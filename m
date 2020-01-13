Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEBC33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 15:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7495120678
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 15:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xtUjgwRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7495120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D7E06E101;
	Mon, 13 Jan 2020 15:56:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B906E101
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 15:56:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYMnTRiJZDPvP1Q6NlQRUjb/kfF6FWjFjBi1g4meM7OET/s0SwWTeGqx8wNPalwvZxiQEKT6Zyj67oowmirWLQSdiNyb0bz/TCFwa0UBSGQDiibx3NVZfyjaAK1H6xEMH5tIifGjasDBhd47YYZZY8JSXa3UcW03pvolpDB5gjKBP5gLAz3SkD7izJXLM4A3s3aim93PYSGJAC1PNY8i42sy8IbvOu63tD3bXEc99Lpg/m38Vae9v6OKyZaifdjSjxZU3h9VAz8N/7uM9uvci2IcK3CUCjMdxfvVHI1XKqYz1XJpdZ+qijfgmwB+ffOPdMekfAOqOPQcXgQuHKhuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdJjLJTRjvihboA9QskYye7xuKxpiONZRrH+hXmZLXc=;
 b=XeDNdZov0/Z74RfPdbEBjzeb5jfi0MGWM1bF7S+G0dz7WAkFy/NfzLTPQYCrDcbyrNpnOl/LV7vakrXHunbc281h3HvQpDlv31yEk6PSwooSSBY5a+OQZbCWxqSMPObzKlN/bn9b9bHzTpMYZOkXIktx5kiFQgXUDV/XMMdI0e5ZXo0YxpaDFEaLqputTKeYkW68l70sBl0A3YUo6lutH0j0M7lRkPYubRk8UtbxcZPde2ag+A6VSQZAxUG+02zcLPit6zMWeIBBTqlK3E8xk3ic/j8SeguvlWdCNnxLSw1y57/A6EB16yHESVV61c7N3ntK41KFTyBhYeCH7YeZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdJjLJTRjvihboA9QskYye7xuKxpiONZRrH+hXmZLXc=;
 b=xtUjgwRZwGF2q1CN297aciM5EdN0ga5eVTcE+fhjlbEK/J7PxCj2mkPw9rEal6YlbCNPSLOHVpppDcu+wuwZ4gjVTszQZ4EYpt2lCrFZRvWjwE0RzXnXCxKubik/4Bj6W+sMsaa2WfQAz8ZhHV+g1+hD0Cq+RzhnqqyiDLfnax4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3902.namprd12.prod.outlook.com (10.255.238.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 15:56:54 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 15:56:54 +0000
Date: Mon, 13 Jan 2020 23:56:46 +0800
From: Huang Rui <ray.huang@amd.com>
To: chen gong <curry.gong@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add kiq version interface for RREG32
Message-ID: <20200113155636.GC4021@jenkins-Celadon-RN>
References: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
Content-Disposition: inline
In-Reply-To: <1578910582-4505-1-git-send-email-curry.gong@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:202::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10 via Frontend Transport; Mon, 13 Jan 2020 15:56:52 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b387561-8792-4901-6a34-08d7984135c7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3902:|MN2PR12MB3902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3902BC8A31756BB6BA620A34EC350@MN2PR12MB3902.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(6862004)(26005)(33656002)(186003)(33716001)(1076003)(52116002)(6496006)(5660300002)(16526019)(6636002)(4326008)(316002)(9686003)(45080400002)(66556008)(66476007)(6666004)(956004)(81166006)(478600001)(966005)(8936002)(55016002)(66946007)(8676002)(2906002)(86362001)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3902;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVgHG9LPOdKqqvo8OMEAMufRUX0poeeABoLFAuorY8s1hojaG0K5qA54u2mE3ObCz4scWCqudzK/u1ATA8X26/s3exxsw0Xm3yoXY+Se4qLJEZ2Uo5w5Dl8+orVXOWGpKPFKAlo1TCHk3DT9WSkibomDXS1kTfgC8fsj9ZeO3EFLfBf++VKdGz3zyHuoM6BTnQnq0t2tw68fsiZPOgOAJw0lHMjVPB3w3pRi8uARIusA2nmStFVKSlgOzzuvrWtTeClmgz4ZOizt8pszbJp0W8HUaFzhZcyTe5epW5n4Sl31ZPR9IKV66D5Aqr9i5Z3IUvgGHlX6WARIOireygcLgS2S60optVVzlQ7cihrnVabPzwgQfHuOrqs37FExaT0AJgHgferZ7awZPq/YtUOk3DC/5V4tjXTtf+kiqTTd+Vp/OllHBIoB8IfeoW9BESd3Ef45OBX4oDodAPdw6Q1qmOoMW+0RLTEjjtUKDKPmIOM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b387561-8792-4901-6a34-08d7984135c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 15:56:54.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQeQ7KCSMmV4a/1DgPw5Wy8BipK+PD7hwhQsxL+HlSIsA4Jmkm/W97y/EC9SQMH26FfchaqAEnjD1+sM8PUrFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3902
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 13, 2020 at 06:16:21PM +0800, chen gong wrote:
> Reading some registers by mmio will result in hang when GPU is in
> "gfxoff" state.
> 
> This problem can be solved by GPU in "ring command packages" way.
> 
> Signed-off-by: chen gong <curry.gong@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 63eab0c..92c5ee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1016,10 +1016,13 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  
>  #define AMDGPU_REGS_IDX       (1<<0)
>  #define AMDGPU_REGS_NO_KIQ    (1<<1)
> +#define AMDGPU_REGS_KIQ       (1<<2)
>  
>  #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
>  #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
>  
> +#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
> +
>  #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
>  #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2c64d2a..4045b56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>  	uint32_t ret;
>  
> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
> +	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
>  		return amdgpu_virt_kiq_rreg(adev, reg);
>  
>  	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
> -- 
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cray.huang%40amd.com%7C30ace3a1329f439cb69508d79811d5aa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637145074676514100&amp;sdata=t6rAUcThU9cmcu5Rwh%2BuHFDtj7Yie4tRN%2FgF2OSBZ00%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
