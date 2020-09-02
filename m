Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76050C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 02:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9CA206F0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 02:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Lb1AZamA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9CA206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3F36E125;
	Wed,  2 Sep 2020 02:32:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0F46E125
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 02:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4OFHxauxdjc7T3mPFvYgG71mVkY6iQmHStvEZCergcTL6icGf8wpC3sl82Xy9+q/9teFqaugp9LazewTUQx0EG5MdJb34CmGdMDuMOphxLNeI7h3NoBUE+THDwy5uyPspLPAM4oR1jQ2i4mY3SLMOyFhNbClJazemsM4bh5gn2rB2svIvJIMFeXP6pF/xv0AeIZ2y4vupMVM6tNSp3TiPeO5jo427OVEzhE5UJAXnkn7qYKjMEEXjGRAGrl/48dfs1Vf05m+yonr+DcB64qJ59Wry0TrFDJuLAaPHNBJx+Aw/cAAZgpVntIWz9+8hUkvAjbgjhRrOuKTM9voITuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySkWFyhFsE5J1yWBtsclSggdBoKPNmgTc632AeMhtzc=;
 b=kToyy/n2Nr2u3WyWXpDsAzzfb4L+mSfUSOtJV/AUUxScLKYLeqPE/BLlGmo84wZW5Y6D7QyNHiqZRLp9Z+WadSkE6T5EiqA5OfpMymDzvf+O81HzoqrZ/+IEtXSno4lwv1PPYPan26yB2NzPSeHcgRcraoksxC1nB9n9ASduFzqjI2hYCaqSv37F3RBtjYmMNCb23qmKAQaG8K5QYuII8mh6NSQ4M8Pf9KnzNA/gHfWm6hz336h4UbU73j36y/40pxpJNmSrHZl/g2XHTg1Fn+oQVO3z3SVKgHvmRklbCuOJiYmNvyEZcuprn7nlZVFtjeUMVOFK7mFSIws54gMpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySkWFyhFsE5J1yWBtsclSggdBoKPNmgTc632AeMhtzc=;
 b=Lb1AZamAogZ4RjDFKncqREsCz9X5IaicQRbY1vK2DS+NTETHYlI/D+70B/Z62A0IUgSZ6pS32LdkpbeDP3wjli1TjNkhTeO5f28htnUl1BHGsHUeBmsdh4myfmcL/kpZXD+2quNhqmMcLQXReulwC9kr9lX7Va6I17VS73auV+I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:73::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 02:32:31 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 02:32:31 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc10: print client id string for gfxhub
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200901215125.1402033-1-alexander.deucher@amd.com>
 <20200901215125.1402033-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <e6cc8a4a-90e5-fe47-cab8-15ae730212a5@amd.com>
Date: Tue, 1 Sep 2020 22:32:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200901215125.1402033-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 02:32:31 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2b1a28c-2fcf-45fc-b1b1-08d84ee8716f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26870FBEA477C11FA4F93392922F0@SN6PR12MB2687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRGeDKsrXlj0FE9pdP0c+P/ey183kA743LKvCm+JaJwF7i0GUA2C0B4yzYeTW+Z97rbh8tJp17oD2NV1OYMwLWzf4A+eCk5dBZxK61lzpJdcibCtO2cmGGIh+RrXhkZmH1BabHUVsszEYluyGaBk884FBj1igwoKkJnJmcJJWlOeBL7kzY+vPzdLVdEKTNnU5eKhgPmOzF2KjPKIRQV86VrkvgYW8tVriBvGY0BXsFEl5xfBhzpQ8yEV4XOBaQDDCKf9huv0L+RoB3fM5G7lH3TJwfLiTA0KMBBKMqvqWVMmOOmVz7928yI/Wl+0vL11bf3Z4dOe96/HNlERNMb3TS5ZM9/ij+/Wwl9pjSMXdD6v+j8IxhFFwmn0DacHPi29
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(53546011)(52116002)(83380400001)(316002)(44832011)(26005)(478600001)(6486002)(66556008)(66476007)(66946007)(36916002)(86362001)(956004)(2616005)(31696002)(186003)(2906002)(31686004)(8936002)(16576012)(8676002)(36756003)(4326008)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mvI5HBRq3yLDcfYsDHi1elOf1aCbr0m4FAtxrnyCOSWn7Dcc+7smx3UK8V4r4HY85Aa7ZuKVAsx/2fCC0HhRtHhRB+6MRx96LPaxtzNRpDpF4JOgUB20oBNLIRXiRTmcG+YEy+vaZFJUAGD9V5B0SvIWf/QxgtXQjHnqurLJLnPhZrO+t4jtWflwjju0LUy/DZ30aSxwg48yikhF5bwhPmmctG0CeVQAW1D6HjZwG/naZgWfnuzrEBU+c0vf/5w89O5BLp8K8V/XKkP2GVUDtvsCAHpMcVz66XHZ8T/+WjtKC3iCRRFRHXSc2YbmwuVQRY6iLWCQcmZqNn0wcPDpIwEDgRnQUvm4VzFwBPsUwoc48ZvV78/2jVRoiJYsJczwD2PIDXiASPlYRoY6NkJRKFvBdf+sE6eqs1dfB2zRBdrYWhLRNypBSTrVtBiKG5AtejWFqma7rIj2m/BHQT6xfRgwZpWYNjeAcSGtEqJ8Z4ZC0Z6bF7ZjcNu/r5bdX1e7Aw/WbuvC+78zo3t7VpUz5lKZ4cPrvedkcd/jAjLuXH3N/JZT7ysjJhWBqc1YQ1OGUoAEdL4l5KOS9GL8vcO5zHDBOeLoZMJEe4m3JEQwp8fE3mW0llyE+Mv6eSQwZSgSKLK/qfCUaI6/G5M5xx9TBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b1a28c-2fcf-45fc-b1b1-08d84ee8716f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 02:32:31.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYNsPYtdetICAywIkf4P7d3DDa5XHOOGSzXGSBdcl14oFpbonF3RF8TB/rAYGeKbhtoYzvK5S15ri8TnrXKDFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Should there a corresponding change in mmhub_v2_0.c?

