Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10852C2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 07:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A0510E78D;
	Thu, 15 May 2025 07:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mdx+/CxP";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CDD010E78D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 07:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIH1sQhI9vcqWxQkJ+QV6sPt4jFjCCkF6GFZ5mNY2+qUXdHwpsHTZSM2YsVapPLx5S+6H0G6iIw9cQpBlgaXUCiyv6KgB0P8c0GqhD6rwRcEpk/7AMlswyNxTeqxQijUdM4rLpjMWPwOfmDvWgZ6rdDtrv3g4k90/AzD5+I3XCWHc0NVim1DVgELIa9X0jXW3MUX8JZYO74VtNDPvgAOthSr3wvEgoQbF/wWCoAj9LLhg5VZu5a356CaqQKXiA8Glh/Ji3d/se3G8Ed/l7k8mX2KmcTOgCxoUOQQTFCYFUFwL4BaTDh0L+iRzn0PcP7rLp1Ddh5qh8j1+XofCW9K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zll2qAi71PzjPWLEnGQXbztfakxt0PtD4hxRlLAiX0=;
 b=Z1ITU23ls064ljEp5c5moCXBCqSAhlr6UwDRvdvvJWV18vA6l4bRdG3Ks5G0M92r/oZYf47/8YACToa5pR5iDj4tyKkHhSxwBDEMJ6B9c4me9RHLgQv3fg/MCebHD64fe+fr8YsfLIIzWVOIN2aTWAv7lW4WymVS0COPsfVQk99swT+aMB2BnBxSHI/Ef0wy0deSwkwzKVEbDWic7/hr/CSbRtWBvTeUyGmT0RiWtSgX0zyt8nZFCN6frJ+AlOwhkZZZAy/5/NS5Bw4OO6FJNcKFKnCkHp+OBLRBRrvdlJWUHS+ki/pNjiDq3QL3PF/XKUNQNsEFa0R83/Qp6CsxHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zll2qAi71PzjPWLEnGQXbztfakxt0PtD4hxRlLAiX0=;
 b=mdx+/CxPn4ZOOHEC/cjGQ+6nG2vMJEPuDm8+y13vAa9xm6Gh05fpDLg5QlR+3DDF7asX564ti6vHltn52brwkVN8vobgQVvzsKoJT4SCr5Ka1ukpsBG4ddYAEHSL0OaPRIARLhX2rIz1gED4W7bkDBJZRhNB0lKqGeWJagOVuso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 07:41:46 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 07:41:40 +0000
