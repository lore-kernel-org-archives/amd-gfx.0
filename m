Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA84C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 01:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C830A22254
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 01:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cl6ywlHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C830A22254
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F7926EC03;
	Thu, 15 Oct 2020 01:05:26 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E636EC03
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 01:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdjR1H2+kaHEL4U18+r+OV1EX8tnc0AUwDolvM3STooUw397AMOhR16CzX1GZ4cWPtqhwgFXE6nQNLFVA0On6EA4+LpTENVmvVj/PbyRb3sLdPf7pVDSiFEaB1IJ078H/zxhp6Ofqr25i5cxVg1YRsBsiVt/1cOOt0wd6r1W4xDZX0piML77zKqBAEpLZ/CmZ+FEk/fFBwtnecIB7F15tbzYMSBg+Dy2S6u+b9OBr7Just1z8+xgzLsMQMVXPDA5QZCAkTq5zqKpwH7nqNtbWKFM3FFk3LRlywxGfMBjIc5ObTBY4FSFT21UB9x+83RkmCINZ8tn9LrH5cT17LZ4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI2K2HAtVZf/KwT61qroIzgntSTiWDdbRWjNvDuDHU0=;
 b=W29gILqo3a1svQSyL5KytXh7zv8UC7lT0bi8IfDiwoNqfsUIGHbfs1BiYxUqTbL3Wo8Z75VvOmYWd+ox8JqkzINZjKZOPxgy7KAeC2vHcg++nQOXGXmTo4xoXhKXoVBWXM2mSWcd0TC4xqVMNIXwgeSCPq1XTof9wU+bNIk62A4KR6CR6HYUYInixfMFQuOWf3xnY8Jtw25xttg+pOkWS9voK9arFR4Ke6A+aBiYVnIRuKEoeZdcwYopZtDjCSuczdyxKGNwTv54aO1Y7oizreuKyXSIixxvVDu3z3BgpEC2hx3tzzwt6Q/LcnZFS0fko+s5/8+jJmfRDSJ8MqznNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI2K2HAtVZf/KwT61qroIzgntSTiWDdbRWjNvDuDHU0=;
 b=Cl6ywlHy/mUZarYQTRhMol3MeNiqN9QjTYNgjt5hxtCQJ9e+ZEAqAOJxjGmGyGxnbWsoxuEK7lMsRz+mFIdLWTSy4HHYhW32WA+/TUHbYmQ2K9WlN+dsC3M6DBxiwyYdRDVnVqQksWaeQ/RKimZISchH+OV1yugmRvuZhaFuS0s=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Thu, 15 Oct 2020 01:05:21 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3455.031; Thu, 15 Oct 2020
 01:05:21 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state
Thread-Topic: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state
Thread-Index: AQHWoenN61Lemk9g30GCjrGWMt60Y6mXFSqAgADDaZA=
Date: Thu, 15 Oct 2020 01:05:21 +0000
Message-ID: <DM6PR12MB2619C69B7B08A698238F7DACE4020@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201014052023.7085-1-evan.quan@amd.com>
 <20201014052023.7085-2-evan.quan@amd.com>
 <CADnq5_MxB_N5kAW6AGUYvWRTkZGu9GGrHM4rocMz4gJeyO6i-Q@mail.gmail.com>
