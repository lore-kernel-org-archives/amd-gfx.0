Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB80606A653
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2P9ouMXd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B170112595;
	Thu, 19 Nov 2026 15:40:37 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2226112595
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 15:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ys0jSKIi0EZTJqwMze8lCR/duAfQ4xVQoeOZOema/U/T2ufipLyTh4xo0PIqqLi0AAvP2vyXBgmq5wlii10zit3JLfN/YuIi7ubj7EfyM5+kTYNcRbjE57M2px7MuKlIw4UPGdAHg3xykznorVNcInLWInTp0YUwmt9HcQ1WAnfFjz3du0BxLEWnl787vS4p3UAjAlLif0TJHmcfWuAMKLVYtMzCN1oU9PgtcS4awygIWW4uHubaZmO84pzqsqSFaxsn9RtcfncnExzSJSpE2RJIQWLs8/bnivk0JqnRPSO00fHT5no2UGpR0RZlk5n57NkaUiOpRp0OIm5WCYSc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie7G0yuQJgn6bzrqSkoFtDn67tyqMBYcNic5Ypx8wMQ=;
 b=EBrot3vHY5awddvLEFxjsN86NfyNO6aN0EUyOrP7L9luJ+a8DLzbrDPDZ7wrnmGdCA3dmBlIz62aYWWZ1deMlgc0RQ6ElvY8KR6CIhYtQaQ+2TS8CNPc408iQEdc2O83DhQyS7Cg/iaYfrBjkmleZxatXechB1gOPYhIPZH3CaXd1kzFFAhFeGnNLtyiMh0S1LLqrVfjWD5s//+IQFIxMCxaWyngzvT/ArzH0xApk9U1SALW43QDzGex/H776BBrsb3IiycnjCpsqjwCyWhqZ8R3T/QKcQmG3aDq9oG3+384flDOCHUuKL/4/9l+kj8rxD8BJzs0lBW9oned+7TasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie7G0yuQJgn6bzrqSkoFtDn67tyqMBYcNic5Ypx8wMQ=;
 b=2P9ouMXdd+xKVYefy6iwore88ZCMwU/D2Qn12Vu04t8zDC6YqTSW2ZkX62e+4eArejmERzUH8ZYK7B1wgAQQBk9FWtPtifvUfnSVECNNDXZoGMpXB2vQKCMWWG5R12hPZpt+zzzCkPBdCP8OvPDT/keWwT2DSGo1LU+/HVwMxEM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 15:40:26 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 15:40:26 +0000
