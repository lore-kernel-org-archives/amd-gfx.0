From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 044/167] drm/amdgpu: validate user pitch
 alignment
Date: Tue, 3 Sep 2019 16:01:39 -0400
Message-ID: <20190903200139.GJ5281@sasha-vm>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-44-sashal@kernel.org>
 <7957107d-634f-4771-327e-99fdd5e6474e@daenzer.net>
 <20190903170347.GA24357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903170347.GA24357@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yu Zhao <yuzhao@google.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Sep 03, 2019 at 07:03:47PM +0200, Greg KH wrote:
>On Tue, Sep 03, 2019 at 06:40:43PM +0200, Michel Dänzer wrote:
>> On 2019-09-03 6:23 p.m., Sasha Levin wrote:
>> > From: Yu Zhao <yuzhao@google.com>
>> >
>> > [ Upstream commit 89f23b6efef554766177bf51aa754bce14c3e7da ]
>>
>> Hold your horses!
>>
>> This commit and c4a32b266da7bb702e60381ca0c35eaddbc89a6c had to be
>> reverted, as they caused regressions. See commits
>> 25ec429e86bb790e40387a550f0501d0ac55a47c &
>> 92b0730eaf2d549fdfb10ecc8b71f34b9f472c12 .
>>
>>
>> This isn't bolstering confidence in how these patches are selected...
>
>The patch _itself_ said to be backported to the stable trees from 4.2
>and newer.  Why wouldn't we be confident in doing this?
>
>If the patch doesn't want to be backported, then do not add the cc:
>stable line to it...

This patch was picked because it has a stable tag, which you presumably
saw as your Reviewed-by tag is in the patch. This is why it was
backported; it doesn't take AI to backport patches tagged for stable...

The revert of this patch, however:

 1. Didn't have a stable tag.
 2. Didn't have a "Fixes:" tag.
 3. Didn't have the usual "the reverts commit ..." string added by git
 when one does a revert.

Which is why we still kick patches for review, even though they had a
stable tag, just so people could take a look and confirm we're not
missing anything - like we did here.

I'm not sure what you expected me to do differently here.
