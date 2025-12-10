Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A8D3B9BA
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 01:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FFB10E63E;
	Wed, 10 Dec 2025 01:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GP9bPtPj";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3FA10E63E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 01:40:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spMNV0ma25rwWpjHxx5gCmLII8DkHK1J0TUe4nmzxFsNlK6sigTZMqdzufADhDTBzS1ceqY1M9MjKJTMxyllD4WuMxjzuPlf4mTvRVja9p1F1WooFdG3txdsUvdj/TiPeJRS+9QXEn7D0Z+r6oDliYAv6dcSVNjQ49aQXaR/ZfCUNOTF6c0FVlHjHmXGtK8qiSAZS7/IuBRnOAD8yeE99JvJ0c1vqNhl/3/1JmEkHnmEsimTHlxmnp5Jha9WN664ZUBeCCvm30gqx4ffB9UgTJ2WtQLLr86c6Z3nli3LsUNzJGbGNJC0PT1H+rtuoMZfjaWXKC6MIr3THB8/vMdtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ialKaNIZS9D8GsjAaWFfk93vGI028iaypGfd7UcL5l8=;
 b=eTDML3tHvQSgv4INrjlBZrgRuhlWKmbQmKcPlqLdkroa3Wl/utWQuaaBnnfqIC5sg2o2aOJT7/J+wPR1AafUpmpHOj/UAWlygopMrBu/nq2waVyamzNpQQbtIRJifFzOdHSotbHtXMlYfsFaXC2+yXyccE8wTYIgEQBot+C3ANUaF8jFm+IrBlTZAjTAQfuKwQIElgOzPmX5fuSHBL3x3YAnV6PEVAaN+OTK/4klrAcZUhgSu8vEfH6utjOFrkeqrjzSQg0u5WAqpZTOgJz46wAnzJBngAo3SLUGPq5guF6hhZL7MBDMKHtMOgyepW+/RqNn0PWhiYlMxPU4bHCXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ialKaNIZS9D8GsjAaWFfk93vGI028iaypGfd7UcL5l8=;
 b=GP9bPtPj9xrdGdBRdlAj/8ZM/FdvTYDz8xh7jjMWZSEMLSfXgOWPWrNwDDkaXNs1GJt/Avb8c8HWuuzzUw/2RvDhWMSGYwjwSnERdvxho3iQhD/LGJlAE99/JDB6JIsX8nx/BmYH5JOnpjkSXnvguTK0xhLP1JiAi7x887h0GCg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 01:40:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 01:40:52 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "M, Mythila" <Mythila.M@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "M, Mythila" <Mythila.M@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: restore SCLK settings after S0ix resume