Other than that, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

On 2020-09-01 5:51 p.m., Alex Deucher wrote:
> Print the name of the client rather than the number.  This
> makes it easier to debug what block is causing the fault.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 30 +++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 30 +++++++++++++++++++++---
>   2 files changed, 54 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index 76acd7f7723e..b882ac59879a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -31,6 +31,27 @@
>   
>   #include "soc15_common.h"
>   
> +static const char *gfxhub_client_ids[] = {
> +	"CB/DB",
> +	"Reserved",
> +	"GE1",
> +	"GE2",
> +	"CPF",
> +	"CPC",
> +	"CPG",
> +	"RLC",
> +	"TCP",
> +	"SQC (inst)",
> +	"SQC (data)",
> +	"SQG",
> +	"Reserved",
> +	"SDMA0",
> +	"SDMA1",
> +	"GCR",
> +	"SDMA2",
> +	"SDMA3",
> +};
> +
>   static uint32_t gfxhub_v2_0_get_invalidate_req(unsigned int vmid,
>   					       uint32_t flush_type)
>   {
> @@ -55,12 +76,15 @@ static void
>   gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
>   					     uint32_t status)
>   {
> +	u32 cid = REG_GET_FIELD(status,
> +				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
> +
>   	dev_err(adev->dev,
>   		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>   		status);
> -	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> -		REG_GET_FIELD(status,
> -		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
> +		cid);
>   	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>   		REG_GET_FIELD(status,
>   		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> index 80c906a0383f..237a9ff5afa0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
> @@ -31,6 +31,27 @@
>   
>   #include "soc15_common.h"
>   
> +static const char *gfxhub_client_ids[] = {
> +	"CB/DB",
> +	"Reserved",
> +	"GE1",
> +	"GE2",
> +	"CPF",
> +	"CPC",
> +	"CPG",
> +	"RLC",
> +	"TCP",
> +	"SQC (inst)",
> +	"SQC (data)",
> +	"SQG",
> +	"Reserved",
> +	"SDMA0",
> +	"SDMA1",
> +	"GCR",
> +	"SDMA2",
> +	"SDMA3",
> +};
> +
>   static uint32_t gfxhub_v2_1_get_invalidate_req(unsigned int vmid,
>   					       uint32_t flush_type)
>   {
> @@ -55,12 +76,15 @@ static void
>   gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
>   					     uint32_t status)
>   {
> +	u32 cid = REG_GET_FIELD(status,
> +				GCVM_L2_PROTECTION_FAULT_STATUS, CID);
> +
>   	dev_err(adev->dev,
>   		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>   		status);
> -	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
> -		REG_GET_FIELD(status,
> -		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
> +	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
> +		cid >= ARRAY_SIZE(gfxhub_client_ids) ? "unknown" : gfxhub_client_ids[cid],
> +		cid);
>   	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
>   		REG_GET_FIELD(status,
>   		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
