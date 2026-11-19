Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD7606C30A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F6zY72wm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB261124E1;
	Thu, 19 Nov 2026 14:48:08 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1AC1124E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npVoqI+JhcJQbr8qdwZcVUnH1+aXWU+YOBUl3x3ZotWdJKSuxwxK+0QhUORgiG7uuL7wKO7vSbt2ooTpL07JaWS53J8fHjJcVYxgMbFFMhmB4UznpdMIu+RMmKBBflWv8HY3gDI/mbekvIUG5cm7Lc23X/Ju/CqS8cn7oy6hXBQ35BohVPq7HePoOUyk3hsNMbalDnDLKhlse9qW7nKuWr/h8qPbQtjxz0HtwSl7xPm++zbaaLd/sYDmeAna+0suHaKzEhpuq4EYclwFFMPVAmsfa6/hhNKjw0LNu96SfmXlLlgJkahNabmW2QUA+2+Ait9eI+oHjbFTBkeJD312VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGSfVXYqkKZ4k43xRjPK7YxzcRCkZKNk+0LBJj5Uj3s=;
 b=bX+r9OKCrbXbWEMdcCXLSOjWllyXMZ9O6B7Ci5E98NuvD3i/YARqELOHPSF0ImyFm5mWlZIqEtSVWXovJCyrFRDxkNy5ZcEO5qD0Rv4El9JiDDeI4VKeNSEYcH5FNQltT0tQcmQtjjOxGG19u0kGbnNL6ISYsCZzV4HQiUbVycJwRAUX/m+7x2x9KRrUMA04knvZt+CX7O+RpnSuMh0zaug1mXFca3n23kHsw40KGKzfhXV9u9iMKrEkxfMDcC18FQ0iF5IhfmpOJ8cyg7j4fs4K0ECNdC0GfJ7/JZX1C08wbzhZCPj9OHK1DKAL5I+EdVZGq2D5dXXBjwFtYiw+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGSfVXYqkKZ4k43xRjPK7YxzcRCkZKNk+0LBJj5Uj3s=;
 b=F6zY72wm1frocfT4kFjRK5xOy2BCV4C61JRmijWA7G8Uj21O2Q0m8cCFD6ZuEotox1+SZD9nmNXWAKkohAb5g/lrnPpNvFGTgCtU0KsX4oDlTBLiuGEe8ffqf01/l3Q4eGKjrNTlqZqkjeJ/Oma0kOlgSD1OMJSeG8vdrinKPRM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:46:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:46:42 +0000
Message-ID: <6cd1af3d-4647-4cdf-a351-b65effdfab48@amd.com>
Date: Thu, 19 Nov 2026 15:46:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
 amdgpu_vm_init()
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Sunil Khatri <sunil.khatri@amd.com>
References: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
 <20261119095652.3510341-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119095652.3510341-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2564ad03-dd7d-4853-32a5-08df464bed4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261021135927099003|261021123027099003|10067099003|11063799006|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: UqRaXCxFMdx9oIENgT2sbE30nBpigkjEHhi8aKbKiGvIF0JssVYwHsMy9NZSc2jZbvzYISMhWoMxdJYHogzue4vrIKO7lkSXw2AVVvKpqZl1JApYyHwv/2UhjE5O0BwbW3TeeWt37oK9XzQYcXI0VHou7IvTFHyjjooXy/U/AfIZ4YtD614Ay8YvB0ZzC+wDxMarNh2KskNHVgEVoOZeuz3Fp/l4dIp+sVaEbMVVgnBDS40LWB+gFAGmLjsaVkws5lQU3MF8u9bQpsO7Res3rmGX0wk/Q61raoRNvm73L5hfCCx7wYo4x9PlCnigmvyGJdbwIIJr6x1sIzGLpkDTK1aKIpJf9MwvZ/6NZJS25hV9ygdab1j3q/uISZmC1I0Rl5Kb9zFcfd88PZpihnReOrt6txd+aOWbQlQAIGzTfKRTK5ynLxniaA8fKbKgGHVcd0GL9zRY506pVi9on33WuaWl7t0Yo8EoKCq/fYG9TKB35F/ey1o6FhoywRJlc3Agk/m7TWmVAvrtrHubydcsnXFsFmPw643n6EfHzRJLmIxnvdQHseCnR2zd6o7BMFUi8WD4SDOsBlF31yhv6MauNpYNZ9SXuqUh6HorqKWZXTVHizLbbvd47EGMAd2+QYlaL2CNCE2+JCJOFF91pLu3ExpjvleqTr/MyGkpjzB+/ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021135927099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blpseGs2b1AzSjdZRXRCZlNTVHJuOXJvRHdraEFqZWx6QjQ4VVBhaCtEZk90?=
 =?utf-8?B?U280RTBkK2pFeHd5STdsS0l3OHhSRkFtYTh2MkNtWlRyR2RCQ1NQMFJUd2VK?=
 =?utf-8?B?Z3J0SjBuSm10dG00VWgwdjA5VXRkSkl6K3ZFaXJlM0l5ODY3T2FGcWtPRHdL?=
 =?utf-8?B?aWF1OXhYbGNzRUVjY2hnV01laUd2akNDOHlBKzdmUlRucnhmbXBkLzh1YkVq?=
 =?utf-8?B?VXRMMUFFSURFb2N2dTNJQmszQzA0VncvU25vN3VpTDEzMUIzVHB1a3lWZDk1?=
 =?utf-8?B?RWs2ektIN05wUTlaY0hnWTVxWTVKSXRxR25LT1FSTHg2dVBpMndQaEJ4eVZl?=
 =?utf-8?B?MTllQ05XamsrdDk2YUFtQU5mRTQ2MXRTclVFaEw4aWtBL216RzJQL3R1QmVi?=
 =?utf-8?B?bEk0RkNPOTJlUldFNXNEVktZOFNpV0VzT2theFRUU1BNckdHaU5Ha2g1aFF1?=
 =?utf-8?B?SDVuU1o1WU9OVWxXY0ozZStkSkxsam9CekdhVXYxbFN2SkpNQzVudytQVTk2?=
 =?utf-8?B?RURTMC9pK09ockxFT1hOU1hYeEYzWUl2ajVRNm94ZGZHNjVIY1lWZHVwQTRl?=
 =?utf-8?B?UGV1L2c4WVlDaWM2TW53ODE0Qnp6Ulo0S1RxTmtsK3lYQTUrazdGU1JCRUEy?=
 =?utf-8?B?MG01dUR0TFdpMzR6YnVtVlRKYkZWV2JXOTBKWmJ6RS8yazA3V3dEUjB0b0Ur?=
 =?utf-8?B?bHRzekdITm56cHQ1emxhT28rZFlndE1yT3dReUhSdmVLNzVFb0poVFdTNXk2?=
 =?utf-8?B?REVBTUM0ZjhMTFF1YkNVejlnNFl4TEkxRVlqWmFqRUlPUC85Z0JQL3JEWisx?=
 =?utf-8?B?Y3FhTllidEFqN1hkZFJ4d1U0RUV1ek9jaUxyYmlzT2lqLzM5ajBFN3pFMUVD?=
 =?utf-8?B?ZWhCZGV6dmFwa0ljbjhuYkwzRHRyQVdxYlBtMDAvVFg4VjVpOUxXNzdvNTk3?=
 =?utf-8?B?QktvQnQzSERVN3lJU25veS9yaFpqaVJlSU5DekZqSjN1U2dBdXBlMyszb0tj?=
 =?utf-8?B?K241VXVoZFFVZ3lCNzhUTnphZDJITFB6SVhXVVluYmc4WGRYdnIyQ3U4Ukpw?=
 =?utf-8?B?ZGVKcTVTdWxRajdMWGJPNDIrTE1hZUdKb2RUOWNxdTVyaUc0NHRXRmVGMVd3?=
 =?utf-8?B?Wk1XaWc0QktZYTBMSTZ6anBwZjBmcXlLS0t1VU5iTXluTElUdGs0RGZLTmhw?=
 =?utf-8?B?TWFLVmJUY2hSOE5JME8vUURhTFlIdHcrQUxmUmRIdDlLc2FTUkptZ2toTmFI?=
 =?utf-8?B?R1gralViRUo4RFY4K0ltV1llaDYreUE1VDdkbUFIK2pGZmdzcXRnRDN6YWp2?=
 =?utf-8?B?OHQwSStDUGFYaExUQmxQZnNNZTBSdGowNnpmaFhyUTBGcy9mWURoZmJrOWlj?=
 =?utf-8?B?Ly9mSElCcitnV0N2RStzd00rZEVsK1RwK1VtMktSZnVRZThSRXdGdSt5cHRV?=
 =?utf-8?B?eEVOTlNOWWg1cUlUbDZhSWF3QUloampaU29UdDBzS0hMRW9CQXdJa3k1M0xt?=
 =?utf-8?B?WkV5RzE4Q25lUWdJM3FjRVFRMFB5c0pzUXFQMG5PRENnTnlXTWU1bEUxNVVt?=
 =?utf-8?B?M0VmREt0SGlsakFVRW9vclFqUXM3TkMzTHZ5eVRkKzE1dVRqSUZERWljeFk2?=
 =?utf-8?B?RzFpT3c5Tld4SXFyNW4xTFM5U0ZvOUFQYVk1eDNSZ1VyTkR6NjZhZ25ZaGlj?=
 =?utf-8?B?NWt4dDBPNGN0S0wra01BMVc2STdIQTRNR2lia21hamFiaWxMMlBDNmFrbFNt?=
 =?utf-8?B?YVlhWHFYK051U2lURGxPUzNwdmNCczViL0pocHF4OEoxc0ZWZS9OSDRkeHhF?=
 =?utf-8?B?VVhlNW0zcEk1WlZiRHF0b1F5Wm1LTmQwWUc1UmpJbXoyVmgxRUZyeW9hRzFH?=
 =?utf-8?B?QnlLTTNOUFl4dDIrZFc1RlJsems0ZjUwREFSKzJDTDZIcnVuRC9JYjRoMVFk?=
 =?utf-8?B?dGZkdzJac1FCcXprRzJmUEJDeDU4OTdlTU1CM3NzK3ZlYWVPd2RKZC8xNjNn?=
 =?utf-8?B?bXoyelJuMXB4VDZOaEU1VURZUzQrQU5Wb0pzeDhybWJMWGI3RXdmNTZqN0s1?=
 =?utf-8?B?cjROY2JhTnBkbFZWK1hIeFV1b2duQkFPcG1oNzVJeWVLejR6ckV1Sk40Rnlz?=
 =?utf-8?B?MjZLbnZYQUxWY3h4TnhESTByZzBNbGJpWkR5czJhTEhPaDFyMXpKUTlRZjBX?=
 =?utf-8?B?cHVDQktQaE1jNktNTVQyZDEvN3YxVHhEWThnaFdJTmxoNGhVWEx4ZWNZb0Jz?=
 =?utf-8?B?dStEOGxxMWtjUzA5Slo1YzNXS25kWmY5Z3oyUm54SVhXTjY3Nlgyd0t0SlZB?=
 =?utf-8?Q?3hECWbmitj6O6aSLky?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2564ad03-dd7d-4853-32a5-08df464bed4d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:46:42.8991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZmzI34qZB+Kf3SafswnW0jH6l5hsPOayJU2tedadN8iAdJzHpSSXq46RjLOiPG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/26 10:56, Jesse Zhang wrote:
> The error path of amdgpu_vm_init() frees the root PD, which clears
> vm->root.bo, and then unreserves vm->root.bo. On navi48, with an
> allocation after reserving the root PD failing through failslab while
> opening the render node:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc000000005e: 0000 [#1] SMP KASAN NOPTI
>   KASAN: null-ptr-deref in range [0x00000000000002f0-0x00000000000002f7]
>   RIP: 0010:amdgpu_vm_init+0xa9f/0x1480 [amdgpu]
>    amdgpu_driver_open_kms+0x2b1/0xd10 [amdgpu]
>    drm_file_alloc+0x58f/0xac0 [drm]
>    drm_open_helper+0x1b3/0x4b0 [drm]
> 
> Unreserve it through root_bo, which still holds a reference. With this
> and the entity fix 4842 opens with allocations failing in turn don't
> oops anymore.
> 
> Fixes: 8473bfdcb5b1 ("drm/amdgpu: fix error handling in amdgpu_vm_init")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

That is already fixed with:

commit 26401a4999f1596a515b2e704e7066ac09306488
Author: Christian König <ckoenig.leichtzumerken@gmail.com>
Date:   Wed Oct 7 14:46:57 2026 +0200

    drm/exec: don't immediately add prelocked obj to array of locked objs
    

Regards,
Christian

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8cc5964f29c0..272eac0ef317 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2718,8 +2718,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	return 0;
>  
>  error_free_root:
> +	/* This clears vm->root.bo, root_bo keeps the BO alive */
>  	amdgpu_vm_pt_free_root(adev, vm);
> -	amdgpu_bo_unreserve(vm->root.bo);
> +	amdgpu_bo_unreserve(root_bo);
>  	amdgpu_bo_unref(&root_bo);
>  
>  error_free_delayed:

