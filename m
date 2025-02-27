Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45635C19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D625310EB21;
	Thu, 27 Feb 2025 15:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tkb0cfc2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D6F10EB23
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm1jxRtVG/wfq7O5Wz6wuLm0BMvGVArNA3x2ThfUx+/OVVfrXUZ+TPhXxcidEF78yglrGmijJbFniwMMYIksTleVjxJ2qo5UinFXI+7BZi9v1cl5MT7tCzBocui5HbLA1YkB8dsv4i96Scdzz7z28B3we6cP+71cw4peMm11oUG/iHCwpqiVTjRVUWwP7BE6PY1YeZ4cBLKeWTQ5za2keuZSsQXjJvdz+df45HMwlUh65tOUZiooNBxgGlZ6t7y3N3kd92/VWwxinSLfqYtZdoGJ+mIeRAqaqaE4zJPRxjL2IvV1BumYpM3g1xqw3hvlgHivNqIspMDUXBVcNHHoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pivm7+O4i+0xouCZMZ/S68Zdk3mZY8EaGiXJOfXBvfg=;
 b=nNDmp66TjjS94CTecboJx4G0wLTd6pGfOhM2FnyYgEjqjGbFE8hgUNCHVCZDaPLTJMFO/RkUnai+o1W+X/dm3UE9DCmGwmDfIfHMEgcJ9Y5kP8vWxVDJazvMf62NVOrRN0/3SBLkkQVfuyfB9xMGpWAi4gqK131ic6y0jEGNiUiMpMwa6ZTG0SMBqaN2DQGXJozwQF87Df6l73Prb3iWlQ+/Ue0TPz3E95ppXO90XQAQqhLdJ0xY0JkFYTEXLpeJBODWm2L7H+cT9R7+UYm6J/15hekjf1v6zRnWBCNcWBS7xvk7lRASvmANL49j7N4oX44Xnuhx7heBllt8k2JwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pivm7+O4i+0xouCZMZ/S68Zdk3mZY8EaGiXJOfXBvfg=;
 b=Tkb0cfc2GljabRamOWV+1VQcKATo4wdO6mVlEHmcGZGWJwPFSXuThkphjciVhIlbsXnCbE9nrsU8PwQhDCeHiKoM5OOq+YWlr/uDm5X5fpwgr2hKmskfXZRImkZmz1wPRLWsuOT1QPdFN+Yg/ZWvwU2J8/sKtEO6+yUK/nnJPVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:08:56 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:08:55 +0000
Subject: Re: [PATCH v3] drm/amdgpu: fix the memleak caused by fence not
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>, shashank.sharma@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 sunil.khatri@amd.com, Le Ma <le.ma@amd.com>
References: <20250218145322.1500-1-Arvind.Yadav@amd.com>
 <b453f96c-ec53-48cc-9179-7dd70012c561@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <def5c837-f2bc-3667-fa18-b755c1392d35@amd.com>
Date: Thu, 27 Feb 2025 20:38:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <b453f96c-ec53-48cc-9179-7dd70012c561@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 56328fe6-808a-4e41-a14b-08dd5740a78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnpERkVtTWQxNzhtcU9xUC83RVM2NHprR1BRMUp4L3N4eGgxU1ZKeUU5OXkr?=
 =?utf-8?B?YXBEWjNhMzAxbGZkaHZ0YkFJNTFkdGRFcU91U1g4endPZVI2MndFdEEvVllE?=
 =?utf-8?B?VnZpTldmWkwydkY3enhkMjdyYmV1M1NsQ2dSWE1mYmZMQ1V5S3E1SjFEK0x6?=
 =?utf-8?B?TG5WWWxUR2ZpclJQNzEzbWRmYXdlZm13S2FNdHRJWWtFcXFmYjhFaXpEcmtm?=
 =?utf-8?B?QmdIVk1kTW03S1poRnVLU2xMd0xTd2JESkJLTDJwZVdqNWIyaDNuV0RaYk5p?=
 =?utf-8?B?a3c1Ukl6dU0yMm5aTnpqTWdCd2lFcUNkaUZ6cGVXSUcvM1phVDJIcWxVV3hZ?=
 =?utf-8?B?c0xNakdpSy84dEJ0elRkeTZva2k0VTZ2eExMTzdpSFE0elRsRXBpdTRTSnRK?=
 =?utf-8?B?ZVBvOCtUZEhZbDgzTEs5LzdsYy9nWkkzYTd3QVJ0S2dQN0Z1ZVZPQnhDVThO?=
 =?utf-8?B?K3c5ZStBYU5ENGdHTng5OS9teEFwVHV2cE1uSWdoNk9BNjNranRFMXQvVGpI?=
 =?utf-8?B?bU5PdUJhZU9NWXFIbjVwUTBaV2hGY0dmakhvSk1PcG41Z05hN2ZFWjViSHJq?=
 =?utf-8?B?d3dib2c0VVBtYUtVc1MrRGN6YkQwNmJCeFFJQWpuMThWa1g5Sld6U29nMjUr?=
 =?utf-8?B?VFpBU3hTS01QRUZob3dYQUtqUHhSSkp5SnBsU3QwdGlWb1dFVXo5QUhZUk9s?=
 =?utf-8?B?N0JQRExrNkxtYWZtVnN5VnBvQ2RHYkFCUUdGQnhMc1l2MGF2QUpUNVFvUVlh?=
 =?utf-8?B?NWduTVBnTDZwcEs5YW8zaXcwdDFVVElmaGE5RDJEdjFRV3ZqajJUc0hmbXNW?=
 =?utf-8?B?bkN4LzdEeE42Q3dCSVI0Vk9IcS9PeHZDQnJnMUtjVTBjQ0h2YXhZalZEZjBx?=
 =?utf-8?B?RFZ2VDAwQUhub0IxTzh1aW1KeHQ0T1pEU3RHMUpjY0xiWVBLQ1RwdllYVFZu?=
 =?utf-8?B?TDFRKzNqOGE0c1Z0RTRybjZmUElxRklZSDRNT0tFVHI5VjhDNjFlVmdtQ1hF?=
 =?utf-8?B?NVZkYW5aSWZOQ25TRTdFUTg4QWxlVDlrZkhVRTIxNUU4K0lBazE0d3lLL3Fr?=
 =?utf-8?B?aStrTkI0VDRlRlBRREtua1lxYnI3OENhUFlkb29hWjhobEdXUlludkxneFN3?=
 =?utf-8?B?R0xBa215dHhUZmozeEFWc1J0SXpUTlVsekg2R2dCdVpsYTBwQnhXZDltL1pa?=
 =?utf-8?B?UTZKaWI1cDVnQ01BN3hIMW5Dd1g0TzRRNGJ0WGo0T3l6a1pBOXdXcjJhNU9z?=
 =?utf-8?B?QmZwdmNPd1pmdmtodnhCeFBDZmJSY1d1cDJyWnk4dHA3ZXB5clFncWxvVHJL?=
 =?utf-8?B?UXQyK0laZnVxbm5oYVlDOVFJcmhrWXZpWCtpUmMvNWpzcThxaU9EZmxsQlg0?=
 =?utf-8?B?NSs0U2s0azV3MVcxYnNJVkdkbUYzS25tUWJRNkYvVm5EVEljVVpxdDRrVlNS?=
 =?utf-8?B?emMxRjFveW1EUjhJT0lrUFIvSUYvODNMOHQ3Z1R5MmE4Q2hVVjFUNjM3ajNQ?=
 =?utf-8?B?c25KQ2hYMEcrY0RBRmFScEE2Qi9udnRFY1YvbE9pY3RWeHEvN1c5MGZFNlhO?=
 =?utf-8?B?bSs0cXo2M25tdzczdVFjRmdvdURmdWNqaXU4QTFiTzQzaUZTOWNEbkpWeGRN?=
 =?utf-8?B?d3kvd2xLeURZbVhxZWJMbnNOVDdqcXRtVHVvODA4dDJwQmcwUG03d1czTGN2?=
 =?utf-8?B?UkE1aTBIRTFjc0RaVldtUThEOUM2bE8yQUxaY2NZRWJsSXp3QXFWRi9MZXJ2?=
 =?utf-8?B?ZUJieFo0NU9iT3hOMGk3Sy8rYVFybHZZYWVENTl6Vy96ekRkekZ5c2FxdEFO?=
 =?utf-8?B?SytFd3AvNjZYVE1KeFBTUW5KMW1yejJDcVArVTZLa0hHd1NKRDZmVDZmSWd6?=
 =?utf-8?Q?iZ0mE4tEqVBgq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBheG12aFhUdklpUEJYOW5KeFdPV2owSG54c0V5QVJGaFZUNnc3V3Y0YnNh?=
 =?utf-8?B?cjB4dit3c1pNQXkxM1FId3ZEU2k4ZXVGeXJRUG9NalBzSEViQW9XalM3OXBv?=
 =?utf-8?B?QnRLZytFUGNudTd1UVZpUWFTaGswYk0yWDhvWEoyeTM2YmM5TGZMUTBtc2Fr?=
 =?utf-8?B?Wit5RWVSelU2bTNpWmEwaXlxb0psTzgvQk9qeWh2S29hMnlnUjVaQWV3ZkZz?=
 =?utf-8?B?U1FTMW9qUE5BNnVmekFlUEpSV0p0UUNPQnNGSnVaWUdWbWZPSEQxb3JLbnc0?=
 =?utf-8?B?S3pjdGd5aVQwRHpacnJmSXN5KzIwUnRidjhmZXhoTjJiYWhxeUV3dnlaN0Iv?=
 =?utf-8?B?RVNXeFFKY0tEOUs2Y3duSjhLVlFndlJMclhnanNXWDl1R2dwSDEyTzlCaFl5?=
 =?utf-8?B?a2VSOG5kU1EwQ2prb1ErQnpEcTIwdVArbWlGUG96aFAwY1kra3F6bTg1RFl1?=
 =?utf-8?B?Nmk2bkNQQU9tVXh6MWpZWWN6NEI2ZENtd0QxTGtSbFJsRnpWeXp2amFYSGpZ?=
 =?utf-8?B?R0szTHRYVE50MFpCNW9uajk1MHp0WStaR04wamJmUW9BalRNcldyb0o3MnFG?=
 =?utf-8?B?L3NveHhIM0lIb2E5cFk3eUhRZFRmMXJwc2xES1pmbEJLaG84V3hxRmJCV0pl?=
 =?utf-8?B?Wk4yeWt5K3BkQ1RDeXQ0blVqVjhQZ25lOGV3UkJ5OW5iVU1wekp4emE0dVdN?=
 =?utf-8?B?TmZjdU50TDlWa0NLeXJRd3NyQXo1eGQ4SVhwM1ladC95aFBZRUJjTUg5MlNT?=
 =?utf-8?B?Vm5zL0F1VThtMEhhMytyNWtnQ3VHVW96Umt6dW5TenZKWTVtcXBtaXJvSVdv?=
 =?utf-8?B?eFBZU01pb0Nqa3NaV0JYa2VMTFVjaWkrdUlSTGlCbm9ZYnpRcXBKSlBFaWx0?=
 =?utf-8?B?bmU2Umhwem5IWnlpN0RIZGtOaFh3S2FmWWgxOWVnRWdjcWt1MFI5Tm5uM2JT?=
 =?utf-8?B?YzNEMGp0TTNTUHhBWmJoZm9nZGVia2NGM2VvNnhMODVBWlA3dXhnbFIzZ3BV?=
 =?utf-8?B?azI0MjhwUXdMM3NlU0Vma2RZbml4LzIyM2RlbWsvQ2c0bG5YVm5Mc3h2QU1W?=
 =?utf-8?B?ZE1Cd01YRnVJcFlLZm9yUXdrM1BuRnZwUXFHVm03T05IZTdkbnh2MXUrU0xK?=
 =?utf-8?B?L09pRUlVZFNHNXhhdHg1N1FhWml6bkNoTklGdWlPZ2F1OThCNnU2QUFBM3Y5?=
 =?utf-8?B?enB6YmdaWEpqcTE0cG1NTmY2SVdsSXRPcnI0eitONHp5QmlabWp2RkxtaXFk?=
 =?utf-8?B?LzdDQml3eG5VOUNHN2F6NXlaL3FJcGhQaHpGV1ZXZkpQN01nQW5KUEI3TSsr?=
 =?utf-8?B?eFExM01Kb0VzK0tvQjQ1Um4vdjB0RTVpU1JTcFZ3M3FoRGxlRTZZTkZWSFYy?=
 =?utf-8?B?WWRZRmY5dHhreFdtOHYwbHlsWkgrRHVkeE52YVBleDlCWEhsZkwvU3dzaTZt?=
 =?utf-8?B?V1liVkFFNTVFQU1ZaG1PVmFwWFZpeWZ2VmVWdXRMR3dTdzBZR0FIYTRQZnZM?=
 =?utf-8?B?TENqQlYzRlV2cDA4eWJvRnc3NXdPNmV1a01kRjBIL0doWWsrc3BicGZqaXBD?=
 =?utf-8?B?V2tDSkJZSExmNS9qQWtQbWJsVzl3ZzJlVm4zMWNlVWh6T3BtcWljRXIrcFBa?=
 =?utf-8?B?aWIyR0J1VzlJZGxtQzl4bUVJenZVMkE5ZU0wSmx5NHVIQmIxZG5nd2wzWFRH?=
 =?utf-8?B?aTBIbWIrMHY1dkhKWGZ5SmU2ZEM1M2ltUzZiOWVlc2VmcHFkR1hSTUxqV1c4?=
 =?utf-8?B?NFFvUEpyRGFPUFh6UHRkWWNNWlJMdUh6Z2tWR1JFT1ZJV01UaVF1NXNXRHgw?=
 =?utf-8?B?MzI4VThHV28rckZmK1Jub1BObGs1MmFpek5WQk1TT1hJOEhQdzhXbFpFaEJn?=
 =?utf-8?B?TnUwSDJsbVExNnpraUJOb09WWDU5dms3eWFQQW9sNmlUL0hUWVAzTk83TW1R?=
 =?utf-8?B?MVE5U1NySW9xRFFmNG9pQ1dwZ2Z1YlNFRktNRjBZZ1ZZaWMwaUlyZWxxZmlz?=
 =?utf-8?B?UU1zYXllSUZCUkE3VmV5ZkJ6UkE4M0huakRuYm1GeUE1Qlc3dGx5Y04zZFBH?=
 =?utf-8?B?UzFlclRNdUJJZndFT1RmV0p5YlBaanZlbTg0dGdsdUVkLy9UNjhtclBCSzVE?=
 =?utf-8?Q?g/QL0jRiTySvPheGckySlDesS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56328fe6-808a-4e41-a14b-08dd5740a78c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:08:55.8343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJE1mwhYl/eArhuWnsrUCfx5K5QnJ7FZU0NQtwEWMgB2qF69gidvsbwZLeTyZqblLlBpZb6QHU0LrgpUDorxzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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