In-Reply-To: <CADnq5_MxB_N5kAW6AGUYvWRTkZGu9GGrHM4rocMz4gJeyO6i-Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5878027f-c629-4edf-bd5e-77cb5bc75d0e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-15T00:57:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e8d21c3-fc93-4a73-2d67-08d870a6640b
x-ms-traffictypediagnostic: DM6PR12MB2617:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2617419CFDDA5A6B9A32B496E4020@DM6PR12MB2617.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IhQvbTzaIChGncoQb9yE6QS2ED0QdXpf7nDCiLn1wOpWNaL/BBvGJA04vZVYV+VUVjf7J9hb8OqW02ro0U/wQ70QlaEgqv5m715FsJdr7hpoVqiUxq1OVgIcKiZmk05LzObuMjWP23jn/caeFQtbazG91j2mG7aSZjP5lVbzwLvejDK8hU/aX7RyJgBDGZ9g4cAh0J+1IRwyoqctZwuIpZLcEDP9ZpOKbpT0Fu/wJQQlDvUylXelJax/8g4uPPJiadmX5tCD5wHPFZuavSLonDveaUkFk/e7XmUqTbTcLtjYRYnUVmiuZyl4tgfpcBfcieqCDyGcvSaAc7op/IJI65zXIaPCxdPOsBH/tkr0Bc/yUqBaFivF8UTT36GT/6OQlG9bM/rQdvuwRkeeQXrSuQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(66446008)(33656002)(66946007)(66476007)(66556008)(83380400001)(64756008)(76116006)(83080400001)(8676002)(52536014)(8936002)(5660300002)(2906002)(53546011)(478600001)(54906003)(4326008)(86362001)(9686003)(7696005)(6506007)(45080400002)(966005)(316002)(55016002)(186003)(71200400001)(26005)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: TComXCqs4Xd/fLea61JcdwC/g2ea4/wq8owMBF1Ydw2UzQuvHaiwmo09kL/eBuXbKhPGIGWgGnDK4fsNg4gJSZxfE4ucgmCOHle0JMAEZeVYpfTOpYp8gaAS7QrnF9XPN6xYxX1zlKvZy6eTugwdDwlMVUfDEKToEBQvpNq9nfJXByRXEsRx3f2GjbEthDVLpJ8OYh+t6n3gLxpf9b8oz8paweBnF9cipZsi0fjkRC0CfVo4+X11q5XM3uzhi90IvNXxrdWkjeESu5NQTZBNP7/mIquFzam8kmfRmgTZeJX5S9LP8ewD+dHroB2936QvWAhdO+jOKU8dHCM/oLkA3b/TYcD8IQqlIXHlBHM4tgbpmB6jCVrc0Sr3ZrjSEt4QHJdhKUnG0dObNduW1/dU1PJBKVlWvQ8a/1cn1TFJuIuZ3ZyIeKN2EYp35UqxmSUx8DMQMOnOlbu69D87oI9TXs0RD5tgB0AzKqqhgAaAFlmfcl984XE5TkAF2FUcgFMy5aTh30TUNcjHHNDMatZRYokYgKI5CA2VAVWtburrh5kcICF8fSEvywGEUDDj7XIZxm/0doC/M7bx0QSzbS7ctiuLqoimus3xghDldFXZtoBuKxEqx/ef5rHScqSKmPu8aAlU/ar/+FWwe3fEizcvWA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8d21c3-fc93-4a73-2d67-08d870a6640b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 01:05:21.1435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9a7GmZGzzJbwK5yKglESaLKiPTq3Ia0JIrAJCu87BlZpvD3O9FIzWE2I0NiE07t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

It was intended to align with other ASICs. The output for this on Arcturus is:
0: 8.0GT/s, x16 618Mhz *
Is not that OK?

BR
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, October 14, 2020 9:18 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: populate Arcturus PCIE link state

On Wed, Oct 14, 2020 at 1:21 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Populate current link speed, width and clock domain frequency.
>
> Change-Id: Ic342fbd8f5e2495d212eaa4b85b4e146838e0525
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c             |  3 ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 18
> ++++++++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 46eea3f8f958..f87411cfa4da 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2124,9 +2124,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>         } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
>                 if (asic_type < CHIP_VEGA20)
>                         *states = ATTR_STATE_UNSUPPORTED;
> -       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
> -               if (asic_type == CHIP_ARCTURUS)
> -                       *states = ATTR_STATE_UNSUPPORTED;
>         } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>                 *states = ATTR_STATE_UNSUPPORTED;
>                 if ((is_support_sw_smu(adev) && adev->smu.od_enabled)
> || diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index f982b9090d7b..46d950757230 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -720,6 +720,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>         struct smu_11_0_dpm_table *single_dpm_table;
>         struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>         struct smu_11_0_dpm_context *dpm_context = NULL;
> +       uint32_t gen_speed, lane_width;
>
>         if (amdgpu_ras_intr_triggered())
>                 return snprintf(buf, PAGE_SIZE, "unavailable\n"); @@
> -823,6 +824,23 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
>                                 now) ? "*" : ""));
>                 break;
>
> +       case SMU_PCIE:
> +               gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
> +               lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
> +               size += sprintf(buf + size, "0: %s %s %dMhz *\n",
> +                               (gen_speed == 0) ? "2.5GT/s," :
> +                               (gen_speed == 1) ? "5.0GT/s," :
> +                               (gen_speed == 2) ? "8.0GT/s," :
> +                               (gen_speed == 3) ? "16.0GT/s," : "",
> +                               (lane_width == 1) ? "x1" :
> +                               (lane_width == 2) ? "x2" :
> +                               (lane_width == 3) ? "x4" :
> +                               (lane_width == 4) ? "x8" :
> +                               (lane_width == 5) ? "x12" :
> +                               (lane_width == 6) ? "x16" : "",
> +                               smu->smu_table.boot_values.lclk /
> + 100);

We should put a * by the link speed for consistency with other asics.

Alex


> +               break;
> +
>         default:
>                 break;
>         }
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C880ed84a1bc14d8df30108d87043a997%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637382783197264100&amp;sdata=kz2KbU6Sn00k9
> jjihiqBnQEkfgI3dFbApLnqLf1Dw98%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
