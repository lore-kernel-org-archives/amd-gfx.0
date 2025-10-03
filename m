Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B07DCAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 20:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC4A10E97A;
	Fri,  3 Oct 2025 20:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ejg3VrYc";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C52E8826D
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 20:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqxoxb9jtkTYAqr1VvrXTT4yzH2hMCW0MhR5B+dhYxzRgM2XyWmQ4BWa3fi+QmnY8488hEdzV66SE6XBmkcKOzX+xnP1OhFeEoQgK9vT1sY7vBvREDuRY/Iyh5f5JWNo2BEt+OKwDL0GMJ0f5udEljfw/8PgvM1uME2e3TWWDfB2AHLqtJdO2c4Bp649XH8HtQAJHXbyKO1sbkMblTjhm74kAmmjLCXXcR70JSE5gy1taAaSzWjw9+7hJvsDrB6SysXNMrWHuevzF6P6qY83WlQQGoRu43tGQ1XSs8WL6NIOOywUicgwknfOJjSizlXYj8Bm+horLbvmueyatFhh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c33D4/He1KAqk0MJbWlzoIavFXadWWuYcnVamtNFclc=;
 b=u0cNqClMHz0MOZPpXN/sfg4DRSwGG4XWsfbBe9xNrX/zGnbiWswul9EKh8rcfgkhA1poTcp07rcWGO9K2TpgToQligwjNIrjekKPiZR/eb5fIs3c4lJ79n24IbwGyN9EsvUSVgQhY+SBh9K5XIaIYphndQ6BQ2l1KvZPWRhSIbCRIYheKcwyUTTcSho7UmUyUjfRW60Zi4CO+cqdP/wDmd9mI1i9T8aCskrEtIRvl7Wmh23LtSTURPxhe2ud6YeWIPKmK9tgxr2SgiCTn6hqnurFqq/fEy8ID7QGs5/9/xWraw7zxYWhxzsfe/EkcQSVStoOgW4p6OCmSk2kr6v2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c33D4/He1KAqk0MJbWlzoIavFXadWWuYcnVamtNFclc=;
 b=Ejg3VrYcadglY36rHgmoNNhGPckx0PKPENMru0yhgTTpD8zhjpnnZZnPvLAfeFvhnfALzvlT4INKKPICXbWLLlWqOmEO8Z6k0Zml/pVGPGg18mPwz2+0u1Gsk22xm9UyNNFtEThClcSwPxTri+YHS6FJ5UjfLAlpylP0ML8/LqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Fri, 3 Oct
 2025 20:46:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 20:46:43 +0000
