Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4318CC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BD510EA3E;
	Tue, 14 May 2024 08:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vcw6QbHJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDF510EA61
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnBmSr0Qj4upzJlGPBSDiifv4QbgY6Q+HK3KugssXGxLFTaZBYaWZMlUPDC87cvpzHRANZuLOESkr2pageD4L8u7kBmDqWRAUJ7/6NVvrZEgxR+sZ0eaDfMr1/Cg9I4+kt8AZsNK1ckfGNu+qpNoBYmQ3Hq4qgY1Iplo6f2qCMmzj9dVv0oDjf9j46bPpuPvXOpOD6fmszE0Dxgt9CeIcnchcpWER0/QEi9QCn8cw4j7QnhybPPntgv0jHxlQdhPIUbLH05z5jw5GqyGxPySoFr4c2GdotEk/I59TkYbwDT/XRNdrQ66eZzBY7NLhhOFfZnrH78wBp16lXgnFRZ+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH/RtBS/TxZymMzd5x7o/fJFRKnEKV1UoSY66Hnii2k=;
 b=lmGSjCW/s/Zh3r8Hsne0fNgiAtV3yrivafSTDEWTpA1gcOSF5Bhg8sGIE1Sxtj0tgUoWsYOugKyu8rtc+y+q4fj8QyqZeqxanLyg2s6hUuPtnJDrRrE6h7sr+3CHaiv5UlvPdtEYZ7L2/ZD8uOmRn9oP/GEwbeuhTRp3BxPufOTsKO85TVw95zVv9c0qtlrzoSzpmYcMOuo4Piopev9Ia8rJOfj0rMJ1RzC7Jw6Bu6q0os0GV5WF3ngImXrhc9LpdKyFlZIp0uBFawxZ5l9naPn3M3EIBhuiJBX6Ti/gafJx7j/xmB7gYlbebv8e7AMG0iAZXNyNSexTY6TT52QOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH/RtBS/TxZymMzd5x7o/fJFRKnEKV1UoSY66Hnii2k=;
 b=Vcw6QbHJ7UIYDEGG+QjEb21jZU/WQa5jXN9KB7QsLpbIZOdWBacL4QHK0Oa1idP1lX00XJ8L9SQrpugyCBzDAFCWjQSqTrBZ/Izp4LYNXAL1n6LoKvKA00ioWv7HUs/FAg1Figf3z016F+UalWPs8yZNFBJtdPJW7FVbeIMqrw8=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:51:46 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:51:46 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd/amdgpu: enable mmhub and athub cg on gc 12.0.0
Thread-Topic: [PATCH 5/8] drm/amd/amdgpu: enable mmhub and athub cg on gc
 12.0.0
