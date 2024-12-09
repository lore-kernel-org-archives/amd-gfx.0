Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C085AE7717D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2024 18:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678AB10E34F;
	Mon,  9 Dec 2024 18:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfDxR5OI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8654610E34F
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2024 18:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUkvEeVzTYKjq7bBnLb2p7mX1LSvI2kXSopIOPLmfpKgPxJFmXOPus986gblF/7LWZOSzuPckLgJ5grmr9XxlltZxRjlZFotFoTjqR+XDWIwP96PcG4bHbpPSqoxqCtgtzQsGLvJDBHtgZoccHCzpv8t1U79a4czGa2N27uE1duzx7X8fsplF5/kznMi/uqGKCNtyNHup+93G7GwJHu9FdiGstaE7a1SS253IYbb1P5GQi3BOj7UMlNnRRFbIX6Ai2wFWoF7tEdcn2JJ6z2ZJVtwmlu3ttuQPMaFiKHBCrPK98W0TwueWRca2l+g+xX+XFa3hpY5reDwAQTaNNygZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZ6lh3wnH49sit7xF2lomANKUCmzcslGGXkoTIFk5Xo=;
 b=f4HYaSZVOgyPDwuE5EueYl2liIjXMaDAfDSGutbG9exNk2zvg1ZAeq/NABqkw2IvLlUHQvv1xuqSXrI1tWcNFOYPlZ8paimGPso7hvyIvZ0YrvnsrUJDCx9xn29S5MyDbXaRFMNPUBqHfGKuLTFWkf92/J63K0dtyX11RvWU39iTP6uMZ9PfDiyfM6ukMN6KIWuP6pp1mWjjD4EgQKKWMgilfBk2oQH82/o/CxSWiMz2LadwxaYFlhG2I1N7/0XFA2bzI+6ltVggaHNj1zKNyONZgdUaPuYQg6eahPSW7GoHIXK8Vx9NQ1XZgtgajO50zw+a1VG9J2e9WlVJJZ+ooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZ6lh3wnH49sit7xF2lomANKUCmzcslGGXkoTIFk5Xo=;
 b=wfDxR5OI+En3yWloCcZN2qGIjFPuXsPBYgMELbIxg1QVw3jYqUzP8u01Fkf8wTLl+v9gsRSEcT/mBsKX6LSEnlcTPFY1Kltcc27+um8qsEMRupBhrSCz0r6fh6a27/nKGsL6bBRAHtW8qU6VYEsn2JmSKacNuNXED6KsXRLzpu4=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:50:34 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 18:50:34 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tudor, Alexandru"
 <Alexandru.Tudor@amd.com>, "Martin, Andrew" <Andrew.Martin@amd.com>, "Martin, 
 Andrew" <Andrew.Martin@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Failed to check various return code
