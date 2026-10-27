Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7E606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 06:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GHcKG2mJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA5110F28E;
	Tue, 27 Oct 2026 06:21:54 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6409D10F27C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 06:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA7M9jp6r1TkUd/Sg0A8fFDBCrCudqWe6dQ7kqYgPbnU+rdM9YJhoiP+dlFLHX/JRCAHCyck3Xf5GutZ5N9+FEMsCDTuAC0yIMfTenUpfYOQ8XoVNMGtUiNQXjPLvgsCwzOSVrUM/3/4j9W7FkObUZ++HWyPKsrST9Ly35pqvEsZDVduF5mHkgpR2Dwx2R9g6DFndezqk8DZv/HyfFYE9QHls3QP6XP5RRyxGE+Pndk58vj+XO4/39gq/8i5Hc1tseNUiMVEH6v9ndZH2CwmNWv3Hem376zbLD811z9U88BHI8w+abdCli/1aeEnIelEIBo9H7n2IxXMVsjax6vmdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGoxKOqeOcdjXyGc4c13rr/XOy5PJ49+1Bw1fs0rDts=;
 b=DlpASwH9sE7glL7W0RfEgCoK3T09b+cxTjkR1DbYPrwFnLSLMA1OkeQDt8+wiX9WdudEhkSSILQRGrwA/3psTIeBGDFmp4CawQxbezcyqquPEDaYTaZMYdV8TJbFFc1ZGebpL5sT0jEoa9xiIvLNSmTIoCITBRjJusLabAwSMQc0kc1lqTJylAkLJpwDTibDfpRcpK4QAIq6CbGqYLMaqolsvIxxqaNiq7jEqfNftR9FSq5kke1pfq6mT+IYRYNzO+fWb01Mzte4oTn6squa9sm5qvOKMnfuKa2p3AzRvzq1xDmcKc1NXFSKrOqpEQcvjS7XrQ2CIbXPjZAh1TK3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGoxKOqeOcdjXyGc4c13rr/XOy5PJ49+1Bw1fs0rDts=;
 b=GHcKG2mJ0RxN+EJgDqsJaJKQgcML918nRzYK4mqeLqvLhCyvLAqNbMC2poc0A7qX02LKlWmmgJXSPanYJ43nMk6EMMPpsrJGG4gUC9vD3imxOlcnkIkks+SuNsN67duHYVYbTbyLGEORUdW3TnGetxtIWXz9ZBcXkFAOZPu9SsU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 06:21:43 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:21:43 +0000
