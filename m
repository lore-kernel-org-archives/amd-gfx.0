Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8640C5B552
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 06:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633ED10E73A;
	Wed,  4 Jun 2025 06:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ky/H/+cu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76FB10E72B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 06:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLnkUf5cSJ7EQJqaBFc5NHE8qmDm0+K8q7AnO39OE86P5vAT8vMmzD7Kl8OVTMb6Ulu3LvD1jTPSEDr9Hw8BA6Um2dvKWyxMq1SXBLMvwI9C1TY8RGCR01AH/T04K9SyGFr/QOHDCaXBDi/u+ghIU4Tfar4u8E5XVgkaNNy1lL5exh+9M6tDstdEBek1Hu8n/P1/kQ3gjNaob5blbEV3QH6PJv31DmaZu/PPaIiFZvJiK2v0TM0oaMIeI9Npd315KDNI3rYyYnSRkCBd9eIANjQ0jcE66Bns/N+zuVNV+VrSA/wIB/Ic6rCwAP3xN6bzyevcPBZdXxpqMz0lsBU10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGPXBi+MMSLF96/dRLjc4Rf6IDy9fIIz5CNF+kCopGY=;
 b=O6AK68IiwU3jekhm+ELm7MyFjYRR+isflgTu+TiRlipGJ7elSYMnzJ4onrHnZiWDiDyAuNGo5nv1kT0KViiaaFmW7czfCPcwEbQb1VLX5H0gC4ClLzF1rLMKZRk5GBCOLYjNsYTt1bKB2kS3Vo/LCmwgmOc3Rx4b+qUQKGgqRRKGVjlBEDu7LRsntb5tHZHXjV+t9Kjm9vx2zEsmgJEmzQlIWGFm4R7yP3PGhrxjck1cKwSEs7ay2gHBwpSVsABfsbAPQ2udegUs4tiZQMBiBhpmnBxSrtj7nTuCWS6MUxlLhx2nirObxUglg7MdqFbK0XS6KlMhsixOCayKDhiBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGPXBi+MMSLF96/dRLjc4Rf6IDy9fIIz5CNF+kCopGY=;
 b=Ky/H/+cu1FZbt4vhR4UBaJcRMW+oyFH8K60xlo7myiINcaf0bel+XjycgM55D4TrCuQdV/g9/RDY8zG7T+OFbub1zgLW4YSpuWv27N1mdsJKMKkMAz2Xq1a5YpL1C8on9RLbQaEauhpZFiCERtNt84AjBm/e0cLHkEGViO3D00Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Wed, 4 Jun
 2025 06:40:28 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 06:40:28 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Clear reset flags from ras context
