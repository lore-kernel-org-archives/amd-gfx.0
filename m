Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6A0D2444E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 20:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCB910E9C7;
	Thu, 10 Oct 2024 20:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YY4PH2m8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C335810E9C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 20:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHncuALpjcEUb/+/Vse/z00crLH42/xRTaB2BVSd4+hbcGCalJlo3pnFQH9k8drTGktSb0FP78gJCGBuLraDvAkzSauL3GJz76ZAiPlvUb3FQHTFWza8OPozEZsf7lQ4/uwcVH1S3+L3b7PW8o1VrqpIgtZi/eyZWJGeywQcU00uNLwzOcZBJTRpHsCE4A+89K9Bcp3JX2y418R9dkLCup0TOw159C1MKL+6SGYJPG/jDotZ/aZi5CA0CymS20o/yvVukKGeRllfRJURAD0qRux2xUcj/aaz1Z1jmWa1I/GWI1g170F7sv3cIYCXgs6K2htDTJjPRuHUqNWceJo/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S73JKMSIxaBK+QbKkIfKxoKk4XNSlg7ZA79qG1b5ED4=;
 b=ju1XC9h39q6BNsiEskGJb4kpF+L7KuTE6zZxJUMdRnZRW0KjLSHeq64ID0JgfDeeJOg1p3SqloUqzirz63K/XDATUp5O/iu+IFztiQP1EwGa42E9CtxysVhPDfwhukCxOjJve1Ha1h++qb/gp79z1ZryVe82mzi4P7C9pAL1iOyGkqZez/+FpBh9dFXGjGbT4Rr01rD6dWIqdUtAkNSob5rrHR9hGkPzPYWz6G6u4Nd4WOpO1ED5N+9UyKxhoidzGCRyF0gVD1OZne/lHMCKs1m89973fKniLBmLk4wlOEmOPgyD0GtidLNxjMqfUFUSlQceK/LCpDyYCbueHPJxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S73JKMSIxaBK+QbKkIfKxoKk4XNSlg7ZA79qG1b5ED4=;
 b=YY4PH2m8XkwVPCdvmUXaAFE2JBlO4wq1wdIAlZG1Rugtyp3LGV6lzm3t2b765cbYDMyWjbyWRGZqfhMc9vm2k31B8AFEtq4C/czb4hSTP+//3LgarGwMW9skUHL47rT/lk3ZuD5LK5swWcnq5TjJiUga72JeCXBFbQWtWhT81v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 20:19:07 +0000
Received: from PH7PR12MB6561.namprd12.prod.outlook.com
 ([fe80::78f3:7e6b:4d7c:5b3b]) by PH7PR12MB6561.namprd12.prod.outlook.com
 ([fe80::78f3:7e6b:4d7c:5b3b%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 20:19:06 +0000
Message-ID: <381a4701-1b3d-4bf9-a361-329fd090ba44@amd.com>
Date: Thu, 10 Oct 2024 15:19:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
 <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
 <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
 <0e685c63-ca07-4147-9051-bac211f52661@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <0e685c63-ca07-4147-9051-bac211f52661@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:806:d2::34) To PH7PR12MB6561.namprd12.prod.outlook.com
 (2603:10b6:510:213::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6561:EE_|MW4PR12MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f62881-b086-44f1-8198-08dce968ca95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDhWa2NhTzY5dTZTeUJZbVBzQmJ1c255c2cyTjRiRkJLWCs4WXRLaEI2OWtv?=
 =?utf-8?B?RVJlbjF4UUxmQzhqWkdmL21xRER1Smp0anpZSDMzWDgxYzhnaThKU001aXFU?=
 =?utf-8?B?SHVHNzY5cVh5aVFHdVZYVlF4M3VMaWtVMkloYXJndjVnYzczTDlqc3JCaUgx?=
 =?utf-8?B?QldIWHcwSEsyMDlTV3R1MTBYalV1RC9UNzkvUzd4elRWNVdaRDJlZTJuN2R6?=
 =?utf-8?B?SE1lRm9QT0ZERzVxWG1IWjR1cTBpa1ZmRWRSdzNINDJ0YXhIK2g2QXR2dEJV?=
 =?utf-8?B?NFdPSzBHdC96cG1Nc0YzWXFtYmhXTUl3ZTJTRXZXeDdPbnlycEp1OEhTQlhJ?=
 =?utf-8?B?cEJ1NUU2Nmh6a1h5Szc1Z2Q1ZlYyUTE4eEVQSUJFK094eVRYK0VoWHd3TEpC?=
 =?utf-8?B?cUdUTDBEdkRQRHRyVE1BK1lrb01pS1pOMm1wUlhVSVhvQnVibTNCb1NjUkRq?=
 =?utf-8?B?RVBXZUlhT3VvVDR3WGJtckdtVVFDWUNYeEU0VkFWZ2Zhc3pJYVRkNjJ1Y0xM?=
 =?utf-8?B?NSttYTJvYkdLY2Y3R0ZqbUtZVzdTYTk0U010UHB6UEwyQm5yb3hKVHpqVThl?=
 =?utf-8?B?c0hiU2puRWM1VXNjdTVVZk1mQlBmU28zSzBJU2RVSElMREdsU1VqSndDRG0x?=
 =?utf-8?B?NEcxQktuNmVQVVlVUDNQVWFBOHNVVmFSY3RrVExVUzVvTTFWZVRmb2QvWW5W?=
 =?utf-8?B?NHFxZXVnN2hxNVhFbzJVUHE0dEh5UTgrSVBRUzd1OGlFVEhueHFIaVBveHhx?=
 =?utf-8?B?aERQUTFFdFgvQXpMNTRhdE53Z203bEtxY2FhZDBGclZmNVlGQ2F4TXpxZDEw?=
 =?utf-8?B?RHluWnVTc2RtL3FzSFVRdlFtV0ZwdW1DUmF0WTcrRGhDaVpwc0NZNjN4UTFF?=
 =?utf-8?B?alhFRzhad0Z1bGRXT0ZpSEwzZzBQNjFpOUVHa3p6MVUrSnQrVW1lenAxTXdP?=
 =?utf-8?B?WHVJdC9QbVhkOW5oaEpPWFY5QTdCUFZ4ZisyZEtzZUJiUUorSUI3aGNxVG03?=
 =?utf-8?B?c3k3NVhzeFd3T1ZNSlFyc1FXNUpPdVI2R2xFQXR1bmkwTlJoZ2NJQjBjTTNu?=
 =?utf-8?B?Z0JrcWlocTE3c1JnTkppdzZoMTZOWUhGdUZKWmZzRnJZVGFlemUxbGYwd1kx?=
 =?utf-8?B?U1hCUnNtc2k5Nk9KUEw2Y2hPdkxWeWFpY3pPNXJvWlp0aEVWT0JNcG9wZ2VT?=
 =?utf-8?B?aU56dE5nanpjWmRBS0dLTW5aemsxbTdqNlNaa2o4MzRlNHcwQVJKSWpKTHVy?=
 =?utf-8?B?MTVmNjJDUjJNN2R1Q3R2YXB3OG9scVRMSEp1SnV1K2RXQkk0YW1mSTE5TnRr?=
 =?utf-8?B?b3FDSkhXby9ORDJiZTc2RWN5RDZxTWd1WklnL2xJdWUxTzhVb0dmbnllazV6?=
 =?utf-8?B?Zkc3UzVrZ3p0eXRkaEp5R0RpVzlqaHV3Q2tZYlI4eXYxR2J0NXA4bnBLSjly?=
 =?utf-8?B?YkE2SHAwT0xFd0IrTCtSZjIxS090d3Z4N3VlUkV4TWVPU2R2K3BIYUEzUU5E?=
 =?utf-8?B?RDBORnQzdE0raFJoMFBSVXFkblF6eEY4SWZTRzh2UU94OFZzVU9tZnFZeHJr?=
 =?utf-8?B?cmtjSmpqdVd2YWNNcnVzRUNxc09Ua0RwcUx1OFM5bGpCNllOb3JBYzZjSkZM?=
 =?utf-8?B?K0pYRFhXYm5RNnRYaTVwTnpGUlp0Q0FyTjluOSs1bEFsZCtCMk5PMmo2RGhx?=
 =?utf-8?B?Z0VlOVB0SEVmWWxGbld5eGRPNXVVQjBrSnZhdVpaV3VkbGV4aG9NN3p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6561.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtFSGFvU1ZnQVZjZm5lSEZrbHhKdWFReW5IbWdUV3ByUDkxQ1gxR0pwRk1D?=
 =?utf-8?B?d2dmOUVQWUxZNHkvbktXbythUzlhZkRONFpXSEZLRkZXY09id25GMStsUy9s?=
 =?utf-8?B?OFZ0ZXNsY05EL0VoWjZqMzA4Qmc0Y3RYMWxQUmhrL3g0L1BYSlZ0NUJ0RGNU?=
 =?utf-8?B?aXlMOUczK3JMcEI4SUtDYUNNVlFJY3VNNmVrelQ2T3Y1S3ljaVRzcjJrWDFQ?=
 =?utf-8?B?QUU4Rkd0VlhFRVNkak1YWFluVURFMWdjeVlaZ2FwUjFmZDZSbEhiS3VuVFp4?=
 =?utf-8?B?S3dzTkRLb0pSSm5Jdm9RK0xiTUNtMWRjOUpoeUZ0LzhuTlBwRWxWZVI3Vmdm?=
 =?utf-8?B?dE55S212a05Qdk9idkxOU1NSYWhHQ1B0SXJOSmlwc0JtcXJabVpFOWx4NDhO?=
 =?utf-8?B?aXk1OVJzaktMRHRzRit3L0tUdVhKc2k4ZkIwWFYxZldmalhCeW1iZ09kVlhk?=
 =?utf-8?B?V3BTQnQvZUNKdE9FSm9MZ1h0OFJDckI2RzgyZzlJWXFTL3FFU3Ezd1RmZUc2?=
 =?utf-8?B?Y3JJU1dhQVRLV0F5clduNjc4andvUHhzWG84dlNRRjMvd2RzbHdEZ1luNEt1?=
 =?utf-8?B?RlN3Q05zVlRVcGFFRjBCL0JaSkR5UHlxVmJIQyt3T0Z1bVhQSENoL0NjdVk1?=
 =?utf-8?B?dWVybjF3aElQM2s5VndHUklLeHBzNG9vLzdscS9EMHpLQmF0K3dUMXNwYjlO?=
 =?utf-8?B?VVZLMXhYMkFzMHUrOC9rNm9RYWpXbXNlenpuR0htUEd3a3BycFBqeTBqK3FT?=
 =?utf-8?B?ZEZDajA5R1Z6b2YxcmlNLy9xNitlMHRnekZLUHhtRzMwTlF0VUNVQU9icExV?=
 =?utf-8?B?YkExa0VycGpUNDZ6TWxEM2F2K2dhYXVmTlFyTE82TFYyd2NBRXZQN1R1V2hs?=
 =?utf-8?B?MTl2bk01Z2xxUmh1SkU1Z0FJdUk4MHh6S0NtdUZlY0FqMlFpTjdGZStJell2?=
 =?utf-8?B?bEVraXFiaUd1WDEzT1dhM1hWNmFubHFGTmJLL2xWS3lya0YvUnFURjRGdXJv?=
 =?utf-8?B?MDZrQWZKdS9NNjdzbWF3RmViWW8wTUR6a0p6dzVYNGo5ZFhyRnZrSEVpZVNG?=
 =?utf-8?B?Vnh3d0tuenU1VzRRdHdibTRLUHpPdG1IUHFQbi9XRXdvK1VtSUNyaWcwdDY0?=
 =?utf-8?B?M1RXVUlLcnE0clVpOUc0TXJ3d0Z5UjRGRXc1ejRWelBMcmFQcWxJaGJlKzFt?=
 =?utf-8?B?cURoaWZpdXRlTXNPTklSUWdRc0lLSGlXVnpyLzkyc0lyb3hNOUN4L0tVdXk4?=
 =?utf-8?B?SmpZOU1raWQwY1VrOTAvSGhkWEdMb3k1dGREbFFvQlljMXJuVmxMb0xoMUd4?=
 =?utf-8?B?dlNCMjJRVmZFZXBUMWpWRXJ2ajZ5QXI5dTFuTE1BWC9DcVJodGJNaW5IOCs2?=
 =?utf-8?B?REtmTFQ0NDVpdWVrdk54blNicUcvUGQyektiU0cxakJoVXdRazRqK09ETWYy?=
 =?utf-8?B?T1AveTVzb0trcGpuSmpRbC9aNjFWcGtmdTZrRDVHWWE1VXdKSm5vMWJhbDVo?=
 =?utf-8?B?U0JldzN4K1d1UGpDczZaLzJiOUZCKytoci95dm03ZlBtajZmVkpoNFkzdFFR?=
 =?utf-8?B?djl4ZWxVbERjeGNFN1dTZ00wcmVWVkpCOHRhU3lDUnE5YVlHc0p4bHFMenZp?=
 =?utf-8?B?UGlBT09QRWtiaUlQY0hlRkx2TmdseSs1UG9kcU5waG9lZ3dpZmRnZHdVbkQw?=
 =?utf-8?B?M2NXT1VhdFNKaVladkJ1dVdFcXpaTXIvSDJjSHU3YTZVMVo5c2swUnNlVmll?=
 =?utf-8?B?RStEUzY4Y1NJUm1BcWV2dVlHL2NPdUVER0FIekFsb0ptbGM5bFUrbnBOaHRp?=
 =?utf-8?B?UjJwVlU4UjAyT1B3VE14Q1lXampIelcwVlhOTE1pYTExcmdHdThNcDQvclk2?=
 =?utf-8?B?dk40K2xLTXg1alJlQ09lMTJiaFh0OTFCUTQ1dllCU0dJUjdoOFlSeUh1NWVo?=
 =?utf-8?B?b0U5VmRrTHNQOXBiZ3QxMzBLTkw4bkZsZFMxWkJDY0VBQ2dNNndlS3BNSWMx?=
 =?utf-8?B?azNUbnRuN3NmRzlCTHQwczR2KzhicTJOdUVXSWcwVmtJazVLMjQ1bWZ0ai96?=
 =?utf-8?B?cnN2T2ovUkFkaGVDN0xTdDJqRlhNdFcvdUlVdTZCVEZrdnBHMjdJWFBZWk5j?=
 =?utf-8?Q?NYHs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f62881-b086-44f1-8198-08dce968ca95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6561.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:19:06.5984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud2uSu3+FAgexMmSh4lyNcBO9ZwIgrmcBxi+srCZ82biD6PCXB48cLts+ybOMfFS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
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


On 10/10/2024 2:01 PM, Felix Kuehling wrote:
>
> On 2024-10-09 18:16, Chen, Xiaogang wrote:
>>
>> On 10/9/2024 4:45 PM, Felix Kuehling wrote:
>>>
>>> On 2024-10-09 17:02, Chen, Xiaogang wrote:
>>>>
>>>> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>>>>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>
>>>>>> kfd process kref count(process->ref) is initialized to 1 by 
>>>>>> kref_init. After
>>>>>> it is created not need to increaes its kref. Instad add kfd 
>>>>>> process kref at kfd
>>>>>> process mmu notifier allocation since we decrease the ref at 
>>>>>> free_notifier of
>>>>>> mmu_notifier_ops, so pair them.
>>>>>
>>>>> That's not correct. kfd_create_process returns a struct 
>>>>> kfd_process * reference. That gets stored by the caller in 
>>>>> filep->private_data. That requires incrementing the reference 
>>>>> count. You can have multiple references to the same struct 
>>>>> kfd_process if user mode opens /dev/kfd multiple times. The 
>>>>> reference is released in kfd_release. Your change breaks that use 
>>>>> case.
>>>>>
>>>> ok, if user mode open and close /dev/kfd multiple times(current 
>>>> Thunk only allows user process open the kfd node once)  the change 
>>>> will break this use case.
>>>>> The reference released in kfd_process_free_notifier is only one 
>>>>> per process and it's the reference created by kref_init.
>>>>
>>>> I think we can increase kref if find_process return true(the user 
>>>> process already created kfd process). If find_process return false 
>>>> do not increase kref since kref_init has been set to 1.
>>>>
>>>> Or change find_process(thread, false) to find_process(thread, true) 
>>>> that will increase kref if it finds kfd process has been created.
>>>>
>>>> The idea is to pair kref update between alloc_notifier and 
>>>> free_notifier of mmu_notifier_ops for same process(mm). That would 
>>>> seem natural.
>>>
>>> What's the problem you're trying to solve? Is it just a cosmetic 
>>> issue? The MMU notifier is registered in create_process (not 
>>> kfd_create_process). If you add a kref_get in 
>>> kfd_process_alloc_notifier you need to kfd_unref_process somewhere 
>>> in create_process. I don't think it's worth the trouble and only 
>>> risks introducing more reference counting bugs.
>>
>> It is for making code cleaner or natural to read. mmu_notifier_get is 
>> the last call at create_process. If mmu_notifier_get fail the process 
>> is freed: kfree(process).  If create_process success 
>> kfd_create_process return that process anyway(after create_process 
>> kfd_create_process creates sys entries that not affect return created 
>> kfd process). The finally result is same that kref is 2: one for kfd 
>> process creation, one for mmu notifier allocation.
>
> Currently, when you call kfd_create_process for the first time, it 
> returns with kref=2. One reference for the MMU notifier, and one for 
> file->private_data.
>
> Subsequent invocations of kfd_create_process when the process already 
> exists should increment the kref by one to track the additional 
> reference put into the new file->private_data.
one ways is changing find_process(thread, false) to find_process(thread, 
true) at kfd_create_process. When kfd process already exist find_process 
will call kref_get(&p->ref);
>
>
> If you can come up with a patch that preserves this logic _and makes 
> the code simpler and more readable_, I will consider approving it. 
> Also keep in mind that your patch would need to be ported to the DKMS 
> branch, where there are two different code paths to support older 
> kernels that don't have mmu_notifier_get/put.
>
At DKMS branch alloc_notifier and free_notifer either exist together or 
both not exist. So when HAVE_MMU_NOTIFIER_PUT is defined(new kernel) it 
is ok.

#ifdef HAVE_MMU_NOTIFIER_PUT
         .alloc_notifier = kfd_process_alloc_notifier,
         .free_notifier = kfd_process_free_notifier,
#endif

but when HAVE_MMU_NOTIFIER_PUT is not defined we need change 
kfd_process_destroy_delayed since since it call kfd_unref_process(p);

static void kfd_process_destroy_delayed(struct rcu_head *rcu)
{
         struct kfd_process *p = container_of(rcu, struct kfd_process, rcu);

         kfd_unref_process(p);
}

That means if port this patch to dkms branch when HAVE_MMU_NOTIFIER_PUT 
is not defined(old kernel) we do not need call 
kfd_process_destroy_delayed or remove mmu_notifier_call_srcu(&p->rcu, 
&kfd_process_destroy_delayed)  at kfd_process_notifier_release_internal. 
I think that make thing simpler for old kernel.

So it needs additional handling for old kernel on dkms branch. I do not 
know who port patch to dkms branch, or I should change that on dkms branch.

Regards

Xiaogang


> Regards,
>   Felix
>
>
>>
>> Regards
>>
>> Xiaogang
>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> index d07acf1b2f93..7c5471d7d743 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct 
>>>>>> task_struct *thread)
>>>>>> init_waitqueue_head(&process->wait_irq_drain);
>>>>>>       }
>>>>>>   out:
>>>>>> -    if (!IS_ERR(process))
>>>>>> -        kref_get(&process->ref);
>>>>>>       mutex_unlock(&kfd_processes_mutex);
>>>>>>       mmput(thread->mm);
>>>>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>>>>>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>>> +    if (p) {
>>>>>> +        kref_get(&p->ref);
>>>>>> +        return &p->mmu_notifier;
>>>>>> +    }
>>>>>> +    return ERR_PTR(-ESRCH);
>>>>>>   }
>>>>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
