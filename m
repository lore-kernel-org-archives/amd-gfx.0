Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00E9E7542B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 17:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FB410E03B;
	Tue,  3 Oct 2023 17:55:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE9610E03B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 17:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpDxAR5TAtQUiC41EImpkbWkgmkMZgY1sG+V1OZNlH3I+n1PU6WUCzR+yIbwkb8jtuPn8eLyptL76pH1epsEKqNbPq0xzRcawoLXgQVR8JsS/WzQambQHR/LO6SOnXQvJ5rZFb4HingoEIUNRJNqM6ZmTi+IxGUZqSo39BFBKZ046JlnTFwO+tgelaY5+bJNl4agoHyt04c2tcnqoM3+F5Uh/4HX6QvONH/UuiO0l3iZmAYLk0NO+OWpNXbBZl8iz2CyT3KN7ckeRCOTwP59TvwQ+2pgOXom9nDe0vkuHoL49L5driNxiByc9TjmaNms/cBmAtxKX7x/jKOBT1h9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7kRpoRx2cN3ZlULJl+X6JfBycBUXHre1rtUUrVKxPY=;
 b=kDcFtlznwW3wS/10gcwT5ff+dVhUh4dQ+byVOKW2i8coqQRWU3TMMYbm+uHAkejoaMCSR1jiT5kcKCcXisIS96ZCYzisKCdMTXwcXAjfQRAYyzVdAH10VK+GrR3mkDV27S9CUKjE4xFmz4tGE815O+p+/0JRm7TMV0YwuHAqVY3/f3m4BczF/FNcRMsPqmG8Xty6tc31cO5t1aJTfUWO1rkooqGR8NcykgPlzy3kUHEYMWxYEGXgJs67a5i/cF9tA0ntUj5OcZj5hjm44YOqPZ7f2G0lOgli2mTXglrR+mypv0EDnGyzgrPIMLDvHJxqrUqdq1IUSqd55A0iM6WdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7kRpoRx2cN3ZlULJl+X6JfBycBUXHre1rtUUrVKxPY=;
 b=ICzCqDM2WI2j6S3sMja4LY5ptd4I/8O892C39j6tEoKnHIkwDUEvRtu2cjTX4z511r0oZmu9X+zT5mz/9W/zEa4xalyg+lCpPL6+waqxjcmLf0XMdqGTU28obHH7j/F1BTfuyufWiDCVdBoG7x9R1BlL/ft90nHxnZby9TCiPQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Tue, 3 Oct
 2023 17:55:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 17:55:33 +0000
