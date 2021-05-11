Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A70DC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 13:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CF86191C
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 13:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CF86191C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F16DD6E17C;
	Tue, 11 May 2021 13:15:32 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750045.outbound.protection.outlook.com [40.107.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA116E17C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 13:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWIj30wJmly3qQMVZ2dcAFUWpNyiGAfauf443HOxfAOseOE5+pVceyNNCiqo5BdTC9HlYXK5xPWWtSP1ciaNDGJOryG/pmmoXDfmjYuW4BM7k+ND+ZAxCULpUpJDQ5RqPWcc8i/Ij3abntMQFl90N5Zl7dq8Wlhh9Bv5C474X/XazgZpEFXcArdBHJAHRqGU0ksQLi+KOksghaiu3b5sB+JIgxUfPF6QbGDljrJ+AwTMItie+jdOjsdsHawqqOUDJSE9lVbn9K0+pCmhSRKlMZjxYYy5pj9hB4Nsexmh/oNyZtK/bT1/3kTSHQc22o7d7b/s+P5q18NyX0X/cO1RXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15mDDErs2lbmD4BNS8dUd3aIj8XXV2nxjIQCCJB6JI=;
 b=aYYxmrYPV3VG3qE1qQfDnxVyabcOhQo4vPgE4vZ4YMNPVcT/CatMvp6JiRvLHyWcvR/oP5Oc1XQYo/9vpOV/vvBBvjV+I1jPxpOMIlMNfoacaXJE5Cv+hgee1mf3Ynd58VnR0gFaPqf0W1DtWIPzTfpC5SDNJciCa/yHEeSEcEza8gqYBnV3qHD56YrA0RlBwd9qrUsOs1LrONHa1Phj/U1qsUtUDhA0kk14FZYExMfsF4zGpmff/bPZvFb0Er3cPdp62CkgBYyE0DmUvuqM257gbpd0ErsxNaaxZdivu9q57OxlPtoCLSOEBlJ+XunYIc4US15LIRyiKH/d9SOyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15mDDErs2lbmD4BNS8dUd3aIj8XXV2nxjIQCCJB6JI=;
 b=tKq1+bzX05iU/mlXZKtrY70nXBtYpt1CUhTSS6X/4EuPPqFPotHBB2OUG9FAJCGYzcGyvCqGcaPqkPIG/dMkuPTPq05BQB8J3gGtzdQHsmWrs/uh3ZP1Dw5CiFNeON7gTyL2YE5ykGKfnNNPM6JJmolt3gPEW8pYbCqj7ZBL6/k=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4866.namprd12.prod.outlook.com (2603:10b6:208:1cf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 13:15:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 13:15:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios
Thread-Index: AQHXRib3oQEsnfINC0S0WY994zCB0KreQfQv
Date: Tue, 11 May 2021 13:15:30 +0000
Message-ID: <MN2PR12MB44889B34B2877BEEB6DF1803F7539@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210511053109.28816-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210511053109.28816-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-11T13:15:29.624Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fed16ab8-3ce1-44b0-8699-08d9147ed9d6
x-ms-traffictypediagnostic: BL0PR12MB4866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB48668DB2D4A3AC32C42CC568F7539@BL0PR12MB4866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzNaf5bwkupNEFOiCEfLvSZBATcjNStINOQroPPmYkM5WP/JV421d85MwqVnFdprI9OcxX/TbL+hL/sKyWXNcr3ZjY3JHYr9kCly6Zi9iw9zBEMeS0CT/2HNkinA8xqIkfWNLlyyWsDyXV+rKqX1HHKH5UG3N2yPN9r5UGXWKSxGA9E3clWL0QDC2unthzRaoYHy3tuhLu3UHsuE/6sUQ1Suz3J2FkZxNBDo3m1+4vOuewfxlrg3PIvsjTgIMOeTivltJpCA2noP/8pk2+YD7ubgT8ObSJolqrwpTEaqSfdJZ6SrqlmP57IJ4ClDFI8UxAo1gEKaLD+VG1fAMY1LmKG8suiXzaSJnnAOH2Hx/ifP9TqGXAUSYhJ1d/BpdBt25uHZbpo3Cba7IMGaZX7BDFfimJPgJN3IBgklTqC5zcwLqJ0GOR9FE2RoRoFhqAvYCVSapPb+qoIejEUq2CEqLgS+HwQH0Q5xHgSPdub4XVhBPeLZXZbGmjfjwfzMSinRTaQ2IEM7XXgfP9YmJUogeTT4W8seIlXFQVLkgdJQfCsWiS8djmoKtlWNGKvoRv1yz5ihYqMN5qtwsEq2GfLVeEmVYOB3KTWIKlLS94zBTqMvoACLtOLW+sA4eSST64D/atSBxU2En/c1HD+4UJQrnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(45080400002)(186003)(2906002)(5660300002)(26005)(478600001)(76116006)(15650500001)(64756008)(19627405001)(8936002)(9686003)(66946007)(66556008)(66476007)(38100700002)(122000001)(66446008)(55016002)(8676002)(7696005)(4326008)(966005)(71200400001)(53546011)(83380400001)(316002)(6506007)(110136005)(52536014)(166002)(54906003)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?OR55tmMoiCjFjh6PLxQw32fS7NTxg2R77EWrccW2peXmAn7k7cROqot7wh?=
 =?iso-8859-1?Q?kaFgHYeDSxRwaDHzlh+bpry9ErrOIaRgzTmdClS+5LRHzkrhQSQIYsA2vn?=
 =?iso-8859-1?Q?JS/VZWVPMeaIpW9N50VN/d3xLR+OQhP7yJOiB10u2E0ZAA7zrVSQQ7WyKR?=
 =?iso-8859-1?Q?SVO0dKWbt/COAgf7iKJuqexp883v3rW8eBzyjo6QlRJPRyziStlA5daHUh?=
 =?iso-8859-1?Q?KExIhXzrwdDW16K0cVuHyLG9ojHNgBf46eoCndnwqZskf60vBF8p3tGFzu?=
 =?iso-8859-1?Q?rcNiXiRwazVB4vj+Iked1AbRJfSmGt/UDPojwP/xlnvOWvuiNjxL5PWTSr?=
 =?iso-8859-1?Q?lHCg+Xr3Bh5Who1tEt8nreRT60JNtEnQYF1kUdJiAhCv1M8InIYCYv8LM0?=
 =?iso-8859-1?Q?IM1uHozuIShlfSdhkbP8dSbfh8OrORylE+fjdByJoED8ZcadDxOgqHKQo6?=
 =?iso-8859-1?Q?CC+SsECWoVBSFx2duzZXCRS4zeJ2pV1WPFshY7m8bXRkf9vWyDKcX/xYy4?=
 =?iso-8859-1?Q?JWAmMKaI2Q5atCno8fFCQIKTgSbUF50MgoJKJ3zgb/QLaZkpzuh57CABXQ?=
 =?iso-8859-1?Q?AXMIV8ALuQWVRuAN8hmvxjoGfPnM7HjGvgZVJGQzefJbYs9YJltSFrizp0?=
 =?iso-8859-1?Q?naNdpV8LoVUzhMcLpABpDHjpP149YZNWgaetN2aYleJ3JIr+hmRtgzSfno?=
 =?iso-8859-1?Q?bgUxU8xlylHbeA7z0tkkkQ7YCueW1/zKa3EoB86rsuVNwT5tlqxgAQYFEy?=
 =?iso-8859-1?Q?LyjahHK/YNg8yYq+a/rxPuV9MIjEfnzJGi6BmZ09NXKqa1vC8kF5ZwqzqH?=
 =?iso-8859-1?Q?qyb1xxFT92THDlhYV+Xf60d1JnDs5l6M4pEbtziCRQFp1sqkXjbwk333uh?=
 =?iso-8859-1?Q?DzKYtXbokPA3kYEHPednLoWHVlx6cFaAIYcMCLK256d3TxiUxrcos0yuFb?=
 =?iso-8859-1?Q?gqSUWtowvChgSdFxNuZPIXJpWHM/apUnESsptmP9jdBfHrlX0di95dv9RW?=
 =?iso-8859-1?Q?ArFZBiXdpfqI9lTd/Z+GSUrXnG+rpsDhkpGR2qmUj8aXdfNGr9/36T48WY?=
 =?iso-8859-1?Q?anmri+PAAVlU9oPt5mhwpCb2q/wqUAUTQ3AAYVDsCMp8n7lH13k252JZSB?=
 =?iso-8859-1?Q?TAGGLJ6RJF+RzxsQhoftPqgFHc07HAlbFIizVF/Ku05J1STE1l8nc6T7RA?=
 =?iso-8859-1?Q?rHTxpdTHorYfw4jkozPT9hDAtxNxJYLDSkGy9+XmDtL1Lbs7+QiGEaGROz?=
 =?iso-8859-1?Q?9Ma6q/6k6qVEuqRa6p8jgnihzPRyYVpStzbc5wlVBw3tTwOQ0aEA7TGFwW?=
 =?iso-8859-1?Q?/KmURF9Ijlazvb2PhfBWej9eQJRvaJzhZ/BJPJoYawL22YQ+koOcPKBVeE?=
 =?iso-8859-1?Q?maInGMAXlT?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed16ab8-3ce1-44b0-8699-08d9147ed9d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 13:15:30.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Wpc+d/t79HepEgFMPbtJ4IUO49HKpNOBvTmU89cSJbZdxJagAjp92G/SYShW25Mvm9Njz582iRSiVus5XUixg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4866
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "keescook@chromium.org" <keescook@chromium.org>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============1183803976=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1183803976==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44889B34B2877BEEB6DF1803F7539MN2PR12MB4488namp_"

--_000_MN2PR12MB44889B34B2877BEEB6DF1803F7539MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Please update the umr patch as well.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jiawei G=
u <Jiawei.Gu@amd.com>
Sent: Tuesday, May 11, 2021 1:31 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: StDenis, Tom <Tom.StDenis@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.co=
m>; keescook@chromium.org <keescook@chromium.org>; Nieto, David M <David.Ni=
eto@amd.com>
Subject: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios

Use numeric type serial in drm_amdgpu_info_vbios instead.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 include/uapi/drm/amdgpu_drm.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 75f34a9008e7..e1008a79b441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -871,7 +871,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
                         memcpy(vbios_info.vbios_pn, atom_context->vbios_pn=
, sizeof(atom_context->vbios_pn));
                         vbios_info.version =3D atom_context->version;
                         memcpy(vbios_info.date, atom_context->date, sizeof=
(atom_context->date));
-                       memcpy(vbios_info.serial, adev->serial, sizeof(adev=
->serial));
+                       vbios_info.serial =3D adev->unique_id;
                         vbios_info.dev_id =3D adev->pdev->device;
                         vbios_info.rev_id =3D adev->pdev->revision;
                         vbios_info.sub_dev_id =3D atom_context->sub_dev_id=
;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2b487a8d2727..2d9e84658bbc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
         __u8 vbios_pn[64];
         __u32 version;
         __u8 date[32];
-       __u8 serial[16];
+       __u64 serial;
         __u32 dev_id;
         __u32 rev_id;
         __u32 sub_dev_id;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C9c3ad129089d4585544f08d9143e1892%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637563079204768525%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DefCxiLv4J5KWmoKqy1geARlt%2FJppT1eetVI3R%2FMNfzw%3D&amp;reserved=3D0

--_000_MN2PR12MB44889B34B2877BEEB6DF1803F7539MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please update the umr patch as well.&nbsp; <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Jiawei Gu &lt;Jiawei.Gu@amd=
.com&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 1:31 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> StDenis, Tom &lt;Tom.StDenis@amd.com&gt;; Gu, JiaWei (Will) &lt;=
JiaWei.Gu@amd.com&gt;; keescook@chromium.org &lt;keescook@chromium.org&gt;;=
 Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vb=
ios</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Use numeric type serial in drm_amdgpu_info_vbios i=
nstead.<br>
<br>
Signed-off-by: Jiawei Gu &lt;Jiawei.Gu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-<br>
&nbsp;include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; | 2 +-<br>
&nbsp;2 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 75f34a9008e7..e1008a79b441 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -871,7 +871,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcp=
y(vbios_info.vbios_pn, atom_context-&gt;vbios_pn, sizeof(atom_context-&gt;v=
bios_pn));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.version =3D atom_context-&gt;version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcp=
y(vbios_info.date, atom_context-&gt;date, sizeof(atom_context-&gt;date));<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(vbios_inf=
o.serial, adev-&gt;serial, sizeof(adev-&gt;serial));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios_info.seria=
l =3D adev-&gt;unique_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.dev_id =3D adev-&gt;pdev-&gt;device;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.rev_id =3D adev-&gt;pdev-&gt;revision;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vbios=
_info.sub_dev_id =3D atom_context-&gt;sub_dev_id;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 2b487a8d2727..2d9e84658bbc 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C9c3ad129089d4585544f08d9143e1892%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563079204768525%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DefCxiLv4J5KWmoKqy1geARlt%2FJppT1eetVI3R%2FMNfzw%3D&a=
mp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D04%7C01%7Calexander.deucher%40amd.com%7C9c3ad129089d4585544f08d9143e=
1892%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637563079204768525%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;amp;sdata=3DefCxiLv4J5KWmoKqy1geARlt%2FJppT1eetVI3R%2F=
MNfzw%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB44889B34B2877BEEB6DF1803F7539MN2PR12MB4488namp_--

--===============1183803976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1183803976==--
