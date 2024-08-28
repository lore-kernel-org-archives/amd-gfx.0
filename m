Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A2C7114C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 22:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD72710E084;
	Wed, 28 Aug 2024 22:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x8uxXBvy";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA8210E084
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 22:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9pkJROx4UDJ9rpQ1hCshtcBcq9sZW/2ojudyYQcOzWH/NB9ZN5HdezRODSlrbimVjEY/w86eXUgw4Y6LQoLvbAjeYXqiGf3D0HwEshjEx6UMfqnWX4b2Jteq5b9vFvumRmE7NHYkEhAj2eyGFrDK/yjgnhcZENB2TWmAdLoMuZtYaZHlxSQIR9Esj2jmJcGeBITLbCHCJ2gZV2PjVWWjGk0z8flsNGYlNDOb/lBNeu7A7OO5O5gmUJrKBsHKLTdLt1JKlDij/B+Va6jxoGEIXMYmwzSj9LViI4GcqzPl3wLaR7Xs1pG/mlKYrqponVbTzYDEwB+QxTAEFfWhPkZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwFrgQB/MRHPrhOQBS3laFKYOKzjh/pd4Jz3dKI0S1c=;
 b=vki7faIe4J6Mg/VWyiM89pZxZYXZwjYquEiaPB+GlyuOwJvHs6eBJXfu8ahaf6r5kwyziDpJZKjwvjaImSsJaebrjJtRTALAhq4LQRaK6GIu+AwJOKyOdVwuAhCkuM3rEW4sKN0IjSpW0DWwzI/eK8EAQMVIpw2K3GFTi0v5es/8Bs9tq6nxIQOtwaf2yni9yahbkgqVqb2io+F5uY3BACbzF8Sbnt0k8TxSpJw9LFi3RgzXALRKh5Ty7YTdm59/P9OqUItXR8litWdGNNUtKPpInfvA+CG3jU+H6MxkAoDWKeMxSwNPsFJMzM9j+jtL7q6490ADJb6uuEmv9+NWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwFrgQB/MRHPrhOQBS3laFKYOKzjh/pd4Jz3dKI0S1c=;
 b=x8uxXBvyO7cFKtjDtznj/q23eQ/GX4xFHF5ZXhQyBiJASrx41iI1yM/TADj+ZIW/php+4aha1mHTB3aDFxvDZNcl7NF2CUF7AoZGgc32pC5LjQ8KnHUbf6josCfzNeQJJgoGWv2ZwJf4uHo4qwPK0+EVFWInyx3IWic2Klncics=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:29:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 22:29:43 +0000
