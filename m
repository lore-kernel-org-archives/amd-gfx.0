Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2994CC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 17:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0ACE10E6EF;
	Wed, 26 Mar 2025 17:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TxafYxJa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17C010E6EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 17:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFsyCLlL+izFXfN4RxriuJG4syP+FicfhLmXEYyjErjBX58HeHrAaGW8MWlVzNK+ZzOq+Eg6jgnV01PC0cwgrARSJW+311MkoYlfuxc4PPoTDH+CpOz/AT4x2K2+JrT2YTWgBGz2s2T8zT/JrbW9C9N52Ojhm5RD+WB+4g3AvNKfmSX3Jdn3HhG0I+ojLi7zR/bA2O4qdvI0fJJ2NRihETkvjsinUAcsGkKWRiNfFKm7AQvDBr91HfWq+t42NhbjMq5jfION+yS/L0/4q8rv5jKKUo90FG7PVX89fQiovSfGpEmvVQ5cCqigLRw2X/mVCOmW9cwBW3SGKRiYiPTfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPEbdZ8sdmV31UUN7oQHBLt+ANQaHL/Q3DMu4LkRNz4=;
 b=Q1n8N15y9sqTRmeIMphlynewvM1OArHeGqXjek82huyDPQYWR4b0Qny4OunGtky0LQvOVMWii//aWOKeYEuQHLfAHhDMaUTD/G3j6hY/jPZM7oCvGEhDq3Xo7Jd30KXZAn7DLHME3aLcLxeiOLbjFqlMjsgBMMOQTZlGbqWb/wwI5x7jMsqACPVa8MsE3+PCgM+Y3WLxzE0/ZvkrUCx5tA4dEoK5bp0dPjJK4P1TymKRM+VfOfS/TZf5sOki2odEd3mnOfddlkl37Qb9wTbu5zsZ6ZrCPijQ9Y/d+6ur8cBpEjVT1e76GWLs7m+tL2UMCsPFUn+CoOsLrR39cKqc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPEbdZ8sdmV31UUN7oQHBLt+ANQaHL/Q3DMu4LkRNz4=;
 b=TxafYxJaZEtA0J/8n7H5e6vmT4mMTdqkuqu7sUzCkQH9DLGSMvol3/PAMl4RINjxXa6xvHfAIBNBnvZn57S1VHG16tJzN90Dy7pPtXdK4wdX5GxSBvAvzrEWxZLt29tbA6LnV52HHz6mZLjmJgBThv+86DnnF9QS0/3wpMkHjUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 17:59:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 17:59:38 +0000
Message-ID: <b8f5b257-745c-4207-b787-b20a8c13b986@amd.com>
Date: Wed, 26 Mar 2025 23:29:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: clean up and consolidate sw_init
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250326162403.1139259-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250326162403.1139259-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::25) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bed05cb-2249-4418-a1c3-08dd6c8ff957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2MwcGFMYjZDeTJONHQxOGtsbGJhbzJWV2lmMTlrL3paOUVEMnV1ZkxTTWxX?=
 =?utf-8?B?RW1tL25ZZjdzZ0ZwVGdUUktWM1ZGTHpIcnBsZExVcXg3aGppekRrTGQzRHll?=
 =?utf-8?B?RXZ2Uk9xUWtub1cwZ0Zha1VRbXlwdzh3bXV6V21xQWFwM081MHQ1Q3BIaWR0?=
 =?utf-8?B?MXozcU5TMXd2dHQrbzhZVFR5VTY1MjlWVWJpNEUvMjZmTmZGczZJZU5zY1NZ?=
 =?utf-8?B?OU5rYUswWUsvVlJVOUl6MlovZTBnR1YyT0lrSmlhOExxKzRhTXdNTVJrVDQ0?=
 =?utf-8?B?Mmlob2hjZzN3L1NPNHdaZ3lFQ0VJMEJnK0JmZ2NWcGJXdGhDeE05SjBGNFRJ?=
 =?utf-8?B?V1JQOXZtb2I1NVJteXNudmkyNElzcm1MMEJNVzJ6bUdRczlOYmFoaWVhWUZX?=
 =?utf-8?B?UW1FOTZjd2ZWV2V5Z01JVzhjSGhpQWZxMzhpdFgvdTdscVhaNnhKS2VjUFJX?=
 =?utf-8?B?cTl4VGUvWlpaSVhlN0U1MDdub3haTWRzS2tMWDZxZENENkxzKzdnU2RLRFRP?=
 =?utf-8?B?ekhjeFdCQkx1ams3OHNoSWVzbTlCb2VheTJncFlaZ1UxSG9qR0VUa2pyaklR?=
 =?utf-8?B?RlpBdHVlWGhBaGpDa2xOYXJtVkwyc2Y3MlYybXJjUTNnQkN0YXRKOS9Nc0I3?=
 =?utf-8?B?RTdFVmFkSXJsSGI3QlUzM0x1RC9HaXJMTzZVSUp2K1E3NkRCZGZ2MnU1czMv?=
 =?utf-8?B?VTJ1eVFId1M2NnVuSGhzRHlPSHBLRGZDd2QzUkxUTWVzUEZnU0hKMWR2LzhR?=
 =?utf-8?B?NTh2VXhkYUg0UjFyUTZTbFBCYU0yTis2UVozNW5LTG1NVk5WZVdBekNVeVRG?=
 =?utf-8?B?eGkxcUJTdzdFVlY5cnA4RjB5Rm9oOGRtV2VtbGVMdzQ3QXoxUlBXMFByWGI3?=
 =?utf-8?B?YlRRQi82eHgwV01tdkpPZ1dyY242Y2ZHNk1rS3B2dVEzN1Zpc0wremhiYm9s?=
 =?utf-8?B?dzRMTEVNWWYrVWhxVWlZMFNSU3BUY3cwMGxON3cybWQrcUpQK1ZFa0YvUWhq?=
 =?utf-8?B?V0hHSElyd0RlaUZIZkZrcU5TbE1iOVJDejRlQWdoUGJ5SWNuUWJJN2dLQjUr?=
 =?utf-8?B?TmduRGhtZnhsK3pmWmtWWVR5U0pnU2dnQS9pRk5FV2o2ZjlmNm5MMVZkUGpJ?=
 =?utf-8?B?Wnc4SHVDeEVkeUV2UmVJQ1VEQkxPK2RyQk9tSm0xcVd5akV2TmRDcnF2Mnhz?=
 =?utf-8?B?aFUvcWppdlFXcW0vTGJKY1JiODZSRkJrY09pRkNVbk1peXdwYlFPRlVYaWJW?=
 =?utf-8?B?U2laMHNWUSs5bllLVDF6dGcwMTlxZ0RvNWpnMXpGNk1UYUZIcjBtKzF0Z29m?=
 =?utf-8?B?NGx2cU5odDR2MWdteW9QRzdEOU96TFJUOGVVVWtrRUpGQUNnTDhxQ0o0S3VZ?=
 =?utf-8?B?TjdTT21aOG92emRuWjk1ZFFNejhIcW9EYzJRNWdhbzRsT0lPbUJVYUF3M3dO?=
 =?utf-8?B?d08vVFlncUZiZTI3SS91d3FrUTB0bzZhWFVFT0ZMNytTZjJ6ZVFLTm5GZytZ?=
 =?utf-8?B?My94ZndSUWN2RVhwUDJXaGtyVWxjVEtRTC9jQVQxbG85b1NoazBEMFJGMUgz?=
 =?utf-8?B?UFM4dUpJNmtVV3krN1NHRzFoUW9OT0lpR1VFcWc3Z1ZMZHFaVU43RFppYlcw?=
 =?utf-8?B?M04zUjNXdy95TjZHUy9OLy9OQXRuSWRaS096aUdidHFKa1EwQ1FtYndZOFRN?=
 =?utf-8?B?SVB5bnhFNncyVVhXN1RHck05bmFnNXhYUUgxa2p1Z25Dc0lrQWF0TS9uTGNB?=
 =?utf-8?B?MjRSdjB0MEhkMGRMdC9KbDljVXQ4YzZGRkRaQ0VBS1VkNk5kSjVidjZWNUVw?=
 =?utf-8?B?VmNPWkZnRmRNa0JMMDMydFFmZ0E4OXh6Y2JWZTBPdGR4NEtKOU9GSWxCNUlR?=
 =?utf-8?Q?YhPiT7OoQW+rm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJMUzI2aWZiVUlXNk5zRjNDRWg5MU5IOTJieGZEcDZPRU13UmlyRXd1dVdH?=
 =?utf-8?B?TFU4QlFhVDFGTE1uVzRsdWNzNXBLRDZ5dU1wdlZBdFlMMWhRdURiSGpyRElv?=
 =?utf-8?B?cis5SkNMZzFiQk8xdlkycXBqVWZrTnZhQlJnVlhCYXliUkkxSU5jbC9XN3Ja?=
 =?utf-8?B?ZThYVk5JdWM2MWFwWWNrckR0SmlYMXhsTDZTeHhOdis1V01lTjc0cXN5UEd1?=
 =?utf-8?B?cmpqY1hrUUFQVTR5YitIR2dQeThCZklNUnZzMnZ5b0lVQmRlTEQwSGFITUMv?=
 =?utf-8?B?di9ObEkzZFZWK2ZsdFRLZDR1RXB1NzZUM0FMM3YrdGJkRE1JU2tRVHd0VjBq?=
 =?utf-8?B?OHNBc1g3UG40T01ZamtmMEhGK3JmRitIMnlFdDBKWExhSjcwYkRiTEZ0SVRM?=
 =?utf-8?B?UkxqTnF6M1BlNGliYzJ1NWdiNG9LVllQTDZaeFhtcmVuZHRtb0dmSTNYYWJh?=
 =?utf-8?B?a1gxdEorbHE3K21nOFJLcFpKcElDcmxyb0ZXWlFxWklxNjNMNnk4TDV6Z0Rr?=
 =?utf-8?B?eXF3RlJaRkVRZDdONklMcVNEejJDQWRtSGMvUVNXVGpuSWhYMVowYWJ1ZjhQ?=
 =?utf-8?B?SWkzNlZvd1cwd3pVbVlxSjFSdTZMVmhLNnJGZVFlenN5MXlqc21kWjcvaGFC?=
 =?utf-8?B?OHFYd0NTYUk0dkhDQ21mVFhWaUQyUkpIOWJ6dzlkcy8ySk51SWpEbENNWlZG?=
 =?utf-8?B?SFYvcFFJMXRscTZZY2poOUl5d1I2Ykp4Mk1TY25NZ3NwTUlsZHNLcUllbHJq?=
 =?utf-8?B?T0tLTmZiL3VwUm42TCtkZ005TTQxZ0JhSEFRYkZQWjI3MVFzNnhIQkZ5WHJ1?=
 =?utf-8?B?WnFROG04OGtqWnNuRkFDRkU5UGpyaWJMRGRqWHJEei9zZlpCM0FBeDF1R3Nx?=
 =?utf-8?B?U3ZsZm1WV2UzdFFlbXhDb1JUcW9mNjZHR3hzQU1TTEE5eUJDRjBzNktqdXJs?=
 =?utf-8?B?cStOMUFQai9yTXlhcWRhRXpMUi9nZnh4dmN3NldVcWduYUNLWE04MkdtQlJV?=
 =?utf-8?B?WlB4QUgwb0Iyano4NjltaDlNNVdScGtSMytGYlRRaXR4Q2VIeERiZzg3N3FU?=
 =?utf-8?B?cm1yazdaRFc0dnAzam83OEVIZStQZmNHT0hqVEJUSVdaKzBNUTdDci90endC?=
 =?utf-8?B?Ny8ySS9GclIxUlFIOTdZcWY5L1BybXE4b3BDMzlSalJmWC9BcXBMSTBVVDl0?=
 =?utf-8?B?WkFwWmxtVGY0MjRIblV4UytzcEQzV0FJRlZEazYvMlA2d1JNbExHWWVObmJz?=
 =?utf-8?B?MlRyaWFuQTUxbDNRWWhLQTBhcDQzaEh5TW1PUHdXMWpUcFhkU2hkU2dNWVFJ?=
 =?utf-8?B?aEQ3dExBMXZyeTU0em5ld0MxeHd6VTc2enBmblJIVlplTURJVVdxL1o1aTYx?=
 =?utf-8?B?dGY0VGYyc2JyNGdIN1IrT1JOWndkQlUvbmUwSEJRYU51SGxVLytoT0lQRUZ1?=
 =?utf-8?B?QXJHMVZnMjJyNmVGVTM3VGxsNmg0VDJBZkllc0xtZlV0WEFNQTlTWlYybnlo?=
 =?utf-8?B?U0VuMnlXN3JldUtDbktXakg0cnlRK2pJcC9qYi9xcDdMZ3FMUW9VRUJ5VVJn?=
 =?utf-8?B?dVBrb2p1NlZCbmlUSUxMQnVNZXJyR0N5Z1JBN3MxMkFqeGpUcjBnNmRMT1B1?=
 =?utf-8?B?TnhHYjZqRkZWQTNuUVphK2dPbUQxbUduaWMyeW9lbElLSnlibGRsRStJdUdP?=
 =?utf-8?B?azgxU2taU0VSd1YzNTJaL2FaZXNybS9TcVhQQjRHb0xqWlQxWEZubkFWdlVw?=
 =?utf-8?B?OW92NVpuK2dLS0hDTm9TbGc1STQ0d2h3eit0QlBiQ2duREc2NW1LclFPVFFV?=
 =?utf-8?B?SkZRVlVmdlZvd3V6ZVp6M1JqZ2xnTGNqMEZDMUFaTTBxOXhoQUlnWGhWNUlw?=
 =?utf-8?B?eWRGZnkrY2FZWmZzcS9pWW9aeXNkT2Y1eXRySEJlWHhpOFVyaTFzNUxVOTdW?=
 =?utf-8?B?NG5LZVdURGdCM1hxZC85TVlLdEc4N1JETm1CVmZxeXhPOE9LbW5QdXhLRUsx?=
 =?utf-8?B?TllUa2hxTENCeWdHb1ROQlp3OEhPZ0ljQ05XZmt0V1NjVWxNQXV6SGZRWEV2?=
 =?utf-8?B?MmNOSXFzZjA4dzhLYTdoNEQ5cWk3dnRXQStVRU5aOWJmRmI3dklUVHJVWkRD?=
 =?utf-8?Q?lsz5irwskiVFt3aDRE1uvTH1u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bed05cb-2249-4418-a1c3-08dd6c8ff957
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 17:59:37.9520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ay+jdyCzk/8hNa0UiulnatUPViOtBOOSK30RDvX6cf93dfP2NplcS0A1aQYp0zmGQ3UKZPUdgz2cKLXnjlTOrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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

Both patches looks good.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil khatri

On 3/26/2025 9:54 PM, Alex Deucher wrote:
> With the ME details fixed, we can now consolidate
> this state.  Also split out the userq setup into a separate
> switch statement so that we can set them per IP version
> when the firmwares are ready.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 33 ++++++++++++++++----------
>   1 file changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1b3cbe3286dc2..b5c9ca680ed7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1597,14 +1597,35 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 1):
>   	case IP_VERSION(11, 0, 2):
>   	case IP_VERSION(11, 0, 3):
> +	case IP_VERSION(11, 0, 4):
> +	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(11, 5, 1):
> +	case IP_VERSION(11, 5, 2):
> +	case IP_VERSION(11, 5, 3):
>   		adev->gfx.me.num_me = 1;
>   		adev->gfx.me.num_pipe_per_me = 1;
>   		adev->gfx.me.num_queue_per_pipe = 2;
>   		adev->gfx.mec.num_mec = 1;
>   		adev->gfx.mec.num_pipe_per_mec = 4;
>   		adev->gfx.mec.num_queue_per_pipe = 4;
> +		break;
> +	default:
> +		adev->gfx.me.num_me = 1;
> +		adev->gfx.me.num_pipe_per_me = 1;
> +		adev->gfx.me.num_queue_per_pipe = 1;
> +		adev->gfx.mec.num_mec = 1;
> +		adev->gfx.mec.num_pipe_per_mec = 4;
> +		adev->gfx.mec.num_queue_per_pipe = 8;
> +		break;
> +	}
> +
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
>   		if (0) {
> @@ -1619,12 +1640,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	case IP_VERSION(11, 5, 1):
>   	case IP_VERSION(11, 5, 2):
>   	case IP_VERSION(11, 5, 3):
> -		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 1;
> -		adev->gfx.me.num_queue_per_pipe = 2;
> -		adev->gfx.mec.num_mec = 1;
> -		adev->gfx.mec.num_pipe_per_mec = 4;
> -		adev->gfx.mec.num_queue_per_pipe = 4;
>   #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>   		/* add firmware version checks here */
>   		if (0) {
> @@ -1634,12 +1649,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   #endif
>   		break;
>   	default:
> -		adev->gfx.me.num_me = 1;
> -		adev->gfx.me.num_pipe_per_me = 1;
> -		adev->gfx.me.num_queue_per_pipe = 1;
> -		adev->gfx.mec.num_mec = 1;
> -		adev->gfx.mec.num_pipe_per_mec = 4;
> -		adev->gfx.mec.num_queue_per_pipe = 8;
>   		break;
>   	}
>   