Message-ID: <6559763b-2ea6-444c-bf3c-d6394f61bcde@amd.com>
Date: Thu, 15 May 2025 13:11:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v7
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250508120502.1467-1-christian.koenig@amd.com>
 <20250508120502.1467-2-christian.koenig@amd.com>
 <CADnq5_NwHQdE6aAR_ca88VGWmjXr9vtDf5_YQrL=DijA-6=UYw@mail.gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <CADnq5_NwHQdE6aAR_ca88VGWmjXr9vtDf5_YQrL=DijA-6=UYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::11) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e666146-01a9-419c-224d-08dd9383ed8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFV2cGZBb3RpV205enVFczg3VjhXNy9Ga1hBa0lvNjVnZDNJNWpCZm5JL3lt?=
 =?utf-8?B?ak9Sc2hUcEN0R0I2R2RsTFlEMXZUMlZtZThGeWlIeHo5V3JhQVRsMzE0UkpK?=
 =?utf-8?B?cEJxRWh1Z1F4T0V4b1cyTTRWR3B3T1lsOU15b0pYSks3SVRVUFQ3NGtSdkcx?=
 =?utf-8?B?ZFV5V0NWSldjcTRtc1BjZG1JbGhrU0tnZWtkUEVEVVUyVmJHS0U4bjhWcnZ3?=
 =?utf-8?B?OTY3aU5xSGowelJITFZranpFRjZMMnQxcXV4WWZLS1ZPZEFZVzdNZUhHcXc1?=
 =?utf-8?B?YzJZa0t1RUtiK29aZGlhUEVYamx4M21WcEZ6TDd3MEhObzFlTDYzZ3FTaWVJ?=
 =?utf-8?B?UC96Z3NMeDNvd3FiNjNuZmxMdmh6U2xCUmRpSGhRZUkvcVl6UExmTzV6VElR?=
 =?utf-8?B?aXhwbVJrcnducDQrSzBqc1VVeE1Ud3Q1QWxsZm9iQlZhTWdPMVJEMkJ1VTVa?=
 =?utf-8?B?TzZDVWZZV1FpZGVSc1NlWmdMY0RGOWFqMnVGTHdNNzUvb0prWFZER2V4M2g1?=
 =?utf-8?B?Y3hHQ2RDSCt4T1RIc3RjOUF3WkNOQjVHemtJbm42WDVCMXBhNTdTYXg4emMv?=
 =?utf-8?B?Q2JGRXYwRUhNOXkvTVloWjNaREZQeHVMUy9WRzV5Vlg3WSt0RmxoRXh3OVZI?=
 =?utf-8?B?TFgzWndNc0F0ODl5Q05tRkRnaFVLMS9TUm95SDFTOFp2dkhwYmpBeXRnRzVo?=
 =?utf-8?B?bnhQd0gvWm5xY0VYMEdGZ0oyUlpWZlVTRWZkSGdqc0hDUFBpQXhlQ291Yzk0?=
 =?utf-8?B?RDhMMFBCV1E4TGFXOUZGMWIvbEFRSmk3U0F4RGVYK0RzY3p4RGozOGZpNjZY?=
 =?utf-8?B?RjExV2hKbnVVNi9DSkJ1SkJWSDVnMkZ3Z0hjZHB6dWR3T3AwamdVRFNKNytp?=
 =?utf-8?B?SHhHSTQrUzhHVXJiYjhqSFFvd0hLbnp5dldJRFI3WEszWEZ2QkN2czFNcXhF?=
 =?utf-8?B?bjEyQ3k3cldPb1ZMbW5yYTY3S0FRN0lPMnB6cG84UXRnZVZ2V2hMSmErelBp?=
 =?utf-8?B?Rk5rVjFNYnMrdU5wK3ozZjhZOTFOTVhTYStEc050UEcwYkdzdGp2SHcrcHUv?=
 =?utf-8?B?OFpWWnhiL2Y1T2E2VUduSnd2cDdiY3lRQUhhSGphSG0wOGJWYlZDb0pWYWpy?=
 =?utf-8?B?Z3BNekJZMXRnWEVzdGFGWTBoNjZxWkJtbjdvWFl5VG9RREZsS1dWVFdrWkRX?=
 =?utf-8?B?RllZa1ZPMkpOajB5YWVpTTBUVFAyMzUzWmkzRXZ3dE1GZFEzYm5qcGJkUFpG?=
 =?utf-8?B?OVhkWkJLUmE5TkVVTVZiZlhKZ1JaY0U2VlRyRnFRRXBaVFB4MERqT2w3NDB5?=
 =?utf-8?B?WlFOcE0zd09VdzcwN1FsVG12b2JrTTdybVhQZ09NRDJlOE02anFPR1duRXd6?=
 =?utf-8?B?bTdGWHJob3JaQTVFNEhjU3dPcTdrdGVFN1phMmVsRncreE5oOVFWQlI1SFNH?=
 =?utf-8?B?eTNCWXF4cDNaWjBCU3FFWWFmZjdtcGsvd3ZQNlR5QnpjWWFCN2c1TlhUWG1F?=
 =?utf-8?B?T3pHc25NR2FnS2dQUEcwQUVXTGlTT3BWeUplK2NjTEFXK1NwN29XSTMrMmNs?=
 =?utf-8?B?VzA1dXBmU2dKQ3p5VGFZQnFraEVaY0w4S3ovRldnYjZwa0l4dENNWXh3dUhX?=
 =?utf-8?B?ZFRFcW9OQm8wOUhlczkxeUFiNU5aamNhWm1IUXB0V0Nob1hMMXdKYzNzQUNi?=
 =?utf-8?B?QmR4Sk85OGVoUkh3M1R6VFkvUUh1VmU0WENsTmZQSk9NNWZCTVZPUVZvYXlR?=
 =?utf-8?B?TEFzdWo2YnVVMDVZd1BCbDY4TmZqSTI1OGVUR2VRdm0wNWo0aTlyN0dtbkJK?=
 =?utf-8?B?bjdJTm5YaDhESm1SLzNOcEdUVjV5TGt1KzBGRmgzR3NvSkZvc0RQakE2VDBM?=
 =?utf-8?B?WGFFcGZFTVdzanQ5TVFWSzNvdS9hT3k0dDR3R2o2L0xaQ045a3hFTzQwclVO?=
 =?utf-8?Q?RjwWs2Uswv4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FlZ2VjbGd2YmJkVys5RDRsYjY4MzZtZUg5QlVIL3MyQklIM3FmU3JzckYw?=
 =?utf-8?B?NFdsOHI1d3ErQ29yQ3N1MmJhRmJldVpUOVBHL2k4dXNISWlxSzUxNFVoeEpj?=
 =?utf-8?B?NWFPaGtzblFxdHhhcVdGSFhyeE0ybEtPdUV5WEVlcVBCaXZIcUJTMUR6dzJl?=
 =?utf-8?B?UkFkS0lHL3ZJaG4vaXBrRjhSYWRLbE85MG5JMS9tdUNxekliOUJScmFQMm9O?=
 =?utf-8?B?aEwxU1Q2WHY1SWdtU1N3RnNDYnV1K0pKSnBJOFZNQlRERkJ6dmNBRjJ5VE9S?=
 =?utf-8?B?ZUJDdjhGaE9obHJzQ3NYTEg1ekpQMURSQW5sQ0dITkF0VUczWjBiVVo5VzJN?=
 =?utf-8?B?UW5oQXY1N1hxOFJHcjg4SWpTeGFFcW5Od2FhUUwxUW5IbTdwcWx6dDZJWjl3?=
 =?utf-8?B?YmZ3TGhLRVRkamplSlpDcFB3dkdJdXdjV0NNcGthYnJabDJmOStienpWcWd1?=
 =?utf-8?B?M2pwdDJNdFpYalVPOFBLTGY3eTF2MVFBdXB1dHY2L3lDQzJpMkJpd25XSEcv?=
 =?utf-8?B?MHJFdm5yNVk4VUl0UU1iaUVCeTk1YlZWcTRHSVJGOEQ0KzNWWGZQaUJTeGFV?=
 =?utf-8?B?YnJQRkdWeHBGMGF5Yk05NCtLc3JwQ3BZbUUyTFJtSkZVaEtPWDBqeWg5c3Jv?=
 =?utf-8?B?S3RzMkJHZ2IwVTlNVEg3bzNwRGFkcTZsMEFPM2cvUWxSMzZackMwNjlCbWhB?=
 =?utf-8?B?dWxCampXaGl5MEhnOVcyZkNMZXFJODVBTytoTG14MHV4OHdyZmlWQnNqMXVx?=
 =?utf-8?B?WVZNcFoxS0d4dFo5VllWaTF0UlpmakNiNnZZWFQvNnIxdXpYUzJ1eGpOOHRz?=
 =?utf-8?B?dmhoMHUrUHhOMXk0d242UmljZ0lmWmhzMGF6MFBGMU5wbFZTUk5CYkhHbHFQ?=
 =?utf-8?B?alYwc1RtQ25MSjRyWWE2dFFHT1VhS2M5NFZyK0puaEJ1U2pYN2ZhaDdiczlB?=
 =?utf-8?B?Tk9ZOW5Dc3Z2aXFTNS9HUVgxdzI5dURqVk9KV2tEeS9nRURHKytTd2JtYmYx?=
 =?utf-8?B?Nks5TWxBS2VEa0FWako4dnJ1RDZCeEpBTGc1UHlselc4bytGR0xkUTRIcXZJ?=
 =?utf-8?B?cGluSkFLbjUzUXZ2Rk1hdEwvYlk0TWcxcXVOUkd0SlhjVHoyZS9hbWdZUHVE?=
 =?utf-8?B?cGVSMUVOWlpmSmlhTzQ5MTBuR3JndXpLVVUxK3lnSjFUTU9jSG9PTHE2Ly9K?=
 =?utf-8?B?ZDEwMmRFQlhrOFJJUU9OMkNLYzJUemJvYUwzUy93Vi9hWjE4VmhNY1hUMXox?=
 =?utf-8?B?ZTNKNzRJS2NQdXplcGR0cHdEeUZGdjdTUDNoRTBMUGNUZDI4ZUFHQWV3V1JO?=
 =?utf-8?B?RFMxSGhPSkRJakwrcGVBamFvVTdNcTcyVVAvekloaHNJYmZNaW5pSG5zeC9U?=
 =?utf-8?B?b0h4aVhtMWFOL0xOekRBT0d4cWI3R0t4UDJ3Qlp1Y0J1eWVNcVd2cXpGS2JY?=
 =?utf-8?B?MU5QUkNJajNLNjhtYTZkUmRyTzY0TnU2VFJ2UWRoaEJsUUFreDFidXdiaDJV?=
 =?utf-8?B?eUlRUUZqdkF5ZkxPckdlOHBiMW11QWhtYjJiNnVBRlQyTjY5aDM0Y29Qb093?=
 =?utf-8?B?L01vQVJtdTdReC9TdGlEM2VWSlZLM3JlYkpWOEQyaW1jaHkvVk9wQThwQVVm?=
 =?utf-8?B?bFBEdURrcXdHa3V1Q0ZRSWtKYVFOaDVzUXFXM3FRNHNsREQ1d2p6R2pWZDFm?=
 =?utf-8?B?dzNFU1JkY2FtMVBHSXZnaS94azUrOXJZRnkwanN0bHVOV2RXVzBpWXJBRm1q?=
 =?utf-8?B?Zmp0TkRoT0dKenp5SEZVVVRHTmkrOWVwemdHRDlLdkQ4aUhVU0l5aHVkMUJH?=
 =?utf-8?B?YW52aGRZQlpyMEJnSm5adWljaExMZ01wQnVOS2tCWHpack5maGhiQnlJVWxO?=
 =?utf-8?B?dHY4QXQwZ3RUU3BmeE9oQmhpQXZlZml4dDhzcSt5NytvMFlHSWVVeDB4eEh6?=
 =?utf-8?B?ZlN1NmxYNE1semlNdkhrSUp0Z0lQR1lXalpYY2llNlNuVXpSbS9DUlpGTlJs?=
 =?utf-8?B?em56Z0ZmM0FyU2ozakRQQVhqcFlPRVdZVEFyYXBvYmZsVEhDbHE5aFpXR2ls?=
 =?utf-8?B?UHVmVG1pM0ZTTzV3WFpxV1ludldFelpRdXJlUGlRTWhQRTQxYjFUWkJWTlZB?=
 =?utf-8?Q?9A53tiCJ9PUEHiXObmK2TifDn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e666146-01a9-419c-224d-08dd9383ed8a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:41:39.8818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+dTCWsogCduiKm4mx3/fJ6ncSdTaVDGn+Q2AXqb5Cc1k6jATf70LJrlAgKjcdv0xOzx/naylMc6Lun2eisuUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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


