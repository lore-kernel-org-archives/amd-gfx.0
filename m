Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A1C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 15:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CE711A54D;
	Thu, 25 Apr 2024 15:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QuwRZc04";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010A511A54D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 15:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg8RccBEIFGIy3rqbo5fVZH1wHQBwlM1f/ma1r4V2+is/bifKmnXHHFS/hhkH1p4/ikqd/7crXbA2mXVKDoNU47TcSs+D9XSIYdLa3vtCPaVu7aJ0WNlxAq0u4uOKkn6ho4pK7HZfXVC93LsfO0IeDi4Hw69Yq8rKXNnCXQMNzv3zi4fz6zLsEoGrOVj7fiTDUvY5Z6pNCuWszOBfrRIaxZJaDhmN8GoHk0vHaWo6OB7s+9x4rNZF+asBHxYJrKyfgPXqn3uYvzpZcXM6mNHN0jIREk6rL9hBpY8tQy9mjFS6TEkNrKdi0ZExhNWOyxTb/lUOe5x6CQal56Uf/iFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JoFR75FMTTuIKkI5VQchNLEY6oypFtrCbXQdP46NI0=;
 b=c5CC1PWgo3p0j4o8oj5xrIvC56Tu6OqIzSZD6nAkZbO+vp3StbZUCxK2DksZKh9O+tlCs+YChodJnO+yYfQk7o67M4BKGtYVTfDOpAacMs3cLMqKsALhAsEmMD/8vtG37/WvTv2mlTrsC6LHyOit4YY//MW3GY2nkWiTJH+EPgfEKFLOe8YuqsB5w/dVXHOHFyhXzAd6jMx+jcBfv+8uLhk6YHRDpDtoDpqq2GNf5Mv2LFl+Yv12i1QAVVqCVBh3GCOTcrZOF5mDgFalAxZt59Ef1EiJDUEJ3bm47prr2b3tzzQTZOGsgjIKkQEZ0AReV/Uy1G2Qos46VG76OSNZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JoFR75FMTTuIKkI5VQchNLEY6oypFtrCbXQdP46NI0=;
 b=QuwRZc04IvMnhyvpDnp/QF9XovRjAPC5gm6Ye00vzRpBSdAPfu0Q+vMANrDZA8izeMgMI8Lx++/GCJ3o/STbdDvQax722qCY2kJlPDdVm1tjXq41Qw+UEJvpYwAmsAlVBKGWW9TU2uFXOZNbntyGvcubj199P9ErEufjBd3YYJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 15:22:21 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 15:22:21 +0000
Content-Type: multipart/alternative;
 boundary="------------f3PavfSEfE0CAjnWRaVIPqmZ"
