Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65959C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 10:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373CC20658
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 10:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="C/AVA5e8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373CC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1ACD6E2C4;
	Wed,  2 Sep 2020 10:08:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D355A6E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 10:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFr772RbivX9Q6ZYMn0G2PoP/ltTG1ZWj/SRoTAdWXUaDrqLeKufJMluqSV0B/EG3SbywLDjAf93t5fCfTffQFam9dU1u+YBRPcfYccKo1QRcp/uZFH+lGtnbBQkhRgMEizzJpmUGl5F0rpYfmYhmEB6LHzhuWbdYEfECkHqGEBDjCXRA7nuSZ8wXCcYwsBw+PlInt5fNLbe3bS+nFgpbej74ehRN2QRbBfdpvKl20Fqsdi+5VXrgJmVh9lG1LBALJ8Kxy3QEfkb6NZaGj0Wkdw2Su6pzCNpI7fnA4GFl/YKzOnT0aDNTDORfzZVPM0UuD4pr8qZuqSQm08jZGUpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDd1ROI3BgeHwEtUNdeKPphPYqko13k9EouIuNq6P5E=;
 b=AfEfhqek3vgvOHwCCItDx7w3u6L4RRyUF0QlY38TdmV5b/YgWpBPkphAbAOTrgR91pt1pnh4qxwVSqzaxCtMyAGEg88+9dzWy3/hxpPniCVYPUnjGAZBukSwu6qO3TRag3tez48Bjh3/VssrnPmupid6jaY9apNu6xI/kB002h8ohnYR7TsCQusz/NIlzD+cQl4jW50qHTGJXMfmT9ym2PUu+k3fusMBKyro91PT2PcudZrsqOQiKEh/QLsBXF4A88zlOGO5q+lYu4srJr4ZmEPK0LAOL85F1UIixrXTzBSALZnRroxtYo+lagMTs3Fc8Gt/g8v7eAOAmalvSIVdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDd1ROI3BgeHwEtUNdeKPphPYqko13k9EouIuNq6P5E=;
 b=C/AVA5e8oj1wERKsHeZ9uug9l0NihArL5k+x6FUO+0zwY0FdYEqQAzgvJJZWZnGDsclZdVYG71x650gr7zl7LLLwUpsXxwWd7Ej+u7sk81+eF1dyrD6N/N2KJxiDhzKqukX3QYXVoKmVhZIuWjvsFjMgFPwXTVuLCrNa4a/2M2k=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 10:08:06 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 10:08:06 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: disable gpu-sched load balance for uvd_enc
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200902100837.43353-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <ed2e1411-7883-b01b-b36e-2431e833af2e@amd.com>
Date: Wed, 2 Sep 2020 12:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200902100837.43353-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0027.eurprd03.prod.outlook.com
 (2603:10a6:205:2::40) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM4PR0302CA0027.eurprd03.prod.outlook.com (2603:10a6:205:2::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 10:08:04 +0000
X-Originating-IP: [217.86.127.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ab2a06b-beab-438d-2453-08d84f28160a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4404DDA7CFB875A6F33959838B2F0@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDdHBq6TRTPgOuYsZlZlghKFhOasOI2tZm25qXGrE+hazNdp2UfmJ9u/W1oWj4RObKG5fChNl6M2ZksPnyDbO7xzcdVooEpOWuAhcMXFMYhk5+BobkpoqrZ9UK8k2U9bLjzwQAWx5Aas+9kG9p95HA2slRzMLzf7QS8xKY2sctGCDmLNNneuPiP385ou58yOrZbw8rt0HVL/sM54IZxX2je0T9DVGOFLn89QYXoXekrtxy7VYFDfVVO/FnEwRbNXYTJ7fsraJ5BLZD51D234cP+Xadmm4d/qaGnWPzd1K30+aowq04xZtOI7dKesbdMR28mZUwQZ4Sf4Nxrt7MY3qok2Bm+7KoNMGJblnmYyFIQIhLqwy0hBuXkoUYLWQjoO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(186003)(53546011)(8676002)(16576012)(8936002)(316002)(31686004)(6486002)(66946007)(52116002)(66556008)(2906002)(26005)(66476007)(31696002)(956004)(36756003)(5660300002)(2616005)(478600001)(6666004)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IWmwl1oMogahJJH3Bpo9E/TzK35d1JWXcfE+SWzSYod/27Ifvd3HOlrKV4CnP1tkURMqaNwvRmk0kM1R0tCgSdXPTv1OnHn13Fuw14G4FtFvCIIGwjRJoOriWWzF2upVl+GaDBTTMJuGceeE3rMNuVqcsDbg8dBGaLR+HEEor2Dx4k+SePh2y1qOWlw4OLOqvT1iyGPrUeRSp1+lNljbYp+JZVwWBwjJbTJIKRp9ZOK5ILW7bbrL2/Zt/gd9Z9+O0qAx8QIrY1Iw7gh778dxoVG08Z5a0TLrPP/iioqNd/OCE4K7esxhDuCLXri/033+3SLmZmrZtx6mAk1+oUSv6g3tnqWEkBV6jN3Y4MZsvV2LAyXQeUQ6VbqJ8uDOzpOZPMb2HxR53MqCtf+2SI94qJVcCGTUFF2rhvKNSkIh9bt7Bw15Ea5Jd1ShAxVf3ucsIiSeuE5rAg0gVhR11a5ghfSqbR7US/ogapolbepBN+rT7XOiXQJDLK8OcmSstHgcZmW3SCSKowf2igmJXRhmq3wmmydIPig5w6Is4txoWaLU0qWmlC6aswifG28sb3pp2WpFN8wB6D3Ngo3ue4SjMaR9Y8Q5EIeJM/WAuCRR33SAf1IPM2UHnWy+Mqj22jDqrJaxuGfQfxqcY55rJGuT1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab2a06b-beab-438d-2453-08d84f28160a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 10:08:06.1613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJwJ6CMZqIiMuYUkz0IOj8nxTgHrjKg9KQuljtXaXRVBArwabVOXz7QyalfU06vXyXgmNZyFCDHVJWetDt9c4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
Cc: alexander.deucher@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Tianci.Yin@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please ignore this.

On 9/2/20 12:08 PM, Nirmoy Das wrote:
> On hardware with multiple uvd instances, dependent uvd_enc jobs
> may get scheduled to different uvd instances. Because uvd_enc
> jobs retain hw context, dependent jobs should always run on the
> same uvd instance. This patch disables GPU scheduler's load balancer
> for a context that binds jobs from same the context to a uvd
> instance.


from same the context --> from the same context

>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 7cd398d25498..c80d8339f58c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -114,8 +114,10 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
>   	num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>
> +	/* disable load balance if the hw engine retains context among dependent jobs */
>   	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
>   	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> +	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
>   	    hw_ip == AMDGPU_HW_IP_UVD) {
>   		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
> --
> 2.28.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
