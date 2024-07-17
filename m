Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D3CC3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 23:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C569A10E484;
	Wed, 17 Jul 2024 23:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GYCA7/ig";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F5910E484
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 23:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBG0obZH/5QPsaO15nRWVrzn0quOB0mMTyjUkiGftfFhOCRKU7ue2UYsdqEKkhVYaXoiiIUnjnZuFrz/CSPT8wMhRc1Kk3gSDfeG58m1/MuA8Bo0TKk7y6rFW9j2msQKiznajsU0sqOFL/eZO4tIbW1clVlUysC/BMiVNXDlgx9ptmsbgwujRU77mPQ7RuWLzPnX6MAcHKdAlE90i8LkCA/8Uonn9u+jvWgBhyi7k6c9VcghkeiM4iTv1sK8NTWfFIQk5zetwvMASZ5YRBIJE6PaxYz8PHcktdfhKY7omZUJdoc5GRsSg6Ex3vk7T3AfoyT1sUqa+4DFal73vgv/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk7dLW/Dp6kjBH0Z8yNFOoocO8j0qmDPHFUA4GLDnLs=;
 b=URTZ1EMe/r3YNw3wMstrgrSLxN3Zm2YVbFfH/9Q0cr4Ow7vcQFPo96SwZtqgSaaFwt9VLO+hD8sultkyeUn3/MU15iNSTj2UjpwMarB33WAAmZjzQ8i95TanNJ7K9284JiIqoH84of/W3fueaCKrChDeJzmDxI7sfyk5cY6YH7/xJ3gg/eWzUsxBdyUETs2iW+M7ChV8XuSsbR5AfnqCTey7PEbeEFo9Bich/36w+r6QnIUnd9eBGvaOZMuTfz0rEJ/mmfzYhDBsZhclojCDJPNcXVSCEguLRe3YdUt/dzIXCFLXEEpwrNbfq02iAxLJWW/IOrLY8p/l267a63x6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk7dLW/Dp6kjBH0Z8yNFOoocO8j0qmDPHFUA4GLDnLs=;
 b=GYCA7/igMDVV7mtH7QySDtzOW7iVpDsBgYoPRQOa3NpPafQuGj9Cn3/IFys3ftzN+BVOKZ7uwD50/cCv2uGaNaOn7ph0VJ++eKhwNdTyNk82N3644jxW4fEpH48m2RNZKLs/sTfIoJfTVwlIWGWR8XKP1F26SJXhP+Kds4J7BUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 17 Jul
 2024 23:02:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 23:02:45 +0000
