Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B33C33CA9
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 04:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FC8217BA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 04:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1ucIpcgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC8217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C7DE89337;
	Tue, 14 Jan 2020 04:20:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D18389337
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 04:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWWqQSW8tAsoWoi8uTPlE3ieErJzNpKtNuL9UOmcAipHm7PqDkFGWzF3jEfut2UFDSATm8xpLG0bXqHt8aHoYZGzcTNbVra6+89ktPp4nvMZBnJE1wcAFbFae5OXt2b3n6uxa6u58bc1eEJROsS6pYMNVlRGY0FnOUy2jigK5nRfdRp8dReT8a9MF+ueSZA1gKTNBHSWgws8hW7jwi9hqmnn2RZwZ3vGw2kVoHDdQ9dz8Lr+ozqtlfzwPslXpewiSERP9iUPAjo1kUA9FVSskD1EQGFYTi4aIk3Gkmja0BBmKB0PMGoxvJTvf3z30I1VgMSAesAzshmkuL39rM3+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QyuPtkeIFLFmbKPziAp38togbxW/mQxTNQF5uhKkdY=;
 b=jpGrbdoUAv2KBUNVo0i+KLuRuFsoE6TpuoVUe5/x+uEXRimhWkzCRYPBVA3wsnjM9l9X2DWWLqLLivw+19BTOe8gTNILrwT8C4DD90TLgtcaL1ETPflH51ldtMeuj/JTo0wlM2Kpr+F95Pc9RXwOJwFetNoeSbsNYdPixxbGMZyi1FfoM/CubigfNE6sMAhDHMUWSf+nhHOvBaSMy5zTk0BIpbL6PB/dEsTNGygKuSCP9Hzu4I8mCiGjf/bUO07HftQt9X3szInpYFJBFZv1wUNg+UqL787qketlfSxFtzH+324rLtEUvh84lzhXpkBQRW9JfMGtrgi3OTH+4mB0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QyuPtkeIFLFmbKPziAp38togbxW/mQxTNQF5uhKkdY=;
 b=1ucIpcguwu40clSMPOSNYAG7ptrm0lSxpjn0NdYvXwFHvlT86MgOb64JDOl5nTLdsVSHMzu2sl5RfIzcrCYYilDeV1KY0uOOhfLL1JH5Dr61vv1bmZ9htzEFC7G2oox5GBiW+NpZCMKBW9SMJLagTd0DmoaQqVqGM0QWDYKLJ6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4237.namprd12.prod.outlook.com (52.135.49.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Tue, 14 Jan 2020 04:20:14 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 04:20:13 +0000
Date: Tue, 14 Jan 2020 12:20:06 +0800
From: Huang Rui <ray.huang@amd.com>
To: chen gong <curry.gong@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add kiq version interface for RREG32
Message-ID: <20200114042005.GA13044@jenkins-Celadon-RN>
References: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
 <20200113155636.GC4021@jenkins-Celadon-RN>
Content-Disposition: inline
In-Reply-To: <20200113155636.GC4021@jenkins-Celadon-RN>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR02CA0152.apcprd02.prod.outlook.com (2603:1096:201:1f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Tue, 14 Jan 2020 04:20:11 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b7b23bd-7223-4cd9-337c-08d798a90d35
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:|MN2PR12MB4237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB423795A7E280EE1DCA852971EC340@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(199004)(189003)(33716001)(8676002)(966005)(6636002)(16526019)(66946007)(4326008)(316002)(6862004)(2906002)(186003)(26005)(478600001)(52116002)(6496006)(86362001)(45080400002)(33656002)(9686003)(6666004)(1076003)(8936002)(66476007)(5660300002)(81166006)(66556008)(55016002)(81156014)(54906003)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4237;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANzEipgk50dhvD2XlkMCvytPQBrPUhcNL/ny8C5VR5I51eFJDWgY0X4kwMId1bQKLGcnX0gFWYJ+hIHnK59OWYOWYkTxevR8ZKz1qgAh2igbOhht1iAPtbHxrlobADwAfOfIbvzSanQ7Zu1y9OJDzgfKIfZT7AGZtarMT4oC5SMSvUnY8zRnGARaV6aNoohWXP3L0Ile8LBwg37XsS6TGqi3hr9NLKVh6Sgc1ZnCiyLPjNWOUnq+K888ryaN23jSG0PHOxiUMyee8nVS/AMNw3ykRQDb6EXDg6XDZI4om3NZjfUhsSyt4h2N/i+5Xh+Pu+dYe2Mdz9ZoOS/chGHv54rv1l0rtHAkCFxlUB5xR2fiwtb6c5O9VsTUKOMhmU1dHRmSGo+YO9hwC4dpmB6uL6x9HsbLfa2UGMetN4znoASoYU41HdCFGDITSmDvAZpxRtaKj6Wp4EVdvRVZVW5WuZ09jBtJCgqMER3g5ndYNFg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7b23bd-7223-4cd9-337c-08d798a90d35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 04:20:13.7198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPvN2mi16daFGk0TqXebqHLcIhVMm9sFdmd0QAHaBJsaWfuebYgMw4OzEJxp3BM7x/A4PdhyY19V3XzAKPJl/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 13, 2020 at 11:56:46PM +0800, Huang Rui wrote:
> On Mon, Jan 13, 2020 at 06:16:21PM +0800, chen gong wrote:
> > Reading some registers by mmio will result in hang when GPU is in
> > "gfxoff" state.
> > 
> > This problem can be solved by GPU in "ring command packages" way.
> > 
> > Signed-off-by: chen gong <curry.gong@amd.com>
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 63eab0c..92c5ee4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1016,10 +1016,13 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
> >  
> >  #define AMDGPU_REGS_IDX       (1<<0)
> >  #define AMDGPU_REGS_NO_KIQ    (1<<1)
> > +#define AMDGPU_REGS_KIQ       (1<<2)
> >  
> >  #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
> >  #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
> >  
> > +#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
> > +
> >  #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
> >  #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
> >  
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 2c64d2a..4045b56 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
> >  {
> >  	uint32_t ret;
> >  
> > -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> > +	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
> >  		return amdgpu_virt_kiq_rreg(adev, reg);

Hi Curry,

I read this patch again, we would better move the
amdgpu_virt_kiq_rreg/amdgpu_virt_kiq_wreg out of amdgpu_virt to amdgpu.h.

Because these functions are not only used for virtualization but also for
the case while gfxoff enabled. We will continue using this interface
instead of MMIO access in KFD driver as well.

Thanks,
Ray

> >  
> >  	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C30ace3a1329f439cb69508d79811d5aa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145074676514100&amp;sdata=t6rAUcThU9cmcu5Rwh%2BuHFDtj7Yie4tRN%2FgF2OSBZ00%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
