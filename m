Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E95CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 07:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 510EF10E98E;
	Tue, 29 Sep 2026 07:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AIFQr8hs";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B5310E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 07:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjruF35lCoXu7vxJEYTVAhX2jTcJlluhwrp/HhiiuwV6EtQ+NuzKfwDszwIen7oSx5+WbV/zpoeYeYXi9iKnNgWXEGjufDWij74muAIdKPwIRlly74pcWKZm0ahheOdVVMDzBUkrEg2NnTSXWlLXmuhJDugHI/1FVz/7NcXMu6InZGsCvlEayfqGdP12sQatLXtonbub480dkhi+XQ0pQHs6UabLpMqryuSzeBULnoMji0Flr0ZHpihvA1WeOl/xOQ9g52zZwihbph/jXxcAPGiGrr17GrMNB6lIMrv29a0jd4JR+FROZoBqq2wej7qYCbDhIfMTWtKeKNCPjVA2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z93/W6r5kYtp+Ny+2+QggdasvI2fGPOrLmIHUpphS7U=;
 b=X7m2Egyfacgn4YISgbs41L8zdhqIzQzUR9Cda3kP6qxldAixOb7XrV+a1TUagGY41+uNH9BE+yuUwjbpL8u1SUc4Xp8UVBzGkGs/LRqm7hgmxriTzL9Yu2wHCGYTWBJ0JwoZAy4I5enPErIKO0x059gUgdRkpgaIDqLru+Oz6i+WCFd4vp6+sYf0tfdr0X+fOfnv3aTWrUkEcn5VS9IOaQvcuBe3MQOtxLevHq5oAl0wOtc0R0N55K74mURf6He7QjNgeHuQ+WCiI0pPc0VrhA1DgVXD8Wo5HzXgjQdkyTQhxTvzBSppZ8xNL1GMmoQPp18yKg86DoD2yNrCTnD0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z93/W6r5kYtp+Ny+2+QggdasvI2fGPOrLmIHUpphS7U=;
 b=AIFQr8hspQ7VXu0MjRVokM3Q5RNIhfdUYgiHA60vhs2VH+QC8UvH3daGsuBfoeppJ/17kZJn56edRHFya0x3K+beA1K9ao8T4RPHONHyT8kk75UEhlFtL1CwkdJtYq7ppz9R+YDuU8dbQLoDkmt+HMw5k2GAEYRL1IwiJACy1Rs=
Received: from LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 by DS6PR12MB176549.namprd12.prod.outlook.com (2603:10b6:8:468::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:25:12 +0000
Received: from LV3PR12MB9235.namprd12.prod.outlook.com
 ([fe80::fa69:b1ab:8128:4ec5]) by LV3PR12MB9235.namprd12.prod.outlook.com
 ([fe80::fa69:b1ab:8128:4ec5%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:25:11 +0000
From: "Hong, Chi" <Chi.Hong@amd.com>
To: "Hong, Chi" <Chi.Hong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Topic: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for
 SR-IOV VFs
Thread-Index: AQHdTxBHfNaTUsoRCkidkpaFmONe/rblI/3w
Date: Tue, 29 Sep 2026 07:25:11 +0000
Message-ID: <LV3PR12MB9235640A364B16BA772702889F8C2@LV3PR12MB9235.namprd12.prod.outlook.com>
References: <20260928061148.117428-1-Chi.Hong@amd.com>
In-Reply-To: <20260928061148.117428-1-Chi.Hong@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-29T07:06:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9235:EE_|DS6PR12MB176549:EE_
x-ms-office365-filtering-correlation-id: f304b8e2-e226-4336-794d-08df1dfacc30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|5023799004|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: QBMFhZj6hbq7q91DJoKmVftd9XpgWjLzi23ZhLdbdZXbU5D1xUPya9Fuq2/u9Xfg0SzG3AWLB0ETsYyHS+MeVtvIzHTpxF64qmG9nlsiZ8XH1B9sKE3E/9KQLw4WNwzhAca3FFtUfi3+TQco6q5IVwn7tJoqM8UTGTIzcYuzThXf1VPnVWh9GPFrluvSAoTuLbG9rG2JoM0ieJLXa/5tEAcIRglA0EAbcKRzG6zDpAPtJc9MX/H/4UkTw7dnTHfiU97EV8k5w6TtAunmhzm48LOzKZjIfGctJcpX7W6/VSNoOpZWtI3qQ0Qpi34ssqKFpapRcs1ZO54rxJUYC7mBwgSBarPNSNOU14/OvzR31aQVaIKAEAWWkd2gp0etStzD+G3x54Xmhyz+L89klGKm9GBYN5ZS6zogEQcdIdDvQ4qhvLZsyBp+1+nAfiAklkidhoMUsjmxm4oMO3iNIXoEXUn8ldDflo3aFXIepTvuHbSjsw5kCvMozbWqA3Run9YLk8TlJnYalisI81UA+dqNXlxUyeyLiB1DE88eR8FaxkHsdT7tHQIH7rQdSZdhQLbz28ud6+r41WncD+fj9OlYwNioYLTBQqUbXp4rDoQobAHhl073MomNso+lrWDwFCgks/pbs0t5dKnyH323sRalhypCp+P4d/5XNAcWBe1SRHJNooB2DSlsPYvNU85Ol4SLHcCuMJNLxwgHu0DB1Slprpfug4C3RlreiQCoRDeGOMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9235.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(5023799004)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PVVz7pAd14oKAbyuYNSTLBlB/E2RbImktzhz4td1QlKhBNYi7seWJjSh0eyS?=
 =?us-ascii?Q?R06V2w2aVPOCVaWo7lqM1SBowfCz1JrwZrrA5BDr1ovGXtgJJ4l4p+49Us0N?=
 =?us-ascii?Q?Iaiq0a93vl8ZHS/Zcd6mF+FuU9xaALWFDSCFbm4ZzmfkykGu0vZDSxJqP9uA?=
 =?us-ascii?Q?+u2JmlDLnl1WDgIsNn2qcW3elvtMWZ6zd1u+epiPM6t8qWP6Vzvtvei37etW?=
 =?us-ascii?Q?0loWZD67/aP5mHTDfFnJV44d00YJMl48qpVubo4rkAeFA9wlRNOmOwM4B/O5?=
 =?us-ascii?Q?gQw4mACYeloszfweQStNppIhVoJoMwUJdNBYPMAB/pWBHEaYY1HkSYkmJP+0?=
 =?us-ascii?Q?H1mg0A+ktMDXs9fWnrNgkjkYdPBH4PsmF75qVbOPNI9rz0/1FTvG9x/ZIPmj?=
 =?us-ascii?Q?5bn1EBSANWbkPpp7SSmkbamPgxV0GjlomylV2STfA6GpjnyixigjOq3y5EN7?=
 =?us-ascii?Q?9GshzxnDx+c0snhCW1UmSPQgxg5UW1gk6gOeSG60IWaoZqik3sWAE7qcEtFK?=
 =?us-ascii?Q?5OPgLSz5oZ2c63ebu6tL1uFxVeAetOz/PFnMmnTuvs/ia1mRrr8s2T4OBX99?=
 =?us-ascii?Q?JMWWyQdpdoLi8AdLf9R18/duOmhs1/K3Hs4pw4JlYN22ngxpLSnT3thWTDEt?=
 =?us-ascii?Q?1wG1xzURCqdb+mGjHgQ24DXM4vJ4t3S6KTF5LdiLAXuOcyCoTJx5wCIlCJVP?=
 =?us-ascii?Q?yYEg0z+6aHNWbRP/95odqkCudkCPxtc1b+vfoRNWWXj4Tt9eM4O6vvRNjCLD?=
 =?us-ascii?Q?Sk5npcuXRvFuOqzE5+rlKEFUeBY4xk2zrpPDCbxPo5wZDKrklbetSiUq7eIY?=
 =?us-ascii?Q?EatSK038l3T9BXir/bO1NWzo0SNxWf0q39aX2psXKxpqDdNOLSz/6e+dUqvy?=
 =?us-ascii?Q?cawYK1kZ53V4sXSZiUr0IIeQD68upr7dtERXqXgtjnLxSCsm7bFI0P1+kVY/?=
 =?us-ascii?Q?q9ADSfxRHPsPNG+9amBYjsExIPHv/46PU4JzgDeej/j0WYDNcbXlwPMwhbnz?=
 =?us-ascii?Q?eplWSHhPvYInRKKASrOuGfEKiHTh5/ePUFCivLDDC4eXDsoMWjjFGssYjBO1?=
 =?us-ascii?Q?9KQNV6zj+TVRAYnXdiJ2zdJDVeFrfbVMjoKOuGc7VqpPN2O9wIO6AtAe1puh?=
 =?us-ascii?Q?xYeAciy4yFdKTEvyM529B4apueHlP06Tv5NKZjgYUuJPzSrGTz9NjiN9Ub7t?=
 =?us-ascii?Q?NHP+gdvUKLCVs1JpCQlQIh8l8AQayzZC6CHUL0DvP+iSUSvlh+lXv87Qp11i?=
 =?us-ascii?Q?qnqOYmWNYCojoPCY7N531LWhKZw/wEUccqti7YmsqthvR4p4iuSpw2ZYHFEV?=
 =?us-ascii?Q?92XJo9j75NdNN4jZB8mnoG6HjD9NIA6T6YpkiINoFvTXiGbhJjEpdVRkh9Tx?=
 =?us-ascii?Q?1T+q1c5aZl37t7QxqJxE+8NEeFtXa46TRKB5TU+QTrQ7jupn+kBZpy5DUpBO?=
 =?us-ascii?Q?Wr0gPUrJGXuPd1uzVl8mEWLqlhgOlAAJHfCdv7PyNPkxhFADz7CYt9OpIIl7?=
 =?us-ascii?Q?RJM9A1ZDsIJcvBoedP4wgqJMr9ABxvuerQn04JmaAwZMdGCz+/eZOSQWpp+g?=
 =?us-ascii?Q?bkgmxK1svF408YY7bMrHY6ZY/52nw6kV8+t+FTfgsO4Dore1ERJFeSpChT9w?=
 =?us-ascii?Q?bIMzBiZAiR2fiRxptlSdZGJcKxf+IN0rpaup4nJGjA8pE8sQ5gTIaEr6Jxc9?=
 =?us-ascii?Q?UQsLgfjmNOr6LMF4Fw8OgOfAYtCg5QmBtrGCZWWhmf6rjAOG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f304b8e2-e226-4336-794d-08df1dfacc30
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:25:11.4593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fftf7kuTin23fmU1xJceigTK89SN6Mj8FD2nHvx77T/YBPMTAqDA6QYNUAhRFnDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB176549
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

Ping

-----Original Message-----
From: Chi Hong <Chi.Hong@amd.com>
Sent: Monday, September 28, 2026 2:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Hong, Chi <Chi.Hong@amd.com>
Subject: [PATCH] drm/amd/ras: skip RAS TA firmware reload on resume for SR-=
IOV VFs

SR-IOV VFs use amdgpu_virt_ras_hw_init() which skips ras_core_hw_init(), le=
aving fw_gpu_mem unallocated. ras_psp_reload_firmwares() then hits the NULL=
 buffer and returns -ENOMEM (-12) for every VF on resume, aborting
ip_resume_phase2 before amdgpu_fence_driver_hw_init() runs. The next hibern=
ate double-puts IRQ refcounts causing a WARN storm.

Skip the reload for VFs - there is nothing local to reload. The post-reset =
path (amdgpu_ras_mgr_resume_after_reset) is unaffected.

Fixes: 5e5be56a5b76 ("drm/amdgpu/ras: reload RAS TA from ras mgr resume")
Signed-off-by: Chi Hong <Chi.Hong@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..5bac792554f5 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -529,6 +529,9 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block=
 *ip_block)
        if (!ras_mgr->ras_is_ready)
                return 0;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
        ret =3D ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
        if (ret)
                RAS_DEV_ERR(adev,
--
2.43.0

