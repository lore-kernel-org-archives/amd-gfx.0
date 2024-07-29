Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC6EC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 18:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE91310E46D;
	Mon, 29 Jul 2024 18:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mTB6ji6E";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBBC610E46D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 18:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv4AkXY2XFs/YLvg4wCa4AaGsnJS1ni6lXSre1+bvllCB9V0QUpwa8PK6eEPkI65pOS0VQCHIXWp990GCJ7z48u1GkJHaea7vR1Dc1/fLZiHE6OlejMwG2VxuhYiq7R2frEK/vc4FNj9OgV15CWx3SMT8I6MahaomKWgMsiMOH4IuBZJn4Utp50tZOVSDkBfAaLIRpFtcGdcYfDcHUJlgtsaNmeKmO2iZCzGGXTimQC9KFq3T4IlGlG6mbBHJMmvAVMfe/XbDGi+z8cYMqb9e1B6fAnvzAbOTp5dWsTk+/0fbAldRYwdoBRjApdDgIFCwOPIQf0gltlOMXnZxwRklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7gRAWS8KUd9oWFgpRa/5LYaPmeaJk8pkzVzp8iKCkE=;
 b=ggGcEPrFE8Z8dcHAgFUyUKiA/hVyWda9OHK/PiHClt35hx5IWTCepjn8+L6b1MMxLw0hDWvTGrZOg3WZJAOamf0Ss7D8Z9vPu0ZRMPqzxxp8qn839LB3pObEVRQz19CJm7a28Q3CjSr5eCu1UPr8CxHh4WcW8GYqxyukVRj7mzvnbgfM7RTUYboyZg4Kg5XhyzrF5n9kGCefNwJ8B3TJjwiulK601EY0nmQcSH+nBe9gzseqba4FHS9CoHWu2mIgeS2cs5nvmRtMFHArWzn3QMKNKx12Th0/zuGihkwcpQR7uN2uWY4yIAAdCIsqF6JM087Nv844dA6JOMVMXoUgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7gRAWS8KUd9oWFgpRa/5LYaPmeaJk8pkzVzp8iKCkE=;
 b=mTB6ji6EgV2zMoeSIn4n1xwexC7nH12RgDbaoPgquXvv5EWI0RV0Wi8t2GqQrrDNXpUaqxngEzamr/BatjWYDsef1Q46bYr53v/GIGRw/n0tVfd1YaEUC+HvvGOF3x3PIAo3vtc4CJtqnMyEXxPhr6rqqynjBnv5iVTCUyNyxwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Mon, 29 Jul 2024 18:52:25 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:52:25 +0000
