Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0E4C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FB52076C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kvgPAMFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FB52076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289846E995;
	Tue, 14 Jul 2020 15:12:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447746E995
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 15:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqCb66Nv/czqre+tO+0tMum6ReQZVoqW/DqAFEdO+7JA0Tj9pzVv7Wcu00ncNVRDJwYU0xkHBLXzvg1JTLI9/UgdYB8kJYn8CnasCWrYUSFRhz5NmjFG35eGSaX1azvwP0r/2Hj6nX3pffeSBh7mpSneauo9lB+ONaEUwkzj8Mu/gEs/yW5atXPMuYdHhU+Aw6YhFxYixUsnV6zKJ4T+0qt3djt2QsNAiY5bG+xR7EIH9onoxykog1271FUUP+vVT3FwulTLLirQwAVtldJg/Sa1V2gMgdi6lGMfmc680vu+S/aKX74HHUQRBUOKcjYrfRRI20f13A4pfYPkZOloEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSAnLFuCijNbwdbb+fVDlFB+ZSeilbR9i300HPfguXc=;
 b=i3vlfoIQzujnM1qBdoIBTOYPELHsUWMlrL4nS9fNg1qHSmytuYODdsDrzctRPs+ntLzIJ/iqpJPiCSYNIBXPpUV/4pYyJhI68heL///UaECORPnH/7KhRHX8dbfQiJhaHKZRm1pzUuHNCURC8WRg3QIemuNNsNbH4s8mZmm6n3/kUm86DiYdJEqad41Q6cnJlncCFK511fZCWHgaA8OeYopEap0G4iGvTkT09ZHApD4sOXkK3DVtLsY5OWG72r4CsWT5Lfds+ck+m/mi7t3NhS9mEvkB9DqwZi5FYhMqY65aaQ0w6erD88ix4Aqc/tk5gG01sCwBSyILHJxVXmbT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSAnLFuCijNbwdbb+fVDlFB+ZSeilbR9i300HPfguXc=;
 b=kvgPAMFg75wuUpBJ+BOyPMmEiilNPkjySJ6bjLwiwsptC1ydOg0iLhBeIuPM+FYGN6cAcphL7jnt1jSPoLLXaBjDAzGwUp1V0G11UQ+rgokbGgyhQ684T+SaqR/dWEAKJYcjez6zvzpff7dyfW+fWAHw388JP6Dwg3uMqYqnFsI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 15:12:36 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::f4f8:d7fb:5d5d:e4e6%4]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 15:12:36 +0000
Subject: Re: [PATCH 5/5] drm/amd/sriov skip vcn powergating and dec_ring_test
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org
References: <1594694830-7788-1-git-send-email-Jack.Zhang1@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <4ef6794f-2cad-fcb6-c860-68db6be76c9c@amd.com>
Date: Tue, 14 Jul 2020 11:12:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594694830-7788-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a3c0:203:107c:af05:3460:3e70]
 (2607:fea8:a3c0:203:107c:af05:3460:3e70) by
 YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Tue, 14 Jul 2020 15:12:36 +0000
