Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E36E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 10:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B67E10E135;
	Fri, 20 Dec 2024 10:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q108cBSM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 818A910E135
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 10:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNYRsrElAH+fi4Pvbv9+3RnLjNsbSxJDxAbXkG0nEvd6l9YCkAMpQVjqOGtEUU5i/e2O/06okMf2B40I4IrVloZ2xgqO9i4AdBA+XSj+SGPfyXJe0bLnD+rMBouDL5sccflNKjz6BAQJ0J4qnl1i5lzQNoC10Zvn02PF567IZ1Z6X3wKNpD4e5PAQGw0gOGjSNHUIK9MI2iBvAk4+TGIGD+BLIXbNnCAGgKEGKSVWkLYklxI1JZ6/uGyGbC75ckw2BRUe8hSBN3fDeQ3BF4C1rpF4G0tNibogC5BZySRQG9nAMPPkkEvDM2L4UR+YS77NitT8fd19hJhx4IKMISdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iPMrL68x7E2P/pFm1lHnsk6P9i4KZpRSn+3sIGH8i4=;
 b=dJ4vZfaMrNaGFbjizZ+61kAIPUxYAEyj9KFJa4q1SEmuz6L7SjmfHft7DP0fbnJIQIr9DKxsoz2r5MDHx8uRL8ibVvWy8fJ0pvYbPfASutN/ZA4CuW+YtVNve8WN/EiXEc7AxPgrK8p2nGVjBQlY9jEBY9FYkJNt/PxU3n+IGPTtD5cTCkO1DHttN+lzeoeAOTgUE8xA17xkrDo67q0MTKBNS01Kmd7QVZo+ppafm5/A9/NxamNSq/7hc1i7ao/k+4adRCUesdXCh6Boskca+4KY+NoixK87MQRW9mD4owVi0Dy431SNrEWQauHIOjGD9ELFOQ62JEd25fJvD45HOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iPMrL68x7E2P/pFm1lHnsk6P9i4KZpRSn+3sIGH8i4=;
 b=Q108cBSM/qC8CkivbGwl65uxKrsCwN4R/yvwzoXiyIbVm+vM7BQiwJUrQf8Z68I0Lz6Nd8mUwH4PajHiHK8bqsjpMaBSHRAj6Tr+RV2m1xZ6mAQP+myhMpgEDHMEHxS2nt6U/9MmT86DrGdKpzOpZiafZD0AhaUN5tZo0epeKq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Fri, 20 Dec
 2024 10:38:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:38:14 +0000
