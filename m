Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ED8C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 15:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B4E2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 15:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B4E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C946E17C;
	Wed, 19 Aug 2020 15:01:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271506E3AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 15:01:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxIf9iOX9OP63vkZCPXnU9gZjSfFWxSNl0P5wiD81TAFUjaj/e5My6DoPBBnDJajXW7JILge/aotuSu5uoTkuIPT+ruP9Iof6YHIfqUqIxmRpLOuBmBolYsm8phEenilHZtQn7CyPi3ZiLbPpofzKAsrjAlfLGQ9zR5qDY3gXGcu4yA+IzufxxYijrKtgplGdCEXRCwRX3Id4Vl/GVSb5KWoPCkBnfezd2D5ycJCHNQAV2fsTYgK+igoaCHN2CbmxeauYhyfctBVZtysebk9+lhPY454CSWNp177cs1uCOSYir5I8ux6sHVDQQVdy88os/qMfUkeH6nWfuM3B1HDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVVVdo3fQSSOb+WhxQPfKFpUWoDmPdsyoeDpZQNvaK0=;
 b=J2BWjfzjMcuED8WMU2SdIex+7szWIianUFAEbjthrPu5huhwqgWjKG43lDZJlz7O4euS2xDRkt29fDBDvcixNoDB9KBN2BFwQH9BxzDFsXXdB8McL8Vh1/XUbl4HJCXyXE7XviD96m9j1vGWzM4q6u5vHWSfv7LHiYMhCmd0i/R/zfyMmXdn9I79TZGC5oQGX6qpBJZr6cpWHK9ab1+3Ii0jhWxuJcEe8kaAcEemBvmrA9ycfrGPXFqR33zbJ/R4qjohrdAA4H7uxdm1kDG0s3DT1O5NVuEuulBZEI97f94oqbFqJ2GbjWpXwM1CJlK4JwkUPh8FyMzlhQapBUIVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVVVdo3fQSSOb+WhxQPfKFpUWoDmPdsyoeDpZQNvaK0=;
 b=w5ND/tNqlNS/AjQ8XtgpGZhOYQz83V11VbHcD7lDaUepzw2RZJ+6g78UyoogbYP64qSMGDvCmWEKMveAHw/kHlM2ONLigAj1m4cwWgM7uiRtp1jcoj7PqnDvzfHR47gVFEoohZHP7Cq6RY79JZWsj9M/bW36I+nD60lBllXOu3s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Wed, 19 Aug
 2020 15:01:42 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 15:01:41 +0000
Date: Wed, 19 Aug 2020 23:01:32 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH] drm/amdgpu: remap hdp coherency registers for vi on
 carrizo
Message-ID: <20200819150132.GA215900@hr-amd>
References: <20200819142816.215812-1-ray.huang@amd.com>
 <197df017-d2a2-551a-7722-5f3c45de8544@amd.com>