Message-ID: <f603ba98-d360-4195-8fa5-50ecf9b54899@amd.com>
Date: Wed, 28 Aug 2024 18:29:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: re-work VM syncing
To: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240821120324.4583-1-christian.koenig@amd.com>
 <2e24ab52-c5cc-4991-b610-df0681410229@amd.com>
 <7b911fc5-a186-441c-9648-1429f8be0e2d@gmx.de>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <7b911fc5-a186-441c-9648-1429f8be0e2d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a3a435-31d4-4926-2490-08dcc7b0ea35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXRaUmVPQVlFV0dmSmRwT3RpbTFSWlp5QkFSaXJGaWRiNCs1NHNvcXZuK05s?=
 =?utf-8?B?akttaWgxejRVVW9pMmZ1cDg3dnVteGo3ZTVPY3BsUkh1eHZsVTZkV1N0QkVj?=
 =?utf-8?B?S05BY2MxV3ZXblhabFBzZVQrL3VJM0JNRG4rV0NubFVIWG1NbERKRjgyN1or?=
 =?utf-8?B?czZHaWt3citnNTR6WndXTUU3UDJNVDRvNThsUEhiVzlIYjV0b1pjSHRuWXVj?=
 =?utf-8?B?Yis3N2ZKWVFSTEtPLzhkQ1BWdWhPdnN3ZGVkYmhjeVBETkZGTndJWTd3RDRk?=
 =?utf-8?B?TWNVd1phVlI2OEQ0MlZScDRueFVlbUIwd0VPWG5DM0dZeHJzMERIZVlnTWto?=
 =?utf-8?B?NGFrby9Xb2FtYUtHUHFPYUVmQ1dkMUo3b25qbkdDdzJpaXNMNi9NcTBoYzZS?=
 =?utf-8?B?RHRKb2pDYldKZXhjYzNFTlRuZ2JzSjBxcmt1R0Fzd0oyWmdyeFI3OHZ1RlND?=
 =?utf-8?B?aGliZ2xvektkOEtvSURBbmhDSkxEcC9zVlJoZEFnOHBaSEd0OXFpWU13R3Zz?=
 =?utf-8?B?NnhKcEJ0WTdQTUFPZG16b21BUXI1RWNvcDBia0tIQzNUVnplRWhrZCtVTVI1?=
 =?utf-8?B?djN6aGtzVnc5NFRVRjFHTGcwT3RZNGt3UmVENU1OSnpEQXp4bmlhUUYyRGpM?=
 =?utf-8?B?RmRQRGlYaWdxcDdkK1NTOHMzSUxDYkFURTVtZkZ0SjhYcU5ybjRBQUwwZzhN?=
 =?utf-8?B?WHFUM0NZdEJXRUszbXdHdXYzYmZSUmpVUlB6dzhlaDlOcGF4OWJtRFd2WWpD?=
 =?utf-8?B?ZE9GdVJ5Q1ZVcWZuWkVUYXBPaUpPWmZSeE1hcnFZWitrT2RYcHdkdUhyVnln?=
 =?utf-8?B?NUhrZGEvanlkWVhNNTdEWWdjeGRVc0JzVG93WjcxWVl5SXgrN2hmdmZOcFFO?=
 =?utf-8?B?dFVWenRQZnBBM3RCcEFpeHozcnM1SjJKRnR6cEp0anZPS3YyY3hPTGxNNjRL?=
 =?utf-8?B?Q1l5Z042VlhJeEN1MWkzQkVIQmlkd3hBWmNjbG5ZWDBNdXV1M2xNMVRMYjJP?=
 =?utf-8?B?SXBXS014WGZCL3VLNWhRSDVxL2VkbnZicWYvVVVONVlJcmpyMVU0S2F5dWhE?=
 =?utf-8?B?RThLTjBPRXVrT3ArR1I4NEtRVXFtTjRtbDBUY0UrL0dGK2xBYUNkL2ZLeWdP?=
 =?utf-8?B?b1BDeDZYQyszbWdvM0tqdWMycm45aUY3c1VkMGFGamdVR1FNSkRLdzFPbGUy?=
 =?utf-8?B?M25nYU91czZwNG5tdXVrVyszVGIzMlk1REZ4SzlNc3ByajVSbERNRFBKTTZ6?=
 =?utf-8?B?akJpQzBmbWdlMmJIRW9EUWxDQlhUOFBvMUdXbEF1b1hqVGVzb1hlcGFEU21z?=
 =?utf-8?B?ZmlpbVpLaWNzL3hPZFAzVmRLNHlhYzR3dmVzQkIwMGZNUHBnM0JnZTNhYk9W?=
 =?utf-8?B?ZHBRQXJoMUFobi81TWhsS2ZNbVJqRVFCVEwxVU1nSWFNMVlVVEJqWDJnZGZM?=
 =?utf-8?B?a1htQUFmaHhXSG5XY3ZtOUJTVXNDTzhqZmFSVnhKUmRSNm9YTTIxZWJ4aDNx?=
 =?utf-8?B?eld3eEcyOGRvNHFCQktYWXEzVXoxVHBHZ0p5dk12ckUvMVlRZFFNQ09YZ3NJ?=
 =?utf-8?B?YjRpbkpYbHI2b1R6ZjhISDg5eGRVczRFRVRUZGpnTnphYUZ4cTJFaWRVei8w?=
 =?utf-8?B?c2hPTmJuQ0VUbE9UeFdtUEtjWGl0V3VuNGMyeVBoaEtGbklyUHhydFNJOWN3?=
 =?utf-8?B?elRxSnNqVFZVeSs1RmZOT0Mwc0NZUksxLzlIc2EvMHZYYjR1eHlqQ3haQkdV?=
 =?utf-8?B?dllGQ2RTZm54UnN2RUtxNW1KNkxQek5mUndLV3ROVTU3Sksxa21hbG1oWDh2?=
 =?utf-8?B?NDBSWTErbmVZbzI4V1BtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1lvOVJnU0Uvb3c1U3lpcW5ORVNHOTZvMlR2a2U1Q0dWSjFGcklNT1Zlekh5?=
 =?utf-8?B?bWNtTEpCTE5aTURmOGIyWEFOS1VVZGVwWUg0S2NkQjk5eTJRT3BQNlZZZXNC?=
 =?utf-8?B?T3BkS1ZFcytyeGJNMXpmVndKamh5MHVvbU9RY2xKUDlSWHQvUGQyK2N3OUtF?=
 =?utf-8?B?UWVDWHNYbmpSWmNRcEtZL3ppdU5QcG5sWmxWRDhHYjJ1U1gwQVJtcjBINDJ4?=
 =?utf-8?B?cFFESWk2aVRyRG9DOUI5OHcrbGtFcFhqRksvd2FRWmwwSllQaERoTnZlS0hK?=
 =?utf-8?B?bVZ5emIwcCtQd0FkdHV2aVoxN2xYdGRtUmMrNWNBdCtBcnFDTERER3UxTUI4?=
 =?utf-8?B?bDJ6dmlVMGhDSlREM29ISTg0dnFsdGREeW9waGxqUlF6VU1rNm0vSmRqdlpY?=
 =?utf-8?B?Y2RsRC9jeDNsUGJsVm5yVlhQN1B6Tll0eDA4Ym9XQ0JuMDd2V0cwa3BzcTVx?=
 =?utf-8?B?d2FabUxpczhva3BUUGltMGxKSE5DNE5mSENYVW5FdlZMNVUrWlUxYWUvRVRm?=
 =?utf-8?B?NlJYRWF2MDNieUNzLzRFQ1hCUCtwTktMa01IK0lNSnZxUXV1c1h6b3hZUmZH?=
 =?utf-8?B?UUNlVTF5MEQ2ZEVwRmt3L3lTK1VNOE0yVC9tQTN1U2N1L2hvQUtRL1Eyb1l4?=
 =?utf-8?B?YnhabTdUSm9OSElPc3VDaWcvNmpXV20yZWxqRTRqNVQ0aWV3L25acVZ2OHMv?=
 =?utf-8?B?WTJ0NjlzdWdqKzh6QkRJQ1hnL2VJcVZXNm44NEhpVUlvRVBNOGhGU2wxREQ1?=
 =?utf-8?B?MjF6Z0llc3llZEROMmhCaTl3ZkFiR3VFNkRBakdEejJON2YyMlcvaTlXa0dv?=
 =?utf-8?B?cWJrajVXMXlUaGFUb2xiSU9pZC8xR3NQY0d6dmM4b0x0Y0FZYWx6RUd1QzA2?=
 =?utf-8?B?clgwc0w4c0VIVlplODZOamw4dzc4RTAwNXFRT0tKc05wakx3eWxwUUlXdGRM?=
 =?utf-8?B?eXkwN1RrSWF6bGdwS3BMSmFWUHZia1NrOFd1NGhzdWp0N25DaDU4YS9sZUEr?=
 =?utf-8?B?N3lxV0tYeEwrVVlGR1FmWDN4V244Wkp4L09jT3JmdDBURFZBN2pSN3BJMG05?=
 =?utf-8?B?UDZaRUl3M05RamdDOUZYVE9ZN0s4YkhQK1dKRlNVdDFFWFhZMFExSzloZTJS?=
 =?utf-8?B?cDBra1FEVTVnaVZ0dzZIWHVST2lYU2N2RlRtaUJzVEVleEFHYWVXMEFvdkUw?=
 =?utf-8?B?M0Q5OGNUNWk1ajdhWW1HZ2daVUxNdmJNMTN0ZEV2YnQ4RXU3TjBzaHppTEFJ?=
 =?utf-8?B?RUM1cXJ0ZTdJdHIyRUk5Q05LWkpldVpNK3hCWjAvYVJuZitvVXJyQ2NSWFZ3?=
 =?utf-8?B?QUV3eGtHWkdqOTlScHd6TjZoWnExSHFUcXhqZ1k0Vk9oYk1XS1cvczZpWFpM?=
 =?utf-8?B?Q2dzOUkwWmYxSnRFaW0xYU9DRCtDZks1YzltYWpjaE1FeVo5RFUxaUQxYU5s?=
 =?utf-8?B?c2pnN25KMndLZ0F5QkxDMDNDL2R2ZWZPRFo5VEo0MDdGVkl2a21xZnJsWEZ0?=
 =?utf-8?B?RU1tc09VdkxPVzFldUI4ZldDUnIrUEsrZ2NveVpTQkswMzZYeXpzVHJtNGVZ?=
 =?utf-8?B?RXplSThaS0E3QVgvWEt6Q29XVFNBV3dGMjBNdnpkNEVHcDQrejVlRDcyQWRM?=
 =?utf-8?B?dHJMcnpyT28zUHNKaTVmMmhmRnFyYWI2d1AxdmpxU1R3dFZVMU1ZVXRKbnBw?=
 =?utf-8?B?UG1UbkdXeEZTQzh4am8wTHErRHQvalhoZFQ4enFpQTlOQ201dUEyNW9EMWhk?=
 =?utf-8?B?VkxBWCtnUDhoamMxMmJqN0hqSzlPR2hmRnNCck9DOU12cGJCRkk3R3lZSlFz?=
 =?utf-8?B?cTl3dnhLM0o0NTZnemtxZDhmakJsWkZzYkpmNVkwUDVldy9xdklOVFlGLzRn?=
 =?utf-8?B?L01Haml3Q0psUUdUcERDNk4xRWVUbkIvYUF5U0lGb1p2dDFJNXlXVDV4Y2k5?=
 =?utf-8?B?d0NnNk9XbGdQS3BCNmtGOUN4M1VuNThpYmNLbTlCZlFYcFRGUzNkZ0szUlkw?=
 =?utf-8?B?S1RnRWNuVUlYMmpZVUVkeEpoMytoOXBZcWZHZzVBdUt3R1RTT3BXY0QvYVd3?=
 =?utf-8?B?ZnREc3h5b0d4Z2EwRmlrYzVzdG5RZXlWNVNISEtzK0Z1a2NHZ2l2ODZSU0Mz?=
 =?utf-8?Q?1xTOzIVT8woZDQDFaH3tyvP9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a3a435-31d4-4926-2490-08dcc7b0ea35
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:29:43.8985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXxW25Vu5eEZZzNfqtblSblo/fe2YVHvVPVVRxK3uVndeenPHUp1U98JIl6tER53xuzdGgunz1UYkW1tFRa6yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236
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


