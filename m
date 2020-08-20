Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1E4C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 00:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB44208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 00:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB44208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 064AB6E884;
	Thu, 20 Aug 2020 00:06:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C45CC6E884
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 00:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT2RtLc2KlJ/i7UId8ClsaP+iYwM+ijP+9JJU7EDZouTCagxlaRwTFyQTv2MCd1LAinD5UP5hnhlVWQzo0igpIim4aHXyeVVKYu2Hzb+4AAZN3aB9UXrJdymPFoAL1taMYeNTQPjb0lKWaVDf3WkXmHkjI33Qu08WY8lG0ILoiuGwqo6oPMiKbfxT9Zt2P8jwzv127Ekc1//b7wrYXfDPLlOOhLCDTck4/a5Ufe9gRjieFfC3UL9YmvpbGYjvLN4skqY+pcPrq10xaQCpNcaCdn+0cHvLHeQ9uIl/TpjRl/FIsqSh+X7bUPM0A31oJQoiPbCmdEJMDY5+ujs2KyluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJcxXFGYidv6WdbqSzqwcRS2pb9+XP+ptrwpFtPHmDc=;
 b=D0U/CAOYWJE5LfG51wzRPtGdHum94tfBD0rhNq7ze7pwJvLxhbXURRQt1Q5we8i6NmG+FcZMQZkk5YXCJ82XpKZk5zoHpNkDjQpLxp5FuzC/hL5gqVtsHSr7CHgUsqMF9uMLD802SkvROIK+yvCNkCVthKfafEPtPEnJqSxAA83Bt8z1cRkM69+pXm5kLp4RVr7moduI8D2kgh9MDfk37aqtOwIkZsAa7YAGCLExuJU1rOGr7AJlo7XQb+C3WHZwWctB2J+aisXhuzswYOVioFG7eJx+KXp7yRqW4sIaVFUVznsuAtjZ5J747o2OXBng9r2l25bLrp8rrX+LuU6fsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJcxXFGYidv6WdbqSzqwcRS2pb9+XP+ptrwpFtPHmDc=;
 b=Mtc3ix+EMN6QeNnjl6SYjjrCVFKR0xjavse97PoS83wHjSP8y/nhCZyhy6WKTOW/TANY4PC5YIyhgIYHBbFc53TzsmcJDCK9O5ImzXTjKA5XnBs5IpTVSBvUKyNprMlcU9kRiO2dZkEdpqjEwkY3H2SKtQlvK6/Iux8IQovhx1o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 00:06:13 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 00:06:13 +0000
Date: Thu, 20 Aug 2020 08:06:05 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remap hdp coherency registers for vi on
 carrizo
Message-ID: <20200820000605.GC215900@hr-amd>
References: <20200819142816.215812-1-ray.huang@amd.com>
 <197df017-d2a2-551a-7722-5f3c45de8544@amd.com>
 <20200819150132.GA215900@hr-amd>
 <4120f130-f068-f90d-a76e-b5717ad22780@amd.com>