Message-ID: <0aea26d5-7850-44c8-b072-5d50a9d4c272@amd.com>
Date: Wed, 17 Jul 2024 19:02:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20240626150633.157464-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240626150633.157464-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::10)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc27b56-3c7c-413c-8f6c-08dca6b491d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VytTaWdPc0FiampqUTI0RExjTGZkTDZoeUZEWkZOMXE4M2JhWURrcXpHRlNR?=
 =?utf-8?B?WFVka1NwY2IyQ1c1Q2NpQmFxSWdtSFJCcmVycDVlRSs5ZFNmMVlqclduNXZy?=
 =?utf-8?B?SUoyUUdnSFNLbEpabXFzZnZFamVOQWJPdnhzT2xpdlZ4eWVHKzQ3MmZjTm9P?=
 =?utf-8?B?L0NoUlNjalBYenVSaHBjdTFWWE9waDdsMi83SDFmRjBlUTNHR2NLbEZXekxQ?=
 =?utf-8?B?cGdtQitmTXBlRVB6NTZ2RW01VW90TVJNS1NrYm9iTWhwd1hJSy9GWkNlWTRm?=
 =?utf-8?B?bVRLTGZtVStIbmdpRGYxaC9RRHhacitFRU10UDJGS2p3aHpxZ1F2Tzd6akRM?=
 =?utf-8?B?eFhmWEFQMzUyNGhRVHE5dUFtT0F4ckdiM09WTkxLdjV3Z3N3V1F1UlBxUHlS?=
 =?utf-8?B?YjRocWF0MzF5ZGljb2FKYjdrbk1MMXhxaEE3YlRoOWUvR01HVnJ1OTF6OEE0?=
 =?utf-8?B?U2tQa0NWWVliMTNuQUpteVdETE9kTXpyZG9KWlVRUlh6MTErSXNDMGwrMitV?=
 =?utf-8?B?YlRRdEdlMnNST2NjRzZzMjJsYXo4dVl5QkRnR244NmRPK3QxdE1oVkQxN2Fx?=
 =?utf-8?B?NVB0Ui9iK0lBN1pKT2dxR0pTelZxbnllUEZISWFVYkVpcDByYUh2ZEU4TVJP?=
 =?utf-8?B?OHI1Z05RVStwWHRVaGFBc3FrdFRaR011bDNPbE9CdG1Gdi95ZENiVnJ2WHd0?=
 =?utf-8?B?eWtFQlZQT093NUl0NVhDK1UrRWc5Y0J2TklpVlJ5enArTXRQMXB0eXBHRHpu?=
 =?utf-8?B?RWlVTEVPRU1Wbk9LelVIVmlEd3MraUt0YlMyNDh4ck42SXQwR0NEbWhHOUpV?=
 =?utf-8?B?ZHRzUThFOCttODQ3NThrUThqQnFMaWtZMHlhTElwZDZvbmZjcHBJYUlEU004?=
 =?utf-8?B?bDNHbWdIWkRBMVJiNGdlU2hRdTBMdEpsMTI4SE1NdlhYSXdhTXM1Sm9yRDZt?=
 =?utf-8?B?QUVYSmVmSStQejQyamREUDArK3hncnk3VU9BVEpUTStUOGlGcjZ0VGUrWDM2?=
 =?utf-8?B?QlJUeXVpd2IyQmdBWVVSSWNZMnluTnNNNlV2bDRrRksxeklxTmNsaFhiZjU1?=
 =?utf-8?B?ZDl5Rk1XT2tOS0Z6bzR2bGY2MGZ5WGYrNGp0VGRvaXBuN09XTzF4L3Z2WnAy?=
 =?utf-8?B?S0duTUZmaUdqYW5Sb0d2bTFySkJEQ3p6R0RuTkJrdWxxK3U5ZjFIK2VtOWJ3?=
 =?utf-8?B?dkEyenQyaGtHTWh1c2kxMWUrR1RleFlITXVzcWk0VEdJRURsMStBQXF5VFpU?=
 =?utf-8?B?eEJHRVo0U3Q3RlVvdWROT3llNnFqbG5saGpMMWx0cE5oWFk5RDVjbHl1QUlv?=
 =?utf-8?B?N1NLLzBaanhuQktaRjFaUWQ0c1N4enpjd2xia0JIdlRyQUo5QkIvSnZhYUgx?=
 =?utf-8?B?dzcxUVFGOXFSU1l1RTYyOC9RZmhwZGwvTW0xTWxYdEJDY0VjVGxQUnB4dDNu?=
 =?utf-8?B?dW1tWUw1SWNsaUpJa1UxSDZNRzdaaDNlcWpMUC9IMElVczdwL1JsR2tZOHpN?=
 =?utf-8?B?aW1ia1RpR09pVkpqWVpWR0FIanVwR0RINmwxTjNtdnZkWElCYy95UzRScU05?=
 =?utf-8?B?NGp5eWVZRUswNzc5bUhtcklkakRqUEYyYjRCOXlBOWJ2OEgvVUhTTnlvN085?=
 =?utf-8?B?TjlGZm9pZDA1SWozKy9ES1RnTDlPVnhVWmM1a2V0NXI4Si9wNEJlK2lpMlhI?=
 =?utf-8?B?UmNUV1ZEN1pYWkJMSExiM0FnRzZOdEkrS0hxdEZuemZDOEpQZml4VTlqaDI4?=
 =?utf-8?B?NVBpRDBtSFRjWlJydmtuWkl0d2hkTFBrTUs4cTZEM2RpQUhJanovU1orcjU0?=
 =?utf-8?B?aTJHZHcyNmdIZE1NVjNadz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWN2Wk5JRlIyZTN0aHdPSTZRNW5uYlhNMTNCVWRjUTNwakdQQm03aS9PWEM0?=
 =?utf-8?B?VnBPQ3B2WVl0UDZWNWhWMHd2M0wvcC9tUElyeDN3M0FTaHRGNS9iZnBKR2Vl?=
 =?utf-8?B?c1MxNzBpTUFVamhnOTRkYWtKcEpNTzM0VzhDNkN1SjhMSHhUcCtvcE83LzVO?=
 =?utf-8?B?NVlKR01PdU05VnR6WGRFblZLQ202OS9zMUprYUNSNk1nVFduTVlyeE5icmNY?=
 =?utf-8?B?NEUySFh1c0Fsc1BKTTYxdG4zQ3dSbnJNZkd3cm9aR0xXanNSK3VMdVoyYkVU?=
 =?utf-8?B?eCthb0NDTGU0Y3I2NEpjNHgzQ0pWdG4xQ2EzeEY3WUtJeldvd01Fd2NrMXhS?=
 =?utf-8?B?dFN6RGtrdzB3RVZOWTNEMmRZSmJIVklXUklXY2daN1c2TG44SXBoKzdTT2VB?=
 =?utf-8?B?TDNuN3RjWGVVcUJlYnVDMVlubzFKeGpRc2RrZStJaHlBbzZpeEQ1ZUlTUjdN?=
 =?utf-8?B?Q2NxVjQ5Y3BORFg5TmZvaGVhNU9ZU3hmdEk5NjFDOGpCRThNYUJUVmhCT2VF?=
 =?utf-8?B?ZGZHbVo2YzVJN29vN3JZeW50R1M0MEh2cXpxdDFDT2ZtQkk5V085MmhlQmR4?=
 =?utf-8?B?SERGRm9yR1VxNWJLbTl6eTYxYk1UOU1Hc2w5bmtvakxkVFFEMERIaFo0ZHBT?=
 =?utf-8?B?YW1JM2tBTm1qdnhwU05DT2E4Z2h5YmVTd2RWdGpOM2xTRjZHaEExaDV5bFYz?=
 =?utf-8?B?UXJablpuVEhqTEhqRytROS9uaTlDc0Z3RTU1VnpIVU41UzNrWlB3QUhHMkYy?=
 =?utf-8?B?dGs2ZFROSVlJOXg3dG1GUitHUVdEUWQzSTZ1NXlka2d5Z2pLTHBleTBaMDlI?=
 =?utf-8?B?QmtIRi9xL1JnaXMzTmMrUGZCWlRWRTNKR3JTQ0xFZ1hOSmtkdjM5UmtKaTJo?=
 =?utf-8?B?K1RtbXlCQVhENU8xZVlxMmNRbitBUlRLcGlNVFJ2SFJLY3p6a2VZMy9SVExz?=
 =?utf-8?B?VkdXakhkbEt5SlM0QzNFTm5scEUzN25oNTN4Zi9WaEp4RHI3NFNKcXZwQktC?=
 =?utf-8?B?dmJJdU13OTJ1SWIrN1R4NmpYRnNRZytpR0h4NWkrQ1VoVEw0enQ3YStlSUVo?=
 =?utf-8?B?c2ZlVXNGVnhEZ1hSTitDVE0vVWZzK1J0U0FzMGRVaGQvVGJSRkZzUVhzUmpv?=
 =?utf-8?B?RTl1N3o1cGFJeWFaNk5PNXAyYUZEUzJnL0FCbEJicXNQclF6ZVdGbVhDTWR3?=
 =?utf-8?B?T2pHelFyb2loa29VVG1VYU9iczVLenFxNVhFTHA2WE1mcmhmbUdRT1lVMU9B?=
 =?utf-8?B?YlRNb2NlQmw0MkZ6azYwc00vNzFudTBSRG9ZOUJXR0hIbENra2JEQVdpeEQx?=
 =?utf-8?B?eTdvYlRMNGhTbmxFT2RoWU9xaGdFelZVSkRocTFlY3JIaE4xRG4rbG9MaWN6?=
 =?utf-8?B?ZGQ5ZWo0SFZJZmpTd2RtdlRZbDV0djF1Uk9RMlZoUDV0YTNNUmVTYmpMSlVq?=
 =?utf-8?B?MytUclg1UW9hcEZkVmRYaDhUV2xZV0syd0hmUEtFeTBhN1AvczdNQU91eHlJ?=
 =?utf-8?B?TEQyWk81eGd3cmtvOExTMktsUjRqSmc5Q3R6WHJWQnZmSTVacnRvTHVzSDFw?=
 =?utf-8?B?Wm5WQm5nL0t3OUdPL0Qwc0tMUnZaMjY2dU9ya0JoUDBWNnYzVFhHem5EYWVI?=
 =?utf-8?B?TkYyUmtzMDQ2U2hkNk5wZ0JhU1lGTjM0SmRDQUVZaGRvTHJGQ3EraVpOWENV?=
 =?utf-8?B?QzFXb0ZOS2lhR0w3WHdxVlROU3JsNGZxV253NVJYeVphMGZZQmxMNU1vaFdq?=
 =?utf-8?B?dE0zS0xvWXZQTll6eXJTeVgxQW1Gc2g2ZTdoM0tpeG45ak5jcm9uMXVsVnF4?=
 =?utf-8?B?WjAyV04xaTJqTzVoSDVtZ1I2WjJzSWNIRFRDRjJtM083WHF5M3ZXUEVkWmxx?=
 =?utf-8?B?YmljSDBRUDk3dnl4M21jeENBYzlMYkFDNnRJSGoxWXdlazFEQzlXWUIxWGM4?=
 =?utf-8?B?d2MwYTd2bWptbEIxY29zb0gwMlBHZmdBUTJ5VHRDdzF5bUNmQmRjUUZpNmFK?=
 =?utf-8?B?aFM3eDVmUGZYQzJTS3lVV0UycmtQOXBNc1NudUJMdkJDSVFSQi9ubXhza05k?=
 =?utf-8?B?OGFlN0ZJdEV1N3RFUkYxZTdkelMvbkdBcW8venFOenk3WjZPQkJTMjJJTUQ2?=
 =?utf-8?Q?aeEoM33c9Gfy/DjwBG1O6+p7x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc27b56-3c7c-413c-8f6c-08dca6b491d5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 23:02:45.1964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqGekSJy3CaAMDgHh0xJ1f9H8x9PB8crQ6RcHb4DGTty07VFjAFtW1RfSLnQYgG7vsC5qycqDnawtvu3R5SERg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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


