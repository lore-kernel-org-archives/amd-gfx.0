Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15A0E77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 07:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660EB10E027;
	Thu, 19 Dec 2024 07:39:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kolabnow.com header.i=@kolabnow.com header.b="S9+kjcNT";
	dkim-atps=neutral
X-Greylist: delayed 371 seconds by postgrey-1.36 at gabe;
 Thu, 19 Dec 2024 07:39:25 UTC
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C3010E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 07:39:25 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mx.kolabnow.com (Postfix) with ESMTP id A0F973070C70
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 08:33:12 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis);
 dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from
 :received:received:received; s=dkim20240523; t=1734593591; x=
 1736407992; bh=p1zyix0dJtb7v2RT+fcQVrs3GB6yGCoMN3rPr4i40LA=; b=S
 9+kjcNTZllT+BwgEx8lSu3HLN26iihBGPiGvMbu/Ozgb8GNuW0bg5P0+N590pfRH
 XkxEtSDefmWwuTlVKOyyh6GFFWZqUcIQVi3E9YpHEWipGxDbjbEmKtqlOkt8xedo
 XJXRpWx4CEjQvJbgWXrvvlAbNevCIYMWMHZREnYM4FKMmhJj+QdHPGLMcZQJ8oXv
 UyRZLdEdvEQTWaTcrxLAhreALeA/1G55ZhDlnDyHyCGXU4MZpQM9DXpuuUsuSo/V
 EBP7UAzkyC6yKpEFB9NtVtqospCasigRBXOPR5Ui+59eUcfnBZa4f9V07pH+RSLY
 vdA12poQyhb70GQiKzggQ==
X-Virus-Scanned: amavis at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 94JhJJtfvQcD for <amd-gfx@lists.freedesktop.org>;
 Thu, 19 Dec 2024 08:33:11 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
 by mx.kolabnow.com (Postfix) with ESMTPS id B1BE83069ABD
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 08:33:10 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
 by int-mx011.mykolab.com (Postfix) with ESMTPS id D7CA0306BFBC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 08:33:10 +0100 (CET)
From: Jure Repinc <jlp@holodeck1.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Handle NULL bo->tbo.resource (again) in
 amdgpu_vm_bo_update
Date: Thu, 19 Dec 2024 01:25:15 +0100
Message-ID: <4917513.OV4Wx5bFTl@excalibur>
Organization: Holodeck 1
In-Reply-To: <20241217172256.3668-1-michel@daenzer.net>
References: <20241217172256.3668-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26689383.1r3eYUQgxm";
 micalg="sha256"; protocol="application/pkcs7-signature"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--nextPart26689383.1r3eYUQgxm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>=20
> Third time's the charm, I hope?
>=20
> Fixes: d3116756a710 ("drm/ttm: rename bo->mem and make it a pointer")
> Issue: https://gitlab.freedesktop.org/drm/amd/-/issues/3837
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> ---
>=20
> Or should amdgpu_vm_bo_evicted be called in the !bo->tbo.resource case
> as well?
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index ddd7f05e4db9..c9c48b782ec1
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1266,10 +1266,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
> struct amdgpu_bo_va *bo_va, * next command submission.
>  	 */
>  	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> -		uint32_t mem_type =3D bo->tbo.resource->mem_type;
> -
> -		if (!(bo->preferred_domains &
> -		      amdgpu_mem_type_to_domain(mem_type)))
> +		if (bo->tbo.resource &&
> +		    !(bo->preferred_domains &
> +		      amdgpu_mem_type_to_domain(bo->tbo.resource-
>mem_type)))
>  			amdgpu_vm_bo_evicted(&bo_va->base);
>  		else
>  			amdgpu_vm_bo_idle(&bo_va->base);

Hi

I reported the issue and just replying to confirm the fix works for me. I=20
applied the patch to the openSUSE kernel sources of the same kernel version=
=20
that I got the original bug with and tested again with this patch and now a=
ll=20
applications works fine.

Thanks!

=2D-=20
         Jabber/XMPP: JLP@jabber.org
              Matrix: @jlp:matrix.org
Mastodon/ActivityPub: @JRepin@mstdn.io

