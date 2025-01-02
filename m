Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E0EE77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 23:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0364F10E40D;
	Thu,  2 Jan 2025 23:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlYPjHtd";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606A410E407
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 23:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIgaYvnjNNVz9EPY2mdE64NLRuZ2zMk13UzX2dbWwwgRDqXa/gchHng3K1XWcd4axxqTnagTCF4WFu96og5U0r4pPlSBCTkcCz89ZAL4enfVZcpE5zJ6P+x8gVxthKMZ6NVGT5hoHksMkIFcMMEajWImuKUBJPStBZ3Zx/TR0La814X9TY0e0Ak0M/+XzzDAUjzm1IP4qi6QEeX9WE+roY/w+MDeUkzrQZyh/OfrhAjeokg+ZjEvzwNkVBpuFM2KHGP0cJy1peY6mAUdui6B/sjIKN3fw1GlQg8/B0yTrSOpVbRd7Z6usnDID3UL6BSRWw5Wo9G/yoWYhgeqG8kzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON4vu7qlOclUIvXnnRoeCCoZpw9VaTz6dclhtgdcAsA=;
 b=UlNjY8dx313i0nMd6SbzEGlmWPdTXoV9XPo4/fHVYEeHz+ehMA4zy9ZzZ7z9zyOOxHIRSglUhGv3RgtcV1BNOuM0pWeZR8CRhWti4Nf7rOQlY9E0XxD9fLe1rNLIW8bI/Oesl30ltF3QfZQPAR6M78Kh09QknidP27Hq3ooxs194Jmcc/F56Gw2SJiQj0yaN8gHNnFmlihkonhKFAnK28ntdvFjWRdHVUVTORCinTnmK/8zsRYcZRqSNR/4MTQT/Dj25adQTTGpsAnY+u79CC7FTL82bOGBWrC0mW65vKm60xvM1vZcak3hY43wWglI9hEHDYiC7NwMVPocawZr0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON4vu7qlOclUIvXnnRoeCCoZpw9VaTz6dclhtgdcAsA=;
 b=UlYPjHtd6fmKxqYEaq9NQ9BU0dwTAJC+wSgkW1WbkocPnsE3O9lSs+B5QkD3UFjJvtb0LUarQSWrIQoFoPlfN9IVVTwHFPtMBZt9Rd+nw/6Gi61z5VYiVWlcbnYeVhvRs5dmAOYJ7zSfyIG0XxuKzH9tGnhqZR3KrYWYgr5LbYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11; Thu, 2 Jan 2025 23:08:22 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 23:08:22 +0000
Content-Type: multipart/alternative;
 boundary="------------qv5mBrnZc6NVHvk28sVfXQ4Z"
Message-ID: <b835ec1b-f40b-4abb-8267-934a0e497415@amd.com>
Date: Thu, 2 Jan 2025 17:08:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] amdgpu: fix invalid memory access in
 kfd_cleanup_nodes()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 kent.russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com>
