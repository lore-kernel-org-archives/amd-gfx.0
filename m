From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH] Cleanup: replace prefered with preferred
Date: Wed, 23 Oct 2019 08:40:59 -0700
Message-ID: <fa12cb96-7a93-bf85-214d-a7bfaf8b8b0a@android.com>
References: <20191022214208.211448-1-salyzyn@android.com>
 <20191023115637.GA23733@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023115637.GA23733@linux.intel.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Thomas Hellstrom <thellstrom@vmware.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Alexander
List-Id: amd-gfx.lists.freedesktop.org

On 10/23/19 4:56 AM, Jarkko Sakkinen wrote:
> On Tue, Oct 22, 2019 at 02:41:45PM -0700, Mark Salyzyn wrote:
>> Replace all occurrences of prefered with preferred to make future
>> checkpatch.pl's happy.  A few places the incorrect spelling is
>> matched with the correct spelling to preserve existing user space API.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> I'd fix such things when the code is otherwise change and scope this
> patch only to Documentation/. There is no pragmatic benefit of doing
> this for the code.
>
> /Jarkko

The pragmatic benefit comes with the use of an ABI/API checker (which is 
a 'distro' thing, not a top of tree kernel thing) produces its map which 
is typically required to be co-located in the same tree as the kernel 
repository. Quite a few ABI/API update checkins result in a 
checkpatch.pl complaint about the misspelled elements being 
(re-)recorded due to proximity. We have a separate task to improve how 
it is tracked in Android to reduce milepost marker changes that result 
in sweeping changes to the database which would reduce the occurrences.

I will split this between pure and inert documentation/comments for now, 
with a followup later for the code portion which understandably is more 
controversial.

Cleanup is the least appreciated part of kernel maintenance ;-}.

Sincerely -- Mark Salyzyn
