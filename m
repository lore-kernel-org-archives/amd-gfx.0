Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9129AC7115D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 02:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C55E10E0D5;
	Thu, 29 Aug 2024 02:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0wHNJR+D";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FC210E0D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 02:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/OvvQbW+zQCGPTyJxvPEooBjhQ6nDbVM55r+DBmsNM/IB+h5SrX4MT14JIiUR6/lMvZ0PzKE/fqONughelAd5Xahzf8W5YKvqBs/T5GtpwFaBMDq6KendxQhzdZxKlOY9+CdM4sekv21OmkhSTvOG7Nn/8h/EO4LK3+jGF3Ea56hU+Ghh0/Wbx32hHw3dQ8aSPeWx7W1yPzgScsNYAaXSH3kdZsa08VEZDqEx3u96wLi7JLo+Qa705/V00EHj98AskUdQhgrXydo8kPbcTaHB1+pMXyEgb3jGySRJ5psAdXyeBU1mSy3F5KE/L6tdpUwLD0U77VUIXAVMXQJfNYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOsWWDYDewPKz6bBIvYoyMUeK1O1rOtXgzNodx/aOh8=;
 b=PAT7x4EubTO/v2bDLF1ZdB7DMLx3RvseKilG+diYy6jvqCeh6GehkftO+Mb5k9f1IA4UyyPSiOoM1G3Jaem7o5huvFQ1lggNkhES3J4ewc/giK4Lg8+7LwKvYa9dwuMgTVhGsgZ0eFRPCFECt/JCmpqtl3egfaxsnxrPEUcx7KWUGVY7YH68JyJ0l4igYoxoLQmL11KIZ4mgBR66aBvq7rBamgWnXsHlA5znRixZoiazXejJP+XCPAf9AuqKGalb13y0WeYgc3c/iBtA8z/kzZsyNX3EpsZ5GCQa7hevgsl9OZQXkjAjRFqJhVArX6eFEg3aCfTKFvrhIoVwS5mj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOsWWDYDewPKz6bBIvYoyMUeK1O1rOtXgzNodx/aOh8=;
 b=0wHNJR+DR9lWSGRjiKBGPa1e9h9XzYtiZguj2NJIccwoKRYbl6UwhIqskG5cShfldHwBDiCoqeDi6pRNYMbTPNX5lY6dKNib7Hjr4wyEmxK8H1MPoCkeQifYL8E2OaS57E/a+3TYlKZm0MH7NT1eN+lpYTQ+oE70PhB2YECZy1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 02:55:31 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 02:55:31 +0000
