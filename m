Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C489C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 10:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F4C22B42
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 10:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F4C22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F3C6E14D;
	Mon, 14 Dec 2020 10:41:01 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036C56E14D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 10:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQv8plNA1Z0CRy6tQtmXAv5ABE1VPbEb6HE6FpNvAux0tsd9lKGh13wBsytiWDb5Atkxxb5hRbYYzHVpw0nXrfQ8baM6Ec4OUcW4oAvLBfXej1DQCz/8XDkPZ7zZ7XA1Qv6bFWEJzTjrtbtmdNfHWh7umzSKz2yrdXG/pq9YTWVxxttotfkyiavzFwPNLunGUQhZf3a2OqfQtDtuECd3avQIDUz7mfNAN3Rujg9H8J6/zSerjfSoTbitMkWaCCLIG6dPR9J1CD0VYwROTkFhK9yIW5MuAYSzyLwYRpAh1o6EW7sz6BbbGVWmFTYw5VSNQXB5rSR/Yhc1PnUzYp9VTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmdrvVqn0pq2YiX3FH5oI5fGMgIqSZ4k6JkFTClQfms=;
 b=eW7KgwXXSPh6D/UX7UNjuFwJiSwEPaJTLULfpEyWRLSKgPLULbFOzK0cNTDpAMbZ7OoApSqhiuimxje89UzJP92QGdbhkcszIePzxQtNad1hjFFXuS3ZxI4MQXW8whROP0YK/fABzJJs5F5aOJUurLydJtB3PFGkNPY6RtKgejVs2HO7MK3swNlAgyGOLaAC5PO1XyTHfFbXekZimBvjEhZItjBcPWFPo46l13JySnqDq8OTPxcMISIQIrh5EoGdTgj942tHndflQ2kWIzItfc2JWcFMQAXog+XWorQ8l/ZHh/lDFAJkNFR/5vD1OvMFhIAwEexoHOEHA2v/koz4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmdrvVqn0pq2YiX3FH5oI5fGMgIqSZ4k6JkFTClQfms=;
 b=XSWfELNfIfBR0DTzvMrSORGdTvF8lP4yr9tZfbjckIgsJ/bRXAxwNafGeaPVA2qzW9ntHRoeYw0P/d4zNdd0BpVoPP9wSTzWYDTJ+pABGeAyXVKpI0U97dKUIKhdHLSGyZMgpdCuQRu88eymot3a1UNtLDBVZ54P2Z2sWgh7RNA=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2989.namprd12.prod.outlook.com (2603:10b6:208:c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Mon, 14 Dec
 2020 10:40:58 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 10:40:58 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: Re: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on
 sriov for SIENNA_CICHLID
Thread-Topic: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on
 sriov for SIENNA_CICHLID
Thread-Index: AQHW0gTZ36Hm12GAmkOBqgXjTvHeQan2Zwyf
Date: Mon, 14 Dec 2020 10:40:58 +0000
Message-ID: <MN2PR12MB30220FBAB3289F68061F64C5A2C70@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20201214103519.20030-1-Stanley.Yang@amd.com>
In-Reply-To: <20201214103519.20030-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-14T10:40:57.219Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7309bda2-7845-48f1-460b-08d8a01cbe2a
x-ms-traffictypediagnostic: MN2PR12MB2989:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2989E784FCFB78C2B5540714A2C70@MN2PR12MB2989.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mo8OA8U6RE9OLd848e6ewxgGm8Evrm7+ebiPUxmr9ce64NQO7fIj9BwEe0LsveXffkjUDIW2yeBs1NxlQIR4DF4yQ/jyVburCNZ6DVlHLFnsurVMA/r6MEhFhA3DvTaI394wzCFVg7Fn1vU+wZB3lxL0lCJxrxvF8A6cKQUO/K2W0NNO3viFFVup74lP5mzHDKOUeCXYwjkTW3Xe7jM+MyPCSEZQd2Gqm1+/H4pxtKum/2S0upJ29O5tsLmecU8yBhpUg5JqlR+cuud8lp+i/ATsQe4Zq4NtYQVhSkCHcQwE5whAk3qgZry/iC7W1q2uOpq/a0fOE043vkyyYBnx3j2xAzv0oXXTj7i2vRryYL0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(52536014)(186003)(91956017)(66446008)(19627405001)(166002)(71200400001)(6506007)(45080400002)(7696005)(33656002)(76116006)(508600001)(53546011)(66556008)(6636002)(66946007)(9686003)(66476007)(86362001)(2906002)(8936002)(26005)(8676002)(966005)(110136005)(5660300002)(64756008)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+iG1MKl+vy54RJpqqpvCn3asthMX23ewteciaU4jrWQba+pEPnokJnF9pn?=
 =?iso-8859-1?Q?9zaoOI2rwvBQVEh7bvMNJS8BZ9SQZPfZti6A+3wn3lGA99OEd5oOvcTwnQ?=
 =?iso-8859-1?Q?aDI0dT7a6XbMHmMcz5eIgwzu+BljAdNgkVIm9P6jMMn1QkD6eyi+85bd+B?=
 =?iso-8859-1?Q?bugHEhWAan3klZSvX+sZFZTQtTN3+8O6UFWgQiVusFJ1LzoGhjuXVTZlin?=
 =?iso-8859-1?Q?tT+7KXZrh8joDkEWhPDtlWDsOM1/sdwdgf7HS3IjE3nNbfpPNjeT8jgEtJ?=
 =?iso-8859-1?Q?M14J5JSphfUb6j/uu3+CiT2uMqS8hiVDfrgcamh0T7EMrUsUj5gkyAlfkq?=
 =?iso-8859-1?Q?4QyIZqp74cx26MEEnsBCmQO+45YSknTG6gpQ160nycSYjqc+ZmVDNt4RNj?=
 =?iso-8859-1?Q?dpz6124REspwWErAFllR5uCa4IiFZQR/DbI7+FboUcb/L7rebLSFnuV/hU?=
 =?iso-8859-1?Q?XT4WENyUjLyq0U7al2UCRaWEj63RNM4ZG4dxNjOKdRngH/6ThBBc3QXNoB?=
 =?iso-8859-1?Q?N67gKAA1g9yMnClPtPgGge+1HOM7b+t/DfKx27+fElIwHoLkV8YmHIr9yd?=
 =?iso-8859-1?Q?Fn47qaIAbYQPT8hngSsP+FCfRzH7JMyZ2HYsQQz4i0fifHkUd85tLjxOtB?=
 =?iso-8859-1?Q?qz91xw7+uXHC2wfR0/tq1FpQQONNnBI+gbgfmqSUFSnnAyDoDjaxZvgVLp?=
 =?iso-8859-1?Q?5UQBPR+fpecpbUKqSP6oPgDQZoNdpAAKkx8J5S3s3EGA03eWqTyVbYDLfh?=
 =?iso-8859-1?Q?xCb+59Og8RJj+9IRPrvSOPV3qfAxwf1tTDRUei6IferY88QH4ZNxUoPxmp?=
 =?iso-8859-1?Q?nXv9t26T9rupZEEbofJKyKNLiq73Aw0NEXnGWkz0tyXt3zcheOjfwi2QcY?=
 =?iso-8859-1?Q?WMoCShpjVFue28ZcojqCmWPG7foULPqUfR5jB+VP/jNbNiWIdS2HowNBmK?=
 =?iso-8859-1?Q?p1zerVq3Tuy86+8ap+MCG39mcytAHZCuurvESSHA6hFTnhnxC7Yq++Ypl1?=
 =?iso-8859-1?Q?ZtG9222I7mE4n2irc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7309bda2-7845-48f1-460b-08d8a01cbe2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 10:40:58.1226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bX57jMQYQ5itJarW6AAIf63jyYjWLDDwTDeiFL6fwDZzY5wnE79NNUaqm4p15kyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2989
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
Content-Type: multipart/mixed; boundary="===============0755348143=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0755348143==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30220FBAB3289F68061F64C5A2C70MN2PR12MB3022namp_"

--_000_MN2PR12MB30220FBAB3289F68061F64C5A2C70MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Stanley.=
Yang <Stanley.Yang@amd.com>
Sent: Monday, December 14, 2020 6:35 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Jian, Ja=
ne <Jane.Jian@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode on sri=
ov for SIENNA_CICHLID

skip load smu and sdma fw on sriov due to sos,
ta and asd fw have been skipped for SIENNA_CICHLID.

V2:
    move asic check into smu11

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c         |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 10 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  5 +++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 39e17aae655f..87566dee048d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_devic=
e *adev)
         struct amdgpu_firmware_info *info =3D NULL;
         const struct common_firmware_header *header =3D NULL;

