From: Borislav Petkov <bp@alien8.de>
Subject: Re: radeon 0000:1d:00.0: GPU lockup (current fence id
 0x00000000010da43f last fence id 0x00000000010da52d on ring 0)
Date: Wed, 6 Jun 2018 11:52:02 +0200
Message-ID: <20180606095201.GA10840@zn.tnic>
References: <20180605144404.GA7389@zn.tnic>
 <7921bc34-6e63-7869-0695-70baf9d480a1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7921bc34-6e63-7869-0695-70baf9d480a1@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jun 06, 2018 at 10:26:15AM +0200, Christian König wrote:
> Well what did you do to trigger the lockup? Looks like an application send
> something to the hardware to crash the GFX block.

So what I observed was (in that order): machine was building a kernel so
was busy, X didn't respond for a couple of seconds (which it should not
do) and I switched to tty8 to see what dmesg says (I am routing dmesg to
tty8).

At that moment it showed the lockup splat and then X restarted showing
me the login prompt again. I'm guessing the X restart was caused by the
GPU reset.

So if I had to guess, maybe pressing Ctrl+Alt+F8 caused the modeset
change and thus reset? Hmm, this is just me guessing with my
non-knowledge about graphics. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