On 5/9/2025 12:03 AM, Alex Deucher wrote:
> On Thu, May 8, 2025 at 8:05 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Check if the cleaner shader should run directly.
>>
>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>> if the VMID has seen a GPU reset since last use and the gds switch
>> setiing can be handled more simply as well.
>>
>> Also remove some duplicate checks and re-order and document the code.
>>
>> v2: restructure the while function
>> v3: fix logic error pointed out by Srini
>> v4: fix typo in comment, fix crash caused by incorrect check
>> v5: once more fix the logic
>> v6: separate cleaner shader checks as suggested by Srini
>> v7: re-order incorrect check
>> v8: separate the revert
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |   6 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 106 ++++++++++---------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   5 +-
>>   3 files changed, 46 insertions(+), 71 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> index 5eab1c1a380c..30b58772598c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>          }
>>
>>          need_ctx_switch = ring->current_ctx != fence_ctx;
>> -       if (ring->funcs->emit_pipeline_sync && job &&
>> -           ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>> -            (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
>> -            amdgpu_vm_need_pipeline_sync(ring, job))) {
>> +       if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
>> +            (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>>                  need_pipe_sync = true;
>>
>>                  if (tmp)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 0a80c011e678..31c423663b54 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -707,37 +707,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>>          }
>>   }
>>
>> -/**
>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
>> - *
>> - * @ring: ring on which the job will be submitted
>> - * @job: job to submit
>> - *
>> - * Returns:
>> - * True if sync is needed.
>> - */
>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>> -                                 struct amdgpu_job *job)
>> -{
>> -       struct amdgpu_device *adev = ring->adev;
>> -       unsigned vmhub = ring->vm_hub;
>> -       struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>> -
>> -       if (job->vmid == 0)
>> -               return false;
>> -
>> -       if (job->vm_needs_flush || ring->has_compute_vm_bug)
>> -               return true;
>> -
>> -       if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>> -               return true;
>> -
>> -       if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>> -               return true;
>> -
>> -       return false;
>> -}
>> -
>>   /**
>>    * amdgpu_vm_flush - hardware flush the vm
>>    *
>> @@ -758,44 +727,52 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          unsigned vmhub = ring->vm_hub;
>>          struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>          struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>> -       bool spm_update_needed = job->spm_update_needed;
>> -       bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>> -               job->gds_switch_needed;
>> -       bool vm_flush_needed = job->vm_needs_flush;
>> -       bool cleaner_shader_needed = false;
>> -       bool pasid_mapping_needed = false;
>> -       struct dma_fence *fence = NULL;
>> +       bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>> +            cleaner_shader_needed, pasid_mapping_needed;
> Would be good to document what all of these flags are used for.  E.g
>
> /* need_pipe_sync - if set, we wait for the last fence on the ring to
> signal before executing more commands
>   * cleaner_shader_needed - if set we emit the cleaner shader to clean
> up GPRs and LDS before a new command is submitted
>   * etc.
>   */
>
>> +       struct dma_fence *fence;
>>          unsigned int patch;
>>          int r;
>>
>> +       /* First of all figure out what needs to be done */
>>          if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> Please add a comment here to explain why we set all of these to true
> if we had a GPU reset.
>
>> +               need_pipe_sync = true;
>>                  gds_switch_needed = true;
>>                  vm_flush_needed = true;
>>                  pasid_mapping_needed = true;
>>                  spm_update_needed = true;
>> +               cleaner_shader_needed = true;


