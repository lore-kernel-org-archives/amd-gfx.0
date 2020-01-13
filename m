Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613ADC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 22:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314AB2084D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 22:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MEwq464i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314AB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEC846E17A;
	Mon, 13 Jan 2020 22:16:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A8F26E17A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 22:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGTOTq6kIlxCE6ciC8mB+XvcC1l93Ls1GOVOJmkPqkOHL5OojqukijCCTHtHWjjX5g6Zdpz4zmlo8swK7qQXnn6rLyrtuXDYQ75Px5T005+4mOYDyAT8DT9aVmwfuJ1KyZm5wUGZAp8BSWuS3q8auCEj+nwK5/E+UG+H9V7jVqvv9uakAPyQZ4ZeN6gzOLWgyWwVlUZfJf0XYrZxeHFO+IfjKqkh09Momc5tCPdsAhVZU/OTe17LSZVTbfMtFSJpvwbUryHpZ0GYC1eKvLZRaje2HPrHQqESsQEMHESBLljWXxvg746W5TNFealHRfQV1TLp4cHYf/cxqmexGAmvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5+/9wlMZvpPb7qh55qJvQgFlKozIKV8USkzav6nn1M=;
 b=XIaa4fmtbvVw7/CaVNzOGo8eJgNZ/WcmWVz2HeTh3QXg8kFY+zEUFmkm6CUG+VNMVKkeR+wACqkDH6xjIGcQM94uFHfKEQzzqfQl1p9yR3kJRj+qcGOXoBMlQ+rKx+Dda16SMocJ/H2F7sU8tYfCx1hqzlxWgfVALuuaB7tvmw+QlAF1i6EVQblUZzu+C0aN6Hr6UwOKBNgi/csapyLEhlyDLzUmSNpKZiqxZPhDRP+kDUvUMefJ7WWvBqBRtczNwoMVhgmiG+0LiB2YCq3y9MoGhy+mAwsz38P51XbJB7KGrEms3+bFXGq5+pDaZGQu5LtoYPzEIwiQiuai6mHjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5+/9wlMZvpPb7qh55qJvQgFlKozIKV8USkzav6nn1M=;
 b=MEwq464iDp+zPfQNwxCjyVKRDRkp8pOxstgb74QmgDO4VyanH/5Az2AWnQwvb6klYGvPs7otVBLDCMYIM1qxc7g7aXwVBF2Jum5fl+8N4SxVQpgxNlJt+1271ZjhuGFzDR8Kqp4TWb2xuRuItniS3h2V89mhpMJ9AreoDjImBzU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0074.namprd12.prod.outlook.com (10.174.107.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 22:16:04 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 22:16:03 +0000
Subject: Re: [PATCH 3/7] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200113202629.94021-3-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <942b2bed-84b7-26bf-c7e6-8816cfce99de@amd.com>
Date: Mon, 13 Jan 2020 17:16:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200113202629.94021-3-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::30) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Mon, 13 Jan 2020 22:16:03 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d19cfc8-71cc-427a-3bce-08d798762dc4
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0074:|DM5PR1201MB0074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0074EA1EEEA7D60CFC70203692350@DM5PR1201MB0074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(31696002)(31686004)(44832011)(2616005)(478600001)(316002)(2906002)(956004)(5660300002)(16576012)(8936002)(66946007)(81166006)(53546011)(86362001)(6486002)(66476007)(16526019)(186003)(26005)(66556008)(36916002)(81156014)(52116002)(36756003)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0074;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KzxgXL8IfVDMPCMnDjAhX0EswKXvdMWFmV6AcRNHzgL80nv3SDggDJeWsLI3FZvYClTIQHMEUikvkEN0etAs6OmH7ZpfoF4rP6YkeNF2jZQ0PWGbDpsuSxJgiiS2mUFwUhL4AI865s8JbtEFoId355sJ+xBelPU130y+dZDoSU6zAnD2qEkUXr4hv4aEq94df83fH/+uo048+xbfPVrahUCAXB+d12OmLic2mEjTkq72Q44xxemqc7E21fvH8hBdpAWiyBk7D/s3bDI1M0zqheMTZJbGuyoTrWXkxXEWeIrYKqVY0k39vYhLc/1d4bkRHNrYA8+PSq3PWE/q7bEDrSnFrD3FYEWCT9q6aOv/DibRKl4XJ24Hr8+PZgi3lfdMmNXAPW0TKekHMwWBTGt3KKeb6TDNjfFfccL40W/Fo7rRBsedAtBYJtyzWwcmfLF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d19cfc8-71cc-427a-3bce-08d798762dc4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 22:16:03.8861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqayKgKullTblMZWnKQu8fkD544DpHMsrgmP7y9hFx+53LEwQyzJht7M39HBGXyOd4YoOIGA+5d4/U/mRQaUnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0074
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


