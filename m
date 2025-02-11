Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C95FC0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 10:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9CB910E46C;
	Tue, 11 Feb 2025 10:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m8Toefk1";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 614A210E46C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 10:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6gGf0s1qd9I5CKCnEKOqBBxI13gvhMK57X1uT88di7/Fz1XEspUZYkmU5ovtAuikcxOnh2R5B7Y/CNJ0zFHaFMfSP/Ww6Z1vUFkmuJ/CxngtLg/qfaUG+QC1sElXYUYNyVnkdAYyS0phhoKmhFSmSRdh3wjVQxmdNmquW/i54McPaJHx9/2J+sNnurAW/dwdJTxsE7XoEOjW3+CQQ032gjXwWtjaETi57HHpMuF7KxrfZmHscud8TX9+uM847CBvGbHelOCzr12ltt7xUVNmcpqUo/QFrz+GBNM626gQgz+IrFMFcToYRN/NQ32Hl6b70T/DuCiHolR7+Lgy/dIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAETWf169L4s6SQBp/3L9k9N7GYmc6Utk6zqplvGZLg=;
 b=MC4tVJwgDaUeOGcTMsFGCRHkWfezZ4JF/5o0R6MNxLY+KwXH2S/ieXUDtzEF6YAeSY9pGydsfc8OlGsXS4Nypbk4BFChdf5ArcghuEUPwNJa3S6+5JkEXYJzfUT4Am8LlsqKCl6ede5HXWRcvEeVRttOMoUBaQgB8jD1XUb16uxl3nljWLQ9ud4/ikv4s9AVzj4YCqkgu7enbdVGfgghWCBgGAltXTYfeNCRbtWTkHj5vZVvxWmAbLhgCrVcDQ2ESAi6rgMS0+X4xX0mXp+sCgufoh1cEp7yYNEOa2s93OI7inOn7PwI7UJb3M4In9vo+jOw9TrgdSybaZlkoHD+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAETWf169L4s6SQBp/3L9k9N7GYmc6Utk6zqplvGZLg=;
 b=m8Toefk1KkIFmYbynEoEP/iPXAKC2+U2kQZtx4ggH9aQDWieG/lraHEui7gos/TkD4mf8isJ2+eS/F9BZlNOBM2Cwv1eETd1M61VcFUQ54xs07+jUD3PIGwpaPJvJTeB0+iVuzCcssU1Yw0BgxMloHXj7iR81GMurGJUi4+aKDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Tue, 11 Feb
 2025 10:21:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 10:21:33 +0000
