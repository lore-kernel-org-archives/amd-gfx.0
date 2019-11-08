From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/5] power: avs: smartreflex: Remove superfluous cast in
 debugfs_create_file() call
Date: Fri, 8 Nov 2019 12:37:05 +0100
Message-ID: <20191108113705.GA721212@kroah.com>
References: <20191021145149.31657-1-geert+renesas@glider.be>
 <20191021145149.31657-5-geert+renesas@glider.be>
 <4367615.jSCgeRn5tF@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4367615.jSCgeRn5tF@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David@rox.of.borg, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Casey Leedom <leedom@chelsio.com>, Shannon Nelson <snelson@pensando.io>, Pensando Drivers <drivers@pensando.io>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, linux-
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Nov 08, 2019 at 12:24:42PM +0100, Rafael J. Wysocki wrote:
> On Monday, October 21, 2019 4:51:48 PM CET Geert Uytterhoeven wrote:
> > There is no need to cast a typed pointer to a void pointer when calling
> > a function that accepts the latter.  Remove it, as the cast prevents
> > further compiler checks.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Greg, have you taken this one by any chance?

Nope, it's all yours!  :)
