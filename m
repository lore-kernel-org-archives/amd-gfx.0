Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52ECC021B0
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 05:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237FC10E17B;
	Thu, 20 Feb 2025 05:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HD8Eg+Sf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1476D10E17B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 05:28:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K60gLXfbxNnO+cDH0SYmNyWpFbCgUPo/TA3BYHvEql+sSAhplLJeegtAgAg3AU4p4VU5pCi91RWxiBlcCR9JdJqjHeYN62+wYuskl6jxtJocoZPevMwyWptA016x8BLT21/e5EoNvgv6t3iv99P6bXfyk6YqhF91PiyDNAnYaAo6oV1TV17SvNvu+U/BjlQy9mj9U5da0enooXK8zY4+99UlqqxPm9uhYHOd5QZ04HI0H4RLDnhjOr38gB21TTP+f+KBuS115sK02TcfmTG7P0VpzZ/7/mPGvRiMB85bF35snNosVBKuSud1T25tj7cC6qM/0CbYHlBOxHn3vv42qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoD2UufcV9RqKT7N5aeR/fWF+ZgRNitPNhvA7IZ0ipU=;
 b=x1DOVaGrTEkPgEeKIqnkypCQyCB+58aezH1SpX6AAKTT0DC3ZT0fWgtu5E7g3MD+Iowe4pAqErx+R8MnnQuZn7EDgRAkxR0yVQmkQSIp6hh03nfcmvuQLdUafpgGFAl9W/qXspXrkeQau5ApsElxmlV8OIHVcKv8NIpX7mt6pPVRLmk75+eBNLmS/dHGbXDMnMAgYbdBTiVEWkZ6hOvDlzG35X3ZDnWpUKd30YZt+pfngyu+rRl4kkUjMW3aRLxskuvResd0pMK9UMvxeukyEYuyEeaLTkOh8HWl7ZliRBI9YVujDmraH5oFXiD2aROoq7rzyznFZpM2wNuHF8FIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoD2UufcV9RqKT7N5aeR/fWF+ZgRNitPNhvA7IZ0ipU=;
 b=HD8Eg+SfdN6Wdd9xYbRIDIM2jtHddAUyMXO9tGl6fdVtnJ86xSem7ZfyFu+M5XBjFmSLmVzD1Dkex9LMv1xpxdsB7H4m1WH8PIGyd+I5Tymp4j7pPbDe1m8zZ8+3vXULk7k6l2Z9U9ATTFKDuEnjlKwZ88C7iNwh7a9Ie7AkV5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 05:28:47 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 05:28:45 +0000