Message-ID: <e0a3e8de-2e90-420d-86c1-844f86ebe319@amd.com>
Date: Tue, 11 Feb 2025 11:21:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: Pop jobs from the queue more robustly
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206164031.43413-1-tvrtko.ursulin@igalia.com>
 <20250206164031.43413-3-tvrtko.ursulin@igalia.com>
 <949a5a2f-dbf3-497e-a50a-92adb48aa31f@amd.com>
 <3f6de080ac75fc0988d371e71072cba5d60e269e.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3f6de080ac75fc0988d371e71072cba5d60e269e.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 36eed8cf-b926-4b7c-29bc-08dd4a85db8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlpzbDBtQklYT2ZXQnlVY3dyUzN4ZUh6ZHhUSDl3aVZvOXFDRkgxdVhLNUtN?=
 =?utf-8?B?UWs2NHNCQmk5RTN2cVlCOW13K3RSOE9ZN29YWlZDK1Rqa3VEOVBWUTRqQncr?=
 =?utf-8?B?MVVpNy9kRVVxYlZJc2htaExxU3dKVjdrY2J1eWUvOVVtWFVETWpvYnorM2l4?=
 =?utf-8?B?VWtheSt4NnlSVHE0RWI1bUZRZmtkeTl6djdDOFVFT2pyMnZUeFcwTjREandB?=
 =?utf-8?B?RHJYM014Uk82Qm82SE42cktlc3dORG1RamdVUTluV0VoTEZYQ1ZpOUlnSDkx?=
 =?utf-8?B?WHF4NWlackpXUndaLzRyRjBNeHpLTE50ZUlkUUNPUXJhTXhZOFZvR3lZZU1m?=
 =?utf-8?B?MFRybXdoUkoranVoK1JGbU5MSU0zVmYxM24yaFp3Y3ZRMEtwQmkrSDBtNmht?=
 =?utf-8?B?MEdNRjFSbVRQMkJUdUZwWDE1ZDBYelFKdEdDME5ySjhzMnVXSVQxY0l2b29H?=
 =?utf-8?B?ck1LcHZCOGpoWTZrZGZiY09HVCtnaVJWRFd1SHpmZGs5cTBLaDJ2UEI2RGZM?=
 =?utf-8?B?c2NvUFRWZ1VGYXR1TDdmNWRxU2YxdFNSeldHbEtrZnVFS2hyZk51YmJ1Si83?=
 =?utf-8?B?Q3Uzd0hjc2Y4cm5DbFdjaVkreWNMcVMzaXVPUEN2YWtRcXlUdC9pVUlsZlM1?=
 =?utf-8?B?MlJZVHozWFZwWk9jUXFFeDYyZkpEQzNrVEtaVzZxamtXRzVIQ1lIR2lrbTV6?=
 =?utf-8?B?elNqellCVThUbG51UmFQd3hpKzNORzF1OHFHZStpRE16bHgvVG1FbkE5WWQy?=
 =?utf-8?B?UjQwd3h3NDZFYmczVSt5N1RTVjRQWEZZMlVYUnU3WTFrNytKc1kxTG1USGEr?=
 =?utf-8?B?T01sVkg3N3IzQnVIa0luUXF2Wk9WRHZ1SXFFTTdOcFRpWGJyRXJrcU0ydit4?=
 =?utf-8?B?dUc2YjVTeG9SMlNNblNVWmlxcU1hWGl5NjJTdEdVOXNxcmluRVIzRElzVXh0?=
 =?utf-8?B?R2c5ODBYeFNFcEtBdU55dzVTRGE5MmtGdWk3VnZOK2xDU1dWNTRRajNDTS9L?=
 =?utf-8?B?b2JSUGNDa2ZhTWxOYVdQbHM0SU5WSzRINnhiMTdNYjRjUGY3UjF6S1J3NnRQ?=
 =?utf-8?B?T0VEa1NTREMxVy9OSzZsd2VOOVdnNytIUGtVMDF4SjY0aFZPUHBoUDBDaUhK?=
 =?utf-8?B?TXk1eWEreThiM05uRldHdllPR0FVU2hUTVdFMHBpWnNtaUhKNnlyM0c2aEF1?=
 =?utf-8?B?RXhQTUkxK3krVWhacDFaWmQ4a2x0SmlBOHdPWUFIRnFiZTFMZjhvRFJtUGF5?=
 =?utf-8?B?aldXRUNrODFrUVpWRk5jUTdwWFZoaEpkVWJ0bWU4MytadHZQbU1UQ1NsWWdN?=
 =?utf-8?B?QmJHMHFvQ0VEOFQwWHRpckNuTXcwbWhjZFVyQlV1cDF2UGtLU2ptSXpNaVI4?=
 =?utf-8?B?YjRRMklrK3ZRQTdnbW4zajU3bk1WMnFLbWhyd2dubUJndjNQTE1wVEF1THRy?=
 =?utf-8?B?RVBLZEVjeFBKR2ZhOTFFS3R1cVBsbkQwekR6ZnkvSFU5dzd5YnFZcW5yODdh?=
 =?utf-8?B?dUZYQmkrZVBpL1pWTXhKNi9PcU5BQXNuU1hUbjNDektmNlVxQzhJTWlsSU83?=
 =?utf-8?B?ZVpJM2VMVC9GSmxPM1hCK0Q2VER2TUlnS3ZsbWp1V042YW93SUFSQjFzQzlX?=
 =?utf-8?B?NWJ1bUQ1T2FQWXNJbHhiQStmTXQ2N05MUzlCeEpxeFdCWjcwK1NNZUtmd2I4?=
 =?utf-8?B?Z3JUbzk3RUcxc3g5MWVqTjlJR2MwYm1CQ29aaU9Icll5dWFsem1SZEVzQVZa?=
 =?utf-8?B?NXducHlxaTY5TkZtbVBLcHJwd1JsdGt6azJVbUFnVlNaSm5sZDVoNkZnYmQx?=
 =?utf-8?B?eGt1UW03M2ZFcE95ZFZWV3NjSktCM3JGWlpBSVl6VldQaXJVZ0NYU0tUNjNl?=
 =?utf-8?Q?0EtY+MG6lQk7p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhqcnZHVWZDeURJLzI3OXQ1U0tTQU9KNk1Renp5NktJTEpuQzNFSTAwbzRS?=
 =?utf-8?B?eCsxUHFyNFJNR3lHeWdPVU4vdFJMV2JNSnZBM2hHOFFhMnVXb0Z1Vk1rbVZB?=
 =?utf-8?B?VEc4NXJaUEI1WUhqdDdHU2M5LzVQNEx3K2tDWDFEQ3JZdm5mS0FPOEJyUEMw?=
 =?utf-8?B?ams3QUlYcE9mN245dnNsL21NdUVYZFlkZk1qeVltdDBTWHlENkRYREpNVUJs?=
 =?utf-8?B?Vm9RaUVBOXlCTmxrc0hVRHlMTTlZKzQvdUk4cmQzSGJtV1ZXUWRwZEEyTHhu?=
 =?utf-8?B?dCtGTElsdVJ2Qi9mYmxVYVJPYTB6ZkxyMDZkRXBwNU1qaDV0WStGeTNzR2t5?=
 =?utf-8?B?TkNLVVYvdHUweFZxMWUrSVNqc1VvWGhxamNXZUptbm95RnJlSTVNMmI4N1Iy?=
 =?utf-8?B?OGVmUUJJd1kzT1NTSHFaWHU0MWJWY1EvVmRiWERZT3FLdmZBelFTN3ZuTXBt?=
 =?utf-8?B?WUpoekYyVlZUYXJEbytlWS95RVhlOUd2OEk2L3g1WGcyemlCbzZURTUzOTIv?=
 =?utf-8?B?emFmLzVjTDVnTG05RU4rekgrRVYzNjZ1MFpRTkZTK2lmYndXbGdkODYrdFlh?=
 =?utf-8?B?R2paZnNrWWdtdG1FNjljY0FSR3hXd2pFSWlVZHJvMzdLRUYzMHoxbkpuQ1NW?=
 =?utf-8?B?bGVaQmZCT0EzV2NJSEQwWGovci9oOG5jejRPU0pkdHkxL0N2WE92aUU2OStO?=
 =?utf-8?B?d2NqbElWdmR4SFZDZUxsVlpjN3A0dUpyeXRHT2ZJL3B0dzdQOE1VRGNHVzR0?=
 =?utf-8?B?eFFkN2ZURGNCRDUvMnRHdWpiZFEyK0VSYlUxSTBPRk9wb0xIVlIyQUttdG9Z?=
 =?utf-8?B?QVE2SkVzcVBUUlpsdWkrVmhua1drOXNUdFd0cklSNjJkcUhNWnBEa3dHNEp4?=
 =?utf-8?B?Y3hXdklrcWZpTStuNm83NXZPOXdsejE2ZGZicGJBeFRDQzRmRHpvdGxzR0tT?=
 =?utf-8?B?L1lZRG1xa1lpYld3WHlwVmo2WjVZc1d1L3B1WGRXbFZoMmszMEtrdFRON2Ev?=
 =?utf-8?B?N1FwUUMrbzdhR0cwS0Uzb0hhSVV4QkFEZGRHcE9RMnpWUkZjbmVoTXYybU4y?=
 =?utf-8?B?OFZwcHExR3NOUDFhRjkwOENMODNZRkp6WkY5cCtIZ3BMNTUzTFFEOE9nOGto?=
 =?utf-8?B?blJ3QmE5RUkrUzYwQVJsQ0k4ejlScmFRS2RjZGVvdU01bEMyZ1hBMkx6Sndw?=
 =?utf-8?B?dDc2TXZDdnVZTm5XVzRiV2N5VjYrZDlPcHNmMU5IWS9IbitUUWZsQ01DNStG?=
 =?utf-8?B?NUxORUhCZklJcU0zRXJmRDZpU1NXM0VEZVdXYlJGekdLeFZFclhVdWhZUlNs?=
 =?utf-8?B?VGZFdVBRSklJWEkzNmgycHpVYjJNeXFPRmw0aGxuZ29vRG44QXBmb2hjYzZL?=
 =?utf-8?B?NFdaQ2dyR3MxMitKMFZaZ2luZTZmVkZyd0c0bTdGR0h2TnlldlhFRTNvMVBX?=
 =?utf-8?B?MW5TU2ZUeHFmY0FsNWYrQjZ3NisrTER1UnJSYXZVU0pDSklwQ0MzcStuT1dL?=
 =?utf-8?B?MFUyK1o2K3l5VFFXaXhCSXdhMFpuSVZnQk1BRTFzUXBIbUY5bFZ6WkEwK041?=
 =?utf-8?B?ekdoWllZV3RPeDNLSmdSRzBkYWNEVWljQk9SUkRURUpwZXVBRWxRaTVsWjhM?=
 =?utf-8?B?VzhaTDEvOGI1NzBjVG1kL29BUlFmU1dTZ2E2YWRTUzNFRDI2L2xaNytCVzdm?=
 =?utf-8?B?alJOZnMrSFFEYkpFVy9PRStSNXhYaTB4L2FkM1duOUZtblJBYmVjcjBxbWRP?=
 =?utf-8?B?Wi9JUW5teEszZGZhZVNPYXFXY3A1K3U1eVd2UUZYM0s0M3BOZTRFMkJVbEVK?=
 =?utf-8?B?cGZ6eDBVRzd4MEhRZVQyTUdQY3ZUQ2o5NVZDU1NqdVFLb2M4Tit6OVpZdGpu?=
 =?utf-8?B?T1dwQ1JpNVJGelhXL290d1l6MThYU1pIc0pDeDJ5U3o5UzUwdENzRm1VRFpX?=
 =?utf-8?B?T1cyV29acndtaHh6M09EOFNVV1JiUEZlT0NaRC9kY0JKcml4MDZYNC8vcjVn?=
 =?utf-8?B?MTQ3eWYzdDQyenhvdVNJK0tzTDZtT21KK0FiVXFvb2V3K3BmeGtzdFJKeitW?=
 =?utf-8?B?Y3pPUU9FbFFuYkdsVzVtZ1JIWnVDNTd0Z2JZTytESDQveHZ1QS95Z1ZMMk1w?=
 =?utf-8?Q?7Gl53Fg0ws/8Df3UXau6zyorb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36eed8cf-b926-4b7c-29bc-08dd4a85db8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:21:33.2469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvIa+Nu/Le7+1XTIjW4jy01Bqig0bS06gY/K/CbTnvn6E3j7feHDZ0XRgatfmdDZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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

