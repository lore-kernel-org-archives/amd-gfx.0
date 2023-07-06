Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97DEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 13:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 826F010E05F;
	Thu,  6 Jul 2023 13:00:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA94C10E05F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 13:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbvOJE6xeuns3viatC8djwjZ06RYTy2rS8v900c//baDTrJSfTer2NqgXDw7WRaiIvBG95yplHAbStUxhMZnofkP9BSOXV7F6WioUUtJRFD6BWB7D//RWfFQZy0H3wFt5on8vibuO4ZgBQDmXeUPftQScBFNDrS8JydwqmlQ0DmERcOBJ7aXV7F+prSDbV6+LZSI5lSD9bXQmWAHIbIBaSVZcSHxzG6tn5VTvF2GpFt6c/HNkAen90lCQd5AV7/3KKa7BA5vcpxRB8PkQESY8qGJ3xq9TtFb2ewbSvsHgsehRJJMYrRTWLONPXDmLLnbVsblJYfKi8owLsqcA4nyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/z6cK/GO6k//7pbKauO30olqqzmtlf4VqdzEYt2zJs=;
 b=inV3PnnutM8a6LMlyjAbIPuLX0kD1wgNXoov1IBl0gF3ULzv6oPCCJLs+2K+qKPDFStNT5grCgFtX0NsrYb+zQS391No+MopSx+toZ9NWt2OlCano5scpn3bmKAQrYdfk+luiIMnKWqF/L8swPK5yUJ7RAt5UR2gc9WkUks2Em2czmaByR/XfMzXBCrhgctAMW0XqKlrHOeu+eNvbOA9YZi/d/4zJtAXYHfHxtwF8XwunZMdRvrIBLNLTO4VhYqIzfC0rg/LATuQOCmGU6I71r6c/KHHwxdbTH0r5+O0/J2uWTAoJwTctVt3RBSdH3qTkqrwjkAkmn2xtCd5qCjjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/z6cK/GO6k//7pbKauO30olqqzmtlf4VqdzEYt2zJs=;
 b=ToURFkNJE3VKNMJrZQL5/D7hFrdbaOkJb4XnaVtyCUj59Qr/29/qo0ouTtyU9OL9aNHttIrBQmxZXGXsVepuUqr3Jux9FxseRZqZFE88LPqFAkVq13cAYv+GTIoSY08n8AMMrq/+UbdMlxdOGTqshLKbumD2Jt5WqcVL99EMVBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:00:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:00:20 +0000
