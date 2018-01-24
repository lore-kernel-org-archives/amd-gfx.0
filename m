From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [RFC] Per file OOM badness
Date: Wed, 24 Jan 2018 13:11:09 +0100
Message-ID: <381a868c-78fd-d0d1-029e-a2cf4ab06d37@gmail.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz>
 <20180123152659.GA21817@castle.DHCP.thefacebook.com>
 <20180123153631.GR1526@dhcp22.suse.cz>
 <ccac4870-ced3-f169-17df-2ab5da468bf0@daenzer.net>
 <20180124092847.GI1526@dhcp22.suse.cz>
 <583f328e-ff46-c6a4-8548-064259995766@daenzer.net>
 <20180124110141.GA28465@dhcp22.suse.cz>
 <36b49523-792d-45f9-8617-32b6d9d77418@daenzer.net>
 <20180124115059.GC28465@dhcp22.suse.cz>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124115059.GC28465@dhcp22.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Christian.Koenig@amd.com, linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, Roman Gushchin <guro@fb.com>
List-Id: amd-gfx.lists.freedesktop.org

Am 24.01.2018 um 12:50 schrieb Michal Hocko:
> On Wed 24-01-18 12:23:10, Michel Dänzer wrote:
>> On 2018-01-24 12:01 PM, Michal Hocko wrote:
>>> On Wed 24-01-18 11:27:15, Michel Dänzer wrote:
> [...]
>>>> 2. If the OOM killer kills a process which is sharing BOs with another
>>>> process, this should result in the other process dropping its references
>>>> to the BOs as well, at which point the memory is released.
>>> OK. How exactly are those BOs mapped to the userspace?
>> I'm not sure what you're asking. Userspace mostly uses a GEM handle to
>> refer to a BO. There can also be userspace CPU mappings of the BO's
>> memory, but userspace doesn't need CPU mappings for all BOs and only
>> creates them as needed.
> OK, I guess you have to bear with me some more. This whole stack is a
> complete uknonwn. I am mostly after finding a boundary where you can
> charge the allocated memory to the process so that the oom killer can
> consider it. Is there anything like that? Except for the proposed file
> handle hack?

Not that I knew of.

As I said before we need some kind of callback that a process now starts 
to use a file descriptor, but without anything from that file descriptor 
mapped into the address space.

Regards,
Christian.