Message-ID: <90e125c4-b568-4756-b916-056f900b46fb@amd.com>
Date: Thu, 25 Apr 2024 20:52:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip ip dump if devcoredump flag is set
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ahmad Rehman <Ahmad.Rehman@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240425102318.14883-1-sunil.khatri@amd.com>
 <6a0f8917-3a86-4f18-8a76-1e4062e44865@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <6a0f8917-3a86-4f18-8a76-1e4062e44865@amd.com>
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4cf7aa-d171-427c-dd62-08dc653b803c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eURHTGo2MEdyaVNEK0h0dWU1S1RjOVRETk9GNisrR2Z4a3J0UXlZR1BXTzhV?=
 =?utf-8?B?MThDTWNGbkpLWnpvZnV4WTRxOFhPb21oYnNvc0c0R0tIM3NLck91eHdaS2NP?=
 =?utf-8?B?YURndW9EOFBINFhTNjcvb3RsK0l0UDhuekZhcFdDVWRReWNOZDZjNXJMTXUz?=
 =?utf-8?B?U05lSGswcDF2bHhMVUFJaTU4L1hWZ29VVHdidlgvZUROK2hTTXlmVWJkZ1cv?=
 =?utf-8?B?WjNHUTNjYXl2alJHRS9ObHFUNXlkNDJ0ZFJBWEdyVnVqVlhNejQxYlVoUEY0?=
 =?utf-8?B?V0hEbWpPVUFFNFJHeGJuWXdwcHdVSUN1SFpuSzM5MmNlTGVsek1zWDBEM2ds?=
 =?utf-8?B?VmJlcTB1R25hVHZmdTRYL0hFUXh1OTE4bmVXS2hqSkFBY2JsNDBGZ2twOU9r?=
 =?utf-8?B?TGJiL2NINlcxbmNzd29tU0tWN3MzbzE5akN2Y3BGaWFpTmovc0V5ai9QMHFn?=
 =?utf-8?B?ZUFYTTRMRVdBQjNkckJSblIyV2JRY25uWGlxSndNV1VnbWthWE4ySnFRTUFo?=
 =?utf-8?B?djVld01PT2NEOXYzSVN6RUpzalhkeGFOaW9HMDJvSTRlaEczR3BWYVhFTUxC?=
 =?utf-8?B?NVl3MGMwSVlYenhoNXNYUi9XY3JjK20wdEtpcUdPVStQSkZBV2E2ZVRZbUtE?=
 =?utf-8?B?UGhteHdCY0MrWGsyMlRrZ1U1SDQzaEgzQ0JWckdGcU9ya2FyN0F0TG1BRDNC?=
 =?utf-8?B?VkZRL3hjck41T2NyYVVIaXBxckZmTENxMTRuSy9RZWp4c0VJTUFRclcvN0Jp?=
 =?utf-8?B?aWtYWnVKL3hsVUFlS3hwZGsxanZ5R1N1dVhqZGtlTExVK2JtS3ErOU5QaFQ4?=
 =?utf-8?B?RUp4MUU0dVVyVkpzV3hILzZ2dGRJaGlZRithNlM0QmlFNXZBNmgrTkJsbkc3?=
 =?utf-8?B?VFltdE5nTzhnVXZ5enFZb2x0aVRMeFRYekxpT1JtNjdwMGVqd3RZV3Nobm5B?=
 =?utf-8?B?dVJCMWxCeUxOUnhBb2ZQdHlWMXE1bVRjUG9jdnk2bENQS0NDUVkwZzRFNWR0?=
 =?utf-8?B?R2NIbmw4SmNMZkhidDNjbjMvTVBGbERuRTNSK1FHd1ZGcVBQSmtxaUdJNUlR?=
 =?utf-8?B?Mms4M2YzSEtETmw2S24zem9rajZ2dElaRmdvcjRYMlRwdmg1eFBtNXhZTkNQ?=
 =?utf-8?B?eDh3eXpTRURoZjVKSHQ2UDZTUkQrcVpqYzg1c2tzaFVKZURuUnBkU0Y1Nmwr?=
 =?utf-8?B?WFFOZjFxb3dINlNqK0VmSUdDUjlPMmtXUjVXMTZBRGtBRStpeTJEdGVHMndY?=
 =?utf-8?B?Qm1CUTJneU82Q3JKV3lkczlZSi8rRVBPMDRJWTRZZEJOcFVIUnhlaUtHSTRH?=
 =?utf-8?B?czNWcnA3bGZUcitORkxrUk5PbmlRWWdzWnZGb0d6ZlNPMmNFbkJjVEpxQU1i?=
 =?utf-8?B?eVQ4dFpyK2RVcGF2L0VNTGJRU080eG4rcENvdlpRcVJmZXlIS1o2K2FJams5?=
 =?utf-8?B?SVR1aldHc2NIdVAveEJDUWR5aTk2dXJlcjJaQUJGYUdmaWtIQXZzMXdQTmNW?=
 =?utf-8?B?VlJrSElHWEtGYmJpR25NMm55d3lwZERZRDEwbEFna0lsZ2I1MHcwQ0o2UDM2?=
 =?utf-8?B?V2N2WDhJYnkvbkdaNmFBTjJSWHBDb3RYUzBqT1NveWxOUSsxZm5OZ3RYSTlP?=
 =?utf-8?B?eHp3MlBIZHRzNVBLNzZKV1cxb0txSHUzMlhNTjAzblo1OG1vRCs2UzdMaGEv?=
 =?utf-8?B?KzJXNE90eHlra0M1ZkJRQjduc3h1ODZoWVdqbHBBdGpUdUxGVDU1QytnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRnNTVxb2JsNHJxWTYvTi83RzlVQnF2ME5MU25UMEZJYWpkSzdPT0FCbXQz?=
 =?utf-8?B?NHRuUnczbDNUblJ0TU5jU1lFN2kxQ3lQWWxrMHB3YWxDS1JUS1FXUDV5TDhh?=
 =?utf-8?B?QW9vMEdyQW9KODdnSnZOMnBlQ3YvMVd6MjJKNFlwUjNYSWxINk1UU1dvRHhx?=
 =?utf-8?B?WS9CVDZPOFkwNU5TT3lQUHg3a1Q1KytWTXpRaXlYT09aMlVESUtFdkxRUkd1?=
 =?utf-8?B?aEswVGJDSkdIQVlVWnNkTHhtNGtoTjVJUEdsQWtEWUpCSDhFdm9ybmUzd1JW?=
 =?utf-8?B?WTdsc1R3U1ZjV1lldGNaZTJyK3RMT3FDZUt6dlplVllyZGpTdTFnRXBrZTl1?=
 =?utf-8?B?RFRQRk5FdGtPQ0RETkx4M09YekgzOW5mRmE4NHd0YnhMS1R3OFVvOUJiZnhU?=
 =?utf-8?B?M0ZXTFZITzUyRGJXWXNNRkFCMjBXODJpcEYrVE5rNzBiZnpCUEZhdmFLcmo5?=
 =?utf-8?B?TERHVlNjeDlwY3V5U2FmWjB1RHArblhPQ2lHZlhDZ2pLa1Q0ZE8vSDZpWTlB?=
 =?utf-8?B?d0pyY1pRZmRBOFBrMnVyUkNrNzhZRW5WWGxDQkh5bHY2YUU0UXgwVjc3OE9t?=
 =?utf-8?B?Zks1VTdUYmYvK1ZoclpNWUlGZ3l5QnhUeGRQVFZ3Sk91UDZEeUlkQ2o3MWx6?=
 =?utf-8?B?c0N6OVVkSzA0VGRzaU1RK004QzE1NmJVOVNRcm8wUnJraTIvZTlGK25SbkV6?=
 =?utf-8?B?YmJ4ZTVuMHFWSkM0MVVOVi9QaEJiTjNYUWFjVlF3cGdkQXpLdUVJTlFiNE1y?=
 =?utf-8?B?ajg3Qzl3ald6TEo5NTJuOGMxR2U3aUtpWkc4bDZhalZ5b1pCY1F6ZWxpY2FU?=
 =?utf-8?B?Y0c2RGNsTDNWUG4wSGdKSU9xR095dzRvbVROOTkrVGt6Q29UR1F1QnlDQ0lE?=
 =?utf-8?B?VHluMWRPUWk0NUM0NTRlaWJrNklUcWdjaEFJcUF0alJhQWdIemNmTmhESEVx?=
 =?utf-8?B?OXVKY2tpT3JMR29vVE5zRWdvM1hZQ0tvYVFEcFcyOHYxUUEwb1lRNmx5RUJw?=
 =?utf-8?B?dnF6d2R3MTNIV3hHOENmZitibDZRcTVSQUJOSW5RVERXYitBK3QzVjRZVWR0?=
 =?utf-8?B?UFhSTythWWRPUHdKaG1ENTZnUERPU2cyNEJWV0Vsb3NsZU0zb0VTcWxvczZO?=
 =?utf-8?B?eTdPTDkxS0g1Nk40VlVJOENwL2tNT05zZUR0dzk4L3NxWjlvajQ2dFJWWE9w?=
 =?utf-8?B?aW9xYUViS0lrQ0x1ZTdxb3Jhc3dqNWdhVXBwNnFyYllBZUJoYkNSY09FTFo4?=
 =?utf-8?B?S2x6YUVnUEp5VUVUNXBRcGxzTmhEdThqcmFONnpyNU8waHpmRklHQjI1clhB?=
 =?utf-8?B?QU9NcU4zT1NyMFBzNjFmekt5bVNkUFdHWENTK1I5Z1ltOXp1cHdiVnhoc3l1?=
 =?utf-8?B?V2c0UmZsV0x5NjNIS3dNeU1JNlBZTWxZYjBXRWN2NVBTVHJ2UnBpU1NMMlJI?=
 =?utf-8?B?Q0xhOWtCZkxIVVo1bXhEdWFNS3ZZTzRoekhzdStNcHMydFBvZHlYcFhxZXlv?=
 =?utf-8?B?dks5VnlCZVl3ZEE0MC94R0ozNGo1Yll2elJTajA3YkpYajk2TnRXMExvR1lz?=
 =?utf-8?B?RDN2bmxhZVpmb2tjZElCejAxV09YU2kvTTB5U1g5SDdjSXp3emxDZ1BMRWdK?=
 =?utf-8?B?U1BZOWgybWJhYlh1bFBxRXU1TnNlU3E3N2E1Z2NyK2djNUt3eEIyTGpzb2No?=
 =?utf-8?B?czdiNm9PMVhCaEIvdlpSaEp3RXVPREtFZ1pySk4zUkMrNVROYnFrMTZkTXNE?=
 =?utf-8?B?R29ZcnhzdGt0V1EwNjV4S1doSzBvamlnQVAwR2l0SXU0b2ZFbmVQajBKb0sw?=
 =?utf-8?B?MGQyalRldkdQaVZEOTJoWmxEdzNlVDY0OFArNXQ4bmpiTC8xUVUrYmRTeW5E?=
 =?utf-8?B?T3k3QWxKcEQrQ3RrcEZPc2I4NUpSTTRXcGlLZjkySTFZL2pma1dsajFRclpr?=
 =?utf-8?B?NmNFR0Z6ajIvZ0krWEtmUm9udlliTXJEV1JVbWFrUUQrY2E5Nk9qbXh4RE02?=
 =?utf-8?B?aW1RY21Sbk9HTlNLbnAyYjd5ZHJjNkFIUHByZTd0RVpuWUh1U0xWVjdFcHpi?=
 =?utf-8?B?bWVtVVF6Wklta291b0dpOC9FVnlQbldKM2ZlU1FBT3R2YlAzODRtS1FYSW5C?=
 =?utf-8?Q?oG12E5YHTPE1mMAwkhcX9SN+b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4cf7aa-d171-427c-dd62-08dc653b803c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 15:22:21.2347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ID2M2hYTltOT/45V1vgZ7D4tbCFSTRVRyF7T6OtB6TMd9ACY3zfXSRrzgWo2ytZSmxMSUffcn2qU9GUCcREOkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