On 2024-06-26 11:06, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When user adds new vm range that has overlapping with existing svm pranges
> current kfd creats a cloned pragne and split it, then replaces original prange
> by it. That destroy original prange locks and the cloned prange locks do not
> inherit original prange lock contexts. This may cause issue if code still need
> use these locks. In general we should keep using original prange, update its
> internal data that got changed during split, then free the cloned prange.

While splitting/updating ranges, the svms->lock needs to be held. You 
cannot have concurrent threads accessing ranges while we're updating the 
range list. If that is a possibility, you have a race condition anyway. 
You also can't split, shrink or otherwise modify a range while someone 
else is accessing that range. So keeping the same locking context is a 
non-issue.


>
> This patch change vm range overlaping handling that does not remove existing
> pranges, instead updates it for split and keeps its locks alive.

It sounds like you're trying to fix a problem here. Is this an actual or 
a hypothetical problem?


>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 112 ++++++++++++++++++++-------
>   1 file changed, 82 insertions(+), 30 deletions(-)

Just looking at the number of added and removed lines, this doesn't look 
like a simplification. I really question the justification for this 
change. If it makes the code more complicated or less robust, without a 
good reason, then it's not a good change.


>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 407636a68814..a66b8c96ee14 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1967,7 +1967,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>   	return r;
>   }
>   
> -static struct svm_range *svm_range_clone(struct svm_range *old)
> +/* create a prange that has same range/size/addr etc info as old */
> +static struct svm_range *svm_range_duplicate(struct svm_range *old)

