Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A5D37487
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 12:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A97F110E329;
	Thu, 17 Oct 2024 12:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEfjVD6p";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF0D10E329
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 12:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FErRonmZJlY3gjBs0eftKDEu0LV9yHos99f7xuzy/nc/aoDGtqPhEeUh8khXOeANpO3wZnqyoATZmNikzvfH/XbDeob5DtR7NeQwkA80f5aUGvyCLRoSAEnNgIA2hXTwIV6KCd9+4QOM0alDLYUOovv0VXT6LtvLcjs/GIefrtw1BUK3zOvj3CLKWHeR80i19tmOOVE+7LWZbvBY108n9jmASCvpJ5ENveumAvh3aIvO7o3KncIKH1CFHUwJXDco84/lWJT68SxBOOVt3RHLgiHAePoVaKQbuZiwYaEFeM9CGueUHk68ZrDy+Qi/EU7A99+Z8rxaDCx7jXSgx+F7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8BfBKitlylM9hr+GmQqWs5rGdy9mtNQXIknO1j9v4s=;
 b=Q3Cic08EU1JSoLuqVRwl550rcPnL+l7ueOetQVrs1dNwBcdB1yzz0IfWClqFG4Y5YGDdXIUEtQ9YaqsplrPQp6JUAo3PmG9ZILl8bNP4Y2FisOlYZIaAYRJQwNLnwRlaczHvbumtkVbpjqqoXEYAdNOIX7VM5x6hNDrwICnekvec8EXt4gLhDN8yVGJwxzeEJvPEa/R6cZSfCXKg7l1CTSwpQ2VtoXZRFl2F0XKi7x8Qc7xOR/qK/5d3aay3PFNKz66BjQs4zFkkbZYa+R83i2ND79rLRef49+67dyFr94NX+2cgTnNJpvVS/vCeCZUMIwMKJXcFEqtL+fCmq7xJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8BfBKitlylM9hr+GmQqWs5rGdy9mtNQXIknO1j9v4s=;
 b=AEfjVD6pRgvtPRJl5399zmeqf8DoecQp9FHaOyt6aCeFnLdssiMFyPOCkdlQHRL1VnZosuN84xRaViZPm9huQ5mw0NRFhrIIX+rg8GiLo3Ymh/e0PvoXd5kSo/ptcJFdjJXFiuCkYXXcUioZUi7JBknKBeykwVf6IKkj3HwQkR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 12:46:06 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:46:06 +0000
Subject: Re: [PATCH v4 07/15] drm/amdgpu: validate resume before function call
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017100615.1492144-1-sunil.khatri@amd.com>
 <20241017100615.1492144-8-sunil.khatri@amd.com>
 <bd5cebef-9423-4cd2-a965-208735bca523@gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <f45a4aff-c772-3344-5b16-1aa147b9ca09@amd.com>
