Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB1ECAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 14:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2DF10E1EE;
	Thu, 18 Sep 2025 14:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fmQBqpfj";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010055.outbound.protection.outlook.com
 [40.93.198.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9C110E1DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 14:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSMCvPTbiiyjmG5YmX1xGxpAEeCAcioFHw5dd5R+NFdX6SscBWdAq4qqDdg7qtTpKgnn2M/NjhsauwZaIN75SznDOll2Uxumi2GTsDC5Xibciy65/KkoyaysLQtyOifnEhvgWoK6VLVBem80o0/4Etspoj7ORuu9Iv6mudhZ/fpLc9nb61KZkAXndk5PPuDx+eQGjPKGC12PQ0LkWLbXfU/+Y48juIV36da6xWVBXCYPZ0+6PtKhCxlPgCndwnCi7s1ZREXimNes5hle8bhW22+TXjMRIYNR7UnRoZZhOurIZQzzhrCqgtWWLN74UOJdjPdFrqV6TTv/GK4v8ydOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVKvYw29FDfx71cDJ1U69Zg69QZ1/vtGrWn4l0xSmt8=;
 b=uPXxyLwCySbmbBrgyWgW2PW55JfxQ/S/AI+4m7y38/fg8u+NVOWk4cuS5TJNTrwNVNPVHpPxXd7RsrRiLDX7OViY4SmJjcdfhLRkLtG6dP7R4bh1F2oAc4aSXXyqDob0IvWhDtXNqlvcS28Sx5rA+48w93yPmRq+QcMOeKTcpWCFCl2uIphZfQtIN1AiBrNltt+NnkWJg5qmD7dtWU2Eho7fio2BXU41/gS48yflftf+BQVQDpt8VhpeAjcPdTEIWLDkRtO2m9AQBHorVlQfyrQ2ygThCgUmoOWQzof1tB36emmqTIMCsSptchMQxRf2bOHg34nNeEy0K2hArKIm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVKvYw29FDfx71cDJ1U69Zg69QZ1/vtGrWn4l0xSmt8=;
 b=fmQBqpfj0iHBHHztHBzoB6NorlkuRx2NBZMYATRpln8BcsRlNEXWTIo2i8GpvIJ/Szk12K/R3pc+0b0CH92nc+IcIQA9Vi8x87kDfxoXDp/VPZjpUUzhZ0jYpCsD6Qj7MF7UDzegt9QAZ7sJLgyNyUR7S0kDTKsfwGJXTeTq04g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 14:35:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:35:09 +0000
Message-ID: <7c0f8c1b-0a55-4824-ab01-28745db06051@amd.com>
Date: Thu, 18 Sep 2025 16:35:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: use hmm_pfns instead of array of pages
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250917172201.3874839-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250917172201.3874839-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 656a8a93-c54e-4526-38c7-08ddf6c0914e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzdubjVaK0g5ZjIxUmZkMkZiSnNvL1BmLzIySmRrdEVBdEhaTWNQenU2YVBI?=
 =?utf-8?B?YVNDZ0xINjNDY0VDdGxXcTh3TzVhdW45UHBrUUVONjJnMlZxM1l2MjhNSmVs?=
 =?utf-8?B?Ty9USDZ3SDFramxoTVZEdWxKYnQ3RmVOZGZCTEN6OGFGWms5U1lZZklIVjB6?=
 =?utf-8?B?Y1F1V3ljM2pYbENwV0w2MHRqWDZmaXE1eVpVK1ZUZGxQRG9vNU5md3F3Z01G?=
 =?utf-8?B?OExXYk5KaUh2Q2xvbkRnTVlLalYrUUpnSmNGbS9qWjR3b0tTa0NsL2dTNGpZ?=
 =?utf-8?B?ZG40UFZPZ2VoTzhTN3BXaWthOXhNQVdLUGJxOXUxWDE1cVhJdkxOSUVBZU9o?=
 =?utf-8?B?UXhVbWkzanZBR3crUHd3Wm44ZUNPTVhGcE16ZEIvWU41T0pyVC9RblVLejNv?=
 =?utf-8?B?T3BVdC92RDI0SG1MdWU2LzM4UkYwZTJNTFFhTWpNa0J2QmJsMitEUlJsaTE4?=
 =?utf-8?B?RmIrWkFIZmRFUXZ5OWtlOVlhTXFZc2tsZTJRREw1UktlaHYwY3FIM0w4dXpJ?=
 =?utf-8?B?Uk8zTFNJZEtSemMwem5FV0k5VHc1cVRWSGRHbmszdzZ3WFM5dVBaYkcwUTB4?=
 =?utf-8?B?WWlWQ2pUSXgxbTJBWFhiTUxodThVZ2lkS0FKcnJ0bStZby9ld0Y5Z2hMSkhU?=
 =?utf-8?B?ODRqUG9wSVd1eThBRnlhcjdibGREUU5oa1NQZHYwNWFqbnd2VnVQLzVKc3lD?=
 =?utf-8?B?US9qRHlUMDU5SjdFcnFVZkJTR3VPSDZDWTdqekVXRWhPZlNOWHR3ZUQ5U3hx?=
 =?utf-8?B?aVV4UXF3U212UEZ4VUlxTC93eGRlb1ZsSHhxRXFtbVVTTzRONm5tbTJmQUoy?=
 =?utf-8?B?N0V3eW9HRTl4TTJvd1hJaE5PbHN2L0hCSDBqQ2drU2ZuRGphUElvS1NXbFQ5?=
 =?utf-8?B?VXRxaE91UXpwOUtKbHZZVm94TFNrMGVMaTNiUjNaNzM4dFc0eG5HdXFyUDRD?=
 =?utf-8?B?MmNGS0tFRGMwVVB4ejdqeGZRK25IQmRUNTQzOEVSMjczTm45SFl3ZXJ4TW9Y?=
 =?utf-8?B?S3ZWREdpT1dteDZaSGhEelFtQWlVN1kzbjE5UHZSQXp5NC9kaWVSY3I0Vmxz?=
 =?utf-8?B?ZDlMTklWRld0aUZqWDZMWUZRTXhnQkNtMGg2OVVuRlNCTmsvbjViZlhYTE1t?=
 =?utf-8?B?L2U3cDliTW1sWEtmK3FxTjZDMEFIbEZtMWFualQzNG5XK3RrSWdUaW9zQnlm?=
 =?utf-8?B?UDhaR0pXeDBEVlFPdkJ4UVltQS9aQVpNejlHQldUWFlXZ0QvTjdtZmZvc2xQ?=
 =?utf-8?B?NFFuQkM1WmF3aXVRNVg0bnUvVjcyUlJTRlFEb0lsVjg1SkRxVExjU1l3OU8z?=
 =?utf-8?B?UnJXYUtFajVpWEc1Q211YzZuV3dubXFJYzhQdDBlYjFqWnA0Sml5bU5kYzBv?=
 =?utf-8?B?K21mMUkxMzBsRG1RUy9VRVZNL3gxVEpMdVUvbkhjeDZvejI2UExqeU5zTGti?=
 =?utf-8?B?YXhDaTA5ZDVkV3dyOUU5QjFHdmpjQldscFpMVHBuNHFQelF3LzBzK0UybVly?=
 =?utf-8?B?S0lSWVRQaUtjakg0b3dtdVRPd1BSeVM0STlHckVPb29hVG5nMzNzWnhHZGdF?=
 =?utf-8?B?SGo0QXkzWUppY3VEdW1LOEVocjluVWo3RXZ5YmtCZUZNWDQzbDhMVlV1N0Qx?=
 =?utf-8?B?Y2xLVGNRNXV1bGQzUFpBeWRXRGFmWElOKzE1VlFOaHF3T2RRTE42ZTVFZ1pU?=
 =?utf-8?B?bmZWOWlXcEFSZ2JTMTV5c1dlTUVPQm9rWXUxeFh1OVJCMFNwRnA1WjY1bVJu?=
 =?utf-8?B?TUc1S3ZvUytwQmdqOXBVQXoxMCtjQTE3dDBycVdKM3J5SnVOSzFtZG9COG4r?=
 =?utf-8?B?SzVTam5ROUJ1d0M4dFJQQkZUSk9sQk05NlBUZEcvWHhRektxb2hwYU5RUFdE?=
 =?utf-8?B?QS9FYjc2WUk0VmZud1Eycm5rdml5b3BmNUdZOEVwQk4wejc2Ri9kbC81Vjgx?=
 =?utf-8?Q?vrdQ1uSjTbk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEl4bWpieitkR1laTWppajB0R1ZRbVBBTWdtdTF5Zlp3aUpERlNWcCtTU0ZN?=
 =?utf-8?B?WWx3ekIrdm5nbDZhQytsU2xoeHBHQU5wSDAyTy8wT0NhdlEwcjQzRlUwTThq?=
 =?utf-8?B?S1V6aXhiWmVKaGNrbGlZdG1Sbk1nNGd6OE16TmNLZ2RhTTlQOVNyU0ZjMGR1?=
 =?utf-8?B?MU9JVHZJdStRKy9xdEoxOVJ6c2JhN21ObTVYRDZ5cUk3OXlIeEZKRmVGUDZm?=
 =?utf-8?B?b0psNFo0N1Bhei9wa1pXSlI3ZXJndFRuSkJ0Z2tGM2V4Zi9lT09UMXp1ZnNs?=
 =?utf-8?B?N0QyVFNML3NNWng1SDhNdTZNdTVGOVVtWnFKZjgrN3JvK0ZLR0t5TWYyRU4r?=
 =?utf-8?B?WnQvTWdQVHVDMEhxRjNiUzg3WCs5b0pJZ0VqbTdxU2tkSXFyL2RHVnN6cUtN?=
 =?utf-8?B?bWlOTlozVUpjd3JGU084R1JHZ0hXMjFhMkZwaWxHWE12N1kwYlhMQjhLYmE3?=
 =?utf-8?B?ZCtpRXdjM3VIVm9maW8vczM4WE03QTY5K3Y4and1ejNLZlNjTHRUUkhDS2Fs?=
 =?utf-8?B?YWhYdTRHalNIaVhUVmRqb2NEYVZ1UlZJRXMrUzZwMkZ4ZVFFVGczY1BDVzlV?=
 =?utf-8?B?a2ZGYU5KY2ZMY2dwTHkrTjBDVXZKcytlbG1FL0lFay82S3hxcGVXclFTMFhX?=
 =?utf-8?B?dUZTY1BaV3dhemNZUnZkeHFVZzdsQXQ3RUxvNU5xd1l4ZkFkRlMrSUsxRUh1?=
 =?utf-8?B?OTMrb1Brcm1IQXZHTllTaDE2QmkvVEF4K3pmSWYrdDdZVzVmYXkyUlJ5RlRl?=
 =?utf-8?B?czdNV3A2bE5sd1J3VGRodkh5WXJQWTFBYld3eldHTWtwMkFGdzlvSEpxZjZr?=
 =?utf-8?B?OHoyUkFmUjJlTjlrMW9iUG5vYkl2TlQ0YzgwdUpEVTdpNHhXSExWcVBCczRt?=
 =?utf-8?B?VkZ6THZSbzZwcnhVdzFnNlhjRGw3SW9yVTZBVWlrVmxrcE0vVHRwd2hYamdj?=
 =?utf-8?B?UDFBU1R1dFBwdDMzbDI2R3pQZ0VCbHNGSWFHSkxaa3RFQjEvb1c2V2J0ejFG?=
 =?utf-8?B?QlFGbjlVb0hvWHVSNFpIVW8yVE5YSStzQ250anlTVUFibWRoR2p3c1hnYXF3?=
 =?utf-8?B?eldIdDBCS2poOHJ2MzR6MXJ6dHM3VHdsL2VzRFlrU29ZeFdZT3NuR0lSYTMy?=
 =?utf-8?B?b2JvVmFzakV2RFhwY0Z4Q0tYTFhpbzlSa1BMZnNPTUxlTWhXREpUSmNHd1RL?=
 =?utf-8?B?UnczWjNyVE9wekVJNmhRSkkvUTdZOWlBdGZrQlYwMDBHenpBT0x0ekF3MXpE?=
 =?utf-8?B?RVdpdDV2ZHFhZFAzeTZCcHViY1p6Y015VzAyUDk5NVNuTGJqUkJEdkkwclMw?=
 =?utf-8?B?UCtqenREbjQyckxDcTFRSkZqQWkyNkFlTmJxYXFMZ0hDT0JlYjZVMVM0d3By?=
 =?utf-8?B?a0RaY1lSUHk3WmJDeXhTLzlrcmxtZ2dWZWlMdE02WEN4T095cGtZWDBucGwy?=
 =?utf-8?B?SDd5OE9sVDJBelFvOWVxOWRuWHZGSWV1aTVpZDFlM1pjKzQ2aGdnWVRmZzJF?=
 =?utf-8?B?bG5KSUx4RzhzVk1GcEp5VDlPUnhVYTdOQUFwRWgycG50YUhYcFpNMncwM0Mr?=
 =?utf-8?B?dE1LdUVVdDlsZldBVEF6MTBySkpnOWFienZ0YTA1RlZQTXQzd3FHaGk2bFF4?=
 =?utf-8?B?T1R6SGxEeTBZenFWbWdnZTJsOEhEYWYrT1IzK0xWREpWRzlDTmVDVXgzMzBM?=
 =?utf-8?B?blFHUkpFKzVzSkJIampqU0g1OUNrYTBsSWFXTmM2b1kzSmxIalJqKzh2SnJn?=
 =?utf-8?B?L1ZYT1dZRElkdVU5bktWc0xuZHpZVDkxTk9lMXJZZzVJei95N1lCd0UrZXNH?=
 =?utf-8?B?MldYR2ZwWUI3M29JdUV4U0FlNkxnWlJvaDZwZ2FwYTVPVS9PUjZIdldUeVA4?=
 =?utf-8?B?T2NzZ2RFNHNreU8rK25GRWdTWElCc24wenhNWXZoL1YwN0U1OVprWER2aENz?=
 =?utf-8?B?WDV2blpSUGFCbnY5R0JhcDdTdjRuQUh5dDdya01rWm40L0VmZGN5bUdmTEF1?=
 =?utf-8?B?WjRCWEd4MXhyQ0txZWxVQU1iaUVNY2dEL0lyaTV4cm4rRXFHRk1yOG1od0tR?=
 =?utf-8?B?bXlHMFRLOHo0QzBKSWFERWVjV0Q3d1B3Y3VydFhuVHRYZVlLZCtEUEpzUzEv?=
 =?utf-8?Q?5VLeeTBwj6m59HGCkV5um8V4p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656a8a93-c54e-4526-38c7-08ddf6c0914e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:35:09.1134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFKTF5LrRHH7XZmpaiV8n+RIVPqf+Tk55qz72+F+35dbrVOtP2AOL/dola5mmpq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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

On 17.09.25 19:22, Sunil Khatri wrote:
> we dont need to allocate local array of pages to hold
> the pages returned by the hmm, instead we could use
> the hmm_range structure itself to get to hmm_pfn
> and get the required pages directly.
> 
> This saved alloc/free a lot of memory without
> any impact on performance.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 10 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 30 ++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 10 +------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  8 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  5 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
>  9 files changed, 25 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c3b34a410375..7c54fe6b0f5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  		return 0;
>  	}
>  
> -	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
> +	ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
>  	if (ret) {
>  		if (ret == -EAGAIN)
>  			pr_debug("Failed to get user pages, try again\n");
> @@ -1103,6 +1103,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  		pr_err("%s: Failed to reserve BO\n", __func__);
>  		goto release_out;
>  	}
> +
> +	amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +
>  	amdgpu_bo_placement_from_domain(bo, mem->domain);
>  	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>  	if (ret)
> @@ -2565,8 +2568,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  		}
>  
>  		/* Get updated user pages */
> -		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> -						   &mem->range);
> +		ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
>  		if (ret) {
>  			pr_debug("Failed %d to get user pages\n", ret);
>  
> @@ -2595,6 +2597,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			ret = 0;
>  		}
>  
> +		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, mem->range);
> +
>  		mutex_lock(&process_info->notifier_lock);
>  
>  		/* Mark the BO as valid unless it was invalidated
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 555cd6d877c3..a716c9886c74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -38,7 +38,6 @@ struct amdgpu_bo_list_entry {
>  	struct amdgpu_bo		*bo;
>  	struct amdgpu_bo_va		*bo_va;
>  	uint32_t			priority;
> -	struct page			**user_pages;
>  	struct hmm_range		*range;
>  	bool				user_invalidated;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index defb511acc5a..744e6ff69814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -29,6 +29,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/sync_file.h>
>  #include <linux/dma-buf.h>
> +#include <linux/hmm.h>
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_syncobj.h>
> @@ -885,24 +886,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		struct amdgpu_bo *bo = e->bo;
>  		int i;
>  
> -		e->user_pages = kvcalloc(bo->tbo.ttm->num_pages,
> -					 sizeof(struct page *),
> -					 GFP_KERNEL);
> -		if (!e->user_pages) {
> -			drm_err(adev_to_drm(p->adev), "kvmalloc_array failure\n");
> -			r = -ENOMEM;
> -			goto out_free_user_pages;
> -		}
> -
> -		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages, &e->range);
> -		if (r) {
> -			kvfree(e->user_pages);
> -			e->user_pages = NULL;
> +		r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
> +		if (r)
>  			goto out_free_user_pages;
> -		}
>  
>  		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
> -			if (bo->tbo.ttm->pages[i] != e->user_pages[i]) {
> +			if (bo->tbo.ttm->pages[i] != hmm_pfn_to_page(e->range->hmm_pfns[i])) {
>  				userpage_invalidated = true;
>  				break;
>  			}
> @@ -946,7 +935,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		}
>  
>  		if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
> -		    e->user_invalidated && e->user_pages) {
> +		    e->user_invalidated) {
>  			amdgpu_bo_placement_from_domain(e->bo,
>  							AMDGPU_GEM_DOMAIN_CPU);
>  			r = ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
> @@ -955,11 +944,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  				goto out_free_user_pages;
>  
>  			amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
> -						     e->user_pages);
> +						     e->range);
>  		}
> -
> -		kvfree(e->user_pages);
> -		e->user_pages = NULL;
>  	}
>  
>  	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
> @@ -1001,11 +987,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>  		struct amdgpu_bo *bo = e->bo;
>  
> -		if (!e->user_pages)
> -			continue;
>  		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
> -		kvfree(e->user_pages);
> -		e->user_pages = NULL;
>  		e->range = NULL;
>  	}
>  	mutex_unlock(&p->bo_list->bo_list_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index a8fa09184459..8524aa55e057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -571,8 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		goto release_object;
>  
>  	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> -						 &range);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, &range);
>  		if (r)
>  			goto release_object;
>  
> @@ -580,6 +579,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto user_pages_done;
>  
> +		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +
>  		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>  		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>  		amdgpu_bo_unreserve(bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index e36fede7f74c..4441572d6ad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -167,7 +167,7 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>  
>  int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
> -			       void *owner, struct page **pages,
> +			       void *owner,
>  			       struct hmm_range **phmm_range)
>  {
>  	struct hmm_range *hmm_range;
> @@ -222,14 +222,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	hmm_range->start = start;
>  	hmm_range->hmm_pfns = pfns;
>  
> -	/*
> -	 * Due to default_flags, all pages are HMM_PFN_VALID or
> -	 * hmm_range_fault() fails. FIXME: The pages cannot be touched outside
> -	 * the notifier_lock, and mmu_interval_read_retry() must be done first.
> -	 */
> -	for (i = 0; pages && i < npages; i++)
> -		pages[i] = hmm_pfn_to_page(pfns[i]);
> -
>  	*phmm_range = hmm_range;
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index e2edcd010ccc..953e1d06de20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -33,7 +33,7 @@
>  
>  int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
> -			       void *owner, struct page **pages,
> +			       void *owner,
>  			       struct hmm_range **phmm_range);
>  bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4e2486dbc0a6..280400b13c54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -707,7 +707,7 @@ struct amdgpu_ttm_tt {
>   * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
>   * once afterwards to stop HMM tracking
>   */
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct hmm_range **range)
>  {
>  	struct ttm_tt *ttm = bo->tbo.ttm;
> @@ -744,7 +744,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
>  
>  	readonly = amdgpu_ttm_tt_is_readonly(ttm);
>  	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
> -				       readonly, NULL, pages, range);
> +				       readonly, NULL, range);
>  out_unlock:
>  	mmap_read_unlock(mm);
>  	if (r)
> @@ -796,12 +796,12 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>   * that backs user memory and will ultimately be mapped into the device
>   * address space.
>   */
> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages)
> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range)
>  {
>  	unsigned long i;
>  
>  	for (i = 0; i < ttm->num_pages; ++i)
> -		ttm->pages[i] = pages ? pages[i] : NULL;
> +		ttm->pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
>  }
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index bb17987f0447..6ac94469ed40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -190,7 +190,7 @@ void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct hmm_range **range);
>  void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
>  				      struct hmm_range *range);
> @@ -198,7 +198,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>  				       struct hmm_range *range);
>  #else
>  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct page **pages,
>  					       struct hmm_range **range)
>  {
>  	return -EPERM;
> @@ -214,7 +213,7 @@ static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
>  }
>  #endif
>  
> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
>  int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
>  			      uint64_t *user_addr);
>  int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 68ba239b2e5d..273f42e3afdd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1738,7 +1738,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  
>  			WRITE_ONCE(p->svms.faulting_task, current);
>  			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
> -						       readonly, owner, NULL,
> +						       readonly, owner,
>  						       &hmm_range);
>  			WRITE_ONCE(p->svms.faulting_task, NULL);
>  			if (r)

