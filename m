Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C671560C51
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 07:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C671560C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CAEF6E046;
	Tue,  2 Nov 2021 07:36:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BF46E918
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 07:36:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVUMUEHbwishJxXMyHz/6I+8npvVez3BCnYKGOU2hvKgbfZESrnway0EEuBzMgWSiX+NognqZmwfG64Pg1laARUw2jzPdH/R7EfIhg6/bqD5nGJUBwDQHLE0t+OCHouCq4sKTjDW5R4gutMxjjFLN5IXhwyXoIXPgEr3zpuX/y+iMJU4uM9vDrd3gyMTdsfn1TYNXTiYU3mS8zL3TxbXuLtDjXO437aoLN4To6aghl5NKNf5Wx+g6Ajp/DjBer352JcTGYVkuVF9DCGeyS6QbHfd5AoftoBcdKm/qFIkeFLCc2cJqPYdqopsmbrRTC4KJui3hOq1E1tXVDV8WZvNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I13WEvlDDDZJckTNrq27N7e+KVCD/9WtYs5FZ/a80w=;
 b=bb9CHPUUIDNBaBwTptHXPLYdAlrDNtRwziS5ilOkJgBWxvzyVOtl/uH4FjIcJxQJTI7+a0jpU1DiaLGPLOWSfYaIO74cIZXJ++VrkpHACqYJ1MJytnRj5C8xtV2Hj9YVSURBNf8jWAFz1cPRfLgwR7b08w6lW1GTMVf6Ps6wkVjIIxpit7zDqknLMgMPITLyo2ll3GFrhnfN/vcTiY8OT02fkwKHG7SCfxoUkJUC1e+tf/nOe87POy0oHd1NT6OOm2CRdpV5LhEYPmOv2YUAROGQ+U9xQ6VZRBbvrU3iXoI3O54aQWYW5mweHE8wdUAYZTNsRKvzedxWgCFv5MBJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I13WEvlDDDZJckTNrq27N7e+KVCD/9WtYs5FZ/a80w=;
 b=ysPPC69FDsk3uynhKhDbmYfk3/wusgnC4uv4iToRoMaE8L8tXhuQjx4t8BffNUVL8b0dTuNA5vvMGepumreBQVSBHJCsUNuC+M4Fqrc3yc8/JTncbW8wctuk5aCQDkreGY81G29h93VoVx2z+PfNDMFfj2X9XFjDDPFIGVDR1Nw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1214.namprd12.prod.outlook.com
 (2603:10b6:300:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Tue, 2 Nov
 2021 07:36:53 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 07:36:53 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: remove unnecessary checks
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211022110311.128971-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3ef7b422-80f6-354d-7cba-cab59de8ca57@amd.com>
Date: Tue, 2 Nov 2021 08:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211022110311.128971-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR10CA0071.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::48) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:2746:f022:81db:a2f4]
 (2a02:908:1252:fb60:2746:f022:81db:a2f4) by
 AM6PR10CA0071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 07:36:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba2a943b-3836-4840-94b4-08d99dd389db
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1214709EC1AE9FDEB5B54898838B9@MWHPR12MB1214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWUgeMTuWDXyLjHSCsoczg5eMJchlI5msPkoBU1ignrIrGVrh9E9lf6VafLboNzy2nrO0F8hq+aIAMN7cSX3hdHLR5VQWyW10YL11hOPwDHTv6euLSvuQpM48LQELV/MUpshwk6oQ1G9YDGqmfFPSDXBjqENpF3VjJAjtLidOvDWNtb7G6OHb1xtsvvLnnUTqN5phIpbk2cORX+koMLxXFz0FOnt/qX2fXCCwIi3U4ateHKVfR3qhRI+b+LFSOjC2C7VqkNzMGMm1KoJGWErNP8QPQ74wXMSUB/u7wf0d3ivdpsx+h40XkzsWiubi0HbNLGMhHVwpaLWLq2tRvQiAanqnemasoVAiAHrutkEE+ccyp4kbU1gaTN1t0d0jckfQmUKqnWDCN7pF3z3t4RMCYnmxonY5chVFR4J3lZ5flBM7mrNRvCtIAN1cLWp8PaWnANInMhIlHdDvdyIb3+CCm8IPT6XkuWigPJgOytQF24wsDBvVeajiQsqnfTTFQ2oBtOPy7Nb7twtCIa1VNtLQvcv2hnzyv7jtM2aGVmi60opjb2QaBgPjHsADjoqhTphvv1BX8iqaofnZN9ZBopyRU3K9ihc6SX3q7QcET9TT1JWx8xkOgImM/zCl23KHwSA/h3jWYoo0tWNzSBheDbfClxYblqee+E3YitfwyzwSEMWniM18BfjPATpTf14d2chDUxzneq7SjqZHHgXT7F/wuFPdKy9ExBqEmhJaYNPGQ5Y1McjESLpkyxnjZc6oTuq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(31696002)(8936002)(31686004)(86362001)(38100700002)(316002)(2906002)(6666004)(8676002)(508600001)(5660300002)(36756003)(4744005)(66556008)(66476007)(66946007)(2616005)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3YrckxTSzgvTEQvQThCMmxJSzUrQjQwWWlkZTdoYjNFWUtFbHFkVDcyNEU5?=
 =?utf-8?B?bC9yVUJiUXZoWGpkZldkY205blFyYXYrWFBOSWlBNWg1c3RwM3ZqK0pXMVNj?=
 =?utf-8?B?bnM5VmVzU2hydUh4U0QzR3FiY3ZDS0JBMVhVU0d2TUYxWFpQcWM1ek0remRp?=
 =?utf-8?B?Z1pGbEVaTEtHd3RDMFZzdWRQVTg1czJnQUV5V0VscFozQ1JOVURjNldYZjk4?=
 =?utf-8?B?MWJPWGdhcmNUWCt2ODdoUlU3RGs1SEpHWDVkU01menpWWkI3Z1M3TzN6bWor?=
 =?utf-8?B?b1RZTlJTRWdsbS8wc0E0UEVjUUI3QjFhR3dBUkpMQU1NZVVxVmw2aXhvV0Rj?=
 =?utf-8?B?ajNiVFdsaGdjbm81SFBMVjRhMVFtb01rUWpuSU13Zm0wdVBhN3NteEl4djU0?=
 =?utf-8?B?OEN2Y3VabDcwZGgvd0xTMVNIV1UxWmcrOG42bWtFSlUrM1JvVTQzYWVhM25h?=
 =?utf-8?B?dWpyUkwyUm9ONU5DeHlUU0ZNYktHRFh3WmtnZ2RlSWtTYnFZUWdtYnE4d3U3?=
 =?utf-8?B?Nkx1aTlkRmZMUm5GZGRSdzNNUVNkUUFuaUtYYlYwSng0WHNCSUJJZW1ZSDJY?=
 =?utf-8?B?dUc3QmRCcFUxSnc2VE0xZ3dIZEpGWDFFd0xyTXRTSWRNMEFTYUg3UUZscUM2?=
 =?utf-8?B?T0xWR0Yvd1p6SmRJMUVwRXE0SDQvWklOUVBZMDcrZ1lEK0kvME1YNEtFeW04?=
 =?utf-8?B?VGhhRmFaNnF3K3VwNUZ5dzdZci81TEVUYkh1TjAzQ0lKbWtyTmlWdy95TjZs?=
 =?utf-8?B?UHI2SFI5SUtvcXlUN215R3B2NDE2MTU1S2M1R2VETFp0V1FnMEVnRXhiN1VV?=
 =?utf-8?B?THc0U0QvWE5Bc3E4SVR0eVN6cnlZcFRrdjVVRURLT0ExN0srVmwrNTQ2VkJw?=
 =?utf-8?B?dEdPajJrbVNuOGpLelNlVS9iUUFGQ2xPSmFNRDhXTUR0SDVCUm5zNHZEQmNj?=
 =?utf-8?B?SjdKU1l3ZFNWeGpBRFZGak9meWU3ZFpqZkw5VFRaTlRHZTFrN2V6UUhHNFZZ?=
 =?utf-8?B?UzVRM29YbDBFZExRZ20vWjlFSStJeGZTT1EwVm5FMGpsbWJvUzhmTFYrNERH?=
 =?utf-8?B?d0R2N2tlSlUwcjZwbUo0RTVMMGJGdzlBNkRHWUdHV3ovUzhWcGNKaDluM1Vz?=
 =?utf-8?B?cXpHdWZib0pNNUVEOU9XRm96RjZQV2FHRm9ZUzllZUVteGFrZ0xDcStLdVBV?=
 =?utf-8?B?NE9McjVheEorSFdBdFA4WmxESGozK2VBOGxsZHZGSnRUN3RYcHJTQlJzMTNz?=
 =?utf-8?B?NUR3elF3UUVxRUR5cUVjMDlkMW9QN0dYWjlyS3dPeXlZNnZrbUU0UnlycS9F?=
 =?utf-8?B?aEd0WHdObU5jUnE4cnJRWUxBSDMxK0hoT2cwcnJTNDlaQk9USzBKU2prK3lz?=
 =?utf-8?B?MTRweWlIdmx6eTEyVUhKbWZ6VXRDZ09TTkltdTNmdzU2YjNhRi9DNCtxZ0tD?=
 =?utf-8?B?ZHpiazA5OU5sbTJnT1JiTVZGU2c3VUFKYXJmL2VmVFU0aXFuazRuVHNvWXVv?=
 =?utf-8?B?MFZrbGdoU2ZwQitSQzVEdDZ0dWxIVTRlTVdSOWJZS0k4bExuVEFLNzhVRzFx?=
 =?utf-8?B?d01NazhGb3VjSTJ3TDNuM0dmanJhZ3hyRzZnWVd4bnlFaVlnNDc2SFpueDU1?=
 =?utf-8?B?Z3dMTkVraDkraVlMbmdCWlFzQXF6czVGUE1VS2dwTUNEMVFHRm1UOGhLWkZQ?=
 =?utf-8?B?dTRObkNaQ2pJMndpeDdBVHFSNUc1UkRiRm1ndE1veVhZN2ZORGNOamh4NEc3?=
 =?utf-8?B?bTE3ZTAyRzZKTkxQUCt4ejdBU1JlMHcxVjVQNGw2UER3YVdha3U0d2FGTHdD?=
 =?utf-8?B?Z3k4WEQvMExmMmJhWlJGQ1hIcU5NR3k5MlV2NGpvNFVCZ243RlgwQmlESE9p?=
 =?utf-8?B?YkFyYmRyT0l4dUtFS2xIRXdCSUwzZDdodDBoTnE3TDNvYTFldDZnL2xGVWRE?=
 =?utf-8?B?bkkzNGtzY2NicFY1VXJGYjhxcUo1WjdmRGpZQ0hwMmZJbERGMCs1S0d5YldB?=
 =?utf-8?B?NWJWWVN4VW82UnBsNmd5b1FtQVV0TUx0UlhJMjlSWS9WVGZseDkwSW1kOElY?=
 =?utf-8?B?YW02TzlrWW5ZRlI4dTRUZlZBMXNidWltZGhsWitYeXhySk1aWjUrQXNmZ3hj?=
 =?utf-8?B?NTdxK3hyR0oyL20yRlZnczdrWWRNeFo5S1FGb1MyV1kvWEZZQXlrUDFJcE1Z?=
 =?utf-8?Q?A9Cb4gZFiwmt8dFQOwtmaPU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2a943b-3836-4840-94b4-08d99dd389db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 07:36:53.1442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWu8wNof12wjT/qw9UeSeIsKpeVMTOfhD956VVlArcGh80SQoYygBQx+YUYSXYRp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
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

Am 22.10.21 um 13:03 schrieb Nirmoy Das:
> amdgpu_ttm_backend_bind() only needed for TTM_PL_TT
> and AMDGPU_PL_PREEMPT.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d784f8d3a834..eb872fc4ad92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -914,11 +914,6 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
>   		     ttm->num_pages, bo_mem, ttm);
>   	}
>   
> -	if (bo_mem->mem_type == AMDGPU_PL_GDS ||
> -	    bo_mem->mem_type == AMDGPU_PL_GWS ||
> -	    bo_mem->mem_type == AMDGPU_PL_OA)
> -		return -EINVAL;
> -
>   	if (bo_mem->mem_type != TTM_PL_TT ||
>   	    !amdgpu_gtt_mgr_has_gart_addr(bo_mem)) {
>   		gtt->offset = AMDGPU_BO_INVALID_OFFSET;

