Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDC8C61DBD
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 18:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0DBB10E12B;
	Tue, 25 Aug 2026 18:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYZXsI3o";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0744910E12B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 18:35:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck3vOUpXRx3KWAAeEsF2RuiNDitKbFuHLYJqs+Fotow5wH6KHmnaIe7/WPjlGSfujcs+ci35BUuTGoykhGGArRC9ff60DmOVaqk1ZEAOdgaS2GuByhezelImTfd7vvtZqM/JHVfnDwD3/txUxCDzIan2HYxAQ4QlzE8E/BTVNqNaWW3rtbPbq1BOKqub4z/HCmjuHHSR13TeUOYENz8q+ld4KORCRdXaHfuZNNzgJeMZbsTDJNcW3ygpdwSWv04G/dL3b0dVyV4LiNpA1YhMNEYfBxx5tsuhfTJleeDQ1XJrl+iD3gCZ7DOGq6F+a6axqP4z2eyCgcb/KM6PvIlZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf3LZELNj7LW6CKxj5WghH7LnAIY4U4admGAtTQazH0=;
 b=cu8c/FdH03RSbDGYa3DBZDnastzVCUPMnBE4gBaOwWjRhyHDU631LkM9k5DG0GIDIQAB0TBxy0/o1uo+pRkpbBS8RKTQ51zzmZqwICsl9/Lmmu5Mr8veI6l84HswyE7rVLu/6TqWfe51sVLG2kOqcT4BSAU1AHGyXdFQfVUkcNtRitfnA/W6x5B7wi/9zoNQG/tGDAbhnx+rFRJabp7TLe8B8koxJnGaAAMALesbuBUBetjAQ/bAISCkpxAqWfYrCg4K1+8M1+dtyElpSYCKh2WDpmeUMSrjwvRTdURMBaEWoRa5j/cRqSd1Sk3TMiEFTkha44US6lEP0v5ZiJvNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf3LZELNj7LW6CKxj5WghH7LnAIY4U4admGAtTQazH0=;
 b=FYZXsI3oz4akmC7OuswwYvLMaH699P9pSW3djWe3VEkKyeVKYgbG5Eo4jfZvJ6WihwjviZrzpJcG95i7SxKKe9HuCksskPkd6H3g/xl5IB8yN4jQHjwkijVsD1LhC/dEXpCuFV3EooTfA02oKqmoCfk9aAKauVqsIokO2W5IWWA=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 18:35:06 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 18:35:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: use hyphens in TLB fence driver and timeline
 names
Thread-Topic: [PATCH] drm/amdgpu: use hyphens in TLB fence driver and timeline
 names