Message-ID: <55e1d859-b614-442c-b0f8-92ed3f7cddf6@amd.com>
Date: Fri, 20 Dec 2024 11:38:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: Fix out-of-bounds issue in user fence
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
 <22a8d1c2-712c-4c16-a296-81fe342bdfde@amd.com>
 <b4acfc3c-5d91-4b94-8d7f-e653cebc5bbe@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b4acfc3c-5d91-4b94-8d7f-e653cebc5bbe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cba7ac-7fce-4132-f5ae-08dd20e26893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlFtM0YxWHBxTVlMQzF1MzBDejZjWkVXWUhERXNieXU0MHlEcDZIaElnQnk2?=
 =?utf-8?B?aWZsVldwalFZQm84cmpHVnNFSlRXZXJ5T1V4Rzd1bE1QSlZyYTNOU1QxMDBx?=
 =?utf-8?B?aWhlUXNTeEFDdXMwU0k4Rk9PLy9HMmRzVVMzL2UvWmYrd3UyanNFSXFEbXZ6?=
 =?utf-8?B?YlF1RWVlTHlXcGs2SHhsbWVIVUU4WXNrVDVGRWl6eXMyTzRMUURwMmV2NVdU?=
 =?utf-8?B?SmxMNko2VHN1OXBzaGZud3N0a0JZdVpzcHFoV3VUUzJaYWl4TTRHdk1oTEpz?=
 =?utf-8?B?YnpFU2dqeGZCMkpaYUJJbStGdjRxbEZ4T0crU2xsVXptV2xGaG5YSUwxNldq?=
 =?utf-8?B?UGswaFo5VlY5MEJiQnJRR3FaQW5iS0kyclJsUjlGR0tmNFdxMndiN2V5bjh0?=
 =?utf-8?B?K0FmK2h6TnNtdGNmeCtraVNETmNFVFBEd1Jvc2l3NEpDRVcwbEVvMklvbzJ4?=
 =?utf-8?B?L3dEZWxRQ0hLbXlHQ25SVEo1R1Vsd2VnUEh0emRDN0w4SkZxbGp2b25KWGFr?=
 =?utf-8?B?MXFWaWU0elB5c05GZ0daTWFhR1NkZXJmSTlWcVA1VjdSRjF3Nmk2ZVc2RzBv?=
 =?utf-8?B?WWpJM1hsTHN1RHpTZGw1enh4SFdTZ3dER0s0dHFOdlBMK1BlMExTemZwU2dS?=
 =?utf-8?B?blJJOXpyMXJ1RzZyTEU3N1Z2RnYzdkkvT0RRbGgybGJWaG9oeU5ZOGlTdnIv?=
 =?utf-8?B?L05ZZm9FM3BHWmJvd3llRnVmdE1aVVVRMDlPZU5Ebm8yUExwa0g4NEVoUU0x?=
 =?utf-8?B?S0xFL3hRK0FOdkNOTDNXVi9OQ094ZXVQaVlRczZEMWlvdFdXZWp0dXZsWUpL?=
 =?utf-8?B?a2l2SVFKcWZUNnFXNlNldG16TmJhclgvd2pRUjFyN2h1T3gzaWcrR2hDS1Yw?=
 =?utf-8?B?YVFwbGcvK2lBTWJXNVBycmRtem5jcVcweXlLSjlJdmZIbW1OdTFxZ2dYSWgx?=
 =?utf-8?B?QWhOemhjbjMzTEV1alpFSEVXUURWZC9tMndNQmlTK1NsRTJBeDNuQ3FqL2py?=
 =?utf-8?B?Qkt2S1BjcitYdWl3NEhCaHROZmdnclJqRTNqOTVna1BXSFRCYXovd0YydFFH?=
 =?utf-8?B?eWtOMlc1cGNLdDBpYmxjWDdPcFl6QWxCSG5BL0FualczOHBCOTRBamNlRGR2?=
 =?utf-8?B?MVlFTXBZMWJpVU5STW4wV3lXdkRNMVNldStqY3hISEp2djlGeDJrdTZteFFF?=
 =?utf-8?B?OXVKaGpSK1dJeUowemRrSW9XcTRERUZPQTlpSnpINmI2cVIvODNMY256Yy9h?=
 =?utf-8?B?WnRVWWxSN1ZiOEtyZWlMcXBWdFpHelFQcVFKWURtOXJBUlY0Rk94b1dkcThT?=
 =?utf-8?B?cXhBVmIwY0Rybk5PbXhObkMyMXlQNGtYS1UwektyMzRTdTRCZ0ZJNTdyT2dI?=
 =?utf-8?B?R2M0VXUyRElNUG9MKzlqRnI1V2h5OVl2Rk11d0FEblRzMjA0aVVEZDR4VHVQ?=
 =?utf-8?B?U0h3UzgrNWFjSmxBZHRHQXpaTVFDbXloTTFPQ3YyNnQ4OHI5bVVYUHB0RHQ1?=
 =?utf-8?B?YU9DcjdPTUdvZUdvNU50VmZMSFBkcVZQWTQrRVllMXUwM1AydG5CeElrZFZm?=
 =?utf-8?B?Rk52MExxYTE4MXBhM0dUOXNoMWE5K1dsSEdKRjUrc1ZpRkU5MHdQWXVMczZw?=
 =?utf-8?B?bnl5TFNKLzNoNWhMSWFPb0duVzZzeklITWtWOFFhY0VXTGdsdDNTWndqQ3hk?=
 =?utf-8?B?SCtSQ05Fa2UramNtMlEyVmlmMVZJOGJFTitYQVJ4Z2hSclVvNkMvaWhKWk9W?=
 =?utf-8?B?ZTgrK0pNMlczWjdSVVJDTDBDbVl6Ky9DNjREMkFraGRiaGlCU3Jjc0llR2U4?=
 =?utf-8?B?dG9UUlhIZXk4czZyNC9aU25pTUhJd1hRcnArM1FUR210aUdWU0w2aEI1VFpy?=
 =?utf-8?Q?H7y5twx9Eo3Go?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXFiUjZLSDhtdTlOenI4SEdKalJGdStxYktHYkZXWEF1aTJQT3lmM0lxREdi?=
 =?utf-8?B?Mm1NQ3VsOW1nMjgwRUx5OEZETHZEK2tyVmRNSGdEOFBhTU5LWjZEcTRkNCtR?=
 =?utf-8?B?d0dodUJMbmVMUEVZK3orRzl2MVBaemZyTjdFem50dUUyUVd5bjl2TUNvZklY?=
 =?utf-8?B?c2krcmpYbzFtMGY4L2ZvakF2NW1oSmVYd1BJYXcwVkhzcWZNRFFrMEM1c3R5?=
 =?utf-8?B?Mm5XN3Zsc0hyK002SVpxTzl6Z25YVFFwOUJ1VXZjaXZrYlRWNm5oMUphQ3VQ?=
 =?utf-8?B?ZXpwYU10eDM3aUw4RWVPWXlZclhLZWZ4UHU4ckVCZTlvT1d0VVZHUWdNSUlC?=
 =?utf-8?B?S1NRTTA5WUREdmc2bDFtbnhTemhENFFycUdSWGZIM0FFamJLZFdHa3g1UkNL?=
 =?utf-8?B?VldmSEI0ZHhMamhzWTUwbnF5TVROc1lORFBEYUhpYUt4Q2lrdTZOUkN4UnRr?=
 =?utf-8?B?QmVSWVZrWVFoUWU0cVhsQkxOajJ1eExJdkJ6KzE3cGkwQ2x5RVVUTFJWL1BJ?=
 =?utf-8?B?NnEvTmltckR5TzB0UFA3RWxhSTVQVnJyMmI5TkdlR2JnenBJdSs5LzVha2Vw?=
 =?utf-8?B?cDgybnFENExxTGdHd1RnSlRxSS84dHFvV05SeHB0ck1pRUJqSk0yak9lR1NL?=
 =?utf-8?B?WE9jQUNianZyb0Z4MzM0OVNiQXhWS3pwR3FyTVpXTkxXUGVKc3hKKzd3Z3dy?=
 =?utf-8?B?L0RNTFlTRlE5ejVSRnRjcmZzUCtBRFZYNEtlekxiZkkyd0JzTjVaR0dVWHhv?=
 =?utf-8?B?cVBsdkF1ZDZUVmRIUi9EdTIrWEF6NllKMUVEajRqWk44bVZ3TVhrQ0FiNU5U?=
 =?utf-8?B?RFlKRENGdzhLdEVSTmpuVm1FaitHV2JUbmh5V21sZ05ZR1Y4KzBZdDlydVBv?=
 =?utf-8?B?R0MzY3RDd1JBMHdENlNzb1RSTkdXdFRub2lyYkovOFFqaFF2TGEzL25oek5F?=
 =?utf-8?B?UmNWYjZhOGlLL0F3QzFaM3RrbmYwRlB3bW5NV0w5eThlUmNmZE1LTTlvcWdy?=
 =?utf-8?B?NDQvL0ZZZXpFa084bmxSN1JCUGVjOWhOS0ttemZrbnY1Q0NtQjMxT0piUDln?=
 =?utf-8?B?RDhuWHozMmJBUWMyWEJlYllXanMyMjNrbWFJbWhFWmRwd290N0FGdUxWTUZT?=
 =?utf-8?B?RytsdCt2ajdpOHRFOU9MRTk3Y1lHeDNFVHNPbFlpZWQrUlBCK3ZVSC9ueHVz?=
 =?utf-8?B?UVpwa1pHNFA3UmRFazkwYm8wZmRwOXp1d054eG13VGZxTC9nN3BvL09OT1RZ?=
 =?utf-8?B?VjJ6K3ZaMEk2OWlQVHRhSGFpZTd1VnNQTFlkNTlVMHZQWmZBZHIzcllOKzEz?=
 =?utf-8?B?SkFJRDFncEdILzJaRFRTNGlUMGl5ZE1lVUt4dTZQSkh1SHNseEhINnQrb04x?=
 =?utf-8?B?cWlEbVF6VzlXVFhNRVVaZFZPcmphU3Npb1Fsb2puK2pUN2taL0kvU0lwRTBq?=
 =?utf-8?B?ZjBWRkhtUUhYY3FVT3pkSzRnRXJsTzREYlovMFlsdU1GVGdFaC9NVEx2eW1Z?=
 =?utf-8?B?NTNnSkZEWEdtRTRzeTBDZmJ2dHgxZnZ0c0l1c2NnZ2ROSUMzdlNnTHdDbUhE?=
 =?utf-8?B?ck83RTVCa2NJTXVCRHBxcVBCWmUzUVJJT2RjVWxDRGxzTEtmWGZ0VElvcWxN?=
 =?utf-8?B?NE94UDY4aTloTVVtSkdvK0lVNDN4S29TSjJVMDg5ZDJqaXRUU0RaLzRBQUMx?=
 =?utf-8?B?NDhLSlZaY1ZiRS9icXFoSHFyREtDQzdTbzNRb0ErcUEzVFV3MFhTUituUzBo?=
 =?utf-8?B?UjdkWnJ5U0tlS0pqbzlpMU13UFlIZGVzOCtSVlY4TU9sc2Q0ZVJ0TlBMQW92?=
 =?utf-8?B?MVUvd2ZMUExCSjJScktiZzRCSTZwOXNER2xuQUplSXBaanRhSldiRkhCWkFF?=
 =?utf-8?B?SUpvejBUaVVFc2NRNHBjYXJuaTNUR2pjMWIwYjhseGM0MUREa0JOOFVWalNX?=
 =?utf-8?B?Y2krdUhyU2d3M1ZaR2tmU3FWZWdpWkVja1A1YWl3RS8wTjhhYkRvMSs4L1lj?=
 =?utf-8?B?NHRrS0g5MmI1endZSExESWgvSFNkT3RvcWZpYXhNUVM5cUZvZlFySXJiczkr?=
 =?utf-8?B?cEU1MFBCaFM3L3k2c0lYS2dnOUJmWTIybEJYVWd3d0hUdzF3OWJOTnI4dm5z?=
 =?utf-8?Q?UWm4zj5SHuGp8Y/iHOCxgEgfz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cba7ac-7fce-4132-f5ae-08dd20e26893
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:38:14.6949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifk7gEU+dlCxNDbSan6LCgAxPQvkTnt9MM0/yJH9IuWLkaB+uuA8i+AK95DFZqfE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
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

