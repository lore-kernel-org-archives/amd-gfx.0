Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D09FC43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 12:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6AF820882
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 12:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CZragXMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AF820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273A06E096;
	Thu, 10 Sep 2020 12:47:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ED36E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 12:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGKHPnX3MW4HDQMYEP4sVc6LNTCjciOHXXXu7+xmS+uBkqICSTfNKxKJBJBYaDkJwxkjRomfPWNz7qySjZeYoM1YFNUZl/SxrIL39Q0nEG7oP/Kym8yDVw8JIM0+u79C1El9B4XFr5+hhZmKOAnLu8oDes5WdTkf4XseH4VEyYzEfY7oUAue9IR+doS+Tlv02a0vPaqROwgYqZCYmDuMXRNlERgZXq7a6KprizAtInHWqlMN64rAHB7Gw6y+9dll9jOp/ZZoLnH1uqQIu1BjvM5JvOvaZTJgzaJWv2aT1e3YurEDr3qUKZ5LrKNvXGTv9sgLZ9j8kuRUFuIaht18nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgLrMHjj8xXVub0Oz8TqP3CTMrUi1HPDJFoP2dXay5Q=;
 b=bWkSuvv5Q2HriuEymp2/PpaQOJqbHDabLOwY0U5l/dT/XH8s7A63rBSKG5niNH0SOnw339UjuEoIVUfaFV/xPIry/kTjPOZ9yozuqgerJgLqabkglk8zo/MTVrNmhWQxLcy8xh7XrxemQi5WO5TDAq3qHV1cSzBGy/jvK4jY86W4/ZcjB8tNMsb+sz7MqBLIj19/3/O13Eh3m5+vo5fcl/O91YS5RF++GaV2fKEVOOq8Ed0m3jST1kS9lx6EByKIdKup7E6/+0mXhDMzX2b6uL/kvGqFrzr2RrrRTFojRrledJwOqIniIz2BMabi+/ZB1H/NfVX8fFTrK+y7roVfdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgLrMHjj8xXVub0Oz8TqP3CTMrUi1HPDJFoP2dXay5Q=;
 b=CZragXMMmxRZ/5c68orbMSO3d6hZVlW/8AscsWD3xiqJvRKL1ci6FgowSW/9DnzieNr67zBD/nGgIS1i3nDzIXwwcA2IwKtJ0iWC4tYCLCDqyaI5HpCtaWa10YGl8hVY3exlztttzTg1p5y2Z8vWJFa5okHBFZgSmxDEk4KiiE8=
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB2884.namprd12.prod.outlook.com
 (2603:10b6:408:97::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 12:47:03 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 12:47:03 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Topic: [PATCH 4/4] drm/amdgpu: add xgmi perfmons for arcturus
Thread-Index: AQHWheDrF8rhVLFyYEK/teIVTD+zLKlh1R1g
Date: Thu, 10 Sep 2020 12:47:03 +0000
Message-ID: <BN6PR1201MB0146471F6A9AFADCDB54B6E085270@BN6PR1201MB0146.namprd12.prod.outlook.com>
References: <20200908130603.10344-1-jonathan.kim@amd.com>
 <20200908130603.10344-4-jonathan.kim@amd.com>
In-Reply-To: <20200908130603.10344-4-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4e633383-4e9e-481f-8770-9b0622fe3497;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-10T12:46:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a0:18d:199e:16b4:ede3:a606]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b671e4bb-2efd-49f5-b5e7-08d855879e5e
x-ms-traffictypediagnostic: BN8PR12MB2884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB2884F53AE6F89AA74861D61585270@BN8PR12MB2884.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6lzsWhKiGPRQYkEDgPophb4W9Ti1YcNNA1xMnIly39EjdQEcE39+pSE1lSgFplQ6yhiSGWIgkEiioQuSFyoBwBY+mMQC3kgRJhlJc9qBEuLEcMs5XlQ0/XUB0AFgaGPFnY617TQPM9PVCyZdUHiNWjmX+RqExl7bYnboHoywPvh63QmnH21S6q5Q952Za0+i9e726yPwjNY6KovMIyuGEN1jrxICP+xigvxnwSdXORN0kSbB3ZstpA+wJFtPr0H5GNBcJJTWC4G4x5S1tJh2Y3pcepXJZu0dED/ETqXJRE1uL8xLHmEDpXBjMnDfN8Pbq9yJYtLFRmnY/vpf4QI0JA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(66946007)(66446008)(9686003)(71200400001)(6506007)(64756008)(76116006)(7696005)(53546011)(186003)(83380400001)(86362001)(316002)(478600001)(55016002)(52536014)(66476007)(66556008)(110136005)(4326008)(2906002)(8676002)(5660300002)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UemXfFbtwbdC5vtjlQiP3WPlbqv4HLTwS8lxUt5QNomS4V360mq8SaLlOX0Ec/pY2VyKMBiEiW7ruwoR/Dz6MDN5fUC91CMDORI0vfkSZ+yN701ayozaKD8lHnhH8UnTf9HwPkC7lteN6a0IPNXhmuS1bzEEEYQdwJT7qAruDppP1WonYsUmI+FsO1zqfJuRCHMNv8uTECs6mQkvZOsNR27sSsJpHzg+nw5rZBk5RYE/i2fu0dAfQGLtOFZdC5+bbqGEqp0iJw0dK02AvvUQy2DNunzBS3eZoPwGxZ1Gvvg+A+xI4nN5WDiyp0LPzevVq4q7bhwgeQnHwoPUsArpw5xPGLNOemICjgynSS7i/Bd9Heu9F4K6DUXGHQbi/Pp5YpJ8rWRU+VLOVcCF/tHIBgnu7b3kz8hgFhqB42MHEqfUpehRxzxUQOaY9+1l2yBR7KGBYpaktsoELKOBAiDZ88WX3IuSeULc7+RXbFe3VcPBXSb3QnpTvUn4gl/gjoymphzEITcCDgF6AjWbnX934oi/CEDLSyvM3kyS5E7ayTH159ZL77LlU/rLbUtiV3dP8e0rrz2y60MPxckeNnObf90RqouGcFtbQW6CMcDX3gnPmtHCH8WyHz0T+RU+f9KNqFAlezPsya8fsZdmTgJXybFkVBgR/CMyRl5feXKhhB/aSJ6wSCWISjFk0z+UJnK+N/CT8PrVjwkAoNv6dUaJog==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b671e4bb-2efd-49f5-b5e7-08d855879e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 12:47:03.7838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl71mPF7iN2tYPq1w/U634i6GNQ4hCn0Vvs83oLSbt3o/I5Y0nTSbI7c4tVZgPDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2884
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping.