Thread-Topic: [PATCH v2] drm/amd/pm: restore SCLK settings after S0ix resume
Thread-Index: AQHcaSggfpdmVBB1wUCIOoFVnczrrbUaGaMA
Date: Wed, 10 Dec 2025 01:40:51 +0000
Message-ID: <PH7PR12MB59970B79E35633E554E16B2782A0A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251209162259.1604207-1-mythilam@amd.com>
In-Reply-To: <20251209162259.1604207-1-mythilam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-10T01:40:33.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS4PR12MB9796:EE_
x-ms-office365-filtering-correlation-id: 41df45de-29a1-4659-1ac8-08de378d272f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KzHUKQwiHHPmKXyLwiW74DwTG8SPaZzUliiSHq76sK+cZ4gPuHKvvZhMZWu3?=
 =?us-ascii?Q?dbrOJbAE/5qSg1KjgStuSmvduKkK6ZWw2iBD6dtL6Z153RBMT35AU6DWV+1J?=
 =?us-ascii?Q?CFRiUfya4thjEheEot3arXMOotl2AeTPXeVz+xL2H6ffrTwavZOk3pkRq9mw?=
 =?us-ascii?Q?ChedVwWX8lPUkZzEWljrTJMjOztjLal9RVXH5LswF43olT2Hg3e1fHBOHKny?=
 =?us-ascii?Q?YZnwz/PD9POexRFNZwIKzhOdDZIM5kzc/LwKLnV0+kbAh7t8dJImBrjpJdC+?=
 =?us-ascii?Q?PgwTXNPCRPyfVFcdZzc4ejdjmFA/UsNGvHxoOoXTNObBI5zg2LH8maDWQW6+?=
 =?us-ascii?Q?xQOsPtKeTC6RwR0Cc1+a2LaeEDuMuWqsIEuKXLtPaKdqjoW/5gyjJMkowAws?=
 =?us-ascii?Q?w18J36kK+6eLx7qK/QfYb4e9zAXQtYKU8XVDUtUvksUtSDsqufAmCw2/1FEB?=
 =?us-ascii?Q?UhCypAEPBy+S5AFaNkliTs0CStEStu+15BzmDE4uQnwq/y6XWxzabTBKvpFV?=
 =?us-ascii?Q?zdyTbzSvXKXTCX+efcKtUO0F37Rq6nl57nEfUwsU6LBaRmKvZ8wxKYCtESnN?=
 =?us-ascii?Q?xnbQkKqkWTvZVy6DL9SwXeQxYnuORnklD1u7dgi38MPTkfWAeIFXPGTpn8dk?=
 =?us-ascii?Q?4xhjG5TTp39Ao05sWDb54vE7yLonIeplFkSPca0qUohxOQSS6Uvkp6iRk8Lp?=
 =?us-ascii?Q?DufdD5xa3m1/4DQ5/uisKBD9xXgVKRXl+PZ03qgtnS/cUMPUh1xJiywzFq/s?=
 =?us-ascii?Q?4IO8IjMpVpVh5YFhZ8jCF7fLuSAVlKGoFfUaIHZst/KWaEsrjRYbjsXSe5qe?=
 =?us-ascii?Q?2Wv5oshTOS1oQRUD8NUbYKWjS0p0ylSndd6rbDzb8cZFp4rUkFxOhhsPQh7+?=
 =?us-ascii?Q?gzJ7Il2rT2Z+laYKOXFy+J+qUda5qiNqCvWDz6Ba0iLvKroG0a9nQVLgMPIx?=
 =?us-ascii?Q?OiiXdX7euAVbwbt18UcgaQOLONucdQ0oNahAEKViNceGRhG5CZoozuXVtS/z?=
 =?us-ascii?Q?ntqAczCObI9qdNqH2W/tkpA9nEHeay5h3pCcVDKNBF4ltAmbBjvMUyH5OWgr?=
 =?us-ascii?Q?eNboGngradh10heArSB6yzi7Ep+f0sJ3ax7P8luM+Qz3332PnUnmsMfQ7Bb8?=
 =?us-ascii?Q?FtJjJn29qoJcyJW/sACCccJuO9acl15r+6AXCgKdg0In+r/+iRLwhMJTVvg4?=
 =?us-ascii?Q?S8ebXv5FWvRxTdl8zG+XRYaTFxCUGQcOcQdkHgnLcaH95i18dedACrF9MbLj?=
 =?us-ascii?Q?lk+mf/0E9Xo4CPeb1ZlT7XtC3mBCqwaYLyniDpkfjfdQGXH4wYLmr5XYrwWt?=
 =?us-ascii?Q?5VpvnBQXp2Prp77Dp4eijmC9gu0UIrZARVh7VaNb9Ax6VLAmmRZv7mU4BYAu?=
 =?us-ascii?Q?kQ/z0ShZ42brodIKcxv4XO1cNOolej4r11RerpTM4neIWChoSnhm+C8NYkoE?=
 =?us-ascii?Q?U7daJpFIbzQSNFF68X1PIH8czm20vn9+9AqfXSc4WnvmvdsPY33VrkP9Kw55?=
 =?us-ascii?Q?s6ylbwbGPSneA2xazJ9E3XydCEBNHa0Jxmbn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BUyGAmIpOfVQRrrMecOM0+BGpWvMnlwitlNhmV6SUBo3ZI12BHrWsQ2KAdtS?=
 =?us-ascii?Q?kz6XCuk73oLYTW3jDCKgSeaHr/KJ4+3DtPCj27/7OzSsq1eR9iRma6pwWl8i?=
 =?us-ascii?Q?n98KwVkTYIxi5kCNK3PJZNTI6qA7i9LZTJBhx5uLKs3V5CNYamzmfSN54qYk?=
 =?us-ascii?Q?8z3yY6dwKLLRCZWMyXOhJl+H9SAzdKWqwCiDcpyOBOe0icWvC7KPoPcj5CZL?=
 =?us-ascii?Q?FlbXvWFpQybpkKjTLR7nw6vdFKH9grYD7OJ7dprgY3Y9fwjzSAKpyxZJ3DLF?=
 =?us-ascii?Q?fc4++RsoXfcDK/meRRcHV7qkFX2caz5rsKB7D301GhkOvS+lHLSKs1qLCKGK?=
 =?us-ascii?Q?41sMC246TkGVt+tdzGhb+1VG+8eBqJwBYVtm6gvZfStPkxf4eef8KqfaF984?=
 =?us-ascii?Q?rTR0++zDo19wrjdQvmEeAaLrm0VJe1hjViU69XjjC9OWEd/Xcvt4wy/YZz5u?=
 =?us-ascii?Q?/zTFVGle501qQ4Zs6vgT3BJObzw3oX4u/PlwqOn1rtPaeKVPzXXWzXG5Ohw7?=
 =?us-ascii?Q?ZsehcG8TmMbP2ZpcoQ0WwvP1wELLPKKoWQuM6iut5l+WFOVJhh9r2uekHBGB?=
 =?us-ascii?Q?eexBVKoYFCbsNCgFf78dt96VLf15Z0gK4cuDBhjiQThbYdohARLH6sIjyG+m?=
 =?us-ascii?Q?ulxp+YC8UVN3ae3mterykgo62mkd4RMdD/PbkN923cxTKowqufh1onYRgN0E?=
 =?us-ascii?Q?sYy+xYb/GWOiFqXm15+LytE04wZL0mPlRLMmC11BkZ0aYBmR7dGdDydqQRu2?=
 =?us-ascii?Q?2I/lQMJE6oemb2sjS9nXG4JnWH+uUWNDCNYrW3c4jWfuQ7jC93Ex35IDIMO0?=
 =?us-ascii?Q?6hQym9pQY3sutKeh0sdwIQYjHVjUXKJ5/r3ZABrV5O76+Bk7fFrLTKOIRWEq?=
 =?us-ascii?Q?Z0lrkoFYLkfbw9Uvm51Rd5YtmdAgg2V8xAbo6y4mt2Uqeg36h5R1qimqOCRp?=
 =?us-ascii?Q?PJEj9MSjlVLqi4N+JJe2JLOQzUyZYEk5gHToM3jDyqltOXLSS11tvRgQR+rm?=
 =?us-ascii?Q?V7AUt7ffwN6RHRLmcqPc9x+HNkT29qO/v432Ls1TeO/1YKbNuZIB8/MmMj2d?=
 =?us-ascii?Q?nvouNwoqANL0zRhpB6f0/Kr3arOoB+RXARcMuS4wKIyKhX1AnTgd8HuMNZNW?=
 =?us-ascii?Q?Ja/3l8yuR8enBqpCS1MKSuxO3CTjgS7Cawz79C1VLtZCxVpVkzxfVYBOCgl6?=
 =?us-ascii?Q?MiMvIFC3WfxmY04C2F89SgmgUIKqujS7s/VV3vqEJhGkL7ISxFzuwGNHuSqM?=
 =?us-ascii?Q?Thi4zz37RsumR5BCybavgMkf1RaZ+QLxL78Iruvmme4RlbX8jQbk6AZnX44s?=
 =?us-ascii?Q?XB25muzKk+qZUZyyDQhscr6nQHDdKw6nIshrBELiNfkWJ5eqJhFHT3s5w5QB?=
 =?us-ascii?Q?CCNqeFjbDkAk402FEYWf6/yl/chkel+LYFjeYsmjkCoCEdl/SYKMdu9xtQxJ?=
 =?us-ascii?Q?Vs1QPFZYG6nISTvvstGhhGW+jgN6KCCwC4HWUz1ZVI0KWxdK+NSumRhKIJug?=
 =?us-ascii?Q?w7OPFRoucdzWPAlexWaXA3FRs4SfB3d2+Bb/jBolduG5yPOFvgKMODPPzxPM?=
 =?us-ascii?Q?5kGxDzGr8hKuI3NDkUc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41df45de-29a1-4659-1ac8-08de378d272f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 01:40:52.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwyUlDVBVJ9k8GIPatISwM82nFDQHeytHwrVIENFQDTXchck6VQpBNCzJS6eZKjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796
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

 Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of mythilam