Thread-Topic: [PATCH] drm/amdkfd: Failed to check various return code
Thread-Index: AQHbSCvZ5VEnFbsgFEu/Ybj9VQUPmrLeRcAg
Date: Mon, 9 Dec 2024 18:50:34 +0000
Message-ID: <CY8PR12MB70992BD4D27ACCBF5AB8BDAA8C3C2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241206221110.2898199-1-Andrew.Martin@amd.com>
In-Reply-To: <20241206221110.2898199-1-Andrew.Martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b40676e1-9443-4515-b385-c7d1164da6f1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-09T18:49:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DM4PR12MB6182:EE_
x-ms-office365-filtering-correlation-id: 26049ba1-6d49-4809-7895-08dd18825d5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3eAUIO9n/HbZXcSGtrcqsYpY82aSQJHGFi6Z/wdivkWYUYI7Teh+qGeRcFHr?=
 =?us-ascii?Q?GAAqx9GnNPkXbMbWnJiTQIlvZcF+AHiAwrBekwooHCiDJVDjtSjDx5ynKS6C?=
 =?us-ascii?Q?VNCcuR2FB8b0z/5P4t3CDuOCFj8TPiAhxaTlubYsL1dOmeHLGpx2alUedjT/?=
 =?us-ascii?Q?GH0dY7DmmZIep1pkxAao3nBI5PeHVCjqbTFRDjD5fcQuz7AWOodti+d4o1G5?=
 =?us-ascii?Q?K6+/1DmTZhWLdcj4NHkS8svqlqCwyYBGb9XmxWFWHShpQhDj7W5KxqoWie5J?=
 =?us-ascii?Q?38mnkL8pKtdVbXm07CdBLVM26fSA+c/VEka3FuDTW3+/vv6yZ+b3APs4r2d+?=
 =?us-ascii?Q?rcJ2w9HzMm7tEe4lX54SNCYSsAwvwCpLQIZmrtdS+YiO7zXKr9PK+C94XDnq?=
 =?us-ascii?Q?6oTgGLvbEXb1mFclguL6cCgtW99K63d0i3KYfqxRxB52U3du9Fbr+58QE+8t?=
 =?us-ascii?Q?vO/knOGFxGtZlrEKJfPMjzuepOoRtOYrwYHbQib8WngZfVOoMH1Rm6oUSB0o?=
 =?us-ascii?Q?Xn7hG0AD2wREAPK9mlBNGiw7uh7oZverMT5h5ajeQ3JRG5XQm4DxLhnpg6hy?=
 =?us-ascii?Q?6NGMTlieqPy/PEYp/j9ZsfnU04P8VfJzsiEHAdP00CgGo7pDNI2yMX2GBuc2?=
 =?us-ascii?Q?+H7I3wauqp9WDzFeJw0EVb/YTayIEQ+vzAcDoMAr9QQPxdt5MU4/P/BeU5zG?=
 =?us-ascii?Q?zpSkgWqxpnJG5kQZqjdFPcEsBamOXOI5dmnLSRSjOlfguxrTTD9bGDaLFiBh?=
 =?us-ascii?Q?WZ3jKZt1O943tLv5+waXLj5htubvIX9Q9l6/xMC2mKFfMcer5kkxFVHucyj+?=
 =?us-ascii?Q?21H9ceHX0qujlpWlAuugqVuLzhZ4G0vOTcqhobREMubO9WZABQZTLCviNElZ?=
 =?us-ascii?Q?zNpUUM+SCka8O8+772RW3eyhA7fZI8oyV3tE/HEcvAUgrIwtHjHxep4B/s9W?=
 =?us-ascii?Q?1mBCczfSnsMiUqTQNGhoKxnbSxG7dcSgNNNFMmnPjclZcOocl2OEzB+mLXHL?=
 =?us-ascii?Q?Iy2VjD6bLKP6H7UomMa6t2EphGZUxSbT464/MCQU51YakHIlbl5Of4YqoK8x?=
 =?us-ascii?Q?hSdwZErAfgDDu+lNjkybp/p6x5F4mb8GORpNWe4LBuwlGdSLGv7brqFgn4/r?=
 =?us-ascii?Q?p3/qWAQpQYYDlGN4lOK3eFelbyRFxvUoNPoISmfWx1LzJbmq9pCO6x30Z4dq?=
 =?us-ascii?Q?1d9D2AcQd2DHcMJuXWG57KjX6VE6KO+kNx4VTF2RuqsFmNPs2eWtRxmKbVb+?=
 =?us-ascii?Q?wkqx6ETZuAiUxMonVapLN/VomYcQ7v6uzemp7I4y00JireoqIUqMJ/nqmcy5?=
 =?us-ascii?Q?1Hmnoaia3uXREmKt2UjCN64GLH+ST9xyyph/st+77Uf1Run+v5EpIj8hz0eH?=
 =?us-ascii?Q?xKHqQFkgO8OqeS5xM2Ie1gAtdySHucUogCILbhpruThEnnytlQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jSzAk9xdS0ALpDL7ej7MaTe157sZcIWsJI9OXUQxd05VRHKKw3E8SficBRGV?=
 =?us-ascii?Q?KQfTuav1SJg9y95EJhy9RhX1ft+lXKuclcJcjs8hUbSxobkgyin6tM87QLXg?=
 =?us-ascii?Q?sARk2YlGlzD6ceSoxi8kP3dQ4mkEYbwa0Ytk9GIMJwDJt+hRzJL4k3U3pgPs?=
 =?us-ascii?Q?0ZNP2o9RYXrbMFS7Rwjdmjhv1RQqVq4y7yc3JFqjx4JQMhw/QQDMRLruRWHj?=
 =?us-ascii?Q?DUpaubI11vhCNf6nG/zHGmrC1m5AIY2OKHmtD9BfhQwk+ejkwRQXtrsQqNBS?=
 =?us-ascii?Q?8tbuHexaPWefoijsRq+2le7SOY887c35ncDm6GqFhmCEXVffXcIXYPqz66BM?=
 =?us-ascii?Q?WQw2pQkEIQ1+d3kVHPu5liODs1DkmAd7kOcCCDMoqJaM3nDFbHBT/lWA+Upo?=
 =?us-ascii?Q?VXMTGtiqCjwnbYLFq3BTsRQXO/6hPkvEnlNwOJ+4baZvLcRbziJAt5x6wLcy?=
 =?us-ascii?Q?ypR+QKlRZDTl859rBvldgvSIAognLsPWBEy4fN/Ez52EtUhkl5UF8aBdlWoq?=
 =?us-ascii?Q?QNAzNc5QAg+8fDQtGHVaXj7Q5/AEsNqfxhM/Il5h3viO+ApX0PemeKm3IdKV?=
 =?us-ascii?Q?4LHotBorsx+lHvvTScpfIelKd1QA/+/+UEgN3k5erCwEdGZTHhQuVmGFsiJF?=
 =?us-ascii?Q?ZhTttCJ+9FdmOcN0Sl+qsek9Zi5f/d8F0Y+VW8svAOtDo224sa8O4uAWQi2p?=
 =?us-ascii?Q?nMWRNGhAkoyIRvXj9prFtlNpfDh93/7BZbtA4lQZJLY4MeA6KKAGaU7Ae3Q7?=
 =?us-ascii?Q?OifRl9UjxBavye6B4gR5dApMmpKSdlmSgHkEqofH9JTIEan0/tevJGXWhiF6?=
 =?us-ascii?Q?bVne5Lwpvf7XGlw4dCBqgDJtCnvOHUOnMufvITA3/sXlWM0Fz1FKZmTNK0O0?=
 =?us-ascii?Q?NoGDgdfYXuhZxcKeL8YLOE7M5r5nPzvLR2APU/tJeoV2P4dkeR5+1YgnQPXK?=
 =?us-ascii?Q?Ksi4o7qEMy1kSZwuJ0ev7QMLn0WJcx283iZDryxiy/DFz1GAz6XMNFxAAVCZ?=
 =?us-ascii?Q?nfFquJ2mpFGT5szCE2atSO/1otbPZRvIKpb7kpc9uxsAfFodc5j9lmV/ESPg?=
 =?us-ascii?Q?d2x1dYDqbXkDfuZbPlPVmFGNXkZj3GLse/HYRF+NU8OOQuQD6qSM0KhVeGi+?=
 =?us-ascii?Q?JaVU8z/A3El49idmDgHMxFKX0hrBnKEwLNd9de75/3BDRVZxt84t7J+P546W?=
 =?us-ascii?Q?hL7LNPjzZJjJ8XgcGUlHABOjnSiojz8Mr2/TZjnTftyME5012/hRKVDs7k+h?=
 =?us-ascii?Q?EVHou4BTA7dtLVGpRu2ec+seNGQmRjCX1J1rt5wyNnWxyWKIt4CqQAhCnzv6?=
 =?us-ascii?Q?qZMQCY7NeVkyROSLS0QwveM5XHCR8t157Rgm7EF3D9/nOtIVGOTL2sBkVapi?=
 =?us-ascii?Q?VxeNbetj3CbGMyFRG+ip8K9zuAtQz2WFtjZJJPpWdwDZn6JU9vSRiMmJZtGo?=
 =?us-ascii?Q?retnX9rNWgojK9vt1xybDZ1BiwUl2qq8Hma/YCBQHdR9LThyTW/GhAW2qVDE?=
 =?us-ascii?Q?RzmzeM7oxwNolzoR/Dq5od1IRT/S3h7ynJ0eyDE9AIXcQBo6b8l8CJxQKmwC?=
 =?us-ascii?Q?STaE7fxSEvx3VBtmwB4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26049ba1-6d49-4809-7895-08dd18825d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 18:50:34.7104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZBlipxIjVTh39TGyObp1h0M7pvLnqzuUu6xYg/7lcadRMHGXBLlQG2JHdGCGUbIYMViZyhFyz8SWUfZjJnWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

