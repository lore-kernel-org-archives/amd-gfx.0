Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E33C369C2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 12:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9B510E8ED;
	Wed, 16 Apr 2025 12:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FsqPjQ/7";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9367D10E8ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 12:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7XgMUu8TWMpnZbOJE4ocYlEZmCTQH6mnwK5CzP05hLQKEE9pjDmY/kmAL10V+ESazj1oNAE7jin+9UWQ6ftwPsTe3qzSdOMdyeVsWdQsuqMIbzkeLmKPnl6z6mjRKkOWt7a88z8oiAGrzkuIiSnFbb1p3Z9cQpCwGSnKgAgmpNR1rWNnh97YjtH5yjab9wssDhHRUwXNQD/8uziB2eEAYaHzIxXbNLUOy0NIs+WlELxYlsCqXq1qBukE6kRQX+j2NbGOaKnW0VONutXxRf9UlDmiLcsXMkVw26uccR/JQuNbOZtkFYsWOmqnf2UCq93MTTIaKfAG3BIauUMSCYBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkEVMLkpnNfCJsz+s7RCx8Tbqbxft9goo0QRrV+Z14M=;
 b=EJ2mmnJrBMrnaDXVhsghqAETqiZJD/uBQP1QgY3ccdLi2bDhsivo3atYbk/t3eY3/7n5ADS5dV+wAgRMeLllNfSu1UfLhFEHNGJ5buZWHSm2PMszewKVu79YUwQ4f0gIkqoS+VdmL/a8o0KN+OCr/fYb4mCsn33FscgJBVaaBtAHl61848WDyPaFeHpmM4Tivymn7u73yky8/cac2P93zcS6m4/aGD97Uvtnry8FD8kWQ+b3wKevD1TWz/U5px71KyF5Qp/QUzrILR8Smmot59WqWPSffHVJUFZKJi9olQFcxiLjTrkqAAXhcW0QH6YmA0bONhGUxMCoMMGTMsS+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkEVMLkpnNfCJsz+s7RCx8Tbqbxft9goo0QRrV+Z14M=;
 b=FsqPjQ/7rq6TwhUvod9hiAwukmV8/sJpGyInsU5NLBWJ/odHYV4PO3HlKDivM9iY6VMi6mhVqv1+D+NTggpIhn3cwddDedVFirpjbAhAiLPBuGjxntesO/ccAtxXXoLx4me4bB1/zo8MK9h9C3zs9bkcdDX7JSoGO3MYlF5kAm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 12:58:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 12:58:16 +0000
