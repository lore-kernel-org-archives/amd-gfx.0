Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA867C021A6
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 13:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBD610E313;
	Fri, 14 Feb 2025 13:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VcrZSd3g";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6441510E313
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 13:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT/mmWxCRgoG7a1SJ8rzUUx9NMF0AuyMWSM3mnd9Piu2x3MgMzNGsOkI22TGhKyzzp8suZKdY3BVdonArhbu4QZ9GCjGiLItRcHbaX1CmJSHLdU/zOy4xCSfw2lGuzGgCnu5SxLMIGYUiPGB5DH5PbKm2yGUE2su9t1xiswrjWuXOn7EASGKu+6pP5FUusAJBeJ8hOMQPpcYL8AStjCNkk3GxJ6uwTFH6I/1270WlkNWQGRNEefEqRdgAXi+d4SYJUYfBkrhdSfpGUZrjRhcL8tooQFDLlLQKi+gnyi4W6AG4mfMz/EsBLMKsIa6atCeDIdUYKbDpL+j93GVyoFkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgCdq9vqaCNIiveeBnGY/YBhxwNtWpo/YDcxu1dh8G8=;
 b=GuLNzBEJ3QL+Wem/5GG+nXEkjNo+k3PTC9fB2Bb0lh6dI/kkL27r3B6//+LEtDBK7PuPFP+DfFrrZiOg4OBOYBA0j8tiXBLGbg0vTC/YvMBTLOg+xWj2KLkS7iCnYEMpR8HXRk3vGKmS2Lj6SrZjNEOlcgXJx4OOyZxukvxvlVB/wVxBDjjCmYj9l0TOD4fyBeVsjnNOGz8xetLjc850GDdGvP0CgB9/gjjziPUe2C0CLhvctAipkYJS9yD7N+vqXb0vLkUvuNOIByP9lIFi4NBINuTc+e8NdOaugFXS+ytcaxnqRMkzdghhm5swZIVUAT+Hwpq9KSgtl02spB8BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgCdq9vqaCNIiveeBnGY/YBhxwNtWpo/YDcxu1dh8G8=;
 b=VcrZSd3gc1pz9HCoYF3jypfQSMKm7TPWdse51xASqRo4Am52d50C/4C1CETNEQXCwV7I3dajdwVlu/cxnB6YzFXjGwpF9idb2D6MPzzeExNeBKMg9ikwjfFu3tISNlMdeQrDr0BRZXfkvaao44PZ47jUgtFXliMKO6P/Pa2wPks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 13:02:09 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%7]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 13:02:08 +0000
Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not
 released
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
References: <20250214100718.2663073-1-le.ma@amd.com>
 <0e49dc7a-d932-403c-88b5-9b16ab9477d0@amd.com>
 <13d5afc4-4f97-8fe7-0c05-647bfb768abc@amd.com>
 <PH0PR12MB5420391BB3877E5DF10F1451E0FE2@PH0PR12MB5420.namprd12.prod.outlook.com>
 <432061f2-1695-4a18-bbdd-228949b73037@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <98e7fc39-2635-6510-75e5-d08369b9a095@amd.com>