Sent: Wednesday, December 10, 2025 12:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: M, Mythila <Mythila.M@amd.com>
Subject: [PATCH v2] drm/amd/pm: restore SCLK settings after S0ix resume

User-configured SCLK (GPU core clock) frequencies were not persisting acros=
s S0ix suspend/resume cycles on smu v14 hardware.
The issue occurred because of the code resetting clock frequency to zero du=
ring resume.

This patch addresses the problem by:
- Preserving user-configured values in driver and sets the
  clock frequency across resume
- Preserved settings are sent to the hardware during resume

Signed-off-by: mythilam <mythilam@amd.com>

---
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  5 +++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 37 ++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index f9b0938c57ea..f2a16dfee599 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1939,6 +1939,11 @@ int smu_v14_0_od_edit_dpm_table(struct smu_context *=
smu,
                        dev_err(smu->adev->dev, "Set soft max sclk failed!"=
);
                        return ret;
                }
+               if (smu->gfx_actual_hard_min_freq !=3D smu->gfx_default_har=
d_min_freq ||
+                   smu->gfx_actual_soft_max_freq !=3D smu->gfx_default_sof=
t_max_freq)
+                       smu->user_dpm_profile.user_od =3D true;
+               else
+                       smu->user_dpm_profile.user_od =3D false;
                break;
        default:
                return -ENOSYS;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b1bd946d8e30..97414bc39764 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1514,9 +1514,10 @@ static int smu_v14_0_1_set_fine_grain_gfx_freq_param=
