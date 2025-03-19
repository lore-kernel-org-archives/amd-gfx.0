Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CA9C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 14:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C2C10E50A;
	Wed, 19 Mar 2025 14:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JZ9/fNaY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8239210E50A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 14:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCEvTFqVgDXL2YEMg/a5V6hxHbHHhPwsA/OrQDTOqBJcJXp0QIhvX/uEKfdgUnFqBgKWDo4f5PNW7ropPGIuSjttJKL4/cyHyp0PtmXk4fV1xzGfZ1M5dWHfBSRVHGlfFzyt901N/335UvWkyQJf7mG6RdK1HtZ3Qlz20kEa9xxW6ewRjpeEBjbvGo+ZqWvWg2eULnzCuEpARu8t8DuIx7wzp965KmbaFa3PGDh1SSBsOcsIw9HF9G6BPckqP5V9v2kEUUdKM6HdZjvahdLPz2hW4YWxLtRwQNiUEe0b5/AAOqIKvBXGG87rHzuVBaQMULFwZanxnGeoMA18BmFlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROMZc8KqiqaXKzLDuAArTY9wp0a/g+psF3cV7lSWljY=;
 b=AQuK+h9cw01kROR0fMsx5iT0Fs5ZeW1agPzh9ZuCldTOwK+OjwnOggE2H9B6KjZknenPDmy2WghwkCOp/XHbxYJQq1Bc7Uw3Ze81PyzF3mrYxZyKY1PV11iiRWr8m23iQVqhtwl1959a23w6ijsF54qNaadf+LHQW08VzvVt8vm5DzC08mdeqXLCmkefODpVCQIBE6J+S5qxMkDUUuJeaN9GefCLLsdvFf0lTuvi2KkPyAMYibuw3iFv0XqkuLT4g0QUe0H7ghbJ7VpvgBDkhiZmVUQEiVVs0XLGNkfTN+x1/0Igd4aq3v5cezgMPjhnrEHlc5tlgv5byQOSE0UM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROMZc8KqiqaXKzLDuAArTY9wp0a/g+psF3cV7lSWljY=;
 b=JZ9/fNaYNno9gwcgyQ8rqOCmSGhbERnUqgcDOE+Co24MvMsD92gF8Qf4VT0mpXxb2/zDSKRajnNXC//eJhiDl2/jy1RFotvE5KA1JRa3NATRw+KeDrYhmG6tCN3cX5eTl1/GJDnsd4J0AWqYmEJxvQlXCn2cAOKUIGOkI5lBX5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 14:17:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:17:54 +0000
