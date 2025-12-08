Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72446D3B7DD
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 08:34:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF8A10E3D3;
	Mon,  8 Dec 2025 08:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T4JdICkV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD4310E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 08:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFgeWad6/MMZ4gWx6z8IP+iLQbk7Y7P4uTaohfxP9kzk6UkDY2udCipBtED4EhJpdM5iCstvportjwNgltyBB0XuGOO7VP8d7R1y4vywUxSzjTb+897KO1QAjxNYsVx8/KSKmZjGcX41w2Kjs7PGtNb4siZ9k2HEbI1+54MrslaeQxMkhhKMcBa+kjyItAQrLk2rdXg1vRkNhDoT9SDlpVQX2jIVEfSWlqEVkuhjgInDGDqqst7sLeE7mOyXdj9w1TR8mT0aPL0Nhap9D065Fmr4L8A5CVPKfhnbUfoVJ9MhTHyv7w1rvszZUdCJYrLHnyxk9mYNhi8fhAUlKmzVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7p1m06hscyg8MVzuadRKGx9FM8jbjARRAAQccOUYK4=;
 b=KS6iBQh9FweoxTMG72yXF88JdPLIxKpPyvaUGfQXlUg/sgeVuHsVutDyAOpHXAco/0UdJ68TDFb9mdAsKi9RY8PwIvxQuSa4rt+pT74kdW7Jrwf+VnAA8Wtc8s5vfdJoDrShbWMVyf2uuQftmX1uAeH7Gxbz7C7bT57xOIlKtXVlEs2HJyI1eBs0i8AsNZxQANDhT7u9yjZyiHNFII5r9+xdMpmh4nqz4Dcpq0hvd6ZTkXG+YGBU2lHYHMS9vFBartp/gSBts0lTIo78NNe4gup+pSSWNW0wVGDjoGuKLrW7/i/M5XzwX/z+7/baoiHOZrGuJFjibFxwby0eWAUg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7p1m06hscyg8MVzuadRKGx9FM8jbjARRAAQccOUYK4=;
 b=T4JdICkVjy4yL20wQ+zkFAUXdXCd4+Re18zYtDY4/0pIVqPAoIjpuBzT2bS5t5iv+aoZw4K6P1LjtErxj5rUMtK99Z/vPcYXkCwqyCTa8gUb4hl3ZK02FC0o+J1chbFhUxca0X4H9+pTqMdQbSTv2Ztl/KYIo4QX14FGhLwS/kk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 08:34:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 08:34:06 +0000
