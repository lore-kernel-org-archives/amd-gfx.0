Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39B6E6B275
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 05:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4400B10E141;
	Tue, 23 Dec 2025 05:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kzBuYDyI";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B9210E141
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 05:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x08lROhoLIR3UnCCyWqeZKxgSN3jv2H3pE4MY7AaBpKBvBX1aMlRx0HztPrbSD4v+LliazY1ACnL4yZcLapRqXYeViW+gPxqsKhdS4GbPmlGWgBVeg0UtHx/IiCtmQy/+7NSo0XyYNms87RGpbIHU+PiSQVlo+3gcOSDdBWhk+RiHvLmOicF/gkJDxQUsa1lpdG+s2o8IPQJTDdcFHimtXYpqq+hsiSJatNd9kU+SxkkM0XnuQS1F8kcs5+aCQIkeZkYdEQ3ixmVdT3wm/fVUhFUjASV9u37B2n6UGVGPFPcQUAtngsU1fHk5XMViUFugPlAaXda/vWWfAK2y9FFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZrXs0rP2FwuleRsMKGBZm9DlLZeG5g5a4L2V5ZoWYQ=;
 b=ZaNnLYz78NWO8zoaA/5NsJVpc7fZP/+NoZ8yDLim7ceLkE49NPaiSB4m/nlqzvfVXmN3KbekmQLR1WEFuJRrPQ63pR2Ux1cs5PPxOwnu4AwurVsDCuUZm0mn8Tq2upgNhW/aljxhMqgW0xpbhzMFEmTzUTbN9SyrH3/Xmht+XbH0s8gfz/rqNC9dT3Q9yE3UFK83oLHj43XtxyKXwtTQLzSZpoF9h/QzECYiKVeeUl3XLT/yXSQcjuBu419sBzxcR7Fz+PtHWMgvCA+hJgNxxjiTvL3KUk0ujpi/0gpfE4bOlfj/KGlty/yoSI28Z96otWlUCzDb8CjzkCsagtfphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZrXs0rP2FwuleRsMKGBZm9DlLZeG5g5a4L2V5ZoWYQ=;
 b=kzBuYDyIwsMhrLZ6EM/O8yOW/QsmgAsQot6IJUGPUq54ov5/WZsDBTWuVMNFLizvbDol9RUY5TsyqpFkMHb6WqU06RqMWtNpW+zak0ODXubj30h2rYK0GrN8AAOQr2InSr1zU/uayrQveWix3Mbmf/+z9+uK226B7iqWqXU6Q2k=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 05:51:34 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::6749:e799:6045:d959]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::6749:e799:6045:d959%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 05:51:34 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/ras: Replace NPS flags in ras module
