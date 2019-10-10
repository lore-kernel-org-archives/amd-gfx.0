From: Gabriel C <nix.or.die@gmail.com>
Subject: [amdgpu] ASSERT()'s in write_i2c*retimer_setting() functions
Date: Fri, 11 Oct 2019 01:34:08 +0200
Message-ID: <CAEJqkgi-9_1D91GUm_MbS-=RRRwMZjqEYWhCCdk+STvc0PeYXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Zeyu Fan <Zeyu.Fan@amd.com>, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

Hello,

I've built recently a new box with a Ryzen3 2200G APU.

Each time I plug in an HDMI cable ( to a TV or Monitor ),
or boot with HDMI connected a lot ASSERT()'s from
write_i2c*retimer_setting() functions are triggered.

I see the same on a Laptop with a Ryzen7 3750H with
hybrid GPU configuration.

Besides the noise in dmesg and the delay on boot,
everything is working fine. I cannot find anything wrong
or broken.

Since the write errors seem to not be fatal, I think a friendly message
would help more instead of flooding the dmesg with dumps while
everything is working properly.

Why is ASSERT() used there?

I have a dmesg from the Ryzen3 box with drm.debug and a snipped
from the Laptop ( not near me right now ) uploaded there:

https://crazy.dev.frugalware.org/amdgpu/

Please let me know if you need more information,
If needed I can upload a dmesg from the Laptop with drm.debug too.


Best Regards,

Gabriel C
