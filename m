Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBBDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 18:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECEB10E13D;
	Tue, 10 May 2022 18:24:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F6BF10E13D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 18:24:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBHtgzZYU8rw19C7mMCTC28Dkm95ZELEscKXxGmSE3cMat4UCWd3b74mwy+hcRP2Fier5XJ00htUC+bpnb3AINj7A/I/9+PgMN6nYwGoZAb2OfGuvWBx+iR/dDECoIuzpg+NshRUv9vrAhhCaUNGmn65rc6WYQYrwiMxU81q47p5qGWaDptqQAqsjKlG2iG+hTvZ9NWde9Druf8V5j3VnXoCRLKqyzckHuVFt9WxL+jJw9NaweJCe03Y6jUHjbClGiQjlm8qxD5ZKvame/wHYfm/NmpSgsZbGFLKdrEYS3o6UygZVvw6Uy5hOlsTNGFCGx1fPWtT6ljYEBIEKTIyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1SFHwgMeBq5DWEi/PBlqQ3cEIWaeA3t0cZQJZW2DCw=;
 b=BuBLeKjvLcM72mO/T8Eh4z44fcmFw2Q2qQ0eNRwbq5pJQfpiDSZLbG1RU2fzK/3o+ezjLE8aV8pYpDkglnIOgBOraUQIuSpr9YebTXecaFo1xZhgc/ttPqSQ3Mexv08DpDpqx9QyhS8Bn0f8mkCg3fnwxzOIfeBe3X06iCiKRoR/FZnghxLNiXLu19aLA8uKb8v2YevfJ73uF+RbT99C0lJhBS0ufoMnt901ioEC547ET6iecy+IztUFoAQRyC6xdd9e6TQaMNyns5aEvtycJ+tMdsBGiY4ekzQDsgIaYkSKCcEwg+trGJ8pC6Rqcn3LYHDpuXy/UhZwT9a1kjlQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1SFHwgMeBq5DWEi/PBlqQ3cEIWaeA3t0cZQJZW2DCw=;
 b=2tkxVI5gsvn6KBP4V7BdF4AA0MYw/LUn+5jMKzqOYfNffNyiXtOYazHEJBxf3bBauo34jyeqroFis/cmKIG3tDKkKxAwn3hRnrOqB5jzBcULH8QWrSHOELJrT4Lkmpy1OuRqeGsmpB4yXNs7Xcpa6PTZq3AySAb0GVDZQLK+E1A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY4PR1201MB2484.namprd12.prod.outlook.com (2603:10b6:903:d7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 18:24:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::98b8:8b06:2069:c838%9]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 18:24:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: add smu pp_feature_mask callback for
 smu_v13_0_7
Thread-Topic: [PATCH] drm/amd/pm: add smu pp_feature_mask callback for
 smu_v13_0_7
