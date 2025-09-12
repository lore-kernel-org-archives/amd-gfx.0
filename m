Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5189CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 14:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BB210EC5E;
	Fri, 12 Sep 2025 14:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZAEj8erx";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D311D10EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 14:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNeRvNWhZ48TbiZBDBtIcONGOrcE8eTBybS+qawbf6NKvI35/BlXj9faZ7P8CqVdB2tW0n3rshQ+133S+nlawhOBu1ph2A+y65ssoNkyzhxA4veKBnPEyaDO2uAjQlsYJi0bfDWqsMNMQxIcEud50fHmCtmESqcT46SpsQW6A+HpVFCygU+QK3yRFy2qU9eO1ceESQoROANaQmXFHx0vO7XyWvf2oUTvLuqZrIb1kYw7YF1A4UqVEPJC1PMAsLBh2OGCK1iwsfBEnO0pXyizlYw4lo+tjDYdOnvR1Cr08aApWp/QLnzrKDygTH7W1fFz2FfNYFZvHz3FITLFCN12mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qf0931FspqpBD1gyzmAZ2dwUYyAv6V4BOA+Pq8ybQ4=;
 b=J1mqlbWOqay2zkVZcB0n4rC2qQhQtWt0Re5m8ij9YOHZpWxNZKQtsv+4LAwn7QSpwVFBywAB9Tu3ImU6m0fBoW5ATvyfB43blG6cmn/HKtMb8OYW2rFklSIKJ5jd7smjpzo6GuOtWGuhTVB365nfgcNa08daYuDmZVV9JQtuNqRwExE815j4SDdULR0lbXx8kmhp1WXxpPhvpBtIpNJsN6PlIipV1YNqgSQReM/p5BfMtd86kX4CUMNKYg6aERtqoX531RkyxUmsu4ExjnOBIheHjy1YpRNt807DHx0uFOmdZfNmQvz9VWNOVEvQS//yy3NlNbCIDduqQT+qxnbCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qf0931FspqpBD1gyzmAZ2dwUYyAv6V4BOA+Pq8ybQ4=;
 b=ZAEj8erxadhb/f8lRvnE7Iro1HQXT9op0TYEe3R1Q9bu1IDJCzbLPvV9gsRK84lVCVf/Ry10Zf+DIHO8yqKraF8M+dg97FSlK86/4DpB8dkf3K+rwqbE28CXFhzXJU47ixRDX7BYCY16ItlUF5KEy5Zbh58lH62aFNuP/+mpGWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:06:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:06:13 +0000
