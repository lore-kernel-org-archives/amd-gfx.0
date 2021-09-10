Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC32D611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC32D611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DEA6E4B7;
	Fri, 10 Sep 2021 06:24:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1A36E4B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 06:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOaZwdINSGzgWJYy7GgDI//sEpKuyhsHx7u8+XNLshOwpf8A+BkMPCwn5G5AERsr0xnv+7L1iZ45sRSmQZgW/CpoG1I6z5GdpEnrbmhs8auoXwGYYeuXwwpc9kHZqnGFDqmvcG04+FPJv8vyoySTZEEyJtughlmVuG3zQp1OMwl9O0Co7qVbMTEL3ZDLkgMpldQm3gSFIMA4ZuCronCMQ2/Ya4Z/L0WijmUkqmREale+vXZvgHgCPsIRfuNiZfO1AOMCfeppCG2j8AV9jHQpXajICGQjvebV2mKYWQCtBkVKQAXoM52CYgSM4xn943igsLTlT134zH2WelgFx56V7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aaTRVUDMceRN9OUlo5xAOhjjEOHoBjmtXu2Mv/Bztkk=;
 b=QK0N32FHSoXEGlE9zjnDdQX/WWdEByL8azwHKXyMYqRadNPiiR+HP9KcjGCYpy+qj89Uam0SNkKCJc6/rdMExcaWCxOI4G1t6pDihk/6L2KnARjL271lDMSDuLbLzBZO+EBRO4Wd07AqAkcoPqJAcngHNHi5T6iNAPg7Oe3z+Yuue7WViUmTZaPTZqFaWl2PGA1miXPjidfBY1/e0nN4LwhH0ekcSyaMK7S+FY5acnDzyxHADVoWjJHwjXOhgpW1V+z9xPTXGiMWy/hB04CETX6iET83q9/tvnlkhechj+0Z0TLtdrEXH55NS7k0PLnm4Sb7003wlGoRueOZLXdlcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaTRVUDMceRN9OUlo5xAOhjjEOHoBjmtXu2Mv/Bztkk=;
 b=qqyFj04Gqks1Wjp4Za9yt84pBDP+XRdjj09mGFb2AMJAb9JitIUdEr6qQhf9lDBWgZXWMf6TeTbZ5znLZfJOdYG7C0tS754jFU7ELx2dJ2w2brxQsT6Ydze9pxfaLVdZCl6rPiExUJdsZF7C41TAP2P979navgXOvj71GzmiBEk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:3f::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 06:24:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Fri, 10 Sep 2021
 06:24:13 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: UVD avoid memory allocation during IB test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-2-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <005bbb06-034d-6cdf-7c61-1d0339b2e54d@amd.com>