Message-ID: <7cb4d0bc-2a19-41a8-93d9-f442ec80d73b@amd.com>
Date: Wed, 19 Mar 2025 19:47:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/sdam: Skip SDMA queue reset for SRIOV
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250318144715.7881-1-Ahmad.Rehman@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250318144715.7881-1-Ahmad.Rehman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: aba8c290-6976-4840-6614-08dd66f0d6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amEyd2ZFaHRNeXl2Sjl0bDZMd243VHZRQi93QTFrZ2lMemNoNndGOXlyREpk?=
 =?utf-8?B?SkZpZko2aVZ2ZkhNVStsYm5iS255S05abVpPZVc3b2xHdjZhcVUranZsQk5x?=
 =?utf-8?B?SGNGd2dFOFNwbld4OUhWc0RnSlVaazFLMm9ZK2huN2ZzelNMc2wrMlk5ME1R?=
 =?utf-8?B?NDZGUXpneXhrRHJpNmNxdmgrTmpUY2VsU0N0MkVRZEFMa1QwSDcrVlgyd05v?=
 =?utf-8?B?Z2xjWTd5V0ViV3BlRm81emIxNW1MdHBGMjFEWU8zcUtLTmdLdktnaGJQbXhM?=
 =?utf-8?B?cDFVTjNHdHNMbktVRjBmTDNmYk9hY2JtQzAzeDVyVktISW16R1k3NGhZUVl1?=
 =?utf-8?B?OUE5UUVhY2RzTzNpWUtBcnc4T2d0cERiWURJV1lnMnNWU1lNMU1Jcjc3TWVW?=
 =?utf-8?B?ajZPYlJJMHlJa2hFVGtmME5xVVROU3A4KzlDUzcwNWpML2tzTlRXZUJiSDFK?=
 =?utf-8?B?V3B3elV1MzZ1THRaZE54MW5kOEZNVENTTDRKdnI4YXpiY0xDdG1QSjhJY0do?=
 =?utf-8?B?S0JZZ29yb0NXekhhV2NTYmMvTnlYazNkRXRLdHFnZkZaMk1hY3djT0RMTHMw?=
 =?utf-8?B?bzRUUVBvQ3V0d1JMZlpvR2tZNm1IK3VQVWpvNEEyVHhHVTJEOUFIL2ZpdjZP?=
 =?utf-8?B?RmR0Tmt3dG9RMmNWTDc1Sml0TFZEWk9xOVdYWnEwSTFXMUFHYVRFVk43ZFJQ?=
 =?utf-8?B?VFltb0xxRk1YMWg1djJ0UW1RQ2pBclUrY1lzVTdqUkpQdElybnN4Mit6cnhv?=
 =?utf-8?B?b2lXZjdhTVlVZytIbFdlck9EbXZ3S0hpNHlDRDBFcWttMlVaMm9NdDNnMmpU?=
 =?utf-8?B?ZGtHeEdCWUVHLzhCeDNISmxXcWRtZE9KdWlBTWlGY3Bad29HZVhhSVRGMTRO?=
 =?utf-8?B?cFFyNkFQcDJBMVltNUl0NkF3YjRkdWE1dTVwMkdLNVZWRStXRWFUaElJVy93?=
 =?utf-8?B?SlgyMm1SZGFURE1HK2h2d0NmZExNN2hZNlZHcWdabk8vQXg4bHQ5VVA0OGJJ?=
 =?utf-8?B?MTQvNmxGY2Zrajd4Nm14WDJUMlFzTlhncGdIQ1BvYWFBY3BHeDRocFR5VFNU?=
 =?utf-8?B?bS9HTEJ4QXRQV29uamt1ZCs1N0M5cTdTQjhlYW5MczQrbDFtSUNIYlRpeG1o?=
 =?utf-8?B?WmQ3QVdLMWVCUHFIeXRkdFpSMjNDV3R5OExkWWN3L0J6UUg1MUdySE0rdDVa?=
 =?utf-8?B?TFVSWUNxQXlHb0ZqMkhuNDB2c1lKMmpjRnk1ampucHUrc3VvK05adGx6K0xJ?=
 =?utf-8?B?OWcyd3NKSWtlaEhOWlppTGxXdFRKUUhDeUE2MDQxTlB5QXkvanhoc0pxM3cr?=
 =?utf-8?B?S2lxWUxrT0w5MHBrOGtWRkpnM3FPVjVyeGIxaU54Y05aS3FZRVJKQlBiWXZP?=
 =?utf-8?B?Yy9XT1YxWHR5NllpbDdjaFJyUUh5VFhReEQ0VjM5TjdEdUVLY3F0bldQVzJ4?=
 =?utf-8?B?aEQ4SHQvbzNMT0p1WlVyWldQZ2tURmd0WWdlVWVWOGw2QU5QdzNVc1FFNUhV?=
 =?utf-8?B?ejE5d2V3bVl2QThhUEY4c1hyaXVpV3d6Z2RpN1lBZXJGU3Z1UTZoUnRNY29p?=
 =?utf-8?B?UU5ENjZQT3VvTHZ2d3JrVExiQko0M0lCV3oyc3p3VURNUVh0V20wUVhaWkk2?=
 =?utf-8?B?OWlSaTFZWWx5L20vaG81SGI5ckVZQktrMjBFZ2s1UEpmU1gxUlB6RTR4cEhx?=
 =?utf-8?B?dW5OZHBxVklQQkxUMkx4UE5FYitVU2hHVG9pMVBTdjd3aWFPRnloYnNNNGU1?=
 =?utf-8?B?Z3kwZTRmVzViNWJONEJBRVdNcUJNUEFjTnFEMnhFWUhCYWpIamdwUWxOWHVh?=
 =?utf-8?B?MzVmQlNBRUZxQm9wUGZyWmFFVDJXOGdzRGQ3ZHl1dUx3VEQybGZ6NjhKSGl5?=
 =?utf-8?Q?2XfNA2ZPuKRAy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdBRG1xYjM4VXJ2SXFnNjRTcENob2xaYnJHOWRMRlNZWlAxck01NnMzTWYy?=
 =?utf-8?B?TWw2T3kxNmFvNnZUNGZuQmh2MzMxd3FtZk0vQ1hyL3M2UGRmODE3bzRaRmhk?=
 =?utf-8?B?elA4dEdJeUxsMDAySEJxVWJyNURCMngxK0laWnJjQjZQMkVjcE1jQjc1LzFp?=
 =?utf-8?B?YXVrWEJtMmJnL3NkSjdpZzVJK0NoODdRU3hnU1dHSnZLbkNyWndPVjRrWWJa?=
 =?utf-8?B?aUE5Y0JtU3JwSWczRG5yTmxIU1ozeGFTTG9DbDZEazg1MUo4MGo1SGgyOGxK?=
 =?utf-8?B?aVl5am5tSlY5bTFNYmQ3M0tPZHBvTzdGdmZtWlBGNkZPRUhpZHducWw5UUxZ?=
 =?utf-8?B?elFIOVM1d09LS0srdGFhc2RlcEtNRURNdXJqZ3V6cDJ6VWZ5cjhkU1VjaTBl?=
 =?utf-8?B?TDZLZkIzVEJLc0JCK1liREZmUThVZlpBMFNlVW11Rml5cndqckVQZVQxdTVW?=
 =?utf-8?B?MzZqY1F4WE5VZzhzK1EvV0dtNGphRFZWaEZ2Wm5OSWhmZEgvUGlvVTBPamk3?=
 =?utf-8?B?c2tNUEsyWXBkc3RHQUdXeXN0TDN0QVlGYU9XbUlTY0dDNUpwYkR1TlhHZ1Jp?=
 =?utf-8?B?ZHZSRlVRMDhZOE90N3FjWnprNkNQTHdyZVBhZmlobHRlYVhoQVhFb290L1hO?=
 =?utf-8?B?NGZyNUpBZDJOTlgvWUUrQWxHRGVFYWFIK29rQUVNVkN1UjF3aXRwRkdXSkp3?=
 =?utf-8?B?SWR4b1kvM0pqdW1Ic0RMdG9xTjQzOCszK0xjYVZ0NHQ3NDZWS2FnS3l6V01t?=
 =?utf-8?B?S1ZWY25iMTF4cjN2dHNNSUxRTXRjUFRPeEF5WGdVWERZM3Q4Z0luZ3lpYStN?=
 =?utf-8?B?ZVR1RS9Cc3IwdmYyYzJNUG5kTFlRZFI0ckpmQkVJKzlINHZZenk1cmt1L0V1?=
 =?utf-8?B?TXBqdHhQVFA1WnNOMjZ4YitFdUZvK1JvdlRvaTlsTzJFQnhzL25KWnJiVVFQ?=
 =?utf-8?B?cTJQTWFlQUlkUDlJMzg0eWs4eDVlancxT09MSjZWZ2s2OGQvcXk3SmFKbG11?=
 =?utf-8?B?M2Q0eTFiR2VoU25vV3E2MkJadVdOM1Vld1lPSVhLbWVtbzlYejhlc0lqQVV5?=
 =?utf-8?B?blRNNVIvZjRlL3FyYmRTeGxjNjBOWmlQTnF1WjRmbXJpcW50cldEZXcwRVdY?=
 =?utf-8?B?OXZ2ZEV6ZG9nc0tGRGZCSVloS0RYQzZyTkRxTDNOS0VlQXErZTViMXZLUVor?=
 =?utf-8?B?bFE2eW81MU5jV1FvT2JScGowVnVvSkhlRGttN3RoSFdTNGt5UXRvcEVGZGxR?=
 =?utf-8?B?MkZKTUcxNnpUN0dHRVhycjI3YkFwQ2hQQ1dEc0Nvd0lMSmtFaElJSkFsMVA0?=
 =?utf-8?B?TzVMbFJHVm5UVFM5cnA0WENqdnJLTFpBaVozd3hsUUFOSGpQSWdLakpVK1dX?=
 =?utf-8?B?REFONzRCM2JXSVlSMEJweEpFNEVobE9WNmFMSUFUNmJFcVFiOWdOaUpUUWtS?=
 =?utf-8?B?NUdZbkFhcXkzR2NTdkR0MlcrSjV1cVBhWDhYcHpkbE5wbDI4bDhNbzlyOTNE?=
 =?utf-8?B?WGJyUUt1eDhKejhMdDdkNFdxdy9iZ0gwMEJWTW9aamQxZVVVR0VXVWU5cWJq?=
 =?utf-8?B?T1JmU0Y4aHFnanRBMDRYWHJ6T0h5WnRuQVA2YnlEQ0F2cTRCOHJwNEtlRHZN?=
 =?utf-8?B?bGt4cUNyaHljQ0IybFVlOEp1aEVSemMvZVBLZHZJbnZyYjFkYUtKSXpsVEJ2?=
 =?utf-8?B?b1dpM21JVE80Z1IzVTZLL0paQTc5dTBldW92SmcvUVBqOXc1VGw0dzVpdjNM?=
 =?utf-8?B?MnQyMXYzS3A4V01maVhKZjBZMWJqeGJQUmJmMmdZdFN3RitYaUV1bTk4MWw3?=
 =?utf-8?B?aStyV3pLRUVSemx6eUdUKzhCZmJuRVY3WFNVdE55TjdLOXBLVmRtblNQTEo4?=
 =?utf-8?B?REp5VVcxMjhxM3BrakxZcEU1bVk3akRrazZkbjlkZ3d2eU5NWWdaSkQ2Zjl1?=
 =?utf-8?B?R0Z0SllUN2s3U3ZPSWhtNFB3U0NoSUFSMmN4WUZldWJZNkJXOWYvdWxZcGJz?=
 =?utf-8?B?YmQ2QkhjYWJZRllua3ZaazhIQm9zMTdYYm16Q2wwRmRMMjFnZWpOalBxNXV2?=
 =?utf-8?B?LzlQdWk1SjBjTk55UWpqUCt4VCtYeTFvaE00MFlqdm1BcngzN1ZMY3RDQnN6?=
 =?utf-8?Q?lo0VkW2kX5oIgr0vantbzqdSI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba8c290-6976-4840-6614-08dd66f0d6d7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:17:54.1627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPp6NIS43hn+KD5FqTvglmro6uQhaCIpWHiMdiOxLcJZ4yrOjp5HLQU+V6DV5yXZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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



On 3/18/2025 8:17 PM, Ahmad Rehman wrote:
> For SRIOV, skip the SDMA queue reset and return
> error. The engine/queue reset failure will trigger
> FLR in the sequence.
> 
> v2: do not add queue reset support mask for sriov
> 
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fd34dc138081..e77c99180fa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1666,6 +1666,10 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = GET_INST(SDMA0, ring->me);
> +
> +	if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> +		return -EOPNOTSUPP;
> +
>  	return amdgpu_sdma_reset_engine(adev, id, true);
>  }
>  
> @@ -2347,6 +2351,9 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
>   */
>  static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
>  {
> +	/* per queue reset not supported for SRIOV */
> +	if (amdgpu_sriov_vf(adev))
> +		return;
>  
>  	/*
>  	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.

