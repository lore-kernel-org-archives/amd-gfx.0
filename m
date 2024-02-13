Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E292C48260
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 20:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2BE10E678;
	Tue, 13 Feb 2024 20:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BABeRwrd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBFE810E678
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 20:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuK2kQUUdGD+Lz2I7ilRBu3h/1+A6ieRooCWaV704RpJTfjCWh2kKzlRFUrux2EZVm/pHbMPxsZJMF6cK8D/G7YRzjGxRSRJlgldPeDNBUv2U89ckImloXr76i9RmM2HYGJUXK7SK9gFjbFSjeD3N3I0JYICkeX5Bpy4XxOeS3kQGnZFMeOO1R0IYxz9h0MNI27WzOboq2HubWGgN4PrS8ko/SZFEPVrFnuW+08XdrsEQfDOBw698w2yoYRI+QwETfeK8AjhiPhSPtUw8RO6BG/EBJKjemS46jDCj0B5AFCaNjqLKkZAfe/mhtcwJAvUHKBlB/QBBny5FivFBifu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTZwp190evleVntqcmHF28nKe/WodF4wnVaAVMphOmA=;
 b=Ikvfv4Ewupzfr2ugFEWXTD5LXO6BMquTCb+e8gpT0+uFDVt6fu16a0xW92a4/e3bV2jpbb3978Q2xwse3hFoZjQbiEZJdKvi5wwfpSgyjm0hzmKXgP0TN2p8CV+zbq5kUyvijZsnxXXY48rBx6XMJUx5WcyJdrfuDNgrJDyVvHKXkiJJcpWLV6LEYfi72z5KMTypKWEOxnekTdQ9xzPb23ixDC+iESC+QZ7tcL+wQRUktyxb3z9L+uE5kFivTNy9BxVHrQJthlQcdxOmajYZWnqcJQhbhYKtubMpqEiMTuZ10ROc9oHOr9CznlSmV4mRrKnaK8dg6GXHzAIKXImqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTZwp190evleVntqcmHF28nKe/WodF4wnVaAVMphOmA=;
 b=BABeRwrd94jLH16KHKKeu+78nv3AhJHb/Cbexj9PLRXJZDSIYXj/Ur38feTqWxJxOJO8L87W2clUGi9s0nAY60errN740S6+fFyJlKhs0TqCOT1CmWKttPS8qWB8D9q90Lr2h1esx8JaCZgLgoTr+94NfYe1SCQ5arYbSZfYbV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 20:52:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 20:52:47 +0000
