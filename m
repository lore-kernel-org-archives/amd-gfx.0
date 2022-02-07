Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374C4C4332F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 06:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789CE10EA15;
	Mon,  7 Feb 2022 06:30:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A388C10EA15
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 06:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmIpL+KENBWMfTeNoG+CkQ5Jr8yKiw/bEzoQcKgitiES+6wda9DTzNd4q0XMW3PLZNtvS+nZWemcY/m5yvsY3joNlboJyS5kT0ayy6c8ALks7CGRSNQqJPkNmIAFp/UiwvvQMkD03SVdzyMjfRRv39jUftc2IStb6F01gcVbylHv2oJe4sI8HRyArKZVK6Eham4g9aynI+KDC6mEoANMECelaiMO7XR1PdHJPGV/CmUZR7kGSLQj8Cw+Db1wbVHC3bB6qaA85xsJ+JUz/wEFHxnAJjDVcTFQql47U1zm6zLYO+HSvsnfI6Y63t7c++ef2wQPS0nnr3ZxIfATkPoVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCtVJv+Ph1+b7fKET2KQCNzf4mzXC1qwUs9rK5dabMU=;
 b=Smw1J+2Tw0OVMF7xYXYZ+5LdJ3aWcpJ8ZX5gK3SgdrxOeEAG06O/OByLHYwFR3R1Dvhc1m9t1ylfJwzJM/mKemMXYOpyTj0efa4v2JD53qlt5vPBGBAJ0n42LCzpSWW1uS8KyRhStzqyuP2rPDKVplZA3+oGXTUnHLNEQOfO+2iwvFJrP9z6sNnHgbgTYWgWQcY4jIPuRoXxhJ4dcZmHm6hfc4wFIwnBBjr1GwFE3VAXtR+VLdPqf5KSuLxR2bqiXaBsRkLVEA6acO/TzdUHAKuxwGJOgOeIHuBAUPbG+rxZ40wg5yhwKiBkckxGiZBPNp8KanbJwYpuhfscG87tTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCtVJv+Ph1+b7fKET2KQCNzf4mzXC1qwUs9rK5dabMU=;
 b=YrL4noSzkI71YLtjyFK7/f+wKsSOkiqkLMoMlq0fPn5aNqgsxFs9D6zxDzkYbnMX06rpuJy9G6cUdTw1eayLtxk1grKZvFudygyZcghrtPajJjSD/RgdFJhwPeIjq/MkFzQR3E3bH8E1aV9nKFN6QCxYt93aXFpyIDYBrhQTQKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3946.namprd12.prod.outlook.com (2603:10b6:5:1cb::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Mon, 7 Feb 2022 06:30:36 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 06:30:36 +0000
Date: Mon, 7 Feb 2022 14:30:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: check the GART table before invalidating
 TLB
Message-ID: <YgC8d4ld4aaAyuZl@amd.com>
References: <20220207024155.414712-1-aaron.liu@amd.com>
 <20220207024155.414712-2-aaron.liu@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207024155.414712-2-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66a294c-e79a-4401-5447-08d9ea0359ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB3946:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3946EE7C665EFC22E2F257E2EC2C9@DM6PR12MB3946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgfgBa5HT9DpXe6QePWtUL3PfvTgSgz3r0A+iC5qQ4q5bq/p79W9yPJ6MAFc8VaQJKUN+nd5g6jJ767Q11v6kW4ULrs/qxX3rNDJuscYUwRLJArimeyhcgBXa0vR3jPYD0gSO4aBZYTRsvRpSrqGnHif9MflqbaEapM9eSWPtk7kPvj+8JAHwe+bqpewJTYihckQTjYfyIx5TKCpIc67C1Kq7BzaOCOnJlLDq5gby51dbXuLwDzhu/VWxGd7eOhJ7pmDGZDDuWGtjTo4iffn8GnTgcZXwyl5AdtbrS7ez7kZMt1niKWK5El2V9DdLc1rJQyiZB8+BFTHycitw2dNP3jPEXZ3KsvUxfg0X5aB7z8bduj8YLTRVF1lotWLWfZHNJib7Oaw/bM040e2Wr/8/fG9vbRFnhuaXqBuBXLUW/vpZNr/JLRfWKNLjcvYmM9gLEg4hpvml/cSTnblK05pvrSap6WTUE3ip5+3NPlLjg1GKiIbeFaenPvXwuiaMpUgvUR/ST952FRzlyDRWPUV3m/NXwG4upinyMkD8NNWHPS/xJq8S2SEMfA0TvuvAbiEjX9ArtLDyjSZuESQI0ImisUYbisrDGNTDvYEgA4tytxRBmTA6CrADEBi0rDusxOtAbV+4qFE1C4XiY3dGfCv6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6862004)(66946007)(8676002)(8936002)(66476007)(38100700002)(36756003)(26005)(186003)(316002)(66556008)(508600001)(5660300002)(6512007)(6506007)(37006003)(6636002)(54906003)(6666004)(6486002)(2906002)(4326008)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HBfWxDY+2Bs6I3UhF375oX3+IGBV6KsxSV2O/1RN9xiMtLW8/wGojM9G8g?=
 =?iso-8859-1?Q?NRZV4M/oGWadKm+mMCQ/NPLFqTwEvL3uXWsBjJRSgnA+iQeaV8FSBhgbQg?=
 =?iso-8859-1?Q?+d024rKlbvvWuCsCc2C/+7TIpthdjcL5+dvnpPydc8NKcSRkPC9R9werv/?=
 =?iso-8859-1?Q?IN70urCV3no2Us8bAbemuk1GU3ia+A0zea+yFSuSWcw1twcTXZzFRDSaii?=
 =?iso-8859-1?Q?/JOnuMhU5tSnAerWvtjoW5JjewL6vA4nVe1GNN/BTNKtozoqe3u7cPhM5P?=
 =?iso-8859-1?Q?zIq0DNu70i4nxDr76KUtzN/SQsCokRYoRCtiIHCq1izw0tF7WzxBkpErQy?=
 =?iso-8859-1?Q?NuX4uow97nbxDaWK+d20DZRbRlPpx1LzBnx3Of25QM+7y+UQUQZrU2Rqs9?=
 =?iso-8859-1?Q?Q1hut/EX2TNyQOWpRfs6vBokdBBODNNo5kHafxxdhO6/tByfJ5ZGRJaC0D?=
 =?iso-8859-1?Q?RS7eaW/+QxNyLkfHkT/XJU73lUbYhDouu+6QoRLc+T1Sh1hPygJYgmkJ/7?=
 =?iso-8859-1?Q?H8psgGwTFob5uLusdqO5AM4yhVWgwmCI6kGjX5et2eZeXd0JegDqghSXBJ?=
 =?iso-8859-1?Q?fWTI/Y1q4SC54NN7NKnbbslMT4rzMo5gJsmNdOWzbr+onH5imKwwFPaqsc?=
 =?iso-8859-1?Q?Psoh6wbC9kA9cmoHdVx7m5RZtZOkhiplVLsv3qBCrol0v2P9+MxOCR1Rmv?=
 =?iso-8859-1?Q?lu/+wYB//t4XH2A7mDyUq4nLPKhSuTIKGFZX6rkA244/2renD5+TI4fnDd?=
 =?iso-8859-1?Q?Hrcf7EG1/YOxZH8kvcuUVxASVAfkkr6tiNmnUt+PWvkqeoT0I3kf79liAk?=
 =?iso-8859-1?Q?30vFahzomeWdxvgRpuHFjPu5SJyC+IoA3lPAnDc4U5K6mG4UKbXMUTzUnK?=
 =?iso-8859-1?Q?K+ZJamtM+3e6S0ze1ovvB17Da/kD6g//ii2tWLpFANDTVV+h7UpPKEBr+x?=
 =?iso-8859-1?Q?+BgKhHHEHnAr+WCYvGvRshUCwETDeB5T3AJXiY3qMjMPsLBoG/wZXMdjJp?=
 =?iso-8859-1?Q?wHZdHCpj8yTBh3dEJDUyP8NK1aWlaeSBG/LymKDcQKrlBnHRCf+uKCpSXA?=
 =?iso-8859-1?Q?s+/iW9wi7Pxvt17fM/lWvl/oVtYcmJXlemPYTNuamlvd2Ql3cO2iW9hV1F?=
 =?iso-8859-1?Q?J+UjWiqR2hudVRu/RMxSI+6MOo2T4nhW9ThUwmRnWHuUruJ8xD/MVeRdnA?=
 =?iso-8859-1?Q?+G3LMWMy7er9ZwKIr1EgQokjvNWax30vV/JyqYqEzt60ZIzn++oXC4G9CY?=
 =?iso-8859-1?Q?/IAxv3jSZdFuBgYU4XLGstyQjTXmncMGHCLdolswAVJfYYoBUwrNflU9C1?=
 =?iso-8859-1?Q?up3hEtVB7giPD36UOHXSJtbmWn5yp0qcApS20WDd5OmVD/QAYxNV1GMgw8?=
 =?iso-8859-1?Q?c8Hn2Grjp79KeB89LiTbDTgsIsMNLhHwEnIrRg/GRJ5CfzrQTuKYrlPIP9?=
 =?iso-8859-1?Q?23JNB8ovUw+fjZOjfc0csYoj5kHRBUTwP/ZZkPBtyy/6qhsiiBZmDWP5l+?=
 =?iso-8859-1?Q?4DBOsIX4cTTvLBpNU+SQI6Dp/NZxAvg7PenqgCNPnU7+XF6xn/zfPgiuYu?=
 =?iso-8859-1?Q?3e+2uRu28+fAaGuVTC9Pxy0wdWkppiwUD7sed7a86jy7vOJm/yqeSvVfuf?=
 =?iso-8859-1?Q?ciGcPH+3y1Qi1SVx/724hc9Xkbh8t/o68nWF5mwecSlwX5oNYJNigRGcVT?=
 =?iso-8859-1?Q?khes2NEG846p4/H/4BE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66a294c-e79a-4401-5447-08d9ea0359ea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 06:30:36.7247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YE+fLi4G1iAwS+Fcx6rq2ODhR59NtjRr4YwYLDzbndK7UPng/LGLeWyisNFSsB+ts6Bq1pD5xLSr5LHrsMMfMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3946
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 07, 2022 at 10:41:55AM +0800, Liu, Aaron wrote:
> Bypass group programming (utcl2_harvest) aims to forbid UTCL2 to send
> invalidation command to harvested SE/SA. Once invalidation command comes
> into harvested SE/SA, SE/SA has no response and system hang.
> 
> This patch is to add checking if the GART table is already allocated before
> invalidating TLB. The new procedure is as following:
> 1. Calling amdgpu_gtt_mgr_init() in amdgpu_ttm_init(). After this step GTT
>    BOs can be allocated, but GART mappings are still ignored.
> 2. Calling amdgpu_gart_table_vram_alloc() from the GMC code. This allocates
>    the GART backing store.
> 3. Initializing the hardware, and programming the backing store into VMID0
>    for all VMHUBs.
> 4. Calling amdgpu_gtt_mgr_recover() to make sure the table is updated with
>    the GTT allocations done before it was allocated.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 91d8207336c1..01cb89ffbd56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -259,6 +259,9 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>  {
>  	int i;
>  
> +	if (!adev->gart.ptr)
> +		return;
> +
>  	mb();
>  	amdgpu_device_flush_hdp(adev, NULL);
>  	for (i = 0; i < adev->num_vmhubs; i++)
> -- 
> 2.25.1
> 
