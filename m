Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4589C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 03:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CE861433
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 03:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CE861433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1160389179;
	Thu, 29 Apr 2021 03:43:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4944689A4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 03:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5DonORsJiHFQg90lSd6vTvjM+GOPTgRDG+TqmKVyXaD2UTH0zT9qGVX0z96aCAe6M/hNahdyPZe5JpkHEAPMvntYjTORyQGCjsO4ru9SeWDm0hiQSPDgi2qC2ckHSRXhsrs4hoHV1XLoxy+3FDbPdatDlV+AGshVs7/DTCoxXIysaoMt+P5eHsJV0MVHpGgU1TJgkFwcukTWljEO8v1HcJernpWFo6UEV/JiCXpnDXCbJc8DsqxGoiQKTp3IVQTGx4ArjjsfL7eDMSOuXNCs9k0YG42B95bltCNDKMfJd0Hz5b+ww5TRBjRnXp+e8vdE8ufld/DjLxltRvW3Qf5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swRtsmiRbV1NFNW837zFvzbHDAyPNgcJnrdT+r3NdbI=;
 b=FVpe985IrQ0qiKR2aIjc6Q8cZxannYjOBm7FfiWAYI6OQ7wUzht7wODiwm+GzSYk4lVE6F2mdtOebxB9sp6o9Az62tGgoSJECLF38VPO2mapMtjMAlHSGei1m92y8FyrQj7gp0sCqUzaqh7VZWtd3v3cWy2Y1mvOOxySwRhrkrviIAj9YoR3gjT2jKKQ2JZiu6E8350Qe8rL9DcqEhIysqJFYfHuEE3orIWXhX6ixhvFGdI1rOOLvsFyTCNweK0+n8tXevXlS7JoLLDWu8+M2TTzxqmqNH76wc3bXHODTUZ6NKRcUBVZPsrVcODfqi/A+s/rwn8EUYjQKkiVeaMqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swRtsmiRbV1NFNW837zFvzbHDAyPNgcJnrdT+r3NdbI=;
 b=JHntxVSdcCYb8QUzFoSuZeaomyPRXkdZ36pB2Zxpd5Jkn76bEdIbcAxaPSIYjFaC2vmPB84VdX0xLnPdkgQ1B2vEVe9+r/VmfxkH4OHy81Qg9tfS1nRXwFDO1tk838YOsj1Ao3N9gDK7oDSYJUuLz3Y5KNq8BljsC8cfMsO+jjg=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 03:43:00 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 03:43:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
Thread-Topic: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
Thread-Index: AQHXNhtOCrJGo4w2OUapnkonw00BvKrK5raAgAAAeEA=
Date: Thu, 29 Apr 2021 03:43:00 +0000
Message-ID: <BN9PR12MB53684CB417AA36437FCB3D33FC5F9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210420192739.1906700-1-alexander.deucher@amd.com>
 <CADnq5_O7OWgmX72VBOqSYKkq=A0dVmxGFmg9om54HCqen0r5EA@mail.gmail.com>