Hi Arun,

Am 20.12.24 um 11:34 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
>
> On 12/19/2024 4:11 PM, Christian König wrote:
>>
>>
>> Am 19.12.24 um 11:38 schrieb Arunpravin Paneer Selvam:
>>> Fix out-of-bounds issue in userq fence create when
>>> accessing the userq xa structure. Added a lock to
>>> protect the race condition.
>>>
>>> v2:(Christian)
>>>    - Acquire xa lock only for the xa_for_each blocks and
>>>      not for the kvmalloc_array() memory allocation part.
>>>
>>> v3:
>>>    - Replacing the kvmalloc_array() storage with xa_alloc()
>>>      solves the problem.
>>>
>>> BUG: KASAN: slab-out-of-bounds in 
>>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000006] Call Trace:
>>> [  +0.000005]  <TASK>
>>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>>> [  +0.000011]  print_report+0xc4/0x5e0
>>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000405]  kasan_report+0xdf/0x120
>>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>>> [  +0.000007]  do_syscall_64+0x4d/0x120
>>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 43 
>>> +++++++------------
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 +-
>>>   2 files changed, 17 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 2e7271362ace..4289bed6c1f7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -122,10 +122,11 @@ int amdgpu_userq_fence_driver_alloc(struct 
>>> amdgpu_device *adev,
>>>     void amdgpu_userq_fence_driver_process(struct 
>>> amdgpu_userq_fence_driver *fence_drv)
>>>   {
>>> +    struct amdgpu_userq_fence_driver *stored_fence_drv;
>>>       struct amdgpu_userq_fence *userq_fence, *tmp;
>>>       struct dma_fence *fence;
>>> +    unsigned long index;
>>>       u64 rptr;
>>> -    int i;
>>>         if (!fence_drv)
>>>           return;
>>> @@ -141,8 +142,8 @@ void amdgpu_userq_fence_driver_process(struct 
>>> amdgpu_userq_fence_driver *fence_d
>>>             dma_fence_signal(fence);
>>>   -        for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>>> - amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>> +        xa_for_each(&userq_fence->fence_drv_xa, index, 
>>> stored_fence_drv)
>>> +            amdgpu_userq_fence_driver_put(stored_fence_drv);
>>>             list_del(&userq_fence->link);
>>>           dma_fence_put(fence);
>>> @@ -221,34 +222,24 @@ int amdgpu_userq_fence_create(struct 
>>> amdgpu_usermode_queue *userq,
>>>       dma_fence_init(fence, &amdgpu_userq_fence_ops, 
>>> &userq_fence->lock,
>>>                  fence_drv->context, seq);
>>>   +    xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_ALLOC);
>>> +
>>>       amdgpu_userq_fence_driver_get(fence_drv);
>>>       dma_fence_get(fence);
>>>         if (!xa_empty(&userq->fence_drv_xa)) {
>>>           struct amdgpu_userq_fence_driver *stored_fence_drv;
>>> -        unsigned long index, count = 0;
>>> -        int i = 0;
>>> -
>>> -        xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>>> -            count++;
>>> -
>>> -        userq_fence->fence_drv_array =
>>> -            kvmalloc_array(count,
>>> -                       sizeof(struct amdgpu_userq_fence_driver *),
>>> -                       GFP_KERNEL);
>>> -
>>> -        if (userq_fence->fence_drv_array) {
>>> -            xa_for_each(&userq->fence_drv_xa, index, 
>>> stored_fence_drv) {
>>> -                userq_fence->fence_drv_array[i] = stored_fence_drv;
>>> -                xa_erase(&userq->fence_drv_xa, index);
>>> -                i++;
>>> -            }
>>> +        unsigned long index_uq;
>>> +        u32 index_uf;
>>> +        int err;
>>> +
>>> +        xa_for_each(&userq->fence_drv_xa, index_uq, 
>>> stored_fence_drv) {
>>> +            err = xa_alloc_irq(&userq_fence->fence_drv_xa, &index_uf,
>>> +                       stored_fence_drv, xa_limit_32b, GFP_KERNEL);
>>
>> That is even worse than what was discussed before. Now you have two 
>> XAs and the second is incorrectly using GFP_KERNEL.
>
> I think the problem here is, the WAIT IOCTL updates the 
> userq->fence_drv_xa entries between the 2 xa_for_each blocks
> exactly at kvmalloc_array memory allocation. Though, we are locking 
> the first and second xa_for_each blocks and having the
> GFP_ATOMIC in place didnt help to resolve the problem.

Yeah, I agree on the problem. But I don't understand why using 
GFP_ATOMIC didn't solved the issue.

>
> For example,
> kvmalloc_array() is allocating the memory for the count value(say 5) 
> and before we acquire the second
> xa_for_each block lock, the count modified to (say 7) by the WAIT 
> IOCTL xa_alloc() function (by acquiring the same lock),
> and we would be iterating for the new count. But the memory allocated 
> would be for 5 entries.
>
> xa_lock()
> first xa_for_each block to count the entries
> xa_unlock()

When you use GFP_ATOMIC you can drop this xa_unlock().

>
> kvmalloc_array allocates for count 5
>
> xa_lock()

And that xa_lock() and so make sure that the xa isn't modified in between.

Regards,
Christian.

> second xa_for_each block to move the entries to allocated memory
> here the count increased to 7
> xa_unlock
>
> Thanks,
> Arun.
>>
>> Regards,
>> Christian.
>>
>>> +            if (err)
>>> +                return err;
>>>           }
>>> -
>>> -        userq_fence->fence_drv_array_count = i;
>>> -    } else {
>>> -        userq_fence->fence_drv_array = NULL;
>>> -        userq_fence->fence_drv_array_count = 0;
>>> +        xa_destroy(&userq->fence_drv_xa);
>>>       }
>>>         /* Check if hardware has already processed the job */
>>> @@ -300,8 +291,6 @@ static void amdgpu_userq_fence_free(struct 
>>> rcu_head *rcu)
>>>         /* Release the fence driver reference */
>>>       amdgpu_userq_fence_driver_put(fence_drv);
>>> -
>>> -    kvfree(userq_fence->fence_drv_array);
>>>       kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> index f1a90840ac1f..3283e5573d10 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> @@ -37,9 +37,8 @@ struct amdgpu_userq_fence {
>>>        */
>>>       spinlock_t lock;
>>>       struct list_head link;
>>> -    unsigned long fence_drv_array_count;
>>> +    struct xarray fence_drv_xa;
>>>       struct amdgpu_userq_fence_driver *fence_drv;
>>> -    struct amdgpu_userq_fence_driver **fence_drv_array;
>>>   };
>>>     struct amdgpu_userq_fence_driver {
>>
>