Message-ID: <125e9487-4dcc-c796-6d80-d9df778d853c@amd.com>
Date: Thu, 6 Jul 2023 15:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdgpu:update kernel vcn ring test
Content-Language: en-US
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 veerabadhran.gopalakrishnan@amd.com, sathishkumar.sundararaju@amd.com
References: <20230706124901.3638313-1-saleemkhan.jamadar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706124901.3638313-1-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 029159e8-6db0-490f-f273-08db7e20f416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wo7UW2I4b/dGRtDce3n2iVbze4fSGc4l/g0U02ZQAjM0tJi7UMvgbbzjOjdlDhmKcUff/IM629qKDASzdnI7CMcfBjjPL0z3m0XqKAvUcojOvrva9Nj3IPMZI3JWALk0y0q1FkLQPvMph4vi9SpYSYEWIX6s8J5QGdBoUXUIbM6/E+Nbt2zx2oG06/08uLL79oLKlysbLJrOrsnzf+r+vJ8gtA30/VlXb3nz/XJmfJ15NKsEpIYNYAW/K9uZV9qqWKy662IEDZT4UMeLLI14eU/psD+D+YVWqn0bhAQgvn2AdJf2txAhbQnW6xDk1yIlITWgOnhS4VpWmX6xZA6IctAAAi8CBVneVHUAayfWxJEQvNzHTgd8EFotxCFMIU7+DiQC7XQ00fRJrvuXlmq9jDC1F/EG1Jb/oVpyRBFUN9FA9m2w5RiK4wlOnK+kDs6JaMq8oV61g+jiLpgKGH9l0sWtrEiH+eX+qoh6FkueGJ8DUdFj0EHMZgj3oaVDdFcM+DqNX3nK4abyZ2MwWGM0LFr8FC/EISmZrvB8+hjHAMPtCLKif9/2nMD6lAey+fjrP7e9+5ObI2TxNTMVfdnSvdXvoxpH+G53cT/umOCEPQaoPAn7+CtXQkQVi4rVjquEFnNdgIs4s78ZPKqhUV+6VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(478600001)(5660300002)(8936002)(8676002)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008)(6636002)(2906002)(6486002)(6666004)(6512007)(2616005)(6506007)(186003)(31686004)(83380400001)(36756003)(31696002)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9DaS9jMUkrTTNjelI5N0lqdjlNWG1jLzBiRGlXQTBIWEk5Sjc1YjZqbzVC?=
 =?utf-8?B?TS9UQlc4dEE5dzJUWmFpeVMzUWVUbkEyTEtVd0ZlZEhjZE1LQVBqTGFzRmhm?=
 =?utf-8?B?NFVpSFQ0UC9KN3F1YmZROWlyenhxYWcyKzQ1YmZVR0NQbWhTa0NHUVNQVHh1?=
 =?utf-8?B?dHRiUi9ia2RZSkU5Qk1DekxkZ01YeVNXWnNWcExIL1c5WTh3bmxpejBnZ0ly?=
 =?utf-8?B?UncvVVdIbmh6bW5BVVkyaDRlL2N0T0NiMjUrdzhWRzNhSlhwSkdyeThyOW5C?=
 =?utf-8?B?RkRON2hJWjRGZTRYS1h6UDQ2V3BOeUJZME9PNlkwRWtwMk56dDRaL2x4NVZo?=
 =?utf-8?B?MjRHcllWT2pnY25tWTgzVmY1UTBzQTB4NHVpd1RiZW1zQ3FFSjVETmxGSHJM?=
 =?utf-8?B?eWxNcTl2UzNPM2FJcUZ1MExEN2pQRGw0NTVSajJGcE9Ebk54aTZwSDRpK0dL?=
 =?utf-8?B?dzRwLzl6TUVxS1MvZnFPWStkZElFdGhCeDdvalJteDNvN2x3VHFpZjFWVnlh?=
 =?utf-8?B?L2lnQW1PdDNtZThscmQyMHVwbHBtL2xsRk9Mb2pmMVlFZ1c2NW1ST3BhNm9J?=
 =?utf-8?B?YjhnUmN3VU1iejlpM3lVRUovb0JwdG9PNUN0SHNEeTB0NGYrUnNwVVZhL0pP?=
 =?utf-8?B?dlA3TnJXK2dldjVTZ2R5WUM1eGpRTUJpZE1lWi84UFNlL0VXeEw4UnlQcDgw?=
 =?utf-8?B?alFNL1hua1NTbkJZUVJ1eTI2S3MyRllWYzZXb2ZWNm94Rk1FV0lKSVhwTDhj?=
 =?utf-8?B?aS9rMGl4S25mR2hrb1c4S2xSMTcya0g0UXJwM2M1R3d3Qjl4ZmdhN1BTa0tH?=
 =?utf-8?B?REpUZW14Zk9hcGJocWEyWC9ndnFNNGVxeDBTNTdDRzZaSHhCV0s3R1ZCSXV0?=
 =?utf-8?B?U1FZVkpSVHBYUXBhMkpQOGtjSW5xT1dNMlMrQTVWQ1pyWE9PcndJMVhtR3d5?=
 =?utf-8?B?V0VPT1RGcEtUYW9MTXpTV2gwcU8wLzBGRUF1eGFZdzJIUnZnNXA3dUFEMWZO?=
 =?utf-8?B?bnRteGtEd3lOa0pBakJjV3NZcG5lT2NWUjg5WWtQTGRNY2Y2MUVFaUtVSE9a?=
 =?utf-8?B?dU1hUk0rYXRZK2ViVjJ4NWR2UnFla09mYS9Rby93dXljdUhVc29YOUs4NkJB?=
 =?utf-8?B?Um80NjUzU3pYcmFOY0ZIK2I0cDh4eXRGTWE0M2xTb204UjQ0N1FuWGltL3pI?=
 =?utf-8?B?WGlxaEp3SkVOMS81ckJIbVhSUVE2NjhrN05CdXJqYzUwMURXcFN6Wkp0Mk5q?=
 =?utf-8?B?ZTBsREdSM0IrNHVGOFpVZGhZT05BYnVVeVRGZW9WcGFWMm1YVlZCNnU2ZmFl?=
 =?utf-8?B?Rmk5NGkvMWswK0lZdTNNTGhNcUl3LytxUjhPNjNva2dxL2NxMDhGVDQzSVVk?=
 =?utf-8?B?WjE3NmZVZHJPcjdxWk0renc5N3NtT1FraUVBS0pPenQxaHc3S3oweUMwRHgv?=
 =?utf-8?B?anRTc25qUEVrMzlKYTZFRnpTRURmRnBSYXFqTXg3OWxhM0lGeEpiWUhrSnR4?=
 =?utf-8?B?WWFJVTBuVEhjOTYzaWlpdFF1dG9wVkZuckdYUHlveVFRQ24vWjVzaEl0cG9o?=
 =?utf-8?B?NkducDN0RmtpUlkzTXVSa1FPZWM3SHZacGV4SUtySy9UQzl2L0FKUUJBcUtJ?=
 =?utf-8?B?dU1wdXJBTUFpQ1pOQjhWMllITW9sM3BwN2NWL01VZEwwVEErYnpISzRHMjRB?=
 =?utf-8?B?VUVkYzNCN0RYYUN6TGd4SzhBTEt1SFRTTUdjdGxySGRadko3SmtSS2hWTHFx?=
 =?utf-8?B?a2VuWXI0QWd6VnM3SmFWazlKSnBNekk1eWMwWWdNRWtWcTBETXREZHpLTDI0?=
 =?utf-8?B?bTgrZmFSVGRBNnlkYTE4L1ZVT2F1cHl6MGhOR244M3RhbTNCcW1ib1IvQjVx?=
 =?utf-8?B?U042M2FGZlBqd0xXelppMlVINk82VHczanZOT3pJaDZhWVFZajN3ak9oM0p2?=
 =?utf-8?B?UnAxeFVsNVBBSFZ4NWdGNVhKRFhDNjVRU3ZBKzdUdndnMDgvZzVoblZqMUJa?=
 =?utf-8?B?R2g3SEQzS1BzaTNZSUY1MWtkcDhjVGdEbEl2MHRXT29VaHZvOGcrTGxGYU94?=
 =?utf-8?B?Y05hdWR0MEdRNnJESEthL2QrR1dtNWM5c2krUU1nRi9WREE2Q0djQUp3djNR?=
 =?utf-8?B?a2xDOW5OSXlleUtjYkxYdjRUUGpjT2VNUVkrODdFVnJMMGlYcFd6endiTGtt?=
 =?utf-8?Q?NxG/A8n3k/bcSm/bl5TLryqcJtRkr275PnawdMEmCMjq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029159e8-6db0-490f-f273-08db7e20f416
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:00:20.4761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9BFmiztnHlagHZXpQPuvV/RJ9/yAVkl1WC66RHTPnwlHnDDCc2zlAHE9/8BFq10
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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
Cc: srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.23 um 14:49 schrieb Saleemkhan Jamadar:
> add session context buffer to decoder ring test.
>
> v3 - indent and  v2 changes correction. (Christian)
> v2 - put the buffer at the end of the IB (Christian)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Acked-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2d94f1b63bd6..15627fd94fbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -573,7 +573,7 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	int r, i;
>   
>   	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>   			AMDGPU_IB_POOL_DIRECT,
>   			ib);
>   	if (r)
> @@ -608,7 +608,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	int r, i;
>   
>   	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>   			AMDGPU_IB_POOL_DIRECT,
>   			ib);

A comment or some define which explains how this size came to be would 
be nice to have.

>   	if (r)
> @@ -700,6 +700,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> +	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
>   	bool sq = amdgpu_vcn_using_unified_queue(ring);
>   	uint32_t *ib_checksum;
>   	uint32_t ib_pack_in_dw;
> @@ -730,6 +731,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>   	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>   
> +	if (session_ctx_buf_gaddr) {

This if can be dropped now. The address is always true.

> +		decode_buffer->valid_buf_flag |=
> +					cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
> +		decode_buffer->session_context_buffer_address_hi =
> +							cpu_to_le32(session_ctx_buf_gaddr >> 32);
> +		decode_buffer->session_context_buffer_address_lo =
> +							cpu_to_le32(session_ctx_buf_gaddr);

We have upper_32_bits() and lower_32_bits() macros for that.

> +	}
>   	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>   	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>   	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index f1397ef66fd7..06f9ee91a1e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -166,6 +166,7 @@
>   
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> +#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
>   
>   #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
>   #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
> @@ -357,6 +358,8 @@ struct amdgpu_vcn_decode_buffer {
>   	uint32_t valid_buf_flag;
>   	uint32_t msg_buffer_address_hi;
>   	uint32_t msg_buffer_address_lo;
> +	unsigned int session_context_buffer_address_hi;
> +	unsigned int session_context_buffer_address_lo;
>   	uint32_t pad[30];

Please use uint32_t instead of just unsigned int and I think you need to 
reduce the number of pad fields at the end.

Apart from that looks good to me,
Christian.

>   };
>   

