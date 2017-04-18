From: Dennis Schridde <dennis.schridde-axtXthT+lymYbFdUjOg7S7NAH6kLmebB@public.gmane.org>
Subject: Re: amdgpu 0000:84:00.0: gpu post error! \\ Fatal error during GPU
 init
Date: Tue, 18 Apr 2017 14:27:26 +0200
Message-ID: <16054053.I0I8DtKEcm@c07060>
References: <6570445.DKuzpyIqJk@c07060>
 <BN6PR12MB1652EBEDA7927456A065C8CAF7020@BN6PR12MB1652.namprd12.prod.outlook.com>
 <2718321.4rFqy0DFN7@c07060>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1603198408=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2718321.4rFqy0DFN7@c07060>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1603198408==
Content-Type: multipart/signed; boundary="nextPart5242374.g2rn6WpYVm"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5242374.g2rn6WpYVm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Alex et al.!

On Donnerstag, 13. April 2017 22:16:50 CEST Dennis Schridde wrote:
> On Donnerstag, 13. April 2017 17:30:45 CEST Deucher, Alexander wrote:
> > > [   17.692746] amdgpu 0000:84:00.0: enabling device (0000 -> 0003)
> > > [   17.692940] [drm] initializing kernel modesetting (TONGA
> > > 0x1002:0x6929
> > > 0x1002:0x0334 0x00).
> > > [   17.692963] [drm] register mmio base: 0xD0100000
> > > [   17.692964] [drm] register mmio size: 262144
> > > [   17.692970] [drm] doorbell mmio base: 0xF0000000
> > > [   17.692971] [drm] doorbell mmio size: 2097152
> > > [   17.692980] [drm] probing gen 2 caps for device 10b5:8747 =
> > > 8796103/10e
> > > [   17.692981] [drm] probing mlw for device 10b5:8747 = 8796103
> > > [   17.692992] [drm] VCE enabled in physical mode
> > > [   18.648132] ATOM BIOS: C76301
> > > [   18.651758] [drm] GPU posting now...
> > > [   23.661513] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios
> > > stuck in
> > > loop for more than 5secs aborting
> > > [   23.673155] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios
> > > stuck
> > > executing F250 (len 334, WS 4, PS 0) @ 0xF365
> > > [   23.685453] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios
> > > stuck
> > > executing DB34 (len 324, WS 4, PS 0) @ 0xDC2C
> > > [   23.697816] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios
> > > stuck
> > > executing BCDE (len 254, WS 0, PS 4) @ 0xBDB4
> > > [   23.710137] [drm:amdgpu_connector_add [amdgpu]] *ERROR* atombios
> > > stuck
> > > executing B832 (len 143, WS 0, PS 8) @ 0xB8A9
> > > [   23.722451] amdgpu 0000:84:00.0: gpu post error!
> > > [   23.727950] amdgpu 0000:84:00.0: Fatal error during GPU init
> > 
> > Posting the GPU is failing.  The is the initial basic asic setup that is
> > required before anything else can happen.  There seem to be timeouts
> > waiting for some register states.  Is there anything special about your
> > setup?  Can you try a vanilla kernel?
> 
> I don't think there is anything special. At least not that I am aware of.
> Dell R730xd with one AMD FirePro S7150X2 and 2 Mellanox ConnectX-4 Dual
> Port cards. Apart from the modifications shown in the commit log, I made no
> changes to the CoreOS Container Linux 1381 development version. The kernel
> is now unpatched, stock 4.10.9. Please find the logs of the unpatched /
> vanilla kernel attached.

Is this information enough / what you had in mind? How can I aid in debugging 
this further? Are there some command line flags I shall pass to the kernel or 
configuration flags I shall set?

--Dennis
--nextPart5242374.g2rn6WpYVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQG0BAABCAAGBQJY9gYuAAoJENS5dBsVnRQdB4UMwINxrww12meSU4u6FLJ+rMqf
Nsm5Zp8crYNTHcmd91Xxds+PLSr9Eq7H9pcSE8QtowY+Xs1p3wVBKgQklaAn0uf8
UudnWLk5MfL+LHy4x1db0jlddPpfRhCTCBGA97W6VMCZdlGew69hLoRutqwMihJA
tmGT4FkXW6PJRFvw7kVxHCbjG++1EplvBvtIaWtXTHjQ1mPPsvdjp7DTWJ+T+KkW
L2firoo/XI9XIJwHe6fseoANBy0GTITWYhqSOgNJljRA4IDAeb9cq1MdbE87WyUL
cI8RIrakErS73Zz6KbY/YdBJKaKwf2LnVkn4kImYgKivyxbhykYUxrC2g7zMqyF6
grvVONK2HzfZsQODlG91nP1HqQG+K2qjuTjNA5ikhUlwR/WBolKcSDNahBYauGUM
tyl18Wn5hPwGpx5QATwe8hwTf/FpmT9EnXrGrVxcmocp+BocjtIgGdWy79w3R6hq
yuBsutyfdwslH3pw2pOjxNWQDYoOpEiY10YgBo0Ru2j6BWZQO+uwONjDX1x7Jg1e
ZSwXaXvm4g==
=hUBf
-----END PGP SIGNATURE-----

--nextPart5242374.g2rn6WpYVm--


--===============1603198408==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1603198408==--
