Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50FFC43461
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 13:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF50204FD
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 13:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zbCLKcOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF50204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FA946EA25;
	Fri,  4 Sep 2020 13:48:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A64F6EA25
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 13:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NThobPi+5QhtAPapzpOjce3NL9MxThqucYKwMbkvjpB3QJYDRa2xcKy53BxA3F0wXkBon9/UBil9qGbaZT87A0VSPbJfqJnJO5bP6QXjAApyRv6Raq7AdWSlPS1PabH6qrlDJB6mElKskKbnnvqH3p+hke6SC9DPYYA2szFEDtleYdCHZ9d1x19CFFG+fmQD8+CcoFPdCdHgZn8LVbp9OFkmQfxfWhokJKhAlVUn3OCwL+FsZmVwV8gNLrZJKrO0EZ5l/TWlvRe0rU+WRNPoieQcMINF8BOHyRPvSBCBSngiQ8CShfCcVvGGkcYaDFd7gRyRd3GlZDV4LPQ9s3u5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6ajETHDCgq2kme+JZ1xO88AF+zzFOBkQQYjWBlM3lg=;
 b=S3bXK4VaBgKPjk06WcknW767A3rjY/0pBtHcWvi6WO7LcBfT5j5DLifBux33mwhzrROS/EqSaFoCCot7KpcIofJZDW1wfhkJxlQkJhac052XEniLwW66BjGg3gT2UQ2aHgYiOXesqtakOyh5kOxCnSmjp0j7481A3ARbL3KLGHGnvoriRKSHFgDU9iAqlm9GEajPjtB1hldX06sp3bk4N9T0g281Jr2PB4SL8crSp2kqLzyezCJwjqbBX8caJWaVk7aKPuygHLyv4oGPDvosHzI7+akZSADqSIa56Uhhd2m8bpNu2z9ag4Rza5Xet6E60UtqeSFXyAT6PcDQbE110A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6ajETHDCgq2kme+JZ1xO88AF+zzFOBkQQYjWBlM3lg=;
 b=zbCLKcOv1MCd4poZdrpX7Ljmg+k2lxOicr+/DCqyZP+ihlMf0fJXx7tC9fD5vBlaEd3zeU/q103c4Nm0c0sB4Xr++OO316/pSL41na/nFFr8+/53f0qA4eX/wtm3OphA39GS7V0BD4eLfaVRg+AEs2R1VOr+6jh6inBoUQfdVjw=
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 (2603:10b6:405:59::18) by BN8PR12MB3073.namprd12.prod.outlook.com
 (2603:10b6:408:66::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 13:48:05 +0000
Received: from BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be]) by BN6PR1201MB0146.namprd12.prod.outlook.com
 ([fe80::615d:bea9:8838:92be%4]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 13:48:05 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/6] drm/amdgpu: add user friendly xgmi events
Thread-Topic: [PATCH 5/6] drm/amdgpu: add user friendly xgmi events
Thread-Index: AQHWgg5ih4Sw377i5UmGLmDeRwXndKlYf5IA
Date: Fri, 4 Sep 2020 13:48:05 +0000
Message-ID: <BN6PR1201MB0146474EE39F8CC7C3AE3437852D0@BN6PR1201MB0146.namprd12.prod.outlook.com>
References: <20200903162154.55694-1-jonathan.kim@amd.com>
 <20200903162154.55694-5-jonathan.kim@amd.com>
