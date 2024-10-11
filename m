Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C7D0D79F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 14:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD35F10EAF9;
	Fri, 11 Oct 2024 14:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AvSCvjQ3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BFAD10EAF9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 14:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNKJVgPoh/FJ40oqKnsyLVabV+JOTPDV+2y50hnskPQFleN+fU0D/MOJoQBcDH+76ob94CcWLpmQ3CQujpCHVnw3crJmlTF7MGLQBELxbHbxzx5CYZm6N2qCwZyhd6RpYZMDiCYoh88JZEmTnFFopLY0+tYpeDjE7VPkgA8Eo4d5+cQEJVg8K5+cGsK/zhJqX4qYhaMRGqJXmWXBA9kt3q1m2JfrevrWywfhR3s17Z4xQk6JLhBaU4Ju90hNDPGoNyNZC+El0khcdoFTIoq9v8l213q6GTOmgFU+VSmMZf4EU1IKEhH324+KgAuZO0fmreSZvpAs1uZtNDwdIglgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlrzau2JgzLndVGsSDI1NLRItrk17YLoVfvlCv0AlaQ=;
 b=x1IVZqluySMfrzfXxHfgt9Z1ZDLi7AaUsxDtPSfhwcvEzlKMkRH3QZxZj15QnUTgqH10G5xJsmBV0oPGstHmU/qs5U5EvB1UFs1+d8DqrIWSQpDqq+opQLJRJ0sk+vJcF3xY47Sq3ygIMWpxUAb3zsBeO0O2cD/ZTit4CaTHJps91QGiQ3T20FM9WrOGN7n072TTkae5Li4VXrG3EU/r4Y1gnMMtUpaWQiVGMgBZ0gUWCTLv4DejEhwaW00HjKY6FC1I2iQv+6UXKX819y16VEpFleEqaKJDMGN573rgfTzqFPjjHJNdrWctoixmEGKTJlO1Yw+5bcrqo2dK/wQrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlrzau2JgzLndVGsSDI1NLRItrk17YLoVfvlCv0AlaQ=;
 b=AvSCvjQ3/WOn9PI5Bozo/qzxOevTCzQWgU7XnsN3EcL6hvnWh7shqlxvbByXqOHoXeAZfxrz86fbpBwrXpYxqlDijVo+0I1hm4ctuzUubRjw4rGHJtXCdeGrCptNWq9UZvC7KZCrbgDZj4DWQ2fQJjZoz2FRXCrXOuPeS2qiVCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 14:42:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 14:42:18 +0000
