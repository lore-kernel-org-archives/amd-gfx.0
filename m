Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB44C021AA
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 02:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FDA10E101;
	Thu, 20 Feb 2025 02:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EfMUSWMU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB4410E101
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 02:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3rFvkb6sTKKghxgi6n1wvvenwFOyjFRHf/e+vZcu957idcfLUQFrkRbOUVPnHhuJkXVVyr4jlsSfgXaqUk4tEx9SMMbUHYlK1TvXzH/eAD+CttazrcPTUstJwmqn30Qyoc1mL9Vn+25karg1uzlWllvxSQY2xlm8lKVpUkAgchyN9n1qILpBUpZe9QkhkVIFj2jxYKVIqN6ITIhuqBNi+p8ajOQJRoObEyA4iCsx/kQG4oGujmD9bWLuwtSdmTDpHPbnizI8j5AdwQMZ/K8IHSgIf1P6YKx8zDmD8B8nwu471eF3mWCeOdgOelfBaE9p85m0ZcQeLtzh7DIOXxJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuEZvfWIPhA4bYa/X50VE8ooKN+KrITNdgXR2Vub3U0=;
 b=sCaJ19dl3xA4GZDcDWonIHZP4wS6vfCcJE69AleoGq/fVA7teDLrqUAG+Q2vwIXrgp9hcQJ8hpLsnmDxWXWc88zyiFe8vqgL2P1wPlcO3gA31se+h1FsQZSxSMEnk5LlqZsXPhND/MyQDrD/SIxjAZYt0okAYbJ2761TSEdhY68fVAUdpXXzzzEIwfeAAEXVs4DxMPALm91WEbQsTrMUxBuGCHhkb6RaWTtayyL6L0Gf4znuBc8WdY1BiSw77PjW6F5m9G6Si6wTg9tYJlYJ4AcsPv6fcYvAwX2ICOZbXJZvUZTebEqnKVPJdK4UXhYc0r71+O/FitdeQWS2P7W8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuEZvfWIPhA4bYa/X50VE8ooKN+KrITNdgXR2Vub3U0=;
 b=EfMUSWMU2vdZlfn+hjyUF0ae5eXFiw87lycQkNX4lGWmCMpNUZCaReH8qZBoKfspYHTWY2tjbiF7cZdIdJdQ9ZpgHzEiMY6mC+adhXFKW3dbIOBbYrY/7z//HAMnOVoDX8MXfPsd7Dbg/btLmMfx7EplRU+FxZgMrWMxT03nwzU=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 02:27:55 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::eb1a:4c36:7d9d:6176%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 02:27:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct the name of mes_pipe structure
Thread-Topic: [PATCH] drm/amdgpu: correct the name of mes_pipe structure
Thread-Index: AQHbgz2ixbxs5J/rPk2/TlwRk5ijyrNPdNwggAACsOA=
Date: Thu, 20 Feb 2025 02:27:55 +0000
Message-ID: <BL1PR12MB525400B5B07A108EB836D1ACFCC42@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20250220021725.430123-1-likun.gao@amd.com>
 <DM4PR12MB518168087AD1581726911005EFC42@DM4PR12MB5181.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB518168087AD1581726911005EFC42@DM4PR12MB5181.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c74d67f4-e336-4bd0-8d32-a98fcd81bc10;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-20T02:18:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|DM3PR12MB9325:EE_
