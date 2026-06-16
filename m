Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB654CD98E7
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B9610EB88;
	Tue, 16 Jun 2026 12:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2JU2sFCE";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30EE610EB88
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaGy2hZo2tsvEJbSvSTPnGOE/bbCnI0efuZlDPF8z/ebft57s5EmffbaYUWqgqHUymMDw+s/J5ucT3M06TbkB++5xwF+39sGOVChl4F67NZ1V/5L7q8f8h7+d1JwRkDZzr5F3VcMssfkNXK/AyT0B974taJLJDBw2eC9wPml/YX/LZYZIpei3N1sCyUB2GruAk9RfHIbvVyhPiZhZOquwE/j+kSaGNk/udd3kkIqsvY5l0FePYwNYSUWfMC4FzR1YNsOtreS0slOYCS0tl3mMxnyU3NtoE4SJ6+40ZOh9FkZYNG458IsxyHeqBqKg/O4kcyuYOxqJwpkjP5pbUKCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKT8NUpBoqkLYOcqqmDHe1+DuKcqP+XljQUXxiUmygo=;
 b=Qm/+/ZC7czObIu2V48IN/InEemAnxyZgv8dGk5ipQKZKIwCgS9IxC0HVcpuZruTfRfJjbGb1ew+G2MjEUj2Kpy3mf9k9OLHMtHFwnHRMxUqSSL1+QdBheIfaxbXF1ZVPJCTO08Vjuc+MYBDpL15q11e9gv8eyzd1uRrQnDmhtlPE4xDoqVo66jJKVzCa/N7erPSnLmyVI64+0Xb8U1lUtggE38FtvTDYiZkcaDwBpML8VUPz0VJw1GiqfnvzXJ8EaEy5DFJHoaMW8AhKAjYYDxdJUv9h8ARWEv5V6W3DsU2GHU63uqqkvjcVD4XaNEq7vffYSlfp35rga6zx/VDlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKT8NUpBoqkLYOcqqmDHe1+DuKcqP+XljQUXxiUmygo=;
 b=2JU2sFCEEkQI1nsSbmA5QVl5kcM65K3bUnH8YXZKPF2d+yg2b0RmXwrjuNw+z1abjTS6pcppHdvc3lSGBCL2bafHeX5nPYad8Lb4QIclrlFCIuv5HpGkym05q+NMVRUplEp2VEbvITRxPPCRFn9s6vYsDjMAOIIYiU78MWhP5Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:51:11 +0000
Message-ID: <cc3c0181-413a-4c82-9363-1bffd7c3fc53@amd.com>
Date: Tue, 16 Jun 2026 14:51:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/amdgpu: Signal SCRATCH EVENTFD notifications
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260612055226.2879270-1-srinivasan.shanmugam@amd.com>
 <20260612055226.2879270-4-srinivasan.shanmugam@amd.com>
 <5f16dfbb-e9b7-4f66-954b-ac7299743323@amd.com>
 <IA0PR12MB820812B1B96223065F5110FC90E52@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB820812B1B96223065F5110FC90E52@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: c5aeecc4-df37-47e2-a910-08decba5f18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: qDsxvnszNH6RVz8akY+I03xWJonSIkicCTrVesDl4tUF8QSsg8HSENsU1e6l6Bg1JNoCM2uj8BrhYXYair9IyEr/4ZQB2dOwk/m6z6UFqdqZKAThAka39RIPIjz+VbK6B+a23m4OL0MXtmO/ratAUeMOk+kyeIis074/yrnanRaOQeV5sAoW8a3/JLiG9pfxjUfWRnTXZhieAPSTfIa62gAhY26Obp8CWp7ywQVweaV9OzGU0AzyjSdX8rHwXmFcgVvzC3jUHu9Lksa81ndDTrJuLQx0V5kTJM1A58Cv35GZwM9CI58imbmIkGRax56lVDED/LdhQ49pM8AALo3S4qIt5bLGHmDpwb1m79KL77jlu+/Yb30QBa47vpKSQpLhLeroEe2l/funEGFdv2des9Kf4TqplLvDkbQm3/oJAS+rJWa1YcP9odrrLjiqXR9Vl+4tV7cRjC3L5U1YcDK8zCOMKrhfFhZdAkrVTxQy7JaV6FkIuEUeTWSjSSymSaSsk8VWn15Uh2erwKVjD5uyAiVdL7qkzHtMUKGPFMPwnXY7BquxxjDENbZGD0i9Tjf+JXqyeL6sjo8ZhE7DhWXoUaFO+Nr1EglxeOwHxX1Kj1jtS8fSZCfLP5NTrJS2zXZlOqxKevynPEpSas44TacyYwyuqYO0omt3L67rZ+ilWmI2ouLRxJZTH4oSrhfJ2oZY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ui95OEYwSVUxNXVnUC9hNXdSdGZOWkRsWUtLUXo3eDlOU01Yck50SU93WnM3?=
 =?utf-8?B?RERyWkdFNmFBMFIvaGtEQitsS1hzZk5obVNwVWgxa0VaazllaUtnUkZxL013?=
 =?utf-8?B?QkxPa2NWbldHbzJRNFYvWXJzTndLNjdneTk2VTkzeUZmZGpLdHhReXVZSjBy?=
 =?utf-8?B?cjFsODNyYStGd2lMbFJrUFRRc0M4RXBSdkp2NkJSWHdXZ1dheEUrSWFKY3My?=
 =?utf-8?B?V29PNDM1aEFVN2cxS0pVRWZPWFB4VWRLSXNLVDFrODF3RzFEdXJYSmd6dlhZ?=
 =?utf-8?B?cnZMMzJyaHJrbmlZVEZ2RmZCenhBRTFUVzV0UmZFQXBneWhwOWhkTFNhcTZo?=
 =?utf-8?B?QUw3ZURsaFhCQWVjTVBFMTJpZENHSWNYN1JKckd4d2V0UnVBL1VHWEcwbHJK?=
 =?utf-8?B?ektVSHdIdytMQklOcGoyRmEvTkQ3TGRTM0NjUFdMamo1a0lOU2YzVjcyaWFz?=
 =?utf-8?B?NDJkSnpUTmdRQnhBemh4UkhOR3BYNU8vRU5TWHFhVXVCdWR2YVVLUGJzNjRT?=
 =?utf-8?B?Z2xzUGFrZFBUMGRwNDR6amJEYTlnNExxSVRNYXZEdWdENnNuQ1Z6bEVEK2pq?=
 =?utf-8?B?SFg0c095NjhjSG1CQXNsaHR5V1dhMmVWZEl1QVV6bW9rRVVGS2swYWlET1Z3?=
 =?utf-8?B?Vk9QVDZ2OHZ2WkF0WEpQc0VOdk4rUkhJanYvampyeS94TXFWWlF2THRzbE1C?=
 =?utf-8?B?WVdrRVJycFVJU3hKeUlZbCtXbFYzZFNDdjFnUCtCMk1qSGN3NlZ6ZlVtV2ZE?=
 =?utf-8?B?ZDRCNVlGT3RoVnovOVY0SFpMWmY5V01zNFJ3dWJ3U2JlRmYrU1dkQmlTeGhv?=
 =?utf-8?B?SENIMFhiNHVJaU1sb0xxYW9VVzN1N0dVbG0wTERyQU5iZkgyd3pCTkNYdVQ1?=
 =?utf-8?B?bDVOYTF0TklqbHhRZ3RpQWR4cHlkMC8wMkNOQmc1WHM1M01ZZnI2UHZzSktl?=
 =?utf-8?B?MWtEREZqVFFPd0s3eTZxOGJqRHB0VTkvQzM5S0pSM2g0YnVlQjRJRXdqRlY5?=
 =?utf-8?B?emNORzNWWmN2a25NUkpIZDA3bFhRS3JBRW5lWlRrRzlPNitBWXFaL2NGNVA3?=
 =?utf-8?B?REZONGpNWU1yVG5vSElHaHhlQUY1WGJXUFdWb3ZQYXZqZHpjZXBJaVQxZElZ?=
 =?utf-8?B?c1lmSndWNnVLbWVMcUh2VFhBTmczcWhwQkczd0t4M2JEcmFiMktFMXFpREtJ?=
 =?utf-8?B?QUlINEljcUFiWFp1cG1CK0pVRWQzNnVxZHZrR1ZoalowOU5sb2ZXcXJ6RHZD?=
 =?utf-8?B?cFlYUmxURllIRzF5d1JrcFBQeWh0R1M3eFA1eWhGM3VMQ3QwT25oZ0EzOURF?=
 =?utf-8?B?NUpIdUtNOGpkaitoWm1tT0RxREkxM0xWbEpBMjRMQnlERkxrRzcvWXlNcVVT?=
 =?utf-8?B?ekVwTmdqUURqNG42eHkrNkRRZkdEdGxIelBXRzlUeU9Vc2ZSNzN5U2lWNXpH?=
 =?utf-8?B?ZDlPNHEzcTJrR0RmWjVaQmVpMDI3U2tDT2xhVmhrMFBTb3pRTkFuZ2RNSXpM?=
 =?utf-8?B?Q25rckRpc0FGazdUK0RrWTg5WGI3VU95QXlITEQwWFd6SlpQMVRxL0dFc2w4?=
 =?utf-8?B?MDhybGUrR3dtVGdRc05Ec3FGRWk5OFdvTU03TFhaRG9mczc2M0l6OExMRmI5?=
 =?utf-8?B?YzhxUUc3YmRqTTdRL2JLVDFVcERraWQxNStUMGtBSUdsaUFnaFZMc0ozcURG?=
 =?utf-8?B?dnhMOWFTTVV6bmxZbnkxbnA2SE80aFNUQjJ3R3JBSmJvUjI4UENyWVloL24y?=
 =?utf-8?B?Q0JTMlV0OGxkc3FYbWRvVzRlMi93amcwbVJFei9YdnBMM09IYVkxSHhBWGFH?=
 =?utf-8?B?QVVVZnU4bEdlc093Z0xQOXVLTVZ5MHdORmxRcjBYbFlOVE8vZk4rNStwN1dZ?=
 =?utf-8?B?YlBmTFVucFJ2ZzhmL0I5VWNWaUQwVWZmMk9Gd0gyQjMvanN1dW8yY1hTWG5t?=
 =?utf-8?B?bEM4NjlKUysrdHRuOXJlbWhrdE1KcjdpbWxiSnFwT09udlVXbFJmdHhKSEov?=
 =?utf-8?B?VkYyZnpEYXRoRkV2UnA0cGc2UThhT3QwUVdWTWhScEhpSmlKcVdkeGdpT3JJ?=
 =?utf-8?B?N1Q5VzR5clMrRnYvNTFpQWt6T3JacmgxSzg1ampyUHJVMHI3L2phb0RSem9o?=
 =?utf-8?B?dnI5LzZOQkdkVkZXaGdNeElNVnJKYXFTajVtYzFucG9sZ2xLOFdOeHIxMFFu?=
 =?utf-8?B?TE15WTNZMktvOERWRGgvaTM5SDF1UnlQWVl2VFJpOGFGYUZsb2o2VTdER21M?=
 =?utf-8?B?ZUhWa2lEUC9hZ3VJUENsUURYK3M5ZHh0bDRydXVTV29BMGxqYUQyU2U0a2pO?=
 =?utf-8?Q?98b7shzy+80aH8o7qY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5aeecc4-df37-47e2-a910-08decba5f18c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:11.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dopG0VaPzf2xCirxuP8Nrj23PDz519b9wxFMeUB98Ko0qE6G7NnF4jxrV956elbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

On 6/16/26 13:37, SHANMUGAM, SRINIVASAN wrote:
> AMD General
> 
> Hi Christian,
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, June 16, 2026 2:32 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 3/5] drm/amdgpu: Signal SCRATCH EVENTFD notifications
>>
>> On 6/12/26 07:52, Srinivasan Shanmugam wrote:
>>> Signal SCRATCH EVENTFD subscriptions when user queue restore detects
>>> missing VA mappings.
>>
>> I think the scratch event is meant for something else.
>>
>> When a core VA to run the queues is missing (WPTR, RPTR, ring buffer etc...) we
>> have a hard and unrecoverable error for this queue.
>>
>> But scratch handling is a different interface as far as I know.
> 
> If a queue cannot be restored because its VA mappings are missing, what notification would you expect userspace to receive? Is SCRATCH appropriate here, or should we handle it differently?

Differently, we probably need some notification for per queue error handling.

Regards,
Christian.

> 
> Thanks,
> Srini
> 
>>
>> Regards,
>> Christian.
>>