X-ClientProxiedBy: SN6PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:805:f2::41) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: b81e9e59-e282-4526-5de1-08dd2b825a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmJGMHNGNytldm8zeUptZ1lEZXR4VGp1UVJjejg4SlFiTHRUTFNQbFRLL1hM?=
 =?utf-8?B?SkhPTC9xWEtIcURNb2tYeHRSbmlWSVlyUk85bWZXRWFXN2EzN21saEFDblZP?=
 =?utf-8?B?ZFV1WGNxcWF4bDFBV296VHozdlZvMjVFTlFDNXVzRHBybVhmUWU0ZEFKdnJO?=
 =?utf-8?B?TDZYUXg4Z0ltbGdtTXBGdEtjOXZBTHlhUS9OQmZxemYxMXFWT01Vb0xvZ1Rx?=
 =?utf-8?B?SWVjY1VsL1I2Q2RETHZRNjRwNXVMRXZuZkxFdDJzdGNwYnozY1B6ZnptcEdV?=
 =?utf-8?B?UWxmOGdyMkYxREszQVlwUjdoRjJqSElpczIvZDErQWJ5UklKaExVbUxsVjN0?=
 =?utf-8?B?Q1Yzekp6RksxcG1IMWdVRC8wMEZqNGhOZHVPVzloRHJiaXpUS1lJOVZEZjNR?=
 =?utf-8?B?M21JK3J0RWxHanExMVQ5VXY2NndzaCtIVmRRMEFpUkEySUdJWXhZRHZ3N2JS?=
 =?utf-8?B?MXA2b1V5MDVCdUZtUWtnUmdyYnNFMGVzQ09maTc4a1FKSzVuVEpVQ3hudnpT?=
 =?utf-8?B?V2tYT2VwM3k2R2lOOHBzNTB3NGZLSTdKQ0tzaGREWHovdWtPSi9lUWQ3OXJv?=
 =?utf-8?B?SWpqdWtnTFhteXZ2WkVUWFRzYmVsbzZkMHVCTldyZlhnMmQzS3JHeDRoK0JE?=
 =?utf-8?B?U2t5bkdHUERWOWxLUzVXdkcyU2NZSWlzZXkvNFVmUlk1VUUrRGVMUnR3R0dk?=
 =?utf-8?B?aGEra1FTSENUaHZQVC80QzR0OHNzVTFTNk95elgvSnRQY0V0L29hRGRTNFNU?=
 =?utf-8?B?YzJJT3JJWldhMk1CazkzVEMzQXVEMEU5NWJlQWttS2ErWG9DV1I3bmFIVkRy?=
 =?utf-8?B?VjV3Zk1adnZhL1ZBK0V2Wml4ZUVQeVFhTDNjUHNFeUpSMmFMZitVQ0FIVXF6?=
 =?utf-8?B?alZlRlhuTnZ3dzJHeFRIeWpqOG93NkIreHN2S2d0SUNDN2F0Q3dRL0JYREFl?=
 =?utf-8?B?NUxSbGFmeVJoS3BaUXpLY1daTUdKVE9GNFduQnZ6blZSYURTNVQ5WGJtc1pW?=
 =?utf-8?B?SVJ4RGJIOVVxKzV6TGszaXh2OVg1STdxZHVUVjM0OHlzbURaeFlzWVRwTGxy?=
 =?utf-8?B?VFNiOHJTZWtkSEI4SEJ6Z0JXUGJmTEcwaDQ0NUhycFZMK3pQKzhSc1lNUEVv?=
 =?utf-8?B?Ym5kc3JkOHB3WWMxT1F4T3hBK2lkeUNjV3VrYmNlL25kMExZQTZYRitlN2ZO?=
 =?utf-8?B?MXExbkZxVXdGQzNTUjBvSkI0THZ3d3hvbnRxUVJmNWd6V0l4RjkzdDFBVDlZ?=
 =?utf-8?B?Z2oxOUxOUGMrQnV6OVFkY0p1aVFGekhzTDZueVBlR2ZDdkZqWlRFa3JWU2xo?=
 =?utf-8?B?OGpmWTgvby91MndIRzVoaWp5OWhMU0hXRVc4Z3JISGs2bUxVeVNsZjMwSXhr?=
 =?utf-8?B?QzlITVUxMmorZml4QWgzb3lZd21mNTNHRkJXNVVFb2IxaWlUbTgvUzFDWTBP?=
 =?utf-8?B?STdyeU16Y25QL0RBdTZnZkhsTEZldkd0OThJTEEzNi9kZWE5cENZMTZaL0pZ?=
 =?utf-8?B?aUhwYXQwVS9OSkliMWN4K3MyckpXNThMaHUrVFRzUVBYdGNKZnYvS1NFNU1J?=
 =?utf-8?B?TzVDRHBkSEI2ektMUm5mampOVVRTeFRrM2dYYmJ4di9FeVhidFM2a1ExeFJV?=
 =?utf-8?B?ZDY2bVlwbTdDS0NtZmtiTlNmb01oMEdIRnlWTWRVTEpjTlNtZ1lTRmFxaTZN?=
 =?utf-8?B?dENsbGFiNXM4Qnc2UTBJbThmV0pNazFia05CdjdCNGZWQ0UxT0FPTDNMV1V0?=
 =?utf-8?B?eVFleVlNcEc2RHk5OEYvUWcrczNRV09rd21nZ2ptWXRqTnA4ZkhqdmRyNXdk?=
 =?utf-8?B?TWVBdlhpVmhOeVFYWEdaaDBiMDcwWENCY2xzTDU2NkF6UjFjUEQ1ZmVKZXda?=
 =?utf-8?Q?RPV0mn+xTNCaY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzE1U1lxRnowclZocFRGQkxWbFRYZUZiT0lwbXdOYzNUTWNPQStKczZtS0x3?=
 =?utf-8?B?UUE5TVorK1VRVnhRVEtVQ2NlQUNlUlcxV0RQSU02STYvMnBXL2FXRUlFYTN3?=
 =?utf-8?B?QUloc0ZnRGE2Z2RJV0xYVVYvSWluV1grT04wZVpIeEVablRKdW9pVUtPaXZs?=
 =?utf-8?B?RUU1dnE4N2h1SFBKc09odXpHUElWZkV0aU13ZVpHRjF5YnlzVVJ5OTRqbjF2?=
 =?utf-8?B?MkFtMGtSRXZEN1d2b0JyTGN3dE5iUkRPcmlEYVpwQUxtV0J4K3daeXE5dGxZ?=
 =?utf-8?B?bEVaL1lFeC9sRXcrQ04zWUxnSlRLS29ZQ1FVcUhFK3ZLbVZ0YmRMdnk5NU5N?=
 =?utf-8?B?L3hvTk1iM3F6bjBUTWVrRk5PY25Fa2QybHBIOFRyL1NiVzRhMHNMcHVVcVI3?=
 =?utf-8?B?OVNqVHpjT2FNT2RTUU9DZTI5V0RTMy8rTVo2MHhHc1pDR3VYUjRSMjBkY2VZ?=
 =?utf-8?B?V01TUUlqZVNDVWwxbncyclUrdFNlM0p3OE1sQlNHbTBTd0kzTmRxMEtlZmFv?=
 =?utf-8?B?eUVpelVCT2ZFbURxT2Q4UTVXVmRVRmljUjViemIwenozQnFKVVUwZi9TN2l5?=
 =?utf-8?B?b0t1WENlRXBmWUxrczFoKzk0Rmk3Y1NUOE1JTDFmTzBRM0d6dksvblpSRkVo?=
 =?utf-8?B?cGhJbUpHMklkRXRzbVhoQUVRdklJeFptZ2dTWmFRd0ZBWThrazBORm1OenBE?=
 =?utf-8?B?clVwanZUWUswVjFYaGxOZzR6RkdqUUFoeFMzMTk4bjk1UHlPUmdlV1lIRE9D?=
 =?utf-8?B?Z1QvTGladDRIQ1JsVEMrMCtPKzJ0NzFWNXAxaHJDTUxaUktUQ1dkb1pDTGVz?=
 =?utf-8?B?YXB2UXlnTUNzTitaaG1QMFJHSnhnTkF0bzJVbTdiMmM2UmpiNEIvam14WnQy?=
 =?utf-8?B?aDkvMU5CdnpzNnFFSklJTUwwVTlFY1JaYXBjNHJmVUhudm9rUzA5RXUyWUhl?=
 =?utf-8?B?UWQ2aVNTTERadjlncGErSnlIZ2RWMVBqUjhEQUk5aXBOYkRERC9oUEFwQ2ZL?=
 =?utf-8?B?dnJsZG9Ielo4bUNqbjRkVXJFWVdkZkV2VEhwRXpmRWp3UmF1b3g3M1laWFRC?=
 =?utf-8?B?bkszdkRRcjZYUDdEcGlENDJHa3gxUFM5SnFLbThIK2FrUFJNY0ZPVFNiN3Jx?=
 =?utf-8?B?eVk1aE82TXVFQUp5SXExQ1JPcDVpRTJiVURPSHFKQWNibXlLalpvUHRONC9E?=
 =?utf-8?B?VU4zUkwzUUFLZTE2MjNwT3JZQzJRMXJMVmhjTkpBNEE1VlhhZDNSQ2dFODRK?=
 =?utf-8?B?VmdWcFV5NUFIbERNQ0V2Y1FYOUMxU3duRHlKcWxtdnBzN2lwYkhUWk5DRW0y?=
 =?utf-8?B?cStHQ0d0V2Fydk9FcVFpelJCeXlOTnNVYS9Rbk8yQ2tYcnZDZjF4MlJvSUJw?=
 =?utf-8?B?M2pPYzN6MGVLbzJUVFNSSUx0SldETE9xSTd6TCtWVXFhQWNZU281Zk52SndJ?=
 =?utf-8?B?TGRkbGhNOXBOTEgvMTVueHVJcTBzcm5oVHlLUTBFMVlIMXpNU1g3cC9CWTNH?=
 =?utf-8?B?K3I5dkMxWXRCMXJKK2RNVVdjWHY3aWlYaE4wSzNLZDBkT3Uyb3gxSjlvWmtX?=
 =?utf-8?B?MzFTN0hwQmx5MnozMDAwTGk3RmVyKzZJeVFidjN3WFU5VEVIb0p1Qzh2VGNO?=
 =?utf-8?B?NG5sVkRJZzlndlN2THBoTUVWTHBnSEJqaGh4aHFpcWpBSVhXY1B4QTFYZE5U?=
 =?utf-8?B?QkNhalIrWUtaaGQvWk95eVpkNENZNjlycFpuTFE1eE83Y2RubUJZY2JDWlNU?=
 =?utf-8?B?UzhjSU43TUpscXhwTHJSQ0cxakM3ZUhlN3VvYjJjUlNmbmtrcWhwVVUvS2dP?=
 =?utf-8?B?dktSWkJkYUhnK0tyNWxyUTBlRGl6Uyt0ckE0dXBOd0lMVC82TXVZYXJINUxu?=
 =?utf-8?B?UEczc29qWE5lRk1qWVJKbVgySTJ3SWxQU1A3N0hHeU80anl5aW5lckpObHJh?=
 =?utf-8?B?eDdmS0cwUDJNeCtZVEo1WGxJVWZzNlJ0WjRVZlBoMXJYRU10ZjB4L1c5TGE4?=
 =?utf-8?B?VTQ4QThSaHVyeXdWdG9YbURxcGp0enRGaEZSYURsQ2tzV09lQVJSV1ZWVTRy?=
 =?utf-8?B?UUl2V1BKMU9SQU1SQ3lDLzhpeEFxdzhaTmF6OHlOV1htWHZUU1VqQkpSZ0Zj?=
 =?utf-8?Q?VLCw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81e9e59-e282-4526-5de1-08dd2b825a59
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 23:08:21.9264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YGx0LrDM+NGtLTGO6Znv2v42PtwY14rdQZqv4ATkWt2N//5Rw32EdZYZtfdzwbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