x-ms-office365-filtering-correlation-id: ca032757-36e0-4e26-f597-08dd51562f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xQjomx0s9PHvOvov0GOD77DzYUxavPJC0vyYYwdV7xBP5mZEbFrYGH2lL8dl?=
 =?us-ascii?Q?lGgSnLrODWzsUfNjRk4xu5kxxWrE4jN941Px5I3yebXbrTdpuY9hsH8rc+vM?=
 =?us-ascii?Q?XKuPL9Jm1aeUey+MldGz0ePkcgb0Ned0/4XKHzLPueLpPsw8Yn9MAwpsf/JP?=
 =?us-ascii?Q?h0Fa0ZcIVPe02a6+sGXyRM8saDefJo1QagrZfMml6LNBkzUYcVk5wdlcGHV/?=
 =?us-ascii?Q?8noBDF4e+/ZY5WfAdLgui4TFXW4e8Ddui0ux/OuDjcf4Y4lLx7oaRms2UWPb?=
 =?us-ascii?Q?Bf7/J7dzHXn8UZzWx4hPQ/V+dJ1kfru1RwrXeaB//W+NTUQEtFOLxmGCcBud?=
 =?us-ascii?Q?ad9pvtLO5+dejaEo1k7KFN8ItXzZKTG82UTzk/IQNMDlanEgyIQ8wBbIWTH9?=
 =?us-ascii?Q?BPnWj+gIf+a1oRCLCTSyNyXdj2lvofYxQG/fBr9FCXE21Yxp/35fzAGBIe60?=
 =?us-ascii?Q?2g6avUWCXHsM4u84fvCVpq7mXDBq3WTORKDbRdcnXPfB/J6x6Gl7oMLgAMkl?=
 =?us-ascii?Q?xlpofTh0LS3jUbHOsJRO+W+HcVV7Wr1WqYnqBfkm5x6mj3M/zp4kJNdktV3X?=
 =?us-ascii?Q?2yKEKn8O/Rwk4kQUYJ50joRcheHjz597IV6tZSAY7u1l9B7FM+qw4GcAEHGV?=
 =?us-ascii?Q?E6+XLtImU9CVGgVX7UEcrfEUpMr3cPvJzj1smH4EeTFKyXfo1M32wf+YRrsQ?=
 =?us-ascii?Q?Yfqz2OaEb2dujDJa7nPNxbRNz0wjZ8ORQPJ9UHcLyki5kddSR6WGu0LAYNZ+?=
 =?us-ascii?Q?E8FDfxdUu0zLnNyTqTppIQJtI28c9mxfON8g3gukKmC1e3AIH6XXC4+upxDY?=
 =?us-ascii?Q?h3JhU2TMNSufs799Q3ALP1GV/lLK6JBMC5sBuVrran3GQgMwKrRU9Jb5J+tL?=
 =?us-ascii?Q?Im8tLpH9fSB4thCUZNqOfA+heqUdbG2Iu6mXaKwGAqzJ/98BIEwyZ/QMSVT7?=
 =?us-ascii?Q?qX09E6MEgnOgWNtAkTNBVwWokortu9agieRkU/vnFnQe8y+4nGg4fQE34F/D?=
 =?us-ascii?Q?D8nnW5RaBEceWpBKXgU7UnX6DdS3A/aFZlWAidGEhUgsH17ogEU8tnKbcmBY?=
 =?us-ascii?Q?8f9/h0CTEulV8fuAqBdeGDpIquCLQp4VrMlMUKvxAWdcQZKABKM5HtXOmxqj?=
 =?us-ascii?Q?jI/0kRRcF7uKTIXCn6Jazl1sEDhYideBCN2kR3u0w41uaLNB0lwk5uocc71O?=
 =?us-ascii?Q?iucLOiBf00u5QVwOb7Amg7ll+HVZavKqMBnbqmeFlIqU6lCCw1CwVth8zeKP?=
 =?us-ascii?Q?zgOJg57c4BaGEMD4Cb+I1/99Ufd6R/f2Z9LLMoSVgN0WBYYc7H1AJueHIQWc?=
 =?us-ascii?Q?XdqrVNDtsuJcuvRfva2WqKNFzb55PPnBwWHanzdWMXj2O7yuj6ij5iWp3Dkh?=
 =?us-ascii?Q?ol8PHPA/7p5m4RTbem3g4+MTUB/KsrNL4SXXi7SaukKUgRoVOCI/jVHdEDBA?=
 =?us-ascii?Q?Kxzb8GS4zo3lbqaQ8RbjI0pG9xj6gjs5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xOiXtekkd0CrZbwGcbN/V+1J7EBRvRfw01tqFRzdl2D+ojW3rlg8uoPUP4Rs?=
 =?us-ascii?Q?7SfwwEmu9yITYeLWfyF1AOd8E5OZqe2eaklYa6zBNPxnazigYrcUoBeFmkpo?=
 =?us-ascii?Q?tL+4rk6DF6jW/AI3wyPslX+tStXII3J6fSCeRa5rMaqhokB9Y1/x9bIg3f+g?=
 =?us-ascii?Q?0RGYMycxqwS6wExcMSAgZx7FRzRfw8wM/Z9MbQeUDQJI4lNkRlCYVBOq6mfH?=
 =?us-ascii?Q?7UH3LrQMCyU877gHoMnL4tycuQy7gVxIPvb/DCwlQlmZ1lvUqT0mX67exBiJ?=
 =?us-ascii?Q?toyh3CSdIgwKoqJW+D8geO/S5g96sLIpsn90v3GgmB+KuTyVa0ffgGFYtl3R?=
 =?us-ascii?Q?8heqM4kRg/mtBbM39EsFEeyiqlHc4OIAYR3mlTQZwV/wDIkkzqLkl3vUjtSK?=
 =?us-ascii?Q?H5tkDdv1AO8cglKPhbHazgFsejgbMZEi3m8YznTd6k1K7gQ/Ziste8/ZrzFg?=
 =?us-ascii?Q?JoEDVn2CoRlx+PawkeNQOeRq7psV8nKUt0j8+VPvVC2rq0VUJq7l1mqFA7Gz?=
 =?us-ascii?Q?1SLK0SAU9xi6TjxCJ+5ZiNVZR74a79s/XiP+42+K5l7Z4dXiHZ1AqdLSWXud?=
 =?us-ascii?Q?yWxHZCfaFc2K1N6kC9JOHWzZOxDyisdTLvfCBvQ8YyzOTu4HvDN0/XNHRlRi?=
 =?us-ascii?Q?1rSes/dvxst8ruqtKaQCHgbds3k8oWhKBPwUOH9urf4L+kp4sxRrr3wivWEo?=
 =?us-ascii?Q?Qo+TagmTH4nX/DozJKYoAIrNTf55gFVXMR0HwTmsyeGELkSsSjX7lYmebQJ9?=
 =?us-ascii?Q?VbW5tHC6lVvC9Oi+2ctbphICqAzB/1QquS8bRjio3NLPhKxZkq2cSMjHAoFp?=
 =?us-ascii?Q?1JdP9iupd9IXXS5AR+vaRzGVuOx8J9eZq4RxD6RUJFx5Wsfj0jQ0/9Sx1uzp?=
 =?us-ascii?Q?5JKofQi6MGh8qpax/U9pcP3VgTZtxxoVBODzVMVYt+zhM6ooCyeMV4S32cz9?=
 =?us-ascii?Q?JljPBg4Q/Q/YAmX/2dD6dU1jdFwFEGPpt36/YQxiLqL8RUBGCyQQ/ED2exdI?=
 =?us-ascii?Q?+2HNYlUyfJe9PyRo438XLov13WNkPB0LNAy2d3YPwXVojq1NZ6SOb2fSMe4b?=
 =?us-ascii?Q?xZ7qt55M9bgSA532SHMbDI9W47Icw9EBzm9F7fR4PuzX5mb6sT2fPhaoUoEy?=
 =?us-ascii?Q?mYUKKDVKEE8njOuT9M7s/CKB3DGs23+WXgJqsF4CUo/frtftPl1Ra3MOpWRw?=
 =?us-ascii?Q?S6khElA/PQeU4Iy9l+Gh59rcWz7inno0IsHZ5ImZbKuGMVWerJiUrDxaMcSx?=
 =?us-ascii?Q?ru9kBwXeRFmQ6TW4YSXDbi/BH3BF4ZTHbglG8bnI9F5LxPNeeUjF3fgp7QYQ?=
 =?us-ascii?Q?ddJTLmRNE5lOeKbMnspA6rkxGNs8Od3wVPgi4Uw/9U5XyLwHq9GWDclsdQ14?=
 =?us-ascii?Q?z0psggbe8lzSFvZ3QUSxUhVJB9xjv8IYCf2bEkSXHJyskfPneu/F+3sRqvqQ?=
 =?us-ascii?Q?VoB30523Vt7QFmf8wao2GyagsIPePwBiBfYUFQ/ocFs62hekYG8OG/kbA0sd?=
 =?us-ascii?Q?A3w4Hz4nZD8XE/krQFi77FsAQdYUvapM7S24kUVJcG22Cbm6QD6pWHhsK/x6?=
 =?us-ascii?Q?UmgcZ3ddQDqVn7olJx0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca032757-36e0-4e26-f597-08dd51562f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 02:27:55.8022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Av2g4Ci+OIVtHlKFgh35HDfI4OqZAtCyWMshVPoU5fw4h3lCYu9FAG/ytWHdiZ1cb5Abtus3yaZ1MGp/QwWYXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Thursday, February 20, 2025 10:22
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct the name of mes_pipe structure