Thread-Index: AQHYZJf3JZKUJvCWpEKLp9S0nmfEY60YbSxf
Date: Tue, 10 May 2022 18:24:47 +0000
Message-ID: <BL1PR12MB5144E501029F25E182407EC4F7C99@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220510180009.461734-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220510180009.461734-1-KevinYang.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-10T18:24:46.673Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91f7c92b-9f2f-445b-2446-08da32b25cf7
x-ms-traffictypediagnostic: CY4PR1201MB2484:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB2484CF9B014FC0E70AC78A2AF7C99@CY4PR1201MB2484.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5o832j8gPdssH2c5ZytvMOXNGBt7b4lE5u1BcSPWl4aWc++YLNQiFWMGPsvmWxlWM6nU/t3G8uwtXh00ya+glL97SqqnM7OrcHnSp0IOSDMXipPMYwYckTj1o0EbX5pmeAABCvzgyfAGleG+RpQup7ZHDDBeB4zEIFGwj5IZbU/tiq94AZ7vJRHPhXeV0M99AblrgMUR2qTBAfzVD6LVJCrwCDmAc8We4SXEJ3M85S4GLw5P/ZDIfXytgdxs93pXz/mjW3q3bB7V3bl7YVQRs8CKU02/46Q1yP7ZX0AKAi5RBEhe6a95VQuJfAiVkgF4+Lzmk3FMnRwGPAuAj//cF+rrE5I2wT+jp38ig/xgt4cWHHBCJetkaKWVO0+8hjLse7DIQ5ROgT3DHpm9ktPD8LxUrejfZz88uLvScyaeMUXg6+hAAKfJ57+CamdnB9CoiCPoc3p+h0fdAUmXR6gmbi5ZdGSC34cuyOeuMytHOB5cb2u0cDSl7i4kQFIgE5/gxjkbK382bayZlu2oBnpsmFBpS3JUkv26PwgGSH1nkv+I7s/NzfWy9CVemIGfkwpiCS+VQfRyjCCrB96FsLJ6YTKTAhJyRL71VNeLUG2L4W4NkcxZhjerJiabGYIUPfE5enSTjx6V+uuDKdCblTT876LESNyPs99+3zAJ6fseGq/Sd4XEU//QS1jIFTBDUVHH/nEm77CaV6iOWTJquiiYTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(316002)(86362001)(64756008)(66556008)(76116006)(8936002)(110136005)(52536014)(66446008)(53546011)(6506007)(122000001)(9686003)(26005)(7696005)(71200400001)(66476007)(38070700005)(38100700002)(508600001)(8676002)(2906002)(19627405001)(5660300002)(33656002)(186003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2lfFv2WuFNzZhF9Y70uliF038qp613OnOnCmkeoRqjdfnbDxIn+rO1cyX3Ho?=
 =?us-ascii?Q?b6Nu8nE1hzaGz2XHNiSAGGZHbKCLtFJQVZSa/m/cxRkHAb0mdnbFATIuBO48?=
 =?us-ascii?Q?NXQj1s9fVDGJAu/9ehg6B/lU+wwjrViv5aBGmP0LsRV8D/BuIz2A7d0qiKGy?=
 =?us-ascii?Q?l9imDBm4+sM/yvPPK4HY4fofXGRuW94YEC4rf6UNEXV3lXHmfbg+7xNVq9bm?=
 =?us-ascii?Q?A49GWrUDM+1ki/IiwNYFTvwlgeI99Cp037GxVNyRY1WAF515DiYCGSmAPSEC?=
 =?us-ascii?Q?ld5Ld7b7dBADArbyMXdlBu5flo4YZPBMp6aWpOJynCYtyy1WKKYzb7XjNSmW?=
 =?us-ascii?Q?3Wx2RLbkTrk/LfI68+oeYrZLEQ+fujEt0GMq8lQ2ZHh0i0h/DO5a0ykaZ95n?=
 =?us-ascii?Q?aTcgxIDRtyWyYOMdFc92YhoXAeMeqNaI/n3iniASUSC0cIiV9lDPEa0p9nSc?=
 =?us-ascii?Q?A43Z3z6/oegV1mq8wuGFJWiCV0LyJ695NiolisafsK2HgDiDY//H77GFt6qr?=
 =?us-ascii?Q?afAJNwd6ZDivf6c6swgiTy9VF3M1HfsQZd/k1s1lQ0bdr4SN3n5ZeHpHqGZ2?=
 =?us-ascii?Q?2xuKX31v7wOh2rg6qamO8tsj+C9PFy64HF7PMUXbGr2+mjbzzvVNjTApJv87?=
 =?us-ascii?Q?L7zc4sQwq+qhB7aiTx4lo4Db/4zwl06wK1xCI0QekbDybEXFCI1TrCfsnNKl?=
 =?us-ascii?Q?tTikiuaeAGjyB2uh20cTwwkMRShfrx9Tb1NJfnVarzUnzZXscKEl/X/+4W/j?=
 =?us-ascii?Q?VVdgdc1C1Gj/B5DM/kApaLhFkQK1tGIq/szCnLkhW/6jKTNihPUzuQa3XOoA?=
 =?us-ascii?Q?ibEPKmHpObqPPYNMeYhUENIYNJUJtoxAKZmxsC3T4ufpxjbC1Nwh2VaLJUqK?=
 =?us-ascii?Q?pNDAUaB7M0gNkeCTc+A9JsdtjJ/HXy1L9U1SjuRXG9LL6AktzsudjKdkm/Yx?=
 =?us-ascii?Q?c+jDOfOCRfztjKeW8SqaWs2Z0842AXMPUjcjznqaPZHYC47FJtw6JgaVnKAh?=
 =?us-ascii?Q?wUDeNeXZbaTn8I1TeukUSC4HQJPvOR0f1pkSvlyfAv6q9pApylw9cYOHdOEU?=
 =?us-ascii?Q?5T28eDCyLL3NEpJeYDkblrNTxYTV//mR7AxENBJusx3fDxDXaZepP8LnZfCh?=
 =?us-ascii?Q?QojrvjAN2kbg3v9lgudUuC4Fto7Dpgz89veuL5mlLrMHW/lp6F4bKPFrW62T?=
 =?us-ascii?Q?jumzBXw5i43kFMMCmFZSqIfMyd34H1MEKQjwpd+9oQlHEgzxiJsKwAL0rkQc?=
 =?us-ascii?Q?onEXQ0078mS7ePir9HhyXXZEBlHT/lc2EKrycbTqHlky8FHrHV1F6BCw1nzh?=
 =?us-ascii?Q?M7ihDOqtJ9i+ZKwYl3xCCE5wgBsQpFM5fz2AWceEYpIfkfJDanmiNyC8w4+E?=
 =?us-ascii?Q?JgaYVkYNl4/0G0A6TE81N1SUnQ97gHE0PIaqRZKy+Jr1i/YvxszD2ijiYL+G?=
 =?us-ascii?Q?q1msqVYJeKhqBCiYEnHPq2hQuHWzV6+Z5RpyGauli+/VRM0BrLVFt5hcuEWZ?=
 =?us-ascii?Q?WukIdpkM/wK+YYxYToVgE2oEtJZRcGYU/64lEPCACr7upfZEeRjxpXEBwCud?=
 =?us-ascii?Q?Bkgr/aLY1170GKiea7lU03mQKe/wtW7/k3vfrRS6f95agoVjUbJi27tECSjf?=
 =?us-ascii?Q?SwdcabG+gCkydZbmVlcOhadP7cxw1C3eoLKenL8+QdTWYGYgKKX2+JVhs1P4?=
 =?us-ascii?Q?Sp4ORDfPXwgbLwpshqos5eRioXOHA3VS5xa91WcC6C26VVhcbSNsnI+suF+X?=
 =?us-ascii?Q?OESLEjQLUA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144E501029F25E182407EC4F7C99BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f7c92b-9f2f-445b-2446-08da32b25cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 18:24:47.1458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mu6A+9L0As1TYCn7iIMEUulg/WznFMoh5OPSEaSIsi3+WwxhrlrNexLIUBLBcaALwBKp1KG/Yi8Nbp4wU2ehwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2484
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

