Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A3606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tx+W9J7K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A48F10E65B;
	Wed, 18 Nov 2026 19:44:12 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D135D10E6C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pveYJ3bg2ynRXdFbPc1SJ5ZJ3oX//NWpqfClWGo6YTqth265buxkRBPR51Wj1jKLs+RoOVS3Mzq/v69+DMmzCbECFlwxBcpUATabrT96AHjZw7/Qy4MUb2PgmOs722AE7UUdypVT32KdABhbXn7jVWD/YETf6/+KFQInQOwnRUv8//5uCo6SmlXWvclUCreK+gdRzwwKdwrAdEpGhM4uRfTs9CaQhlNCFEJAupV6OSfjFh+vjL05Z6Rbq85NByhqlfYqEO9lwKTk9qw6zeCiMNSGbP+/ZVcG3oAOWwVI/txop1p83pHAKLwkqNT3vxFQBLFas2HHq215+U3n2jQdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiidXYSygYS2deAVm4el7vc7uVARKr7N/wYvcL/2TnA=;
 b=ASF0Jna8F70hsYRbEJCsj3rlpn+oPEHmoeCDOAyj4/4U6+3bwxWA6tMWSsOacgApsoshT8WiI52KTqlVObwx2p6/qlMQerQhQJe0EqxtTYoK2EIluksGwXEXCSUB8tl6zubgdx7wNVGm9m3erDJzUOZeHuEQnz3XrKsuAO1EqkMQ7dfgeiDc6ACvrhVIC6+GX7g0MkeSIO0FqotuvAPfm9pW5bUWj8Px+sUoJ8a53dwoZ05OJOao2pYjy+f/rxG/WFsD3lUf+b4VTLpccC6JYK9ruLJ8duRbPCx1Og6OjXH4e8l6jUsBj0Ckw1vd+WcRi2j4BXgTN06bZwm93pVB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiidXYSygYS2deAVm4el7vc7uVARKr7N/wYvcL/2TnA=;
 b=tx+W9J7K26yLQvCQx04YO8jBmaTuVdON5yVxvWCe7TpaE47XsdHmeQQEqibu3Lnejxg/IatwLD6F5pq0Cdnq2LVDQQjeueS5Ih4OkPPvyKJbT3c7NXfCmKv38rAXz6GMG/VRnFfzXBCfruDYehHxNnTAdeEdDn4bNIqByNqPOFY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:43:54 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:43:54 +0000
