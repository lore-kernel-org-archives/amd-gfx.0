Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F75CC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 15:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D9010E3B3;
	Mon, 24 Feb 2025 15:21:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NrZzcWnc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEDE710E3B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 15:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPMCetcTuCHSifuFMDhdwwLdiru1MDTMv+ehoZFtylVMXLmJil/yo7KMOrXv3OddwmixtiIY4Zl+cSDbAuoAXStevMVyQ+ZhzEqsbc1Oql1APtl6ETqwjUq420/KPwnrrx5/+Ryy42UoaRHcFZ0dmn8tBMBlFZZgxRQQRhkSOj1fkh9cQWABJVaVe7Lfr991sYhRljeO4UE+fqPDhJnyPXo5XKho5RvE/L3E8tI1mTNwyllJieGJomGmhJelWo3A9ORPqgvwbYCKz91+ErRGFpQ1yac5fGHqEfWUsxkGigGjnY6/D62kDVIi+oeA9sx8vp2xwhDZL94abVcgeMzH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7R2OBwk8T60IMgGlbYpPzZe4420Z1T2L8+gu0wNZj+E=;
 b=n0SOFLfJ0z1aSE1C+nnVg3/I3mvL5sPySPI/dTLuV8yic8Q0X7n+pGTxts0ArMvVE4l1QIWNGIiOdMPINQmak7KmzE0z7du9uenR29uzEpvpApdmPmTJNcLT2g8fd4ORfTlCDVaJBqIKkr58BlOeTSsWR0D47VJfHufd8ngpXQl8HTQbi3nZenMPELIZWqd0ERJfWNhDYp4fCRal5JVHjP+5JjZIPu61Mu4gqoKBzSHkHlSMqx0mhUoPv1GN6N6dAnhBDnSPgKP5SISXA5T+daR3aHCtob4v5+eZQDoxhOZCcG70QD/pRzBD6m8BzDps41at4bFCH0vgm5LWBK+72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7R2OBwk8T60IMgGlbYpPzZe4420Z1T2L8+gu0wNZj+E=;
 b=NrZzcWncrZXfITq9K03rK8k2+iVyfqPt/A62ITcEt4H8GP99ZZqBikQGmYUWUl+Jv3cht3Msk9jBO3hVl/fNotiYgtW2QBLsCE2XqRUFXV4kvsXNULxsfnKTejDIavpwPWLsUBU5UEhGFTX/7ByveI/EkJIlLWfcsIGtFP69WNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 15:21:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:21:18 +0000
