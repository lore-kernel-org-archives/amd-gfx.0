Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A10C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 11:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8F31135E1;
	Wed,  8 May 2024 11:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tpDMbuHA";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565091135E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 11:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfWHPwt78YmYW7BvRxTJ7uusk1oDU9B4FE/DoAi/QmIkNcF6sqUoqa+0Gj1QiLRLduwMx+KORy9kO9h97OZY/6b7XZt133GlaSlDrsdNTJ/MI5j4NxseurDwaGbRidjEtPcb5RkaXdI7iTtRP4kJTeqbElWU2L6XTZhEPAIu5fJzPGbchgsC6pKBNZ27aP8O67i6qpxBWSnZDVW1hJ+HY1tjnkQP/Lk310sC2jBFZSHbVBcFEE8H35K5QlpMfP91kGJOJnxRJ0wY/UrIcgzRF4UFB7eS9nIoEGogOMdvI0wiGSC9zDZ7Jqr+5wsnzO9KPoT8P0dyo065o+zO08Ur2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evc9vKXnXtbA0U9vIIQvBnBCGvD1CWyvFaKcuCiun8M=;
 b=SL1H76cXKOvQ2HQA8ldkPxvqoTa7yiEt22DZbMcBReEt5uCAV4cswJ1ryqwVhWOfZnpFVoaXic8RBSKH83p4oHOAp+h2U5C9iALK2bGw7ImAEE+rNWD8VJjNAkyuYfgeHch3RdizEtqM9lVDPksSfjIU4A/l9wPkjKmHXXMO/GqeVALRCdeIToGXBJ0+LxnJ9LeCLt5feyYYASzbMJDadlDpJnV87X/w3WAUOvoiWys7IlWp/iBU+bYXBB8xy+lURiNOz3oXHU4+jj4p0b6QzvwfFcWx1Ba1JPuy6qAo/ra/buhEGjQA+BtJoInMra73+KeBg9Wc605Kv1yZDle99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evc9vKXnXtbA0U9vIIQvBnBCGvD1CWyvFaKcuCiun8M=;
 b=tpDMbuHAj2BuDQrAxWpKjkhCF0N7Rs9+/zs48trorDlEKYxFXWaupyjo8LiXQuSLsM5aoXPm0GAPZuRHk5AQWY983+00x1DLJVigjXIqJJCmR+BKxUlgYz0jJtYAb6W+UKjhIi1d00AjUKafX6EpjjBn3sE1/zf9FhxYjdSqbww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 11:38:56 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 11:38:56 +0000
Message-ID: <81965a6d-2b59-4565-a49b-6a363c6bb8f8@amd.com>
Date: Wed, 8 May 2024 17:08:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix truncation by resizing ucode_prefix in
 imu_v12_0_init_microcode
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240507164446.318263-1-srinivasan.shanmugam@amd.com>
 <20240507164446.318263-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240507164446.318263-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f2eba9-a71c-4dfb-d625-08dc6f537162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE12ODlRUGk4djJsZXppcENBOGxFYkZPVWw0Y1BDcnF1SUc4VjNXcTNhWEdP?=
 =?utf-8?B?U0RzZWtxWGJPS2dNQ3p1bXpkVjg3ayttVUwvRnMxYi9kVEx2bWhQVGJMMGYy?=
 =?utf-8?B?SnJtdk1DUjVXL0VXelN0cXZOY3MyL1dUYzFwZEMzWEZjTkx1YXdncDNoMGhK?=
 =?utf-8?B?Q0ZnWUY0Vys2TkRCRk5HTWhKeGozUllaZ21sSzQ1STZPSXB2eHF2Wkh5c3VN?=
 =?utf-8?B?VHczekcrSW5WM3NhODVXZHVhSlFpV3FsaU9FTzNFWlVpeGxwTEp3MUFmVHZY?=
 =?utf-8?B?d2lVQnpVOFZUcnJjbExkTGk3R0VwZW1rUm4veEtrYWxiMm1SVUtzOXl6NXlB?=
 =?utf-8?B?dmprNDREV0pxWEdvT09yWGJlN01MbXlhSkdtMG5FTkk1OVZxV0paQzBRbzBz?=
 =?utf-8?B?Ni9BN09TU1drN09DMUlJZWduWU41cmh4SWxleVNNL0FJaEVaRFViOCt5dWl5?=
 =?utf-8?B?NW0yN0phRklkL050WUhIZ2gxNWJ6eTRmZ1RQYVhzNWxGYXkrUEN3dGFaSFlY?=
 =?utf-8?B?Y2Y2UGl4SjIycjZtajZCSTJHVDdQdzlJM2FYaXRZQWRaNzBCcG9kcGVqS3Q0?=
 =?utf-8?B?b01YVzA3QmJVWS92YVFTMjYxdHJmVkM1MmtoT2h2TGJubVZUcWw4amVPR21a?=
 =?utf-8?B?UWlYV0w3UFZjNUdoTGNXUk56N2hINUUvUkkxWk91QS9aWnc0SEtIZW5IMTc2?=
 =?utf-8?B?ODZKZG9qSUN3cmRQWFRtbDNsTTlFRzEwQWlTUURYYUVRRVUycUE2VjBaVVlU?=
 =?utf-8?B?QkV1TFFVeXlvN1pUYWNqTCttbkU0THdvR2VlMzVQbTRjeUhFRmhXUkR6cGZw?=
 =?utf-8?B?dHUrRjNLUStURkFlcEo4SFM5b0lFclZydDNpamhYK1pMaVJ6MGhMR1Jmbm1H?=
 =?utf-8?B?Y21IcnN0aVE0THA4dmNCNnJiRnN3RzVxbEc5MUJ1U0J5Q0pKc3NpNXRVRzZh?=
 =?utf-8?B?VTJJMnJWTmJVM3F3ajc2MUFkQ0U4Um04SE9VS1FabHVvdk1SMnN1NTk1d3FM?=
 =?utf-8?B?ODdKRUxHZ2lobFo3SFZDNFlYRkFReW5jT2JhV2tQdEM1SXJoSk8vdVp3NGdK?=
 =?utf-8?B?WHJWdHJPRHJLUEpCS2JJdDJJbUxhTUJqTWZPSDAvbDkvb2NTdkh4a1ZsOEZ4?=
 =?utf-8?B?Tlgzd3VEZ3ZrUDR4Uy9SVCtWWWE2cG5WVmJDZmFVN2pLOWNrSGNFUzAydXEz?=
 =?utf-8?B?c3puaFhwd3E5U0c3Zmw1SEpsSDVEa0xHKzR5UDNpZVErbUx4aVBGcm9Ibkh3?=
 =?utf-8?B?SmZyWGRMN2hHQUtOK1UzSTEyRjJOOHQzRnNvSTVBNG9ROW4zLy85WDV1QjRp?=
 =?utf-8?B?SFRrWlhMUXJvNmsxU0ZMeDlNRnNMNEVzTjUwdVd6V0ZzWmV6TkZEbnhWQXhR?=
 =?utf-8?B?T0lKTUZSNXNmTjJldzkyRWdWRldOVlJmSDlsUEdSV2ZRWGx1dTlkWkRobHY2?=
 =?utf-8?B?MDlXMld6MDNVY2NuNEZLQ21VMC9lTUYzRmorVzg2UFRDc25FL0ZCV0dUSjdz?=
 =?utf-8?B?V1FiVURqMUVENUt5c0ZzWXJsV3B5VnV6bUFVUG5raW1RckU1dnJIRE1hSjg0?=
 =?utf-8?B?cHU4QmJsdXNRODlCWmxHUVlPaklaNE52c2x2ZGJTN0RDeHMvY1A3eTI0c2FG?=
 =?utf-8?B?YzBTN3lsWm9kUGZ0Y3lFME5uWG1mZXJEYVNkRDBvNXU1MVBXSzVZNmNZY1Iy?=
 =?utf-8?B?Y0ROcmlNWTFlQ2hKa3NFd3NBdDB0b3QxbVhSZ0Q2Viszb2NaYlV4ZEhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZVK0pXWmZFaEpLT1dSZ1hpeU14V0dmVXR1aityVXp0YVU0V2lCT1NVMkdk?=
 =?utf-8?B?cktYY2JvWU9lQUdDd3ZqVVE5NW4xczRPZ0I2Sk1oQkJKQ29NZTdkZTVVbjFq?=
 =?utf-8?B?Snp1b3BYYTdHQ1lnSjRRQmhDbmxRbWtva0FlVkJZYlYxdWsxdFI0K2dYWmM1?=
 =?utf-8?B?OFpudGFCYVBYRGVDTjh3TEpDOTJkOXNSWWR5cnlERWdPSm5zVjRTM2g4TlVM?=
 =?utf-8?B?WDNRWkZONFcrd1VlSFJFclJrekVlS3EyVnZBaGNDOXd2bTB3eFB6dWU3REsy?=
 =?utf-8?B?TFpSbkpjbUE0bWw3TjBCQWtjOXI1cmpQR2FsSTkxNXlxV3FoMXJaWERqYkFq?=
 =?utf-8?B?SlNFeGxZUUJBc2VWZnBqWHI2akxpVnU4QTN5MTEydnY5RnRtTjQvUWJMQVB4?=
 =?utf-8?B?N2NueDVJbTFZWTR6cG91UHBSNE1XTFhOUU9zK1Z1NEJBcGhxZWRtMU0rZ2lK?=
 =?utf-8?B?TVJVMXh2dzZJckcrS24yR09vNk9LWFNET0dycjBmT3BZREhKSklOaTlhUHNO?=
 =?utf-8?B?L090U0FTb09CYklxdlBHMG1tTk4wRUtKQi81MjFpWEhnVkd6VmdHeGIyZWc2?=
 =?utf-8?B?dVdrTzJ4NVg5RndhMFZxVk9MV2pwKytDeEx4bStrTjhXMVI3ZW5FSDN6YTNX?=
 =?utf-8?B?WThPd05EaWJ1U0kwb01teVFQV1VMR2pTM1VMdmJSb0U3NjZyOUFJdlZqdzV0?=
 =?utf-8?B?dHFJSld2RW1ObTVjVWo5RUhlbEhiYzBoNENRalZDMDNQUjBGaVVmcE42Q2xI?=
 =?utf-8?B?SkJWNmpKK1BsNzl3dFUwU29hWElLODhFS2drWTBjV20vNVpwclptaW5BM2tN?=
 =?utf-8?B?bngzeG5CdWFUTDUvRVZUaU9icWFUVUtFUXJ0ZEtaeEQ2NDhTdWJJY2pwKytZ?=
 =?utf-8?B?aHlkcjlpUUIxdk9sSDZmY3h0Rmc2bE1RaGZ2dTlQNldFenVGazQ4WjJjVTRD?=
 =?utf-8?B?TGVLMHNDQ0VWbTZiczN6akppd1YwN3BpNkZPRTA1cjRuUEN2RTlLZ1FGdEFC?=
 =?utf-8?B?cDlPYmJFdDRKcGlWTEhIR3IzMXNaN0sxcmk5NmFlOUkxK1FUUjNFVHVlRlZq?=
 =?utf-8?B?Q3BlTUtvYmdzK1AwemhwNWVuTEQ5WUdpOHRwakFtbW5mZCt5RTYzK3J2S0VI?=
 =?utf-8?B?dFNDekJGa3pXVlpKTWdQNEJGNEdGWGdza21iamE4ZCtrQWZLWUxmeHUzWnUv?=
 =?utf-8?B?WjQ1VHJTOVF4TUhzZ3ZNUnpQQXFnQmNVYThLbHNKZFc2WDBBR0dyQmI4MGwx?=
 =?utf-8?B?azJFWkRpWUp0TjRhNEREYkhGSk9ZTTFQSXVDWDFxbDZ5ZWxqcHFuY29DMFRn?=
 =?utf-8?B?UlJkYlAvUloweFYyTEU1T0xrZkpaVmFXcXd1WUJqVG9RM2QzSUZMM3Jxc0RD?=
 =?utf-8?B?cDJMUzlzMHVjdTVGWkJtdFlIVWs1eTFFRFNlaC8vQ015dm9ZUWhDYVNNdGRJ?=
 =?utf-8?B?enZOTVdQZ2w1QmQreXdRTHBQbzRHelJwV1dUZjRaWlA4RHI5VlMrdmJXMndJ?=
 =?utf-8?B?YjlEM0QxZ2pIUERqelNGUDhPRm9OdWZOSy9NazNpaG1tWWFkUDV5cXBXNTN3?=
 =?utf-8?B?VzVROWkvZHBZZTlFbzI1eXpBWmNpTm42WnYrQ2VBZWN4S0YvRjhNNDFmaHR3?=
 =?utf-8?B?aS9wQ3c1a3lKdTI4bGV6UG1GVGx6aUhNTHpBVGZHblc3TFhIYVJDTXM3c3ZC?=
 =?utf-8?B?d1RaZjRGZmdOUWtQR0Y5cjh5WXVEM3Y1TDgvbGFOVmVFa2RuWVlJVmhJOTBP?=
 =?utf-8?B?V0I5bGovdFFXTzB6ODRRUVVMVmdCUHp4RzduMTZmVlVzWXhqRFE4SW1RdVFJ?=
 =?utf-8?B?T21OMmdDTnYycklmRlNCdXlIRm1xRG0zU3NNUlM1REp2MVdybmhoWTJGS2ZY?=
 =?utf-8?B?ZzdwZUxkTDAyVUN6K3ZsM05Vd0VaeGlmSm9WL0xTVUo3K1ZlUjRrQjBIWjF3?=
 =?utf-8?B?c0xiQWREUWxZdjlZVnpPbXRzZ2tqY0NseWJsVG1ESVZwaHkrNEdFWWQ4aGFE?=
 =?utf-8?B?QTVmOHVCOXFHc0FXcHk0d2xHcHNPdW1aNG5WQXY4czVicXdSb0RreHcwTzcv?=
 =?utf-8?B?YnlGVkdaQklkSjZ3TFVtZURoQXRCMTAycXY1VHZTWU5ZN0VXQlN3Q2xZMDBQ?=
 =?utf-8?Q?1f1Vwjmay+NguyaFYm7+S5nhf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f2eba9-a71c-4dfb-d625-08dc6f537162
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 11:38:55.9115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dWoIfcsqQ8IPEhe3H46JqowX1McNfMuAdGHyJEkSuWFlCF06L8JsOdO7xagFM00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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



On 5/7/2024 10:14 PM, Srinivasan Shanmugam wrote:
> This commit fixes potential truncation when writing the string _imu.bin
> into the fw_name buffer in the imu_v12_0_init_microcode function in the
> imu_v12_0.c file
> 
> The ucode_prefix size was reduced from 30 to 15 to ensure the snprintf
> function does not exceed the size of the fw_name buffer.
> 
> Thus fixing the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/imu_v12_0.c: In function ‘imu_v12_0_init_microcode’:
> drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:51:54: warning: ‘_imu.bin’ directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
>    51 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
>       |                                                      ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:51:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 40
>    51 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_imu.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/imu_v12_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> index ec2a4613567a..032ae12b2be2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
> @@ -39,7 +39,7 @@ MODULE_FIRMWARE("amdgpu/gc_12_0_1_imu.bin");
>  static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
>  {
>  	char fw_name[40];
> -	char ucode_prefix[30];
> +	char ucode_prefix[15];
>  	int err;
>  	const struct imu_firmware_header_v1_0 *imu_hdr;
>  	struct amdgpu_firmware_info *info = NULL;