--nextPart26689383.1r3eYUQgxm
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIP3gYJKoZIhvcNAQcCoIIPzzCCD8sCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg1qMIIGdTCCBN2gAwIBAgIMKMOYHQAAAABXHdDnMA0GCSqGSIb3DQEBCwUAMFwxCzAJBgNVBAYT
AlNJMRwwGgYDVQQKExNSZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5WQVRTSS0xNzY1OTk1
NzEWMBQGA1UEAxMNU0ktVFJVU1QgUm9vdDAeFw0xNjA1MjQxMTQ5NDFaFw0zNjA0MjMyMjAwMDBa
MFoxCzAJBgNVBAYTAlNJMRwwGgYDVQQKExNSZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5W
QVRTSS0xNzY1OTk1NzEUMBIGA1UEAxMLU0lHRU4tQ0EgRzIwggGiMA0GCSqGSIb3DQEBAQUAA4IB
jwAwggGKAoIBgQDRJl0dqc7nAg7Bi5WGSvyYlSuJq1N/3IqHKoA4JK2iB46GMBSc/akw2EMOigD1
9Uce9jNnKi3cZpDMQglTi3MlAX3pv8wajmMBMfQ2P5ID2F3VkcZVKWlPUAnWjzr+3SW3neGqMN+/
3jixXPuyB45BGhW1kjqZ5i8DIwppQuF3dUYAkyESdGCwtqYAWn1d1vATzdRs7fn5uKNCGqbMcYaL
7hhC5Z0j+hnfKuZKRtzSH9xM07+xXKIoF8gvYEfWB/lkcIdVEUBANSa8TefuhVoClTapLH/zjZBV
tHt4xBMbc+6go8KD/p7J+V9+uH3QCgzM3RdIIgl13TJUtMWAByzmkq74UFM0CsOTlVvpfUzqEUUY
Zi0PYtg6/fDzg1k2dtqOEeQonQVBtPot0bP643D0zDS/kk0+V4zeQjhhVawBAvwTsOXOx9MRzyt8
5mnlMMN4Vdqk2vJd2C+uADBknlFXv5CM2CmtAbOXH4OeS0qICTqqWw8uh6T+DVl4eommyY8CAwEA
AaOCAjcwggIzMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEw
LwYEVR0gADAnMCUGCCsGAQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUF
BwEBBF0wWzA2BggrBgEFBQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJv
b3QuY3J0MCEGCCsGAQUFBzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwEQYDVR0OBAoECEwlJ4yo
LXKeMIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9z
aS10cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qs
b3JnYW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zl
bmlqYSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJT
STEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcx
FjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4I
AmMwDQYJKoZIhvcNAQELBQADggGBADVgVyRt64166Ry1oNxqii/zIzrKEr24IPkI7vJmczGJ/lRm
6vIaZBdxeuebD1KICR8YQznI0xRiQZ/cz2oINJdVqCqXlOddRZvufWIcZXpmDPlig86+gueYtJIR
Lq+gk4Fjz8tdPo6GhYN7b9wQ15FYDIjgPzEDnq/YQJ+ZJs9aPotskKHvKyaDg8NibS7qdiLXaToo
WFCaSV4h+JPtStbw+R7MaLnHvyp8sqhl4vgnPNv3TLwPmWr1jU+EP1gx5axEkKpJamc1zMgTWw/F
S4VzrxSKsDZM/7E6cCZHCWziPWs8C3uLqye2tBBBCgjmyNY5XC8rj85Rbpl5K1SIlg9jetEfUNoa
WXP0S/GgAtgB5EQ9IXwSjf9D/DxqvOme5bhK7o2l3r/1/OvPmoYttgQhBmpIYQfzacB94yTHDCJZ
rWqFc+DW4BOg/dyLLsykcNEnYWClibUWiU/ITlW/AcKkuovMQVMAHYu4u5LveEWEymkbaTxRmHx3
/swn3eZi2jCCBu0wggVVoAMCAQICDBSL7r4AAAAAVyU92jANBgkqhkiG9w0BAQsFADBaMQswCQYD
VQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2
NTk5NTcxFDASBgNVBAMTC1NJR0VOLUNBIEcyMB4XDTIwMTAwNjE2MzMwMFoXDTI1MTAwNjE3MDMw
MFowfzELMAkGA1UEBhMCU0kxEjAQBgNVBAgTCVNsb3ZlbmlqYTEUMBIGA1UECxMLaW5kaXZpZHVh
bHMxRjALBgNVBCoTBEp1cmUwDQYDVQQEEwZSZXBpbmMwEgYDVQQDEwtKdXJlIFJlcGluYzAUBgNV
BAUTDTI0NjY0NzgzMTIwMzkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCu1oYnY4M9
ZB4zQrL+Ynjuc1zIYxmHZNwqgv38oz5QzIdJIyg0XRgaOrFcevE30AZMrSwYsVD689pEnQgqrkbA
JqExEBi3TtmsH4N5czwtIDiP2MYp9lkrNV/+/ND8hUUVz1i4LkFt8k8PHujuPrLgY/zmsS6Sz07I
G05lf/gxlkPMKn8oOKwiCAny4qUYEEZeQG6B2gjkayXn11Uz4DVEIpUd76BaQAYgmC1kicmJXWYm
CqKjQDMlXekvNhpFgmse3jnAlunPfoBtWM3OjSra7EJGSrWIkL1aHcXc8wMhwT2n9IsEuTitZOKw
S17bOKEqWzQ/fXGgTyt8BSSMB6H3AgMBAAGjggMMMIIDCDAOBgNVHQ8BAf8EBAMCBeAwTAYDVR0g
BEUwQzA2BgsrBgEEAa9ZAgIDBTAnMCUGCCsGAQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9j
cHMvMAkGBwQAi+xAAQAwgaUGCCsGAQUFBwEDBIGYMIGVMAgGBgQAjkYBATB0BgYEAI5GAQUwajAz
Fi1odHRwczovL3d3dy5jYS5nb3Yuc2kvY3BzL3NpZ2VuY2EyX3Bkc19lbi5wZGYTAmVuMDMWLWh0
dHBzOi8vd3d3LmNhLmdvdi5zaS9jcHMvc2lnZW5jYTJfcGRzX3NsLnBkZhMCc2wwEwYGBACORgEG
MAkGBwQAjkYBBgEwcQYIKwYBBQUHAQEEZTBjMDwGCCsGAQUFBzAChjBodHRwOi8vd3d3LnNpZ2Vu
LWNhLnNpL2NydC9zaWdlbi1jYS1nMi1jZXJ0cy5wN2MwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3Nw
LnNpZ2VuLWNhLnNpMBwGA1UdEQQVMBOBEWpscEBob2xvZGVjazEuY29tMIIBOgYDVR0fBIIBMTCC
AS0wgbWggbKgga+GKmh0dHA6Ly93d3cuc2lnZW4tY2Euc2kvY3JsL3NpZ2VuLWNhLWcyLmNybIaB
gGxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSUdFTi1DQSUyMEcyLG9yZ2FuaXphdGlvbklkZW50aWZp
ZXI9VkFUU0ktMTc2NTk5NTcsbz1SZXB1Ymxpa2ElMjBTbG92ZW5pamEsYz1TST9jZXJ0aWZpY2F0
ZVJldm9jYXRpb25MaXN0MHOgcaBvpG0wazELMAkGA1UEBhMCU0kxHDAaBgNVBAoTE1JlcHVibGlr
YSBTbG92ZW5pamExFzAVBgNVBGETDlZBVFNJLTE3NjU5OTU3MRQwEgYDVQQDEwtTSUdFTi1DQSBH
MjEPMA0GA1UEAxMGQ1JMMzM1MBMGA1UdIwQMMAqACEwlJ4yoLXKeMBEGA1UdDgQKBAhBsPrpktbp
jTAJBgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBgQB7FJBhacs9mzlIcERXuoNW+MjDa9dEflGl
cfDWQsZSmuuu8k11KGfoQtqB6a/CT7mYf54abpcWMjQ3H9y0gwft/ZX5sHQsZV/qGyh+2KjE+gwA
XXZ2R5lIAYDkZQBBU88dE6XzR3ibgpQ6O7wmGBN6dmIwLK1LMpOtEwHQqw/WWB6gRS+mpPnZhk9Z
6i4WVRHf5Gs/Xl3vUtV2V5VziGTc4evMh49+VG4oNG9EyF110JSAdAIbZ/F+Jz49UlzGrau6dh3H
pS/tBk0m+nTdHurklnCobrPsE9viAdUVjIQ5vfN5SXTxBSDH5Ag/8OSEfPoJBykgGYkNST52HvXT
M6WZqx9JSwA/tQrJpFrpDORgwyVRRgxgR7z7Dx38TViV7HeuqLVEJTtRIk8c6/Z2CYOlmSsUNNLw
q72j2Wv2zXSzWS2aD7cMR5v8jPzatYf4TYVOdxygrGOEBHYoElWk7ixXHyheYEqix5CFBYA7PuQm
CdDquv2oAC7tTM5m/uoS1N4xggI4MIICNAIBATBqMFoxCzAJBgNVBAYTAlNJMRwwGgYDVQQKExNS
ZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5WQVRTSS0xNzY1OTk1NzEUMBIGA1UEAxMLU0lH
RU4tQ0EgRzICDBSL7r4AAAAAVyU92jANBglghkgBZQMEAgEFAKCBoDAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNDEyMTkwMDI1MTVaMC8GCSqGSIb3DQEJBDEiBCBK
v8r/WbCZh1yzsIjFi2AKgX+zzZVEoG7y+4Vdku0NfTA1BgkqhkiG9w0BCQ8xKDAmMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEBBQAEggEAmhKlSAjxjfM6
yjmTcZ/WD8Uml9e0XpyDhLyzxBjG45P6tHwdXAzh5YO0eW8BTcOQzV0BIqphxzqFAon5kEmTPTId
DUsaZqVYffxDVmfQT7a2FjetAUVMa5MbhMLbWpcsETls31re3jDoj7Je53MuWgVbh8q3nKIzd7wn
HdH1y9Ntt3yHXk3qtpRraAr7KlL9+ZRMiZxGY+Tfwf99iCFnAIgtN55A1VjsjYRjiA7VzGRT1bbz
urPvhqcXAEanvIEqDHVvVyMj7PV8mec/AUUE3Rk+0KPCq6xEB9oAiOVJcsbDIMAMDwx0wlCTAqEF
xmTAHFPRZfQFzzO1H724kA0wWA==


--nextPart26689383.1r3eYUQgxm--