--------------f3PavfSEfE0CAjnWRaVIPqmZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/25/2024 7:43 PM, Lazar, Lijo wrote:
>
> On 4/25/2024 3:53 PM, Sunil Khatri wrote:
>> Do not dump the ip registers during driver reload
>> in passthrough environment.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 869256394136..b50758482530 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5372,10 +5372,12 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>   		amdgpu_reset_reg_dumps(tmp_adev);
> Probably not related, can the above step be clubbed with what's being
> done below? Or, can we move all such to start with amdgpu_reset_dump_*?
Sure lizo

I will club both dump_ip_state and amdgpu_reset_reg_dumps under one if 
condition in the patch to push.

Regards Sunil

>>   
>>   	/* Trigger ip dump before we reset the asic */
>> -	for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>> -		if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>> -			tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>> -				(void *)tmp_adev);
>> +	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>> +		for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>> +			if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>> +				tmp_adev->ip_blocks[i].version->funcs
>> +				->dump_ip_state((void *)tmp_adev);
>> +	}
>
> Anyway,
>
> Reviewed-by: Lijo Lazar<lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>>   
>>   	reset_context->reset_device_list = device_list_handle;
>>   	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
--------------f3PavfSEfE0CAjnWRaVIPqmZ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/25/2024 7:43 PM, Lazar, Lijo
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6a0f8917-3a86-4f18-8a76-1e4062e44865@amd.com">
      <pre class="moz-quote-pre" wrap="">

