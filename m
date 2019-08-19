From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Aug 19 (gpu/drm/amd/display/)
Date: Mon, 19 Aug 2019 14:53:43 -0700
Message-ID: <3557b61e-bca8-1410-ff71-b7383b255c72@infradead.org>
References: <20190819191832.03f1a579@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190819191832.03f1a579@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On 8/19/19 2:18 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190816:
> 


on i386:

ld: drivers/gpu/drm/amd/display/dc/core/dc_link.o: in function `wait_for_alt_mode':
dc_link.c:(.text+0x1f38): undefined reference to `__udivdi3'
ld: dc_link.c:(.text+0x1f71): undefined reference to `__udivdi3'


-- 
~Randy