On 2/27/2025 7:55 PM, Christian König wrote:
>
> Am 18.02.25 um 15:53 schrieb Arvind Yadav:
>> Encountering a taint issue during the unloading of gpu_sched
>> due to the fence not being released/put. In this context,
>> amdgpu_vm_clear_freed is responsible for creating a job to
>> update the page table (PT). It allocates kmem_cache for
>> drm_sched_fence and returns the finished fence associated
>> with job->base.s_fence. In case of Usermode queue this finished
>> fence is added to the timeline sync object through
>> amdgpu_gem_update_bo_mapping, which is utilized by user
>> space to ensure the completion of the PT update.
>>
>> [  508.900587] =============================================================================
>> [  508.900605] BUG drm_sched_fence (Tainted: G                 N): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>> [  508.900617] -----------------------------------------------------------------------------
>>
>> [  508.900627] Slab 0xffffe0cc04548780 objects=32 used=2 fp=0xffff8ea81521f000 flags=0x17ffffc0000240(workingset|head|node=0|zone=2|lastcpupid=0x1fffff)
>> [  508.900645] CPU: 3 UID: 0 PID: 2337 Comm: rmmod Tainted: G                 N 6.12.0+ #1
>> [  508.900651] Tainted: [N]=TEST
>> [  508.900653] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F34 06/10/2021
>> [  508.900656] Call Trace:
>> [  508.900659]  <TASK>
>> [  508.900665]  dump_stack_lvl+0x70/0x90
>> [  508.900674]  dump_stack+0x14/0x20
>> [  508.900678]  slab_err+0xcb/0x110
>> [  508.900687]  ? srso_return_thunk+0x5/0x5f
>> [  508.900692]  ? try_to_grab_pending+0xd3/0x1d0
>> [  508.900697]  ? srso_return_thunk+0x5/0x5f
>> [  508.900701]  ? mutex_lock+0x17/0x50
>> [  508.900708]  __kmem_cache_shutdown+0x144/0x2d0
>> [  508.900713]  ? flush_rcu_work+0x50/0x60
>> [  508.900719]  kmem_cache_destroy+0x46/0x1f0
>> [  508.900728]  drm_sched_fence_slab_fini+0x19/0x970 [gpu_sched]
>> [  508.900736]  __do_sys_delete_module.constprop.0+0x184/0x320
>> [  508.900744]  ? srso_return_thunk+0x5/0x5f
>> [  508.900747]  ? debug_smp_processor_id+0x1b/0x30
>> [  508.900754]  __x64_sys_delete_module+0x16/0x20
>> [  508.900758]  x64_sys_call+0xdf/0x20d0
>> [  508.900763]  do_syscall_64+0x51/0x120
>> [  508.900769]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>> v3: Addressed review comments from Christian.
>>      - calling amdgpu_gem_update_timeline_node before switch.
>>      - puting a dma_fence in case of error or !timeline_syncobj.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>> Signed-off-by: Le Ma <le.ma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 33 +++++++++++++------------
>>   1 file changed, 17 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 8b67aae6c2fe..40522b4f331b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -125,9 +125,6 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
>>   	struct amdgpu_vm *vm = &fpriv->vm;
>>   	struct dma_fence *last_update;
>>   
>> -	if (!syncobj)
>> -		return;
>> -
>>   	/* Find the last update fence */
>>   	switch (operation) {
>>   	case AMDGPU_VA_OP_MAP:
>> @@ -839,6 +836,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   	struct drm_exec exec;
>>   	uint64_t va_flags;
>>   	uint64_t vm_size;
>> +	int syncobj_status;
>>   	int r = 0;
>>   
>>   	if (args->va_address < AMDGPU_VA_RESERVED_BOTTOM) {
>> @@ -931,6 +929,12 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   		bo_va = NULL;
>>   	}
>>   
>> +	syncobj_status = amdgpu_gem_update_timeline_node(filp,
>> +					args->vm_timeline_syncobj_out,
>> +					args->vm_timeline_point,
>> +					&timeline_syncobj,
>> +					&timeline_chain);
>> +
> You don't need syncobj_status here, just assign the return value to r and abort if we can't find any syncobj.

I have not used variable 'r' because below inside 
switch(args->operation) the 'r' value will be reinitialized and the 
return value of amdgpu_gem_update_timeline_node will not be used. Here, 
we cannot abort because syncobj will be NULL for Non-UQ.
we can use r but it will not do anything. :)


