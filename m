From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdkfd: Fix missing break in switch statement
Date: Mon, 22 Jul 2019 14:47:21 -0500
Message-ID: <f9b47ccc-d8e8-e03b-dc0c-6c8f1fd36477@embeddedor.com>
References: <20190721214935.GA910@embeddedor>
 <CADnq5_OTmx==m+1fJbf1PxPhPM0H0O8GRjq4eWeX6sw889YPrA@mail.gmail.com>
 <181c1bc9-4cf9-057f-a6e6-e6d62ddbc347@embeddedor.com>
 <CADnq5_NRDy1jpa2MGefo7KbUB2vejuLwpnJh=vsqyp56yY31Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_NRDy1jpa2MGefo7KbUB2vejuLwpnJh=vsqyp56yY31Sg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Philip Cox <Philip.Cox@amd.com>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@chromium.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org



On 7/22/19 2:45 PM, Alex Deucher wrote:

>>
>> By the way, Alex, I'm planning to add these fixes to my tree. I want
>> to send a pull-request to Linus for v5.3-rc2 this afternoon. We want
>> to have the -Wimplicit-fallthrough option globally enabled in v5.3,
>> and these are some of the last fall-through warnings remaining in
>> the kernel.
>>
>> Can I have your Ack or Signed-off-by for all these drm patches?
> 
> I didn't realize you were sending these yourself. I was going to
> include them in my upcoming -fixes pull.  Feel free to add my RB to
> all three.
> 

Awesome! :)

Thanks
--
Gustavo