On 2020-01-13 3:26 p.m., Alex Sierra wrote:
> tlbs invalidate pointer function added to kiq_pm4_funcs struct.
> This way, tlb flush can be done through kiq member.
> TLBs invalidatation implemented for gfx9 and gfx10.
>
> Change-Id: I1b77b364f3ae0038ff3e70e869be5f2ef6e6d293
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 +++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 14 ++++++++++++++
>   3 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 8e88e0411662..af4bd279f42f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -76,11 +76,15 @@ struct kiq_pm4_funcs {
>   					struct amdgpu_ring *ring,
>   					u64 addr,
>   					u64 seq);
> +	void (*kiq_invalidate_tlbs)(struct amdgpu_ring *kiq_ring,
> +				uint16_t pasid, uint32_t flush_type,
> +				bool all_hub);
>   	/* Packet sizes */
>   	int set_resources_size;
>   	int map_queues_size;
>   	int unmap_queues_size;
>   	int query_status_size;
> +	int invalidate_tlbs_size;
>   };
>   
>   struct amdgpu_kiq {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 379e46c1b7f6..d72b60f997c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -40,6 +40,7 @@
>   #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
>   
>   #include "soc15.h"
> +#include "soc15d.h"
>   #include "soc15_common.h"
>   #include "clearstate_gfx10.h"
>   #include "v10_structs.h"
> @@ -346,15 +347,29 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
>   	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
>   }
>   
> +static void gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
> +				uint16_t pasid, uint32_t flush_type,
> +				bool all_hub)
> +{
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> +	amdgpu_ring_write(kiq_ring,
> +			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
> +			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
> +			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
> +			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
> +}
> +
>   static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
>   	.kiq_set_resources = gfx10_kiq_set_resources,
>   	.kiq_map_queues = gfx10_kiq_map_queues,
>   	.kiq_unmap_queues = gfx10_kiq_unmap_queues,
>   	.kiq_query_status = gfx10_kiq_query_status,
> +	.kiq_invalidate_tlbs = gfx10_kiq_invalidate_tlbs,
>   	.set_resources_size = 8,
>   	.map_queues_size = 7,
>   	.unmap_queues_size = 6,
>   	.query_status_size = 7,
> +	.invalidate_tlbs_size = 12,
>   };
>   
>   static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ad0179ea2cc5..b8759386dcbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -837,15 +837,29 @@ static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
>   	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
>   }
>   
> +static void gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
> +				uint16_t pasid, uint32_t flush_type,
> +				bool all_hub)
> +{
> +	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
> +	amdgpu_ring_write(kiq_ring,
> +			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
> +			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
> +			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
> +			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
> +}
> +
>   static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
>   	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
>   	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
>   	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
>   	.kiq_query_status = gfx_v9_0_kiq_query_status,
> +	.kiq_invalidate_tlbs = gfx_v9_0_kiq_invalidate_tlbs,
>   	.set_resources_size = 8,
>   	.map_queues_size = 7,
>   	.unmap_queues_size = 6,
>   	.query_status_size = 7,
> +	.invalidate_tlbs_size = 12,
>   };
>   
>   static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
