Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90034CFD318
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 17:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2CC10E318;
	Mon, 24 Nov 2025 17:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="loqwIsaR";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E8710E318
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 17:20:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khMiD0lRQ07G06YXCFOTmfgosH3OomD77zrVxEAafZI7vKzPeGluvg/iy7GPfKTx4/a+r8XNZkWrw74MNY3maMnOKlUJVb4mSYmVo5APYnnkLYdfs7+6sgDxKC4RXZdqNY3CAUi9EirKKG7Yxyw2y7qHcAtkSXGyKFi078P+J3Ehjxn5XK0Np2z2Gz7A/DTR4KzcktWKChqvNaOOJiraGAGZx4sG00XQ+6cv2b32rXMK2kOKOuSPe25gWUrgY2gq5E2ssqJ8HbqExNJX/IcfD2eHBfkPExurJsQvHNdpNUn7jj9lpNkMcwrWH3PCNj1+a+7Tw9G0c8uFznXkj9l8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+GwdgB+K3+Q9O7xwRxajIy9BS1Uc3sxaxKLfp5EoG8=;
 b=MTbLhbN7V+ZGAbqIRP6pEQn+juiVxv6318P4chgkTbrWjCLxcrOsdFNMyKc9eknZNSqF2Updbx8gbOCyZLIphhsYOpl1c/CAqhuWLB6g2R7mpWEYflGRLM+43QilRqvhBdkQwymAHg3fZd+/BQ3dXhLVE+GERn+nYLN7IY4d2gfQs4SsmncIJDXRCe5497kSdDX48SrFqT1KGUivHHgvH6AN8a6ixeXJ1LC/sh/Ze3nlHfUeixqn7RLe9D/PHTiI0rcO3A7GM1QFucn5qYOBp+Nnv5qjA8Ce2psSc8w9ThzNt5BXajq0PAb4GdV2M9fNGh/6uAO/UoMUinW1qpUzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+GwdgB+K3+Q9O7xwRxajIy9BS1Uc3sxaxKLfp5EoG8=;
 b=loqwIsaRD9ihrS47kWuvVi5R80mceg4c2txuzrNkY0OMDHEd8KXK6L4kPcKDvc5CmpC9KTZ5LhBs7/EEZUdEbL7i7HlMlQbFZhBVpKb0ZYVcPICoWyKbIeLEPPkslhsMSBaaXM5iCFEhq8aOGMXf8VTmkIAcwCymXZEx0t3PNH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 17:20:02 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9343.011; Mon, 24 Nov 2025
 17:20:02 +0000
