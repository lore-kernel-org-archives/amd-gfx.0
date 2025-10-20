Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6F1CCD195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 02:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B179310E246;
	Mon, 20 Oct 2025 02:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ONILRD1k";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC5F10E246
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 02:38:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV7hSFcgqFxK+U6aFxfT67MrzO0VAoTzVPHI78Lkz+HTyWTODoYbj2yKvYr57CkNsRxQhwjyN+2wLTA3y90qILboBTyNaBcZ9PW+UvxsR2SMsfcC6ha+ti4oUIIIH2WNA1w8OYBTyQDP6p8ZrluLIIma4VDmWz/FBXVxZjde2L1HOLA1P7zQM4pAe+g49opE9zYhoyXUoeryN+kyEt/QoyLVLhAih5UTROVi4HSklruFEpH/W6xbJELA7D5orNCBR+ckkYBB5CXE6yl/9YU1CbyedsrEtiWW/cUxPw4x3QswlGHMWfE0Uj/WiFzDvUbuyCggl7cQPYvo2ja6aDQDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEhPwcOAb4/ixDtT2M+8xERTf3Sg6iPL4eYRAcdcVNY=;
 b=rKfkHvnx8Rwf6FI+zwxn+usukST/I3J/iUYkIA7gM+Kt3QRbmhdYCwM5BjmRLgG5HVD1Un4BiaThGSSts+tzTRqGSOtmHkJUE/5f6Ac6BDnNCwK6yAVcomxAA/Cbyy3hKSjJOKw7tZv86nQwxHOVXAyYG7FgdXosmEbBwskVIRX/U50C0dhSPp+O2JWFn5xup2FiHtMttsoLkOyVnF6QY5Lu04czgUwYyVhb7iUEnn3iVsyHlX/gZz7pKa6C4deLRV8YWWmnwuLLV4cmY6qFkBgA0TqTfzFORD4ufkbTLJDEk1bD/IQkzfCJJyyDVKDQHklpu5OfAONklAGEBcXIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEhPwcOAb4/ixDtT2M+8xERTf3Sg6iPL4eYRAcdcVNY=;
 b=ONILRD1kaWBuTdUwjdvaiHGZEWzAedc0bnjmwLz2btjpYgnaNw9UxUGUKC1qFWIeuo9VocFGK0O5tPviNadeNYUTUkFVCka3+RsU62NvXpSETxpshvOYOT6VW8OrZqAqXc1oCjkcTI7Bf4rFMzi6x8ST3oVgBLPjMaVfqY4nv+Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 02:38:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 02:38:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: query block error count of ras module
Thread-Topic: [PATCH 5/5] drm/amdgpu: query block error count of ras module
Thread-Index: AQHcPzsJAFxSBiNfHkCs+3U0qmXkHrTKVpEg
Date: Mon, 20 Oct 2025 02:38:07 +0000
Message-ID: <BN9PR12MB52575D5DFD1D2A2487498677FCF5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251017075131.23939-1-YiPeng.Chai@amd.com>
 <20251017075131.23939-5-YiPeng.Chai@amd.com>
