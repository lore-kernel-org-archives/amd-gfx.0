Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C06C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BD510E90F;
	Thu,  8 May 2025 13:58:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="otno4GyR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECAD10E90F
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 13:58:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKbIQi1HmrxZhnUHVjeXSkKoJ0snw1j5Z8dVCPw5stDtoty0Sx4CnVAfLZ9DH56amu4SZKcMTFZV1VcyYUTMRuDD7i/6oeBvvnJDTd11U2yfNkd8cTXXe2eHyeoh09yVtrEv7q4ZlK8QU33InOn7Tuily5a+p1bcvA4622YCJS9mLZ1gBqYNcACKOByy6cvbywLTNC9WlblPD/O2m/sctIKivcKAnZrQhHcGftZB6Q6llX/mftwTKHs2epL8Dxy1cB5eGhgPJpccctOo1HNxfG1wGuBNR4TGuIBsJzGJNLZ2LONN9+8C5alkfpiVmilDTi/XSQzL98Qkg8dtxoKifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMa97qMikkDfhi32TzjAKBAb5TJ9UgRbY7QBUty6rlA=;
 b=UDemJTQnImAMz4gRWz7Yrwj0TKKkCyVatEMRXs8giAJ5NfUgcUHS4GZ1g3/lSRNzurFJo1Dg/1M1qET+ukHMAaRojnlVRziG096qgP3ESltTmM27xNudzv1sdW+lqU15Kd06sZGqZ78KqRS+y9NlnIB8r6YZgRoh5aMym4wy45FYxeqU+bDezF4nhsfh9xT8gimsxNW+Ng/5qjSwqpFCsBj3DaNcMGUtgXWZHKBpmv03Sv57UFlMFc75QAnLnCPPnEZObz/ZLMNipNrLByOmH2bklu/7L31MNbF91CPGvbBVeicACMtPs8Jz2Ji1u2sVxu0YklJOhXC6lV+sEeDPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMa97qMikkDfhi32TzjAKBAb5TJ9UgRbY7QBUty6rlA=;
 b=otno4GyRTHBA4X+zD5PXZ0rJAPzyMII23xpDaNwqVZvZz2ak8D6sJxo6bnnE7h026HdS08jTVCwy2QG5V/by8R73z3UsQ0T8Wof+ljBdtILuY3Wta7zg4jxursY3ogFg2nPMhCGEqpzLte74R28xI3/ynXvAWAvtmQzCDRzFep8=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 13:58:47 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%3]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 13:58:46 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: John Olender <john.olender@gmail.com>, "Wu, Ray" <Ray.Wu@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 05/14] drm/amd/display: Defer BW-optimization-blocked DRR
 adjustments
Thread-Topic: [PATCH 05/14] drm/amd/display: Defer BW-optimization-blocked DRR
 adjustments
Thread-Index: AQHbvvnY7y7jGHfeiECkrhQ3n76d+bPIf6WAgABEplI=
Date: Thu, 8 May 2025 13:58:46 +0000
Message-ID: <CH0PR12MB528465F8DBB2E1F7DF9585158B8BA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250507024242.1928299-1-ray.wu@amd.com>
 <20250507024242.1928299-6-ray.wu@amd.com>
 <1db948ed-b2e4-422d-a182-6aea8462c275@gmail.com>
In-Reply-To: <1db948ed-b2e4-422d-a182-6aea8462c275@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T13:58:45.921Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SN7PR12MB7955:EE_
x-ms-office365-filtering-correlation-id: eccb5e7d-5a07-47a7-bf4e-08dd8e387389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|13003099007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RiSzzIMrSgdy8/sA/GD4aqZpTrWrDF4Z5SDAfS2yDYGzwqBnFAcAa1LyFP6u?=
 =?us-ascii?Q?JogbiO1PWWUsyfybkgkgbuHZTVJLEgnM8ixbw+Jzh1nJ8wrmGaF9exFdqRvf?=
 =?us-ascii?Q?pBTHeEjmcmIpe8FXJ1yfZQSUcAHybCeED4RY8gX0Hm3GlEm6MAkqhmh2ERs7?=
 =?us-ascii?Q?aBMYmsH8Ul7WReZlF9CY/c6Fk8Y8U/vSpT88k3QNDI6yH7Xk0vkbb1OnNF8G?=
 =?us-ascii?Q?rAeu/kbyvugsfuT58EtMWy/JWFMraGSPxMKTzonGJOwHB1p1IM9eFz/eSL9f?=
 =?us-ascii?Q?uYU2kSerl11MkdtuafOXxpCEAfzF+oV34ZYC9jhG0H7WepjrfT27HxnOks/B?=
 =?us-ascii?Q?vFSdLeLLvhwyQeIilmLPmTMAjI6TM6EVzVzfYwy99aotqmlCS/1vI0BwdRx4?=
 =?us-ascii?Q?Lb636WDjtNS42E6j77TICbnbSaLBJ5ZocHP3D60Kej4NBmtr0QU2yJM58Lns?=
 =?us-ascii?Q?JE8AjGnVSa5gNUeRAf3z8Mriw0IHAapI/ApIsROT2l88nvF8S07FHbwXTQ2k?=
 =?us-ascii?Q?VuFnx2iI17cugzxdnfYwApmg7RlfdcPQYsHMwpqbQv57IDkjUuWPdurTT7/v?=
 =?us-ascii?Q?SJMXjvVaw8BzTk3mxGO8uKdBVEgpjQ0Zf5hoX+xzrmHbidZ7PJS1XzZm0iRD?=
 =?us-ascii?Q?1oN7B1AlMI6giXukKDIwvcRaVFMj3Y3yTP1j30CKZ3WvpkRZJpzYVVmnFlBH?=
 =?us-ascii?Q?N0miXEUgKk5v5sL2KdbdSCBJG0vCVDHN6NrkVBg7OE4rTFwBz/l5gaS+huBj?=
 =?us-ascii?Q?UDL7vXXi+KbU4SorHp207Nu33U90+SESAa5oZgbTQxuIs6Qp7ZDtqYOGMjDb?=
 =?us-ascii?Q?OkDy77IQGLHlUgofFRCq31s7envD4GmmuX1/ym6CLuuwTCfFLb0Jjd22g2Ay?=
 =?us-ascii?Q?UjuopJVV8cqeIAYrWSQ/+s6eaVO5IBR3yFewvLxMSF/SNZ8bkofxPIMlVXUs?=
 =?us-ascii?Q?6wEUDTKFdzOMtY/nbiXWkBfX30NR+WUPnuj0RCiV6U1Qhn14wuLqjmB1OLaz?=
 =?us-ascii?Q?JQgijbK4MJeujHVcgKZ+C3UTAezN/nDo8N+nYW6YXV10znQcJIS6mF+KO0eM?=
 =?us-ascii?Q?g6E2q2mFouqqnh64LkjAAOHjy63CidrWI0VI7/HH2Tku6Arlte7WnWVftIdC?=
 =?us-ascii?Q?vFJ5MvKW79z2vbjgmH/UwK4pBMIfXsyoU3CIOi7R5HrCvVrV7ur3WEDf0JOP?=
 =?us-ascii?Q?nEaenkK6q8aQtpt8qU+XFGFWupizkY6VVIUIsthDyKshgMavyRJ2+0RO0GSZ?=
 =?us-ascii?Q?Hz8R3pKKSFF58cf5QO88WoiXB5EX8Njd7YTibMEGgV8A7Rx6oCQ8CQ1V7oLS?=
 =?us-ascii?Q?WRf35kwLVEkY/0qntvjJhZeTKYieKjk7s2rgIAPu+QBhm8iEnB2C44eQX5pn?=
 =?us-ascii?Q?HTIfnjrcGPqQLCSqGgTXMne1e/w164uQYq8KFaThCKvYW1ksrEx8oLaXWMPN?=
 =?us-ascii?Q?HCc7Q3aQhsI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hJX1XZX8r1Jrv0gg6ziGRpZKjPodPQ2V5IL7axzPVNpHQueZoLP3RFXk1alu?=
 =?us-ascii?Q?MwNosv7EtlyRNF75GuiQ5Qn6Ahs/U2k/hu6SEcq8fphJQwU8Af1EB8BRsQQ4?=
 =?us-ascii?Q?j0J1H5zlYo9rBF2dUk5Ec6Es2bNIMQXfApX+53EilxKteO8RR0M8LRWLy28x?=
 =?us-ascii?Q?87e+7YHyynk66+orUTaJEeALkzFkToTE/aSy+T06P5nWTNC1O+4FCOITnGKX?=
 =?us-ascii?Q?3IaM4G7TPYE/yr8bb/V0oomETL5Mx9V0beZrZuqQJ0lTD5Il7uX2OkS1++sZ?=
 =?us-ascii?Q?bUVGi1zLiR6wTtE3ZfjmeFFDacfYm1mUqWyla3k1LaD6dOMHfpGB5xQJpqMA?=
 =?us-ascii?Q?y0vY7MvtS5vsmPpQ8/oR4RuT/7J+iQGHQ4c2Nw8Q4rvvbmsPGKCDz0qyTctm?=
 =?us-ascii?Q?Lp/jMPwVAN8GIMNYNK+ZoC+NBSj0Edvb1zhortEk7a4VoKqYd4WEDPwVn+qN?=
 =?us-ascii?Q?5uBvutJ9wcFHvCYLK+N7xznjASHlC0pD6LSrTPXH+f1BLQDJGoTv7nGi+19R?=
 =?us-ascii?Q?8RxJZEPGyVpYMsPuqUMhrEQcpMks96jebywJijUHVpSHhVg3PgIxDr/ND+nP?=
 =?us-ascii?Q?pQxxSZXFsqUG0bdWP5BibB9Hv+qYsx360zp7RmZ7gI7H4jkxH1FI9dpJou6j?=
 =?us-ascii?Q?T5dB7mt5/cAwH18XexG+yg0+HRZVp/Jf3VIgWIQjXWVI0YSjnQmmFimNzi0U?=
 =?us-ascii?Q?s3sZOlpsz8FV3TeijiLhCljre+95Nzwv+XJCyfr4KEdlFgEt6qHJnyqVeGRT?=
 =?us-ascii?Q?V3mTgMhp5lI7BNnMLp+xNWDoIdm/TQ7YVmcjOjxvtGCx0xjRvghLPmq+1eDC?=
 =?us-ascii?Q?I0fJnClT89UfttcMIKmrTogBih4cnbhm71S7HgJmGTui03kJulNgu785LlR3?=
 =?us-ascii?Q?MPX9e3y/WYt2hb8a0QBWQCyWotozWfJlrT8VEghgpKcWONrHIuG2CJ2+ScQa?=
 =?us-ascii?Q?R+vFNHc1VSh3mAuLXpqpq6s9ZeujDAKpvB3KknMzV8dD+ijuUu0E65UW2pJY?=
 =?us-ascii?Q?vet+v94VZY002AO1km410BeoLHfpoOEOEAaNA1n77FbACPBOGkTXlRstYtrJ?=
 =?us-ascii?Q?LOMOygGaQBv8Y9UBuhLsdvAmdZ5N/q4nemzkwPKOzyNgN2ZSNYjXf/C56BhV?=
 =?us-ascii?Q?nNiAGMujqwlO2B1nhc8ndjGf3r/pqmpzDilo6hfQ9N9IMQkw8hSaLrB7DNJ6?=
 =?us-ascii?Q?+b68U+/NIBbyHtt67uXAgsUkmfpJ9U2qYEeGI3c1JSECWMAp6ddZq+msUc+G?=
 =?us-ascii?Q?Lnay5srHSq1R5ozBtwLuW7EXSBroBWxh3WLuXUwfC0JqA3wHBhJEJf8bpoGR?=
 =?us-ascii?Q?FaJtLigxuoTe6QXIpRlIhItmbW0/05TxoavoswT6gMvER4gqZ3GKGgfJpWQf?=
 =?us-ascii?Q?u8fuComG4Q2ZzZ01jbKW/VTEGtMWZZBZ6KOA300yO/LSHVXZt6OEpzqF80G0?=
 =?us-ascii?Q?BjzWsD4IEMj/qMrFs3KTGO6n1kMYpnUhKBFSFlyyUGHtJiON66MebTZAKneR?=
 =?us-ascii?Q?6IXdekUYaixXB7mI9IOkE5fTT9gr8FsCDSOp8YhlOrtSr/gw07AsXTu83OBL?=
 =?us-ascii?Q?om1iF1urCufJQK8rl0U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB528465F8DBB2E1F7DF9585158B8BACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccb5e7d-5a07-47a7-bf4e-08dd8e387389
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 13:58:46.4092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZZ/saQXKnCE2b4BFOxzs3NXLqG/FZQioSCxLz4qh2YWJ0ruUBxt+L+QJYRljyVIVgGXM9iHCUSrrS0sU2+MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955
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

--_000_CH0PR12MB528465F8DBB2E1F7DF9585158B8BACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi John,

Sure, the debug print is not really necessary. We'll update it before mergi=
ng.

--

Thanks & Regards,
Aurabindo Pillai
________________________________
From: John Olender <john.olender@gmail.com>
Sent: Thursday, May 8, 2025 5:51 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wu, Ray <Ray.Wu@amd.com>;=
 Li, Sun peng (Leo) <Sunpeng.Li@amd.com>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Roman <Roman.Li@amd.com>;=
 Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@am=
d.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.c=
om>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.co=
m>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 05/14] drm/amd/display: Defer BW-optimization-blocked D=
RR adjustments

On 5/6/25 10:34 PM, Ray Wu wrote:
> From: John Olender <john.olender@gmail.com>
>
> [Why & How]
> Instead of dropping DRR updates, defer them. This fixes issues where
> monitor continues to see incorrect refresh rate after VRR was turned off
> by userspace.
>
> Fixes: 32953485c558 ("drm/amd/display: Do not update DRR while BW optimiz=
ations pending")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3546
>
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Signed-off-by: John Olender <john.olender@gmail.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>

Thank you for reviewing and revising the original patch.  This commit
message is a clear improvement over the original.

I do have a concern about the debug print clean up though.  Please see
below.

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
>  drivers/gpu/drm/amd/display/dc/core/dc.c          | 13 ++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 36c16030fca9..5a38748703b3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -374,6 +374,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
>  static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_=
state,
>                                              struct dm_crtc_state *new_st=
ate)
>  {
> +     if (new_state->stream->adjust.timing_adjust_pending)
> +             return true;
>        if (new_state->freesync_config.state =3D=3D  VRR_STATE_ACTIVE_FIXE=
D)
>                return true;
>        else if (amdgpu_dm_crtc_vrr_active(old_state) !=3D amdgpu_dm_crtc_=
vrr_active(new_state))
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 528e6fd546c5..6ec22c0d5b97 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -441,9 +441,15 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
>         * Don't adjust DRR while there's bandwidth optimizations pending =
to
>         * avoid conflicting with firmware updates.
>         */
> -     if (dc->ctx->dce_version > DCE_VERSION_MAX)
> -             if (dc->optimized_required || dc->wm_optimized_required)
> +     if (dc->ctx->dce_version > DCE_VERSION_MAX) {
> +             if (dc->optimized_required || dc->wm_optimized_required) {
> +                     if (!stream->adjust.timing_adjust_pending) {
> +                             stream->adjust.timing_adjust_pending =3D tr=
ue;
> +                             DC_LOG_DEBUG("%s: deferring DRR update\n", =
__func__);
> +                     }
>                        return false;
> +             }
> +     }

Printing the start of a string of blocked updates without also printing
the end can result in misleading debug messages.

The original patch got around this by spamming out a debug print for
every blocked update.  Not ideal, but it let me to keep the focus of the
patch on the fix itself.

If the spam from the original patch is too much and adding an end
message is too messy, please consider removing the debug message entirely.

Thanks,
John

>
>        dc_exit_ips_for_hw_access(dc);
>
> @@ -3241,7 +3247,8 @@ static void copy_stream_update_to_stream(struct dc =
*dc,
>
>        if (update->crtc_timing_adjust) {
>                if (stream->adjust.v_total_min !=3D update->crtc_timing_ad=
just->v_total_min ||
> -                     stream->adjust.v_total_max !=3D update->crtc_timing=
_adjust->v_total_max)
> +                     stream->adjust.v_total_max !=3D update->crtc_timing=
_adjust->v_total_max ||
> +                     stream->adjust.timing_adjust_pending)
>                        update->crtc_timing_adjust->timing_adjust_pending =
=3D true;
>                stream->adjust =3D *update->crtc_timing_adjust;
>                update->crtc_timing_adjust->timing_adjust_pending =3D fals=
e;


--_000_CH0PR12MB528465F8DBB2E1F7DF9585158B8BACH0PR12MB5284namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi John,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sure, the debug print is not really necessary. We'll update it before mergi=
ng.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" style=3D"color: inherit;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Aurabindo Pillai </div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> John Olender &lt;john=
.olender@gmail.com&gt;<br>
<b>Sent:</b> Thursday, May 8, 2025 5:51 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Wu, Ray &lt;=
Ray.Wu@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd.com&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Roman &lt;Ro=
man.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Chung, ChiaHsuan =
(Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Zuo, Jerry &lt;Jerry.Zuo@amd.com&gt;=
; Mohamed, Zaeem &lt;Zaeem.Mohamed@amd.com&gt;; Wheeler, Daniel &lt;Daniel.=
Wheeler@amd.com&gt;;
 Hung, Alex &lt;Alex.Hung@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;am=
d-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 05/14] drm/amd/display: Defer BW-optimization-bl=
ocked DRR adjustments</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 5/6/25 10:34 PM, Ray Wu wrote:<br>
&gt; From: John Olender &lt;john.olender@gmail.com&gt;<br>
&gt; <br>
&gt; [Why &amp; How]<br>
&gt; Instead of dropping DRR updates, defer them. This fixes issues where<b=
r>
&gt; monitor continues to see incorrect refresh rate after VRR was turned o=
ff<br>
&gt; by userspace.<br>
&gt; <br>
&gt; Fixes: 32953485c558 (&quot;drm/amd/display: Do not update DRR while BW=
 optimizations pending&quot;)<br>
&gt; Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/3546"=
>https://gitlab.freedesktop.org/drm/amd/-/issues/3546</a><br>
&gt; <br>
&gt; Reviewed-by: Sun peng Li &lt;sunpeng.li@amd.com&gt;<br>
&gt; Signed-off-by: John Olender &lt;john.olender@gmail.com&gt;<br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Signed-off-by: Ray Wu &lt;ray.wu@amd.com&gt;<br>
<br>
Thank you for reviewing and revising the original patch.&nbsp; This commit<=
br>
message is a clear improvement over the original.<br>
<br>
I do have a concern about the debug print clean up though.&nbsp; Please see=
<br>
below.<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |&nbsp; 2 ++<b=
r>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/core/dc.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 13 ++++++++++---<br>
&gt;&nbsp; 2 files changed, 12 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 36c16030fca9..5a38748703b3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -374,6 +374,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,<b=
r>
&gt;&nbsp; static inline bool is_dc_timing_adjust_needed(struct dm_crtc_sta=
te *old_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dm_crtc_state *new=
_state)<br>
&gt;&nbsp; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (new_state-&gt;stream-&gt;adjust.timing_a=
djust_pending)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_state-&gt;freesync_c=
onfig.state =3D=3D&nbsp; VRR_STATE_ACTIVE_FIXED)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (amdgpu_dm_crtc_vrr_=
active(old_state) !=3D amdgpu_dm_crtc_vrr_active(new_state))<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc.c<br>
&gt; index 528e6fd546c5..6ec22c0d5b97 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c<br>
&gt; @@ -441,9 +441,15 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't adjust DRR whi=
le there's bandwidth optimizations pending to<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * avoid conflicting wi=
th firmware updates.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_version &gt; DCE_VERS=
ION_MAX)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (dc-&gt;optimized_required || dc-&gt;wm_optimized_required)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dce_version &gt; DCE_VERS=
ION_MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (dc-&gt;optimized_required || dc-&gt;wm_optimized_required) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!stream-&gt;adjust.=
timing_adjust_pending) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;adjust.timing_adjust_pending =3D true;<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; DC_LOG_DEBUG(&quot;%s: deferring DRR update\n&quot=
;, __func__);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
Printing the start of a string of blocked updates without also printing<br>
the end can result in misleading debug messages.<br>
<br>
The original patch got around this by spamming out a debug print for<br>
every blocked update.&nbsp; Not ideal, but it let me to keep the focus of t=
he<br>
patch on the fix itself.<br>
<br>
If the spam from the original patch is too much and adding an end<br>
message is too messy, please consider removing the debug message entirely.<=
br>
<br>
Thanks,<br>
John<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_exit_ips_for_hw_access(dc=
);<br>
&gt;&nbsp; <br>
&gt; @@ -3241,7 +3247,8 @@ static void copy_stream_update_to_stream(struct =
dc *dc,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (update-&gt;crtc_timing_a=
djust) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (stream-&gt;adjust.v_total_min !=3D update-&gt;crtc_=
timing_adjust-&gt;v_total_min ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;adjust.v_tot=
al_max !=3D update-&gt;crtc_timing_adjust-&gt;v_total_max)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;adjust.v_tot=
al_max !=3D update-&gt;crtc_timing_adjust-&gt;v_total_max ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;adjust.timin=
g_adjust_pending)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update-=
&gt;crtc_timing_adjust-&gt;timing_adjust_pending =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; stream-&gt;adjust =3D *update-&gt;crtc_timing_adjust;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; update-&gt;crtc_timing_adjust-&gt;timing_adjust_pending=
 =3D false;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB528465F8DBB2E1F7DF9585158B8BACH0PR12MB5284namp_--