Message-ID: <fc8a4951-6e49-48ac-962e-29eb50e0cb07@amd.com>
Date: Tue, 13 Feb 2024 15:52:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix implicit assumtion in gfx11 debug
 flags
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Joseph.Greathouse@amd.com
References: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
 <20240210014951.73159-2-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240210014951.73159-2-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ede593b-59ba-4e22-641e-08dc2cd5bbf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yAmCqr0OsQe4ahsL/PmX0m4QNx9BHfSi5Lc/gqQ1EUZc1RLbFQ4obwy2Fn7aSOgEq5/2qL4P6hF9Mx9r20pkiikINxtcsyOZySyD6216gKdzlAKGaqk3pTw7cM6m+xt8JXCrs+SjFEMBaYVowiFyuiR7ExJKmBom9WDagax5BZxIG96Dfabk+A/BbLOTx1lRpreqnCbeULG888lekT2Y64GXz9Cgvx0vzjW30xLIgQf+y42mjUZLxfBZ4KcVxfrTlH5C5l5Zxz56o2TRB68fi3er88cKjXc7H/Ax7Wq0yay3SarZZgBHq4tVOkO3YPbXjJjOyhXxKUgUOUm6VEPRy/XNBBw4SNa+1hhKjRx1vYKY70cfAH8sj+ibPfQ7niHI5TQCixwoSVbwT1SBKMfdDqbKD7uZ1LcYbcuJlZgFpqU3XE036HjvOw6HHR9Ci4gk7j+f2NsUSVAISN2g2aruABkX9pdPiS4ir2mrYQ51Ig3kfTB7R1S8DO4b3T9yzRsqcw5FeSE0nrhVt1SvHFuFwOUwdzY++ojjNaf0mGawxBJISlFceZTLi91dKLsogM2y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(6486002)(478600001)(31686004)(41300700001)(44832011)(4326008)(8676002)(8936002)(2906002)(5660300002)(66556008)(36916002)(316002)(53546011)(6506007)(66476007)(66946007)(83380400001)(86362001)(26005)(36756003)(38100700002)(31696002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXoxMUlqUG5HUG94ek92WS9aM0dZTkY5aTJGSDdjMkRXRG00WXZheWt3RzJH?=
 =?utf-8?B?MG1vZG9NSGlZUWZJNVBMa0pBblVRUEtDVW1MY3JtWXE3UFFmUHpGOGZFSGw5?=
 =?utf-8?B?QXE0UGdNQzFJYTdTQWxNQjVjcGg2Zm80NGF6aHhMNkJBRXJuTzJKcUN1a1JY?=
 =?utf-8?B?cWEwdVdhN0MxL1JEWlRGUzgrVUxuQWQ4RkVOVDhPemx5S25pRkJKMStCeXV1?=
 =?utf-8?B?VWFrMkV0NDdnekxldHhUajAwUGJENFJtTkgramNiMU95ejZ4ZStlZ3JYK285?=
 =?utf-8?B?bTl6b01ZcnFmWjQ0RWk0K25yUzdaSjJNdnB3L1ZiQm0wdTBEcFRLSXY3Vk1Z?=
 =?utf-8?B?YXhLck5yVGpyUWo0bkYxTVQ4VDlFQzB3ZkF6a251NmVUSkxIc3pPaFAwOHZx?=
 =?utf-8?B?SGtZblA4UzR4Z1VhOGpVemRSUWMyaGdmNWRWRmVVcjFQR3FYWkt4NjM0MWNE?=
 =?utf-8?B?VEwxOW8vYWxLQmxNVGhiVkN4a3B1eWI2alcxcm9NT1M4cGpQOWxTeXFKNjFz?=
 =?utf-8?B?d2VaOHAzODRtSU5iaXljN1NyYXpuc3hTN0dIZGMyVU1lWk90M3BiSXpJSllB?=
 =?utf-8?B?NkNmanR0Umh2VThSdTdjY2FMcU1RL1M2OHJ5LzZUekpvdjJsSTFOVWNjaTMz?=
 =?utf-8?B?U2hVMU1na2xSdlZGMlB3b005T3pBK1NuUG94SS9Kc0ZRemx6N0ZoOWROTm9P?=
 =?utf-8?B?MFVJcDErR20vWWhqZW5ycGYzbzExdlp3QURsTFVjUlZLcE55UnhETzZVaHlu?=
 =?utf-8?B?cGF6ODNIcVp1R0p0VzhTSEwvNGZiVFp1WDdmRW5CYUkyOUdXMHpRenJnTS92?=
 =?utf-8?B?NHlaUUcvd3hqT0lObVpsUXowa1NENitDbWtrRkppNFZLVWRjeWcxSzRBeW1q?=
 =?utf-8?B?TmxDa3loS0M0WjRHeWM5VmZZQUcyWXQ5Q0ZQMnJwVXZVMk1KVmNxRi9qM0xF?=
 =?utf-8?B?S0JUYjFBUHpJVVpqUHFPdktKbWVqUTFuVytNbm9QdDlwRjY1NS95aHFIcGI2?=
 =?utf-8?B?UUgzRlVQVnYvRDRFb09WQXdXUlFRblV5MlVnZkpWalRnRlFIZXc5ZXlZZElX?=
 =?utf-8?B?RXNmVzJVZnhGT005ZnJIMkMxY0Y3T0kvVk54Um8wYnMrWTBUS2lPWWQ5SEh5?=
 =?utf-8?B?RTc4dWRwdTJweThPRlpVMGt0bVdzVVB1M1B0RzUvQ0JKeXo2ZWNXeVN5ZnZQ?=
 =?utf-8?B?QVpMUXdzdzRaSnhuTU10a0xXQ051bmpQTmg3SjBCQmtlSk5DbHNpTEJGSlRS?=
 =?utf-8?B?ajRUTFBxR3RobkZlS3dFcXJTcmZ4Sk15OG5abExwN296dmR1OWNYUXFOd0Ey?=
 =?utf-8?B?bWMwMkhQT0VMYWpGODRJS0RER3duNVhIanFIVWpCc1RlUEJNZUhwVjFSNjVG?=
 =?utf-8?B?WFlMZ2M0ZHNVOFJLWS9pVjMvUGtwajNBRkdPZWZ1ZGxMYXc0bTF5OERYVmtI?=
 =?utf-8?B?ekhvQWQ4bFQ5bUdXVnNrc2pnRGpJVFRoVTFRNFlPRDlYQnZVSW1rSXNBb0Ez?=
 =?utf-8?B?b0pEYmUwR2Jjd2lyc3hXSXI0TlNpRGFWNzFGYUhYd3hYdTdUc1ZxeU5aL3Bn?=
 =?utf-8?B?YmFHMmovbXRqeVdVTTJBcG8waEY1a0pUNTBiTVpPODhHaDVtUlE5VWRLY0Mz?=
 =?utf-8?B?a2I5dVpYV3lQejAwODFuUWM3RkNFQ3d0K0xJQkFsR0hyZlMzYTRUWWQ0REdS?=
 =?utf-8?B?NTFRczVZbWVNWHpsT2FkNWlWcytHdDNuQk1JYno1cWFEWEh2T3V2VzlUR0VE?=
 =?utf-8?B?akdmY0FjMUFVejRZbjhPVzlIUCtualJrK1ZZNi9DYml6YlNnNi80dEM4YjhL?=
 =?utf-8?B?bVppUGsyaktoNW5BbE5panl3RGJwS0h2RDN6bE94RGo1dDlwZHVGZGdRZWov?=
 =?utf-8?B?YXRjRDgyOVU3SDc3bEYvbXRkdDBtU3NYMlVNQ0l2MW1DNjBaNUZ1WXhyaC9x?=
 =?utf-8?B?Qm5yeDQ4bjRnZ09CUENTZ3dXbmZpbWJwVy9ncmdjT1F2aGx5bWRFOWNsVGIz?=
 =?utf-8?B?RFdxY2F5eTFlTlBHUVlFd1lTZHgzSUtoZGZ3S1VmWTY4S0xOMVlnMmk5SUJR?=
 =?utf-8?B?WDlEY3FMWG9YNGtrK2ZKaFROUnJ5ZnNkNVZ0RWxUTmRnUDFrRnVzMkl2M0lZ?=
 =?utf-8?Q?RnO9Z4I5Q1Ext2xKwlklwUKn4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ede593b-59ba-4e22-641e-08dc2cd5bbf2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:52:47.3775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2vPvqYY4hylb+EmGCOUe4kiBbaGWd4lmKFkWqYONGLWPnG/2nJmf9ww1rHdJkAz7VgUW2Dt6Bnw3h8vcQ8NbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

On 2024-02-09 20:49, Rajneesh Bhardwaj wrote:
> Gfx11 debug flags mask is currently set with an implicit assumption that
> no other mqd update flags exist. This needs to be fixed with newly
> introduced flag UPDATE_FLAG_IS_GWS by the previous patch.
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index d722cbd31783..826bc4f6c8a7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -55,8 +55,8 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>   	m = get_mqd(mqd);
>   
>   	if (has_wa_flag) {
> -		uint32_t wa_mask = minfo->update_flag == UPDATE_FLAG_DBG_WA_ENABLE ?
> -						0xffff : 0xffffffff;
> +		uint32_t wa_mask =
> +			(minfo->update_flag & UPDATE_FLAG_DBG_WA_ENABLE) ? 0xffff : 0xffffffff;
>   
>   		m->compute_static_thread_mgmt_se0 = wa_mask;
>   		m->compute_static_thread_mgmt_se1 = wa_mask;
