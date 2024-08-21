Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FA2C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 01:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C7410E759;
	Wed, 21 Aug 2024 01:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lmN/CLxq";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D5F510E759
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 01:12:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr6ZgfLpB2hYMOUtkGIsvxj/BoDbCwFyeyakbtTJzUgBmvre4WMn99u/nWqVW9a2kyI9S2ueT4tJbpr0i6biE5E7aQ2yOpgbHfD5kOshYaXzKjzlj24ohkA5K2PWQiv7eRxmYKb7fxFAMjksaZuKKkanz04zVQcq1g17N8Qk9ibA+c2lvLi7XC8j/td14VaDqBuQyxN+QqAMvCwwCE3TKHmImTFxePavOw9MOPO3/XhK2R+copMHTmNF2UmOkGzdITxDk/xe3RQwr++uZhX9FxapIwGs/LNrtHKE+5gvW6aOyBCReETFgaeEAEFbnrqTKvHhq2EuSnifhVHWu1MSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqnolWq2GK7oJz4BbIog1f1X7AaoVSgcaqe8V9NqpP0=;
 b=GzYhGkcJMMC1M29NDN6smakagUPGEtyDiDabHWFKc9RxdHMSDVO+KbXuBExL4V3BOU2gZi4zyYLpM7zwaJ9jk+lxypNFOne4uDPfnf3e0AQKqNaAcd/VjcJSWDPRAQa90Ap1rZilPPhA0wjOLCD+yaz0HY0WZ+Fu3E/JNL5Ux6w5EySNehYRJL5nQgH9UHlosfp7Xv9co8NxXbL/thivpB8ZLYpvR4LuXl65iC8+AYUzl7aYKtYjStkZCbV/D3irS6E4b7Z/zifMHxHkTVf5J52Rsd47NZ7+6wJdgg6dsV8It5cOMMzUH+9u8IgRcK/cDAdtneR/+NmFTI5V9yKR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqnolWq2GK7oJz4BbIog1f1X7AaoVSgcaqe8V9NqpP0=;
 b=lmN/CLxq7QpouN1xWqxWGDKG+KFLkxw0QsOeElNxQrV1ozEFIdap8JCU3jhUHZyhNRJ89R7mtPqoQP/1xy8mzgO43ztHO7OA7IpzX9UcqAeiHiUTR2p6MwBtctWaxb36SK+Esk9Th4coc/Y0UG/wM8EpEZPPEYgjzov4b5AXnbU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 01:12:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 01:12:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx12: set UNORD_DISPATCH in compute MQDs