In-Reply-To: <20200903162154.55694-5-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=27ba7796-602e-4d3e-b489-3110e9d38d06;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-04T13:46:52Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:7a0:500a:c9c6:2527:4169:9026]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05c022be-180a-4f19-fc36-08d850d9268b
x-ms-traffictypediagnostic: BN8PR12MB3073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3073990080F30A4CCA07A39D852D0@BN8PR12MB3073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:538;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yfWKt3mb/l3v0Yq37q5lrzE1eYGQ5TFhd0abvgvYlryEIMpZM4wR4DdyQBUSyhntPgATNF7h593iIF19Tz+9ZYVE3dWTkyiB+jjgErmG72cz/3YwfBAS0ZmbuMuFFcE/N5OUECyLf6TuNfCN9juerz1GZHDrgwGJqXDkWhHSUWtIfMa3KW310SX1VSr3fmHZloDbjypc5QZ5DXh09jYfaopj9jlqUSyFhq/GcL0Y/YQ6wY+zgnSiivvx/S8gF+hdIlcvJX3opUfTyfrSD4mt01UeOVjHXnz/ViGiZ09+zkW2LACUDKD0iRKJmEZPeircXJnovUcmJ/g/66uAucL2+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(8676002)(33656002)(2906002)(52536014)(83380400001)(8936002)(55016002)(4326008)(9686003)(6506007)(53546011)(66946007)(86362001)(478600001)(316002)(76116006)(71200400001)(66476007)(66446008)(66556008)(5660300002)(7696005)(6916009)(186003)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nOfwL5Wf9KNcjd17wuT3uA4oflxOtR8V7BPnURXIVw/l5FoSslmULw1ol91lnuhVYCCL+36grCW/RyrQLWwH09jkoCxxcI8syCSUSJkVJhDSzqehEZrNztiiY5112rmlWmemYOySxMoKKKmnvWWF5u+6/Sq5b4GGZg3sVFi6T1G+4KCt+LvlZ52dQHU7tRt1Cf/NJtrtnDCk+vAwnUy+iz1Nhn5B4n5CS7UwSuBuk2+xhuxpGQhF3WTGcLlI9TDMImok9MKfhR7Xoj+F9dy9aIfaAEXJer2Dk3qmnkm2biOuc5fx8ok437pdARNq6Up72rCsABaXmcRZ01l7kkqxps5o8rtiY1itq2E0UqQYbzDKqwGDDz1+/46uffRLcxGlJxchitW9V1e6ggIuPOOiGgYaMy9bBOR5MIsoUZUxr9s0D55MhAAvzcXuuMytvLfzK2SiPr9hkWWBpUyNSuiYGycn1UaA54YMu+NTKGvWHyeVEvbP3nory4N0P30uiLZLfa05o8yXcar9FpiYRofpvwi1YrCH8jM0+5vxUtRUOMXGZ8u/z4oQo4KcV/7AQSkWQn25X3NWLR4Lri0sSuK2DK9/+zVW6bZ+f+7+SpP2T/DyDxpX5a5uVEDGJYEdgrboREV19ulHd4GplGKFvcQXE5CwtueZRe1JdzdpwYGx2rCK6u39l94oeDrcBMcZtwCNvkLMVbfyLjb5M3mGkhfAJQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c022be-180a-4f19-fc36-08d850d9268b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 13:48:05.6679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /AQsE6nOYAFdVpM8bU0Ygd0/PJOjfHdJEuFkllOHMOUmjjyvqWE0llrqHmIYKb7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
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

