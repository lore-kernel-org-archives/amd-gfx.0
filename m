Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9B4C7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 15:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2365A10E8CA;
	Wed, 18 Jun 2025 15:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ef4fnMXz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C6089A1F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 15:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVTIECljrM59laahaOo8PsWHIKP1lpEUDUKAXzed89KVZqT5lO2hIzA8virXoGf2SRYOkh0MqhNJkks0gkcJ/RNa5i1D7ZqI84F34HhhUzc1ine8mpP0P7SO4U8VU79Num+/ZRxo/fhmUnRSVOEgNfMgXTkonHPYv1emWwQaFnBmGDNWo5WlohEGoZWfUR+jYhBOtAJbxi19/6o3EHJGr+Z2A5eHV91Pwb/caYqfCDFFQpBANesp0brAlWathlPReyuyQKRmRBZWhLngvw0pacN/2+TQBa3u7Qw31Xn4Tl/7fnt/NuzD4ybXpaOjSTjsZXtudp/jOzG2SsGm6U/TQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYJwc1d8x7oDoecb+GfmTPvms0MvcexMy0HqoNiVang=;
 b=L/+LcIk9mbq7MfZk2NObXdm+XBVCOd6xS6d6C/cfFlThicBRx5+NwKbq6F3Aktq/9Ao7UuLlBh+ERNrcf4Q1u+Xee6kiJ3nQOZxW6/pqbMejo/0ZOHb2Q4diTiaSCUagASgdztOy2qITen+E7KuZjF0kpQ7KFuMX5GYKr/VCTN5UUcZFzXozvbz38BMC9mQ+CX9pSS86FFAsMCPB07VqyvDLIVTupXWf7UoFbwfQTs4yws7+nSoLHw/PxwL/U1J1obcIgCz5MsTHUE79NkTGun9ugWLiGMId5Dt5mXVOu7FRHpYdbMLYFMHWRuHhGrsn/A1VkkbPGf7EpvAePBmCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYJwc1d8x7oDoecb+GfmTPvms0MvcexMy0HqoNiVang=;
 b=ef4fnMXzC78TbJutvDLfx/H9FjZEHkRf4aIaXwAKge8bjunDaPYiOhcqycvqXh7h27q+fbs0IvmBm2uxKZ/eH7hMilCDKu3tcJSbreUm+ml8L6pOWWgoR6O0cffwCIg3uM3qgY4aVZA7V1UhQYzyG3O3SjY6eubvjl4IjWfvb1c=
Received: from BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 15:58:04 +0000
Received: from BL1PR12MB5288.namprd12.prod.outlook.com
 ([fe80::b2d4:5bff:834d:9c59]) by BL1PR12MB5288.namprd12.prod.outlook.com
 ([fe80::b2d4:5bff:834d:9c59%4]) with mapi id 15.20.8835.030; Wed, 18 Jun 2025
 15:58:03 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "Li, Allen" <Allen.Li@amd.com>, "Chen,
 Robin" <robin.chen@amd.com>
Subject: Re: [PATCH 06/13] drm/amd/display: Remove redundant macro of refresh
 rate
Thread-Topic: [PATCH 06/13] drm/amd/display: Remove redundant macro of refresh
 rate
Thread-Index: AQHb4GlcNAKZLLOyqkaNyxStuvftWLQJEpGT
Date: Wed, 18 Jun 2025 15:58:03 +0000
Message-ID: <BL1PR12MB52882B098446D692D650E9298B72A@BL1PR12MB5288.namprd12.prod.outlook.com>
References: <20250618153936.6472-1-Jerry.Zuo@amd.com>
 <20250618153936.6472-7-Jerry.Zuo@amd.com>