Message-ID: <8d031f23-8a56-4d7e-af5b-834369742723@amd.com>
Date: Wed, 16 Apr 2025 14:58:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: add the evf attached gem obj resv dump
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <0ce0c2ef-f6d1-4d44-9d6e-ece14d17de45@amd.com>
 <DS7PR12MB6005B33759751C890186369CFBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005B33759751C890186369CFBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f76888-9bb6-4981-72b0-08dd7ce65a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFN5Q2w1S2RZMW9yay9xeWhWT1ovZjY5TlRnZzJVamVhbWF2L2o3SzlLMkpF?=
 =?utf-8?B?THFjWGYzNFpFdmNyNHpVQlFzZDA0ZFNzWHMwYWtaTnNjWmZ6UVBaSlFPS25s?=
 =?utf-8?B?ZWdpVUNyR0tZd1c3d2JabFR3SENhc1cwNzZscnBSeExIeG9sVGFZYnlibkVL?=
 =?utf-8?B?OE1aZUdsUFNqSW1SekxyWUFUZzEzNnhuRlFJNTNiWEhPcTFIVW5zbHJnZzQ1?=
 =?utf-8?B?ZC9MdFpYbFFpSWNMSEQ3WVQyVHFUZHRoZVIwQ2lKbzZwVjFCSmt2VDJ4YU9r?=
 =?utf-8?B?dU9GMFBzdWVTLzV6bU44K0xrVUdxbXdOdU1OOHJtWmFCQXhDUVRBc1dzWUNx?=
 =?utf-8?B?VEZVMlFIY3ZsZnJ1em52WnA4WXQ2MHNoSUpaVTlrU1JyTzFxTXpyUUIxNjlv?=
 =?utf-8?B?MmJheFBFTkpPTjJpbXEya0wrUXRIaFRQZlpzelVqa21tRkR1R1JjRXlTbm1r?=
 =?utf-8?B?TXRCaENWL3daSFR0VjdmTDRTR2tBdWJMMzJlRTArZzlpNWNrOXFaeWIxdEM5?=
 =?utf-8?B?NEh4WUtuRDZ1RkVRMFA4dVp4RmdJbVFETGZzVlh3NFR5T1VlY2YxZG41bTBT?=
 =?utf-8?B?ZzFNYWxVclJVbmUxc3k2RWVwUzFjY0g4ZCsrcy8vaFVpVDdna1krblJHZkkv?=
 =?utf-8?B?S1FGSlJwRlhPRUpqcTNOL1UrR3k3RFlvQXNiMkxFT0dsZzlwQUtoZTRQcnQ0?=
 =?utf-8?B?SVFsN2VpeStyRnM1b3IrdHIrT3lwaDdHdmJzZTZQMHlublYwb1JDNVBnQUtY?=
 =?utf-8?B?a0luc3VKQU9IeWNLS0JBanYrRUZpU3RTSEQzeko5RFQvN0JjVk9ZYTE2cnJE?=
 =?utf-8?B?b09UdzZ3WU5acUNaYldYcWovMXJMb3VvNTVsZUhNNlZCbkswUEs3cDNzTC9T?=
 =?utf-8?B?Zy9NSEF6Tmx1bFBLRHdqak96R3dOUHBsOGoxcE1SS2dIUU8zWG93aE5iM1Bu?=
 =?utf-8?B?YXBRSWFhRk41UFFqL05zckdGbFdGbU9oRDFkalhXQUt5dnhBL3dnQ09KUVRp?=
 =?utf-8?B?MXgzZFNrZFFkLzNwdTRpK0htbnFhTGlMd0E1ZTFiVTFlb1hkMDI4QjE5aHRj?=
 =?utf-8?B?UldaS3VLT20rc0JrT2NMZUVkdnJEbUpVZm05bnVQdHhBUlpNa2ZWSHdSOTBJ?=
 =?utf-8?B?alNXMU04bXdNSG5hVGdqMG12RU05eW9TY1NFb3BVbHhUWGtJTDVpQnA5U2FR?=
 =?utf-8?B?M2lZNUtQYzRPcmZaRWM3YmlRLzhVZ1hIckpjMGo0WXYrRjRQeUp3YkdZeHdm?=
 =?utf-8?B?akZSZG53U0tlTEQzUVJ1UHJ5NzJLcEtoMHBUV2xxUjZ6ajhubURWdGtHZWpi?=
 =?utf-8?B?WTFLRStuVDdzTG9yMHlmdnpDU3B2S3ZkNXZHN01nTXBYYTVBT0RBUjRhL1Rt?=
 =?utf-8?B?SnhsVENmaWsxa3ZvTkdNUVdlcHduc2I0UUYyNUNWMGJVOC9QOW05ZzhsYXhC?=
 =?utf-8?B?SEp0clJCSjFnY1FOSU5Ld0M2YVhqby85ZXk2dzNDSzlkaU90SUVhY3QyTTl6?=
 =?utf-8?B?ZkNiQXY4bk1MdDFzVFFDMTY0YmFvZlhybEp1UHNDci9RdGY2bkdTZWZhMFVQ?=
 =?utf-8?B?WlhnWkF4RWxoUmlhRmxTTW1WbGMvK3dLSmZ1T1NITEl3L0dtcGo4US9vMFBU?=
 =?utf-8?B?bGtJQVJqSzVjcENib0l1UlhFcWNXWlpFQXJSYzRDMHErMGtRUlkxdE5kYm9M?=
 =?utf-8?B?SHI4MlIrZjNHU2RCS013bGo5WWFKZ3VudzB6VzIrMEhoZnZzUU9ZYWlrcEEv?=
 =?utf-8?B?WERwMmNET0ZQb1BTRXZjYTF3VVYwdzNwRFgzVnZNRlRTdEQvOUs3QWlsUGwx?=
 =?utf-8?B?a1g5VGRTNWtnekswZzdRYUR6cldNR1hLL1VpSk5NREFwMnA1OWg0ZzJwdnUy?=
 =?utf-8?B?bTB3dzdud2IxS3I2aFdYZGVBOEJKNVVNWkxNL1FQTi9PaGxPTElTVE1Bbklr?=
 =?utf-8?Q?XMtY5arJfUA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVhHVUJnYk96Ynl4UCtPaHVQUWMwN011S0dtKzBJdVE1VTdPUW1ycWQ0VHFF?=
 =?utf-8?B?MlNWT3ZxaFBXNTYvUlBTdjJ4V1lTMFdKeXhybEpOdzcwZG1nVW52SWp2QytI?=
 =?utf-8?B?cW5GSi9VTStYSVd1M3M0bXphaURIdzgwOWdzS04rS0ZZdGVYTGZUTEQ5d3RG?=
 =?utf-8?B?RDFvb3d1Sit6NHg1SkM5bmd4aEp2TkNFQmpLbS9RMmU3cUo2SzlTKzRhM1hP?=
 =?utf-8?B?SE1MQm4xaWFad0Y3aGJGbjdIREl6VDhYSXFEOUZnN2R5R3NBcHRKc1h2a2dl?=
 =?utf-8?B?aytLVW1sNmdUeS9zMlYrZUVjcnF1QjRaU1BmTkliWTNlRVoxWVZhRmpOa1FX?=
 =?utf-8?B?YUoyQ2xHLzdxUWQ1Z1RVaS9mMXZkSUNSZmNzdU1DOUxVV2lMZlp1VFNDVVRH?=
 =?utf-8?B?dmhoZW5uNkh6ZXpXZzFUb0EzSTJYVUZPeXh3WHlVRC9jdDNPM1dzL2E2RVA3?=
 =?utf-8?B?ZkdKeC9GbUpFaXcyUGk1T3FYcG84UG0wVmNDRXpHbXphVjlJMjNZcjN0SXlV?=
 =?utf-8?B?TmtIMXZJK2tlTFJhYkMveWx1QXlOOG15NUVpYnZXVFpTT1JabXREN1BHa3dB?=
 =?utf-8?B?L0kzNVgwTExZZ0pDZWtRRjFybDFvUk5KY3hFOGJvTTNHMWRCYVZCVjZXcmZs?=
 =?utf-8?B?Y0ppT1RYYzlRVVpGdHcwRkFBbVlzWmMwSFBwSS9UelhhS211K3hraHVUSUlP?=
 =?utf-8?B?U0xZVjRBdjhQTUV4aHJnaVE3VDhPbXl4VXpZcUYrWFplc2VVYWpvRXZiRnZo?=
 =?utf-8?B?TnZMMDV5TUN5ekRYOC9jTGhkSS9HWHZQdzRrOCs5V0FWTkdvaWZRZWN2eVk4?=
 =?utf-8?B?ZGRWSzNHcVpPMUFlaEdNSGhPakFGS29GNkU0cWtMVDc1akhQZFV6aHNFSEU5?=
 =?utf-8?B?NUUxNnlxMVRWbFZaSTJMdGJQeUR3WEFuVUxyVzRPZW45TGRBajJYSzloNTRu?=
 =?utf-8?B?cHdQWE1PNlBPQ3JTQnh2SVhiaVQvb2xVaFVuVUY1Rm9kYWVhdkxibTh6dGEy?=
 =?utf-8?B?NG5XMVBOOWxlamlWWEc2MWdldXEyWENuTExjNVVuZ3NYT1k2ZG9vcndsYi9K?=
 =?utf-8?B?aUpMbC91ekMxb2x6algyTGdORGV3SmpnOU9OMFY5ZFBnNVc5WitUdExXQWI1?=
 =?utf-8?B?ck1CckF1aldQaWV6NGgzeVpxNjlWeGV1UFhQMXpUaXNRTU1MbjJqcUhCNGJH?=
 =?utf-8?B?eE5zNDZaQ01SWngwN1B5UVN6Snh1WTFzU1BGYVp6bE9iVXRhbXprT2RGSEIz?=
 =?utf-8?B?dnp6eWNhWmF3elhvejRwNW51TlJHT1ZjV1ZDTE5wMGVUWHFFYXN1dXF5Qmo1?=
 =?utf-8?B?SzNEMXkrUXkrMU5abDRzQS9SVWNJQ3BLSzBXS1poTm5vWHBSeU45NnhlZTVR?=
 =?utf-8?B?S2JYaVdtay9aTk5FUHM3Ym1hK1FTTXJBQzB5WjJGWXVOczdOWWdMTU9pOGJX?=
 =?utf-8?B?cnoxV1ZKS2d0WWpkSWhUS3NjV3RjeGhZQUtUYnNjRnBOV0xzL1RXRHBTK0NY?=
 =?utf-8?B?Z2NPWjRJVU9PVmhsaHRJbjVzYVJDdUsvTG9WOU94Q295aXdaVzN0L2t0d3Jn?=
 =?utf-8?B?ZnVhbGplVFVXWXVBL1htQUt1SGtEU3lJZC9VRzBSY1VBbWFXZEdKZ3VxSG4w?=
 =?utf-8?B?dEJmRU1COEJEU1VHNlBvbldQbXd0U0ZoQ0o0d2V6STlzU3NFODVZZjNvQWVZ?=
 =?utf-8?B?NlJRNUhJenN1Q3F2UHI5c3QrenM0UE12ZGRDdzdNYU5mZk8xUDFxZGRUYndM?=
 =?utf-8?B?REhraUQwdmJtVTI5dENlTjNTa0FSZHZCTWorWmtaZE1vUWFHdmhlRCtFVEdE?=
 =?utf-8?B?RGZiYXBSM2RJVzRqTkVTdkZMSlBhTUJiOGxBRitPV2loK0wyMHU2bGVHcmZT?=
 =?utf-8?B?c2Z1K1dPeHlQclhIcUd1a2JTU1VGWDBFdklXdE9MTzFEMnBNK0JPVFdQcEdt?=
 =?utf-8?B?N2cxZUNpVnlJL3R2L1dzQTBvTDJVR3JRdlJhRlJJaFhaVkNkNDN4Y3ArYktO?=
 =?utf-8?B?aWRiZ1hjamgxa29UVDhSWmZzZ25wQ2N5MWFWM09sMU1HaElMaTNuR2JocXps?=
 =?utf-8?B?R2YydkVsekExL2VQeCtCWVptTjZ3a3I3MFZEVWcrOE92MVJOZHVnUnpIRWdQ?=
 =?utf-8?Q?bV6+cy6Kaur1d4BRFMvoYRw6Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f76888-9bb6-4981-72b0-08dd7ce65a63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 12:58:15.9869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+nXHcHe3jNYLFGZzLzE9IFSbpZOh0vp/trmlrXQ/tauE1XlQtdaSc4Epepa1elL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
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

Am 16.04.25 um 14:54 schrieb Liang, Prike:
> [Public]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, April 16, 2025 7:01 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/4] drm/amdgpu: add the evf attached gem obj resv dump
>>
>> Am 16.04.25 um 10:50 schrieb Prike Liang:
>>> This debug dump will help on debugging the evf attached gem obj fence
>>> related issue.
>> That looks like overkill to me and will just massively spam the debug log.
>>
>> Christian.
>>
> How about putting the evf attached resv obj dump in a trace point?

Well that's better, but I still don't see the value in it for the eviction fence handling.

See the dma_resv object is just a container for fences. it's completely irrelevant for the eviction fence what other fences are in the resv object.

On the other hand adding the dma_resv_describe() to amdgpu_bo_print_info() is probably quite nice to have and perfectly valid.

Thanks,
Christian.

>
> Thanks,
> Prike
>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 13 +++++++++++++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  6 +++++-
>>>  2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> index 0075469550b0..7030d721196b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>> @@ -86,6 +86,19 @@ amdgpu_eviction_fence_replace_fence(struct
>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>             if (ret) {
>>>                     DRM_ERROR("Failed to attch new eviction fence\n");
>>>                     goto free_err;
>>> +           } else {
>>> +                   struct dma_resv_iter cursor;
>>> +                   struct dma_fence *fence;
>>> +                   static const char *usage[] = { "kernel", "write", "read",
>>> +"bookkeep" };
>>> +
>>> +                   dma_resv_for_each_fence(&cursor, obj->resv,
>> DMA_RESV_USAGE_READ, fence) {
>>> +                           DRM_DEBUG("after attach evf the resv dump
>> usage:%s\n"
>>> +                                      "after attach evf name:%s timeline
>> name:%s seq:%lld %ssingned\n",
>>> +                                   usage[dma_resv_iter_usage(&cursor)],
>>> +                                   fence->ops->get_driver_name(fence),
>>> +                                   fence->ops->get_timeline_name(fence),
>> fence->seqno,
>>> +                                   dma_fence_is_signaled(fence) ? "" : "un");
>>> +                   }
>>>             }
>>>     }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index d09db052e282..1e73ce30d4d7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -1675,7 +1675,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo
>> *bo, struct seq_file *m)
>>>     amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
>>>     amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
>>>     amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
>>> -
>>> +   /* Add the gem obj resv fence dump*/
>>> +   if (dma_resv_trylock(bo->tbo.base.resv)) {
>>> +           dma_resv_describe(bo->tbo.base.resv, m);
>>> +           dma_resv_unlock(bo->tbo.base.resv);
>>> +   }
>>>     seq_puts(m, "\n");
>>>
>>>     return size;

