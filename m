Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A79C4167B
	for <amd-gfx@archiver.kernel.org>; Sat,  9 Dec 2023 14:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF5E10E18A;
	Sat,  9 Dec 2023 14:47:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D9A10E18A
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 Dec 2023 14:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbZzn/HEzlBMmUmyLDLjWZSpZMuLWp46w0pRyeUdGk1faCUBjbSxEl939gFcrSmTxp18yW9nWnqllFuoFDCcHzQlzw5WqYnYpxjzFGyhNWCW4AVQQjUiTPEOrbkLruvNSu+Z6Mv6ouVlmAbiCSdhsB5YZRHIjvkNhAOdjI26X+BI+Ij9rNEiC6c0ujp7Il3hJT0l6PZrsWGqX7Ryl6yUg8dlR9VyReS6Kjt8TSTsfABIw/jPgeEiZfPJRpXiHc5JLuaArc1xtM2LcK0KrVqTtYeQcb/hlKISCmSwscfF/+9XKS3e6GmRFPNZrbx4SCpoqH0iz+bDihvrIJDP8gcOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/WsdhENMJleByUmWIyRTgHNNlZNEwmclu6JKKk46oM=;
 b=YiLTm8BmWtF+KhLkYtBXPJKuPeFC4Q/7UZAKiAKzQ2mWb0SOYc777HtuY5wISGedmLnc6ippzeOpypl4KU8mKgmhnS0UmgjoEoCYNDVEt5FDA/nGIOo6WkypbK+DoMX/gCvMW/BS/yPiT4yBFz3ZiHqFqgYI5XZTpclvt8deZR5Y7HsfEqR2H5WTs1i9ZtAlQ8zLbO+0+eieTDLMESmxCVvqn0jxzhFmwji6oOB8fc1SsdGD46DLAsblMLaH3TZLB9bnaW3V3WujEBuxvHpljfG0kUyO8P1z0pjj2ftyuUPsKpFXK04+GAiIcVtcUNrrbEO5w67w+VFKg+/FQAF0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/WsdhENMJleByUmWIyRTgHNNlZNEwmclu6JKKk46oM=;
 b=Zj83w+pYffwTvbk60Agf3xcLIwLrZbjhothMdi3PXW5B1FGpDAH2cwYOAOLZv4nWIiNH6YOgD4qpZqgj1dULuPBwJHfKceL71wyqfqHI3nzb88NFEhI3GWbQT7w//EE2M4qvEQj/WIfH8KQavPfu63gWwzJVotIZNEOCFKqwMC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 14:47:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.030; Sat, 9 Dec 2023
 14:47:25 +0000
Message-ID: <336ab1dd-c32c-4197-a334-6d25c94e0911@amd.com>
Date: Sat, 9 Dec 2023 08:47:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu/sdma5.2: add begin/end_use ring callbacks
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208225328.25651-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231208225328.25651-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a62cd4e-7d0f-4c92-cd2c-08dbf8c5c216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pElEE6xM0qoCfXfDBeteqfXhn0amuDySufmgeRSSgHNafZ1e3uG2roCOy3CSnEsFAARewHELgcQXeKHI3ABn8Cbw3T1vfq5atydlup/fys0c4pWjGMfGibKcwKrHQ348tQqAeM77YjChH0iWc2oSmoilR7Ly45eBd0AjAI0UGQE9VPfxWCjhRxlaY3KWyPYn9hFvkU0DDJuFS2+SiCkrF1wLhWYnnb0yB2ZWhrN1CDObjnYtpxgmtAn7m2lZEnWZ+Q3uq3HiDhBe1Ql+04p0UMeeyDtH+e9uY+Xmz8IS9gjhLuvA7DasHSt7Me/1EOG4sPxMymx4JVEPWhhp6NmZNMKo+RCN/IJmqhRJX/rNAUpyVH1oGBnFrqvpe/gBVJR7VG4m0YbSLiLR6JjZi8b2uaBZuQwscxAXcm0chJGZAKwwxVW3JE7BQBlpc69qCvpsqRUnhCDI6NvQp9hdrjnU9DSo5TFTaMitYJHkyIG29nZFTWUVyy5er1XwGmICUjx44aHxVbCaZztXCzyplhPrD8w28ZOF2CZIW5hgV4vPj66smZjWuJKT59SHnf+CSsGYuSzh0xUjVwdk9q+FDUnhMKppCKxq/v3KhZYjxIpAVmkVH1kYrWIwrF68KiQHiftJbsh/dc9t5hC+wNSs5obb8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(86362001)(36756003)(2906002)(6506007)(53546011)(5660300002)(6486002)(478600001)(83380400001)(6512007)(26005)(966005)(2616005)(316002)(66556008)(66946007)(66476007)(8936002)(8676002)(44832011)(31686004)(41300700001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlObXVQNW9OaExVRXJ2Ym1wdTVwOUV3aHd3dmJ5Njc0dVdweExURExFVzhk?=
 =?utf-8?B?bmN4R2VZNjF3QisreW1GY2tJTTM0dk8vWnhSZXgwcCtKa2I2djlDc0VrY2h0?=
 =?utf-8?B?dXpzRTNOMFZYRGppaVNzN0IrMnlQbDltcU9wVDFmQ25jTk4remtDKzNkNTYz?=
 =?utf-8?B?UVlUM1hlNmUzbU1oQy9UWU0wb2djdzlEWVh0Tm1xczArWTZhVGhqOE5PQVZN?=
 =?utf-8?B?bCtadkZtVzJic2xwZWpZU0crT1lMZEoyOVpiQlRhejRuTzFPcmNhTm5DRENI?=
 =?utf-8?B?cVpkdkNVRk5iZ1k0Z3AzSDdnMTVSMFUxOXFqUXphOU9vVTVxZ0FNTGc5ZlJM?=
 =?utf-8?B?ZWhJR1NiVkU2ZXpQbjJyRUpFSE1MMGVCQit4ZTMzMVdLelFIZThCN3g2RmpO?=
 =?utf-8?B?R3IxMXBxVExNbSt2OGduai9PVGJMKzZaSTQrWlpkMnh4N3ljYmJLZXI2WHZM?=
 =?utf-8?B?eFV1WElRYlNmLzcyYTQ5SHNNSXZnc2NrMXVxMnZ5TnRKQUxENnViRFhKTFRC?=
 =?utf-8?B?SXF4Tysvamt6bzJ5aWNpQk9IN0RqbnpISzJ2cXdsdWpNaWMvaG4xZ1RYdHpm?=
 =?utf-8?B?OVhoalhWejN1MXM4ODQ2R2RsOVYwOHhPdU8vRWJIeVhRd05naW9MWEQ1aDdP?=
 =?utf-8?B?MlVUd0xQTTZhOUhsSkQzRHZCQjVia0lUZGlyVjhvc2d0VFcwMit1M3dDNmJO?=
 =?utf-8?B?UUlaRGt2R0xUeXJPcFJXbVJiOFBab3F4MitQRERET3hmaXAwdWFaUFhDOWpW?=
 =?utf-8?B?YmVBdHhKVWs2YVRFU0g3TUF3eFhhZGUvZE5hVktKVUk0dHNlTEc3eHBJa08z?=
 =?utf-8?B?dTI4aWN4dGc0blVKem1pVnBnQXlvZWg2UXNhODZhcjE3MGtPbkNSeWViaXdy?=
 =?utf-8?B?eDhvalMyU1B4VDF2WHhRUWhLbTVzT2IrWGlqbXkvRXp6RisxdmhYRVJkQmQx?=
 =?utf-8?B?S0MzNHRFWlM4b2JkWnlxekxyZFAvWGVhVFVmR1dOSFUyY0dmZGErbllHSnVP?=
 =?utf-8?B?dFh0dEpKaVBMSnZqd2FFYWRkNlFRTExWOU1oVEY2cmo2dFlmSDM5S1VNNHEr?=
 =?utf-8?B?eGJsUUZnM2U0Ukw5S2Z4OUxJcysxeWprUEd2SFJGbGFWbTRKV2VYajJndFdE?=
 =?utf-8?B?aVVXV0lQNktKRytvRmlzRXFCdVNLOUJaZGFXV3FmVkl6SXVnRlQ1UjZDUGdO?=
 =?utf-8?B?RUFlNUU5ZVVXZWw3a0RKUGk3WjhEVmdzRzJ6TFh0T3R1dTNWWFNueXdGb2lY?=
 =?utf-8?B?QzZPMVVFMzlrUUJGSC9jUXRQMjNqNWtaRVFyT01ORm0yQ3o4V0tsdTRidzdC?=
 =?utf-8?B?cENjcHNyZXlqbDhONHc4TkpZL3Z0QWd0WVVHV0UzZjdKV1BZL0ZOYmFNTjlF?=
 =?utf-8?B?eHVQUlJCWitMNVB2Y1NSQXdsdjRBNUQvdnptYUNITjFSU3c0dUtNSEN4emZS?=
 =?utf-8?B?VGpFMm0zVFBDZ1IycmZmdmZIVFZNa2Vzd2RvQlRHVkZrWHQvY1A4bnNNTFZj?=
 =?utf-8?B?aDQ2R0pKQlBLVzhaK0Z2emcyNXQ3NTgvcms1ZEYxWnN5NFcxdkJCK2dMelMv?=
 =?utf-8?B?RHYyZmU1UEpXV3o2Qm9SdTlkL1FXMmNnekRGdndRL3JjUUZTbzlpR0RHK3BG?=
 =?utf-8?B?bUo3cSttT0cyTlp5VHJMajZXTVA2VGNwYkVHZmhrdGVYbnFnVHppbGdUNjBO?=
 =?utf-8?B?cUN6ZzlUcjN6dFlDZ1UvUWgva1JNcnY0WHlDV2hiL2lqZlF2SXNoczFUVWtW?=
 =?utf-8?B?T2VOSjdpeU8zMThTeTJvd1N0eUltb2xWOGhRK01sVDhkRThrY1FhVVdhNU92?=
 =?utf-8?B?akx3ZmUycFpVUm4xc014b0ZBaGx5Tm9yZnJaR2Q4aUVoNmpBQWxXeFhpU01L?=
 =?utf-8?B?U2RTWUg3NjI5RnRJazV0SmljYldONU4velhNT0Z0ckFtSEZ3OWhwSWt4QlhK?=
 =?utf-8?B?cHZqeWdjNUFkNitWY1lOcGdIdUU5SHM0djFyV1I3MWd4SjFLbytoaythTUlx?=
 =?utf-8?B?bWppSHVHa216QWFFYjBQSS9Za1VMU1ZsM0ZtVUd0ekNDK2RNdWdnNDJ4NnBJ?=
 =?utf-8?B?TzhEaTEvUytWMTUwdWpxeEtva0o4em9vTXVtYzlxeFowWEhHckVaU1I3Z2tQ?=
 =?utf-8?Q?/xGqnhxVoEHayD4nuo2oFBFjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a62cd4e-7d0f-4c92-cd2c-08dbf8c5c216
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 14:47:25.3621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSX92zY7DIQEUsPT5XTf5PN9+jtzoGKo18UCJaZu91AYuZqciFA+6HRteQS4TrIaBbLGiJxzFmDze6I/Pa9Z4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101
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

On 12/8/2023 16:53, Alex Deucher wrote:
> Add begin/end_use ring callbacks to disallow GFXOFF when
> SDMA work is submitted and allow it again afterward.
> 
> This should avoid corner cases where GFXOFF is erroneously
> entered when SDMA is still active.  For now just allow/disallow
> GFXOFF in the begin and end helpers until we root cause the
> issue.  This should not impact power as SDMA usage is pretty
> minimal and GFXOSS should not be active when SDMA is active
> anyway, this just makes it explicit.
> 
> v2: move everything into sdma5.2 code.  No reason for this
> to be generic at this point.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2220
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
> Tested-by: Mario Limonciello <mario.limonciello@amd.com> (v1)
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

As SDMA5.2 is supported back to LTS ~5.15 I suggest also:

Cc: stable@vger.kernel.org # 5.15+

> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 2e35f3571774..89f7955739f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1643,6 +1643,20 @@ static void sdma_v5_2_get_clockgating_state(void *handle, u64 *flags)
>   		*flags |= AMD_CG_SUPPORT_SDMA_LS;
>   }
>   
> +static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +}
> +
> +static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>   const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
>   	.name = "sdma_v5_2",
>   	.early_init = sdma_v5_2_early_init,
> @@ -1690,6 +1704,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
>   	.test_ib = sdma_v5_2_ring_test_ib,
>   	.insert_nop = sdma_v5_2_ring_insert_nop,
>   	.pad_ib = sdma_v5_2_ring_pad_ib,
> +	.begin_use = sdma_v5_2_ring_begin_use,
> +	.end_use = sdma_v5_2_ring_end_use,
>   	.emit_wreg = sdma_v5_2_ring_emit_wreg,
>   	.emit_reg_wait = sdma_v5_2_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = sdma_v5_2_ring_emit_reg_write_reg_wait,