Message-ID: <159a8917-3ade-4a15-9d82-ba4ac949e0db@amd.com>
Date: Thu, 19 Nov 2026 09:40:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
 <SA1PR12MB715234880D4B3AEDAA1AFF72F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB7152CB1DA95F6AC4190C93E6F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB71526239725978636452725DF87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <1d06a6ef-7a67-409a-bbaf-9ec9c0dd32de@amd.com>
 <SA1PR12MB71528D13366F5048D82E4841F87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <6fd3e1d7-2aee-462b-850d-c244a2c085c6@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6fd3e1d7-2aee-462b-850d-c244a2c085c6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P220CA0079.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:259::11) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: c9631758-1c72-4104-1505-08df46536e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|11063799006|56012099006|261026121527099003|261102123227099003|5023799004|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: fVdmjVB7QPrl9QDkDmXSmRAOiU0A5QwvQOrplU9JPuzEVJdzGTRPJ8znUpc1ucRPQluozOwDUXUSf92AkuDYkaP3w2NM7GAT/u5fw/k+HFsh0fTKB8YFIFR1+0Ddxlemnm1fVGddIJhv6/UjP7JNZVV73VPqvzCF2qDWGYk4Z1pPnkczjMBhqCXCdx0Pvvoca6KFnIBdKig1xr8JR4R/yGkvIqEtxL6BN48gdKf4OOXjWEdx6E+Vc8gDx+NpybHlBo+MzBdQiymPtSBLDwtZYwFBhVCtIChCTRnT4dLruWnL4kBGKqzLqg12kWO8I7HNZdod2TVdJgIK3vEj1ZzGqDkkclAIuCFEH708DhseI3HStFC7A9NCYOZCECREn3VO3qQcBdlHotdw2YVJbVCVRHOYZTauF1bYIU+2rXvMR33Y17LafprhFLYYdXQuxsufVssuXcNAUNa/HKpewHvLNZpl9m2W98DJ2l0V65T3cyuckB/6KuIzV0YFWbLALNqrf/LbmFSfAg+Os7lkoA/NTGq6UdOipwGJjsAO2Wl2s5ZiAayC6JWAiIanRjWhC238+pdjA+eR86T6UbEqas+1kcX/iMZBG3qi6LKtyEcWBzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(5023799004)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTZON2tBMlMyeFM0Ly9GSlRiUUZ3WFR1S0d2Rm5WV3dZaE1NMlYybCtkdGln?=
 =?utf-8?B?dGMzaXJSSDlPaXY2SXR0OUJReDFCMVRnbUptNE9pOWVWckZLRjR4Q1hHblM4?=
 =?utf-8?B?Y1lwMWdINkZlZFE1RE95Wm9va2xuSjNScURPUXdEUmhXZldKWUR3dmV0QmpS?=
 =?utf-8?B?ZWhrdTVvbzlxTXZ2UHVCbDF1SVhFUEg1MnJaL1ZQdHk0SkZCOUdMZ1pTZ2tZ?=
 =?utf-8?B?dFhGa1BrOTk0SW9xc3NMOXpMN2hCeCtTZmNaS00xQmgyZW1mNW5sKzVUZXIz?=
 =?utf-8?B?Zko4NElYWGh1ckJLazE0V1NzRVdLUFNlNkN1K0RQTVJHTHZjOWhQY2k2SjZY?=
 =?utf-8?B?aURDOENqVGhzcko3OVNnVXN6ZnFWZStzYkZ5UnNYTVcrNGhnVk9Pd0VXdzcz?=
 =?utf-8?B?eEUzc0JVR3pxVUtlU20zVkdKaVA0SllIM1FHdVNJcVRsclpUVHo5VDMzTWl4?=
 =?utf-8?B?eDNJQ0hMVXZZdDdKVDliM0tFTFFFT0JKNld5ekJ6T00xVzVNWDdXTTV2TXIv?=
 =?utf-8?B?cXM0TmhIWVEzM0hkMjhxL0h5YmxJV3pETVEyS3NmUmRFbExQTGFWNkpNbVdB?=
 =?utf-8?B?dmdESERnUTV6c0dUOTVPRDRtSW9GTjlFOXRkeVg5QXozTG9uVkl5SFFBZWE0?=
 =?utf-8?B?aXFCdjBOM1FMK2crM3dQZ29pK0N3UldkeHlkeDMvTFhOR1BvYWFNemU1cjY5?=
 =?utf-8?B?WVJMQWlHc25CY0dLZ0p5Z2RpZjhTS2cxVXZtWklOM01vWnF6SzhHZ2ZFRVYz?=
 =?utf-8?B?WnhvR29tbGJySnhEemVMU216ZUEwNVcvSGt3Z2xlVitOdjd2dHNxRkxHWmNV?=
 =?utf-8?B?S0xxODgwYis5d1RURHhUMVVRTG85UGRjbTF0eDVOT0JadGlVK0Q3c1N3UlRP?=
 =?utf-8?B?VzJKbVlJMkFNUy9LTzE4STVTZk5aRk5zY3U5eG1iT3JRTTFqUmpwWjdjekl5?=
 =?utf-8?B?bytiTWtNc1ZqL2RyVE0wcUZlQWNWeUFoWmltVFpMeUtjV0hYVTVNbUpEa2h6?=
 =?utf-8?B?VmNvb0RoTlcyRExnTmE1aGhxVE50OWVXWE9YejFyYTduMm9kM3Q4bWVOaFh6?=
 =?utf-8?B?VHhBV3NIZzdnOXFobnlHY2NsenN2ODNrZDh0TzFCV2wzRVBrVkpGTUVSSjBV?=
 =?utf-8?B?TkdOQlU5S3Vwc0gxaDZRZ29kSVhtRmN4bU9NYzQ2S2c2L0d1UmxvUGwzVHdk?=
 =?utf-8?B?OWVkQTdPTGdUdVNXWkJucnMyT2RUV3pUbi9YT1N4d1JxQ0k3R3VDZGxpYk0x?=
 =?utf-8?B?aDhpU3FrdkcySHg2MER1ME8ydmpUUlFWbzMzYmRsdFV3WWJNbmxOVkV2N2N4?=
 =?utf-8?B?cW45dmJwTjBXTmhLS21KZGtTelcvbTh1SzQzVUY4dFhUekdxakJpY2xqY3M5?=
 =?utf-8?B?S2RBNHJUOXVUdlFpcHRlMjdLNDVkVTJDS1pWbWtKTi9XTU9jWTFXbDBlbFFa?=
 =?utf-8?B?dmtNRkMyNzkxZDlaRzk2QlpGR0NueWpETHczV2Z2SHBKZGRycDR6SlcvT2hW?=
 =?utf-8?B?WGpnY0l5amJVN0ZlSXJpRnQxQU1wM0x4RFBrc3F1VWJDZnYzN09hQ0VpZlhJ?=
 =?utf-8?B?NXhURzdIQk1ibmxiOGc0MDVSOFFVTjlLeE05c2tuZjFWY0ZXbEJ3dXFreEx5?=
 =?utf-8?B?U0VCY3UzZ1ZhbmFOdUhDNlVINExsa0lpcGpzdFd1ZHBkOG5EVUdObTZPWVo2?=
 =?utf-8?B?cFZTSVdtU0ZtZXQvRUsyWkZzbUxqUGJzdEwxU09NbytIcStIeXdXUndRYnNH?=
 =?utf-8?B?VFNpWGZDN2czYkh6d3pWYndHc3QzTExxQnpOam9WWEh0K3ZTa29YNXJIQ0dC?=
 =?utf-8?B?YlIrQUhQZ0VZSzFseDN1ZCtuWFR6VFVOcllJakVGTGtUWVh2c29qU0tlYjdm?=
 =?utf-8?B?ZHRPNnZ2U3FiS1pKOGUrR1d2TWgxSTA3QnNPVUZ6d1g2NUVONWRJVDc0dlF5?=
 =?utf-8?B?YzcxVTgwL3FyRDFsRWdIc0RyODA3UjZHbE1UYXZpeFNwRGtwWlQrdWdxSjBU?=
 =?utf-8?B?VkNyMFdVaDJJMTJZN2NLOHVUMUExWFBVZi9QUm9qbVhzcllxYVg1N2lxeW0r?=
 =?utf-8?B?OXVlbTlCNnc5VklQb0hmUmVqTWJvcmNXQ3BvYVNlSGpyN1RLQktoT1pxR0c5?=
 =?utf-8?B?dk1Ya2pWUG5jQjYySE5MTHZUQk9pd2RBM2V5aVVDaVlFM2V0Ym1JR2IzdU80?=
 =?utf-8?B?MmlJRnRkR1VSQ2xMZHI2L2xpZWNuWTB6c3BwTnhLcFpvMnlwUEp4ODR0YVlM?=
 =?utf-8?B?ckpJVlZVeVdZc0JWemIyR3VDTHJsQ3RYelFlL0sveUdBS0x0QjZjWXZNM1VT?=
 =?utf-8?Q?tWQAKV7w9Ayuk4rz2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9631758-1c72-4104-1505-08df46536e4a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:40:25.8868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPXjieXYVRAvOQNjH2dBCT4Fpde+eXG2Bhyjh/Ad7Ufjs8i2I5N5hqSq2PWVfVJjYvv0ewOfhNJ+t+GeMjeP4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/26 07:51, Christian König wrote:
> Hi Tharshan,
> 
> feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> and push to amd-staging-drm-next unless Mario comes up with some last minute comments.
> 

No concerns.
> We should probably rename the amdgpu_vm_wait_idle() function to something like amdgpu_vm_flush_entities() because the name is really confusing.
> 
> Regards,
> Christian.
> 
> On 11/18/26 20:01, Thothiralingam, Logatharshan wrote:
>> AMD General
>>
>> Hi Christian,
>>
>> You are right, amdgpu_vm_wait_idle() is not needed. I was thinking of that before, but I added it in the previous patch per your request. But now, I have removed it.
>>
>> Please see the attached patch. I have tested it, and the hang is not seen. Please let me know if the patch is good to go so that I can share the solution with our customer.
>>
>> Then, I can create another patch against upstream and work on getting it pushed.
>>
>> Thanks,
>> Tharshan
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, November 18, 2026 5:15 AM
>> To: Thothiralingam, Logatharshan <Logatharshan.Thothiralingam@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
>>
>> Hi Tharshan,
>>
>> oh that is a really good point, using amdgpu_vm_wait_idle() here is not correct either because of the same problems as with the context flush.
>>
>>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>>> false,MAX_SCHEDULE_TIMEOUT);
>>
>> That looks like the right thing to do, yes.
>>
>> It only might be necessary to replace DMA_RESV_USAGE_READ with DMA_RESV_USAGE_BOOKKEEP, but I'm not sure if KFD/userqueue suspend resume is actually fully implemented and handling this.
>>
>> Maybe we should stick with DMA_RESV_USAGE_READ for now and I will let my team double check the KFD/userqueu thing later on.
>>
>> Thanks,
>> Christian.
>>
>> On 11/17/26 21:08, Thothiralingam, Logatharshan wrote:
>>> AMD General
>>>
>>> Hi Christian,
>>>
>>> So adding dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); before the amdgpu_vm_wait_idle() fixes that gfx reset. So it seems like amdgpu_vm_wait_idle() alone is not enough.
>>>
>>> Attached the patch again. Please let me know if it's good.
>>>
>>> Thanks,
>>> Tharshan
>>>
>>> -----Original Message-----
>>> From: Thothiralingam, Logatharshan
>>> Sent: Tuesday, November 17, 2026 12:52 PM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>>> suspend
>>>
>>> Hi Chistian,
>>>
>>> Just having the amdgpu_vm_wait_idle() doesn't solve the issue. I
>>> tested it and I do see the reset. I have attached a patch with the
>>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>>> false,MAX_SCHEDULE_TIMEOUT); I am building it now to test.  Please let
>>> me know your thoughts
>>>
>>> Thanks,
>>> Tharshan
>>>
>>> -----Original Message-----
>>> From: Thothiralingam, Logatharshan
>>> Sent: Tuesday, November 17, 2026 8:39 AM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>>> <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>>> suspend
>>>
>>> Hi Chistian,
>>>
>>> I looked a the amdgpu_vm_wait_idle() function and noticed that starting commit 1f02f20 (https://github.com/eseiker/kernel-asahi/commit/1f02f2044bda1db1fd995bc35961ab075fa7b5a2)  the wait on the VM's root page table fence list is removed. So correct me if I am wrong, this alone won't wait on the gfx jobs right?
>>>
>>> So should I add this before the idle call?
>>>
>>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>>> false,MAX_SCHEDULE_TIMEOUT);
>>>
>>>
>>> Thanks,
>>> Tharshan
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Tuesday, November 17, 2026 4:37 AM
>>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Thothiralingam, Logatharshan
>>> <Logatharshan.Thothiralingam@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>>> suspend
>>>
>>> On 11/16/26 21:40, Mario Limonciello wrote:
>>>> At suspend, amdgpu_fence_driver_hw_fini() only waits for the last
>>>> fence emitted to each ring. Jobs still queued in a scheduler entity
>>>> have not reached run_job() yet and so have no hardware fence.
>>>> Userspace is frozen at this point, but such jobs can become runnable
>>>> later, for example once a dependency signals, and the scheduler then
>>>> pushes them into the ring after the hardware wait has finished and
>>>> before the IP blocks are torn down. On resume the ring write pointer
>>>> is reset, those jobs never signal and the GFX ring times out and hangs.
>>>>
>>>> This was observed as a rare (about 2 in 400 cycles) GFX hang on S3
>>>> resume on Picasso.
>>>>
>>>> Flush the context and VM scheduler entities of every open file before
>>>> evicting resources, mirroring what amdgpu_flush() does on file close.
>>>> Like for any other dma_fence there is no timeout, the wait is not
>>>> bounded.
>>>>
>>>> Reported-by: Logatharshan Thothiralingam
>>>> <Logatharshan.Thothiralingam@amd.com>
>>>> Closes:
>>>> https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F2
>>>> @ SA1SPRMB0073.namprd12.prod.outlook.com/
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>>>> ++++++++++++++++++++++++++
>>>>   1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 19a566187dfb5..d18348116d3f1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>>>        }
>>>>   }
>>>>
>>>> +/**
>>>> + * amdgpu_device_flush_file_entities - drain scheduler entities of
>>>> +open files
>>>> + * @adev: amdgpu device object
>>>> + *
>>>> + * Wait for the scheduler entities owned by all open files (the
>>>> +context
>>>> + * entities used for command submission and the VM entities used for
>>>> +page
>>>> + * table updates) to run out of queued jobs, so that nothing can
>>>> +slip into
>>>> + * the rings after the hardware fences were waited on at suspend time.
>>>> + */
>>>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device
>>>> +*adev) {
>>>> +     struct drm_device *ddev = adev_to_drm(adev);
>>>> +     struct drm_file *file;
>>>> +
>>>> +     guard(mutex)(&ddev->filelist_mutex);
>>>> +     list_for_each_entry(file, &ddev->filelist, lhead) {
>>>> +             struct amdgpu_fpriv *fpriv = file->driver_priv;
>>>> +
>>>> +             amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>>>> +                                         MAX_SCHEDULE_TIMEOUT);
>>>
>>> That is actually superfluous and even a little bit dangerous.
>>>
>>> amdgpu_ctx_mgr_entity_flush() is only supposed to be called from the process which has the file descriptor open and is closing it.
>>>
>>> We use that to detect if that process using the file descriptor was killed and we should discard queued up work instead of waiting for it to finish executing.
>>>
>>>> +             amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
>>>
>>> That here should be enough to wait for all work to complete.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> +     }
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_device_suspend - initiate device suspend
>>>>    *
>>>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>>>        if (r)
>>>>                goto unwind_ip_phase1;
>>>>
>>>> +     amdgpu_device_flush_file_entities(adev);
>>>> +
>>>>        r = amdgpu_device_evict_resources(adev);
>>>>        if (r)
>>>>                goto unwind_userq;
>>>>
>>>> ---
>>>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>>>> change-id: 20261116-superm1-drain-submissions-17d4414ab3b9
>>>>
>>>> Best regards,
>>>> --
>>>> Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>
>>
> 

