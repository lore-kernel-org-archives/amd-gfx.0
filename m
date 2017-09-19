From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] lib: Closed hash table with low overhead
Date: Mon, 18 Sep 2017 21:33:16 -0400
Message-ID: <1183ff82-8ec0-6ea7-4613-2f0fe5e90bfb@amd.com>
References: <1503971590-15963-1-git-send-email-Felix.Kuehling@amd.com>
 <20170915141456.4382d7ffae7ec8a9a86c8cf9@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170915141456.4382d7ffae7ec8a9a86c8cf9@linux-foundation.org>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On 2017-09-15 05:14 PM, Andrew Morton wrote:
> On Mon, 28 Aug 2017 21:53:10 -0400 Felix Kuehling <Felix.Kuehling@amd.com> wrote:
>
>> This adds a statically sized closed hash table implementation with
>> low memory and CPU overhead. The API is inspired by kfifo.
>>
>> Storing, retrieving and deleting data does not involve any dynamic
>> memory management, which makes it ideal for use in interrupt context.
>> Static memory usage per entry comprises a 32 or 64 bit hash key, two
>> bits for occupancy tracking and the value size stored in the table.
>> No list heads or pointers are needed. Therefore this data structure
>> should be quite cache-friendly, too.
>>
>> It uses linear probing and lazy deletion. During lookups free space
>> is reclaimed and entries relocated to speed up future lookups.
> I haven't looked at the implementation (yet), but I'm wondering if you
> have identified hash table users (or implementations) elsewhere in the
> kernel which might be migrated to use this?  If so, such conversions
> can be used to determine/demonstrate the desirability of the patch.

I haven't looked into this. I did a quick search for where hash tables
are currently used in the kernel tree. But I'm not sufficiently familiar
with the subsystems to easily decide which ones could benefit from my work.

My implementation has some constraints because the hash table is not
resizable (by design). I think it may be useful for some applications in
drivers, where the amount of data in the hash table is limited by HW
constraints. Data stored in the table should also be quite small. For
larger data structures that need to be allocated with kmalloc, you may
as well use hashtable or rhashtable. To see a performance impact, you'd
need very frequent lookups.

For now I've settled on checking the code into the amdgpu driver so I
can make progress. If someone finds another application for it, it can
be moved to lib/ easily.

Regards,
  Felix