Message-ID: <a3527330-c47f-4b7f-9c5b-a2816bc09a43@amd.com>
Date: Thu, 20 Feb 2025 10:58:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix Circular Locking Dependency in
 'svm_range_cpu_invalidate_pagetables'
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <yangp@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Alex Sierra <alex.sierra@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250218160130.810595-1-srinivasan.shanmugam@amd.com>
 <5348d3b3-a9eb-24cf-b6cc-33e433bacb7c@amd.com>
 <41eea943-18e3-460b-a088-e2325b9a3064@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <41eea943-18e3-460b-a088-e2325b9a3064@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6a1329-d885-4c94-99a9-08dd516f71d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWNidTFLNmhGZVpmY1oyYjFRblh5M0xPNjcvS25Sb2VxRWZIMjVlZUxxYUY2?=
 =?utf-8?B?cFY3alZ1REZPbncrVHdDeDJ6UmhKcHpLZzkxeHNiQ2dHL3VFNWhFN1doT0xY?=
 =?utf-8?B?UWdxckd5K05ZWk5vQ0lCVmVTYUdDTTFHRUdIYjlXYWNlYm9IeG9tb2IrTXV1?=
 =?utf-8?B?STZabXp3OHgxTittRm1Dc3g5Vk01R1hPdlo0VmpVQUFBYlJ0S3VycFp0TXV1?=
 =?utf-8?B?NnJHNTVuWlo3RkxqVmdzWnVQaEtKRm9hcDhNYlZrNk9PMElkRTFlRHpmbGJj?=
 =?utf-8?B?VFVvWVFkdFVFb2lUdEFBRzBwU3FJT1dJczJZc0thRHlkK1RIQVZ0N0gxaDI1?=
 =?utf-8?B?UW0rcEs3d0ZOZHNId1k2WTBFSndsOXc5WWYxQ2dxTlVrQmoxdjJkQ1NDcVlw?=
 =?utf-8?B?K1AzckZWWU1hLzZoUUVVMVVFRXRUKytPUjErdUo3NHFTbnZiRmhrei9jdlZr?=
 =?utf-8?B?aXhBYjRRSHFJbkVnWmtsaU15b2FsWlVNMTE2MVpENElDY1dSVmhiMjZCY3dT?=
 =?utf-8?B?Z0hxWGwzZXd4MDBoWk1RZE0zWENDYXh5bk5ONlU5NHZ6ckFnWldDaTN4dlNS?=
 =?utf-8?B?Z1dOTmpvdjkzck5mdGVuU3pmY25GSEZTcnh4Z1FxSkdmNjkyM2ZKTWZvK3ho?=
 =?utf-8?B?bGdNYzBIZWRtbEc0Q0hpQ2VCYW9GWEFhdjd6b0NFV2hITFltaVZXMmtCZUhu?=
 =?utf-8?B?R3JUSDk4cXkzeG9jODVwVGhnSkxCdThMNzVHT0h2MHRWajFGQjlYS3NzRnJS?=
 =?utf-8?B?ekpEcHgvQ0JrQWZhN045a1JPNTIvaCtWVlc4V01LM0lxRUdIVmtXWnV6SG5F?=
 =?utf-8?B?MzY3VG1HQk9uR0MyUkVyTzBjc1dSdUxPUzVNUmlSZkhZNkZ1eGorUEd5NUhU?=
 =?utf-8?B?ZFoyZ1JCOC9XM201ZG1mbTBjaWJMUkhidjAxSFFOd09VcDQwU2x5QktWOWts?=
 =?utf-8?B?UWJYNVpZN216ckFVc21FMnJOTUV3Zjc3RmVBSER5dUQyaXdBTzRjZ0oweFM0?=
 =?utf-8?B?bWNwYkhSamxxNVR0L0h3cVAxN0xpR3o0RkhsUXE5eFFGSVJJQWZaeHU1Lzh1?=
 =?utf-8?B?cGpvMW5Vdk1qaXdlNEludE8xRjcrNU5iZlJGcnU0eVdkZldpaW5ZS3FQUHd3?=
 =?utf-8?B?c214QWJvaHN1TDAxdENvVWZjMzZrRit6MXVrdnBXU3Zxc3lXZnpGTnNybVFP?=
 =?utf-8?B?Z2x5S0EweHdhVS9BNGgrc0ZiUitodytSQ3JzQ3V2eWhyeC9ibnloUUVmUTdE?=
 =?utf-8?B?RmFqMm9iQ3V6d2ZwdmdsVEZBUWVRQ0JNLzFjTE1iYXMyY3JUbGtheUJ2OFZ3?=
 =?utf-8?B?SUt5UG5VR3g4aXBveXAwQlo1QldERG1CajFMUU1TUWNIbExQYlBneE5ER3Jy?=
 =?utf-8?B?dTczWHdkbmRtdUc4dmpDTVZ0Y0JDNHd5ZTlzMDlpN0M0VE44T3VveTlYaEFX?=
 =?utf-8?B?ZzN3N1FCQWk4WWpjeHFWYkE4TmFUczdaV1NGTzN4cW1ndW0xaHBycEtZaFB6?=
 =?utf-8?B?SWpldyt0bTBQZmhFZW1weTJYYU9lbkZxaG0xRWVwdlpDbVVnWWJlTXNuNmFX?=
 =?utf-8?B?OTVFUWJBaDc0ZXFZelN1eG1BdCtocTFJckRwUWR6VkFuWmN2ZW8wb2d1NitZ?=
 =?utf-8?B?cEZQTEhheHlPcjZoZEhrY2tLeS9zemtuMHYyc3A2V3pDYnJnRWd0SFhlZ0c2?=
 =?utf-8?B?ZEg2dmVLajVSdjdoZDZCK0RrTjJ3NGtrVFA4SFlHTm5JZGtOSm1vVmQ3UGw5?=
 =?utf-8?B?WDVtRVkzdHZ0Zytaa3JiV2ZzSVFjNDlTUDVyUjF6T3Q5aTFTRWpzZUdXYlQr?=
 =?utf-8?B?N1ZUb0xDcGF6eHFOM3JmVWwra3l5OHB2SUtyOHBoK1YyRXQ4eE9qdDF4eVFO?=
 =?utf-8?Q?Y111sMwKMZLr6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2I4eHVtdG01eFpwWHJhbnd0UkZEa0RYNlN3RGZUdFpNY0c5WXFockN4K2pG?=
 =?utf-8?B?dldUVW41Ukw2QW15ZnpMMlNqdEJmL3FVZHhvR0JjSUdmcjBHNWY3dXVudGRB?=
 =?utf-8?B?VmJzeVhSaHlXdGpNNDhHOFpVNkNPYitjRlNlUm9xL0lGN0Rldnp2cmtUWmR2?=
 =?utf-8?B?SXEyS3dQelpLY1Rxd3hKR1JLR2tJdlMxdFlpanBSNDZwd2RWT21mRHFsOUx5?=
 =?utf-8?B?UjRvZFRXNmcwRVNSYXgyQ3lPd0dRdnhKL01YcUY1Y3EyT2hTSGJPOWZLenNG?=
 =?utf-8?B?UmxyelpVNVFCY0F2U0NMQVJza25IVHFEdGpPWkpKRzBRSW9xcDNtZlA2VlpX?=
 =?utf-8?B?NStVYXZqR2NFaksxQ0I2VXZCY2RqTk9KbytDbEduNGV4SW5pb243cXJTYUJv?=
 =?utf-8?B?Z0dMYmRWKytWalhsK3ZGdTJKbzFCVkxpNEVSL1lFZ1NyTkRxV1BxcUVvYno5?=
 =?utf-8?B?NkZVVVVhVTQ2REFrdWhOVnV6TWY0SzM0a1g0cjFaVXMzVXdyMENmY3NGRUd5?=
 =?utf-8?B?Y1libzJyV1JXbEUrTUk1K2p3UkFOMVlXR2E1ZEVWT2h4bVoxUzdWcng0Q3BM?=
 =?utf-8?B?N2hLMjVOTmUvY1VkUURRWlRFeWFNbUhtb2wzM3Y1WDRXcTIxZi9JYkM2b3E0?=
 =?utf-8?B?NCsyZDRsaDJFMXNVQU5ublMvNXhWTEhndTdjN0RvUzdmYmlCT1dnRXRrM3ov?=
 =?utf-8?B?bndFZHJabzRPcXFESHFWN1BZTGRIYmxKR00zQWJaNmQvMEt4MVJ6ZXhjSE1a?=
 =?utf-8?B?UnlyZTNCdytUM2hobzlzT01ubHpCT3hRMG9vNU9ocEJBbThxMFZsS0h4MTQv?=
 =?utf-8?B?V0E2elJEVWdrd1Q3WFp0djZjaU85RHBweENVOEUwaStmRWtJU3FFc244b3oy?=
 =?utf-8?B?NTNuTGhCYktPeE1mQXQzeGpHbUhna2hhZVpSVkpaTDBwQU02NGlBTU1MRENM?=
 =?utf-8?B?OGR1NjN4VnpBQVRodTBvWmFyZzdVQnZJTmRVd3dTOWRqRjNwT3p1T2JaNGZh?=
 =?utf-8?B?akFJM05IRjV5d2lSbUNNNlVMekVRVkNWcjhHdERTTWNvc3FabHpRY3JYWmVZ?=
 =?utf-8?B?RC9BZ0VKVkx3SldQZkFseEszWmd0MTM5bnQ3R0NVb0lYN2YyU3ArQlh0UWdx?=
 =?utf-8?B?S3NaL0J1L2oxUHZCUlF4OEJubmJqTU5hemV3Y0JvUmI3TEdQSzk5NDhXbmwy?=
 =?utf-8?B?emhtU2JxVnpOMlZhb2xpMUREb1oxa3FhL05lOGFRcEJOeVlsOFVzYVBicVUz?=
 =?utf-8?B?UXhoaWpDVVNiREViM05Ec3hHN0dEejhjNnhkQ2RJOFh4eFM5STJHNDJRZUxU?=
 =?utf-8?B?YmlDVXdhWUxNZXA5OFFuR241RGFieFU0NGNseExMWHhLMFZvaDVQektlTkVK?=
 =?utf-8?B?SG8zNUhDNEN4UmNmOXZSMCtJQk85cE9Ba2g3RmpzclpKeTZINXZuRTlJdm95?=
 =?utf-8?B?bVFUd0tSVkpwQTE2YWcvdmtXank3STJGeEI2enpBSzMrRWZPVjRVczNrMWJ5?=
 =?utf-8?B?cmduQzJycGl0dDVVa29VeFI4ZndycTZ1Sk1DS0xzRGhHU2xMalJHTG40Wmhx?=
 =?utf-8?B?NzBOVE9uNTJHZTRjb3JSVGxYV1NlQXlnNkEyUjFTb2lvUnpBZ01QUStyTWlM?=
 =?utf-8?B?NzlWUnJ4M0VzTmZvVWRUSkFlUG5BRHZvU2YxcGJOM1RxWVd3OWVQSURDMGlX?=
 =?utf-8?B?Q1gzUG92QzZJUUZsZkdqT1JRS3pEd3VvY0pDdjVKcnVHaDMrSzZST0FvSkhr?=
 =?utf-8?B?SW8zSmwvenZseFo3T01KTTR5UW03QzZOZko4QmxoQ1RFVjd5YVBDK2pzeHJC?=
 =?utf-8?B?eFYxWng0MW1hSWlCZi9ma2huNHNYZ2ZDdG9WclVlTmVQMWZxdWxmY0UzU25o?=
 =?utf-8?B?NW5TbGJoMXdsRGFMUlgzb21tSmFRVEh3Z0E5VXBqaHJyc2NKL3NMd2laWmQ1?=
 =?utf-8?B?bkVsenRzRnVTVE9rL0pqT1gwQkUzVVRnRStZVkk5T2hBMDdXakxtU3lWUjhh?=
 =?utf-8?B?eS91YzZBTlp4eWZicktNbkZQZ1Rpb1g0VTlsV2lrQmdkUnRRK0dRbVdFNjM0?=
 =?utf-8?B?aC81clJLd1VZeS9Sc0pRSXhWR3V4cVAwTXd5cmhERkVTNzlEUXVXQVhsWFR3?=
 =?utf-8?Q?Vo+OyPRl48kofPdFjin/ofW33?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a1329-d885-4c94-99a9-08dd516f71d7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 05:28:45.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1DuSLoYKoqwyXxaR8kKpI0pqfxxmlr2BF4iR5fvu328e0+BQsy0vLXBGCW8jZV2vWelgiala6shFHZTh8ExeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
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


