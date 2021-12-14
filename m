Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAB1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 08:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1482D10EA41;
	Tue, 14 Dec 2021 08:41:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC82910EA36
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 08:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bobx5You8qnWaG3N9R7gDUSCyt+C+fkuMexnI+SMRo8mOi0WQA2zbS6ko09dzY9g3iKwEMSs7F/98GXnZqiywCJVU+ZOLA9Vzhbo2aFhAe3El7H0FgR9qK7LItI6He/lGY5lbQWArMcSiQew4oXrSM4IsIo0k74VaUaUYXY8kEHwQ5SqQTkgFAWx47dJKaSMtaMN0a3QkY76lpgskvz3r/uMWJ3ZKm3e6pJn4oftLMof07XqYvHG9Sq2MxMmV1x9XSaOJzI3xMt9ron8LOq6LtcnJgqQuh12IGRnurIsg6MQfrpxXTK8ylN91apUlfdt1nCZEMJI06W7P7Ec6eG5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erHnmydkBCaD8FpEGgwlR+GicmTwK7aKVHHSouWkbOQ=;
 b=LGnaFFfhHCVWKhj8aVGsZf5mOjDXCxd1XsCITopqvpzOj6fgLel6kAtcxCK7ywC04l9dCAxqQV88dbW3D9v1wqD5a5ymcdgnQMtTIhTiGlKj/ByAfEniXpAL1+TPFu3m/muVbGrpdTPJUSO5MnnaCSZfWBHyB7suiTUuUZeKHF1BdpKPlKzI+o2Oot+5iDofWJVAUUDRYr13GuqD3xe5JJnQ0BnWczBpj9LvXWYVOLK6QW/2ztwSI/71coA1IcNgreZcqR4OUr7j4YyDNTMnTd7YAqj2G20ZzIVLtecubvl4HjjNlhV6qnU8EKiBJXTxBtJ0mUyJezkzUlebJvH89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erHnmydkBCaD8FpEGgwlR+GicmTwK7aKVHHSouWkbOQ=;
 b=ih4HpNXmCKqESBgAx0MAKiziIF+OivC9ketANFnseVfFkviGflhbc9mXQUmRl/xHx32RVKas0IhNiwvR4vGxsgX2UXpSYoLB8OBeaXcNCbn4Lj4hODJ4jCqdtU83gBTE5fk0/Y8eqfEnlNY4l+2N+c1ploa17CnmKTsXiWZSwAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Tue, 14 Dec
 2021 08:41:35 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 08:41:35 +0000