In-Reply-To: <20250618153936.6472-7-Jerry.Zuo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-18T15:58:03.1180000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5288:EE_|DS0PR12MB8455:EE_
x-ms-office365-filtering-correlation-id: a605a2f5-a3fd-45e2-69a6-08ddae80e896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6k42epsK3JVLm2ySy+q38dgMJnL8+UtyvZAq/w+c+EWHD2JUuwQ71iORh/gh?=
 =?us-ascii?Q?+a691aeKxIMSRfuw50/zt40QkQPZU39QpDi3AbfCvwRpDCy9+1xqbg+TaEVR?=
 =?us-ascii?Q?m78+B8iMEtFIuPOlSf4lww05heJgAo1X79hDs0+G3w2RO1/xt09/wlK964tl?=
 =?us-ascii?Q?fMv7yby91cl1VEahJY2tvWsUZ6lj/D4nPtRpvogKleVmfeC1LYY0mgK6hEjw?=
 =?us-ascii?Q?G6E3Uq709HPBHqCHWN3cESpeM1OkKoF5YxfytWmJ61/s1fiChqNFbb0kdvCv?=
 =?us-ascii?Q?zcHn2e9kcUQnwvwr6GVwBCdJb/4XlQ1i9cneC0D0r2LmE3goVueRP689cPNg?=
 =?us-ascii?Q?njzAkv6WVStmp5ddpn4Cug6ZkSrBa0Oz0SxFo6unpxjbcTnXmcIr1xn40UL6?=
 =?us-ascii?Q?3acZxZqZ2+TEKOEAMjMp34/uYYSB/iAxy6A9qpCLl9DyljpmnfFl/J/rar3d?=
 =?us-ascii?Q?y/lNIYdxvbzVpseRpbDoc2lHT3ZWIyhaD3uKd+KBRZgIP/OszKnN9VGXKHYQ?=
 =?us-ascii?Q?ThXyGvy2OfUo9B8tM0paRB7wOT5daa/pZo0emJsBK8nZ065b8xvAFQGCyMWY?=
 =?us-ascii?Q?b5QKo9laa8HHdhxKNZGmk/TCRkoz+sj8JXXKVfv+a9eif5nm4hOJzz/JqN5x?=
 =?us-ascii?Q?q7attvq5/vpaEU/xRBWn0Sf4kkrFGwueWjQUGRe6KpdZYQv+hAH/ufQ09C8f?=
 =?us-ascii?Q?uvC0ufTSL2nWexArrG0RcdBUO7tQWXODF3WmzNLpPrm76EtgmPsWvezDCqpL?=
 =?us-ascii?Q?O7rbAkSCATz/Ffh5NBdl08GQQHqbYjofZS/ohvfb75pXTE3ozAPRODROILzj?=
 =?us-ascii?Q?/6ik0jbuAR9q9exSzkSkewk3OAZjsFx/qWj5upAhfUlRDqbb1WeifaGjwiaQ?=
 =?us-ascii?Q?0DKqTZ5vB6Lyoo93INszUUiataa1vDv4JOnRdGED2CqLNAWZFVlXtu0/AQH8?=
 =?us-ascii?Q?yCxVJ4fRU+bbcX3dnjCnVIxqVH3sxI4c+HXtzwoxBnIpLA3XqDrQiXwSwaun?=
 =?us-ascii?Q?IuwUgaJiOuotjB7A5zK65ZF5dltev12H7F0HjJE76Rrb/te8MbHpYjr2G8DY?=
 =?us-ascii?Q?7y0dEkA80bOteFSd3YKA/GpIY0CJ0+K9edjRmS3ULMaMaQ+3FqACv/uGfUCB?=
 =?us-ascii?Q?78lDIlz1ue04PKK8pcCvUKX8Zmd+fzE9o6Q7nLeALJUx21ipCO0t0BYv74dO?=
 =?us-ascii?Q?DGrmtdm0z99ypTel+heiSCfRm2vv6AnFiiokHen3yCBjmjMJY+PlDlAZtqcq?=
 =?us-ascii?Q?qCkcmJAIPGB0d6Wb7L8FQGbMIsGtVp7Q9GkywuFmC1cp2yUnYylfUnIWT8fZ?=
 =?us-ascii?Q?YiBSl+OAUrV8/qEh2xPHpsl3Pd3h2lggOOQ0h11Tr3UQfSwWXxN65XQ9Esw2?=
 =?us-ascii?Q?OX3uakj9QX8Xg65GAP4rgO9dJagI98/Rypmp1QEvos282WvQFk2RwkS8XqtX?=
 =?us-ascii?Q?XRSxt7CraXHXIH0lDHra0qA2RGUqp8wURNnaYO85+na5Ujciuzzpog=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5288.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0WYqpHr8ukSfVyTQjcCs3DQIFv+ANafqJtQMXBs59EygpfWgL9TuivGSSEi+?=
 =?us-ascii?Q?6+9CYJ0VrOWKrFH2k5j1W8dkrQx3VLZErcCOKpocqH88IfSBiXQrlKOhJvEN?=
 =?us-ascii?Q?whRESCilEyI6slElyEByDH5IzEgsMEplwpSG+4nKPwFiYWqsSdKOjqwggyXT?=
 =?us-ascii?Q?DEM2a3/SE/AG/51VOV2iwvu9wReJuoS91D9sfUWr7pDpiu5b2+xsYcs8S5g9?=
 =?us-ascii?Q?zdT1EZWjg7HqH/XtRpyTegiA5Y2R2kDip1edhMO7fCEYHxc9m0rIOFGZnfNo?=
 =?us-ascii?Q?GfoQJu6wdtgnrhPW0ZrEWKycV9fZZve1FdH8CKUAyvNiJj/N4oJ1mB5CreMx?=
 =?us-ascii?Q?0MGpLkSEqDQ4ktwmbCQQMo8Fu97k1L3RT021ExgrjWvQU1Yo1d77W3RGrwNZ?=
 =?us-ascii?Q?kmVPacFOj44FUmuRdnieWUz2Y9+juOzNrX5tc9FHdFVjOEXf8Mom5/CxG8Ap?=
 =?us-ascii?Q?ObYQWgNykbzCqfafM15rrEVtsbyvXRb4usUPehbNV0S2uy6o9tHrunfdSk5T?=
 =?us-ascii?Q?E1gfuTTCLjeEP1wMmf2+RcEGxCjud9JDSgpLHNJ8hOdRR74R8LURU/KQlYDC?=
 =?us-ascii?Q?Rt/0OcG8/nGq7/q/Wr/nbfY5l/HiLzvR1p43x5+mz1doq8GM+2nB9s/Jg4sY?=
 =?us-ascii?Q?ZErhG+F/A+Mqp+9lGX2BrQSjyexaGdnMyy+j34Ag4HFfEsk9o7sLitaL3cOX?=
 =?us-ascii?Q?ZkCflg99ZuWwq4cCj9VrMoNVGb1NPWlIj+Hrv/rnDTPYb/v28mXW0RwPZHQt?=
 =?us-ascii?Q?eR7bpiOZB+Ypi9tmKTtfv8eTMjAinlqllCwhDatoyHKjMf8r2ZE3M3B1U4Hi?=
 =?us-ascii?Q?XUIf3ap2tDhUwljOFKMiQrsdO76HfM447zIFcckj0Fw6BGX7mgivjJOitBdb?=
 =?us-ascii?Q?9JJZGPr/8qllTkyObVgHIj7AdAkPyieG4WunweCW6zUElBfOHSVIwm6Cng2y?=
 =?us-ascii?Q?mkGkg1ZHNVreO61jT3FKfQMr6kS7g6KcRM15G7V1/AJWAPzHOn19WY2xnBmw?=
 =?us-ascii?Q?R62liE1KBF9FLSaN5jAXHmKTad5TL29VICvGDXKiK7Y97JKOvZmCH5M64Nfq?=
 =?us-ascii?Q?3kmWP6ynkpHmFW4T4q+wXPw9WAnaHIV9ZoMfPUz4upZLFVqyjCN2vmmPBnjl?=
 =?us-ascii?Q?c2lr9HZTw8niYsjrcepwFAeD/ZdPM+FPjg0v8U0GiplMchzf2MLDPEAiJhQO?=
 =?us-ascii?Q?U4mOXSgBrqImpHTKtP67eMLRo/ZcPEh4/YageSZADk72Z0+/NSjVhX9F+Sdg?=
 =?us-ascii?Q?64j5NE6sgUGEjREkcvakEkrv5GCbmDTNzKnzdVqkmWyJgbw51BQD9lIVhdzU?=
 =?us-ascii?Q?enUaki0cdWEbtcMwBWaMsTDbIjtFtN9MI3ATPu858Mh/61x3tyTNhtMZmpXk?=
 =?us-ascii?Q?nVnFPpEc5J9fSB1tpITC+9xd3fkDtIrJR+bFcnGtFjWCKpjq0jrJqNSjLBKT?=
 =?us-ascii?Q?BZf9ocfBDVEKVxSsXECcVwBsdntBI61afEieC9e0WNhQwQqFEaEjptL4hgTx?=
 =?us-ascii?Q?H3EP+Oe/2PBVMtrjdzGGoHJYXG8wkrxjDEwZ39cc2lMquXXHieHf/sfDR+4V?=
 =?us-ascii?Q?VO+WPkBUViWUHwXmj20=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB52882B098446D692D650E9298B72ABL1PR12MB5288namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a605a2f5-a3fd-45e2-69a6-08ddae80e896
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 15:58:03.7633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nh/ynXtQteYnJRSERYO6a5B+Dz3Joh2l2zc4F7j23eDmMR5zsyK2CuSs5IgPXnSmnn/pj/mmpHAbg08mAM8O4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
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