On 2/20/2025 10:25 AM, Felix Kuehling wrote:
> On 2025-02-18 15:51, Philip Yang wrote:
>> On 2025-02-18 11:01, Srinivasan Shanmugam wrote:
>>> This commit addresses a circular locking dependency in the
>>> svm_range_cpu_invalidate_pagetables function. The function previously
>>> held a lock while determining whether to perform an unmap or eviction
>>> operation, which could lead to deadlocks.
>>>
>>> To resolve this issue, a flag named `needs_unmap_or_evict` has been
>>> introduced to indicate if an unmap or eviction operation is required.
>>> The function now unlocks the `prange` lock before performing the
>>> necessary operations, ensuring that the critical section is minimized
>>> and preventing circular dependencies.
>>>
>>> Fixes the below:
>>>
>>> [  223.418794] ======================================================
>>> [  223.418820] WARNING: possible circular locking dependency detected
>>> [  223.418845] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
>>> [  223.418869] ------------------------------------------------------
>>> [  223.418889] kfdtest/3939 is trying to acquire lock:
>>> [  223.418906] ffff8957552eae38 (&dqm->lock_hidden){+.+.}-{3:3}, at: evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>>> [  223.419302]
>>>                  but task is already holding lock:
>>> [  223.419303] ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
>>> [  223.419447] Console: switching to colour dummy device 80x25
>>> [  223.419477] [IGT] amd_basic: executing
>>> [  223.419599]
>>>                  which lock already depends on the new lock.
>>>
>>> [  223.419611]
>>>                  the existing dependency chain (in reverse order) is:
>>> [  223.419621]
>>>                  -> #2 (&prange->lock){+.+.}-{3:3}:
>>> [  223.419636]        __mutex_lock+0x85/0xe20
>>> [  223.419647]        mutex_lock_nested+0x1b/0x30
>>> [  223.419656]        svm_range_validate_and_map+0x2f1/0x15b0 [amdgpu]
>>> [  223.419954]        svm_range_set_attr+0xe8c/0x1710 [amdgpu]
>>> [  223.420236]        svm_ioctl+0x46/0x50 [amdgpu]
>>> [  223.420503]        kfd_ioctl_svm+0x50/0x90 [amdgpu]
>>> [  223.420763]        kfd_ioctl+0x409/0x6d0 [amdgpu]
>>> [  223.421024]        __x64_sys_ioctl+0x95/0xd0
>>> [  223.421036]        x64_sys_call+0x1205/0x20d0
>>> [  223.421047]        do_syscall_64+0x87/0x140
>>> [  223.421056]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  223.421068]
>>>                  -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
>>> [  223.421084]        __ww_mutex_lock.constprop.0+0xab/0x1560
>>> [  223.421095]        ww_mutex_lock+0x2b/0x90
>>> [  223.421103]        amdgpu_amdkfd_alloc_gtt_mem+0xcc/0x2b0 [amdgpu]
>>> [  223.421361]        add_queue_mes+0x3bc/0x440 [amdgpu]
>>> [  223.421623]        unhalt_cpsch+0x1ae/0x240 [amdgpu]
>>> [  223.421888]        kgd2kfd_start_sched+0x5e/0xd0 [amdgpu]
>>> [  223.422148]        amdgpu_amdkfd_start_sched+0x3d/0x50 [amdgpu]
>>> [  223.422414]        amdgpu_gfx_enforce_isolation_handler+0x132/0x270 [amdgpu]
>>> [  223.422662]        process_one_work+0x21e/0x680
>>> [  223.422673]        worker_thread+0x190/0x330
>>> [  223.422682]        kthread+0xe7/0x120
>>> [  223.422690]        ret_from_fork+0x3c/0x60
>>> [  223.422699]        ret_from_fork_asm+0x1a/0x30
>>> [  223.422708]
>> This hold dqm_lock, then allocate pdd->proc_ctx_bo and map to GPU, it is illegal usage.
> Good catch. The problem was introduced by this patch after a suggestion I made in a previous code review, to allocate this buffer in a lazy fashion when the first queue is created.
>
> commit 3e5199134e47745256c3be448ca466d06acaebde
> Author: Jesse.zhang@amd.com <Jesse.zhang@amd.com>
> Date:   Thu Dec 5 17:41:26 2024 +0800
>
>      drm/amdkfd: pause autosuspend when creating pdd
>
>      When using MES creating a pdd will require talking to the GPU to
>      setup the relevant context. The code here forgot to wake up the GPU
>      in case it was in suspend, this causes KVM to EFAULT for passthrough
>      GPU for example. This issue can be masked if the GPU was woken up by
>      other things (e.g. opening the KMS node) first and have not yet gone to sleep.
>
>      v4: do the allocation of proc_ctx_bo in a lazy fashion
>      when the first queue is created in a process (Felix)
>
>      Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>      Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
>
> I guess a better approach is to allocate this buffer somewhere in pqm_create_queue when the first queue of the process is created, rather than when it is added to the MES scheduler. That should be outside the DQM lock. Do it with a condition that applies only when MES is enabled.
>
> Regards,
>    Felix
>
thanks for all your feedback's, will go through all your feedback's, 
analyze, and propose v2 again.