Minor comment below.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew M=
artin
Sent: Friday, December 6, 2024 5:11 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru <Alexandru.T=
udor@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>; Martin, Andrew <Andr=
ew.Martin@amd.com>
Subject: [PATCH] drm/amdkfd: Failed to check various return code

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++++++-------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 503051352922..de30143ea51b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,7 +368,7 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *a=
dev, void **mem_obj)
 {
        struct amdgpu_bo **bo =3D (struct amdgpu_bo **) mem_obj;

-       amdgpu_bo_reserve(*bo, true);
+       (void)amdgpu_bo_reserve(*bo, true);
        amdgpu_bo_kunmap(*bo);
        amdgpu_bo_unpin(*bo);
        amdgpu_bo_unreserve(*bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..1e998f972c30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -730,7 +730,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
                return;

        amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+       (void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

        dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
        sg_free_table(ttm->sg);
@@ -779,7 +779,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
        }

        amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-       ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+       (void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);

        dir =3D mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
                                DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -989,7 +989,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, s=
truct kgd_mem *mem,
                if (!attachment[i])
                        continue;
                if (attachment[i]->bo_va) {
-                       amdgpu_bo_reserve(bo[i], true);
+                       (void)amdgpu_bo_reserve(bo[i], true);
                        if (--attachment[i]->bo_va->ref_count =3D=3D 0)
                                amdgpu_vm_bo_del(adev, attachment[i]->bo_va=
);
                        amdgpu_bo_unreserve(bo[i]);
@@ -1259,11 +1259,11 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
                return -EBUSY;
        }

-       amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
+       (void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);

-       amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+       (void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);

-       amdgpu_sync_fence(sync, bo_va->last_pt_update);
+       (void)amdgpu_sync_fence(sync, bo_va->last_pt_update);

        return 0;
 }
@@ -2352,7 +2352,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(str=
uct kgd_mem *mem)
 {
        struct amdgpu_bo *bo =3D mem->bo;

-       amdgpu_bo_reserve(bo, true);
+       (void)amdgpu_bo_reserve(bo, true);
        amdgpu_bo_kunmap(bo);
        amdgpu_bo_unpin(bo);
        amdgpu_bo_unreserve(bo);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c79fe9069e22..2f955c76fc56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2373,6 +2373,9 @@ static int wait_on_destroy_queue(struct device_queue_=
manager *dqm,
                                                                q->process)=
;
        int ret =3D 0;

This should be a separate commit. This doesn't match the above description =
and falls under drm/amdkfd.
The above changes looks fine, just use drm/amdgpu for the commit header.

+       if (WARN_ON(!pdd))
+               return ret;
+
        if (pdd->qpd.is_debug)
                return ret;

--
2.43.0