Message-ID: <50e93032-57da-4756-be08-056db1457812@amd.com>
Date: Fri, 3 Oct 2025 16:46:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Philip Yang <yangp@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
References: <20251003181518.24270-1-Philip.Yang@amd.com>
 <20251003181518.24270-3-Philip.Yang@amd.com>
 <DM4PR12MB656658906DDEEEA2D86AA64AE3E4A@DM4PR12MB6566.namprd12.prod.outlook.com>
 <85af42a8-25a0-5614-a35b-fdfba1b7589b@amd.com>
 <6fd40823-96a9-4307-8364-8a6c70153a85@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <6fd40823-96a9-4307-8364-8a6c70153a85@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc04956-6494-4bde-c76f-08de02bdf5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGg2MW9EN3pGaEgyWlIwcEFOK21UeTBzV0x5U25rdWhiM1BGTkQ0VmFaZjlV?=
 =?utf-8?B?ZTBMb0gvSzVWNWdFL01KcDRMREdBMWlwUlpwNXIrT0k0eTY1VUVoL3VuM0Fh?=
 =?utf-8?B?MHJZd21VWHJDYTlRdTRWS0lQNHFHYjV5dFpadC9SSzNTSkJxMW5KSHM5SzdM?=
 =?utf-8?B?V2RLSFdTSDB0eGlvYTZ6Y3RTaGo2aXk1bkRMSjBrQW8ySjNzZGo1WDZNa1po?=
 =?utf-8?B?RFRNT3IxTmV2TDlvTmUxYVZNZ0lIMURqNmJtMTdGcDQ0elJwdmpuMFhWbFdT?=
 =?utf-8?B?SWVtMzBTaVJpSHJhZWpNZ1BteXdBbmY0TCs5K1E0c1pVNldOTERuV1pBMlBa?=
 =?utf-8?B?U1JFWm5zbkdubiswZ3c1dWVObk12UHNKd1drOGZnazFUdEg0SXRwbmlXRXVO?=
 =?utf-8?B?K3lGRTFVRS93NWpEdEN5QkhYL3NpcDUzQmlwOWRjUFRHWjNFRy9NVE1pNlV5?=
 =?utf-8?B?U1BKcVlNb2YxWm9yMFNVTFh1ZnJQQ3NxU3QxMG9yMU1TeUNKZVhGR05ya1dM?=
 =?utf-8?B?VzZCbGxTTDNwQi9EVGo3bUhuK2Y2SWIrbUhwUGR3VG8wSEdrWFZPUit4QmM0?=
 =?utf-8?B?ZHRoM1UyelhxLy9KZ3B3ZGg1ZEJ6U3FoNFhzZ0k5dTYyZjh3ckVqQm56cHd3?=
 =?utf-8?B?cFF5U1k0UGdDcXRBWHFpMk5yWkk1c1I2QmdxVVFWQjFzOWNyTWE2Zzh6dmlo?=
 =?utf-8?B?bitBVzVFZklhVEQyQkxwQlM5UzVWZkhQVGlTdldDRndwQ1drUEVXRzVRUEVE?=
 =?utf-8?B?ZnhzUnFQam1LV2FRUncxVlBZNnR0WHdVOVdlYk5qam12NVEzVWhYMlczaER4?=
 =?utf-8?B?ZTNrd3F1bEQ1bHlvNzFVaUFXaU5qU2lLSyt3MHNJUFBVK0U4TEFac2pxZTFC?=
 =?utf-8?B?Z0lqNkR5UUl1dncvdHh5elZDTzhxcjJrUTdjVlJFOEFXNFF3Ty9heUc2UWw0?=
 =?utf-8?B?L3JURkJYUVM5RWR3YjVhSW1JZ3pmR2g3ZDJlcVNaUnFKSjhmb2RrK2NsNlU3?=
 =?utf-8?B?UFdiTTFOUzhIWkI3TGIzcllEMzZYMnA4dEJmbEM2YlVNQXREZXBOR1FYVmI0?=
 =?utf-8?B?UTNxSml3bk1pdE1xRU5mTWpPTC9zcUpNOWQrQnl6VnVFYjlKY1VwSUEzTitG?=
 =?utf-8?B?RGNNUXY1UDV4RXl5c09DT1dHamZ0OXJPMk93aC90M0QxaVVEcXdwOWdLc2NE?=
 =?utf-8?B?UmFDVDZZOU1jWUZ3Mis2UkJLSjBEYUEra1pweERsVWZQSU51eEk4U2wzek9v?=
 =?utf-8?B?elcwNE5vemJibEcwTTk1SXY0TTVSazhDYmRRa3RRRkJob0kvQ3d3WXBqdExz?=
 =?utf-8?B?RXRHU05MUzJzV1JGekRiMWVQVWhMWEZVOWxmOGZlWVowOTI3bUs2c1JzZUcz?=
 =?utf-8?B?bDV0SUNUck9oRGQ1NWNTRE1MQkhXVWZJM0FacEg5Rmd4SlpWNlBlUUR1S2xM?=
 =?utf-8?B?cEgvNDgydnNLY3JIUXhEN3hXTmdRVHRQYndDbnVYbVA0ZE81dmNiVDRNenBY?=
 =?utf-8?B?c3JiRlFWZ0cwcjlqa01hamoyM2tHYy8xNEtYQmd0NDRXR0YrcUZUdThsRHFr?=
 =?utf-8?B?Rkx4RmVmRC9odWlYeXNlcG9GajdhakVjS010MjNkNjJHQjZJMmNmVHgzUXZE?=
 =?utf-8?B?NzZYNTVpNm9rQXVaTC85L2QxMHY0ZkVjYzlTTU1zM1d4b0E4cnhZRyttbDlK?=
 =?utf-8?B?ZjdLdUkyanBKRHN1WmZRbXhkVHRUbUtWN2RRVEg2aHFTcTJ3cHBnZE9CenJB?=
 =?utf-8?B?VzBpMzIxTk04dUkvM2FtVzJVeGtCWjk1TTZ1Q1V4NHpzc1lidnJJTks0Qjg0?=
 =?utf-8?B?NFU3aklRN0RST3hXamwzNDFja1hBVXFpL2NQSlVrMzhsZkU2a0QwQUFKdlBH?=
 =?utf-8?B?d0NGdmJCLytvTitDNFh4d1NzRzBPZDFpYW9VTjhmeUluZ1l5Wm4xbHA3bWUw?=
 =?utf-8?Q?qjNV7pFmHTMu6tF+IGwBPKGSrFx5EpwW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V011bkZYR2dBakVPcGQyKzlueHVvRFdadE10N3lRVDVKZklWblVJNTk1N2N5?=
 =?utf-8?B?aU5rQzlpN2xDeEJDcEViRzU2TGlTWFI1RkZMZnRtOHkwMEdDeEtYaGV4bUhY?=
 =?utf-8?B?d1FDU2R1djRuOEJFOGVrTWRmZys1ZmRtSmROL001bXlheWU4Qm1wWnNwZEZJ?=
 =?utf-8?B?Q1ZLMms0WTJJNmxrVUtxNnQ1OTU3cDNreitKYWc1M3QxbnFoWTFCcjdpR3lO?=
 =?utf-8?B?VEVLMnJaQmZJUms1dmJwdWpoTnJVSXh6czRvLzdaYzkwM2ltVkpkWVpRR3p5?=
 =?utf-8?B?UDlvYXhPVm9mSkNYeE5lODJ1djgzcFd3ZUxVZU1IWkNKelFxQ1dOYjBlbEtR?=
 =?utf-8?B?U3MvajAwcEJ2TzdQam5DTTFCc0NwSFhnZ2FrOEF1V2ZKRWFXc1lOdmlzSElS?=
 =?utf-8?B?angvejBsMVJQUTh4cHpCN2NVVkhlNHNUNjZwSmdSd212Rm1JdmZZSkhQenR4?=
 =?utf-8?B?T3F0K1pMczR2NTFDTkxJK0IyRm11YXZRenZNaW1nRHpIUU44U1EwNzlKd2ZM?=
 =?utf-8?B?UFpFUzBpSENjcXpiejR1a2loaUdBZHZjOTQ3S0gyQ3dleWdFaUtDeHl6ZjBM?=
 =?utf-8?B?ZzQ1NzFEVExNRjh6YnI3SnZCeG5yVWwzMW5lZ1JDdFNkTGVPY1FqK3JXRENU?=
 =?utf-8?B?V2VlLytldGJsZ2NoM0h3clZVaE5JYXRSbEJEUkw3aTN6bVBKbHpsRHhqYUY2?=
 =?utf-8?B?dFMxQUNQRElQS2ZNbHdhUHBCY0NpWkFZbG9SNklaYlpIMlZDM2VDUGpnMjg4?=
 =?utf-8?B?ZHdhNHpSVkdaaFhMMGtONTlySG5EOHhBZnRpYXFoYUU4aWt2Z3BqaGZiZUIw?=
 =?utf-8?B?MHBycXdibzJnejhjdktSM0d4Sm1ObkFEWUVJYlllR2kwWDdmaUhweEpmc3JY?=
 =?utf-8?B?MVY4NE1NREZyQXBQSU1yMVl4djZJUGdzSDdDUlJiNC8zcms3eTlUTm1kWDYw?=
 =?utf-8?B?VUN5MmxjT2JGanpyYm5rbmZ1NU9BWjd5UUo4VHJFb0ZwQ29iN0paT2p5NGgr?=
 =?utf-8?B?d0VBYXRSZWV0YVdGSXFWV0x0MlhXWERXT0l3L1hsQzUyUlhxdzMwKzhhMXdG?=
 =?utf-8?B?YTVRQmhjZURqaFQvdXZoN2gwQWhGNTE4YVM4Ny9MaWxKSzhxUnVsR2NFMzdX?=
 =?utf-8?B?cGVUcnpqSncyMlhDaytuRi9jU1dYb2tNTnVEUlNmRDA0LzRTanZibE1FRTZG?=
 =?utf-8?B?Y1dCSkNGeDUzTTNJVWFnQ1hJQlp4dGJPSVVzdTJlUURJYVBDVHdEUERZZ2h2?=
 =?utf-8?B?dlBqcTVyTGxqUkoxV3N5RTZFMGwrbldDZUxpQlg5UWdnWCtZSjRoa0hLZ2p6?=
 =?utf-8?B?Y09FTndza0dFNGgyWTduYmdJTHBnMUVDYlVRaWpncnhpNmh5UkNLV1NOWEpj?=
 =?utf-8?B?bWJLR1dUTXkzL0haSFhGQlJURjBLNWhDQlhlcnNJREc5RTFkT0ZiVU5Mc3J0?=
 =?utf-8?B?dWxYVVlnSmFNeitQM0t6TkdJU2sySzVmNmxkcjdLVFJGNDAxVkhvcUZ3aVk2?=
 =?utf-8?B?dHpRTzFZeU1Nc1ozdnYrTXcrb0R4dU92VUptcnRIR3NBVzdIaWJxUkdyanNB?=
 =?utf-8?B?NDZodkNkc2FZVUdVUWYvUVJaditybkNhMEsyZnRuVy85VFFYWmNjdDd4ZVZM?=
 =?utf-8?B?TlpiQStDQzVsbmZObzJ5R1RTL2NjMTJDeG9LeVBrNDUrODBSMXdPY04wZ0lM?=
 =?utf-8?B?MkR5M2hzM1A5dkFhWHU5cDNXUUVHLy9zZEdkSnRQcmdKdVY4aW1vWitMc0pJ?=
 =?utf-8?B?UEtUWGppWERPeUFNTWw5RDZBdEVOUTdSVkZRbDJ0eVA5Zi9tRnNGckJrQ1da?=
 =?utf-8?B?MjJjRlZIZktHVCtmTUVuR3JEL3kxQWkvM2tVUXBwYzZsZ3d0b1ZvRUNJdG9I?=
 =?utf-8?B?UGZJUERwZ2VYZkg4eWRVbUM1a2N3b2VJQ3gyUS8wWE5sVXJlQVZJTVl1SkZk?=
 =?utf-8?B?aXFhVFVSSlByNE91Nk1oTXlSZUdId2Z6NTJMd0tFcm8yMGh2NzUvR2ZrQTBr?=
 =?utf-8?B?Yk55eXArOXoxRElLVDNLMHRwT0F6VkFhQTdJbTlDbHAzdHNQeU1aNWR2Q3I0?=
 =?utf-8?B?K0doVG42TGRsbG9pZExNd1hHZWtYTFdPNGdQK1pPbGVheHJjQUxrQ3o0UVYv?=
 =?utf-8?Q?spdTnTcWFbA2sr4VzDQ0uTA2F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc04956-6494-4bde-c76f-08de02bdf5f0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:46:43.3237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UNvjuXEWmmcN/X/fiROSMSDJWk1dCXrgpp4w5TF0eJgUJ/vmfsi8BEx+d4qyupk7OoRhwFUi4GaSyEfq4rwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

On 2025-10-03 14:34, Chen, Xiaogang wrote:
>
> On 10/3/2025 1:27 PM, Philip Yang wrote:
>>
>> On 2025-10-03 14:22, Chen, Xiaogang wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> The MADV_FREE is handled at 
>>> madvise_free_single_vma(madvise_dontneed_free) from 
>>> madvise_vma_behavior at mm/madvice.c.
>>>
>>> It calls mmu_notifier_invalidate_range_start(&range) with 
>>> MMU_NOTIFY_CLEAR to notify registered vm intervals. I am not sure 
>>> how driver don't receive the notification. Is there something else 
>>> cause the problem?

I guess we got that notification. That's why we're trying to restore the 
range later in the first place.


>>
>> I cannot repro the vma not found issue with madvise MADV_FREE on 
>> Ubunut kernel 6.16, this issue reported on a customized older kernel 
>> version.
>>
>> Regards,
>
> One principle of hmm is gpu vm is mirror of cpu vm. Whatever happened 
> at cpu vm need to reflect to gpu vm. If there is something wrong from 
> hmm that driver did not get notification from mmu notifier driver need 
> update gpu vm, also the correspondent prange. So, besides unmap from 
> gpu vm, I think driver also need split prange to remove correspondent 
> vm range from prange.