Thread-Topic: [PATCH] drm/amd/ras: Replace NPS flags in ras module
Thread-Index: AQHcc8/snKQt4LTlQE6Pp9r+KeG+yrUuuLWg
Date: Tue, 23 Dec 2025 05:51:34 +0000
Message-ID: <CH2PR12MB4215ACC06A8F9B1C214A1786FCB5A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20251223054917.1498759-1-jinzhou.su@amd.com>
In-Reply-To: <20251223054917.1498759-1-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-23T05:51:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY8PR12MB7754:EE_
x-ms-office365-filtering-correlation-id: 8130bf87-45bf-43e0-7194-08de41e754ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TidnNK+nHlXktHNR6pzFdEB+xsjmzH00GbNyKbEyD8/O/IjV6wuQl+dN0oZ2?=
 =?us-ascii?Q?b0+/SjMoIZ7oOw1Ntmk4UYbKepJkVz1iqDBFPsj6qOXhxGMZN6FA86vL5Hjn?=
 =?us-ascii?Q?rqK171yQiyZQoaaRAH//YxoDisfBPVXUoE6ocHyP1Cdaan20KCroUn58Wzcu?=
 =?us-ascii?Q?XrV++X2dvJlQp+PRUmdFNLorFB+/Hx3bM1s+yyg1ffQQN4kPFYn8TdmJnn8T?=
 =?us-ascii?Q?PXiwdg4dYUIu+dDwbcdVxyvZRTH8yF4K9wx3Xd2Be9EynR7IX5zB322KLW58?=
 =?us-ascii?Q?yzZ4+bGH5cpZHIPfTvXq7dFvK9a7x/u4PeZKCI2ZPBH/tNS1etHaBJsU2xys?=
 =?us-ascii?Q?8RSvt4fz5EbK4kvutiKxOpzPPx+59KbPomzQ8ASm9A3KWS7LYjz0kJreAOL3?=
 =?us-ascii?Q?/JSLp876GTW6yziS8FvgSJMqt8xwlIbYNUCvWXrT9G4oUsoo4XpbcdPubUZr?=
 =?us-ascii?Q?gGdKJZVLqUZUAlRwwatsqwm1FuDspKYsS9ygHfEKBRGvTV2Ozc1R5UjCn4k2?=
 =?us-ascii?Q?gxg92y3i/lsnGF8gmViBbMwZTNSPwJDUNu/qpeqTW4Ur952uzAB27kLi9f6B?=
 =?us-ascii?Q?Bn9MinbqRsworjU/gGu4VgNIGZXKsNTCkt1BV/4LOm29km3bhWb9O/X3Q1Dz?=
 =?us-ascii?Q?W3aVpTPXOV4gz6tWvnIIOF2VX5kQuE3PfVeJ5bdcBavwy4ha3yPGWatAl8IN?=
 =?us-ascii?Q?6cyg4hk2yJGjGOSQGBOsHhi9JblDJjXRdj1W0+SeEZL0PcrABBHjCXLxgsaE?=
 =?us-ascii?Q?0hHEVLlvQxiKzZw8HaTNHFES17NsPuYLmv1/BhhFgWAj+7JYeitCDN59eAuS?=
 =?us-ascii?Q?5qPZnnCv3MQ3MoAiKm7s4AgxOQyEDQA+vONIMVMmx6mmM2H+SA1nmDlIH1Oc?=
 =?us-ascii?Q?Fum2Icmq11bd28TQjxmYNSnzveSaol59E5JvjCyVUT/feTrk7WQRH2fcwE0S?=
 =?us-ascii?Q?kBL8hq1x0g+/eFJKXV0xJKoOqg9Xeqbm+pqnno1yqWoZP+iPjm6/DHDaD8fH?=
 =?us-ascii?Q?HDKt4gZjSITZeQ4kUQlCxq3bjRCXljuw9UHQZ/E3DiEUwlMshfndrIZ/9QO+?=
 =?us-ascii?Q?hn+fPNr+81+x/XAwaeLnduEdB3Tr2xB+MX5C2xs3/S004LcG55sYBjdiwx/F?=
 =?us-ascii?Q?JzExRqec0RVSLS8PkI6EauzPUn+w/wzvDZNbcKm6JHyw3gf1YZoQL1OvnOl7?=
 =?us-ascii?Q?JIwiHxjob5OMfLcPMhvf3YHJU47vPjuch016bwY0TwV19KrmkXR/E+igJfrs?=
 =?us-ascii?Q?Mu3PjSFYhyXr3ZMEwzgn6oenFHTfExk8uMJxAGVPhA3DYwQMw5VehQjX6jn0?=
 =?us-ascii?Q?nvq+D/PgE3/P+d8T716CfP5zcqC+nzI1jHf1hu9D0RZmPyCESRUoHh2QHYva?=
 =?us-ascii?Q?6NjPo3AKgRyKgdRpwNSwCicvptv+rgEE4uVFzqmZAafE0MF1UOsL18zMdqEN?=
 =?us-ascii?Q?Bbxr5hGLPgJYhoF8asdtd5oxA+zdK74ZhqAnaV9wM/o0wA2uixZ0WqS+r5R4?=
 =?us-ascii?Q?FWKCvzxyUj2B422ZRp+OlL249UltrQPHtsgs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OmaF2jaZOZEPL4DgvXJapyCyL9sIwO2BKwI6R9Pl6Z0EjzypzG4fHVA89CSN?=
 =?us-ascii?Q?98KY+eK2l1G713HD+doyNC3zANK0zCj6ai08cmYXp64oLncXbIU9NwzOPb8y?=
 =?us-ascii?Q?FRDSVbAuWFeiEo2+BxX2sLRdNB1m09GcGb3MSSD+gO+bSgozpfyRNYXZnkDp?=
 =?us-ascii?Q?vbCSEMRhG+ERlCcA+vTTamN4Pd/qlFI+TNVd9C6JOIDiu/D6Lc6Lnviia9bw?=
 =?us-ascii?Q?/kIfmCdlZyxhNoRi5p/LhZ/5A0R/UBG+YGHRS+V5/8jVLzuQYJJiJ4kalAcy?=
 =?us-ascii?Q?HflUI0HA+ULYSvhngmWa2t//seSdlwy+cL/lw/Wd1FsZIzpPFlo6Q0ATzlC5?=
 =?us-ascii?Q?SGxKdl/OOJjfaCf81qG9l2kYPf1ngHI//CI0+bJvlPvn2YCBWXN1hCo9ejWe?=
 =?us-ascii?Q?J6ow5J69QsiyM4N8JWuW2jUK1rkUZVE5cdGH+AMfodgb5zqkCaWwKG0AFpVT?=
 =?us-ascii?Q?arr8mDTtLlExfOQUCqPj+h4cHk8lZOX/tGcxNBp1aXIneFOrgLctDnYYGNd4?=
 =?us-ascii?Q?hBEeTevCK3LWoBex2aX3hZ8jQ+ksSXLtq8uRf2jET/xonEdK7H2VErIpzA41?=
 =?us-ascii?Q?IhjvHKxkN0CD1vlV28NFP/isSdDgPz78fnGgUt7dCeqmtLcvjtb+TZJ1dmYu?=
 =?us-ascii?Q?RBzywo+U/QGrXhOAqcoOLEDW6616lJ9AqeEfFsJvadf2somyIqIK4A9UR0AV?=
 =?us-ascii?Q?gOaNXrXcqaOU//LBOcsMp1iQUHEEjk54Xll2oy9QXX7tsC0mFJo0fiq54EDm?=
 =?us-ascii?Q?udOysnhFOAW4UIEPxSZd9Nnsq6XJhJmvohI2vZSgNXdVzWzXA5lAZ9fNdznu?=
 =?us-ascii?Q?hPPydgEDswhayybns1zTVTDI/5RkIszuFixsZFPoOSK6M/0or9WZN+C9qtYq?=
 =?us-ascii?Q?h2XNlC1gLlTSxeE7+DKUS/Wu4UqX3mhaSxxhObqkjn0TmI6tiuoHYXdpJ/7T?=
 =?us-ascii?Q?Uwl3I4D4P9uHa6NyGznKPRDJDpQ027llFd1v+kMeMmisV13a9zpQygjC+u9D?=
 =?us-ascii?Q?tME797MBD1gBkr/6LTpz2YgQVQGxCO9E95Pm0SwrhJwmeazNAdu502yt0+dZ?=
 =?us-ascii?Q?/jWjp0J1DCtr+DOK+93XONxW6N48oBy9GVjk60OOgxU5F+2cP2FjPa/IcsKU?=
 =?us-ascii?Q?ciL8vo6YwX1vNxzD8LS19OSXbH63qMVYzvJReVyh65EVPOWH1L0hhZHvnUkC?=
 =?us-ascii?Q?Cu57cl08bZBpMdXMPqcpZDvIo8OqENYzhB9YHtfUrWV4Jrod3yKUXs8c+fJZ?=
 =?us-ascii?Q?FiwGT62YdB/Scrzp9iecaGHzvTQZbd3pNnXOANrGHPCoPIuoSXTvssCLz5Cr?=
 =?us-ascii?Q?Diof6jiCLy9lXknKqRD+9U/rhKFfKKRU9x04cFzcTJR4E8/Vi/Liakpwk+dH?=
 =?us-ascii?Q?uXbsRVNH/Dx5v65yLaZaVLn/AUZVg19z3Q85nW3BYXWLaw633jAdcjTjoLUO?=
 =?us-ascii?Q?ye0R6YOHHbBLmmcQRX+lPZWnr8gXrQ+PG06+PmdtnxZbcfMHKRCBq8C6uYu4?=
 =?us-ascii?Q?kopUKJbab9urxDc3Zkt4vojhwqtvXOzoJy3QCNY1CN3wT8A2gKWGlGzYhgNj?=
 =?us-ascii?Q?hvMWItmho5GpmPFCcWuKVesJWjm2LGOXGXzSgDrcfYqfNsG6OOWBDWuQdVgM?=
 =?us-ascii?Q?pQj9S4QBIpCSKhmAi/jAP4Cc5ry2vwOIdKxprwkKA8rh7ajH3TBxs+QDgF6t?=
 =?us-ascii?Q?4iV/cC94dsjsZFml0y1d+k3HfP5UzK1koO1v/jSEssahy3tc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8130bf87-45bf-43e0-7194-08de41e754ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 05:51:34.6862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWrmIGbda4m3Wm5F4n217/pAc1ebyJb/n4TI3hXHS2avs8XQfkFqkl5DYaYEyQxDcpmEmBH5GjQLoFmt/b3ZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

-----Original Message-----
From: Su, Joe <Jinzhou.Su@amd.com>
Sent: Tuesday, December 23, 2025 1:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Su, Joe <Jinzhou.Su@amd.com>
Subject: [PATCH] drm/amd/ras: Replace NPS flags in ras module

Replace AMDGPU_NPS8_PARTITION_MODE with
UMC_MEMORY_PARTITION_MODE_NPS8 to pass sriov compilation.

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/a=
md/ras/rascore/ras_core.c
index 7e70560b590b..f2fccdf5e329 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
@@ -613,7 +613,7 @@ int ras_core_convert_soc_pa_to_cur_nps_pages(struct ras=
_core_context *ras_core,
                return -EINVAL;

        cur_nps_mode =3D ras_core_get_curr_nps_mode(ras_core);
-       if (!cur_nps_mode || cur_nps_mode > AMDGPU_NPS8_PARTITION_MODE)
+       if (!cur_nps_mode || cur_nps_mode > UMC_MEMORY_PARTITION_MODE_NPS8)
                return -EINVAL;

        memset(&record, 0, sizeof(record));
--
2.43.0

