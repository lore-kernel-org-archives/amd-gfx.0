Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FDA105F7A6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 14:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2374910EC68;
	Fri, 13 Mar 2026 14:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dQnVrh5E";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AD910EC68
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 14:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoSc2tzrnqtVL7tjtsjN24V8M7QOQ1a93zOJQCVNVPKJFu/fKC2qKtFhr1hQoePzASnx21eb1ihBgbGmu+XKpSHL1LUEqsWaHtPmWcodvIqi4X8JpGQiO17XInUQiZAk6gs0mUNMqr+y7h2UReYhqZngQCFw/hbczInDsuDoNFj/Gc1qL5F1jQ9KvquWH0u1F9vVRW16gDxs8AyF2toaT0yw7yF5sr1qpbItmcQvawVOW4O5m1ORMoxaawGvG/s0nZ3ib6xxxsujhiLH/gG+OiNM7KWzb6k5HQlGVzxQkr3MRhPxfBOGxTg70j4H2gimk2X7xtv8r2RCwuyP1D2EMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n76GkaXibg+DG+a8R5/kBNLHSVm2GisC/8NKoIjX1hk=;
 b=vWgQQpoaWdxHYQ17Jb2AyDL+2r/xMSvhhg9YbLT6NsAo1II6p1m6NXpcAfsLbj7EVeVYD2ougurXuviA1IIRizhtdzwQ4f+o4ZMv7KsbDnE1UNsBf2X5WuUPcjwFYFczI7y0jEnJEkNPW8/JTuGSz439eKZ8PNzBBvYZFaUOb5JiXsxSVZVsGcHJZSyBumuoqi7S6V4Tiw6mgJuzGt/1llBVkriZrLXt8U6RAz2m81g8e6bDVnIwmCaUdsqrbVAIlo0H2lHvF0rbFwhnIAGr6skPL/Z7Zd2HyIvtvAV7mrT0JGiM0+Lygl9SMSJbtrNj+jBygBhU8x5moZFSj2EDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n76GkaXibg+DG+a8R5/kBNLHSVm2GisC/8NKoIjX1hk=;
 b=dQnVrh5Ens5k1TRd0OSEhmouXentvzAbOPf4Akf8OA2jR6vIE0jWbfK87bHMLYuri9qvXP/yAqlWfVVyFRLcKZ9AtEzvNlRyrRxpX//o0mCUWQcVWn9PK2cNi3yHr8M7dsAnODSBsErbWw475mp/7gjQnoJuMjQVFAyFm9JySa0=