Date: Thu, 17 Oct 2024 18:16:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <bd5cebef-9423-4cd2-a965-208735bca523@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0134.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::19) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c49567-8ec8-4513-dc67-08dceea9ab05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U05EdnFPdE5aKzJScm1oN0ZxNXQzSS9HTHFQWENIYWI5N3h1ajVkcGZoSkM5?=
 =?utf-8?B?U21vaVpQUmVXSnVYNVY3a0l6OWdwcGtKTDZwTFoxYjA5Z2xpcnozeDJ4eVhV?=
 =?utf-8?B?TC9mNGJ2dUtlVzVqTThPNWZ5bTdYSE1YTGNsTEtKMnRkd1dxUzducms3MnFs?=
 =?utf-8?B?WDY3STNxdmxDTXRiWmQ3VkNFd2hIOEgzT2p5bWEyQll4dzJrZUtNV01DL28r?=
 =?utf-8?B?VnZMRzUzcUo5eFZsNWIxYi9oNE10OC9SLzNUZVdVdTZsYUNqc2lCZmRmUDBi?=
 =?utf-8?B?NGFaa3hDM3A4M1E2ZC9MU29vUi9xTWZRUDRxTUhvYmk0OTgySE1nRkxxTWR0?=
 =?utf-8?B?a2NsVE0wdnpYbjlWQ1BzeHhWQ2U4eTErb3FsL1FKRjQyV2VTMEZkZ1VCYlBi?=
 =?utf-8?B?bEFZWFNZN1h6Wk9od2JwblRhVm41Z0RQRlhISVZRTGZMTDVBdFFQRm02OVBV?=
 =?utf-8?B?bzVSSHFrQlhlaWZRVHpTQktzTmwyMDhwZ1dEUWszczNpSFYxcmpzMVJJVlFZ?=
 =?utf-8?B?OFhMUXlEYmF2Z21VbWdwaUwySEh6N0ZDWTBFUXhsRzJMQ293OTNZbklMZ3c2?=
 =?utf-8?B?cnFLaHE0c1h5MGRxaE9ZY2d4Rk9qT2hrRkxGS3JLY3FlMVNWLzlmbFM2MExV?=
 =?utf-8?B?cm4zemF5a0VvejlHTmF1YUthNE4yZkxtWnl1QmJUQm5kRzFKdlBVSnVod2VJ?=
 =?utf-8?B?UExXRlRPTkg3RGM0cUVKQmp5ZzdNWWlnL1dkL0E4TjN0emVjUlFnRSsxWUx2?=
 =?utf-8?B?QTAveHphOVc0ZlFCUENldURYUVBxNUlhLzdSUm9sc3dwOXNMcGsyUXRIeHBJ?=
 =?utf-8?B?eURCOGtHd0N0ek1WeXJFYkdNNUFDWUIxcURtdWZxSGRySi9WWFZmamFkMkpL?=
 =?utf-8?B?Z1B5V1B5TFNCZk5aU0M1cnJJOVZuQWRuYThWMDRadEt4ZzlBRHhEOGswUVVE?=
 =?utf-8?B?Z3d2VHNZMWJ4d3p1elRTSDYwSW9sSjgvbzA3RW5JakovMXltaWVZbkROUnB4?=
 =?utf-8?B?bGRtSEU3SEtBN3ozRlMySVdickhqL0JkWVBsZGFKR0Rva01tbnZmenlMdVlS?=
 =?utf-8?B?VDB0MktGcGI0M2hrOEE3QmhhSlg4SFZXRGQvN0lnS3k1YjQ4M2czR0NONW1G?=
 =?utf-8?B?YytWQmdqOWwxSkVpSnNkZmtPcU1ISUtFWWI4ZVRvZ092c1k0UWRsWktnUVRt?=
 =?utf-8?B?RGRDL0hlTzNhcFo5VG5tWHBJVFhFUEQ2Ky9OVXh1NEFZOGk3UE9vbzVjUDU0?=
 =?utf-8?B?QUd2bnFnL0NnYkdTbFpJdkFOV1dmdjVkR1hUMW00SXNvekcydTRVaGlMSUhM?=
 =?utf-8?B?dUFZRHRQT2pkVTJPWjhjb0t2azBYZE11RkJtSmo5Y0N1SzA0L1UyOXJFSkxz?=
 =?utf-8?B?QjJUYXZFQWNyNXNCdzhEd3BwbkF0L1ZNZzdJOVRrd1NrSndSOXZyT293MTFU?=
 =?utf-8?B?dEIzLzBzZlRnNkM3ZkYyK3JxeVJRVUl0SFhGbTdIN1UzRDZnWlNyL1Z2dTlr?=
 =?utf-8?B?NWNFeitwZnhncGFsRDR4NXRERm81b1NvZy95elRES2dCTHV4QkNzL1lhd3Rp?=
 =?utf-8?B?NmtMeS9rSDVOZEc4OUZtcmd4aU5rUVZEVjRNSWZTOGZtbGRrRmZrVUJUWkMx?=
 =?utf-8?B?ZTJaNFA2OEYvVnpoZy9XSi80a2dlVWg2clFOVDJxbmZmbUZIR2ZheWpkdkd4?=
 =?utf-8?B?Q2pmQW1wZE5BY0VYb1ZmOVVqV2hCdHpFUXBuQjZHZzJ5K3VQb0JPYzFuZE4x?=
 =?utf-8?Q?E7mOgy8JdyhueZotTSgZTOMuhKRFDdU9KgvukRB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRqaEI5MmlTdzBGQzd2alNkMVJWVUhXUkhDYXhhbmVZTXljQlBVcDJYdVJK?=
 =?utf-8?B?TldRY0dGUklBYWtYVTdVVS9sTzM5a0xWOUlYNnIyQk9la1F5cXVWK3MrV3Rx?=
 =?utf-8?B?SHFKTFI4aDVEV3NFTUFmdzVmTjlkNWFudktXRE91UTZNTm41dXdqRlhFTHN2?=
 =?utf-8?B?d1FJQm1KSUFuTDZKczhSZkFGUEtqZHNoZ0MyaHlOZXNvTFBHd0Y2UmcrY241?=
 =?utf-8?B?bHNCTzdDSzhobTdHSis5bXYzV0NiYzN2QkdTRlp3MncvNnRCczBpcTNzY21h?=
 =?utf-8?B?eFJwV0x2VlRDazlsUWQ3QlpiR0YzbmRST2ttQkhYQmVFSWlBUzVCWlpoOWc0?=
 =?utf-8?B?YzY5elNQYm9XZVk1S2sxS0E0dHFXczZDcVJHTXdhVzA2THFCU1k5Mi9tTUM4?=
 =?utf-8?B?M3o4bEZ6V3BReUQ3azJLZ3ovV1Q4M2IwdUFWZjhubkJVQzNpUWRwanJRUHgy?=
 =?utf-8?B?Sm9mWUFZYlBiNWVUd3NOZjlXSkswU3gzV0NhN0FETlBsSzhWMkV4dHJldXB5?=
 =?utf-8?B?RlFRdDJnU21yMEs1TXNxeWJHUFpQYkR2RXBoYjhSdGE3R0ZaSXZCc1pqK2pw?=
 =?utf-8?B?Qy9GRUViL1ZtR2JpTFVOQXBGN2FKWjVGZVliZ1hMeDdwRHZBL0gyRDB4ZURC?=
 =?utf-8?B?QWZJOTBqNTZpenBhQTVuTm5wVUFDSG50cVZwb3ZwZVdtbitDME9vWEhPSnc2?=
 =?utf-8?B?c21vNFlOL3ZHbkpjM01FRjlqZ0VRdWdDeU5iSDc1anM2WXNqbGo0SmxBNEs5?=
 =?utf-8?B?Z0ZiUzRlbzdTeExXdWJMcS9TengxNkFLTVVWcW4wR0lDa3ZyWDhpYWE2TEVI?=
 =?utf-8?B?aTFTdU9sbzgwaEwrSkxiTVlyZmJKS29jcXVXZGJCMnRvRElhSmQ4SEtSMExF?=
 =?utf-8?B?RzRRQnVqVlh6UkFRUDNZbHhCVDhFTTNQWTA4YzhqcDVvbGhwTHdxbkcwZE5Q?=
 =?utf-8?B?c0RLcm0xZWhlV1VxajRpVlBjbVd6clI2TzBMNVpDcWNoVkdHZkhaQ0Q0YUZx?=
 =?utf-8?B?dDJ1MVBtVUpMUWRtR3liNmMrVHpkWFJDMWRzdkJ0eWhpT2FRNUlDYzZBRVVP?=
 =?utf-8?B?OUxXUFNnVTVlYXVFR1NjYWxoaCtFaU9IRlFEMDVKc1ptMDRFQ1p5a25CZzJI?=
 =?utf-8?B?d1ZmZnRxVHBsa2lPZnR1QkRlRzVGdWVseFc3QzB2QXExeG82b0taNmRvWTdk?=
 =?utf-8?B?czl0L1FTWjRtVElBVVNUQ3Mwa1pkV0kyZWNDUVlDMFE3akpxaUs5c08xamJM?=
 =?utf-8?B?cnB4VnI0eXF3OEVzTlNjN3pJZWFPbVN2aHlxWm9pWnZSZWtFdVR0eVZnQ0xp?=
 =?utf-8?B?VTcxY3Y4VVR0R25IOUsvcnFGWVJDRHhBS3ZodllKazV0d1puNXQyRUpvZXU0?=
 =?utf-8?B?eWEzRm16UDVWd2ZmNlZOa0ZHOXlVVS9Oa0xCZmI2UDNiOWNVazlyQ0hVTDEz?=
 =?utf-8?B?b3FMRVhveWdlTXJVR1pBMlE4SDUzSFBMaGU1eEt1STdLbktrV3VVVExTRDlV?=
 =?utf-8?B?L25tanZJTzF5WnUwa1Y0SURqQ05HblhOUGV1WlRmZGNvZjZobkJVZlRYRGJT?=
 =?utf-8?B?blQrNG5mc04wY1BoWVZSR1E4SUlPUWtLZjdVb29kZlgzaDRDVjltUkhuQkdG?=
 =?utf-8?B?Wkh2OHJnWmIrTVFlOU9mNERVTDZmanJoSTl2V3c3c0VJYXQ2UWM1WUZjYUM0?=
 =?utf-8?B?UVlBK1F6NUtlTjA2V25XKzNrK2QvTWZqa21NWWdJY25DakVvOWpXZlowUllp?=
 =?utf-8?B?cjZOSXVYN01oUWNQZUx6R00vclJONzJqNHJNamo2eUI1WkU0SmNEZERkbm9W?=
 =?utf-8?B?TXF5Z3lsZzBadzNmQTByRlFDYW4rZUQ2VVRzQWdWdE1FU2hQRXVrcDZyZ3N1?=
 =?utf-8?B?eExCeVJUTUlaVVE3aFlFTzA2MUE0TEc4MUNzWDg2K25XKzNFL2NnNEg1cEFn?=
 =?utf-8?B?cXRRWVhzT2NqN2pwWmJDU3RKWlgwZmYwQTJ6cndDb2NRMGZhbWppbW1xWmx5?=
 =?utf-8?B?UEJ5RE1Nd3hqTnBmWUZ4aFBCeEpoUXN3UUN4M0NiS28yMGVPYVo0bG05cTZh?=
 =?utf-8?B?K2ZEWmNZTmpCMWtxN0RKdEF3NjVxeGlyaVdxZHNLRGtOWHY1VFJScnNWcVQ4?=
 =?utf-8?Q?euQL4PwPxVQ7Q5FaZe5fsa5c1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c49567-8ec8-4513-dc67-08dceea9ab05
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:46:06.6848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEnaFS3eFlOEw3erTYIOHNLD6MCwyD6S5LvTTWc862CfAEFMhw4Y4n00RRkKIn5ayUTvxnkP4tdCpDcKKDNnRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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