Message-ID: <a70587c6-abe7-ef44-21b9-1c8d6a2c659e@amd.com>
Date: Tue, 14 Dec 2021 14:11:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: fix a potential gpu_metrics_table memory leak
Content-Language: en-US
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211214080633.335789-1-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211214080633.335789-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8013ce-8ccf-4d95-1ba2-08d9bedd890a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39305E8567FA98C06C759FB097759@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OYlyswoQ7wRjFMxgzx1Zb2MKO0/klS2YAigY1x3rREYvyF4Y1DvbUkZUpWcOhIjXH4dcY32jCNYo5F/8cvCjjLcpmKtNa9DMAjBd0MfHd2XhjvEtpiej8iv3rsVy4AHO202qjMkOZMNBcf5G9TDWY19f3dcIgS6mCjHKV26WlFC4sktji28dtt2OqIlaSkYd64sACiv0E9G292a1ZRYr/G6gjrvxObYC0309zK3EvrSMyE/ZGFyBralPzrmQ9VXEfkiNvtJlgQgw9VlSIcqpn8gnU6J2VTSonTT2TrQkEay+VTMNfSH3uLAJuJokBCfw5CbsZetT849DVMyyi/97ahOGpTQeIokgaCr4JBrahdVAiIVXFhtzcnyVQuv89UcD1MeKMXFOMXzjL9QPnO3GbBaBoT3BI1WGkDiv2qcrJBSsLgBYQMhrrQBreqMnV/XG1BwpoFCIH7C9YMJhXFowalkzOSzOituIzyn0p9EKVuB+r74E75p/tEVc0KXreuOS9ktNOua2Ik2t9B10ufdHIfRp2Q3hJes+/chyXiGwOV4Un6D5UULG/gKgWQeXVNCf6N7OxX6xLydVpjauGkx/wHnipO1H1v+5QmDEbi1EPpNK7mdR7HVBVxQsjko7SSO3hyJlHvl2atLOktkiolt5P5NpZcoMvgt0QQ6MdJk3iSpOMcl5oVIB5UqQaGjXa7Cj3zf66jyrNkWl0jo+QFUMz7sUCmZXG+daCH7xk43qZPPs+52RGaKErpxPFOrME0I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(508600001)(54906003)(4326008)(66946007)(86362001)(66556008)(66476007)(6486002)(5660300002)(6666004)(31696002)(8936002)(8676002)(4744005)(31686004)(2616005)(38100700002)(2906002)(6512007)(36756003)(26005)(186003)(6506007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXpmdDVOM2psMDcvams4WDIranpxT3gvL3l4YkNzSFJLUnhpckNxbDBzTmdp?=
 =?utf-8?B?Mzd4SG1pcSt3aWRiMUNEWHpsbEc4OTFCREZuVlRaVmhOZ2V4Vm9FZ0RUZ3Jq?=
 =?utf-8?B?RjZzNFhkWVdhOHdrQ3FQYk9XYzBZeWQvc1RBcE5GNmZ0VG9KdGZyZW1uSU9T?=
 =?utf-8?B?SUxnYWk0bVQ5NkVCT1pSSjJ5RFFvbTR3bHdqYjBkdHV1cGRJRUk1eVAzNUQx?=
 =?utf-8?B?elo4SmU4TTA3NTlRay9pMlQ2TmRuNXVWUDNLd2syVUJjbkE0VkJXV3p2cVlC?=
 =?utf-8?B?VzJXNURHcnhaY1p5RkxpU2VzSDkyQWZ3cURsVXcvYktqYnN2YlhJdmtpYk5M?=
 =?utf-8?B?c0FwRngxcmFwNXRKUDFBWGwrbk1EV2F1M1hhNEpzSTRjT2dzeElIZEtkM0lS?=
 =?utf-8?B?ZFdsaTJHd09DNG5XZ3RmRjJMY3ZQUnR4YmV3Ry9KOSt6TURkZGxXdSthYjdS?=
 =?utf-8?B?Vk42V0w0bjNDUER2Z1cwSnJpMmJ4R1pqU3Bjb2p4eEVkbUx1S0hZVU9DNDc1?=
 =?utf-8?B?dTJsTU55YTdELzBOSW5KWDdQcjVaVGJGTWVLdUhpK0V3TVBNR3FGdFVZWVV1?=
 =?utf-8?B?MU8zb1BPL1lKKzhPd1Jza1NHdEQxcjR0aXRmKzZqcnFKcXI1cll3aWRxWDlT?=
 =?utf-8?B?QW5xMU44bE55emNIM2NMM1U4NmpGZmRZcE41bFRjVGpvN3N5RkwyOWw5WGU2?=
 =?utf-8?B?clgwd3N5dDhYVHVnUlhFcTFtUjdrQ2I3cUNpRnRybThEbzRnblA3emdvQWlj?=
 =?utf-8?B?dTVxY0F6RGk4RUtKd0U3RlpxYkdSY2hJTG5ENGVzMnJPdi9MYWk2T0EwaTBY?=
 =?utf-8?B?WUNDTFJiOENlZ0E0MERVMEtOckJuODhsalRwdVo5Q21uN3grOXNQUVJpRUVt?=
 =?utf-8?B?ellicVhmUlBWSlRqemJwNkdhNm8zcHJJTGNPRDhOUlQ5QXluYkNYbTFtU3Y0?=
 =?utf-8?B?VThaRFcyRGcxenY1WWE1RkV2OEQxS3ZwOGZSNHVkZWl5ZFVnN1pReWRJR0Jh?=
 =?utf-8?B?MXgxYndiZXJLNjltME5XTnpQL0hjQU9Ud05qN1RxOENRdTVhMVlOV2dNa0VR?=
 =?utf-8?B?b3BCU285djhoemRDaGlaVmpBc25mYVpxSW9JNVhFOUkyeGlIRFpKNHJBNEt2?=
 =?utf-8?B?dXlmeUZoZVAzVWxsRHA4UWR6YTBwOXR5Nkt5cHQrb1h0TXlubmJiem9Ic0Jo?=
 =?utf-8?B?VVUyeWU4UDFWbFUvcWpsRjQzRmNjSkVsOG5SbmQ5MlZYT29oa0R2SWNVTmtS?=
 =?utf-8?B?aThENFNsQTVreHV3SVlEMlBIMHF0SUpSckxGYXhhVk9Xbk1sSExrL0plSzZk?=
 =?utf-8?B?UTdmR2V0ODVXWDNMRHJ6ZDRaRXVXd1pBbHNPUi8ybGRFWXdUSkFJVzFzUG9C?=
 =?utf-8?B?QmpzQnc1U3E2R3FmTU81TTR2RENhMXNGNXZ2UytEV0FzMnRnVGdsVThYS3Nq?=
 =?utf-8?B?K0xwUUc2OFFyN3JFdndibjFFOCswY1U1MFZIbjdrZHJ5M0JTZE5jTDV5Z0lG?=
 =?utf-8?B?M2RrVGp3aTZ6ODBvZTJVTXEyMEJRbWgvcG5Jbm9wRDdXZnJoR1AzaHJzS1RU?=
 =?utf-8?B?YjYyK3VPQWx3TTJObkptbTkwNGdjMzR0NHNDV2U5dHRLVVVhV1VWQmY5TlJL?=
 =?utf-8?B?M2EwSCtDZzJVTjEwM3UwSXhkTVJCQkxkdWVWRTJSYzJqbFIyVG9VWkFnZU5o?=
 =?utf-8?B?cmxzMFVBZlU5RHBxQXovSUd2Rk1SMlpqc3BidXVHaUpDaXgrbndHUzhTLzVD?=
 =?utf-8?B?U2VTMHF6ekVjU1JGQkdPUlVOTDF0UEQzNkZhTDJjb3hrcEJiYmtVZ1JSajdo?=
 =?utf-8?B?Mjk0WU1OQXkzOG5SejhZU1R4bDFTNDhzRE4rMWZOYXFUeDBHbTNBQTlKQ3Rj?=
 =?utf-8?B?bGt2d0ZqT3dPVWdPdjA3Q21iL2R0bW1ETWJOdmY0R1pORFFHVlJJVGdkU3Vv?=
 =?utf-8?B?KzRPTU9sdE9vempJdkJIRXpwK3dqV2xRdDVTODZ4Zi9DUDFLMHdpYXJ1MjVY?=
 =?utf-8?B?akE5bWNZZjdtSEk5SmM1WEpnUE56V0pMM1hEVVhDUzlkQjBVeGx5UG9NTjV6?=
 =?utf-8?B?MnIxbHEyVGZwQ0ZuZFVJQ0ZJeDFXS2RNaGZ0QmQxdXlmaGNBQmN5RkZvQ2hz?=
 =?utf-8?Q?cRtE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8013ce-8ccf-4d95-1ba2-08d9bedd890a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 08:41:34.9714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX+Q0c+fzJrVZc4ieah8oWLwluqtGLywaSX9W612Refoe5AC0Z13cNBKTUzGYgoL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/14/2021 1:36 PM, Lang Yu wrote:
> Memory is allocated for gpu_metrics_table in renoir_init_smc_tables(),
> but not freed in int smu_v12_0_fini_smc_tables(). Free it!
> 
> Fixes: 95868b85764a ("drm/amd/powerplay: add Renoir support for gpu metrics export")
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index d60b8c5e8715..43028f2cd28b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -191,6 +191,9 @@ int smu_v12_0_fini_smc_tables(struct smu_context *smu)
>   	kfree(smu_table->watermarks_table);
>   	smu_table->watermarks_table = NULL;
>   
> +	kfree(smu_table->gpu_metrics_table);
> +	smu_table->gpu_metrics_table = NULL;
> +
>   	return 0;
>   }
>   
> 
