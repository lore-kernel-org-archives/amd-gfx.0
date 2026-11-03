Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF3606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FpDgmddC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 526AF10E00F;
	Tue,  3 Nov 2026 23:19:40 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D9F10E00F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abXHhqRpgZFRlIOMefT+iiEsPX9mCOx/29m3980oRILSlXTb7DhGvQ/ezEESq3qHzK1a7v2d3ALciaqQqxxMCu/8Xdv2Mnh/lxKDkOUMQdmvLPpyaXtDzsUrO/shfmSVG1WYkkV267xEC+/Yjzj22zVeyFII+pkEcBbrGKYam3XXEkWa300EaOZaPcOfJKWG7wBaMSIPP/n9IHBsl6WHF+ipS+vqja0fs49HKwlnFbhMKjWAAxNpaaQ3ulFKFYCg/Ix1HinCHywyMb76hpfNvjW1VZlUFI+q5q776lgpX6ij+s/JzvngieEWHqT9y9QeP/pGG6OkbImWABE/xq6WZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTkJeblMSiFNcLzWv3+YY5cfEXcUEwtr6oahUEpKXsE=;
 b=YR++jkpnY5kEfJeqQxnIpdktyaHM5H41tQZfc+bUjRain8N4yHAZwiWvTGi+lPSxvu8mNc3yrxbSVwKkxTUSy/tn8dCh/yl0NRl4KZJh6pY+SkZxvYNWmzSXULjB1M0i21hZAxVeKT5bt1/0DJ6hFQJylR44x3ZKajHK2MBQHJw5IWnXPFO1ckyNgBXOMhhfWQ2hTRzMRBHYDyLx0H6e2OrY+YOCOsZ0cR4WK5sH9sAlFhB9sYkjia1vYVH7NNoF247UfUIhnEwuoDNQFPfspNbcWxb1zENcQWz2xLB8733AyJUdA05Lgy+P1yYG/c+sASYY5kKSRxaZhWF5UO02sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTkJeblMSiFNcLzWv3+YY5cfEXcUEwtr6oahUEpKXsE=;
 b=FpDgmddCLTRcmNUvieITzv8soThDGNuRe05r629seOjQT9aixP2jLltDBNpNHTKya6k6gHBq2Honm446QlijJlcNyD+UjiCE3eTW5v4BoQNTUT7T+zw/YFK6td4kARXjSvUuS+BNMOSxiMxD5i90jyWsgbVOtN2oQMSWQj6k1/4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by LY0PR12MB943461.namprd12.prod.outlook.com
 (2603:10b6:404:231::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 23:18:52 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:18:52 +0000
Message-ID: <bef51ab8-e636-47ad-a006-82e3cf6e1160@amd.com>
Date: Tue, 3 Nov 2026 18:18:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-2-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102160125.2743750-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|LY0PR12MB943461:EE_
X-MS-Office365-Filtering-Correlation-Id: 6562b644-4130-4537-49b3-08df3a00d2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|22082099003|10067099003|18002099003|3023799007|261102123227099003|261009223027099003|261021123027099003|5023799004|4143699003|261022075727099003|261021121427099003|261026121527099003|11063799006|261028144727099003|56012099006|261022105027099003|261102130727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 1/MK2ezyuRAQxh/bSHu6cOAonbFN/yraj36mSoWhnPSUB+7H5pCSozE0mKe8ZRLL02/RnKURkJMFj/Y/8DJVe/LNi1MmPnavwEmQPK6oXrinveWThFGTOKgABTyuP4VgCZTEYh4XVJZ/h6MSHPrXf30V0CDS4myHgKslditloxMAuyGsKnXn+/oAoEMqqoA2iYVQQbp1prUy5Tmu0k02S4dzeWxGU0tboKJPuD86hQ2TuWVCNKrdzXGaHN1pGIScsZN8JNYEGCVD9bHiuwMfQLIdjTd3cZjFVBv0gW7+L08hWXgvOwS/RcuLZoM+oqL/hOhNbQRDbFCX25x3Ju3lLwI8x9HI2by3e566AhBp/9SCNb3vsrd86xLFIQoafvD0ENLB19wre16G0KTOY4i+IGp71A+5Bwven+CAM8UFu65jK0eSdGVEDcZ2soSND1q2yWQZntJHIJEPmwMgXW7nHneY7BVAqs1HixRzADaRFigP3G8N1ZzQhQp8Jum0xeFoSWo6atJmNqKQvjiPYJu/CBxpErsNCrkxKYIzExVKkuGkXaelXacOFc2iVUFayqVI1L1cpc4mPn7f1RTWJPeUeNcv+V5Pv1d4e3Zi+YMv6cwr2l1WSTQSqLAtNMiMmdzTY3DNjkTbHN2yQB5nQRBd62L6sirATAR77Lo8dRgjko4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(3023799007)(261102123227099003)(261009223027099003)(261021123027099003)(5023799004)(4143699003)(261022075727099003)(261021121427099003)(261026121527099003)(11063799006)(261028144727099003)(56012099006)(261022105027099003)(261102130727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZhQld3bDk1cllyVEpzdE9ZNW9jdUJiRDlBbVBSRjhBWTBLVWJjZHlzWVVa?=
 =?utf-8?B?N29CcjY5SVhvT3hqRGZVcm5GV3JIMjhGeWZQVUZWeG5KUHltaTJEZW9GbVdD?=
 =?utf-8?B?UzJWaU5EQnFwb0dZVkFZYnpUU3ZoNTA3RmxnMG1kM3IyWlVWZXlKRGFqdWZq?=
 =?utf-8?B?MElMWno2NHFVQlo2dllscWVQK1VRdFl5bW5ucXVibGMrbC9ZeW5wMld2ZERI?=
 =?utf-8?B?aVdDbUJXN0dsRE0yL042cHliV1VNRkxhNWcrM0FpNklDcmdOQ2NadnFjVCtm?=
 =?utf-8?B?Y25TN2ZKeC9QV01zK2ExQmtTKzFEdXArM2d2M2phd09leWh1NGFlOHMwQkFX?=
 =?utf-8?B?elJoK2RxeXVVZWdSNUZ3cEVmUnRlTEpNdGlRY1hUZFBmSHBBOWt0NitsTnRU?=
 =?utf-8?B?aHRLeERXS3BMVmZGZ2JTNnFiNTg3Rmg1SUtYRitRZG9IaXFWMmNHSjJaekE5?=
 =?utf-8?B?b2FWMXY3M0E4c1d1VU1LTkdhZnp3amVoeGs0UXFGZUYwSGROdGVMVHRVMS9Y?=
 =?utf-8?B?VHlYYWxtc1NlUEdqZ00vQWJLVnEvU0pzN3JETkxHWHEwQTZxNDN2MUQyaXRI?=
 =?utf-8?B?NlRsN2RUNUpENTE5ajExcGM0UDI1RkF2bUhUK25jWEtCa29uUkFpVW9LUE55?=
 =?utf-8?B?ZTF4V2YzWmRxL0FyK0owMDVDc0EzOWYzVSszUjNKRkFwWU1EWFo4WERKejJq?=
 =?utf-8?B?c3JUSnYvWEZWcVgyRVlIVzF3N0hzbnZYRGI3T1NEZVJLZUFQQlk0eHpBLzV5?=
 =?utf-8?B?RGRFSXhqbmFhbkVtWHU0dWprR3dhK0JRZVZJQmVGWEpQUmdXUVdHU2kwb3ZE?=
 =?utf-8?B?QXZRdmxZNnVpdWlmYTdSNUFSdWpOU0pzdktjVXRKREQ0YlNtY0FQZ2Uxb1pY?=
 =?utf-8?B?b2pzZ2xWMm9ncU4rcHJNc0l0ZkJBeXdpanF6OWdWL2E4TkJjL09KblZKOUtP?=
 =?utf-8?B?bUlwSFh3cmhiRDArNUhIMHNRb3JjaUo3aUdWcGsxNzgrcnp5U0p0SmFMUito?=
 =?utf-8?B?WERoVDNUeXZxY0cxclh5SUhXbVhJVFRPcGJ5bFpkQVJvYjhrSWVJdmNRRWZs?=
 =?utf-8?B?MzBUWHVTdm9BeW1NRlg1dDVnRjVaVjBYRkRwNG5nK3FMb0c4cUcwQ2s3dmJR?=
 =?utf-8?B?UzBDUi9Gbm9JTmhWaFJlZ21SME1qVDlYZGNEWmdHTzNpNlFQRlpUUURvSUpq?=
 =?utf-8?B?eEgxOGwzdTNhOUEwWlA2ckNXRkJUcFZHdmRTTEhEYncralIvOFRDY21uUlhF?=
 =?utf-8?B?NU1HRERyOXMrNnZEYllqd0dlMlM4ZjZrc1FSSkxJdENtZlozaTVMVkJPTlZR?=
 =?utf-8?B?ZlAxU3BzRTlFaGphTUZuQzhneHhoOFNhOTArQXdtLzFGd2dEdGRsTVZKWmJI?=
 =?utf-8?B?RWdSWkk1NDNwWE5leDEwMnVSN1pzMkduSnVFSVE1TFFaenhxc0tBSkttdFpv?=
 =?utf-8?B?K3BLSG1ZMUJWekpMMW5iOTgyUHVKRU5Qb0Z1WHlUak1pUWQxbGxwRFBsS010?=
 =?utf-8?B?WC9VWUJ5akxxVjlDOERZOXR0OERHc0dnZ2NDVDRQcDZsMDVHemR0ZG1ZMVNz?=
 =?utf-8?B?R3VXZktkUzAxVE9mcEVWTmdsWGVTdWh6cXdKa2p6ZEQ5bzZDOTQwMTZSLzl3?=
 =?utf-8?B?aGx5dVpPeGJDdkVwNGYxZTJDT3VLMFkyUjBMcjhrL3VtRWtXSjZaY3BCdXl4?=
 =?utf-8?B?djRMdlAzYVE1T3BOSldHa2Q0c2xsWGdPQzlRME5TOXU0bTRqNzJnL205V1l3?=
 =?utf-8?B?TkI4bzJKZjRXemp1Vk0xUlR2dms2Y1FhNGFrTUpLcXlWOERHYThhOHdVZFpH?=
 =?utf-8?B?V0R2S0RKUkpGd0E0amNyenU2UGlCcENMVmc1TGxHTkxGV2tIbC9kSmNpRWFn?=
 =?utf-8?B?VXpXbzNQY1VDdW5DaUwrYXdYV1ZZMWdwcDJmYkpTYk8xRW0rQWNrc0tMU1NR?=
 =?utf-8?B?em1rOXcyVUZtZXFPVTBnWXlPUFBzV2dWcmc5UDdabCtjWFFaRnFycmtoSDJ1?=
 =?utf-8?B?WHNtVHV5RUlNQTByZFdrdEJhLzhWckZVNyt3TkQ5T1h6cEVoZ0QzZmMydmxM?=
 =?utf-8?B?dmEvS3oxY3JsN2tnN1dWSzVnSjBmQzZGRXZ2MkczNGYxdk42eEtweVpmQ0E2?=
 =?utf-8?B?ZDZzaFB6U1pUbktkQ2UvbXUrdXhHRGlXMTlIYjZ5SlYzeGlUdHdHSkc5bTVu?=
 =?utf-8?B?cWNhUGhmamZnakFsRWxtT1dMVExLRlVnaE1NRE03R3B2L245TVdZUmVJU2pC?=
 =?utf-8?B?MC9HZkRwQ25uNmpBd01abmpJajBBRUduMjFNbURqSEYvR3kvNkZTZThxR29l?=
 =?utf-8?B?UmNzOFMvZml6YWZtcmx5MmNEM01vWCtiKzI4blBLQVlHM3RCTHMxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6562b644-4130-4537-49b3-08df3a00d2ca
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:18:52.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKTGs7Z4g2gZ5j9VDyFlCEL+bq13a0gzTUeaF0U91grmdrvXOM1+/2ew+RyVTIbg/IT7auXhVSOleAlne/LDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB943461
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

On 2026-11-02 10:47, Mukul Joshi wrote:
> Add the infrastructure for UALink loopback mode, where a single GPU
> plays both the exporter and the importer role under two fixed
> accelerator IDs:
>
> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>    with the fixed exporter and importer accel IDs.
>
> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>    ualink_imp_accel_id(), which return the exporter and importer accel
>    ID in loopback mode.
>
> - Add amdgpu_ualink_loopback_sw_init(), which allocates the ordered
>    workqueue used to emulate exporter->importer messages from
>    ualink_ip_sw_init(), and amdgpu_ualink_loopback_fini(), which
>    destroys it from ualink_ip_sw_fini().
>
> Loopback is not enabled yet, and outside loopback both helpers return
> ppod.accel_id, so there is no functional change.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v1->v2:
> - Drop the change in find_peer_adev() as its not needed.
>
> v2->v3:
> - Update src_accel_id to the correct value in amdgpu_ualink_peer_remote_init()
>    and amdgpu_ualink_peer_remote_fini().
> - Add the loopback teardown in amdgpu_ualink_loopback_fini() and call it
>    through ualink_ip_sw_fini().
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 +++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
>   2 files changed, 133 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index ca6432610f71..a98d5bbf0622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -89,6 +89,41 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
> + *
> + * Allocates the ordered workqueue used to emulate exporter->importer
> + * interrupts in SW. Does nothing unless loopback mode is enabled.
> + */
> +static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
> +{
> +	if (!adev->ualink.loopback.enabled)
> +		return 0;
> +
> +	adev->ualink.loopback.wq =
> +		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
> +	if (!adev->ualink.loopback.wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/*
> + * amdgpu_ualink_loopback_fini - tear down UALink loopback mode
> + *
> + * Destroys the workqueue allocated in amdgpu_ualink_loopback_sw_init().
> + * destroy_workqueue() drains any pending self-interrupt work first.
> + */
> +static void amdgpu_ualink_loopback_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->ualink.loopback.wq)
> +		return;
> +
> +	destroy_workqueue(adev->ualink.loopback.wq);
> +	adev->ualink.loopback.wq = NULL;
> +	adev->ualink.loopback.enabled = false;
> +}
> +
>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>   {
>   	if (!adev->ualink.info)
> @@ -1028,6 +1063,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
>   	return NULL;
>   }
>   
> +/*
> + * Physical accelerator roles.
> + *
> + * Outside loopback a GPU owns a single accelerator, so both helpers return its
> + * ppod.accel_id and the exporter/importer distinction collapses. In loopback
> + * the one physical GPU plays both roles: the exporter owns the MP nHT and
> + * receives all HW traffic, while the importer is the (virtual) HW sender for
> + * the importer -> exporter path.
> + */
> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
> +{
> +	if (adev->ualink.loopback.enabled)
> +		return adev->ualink.loopback.exporter_accel_id;
> +
> +	return adev->ualink.info->ppod.accel_id;
> +}
> +
> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
> +{
> +	if (adev->ualink.loopback.enabled)
> +		return adev->ualink.loopback.importer_accel_id;
> +
> +	return adev->ualink.info->ppod.accel_id;
> +}
> +
>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>   					 u32 accel_id)
>   {
> @@ -1533,19 +1593,21 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_ualink_ppod_setup *ppod_setup;
>   	struct amdgpu_device *adev = ip_block->adev;
>   	struct amdgpu_ualink_info *info;
> +	int r;
>   
>   	info = kzalloc(sizeof(*info), GFP_KERNEL);
>   	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
>   	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
>   	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
>   	if (!info || !ppod_setup || !vpod_config || !stations) {
> -		kfree(info);
> -		kfree(ppod_setup);
> -		kfree(vpod_config);
> -		kfree(stations);
> -		return -ENOMEM;
> +		r = -ENOMEM;
> +		goto err_free;
>   	}
>   
> +	r = amdgpu_ualink_loopback_sw_init(adev);
> +	if (r)
> +		goto err_free;
> +
>   	info->ppod.accel_id = 0xffffffff;
>   	info->ppod.bandwidth = 0xffffffff;
>   	info->ppod.latency = 0xffffffff;
> @@ -1568,10 +1630,18 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->ualink.stations = stations;
>   
>   	return 0;
> +
> +err_free:
> +	kfree(info);
> +	kfree(ppod_setup);
> +	kfree(vpod_config);
> +	kfree(stations);
> +	return r;
>   }
>   
>   int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
>   {
> +	amdgpu_ualink_loopback_fini(ip_block->adev);
>   	amdgpu_ualink_object_fini(ip_block->adev);
>   	return 0;
>   }
> @@ -4487,11 +4557,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>   			     AMDGPU_UALINK_ACCEL_MAX);
>   }
>   
> -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
> -{
> -	return adev->ualink.info->ppod.accel_id;
> -}
> -
>   static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
>   {
>   	return adev->ualink.info->vpod.addr_mode;
> @@ -4837,7 +4902,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
>   	struct dma_fence *fence;
> @@ -4956,7 +5021,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
> @@ -5241,7 +5306,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   
> -	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
> +	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>   	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>   				      &remote->rptr_cpu_addr);
>   	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
> @@ -5288,7 +5353,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
> -		ualink_accel_id(adev), ualink_addr_mode(adev), status);
> +		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>   
>   	/* Alloc metadata structure for all GPUs */
>   	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
> @@ -5361,12 +5426,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
> -		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
> +		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>   
>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>   
> -		if (accel_id == ualink_accel_id(adev))
> +		if (accel_id == ualink_exp_accel_id(adev))
>   			continue;
>   
>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
> @@ -5392,7 +5457,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   						     ualink_tlb_wptr_offset(adev, accel_id);
>   
>   		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
> -			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
> +			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>   			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
> @@ -5806,7 +5871,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
>   				      u64 *wb_npa, u32 type)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 accel_id = ualink_accel_id(adev);
> +	/* The GPUID encoded in the write-back NPA address is the routing target
> +	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
> +	 * physically-owned accel_id: outside loopback that is our own accel_id,
> +	 * and in loopback it is the exporter (the only id the single GPU owns
> +	 * and can receive on). The importer is only a logical source id for the
> +	 * forward path and must never appear as an NPA GPUID.
> +	 */
> +	u32 accel_id = ualink_exp_accel_id(adev);
>   	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>   	uintptr_t wb;
>   	u64 npa;
> @@ -5981,19 +6053,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   						   &peer->shootdown, &tlb_wptr);
>   	if (r) {
>   		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
> -			ualink_accel_id(adev), remote_accel_id, r);
> +			ualink_exp_accel_id(adev), remote_accel_id, r);
>   		return r;
>   	}
>   
>   	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
>   		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
> -			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
> +			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
>   		return 0;
>   	}
>   
>   	dev_dbg(adev->dev,
>   		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
> -		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
> +		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
>   		remote_accel_id, int_wptr, tlb_wptr);
>   
>   	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
> @@ -6164,7 +6236,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *interrupt;
>   	struct amdgpu_ualink_ring *shootdown;
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	/* This sets up the send rings (local sender -> each remote dst). In
> +	 * loopback the HW-served direction is importer -> exporter, so the
> +	 * local sender is the importer; the skip below then skips the importer
> +	 * and sets up the peer[exporter] ring that the HW path needs.
> +	 */
> +	u32 src_accel_id = ualink_imp_accel_id(adev);
>   	u32 dst_accel_id;
>   	u64 npa, flags;
>   	int r = 0;
> @@ -6287,7 +6364,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>   {
>   	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	/* Mirror peer_remote_init: in loopback the local sender is the
> +	 * importer, so unmap the peer[exporter] send ring that was set up.
> +	 */
> +	u32 src_accel_id = ualink_imp_accel_id(adev);
>   	u32 dst_accel_id;
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
> @@ -6374,7 +6454,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>   {
> -	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
> +	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
>   		ualink_addr_mode(adev));
>   
>   	adev->ualink.msg_ctl->send_halt(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 85c9a9634a4b..0b1e8dd38666 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>   #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
>   #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
>   
> +/* UALink loopback support.
> + *
> + * In loopback mode a single GPU loops UALink requests back to itself for
> + * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
> + * as the exporter on one and the importer on the other. Loopback is enabled
> + * with the amdgpu.ualink_loopback module parameter.
> + */
> +/* Fixed accelerator IDs used by a loopback GPU. */
> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
> +
>   enum amdgpu_ualink_conn_state {
>   	AMDGPU_UALINK_CONN_NOT_READY			= 0,
>   	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>   	int (*send_halt)(struct amdgpu_device *adev);
>   };
>   
> +/* UALink loopback mode state.
> + *
> + * When @enabled is true this single GPU acts as both exporter
> + * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
> + * physical GPU, so exporter->importer messages cannot be delivered by the
> + * (single) MP nHT and are instead emulated in SW by feeding them back into
> + * our own IRQ handler via @wq.
> + */
> +struct amdgpu_ualink_loopback {
> +	bool enabled;
> +	u32 exporter_accel_id;
> +	u32 importer_accel_id;
> +	struct workqueue_struct *wq;
> +};
> +
>   struct amdgpu_ualink_mgr {
>   	u64 npa_size;
>   	u32 psp_if_ver;
> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>   	/* For remote interrupt and shootdown */
>   	struct amdgpu_ualink_remote *remote;
>   
> +	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
> +	struct amdgpu_ualink_loopback loopback;
> +
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   
