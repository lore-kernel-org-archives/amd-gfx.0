From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib: Closed hash table with low overhead
Date: Fri, 15 Sep 2017 14:14:56 -0700
Message-ID: <20170915141456.4382d7ffae7ec8a9a86c8cf9@linux-foundation.org>
References: <1503971590-15963-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503971590-15963-1-git-send-email-Felix.Kuehling@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 28 Aug 2017 21:53:10 -0400 Felix Kuehling <Felix.Kuehling@amd.com> wrote:

> This adds a statically sized closed hash table implementation with
> low memory and CPU overhead. The API is inspired by kfifo.
> 
> Storing, retrieving and deleting data does not involve any dynamic
> memory management, which makes it ideal for use in interrupt context.
> Static memory usage per entry comprises a 32 or 64 bit hash key, two
> bits for occupancy tracking and the value size stored in the table.
> No list heads or pointers are needed. Therefore this data structure
> should be quite cache-friendly, too.
> 
> It uses linear probing and lazy deletion. During lookups free space
> is reclaimed and entries relocated to speed up future lookups.

I haven't looked at the implementation (yet), but I'm wondering if you
have identified hash table users (or implementations) elsewhere in the
kernel which might be migrated to use this?  If so, such conversions
can be used to determine/demonstrate the desirability of the patch.