Date: Fri, 10 Sep 2021 08:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910003828.4013-2-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Fri, 10 Sep 2021 06:24:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7543ce-5511-452e-2c08-08d974239b58
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355FB8F2763A5C506AF5E5683D69@BL0PR12MB2355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZD+Qf7hvbyy96kDhG7ydEcBxnPUNiSC6s3lrCdlkK6PuM49sgUatqOldT2/rwe4bhJj5l52cRsHuNkDiQDBq87CKky6aga5whZbx1kf2NLlFedJFeGGdk0qFZn5O3sPjQaC7WP9i63s8hbfWOT1FyDQkktN78OjziNV1wpE/W89CCDdHOfXa/CZcOzbvDROELFNQYuM/8fMTGHOgzpEItHmtmtKqH6eEjGUWxHjqElEf7ErrcAJVfIJQOnQZMfG4nm0hgIAyTNQhsFnA2zNkUtbSZDXJJo/tA9hB1mWMUF+hSVnfox2Om2RBFv7cqvnX3S7Zvbjy46M6rrLiBYflX0+7kzkB0H7egnNLyGA3YhpnRRTKGJitwpjvSm7SXaggQwmQeQkkh+/PbVuZfmUg+WPAO19Wc8zf/olgdegM9fCiRXmT0uCAVX4KC/tFtfbT/v9xs5ab8zn53sCGbR5t+6ChNnXQycQV6osBUuRU/LEhcM6ohy9q7HzRRFHw1or1s/OReaDCJ99QonD5otT51FZXHmpMgJqdiSfsLebdQ4PnN9yqxx9+8uOzLRisKWTRXabk/zNcpo2k2cxRmUmhoCrL+6kA5OacJhQDTdyulN+WHE/0cVtILK6htexcByf2BCdySVIh7+JzfXXUaBVGm7JEU13v0n0LN15ZezIWOfn1Ri4j31+ZwT+BhPTHIGvEalLS5tDTVA17tZ8zZeMZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(8936002)(31696002)(66556008)(478600001)(2906002)(956004)(5660300002)(83380400001)(316002)(16576012)(86362001)(186003)(66946007)(66476007)(8676002)(26005)(6486002)(4326008)(36756003)(38100700002)(6666004)(2616005)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZDbnUzRjNvVVVLeCtPZUVLQWNqM1lZL1dPMjFJWWVFUUhiZUVtSTIzK1dO?=
 =?utf-8?B?MXh6SnhYcXV5V2t4Z1ZKYkw1MC9pOVRZdytWZmJRV0tlQmp4K2JvSE1mb1ky?=
 =?utf-8?B?ekRwd1FYanh4ZFY3REVPRGtCMU41Tk5ZUkZxRTdaeXQ1MnV4V0V0SGF1TS9W?=
 =?utf-8?B?V1l1OHJRSEhTM254dHRsWVRVY3JibGpUZlhPRjZJMW1kaUpLSittYldySFVv?=
 =?utf-8?B?WXNGMGFOUnFTVkF6OU5xWUtWSFk5MkNjRC80OVVPOGk5OGRlbFdqQ0RuS0tS?=
 =?utf-8?B?K3hlODY3cGdmcGZVNGx3UFRrb1RWbkkrUUlZdnJWQ0VEcGF6Q21keFVib0pK?=
 =?utf-8?B?T0syczdDeUFDTzdxUVErWUFwSXp1TDJrZVRHVFVlRndxbWlKSldTWktvT3F1?=
 =?utf-8?B?cVczYkRRM3lUVWNKMmxydjVDZTRjZ3RNbXk0OTBiVFN6L1hyQlJTUXc2d1gv?=
 =?utf-8?B?SWMwZGxTenJZZGlsZDByRVpEVzEvbm5LdUw5ZUFUMkx3U25ZdUlUTGZnVlJG?=
 =?utf-8?B?a3NrU2ZlaDJGekZJUngvYnVrYkhrNTkzZGZGc0VvUVpLVmJXVHNoelNOU3pw?=
 =?utf-8?B?bm1zem1selVTd25QUkNvQkRidTY4K2NNczV6MWhvcE1nK3RtY1J1ZFJqbGtG?=
 =?utf-8?B?cWN2bEdKcER0aWM3MmNaVEpsUHNBNUZOZW1meWtXb1NnejlmTCtiVjdQU0lY?=
 =?utf-8?B?UWxSWmtqbU5pTXhiR2ZPZll1Tk1FQ0t1Q2pqeEVmQ3p1T20relBvd0tJUU5o?=
 =?utf-8?B?T2ducUJ5ZUhqK1RBQTh4eEd1YkVhdm9GbXZsWW5hOGhFRW1YUkN6VW9FWWtw?=
 =?utf-8?B?ODA0OXIxeEdKMWRzUUR2MjFZT3J3NUExYk1HaGxzNmk5MVBvbWJOZWZjOUZ4?=
 =?utf-8?B?TWlnQStXc2hka3NTSzl5a0xnQTQ1REI4ZklNRlMxY2l4bWRETVI3dE9BZXF5?=
 =?utf-8?B?eWxoRjU3ejBZckhZTm43SEpRNUZuY1FYdytZdlhMUjU1ZGg5Qys5bjNxS0RG?=
 =?utf-8?B?T2ZtMFBDcjllT2dpTFdtQVRIR2VSNW5uK0JZWW9BK2JsaUFRdTI1MzAyOGda?=
 =?utf-8?B?U3cxalF6NDJtYkc1blYrYjhrNCtyZ3NOSlhsQWIrSk1kSDFqUlRuMU1JWnI5?=
 =?utf-8?B?T0hiUktWWFJaUlZWTG8yalg0c2xzT05JQUJRVzJvYzJ3d3RZR2tKTTNGVmFB?=
 =?utf-8?B?N1NEL0wzaXJxUi8rOHlwWkFHR1V6VWlnRWRZeFdDeitYOXZqLzZaa2hVMEVQ?=
 =?utf-8?B?RkVhR2tvcGNzNFJhQ1lPL3dPcXVMUlEzZVp2QWlocDZBeEliTm51RklPWTVI?=
 =?utf-8?B?S1dPNllaY2ZSZlJYUnpoNG9ha21GOXBDRFp3OWoybmJXL3Q5WHUvOHlLekFM?=
 =?utf-8?B?QjgxU3MydnYzSmd4c1Z6ekE0UVNCV3RMMTZiVVoveS9SMFNGTXlqK28wZmRv?=
 =?utf-8?B?WXIxUXNFV1lKeUlrNit0K1dOUWdkYzJNUVFwRHZDaDRFSVVWQ0RnRmNtREtp?=
 =?utf-8?B?VEhIZnR1K3hvbVlYbEliV2YvUkdhdkE1V3ZzLzFBYlA0S2FCM3VlQ3FiUk1j?=
 =?utf-8?B?T2FmWmgyWFc3V1VmZFF0NU9VN3BoVHQrNGVpb1pES0ZBY3BSOU1hQ3FlZ1RC?=
 =?utf-8?B?M1VaMlUxZGJ0NXk1VGprQXJCSDJrQlZXWUszYUZKWnZnVDI0NmVNWUcxd0Vp?=
 =?utf-8?B?QWs1MHhvUnkrTnpueFdxNng5b01hVkJ0OUlua1Y3MnprOGY3OHlJZEJqRlRz?=
 =?utf-8?Q?3Ldr4a+5v1dEtSIylXA40/ejt8GbFN1Ryk+JaM+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7543ce-5511-452e-2c08-08d974239b58
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 06:24:12.9899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIeecfrrKS/Qh9S8H62wLlR7oL7ArQbnhdurhihKaFBRBrA6wGJNnY0YD9nn0Ns/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
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

