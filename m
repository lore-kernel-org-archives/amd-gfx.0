Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE2FC0219D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 21:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EAC10E3D6;
	Mon, 10 Feb 2025 21:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S7drK5Tc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBE210E3D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 21:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ffi8ygVBXB1Q6dnLYXh7ssoNC2ERJAtnjnogBqAwxe/CqD3bB+dYtgfHa9KD5Tf5A5pc2mj3G1mlqEA4EQBCBo0I4eWQrLc7VSQfSobPi6U1j+TpVhnEJw7M9r//7tRDXKLJaBFgyEAQ3clSZXQuPH43HvmOkIOzxXSQo+vBhX0NJss+1QsOieI1TeJP+MrHj0Zby8INFWQgUfZi2zu0FpAPhFGfIvSszsjjU9VjPEgaKEYIcIgGMTIAj7KB0diwB62G2C8MTTN2SoTKdeou8jZSMXqU0Uja9RTDRdtlsdVNv31xj3xjy1Synz/p0p3b6xQVQeq0X4yp40PJFj4stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtK4WqrwK6/vEBWIH9BK6jsFiXQSUbwvt1f5aJSRSC0=;
 b=tPJg/EEgEMPoWbLEJ8n9YB3kEbHv/9r/w+zi0mEtdlOBq7PVwm8woDhQVWp083EPdZTfR2JGEUb3TTxY8IBCeILTiNTKe6LIfI1A61877vczPcJXx8Gi6JbR8bGXMOzRjsrvGB9aBuf9xIn7CW/cpBR38/M64FHke8GZiFOye8ik8L0ahHJI4rwtL6YaO2+Trg4TbYpHXHDDNgPiomKMTQ9MZ1la/skWGIHKGHIJcNjSR0C09Hctzlaf8X79O5/PoEiIYTH4P6Nn2iuBcPr1XHCXQ6gp9lieodyjQVZKKJVyrVQYRaxy5MoM2FFRtliJR9Fm2T4OAMOtRSjGSOwSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtK4WqrwK6/vEBWIH9BK6jsFiXQSUbwvt1f5aJSRSC0=;
 b=S7drK5TcVxMQKCzh2ubLEvrVmX1v8+Ok8t5hwobBL9+6j2mRJwQtkgVYll0dqtgmLmWBjy3BZASF8WkuF1HKn46o6mLTz5u9IezbKxioRhH0Jv1h+obG4KQeDk4Y/66jFni+XNGwERh3J1Di3cSn6XdbpSbEbJYrVyiKrdhh81Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 21:18:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 21:18:28 +0000
