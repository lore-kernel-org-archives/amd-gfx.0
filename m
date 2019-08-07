From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: replace readq/writeq with atomic64 operations
Date: Wed, 7 Aug 2019 13:59:28 +0100
Message-ID: <20190807125928.GC4048@sirena.co.uk>
References: <20190807025640.682-1-tao.zhou1@amd.com>
 <20190807070834.GA24792@infradead.org>
 <daff9fc7-ead8-40e0-9a16-cb3b90b01722@amd.com>
 <20190807104104.GA18773@infradead.org>
 <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4979270053985998137=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <18cd9fa5-2d87-2f41-b5fa-927b9790287d@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "kernel-build-reports@lists.linaro.org" <kernel-build-reports@lists.linaro.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org


--===============4979270053985998137==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2019 at 10:55:01AM +0000, Koenig, Christian wrote:
> Am 07.08.19 um 12:41 schrieb Christoph Hellwig:

> > writeq/readq are provided whenever the CPU actually supports 64-bit
> > atomic loads and stores.

> Is there a config option which we can make the driver depend on?

64BIT should do the trick.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Kyy8ACgkQJNaLcl1U
h9CSUAf/bUrGApOJ4TloFKZSBONMJdqKqen4pcxRQYHBdRMyb9jNWyeJTqP+Wj0g
aQ7WrZb9af6U1NxFXjpCokpLd5UjEslDiLT2PCo2BR2TMgxFqLE9QTw+HdMNMoPX
lxWI6uQYnj6xQu3tmPJ870gFcKKjFkCE7Q2NH1FNjSRxg9ApAAb333sFf2viaBEo
1YgDTlRCGBxejDRhW0fR8GwJUU/CSF77zV2HFGJtBGhhBfeZ72mp8gmfOtX0AUaj
cPWaZOHrOhZN89rRC65g1NagTRK6kB5Sr+rhBcQj/b2R5Rmynj414ZjO0l2ENmlq
MfX/UcsY6twsldvz7Sng1BUk9WsUxg==
=TBn7
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--


--===============4979270053985998137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4979270053985998137==--
