Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02640EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 07:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 963F510E110;
	Mon, 10 Jul 2023 07:56:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 030A610E110
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 07:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN4FTsGe8B1c8ihqozevgIf+kH86ICOyH1YsbtRaDIeyHGgvf+Cvkh0v1JVyqjXTpuu6UVcTnlGBrxbDZ8lSzTtQJikSl7aBIGKSY8xrn+KqBYsajIwmNqqZa5mjYhaRtGpiQsKR2oOe9TNplvSlS+bYID8mi/xEJFZvR6HXM7rFBUp9Xw6v74nehfvvFa9d6TBVQgsNAwNBgc4QLddZaj5n+zfwXWJWL/cEe1O17QVUNGZ5Q+szEHp7R1zNb4qAbAyHnI08gLfVqwh+AEei0qmPuD5B95THMm2kWqR/0gV8G603P7Z4gEB9MWGhmNMPLn9oP0/PsLJP0NMDHuSiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34n8EF/3sJKWU9dvYGkQFyRT/pW26ezsmY5PORFZHak=;
 b=IR3Ps25Ve9dW0+VuVjSQN4xqQ3BZrdSyatotTGEdeLBZuDis+YUuUtRXN9DnJJ08YFCGHyJ3sa8CHxg3jF7RoDYgheKOAEqLBXsWwtlpI1IxYG9YpO00MClwWKYm+dFjuq4xSE6m+fxMKGLX90QrjCXyeUPv2G4IKWavEowFquWoa111/B4fOYUM05aKKxNRwyEmjpM5hfcq9R5lsprym9DUU/ecIyLzk0bNlC6KmaB25xLquBCyo1S5bu0opHrbVbTW+ttgkopROvSbpwR/neEyuA+zVIi8UIO1GQoJ2tzBWyb0nd9mTQtPve1MvN8k2FkPY6cdx092Y2jZfL6cGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34n8EF/3sJKWU9dvYGkQFyRT/pW26ezsmY5PORFZHak=;
 b=E2vXY7Quu4j7zJEEuMFQn4mn9iKqu9xXfQFmjYq8E8zPav2WM9AKkEqiZgtfO62n1L788ztK84CT745VGz9R9Z1rKWMHOknWBc9TQi7PhmnCDAS/SV2zdC882unph7ZutaLqdWIqBHCDqcshiAI9WNaBhyFxpUuBUwFRxb8cbwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 07:56:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 07:56:00 +0000
Message-ID: <a96165df-67af-af87-5095-0cbcae584401@amd.com>
Date: Mon, 10 Jul 2023 09:55:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5] drm/amdgpu:update kernel vcn ring test
Content-Language: en-US
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com,
 veerabadhran.gopalakrishnan@amd.com, sathishkumar.sundararaju@amd.com
References: <20230707152046.48706-1-saleemkhan.jamadar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230707152046.48706-1-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec336a6-4e18-4ffa-2fe9-08db811b19d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPsLCTAfNXwtJkIRarJcIn0+UPR2si7IGhpnOnL11dtMs9yiPi/r9zuOmaGm+7Sn+wvyvIvYEnD2dZ6KA0yQHfy/U37GlPB++H/xS8P5c1/Bmm0m1XpfIq+W9t77Zk2RnAYR/Sl9abvJ2MxT0pgCE9g8qE/oZt9f4Q0oT5ra7g45kIO6igxKpKVgLMTHEJr1bpPJBMsDxPFbG9eoYDntx4eCkccLTDpd7m6mPUDi5WA3+0/SIjVu+VNIih+qH6RIXXfGkGzIWklepBDdm48UR2jc+kZoBQEq507ae4MpXuKnqJGZIZ4608bn/lQmtgcjVcpIgjWbVlPcAvH5MBdyymy2iYMZOZvS6pDXfrXJLX6Kh4O/YebRWPJ0UmJ63NNwiY9N62SwR1QU6L1aBFoLZXKLmjl6SW9gKxcjgT+d8/qhGr1HvoZ4SR6GCYUmTq8zZVxFb3UskRzRujW8qrL5PmsvvNDssq5yPvLVgu6Sda4aEFqryoYeyih4XtiZyZDxYvhcviQH8b17skv9bg+Q2Xg6k/LVU47SIEEOjCL7j8mYoOct69f3QqAs/Y/3rTadhTcFbz4m2TX98LwpDguqxWaHGAdTJh++lWl02Hi1pGu4QW4ZgSzJoO5Obk/Ai3NlBYq1zbQiaKaes9V2ZGTb/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(86362001)(31696002)(38100700002)(31686004)(36756003)(6666004)(6486002)(6506007)(186003)(6512007)(2616005)(5660300002)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6636002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09PWmgxQlN1dVhjbXY0UUtGZUZXMy9ITUhBY3l0dFNHS2taaDUwUW1PTWZn?=
 =?utf-8?B?cWtVWDEzNVpTNTZKMko2UHh5cmlUUW8wcml6clN1Szk2Y0JIRHFZNWlSRTZK?=
 =?utf-8?B?TFJwMEsxdWtvSGpvdVpHY1J3TFJPdFBsYyt1V2o0L0tVUXZscHIraGJSZGFp?=
 =?utf-8?B?Y2JXKzg0Zzd5K1QrQ0NwWVJOTWNScml5QlRsOURqTy9DWUNnaG5tSkw0MXpL?=
 =?utf-8?B?bzU5SWk1Z3lMWGFlZk9vMm1LNFZ6WHF0ZlFUSVpnWENaUXlFYWdnTk0rQ01x?=
 =?utf-8?B?M2tCcytuRkpBMFhUVTF1WWxVMGpvUWJYUnhTTnVDeGRaWmR5SHNQT1ByMU5s?=
 =?utf-8?B?QVVvMWtHQmZEWVltZ0JuemRsbHl1SFc5UWJDMllncEZVYmV6c3RyTllpMDBN?=
 =?utf-8?B?VDVjU0dSQ3VhUVg5V3QxL0NuNUorMlE5cURoZzNISVR1cStMRU91djcvaUkz?=
 =?utf-8?B?VXc2THZPdkNZUC9iU2JLTFFMZEI4aE1WK0llSkI4TGlPcTROQ29mbXYwQUZt?=
 =?utf-8?B?d3lscnFOSkorYkdLTC9CSkpNbWd2aktvY2k5aVk1aUNvNy9YOTR4VXJyenpC?=
 =?utf-8?B?WGRmanMxanBCNDV5ZFJuYWRqQVo0Ym5TTFpNQ2VaSEMyTjdiNkVzMFZoZ2xh?=
 =?utf-8?B?QU93Z0JZR0QyL2xvOVdWcHkvaVllM0JsRUxFUXBMME5OZTVucWgyRWtJZXBt?=
 =?utf-8?B?TkhsbDFQaStHenFiVUhxU0JkdjREMmtsVVZnWFQrbXdkYnhua2QzWWNzUVV2?=
 =?utf-8?B?R1V5ajhUMXJteWx4RGt1Z28yeEZod2ZQSjU1aFdCQ0ZFQnY2RmdsY1AxWjVX?=
 =?utf-8?B?RlhNeHN5ZjVudHBhMHl3RUpvVjFmZHR0NFM3MmVxRU0xbEhlbFU5VExSWm5F?=
 =?utf-8?B?Wm9mU0JIK1p0NUZtZ3B6bEt0WjMyTjFPOXRrQURLb1R3dXJWaEtFakljMy9T?=
 =?utf-8?B?c2pVWkVoY3lwd1RVVlYyK0wwSDlNdzdQaklIVVZjVjdXZmkwWlhEL0JVS21p?=
 =?utf-8?B?UHJoZ2k3Qm4wNzM1V1JDVG1mUFlKUUkyVkhDakU2TGRhdmNWRjE3bG5pb1B6?=
 =?utf-8?B?dklvSjBUR25HUzZ1OThJeDFIL2orYmV5b1NBbEhML3VwbmczWGVqalZIdkZw?=
 =?utf-8?B?U0ZNZnhnaHJudC9SS20wU0NEMFZhWkx6em5rM0FBTGx6OXl6MzRlVFZ0V2F1?=
 =?utf-8?B?d3ZEeGJMbDdRZDlTWWpTZzg0MHFEOFlxN2lSajM0a1p3N1hzL2laUjQ5eDBS?=
 =?utf-8?B?RDdhL2h4RjF4NTlQRkFwZFBITHRobFBsSDkySkVjT05KS1E1TDc2TUE0RkFk?=
 =?utf-8?B?eG0waWdySVZLeXM1UTYyODBOelJpNFVhMnl4Q0RyVUFyTGF2OGlZSDJ0cnha?=
 =?utf-8?B?Y2V2TndwNS8wMnhEZ0h0MmVqMUdwdyt3V3Yzakwzd2UxNUk0d29TVGpXU1pC?=
 =?utf-8?B?VW5EVzQ5cUZGOVJ3SXB6dVdEWnMrNEpsVDJRak5EaVkyQ051RzhHUVllL1Fz?=
 =?utf-8?B?Tml4VlJIcWFSaDFadTh6SndjSHFpTndFZHd6WGhsc1V5STlmd2RHOEpXVDB4?=
 =?utf-8?B?NWlxa2xrZFJnN25EZ1UxUXVETmFrOXMxTjcxTmpqRkZlRW1KdXgxcDRWU3Fr?=
 =?utf-8?B?NmtkUnJDQWVnSUJvODZhSlVkbG4vSG8zS3hLcHYySURzeWdhdDFMT0l1M2lo?=
 =?utf-8?B?YXNUVWFHTmVKM1lsTEhlVUR0SFh2VnppN0hUbU9WRmtCZTE4SDYvQVJKQ0V1?=
 =?utf-8?B?VjVkNCtXcDRKVUVBLzhwSVFoeXRxV1RiYVF1MjJrRWtSTlcwaTc4dmd5Nmhk?=
 =?utf-8?B?SWhJMzg3YUsyaWVjS2tjbWlCd1FlL1laR01MSnAyb1NyS3FXN1BXZWNCSVZD?=
 =?utf-8?B?emkzVSs1Nk0yZURSb3BkUXBEY3hDZVZnakl4YTFOeFJ6ZFo0Q2llUlkvSHY0?=
 =?utf-8?B?L0N3c05DblhuZkk0U00wQ3BqL1h3aWo4dllxOXQyZW0xd251T0lyWURqcW5I?=
 =?utf-8?B?aWpFSDdGMG1CY3ViQ29LZy84SE1tZm8rVXlxRnl1RUoxTCtEb3dxYmNPanJQ?=
 =?utf-8?B?SzhmM0NnY2lZSGhpUG82T09ubUJqYU03b2VYQnlWR1BuYW41WUtZS3hhdWpn?=
 =?utf-8?B?MVRHWnNTcVN1d2FPQlRTV1JQZWNNMzJEcFNRVTZsak43NHNWVzkzdVhseFZ0?=
 =?utf-8?Q?pwf7Es1WUDW9T41c5xn6ND+hesNPs8mb2utL1IZ6ENnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec336a6-4e18-4ffa-2fe9-08db811b19d6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 07:56:00.3838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsaiApJIfZyGwpna+b+FFeTgC+ra/nuSc4FaAqmGrUTPh0WukCOKOvA2aZixFua0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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

