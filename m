Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE2CCD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C949511211F;
	Fri, 29 May 2026 15:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndQZH19Q";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010001.outbound.protection.outlook.com [52.101.56.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB85B11211F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbBcxie5n2teCH1G5IvRckYtVVz9Jph1tHpNt3nOEY3qVGTqAifWlihdn99ZeFiZG6Q4WFqj5GNRsM6OaE+n4V+Yu+PH9Gf0YrMWNEQqA+d/Vb3KaCNKTodw//wuMVBs5RrWFtYb61JghkIi4l1FWNdkUPBRYDRJkrDoRf18qnTzrf6UXXNIxbyeDYeWQpyrhBvKTM+q4/mXvUgmgRmQfTnRLotJriNKvGIfy9kx/vrCC5nu4ev9X77Y2slr8hTd0m0qOCYVCiUPhA3abWm65wfYu3EbYPeJS0N5jCbCEzFrEbcYgSxCteCzqqU0ubJUVtJzePh9L2ZQPLHtLL994Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG9Hw3Ljw5UwQCi4yYieuy9SxG7TBUY84Nj2GukZyDY=;
 b=r61a5bW9ZnHVtFXd/fc3yUPcLxSUICmuYU8j3PvOrmiVk7b6q+jxUM5VM1lYVsSNdxV9Z6AZR9f84kty9xkGNbXUfsoqX9eFzRuR/Ez03mnG4HoCBTsdEzIsAabs3bIlm4/qngl0QYgnDrFTnC7k6gWpc63i46BQbMEofNoeCH4PFabDQpK/1fx9/t6koIYL+jvNx24+kFWZhWs8gH3IjzHOgOxYeqgnUSSxHTeLXYUd2tj5JIDd9jCl18WrihyvA6aWhHZUXCSRNy2r0jrv9nojQi/0k31Kim0Nx1qMqeKdEJEIEU3pdSRRVvnqeUf6ArSNZZvMbWuJ+ilZneZAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG9Hw3Ljw5UwQCi4yYieuy9SxG7TBUY84Nj2GukZyDY=;
 b=ndQZH19Q3SiFkoqmFyX5knRx/fkcQ95gO+RHH+8sUiCXF3Qwcyj+MUo66CtbDgLkROV4p13wXT3zC9fCyp+r9YOo+ITJlexjW7PsAB9oIviNp9ecybnjPLpsY417CJnV1NtgkdnNaddCSF3cPlwWVI/d+eNO1TEhxTxQgN1ILxs=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by LV0PR12MB999067.namprd12.prod.outlook.com (2603:10b6:408:32d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 15:36:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::f3be:26ac:e6fd:16da%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 15:36:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
CC: "Chen, Michael" <Michael.Chen@amd.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for
 legacy queues on unified MES
Thread-Topic: [PATCH 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for
 legacy queues on unified MES
Thread-Index: AQHc6YD8kDbRmhO180GGwEzyumvrybYlLrHw
Date: Fri, 29 May 2026 15:36:02 +0000
Message-ID: <CH0PR12MB537258E1F648A63DF404ADA9F4162@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-13-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-13-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T15:33:49.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|LV0PR12MB999067:EE_
x-ms-office365-filtering-correlation-id: 1065c93c-786e-471f-c5a8-08debd97fdc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|921020|4143699003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: AKoeBTpF7c60Ey7ycTY1iJgSEL1ljpNDpK/QkfYmSEh/GZNEc6VXzJiKhsl1Rph4YE1f3m7gNkp3u7+/+ZrbDbj4DT5LxogBhu1891tM38PS7VcoI74ZgFsAH+VoQ7O+Khlngs7CSrbNUHVxRoGQKEsUoRNdWoqY3CqUfYxN+TYIjsN3ZpDWBFqSZ6YD+HNW7s9JD1siOyTTrKjezjsPGIkF8CWAUd8vLUMN6PeV4+ZnDjcBewVc6ugF8P1f3NW8h/z7mEbnR2Ks9clkdUfRM4lgnY990q87JynM2atpml5Fc1OxdVbinuZ5uyAA+8t9jjWOOgtXoSkqz/DlzGulwY/ep9IWq5dYAHI5PPOksexNrxXO27A9zZz+p1f1ED4Mb5QI4v0CmT7ORERZeG2ojb4/kmEDVhu7/woxiSvt6U8gZymAx7fyi5MrKDmCcpFPTuaBrI7QckuzugtjjcFUgHSGJY/BUT5SG08TLm6nP4ynT64lSl9dDvXeCEbThfV6vog0+DYDKX6Dou1X9i6/NUbSWKyh5yuucCyZC9Uc32OgRezPnVkEtNRBRZzB/d7EIXw5QSFKyHTwgDKfKsRkuO4LW7Jfhorbr1UBFNLPu8lETuEgTy0YQvsZjrZ6NJIB1rc4iTCtvCrIGBe4ZqF43OIFg/PkJS7kcvUGewvxNdxAzKUX+peXsjOHq8FqhC2uWaXsuwf51qyHvXZO7RnMvl2wjagoNN/d64dTbm/WPnjz1SGD00oQVPAyg9voAPfNWsQha4RvFW/YVavme641dw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NTNPdbyFa3hTKg7vhZ4/C4g6LgUSGdjElsWXDEDOwMZdApXm4D7RjipeWMUF?=
 =?us-ascii?Q?dbaXTA9mQxG362LuljQCAlca5s4+Z3ir6rXhDgpjblUfRD7nu/xfE92HY0E+?=
 =?us-ascii?Q?VV3tHCt0Y9RV6+kKC/ORDE9b/oVZ/kv+8DdL5JK8N2S5HZTsBhrE2cUxU/5n?=
 =?us-ascii?Q?9eZxR7/1FAa4hNzzXH2+O5BclHY6xi2TTlbUSVgOL6nVX2VSeLkyYh/tnN0O?=
 =?us-ascii?Q?Go4eT3A8AP3u9LapOZLxJA/XTg9WlMzWzGCgJLB1IEXkKWDEm2//+IKK4ejf?=
 =?us-ascii?Q?rZp9ddl1T7RQG8ZPGgw0tl/TZdFAjHjEvQnjHkSCzoloV8fHIwY/WbRkHn26?=
 =?us-ascii?Q?yeYVqQOiIskdxAdOjx000yeHI0tKcVLb/Hrr1Bf6kscctlBzRaDa/qPJ+wvX?=
 =?us-ascii?Q?zNmZ0IQHMxAHqQLbJBFkcZGYJ3iVweflhqRzXQIg+w+yMo/c17YHFlhS5kKi?=
 =?us-ascii?Q?E+fQ6kNlf6lxtlweR79vF9Q+fD661hTf0czmG1iYcGSGMPVtr3nPK/WHK7jr?=
 =?us-ascii?Q?e8ukDoMUDF23itNMuiCE+z8WqVsWy8wIGzVRprXC4YsAztztzFeboRxXnNwf?=
 =?us-ascii?Q?4s/uqw/X593/BeAz25tMJrRExj3FXsaAGOvZ3KNrLSvCIbclsDby+2rRg9dA?=
 =?us-ascii?Q?xzfFmCHc86AkwEMwZ6KBLXNGDCciqmxpgcop7Q7QxrFX4ecu1WksCVVn0T2W?=
 =?us-ascii?Q?VY8zC0ExwcwVW1cc7YRGdZY3VbFmwzSB2JMp4qeNLBZTQi1FeF2Fg+uk0Kmu?=
 =?us-ascii?Q?SNKVAcZNgqcik6fpL0KvXfmYyPGUBIfIkJqwQnnHGhACTxu9U+padnrSGHTA?=
 =?us-ascii?Q?huEOQpHnTZYj8EZ7/JZ7C/RPHut9XNXasvOqFTNT8Zl0dr22ZX5QBuOjY3wq?=
 =?us-ascii?Q?QXn1FMcL7BN0voDF2Y7Eb29wyy90BiNyQiSiCpFxahAJCC6NeL1JOd684Oaw?=
 =?us-ascii?Q?tFwKetI6lShN13ADwldLi9F3VIuv6eCMwWzVLc+oqwka26QdGevioifnbkGw?=
 =?us-ascii?Q?f/eLAMKleFevqI4+9ZFhe3mX5G2I7Aw0SR7G1vU/0DTKHPx7qDTwd6Be7U3C?=
 =?us-ascii?Q?g+34pC+NV731malV/x9tJTohiADKmIR5DKwTQs4Z/6+h44JYCAjIZFd+rOyK?=
 =?us-ascii?Q?PBS/XXwYFUqe4ZgefK6AIzVQAMpJNrr2JcKy7jkqAh4SY9k7XCOzttjIW1zu?=
 =?us-ascii?Q?zsfgnrbnSJd2HBITLvuCmG9TBdtn3OkpZi3GKBl2qWsN5uQrYHtQmwaDGCC9?=
 =?us-ascii?Q?clxwO4e7SQsGvJhiWGA6wanZMEJAIVT/15lh8P2VHC/jfZprMK/GwAIJ0Vyj?=
 =?us-ascii?Q?aOnjV+PFndW9TqwTucNDpblTEHar/CfrsXyWuwlkecZDQ3zaNzrmXwnQI994?=
 =?us-ascii?Q?bRQBBYYWpKpS0Hv7HD01ryzv6Xl6LB4VNRd3L3mfELYyo/jdBuh7mPuLvwwe?=
 =?us-ascii?Q?GJKj33+BqpzoRd2DEwuomHdZyd7TWx/usyh7IUpbpbgODSnhYqu5MQJVqvKk?=
 =?us-ascii?Q?lkTcoFUnxAOKPa3THMjupgkgp5urdwxf8SOa3N2gpN9fMK654eJWIFdBrNoJ?=
 =?us-ascii?Q?sADgoJcEQrbhtrMaa92nn1wmz3O/gXnFvlWoRUZa5s4DOEwCc6M1vIpvoJlA?=
 =?us-ascii?Q?8Sj8N2GkwXjJIrAH11vk2igUrYC3Bx6o0MPZH+k8nvCqqUnqterF1hXs38iI?=
 =?us-ascii?Q?DXLANmpI7wr0cjw8jBFfpfqagLMeLSVi0e16xz6SvdQjlsPc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1065c93c-786e-471f-c5a8-08debd97fdc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 15:36:02.7712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkVQ7AoKuNGmXizaND7dDxcMjWhbvQe/i07+PglGqHw2iDZmb+y7G49XpSQP8R+KBR0MT+DIGL6O/bMCnZy0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999067
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

AMD General

The KCQ is not used for mes_v12_1 anymore , so it won't affect it  at all, =
but It's still good to keep the  same logic as v12_0 .

 Reviewed-by : Shaoyun.liu < Shaoyun.liu@amd.com>

Regards
Shaoyun.liu
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Thursday, May 21, 2026 8:20 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Amber <Amber.Lin@amd.com>;=
 Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com=
>
Cc: Chen, Michael <Michael.Chen@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhang, Jesse(Jie) <Jesse=
.Zhang@amd.com>
Subject: [PATCH 12/42] drm/amdgpu/mes_v12_1: use mes schedule pipe for lega=
cy queues on unified MES

From: Jesse Zhang <Jesse.Zhang@amd.com>

when suspend_all_gangs is issued to pipe0 MES during system suspend or runt=
ime PM, pipe0 can only suspend and resume queues it has tracked.
KCQs registered with a non-zero pipe slot may not be correctly handled, lea=
ving them in an inconsistent state after resume.

v3: fix the schedule pipe issue

Suggested-by: Michael Chen <michael.chen@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_1.c
index b169e577e5838..2099beedd5755 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -417,10 +417,15 @@ static int mes_v12_1_map_legacy_queue(struct amdgpu_m=
es *mes,
                convert_to_mes_queue_type(input->queue_type);
        mes_add_queue_pkt.map_legacy_kq =3D 1;

-       if (mes->adev->enable_uni_mes)
-               pipe =3D AMDGPU_MES_KIQ_PIPE;
-       else
+       if (mes->adev->enable_uni_mes) {
+               /* Keep scheduler queue on KIQ pipe; map all other kernel q=
ueues on sched pipe. */
+               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
+                       pipe =3D AMDGPU_MES_KIQ_PIPE;
+               else
+                       pipe =3D AMDGPU_MES_SCHED_PIPE;
+       } else {
                pipe =3D AMDGPU_MES_SCHED_PIPE;
+       }

        return mes_v12_1_submit_pkt_and_poll_completion(mes,
                        input->xcc_id, pipe,
@@ -457,10 +462,15 @@ static int mes_v12_1_unmap_legacy_queue(struct amdgpu=
_mes *mes,
                        convert_to_mes_queue_type(input->queue_type);
        }

-       if (mes->adev->enable_uni_mes)
-               pipe =3D AMDGPU_MES_KIQ_PIPE;
-       else
+       if (mes->adev->enable_uni_mes) {
+               /* Keep scheduler queue on KIQ pipe; map all other kernel q=
ueues on sched pipe. */
+               if (input->queue_type =3D=3D AMDGPU_RING_TYPE_MES)
+                       pipe =3D AMDGPU_MES_KIQ_PIPE;
+               else
+                       pipe =3D AMDGPU_MES_SCHED_PIPE;
+       } else {
                pipe =3D AMDGPU_MES_SCHED_PIPE;
+       }

        return mes_v12_1_submit_pkt_and_poll_completion(mes,
                        input->xcc_id, pipe,
--
2.54.0