--------------qv5mBrnZc6NVHvk28sVfXQ4Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/1/2025 11:36 PM, Jiang Liu wrote:
> On error recover path during device probe, it may trigger invalid
> memory access as below:
> 024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
> 2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
> 2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> 2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
> 2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
> 1f 44 00 00 55 <80> bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
> 2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
> 2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
> 2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
> 2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
> 2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
> 2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
> 2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
> 2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
> 2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> 2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
> 2024-12-25 12:00:54 [ 2703.935444] Call Trace:
> 2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
> 2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
> 2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
> 2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
> 2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
> 2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
> 2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
> 2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
> 2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
> 2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
> 2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
> 2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
> 2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48
>
> Signed-off-by: Jiang Liu<gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b6c5ffd4630b..58c1b5fcf785 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
>   
>   	for (i = 0; i < num_nodes; i++) {
>   		knode = kfd->nodes[i];
> +		if (!knode)
> +			continue;

I wonder how knode can be null here? kfd_cleanup_nodes is called by 
kgd2kfd_device_exit under condition if (kfd->init_complete). 
kfd->init_complete is true only after all kfd node got initialized at 
kgd2kfd_device_init. If kfd driver init fail kfd->init_complete would be 
false, then kfd_cleanup_node would not get called.

Regards

Xiaogang

>   		device_queue_manager_uninit(knode->dqm);
>   		kfd_interrupt_exit(knode);
>   		kfd_topology_remove_device(knode);
> @@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   		kfd_doorbell_fini(kfd);
>   		ida_destroy(&kfd->doorbell_ida);
>   		kfd_gtt_sa_fini(kfd);
> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
> +		if (kfd->gtt_mem) {
> +			amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
> +			kfd->gtt_mem = NULL;
> +		}
>   	}
>   
>   	kfree(kfd);
--------------qv5mBrnZc6NVHvk28sVfXQ4Z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 1/1/2025 11:36 PM, Jiang Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">On error recover path during device probe, it may trigger invalid
memory access as below:
024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-25 12:00:53 [ 2703.809188] RIP: 0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 00 00 0f
1f 44 00 00 55 &lt;80&gt; bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 65 df 9d f4 8b
2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: 00010202
2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: ffff97ad689a3ff0 RCX: 0000000080400014
2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: ffff97ad627e93d8 RDI: 52445f4749464e4f
2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: 0000000000000000 R09: ffffffffb5814c00
2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: 0000000000000001 R12: ffffb5313df07e98
2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: 0000000000000001 R15: 0000000000000000
2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) GS:ffff98a93ec80000(0000) knlGS:0000000000000000
2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: 000001008fc50001 CR4: 0000000002770ee0
2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
2024-12-25 12:00:54 [ 2703.935444] Call Trace:
2024-12-25 12:00:54 [ 2703.938962]  amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
2024-12-25 12:00:54 [ 2703.946080]  amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 [amdgpu]
2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 [drm]
2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 [amdxcp]
2024-12-25 12:00:54 [ 2703.983906]  __do_sys_delete_module.constprop.0+0x138/0x2a0
2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
2024-12-25 12:00:54 [ 2704.001166]  entry_SYSCALL_64_after_hwframe+0x62/0xc7
2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0
00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 d8 64 89 01 48