Thread-Index: AQHdNGnsPhSK7NU9BkiUWKtULC7cJLavGAFa
Date: Tue, 25 Aug 2026 18:35:06 +0000
Message-ID: <CH0PR12MB51392B112852ECDB641FC03AF7AF2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20260825081528.496730-1-Prike.Liang@amd.com>
In-Reply-To: <20260825081528.496730-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-25T18:35:05.909Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|MN0PR12MB5932:EE_
x-ms-office365-filtering-correlation-id: d5e8f7f2-dbcb-4c98-9cdb-08df02d795a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|8096899003|38070700021;
x-microsoft-antispam-message-info: sn/0qqXZIEeSB8E2ODYnoiI0zya8y+QMzfNbtpr15CSWVUtQjGA2EhXSv4PPuiETmgStLTBIanR0pWNAMchlRGeaOLhl/lfWqE/O3HxnDRKpdpPjbJjxxpdSvRmFAx6iboLVVR7EvENWGGS3xghImxBPhVpGjDOTxPPx+29zws1CjpJjsKTNlHVU18yE0uIfzj8bMCUlqzbfkmODg8Enploo8psH1zX0Xdffm5vO2ZwRTvByaAWTUrzjQjrRAZh2y/w6bzB36iutrN2XqINMZgw2y1cEXMrfmoUHUUiVo8og8l+R+Kldw+BqIIWEEqRj8h2VSRs8LGPWJYtGnwSVJC5BMyAJVSiDX0oTnSpPiYcMkPSNUHFvLyNeTVduRoV7abq2lR0VWckQ42edyi5oxolnRqeAOmeIqNUXpb5LsOR0yjrWYI3Q1VJJcHqNOKcNNBkcRRqCw2xd+p2H08dQwp2JW1R/OzgUj2QjxGD4GmHoDno1pcXr7kb0eiun+eR2aThfsTJG4Oa/pVs+ztNjbnmnzHXUuxl8cB7JEM+jM9barlgEhkabFeg/MXYUxXiXGo3Vk2evmUe2VRQPBvc40LFavAzO0zSTgbSuhpPB84ykxn2eg+5MDX3DKpA9HT6qcraMeb2jKGuN1342dVv/rseDKG29Gn22mXWX9OhcZRwdjaegpwPfFkMIa0vrxaic6Rsw0BMN+EDzObVnJ1qlMmBZLtfrwz3dFeZwu0mVeYI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cDfmbh2IAldcZCFzZb/xOwITrjl70C/cyEeqKqdGqnLO6i0qNbTQI3jUzigB?=
 =?us-ascii?Q?OhzyoodcUs+KoeGmmn0PNoNAqJaSuvvrLrkW4ajeFM7m3W1kTfQoBrUWM0fB?=
 =?us-ascii?Q?oLvRzR+cww9+4TLZ5a69p2riEnJts+pYdoLdVe0Ne0UZTz/cPhfR2cCdrRZA?=
 =?us-ascii?Q?1tfMowXT1WIWdrhRPa/GOgatuh0M+X1G5V68eEBbvVcgqY4m0v6xXg5hXSeV?=
 =?us-ascii?Q?SIdgqXyLOp8sRPjbEv2w1zdbCkweuD0DnxzGD3RBXCHs5A2R9w9BYZVxew0L?=
 =?us-ascii?Q?ExU7rXXow1Zr2aeAfPirKRziuy01hJ3bagPhklP5tmlb+ui0IZtFs1VQXs3Q?=
 =?us-ascii?Q?+3/aY+ywcpxENzUZnb17QN4NS1rAAfaWmyGRtn+I83/qQJRGvv1nKVdr6Vtt?=
 =?us-ascii?Q?IwHv3Dr8hR5PUMx33gd1bpWkXNpcTLs5ehcimhTYSOklMkeWbfUh4HoDysRE?=
 =?us-ascii?Q?zIE9uSWV6gNRe6NBFDpnhea50fZLR0KPPMXcGdtvcns6432JAPD6wvis1e/d?=
 =?us-ascii?Q?BewDvk9QG2f+7gQdXSgJ8qsafh6eDrBADW/Rwqo0SDJTeXZcNY8g+JhCHkJP?=
 =?us-ascii?Q?5NS8jCF1FMke09GBQxv6Is1KzIMIfg+z9wisat6/t8NYlN3zMPn+YbaL941T?=
 =?us-ascii?Q?f0fQnmg2aKwkUyuHB1n4uZTSrU4Ys2YBpZbgRef/8IM9n88UTIUwHtuv5EvD?=
 =?us-ascii?Q?Dy8uQI2d0cC8/4EnsNToVCTz9XOeHgzaUDhSu6BuPOHdcRT4vaGzDAlrKuYv?=
 =?us-ascii?Q?vVuV1ycCFG3Z0A/Upz19DU4UdANkZNwR58WhBljkSp+hC4DZmUlRVwJ63TSE?=
 =?us-ascii?Q?SqaHQB2j/Bvytv32+SqwGkaP1yJSMB4Ce5HOyzLiA0RTVV55Zxdx8IPbTwuY?=
 =?us-ascii?Q?mieG4zzBVx5HQUhlhtCnmjCDNcfMiQpiGlMOZj/du33mYGZdOGbsJo8399LY?=
 =?us-ascii?Q?ntpdOZlWgvCj2jom+GfxvGH1NaKf2cOBDvP1+bsHIgaVTEST5u35FfVTliCm?=
 =?us-ascii?Q?aGYQ8eM9kpCg2bk6UHq7Q+L15K8+ORuB+wrJvSzfRPdNPYYO04z64MLUSkPV?=
 =?us-ascii?Q?a+G3MVKwDmH/nZzbnwK/FeVsWIKB0fLCxkuy8Sx1BEQPrKYXpeXRwdVKX+QT?=
 =?us-ascii?Q?vLDd3F2W3UDyChqrm98Wo753ySaSI+MIl5kXBHOT7WITUUbbp1v7cXs5yCbF?=
 =?us-ascii?Q?hTdH4Y+4uX+wRcDRJ48fqALuiQ1gTsDcF6Qis34d8zHYObCpZKNkv4Lwr8Za?=
 =?us-ascii?Q?ZRPn4Yh5W4y0AF34/lvofgD885n8lda2i/OXEU4Of1Unfzu5+q4Nd1R/OCIF?=
 =?us-ascii?Q?g2qMUrqBvqywXLFvMnoMUGuajMI/YAsOkXA1DeQOPH9EsoovHtWY0o2VvPfe?=
 =?us-ascii?Q?tchuyIofe/Muhh3xOuYUxQ0NoSbmYxC+g30Q92ecT40X2rGPB+pKIe1EyCpl?=
 =?us-ascii?Q?wiw6FPAkEsswizlzNhZH1xmvJN7WUqooeKw4Nz+Zs7oPR/xNGQW5xRIyuHao?=
 =?us-ascii?Q?TVMO/W42zbmPua9bPGXaDx1JA6vDSSuZjvAEqjXwnH6DjWsJYCBrc3Zrm0zf?=
 =?us-ascii?Q?FiT9LJfNBCzNGfwrZ+6c5wbsqu9LsI8dKFcm1/ZotT/4uGfQhKHr8OLg3o2z?=
 =?us-ascii?Q?wa/oE/DEWGWyVVdYUP6prjchUxOZcY+3H1RfqmECyext5IGNr85owMGyKpTr?=
 =?us-ascii?Q?NnEPqbS6BTP9bR69HAySbYO735Il9/oa0k3Z1FeaKlUYqt5o?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB51392B112852ECDB641FC03AF7AF2CH0PR12MB5139namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e8f7f2-dbcb-4c98-9cdb-08df02d795a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 18:35:06.1106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNqWtiZ7Xe2AsONkOOnfrpc8QtYJpr91bcwYuXdtZe5ts1sbCAu/xL8gZ9rCaJu0inKP3UP8xBTnheFZ8/vbEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