Message-ID: <b39227e3-31c8-3e8d-9fce-ddd0f2943494@amd.com>
Date: Mon, 24 Feb 2025 10:21:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250220115946.2051216-1-Emily.Deng@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250220115946.2051216-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXP288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b4d65d-45aa-4d8a-ab6b-08dd54e6e32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFRlV1Y4M0xTT1N2K3VYRkVTYU5NdWl5c2JoaEgwS3N0ZCtvSjFxUzd1d0hR?=
 =?utf-8?B?OFVPeUptQVFkUFpFYlQvVmlXcDU4azZYZlR6czRuaUdITkFaenQ2b1JSMndJ?=
 =?utf-8?B?aTNadWYxRmg5blVQUjZOYWdPL2RFd1FPV3VCQmF2UllEWGxEWDVsM0pwSEh5?=
 =?utf-8?B?WEpkbHhWUFlzdXJNWjJPeG4xc1VnV21ZZ3M1Z3lFdmNFbUxQaHhESXFEWWJi?=
 =?utf-8?B?Y2FCRTB3UXdQVURTd2VPSnZ5dE12STl5L08vNUo4K28xUmlsb2hES2wrR3hx?=
 =?utf-8?B?KzhJNFVETzF0ZUNBZDVYZWl6WFpDZ3FUSjBmZVY3djl4azlwNm5LajFxMmVm?=
 =?utf-8?B?S1M0TmJ0dFpwVVpsSTZpT1VuQVpIckJlbzdtcFdiUzAyZzA4LzRJeFF1UTgv?=
 =?utf-8?B?cytoYzMyZjJYWG43andmSitaTDVENUR2YUtQajk3SGp1NVVFbEo3R1ZZVUZV?=
 =?utf-8?B?ampZb1ZScUtlTEVvOUVMYzlQTWdHbnRFL0h3UkNxVEppOVNURXFVZjBXelpD?=
 =?utf-8?B?RnpIcEJGS1VtckdKTnlxMTROdzdLRDM5Mmt6QUhiZFRIMklWL3VKajhYeFJy?=
 =?utf-8?B?YzAvcVdCRnRKUlBKaGxGV3B4dnZoTE4xaTNwd3F5N1FVei8zTXVoRUJmVUQy?=
 =?utf-8?B?S3Bsam5uOTFIMS9Yc0pvc0FtQXBFSW1oQTM2dG9CK0t5aUduMFpiaWwrVGpO?=
 =?utf-8?B?N0ZyQ3U1NEl1Z2h0VW9UdWVhMkdFUmtmMDhLQ1ZLUGwzRlQrWndIUldjRTdz?=
 =?utf-8?B?NHlLa0QxYklhU1l6YW55VFhjYjcvNzNXdmpZWmdabzJWTnZGVHZHcE52S2Jv?=
 =?utf-8?B?Y3U4S2ZUSmlqOUp0aW1Pb0w1aDhlaitTVnNBRlhvVjhMS3VuWkRERkVoMGlG?=
 =?utf-8?B?QkIrTzF1eitvZENRS1Mwa2YxRU9Zb1g3d1FxMUVZU3NUUksyQjlUUEt4SFJ4?=
 =?utf-8?B?dlFmTU9teFowMFZCaTEzb0hsUnZFQzlJd1lRUmlyVnV3YWl0bXRNWS9ISWFY?=
 =?utf-8?B?OVNza0dVOGFqdkp3amRMWHZZYUxCSmEzdDBNU3dzOHBoNVkxWVcwbit5S3RL?=
 =?utf-8?B?R013cndUTGpZaHhoTWtYbGQzbEpnZTlpaDMvQ3U2OUd2RzJpMkU0MjVoeUdp?=
 =?utf-8?B?dU02UUJLNmg5ZDNaenFqNFdUV1MxTWJzQlNFZFFPK29DcEZoSHBvVVE0cVRy?=
 =?utf-8?B?MlBDRnlmV1dEYTNSUVhxQzBQZGlvaytpMFhKVldRZ2MrSStiZVYwa2xRMTQr?=
 =?utf-8?B?dTNuc3NBa3JYLzZkZmdBaHVObStOSlhYZjRaK0lmTWZSOTdZYXd0bVZSZHdv?=
 =?utf-8?B?NHEvTnF6Q0R3MjJLZFV5TEgvTXJ2dk5kNWZpSjdjOXB5SVdQNWZjNzl0ZzVy?=
 =?utf-8?B?TTdTbk1GNjVYa0pTSkQ4NmxHY2JXSk5JOFFOTmlUMVgydDRuOS92UVdTOUJT?=
 =?utf-8?B?UFA2bDQrbXlZYVFPZlY2ajNhUzVQZXVldmVuUlIyUHdjY2RhdGw0aS9rb0JH?=
 =?utf-8?B?cHc2c1Q3dzErUitwSlMyR08vY2NiN3BmR0FsdVRYV0trV2JqU1hrQWJVUnly?=
 =?utf-8?B?WFAxNjdBeE1Ib3J1RUVYV3pDTE1LNTZQeGh2QjM2NEd2Q3pmaUY3aGQ0RXh4?=
 =?utf-8?B?YzU3NnU5N2xWcDNqbm40cFBwTGd5bDF3T2phZ3EvaWhJQTVhd2pRMlBtMzNC?=
 =?utf-8?B?Q0ppelRUNVdRM2pLeERiUlhOZU9XTlpycXd2WU9oNUpkc294S040NFNySEFy?=
 =?utf-8?B?VEJTRlFKdXB3aGpGOGlSUE1NclhlT0dMY2J3d1o5QmtpV0Q1bTdmdGtyenBt?=
 =?utf-8?B?dFowdW80a21IZmhVV3Byd2VnTXBRZ2JWNXRxN3NrZmIzbHVCaEtwZlBtQ1RE?=
 =?utf-8?Q?YdMp7Doujtlwl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVh2OUc3SEIreEd6UmF4d2l2U3hmNjB0SXhWRnBLMTV2WUpsd3NUUzE5K2pR?=
 =?utf-8?B?TmltcUpJZ0NKcVV2a01qOUhSalo0YnhjMWxQYUdtczhrbVhrRFpGWFBzR0lh?=
 =?utf-8?B?dy8wclVaNnRSalhRdU5aN0Y4dFhlby9NMllkMXBvdDdqWGRjUzVuNFQ5dnMy?=
 =?utf-8?B?amV6b2NPdVBDZTkzdEQzdDk0RkxzT3BBN1M5alVkU3FpOUVyT25nUkVqVkJy?=
 =?utf-8?B?bGJPdWdqMkNtTDJJaGJxYWo1cFMzVWRSZlRlWUg5Q1hZWUN6bG1lUHJWeGlD?=
 =?utf-8?B?QS8vcVpEZUJhd1JLWnBwM0QvVHd5YUwvQVhTRkkyWERGemRGK1F0WVdOU0Jk?=
 =?utf-8?B?T2prNUhKcWtkTW14WERNbERXUmUvU25HT0xEbU41cWs1N1dxTVBYWlFJWW45?=
 =?utf-8?B?SkxWdkNaTmpMSVJSdHkvdkdwYXJRY3JoV1Radlo5YXVJWnB3WHBFYmI0TDBn?=
 =?utf-8?B?ZFpIbXAyOGJ0ZkVqSHpTcmhZajRHcmFmV2dzMGtyRjUzZHRzWjBYK1pvT2dN?=
 =?utf-8?B?R0tsMlFxTUp2QVYxSUJyNEpOT2dyYmlLUU4yYU9ZMWVhMmRYNGtiQW94VC9G?=
 =?utf-8?B?QnJyNGdaclQveUgyNlZMVURJSlQ0ZDU1b0YxU3h6MzROaEhnak1MZ1d1QmVv?=
 =?utf-8?B?MWVYYWVOdFlJL3dEK2pVWTdaUWpkaXpXRm5xM2pPWnNHQ3hTZGh5Zk5GNUtE?=
 =?utf-8?B?SWNxeGVJVWVNWThjTU10dzlxOE5VMU4vK3JZVG15L2V6VGF1Yjk2SVB2am9V?=
 =?utf-8?B?dlVYMjViSW1nYmVoazFZNlJQSXBGRXR5aWtQZHJ5eHUzMnNDR3o0ZEdJTnps?=
 =?utf-8?B?QzB6eGswTU8wNXJudEZwRUJSRjR3N0R5SG5aQjNqbkI2R3lKM2l1VStWdEVm?=
 =?utf-8?B?RWhPak44cDJoeVNkcXRBTDZPTGowY1ZjcTRxRi9samppWDhhVTluYmcyTFdu?=
 =?utf-8?B?ZW1WSGNaeFpoM0hiK3I4QWZ3TkNvRC9DemIwSTZ2eCt6UURqSHI3eGt5WS8x?=
 =?utf-8?B?ZDU1YkJhWG1qejZwbG82S2pnK3J4SGNySlh3WHQ1UElDNzd0OHJkQjBEQTI1?=
 =?utf-8?B?aGtranh0SUN4V0xDcmZRWExUbE1mYzA4N0dySnhhd1NXZGVONDBSUWdrWXhp?=
 =?utf-8?B?WG45UUQ0d2E5U05kOEk0L1Jjd0ROeEd6Q05xQnRLV2VuVDFGNENRVHlDQk5W?=
 =?utf-8?B?TDNob0QyUFhESUQ3RDA2OTg3MGwvWks3YzUwZzhENDlHM2hzeEhYY09ZdHhj?=
 =?utf-8?B?L3dBUWx6ZEx2eEw5SHZsczZaY2dZV2lQVE9jNncrSTVTZTdLT1E0Z3RiSlJX?=
 =?utf-8?B?NHJ0R2RZbCtGNXkxZlg0WU5oYjFaakdWMmpoUmxEQ3VsM0ZCTDI4cEV2QkRz?=
 =?utf-8?B?UFA5UFNLLy8yM0NVOUtsUGhoY0pOazhHQ2hBZGxoTzJaRDFReE0xSXF3alVZ?=
 =?utf-8?B?QkVZOHVBWERYZUZIMTJUcExyWHFFb0UzWUg5c3BXOGlYK2g5TTZzMnFPcTZw?=
 =?utf-8?B?aThCQW5uQmowVzNDVjNwaVBYdGd2VFhjZ2hVN2lCM2pjOVBqYmhnUy9Qcnky?=
 =?utf-8?B?dlNrOG0vd0Y1SFA0djJnU0RIZlRzM211aUN2WTFwQWpKRkZtTnFtcG5ObUVr?=
 =?utf-8?B?ZjNnaWVFVHlmeS9UaUpwUU9pMXpjK0I0Sk9Nd3gyUWQwM2pXWWZQSE9uQWg3?=
 =?utf-8?B?MmR3ZENJY05UNTVLSERzTUNSKzVBbzJTVzh6VDRnYUJPUTFWVStaejZDT2RE?=
 =?utf-8?B?NWtpRHdXU0NYNytZQ2R5ZFd3eVloK3lULzl3Y0tIb0EweDJFU1NJeGN4eDZk?=
 =?utf-8?B?cjVIdURLNDBRZzdrU3dRY3J3ekJGMmhCeTZDQVA2SWRuSU1hZ1FPTFRCRHRM?=
 =?utf-8?B?R0NwTTBaRXRSMk5Dd2FJeGZxSG1SR3VEV09RQTIwQUNuQ3o2MkhiT2Y2VWd2?=
 =?utf-8?B?aDlpcTVWV1RwM25lWVZkVEkzMUZlTldVd0tKbEhqVGNhcmY4d2psbi9RbGtI?=
 =?utf-8?B?bHhjZENxSzNVRWkxcnhLSitkbXBrUHJEcm1tNVhxaFlkMVgxQ0xJd0lqZFVZ?=
 =?utf-8?B?dExRSjByaU0zeUJ3OU5WS2h4S1FWQWNVZllEbHVXSHFsa2psb3RWMGRKdGJy?=
 =?utf-8?Q?aaOs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b4d65d-45aa-4d8a-ab6b-08dd54e6e32f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:21:18.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oVqjHC3WdXXXuHperrb1rqRY2xxYW+oJJsl2sKS/biEo7ogeE2wJP08POlHETRI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
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


