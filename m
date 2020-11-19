Return-Path: <SRS0=HxJR=EZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060CAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 10:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C6B246D3
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 10:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RcIzdhR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C6B246D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1166E5B2;
	Thu, 19 Nov 2020 10:36:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0AD66E5B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2020 10:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdG7vW364hYhLlg/fFcyANdEOS6G6JzYHU+cLDBrUwvl+XWd/FMk6bzFNJjb4SGQqYgExTvsAqfRrFhA2WY4WF4+/Hd4aWbyHIG1qEu03ID6ZgL+dk5wsNQrmNpcG2ngcByVoA0vOqgqIYG6Ef8UjbLdpGUXhGCG99d3C+SFW3xhoiV1YWGk7jpLEIE0p5SDqGp8nBS4PpAYhexkaBrkFzpYv8rWjqiPJaodu/ISRyDSnt34axlwHzXE6TFkCJKhaD0xXdtFKcxowJ/yPEMZmFJPnjp8Zp3Oba0Xv4LmuAua3RItT1Zm6d2DBpTPVZ6Kvf24yChyAfvxmNqvW0LQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oqM7vVmMDBOmmuKDHfMTzEtBWT0Ol+ozD87ZN9YDto=;
 b=ivKvCvtDoxm16wZrLox/pVxz5fNiEbdIrVVG8dbEAYT5ocCaaUwu/2dRUb7NjJ5a+pwYdm7I2xEHvfnSKzy7PVszpvKtXa6d0vgFzjIcuXa4KOKblyGPbJ3aInNA3mXjQhVS56l3zMmuQPk/PdcO4ycP0t5tWaQs+qC4i6Pov+eV02WPl4Ug0Ce2rwOJFAbFW9lODsQVBwMz9niKVR0a2KGkTXn7g8KsxCLaXwhI3Frfm4yWhNGXg+UyWh8Cx7jj/EGTXpmi+HBydJUeht7+QEgdNg1lMC/F1JkQ7DGbpayJF4XhSElr29eD6JW6zTWPa8GFD7nSMZIkKViKdTDT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oqM7vVmMDBOmmuKDHfMTzEtBWT0Ol+ozD87ZN9YDto=;
 b=RcIzdhR6UZa668vFOGqwRRGzkYEXQYK8FhSBqXBtmmfrI01lXnJYd9Fi4apa/dLqcOXproZd95TQbAEB3Km5RZcc70zBSUa2Rdf/PTyFpvWIhISAiiUmzT5eMs6fW/cgsqw1Yar/uEtamewJkMKiyM3kryTE1cxwgaGvCLoacWg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Thu, 19 Nov
 2020 10:36:34 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3589.021; Thu, 19 Nov 2020
 10:36:34 +0000
