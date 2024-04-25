Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04A7C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF7011A1FC;
	Thu, 25 Apr 2024 07:05:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/qex6eE";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F255E11A1FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:05:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd+rpf1cHBsSuxuo9vhK+3QPknzaBN2UrzwIz0ZVfsruqNmiAowYm032LPzSp9DlHDy4rzrpJsqWPW6qecKwTbdzxbq45U/gGb5kfg7Wdfk10LjI6G6ILFMm3venVEHcSPzmXWMBhCe50CzFy8Rlq88mWJLpZR5O0fd3eV9JMgGkeNtE0MyiDFHCP44cuwiIZyT5WFVkxISRKJrg7yO0nITc8RuRYJwpeKpQW+QWctH8ExIv1dAIdVdUt6bUJ6oyNC3+gvcwjio2Hcy+cdeHvVGVhWV/b6PTAFQkhfu7WcefeN/a1ZPl1fxAtFocfwt5ZSAM7aRnPcfNYMjs07K/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI6LBW9UXvWlVcoFt5aQUbQZvwF5aS0GgY8ZfR8e1vg=;
 b=GSAH/KaW9RPSPhuJAs3rUQAqoRO25EgCD1IOKTTvkh7AcdwFHJ61OSlPGUrrpt15n/cBI+L1YvwHnDzM9lHxXxQUV0uHGdLul+eBBEetUIVbjXvdL4OlUY7dJhQgOzGH7RAI2Qgi6tXLgBo1EFwsy5mPwzxhIf8u+z9J6a8lbzczvT+0+buSg908fcJ7bifGNb1l6TeaeD74DN3MUILFd0SRvKzidUzL1z70I+mviIuL5HK0uBQlB9piNyiwEOXhrUUwzulyv2VsNPw+ldGT9cQCVVLcZ/eUJAg4WdU1WCD6yoXRcWPLG352AFIFGvMM9DvGdH4MMGW3HgVI1fUo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI6LBW9UXvWlVcoFt5aQUbQZvwF5aS0GgY8ZfR8e1vg=;
 b=m/qex6eEBblzq3kO0pVrq7YB/NNleRtlV2PMzkJMuy3XZIhDrxPQrwV+yLc3rqYTytX+iOw0e+0NHxUOUpdrvOuTyCME5SrzgQrXMH7pHOzejhxJUix5SAxbJqHw/nYzEZTS2wnY9PGN7+HILBtN8uY7JC9uYBixfE7FrNN/1kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:05:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 07:05:41 +0000
Message-ID: <034202c7-4602-464a-9500-3e451c5ac24a@amd.com>
Date: Thu, 25 Apr 2024 12:35:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_
 cp_compute_microcode() and rlc_microcode()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