Signed-off-by: Jiang Liu <a class="moz-txt-link-rfc2396E" href="mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b6c5ffd4630b..58c1b5fcf785 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsigned int num_nodes)
 
 	for (i = 0; i &lt; num_nodes; i++) {
 		knode = kfd-&gt;nodes[i];
+		if (!knode)
+			continue;</pre>
    </blockquote>
    <p>I wonder how knode can be null here? <span style="white-space: pre-wrap">kfd_cleanup_nodes</span> is called
      by kgd2kfd_device_exit under condition if (kfd-&gt;init_complete).
      kfd-&gt;init_complete is true only after all kfd node got
      initialized at kgd2kfd_device_init. If kfd driver init fail&nbsp;
      kfd-&gt;init_complete would be false, then <span style="white-space: pre-wrap">kfd_cleanup_node would not get called.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <p><span style="white-space: pre-wrap">Regards</span></p>
    <p><span style="white-space: pre-wrap">Xiaogang
</span></p>
    <blockquote type="cite" cite="mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com">
      <pre wrap="" class="moz-quote-pre">
 		device_queue_manager_uninit(knode-&gt;dqm);
 		kfd_interrupt_exit(knode);
 		kfd_topology_remove_device(knode);
@@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&amp;kfd-&gt;doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+		if (kfd-&gt;gtt_mem) {
+			amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, &amp;kfd-&gt;gtt_mem);
+			kfd-&gt;gtt_mem = NULL;
+		}
 	}
 
 	kfree(kfd);
</pre>
    </blockquote>
  </body>
</html>

--------------qv5mBrnZc6NVHvk28sVfXQ4Z--