Message-ID: <f67ed498-717d-46fe-82e3-82c7dbd6dda2@amd.com>
Date: Mon, 8 Dec 2025 09:34:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/amdgpu: Fix gfx9 update PTE mtype flag
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
 <20251205214922.1095629-2-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251205214922.1095629-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: d5088bd4-3727-469b-6b6f-08de36348c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1dsbHorRjJxU3N0ZkVkUmdOWWpCdDEraDFnN1Q5VFk4SThPa3lvbHhKdGU3?=
 =?utf-8?B?QVk2c2hNUlhTK2oyYW1xN0wrY2VXLzk4UUM3dDJEODBsRk9xcm56UEZGQ0tr?=
 =?utf-8?B?V1JWeG9PYll3T29nbW5aNVhHeDM4dktxTUhxZmFvS1Z6dmI1VXFiVWRSMmVk?=
 =?utf-8?B?WVQxb3o4WUhvSDhXK0tjbUEzb3ZacGt3NkpqOW15Yy9qZG5SRmFmNjUxU1hM?=
 =?utf-8?B?ano1azJteFRvcVRaWmRFZHdkVUxSRnZ2RThMMkZidW5zaHQwSm03QUhFVHRR?=
 =?utf-8?B?cmlOVXZKTXVIclR5ZW9Vc3FRWXdETGlueGdRQmx4bDFUNmFqTHRmZFVPeXVt?=
 =?utf-8?B?T0VScWtUanZWd2JMNW1vbU91WGVxeXdOVXN0RFNUWVRsc1dvOHlYUWdUcTZH?=
 =?utf-8?B?N1czSTNlSEs5YXVxbitabmRWSTZvNTdtbEQ4bmVFdmZRd0Q3SWpwbHAyVWc0?=
 =?utf-8?B?RUdPL3ZrM2dUUjhUU1dVMFBiNWhqOUFFNnI2N2JRcjlMZHdKQVRWcG43Y2pW?=
 =?utf-8?B?UG1aWkZYTFNPdlFwbkJNdHBQMFN4dXNrcUREUnV5ZXUxemhEZUNKSlBkSVhX?=
 =?utf-8?B?N21nYW1ML2ZmdEZ6ZXZLT2w3UW9XV0ZobldQd1Fta3BmUjRBeW00blZLZ2NN?=
 =?utf-8?B?ZHliQ0FKemx2NEpmSy9rakpCWUFiUHpieEoveTlObHNlZXJJWXd4c0M2S2dH?=
 =?utf-8?B?b2IwZXdqZmM4U1VJMTJ5aERDQlhJUWVVbmMxY1RaSVBwM1M1WnVOa24xYitm?=
 =?utf-8?B?Mk9XdDZ1ZHF0MFg4Q3MvTjAvUmt1RGNKRVRGVjVqL0ZuWEZqSGIxSG9CcHRq?=
 =?utf-8?B?L3FWTzVoRWc0NlR4dGhyNzFmY3RxdGNxOXFVc3JiMWdyK2NBSVNvZVY1S0pB?=
 =?utf-8?B?emluUm9tWlYwSUViejMzdnBCZno1MytzcU9yb0E2Y3R2b0ptaVVDOEhpenh6?=
 =?utf-8?B?cDVoN2pPSVZYYXBWWGFQK0dJVEl2d1UxVHJ3akdpMGcwM0oyRkx1MjdxVDg5?=
 =?utf-8?B?MUYrVUZuNWZlSTA0MXFrbG5zV29OcHUyV2c0bzVORHdKUEtwNW5hVHNoTHR4?=
 =?utf-8?B?VlMvcXZ2UkJUdFY4c2o5bjdEbUJ6R0R3aHlYeExWRXcwTjkwNEpVdG9KUkVo?=
 =?utf-8?B?QjF5cGp3cXA0ajJ4OHQ5R1BnVVlsSFlIdDMvN3ppdTI5c3RsWXNmRGxqQTFJ?=
 =?utf-8?B?UmNkWkZ5M1MzMjdxVlhnUHlrTzNZUDBMUW5mTkgrWHVWV2R6ZXVCdXExaUNw?=
 =?utf-8?B?bGNBNnN0TXRxb01PcWZiTy80QjlYdFBwME4yOSthSm1JU3NuejduK0RiSkFV?=
 =?utf-8?B?U29SUmdMVmJMWkN2YXozNnFzb2xJY1AvMTBLeWxtNzR2TWk5UUNEK1kyNHcx?=
 =?utf-8?B?TDZCSituNVdlaVVFeEJ2T2dZaDM0UDVhMzNWNGxOVjlGRllqMWg4KzkrcVJE?=
 =?utf-8?B?STZoUS9CWGtlTDNISWVkNno2eVh3U2lvYjNERC9QeWpBaEZJS0FiUGRWdVFu?=
 =?utf-8?B?ZUtBVHV4VnQvL2t3c0hwQTAxOEpQZ0tZZmxHdy9CaEYxZnNiWmptQWFIWkhP?=
 =?utf-8?B?L1QxUTFsMWlxN0FMd0loeWZLNEZRSUVyaFpzWGZpTnVlSWJPNnZQYmtXeGV6?=
 =?utf-8?B?QlQ1aXNYeWdHa0ZuR2VhaGVZOVRNQXg5N1ZNWS84VG5aRW96d2M3eDk4ek9Y?=
 =?utf-8?B?RFl1bm5Sb3ZQbTBEbzhJcURZYTYxZHJJS3FVSnVHdVJCNk9sU0YxdERIOVQ1?=
 =?utf-8?B?amY3NzBKMkYzWjVISUNxSHVVcWdYODcrQUhTTVNUelg4aHJUKzBmY3l6eTds?=
 =?utf-8?B?bTBvY1JJVkZlZ25lVGZPenEvb1c1T3B6WW9vZmdycUpENXJ1aEVDdkR6NHZI?=
 =?utf-8?B?QWNVS252dlhmRFVHdWx3U1l3bXFOdUFwTXJrRytOVXB5dkh5ZUxrUjdvWjRi?=
 =?utf-8?Q?U9cJeV1KdPzI/EFptNefO9BugP30K0QB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wi93V3JCSThzbHN3aVAwTms1U2JFTXlyS2FOeTRkc0lMTEVwdmxWSVllRk5l?=
 =?utf-8?B?TktZU2pxTDZPcC9idmxrc05CdDhLcXBzVjJIR0k2UTZxeitpYjlFWWc3VlU0?=
 =?utf-8?B?amFiZjNNbitwazY0OWZSWDh2bWxoREJucHhDbGU5cVp6VVJXWU1HTmhqWHhu?=
 =?utf-8?B?UzVjKzNOVkx0K0FHU2JGUjJCdDdsTEc5RVdVV0xiUS9Zc2JwWmI1bVZYNzZ4?=
 =?utf-8?B?YzNYMlJvNTExbWFZckZMZVVUK0FZMW9oRUpmMDV1bFpHekpmNVNqS2x3VTl6?=
 =?utf-8?B?elp3ZHJoT3EyU0JFK0UxSVRPdmV0N292SUxqdm5VNkdOa3doUzg5aTJWWGEy?=
 =?utf-8?B?dnd4U0NESjZTcjJkaEhDVFVoS1NlMHhRcUdMWVArRlhTaTlXS0g4bzVCS3Fi?=
 =?utf-8?B?MDV0ZlM3MzdMSTVMY0RadFVVb09EWDRpc1ZkV2NGdS9aWUIwY21XMjZPc0Ni?=
 =?utf-8?B?SmplY3Z3dmpvai9TczFXcUwwdXFRNkp3dUZXbHZ1N2ZMcWFVVExFY3BEY1NG?=
 =?utf-8?B?RjNlYnluNUN2ZG1ubkxYaElDbXVHYkZWSXNRenJDYkl3a0tjM3E5OFFiZ29k?=
 =?utf-8?B?a0FoMkRpRnlqUUdOdDNCVTVxb1lUV01ueGpYSEorYWZycVR2TVVwNmNvQWJu?=
 =?utf-8?B?WXZuVEZyc1hjUmNVa0g3a2RrZU4yTk00cEk1VFIraGVNemtxTXUxOWxBRTI3?=
 =?utf-8?B?cTR3NTFYVldyY0xzbCswRFlUV3VVYlB5YWppYjJkelFtenpmanJtQTFUZ3dZ?=
 =?utf-8?B?THd1d1Q5U2dxT3czSThpWGVpaWtPcW9ZcExyVXQrNWNjUXVMOWZPUitxV0x0?=
 =?utf-8?B?YUV2aEd4OWtOallVbE1mc1FJTnFHaVFlcmlzNDBrRzFkRVlMSTkvV2o5Z3hs?=
 =?utf-8?B?elc0NXZQQndSM21PM3BsVlo1S0NJL1l5UzRXQ3E2L21kc1JkRWhPdG9XZGZ1?=
 =?utf-8?B?OUc4cWlURmpwK21HRWlUQVZrWFp4SDVkOWcwdWQrMGZ1RzBHQWZlK2JWdG9G?=
 =?utf-8?B?dUZGVGIwSWV0b0dibnUwOTNXdkF6VUpycmdWamJUeTNmSHB3YlNQaVZSNTl6?=
 =?utf-8?B?Q1hpdjgrR010U0FoTkc2UVJHL0dyS0dlOEc1clpnNHdQZW1PbkN3NEs0d2dK?=
 =?utf-8?B?MVlIaVJRQ0FBczhVd1hqQnduQWpNZytYUm5NL0xVRUNwamZRN1VBakI1WHNq?=
 =?utf-8?B?Vm0wWmtZU1c0QUJCMkJBeTdJMUg4ek5jVDVhSkI1QjVwTkJSbGR3Z1MyUGs2?=
 =?utf-8?B?MlVHUkhZNVN3enVHWnNnOS9wWnFYOEgwRlZxRXVSQ2VCREYrbUpveEV5RlMr?=
 =?utf-8?B?OUVZM3Z0RndzVHlqSDFQWHUxMVZEcThQdHd6dDR1Qk10UVZSeklNRGMvejdi?=
 =?utf-8?B?dkVudi8zeGNVY05BOEE3UWY3WDJGVXpQN1NjamNSbHJobDVjMDZQcEc1MVBv?=
 =?utf-8?B?Y3dJYmNLMVdRMncvSTZNcFdkbFF4RENQVVZvOGRXWENpVjkyQ0NPR2pYVkxQ?=
 =?utf-8?B?blQxdFVpaCtMWWhmQVFENXRYK0FnSFFuVFlmc2FiempIa1JkUWlqN0RwWjFF?=
 =?utf-8?B?WHVuNmpBa2hPYXlsWDRsU3FmeTNwczkveDUvRisvSkIxYkkyY2hlYXlVWlhN?=
 =?utf-8?B?dVd4QVhCaHVCNmlmbFQ4SFc3eHB4QmZBYlFtbDdnRmsrT2NXcHZkK2VXb2pr?=
 =?utf-8?B?VkVvWU9vWXBrbTlSbDlld0hYRE1qKzVkeXJNUHhtZWNmdUpCYnNlOWthQ2tX?=
 =?utf-8?B?V2t0RmtaejdpcmkydXRGdGdxWmtvRDFkWHA4Q1ZIamt3NXlqWXlzYzV5Y1Bk?=
 =?utf-8?B?ZkhvMTdYNlhEUVg0ZUF4ZkVjOWVZQ0ZLRWdySUtQNWRJOXpweWk2UXQralBj?=
 =?utf-8?B?c2xCYWluQXNpUjBVOVFwdHQxbEYvS01QaXRta0p0cENCTUkwMnh3Nit2b1VL?=
 =?utf-8?B?MDRFMVByNE81em1ZdmJQVnFXK0RUeGNYdTZsZERuM0haWlpSL2M4L2ZsUTJU?=
 =?utf-8?B?ZkJwZlQ3M0VNYU9ZZCt6OHBicS8zN2dKQlVQRTE0K2RxZnJXbkptOEFlRW9u?=
 =?utf-8?B?UjdxMkRSWFBKNDZYcTFnNDh4WXk4RThXQlFlbFJLRm13eHp5dWE1VURUYlF3?=
 =?utf-8?Q?33mzfjxuFYWY/mw9nD3BDfT3F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5088bd4-3727-469b-6b6f-08de36348c92
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 08:34:06.4312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tywDkzEq6bI2TQWu3VEspCQIw8wQOXwKORQQiDYw3sW5TpLco/sYRwjNLeaE2UI/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