Message-ID: <e0f652ce-80d9-4420-8e49-6a029567140f@amd.com>
Date: Fri, 11 Oct 2024 10:42:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Accounting pdd vram_usage for svm
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20241004202808.30740-1-Philip.Yang@amd.com>
 <d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com>
 <5f6f5e6f-3c1b-30ff-cab8-231544a63976@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <5f6f5e6f-3c1b-30ff-cab8-231544a63976@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 942eb779-274d-44a2-1398-08dcea02e7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFZEbU1CZ3dCMS9IQmdsNk92REluSkpBYThnM2FUcEdWQ09LQzNRY2JpYzA4?=
 =?utf-8?B?b0greGtuYVRiTy8rUXovSUt2Nlh3eWVWTjFqM2huUnN6Wlk3OGg1ZWZnT1Rh?=
 =?utf-8?B?NHpWZFRvQ2orUjdMWi9jaDhTOGNUTU9seEZFbU1nMTRVdUxKa1Q2RnFYcHFL?=
 =?utf-8?B?WmdqU0NtanpKdUJ2c0pwMFc2eE1JVk1jaXF1MGRQcW5UVktrNFdkOHI2amcz?=
 =?utf-8?B?ZkpXNWFWS3JtczRNR0FCTUl1RS9kR2pvaTNtTmpMbVlKcGtVVTl2dzVxdVB2?=
 =?utf-8?B?Qms4YkZXbkV0cTYyRjdNTVNnOUZNd0RrS0NhaFJneG9udEFUNkJ6SWV3b0RP?=
 =?utf-8?B?U0ozY0N0MGl2ZXltTGhGMVJzVGlFSElDWHRCQVdwNDlEbDdEV084U1JFTCtn?=
 =?utf-8?B?SnhwcDZRWWRvTXJ2VHY5NUhRRGJROWxBVFpHbmozS2RYS1dBVWJZbEJNZHBI?=
 =?utf-8?B?NFhpNkRHQXp2Wm5pYUEwdEZRQWoyd2lUd1NieTBYVGt4M2VEYnpPTHAwRllB?=
 =?utf-8?B?empZTXZTYkNiVVY3SllkZExDZ2JiRHYrOUVDTEd5ZzgrbGZpdmFocGJNN3FP?=
 =?utf-8?B?K1M2VFlEdlI5cUdIbEMyQURMOE0vUE9FLys0WUphWGtTMTRHMUs4U3ZPVXh0?=
 =?utf-8?B?T0doVTlCREVuS2Q5U3ErY04zZnJTWGwremhZcEhLc0dyVHNvM0s0MmVHY25V?=
 =?utf-8?B?VWo0MFh4c09EVXpzaWMwUVI2NUwwdUR0THNrbEFEL1NTdlpaRGhxdkE5eVJq?=
 =?utf-8?B?WGVJSTYxZG9wL1NSYWREOGJKWW5TZ1BKbnBNTHZsU3htMHZyUEhzc1BoTDRS?=
 =?utf-8?B?b0IzNnhMU0E2aFRnazE2enU4VkhvYWlzaUI1STJ5N0c2dXlhTzVEUWllc2I5?=
 =?utf-8?B?dHJQVWlwRkhRTlpMdS9zc0d5eG1jdDBmVXpxVHF5RWNOSC9XeHNGbXovNnJW?=
 =?utf-8?B?WkdFZEFWTFl1TDBBUm5JOFFzeUt0TEFYTVdPL2phcSswS283cFR2Nmk3a2hO?=
 =?utf-8?B?ME56VWVHZkVkazl4RlBTVENDNitsdmpnTnBJWHZYR3JhbU1rNUlqQk9FeGVr?=
 =?utf-8?B?OHBEeFcyK1Jma0FTdmVvOFVkNFBmYTRIcGNCY3p3bGJMM1pBRzVwS0RzVTFE?=
 =?utf-8?B?V1c3aHF0YnNFRzJBOFlmRjM3MEZkQnBXMlBKeW5NVkVMeWE0cndQMzZ6UXQ3?=
 =?utf-8?B?T3p6U0ZWbWpHRG9jWUppWjF5MG5mVjlNRUNhdUI1V1pyNXRpcjkrS0lDaG95?=
 =?utf-8?B?ZFNSWTBBODYycU4xOU9ScTQvemNBbHVrOHdhT085dzNHcXErMnB5RGIrcHpy?=
 =?utf-8?B?azFGMDhkaFgvc0U1L1JDbjZBQVRRREtiSWtDNGpCbmJtaDZGUEQyQzVKQ0N3?=
 =?utf-8?B?dys3OTlsRFFYakNSaWI3b1BQcHpVQmVGWlQ5UmFMa3JSWXhzVC9Lb2JxbHBm?=
 =?utf-8?B?TVZVamZuSXl5MUZ4T2w4RFUvSkVodkw1WFNoNVhZOGhCV2FXOVhvSXZ0eUw3?=
 =?utf-8?B?SmdXVmJhSVdwLzRSMXdYN2ZmcDBlSjQ2WVBLY1MrWCtvUXlrZlBLZjl0Yzlj?=
 =?utf-8?B?WXlRSlEwWWd3MDZwTjlQY2lKMGJNME1XdHpSR2phbUtxcytSMlZoYzB5QlFy?=
 =?utf-8?B?WUhxQXY2T2R2SzgrbE9DNVpQdWpMTnNrQnlaemp5L1hFTENkMG11ZlNHTkJy?=
 =?utf-8?B?RWluMWtQNGZXSk5WSytINEpPa0pKcHFUcGZ5bGtDR2hJVG9ZTm5KUWxRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDFJWlc2RlVlLzVxaXJqaDFoYXU4U0d1anJsbFpjMUt1Qk12MlVoSGFPbThW?=
 =?utf-8?B?YVhGS0lIdWVPbTlPTjhiT0VRSkVpcWZFME5hcFozS0dyTlJEU3BVUWcwTmxu?=
 =?utf-8?B?UDMwY3pYcTZsRUlvd0NzNGg5eFlhalNDL3Rmd1pDYTByL25IQTFHRG5VMGk0?=
 =?utf-8?B?ejYvZHZ2YzlvRGg3bFZ5cC9hSDZpR2hLcHRmc25ZRHM0a1RMTGVCOTlmTUpX?=
 =?utf-8?B?elFKbnliOTUwTEVTY2xaczR2Z0dCY3RYb1lvS0RiWnMwc3NBVDd3RnA1ZGpB?=
 =?utf-8?B?SDdTOUVNRC9CdzFGSVhMeDFXaDN4K1ZxaTFCL0QvOE9GUDRSQXFLQ21wSUNJ?=
 =?utf-8?B?QU9kaEdjWS9mVmo3aUtoS3kvL2xpWnd6dTNLUUNNM1orc0hFdkdmUHNsOHB0?=
 =?utf-8?B?Q1pWUFdZTXp3cm9za2tBTGlGUnNUM3ZwQkhPenhZd3laTmgrYmhMcmlKVGFq?=
 =?utf-8?B?cGtkdDNqKzVtRU1NYUpWVXp6UzVIckdidmpMQmk1LzNsTFhiQ2h3bnpLMnZz?=
 =?utf-8?B?Y0ltaHNZeWdRTWs3ajBDd1JlVlg3dGt2a3dMUk53R3dVOUFNNXdESW5zTHlw?=
 =?utf-8?B?SlM1YTFMT1BQdDNwQ0JGU1lVR3J6V1lUWmhKdW9FMk85WDdlMm92M2JLVExw?=
 =?utf-8?B?bHJBM2ZDYnNsTTdHbHZjUk1QQUZWc1BwR2tWeTZranFybE9WZ0ZKTXdwVkJK?=
 =?utf-8?B?ZUlIRkhJbEF0NkxJVjd1azkrZXBTMW1jWXlENjc5UVlBU2E3OUhYcXcrZEZm?=
 =?utf-8?B?K3gyOXh0NmpMU2RCcFNEckxDSWdQcGorTXo0OVJpdUJqUWgzTWdvR1F4cGZu?=
 =?utf-8?B?VWFCRFlyV2djc1YzWlp5RW9NRVpoRi9keEE0L0llTm5tUHFqbDlWdVZNMzBV?=
 =?utf-8?B?eUllSlhTYzhpODdxMzVsSzlBRHpGRjJrYlA4Y3l0WWg5SEYvbEdmK25mVDQw?=
 =?utf-8?B?V1FNaWxLVHN3Z25kdU5sZk5mUFZmK3VTcFVLVXlBS2ZqM1JOMXphQ0x6VkIw?=
 =?utf-8?B?amFMUm82ZWdMVXk4RE9BVWp0azRCQUFvelU3a1VNaFppQmo3RVVYTVdjZnhD?=
 =?utf-8?B?NSt0ZkFRekNPRDZFZ1YreHlOWHhDS1JhRXFhN1RIM2NsdzQ2TGo4Z2tTeHhn?=
 =?utf-8?B?OCtuR0hGN3BiaEJCZHl3MHlMU2NMMzlmc0dUYklrZTJjMEJOZnhVRWYrVmQ0?=
 =?utf-8?B?d080N3gyRTdESGk5d2lZY3lBY1o0ZFVtTDNkcUFyb29nUUU4RXZVRTRYNU9o?=
 =?utf-8?B?TjdLZXlDdVkzNjJnUm1RZmJxSHU0MzUwU0hXclJvdG05VGFNNUF1dHRrdW8z?=
 =?utf-8?B?dDJHci9QbmQ2c1B0dXh6dnZpbzlIZE12YUsvZjJjcXcybFFQTkRGVUZMbE91?=
 =?utf-8?B?Y2F4REpnQ004dHZmZEQ2RGFoKzM4NlN0VGkrTzhiZFRlRit3cVh2NlBieVZ4?=
 =?utf-8?B?Y1lOazQ3Y1hyKzdkU1laNXhnS292SzhHZ0JlSS9Ka2UxRDdmd3owWXU2ZjRa?=
 =?utf-8?B?Wmd1SjF3bzRnUi9xdVAwK0dzTDdDYW1NdkVtemdpaS85Rmk2cmg4bTFxMUxG?=
 =?utf-8?B?a04rak9DblJaRGk5azBWK1B4ZjNaMHhSaUszMkZnUTIzMU94NHNtQXNXV21M?=
 =?utf-8?B?cXFkTGdFbVd5TVY5aWY5b2QvVjdOZFp6ZHR0eHRHSk1ZcHEzSTlBSmZ5YVVM?=
 =?utf-8?B?OE1Qd053M0pBSWRka29qOFJmRkRYWmFBZ0w0MkoxS0RQUCtXM280SjQ4aW9r?=
 =?utf-8?B?UVQ1aWY3WDM3azQ4aUpJYTVFRkdGTU1vcUlWMWs3TklUSXhCOWx2d1ExUXR3?=
 =?utf-8?B?K21BNFFPRzVHMUYvTkZWdVhXaDE1dnZrTi92YkNVVmhpRTZXYnFGUzM2bGRq?=
 =?utf-8?B?VjFDdVVXcUdrTjZ1TUlPZG1LekZ2R0dKaFk0ZDI0UFhKak5pMzI4ajkrRVg4?=
 =?utf-8?B?bVlaRjltUENxYzNjaTQwNkFvdFlDL1E4dmhQWWdIY1dhWTZvZWhhTjE3b2ta?=
 =?utf-8?B?NE80STR2bkJYWnpxTlArVHlmcEsxYS9lYTNNZzR1ektXemZ6MW9qZ3YrN0Iz?=
 =?utf-8?B?ZHFJSm4xNjh4ajhuS2RPVDVqdG53ZDVzNVA5Zjc3OElFTnRoU0RVbSt0WWli?=
 =?utf-8?Q?fZ/CVkgf4qYR7qwEcx3M6HxzG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942eb779-274d-44a2-1398-08dcea02e7e1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 14:42:18.2007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6pRL+Z4/8XVbPVh8hhlYZFq2mWzLkwEo6FNZpeLGyGs5/8w/tumIANSSGsfZ9XGxtB0H/fEiPv+enYpGZKGXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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



