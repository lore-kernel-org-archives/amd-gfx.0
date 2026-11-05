Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE300606D801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HpQe2nww
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BCE1127D0;
	Thu,  5 Nov 2026 15:51:59 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027AA10E94D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 15:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYkSb10igg4DtfxjPXcSSemmVzHbai7VSn/QKs8AsXt1x5k4UE6TtcblNlCYMnsJahIQSQ3WnG2Z0aiVxRkssqtyFK/pxBkuzfhYTJ4mslvzC6dU+9rHRPIyiRz58dCtA9ae4ka2stImCQJnH0ogcqG7kcfgUdmXpDSNaQ6X2Ub8+CksFNwmfhtVSoRapt3rgGUgNfg3LfXoEPHY7BzrhPm6iD5HtScBauI6saXnkT3VhZBA1j0FAGg4qFhPzO49xykS89wUppr08weYi77Xkksv4UkDSW2t1sL8lo8+7QLZfS1jiB5sBy5ReAo94BqAdCssVRFVrI6vVkLwioeclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJEdyVm0fw1+JexoqCUe+YWO5poV8jwUiQQBwgqX2CA=;
 b=m5qu1pFooPPw9g8TEYi6Q83YSrGuI1tJOloKmEETVInd8u6EumnNthTZ1QoZ/KzfYFr+irHpYcCqU9MjFr1fM7ohwjnO+2kkUmZc57mlWSdOTdDyrRyVxsKlYANKRtEH0qIv0wk5TzXLIZgyenKsm88vCNCMwJlyG0Iq6UNjj8MGxuRnfEhXStz4sSjklAYD80pvxVNgG1oiJJ6Nqh31Gj0kmlai0GUSt9u0Z2qrDtW4IjaaHPc18Om6Ux8lrQH5QQJECZLxRpkmxrXSC76TrT3kdOoILTxgCL6xkVUEz75ZLtMRpLJ79ttP05LzgSj+FoCYd3kF9Q8A2E50W6CnGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJEdyVm0fw1+JexoqCUe+YWO5poV8jwUiQQBwgqX2CA=;
 b=HpQe2nwwVroddOPIzejdgKFzIEb2RPTS8n5IYsJSoiOUpjyv3avK7vQM6OAfumUN0Fzi8m+MaxqTX6Oq0nB0zILF8hVK3iLnNH+ukqd7u3kBOo2PLS5htzXspiNmcPhlg9WMe2XCKJO11QUq1IqLqrQ2BomLaE67lRMIyWYjuL8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:51:50 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 15:51:50 +0000
Content-Type: multipart/alternative;
 boundary="------------qewgqtD9IMJvTtCQB03ArgSM"