In-Reply-To: <20251017075131.23939-5-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-20T02:37:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8516:EE_
x-ms-office365-filtering-correlation-id: 4598d3e0-446a-4d2f-b0b6-08de0f81b3b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0xABDUy3InOeLCk3BQIzgHleBKXZme+5fJ6oujxXiIut6kR7lh0izy/m8v0H?=
 =?us-ascii?Q?TTaytOWf574WZQh21+fixkYRsowju280IMGbnUQtxNXu0t44uQKRgO16T85W?=
 =?us-ascii?Q?q5Op0WnSdwBS/sZyg5RHzIol4//muJlH9gHH1MT43/7aydP3y5A2JgX7NBIv?=
 =?us-ascii?Q?exOVEzSUrhmgieuagdpmqCY56maGWbg41hIstNgxOpuDjHpHAWzaL5rZ2PEX?=
 =?us-ascii?Q?6Ub5pOosEMaDy756iC8TXrItOEaIgbuamqvPgnirQv2RbOqooMPRuNZ1yElB?=
 =?us-ascii?Q?E0ouvGO3nGMAeND/sAZike4DnAiorwCOwh8qr3IriIkcXDt/xt9xs5WBePcV?=
 =?us-ascii?Q?9Y1Lv+BA2B10Gb0GsDwbrqCvbnz8cvemurt9+1LbATvWvTOoI3DhbCKkYMs1?=
 =?us-ascii?Q?E9Vn2Spirg1hFomfcJj+m9Cs1JAY9urvD6tK3iA563obWdvvsh64O7pub3oN?=
 =?us-ascii?Q?/NkaioHx/2iyqPF5gpFp2MXaCFzvlsrMG9WziUtpLZpokGy3q9lqM1DGINr+?=
 =?us-ascii?Q?NlHXLDyzBM71SXjrpPN+zM/b+1fJvufZryHTGInJlGT+wuhnPFgwR6J+mqVT?=
 =?us-ascii?Q?5uPQn45trBaFjXq9o1XcbFNC0492OwUyes0xxYjqgq5QPktPROSVt/1V5Zll?=
 =?us-ascii?Q?cz4v4tZK2cAyqXsoztRtoN5QIPEVx0YF1Zn89Y/HDr4gP9w9VOKRsj6VjW+s?=
 =?us-ascii?Q?4+OM/E2sA9aow5lsTqq80ytpd/fnnBueTEGTvrX56u7JQhKMX5RWrzSKl+3O?=
 =?us-ascii?Q?jZcSrOvaYJ5V5Cmfcr5NLMGrqj6p37BKii1V0bmdFLcv+MErK3CXCzG4FLtU?=
 =?us-ascii?Q?ZoaNSAD3o2LvOcVBnAU6M89GDrXRCzXkPPv0qYIbLYtMP/fDtXHaV8EFany6?=
 =?us-ascii?Q?HTrM4skjaZvqYLOTM1Dd95m971qwo7xxptaKbAiLyrFpPpXLeR3ESKKK8Vrc?=
 =?us-ascii?Q?6vT5h86+xN+L5t/BkVgoAF4tUu8Zt5oEcehtJ14ytTRdfcy8DSzNavEcXeYJ?=
 =?us-ascii?Q?4LpDerT/GFKd95rz68RohxpI931NRYJJNsv1foGKZf63J/Aa/NNw8mSok+RV?=
 =?us-ascii?Q?aUQrV/wOgJY7RCURVpZhVRzcLIGXY2dYpivOp2WZLfr3mnl+zwZw4UHtj11m?=
 =?us-ascii?Q?f8J75BemG7GwQfMqwdjmf+7Kp9MNVNQCVl/P6NlPn1QuBeC4K8buuaf+/8af?=
 =?us-ascii?Q?Pv2AiT1uSb/F85lbwDU3lqo0DN4gH/SR8KWTRULLWB8BqQzioNPG6yeJ0SU2?=
 =?us-ascii?Q?cyI9OlycsDNCypXtvH8jSj4AZrFpfLlam5bBA3358c1d+CMha3vIUOSwvZ90?=
 =?us-ascii?Q?a0/XZ/tGSRuw6Q9ZqDr0BEFUECWQ8MY0tcwArSV8kBniElN18jucziejoQY6?=
 =?us-ascii?Q?1VvqUbw8OlC+DX44k/xuA4DErGCjoX2xkS1/VHZ6pnVe3QfJBFm+OSWjgTtt?=
 =?us-ascii?Q?gDuzxBlvfMArktJuYrU/3EsHZyjE9rzBfQvNOkKFP8HL6bcosO2VZzYI+uj0?=
 =?us-ascii?Q?MfKIQNjtubma5VvTfGV8LA0g66tdcVQRGqbm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xTkDGYI+axc4z118MXxHxEbpgfx7zh12vwoSE6gKiRrhpFzI5JxzQO71TZ8?=
 =?us-ascii?Q?cg1YWb8CE9o07nPaRLtcIOcFDOrl0IVkZnMfZuTCFvca2h2AeoQNo2Qkvxb1?=
 =?us-ascii?Q?iDTTEJv1zesu/K+G0WVGeFD93uB+fy+/QJO3noakToNUulYU9IPUYTcNOiRP?=
 =?us-ascii?Q?mD6k8Xk1yLFY1Cv00C/lKkDDmOSSlvKuHPsfq+AdAe0NmZXWPis6sjm5PZT7?=
 =?us-ascii?Q?EmGtQHbxXAG+35I/ne4+mycqSjU4WJMwAU6RJxF7WLvICtw7/Pf0y+5lAuYr?=
 =?us-ascii?Q?XRUuL0pGvfFMAVjT82XRIO7U5e+BfYmsuKLiAfDyoS0ZclqAy2Tk+AtkvxMF?=
 =?us-ascii?Q?4dg353ikQOQwx0Ziei02Te+aYdb7wSTGtfMCrtnhBfA2oLyEYle+yrNPHIF0?=
 =?us-ascii?Q?oTMhKrZ9Ti2wEPKgXrtEPTe/kqWUrzu4VLOb0ZWep37LsVqYWs1hHWRBt6e0?=
 =?us-ascii?Q?AcVlrWH6+DHepzd4eFzojD6/KOqYRRbbcmBUVdCQKDOQgaEcG1+6CNUeK73A?=
 =?us-ascii?Q?xBWJ5MD1+ZW4mYpiClQCWT7efCWDQybKGxkcyfgYjVu2JhD6ne/gwU4ijiMy?=
 =?us-ascii?Q?Hepo1lWjTdcCD/hllNsH51C8hUNA+RboBd8HQSED8YP+7taOCyn13UEKmpZO?=
 =?us-ascii?Q?zolxU2LZeBwuVVvsy07l3J0+u6NcEvmkUH0OC3oksRhaQjdbN9bWzkXTRPgQ?=
 =?us-ascii?Q?aRVbQ1kPW+QGKJjGb6aT9kGNaSSHbAs59Ox2PmvaYkWk5q8//uSyf5fSmjcU?=
 =?us-ascii?Q?vLW5DXm7Hg54W/8zCsXt2D76KhgSYQGHzTv3HA46S4SVHBn/B5Cv+Fz0i8EY?=
 =?us-ascii?Q?4v6Zt8VledTmj6ZKn7DdFR6RsrSDhqDi/N7Brj8f3xw+xJ42fbSDGTx3ti2+?=
 =?us-ascii?Q?GOofV9/NBTDn7qiHW83n9VVPKpJlvs/A+vBwyBBb2Tq7yuAR3BGCtFtGINFz?=
 =?us-ascii?Q?dHCsfl7b4VxQ3ryZ2RABi0B8ygrRtOU/9/mfs42VaEo0O2jzLQnA5uvFFC9r?=
 =?us-ascii?Q?3xCUA8I4AE2dyhB5fDTnJO2on2R10dlh3Bc0C55RWqgjEnOCQh0ui/0/Pn+z?=
 =?us-ascii?Q?y2otcSlsJy2nYTWjHs26dzotzCL6cBpEwQisxyUs9v0s329i8eccjMLIM0pQ?=
 =?us-ascii?Q?BC7B/+O4MiE7hJTDxWtG+sr/QogSYXrt2bpwkXHb3QLR7TqHe8tUDyeSmPGM?=
 =?us-ascii?Q?XZK1/VSgx5hgsLrQih3Zba1pVW/MrIUou37cc0wChAOeQ273Vai5RDBJx6+N?=
 =?us-ascii?Q?6x8gpSCSjLnAZ1fCeXOirpAwJP2/jdMY+QYWyWU0UYYrNWZ9JRRklnDEi13s?=
 =?us-ascii?Q?NhVrB2iHpmzMRTfa1GUo3WodOqZFp1Cy1eH3dcqqGC1838ay8LOsXtq1PuYM?=
 =?us-ascii?Q?2goZrz1T3KVfU2ptikLb1RnEjAPS/Mvqjq5U1mmFL91us2t12VvWZdX02qFU?=
 =?us-ascii?Q?sFuGyY24lCbN37QHFj5y6KpwLNqfApOqEnLJPk4lpSQ6gxwEKZ0FxpbCJm+o?=
 =?us-ascii?Q?1E+6rWtDlbG+0lL1enCwgg9YQKcqwk8rOSpHIUTj6nhKRBilRsn5iHmCPBGB?=
 =?us-ascii?Q?UpZtmWIbRmvuwBZAuwE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4598d3e0-446a-4d2f-b0b6-08de0f81b3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 02:38:07.3267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weqN+dIxj+mtDn8720t5aNBl6PXtefVuDexWjza6fOhikJWQH7wXGNRBdqB7LB7YlGjotp5hoi+Am9zy/ArvaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Friday, October 17, 2025 15:52
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su=
, Joe <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao =
<Tao.Zhou1@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: query block error count of ras module