Date: Fri, 14 Feb 2025 18:32:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <432061f2-1695-4a18-bbdd-228949b73037@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::35) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|CY8PR12MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: f876ed43-be58-4af2-d6c3-08dd4cf7c9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkRyemlWQjJpR1o4cEpJL2ZXQkdyUENHN3U4SFdKdk91OEJqS0d3VDNHdVFp?=
 =?utf-8?B?OGtpYm9OU2hWYXdvY2NsQjd5RTRxdDU4US9HdzRxZG93eERLSkMwOWxyS3hj?=
 =?utf-8?B?a0FWZWNHVXY2WDNEY3pxTDZ4Tzg3ZWF5azVEaGd5bmhxekNUejRIQWw3V3Fu?=
 =?utf-8?B?SURjNUpPZWlEN1A1SitwQmlJUjhuUmZvT1Rid21MN0pEZ2d3WFh2M29Yazlu?=
 =?utf-8?B?NFpVaFVlUkh0amFmRWxWUkFkYWttdWpGbXpQQlBuN0JvK0VTOEtUWVptakMz?=
 =?utf-8?B?Z3B4eDVpMUI3ekJWc1pwbDQxQ3dPK0cxOElZQmZnb2puUzV1Sk5IZ0VqNGdu?=
 =?utf-8?B?cVBTZ0VDVjd1NmxBcTRyK2NYSGhzdTlUczVwNEhRbWJhekN2OE5PN0U4RmVE?=
 =?utf-8?B?dkJVamFJeW1FVGRZNjNGK01DaVc4b2FSbHN1OWl4cEN3dUtqVkFEMkIxMVVL?=
 =?utf-8?B?Q1NZb094ZHl4dzJXeDlwT0JtckFXV0JJTDdBTUgvUWJxeUFENDl1NTB2NmIz?=
 =?utf-8?B?NUwrU2hHMDVYQ2tYdTg2VGR5VDZOR3dqVkVMQTJSTWJIbmc2amc3d3ZZbENE?=
 =?utf-8?B?RFFGTkgrYlBYZWJ5R2hmclQvY0tRamZmdklydWtrVEFJbzZmNDFEOUtON09r?=
 =?utf-8?B?MkIrS01Pa1ZrQThleDI5MGxHWjkybGI3SHRHNnovSXlmWG5HYmJoMXdIZTlX?=
 =?utf-8?B?TStreWJib0FBNU4xbmxFYXo0Tk85Y0JOVnNXTTZpKzBIUjJHcUtMVHdVL2tm?=
 =?utf-8?B?VitGaFk5alVjOStoQkhZVDZvUU1nZWR6aERyeGNIV3dyWXJabEkxaHQwblYz?=
 =?utf-8?B?Qjc0UFBwdzFyUndTcm45ZjYzaC9sdk9ISlA5OHAvSkJQTEpYQmUwLzhzYjEv?=
 =?utf-8?B?RVMyK0N2dVZxRnZqRVJMaVZJRFBJSDZqU0xWZGNKR1EwaW5UY3poV3VBQ1FK?=
 =?utf-8?B?cjdRckVBUlIvRFJ6UUVyOU95NlhpS1hxNzZDTDcvZkdISndrTnNnUXRrWnA2?=
 =?utf-8?B?aHJmK3FqakpQWWcyRzNmZ09iU2lJK083RGJEaU55RkpOaUV1UXkxRGZzSG1p?=
 =?utf-8?B?QThJbU1KVkpibDI1MDhmYjgxMDBaQjI4ZktTNUpjd2hnVUgwellzL3JIVjFI?=
 =?utf-8?B?ZzhPQW5jRVlJb1h2VEk0WGFrdURDSmNPWDdrc0V3TUhjKzQxY3RLTkZ4elRS?=
 =?utf-8?B?TlRnVVY2YWZlSXFkWld3R1FjbWlKKzREc2ppUk83Z3hMYUxJMjl6bTdRMWI5?=
 =?utf-8?B?WUt1SlZXNVF6WFdJSXdHMGJwc28vcnZic1JxK1JnTkhkd0RmMzhLWTMxMkc0?=
 =?utf-8?B?VXFreG1iTmtsK0ZFS1hCR1RUVW9MRmRSSURZR1E1ditqK2hKbTc3Y3V3a2Zl?=
 =?utf-8?B?c3lRTWNtR1BON1pQRTVWWEpYbElnKzRhVWs1VkVBaUZ2VHB2d09Dc3hNcGRi?=
 =?utf-8?B?aU05LzZnR1QzWlptcWJiZUFsa1pnSkxYdjltQnZSODFKVit6aktaMFJibFgy?=
 =?utf-8?B?dExmdDJGMGpWRGRmK2YwUUJOMHlEaHd1OEVLSzhyQ3Zzd0hmSUJxUGwvVWdU?=
 =?utf-8?B?NUM5OWpyVm5xYzBCWjE4S3d5V0tpVWY2eXQ2emVLclF3RmdDeWJNbjNvQVlG?=
 =?utf-8?B?QTVnSFIzMVAxSVIyaDBaSVA5VlZBNjk1MFUrVHl0OGJpaWVXZTNCeEVJeUNS?=
 =?utf-8?B?ajJqL05VMHlOZWpwSWpHM0JmNmczTmhRbkUrZnRId2QzN1doS2J1K0dUYUFJ?=
 =?utf-8?B?WktSUWVqVDRRaUJZekQ3THQvQjdTWGhDNXRWVTEydkdBTzFDK0pnWWhOWE5G?=
 =?utf-8?B?Q2FNa1lmeCtTS20vVEVjU0NBYXNtcDNaY3RHUys4MjR1L25qanRSK3RrRlpZ?=
 =?utf-8?Q?xq41NSNEnjWuY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxtNkgwTU85NlpXRzJQQ05EdXYyUnZFWElSRklDVTVjSVJqY2xXejdmOThD?=
 =?utf-8?B?QmZXMDhOdTdKWWx2VDZkZE9WVGxYcTh2VDFpNnlpc08wbDNEMFViNU8vQmdX?=
 =?utf-8?B?aTI2TklCZjlwV3NSbDd6WE9sMjMyYVNtUVZOWEU3U3M5T2E3SjNIT2Roclcz?=
 =?utf-8?B?clFheUVSMEhnT0JWUjNHYWFNVk5DL3BhLy94MHByM2NUNWpCTXo2TUQwZ0xz?=
 =?utf-8?B?eStZY0UwVStUQkxjQkJudjltUGlGREtETzBzK20vZ2FDSGpJNElVQXFSdlE1?=
 =?utf-8?B?VXJwY3g1Rmo4K3djQkRUNU1MZWtYZXlJSVZnZ3FscVFLblRuTWxETkdzN0N1?=
 =?utf-8?B?dlMyUnJMbkVqdG1iTTk2dG1NRmlFMnBLZWxXdjdlc1FXU2FFOGlEaFRGN3Jk?=
 =?utf-8?B?Yk9JTmhWU0NPMmtteC9xRXBSbVBPbE1lRkhGTzIydy8yZWlQMWtUQlhhSnpS?=
 =?utf-8?B?M0tib3k1THNzMGlJVmdHVU5oZ0ZWWVEwUGoxcUhTN2dKOHpTMjhZUFgrN2ww?=
 =?utf-8?B?UUdTcHRGQkhsL01BR0QzYnFRMmlyeDBFUW15Y3lXajNCa3dYUitvWllCTXdV?=
 =?utf-8?B?c3VWaFRCV2lVNUczQ0VjQkxIMzJ3Njh5WDJnMTRibk01UC9maEdRdENDOXpR?=
 =?utf-8?B?OVZlZUluaC9mbFlKd28yZzl6SEVSSCtLWjd3MjdPSENvL25vaEpkZ0daMmhs?=
 =?utf-8?B?cllvZU9QNDNRbGJGYTd4dm0wM3doYnEvS3lhVUlKSGhLaGRjL0QxTENnd3Qx?=
 =?utf-8?B?RCtnWUs5QzlDQ2tmN1hnLzAzN1BBOW9SV3dNOTJONlUvdFE3T3NzR1BnWkhR?=
 =?utf-8?B?akdrbEdtU1JYc3BjUFdZaUMvQytHc1pMZWRKMFlaS3JEdHVRVG1hakpIM3Ru?=
 =?utf-8?B?QVpEUGdGMlVibnBaRlFDTEVOQTQ4QUZCZDBLU3lKWGtlNm16cFBYci85RGRS?=
 =?utf-8?B?b1kra3U3QnE1b0RnNmFJMUNjUTZ3MDJHMkFjZVg4ak9Gd2dMQlNLdEhBVVF5?=
 =?utf-8?B?T01kN2VBQ0FOQVBzZVZQZUZvWkNSckdNZEFKd3FSRnhKc0F0b0FhbUFBOThC?=
 =?utf-8?B?d3pJcGhIbWpLQmUyQmp5SVFaT2xmS09ZMUw5WkJCNXVUVXZ0R2VqemNQTnF4?=
 =?utf-8?B?N1NndldlUFJtRFFhbWNhRkRZT0FUbWNvZjVGRkNiWnF0YVFBbFJrSWNtWlgz?=
 =?utf-8?B?YjRnbXhEbU9iRnVRQXc1KzFwVjQ3UC9IZWlUU25vYXFoRDNMQ3RZNWs3d3pY?=
 =?utf-8?B?MEF1K0Rqd1F6TDhvQ3ZtSTVZdmFtMjBqOXhTZFNPSS9pWTgraHdWR0V2bWhz?=
 =?utf-8?B?cEt3bXh0eWVuV3A3WFdLckZGODRWRi9SL3FRZ2lEYy9reTRHbjNReFpoN2Yx?=
 =?utf-8?B?QXVOK1J6SWxUMFFHaWRWVitDWFM2ZVBSOHNRVThuRGhCVlZSQm9US1J3RnhI?=
 =?utf-8?B?QVQzMVNWdWU0bTd6UlFFdTdNUlRJZXhXWHN5ZmVpYTFLRHRoUUNjcGQvTnlK?=
 =?utf-8?B?REI0ZW1WWVllU09FcTVESjhFNmwrYWdNU0JCK2hMYmpCY0Z0aWRVOXEwNDBL?=
 =?utf-8?B?TktId3o5amRvRkc3TCthU2pjeFFVeHE5cjl6NGhhSld0cDJleWxQMkppYkVs?=
 =?utf-8?B?QnRrUUxJb3FDd2RTVEhCQWh1NWRzMzY1VWlSWnBjOEE1TW9Qd1Bsc0lHeFp5?=
 =?utf-8?B?R3dsTmdOQVp5RVNLNEY2VmU5SnlxSkVPT1g5dWJxcmU3Z0thMCt0THo1UnRR?=
 =?utf-8?B?QmI1bTV1WHM4Mjl3cVU4cW9QalhqTnVrSExpekNoa1JKWW0vaU1ybkxGMVpF?=
 =?utf-8?B?NkhzbXZDbXJYZWhzTnZ0NUljWGFqTzI5bnRYZFhXZ2lyb1NEUkcvV3FuNXhC?=
 =?utf-8?B?bXphU0ZLZ28xY2h6UFZKVkY4cHk2YStHWlA0WXJ5STNmL2RidDYvUlVzSjRS?=
 =?utf-8?B?UGRFalMrT281d3h1ZVlCZHdoQmc2cHJVUGxRbG80eG1RUnBZTDJUclBFVGtP?=
 =?utf-8?B?R3ErUFRtSitPQ0VMTUJBT0UvbEJMT3lNamQ5ZkNpZHpNNFI2RC9iblVxb1c3?=
 =?utf-8?B?Q0tmTDVQWlZFWk15Y3ZIcUlrOENBK0hRbWVtMGt3L1lNdmsxclQ3T2xkSjJQ?=
 =?utf-8?Q?ysS3RnhIpXMHN8zpkwMyWZdoR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f876ed43-be58-4af2-d6c3-08dd4cf7c9ff
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 13:02:08.7405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtAV2LETQQ2Len8r+GlMBPrwj/zv6mYwjx63O2KzGB9wDyr1PQ+jewpR7uNDtezPxUzbFcWfVw2BPrbBZ5NjRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8297
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


On 2/14/2025 6:09 PM, Christian König wrote:
> Yeah, completely agree.
>
> But not checking the syncobj handle before doing the update is actually even more problematic than leaking the memory.
>
> This could be used by userspace to put the kernel into a broken situation it can't come out any more.
>
> Arvin can you take care of the complete fix?
Sure, I will do that.


Thanks,

~Arvind
>
> Thanks,
> Christian.
>
> Am 14.02.25 um 13:14 schrieb YuanShang Mao (River):
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Better to put the fence outside amdgpu_gem_va_update_vm. Since it is passed to the caller, and the caller must keep one reference at least until this fence is no longer needed.
>>
>> Thanks
>> River
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yadav, Arvind
>> Sent: Friday, February 14, 2025 7:42 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Ma, Le <Le.Ma@amd.com>; amd-gfx@lists.freedesktop.org; Yadav, Arvind <Arvind.Yadav@amd.com>
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
>> Subject: Re: [PATCH v2] drm/amdgpu: fix the memleak caused by fence not released
>>
>>
>> On 2/14/2025 4:08 PM, Christian König wrote:
>>> Adding Arvind, please make sure to keep him in the loop.
>>>
>>> Am 14.02.25 um 11:07 schrieb Le Ma:
>>>> On systems with CONFIG_SLUB_DEBUG enabled, the memleak like below
>>>> will show up explicitly during driver unloading if created bo without
>>>> drm_timeline object before.
>>>>
>>>>       BUG drm_sched_fence (Tainted: G           OE     ): Objects remaining in drm_sched_fence on __kmem_cache_shutdown()
>>>>       -----------------------------------------------------------------------------
>>>>       Call Trace:
>>>>       <TASK>
>>>>       dump_stack_lvl+0x4c/0x70
>>>>       dump_stack+0x14/0x20
>>>>       slab_err+0xb0/0xf0
>>>>       ? srso_alias_return_thunk+0x5/0xfbef5
>>>>       ? flush_work+0x12/0x20
>>>>       ? srso_alias_return_thunk+0x5/0xfbef5
>>>>       __kmem_cache_shutdown+0x163/0x2e0
>>>>       kmem_cache_destroy+0x61/0x170
>>>>       drm_sched_fence_slab_fini+0x19/0x900
>>>>
>>>> Thus call dma_fence_put properly to avoid the memleak.
>>>>
>>>> v2: call dma_fence_put in amdgpu_gem_va_update_vm
>>>>
>>>> Signed-off-by: Le Ma <le.ma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> index 8b67aae6c2fe..00f1f34705c0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>>> @@ -759,7 +759,8 @@ static struct dma_fence *
>>>>    amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>>>                       struct amdgpu_vm *vm,
>>>>                       struct amdgpu_bo_va *bo_va,
>>>> -                    uint32_t operation)
>>>> +                    uint32_t operation,
>>>> +                    uint32_t syncobj_handle)
>>>>    {
>>>>       struct dma_fence *fence = dma_fence_get_stub();
>>>>       int r;
>>>> @@ -771,6 +772,9 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>>>       if (r)
>>>>               goto error;
>>>>
>>>> +    if (!syncobj_handle)
>>>> +            dma_fence_put(fence);
>>>> +
>>> Having that check inside amdgpu_gem_update_bo_mapping() was actually correct. Here it doesn't make much sense.
>> Agreed,
>>
>> Regards,
>> ~Arvind
>>
>>>>       if (operation == AMDGPU_VA_OP_MAP ||
>>>>           operation == AMDGPU_VA_OP_REPLACE) {
>>>>               r = amdgpu_vm_bo_update(adev, bo_va, false); @@ -965,7 +969,8 @@
>>>> int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>>>>                                                   &timeline_chain);
>>> Right before this here is a call to amdgpu_gem_update_timeline_node() which is incorrectly placed.
>>>
>>> That needs to come much earlier, above the switch (args->operation)....
>>>
>>> Regards,
>>> Christian.
>>>
>>>>               fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
>>>> -                                            args->operation);
>>>> +                                            args->operation,
>>>> +                                            args->vm_timeline_syncobj_out);
>>>>
>>>>               if (!r)
>>>>                       amdgpu_gem_update_bo_mapping(filp, bo_va,
