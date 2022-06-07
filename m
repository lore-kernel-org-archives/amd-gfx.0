Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEB3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 09:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BD911BA97;
	Tue,  7 Jun 2022 09:41:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B556A11BA97
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 09:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPcxx/i55ypoOq/e58XzJT83zWAE7fvb32Ggm2kHSpEMQDa9d6f51Uhg0uG9Z6F+WohaNSrxofU4ED7hiNEFMJIT2wuChKOG3+GtRKKVbZgVZq6upnFcX6PaPEkeJbpKI5tI5Wklxhb6ENJzlZLXKVVIVOTR4WUp++9RIMVQJS8zGhERwf0xijR4eVCtoTDFzibypVFopUzDn0/b9e+uxzQIABLbyO6AFX9SOh5T2Max3+GTBCgw2NT+cIsgU8CCLg+pkf53bCem8ulFg79ebGtwa6aYDCIY7ljcvzOMA9h0QbeH0qZdTtmKbO0s1uwmoyjmfxY8dQUcm6M7W20lFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d8xwFWD4T+rK1Lzmc+QTwOMFVdj8Uw3OngRmHQHD+4=;
 b=U2ueH5SdeZ6tgXsiA4gFCcFEQ1jAD0+QhYlI/+spiJdhO4ktjQrXlAHna5R8VqAvr3iHldWgfYB8GRPvUmgKWDc3D0QPGwQL4YzUSceBpq1XVZ+UvzC8LJ/TvkJakZF4M+659vU57mfw3HAV0payzrv4muGI5GH/G41xx7Bi8XgIUbQuRqSUfH1t8Rlu7wTI3quDXzBv8tF3/Hcc+gvtEND3ubhFSjFKe13WFfupti6kAG8/9Td1tyP3A6uCWdJy494QSQUDqrx8ddmPQHwQdhy8splzuPyzs58MuPlS+HS1FIKvmlGamtjBw0ZBWsgMTD30vkOkM6wCuqcaJLKmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d8xwFWD4T+rK1Lzmc+QTwOMFVdj8Uw3OngRmHQHD+4=;
 b=b2J2rUHAEdDMQoBl+xQRQRPv2KnBbtmz3LY/gJ3C5SoSiolKPuMrsUkvN5KrNd1GJUvpPxqTmOpfkbJ0HWw8elsU1I+InRE9kK9P3fzcj8mhDxf8Ohr3l67wxPhymX/diS6DD6Z7zYvhNK0oKLuAypNUbZttF7eSLZVypiFEYHM=