Please ignore patches 5 & 6.   We'll run into EEXIST if future non xgmi counters are added to amdgpu_x this way.

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Thursday, September 3, 2020 12:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH 5/6] drm/amdgpu: add user friendly xgmi events
>
> Non-outbound data is useless for throughput metrics.  Add human readable
> events and note deprecated events.  New events are now per-device and not
> per-device-per-ip.
>
> Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 38
> +++++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h |  1 +
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 517448aa2d50..eaa44c99d423 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -31,6 +31,7 @@
>  #define PMU_NAME_SIZE 32
>  #define NUM_FORMATS_DF_VEGA203
>  #define NUM_EVENTS_DF_VEGA208
> +#define NUM_EVENTS_XGMI_VEGA202
>
>  /* record to keep track of pmu entry per pmu type per device */  struct
> amdgpu_pmu_entry { @@ -52,18 +53,33 @@ static struct attribute_group
> df_vega20_event_attr_group = {
>  .attrs = NULL
>  };
>
> +static struct attribute_group xgmi_vega20_event_attr_group = {
> +.name = "events",
> +.attrs = NULL
> +};
> +
>  const struct attribute_group *df_vega20_attr_groups[] = {
>  &df_vega20_format_attr_group,
>  &df_vega20_event_attr_group,
>  NULL
>  };
>
> +const struct attribute_group *xgmi_vega20_attr_groups[] = {
> +&df_vega20_format_attr_group,
> +&xgmi_vega20_event_attr_group,
> +NULL
> +};
> +
>  static const char *df_vega20_formats[NUM_FORMATS_DF_VEGA20][2] = {
>  { "event", "config:0-7" },
>  { "instance", "config:8-15" },
>  { "umask", "config:16-23"}
>  };
>
> +/*
> + * DF events for xGMI - DEPRECATED.
> + * Potential for non-xgmi DF counters in the future.
> + */
>  static const char *df_vega20_events[NUM_EVENTS_DF_VEGA20][2] = {
>  { "cake0_pcsout_txdata", "event=0x7,instance=0x46,umask=0x2" },
>  { "cake1_pcsout_txdata", "event=0x7,instance=0x47,umask=0x2" },
> @@ -75,6 +91,11 @@ static const char
> *df_vega20_events[NUM_EVENTS_DF_VEGA20][2] = {
>  { "cake1_ftiinstat_rspalloc", "event=0xb,instance=0x47,umask=0x8" },
> };
>
> +static const char *xgmi_vega20_events[NUM_EVENTS_XGMI_VEGA20][2] =
> {
> +{ "xgmi_link0_data_outbound",
> "event=0x7,instance=0x46,umask=0x2" },
> +{ "xgmi_link1_data_outbound",
> "event=0x7,instance=0x47,umask=0x2" } };
> +
>  /* initialize perf counter */
>  static int amdgpu_perf_event_init(struct perf_event *event)  { @@ -106,6
> +127,7 @@ static void amdgpu_perf_start(struct perf_event *event, int
> flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> +case PERF_TYPE_AMDGPU_XGMI:
>  if (!(flags & PERF_EF_RELOAD))
>  pe->adev->df.funcs->pmc_start(pe->adev, hwc-
> >config,
>  hwc->idx, 1);
> @@ -136,6 +158,7 @@ static void amdgpu_perf_read(struct perf_event
> *event)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> +case PERF_TYPE_AMDGPU_XGMI:
>  pe->adev->df.funcs->pmc_get_count(pe->adev,
>  hwc->config, hwc->idx,
> &count);
>  break;
> @@ -161,6 +184,7 @@ static void amdgpu_perf_stop(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> +case PERF_TYPE_AMDGPU_XGMI:
>  pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc-
> >idx,
>  0);
>  break;
> @@ -192,6 +216,7 @@ static int amdgpu_perf_add(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> +case PERF_TYPE_AMDGPU_XGMI:
>  retval = pe->adev->df.funcs->pmc_start(pe->adev,
>  hwc->config, hwc->idx, 1);
>  if (retval >= 0) {
> @@ -226,6 +251,7 @@ static void amdgpu_perf_del(struct perf_event
> *event, int flags)
>
>  switch (pe->pmu_perf_type) {
>  case PERF_TYPE_AMDGPU_DF:
> +case PERF_TYPE_AMDGPU_XGMI:
>  pe->adev->df.funcs->pmc_stop(pe->adev, hwc->config, hwc-
> >idx,
>  1);
>  break;
> @@ -346,6 +372,18 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>  df_vega20_events,
>  &df_vega20_event_attr_group,
>  NUM_EVENTS_DF_VEGA20);
> +if (ret)
> +break;
> +
> +/* init xgmi */
> +ret = init_pmu_by_type(adev, xgmi_vega20_attr_groups,
> +"XGMI", "amdgpu",
> PERF_TYPE_AMDGPU_XGMI,
> +df_vega20_formats,
> +&df_vega20_format_attr_group,
> +NUM_FORMATS_DF_VEGA20,
> +xgmi_vega20_events,
> +&xgmi_vega20_event_attr_group,
> +NUM_EVENTS_XGMI_VEGA20);
>
>  /* other pmu types go here*/
>  break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> index 7dddb7160a11..2f1a80c42dbf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.h
> @@ -28,6 +28,7 @@
>
>  enum amdgpu_pmu_perf_type {
>  PERF_TYPE_AMDGPU_DF = 0,
> +PERF_TYPE_AMDGPU_XGMI,
>  PERF_TYPE_AMDGPU_MAX
>  };
>
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