Date: Thu, 19 Nov 2020 18:36:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add gfx doorbell setting for Vangogh
Message-ID: <20201119103624.GB2562865@hr-amd>
References: <20201118120905.1473-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20201118120905.1473-1-Jinzhou.Su@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0160.apcprd02.prod.outlook.com (2603:1096:201:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 10:36:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6bd9fe6-82ba-427e-235b-08d88c76fc1d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB23966BEBABB03A0B95281EC3ECE00@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARWZy5gIDRT2xJbVYzOH6CfzdDILM7B79GGbrK+AmAqoaPpogG4FMK9laf+VYMYiUYHiT2S48zb3D+gLnlhMRcocoULGg/V7uJIOvVMQOsn+SstXYv4HPHYbxlz2+JJSRZROagZquIacW+QB7V02HW4w356+6xqhBFdf/8y9ztIYvUH3x1hw5Ug7IwNDJya3HVblI7FexTvpbc+TarYSMRlUyjYHF3+VFpVqtVCT2v6Drtik7LoaQZTkaIWw306wazWRsOnvcxMOpXloKnQxsXDHJQHOBr2Dxo8C0sMviH2Mv3k2wQ1F/HuyGRzCMzwbOzfSCQw/fSSUG3vIuHs4Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(33716001)(33656002)(5660300002)(478600001)(52116002)(6496006)(26005)(2906002)(6636002)(54906003)(1076003)(6862004)(83380400001)(16526019)(55016002)(8676002)(8936002)(4326008)(66556008)(66476007)(316002)(6666004)(86362001)(66946007)(956004)(9686003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HPBSJi2P1eD/dVncR8tfIkpAOF7BK+xteh3l5lVjwXiMDeWlth9tKtXrT3ZreIj7fI8ltI8f6nKn2e1HZ7D5esFa0wt8FfH8wy4DpX0FUoYp3MxvMGMPDHCCwic8yjQSsqQqpjvsFE3+5AvNvRwHk9A/f3XjcsNDpQ4wwUJolkF0e4h5oKTnFGpEGC99PUEnum9xi2bm774IMo1CvYcQ4EDj67AD8qoHvOY7JKuTrIn5O7YTQoIpP/rxuYZdlqRsXGNJjx0y8YnrTR15KB0jZ9gmpoDbG17Mjz8ZlygMQzPvJ3TyjnqOjx9pd0158ZnWH2UcWufMDIRtDj1WBAjVjvIomw4qpBq4U2d1ZpNDJPF9LSbGoiS4UW7vx/Dp9D+x+J/GHORSP/6OIFmI++bDhWVuNgCKBR6NIQpyeXClPp2TNLFNrlbzOrOsfdpLPVzTPFjWuLmkHt/Pw0O09y4lk7jlHBuniOA3bzNovERFCK2vhYEI9owyofyrh5PXUYqkBRmDCg2Fm+AUzX84lXN7RG/EjR2bByMWsuM9PipMirC9TRlq+jQj4HoLpPjTsxkHYAJvXZ67dQYg7MJ7ciLzvssr55FhTJzarONOVndhFnK+XxqNVf8/ByCXc+LG0EDiha/eCdd8gdBBOLvLrv6leTtMhnq2DFamZjcF/IMpUmKOJoXJ8xiyZphbMOM9MOo0OhthFTgb61cKtpM3r9Un9SsPojeI4TIqi9awV9GA6zyvS6kav7D86J0z2mbXbkbn6ds3HyL/ObFxKs6yAxc0kAcx7Y7auxW0gIZlGYS1FCnUwfzxX4KVWWl0IEC40wKTgSy2Ut7pYBl1sEx/0i4/vjJur3/9EcAnUvRxzPVp8YUN5CXkeJd7GmuPolXg5h4EaX0xooldcIrKLWEmdgUi6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bd9fe6-82ba-427e-235b-08d88c76fc1d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 10:36:34.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZos62prjJffRnKHj+iswDK3url6AIEDMdDKoOf7gZbTDnq4Gm3PWU6ktej8I/VLNCAa4xUkbecSUp/VvY5lEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: "Kamliya, Prakash" <Prakash.Kamliya@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 18, 2020 at 08:09:05PM +0800, Su, Jinzhou (Joe) wrote:
> Using KIQ to map GFX queues instead of MMIO for gfx async ring,
> add missing doorbell range setting.
> 
> Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index a6d03931f7fa..9b4e5d53432f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5995,17 +5995,19 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
>  {
>  	u32 tmp;
>  
> -	tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
> -	if (ring->use_doorbell) {
> -		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> -				    DOORBELL_OFFSET, ring->doorbell_index);
> -		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> -				    DOORBELL_EN, 1);
> -	} else {
> -		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> -				    DOORBELL_EN, 0);
> +	if (!amdgpu_async_gfx_ring) {
> +	    tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);

Please use checkpatch.pl to fix the code style issue. And double check it
on SIENNA CICHLID card.

Thanks,
Ray

> +	    if (ring->use_doorbell) {
> +		    tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> +				        DOORBELL_OFFSET, ring->doorbell_index);
> +		    tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> +				        DOORBELL_EN, 1);
> +	    } else {
> +		    tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
> +				        DOORBELL_EN, 0);
> +	    }
> +	    WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
>  	}
> -	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
>  	switch (adev->asic_type) {
>  	case CHIP_SIENNA_CICHLID:
>  	case CHIP_NAVY_FLOUNDER:
> @@ -6349,6 +6351,8 @@ static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
>  				    DOORBELL_EN, 0);
>  	mqd->cp_rb_doorbell_control = tmp;
>  
> +	/* set doorbell range */
> +	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
>  	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
>  	ring->wptr = 0;
>  	mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_RPTR);
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
