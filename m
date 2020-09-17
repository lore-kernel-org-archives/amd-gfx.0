Return-Path: <SRS0=QzDn=C2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97728C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 18:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34CB21973
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2020 18:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZzEiRx28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34CB21973
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 820F36EC45;
	Thu, 17 Sep 2020 18:08:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D9E6EC45
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2020 18:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDw0wMxpzHYIsfpjyPfZPufqIyvXd7F7FrxdtjeZKbHLhirLpQ6oHJYpblLHSuocagc5IxGVUTzzw/u5byPfWY0yYPoiTovc4wSmg44pE/5ZQFfJUwfGShk5+W9X/SsWWfWiBUnVnD4f0SmHPHUSfzSjKPJq7Cyv+hQGkz7JD3dlhLZMvUOHch7ikthxP0o3Fu0AL2F1OoR7/d4deRl4XPf4tutbIUPCxkQdBQZ19ftIZ1uQqiDaOtyLKkSnlR/tKdJ1Xy7ZlfFqHk6qgpPWmRbKMYrrCnw39TbaPhcHIze32PMXVqRd1QYzaqwiXlZDkaVmDXhr+/kna+vsC/5Q6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0k+UG7g2AFiHoKqz5N6F8Nh0QZaYv6ZWw+CeL1KG6o=;
 b=cCovsQv2LkDB+jIO6p/TrBTrineTTDZtXdn9xiInUggjpkmzjmhnIrRZiRh2zJnlmdnDdYlco2Veqz2webkiqlAan/x/SpPGVyFoAhnab7r+/0ss58w2IH7zD8S9p4DeKtc15Io+l4mE8zIJIDpANv2RRwmyTdTtyWkrZkJ4HFOCTwodQ+0vR/FtoTZIsR5Q8/IxCkK01aRxgq5ha4zswZSm5Z7GWAguOcC9zXLnwh1Spq5ug6ch5ebDEuX7vzMPIiyFfwlZKN38jA8BfOMLDtrXc9H7V3ZCQN0WA7QSSj1kgi9LPIqDlCqwIjXh8Wsc41lJNbb05zqKKEnth38shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0k+UG7g2AFiHoKqz5N6F8Nh0QZaYv6ZWw+CeL1KG6o=;
 b=ZzEiRx28SItUjdwJhZwadlqEwoLXoFyfkmqs+vOJ5oryAr0RETkIlzxC+MmbpQ1VISqOai631ouJmXz3AVGbouP6Meuq/yAWeY64613hV0AM4mAOAhKs4XJ/qBooxpV/XRSMw1qtVggE56OHbcf/kDVCQqD0ukNuFAdWU7hY4zU=
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3281.namprd12.prod.outlook.com
 (2603:10b6:408:6e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 18:08:12 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3391.014; Thu, 17 Sep 2020
 18:08:12 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Topic: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Index: AQHWi6ujmhfZVhhGDU+73w4ETczc+6lqhZaAgAKdV/A=
Date: Thu, 17 Sep 2020 18:08:12 +0000
Message-ID: <BN6PR1201MB01460DE7C978CE6D70C6CBF2853E0@BN6PR1201MB0146.namprd12.prod.outlook.com>
References: <20200915220015.2646-1-jonathan.kim@amd.com>
 <20200915220015.2646-3-jonathan.kim@amd.com>
 <DM6PR12MB2761C8F345F1EE8964E2BA968C210@DM6PR12MB2761.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2761C8F345F1EE8964E2BA968C210@DM6PR12MB2761.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-16T02:09:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=70a73957-61af-4352-b5aa-de5dd4898cc5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78014730-dec8-47f7-e54f-08d85b34a425
x-ms-traffictypediagnostic: BN8PR12MB3281:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB32810E4447533380D18A8D8E853E0@BN8PR12MB3281.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lq1LJvHEDGhzJ2zdREuga935BzvJzLxjgPr217E0XSZ9751JXGdL0ZEkfQaD7+v1Gekgz3/TFFQt1bU4oHDSZ2TBEHsurzT9tiKd8CQ8Tn/W1dOAytPnwYQkxBsdhcnX/M1TiYSFX5OBg8nrqSgBdtX53DFt+Lpn5Ng/OzOuOJjiQtB+qbWsNEMbSZeqTqsiW8D18M0TggIppERTzJf7HL9j/0PjxFjs7+VAptkmtJky5mSd2qUhtR2n8WPbmM1bmnh+Y9fjuYzgTbyfOyTMlXw/QvVHWkEWbXo6wPUoJrMh4R1xiXJoOI0rxKS1+QepbpdO8pjQ2MZJ9wBqd5B2kw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(52536014)(5660300002)(478600001)(33656002)(66946007)(6506007)(8676002)(64756008)(8936002)(53546011)(66446008)(76116006)(66556008)(86362001)(66476007)(83380400001)(2906002)(110136005)(55016002)(71200400001)(9686003)(7696005)(186003)(316002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Ll8PTv/VFdLA+cjmzq+d8Z7+/o3Z2igCrzeG36vJ0Z0Iacv2A05/PbQSggWTJCrBndBuuCNiyxrKCRqar3MrbQ2bZkcGkbfF02577cKggf0yKl6cJX4A+nfXRANLEKCnSqxDmQRUG3B4etWvtbuL5h+l7VU2S/MEekZN+2chf/OAoKvu7AKw6fdIU5ydVED2QvFNHn9ofoFKKSq8hbawxAVfJK86QtOYCiVN4bVYQPuh0mCTlnxRuNnM3EbjuyI6OKAM4aSigrJ1scfOufQISgOCRSpTrNU2XJf0ExuNJXKGZfH0r5eM/eHCjEwx1QaHohupQgANYkRcnxhSiJQcMGLOVc+VKrOd1wf71ZlfVxT7xxODuB91XIm5QxdUgxAV/psCmV4MbS16L/8f4vAHU6eLDGjJMs2pCuTP1ggOi9+Ct3fDTwtONYNHw8jZy0AQS4P8zgLOPt1uxvMYtEM4U6BkXFTgOeCGYNwLXBf93oo4RnBWI/95OGkEQTe4O4XR/KAumFVX3rPJ/K74eWG3u8RUD1I91/PEsHQHCLaOP9/QzPuYoqXmw/iIDWFUQtHPLjB2lvsSGRCwqvAOh3YtJcRPfXDUkRxN9MZtPVykPWTSF4enposuNjerfZbY1cYFKHEuTC8+xAyF2itcIntYoA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78014730-dec8-47f7-e54f-08d85b34a425
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 18:08:12.1569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkoug/HTFF4cc27JfavUZCqZ4FF+I3GTXlrPkYaRs8aPgiaC+2TRV17QI7SbUoyS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3281
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Harish.  Thanks for the review.  As discussed offline, patch 2 has a problem where attr groups array is global but allocation is done per-device causing problems with mem free and pmu unregister.  I'm sending out a second series that should fix this and simplify the solution as well as hopefully address your concerns.  Sorry again for the churn.

Jon

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, September 15, 2020 10:10 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> 
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Tuesday, September 15, 2020 6:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim,
> Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: add xgmi perfmons for arcturus
> 
> Add xgmi perfmons for Arcturus.
> 
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 55
> +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  3 ++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index f3d2ac0e88a7..ec521c72e631 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -34,6 +34,8 @@
>  #define NUM_EVENTS_DF_LEGACY		8
>  #define NUM_EVENTS_VEGA20_XGMI		2
>  #define NUM_EVENTS_VEGA20_MAX		2
> +#define NUM_EVENTS_ARCTURUS_XGMI	6
> +#define NUM_EVENTS_ARCTURUS_MAX		6
> 
>  /* record to keep track of pmu entry per pmu type per device */  struct
> amdgpu_pmu_entry { @@ -110,6 +112,27 @@ const struct attribute_group
> *vega20_attr_groups[] = {
>  	NULL
>  };
> 
> +/* Arcturus events */
> +static const char *arcturus_events[NUM_EVENTS_ARCTURUS_MAX][2] = {
> +	{ "xgmi_link0_data_outbound",
> "event=0x7,instance=0x4b,umask=0x2" },
> +	{ "xgmi_link1_data_outbound",
> "event=0x7,instance=0x4c,umask=0x2" },
> +	{ "xgmi_link2_data_outbound",
> "event=0x7,instance=0x4d,umask=0x2" },
> +	{ "xgmi_link3_data_outbound",
> "event=0x7,instance=0x4e,umask=0x2" },
> +	{ "xgmi_link4_data_outbound",
> "event=0x7,instance=0x4f,umask=0x2" },
> +	{ "xgmi_link5_data_outbound",
> "event=0x7,instance=0x50,umask=0x2" } };
> +
> +static struct attribute_group arcturus_event_attr_group = {
> +	.name = "events",
> +	.attrs = NULL
> +};
> +
> +const struct attribute_group *arcturus_attr_groups[] = {
> +	&amdgpu_pmu_format_attr_group,
> +	&arcturus_event_attr_group,
> +	NULL
> +};
> +
>  /* All df_vega20_* items are DEPRECATED. Use vega20_ items above
> instead. */  static const char
> *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
>  	{ "event", "config:0-7" },
> @@ -400,6 +423,16 @@ static int init_pmu_by_type(struct amdgpu_device
> *adev,
> 
>  		pmu_entry->pmu.attr_groups = vega20_attr_groups;
>  		break;
> +	case CHIP_ARCTURUS:
> +		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
> +				arcturus_events, 0,
> NUM_EVENTS_ARCTURUS_XGMI,
> +				PERF_TYPE_AMDGPU_XGMI);
> +		num_events += NUM_EVENTS_ARCTURUS_XGMI;
> +
> +		/* other events can be added here */
> +
> +		pmu_entry->pmu.attr_groups = arcturus_attr_groups;
> +		break;
>  	default:
>  		return -ENODEV;
>  	};
> @@ -530,6 +563,28 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>  			goto err_pmu;
>  		}
> 
> +		break;
> +	case CHIP_ARCTURUS:
> +		ret =
> amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
> +						&fmt_attr,
> +
> 	NUM_FORMATS_AMDGPU_PMU,
> +						&arcturus_event_attr_group,
> +						&evt_attr,
> +
> 	NUM_EVENTS_ARCTURUS_MAX);
> +
> +		if (ret)
> +			goto err_alloc;
> +
> +		ret = init_pmu_by_type(adev,
> +				&amdgpu_pmu_format_attr_group,
> fmt_attr,
> +				&arcturus_event_attr_group, evt_attr,
> +				"Event", "amdgpu",
> PERF_TYPE_AMDGPU_MAX);
> +
> +		if (ret) {
> +			kfree(arcturus_event_attr_group.attrs);
> +			goto err_pmu;
> +		}
> +
>  		break;
>  	default:
>  		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 6e57ae95f997..6b4b30a8dce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -513,6 +513,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device
> *adev, uint64_t config,
> 
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
> +	case CHIP_ARCTURUS:
>  		if (is_add)
>  			return df_v3_6_pmc_add_cntr(adev, config);
> 
> @@ -554,6 +555,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device
> *adev, uint64_t config,
> 
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
> +	case CHIP_ARCTURUS:
>  		ret = df_v3_6_pmc_get_ctrl_settings(adev,
>  			config,
>  			counter_idx,
> @@ -590,6 +592,7 @@ static void df_v3_6_pmc_get_count(struct
> amdgpu_device *adev,
> 
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
> +	case CHIP_ARCTURUS:
>  		df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
>  						&lo_base_addr,
> &hi_base_addr);
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