>
>>   	switch (args->operation) {
>>   	case AMDGPU_VA_OP_MAP:
>>   		va_flags = amdgpu_gem_va_map_flags(adev, args->flags);
>> @@ -957,22 +961,19 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>   		break;
>>   	}
>>   	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
>> -
>> -		r = amdgpu_gem_update_timeline_node(filp,
>> -						    args->vm_timeline_syncobj_out,
>> -						    args->vm_timeline_point,
>> -						    &timeline_syncobj,
>> -						    &timeline_chain);
>> -
>>   		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>>   						args->operation);
>>   
>> -		if (!r)
>> -			amdgpu_gem_update_bo_mapping(filp, bo_va,
>> -						     args->operation,
>> -						     args->vm_timeline_point,
>> -						     fence, timeline_syncobj,
>> -						     timeline_chain);
>> +		if (syncobj_status || !timeline_syncobj) {
>> +			dma_fence_put(fence);
>> +			goto error;
>> +		}
> That should probably be something like this:
>
> if (timeline_syncobj)
>      amdgpu_gem_update_bo_mapping(..);
> else
>      dma_fence_put(fence);
Noted....

Thanks,
Arvind
>
> Regards,
> Christian.
>
>> +
>> +		amdgpu_gem_update_bo_mapping(filp, bo_va,
>> +					     args->operation,
>> +					     args->vm_timeline_point,
>> +					     fence, timeline_syncobj,
>> +					     timeline_chain);
>>   	}
>>   
>>   error:
