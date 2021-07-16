Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD7BC07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 13:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DE1613D3
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 13:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DE1613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046F86E98B;
	Fri, 16 Jul 2021 13:57:10 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8716E98B
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 13:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARaPdcpus5SJ7wNu1BGHSe2PiHX2yLp68CtbYl+0lYdAaKjpYDhdg0Iq7Z915kpU/TXydgi04xmmkNa5cJ1weq3RNa3nOKTsomAZSKYuUEfGo9P8W9uRULoNNoblJdyJnydt5VR19AoGBKxAsxMakEMiseT/DoBEK/uDR+zkoS85epgWJ0HXCxyhTIa4DYdPau8ENMs5i0jO/Vgz1mEgD2RZM5qwf2oMnEpuVSiIac4q9Kn6oelv9WzN7uzBMJ740NMog4c4xXMnBDLU5giimzIhGOqhzEYDsaQjeelw1CRHAScVn0P/zmRZxyfLlYlZl63nSlIJjMpg+Hb0lwepaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3RgJqyiL3WgPnRIHJnpGukG4t6uWXlUoJAiGWndv2g=;
 b=c48PMMLV8WPpny6fnA7E8cDT0oypzPtTtbJUgdKFITzdXhWvOFwRPoJSBh58M//65GQTjzpx5IfTTcC09LYSbWJ9lhf8Hqzgcmb0zvDJhFtUe+I9h05OPoUTGLp4Wx4PAOEuRNSv6+XQzuxViJsHVdCScjzRkbwfiZsqrv+xlw6PCFAo4DVavGYBUQxCF9eqi6oi51kf/dku4FbH/qgSCNDwI9QwJXptp8Juyj6nrUoRwmwqTIlqbPfLeXaMJFQsiE5Ga0329euYYQhoozxYyrmfUotJrSKHM03wZ+tnmH1BHsn1kIPwHOR9Onu6yqIWY5VtRA52Y5cnfUIDoS+xmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3RgJqyiL3WgPnRIHJnpGukG4t6uWXlUoJAiGWndv2g=;
 b=0Q1MU1qTrQ8M7bTyrTp9R9BMLOPShRh/n1Q4fG4Hwl8/f8LJ6naSGNTNBQ/RoS3ob/ZtWtiIKh4Et6gjkOCBe7n0wI7umwKvccDJM7fDvEvGKPmyIDiF7z90eCvGiL7VFj//n6o13dEwH5UqPzlMzWqOVeLPEsen2+gIxWMZR8c=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Fri, 16 Jul
 2021 13:57:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.028; Fri, 16 Jul 2021
 13:57:07 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/5] drm/amdgpu: Change a few function names
Thread-Topic: [PATCH 2/5] drm/amdgpu: Change a few function names
Thread-Index: AQHXeeF4uSQ5a+5H6kq7+y4uaXMVCatFoP2r
Date: Fri, 16 Jul 2021 13:57:07 +0000
Message-ID: <BL1PR12MB514459E6C4EF5A621563978FF7119@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>,
 <1626398715-6419-3-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1626398715-6419-3-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-16T13:57:06.931Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e2dce77-bf30-44a8-225b-08d94861998c
x-ms-traffictypediagnostic: BL1PR12MB5317:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5317C744AA0C732949C21BBDF7119@BL1PR12MB5317.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9O1qH0DDaCqPOR6TNqsz6SsZjlM6hJ7iTEJslYqHcjCDslSNDYMtYvBQ6AILkXfBvT6DtASbSjMbDh/wy1NGYMQPKyF9PfxHepDudpuO6Ax0rrqvetJPQb8KOd21UKvTkrLTkLQjUhzuVnyD+CiEzf0fL9mgI9vpeRdJ9MJB7BpwfQgHkbatIR++Radio36cMRJRKLxA+7uOCDVf4n4gu0yiNwZnOG/kB5d4SDulhKbvGJZwhnMA7Gilh1teu+Zo14r/lL/xkYZOzdS3JI9DZaunYaaETbMbzSe6fVn2Mckc2vZ7qTubBZtGHd+X/ITbi4IHp9Wkng9Ve8acLcXgUp2W40t5jBkmqTPCwyn91brwKIM+aT2UvF6FFtvEBl92jkOYsVKfNVbCdcjr/KDtiZAYUm33JVxMLgIbfYOaZj5nNvDwAXXtP3gdiLRADLGkxybJwqX882YFaiz8z61DT9vJn3h2blodw6hjMoQ/PYnLbrvvvCwEbuI5e+YAzoTFHroei8O71p06mMl4EBw93IhfHhCZz5hr1O3sbppeNoaJ4qAhtBjR/B0iX+ZA9wcOuUVZIh86KQoQlHsUiBxJlsD31ajEgFKrWaCzqpwWaFsUiMN56SJ4gKrh2v/ph6tnIxgiCMnqlWG90ueHq72D2lkMK3Ak8YCF63EQKw7wVBX0993tz73hBCVsI8MRgfI11g6gx1EO4VzZyHlzWfoOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(83380400001)(9686003)(4326008)(66446008)(66556008)(52536014)(86362001)(5660300002)(54906003)(55016002)(66946007)(316002)(110136005)(71200400001)(64756008)(66476007)(6506007)(38100700002)(166002)(966005)(45080400002)(478600001)(76116006)(2906002)(7696005)(122000001)(26005)(8936002)(19627405001)(186003)(8676002)(33656002)(53546011)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/8cYUooRWyRNcAe+fFgq6RAW2yiQT6hgqwIvdIMCkqYmtPnTnyn+FvrhsK?=
 =?iso-8859-1?Q?Us86oVNGQ/V8GguednqipeRvJsssjxKzsFVhTm0B2pXBchwFvK/dPsoWNt?=
 =?iso-8859-1?Q?d0VrVsc3nnuCjndk0RQWGNPOv3Zd42mZuBG24s2IVVlpvvKK8KFh/wzxF8?=
 =?iso-8859-1?Q?cw+buQX6Y0bOs4D9q0ErkegVgjGhXbOf5AEQKwB5MXNdowbk7G5w84aOab?=
 =?iso-8859-1?Q?3f3TCi7wc+1k9HQAp8FUT+DYW10blL753qE1JtTljAdJrTDLsjDVxCAj1O?=
 =?iso-8859-1?Q?VE9TY6R/KXnUO/qRgRMHM7Hm8uloHiWqKYKnYiV/8mxbyM6HHp210hSSgz?=
 =?iso-8859-1?Q?yWGl2i8lRdAvmoOjtGjLKSH1rR4ObEJqSCdPe/AciyP1ZotOB36uFqv3EK?=
 =?iso-8859-1?Q?wdw9E5Qhsz169bt/5fiBUHUHx+gvmNH00p/QIEIoGcL4RYXMn18svIPBfH?=
 =?iso-8859-1?Q?zDnGWZNrjszBWK0Gy2TSX4dKuGKdiBDM6cYXQV2CjkxePFeZE+drLx2bL3?=
 =?iso-8859-1?Q?P8lnM+oPG/HPhsXC4YMtWBacQ9SAnT3PPkW9g65syox5As2Q4q8JLETmFt?=
 =?iso-8859-1?Q?WQ1A6bvG0LWcEJgkwv6HvRbXEkY0lnvEABqf35Z+4EevwKTv3+Wg70n+/U?=
 =?iso-8859-1?Q?TLp1GzKMA07wSyg2Mmg+vykROnp8Qms2QQ2D8++NPfZDb+kntPTNFnyJ0k?=
 =?iso-8859-1?Q?KjAMihzaUQeWofgGZawnT1Xz7T89uxvnQUvgJNqGLpZ+Bcz1Sr+fSm8nXJ?=
 =?iso-8859-1?Q?lzSSG287sxJMRDMmxKRimLHq0hOb+Byh1ZnrKL5zvbmcz3mYdEN7XGowlf?=
 =?iso-8859-1?Q?ablXPXOvXRCmThHVFrb6oSJgTVLS0cMZgHwFv+9ywJLFt+THIes+c25HMD?=
 =?iso-8859-1?Q?jC3/GlVr5U9/z7dGqlDyBJ8jUZBNKJLlu80elwHjnlk1pDPPM6sE7hWXjg?=
 =?iso-8859-1?Q?jaIXNIimpOsxPZ4u+La/M7iXUm1LuK5rVxWvvKPTu6+799/mbvgJpchC9I?=
 =?iso-8859-1?Q?0WmpeCMBA9g9pXZL3/B1kM+pkKtGmGxgMWAdQUn4Jt4NEPujQ21Jxktg4v?=
 =?iso-8859-1?Q?7Xj7TG/9cBDhMoaqxIe/c9nbHRfuPtfnArN1l1kHi9pMDs0SuNEBUUFmOn?=
 =?iso-8859-1?Q?Ti14EMu6q9Q0rb2qVgvf/pZ755pjNRoUJylahNypBHex7I1Y5F9zfgd41Z?=
 =?iso-8859-1?Q?V7M75cNf26QKmDsdUpO72oiTDvfvxtjw33312a+5p0meigdAX1OTV9qIMf?=
 =?iso-8859-1?Q?bVc050bUjHNLr7mq6KjTlEH5C7K4C7lzUz/kGXcsFHe4u7iCsEMbjeOZ5U?=
 =?iso-8859-1?Q?ETw5kltQs9xD5E/UMYJsunCBRAxdciYu79WF+ctrIUf8BsmsnV5zgcZACN?=
 =?iso-8859-1?Q?RZIuOD4TFO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2dce77-bf30-44a8-225b-08d94861998c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 13:57:07.3934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLV2S/ysIdUFxKSxtgJhwz2MrBi9ICA5sLKwtR3k2XjlWHI8quQOWVqL5Xj1ZIiI3f91auVUlgt0LtPx2r86Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2002517940=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2002517940==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BL1PR12MB514459E6C4EF5A621563978FF7119BL1PR12MB5144namp_"

