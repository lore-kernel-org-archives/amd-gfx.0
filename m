Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEBBC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F6B6105A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 08:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F6B6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7145F6ED9D;
	Thu, 29 Apr 2021 08:11:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117056EDA2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 08:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFhKBR/17H4vGqXYhoK1U3unNwnrmhsyUpCNh9Fb6eZcQ5Jp+/+Ug+Tf6+R3EFlRIS9JV5f2RcpeOPPGxkVBmFQ0Pf5X/l08O8P1oUgTpXTejcwNQeHvjslOH5+4m8ZN58LzWQL6Lb4luLVtSeRXdfmQZ4hPYz73VdH0HikbOo9Eqe4M7Kw/69TiNn7+6JllpNWRi+BK3II0AVoWKlGOf3/8Ts6KJ++65kRC0gHeB9lY0tECBpoqw1K748QXblc4BSrmwB0k6mUsci+LxuESkylskrl6yxDoSnYtAhWX49k5iUHbSbTY+89c+xkYOf85Oc0KpH4DqQCm4MIDxrmwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwUmuyhv+6DTGxvCMZEmzzaUHv2S56/sWcqHEb94bK0=;
 b=kDsa60X6j9NgTMAZre4DgkdBKWhEK1slw8O/maPvEyl34y8Gcfnlo9Pp3zKMp7J1lVaCxDP4/A1kpNIPWAcBSpsJNtiVNtTTMbKoyNS7HQB7TkWP5IlJRq/XRS4jy0jyHeI56fpw5hExwd9MtvsfCByZv9KkLuRNfITx40W6/oCy1ndwceBocj7M/7Q2LO2dz5WQgcxgGVn9ecZaq6C0AVRep5bNYd4o5pxhAFfhH1Qf3cc8WhnJvxxLucWl19SzqMBDeQTid7OktU7TbQfXOcnRQksX5CPI2CkZcMqAGO0REcBDLRE3gfYVh6Wv0/oyPNAXeB1bmfOqlIfKY4CybA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwUmuyhv+6DTGxvCMZEmzzaUHv2S56/sWcqHEb94bK0=;
 b=yDtujQYy6I+qfknxcmXpLzgLXHYYkH66RwGbv2frkH5TUnlH8cXoAO2PQfbDpjJgNP9Annn/RfyF4V/j7nC6jO2ItfDAhszmh5MZ5EqucC9eHvG18DBXo5osIS8N9VR+P+KtZeBska+CzL1GkHPubUcGa4gduN+iRyQl4M17YVs=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 08:11:31 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 08:11:31 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
Thread-Topic: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma 5.0
Thread-Index: AQHXNhtOgj90yu6PnUeYsQ8WgVqq2arK5raAgABJM2A=
Date: Thu, 29 Apr 2021 08:11:30 +0000
Message-ID: <BY5PR12MB4885068A1AD3C120C8B9432DEA5F9@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210420192739.1906700-1-alexander.deucher@amd.com>
 <CADnq5_O7OWgmX72VBOqSYKkq=A0dVmxGFmg9om54HCqen0r5EA@mail.gmail.com>
