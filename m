Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6B9C02192
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 16:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6279010E121;
	Wed, 29 Jan 2025 16:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Im4U6qwU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F61D10E121
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 16:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIj2AN+eJrM5AZZOjo7S40a22LFrm41C9kVNsmWTfc5fg+UPY3hIfhfDqsG6LRym76VTWJiWWkpRNvA5EFq9aHFuDwQTuddv5sKPeKPV8MA1Oo3aSpSbr9U4hB9ZRPRJeHHja+K0EvD1VVI7KgX/pcwYGTfdHYkmXL1va3DPj+gusieOvcQ0ONRlD8NyznmLshM92AItq67C9wyBGxnq8vW16qX/OpyYdv9j06+nJL3PueDIJIE53OZ/+HXt1JS3Q6G+gxAt1mF6ui8esFtfWHRuOUPlQ1hhbt3EwqUk/q7FEIEQEZrImQnp43lSrHFV2cVb9hZ4x+hY2kwnfzqFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIuBIpLDHSWdAn/ebMC1AVoF0JJlp5acMMQtENZUKCg=;
 b=KboXMb+LJScEVp/qSK0QIldeamkuj0I/ZniD628r/1fqy56e38GZqEJg85RPGOdPIi8mZYLoGZL31ve9KSZaHa68d2/9zDAGX4oTLZw09KEe16X7oBFiEsOQp1eG1jJniWCUxiF25mly1g+OxnOxcOD0z++epxsl4h72R4+kzgfeVDtBVlXeQxacp7b+sjVMdmrVAdGN0TFcOheW5Ptk71Cu8YOluLXdnczKix3eDfr10edRt8fcx4a2J9K7CqMMgW41+GaMwIR1KiZHKRJvupxP/7yY8Vzx4OFC4m+zaAVdCfRK/tJ6Eo5ZYvoCawuf7jfaAxvUSfHSxbAkCTiHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIuBIpLDHSWdAn/ebMC1AVoF0JJlp5acMMQtENZUKCg=;
 b=Im4U6qwUGivTN+fFlZsIV9P2LSeePUryEGe2VVfOkABId2YyKDL8kJCL1Tu8gzoqh4G1xwBSRdD3ZQF6uR9Eg2+LDN1eqAcyGouYqlDfCm8ChtkW4BBeV9R/4a0mTWVBhfVGe96mAB8cEk1pEwNNYH0wfM1WLOHGnJN2Jz2635I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 16:41:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:41:02 +0000
Message-ID: <af4ba8cf-b23e-497e-a5ae-2ae4f3aa24f9@amd.com>
Date: Wed, 29 Jan 2025 17:40:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Unlocked unmap only clear page table leaves
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250123203931.18867-1-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250123203931.18867-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0218.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 519e6979-1dfa-4f37-26c6-08dd4083b7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUY4RGRGVC9ZTWtKL0tpbHc4Zmk5bXJKa2dJSlR0b1dFQmliNThZemt0NzB6?=
 =?utf-8?B?VmlzU2J5MElVL1hCQ2hIaUFRTnUySGt6NDBsNjZsSys3eW93S0dha0ZlZ0Zv?=
 =?utf-8?B?Sy82ZExNeWJadjlQMW5rTitDd1ZTMU1yZlZuamkrWGg3aFFDbUxrbWtNNTYy?=
 =?utf-8?B?M3FKVDNtQkZad0c5eGJsRG1OZ2NNU1NsWWR6NXNmbFg5N25kR2JPK0NJNnJH?=
 =?utf-8?B?TjZ0c20rQ3FXK0Z6TlZ6ZHhEa1k2QmlJaDBFNWszU1NXcEx3NzFkYUFBR2Rz?=
 =?utf-8?B?QjlTWU1qcm45UnkweFZZVWdiQUFQTEVQUmgwM3dmU2FXOWRGSVZwRmFHdUdT?=
 =?utf-8?B?NTd2SDN3c3VYRnUzTDVRUHFLNUh0aW9DY3p1aytFUVRhNUxPNC9jdXN6dlNy?=
 =?utf-8?B?WjR3SDVyemo2UFBYV2djTUtKdXh2UWk5MFRPMk9GeGxBNytHMUtuc0ZQWGNr?=
 =?utf-8?B?WWVQRmEvdkx0ZUhqWGNJSmxSSDYxaHczYzQyeDN0WTNQQVFhOGZUOXZHTjMy?=
 =?utf-8?B?S1prdGFpQ0FlbWNlYlJYUlpUNE5YNWhUaGszeXVsRjB5NFNjWTR2RUl2Rkp0?=
 =?utf-8?B?RGhSemVORkNjNGRYQi9lNDg1QTNqQW1xdGhiaTJFTVlMYTBkc0o2ekEzVHdx?=
 =?utf-8?B?UDlyUGFReVM2ZksxOUlRSi9NMGtMUmQvTjJIWFllQ0ppYTc4Ky9UUkNsYVgw?=
 =?utf-8?B?aGJrNFAwZ0dsTzd5NGsxbFpDcElLQWp2TzJaSUhhOEdXb2VaSVNOSDZuN1ow?=
 =?utf-8?B?Y0FKdTYzU05zZjEzT2NPY0NCb25XTDNNbFVleDYvR0dTN21MeUYwVHU0cWY5?=
 =?utf-8?B?OEVENWRBbHJ4VDRtWTB6clpqSlo3a0RaZk1XbmVaMW1EY2ttaGhFakJUUjAx?=
 =?utf-8?B?U2ZKcFJ4VTBYREV4cU04dnlTTjdnQjdsYzUyTVZhUUJDL2ZKckFxM3RsRlBC?=
 =?utf-8?B?V3dqeUJteStOdFRsait3NzFDdUs3a25ndmVUdFBWRURZb0dQVDRZSVM1Z1k4?=
 =?utf-8?B?a0drNHQ3cC9PdVJxblkrcUNUdHVqbUQxUWdDOE5oMDFNQkpGNmEzWWpQa3BU?=
 =?utf-8?B?bmV4VTlDNm0wVy94VzNXazR4b3ZhS0RTT29CRkxiZmQyK1RVakRCckE3YTJp?=
 =?utf-8?B?OVVFbnVYcjJtUFVNNkh2VWx3MktQelhXbjFXejIwelhXaTlxOVVkNy9KQnFp?=
 =?utf-8?B?WkVDRENIS3psVmZNMVdHbkdRVEhsdldaZzdNVVByajRsNk5xcDF0SlVBY3or?=
 =?utf-8?B?clQ4Rm1laGM1dVBxYXNZa283dnYrOUJqWFZiME1BSVBiVURzeVp5TTZndjNo?=
 =?utf-8?B?OXFQNGdjb3lsS0kwb05JdSs5bXpHSnVKZHUzbGlUUTk0UmJWOVk0QVVYVXBn?=
 =?utf-8?B?MU56MEVBVzNIeVNsMnBveDRLbkdVNFZFSDV5OTZ0ZDBXVkpkQTZ5eG1uUHA4?=
 =?utf-8?B?bk1sQ21zclJGZEZsVk5WMXI0a1l0Z3Y4bzBMV0RUdVprK2p3ckFtMXAxWFlY?=
 =?utf-8?B?MzBuVkY4ZTJwY2FqeFV1ZU5PUHJ4YzFHSmdHc1Y5ejhLUU9XKy9yMHZaUDV1?=
 =?utf-8?B?UTM1RXNtbVQ1YkRoRm9hOXYxS2Njc0IySXhYamJRa2REcmhHY0Z0ejdrZFZq?=
 =?utf-8?B?TU4rMFZBeXVCUnM4ejVoMjJaWXpCOWRoL1N0ZkxqU1BKbUNsRkhtOUhReC9m?=
 =?utf-8?B?eXZBNTFLb2NtVkoyYlhWRUZmd1htMml6SDlZV25qUU95NUw1ZWE1K3BxV3dE?=
 =?utf-8?B?RVlncHJvN0FrK0pGdWhpTlFaYklOS3B1Qkloam9NZE5WcGhlZXZDMzc4U28x?=
 =?utf-8?B?eXQzNVlUd0JlWERVSGFQOEVWd1JzQTkzaWhlNnVvd2l2V2NZVlpjSjFvVGhw?=
 =?utf-8?Q?kVqVoMZ+O9Edf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RJYmQxRUt2ckRlUlRjVmRvMnc1YnBUeC9PdjVScGxJQ2JVcEtvTG9IY041?=
 =?utf-8?B?SXFRbDA5NURpeU9CcjM3UGpyMVV4a1Vkbm11cERzM3RDRlp3dGVJTVFza0Jt?=
 =?utf-8?B?cTMrRUFVbVhudXI1WXd3MHd4OFBKbE1HbDdmK3NmM1BVbWtiY1kzSFQ3VHQ5?=
 =?utf-8?B?NktIczVnaDdmRFlPVHBOTmRCMVBjd0NuS0NLaEZ4Z1RpSW9jYTFFNmdVZnIv?=
 =?utf-8?B?RXF0UEtNRTEvL1h3eG9sVFFZUmhzdFFNWUw5MCt2YW1FZWQvVjVjNU0vWHYr?=
 =?utf-8?B?YzAvbnRhNlFZZ2E4Q213eTd5YlhpVUc2QjgvRlVHdDRIZEtWYzdKTU9oYTF1?=
 =?utf-8?B?TjhzRzBBdWYremRpZTNPdzFrb1loOGNjVzJ0cFZjWkI3ZnozSVVyVGZCUEk2?=
 =?utf-8?B?eVJDWkJ5cTg5cE05OFU4SlBzM3k3OHZEK09pRzB4dXNEZXowV3ZjMWtxbUU5?=
 =?utf-8?B?K0xuTUYra1FMSnU1NHVraG1BNG5YRU1nRDd4eEdBa0kvL1dxMmF3K29uRDBa?=
 =?utf-8?B?bHdhaHpqRWtDVmhxRDNFbHlINmtxOThZYldQb1R3QW9kWXhVM0krUlA3djM5?=
 =?utf-8?B?R3lvL0FJS2tUWU5weldYQTcyOXhUWFMyUVFCSVkvYWlpenNYMmZ0ZGtsdHBY?=
 =?utf-8?B?SExZazVEbXQxSStMSnh6NlNLT2VXY2JlSmxBVEVxNW9BVWZQVk11YmVVZlhM?=
 =?utf-8?B?Q2JrYmZLbGxOdnRsSDhIU2UxZVEzUnhtNTMxT0p5elN5R0g4MjZhTFRaZlRp?=
 =?utf-8?B?N0RnUXkwWUFiWFFnekNsWHZBYzlsb0puWThFN1pHakcvc0dkUkxIZjN3bHVq?=
 =?utf-8?B?NnVvNVNJeGl2U2F0SFR3UG5EM2VXbXZjb2wza1oweXNmVms5NEJoQlpXSlB4?=
 =?utf-8?B?aE9wK0dDQ2hYZGNDakpiRXZjaWx1UWNuYU1ldUVVbjVlY1oyTXQ5cVFFZkxS?=
 =?utf-8?B?aXRhT2M2emlEeVFaNU9iemZkT0pZTFhaVm8vei81SmdGWERYZkJmK0VZT1N2?=
 =?utf-8?B?YkU2aGpXczA0S1FCQUl0bGNnZnhqMVZ1UXF2dmhvMEdHQ3E2bFdEeE5HR0ZS?=
 =?utf-8?B?THJrWjlwRTgwQjkwck1JUS85eGtFOC9iTktYSkxETWdodWRHMElVcy9iOEpB?=
 =?utf-8?B?WitFT05keHEzcnVnZjZhemZHZXR0VjhoL0NEcmVBYVZZVEtuZFZJQnF0STM1?=
 =?utf-8?B?SU95ZERpZFMxcmppdGd3NXRQaE85NWtveEM1TnlaTTVtZFplN3VTMkJRdHQx?=
 =?utf-8?B?VjU1REtNdWJXRy9IQ0xJVUxvVzNVNGJ4Zkc1Vm5uOGhhKzhQTiszZEFtdjlr?=
 =?utf-8?B?NFhZeitCMUhDdEpDdS96SGd4NFhIeUxENmxnRjNhZ3RBdG53eVJ3OXNXZGho?=
 =?utf-8?B?K1RUdEt4R3NVZGF3cWswdWJZaVUxbFNPTGJwRzNiZUJhdXBIcWkrZDJDczNw?=
 =?utf-8?B?ZU5jbkUxT3ZLZlFtcjRmK1JBYURLcE5ERGhTZG5wUjZwU0F5U3pEYy92cFlI?=
 =?utf-8?B?dndVcDRCRGU2My91MEdpY1hyY3BTOG1JWXl2MnVPOWM0TGIxZmtsblZQREJr?=
 =?utf-8?B?d3NDWm1BVFo5cWloQ2VDZUxtL0hxMVk2aGpaRVU2cFc1WVJzUE82alJhanRZ?=
 =?utf-8?B?NVBURFhjUGVoK2JFVGE0YWJ6MUtuWEhOL2Y0Yjd3UUFNZmJnQ0pnS1ZXUEVW?=
 =?utf-8?B?RE1lMXMxUXpuYzJjYXBiQU0wdmM5VEgzMHhWSFdWd1VuUnpBdXRBYjQ2ZkdZ?=
 =?utf-8?B?MEhJVUpGdHBBd09IdlFNeDVhRjBKQVYzVE9kWTcwRTk4MndEVW1LY1FRSnZI?=
 =?utf-8?B?VWdya2xMdWJGSzZ2bTN1anpHakVIL3VpRW9OMkFOSWprVC8vYzNBa3pTcjZy?=
 =?utf-8?B?MkRRKzJWOFpBRnJtTDIzQnRXOERzYXZ5My91UmVxWGwxTitTVkZFcVMzd2dn?=
 =?utf-8?B?bUk1TlRHYlB0MHo0ZklXNEV4cm9PY2kyQnZjQklrTjZPdjZSNWJQMFYySUJh?=
 =?utf-8?B?T1RvQWdtZUdtMzgveDJnYXhjQjJ0eDkxL1RGM3kwUG1pMUZvRDQrZzhpT0tj?=
 =?utf-8?B?S2dCOGVLK3A4VHNsQkpXSlJsNmtGYXpNWExmc1RTMFVrS0U1amdaSFhvSDJi?=
 =?utf-8?Q?Xd3FThB1ZsyQgN00lhDXeRuSB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e6979-1dfa-4f37-26c6-08dd4083b7d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:41:02.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyVPPDQT38/1VMRAzWTwOxzMwAMVBAPRvAIylykZx89s8eQDHNU1MyJWgkwXXfC4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
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

