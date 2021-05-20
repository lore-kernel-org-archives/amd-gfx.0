Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADEC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 04:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 829B26108C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 04:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829B26108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04CC6ED9F;
	Thu, 20 May 2021 04:12:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6E66ED9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 04:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfVa0zBwmN0MyzHroG1EEZ7K4wZbiWpANrTYOlX4gS1xix7GA4Ywt7x9kbYDzWPsXMwE2bllrJNeDcjGojJfo9MD79FykAqe/JocXRYMAng3GYnK43Q4w6HuUOd+Sp2YWiBpAKO9INdBJauIb8bTPUMUA5BjGNG+492tOtOSXULMsmseK70z5pZJzxGgrSMZrd62FlBGGGSr4VR73PxCbwR3x1Ry8Wsssx328NU4lcp59UE7CSPLL8MhgCDZ8LPpz6FjmAF9nD3IrdaFhUb9QY2C37aTHFUdduXeAubXPQxTJatqNHKL0Rqpqi0YbtYFyFvJfpf0/EwEFXKMWgQRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UlB5RrefIyFG7p9zjrdE0lpLU9tuRRLQ+ayWxll3BE=;
 b=iUT/6mhVkTHpQXpwBz6xY8fLIgYFZkXykRci2a2MTmGwqZGoNcgkbxOLmBLyy6+T6SHnZLL441eGI+v9qekm4giW26l5PEUWZzKgYOuRxlR7o6mtiRHjzkek5i1SfBm/hXQI7WQOAqTiwk9YEcDnA0B5MfFiff0HduH709qSVCaJUKH7OJs0jW59uiTDA/Z91oRxH/hF6zWeip8kYziiVF2uKlVPsvr7+I7xkf19esLprppcjYvqp5FG00Y18wZIpQq5MxJFRfkc1VmIHqozWWnwz+gF++BFYUbfsx8/Pg4LjgMx91zQdvbI/ZjFQOW3Ji4NB8XaGkAuVc00xir3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UlB5RrefIyFG7p9zjrdE0lpLU9tuRRLQ+ayWxll3BE=;
 b=uQeA2dveEc/gLzZOsFiFxAVNGmIMPZiiad2uq3pNu2aNKmmNf9+wBvgfpmovUo3Xj5CC2XyAdiBZw5t+JjoPrw84HVseKrbp8Qa7v1kZ6j/k+lLoNmmX9nikBsz4EAoBKPvPUiAeLC8w4ZUzaxtXpFrE1wZjSlQf338Hwp9ZM9o=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Thu, 20 May 2021 04:12:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4129.034; Thu, 20 May 2021
 04:12:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
Thread-Topic: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
Thread-Index: AQHXS4pCAvmt9AX2mU+Pp6CnWvO6XarojKiAgAGFJYCAAbN+IA==
Date: Thu, 20 May 2021 04:12:24 +0000
Message-ID: <DM6PR12MB261976E1B9D6C259F31A166CE42A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210518020502.351803-1-evan.quan@amd.com>
 <BYAPR12MB364031C662ABE2B04ADE75758E2C9@BYAPR12MB3640.namprd12.prod.outlook.com>
 <CADnq5_ObXZajNNTGpp4ffR+aC-mvyXgOJzfPm-oz_K15eq+zjQ@mail.gmail.com>
