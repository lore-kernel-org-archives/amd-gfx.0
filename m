Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46537C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 15:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C459D10E1E9;
	Wed, 15 Jul 2026 15:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rITVU71G";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B0010E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTRiuipCl901RnqpXcO35tEOXdP9GAUkgyYJ2b2P65HnfC0HpMLp9IpMsfNozShjjrulsEhz7FY2u+XfvhE1joMF5mmvtmmY0G8S78m+ffeBBvETZX9prYqj0e9uYjtGbujKvVkMTigOMDgWkCb4E+k083JppPn133W9bOYuZCelL+KOh2PV1PEhEbdyfgdrWDeLfMIhJKQjare4xYmoda6bCIAnkuxvCzjrj2wmRWLOGHy1s1LHhI8DkYXcICiC6989FvS+A9NDkdlmH1mlRtzEJXXkKenqP8kFAK47KbyYv3JHzat/WASrINSe/8nLdO5lF/rSg9+q8TIyUyIbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/N1vudw5DOyK7lYUjMCpvneIWlRvfS8iuYTyymIiPY=;
 b=sKql5bWOH46r8Ps+wjYsF43Mi9/fuBqobdSOXOpbKDcHjA7mXlQwpfglw1q7SCHK3TquxIflJfaAUFTrygpUYdPwt/ujCVvu8YtBKMGDwUUwzk9mML26zIKal2uLBmI+dZm3PODS3xD+xpDuwCtdcxN+7OaoH069Z3ccHMRu9Uzefgvle6u0KAXFI9h/Bh/KQ4mH2rrEKGxOF/ZAr7N+MXVzgRgYVr4ghDcpTaJ9eHV9YQPvaJPzCEKCz4lxK7V4C3WOnua4GnjHoboC0594SU43N7o2zn7r6Yy1XFk8EAlX9kQ+ecdORjaGZpSzEcJBydZFUFhKKqqzBCi7k9sLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/N1vudw5DOyK7lYUjMCpvneIWlRvfS8iuYTyymIiPY=;
 b=rITVU71GSxk/3xWg2oh/khU2JrVVNyC55MtQZV75KxiZYfYdpl4fznoMTVwIsEpmWGakRGtVrl6YWIzcr5f4ZovTYpw3GS+GYJVAPRRolzn6WgQh4btlGne6MbnEEnVIOKrja7J2bFvgY3R8OLfTYa9DpyKu4jJLsd0Ddeoj/ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by SA0PR12MB7461.namprd12.prod.outlook.com
 (2603:10b6:806:24b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 15:34:37 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 15:34:36 +0000
Message-ID: <95a4c91c-5d2e-48cb-82b3-203050d4c8ec@amd.com>
Date: Wed, 15 Jul 2026 11:34:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip clearing empty freed VM list on GEM close
To: Bob Zhou <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20260715074523.988105-1-bobzhou2@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260715074523.988105-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e65d58-28bf-479e-d902-08dee28693aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ac16+DqsOSFtyCQCqyHUENrCR7i89uDYhBf8B97v6axz3y4HvbrzZZ/eDw8LFY4uUJrGqRLVMOJKQ25ExCVnbzWCCehULsJvoFOvC8+Z0KYgLBQdu67U9YaQ6lbm4GXZNRb9KlL7TYpNcPQN/g2zIoef778hmkAYIWMxCwBA6xsLVdZb/aUB2y1k4NLvx7ykpv/P5YrLxF6yfSE0q7h4XH+JjZ3wdexZAJ7wdCmi7YO7tJ/C2e+05tYVf1zKMDTljyeVxbvYe+v5bzAm3g4I32fMNw+GTnlE8qJeWg6DXAYaLKJDMsx98NPVu691OhNC7Zf00RpJ+OGCT2+io+k/E+T0/NhHP3/FEldV3A4Rh7FUVQ8Lqs+9QkAnlxNHEbdtA4uNQd1FPxpWZyFPDeGWthirZ1vEWRozr8G4cLalhHMDvVHDO5C8/bCCAGJmNPMjJOJzS1ue6bgXgQejjbFCK/wOWKMcqSlprZlobctuAfQPaRnbl+ynKEcB4knGZtnvvRWsSjcVSjJTIr+Sj9l18rV21RLca7FyZksX/H4H2FQEbxub1LJ9aQ+380pzQvo3uLtBsHopCHcNMfbaAek4vi7u2OH3Np0jDJOK1/781eVBKJtDka2bV5NKPCbkICl08aNnA0eWrnR6YRuP2D+aKOuadSQf2uzVS3OiDadGxAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDUrMDYxVXdjZFNzR0dCaFNONWppTHpodkdvVkhpd0JsbE45dml1a3FvcWto?=
 =?utf-8?B?cU5xU0l2SkZhOXp4aGw4aVAzWUtwWm4zVlVhRmRjYnNCKzEzRHpHZFVRSFdZ?=
 =?utf-8?B?a3hjMHJUQ25obXJ6U1FlT09Cb0JPSTk0UFY1dVNpcFZxTXpDd25pN3B6dW9I?=
 =?utf-8?B?NlhQUjIxMjUvQXh6SFZrVGFENGdRUTZSbENZVDZJYnMxaXkxOUVVWWFqRXhG?=
 =?utf-8?B?OC9JRTlxaWR6cnA2RGxaYkI0WGVHSmZ0WXpNdU5BaFV3OVFwaHVnY0VuVVgr?=
 =?utf-8?B?UmtqK2RkK3FLN1dSVzNvNGY5ZDFYWU9VN1R0UzAvWFRGejRlTUdWYjBmaUdC?=
 =?utf-8?B?WEExNmFHTnZ1Q0xFaEt0Y1dKV2o0WkZGcTBJM3h3Ujd2K2E1Z1RoaTdYQ0Mz?=
 =?utf-8?B?Mm5vMDJtOXcyRmZtRWFjRFBUUmpLQlF4T29PalozRjVIQk9CM3BIME5SbVdT?=
 =?utf-8?B?ZlRzNEMydG5teDJmaXFvYkFjS0hKRjNMa3dYSmdlY0J4YVV6YWlyRzJ3ZktR?=
 =?utf-8?B?NU0vSmNrUWMxT2tMVFpjaks4TzhNLzU5d1ZTOGtleVZ6VkFsSG1FbXpPMHJ1?=
 =?utf-8?B?MGJoM3N6RDQvcHZnUWhVemNUSXB6TEhOUWRuZmRhRFNNSEVkZ0UybWJTOC9z?=
 =?utf-8?B?WFoyUC92a1BwRnp5QzJCRC9oN2piWGtFZ1d0akRwVHowU0RZKzJVNzJCNXJn?=
 =?utf-8?B?M2svOWVFZmJNWGpvOUZyYWl2UEFHOUI3YytWZFZQb0wyYmQ5bDhjcWxVS3BW?=
 =?utf-8?B?U3lVY2ZoRnIzMFY1WlRQNjFzZTFMRVROcUg0QnRBZnNvd3FqeUxnZzQ2SkdB?=
 =?utf-8?B?ekVGZWxLdG90S0RmVDZORkF5b3BNaEV0QnVEc1ZMaWxpd2I5VjJmcXpTbjB1?=
 =?utf-8?B?UUVqV2xweVArZnNibnV3QksrWk9sOFB0RnZZWHpyelBjdmwyRjhFbndLYUJZ?=
 =?utf-8?B?OHZqVmVBajFKWCtnY0d3MjVZR0Fxcktra2dGQ3lhL0pJaDZmZHdCNFYyS0ds?=
 =?utf-8?B?c0VxbC9WSmN0MVN4L2FzU1B5UG1NQmJQRzlmUmxGS1VLaS92Y01RM25xL2Uy?=
 =?utf-8?B?QklUR2hvSTYzdjBwTnZMdjJYUzdNQjZhRmdNOVlWeHRuQWpES2lYWjR4VDlJ?=
 =?utf-8?B?V1BIeVlhbGNhQUxsNW5MVVJ2SVp5Qk1NcTZzdGNacTgwTm82bTN4bWpQeFF3?=
 =?utf-8?B?cWpQUTVHcDdUeTl0bUcxdzJPK0VBMXowb09QYnNyQmZNKzk3WnF5ZS9EcUhj?=
 =?utf-8?B?VHJGcjFpSm9EUXFJMVBDZjRLbGRZalVTWTlvK09KOUc2OXJUbmJOZlFGM2hN?=
 =?utf-8?B?UGFvODMzWWZkQWxrK3hMZVRQc1duc2cxbmMvb2lTYjFyN3ZoUXEzWVBVRVJ4?=
 =?utf-8?B?NWY1VUpCRURRSnYxSU1ZQW4xZ2V6TXE3YkR6Q0RqVXFEYjRIbWZ6cVlhZHJP?=
 =?utf-8?B?NVFhaE4veGlXbHFqck1yb2hRMVZSZFNEU3piUDQzTXpPR0k1S2NHVTZJNW9k?=
 =?utf-8?B?Zi9IVjhjUFRXWWVpVkxhZWNrRWlvWXNWeC9EQVRtd3RZUWhOcHdoa2gxZVFT?=
 =?utf-8?B?RzZNOVkvaUV4NUc5Nnh6Ujdzbkp1Q1BrNjhMZmI0WE5kWTZXYm9OeG1RUlMr?=
 =?utf-8?B?WTY0QjRtcHpSNUswNGR4VWdMb0lncXcyMDZtOTRxOHkyYWdKTjEwYjlQMVdE?=
 =?utf-8?B?OXR3eEhqNnovdFYyeWRJcTEyTFMvS2NvM21TZ0FWTXc4MEg4dXZzYnVOZjBH?=
 =?utf-8?B?QkloaHFyS0ZLNlpLM1BCOEU4UDdRbkVYRUkxMDdXaW9UVExHd29SSEx0eVJZ?=
 =?utf-8?B?ZTVIT3BxYm4zRXJpNTNvbUZPNmJuSnJNZzFvc3hkdVdpeDQ0dWNQd1Fhc0ZJ?=
 =?utf-8?B?VDhRbm9JWnVKUnluNTUxWGVlWHpOT3FmNU9jbnZydllBU0xydjEzUUtEQll3?=
 =?utf-8?B?Vy9GRS9xajV3S2lheHN4RVhhSDZoMDBEbG9aeGd1dHRjWmtHUXNwbGc4VHhO?=
 =?utf-8?B?Uy9aVmhsT1FtYXdvNTc3dnViZnRIZXZFTytIL3N6RllKVTRhS2lwVXVCKzNi?=
 =?utf-8?B?S1Y3Qzd1VjlmL2ZRdHdPOU9mZjI2OVJwSUgwbU0xU2w2U2ZFTklQSUN5OS82?=
 =?utf-8?B?NU9sbU5RZUg5OWNNdTI1RkQ5ZmFtZFdFYkQwM25QbFFLSWoyMVBPWTJUM01t?=
 =?utf-8?B?WU16YVZnbENuWlJpSmR5VExjNkRrakg2cVMvZWRsaFZuRmVKazF4bTByWVlh?=
 =?utf-8?B?OFhHT29MQ013bk5PSFV6WmkvNG10VVR4ZXVsRHRleXZqL3VaSTd6OERGbjZx?=
 =?utf-8?B?VklvL3lLZVdUZlliS2NIUHo0eTdqTFF5NFFxUXdXcUFrK3N3R1RsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e65d58-28bf-479e-d902-08dee28693aa
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 15:34:36.8102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT7MR6sA/sufpTvFwzI7L/16eBSCtyZ6xoDWBKRLzFEcDh4mjkp5h5JbYhumjk0MAqkJD9JaB8I46ptc6tB6zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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


On 2026-07-15 03:45, Bob Zhou wrote:
> amdgpu_gem_object_close() calls amdgpu_vm_clear_freed() after deleting a BO VA. If vm->freed is empty, that call is a no-op but still allocates sync state and walks reservation fences before returning.
>
> Check vm->freed first to avoid the overhead on the GEM close hot path. This does not change behavior because the empty-list path leaves the fence unset and returns success.

I think you could get the same effect if you put the check at the start 
of amdgpu_vm_clear_freed. The function would just return with "fence" 
unchanged, or NULL in this case. Then this optimization would also apply 
to any other situations where amgpu_vm_clear_freed gets called without 
anything to do. The other advantage is that the callers of 
amdgpu_vm_clear_freed don't need to make assumption about how it works, 
or know anything about internal state of struct amdgpu_vm.

Regards,
   Felix


>
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6a0699746fbcd..72811f6963a15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -348,6 +348,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>          amdgpu_vm_bo_update_shared(bo);
>          if (!amdgpu_vm_ready(vm))
>                  goto out_unlock;
> +       if (list_empty(&vm->freed))
> +               goto out_unlock;
>
>          r = amdgpu_vm_clear_freed(adev, vm, &fence);
>          if (unlikely(r < 0) && !drm_dev_is_unplugged(adev_to_drm(adev)))
> --
> 2.34.1
>
