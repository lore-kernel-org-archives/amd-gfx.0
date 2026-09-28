Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED10BC98328
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 04:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01ED410E052;
	Mon, 28 Sep 2026 04:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iKygAT0t";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F20C10E052
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 04:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8PZcnN+cHRGknN+bOvATusgDEdoumT+GNYtUR0Lja++HM7n9fErrXAzR24L2w/dfGmJPB4mR5V4KQ9L9adbd9v3U2xx1+uZayjEkb/U62rM4cRm/PkAfD2u8KWcn6NzftaBJPyWLdYFwOdCRVrpfWI7f6N7oa1PSdUbxHG7DskjgiwU3HQZTGsFNoCzPvrzjJAu/RgtKuHTKmuVZcmlf+j/FYsa2fl8mVWHJFijCwbp0hGTOeoQjpHWObpvLpn+DAm6C3tEJ0JxoOxd35vIa7jQGPs+jINTXrdVdlnmFmIgjoVwxHFfsguKUh3FSuYsBk1cfdT8+M//kTx7ctW8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG/lNpXiezB2qRDmVNrbWAKY34nhaRV80MXJmCHW3ko=;
 b=HY7e+45SWZrzU52yXDC5IWaAHOZoNcUgUXs/JEgpQ2wSyDf3ZFAuflORGktUnRIyCu0hBy5FuL5PYe9IxfgellLsjapebRMB3s7x1iLx027YXWFW/GhcTi9aXsPA57GF+t8TaB+v2tH0Sn85EnMf5T2LK9oHnG75l8791dqXZchg+CZUiXbSXpYPxY6fzjyJZQOT1aS5C8VqdCSsb7GQDJYSk/PqhKM5W8MzWS++bF2DJJVUJIovQqgyEjAbpZs2CUQJ/4B+XTL+je4Uc+bfKfAua1RVXW3fgZ/HePF4qf6KXH1QrxwH1hVzEXC9yF2ol06iGfwvdhRvVnX9SbhJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG/lNpXiezB2qRDmVNrbWAKY34nhaRV80MXJmCHW3ko=;
 b=iKygAT0tjOefrEWolEPKduZy20jK5ZobUpiwnEBz1Jw3A6pgMQDBLeTzoJuik8rQoXity18574prndTpJSultlxohokygFM8jGkRqvboPF2JXjh8HSoL7hFUp2LuPXKeXVe9DZlzGw5ZyhaNJ6xVQCZ+jZtfQzWt+NtMH3icDXY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY3PR12MB9556.namprd12.prod.outlook.com (2603:10b6:930:10a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 04:43:22 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 04:43:22 +0000
Message-ID: <f20b4b97-1334-4190-b1e3-ae8b6fcca69b@amd.com>
Date: Mon, 28 Sep 2026 10:13:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/mes: Support 64-bit register reads
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Shaoyun.Liu@amd.com
Cc: Davis.Ming@amd.com, Gavin.Wan@amd.com
References: <20260924063519.688340-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260924063519.688340-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0075.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY3PR12MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3f1d9f-88a3-4c60-1238-08df1d1b0649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xrx0CSnyFhQ89wjJ8A8R07xE9rXvckMCwCz3S47erjacr5JT4/4UKv5LH8ii4/Fb4EHNV2fvbPSEHxFmIF53Ft08w3V+CGTkAsvKt5y3OzOTL0PWsEKe2KkQ24a7mGyys2Xmv+AHjGEX5dr270ihOJT3EatkgVU1zOq6VEWZA8q5OqSum/zLOWaJ6Nt7nZXzOG3dzYVsZoLo5s7XouDBba0onfunMoY/bUYNfxfH8rj/Yr1z6IRdMUzFgXHI7fQ6qSMFmExib26X9iWVj3Xa9z92kuj4ls1LFd5h/EdTR/UFyZrKdJvAuL/ngtKXPTQlhkXoIMw75Q7KcjvBc5IHZFUooyRaRjQl1TJM3a5MfEU2CovTNZTenAtdcdeaQIZr9k/9tEgAJ2b1uLfgnARjvbxxKInKYyKZ7+JZQaou1p0hUNQgjxdXMaiYKZyUNDcJRuYXdDza77qnzMP5p2jLitN6do4NcMU/v9Bpm9399Y6XjaidBRNvQb+uGS2nyRjAMr69kO1NbkUnKuao6iDpQ57pF16VEf7SOLrIXt/udm2eb6TtSzj/qmxs0cli+rrXn5x+rZupLTCKOp58nIVEjaaZOOGw4e5EODeIoQK6Wjaa3WNOxcf0Gi6JChH/HqNGYaPTiTesTYuSbFZXDsWsk2m92g/zokEsMzemR45UgFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1kxOGRZeUh1cW5HWVI0aEJDMU9vcUgzQllKNzFvWE1teGlEelB0QmU5aVdw?=
 =?utf-8?B?MkFqS2tWblZsajJXYWZHR1RzRXJ0M0lkaXhYc1RhVjJjQVJUK0dWTU1zZWJN?=
 =?utf-8?B?YTBvcVRmOGZJdGsva1B6Z0RzSUhxNEkvQzBNbVVBTzlXbXZnbVBzbnlHcUda?=
 =?utf-8?B?b3ZNaHNIQ3JuQUpnSmdqUktaU0J4R0hBVWQyTzA3b2ZCa1VPTWE2RzloNFBS?=
 =?utf-8?B?SmUxWUJ5Ri9kQ0d5K1pjdjd3WXREaXNjK0duZTRFQ1N2Y1RMUkkzczcyakM2?=
 =?utf-8?B?MmNld0FUbzFlUTZoemg3VytCeWNWeHh3T2p0VFVKQTJWOEM5VlBNQjQ5YW5y?=
 =?utf-8?B?c0FqRXRGbGxiYXU5KzIxNlNUNFZKc2VkakZnRUF0aC8zZkNGT3Y0N3YzSFdU?=
 =?utf-8?B?UE0xZkQzMWFjSUV1S3lYbjNlQVhEU1d1V1pYd2ZsYWNkaDdkR24vUkhSOWwv?=
 =?utf-8?B?Q25xY0MvU1RYY2t6bk5CSU9QV1JQM1VWZDE5STBNV0JlaCt1QmJsa1pPVUZD?=
 =?utf-8?B?NFFmYVVSeE1Nbkp6d21NVG9UNGdKY2RWNmcrWFI3bFh3b3ZOZHIxZENoZVZt?=
 =?utf-8?B?TGJyM1VMWnM2WjZlNTlGQWQ1NVRIb0hGK3VXb21wd2J3bkZGcXljMHNUU1I4?=
 =?utf-8?B?OUhjcVNPRXI4MXRsK1dKd2ZZN09HWElkK3dFYjZSaGxsZDhyc21RVmlZa0F3?=
 =?utf-8?B?cEFTRlVtODh2TjlMWlExWHlJOTkzMS9ZYmtmdHdyY0pYUWo2dTBFLzE2Tktw?=
 =?utf-8?B?VllyNjZXc2hEM09IWW40bnZmUUQrS2xORTkza2N3cTNlamVob3I3U2pIR3ZI?=
 =?utf-8?B?WEdGR3paaHl1TTVvQWdGb3Y1ZERhbmhrUXIrZS9xRVBMU2JXSVVPQlJUblJJ?=
 =?utf-8?B?WTdGYUR2c3lBNkxWbkF1ZGVydHFzQnpOK1RsbDhDUGxXdERiT3h2dVdFY0s2?=
 =?utf-8?B?Szd3N01lWVpGMkNEYmpaUDRleE9HVXR2SUM0bXh0TG9JSDdTNTRUY0xndHls?=
 =?utf-8?B?cnJTcGtSYW9pSjEwMURFQ1RaSEdockZvckIrclFTUlpodzJiVU56WE9QREdT?=
 =?utf-8?B?UnNhaDNISWJIVEZDa0lpQURFWGFwdXM4WjdaaDlQdGFtTVBvVFJIZlV2YVFz?=
 =?utf-8?B?RDBRZzFLTWNhbWo1OG8yZHVtWWd1UUpKU0pZSDBtblFlTmVVZ0tvYS9aWnJR?=
 =?utf-8?B?dGpPR2QySzdWSHh2OUxhWGxJQ0RVRENmNTJXVGhkcDYyTUhRSCtuNlNkb1FM?=
 =?utf-8?B?T1orYUkwTkxtNXpBZ3NVd21PUmU5cDVXMXB5dFpLTjdyVXllQVZLYmtqZTVP?=
 =?utf-8?B?RUd0T3VsNCttTnMwNHplU25KcFd6ZUh5Z1ZXZjQraksrY0tNU05JMEJKTUQ0?=
 =?utf-8?B?TG45OWNZaWdtK0RaTGVDZ0pkU0VCczJXWFdWN2NZZkJCUTR0TWQyeStmdVky?=
 =?utf-8?B?K2xzdG1sQ3BJUjJpOWZMbDcwbWdsd25vVUZVY0ZJRjNaMHMzaEk5Z210d3Vp?=
 =?utf-8?B?L25BS2p4cVZOUmQwbWVDek90Y0dQZVRXN1U4ZlR1QjJoYWVqbjI1b0dUakEv?=
 =?utf-8?B?c0Fua1hmakdmdDJiNVdzYTZobjB0THF3NUhGdmZNS0k5MklsTGxvdytpaEQx?=
 =?utf-8?B?YWJYeTRuYTBnUTdQck1NOU5Za05HZmJuWmkrVWlBSnNlQ2FJeTlpckJzWFJi?=
 =?utf-8?B?OWVCME91em5LSDFhLzVwMGN2OWlUUDMyN0ZURWxZUUNkdWkrUjcrQU1lUWtt?=
 =?utf-8?B?eStOQlhVVTZuTThJZHg4aElCZFdZOUM0RHZBN1IwQnA1WngzTUJuemo3VE5C?=
 =?utf-8?B?U2xrSEVPQ1UwZTRZK2xOaVc2YlJwQnl1ZGpPTTdleng2TU9VUERvQWRUbXd6?=
 =?utf-8?B?QUc4OXk0emxPalRScHNVNzRKdDFwbmpvV2RYK0tzd3VibHhVdm5CL1lQYVFu?=
 =?utf-8?B?SUhENXpSUWJNanlNZUE3WlY2T0toellSUGg0R2dDbXNjRXBWNkt0RHAvUUly?=
 =?utf-8?B?ZSs5TVgzQkdHSVhnNGhHMEVVQ2E5N2NnNjhwbnQ0YWIwVnFqV2JhS3RDNitH?=
 =?utf-8?B?M0tSVnRJRDRidnpkdVJQbFRCWlo3V2orMFRIS0xKRGNUNVJyQWQ0SzVsaVYy?=
 =?utf-8?B?ZzRhdWVrd0MvejJHWnpQNnptWGtsbDJQdTN0R294L0xKZUNRWUNWaExhNjlC?=
 =?utf-8?B?cm5tMkk0UzlncytVZkY1LzVyMFhrMVByY24zMWJDNzA4ZWNTenNpM2JPSkJ2?=
 =?utf-8?B?L1pVVk5uS0x4aDdhTVZvZ2p6OUFwbzkvakdENGV4U0VEdW1nM09Ic1N5SUNx?=
 =?utf-8?Q?f2JtoN/YjKMNHNkabw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3f1d9f-88a3-4c60-1238-08df1d1b0649
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 04:43:21.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzZILY3aAfDL5ypTQDhtRARyoqZyVoDNIoML5hcRrfWuZOfrIWZYArFW3O6CTZs9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9556
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



On 24-Sep-26 12:05 PM, Victor Zhao wrote:
> [why]
> Some register values span two consecutive dwords and must be sampled
> with one MES operation.
> 
> [how]
> Add amdgpu_mes_rreg64(), set READ_REG read64Bits for MES 11 and
> MES 12, and combine the two returned dwords into a 64-bit value.
> 
> v2: add MES 11 support with the same read64Bits option
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 42 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +
>   drivers/gpu/drm/amd/amdgpu/mes_v12_1.c        |  2 +
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h |  7 ++++
>   6 files changed, 58 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 5bebe74de01ad..52b05dc7b74e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -582,6 +582,7 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>   	op_input.op = MES_MISC_OP_READ_REG;
>   	op_input.read_reg.reg_offset = reg;
>   	op_input.read_reg.buffer_addr = read_val_gpu_addr;
> +	op_input.read_reg.read64_bits = false;
>   
>   	if (!adev->mes.funcs->misc_op) {
>   		dev_err(adev->dev, "mes rreg is not supported!\n");
> @@ -602,6 +603,47 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>   	return val;
>   }
>   
> +uint64_t amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
> +			   uint32_t xcc_id)
> +{
> +	struct mes_misc_op_input op_input = { 0 };
> +	uint64_t val = 0;
> +	uint32_t addr_offset;
> +	uint32_t *read_val_ptr;
> +	int r;
> +
> +	if (amdgpu_wb_get(adev, &addr_offset)) {
> +		dev_err(adev->dev, "critical bug! too many mes readers\n");
> +		return 0;
> +	}
> +
> +	read_val_ptr = (uint32_t *)&adev->wb.wb[addr_offset];
> +	op_input.xcc_id = xcc_id;
> +	op_input.op = MES_MISC_OP_READ_REG;
> +	op_input.read_reg.reg_offset = reg;
> +	op_input.read_reg.buffer_addr = adev->wb.gpu_addr + addr_offset * 4;
> +	op_input.read_reg.read64_bits = true;
> +
> +	if (!adev->mes.funcs->misc_op) {
> +		dev_err(adev->dev, "mes rreg is not supported!\n");
> +		goto error;
> +	}
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r) {
> +		dev_err(adev->dev, "failed to read reg (0x%x)\n", reg);
> +	} else {
> +		val = READ_ONCE(read_val_ptr[0]);
> +		val |= (uint64_t)READ_ONCE(read_val_ptr[1]) << 32;
> +	}
> +
> +error:
> +	amdgpu_wb_free(adev, addr_offset);
> +	return val;
> +}
> +
>   int amdgpu_mes_wreg(struct amdgpu_device *adev, uint32_t reg,
>   		    uint32_t val, uint32_t xcc_id)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 33a426f58e723..d67814124f9e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -373,6 +373,7 @@ struct mes_misc_op_input {
>   		struct {
>   			uint32_t                  reg_offset;
>   			uint64_t                  buffer_addr;
> +			bool                      read64_bits;
>   		} read_reg;
>   
>   		struct {
> @@ -545,6 +546,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>   
>   uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg,
>   			 uint32_t xcc_id);
> +uint64_t amdgpu_mes_rreg64(struct amdgpu_device *adev, uint32_t reg,
> +			   uint32_t xcc_id);
>   int amdgpu_mes_wreg(struct amdgpu_device *adev,
>   		    uint32_t reg, uint32_t val, uint32_t xcc_id);
>   int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index d8b4d3deff605..304087b851644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -905,6 +905,8 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   		misc_pkt.opcode = MESAPI_MISC__READ_REG;
>   		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
>   		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
> +		misc_pkt.read_reg.option.bits.read64Bits =
> +			input->read_reg.read64_bits;


Is this only a missing interface definition or does this need supported 
FW version check?

Thanks,
Lijo

>   		break;
>   	case MES_MISC_OP_WRITE_REG:
>   		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 04465804c2544..0d2a60528802e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -858,6 +858,8 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
>   		misc_pkt.opcode = MESAPI_MISC__READ_REG;
>   		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
>   		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
> +		misc_pkt.read_reg.option.bits.read64Bits =
> +			input->read_reg.read64_bits;
>   		break;
>   	case MES_MISC_OP_WRITE_REG:
>   		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index d17ced46d5f73..e0a488e516c09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -581,6 +581,8 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
>   	case MES_MISC_OP_READ_REG:
>   		misc_pkt.opcode = MESAPI_MISC__READ_REG;
>   		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
> +		misc_pkt.read_reg.option.bits.read64Bits =
> +			input->read_reg.read64_bits;
>   		mes_v12_1_get_rrmt(input->read_reg.reg_offset,
>   				   GET_INST(GC, input->xcc_id),
>   				   &misc_pkt.read_reg.rrmt_opt,
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 1fe824b41f2a5..b27ec78da3b08 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -635,6 +635,13 @@ struct WRITE_REG {
>   struct READ_REG {
>   	uint32_t                  reg_offset;
>   	uint64_t                  buffer_addr;
> +	union {
> +		struct {
> +			uint32_t read64Bits : 1;
> +			uint32_t reserved : 31;
> +		} bits;
> +		uint32_t all;
> +	} option;
>   };
>   
>   enum WRM_OPERATION {