Message-ID: <45c496ec-d8c7-43c4-b1e4-33453e285bb2@amd.com>
Date: Fri, 12 Sep 2025 16:05:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] drm/amdgpu: Simplify user queue locking with global
 device mutex
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20250912093202.4905-1-Jesse.Zhang@amd.com>
 <5a04607d-0d50-4543-8498-52122045048d@amd.com>
 <CADnq5_MoPA7hMc1ffM992pxzU=UeAMaTC2AZBzpC+4Y8uP37gw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MoPA7hMc1ffM992pxzU=UeAMaTC2AZBzpC+4Y8uP37gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9882e2e2-4d52-4bc9-f310-08ddf2058880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0FibnF5aFR4YkFTQ1paN2ZCc0dqQ0o1WE1oNDdHSFhXZG9wMU12SDRjTENi?=
 =?utf-8?B?cnRCTEpXUEdrNE0xcEZMck9QL3dwYVoxWFA3RllrQ1U0ZzQ2NnozaG1Rc2FE?=
 =?utf-8?B?ZjlZL2hJRmdqbkRkVldwMjhwOEZXQXZHcWFZWkIwUzJlWUNGUHNqdXAvbWRH?=
 =?utf-8?B?ektGZEFJemtob3hITHdSTTY1VGRtZFpDOTBvckJZMTUxMW45aTFBUjFkSHF5?=
 =?utf-8?B?VTY4dHJ4MkdiVStIQUNkM0VGVXBQWHFuVlFRRWZITXVYWXl3VkNxK0czTTRC?=
 =?utf-8?B?Z1hZdjFacThqUXJyRDI3OHBra3N4cmJ3cjZycVByTm9IMFpxcjVDM2dMV3V2?=
 =?utf-8?B?RGN5R29ERUtLdXp5Qm5LK3VYUUtCU09uS3JvNlI5OVJGY0RhM3ROMHBIcXV0?=
 =?utf-8?B?U082L2ppQWRJTlg0dFlmV2k2VDk2RVJCWDJEYkV2OXRKZjV6bXYzQmxxWXdJ?=
 =?utf-8?B?enVzZmtFalhTWkxBS3NSWGgybkROQjZORzJ0ejZrMkt2U1A1eFFMMG4raU5C?=
 =?utf-8?B?T05uMk5UMFdzVDE4cXZ1ZzE0VS9BRXFpd2daQWpMYkJLMFZDcEM0UlowQXNO?=
 =?utf-8?B?VG1PcHBXNXVOaGFEN2hZV3prdm9oUTd4V0VNYXBZbVRZRUFtNEM4blJNN1Js?=
 =?utf-8?B?YTE0dmdTVnRYd1BlOExIb3NrUytNQndsZ3FHN1dYNmg0ZTl5c2N4U0ZOOXJw?=
 =?utf-8?B?QnExNWw3S0ZlWmpDNTBvN3VzSGJDcDBjMTh3aWZtM3ZCZUhBNnIrNlhPZVJ0?=
 =?utf-8?B?RlJwdHZkRncvV2hHaDRqb0lCY1lyaXFZcW9xeU5GNXR1TjJFbjU3OHZzR1J2?=
 =?utf-8?B?TlZaTkovcDRZRHhObWd1NUFOSm9ZZWFsc0lRRVVXNDdxbW1XUE45RUtLaGZB?=
 =?utf-8?B?djRCWU94NDFoakNEY1dQYklieVRJcUcxOVdaSk1QV0hxZDg4d09Gdnc3ajEr?=
 =?utf-8?B?SlFoaTFnUGtpcXdEc1h0ZWFxZEtFWU01MldHZ0tpVWU2YWRPSEdaZ0Ezdnlu?=
 =?utf-8?B?QU1JMEIrOVB4ajFCbmlna3l5VVd1SFl0TTN6a3U3eDN2QUt5SWNUc1ltVVZY?=
 =?utf-8?B?NCttNGxjWDBUWmlJQllDaXVXeUtKa2ZxWmNhS2hQZkYrQnlhWGVUMGFmRnNk?=
 =?utf-8?B?ZllFSnpzRlBqUXBnYS9RR1VhZ3VYR2FUdHYydXRGNDA2UlJIbUZRSkZvVm5V?=
 =?utf-8?B?bzZHQXFKZ1N0eEJCN3RzOFRUU0RUQjZmR2NnMUw4amw4SVRkUnowZkFMTldi?=
 =?utf-8?B?M1E1ditlSFJOWk5RcW9WWjB0b3VxYnNtTWhUQ2VZU1FsWWJsM1hhaFdPaWly?=
 =?utf-8?B?ZDUyeGNhWDJ0K3lXbDN0b1l6WEZPL1dxZ0J6WnhVaFc4ZmE5TnNMQWhRclRk?=
 =?utf-8?B?ZVhzSDNvUERqWi9YYklUQnlJc3FtOWFLblYyV0s5TEFqb3JKYXhsaVZ5b054?=
 =?utf-8?B?M3hXbmFFV1BYcVFkakRIUzJtNTNObW5ocjYxZE5yOU96N0E5RGNQa0pCMy9i?=
 =?utf-8?B?cVMvUDZpdlc2N2hlRktWWmFHZG03Y1lzUWlSR2YwSkNuNmc0eXVJOVdiekt3?=
 =?utf-8?B?Ylo3RnQ5S1RVSlZPaWladkJRdTFIV2d3NjV4RWFCR256MlQ5cGR0UW5vcVBX?=
 =?utf-8?B?SmdaRVJReUZxQUowc3VQb1gra2paM3hLNXk4WDlPUm04ZWd1Sit3cTArWENM?=
 =?utf-8?B?ZzJ4N2puLzMrZUl2ZXYyTFNWQkZ2VzhNdW9CZldjYTIzeGU0OTB5eDRibWJ2?=
 =?utf-8?B?amplMGhEb3EwUzJQdGVZR00wZFk1a004RExUbU1RV3JRSmZUenJtdlNVSjVO?=
 =?utf-8?B?TWlXdkdBaXJqRHBwSmIrMUowZ3dva2poczM0d0Y2WWd2Q1l3TzVGdDJEQ1Zn?=
 =?utf-8?B?eElCQjJEaE01UVp5elg0SmphaGh5dlN5Z0FEa3hqUkwzcWk3WHNVWG9jTHdu?=
 =?utf-8?Q?LCNpqF2aOeY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlIRFlPZ3oxRUtndmpWdDB1WG9KVEtUTjNLUDUzeFRXTU1FRlFSbHJEQTdk?=
 =?utf-8?B?Q1pYd25DYkRidGQzQ2FLWTJCVndYRElZQUpBR21LMmtFVnZLSG1LUisyUEE3?=
 =?utf-8?B?NEhXOHViNHp5L0tobHcvdDJSeWxkTTJUOEo4c0JIZlozYWUvcUYwVWk2aVhh?=
 =?utf-8?B?NEZwVmdoc2tGWk9OTjZ3NWNlSUErQ1l0UlFkRWp2KzdsUHROdnpvV2hWNGUx?=
 =?utf-8?B?a3lCbG42bllBMkxkb3h0WERLQ3JSSjl6aWE0YzIyRkNiQ0VMRVB0MkZzVDVs?=
 =?utf-8?B?YlZReW1rVlAxR0MyZU5ObVFtaHg1Rk1LY052R3RpY0lrWkVxUCtvNjU4WG5X?=
 =?utf-8?B?T0lWVC9yVnNtUG9rejVJeWdmS1FLdW0wS1BSeFh2dEI0aVdKTVVpM0krUkxm?=
 =?utf-8?B?Yko2YW5WdVdONElXS2w0MkxuQ0VFNEtPMHh0NStKM1QxMzdURXBiZFpnZlN0?=
 =?utf-8?B?aDZwbmp5L2gxTkRkVjV0QUVZakRrZkpTTVBEOXRDSjdYVVZ0Smk3Rm1SUWd1?=
 =?utf-8?B?akNQNktCOTc2WlpoL1RXdVNNMXhMRGpHRUdYb0ZSUG5zTGdXc2syR2d6QkZk?=
 =?utf-8?B?SjdSVjFCVElRTWNSK0J6MEJEdU1pa3ZNSGc5QUJFdjYxekdHQ2JaQnRBVHBx?=
 =?utf-8?B?cGgvYW9mVWFLQUFBVEdZdXhaUkhhSCt1ZFFwdVd6ajUxTEFtZ05IOFRNT0d1?=
 =?utf-8?B?L2x5Qk15cGc1MmFGazQvcU5ma0ZVbTU3MXR2QVRzTjdxc05ZbU5Va2pybWZa?=
 =?utf-8?B?UGhhYWhKeHdyWGRaUVZCUmJ1bWJkaHhjUlZVS0p3VmdsaFRSZUxvajV4aEdm?=
 =?utf-8?B?ZFVVbTMrMGxHOEFoVWNSVmtadE9OWFRXODRSTEhPaEtsaFNiLzV5OElSTk5R?=
 =?utf-8?B?SjF3VWNuVmVYcW1XYkJTSDBFOVIzYTV5QmdSUE1PcTgxRzVTcnpCWmdGV3ZL?=
 =?utf-8?B?ZTZWeSs3ZVd1MTNSMnNUN2pRbTFLdlVXVCt6dXNZbnVLQzBQNitLbW9yZGxo?=
 =?utf-8?B?NTZRdHJxekxIR2F3SmhBTFhHdjArMGZjSzhNakkwT1crdEs1a3ZjS1VURFdN?=
 =?utf-8?B?enVHVkxFUk9KY2k1NGRuN3JaWDVnMmhXU2tCNmNzTnFxSWNGdUVEenY2OEg3?=
 =?utf-8?B?c05mNHFyaWZaQ3VZS3lLRG1IUitEV0EzUHlldWgxQjBMeU9DV2JZQXlLZUEr?=
 =?utf-8?B?bzcxeHI4a1pkSGxqbVRQREI3d3RvWnJrcjRIK0V3SWJ1VXJVeVhna1lvTHNO?=
 =?utf-8?B?anBrRkN5SHd0cUl0RWpWT21ucU45R3FyaWdlMmhhR3QwT0drWmQ4M2lYN21a?=
 =?utf-8?B?NmtUZWNmTjE4WnpLa0h6ekQyL3pTSitjR2s0RkpTcnF6Nks3NVNqM1gxTEtF?=
 =?utf-8?B?dnRqT0VlUmgyNUFTSTczUDhyTVR3VHdMZENPSDEva051VkprWjVZYWF4YW5O?=
 =?utf-8?B?YmwvTkFoWm9EbkJ2ck1OMEc3MlJ4blJYR1Z1bEdFQzVVZTNYT1lLWllJQzBE?=
 =?utf-8?B?MDczQ2ptdVlpMzlIUDRkMnIrVklYcWQyL0dOd2ZPbzJnVllmVzA2T0o2cU1a?=
 =?utf-8?B?SGdWSWpCaFcycExCVlBHcmhxQk9hSng3MlhDckJBcHFvaW5GV1d0eitIdEV5?=
 =?utf-8?B?czMrTVdYeHZZWHA5MS9hdUV4QlZLWVVEYlYyNmRIaG9WWkVuanQ0L0VNaDha?=
 =?utf-8?B?T21PNWR1L1Y3b201cjRkNVp1aUttZXl6MFdYeE5xYWtuVVJGUy9jWkFOdzc4?=
 =?utf-8?B?Q0NHbzk4bVhmZU14V1V2SFl2K0Z1SFFySExBUTJhTFU4bWQ4RVgyZ2ltMGxO?=
 =?utf-8?B?V1hjclpORmZMc1RHSzMwOVNIV1NNN041NVF6dGxCRGtFbFVsMjJPNXhxY3U5?=
 =?utf-8?B?VE5yejVBVW4yK25vL0hiQmJ1QllzOFMyZ2JBNmQ1SFFycmNRclNyd3FmYXNH?=
 =?utf-8?B?WnpFUUZxU2tpbDl0Vy8vbkwwc0I4N2xwdW9QV2F2a0Y3UWxSWFplTDdJYlE3?=
 =?utf-8?B?M0JwSTJVdzM5bjZYbit6SUtDMVA4YklxRERncDFtZGxMQ2dzMnFmU3YrRVJi?=
 =?utf-8?B?ZkZ1KzFQUm9RUGw3OWlkSEw0UVZZQ3VRWkV0UU1saVVMSjlMU3pmdExiTEcr?=
 =?utf-8?Q?NY8QlHxC2PyAh7dqEjmUKtSp9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9882e2e2-4d52-4bc9-f310-08ddf2058880
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:06:13.7185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck5IEkUBt13GwTvyJhyXTqjtlBgkCrY3RXtMwHMHpn0MJF5lxzIjc7YUfzlaHVwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
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

