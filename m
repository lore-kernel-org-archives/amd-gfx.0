Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69B7C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EC22064B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 22:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mAJVHT4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EC22064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCFB6E1E0;
	Tue, 15 Sep 2020 21:59:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35D66E1E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 21:59:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGIQUqJjP/u/Ax/KU1bg+Ygr8hifNynKO8Oao6C+VYTsh21RSPbZcudCZ0Kb9GnMaFBqayBjwcInh8xcGzMe7ZWlWjWttTGgUiy5u2WhouIGj+mK/+zPdoX8gfydCSJdm+otMJ7slHoavkF8hSDq/aokG2tXwiJoDUYCLqs36Ny7cu1Vpj91QNF80gk9e4Fd3z2b0/ot8eUrKnSPuHEezSMTa+xTRCnaApUr2vWRIGVG95dI6Vk8cHutpsLGqPOKoJrJjKnnBOL1KFWDjmYHdZUYYy1ddgnsnsoLLiZJALXgNdV2sAt6Z+rBqqPqMu9O1opfKeBZVmmWO60PpqTKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi1C0RDIXBb1mszHZsU2YoTk9B5wqS/eIgqKai+ycD8=;
 b=kk8zjXV/LTrAeoygljYReDO147iTtqrujS8+Wv0za0XzhMa07npDo8o6Z2ixzV4LjPQcOXd1LnYyExyZe67oN5hl62ib617GoOYDxnKKtNqfQw8fQNR0WsgL/uwSPX7reAlNt/SmX4ipxiJC4lnJLnBjJAlalxKM1X344f7OtOG+pge187X04i+vzE3GTDon5+wNWPJMLivdQPSDSqThwbozKBasn+aNnL7DHceyexURjlVYStI744IErogaQSQDWFpMnrMhPJqS+0vn5AeYyEefsK8KOADagXP8HinTm9kVot8bYapxif1iQS/sdTwfFfupkkoz9jxbUlYpkCsXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi1C0RDIXBb1mszHZsU2YoTk9B5wqS/eIgqKai+ycD8=;
 b=mAJVHT4ou5I+vzNiEqcxQ/7fXy8jSQVc40KXiCRjw+d5wG6Hi1RYqd85pPYMEKU3QpaCtfPll2+yBj3HyRbKSqszPcsScHh+1qDR+wvssvPnXTfhEN3X7Tnex14vUq6TRLj2VAHvwELlCSjCrd69KvHIjw/Ejx/j/U9FccB3Zto=
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN6PR12MB1188.namprd12.prod.outlook.com
 (2603:10b6:404:19::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 21:59:56 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 21:59:56 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: fix xgmi perfmon a-b-a problem
Thread-Topic: [PATCH 1/3] drm/amdgpu: fix xgmi perfmon a-b-a problem
Thread-Index: AQHWi6o7MucvHilvHUScTAy4QgS89KlqP4nA
Date: Tue, 15 Sep 2020 21:59:56 +0000
Message-ID: <BN6PR1201MB0146A986F6B7972865D7CBAC85200@BN6PR1201MB0146.namprd12.prod.outlook.com>
References: <20200915215020.128856-1-jonathan.kim@amd.com>
In-Reply-To: <20200915215020.128856-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc265a44-c1b9-4567-ab55-1a0af429bc4f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-15T21:59:08Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a0:18d:f5b6:b45f:f45b:3866]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b9293cf9-7ee3-4837-76c6-08d859c2aefc
x-ms-traffictypediagnostic: BN6PR12MB1188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB118828723619A7296E38483385200@BN6PR12MB1188.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vq9N+qOpV7ciEK9ZkR+mYeikgX3O5sm3Q0quK8ZoE5o7dvqB8jRU7Qc8oYsWZm3hoHkTjUT31G43+miQDaim3uOLuVrHkXgKEZCnjn2scMrRtsJEFylbbzQXbdF45v24e3U25+J+Hqw+Zlp1tHBvWoJRE7FlApLhmtPcq7hDbTrKh0gtneTMhlMyf9VWnKPkfBjUAniviusP9epKVU7Ti5WwsagmxoNCQXZncUmBiMhRFAEejvM9p9c0p3ZzxSBSivd4mLKSyP3GDQ5gUpCXr7OY+rnWics/+kyrJRA51cInIix6L5rzcIM950lVS6IPaOQaocf/lai+PjVRe/noDQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(53546011)(6506007)(64756008)(76116006)(66446008)(7696005)(316002)(66946007)(8936002)(66476007)(66556008)(478600001)(86362001)(5660300002)(30864003)(33656002)(2906002)(83380400001)(8676002)(52536014)(4326008)(71200400001)(9686003)(186003)(55016002)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iLd5V3EI2Z68tB6ZqlYtoRMEwd0X8zwmiIZO7dsbxUfb6R5MsV1omGVzLz9e/hbUyi3WNhXcahwn6X3uTXTvS+kaxOKzJcFwxfKk2iu9Ho7lU/Pvx74pmYqIB4EbDMcvx05Ox694zsi8iUQMmdtU5lJYj6J/TxmDVLYhT63vN4y2mL+a5pZpB6wmba4pMfhA/tlI7km3x0mXmAkDoxGRE2KNHIQFYiqGFTitit8k0fVixPn7yGrv/Mh0FU4ibs41B4JGry12EleBHl+IV+nEwpnDi57vraCZRjSbLC6VFlzQwaXriJ3wl1EawqCnPvu5vhE+mNdkc/7RGlG469hBoJwhUfbOMSRX5pZuLDKzWm/PpQR0e/49yEQ8wLKczavBh15P0tEaF0r8LS5620uGJ93ZTUArieBtTTZWx2VXcEkM4WqK/a32Va0LSkJSY8a65pqLv8Fgr36Gsji3IvNHKE7t3G+Tr8D2MLs5YfazNBsDCHg6aMqOAklYI1U+nCWG+cgBHmMIAZaVWd9wumHYFeCerzjONVzPitHVvVnUJu9hwnmly/vEf2swUs2Cxk4sRcjer/Zk2CVYiucGUX1DGYciPiy2joVvCCyT4C3fPdns6EcZkl0BANVN+W7NQwt9SjK+jLSKbLfsQihAumIBZfWZmp+5e4ON5V75DgTf5rwBh5EMnGL7M8SIsJcixHudv8OKid4VwQF6P4Q/xw2b7g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9293cf9-7ee3-4837-76c6-08d859c2aefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 21:59:56.6194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Us3huNzuOBsuVIP0x3tIQEPLXHJ26D5Hex1OvMu51vdsRgF9ZF2LNX58qw1O7DGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Kim, Jonathan <jonathan.kim@amd.com>
> Sent: Tuesday, September 15, 2020 5:51 PM
> To: amd-gfx@lists.ffreedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim,
> Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu: fix xgmi perfmon a-b-a problem
>
> Mapping hw counters per event config will cause ABA problems so map per
> event instead.
>
> v2: Discontinue starting perf counters if add fails.  Make it clear what's
> happening with pmc_start.
>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_df.h  |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c |  42 ++++++----
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c    | 105 +++++++++++-------------
>  3 files changed, 78 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
> index 373cdebe0e2f..52488bb45112 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_df.h
> @@ -44,11 +44,11 @@ struct amdgpu_df_funcs {
>  void (*enable_ecc_force_par_wr_rmw)(struct amdgpu_device
> *adev,
>      bool enable);
>  int (*pmc_start)(struct amdgpu_device *adev, uint64_t config,
> - int is_add);
> + int counter_idx, int is_add);
>  int (*pmc_stop)(struct amdgpu_device *adev, uint64_t config,
> - int is_remove);
> + int counter_idx, int is_remove);
>  void (*pmc_get_count)(struct amdgpu_device *adev, uint64_t config,
> - uint64_t *count);
> + int counter_idx, uint64_t *count);
>  uint64_t (*get_fica)(struct amdgpu_device *adev, uint32_t
> ficaa_val);
>  void (*set_fica)(struct amdgpu_device *adev, uint32_t ficaa_val,
>   uint32_t ficadl_val, uint32_t ficadh_val); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 69af462db34d..1b0ec715c8ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -64,6 +64,7 @@ static void amdgpu_perf_start(struct perf_event
> *event, int flags)
>  struct amdgpu_pmu_entry *pe = container_of(event->pmu,
>    struct amdgpu_pmu_entry,
>    pmu);
> +int target_cntr = 0;
>
>  if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
>  return;
> @@ -73,17 +74,24 @@ static void amdgpu_perf_start(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> -if (!(flags & PERF_EF_RELOAD))
> -pe->adev->df.funcs->pmc_start(pe->adev, hwc-
> >config, 1);
> +if (!(flags & PERF_EF_RELOAD)) {
> +target_cntr = pe->adev->df.funcs->pmc_start(pe-
> >adev,
> +hwc->config, 0 /* unused */,
> +1 /* add counter */);
> +if (target_cntr < 0)
> +break;
> +
> +hwc->idx = target_cntr;
> +}
>
> -pe->adev->df.funcs->pmc_start(pe->adev, hwc->config, 0);
> +pe->adev->df.funcs->pmc_start(pe->adev, hwc->config,
> +hwc->idx, 0);
>  break;
>  default:
>  break;
>  }
>
>  perf_event_update_userpage(event);
> -
>  }
>
>  /* read perf counter */
> @@ -101,8 +109,8 @@ static void amdgpu_perf_read(struct perf_event
> *event)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> -pe->adev->df.funcs->pmc_get_count(pe->adev, hwc-
> >config,
> -  &count);
> +pe->adev->df.funcs->pmc_get_count(pe->adev,
> +hwc->config, hwc->idx,
> &count);
>  break;
>  default:
>  count = 0;
> @@ -126,7 +134,8 @@ static void amdgpu_perf_stop(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> -pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 0);
> +pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc-
> >idx,
> +0);
>  break;
>  default:
>  break;
> @@ -142,12 +151,11 @@ static void amdgpu_perf_stop(struct perf_event
> *event, int flags)
>  hwc->state |= PERF_HES_UPTODATE;
>  }
>
> -/* add perf counter  */
> +/* add perf counter */
>  static int amdgpu_perf_add(struct perf_event *event, int flags)  {
>  struct hw_perf_event *hwc = &event->hw;
> -int retval;
> -
> +int retval = 0, target_cntr;
>  struct amdgpu_pmu_entry *pe = container_of(event->pmu,
>    struct amdgpu_pmu_entry,
>    pmu);
> @@ -156,8 +164,14 @@ static int amdgpu_perf_add(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> -retval = pe->adev->df.funcs->pmc_start(pe->adev,
> -       hwc->config, 1);
> +target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
> +hwc->config, 0 /* unused */,
> +1 /* add counter */);
> +if (target_cntr < 0)
> +retval = target_cntr;
> +else
> +hwc->idx = target_cntr;
> +
>  break;
>  default:
>  return 0;
> @@ -170,7 +184,6 @@ static int amdgpu_perf_add(struct perf_event
> *event, int flags)
>  amdgpu_perf_start(event, PERF_EF_RELOAD);
>
>  return retval;
> -
>  }
>
>  /* delete perf counter  */
> @@ -185,7 +198,8 @@ static void amdgpu_perf_del(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> -pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, 1);
> +pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc-
> >idx,
> +1);
>  break;
>  default:
>  break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 7b89fd2aa44a..0ca6e176acb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -391,33 +391,28 @@ static void df_v3_6_get_clockgating_state(struct
> amdgpu_device *adev,  }
>
>  /* get assigned df perfmon ctr as int */ -static int
> df_v3_6_pmc_config_2_cntr(struct amdgpu_device *adev,
> -      uint64_t config)
> +static bool df_v3_6_pmc_has_counter(struct amdgpu_device *adev,
> +      uint64_t config,
> +      int counter_idx)
>  {
> -int i;
>
> -for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
> -if ((config & 0x0FFFFFFUL) ==
> -adev-
> >df_perfmon_config_assign_mask[i])
> -return i;
> -}
> +return ((config & 0x0FFFFFFUL) ==
> +adev-
> >df_perfmon_config_assign_mask[counter_idx]);
>
> -return -EINVAL;
>  }
>
>  /* get address based on counter assignment */  static void
> df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
>   uint64_t config,
> + int counter_idx,
>   int is_ctrl,
>   uint32_t *lo_base_addr,
>   uint32_t *hi_base_addr)
>  {
> -int target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
> -
> -if (target_cntr < 0)
> +if (!df_v3_6_pmc_has_counter(adev, config, counter_idx))
>  return;
>
> -switch (target_cntr) {
> +switch (counter_idx) {
>
>  case 0:
>  *lo_base_addr = is_ctrl ? smnPerfMonCtlLo4 :
> smnPerfMonCtrLo4; @@ -443,15 +438,18 @@ static void
> df_v3_6_pmc_get_addr(struct amdgpu_device *adev,
>  /* get read counter address */
>  static void df_v3_6_pmc_get_read_settings(struct amdgpu_device *adev,
>    uint64_t config,
> +  int counter_idx,
>    uint32_t *lo_base_addr,
>    uint32_t *hi_base_addr)
>  {
> -df_v3_6_pmc_get_addr(adev, config, 0, lo_base_addr,
> hi_base_addr);
> +df_v3_6_pmc_get_addr(adev, config, counter_idx, 0, lo_base_addr,
> +
> hi_base_addr);
>  }
>
>  /* get control counter settings i.e. address and values to set */  static int
> df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
>    uint64_t config,
> +  int counter_idx,
>    uint32_t *lo_base_addr,
>    uint32_t *hi_base_addr,
>    uint32_t *lo_val,
> @@ -462,7 +460,8 @@ static int df_v3_6_pmc_get_ctrl_settings(struct
> amdgpu_device *adev,
>  uint32_t eventsel, instance, unitmask;
>  uint32_t instance_10, instance_5432, instance_76;
>
> -df_v3_6_pmc_get_addr(adev, config, 1, lo_base_addr,
> hi_base_addr);
> +df_v3_6_pmc_get_addr(adev, config, counter_idx, 1, lo_base_addr,
> +hi_base_addr);
>
>  if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
>  DRM_ERROR("[DF PMC] addressing not retrieved! Lo: %x, Hi:
> %x", @@ -492,18 +491,13 @@ static int
> df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,  static int
> df_v3_6_pmc_add_cntr(struct amdgpu_device *adev,
>     uint64_t config)
>  {
> -int i, target_cntr;
> -
> -target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
> -
> -if (target_cntr >= 0)
> -return 0;
> +int i;
>
>  for (i = 0; i < DF_V3_6_MAX_COUNTERS; i++) {
>  if (adev->df_perfmon_config_assign_mask[i] == 0U) {
>  adev->df_perfmon_config_assign_mask[i] =
>  config &
> 0x0FFFFFFUL;
> -return 0;
> +return i;
>  }
>  }
>
> @@ -512,59 +506,50 @@ static int df_v3_6_pmc_add_cntr(struct
> amdgpu_device *adev,
>
>  #define DEFERRED_ARM_MASK(1 << 31)
>  static int df_v3_6_pmc_set_deferred(struct amdgpu_device *adev,
> -    uint64_t config, bool is_deferred)
> +    int counter_idx, uint64_t config,
> +    bool is_deferred)
>  {
> -int target_cntr;
> -
> -target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
>
> -if (target_cntr < 0)
> +if (!df_v3_6_pmc_has_counter(adev, config, counter_idx))
>  return -EINVAL;
>
>  if (is_deferred)
> -adev->df_perfmon_config_assign_mask[target_cntr] |=
> +adev->df_perfmon_config_assign_mask[counter_idx] |=
>
> DEFERRED_ARM_MASK;
>  else
> -adev->df_perfmon_config_assign_mask[target_cntr] &=
> +adev->df_perfmon_config_assign_mask[counter_idx] &=
>
> ~DEFERRED_ARM_MASK;
>
>  return 0;
>  }
>
>  static bool df_v3_6_pmc_is_deferred(struct amdgpu_device *adev,
> +    int counter_idx,
>      uint64_t config)
>  {
> -int target_cntr;
> -
> -target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
> -
> -/*
> - * we never get target_cntr < 0 since this funciton is only called in
> - * pmc_count for now but we should check anyways.
> - */
> -return (target_cntr >= 0 &&
> -(adev->df_perfmon_config_assign_mask[target_cntr]
> -& DEFERRED_ARM_MASK));
> +return(df_v3_6_pmc_has_counter(adev, config, counter_idx) &&
> +(adev-
> >df_perfmon_config_assign_mask[counter_idx]
> +& DEFERRED_ARM_MASK));
>
>  }
>
>  /* release performance counter */
>  static void df_v3_6_pmc_release_cntr(struct amdgpu_device *adev,
> -     uint64_t config)
> +     uint64_t config,
> +     int counter_idx)
>  {
> -int target_cntr = df_v3_6_pmc_config_2_cntr(adev, config);
> -
> -if (target_cntr >= 0)
> -adev->df_perfmon_config_assign_mask[target_cntr] = 0ULL;
> +if (df_v3_6_pmc_has_counter(adev, config, counter_idx))
> +adev->df_perfmon_config_assign_mask[counter_idx] = 0ULL;
>  }
>
>
>  static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
> - uint64_t config)
> + uint64_t config,
> + int counter_idx)
>  {
>  uint32_t lo_base_addr = 0, hi_base_addr = 0;
>
> -df_v3_6_pmc_get_read_settings(adev, config, &lo_base_addr,
> +df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
> +&lo_base_addr,
>        &hi_base_addr);
>
>  if ((lo_base_addr == 0) || (hi_base_addr == 0)) @@ -573,8 +558,9
> @@ static void df_v3_6_reset_perfmon_cntr(struct amdgpu_device *adev,
>  df_v3_6_perfmon_wreg(adev, lo_base_addr, 0, hi_base_addr, 0);  }
>
> +/* return available counter if is_add == 1 otherwise return error
> +status. */
>  static int df_v3_6_pmc_start(struct amdgpu_device *adev, uint64_t config,
> -     int is_add)
> +     int counter_idx, int is_add)
>  {
>  uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
>  int err = 0, ret = 0;
> @@ -584,10 +570,9 @@ static int df_v3_6_pmc_start(struct amdgpu_device
> *adev, uint64_t config,
>  if (is_add)
>  return df_v3_6_pmc_add_cntr(adev, config);
>
> -df_v3_6_reset_perfmon_cntr(adev, config);
> -
>  ret = df_v3_6_pmc_get_ctrl_settings(adev,
>  config,
> +counter_idx,
>  &lo_base_addr,
>  &hi_base_addr,
>  &lo_val,
> @@ -604,7 +589,8 @@ static int df_v3_6_pmc_start(struct amdgpu_device
> *adev, uint64_t config,
>       hi_val);
>
>  if (err)
> -ret = df_v3_6_pmc_set_deferred(adev, config, true);
> +ret = df_v3_6_pmc_set_deferred(adev, config,
> +counter_idx, true);
>
>  break;
>  default:
> @@ -615,7 +601,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device
> *adev, uint64_t config,  }
>
>  static int df_v3_6_pmc_stop(struct amdgpu_device *adev, uint64_t config,
> -    int is_remove)
> +    int counter_idx, int is_remove)
>  {
>  uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
>  int ret = 0;
> @@ -624,6 +610,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device
> *adev, uint64_t config,
>  case CHIP_VEGA20:
>  ret = df_v3_6_pmc_get_ctrl_settings(adev,
>  config,
> +counter_idx,
>  &lo_base_addr,
>  &hi_base_addr,
>  &lo_val,
> @@ -635,8 +622,8 @@ static int df_v3_6_pmc_stop(struct amdgpu_device
> *adev, uint64_t config,
>
>
>  if (is_remove) {
> -df_v3_6_reset_perfmon_cntr(adev, config);
> -df_v3_6_pmc_release_cntr(adev, config);
> +df_v3_6_reset_perfmon_cntr(adev, config,
> counter_idx);
> +df_v3_6_pmc_release_cntr(adev, config,
> counter_idx);
>  }
>
>  break;
> @@ -649,6 +636,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device
> *adev, uint64_t config,
>
>  static void df_v3_6_pmc_get_count(struct amdgpu_device *adev,
>    uint64_t config,
> +  int counter_idx,
>    uint64_t *count)
>  {
>  uint32_t lo_base_addr = 0, hi_base_addr = 0, lo_val = 0, hi_val = 0;
> @@ -656,14 +644,14 @@ static void df_v3_6_pmc_get_count(struct
> amdgpu_device *adev,
>
>  switch (adev->asic_type) {
>  case CHIP_VEGA20:
> -df_v3_6_pmc_get_read_settings(adev, config,
> &lo_base_addr,
> -      &hi_base_addr);
> +df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
> +&lo_base_addr,
> &hi_base_addr);
>
>  if ((lo_base_addr == 0) || (hi_base_addr == 0))
>  return;
>
>  /* rearm the counter or throw away count value on failure */
> -if (df_v3_6_pmc_is_deferred(adev, config)) {
> +if (df_v3_6_pmc_is_deferred(adev, config, counter_idx)) {
>  int rearm_err =
> df_v3_6_perfmon_arm_with_status(adev,
>  lo_base_addr, lo_val,
>  hi_base_addr,
> hi_val);
> @@ -671,7 +659,8 @@ static void df_v3_6_pmc_get_count(struct
> amdgpu_device *adev,
>  if (rearm_err)
>  return;
>
> -df_v3_6_pmc_set_deferred(adev, config, false);
> +df_v3_6_pmc_set_deferred(adev, config,
> counter_idx,
> +
> false);
>  }
>
>  df_v3_6_perfmon_rreg(adev, lo_base_addr, &lo_val,
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
