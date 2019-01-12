From: Borislav Petkov <bp@alien8.de>
Subject: radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf
 last fence id 0x00000000017a67a1 on ring 0)
Date: Sat, 12 Jan 2019 21:50:51 +0100
Message-ID: <20190112205051.GA1908@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi guys,

my odyssey with the GPU continues. This time it didn't reset itself
but started spewing a single line about the hardware locking up.

The machine was responsive to sysrq so I was able to write out
/var/log/messages and reboot.

This is still with 4.20-rc7 but I'm building 5.0-rc1 to see if there's a
difference.

Any and all ideas what to do here are greatly appreciated.

Thx.

Jan 12 21:38:16 zn vmunix: [257393.853806] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a0 on ring 0)
Jan 12 21:38:16 zn vmunix: [257394.369780] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a0 on ring 0)
Jan 12 21:38:17 zn vmunix: [257394.877795] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:17 zn vmunix: [257395.389789] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:18 zn vmunix: [257395.901786] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:18 zn vmunix: [257396.413787] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:19 zn vmunix: [257396.925790] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:19 zn vmunix: [257397.437787] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:20 zn vmunix: [257397.949788] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:20 zn vmunix: [257398.461786] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:21 zn vmunix: [257398.973824] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:21 zn vmunix: [257399.485828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:22 zn vmunix: [257399.997842] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:22 zn vmunix: [257400.509852] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:23 zn vmunix: [257401.021845] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:23 zn vmunix: [257401.533826] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:24 zn vmunix: [257402.045822] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:24 zn vmunix: [257402.557826] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:25 zn vmunix: [257403.069833] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:25 zn vmunix: [257403.581826] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:26 zn vmunix: [257404.093828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:26 zn vmunix: [257404.605827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:27 zn vmunix: [257405.117821] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:27 zn vmunix: [257405.629883] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:28 zn vmunix: [257406.141842] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:28 zn vmunix: [257406.653828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:29 zn vmunix: [257407.165827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:29 zn vmunix: [257407.677827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:30 zn vmunix: [257408.189823] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:30 zn vmunix: [257408.701827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:31 zn vmunix: [257409.213827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:32 zn vmunix: [257409.725822] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:32 zn vmunix: [257410.237827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:33 zn vmunix: [257410.749833] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:33 zn vmunix: [257411.261824] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:34 zn vmunix: [257411.773828] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)
Jan 12 21:38:34 zn vmunix: [257412.285827] radeon 0000:1d:00.0: GPU lockup (current fence id 0x00000000017a66bf last fence id 0x00000000017a67a1 on ring 0)


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
