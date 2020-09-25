Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BABC4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D6D208A9
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RgbvRFm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D6D208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592E26ECEA;
	Fri, 25 Sep 2020 14:26:26 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D98B6ECEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDsoQV/NYLzo1i0HcbBHWn8S2cJkaUq1alPfAL0EuaLyDsNDwpEDRfA6Bj56NzHC/uL0AqFpLi53OHzsYTxDeScHg+lx0f+SRvSSfF18qOukJW7GxSHInfbCxuCQl6ahU+qJrJF3pW2BuKeg+lrSs+V+7U0P6UnZKmSni4tfTacgJSjyJPPP8McHtuWIkc+dbBptrEUvtdBJBhzXKkydPQlZ7/72WNU9x9+nNoPCrBt+vopBkew9d7OOUOOfN0ZM7/fe7uAu9h9gg/053fsm5xBGUqojP5PX3FIG2W0/Y5eNRmTNK8lB9L8fZSISgtfSOxfr7nI3pSJIYkwhdJoTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpKq0LjdyvQykPA+uqaL/lIL/lKpTKKg/PP7nt0OULo=;
 b=jLUc4aJy/JoJNEN4YZXu/+rEsLwHYfF1Vp9bMSAqbDNB51pfBMq151yKyquSytodkz842UnDyt7EXx5VR3KWELTa0wUr6lr1zE12hhVEDzWJ0l3eThsTPameJKHKRSw4CVW8pk9FY4uDqkoU4+S1lK1xlv7HbIFqRO+9MdP3w5WY2f7ITWGrs0yltd3/jgjMkAxoXD44YROfq9DlmNVPUxff3UqdjE7Eu+ajUHHUD7itSCmoSJfCMsBIJOpAlBRX4KSzFyaLQvrtFjJqXw7zeeqTfc+ZywITd/UBPMh8Gw8dQ0RcBftJLA5zh4vUQLCc6MFGv+dnrNNWxZPnsJwFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpKq0LjdyvQykPA+uqaL/lIL/lKpTKKg/PP7nt0OULo=;
 b=RgbvRFm6y5z84JYr3zsNSWKvNn+ErXodzMs6U1xxEOH2p5qS5gZPqZnoxd5OQgwpMiGq0s0PBEmi5v+CwKgaDQ0vmDU9gthYrB9BdGnc8FazHgu+nX8wcOLK185PJtRZwtCzVjszrkK92aw5rpjBtfZ1Xx3WMGpROsPP1lhedkk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:26:14 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:26:14 +0000
Date: Fri, 25 Sep 2020 10:26:09 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/virt: fix the build
Message-ID: <20200925142609.p6djrb6swzkdphuc@outlook.office365.com>
References: <20200924193139.1550564-1-alexander.deucher@amd.com>
In-Reply-To: <20200924193139.1550564-1-alexander.deucher@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::44) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::980e) by
 YTOPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Fri, 25 Sep 2020 14:26:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 933331d4-7a83-40f9-30e3-08d8615ef4de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB48626D645F5C19FF670C593898360@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnbmhhbYXOk26dQ2Fwf6QY7uMYk1XYLEhkct3y0IaT2jozdinAbp0InqsE0fxbs2RUMvdhOWRN43ERC3gI+cXCuRrCOTf46WZGfmyiLsI3U1UQClGlkHFJUumaneuGqPEyFYN11YEsEKEO+jRUyL5V7uRp4MglL8aT9UDp+SZBklA+lcIPuhPNwQ4e3q5kw0Qq/oAd8GNLHmE4xBOnJBaTOVb2SB5kwVwLhOV/VQ/hKlUzhwfgkfWDNeir7kFE9Jmb7bJwezNWb0Fe92W8r7Vjrb7OZCh0RmxUbj2MYSGbqFnut2EBByYiB9B94hDrN8LfxlfV8jSv49kxHS4ESNu8w1CmQFYcACIuc00i7lZCZJpTerjyKUlNFp5fPTTfe6/LE5mrisOsInpYx51kqxuVgSDKsrKYjDyMJlTwPtnKdaUDOx5iVGoPxgFb5FIsC/HxnjK8GPwPOdx8Zky409MSnnpoBJGb7l1MTRmqJ5LftZc11p4xXRASiJ8a1k+Fy5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(966005)(66946007)(83380400001)(21480400003)(86362001)(55016002)(66476007)(66556008)(16526019)(478600001)(45080400002)(186003)(1076003)(5660300002)(33964004)(6916009)(9686003)(6506007)(52116002)(7696005)(4326008)(44144004)(2906002)(6666004)(8936002)(316002)(8676002)(54906003)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FpeHljSIqr5X9qoBBQGoaSPnULGMe2jIFBju6Ol+AhgY8amBuditIy1czKX8DbqK0Ksfct20M79eFFZhQjHbe66MELquluSopVDplnNYU6bV4s93lInCIn27WvVRdafBFLJdH6Us/VBrd+bY2FZMBF3QPO7PqmqCY9qbnMwlZ5oHEBCvKzpxm1tEDbI+kId7lpvOFVORGiCQs3WefMMXbrUTEEKBToGQzwcIv4UlzuTuxwzJp8Ld7tW1T1EeSNVHscwWsJHdS1yKk374g3TgjKXtddg5QmrtNDKD5Ic5tlJTqirDmabkJgd+c8Z8D9ZglbwxbJzcgF9K8oqdUGVouoW9D2+3U7lkwQLyz+SxLUW5ih6VAmRVFdkGFMtW+P6T3OCArNz5Xm34Zk7bmeG6ZhSv37bTTZ8FP88UXZlUKAShQepa3AsycmbGSi9hDeGQEY4WvJPIhjSuu2llbnHA3Sos7PqPnk8NvUnienm6RmBpq7TbB1OuMDNs4UPxTd5aYfkLTooZA90VFvubAg5gP7sl3jg0GgzQhiyPhU484RKTTLWEFCYdNKA4gbms0uvFxTtNEaS62r6k6uVQ0fNm3V87L3NLdsCQPGATFFJ5kUZ9ASoomhqasiZtc9DHiVQwdTWZUZYJ479M0u1h+reXN8hsG9AvrxWcXamrqD445uht/YDWNq+CXYDsH2zZxKCa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933331d4-7a83-40f9-30e3-08d8615ef4de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:26:13.9999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j19K6iHePVU5u9jfMZM/xx0Idz0OnrhvbhF2FPsXztRTfsKUX2sS/hqQB+WxNE483ABjvH280tt6R1EEYvgVWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Bokun Zhang <Bokun.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0205850999=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0205850999==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="frugkrpizzoa2x4y"
Content-Disposition: inline

--frugkrpizzoa2x4y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Tested-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 09/24, Alex Deucher wrote:
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: In function =E2=80=98amdgpu_vir=
t_init_data_exchange=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:586:10: error: =E2=80=98struct a=
mdgpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
>   586 |  if (adev->fw_vram_usage.va !=3D NULL) {
>       |          ^~
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:591:9: error: =E2=80=98struct am=
dgpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
>   591 |    (adev->fw_vram_usage.va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10=
));
>       |         ^~
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:594:9: error: =E2=80=98struct am=
dgpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
>   594 |    (adev->fw_vram_usage.va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10=
));
>       |         ^~
> make[4]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/amdg=
pu_virt.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:500: drivers/gpu/drm/amd/amdgpu] Err=
or 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [scripts/Makefile.build:500: drivers/gpu/drm] Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers/gpu] Error 2
> make: *** [Makefile:1788: drivers] Error 2
>=20
> Cc: Bokun Zhang <Bokun.Zhang@amd.com>
> Fixes: 614e7ac92979 ("drm/amdgpu: Implement new guest side VF2PF message =
transaction")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 1f1171812e35..836d784456e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -583,15 +583,15 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_d=
evice *adev)
>  	adev->virt.fw_reserve.p_vf2pf =3D NULL;
>  	adev->virt.vf2pf_update_interval_ms =3D 0;
> =20
> -	if (adev->fw_vram_usage.va !=3D NULL) {
> +	if (adev->mman.fw_vram_usage_va !=3D NULL) {
>  		adev->virt.vf2pf_update_interval_ms =3D 2000;
> =20
>  		adev->virt.fw_reserve.p_pf2vf =3D
>  			(struct amd_sriov_msg_pf2vf_info_header *)
> -			(adev->fw_vram_usage.va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
>  		adev->virt.fw_reserve.p_vf2pf =3D
>  			(struct amd_sriov_msg_vf2pf_info_header *)
> -			(adev->fw_vram_usage.va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> =20
>  		amdgpu_virt_read_pf2vf_data(adev);
>  		amdgpu_virt_write_vf2pf_data(adev);
> --=20
> 2.25.4
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cbcba7e21b9534a8bb13408d860c07c74%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637365727154441762&amp;sdata=3DfGOxmxirhlyBxsAF=
ZT0V52wYstMsZUI11aXgzg6O2%2Fs%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--frugkrpizzoa2x4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9t/fwACgkQWJzP/com
vP+M2w/9GfGbKHRaPl/5r44pu1jk4n5J24tV1mTBjfi3SEcEJw87iQUqgmIGQ9u1
yFFHSRN2pum07bwx4al9BB7eycBg1MolX5HAhP5ZXQCNK9VZEP/7EL+UiBLrG7Yl
snijw6gX0XJcNDDtxv0IpJja/l5U09V68qE28FpOsPowaL35X5WQ5oUdXUC3lkp1
j9XHC+NDmw/TnZk9wizCd7GxWeNODfGGDQkaA85aHyq+Egmp5W6dfED8Qxdr7gaV
uFOdjOA5abWujQ//HHfEU52mJPxx1OF+ENOCi/BT7p/Tfip5tlwE1ZxkYD8bRShu
0cDV9u9UAsDnB3wtlbI/Py7AQXo/7hXY0dTjo4d/Wv2EHxDJ2Ak6EwIVE+SGfN0H
4oW/Ykw96LHvTLpaZkOD9RN63nS9Uth9drSctOkW38dvm6LJrOGFZKxmGpSyEun0
3k5QWA4gApuGCAv5ZcBlZOC0Iyl8Xua93Ic52ylkV4PTHohg6YS5nSoaLyw5KOie
8jAEzDP4DtnmNaNdcOk0HpwE4+nEPFDjvYzuQIxPFVB0a2IVx/lpTPJ6BiLJs9Xu
WRJzH80SAAo1VxIlosjxfKltv+f2T/2r/bv7AU+30yPAOBpB03GAi05rOpaXPwcf
g/0HPctt8maA4guEtcFyJMvfGArqU9cbSiMkGMD0PGG3VetICDU=
=nzJ+
-----END PGP SIGNATURE-----

--frugkrpizzoa2x4y--

--===============0205850999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0205850999==--