On 2024-08-22 03:28, Friedrich Vock wrote:
> On 21.08.24 22:46, Felix Kuehling wrote:
>>
>> On 2024-08-21 08:03, Christian König wrote:
>>> Rework how VM operations synchronize to submissions. Provide an
>>> amdgpu_sync container to the backends instead of an reservation
>>> object and fill in the amdgpu_sync object in the higher layers
>>> of the code.
>>>
>>> No intended functional change, just prepares for upcomming changes.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 84 
>>> +++++++++++++--------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 11 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  7 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 +---
>>
>> There are two calls to amdgpu_vm_update_range in amdkfd/kfd_svm.c 
>> that would need to be updated as well.
>
> I don't think any change should be needed there? Both calls pass NULL 
> for the resv.

Right, sorry, the change to the function signature looked bigger than it 
was due to formatting changes. The patch is

Acked-by: Felix Kuehling <felix.kuehling@amd.com>


> All this patch changes is that we're now passing NULL for the 
> amdgpu_sync - but the behavior with a NULL amdgpu_sync with this patch 
> is the same as with a NULL dma_resv without this patch, so nothing 
> needs to change.
>
> Regards,
> Friedrich
>
>>
>> Regards,
>>    Felix
>>
>>
>>>   5 files changed, 65 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index bcb729094521..ba99d428610a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -838,7 +838,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device 
>>> *adev,
>>>       params.vm = vm;
>>>       params.immediate = immediate;
>>> -    r = vm->update_funcs->prepare(&params, NULL, 
>>> AMDGPU_SYNC_EXPLICIT);
>>> +    r = vm->update_funcs->prepare(&params, NULL);
>>>       if (r)
>>>           goto error;
>>> @@ -933,7 +933,7 @@ amdgpu_vm_tlb_flush(struct 
>>> amdgpu_vm_update_params *params,
>>>    * @unlocked: unlocked invalidation during MM callback
>>>    * @flush_tlb: trigger tlb invalidation after update completed
>>>    * @allow_override: change MTYPE for local NUMA nodes
>>> - * @resv: fences we need to sync to
>>> + * @sync: fences we need to sync to
>>>    * @start: start of mapped range
>>>    * @last: last mapped entry
>>>    * @flags: flags for the entries
>>> @@ -949,16 +949,16 @@ amdgpu_vm_tlb_flush(struct 
>>> amdgpu_vm_update_params *params,
>>>    * 0 for success, negative erro code for failure.
>>>    */
>>>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> -               bool immediate, bool unlocked, bool flush_tlb, bool 
>>> allow_override,
>>> -               struct dma_resv *resv, uint64_t start, uint64_t last,
>>> -               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>> +               bool allow_override, struct amdgpu_sync *sync,
>>> +               uint64_t start, uint64_t last, uint64_t flags,
>>> +               uint64_t offset, uint64_t vram_base,
>>>                  struct ttm_resource *res, dma_addr_t *pages_addr,
>>>                  struct dma_fence **fence)
>>>   {
>>>       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>>>       struct amdgpu_vm_update_params params;
>>>       struct amdgpu_res_cursor cursor;
>>> -    enum amdgpu_sync_mode sync_mode;
>>>       int r, idx;
>>>       if (!drm_dev_enter(adev_to_drm(adev), &idx))
>>> @@ -991,14 +991,6 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>       params.allow_override = allow_override;
>>>       INIT_LIST_HEAD(&params.tlb_flush_waitlist);
>>> -    /* Implicitly sync to command submissions in the same VM before
>>> -     * unmapping. Sync to moving fences before mapping.
>>> -     */
>>> -    if (!(flags & AMDGPU_PTE_VALID))
>>> -        sync_mode = AMDGPU_SYNC_EQ_OWNER;
>>> -    else
>>> -        sync_mode = AMDGPU_SYNC_EXPLICIT;
>>> -
>>>       amdgpu_vm_eviction_lock(vm);
>>>       if (vm->evicting) {
>>>           r = -EBUSY;
>>> @@ -1013,7 +1005,7 @@ int amdgpu_vm_update_range(struct 
>>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>>           dma_fence_put(tmp);
>>>       }
>>> -    r = vm->update_funcs->prepare(&params, resv, sync_mode);
>>> +    r = vm->update_funcs->prepare(&params, sync);
>>>       if (r)
>>>           goto error_free;
>>> @@ -1155,23 +1147,30 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>       struct amdgpu_bo *bo = bo_va->base.bo;
>>>       struct amdgpu_vm *vm = bo_va->base.vm;
>>>       struct amdgpu_bo_va_mapping *mapping;
>>> +    struct dma_fence **last_update;
>>>       dma_addr_t *pages_addr = NULL;
>>>       struct ttm_resource *mem;
>>> -    struct dma_fence **last_update;
>>> +    struct amdgpu_sync sync;
>>>       bool flush_tlb = clear;
>>> -    bool uncached;
>>> -    struct dma_resv *resv;
>>>       uint64_t vram_base;
>>>       uint64_t flags;
>>> +    bool uncached;
>>>       int r;
>>> +    amdgpu_sync_create(&sync);
>>>       if (clear || !bo) {
>>>           mem = NULL;
>>> -        resv = vm->root.bo->tbo.base.resv;
>>> +
>>> +        /* Implicitly sync to command submissions in the same VM 
>>> before
>>> +         * unmapping.
>>> +         */
>>> +        r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
>>> +                     AMDGPU_SYNC_EQ_OWNER, vm);
>>> +        if (r)
>>> +            goto error_free;
>>>       } else {
>>>           struct drm_gem_object *obj = &bo->tbo.base;
>>> -        resv = bo->tbo.base.resv;
>>>           if (obj->import_attach && bo_va->is_xgmi) {
>>>               struct dma_buf *dma_buf = obj->import_attach->dmabuf;
>>>               struct drm_gem_object *gobj = dma_buf->priv;
>>> @@ -1185,6 +1184,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>           if (mem && (mem->mem_type == TTM_PL_TT ||
>>>                   mem->mem_type == AMDGPU_PL_PREEMPT))
>>>               pages_addr = bo->tbo.ttm->dma_address;
>>> +
>>> +        /* Implicitly sync to moving fences before mapping anything */
>>> +        r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
>>> +                     AMDGPU_SYNC_EXPLICIT, vm);
>>> +        if (r)
>>> +            goto error_free;
>>>       }
>>>       if (bo) {
>>> @@ -1234,12 +1239,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>           trace_amdgpu_vm_bo_update(mapping);
>>>           r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
>>> -                       !uncached, resv, mapping->start, mapping->last,
>>> -                       update_flags, mapping->offset,
>>> -                       vram_base, mem, pages_addr,
>>> -                       last_update);
>>> +                       !uncached, &sync, mapping->start,
>>> +                       mapping->last, update_flags,
>>> +                       mapping->offset, vram_base, mem,
>>> +                       pages_addr, last_update);
>>>           if (r)
>>> -            return r;
>>> +            goto error_free;
>>>       }
>>>       /* If the BO is not in its preferred location add it back to
>>> @@ -1267,7 +1272,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
>>> *adev, struct amdgpu_bo_va *bo_va,
>>>               trace_amdgpu_vm_bo_mapping(mapping);
>>>       }
>>> -    return 0;
>>> +error_free:
>>> +    amdgpu_sync_free(&sync);
>>> +    return r;
>>>   }
>>>   /**
>>> @@ -1414,25 +1421,34 @@ int amdgpu_vm_clear_freed(struct 
>>> amdgpu_device *adev,
>>>                 struct amdgpu_vm *vm,
>>>                 struct dma_fence **fence)
>>>   {
>>> -    struct dma_resv *resv = vm->root.bo->tbo.base.resv;
>>>       struct amdgpu_bo_va_mapping *mapping;
>>> -    uint64_t init_pte_value = 0;
>>>       struct dma_fence *f = NULL;
>>> +    struct amdgpu_sync sync;
>>>       int r;
>>> +
>>> +    /*
>>> +     * Implicitly sync to command submissions in the same VM before
>>> +     * unmapping.
>>> +     */
>>> +    amdgpu_sync_create(&sync);
>>> +    r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
>>> +                 AMDGPU_SYNC_EQ_OWNER, vm);
>>> +    if (r)
>>> +        goto error_free;
>>> +
>>>       while (!list_empty(&vm->freed)) {
>>>           mapping = list_first_entry(&vm->freed,
>>>               struct amdgpu_bo_va_mapping, list);
>>>           list_del(&mapping->list);
>>>           r = amdgpu_vm_update_range(adev, vm, false, false, true, 
>>> false,
>>> -                       resv, mapping->start, mapping->last,
>>> -                       init_pte_value, 0, 0, NULL, NULL,
>>> -                       &f);
>>> +                       &sync, mapping->start, mapping->last,
>>> +                       0, 0, 0, NULL, NULL, &f);
>>>           amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>           if (r) {
>>>               dma_fence_put(f);
>>> -            return r;
>>> +            goto error_free;
>>>           }
>>>       }
>>> @@ -1443,7 +1459,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device 
>>> *adev,
>>>           dma_fence_put(f);
>>>       }
>>> -    return 0;
>>> +error_free:
>>> +    amdgpu_sync_free(&sync);
>>> +    return r;
>>>   }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 046949c4b695..1a759012ce93 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -304,8 +304,8 @@ struct amdgpu_vm_update_params {
>>>   struct amdgpu_vm_update_funcs {
>>>       int (*map_table)(struct amdgpu_bo_vm *bo);
>>> -    int (*prepare)(struct amdgpu_vm_update_params *p, struct 
>>> dma_resv *resv,
>>> -               enum amdgpu_sync_mode sync_mode);
>>> +    int (*prepare)(struct amdgpu_vm_update_params *p,
>>> +               struct amdgpu_sync *sync);
>>>       int (*update)(struct amdgpu_vm_update_params *p,
>>>                 struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
>>>                 unsigned count, uint32_t incr, uint64_t flags);
>>> @@ -505,9 +505,10 @@ int amdgpu_vm_flush_compute_tlb(struct 
>>> amdgpu_device *adev,
>>>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>>>                   struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>>>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm,
>>> -               bool immediate, bool unlocked, bool flush_tlb, bool 
>>> allow_override,
>>> -               struct dma_resv *resv, uint64_t start, uint64_t last,
>>> -               uint64_t flags, uint64_t offset, uint64_t vram_base,
>>> +               bool immediate, bool unlocked, bool flush_tlb,
>>> +               bool allow_override, struct amdgpu_sync *sync,
>>> +               uint64_t start, uint64_t last, uint64_t flags,
>>> +               uint64_t offset, uint64_t vram_base,
>>>                  struct ttm_resource *res, dma_addr_t *pages_addr,
>>>                  struct dma_fence **fence);
>>>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>>> index 3895bd7d176a..9ff59a4e6f15 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>>> @@ -46,13 +46,12 @@ static int amdgpu_vm_cpu_map_table(struct 
>>> amdgpu_bo_vm *table)
>>>    * Negativ errno, 0 for success.
>>>    */
>>>   static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
>>> -                 struct dma_resv *resv,
>>> -                 enum amdgpu_sync_mode sync_mode)
>>> +                 struct amdgpu_sync *sync)
>>>   {
>>> -    if (!resv)
>>> +    if (!sync)
>>>           return 0;
>>> -    return amdgpu_bo_sync_wait_resv(p->adev, resv, sync_mode, 
>>> p->vm, true);
>>> +    return amdgpu_sync_wait(sync, true);
>>>   }
>>>   /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> index e39d6e7643bf..a076f43097e4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -403,7 +403,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device 
>>> *adev, struct amdgpu_vm *vm,
>>>       params.vm = vm;
>>>       params.immediate = immediate;
>>> -    r = vm->update_funcs->prepare(&params, NULL, 
>>> AMDGPU_SYNC_EXPLICIT);
>>> +    r = vm->update_funcs->prepare(&params, NULL);
>>>       if (r)
>>>           goto exit;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> index 9b748d7058b5..4772fba33285 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
>>> @@ -77,32 +77,24 @@ static int amdgpu_vm_sdma_alloc_job(struct 
>>> amdgpu_vm_update_params *p,
>>>    * amdgpu_vm_sdma_prepare - prepare SDMA command submission
>>>    *
>>>    * @p: see amdgpu_vm_update_params definition
>>> - * @resv: reservation object with embedded fence
>>> - * @sync_mode: synchronization mode
>>> + * @sync: amdgpu_sync object with fences to wait for
>>>    *
>>>    * Returns:
>>>    * Negativ errno, 0 for success.
>>>    */
>>>   static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
>>> -                  struct dma_resv *resv,
>>> -                  enum amdgpu_sync_mode sync_mode)
>>> +                  struct amdgpu_sync *sync)
>>>   {
>>> -    struct amdgpu_sync sync;
>>>       int r;
>>>       r = amdgpu_vm_sdma_alloc_job(p, 0);
>>>       if (r)
>>>           return r;
>>> -    if (!resv)
>>> +    if (!sync)
>>>           return 0;
>>> -    amdgpu_sync_create(&sync);
>>> -    r = amdgpu_sync_resv(p->adev, &sync, resv, sync_mode, p->vm);
>>> -    if (!r)
>>> -        r = amdgpu_sync_push_to_job(&sync, p->job);
>>> -    amdgpu_sync_free(&sync);
>>> -
>>> +    r = amdgpu_sync_push_to_job(sync, p->job);
>>>       if (r) {
>>>           p->num_dw_left = 0;
>>>           amdgpu_job_free(p->job);