[AMD Official Use Only - AMD Internal Distribution Only]

From: Likun Gao <Likun.Gao@amd.com>

Correct the structure name admgpu_mes_pipe to amdgpu_mes_pipe.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-  drivers/gpu/drm/amd/amdgp=
u/mes_v11_0.c  | 14 +++++++-------  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c =
 | 14 +++++++-------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 6a792ffc81e3..044cd325a849 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -56,7 +56,7 @@ enum amdgpu_mes_priority_level {

 struct amdgpu_mes_funcs;

-enum admgpu_mes_pipe {
+enum amdgpu_mes_pipe {
        AMDGPU_MES_SCHED_PIPE =3D 0,
        AMDGPU_MES_KIQ_PIPE,
        AMDGPU_MAX_MES_PIPES =3D 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 2af9c69d4b1a..6258a4e0be0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -811,7 +811,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs =
=3D {  };

 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-                                          enum admgpu_mes_pipe pipe)
+                                          enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -846,7 +846,7 @@=
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,  }

 static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,
-                                               enum admgpu_mes_pipe pipe)
+                                               enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -887,7 +887,7 @@=
 static int mes_v11_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,  }

 static void mes_v11_0_free_ucode_buffers(struct amdgpu_device *adev,
-                                        enum admgpu_mes_pipe pipe)
+                                        enum amdgpu_mes_pipe pipe)
 {
        amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
                              &adev->mes.data_fw_gpu_addr[pipe],
@@ -985,7 +985,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)

 /* This function is for backdoor MES firmware */  static int mes_v11_0_loa=
d_microcode(struct amdgpu_device *adev,
-                                   enum admgpu_mes_pipe pipe, bool prime_i=
cache)
+                                   enum amdgpu_mes_pipe pipe, bool prime_i=
cache)
 {
        int r;
        uint32_t data;
@@ -1057,7 +1057,7 @@ static int mes_v11_0_load_microcode(struct amdgpu_dev=
ice *adev,  }

 static int mes_v11_0_allocate_eop_buf(struct amdgpu_device *adev,
-                                     enum admgpu_mes_pipe pipe)
+                                     enum amdgpu_mes_pipe pipe)
 {
        int r;
        u32 *eop;
@@ -1268,7 +1268,7 @@ static int mes_v11_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)  }

 static int mes_v11_0_queue_init(struct amdgpu_device *adev,
-                               enum admgpu_mes_pipe pipe)
+                               enum amdgpu_mes_pipe pipe)
 {
        struct amdgpu_ring *ring;
        int r;
@@ -1351,7 +1351,7 @@ static int mes_v11_0_kiq_ring_init(struct amdgpu_devi=
ce *adev)  }

 static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
-                                enum admgpu_mes_pipe pipe)
+                                enum amdgpu_mes_pipe pipe)
 {
        int r, mqd_size =3D sizeof(struct v11_compute_mqd);
        struct amdgpu_ring *ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index 042264767a44..0edd5205d970 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -910,7 +910,7 @@ static const struct amdgpu_mes_funcs mes_v12_0_funcs =
=3D {  };

 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-                                          enum admgpu_mes_pipe pipe)
+                                          enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -944,7 +944,7 @@=
 static int mes_v12_0_allocate_ucode_buffer(struct amdgpu_device *adev,  }

 static int mes_v12_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,
-                                               enum admgpu_mes_pipe pipe)
+                                               enum amdgpu_mes_pipe pipe)
 {
        int r;
        const struct mes_firmware_header_v1_0 *mes_hdr; @@ -978,7 +978,7 @@=
 static int mes_v12_0_allocate_ucode_data_buffer(struct amdgpu_device *adev=
,  }

 static void mes_v12_0_free_ucode_buffers(struct amdgpu_device *adev,
-                                        enum admgpu_mes_pipe pipe)
+                                        enum amdgpu_mes_pipe pipe)
 {
        amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
                              &adev->mes.data_fw_gpu_addr[pipe],
@@ -1084,7 +1084,7 @@ static void mes_v12_0_set_ucode_start_addr(struct amd=
gpu_device *adev)

 /* This function is for backdoor MES firmware */  static int mes_v12_0_loa=
d_microcode(struct amdgpu_device *adev,
-                                   enum admgpu_mes_pipe pipe, bool prime_i=
cache)
+                                   enum amdgpu_mes_pipe pipe, bool prime_i=
cache)
 {
        int r;
        uint32_t data;
@@ -1148,7 +1148,7 @@ static int mes_v12_0_load_microcode(struct amdgpu_dev=
ice *adev,  }

 static int mes_v12_0_allocate_eop_buf(struct amdgpu_device *adev,
-                                     enum admgpu_mes_pipe pipe)
+                                     enum amdgpu_mes_pipe pipe)
 {
        int r;
        u32 *eop;
@@ -1369,7 +1369,7 @@ static int mes_v12_0_kiq_enable_queue(struct amdgpu_d=
evice *adev)  }

 static int mes_v12_0_queue_init(struct amdgpu_device *adev,
-                               enum admgpu_mes_pipe pipe)
+                               enum amdgpu_mes_pipe pipe)
 {
        struct amdgpu_ring *ring;
        int r;
@@ -1469,7 +1469,7 @@ static int mes_v12_0_kiq_ring_init(struct amdgpu_devi=
ce *adev)  }

 static int mes_v12_0_mqd_sw_init(struct amdgpu_device *adev,
-                                enum admgpu_mes_pipe pipe)
+                                enum amdgpu_mes_pipe pipe)
 {
        int r, mqd_size =3D sizeof(struct v12_compute_mqd);
        struct amdgpu_ring *ring;
--
2.34.1


