Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D9FC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 03:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D042E21D80
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 03:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xsXhOQf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D042E21D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451A76E972;
	Wed, 16 Sep 2020 03:07:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED4D6E250
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 03:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbwQc0vpkenVeKaLh87r3pZff9j1W38X7+80+tAmRdRcsw77AHo7aq+1z0fOYCSMIzzWWWWQvgF+CY1Sj5rFrM/VpVTo/RYBsebo5Cd/P3321oaOAYA2PCkYVSQkm2ADLdNccTWnG6GDLKnZEvA84C6k+Wxm8V3yy88laxgS79E6Uw1OXnS6vKyF3zTrc/hAUKFDOtqAbfqkV2SoJ25HyO8xuMKGRP6munoYJAmYH6LDBR7RDpVKz8NYzuo0+glHUTf4xYqOim5HTCvGPV2eikwSBz47aljRZKR5C5LBveUDBAoEgvvC12brAGHruLBeVtJINqfd8VxBQEdwQvwW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIAy2BiO+XmCP34lxc3Z5JrVY8+5x1kUltGSHIKj9RY=;
 b=kD0kXPr3CKnPXGvLjFTrxtlCMzx76zlkk4gAJMoMt/xaPUQaShAN7IFGqR3Qwu1b2ULusD9GDxfFzbDAa2i1nHHFHfRFgEcrtB1tV74rOqHJyM1lgiGeB49BNxSRsabyA248Zs4bk6+7Y+ZaWOY8omCDAXq1m9GkzCSqazlmzU2Yo/ZSWadeZ98SpBCOefXXWFMIl4l8W+0bNpFuBW1V1t59f3zu1aQxE+zWCAeT1TU4wcKiKOBPlhXtL1Gjtimu1vTbT4EmdPo8DNkzaX9Hx9SMWVMGS9d/pylfFpDn1OA2nxZ1xTOagLXk1dYPKanlWcoBwjTmJPVnxg/0vjVVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIAy2BiO+XmCP34lxc3Z5JrVY8+5x1kUltGSHIKj9RY=;
 b=xsXhOQf6NJmAO2hnM5+Bqx5leM88V8en/Dd278hrpgOVJX5eCzI/+sHIBzVvFc4sy2BP70tHE93gFm7jNdFCHlHdwd2NlcJw9ZVvrJPmXHlCfgPuAAp5O+T8yK2yto42LmH3kzDAZSFvTWIB+w17rYOglesgC28lNVYeyveKjA4=
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3538.namprd12.prod.outlook.com
 (2603:10b6:408:96::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 03:07:40 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 03:07:40 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events
 for vega20
Thread-Topic: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events
 for vega20
Thread-Index: AQHWi6ujgd5W6QZpF0Gdtydiq9BrAalqhS2AgAAMdbA=
Date: Wed, 16 Sep 2020 03:07:40 +0000
Message-ID: <BN6PR1201MB01460CCFC7CCBEBAE8D4EC3A85210@BN6PR1201MB0146.namprd12.prod.outlook.com>
References: <20200915220015.2646-1-jonathan.kim@amd.com>
 <20200915220015.2646-2-jonathan.kim@amd.com>
 <DM6PR12MB2761BC65AFA0B2396F94137A8C210@DM6PR12MB2761.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2761BC65AFA0B2396F94137A8C210@DM6PR12MB2761.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-16T02:08:19Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8217f3b4-1be3-4489-bce5-981c9fa0ea63;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a0:18d:21a8:728:a6bd:f6c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3979869e-57cf-4d1b-a2de-08d859edac37
x-ms-traffictypediagnostic: BN8PR12MB3538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3538DF6544EA5EE745C0AA7485210@BN8PR12MB3538.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1RhUX+uhGtHuxhcSApzWGExEUDDgaI7blchkUWZ/ComzaN5Li7VB5XBbY8XBMBakQEsCZrG5BLA0VaIZCoLEDzVd4kZua/ajnjaYgKmMoJhOyXHMKKn5XFh//NMdhml6evWpRZF1eqnP0zfRYHxfdmeV60dFYMBQ4tB7VKjhCF7DxPldoiCd3sHYQfryvy/g5jPP+PG+DQ2yRuSFQeb94LSEXmOfuRNLskllf0kasmghX2DMw44PdIKfKtXsa/zixxn/v3cQApduSAkDOl2RdGLmsjJSCSZcJDExgvN/dL7kEYa9nlJhq680HqO9lgmswjINnbCvDqDtWk1alXeCYJPY8QE7lcSqN5CndrVYxI9QedNh3iVhDJZo9OygfnmI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(8936002)(71200400001)(76116006)(66446008)(66476007)(66556008)(86362001)(64756008)(66946007)(5660300002)(33656002)(186003)(8676002)(52536014)(7696005)(30864003)(6506007)(55016002)(2906002)(9686003)(110136005)(478600001)(53546011)(316002)(83380400001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DYjPrJzt7PWBIO5cZ06wdHDqFnd4BlEPhkLcgDy/4EEhcDPP/P6gAeObdUiSoAi4W1QclSLmYE/+v3aRhF+TBPDzjXcB7B2G2gNQw6UajqZu0rirTNFm2zh1Bxskt6HrykLZ1TWK69oLyBWfO8IKkL15XjV/ajd/0kIGT4SXs9CvgywyMiNaNIhs+KHP35nHWUSPRbzns3ImBaj8PaxCkZPVQcq3e8m6p1orj3tWQ5ihf9VwyMQpI9oWc03eRoDx3lShuw7ruu3LAtSmaq9tZQcUIYeiPQxC5RAWnVJgK3wcF1JIeRBR+7agGY5C9vhglo6HNzpp+iJgFICQDbf+u6RK0GgBMnTmoVDE5buTmhlrkdf6xYrRW9DQQlPwrG54T9U/gUb66yeNS6QmUtpBRCLpxhUL7SV6x31p540Dotq58mpOZ3UKjNx3W+ECF9z6NMqcfeuyfTuknfuPztuIyplnmXmua2FSjDbP5r8A0nrRR8wFLTiPg9ZIF1/GSnygaqFSLWx/ykQRz8ca5LCUFCBCU2mpBEViRrVoRRZtMiPM3HZAWvsBIF+/NDuj66D0XKS1tvfSKR/OTpRgMUOsaNb7eaZ5JaKOYgmNfzjxJTAER2kLkfKfrif+OVlhUsC5zXU9VGeXzJsOU4F0y0wHkv9SVjfeh3SGlhc3Aa7hHz8202kHw2dKa0ys/0Zr2RDTzOL2MjoJQRp9lFF3o8Z8nQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979869e-57cf-4d1b-a2de-08d859edac37
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 03:07:40.3054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQxGKYqhhgOrAijWPKwT7Li7xZJ0ZDWa+IpdwCPyCtEnhqd16JC3zI6toXiigwak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3538
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



> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Tuesday, September 15, 2020 10:08 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi
> events for vega20
> 
> [AMD Official Use Only - Internal Distribution Only]
> 
> Some comments and a question
> 
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Tuesday, September 15, 2020 6:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kim,
> Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: add per device user friendly xgmi events
> for vega20
> 
> Non-outbound data metrics are non useful so mark them as legacy.
> Bucket new perf counters into device and not device ip.
> Bind events to chip instead of IP.
> Report available event counters and not number of hw counter banks.
> Move DF public macros to private since not needed outside of IP version.
> 
> v2: add comments on sysfs structure and formatting.
> 
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 342
> +++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |   6 +-
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c    |  72 +----
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.h    |   9 -
>  5 files changed, 314 insertions(+), 128 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 13f92dea182a..f43dfdd2716a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1279,19 +1279,6 @@ bool amdgpu_device_load_pci_state(struct
> pci_dev *pdev);
> 
>  #include "amdgpu_object.h"
> 
> -/* used by df_v3_6.c and amdgpu_pmu.c */
> -#define AMDGPU_PMU_ATTR(_name, _object)
> 		\
> -static ssize_t								\
> -_name##_show(struct device *dev,					\
> -			       struct device_attribute *attr,		\
> -			       char *page)				\
> -{									\
> -	BUILD_BUG_ON(sizeof(_object) >= PAGE_SIZE - 1);
> 	\
> -	return sprintf(page, _object "\n");				\
> -}									\
> -									\
> -static struct device_attribute pmu_attr_##_name = __ATTR_RO(_name)
> -
>  static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)  {
>         return adev->gmc.tmz_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 1b0ec715c8ba..f3d2ac0e88a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -27,9 +27,13 @@
>  #include <linux/init.h>
>  #include "amdgpu.h"
>  #include "amdgpu_pmu.h"
> -#include "df_v3_6.h"
> 
>  #define PMU_NAME_SIZE 32
> +#define NUM_FORMATS_AMDGPU_PMU		4
> +#define NUM_FORMATS_DF_LEGACY		3
> +#define NUM_EVENTS_DF_LEGACY		8
> +#define NUM_EVENTS_VEGA20_XGMI		2
> +#define NUM_EVENTS_VEGA20_MAX		2
> 
>  /* record to keep track of pmu entry per pmu type per device */  struct
> amdgpu_pmu_entry { @@ -39,8 +43,106 @@ struct amdgpu_pmu_entry {
>  	unsigned int pmu_perf_type;
>  };
> 
> +struct amdgpu_pmu_event_attribute {
> +	struct device_attribute attr;
> +	const char *event_str;
> +	unsigned int type;
> +};
> +
> +static ssize_t amdgpu_pmu_event_show(struct device *dev,
> +				struct device_attribute *attr, char *buf) {
> +	struct amdgpu_pmu_event_attribute *amdgpu_pmu_attr;
> +
> +	amdgpu_pmu_attr = container_of(attr, struct
> amdgpu_pmu_event_attribute,
> +									attr);
> +
> +	if (!amdgpu_pmu_attr->type)
> +		return sprintf(buf, "%s\n", amdgpu_pmu_attr->event_str);
> +
> +	return sprintf(buf, "%s,type=0x%x\n",
> +			amdgpu_pmu_attr->event_str, amdgpu_pmu_attr-
> >type); }
> +
> +static struct attribute_group amdgpu_pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = NULL,
> +};
> +
> +/*
> + * Event formatting is global to all amdgpu events under sysfs folder
> + * /sys/bus/event_source/devices/amdgpu_<dev_num> where dev_num is
> the
> + * primary device index. Registered events can be found in subfolder
> "events"
> + * and formatting under subfolder "format".
> + *
> + * Formats "event", "instance", and "umask" are currently used by xGMI
> +but can
> + * be for generalized for other IP usage.  If format naming is
> +insufficient
> + * for newly registered IP events, append to the list below and handle
> +the
> + * perf events hardware configuration (see hwc->config) as required by the
> IP.
> + *
> + * Format "type" indicates IP type generated on pmu registration (see
> + * init_pmu_by_type) so non-legacy events omit this in the per-chip
> +event
> + * list (e.g. vega20_events).
> + */
> +static const char
> *amdgpu_pmu_formats[NUM_FORMATS_AMDGPU_PMU][2] = {
> +	{ "event", "config:0-7" },
> +	{ "instance", "config:8-15" },
> +	{ "umask", "config:16-23"},
> +	{ "type", "config:56-63"}
> +};
> +
>  static LIST_HEAD(amdgpu_pmu_list);
> 
> +/* Vega20 events */
> +static const char *vega20_events[NUM_EVENTS_VEGA20_MAX][2] = {
> +	{ "xgmi_link0_data_outbound",
> "event=0x7,instance=0x46,umask=0x2" },
> +	{ "xgmi_link1_data_outbound",
> "event=0x7,instance=0x47,umask=0x2" } };
> +
> +static struct attribute_group vega20_event_attr_group = {
> +	.name = "events",
> +	.attrs = NULL
> +};
> +
> +const struct attribute_group *vega20_attr_groups[] = {
> +	&amdgpu_pmu_format_attr_group,
> +	&vega20_event_attr_group,
> +	NULL
> +};
> +
> +/* All df_vega20_* items are DEPRECATED. Use vega20_ items above
> +instead. */ static const char
> *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
> +	{ "event", "config:0-7" },
> +	{ "instance", "config:8-15" },
> +	{ "umask", "config:16-23"}
> +};
> +
> +static const char *df_vega20_events[NUM_EVENTS_DF_LEGACY][2] = {
> +	{ "cake0_pcsout_txdata", "event=0x7,instance=0x46,umask=0x2" },
> +	{ "cake1_pcsout_txdata", "event=0x7,instance=0x47,umask=0x2" },
> +	{ "cake0_pcsout_txmeta", "event=0x7,instance=0x46,umask=0x4" },
> +	{ "cake1_pcsout_txmeta", "event=0x7,instance=0x47,umask=0x4" },
> +	{ "cake0_ftiinstat_reqalloc", "event=0xb,instance=0x46,umask=0x4" },
> +	{ "cake1_ftiinstat_reqalloc", "event=0xb,instance=0x47,umask=0x4" },
> +	{ "cake0_ftiinstat_rspalloc", "event=0xb,instance=0x46,umask=0x8" },
> +	{ "cake1_ftiinstat_rspalloc", "event=0xb,instance=0x47,umask=0x8" },
> +};
> +
> +static struct attribute_group df_vega20_format_attr_group = {
> +	.name = "format",
> +	.attrs = NULL,
> +};
> +
> +static struct attribute_group df_vega20_event_attr_group = {
> +	.name = "events",
> +	.attrs = NULL
> +};
> +
> +const struct attribute_group *df_vega20_attr_groups[] = {
> +	&df_vega20_format_attr_group,
> +	&df_vega20_event_attr_group,
> +	NULL
> +};
> 
>  /* initialize perf counter */
>  static int amdgpu_perf_event_init(struct perf_event *event) @@ -73,7
> +175,8 @@ static void amdgpu_perf_start(struct perf_event *event, int
> flags)
>  	hwc->state = 0;
> 
>  	switch (pe->pmu_perf_type) {
> -	case PERF_TYPE_AMDGPU_DF:
> +	case PERF_TYPE_AMDGPU_DF_LEGACY:
> +	case PERF_TYPE_AMDGPU_XGMI:
>  		if (!(flags & PERF_EF_RELOAD)) {
>  			target_cntr = pe->adev->df.funcs->pmc_start(pe-
> >adev,
>  						hwc->config, 0 /* unused */,
> @@ -108,7 +211,8 @@ static void amdgpu_perf_read(struct perf_event
> *event)
>  		prev = local64_read(&hwc->prev_count);
> 
>  		switch (pe->pmu_perf_type) {
> -		case PERF_TYPE_AMDGPU_DF:
> +		case PERF_TYPE_AMDGPU_DF_LEGACY:
> +		case PERF_TYPE_AMDGPU_XGMI:
>  			pe->adev->df.funcs->pmc_get_count(pe->adev,
>  						hwc->config, hwc->idx,
> &count);
>  			break;
> @@ -133,7 +237,8 @@ static void amdgpu_perf_stop(struct perf_event
> *event, int flags)
>  		return;
> 
>  	switch (pe->pmu_perf_type) {
> -	case PERF_TYPE_AMDGPU_DF:
> +	case PERF_TYPE_AMDGPU_DF_LEGACY:
> +	case PERF_TYPE_AMDGPU_XGMI:
>  		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc-
> >idx,
>  									0);
>  		break;
> @@ -160,10 +265,15 @@ static int amdgpu_perf_add(struct perf_event
> *event, int flags)
>  						  struct amdgpu_pmu_entry,
>  						  pmu);
> 
> +	if (pe->pmu_perf_type == PERF_TYPE_AMDGPU_MAX)
> +		pe->pmu_perf_type = (hwc->config >>
> AMDGPU_PERF_TYPE_SHIFT) &
> +
> 	AMDGPU_PERF_TYPE_MASK;
> +
>  	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> 
>  	switch (pe->pmu_perf_type) {
> -	case PERF_TYPE_AMDGPU_DF:
> +	case PERF_TYPE_AMDGPU_DF_LEGACY:
> +	case PERF_TYPE_AMDGPU_XGMI:
>  		target_cntr = pe->adev->df.funcs->pmc_start(pe->adev,
>  						hwc->config, 0 /* unused */,
>  						1 /* add counter */);
> @@ -197,7 +307,8 @@ static void amdgpu_perf_del(struct perf_event
> *event, int flags)
>  	amdgpu_perf_stop(event, PERF_EF_UPDATE);
> 
>  	switch (pe->pmu_perf_type) {
> -	case PERF_TYPE_AMDGPU_DF:
> +	case PERF_TYPE_AMDGPU_DF_LEGACY:
> +	case PERF_TYPE_AMDGPU_XGMI:
>  		pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc-
> >idx,
>  									1);
>  		break;
> @@ -208,18 +319,42 @@ static void amdgpu_perf_del(struct perf_event
> *event, int flags)
>  	perf_event_update_userpage(event);
>  }
> 
> -/* vega20 pmus */
> +static void amdgpu_pmu_create_attributes(struct attribute_group
> *attr_group,
> +				struct amdgpu_pmu_event_attribute
> *pmu_attr,
> +				const char *events[][2],
> +				int s_offset,
> +				int e_offset,
> +				unsigned int type)
> +{
> +	int i;
> +
> +	pmu_attr += s_offset;
> +
> +	for (i = s_offset; i < e_offset; i++) {
> +		attr_group->attrs[i] = &pmu_attr->attr.attr;
> +		sysfs_attr_init(&pmu_attr->attr.attr);
> +		pmu_attr->attr.attr.name = events[i][0];
> +		pmu_attr->attr.attr.mode = 0444;
> +		pmu_attr->attr.show = amdgpu_pmu_event_show;
> +		pmu_attr->event_str = events[i][1];
> +		pmu_attr->type = type;
> +		pmu_attr++;
> +	}
> +}
> 
>  /* init pmu tracking per pmu type */
>  static int init_pmu_by_type(struct amdgpu_device *adev,
> -		  const struct attribute_group *attr_groups[],
> -		  char *pmu_type_name, char *pmu_file_prefix,
> -		  unsigned int pmu_perf_type,
> -		  unsigned int num_counters)
> +			struct attribute_group *fmt_attr_group,
> +			struct amdgpu_pmu_event_attribute *fmt_attr,
> +			struct attribute_group *evt_attr_group,
> +			struct amdgpu_pmu_event_attribute *evt_attr,
> +			char *pmu_type_name, char *pmu_file_prefix,
> +			unsigned int pmu_perf_type)
>  {
>  	char pmu_name[PMU_NAME_SIZE];
>  	struct amdgpu_pmu_entry *pmu_entry;
> -	int ret = 0;
> +	bool is_legacy = pmu_perf_type ==
> PERF_TYPE_AMDGPU_DF_LEGACY;
> +	int ret = 0, num_events = 0;
> 
>  	pmu_entry = kzalloc(sizeof(struct amdgpu_pmu_entry),
> GFP_KERNEL);
> 
> @@ -237,59 +372,182 @@ static int init_pmu_by_type(struct
> amdgpu_device *adev,
>  		.task_ctx_nr = perf_invalid_context,
>  	};
> 
> -	pmu_entry->pmu.attr_groups = attr_groups;
> +	amdgpu_pmu_create_attributes(fmt_attr_group, fmt_attr,
> +			is_legacy ? df_vega20_formats :
> amdgpu_pmu_formats, 0,
> +			is_legacy ? NUM_FORMATS_DF_LEGACY :
> +
> 	NUM_FORMATS_AMDGPU_PMU,
> +			0);
> +
> +	if (is_legacy) {
> +		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
> +					df_vega20_events, 0,
> +					NUM_EVENTS_DF_LEGACY,
> +					PERF_TYPE_AMDGPU_DF_LEGACY);
> +		num_events += NUM_EVENTS_DF_LEGACY;
> +
> +		pmu_entry->pmu.attr_groups = df_vega20_attr_groups;
> +		goto legacy_register;
> +	}
> +
> +	switch (adev->asic_type) {
> +	case CHIP_VEGA20:
> +		amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
> +				vega20_events, 0,
> NUM_EVENTS_VEGA20_XGMI,
> +				PERF_TYPE_AMDGPU_XGMI);
> +		num_events += NUM_EVENTS_VEGA20_XGMI;
> +
> +		/* other events can be added here */
> +
> +		pmu_entry->pmu.attr_groups = vega20_attr_groups;
> +		break;
> +	default:
> +		return -ENODEV;
> +	};
> +
> +legacy_register:
>  	pmu_entry->pmu_perf_type = pmu_perf_type;
> -	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d",
> -				pmu_file_prefix, adev_to_drm(adev)-
> >primary->index);
> +	snprintf(pmu_name, PMU_NAME_SIZE, "%s_%d", pmu_file_prefix,
> +					adev_to_drm(adev)->primary-
> >index);
> 
>  	ret = perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
> 
> -	if (ret) {
> -		kfree(pmu_entry);
> -		pr_warn("Error initializing AMDGPU %s PMUs.\n",
> pmu_type_name);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err;
> 
>  	pr_info("Detected AMDGPU %s Counters. # of Counters = %d.\n",
> -			pmu_type_name, num_counters);
> +			pmu_type_name, num_events);
> 
>  	list_add_tail(&pmu_entry->entry, &amdgpu_pmu_list);
> 
>  	return 0;
> +err:
> +	kfree(pmu_entry);
> +	pr_warn("Error initializing AMDGPU %s PMUs.\n", pmu_type_name);
> +	return ret;
> +}
> +
> +/* destroy all pmu data associated with target device */ void
> +amdgpu_pmu_fini(struct amdgpu_device *adev) {
> +	struct amdgpu_pmu_entry *pe, *temp;
> +
> +	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
> +		if (pe->adev == adev) {
> +			list_del(&pe->entry);
> +			perf_pmu_unregister(&pe->pmu);
> +			kfree(pe);
> +		}
> +	}
> +}
> +
> +static int amdgpu_pmu_alloc_pmu_attrs(
> +				struct attribute_group *fmt_attr_group,
> +				struct amdgpu_pmu_event_attribute
> **fmt_attr,
> +				int fmt_num_attrs,
> +				struct attribute_group *evt_attr_group,
> +				struct amdgpu_pmu_event_attribute
> **evt_attr,
> +				int evt_num_attrs)
> +{
> 
> where do all these allocations get freed?

Thanks for the mem leak catch.  I'll free these up in amdgpu_pmu_fini after pmu unregister and fix the bad ENOMEM condition checks below.

Jon

> 
> +	*fmt_attr = kcalloc(fmt_num_attrs, sizeof(**fmt_attr),
> GFP_KERNEL);
> +
> +	if (!fmt_attr)
> 
> 
> I think you want to check *fmt_attr
> 
> +		return -ENOMEM;
> +
> +	fmt_attr_group->attrs = kcalloc(fmt_num_attrs + 1,
> +				sizeof(*fmt_attr_group->attrs),
> GFP_KERNEL);
> +
> +	if (!fmt_attr_group->attrs)
> +		goto err_fmt_attr_grp;
> +
> +	*evt_attr = kcalloc(evt_num_attrs, sizeof(**evt_attr), GFP_KERNEL);
> +
> +	if (!evt_attr)
> 
> I think you want to check *evt_attr
> 
> +		goto err_evt_attr;
> +
> +	evt_attr_group->attrs = kcalloc(evt_num_attrs + 1,
> +				sizeof(*evt_attr_group->attrs), GFP_KERNEL);
> +
> +	if (!evt_attr_group->attrs)
> +		goto err_evt_attr_grp;
> +
> +	return 0;
> +err_evt_attr_grp:
> +	kfree(*evt_attr);
> +err_evt_attr:
> +	kfree(fmt_attr_group->attrs);
> +err_fmt_attr_grp:
> +	kfree(*fmt_attr);
> +	return -ENOMEM;
>  }
> 
>  /* init amdgpu_pmu */
>  int amdgpu_pmu_init(struct amdgpu_device *adev)  {
> +	struct amdgpu_pmu_event_attribute *fmt_attr = NULL, *evt_attr =
> NULL,
> +				*old_fmt_attr = NULL, *old_evt_attr = NULL;
>  	int ret = 0;
> 
> +	if (adev->asic_type != CHIP_VEGA20)
> +		goto init_events;
> +
> +	ret =
> amdgpu_pmu_alloc_pmu_attrs(&df_vega20_format_attr_group,
> +					&old_fmt_attr,
> +					NUM_FORMATS_DF_LEGACY,
> +					&df_vega20_event_attr_group,
> +					&old_evt_attr,
> +					NUM_EVENTS_DF_LEGACY);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = init_pmu_by_type(adev,
> +				&df_vega20_format_attr_group,
> old_fmt_attr,
> +				&df_vega20_event_attr_group, old_evt_attr,
> +				"DF", "amdgpu_df",
> PERF_TYPE_AMDGPU_DF_LEGACY);
> +	if (ret)
> +		goto err_old_pmu;
> +
> +init_events:
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
> -		/* init df */
> -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> -				       "DF", "amdgpu_df",
> PERF_TYPE_AMDGPU_DF,
> -				       DF_V3_6_MAX_COUNTERS);
> +		ret =
> amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
> +						&fmt_attr,
> +
> 	NUM_FORMATS_AMDGPU_PMU,
> +						&vega20_event_attr_group,
> +						&evt_attr,
> +
> 	NUM_EVENTS_VEGA20_MAX);
> +
> +		if (ret)
> +			goto err_alloc;
> +
> +		ret = init_pmu_by_type(adev,
> +				&amdgpu_pmu_format_attr_group,
> fmt_attr,
> +				&vega20_event_attr_group, evt_attr,
> +				"Event", "amdgpu",
> PERF_TYPE_AMDGPU_MAX);
> +
> +		if (ret) {
> +			kfree(vega20_event_attr_group.attrs);
> +			goto err_pmu;
> +		}
> 
> -		/* other pmu types go here*/
>  		break;
>  	default:
>  		return 0;
> -	}
> +	};
> 
>  	return 0;
> -}
> -
> -
> -/* destroy all pmu data associated with target device */ -void
> amdgpu_pmu_fini(struct amdgpu_device *adev) -{
> -	struct amdgpu_pmu_entry *pe, *temp;
> -
> -	list_for_each_entry_safe(pe, temp, &amdgpu_pmu_list, entry) {
> -		if (pe->adev == adev) {
> -			list_del(&pe->entry);
> -			perf_pmu_unregister(&pe->pmu);
> -			kfree(pe);
> -		}
> -	}
> +err_pmu:
> +	kfree(fmt_attr);
> +	kfree(evt_attr);
> +	kfree(amdgpu_pmu_format_attr_group.attrs);
> +err_alloc:
> +	if (adev->asic_type == CHIP_VEGA20)
> +		amdgpu_pmu_fini(adev);
> +	return ret;
> +err_old_pmu:
> +	kfree(old_fmt_attr);
> +	kfree(old_evt_attr);
> +	kfree(df_vega20_format_attr_group.attrs);
> +	kfree(df_vega20_event_attr_group.attrs);
> +	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> index 7dddb7160a11..0d214abe720e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> @@ -27,10 +27,14 @@
>  #define _AMDGPU_PMU_H_
> 
>  enum amdgpu_pmu_perf_type {
> -	PERF_TYPE_AMDGPU_DF = 0,
> +	PERF_TYPE_AMDGPU_DF_LEGACY = 0,
> +	PERF_TYPE_AMDGPU_XGMI,
>  	PERF_TYPE_AMDGPU_MAX
>  };
> 
> +#define AMDGPU_PERF_TYPE_SHIFT	56
> +#define AMDGPU_PERF_TYPE_MASK	0xff
> +
>  int amdgpu_pmu_init(struct amdgpu_device *adev);  void
> amdgpu_pmu_fini(struct amdgpu_device *adev);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 0ca6e176acb0..6e57ae95f997 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -30,71 +30,17 @@
>  #define DF_3_6_SMN_REG_INST_DIST        0x8
>  #define DF_3_6_INST_CNT                 8
> 
> -static u32 df_v3_6_channel_number[] = {1, 2, 0, 4, 0, 8, 0,
> -				       16, 32, 0, 0, 0, 2, 4, 8};
> -
> -/* init df format attrs */
> -AMDGPU_PMU_ATTR(event,		"config:0-7");
> -AMDGPU_PMU_ATTR(instance,	"config:8-15");
> -AMDGPU_PMU_ATTR(umask,		"config:16-23");
> -
> -/* df format attributes  */
> -static struct attribute *df_v3_6_format_attrs[] = {
> -	&pmu_attr_event.attr,
> -	&pmu_attr_instance.attr,
> -	&pmu_attr_umask.attr,
> -	NULL
> -};
> -
> -/* df format attribute group */
> -static struct attribute_group df_v3_6_format_attr_group = {
> -	.name = "format",
> -	.attrs = df_v3_6_format_attrs,
> -};
> +/* Defined in global_features.h as FTI_PERFMON_VISIBLE */
> +#define DF_V3_6_MAX_COUNTERS		4
> 
> -/* df event attrs */
> -AMDGPU_PMU_ATTR(cake0_pcsout_txdata,
> -		      "event=0x7,instance=0x46,umask=0x2");
> -AMDGPU_PMU_ATTR(cake1_pcsout_txdata,
> -		      "event=0x7,instance=0x47,umask=0x2");
> -AMDGPU_PMU_ATTR(cake0_pcsout_txmeta,
> -		      "event=0x7,instance=0x46,umask=0x4");
> -AMDGPU_PMU_ATTR(cake1_pcsout_txmeta,
> -		      "event=0x7,instance=0x47,umask=0x4");
> -AMDGPU_PMU_ATTR(cake0_ftiinstat_reqalloc,
> -		      "event=0xb,instance=0x46,umask=0x4");
> -AMDGPU_PMU_ATTR(cake1_ftiinstat_reqalloc,
> -		      "event=0xb,instance=0x47,umask=0x4");
> -AMDGPU_PMU_ATTR(cake0_ftiinstat_rspalloc,
> -		      "event=0xb,instance=0x46,umask=0x8");
> -AMDGPU_PMU_ATTR(cake1_ftiinstat_rspalloc,
> -		      "event=0xb,instance=0x47,umask=0x8");
> -
> -/* df event attributes  */
> -static struct attribute *df_v3_6_event_attrs[] = {
> -	&pmu_attr_cake0_pcsout_txdata.attr,
> -	&pmu_attr_cake1_pcsout_txdata.attr,
> -	&pmu_attr_cake0_pcsout_txmeta.attr,
> -	&pmu_attr_cake1_pcsout_txmeta.attr,
> -	&pmu_attr_cake0_ftiinstat_reqalloc.attr,
> -	&pmu_attr_cake1_ftiinstat_reqalloc.attr,
> -	&pmu_attr_cake0_ftiinstat_rspalloc.attr,
> -	&pmu_attr_cake1_ftiinstat_rspalloc.attr,
> -	NULL
> -};
> -
> -/* df event attribute group */
> -static struct attribute_group df_v3_6_event_attr_group = {
> -	.name = "events",
> -	.attrs = df_v3_6_event_attrs
> -};
> +/* get flags from df perfmon config */
> +#define DF_V3_6_GET_EVENT(x)		(x & 0xFFUL)
> +#define DF_V3_6_GET_INSTANCE(x)		((x >> 8) & 0xFFUL)
> +#define DF_V3_6_GET_UNITMASK(x)		((x >> 16) & 0xFFUL)
> +#define DF_V3_6_PERFMON_OVERFLOW	0xFFFFFFFFFFFFULL
> 
> -/* df event attr groups  */
> -const struct attribute_group *df_v3_6_attr_groups[] = {
> -		&df_v3_6_format_attr_group,
> -		&df_v3_6_event_attr_group,
> -		NULL
> -};
> +static u32 df_v3_6_channel_number[] = {1, 2, 0, 4, 0, 8, 0,
> +				       16, 32, 0, 0, 0, 2, 4, 8};
> 
>  static uint64_t df_v3_6_get_fica(struct amdgpu_device *adev,
>  				 uint32_t ficaa_val)
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
> index 76998541bc30..2505c7ef258a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.h
> @@ -35,15 +35,6 @@ enum DF_V3_6_MGCG {
>  	DF_V3_6_MGCG_ENABLE_63_CYCLE_DELAY = 15  };
> 
> -/* Defined in global_features.h as FTI_PERFMON_VISIBLE */
> -#define DF_V3_6_MAX_COUNTERS		4
> -
> -/* get flags from df perfmon config */
> -#define DF_V3_6_GET_EVENT(x)		(x & 0xFFUL)
> -#define DF_V3_6_GET_INSTANCE(x)		((x >> 8) & 0xFFUL)
> -#define DF_V3_6_GET_UNITMASK(x)		((x >> 16) & 0xFFUL)
> -#define DF_V3_6_PERFMON_OVERFLOW	0xFFFFFFFFFFFFULL
> -
>  extern const struct attribute_group *df_v3_6_attr_groups[];  extern const
> struct amdgpu_df_funcs df_v3_6_funcs;
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