In-Reply-To: <CADnq5_ObXZajNNTGpp4ffR+aC-mvyXgOJzfPm-oz_K15eq+zjQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-20T04:12:16Z; 
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=554e7d3f-23e6-4d7c-804a-3cefe7cc2e29;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 742ed1c1-2dd9-4349-4d34-08d91b4578bf
x-ms-traffictypediagnostic: DM6PR12MB4862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB48627B200F0D7471FBCF8C52E42A9@DM6PR12MB4862.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVkVKhRr/vjufZ8F6uojtGaNHRz6coqdd11JtVgIWxYCuv0EuxLnf9N+5Vgx6q5Tw9sOtggeMepic5LcsfCXpbwdXZvVbfkQuabk9l8pvzgOpvu5TkxglHAags2MCT8AsvT4Lqs5Qrusw2Vt02mZI5dxoKia5tmYhVO7vhAAqQuBC9Ecf2fYXDc/EROMctRpFGiqcIfLqXcyfco6GdSkxQ1Sy5f2wqMUkur1RhnpOB3vTpl2CaT/Pe6plGMqUNRgwnTI+o4XntEJ+EiKyz5a6dQVO8JGb732J0BwMcfCGMhYvLDNxelBZaASvdXegN3hJTp0PMHfTLFsAptoTlyW2jf7zFZdWdZkOowa1VWqt6vSeJ1JxEJhRahJBvyDqewN8otLAqNjHOy+qy1VuXSpR/l+yAEhNk30cHaLjbvv+aKsIlWVSfMrlqxQFDT0TQwAcXVxXIxtAf6vJZqjq7I2YqkygmNXYxrtcdUmvmdAn+kSVivr9b6ohbi4ysWPWCJUwMF44M4E127iFEKHsr4zMx6j2kri+EPWF2UKCyqjzwsi+wkABM2lMKAs3x6S4jSkcEz/j5+7y5cXzFYoZIaTFM4TIyF+japxAGy/GFn4tYGDgDZ59/qGhSsoHJAIEggAYAhzl+pE4b4C5NDsxShjOyhV8a5oCtUZPZcCi06AxdHJ/smA0W+Zb0iRJ4G/C5eAUlvt36+QesfFpfhdFzGr8b0fVqnxCc6NocBYcH920iA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(76116006)(33656002)(186003)(966005)(478600001)(66446008)(64756008)(66946007)(66476007)(66556008)(83380400001)(45080400002)(52536014)(122000001)(38100700002)(7696005)(26005)(54906003)(8936002)(5660300002)(86362001)(110136005)(55016002)(316002)(8676002)(71200400001)(4326008)(6506007)(6636002)(53546011)(2906002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cmYhQtPCHOG7B+R2it8nQ+ppoays7xjZchV2ZnPst3RCWN2qMBCy7X2QFwK8?=
 =?us-ascii?Q?dzncEKJEEI3XTZvfJdYN5uv/9RYVl34PlOm6N3GB4gVYtm9t8yRAFTrhDYET?=
 =?us-ascii?Q?GpM/DzqdF8z5caDm4WxDoM+gnEC8k7IJr4Y32CtDciAfktOuwt7KmbsHyLRd?=
 =?us-ascii?Q?b+w6efBN4gt5iTmICzFyHsm9Z+GZYwXuCiYz3kKAyWxmmuh7c9QVcLkTyUgo?=
 =?us-ascii?Q?IX4vOrQyqbNBQG2TrRSE7usQZbGmllfgzNo6tVZRRRPQSb5a/S9v38UWqkQK?=
 =?us-ascii?Q?oYNdcqyRhtmH3uVpECyMkriw41z1v8pKky/eLVjXFPMZo9N7Rwh+AwUX91NI?=
 =?us-ascii?Q?WWsK44rqUAGjS+5H4W6S8BSJi/h7Qb7eKjOa5Hajx6niHqXc39Brra6C/WEI?=
 =?us-ascii?Q?JYxPZC8FI7uQS9foCRZKx6mqV9d3S79qzHAO6ygz8Q6jjl/o9gM1dKf3EeeG?=
 =?us-ascii?Q?mMcnTIrGSlMAn+jN0Ar0eV+UvrjiJFlwxuttDRjbo7GC43MGX3DASngU/9hD?=
 =?us-ascii?Q?8TucC96v7vjuSkqI7mELV6LNjgKlkUQ2TY6JboFYj2Y3i8M9OZIiZBRxYg3H?=
 =?us-ascii?Q?VIa4mzadrAq0ixbCR5XGvYVvo9br/UMXtqkGGlmNKYB0GsPXwpeQtBjafvKU?=
 =?us-ascii?Q?1s+VabIstkPeNP11hDpS5veu3vV1lG/BC6ovbFFcKTGkIbF7nLqcWqoi+JUE?=
 =?us-ascii?Q?h1QFEwnXlu+SHK1WxWvgrNXz7HgEWytGw06PW1HJBRjLEySuHTxKNyY1WWnP?=
 =?us-ascii?Q?0j9qSDODCWETcC42Pi6GwCsUlwicaxvyxG2/yptnanJGWQr/urHGjictDhK7?=
 =?us-ascii?Q?pwh844WcqdLFrBv6MOSa0qkKifYTAuDvka2OQkG0cJTE5MrpI5hEr1y+gnQi?=
 =?us-ascii?Q?wuaRfml1ne7Xv7+uJ4SL2ZxSBD2Hh6ocWv8yi7gDgxxdSl+65WjIhHAyp1uk?=
 =?us-ascii?Q?zU2aTPxjAhghOiAhX6R5ydmTaD6CtnGEUlTj0dIviwoGueW4j24KytBT1M86?=
 =?us-ascii?Q?MA5VokbLk9CqphdGH4K8r7LGtqS2KSfWBAsi4X+/26uWHtasOccB20b+Qzh4?=
 =?us-ascii?Q?x2mj2y5vxJsSskXPI3S0O5YaYgR7O5QxAQjdPHCbSZXcBxGFYUL1D4G1qR0Q?=
 =?us-ascii?Q?UFbG0KbeFXUZGzPyI6uNUTZb9QT5Xr+y7ycGQOTXXbrlkot8ANL6BuIFb35r?=
 =?us-ascii?Q?T+4EfNfGrw4y9d9a+ExTf8JQg7BPURdCylZJl9kIGwrN3sGDW9KXTPwiJnZl?=
 =?us-ascii?Q?qH8DtqUMHD+u41EHIeGlLHm2W+QDRa3m4f9dR72CgW6PKUoDYHl+eC37pd7p?=
 =?us-ascii?Q?QrIenKjEc5Uc1VU1B+iN6S04?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742ed1c1-2dd9-4349-4d34-08d91b4578bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 04:12:24.0663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7iykxVcFJR7SBXHPpcu2DdyvBrRBwGgOK+n9N2uYY47VkfTJN5AV8CCQxehcFF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. I will check and port this to powerplay code if necessary.

BR
Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, May 19, 2021 10:13 AM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
> 
> Do we need a similar check in the vega powerplay code?
> 
> Alex
> 
> 
> On Mon, May 17, 2021 at 10:59 PM Feng, Kenneth
> <Kenneth.Feng@amd.com> wrote:
> >
> > [AMD Official Use Only]
> >
> > Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
> >
> > -----Original Message-----
> > From: Quan, Evan <Evan.Quan@amd.com>
> > Sent: Tuesday, May 18, 2021 10:05 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth
> > <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/pm: correct MGpuFanBoost setting
> >
> > No MGpuFanBoost setting for those ASICs which do not support it.
> > Otherwise, it may breaks their fan control feature.
> >
> > Change-Id: Ifa9c87ac537a07937a0f0f6a670f21368eb29218
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  9
> +++++++++
> >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10
> ++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index d2063b1e7936..f16c76038f13 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -2936,6 +2936,8 @@ static ssize_t navi1x_get_gpu_metrics(struct
> > smu_context *smu,
> >
> >  static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)  {
> > +       struct smu_table_context *table_context = &smu->smu_table;
> > +       PPTable_t *smc_pptable = table_context->driver_pptable;
> >         struct amdgpu_device *adev = smu->adev;
> >         uint32_t param = 0;
> >
> > @@ -2943,6 +2945,13 @@ static int navi10_enable_mgpu_fan_boost(struct
> smu_context *smu)
> >         if (adev->asic_type == CHIP_NAVI12)
> >                 return 0;
> >
> > +       /*
> > +        * Skip the MGpuFanBoost setting for those ASICs
> > +        * which do not support it
> > +        */
> > +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> > +               return 0;
> > +
> >         /* Workaround for WS SKU */
> >         if (adev->pdev->device == 0x7312 &&
> >             adev->pdev->revision == 0) diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 3c3a7f9233e0..159cd698323e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -3201,6 +3201,16 @@ static ssize_t
> > sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
> >
> >  static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context
> > *smu)  {
> > +       struct smu_table_context *table_context = &smu->smu_table;
> > +       PPTable_t *smc_pptable = table_context->driver_pptable;
> > +
> > +       /*
> > +        * Skip the MGpuFanBoost setting for those ASICs
> > +        * which do not support it
> > +        */
> > +       if (!smc_pptable->MGpuFanBoostLimitRpm)
> > +               return 0;
> > +
> >         return smu_cmn_send_smc_msg_with_param(smu,
> >                                                SMU_MSG_SetMGpuFanBoostLimitRpm,
> >                                                0,
> > --
> > 2.29.0
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cev
> >
> an.quan%40amd.com%7Ca14d02e9c00a4d13acf808d91a6b9da0%7C3dd8961f
> e4884e6
> >
> 08e11a82d994e183d%7C0%7C0%7C637569871776869665%7CUnknown%7CT
> WFpbGZsb3d
> >
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C
> >
> 1000&amp;sdata=oo3glBV4Par2AylocfT3586Y1U%2FuePBureFdUOu7j%2BQ%
> 3D&amp;
> > reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Ca14d02e9c00a4d13a
> cf808d91a6b9da0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7569871776869665%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> oo3glBV4Par2AylocfT3586Y1U%2FuePBureFdUOu7j%2BQ%3D&amp;reserve
> d=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