On 2025-02-20 06:59, Emily Deng wrote:
> Call amdgpu_amdkfd_reserve_mem_limit in svm_range_vram_node_new when
> creating a new SVM BO. Call amdgpu_amdkfd_unreserve_mem_limit
> in svm_range_bo_release when the SVM BO is deleted.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 -------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++++++++++++
>   2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 79251f22b702..3bbc69751f7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -514,15 +514,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	start = start_mgr << PAGE_SHIFT;
>   	end = (last_mgr + 1) << PAGE_SHIFT;
>   
> -	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> -					prange->npages * PAGE_SIZE,
> -					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> -					node->xcp ? node->xcp->id : 0);
> -	if (r) {
> -		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
> -		return -ENOSPC;
> -	}
> -
 From git history, this is to "make sure there is enough available VRAM 
and migrating to VRAM doesn't evict

     other possible non-unified memory BOs.", without this, it will 
trigger unexpected OOM killer.

We should keep this for xnack on.

>   	r = svm_range_vram_node_new(node, prange, true);
>   	if (r) {
>   		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
> @@ -560,10 +551,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	}
>   
>   out:
> -	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
> -					prange->npages * PAGE_SIZE,
> -					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> -					node->xcp ? node->xcp->id : 0);
Keep this for xnack on.
>   	return r < 0 ? r : 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index db3034b00dac..c861d8c90419 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -430,6 +430,10 @@ static void svm_range_bo_release(struct kref *kref)
>   		/* We're not in the eviction worker. Signal the fence. */
>   		dma_fence_signal(&svm_bo->eviction_fence->base);
>   	dma_fence_put(&svm_bo->eviction_fence->base);
> +	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
> +		svm_bo->bo->tbo.base.size,
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +		svm_bo->node->xcp ? svm_bo->node->xcp->id : 0);
>   	amdgpu_bo_unref(&svm_bo->bo);
>   	kfree(svm_bo);
>   }
> @@ -581,6 +585,18 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   		kfree(svm_bo);
>   		return -ESRCH;
>   	}
> +
> +	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> +			prange->npages * PAGE_SIZE,
> +			KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +			node->xcp ? node->xcp->id : 0);
> +	if (r) {
> +		pr_debug("failed to reserve VRAM, r: %ld\n", r);
> +		mmput(mm);
> +		kfree(svm_bo);
> +		return -ENOSPC;
> +	}
> +

The reserve VRAM limit is only for xnack off, as xnack on VRAM over 
commit should work.

Regards,

Philip

>   	svm_bo->node = node;
>   	svm_bo->eviction_fence =
>   		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
> @@ -655,6 +671,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   reserve_bo_failed:
>   	amdgpu_bo_unref(&bo);
>   create_bo_failed:
> +	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
> +		prange->npages * PAGE_SIZE,
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +		node->xcp ? node->xcp->id : 0);
>   	dma_fence_put(&svm_bo->eviction_fence->base);
>   	kfree(svm_bo);
>   	prange->ttm_res = NULL;