Received: from MN2PR12MB3663.namprd12.prod.outlook.com (2603:10b6:208:16e::22)
 by SN6PR12MB4622.namprd12.prod.outlook.com (2603:10b6:805:e2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 09:41:15 +0000
Received: from MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::55:1e84:5052:909a]) by MN2PR12MB3663.namprd12.prod.outlook.com
 ([fe80::55:1e84:5052:909a%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 09:41:15 +0000
From: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix scratch register access method in SRIOV
Thread-Topic: [PATCH v2] drm/amdgpu: fix scratch register access method in
 SRIOV
Thread-Index: AQHYeU6YX9TPw2bf/0SAi4rYO3S+g61DsWHQ
Date: Tue, 7 Jun 2022 09:41:15 +0000
Message-ID: <MN2PR12MB3663119BCEFB0D0CEF423A9AE9A59@MN2PR12MB3663.namprd12.prod.outlook.com>
References: <20220606023845.3439931-1-zhenguo.yin@amd.com>
In-Reply-To: <20220606023845.3439931-1-zhenguo.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: ckoenig.leichtzumerken@gmail.com
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T09:41:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9495905e-4b18-4453-817c-3d5e3b6ba235;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-07T09:41:02Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f11b9d20-c88e-422e-9f98-a98dfb13e04e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b674f885-41be-41c7-a142-08da4869dd96
x-ms-traffictypediagnostic: SN6PR12MB4622:EE_
x-microsoft-antispam-prvs: <SN6PR12MB46227B8AE591F72C9EDC4D7AE9A59@SN6PR12MB4622.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLA8ekJeoetbg3SMLBYuCEn+PkinZm05ySwLlIVjX7WvXljPnvnKX9b8k78VWgpxJ/8D7zp1psIeh67XnllomqQmm7mJ+0ciPEZKgmzMhyOfCBkDcMK6gnFRodWDYH3shkut6kg1U8WwSAsTgT3oGbRAlMw2FePNPw1IJbITDq2eA0b9Jh3gaJiu1lpj+CnvxYSw0tu29WMu5FER6l8qdhq2zT7ZHLkbn2BV78EQNaNsIYdQ8QoehLLzFCi6E4ofBQSXKAtBye7htsNZddJei9aFgi3CoNvLcrq7YuQf0xxWaP+wPHqZHXJzNuQWGgm0VCuFaQO/mK32ll/XBSjM3cXFuiQov2a7lmtmEVHcmI5mB1T73lkTyMwjMiwmokFWmOzymT+lAt4TwAQc0cfuNUBwELFe5DOvaHt9Zy3H0k8lXmIkcSpveN4eP8qOwONiXOxU51LLrR31o57gIv+zrSlZhMW20GRGQuLZGdHUDv4Hx44S6y/597vUUsY34woHSv6ULaAXo976kPMUjJBqVNT9Hh/xdgfTzQ7SeZVrOte2VaF70sx1/PrLf4zIZTu0qnFRahNeGZEY/rh2TwSXcrSdHvL+VHsgMKDNtEMdh1C/4QDhEEMNeKzYi2HC+zkbGcCPwFS1dDC60wlyP4rxkJBLBnt3xjMdhukm4RE6xtxFBM/W8DHYG5R4ND9A4YHsUTQZA3FLf29Db/y8Y4IMJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(7696005)(316002)(26005)(8676002)(6506007)(53546011)(64756008)(5660300002)(55016003)(86362001)(66574015)(186003)(66946007)(33656002)(8936002)(52536014)(76116006)(66476007)(66556008)(9686003)(83380400001)(66446008)(2906002)(122000001)(4326008)(38070700005)(71200400001)(99936003)(110136005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?E8PFXWcA6jqZ0kk58V9DOEPXwCVaxR3l/kEXgsRfBih+2gYV5ns24QeqX2?=
 =?iso-8859-1?Q?mWCQrLenYLz/MOlPINeQoPyhHHPErQCKvJdt3i6hixiyuTGqeOqiFF2rGh?=
 =?iso-8859-1?Q?VZ3HDgrQorxzgQSRpsnH3ODVUMt8rdwDtzZt9vasPSBzzPM0aCV6lmhmu9?=
 =?iso-8859-1?Q?ZBASYxAXUDZyy+yg5kb/0EePj5H9IG3Ghonz6wUa5mAdDBMqMvXWRRpFNc?=
 =?iso-8859-1?Q?1h/9jozSUwLlF6ujFSGym08oLyX5ctq5xvN23UHjTzpP0+NjnVATIRsnTs?=
 =?iso-8859-1?Q?7FATtjm1ZShEvOBfyYLdGmKe5QnV4o3WXDrf7vIoqH3uczRGEiWteFXyN8?=
 =?iso-8859-1?Q?M9Ylu/0CS+Jeju1BXZnwpPuYT4n+2DyqlV55HY9AOv95B5hvTwhOooiVRf?=
 =?iso-8859-1?Q?cFCxFYZPv+ihAHE4UJlF9bJOFMgYSy2pAZL88vajD9sabfF2iE/rFOqrb8?=
 =?iso-8859-1?Q?4iUbiLAjgMobv91Xpb2SLFil/OriPL6SR1Sh1spwLAuW2FkbdaRXf9y6lB?=
 =?iso-8859-1?Q?nPXO/im7uhV4iudq6qWuWDudEcsgCOfs2GF9OojFO1u8peLDzw47V4M0nk?=
 =?iso-8859-1?Q?36l6f3F16BHGfPVFo7SUD/LbjSSneh9cb5Rzg9pxaWcXP0YlDtufPBPSHN?=
 =?iso-8859-1?Q?TzGV2fryqZSVT7Ln0sODg5WG0B9oSAGD3K0bDafK6PMIS5OI9Hx0GRadUN?=
 =?iso-8859-1?Q?TAFbp6Kf58gpwwMx3YEfROHQ5AAIJHrjYq4x/5oNt9NQ3r7568H9iurdx9?=
 =?iso-8859-1?Q?Q2jzrwqAxLtdsWyZnzzGhwYRbIa7GdZEIKd53lvoXg1tT1UrPXJXWJdDNl?=
 =?iso-8859-1?Q?mUkjg8/lEr1T3Hlj9RkIpvm+kyYSmamZ9EoYucWQwmTqpi1Uw+2WH4+kcG?=
 =?iso-8859-1?Q?JYxD5RgV5CvfZjW212aJBBX/OxkjOwqHlwRa/mWotc8k6LpeCnzHp361BS?=
 =?iso-8859-1?Q?dMlJOqVF0A6Cjhe2+bSFOcmDHLHIVacHa9PH7drwVS0DDGeZO2bFGJtMiO?=
 =?iso-8859-1?Q?lJN+c2EJ3hJaMEc8XRR3LJxrIJU1K/lOozT2CUDiTux92+uT+/J7UzRUH/?=
 =?iso-8859-1?Q?zKmlJo1Ldi/l8lWwnM2o/SKbokwqQ/5BcyW4OIcFr/FIAN3iwFnvL01UvI?=
 =?iso-8859-1?Q?N5paEHxT0hVIEHJzaVUSNBwEOo+MBCxMxV02EPC826VS8Z0UEBxVlLXS1a?=
 =?iso-8859-1?Q?f6A8SbFVBO7eQSuWs+d/lB3kP6VLR9rn9uhigokqmJcEAD73X6C8HYAZdj?=
 =?iso-8859-1?Q?q4q4Dai87QlgJiRK8qY8ReHKBTF6+6Js73LmaXqq9iJREKbRGi0mPzgI9+?=
 =?iso-8859-1?Q?MY+7lHEIk2ph/uEmqzpTf9JkY81vh7vJrJ0Ya+Qrx7o72tduOQ1/Cx9JNy?=
 =?iso-8859-1?Q?V23gl7vF4yf+lBHVxJBelLCMUyYfL1ARslXIZ76UvbhcrfliHe1QaOipkO?=
 =?iso-8859-1?Q?q39k6FlR08nLED960NMpCgVCaC6fMAiBaSWplrEOPslZ0BD/QJt9kc1vfS?=
 =?iso-8859-1?Q?3ci76bL7p/PJI/EXVOplodJU3E+8jDJZxtNhVeRpuW4sMp/2gpmgdzx/Mn?=
 =?iso-8859-1?Q?RfYVXZt3a7VkQBQNEOLCZHNzPS12ZmcdUtUGo/GYhIm3TC/+vHd3241hs4?=
 =?iso-8859-1?Q?rR+hsmGjOK5soAS9qEfkpK/b2l9gOzMvLr7jS1FCX/M0nqc1R7ADZ9DnsI?=
 =?iso-8859-1?Q?67++nqRqeWCbI2+4Zo7sgk23Bt74vSPBtnwSu4TbgLVRVMAFlc2OnGYU/y?=
 =?iso-8859-1?Q?TN3OtkgJI/3SAFA609S5ZaVOjuqrAkR9QSGhuZjAjU1MQ5CpBmjQtxGNfl?=
 =?iso-8859-1?Q?vky9kTu18w=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_002_MN2PR12MB3663119BCEFB0D0CEF423A9AE9A59MN2PR12MB3663namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b674f885-41be-41c7-a142-08da4869dd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 09:41:15.2280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfmJRIl9anjNpwZNjfa7GnCDoRx86aOA1iA80+rAsnkVqnIqcKJQwKKaT7ljfJtK6Ckqi09tDOaE4aOl07Vwhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4622
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
Cc: "Chen, JingWen \(Wayne\)" <JingWen.Chen2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_MN2PR12MB3663119BCEFB0D0CEF423A9AE9A59MN2PR12MB3663namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi, @Christian K=F6nig

Added a local variable to store register offset according to your comments.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of ZhenGuo =
Yin
Sent: Monday, June 6, 2022 10:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; Chen, JingWen (Wayne) <Jing=
Wen.Chen2@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix scratch register access method in SRIOV

The scratch register should be accessed through MMIO instead of RLCG in SRI=
OV, since it being used in RLCG register access function.

Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")
Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index c5f46d264b23..ecbaf92759b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3780,11 +3780,12 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_ri=
ng *ring, int eng_sel,  static int gfx_v10_0_ring_test_ring(struct amdgpu_r=
ing *ring)  {
 	struct amdgpu_device *adev =3D ring->adev;
+	uint32_t scratch =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0);
 	uint32_t tmp =3D 0;
 	unsigned i;
 	int r;
=20
-	WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
+	WREG32(scratch, 0xCAFEDEAD);
 	r =3D amdgpu_ring_alloc(ring, 3);
 	if (r) {
 		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n", @@ -3793,13 +3794=
,13 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	}
=20
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
-	amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
+	amdgpu_ring_write(ring, scratch -
 			  PACKET3_SET_UCONFIG_REG_START);
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
=20
 	for (i =3D 0; i < adev->usec_timeout; i++) {
-		tmp =3D RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
+		tmp =3D RREG32(scratch);
 		if (tmp =3D=3D 0xDEADBEEF)
 			break;
 		if (amdgpu_emu_mode =3D=3D 1)
--
2.35.1

--_002_MN2PR12MB3663119BCEFB0D0CEF423A9AE9A59MN2PR12MB3663namp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Tue, 07 Jun 2022 09:41:09 GMT";
	modification-date="Tue, 07 Jun 2022 09:41:13 GMT"

Received: from BY5PR12MB4018.namprd12.prod.outlook.com (2603:10b6:a03:1a7::17)
 by MN2PR12MB3663.namprd12.prod.outlook.com with HTTPS; Wed, 1 Jun 2022
 11:48:18 +0000
Received: from MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15)
 by BY5PR12MB4018.namprd12.prod.outlook.com (2603:10b6:a03:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 1 Jun
 2022 11:48:14 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95::4) by MWHPR13CA0029.outlook.office365.com
 (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 1 Jun 2022 11:48:14 +0000
Received: from mail-ej1-f46.google.com (209.85.218.46) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 11:48:14 +0000
Received: by mail-ej1-f46.google.com with SMTP id y19so3199657ejq.6;
        Wed, 01 Jun 2022 04:48:14 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709060dcb00b006fe9f9d0938sm614004eji.175.2022.06.01.04.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:48:12 -0700 (PDT)
From: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, JingWen (Wayne)" <JingWen.Chen2@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
Thread-Index: AQHYdYkaVSdvBuIzMEClokVggkg2jq06b92A
Date: Wed, 1 Jun 2022 11:48:11 +0000
Message-ID: <47f997f0-e9a3-c46b-931d-756dd28cb230@gmail.com>
References: <20220601072732.2773139-1-zhenguo.yin@amd.com>
In-Reply-To: <20220601072732.2773139-1-zhenguo.yin@amd.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthSource:  CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Has-Attach: 
X-MS-Exchange-Organization-Network-Message-Id:  9f65f493-e922-4353-8cea-08da43c49c67
X-MS-Exchange-Organization-SCL: 1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-publictraffictype: Email
received-spf: Pass (protection.outlook.com: domain of gmail.com designates
 209.85.218.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=209.85.218.46; helo=mail-ej1-f46.google.com; pr=C
x-ms-exchange-organization-originalclientipaddress: 209.85.218.46
x-ms-exchange-organization-originalserveripaddress: 10.13.174.110
x-forefront-antispam-report:  CIP:209.85.218.46;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail-ej1-f46.google.com;PTR:mail-ej1-f46.google.com;CAT:NONE;SFS:(13230001)(4636009)(26005)(76482006)(956004)(5660300002)(450100002)(2616005)(8676002)(31696002)(55446002)(356005)(336012)(7596003)(7636003)(86362001)(73392003)(31686004)(83380400001)(426003)(1096003)(34756004)(36756003)(82202003)(4326008)(43740500002);DIR:INB;
authentication-results: spf=pass (sender IP is 209.85.218.46)
 smtp.mailfrom=gmail.com; dkim=pass (signature was verified)
 header.d=gmail.com;dmarc=pass action=none header.from=gmail.com;compauth=pass
 reason=100
x-ms-office365-filtering-correlation-id: 9f65f493-e922-4353-8cea-08da43c49c67
x-ms-traffictypediagnostic: BY5PR12MB4018:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR12MB4018
x-microsoft-antispam: BCL:0;
x-ms-exchange-crosstenant-originalarrivaltime: 01 Jun 2022 11:48:14.3029 (UTC)
x-ms-exchange-crosstenant-network-message-id:  9f65f493-e922-4353-8cea-08da43c49c67
x-ms-exchange-crosstenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
x-ms-exchange-crosstenant-fromentityheader: Internet
x-ms-exchange-transport-endtoendlatency: 00:00:04.1622154
x-eopattributedmessage: 0
x-ms-exchange-processed-by-bccfoldering: 15.20.5293.019
x-ms-exchange-crosstenant-authsource:  CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
x-ms-exchange-crosstenant-authas: Anonymous
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com;
 s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sPxK5UghEuYFIAiafTc7D7nHEIB1svqjAjjDyxsCIlo=;
        b=BejQVTVVfRVbhf86VYRL4odjGSn4Fyq8tpA02vzwDiCqhf5ZlG9p/zHI2QNvCFDXPm
         F0d0XlbQ24Vpt6XV44X4BFYJAxsHObmB00OtzGLbnaDikcwz1TznMLzfn9NLk4yUjzkv
         72726NpTUZ+x4dzPc/KDfWDA3fTkF+jdgfKm25NJxS4Kqb5OMYRoutb8ePwf+uXQ7gJP
         lJ4DxAWkmaaCG9cesr6TnWsp+83Qd61oprsRt4LJ8lBQfC/JTtHL7BVfij1D5Tp+t4or
         S4dgeCJDWiCj4qJaPQRC1knCNOi8cZQ79sMOXffbJbXE1PKVoxuFWPQYks3FhgvucNuT
         TVdA==
x-eoptenantattributedmessage: 3dd8961f-e488-4e60-8e11-a82d994e183d:0
X-Microsoft-Antispam-Mailbox-Delivery:  ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506458)(944626604)(920097)(930097);
X-Microsoft-Antispam-Message-Info:  =?utf-8?B?T2tTaHVqZEpSMGxseTRaYkZ5WFBvcDgvSlc4MUpKbHB2aThHQWIvcE1mOWEw?=
 =?utf-8?B?cDFVbGlWRFBuVzZ4SjFvM09EQ2Z0a1ZzOVovMStNbnlGY3NNcGR0RmFScG5j?=
 =?utf-8?B?MEloSjhkNjliWGpOU2Z3VEMrMWpPWnM0K0NhS2xhakpsYUFXenRJcU1JTyt6?=
 =?utf-8?B?bU10TklkM2NITkNNT2lQRWFhbFJTN0kwdTA3T3lBVnNDa2NEMURxcXFWbjVJ?=
 =?utf-8?B?STFZOURnbW5QcWJiUXM5cmorbGVyQjI4blN5V3JGQmFkTlMxeTNLTElPbDll?=
 =?utf-8?B?V2Roayt1ZkIvdVVzOVRrdVFCYUZFU2Y4cFhwY0tURHhjNjl4VmJOMSs0R0RU?=
 =?utf-8?B?QkZZYWMwaHBPcEhDTENweFR0OVFXNGxsWHNVL29JRE82bzVGVXZCR0ZXcDRv?=
 =?utf-8?B?SEo5eGs3V2QrOFNFbUJtWk5yd2hpcmxKTy9YL3hWVWJGT1BKNEhyMjN1YUc3?=
 =?utf-8?B?TjFDSGtkcDJwdnlqMHI3am1MeFRDV0QxbUg2UUxsTDBiU3VlVXFPQzV3ZTY5?=
 =?utf-8?B?Z3ZVMnl5Q1RsY3I4L0ttL082ODZFUVlMcExLSEhvSUpMWW9PaEJZOG5VOXJX?=
 =?utf-8?B?YmppZUhGZlZTZk42U2tmcUsyN1RXQTQxRGY1V3d5QVZKMGhuZEZ3MkZybFVz?=
 =?utf-8?B?VDZja1AyYS9oSkx5UVNwVEYyalIvNFJjQ2IvY1JMb2lWSk1uR200ekVDZzJC?=
 =?utf-8?B?T0FtSnh6dHBXUExWU3J1TnVHZ2tIdnlNbTZUN2RoMCttZERqRlZzTk13WlpP?=
 =?utf-8?B?T2RXYWtPdEg0elorN0tCeEJvdEJZN29XQ2ZEMjduZjFBMHZQZ0U4MkJjMFpT?=
 =?utf-8?B?UUp0eWZoN2R3TTBZK3lsWHovQWsyVmJ4NEM4VjJHZWtRUWFYc0FHRFJyMmVX?=
 =?utf-8?B?N3VITU9PdXlJSUlEM2I1SXpScDIxMkUzM2dyYlFpQlNwRzFMR2wvNEJMeWFw?=
 =?utf-8?B?Z2w1RzcxdTZ1d1lEUFpKSmpjTDIvQzAySDljcGVGWFZxbDhBOTR6NWw3SitE?=
 =?utf-8?B?UDY2bytTMzF6aTI3cU93cjU5YzRWSVdGSEFqbmNwY1Z3SUozQzRVa0ZrbHlY?=
 =?utf-8?B?UVBBR2xzNVdvRnBPZXNmRVZPZUVvcm0wbHBET1VQcS9ydFhOcUJWeDZFQ2tw?=
 =?utf-8?B?aGxINzdaY1lZVEVvM29HbTI2Z093OEo1cDdYS2hrTm5FTU5Qa3FxWTJiVzQ4?=
 =?utf-8?B?Y0pJcFF6TFdjS3NjOTRJdE1FclJuejI5ZVkzMHo5TE9JOFQ4WEswRzEzRjkv?=
 =?utf-8?B?ZkFmL0dad290MmRSZEJKc0o5em9EUU51bS9kTUV0NWc5V0o0NVZGbitnS0tV?=
 =?utf-8?B?cjgxVWFRSFhPZXdxcWJ1aEVqb0JkK1FnQjF0R1Q3NG8yTGZQdDNIOTZ1bXp3?=
 =?utf-8?B?Y3Fsa2dQK2ltQTZzM2thKzRPQjRrbVQ1OGUvc1dtLzkvS2ZFNnE4N2YxWk9P?=
 =?utf-8?B?VXRPYzdiR3NxMW1ZTFMvLzRPSWdRamlTTndBcHJUa3E0blAvVzNJQmF3bHNP?=
 =?utf-8?B?Ykdrb2g1MFFnWmc3c3QzQkJvUUhFdm1NOElmKzErYUs5UTlOSFhrV3crL1Nm?=
 =?utf-8?B?UHFYNUxDbmFjbi9DdjJQVCtwVlZqSnFJN3MyZ2w4NnE0b2RwVjlCUjE4L2NN?=
 =?utf-8?B?QzNFKzh5S3JJbFpRL21nS3ZKUlBXR1d3T0ZtRTM1Skk0Um1IUm1BWjdXekxE?=
 =?utf-8?B?VnNKZVZ4b3RVOUcrQ1E1S0V1YXZxTnhYWUhDR2hNYXJrSXAvQytGbHpEKzNU?=
 =?utf-8?B?QnNIUWVPUjdXKy9lcHVha2pmUjNYT1E1MjdvRFhTUVM2TzFvUDE3bUpiZVJk?=
 =?utf-8?B?cDlWM3lmTEFlVnJNRGJXNzMyUWlJeW5EcGIyeEpBM1RFTjI1ZGZrTjNGektt?=
 =?utf-8?B?WkVZUGRMU2QyRVd3TW9qT29wWlVEN1VxNVdnUnZoTG0wMXlTYStBMVZzLy9u?=
 =?utf-8?B?dDhhbml1cWJOTGoycW5GN1dEcGFNWjVWcHVtWGEzbnlRL3lqS2ZZVVdaajVh?=
 =?utf-8?B?VTBoNkFySmV2YXBLdUJBanJKQk9TcmhDd3R3d2E0ekdndG01TWlrZkFNTHoz?=
 =?utf-8?B?OTM3Y09VY2E2ZXhvNGd5YjZnL3BHc1V6VkczbXRmZ1A3U0huV3kxZnhvMkVR?=
 =?utf-8?B?WUhiRlg2SklHQ3owK0R0VVpxUklkeUUvSDdjd1hEdy9OMFg3TmZiTGZ3MEo2?=
 =?utf-8?B?WnFXNEJ2UVljRFhUeGZiOWhRUGhTcHYva1Y0Q1dQQXczQmRuWVVaZGVVY2hR?=
 =?utf-8?B?dEdLZEFVaHV1aUVOc0RRVlhwNWZheWJpTHB2U2plS2xjUVowWFRSeGE1cHJL?=
 =?utf-8?B?U2s4WVFpS0JHcmQxbk5kMGQrZEwveUlPMGI5RzVmYXpSSWZ1cVpmZG5EY0RF?=
 =?utf-8?Q?w9BgbPcsndQVMqCiwpP8w2YCzcjsxYnwSWj88?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D58526CE15AB84B815494FBE8E88306@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0

QW0gMDEuMDYuMjIgdW0gMDk6Mjcgc2NocmllYiBaaGVuR3VvIFlpbjoNCj4gVGhlIHNjcmF0Y2gg
cmVnaXN0ZXIgc2hvdWxkIGJlIGFjY2Vzc2VkIHRocm91Z2ggTU1JTyBpbnN0ZWFkIG9mIFJMQ0cN
Cj4gaW4gU1JJT1YsIHNpbmNlIGl0IGJlaW5nIHVzZWQgaW4gUkxDRyByZWdpc3RlciBhY2Nlc3Mg
ZnVuY3Rpb24uDQo+DQo+IEZpeGVzOiAwZTEzMTQ3ODFiOWMoImRybS9hbWRncHU6IG51a2UgZHlu
YW1pYyBnZnggc2NyYXRjaCByZWcgYWxsb2NhdGlvbiIpDQoNCk1heWJlIGJldHRlciBidXQgdGhl
IHJlZ2lzdGVyIG9mZnNldCBpbnRvIGEgbG9jYWwgY29uc3RhbnQgdGhlbi4NCg0KQXBhcnQgZnJv
bSB0aGF0IGxvb2tzIGdvb2QgdG8gbWUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gLS0t
DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCA0ICsrLS0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KPiBpbmRleCBjNWY0NmQyNjRiMjMu
LjgzMzFlMGM1ZTE4ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMNCj4gQEAgLTM3ODQsNyArMzc4NCw3IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JpbmdfdGVz
dF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gICAgICAgdW5zaWduZWQgaTsNCj4g
ICAgICAgaW50IHI7DQo+DQo+IC0gICAgIFdSRUczMl9TT0MxNShHQywgMCwgbW1TQ1JBVENIX1JF
RzAsIDB4Q0FGRURFQUQpOw0KPiArICAgICBXUkVHMzIoU09DMTVfUkVHX09GRlNFVChHQywgMCwg
bW1TQ1JBVENIX1JFRzApLCAweENBRkVERUFEKTsNCj4gICAgICAgciA9IGFtZGdwdV9yaW5nX2Fs
bG9jKHJpbmcsIDMpOw0KPiAgICAgICBpZiAocikgew0KPiAgICAgICAgICAgICAgIERSTV9FUlJP
UigiYW1kZ3B1OiBjcCBmYWlsZWQgdG8gbG9jayByaW5nICVkICglZCkuXG4iLA0KPiBAQCAtMzc5
OSw3ICszNzk5LDcgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmluZ190ZXN0X3Jpbmcoc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nKQ0KPiAgICAgICBhbWRncHVfcmluZ19jb21taXQocmluZyk7DQo+
DQo+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT51c2VjX3RpbWVvdXQ7IGkrKykgew0KPiAt
ICAgICAgICAgICAgIHRtcCA9IFJSRUczMl9TT0MxNShHQywgMCwgbW1TQ1JBVENIX1JFRzApOw0K
PiArICAgICAgICAgICAgIHRtcCA9IFJSRUczMihTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVND
UkFUQ0hfUkVHMCkpOw0KPiAgICAgICAgICAgICAgIGlmICh0bXAgPT0gMHhERUFEQkVFRikNCj4g
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgIGlmIChhbWRncHVf
ZW11X21vZGUgPT0gMSkNCg0K

--_002_MN2PR12MB3663119BCEFB0D0CEF423A9AE9A59MN2PR12MB3663namp_--
