Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B3FC11F64
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 20:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DFB61CDC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 20:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DFB61CDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E006E570;
	Mon, 28 Jun 2021 20:44:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E1C6E570
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 20:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RS7ABZILNB0uoSaP7faC80vzCAoyunFul1qC3H0pKY/0wqQLZMsmlgmz7W4r3isqfoaGAjDG4CyIYymTSUYzsPUhtzvcTAppFjttC/K4YXmbiXMunO4vWCfl2965yBs6bwlD02km8GTSVzMvNsVY0Gt6ilou3mKP+zVFV/76C9Ro6iGKLemQdKGYpaSwzfv8xi7csFaCnDG76RqMfJzf4MoJhGSAW0KGhAheM06byRZ26yYZbJxV9JFZxM4/Kb4wXRgbdZR+OrS0WkW0nhsAbz4p+zJapAOX99txpTJIETedJb87Al2jTm5H426t4uxMMeJFrcNShOVTMfjJFPD47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N34KqTDMAh4vZwigmxaTxKvbOUMWufk2e1qHXrX82i4=;
 b=HWdrYSB6i8RlWGhmhxVASc2fSdRoqkbVdSfjjzhvZQ1fn7pR3/3fz7oZSHZA9j1R0bH35iepL5B85v4yqfBLs/zhfX/PiB3/cXlGVJay3ZMLyrXXtibUen/jwP51rtaBM2Uf7+POZrxb177yvK0lfAYZ4E2wnr7G99oF+rnbjSoaOvfLzWx82z4rljRsl8NEJjRN9OFMCT4x6lkGdp51xjMI4aqxWyup22LBPYlI9HOoffTWi91MwXwildXaWJXOrqHKUe89SLFMFwbnfn98rFrehkGE95vvfLtbhmkzcoR/WobP3w4Xfxa4T1j6siXUdoJzWkhvase0/+StGEoMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N34KqTDMAh4vZwigmxaTxKvbOUMWufk2e1qHXrX82i4=;
 b=f+/WQ67hSgV6N6twkKWDr0eCqwcVW3bK72kYZLRNv7QMArpFldaIaj80g9LKb/ZRbolzgX5IDejYEEuUrULYjEd6Z7D7RA1Z7XHGvNtBdKml4RGh4yWBurbYK+d0blwwPBqJkr/35QrWhqc3+zfu+Jdj1BoijNpqkcK+KfPXE0o=
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB1450.namprd12.prod.outlook.com (2603:10b6:4:3::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.26; Mon, 28 Jun 2021 20:44:07 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 20:44:07 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdkfd: report pcie bandwidth as number of lanes
Thread-Topic: [PATCH 3/4] drm/amdkfd: report pcie bandwidth as number of lanes
Thread-Index: AQHXZtL/HY5shVl3c02yyk2IAi03lKsp7qtA
Date: Mon, 28 Jun 2021 20:44:07 +0000
Message-ID: <DM5PR12MB4680FB12BECBA2F204C341FD85039@DM5PR12MB4680.namprd12.prod.outlook.com>
References: <20210621192348.2775943-1-jonathan.kim@amd.com>
 <20210621192348.2775943-3-jonathan.kim@amd.com>
In-Reply-To: <20210621192348.2775943-3-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d28bb87e-61a1-4f19-a535-bd43649bd326;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-28T20:42:49Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8d3d70f-601b-49bb-b65f-08d93a7579c4
x-ms-traffictypediagnostic: DM5PR12MB1450:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1450152BA1502523F8E7392785039@DM5PR12MB1450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D2VJkMCMdRrI2zRSJRUzvDid+34f5txNh8OrBNRuSP3n4S4EFF7jiHq64GuEhADlOl1KwXSY8w/4DigXWaRLKA1mvyCIr+VN69yRQMv17xX8jsEnXfWp/aWW11ASUFWHcZ/OYSXZnC/m66neDJat33zDCxoPdkqlNav3fkIC/GU7HHSLIETNivn32J1hF36/DtlUT+vMS+Ul38U+gt0oaS/aSqfJFV+ru+Q6iTPkPz66ZmLBfdlV0OUxi/qS11qGyTtDYGD3bUb7E894/sAIGcl+2axWY9/py/JMF4zBS+AfUFcdMjTlna289QU+xrhTYkbWx/FOIV1uWADKWO4u4+zRYXUn8Vr627FmY585nhCVGgFAuS3xO7mlXwJSGoCRkGXfaJO3wfWcK6z9ORFsYSf3DWZKB0yjM5syBzDjXtcwPEeRfQGOJ0zbChP30z6vdEW/60eLjHsaEIZrTL2abrvgk/tgOeU/YIXh54h5cGepelmmRo47P8QXKQTnGm0LzryTigUyLNvwJhESqsuEASDlPsy2q93Q+hs0puNTqOIO8GGWIwMHl7yA4qJYxb9+SsU+irIHvxRgWHb/8oCmdZnC7MFHUh1oQh7Oww5MqgGnDR1M0U0QoJVoixMZ90lulBT7cuXTNlaGrT2g3pIIcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(55016002)(8936002)(110136005)(9686003)(54906003)(316002)(8676002)(86362001)(66946007)(5660300002)(83380400001)(52536014)(478600001)(66446008)(64756008)(71200400001)(2906002)(66476007)(66556008)(186003)(26005)(33656002)(122000001)(76116006)(38100700002)(4326008)(7696005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t83ZiZy7ivrKjZWcp3iRISYyFu3O9UQFKOf3kcgoT5N7ngD7FqM9fit5oM5a?=
 =?us-ascii?Q?4ACiW32SmB6NB4RUQn1Ann7iRRK3MyBpUyuhXZKJmUbwa6wvfolIAT4a2bBv?=
 =?us-ascii?Q?JCQ5XvkUaWX5DPMYSNNE+bSXVc4fWUoCwsrak/X9OOawJYN/EdY4EMAIpMB7?=
 =?us-ascii?Q?l1ccDULbaHYfh1I9v41XrdmxdWjqz8k9XvnR/1NLfivLtUUv8508bXTJj8bb?=
 =?us-ascii?Q?phaFwYf9eUIwPLimGSQqVDZYfUy4IhkD1OLTRfeQzAK7WxIxDxHDO33j6j4p?=
 =?us-ascii?Q?5qS/wcKDXnXNpGDCkK8pN/xR2E7/D3IoFsMG9h0uyiHfhNLGjt0qzRdGbSxw?=
 =?us-ascii?Q?hW04HczuOYH7DU9iXj9R457iBv0EzhLJM1YY3JwJx44PLtYeHNZfqwsplF2j?=
 =?us-ascii?Q?gCc7NJjnxIzuKK/b8nLyUHvtvWjW9+Ce4KvKgj3M0pFOJaHE5urnd85y/DtY?=
 =?us-ascii?Q?KuXd85WG6uR0i++1xMF5hdsvlti0MCrvVDX/aE+EztydbOsXJOONzL4XOnru?=
 =?us-ascii?Q?EImcT38j+acHdvHo/Ky2sJ0ohMk3atMPo1f64dMfGehZRLdpU6dBX/Ls1qZJ?=
 =?us-ascii?Q?ztJw8U4Ntetl3EnkT9C22SlNtQEGuCA6vpJnNjT058XG58E+98FBIeyMvHY/?=
 =?us-ascii?Q?LH0TLPSmCulxORHJbGhz6y3PWGD4sv9nU2xCNygDXnTi0ZZkcvCAjnRCKuLY?=
 =?us-ascii?Q?26J1q4VZ+TtDJCRRq6mjz6l4wXhh4az0PaDBAIPsiJ1DlqEEFBTY4M/zMmLe?=
 =?us-ascii?Q?QroaokWkI9kduj1RUNLKrtss9KDo5PctsEzCzLtEQtH3aUdEq/r8hnQ3Aa7P?=
 =?us-ascii?Q?nPsa5L/HHTP4+J1iJ0DhvhlTL4tEelTjgnPfv4Ebhqg6oAcPyZZxFU/msAiB?=
 =?us-ascii?Q?CtToB+cqj5Ao5nAPxwUXX5plldK9wrDO2WCjtSdsXttzVXtCf3oiKW2fsMz5?=
 =?us-ascii?Q?BpqM5Rp+jurd1ku7t9RV6afuMeascwNTHhO3hiK6zI8La4mXQOB1WOuYbCW5?=
 =?us-ascii?Q?Lljr0TuYy+W7zweyLfZ25rD2nTkKlGpa5g2KfszfU+Md+z4JwITErhd4p6Xl?=
 =?us-ascii?Q?TUEytaKS+zfFDRkcYHAZISu4Jigw0vvjCBrBaMqbCFJyB+D15d50uMfZ02De?=
 =?us-ascii?Q?dE1q41y/wbe1eFZNsiYzZmh/CwfdWL6fCalWVEhCs/stFFXCDAWdh5YMyZ+h?=
 =?us-ascii?Q?dc+3s8odCtXNNmmlBJOhhh3MgSbAPEVoX4QYaUz+FzoXKZw0JMwkzOxXcdaM?=
 =?us-ascii?Q?SlUPQOb1Q9TcvMVQIvTYmLBiNQ2bpGz/wQ+HQfizYMgUd+EHSUBW467A/qKj?=
 =?us-ascii?Q?mmzwskipVAZrZ5h8hlreZiTY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d3d70f-601b-49bb-b65f-08d93a7579c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 20:44:07.6656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gO/allNXBxmrXkwfUyyqvlDbAddpCAKy5iBR4Na1MXZkfjIkbLWN7aTN+paflDAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Ping on series.
Note Patch 4 can be dropped.  Runtime doesn't require an extra flag to determine direct connections.

Thanks,

Jon

> -----Original Message-----
> From: Kim, Jonathan <jonathan.kim@amd.com>
> Sent: Monday, June 21, 2021 3:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH 3/4] drm/amdkfd: report pcie bandwidth as number of lanes
>
> Similar to xGMI reporting the min/max bandwidth as the number of links
> between peers, PCIe will report the min/max bandwidth as the number of
> supported lanes.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 24
> ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c      |  3 +++
>  3 files changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c84989eda8eb..99c662b70519 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -568,6 +568,30 @@ uint8_t
> amdgpu_amdkfd_get_xgmi_num_links(struct kgd_dev *dst, struct kgd_dev
> *sr
>       return  (uint8_t)ret;
>  }
>
> +uint32_t amdgpu_amdkfd_get_pcie_min_lanes(struct kgd_dev *dev) {
> +     struct amdgpu_device *adev = (struct amdgpu_device *)dev;
> +     int min_lane_shift = ffs(adev->pm.pcie_mlw_mask >>
> +                             CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
> +
> +     if (min_lane_shift < 0)
> +             return 0;
> +
> +     return 1UL << min_lane_shift;
> +}
> +
> +uint32_t amdgpu_amdkfd_get_pcie_max_lanes(struct kgd_dev *dev) {
> +     struct amdgpu_device *adev = (struct amdgpu_device *)dev;
> +     int max_lane_shift = fls(adev->pm.pcie_mlw_mask >>
> +                             CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT) - 1;
> +
> +     if (max_lane_shift < 0)
> +             return 0;
> +
> +     return 1UL << max_lane_shift;
> +}
> +
>  uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev
> *kgd)  {
>       struct amdgpu_device *adev = (struct amdgpu_device *)kgd; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 20e4bfce62be..88322c72a43d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -31,6 +31,7 @@
>  #include <linux/workqueue.h>
>  #include <kgd_kfd_interface.h>
>  #include <drm/ttm/ttm_execbuf_util.h>
> +#include "amd_pcie.h"
>  #include "amdgpu_sync.h"
>  #include "amdgpu_vm.h"
>
> @@ -227,6 +228,8 @@ uint32_t amdgpu_amdkfd_get_asic_rev_id(struct
> kgd_dev *kgd);  int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
> uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct
> kgd_dev *src);  uint8_t amdgpu_amdkfd_get_xgmi_num_links(struct kgd_dev
> *dst, struct kgd_dev *src);
> +uint32_t amdgpu_amdkfd_get_pcie_min_lanes(struct kgd_dev *dev);
> +uint32_t amdgpu_amdkfd_get_pcie_max_lanes(struct kgd_dev *dev);
>
>  /* Read user wptr from a specified user address space with page fault
>   * disabled. The memory must be pinned and mapped to the hardware
> when diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 75047b77649b..f70d69035fe7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1036,6 +1036,7 @@ static int kfd_parse_subtype_iolink(struct
> crat_subtype_iolink *iolink,
>                       props->max_latency = iolink->maximum_latency;
>                       props->min_bandwidth = iolink-
> >minimum_bandwidth;
>                       props->max_bandwidth = iolink-
> >maximum_bandwidth;
> +
>                       props->rec_transfer_size =
>                                       iolink->recommended_transfer_size;
>
> @@ -1993,6 +1994,8 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int
> *avail_size,
>               sub_type_hdr->maximum_bandwidth = 1;
>       } else {
>               sub_type_hdr->io_interface_type =
> CRAT_IOLINK_TYPE_PCIEXPRESS;
> +             sub_type_hdr->minimum_bandwidth =
> amdgpu_amdkfd_get_pcie_min_lanes(kdev->kgd);
> +             sub_type_hdr->maximum_bandwidth =
> +amdgpu_amdkfd_get_pcie_max_lanes(kdev->kgd);
>       }
>
>       sub_type_hdr->proximity_domain_from = proximity_domain;
> --
> 2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