--_000_BL1PR12MB514459E6C4EF5A621563978FF7119BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Oak Zeng=
 <Oak.Zeng@amd.com>
Sent: Thursday, July 15, 2021 9:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Liu, Leo <Leo.Liu@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; Zhang, Hawking=
 <Hawking.Zhang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Change a few function names

Function name "psp_np_fw_load" is not proper as people don't
know _np_fw_ means "non psp firmware". Change the function
name to psp_load_non_psp_fw for better understanding. Same
thing for function psp_execute_np_fw_load.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index d9ddb2c..8d1e2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2351,7 +2351,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_=
firmware_info *ucode,
         return ret;
 }

-static int psp_execute_np_fw_load(struct psp_context *psp,
+static int psp_execute_non_psp_fw_load(struct psp_context *psp,
                                   struct amdgpu_firmware_info *ucode)
 {
         int ret =3D 0;
@@ -2387,7 +2387,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
                 }
         }

-       ret =3D psp_execute_np_fw_load(psp, ucode);
+       ret =3D psp_execute_non_psp_fw_load(psp, ucode);

         if (ret)
                 DRM_ERROR("PSP load smu failed!\n");
@@ -2442,14 +2442,14 @@ int psp_load_fw_list(struct psp_context *psp,
         for (i =3D 0; i < ucode_count; ++i) {
                 ucode =3D ucode_list[i];
                 psp_print_fw_hdr(psp, ucode);
-               ret =3D psp_execute_np_fw_load(psp, ucode);
+               ret =3D psp_execute_non_psp_fw_load(psp, ucode);
                 if (ret)
                         return ret;
         }
         return ret;
 }