X-Originating-IP: [2607:fea8:a3c0:203:107c:af05:3460:3e70]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b8cb49e-88d0-421a-d272-08d828085785
X-MS-TrafficTypeDiagnostic: DM6PR12MB4339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4339E9BB5DA4F35EAD75FFF3E5610@DM6PR12MB4339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSEWOwSH0wbIA65aviaGeKQv0I2ErlXKBFZfQNLr+PF/M1objHCxaCVMTbI+O0E7rPaGrHy+TNo4jBxS30vupMTQ/c0qjgxjNZJmGu8tU/p9jaIKYhSzVL7DpRA6t5/QZe07brYVe1X/DVg1R6KxOD18o5EO8rCHBC+FmOyQQSjBKfQE522He8NpneyTlgUDjzqU5rfOZDk+C0K4zhl3GlhYSvXgtpPNtYwfPdpVOlJHF2vaYyFiieTb5Pr0d2Sna5o1J52e4AmEixMcwpJB5W8zQf2DqasR6OmUr0iYSsiS8apK6j5BHv+x5o5QBi07v3JK720EdiJ3Ghfg4KsUlnyNz9Mqmpg0q/ZdE22zbfkGi/8HtZB6/tqo9niIQJwb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(83380400001)(31686004)(66946007)(86362001)(66476007)(8676002)(66556008)(186003)(53546011)(31696002)(478600001)(52116002)(16526019)(2906002)(36756003)(4326008)(2616005)(44832011)(8936002)(316002)(5660300002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ujzb6TUNC2H+WLyLlQrDfPjuPOqb2SBHlhK6dIRyiRn2Mvn3TBQ8En0HmfFDu9U8Z1gcUtyoewdmm797B7xKjVgnwwHZdByJYZ88mwhB3oIKJ59LarGn+fBQjS+KdNrbrR01MhJmRujtR+3tl5SkY4YsWtLLyjmt+k7dZtOKhHZOShShMJxgmN99LB7bxzuNlxYUs0EEZy9yVJMvhTHWjCUpr0xR2fdWVYvDhgvr26vVo+dAy/LBuwsjnA6Es+4Iq1N5PyQkVB76x8ArWK6m1mMZE6i3o96v52Ix39dbnh8nZ4rpIMvhlEAYNgmHfKm9FIuRFW29L78Gp0a0SfEiZ7aPqBcsfA0VmdKS+CijvDM13vdDCEXtUAfbeBllbtp8gL15iJotyRfvhkCDj2o8lf3481yTJdjvZMadtiIAvNx8NCP6IvNKprbHPiR4o/C0kKfOsy/v+OFf8oqX+sEz9JM3stX3E/xv8JCBUnfWBj7DDVYfBJPz5dKPz5+/ceVDNrWd8Yff8t6oX4DIWPXxkZReYjBm5jx4ooYGU+o7Uf5ksf3KmXd9RH1G0OIYRRQG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8cb49e-88d0-421a-d272-08d828085785
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 15:12:36.7921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9DynRUcGm0UPisaj3gdwCtY8Vq3elbVZEpccpFTo4Hfp484UHqsddK3sMg6q/Do
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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
Cc: Hawking.Zhang@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-07-13 10:47 p.m., Jack Zhang wrote:
> 1.Skip decode_ring test in VF, because VCN in SRIOV does not
> support direct register read/write.
>
> 2.Skip powergating configuration in hw fini because
> VCN3.0 SRIOV doesn't support powergating.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 17 +++++++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 15ff30c53e24..92a55e40bc48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -421,6 +421,10 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> +	/* VCN in SRIOV does not support direct register read/write */
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
>   	r = amdgpu_ring_alloc(ring, 3);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0a0ca10bf55b..8e5de9ed64f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -354,10 +354,13 @@ static int vcn_v3_0_hw_fini(void *handle)
>   
>   		ring = &adev->vcn.inst[i].ring_dec;
>   
> -		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +		if (amdgpu_sriov_vf(adev)) {
> +			/* for SRIOV, VM does not control PG state */
> +		}

It looks odd to me that only comments inside the bracket. Can you 
combine it to the "else if" line?


> else if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   			(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -			RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> +			RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
>   			vcn_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> +		}
>   
>   		ring->sched.ready = false;
>   
> @@ -1208,6 +1211,7 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +

Why do you add an empty line here?

Regards,

Leo



>   static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   {
>   	int i, j;
> @@ -1861,6 +1865,15 @@ static int vcn_v3_0_set_powergating_state(void *handle,
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int ret;
>   
> +	/* for SRIOV, guest should not control VCN Power-gating
> +	 * MMSCH FW should control Power-gating and clock-gating
> +	 * guest should avoid touching CGC and PG
> +	 */
> +	if (amdgpu_sriov_vf(adev)) {
> +		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		return 0;
> +	}
> +
>   	if(state == adev->vcn.cur_state)
>   		return 0;
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