On 12.09.25 15:02, Alex Deucher wrote:
> On Fri, Sep 12, 2025 at 7:17 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 12.09.25 11:31, Jesse.Zhang wrote:
>>> The current user queue implementation uses a dual-mutex scheme with
>>> both per-device (adev->userq_mutex) and per-process (uq_mgr->userq_mutex)
>>> locking. This overcomplicated design creates potential deadlock scenarios
>>> and makes the code harder to maintain.
>>>
>>> Simplify the locking by switching entirely to the global adev->userq_mutex
>>> for all user queue operations. This approach:
>>> - Eliminates potential deadlocks between the two mutexes
>>> - Serializes all user queue handling at the kernel level
>>> - Provides adequate protection since user queue operations aren't
>>>   performance-critical paths
>>> - Makes the code more maintainable with a single locking scheme
>>>
>>> Key changes:
>>> 1. Remove uq_mgr->userq_mutex entirely from amdgpu_userq_mgr
>>> 2. Consistently use adev->userq_mutex across all user queue operations
>>> 3. Add proper work flushing in amdgpu_userq_ensure_ev_fence() to
>>>    prevent races when ensuring eviction fence availability
>>> 4. Maintain proper locking order throughout all user queue functions
>>>
>>> The serialization of all user queue operations is acceptable since
>>> these are management operations that don't need high parallelism.
>>>
>>
>> Absolutely clear NAK to that.
>>
>> This also serialized eviction handling making it completely useless.
>>
>> The global mutex should only be used when new clients open up their connection for the first time or closes the last reference and never otherwise.
> 
> The problem is that the firmware reset code can affect multiple queues
> so we need some way to lock all queues during resets so we can
> properly update their status.