On 4/25/2024 3:53 PM, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Do not dump the ip registers during driver reload
in passthrough environment.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 869256394136..b50758482530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5372,10 +5372,12 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		amdgpu_reset_reg_dumps(tmp_adev);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Probably not related, can the above step be clubbed with what's being
done below? Or, can we move all such to start with amdgpu_reset_dump_*?</pre>
    </blockquote>
    Sure lizo<br>
    <br>
    <p>I will club both dump_ip_state and <span style="white-space: pre-wrap">amdgpu_reset_reg_dumps under one if condition in the patch to push.</span></p>
    <p><span style="white-space: pre-wrap">Regards
Sunil
</span></p>
    <blockquote type="cite" cite="mid:6a0f8917-3a86-4f18-8a76-1e4062e44865@amd.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
 	/* Trigger ip dump before we reset the asic */
-	for (i = 0; i &lt; tmp_adev-&gt;num_ip_blocks; i++)
-		if (tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
-			tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state(
-				(void *)tmp_adev);
+	if (!test_bit(AMDGPU_SKIP_COREDUMP, &amp;reset_context-&gt;flags)) {
+		for (i = 0; i &lt; tmp_adev-&gt;num_ip_blocks; i++)
+			if (tmp_adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;dump_ip_state)
+				tmp_adev-&gt;ip_blocks[i].version-&gt;funcs
+				-&gt;dump_ip_state((void *)tmp_adev);
+	}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

Anyway,

Reviewed-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>

Thanks,
Lijo
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
 	reset_context-&gt;reset_device_list = device_list_handle;
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------f3PavfSEfE0CAjnWRaVIPqmZ--
