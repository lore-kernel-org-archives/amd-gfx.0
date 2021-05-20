Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE940C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD8761004
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD8761004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666FF6E8C7;
	Thu, 20 May 2021 08:16:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1FE6E8C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 08:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mogvJuQ62bAn8SNheHSLlmZIAhG3S4ZAAXbcQNFbcw5FwkCgzurcIT2eTFmeG5V6hqLgYzynsMgmUsRT7RFWua+CJgFFtD+w8ZmoLKECnS8a93eVoM1rbpa4cNVL2D3Foz9M1mh2O5lMvEbi/+7XAMwkydKiaX9qRhvRRrGDRWeyGA2NKZp7OEdwbOtmwQ0W6UCHrU/I7By+PmIrYtArWFVtlAXl+5xu5STrcS6UmXV0SWa75ZEPUlA73j4PztypJZz9UY59Td7Huyri80Eu+tuZCbtL86SzgE3glFntJI9TeOnBpm8ENMuFYewoIzXvQsNz644hV8TJlJhnIet07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/7SFVzz3Z4pzIDHmm1aDj+jii8r4o1N27cmuPo8xmw=;
 b=Iahg7VhTkAX+hPA8HzvdmxcIWkns6ruJpvthWbV9J612VswkTf/k6ptO8xeCUjGC9lbU1yqVzROzKtjmezFef1IMB6f364cwINXFNkXkZ3Bp/Tx95xPauizQuHT1oW9FI2V6xa52SjpVPp6uzEc82HC4T1560CnF129MgJNQvW41fjmLG4fnDokEqr8RQ12mphC7N+Az4hUfYl+rpxszQUgRnYUvCNyo268e0BlAcsDTCqQRCNmA1dADjnTQVN1QcFjWRUFTh7S8eAXf78v8yrqu5etjd5o1tevscQ2C0aWRSyvmF6fc2JLK9JocmdLactfzyfYc5gRXqFfa2TOCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/7SFVzz3Z4pzIDHmm1aDj+jii8r4o1N27cmuPo8xmw=;
 b=y8nlCXGxYMwMaGtJ4ofLWnGvhLlmcPzaHuN9u+NudN9/X/pyZ3aj3vF4CYniQMf/W6ms1WCsUhCbIrtMSi4axc1ZA5q+8eswGQ/eSyGLEt73Xl0L4Xi8YGXG+Rvek65oWuTbnmSLLyZ33uOM8qjse/Jac5+9AA786YfKRtPrbqs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 08:16:21 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 08:16:21 +0000
Subject: Re: [PATCH] drm/amdgpu/acpi: unify ATCS handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210519203747.2736827-1-alexander.deucher@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <fb1b5670-f90c-bef9-e0e0-1b6fbf6aab3a@amd.com>
Date: Thu, 20 May 2021 13:45:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210519203747.2736827-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::11) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MA1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 08:16:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7566ff-c8d5-4d7f-683a-08d91b678cf0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB532969E2BFF567364623EBC8972A9@CH0PR12MB5329.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:31;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0kEUbk4eidZ3cZVxcwxbhcVh5Df+UTbE3EDjELCTotldIE9AIhHT7DZjC+WSRavxyD38WqTqY5wn955hlYbPt5oso5xPaliN0jGcKyQ10lEeYpvZE0NJhDSJ70Vpx+mCqii9bS+os9tVmoyfA/cP8YDv2FLFsgiBDvXsE+qWMGm2f+8BfXZvoGfoAeFMUb7BU23Xa/8a6NFWSizvvEGOu2kLJwG/Czh8oGb0x028Ow3YCkuHLoVruC/THnNwoirHTY9OzcTNf9wfN3KildWeLI45l1C7F1vEuB9LOk/FHVGR5FUdl+tFFnd87KPM4ComX+sf+oNcO+wVs9j2G97KWMLouGsZMpUkvNW2kSWZFA8TG7fHlvoMsKmrUtpLZkSnzMP+CIwUyfHCItTC1ZK9DlRpE44cVvH9l70xuiAvEK59LAuvIPhrx2KrWuyKQZJYQXqghPjduq1x2N+62yXkjq9HNl+P4yIbBaKboxppFpDCYcuMBhajYhQpWTr44ZJ7L2t0Ovw2CVwvoce2q+ZLxGtHIzv0ORPSf0egYN0QSpEu6YtwKlwfhUmAY7YksmA/m/XgdsteKtQv+Rt5zJqB2vPcox6/6grjgK6cb+DtA0LYtMX/KgH9kCPxBpCA0W1UJhfhvaI+8VIbsqd0pApBwmvPvxHOnhOytQt2Kwb7lHSy14/l6+AD5Eo08dWlq06Kd7D7duNc2UWqwzhHnbHCxP6orzyuEHOMiRucnk9ZvsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(16526019)(186003)(2616005)(956004)(38100700002)(38350700002)(36756003)(44832011)(52116002)(83380400001)(53546011)(316002)(26005)(478600001)(16576012)(86362001)(31686004)(8676002)(8936002)(6486002)(2906002)(31696002)(66556008)(66946007)(66476007)(5660300002)(6666004)(30864003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aC9BS1FQQXQzbFlGZzFQZ0VsTGlZeHFLc1ZlZ0hneTJ6dGU3Q0xFazFvMlZX?=
 =?utf-8?B?MmJocjdtc1hxbEVhb21PajRXOXJwZmNGeGxWWXdhSkNsbWlUMFhTZHFtZWpM?=
 =?utf-8?B?R1pjQjhXSzJra2hFK1oxU2hlWlNNMW5vN1VqT0diVFRsMllYeXFwa1FEd3pO?=
 =?utf-8?B?cUp6U1FTOWNhV25QaGJWU1dEQlpodE5JRzE1am04SnJSOXlqc2ovV0h1ZXNK?=
 =?utf-8?B?UTNNU3ZGYXBFQWUrdnIzWWtaS0piSzRXR1cyNlhRNjFrRGF5SFB1S1JZbFhC?=
 =?utf-8?B?WXQzQTBHOWFNWVRadDhmMnhxaFhMY29hbEwvdkdLMHlkNk0xRXlpcnRmV1d6?=
 =?utf-8?B?dXFrUWg0OFQvUXpwTnNYSG9zVVE0SlBTMVJiSU9sYURrMGRwYjg3dWdYclFE?=
 =?utf-8?B?bmhhTytwWmJoVk9peSttZktGb1lva0NRajA2RVNQOWZ0akZUUTFMWUM4VEZL?=
 =?utf-8?B?R0FVZmZBUWlBY01DQTVXbHlyb1dQMXNpVVpmWVdGR0VXK0ptNGVQRnBoYU9I?=
 =?utf-8?B?WVhjWCtHbWpQL3J3N1dveEI1cW5Zdm4rdHRuQ2QyVFRjU2QvYlpwVWROSXJl?=
 =?utf-8?B?K3MxSEdTRTFBZWx3SWljU3p6ek5kWDBWdGxLemkyYVZ2eXZVZW5mSUg1Ymc3?=
 =?utf-8?B?bUplZENzb0xVcFZ1ZWtqZnRoNDMzL2Q3cC9CU1dvdXcya05QNFlldWVKcXRy?=
 =?utf-8?B?VW9FMTZqVG1YSjRscmR6RjBZTXJOcDUxYk84K3p1dFN6NDhTMkxsTXl2T1Bx?=
 =?utf-8?B?SzZmOHgzZWJNMUdGaHhqVFNORU1qanIzR2pHOEcwRTdzZjdpckcxNEgwZXZp?=
 =?utf-8?B?VTNRemEvblh2OVJMbGVPaWlaeUpLMzR0YjlBVFlweEUxZUNVZnJaQU1ES2tn?=
 =?utf-8?B?UEYxemo1Y05EczFuQmhkK3h5aFFPTXVCZUJvclJaeEY3RmdxSVV0WGVIS3dM?=
 =?utf-8?B?TmhXdDFRVjdkcXJyVjR1bGVkSHc0UktiY1VIa3VFQnFjVTlKSHFKaHp0MHRx?=
 =?utf-8?B?OXVJUmtucXp0WnF2ek1NT3ZCT09WYXp4SmNhY2Zia21YWEhKVkdKVWtzaGtX?=
 =?utf-8?B?WGkwYzJ2aklGQ0RKZ1hmODVHNFBBTVh1a2I3RE1IYTQ5ZFJndTQzMUthMjFj?=
 =?utf-8?B?bDAvd2ErTDFmcVp4UndyTno5ZFJyZGUyN1UyeFkwcjlHaHFOQlMrYzZDaURk?=
 =?utf-8?B?RWMwQmI1M2lxek5uMTdJSk5ZY2JDMnVJWU5LZDdLbmwzQnptYnBtS0cyVnRo?=
 =?utf-8?B?YVM0eU5veGx4djBzcTRzaFNRNVlIVWF1Z3QvYlJacVl5NFlLMFQ2OHR6Q3l6?=
 =?utf-8?B?bVNTdk5lTmRnWHV2cWhXK2tTbnZ5ckVmbE5RdnJYTnJUODRmZCszM3dzY0s3?=
 =?utf-8?B?eVhhb3kwZnZDQ1FWZ1FRT3NvdGphdHNUamIyc2FUaDhnTUhDSURKTUc2S1U3?=
 =?utf-8?B?c0hWQklVNmJNUGxFaExpNzNNdFJVbGE2YWZ3c3Z5Ni9aK3A4ejJPWmtiZ2F5?=
 =?utf-8?B?aFJxS2hnRm9tamh4Y04rYmFMdVo5QlhUWFJCWlpsbUk0YWpNZlNTNEdaSExP?=
 =?utf-8?B?Qkx3MVk2dG5wMEM2OHJEdUU5SDhhYkpOaDllL3IzR1BRalloTVRhcHRuWXlL?=
 =?utf-8?B?RGNDc1JQRnphRlFCVS9OUGxQdEU5N0E2U1hmZW1vbkdFUXExVWxLd1MraTFo?=
 =?utf-8?B?N3pEODA2bGdSS0EveXFkQ3hkMlNVR3kzUldaUkRIYnFTUzRpK1BjNDZJckVV?=
 =?utf-8?Q?phGbvQeA7gS3nNqpB4B6kQPfMZ/sOn9Rr6aTrIC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7566ff-c8d5-4d7f-683a-08d91b678cf0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:16:21.2112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghzbcfzBucC0MnwaBub0wlvLmB9e8Ai+oBI0+g+iY0DqZEADKmqS/UCH1uMim+pC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/20/2021 2:07 AM, Alex Deucher wrote:
> Treat it like ATIF and check both the dGPU and APU for
> the method.  This is required because ATCS may be hung
> off of the APU in ACPI on A+A systems.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 126 ++++++++++++++++-------
>   2 files changed, 92 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3147c1c935c8..b92eb068be12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -269,6 +269,7 @@ struct amdgpu_irq_src;
>   struct amdgpu_fpriv;
>   struct amdgpu_bo_va_mapping;
>   struct amdgpu_atif;
> +struct amdgpu_atcs;
>   struct kfd_vm_fault_info;
>   struct amdgpu_hive_info;
>   struct amdgpu_reset_context;
> @@ -685,20 +686,6 @@ struct amdgpu_vram_scratch {
>   	u64				gpu_addr;
>   };
>   
> -/*
> - * ACPI
> - */
> -struct amdgpu_atcs_functions {
> -	bool get_ext_state;
> -	bool pcie_perf_req;
> -	bool pcie_dev_rdy;
> -	bool pcie_bus_width;
> -};
> -
> -struct amdgpu_atcs {
> -	struct amdgpu_atcs_functions functions;
> -};
> -
>   /*
>    * CGS
>    */
> @@ -829,7 +816,7 @@ struct amdgpu_device {
>   	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
>   	struct debugfs_blob_wrapper     debugfs_vbios_blob;
>   	struct amdgpu_atif		*atif;
> -	struct amdgpu_atcs		atcs;
> +	struct amdgpu_atcs		*atcs;
>   	struct mutex			srbm_mutex;
>   	/* GRBM index mutex. Protects concurrent access to GRBM index */
>   	struct mutex                    grbm_idx_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index bf2939b6eb43..cc8bf2ac77d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -71,12 +71,25 @@ struct amdgpu_atif {
>   	struct amdgpu_dm_backlight_caps backlight_caps;
>   };
>   
> +struct amdgpu_atcs_functions {
> +	bool get_ext_state;
> +	bool pcie_perf_req;
> +	bool pcie_dev_rdy;
> +	bool pcie_bus_width;
> +};
> +
> +struct amdgpu_atcs {
> +	acpi_handle handle;
> +
> +	struct amdgpu_atcs_functions functions;
> +};
> +
>   /* Call the ATIF method
>    */
>   /**
>    * amdgpu_atif_call - call an ATIF method
>    *
> - * @atif: acpi handle
> + * @atif: atif structure
>    * @function: the ATIF function to execute
>    * @params: ATIF function params
>    *
> @@ -236,6 +249,35 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
>   	return handle;
>   }
>   
> +static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
> +{
> +	acpi_handle handle = NULL;
> +	char acpi_method_name[255] = { 0 };
> +	struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
> +	acpi_status status;
> +
> +	/* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
> +	 * systems, ATIF is in the dGPU's namespace.
> +	 */
> +	status = acpi_get_handle(dhandle, "ATCS", &handle);
> +	if (ACPI_SUCCESS(status))
> +		goto out;
> +
> +	if (amdgpu_has_atpx()) {
> +		status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
> +					 &handle);
> +		if (ACPI_SUCCESS(status))
> +			goto out;
> +	}

Going per the comment, it's better to reorder. If atpx(), check in iGPU 
space first, otherwise go to device's namespace.

-- 
Thanks,
Lijo

> +	DRM_DEBUG_DRIVER("No ATCS handle found\n");
> +	return NULL;
> +out:
> +	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> +	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
> +	return handle;
> +}
> +
>   /**
>    * amdgpu_atif_get_notification_params - determine notify configuration
>    *
> @@ -485,14 +527,15 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
>   /**
>    * amdgpu_atcs_call - call an ATCS method
>    *
> - * @handle: acpi handle
> + * @atcs: atcs structure
>    * @function: the ATCS function to execute
>    * @params: ATCS function params
>    *
>    * Executes the requested ATCS function (all asics).
>    * Returns a pointer to the acpi output buffer.
>    */
> -static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
> +static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
> +					   int function,
>   					   struct acpi_buffer *params)
>   {
>   	acpi_status status;
> @@ -516,7 +559,7 @@ static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
>   		atcs_arg_elements[1].integer.value = 0;
>   	}
>   
> -	status = acpi_evaluate_object(handle, "ATCS", &atcs_arg, &buffer);
> +	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
>   
>   	/* Fail only if calling the method fails and ATIF is supported */
>   	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> @@ -550,7 +593,6 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
>   /**
>    * amdgpu_atcs_verify_interface - verify ATCS
>    *
> - * @handle: acpi handle
>    * @atcs: amdgpu atcs struct
>    *
>    * Execute the ATCS_FUNCTION_VERIFY_INTERFACE ATCS function
> @@ -558,15 +600,14 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
>    * (all asics).
>    * returns 0 on success, error on failure.
>    */
> -static int amdgpu_atcs_verify_interface(acpi_handle handle,
> -					struct amdgpu_atcs *atcs)
> +static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
>   {
>   	union acpi_object *info;
>   	struct atcs_verify_interface output;
>   	size_t size;
>   	int err = 0;
>   
> -	info = amdgpu_atcs_call(handle, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
> +	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
>   	if (!info)
>   		return -EIO;
>   
> @@ -603,8 +644,10 @@ static int amdgpu_atcs_verify_interface(acpi_handle handle,
>    */
>   bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
>   {
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs = adev->atcs;
>   
> +	if (!atcs)
> +		return false;
>   	if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
>   		return true;
>   
> @@ -622,19 +665,15 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
>    */
>   int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
>   {
> -	acpi_handle handle;
>   	union acpi_object *info;
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs = adev->atcs;
>   
> -	/* Get the device handle */
> -	handle = ACPI_HANDLE(&adev->pdev->dev);
> -	if (!handle)
> +	if (!atcs)
>   		return -EINVAL;
> -
>   	if (!atcs->functions.pcie_dev_rdy)
>   		return -EINVAL;
>   
> -	info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
> +	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
>   	if (!info)
>   		return -EIO;
>   
> @@ -657,21 +696,18 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
>   int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>   					 u8 perf_req, bool advertise)
>   {
> -	acpi_handle handle;
>   	union acpi_object *info;
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs = adev->atcs;
>   	struct atcs_pref_req_input atcs_input;
>   	struct atcs_pref_req_output atcs_output;
>   	struct acpi_buffer params;
>   	size_t size;
>   	u32 retry = 3;
>   
> -	if (amdgpu_acpi_pcie_notify_device_ready(adev))
> +	if (!atcs)
>   		return -EINVAL;
>   
> -	/* Get the device handle */
> -	handle = ACPI_HANDLE(&adev->pdev->dev);
> -	if (!handle)
> +	if (amdgpu_acpi_pcie_notify_device_ready(adev))
>   		return -EINVAL;
>   
>   	if (!atcs->functions.pcie_perf_req)
> @@ -691,7 +727,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
>   	params.pointer = &atcs_input;
>   
>   	while (retry--) {
> -		info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
> +		info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
>   		if (!info)
>   			return -EIO;
>   
> @@ -767,32 +803,26 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
>    */
>   int amdgpu_acpi_init(struct amdgpu_device *adev)
>   {
> -	acpi_handle handle, atif_handle;
> +	acpi_handle handle, atif_handle, atcs_handle;
>   	struct amdgpu_atif *atif;
> -	struct amdgpu_atcs *atcs = &adev->atcs;
> +	struct amdgpu_atcs *atcs;
>   	int ret;
>   
>   	/* Get the device handle */
>   	handle = ACPI_HANDLE(&adev->pdev->dev);
>   
> -	if (!adev->bios || !handle)
> +	if (!adev->bios)
>   		return 0;
>   
> -	/* Call the ATCS method */
> -	ret = amdgpu_atcs_verify_interface(handle, atcs);
> -	if (ret) {
> -		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
> -	}
> -
>   	/* Probe for ATIF, and initialize it if found */
>   	atif_handle = amdgpu_atif_probe_handle(handle);
>   	if (!atif_handle)
> -		goto out;
> +		goto atcs;
>   
>   	atif = kzalloc(sizeof(*atif), GFP_KERNEL);
>   	if (!atif) {
>   		DRM_WARN("Not enough memory to initialize ATIF\n");
> -		goto out;
> +		goto atcs;
>   	}
>   	atif->handle = atif_handle;
>   
> @@ -801,7 +831,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   	if (ret) {
>   		DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
>   		kfree(atif);
> -		goto out;
> +		goto atcs;
>   	}
>   	adev->atif = atif;
>   
> @@ -810,7 +840,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   		if (amdgpu_device_has_dc_support(adev)) {
>   #if defined(CONFIG_DRM_AMD_DC)
>   			struct amdgpu_display_manager *dm = &adev->dm;
> -			atif->bd = dm->backlight_dev;
> +			if (dm->backlight_dev)
> +				atif->bd = dm->backlight_dev;
>   #endif
>   		} else {
>   			struct drm_encoder *tmp;
> @@ -862,6 +893,28 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>   		atif->backlight_caps.caps_valid = false;
>   	}
>   
> +atcs:
> +	/* Probe for ATCS, and initialize it if found */
> +	atcs_handle = amdgpu_atcs_probe_handle(handle);
> +	if (!atcs_handle)
> +		goto out;
> +
> +	atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
> +	if (!atif) {
> +		DRM_WARN("Not enough memory to initialize ATCS\n");
> +		goto out;
> +	}
> +	atcs->handle = atcs_handle;
> +
> +	/* Call the ATCS method */
> +	ret = amdgpu_atcs_verify_interface(atcs);
> +	if (ret) {
> +		DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
> +		kfree(atcs);
> +		goto out;
> +	}
> +	adev->atcs = atcs;
> +
>   out:
>   	adev->acpi_nb.notifier_call = amdgpu_acpi_event;
>   	register_acpi_notifier(&adev->acpi_nb);
> @@ -892,6 +945,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
>   {
>   	unregister_acpi_notifier(&adev->acpi_nb);
>   	kfree(adev->atif);
> +	kfree(adev->atcs);
>   }
>   
>   /**
> 


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