Thread-Topic: [PATCH] drm/amdgpu: Clear reset flags from ras context
Thread-Index: AQHb1Qanh6bphp8TxEqxsdzgqkggC7PyjPgQ
Date: Wed, 4 Jun 2025 06:40:28 +0000
Message-ID: <BN9PR12MB5257FB2C3547E0FEDEF36F54FC6CA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250604041028.643571-1-lijo.lazar@amd.com>
In-Reply-To: <20250604041028.643571-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7de1c0d4-c8fd-4499-b68d-f6640c68dd0f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-04T06:40:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB8180:EE_
x-ms-office365-filtering-correlation-id: 9fe2509a-0b3e-4e0a-04b5-08dda332b1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YSeBIwTcUJ8rjGMssNIlNzSALK7YSoqmBTRigBRUih/OYzs+Qt9ahVwzAQPI?=
 =?us-ascii?Q?y4KUoxDpCN3NnavmzTxTRRL8a4KvEZiEQMUTzcWtAuFkcONeqK9Up8iBVQqO?=
 =?us-ascii?Q?DUhR1CGWfuLW00/DdH/3/PyRys5Q9cFlBOGOhUMuIPt84KB54cDV/w7vC12N?=
 =?us-ascii?Q?RlwaIxfbbK7cGWX2wK9V5PkN2rMmYGBZqWYVjn7kvfvPeqdF+kpHR+Yqs6bl?=
 =?us-ascii?Q?35OWet4SK5z+swnOqHPrVg1pZnD9Rax6TWDdhJLbIABUlTEcUJoTq/gKLrlf?=
 =?us-ascii?Q?/XblnvJAHFwGG7/6QuF4h29DLEkLlOE7ykSH+XckHhJaYuNT0yxhJL5pEyvb?=
 =?us-ascii?Q?VTP4EGewE0I8e6LU9QjK2KmIDcmTGN8CJ9xv6ocIck1/+7HvsODvpzwAI/sJ?=
 =?us-ascii?Q?35JRFAmJioUbCoXNDAI+lYKOP4zmsZSN8ZK9P+lnSChhzgqFATffj6i4ezO8?=
 =?us-ascii?Q?WNRbNq0Exm2RiXVEwjSlPAoi1RRU2+jFVrKXzGVWL6MJLTWEKjk/6ndxxDt8?=
 =?us-ascii?Q?7E+Wqz0+WUrhSuv5M0LPq8pNtN0NKDU8/Np3Zyzx5/8q/8kp8ZLzEAV6gkzu?=
 =?us-ascii?Q?7emEgbSiKPz9FPh1rAvtyx+KnsYAQ9HeiI62CvnkGAyUX1qX7I3DLPa7vZFk?=
 =?us-ascii?Q?vtK1AbB87/fsQX83lJbOaK/oCjua53Bewm9fMGYatPyzWXH6guJjU5GLTcaH?=
 =?us-ascii?Q?LH2G9ET3DtFnvtEA4m4xhC6Okf3VFuA6khm/7PZw1QJfvwqiPUjpL5x38kUJ?=
 =?us-ascii?Q?LK4YLK1UWPNGWrUoUx955m9zMbxQ5CQ2DoTTcbI2JwA/LB/CXCbocm+/1RGH?=
 =?us-ascii?Q?RMoiqyM2nzX/LT1c1MYoVcEVkY39bzOPYGSFllfwkqznXFLfd7Xoj0kFOT+m?=
 =?us-ascii?Q?mRMXKim5tMbGAbihEVhAEE7Xx+wYit5JHp9dCsTOBcCHcwjvD0lqwMpo9zoX?=
 =?us-ascii?Q?fsY5PtW8zkAhMFxE3aqCSbEKEFdmiGV0fJeiV/2cNJE9Z+H5JFk8OUvclUGh?=
 =?us-ascii?Q?ulRabDcJfswzJKTMdyGUHyYVbtunPdq9Xm52w5YU7Lo9W0oRR85WjjR3g2Fh?=
 =?us-ascii?Q?Ad/lAT11pMxUO3Vi4EWPzG1Bz7SdNCp46EXe4v76R5lM0u4SUk5FCp+0r8dF?=
 =?us-ascii?Q?XWELOxWR4o6Wy01XhCrT+q1+hssD0S8IVd+BQvQbrFnqE6Yo02UnwZ4Vr0/8?=
 =?us-ascii?Q?q7qsooJU8MM8Q8k3h7A3vNBQie/0ooWpMsjfewRwRf6K5ZQ5mQ50lKDzYVih?=
 =?us-ascii?Q?yH5tVMrz2CZIk0oKp493xd7qLvetSh8ASxs7NjpTRI5nuA/Ux7H2CLa7Scq1?=
 =?us-ascii?Q?aZ1/0q22vPRuMSoeatkdQi46eL72P7vSCCbwDs+8KMKGzw4VwupJ7CaotLOG?=
 =?us-ascii?Q?1Ci90j/u7XI3EMe0sSxrDRRJvV8a+6EQqRTtGpqKIXC6may7Y6VSxA5t66li?=
 =?us-ascii?Q?H1mweMdFjzZPkPLaZnjiOaMJfHBV+ZkyxItB3HVx3fhcq9Mrt5b50A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qG6jCrX70eS1qtxLyui0u6yg4M5CbIBPeOjL7etwCyDQQhfYtXWpfEoRAMaE?=
 =?us-ascii?Q?s1X5moW3qZFd4ZO57U64tl4o/YSYNSAM7ieNtKFURuBr0ZCLn4/O3i1VOlvG?=
 =?us-ascii?Q?Bp/GykxSRsi6SIu5Dp9LDAcTeVNDpJYKtsLH6ZjSZmbloOmVcoicOSq1xdE3?=
 =?us-ascii?Q?Mt92WeZzzWuTjmZKT/X+eYBtKrWLq2nG/4WbOT8QTc029/fgmciQqWrzF/Kp?=
 =?us-ascii?Q?N0bMSqaOyvl8e/MljRWsdTTtroqdIc+nChwk5B2fT3T55EuVWsywXDUxu518?=
 =?us-ascii?Q?PEQFzkwd17jw+qR3Jdpn6bDdAF/Z5KnOvYAq7mKNvczB1gT9D0dIyUbnmfjQ?=
 =?us-ascii?Q?xJMlqNYTS7H4B+Al32NEuUbFjY6RLa3aiXGJMDoOoCKTZ8Dm5d/AJMUMcbt8?=
 =?us-ascii?Q?sqCVDqSSKwwJx8//IkUhaTJdLUaaQXbEjOvVnmvN58Yhv62MSOmFYxgkZ76D?=
 =?us-ascii?Q?I/vW86p+OVlmdat6cNZHPJ78zF5GLvH4qyPUortSjbfanP7JuHxnu9Qvjgj4?=
 =?us-ascii?Q?BsmK1tHdavxr99RIwX65dF/bPDT2dfbLmUCm0iHUDtbTChJyz7CAWYm2qet7?=
 =?us-ascii?Q?I+VdMXV3hyRExNT+B9aWg++J9hX0kXpBxPn0FD+jWGOYLv1FCIatMmci7piU?=
 =?us-ascii?Q?z6OZyLG0/ibAWwIzniidRCN0hz7J1DpT3EjBIfIkemFiSUiQ4wDGLtU2rp0m?=
 =?us-ascii?Q?/DpTUIzVoehAxNO9VZCjNPbwHajlrb+s+VLimGlxm0dmqCK3VV5nlFxobhKB?=
 =?us-ascii?Q?yuzbiGP/v1Zlxqi1GcuFoPUmwuXgjyfjam8Uhnltlc82w68EE4vVGXuQHL8X?=
 =?us-ascii?Q?u6SRCyuo7a/g2PJZIetiQQ5uo+kMJZS7m9X4S/aDehIycfKfIrIIKcNtdF+E?=
 =?us-ascii?Q?wisYBKNU8AcBWrFokM6zAJZjwyjYWHc5xTFXMGA30/dpu4Tc2KAJUvdZHCzS?=
 =?us-ascii?Q?iQ8pZ6Se5VQacguw0fma3Er7Dem5tdoFvU/ctyG7a3w50B9WvIq+FiSoyavZ?=
 =?us-ascii?Q?TJ4jCb5U2xQuaTOWAVsRTT/9caOUHfEx1/xucCHkbMvD/zAQ6S8pU+kWslXc?=
 =?us-ascii?Q?N56RmZZ5DEQAaoK571CLzg0Ru31HYT0bhW4lsrUNiLTVCx8d8jeFzlIGZnO6?=
 =?us-ascii?Q?nlxxAHoM4U9oxUQixs6gIt7tM2KgRClej14gtpOUT0YkMUmfYn5xpgN/eUr4?=
 =?us-ascii?Q?N3htdp4LT2MPh2KNpDWmzix1pjv7S21U5SLB1CjB/0UNEiCvNcHzRgNGymd7?=
 =?us-ascii?Q?FQHVAbhVJ+bEORuw3bjW5WTJLrSHVe8fuuoCG3u+AlNjzHQBatehAtWcxypu?=
 =?us-ascii?Q?mYRSzOdC94PNeA5GbS91f07XdF7qsr8qxLUUwT9OrYuEcDmedxOnh/kFWG34?=
 =?us-ascii?Q?sbjKoV6aGv1Kw/zGdF010h4soj953z4Fzzy7bQJ06RjSzUJ5s6dGilGsOX4y?=
 =?us-ascii?Q?/uS1Y3Dx6AlZzIU3prN2tsZVtFnCA9a9YzyV2nJpM73PXUOc9z+t+27bPzbU?=
 =?us-ascii?Q?OyjY6KOCUf3dD/BIranxp2zWDCoeei19aBRexRRpxxH3TqHWEr1aYA+vDoza?=
 =?us-ascii?Q?eh7FzmEvo/WSND2lAyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe2509a-0b3e-4e0a-04b5-08dda332b1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:40:28.4232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: US09R9WYONWO+CeHr1mHMhhfW6x6YWep7D0ef0ZczoxMmNfn3eoR1Mn0VRQp8iOUGbuHZtHiC+kA2MypueC14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, June 4, 2025 12:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Clear reset flags from ras context

Once RAS errors are cleared with appropriate recovery mechanism, clear rese=
t flags also from RAS context. Otherwise, stale flag values could affect th=
e subsequent RAS reset handling on the device.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b275e464ae4f..b14d08f8feba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4415,8 +4415,10 @@ void amdgpu_ras_clear_err_state(struct amdgpu_device=
 *adev)
        struct amdgpu_ras *ras;

        ras =3D amdgpu_ras_get_context(adev);
-       if (ras)
+       if (ras) {
                ras->ras_err_state =3D 0;
+               ras->gpu_reset_flags =3D 0;
+       }
 }

 void amdgpu_ras_set_err_poison(struct amdgpu_device *adev,
--
2.25.1

