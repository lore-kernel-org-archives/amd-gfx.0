Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1706AC3F2D7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91702073B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qUZcG7p8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91702073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6B16EBE9;
	Thu,  5 Mar 2020 16:10:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022616EBDF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxPZRulAh0AZOS+ITN2ZCunSepMUawZaj/QNXe5p+A2cj2BEC4AYwTCi81384n3aD7XB90zxTPnV6iLpOgUcT2jiP+ttO4q6WuruU8Z6phpHBFAul5cINbG8HKxoYpgmj2MG9aBtOvUfEJySIYpQFzu70rSY0EC4Hl0dK3cdO5+De24WIvMoJs6YePP+bCQT1IHJnbL/d2cQjeYmNvJ/KXydZaMsaaLJYoFw90xCiu/1l0pEGrRPtM4Z5OwaK3RZ68UpLEaWb3A+u//+1jsauP7ZRBNIJFa0KijbOOP3KFBTRG8HOKCXzuqE+eGyu/eRqkCPuGTjaYhU+DnEmt5Mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPep4iLDOJnKnw8cd+ipyEl3WNFtu0I3HL1Gs5Bzi8s=;
 b=WXvEEK1X4gBARPBKHXlc5T118LxRMTgticEStiqAL4jvqrwgSDjFBoniYxzOF9dbj9nP5s9+JiFRdqaadHJCno+ObDbalN5Qi63R31d7pWJCexYcTMgSPne+lBilXa9wkWp5IgoCKCwxfpbw882ByjqRzPqeIbICoG38NIPeVx5NhUyg36uvFEyVy/BLxLcTyCI2myvo4vjnvhnskoEaLWk9/8l1KyxmgHi62kO7w6PnI+bBJ6JlwWPCYp5LDbsOGpbXu8QI4XJTZypRneF49c6qi+ZaiRNMAgyj5/E+2jpM4F8UDoZVO/bt/qoEJgNRiTjZNzmx4cgKt1jvPjpkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPep4iLDOJnKnw8cd+ipyEl3WNFtu0I3HL1Gs5Bzi8s=;
 b=qUZcG7p8onGlZFubW3lAvVvYyo3APbJ+Y1YaNd3c8jy78gs3D51yjucpvS/1vHIcatb+9BG5Z7AAdteCy4llLlbytBRMKwxuOXYTbHGsGfuUmstwbV/CH9HsLmt8W5aKHxp4sCl4I1X3l4ZIY4bxS9bi4NLTDd3frFpUlJNf3y0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 16:10:37 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 16:10:37 +0000
Subject: Re: [enable VCN2.0 for NV12 SRIOV 4/6] drm/amdgpu: cleanup ring/ib
 test for SRIOV vcn2.0
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-4-git-send-email-Monk.Liu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <e42ebba7-b830-4b07-32f9-32b8180b484e@amd.com>
Date: Thu, 5 Mar 2020 11:10:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1583415187-16594-4-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:917c:58ca:660b:c965]
 (2607:fea8:a200:445:917c:58ca:660b:c965) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Thu, 5 Mar 2020 16:10:36 +0000
X-Originating-IP: [2607:fea8:a200:445:917c:58ca:660b:c965]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50adcd68-f88e-42b3-fe08-08d7c11fbdef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4155:|DM6PR12MB4155:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41553264A7CAC041F4CF76DBE5E20@DM6PR12MB4155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(189003)(199004)(66476007)(66946007)(66556008)(44832011)(316002)(8936002)(2616005)(478600001)(31696002)(8676002)(81156014)(52116002)(81166006)(31686004)(186003)(6486002)(36756003)(53546011)(86362001)(5660300002)(2906002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4155;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVG8YfrqvKnCB0dPYhesDcRqJQCTN6mPPpnnvC9RZYe/JYb1hafOVwZbL5vTMeURA+Nas+qZebR3mrwPu9d77zmKTp/i+jZBndw1xd+6R/RneMwwk1znf1Bt/aN+5cC6vOjvL2g0VcM3y18C7qtKDWkXiMCBXCqpwYMHaprCtPkOwl2N7e14myPN3hW4RZ1hHv94CL4qViqiWQ/2sxpj7DTHSQHNL/qu1birf+dUmdo29xV1udcZThNP9JfwOZiNDR4Z7XREUlaM/9ZEZAadnyWgqDxQW+1qMAmpquDuZZwHc9tNXbz/6MLfVo9FbJ2wbnXMOVioX86cIauXTF49/ZyD1+y1Mf4wbdtvXq6pvQR71YQ4ZcXOsLyeZdJzA9f42abfPHRGgv76j83CzlDX4mxIubrhO1C/oUfLlj8t9NrtyKY/AIZOtm1Hn5TIuKPR
X-MS-Exchange-AntiSpam-MessageData: WfVQLEbjfPGFXLjcZleKVpIFHoumU8MFB7j5TxALlJn4OKkcO/gVPsjLbGnuck+xeIW1aXsVOLzPicEBjDoakhBNfYV8PIWwjeMDjTvcW+62blGTT5yDZ2ZsyzdddNqM82P6F6qbEyHUJ1J9Wd694Ur1TUd92UA4IhBWMzqHVszGtGYRbBiEKvG0zVosH1/qEq/5VlJWsF6Y8tQB4QZ4PA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50adcd68-f88e-42b3-fe08-08d7c11fbdef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 16:10:37.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0Sb4EBOA6mUH3NZoHf83On3Zcg5oIf7olUDsdiCKkEJ9VjQAH5WiPSl19TonzYZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

This patch is:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2020-03-05 8:33 a.m., Monk Liu wrote:
> support IB test on dec/enc ring
> disable ring test on dec/enc ring (MMSCH limitation)
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 11 +++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 +++
>   2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index f96464e..ae9754f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -497,10 +497,6 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	struct dma_fence *fence;
>   	long r;
>   
> -	/* temporarily disable ib test for sriov */
> -	if (amdgpu_sriov_vf(adev))
> -		return 0;
> -
>   	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL);
>   	if (r)
>   		goto error;
> @@ -527,6 +523,9 @@ int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	r = amdgpu_ring_alloc(ring, 16);
>   	if (r)
>   		return r;
> @@ -661,10 +660,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	struct amdgpu_bo *bo = NULL;
>   	long r;
>   
> -	/* temporarily disable ib test for sriov */
> -	if (amdgpu_sriov_vf(adev))
> -		return 0;
> -
>   	r = amdgpu_bo_create_reserved(ring->adev, 128 * 1024, PAGE_SIZE,
>   				      AMDGPU_GEM_DOMAIN_VRAM,
>   				      &bo, NULL, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 421e5bf..dd500d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1647,6 +1647,9 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
>   	r = amdgpu_ring_alloc(ring, 4);
>   	if (r)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