Hi Christian,

may I please have your thoughts onto this. ie., "cleaner_shader_needed = 
true;" wrt GPU reset
ie., why do we expect "cleaner_shader_needed" to be emitted during "GPU 
reset" process?,
because even in normal bootup case, currently we go and enable
process_isolation/trigger cleaner shader manually, only as and when
needed.

Best regards,
Srini


>> +       } else {
> Would be good to document all of these cases as well.
>
>> +               gds_switch_needed = job->gds_switch_needed;
>> +               vm_flush_needed = job->vm_needs_flush;
>> +               mutex_lock(&id_mgr->lock);
>> +               pasid_mapping_needed = id->pasid != job->pasid ||
>> +                       !id->pasid_mapping ||
>> +                       !dma_fence_is_signaled(id->pasid_mapping);
>> +               mutex_unlock(&id_mgr->lock);
>> +               spm_update_needed = job->spm_update_needed;
> E.g.:
> /* The spearhead marks the first submission from a new client.  We
> need to run the cleaner shader
>   * if it is requested by the job and we have a new spearhead so that
> we clean up before it runs.
>   */
>
>> +               cleaner_shader_needed = job->run_cleaner_shader &&
>> +                       job->base.s_fence && &job->base.s_fence->scheduled ==
>> +                       isolation->spearhead;
> E.g.,
> /* This will cause the queue to wait for the current fence on the ring
> to signal before new work executes (wait for idle).
>   * This is needed as a workaround for some hardware
> (ring->has_compute_vm_bug), if we are updating
>   * the vmid or page tables (vm_flush_needed), if we need to emit the
> cleaner shader (which must execute while the
>   * queue is idle), or if the job uses gds and we need to update the
> gds mappings (gds_switch_needed).
>   */
>
>> +               need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
>> +                       cleaner_shader_needed || gds_switch_needed;
>>          }
>>
>> -       mutex_lock(&id_mgr->lock);
>> -       if (id->pasid != job->pasid || !id->pasid_mapping ||
>> -           !dma_fence_is_signaled(id->pasid_mapping))
>> -               pasid_mapping_needed = true;
>> -       mutex_unlock(&id_mgr->lock);
>> -
>> +       /* Then check the pre-requisites */
>> +       need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>>          gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>>          vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>>                          job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>          pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>>                  ring->funcs->emit_wreg;
>> -
>> -       cleaner_shader_needed = job->run_cleaner_shader &&
>> -               adev->gfx.enable_cleaner_shader &&
>> -               ring->funcs->emit_cleaner_shader && job->base.s_fence &&
>> -               &job->base.s_fence->scheduled == isolation->spearhead;
>> +       spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
>> +       cleaner_shader_needed &= adev->gfx.enable_cleaner_shader &&
>> +               ring->funcs->emit_cleaner_shader;
>>
>>          if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>> -           !cleaner_shader_needed)
>> +           !cleaner_shader_needed && !spm_update_needed)
>>                  return 0;
>>
>> +       /* Then actually prepare the submission frame */
>>          amdgpu_ring_ib_begin(ring);
>>          if (ring->funcs->init_cond_exec)
>>                  patch = amdgpu_ring_init_cond_exec(ring,
>> @@ -815,23 +792,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>          if (pasid_mapping_needed)
>>                  amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>>
>> -       if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>> +       if (spm_update_needed)
>>                  adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>
>> -       if (ring->funcs->emit_gds_switch &&
>> -           gds_switch_needed) {
>> +       if (gds_switch_needed)
>>                  amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>                                              job->gds_size, job->gws_base,
>>                                              job->gws_size, job->oa_base,
>>                                              job->oa_size);
>> -       }
>>
>>          if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>>                  r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>                  if (r)
>>                          return r;
>> +       } else {
>> +               fence = NULL;
>> +       }
>> +
>> +       amdgpu_ring_patch_cond_exec(ring, patch);
>> +
>> +       /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>> +       if (ring->funcs->emit_switch_buffer) {
>> +               amdgpu_ring_emit_switch_buffer(ring);
>> +               amdgpu_ring_emit_switch_buffer(ring);
>>          }
>>
>> +       amdgpu_ring_ib_end(ring);
>> +
>> +       /* And finally remember what the ring has executed */
>>          if (vm_flush_needed) {
>>                  mutex_lock(&id_mgr->lock);
>>                  dma_fence_put(id->last_flush);
>> @@ -861,16 +849,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>                  mutex_unlock(&adev->enforce_isolation_mutex);
>>          }
>>          dma_fence_put(fence);
>> -
>> -       amdgpu_ring_patch_cond_exec(ring, patch);
>> -
>> -       /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>> -       if (ring->funcs->emit_switch_buffer) {
>> -               amdgpu_ring_emit_switch_buffer(ring);
>> -               amdgpu_ring_emit_switch_buffer(ring);
>> -       }
>> -
>> -       amdgpu_ring_ib_end(ring);
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index f3ad687125ad..c9578b7f670c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -498,7 +498,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                         struct ww_acquire_ctx *ticket,
>>                         int (*callback)(void *p, struct amdgpu_bo *bo),
>>                         void *param);
>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>> +                   bool need_pipe_sync);
>>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>                            struct amdgpu_vm *vm, bool immediate);
>>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>> @@ -559,8 +560,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>>                             uint32_t fragment_size_default, unsigned max_level,
>>                             unsigned max_bits);
>>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>> -                                 struct amdgpu_job *job);
>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>
>>   struct amdgpu_task_info *
>> --
>> 2.34.1
>>