Message-ID: <d5006221-41b2-46c3-b5be-6a5f9bec0034@amd.com>
Date: Tue, 27 Oct 2026 11:51:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
 <20261026230248.1597606-2-mukul.joshi@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261026230248.1597606-2-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: fb42b6b5-c9dc-4f20-ac7c-08df33f291b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261026121527099003|4143699003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261022075727099003|261021123027099003|10067099003|22082099003|18002099003|6133799003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info: +fswZGKKmePVAXG82hEf+s+iToiVqTgzTm9nuOzDZUdywF43wilnukeQAtYTp1pZoD9RK0LJ2+LD7y7Kf7rl+MVTQQbMHDwGdvckxTs3JwrcnWHGiYew0YNQ4lbDfVD9zIf/GQfXVoJopPjsZwewQ2tr1hYtT39QMbEejLkLtFtlWyMKodrHgq/qmMtD5kOjJxs8o+vJlHf/jFMmA/5pDpLxVNmg/1GGkikTdEuNQBjC1F5PFPzmiTkUWeziF/of+Hqdl2JhLLfP0Kent76nQvML75pKdWUvQ3DuSBelDmYmOhe2uoW/GtzqycU9gtF1oPjTNuYGw8mw8HPWYjNwa5630+E6HKtsJLlBXCl7MliY9/nwbOCgDu14lSWV/ThQpy9i24wSyCH7H8Oiguc1/t6Zu1ePumWWX7/Nl0zDZBjE2hk6NfxyvhAeCa0HGrmQE1MUN6RK/xpvTr1FM9cUi7/r19+LN/g6nFRM0gtkOYxWLCZ/4ul/4kxD0qnLy+i7Qocs3Mdxn0a8O0OvBjKjjJijSmyhhZu0SwUXWuHy1YenWlCkewN87MGvuITg/houJ3wUG6TbabNNrxK2xLDEPmRRrWvd7aivIv++hhUV8nAtR3axFJAKQ6NVeYlASErneaWybtuONKlw4STvQr/Ox7qybzyQeGFK8Vft9R8g6YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261026121527099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzZUTExCWlhuaHJjamkzZDJ4RnE1M2RMd1p1TmFNdmo4V3djMWpYdEZnZTZw?=
 =?utf-8?B?YlVEYlAxUzZ2NFJRSVoveDMwUFdPZkl6T2JaaFhFOS9oSUIyckpDS0d0Mmph?=
 =?utf-8?B?WjNIN2dvcUJIY0dycHF2NFhQeFV1RDJsWUpCSVpNYU5QYnYzbHllOUJhZU1a?=
 =?utf-8?B?MFZQYnpxTXh6ZzZSZnBrMmoxaFdNSlJkUDRuVmUyLzVsV3p3Zk5qWTFiTG90?=
 =?utf-8?B?UXJoVGVmbkNUcHAxSkVQeDdBZXhqU1NSelRZNlh1VDFHc1BvYUJuQmRJclkz?=
 =?utf-8?B?aW8rUnBGamJFbWkyUklabHdPQXpYWXZXRmQ1cStzaUI5Yk53QzEyZWwzQVZP?=
 =?utf-8?B?TG54VjdNUzk0c3VsNHhnUWRxb2tjK3l5UW03bFY0WlpQZEh6R2NzWkliaXho?=
 =?utf-8?B?bTVwUkZuMHNESUYxQ0xPZHkyYzU5Ky9TbkhvdHZWQkFNYldvTDBjdnY5OWZl?=
 =?utf-8?B?Zms1RGlob3doN3FsYjNhTFc4dzBIQTNjdko3Z25tQkphaVJjeldCcHJGb1RE?=
 =?utf-8?B?bTUyMjk1cGFXczhvT0s5WW1rV002cGVpYkVSNDN1QWpJaWE1VURNTkRQZnNl?=
 =?utf-8?B?WnhJdEpuNm1LUmZwTjhmSFJiZXc5cytobDZMK2tINXFZNUhNZmZ0WTRzTXF3?=
 =?utf-8?B?ekdTV3poQWZZQXlvalpCOTZhM2RoVWNqa0NvM1BTbkFvSTJZNGQvZVJtWEQ1?=
 =?utf-8?B?SFdTdFM5MGJ6UitWOTVZakFqMlJGNDIzZTBHVmRwbXhkZjVieDFOMitPQWVk?=
 =?utf-8?B?OUNkMDc2Q1pOcGR5VnJtUkFqcHNRVUxoWEdSb0tkcHVXdU5iL2tFMC90dG14?=
 =?utf-8?B?YkRYMEMwMU5xaENHU090Uk05UGpjRnIzQVBxL3NxM2NEMUJPVW9oMVV4c1pB?=
 =?utf-8?B?Ni9nUElZbVR6T1owTVZjVWNqamVKaU8vak9QUXRyVWhIdmg0L2IvNjlXTEZy?=
 =?utf-8?B?dW9od05aZCtJNWZabFNET0d1dlhnRTV2dHdwcTB4T1Q5TlRRYWNDUHd4V0Q5?=
 =?utf-8?B?c2w2YzkyVWJHSUNkOGF4KzYxWGRUV09LWjNzZElLR3dEdysxY2h6THV6TmV2?=
 =?utf-8?B?VUZMR3lTTGhVZUFZeDFIc205K3JLNlJYdzNJMms4UHlkSDh6dGZxVzBKOVdJ?=
 =?utf-8?B?aVFIdktGb1F2S0R5eGFHQ0g0cVRtQndqQmlBcnRYYkxobS9wVlltdUl4VFp1?=
 =?utf-8?B?UEZucUxHZ0FJU2xINXhqU1hpWlhVMWI1MWhKZXdaaXlQTGU2Rmhzd0x6bkxh?=
 =?utf-8?B?RzFwWVJZTjYrYzNBMmJTSE5SdWd5ZkVIWWk4RWFZeDhyeHM1YTlZYytxNWJx?=
 =?utf-8?B?eFp1ak9KUDY1YlFmWnl0MklxOXM1UWJnb0g5Y2gzSE1DaWRTdm85bS9QWCs5?=
 =?utf-8?B?RVpYejJYTE9kZnFFSXdBK0dsdDFJUFhzd1FlajIrRGxFMEhrU1lDaFlZK0dF?=
 =?utf-8?B?ZXRiZGdUTkNmazRPaktSRjB6ODNYYTlWbUlzTUlBd01VMXFzbWVBU0JEa3NR?=
 =?utf-8?B?OXd2RWZjMG12cC9QTmVIUmxOMWVPOU03MUhrdXdVbGUvQ01zVnpyRzBGUnZQ?=
 =?utf-8?B?K0M0MjV6SzQ4cHAzT1JkUzRFaDdpRkRQL2F0Qzh6M3g1eGw0bFlXaW1HbG04?=
 =?utf-8?B?M1J6WVB0ZlB3OXhHaUR1ZWQxMGlsMWdqdjZ6WStKU2NNOC8rL3pEbU1pT1JQ?=
 =?utf-8?B?b1lqeW5mY0ZVa3ZQNmtBeWVZSVZFVWw3VWl5RGJNKy9YeFluc3hkUmt6SWsy?=
 =?utf-8?B?TWJ2NHByZUtvN1UwK3JZY1ZaZHRQcVJGdkFkTXk0c1lNa0NES2ZGb01aT1Bh?=
 =?utf-8?B?bXBOaGxvVG5xMjV6VW51NnVDR3VTRlN2OXFBK1VRWE83WGZKYWZpa2pOdDIx?=
 =?utf-8?B?ZmFvYlFhVTJmclV3dHJ4SUU4c2NMRFJyZ3VSVWRESUdOVFIwVEZ1VnhMeDN6?=
 =?utf-8?B?OUtOQTFOb0VGV1BYK0lEMFJsUmZHakwzVXFGbkt3ZmhtNXRSTUF5Ky9Ma016?=
 =?utf-8?B?ZEpqOEZ1dHdNS0tML2RZNUpOMVhwQ05jYSs2cEowcGJ5TFQ3RlQ4MmlrUzhk?=
 =?utf-8?B?TDFkakRqTW5vbER1MFR0Z3JHajl6R2Ercm41ZWM5TmNISER3SmlYZXRDK0ZS?=
 =?utf-8?B?enlUeUdWY1ZjS2hVNVdUb2RsdTJacjN5b2lja3phUkdnZFRRMGVHdWhGdkRl?=
 =?utf-8?B?SkM5Smh0R0E5aEpod0tsV2g5MlM2bmFnSGdWSk9WZVJNd01uT1FvNndvWGhx?=
 =?utf-8?B?bCt0VVZKSkxsNGF2QktETHhZVU5sME1jZTBTOW5LdGQ4d2tlOHRkMldXOVdW?=
 =?utf-8?Q?sifWlId85+bZWQNePZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb42b6b5-c9dc-4f20-ac7c-08df33f291b8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:21:43.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k5bCzyW5YPClQzB3n+/ffZa0kbmU8aDVIbsGJm4aJMNCV7kw5VJ51lxwdQ/pLjS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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