Thread-Index: AQHapduD7U1NwZrrVUmWpXxAhaBepLGWbCDg
Date: Tue, 14 May 2024 08:51:46 +0000
Message-ID: <DM4PR12MB518128DCA5D692E891A1FA63EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-5-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-5-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=63556a1a-0d8e-4335-9639-86c92f8b8795;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:51:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: 995727b0-3a76-4b9e-eddb-08dc73f31608
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?4d21dHZr2I1NMiV0lr5wVkzzUyTg8sbH948uLZNWXH4dQ4nXZy9l2YPdpWEu?=
 =?us-ascii?Q?0UU6er6YANuZ+BqR1IbSoacpjZ3qYuH0duKi3Vi9nagxpOVUaYV/gjM5VecY?=
 =?us-ascii?Q?rh4IKvXOWiRLGcWFLyVoTMJE7oMfH9QZXVSKbJG90DQ6lpEneFUCQNexvSHF?=
 =?us-ascii?Q?cRoLwMIncFqmDlEzlwEriYCsMTpxPlxvUyvaQxQ2Cx1sTBDwBp2oxTpcMWRS?=
 =?us-ascii?Q?H4yg2VwPXOEVp8I4BMfpuDCUemWlpCxbqFhnor4d4AGWMG+Q0cKvjAI54aNv?=
 =?us-ascii?Q?YEDGXleBk/IjL1iG4f7AeMHB/yp7iOpW/kUYrUv2R8fU4T9gAwjHPNT01Zv3?=
 =?us-ascii?Q?FbCW4150IyZL0100xsB1tI1I4sZIQSSYI4x748f59aG7FNZ/8YnnY3E9Zu5i?=
 =?us-ascii?Q?nyxldikkDuyzCctmhT/2Ugt2yrgJ0H/uzAxD3NoJsBoP6ffzXSbIIPbRKVjp?=
 =?us-ascii?Q?gYWD0xwb2Przlxm0NgyKP5mDsuqy/8f/npCAq2iJjVXOY5tC4hzN48DxHYx0?=
 =?us-ascii?Q?e+xF7rQLQLDCC+im3QkX90BunWyRfbQCkAcRfdA3yN9yPSGM3/s/TSlCE/bn?=
 =?us-ascii?Q?WmKPprL14ORzuR3cmtp81X190EuAOMMKHKVBFxK3XskmikJMrRCl+nRkgmjl?=
 =?us-ascii?Q?jVTED8a/C9n67wESj2jjhFAeD05kIH0ZGfzQpP9Dcke3lU74q1khOb9g5jEL?=
 =?us-ascii?Q?bj/wkn2ZToufi3+Wc4ppuUDipn6aagU0pEfGKU5N3epj8xQNiKQmE1xvQK4d?=
 =?us-ascii?Q?9ofX+yLVG3OeWqRRKX6xNjB1bSjHYezbXn2wCj4/eapgN3AP5aAwRLKGuJdQ?=
 =?us-ascii?Q?8q9l4Quvw6WFvfg4FVoe02gneuJajXfRKTJIUk0flEjbRPGw1p0XwhbBpoUX?=
 =?us-ascii?Q?8mNilR2b/W7n+YtFbHKy9IuRnQuTYo5aNYwTgnbbJYeR8zR41tkyembXKcyx?=
 =?us-ascii?Q?am8X/mx8bQCcP81Sof0Figu5izrvFwxTsLFOeS06DMCpN4m4NAbg4yN2H38J?=
 =?us-ascii?Q?UT5Ng94IE4QSjjQ7/7GU/xugtkHW6cG4UylRG1fQHxcot3D8hziCgzZJX0WS?=
 =?us-ascii?Q?XeG3pFvTXj0ENC9xpO27jAfVWaTbE3wWsQBQe3h+4xaX55S6i8yZ09druKaK?=
 =?us-ascii?Q?jKXhoAxteeXnqeiR5ic5DhYycNML3kmSpPOMPo4UOoWpUWpYL2CnLUAZyvTo?=
 =?us-ascii?Q?2pihl1+ERKbWel3cNbM6827mgbBhiHt7VoX5BhoLyyxzqOqSoAhcT/yx+ElD?=
 =?us-ascii?Q?nw5z94MNqwYcNShDy/64pvm99vFPEzw3nSR1PpFAOfcXKNNKDFs4lNZ4gVEn?=
 =?us-ascii?Q?B3qfy3VqdmNJOkauYEO6TCz56Y3Lieuwg1nolWS5NW9soA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uaAcRk3qdZETO7IKamt6iIO1A4uZNU+FFdQ6B9H/QNwAYTz9Zv5+8mI0BK+I?=
 =?us-ascii?Q?QMfl2t8SENOcUxQa9T06r08jN3I3ak3brUviCnF7TzpNbYVi7bSaQr3SCjnb?=
 =?us-ascii?Q?d+i/JlXtXhR5U3ZwjzHj5Jdiw+RtTKkt0bcqkhJf3EWM2xgMU1D5JzBCQbDr?=
 =?us-ascii?Q?sHF0ekIw9QbH60HMOfVW2gq22eobkuWdqxySanFZAX5y6iaXQXZShSZOyyuK?=
 =?us-ascii?Q?nHMNVdM9J+s22q1/PO4yx0BFhhejZ07NM4gdChBJDsHolQlWPs5awFijjIcl?=
 =?us-ascii?Q?cepl2TzwVQ52XE0Jlvd1oxP7B0ZG3dT4Pxz1ZD/Bdf5eQSXljuO6Ia0Lp6Sd?=
 =?us-ascii?Q?IjzJS4QPBAMZA/2IuF1jVxxQ6s9peq7o5se/+HY7hUwBhFJjgmX/UWyUU6Wp?=
 =?us-ascii?Q?DvILk/NE5CvUZGfatz2DxfV+bsAa9ITG1ylUrBspIKNWAORI7jvbTgrK/jWI?=
 =?us-ascii?Q?SyG5Ydz3C+Vcgj/nRtX92eyz/k1ZEocsBF2HwVjzjYJz4Q3kMna3B6SUhTf5?=
 =?us-ascii?Q?jRFA03MiDmulcNQYDj1viYgaXmrvkLrOP4cpOnb6946jSCu+GWGYN9ZvngxV?=
 =?us-ascii?Q?MOFL2WISa/zs0mcUj2FI+m4fye6JAFW8JAdbmLz4YDCXgEsf7mguRsaxOiOv?=
 =?us-ascii?Q?FQjTnZ6aXCLBSlTvTM9ao7wILjOsxvgENHF1h/Bsej9FgnkKemt8hMZN0ksf?=
 =?us-ascii?Q?TtEAFYISHx6HYLamv+1KPqhGWtZGZyJjfAKix8haHpes3dSDnzFxvL8aqlTw?=
 =?us-ascii?Q?JYyBOczf4tpzNVxEOEyF2x+6OfZJn3bkkaXxnj2fbW1MPaJHRzUO03Yym1a3?=
 =?us-ascii?Q?+XrlEtr+pKoaNTSsewN7jgJn2XfwOpl0j5UbT9QNn9an5JOD5apCmBnEsHDG?=
 =?us-ascii?Q?rRXK9iJ71XW2bQx8qADjk5fvNeE8A4cktS72S4d8hvifztPPYfYHkcgd5cog?=
 =?us-ascii?Q?bCNNTzQH+Qye3l7sb00GGhsscqB1CkvMTTEQ2VWen6Sc5OYOdnZyr1bkr5PS?=
 =?us-ascii?Q?kbvDNgw7ArPeoyzTBMYjlEoMu+/5ZiLyDvfno/zBESVpdj76OgwXijiWHVpC?=
 =?us-ascii?Q?XjvqmfEQufPciooTgKOWjfhtmPHu20846kLembq6IsI8cO+ePvgyGvI8SuD3?=
 =?us-ascii?Q?vnPoDbDg1JjPjurKGGdFOnPQq3wjlpuyzvhOt+q1uTA1NouzehfRdlKOHF/Z?=
 =?us-ascii?Q?xLpbr7HfMmVrSVMSayKk7xft3C4nwlZSTfKlGPV4yJ2wBRYVki2L0Hkq+BeD?=
 =?us-ascii?Q?Lv/Y5Px1tGoXHbeJWnnSh1PsOkMdF+WL01EanVzGYdqyUgnAwdCLhBmyuiPu?=
 =?us-ascii?Q?PRXidPyygsPqJzUZ+CfKQ9bibiW3h+Izj/WMnVxaZvVZpYsY6T7zVfxDsOXR?=
 =?us-ascii?Q?Tu7+ewswTMpIuicUl6IA+Deg5Z2yFx9kv63+suzxUhBPHriT4n6Sv+pILEUf?=
 =?us-ascii?Q?ESGS0Bz5ayB36rfVzH2pZucVBHRHh+1Z8hppDEad9gFitAYbSUs2QICOmBHy?=
 =?us-ascii?Q?lVr0Y9DmTNoNnB8OgW/NPj6fDoziAttfQIndQwWdJQbGwtIWD/XcIHfaHJYp?=
 =?us-ascii?Q?mo3QOHqcEsMSWThd4Ko=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995727b0-3a76-4b9e-eddb-08dc73f31608
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:51:46.3276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bJ7tSu6g9dWIH6bGsartW5sNrHA39w4TlWNhL5Bm0vzZDmZbraiJTRKxCGxNR3o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Likun Gao <Likun.Gao@amd.com>

Enable mmhub and athub cg on gc 12.0.0

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index e91da2d986da..b2b9e0f83bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -404,7 +404,11 @@ static int soc24_common_early_init(void *handle)
                        AMD_CG_SUPPORT_GFX_3D_CGLS |
                        AMD_CG_SUPPORT_REPEATER_FGCG |
                        AMD_CG_SUPPORT_GFX_FGCG |
-                       AMD_CG_SUPPORT_GFX_PERF_CLK;
+                       AMD_CG_SUPPORT_GFX_PERF_CLK |
+                       AMD_CG_SUPPORT_ATHUB_MGCG |
+                       AMD_CG_SUPPORT_ATHUB_LS |
+                       AMD_CG_SUPPORT_MC_MGCG |
+                       AMD_CG_SUPPORT_MC_LS;
                adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
                        AMD_PG_SUPPORT_JPEG;
                adev->external_rev_id =3D adev->rev_id + 0x40;
--
2.34.1

