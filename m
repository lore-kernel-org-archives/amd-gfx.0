Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56593D41C17
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 08:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C8010E69C;
	Wed, 13 Nov 2024 08:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EGUBlgvL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB56B10E69C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 08:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAuONVN4ry4By0SxZYZhf55rwlhDC67ml8R2Obl6jQqFIwCyClyiv3A5YIB/E0ZIUgluzwaSARI9Je5FEt79c0LeuTLS2mCn7d1tzEv7wbKOyDykRmpLzVbQraAGXWiiG2NP+AyPKSGBYqt04pE2FjN+FjfEHBLEvf6J1uXq6Wf3jr5zReDn8QltgU6hnMO39dvIfzJ0bXYUKJV1/z9pWT39vy892k8kzXc+PhDV4yfo/QsIQ0FTKMJJgfULqjDq7pnFGlYV0tEFGsfDQ7MMALeNM80ru1bwg25t7gDUIGcn2ogbI5xH9JlYt8B0CX/4Jb7wPfEyPHSGuQkDNNaZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKEddRO/gn/HKFWeuaMIKogC7FZGBKpxMPPIh6m16+w=;
 b=IxxLRUThKRZmV2/Dr/k5PadQWOJ266XYF0TSWPUvNbO1oNdb/6JFUanPE0swNnAPVuO6qFDBLye7vMOz4YJfVkA8P/ePNYSN/wUjwyYQkn3pixWsL6dEL2UahQa3X8tHTDV2BLE2cQUlykzxpNtLEKoKwairdx+vHGYkIKu+CLkPs7VfODnFTYVzmGQhrvX0ue70jkGlMECHJO8hkD+9hnB0CfminS8rMcEZqm4bAvIdA+A1ar4/z+6MzZQigBJSg2G/LNleyp1XDpQYH1FTkzWct3MmVLNifEXu+PMxRne4kVKDgE/UApZdzWVtD5GJPVAt4S+3LNgei+c6kiXDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKEddRO/gn/HKFWeuaMIKogC7FZGBKpxMPPIh6m16+w=;
 b=EGUBlgvLE8pwar14geIgFH6ukiOM+xdih5qFPiih4zAHL9uLURHFwrTLkYmSzZmZiLZrOOxXM2UyjU/Eacp47i8keanxtwnhYyh4smwtNKw899LeletOBwd8Mpjqjg1eQpsQXD1eT5tJKvnNooSXe8Ud0QeL8Xuwc2afSk30KMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6406.namprd12.prod.outlook.com (2603:10b6:930:3d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 08:49:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 08:49:06 +0000
Message-ID: <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
Date: Wed, 13 Nov 2024 09:49:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "tvrtko.ursulin@igalia.com" <tvrtko.ursulin@igalia.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6406:EE_
X-MS-Office365-Filtering-Correlation-Id: ac00d847-45e8-470d-d9e5-08dd03c007da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE1LTEZ3dHNIQ09lYmFESGk4b2dUSHNZSFV6dVYrWFF5MW0xK0UxV2FCSXRE?=
 =?utf-8?B?M1I3a09zaURncVJTOFRJQklDQ1pSMkVPQW9BR2ZTU21la243L3dWQ2NXYWZt?=
 =?utf-8?B?SmdYTDZlYTE2VTU5amp2Z202WWJTQ1VvS0NBMGtXZElXN1dGQ21sR29BRGc2?=
 =?utf-8?B?NkpLNkV2WmtHejVyYjNLWWJGd05WYVlVdFpLU1B2MTNiNWpjVGlmeCtiMzFH?=
 =?utf-8?B?YWFxdHFRdUZ0TFordU1DeGYxNEVlbHNVZTVsSDVwMnVPWDZlcFl4QlJpZ3E0?=
 =?utf-8?B?bFY0M3VmeFZlOGtaNDZYWDZIL3NBOFVDZEJxanpRenJRc2hqTjNuVXZqdFQz?=
 =?utf-8?B?eTZibmxmRzF0ai93b1FlK1B4K1Q2L2xtS0MyblRmSmsxSHo3QlZrL2xBR29n?=
 =?utf-8?B?ay9ORmhMZUJGb3p0STJhR0dEdnd4K3BMVWFHaC9xWmx1ZFJvSTlIUDNBN0Na?=
 =?utf-8?B?M1Y2ZHQ3ZnBIalpXcERIMFZXZW55SGFuTXAvaGVENHcyOXNBRzAzNjFYNXdv?=
 =?utf-8?B?bWZjYUhRN1FrOVB6RGRtd2RKRDBiTVRHeitrcG1uUlJFV3BWUjFaa2lwTjk1?=
 =?utf-8?B?cnU3cmZJeEw2OWdWSk1veEFaYkF5U2J1NHlCN09VUW1uUDRNaWY0elpKbjl2?=
 =?utf-8?B?b2tYRWdxRXJBNjA4NzhIczVNeEZORmpkNWQ4eE4rYmVBSjVlWk5CUXVUWmow?=
 =?utf-8?B?VzZiOHR5U1pGaEhvZzdkempaam80NGFRcFYxU3VHVzkxbW1KeHJrRnBtcExI?=
 =?utf-8?B?MTVNRmlOOFB2V09DZjVjR0gxbGNBZG1HeXZxRE0wT282TisrNncrSnF6Z09m?=
 =?utf-8?B?azlGQUtIbjhOU1lSZlRRQjVoR1RqNDhYNGpLTys4MWxUTTlqRkRrMXRLZk5V?=
 =?utf-8?B?NGRMc043TEVsOFd2MnpmYnJpZzQxTW53TnB5dytORkZNNlFmWHgzZlFmVkVp?=
 =?utf-8?B?TjRDOEowd2xpQ2QzNDZ0UmRlSEdkY0Q4WnZYbyt2cVE5SlZtTDJFZW9GaDNw?=
 =?utf-8?B?YlI1SVZUcVc0anJkeDg3eFhMeWo5MTU1Sm9ZaFgwVy9YWjQ3OWRXUDhyQXFh?=
 =?utf-8?B?cUx6aS9KUlZPUzNQVWxjdU50SkZCWlhEVW5RanZyZ0d5MndkeEtlV3ZmRGNt?=
 =?utf-8?B?RjVyOWRpUXRaQ2habDVxMlJqOXpnalNSN1F1dXZJYVRqL3RyTnYvOFpib1Zu?=
 =?utf-8?B?cTU2UC8wbGsrNWJzWXNMZ3ZyTnV6eWxBN1V2U2hvRHVXY2xJeUNZdWNjYzJG?=
 =?utf-8?B?Zk43TjVJS2l3L0J2UkRYOXAzRW9sODJPWVk2SXh0RlZGQ2pid25PcVR2L3lu?=
 =?utf-8?B?cURQZ0ROa01RU0JxQXRqOHlNRC9pR0h2alArMlczVFI2R0RUaVMyYVA2RStO?=
 =?utf-8?B?L3RjVUdpNHIvT1ZzbVZUUCsxMmpvNTBiRjFPdDZVR0FhZVNLbWdQNnFjbWVH?=
 =?utf-8?B?andPV2NFK28vRXN3RWk1RjJVUTM1eTZsY20vZE5PcTF6dWljR096Vjc5L3la?=
 =?utf-8?B?R1psTzhMOGNNZVE0aGpSVVdUM2c0elRLZ1JzZFpDcUpjNGJaUjUxazlBK3lk?=
 =?utf-8?B?Nml1YzJVaE9KdzYwbHNac1VFRExzSHRaUzhQSzRqK0gwZnBObllhYnd3SUdE?=
 =?utf-8?B?M1ZLaVBXSUQ0RGppeWQxbGs0UUZEWXVIOUxRbW01UjQyWXZER3RONi93V0h0?=
 =?utf-8?B?bVNuNGRQS2dqNlhEaUVITUM1dW90eEVvVmlBYmF6dXlBa05yQU5QMnB5T2k1?=
 =?utf-8?Q?bx8yvYG7stUnlVgoFf0yyAozxv5CJFP6khxUoP/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZ0d1VESTZzMitacGwvMFowZnB4R1JKZ3hyREltNGRlOVBqYUF5Q2ZrNVAy?=
 =?utf-8?B?SlB2R05VZUdKVVZHc3JHK1ZabDFkM3FubWlEdWVSdmZGNTdIaUpxNGJ3RTBP?=
 =?utf-8?B?YTd4cUw0Yjg2bDBreFNiMTh6ekY2bkcrM1l1M01WR1lVK3hNQlBkaGlXTnRo?=
 =?utf-8?B?aHFLZWVHMVpxZ3BNa2I2TUxmWDdiZ1Q2MUt1MlZsRVFZeVBRaUJTOG1WRlNt?=
 =?utf-8?B?cnR4THRoYWhaUUxmYzBwb0MvTTZmWXk2RENIYkZOZnN1QytMTk5QaEFVQk5k?=
 =?utf-8?B?blZlRUtZWjhaWjV1VStHY0xuclFwUkVlSDNZcitXRVRET3l1NW94QTFrWWlp?=
 =?utf-8?B?NGxvUGxxRjdJeDVUZnhva1ZRSnA1UGJOUFE2UWlwZkRnT3R1S0h2SG1nNmdX?=
 =?utf-8?B?MzE0MjdIZ3B6bDBOMmRMOTVXa0t2Y3FYQVFKei9ONVZYSWEvL1UyQUNTcXV3?=
 =?utf-8?B?bDY5Uk9vMzBtWEc3cVVzaFBFMDZmVGVoVEVhRFNtS0pQN3JuMXBVTE1DVEVD?=
 =?utf-8?B?UWU2blBpa1ozWlZNQVUzYkdoWU9ZWFRwMGo3OVMzYVVZejg0K052ZGNUUnBW?=
 =?utf-8?B?TmFUVWs5QW53K3ZmeHFFUlpUQ0ptYmg2RUxuL2hSZkRzT1VmTGJrd1Z1ckhl?=
 =?utf-8?B?Rmk3bG5WWWJZSlNSZnNxd2RGVUlKSnNuVkl5V2dvazIzN0d2T0hiUmN0dUR6?=
 =?utf-8?B?Q2RNc2RGUU8wbC9Sd1p1S1p1TGZSWHF4dGN5b2pNd05QditETHJHZSs0WDdR?=
 =?utf-8?B?MGRGNnZUSUVROUwvamdkOWMzNVdjNC9QbExObndicWcvYTBibnJVZld4Q0Uw?=
 =?utf-8?B?bDBRZS9sa2xwNG9ZeFNqN3lZdWRqNC9QS0hhaU9YQWpDdzNVK2cvTzl0cWEv?=
 =?utf-8?B?RXdTSmhQVEN1ZWlIbi9XYXNadWNHa1lKS2Q2VWU4S2dqd3NhdGZ6UElXRWk5?=
 =?utf-8?B?V1pDUnZQUGJ6SDRlanF0U1FqZm14bUVScTNTU3ptUHBhMjgvTXg3UElaQWxU?=
 =?utf-8?B?OGRieXpJamNhU0xDc3htbkxSb2ZaZFNZRE80WkZPK3BNaGhtS3dnaldjczAz?=
 =?utf-8?B?RENCY3h4MEVGbGNXWWFscDJQcU1vYm5XMVlPWE0vTlJ6UHJmaVJWb05Zdzdy?=
 =?utf-8?B?cFRMN3U1dk9jbkx4Y0VKSkloQkZhUmo4UEpMTVE0ZFY3eUttdGZvcm1HaXVV?=
 =?utf-8?B?azFEaHpyakF3K2hxRFdlNGdlNmQrRGRtcEd6MW9OaFhyNEtzNjgvcy9sOVFO?=
 =?utf-8?B?cHIzSGR3TDE3ZStRdXlyTVBSeDhVTXBRUjhBY1dqczdLbkNZRHo0RFF3bjdH?=
 =?utf-8?B?TnZwNzBaa3RwZzNOT1RCVGxoY3BZVmpKWFVzVzg4NzYyVzdiMkNXbXEzYW0x?=
 =?utf-8?B?UTB1aDdYUnJTeTcrNnI4aWw2K1dLTXZ0aXQ0N2lBNWgvY3pkdG12aWpQdDJw?=
 =?utf-8?B?S0diU09UUVZlYnJ2SVNUcnM1UTJobFBNSnlnS2F6REJMRDVrNGxic0t1NXVx?=
 =?utf-8?B?b2tiaWtLclpLdm1hRFZyNG9ZYWg4OFEvNnNHZC9kSjRNZVFXQ3kyT0JNcGY5?=
 =?utf-8?B?V25JU2c5RHRMNVo2b0QrNXR2OFNJdG56UlFwSzZkYlFxMnhGamxYUjFteUNp?=
 =?utf-8?B?UWFEaGEyU0Z6M0ZGYklLc2R4Vk03dkt3emdaMDEyZU1lNnp1VmI0WGNIcU1H?=
 =?utf-8?B?Sk5YZGlXNkVlTDZ5eWVTY0Rra0d5TzVxTDNXby9NU2hrZm5jNlVoT3VEV1N5?=
 =?utf-8?B?eEVrN3cxTUdwNjdsUUExSDhOUTRqZGpYVi9uT1JmRkJKSlBtYnFTdysvR3B5?=
 =?utf-8?B?d1k3NW5XLys1THVSR0k4YTZTT0VRUFVPMHVySFdhOElzMm44ZGU3VlN0aTZp?=
 =?utf-8?B?bEZYZXQ1V1hidUtxY2l6VTdxMXVid014ZW5neStMRWs5c2lHQkFqbmZsYnQx?=
 =?utf-8?B?YURDaHR1TUNtbzYwaUZNQVJHQzg4R1FxRzlJNkk3eGlobTFTWm83WUJrbG51?=
 =?utf-8?B?TExQRXYvekIyeDJkL28yaTV3UjRBZ2pvYTB2NmFEM1ljeEZFUzg0aUtMVEx1?=
 =?utf-8?B?amVxU0lSR2FXcThORlpmZ29jZ2hoYmNHWXZNcmJMSnVTQXV3ZnhvVmdOQ1BZ?=
 =?utf-8?Q?wWu0q9fkOWCAxJXWnDkQRj6kn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac00d847-45e8-470d-d9e5-08dd03c007da
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 08:49:05.9340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIm9Cf2dfnO7frGhhrmlK1XidMq0/dlzk4Prc8ZvqnHGu3921RcoJ33/6G9ZMuKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6406
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

Am 12.11.24 um 19:16 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, November 12, 2024 5:54
>> Am 10.11.24 um 16:41 schrieb Yunxiang Li:
>>> @@ -310,6 +311,92 @@ static void amdgpu_vm_bo_reset_state_machine(struct
>> amdgpu_vm *vm)
>>>      spin_unlock(&vm->status_lock);
>>>    }
>>>
>>> +/**
>>> + * amdgpu_vm_update_shared - helper to update shared memory stat
>>> + * @base: base structure for tracking BO usage in a VM
>>> + * @sign: if we should add (+1) or subtract (-1) from the shared stat
>>> + *
>>> + * Takes the vm status_lock and updates the shared memory stat. If
>>> +the basic
>>> + * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need
>>> +to be called
>>> + * as well.
>>> + */
>>> +static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base,
>>> +int sign) {
>>> +   struct amdgpu_vm *vm = base->vm;
>>> +   struct amdgpu_bo *bo = base->bo;
>>> +   struct ttm_resource *res;
>>> +   int64_t size;
>>> +   uint32_t type;
>>> +
>>> +   if (!vm || !bo)
>>> +           return;
>>> +
>>> +   size = sign * amdgpu_bo_size(bo);
>>> +   res = bo->tbo.resource;
>>> +   type = res ? res->mem_type : amdgpu_bo_get_preferred_placement(bo);
>> Again, it's a clear NAK from my side to do stuff like that.
>>
>> When there isn't any backing store the BO should *not* be accounted to anything.
> I don't have a preference either way, but I think it should be a separate discussion to properly define what drm-total- means.
>
>>> +   type = res ? res->mem_type : amdgpu_bo_get_preferred_placement(bo);
>>> +   shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
>>> +
>>> +   if (type >= __AMDGPU_PL_LAST)
>>> +           return;
>>> +
>>> +   spin_lock(&vm->status_lock);
>>> +
>>> +   if (shared)
>>> +           vm->stats[type].drm.shared += size;
>>> +   else
>>> +           vm->stats[type].drm.private += size;
>>> +   if (res)
>>> +           vm->stats[type].drm.resident += size;
>>> +   if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
>>> +           vm->stats[type].drm.purgeable += size;
>>> +
>>> +   if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
>>> +           vm->stats[TTM_PL_VRAM].requested += size;
>>> +           if (type != TTM_PL_VRAM)
>>> +                   vm->stats[TTM_PL_VRAM].evicted += size;
>> Again that is incorrect. BOs can be created with VRAM|GTT as their placement.
>>
>> If such a BO is placed into GTT that doesn't mean it is evicted.
> In that case, do we count BO with VRAM|GTT in both VRAM and GTT's .requested field? and if they are not in either, they go in both .evicted field?

Oh, good question depends on the definition of the requested field.

Accounting it to VRAM.evicted while GTT placement is desirable as well 
is certainly not correct.

 From my understanding they should go into the VRAM request, but not 
account to evicted. But Tvrtko might see that differently.

>
>>> @@ -2612,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>>> struct amdgpu_vm *vm)
>>>
>>>      root = amdgpu_bo_ref(vm->root.bo);
>>>      amdgpu_bo_reserve(root, true);
>>> -   amdgpu_vm_put_task_info(vm->task_info);
>>>      amdgpu_vm_set_pasid(adev, vm, 0);
>>>      dma_fence_wait(vm->last_unlocked, false);
>>>      dma_fence_put(vm->last_unlocked);
>>> @@ -2660,6 +2754,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
>> struct amdgpu_vm *vm)
>>>              }
>>>      }
>>>
>>> +   if (!amdgpu_vm_stats_is_zero(vm)) {
>>> +           struct amdgpu_task_info *ti = vm->task_info;
>>> +
>>> +           dev_warn(adev->dev,
>>> +                    "VM memory stats for proc %s(%d) task %s(%d) is non-zero
>> when fini\n",
>>> +                    ti->process_name, ti->pid, ti->task_name, ti->tgid);
>>> +   }
>>> +
>>> +   amdgpu_vm_put_task_info(vm->task_info);
>> Please don't move the call to amdgpu_vm_put_task_info().
> Is keeping the task_info alive a hazard here? I could copy out the info, it just seemed a bit wasteful.

Ah, now I see why you have moved that.

IIRC we need to free up the task info before releasing the PASID, but 
that info might be outdated. Need to check the code.

Does it work if you move the message further up or does the root PD then 
break your neck because it isn't released yet?

Thanks,
Christian.

>
> Regards,
> Teddy