On 27-Oct-26 4:29 AM, Mukul Joshi wrote:
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
> - Make find_peer_adev() resolve both loopback accel IDs to the calling
>    device.
> 
> - Add amdgpu_ualink_loopback_init(), which allocates the ordered
>    workqueue used to emulate exporter->importer messages, and destroy
>    it in amdgpu_ualink_object_fini().
> 
> Loopback is not enabled yet, and outside loopback both helpers return
> ppod.accel_id, so there is no functional change.
> 
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 117 +++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
>   2 files changed, 124 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 2ae14e83f6b4..288c07274254 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -88,8 +88,34 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_ualink_loopback_init - set up UALink loopback mode
> + *
> + * Called once loopback mode has been detected. Allocates the ordered
> + * workqueue used to emulate exporter->importer interrupts in SW.
> + */
> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
> +{
> +	adev->ualink.loopback.wq =
> +		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
> +	if (!adev->ualink.loopback.wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>   static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>   {
> +	/* Tear down the loopback self-interrupt workqueue allocated in
> +	 * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
> +	 * pending self-interrupt work first.
> +	 */
> +	if (adev->ualink.loopback.wq) {
> +		destroy_workqueue(adev->ualink.loopback.wq);
> +		adev->ualink.loopback.wq = NULL;
> +		adev->ualink.loopback.enabled = false;
> +	}
> +
>   	if (!adev->ualink.info)
>   		return;
>   
> @@ -479,6 +505,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
>   	psp_ual_query_station_config(&adev->psp, adev->ualink.psp_if_ver,
>   				     &adev->ualink.info->station);
>   
> +	if (adev->ualink.loopback.enabled) {
> +		r = amdgpu_ualink_loopback_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to set up UALink loopback: %d\n", r);
> +			goto error;
> +		}
> +	}
> +
>   	r = amdgpu_ualink_drm_client_create(adev);
>   	if (r) {
>   		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
> @@ -1044,10 +1078,22 @@ UALINK_IDBITS_STORE(vpod_config, vpod_active_accels, vpod.active_accel_bits,
>   		    AMDGPU_UALINK_ACCEL_MAX);
>   UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
>   
> -static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
> +static struct amdgpu_device *find_peer_adev(struct amdgpu_device *adev,
> +					    unsigned int accel_id)
>   {
>   	unsigned int i;
>   
> +	/* In loopback mode @adev is alone in its physical pod and owns both
> +	 * the exporter and importer accelerator IDs. Resolve them to @adev
> +	 * itself. This also keeps resolution scoped to the caller's pod for
> +	 * 1P4G, where every loopback GPU reuses the same accel IDs (0/1) and
> +	 * a global scan by ppod.accel_id would be ambiguous.
> +	 */
> +	if (adev->ualink.loopback.enabled &&
> +	    (accel_id == adev->ualink.loopback.exporter_accel_id ||
> +	     accel_id == adev->ualink.loopback.importer_accel_id))
> +		return adev;
> +
>   	for (i = 0; i < mgpu_info.num_gpu; i++) {
>   		struct amdgpu_device *peer_adev = mgpu_info.gpu_ins[i].adev;
>   
> @@ -1059,6 +1105,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
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
> @@ -1145,7 +1216,7 @@ static void activate_local_vpod(struct amdgpu_device *adev)
>   	for (i = 0; i < info->n_local_accels; i++) {
>   		accel_id = info->local_accels[i];
>   
> -		peer_adev = find_peer_adev(accel_id);
> +		peer_adev = find_peer_adev(adev, accel_id);

Since it's always single device, it doesn't make sense to go through 
this logic in loopback mode.

Thanks,
Lijo

>   		if (WARN_ON(!peer_adev || !peer_adev->ualink.info))
>   			/* info->local_accels is corrupted? */
>   			continue;
> @@ -3809,7 +3880,7 @@ static int amdgpu_ualink_local_import(struct amdgpu_device *adev,
>   	int fd;
>   
>   	mutex_lock(&mgpu_info.mutex);
> -	peer_adev = find_peer_adev(remote_acc_id);
> +	peer_adev = find_peer_adev(adev, remote_acc_id);
>   	mutex_unlock(&mgpu_info.mutex);
>   	if (!peer_adev) {
>   		dev_err(adev->dev,
> @@ -4488,11 +4559,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
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
> @@ -4838,7 +4904,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
>   	struct dma_fence *fence;
> @@ -4957,7 +5023,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>   static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 dst_accel_id = ualink_accel_id(adev);
> +	u32 dst_accel_id = ualink_exp_accel_id(adev);
>   	u64 timeout = msecs_to_jiffies(2000);
>   	struct amdgpu_bo *bos[2];
>   	u32 n_bos;
> @@ -5242,7 +5308,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
>   
> -	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
> +	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>   	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>   				      &remote->rptr_cpu_addr);
>   	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
> @@ -5289,7 +5355,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   	}
>   
>   	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
> -		ualink_accel_id(adev), ualink_addr_mode(adev), status);
> +		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>   
>   	/* Alloc metadata structure for all GPUs */
>   	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
> @@ -5362,12 +5428,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
> @@ -5393,7 +5459,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   						     ualink_tlb_wptr_offset(adev, accel_id);
>   
>   		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
> -			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
> +			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>   			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
> @@ -5804,7 +5870,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
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
>   	u64 wb, npa;
>   	u32 offset = 0;
> @@ -5978,19 +6051,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
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
> @@ -6161,7 +6234,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *interrupt;
>   	struct amdgpu_ualink_ring *shootdown;
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	u32 src_accel_id = ualink_exp_accel_id(adev);
>   	u32 dst_accel_id;
>   	u64 npa, flags;
>   	int r = 0;
> @@ -6284,7 +6357,7 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>   {
>   	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>   	struct amdgpu_ualink_remote *remote = to_remote(adev);
> -	u32 src_accel_id = ualink_accel_id(adev);
> +	u32 src_accel_id = ualink_exp_accel_id(adev);
>   	u32 dst_accel_id;
>   	struct amdgpu_ualink_peer *peer;
>   	struct amdgpu_ualink_ring *ring;
> @@ -6371,7 +6444,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
>    */
>   void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>   {
> -	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
> +	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
>   		ualink_addr_mode(adev));
>   
>   	adev->ualink.msg_ctl->send_halt(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> index 3e4f2d18c83c..cbff60193383 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
> @@ -93,6 +93,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
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
> @@ -321,6 +332,21 @@ struct amdgpu_ualink_msg_ctl {
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
> @@ -335,6 +361,9 @@ struct amdgpu_ualink_mgr {
>   	/* For remote interrupt and shootdown */
>   	struct amdgpu_ualink_remote *remote;
>   
> +	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
> +	struct amdgpu_ualink_loopback loopback;
> +
>   	/* handle irq from ualink client of remote GPUs */
>   	struct amdgpu_irq_src irq;
>   