Message-ID: <6848c9d3-05ef-467d-b289-c8367f55fe78@amd.com>
Date: Thu, 29 Aug 2024 10:55:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add missing kdoc entry for
 'bs_coeffs_updated' in dpp401_dscl_program_isharp
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240828112559.83911-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240828112559.83911-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0120.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::36) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ec7a7f-ae3d-4d00-b6f6-08dcc7d60bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0pnSzZ2aGhhSGFxYW9WRWlQLyszcEgxRkhJaytvRUFyN3Rsa0lYQVJ6UmlS?=
 =?utf-8?B?bmVuT1ZMakN5KzVib1dMQy9jamhDdENWWm9UZUhtRmZBbnhBZENlR3IzQzlz?=
 =?utf-8?B?ZGRvRTU3ZU9aRFJvaUVsSDVKajd5Zm5ERnRQZkVmY3YwZjZuNElkeXE1elZ4?=
 =?utf-8?B?MUc2VkpPVm45U3NwbXY0V1RuWTNjTWl4Ymx3MmY1UnJFMFAxcVR6UjJET3hs?=
 =?utf-8?B?ZjFiR1Nnb1V0UEFncEhFTEhRb204MHBxb0RoZnQ1VElLY0UxV1dVQlh2SHpM?=
 =?utf-8?B?TE91bzJKVm1MLzFqSUVneWxITzZ4bVNvYjZtRElWcS91TWhjZEoxd2U4cllS?=
 =?utf-8?B?cE1sMDI4NC96T3RiTGRiditWdS8xcVVsQWtCVnNCaWtVVnRDYzdSMWREN0RH?=
 =?utf-8?B?UzdEajlRVCtFeHBSc3RveXgyUDFTb3FwZ1pjdGtIbGdKYi8yRVpldVJOTlMr?=
 =?utf-8?B?ZTFwWVFhWDI0VWpxMHh4U005V1B3TTRYN3N6bURWMzJzYjFRejM2NndqbTdw?=
 =?utf-8?B?RjFrbVFJMWhqa0I5MU56V2g4VE1PeWwyOGRlUHM3MVRWQmNZdUtuSzQwNXFs?=
 =?utf-8?B?SmhVcE05cDdDL09JYUg0bWxJQ3ZyWkQ2amJGM1NGeUNxNWJNZ0o1R1ZjaWx0?=
 =?utf-8?B?eUUyRjhVaFJ5Q2pMcy9xSllKSHZIOGc5V3FvSVRtSmJMaVo0elpxNkNWbUY2?=
 =?utf-8?B?b0N1THBqam4reGJHMzA3RGg1MHJiOXpTcGk2a2hJL0JuM1BwZC93cHVSaGZE?=
 =?utf-8?B?SUtXOGNFZE9LS0VOa3Y5SW5YdmVjYzkvc0srVkFyVmxCZ3pFTjh1M05rWDZa?=
 =?utf-8?B?dS9OYlVJOXZTd014YzIvTkU1VnE2aFM0VEtQcXBZR1hLU25wTXVvWEVJODls?=
 =?utf-8?B?N3Rtd3pjakdScjYyMFR4aUowbytjL1hHZFl6UU9haFBwQTAvek1qNFRNdEhm?=
 =?utf-8?B?cFhBbG5xdXIvTHN1bVJ0OGVOLzh1UFpBMEVGUVdUYTBrTzJUMVhab3dwVUJV?=
 =?utf-8?B?WFB0S0RwbHQzZEttTDRaV3NQS2J4NlpyN0gzTWdWN2dqQXpQUFpMSDF2d09D?=
 =?utf-8?B?Qkdrc3hxdkpZL0doU3BTRzc1WmZpUENubUJzcFdpSm9LdVRjQ3lHdi9vb0Vs?=
 =?utf-8?B?dVNWc2Z4N0Q4dFBMQXlrMmtDRVV0VytlTmZTdm1zK3VxRlJmdXBlT0FzWUU5?=
 =?utf-8?B?WG5hcmVmUGVMOEtCRDlYQ1lKa2EwZ1BKcFVzZHhJalVZa1UxTTJZUUJXOG9O?=
 =?utf-8?B?b29KbWphUEw3TnNRWGZ6elo0azJuVDBabWpPQmlSRHBDeEloWk1GMVJtUnRx?=
 =?utf-8?B?UjlLRDZYVHJDYlVZdmpNUVFMVEFHQy96UzFyMFBITFFhNVYxNnVhWkdhSnYw?=
 =?utf-8?B?VWRxOWJLUVhtT0h1Rm5RTVhNRVphWlprYTAyaWxnN2ZPbFVjRFVaQW9xR25P?=
 =?utf-8?B?Tnh5VkwzMzdzLzVZMFYvR0Y4UWpPZ2VTMDdIV2UyUisyYUUvaFlob0JhVUlp?=
 =?utf-8?B?amkrTVIySnJvTWJvOW5QUTNweHdUZHFGaENuNURFQzhMQWxob3hMb09QYmZ0?=
 =?utf-8?B?a0hsTEQzT0w5NzBoWmFmSlRWNU1ScXRQQWNTKzBWaFNScHphb3pBdko1Z3VX?=
 =?utf-8?B?NnF3dnVERVUwOVMrcXNwYWZQeEV3cEFUS0hwUXhFbGxRYXYrcTJUOGszcmpj?=
 =?utf-8?B?SWxLREFyaTU3SkdjWldTZ3NkcjRnUXFXRS96emdhRnQ0L3MxK0FPZmxTb0JF?=
 =?utf-8?B?a3JQVDZCSkRZazREZ0VjeDZ0UW5lNXRpVVJEdXZIbVI0MUxRUi9wOFg4MUQw?=
 =?utf-8?B?MFBWVU5LSVhrZkp3Ukhodz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Z1Nlh1aEM4bFhmQVFsWW9RVlJBeVhhNUJPelFxWHluQnpPckMrb2tRanBJ?=
 =?utf-8?B?SFoyMUhWZkZJeENRKzdEcDVQdEc5ZGR2MlpIc3IrV2l6TkhiWGE3M0k5akpz?=
 =?utf-8?B?TlpUSy85K0w3WWp2WVpnSFNTcFFtZ0tIMXkrenQ0eFJheUcyTGV5ZHNxOVhT?=
 =?utf-8?B?ZURGMEc4UHQzeVErdUVFV1QyNVJTZ2JNVkR3cUxvNDkzTkpNM0hQSUk1Q0Zm?=
 =?utf-8?B?d0poaTNWM3dFMkFmTzkwN2ducUFUMGRIS3IzSm5tV3YxTWZxTDNzZS9PT3cz?=
 =?utf-8?B?L2RkRVF0RWlLZ2VaRlJER1B4U09mL0N2dXE3d1VtY0tyTGpVTmI1ckFPVEw3?=
 =?utf-8?B?Y2R3emZWWlhrNEJnRVFicjMxTUtocWVYbjBOWHc2SDNsNlp3a1JFRzdMQ0x4?=
 =?utf-8?B?aFZBS3pkYlYwajhuTndaNGMrYjRESUMzSjk0TThZeXlmc0JoaHljbmVYbjNn?=
 =?utf-8?B?RnRmNU5qa0Zsdlpvc2V5a1JmWFBuNVR0enloellYSExGMnptWm5EOG9wU0Fo?=
 =?utf-8?B?YWZqYS9PSFUvaUJhWVptZm1qQndiN1k3bFE4M2R4SmtNdThweU9scEJuTlVX?=
 =?utf-8?B?R280MHJGWmc4bGw0ZWZaU2toV1FVTjF6N1hFU0h5NnlCWVhyYUFUWkVDNG9G?=
 =?utf-8?B?d2NhbjJkSFhmdHljemxqSTlBSXZwenZlektNRndrdCtZRU9WQlJQcFVzamlC?=
 =?utf-8?B?TDZESUVYRFBzYURNLzV6Y3BSRUNKZ0NBUmVsblB4Y2NPKyt5RHZQSkR2THYv?=
 =?utf-8?B?bklPcHpSUzZlRGZOc0orWlpFYk1vaHJnVHF0cnpFaW9sMlJCeUdCa1p4bERy?=
 =?utf-8?B?blBuSDlFSzVGMHIxS0szSWdhc0paZ2lGbUx5eXRoNkJSSVZod1JpTWEyQld2?=
 =?utf-8?B?UzFiWW4rQnA4V2NZcllHUVE5T2htQmpmYVh6ZzVTQWtCMEI2Z3NubTQ3dy9n?=
 =?utf-8?B?UHRHdkQ2K0QwSmZJQU55VVVWMmQzU0tzdnNiRkw3VFhKOC9WREh0akI0Uzcz?=
 =?utf-8?B?cVo1dC9iclFDV2h2QlNMV1hhSE5WVmlXc2xuUG10VnlYZzZFT1hiYlRNTzVM?=
 =?utf-8?B?V0VHN25XSWd3YXZ6UmpnRURrQVNIOWF5VjJnN2w3TUFGN3lJaUE3emx6V0x1?=
 =?utf-8?B?bFpmZ2RSNC9NSC9CYnhrdFg5Wk5MZzNSYmFTRU9Rc1hIYmxmS21ibmw4dFk4?=
 =?utf-8?B?ZDVpZWptdmhkWHdlSkpXSnExRlptMHpBUVZiTXlCRDdzVzBUNDRpaUJ6OWJP?=
 =?utf-8?B?L3NkSzhFTDJzNHZRRDhYcHVJWWFmdnF4S1IvL0pLVi9ycVVLclJDRmRmcWdk?=
 =?utf-8?B?Vi9KalhYNWwxQjBEUDdmczVGYUtLdVM5bjlEeU1ZUXB3OFU2cXp0OFRoWktn?=
 =?utf-8?B?eUhYZ3pVMC9adncvdmdydzZuYldJUlM4eUZZWndZM3IvWkF6UjRVQ0JyUEhL?=
 =?utf-8?B?TzVnSCtJdWVIaXo3YitlYXdYM0d2b2FkZGMvK0ozdTRlRms3WFN5TW9ZNlVL?=
 =?utf-8?B?cmV1eHpwVlZxYzF2STRKYTdxSmYra0lKRDVoTnppTHVFcXUxRFBtNGFHbGpR?=
 =?utf-8?B?bWhsN2FoSjVCVHgyWXBLZ2NvNnBzK093SU1VQzk3ZlNBbFpDdE1RL0dXaUpF?=
 =?utf-8?B?T0swS0lLd1pTZnhoS1RHZXhlOU5OemlJVXpZVGdWSmRlcm1qaEp3M1RwRWVG?=
 =?utf-8?B?Q2pzNzZHTmVNNkRrS3RRSCtyeEdsU0JURXBHclpEcFVIZEtOSjJteHVEcmZW?=
 =?utf-8?B?RStVR0lMSzhMWTI3MWJXV2pEdE1zQXdqS21jUmJmcC91L0JHbUJmcjR6RWJ0?=
 =?utf-8?B?N3ZSTmRZejRka1hoTGxlMStuWFo3NEJzT2F4T1ZuYlo5UldwRm44elR2dk82?=
 =?utf-8?B?K2dEU2VKZnh3YTJCZE9qOXg5NTFSQkR0cXk5VHEzZDFaRHhrZ1FzZHRQQnlV?=
 =?utf-8?B?Nk9kSDczQ2hVZDNkYncxZGJXQURuNXN3MzlnaEtLcFBnT0dCamdrK2NZaXZu?=
 =?utf-8?B?M2FjTHY1TWxtdU5PQlFEUWxsL0hLcit4ME5XYzdhUDBrRHFETGpJR0Naelly?=
 =?utf-8?B?UFB0b01xWnVQSVlPZUFTUWFNMlZ3RFRNbWpjVkRGYXc5RXUzTlZPbUZINXB2?=
 =?utf-8?Q?IXKzKLReP575abXKUdOp7yEFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ec7a7f-ae3d-4d00-b6f6-08dcc7d60bae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 02:55:31.4834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyCERkzBYeQEeESXODIR89D9mimJvyqXKwUoaICUb4Z6hdn5pYOZQ+Xhvtg6MPozf5kDzdyRpJ40EEcgQ9vZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

On 8/28/2024 7:25 PM, Srinivasan Shanmugam wrote:
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dpp/dcn401/dcn401_dpp_dscl.c:961: warning: Function parameter or struct member 'bs_coeffs_updated' not described in 'dpp401_dscl_program_isharp'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> index 703d7b51c6c2..3a3745597f0c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
> @@ -951,6 +951,7 @@ static void dpp401_dscl_set_isharp_filter(
>    *
>    * @dpp_base: High level DPP struct
>    * @scl_data: scalaer_data info
> + * @bs_coeffs_updated: coeffs update flag
>    *
>    * This is the primary function to program isharp
>    *

Maybe use the "Blur and Scale Coefficients update flag" can be more clear.

Tom