Query block error count of ras module.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 29 ++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5d5e1c0154b2..3150d736a4e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1543,9 +1543,36 @@ static int amdgpu_ras_query_error_status_with_event(=
struct amdgpu_device *adev,
        return ret;
 }

+static int amdgpu_uniras_query_block_ecc(struct amdgpu_device *adev,
+                       struct ras_query_if *info)
+{
+       struct ras_cmd_block_ecc_info_req req =3D {0};
+       struct ras_cmd_block_ecc_info_rsp rsp =3D {0};
+       int ret;
+
+       if (!info)
+               return -EINVAL;
+
+       req.block_id =3D info->head.block;
+       req.subblock_id =3D info->head.sub_block_index;
+
+       ret =3D amdgpu_ras_mgr_handle_ras_cmd(adev, RAS_CMD__GET_BLOCK_ECC_=
STATUS,
+                               &req, sizeof(req), &rsp, sizeof(rsp));
+       if (!ret) {
+               info->ce_count =3D rsp.ce_count;
+               info->ue_count =3D rsp.ue_count;
+               info->de_count =3D rsp.de_count;
+       }
+
+       return ret;
+}
+
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev, struct ras_q=
uery_if *info)  {
-       return amdgpu_ras_query_error_status_with_event(adev, info, RAS_EVE=
NT_TYPE_INVALID);
+       if (amdgpu_uniras_enabled(adev))
+               return amdgpu_uniras_query_block_ecc(adev, info);
+       else
+               return amdgpu_ras_query_error_status_with_event(adev, info,
+RAS_EVENT_TYPE_INVALID);
 }

 int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
--
2.34.1

