Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B7ED65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11EE10E0BB;
	Wed, 17 Dec 2025 14:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhEwF5wB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012068.outbound.protection.outlook.com
 [40.107.200.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 421F910ECE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuPYG07kdwhatLQn3IMIz11DcXxbIh1a7GyYgnzXlyjF8zkPbjh+6obyKDgfizCIBBA/rt+zRuwPKoPIwED4mCnYmYhtoFiPEWydZldWVjTZb/aiQ/0sK4ppXilsoguPCeWui9404KKxUZRWjBl+l0XcKExfTUS0U8dapdVZsvFlc9JRBYfM6yHGPw/9uitEXUkK+zJZAt+B6vqIfATAOohcr4Pk6a85UG9/a8OvrvvXg02c2j2npTCJcek7Ontdcn35iTLOJC2VdXVofXm6Eq6HLWZTMJBIhIuY5k7a5d9fLe3opY5npCkusBUzoj6reo7c4LxsVAAXsu1nMmUP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+9Jt3FWqfLZi/+TAZiKRSvw59K05vkFQnHYpna+yGY=;
 b=wJoIKJDSu5fxy1Va2doEvCbcgHJXJ9wLJhfpghQ4+67F285v1ts2tTHdZWaiixpfaUvRVk11yJpzpcoUFTPtrJrNHvVm2ZeaixCOOHb+OZvRdycAY1qTZGvK2YpcKuHb1x4+aJFPHDrtGr9drBNKU/AJgwr4jAm6PlpiJMJGc0+drKRXSsrlWXd/8dP4XgbXnv0Iy86LUX24eSws7nVnDHlr2WPw2KGYurQpHjBDC4nG9tkoRrLIuambVT19ajtBnWRUssx63gayeq267poV3os5QTBCXevkjDJwv6LBLDQmeq72pachmzaSKh00w5uqiN+rF6w3rpo8rid8mGD07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+9Jt3FWqfLZi/+TAZiKRSvw59K05vkFQnHYpna+yGY=;
 b=mhEwF5wBJcq16TVB+gAQ4IfVxsrUrFk0ijB66/qpfbBiFh9DiiHEGLurNVR+iCMUf/CeyxKdjeEnenRobbyiCgj8NjSYQONCtKCNNoVv3XxNd4u09cDd44zqPjEGgV8vEJgHO3sNiJ54xNF5M/evTgmJXAxmdq4h8a+EMaLhl30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:19:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:19:38 +0000
Message-ID: <e0ef1d04-240e-4e07-b5be-7a4cc1d037d9@amd.com>
Date: Wed, 17 Dec 2025 19:49:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: Remove __counted_by from
 ClockInfoArray.clockInfo[]
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251217140151.1984057-1-alexander.deucher@amd.com>
 <18588297-a934-4e51-87b3-b2aa453f7672@amd.com>
Content-Language: en-US
In-Reply-To: <18588297-a934-4e51-87b3-b2aa453f7672@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: b451d696-da21-43d3-9c5d-08de3d774fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MndoWVA0VGkrelR3KzNUVU1zV3BGdmRvTzRaVDhvdXdDWTl4UVlUaHdiWmxW?=
 =?utf-8?B?ZjRBdTFtMXlCRHk4a3d2UERsclBjVHhFNzBxYVZWamg3eVM5MHQzTWI0Qkwv?=
 =?utf-8?B?V3NzenpTYjFzVUt6OGphTEtXZy9nNXNaZWIvTWh6ZVMxMDNza1JQRTk5RjdL?=
 =?utf-8?B?VXJSdStvQkRIZWt0cXVCcDJReWpaSTRkcWs4bnY5OVpsQ3B0SnlCQk5iU2c5?=
 =?utf-8?B?T1RraW5hSkd5ZXhyV2hlTjJ6eDJZOE9rMDBrc29LZENzWThibGkvZnJ5ZGg2?=
 =?utf-8?B?VVBTQXNlRmZPOVZ1c0g1KzE0Mm0yWFBIWXpuSVFVcVB2YmQ4RDVLL1dBeXlN?=
 =?utf-8?B?U09IRHJzdHZ0RHN5U1ZIdS9lNllZdHlleDlwcXNqWGp5eUcvSVpiODBNVVpr?=
 =?utf-8?B?Vk5lUmZPT0dNUjJnSDVYYzdreFFGODQrcCswZ281VFBBVTdqL1c1a2RndmFl?=
 =?utf-8?B?OTZ3cERnSy9BRk9yWEFrNG9Cd2thVGhaUloxQ3JqeGFPcE9nZ0NFVHpydFdr?=
 =?utf-8?B?M05xMHh6RnRRUnhpR0tRb3lpaXlHSUtDdlRqeGNzS3JsTzNYN3d5M0RqU3Q1?=
 =?utf-8?B?ZWVJMmZ5NkJQMVUyb2I1T1BrQ1BEdlloL3U3M0RqQU4xVXhWOEZZMldVUGtY?=
 =?utf-8?B?THNFbTRTYUlpdjdaZEVNeEI3VnBsZmRZZTJtVjFLWVhXK05DbkptR00yc2xo?=
 =?utf-8?B?THVuQjc1ZURaNmp1ZXAyeFF5UGMwNVBka1ZzQXc5b3hJblZXY09UL3dTczl3?=
 =?utf-8?B?a0pTWElVVnd4YlFHbDBkMDFoeEtKaEhCNGV4dG5HeHJVaVJ1ZkQ5Z3NSQ214?=
 =?utf-8?B?Z2tFc1ZsUlVvVWRibjh5NlJJNGZMRk40WmVYamR0dFdWMVN6anZySTh6dkJF?=
 =?utf-8?B?aEppc2pSNlFvWXQ2WS9HSFN3alZiUzVUVTlhL1cvbkRJOC9pd2RDUFFSSk5X?=
 =?utf-8?B?aFpLbU9QR2YxMEV5a3J2NjBESUgrZDFmM1Q4KzRESjc1TzJKQlhiOFRnM3F1?=
 =?utf-8?B?MmlYOUo1STBIZWYvTjZrVGJLNjdHNEh5N1pMcGE2d2pEZHBHc1BJalp0bmxs?=
 =?utf-8?B?SHZDZmJMOEYvV01RczRoVlBxUVFKRHd0bk8yVG1DbGRsRStKc05xdFkxamJQ?=
 =?utf-8?B?MU8zeWNuYmhJZG9aRllQY2hKYzdDNWJkSHh0Z1VJQm9xeTdUVWZIS3lGZUZ0?=
 =?utf-8?B?alFWeWttb0grcUxTcjl4VWhSTE05NXNmME91SkZSM1RBcFd4VmpLM1JwcDk2?=
 =?utf-8?B?R3NFVjRiMWpyZm40OXdMVDdCb24zNGdJUXA1a1RPdFV2Zi9MVDJLYWFibkJx?=
 =?utf-8?B?WFpVYTVhWVFXN1N1cVNhREFqeGFpRjRteUY3eDB0VjBicVdiQTJzS29SaUJm?=
 =?utf-8?B?V3p6cGZIS3hsaERRejRsdFdPSExKTWlWSEFZUDBYRnZqNDVIUU81VTdqbDYr?=
 =?utf-8?B?ZXJuMTZjMVNjNWlNNFcxWDBSWmdaMFNiWGZuRnpwNDgrL202OWFiVTJ0OXAz?=
 =?utf-8?B?Uy9BQVpGSG90cDZLZXhBL25pSGNucng3czhtQ0I5NVU1OHc3U1pQUHlVWXN4?=
 =?utf-8?B?MTNGYXpSaDFiU29jaHNnOTZUODNzY0t3VTlNZWgyVTBIZlF2Mjg5TEI2emM2?=
 =?utf-8?B?cGxQaE9TWGphZy82a2hUUVlxR1U4Y0lBZElEa0I3QnMyUGxvc1VFQTNJVWpU?=
 =?utf-8?B?TjNTZHJ2dXM4alIzYjJmcVFTUkdxYWl0bE52YmkxU0VaN2NSQzBHcFZDOXRw?=
 =?utf-8?B?Qzc2SWkwb0s2ZVNIUktJSzFua0d5VnptaHdIakN6c0h5ci9NL3kvQTlUeWVP?=
 =?utf-8?B?U3hiWGZhMFJGMW5ERHZzekkzSG9oQUdQUVhodDZNaEZBam1YMTI2UWpMRi9o?=
 =?utf-8?B?T1UzNzA2ODZrRXU3OTJBQnlDNkx3QnRlbEpOWnZ5ZnFMblE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M01aMkxBSzVpRk1CVVhvUXJTYnhtd0RmTTBaUmtaUjZLUExpOXZyWVZDNStl?=
 =?utf-8?B?MS94YjJITWNwSkVybXAwQWZUV3VON2ZJUFdoSFhERnFWWkp2ZzVvYjNYWnlJ?=
 =?utf-8?B?T1VFU3JudEgxZzFPOHZvWU93by9tYk5QVWh2ZnhpWWw3cy9LbHdrTU50SkdI?=
 =?utf-8?B?TGxkMDMvWDFoQkFvU0hXMEtpUWZ4ajJEbWRmSitPdFgyOTRCYitFQnlwTEJv?=
 =?utf-8?B?WDVBT3dHOWZCQkFWUnpDdFRza0JZZVVjbnRLUzY4eGo4MDIydDVaUnZyUTd0?=
 =?utf-8?B?NFYrN0NMUzFJalpvQk1aWTVaL1k1bnFRQmpWbDdyVXoza0IzTWJWeUNzc2lh?=
 =?utf-8?B?aTBuMHdYTmF3eGhtbFV3dG5laWNsQzcyRHhTU1pqWkxJOGoyc3JFaTFOVHNt?=
 =?utf-8?B?YXRzcXdFcG1QcVlxdFVLYVRrZ0h2a3JvL1FYaUwwa3ZQMFBNZWl2cW1BV29i?=
 =?utf-8?B?aWlxVUlKL2dTblhGcDlvZFg1TitpeXRWV05Lb2k5VmVscDkyalovcjNSK0RF?=
 =?utf-8?B?Q2M0RjBxUkREaVZpUWgwTzB6NCtqS1BCK3VrSGFRMXBYbEdVaCt6c1Bab3Rw?=
 =?utf-8?B?ZXR0Q3FCeEhvenB5TGtzYkcwZzd6WkNGVzZOUVdPZjJNcUMxaUNxUUVZZmpP?=
 =?utf-8?B?U09GdXBTM3BvWFJvQnNxV01HM0l1d1BENjNtbkhBUDVSaDFzVElURVQ2dXdM?=
 =?utf-8?B?ZTN2cHp4WkpjUGZCWWNicFdEVHVxQUF5TTdNRFFxOFRKdHFDdUlQTTNKNTFL?=
 =?utf-8?B?b1pYNmR1djBSNjhvdjNlOS8vTE5tanJjckcxSk1CYUcxRytWdkIwdWNra0x1?=
 =?utf-8?B?M3IwbjhXQVlIaXJQbndrYmFML0ljM0dZM2JBbm9QemR2YzgzZlZMNHBlTDZy?=
 =?utf-8?B?bC90TG1RSWpsT1BXOW5pL3c5N2ZsTU5KbSs1cWdYMmZkcmE1emxwNEtSdisv?=
 =?utf-8?B?dmcwSTk4MG1pdUgzblBWMEt3Z2N1Q2RWU3JUVHRJdVRuV2htbXovcGluZExE?=
 =?utf-8?B?Q0lqUCtuclFOMDd0N2Z2eXBocS80RkhnQTJPTTBXMHNQOU40eGRwRHBERkd2?=
 =?utf-8?B?Y0NydDNQUmN2VFRaZit2SlFDRDQ3STBqbzZlWU5wSkE2R0h0ZTdYTVFIbmR3?=
 =?utf-8?B?blFGTHRKNnZjRmhyZURQMFZMOGpxeXVJZGlCak5TeVhjK0VYRDMvSVRUM041?=
 =?utf-8?B?WWRzK200c1U1SldRR2UyUCt2cmd1OUN6MWNtMUJDaGlXVlR1Y1Z2S2FHb3RV?=
 =?utf-8?B?bzMrYjBFNFMrM2VXNVJ0eE9WdkpyY3BRWUYrT0NMRmxDVU1xTG9md1Z4d3VY?=
 =?utf-8?B?c1IwK3daOTlkVUovT0hlRGJ6a2FjOWt3aU85dnZ1amgxeFpJOUVqTmYwSVdW?=
 =?utf-8?B?YjVpYjRCZXlwSjArbDJXaXFKTlBNQ2Q4TWdJT1FUK3RqWnljcFRqQldnWFJI?=
 =?utf-8?B?VkJKY2QxUmFwOHhmODZJaEYvWWtFN1hiZklZa045N3pPWjdhai9lTmI1UjNZ?=
 =?utf-8?B?M0lrK0k2c0dPb2pVaVZzZ1YvMlg0b2tyZk1ROU5nd3pqUmlKT1U0MmY4cnha?=
 =?utf-8?B?VWJ2eUh0K2ExK1BkT2s3eW1XTjhKUEVhNEZhVnJmNFhPcWExMmxTU3VnRjZu?=
 =?utf-8?B?V3pidm5QbzhXMzIzZGVQWWV2TXJXWDl0RC9kY1BPVWlTYlpZaDJtNmJzSlcv?=
 =?utf-8?B?OHZ0SEVESllIOUk3VkxFWkh2d1BWbmRJa3ZXV3h1dUJJUXAvQlg5elh3WVFp?=
 =?utf-8?B?dDZMek5UeE5DN0tuM2I2ME5xTEdkcU91T21XME1zOW5BblNHOVc1MEl2MzQr?=
 =?utf-8?B?emMrRmw4a2U5UU04MnlBTFpuMXQ3QVhqUlhubEx3eXRZMCt5UWUyK25MdTh3?=
 =?utf-8?B?QXZiL25RTDhrOGFnODZ4T2N6ZnVjL3NvZ2JkbURmNDJtazBVcVVYQVh2dFkv?=
 =?utf-8?B?Z3Vsa2NZTVJvbFEvaGVid1Q0ZGVzYW8vZVgxck1VVGFMSUM2ZDFKSUJ2VkRz?=
 =?utf-8?B?S3NYcHhyd2ZQUWExOE11MzhhQndMOGh0UEVRQnloT0FnQ2dod2Q0bTAzR1RT?=
 =?utf-8?B?ZWErK2V4SkhpVHl4VFVDajc1c2h4UnpJc1VqV3hwSGVnOGtMeVFaSEVYLzRk?=
 =?utf-8?Q?f3wMrNOfzsCq4AIhimEC/6VQ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b451d696-da21-43d3-9c5d-08de3d774fcc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:19:38.5074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30QcHtnBrptC7gPClV7CNhNiKDN5W2gW88h8EG8wmC5M86vE80aJ+nsR89SKQaKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431
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



On 17-Dec-25 7:47 PM, Lazar, Lijo wrote:
> 
> 
> On 17-Dec-25 7:31 PM, Alex Deucher wrote:
>> clockInfo[] is a generic uchar pointer to variable sized structures
>> which vary from ASIC to ASIC.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4374
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> There is one more -
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/ 
> pptable.h#L463
> 

Please ignore. False alarm, has the right datatype.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> ---
>>   drivers/gpu/drm/radeon/pptable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/ 
>> radeon/pptable.h
>> index 969a8fb0ee9e0..f4e71046dc91c 100644
>> --- a/drivers/gpu/drm/radeon/pptable.h
>> +++ b/drivers/gpu/drm/radeon/pptable.h
>> @@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
>>       //sizeof(ATOM_PPLIB_CLOCK_INFO)
>>       UCHAR ucEntrySize;
>> -    UCHAR clockInfo[] __counted_by(ucNumEntries);
>> +    UCHAR clockInfo[] /*__counted_by(ucNumEntries)*/;
>>   }ClockInfoArray;
>>   typedef struct _NonClockInfoArray{
> 