Message-ID: <a38bfe49-18e0-ff6a-6142-1ade6c53bde9@amd.com>
Date: Tue, 3 Oct 2023 13:55:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231003165727.10854-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231003165727.10854-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::38) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef1d11e-f565-42aa-f1cd-08dbc439f0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBzgw8AhERSgNnVZeNAZnU3nWLSusxO5VOAljBWdDyxWHXi06IfYgjJ7EZgF+Ss4VOsESQSeIOj33hztc+b7M3EsiSTQkh80ZQSKJXBip4vQb+JUMSkLC9jxnsh2PwvGi+RDXNsaBZqRbdhalHv6xCm6NJKEiiZLrX12YsWn7rpf1keAzM+QctZWnKDPrJledalFXDk4zqmOXnLY5zm7hpKEHYwuOiDeqkGnYZfbykX8hywwge/1UC5LUAqSroWqEvsK2Jgm+CBJ0KTEwhHYSkhVdvAhljfnKE5ULOoKa09S/zi5pUJRy/7ZlhRfQrzZoopMqW0qB5Kk/r0ZZ1Q/A/CwV/9Qa0dZ2heEco0hhMIw4ney1nIZA0oQiAkyZwglYOtxsyRawayORCf8gs8IULJJQfqmFvG6OKZwoTDp+8ekdtlx82/xFZdDKIjafGTbnQV5I89+j4vh1phNFCyUsZ19fwFOT8Zj994Pra+bGdONCVCmxnKH688YYeRFTYFBQXaoJqsNObui3oq5D/c/K1vZ7MSEouU9lEssnV/Sj5QSbYLcZz98/I55yCp/nPnxwzYvjXaB/ApvP9cwn/NanwzkV7wjGWMup82/CYV32xJcF73pIb2hi40X87YuWRhdQ7RP49e4Boar32ybqgmUUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(53546011)(36916002)(6486002)(478600001)(83380400001)(6506007)(2616005)(6512007)(26005)(8936002)(8676002)(66946007)(31686004)(66476007)(316002)(41300700001)(44832011)(5660300002)(66556008)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1NjcFZEVkFnemg3U2dodURvVlVFRW1JQVdXTW50RXhRcStjbG1tYVg2Ymts?=
 =?utf-8?B?QUx1V21oV1pFcVlVY25FMjNDRmd5UDI2MUxveU1Rcjc3Sy9qWkJqQlUyTGlH?=
 =?utf-8?B?ZE9RRHNwcXFUVUlzNHJyRThaNWVmdVNOeC9od1ZDQnhtYk1IWXRDTTRDTG1F?=
 =?utf-8?B?aFNrbHFVZ1dXQyt6cjBKV1NiMytjaHhBcVJIbHBLLzhKdWo3WTVBZlJxdGxk?=
 =?utf-8?B?RU1OVHhXRlZtSEMwWVdqQjlid2N2OXByUjQ2YzZteFc2ZVFKNWtrSHVFckVC?=
 =?utf-8?B?TFQ3eFpIQVhFdmtSQWhpTnVndEtNcjN4RXV4NmRpU3JpTlpmNHE3bE03YVNs?=
 =?utf-8?B?QzczakEwTmtWWk5hMHN2SDBPZ0hFeXhkVFc2T0dsSVpjNXJxR1BRZXFqazNX?=
 =?utf-8?B?bGtGL2U5K2loaFNOYytxMklmS2JRUXhvRDROMElNNk43ZG0yZXBuNU9QYkNs?=
 =?utf-8?B?N2ZadEowSGlSQ3ZYSjJZQzdWM2N6blJNZXlhcGF4MUJzTjZ2Uy9UdVF6RnpI?=
 =?utf-8?B?WTduOUtEREVxY3ZrcEdDc0tpaDlRaFNlOVdoaGMzemVsZ0RUMXkvbHR3SlM3?=
 =?utf-8?B?MlhlcFBnYUx6MGFGZmZ3NFo5OGdJaWd3c1dhM2NhdlN3dksvd0lRbVBJYVE5?=
 =?utf-8?B?eVBPZDZFL1B3N0ZKMkhvVmJFenBnQlUrUEF1cFlJU0NnTXYxQTVsMzd1bERa?=
 =?utf-8?B?QThNdm5PM2poUWJzcUl1NlFFZUs5KzI5OFBFQ0JKZEpSNUZGZmM5OWtwL1Bs?=
 =?utf-8?B?eHBDTkVJeDN3dzU5Zk1wU084LzZrci9rbUMyV29GNzFFOVp1RllxS1IvZkxa?=
 =?utf-8?B?T3RqRVdBY2J4WTUyU1FiSzdlaFN5ZURrTXltS21zRXdtZkVFVGE2ZGRMcUpS?=
 =?utf-8?B?SzZ4NmhmZmtsU0lxZExsNDhHSjVDRVVNVmRyRVd0dmNLenpiNXgwZ25oM29m?=
 =?utf-8?B?NDhDL1hPZis2cHc2bU5DRktQT29mVlNkMW93YTZST05lOWtjajJobEs2ckwx?=
 =?utf-8?B?OGdDbEcrcXk5MGJ3M3AzclUvY3dscFl5UzJFdE1ka01zVnpMeVp2c2JMb29Q?=
 =?utf-8?B?Wmt2VFhTMnhwR1pmQkw3ZStpMzg1SVBUSS95bjBxUlFuUEM1dnA3R2hrTWN2?=
 =?utf-8?B?K3d3TTcydUdiek5SM2s3WUpkTnBFUDE5UkNOTXQrN3BPTk85NWk5b2FXR1h5?=
 =?utf-8?B?ZUpkOWY0V3ppSFM5UkgvLzhwa0hVZE16UDNiOVl2a0FSL1dlTzV4RXdNa09D?=
 =?utf-8?B?NS9UVlp2dml4eDlVWTNDYmhHR3ZKTlFkWGVxVGFUVDRlSUFoeDlSYjQvNGE1?=
 =?utf-8?B?MXVacUhqaXZkc3V5U0J5UDZHMGNrVm1jc2pWL2Z4ZzNUQ0J6cjZ4ZktoOXZP?=
 =?utf-8?B?M2JPQVNQb0hKSUJPdFNXaWVvcEJZamt1MmgzR3RaR29hQU1nUWZuMWxveDg2?=
 =?utf-8?B?MERGU09JQXV6QmVaaU5TODFidTducEpoNnA3aHpFQkRPOUVxYnpNMGloNTRi?=
 =?utf-8?B?dWV2VUxkUHFZSmpQNk5lcDRXeVljV281dlFvVTR4WWVZbWdTUU90RHVGR1RP?=
 =?utf-8?B?RlI3a0JWZGt0MXZhR2pwVVY4Yk4rKzNwU1RWZEF0ZU0yQThRS2RvVk1rUU1M?=
 =?utf-8?B?VzdPUjN3MEtYajJwRHZkQ2ZGVWpINmlKWmZnT2ZhZmpuMDJoNTRYckRlY2o0?=
 =?utf-8?B?NjFWNjhudzQ2aW9ZZVpUT1RFWGVOMFJRRFlMb1VWMTdrYXRXcGlKNEh3UGFP?=
 =?utf-8?B?WUhjOUpjeFh5T2NFd2tWaGFmV2paYmduK1ErKzZMQTBzRSt0M1hyaGdOODRu?=
 =?utf-8?B?Rm03NGVRNS9iUkJxRHpmcjJ2ZmdCWnAxUERwVTRuVXlwejNlaXJyc3RwZm5z?=
 =?utf-8?B?N2QxcFJpUFYvR1BnN2dHNmhDVWZRYzAvcENZSTY3WThOQkZEeFZCMVZTckww?=
 =?utf-8?B?RktNZHFOcHFEb2k0V0xFU2xzRmlva0luVG9Id0EzRHVFTno2UkQwOW95Yjlm?=
 =?utf-8?B?T1h4YnZGb3hLTzNOMVUxSHhaRUhtczJ5cG0rUzcxRHVobkZQTHhieWNXaGZP?=
 =?utf-8?B?d1VRYm1FbnV5QkxvOTZ5TGFaTG1mRHRqRnQ2SXFEUzZVQko0UGpBVCt6WjFT?=
 =?utf-8?Q?Ki4LMN/DIwlMxNx+Dk53jWcpQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef1d11e-f565-42aa-f1cd-08dbc439f0cf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 17:55:33.6611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCAOYotEXni2fr2r0tvvjdewwCWqj0C5s0ATLg2X0oSpmoecoQ3UL+wn25ulNaaRcHxSH0Xp4c6H0r0uyi7IAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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