Message-ID: <b312d42e-817f-46f7-8030-27c33265fbe1@amd.com>
Date: Thu, 5 Nov 2026 10:51:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Mishra, Apurv" <Apurv.Mishra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Faizal, Sahil" <Sahil.Faizal@amd.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
 <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
 <601d1612-ea3d-4379-9336-9c36e9485230@amd.com>
 <PH9PR12MB13592198ABB2BF96C9F290F41D9F6F2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <ee715a81-5643-4da7-a0b9-7205e34758b5@amd.com>
 <PH9PR12MB13592158862738134DABAB73F89F6A2@PH9PR12MB135921.namprd12.prod.outlook.com>
 <39984cf9-fe4a-40e3-b076-20bea95f2127@amd.com>
 <fe5f9b54-0516-4a83-ad54-c982dc161523@amd.com>
 <fe5c2998-f19d-4992-b87c-2a498fa109d0@amd.com>
 <fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com>
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: c9154013-a728-43d1-c213-08df3b54b429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261021135927099003|10067099003|5023799004|11063799006|261009223027099003|8096899003|3023799007|18002099003|22082099003|13003099007|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: j7jpQgkX2bc9RSseHz9FxwHc79xcAaPOmcRYaQwiAe/SzJO/+fCXRCChZ2B3iaFVPFsp5bhAhsDJ0W/J/2QdVYY9MFiwWFyPesbJMwQ22BNaZDmdQ16rsuxRoMZ+TpkJMdE4mPELPrweQjB91JZ8l0ngTJ5yREU2Va4zCl0R3Mdto36bMDF4TmdhplcxYSJ60IJnAxIILJcb44194Msc6tUMbNWovTFG10O+He+uVBr3M8xZFNycVURjLaifj8H/d+PiMzU8ezAJVdJRpqg4LYr3nN1Vh2FnGR1HAdVA0u/BfOechauSOsh1z4h7+IxjRWy7VS9TgpTrU9AUnetVc/D8ZXU59kw7GmhJQVbWvg78v6pRff0BmvGXdjy+dERnIRoWV2dnbPv6jN+ZVr6gxdYO1+qZSWG+aeJV/H6DT3oIlUnyJYfpcT1XfSHtz9c+NtWVsdvb4oR4DmLUcgkB7eLh0kTl/wt+9DEjSyi3xeI2VRI/GczFKscW16JeuSTydAP9aPubVoIfWLDuOxEi5C4u5xEqwsyubx12TgYxMF0sC5481ZgzS/QdqNv3VZGLYAjdWw12kMKOg6NKcWXcKqXN3MsXxCsnYWKuemXcPsoxH6YssczhU/YCO8EaCIWC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261021135927099003)(10067099003)(5023799004)(11063799006)(261009223027099003)(8096899003)(3023799007)(18002099003)(22082099003)(13003099007)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXB0VVc2cFhNSWw2YnVRUFVCZU42Tm9nMCszWWYvMDFscEhyRFdhQkFrTHB2?=
 =?utf-8?B?Y0IrVUZUOWdwN1BwMWwyaWx4Q09zS25xa3JTWlRac0xqT2V4TWU1QmN6Ymxj?=
 =?utf-8?B?WDRqTGhkZ2wra2M3VTlBaVA1WnoyaE5pZXp1Q3U4U1RjdjRqOW9HNU90SmU5?=
 =?utf-8?B?YnJrUm1QcjcxRzd1dlFTUFBRRnU2ZEJNTjN1MTFIK21JejAzaEI0WHc1QjdF?=
 =?utf-8?B?Mm4zT0piYlYwU1VZc0o0dGlNTVc2SDErell1MFFsTWd3S1VqK3A4TUoxOEw5?=
 =?utf-8?B?L1REbWVQZzFYQlNLL2JGT0xmSHYyWnpsVVdXU3VJQVZLaC9iTnVTaDNpRmQw?=
 =?utf-8?B?RDBLbW0ya2IyV3U1Z2NYaWRreWd5NEsvSXloVTIxalNDOFVhWW5BclEzRk5F?=
 =?utf-8?B?cXhpai9TNHdnUkZud08vOWtCY1dMQXhOSzhqTncxYllCVGhTSW1vOGtMVVBJ?=
 =?utf-8?B?dWJBeUx0cm8vZlhFby9lYTNHY2ZUK01KdzZaQkQyR3AzN3lueERtMWVJNmYw?=
 =?utf-8?B?TmJnOWY2a2tmUndWNzJyRDBRZWVCSGQ4bjUvS0ZBdGtNTnZuaDQxTFRoRWdX?=
 =?utf-8?B?aFdHdFlPeE93TXMzT3hXT2tYcWF3UlF2d2M0MC81UUxhRmo4NWZYRzZ5L0pE?=
 =?utf-8?B?QTgrbjNCMUtKSXI5Q1F6N2w2NUdVSjJlS3FINWxoYWphOU00ZUtSYjRwQ0NT?=
 =?utf-8?B?Wnk5UjF6aXIrdWxjNHYxd3l3WndxU0RVZGtkc2RMaC8wbWhPa0x5bFg4RkI2?=
 =?utf-8?B?UExXVU5aam51RndrNW5nZm5ibkkwNFVhTUZ0V0t4aW04UjhhV2FWSkJsZkZt?=
 =?utf-8?B?Mm9uL0lZekRkaWpPT3ViVVRMSFpCWENxdWt5c2VQTkN0alA5cnhpMXRHNUFV?=
 =?utf-8?B?S3VFVGxYMzFYOXU3bWx2VmRKTEcvYzF6ZjEwWlFpbG03MGJtRzR4bElBUG5U?=
 =?utf-8?B?a1ltQSsxWTlRZ2ZvMVQzUXRUY1pUVjhtdldrc2lPaHUwV0NCUmJXMXpMNE1E?=
 =?utf-8?B?dmVIODZBdGNtSzVsL0dERXpIUHVrN3pQYzdYYUwxL3pnNE1UcGg4UlRsVTRN?=
 =?utf-8?B?VXdydnlwL1MzNnREQ3E5RVF4ZTZ5d0tLZnhzNzJmTk9Sb2FDWWFGT2JJR2FY?=
 =?utf-8?B?a2lFeWgxT1doVGpnN1h4R3AwWXo3cDR3ajFyVnhDK1JzTE4wamhzbVZNb3Bu?=
 =?utf-8?B?TmNEMmVpbDVvemQ2NG5aYWsyTFk0RmdjSGdobk1EY0ZpVWpIVzRrWUNVVGUy?=
 =?utf-8?B?UW5CZ0NFUkRRSU9yekVrU3FIOXBTRXdrNy9YU052M0N5RVBBVE9icTRjQUNu?=
 =?utf-8?B?RVhQRUJpVkRWdnZCaGtEcHRNYTRkQ293a3NlZytPM3NEKzBINFJUQ3RDU0xt?=
 =?utf-8?B?UG0xLzVEREZVMkpEb3FzbEJ3ZFhQQkNlZkR2ZmdJN2ZEVitlTmc5WFdkdmxL?=
 =?utf-8?B?T0V6VlI3bFNnVTBNaWRxd0ZyRFFTV2ZiOER2QzloNldwZUpmaHNSK3Z6cE1o?=
 =?utf-8?B?N290eThtNkQ1cEJZTGNhK2xnY2NxMS9hTnA3ZWlYU2dONGs5ZUs0QVdCdko4?=
 =?utf-8?B?K2szSjRPS1p1blFrMDY5MktDczBjOGN6MHpsdnVoVzlQYWFoSjZoNU1hQjNC?=
 =?utf-8?B?SU1rTmd3Q2V4eEhQN3IwSk5HQlJXUjhOUmpydVJvTElMUlVWWmN2cGFQSmNv?=
 =?utf-8?B?ZTg2bXNaTnZ3ZGVOc1c1OEk5RFVTMUh1dVFUYXdkbklhMVFKMDFIMVhYU1F2?=
 =?utf-8?B?c2sxS0NUcTRyeW0rc1VDSGMyWGFFayt0VSsxY0U5MjhDcWxQajhqaW9qeElJ?=
 =?utf-8?B?V2dtVGtFYWoxRzFMN3VocDBHWENYMWs3UWl4V1ZsUFVUN3NHLytuSk40T29l?=
 =?utf-8?B?MXlsbWJVa3M0S1loaDdlMXRzN05PaXV1UnRXR2E2WkRIaUNjVU5LcDRaMU5M?=
 =?utf-8?B?emk2SCs0N05yVVluR0hMdW14RzRVZ3NYQzVPUno4c1htbkIrV21GVFhUUTU1?=
 =?utf-8?B?OU1kUWs4SjRLT3RGMk5pMFJaYU1OQUVmckNDalpudEx2YTluNmxGeWk1Y3FG?=
 =?utf-8?B?WktTMlFTUnk3cHNkL2o3RUMyN2Nwb0k2Q3F2RndqMlpxbEpXcHJEdzlpckdo?=
 =?utf-8?B?UktIQ1NNRkp5enk2eVZHOFRKSnZGQ2pMdHRDRFZNQ3crSmRSTGN2bmtLM3A1?=
 =?utf-8?B?NENXcmMrcFhPOUhFWi9zeVpaTXlTUmIrbGxpWlJ0d3lNcWlmTGhST3R2R1BM?=
 =?utf-8?B?VGpoalhJdkhlK0ROS1FXMk1SMzVGZTl1WURLL2lseEVJNTd2UE9DR0tJUGx2?=
 =?utf-8?Q?YTh2M+mR6TFmKbpWIf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9154013-a728-43d1-c213-08df3b54b429
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:51:49.8672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1AtTVL9gV5dCYjemBpEx+f9PuZgWs+5y4TZEHRLMX5fGTpfH5UltFflM2ADoFOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------qewgqtD9IMJvTtCQB03ArgSM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-11-03 13:43, Chen, Xiaogang wrote:
>
> On 11/3/2026 12:26 PM, Philip Yang wrote:
>>
>>
>> On 2026-11-03 12:09, Chen, Xiaogang wrote:
>>>
>>> On 11/3/2026 10:57 AM, Philip Yang wrote:
>>>>
>>>>
>>>> On 2026-11-02 18:32, Mishra, Apurv wrote:
>>>>> AMD General
>>>>>
>>>>> AMD General
>>>>>
>>>>> Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com>, following up 
>>>>> on your comment...
>>>>>
>>>>> P's other user is |do_swap_page()|'s own pin. On Ubuntu 6.8, 
>>>>> |do_swap_page()| calls |get_page()|, then |migrate_to_ram()|, then 
>>>>> |put_page()| (/mm/memory.c:3861–3864/). The extra reference 
>>>>> outlives |migrate_mutex|. By then P's data has already moved to S, 
>>>>> and the PTE points to S, so nothing else is wrong.
>>>>>
>>>>> The wrong place is KFD's reuse. |svm_range_validate_svm_bo()| 
>>>>> reuses the |svm_bo| because P's pin keeps it alive. 
>>>>> |svm_migrate_copy_to_vram()| then hands out P by offset without 
>>>>> checking it, while |zone_device_page_init()| requires the page to 
>>>>> be free. The fix adds that check where KFD hands out the page. 
>>>>> When the pin is still there, the page stays in system memory with 
>>>>> a valid PTE, and the next GPU fault migrates it normally.
>>>>>
>>>>> Mainline is the same. |do_swap_page()| now holds the page lock 
>>>>> across `migrate_to_ram()`, but `zone_device_page_init()` resets 
>>>>> the refcount before `lock_page()`. The race remains on mainline, 
>>>>> because upstream KFD has no such check. My patch adds it. This has 
>>>>> been tested and verified.
>>>>>
>>>>> Adding @Faizal, Sahil <mailto:Sahil.Faizal@amd.com> for updates as 
>>>>> the fix needs to merge soon.
>>>> This is the corner case I tried to fix with the patch "drm/amdkfd: 
>>>> Fix svm_bo and vram page refcount". That patch was rejected because 
>>>> we cannot take a page that is not free and treat it as free and 
>>>> safe to use. The approach here makes sense to me: if the page has 
>>>> not been freed, we skip it. With that said, this patch is
>>>
>>> If the page has not been freed HMM page collect will set 
>>> (migrate->src[i] & MIGRATE_PFN_MIGRATE) to false. The explanation 
>>> from this patch is do_swap_page does not release vram page during 
>>> cpu page fault recovery, then page collection by page table walk 
>>> would see pte sill point to device memory, then not collect this page.
>> This issue isn't with the source page, it's with the destination VRAM 
>> page, which still has a non-zero refcount after migrating to RAM. We 
>> cannot assume every VRAM page has been freed and zero-initialise it, 
>> so we skip it and map to the GPU with the system page instead.
>
> When HMM allows sys->vram migration on a vram page this vram page 
> should not be used by someone else. In this case do_swap_page has not 
> release the vram page, then data is still in vram, then collection 
> will not collect the sys page correspondent to the vram page since the 
> vram page is not available and pte at cpu page table still points to 
> the varm page , then not enter svm path of sys->vram for this vram page.
Right, the root cause is hard to follow. Let's start from the CPU page 
fault: handle_pte_fault on a device-private page -> do_swap_page ->
........
             if (trylock_page(vmf->page)) {
                 struct dev_pagemap *pgmap;

                 get_page(vmf->page);
                 pte_unmap_unlock(vmf->pte, vmf->ptl);
                 pgmap = page_pgmap(vmf->page);
                 ret = pgmap->ops->migrate_to_ram(vmf);

This is where it races with the GPU page fault. migrate_to_vram can 
collect the system page, because the CPU mapping on the system page is 
complete by then, and it reuses the same svm_bo, because the svm_bo 
refcount has not reached 0 while vmf->page still holds a reference.


                 unlock_page(vmf->page);

It then uses this device page, and svm_migrate_get_vram_page() locks the 
page and resets the refcount.

                 put_page(vmf->page);

then drops the refcount to 0 ( put_page() has to come after 
unlock_page(), otherwise releasing the page deadlocks.)

Hope that explains the root cause.

Regards,
Philip
>
> If the explanation in this patch is what happened it is not driver 
> issue. This type vram page ref count is not under driver control. Skip 
> migration just covers the real cause.
>
> Regards
>
> Xiaogang
>
>>
>> Regards,
>> Philip
>>>
>>> If this explanation is right it is not drive issue. Driver does data 
>>> migration, not decide which page can be migrated. There is 
>>> contradict in this explanation. I suspect the real cause is not 
>>> revealed.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>>
>>>> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>>>>>
>>>>> Regards,
>>>>> Apurv
>>>>>
>>>>> ------------------------------------------------------------------------ 
>>>>>
>>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>> *Sent:* Wednesday, October 28, 2026 6:41 PM
>>>>> *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>>> Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, 
>>>>> Harish <Harish.Kasiviswanathan@amd.com>
>>>>> *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is 
>>>>> still referenced
>>>>>
>>>>> On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
>>>>> > AMD General
>>>>> >
>>>>> > Hi, @Chen, Xiaogang <mailto:Xiaogang.Chen@amd.com 
>>>>> <mailto:Xiaogang.Chen@amd.com>>,
>>>>> >
>>>>> > The migrations don't overlap. |migrate_mutex| serializes them, 
>>>>> but it doesn't
>>>>> > cover P's last reference:
>>>>> >
>>>>> >    *
>>>>> >      |svm_migrate_to_ram()| releases |prange->migrate_mutex| at /
>>>>> >      kfd_migrate.c:1073/, after the VRAM→RAM migration has 
>>>>> finished and before
>>>>> >      the function returns.
>>>>> >    *
>>>>> >
>>>>> >      |do_swap_page()| drops its own reference on P only after 
>>>>> |migrate_to_ram()|
>>>>> >      returns, at /mm/memory.c:4851–4853/.
>>>>>
>>>>> Before do_swap-page drops the last ref on P the cpu mapping of fault
>>>>> address has not been changed. Then at following sys->vram the
>>>>> migrate_vma_walk_ops->pmd_entry will not collect this source(sys) 
>>>>> page
>>>>> because the address there still point to device private page(since 
>>>>> you
>>>>> got cpu page fault it is device private memory). Then 
>>>>> (migrate->src[i] &
>>>>> MIGRATE_PFN_MIGRATE) is false.
>>>>>
>>>>> If P got used at sys->vram, but P is still used by someone else
>>>>> something wrong is in other places. Skipping migration does not 
>>>>> solve it.
>>>>>
>>>>> Regards
>>>>>
>>>>> Xiaogang
>>>>>
>>>>>
>>>>> > So, the GPU fault takes |migrate_mutex| legitimately, while P 
>>>>> still has |
>>>>> > do_swap_page()|'s reference. KFD gets P back without P ever 
>>>>> being freed. VRAM
>>>>> > destinations come from the |svm_bo| by offset (`cursor.start + 
>>>>> j`), not from a
>>>>> > pool of free pages. That |svm_bo| is still alive because P holds 
>>>>> a reference on
>>>>> > it until P is freed, so |svm_range_validate_svm_bo()| reuses it 
>>>>> and the same
>>>>> > offset gives P again. Nothing checks whether P's previous user 
>>>>> is done with it.
>>>>> >
>>>>> > Regards,
>>>>> > Apurv
>>>>> >
>>>>> >
>>>>> > 
>>>>> --------------------------------------------------------------------------------
>>>>> > *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>> > *Sent:* Monday, October 26, 2026 5:27 PM
>>>>> > *To:* Mishra, Apurv <Apurv.Mishra@amd.com>; 
>>>>> amd-gfx@lists.freedesktop.org <amd-
>>>>> > gfx@lists.freedesktop.org>
>>>>> > *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra 
>>>>> Guiza, Alejandro
>>>>> > (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish
>>>>> > <Harish.Kasiviswanathan@amd.com>
>>>>> > *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that 
>>>>> is still referenced
>>>>> >
>>>>> >
>>>>> > On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
>>>>> >
>>>>> >      AMD General Hi, @Chen, Xiaogang 
>>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>>
>>>>> >      <mailto:Xiaogang.Chen@amd.com 
>>>>> <mailto:Xiaogang.Chen@amd.com>>, thank you for the review. The two 
>>>>> migrations
>>>>> >      don't overlap on that address; they run back-to-back. What 
>>>>> overlaps is the
>>>>> >      lifetime of the VRAM page. This was reproduced with ASan 
>>>>> and XNACK, which
>>>>> >      make concurrent CPU and GPU faults on the same ranges 
>>>>> frequently. As per the
>>>>> >      logs (ROCM-31012 
>>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012 
>>>>> <https://amd-hub.atlassian.net/browse/ROCM-31012>> <https://
>>>>> >      amd-hub.atlassian.net/browse/ROCM-31012>):  * A CPU fault 
>>>>> enters /
>>>>> >      do_swap_page()/, takes a reference on VRAM page P, and /
>>>>> >        svm_migrate_to_ram/() moves the data to system page S. 
>>>>> The PTE now points
>>>>> >      to    S, but /do_swap_page/() still holds P until 
>>>>> /migrate_to_ram/()
>>>>> >      returns.  *    About 66 µs later, a GPU retry fault 
>>>>> migrates the range back
>>>>> >      to VRAM. src =    S with /MIGRATE_PFN_MIGRATE /set is 
>>>>> correct here, because
>>>>> >      the data really is    in system RAM.  *    KFD reuses the 
>>>>> /svm_bo/, which P
>>>>> >      keeps alive, and gets P again as the destination. 
>>>>> /zone_device_page_init/
>>>>> >      (P) runs with ref=1 (traced) and    overwrites the 
>>>>> refcount.  *
>>>>> >
>>>>> > How KFD reuses same P? From the description above CPU fault has 
>>>>> not finished
>>>>> > because  svm_migrate_to_ram has not returned, P has not been 
>>>>> returned to KFD
>>>>> > driver, so P still has reference count.
>>>>> >
>>>>> > Then GPU page fault happen on same range. For each migration on 
>>>>> a prange there
>>>>> > is prange->migrate_mutex to have migration on the prange happen 
>>>>> exclusively.
>>>>> > Then how can svm_migrate_to_vram enter migration if 
>>>>> prange->migrate_mutex is
>>>>> > still hold at svm_migrate_to_ram?
>>>>> >
>>>>> > My basic concern is a vram page can only be involved at one 
>>>>> migration at a
>>>>> > moment. If it is getting migrated in two migrations at same time 
>>>>> with difference
>>>>> > direction there is syn issue. Checking the page ref here to 
>>>>> avoid migration is
>>>>> > not fixing the root cause.
>>>>> >
>>>>> > Regards
>>>>> >
>>>>> > Xiaogang
>>>>> >
>>>>> >          The CPU fault's /put_page/(P) frees P mid-migration and 
>>>>> clears its
>>>>> >        mapping. /migrate_vma_finalize/() misses that PTE (263 of 
>>>>> 264 restored),
>>>>> >      and    it's left pointing at S. S is freed, and the next 
>>>>> /hmm_range_fault /
>>>>> >      hits the    BUG_ON in /swapops.h:504/. The trace and the 
>>>>> panic registers
>>>>> >      match this page and S exactly. With the fix, the /refcount 
>>>>> /check skipped a
>>>>> >      busy page 705 times on the repro host with no panic. 
>>>>> Regards, Apurv
>>>>> > 
>>>>> -------------------------------------------------------------------------------- 
>>>>> *From:* Chen, Xiaogang <Xiaogang.Chen@amd.com> 
>>>>> <mailto:Xiaogang.Chen@amd.com <mailto:Xiaogang.Chen@amd.com>> 
>>>>> *Sent:* Monday, October 26, 2026 10:32 AM *To:* Mishra, Apurv 
>>>>> <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>>> <mailto:Apurv.Mishra@amd.com>>; amd-gfx@lists.freedesktop.org 
>>>>> <mailto:amd-gfx@lists.freedesktop.org 
>>>>> <mailto:amd-gfx@lists.freedesktop.org>> <amd- 
>>>>> gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org 
>>>>> <mailto:amd-gfx@lists.freedesktop.org>> *Cc:* Deucher, Alexander 
>>>>> <Alexander.Deucher@amd.com> <mailto:Alexander.Deucher@amd.com 
>>>>> <mailto:Alexander.Deucher@amd.com>>; Sierra Guiza, Alejandro 
>>>>> (Alex) <Alex.Sierra@amd.com> <mailto:Alex.Sierra@amd.com 
>>>>> <mailto:Alex.Sierra@amd.com>>; Kasiviswanathan, Harish 
>>>>> <Harish.Kasiviswanathan@amd.com> 
>>>>> <mailto:Harish.Kasiviswanathan@amd.com 
>>>>> <mailto:Harish.Kasiviswanathan@amd.com>> *Subject:* Re: [PATCH] 
>>>>> drm/amdkfd: Don't reuse a VRAM page that is still referenced On 
>>>>> 10/23/2026 12:17 PM, Apurv Mishra wrote:    In 
>>>>> svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero 
>>>>> refcount and    leave those pages in system memory for this 
>>>>> migration. When an svm_bo is reused, a VRAM page can still be held 
>>>>> by an in-flight CPU fault (do_swap_page -> svm_migrate_to_ram). 
>>>>> Migrating to VRAM then re-initializes the page via 
>>>>> zone_device_page_init(), resetting its refcount. The fault's    
>>>>> late put_page() frees the page mid-migration, so 
>>>>> migrate_vma_finalize()    never restores that PTE. It is left 
>>>>> pointing at a freed system page and hmm_range_fault() hits BUG_ON 
>>>>> in pfn_swap_entry_to_page() (swapops.h). If there is cpu fault the 
>>>>> data is in vram page. If at same time driver is migrating data 
>>>>> from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should be 
>>>>> false since the data is already at device side. Then if you got a 
>>>>> MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram after 
>>>>> migrate_vma_setup, but cpu page fault also happened on same page 
>>>>> there is a contradict. So, I do not see this scenario can happen 
>>>>> or the real cause is revealed. Regards Xiaogang Signed-off-by: 
>>>>> Apurv Mishra <Apurv.Mishra@amd.com> <mailto:Apurv.Mishra@amd.com 
>>>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>>>> <mailto:Apurv.Mishra@amd.com>> <mailto:Apurv.Mishra@amd.com 
>>>>> <mailto:Apurv.Mishra@amd.com>> --- 
>>>>> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    20 
>>>>> +++++++++++++++----- 1 file changed, 15 insertions(+), 5 
>>>>> deletions(-)    diff --git 
>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c 
>>>>> b/drivers/gpu/drm/amd/    amdkfd/kfd_migrate.c index 
>>>>> 8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/ 
>>>>> gpu/drm/amd/amdkfd/kfd_migrate.c +++ 
>>>>> b/drivers/gpu/drm/amd/amdkfd/    kfd_migrate.c @@ -297,16 +297,26 
>>>>> @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct 
>>>>> svm_range *prange, amdgpu_res_first(prange->ttm_res,    
>>>>> ttm_res_offset, npages << PAGE_SHIFT, &cursor); for (i = j = 0; (i 
>>>>> < npages)    && (mpages < migrate->cpages); i++) { - struct page 
>>>>> *spage; + struct page    *spage = 
>>>>> migrate_pfn_to_page(migrate->src[i]); if (migrate->src[i] &    
>>>>> MIGRATE_PFN_MIGRATE) { dst[i] = cursor.start + (j << PAGE_SHIFT); 
>>>>> migrate- >dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); - 
>>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); - 
>>>>> migrate->dst[i] =    migrate_pfn(migrate->dst[i]); - mpages++; + 
>>>>> /* + * A reused svm_bo page may    still be held by a CPU fault. + 
>>>>> * Reinitializing it would free it under this migration, + * so 
>>>>> leave this page in system memory. + */ + if 
>>>>> (page_ref_count(pfn_to_page(migrate->dst[i]))) { + dst[i] = 0; + 
>>>>> migrate-     >dst[i] = 0; + spage = NULL; + } else { + 
>>>>> svm_migrate_get_vram_page(prange, migrate->dst[i]); + 
>>>>> migrate->dst[i] = migrate_pfn(migrate->dst[i]); + mpages++; + } } 
>>>>> - spage = migrate_pfn_to_page(migrate->src[i]); if (spage && 
>>>>> !is_zone_device_page(spage)) { src[i] = dma_map_page(dev, spage, 
>>>>> 0,    PAGE_SIZE, DMA_BIDIRECTIONAL);
>>>>> >
>>>>
>>

--------------qewgqtD9IMJvTtCQB03ArgSM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-11-03 13:43, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com">
      <br>
      On 11/3/2026 12:26 PM, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2026-11-03 12:09, Chen, Xiaogang wrote:
        <br>
        <blockquote type="cite">
          <br>
          On 11/3/2026 10:57 AM, Philip Yang wrote:
          <br>
          <blockquote type="cite">
            <br>
            <br>
            On 2026-11-02 18:32, Mishra, Apurv wrote:
            <br>
            <blockquote type="cite">AMD General
              <br>
              <br>
              AMD General
              <br>
              <br>
              Hi, @Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>,
              following up on your comment...
              <br>
              <br>
              P's other user is |do_swap_page()|'s own pin. On Ubuntu
              6.8, |do_swap_page()| calls |get_page()|, then
              |migrate_to_ram()|, then |put_page()|
              (/mm/memory.c:3861–3864/). The extra reference outlives
              |migrate_mutex|. By then P's data has already moved to S,
              and the PTE points to S, so nothing else is wrong.
              <br>
              <br>
              The wrong place is KFD's reuse.
              |svm_range_validate_svm_bo()| reuses the |svm_bo| because
              P's pin keeps it alive. |svm_migrate_copy_to_vram()| then
              hands out P by offset without checking it, while
              |zone_device_page_init()| requires the page to be free.
              The fix adds that check where KFD hands out the page. When
              the pin is still there, the page stays in system memory
              with a valid PTE, and the next GPU fault migrates it
              normally.
              <br>
              <br>
              Mainline is the same. |do_swap_page()| now holds the page
              lock across `migrate_to_ram()`, but
              `zone_device_page_init()` resets the refcount before
              `lock_page()`.&nbsp;The race remains on mainline, because
              upstream KFD has no such check. My patch adds it. This has
              been tested and verified.
              <br>
              <br>
              Adding @Faizal, Sahil
              <a class="moz-txt-link-rfc2396E" href="mailto:Sahil.Faizal@amd.com">&lt;mailto:Sahil.Faizal@amd.com&gt;</a>&nbsp;for updates as the fix
              needs to merge soon.
              <br>
            </blockquote>
            This is the corner case I tried to fix with the patch
            &quot;drm/amdkfd: Fix svm_bo and vram page refcount&quot;. That patch
            was rejected because we cannot take a page that is not free
            and treat it as free and safe to use. The approach here
            makes sense to me: if the page has not been freed, we skip
            it. With that said, this patch is
            <br>
          </blockquote>
          <br>
          If the page has not been freed HMM page collect will set
          (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) to false. The
          explanation from this patch is do_swap_page does not release
          vram page during cpu page fault recovery, then page collection
          by page table walk would see pte sill point to device memory,
          then not collect this page.
          <br>
        </blockquote>
        This issue isn't with the source page, it's with the destination
        VRAM page, which still has a non-zero refcount after migrating
        to RAM. We cannot assume every VRAM page has been freed and
        zero-initialise it, so we skip it and map to the GPU with the
        system page instead.
        <br>
      </blockquote>
      <br>
      When HMM allows sys-&gt;vram migration on a vram page this vram
      page should not be used by someone else. In this case do_swap_page
      has not release the vram page, then data is still in vram, then
      collection will not collect the sys page correspondent to the vram
      page since the vram page is not available and pte at cpu page
      table still points to the varm page , then not enter svm path of
      sys-&gt;vram for this vram page.&nbsp;<br>
    </blockquote>
    Right, the root cause is hard to follow. Let's start from the CPU
    page fault: handle_pte_fault on a device-private page -&gt;
    do_swap_page -&gt;<br>
    ........<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (trylock_page(vmf-&gt;page)) {<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct dev_pagemap *pgmap;<br>
    <br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_page(vmf-&gt;page);<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pte_unmap_unlock(vmf-&gt;pte, vmf-&gt;ptl);<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pgmap = page_pgmap(vmf-&gt;page);<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ret = pgmap-&gt;ops-&gt;migrate_to_ram(vmf);<br>
    <br>
    This is where it races with the GPU page fault. migrate_to_vram can
    collect the system page, because the CPU mapping on the system page
    is complete by then, and it reuses the same svm_bo, because the
    svm_bo refcount has not reached 0 while vmf-&gt;page still holds a
    reference.<br>
    <br>
    &nbsp;<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unlock_page(vmf-&gt;page);<br>
    <br>
    It then uses this device page, and svm_migrate_get_vram_page() locks
    the page and resets the refcount.<br>
    <br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; put_page(vmf-&gt;page);<br>
    <br>
    then drops the refcount to 0 ( put_page() has to come after
    unlock_page(), otherwise releasing the page deadlocks.)<br>
    <br>
    Hope that explains the root cause.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:fd5bf2a6-6146-499d-9e75-bdcfc51b3ca5@amd.com"><br>
      If the explanation in this patch is what happened it is not driver
      issue. This type vram page ref count is not under driver control.
      Skip migration just covers the real cause.
      <br>
      <br>
      Regards
      <br>
      <br>
      Xiaogang
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        Philip
        <br>
        <blockquote type="cite">
          <br>
          If this explanation is right it is not drive issue. Driver
          does data migration, not decide which page can be migrated.
          There is contradict in this explanation. I suspect the real
          cause is not revealed.
          <br>
          <br>
          Regards
          <br>
          <br>
          Xiaogang
          <br>
          <br>
          <blockquote type="cite">
            <br>
            Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            <blockquote type="cite">
              <br>
              Regards,
              <br>
              Apurv
              <br>
              <br>
------------------------------------------------------------------------
              <br>
              *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
              <br>
              *Sent:* Wednesday, October 28, 2026 6:41 PM
              <br>
              *To:* Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>
              <br>
              *Cc:* Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sierra Guiza, Alejandro
              (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>; Kasiviswanathan,
              Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
              <br>
              *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page
              that is still referenced
              <br>
              <br>
              On 10/27/2026 8:19 PM, Mishra, Apurv wrote:
              <br>
              &gt; AMD General
              <br>
              &gt;
              <br>
              &gt; Hi, @Chen, Xiaogang &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt;,
              <br>
              &gt;
              <br>
              &gt; The migrations don't overlap. |migrate_mutex|
              serializes them, but it doesn't
              <br>
              &gt; cover P's last reference:
              <br>
              &gt;
              <br>
              &gt;&nbsp;&nbsp;&nbsp; *
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |svm_migrate_to_ram()| releases
              |prange-&gt;migrate_mutex| at /
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_migrate.c:1073/, after the VRAM→RAM
              migration has finished and before
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the function returns.
              <br>
              &gt;&nbsp;&nbsp;&nbsp; *
              <br>
              &gt;
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |do_swap_page()| drops its own reference on P
              only after |migrate_to_ram()|
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returns, at /mm/memory.c:4851–4853/.
              <br>
              <br>
              Before do_swap-page drops the last ref on P the cpu
              mapping of fault
              <br>
              address has not been changed. Then at following
              sys-&gt;vram the
              <br>
              migrate_vma_walk_ops-&gt;pmd_entry will not collect this
              source(sys) page
              <br>
              because the address there still point to device private
              page(since you
              <br>
              got cpu page fault it is device private memory). Then
              (migrate-&gt;src[i] &amp;
              <br>
              MIGRATE_PFN_MIGRATE) is false.
              <br>
              <br>
              If P got used at sys-&gt;vram, but P is still used by
              someone else
              <br>
              something wrong is in other places. Skipping migration
              does not solve it.
              <br>
              <br>
              Regards
              <br>
              <br>
              Xiaogang
              <br>
              <br>
              <br>
              &gt; So, the GPU fault takes |migrate_mutex| legitimately,
              while P still has |
              <br>
              &gt; do_swap_page()|'s reference. KFD gets P back without
              P ever being freed. VRAM
              <br>
              &gt; destinations come from the |svm_bo| by offset
              (`cursor.start + j`), not from a
              <br>
              &gt; pool of free pages. That |svm_bo| is still alive
              because P holds a reference on
              <br>
              &gt; it until P is freed, so |svm_range_validate_svm_bo()|
              reuses it and the same
              <br>
              &gt; offset gives P again. Nothing checks whether P's
              previous user is done with it.
              <br>
              &gt;
              <br>
              &gt; Regards,
              <br>
              &gt; Apurv
              <br>
              &gt;
              <br>
              &gt;
              <br>
              &gt;
--------------------------------------------------------------------------------<br>
              &gt; *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
              <br>
              &gt; *Sent:* Monday, October 26, 2026 5:27 PM
              <br>
              &gt; *To:* Mishra, Apurv <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a> &lt;amd-
              <br>
              &gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>&gt;
              <br>
              &gt; *Cc:* Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Sierra Guiza, Alejandro
              <br>
              &gt; (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>; Kasiviswanathan,
              Harish
              <br>
              &gt; <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
              <br>
              &gt; *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM
              page that is still referenced
              <br>
              &gt;
              <br>
              &gt;
              <br>
              &gt; On 10/26/2026 1:12 PM, Mishra, Apurv wrote:
              <br>
              &gt;
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD General Hi, @Chen, Xiaogang
              &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt;
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt;, thank you for
              the review. The two migrations
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; don't overlap on that address; they run
              back-to-back. What overlaps is the
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lifetime of the VRAM page. This was reproduced
              with ASan and XNACK, which
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make concurrent CPU and GPU faults on the same
              ranges frequently. As per the
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logs (ROCM-31012
              &lt;<a class="moz-txt-link-freetext" href="https://amd-hub.atlassian.net/browse/ROCM-31012">https://amd-hub.atlassian.net/browse/ROCM-31012</a>
              <a class="moz-txt-link-rfc2396E" href="https://amd-hub.atlassian.net/browse/ROCM-31012">&lt;https://amd-hub.atlassian.net/browse/ROCM-31012&gt;</a>&gt;
              &lt;https://
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-hub.atlassian.net/browse/ROCM-31012&gt;):&nbsp; *
              A CPU fault enters /
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_swap_page()/, takes a reference on VRAM page
              P, and /
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_to_ram/() moves the data to system
              page S. The PTE now points
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to&nbsp;&nbsp;&nbsp; S, but /do_swap_page/() still holds P
              until /migrate_to_ram/()
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returns.&nbsp; *&nbsp;&nbsp;&nbsp; About 66 µs later, a GPU retry
              fault migrates the range back
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to VRAM. src =&nbsp;&nbsp;&nbsp; S with /MIGRATE_PFN_MIGRATE
              /set is correct here, because
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the data really is&nbsp;&nbsp;&nbsp; in system RAM.&nbsp; *&nbsp;&nbsp;&nbsp; KFD
              reuses the /svm_bo/, which P
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keeps alive, and gets P again as the
              destination. /zone_device_page_init/
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (P) runs with ref=1 (traced) and&nbsp;&nbsp;&nbsp; overwrites
              the refcount.&nbsp; *
              <br>
              &gt;
              <br>
              &gt; How KFD reuses same P? From the description above CPU
              fault has not finished
              <br>
              &gt; because&nbsp; svm_migrate_to_ram has not returned, P has
              not been returned to KFD
              <br>
              &gt; driver, so P still has reference count.
              <br>
              &gt;
              <br>
              &gt; Then GPU page fault happen on same range. For each
              migration on a prange there
              <br>
              &gt; is prange-&gt;migrate_mutex to have migration on the
              prange happen exclusively.
              <br>
              &gt; Then how can svm_migrate_to_vram enter migration if
              prange-&gt;migrate_mutex is
              <br>
              &gt; still hold at svm_migrate_to_ram?
              <br>
              &gt;
              <br>
              &gt; My basic concern is a vram page can only be involved
              at one migration at a
              <br>
              &gt; moment. If it is getting migrated in two migrations
              at same time with difference
              <br>
              &gt; direction there is syn issue. Checking the page ref
              here to avoid migration is
              <br>
              &gt; not fixing the root cause.
              <br>
              &gt;
              <br>
              &gt; Regards
              <br>
              &gt;
              <br>
              &gt; Xiaogang
              <br>
              &gt;
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The CPU fault's /put_page/(P) frees P
              mid-migration and clears its
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping. /migrate_vma_finalize/() misses that
              PTE (263 of 264 restored),
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and&nbsp;&nbsp;&nbsp; it's left pointing at S. S is freed, and
              the next /hmm_range_fault /
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hits the&nbsp;&nbsp;&nbsp; BUG_ON in /swapops.h:504/. The trace
              and the panic registers
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match this page and S exactly. With the fix, the
              /refcount /check skipped a
              <br>
              &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; busy page 705 times on the repro host with no
              panic. Regards, Apurv
              <br>
              &gt;
--------------------------------------------------------------------------------
              *From:* Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:Xiaogang.Chen@amd.com">mailto:Xiaogang.Chen@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;mailto:Xiaogang.Chen@amd.com&gt;</a>&gt; *Sent:* Monday,
              October 26, 2026 10:32 AM *To:* Mishra, Apurv
              <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt;;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;mailto:amd-gfx@lists.freedesktop.org&gt;</a>&gt; &lt;amd-
              <a class="moz-txt-link-abbreviated" href="mailto:gfx@lists.freedesktop.org">gfx@lists.freedesktop.org</a>&gt;
              &lt;<a class="moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org">mailto:amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;mailto:amd-gfx@lists.freedesktop.org&gt;</a>&gt; *Cc:*
              Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:Alexander.Deucher@amd.com">mailto:Alexander.Deucher@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;mailto:Alexander.Deucher@amd.com&gt;</a>&gt;; Sierra
              Guiza, Alejandro (Alex) <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;Alex.Sierra@amd.com&gt;</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:Alex.Sierra@amd.com">mailto:Alex.Sierra@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Alex.Sierra@amd.com">&lt;mailto:Alex.Sierra@amd.com&gt;</a>&gt;; Kasiviswanathan,
              Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:Harish.Kasiviswanathan@amd.com">mailto:Harish.Kasiviswanathan@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;mailto:Harish.Kasiviswanathan@amd.com&gt;</a>&gt;
              *Subject:* Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page
              that is still referenced On 10/23/2026 12:17 PM, Apurv
              Mishra wrote:&nbsp;&nbsp;&nbsp; In svm_migrate_copy_to_vram(), skip VRAM
              pages with a non-zero refcount and&nbsp;&nbsp;&nbsp; leave those pages in
              system memory for this migration. When an svm_bo is&nbsp;&nbsp;&nbsp;
              reused, a VRAM page can still be held by an in-flight CPU
              fault (do_swap_page -&gt; svm_migrate_to_ram). Migrating
              to VRAM then re-initializes the page via
              zone_device_page_init(), resetting its refcount. The
              fault's&nbsp;&nbsp;&nbsp; late put_page() frees the page mid-migration,
              so migrate_vma_finalize()&nbsp;&nbsp;&nbsp; never restores that PTE. It
              is left pointing at a freed system page and&nbsp;&nbsp;&nbsp;
              hmm_range_fault() hits BUG_ON in pfn_swap_entry_to_page()
              (swapops.h). If there is cpu fault the data is in vram
              page. If at same time driver is migrating data from
              sys-&gt;vram&nbsp; migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE
              should be false since the data is already at device side.
              Then if you got a MIGRATE_PFN_MIGRAT sys ram page at
              svm_migrate_copy_to_vram after migrate_vma_setup, but cpu
              page fault also happened on same page there is a
              contradict. So, I do not see this scenario can happen or
              the real cause is revealed. Regards Xiaogang&nbsp;&nbsp;&nbsp;
              Signed-off-by: Apurv Mishra <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;Apurv.Mishra@amd.com&gt;</a>
              &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt;
              &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt;
              &lt;<a class="moz-txt-link-freetext" href="mailto:Apurv.Mishra@amd.com">mailto:Apurv.Mishra@amd.com</a>
              <a class="moz-txt-link-rfc2396E" href="mailto:Apurv.Mishra@amd.com">&lt;mailto:Apurv.Mishra@amd.com&gt;</a>&gt; ---
              drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp;&nbsp;&nbsp; 20
              +++++++++++++++----- 1 file changed, 15 insertions(+), 5
              deletions(-)&nbsp;&nbsp;&nbsp; diff --git
              a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
              b/drivers/gpu/drm/amd/&nbsp;&nbsp;&nbsp; amdkfd/kfd_migrate.c index
              8b96e1fe741a..1eb92ac6eb05 100644 --- a/drivers/
              gpu/drm/amd/amdkfd/kfd_migrate.c +++
              b/drivers/gpu/drm/amd/amdkfd/&nbsp;&nbsp;&nbsp; kfd_migrate.c @@ -297,16
              +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node,
              struct svm_range *prange,
              amdgpu_res_first(prange-&gt;ttm_res,&nbsp;&nbsp;&nbsp; ttm_res_offset,
              npages &lt;&lt; PAGE_SHIFT, &amp;cursor); for (i = j = 0;
              (i &lt; npages)&nbsp;&nbsp;&nbsp; &amp;&amp; (mpages &lt;
              migrate-&gt;cpages); i++) { - struct page *spage; + struct
              page&nbsp;&nbsp;&nbsp; *spage = migrate_pfn_to_page(migrate-&gt;src[i]);
              if (migrate-&gt;src[i] &amp;&nbsp;&nbsp;&nbsp; MIGRATE_PFN_MIGRATE) {
              dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT); migrate-
              &gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]); -
              svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]); -
              migrate-&gt;dst[i] =&nbsp;&nbsp;&nbsp; migrate_pfn(migrate-&gt;dst[i]); -
              mpages++; + /* + * A reused svm_bo page may&nbsp;&nbsp;&nbsp; still be
              held by a CPU fault. + * Reinitializing it would free it
              under this migration, + * so leave this page in system
              memory. + */ + if
              (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) { +
              dst[i] = 0; + migrate-&nbsp;&nbsp;&nbsp;&nbsp; &gt;dst[i] = 0; + spage = NULL;
              + } else { + svm_migrate_get_vram_page(prange,
              migrate-&gt;dst[i]); + migrate-&gt;dst[i] =
              migrate_pfn(migrate-&gt;dst[i]); + mpages++; + } } - spage
              = migrate_pfn_to_page(migrate-&gt;src[i]); if (spage
              &amp;&amp; !is_zone_device_page(spage)) { src[i] =
              dma_map_page(dev, spage, 0,&nbsp;&nbsp;&nbsp; PAGE_SIZE,
              DMA_BIDIRECTIONAL);
              <br>
              &gt;
              <br>
            </blockquote>
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------qewgqtD9IMJvTtCQB03ArgSM--