Am 10.09.21 um 02:38 schrieb xinhui pan:
> move BO allocation in sw_init.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 75 +++++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  8 +--
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  8 +--
>   4 files changed, 49 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index d451c359606a..e2eaac941d37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -141,6 +141,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   	const char *fw_name;
>   	const struct common_firmware_header *hdr;
>   	unsigned family_id;
> +	struct amdgpu_bo *bo = NULL;
> +	void *addr;
>   	int i, j, r;
>   
>   	INIT_DELAYED_WORK(&adev->uvd.idle_work, amdgpu_uvd_idle_work_handler);
> @@ -298,9 +300,34 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>   		adev->uvd.filp[i] = NULL;
>   	}
>   
> +	r = amdgpu_bo_create_reserved(adev, 128 << 10, PAGE_SIZE,
> +			AMDGPU_GEM_DOMAIN_GTT,
> +			&bo, NULL, &addr);
> +	if (r)
> +		return r;
> +
>   	/* from uvd v5.0 HW addressing capacity increased to 64 bits */
> -	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
> +	if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0)) {
>   		adev->uvd.address_64_bit = true;
> +		amdgpu_bo_kunmap(bo);
> +		amdgpu_bo_unpin(bo);
> +		r = amdgpu_bo_pin_restricted(bo, AMDGPU_GEM_DOMAIN_VRAM,
> +				0, 256 << 20);

Please keep using amdgpu_uvd_force_into_uvd_segment() and validate here, 
cause I want to remove amdgpu_bo_pin_restricted() sooner or later.

> +		if (r) {
> +			amdgpu_bo_unreserve(bo);
> +			amdgpu_bo_unref(&bo);
> +			return r;
> +		}
> +		r = amdgpu_bo_kmap(bo, &addr);
> +		if (r) {
> +			amdgpu_bo_unpin(bo);
> +			amdgpu_bo_unreserve(bo);
> +			amdgpu_bo_unref(&bo);
> +			return r;
> +		}
> +	}
> +	adev->uvd.ib_bo = bo;
> +	amdgpu_bo_unreserve(bo);
>   
>   	switch (adev->asic_type) {
>   	case CHIP_TONGA:
> @@ -342,6 +369,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   		for (i = 0; i < AMDGPU_MAX_UVD_ENC_RINGS; ++i)
>   			amdgpu_ring_fini(&adev->uvd.inst[j].ring_enc[i]);
>   	}
> +	amdgpu_bo_free_kernel(&adev->uvd.ib_bo, NULL, NULL);
>   	release_firmware(adev->uvd.fw);
>   
>   	return 0;
> @@ -1080,23 +1108,10 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	unsigned offset_idx = 0;
>   	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>   
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> -
> -	if (!ring->adev->uvd.address_64_bit) {
> -		struct ttm_operation_ctx ctx = { true, false };
> -
> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (r)
> -			goto err;
> -	}
> -
>   	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>   				     AMDGPU_IB_POOL_DELAYED, &job);
>   	if (r)
> -		goto err;
> +		return r;
>   
>   	if (adev->asic_type >= CHIP_VEGA10) {
>   		offset_idx = 1 + ring->me;
> @@ -1148,8 +1163,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	}
>   
>   	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -1159,10 +1172,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   
>   err_free:
>   	amdgpu_job_free(job);
> -
> -err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> @@ -1173,16 +1182,15 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> +	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_bo_kptr(bo);
>   	/* stitch together an UVD create msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000000);
> @@ -1198,23 +1206,25 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 11; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, true, fence);
> +	r = amdgpu_uvd_send_msg(ring, bo, true, fence);
> +
> +	amdgpu_bo_unreserve(bo);
> +	return r;
>   }
>   
>   int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = adev->uvd.ib_bo;
>   	uint32_t *msg;
>   	int r, i;
>   
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_GTT,
> -				      &bo, NULL, (void **)&msg);
> +	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);

Please use amdgpu_bo_reserve() here and elsewhere as well just to be on 
the clean side.

Lockdep will sooner or later complain that we reserve a BO in the reset 
path, but that is mostly a theoretical problem and existed before. So 
I'm fine with sticking with that for now cause the problem was there 
before as well.

It's just that trylock might not work because the BO is busy with 
indirect submission.

Apart from those two minor issues the patch looks good to me.

Thanks,
Christian.

>   	if (r)
>   		return r;
>   
> +	msg = amdgpu_bo_kptr(bo);
>   	/* stitch together an UVD destroy msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000002);
> @@ -1223,7 +1233,10 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	for (i = 4; i < 1024; ++i)
>   		msg[i] = cpu_to_le32(0x0);
>   
> -	return amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +	r = amdgpu_uvd_send_msg(ring, bo, direct, fence);
> +
> +	amdgpu_bo_unreserve(bo);
> +	return r;
>   }
>   
>   static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> index edbb8194ee81..76ac9699885d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
> @@ -68,6 +68,7 @@ struct amdgpu_uvd {
>   	/* store image width to adjust nb memory state */
>   	unsigned		decode_image_width;
>   	uint32_t                keyselect;
> +	struct amdgpu_bo	*ib_bo;
>   };
>   
>   int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index bc571833632e..301c0cea7164 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -332,12 +332,10 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
>   static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>   	long r;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>   	if (r)
>   		return r;
>   
> @@ -357,9 +355,7 @@ static int uvd_v6_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unpin(bo);
>   	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index b6e82d75561f..efa270288029 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -338,12 +338,10 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
>   static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_bo *bo = ring->adev->uvd.ib_bo;
>   	long r;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	r = ttm_bo_reserve(&bo->tbo, true, true, NULL);
>   	if (r)
>   		return r;
>   
> @@ -363,9 +361,7 @@ static int uvd_v7_0_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unpin(bo);
>   	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
>   