Content-Disposition: inline
In-Reply-To: <4120f130-f068-f90d-a76e-b5717ad22780@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.15 via Frontend Transport; Thu, 20 Aug 2020 00:06:12 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d63ca9f-23f2-4e8a-8e71-08d8449cd9cc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB430128961E6E55E85C0DF3A6EC5A0@MN2PR12MB4301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LmYdYhYdrIUF6ccw7JprwPggRfeE2jmqXBj/vRPhzW4q9kYN715O+rdqrrM8E4tDquN9f48wxy4Iaff+N0mAgm8/vu5mow0IVkdBCURfAxrDWZ1PgqzzYNZboapZeiRHSxwwBls7QB6Hm4GP2jtMQD5CaVqWSESYRMrz6DyfqVhosO482XdROJaiCPIh4h10CXwhybIsrI8SLBIvg3sgc2vWkeeYCfCSAQ7/dnlb0wqbFefvXxRstoZGpNUeWvB9tWcr7R240XjTnvZmiqDIijtXp5G8FgR3z0LY/pp0Kjto6CHAi9jhSuO6pTI6ahUWaFlBIK/sTb2a/vz9undUoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(8936002)(54906003)(9686003)(2906002)(6862004)(6666004)(6636002)(186003)(16526019)(956004)(4326008)(33716001)(52116002)(55016002)(6496006)(478600001)(8676002)(66946007)(66476007)(66556008)(1076003)(5660300002)(26005)(316002)(33656002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OsSvLTtn+r6OQjlbPVYm35uu3XROi8WVFHcTqnDwtFqMWQ4ZtVXoZbeSC2LHzG2/eJ3qIcZUf7iYlR6xsgwSaLTno9nqiM56YX9P4n6GVnrRlMtHHs8g/w4JI9/TtOAczGZnCcmH7bc9utGdxQOhyoDwiuJaZSnEY3wzwBwUbk67RDeLTRiAaORyf9N6709xYSW5sEyNQKVoHHTgajgV062dP/qgdWz4fI58Zczs+k5q+E2iGfK918q7QNFbje9gG+xfPGvX4csuMGf4ZQAjIIRN62T3JSDtdA9tCGnt33nUJN0GLvpIU40ViBtRgnmJ48un4chZgkbNITIZthnoFkDJV9S5qEQZqeFzhin4uNNQHedgKcIkL2R5iJkKA8JGeCSHS/mp9VYBIth+q+Vpv5oH9DClgS82vQXYysB0nz4LsEqYgQgKL28dqI1xwpdEGrpAcnTom9J0RqlfmDU7grpPj8wxRsvQrDtFabZICwV9XPLAVx3zgwFLfqYJvcxaZTY8zp8O3UNgy0QmPIW9fkdiivGTFbbMt90NaayI704jxarZBBmutlz2fH1qv3CwKxrHUKmCD/U6dAle1KGL39/16fSlVtH7tw+uc0m942ksloOBAOPY1Ym+tIqGm30ypAi3FhBa5QrJT5Ihco2FBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d63ca9f-23f2-4e8a-8e71-08d8449cd9cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 00:06:13.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4w0Cenb4cMNGJpcUW7Q7bypo+cGWPkc18oHPyC9WBeoki/eOF5wL6hx1TOm59b+6p/lLGh1FR77Q+0sQlg+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 19, 2020 at 11:28:01PM +0800, Kuehling, Felix wrote:
> Am 2020-08-19 um 11:01 a.m. schrieb Huang Rui:
> > On Wed, Aug 19, 2020 at 10:36:05PM +0800, Kuehling, Felix wrote:
> >> Just for Carrizo, HDP flushing doesn't make a lot of sense because we
> >> don't use HDP to access the framebuffer.
> > OK, so soc15 and later need use HDP to access the framebuffer from user
> > space. May I know why?
> =

> On all dGPUs we access framebuffer through HDP. On APUs we access the
> carve-out directly in system memory and don't go through the PCIe BAR
> and HDP.
> =

> The MMIO-remapping is done to allow user mode to initiate HDP flushes. I
> don't remember why we only enable this on SOC15. Maybe we didn't know
> this was available on older ASICs, or maybe the user mode code to use
> this capability wasn't implemented on GFXv8.
> =


Thanks for the information.

> =

> >
> >> The code you're changing doesn't look Carrizo-specific, but VI-specifi=
c.
> >> So it would affect Fiji and Polaris as well. We already support Fiji a=
nd
> >> Polaris dGPUs with KFD, apparently without remapping HDP registers. Why
> >> is this change now needed for Carrizo?
> > Because I found thunk will allocate the memory with flag
> > KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP once I set ignore_crat. Then we fail=
ed
> > to allocate the buffer.
> =

> I think the same would happen on Fiji and Polaris. Can you confirm this?
> =

> I'm not opposed to this change, but the justification should not be
> Carrizo, but a more general GFXv8 statement.
> =


Sure, it's not for carrizo, I will modify the commit message. Let me find a
Fiji/Polaris card to double confirm.

Thanks,
Ray

> Regards,
> =A0 Felix
> =

> =

> >
> > Thanks,
> > Ray
> >
> >> Regards,
> >> =A0 Felix
> >>
> >> Am 2020-08-19 um 10:28 a.m. schrieb Huang Rui:
> >>> Carrzio also needs remap HDP_MEM_COHERENCY_FLUSH_CNTL and
> >>> HDP_REG_COHERENCY_FLUSH_CNTL to the empty page in mmio space. Then us=
er
> >>> mode is able to do flush hdp as well. It will used for force dgpu path
> >>> on carrizo.
> >>>
> >>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/vi.c | 18 +++++++++++++++---
> >>>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/am=
dgpu/vi.c
> >>> index af8986a55354..a540fe7cffc7 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>> @@ -78,6 +78,7 @@
> >>>  #include "dce_virtual.h"
> >>>  #include "mxgpu_vi.h"
> >>>  #include "amdgpu_dm.h"
> >>> +#include <uapi/linux/kfd_ioctl.h>
> >>>  =

> >>>  /*
> >>>   * Indirect registers accessor
> >>> @@ -944,10 +945,10 @@ static uint32_t vi_get_rev_id(struct amdgpu_dev=
ice *adev)
> >>>  static void vi_flush_hdp(struct amdgpu_device *adev, struct amdgpu_r=
ing *ring)
> >>>  {
> >>>  	if (!ring || !ring->funcs->emit_wreg) {
> >>> -		WREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
> >>> -		RREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL);
> >>> +		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUS=
H_CNTL) >> 2, 1);
> >>> +		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUS=
H_CNTL) >> 2);
> >>>  	} else {
> >>> -		amdgpu_ring_emit_wreg(ring, mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
> >>> +		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MM=
IO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 1);
> >>>  	}
> >>>  }
> >>>  =

> >>> @@ -1085,8 +1086,11 @@ static const struct amdgpu_asic_funcs vi_asic_=
funcs =3D
> >>>  =

> >>>  static int vi_common_early_init(void *handle)
> >>>  {
> >>> +#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
> >>>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>>  =

> >>> +	adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
> >>> +	adev->rmmio_remap.bus_addr =3D adev->rmmio_base + MMIO_REG_HOLE_OFF=
SET;
> >>>  	if (adev->flags & AMD_IS_APU) {
> >>>  		adev->smc_rreg =3D &cz_smc_rreg;
> >>>  		adev->smc_wreg =3D &cz_smc_wreg;
> >>> @@ -1332,6 +1336,12 @@ static int vi_common_sw_fini(void *handle)
> >>>  	return 0;
> >>>  }
> >>>  =

> >>> +static void vi_remap_hdp_registers(struct amdgpu_device *adev)
> >>> +{
> >>> +	WREG32(mmREMAP_HDP_MEM_FLUSH_CNTL, adev->rmmio_remap.reg_offset + K=
FD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> >>> +	WREG32(mmREMAP_HDP_REG_FLUSH_CNTL, adev->rmmio_remap.reg_offset + K=
FD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> >>> +}
> >>> +
> >>>  static int vi_common_hw_init(void *handle)
> >>>  {
> >>>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >>> @@ -1342,6 +1352,8 @@ static int vi_common_hw_init(void *handle)
> >>>  	vi_pcie_gen3_enable(adev);
> >>>  	/* enable aspm */
> >>>  	vi_program_aspm(adev);
> >>> +	/* remap hdp registers */
> >>> +	vi_remap_hdp_registers(adev);
> >>>  	/* enable the doorbell aperture */
> >>>  	vi_enable_doorbell_aperture(adev, true);
> >>>  =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
