Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3130CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 09:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FFB110E5C1;
	Mon, 28 Mar 2022 09:00:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A06A10E5C1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 09:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxp7bd2mVa2ZvzcxFj3un/trvbHbhMk+Th1sVE81c7+sk/YkRSPA67huynTvZx+NInBab6GKmWU65qpSNfcenv5gLZVbzqxEbvwRCJ1E7pw8Rgxc7E2TDByQiLiZxo3MEiZ86YhBqMzdInbi200O06FbinVK34NkuoPIwwqtdKMAX0hLEU1RE8aK0kxPfb/zm8xv3w5Tg+hMtJA/YwW0cAUeV80TcU1H6eAZeqguR92p6WrOXnZmYtxl1hKrzyiGIybaWgRlMHHisb1/m1O9uyOuR1LPiP0Efk4jCwA88JBqUn4oaeJVcRv9MNGLiIhHQLV1y1ZxAZSzyxLXAV3jCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3sdScUkeTLJusvlgm1A3OS4edeDVIEljr9zWZJOdLM=;
 b=EZErjy9rl/iuYDRFfam21Y10XDJQR+O5h4u/4pMsHUo1nTVzMr/HDDvbOsUjnMrrHBwPktlwfFdH/f2XDGvmgZFNEex9RngyrlWGRk2tM1OEwPG7yhBh4bPSNtA2iBchVmpM2OCxix9dWD/yQtBv39RfnzUvxoGZolYGrTa4ed6LtM4sm56RICdHO7qcsiPeSvy9zy1FSQYXYKOesJMYtkv1bu//Cl6XqNFM+uAJTpEPDgIbSWjMK5PnlSmdzzCCdOnZNy4q/sOmuk3+5cwFBbQ4R0ksTE38P9HDmgVGlRZh6LWZaPirQzmA8kmLfgbOCoOJyItmB3vX3901bduClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3sdScUkeTLJusvlgm1A3OS4edeDVIEljr9zWZJOdLM=;
 b=uXFIT39aOWCNAqmbGpF30FLeQqTxF44aweW0P6o6IlsowYtBXjFte8V/mOWFFLhzcSdRHjfjGW0T0PVB4xBZ195ofg/dr5o+5kzwEbuMHXrrw5fMZP5KHA/kUIGm5W4ci73vXzelhS7ozf8Dc/9hoam75PkmrSxR/aqLkka+KCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR12MB1825.namprd12.prod.outlook.com (2603:10b6:404:107::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 09:00:45 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:00:45 +0000
Message-ID: <d35b6a93-9afd-a49d-5f29-865833d82dc2@amd.com>
Date: Mon, 28 Mar 2022 11:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: Reorder ttm_resource_manager_evict_all()
 before disabling ttm resource manager
Content-Language: en-US
To: Leslie Shi <Yuliang.Shi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328084710.6569-1-Yuliang.Shi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220328084710.6569-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0248.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56d6e39a-8cb5-4d94-72ae-08da109971b6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1825:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1825288214B627A0E3400D84831D9@BN6PR12MB1825.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUqmCBf0fjULN9lF9HtkDxsZdbPkLiySnHHroLzULv1yCDU4UViwPlvRn9HLoCtEmyS3gemXrjdpqhHaCVCMzP9nH/TEX2xhjl1rLTME8Tr0U2Qx2yHMbb7a979RT2Gj36U3yRCAqnnljYnN7IRqhtDTSJ8nfYb7kEodzQhL8Sfw4IEOPk3/5i/53uL8aCOjVOPjzhNEUtfJ2gfsnjBwKZ/VgGed/s0Nn41/bfU9tBsTAr9Tk+bH8HoH8IVJ9NYMw7+Xu9+RBDlKa4eUgnRandyRGRu1QQTEEX0rjGXesRNcbpsliszg9XlpuHAxKNxDobtgbuwDVpE0QKOYmuESmFFZS5J+pjTB5seQIbG3eYNSdufmXenT7utgYReBHqPPz5aetLb0IRc31gLNmJP5ne0/VXDrDpVi7ksMxdHj4Uz3mbUnVL2K9p4ycd4YmrGVDbLetcctY22ZU5yYxjHgTSVQKnRup6j9Gtijxb3BSsid+LJrpRfEF2kuRMgibEilnmOn4+LsS8AVeZTv1Gem3X/9QM48YXInK/hT6hW78q/ZfzV+MLjQQWXKJrk++3l/r3qsIPP+x1zObGjTJDT8F7JU/cMA+zlyJd8adUaa+GgiAEFP1O2bei3SpsfgyW5Vqkff5ucoQ1rbCRejAB9PmCyy0BRoX8SnKCLphOOBUxm4o3vuDOQcL5ytLAGxnyyPtwYg5J1/9MB8DcY1vy2OnMiJ2hMOjNd29+Tk5DN+pYQWH2+r/R7VUu/dXVs0wvTC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(6506007)(2616005)(2906002)(186003)(8936002)(508600001)(5660300002)(316002)(36756003)(86362001)(31696002)(6512007)(66556008)(8676002)(66476007)(4326008)(66946007)(31686004)(83380400001)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUZVKzBnTFBKYnl3eEs5SzV3c2lsYVNmRysrNjJiVnNEUDhsS0ttWHFUc1ZE?=
 =?utf-8?B?bEFWWDVuMGRhR3ByaDZYM0JPRGRHZWJrSzhEVXdITXBhRTZhY1VXeHdNalB4?=
 =?utf-8?B?ZzF1c2hsbXZ3MmhZWUw0RXBEZ2pTZExmQWdjak1NL3l1V0c5OUJPNU9DRmJS?=
 =?utf-8?B?bjFpNEFQcVNiRS9MbitzeFFWV3p4L1k2TnlRcTBMYzVKSU9sU295U0ZzTnFU?=
 =?utf-8?B?d3grOTM3bjVpeDE1dlVoeURVT1JaZHRpYnpHRks4Zmh6WEwvRGFvSDhzM0t2?=
 =?utf-8?B?Znd0QjZPdEUzMUxGS1B6N3psajdlcTU0VzJaVS9JdTR2clh5YVBwbmVrR0ho?=
 =?utf-8?B?WFgxUGtEdzd5Qk1lTkJNZUlMdmN1dkNJNk4zVUxzVFlFbVNZalg3aEdZOXYw?=
 =?utf-8?B?OVNrcjBKZnFoNzdvSnVrRlZxU1RDa0RtU1NzbmdzekxMUjZlWGgwV3hQZUpT?=
 =?utf-8?B?Z2tCaFMwaGNETzJLdExHZi8vWm1FOWNUOFd0cWgzc0Z6TzZtOUVabVlwWXBZ?=
 =?utf-8?B?MCtZS0U0N1BGM2VqeThHTFI3eXBTK0ZoTHo4M2RYSE1UbWZXQUYyMUt3eDE1?=
 =?utf-8?B?ZUNyT0hjbG1nYWNJQnV4bHJSdlNhOFYwbTNnaWtuVXNUQjd1NFdhTGlTQnBZ?=
 =?utf-8?B?ZS9MYWgwQktCMGRFMU16UlRKOGVjb1VlOGV6WXNPNzZhNW95TVZkcWpvcGV1?=
 =?utf-8?B?ZEwyUDhXRCtVYlMxQkRZWitXN1FCTWh0U1NJS3ZLRVNuMjZJREU4MTE3bE9k?=
 =?utf-8?B?cDZQVy9TSzI5bVgyVE5tTFU2WHVNSWo4YWxwamxjWXlhSHRTcDNaeEdYZ0Y4?=
 =?utf-8?B?QlRXeGVoejhKTDVYSE9ZVUo5YWIvQVFFeXhPVnpKTUwxNDl4a1RPWk9MV2ZL?=
 =?utf-8?B?TUsydllpb0twNFNpTDZ5WU5PdkNpSE0zaFhuREwwZDJKQUFHdkl6bzFMalVD?=
 =?utf-8?B?SWtJeFFZaE1mdkZJSkVVKzBJRlREenZobTNxNjZXSUlGNnZrRGpXZXFYcUZD?=
 =?utf-8?B?dDB1VFlUMVdjWFVCa1U5NGdVdUNkZUZUZlZNU3ZvNWpXenZlS0UrNjlLakFi?=
 =?utf-8?B?SWMzSW5aTmhlNklpdDdVNG9uSitRZG1od2diQjFPZkdTeEJCM0ovWVgvMlpp?=
 =?utf-8?B?Yk9sLzd1NTdHUkM0M0hMd1hRSThPK0c3VEwvUTJ2bFJaMnVqOERLbEhoYjND?=
 =?utf-8?B?SVBoNVg3WkhNRk1NNldNejRhNEF1MGg4U3ExSExqMDNzU2xPQ01WZ0xTRzVv?=
 =?utf-8?B?b0d6eERKQ0xYNWdITUxyTGM2Zk5tK0RRWTBuVkw0eEtlUkNLV2l2a3RmVjJi?=
 =?utf-8?B?UzVrSVBVS0laeHRnMytGQjJoT0xXSnJSdGJuNnBEUXRIZGM0QmJLYi8xYWNq?=
 =?utf-8?B?MTAvN0YrYXNCTzVjeDFwU2Y0WW9vMDlUaS9rQ1pLbVpyNFNxbXB0UzE3cWhi?=
 =?utf-8?B?eERtRkJsbEF0UHhYUDhhWWlEQUV6ZjlzN3dFbm5wN2ZEVTlZTU95VUJqZVZU?=
 =?utf-8?B?YnRab1hrSHZZTmhxN0JwWTFBQWMyRjFHVzRYY2Vpd3BWdjVKSnhQdmJEOE5X?=
 =?utf-8?B?VzFHR2NrcXZwOU93THVKV0RIUTVEUzhTdUR1VEd3SXZ0QUo4LzEvLzdSamRD?=
 =?utf-8?B?VEQ4MjFITlVlem50cjl4YVg1SmJhaFRmb0NEUTMrM1hkY0xiVUpJQUN3ZmxN?=
 =?utf-8?B?bVRPN0hyNzByWlNBZkVlSW0ydjJhQThmT0U5Q1JXUjMrZ3NnMWpnMTgyNUJD?=
 =?utf-8?B?bjVxWDk2N0x4WUtIYXlxbDl3eTJrM2IyYWxpMkpnZWJYQ0FiWkRqMlZVZVdv?=
 =?utf-8?B?blpoZVRGUDZtY1VwUU9FM25NMGd1N2hqd1hveEVLUVVTTkZuWDRFN0Vid1BK?=
 =?utf-8?B?M09sS1Rtbm9CdDZlcTVqb2NkZ3pmSWNrTlhXUTNpSk8vTlNyZXQ2K0FVUzdO?=
 =?utf-8?B?VHZYMkdOUjRYNmxPU3ozUTZYMVdqZld6Y3lXNytIQXdFdG9jcm9WbUhybnpj?=
 =?utf-8?B?YUlrSkh3ODBCTWF5aHVCUHp0VXM5Nmh6SHZvZDByc3lBdXY3bXB6Ui9jeFNo?=
 =?utf-8?B?MXdLcG9lSFdQTi90Mmp5UVE1SlFiQkVZRUZrR3ZyWENPTDRTSm5KU1hUNm1k?=
 =?utf-8?B?R3ZTQVVnU0NFczZSL3gySWUvcXpIQlhlOWxPcUg2a1l2TXQ0Y0lLeTFCNWxv?=
 =?utf-8?B?NWcrQWt4cGc3NWQ2eTNDaE1uTnRzT0hTbTd3ZGxmb0pNcU8wOG1LdEVxaFlY?=
 =?utf-8?B?WjIvUzFFNXVmUlc0enFkYThUV1llazB2ZUs1NURIZ3RkTHdBbGVJV1ZXejhR?=
 =?utf-8?B?OGtaNEFxaUNQVkEvNm4zUllUTnpTSWxiZm5XUVh1NGJ6NnV1S0JWWTNONHM0?=
 =?utf-8?Q?dav/XmCrU9TTi956q0KgKJtoMa2UypSl9JURd2CBU85Li?=
X-MS-Exchange-AntiSpam-MessageData-1: J+LCM0OE+2gyzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d6e39a-8cb5-4d94-72ae-08da109971b6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:00:45.3294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdD3p1JW55Gu2ePzyqv1N+DcBgJMuZfjD97oplCzlUBOj3m2FnC9UdsmWC+q7GPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1825
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.03.22 um 10:47 schrieb Leslie Shi:
> ttm_resource_manager_evict_all() evicts objects out of resource manager
> until lru is empty. ttm_resource_manager_set_used() WARN_ON non-empty lru.
> This patch exchanges these two function calls to avoid following call trace
> during amdgpu driver unload:

Well absolutely NAK.

This is an intentional warning that _fini was called while there are 
still allocations inside the domain.

The evict all is just the last resort to not hard crash in this moment.

Regards,
Christian.

>
> WARNING: CPU: 6 PID: 22873 at
> include/drm/ttm/ttm_resource.h:229 amdgpu_vram_mgr_fini+0x145/0x160 [amdgpu]
>
> Call Trace:
>      amdgpu_ttm_fini+0x2c2/0x370 [amdgpu]
>      amdgpu_bo_fini+0x25/0x90 [amdgpu]
>      gmc_v10_0_sw_fini+0x2b/0x40 [amdgpu]
>      amdgpu_device_fini_sw+0xd2/0x370 [amdgpu]
>      amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
>      drm_dev_release+0x28/0x40 [drm]
>      devm_drm_dev_init_release+0x30/0x50 [drm]
>      devm_action_release+0x15/0x20
>      release_nodes+0x19a/0x1e0
>      devres_release_all+0x3f/0x50
>      device_release_driver_internal+0x11e/0x1e0
>      driver_detach+0x4c/0x90
>      bus_remove_driver+0x5c/0xd0
>      driver_unregister+0x31/0x50
>      pci_unregister_driver+0x40/0x90
>      amdgpu_exit+0x15/0x12a [amdgpu]
>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c     | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c    | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index c5263908caec..e472a0d639fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -308,12 +308,12 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>   	struct ttm_resource_manager *man = &mgr->manager;
>   	int ret;
>   
> -	ttm_resource_manager_set_used(man, false);
> -
>   	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>   	if (ret)
>   		return;
>   
> +	ttm_resource_manager_set_used(man, false);
> +
>   	spin_lock(&mgr->lock);
>   	drm_mm_takedown(&mgr->mm);
>   	spin_unlock(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index 786afe4f58f9..798be117c3bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -182,12 +182,12 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>   	struct ttm_resource_manager *man = &mgr->manager;
>   	int ret;
>   
> -	ttm_resource_manager_set_used(man, false);
> -
>   	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>   	if (ret)
>   		return;
>   
> +	ttm_resource_manager_set_used(man, false);
> +
>   	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
>   
>   	ttm_resource_manager_cleanup(man);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 6c99ef700cc8..f94f2b271544 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -718,12 +718,12 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>   	int ret;
>   	struct amdgpu_vram_reservation *rsv, *temp;
>   
> -	ttm_resource_manager_set_used(man, false);
> -
>   	ret = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
>   	if (ret)
>   		return;
>   
> +	ttm_resource_manager_set_used(man, false);
> +
>   	spin_lock(&mgr->lock);
>   	list_for_each_entry_safe(rsv, temp, &mgr->reservations_pending, node)
>   		kfree(rsv);