--_000_BL1PR12MB5144E501029F25E182407EC4F7C99BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yang Wan=
g <KevinYang.Wang@amd.com>
Sent: Tuesday, May 10, 2022 2:00 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: add smu pp_feature_mask callback for smu_v13_0=
_7

- set_pp_feature_mask
- get_pp_feature_mask

the pp_feature device node isn't working when
above callback functions aren't provided.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 583a96784558..00964b3728fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1500,6 +1500,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
         .get_power_profile_mode =3D smu_v13_0_7_get_power_profile_mode,
         .set_power_profile_mode =3D smu_v13_0_7_set_power_profile_mode,
         .set_tool_table_location =3D smu_v13_0_set_tool_table_location,
+       .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
+       .set_pp_feature_mask =3D smu_cmn_set_pp_feature_mask,
 };

 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
--
2.25.1


--_000_BL1PR12MB5144E501029F25E182407EC4F7C99BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yang Wang &lt;KevinYang.Wang@=
amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 10, 2022 2:00 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: add smu pp_feature_mask callback for sm=
u_v13_0_7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">- set_pp_feature_mask<br>
- get_pp_feature_mask<br>
<br>
the pp_feature device node isn't working when<br>
above callback functions aren't provided.<br>
<br>
Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
index 583a96784558..00964b3728fe 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c<br>
@@ -1500,6 +1500,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profile_mode =
=3D smu_v13_0_7_get_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =
=3D smu_v13_0_7_set_power_profile_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v13_0_set_tool_table_location,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D smu_cmn_get_=
pp_feature_mask,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pp_feature_mask =3D smu_cmn_set_=
pp_feature_mask,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144E501029F25E182407EC4F7C99BL1PR12MB5144namp_--