On 12/5/25 22:49, Philip Yang wrote:
> With this bug MTYPE_UC 0x3 can not update to MTYPE_RW 0x1.
> 
> Set AMDGPU_PTE_EXECUTABLE flag if mapping flag set, but should not
> clear it if mapping flag is not set, to only update mtype.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 97a04e3171f2..d2e8b96c0372 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1194,8 +1194,6 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  {
>  	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
>  		*flags |= AMDGPU_PTE_EXECUTABLE;
> -	else
> -		*flags &= ~AMDGPU_PTE_EXECUTABLE;

That change looks questionable, we said that we always wanted to override the passed in flags.

Why is that necessary?

>  
>  	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
>  	case AMDGPU_VM_MTYPE_DEFAULT:
> @@ -1204,16 +1202,16 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>  		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_NC);
>  		break;
>  	case AMDGPU_VM_MTYPE_WC:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_WC);
>  		break;
>  	case AMDGPU_VM_MTYPE_RW:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_RW);
>  		break;
>  	case AMDGPU_VM_MTYPE_CC:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_CC);
>  		break;
>  	case AMDGPU_VM_MTYPE_UC:
> -		*flags |= AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
> +		*flags = AMDGPU_PTE_MTYPE_VG10(*flags, MTYPE_UC);
>  		break;
>  	}

That is a really good catch and should probably get a CC stable as well.

Regards,
Christian.

