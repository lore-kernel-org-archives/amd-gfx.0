Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298CCC3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2F2207FD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kgyZaJkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2F2207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B370B6E34D;
	Thu,  5 Mar 2020 16:16:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6CE6E34D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdM6RrlT8kGR0jzU3iOfG72J1mIJUHnMVQZqejT5n0tnlpkDC2MOP2hS/lDSFMyXybGDjSCvWtBz6ngf2QXcsEE6amFU4TeyGfH7jWOU6nyeiILdrDFh/VJr18uUkXjlL6igEpHrBT6FbBZtCFJCMvmBi+gvPjLiGYAC8Bz2+4VOTu6mKthBoQlCWHqOCdG33o0EPDXCU8JBFnfxh6WMCNLv6EFKP/YF9K+wphhx0d+X1YNI2HgtCllmziPr5eZuOPwdErEXrDAMgw054wwFwT+LdYF3s41VB+1iqfs+NRRP6b7VCII8RXvMUXgI58+F/LvcZPmPTypniSwWlaSUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsOSEw4cttqzfKfLUPuv4oFNgmdjLaTVImEyf2FqTRA=;
 b=LyPV3+4UspOvyEBONvbnv82V4P2dlbsVduO7hEQgLVDIdrQY+vo7BePP0FWRn0y36XC3HXPRi5JUJeZv/nCW/EnZpYPs3/o/FzW08ia89YZGUMmuo9qwxskceMb4R/EFDT156zXufXtd7CBVnG3Y9hI6CnMsBacRlTF9uSLCw9Z/GnnPV5wiuycOmk9Al+zwV758Dw+IzKyKBzyQ4TRyiCacAVPtMm7977V4GAnR0kbvIDMviiTWoxLEjOhunFkg3jzLITfEbGmgZiba6bZMuhC5Ql3D2Ra77FH9LhbtaC5bCI1Cu+Nwy18IgMiuQLlypBA/L9NqzAm0yjXHWh8+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsOSEw4cttqzfKfLUPuv4oFNgmdjLaTVImEyf2FqTRA=;
 b=kgyZaJkF7ty1g7NLh2gafJl+ShWUJDVMSn8u+tmuDRJ7gyBvGgjZWG9lomISSbqynXIriQw7pXd0mOC6GYUxwi79WbPJtzUwSwxGYUiaIJ8xVbKwfqIOjYwPAJfV1DuBB3Ic/GsWsXXhdCxUXLs9GiKnFlWuPCRawYIgXSbtrdg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB3131.namprd12.prod.outlook.com (2603:10b6:5:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 16:16:50 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 16:16:50 +0000
Subject: Re: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <e3f3d158-49bc-7412-6e11-7a6977b7d714@amd.com>
Date: Thu, 5 Mar 2020 11:16:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:917c:58ca:660b:c965]
 (2607:fea8:a200:445:917c:58ca:660b:c965) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Thu, 5 Mar 2020 16:16:49 +0000
X-Originating-IP: [2607:fea8:a200:445:917c:58ca:660b:c965]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a36ac407-b7c5-4fc2-3b64-08d7c1209bf9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3131:|DM6PR12MB3131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB313141E35F93886DDB3E5679E5E20@DM6PR12MB3131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(5660300002)(2906002)(66556008)(66946007)(66476007)(36756003)(44832011)(2616005)(6486002)(81156014)(16526019)(8936002)(186003)(81166006)(8676002)(86362001)(53546011)(31696002)(316002)(478600001)(31686004)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3131;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHzcaz6txY3csqDzBxzo3vBy6C8rsteo998MNDnncHb/DIq609t4v2qOBlJIfclOn4+DH2vJkYy1H101wL69c/jFitjBQSE0mWAdpF4CInT34ANw1BB5Ak0+ipadinDfwGZ7/4Fr/3ATG3NRb9b4dAL5Qu2/1xISoAxMwcsN3QzBu+nft6zSbHHb41KEi06cnOiOdmyi391padUgJpyRBYNqaHQq5D7Bii6hECNwWsnhZCsRWdYIZsI4dUbq/gDKESvdT8cztth1MAME4iBD5bl88AZZ/FW/z4CQiT/xm68fthGfzBUDHAyWPoMWBU7LqAcmQB2JHvwT9ZsO31XsWD3Fds6DtQerfazQnI1cmYj2J39XsID/Ctq5CUJ15ihOiNHpuwzRp3H0FAbX236U9k/mp1/SYDCeNAjeUxTj2a0HNc5ecK9BE7k5dtsiVZVc
X-MS-Exchange-AntiSpam-MessageData: HW1J4tzLG/jcAo2hLZeiXxCgtQSOKi0FD2QEuv4JvFnwVSPev+ir+sZVyYMOzXv40uxS473TdvAGk9v4PhJi80UIsRp1kpY9h6NlCteFR73plwCYWTgqqx76DxaRl/PGhTC1CF9eTdQWGnRXPXGDhH/DxxMSLanZGHYGIoegy/rNy5qFvpxadILxGbYPS7U6eQpblIUCMIX8KS5QeRkH7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ac407-b7c5-4fc2-3b64-08d7c1209bf9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 16:16:50.2027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxLD2aZqO7IHXnGhKS8hRVtKPBDkFeDkPJdRaD3ICW1pJA9wPUGjecWBx11fpsjq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3131
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

Is this warning introduced by your patch 4?

On 2020-03-05 8:33 a.m., Monk Liu wrote:
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index ae9754f..a41272f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -493,7 +493,6 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> -	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence;
>   	long r;
>   
> @@ -655,7 +654,6 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
> -	struct amdgpu_device *adev = ring->adev;
>   	struct dma_fence *fence = NULL;
>   	struct amdgpu_bo *bo = NULL;
>   	long r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