Regards,
Srini

>> Not sure but seems pdd->proc_ctx_bo/proc_ctx_gpu_addr is only needed by debug mode path, as kfd_dbg_set_mes_debug_mode also allocate proc_ctx_bo, the proc_ctx_bo allocation should remove from add_queue_mes, and move the allocation into kfd_create_process_device_data if this is also needed for non debug_mode path.
>>
>>>                  -> #0 (&dqm->lock_hidden){+.+.}-{3:3}:
>>> [  223.422723]        __lock_acquire+0x16f4/0x2810
>>> [  223.422734]        lock_acquire+0xd1/0x300
>>> [  223.422742]        __mutex_lock+0x85/0xe20
>>> [  223.422751]        mutex_lock_nested+0x1b/0x30
>>> [  223.422760]        evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>>> [  223.423025]        kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
>>> [  223.423285]        kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
>>> [  223.423540]        svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
>>> [  223.423807]        __mmu_notifier_invalidate_range_start+0x1f5/0x250
>>> [  223.423819]        copy_page_range+0x1e94/0x1ea0
>>> [  223.423829]        copy_process+0x172f/0x2ad0
>>> [  223.423839]        kernel_clone+0x9c/0x3f0
>>> [  223.423847]        __do_sys_clone+0x66/0x90
>>> [  223.423856]        __x64_sys_clone+0x25/0x30
>>> [  223.423864]        x64_sys_call+0x1d7c/0x20d0
>>> [  223.423872]        do_syscall_64+0x87/0x140
>>> [  223.423880]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  223.423891]
>>>                  other info that might help us debug this:
>>>
>>> [  223.423903] Chain exists of:
>>>                    &dqm->lock_hidden --> reservation_ww_class_mutex --> &prange->lock
>>>
>>> [  223.423926]  Possible unsafe locking scenario:
>>>
>>> [  223.423935]        CPU0                    CPU1
>>> [  223.423942]        ----                    ----
>>> [  223.423949]   lock(&prange->lock);
>>> [  223.423958]                                lock(reservation_ww_class_mutex);
>>> [  223.423970]                                lock(&prange->lock);
>>> [  223.423981]   lock(&dqm->lock_hidden);
>>> [  223.423990]
>>>                   *** DEADLOCK ***
>>>
>>> [  223.423999] 5 locks held by kfdtest/3939:
>>> [  223.424006]  #0: ffffffffb82b4fc0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1387/0x2ad0
>>> [  223.424026]  #1: ffff89575eda81b0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x13a8/0x2ad0
>>> [  223.424046]  #2: ffff89575edaf3b0 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x13e4/0x2ad0
>>> [  223.424066]  #3: ffffffffb82e76e0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: copy_page_range+0x1cea/0x1ea0
>>> [  223.424088]  #4: ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
>>> [  223.424365]
>>>                  stack backtrace:
>>> [  223.424374] CPU: 0 UID: 0 PID: 3939 Comm: kfdtest Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
>>> [  223.424392] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>> [  223.424401] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
>>> [  223.424416] Call Trace:
>>> [  223.424423]  <TASK>
>>> [  223.424430]  dump_stack_lvl+0x9b/0xf0
>>> [  223.424441]  dump_stack+0x10/0x20
>>> [  223.424449]  print_circular_bug+0x275/0x350
>>> [  223.424460]  check_noncircular+0x157/0x170
>>> [  223.424469]  ? __bfs+0xfd/0x2c0
>>> [  223.424481]  __lock_acquire+0x16f4/0x2810
>>> [  223.424490]  ? srso_return_thunk+0x5/0x5f
>>> [  223.424505]  lock_acquire+0xd1/0x300
>>> [  223.424514]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>>> [  223.424783]  __mutex_lock+0x85/0xe20
>>> [  223.424792]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>>> [  223.425058]  ? srso_return_thunk+0x5/0x5f
>>> [  223.425067]  ? mark_held_locks+0x54/0x90
>>> [  223.425076]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>>> [  223.425339]  ? srso_return_thunk+0x5/0x5f
>>> [  223.425350]  mutex_lock_nested+0x1b/0x30
>>> [  223.425358]  ? mutex_lock_nested+0x1b/0x30
>>> [  223.425367]  evict_process_queues_cpsch+0x43/0x210 [amdgpu]
>>> [  223.425631]  kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
>>> [  223.425893]  kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
>>> [  223.426156]  svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
>>> [  223.426423]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426436]  __mmu_notifier_invalidate_range_start+0x1f5/0x250
>>> [  223.426450]  copy_page_range+0x1e94/0x1ea0
>>> [  223.426461]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426474]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426484]  ? lock_acquire+0xd1/0x300
>>> [  223.426494]  ? copy_process+0x1718/0x2ad0
>>> [  223.426502]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426510]  ? sched_clock_noinstr+0x9/0x10
>>> [  223.426519]  ? local_clock_noinstr+0xe/0xc0
>>> [  223.426528]  ? copy_process+0x1718/0x2ad0
>>> [  223.426537]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426550]  copy_process+0x172f/0x2ad0
>>> [  223.426569]  kernel_clone+0x9c/0x3f0
>>> [  223.426577]  ? __schedule+0x4c9/0x1b00
>>> [  223.426586]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426594]  ? sched_clock_noinstr+0x9/0x10
>>> [  223.426602]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426610]  ? local_clock_noinstr+0xe/0xc0
>>> [  223.426619]  ? schedule+0x107/0x1a0
>>> [  223.426629]  __do_sys_clone+0x66/0x90
>>> [  223.426643]  __x64_sys_clone+0x25/0x30
>>> [  223.426652]  x64_sys_call+0x1d7c/0x20d0
>>> [  223.426661]  do_syscall_64+0x87/0x140
>>> [  223.426671]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426679]  ? common_nsleep+0x44/0x50
>>> [  223.426690]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426698]  ? trace_hardirqs_off+0x52/0xd0
>>> [  223.426709]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426717]  ? syscall_exit_to_user_mode+0xcc/0x200
>>> [  223.426727]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426736]  ? do_syscall_64+0x93/0x140
>>> [  223.426748]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426756]  ? up_write+0x1c/0x1e0
>>> [  223.426765]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426775]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426783]  ? trace_hardirqs_off+0x52/0xd0
>>> [  223.426792]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426800]  ? syscall_exit_to_user_mode+0xcc/0x200
>>> [  223.426810]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426818]  ? do_syscall_64+0x93/0x140
>>> [  223.426826]  ? syscall_exit_to_user_mode+0xcc/0x200
>>> [  223.426836]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426844]  ? do_syscall_64+0x93/0x140
>>> [  223.426853]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426861]  ? irqentry_exit+0x6b/0x90
>>> [  223.426869]  ? srso_return_thunk+0x5/0x5f
>>> [  223.426877]  ? exc_page_fault+0xa7/0x2c0
>>> [  223.426888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [  223.426898] RIP: 0033:0x7f46758eab57
>>> [  223.426906] Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
>>> [  223.426930] RSP: 002b:00007fff5c3e5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
>>> [  223.426943] RAX: ffffffffffffffda RBX: 00007f4675f8c040 RCX: 00007f46758eab57
>>> [  223.426954] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
>>> [  223.426965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>>> [  223.426975] R10: 00007f4675e81a50 R11: 0000000000000246 R12: 0000000000000001
>>> [  223.426986] R13: 00007fff5c3e5470 R14: 00007fff5c3e53e0 R15: 00007fff5c3e5410
>>> [  223.427004]  </TASK>
>>>
>>> Fixes: 4683cfecadeb ("drm/amdkfd: deregister svm range")
>>> Cc: Philip Yang <Philip.Yang@amd.com>
>>> Cc: Alex Sierra <alex.sierra@amd.com>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 +++++++++++---
>>>    1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index db3034b00dac..a076269cce7f 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -2574,6 +2574,7 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>>        struct svm_range *prange;
>>>        unsigned long start;
>>>        unsigned long last;
>>> +    bool needs_unmap_or_evict = false;
>>>          if (range->event == MMU_NOTIFY_RELEASE)
>>>            return true;
>>> @@ -2597,14 +2598,21 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>>          switch (range->event) {
>>>        case MMU_NOTIFY_UNMAP:
>>> -        svm_range_unmap_from_cpu(mni->mm, prange, start, last);
>>> +        needs_unmap_or_evict = true;
>>>            break;
>>>        default:
>>> -        svm_range_evict(prange, mni->mm, start, last, range->event);
>>> +        needs_unmap_or_evict = true;
>>>            break;
>>>        }
>>> -
>>>        svm_range_unlock(prange);
>>> +
>>> +    if (needs_unmap_or_evict) {
>>> +        if (range->event == MMU_NOTIFY_UNMAP)
>>> +            svm_range_unmap_from_cpu(mni->mm, prange, start, last);
>> This is incorrect, we should hold prange lock to split prange.
>>
>> Regards,
>>
>> Philip
>>
>>> +        else
>>> +            svm_range_evict(prange, mni->mm, start, last, range->event);
>>> +    }
>>> +
>>>        mmput(mni->mm);
>>>          return true;