Message-ID: <87f6702b-42ad-4545-8f79-54f5b98e3b6a@amd.com>
Date: Mon, 29 Jul 2024 13:52:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Change kfd/svm page fault drain handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240725181909.8099-1-xiaogang.chen@amd.com>
 <88c71c62-0cdf-4e64-9f83-befda8f19b4f@gmail.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <88c71c62-0cdf-4e64-9f83-befda8f19b4f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0114.namprd12.prod.outlook.com
 (2603:10b6:802:21::49) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e7bf0d-c3ad-4d30-225b-08dcafff9680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjQxSEN6NTFlK3FrRFZ6eGNKRWZUMWR2Tkh3dDZ5dVU4amVSZjd0NlV5L2tl?=
 =?utf-8?B?WTdLNGh1VlIraUtDUDdTYy9xYldNdEs0cjdnZmp0ODJJZFM0a05ITVBsdUtC?=
 =?utf-8?B?NEV2VkxacXNCR3FXNyswNnlNUXREbUpsdHFCbTkzajBrYWpnYjdwNWpHTXo3?=
 =?utf-8?B?Q0tqRTBBYllURGNRSmNoSGpRanl4NnNxSFRObHB4MDY4LzVSalIxZnlqZDRG?=
 =?utf-8?B?WWUxM3l0UGl3Nys2SGt5Ris0czRrQkZtd3VNR2RDZ3hEOFErR3dsS0Vjc1NR?=
 =?utf-8?B?cUY1S2lpa2xWaGFtNTRUUEZxclduemFkYk1Vd2lua1RmSW9nQzNxUHg1bUwz?=
 =?utf-8?B?WXMrU2diUmNQaG5IQVRWL2h4S0J2a3Y5TW5qRk12WGpUZHRJTlBDNjByYWw3?=
 =?utf-8?B?T0NlMHVnQklBRTMwcmNJTGt1dGh0YWhJZjArbjk3ZzVON21aVkRvRlNSS29t?=
 =?utf-8?B?ckoyaXdxdEx4cCtOQ0svTGZjdUdFd1hkZjc4WGFUdFNjK3M4cTVpQTJFdUc3?=
 =?utf-8?B?Wlo5TE1FUFpydXFWSUZDc0xOcWtERGdEcHZ3R2lOSzhTSUJFaEtzaGl1RGxD?=
 =?utf-8?B?aW9zV3dRVGZrdGt5NUVqOW5VVWQ2Zk05V2Z6V0lic2ROV1UzYTNVaW9UR2Rk?=
 =?utf-8?B?WGpFUWExRm9TbWEraDV6dFRWb2M0Z21aSUtXLzVqSFV2REVZbEluak4zSkxZ?=
 =?utf-8?B?dE93VWo2SGJaNkZvRUpaaUdXczNIMThJTndiZ3prYnVPMmhkZ0N6WXpya0Vj?=
 =?utf-8?B?bFI2QlFnMElqdUNWU052N2VsNFlFajJFVFZENHE2SG04Qnk0VFRseHcwSnda?=
 =?utf-8?B?bUMxOVFuazBRUWZEYTRmSzFCamovZy9kbkdiemtDWjRqYUhRbTVaMmdSY3ZL?=
 =?utf-8?B?U3cveXRtTzN1TkJaSi8vSGIyaSszNFJOZHdxbjhscjJvUXlpZVNXWnZKOEwv?=
 =?utf-8?B?ZVFMOEMrNTlLN1UzMDVoQjlWUzZOMHJHUTkrZHNoNmRrRGhMekl2dWd0Nk9G?=
 =?utf-8?B?WVlHUEdieFlwUkp4ZFpRelVtdGIwbFEvUTQzZSt6dkhGaldtbGV4ZFZ6NTRG?=
 =?utf-8?B?V096Wk1vMkpIN2RReVM1Y1V3Yi82WlNSV0NTSURKVVVVOHhJbnpoWUozTmJj?=
 =?utf-8?B?QUdCQ21CUGthT2k4NFJSeVpYUEdZWStIV0tMU1B0aXRFYzlMVzVEQlFOVWI5?=
 =?utf-8?B?RUtyOVM2bzFjREVsNTFlc0xmUGgwN0xLNUxvWkVNRVJ0M2ZPNDVMa2RNS3Nm?=
 =?utf-8?B?a2YwWFVhWWpjS2dYNmxDSXM1Z0M1NWZxUzE3cXBON2JTaWtGOW5uN29uSmM1?=
 =?utf-8?B?ekNRQ2FTbmdabWRheTU4d2ZCeUpMNW13Ymh4NlBPWDU1K3F2MVVabXRqSmJH?=
 =?utf-8?B?MlA4Vjl0QjQxbFc0YmZRVmowNVlEd1dDNDk3UWZGZStEbXRkUWNSOVZjTXI5?=
 =?utf-8?B?dmhpZmgwOFk0L1l1S3pGYzB6Q3RtbHlERTdndjNvRDUrNmhYT2lsVXBZRnlK?=
 =?utf-8?B?cFhqRFVOUVZhWlNQanlkVmtpT3F0KzhGVDRtclpHb0tEK0xFcHU1VG9naXht?=
 =?utf-8?B?NmJwYysvaStWakMrUURiMmdUdjg5RVhWdXRWakFFaFlHRUtnN00zdC8xa1cv?=
 =?utf-8?B?eCtYeFZYVnNFU0E0eHJKaDkrLzNwOXN2SnptLzVqa2FmWCtIN2F4aUhGbFB0?=
 =?utf-8?B?TmUzWW9GTHN3YTdkbWViZ0FMYUJKTWZZSko1SEN3YVlHelhvdjBzNnZaZG5H?=
 =?utf-8?B?OEVvUjJoVi9tZVdtSDcwVm5YU3Qxc2JxQmQyNWVHNnM0K3lWVTI0Zi9KTUg0?=
 =?utf-8?B?VlRsb096M0I5TEd5aWJFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ljMEppUllUS0ttZzlMRnkxVTFRYUdiVE1BSVJWQW1mMHdERWY2dm5UTk9C?=
 =?utf-8?B?V2owQzhRU1FXOFRkbEI0dGJyRmpPbzNjUDdOdmFGSmoyY21rMXZGaEswcDB4?=
 =?utf-8?B?N1UxUGVJT2RhVzZ1K0tTaXgzWlVaRk1sZ0NJWGZVaU1jVWhqK2lveG5RVVJ4?=
 =?utf-8?B?aVJSU2tHSlkyWDQxbTc4NmJ1TEVGNmwzUmY4ZHRROTVQeFdVcENUWWkwMnVW?=
 =?utf-8?B?S2x0Q2VYOWh0R1BWUzBaMVEwM0xWZytZSzE1Q2R4V3RmdkJjaTU4Y3IxWGV1?=
 =?utf-8?B?OUkxc1kvQzN0ZmxQdzZCNlo2T1hlVEZTdWU0dVpDdjJTRkxrL2lrNElFUVhH?=
 =?utf-8?B?cXJZUDZhUEhGVmM1NFo3NCtjakgzSmxUUFE0Z0F1bi9qMVlQQ1U1TTFsNW03?=
 =?utf-8?B?Vk03cVk2ZkZWclROQitKS2xudkQwdmpTNVFsQmFmYldVWWIyTE96eXkxL3l4?=
 =?utf-8?B?THo0QU5sdmg1WDE0S2JyajJsT2kwZDFxeEJEMTVQVk9abVFZSzExOTVKMXM3?=
 =?utf-8?B?KzU0bUpUMnA5WGxsazhZa2NtU0pHdi9kdFNPbWN0Z3poQ2V3Q2lRd2JkNDZ2?=
 =?utf-8?B?NnFYcjFndWNJY2JJa0FYRVBrU0VTcGpZbXNXYWtYVG5GcE12Zm5PZUh4RytB?=
 =?utf-8?B?NDduSXFsY0JmYy9xNWxJSDd2cG9iVWRiZTNxV0JkL1ladnJGRStRVjk1YlRX?=
 =?utf-8?B?bEMyWWVyRER0K0JkTXhqbzRRSWMzVHhJOVlnU2RVZTRMWFExL2VxaUxNOG5Q?=
 =?utf-8?B?a0ZmUHpGWlh4MllldFhWeEQzSys5SlNjT29BR2MzUnVHV0RsWWhsWG9pQWg3?=
 =?utf-8?B?YStXZEVBTkR3VWN0K3R5Z0pBbVVyM3RyY0RXVlp4L0xZaDNRc294ZjkvRWo4?=
 =?utf-8?B?cCtocUxnY1VybGlnZTN1Y1kxMWJMcU5wdGVoNko2N1lBS1locFI2RWJ2MzBh?=
 =?utf-8?B?MjU3ODNwM2ViZDBmV1NKOTZseXpOK2lVTm9DaXZYbWpOS0tjK1YyRHFxZ3VT?=
 =?utf-8?B?NldTTmlxQXVpUU5aekVzc28rN3ZyVTJ2aTRLcElFdWtndWhab0cvLzRacTBo?=
 =?utf-8?B?QVhoYkhLcFNUOFk2T0MzTVVjN1VWLy9kVFhmbDZBOWhqbmp4eVBqNGRtYk10?=
 =?utf-8?B?SjJVNTdMNXRnQUdldzJCY3psN0ZZenBvV0VCbzNvOEJ4K2JQMTE1Uzhka3li?=
 =?utf-8?B?bnB4Z2t2Z1NlbFg4a211cVZqMGNOSVVXaWNQaWRnQTk4MXg3aTdleGZUQVYz?=
 =?utf-8?B?ajI2MFU3MUFmZEdMRGF2UzZUcXlvMTRkUXhEcDErNENYWWx0eGpkaXMxWTRZ?=
 =?utf-8?B?UDhlNXdKd1NwakE0N2ZMazZWY3VoRGxFYm5aZEZBU0lOdnhsUUFEUEs2ZURN?=
 =?utf-8?B?cXQwZGsva2RRTERnSWdhWUc4ZkxabEs2UzhOaENRWWFvUUVtcmNQeEV6SlpN?=
 =?utf-8?B?WDkvWmxBc3BYSk81YXI3MU5FMTVkUjkxZ3B5Ry80ZThUU2Y2citUdXdnRnVs?=
 =?utf-8?B?MXlJa2RJSkZtNUJHZC9YeWdzUUxIQmd6UDkrUDhSVGRtSjdWL01xRFJ2MERR?=
 =?utf-8?B?NW9DaUZocm0wUCtJYU4xRHBCVFhCSTlFYjBxKzFjQ1R0Q3hSMDN2U0lvNStC?=
 =?utf-8?B?K1h2Ny9aMjRQZkRybmx5UkduK044UDdOaE9FRHY5V3hMUFdYbUg5Sjhra09l?=
 =?utf-8?B?dzFTZ09JVFBuWUppdkg4d1FwblZNUlhjUVBCZ3dCUEEvR1kwSnhUb2Nyampl?=
 =?utf-8?B?RGpyVWNkSXBiSk16WnZSMWhXOXVCWUhsSWZqQW55UGprY0NNaWhNS1NzRWpF?=
 =?utf-8?B?SThwNGdPYTZBM04vclNWMHBrSWNuVUEzcHlmUnA2L2ZzQm1RdWdEWFhndTI2?=
 =?utf-8?B?eDZMTmdPSFpZbDZuMWJRMDJIdHhaeGR4d1RlQjVBN01DdkhGYWtsU2RKdFNF?=
 =?utf-8?B?NTNlb21FS0JIR2pLMUVQQUpxaUg4L21OTlpqNW5SeDZIaHJNRk1zcDJXUWdi?=
 =?utf-8?B?QkkwQi9iY0RJdFRDUUJUWGlhR0hzWnUweVA1SjNldlNWWG5YMkJLeE15TDNt?=
 =?utf-8?B?NnBJbFlmbS9FbmhXSjlJQmFoZHkwdnZRK2kwTUs5dXJRV3ZrVVlYS3BpeWIr?=
 =?utf-8?Q?Z4J8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e7bf0d-c3ad-4d30-225b-08dcafff9680
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:52:25.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YsseCcA8n3J+kXjyJa3GSc+WoGhtcwqOSgYb+ukzR8bk1uElKhXCJB4fPPuW04X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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


On 7/29/2024 1:23 PM, Christian König wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> Am 25.07.24 um 20:19 schrieb Xiaogang.Chen:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> When app unmap vm ranges(munmap) kfd/svm starts drain pending page 
>> fault and
>> not handle any incoming pages fault of this process until a deferred 
>> work item
>> got executed by default system wq. The time period of "not handle 
>> page fault"
>> can be long and is unpredicable. That is advese to kfd performance on 
>> page
>> faults recovery.
>>
>> This patch uses time stamp of incoming page page to decide to drop or 
>> handle
>> page fault. When app unmap vm ranges kfd records each gpu device's ih 
>> ring
>> current time stamp. These time stamps are used at kfd page fault 
>> recovery
>> routine.
>>
>> Any page fault happens on unmapped ranges after unmap events is app 
>> bug that
>> accesses vm range after unmap. It is not driver work to cover that.
>
> But that defers destroying the unmapped range until the IH ring is
> cleared, isn't it?
>
This patch change the time period that kfd "not handling page fault" or 
the time when kfd resume handling page fault. The destroying unmapped 
range is still at defer work, same as current implementation.
>>
>> By using time stamp of page fault do not need drain page faults at 
>> deferred
>> work. So, the time period that kfd does not handle page faults is 
>> reduced
>> and can be controlled.
>>
>> Signed-off-by: Xiaogang.Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 102 ++++++++++++++++---------
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
>>   7 files changed, 79 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3abfa66d72a2..d90b7ea3f020 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>    * shouldn't be reported any more.
>>    */
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>> -                         u32 vmid, u32 node_id, uint64_t addr,
>> +                         u32 vmid, u32 node_id, uint64_t addr, 
>> uint64_t ts,
>>                           bool write_fault)
>>   {
>>       bool is_compute_context = false;
>> @@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct 
>> amdgpu_device *adev, u32 pasid,
>>       addr /= AMDGPU_GPU_PAGE_SIZE;
>>
>>       if (is_compute_context && !svm_range_restore_pages(adev, pasid, 
>> vmid,
>> -         node_id, addr, write_fault)) {
>> +         node_id, addr, ts, write_fault)) {
>>               amdgpu_bo_unref(&root);
>>               return true;
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 312a408b80d3..1d6a1381ede9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>>   void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
>>
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>> -                         u32 vmid, u32 node_id, uint64_t addr,
>> +                         u32 vmid, u32 node_id, uint64_t addr, 
>> uint64_t ts,
>>                           bool write_fault);
>>
>>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index d933e19e0cf5..3596cc2ee7e5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>               /* Try to handle the recoverable page faults by filling 
>> page
>>                * tables
>>                */
>> -             if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, 
>> addr, write_fault))
>> +             if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
>> +                                        entry->timestamp, write_fault))
>>                       return 1;
>>       }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 350f6b6676f1..ac08d9424feb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>                       cam_index = entry->src_data[2] & 0x3ff;
>>
>>                       ret = amdgpu_vm_handle_fault(adev, 
>> entry->pasid, entry->vmid, node_id,
>> -                                                  addr, write_fault);
>> +                                                  addr, 
>> entry->timestamp, write_fault);
>> WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
>>                       if (ret)
>>                               return 1;
>> @@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>                        * tables
>>                        */
>>                       if (amdgpu_vm_handle_fault(adev, entry->pasid, 
>> entry->vmid, node_id,
>> -                                                addr, write_fault))
>> +                                                addr, 
>> entry->timestamp, write_fault))
>>                               return 1;
>>               }
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index c51e908f6f19..771c98e104ee 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -850,10 +850,13 @@ struct svm_range_list {
>>       struct list_head                criu_svm_metadata_list;
>>       spinlock_t                      deferred_list_lock;
>>       atomic_t                        evicted_ranges;
>> -     atomic_t                        drain_pagefaults;
>> +     /* stop page fault recovery for this process */
>> +     atomic_t                        stop_pf_recovery;
>>       struct delayed_work             restore_work;
>>       DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>>       struct task_struct              *faulting_task;
>> +     /* check point ts decides if page fault recovery need be 
>> dropped */
>> +     uint64_t checkpoint_ts[MAX_GPU_INSTANCE];
>>   };
>>
>>   /* Process data */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 407636a68814..fb0e883868b4 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2263,16 +2263,10 @@ static void 
>> svm_range_drain_retry_fault(struct svm_range_list *svms)
>>   {
>>       struct kfd_process_device *pdd;
>>       struct kfd_process *p;
>> -     int drain;
>>       uint32_t i;
>>
>>       p = container_of(svms, struct kfd_process, svms);
>>
>> -restart:
>> -     drain = atomic_read(&svms->drain_pagefaults);
>> -     if (!drain)
>> -             return;
>> -
>>       for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>>               pdd = p->pdds[i];
>>               if (!pdd)
>> @@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct 
>> svm_range_list *svms)
>>
>>               pr_debug("drain retry fault gpu %d svms 0x%p done\n", 
>> i, svms);
>>       }
>> -     if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
>> -             goto restart;
>>   }
>>
>>   static void svm_range_deferred_list_work(struct work_struct *work)
>> @@ -2315,17 +2307,8 @@ static void 
>> svm_range_deferred_list_work(struct work_struct *work)
>>                        prange->start, prange->last, 
>> prange->work_item.op);
>>
>>               mm = prange->work_item.mm;
>> -retry:
>> -             mmap_write_lock(mm);
>>
>> -             /* Checking for the need to drain retry faults must be 
>> inside
>> -              * mmap write lock to serialize with munmap notifiers.
>> -              */
>> -             if (unlikely(atomic_read(&svms->drain_pagefaults))) {
>> -                     mmap_write_unlock(mm);
>> -                     svm_range_drain_retry_fault(svms);
>> -                     goto retry;
>> -             }
>> +             mmap_write_lock(mm);
>>
>>               /* Remove from deferred_list must be inside mmap write 
>> lock, for
>>                * two race cases:
>> @@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>> struct svm_range *prange,
>>       struct kfd_process *p;
>>       unsigned long s, l;
>>       bool unmap_parent;
>> +     uint32_t i;
>>
>>       p = kfd_lookup_process_by_mm(mm);
>>       if (!p)
>> @@ -2455,11 +2439,37 @@ svm_range_unmap_from_cpu(struct mm_struct 
>> *mm, struct svm_range *prange,
>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", 
>> svms,
>>                prange, prange->start, prange->last, start, last);
>>
>> -     /* Make sure pending page faults are drained in the deferred 
>> worker
>> -      * before the range is freed to avoid straggler interrupts on
>> -      * unmapped memory causing "phantom faults".
>> +     /* calculate time stamps that are used to decide which page 
>> faults need be
>> +      * dropped or handled before unmap pages from gpu vm
>>        */
>> -     atomic_inc(&svms->drain_pagefaults);
>> +     for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>> +             struct kfd_process_device *pdd;
>> +             struct amdgpu_device *adev;
>> +             struct amdgpu_ih_ring *ih;
>> +             uint32_t checkpoint_wptr;
>> +
>> +             pdd = p->pdds[i];
>> +             if (!pdd)
>> +                     continue;
>> +
>> +             adev = pdd->dev->adev;
>> +
>> +             /* check if adev->irq.ih1 is not empty */
>> +             ih = &adev->irq.ih1;
>> +             checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> +             if (ih->rptr != checkpoint_wptr) {
>> +                     WRITE_ONCE(svms->checkpoint_ts[i], 
>> checkpoint_wptr);
>> +                     continue;
>> +             }
>> +
>> +             /* check if dev->irq.ih_soft is not empty */
>> +             ih = &adev->irq.ih_soft;
>> +             checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> +             if (ih->rptr != checkpoint_wptr) {
>> +                     WRITE_ONCE(svms->checkpoint_ts[i], 
>> checkpoint_wptr);
>> +                     continue;
>> +             }
>> +     }
>>
>>       unmap_parent = start <= prange->start && last >= prange->last;
>>
>> @@ -2900,7 +2910,7 @@ svm_fault_allowed(struct vm_area_struct *vma, 
>> bool write_fault)
>>   int
>>   svm_range_restore_pages(struct amdgpu_device *adev, unsigned int 
>> pasid,
>>                       uint32_t vmid, uint32_t node_id,
>> -                     uint64_t addr, bool write_fault)
>> +                     uint64_t addr, uint64_t ts, bool write_fault)
>>   {
>>       unsigned long start, last, size;
>>       struct mm_struct *mm = NULL;
>> @@ -2910,7 +2920,7 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       ktime_t timestamp = ktime_get_boottime();
>>       struct kfd_node *node;
>>       int32_t best_loc;
>> -     int32_t gpuidx = MAX_GPU_INSTANCE;
>> +     int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
>>       bool write_locked = false;
>>       struct vm_area_struct *vma;
>>       bool migration = false;
>> @@ -2930,12 +2940,39 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>
>>       pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, 
>> addr);
>>
>> -     if (atomic_read(&svms->drain_pagefaults)) {
>> -             pr_debug("draining retry fault, drop fault 0x%llx\n", 
>> addr);
>> +     /* kfd page fault recovery is disabled */
>> +     if (atomic_read(&svms->stop_pf_recovery)) {
>> +             pr_debug("page fault handing disabled, drop fault 
>> 0x%llx\n", addr);
>>               r = 0;
>>               goto out;
>>       }
>>
>> +     node = kfd_node_by_irq_ids(adev, node_id, vmid);
>> +     if (!node) {
>> +             pr_debug("kfd node does not exist node_id: %d, vmid: 
>> %d\n", node_id,
>> +                      vmid);
>> +             r = -EFAULT;
>> +             goto out;
>> +     }
>> +
>> +     if (kfd_process_gpuid_from_node(p, node, &gpuid, &gpuidx)) {
>> +             pr_debug("failed to get gpuid/gpuidex for node_id: %d 
>> \n", node_id);
>> +             r = -EFAULT;
>> +             goto out;
>> +     }
>> +
>> +     /* check if this page fault time stamp is before 
>> svms->checkpoint_ts */
>> +     if (READ_ONCE(svms->checkpoint_ts[gpuidx]) != 0 &&
>> +                   amdgpu_ih_ts_after(ts, 
>> READ_ONCE(svms->checkpoint_ts[gpuidx]))) {
>> +             pr_debug("draining retry fault, drop fault 0x%llx\n", 
>> addr);
>> +             r = 0;
>> +             goto out;
>> +     } else
>> +             /* ts is after svms->checkpoint_ts now, reset 
>> svms->checkpoint_ts
>> +              * to zero to avoid following ts wrap around give wrong 
>> comparing
>> +              */
>> +             WRITE_ONCE(svms->checkpoint_ts[gpuidx], 0);
>
> Pretty clear NAK to using WRITE_ONCE like this. You have exactly zero
> memory barrier here.
>
ok, svms->checkpoint_ts is 64 bits integer. If updating it is atomic we 
do not need use write_once or read_once.

Regard

Xiaogang

> Regards,
> Christian.
>
>> +
>>       if (!p->xnack_enabled) {
>>               pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>>               r = -EFAULT;
>> @@ -2952,13 +2989,6 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>               goto out;
>>       }
>>
>> -     node = kfd_node_by_irq_ids(adev, node_id, vmid);
>> -     if (!node) {
>> -             pr_debug("kfd node does not exist node_id: %d, vmid: 
>> %d\n", node_id,
>> -                      vmid);
>> -             r = -EFAULT;
>> -             goto out;
>> -     }
>>       mmap_read_lock(mm);
>>   retry_write_locked:
>>       mutex_lock(&svms->lock);
>> @@ -3173,9 +3203,11 @@ void svm_range_list_fini(struct kfd_process *p)
>>       /*
>>        * Ensure no retry fault comes in afterwards, as page fault 
>> handler will
>>        * not find kfd process and take mm lock to recover fault.
>> +      * stop kfd page fault handing, then wait pending page faults 
>> got drained
>>        */
>> -     atomic_inc(&p->svms.drain_pagefaults);
>> +     atomic_set(&p->svms.stop_pf_recovery, 1);
>>       svm_range_drain_retry_fault(&p->svms);
>> +     atomic_set(&p->svms.stop_pf_recovery, 0);
>>
>>       list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>>               svm_range_unlink(prange);
>> @@ -3197,7 +3229,7 @@ int svm_range_list_init(struct kfd_process *p)
>>       mutex_init(&svms->lock);
>>       INIT_LIST_HEAD(&svms->list);
>>       atomic_set(&svms->evicted_ranges, 0);
>> -     atomic_set(&svms->drain_pagefaults, 0);
>> +     atomic_set(&svms->stop_pf_recovery, 0);
>>       INIT_DELAYED_WORK(&svms->restore_work, svm_range_restore_work);
>>       INIT_WORK(&svms->deferred_list_work, 
>> svm_range_deferred_list_work);
>>       INIT_LIST_HEAD(&svms->deferred_range_list);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 70c1776611c4..5f447c3642cb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node 
>> *node, struct svm_range *prange,
>>                           bool clear);
>>   void svm_range_vram_node_free(struct svm_range *prange);
>>   int svm_range_restore_pages(struct amdgpu_device *adev, unsigned 
>> int pasid,
>> -                         uint32_t vmid, uint32_t node_id, uint64_t 
>> addr,
>> +                         uint32_t vmid, uint32_t node_id, uint64_t 
>> addr, uint64_t ts,
>>                           bool write_fault);
>>   int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence 
>> *fence);
>>   void svm_range_add_list_work(struct svm_range_list *svms,
>