On 10/17/2024 5:25 PM, Christian König wrote:
> Same comment as patch #5, please add an amdgpu_ip_block_resume() 
> function.
Sure
>
> Regards,
> Christian.
>
> Am 17.10.24 um 12:06 schrieb Sunil Khatri:
>> Before making a function call to resume, validate
>> the function pointer like we do in sw_init.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 23 ++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 47 ++++++++++++---------
>>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 28 ++++++------
>>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 14 +++---
>>   4 files changed, 66 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c 
>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> index e55d680d95ce..4dd9af51210d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>> @@ -247,9 +247,11 @@ static int aldebaran_mode2_restore_ip(struct 
>> amdgpu_device *adev)
>>           dev_err(adev->dev, "Failed to get BIF handle\n");
>>           return -EINVAL;
>>       }
>> -    r = cmn_block->version->funcs->resume(cmn_block);
>> -    if (r)
>> -        return r;
>> +    if (cmn_block->version->funcs->resume) {
>> +        r = cmn_block->version->funcs->resume(cmn_block);
>> +        if (r)
>> +            return r;
>> +    }
>>         /* Reinit GFXHUB */
>>       adev->gfxhub.funcs->init(adev);
>> @@ -283,12 +285,15 @@ static int aldebaran_mode2_restore_ip(struct 
>> amdgpu_device *adev)
>>                 adev->ip_blocks[i].version->type ==
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>> -        r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +
>> +        if (adev->ip_blocks[i].version->funcs->resume) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index fda89aeb4d1b..aa7314c14db8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2744,11 +2744,15 @@ static int amdgpu_device_fw_loading(struct 
>> amdgpu_device *adev)
>>                   break;
>>                 if (amdgpu_in_reset(adev) || adev->in_suspend) {
>> -                r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -                if (r) {
>> -                    DRM_ERROR("resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -                    return r;
>> +                if (adev->ip_blocks[i].version->funcs->resume) {
>> +                    r = adev->ip_blocks[i].version->funcs->resume(
>> +                        &adev->ip_blocks[i]);
>> +                    if (r) {
>> +                        DRM_ERROR("resume of IP block <%s> failed 
>> %d\n",
>> + adev->ip_blocks[i].version->funcs
>> +                            ->name, r);
>> +                        return r;
>> +                    }
>>                   }
>>               } else {
>>                   r = 
>> adev->ip_blocks[i].version->funcs->hw_init(&adev->ip_blocks[i]);
>> @@ -3683,10 +3687,12 @@ static int 
>> amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
>>                   block->status.hw)
>>                   continue;
>>   -            if (block->version->type == AMD_IP_BLOCK_TYPE_SMC)
>> -                r = block->version->funcs->resume(&adev->ip_blocks[i]);
>> -            else
>> +            if (block->version->type == AMD_IP_BLOCK_TYPE_SMC) {
>> +                if (adev->ip_blocks[i].version->funcs->resume)
>> +                    r = 
>> block->version->funcs->resume(&adev->ip_blocks[i]);
>> +            } else {
>>                   r = 
>> block->version->funcs->hw_init(&adev->ip_blocks[i]);
>> +            }
>>                 DRM_INFO("RE-INIT-late: %s %s\n", 
>> block->version->funcs->name, r?"failed":"succeeded");
>>               if (r)
>> @@ -3721,12 +3727,13 @@ static int 
>> amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
>>               adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_GMC ||
>>               adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_IH ||
>>               (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_PSP && amdgpu_sriov_vf(adev))) {
>> -
>> -            r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -            if (r) {
>> -                DRM_ERROR("resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -                return r;
>> +            if (adev->ip_blocks[i].version->funcs->resume) {
>> +                r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> +                if (r) {
>> +                    DRM_ERROR("resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                    return r;
>> +                }
>>               }
>>               adev->ip_blocks[i].status.hw = true;
>>           }
>> @@ -3760,11 +3767,13 @@ static int 
>> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>>               adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_IH ||
>>               adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
>>               continue;
>> -        r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -        if (r) {
>> -            DRM_ERROR("resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->resume) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                DRM_ERROR("resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>           adev->ip_blocks[i].status.hw = true;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c 
>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> index 10dece12509f..082a69babe62 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>> @@ -176,12 +176,14 @@ static int 
>> sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>>         for (i = 0; i < adev->num_ip_blocks; i++) {
>>           if (adev->ip_blocks[i].version->type == 
>> AMD_IP_BLOCK_TYPE_IH) {
>> -            r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -            if (r) {
>> -                dev_err(adev->dev,
>> -                    "resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -                return r;
>> +            if (adev->ip_blocks[i].version->funcs->resume) {
>> +                r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> +                if (r) {
>> +                    dev_err(adev->dev,
>> +                        "resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                    return r;
>> +                }
>>               }
>>                 adev->ip_blocks[i].status.hw = true;
>> @@ -194,12 +196,14 @@ static int 
>> sienna_cichlid_mode2_restore_ip(struct amdgpu_device *adev)
>>                 adev->ip_blocks[i].version->type ==
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>> -        r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->resume) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = true;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c 
>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> index ab049f0b4d39..2e041424ef9f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>> @@ -187,12 +187,14 @@ static int smu_v13_0_10_mode2_restore_ip(struct 
>> amdgpu_device *adev)
>>                 adev->ip_blocks[i].version->type ==
>>                     AMD_IP_BLOCK_TYPE_SDMA))
>>               continue;
>> -        r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> -        if (r) {
>> -            dev_err(adev->dev,
>> -                "resume of IP block <%s> failed %d\n",
>> - adev->ip_blocks[i].version->funcs->name, r);
>> -            return r;
>> +        if (adev->ip_blocks[i].version->funcs->resume) {
>> +            r = 
>> adev->ip_blocks[i].version->funcs->resume(&adev->ip_blocks[i]);
>> +            if (r) {
>> +                dev_err(adev->dev,
>> +                    "resume of IP block <%s> failed %d\n",
>> + adev->ip_blocks[i].version->funcs->name, r);
>> +                return r;
>> +            }
>>           }
>>             adev->ip_blocks[i].status.hw = true;
>
