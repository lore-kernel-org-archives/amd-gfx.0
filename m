Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCBDCFC29F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 19:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB3A10E908;
	Fri, 21 Nov 2025 19:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EXEqnP9S";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8639410E903
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 19:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqtXxa7OsVP3qAV/9G4EyMV84nq7ZRa1dsqAoE6LiJSPfttrpsyx7AhVabomYJ+X2LMiWOvWj0qxJOwsglbPGLAD9Y3ouNVU7ZyO0H0SI8XGM2/BW2xjJrzT49elx/1fZneFI/nVF+Hi0ahW16THMcIa5dJpVXPRVOMhxJFWKnAn4hgy27IOWoZEsLhgf4KkfLnLI4X0uhMT2t/WN9q4Bz5IDALGGxG1jsk7z71dKv9AvDndU2VEBDWPmR0nPHhOZj+su78vD6ZTVfKpM3fJTPbFEaweKgT3J0/lIS+bzoi2qQYDmanX2f9pjwKyFpwPNkxZUILFJ43VTqwVkdGXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJXBJ4lW8AkULWy1kA9zBCLCOJtryclu/JXFVvDuu5M=;
 b=sw8iVHWqcfGQcMbuUxBPIJM6lIfEhmvejY5jphHVRlqnHUh1fFs6bnFTazBzmycmqqOhkcPz/Nvs0jVOM1W12CGF03KHtoerqTwepXp3lux5Qzd0b8Fes36ZKEDsxEG0nDuQ9cXcK/5Z1rX9dMP4YVSKKQmy+6WMwEbfS7us4yrCDoTiBxtXk1gM8/m0nTGawbZaLOrvbiZoPdfHS/tx5WWC2n8F6KXPoinAHZTQeAIVPdyt4mImbTmnFYK0tLuSjYoPueIoaIIHV1PwWDZU3sz8SUZMNRGw5PAg9k5f+G6D51HPZzbC8qit1eqB+/xA2ghMd6i1QSRefLerzIA8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJXBJ4lW8AkULWy1kA9zBCLCOJtryclu/JXFVvDuu5M=;
 b=EXEqnP9SPCXTjGSySawthjDV1nRXRH4bgPq0PYD1G+YmSkitv1qEx+HgSOJ/J2YFQ+w82AhlUnBMJzhlWRx8UaMVlHAK3v4Ce2Hfz8zX8P2QzrCLn3PdUqFzv0FcZqHcYxFFc9nUgFQ3LAG1dsHtO/mqQHAofPeqQN90ZmPFxyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 19:10:04 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 19:10:04 +0000
Message-ID: <0c28563c-8100-434c-83be-aeecf4556e81@amd.com>
Date: Fri, 21 Nov 2025 13:10:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Add missing newline in DRM_DEBUG_DRIVER
 message