I would agree. It's strange that the vma disappeared without sending us 
a MMU_NOTIFY_UNMAP. If we're adding a workaround here that unmaps things 
for missing VMAs, we're potentially leaking the prange structure and any 
associated svm_bo. Because I don't think we can expect that someone else 
will later send us the MMU_NOTIFY_UNMAP.

If we cannot reproduce this problem in an upstream kernel, we should not 
include a workaround for it. If we can reproduce it in an upstream 
kernel, we should discuss the proper solution with the HMM maintainers. 
It may not be in our driver.

The only place where we can put such a workaround for a bug that may be 
specific to an old or modified customer kernel would be our DKMS branch. 
And even there I would be hesitant with a workaround for a problem 
that's not fully understood. It makes the branch harder to maintain, and 
may be broken at any time if we can't test it.

Regards,
   Felix


>
> Regards
>
> Xiaogang
>
>>
>> Philip
>>
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>> -----Original Message-----
>>> From: Yang, Philip <Philip.Yang@amd.com>
>>> Sent: Friday, October 3, 2025 1:15 PM
>>> To: amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, 
>>> Harish <Harish.Kasiviswanathan@amd.com>; Chen, Xiaogang 
>>> <Xiaogang.Chen@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>>> Subject: [PATCH v2 3/3] drm/amdkfd: Don't stuck in svm restore worker
>>>
>>> If vma is not found, the application has freed the memory using 
>>> madvise MADV_FREE, but driver don't receive the unmap from CPU MMU 
>>> notifier callback, the memory is still mapped on GPUs. svm restore 
>>> work will schedule the work to retry forever. Then user queues not 
>>> resumed and cause application hangs to wait for queue finish.
>>>
>>> svm restore work should unmap the memory range from GPUs then resume 
>>> queues. If GPU page fault happens on the unmapped address, it is 
>>> application use-after-free bug.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 75 
>>> ++++++++++++++--------------
>>>   1 file changed, 38 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 0aadd20be56a..e87c9b3533b9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1708,50 +1708,51 @@ static int svm_range_validate_and_map(struct 
>>> mm_struct *mm,
>>>                  bool readonly;
>>>
>>>                  vma = vma_lookup(mm, addr);
>>> -               if (vma) {
>>> -                       readonly = !(vma->vm_flags & VM_WRITE);
>>> +               next = vma ? min(vma->vm_end, end) : end;
>>> +               npages = (next - addr) >> PAGE_SHIFT;
>>>
>>> -                       next = min(vma->vm_end, end);
>>> -                       npages = (next - addr) >> PAGE_SHIFT;
>>> +               if (!vma || !(vma->vm_flags & VM_READ)) {
>>>                          /* HMM requires at least READ permissions. 
>>> If provided with PROT_NONE,
>>>                           * unmap the memory. If it's not already 
>>> mapped, this is a no-op
>>>                           * If PROT_WRITE is provided without READ, 
>>> warn first then unmap
>>> +                        * If vma is not found, addr is invalid, 
>>> unmap from GPUs
>>>                           */
>>> -                       if (!(vma->vm_flags & VM_READ)) {
>>> -                               unsigned long e, s;
>>> -
>>> -                               svm_range_lock(prange);
>>> -                               if (vma->vm_flags & VM_WRITE)
>>> -                                       pr_debug("VM_WRITE without 
>>> VM_READ is not supported");
>>> -                               s = max(addr >> PAGE_SHIFT, 
>>> prange->start);
>>> -                               e = s + npages - 1;
>>> -                               r = 
>>> svm_range_unmap_from_gpus(prange, s, e,
>>> - KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>> -                               svm_range_unlock(prange);
>>> -                               /* If unmap returns non-zero, we'll 
>>> bail on the next for loop
>>> -                                * iteration, so just leave r and 
>>> continue
>>> -                                */
>>> -                               addr = next;
>>> -                               continue;
>>> -                       }
>>> +                       unsigned long e, s;
>>> +
>>> +                       svm_range_lock(prange);
>>> +                       if (!vma)
>>> +                               pr_debug("vma not found\n");
>>> +                       else if (vma->vm_flags & VM_WRITE)
>>> +                               pr_debug("VM_WRITE without VM_READ 
>>> is not supported");
>>> +
>>> +                       s = max(addr >> PAGE_SHIFT, prange->start);
>>> +                       e = s + npages - 1;
>>> +                       r = svm_range_unmap_from_gpus(prange, s, e,
>>> + KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>>> +                       svm_range_unlock(prange);
>>> +                       /* If unmap returns non-zero, we'll bail on 
>>> the next for loop
>>> +                        * iteration, so just leave r and continue
>>> +                        */
>>> +                       addr = next;
>>> +                       continue;
>>> +               }
>>>
>>> -                       hmm_range = kzalloc(sizeof(*hmm_range), 
>>> GFP_KERNEL);
>>> -                       if (unlikely(!hmm_range)) {
>>> -                               r = -ENOMEM;
>>> -                       } else {
>>> - WRITE_ONCE(p->svms.faulting_task, current);
>>> -                               r = 
>>> amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>>> - readonly, owner,
>>> - hmm_range);
>>> - WRITE_ONCE(p->svms.faulting_task, NULL);
>>> -                               if (r) {
>>> -                                       kfree(hmm_range);
>>> -                                       hmm_range = NULL;
>>> -                                       pr_debug("failed %d to get 
>>> svm range pages\n", r);
>>> -                               }
>>> -                       }
>>> +               readonly = !(vma->vm_flags & VM_WRITE);
>>> +
>>> +               hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
>>> +               if (unlikely(!hmm_range)) {
>>> +                       r = -ENOMEM;
>>>                  } else {
>>> -                       r = -EFAULT;
>>> +                       WRITE_ONCE(p->svms.faulting_task, current);
>>> +                       r = 
>>> amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>>> + readonly, owner,
>>> + hmm_range);
>>> +                       WRITE_ONCE(p->svms.faulting_task, NULL);
>>> +                       if (r) {
>>> +                               kfree(hmm_range);
>>> +                               hmm_range = NULL;
>>> +                               pr_debug("failed %d to get svm range 
>>> pages\n", r);
>>> +                       }
>>>                  }
>>>
>>>                  if (!r) {
>>> -- 
>>> 2.49.0
>>>