References: <20240423014523.1598424-1-srinivasan.shanmugam@amd.com>
 <20240425063543.2621823-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240425063543.2621823-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::28) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: ad97994c-2c86-4ae8-5ab1-08dc64f61e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rlhvb0hISU1JQU9UeXBYekY1aEFuR0k3OUZRTVpOUm9lUFhYYzFvUSszYWpa?=
 =?utf-8?B?NytPbDBNV2QzVStPN2pHbjIwRVUyWXNRdXhlMGN3WmRhKzdXUVR5LzIwTEd1?=
 =?utf-8?B?L2xrVWd3ZC9yL0lkVFNDWEh1bjhNV1NGaUwybi9DK3haY29SOWVNY1drdVlx?=
 =?utf-8?B?QWZWS0EzQXhCdDMveEVHU3dBUzgyaFJYeW5ZbmN2QkRVdkMzNXFmNUQ3ZDF3?=
 =?utf-8?B?UXg4Z0IzR2sycTNOVS93a1Q2d0VMeXUxUWRMQ1RiNHowM083N3JMYzIzS2F2?=
 =?utf-8?B?VDNIbHkvM1plZVpFS1lXVndDd2VTRGdYK0RDSjg0eit1QjhFc3NtTWNRSzln?=
 =?utf-8?B?R3JFZVBMbWJodWtpb0JnSkJBRER6amRhZjFUMWFnVFd5Zms4YlBsby93UGhy?=
 =?utf-8?B?TzhYZUJndmFMZ214OHVpTmF1ZFNIMG9wRHNYdklhWGRpYVc5RytKSkpoa2tN?=
 =?utf-8?B?cEJEQ0NLWktrS2NXU3dhc3NmUTNxTlhKVHljallxVjBOaGRxZ2ZuYVlzelRJ?=
 =?utf-8?B?V0hwZm45MHBDOTJOdm1tSm9jZmJhZ3JFWUE4TU9nbSs0UWcwY3VKQWxBYVlR?=
 =?utf-8?B?NDV5bEtHSy9LdmNjQU4xWTI1QnN1REU5K1FrRXB3R2xFak82QXdnK3VpbnB4?=
 =?utf-8?B?eld0ZVF0emsrMmZocFdtNy9qOWttWlRLaHhOWFNHdFV1Z1ZDdW9ZR0dGUlB6?=
 =?utf-8?B?TU5rdWtJOENMWjZSUDZWNC8xaENVckFIV01TQkpxMGxFMktiQ1NVaFE2YjVF?=
 =?utf-8?B?WE1vci9RT1ExcnpjcUx5VjkzWkRPemVkWE5FdDNLUFhrR1luQlovRkRHVC84?=
 =?utf-8?B?M1ZLbElGQmFIVjVtblpPMCt3d3Z3QmZ4dUZSWXg2cTN1aktzcW1yWERsa0cx?=
 =?utf-8?B?NSttNmpiRnlUb1gyMk9sZ1dXQklxQzhqUHVYMTFNelFZT3dIM0MxanczaEVI?=
 =?utf-8?B?a25UWUxsYlVwclZOSkFOOXRNVXc4TDdxMlB6YWV1cFNjR2pSNG5NTlpyT3l5?=
 =?utf-8?B?VUJ2Y205NWM4WlJJZUd2NTVEWWhBWWtRbDJjZzVvZTVvTW1ZMjh0UXFWUklm?=
 =?utf-8?B?ckFBRkIvWkdlTWIzT2ZvbS92SE90QmlEb1JveFFCV1ZyMEwrT1pKSWd3cXZm?=
 =?utf-8?B?NXBvRDJtb0V3Uk13dytZTHVzSTA0ZzExK1piWjV6WDltcXZWQ08zZ05Keng3?=
 =?utf-8?B?K09OMDc2SlhHWXFDNi9JeHhmdW5KMHNNSXc4ZGpIUXVXbkxJVkhIKzZZcWQx?=
 =?utf-8?B?dDVHWFNoRFZIL0xvM2FOSVFwb0dQckZoYXk0dVMwTi9xYTJ1ajBnN0E5RlRh?=
 =?utf-8?B?bzVxTjJLWEV4dk4veXpNLzhLeitFRTQxdnZOQzMya2RtSFp0dVpOWWRoN3Ez?=
 =?utf-8?B?VEdFdDgxclh1c01kQ2UzTEx1aGhqQTBmblp2NU9nbUtvQTNJdGZMTFQwVEZt?=
 =?utf-8?B?ZUI3eWhFODNGSEtVY1BRQk95a2N1QlR5bVZzYVJ1TkxkYW9VWjhBRUhvVERj?=
 =?utf-8?B?S2ZtYm5kNVJOWTYvN2xyQzJrc1hzdkdLOXNtWVlpblhmcER2ZUFibFRpakFq?=
 =?utf-8?B?Q2taR0hFRisrbmRmalZZL2dUUDYxSGo3VU1kMWQzRUFPK1BlYnVFZm9Gdy9C?=
 =?utf-8?B?bkFGdU16WUdGcTRyOWt2QXFwd21IbVc0SWIvbmVreEJwSjJaSWtBaHYrc0Vv?=
 =?utf-8?B?aFVFRjIyZklhaEdhdzltbHQrL0xheTVlK2xPc0hLL2ZMVUo5UHJtMW9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG9EK1d0YlJGOTdsWGd3SXl4dmFOeWpYZTQ2eklvMDEzMERqR3RPT3lkRVhs?=
 =?utf-8?B?VEl1S3RXaUhGZWM1WExSbHlUVWZKOThzL0ZPaVlMc1JYbUFHOWJZQndKVzRC?=
 =?utf-8?B?NnRneFEwWUZrTGhtREMvbVhwbnl0bTdBYWY2SEIxOGF5NWFybndKd09WTFFl?=
 =?utf-8?B?cy9rSS9SZnhsbzUvdmN1cGxNVERNNmtLWW4zWmZKUHkwY2RsYXNGWkNNc0pr?=
 =?utf-8?B?bjB2MlF3L0lkM3JLNk1oUW5kNldKRzNsa2ZLZmN3b3Q4eU5wRXZXSWU3RW1E?=
 =?utf-8?B?Rk90TkZrdXROM243TjBIWkdZVjZRbis0VGtDZ0VpRVRGU1hGS2ExZEtUcU1C?=
 =?utf-8?B?cjNNQk9lYSs4MkZNbjd0VERIeFZDMlMxeG53Ui9PZTRGTUpBTlZUVFRlWmZ2?=
 =?utf-8?B?OFFTK1RxS3hvU0w1M2plcEx3Z2ZDbjlsS2QrR21Qdm43dTFVZGNKK2wzcHdv?=
 =?utf-8?B?YzhQRVF0NHZNNkJHRmxKS09ZMkUwS1lzd2xhMUdLVEdMQlE0MFpaamtZODEz?=
 =?utf-8?B?OXErelVaZzVmUldmZmZXeDcwb1I2bjFtU0NoVzcwb1pHWURZYmdFQVh4NDBm?=
 =?utf-8?B?cWpjQW1wbWhjazd6dzhzd2VLcnVoZ1JRa3hrT1R0TkpuK1FBYzkzL0FCUGlq?=
 =?utf-8?B?eGwzbFFJdUpNREQyRHNuWDN6cmFkY01nQVpCUjB5bEVXT1Q0SzAxay8rU3lE?=
 =?utf-8?B?emhhcFFYVGJvbjRxZUJaL2VlczdJNXo3dHBEdTBQRkVKR2FOR2ZMSzdkTzhE?=
 =?utf-8?B?REFsZ3gyald3QlU1UWJRM3hXTUJxTnpLYTZYa2lvVUd2RkYzVFBBMXk5NUs1?=
 =?utf-8?B?Tm01YUtGaFFxQWJZbVNuTmI4eVM1dDBnclVyR1o2c3l5RXZHWlNTcFFoM0VG?=
 =?utf-8?B?bzNjQkplbFlDY0lSTUpsNEdnYk1NaTVISXdGMlFYam9IUmpMbWVrcmwrYlhm?=
 =?utf-8?B?RE82WkhaYlNpNXF3dTBYOHc2K3E3RXVMQ1RGcklxRU14eU84SzdDN0tVRENv?=
 =?utf-8?B?Z0FGeXg1MEM2N0NOUHRKbDF1ZEhoVTF0c08xTVNLSnRWUldyMjhwVG9TS09I?=
 =?utf-8?B?UzVvVWpaK2VYc2dMN08zLzB4QXBHN0JOV05VMGhxZlVtRjhzTDdPaVFaSHpG?=
 =?utf-8?B?LzZPcEFKakxBMy9SZlRKUWVNTCs5WHBITmxrbzBnbkd2enpNY0gxUFdFRnFo?=
 =?utf-8?B?VkpOaUpzbnh0MUx5RWpXRFZ3T3pVS2RVL2tyTTg0c3RuOWlUUXhSU0RDR1F0?=
 =?utf-8?B?Yitmcy9DRmdsU0gxR2kxTGtsZldzNSsya1ZLcElSNlhRVFpqYzNpOFFBWGpm?=
 =?utf-8?B?dncxUlNDZ00yK0ptTFN2am53elVxZE80TCtpNFVyMDNvK0lRVFQvZVp0M216?=
 =?utf-8?B?SVhlQ1JLVDJkWS9SdWI1OXBiYkxrOERTa3hJdyswbFBpU25lc1NHSkdBSFho?=
 =?utf-8?B?U1dtY1VaUGorYUlLcDdaUENCYUd4QzFsVEhFczFaNzdpaS9RRjE3Vzc2dXpI?=
 =?utf-8?B?eVk3MWZFTkJPRU5ZY1hhcGxXTENxZW9uRHRLK05EQWxmUWQ4RUtsMkFSQ1E2?=
 =?utf-8?B?dVNhVGF1M0w5a05NbnpmYVY1Y3VHa0YyRm5IVFFxdFNDWWJsY3RVZ3U1TkQv?=
 =?utf-8?B?dHp6UUp3bU9QZVNjeDZUZ0hsV0lBUlloaU8yeDJVZ3IxZk1hK0dvcWh0YnF1?=
 =?utf-8?B?c0FOQ0J3Ymk0TXdEa1JzUjFuS3dyZWt0d2xibERvY011eFJxTUJMaEMwb2Vh?=
 =?utf-8?B?K2lWUEplc05SMk9XbTlvUitscDlRQlpaK0pZcGkyNDRUcWcvR1BwajI4aG9C?=
 =?utf-8?B?elVBSFBSSjcvWGhOd3QwNTNKYjUwZWMzVEJTY245RW5xR0FCcmk2UU8venRv?=
 =?utf-8?B?TjBiemZMMjVJbW1VZnFjNGEwNWo1TzNzUEoyVHRacU54cWtjd0NnZDJKT0R1?=
 =?utf-8?B?ODFtSzErNWxSVDUwMVNqWVRMSUo5RE02NlJKakZtQlZ0VHd3U0EzcFZhMDd5?=
 =?utf-8?B?ZmZtc0JMaUxzV0lNdnNaQXdwOHFxSmxDR2JIdU9wUHNzb2t5SnZWUS9VZjdm?=
 =?utf-8?B?am9SaURPTklqQnVCa0lRcCtEeGg4bGZza2tickxCUzBuVlFCck4zcGxVTUV3?=
 =?utf-8?Q?FFtwHc+AhUKOI/xTzHszCr4Nb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad97994c-2c86-4ae8-5ab1-08dc64f61e37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:05:41.5216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhCVsWJ2B9BFIJlsXyrte5UCOG8gAvCk3e3WgxhqfG6Ul8RbgYc2XLpNPkjZplSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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