Am 07.07.23 um 17:20 schrieb Saleemkhan Jamadar:
> add session context buffer to decoder ring test.
>
> v5 - clear the session ct buffer (Christian)
> v4 - data type, explain change of ib size change (Christian)
> v3 - indent and  v2 changes correction. (Christian)
> v2 - put the buffer at the end of the IB (Christian)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Acked-by: Leo Liu <leo.liu@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 ++++-
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2d94f1b63bd6..76e9a2418286 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -573,13 +573,15 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	int r, i;
>   
>   	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>   			AMDGPU_IB_POOL_DIRECT,
>   			ib);
>   	if (r)
>   		return r;
>   
>   	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
> +	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000038);
>   	msg[2] = cpu_to_le32(0x00000001);
> @@ -608,13 +610,15 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	int r, i;
>   
>   	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>   			AMDGPU_IB_POOL_DIRECT,
>   			ib);
>   	if (r)
>   		return r;
>   
>   	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
> +	memset(msg, 0, (AMDGPU_GPU_PAGE_SIZE * 34));
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000018);
>   	msg[2] = cpu_to_le32(0x00000000);
> @@ -700,6 +704,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> +	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
>   	bool sq = amdgpu_vcn_using_unified_queue(ring);
>   	uint32_t *ib_checksum;
>   	uint32_t ib_pack_in_dw;
> @@ -730,6 +735,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>   	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>   
> +	decode_buffer->valid_buf_flag |=
> +				cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
> +	decode_buffer->session_context_buffer_address_hi = upper_32_bits(session_ctx_buf_gaddr);
> +	decode_buffer->session_context_buffer_address_lo = lower_32_bits(session_ctx_buf_gaddr);
>   	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>   	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>   	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index f1397ef66fd7..2df43cd76c10 100644
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
> @@ -357,7 +358,9 @@ struct amdgpu_vcn_decode_buffer {
>   	uint32_t valid_buf_flag;
>   	uint32_t msg_buffer_address_hi;
>   	uint32_t msg_buffer_address_lo;
> -	uint32_t pad[30];
> +	uint32_t session_context_buffer_address_hi;
> +	uint32_t session_context_buffer_address_lo;
> +	uint32_t pad[28];
>   };
>   
>   #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80