+       if (amdgpu_sriov_vf(adev) && (adev->asic_type =3D=3D CHIP_SIENNA_CI=
CHLID))
+               return 0;
+
         DRM_DEBUG("\n");

         switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..8b867a6d52b5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,12 +847,10 @@ static int smu_sw_init(void *handle)
         smu->smu_dpm.dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;
         smu->smu_dpm.requested_dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;

-       if (!amdgpu_sriov_vf(adev) || (adev->asic_type !=3D CHIP_NAVI12)) {
-               ret =3D smu_init_microcode(smu);
-               if (ret) {
-                       dev_err(adev->dev, "Failed to load smu firmware!\n"=
);
-                       return ret;
-               }
+       ret =3D smu_init_microcode(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to load smu firmware!\n");
+               return ret;
         }

         ret =3D smu_smc_table_sw_init(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c
index 624065d3c079..c3c181975c9d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -91,6 +91,11 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
         const struct common_firmware_header *header;
         struct amdgpu_firmware_info *ucode =3D NULL;

+       if (amdgpu_sriov_vf(adev) &&
+                       ((adev->asic_type =3D=3D CHIP_NAVI12) ||
+                        (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID)))
+               return 0;
+
         switch (adev->asic_type) {
         case CHIP_ARCTURUS:
                 chip_name =3D "arcturus";
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C170ed7c1105e4f1e9ff208d8a01bf99f%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637435389321705051%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiH=
vrmGlSeLBXPzu54Zc4KjV8Y8gUmtNtmScKLdMhUO8%3D&amp;reserved=3D0

--_000_MN2PR12MB30220FBAB3289F68061F64C5A2C70MN2PR12MB3022namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
Best Regards,<br>
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Stanley.Yang &lt;Stanley.Yang=
@amd.com&gt;<br>
<b>Sent:</b> Monday, December 14, 2020 6:35 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Jian, Jane &lt;Jane.Jian@amd.com&gt;<br>
<b>Cc:</b> Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> [PATCH V2 1/1] drm/amdgpu: skip load smu and sdma microcode=
 on sriov for SIENNA_CICHLID</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">skip load smu and sdma fw on sriov due to sos,<br>
ta and asd fw have been skipped for SIENNA_CICHLID.<br>
<br>
V2:<br>
&nbsp;&nbsp;&nbsp; move asic check into smu11<br>
<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 10 ++++------<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |&nbsp; 5 +++++<br>
&nbsp;3 files changed, 12 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 39e17aae655f..87566dee048d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *info =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
(adev-&gt;asic_type =3D=3D CHIP_SIENNA_CICHLID))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index cf999b7a2164..8b867a6d52b5 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -847,12 +847,10 @@ static int smu_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_dpm.dpm_level =
=3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_dpm.requested_=
dpm_level =3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev) || (adev-&=
gt;asic_type !=3D CHIP_NAVI12)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_init_microcode(smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Failed to load smu firmware!\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_init_microcode(smu);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Failed to load smu firmware!\n&quot;=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_table_sw_i=
nit(smu);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
index 624065d3c079..c3c181975c9d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c<br>
@@ -91,6 +91,11 @@ int smu_v11_0_init_microcode(struct smu_context *smu)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct common_firmwa=
re_header *header;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_inf=
o *ucode =3D NULL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev-&gt;asic_=
type =3D=3D CHIP_NAVI12) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;=
asic_type =3D=3D CHIP_SIENNA_CICHLID)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ARCTURUS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; chip_name =3D &quot;arcturus&quot;;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C170ed7c1105e4f1e9ff208d8a01bf99f%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637435389321705051%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DiHvrmGlSeLBXPzu54Zc4KjV8Y8gUmtNtmScKLdMhUO8%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C170ed7c1105e4f1e9ff208d8a01bf99f%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637435389321705051%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DiHvrmGlSeLBXPzu54Zc4KjV8Y8gUmtNtmScKLdMhUO8%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30220FBAB3289F68061F64C5A2C70MN2PR12MB3022namp_--

--===============0755348143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0755348143==--