--_000_BL1PR12MB52882B098446D692D650E9298B72ABL1PR12MB5288namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jerry,

Please fix the Author/committer name.

--

Regards,
Jay
________________________________
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
Sent: Wednesday, June 18, 2025 11:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; Li, Allen <Allen.Li@amd.com>; Chen, Robin <robin.chen@amd.com>
Subject: [PATCH 06/13] drm/amd/display: Remove redundant macro of refresh r=
ate

From: weiguali <wei-guang.li@amd.com>

[Why&How]
Found that we add redundant macro on refresh rate when calculating vtotal,
so we remove it.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Weiguang Li <wei-guang.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/driv=
ers/gpu/drm/amd/display/modules/freesync/freesync.c
index 3ba9b62ba70b..6a939f2f2fb9 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -147,7 +147,7 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
                         ((unsigned int)(div64_u64((1000000000ULL * 1000000=
),
                                         refresh_in_uhz)));

-       if (MICRO_HZ_TO_HZ(refresh_in_uhz) <=3D stream->timing.min_refresh_=
in_uhz) {
+       if (refresh_in_uhz <=3D stream->timing.min_refresh_in_uhz) {
                 /* When the target refresh rate is the minimum panel refre=
sh rate,
                  * round down the vtotal value to avoid stretching vblank =
over
                  * panel's vtotal boundary.
--
2.43.0


--_000_BL1PR12MB52882B098446D692D650E9298B72ABL1PR12MB5288namp_
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
Hi Jerry,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Please fix the Author/committer name.</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Fangzhi Zuo &lt;Jerry=
.Zuo@amd.com&gt;<br>
<b>Sent:</b> Wednesday, June 18, 2025 11:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.c=
om&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.co=
m&gt;; Chung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Zuo,
 Jerry &lt;Jerry.Zuo@amd.com&gt;; Wheeler, Daniel &lt;Daniel.Wheeler@amd.co=
m&gt;; Wu, Ray &lt;Ray.Wu@amd.com&gt;; Hung, Alex &lt;Alex.Hung@amd.com&gt;=
; Li, Allen &lt;Allen.Li@amd.com&gt;; Chen, Robin &lt;robin.chen@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH 06/13] drm/amd/display: Remove redundant macro of re=
fresh rate</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: weiguali &lt;wei-guang.li@amd.com&gt;<br>
<br>
[Why&amp;How]<br>
Found that we add redundant macro on refresh rate when calculating vtotal,<=
br>
so we remove it.<br>
<br>
Reviewed-by: Robin Chen &lt;robin.chen@amd.com&gt;<br>
Signed-off-by: Weiguang Li &lt;wei-guang.li@amd.com&gt;<br>
Signed-off-by: Fangzhi Zuo &lt;jerry.zuo@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/driv=
ers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
index 3ba9b62ba70b..6a939f2f2fb9 100644<br>
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c<br>
@@ -147,7 +147,7 @@ unsigned int mod_freesync_calc_v_total_from_refresh(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uns=
igned int)(div64_u64((1000000000ULL * 1000000),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; refresh_in_uhz)));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (MICRO_HZ_TO_HZ(refresh_in_uhz) &l=
t;=3D stream-&gt;timing.min_refresh_in_uhz) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (refresh_in_uhz &lt;=3D stream-&gt=
;timing.min_refresh_in_uhz) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* When the target refresh rate is the minimum panel =
refresh rate,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * round down the vtotal value to avoid stretchi=
ng vblank over<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * panel's vtotal boundary.<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB52882B098446D692D650E9298B72ABL1PR12MB5288namp_--