To: Ed Maste <emaste@FreeBSD.org>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20251121151236.26852-1-emaste@FreeBSD.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251121151236.26852-1-emaste@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:5:bc::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: c7896e40-321b-4f76-b4e2-08de2931938f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpHUkdJNC9GZFM0TXlxOUtPUGdQa0x5YjE2Sk16MThQQ3NEeHNWQnJhOGZI?=
 =?utf-8?B?M3QwOW4xN1NvM1g0eGp3OXFBZUhlc0c5KzhEVTM4OFJOcnRxV29CZm5DeVFJ?=
 =?utf-8?B?RzBuNHRGOVdrY3U1bUdzWmpWM0cxbkVVc1M1S0YxVzZVN3JqZThJRUF6bzJw?=
 =?utf-8?B?dWZGN2doM2ZRMjNUdjc5U0lpQjUxK2RLZFNaYk4xb3JUU1NhR2haT2Z3cGVt?=
 =?utf-8?B?Wk5keEJzUzJETFhUVVdhR0NzbXpzeDZhakxGc21qVkpCc0ZOOTNsMVFiUkRU?=
 =?utf-8?B?ZHhFTjBPUjg1aVRZczNKQk9kZ1ZCM1dHTWFXNW9leG9MYU9VMWQ0eTFJbllt?=
 =?utf-8?B?WWxWdVJwSTdlQm5ZcjY3cWdBYUIvclpmM0U4ODAydUVZbnA1Z256RUtsT052?=
 =?utf-8?B?eXYzOEN5SWVPZ2NUWEpOMC83aVc1aUlpcFI3WkxsaysyTjJqMHhmalhRdElJ?=
 =?utf-8?B?bC81bGlrMXVSb3pSTWE3T21DZDRpNndxQVNpRDBsdzNhK29wbVV6eFBPYlo1?=
 =?utf-8?B?ZllGQnp0eS9zOGZsaEdpRzhtdU5xaFdsQ1pVYzA0MjNzZTV4aCtNWHZpeWYv?=
 =?utf-8?B?UFM0S1VSTUZUZDBaVnV5NzRITVprMXd5STZiR2MxTHVCNWVvZ3FzV2FZODlP?=
 =?utf-8?B?MUtzdWpXN2s5V0JoeGJ1Ym9HTGx5ZHY3YVY4Vm9FZ1ZYYmZZZE1hRERPdmJy?=
 =?utf-8?B?OVY5ckJPbGg0SXVqUWdkZzJKb0lMNmNnbmx2am5nL0V4Y2xpc3pNYXo5T0M3?=
 =?utf-8?B?UTNyWGQyMFcrY0dOdnBiQlhoNTNYb0lQaUFNMXFGWVdrLzhmUHhhY0xyVlJ5?=
 =?utf-8?B?Lys4MU5IUFE4Wks1YktFbTdqR0EvZGR1c2xrWTZkbk1SckdhQm0rN2pXOEZF?=
 =?utf-8?B?RmlhY2c3NjlUWG1LK1NDZmUzZGZPdVE2Yzk4cERvSnBpY0IycmgwK25Ya2Rx?=
 =?utf-8?B?RzhZM05Cb2tHMTl6U0tTWTVpS1V2NjczZEVoS0VMTlhtQ3FXVTFXbnN3b0l5?=
 =?utf-8?B?eDhyaE50N1BHaU8rc2Y2eGxqN0FESlV0M3RiM29zZE85b0swb3UyRk5XRGRK?=
 =?utf-8?B?ZHFrMWJPRXhlZWdTWjMyZ3UrblNqN1JuS2NhSTlLckt5T1RpTzFVYlM0dytW?=
 =?utf-8?B?STRRaVdtS0h2TWFyWWxFczhjTS9GYjBqOXpSVXk5ZmdHUWNNaWxnTHFlWEI4?=
 =?utf-8?B?OHpwY0kxRDNONmlBeHVnYzZxdVpYdmhXYkJ5NlNWS3V6OE5ySjlzZjlLR0hC?=
 =?utf-8?B?TFFrUGJ3ZndSOVRQMW9TM0Q0Y1k5YWxZMVRjeEloM242SkVhRDVYQmZzNENi?=
 =?utf-8?B?NGhzcEN5djJ3QTBwRWdIcktlb0Jpc0c4TmNxbDE0N2JCWnBNZWwxTVlVTXhv?=
 =?utf-8?B?Ukl3MG4rSGRJNjZmakQvWTVWcnRVT1RrdXcrSllvOE1qQ3l0TTRCOWtKRDhZ?=
 =?utf-8?B?SHQ3Q3dycjZmY3pkTncvOFFVUFZpbUNRQmFPTnYzN3FpOTJVb1dHUXdwdll4?=
 =?utf-8?B?eWU2K2JVYklYL1JBU2pIdkJ2UHpkeU1iTHFFWGhpOW1Ec1ErQ2hYcHNWTXUw?=
 =?utf-8?B?V0x2azZyZnhBdmR5RVJsTldjOUVKeHEzRzR4WDIwenJYeWgzdGI5U3ZIZ0xv?=
 =?utf-8?B?L05jcTNFL3hSZlNmN0FVLzRYVWVhUUtzSWYvNFk5ZjZPekVZNmdtSXVBeVc3?=
 =?utf-8?B?TExSV3cxZ2M4eWUydEk0ZlRldzdhaHVWWnhZb0dsN0dGdHNhSFFveHpTUVN3?=
 =?utf-8?B?TzdqOUZ6R1JkNklTcUpGTDRDUHJXb2w3bEJlVWI2RkRIdnNldUkzVkhFR0o1?=
 =?utf-8?B?L1ZGWGp0MWpxcUdjYjlKTldIT1lHSllvWHpzZjJXQi9iU0h0TUhuaks3QW1m?=
 =?utf-8?B?QWVEb3REcm8zQmJFNXNuQmRtNmprOFBkc2g4VlN2eUtPcWs2WS9ya1RUNm9K?=
 =?utf-8?Q?HgM2TxsaOrxnd2rEjtWrzpcn2OjtRryj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGExb0gzM3Uvbk1wSEJUTXlUcGs2UzVKZ0tHWk1pNDdHbDVHUXpYUno4TXoz?=
 =?utf-8?B?V0ZJdk83NURkNmIraERjOU1wVnF2U1hPQnJLZ2J6WmYzQTdUOGZWOE05Mmkr?=
 =?utf-8?B?Tk9zbC9GNEhQL2NUbk9pOEppSkEvdFZLR1M4UG4yV1VZUngvUWtuM2YwT0F0?=
 =?utf-8?B?Z014SnNveWU3anNWbVpFMURQUnMvVEtvNWR0YlEybVBrMFdoNjRjNkZwQ1dD?=
 =?utf-8?B?TnJSSlhtSkU2clRkZVErcUxqeWhBOCs4RXUvZjZRTUdGdWd5MlJuYk5GVXp0?=
 =?utf-8?B?VU9yeDdkdERldi9OdDluNEExMnFBOXdOUGhhWm5MYlBPeVJicEMraGJMS3Zr?=
 =?utf-8?B?bUdDd3d4QnZZKzNoMUppRHFwSnhueFdVaGpWMHBONCswQVBIUzRiYjErbzRu?=
 =?utf-8?B?dTVkcWJSNzVYang5ak9hWnMzOHdmUGhIenVpbWRxVWY0R041QWpNNmdjYmow?=
 =?utf-8?B?YjRiSDlsOFI1Y09GWWQ3L1FWenl1YnM2UWFFTEhxU0EzNmtCTzhiN29aemFX?=
 =?utf-8?B?MmF4OUVQWXZ6WUZzUXd1dEEydFhxUnh5d0JsTUFLSnVJdVBmWnBaUFJGZ3RP?=
 =?utf-8?B?bVdKbGVYVExINHhwTkoxU3NlRksyUS9YcW9WcFZoR0pXRVY3RWZDWFprbzRC?=
 =?utf-8?B?dlJTZThrVUZZYUhzVFRZVzVtNjJQdU1ORjFqSk1TcWx2OGwxQ1dqMzFURXFn?=
 =?utf-8?B?b2FLUE1zdXN5VHMvWGZnbEVsSmpZQ2EyTWJDc2FSdmNyeHBGTHdNbjBnR3NF?=
 =?utf-8?B?eXEvU094bFU2MVJqQnBKZVlrd1RGMCtaaUxkWk1IOU4yNUI4ZUVuQjlZZEdS?=
 =?utf-8?B?Znc5UXpWcnpRZU41OEZpUVkxLzJIWWtJS2JJYzlYSytYYlJFSUJOUUZndHJm?=
 =?utf-8?B?NEpmcENiUW1zbjFpSW5YQWhYYytXNWlTVFBKdkVVTzlxYWdIaDRZUWcvazNQ?=
 =?utf-8?B?dXNGSExEY3JDb2Y2N2NqM3hRS1E0VzI5SFBRWXJXZ2FDRC9aS3pnS2lkN0hD?=
 =?utf-8?B?NEp5QlpPaUN0WkQxSGhBc2trTlFWQmZlSDJaZ0hleUEramcveVljKzc1dUhk?=
 =?utf-8?B?bW5saVpjZmJLVjZEKzBMS3pWVVUwTXg4Z2RXY1dJMVFqWEYyUWh5T3FaWFh1?=
 =?utf-8?B?TWhwNldkQVB0Q3p1ZWszeWdNbzdoQ09VTFZBdHdBQVBNNi9FUTVsMVFxdjFK?=
 =?utf-8?B?eTRCeExqWEV4V0VoZGxlU29Pek9SeUI2N3BlTjIzUncxMnFnd21pUURIdVRx?=
 =?utf-8?B?My95YjV6Rit3NGV1V1grNExjaFlVWmQ3L2ErZGEwanJiaXdKKzBTUzBMNlBw?=
 =?utf-8?B?YS9CNlVkOGV3c2Q4WDVpT09TSzBDWjBUcFRlRmJpZEc2a2NXWFpYN0c0MjhI?=
 =?utf-8?B?NGhJZjc3cWpPSllOMWlUdTd4aTdJRCs4ZkJkUU01eS9tYUNOVWJTTEVkK25G?=
 =?utf-8?B?enJXMmp6ZlpaUmE4cE1pY3Uzc1laUHRpRnV2djl0WFVOZnNUa0tGc3dBdG9F?=
 =?utf-8?B?UUFBc3NXejlyNGhTOFc0eVE0UEUvV0lqejRMdGxESjJuVkNOTXNBNUR4dVpE?=
 =?utf-8?B?a0RCVFFCMUpSeUpicmo1Qy9mcjFwRWJDMkF0RktlT2xOSldYOHk2dGxXQ2Y0?=
 =?utf-8?B?b09KZms5Q3JUc3BmQUl0Ym5tNkV1a2lDMXpucDNCdGJwQ01ZcmwzdENyM3VP?=
 =?utf-8?B?SmRyWDQ0K3lZbEVFNklkMmlEVjZhVS9NUjVNUlFna0Yzb1NkZStIWDV0Sy8v?=
 =?utf-8?B?eDAzY2U2OC9qRGsxc3JPOVRFbUlHdUFXTDZaRE5zditmNFlXY2NFY3BzMkNs?=
 =?utf-8?B?bTNJd2RmMVlmNktzeTk1NE5jakdDVlE5NzJEQXJvVis3M0l4ZjV4Nk9zdkpC?=
 =?utf-8?B?SlRWUEczZUJnenR1M2t3Q09iMDB4Y0EwcHhSWTdSVlZucWpPQmk0c2F2aWJS?=
 =?utf-8?B?aUdMbHZnVldUZUw4WXZIK0w0cy9kMVBiZzZ4Q2lXUEpCSnJQQU8rcEI0cUdi?=
 =?utf-8?B?eVkxTUt5UjZOR01rREhVaGJ6TUhXOGJUOCtFVHRMWDBLOEsxMkI3OUVVanhM?=
 =?utf-8?B?aFJXTzdBNWh4djgycmkwSm1qaDZQWlBabitYbHh5aEhYL1E5M08zN0xGVmZh?=
 =?utf-8?Q?4oSfz4NDpIB2LhtFYSx95gsAA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7896e40-321b-4f76-b4e2-08de2931938f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 19:10:04.0666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rmx0IMFZLNWh0VvlUITBPgPXzwGc+WhjqWwPnZewDUlvplAUquHd1gvvkK4UStqRef3xXphJp4OxeX9bFg4RAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1
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



On 11/21/2025 9:12 AM, Ed Maste wrote:
> This error message was emitted without a newline during bring-up on
> FreeBSD.  Presumably the error doesn't occur on Linux so was not noticed
> before.
> 
> Signed-off-by: Ed Maste <emaste@FreeBSD.org>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, I've applied it.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 6c62e27b9800..d8a4e918846c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1109,7 +1109,7 @@ static int amdgpu_acpi_enumerate_xcc(void)
>   		 * one is not found, no need to check the rest.
>   		 */
>   		if (!acpi_dev) {
> -			DRM_DEBUG_DRIVER("No matching acpi device found for %s",
> +			DRM_DEBUG_DRIVER("No matching acpi device found for %s\n",
>   					 hid);
>   			break;
>   		}

