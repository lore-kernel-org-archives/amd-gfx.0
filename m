Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E497606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5qyDgijI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F066E10E06C;
	Wed, 21 Oct 2026 20:15:21 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE0210E06C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 20:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLLTzaFSOGSTh2zp56Y24z7n6WpYf6wmAs3/hdZIq4OeA4Ph4AQLUKu7pn8rkFQOJaB0qcuN7WkzSH5ehEkR3/B8qTHpuccWXuKeevRbiOezzb6eUbuEgMIYixtKbSk2YVyvE1SRLtrM+jKhxFkjXrqapgKCBXgddnWqqvZskaDriFIVCp7cASErUl+5euBb6aE9QMXJi8NgDzc9za6lpO4WHJSgsOwPUYA/ugRExBb+bWa4JKH0EsLnBkpU8bPe0h1X9uDsrt/Kw9DJsULwu/wHjtGr6ObnFhPe66hWeNE5gq8rWfj/7NIk1b60g0rL4LF5+Yndg7goelsvGvqsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBF+CINE5q130r1sqRqI5KdSHxjlkroHip25LGp58N8=;
 b=R7Zx6DjTUewkD2bDcRaE2pxHw5qhOQXBnz46j6N2v/k6bbPGZK0f0BOjnC7xea8lvz7CWwQBGA0UsqsY3/KnONe6MvQgJlLo1AZ+8XxpyOmmWx8QSHxVhRFPTOgd8T3cEGCF9ygiEsPVGIAH1WfZIbWpse2fRiXs7Sw3K4E2HCbfJD2csiXQ1hUQl1Hbjurthzhw4JxH52yJYpz4ud+pjoUnjqf9Wj8bTHd5Z3OyFqk9oBqJh2zhNdqHkM25SdEe7msi4gH7hxpKeJoj3gq7BwYAOdpZ+ZKCGf+lka3rz5IQj6FOHKMvyEookhXtUyQPaTqa/wJPP6NAX68xkmz3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBF+CINE5q130r1sqRqI5KdSHxjlkroHip25LGp58N8=;
 b=5qyDgijIpsTVBeAY8CTLjIKMNLM/jfy4YOInBfhF6CtMXRMeq0BJ6HAzpzgncKDGdDDs080nNAshGBzbUKq3gE7MgLxIhD42A1ysOgSQivh/6m/8sR8GRTXgcYjTkQCFApDJ2HVyYF0StFm9zNcxMRNXG5yHIQ8/dqXlF4m4LPA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS5PR12MB741834.namprd12.prod.outlook.com
 (2603:10b6:8:47c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 20:15:13 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 20:15:13 +0000
Message-ID: <6d80b4d9-94b9-4992-b596-f930f56adcd3@amd.com>
Date: Wed, 21 Oct 2026 16:15:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: only tear down an active UALink accelerator
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com
References: <20261021195747.1119608-1-mukul.joshi@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261021195747.1119608-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::21) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS5PR12MB741834:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f5bae7-59c1-489e-397d-08df2fb00377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|18002099003|22082099003|261021121427099003|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: pQAIBlHI32cnomhyA4HGt+uJN1hXkHveBeLk5asJPQqTxQF7et8wVP903eDPpS9gw37MP+BjfKNUq1IxkuQIJRpKF7c7tGr2Gm6Rh42XAGTNIcUrlpZWoEXudPR8DycaxbfQk9RDvU/7MJW/w9LhyuTJy2TN3UvqihR52avg6bZHdhIGDOUHeWYzLNo8UPwFSA0Oj/K0ym5Csl7mlmDZxs7l8k/iOlwOCVOQ9yjcDKtzGwZ6P0bjL0lLjzqHHS1k8MPgIv0qFua6qwSiglpeTIIGYQbOeRuE7NhKoSlZ3vU+ikcP6+Bj3xLGke6EGAJg3auvuB7EOnSObx4BeYy3qJiZTuChafTgBjLJx4sBzoSU4sVNMmNWj2HRe53wF1uU4Mf36O9w5wZFDFkuJLi+rXX1gC9ddyRlLQlZtZCogGiCcnzK+610ddClvCqlyylrb2Vw7PXe0TUIK9hyB9e5rbgpc4hvF8gMTLK95ApOpbsKFY6pGCU49VXjuawSxvF3MfNDFSt7gW2t2Hu9z0cdCtv+3yDhyHrx0pj/pMhoyuoukIzWVnq4+6StiM6wDFSTRDWHmJKmrdFPDL9GLZp+3aw8cnMQBNl9rhBuszs+VHldsw95vKKTIpRX/CX7cAp5lDvvwvWWgG7omBXuvInhTb4fFIS2tQ85EaUN96hsVb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(261021121427099003)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJLSjh6RS8wekJndHZSeHpVYkhocXRMMzlCcFkrZVJnL3NVNTY4Q0ZTNmt3?=
 =?utf-8?B?TW5IVEpLNzFMUGk2eVJJb0Z4OHBJRXpnS2dXN2R1YmtPVXFFajducE1XcDBX?=
 =?utf-8?B?ZGhxME1kVmNtRXlCYmVNS0xzODBBdHREbnlBc1g3T2FONU9nT29aUGpkeDVv?=
 =?utf-8?B?WVJDZ1hTYlFXeFRxR2lNT1NqK0ZhcjhjalVHYWJZYklDNko0Z1hlUVhsU3F3?=
 =?utf-8?B?cXh0dUwvS1NHTlVabWJqQ3d0c1RzdU9XeXE2ckE0eWs1YjBRWlhnNk10MjlJ?=
 =?utf-8?B?bWRxbXFkWVFvRjFNRS95ZHdWN1hXVDcvQ3g1em1MWDR6TjNYMHROZWhmcWo2?=
 =?utf-8?B?SkxOUU1HSE1HQnRsV3d0R3FoNHpYK0hVUGx4N251dTdrUEliamJyZS9JYW5p?=
 =?utf-8?B?b2FXdzlub0tvK0tZV254RTdHYW1CQTZjbEdKWU9IVUVkZDY1LzNhREpBcnky?=
 =?utf-8?B?UXpFbVBOSUl3T3pYcFFlSjRZeCtDOW9qSVB1eGkyTDBIa3R1Rk4xOVJCRUpC?=
 =?utf-8?B?V2lFUTNCTEpQc3FkRC9rdVA2bENLVG9zVTVyeXZvbDlKY0x3SGdRajUzQUJm?=
 =?utf-8?B?Wlpxc21VK2VVTDluZXlKa3BEcU02KzE1TE8yTzJzYVR4UHJ4VzNHTFRqZ2Vv?=
 =?utf-8?B?VWNzYzl0L3NXbDI0ZEhFWUM2dUxZYVpaY1pVWG9HQTZtTGR2ZDdBWE14dlZq?=
 =?utf-8?B?YituOFVrNlBGWGlPa09XV1pySHVOOFNxeUZEK2V4K2hlSklraGhOeThaWndT?=
 =?utf-8?B?MzJ0VFV5a2lZYS94Y3JUTm0yUFFBYWN1aHNjZmdyd3J0Zm8vRWZza1lWVGMy?=
 =?utf-8?B?eXBtRVRqbjdtTHdSYXByMzRwc0E1U28vL0ZKMFJaTEl1WDlGamZrekROMm1i?=
 =?utf-8?B?Rmx3cnFKT216eGZXbGhaN2lrUmpRWElpU0FrUHZ0aGVHOTlPTUo3VEVFTDR6?=
 =?utf-8?B?ZndZeEdHMHNieHVpT2tGby8zNkd4T0M1RktUT0J1QUFlbXJMbDdIaTdoYTFl?=
 =?utf-8?B?akM2NVQ0UElFL1dnN1lud0d2SUFZRTFIWlNlKzRRNHNGVldJekEvL1ZTUzdT?=
 =?utf-8?B?SERjdGYyc2Q1dGxKSU9iYnQvZmoxMFhrOVkyY3JQcDl4elI4WVZ6Ry9nUVZR?=
 =?utf-8?B?NlhDUzExemo2SCtvU3ZyQ3NFYzhjckxjUjNzSXNaVTErTHRJbjJkUWVBM2cy?=
 =?utf-8?B?OFJsQ3hWb2ZrcHNLLzZzYnFhd1ozenYvWkIxWWk4Y0lscFMwZ3RHZU50UGtC?=
 =?utf-8?B?b2kxMDNaNm8yVUl6M1ZZT0ZWUklYTm05QlJsZzI2OE9XV0dRSWo3YmxUMmww?=
 =?utf-8?B?cTNUTkxXeWlSdGdYak9HRXJFNVdlNDZPbzhQbFZraEgvSU4ySUgwZ3NNMS9x?=
 =?utf-8?B?NHhMYTBYQUFJN0QxMDdwNlJqY1RaazlkVk5UdkFVUDZqZkd6RXJYK2lCb3BF?=
 =?utf-8?B?a1VoYXRyZjZwdDM5NDB3dFRMUnVIYlpINmQ3Vi9USXVsVlY1elZqd1lOMis2?=
 =?utf-8?B?S0UzOFpSQ1JEdXF2alNPNTZoZEJhelU2VlJtaVRzb21xWDdJald1VithdHRX?=
 =?utf-8?B?UDN4blJMenhpdXVzWWZ0ZjJFRVQ1dmdJZ0NGaXBWQ1l5OWNYcGtIOU5zZ0JD?=
 =?utf-8?B?TEdQR2cxSWxBZ0RNWUVmOWsweFdYQnh3RXp6a1hxdy9HRUY0Z1NOdXhCUm5n?=
 =?utf-8?B?NGlpUjJBMHV6MDVLMEtNcWZVNkJXS3l0c2NoNU9zZzV0Q0lPdit0aWx6Sk9w?=
 =?utf-8?B?aUxSamV2QmdBVnlLR085dHhLSTVLUHJsdjlzWW94bzhRUDQ2VXE5K2VDZkIz?=
 =?utf-8?B?ZXJ1d29zSFh1VGg1NFdKUXZoNk1XUU04WmF6MGNjN29tZXFsa0FzQUIvVURw?=
 =?utf-8?B?ckpmVmpKTUxyNGw4dUIwRXFOZm1PUkQ0UTA4TFZCOU52L1RrNnlkcGxCSzUw?=
 =?utf-8?B?dVBIcXkzWmxLVjZTTHBQUHlCS1hMUUJSRU1HR09ERExkYWpWd2VyeXhCeHJX?=
 =?utf-8?B?eEI4d1VKUXlnZWsyS25hWW4yTjZMQzZVNDNWcG9YakdVN0JkY0VSbENzTW9M?=
 =?utf-8?B?bmV2UklUVXRsQXZUM1BQNUlXdktQdHZtWmVWWFAxTW1MYU42a2pId2pKMHZ6?=
 =?utf-8?B?M1ZPcm1vTVZXK25OVkRpWTZJR1A4S1lOWWxIMW1Tb1FoK1h4RXhGZkZEK1E2?=
 =?utf-8?B?eSttaFpsNkJBbnZwRDhoSHhUKzRvcmpWY21ZYVpiZ1R2aE15eDJSSkxJMnVh?=
 =?utf-8?B?V1l4R0g3SHlsQ1JVNWZqbU5JWEpWQnNheTBrK25kZTk5YkVtcmhxR1haOEpM?=
 =?utf-8?B?c24rT3NuZjRQNWdORHJFdzZpWmdBdjN5eFZMTFhpN1BsVjdRUUszdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f5bae7-59c1-489e-397d-08df2fb00377
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:15:13.0083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crYG3TWYklwZFCylHdBC0eaumIxWtj70y8Ztd0ibuPSlXP1T145TGCyPgrwIRpp7llU1pFWzW608xZ2uZmZVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB741834
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21 15:57, Mukul Joshi wrote:
> AMDGPU_UALINK_ACCEL_STATE_ERROR is ordered after ACTIVE, so the
> "state < ACTIVE" check in deactivate_accelerator() lets an accelerator
> in the error state through to the full teardown. The NPA VM and
> workqueue are only created when the accelerator is activated, and an
> accelerator in the error state either never got there (invalid pPod or
> vPod configuration) or was already deactivated on the config update
> error path.
>
> Tearing it down again calls destroy_workqueue() on a NULL or freed
> npa_wq and amdgpu_vm_fini() on an uninitialized or freed NPA VM. This
> is reachable from driver unload (hw_fini), a later failing config
> update, removal from the vPod and a pPod setup commit.
>
> Only deactivate an accelerator that is actually active.
>
> Fixes: ccd7fa696b74 ("drm/amdgpu: Assign accel state based on ASP config")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

This patch looks good to me. I see other places in the code that compare 
peer_info->accel_state < ...  Could they be exposed to similar issues 
when accelerators are in an error state? Maybe it would be safer to 
change the definition such that ACCEL_STATE_ERROR is less than any other 
state.

Either way, this patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8d81efb28774..6ba745f37540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -1345,7 +1345,7 @@ static void activate_accelerator(struct amdgpu_device *adev)
>   
>   static void deactivate_accelerator(struct amdgpu_device *adev)
>   {
> -	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
> +	if (adev->ualink.info->accel_state != AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
>   		return;
>   
>   	dev_info(adev->dev,