On 4/25/2024 12:05 PM, Srinivasan Shanmugam wrote:
> The function gfx_v9_4_3_init_microcode in gfx_v9_4_3.c was generating
> about potential truncation of output when using the snprintf function.
> The issue was due to the size of the buffer 'ucode_prefix' being too
> small to accommodate the maximum possible length of the string being
> written into it.
> 
> The string being written is "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin",
> where %s is replaced by the value of 'chip_name'. The length of this
> string without the %s is 16 characters. The warning message indicated
> that 'chip_name' could be up to 29 characters long, resulting in a total
> of 45 characters, which exceeds the buffer size of 30 characters.
> 
> To resolve this issue, the size of the 'ucode_prefix' buffer has been
> reduced from 30 to 15. This ensures that the maximum possible length of
> the string being written into the buffer will not exceed its size, thus
> preventing potential buffer overflow and truncation issues.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c: In function ‘gfx_v9_4_3_early_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>   379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       |                                                    ^~
> ......
>   439 |         r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
>       |                                                 ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>   379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
>   413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
>       |                                                    ^~
> ......
>   443 |         r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
>       |                                                        ~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
>   413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
> v2:
>  - reduced the size in ucode_prefix to 15 instead of changing size in
>    fw_name (Lijo)
> 
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 0e429b7ed036..7b16e8cca86a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -431,7 +431,7 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
>  
>  static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
>  {
> -	char ucode_prefix[30];
> +	char ucode_prefix[15];
>  	int r;
>  
>  	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