Message-ID: <c4f3454f-5509-45da-870e-c06442c03e74@amd.com>
Date: Mon, 24 Nov 2025 10:20:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/hubs: cast register values to u64
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251124170509.450426-1-alexander.deucher@amd.com>
Content-Language: en-US
Cc: Ethan.Cheung@amd.com
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20251124170509.450426-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:303:16d::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 39135123-f1a3-4aa1-638a-08de2b7db3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGhEUGQ3NWdOcVpmYTBaTnYwWU45VlVqYll6ZTNGeTNIZGduMkxlT0todDRN?=
 =?utf-8?B?VEgycEppQ1JQM2M0aWY3alROTXJNRlQyaEM5MllHZ1hiUjVUaWJCamZzTG5j?=
 =?utf-8?B?aEpvSWN1aktINitUY0hEa0llbjFwWk1WSExmWmg0bWFCcjNVT2ZPMUZVcnBY?=
 =?utf-8?B?dzFjRmRpVzJZWXdtR0FQeCtPTHBkTkEwby9WMlBMR3AwaVdhakUyZ3VDV0dt?=
 =?utf-8?B?dVJhUnhEWGI0NXVWRHJ1SERzU0ZhRTRmU0huK29sSXNoVEdVZkpSZGtJaW9N?=
 =?utf-8?B?d1k3RmNodk14bEw1SDV6MmJyU2l2SldhYlJMUkpLV09tZ3gzQmdZSm9odnNa?=
 =?utf-8?B?ZTd3dmd3QnZCNm5VUk5jU0xvSU9nZmdzaGxGQjQvZmpyYVlkTVFRK3NXN2NM?=
 =?utf-8?B?azBJbmM1b2FkNWFhaDNNVytnamRaRnpzUlFRS2VRVUgzV2RzL1JhWkY1bXdr?=
 =?utf-8?B?K0Iva0YxVkZnQ1dPY0YyL29NYmQ2eThSeEpvYTNZbUNjcTFlZUtvREN0RlRm?=
 =?utf-8?B?RGZ1VGQ1VXE3MlNDVUZFYWV0SFZ4MEpYYnpzVTBmZWtxTUNmVjRpT3JTMmhC?=
 =?utf-8?B?TlNhMWhXbTBGMDBCK3p3bXpvaXE3VUxYZ1N1MXVjMHlGM0hzZVN1VFROUWxZ?=
 =?utf-8?B?c0lkejFETmF4R1VUQjEwb0ZIMnowR0YxVkk5YWphZGN1aXpYNGROU2VoZGwz?=
 =?utf-8?B?blVQZzRaZjNIbWNOMDJsU0I1QzM3dkxEWnoyR2ZxMlJ5QXp3a2VqcHVDeHNo?=
 =?utf-8?B?MkhtTjNnOTJQTkJJWmFaTkFoMnJudlVrLzROc3J1aFZYN1lyNDZWMklnVDU3?=
 =?utf-8?B?RXY5NDJMelBoM3NQR3lFNHI2Vmdib1RkaUNyejNlNm9WQitjOU1NNktIajhh?=
 =?utf-8?B?anA5Q2Z2VzEzYmtaYlpoTk9YTldpWk05L2cxb3FaRmlqUjMzL2hoejNyMElB?=
 =?utf-8?B?Mld6dXZ2ZXRycGQ2UEE0d0dIYlFFK3c3NUpjbXZXS2pPQ0JPTnJ4cEoyL1VF?=
 =?utf-8?B?L1RCcDZHRkkrclNJS0pQTEJHWXcvRGJ4NE1EQW8xejU2OEJqbzlWV1dJNklJ?=
 =?utf-8?B?cGFGU2VJTTFwTlpXWUk5dlJrOWxqMU00ODdDeit3KzhtMTEwcnBJMEpkS1hL?=
 =?utf-8?B?c0NYYTRybm40WEtKOG42MUR1dmVyV0p3MSs5VmtHZGZDeXl5VmNNRGtRR1Rv?=
 =?utf-8?B?UUVWR09xRFRXTHowNHJtUVlxRmxuVVJ6UFZQSC94SzdZdTc4c09FUTNtQUY1?=
 =?utf-8?B?ZXkwWjNVOGV0bjhmTmR6TFVHTUQzUG1aTDI5L2JjcHI0VlI3ZGEwQk9mWlAx?=
 =?utf-8?B?VXJncHJsdGVhUVpxVTQ4bTVEWFBKSFprY1ZHNE5RdGd5ZHBkMXhIL1ZqQllL?=
 =?utf-8?B?RnBXenk4eG1iODhxOVpPUkdKSS9IWHJWamVmRUcrdTltR0Fza016WnZwR3I4?=
 =?utf-8?B?TlU5S05oL2lHWFd2V1FSN0hNRHNZQW16dmk4VFZLZW5hc0tiRDhuTkJqVTFO?=
 =?utf-8?B?NkVuMm9uOGwwLytXS0lEc2Iyb0c3cVNHSC93SExMREhveFZpVWZ6Nzg4cWxr?=
 =?utf-8?B?ejBaczlZcHZuSGJXWUUvaGlWQ0k2TEo5ZzRCUFlUNmV4U1J0T25MUFprMWhy?=
 =?utf-8?B?R2tOQ2M0enZsWWhodFJ4WStERHI0WTNaZTlxMHYvdExkRk4zKzZRbzk0R1dh?=
 =?utf-8?B?ZlRxMUNCeGUvWHVIZ0d2VlJiYXRLYWIrbmVzQ2tYczFpMGx1bDZEc3dqdHBZ?=
 =?utf-8?B?bjJsWGZOOE9DdXJHYTZpbWpINFMwQWtDOE1YWGUzTTAvUWtyN1YxMmxabm5S?=
 =?utf-8?B?Mmw1aVF1VmxjU1ZJUVdWeWVxRnVDT2dGYnJxaHpmUFkyOG1PL1JSY1JKQWM4?=
 =?utf-8?B?MlI2L0RzTHNmeXl4ZXJPaHZqTlArVURwanlkVFZnY2hNNVlMMVBIcHZOZ0ds?=
 =?utf-8?Q?wZlpV+Ykn0eKEsKRlV6QttCCF7phu3lq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1EalpuaFlBQkplUUFKZ2pnSVhITGxYMnVCbTdXVmtUb21YdHB4am9FcXc4?=
 =?utf-8?B?TUYwcHYvVkNEYUduZGxUczlxZG1oOFVZN1lKRkhsZk5pZlpYdk90d1JSaG93?=
 =?utf-8?B?ak0yR0JZbUlnUzNlS3labWFVQ0cvRmVMMk1yNDdxVW9sUGtJSEtkQis5OVA2?=
 =?utf-8?B?eUdiMkw0S0wwb3ptNUlFVzA0b3EvMm1Fazh6SDZSbU5ZeEZ2YWF0T3JQbXVP?=
 =?utf-8?B?amsvTFhsTjhoVlIzcTQyTlBRc2NyRXVLclZtNTRKOHJxOENtTlBuN2dwdkt0?=
 =?utf-8?B?MFRUc2hxeEh1Tzdzeis4WkpITjhnbzE5Y2w4TDZnS0pyckMvUDNScVpOazVm?=
 =?utf-8?B?c0N6MnhGUzRWN3Vvd1QxWGNXM1U2cHNLTGluaDllREhiM0pjYmN0cmRwc0Iv?=
 =?utf-8?B?VUFuU29zKy8yMUh6ajV2VkF0cERBUGxncExCSU9LN0JSWmdFRGxiY1p5b0dC?=
 =?utf-8?B?YkpmVUxsWWJLcmlQU3pmQlo5djA2OG8vbnlJWjA5ckNHN25ObmxseHNDSW5y?=
 =?utf-8?B?V3NBZy8xNVQremVDWUJJaklEQzN3dkpjeVJ5c1IvS1MxZjZyVlMwc1BlVDVB?=
 =?utf-8?B?UTN3dXArOGV1RS82SUtCNklwYUF4MEMzS2twRUNXWEFSaHMwOXhmVDUyNWli?=
 =?utf-8?B?Zzd5ZlplWWFYT0ZZYW5zRkdtTzJMV0lLWFYzS0Nac1lBdVVSbC9PeU1ualBT?=
 =?utf-8?B?Z2w5VGxHREtoZEZDTEs3ZE1vdEhTWDhGR3ZpSjhQYzhBbG9GYVROVUxEV0Ur?=
 =?utf-8?B?TkUyVWl5VnYvaG9NRFVMaWM0MjRSc3g0dlFwUUJIRUJGSFZpZnJCcjUyQ3Jx?=
 =?utf-8?B?cUtOUTgwRVJpT1FKNDd6clgxWitvTW1waWdPNzZ5R0NYbWtXZXdFTVl3R1NR?=
 =?utf-8?B?UWRpOTd0dk55TjBneGxTNTBXWFNYZnZDZzNqa1NTRVJSRGZJTlFBbTJDWWpq?=
 =?utf-8?B?RTVXSzlGSCtvRHdnNEJRZjVrb0tqaTI0V2gvd0hJNTZtNlNIazhDUlR3Z29o?=
 =?utf-8?B?K0pScG5jTmI1K3g0VmZFRUhtVDJkTTNmQ1hkTzRSRjVYeFlpMXkxZDBaU1R0?=
 =?utf-8?B?S1M5QTJFQ1dJdC9FWW1aNGRpZnVsN2FpM2NPeVZwNkltRU13c1hzY2ZtS1hB?=
 =?utf-8?B?Y3krejgvNVo5Wm5YcGdYbmdzNDg5YmdJWmZNNEIvdElzb0VRdXFjdDNQVHYr?=
 =?utf-8?B?RTQzQnJNbnJZa1J1USs2aXdKaTkwVTh1ODFkOVhMTStxU25UaGw0c1RRb0Rx?=
 =?utf-8?B?MWhzdkQycVdkZ3p6UnQ2WC9WY0xiSnR2UnJQVmpXZkI4UUxjYWxLck1NVGJE?=
 =?utf-8?B?RVRMbVg2MEhqQXVpeFBPalR1TytzZEZPeFBVSjdkdGVJSm1WZ1kwOGl5anZw?=
 =?utf-8?B?aXhlY1R5alVBbU1Gc3JqOU9Bc21TY3pIVFZ3WG0yRmJNRzcyWlQwYWhwQi9Y?=
 =?utf-8?B?REIyM3dRUDh2dkJvcGlXQktOVFNBZzZibkpUMUJEN3NtTlF6QWM2ejVFRHFq?=
 =?utf-8?B?L3BiaHdlVCtJVlhEaUtWd01EbTk3bEp5N0tRL3FGWXJBdzlWenFsWnBZVjRu?=
 =?utf-8?B?Q2Z4c29tSEgvQ3BucCtwN0hCM2Zlc1MwOXRZQk1uNW44UDdJcmR0ck9qVHFC?=
 =?utf-8?B?VGhYeEtnMVhzeHRidElPdzhrbUZPWnVjbXVNdVpKRHJ6LzFmd1JUdmJVcmV5?=
 =?utf-8?B?cGd3ZWNKNVo1VzRPTjY1UXJubncwKzN1SGxOamU4SXFMVDVhdXNLMGdOeG5q?=
 =?utf-8?B?SVdaRkZLR2VQaEJkUmZzK2pKcnlKcGZheEp1QksxSkNzSDRETmY0RzZJWWtF?=
 =?utf-8?B?aVE5VXhiVGlVNFBzNzNXRTFvaEVTQ0sxOU8ySzZ1TTVFOUIxNVJKTzJ2dVNs?=
 =?utf-8?B?bENUMXRneFBiN2JsRVIrdTMyTE14amRveExpc2pzSXNmN1hZY0JIeHZxL0dm?=
 =?utf-8?B?T2RvYVNaa0NyUndhOC9HMUFEOHhheFJXZU9ZMmJ6Z1VDV3lWS2RaQmVlS2lE?=
 =?utf-8?B?OTY3UGt6VjM0U01DZHN6eDhWOVozZWlEaVV5UmMrZmxxQW1LQ0VYeXVyM21j?=
 =?utf-8?B?ck4zdHNHcThyeVNBNUpCcDFwVS9hRlVvazdIOEVDbm40czhWWXFKNUpxUVpQ?=
 =?utf-8?Q?CRTWyppHiQgFXq67JxKoChgQ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39135123-f1a3-4aa1-638a-08de2b7db3e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 17:20:02.3747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6uiI1d5XGNp1uvuc+ThIYOGTnPs8opCHeD7+EYUxwB6a3SUZaxAElU4d2jIgtm06Tfl8G2DADbRmdVyhW+qZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
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


Reviewed-by: Alex Hung <alex.hung@amd.com>

On 11/24/25 10:05, Alex Deucher wrote:
> Cast the register value to u64 for the shift.
> 
> Fixes: da0020bf6deb ("drm/amdgpu: Add gc v12_1_0 ip headers v4")
> Fixes: 3148d9bb913a ("drm/amdgpu: Add initial support for mmhub v4_2")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index 4c59da7f2ccb1..ceb7eb562ef0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -45,9 +45,9 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
>   	base &= GCMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
>   	base <<= 24;
>   
> -	base |= ((GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> -		  RREG32_SOC15(GC, GET_INST(GC, 0),
> -			  regGCMC_VM_FB_LOCATION_BASE_HI32)) << 56);
> +	base |= ((u64)(GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> +		       RREG32_SOC15(GC, GET_INST(GC, 0),
> +				    regGCMC_VM_FB_LOCATION_BASE_HI32)) << 56);
>   	return base;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> index 23f0042125008..24582b8d90ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -81,9 +81,9 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
>   	base &= MMMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
>   	base <<= 24;
>   
> -	base |= ((MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> -		  RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
> -			       regMMMC_VM_FB_LOCATION_BASE_HI32)) << 56);
> +	base |= ((u64)(MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> +		       RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
> +				    regMMMC_VM_FB_LOCATION_BASE_HI32)) << 56);
>   
>   	return base;
>   }