Content-Disposition: inline
In-Reply-To: <197df017-d2a2-551a-7722-5f3c45de8544@amd.com>
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.242) by
 HK2PR0401CA0024.apcprd04.prod.outlook.com (2603:1096:202:2::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 15:01:40 +0000
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc23496c-3296-439f-df24-08d84450c7ea
X-MS-TrafficTypeDiagnostic: MN2PR12MB4206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4206388AABE151619C6F3CAEEC5D0@MN2PR12MB4206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSmF22REyY3iJnQQFQyrlRT9QA/YP3PLu6WGSg4auHP9RTZHdmi8TNHcoISn+jQma0wcZ+BfV42/Ajoswa3bue+gzwhH4qBkCZMYBTxCkvvl/KVWx3qqY/cIDwzuKcokR0Gro66XIK7qJtpq+kbhp1NVZCkpTIh8BukPBZacpUdGosu2PAkGJ2YKiGypcsG7cJGiLKOjTBgsH0J3kbsZPHnDnluVPRrWhEsGtQT9DtNJw9r5CSTDNEYq3NrRN1tcUCOLfMiWcW5wb8D4lcyz0U+S43IzGkafCjLCaarA4lB9aNM2j6mVYaI1GGWnvwMZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(8936002)(6666004)(5660300002)(86362001)(6496006)(2906002)(186003)(16526019)(83380400001)(956004)(26005)(54906003)(33656002)(316002)(6862004)(478600001)(4326008)(66476007)(66556008)(9686003)(52116002)(55016002)(6636002)(33716001)(8676002)(66946007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1TgV2XpR9cJ2LARAQwMpzv4gh9FoLC5RGU5hB5OAdhqB2v4gyrDwfOSApMtedVY7SXkh/UM2ToGpFdBSJsN53NxlWvtX1OnBUV8Bq9qwnZXh9eLcy3Hv2cvrzn+u0ODeI9QxbOYwt7WSgD82p1ZMZarQITHJekzuZpo4QEdRap1yn6svmexhthGFf2Tm4DK25cCEIlKaKn2xbgcoZXTFy/5bsGYcBFHYrsfSvsPYKviduONxJXe18VqWwD5M6XlVQ1UasWw/03rrNRXNFQoSpTPaGRMvDyl9s9fIvUAwd4017oWCD1eNp+Y8yY05Hrx7apjM9kHlzds3XALdcITIZUCwhu6yJO3EZZZdp+6/O7SKFcKNXIgiPnV3iEbR6JGZ/1ls51q651L+NzaTI7sY6AgKFiMICTNp6rvplZP0q0PoFMuVJ6fbs8+xxrjXaEzrVGr6ig2KdNReZoeDbYJAml4C0uxJqDUua3FqPvqaToFqX+MXhi1+X5kdTRNhX9uH1EfnCadB5fZFx6BNKeM4Xupj2Nz5nrW8cwreFyMhGpNjkd3N3VEONuMSBcTQpCxSiYrV8e+8RT3++CjD8KXjVzG7rbipw0n/IET42sOhBtiJ3wKwdYCOP1tCVuQ1ZrubvokjyjnbPf5SAYZIWOVqQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc23496c-3296-439f-df24-08d84450c7ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 15:01:41.8724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcoKO+Ii4VtMKzWWyga0QC7KEZWgXpkZbZtiofHYqPSQqSrb1Li6N9UJkftwPob97iPBElpNC7f4zFNfMW3aRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

On Wed, Aug 19, 2020 at 10:36:05PM +0800, Kuehling, Felix wrote:
> Just for Carrizo, HDP flushing doesn't make a lot of sense because we
> don't use HDP to access the framebuffer.

OK, so soc15 and later need use HDP to access the framebuffer from user
space. May I know why?

> =

> The code you're changing doesn't look Carrizo-specific, but VI-specific.
> So it would affect Fiji and Polaris as well. We already support Fiji and
> Polaris dGPUs with KFD, apparently without remapping HDP registers. Why
> is this change now needed for Carrizo?

Because I found thunk will allocate the memory with flag
KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP once I set ignore_crat. Then we failed
to allocate the buffer.

Thanks,
Ray

> =

> Regards,
> =A0 Felix
> =

> Am 2020-08-19 um 10:28 a.m. schrieb Huang Rui:
> > Carrzio also needs remap HDP_MEM_COHERENCY_FLUSH_CNTL and
> > HDP_REG_COHERENCY_FLUSH_CNTL to the empty page in mmio space. Then user
> > mode is able to do flush hdp as well. It will used for force dgpu path
> > on carrizo.
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdg=
pu/vi.c
> > index af8986a55354..a540fe7cffc7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -78,6 +78,7 @@
> >  #include "dce_virtual.h"
> >  #include "mxgpu_vi.h"
> >  #include "amdgpu_dm.h"
> > +#include <uapi/linux/kfd_ioctl.h>
> >  =

> >  /*
> >   * Indirect registers accessor
> > @@ -944,10 +945,10 @@ static uint32_t vi_get_rev_id(struct amdgpu_devic=
e *adev)
> >  static void vi_flush_hdp(struct amdgpu_device *adev, struct amdgpu_rin=
g *ring)
> >  {
> >  	if (!ring || !ring->funcs->emit_wreg) {
> > -		WREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
> > -		RREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL);
> > +		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_=
CNTL) >> 2, 1);
> > +		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_=
CNTL) >> 2);
> >  	} else {
> > -		amdgpu_ring_emit_wreg(ring, mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
> > +		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO=
_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 1);
> >  	}
> >  }
> >  =

> > @@ -1085,8 +1086,11 @@ static const struct amdgpu_asic_funcs vi_asic_fu=
ncs =3D
> >  =

> >  static int vi_common_early_init(void *handle)
> >  {
> > +#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
> >  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >  =

> > +	adev->rmmio_remap.reg_offset =3D MMIO_REG_HOLE_OFFSET;
> > +	adev->rmmio_remap.bus_addr =3D adev->rmmio_base + MMIO_REG_HOLE_OFFSE=
T;
> >  	if (adev->flags & AMD_IS_APU) {
> >  		adev->smc_rreg =3D &cz_smc_rreg;
> >  		adev->smc_wreg =3D &cz_smc_wreg;
> > @@ -1332,6 +1336,12 @@ static int vi_common_sw_fini(void *handle)
> >  	return 0;
> >  }
> >  =

> > +static void vi_remap_hdp_registers(struct amdgpu_device *adev)
> > +{
> > +	WREG32(mmREMAP_HDP_MEM_FLUSH_CNTL, adev->rmmio_remap.reg_offset + KFD=
_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
> > +	WREG32(mmREMAP_HDP_REG_FLUSH_CNTL, adev->rmmio_remap.reg_offset + KFD=
_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
> > +}
> > +
> >  static int vi_common_hw_init(void *handle)
> >  {
> >  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > @@ -1342,6 +1352,8 @@ static int vi_common_hw_init(void *handle)
> >  	vi_pcie_gen3_enable(adev);
> >  	/* enable aspm */
> >  	vi_program_aspm(adev);
> > +	/* remap hdp registers */
> > +	vi_remap_hdp_registers(adev);
> >  	/* enable the doorbell aperture */
> >  	vi_enable_doorbell_aperture(adev, true);
> >  =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
