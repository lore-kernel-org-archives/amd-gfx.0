From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Sep 20 (amd/display)
Date: Fri, 20 Sep 2019 12:48:56 -0700
Message-ID: <f7328ccb-0561-3917-47d2-5d101400a66a@infradead.org>
References: <20190920163637.GI3822@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190920163637.GI3822@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On 9/20/19 9:36 AM, Mark Brown wrote:
> Hi all,
> 
> News: There will likely be no more -next builds until Stephen returns on
> the 30th, I *may* do some next week but it's more likely that I won't
> and it certainly won't be every day.
> 
> Changes since 20190919:
> 


on i386:

ld: drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.o: in function `dce11_pplib_apply_display_requirements':
dce110_clk_mgr.c:(.text+0x2f0): undefined reference to `__divdi3'
ld: dce110_clk_mgr.c:(.text+0x304): undefined reference to `__divdi3'


-- 
~Randy
