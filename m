Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6586F33824
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 09:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D28610E2D1;
	Tue, 17 Mar 2026 09:45:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNLZWRO6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54BE10E1E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 09:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwBqePjXOXltMtX4cPW2QRPluUDZyO5ZfHUK7zDAUo9UYTuvT/ojERUG1LsHHSYnlLWLqGJHxpo4nx5GWrXy2jDfG07u7haqIUiBVHj9YeW1JFSYXs/w1UyfFRKCiZrx6YvI7oUYp89apch2TiR8/2OxTyJ5xII/dIFm0Kz3AvwrC7qQfY2lV+l+dQIjsebekZM3MJiIAhz87/CP6+7OuIemF8n9O9lCihU3ym5qY68YqlFs9l4CpHmKQVYiWeWt/h3X2YYtTotqqIT7s87lMFLkY/zPYDq8n5/5hJzGFSFqdyspJUPivlH1wN35u4QIApMilUDqg6K5aGpIffd91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsP2bBsqvxArNtaVK23E0K7AeWd73i9VQ1YeLjTeA6A=;
 b=CUVjJllosCoxwFI85K2KGx/yoHrxe0ZBaWZYZHLxQaMI8z/CoO4CCeRAWsJfTCElnGGtBukkfuui2Lq/O9vad17Hlop1+rMbt8knWTLOwskClEefwKmFNowGFP+2iqX9hGkNco/0Qdiszb/KfjJKwaM2OKS8NH6GNCIpt67/tjdZK5J3huCdwy7j1mFcsRdHGWpIDi19Oi356gS7sQ4SmxhvG2QwFcI4U3U6JiUBb8AZhl3S3WDEHvi9XBnGZ6s6aG9xapgVpO3aVDup4i+wpgIFfgRtUQi3PiMLvyQPOGPrNDdBsFoc90mzpb7vbvzKeo6MGi3kwNvA2aMYNG9NPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsP2bBsqvxArNtaVK23E0K7AeWd73i9VQ1YeLjTeA6A=;
 b=NNLZWRO6drg2QoJVHskFCXd7wcDBps+7x8B/5RTNRm8ALEIZ+tSrWHFpIA0syH3ZVlJmqFLn+AwaOMAX/dPZyi1MzTTwzFOTKFFdG8GDnoBgMCBLE4tVvgccrlDr5vSgnm1+4b2yiw6yUtAV40SCjqf4QXAMYSBeyl7xHOcMKEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 09:45:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 09:45:11 +0000