Thread-Topic: [PATCH] drm/amdgpu/gfx12: set UNORD_DISPATCH in compute MQDs
Thread-Index: AQHa8yTKvGFMsO9GAkiB/ZRcrwJMKbIw6Bmw
Date: Wed, 21 Aug 2024 01:12:53 +0000
Message-ID: <BN9PR12MB5257A275CE8E75184EC555E0FC8E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240820171634.2015412-1-alexander.deucher@amd.com>
In-Reply-To: <20240820171634.2015412-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4f965cc3-cd56-4b67-93a1-e840c1aadda6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-21T01:12:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5945:EE_
x-ms-office365-filtering-correlation-id: 26524561-2ef4-45de-a3ec-08dcc17e621f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?YLJdCdWinW+fTR6x14tA6IsSqgsXwvmOEbp49C918LkGURxb5Zs2Tnywc0qd?=
 =?us-ascii?Q?UngjZZalTOYMkfvve9UamWwjqO9mrmyZs1a9HjX8sxaz6kOs+XLeRkZCeX5i?=
 =?us-ascii?Q?e4Te+simT30D0dZ9s9PiIxdf9kerB8HHSks2SMOs6MNFI00Lkz0HFWNohcOG?=
 =?us-ascii?Q?oImdiQdZsS2GByckgkd2u+XR29SWoHUFFv8NCe15YdqPgpCTR1vlXhdiQ0zL?=
 =?us-ascii?Q?Gwl2iSbl8Ui3m7CcKHnSkTfRsyG6XH1Hw678yd/Vh7VUoOFhslqlKklQugGe?=
 =?us-ascii?Q?EjHFeqtSBAUiqkZ3XSlAeoLST3us70SuQ//bJ3JRv4Xg4tcB4IxzEvlpdqsJ?=
 =?us-ascii?Q?uCiXMqvUCGWqmOa3YDHZYL2vBCfbukkweawOFY9uqMaiutFW94rY2sMHAyZ8?=
 =?us-ascii?Q?J6rwIIOnUjIt3GP9WwQkC6nGqmPxHpydSQJtY+2ELNMzxfs73wkoPYfD3IGr?=
 =?us-ascii?Q?gm6AuOd70mNIJRnLVfW1pIugQRyV/5G9elRDnldtxR50JW9VWNtk6myraPFs?=
 =?us-ascii?Q?1l3xCwxBpYHy9kvtI3SblGWkzk8N+mB4wNbi+DfaIm+79apoRcxSsce6p7uz?=
 =?us-ascii?Q?E4D/g4oLKUC6idiACYXNrHY3ZEBvlmL+janhvCy5o1tKlXoe7CZcBKWKuBEH?=
 =?us-ascii?Q?m22aoJ1cOvw0f6WLteaFqqzvGEtrXnJAwOlgSjSMLqlqfARNFhOd63tuaGLD?=
 =?us-ascii?Q?QraCegLRZ38bLql3LpwWF0DQlJUojTb7mwMKbVPJxe6alHecJciuH9Fw4GCd?=
 =?us-ascii?Q?lmrSt1df1CtTWeOUB1O4OD5TvueemL3IgcW3s3wP4zAB5P0BedeEH5i1STmG?=
 =?us-ascii?Q?aqvHYUS0UfnV7OqNIzffqP/f05sQfvjauOayy04pr5LSaX55HSYI22mHBa7t?=
 =?us-ascii?Q?6bVL86CDWI1TD6P5cIAGd/61bYkvq3nSX9YhpnTDHQ13b8eGGjwBHF4e5TyY?=
 =?us-ascii?Q?aZiB6DHYJBmxcnTf3dlxQdLaHpj2s+4VXjlOw2SEU03OfBTcrWCjRqC+mdsp?=
 =?us-ascii?Q?5GQhzx058ZxjPWfAxStUzZ1fFTwVH0cd3klHyZZdlylyXO/ciAOn0mIz9eu9?=
 =?us-ascii?Q?oQ710Q2PXs/QcjTAokOxV+AV+XfrlphNe2f7x+zT34nD1c75tmn4sU/fVx4H?=
 =?us-ascii?Q?nxOWO+q5oRRLcFwtprDhc+9Q6rfqPv2fIN5p0UHA7aB1sw+SlwZMru6rdCc3?=
 =?us-ascii?Q?Ed9MS5q7N67+4FVm23wVpXMfdE3WYxHHbCPwAQsE35UjNvQhps9el+ZqXWCl?=
 =?us-ascii?Q?p6O/qqNCSBTCfuB2Rut8f+JwKfhCPtHIhIThpepgRbzTomFz9Q+8/2UzmhrQ?=
 =?us-ascii?Q?9O43u4XtE7bcWeIhM4eodF19XLYjMT/lAj6DDTVqRbFDPHIqEO8AtmE+LUZ5?=
 =?us-ascii?Q?xmUAc3A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SSyhJnHCd35kCmRJRSUbhaU7GbJ6lkZNrh9e300OZ9s+HlDOozSpNWGwwNHY?=
 =?us-ascii?Q?+yJacmgPTUWy3NYmmDOr1VsN7wNC+vcWXfbAp8iGCywCK59tYKRSYU+rhp7r?=
 =?us-ascii?Q?LopczXjf+l4KmHI7PcqTXfOfbobqx3uLEul1i8C5TJtFtPznt8xinvBNTNZk?=
 =?us-ascii?Q?m8kJSdA4aO2gp4KCntUYAT2nAMFPKdJwwsmInriCwNMc8tsN95MdW4sIq0Xg?=
 =?us-ascii?Q?tocBWStm4ZcxrVAR7D4ytGNtQol/UNfVQqQcwp6Gq+dt6ejvWSDFZYWFJduD?=
 =?us-ascii?Q?WrrISUgEKL03EdE81gja5PGnq9Z0ybSOe6DhEm0QrdWULMXiuiwO7QLK9YE4?=
 =?us-ascii?Q?FmMFeemgl4LT+GlTxP76TMuauO4ZnOy0Vdw3yuqxQ+54yOng4HEHbpnbUgyF?=
 =?us-ascii?Q?5AgnwFz817Xtv65mxFSrfG8xt8DZfGJ9fr5K5zmobRtR9mPciOaVkWov32ax?=
 =?us-ascii?Q?vfkCjtGafkXb24TWq8jlYoC8GB32doKaDkNWm3j10csodoli/QQoL9DmfNwa?=
 =?us-ascii?Q?OJ9dXU2a+JBYajzkGRrRWzJcuq3pcXQBxmYM25cUGTmGFReyuEUhNYYpdYxw?=
 =?us-ascii?Q?K3h8PRr2qMHtQHNqj5I6iAm9OiyBVQroLk3r1OfCSLORu6jx7aXYML5W0dEy?=
 =?us-ascii?Q?UfpJsrnJarbwoJoAKj2zCUHgUFtWfkqU1BIQCST3V5zecyd09jgIWra6yDgd?=
 =?us-ascii?Q?Ej5C5NQU/cfu/z3HHOFz75vj8cys6UDVjxe+97/PQDPkjqXRWoh34pmkkXNL?=
 =?us-ascii?Q?o1xjbdobVNdWZR5zOBIUU2uy4ILHSaglhbFrgehdObAEsOTB+wIDorxnONK4?=
 =?us-ascii?Q?F7ckns/Vkz3/gzPpu5jbC1wlprX9O31//H+m/zfJKSEOF5vHyVX3Svi5gcl1?=
 =?us-ascii?Q?FSUJCAF/oqWlWvEQ0VWI5TLY7FG88ilIvOOy2Td7YK317gZQDb+oxqIRFYIL?=
 =?us-ascii?Q?hRgC0TGbulqv/oDBbb8Wbq0LWK1c971UBHwa89TQ0gfYbkIWRom3dlGEuYSc?=
 =?us-ascii?Q?XLHkAxdRO+fl0XbhRrpQp0Hu5dMX0HNPXsAx0Y6R6qg3swP/6yipacIp7vra?=
 =?us-ascii?Q?tNnmANT/B0GO1rMaVrpZPssApf23XczD3deNgcCZHA3unRXG4Fsm58QLPQmp?=
 =?us-ascii?Q?B8Kksk7mLjCYbHoC5aVGJTpzVMynYnHqrJxQ/TOZqcKMPdtXFbaQs2tfLEYY?=
 =?us-ascii?Q?ZqXF/6Av0Hs7N5geYiYfgzexwAiZc+TeoHLEZXO3fWZ8z/1KSXA4jIUxBGpH?=
 =?us-ascii?Q?ruP6UdQVy9QzvTjpajR9fBIC8VpRz3OY7r8HLNHMhFJrRkvNNjy1Ewvd2r0s?=
 =?us-ascii?Q?Tkw0erhprndh/3aOyiyweAO6zHnO/kVoxesD5mFR8felba/R9l9HqCRvUPj1?=
 =?us-ascii?Q?pfrTrOVic5Q4+65kDe+HSCcZaWrdo1JfBiGJKfFicTlLVzjsD8HyFz77Dk6Z?=
 =?us-ascii?Q?49URLKuJfgLyb9ZhTgrZKa6IS0K2NkJ+Br2YITJsS2wgI3itggrIZcw8wE3F?=
 =?us-ascii?Q?wcD82uMXFi6BLlvgZOKQgdginnSNdF9y5NQTbKndGoPkg2PpeH1dinLzZBtw?=
 =?us-ascii?Q?R5D7+y/LNL/FSFFDNuY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26524561-2ef4-45de-a3ec-08dcc17e621f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 01:12:53.5857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Hc0lMy2I8GUToMHJrYMdUzciBGHUevO1ZuywK8S/rJ3KmfmvsBQNxfkrvCr70tDLnNyzuvgAzJPsHFq5nG2tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, August 21, 2024 01:17
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx12: set UNORD_DISPATCH in compute MQDs

This needs to be set to 1 to avoid a potential deadlock in the GC 10.x and =
newer.  On GC 9.x and older, this needs to be set to 0. This can lead to ha=
ngs in some mixed graphics and compute workloads.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3575
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c
index 070546c8dd59e..6f700800f346b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3054,7 +3054,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_d=
evice *adev, void *m,
                            (order_base_2(prop->queue_size / 4) - 1));
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
                            (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
-       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
        tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1); diff -=
-git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_mqd_manager_v12.c
index b7a08e7a44234..d163d92a692f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
@@ -187,6 +187,7 @@ static void update_mqd(struct mqd_manager *mm, void *mq=
d,
        m->cp_hqd_pq_control =3D 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__S=
HIFT;
        m->cp_hqd_pq_control |=3D
                        ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+       m->cp_hqd_pq_control |=3D CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
        pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);

        m->cp_hqd_pq_base_lo =3D lower_32_bits((uint64_t)q->queue_address >=
> 8);
--
2.46.0

