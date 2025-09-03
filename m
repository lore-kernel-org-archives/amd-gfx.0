Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAF5CA100B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Sep 2025 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F213110E1D3;
	Wed,  3 Sep 2025 07:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QmKo4MD3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F1E10E1D3
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Sep 2025 07:06:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0uWi85PhHLeokH+QcwjyLxrKIEiMjkRVtQimKngidBd++/ZWmaptO6EcoaQJvlKfLS/YcMBZ+by+3hQtJEpRIDZqabQ4KYSyFiNHzj7wrdcOG6UAIVyrPqobZl+wEXRzjWKraLVofcxxkhP6kyK5JPEkj3HhfhriBBrYNM3BhtLNUX3+GUaNbhAB5MJyA6I9Da+/sNvrGY7gUZ2x0Mmaftsi2/JKpf+GrL2iXokXySEn6b3uyIFV2uRTvC6chLrCb1+5c6ZsZkGqxvGLqOc9E5K6STDKDl0zQD7/eb+o1Ycy2TweSJ0IEMWuO6qajoq6CItQPew7zljCk+k5ZO8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV2BQRb0fgUlpPXV+AwGfl9cjcKHaOk+abr5jdBv5B4=;
 b=GW/elKXPwLR02fzusJPo13gTQ9+Rc11JoI8Mm6Vgu2wRg6yl6ZEddgJbnb+dVCbpCHRAGK/6MLaXSov3HX38ZPBWNCyibJ3L61WJ2oJYmjNJ35irvpv96FpL209BDr0odNN4AA7Meze7SxZHrJ5ulb3lJebx1S2eWt+WsJadC96y5J47qoRo1HUfc2BFjauSaC6j27GxlOXayZDjsGSXsXCay9/PGLXnj05aHipk97NrOLhlJ7F1UReJ7kIsnHmt9aZNOWb2pKuozpeSTImTn8lTb8fZ8yyioWOflt+BaIHdE06uCxaXO9hHiMp6K+Ft825Z99zURriVjPiIEI2pwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV2BQRb0fgUlpPXV+AwGfl9cjcKHaOk+abr5jdBv5B4=;
 b=QmKo4MD3CDPjnyOA8YU1Rt9kdepKyKWA7bPulsf3DfrqsOwze7D+yyKQFZHALf4rN0Yb7GInahBkuR6EsmotpU+/3YaMdG+VckgjCWuHCaZZlCmVLA04Pg3BaYhSzDUHLVb72v/7OiYRWN61yO5J1WHGjZt/afd8z6wndXg++us=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 07:06:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 07:06:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct info field of bad page threshold
 exceed CPER
Thread-Topic: [PATCH] drm/amdgpu: Correct info field of bad page threshold
 exceed CPER