On 2023-10-03 12:57, Philip Yang wrote:
> If there is no VRAM domain, bo_node is NULL and this causes crash. Move
> the EXT_COHERENT support change to VRAM domain path.
>
> Need another patch to support override PTE flag on APU.
>
> Fixes: 55d7e2001c7e ("drm/amdgpu: Add EXT_COHERENT memory allocation flags")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 0d88698ae33f..150a3e88691d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1252,19 +1252,17 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   		snoop = true;
>   		if (uncached) {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> -		} else if (ext_coherent) {
> -			/* local HBM region close to partition */
> -			if (bo_node->adev == node->adev &&
> -			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
> -				mapping_flags |= AMDGPU_VM_MTYPE_CC;
> -			else
> -				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			/* local HBM region close to partition */
>   			if (bo_node->adev == node->adev &&
>   			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
> -				mapping_flags |= mtype_local;
> +				if (ext_coherent)
> +					mapping_flags |= AMDGPU_VM_MTYPE_CC;
> +				else
> +					mapping_flags |= mtype_local;

I'd prefer if this did not override the local mtype unless we're using 
the default. So I'd recommend a patch that changes

  		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-			     (amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
+			     (amdgpu_mtype_local == 2 || ext_coherent ? AMDGPU_VM_MTYPE_CC :
+			      AMDGPU_VM_MTYPE_RW);

...

-			/* local HBM region far from partition or remote XGMI GPU */
-			else if (svm_nodes_in_same_hive(bo_node, node))
+			/* local HBM region far from partition or remote XGMI GPU with regular system scope coherence */
+			else if (svm_nodes_in_same_hive(bo_node, node) && !ext_coherent)
  				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-			/* PCIe P2P */
+			/* PCIe P2P or extended system scope coherence */
  			else
  				mapping_flags |= AMDGPU_VM_MTYPE_UC;

Regards,
   Felix


>   			/* local HBM region far from partition or remote XGMI GPU */
> +			else if (ext_coherent)
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   			else if (svm_nodes_in_same_hive(bo_node, node))
>   				mapping_flags |= AMDGPU_VM_MTYPE_NC;
>   			/* PCIe P2P */