In-Reply-To: <CADnq5_O7OWgmX72VBOqSYKkq=A0dVmxGFmg9om54HCqen0r5EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-29T03:42:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=aa578e71-bc85-4080-97de-80177e0bdffa;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be642f55-dcba-4de1-dc7c-08d90ac0e2be
x-ms-traffictypediagnostic: BN9PR12MB5228:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5228FA5558FB1221D03F8A03FC5F9@BN9PR12MB5228.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRGkPT0aDdtiAL7fM3Ic5tf7z58BvbixEImQPn12LIwQQtQzW3uDvQtuv4J1Ml0/+yAhTnRdaSDCICFJFSIFP+UHAIvT97408qFlgh7F2uvL+hwhAr1VJGOsnQ92SivurMwFNnffAZglZ1r1MCOVeZ1YDLtRDHxnpETwx5UCF6vH7TiKvc6LRWHkC54CRmoptqla3/dTWxlsZ+QL7TQZ/SQa0uYx1N27fB/ug2NVHLpWl0MlOherGVCd3JnLLKmY3U5ldN6dGzabnn4ZNn0Cj7yLYVxKTrlr4Zv2v0XRB4LLxiTvPBgV55r2mytTQwjUeHL63K5H84qpuxwK/q7J7Y5yYjDTD8E9Y1RaYmih+ubi8ECiRFQKFT9J0WaaGmBZotiXjuGGw4Bd9vb4jg2U0GAZc6rhe1rXNh2EH5I9Q5irbQI9+uAHjJl58ldGkcHUju6nuE7Fvi9T2Cl71CsV8nc+5iZxDCIFVmciZiuawRfTCkBjS5KDX4Fop+sjNIODw2bhxUmSoEYWDtKZmsT76wXTTC7UQaL03REYAYyyhiMZKo17ScaxgOwXEKArD46xtY/GcW1IkyxMaP6VXaHxhfIGKnDOfCsoIXI1Bvf/3LbP/k+sGrhS3kyizvssfbpHJdSwRO8ldkVaiOwqy3vxk/Wk/0awGqJmHgl5PSQO+9U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(478600001)(110136005)(8936002)(6636002)(4326008)(45080400002)(316002)(83380400001)(71200400001)(26005)(2906002)(8676002)(186003)(5660300002)(7696005)(122000001)(38100700002)(966005)(66946007)(33656002)(86362001)(52536014)(6506007)(66556008)(66446008)(64756008)(76116006)(55016002)(66476007)(9686003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3ePhAA4YnpekdqUW4oVUEt25gIbZqVaHPEqVIltABTALG59VtvF/UypMLSrO?=
 =?us-ascii?Q?Njj2LoYKXzdx7kHAXaerLbg/3F27F7LbDxaUA3JS9H+5R064WbL7WucEO9RL?=
 =?us-ascii?Q?KOEac4Qyl0rHz6QCs1YLdqH3y18BH4Bcp0aINV9NWUl1p0KfIO99Td2FqjlD?=
 =?us-ascii?Q?W4m7jr871bLmLYahGHBJYtA3bcyusdcOENOilcgL+aYVxDFwqQt6ZbC4QgHq?=
 =?us-ascii?Q?ZXNm0T0plVPcc15dq/BhKWlAB4PNWZoKahL10M6XE+Oaox1neidlbe7j9vjP?=
 =?us-ascii?Q?0/EzhRRXbY4U880HsL7ma6SD+Du7m/Rn0InT+9QuRkz9NNQqtqebwwyENSxF?=
 =?us-ascii?Q?/Sd9WvC3cKa9ocCmyFpXD0Qi5BM+5Ue6oO0VFYA06rmNwgmm/xb0Nx6LoML4?=
 =?us-ascii?Q?8bnouRXg5dZtyayvn/eG14tIomWPiXuPTaPZS3KDEqdo8RVAODflaxQ1ZpxY?=
 =?us-ascii?Q?2+OgwNoANRYoYExssmZNUNI9ELoGuwv17UQEjY6AyrNedRIGlmLKWog4MmHY?=
 =?us-ascii?Q?E38O431p0PIC+7qQn1oqLV0DInZdB2qTwZyceJaevP7feUFcb7iHC94ATHdC?=
 =?us-ascii?Q?K7oSs6j1exav4fn7ul3UOtB6jzl7CeZZhqjiW75DmGNDhuysEVCaCn/amUvB?=
 =?us-ascii?Q?JSC0kedhggWkU0HZj4GKlLMYizzDMSBPjB1uUZOfmSy+Xh/gjk8BKdchKHAM?=
 =?us-ascii?Q?RJdY/LhMwRzGs8mKRdE6PZUsVM8Eu/OLWgJ/G8B72dUandXeq6zpQ5HMG7aK?=
 =?us-ascii?Q?PXx1RKZJS334EyFKvJliHwrFcVfrgCLtXRNVSSx2I1ZalYi5qp688lX7xDYg?=
 =?us-ascii?Q?DT6bjYtdpdmLT2SfIYu9bk9OlzhK5FMINVVMxRlUvJ8QiFEg+fdb0Pk98HAd?=
 =?us-ascii?Q?8LvziUAYknqMzKew+e7g3XWkvI+WsdugIkPBu40tqWpDGLqu2eN/TCi4LpxM?=
 =?us-ascii?Q?nkBBYiPV9+F3sLUptkcmt6/mC+kgglbeDa7E9acp6w2eVDAWMqKe4hyKZltb?=
 =?us-ascii?Q?nTElgnJMeg30PU+D7UUINUdUibv//gDGlYUEJymXOMOO7nUY6hAmNmmlzrVh?=
 =?us-ascii?Q?qkwupiGT5FslO9CZpL4VTpH4Mz1e+cr81DXbOmMbaXHNhyV3VdGrX7kyJaLF?=
 =?us-ascii?Q?Eo4kTViux0uMYTkoZBk6Fn9olDD6XUczWHW5x0L0/fk5FeWQi7/6YE9OzaT2?=
 =?us-ascii?Q?1Oe5t7ZXKKHzAdI/2Xk+MyfLe109vS0G7f1VwA1wssXvCZb8ZxNL0Yl4TQUu?=
 =?us-ascii?Q?9RDMwWMzJ0sy6SUKIhUpfo/63ukaNS7oBFTZ8r9syU9QmbDSf9d2JxQqgQ/3?=
 =?us-ascii?Q?v0Mh5D4gJ98AEFRGhZimhW4n?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be642f55-dcba-4de1-dc7c-08d90ac0e2be
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 03:43:00.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA4Q3wxDpobjpQar4CPkHq7+3r5C15wPs73QixSvwzHiVcKyzs1ngTOVjG/QQ59EhG84Jm3eLe4GVqeHiWCsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, April 29, 2021 11:41
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0

Ping?

On Tue, Apr 20, 2021 at 3:28 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Add emit mem sync callback for sdma_v5_0
>
> In amdgpu sync object test, three threads created jobs to send GFX IB 
> and SDMA IB in sequence. After the first GFX thread joined, sometimes 
> the third thread will reuse the same physical page to store the SDMA 
> IB. There will be a risk that SDMA will read GFX IB in the previous 
> physical page. So it's better to flush the cache before commit sdma 
> IB.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 28 
> ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c 
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 920fc6d4a127..d294ef6a625a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -437,6 +437,33 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
>         amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr));  }
>
> +/**
> + * sdma_v5_0_ring_emit_mem_sync - flush the IB by graphics cache 
> +rinse
> + *
> + * @ring: amdgpu ring pointer
> + * @job: job to retrieve vmid from
> + * @ib: IB object to schedule
> + *
> + * flush the IB by graphics cache rinse.
> + */
> +static void sdma_v5_0_ring_emit_mem_sync(struct amdgpu_ring *ring) {
> +    uint32_t gcr_cntl =
> +                   SDMA_GCR_GL2_INV | SDMA_GCR_GL2_WB | SDMA_GCR_GLM_INV |
> +                       SDMA_GCR_GL1_INV | SDMA_GCR_GLV_INV | SDMA_GCR_GLK_INV |
> +                       SDMA_GCR_GLI_INV(1);
> +
> +       /* flush entire cache L0/L1/L2, this can be optimized by performance requirement */
> +       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD1_BASE_VA_31_7(0));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD2_GCR_CONTROL_15_0(gcr_cntl) |
> +                       SDMA_PKT_GCR_REQ_PAYLOAD2_BASE_VA_47_32(0));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD3_LIMIT_VA_31_7(0) |
> +                       SDMA_PKT_GCR_REQ_PAYLOAD3_GCR_CONTROL_18_16(gcr_cntl >> 16));
> +       amdgpu_ring_write(ring, SDMA_PKT_GCR_REQ_PAYLOAD4_LIMIT_VA_47_32(0) |
> +                       SDMA_PKT_GCR_REQ_PAYLOAD4_VMID(0));
> +}
> +
>  /**
>   * sdma_v5_0_ring_emit_hdp_flush - emit an hdp flush on the DMA ring
>   *
> @@ -1643,6 +1670,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
>                 10 + 10 + 10, /* sdma_v5_0_ring_emit_fence x3 for user fence, vm fence */
>         .emit_ib_size = 5 + 7 + 6, /* sdma_v5_0_ring_emit_ib */
>         .emit_ib = sdma_v5_0_ring_emit_ib,
> +       .emit_mem_sync = sdma_v5_0_ring_emit_mem_sync,
>         .emit_fence = sdma_v5_0_ring_emit_fence,
>         .emit_pipeline_sync = sdma_v5_0_ring_emit_pipeline_sync,
>         .emit_vm_flush = sdma_v5_0_ring_emit_vm_flush,
> --
> 2.30.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cha
> wking.zhang%40amd.com%7C27b92616b764440e6f6908d90ac0a302%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637552644756636394%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=W%2F3m8Hla7J1prF%2BlApw60YpW2rSF8qq9XIjIqgV8DUQ%3D&
> amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C27b92616b764440e6f6908d90ac0a302%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552644756636394%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=W%2F3m8Hla7J1prF%2BlApw60YpW2rSF8qq9XIjIqgV8DUQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