Thanks,

Jon

> -----Original Message-----
> From: Kim, Jonathan <jonathan.kim@amd.com>
> Sent: Tuesday, September 8, 2020 9:07 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: add xgmi perfmons for arcturus
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
> index 82f57bd38716..4adf9c6e3944 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -34,6 +34,8 @@
>  #define NUM_EVENTS_DF_LEGACY8
>  #define NUM_EVENTS_VEGA20_XGMI2
>  #define NUM_EVENTS_VEGA20_MAX2
> +#define NUM_EVENTS_ARCTURUS_XGMI6
> +#define NUM_EVENTS_ARCTURUS_MAX6
>
>  /* record to keep track of pmu entry per pmu type per device */  struct
> amdgpu_pmu_entry { @@ -95,6 +97,27 @@ const struct attribute_group
> *vega20_attr_groups[] = {
>  NULL
>  };
>
> +/* Arcturus events */
> +static const char *arcturus_events[NUM_EVENTS_ARCTURUS_MAX][2] = {
> +{ "xgmi_link0_data_outbound",
> "event=0x7,instance=0x4b,umask=0x2" },
> +{ "xgmi_link1_data_outbound",
> "event=0x7,instance=0x4c,umask=0x2" },
> +{ "xgmi_link2_data_outbound",
> "event=0x7,instance=0x4d,umask=0x2" },
> +{ "xgmi_link3_data_outbound",
> "event=0x7,instance=0x4e,umask=0x2" },
> +{ "xgmi_link4_data_outbound",
> "event=0x7,instance=0x4f,umask=0x2" },
> +{ "xgmi_link5_data_outbound",
> "event=0x7,instance=0x50,umask=0x2" } };
> +
> +static struct attribute_group arcturus_event_attr_group = {
> +.name = "events",
> +.attrs = NULL
> +};
> +
> +const struct attribute_group *arcturus_attr_groups[] = {
> +&amdgpu_pmu_format_attr_group,
> +&arcturus_event_attr_group,
> +NULL
> +};
> +
>  /* All df_vega20_* items are DEPRECATED. Use vega20_ items above
> instead. */  static const char
> *df_vega20_formats[NUM_FORMATS_DF_LEGACY][2] = {
>  { "event", "config:0-7" },
> @@ -380,6 +403,16 @@ static int init_pmu_by_type(struct amdgpu_device
> *adev,
>
>  pmu_entry->pmu.attr_groups = vega20_attr_groups;
>  break;
> +case CHIP_ARCTURUS:
> +amdgpu_pmu_create_attributes(evt_attr_group, evt_attr,
> +arcturus_events, 0,
> NUM_EVENTS_ARCTURUS_XGMI,
> +PERF_TYPE_AMDGPU_XGMI);
> +num_events += NUM_EVENTS_ARCTURUS_XGMI;
> +
> +/* other events can be added here */
> +
> +pmu_entry->pmu.attr_groups = arcturus_attr_groups;
> +break;
>  default:
>  return -ENODEV;
>  };
> @@ -510,6 +543,28 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>  goto err_pmu;
>  }
>
> +break;
> +case CHIP_ARCTURUS:
> +ret =
> amdgpu_pmu_alloc_pmu_attrs(&amdgpu_pmu_format_attr_group,
> +&fmt_attr,
> +
> NUM_FORMATS_AMDGPU_PMU,
> +&arcturus_event_attr_group,
> +&evt_attr,
> +
> NUM_EVENTS_ARCTURUS_MAX);
> +
> +if (ret)
> +goto err_alloc;
> +
> +ret = init_pmu_by_type(adev,
> +&amdgpu_pmu_format_attr_group,
> fmt_attr,
> +&arcturus_event_attr_group, evt_attr,
> +"Event", "amdgpu",
> PERF_TYPE_AMDGPU_MAX);
> +
> +if (ret) {
> +kfree(arcturus_event_attr_group.attrs);
> +goto err_pmu;
> +}
> +
>  break;
>  default:
>  return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 569c40be6e75..23af431de997 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -512,6 +512,7 @@ static int df_v3_6_pmc_start(struct amdgpu_device
> *adev, uint64_t config,
>
>  switch (adev->asic_type) {
>  case CHIP_VEGA20:
> +case CHIP_ARCTURUS:
>  if (is_add)
>  return df_v3_6_pmc_add_cntr(adev, config);
>
> @@ -553,6 +554,7 @@ static int df_v3_6_pmc_stop(struct amdgpu_device
> *adev, uint64_t config,
>
>  switch (adev->asic_type) {
>  case CHIP_VEGA20:
> +case CHIP_ARCTURUS:
>  ret = df_v3_6_pmc_get_ctrl_settings(adev,
>  config,
>  counter_idx,
> @@ -589,6 +591,7 @@ static void df_v3_6_pmc_get_count(struct
> amdgpu_device *adev,
>
>  switch (adev->asic_type) {
>  case CHIP_VEGA20:
> +case CHIP_ARCTURUS:
>  df_v3_6_pmc_get_read_settings(adev, config, counter_idx,
>  &lo_base_addr,
> &hi_base_addr);
>
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