--_000_CH0PR12MB51392B112852ECDB641FC03AF7AF2CH0PR12MB5139namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, August 25, 2026 4:15 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Liang, Prike <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: use hyphens in TLB fence driver and timeline n=
ames

Replace spaces with hyphens in amdgpu_tlb_fence_get_driver_name() and
amdgpu_tlb_fence_get_timeline_name(). Returning string literals with
spaces makes ftrace fence events and debugfs fence entries visually
ambiguous and harder to parse using standard log analysis tools.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 82b8badde453..b0002c898386 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -40,12 +40,12 @@ struct amdgpu_tlb_fence {

 static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence *fenc=
e)
 {
-       return "amdgpu tlb fence";
+       return "amdgpu_tlb_fence";
 }

 static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fence *f)
 {
-       return "amdgpu tlb timeline";
+       return "amdgpu_tlb_timeline";
 }

 static void amdgpu_tlb_fence_work(struct work_struct *work)
--
2.34.1


--_000_CH0PR12MB51392B112852ECDB641FC03AF7AF2CH0PR12MB5139namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 25, 2026 4:15 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Liang, Prike &lt;Prike.Liang@amd.=
com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: use hyphens in TLB fence driver and tim=
eline names</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Replace spaces with hyphens in amdgpu_tlb_fence_ge=
t_driver_name() and<br>
amdgpu_tlb_fence_get_timeline_name(). Returning string literals with<br>
spaces makes ftrace fence events and debugfs fence entries visually<br>
ambiguous and harder to parse using standard log analysis tools.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c | 4 ++--<br>
&nbsp;1 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c<br>
index 82b8badde453..b0002c898386 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c<br>
@@ -40,12 +40,12 @@ struct amdgpu_tlb_fence {<br>
&nbsp;<br>
&nbsp;static const char *amdgpu_tlb_fence_get_driver_name(struct dma_fence =
*fence)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;amdgpu tlb fence&quot;;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;amdgpu_tlb_fence&quot;;<=
br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const char *amdgpu_tlb_fence_get_timeline_name(struct dma_fenc=
e *f)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;amdgpu tlb timeline&quot=
;;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &quot;amdgpu_tlb_timeline&quot=
;;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_tlb_fence_work(struct work_struct *work)<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB51392B112852ECDB641FC03AF7AF2CH0PR12MB5139namp_--