eters(struct smu_context *sm

        smu->gfx_default_hard_min_freq =3D clk_table->MinGfxClk;
        smu->gfx_default_soft_max_freq =3D clk_table->MaxGfxClk;
-       smu->gfx_actual_hard_min_freq =3D 0;
-       smu->gfx_actual_soft_max_freq =3D 0;
-
+       if (smu->gfx_actual_hard_min_freq =3D=3D 0)
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+       if (smu->gfx_actual_soft_max_freq =3D=3D 0)
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;
        return 0;
 }

@@ -1526,8 +1527,10 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_param=
eters(struct smu_context *sm

        smu->gfx_default_hard_min_freq =3D clk_table->MinGfxClk;
        smu->gfx_default_soft_max_freq =3D clk_table->MaxGfxClk;
-       smu->gfx_actual_hard_min_freq =3D 0;
-       smu->gfx_actual_soft_max_freq =3D 0;
+       if (smu->gfx_actual_hard_min_freq =3D=3D 0)
+               smu->gfx_actual_hard_min_freq =3D smu->gfx_default_hard_min=
_freq;
+       if (smu->gfx_actual_soft_max_freq =3D=3D 0)
+               smu->gfx_actual_soft_max_freq =3D smu->gfx_default_soft_max=
_freq;

        return 0;
 }
@@ -1665,6 +1668,29 @@ static int smu_v14_0_common_set_mall_enable(struct s=
mu_context *smu)
        return ret;
 }

+static int smu_v14_0_0_restore_user_od_settings(struct smu_context
+*smu) {
+       int ret;
+
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetHardMinGfxC=
lk,
+                                             smu->gfx_actual_hard_min_freq=
,
+                                             NULL);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to restore hard min sclk!\n=
");
+               return ret;
+       }
+
+       ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxC=
lk,
+                                             smu->gfx_actual_soft_max_freq=
,
+                                             NULL);
+       if (ret) {
+               dev_err(smu->adev->dev, "Failed to restore soft max sclk!\n=
");
+               return ret;
+       }
+
+       return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
        .check_fw_status =3D smu_v14_0_check_fw_status,
        .check_fw_version =3D smu_v14_0_check_fw_version, @@ -1688,6 +1714,=
7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs =3D {
        .mode2_reset =3D smu_v14_0_0_mode2_reset,
        .get_dpm_ultimate_freq =3D smu_v14_0_common_get_dpm_ultimate_freq,
        .set_soft_freq_limited_range =3D smu_v14_0_0_set_soft_freq_limited_=
range,
+       .restore_user_od_settings =3D smu_v14_0_0_restore_user_od_settings,
        .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
        .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
        .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
--
2.17.1