This seems like an unnecessary name change. "clone" and "duplicate" mean 
the same thing. But "clone" is shorter.


>   {
>   	struct svm_range *new;
>   
> @@ -1999,6 +2000,25 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
>   	return new;
>   }
>   
> +/* copy range/size/addr info from src to dst prange */
> +static void svm_range_copy(struct svm_range *dst, struct svm_range *src)
> +{
> +	dst->npages = src->npages;
> +	dst->start = src->start;
> +	dst->last = src->last;
> +
> +	dst->vram_pages = src->vram_pages;
> +	dst->offset = src->offset;
> +
> +	for (int i = 0; i < MAX_GPU_INSTANCE; i++) {
> +		if (!src->dma_addr[i])
> +			continue;
> +
> +		 memcpy(dst->dma_addr[i], src->dma_addr[i],
> +				src->npages * sizeof(*src->dma_addr[i]));

This does not reallocate/resize the dma_addr arrays. Reallocating these 
arrays can't be done here, because this function is not allowed to fail. 
That's one reason to use the clone instead of modifying the existing range.

Regards,
   Felix


> +	}
> +}
> +
>   void svm_range_set_max_pages(struct amdgpu_device *adev)
>   {
>   	uint64_t max_pages;
> @@ -2057,20 +2077,19 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
>    * @attrs: array of attributes
>    * @update_list: output, the ranges need validate and update GPU mapping
>    * @insert_list: output, the ranges need insert to svms
> - * @remove_list: output, the ranges are replaced and need remove from svms
>    * @remap_list: output, remap unaligned svm ranges
>    *
>    * Check if the virtual address range has overlap with any existing ranges,
>    * split partly overlapping ranges and add new ranges in the gaps. All changes
>    * should be applied to the range_list and interval tree transactionally. If
>    * any range split or allocation fails, the entire update fails. Therefore any
> - * existing overlapping svm_ranges are cloned and the original svm_ranges left
> + * existing overlapping svm_ranges are duplicated and the original svm_ranges left
>    * unchanged.
>    *
> - * If the transaction succeeds, the caller can update and insert clones and
> - * new ranges, then free the originals.
> + * If the transaction succeeds, the caller can update and insert split ranges and
> + * new ranges.
>    *
> - * Otherwise the caller can free the clones and new ranges, while the old
> + * Otherwise the caller can free the duplicated and new ranges, while the old
>    * svm_ranges remain unchanged.
>    *
>    * Context: Process context, caller must hold svms->lock
> @@ -2082,7 +2101,7 @@ static int
>   svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>   	      struct list_head *update_list, struct list_head *insert_list,
> -	      struct list_head *remove_list, struct list_head *remap_list)
> +	      struct list_head *remap_list)
>   {
>   	unsigned long last = start + size - 1UL;
>   	struct svm_range_list *svms = &p->svms;
> @@ -2090,13 +2109,14 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   	struct svm_range *prange;
>   	struct svm_range *tmp;
>   	struct list_head new_list;
> +	struct list_head modify_list;
>   	int r = 0;
>   
>   	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
>   
>   	INIT_LIST_HEAD(update_list);
>   	INIT_LIST_HEAD(insert_list);
> -	INIT_LIST_HEAD(remove_list);
> +	INIT_LIST_HEAD(&modify_list);
>   	INIT_LIST_HEAD(&new_list);
>   	INIT_LIST_HEAD(remap_list);
>   
> @@ -2117,35 +2137,41 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   			/* nothing to do */
>   		} else if (node->start < start || node->last > last) {
>   			/* node intersects the update range and its attributes
> -			 * will change. Clone and split it, apply updates only
> +			 * will change. duplicate and split it, apply updates only
>   			 * to the overlapping part
>   			 */
> -			struct svm_range *old = prange;
> +			/* prange_dup is a temperal prange that holds size and addr info
> +			 * updates of pragne after split
> +			 */
> +			struct svm_range *prange_dup;
>   
> -			prange = svm_range_clone(old);
> -			if (!prange) {
> +			prange_dup = svm_range_duplicate(prange);
> +			if (!prange_dup) {
>   				r = -ENOMEM;
>   				goto out;
>   			}
>   
> -			list_add(&old->update_list, remove_list);
> -			list_add(&prange->list, insert_list);
> -			list_add(&prange->update_list, update_list);
> -
> +			/* split prange_dup */
>   			if (node->start < start) {
>   				pr_debug("change old range start\n");
> -				r = svm_range_split_head(prange, start,
> +				r = svm_range_split_head(prange_dup, start,
>   							 insert_list, remap_list);
>   				if (r)
>   					goto out;
>   			}
>   			if (node->last > last) {
>   				pr_debug("change old range last\n");
> -				r = svm_range_split_tail(prange, last,
> +				r = svm_range_split_tail(prange_dup, last,
>   							 insert_list, remap_list);
>   				if (r)
>   					goto out;
>   			}
> +
> +			/* split success, insert_list has new head/tail pranges */
> +			/* move prange from svm list to modify list */
> +			list_move_tail(&prange->list, &modify_list);
> +			/* put prange_dup at pragne->update_list */
> +			list_add(&prange_dup->list, &prange->update_list);
>   		} else {
>   			/* The node is contained within start..last,
>   			 * just update it
> @@ -2178,8 +2204,38 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
>   			svm_range_free(prange, false);
>   		list_for_each_entry_safe(prange, tmp, &new_list, list)
>   			svm_range_free(prange, true);
> +
> +		list_for_each_entry_safe(prange, tmp, &modify_list, list) {
> +			struct svm_range *prange_dup;
> +
> +			/* free pragne_dup that is associated with prange on modify_list */
> +			prange_dup = list_first_entry(&prange->update_list, struct svm_range, list);
> +			if (prange_dup)
> +				svm_range_free(prange_dup, false);
> +
> +			INIT_LIST_HEAD(&prange->update_list);
> +			/* put prange back to svm list */
> +			list_move_tail(&prange->list, &svms->list);
> +		}
>   	} else {
>   		list_splice(&new_list, insert_list);
> +
> +		list_for_each_entry_safe(prange, tmp, &modify_list, list) {
> +			struct svm_range *prange_dup;
> +
> +			prange_dup = list_first_entry(&prange->update_list, struct svm_range, list);
> +			if (prange_dup) {
> +				/* update prange from prange_dup */
> +				svm_range_copy(prange, prange_dup);
> +				/* release temporal pragne_dup */
> +				svm_range_free(prange_dup, false);
> +			}
> +			INIT_LIST_HEAD(&prange->update_list);
> +
> +			/* move prange from modify_list to insert_list and update_list*/
> +			list_move_tail(&prange->list, insert_list);
> +			list_add(&prange->update_list, update_list);
> +		}
>   	}
>   
>   	return r;
> @@ -3533,7 +3589,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	struct amdkfd_process_info *process_info = p->kgd_process_info;
>   	struct list_head update_list;
>   	struct list_head insert_list;
> -	struct list_head remove_list;
>   	struct list_head remap_list;
>   	struct svm_range_list *svms;
>   	struct svm_range *prange;
> @@ -3566,7 +3621,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   
>   	/* Add new range and split existing ranges as needed */
>   	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
> -			  &insert_list, &remove_list, &remap_list);
> +			  &insert_list, &remap_list);
>   	if (r) {
>   		mutex_unlock(&svms->lock);
>   		mmap_write_unlock(mm);
> @@ -3574,21 +3629,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>   	}
>   	/* Apply changes as a transaction */
>   	list_for_each_entry_safe(prange, next, &insert_list, list) {
> -		svm_range_add_to_svms(prange);
> -		svm_range_add_notifier_locked(mm, prange);
> +		/* prange can be new or existing range, put it at svms->list */
> +		list_move_tail(&prange->list, &prange->svms->list);
> +		/* update prange at interval trees: svms->objects and
> +		 * mm interval notifier tree
> +		 */
> +		svm_range_update_notifier_and_interval_tree(mm, prange);
> +
>   	}
>   	list_for_each_entry(prange, &update_list, update_list) {
>   		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
>   		/* TODO: unmap ranges from GPU that lost access */
>   	}
> -	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
> -		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
> -			 prange->svms, prange, prange->start,
> -			 prange->last);
> -		svm_range_unlink(prange);
> -		svm_range_remove_notifier(prange);
> -		svm_range_free(prange, false);
> -	}
>   
>   	mmap_write_downgrade(mm);
>   	/* Trigger migrations and revalidate and map to GPUs as needed. If