That shouldn't be necessary.

When all queues are affected we should use a sequence number to indicate the queue generation.

When only a subset of queues are affected then we would need to identify the queues and then set exactly those to an error.

So what exactly do we get on information from the FW?

Christian.


> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>>> ---
>>>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  7 ++--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 32 ++++++-------------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  5 +--
>>>  4 files changed, 16 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index 23d7d0b0d625..d6a07fac7df2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -105,9 +105,10 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>>       struct amdgpu_eviction_fence_mgr *evf_mgr = work_to_evf_mgr(work, suspend_work.work);
>>>       struct amdgpu_fpriv *fpriv = evf_mgr_to_fpriv(evf_mgr);
>>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>>> +     struct amdgpu_device *adev = uq_mgr->adev;
>>>       struct amdgpu_eviction_fence *ev_fence;
>>>
>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>> +     mutex_lock(&adev->userq_mutex);
>>>       spin_lock(&evf_mgr->ev_fence_lock);
>>>       ev_fence = evf_mgr->ev_fence;
>>>       if (ev_fence)
>>> @@ -118,13 +119,13 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>>>
>>>       amdgpu_userq_evict(uq_mgr, ev_fence);
>>>
>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>> +     mutex_unlock(&adev->userq_mutex);
>>>       dma_fence_put(&ev_fence->base);
>>>       return;
>>>
>>>  unlock:
>>>       spin_unlock(&evf_mgr->ev_fence_lock);
>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>> +     mutex_unlock(&adev->userq_mutex);
>>>  }
>>>
>>>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index b649ac0cedff..af92450ea6eb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -198,17 +198,18 @@ amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *uq_mgr,
>>>                            struct amdgpu_eviction_fence_mgr *evf_mgr)
>>>  {
>>>       struct amdgpu_eviction_fence *ev_fence;
>>> +     struct amdgpu_device *adev = uq_mgr->adev;
>>>
>>>  retry:
>>>       /* Flush any pending resume work to create ev_fence */
>>>       flush_delayed_work(&uq_mgr->resume_work);
>>>
>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>> +     mutex_lock(&adev->userq_mutex);
>>>       spin_lock(&evf_mgr->ev_fence_lock);
>>>       ev_fence = evf_mgr->ev_fence;
>>>       spin_unlock(&evf_mgr->ev_fence_lock);
>>>       if (!ev_fence || dma_fence_is_signaled(&ev_fence->base)) {
>>> -             mutex_unlock(&uq_mgr->userq_mutex);
>>> +             mutex_unlock(&adev->userq_mutex);
>>>               /*
>>>                * Looks like there was no pending resume work,
>>>                * add one now to create a valid eviction fence
>>> @@ -362,12 +363,12 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>       int r = 0;
>>>
>>>       cancel_delayed_work_sync(&uq_mgr->resume_work);
>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>> +     mutex_lock(&adev->userq_mutex);
>>>
>>>       queue = amdgpu_userq_find(uq_mgr, queue_id);
>>>       if (!queue) {
>>>               drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue id to destroy\n");
>>> -             mutex_unlock(&uq_mgr->userq_mutex);
>>> +             mutex_unlock(&adev->userq_mutex);
>>>               return -EINVAL;
>>>       }
>>>       amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
>>> @@ -388,7 +389,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>>>               queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>       }
>>>       amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>> +     mutex_unlock(&adev->userq_mutex);
>>>
>>>       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>>       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -478,7 +479,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>               return r;
>>>       }
>>> -
>>>       /*
>>>        * There could be a situation that we are creating a new queue while
>>>        * the other queues under this UQ_mgr are suspended. So if there is any
>>> @@ -486,7 +486,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>        *
>>>        * This will also make sure we have a valid eviction fence ready to be used.
>>>        */
>>> -     mutex_lock(&adev->userq_mutex);
>>>       amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>>
>>>       uq_funcs = adev->userq_funcs[args->in.ip_type];
>>> @@ -588,9 +587,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>       kfree(queue_name);
>>>
>>>       args->out.queue_id = qid;
>>> -
>>>  unlock:
>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>>       mutex_unlock(&adev->userq_mutex);
>>>
>>>       return r;
>>> @@ -820,11 +817,12 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>  {
>>>       struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>>       struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>> +     struct amdgpu_device *adev = uq_mgr->adev;
>>>       int ret;
>>>
>>>       flush_delayed_work(&fpriv->evf_mgr.suspend_work);
>>>
>>> -     mutex_lock(&uq_mgr->userq_mutex);
>>> +     mutex_lock(&adev->userq_mutex);
>>>
>>>       ret = amdgpu_userq_validate_bos(uq_mgr);
>>>       if (ret) {
>>> @@ -839,7 +837,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>       }
>>>
>>>  unlock:
>>> -     mutex_unlock(&uq_mgr->userq_mutex);
>>> +     mutex_unlock(&adev->userq_mutex);
>>>  }
>>>
>>>  static int
>>> @@ -919,7 +917,6 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>>>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
>>>                         struct amdgpu_device *adev)
>>>  {
>>> -     mutex_init(&userq_mgr->userq_mutex);
>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>       userq_mgr->adev = adev;
>>>       userq_mgr->file = file_priv;
>>> @@ -942,7 +939,6 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>       cancel_delayed_work_sync(&userq_mgr->resume_work);
>>>
>>>       mutex_lock(&adev->userq_mutex);
>>> -     mutex_lock(&userq_mgr->userq_mutex);
>>>       idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>>>               amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>>>               amdgpu_userq_unmap_helper(userq_mgr, queue);
>>> @@ -956,9 +952,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>               }
>>>       }
>>>       idr_destroy(&userq_mgr->userq_idr);
>>> -     mutex_unlock(&userq_mgr->userq_mutex);
>>>       mutex_unlock(&adev->userq_mutex);
>>> -     mutex_destroy(&userq_mgr->userq_mutex);
>>>  }
>>>
>>>  int amdgpu_userq_suspend(struct amdgpu_device *adev)
>>> @@ -975,13 +969,11 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>>>       mutex_lock(&adev->userq_mutex);
>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>>               cancel_delayed_work_sync(&uqm->resume_work);
>>> -             mutex_lock(&uqm->userq_mutex);
>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>                       r = amdgpu_userq_unmap_helper(uqm, queue);
>>>                       if (r)
>>>                               ret = r;
>>>               }
>>> -             mutex_unlock(&uqm->userq_mutex);
>>>       }
>>>       mutex_unlock(&adev->userq_mutex);
>>>       return ret;
>>> @@ -1000,13 +992,11 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>>>
>>>       mutex_lock(&adev->userq_mutex);
>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> -             mutex_lock(&uqm->userq_mutex);
>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>                       r = amdgpu_userq_map_helper(uqm, queue);
>>>                       if (r)
>>>                               ret = r;
>>>               }
>>> -             mutex_unlock(&uqm->userq_mutex);
>>>       }
>>>       mutex_unlock(&adev->userq_mutex);
>>>       return ret;
>>> @@ -1031,7 +1021,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>       adev->userq_halt_for_enforce_isolation = true;
>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>>               cancel_delayed_work_sync(&uqm->resume_work);
>>> -             mutex_lock(&uqm->userq_mutex);
>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>                       if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>>                            (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>>> @@ -1041,7 +1030,6 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>                                       ret = r;
>>>                       }
>>>               }
>>> -             mutex_unlock(&uqm->userq_mutex);
>>>       }
>>>       mutex_unlock(&adev->userq_mutex);
>>>       return ret;
>>> @@ -1065,7 +1053,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>               dev_warn(adev->dev, "userq scheduling already started!\n");
>>>       adev->userq_halt_for_enforce_isolation = false;
>>>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>>> -             mutex_lock(&uqm->userq_mutex);
>>>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>>>                       if (((queue->queue_type == AMDGPU_HW_IP_GFX) ||
>>>                            (queue->queue_type == AMDGPU_HW_IP_COMPUTE)) &&
>>> @@ -1075,7 +1062,6 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>                                       ret = r;
>>>                       }
>>>               }
>>> -             mutex_unlock(&uqm->userq_mutex);
>>>       }
>>>       mutex_unlock(&adev->userq_mutex);
>>>       return ret;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index c027dd916672..2d63308d55c3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -89,7 +89,6 @@ struct amdgpu_userq_funcs {
>>>  /* Usermode queues for gfx */
>>>  struct amdgpu_userq_mgr {
>>>       struct idr                      userq_idr;
>>> -     struct mutex                    userq_mutex;
>>>       struct amdgpu_device            *adev;
>>>       struct delayed_work             resume_work;
>>>       struct list_head                list;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 95e91d1dc58a..daf3be92a39c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -464,6 +464,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       u32 *bo_handles_write, num_write_bo_handles;
>>>       u32 *syncobj_handles, num_syncobj_handles;
>>>       u32 *bo_handles_read, num_read_bo_handles;
>>> +     struct amdgpu_device *adev = userq_mgr->adev;
>>>       int r, i, entry, rentry, wentry;
>>>       struct dma_fence *fence;
>>>       struct drm_exec exec;
>>> @@ -557,14 +558,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       /* Create a new fence */
>>>       r = amdgpu_userq_fence_create(queue, userq_fence, wptr, &fence);
>>>       if (r) {
>>> -             mutex_unlock(&userq_mgr->userq_mutex);
>>> +             mutex_unlock(&adev->userq_mutex);
>>>               kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>>               goto put_gobj_write;
>>>       }
>>>
>>>       dma_fence_put(queue->last_fence);
>>>       queue->last_fence = dma_fence_get(fence);
>>> -     mutex_unlock(&userq_mgr->userq_mutex);
>>> +     mutex_unlock(&adev->userq_mutex);
>>>
>>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>>                     (num_read_bo_handles + num_write_bo_handles));
>>