Am 11.02.25 um 11:08 schrieb Philipp Stanner:
> On Tue, 2025-02-11 at 09:22 +0100, Christian König wrote:
>> Am 06.02.25 um 17:40 schrieb Tvrtko Ursulin:
>>> Replace a copy of DRM scheduler's to_drm_sched_job with a copy of a
>>> newly
>>> added __drm_sched_entity_queue_pop.
>>>
>>> This allows breaking the hidden dependency that queue_node has to
>>> be the
>>> first element in struct drm_sched_job.
>>>
>>> A comment is also added with a reference to the mailing list
>>> discussion
>>> explaining the copied helper will be removed when the whole broken
>>> amdgpu_job_stop_all_jobs_on_sched is removed.
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: Philipp Stanner <phasta@kernel.org>
>>> Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> I think this v3 has been supplanted by a v4 by now.

I've seen the larger v4 series as well, but at least that patch here 
looks identical on first glance. So my rb still counts.

Christian.

>
> @Tvrtko: btw, do you create patches with
> git format-patch -v4 ?
>
> That way the v4 label will be included in all patch titles, too, not
> just the cover letter. That makes searching etc. easier in large
> inboxes
>
> P.
>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 22 +++++++++++++++++++-
>>> --
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 100f04475943..22cb48bab24d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -411,8 +411,24 @@ static struct dma_fence *amdgpu_job_run(struct
>>> drm_sched_job *sched_job)
>>>    	return fence;
>>>    }
>>>    
>>> -#define to_drm_sched_job(sched_job)		\
>>> -		container_of((sched_job), struct drm_sched_job,
>>> queue_node)
>>> +/*
>>> + * This is a duplicate function from DRM scheduler
>>> sched_internal.h.
>>> + * Plan is to remove it when amdgpu_job_stop_all_jobs_on_sched is
>>> removed, due
>>> + * latter being incorrect and racy.
>>> + *
>>> + * See
>>> https://lore.kernel.org/amd-gfx/44edde63-7181-44fb-a4f7-94e50514f539@amd.com/
>>> + */
>>> +static struct drm_sched_job *
>>> +__drm_sched_entity_queue_pop(struct drm_sched_entity *entity)
>>> +{
>>> +	struct spsc_node *node;
>>> +
>>> +	node = spsc_queue_pop(&entity->job_queue);
>>> +	if (!node)
>>> +		return NULL;
>>> +
>>> +	return container_of(node, struct drm_sched_job,
>>> queue_node);
>>> +}
>>>    
>>>    void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
>>> *sched)
>>>    {
>>> @@ -425,7 +441,7 @@ void amdgpu_job_stop_all_jobs_on_sched(struct
>>> drm_gpu_scheduler *sched)
>>>    		struct drm_sched_rq *rq = sched->sched_rq[i];
>>>    		spin_lock(&rq->lock);
>>>    		list_for_each_entry(s_entity, &rq->entities, list)
>>> {
>>> -			while ((s_job =
>>> to_drm_sched_job(spsc_queue_pop(&s_entity->job_queue)))) {
>>> +			while ((s_job =
>>> __drm_sched_entity_queue_pop(s_entity))) {
>>>    				struct drm_sched_fence *s_fence =
>>> s_job->s_fence;
>>>    
>>>    				dma_fence_signal(&s_fence-
>>>> scheduled);