-static int psp_np_fw_load(struct psp_context *psp)
+static int psp_load_non_psp_fw(struct psp_context *psp)
 {
         int i, ret;
         struct amdgpu_firmware_info *ucode;
@@ -2488,7 +2488,7 @@ static int psp_np_fw_load(struct psp_context *psp)

                 psp_print_fw_hdr(psp, ucode);

-               ret =3D psp_execute_np_fw_load(psp, ucode);
+               ret =3D psp_execute_non_psp_fw_load(psp, ucode);
                 if (ret)
                         return ret;

@@ -2565,7 +2565,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
         if (ret)
                 goto failed;

-       ret =3D psp_np_fw_load(psp);
+       ret =3D psp_load_non_psp_fw(psp);
         if (ret)
                 goto failed;

@@ -2765,7 +2765,7 @@ static int psp_resume(void *handle)
         if (ret)
                 goto failed;

-       ret =3D psp_np_fw_load(psp);
+       ret =3D psp_load_non_psp_fw(psp);
         if (ret)
                 goto failed;

@@ -2863,7 +2863,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, i=
nt inst_idx,
         ucode.mc_addr =3D cmd_gpu_addr;
         ucode.ucode_size =3D cmd_size;

-       return psp_execute_np_fw_load(&adev->psp, &ucode);
+       return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
 }

 int psp_ring_cmd_submit(struct psp_context *psp,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C27434c9fa61e4b45a66b08d947f899a5%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637619955325142021%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DGlg8agdk%2BQu5ToJqr7RaF9br4TUfbW%2BFZo1nMX1liZ8%3D&amp;reserved=3D0

--_000_BL1PR12MB514459E6C4EF5A621563978FF7119BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Oak Zeng &lt;Oak.Zeng@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, July 15, 2021 9:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Kuehling, Felix &lt;Felix.=
Kuehling@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; Zeng, Oak &lt;Oak.Z=
eng@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/5] drm/amdgpu: Change a few function names</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Function name &quot;psp_np_fw_load&quot; is not pr=
oper as people don't<br>
know _np_fw_ means &quot;non psp firmware&quot;. Change the function<br>
name to psp_load_non_psp_fw for better understanding. Same<br>
thing for function psp_execute_np_fw_load.<br>
<br>
Signed-off-by: Oak Zeng &lt;Oak.Zeng@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------<br>
&nbsp;1 file changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index d9ddb2c..8d1e2b2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -2351,7 +2351,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_=
firmware_info *ucode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_execute_np_fw_load(struct psp_context *psp,<br>
+static int psp_execute_non_psp_fw_load(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmwa=
re_info *ucode)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2387,7 +2387,7 @@ static int psp_load_smu_fw(struct psp_context *psp)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_execute_np_fw_load(psp, u=
code);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_execute_non_psp_fw_load(p=
sp, ucode);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP load smu failed!\n&quot;);<br>
@@ -2442,14 +2442,14 @@ int psp_load_fw_list(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ucode=
_count; ++i) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ucode =3D ucode_list[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_print_fw_hdr(psp, ucode);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_execute_np_fw_load(psp, ucode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_execute_non_psp_fw_load(psp, ucode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_np_fw_load(struct psp_context *psp)<br>
+static int psp_load_non_psp_fw(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *ucode;<br>
@@ -2488,7 +2488,7 @@ static int psp_np_fw_load(struct psp_context *psp)<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_print_fw_hdr(psp, ucode);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_execute_np_fw_load(psp, ucode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_execute_non_psp_fw_load(psp, ucode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;<br>
@@ -2565,7 +2565,7 @@ static int psp_load_fw(struct amdgpu_device *adev)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_np_fw_load(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_load_non_psp_fw(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
@@ -2765,7 +2765,7 @@ static int psp_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_np_fw_load(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_load_non_psp_fw(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
@@ -2863,7 +2863,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, i=
nt inst_idx,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode.mc_addr =3D cmd_gpu_=
addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode.ucode_size =3D cmd_s=
ize;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_execute_np_fw_load(&amp;ad=
ev-&gt;psp, &amp;ucode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_execute_non_psp_fw_load(&a=
mp;adev-&gt;psp, &amp;ucode);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psp_ring_cmd_submit(struct psp_context *psp,<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C27434c9fa61e4b45a66b08d947f899a5%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619955325142021%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DGlg8agdk%2BQu5ToJqr7RaF9br4TUfbW%2BFZo1nMX1liZ8%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C27434c9fa61e4b45a66b08d947f8=
99a5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619955325142021%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DGlg8agdk%2BQu5ToJqr7RaF9br4TUfbW%2BFZo1nMX=
1liZ8%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514459E6C4EF5A621563978FF7119BL1PR12MB5144namp_--

--===============2002517940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2002517940==--