Message-ID: <fb919edd-99d6-4495-93a4-d0a22024aab2@amd.com>
Date: Wed, 18 Nov 2026 13:43:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
Content-Language: en-US
To: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
 <SA1PR12MB715234880D4B3AEDAA1AFF72F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB7152CB1DA95F6AC4190C93E6F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB71526239725978636452725DF87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <1d06a6ef-7a67-409a-bbaf-9ec9c0dd32de@amd.com>
 <SA1PR12MB71528D13366F5048D82E4841F87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <SA1PR12MB71528D13366F5048D82E4841F87A2@SA1PR12MB7152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:610:5a::26) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 895cd188-51d3-4de6-9c27-08df45ac470a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022075727099003|10067099003|11063799006|56012099006|4143699003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|5023799004|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Bv5DirY3+BhxQnk++lURdPTypdFNHbBml94I2PjctpRHeGfSTC0YIpfnil0TsXXeoqMhqk2SmblyJscs/Hjs0JT+NuOMGptHYUxU7uqZdCD7qF/BBP4wH1znIvf2mifI3cdxxgr8jgEh08jJoM6M5ebk7VmWLey5/W2LowIVMMBj8uaw7kn5Y0HkjoPNPlxW8J2mmXIFj6NKSgYStSCGPT+TMJygVHQ4V+Lhgf3HapTNKPQwmgy4CHb0tXngEWlECyS6ZbgFkpC/J61x39y2dx/mcJsyv0r1eDsHbuaNQH8PUmRFSaDfYFsPOPrgOEjiFJj04/7Gzd+yQ/Lc+xfznzOOZw9xolxKRs5eEJkZkjRNGCOt4rKw5j/4ZfVsj2hBn43LEqBPCPhyB5QU7QFlHWbXN9KFiIZEyMO5ZWXK9CNPykVm10unxpbii4A+WEy0Htl779wIzz4JMBLM+mJFhXHbp06i7rKytsfH/l7RAWj/nqPJP3y+xJ1BxFabTBXJKlsqrhuT7o+uynPT3/5TOrxnmc2sIu8vp4RPA8hFXl7CMxtqMXkVXvT71Ppwz+B6+ymTNQtgF0U00VD/h5YOcxoe8g/ZL/j/LNzXRSyYiRHtk5wadPMqVfNRPZolvRi8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022075727099003)(10067099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(5023799004)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlEvdG8rQ1BaN0Fsd3FMYndQWUd2YmFmajJ5NVRNMEM3MVptRGV1d3V4ejVu?=
 =?utf-8?B?Unk5M0tIOStmM2t3TVpDVFJ1d0FQSm1nREU4V2lMSjNPME90bm9HYTR0cmM0?=
 =?utf-8?B?RXlvdUEwQXRaMG8zUWI4TzBjaHpwZkt0TFNmSTVKS1FaR3dzNjhjTkROeUVm?=
 =?utf-8?B?YnprWHdWd09rYVhwb041T1l5dk5YbWlPVEJlQW83MlRWSVoyUlRjc29obTQv?=
 =?utf-8?B?YzR4V0w0QSt4anRhYXJpcXFRYWJvTmpYSWhZYkhxZXFJRUZzV3pPdzRNblh2?=
 =?utf-8?B?NU93UjJRcXgvYTRRTHBGRGVMU3ZMaDk4WlU5NVBULy9qeG9YaGMwWi9iZzNS?=
 =?utf-8?B?VjNrU0hkMms1ZzNid2RpTitwdHppZzJFSmlpb09xZ2h3Y1VyQThyNnJRK2Vn?=
 =?utf-8?B?S3llRFhJdmFKRkllZTJXWjluRk9PSEd1akRiQ0ljMjJmVXVJNmhiVG0zbGkv?=
 =?utf-8?B?ZUhhT0M1Smhnc2p6dTRibU5Va3RUcWZoL0ZrQWhXajFRbGJmeU5kWmJsSGdX?=
 =?utf-8?B?ME1LR052OVNIME5xM0xGeXJHN09BNDZlbXRsUTB4OUFBdUIycWo1MGF4bWpr?=
 =?utf-8?B?NVdZVUtOQ2lDZWZRbVVzaDR3NlN3TW95Yk5QU3djeGN5a3kreE9EbHRKN3FE?=
 =?utf-8?B?dU1xUVVaanc1RHRTaU92aHlHVGttanpNWkROdy8zWnkyZC9KL2ZDd2U4S3Za?=
 =?utf-8?B?elRwaE51TjVXbHV5bEpzZVpDYi9oSWJQT2lQOE1UMHowY0tmcEFObTFYMTdu?=
 =?utf-8?B?QzF2L2JVTW5hanl2NXNkQlR3SU5KeVIrOVVhc3VkZlZKeko0Wlg2UlZiQ0Zq?=
 =?utf-8?B?QjBMZFZuY1R3SmtJZ3l2VjRPRE5XUWRlUWZCREtJWmpsTmoxS0FHS0RCUFhX?=
 =?utf-8?B?ekdWeXVWNmJwSmRibE5SUkY0UlgzREtuTndwK3JsN2tnZEw5WkYyeEJSbnZv?=
 =?utf-8?B?SW8zTVFwUVZxNDFIM2JuMmJBWWZOdTgwTXJJbmcwaWtXMVAzK2VkZGtwNnVT?=
 =?utf-8?B?WWFOS251N0V3Ynpad3JQa1dVSlJMa1NTM0U1clBBYUtENkZ5aEJEdW44SmJx?=
 =?utf-8?B?dHprQVJCd3loWXlBZWpIeFBodE5uL1E4ZmFMaW9kazdMVWl4QnJYRTlNZ2Nl?=
 =?utf-8?B?SzdMRHcyT1JsU1hzdXV1b1RSMTd6cEJPY2FXV2c5VlZieFlmYjhYUGMrTXdB?=
 =?utf-8?B?am1pcXBBS1JPdGE2U0hhcmlZckFrV2pueDI5VUtvbUcvM1B0NndqMW5YQlBY?=
 =?utf-8?B?NkdhNDdaM1B4VDJXVkVQTEptZEZpcUNmZWRnOTBaNFAzTUdaUGZ0Z3R5QWZJ?=
 =?utf-8?B?OXVZbHU0dWNXeVMyYm1kQWw5WHBna01USnQ2NzB5d09ZY3BpdE5NOVRUVVNN?=
 =?utf-8?B?ZlRYSkpSTGo0SVRRMjc2TlhZZWtQZzc0K2o3bTkwSHR6SkloZkVFNHY0UGRY?=
 =?utf-8?B?UzhYQU12VzhvY1o5cWh6WVpscm02a0YyaDM3MCtkN2loT3RjbG00ZWd6Tkwv?=
 =?utf-8?B?UU55WUZ5TTNMSDF3STlOTCtmM3k2TTFsNkh2OHRPY0liREtTMU9UYTRXMlJj?=
 =?utf-8?B?UHQ3dnYwbUlnVkkwenhNVjhRVkRXOERhby9sYXdjUmRaOXpUTmg2SEdUZkNt?=
 =?utf-8?B?YmdKYWZSWlZDUTJvU2ZRQjBXTFFOcVlJanNZK240V0I0c3NjZEV2c0JHNllF?=
 =?utf-8?B?U2RuS0Z5cmVZbGFMVGlGTlNpZ0xZVHZ3Wkx4SFJaNjI4YTI0enUzM3YvSHh1?=
 =?utf-8?B?aHJMY2lnSFpvWlFjREx0ZG9LWjNWTHY1WlBRZk96RXBZTHF5Sjh5RVdUanB6?=
 =?utf-8?B?RzQ1QWh2V3hFRVZEbXRGZ3lsOXRhaTNZOUF2YXNoSWdhSWxTb1NKU25uc1A3?=
 =?utf-8?B?QVpES1BWaUdvbHBkdzBsUHg0ZkF6UFJPWDhCYjJKOXc3SHIrUGVhcGVYWFoz?=
 =?utf-8?B?Smp1NUVDcVZCaHNQMzAxTzFRSjczd2h3N09uMExyMTNDaU1DaVRzRnJqblZv?=
 =?utf-8?B?L294U2lVRTZOeDdSYWk3YjdjYmdHOThoT3hMckVXSi82TXA1V016MVlITXd6?=
 =?utf-8?B?VEwvbitLWlZJUi9kYUZENy9GUmNkSFBDdHFMT0NIVFkzMHFPNTdVM21xeFNY?=
 =?utf-8?B?bGh0aktINFV1UHFYMk9XNFNTeU9IaCtRc1ZoVG50Ym1tRlZjWlBoZzVVdEFs?=
 =?utf-8?B?MzcxQ0ZkeFVPeERsQkVlL0UrVlpxSVRkVnFYdUcwY3JvYllSUHJCMityL3hn?=
 =?utf-8?B?TENCbzBVdVFjaVp1MVEwbjhJY2lyaERRTXhaQ1N0bFZ4aGs3U2tVNHNyZUgw?=
 =?utf-8?B?RXJhY01Sek5PRVhBSzEyWFRMMUU2OHE5L2tXUHE4REZvbC92Umcydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895cd188-51d3-4de6-9c27-08df45ac470a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:43:54.1918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHfEYi9JAppMZznpchRPkCnNl735UuUicUg26nEAz9ePWHVCHtQPwcrn2QnL3Bujo4SFMn1vIhvhOnnIGaaPtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
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



On 11/18/26 13:01, Thothiralingam, Logatharshan wrote:
> AMD General
> 
> Hi Christian,
> 
> You are right, amdgpu_vm_wait_idle() is not needed. I was thinking of that before, but I added it in the previous patch per your request. But now, I have removed it.
> 
> Please see the attached patch. I have tested it, and the hang is not seen. Please let me know if the patch is good to go so that I can share the solution with our customer.
> 
> Then, I can create another patch against upstream and work on getting it pushed.

IMV - I don't think you should share the patch to anyone to claim to fix 
a problem until we've successfully merged it.

I would post it for review like any other patch.  Let Sashiko bang on 
it.  Get review tags, merge it internally and let CI bang on it.

When all looks good there you can be confident in sharing it.

> 
> Thanks,
> Tharshan
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Wednesday, November 18, 2026 5:15 AM
> To: Thothiralingam, Logatharshan <Logatharshan.Thothiralingam@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
> 
> Hi Tharshan,
> 
> oh that is a really good point, using amdgpu_vm_wait_idle() here is not correct either because of the same problems as with the context flush.
> 
>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>> false,MAX_SCHEDULE_TIMEOUT);
> 
> That looks like the right thing to do, yes.
> 
> It only might be necessary to replace DMA_RESV_USAGE_READ with DMA_RESV_USAGE_BOOKKEEP, but I'm not sure if KFD/userqueue suspend resume is actually fully implemented and handling this.
> 
> Maybe we should stick with DMA_RESV_USAGE_READ for now and I will let my team double check the KFD/userqueu thing later on.
> 
> Thanks,
> Christian.
> 
> On 11/17/26 21:08, Thothiralingam, Logatharshan wrote:
>> AMD General
>>
>> Hi Christian,
>>
>> So adding dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); before the amdgpu_vm_wait_idle() fixes that gfx reset. So it seems like amdgpu_vm_wait_idle() alone is not enough.
>>
>> Attached the patch again. Please let me know if it's good.
>>
>> Thanks,
>> Tharshan
>>
>> -----Original Message-----
>> From: Thothiralingam, Logatharshan
>> Sent: Tuesday, November 17, 2026 12:52 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> Hi Chistian,
>>
>> Just having the amdgpu_vm_wait_idle() doesn't solve the issue. I
>> tested it and I do see the reset. I have attached a patch with the
>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>> false,MAX_SCHEDULE_TIMEOUT); I am building it now to test.  Please let
>> me know your thoughts
>>
>> Thanks,
>> Tharshan
>>
>> -----Original Message-----
>> From: Thothiralingam, Logatharshan
>> Sent: Tuesday, November 17, 2026 8:39 AM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> Hi Chistian,
>>
>> I looked a the amdgpu_vm_wait_idle() function and noticed that starting commit 1f02f20 (https://github.com/eseiker/kernel-asahi/commit/1f02f2044bda1db1fd995bc35961ab075fa7b5a2)  the wait on the VM's root page table fence list is removed. So correct me if I am wrong, this alone won't wait on the gfx jobs right?
>>
>> So should I add this before the idle call?
>>
>> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ,
>> false,MAX_SCHEDULE_TIMEOUT);
>>
>>
>> Thanks,
>> Tharshan
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, November 17, 2026 4:37 AM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Thothiralingam, Logatharshan
>> <Logatharshan.Thothiralingam@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before
>> suspend
>>
>> On 11/16/26 21:40, Mario Limonciello wrote:
>>> At suspend, amdgpu_fence_driver_hw_fini() only waits for the last
>>> fence emitted to each ring. Jobs still queued in a scheduler entity
>>> have not reached run_job() yet and so have no hardware fence.
>>> Userspace is frozen at this point, but such jobs can become runnable
>>> later, for example once a dependency signals, and the scheduler then
>>> pushes them into the ring after the hardware wait has finished and
>>> before the IP blocks are torn down. On resume the ring write pointer
>>> is reset, those jobs never signal and the GFX ring times out and hangs.
>>>
>>> This was observed as a rare (about 2 in 400 cycles) GFX hang on S3
>>> resume on Picasso.
>>>
>>> Flush the context and VM scheduler entities of every open file before
>>> evicting resources, mirroring what amdgpu_flush() does on file close.
>>> Like for any other dma_fence there is no timeout, the wait is not
>>> bounded.
>>>
>>> Reported-by: Logatharshan Thothiralingam
>>> <Logatharshan.Thothiralingam@amd.com>
>>> Closes:
>>> https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F2
>>> @ SA1SPRMB0073.namprd12.prod.outlook.com/
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>>> ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 19a566187dfb5..d18348116d3f1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>>        }
>>>   }
>>>
>>> +/**
>>> + * amdgpu_device_flush_file_entities - drain scheduler entities of
>>> +open files
>>> + * @adev: amdgpu device object
>>> + *
>>> + * Wait for the scheduler entities owned by all open files (the
>>> +context
>>> + * entities used for command submission and the VM entities used for
>>> +page
>>> + * table updates) to run out of queued jobs, so that nothing can
>>> +slip into
>>> + * the rings after the hardware fences were waited on at suspend time.
>>> + */
>>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device
>>> +*adev) {
>>> +     struct drm_device *ddev = adev_to_drm(adev);
>>> +     struct drm_file *file;
>>> +
>>> +     guard(mutex)(&ddev->filelist_mutex);
>>> +     list_for_each_entry(file, &ddev->filelist, lhead) {
>>> +             struct amdgpu_fpriv *fpriv = file->driver_priv;
>>> +
>>> +             amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>>> +                                         MAX_SCHEDULE_TIMEOUT);
>>
>> That is actually superfluous and even a little bit dangerous.
>>
>> amdgpu_ctx_mgr_entity_flush() is only supposed to be called from the process which has the file descriptor open and is closing it.
>>
>> We use that to detect if that process using the file descriptor was killed and we should discard queued up work instead of waiting for it to finish executing.
>>
>>> +             amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
>>
>> That here should be enough to wait for all work to complete.
>>
>> Regards,
>> Christian.
>>
>>> +     }
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_suspend - initiate device suspend
>>>    *
>>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>>        if (r)
>>>                goto unwind_ip_phase1;
>>>
>>> +     amdgpu_device_flush_file_entities(adev);
>>> +
>>>        r = amdgpu_device_evict_resources(adev);
>>>        if (r)
>>>                goto unwind_userq;
>>>
>>> ---
>>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>>> change-id: 20261116-superm1-drain-submissions-17d4414ab3b9
>>>
>>> Best regards,
>>> --
>>> Mario Limonciello <mario.limonciello@amd.com>
>>>
>>
> 