In-Reply-To: <CADnq5_O7OWgmX72VBOqSYKkq=A0dVmxGFmg9om54HCqen0r5EA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=23e2c1b9-0173-4c40-890c-333fe552882e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-29T08:02:56Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c3abd4a-23b4-4f5f-c1cd-08d90ae6657d
x-ms-traffictypediagnostic: BYAPR12MB2822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB28229C5CD156AA708F9A6023EA5F9@BYAPR12MB2822.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeA7kbbqoQTjvRjvFYVhSeb3pvLEO91ncfNAacxK6d8AEzPrMAT8n1zDXEjg3gL/8dopLYJuHLtJRsQuYdxHaWcjNmUmbIYeY0zn7JsYqRvyHFM/+acD1TURxGhJdBWY3C+BiFYPyTk6lEVfo2SbgAvwbq+yx08F8sVPP3Z3LxpLw5J9Xs6COOF7gz9C496oTBWOduC5qdBLBypVYkLN3ZVfHcOyxDr4Lv9+RdiLfJvEuq0gQRNYlmEVw/mshuxDjm/f25/G0kwqiWFNtCiI81dLoaqIljeY0hkOnmsUDPhckDbpuAgREs38+HRb8bOKdjyCgqVzMOs428ulDIBaNQpME/C3mjPmxE6ZgqdLnps8kFm86WPjFsss0XvwwFBiDvCFwgU7Awys+emWJhCIRD2STT9ZgMpOM0x0A3VbzO4MNGmnxY3FihJHKm/HIr6FARDTthjfBpqvDEv69aO8ac2rRwSi0HDrbif4kJEjHfMSW9yRiTiiQtZqhgbesq3Wh6o+SzIaUi7h7uYd21R2Aq9QQUI3iUXG+/hRq0fJNoMbCSb0M57z6fVg+K2oWNibYJvTUC6MsUYZKXXNsUIg5wAjEblN7NmxEZtdmNMAYrKpc6+1zRSOwbPP2JOld989uNVtIuW3k/iCH/ywyXXSICaxeTLPixUn3CD9RGDP3UXGqbG/i36CpeXDSkwBHu9X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(53546011)(2906002)(186003)(9686003)(86362001)(33656002)(45080400002)(478600001)(8936002)(122000001)(6506007)(8676002)(71200400001)(66946007)(66476007)(4326008)(66556008)(66446008)(6636002)(52536014)(64756008)(76116006)(966005)(7696005)(55016002)(38100700002)(26005)(110136005)(83380400001)(316002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TW+oBhyXpwgwBmpVzjBae1BgkLBOgkFQMP+ys6qTJ6gBYCpDDtccnO0FpAgT?=
 =?us-ascii?Q?DDBaMqJJI5YEcYWPtNAxsLEGtxVOqD63tdqkJY+yJNYMpNOD+6Qh0T2CqQVC?=
 =?us-ascii?Q?P2YG6mdFPccbKqgH+gQEhMUqQP+UTvZPvY+2CTRfTvFQYjJnwtlPaTvxliOW?=
 =?us-ascii?Q?zfi9GEyAocJz4lewK6OoZASH15cYz2+vdubSjXpxYG6LEhh6zZ/pO7fnFWLB?=
 =?us-ascii?Q?KU2YWzCeBKUnCcDIuxfU/cj4NMRgjVqqF6I21GMpXACgdA96WEjsuZDnP8H6?=
 =?us-ascii?Q?93JLiuVbBVCr3WbXTu7yJK6DD+Exy8MBbcI49BpZUWtkgbot5d2iY7pRHysl?=
 =?us-ascii?Q?2YMipPlIQI8+6PCCiYazQdc02cnpJGhEDHfFenfKfCgzviiHy471/OrXsktI?=
 =?us-ascii?Q?zn90iDbHAIMpTFDgFgfrWfVY//AEW0Sl5tjuxurdHbUg8vPmfNEziBHUF/RL?=
 =?us-ascii?Q?aZfAOdUIs/LIjRUtoxuxfeFZ9pOOQToBZEgcXBIEm8OTs/bF5Z+Lmg+7aMjn?=
 =?us-ascii?Q?JGDJ/U40ylXQHm15Fd/cfv1zbO5xqG4s+Zz2DWBJZDP7m25U53tEwuTkwwS+?=
 =?us-ascii?Q?lW+gnQsD7XQEFfmOL76/vYpADqxP2rndcPOeKHztqT7BHmoeRB8zEIRT5JPY?=
 =?us-ascii?Q?4WKlO7BVRMhwZOrcL5NHHRNoC+c4cqcsw6OSYZkV4Fl+8Bwd71njYRXdLik8?=
 =?us-ascii?Q?VDbZzJMd3AuAEuiR8oWCbwndK9Nyiu8BuINfm4s1GFG3XGGH1Z2SXDhY/B8O?=
 =?us-ascii?Q?j6+6IjL9923D+VL4Mf2jh7f4eVJWixuzEbLVc27CeddaU+lek2znPnhf9Dh6?=
 =?us-ascii?Q?JMUuextVdsgjWkBHQxJPXRRjWe+q3RZaQIxYaL50i7PEVzeDieKjnSmm7HY+?=
 =?us-ascii?Q?zD4DvEet09FDbKocohRVAPv8SOOjDMC7XZtmiLl4gmmHgR3XUVwDqbEgZfxm?=
 =?us-ascii?Q?gNUctYrQ5JWK5GSFfE56+oQmeuh1FyTx69FWRhaRd+sqcHMkIUp1VkIM/Qkq?=
 =?us-ascii?Q?xVOCBMIMclrE1p4TGPP3LUx1OB9JgWiuiD4P1dHILbhyMLC2ACsV2miX07aS?=
 =?us-ascii?Q?OUlbmmQn+0+uyZUPiMEIoFYcee7HasM0qP9HAn7Cc0D+RaqSR0dV3aV1jJOm?=
 =?us-ascii?Q?+OnR48NzbBnZOXvK3qMiS/onAwTKGc9ux2mvF83yVXz1ngMZ/i9LrAg1jqmJ?=
 =?us-ascii?Q?J6bFKSNRv4YQsMkfcJeqwJF6jhn/LB3l4WH9F/89VfUBOuIoC7esD6RXSPaQ?=
 =?us-ascii?Q?flarg0kOnAhSStR3Yi5xyJn4A08NT4OMGy7Gfa1Bi38Tag8eRqPW1u/pSJoQ?=
 =?us-ascii?Q?JhXQzPW6p1lCqQC19+ZAZFdx?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3abd4a-23b4-4f5f-c1cd-08d90ae6657d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 08:11:30.9300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymcbbrmT3yoYoEGXNflNJ6G7XACtxOVrGMokCr5O61RUPGLetzl1ClS2LZVQFrs39GID98Ng0uV0Q7aHMY+1mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2822
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

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
I notice there is already similar logic in sdma_v5_0_ring_emit_ib, do we need remove it?

Regards,
Jiansong

@@ -410,6 +410,18 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
        unsigned vmid = AMDGPU_JOB_GET_VMID(job);
        uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);

+       /* Invalidate L2, because if we don't do it, we might get stale cache
+        * lines from previous IBs.
+        */
+       amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
+       amdgpu_ring_write(ring, 0);
+       amdgpu_ring_write(ring, (SDMA_GCR_GL2_INV |
+                                SDMA_GCR_GL2_WB |
+                                SDMA_GCR_GLM_INV |
+                                SDMA_GCR_GLM_WB) << 16);
+       amdgpu_ring_write(ring, 0xffffff80);
+       amdgpu_ring_write(ring, 0xffff);
+

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, April 29, 2021 11:41 AM
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
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJi
> ansong.Chen%40amd.com%7C1b777b80b17145712a7b08d90ac0a1f4%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637552644738458840%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=T9jZUIJIQHS2gY8bU%2F7uM1ealAP3qxelkg2Slj3JASA%3D&am
> p;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C1b777b80b17145712a7b08d90ac0a1f4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637552644738458840%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=T9jZUIJIQHS2gY8bU%2F7uM1ealAP3qxelkg2Slj3JASA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