Am 23.01.25 um 21:39 schrieb Philip Yang:
> SVM migration unmap pages from GPU and then update mapping to GPU to
> recover page fault. Currently unmap clears the PDE entry for range
> length >= huge page and may free PTB bo. Then update mapping should
> alloc new PT bo, but there is race bug that the freed entry bo maybe
> still on the pt_free list, reused when updating mapping and then freed,
> leave invalid PDE entry and cause GPU page fault.
>
> By setting the update fragment size to 2MB or 1GB, update will clear
> only one PDE entry or clear PTB, to avoid unmap to free PTE bo. This
> fixes the race bug and also improve the unmap and map to GPU
> performance. Update mapping to huge page will still free the PTB bo.
>
> With this change, the vm->pt_freed list and work is not needed. Add
> WARN_ON(unlocked) in amdgpu_vm_pt_add_list to catch if unmap to free the
> PTB.
>
> v2: Limit update fragment size, not hack entry_end (Christian)
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 54 +++++++++--------------
>   3 files changed, 21 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c9c48b782ec1..48b2c0b3b315 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	spin_lock_init(&vm->status_lock);
>   	INIT_LIST_HEAD(&vm->freed);
>   	INIT_LIST_HEAD(&vm->done);
> -	INIT_LIST_HEAD(&vm->pt_freed);
> -	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>   	INIT_KFIFO(vm->faults);
>   
>   	r = amdgpu_vm_init_entities(adev, vm);
> @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   
>   	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>   
> -	flush_work(&vm->pt_free_work);
> -
>   	root = amdgpu_bo_ref(vm->root.bo);
>   	amdgpu_bo_reserve(root, true);
>   	amdgpu_vm_put_task_info(vm->task_info);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 5d119ac26c4f..160889e5e64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -369,10 +369,6 @@ struct amdgpu_vm {
>   	/* BOs which are invalidated, has been updated in the PTs */
>   	struct list_head        done;
>   
> -	/* PT BOs scheduled to free and fill with zero if vm_resv is not hold */
> -	struct list_head	pt_freed;
> -	struct work_struct	pt_free_work;
> -
>   	/* contains the page directory */
>   	struct amdgpu_vm_bo_base     root;
>   	struct dma_fence	*last_update;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index f78a0434a48f..063d0e0a9f29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   	amdgpu_bo_unref(&entry->bo);
>   }
>   
> -void amdgpu_vm_pt_free_work(struct work_struct *work)
> -{
> -	struct amdgpu_vm_bo_base *entry, *next;
> -	struct amdgpu_vm *vm;
> -	LIST_HEAD(pt_freed);
> -
> -	vm = container_of(work, struct amdgpu_vm, pt_free_work);
> -
> -	spin_lock(&vm->status_lock);
> -	list_splice_init(&vm->pt_freed, &pt_freed);
> -	spin_unlock(&vm->status_lock);
> -
> -	/* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
> -	amdgpu_bo_reserve(vm->root.bo, true);
> -
> -	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
> -		amdgpu_vm_pt_free(entry);
> -
> -	amdgpu_bo_unreserve(vm->root.bo);
> -}
> -
>   /**
>    * amdgpu_vm_pt_free_list - free PD/PT levels
>    *
> @@ -579,20 +558,9 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	struct amdgpu_vm *vm = params->vm;
> -	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
> -
> -	if (unlocked) {
> -		spin_lock(&vm->status_lock);
> -		list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
> -		spin_unlock(&vm->status_lock);
> -		schedule_work(&vm->pt_free_work);
> -		return;
> -	}
> -
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
>   }
> @@ -611,6 +579,11 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
>   	struct amdgpu_vm_pt_cursor seek;
>   	struct amdgpu_vm_bo_base *entry;
>   
> +	/*
> +	 * unlocked unmap only clear page table leaves, warning to free the page table entry.
> +	 */
> +	WARN_ON(params->unlocked);
> +
>   	spin_lock(&params->vm->status_lock);
>   	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
>   		if (entry && entry->bo)
> @@ -794,6 +767,21 @@ static void amdgpu_vm_pte_fragment(struct amdgpu_vm_update_params *params,
>   
>   	/* This intentionally wraps around if no bit is set */
>   	*frag = min_t(unsigned int, ffs(start) - 1, fls64(end - start) - 1);
> +
> +	/*
> +	 * MMU notifier callback unlocked unmap only clear PDE or PTE leaves by setting fragment
> +	 * size to 2MB, 1GB, 512GB. If leave is PDE entry, only clear one entry, next fragment entry
> +	 * will search again for PDE or PTE leaves.
> +	 */
> +	if (params->unlocked) {
> +		if (*frag > 9 && *frag < 18)
> +			*frag = 9;
> +		else if (*frag > 18 && *frag < 27)
> +			*frag = 18;
> +		else if (*frag > 27)
> +			*frag = 27;
> +	}
> +

That here looks unnecessary, the higher level handling is able to pick 
the right PD/PT level based on the fragment anyway.

Apart from that the patch looks good to me.

Regards,
Christian.

>   	if (*frag >= max_frag) {
>   		*frag = max_frag;
>   		*frag_end = end & ~((1ULL << max_frag) - 1);
> @@ -931,7 +919,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   				/* figure out the next fragment */
>   				amdgpu_vm_pte_fragment(params, frag_start, end,
>   						       flags, &frag, &frag_end);
> -				if (frag < shift)
> +				if (frag < shift || (params->unlocked && shift))
>   					break;
>   			}
>   		} while (frag_start < entry_end);

