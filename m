Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607E7E77188
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 06:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDD610E807;
	Fri,  3 Jan 2025 06:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XChq35sW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F8A10E807
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 06:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+SEBnQIAgTN985z1wJ5XR8s5uWhWk0e3zFNhktd0DYPemujq7xhOOq5UgC68JQKeeEYdbAc3kuvMsZWev5naMUBLdK0rdcCfXu7EmQwOoaY20h8Cqqxhn2UsVPSPiU0nlC3R6Bu+Ofj5TZeqaNM+qtxy/7otmPUJpj9YIGm60s1oUPYU1bU89F0zOtH1i1HSyBoqSLIeRfIEXxY5Egj3POK24uL//2tD7Nl6cfplmwftoC4ChtOf857FcE0e0K+0UvkkHaremXYA9AWNr2Se1V+Tn8T5m3Z4ac1TAPxcTPTpPtRIpf2fzAN6PToH4q9u7zOrUV1Zr+sCAqQSTBxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd19xPVtuD8FYSl8n97GbOyscsB/K87d9TzgK4ZaMXc=;
 b=mfVnAkzHEPv2m9CFHKCL++vV/MOPIWxSJimQX+p5pGmhj2ChgkNDYqVI/SvtFWY9gGswqTUmBd8uRg3OAz8NnqUN/PGCvO727NHfa73hF25WUix2y8FtVQYCj6+SswKpT4nPAnRo/o7bQgdjNACMlkxuaKNiJxFgZpw0Ehd38G+oMAtXEWIQ4gW++ufNmw9glTIS4A3Ue81SUnLtbkcbbamOSCyc306hXqig/mJayO7BSTXPs77waPgYxbYO+3ozARjflNtjFHhlxYg+vePjX8jQkveduswLYmGIsbo9WXzf6p2krY0rAraKs1hm2iLakgFenrlzxokuo2qGsuqCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd19xPVtuD8FYSl8n97GbOyscsB/K87d9TzgK4ZaMXc=;
 b=XChq35sW9zZLnCSEnpDn38+qYB9GhXtH8/7OVC/ZNlWcvuzbzvPMI82O6oWFfqdRXh9uBju54GGNc6StqITyDOMY7c11tLU4Uivx80zBSFUPhJXXUiq9ncq0HQYs1AhKiYl4Zg5n14eDgJO6aSTOzlfhJKP9xoRVjXKg3gKP8tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 06:34:42 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%6]) with mapi id 15.20.8293.020; Fri, 3 Jan 2025
 06:34:42 +0000
Message-ID: <7dd29048-2d87-4583-a43f-b4fc5c69c06b@amd.com>
Date: Fri, 3 Jan 2025 12:04:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [drm/amdgpu]: user queue doorbell allocation for IP reqs
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 veerabadhran.gopalakrishnan@amd.com
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250101060338.402215-1-saleemkhan.jamadar@amd.com>
 <5d460846-9400-4821-a371-72388093f85b@amd.com>
Content-Language: en-US
From: Saleemkhan Jamadar <sjamadar@amd.com>
In-Reply-To: <5d460846-9400-4821-a371-72388093f85b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::25) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf56443-58c4-43f4-aa47-08dd2bc0b469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zkg1QzZzQzRFbzFzY3dmVU9ML1cxOEM4NGNIbTJIREczeXN6OHFnalpOSUpJ?=
 =?utf-8?B?R3B0U3pmQVFYYVp0VHFQRVFXZ2pDS3ZYQlBnUGhMRzgyUkRvNTJXWEYxR1Iw?=
 =?utf-8?B?Q0ppcTliL2RIcjVLS1BHcm1IaUd5cWg4YXRURmJyanVpSW83R2ZRbFBwRksr?=
 =?utf-8?B?Tk5HVE1aQ0tnSm9ZTDJES2Z4YVF4dTRQT2JiVDJOQUJNMGRlQ0g0UmpqUm15?=
 =?utf-8?B?Z21Ba1M1R09ZU1hJemF4clpGd1o3VFV4VEtlWjIwQ2VjaHVtNkhhY0tQYWVV?=
 =?utf-8?B?ejlVK0JJWGEybGJxQmVGYm9USW04N1hrUnprVVhxbkFHbjFpOUQrNG9vWDFP?=
 =?utf-8?B?OFpRdkVvTldabTFRQlRvUnhZY21nNTBuUUxlcEZRNTdObjBXYXl0YmdOd25R?=
 =?utf-8?B?SFRiWkJXQlpOOGl3NnJOZlZLcms2d3BHRlg3K0dMTEhnRW12S240akYxTkxw?=
 =?utf-8?B?emJIS3dtSnpQZ293ZnJlYmVmOTRjSlRLZzhCOU9XZWsrb1E3elFjRjI3ZGh2?=
 =?utf-8?B?bm1BWGxERSs0T281MHVPelNmempzS21zYU9tN09YNzhYQ3RzUFZ2MmJ0S3lY?=
 =?utf-8?B?NytuM0Z4dVNLbytNSUlKMUFuYnQyRzFqWWVyeHJtWmowQmJ1S0xSRkZPM1NW?=
 =?utf-8?B?VGZjd0VpL25GK0crNGprdU9ncnBhNUFSSFpQYUZjZWtRaVV4enJaMnNZWEVI?=
 =?utf-8?B?ay9BQ3lYQ3FINVkzRnZJaGNvKzVwQjdHYWp5TllNOEo0OU1UVmRIQ0VVUm50?=
 =?utf-8?B?MlJ1TExYOUt0dUtXZUV5WHE0T09NK3VoNjRJWjJiMWlHNy9OR2hvWTlxSjZR?=
 =?utf-8?B?SGpPb3JrdmhqNnF5NUtON2EyVllCZ3hRY3Z0QlFKSnVVU0ZxQjZpVzE0UC9O?=
 =?utf-8?B?YWo2K3VQRUxybTZUL3BGaXRoTUMzUEM2cHo2aEoxSXhOU3dndW1COG9Oemp1?=
 =?utf-8?B?WWJyYm5TSmZubnBnZTdkSkNlUjNRUWZYdWZxc253MjgvOElIS2oxWis3eGFh?=
 =?utf-8?B?Qi9ZR0tUNUtlSFQxSUtsN0RhTDFvYklqejZLQklDbUVMVWdEMWVxZFhVaDdi?=
 =?utf-8?B?TFMySm1YTllub3llQmU4NFBkMDFxdWRrZGIwR1dGYkdRNjNxOWlQRUg1SHBn?=
 =?utf-8?B?bURsRE1LVnZlYUVlZ08xNVNLNVB3cjd6ejF3eXc0R2gwMUFLSVlTTis1RXd1?=
 =?utf-8?B?NVJzQ2FLQ0xETFF1K29mRGNpNzh5SHA1YnZIZW9ZN2ROUVJvNU8yMjdPYXJZ?=
 =?utf-8?B?SUloN3dOd2ZrRlZHWVZhMFNvUVFRQTYzdnVidG5aZ1ZhOHd4OGdCMmU2bm1t?=
 =?utf-8?B?bDBvcGNHSXB4TGxJUWVOVHJocnZZNUtLVnh5SjlLNXhBei8yQzM4cDNKbWJ6?=
 =?utf-8?B?VFh3ejJVdmQ0dGtSZ2dHVmd3ejdnTnU4VmlySUN1b214VHJOd2FXMHJNbmU5?=
 =?utf-8?B?Uk5RblVrV2ZtM01Id0F6RUlNQ25yMU03d3lXL3EwQWNnNXRXZUUydjdTYlhS?=
 =?utf-8?B?SFBGMmptQi91dEF0aXdQaE96OXpMT2xtN0lmenhCbXV0d0Q0b1FBWm9TTG9R?=
 =?utf-8?B?aDRUbHgzWHBBYm1yMkcxa0RYc3lJemlpK09OampsVEIvNnA2cm5rYzQrREJz?=
 =?utf-8?B?UnZHSXFIbGV5MEwrcjlsZzVtS3htdm12cjBOWDdXbG1aZ1BUeGZNUVVaQWhL?=
 =?utf-8?B?QTVWbUdlQ1RhQkNLUVFFNUFlRVpWOUZtRTAwcmgrNzJyWTR4MkhmSUcrTkFP?=
 =?utf-8?B?M05jOFJIdjhhL2diYTlUMGFnM3ByR2hqejlWUFRQdkFjZU4vcEIyMVgxVWho?=
 =?utf-8?B?MTBYQk12aDFmdHpEd204Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlROcjJsZnpGdkNab2o1Vmd4WnF6b2FlVjJMNkJqam96dmhONzF2Qm9jQkYx?=
 =?utf-8?B?TXBQbVBua2VzNS8rUUlKUllQVVlFYlo3aVduV2hDVDNRbXA0eWg1NWw0cTVx?=
 =?utf-8?B?TTBXNnV5b2tEaXU5WjBLNHdkZE4zSVYwWFhEVUJlbzlnRXQxdndTcnFwc0NR?=
 =?utf-8?B?dldvZytkM3BPNk9uVEpuSmEzOGYySCt3M09WM0xlNnFONE5RR1hPNHJFRlRI?=
 =?utf-8?B?a1o4Q1ExRUNpMVNDZmh4a3ZpRGprcXZZekhVZS92dDZ6VHlnZlg2RnFiSVNX?=
 =?utf-8?B?NktUWUJYcGhRN05jMWx1NEE1VWlTSHBDQ3NjM2lneUJpL1FWTElSTFVCVjJi?=
 =?utf-8?B?azNqTE9Nb05qcWpPeFpPbXZjK0lTbXZhWjBFWjcyaU5YSlp2ckJ0cHlxUi9B?=
 =?utf-8?B?ZThEQ1BXTkN4a2h6bjdLaDdHc2NUL3FoK1AzYzlhMk1VMzBUU2VtZ1BiZHVW?=
 =?utf-8?B?TnBrd0w1UEcxWjlDTXY0MkhsM3dabldKcU5TNUxXbEl2bVl3MHkydkZCOHU4?=
 =?utf-8?B?Y1JORXBCT2FydC9TKzVqMFZHRTBCNTJlTmUvYnp6TTRTenhydklLT3BXSVli?=
 =?utf-8?B?bDU2N3VLTHRhSEp3NWdBMndrQ1lzSzFIczJncExMYUVidzMxaW8yREpwa2RK?=
 =?utf-8?B?STR4bE1BNmNVbXZ0KzhoTStoR0FSKzZLdUxMR2cwRmxhV25JOGlBYjhXTTY2?=
 =?utf-8?B?eFB0RmJ5RnpVTUswbmlQV21mekdqb3dWeFJzeXBvalc3MzVsSit5K3YwYTNk?=
 =?utf-8?B?Q2tmbmcrcDdxWlVsazBsdmlBTzJrUXRBRHVVM1NsbEJteXlDRWxveWVLNTZj?=
 =?utf-8?B?cWVxT2pjUjFWTkg5R1NVVi8vYlJMVlVCRS9LcHJFZlhvejJPV0pVK21NYjNn?=
 =?utf-8?B?cXpua0h3c0dwdkJxczJJOGdubTZUZkoxemp1aXgrQmhXazVRYTJqN0RUcU5P?=
 =?utf-8?B?NDZKVkdvdmFURGlKVW1DYWFYQnlyMnl6RzY0MXExQmlVQUErVjBrRkJjS29H?=
 =?utf-8?B?ZzNYUXJzNng5K2FuTFdVYnhodUlMTWRld3h0N0N6K3lRaWpWeHB6TnMzR1hW?=
 =?utf-8?B?azhtd3RkRzZYV3NKdXFOUlR0RjdDZkFGQ0dLc09pRHJVSldWMm1zeXZETklp?=
 =?utf-8?B?eGFua3NuM3oyRkgwTjR0RFZTK2pyUGVuMDBGSXBGbW1aV0hpMjFxczZtZ1Nk?=
 =?utf-8?B?alQ4Z1lZS1lsSFJiajJpOTdvSXV5KzUyRWxVcUltODdmU1RMN0p2d1BIb3ZP?=
 =?utf-8?B?T2JocjErRm5xWWRvMlRPMG1BUXR1VHhDT1pPbUV0RVV1am1HaTJJZ1U0WGVq?=
 =?utf-8?B?RzJwMStmNGZPcHBBWEtwK2gxTThJM3BGN24rT0M3OUQ4bDhFUllwRHNtbmxy?=
 =?utf-8?B?b3lZL1F5RERJMVg4eE1tSFdoaFh2S2NlcGwzSEtJQmZ3RnJXS3VaKy8yekFa?=
 =?utf-8?B?RTNZYmt5aHovbUZRTGlwQWtLalJMUnFwR1Naam82dmJ0ZkMwbzN0enh0bmF3?=
 =?utf-8?B?ZU5kZFVOSVUvS28yNmoxclMvdW9tUkoyR0oxdTBvcTV1dXJ6bDUyYWJqV0FY?=
 =?utf-8?B?R0hwTkdyNElVWTRLbjExSW1FSkgxZE90c29YZGpnUFJvM1o3VDRzT0srckpv?=
 =?utf-8?B?UzB5NGJTbHhSTlhzMW9BekgrV3dma2s1TTE2aG51RXV0RU9Qc1FpZWQwNzhT?=
 =?utf-8?B?VWEvTWpxNVQ5MldBNDc1Q1FkNnRJRXVibmpSZVhNdDBzWE5GZHFySUQyOEF4?=
 =?utf-8?B?cnVQaVJPU2VLZzFVMGlkV04vMFIxaitwb1R3SFQ1TGVXdjY3T3IxYWs4VzQ3?=
 =?utf-8?B?RXFadFBPTlVzdDBMMk8zcHRORmlTK1JOb2Y5alNOUDlxemE3QkxkRGVTRXhC?=
 =?utf-8?B?eDlsRzlXSFB1VTZJdUtkVFB3TDFqTGZsUzl2NTJpZDVzMFhlUHF0Y1JXVkUv?=
 =?utf-8?B?V2w1bGIrZk5pdm1wM3JMbnVCSHRueUcwcEQvQTZVREFRaERwbTQ3elJHQm1Q?=
 =?utf-8?B?TTMwWTl5UGhNQ2V5Zy9XRzFvSkZMU3VkTFdaMEg5UzZlSndzZUV3Rk9ZYWhm?=
 =?utf-8?B?WUJzbjdXTUxVd1BQdHBIVC9ZWGpKVnViTm92d2pXOGFlQ09CYW1oaHB5cG95?=
 =?utf-8?Q?u1qVptGo9GYXpnKy6G7fUkfx7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf56443-58c4-43f4-aa47-08dd2bc0b469
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:34:42.0993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1K5yTriRU+0Odalk4iqy8VTvP9Kesq+qyOSbHZaMGA102QAGBKaMzGQEqnEOmW0npXemIWdFkcG27VZt7VepeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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

Hi Shashank,

Replied inline [Saleem]


Regards,

Salem

On 02/01/25 18:58, Sharma, Shashank wrote:
> + (amd-gfx)
>
> On 01/01/2025 07:03, Saleemkhan Jamadar wrote:
>> #resending  patch
>>
>>  From 79cd62f882197505dbf9c489ead2b0bcab98209f Mon Sep 17 00:00:00 2001
>> From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>> Date: Wed, 18 Dec 2024 19:30:22 +0530
>> Subject: [PATCH] drm/amdgpu: user queue doorbell allocation for IP reqs
>>
>> Currenlty doorbell allocation handles only 64 bit db size.
>>
>> In case of VCN we need to allocated AGDB and per instance
>> doorbell.VCN/UMSCH doorbell size is 32 bit and offset
>> calculated is from specific range from the allocated page.
>>
>> With these changes individual IP can provide specific reqs
>> for db allocation.
>>
>> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 41 ++++++++++++++-----
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 12 ++++++
>>   2 files changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index cba51bdf2e2c..4fff15e0d838 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -163,18 +163,17 @@ void amdgpu_userqueue_destroy_object(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>       amdgpu_bo_unref(&userq_obj->obj);
>>   }
>>   -static uint64_t
>> +uint64_t
>>   amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>> -                     struct amdgpu_usermode_queue *queue,
>> -                     struct drm_file *filp,
>> -                     uint32_t doorbell_offset)
>> +                     struct amdgpu_db_info *db_info,
>> +                     struct drm_file *filp)
>>   {
>>       uint64_t index;
>>       struct drm_gem_object *gobj;
>> -    struct amdgpu_userq_obj *db_obj = &queue->db_obj;
>> -    int r;
>> +    struct amdgpu_userq_obj *db_obj = db_info->db_obj;
>> +    int r, db_size;
>>   -    gobj = drm_gem_object_lookup(filp, queue->doorbell_handle);
>> +    gobj = drm_gem_object_lookup(filp, db_info->doorbell_handle);
>>       if (gobj == NULL) {
>>           DRM_ERROR("Can't find GEM object for doorbell\n");
>>           return -EINVAL;
>> @@ -196,8 +195,23 @@ amdgpu_userqueue_get_doorbell_index(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>           goto unpin_bo;
>>       }
>>   +    switch (db_info->queue_type) {
>> +    case AMDGPU_HW_IP_GFX:
>> +    case AMDGPU_HW_IP_COMPUTE:
>> +    case AMDGPU_HW_IP_DMA:
>> +        db_size = sizeof(u64);
>> +        break;
>> +    case AMDGPU_HW_IP_VCN_ENC:
>> +        db_size = sizeof(u32);
>> +        db_info->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 
>> << 1;
>> +        break;
>> +    default:
>> +        DRM_WARN("User queues not supported for IP (%d )\n", 
>> db_info->queue_type);
>> +        return -EINVAL;
>> +    }
>> +
>>       index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>> -                         doorbell_offset, sizeof(u64));
>> +                         db_info->doorbell_offset, db_size);
>>       DRM_DEBUG_DRIVER("[Usermode queues] doorbell index=%lld\n", 
>> index);
>>       amdgpu_bo_unreserve(db_obj->obj);
>>       return index;
>> @@ -242,6 +256,7 @@ amdgpu_userqueue_create(struct drm_file *filp, 
>> union drm_amdgpu_userq *args)
>>       struct amdgpu_device *adev = uq_mgr->adev;
>>       const struct amdgpu_userq_funcs *uq_funcs;
>>       struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_db_info db_info;
>>       uint64_t index;
>>       int qid, r = 0;
>>   @@ -269,19 +284,23 @@ amdgpu_userqueue_create(struct drm_file 
>> *filp, union drm_amdgpu_userq *args)
>>           goto unlock;
>>       }
>>       queue->doorbell_handle = args->in.doorbell_handle;
>> -    queue->doorbell_index = args->in.doorbell_offset;
> Nack, this is going to break mapping/unmapping for GFX UQ. Nothing 
> should be removed from the queue structure, as all of it is accounted 
> for.
[Saleem]:This assignment is not used anywhere, moreover it gets 
overwritten with mapped doorbell index below.
>>       queue->queue_type = args->in.ip_type;
>>       queue->vm = &fpriv->vm;
>>   +    db_info.queue_type = queue->queue_type;
>> +    db_info.doorbell_handle = queue->doorbell_handle;
>> +    db_info.db_obj = &queue->db_obj;
>> +    db_info.doorbell_offset = args->in.doorbell_offset;
>> +
> I can see that all the information you are adding in struct db_info is 
> coming from queue only, then why to add a new structure here at all ? 
> Instead, you can just do this in function
> [Saleem]: In previous impl you can see that db_obj is fetched form 
> queue structure. In case of vcn we have mulpitle doorbell to be 
> allocated, to accomodate this and to avoid the another level of check 
> to identify which doorbell is being allocated this db_info (structure 
> used locally) helps. db_info shares data for which allocation needs to 
> done.
>
> amdgpu_userqueue_get_doorbell_index():
>
> db_size = sizeof(u62);
>
> switch(queue->queue_type) {
> case VCN:
>     queue->doorbell_offset += AMDGPU_NAVI10_DOORBELL64_VCN0_1 << 1;
>     db_size = sizeof(u32);
>     break;
> }
> [Saleem]: This change I can make.
> <same doorbell offset calculation as usual>
>
> - Shashank
>
>>       /* Convert relative doorbell offset into absolute doorbell 
>> index */
>> -    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, 
>> args->in.doorbell_offset);
>> +    index = amdgpu_userqueue_get_doorbell_index(uq_mgr, &db_info, 
>> filp);
>>       if (index == (uint64_t)-EINVAL) {
>>           DRM_ERROR("Failed to get doorbell for queue\n");
>>           kfree(queue);
>>           goto unlock;
>>       }
>> -    queue->doorbell_index = index;
>>   +    queue->doorbell_index = index;
>>       xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
>>       r = amdgpu_userq_fence_driver_alloc(adev, queue);
>>       if (r) {
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 2bf28f3454cb..3d54601c6a24 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -39,6 +39,13 @@ struct amdgpu_userq_obj {
>>       struct amdgpu_bo *obj;
>>   };
>>   +struct amdgpu_db_info {
>> +    uint64_t doorbell_handle;
>> +    uint32_t queue_type;
>> +    uint32_t doorbell_offset;
>> +    struct amdgpu_userq_obj    *db_obj;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>       int            queue_type;
>>       uint8_t            queue_active;
>> @@ -93,4 +100,9 @@ void amdgpu_userqueue_destroy_object(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>   void amdgpu_userqueue_suspend(struct amdgpu_userq_mgr *uq_mgr);
>>     int amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr);
>> +
>> +uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                     struct amdgpu_db_info *db_info,
>> +                     struct drm_file *filp);
>> +
>>   #endif