Message-ID: <afbfdf43-447f-48f3-aa85-b1071188ff20@amd.com>
Date: Mon, 10 Feb 2025 15:18:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: add support for IP version 11.5.2
To: Ying Li <yingli12@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex <alexander.deucher@amd.com>, ray.huang@amd.com
Cc: Richard <Richardqi.Liang@amd.com>
References: <20250207212734.1986678-1-yingli12@amd.com>
 <20250207212734.1986678-2-yingli12@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250207212734.1986678-2-yingli12@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: bab897d0-6d37-455c-495a-08dd4a1876b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXpadDVLNUZVM2J1SGFYVU16Mm1GUG8remRoU1hQelgvSDR1Q1YxOThjanRI?=
 =?utf-8?B?MVBLK3ZCdjRjaDJIdXRxZkFqSWZpUkw3aDlhVUlJTmpuRVdjUW5DaVlRL2t6?=
 =?utf-8?B?dkMrbk92VTJVUVVhU2twKzJtbm0wU1NqRjJPV0RTNnpOOFovb0taaXFoMHNs?=
 =?utf-8?B?eG1vTmh1V3BpbStid0tsUExMeHVuMWRFNkVGeFhrSEtZNzR1R0tjamFuTGx0?=
 =?utf-8?B?WmI3TXVpZmNuWTJwZ3dvYStqR0V4Qm9uZ2dxOVpuZHI4cFVDek5qVXNRRzZY?=
 =?utf-8?B?VWQ0Ym5qYm4zNlZ5UmtkK1pNUGM1eCtxSmNPMXgxWldZdXcyUlJ0aFgrS0s2?=
 =?utf-8?B?b1NrVVgxUHk0UitHNHg0eGJDRWNjZFBjVnI5SlVRaytqeWlHM1hLVVNnL2lL?=
 =?utf-8?B?bHVvakZnNXhaUTNoaXhGdzFSaEdlTkljZkMraEpWRVp5UUh0RmFRZnZZOWhh?=
 =?utf-8?B?T3B2TEhnRDd0M2V0bjJnYU1GaHcwT2JieHFDdU9IUjQrMjVRcEpkdjFQUmZW?=
 =?utf-8?B?QVFweVZjKzU5RklWanV2RE9pWGUwYTR0STB3RXFJYStvcWRpRGpiVGgyVGRR?=
 =?utf-8?B?MTNOQW0rdmVOTFFRT1VFZ0pHTUZhQUpiUUw0ZERPYVRBcUtSK3lTV2Q2eGJI?=
 =?utf-8?B?VU5CYjZvYnZzdlNGUHdkVEtBSU5VRjUzRHpZbW9Ha1VwL2lXN2RDTndHZ2Jy?=
 =?utf-8?B?a0puVmJha1RPMmcxeWF3bUpjQndJc2RZdUhrblI3UW5uVG5CdGpSb0pESTRt?=
 =?utf-8?B?U2IyM2VVQi85NElLQVQrUDVKOWovRU5GNWJVRU16b2xGSU81SzJDNVRkQncz?=
 =?utf-8?B?dGRkdXlaSm43NzZOS3ZMUVVQbCt5R2VSRDFCSFNydGlkSms1dEZJaUxGTjBZ?=
 =?utf-8?B?Um5IZ2xOZVFEYWo5eDdXWXZVd2JRcWZMK01zZE5kM0ZDN29MQW9VZlVXMVd6?=
 =?utf-8?B?ZDE3TThoTCsyM3hhZDZlTXJHQVNTZ1IrdlRvMzRHYzlHbHNaNnd1VE9vYmxZ?=
 =?utf-8?B?K3QwaCt2MHEwYzd4THBIQmZzQ2w2TGJVcWFJTGhhTU50R09lM2hWdVZEbDdD?=
 =?utf-8?B?OXpvaWk1UlFVcnNTcXFvWE9tSS9sdTRzaDBtTzE3cHoyb21NT1gyZkZiNVlp?=
 =?utf-8?B?YjZWcERSejNrajgyVmd6aW00UUdza2hCd09lWDFqUDRISFRvc0lOZFJFS1J2?=
 =?utf-8?B?MzJ2NGg2UytFZnFucHBIWllJSmVjaVdRWlB6bHg1Z1pUeHpSMUNNOVllc2ZG?=
 =?utf-8?B?S3NXTHJXcGNqWTY0WFJmcjI2RTVzTisvMVVMU2tjVHdxZm9JdXhRWjhmYnVC?=
 =?utf-8?B?NUFNTzgybWxjeE9MZGs1dDVmcFV4WHVld21RZVhINzVJb1l1NXRwTGt0UitS?=
 =?utf-8?B?ZU1ibG9oU21NU0h5YVN4SjRDVTFrSzlFSU5yMi95SHlnNCtwUEJVVzhid1dR?=
 =?utf-8?B?eWNHTTdJNGRZclVxUkdpTmJBUktpaERrUDJjMzI0RGxvOEhweVgvR05vVFRO?=
 =?utf-8?B?SDMzdE5pZi9yV2VCc0ZTMHhxUU5OTmhOamJhMVVWQWFUa0cxeEJ2Y280d0h2?=
 =?utf-8?B?dEdtKzArbVBMamp1QkdBZkVSNVVkdmI1bnBIcnJITTg2cTFyV05EZ054TG5O?=
 =?utf-8?B?TkpVRWZCdUhRbS83MXU4c0FJOFJSZElRd09UbThEMElPcEpNcFExOTNyMm9W?=
 =?utf-8?B?V3BoYTk2UGtuL2dsbWhBTWJKSDVoWDJNWmtidFlkeFZHSllRand3VWRoQW1X?=
 =?utf-8?B?Vml6LzJmQXVKdFR2Rk9lUjROQTFEYXgybHV5M2x1NCtCeWovVjh1UWZsVnRL?=
 =?utf-8?B?bitXYUdjMTdpQ28zRTQwOW1VbzdUQ3A3VXh1aVVvTlhJY0lBOFZ4U0tjS0c5?=
 =?utf-8?Q?Gs+nsSyMFUw1v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S25DM1FFUlV4NGRXR1V6MktlWUNzYkJZR0JqMGVuVmVWdGNYbmlmVzZnMUlW?=
 =?utf-8?B?dWVMWjJ4dUNZdjFZNnRVVmNpL2ZGUW1sRkltZS9sUldQQzR0djBNVU0vQSsv?=
 =?utf-8?B?MjV2WXhoTXdoY2RnRjNHczVwdGp2TXdGeUlEbWY2WEN1OVowMVdnNng5endI?=
 =?utf-8?B?NDNydkNwTks1bU5QWXU0U21BQTlBZXMrYmk0K29nSnpINWJNNHg3T3dKMVd3?=
 =?utf-8?B?UVdhdXpJUXE2bVFkcFlDNUZGbXFyVUFYQlM4K3NMNGYzSzV5aUtwNXFmL0lO?=
 =?utf-8?B?bUFtNWJKMmNJaXlRQ212MWwzcFZIN2tNdklEMFdPTStBVTVuUXVmd0tuemhZ?=
 =?utf-8?B?ZEdCQlYvQmVzaktXMEs5Zm5FamhHd0E3YXA5bnBXdXFVMWVZQ3k3Zm9LM3JL?=
 =?utf-8?B?M0ZCUHBPaE90NjNMQnZENjdsUHRlYk9HRWtDQ2cxaXEzcWxTLzlveUpVUGZL?=
 =?utf-8?B?V1pqUHE2ZmY5MlFqL3dGeVVuQ3Z1SDdxZ3JSMnI2L3VQT3NjOFI0V2RqTnFW?=
 =?utf-8?B?UU5qNXUrREY2aUZRVEJUTDFYdlVkNUpUWTdoU3dxTnZxNlBMUkJNcWM2bis3?=
 =?utf-8?B?TE54c3NxdUorTWRlbFBrWis5b1JqMmpCRWtJcUVSWTNjRmNTaXZkVDMrUURD?=
 =?utf-8?B?blBKNnF4VS9QRUVRS1hZUGVVZHZKVjdETm9yaGhiR3pVZHI3TmMvQ1RUWWhJ?=
 =?utf-8?B?OVFFcXZQWFlRM1Q2cGo5SlVmMDNKa1VxVnRzL0N4RnpqZWlJTS82ZHc4SUdG?=
 =?utf-8?B?aTBaOXhFY1pIVkhaSUI3OW1MLzBFOGYycVpsUXJhQVNWdVcwbUZQaUpnTWJk?=
 =?utf-8?B?OXZKNUVSSjljRVZDMjlweEU1RTVGaTJ3QmErQ1JBclBGM1FISTAxZDZ0MjBJ?=
 =?utf-8?B?ZmhFUlEwYzkreHNRK21UNUlLTTk0NHZCVjlTQ0lGVE41Mk00VnpYejFuZ2lq?=
 =?utf-8?B?YTkzWU9jU3dTLzBSc1ludHA1ZlIzQ3dZT1RhS0x5aDMvOGRFRFRWR2V5azhG?=
 =?utf-8?B?VmNVeWQ5dk0ydm8xVU9Od0dCYUtxY0RNWXByN09HQWR4QlYydzJiNnRpWjQ4?=
 =?utf-8?B?aUs1aTRaWFZ3ZEtJN0I0NlRQZ1AzSkZPZXB2T0luYzVkTU9SUmdvb3ltOHZk?=
 =?utf-8?B?aXViWjVnd2xDc0VQREpsYy9BUU4yaWVLNUN4RENLMGtuTWtwNmRxckVmUUgr?=
 =?utf-8?B?cmowaHNXTkNTRDRaQXNkc3ZJWHZQVFgwdUdySUlmNzRYSHpxc3dDVG1qVkxO?=
 =?utf-8?B?OFY0UUVEOW80WG40YzY5MXVUUCtIcmM5TDdCRDN1WEZackk5Nlh1SHZzRis5?=
 =?utf-8?B?c2VTRlA0SXVSSEkyVEJjRVZzSUVPc2NNajNUMW5YazZCeEFLejJkL1dGeWt0?=
 =?utf-8?B?UDhBanpKQitQOHIzZTZkNEtiM2RJMmZ2aHl6cUwvS0hJY0dPWENiUUJTbzIv?=
 =?utf-8?B?UWZtNDF4SXUwekZKTG1RcjlEOS9XMkxxNEhxajBDU3dZOGFwM05ncUhXeFJG?=
 =?utf-8?B?TUFQaVlNL01QQTJjUWs3ckRpdEpLTmZiM0Qrb05xWWFIREFwMkhzY0lSM2Fz?=
 =?utf-8?B?S1A0ZVFlaUpheXBPZmQzNDhmc1FIa01MeWhWRDEzOUJycHhxUGZwWUIzN3JP?=
 =?utf-8?B?cDBaY2RwWFl1dkUrSEcrNVlERTYreXNSMDNIVjNYbFdKbW1xNkI3UWpqTjU5?=
 =?utf-8?B?TENQVmtaTUNZSzVWdFdnWmZWa3FmNlZqY3ptZURQL2RscG13VmRQbGxMVUx3?=
 =?utf-8?B?R3FwYXorendzaTQ4T3pDQllBKytDNDRJMUxac2tDSHMxVnVKYitqc2F2WXpB?=
 =?utf-8?B?UEFqQWZHci9rUE14YnBnRFlmTGFSeCt3bDhyTlJpU2ltZHo3a1p2Vm02cDhN?=
 =?utf-8?B?M3lIZG41V0JRWm1oZVJjWUVFcGRoWVFaUmFCWXkzOG5yOHZ4MHNJa3F3bXRr?=
 =?utf-8?B?QXhwaC9HbnJsYVBGTTdGZUZxRndDOG9IRll3ajhwQmc2dHJ0RXpnMVEvOGlP?=
 =?utf-8?B?YVJXdnpuVndlMzBCallQWXQya2QvL0REbldjdERXTVJTNGROVmZBcmd4VTNm?=
 =?utf-8?B?N3BpVHY0aTRTYXljZUx5ZGx5YjJ6cmZBWllIb2h4SjNSS29venB0eHBSY3ZB?=
 =?utf-8?Q?qsCbrFcUPMANMZuc2HzrdP0VH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab897d0-6d37-455c-495a-08dd4a1876b9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 21:18:28.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5OwB0GBSBwTcw27IrfFHE3CDMSL+TuCoawskZ4YagVjLJ7zSMShUX51mm5JIZCQM3fxRq0zZyouO1n1YMX37w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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

On 2/7/2025 15:27, Ying Li wrote:
> This initializes drm/amd/amdgpu version 11.5.2
> 
> Signed-off-by: YING LI <yingli12@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 1 +
>   drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        | 1 +
>   5 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index eca431e52038..8db1b221f30c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2020,6 +2020,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(11, 0, 8):
> @@ -2084,6 +2085,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>   		break;
>   	case IP_VERSION(12, 0, 0):
> @@ -2930,6 +2932,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   	case IP_VERSION(11, 0, 10):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(13, 0, 1):
>   	case IP_VERSION(13, 0, 9):
>   	case IP_VERSION(13, 0, 10):
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b531adfb4f57..a221165f239a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -193,6 +193,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 0, 9):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 0, 12):
>   	case IP_VERSION(11, 0, 13):
>   		psp_v11_0_set_psp_funcs(psp);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index cf700824b960..3d9e9fdc10b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1216,6 +1216,7 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
>   		case IP_VERSION(11, 0, 13):
>   			return "beige_goby";
>   		case IP_VERSION(11, 5, 0):
> +		case IP_VERSION(11, 5, 2):
>   			return "vangogh";
>   		case IP_VERSION(12, 0, 1):
>   			return "green_sardine";
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 47db483c3516..8d84dff58b7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   
>   	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(13, 0, 1):
>   	case IP_VERSION(13, 0, 3):
>   	case IP_VERSION(13, 0, 5):
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 2395f1856962..bb5dfc410a66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -129,6 +129,7 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>   		err = psp_init_ta_microcode(psp, ucode_prefix);
>   		break;
>   	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 2):
>   		err = psp_init_asd_microcode(psp, ucode_prefix);
>   		if (err)
>   			return err;