Received: from DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 14:27:36 +0000
Received: from DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::fda:ada6:cb9f:85d9]) by DS0PR12MB8813.namprd12.prod.outlook.com
 ([fe80::fda:ada6:cb9f:85d9%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 14:27:36 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Pan, Ellen" <Yunru.Pan@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Remove dead negative offset check in
 amdgpu_virt_init_critical_region()
Thread-Topic: [PATCH] drm/amdgpu: Remove dead negative offset check in
 amdgpu_virt_init_critical_region()
Thread-Index: AQHcsiOwJ4AEMraPOkuN21Hu3MiCprWshnm8
Date: Fri, 13 Mar 2026 14:27:36 +0000
Message-ID: <DS0PR12MB88139C1681DD03A4C00EFEA1F445A@DS0PR12MB8813.namprd12.prod.outlook.com>
References: <20260312132456.1839323-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260312132456.1839323-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-13T14:27:35.840Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8813:EE_|MN2PR12MB4336:EE_
x-ms-office365-filtering-correlation-id: a99b1c03-3a31-41db-941a-08de810cac6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700021|7053199007|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 20zkeVaNGXAMCHh8XLTv7mEG0HoFyHMTcBOWSAZgUbjdq2/isIhq31eImPZqmeoZn99NPFzn9pO0Esr1ixAeciTcXPlTDLK9R0RB+f7HdR6SeLMD7R6/nF0b7c0LT/v8oRPluW3sytIYtdyhyJJnyHUNSila4kQ/AX2iVcbRnVuyILdvE8hBsquHwvoxXykGAdxWnUapPD9iuXoGEUFqMCC2Qv7EysKDUTUax2JfeKtg1oRgPQf6QX3PmbzxriG2WecrmFt5AXXdTkFnuQMehf940vhdhbjm82iHzlQdG+sZqfi11KoXFydkfeThOK6GQZQsxTaE+CZl21m6c6XVo42OFQRniwt4UC0RnesIS9pA/T0zAK5yRRHmn0+cU/gq2vyYg5uafE6Jw2UWT5M4m9Es+m8swh1RK8KYPt2HFr1asS1OlxRBilMhwbWi7W6bU/teycTjfdIzwBeNi+QstRN25jmqfK77G4ITS9jT41UjRHPiG2vymNLpygDGlLjrkLZExzESPQaPrbzeYrzdsri71KjCxgMWfhoYySbsbPIcDrkZ/AphXzF5rLIM7TKLHJxXdCqGpmW+X4KwG1H5c1A0sFdZTYD3q2hf4K+iRRudM45wUB3rfKIolGdpHJaq2IZkPIbXZ7QTRurxE2+YhP2lChCTQ8R8knZNYbYfOwx9KqUqqVvp/74y2nT+9agcyuRG6eJ5OkH7jXWlEV2jqwvV4HgV5peZyuPWoTqYvGDF9BqvMFWId4DttpIw5k+dNPrWNKy0gt8TUfYN7j54b8HzNuxeVCEvlODkqoTu2cM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8813.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HouX1HCXmZ0mvThz8EFt7xgcMCb+fscRwpcjrHJJAIC6+PI8wiCyAA9aIB?=
 =?iso-8859-1?Q?ewnr7rPtFHHTW21EPRf8z6ilkCIsBDUqoFQxn5DQug0RSWbneLL6twWfRN?=
 =?iso-8859-1?Q?x9B0dMUfsgLCKuzzKbssZHp18GdYdQRQlL9f7Ngw6nC91ax+0kIK+l9WdL?=
 =?iso-8859-1?Q?Mtc5IabGjXKOtP1c/YhluQZ8sbq9DcnIxMbX+a/4JvwDQubQwQkFbdk0JL?=
 =?iso-8859-1?Q?ClOanvtqe7i/KlV3wDIkEx/rt0QHz/bCZ5znaOfhgx2eFFmE4zChbYOic8?=
 =?iso-8859-1?Q?SqJ+1JgcqEDTbx38OcP+utPPWxV3bNHjFezCKCBdySL5/PAnTxmhW7TtQP?=
 =?iso-8859-1?Q?uDTQcE5OKP36pwENEbDqhzm0d4I/Eh5KYYGNw6lwcmoX5uTn8I4e58J+2W?=
 =?iso-8859-1?Q?CC105d1lYzYQsu0RS2LU4gQ7EBEbxNwVcfkFH+0H8v59IwvYHTtsJzqcfN?=
 =?iso-8859-1?Q?FAZ65sdLqXW/7xwdF7gRAgZyO1NOaDFb+pl96OhqDQZiyxLFxm3MYAODOS?=
 =?iso-8859-1?Q?AGrv9XqeH8fkB0W+N0NA5I0YhReDGVfIMIvqqf7bxZ9RuRdQyy4ymRFaew?=
 =?iso-8859-1?Q?7Wq5vr3Z54G5ieCsPkWjesXUCNOvK6va0CKZ8ucuBp6PKh51ERLKGlUKa9?=
 =?iso-8859-1?Q?ItLiT7jAOaMcAib3L4vQd/W3V9qB26ZUK7OVp/lA3Z5il8uZtfT07LugvS?=
 =?iso-8859-1?Q?9nkIHoIRfBj3sKWrQVno+/wwkSToyqPvJ4QoFVrHbpYQBpt/EJT3J9fC80?=
 =?iso-8859-1?Q?SIzG2/GqZa5BmCKzaakLVJBYEyN9sBiSVlFvtWhKcC6i2pJof8Fey9j2/e?=
 =?iso-8859-1?Q?s6MlAg/THDNL58Yu6ilobdwzeQid0WViw+/mEQyFQ3O1snp8rMv/zCQPRL?=
 =?iso-8859-1?Q?NAf9PrcS5eUaY5hqvXd6hpVBLR4u0FexvW1mXp5I5w8yvoS29wyoLE/IWd?=
 =?iso-8859-1?Q?XFt0U58ZUPig7ScbIjJUh2yTH08P6pS/r5QOtaHfEdIiD+u4gg/wKipnm7?=
 =?iso-8859-1?Q?s17pZcjBHlF297LSxO9dEvKVC2MlbGq95kDpEiNYKRCdoutZBzBn74GM0c?=
 =?iso-8859-1?Q?A+XYYsz9vQgxI6mfEMbyrFgbSi9+dTNAD3jEA6cT5F50Jr6A+T8oIkQoID?=
 =?iso-8859-1?Q?Yx1YgBVkFFDlVXgDF8FZhqB4+1oiZZ4E25eKGnlEM/O0+9hk5NcxU6EUGS?=
 =?iso-8859-1?Q?9w4LP9V0u8oxDT3gyZc1t4G0J7Kcrw5CQkzWj1qqCc0Li6cxWungrKyD2c?=
 =?iso-8859-1?Q?oy+YltV0yUGh56ZIsafXbuR23X2O1a2MQrbwdnkZhbWiWi4I67VAl1V0Qg?=
 =?iso-8859-1?Q?jUCkDtiLligtrl1Kl6Jo3ZDdr3I/VpfqqAwlzd2mT2Cchmu9GP2VzTubsd?=
 =?iso-8859-1?Q?H+irVg6LDGz6kpi91e3UJdOsTdcMPUZC05UZhFnV+dkcU9kLN3MkFnwDa3?=
 =?iso-8859-1?Q?7dZW099ENtXDybZjkZk6ySztz77U/ktYsRwRHkV52DEW22Me+2dRnyMmCE?=
 =?iso-8859-1?Q?KZ7N4IhBE3NhI6GUr83GjnBZgzZy1ViD+oVSQnmdrKzUfLG6u+lsRZzCtL?=
 =?iso-8859-1?Q?rPQGog22zSLP5NZMX3/y0+dE274+AMdFEUhK+ZB1ehTkVUHR03YSBKwA6C?=
 =?iso-8859-1?Q?xLL1pUGeVHRif1FnTPmxGIiZF5Xrpk7pj1tNsDf4K6gTNCWV0IZk09hVAR?=
 =?iso-8859-1?Q?gCQwfGqimUtg8AmV2yQrcJ6K6GT+RHAjnxz18Bil0z180rYzDQDtk3OFsM?=
 =?iso-8859-1?Q?gQwzSA5V//nw9lux+DxyqvR4BOlnlljiljb27YmS9I7xP6?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR12MB88139C1681DD03A4C00EFEA1F445ADS0PR12MB8813namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8813.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99b1c03-3a31-41db-941a-08de810cac6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 14:27:36.5312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4WxdAoQOFTlJf2g7QelexwTgYhfwUESEgaw0JOkmaMwnX9snwqs2pvxiuiH9x6F6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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

--_000_DS0PR12MB88139C1681DD03A4C00EFEA1F445ADS0PR12MB8813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by:  Bokun Zhang <bokun.zhang@amd.com>


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Srinivas=
an Shanmugam <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Thursday, March 12, 2026 9:24 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter <dan.carpenter@=
linaro.org>; Pan, Ellen <Yunru.Pan@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.co=
m>
Subject: [PATCH] drm/amdgpu: Remove dead negative offset check in amdgpu_vi=
rt_init_critical_region()

amdgpu_virt_init_critical_region() stores init_hdr_offset as u64.
The subsequent check for init_hdr_offset < 0 is therefore always false.

Drop the unreachable validation and rely on the existing
check_add_overflow() and VRAM end bounds check for offset validation.

This resolves the Smatch warning about comparing an unsigned value
against zero.

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:953 amdgpu_virt_init_critical_regi=
on() warn: unsigned 'init_hdr_offset' is never less than zero.

Fixes: 07009df6494d ("drm/amdgpu: Introduce SRIOV critical regions v2 durin=
g VF init")
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ellen Pan <yunru.pan@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=F6nig <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f01f38509108..07f0f17bad49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -950,11 +950,6 @@ int amdgpu_virt_init_critical_region(struct amdgpu_dev=
ice *adev)
         if (adev->virt.req_init_data_ver !=3D GPU_CRIT_REGION_V2)
                 return 0;

-       if (init_hdr_offset < 0) {
-               dev_err(adev->dev, "Invalid init header offset\n");
-               return -EINVAL;
-       }
-
         vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
         if (!vram_size || vram_size =3D=3D U32_MAX)
                 return -EINVAL;
--
2.34.1


--_000_DS0PR12MB88139C1681DD03A4C00EFEA1F445ADS0PR12MB8813namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
Reviewed-by:&nbsp; Bokun Zhang &lt;bokun.zhang@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on =
behalf of Srinivasan Shanmugam &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, March 12, 2026 9:24 AM<br>
<b>To:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Dan C=
arpenter &lt;dan.carpenter@linaro.org&gt;; Pan, Ellen &lt;Yunru.Pan@amd.com=
&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] drm/amdgpu: Remove dead negative offset check =
in amdgpu_virt_init_critical_region()
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">amdgpu_virt_init_critical_region() stores i=
nit_hdr_offset as u64.<br>
The subsequent check for init_hdr_offset &lt; 0 is therefore always false.<=
br>
<br>
Drop the unreachable validation and rely on the existing<br>
check_add_overflow() and VRAM end bounds check for offset validation.<br>
<br>
This resolves the Smatch warning about comparing an unsigned value<br>
against zero.<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:953 amdgpu_virt_init_critical_regi=
on() warn: unsigned 'init_hdr_offset' is never less than zero.<br>
<br>
Fixes: 07009df6494d (&quot;drm/amdgpu: Introduce SRIOV critical regions v2 =
during VF init&quot;)<br>
Cc: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Cc: Ellen Pan &lt;yunru.pan@amd.com&gt;<br>
Cc: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index f01f38509108..07f0f17bad49 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -950,11 +950,6 @@ int amdgpu_virt_init_critical_region(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;virt.req_init=
_data_ver !=3D GPU_CRIT_REGION_V2)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (init_hdr_offset &lt; 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Invalid init header offset\n&quot;);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_size =3D RREG32(mmRCC=
_CONFIG_MEMSIZE);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vram_size || vram_siz=
e =3D=3D U32_MAX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_DS0PR12MB88139C1681DD03A4C00EFEA1F445ADS0PR12MB8813namp_--