Thread-Index: AQHcHBhBH/SGGJt8D02zY3mIIcTwz7SBCjPg
Date: Wed, 3 Sep 2025 07:06:19 +0000
Message-ID: <BN9PR12MB52576E9E836FAE98368C8E7EFC01A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250902144511.67751-1-xiang.liu@amd.com>
In-Reply-To: <20250902144511.67751-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-03T07:05:57.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6070:EE_
x-ms-office365-filtering-correlation-id: 8c5d32c9-e607-4672-2497-08ddeab86221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Klwp/rmfcFx3W5gYIHsrMZzW+NXH+Xkjy9dnrLJriH3DQCl80ifrXri6YKlt?=
 =?us-ascii?Q?rxum+WnYlgIGzE5yB+yJvp7qrlKA6uvF2Dp6aDqE1IaaKVQMgFhySyFtrA3V?=
 =?us-ascii?Q?WeygHbgM9Lygqp7h1j+zX5XV9bvJef0AcIij5C1a+RPW/dxTDMhVI17SNAhn?=
 =?us-ascii?Q?yuHWGheRnBMaJG75mPeRgJhDa8wvkrSbN73KbAiVPlqyM1FZ0c9MV1neVne9?=
 =?us-ascii?Q?Gzunx8VSVTbllqN/85/+jQu5dAoMO7tHrwPMTjM9Y4teG0dS4ULn43/Rta8y?=
 =?us-ascii?Q?GnwzdWzL2sk6uJNR6/VjWRto7GBqn6xRsraX5TSoTp9bgKFgdw4H4Wa70IyH?=
 =?us-ascii?Q?da8qM6oddTlsZhyNysfeiFhsHqkMBjRJebZH7/6IdF0BH8PSRpWWn7hMrKUG?=
 =?us-ascii?Q?9IADoNgWsmgfGMzg7+J0/MqCFWG2TqDxfDRpQsPMotZOtzM8x79Giz/spK7J?=
 =?us-ascii?Q?lMbvRjc4H72bUzGa9j32Fr3YjFTHbNvqs3TepYZ7nouifbZjyklkiML1agT3?=
 =?us-ascii?Q?ulDNgqw8eNr2EWPaj4bSDxzmDFgijsXq44eEqLKnzdHQeQDKOn6U2zJk+DUo?=
 =?us-ascii?Q?rXqssSZA/Tv9iB8TsDO/x3B7RFCmIDZwcWWFp1CgiCoYGZ9tEtJ4YKFs0KTQ?=
 =?us-ascii?Q?UyrTQn/92C4MIFmSwGJDcj2HHPfZbuB7VVURB7gMOpSb43rt/Xtwzh257Y5k?=
 =?us-ascii?Q?sERr+bLMnNBz/CKuNyKZJMqDrsvGiICd6/MPUs6+5cr0gvQXNlXHjbXpj1uN?=
 =?us-ascii?Q?kV29p1925fyeAzc0ghaJTbRrMM8MtyDKTNmyTgFpvkfknw3Ha8bGhAcmsb4w?=
 =?us-ascii?Q?/J4+Mjfs/NzPRiQm/TcURFBPfwKA45l2nqBsUMoJWBzkvEqjULKlpzlrSgyY?=
 =?us-ascii?Q?QI3I1qbNnOihL7iAbd9SVXJ5Kzz2G9UzNRzA+msYvYuqAjpdILIbxzdps1a0?=
 =?us-ascii?Q?lnfk73Qre5wFwfjVL/+KWNRCKgAFs5YtCZ4bEJzaCOHo7Vv7Md65JPl8xWlL?=
 =?us-ascii?Q?zIrl+/kZ0GAg1Dnh0WlN90kzVQZVMPYuuIOt4mn7/SyX4I2H5pwB7dIhlpWe?=
 =?us-ascii?Q?rzyzQHUlJC9UvGsk5zhvQA1ie1P7ZYs5evEEfsF+tH5dxDrD2p4n+q4/Boto?=
 =?us-ascii?Q?SLiOyJIUjcpakyNG12Mawks5/7tX1r3Fflv0EiJIyMwj37UEviLHnk+/MEcv?=
 =?us-ascii?Q?oDLl+AcvI8SkbsU8MDX1G8tgJoBOip/3iLnCdHh+SfYPvQSqXuT9cMdAxLiN?=
 =?us-ascii?Q?+Kp4UTYvvjHNi+tVW0yYxy24iNXkb4tJNeDIn1k0Lxvwyoxrn8tPM5rUJu7f?=
 =?us-ascii?Q?VoM12kKXEgUJcpOgsYzqNSf/4ZUIIeEo+6BfDQeyBsc09YyEiBJvi4IK86iG?=
 =?us-ascii?Q?mY/1CdgVFRTADDfjh1LJ0NxoM2VAp4vQC5g+yVZ7eCYO/uISOn1LBDgJPhYb?=
 =?us-ascii?Q?PCGGpf6iI6a34FnT5XnEI3i9i4WhI5HxcArOAx4woB3ZinEnPiq5ag=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g438dPpF26M0ADa5Yp4dd7w8N1B3KpU4mwC53NCvFRqurrapYLv2gZ2XociV?=
 =?us-ascii?Q?/kU6nxDJ9d/y3VNaspq6fLjvd+2gmkeZhRhOgLqNjUG1kDDF6wFdgJoym/SL?=
 =?us-ascii?Q?8Lq3lZUC0/b7i3gq5SxcGfk4Q4zHEWtK33KVpeIwKbit48pxiixxv8Hj2Dtt?=
 =?us-ascii?Q?cQolWVcSzJuSOj/6+6uPZY56/eScHkMVuJeVgIPDyeApwDV8PPm63jW4mQ2C?=
 =?us-ascii?Q?1C6dNnzQswgsDXcn4XkjYOuYQk9RBXB3XoGy0WpebyWeMXx2UxotGbiOeuYV?=
 =?us-ascii?Q?ziF3hAhlAyKtBNoR/Ed1W61vy4HQjagn1Agga800kPH/weadVsOGe3kQGgJc?=
 =?us-ascii?Q?CSbD+n71vh+xIDRCt28yo/32J46P3Ho2hYRDzfIyP2GwZWMHfzNZ4SIboen1?=
 =?us-ascii?Q?mtMjs2gl58ZqlTRwn4CVT/sAGCn8n18TWuY4tzj6Pj6OfkQXwVwfVTZZGomu?=
 =?us-ascii?Q?LKLWIQiLKKI+rLHnvd58WlPA0sG26+KpCgdpGbAXa93Hk72imWI7XfU+sZpK?=
 =?us-ascii?Q?gQk6JsByJx8B3j0vJ+AWSnBfLdE43D6IBRq8S4V464LdXpgbhRBxoPmYfctK?=
 =?us-ascii?Q?Lc1IX+e6VypxaXGqu0N/p6Uta93LdKFdh0bgMoYA0IJMK7jIn/VBJgtGzRWv?=
 =?us-ascii?Q?pM3DrD+yoTHSkT2C+PTNQhvndSK1sWt7WeamV+inanTtdNAOtQdRJZMa3GWq?=
 =?us-ascii?Q?uEwzn1v0GtI72pcifdQ7LQcRJ8vnVPtwyZnGr3CrqM9CtvQO8PYYbd6x7T+D?=
 =?us-ascii?Q?kDIf9oi2dKDB6mPcku7f4AfkchscJem2c7DXPNi6835rtMlJXobk8vEkqrkg?=
 =?us-ascii?Q?mKrZ6O2OOvsMSnMGhD6+TN1W+OuBaFNtL4wtPDclfHpw6UytiYSuUK3Nrubc?=
 =?us-ascii?Q?bncgdqwwccT5lgv6rronvDREzScPJj3Abtl+QlCou/dPy3Fq16DOyd8LkiAE?=
 =?us-ascii?Q?kKKsIcIrP3iRlarI1IzzdBdyFd495ZUi/Kgeha1mJtxLNs+KOfEG19IFcziM?=
 =?us-ascii?Q?ucMyrVxp3jP4ZKhCJHEgGSSq1ElJUtFKHPaxPxJBrfOxKaquF0odgw2zsuh4?=
 =?us-ascii?Q?CsKa4fUOiJTkQvnsAGHcZnb4mKRtgEULuKLB7cVHZr+wHwvKBLZMvLEiRKDR?=
 =?us-ascii?Q?Awu4GYzopI6bjLND+3lSVgvUJl/Nd/meyJdJXH/hNm5YexY7zBTcHZ4aV3ta?=
 =?us-ascii?Q?sUzw92pK8OJNTVkMhHLky/Rz/eK/ARoGaNWopmQwcvKDQRWPotA6KmFAdGkL?=
 =?us-ascii?Q?uKN3t+mNNRaRMtXwjylc+B6wDkpEwXw3acjm6vIYjlRzkQQJEee1ok9MCpJ1?=
 =?us-ascii?Q?Yc3ebmcxVIU+JfKMyOOodRJHpjsHYBUftyELGR2gHXdJutUOALIq4vxieuRk?=
 =?us-ascii?Q?g1Sy8KS5EEJbSemUB6uoeqTsWEhDafNSq8oLWmsn+fIaQ/OGEekwgz/VZilP?=
 =?us-ascii?Q?1gPf/HQ1GlwxRnT1nJ+5bIq+Ug2GOn9r24jF2MbboQi8xNJdll4/wocF2NmM?=
 =?us-ascii?Q?H9adtXN46UbLlvQd3OmsLZ9D6EsHhgYx7LpO6HY0QhOEFEO43EKdIx1mXeUL?=
 =?us-ascii?Q?sY8b6pIipAgnWy1Kcz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5d32c9-e607-4672-2497-08ddeab86221
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:06:19.7480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBjw4c1cPhVbqaOtE3HlQoBwOzEp0f2mWEtuiyNBgJl9kD9AneGO4ymlds5KPWza5dNOoH35lYgdqHTP3JkpxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Tuesday, September 2, 2025 22:45
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Correct info field of bad page threshold excee=
d CPER

Correct valid_bits and ms_chk_bits of section info field for bad page thres=
hold exceed CPER to match OOB's behavior.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 15dde1f50328..287a54086620 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -68,7 +68,6 @@ void amdgpu_cper_entry_fill_hdr(struct amdgpu_device *ade=
v,
        hdr->error_severity             =3D sev;

        hdr->valid_bits.platform_id     =3D 1;
-       hdr->valid_bits.partition_id    =3D 1;
        hdr->valid_bits.timestamp       =3D 1;

        amdgpu_cper_get_timestamp(&hdr->timestamp);
@@ -219,7 +218,10 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(=
struct amdgpu_device *adev
        section->hdr.valid_bits.err_context_cnt =3D 1;

        section->info.error_type =3D RUNTIME;
+       section->info.valid_bits.ms_chk =3D 1;
        section->info.ms_chk_bits.err_type_valid =3D 1;
+       section->info.ms_chk_bits.err_type =3D 1;
+       section->info.ms_chk_bits.pcc =3D 1;
        section->ctx.reg_ctx_type =3D CPER_CTX_TYPE_CRASH;
        section->ctx.reg_arr_size =3D sizeof(section->ctx.reg_dump);

--
2.34.1