On 2024-10-11 9:23, Philip Yang wrote:
> 
> On 2024-10-09 17:20, Felix Kuehling wrote:
>>
>> On 2024-10-04 16:28, Philip Yang wrote:
>>> Per process device data pdd->vram_usage is used by rocm-smi to report
>>> VRAM usage, this is currently missing the svm_bo usage accounting, so
>>> "rocm-smi --showpids" per process report is incorrect.
>>>
>>> Add pdd->vram_usage accounting for svm_bo and change type to atomic64_t
>>> because it is updated outside process mutex now.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  4 ++--
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ++++++++++++++++++++++
>>>   4 files changed, 28 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index a1f191a5984b..065d87841459 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -1148,7 +1148,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>>>             if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>>>               size >>= 1;
>>> -        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
>>> +        atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
>>>       }
>>>         mutex_unlock(&p->mutex);
>>> @@ -1219,7 +1219,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>>           kfd_process_device_remove_obj_handle(
>>>               pdd, GET_IDR_HANDLE(args->handle));
>>>   -    WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
>>> +    atomic64_sub(size, &pdd->vram_usage);
>>>     err_unlock:
>>>   err_pdd:
>>> @@ -2347,7 +2347,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
>>>       } else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>>>           bo_bucket->restored_offset = offset;
>>>           /* Update the VRAM usage count */
>>> -        WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
>>> +        atomic64_add(bo_bucket->size, &pdd->vram_usage);
>>>       }
>>>       return 0;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 6a5bf88cc232..9e5ca0b93b2a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -775,7 +775,7 @@ struct kfd_process_device {
>>>       enum kfd_pdd_bound bound;
>>>         /* VRAM usage */
>>> -    uint64_t vram_usage;
>>> +    atomic64_t vram_usage;
>>>       struct attribute attr_vram;
>>>       char vram_filename[MAX_SYSFS_FILENAME_LEN];
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 7909dfd158be..4810521736a9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -332,7 +332,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>>>       } else if (strncmp(attr->name, "vram_", 5) == 0) {
>>>           struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>>>                                     attr_vram);
>>> -        return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
>>> +        return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
>>>       } else if (strncmp(attr->name, "sdma_", 5) == 0) {
>>>           struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>>>                                     attr_sdma);
>>> @@ -1625,7 +1625,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>>>       pdd->bound = PDD_UNBOUND;
>>>       pdd->already_dequeued = false;
>>>       pdd->runtime_inuse = false;
>>> -    pdd->vram_usage = 0;
>>> +    atomic64_set(&pdd->vram_usage, 0);
>>>       pdd->sdma_past_activity_counter = 0;
>>>       pdd->user_gpu_id = dev->id;
>>>       atomic64_set(&pdd->evict_duration_counter, 0);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 857ec6f23bba..61891ea6b1ac 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -379,6 +379,7 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
>>>   static void svm_range_bo_release(struct kref *kref)
>>>   {
>>>       struct svm_range_bo *svm_bo;
>>> +    struct mm_struct *mm = NULL;
>>>         svm_bo = container_of(kref, struct svm_range_bo, kref);
>>>       pr_debug("svm_bo 0x%p\n", svm_bo);
>>> @@ -405,6 +406,22 @@ static void svm_range_bo_release(struct kref *kref)
>>>           spin_lock(&svm_bo->list_lock);
>>>       }
>>>       spin_unlock(&svm_bo->list_lock);
>>> +
>>> +    if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
>>> +        struct kfd_process_device *pdd;
>>> +        struct kfd_process *p;
>>
>> Move struct mm_struct *mm here as well. It's only needed in this block and should not be used outside.
> yes, mm is only used here. If changing svm_bo->node to svm_bo->pdd, the entire block will be dropped. 
>>
>>
>>> +
>>> +        mm = svm_bo->eviction_fence->mm;
>>> +        p = kfd_lookup_process_by_mm(mm);
>>> +        if (p) {
>>> +            pdd = kfd_get_process_device_data(svm_bo->node, p);
>>> +            if (pdd)
>>> +                atomic64_sub(amdgpu_bo_size(svm_bo->bo), &pdd->vram_usage);
>>> +            kfd_unref_process(p);
>>> +        }
>>> +        mmput(mm);
>>> +    }
>>> +
>>>       if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
>>>           /* We're not in the eviction worker. Signal the fence. */
>>>           dma_fence_signal(&svm_bo->eviction_fence->base);
>>> @@ -532,6 +549,7 @@ int
>>>   svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>>>               bool clear)
>>>   {
>>> +    struct kfd_process_device *pdd;
>>>       struct amdgpu_bo_param bp;
>>>       struct svm_range_bo *svm_bo;
>>>       struct amdgpu_bo_user *ubo;
>>> @@ -623,6 +641,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>>>       list_add(&prange->svm_bo_list, &svm_bo->range_list);
>>>       spin_unlock(&svm_bo->list_lock);
>>>   +    pdd = svm_range_get_pdd_by_node(prange, node);
>>> +    if (pdd)
>>> +        atomic64_add(amdgpu_bo_size(bo), &pdd->vram_usage);
>>> +
>>
>> Would it make sense to save the pdd pointer in the svm_bo struct? The effort to look up the mm, process and pdd in svm_range_bo_release seems quite high.
> Thanks for the good idea.
>>
>> You could replace svm_bo->node with svm_bo->pdd. Then you can still get the node with svm_bo->pdd->dev without growing the size of the structure. This assumes that the svm_bo cannot outlive the pdd.
> 
> yes, svm_range_list_fini is called before calling kfd_process_destroy_pdds after process exit, so svm_bo->pdd will always be valid. I will send new patch series.

I think that's OK. kfd_process_destroy_pdds happens in the cleanup worker that runs after the mm_struct is gone. So all the page references should be gone.

But there could be issues if a page was shared with another process that holds on to page reference that still point to pdds of processes that don't exist any more.

Regards,
  Felix

> 
> Regards,
> 
> Philip
> 
>>
>> Regards,
>>   Felix
>>
>>
>>>       return 0;
>>>     reserve_bo_failed:
