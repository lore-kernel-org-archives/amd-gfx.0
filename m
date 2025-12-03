Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99316D15DB7
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 17:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BFA10E189;
	Wed,  3 Dec 2025 17:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mZpglg0m";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD6610E189
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 17:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0XD6KW/n0cc/+943nZNOKXMnrVe0wS4V+gewp8JjjoA6ABl2eRYa+ykILKtyC5TSDj0L2G6BOXN6DQO0BKGlFB5O1vDnHpOkhVEN10br14klRCnbWMN3PY/JuSwRhiR0xEQdNCuOVeZc0zbBlibN9HR/I+S22lt3jMkq9KJSPRTuyYtVe4BuV9XaSSOHC96tgClZc4vO1Y+kiy43JANYEjCEq5xnaTUzlAx3JV4JV+HCzucPoAvcS/80kiRKdg4EwRhezBSpku5kBh7Lil6fXK0QdUrHDFPqrdxqM7AoxHb+tlov6sQ9m3VMhKyIfYcUOLkBgtCgCA+LYTpnrPMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaDoFVwgIctbKlezmNcI86jbKGC/AuDr/Ihyg+7+V+8=;
 b=absxBT5RcO0fGzfkBdY3EaEligx7ZJazfBbA8WbYAC08CNyYwK1meFxYn4mzgJKuRBqf3yFsNOLL0k3DiL4i+fQ5j5lOk1XgoqnIKkbuWbvflzzOpTGXBshP/40eSMHfQ9CYwWQYkk57q3PwJ9YlUL+gKkxw7tCmQJYnLl613vH63lopX2RnYw82b+IaKuvS10rdRxmxtVeav7ab/K0Iot+uS55xoRNRWlBIonJ4I38bhZqCvXQXqklYfT5xsj+f2csACaPAeHpJ8CznkOvM6YWookdYk+8MGQ0Sg0SBBjmKjZXznv0OhRPni9mU0Igt9ezxCzAfUaPEJ4q1loXKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaDoFVwgIctbKlezmNcI86jbKGC/AuDr/Ihyg+7+V+8=;
 b=mZpglg0movXCjrJrBJjAk2NdGE7Z2v18creYGrOcF4C+wNBvtL80fgLcr+uHwXrDr1O4tmV9O8yubSKyNQn0IFXuPxMckR8mBCwTTUhFrEMmTDC2HqwaCMHQXaKIecImSumAdqLWUrv6yezKc0Q5jabrSJdmOCkKXgylV7rP05g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8776.namprd12.prod.outlook.com (2603:10b6:510:26f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 17:41:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 17:41:01 +0000
Message-ID: <026f82e1-be99-4a16-bf3f-dd6950c15cc7@amd.com>
Date: Wed, 3 Dec 2025 12:40:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-2-Philip.Yang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20251201142838.1516452-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0289.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fb26a8-9bdd-4461-f65b-08de32932029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0NJVXZoRDNJYVFGaDNQTGdncGZtK0I1NW93dWgxRnNIN1gzSkZ6SnpSbWcr?=
 =?utf-8?B?eUdtRE1OUUEydUZDWnNEM2UxUzl0MklsTEhwMzBPZGxvM3IxRTVWRWJvOWh2?=
 =?utf-8?B?RUJ4cWxxQVdvYVJYOXhKT3Z2OW1IOHlsY2FpclJTYWNWQVZHTW9sRlNsYVFG?=
 =?utf-8?B?S1c4bExicDRlblhldEFYcldqbzd1OTBKbGJ3VFpFSDk2TU1aQ2hRUXJZTzJ6?=
 =?utf-8?B?VEdWOTh3amlOYnFQMjBYc29yQ0M4cy9Tc1Y3OGYvcDJsSW9RQVNncXpuY1J2?=
 =?utf-8?B?RjI5MFBoTUlqUENubmxWRlplTGp6cDlrNExuZElpTU5KMzdzekt3bjRWak5k?=
 =?utf-8?B?WVZjS0p2QkhCWnFzQ3hXTWVqYmNwVnZQdFY1a1VRbzRUSDJUWmE3MmJQSlFq?=
 =?utf-8?B?OUE4Nm84azIzdWhFVkNjOFZ6Y0xJRUkzR1BHdnZWaDIzT1dxMGpMcVlMb01T?=
 =?utf-8?B?b3pFZFJEdlFpK1F1akJ6ZXI0V1dLcko1ai9XMzh4NlpHaVRhNEVkVjNoelZQ?=
 =?utf-8?B?dDAwNHUyeWUyTVB1ZEtPb0VCRFd5MDA1Zk9lZVMxc0hNUit6aXo0cGpkL3Fl?=
 =?utf-8?B?WjgzaFZVSkgyRG1Yb09yNktWRVFaTTllQmh4WkVLOUZ6YnV6RzdKeVFTQ1pF?=
 =?utf-8?B?eW9SckVvR2h1TFN5Q0U3UWlVbTNOQWF5NFhFV0hYRU44Vnd2U3FFSmwveU9r?=
 =?utf-8?B?dnJwZ0pqZlZXUCsxK3BaOEdvY253VVRmdkhmUlZGZExBOStXQXFPaDNtcEd0?=
 =?utf-8?B?cXdtWGo5K2hSdVZFTUZ4SUpZOGRMekFVRFZqWWdqTm1JSFJRTGFvaHdtdWVH?=
 =?utf-8?B?RWNnbHhsMmc0a0Q2TnZkTUFma0hTZUhQcm1PaTBNNnh3Vm1ENUkzT1loRDlx?=
 =?utf-8?B?MlBoemNxSmtWWDZWNy81NEZnL2dRQ1VMRkFRbE9KNk1KdWpxbEVpWG1heVVH?=
 =?utf-8?B?cWg3YkJ2YjFQbVZyOFZNRUR6ZEVqdSt0NGx6VEVScDJZU0hDSUtQN2JmRjZw?=
 =?utf-8?B?RW5IcU9VeGUycXVEbzFQY0U1Ync3OU40WE42d0ErZUNZbHZqVkJIMlBOck5r?=
 =?utf-8?B?VFRqd3F6U3poK0dmVUJ2am5GWGowUVNzbFN2MU8vZm1uSW5uSzgzUld0MlBO?=
 =?utf-8?B?VUJBaFhXampwNUtWZ051NHM2RmxRYnpkY2NnREdmdDUzYXdYblcwWFk3VTQw?=
 =?utf-8?B?S0RtazNBU29jL0dBZkNPSE13YS9ZM0l2NXZJOGlzellDTnVtYWNXTUc3OWlZ?=
 =?utf-8?B?OVdjaGxqaW50NkM1Y2VSMHZmQ01xUWdQY3BMaVFhM3RIMkxNUWs4Mm5Qb2hC?=
 =?utf-8?B?YlQwSm13cTJDK0hQL0hwdWRBS0l5R1Vjc0M3Q2xKK1dTR29ybnFKWmVySDk4?=
 =?utf-8?B?OXNHbTNGY3JMNFArcXFMa0hpY0dGdUhGbTFkMUpWUFdUV3lyQUVyTVdZMzVQ?=
 =?utf-8?B?SE95RjRjSStFMmJWUEFuRDNBUG9ycUwzeE5BM3psZVFoRDgxWGlodWV4Tm1w?=
 =?utf-8?B?MkZsT2hrNXYzOHdrblVqY0NlNURQUDVQVWhYUTF5ZTlQZXZNQWd2clZ0L3RG?=
 =?utf-8?B?RDNvQ0h1Z1d5RmNYYmNsMkMwZzQ1YUUwanNsbERvemdrNVU4ejBJMVNaY3pi?=
 =?utf-8?B?SWFTd1djNmtGTWlNbEhodlNHNDVHSVlqWjB2MXZXM0JKazhoUXlvaXJrNEpk?=
 =?utf-8?B?elNxeXVKNmZ4VHRYU1JwaGFJS09NWWFROGJYNC9tTncvYU0wVG9qTHVCK0w0?=
 =?utf-8?B?ZlV2RDhmUmRTZmlRSVZkQnc3T2IvN05zcHl5K01EYkhlYi9lNy9jN1RWdXkx?=
 =?utf-8?B?cks0ZnpjMWpubEFOWHIrajZUcUxKcmpRZVF4L1F2V3p5cGdOSUoxZjlpbzlm?=
 =?utf-8?B?WkxvWnJreUN1SlFsUUlGU1JUbkhQT0wwVmFTVGJYcUZ3OUsvTVg2b3ZwSms0?=
 =?utf-8?Q?B5S3yaEARP+KDYhU1SyQaSam44izbthO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHliOUpWSmV3Zmg0ejdvUjgzbENLWlJMMFk5akZQUnI4bFVhSTlMb1l3bElS?=
 =?utf-8?B?QmxFb1J1QVVnN0gzbmw2QzM2V2VGekhkbUp5VVk5L2w5dU1rRzFNdTdYSksx?=
 =?utf-8?B?b1ZuSjRSbjlrNTUrY3hmTHRNUXBHSG5NVzFqYXBJNmZwQzA1ZWgzRHBtU1BM?=
 =?utf-8?B?YWNoS0R2ZWx0YWhtK3AwWER0QlBTaTVrSUZzbUkvb01XaHpJTjh3WGJaeTA4?=
 =?utf-8?B?OFQyVkRFdnA5Z3BiSXk1ZkdGcFZ3ZlBmeGFqdG55NFBNbnJSY0dSMHVBT0ts?=
 =?utf-8?B?T01IWGZxc1Nac3p6eTlnRmthSVkyNEVTeVF6bjhOelhRN1o1enBONTR6R1Y3?=
 =?utf-8?B?NHZsYjhDMFBQcW5CMytUdmkxMi94VE5SUWh5YnNuNVZUZTJFQnNNb25DMCtJ?=
 =?utf-8?B?eTlzalc1YWlQSjVFRWtYdCs4MHpQTFdMSXdyTHNtaWVXZXlpY2xIWDQwemhF?=
 =?utf-8?B?Vlh3cklRZXFhQllyODR6MmNERFRUM1A4YjFwa3ZBTFV3bjdzdktNMG0wVWRq?=
 =?utf-8?B?NHM3VUdSYTNpT2pyOVF5Z2d5MXAyalZzQklnYldPanIrWDU0UlVzR0dJRnd2?=
 =?utf-8?B?ZHBjS1lWUVNBNzA0cUJDY2Exem15RlkySmxNb2FVdHk2bzFBNmIxVTVSVFhq?=
 =?utf-8?B?NTJjS1BSYWNqcUdicGs1bUhMcDY5S2hsU0ZFOU4rU2krdmhZcHJXdFEzQ0wz?=
 =?utf-8?B?S2tzYUdDRno5RWxabkFac1V1WnpOK0RFWGlrNkpBYk1Gc3l6WUFTckJaU2Jk?=
 =?utf-8?B?M0F0UWNPRklobFBzZGxCbHY1UDc0L2pLNkxJd2YrYy9jQXpmQmNXL3JkZFNT?=
 =?utf-8?B?VEFCRTFpMDVaR3ZkbGsxMXR3S0hEUVRML1lETnJ1eHVGcDB5bmtJaDRrUnV4?=
 =?utf-8?B?RVlRMG5nZ2ZtMVFtdkhpZVBkbWdyUjF0dDV3c2o4ZmZMSkNYQk1OQnpPbDNZ?=
 =?utf-8?B?MEtCU2NXZE9hZ3dzOXZWMC9oQy9Jc0xVL3IxQlF3YVNlTk9CVWdBWisvcnF4?=
 =?utf-8?B?RGJGNWd1SEYrZi9VK2txMXUycy8vK0hqekFWMWYrWDhzRUJJVGdjRE1CVTZq?=
 =?utf-8?B?bWc0OG1QcDU1WWFMQ05QcFZydnZaamova2VsTXozS2pmMnlFTzNuTm9RYUlJ?=
 =?utf-8?B?Qnl5RGE0MWZROWVsdHFEUi83ZUlaaFZQdjB2NHJKNzVxeUFBdk5CMHdkYkRS?=
 =?utf-8?B?OFp1clNNZms5b05yTU8rV0pCUHVtWk1qNzU4djk5UGYreEFkN1F0cXZoUzhV?=
 =?utf-8?B?K0ZvT2pxUWxqeUlMd2txa0ptNUEzb1Rpc0VWQmZmb3FpYmNqaXBhb1pSR1VM?=
 =?utf-8?B?NjdrSVpaZmxvRmZIMTd4UGNrdmNYQkVXSlVFdmZrYUJweUF6OXBVK3dXaGVY?=
 =?utf-8?B?b3R4aFZDWC9ESVkrL05FZUVxUitIbUZSaGd2N0VXTWQzOXo5RXJqckhlcUNZ?=
 =?utf-8?B?OTVCblNTVFJBdzlqME9RZ3JtTjZTYldFaHl2Q21YQU5IQnZRdFZVdlJYd0xu?=
 =?utf-8?B?QUlJeFc5aVFYaUlJaWZMZENNR1FjdWRIc01MeSs4dSs0SUNNblJyREdncnp1?=
 =?utf-8?B?UnMvdUxUQ0t0V1J5aUthTWN2WTM5cFJpVXllQzNOd2hnTVI0R012SU9KTmEx?=
 =?utf-8?B?OWRwTXRwNm1qbnFEckZaU2g4OVoyTHhyeGJtRFc2WDVQMnBkcXkvVWxuWTg2?=
 =?utf-8?B?cC9JcjBwYkVNM0ljTGdab2xiWUw0UGltYUF6Um41c1Q4RU14eXIveWNBZmxO?=
 =?utf-8?B?S1MvbGxYZzVwajNmQnZFRmQ4ZEhXZm8xa240NkFzRnpPWmh4Mm5waEdBbjls?=
 =?utf-8?B?ZkZHSHMzUHA0RUdYc0ROeGpJSnRCU1VodWd4SDduQ0hiSDA0SGVUQmxkV2ZZ?=
 =?utf-8?B?WnFIbVVWV3hJa1BFT0xvUVFtMFhORlU4cTVTQ3pkbDVVUTZucXFYd0N3N2Zw?=
 =?utf-8?B?TzFtT2JWZlpRRDd1Y2wzZHA4K2ovOU1IQTAzMWNtdTBYeWpITXVsSnNuWVVv?=
 =?utf-8?B?Vmg1S0FrTlhMSXE4YWpRT1p0VEM0Q0JWY0VadERHTEdsMUdydFN5dG5zSG02?=
 =?utf-8?B?R3dqa2tzV29BWDl6ZDRKcE8zU2ovWm5RTjUyb0J4elJQVWNwcWNmcXA1TE8y?=
 =?utf-8?Q?rgIw0dNsGHpWandgzrvxJG8s4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb26a8-9bdd-4461-f65b-08de32932029
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 17:41:01.6328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it2Je6ymHO6X/m8A26ocG062sz2gTXrSHcbXVxwVXYEppDbN98s5voAf1u8AenDqvKX33OogtQcDoRfgaypJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8776
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

On 2025-12-01 09:28, Philip Yang wrote:
> For gfx9, bind MQD in GART with mtype RW to enable caching, to
> reduce queue switch latency.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e553cf411191..5f58cff2c28b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -841,6 +841,8 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>   	int i;
>   	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
>   
> +	flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
> +
>   	pages_per_xcc = total_pages;
>   	do_div(pages_per_xcc, num_xcc);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..4dd15767a722 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -101,6 +101,7 @@ struct amdgpu_bo_vm;
>   	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
>   
>   #define AMDGPU_MTYPE_NC 0
> +#define AMDGPU_MTYPE_RW 1

This is probably not the right place to define this. MTYPE_RW is not 
universally available on all our GPUs. Not even on all GFX9 GPUs. This 
MTYPE definition needs to be in an ASIC-specific header file, and 
probably already exists somewhere.

Also, we can't use MTYPE_RW on GPUs that don't support it. I believe it 
was added in MI300.

Regards,
   Felix


>   #define AMDGPU_MTYPE_CC 2
>   
>   #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