Message-ID: <37b5234b-c34f-460a-96e1-003677d77b2f@amd.com>
Date: Tue, 17 Mar 2026 15:15:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reset ras eeprom table when it is invalid
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com
References: <20260317082405.1725482-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260317082405.1725482-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8904caee-5198-47d1-2b47-08de8409e18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0+rR7X7SXjc3CqUcxeO+0Cq4BDjSccQ7YkEyviWK2U15rAYD//jKUQpIoR6VDuDzl0kJszxmxf77wYVJqlL4D8Ecd7su2m+u89dipAYaayIkKVnGCp2Hhpj+zv2843U60uGo6qs404yNZXiaLIhmw4uFPqcDtOh2wIV3aQUp2ikVniXizLNKTPCpwXT9oFBC8rQrRWSFSoSR3vMLaZ5KQHNC33ATT80q9V0Gme+SHwK/r6OvGJzIHPHsCCVg2xhseElH62+CrONHK1lZtfMhBmnEQ/1q8/qsaLeGB8lQe0NnbpLoiUsWzu3mFhyJiEfOy94/X5/JLUvtCg9ZFkKolP7rDSw9Cqy56awAfeKP0VN65eys9V83zj94//guUkH7HRh1d1oPuyear8pUkAbLPeyw4A3x09If2yxOdVkF3pYjpmwHOzTkdtLyRObYW1DFIlDLDN1V1Cbmgp/yky7jh/cjcX+QKqK5rJctEMgDkLLK4Dxkg1DEmSKqfYheb/iBzo0TvmhiNb2QWGmgzM6Hh2/xjaN9WNGhYjIDzjKcvUI/xXTNg/jTESXV/k3UJJcbK7lk0ju5jIQ5Y1Nn5hGzvTVkw3enkry9BeZJrXlMi4lcI3ekBXTEb90jxB5VniIZRjHNS+iEBEI68e9LK7iBmyyymIHdOBRSa7LeeXCLfosvFLA7XeuUWrL3FvOtUT99hCcWlD9/sUgh9cSYt1cLNP4pmhmAHmMh08AEfQQi3us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1d6SlhteW0xSEp5anFPSzI0WEMxNjNTbHhoTWQ4SWdxYlNBRG5aOWozU2Jz?=
 =?utf-8?B?UGovb1ZseXlIZ3FMb1EvNXJxWVZMT2tXZVFoNmRvbVkxa2V4aFB1RGFIRDJl?=
 =?utf-8?B?ZUNIVEdHc09WRkdHYWovZUEvVUx6Y3AxV2JIbjhENVQ5TmlYNEcxazNSL2ZG?=
 =?utf-8?B?aGx0QUtHWTVMcVZ5L3JGS2hYVjVKTkhsaU1TbGdTd3g0NkQrZURGa3VOVmNy?=
 =?utf-8?B?WUZVUW9HWHI5VmpJb1BYQmV0Vy9hS3RXdkUzbisvbjFTcWNwcjhOWkFSYlB2?=
 =?utf-8?B?NnVSNzBXTy9YK25ManF3K3RiYTNtL2ZLQXJubDE3c24vTEhIZERxUGpaS2ZM?=
 =?utf-8?B?Z0QyVWhHeXB2cVlQdGxIY2dpRU9VbHhLcGlJRUhJSFhFQXNQaGV5cElvMG1B?=
 =?utf-8?B?OEhkSnh1YXhLVkNuY0IxazI0Rm9KUUZzNUpyRy81Y1NNUzF4T3FhUDk5V3VX?=
 =?utf-8?B?cEs4bHgvTUppdkFPMjRCdkNZOE10RGdaYXEvMTFVRzJDdTFZc3hQeEtqRVlt?=
 =?utf-8?B?Q1hCOStadmZlWDAzK00yT1hoSWVqaXptOG0yVHhyV2NkUTFHalNERFZ0WXlP?=
 =?utf-8?B?R3NQTEVjRnprdmhmNEs5WThoLytmTWdjczc0R3JhbExjcjRqK1hncmVzTnRM?=
 =?utf-8?B?ejVOZHMzN1hmeTZCTUVScWlXL2VobGo4TW9vcVFuUnBVeW8xZzBZSzVURGVn?=
 =?utf-8?B?Nkw5em81dHkyeEVBUkdaM21RUmUrTGZhVm5LQ1dzV0ZmdERWLzdHaXQxQVJX?=
 =?utf-8?B?bFBqM243c3hEZFJ0dE5EL0tnZi94azluL2t1VTdUOXA5ZHJhUW54cXE5K3ZO?=
 =?utf-8?B?b3haVlRhOTlOSDAwanRseFEyYU14MWV6bWorbWQ0UENVUWFXS0tWZ2E5V2pn?=
 =?utf-8?B?L0V5a2hpeDN0bkprdG5kd1FObzRncFBRWGdoOGNIVmI5Ykg2TDdCOXB5dkR6?=
 =?utf-8?B?OUJDQjllL2Q5dzhvNHh3cDMrMnVOSFdhUHFiRDBCMm5aT1hOL0VLeWFQWmJz?=
 =?utf-8?B?d05FQm9qK1VBNlBuQzdNTlRJNktuS0FwWGdZNmJpVU1xV2VaVzNGeHJSbzVC?=
 =?utf-8?B?QXZOSHFhVlZlanY2QVRKZ2lja0JDQmR3REF2NzFuaFFPN2wvazdEWFhkUTdL?=
 =?utf-8?B?V3YzSUpxUDdjR2pJMGhtL0xGMVhpcUpBZHNGa0o1VEpOZjlhRSs3RnF0N0VM?=
 =?utf-8?B?UWl1QVFrbG83MkU5NFA5MnpHdGI2a0NVMGpqNGtQSm8vN0JqcFlHcWlNQTUz?=
 =?utf-8?B?WjZqQXN4bmg0NURzWWJoS01uMWpmSXA5L1hCQlJnT2RlUEdqaEQyTkhyMmhM?=
 =?utf-8?B?Q0lETlFEeFdFMzhXMmsvQzlNbVkwTDJUQytpOWY1Y1ZXNkRNanZvQ1QzVHlJ?=
 =?utf-8?B?M3Bqd0pXbzE4dGFvM3BJbmErOVJKMUtoK0xQZGlVTUxObktueXV5TVlYNGg5?=
 =?utf-8?B?R0I4cStwajRXaUVnM3R6bTUzTGtINk1pdUM5N0x1d1dRMFErSlZwTGY4STFz?=
 =?utf-8?B?aFhLSm1jNjd5YjlTc0NwQnN1eUdQSlZVZjcvcFNsWisvM0lvYzMvVEk2b0dp?=
 =?utf-8?B?OUVpNGZPUTdEOEZsemM3Y0NWblhxNWlwd01GZVpzU0tYK3NYQUlEWXIzM1dl?=
 =?utf-8?B?Z09VWUd6cjl2cThndVVnTVp3azZJb3UwY2FzN2hUNEJZL1p2S0N5ZVViNlNp?=
 =?utf-8?B?dkk1U0VORzViSXVkMTRlMlRIUk9NSTY0a2JTa24xaDFVR00wVkVDdW15Wkhj?=
 =?utf-8?B?Y0dnT2tXSDBPbUJoUEZiYTVZa0ttampSbDNKTUF1aWJ6bC9mdjZxQ2ZOL0FZ?=
 =?utf-8?B?b2g5VGRQYnRIaUJUK2x1WTBWNng2WmxiREtKZGVSSTQzUURJNFd3ZFNWU1VF?=
 =?utf-8?B?bmFIWjV1NEdvbkFsU2JhN0xBbVVDQURDMlJoTGZ4ckZWQ0FTeXNpSlg3bDhj?=
 =?utf-8?B?bGIyVzFHR292c2hZM0NvekxRNEUrVWxHRXpHZGtxVXpsZ2xrdmlwZFJMakE0?=
 =?utf-8?B?NkhlYU5VeEVSelNiV2R4RFo4MHJzWnhtSDBXYUllVDBRUG5zazFxTmozT2I1?=
 =?utf-8?B?RWVtOUgzMGxNMDRNV1FLNEl5c0ltN1RHaENJeDJHejBpR1dRMC9TVTBjUGxZ?=
 =?utf-8?B?QzRQb2FCZHhZbjJwaFRJdlAyTE5pTGh3M1lrSi83RWRuUGsyOGMzZGN6Sk5M?=
 =?utf-8?B?M3NlcHdUNWgvd0ZPUHhFd05zWHZ2SFljU2JVUHQrN01kTmNLUVo2UWRwRVc4?=
 =?utf-8?B?MHlSRk92bnF6NnFQMjVpZmpiMnZIQUxZWUJRaEZBUUozdXVIakZsSnkyR2JP?=
 =?utf-8?B?ejlEQjVzTGlmZHZldW15SDV1dmIzVHFBVXo5RW5IeVpDK0J4TW52QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8904caee-5198-47d1-2b47-08de8409e18a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:45:11.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWxBgMpHqoKr7UixWTSjw1agcAs3MgoqejMTmyZTrZe5P80BHjB1gNtz0rLohA8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
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



On 17-Mar-26 1:54 PM, Gangliang Xie wrote:
> reset ras eeprom table when it is invalid
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 6fba9d5b29ea..3e818b411ac7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1555,6 +1555,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>   	unsigned char buf[RAS_TABLE_HEADER_SIZE] = { 0 };
>   	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +	int dev_var = adev->pdev->device & 0xF;
> +	uint32_t vram_type = adev->gmc.vram_type;
>   	int res;
>   
>   	if (amdgpu_ras_smu_eeprom_supported(adev))
> @@ -1594,6 +1596,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>   		return amdgpu_ras_eeprom_reset_table(control);
>   	}
>   
> +	if (!(adev->flags & AMD_IS_APU) && (dev_var == 0x5) &&

Are these checks required? Isn't V3 version mandatory for HBM3E good enough?

Thanks,
Lijo

> +	    (vram_type == AMDGPU_VRAM_TYPE_HBM3E) &&
> +	    (hdr->version < RAS_TABLE_VER_V3)) {
> +		return amdgpu_ras_eeprom_reset_table(control);
> +	}
> +
>   	switch (hdr->version) {
>   	case RAS_TABLE_VER_V2_1:
>   	case RAS_TABLE_VER_V3:

