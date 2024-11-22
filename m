Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF18E65D2F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 07:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A4110E07D;
	Fri, 22 Nov 2024 07:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oQ+MShbS";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E592110E07D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 07:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP6WmsTInEdI2RV/qL4Sxj3P68Z74UUiEWu8R8w43qYoO74ccG1wgA6z7klkVvfI8G+/rJLaXAQwOAdrStEPjXEeOYuvNKxxWlN3QsALFNDLaIuLFaMCAhAa4BD4W+PXr1eddE8L3PkQMuyMSRBF4ky9rAN5YjrbdYw5oGlXtHt38N/5NJqRXSrElI4pPmslRp2kCcj3ibcNHGCsQfYFx9jjlvXy7FGJxYs1A/DrBlnoPLMV4hkc4cAhfPVxmUFN+7Xp62dTqCHVaxJNSNqOFHrBEZxfRUkT+U4PG9PIl3EJ/jdOu9AEY3BK+CjpV6gjb3MrF4Ukn6KUqE1fxQRiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx7d87xKxlhKPLS/7Dhb/6zSh3f9GlCylcKr7tM7Nfo=;
 b=sntmFMUxf65qTRTO8RkMddblVnPf2vhwv1XjspnlQ9uUlkqPpMG4ovZd6MrSufDji/tTJtKTUlCuBfDiS5hcu6lnsLnpl6wSGSRqmARFCUEsdtzGMQ60axxDzHHZzFyC3tmjwCSxqjX87/GWkAeO9nAP2yh4OK0uCNUQQ+u0Bg5tZvvZMdjyZrlVKt2Ecen5cHGsEWN32exuqMSduUhzUziQ93GNa9ew4Qw5PVCMsQ8cspB8HXMogCDD4Lu39FkY6BGnuTnBOQ2VRV9wtO11kHgrr0JUGNovr9HGUHaLSelwtHhsyHrbHWEr7vB37bCcNPRJ7EpstE6VOy4z01NzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx7d87xKxlhKPLS/7Dhb/6zSh3f9GlCylcKr7tM7Nfo=;
 b=oQ+MShbSAozyk9Re8eTRI/aevgm4Ns4OCb3fAS/h9GZGGBowW6FBtdorVJK2IcQQaNOix5UDcwiUmUvXwYYRGKkeLVGtP+NmXslyUiDD8tb0fJErcDqMYK/Y1w2opkobIjTEriB1ODFwxTyd8QfGOlsJxWgYDzEkbtwZQ5JPIag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 07:59:48 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8158.017; Fri, 22 Nov 2024
 07:59:48 +0000
Subject: Re: [PATCH v1 1/2] drm/amdgpu: fix the variable name in comments
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241121173746.2690646-1-sunil.khatri@amd.com>
 <0abe2992-b3bf-4114-92de-979cd060c044@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <e55c6650-c64e-feee-2390-88a78d4c8050@amd.com>
Date: Fri, 22 Nov 2024 13:29:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <0abe2992-b3bf-4114-92de-979cd060c044@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5c4bfc-1f72-4d5f-a5ed-08dd0acba2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3FLZjd3ZEozcjNXUXY1emNUczY3bHdrR3dWYkNlempPLzhMK0xaREZDeStI?=
 =?utf-8?B?aVZoMEI0Qm1XRDhlQ3U2SWFQWkRvN2h2QjFOS3R4RVA5b1VPMTg2QXNtYUJH?=
 =?utf-8?B?V3c5VUxGN3NzTFJxb1NwdWF5WnQyK2xOR1lLeG15MFBmaWhnanlWeDYwMUo4?=
 =?utf-8?B?VGJ3WjZ6Uk5MR3h4WXpjandIL013cHRBOTV5bWxCYjFZZUloUzdMUEhoaWVP?=
 =?utf-8?B?OXpsQVEvcTRrYUpmeDZrKzZURFplQ2lNTUN1RUpFeVlGUFlES0ZHTzFoRHEr?=
 =?utf-8?B?em1ZaWQ0QVA4YjVvNE5abk1SeElqTU1GS2N0VW1oR2NaU2ROQ3N1Ky9OUEs2?=
 =?utf-8?B?TVNjdElBMTFnVUNnOG93QkZFZnpKSjJwZHh4SXdPT1UzMDlRWmZMY1lQUitD?=
 =?utf-8?B?NC85bmJhLzA5bXZ1alppMGN4dUwwalJ6NTJ2cE93ajJlZVlvYW1ZTGRnc29X?=
 =?utf-8?B?c1dyOU1MTzIya3lrWmlhMUhQU29aam5KSlpyZnpod2wwbXhTK3lFMUViRmpl?=
 =?utf-8?B?cEdUTlNIbDRrVzBGZ2V6QzR0cDJmWnhscHlJY1BNcVZxOGxJeHJUNGJpSi9H?=
 =?utf-8?B?RDVqVG5FanQrbEdzQ2F2S3FQM08vallMWStZdkNhSXRvSHBaaDlFRFpvdjRs?=
 =?utf-8?B?bUpMU2pNRXQ0NFdrb01Kck5sQW4yQ2ZaWEFZdzNxMzUyQ2txcEl6T2Y0OW83?=
 =?utf-8?B?Um9IU3gzSFJjbDB3bDkycTJIMDlKNm5yVzNVWlNpK1lsMnM3SGdGWkVsMDho?=
 =?utf-8?B?bHZqT20vYlVMSGVTazZxS1dnMTVTa09PbzVManY4SWU5T2hlMEtpek5PVEhR?=
 =?utf-8?B?N0ZlTVlIcW1PSjVMVXFNMDdSRlBhMmxTZk5tNHVNVmJNMUV6TkRPTmEvd0ZX?=
 =?utf-8?B?ejQvNmZCYXJNRDRTQWNZU1IxN3JqWlE5SHFvZU5LSFVaRmN4SFREdXlnVFRr?=
 =?utf-8?B?S3FYSmQvVmFoZzk2ZFlyT3UxK3E3MGgwQUJ1VktNUDVRYlIrVG1DMi9DV05S?=
 =?utf-8?B?VUpPdWdHMU5hZk90TmR3b3lCUTAzQ1F1aXhnQjk5UlI2ci81ZU9tUGYvNW9t?=
 =?utf-8?B?S0hZY1RpM2R4eFNBMzhEMWFBNEExZTlYWm1Fc0syMjJkOEV4ZzA1bmIxSnFy?=
 =?utf-8?B?RzBPVGczT3U1a1hLYy9ZeWRmdlYxc2ZiTWcycThPREZUZmVjMENaRXFlQ2lX?=
 =?utf-8?B?SGl1V1FteWZLc1VpS3o1VUlyLzM2cmk0NTh6M1crZVpSbXZWbVpoWmFzWW5p?=
 =?utf-8?B?Tnpqemo5NXoySkhRM2gxaExMUlRQU0YzQlZYKzhhQ2Rvd1hSOTZpc1c2aVN2?=
 =?utf-8?B?YlhZTzdYWlA4YU1XYisxWTA0SFdNZE90SmJURnZwU251SE9PZmJoQllUYXVB?=
 =?utf-8?B?VmRmWjh0T2hjdlRFM2dOMGpuOXdqaGU1aFJ1dHFlL3R6RkwxYVRBaXQyb0NS?=
 =?utf-8?B?alNpOG56eTkzem5lODNWSlZYR2gxbDc1Y2lSRS8vL2N2RHM0NXJndWxucDB2?=
 =?utf-8?B?NTloMkdHSnNYcXhTcjVCckYzaldNMitYZGk4eStDMEhtNVRMUkdwUkw2SExj?=
 =?utf-8?B?eTRVNThsK1ZxcVFVd2JlSVlSWjJGUHRvTHVEMkpaUkJuM28yb3JDUUtNZkRo?=
 =?utf-8?B?dHJMQWpCT2hOajM1NE9jT0JNRi9mSzlxS1ZOS2RyR2YrK0g2bStCNHNsMENK?=
 =?utf-8?B?Nm9QcVo1NTcyQnBDakFNQ1AxVG8yVnNCSVk4bEdScEtGQ1IxNXU5eHBpNXZF?=
 =?utf-8?Q?zOeyDk1DdezV3/zUKbnVF8heg505t2cLzDb2L/Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elI3OFUvbU9DZXZiRmJyWmYwOENQSGNjWEFQUTEwZE1zUDJaaDMvNWJMd05Z?=
 =?utf-8?B?NEsvSUN1STcwSElmSVZHNzV6aHdhTlJGVFAzTDZ2amxWRmZkeWsyVUkwREVB?=
 =?utf-8?B?OGdIektwbkNLWitRSmI2VzYvbDkvNklGVHoxWHlUT0xtQmJvU1Y2NDNDSklv?=
 =?utf-8?B?WEREcVZESnI4SG1VNE9VWlgraXNOSnpCVlVGT255VUdaMkZFTmZST1dHeUtJ?=
 =?utf-8?B?OUhBMWV1dElqT1QrOHJXUHlvMWQ1OGk1UWJrcGZpaVhZQUx5YUlDZ2J3ZDl6?=
 =?utf-8?B?Y0tpdnAvUmJWaS9PSUR4ZjdxajhyMHFWcXJNUFdkallGQ0JiK2I4cllRRENj?=
 =?utf-8?B?WGc1aFpaV2lFcFU5b1YwQjhkOFplc2w3U3haaW9UU2JpUmNqOEJLNWJYNTRh?=
 =?utf-8?B?RStnYUkvcHVMcURnLzJTUGRoYkVGVFQyMlhsd01JNlBadFA3VjZ1Zk9jQ01N?=
 =?utf-8?B?cTVHTmd1WlVnQmQ3ZFM4dlRzbWQydHBLZDhKSmxXOUlFM3MwV085a0NFSlpX?=
 =?utf-8?B?c1VzTlRpODZLREJITWRhNlBqNDM5Z0tHSzNzeUgrbXdWbHdpejBqT3RzUjhY?=
 =?utf-8?B?czRBV3hRR1ZPbW55VGFQbUtISFVaM1FnMjNBM3IwVzJBaThSNTUzemp6bXBB?=
 =?utf-8?B?MU40ckFXNXliSjZjcHRITDcwbEI2QUZnWFJnVThvaTF1emprMkdQV3hxZmZx?=
 =?utf-8?B?bzhIY1VuS0RQN3lFUy82b2ZOS0MzS0FYZlZxZDBHYml0VnovWDVuVFJlYW1B?=
 =?utf-8?B?OEtOd1lzN21CNGw0c0dTRG1TL0RUenhIa29NUW40ZE81R21sdmZLUVU3bVFh?=
 =?utf-8?B?OURQTFZsVjRiTVNKZDVzNXNWUEdyRmVpWllWd1MyaStIN2JUMEFxTStWaXFw?=
 =?utf-8?B?SEhMcXZLdW5xQkdqa0dteGRGak8yaFc4R05jT0ozZngwSDM4SWV5Z3ZaLzA5?=
 =?utf-8?B?UTMxOTRXM3kvRlJ4OVFDV0cyc3NsRUlYRTlBdHROU2lUTGYzTmpES3pIaE1l?=
 =?utf-8?B?bWdWeHg2WkNIaFFCRXNlZmxuSklGS3RBNGZhLzBsZG41UEFhaXVmdWpjMzc1?=
 =?utf-8?B?cC9rVjRsS20wRjc5SEJ1YzJCVkNHOFlkYlRsODFvWVU5RGFKeElOdkE5eUE0?=
 =?utf-8?B?dXBjdy9JUWhjZk9paSs5aEtFd0p4bmJoOGtGMjVjVHRqOHliQjNFa3RxRS9V?=
 =?utf-8?B?R3hlVjJEUTNrd2VxNCswaW80bVdjOHpXcWxISExuOXJ3Z1I4UFZKVVZCaGVR?=
 =?utf-8?B?cTRJVjVhM0NCWEh4SHp1cHozMm1kS01NbkRham8vT2IrMkpBNldxeVE2dEhq?=
 =?utf-8?B?dFMxN1ZJRkp1cGlHcWw0end5ZEJDYUxyL3FWSS84SDZNZEtDY0VCTWFIVGN2?=
 =?utf-8?B?cU1hdVdFdjgreDhaeGVrOUVCSEdYSWQ4V2xsNlkvakhvcGNTdThNSmkvTTdS?=
 =?utf-8?B?b2ZOZW9DbjJRNnZnUDhqcDV2UVFoeUNaZUIwSVNva0JubzNPSmxKMisrWFJJ?=
 =?utf-8?B?SFB3M25zQVBIS3VlNkJ4MG40L1Z0STVGajhtdTJ3L0tKbUlpMUQzK0JmRWRU?=
 =?utf-8?B?RWxpNjFWTDF6a3I0d1ZWZjNVYzVCREFRUTc3WEN4b0ZiZmJwNllRbWZiM3dj?=
 =?utf-8?B?SXdueDY0L2xhNmFFNkVNTmVJOHdxbGRTa3JIWWttMmd5MWRCMmlOVGNiM0hC?=
 =?utf-8?B?Y09hU0t5NDc1UUhCN3QvRmg1VXN0S25IVmlzcDdML1ZYVHJ0STBCVWVWQTAw?=
 =?utf-8?B?bG9aVEhMT1RVSGV6WDFIT1NzTUdhaEZKQStsZVJzQTI4NDZMWHAvcnl3eUpt?=
 =?utf-8?B?aE1Ha1pVQXhoamdIWTVpclVVU3hGYnlGSHNGQ1JzUnZBWlJGTHZYMHhXWXVk?=
 =?utf-8?B?NmVUbEJ3K1QwNWcrSUI4R05HUzZ3RWFqTEFFMlhpMDBXZ0dZdkhVMEZTQysv?=
 =?utf-8?B?V0JuQ3kzZVZtSVpyNmI4M1M5VWhBUUV3a0JzRXR6VFV0M2d3V1E2bUxsNDl1?=
 =?utf-8?B?ZnR6WERjWTFyK2dwMmxkZldRcktpNnV5bElRQWo5Q0pvaUtCc29xWUw4S2t2?=
 =?utf-8?B?UWpKSi9YSFl4RVY1Q2pmY1poejBZa1lsNk9DVEdZNkNPcEJtMmVWQ1BXTHFq?=
 =?utf-8?Q?ezmA4N64cqz4CjM0XazLRYxFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5c4bfc-1f72-4d5f-a5ed-08dd0acba2a5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 07:59:48.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oK6ttKf1CPziQIHW0fwIrEaIzikgaWBQ1rtfC0/CJmn6P0jF4OyZ3J3r1Z4rcUGc2X4EWMCe9Imid5IiJs8YIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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


On 11/22/2024 1:20 PM, Christian König wrote:
> Am 21.11.24 um 18:37 schrieb Sunil Khatri:
>> Fix the variable name in comments to clean up the
>> warning in amdgpu_bo_create_isp_user.
>>
>> warning: Function parameter or struct member 'dbuf' not described in 
>> 'amdgpu_bo_create_isp_user'
>> warning: Excess function parameter 'dma_buf' description in 
>> 'amdgpu_bo_create_isp_user'
>
> Mhm, I think I would rather prefer changing the variable name.
>
> We used dma_buf basically everywhere else.

make Sense. i will update the variable name rather than the comment.

Thanks Sunil

>
> Christian.
>
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4e6d218839f9..89d84820e4b0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -357,7 +357,7 @@ EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>>    * amdgpu_bo_create_isp_user - create user BO for isp
>>    *
>>    * @adev: amdgpu device object
>> - * @dma_buf: DMABUF handle for isp buffer
>> + * @dbuf: DMABUF handle for isp buffer
>>    * @domain: where to place it
>>    * @bo:  used to initialize BOs in structures
>>    * @gpu_addr: GPU addr of the pinned BO
>
