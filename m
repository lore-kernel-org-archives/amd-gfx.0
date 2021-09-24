Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5D661107
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F5D661107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99706EDE7;
	Fri, 24 Sep 2021 06:01:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918C96EDE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 06:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a38DlyJcxUkdzJgXWxBCzaFHo5DcwXTVppHQbSNMGQKvK2kSSKCfTKyhF6yNu7ZuSLA9FGjtFFjshDtPBmExA5dVT2ZGeOi689ZnwMone46UNO/VyCooOCz6Ev6F79mXcRzwSpqQ+oWJZXpXP8syjCbYtnyOsn3d12AVig6mlAK4WZViycgP/DnP7bJQ7JYDs+B7wrLepOwLXI6woxgV/IGLCvnNahceARvAjGuQiBlK9E3mgldxVh8KlExQqZ3ObZvLSM+FgLFHbZFjUcWVrGhAFUc4QJEEn3Jm5OMCEkeXQk1XVN4xwKjlvHPNHgA/6xRlLUGuIfAJAmelUW1HWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nKrvPLGiKd6D7o2SMhJGcL5Ke92pn7apwNfQ0DBpewE=;
 b=ZMMWSBcBrH3BItotbEDuomgXEk9/6Wo0s6wVU9oa+aSM6XDU7xkebW4TcTRB76Vm6kc13Ga5euSX89VrubZiGsNf0sl9iiXt+McNjWBNfqxfoGBOsTKlcsTVKYOv9f0WorQmCLa023DHESimZ2ByAKNDB5Avu5LVIbMArl1bNgMsPPbIK2ODT39poM6wDkVW14i64speqqUa2/dtICbgPBd49tLiHxsF3oU64gPNbFmq2fKMlRi9t8LCEcD1QVkys0UYD6kLdeQMGtICbJNzhcRNX3zvGCgqNibuuXr+5SMo6fWxHinSHjwjyQuJ27LTs6sbXRaWmJVIGgWYAaL37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKrvPLGiKd6D7o2SMhJGcL5Ke92pn7apwNfQ0DBpewE=;
 b=ocy3+2GahqKMY6G66bIyqCCQkrAYbkNncKoMy4HQvDxV+Abp2dOOjV/tG0NjU5dkySOAn+Gm3gJbbVVuPpTuoaQ4Z7x7sxRHB2z+vClVI5e9AAHK/VTctsY1T2lH5KhIgnqyVGkWD8TLSebkk3SoLUEDkKHpPZh6mg78klo0hY0=
Received: from BYAPR12MB2870.namprd12.prod.outlook.com (2603:10b6:a03:12d::19)
 by BYAPR12MB3269.namprd12.prod.outlook.com (2603:10b6:a03:12f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Fri, 24 Sep
 2021 06:01:05 +0000
Received: from BYAPR12MB2870.namprd12.prod.outlook.com
 ([fe80::ac7d:f2d0:f2:cfc2]) by BYAPR12MB2870.namprd12.prod.outlook.com
 ([fe80::ac7d:f2d0:f2:cfc2%3]) with mapi id 15.20.4523.018; Fri, 24 Sep 2021
 06:01:04 +0000
From: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Jacob, Anson" <Anson.Jacob@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: move FPU associated DSC code to DML
 folder
Thread-Topic: [PATCH v2] drm/amd/display: move FPU associated DSC code to DML
 folder
Thread-Index: AQHXsPOEFUI+Ea0vpEeSHwJlRN6DM6uyqWeAgAAFmIo=
Date: Fri, 24 Sep 2021 06:01:04 +0000
Message-ID: <BYAPR12MB2870958A354B7477697AC13EFBA49@BYAPR12MB2870.namprd12.prod.outlook.com>
References: <20210924032204.955789-1-Qingqing.Zhuo@amd.com>
 <ba57af5c-1f93-1ad0-a186-24d8903a0929@amd.com>
In-Reply-To: <ba57af5c-1f93-1ad0-a186-24d8903a0929@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T06:01:03.311Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4185fce6-76b7-4d0a-7b53-871e0e44dd9a
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad0c12fb-5a1e-4b60-b196-08d97f20b1e0
x-ms-traffictypediagnostic: BYAPR12MB3269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3269003458B7E039E16F4BE0FBA49@BYAPR12MB3269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fS+w/AnmqnOmd1kq3HUrl1e74ckPU9rBfPBKcsu+kuEl9h+0cCz4OtBD1DK1BKa18DYqJo7sbhor3Gzsd91FbUgD346LPi7NBDF+NjddrlpxpROPF8dyDXSDmZxDgQUzCmBRJ4Ja3lysTgMztx5ZBTweSlLXWfboadLjKTcqTxBzcX5miqHAsoLH730H2/4qmtOr5YCLOh8jau49fCbktKX9xhlK/CeCcuuXciWM2r6byMUQK8Uf9Q7SlyDDQ3nYl6k+DyDZezrSG+PHQTYcW6hX/AAlfn8yXCV4pSqaGxrHCSe6maJamit1mXvrswPpZiXgpkhx7/qVbXzSuv2a8jzZk8hfEq/0uDN93or5Q1QKIOSaABbdL53NBW7qSEkmqe3odregSsbg1/m6JYmW4C44AKvxurGZ491SjIdpeckWPFacTurDqj21OCGYQNIIW3ibA7xl2VWsdFXRrND6dU0zgg/UfFhcUoyVOug7TxEc5bW7dyj0orGmhSSewhp9lylVhaVaWn9nnfUJmlyjrjfiZVcePnbcrr/gaLX8+HW1G5BlNrkG5ci5n1uxPt8wm989FMhkNQtXLcNxE1WlzFhHUt85wDJDF39KvXaVaFlb5RYTzipf1yM1oe3NLuDrXij6IlbA6aqZ5/gKURX+t8n53P3JJOUpKilG2ktyFJr5E0YyVsHvnSesRG7TjMBoS67zkDhVWGZwbHDDo0HqrV3jpqmCPOfikp7Ojyc1lIE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2870.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(508600001)(76116006)(26005)(186003)(9686003)(166002)(38070700005)(6506007)(2906002)(53546011)(33656002)(122000001)(86362001)(55016002)(66446008)(91956017)(64756008)(4326008)(19627405001)(7696005)(316002)(5660300002)(66574015)(83380400001)(8936002)(54906003)(110136005)(8676002)(966005)(66476007)(66946007)(38100700002)(71200400001)(66556008)(52536014)(461764006)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZA1m2iA0bYI6cNgW4l0t5pG2a3dPQwS+fJrjeNl9GOxGHrapl4fCFLDtgw?=
 =?iso-8859-1?Q?VepyY/azsTfx6ca6vsHEDuBzR3XhCOIaAHgCH7VPQW+nu8ILejRZglU+ps?=
 =?iso-8859-1?Q?/P5TfAYV8LmgZyIpNTAGFXHeVMaZprjSDFn2/Jn/jTc3O4hPbdpJwOxB89?=
 =?iso-8859-1?Q?va+kOdY98UZiSq7+4lRJ/YOto9XdsT0UQTNw3wiSuGe+aIOzcjFpmkB+i1?=
 =?iso-8859-1?Q?COYqDSfCspjWqvxd87SFJjnHZzZre6G69jshPbJbRxnY3WpZXYC6QofGmn?=
 =?iso-8859-1?Q?/kSJIWI1ckfgB0KXdtuoLM5Z0nSpyGlRQnbjIoEfI/byAXCCTOE39rWf2O?=
 =?iso-8859-1?Q?d5rR2XpjnRq+omRcrkRGBiCKLMUya6mQXoUoj9sLqSbY2EV+uQ3obKXXMS?=
 =?iso-8859-1?Q?GEnYUSXtNburCi8ue+3afRripvOswsAX9mJnOpxVp2XNAJmQWDxPU0yu0c?=
 =?iso-8859-1?Q?2laW3q7fbAlZGTNtMBxwRPw3XcFQnmYCcknUHvOyXk9uecExu+81BG9MQj?=
 =?iso-8859-1?Q?Eae7KaUkXT7PX9MmVfgV/PhnEO6lJX4waaxEk/eQPZFCQIEClfbLORJ/x4?=
 =?iso-8859-1?Q?ci58sWpb1d3YpO+pX1q4s0eITi6fW/syJqdwUdM8pejadS5g6Jq6AIdV0b?=
 =?iso-8859-1?Q?vThRUtE00Z5LFvjXi5Pyz5fKFFSVodLJwUtfsR2ySNhlnpDBYlUFFiQBNV?=
 =?iso-8859-1?Q?HbjhEaQ5blm8OV1kMiqCIeS5fMK6FAbkv1qPALikXi2kmrM1QvVfPfHAVt?=
 =?iso-8859-1?Q?bl/1qENHDdk6QHy7RlGmur/HFIVla0gER2763eUAlw2oQerm2jsD92Pm/t?=
 =?iso-8859-1?Q?5fCm+0ykV8x5A/iIN+Nn1VpVuu6lxmiiXn4958LMLm6O28pjXkVJ3cf+BD?=
 =?iso-8859-1?Q?aszrxUYRNJYjKsg6s87ck2KrchbepSAqKeIYL084McMSi3e7gFKOh1QFX7?=
 =?iso-8859-1?Q?fzRw8xLQVGzO+N8yfRUPN6wBm/P3FLAqz1izGEU5tfPZ3znbYAqQWyusSa?=
 =?iso-8859-1?Q?GozkD/WQTWqzRaW7XWNC7aQz1WZdnDgVgZLEGeZgwtg69aSMBheI9uVigj?=
 =?iso-8859-1?Q?PD9zhMqTFyTM2KaSMW2ruyfesAJZTyavM5+wAwqmL2eJS4Z4K4N3Q+iovq?=
 =?iso-8859-1?Q?9mzgJgVeUCovNwHVGo6yc8gZD8XvlNQxxXIqjXk/Zw1b3CUWODdUgiSWvk?=
 =?iso-8859-1?Q?xMh9Gw4I+SC/0ISJPzdhj1qVcQP3OlAK9E82zKTt4BsuiRiQds1T4hrE6N?=
 =?iso-8859-1?Q?TShGRVwmA3s8zO/HL7GDXpV3Zg3RQZfvx+XZZzFw3zLde4ah3fAkGijZjJ?=
 =?iso-8859-1?Q?k7FNBNlWksDsNFI9wI4hNiihRtCAOxU52g4k94mdEjx3K+BUNM/q8nxSzN?=
 =?iso-8859-1?Q?ROo07ZcTX+?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB2870958A354B7477697AC13EFBA49BYAPR12MB2870namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0c12fb-5a1e-4b60-b196-08d97f20b1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 06:01:04.7230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yXW9szVLgq6GsX8bzZ/attkOb1M7diTjoEEkhhkLvZfvLAglvZy3goEu0d+QL8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3269
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB2870958A354B7477697AC13EFBA49BYAPR12MB2870namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]



________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Friday, September 24, 2021 1:33 AM
To: Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Cc: Jacob, Anson <Anson.Jacob@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; W=
entland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueir=
a@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: move FPU associated DSC code to DM=
L folder

Am 24.09.21 um 05:22 schrieb Qingqing Zhuo:
> As part of the FPU isolation work documented in
> https://patchwork.freedesktop.org/series/93042/, isolate
> code that uses FPU in DSC to DML, where all FPU code
> should locate.
>
> This change does not refactor any fuctions but move code
> around.
>
> v2: remove more floating point related flags in dml/Makefile
>
> Cc: Anson Jacob <Anson.Jacob@amd.com>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>   dc/dml/dsc/rc_calc_fpu.c                      | 291 ++++++++++++++++++
>   dc/dml/dsc/rc_calc_fpu.h                      |  98 ++++++
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
>   .../amd/display/dc/{ =3D> dml}/dsc/qp_tables.h  |   0
>   .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 287 +++++++++++++++++
>   .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  89 ++++++
>   drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  29 --
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 257 ----------------
>   drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  50 +--
>   .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   1 -
>   10 files changed, 769 insertions(+), 336 deletions(-)
>   create mode 100644 dc/dml/dsc/rc_calc_fpu.c
>   create mode 100644 dc/dml/dsc/rc_calc_fpu.h
>   rename drivers/gpu/drm/amd/display/dc/{ =3D> dml}/dsc/qp_tables.h (100%=
)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h

That looks like the diff is somehow a bit messed up.

Why do you have both dc/dml/dsc/rc_calc_fpu.c and
drm/amd/display/dc/dml/dsc/rc_calc_fpu.c ?

Regards,
Christian.

--
Hi Christian,

Thanks for catching that! It seems that my repo got messed up. I will fix u=
p and send out v3.

Thank you,
Lillian

>
> diff --git a/dc/dml/dsc/rc_calc_fpu.c b/dc/dml/dsc/rc_calc_fpu.c
> new file mode 100644
> index 000000000000..e9b40cbefd6d
> --- /dev/null
> +++ b/dc/dml/dsc/rc_calc_fpu.c
> @@ -0,0 +1,291 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "rc_calc_fpu.h"
> +
> +#include "qp_tables.h"
> +#include "amdgpu_dm/dc_fpu.h"
> +
> +#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_=
min)
> +
> +#define MODE_SELECT(val444, val422, val420) \
> +     (cm =3D=3D CM_444 || cm =3D=3D CM_RGB) ? (val444) : (cm =3D=3D CM_4=
22 ? (val422) : (val420))
> +
> +
> +#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, m=
ax)): \
> +     table =3D qp_table_##mode##_##bpc##bpc_##max; \
> +     table_size =3D sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*q=
p_table_##mode##_##bpc##bpc_##max); \
> +     break
> +
> +static int median3(int a, int b, int c)
> +{
> +     if (a > b)
> +             swap(a, b);
> +     if (b > c)
> +             swap(b, c);
> +     if (a > b)
> +             swap(b, c);
> +
> +     return b;
> +}
> +
> +static double dsc_roundf(double num)
> +{
> +     if (num < 0.0)
> +             num =3D num - 0.5;
> +     else
> +             num =3D num + 0.5;
> +
> +     return (int)(num);
> +}
> +
> +static double dsc_ceil(double num)
> +{
> +     double retval =3D (int)num;
> +
> +     if (retval !=3D num && num > 0)
> +             retval =3D num + 1;
> +
> +     return (int)retval;
> +}
> +
> +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_co=
mp bpc,
> +                    enum max_min max_min, float bpp)
> +{
> +     int mode =3D MODE_SELECT(444, 422, 420);
> +     int sel =3D table_hash(mode, bpc, max_min);
> +     int table_size =3D 0;
> +     int index;
> +     const struct qp_entry *table =3D 0L;
> +
> +     // alias enum
> +     enum { min =3D DAL_MM_MIN, max =3D DAL_MM_MAX };
> +     switch (sel) {
> +             TABLE_CASE(444,  8, max);
> +             TABLE_CASE(444,  8, min);
> +             TABLE_CASE(444, 10, max);
> +             TABLE_CASE(444, 10, min);
> +             TABLE_CASE(444, 12, max);
> +             TABLE_CASE(444, 12, min);
> +             TABLE_CASE(422,  8, max);
> +             TABLE_CASE(422,  8, min);
> +             TABLE_CASE(422, 10, max);
> +             TABLE_CASE(422, 10, min);
> +             TABLE_CASE(422, 12, max);
> +             TABLE_CASE(422, 12, min);
> +             TABLE_CASE(420,  8, max);
> +             TABLE_CASE(420,  8, min);
> +             TABLE_CASE(420, 10, max);
> +             TABLE_CASE(420, 10, min);
> +             TABLE_CASE(420, 12, max);
> +             TABLE_CASE(420, 12, min);
> +     }
> +
> +     if (table =3D=3D 0)
> +             return;
> +
> +     index =3D (bpp - table[0].bpp) * 2;
> +
> +     /* requested size is bigger than the table */
> +     if (index >=3D table_size) {
> +             dm_error("ERROR: Requested rc_calc to find a bpp entry that=
 exceeds the table size\n");
> +             return;
> +     }
> +
> +     memcpy(qps, table[index].qps, sizeof(qp_set));
> +}
> +
> +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> +{
> +     int   *p =3D ofs;
> +
> +     if (mode =3D=3D CM_444 || mode =3D=3D CM_RGB) {
> +             *p++ =3D (bpp <=3D  6) ? (0) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (2) : ((bpp >=3D 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3=
.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-2) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (0) : ((bpp >=3D 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3=
.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-2) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (0) : ((bpp >=3D 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3=
.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-4) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (-2) : ((bpp >=3D 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4=
 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 /=
 3.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-6) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (-4) : ((bpp >=3D 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6=
 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 /=
 3.0))))));
> +             *p++ =3D (bpp <=3D 12) ? (-6) : ((bpp >=3D 15) ? (0) : (-6 =
+ dsc_roundf((bpp - 12) * (6 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-2) : (-8=
 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-4) : (-8=
 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-6) : (-8=
 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-10) : ((bpp >=3D 15) ? (-8) : (-=
10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +             *p++ =3D -10;
> +             *p++ =3D (bpp <=3D  6) ? (-12) : ((bpp >=3D  8) ? (-10) : (=
-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +     } else if (mode =3D=3D CM_422) {
> +             *p++ =3D (bpp <=3D  8) ? (2) : ((bpp >=3D 10) ? (10) : (2 +=
 dsc_roundf((bpp -  8) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (0) : ((bpp >=3D 10) ? (8) : (0 + =
dsc_roundf((bpp -  8) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (0) : ((bpp >=3D 10) ? (6) : (0 + =
dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-2) : ((bpp >=3D 10) ? (4) : (-2 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-4) : ((bpp >=3D 10) ? (2) : (-4 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-6) : ((bpp >=3D 10) ? (0) : (-6 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-2) : (-8=
 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-4) : (-8=
 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-6) : (-8=
 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-10) : ((bpp >=3D 10) ? (-8) : (-=
10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +             *p++ =3D -10;
> +             *p++ =3D (bpp <=3D  6) ? (-12) : ((bpp >=3D 7) ? (-10) : (-=
12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +     } else {
> +             *p++ =3D (bpp <=3D  6) ? (2) : ((bpp >=3D  8) ? (10) : (2 +=
 dsc_roundf((bpp -  6) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (0) : ((bpp >=3D  8) ? (8) : (0 + =
dsc_roundf((bpp -  6) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (0) : ((bpp >=3D  8) ? (6) : (0 + =
dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-2) : ((bpp >=3D  8) ? (4) : (-2 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-4) : ((bpp >=3D  8) ? (2) : (-4 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-6) : ((bpp >=3D  8) ? (0) : (-6 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-2) : (-8=
 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-4) : (-8=
 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-6) : (-8=
 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-10) : ((bpp >=3D  8) ? (-8) : (-=
10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +             *p++ =3D -10;
> +             *p++ =3D (bpp <=3D  4) ? (-12) : ((bpp >=3D  5) ? (-10) : (=
-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +     }
> +}
> +
> +void _do_calc_rc_params(struct rc_params *rc,
> +             enum colour_mode cm,
> +             enum bits_per_comp bpc,
> +             u16 drm_bpp,
> +             bool is_navite_422_or_420,
> +             int slice_width,
> +             int slice_height,
> +             int minor_version)
> +{
> +     float bpp;
> +     float bpp_group;
> +     float initial_xmit_delay_factor;
> +     int padding_pixels;
> +     int i;
> +
> +     dc_assert_fp_enabled();
> +
> +     bpp =3D ((float)drm_bpp / 16.0);
> +     /* in native_422 or native_420 modes, the bits_per_pixel is double =
the
> +      * target bpp (the latter is what calc_rc_params expects)
> +      */
> +     if (is_navite_422_or_420)
> +             bpp /=3D 2.0;
> +
> +     rc->rc_quant_incr_limit0 =3D ((bpc =3D=3D BPC_8) ? 11 : (bpc =3D=3D=
 BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444) ? 1 : 0=
);
> +     rc->rc_quant_incr_limit1 =3D ((bpc =3D=3D BPC_8) ? 11 : (bpc =3D=3D=
 BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444) ? 1 : 0=
);
> +
> +     bpp_group =3D MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> +
> +     switch (cm) {
> +     case CM_420:
> +             rc->initial_fullness_offset =3D (bpp >=3D  6) ? (2048) : ((=
bpp <=3D  4) ? (6144) : ((((bpp >  4) && (bpp <=3D  5))) ? (6144 - dsc_roun=
df((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> +             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> +             rc->second_line_bpg_offset  =3D median3(0, 12, (int)((3 * b=
pc * 3) - (3 * bpp_group)));
> +             break;
> +     case CM_422:
> +             rc->initial_fullness_offset =3D (bpp >=3D  8) ? (2048) : ((=
bpp <=3D  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> +             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> +             rc->second_line_bpg_offset  =3D 0;
> +             break;
> +     case CM_444:
> +     case CM_RGB:
> +             rc->initial_fullness_offset =3D (bpp >=3D 12) ? (2048) : ((=
bpp <=3D  8) ? (6144) : ((((bpp >  8) && (bpp <=3D 10))) ? (6144 - dsc_roun=
df((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))))=
;
> +             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm =3D=3D CM_444 ? 0 :=
 2)) * 3) - (3 * bpp_group)));
> +             rc->second_line_bpg_offset  =3D 0;
> +             break;
> +     }
> +
> +     initial_xmit_delay_factor =3D (cm =3D=3D CM_444 || cm =3D=3D CM_RGB=
) ? 1.0 : 2.0;
> +     rc->initial_xmit_delay =3D dsc_roundf(8192.0/2.0/bpp/initial_xmit_d=
elay_factor);
> +
> +     if (cm =3D=3D CM_422 || cm =3D=3D CM_420)
> +             slice_width /=3D 2;
> +
> +     padding_pixels =3D ((slice_width % 3) !=3D 0) ? (3 - (slice_width %=
 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> +     if (3 * bpp_group >=3D (((rc->initial_xmit_delay + 2) / 3) * (3 + (=
cm =3D=3D CM_422)))) {
> +             if ((rc->initial_xmit_delay + padding_pixels) % 3 =3D=3D 1)
> +                     rc->initial_xmit_delay++;
> +     }
> +
> +     rc->flatness_min_qp     =3D ((bpc =3D=3D BPC_8) ?  (3) : ((bpc =3D=
=3D BPC_10) ? (7)  : (11))) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444)=
 ? 1 : 0);
> +     rc->flatness_max_qp     =3D ((bpc =3D=3D BPC_8) ? (12) : ((bpc =3D=
=3D BPC_10) ? (16) : (20))) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444)=
 ? 1 : 0);
> +     rc->flatness_det_thresh =3D 2 << (bpc - 8);
> +
> +     get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> +     get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> +     if (cm =3D=3D CM_444 && minor_version =3D=3D 1) {
> +             for (i =3D 0; i < QP_SET_SIZE; ++i) {
> +                     rc->qp_min[i] =3D rc->qp_min[i] > 0 ? rc->qp_min[i]=
 - 1 : 0;
> +                     rc->qp_max[i] =3D rc->qp_max[i] > 0 ? rc->qp_max[i]=
 - 1 : 0;
> +             }
> +     }
> +     get_ofs_set(rc->ofs, cm, bpp);
> +
> +     /* fixed parameters */
> +     rc->rc_model_size    =3D 8192;
> +     rc->rc_edge_factor   =3D 6;
> +     rc->rc_tgt_offset_hi =3D 3;
> +     rc->rc_tgt_offset_lo =3D 3;
> +
> +     rc->rc_buf_thresh[0] =3D 896;
> +     rc->rc_buf_thresh[1] =3D 1792;
> +     rc->rc_buf_thresh[2] =3D 2688;
> +     rc->rc_buf_thresh[3] =3D 3584;
> +     rc->rc_buf_thresh[4] =3D 4480;
> +     rc->rc_buf_thresh[5] =3D 5376;
> +     rc->rc_buf_thresh[6] =3D 6272;
> +     rc->rc_buf_thresh[7] =3D 6720;
> +     rc->rc_buf_thresh[8] =3D 7168;
> +     rc->rc_buf_thresh[9] =3D 7616;
> +     rc->rc_buf_thresh[10] =3D 7744;
> +     rc->rc_buf_thresh[11] =3D 7872;
> +     rc->rc_buf_thresh[12] =3D 8000;
> +     rc->rc_buf_thresh[13] =3D 8064;
> +}
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width,
> +             u16 drm_bpp,
> +             bool is_navite_422_or_420)
> +{
> +     float bpp;
> +     u32 bytes_per_pixel;
> +     double d_bytes_per_pixel;
> +
> +     dc_assert_fp_enabled();
> +
> +     bpp =3D ((float)drm_bpp / 16.0);
> +     d_bytes_per_pixel =3D dsc_ceil(bpp * slice_width / 8.0) / slice_wid=
th;
> +     // TODO: Make sure the formula for calculating this is precise (cei=
ling
> +     // vs. floor, and at what point they should be applied)
> +     if (is_navite_422_or_420)
> +             d_bytes_per_pixel /=3D 2;
> +
> +     bytes_per_pixel =3D (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> +
> +     return bytes_per_pixel;
> +}
> \ No newline at end of file
> diff --git a/dc/dml/dsc/rc_calc_fpu.h b/dc/dml/dsc/rc_calc_fpu.h
> new file mode 100644
> index 000000000000..8f2cd1364b13
> --- /dev/null
> +++ b/dc/dml/dsc/rc_calc_fpu.h
> @@ -0,0 +1,98 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __RC_CALC_FPU_H__
> +#define __RC_CALC_FPU_H__
> +
> +#include "os_types.h"
> +#ifdef LINUX_DM
> +#include <drm/drm_dsc.h>
> +#else
> +#include <include/drm_dsc_dc.h>
> +#endif
> +
> +#define QP_SET_SIZE 15
> +
> +typedef int qp_set[QP_SET_SIZE];
> +
> +struct rc_params {
> +     int      rc_quant_incr_limit0;
> +     int      rc_quant_incr_limit1;
> +     int      initial_fullness_offset;
> +     int      initial_xmit_delay;
> +     int      first_line_bpg_offset;
> +     int      second_line_bpg_offset;
> +     int      flatness_min_qp;
> +     int      flatness_max_qp;
> +     int      flatness_det_thresh;
> +     qp_set   qp_min;
> +     qp_set   qp_max;
> +     qp_set   ofs;
> +     int      rc_model_size;
> +     int      rc_edge_factor;
> +     int      rc_tgt_offset_hi;
> +     int      rc_tgt_offset_lo;
> +     int      rc_buf_thresh[QP_SET_SIZE - 1];
> +};
> +
> +enum colour_mode {
> +     CM_RGB,   /* 444 RGB */
> +     CM_444,   /* 444 YUV or simple 422 */
> +     CM_422,   /* native 422 */
> +     CM_420    /* native 420 */
> +};
> +
> +enum bits_per_comp {
> +     BPC_8  =3D  8,
> +     BPC_10 =3D 10,
> +     BPC_12 =3D 12
> +};
> +
> +enum max_min {
> +     DAL_MM_MIN =3D 0,
> +     DAL_MM_MAX =3D 1
> +};
> +
> +struct qp_entry {
> +     float         bpp;
> +     const qp_set  qps;
> +};
> +
> +typedef struct qp_entry qp_table[];
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width,
> +             u16 drm_bpp,
> +             bool is_navite_422_or_420);
> +
> +void _do_calc_rc_params(struct rc_params *rc,
> +             enum colour_mode cm,
> +             enum bits_per_comp bpc,
> +             u16 drm_bpp,
> +             bool is_navite_422_or_420,
> +             int slice_width,
> +             int slice_height,
> +             int minor_version);
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/dr=
m/amd/display/dc/dml/Makefile
> index 56055df2e8d2..9009b92490f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o=
 :=3D $(dml_ccflags) $(fram
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o :=3D $(dml_c=
cflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o :=3D $(dml_ccfl=
ags) $(frame_warn_flag)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D $(dml_c=
cflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o :=3D $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_ccflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D $(dml_rcflag=
s)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dml_rcflags)
> @@ -84,6 +85,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg=
_calc_30.o :=3D $(dml_rcfla
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o :=3D $(d=
ml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o :=3D =
$(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_rcflag=
s)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  :=3D $(dml_rcflags=
)
>   endif
>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=3D $(dml_ccfla=
gs)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D $(dml_ccflags=
)
> @@ -99,6 +101,7 @@ DML +=3D dcn20/display_rq_dlg_calc_20v2.o dcn20/displa=
y_mode_vba_20v2.o
>   DML +=3D dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
>   DML +=3D dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
>   DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
> +DML +=3D dsc/rc_calc_fpu.o
>   endif
>
>   AMD_DAL_DML =3D $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h b/drivers/gpu=
/drm/amd/display/dc/dml/dsc/qp_tables.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h
> rename to drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> new file mode 100644
> index 000000000000..0436fc64948f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -0,0 +1,287 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "rc_calc_fpu.h"
> +
> +#include "qp_tables.h"
> +#include "amdgpu_dm/dc_fpu.h"
> +
> +#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_=
min)
> +
> +#define MODE_SELECT(val444, val422, val420) \
> +     (cm =3D=3D CM_444 || cm =3D=3D CM_RGB) ? (val444) : (cm =3D=3D CM_4=
22 ? (val422) : (val420))
> +
> +
> +#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, m=
ax)): \
> +     table =3D qp_table_##mode##_##bpc##bpc_##max; \
> +     table_size =3D sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*q=
p_table_##mode##_##bpc##bpc_##max); \
> +     break
> +
> +static int median3(int a, int b, int c)
> +{
> +     if (a > b)
> +             swap(a, b);
> +     if (b > c)
> +             swap(b, c);
> +     if (a > b)
> +             swap(b, c);
> +
> +     return b;
> +}
> +
> +static double dsc_roundf(double num)
> +{
> +     if (num < 0.0)
> +             num =3D num - 0.5;
> +     else
> +             num =3D num + 0.5;
> +
> +     return (int)(num);
> +}
> +
> +static double dsc_ceil(double num)
> +{
> +     double retval =3D (int)num;
> +
> +     if (retval !=3D num && num > 0)
> +             retval =3D num + 1;
> +
> +     return (int)retval;
> +}
> +
> +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_co=
mp bpc,
> +                    enum max_min max_min, float bpp)
> +{
> +     int mode =3D MODE_SELECT(444, 422, 420);
> +     int sel =3D table_hash(mode, bpc, max_min);
> +     int table_size =3D 0;
> +     int index;
> +     const struct qp_entry *table =3D 0L;
> +
> +     // alias enum
> +     enum { min =3D DAL_MM_MIN, max =3D DAL_MM_MAX };
> +     switch (sel) {
> +             TABLE_CASE(444,  8, max);
> +             TABLE_CASE(444,  8, min);
> +             TABLE_CASE(444, 10, max);
> +             TABLE_CASE(444, 10, min);
> +             TABLE_CASE(444, 12, max);
> +             TABLE_CASE(444, 12, min);
> +             TABLE_CASE(422,  8, max);
> +             TABLE_CASE(422,  8, min);
> +             TABLE_CASE(422, 10, max);
> +             TABLE_CASE(422, 10, min);
> +             TABLE_CASE(422, 12, max);
> +             TABLE_CASE(422, 12, min);
> +             TABLE_CASE(420,  8, max);
> +             TABLE_CASE(420,  8, min);
> +             TABLE_CASE(420, 10, max);
> +             TABLE_CASE(420, 10, min);
> +             TABLE_CASE(420, 12, max);
> +             TABLE_CASE(420, 12, min);
> +     }
> +
> +     if (table =3D=3D 0)
> +             return;
> +
> +     index =3D (bpp - table[0].bpp) * 2;
> +
> +     /* requested size is bigger than the table */
> +     if (index >=3D table_size) {
> +             dm_error("ERROR: Requested rc_calc to find a bpp entry that=
 exceeds the table size\n");
> +             return;
> +     }
> +
> +     memcpy(qps, table[index].qps, sizeof(qp_set));
> +}
> +
> +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> +{
> +     int   *p =3D ofs;
> +
> +     if (mode =3D=3D CM_444 || mode =3D=3D CM_RGB) {
> +             *p++ =3D (bpp <=3D  6) ? (0) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (2) : ((bpp >=3D 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3=
.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-2) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (0) : ((bpp >=3D 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3=
.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-2) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (0) : ((bpp >=3D 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3=
.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-4) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (-2) : ((bpp >=3D 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4=
 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 /=
 3.0))))));
> +             *p++ =3D (bpp <=3D  6) ? (-6) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (-4) : ((bpp >=3D 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6=
 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 /=
 3.0))))));
> +             *p++ =3D (bpp <=3D 12) ? (-6) : ((bpp >=3D 15) ? (0) : (-6 =
+ dsc_roundf((bpp - 12) * (6 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-2) : (-8=
 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-4) : (-8=
 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-6) : (-8=
 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +             *p++ =3D (bpp <=3D 12) ? (-10) : ((bpp >=3D 15) ? (-8) : (-=
10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> +             *p++ =3D -10;
> +             *p++ =3D (bpp <=3D  6) ? (-12) : ((bpp >=3D  8) ? (-10) : (=
-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +     } else if (mode =3D=3D CM_422) {
> +             *p++ =3D (bpp <=3D  8) ? (2) : ((bpp >=3D 10) ? (10) : (2 +=
 dsc_roundf((bpp -  8) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (0) : ((bpp >=3D 10) ? (8) : (0 + =
dsc_roundf((bpp -  8) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (0) : ((bpp >=3D 10) ? (6) : (0 + =
dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-2) : ((bpp >=3D 10) ? (4) : (-2 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-4) : ((bpp >=3D 10) ? (2) : (-4 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-6) : ((bpp >=3D 10) ? (0) : (-6 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-2) : (-8=
 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-4) : (-8=
 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-6) : (-8=
 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +             *p++ =3D (bpp <=3D  8) ? (-10) : ((bpp >=3D 10) ? (-8) : (-=
10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> +             *p++ =3D -10;
> +             *p++ =3D (bpp <=3D  6) ? (-12) : ((bpp >=3D 7) ? (-10) : (-=
12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +     } else {
> +             *p++ =3D (bpp <=3D  6) ? (2) : ((bpp >=3D  8) ? (10) : (2 +=
 dsc_roundf((bpp -  6) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (0) : ((bpp >=3D  8) ? (8) : (0 + =
dsc_roundf((bpp -  6) * (8 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (0) : ((bpp >=3D  8) ? (6) : (0 + =
dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-2) : ((bpp >=3D  8) ? (4) : (-2 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-4) : ((bpp >=3D  8) ? (2) : (-4 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-6) : ((bpp >=3D  8) ? (0) : (-6 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-2) : (-8=
 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-4) : (-8=
 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-6) : (-8=
 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +             *p++ =3D (bpp <=3D  6) ? (-10) : ((bpp >=3D  8) ? (-8) : (-=
10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> +             *p++ =3D -10;
> +             *p++ =3D (bpp <=3D  4) ? (-12) : ((bpp >=3D  5) ? (-10) : (=
-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +             *p++ =3D -12;
> +     }
> +}
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +                            enum bits_per_comp bpc, u16 drm_bpp,
> +                            bool is_navite_422_or_420,
> +                            int slice_width, int slice_height,
> +                            int minor_version)
> +{
> +     float bpp;
> +     float bpp_group;
> +     float initial_xmit_delay_factor;
> +     int padding_pixels;
> +     int i;
> +
> +     dc_assert_fp_enabled();
> +
> +     bpp =3D ((float)drm_bpp / 16.0);
> +     /* in native_422 or native_420 modes, the bits_per_pixel is double =
the
> +      * target bpp (the latter is what calc_rc_params expects)
> +      */
> +     if (is_navite_422_or_420)
> +             bpp /=3D 2.0;
> +
> +     rc->rc_quant_incr_limit0 =3D ((bpc =3D=3D BPC_8) ? 11 : (bpc =3D=3D=
 BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444) ? 1 : 0=
);
> +     rc->rc_quant_incr_limit1 =3D ((bpc =3D=3D BPC_8) ? 11 : (bpc =3D=3D=
 BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444) ? 1 : 0=
);
> +
> +     bpp_group =3D MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> +
> +     switch (cm) {
> +     case CM_420:
> +             rc->initial_fullness_offset =3D (bpp >=3D  6) ? (2048) : ((=
bpp <=3D  4) ? (6144) : ((((bpp >  4) && (bpp <=3D  5))) ? (6144 - dsc_roun=
df((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> +             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> +             rc->second_line_bpg_offset  =3D median3(0, 12, (int)((3 * b=
pc * 3) - (3 * bpp_group)));
> +             break;
> +     case CM_422:
> +             rc->initial_fullness_offset =3D (bpp >=3D  8) ? (2048) : ((=
bpp <=3D  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> +             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> +             rc->second_line_bpg_offset  =3D 0;
> +             break;
> +     case CM_444:
> +     case CM_RGB:
> +             rc->initial_fullness_offset =3D (bpp >=3D 12) ? (2048) : ((=
bpp <=3D  8) ? (6144) : ((((bpp >  8) && (bpp <=3D 10))) ? (6144 - dsc_roun=
df((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))))=
;
> +             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm =3D=3D CM_444 ? 0 :=
 2)) * 3) - (3 * bpp_group)));
> +             rc->second_line_bpg_offset  =3D 0;
> +             break;
> +     }
> +
> +     initial_xmit_delay_factor =3D (cm =3D=3D CM_444 || cm =3D=3D CM_RGB=
) ? 1.0 : 2.0;
> +     rc->initial_xmit_delay =3D dsc_roundf(8192.0/2.0/bpp/initial_xmit_d=
elay_factor);
> +
> +     if (cm =3D=3D CM_422 || cm =3D=3D CM_420)
> +             slice_width /=3D 2;
> +
> +     padding_pixels =3D ((slice_width % 3) !=3D 0) ? (3 - (slice_width %=
 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> +     if (3 * bpp_group >=3D (((rc->initial_xmit_delay + 2) / 3) * (3 + (=
cm =3D=3D CM_422)))) {
> +             if ((rc->initial_xmit_delay + padding_pixels) % 3 =3D=3D 1)
> +                     rc->initial_xmit_delay++;
> +     }
> +
> +     rc->flatness_min_qp     =3D ((bpc =3D=3D BPC_8) ?  (3) : ((bpc =3D=
=3D BPC_10) ? (7)  : (11))) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444)=
 ? 1 : 0);
> +     rc->flatness_max_qp     =3D ((bpc =3D=3D BPC_8) ? (12) : ((bpc =3D=
=3D BPC_10) ? (16) : (20))) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444)=
 ? 1 : 0);
> +     rc->flatness_det_thresh =3D 2 << (bpc - 8);
> +
> +     get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> +     get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> +     if (cm =3D=3D CM_444 && minor_version =3D=3D 1) {
> +             for (i =3D 0; i < QP_SET_SIZE; ++i) {
> +                     rc->qp_min[i] =3D rc->qp_min[i] > 0 ? rc->qp_min[i]=
 - 1 : 0;
> +                     rc->qp_max[i] =3D rc->qp_max[i] > 0 ? rc->qp_max[i]=
 - 1 : 0;
> +             }
> +     }
> +     get_ofs_set(rc->ofs, cm, bpp);
> +
> +     /* fixed parameters */
> +     rc->rc_model_size    =3D 8192;
> +     rc->rc_edge_factor   =3D 6;
> +     rc->rc_tgt_offset_hi =3D 3;
> +     rc->rc_tgt_offset_lo =3D 3;
> +
> +     rc->rc_buf_thresh[0] =3D 896;
> +     rc->rc_buf_thresh[1] =3D 1792;
> +     rc->rc_buf_thresh[2] =3D 2688;
> +     rc->rc_buf_thresh[3] =3D 3584;
> +     rc->rc_buf_thresh[4] =3D 4480;
> +     rc->rc_buf_thresh[5] =3D 5376;
> +     rc->rc_buf_thresh[6] =3D 6272;
> +     rc->rc_buf_thresh[7] =3D 6720;
> +     rc->rc_buf_thresh[8] =3D 7168;
> +     rc->rc_buf_thresh[9] =3D 7616;
> +     rc->rc_buf_thresh[10] =3D 7744;
> +     rc->rc_buf_thresh[11] =3D 7872;
> +     rc->rc_buf_thresh[12] =3D 8000;
> +     rc->rc_buf_thresh[13] =3D 8064;
> +}
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +                                 bool is_navite_422_or_420)
> +{
> +     float bpp;
> +     u32 bytes_per_pixel;
> +     double d_bytes_per_pixel;
> +
> +     dc_assert_fp_enabled();
> +
> +     bpp =3D ((float)drm_bpp / 16.0);
> +     d_bytes_per_pixel =3D dsc_ceil(bpp * slice_width / 8.0) / slice_wid=
th;
> +     // TODO: Make sure the formula for calculating this is precise (cei=
ling
> +     // vs. floor, and at what point they should be applied)
> +     if (is_navite_422_or_420)
> +             d_bytes_per_pixel /=3D 2;
> +
> +     bytes_per_pixel =3D (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> +
> +     return bytes_per_pixel;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/drive=
rs/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> new file mode 100644
> index 000000000000..d3900ff7fa89
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __RC_CALC_FPU_H__
> +#define __RC_CALC_FPU_H__
> +
> +#include "os_types.h"
> +
> +#define QP_SET_SIZE 15
> +
> +typedef int qp_set[QP_SET_SIZE];
> +
> +struct rc_params {
> +     int      rc_quant_incr_limit0;
> +     int      rc_quant_incr_limit1;
> +     int      initial_fullness_offset;
> +     int      initial_xmit_delay;
> +     int      first_line_bpg_offset;
> +     int      second_line_bpg_offset;
> +     int      flatness_min_qp;
> +     int      flatness_max_qp;
> +     int      flatness_det_thresh;
> +     qp_set   qp_min;
> +     qp_set   qp_max;
> +     qp_set   ofs;
> +     int      rc_model_size;
> +     int      rc_edge_factor;
> +     int      rc_tgt_offset_hi;
> +     int      rc_tgt_offset_lo;
> +     int      rc_buf_thresh[QP_SET_SIZE - 1];
> +};
> +
> +enum colour_mode {
> +     CM_RGB,   /* 444 RGB */
> +     CM_444,   /* 444 YUV or simple 422 */
> +     CM_422,   /* native 422 */
> +     CM_420    /* native 420 */
> +};
> +
> +enum bits_per_comp {
> +     BPC_8  =3D  8,
> +     BPC_10 =3D 10,
> +     BPC_12 =3D 12
> +};
> +
> +enum max_min {
> +     DAL_MM_MIN =3D 0,
> +     DAL_MM_MAX =3D 1
> +};
> +
> +struct qp_entry {
> +     float         bpp;
> +     const qp_set  qps;
> +};
> +
> +typedef struct qp_entry qp_table[];
> +
> +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> +                                 bool is_navite_422_or_420);
> +
> +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,
> +                            enum bits_per_comp bpc, u16 drm_bpp,
> +                            bool is_navite_422_or_420,
> +                            int slice_width, int slice_height,
> +                            int minor_version);
> +
> +#endif
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/dr=
m/amd/display/dc/dsc/Makefile
> index 8d31eb75c6a6..a2537229ee88 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -1,35 +1,6 @@
>   # SPDX-License-Identifier: MIT
>   #
>   # Makefile for the 'dsc' sub-component of DAL.
> -
> -ifdef CONFIG_X86
> -dsc_ccflags :=3D -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -dsc_ccflags :=3D -mhard-float -maltivec
> -endif
> -
> -ifdef CONFIG_CC_IS_GCC
> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> -IS_OLD_GCC =3D 1
> -endif
> -endif
> -
> -ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> -# Stack alignment mismatch, proceed with caution.
> -# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-bou=
ndary=3D3
> -# (8B stack alignment).
> -dsc_ccflags +=3D -mpreferred-stack-boundary=3D4
> -else
> -dsc_ccflags +=3D -msse2
> -endif
> -endif
> -
> -CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc.o :=3D $(dsc_ccflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dsc/rc_calc.o :=3D $(dsc_rcflags)
> -
>   DSC =3D dc_dsc.o rc_calc.o rc_calc_dpi.o
>
>   AMD_DAL_DSC =3D $(addprefix $(AMDDALPATH)/dc/dsc/,$(DSC))
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gpu/d=
rm/amd/display/dc/dsc/rc_calc.c
> index 7b294f637881..87acec33b8d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c
> @@ -25,264 +25,7 @@
>    */
>   #include <drm/drm_dsc.h>
>
> -#include "os_types.h"
>   #include "rc_calc.h"
> -#include "qp_tables.h"
> -
> -#define table_hash(mode, bpc, max_min) ((mode << 16) | (bpc << 8) | max_=
min)
> -
> -#define MODE_SELECT(val444, val422, val420) \
> -     (cm =3D=3D CM_444 || cm =3D=3D CM_RGB) ? (val444) : (cm =3D=3D CM_4=
22 ? (val422) : (val420))
> -
> -
> -#define TABLE_CASE(mode, bpc, max)   case (table_hash(mode, BPC_##bpc, m=
ax)): \
> -     table =3D qp_table_##mode##_##bpc##bpc_##max; \
> -     table_size =3D sizeof(qp_table_##mode##_##bpc##bpc_##max)/sizeof(*q=
p_table_##mode##_##bpc##bpc_##max); \
> -     break
> -
> -
> -static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_co=
mp bpc,
> -                    enum max_min max_min, float bpp)
> -{
> -     int mode =3D MODE_SELECT(444, 422, 420);
> -     int sel =3D table_hash(mode, bpc, max_min);
> -     int table_size =3D 0;
> -     int index;
> -     const struct qp_entry *table =3D 0L;
> -
> -     // alias enum
> -     enum { min =3D DAL_MM_MIN, max =3D DAL_MM_MAX };
> -     switch (sel) {
> -             TABLE_CASE(444,  8, max);
> -             TABLE_CASE(444,  8, min);
> -             TABLE_CASE(444, 10, max);
> -             TABLE_CASE(444, 10, min);
> -             TABLE_CASE(444, 12, max);
> -             TABLE_CASE(444, 12, min);
> -             TABLE_CASE(422,  8, max);
> -             TABLE_CASE(422,  8, min);
> -             TABLE_CASE(422, 10, max);
> -             TABLE_CASE(422, 10, min);
> -             TABLE_CASE(422, 12, max);
> -             TABLE_CASE(422, 12, min);
> -             TABLE_CASE(420,  8, max);
> -             TABLE_CASE(420,  8, min);
> -             TABLE_CASE(420, 10, max);
> -             TABLE_CASE(420, 10, min);
> -             TABLE_CASE(420, 12, max);
> -             TABLE_CASE(420, 12, min);
> -     }
> -
> -     if (table =3D=3D 0)
> -             return;
> -
> -     index =3D (bpp - table[0].bpp) * 2;
> -
> -     /* requested size is bigger than the table */
> -     if (index >=3D table_size) {
> -             dm_error("ERROR: Requested rc_calc to find a bpp entry that=
 exceeds the table size\n");
> -             return;
> -     }
> -
> -     memcpy(qps, table[index].qps, sizeof(qp_set));
> -}
> -
> -static double dsc_roundf(double num)
> -{
> -     if (num < 0.0)
> -             num =3D num - 0.5;
> -     else
> -             num =3D num + 0.5;
> -
> -     return (int)(num);
> -}
> -
> -static double dsc_ceil(double num)
> -{
> -     double retval =3D (int)num;
> -
> -     if (retval !=3D num && num > 0)
> -             retval =3D num + 1;
> -
> -     return (int)retval;
> -}
> -
> -static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)
> -{
> -     int   *p =3D ofs;
> -
> -     if (mode =3D=3D CM_444 || mode =3D=3D CM_RGB) {
> -             *p++ =3D (bpp <=3D  6) ? (0) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (2) : ((bpp >=3D 15) ? (10) : ((((bpp > 6) && (bpp < 8))) ? (0 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (2 + dsc_roundf((bpp - 12) * (8 / 3=
.0))))));
> -             *p++ =3D (bpp <=3D  6) ? (-2) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (0) : ((bpp >=3D 15) ? (8) : ((((bpp > 6) && (bpp < 8))) ? (-2 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (8 / 3=
.0))))));
> -             *p++ =3D (bpp <=3D  6) ? (-2) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (0) : ((bpp >=3D 15) ? (6) : ((((bpp > 6) && (bpp < 8))) ? (-2 =
+ dsc_roundf((bpp -  6) * (2 / 2.0))) : (0 + dsc_roundf((bpp - 12) * (6 / 3=
.0))))));
> -             *p++ =3D (bpp <=3D  6) ? (-4) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (-2) : ((bpp >=3D 15) ? (4) : ((((bpp > 6) && (bpp < 8))) ? (-4=
 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-2 + dsc_roundf((bpp - 12) * (6 /=
 3.0))))));
> -             *p++ =3D (bpp <=3D  6) ? (-6) : ((((bpp >=3D  8) && (bpp <=
=3D 12))) ? (-4) : ((bpp >=3D 15) ? (2) : ((((bpp > 6) && (bpp < 8))) ? (-6=
 + dsc_roundf((bpp -  6) * (2 / 2.0))) : (-4 + dsc_roundf((bpp - 12) * (6 /=
 3.0))))));
> -             *p++ =3D (bpp <=3D 12) ? (-6) : ((bpp >=3D 15) ? (0) : (-6 =
+ dsc_roundf((bpp - 12) * (6 / 3.0))));
> -             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-2) : (-8=
 + dsc_roundf((bpp - 12) * (6 / 3.0))));
> -             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-4) : (-8=
 + dsc_roundf((bpp - 12) * (4 / 3.0))));
> -             *p++ =3D (bpp <=3D 12) ? (-8) : ((bpp >=3D 15) ? (-6) : (-8=
 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -             *p++ =3D (bpp <=3D 12) ? (-10) : ((bpp >=3D 15) ? (-8) : (-=
10 + dsc_roundf((bpp - 12) * (2 / 3.0))));
> -             *p++ =3D -10;
> -             *p++ =3D (bpp <=3D  6) ? (-12) : ((bpp >=3D  8) ? (-10) : (=
-12 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -             *p++ =3D -12;
> -             *p++ =3D -12;
> -             *p++ =3D -12;
> -     } else if (mode =3D=3D CM_422) {
> -             *p++ =3D (bpp <=3D  8) ? (2) : ((bpp >=3D 10) ? (10) : (2 +=
 dsc_roundf((bpp -  8) * (8 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (0) : ((bpp >=3D 10) ? (8) : (0 + =
dsc_roundf((bpp -  8) * (8 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (0) : ((bpp >=3D 10) ? (6) : (0 + =
dsc_roundf((bpp -  8) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-2) : ((bpp >=3D 10) ? (4) : (-2 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-4) : ((bpp >=3D 10) ? (2) : (-4 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-6) : ((bpp >=3D 10) ? (0) : (-6 =
+ dsc_roundf((bpp -  8) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-2) : (-8=
 + dsc_roundf((bpp -  8) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-4) : (-8=
 + dsc_roundf((bpp -  8) * (4 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-8) : ((bpp >=3D 10) ? (-6) : (-8=
 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -             *p++ =3D (bpp <=3D  8) ? (-10) : ((bpp >=3D 10) ? (-8) : (-=
10 + dsc_roundf((bpp -  8) * (2 / 2.0))));
> -             *p++ =3D -10;
> -             *p++ =3D (bpp <=3D  6) ? (-12) : ((bpp >=3D 7) ? (-10) : (-=
12 + dsc_roundf((bpp -  6) * (2.0 / 1))));
> -             *p++ =3D -12;
> -             *p++ =3D -12;
> -             *p++ =3D -12;
> -     } else {
> -             *p++ =3D (bpp <=3D  6) ? (2) : ((bpp >=3D  8) ? (10) : (2 +=
 dsc_roundf((bpp -  6) * (8 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (0) : ((bpp >=3D  8) ? (8) : (0 + =
dsc_roundf((bpp -  6) * (8 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (0) : ((bpp >=3D  8) ? (6) : (0 + =
dsc_roundf((bpp -  6) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-2) : ((bpp >=3D  8) ? (4) : (-2 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-4) : ((bpp >=3D  8) ? (2) : (-4 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-6) : ((bpp >=3D  8) ? (0) : (-6 =
+ dsc_roundf((bpp -  6) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-2) : (-8=
 + dsc_roundf((bpp -  6) * (6 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-4) : (-8=
 + dsc_roundf((bpp -  6) * (4 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-8) : ((bpp >=3D  8) ? (-6) : (-8=
 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -             *p++ =3D (bpp <=3D  6) ? (-10) : ((bpp >=3D  8) ? (-8) : (-=
10 + dsc_roundf((bpp -  6) * (2 / 2.0))));
> -             *p++ =3D -10;
> -             *p++ =3D (bpp <=3D  4) ? (-12) : ((bpp >=3D  5) ? (-10) : (=
-12 + dsc_roundf((bpp -  4) * (2 / 1.0))));
> -             *p++ =3D -12;
> -             *p++ =3D -12;
> -             *p++ =3D -12;
> -     }
> -}
> -
> -static int median3(int a, int b, int c)
> -{
> -     if (a > b)
> -             swap(a, b);
> -     if (b > c)
> -             swap(b, c);
> -     if (a > b)
> -             swap(b, c);
> -
> -     return b;
> -}
> -
> -static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm=
,
> -                            enum bits_per_comp bpc, u16 drm_bpp,
> -                            bool is_navite_422_or_420,
> -                            int slice_width, int slice_height,
> -                            int minor_version)
> -{
> -     float bpp;
> -     float bpp_group;
> -     float initial_xmit_delay_factor;
> -     int padding_pixels;
> -     int i;
> -
> -     bpp =3D ((float)drm_bpp / 16.0);
> -     /* in native_422 or native_420 modes, the bits_per_pixel is double =
the
> -      * target bpp (the latter is what calc_rc_params expects)
> -      */
> -     if (is_navite_422_or_420)
> -             bpp /=3D 2.0;
> -
> -     rc->rc_quant_incr_limit0 =3D ((bpc =3D=3D BPC_8) ? 11 : (bpc =3D=3D=
 BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444) ? 1 : 0=
);
> -     rc->rc_quant_incr_limit1 =3D ((bpc =3D=3D BPC_8) ? 11 : (bpc =3D=3D=
 BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444) ? 1 : 0=
);
> -
> -     bpp_group =3D MODE_SELECT(bpp, bpp * 2.0, bpp * 2.0);
> -
> -     switch (cm) {
> -     case CM_420:
> -             rc->initial_fullness_offset =3D (bpp >=3D  6) ? (2048) : ((=
bpp <=3D  4) ? (6144) : ((((bpp >  4) && (bpp <=3D  5))) ? (6144 - dsc_roun=
df((bpp - 4) * (512))) : (5632 - dsc_roundf((bpp -  5) * (3584)))));
> -             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_group)));
> -             rc->second_line_bpg_offset  =3D median3(0, 12, (int)((3 * b=
pc * 3) - (3 * bpp_group)));
> -             break;
> -     case CM_422:
> -             rc->initial_fullness_offset =3D (bpp >=3D  8) ? (2048) : ((=
bpp <=3D  7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));
> -             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_group)));
> -             rc->second_line_bpg_offset  =3D 0;
> -             break;
> -     case CM_444:
> -     case CM_RGB:
> -             rc->initial_fullness_offset =3D (bpp >=3D 12) ? (2048) : ((=
bpp <=3D  8) ? (6144) : ((((bpp >  8) && (bpp <=3D 10))) ? (6144 - dsc_roun=
df((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp - 10) * (3584 / 2)))))=
;
> -             rc->first_line_bpg_offset   =3D median3(0, (12 + (int) (0.0=
9 *  min(34, slice_height - 8))), (int)(((3 * bpc + (cm =3D=3D CM_444 ? 0 :=
 2)) * 3) - (3 * bpp_group)));
> -             rc->second_line_bpg_offset  =3D 0;
> -             break;
> -     }
> -
> -     initial_xmit_delay_factor =3D (cm =3D=3D CM_444 || cm =3D=3D CM_RGB=
) ? 1.0 : 2.0;
> -     rc->initial_xmit_delay =3D dsc_roundf(8192.0/2.0/bpp/initial_xmit_d=
elay_factor);
> -
> -     if (cm =3D=3D CM_422 || cm =3D=3D CM_420)
> -             slice_width /=3D 2;
> -
> -     padding_pixels =3D ((slice_width % 3) !=3D 0) ? (3 - (slice_width %=
 3)) * (rc->initial_xmit_delay / slice_width) : 0;
> -     if (3 * bpp_group >=3D (((rc->initial_xmit_delay + 2) / 3) * (3 + (=
cm =3D=3D CM_422)))) {
> -             if ((rc->initial_xmit_delay + padding_pixels) % 3 =3D=3D 1)
> -                     rc->initial_xmit_delay++;
> -     }
> -
> -     rc->flatness_min_qp     =3D ((bpc =3D=3D BPC_8) ?  (3) : ((bpc =3D=
=3D BPC_10) ? (7)  : (11))) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444)=
 ? 1 : 0);
> -     rc->flatness_max_qp     =3D ((bpc =3D=3D BPC_8) ? (12) : ((bpc =3D=
=3D BPC_10) ? (16) : (20))) - ((minor_version =3D=3D 1 && cm =3D=3D CM_444)=
 ? 1 : 0);
> -     rc->flatness_det_thresh =3D 2 << (bpc - 8);
> -
> -     get_qp_set(rc->qp_min, cm, bpc, DAL_MM_MIN, bpp);
> -     get_qp_set(rc->qp_max, cm, bpc, DAL_MM_MAX, bpp);
> -     if (cm =3D=3D CM_444 && minor_version =3D=3D 1) {
> -             for (i =3D 0; i < QP_SET_SIZE; ++i) {
> -                     rc->qp_min[i] =3D rc->qp_min[i] > 0 ? rc->qp_min[i]=
 - 1 : 0;
> -                     rc->qp_max[i] =3D rc->qp_max[i] > 0 ? rc->qp_max[i]=
 - 1 : 0;
> -             }
> -     }
> -     get_ofs_set(rc->ofs, cm, bpp);
> -
> -     /* fixed parameters */
> -     rc->rc_model_size    =3D 8192;
> -     rc->rc_edge_factor   =3D 6;
> -     rc->rc_tgt_offset_hi =3D 3;
> -     rc->rc_tgt_offset_lo =3D 3;
> -
> -     rc->rc_buf_thresh[0] =3D 896;
> -     rc->rc_buf_thresh[1] =3D 1792;
> -     rc->rc_buf_thresh[2] =3D 2688;
> -     rc->rc_buf_thresh[3] =3D 3584;
> -     rc->rc_buf_thresh[4] =3D 4480;
> -     rc->rc_buf_thresh[5] =3D 5376;
> -     rc->rc_buf_thresh[6] =3D 6272;
> -     rc->rc_buf_thresh[7] =3D 6720;
> -     rc->rc_buf_thresh[8] =3D 7168;
> -     rc->rc_buf_thresh[9] =3D 7616;
> -     rc->rc_buf_thresh[10] =3D 7744;
> -     rc->rc_buf_thresh[11] =3D 7872;
> -     rc->rc_buf_thresh[12] =3D 8000;
> -     rc->rc_buf_thresh[13] =3D 8064;
> -}
> -
> -static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,
> -                                 bool is_navite_422_or_420)
> -{
> -     float bpp;
> -     u32 bytes_per_pixel;
> -     double d_bytes_per_pixel;
> -
> -     bpp =3D ((float)drm_bpp / 16.0);
> -     d_bytes_per_pixel =3D dsc_ceil(bpp * slice_width / 8.0) / slice_wid=
th;
> -     // TODO: Make sure the formula for calculating this is precise (cei=
ling
> -     // vs. floor, and at what point they should be applied)
> -     if (is_navite_422_or_420)
> -             d_bytes_per_pixel /=3D 2;
> -
> -     bytes_per_pixel =3D (u32)dsc_ceil(d_bytes_per_pixel * 0x10000000);
> -
> -     return bytes_per_pixel;
> -}
>
>   /**
>    * calc_rc_params - reads the user's cmdline mode
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gpu/d=
rm/amd/display/dc/dsc/rc_calc.h
> index 262f06afcbf9..c2340e001b57 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h
> @@ -27,55 +27,7 @@
>   #ifndef __RC_CALC_H__
>   #define __RC_CALC_H__
>
> -
> -#define QP_SET_SIZE 15
> -
> -typedef int qp_set[QP_SET_SIZE];
> -
> -struct rc_params {
> -     int      rc_quant_incr_limit0;
> -     int      rc_quant_incr_limit1;
> -     int      initial_fullness_offset;
> -     int      initial_xmit_delay;
> -     int      first_line_bpg_offset;
> -     int      second_line_bpg_offset;
> -     int      flatness_min_qp;
> -     int      flatness_max_qp;
> -     int      flatness_det_thresh;
> -     qp_set   qp_min;
> -     qp_set   qp_max;
> -     qp_set   ofs;
> -     int      rc_model_size;
> -     int      rc_edge_factor;
> -     int      rc_tgt_offset_hi;
> -     int      rc_tgt_offset_lo;
> -     int      rc_buf_thresh[QP_SET_SIZE - 1];
> -};
> -
> -enum colour_mode {
> -     CM_RGB,   /* 444 RGB */
> -     CM_444,   /* 444 YUV or simple 422 */
> -     CM_422,   /* native 422 */
> -     CM_420    /* native 420 */
> -};
> -
> -enum bits_per_comp {
> -     BPC_8  =3D  8,
> -     BPC_10 =3D 10,
> -     BPC_12 =3D 12
> -};
> -
> -enum max_min {
> -     DAL_MM_MIN =3D 0,
> -     DAL_MM_MAX =3D 1
> -};
> -
> -struct qp_entry {
> -     float         bpp;
> -     const qp_set  qps;
> -};
> -
> -typedef struct qp_entry qp_table[];
> +#include "dml/dsc/rc_calc_fpu.h"
>
>   void calc_rc_params(struct rc_params *rc, const struct drm_dsc_config *=
pps);
>   u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *pps);
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/g=
pu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> index ef830aded5b1..1e19dd674e5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
> @@ -22,7 +22,6 @@
>    * Authors: AMD
>    *
>    */
> -#include "os_types.h"
>   #include <drm/drm_dsc.h>
>   #include "dscc_types.h"
>   #include "rc_calc.h"


--_000_BYAPR12MB2870958A354B7477697AC13EFBA49BYAPR12MB2870namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Koenig, Christian &=
lt;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Friday, September 24, 2021 1:33 AM<br>
<b>To:</b> Zhuo, Qingqing &lt;Qingqing.Zhuo@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Jacob, Anson &lt;Anson.Jacob@amd.com&gt;; Wu, Hersen &lt;hersenx=
s.wu@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira,=
 Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd/display: move FPU associated DSC cod=
e to DML folder</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Am 24.09.21 um 05:22 schrieb Qingqing Zhuo:<br>
&gt; As part of the FPU isolation work documented in<br>
&gt; <a href=3D"https://patchwork.freedesktop.org/series/93042/">https://pa=
tchwork.freedesktop.org/series/93042/</a>, isolate<br>
&gt; code that uses FPU in DSC to DML, where all FPU code<br>
&gt; should locate.<br>
&gt;<br>
&gt; This change does not refactor any fuctions but move code<br>
&gt; around.<br>
&gt;<br>
&gt; v2: remove more floating point related flags in dml/Makefile<br>
&gt;<br>
&gt; Cc: Anson Jacob &lt;Anson.Jacob@amd.com&gt;<br>
&gt; Cc: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
&gt; Cc: Hersen Wu &lt;hersenxs.wu@amd.com&gt;<br>
&gt; Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
&gt; Cc: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
&gt; Signed-off-by: Qingqing Zhuo &lt;qingqing.zhuo@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; dc/dml/dsc/rc_calc_fpu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 291 ++++++++++++++++++<br>
&gt;&nbsp;&nbsp; dc/dml/dsc/rc_calc_fpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 98 ++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dml/Makefile&nbsp;&nbsp; |&=
nbsp;&nbsp; 3 +<br>
&gt;&nbsp;&nbsp; .../amd/display/dc/{ =3D&gt; dml}/dsc/qp_tables.h&nbsp; |&=
nbsp;&nbsp; 0<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c&nbsp; | 287 +=
++++++++++++++++<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h&nbsp; |&nbsp;=
 89 ++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dsc/Makefile&nbsp;&nbsp; |&=
nbsp; 29 --<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c&nbsp; | 257 -=
---------------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h&nbsp; |&nbsp;=
 50 +--<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c&nbsp; |&nbsp;=
&nbsp; 1 -<br>
&gt;&nbsp;&nbsp; 10 files changed, 769 insertions(+), 336 deletions(-)<br>
&gt;&nbsp;&nbsp; create mode 100644 dc/dml/dsc/rc_calc_fpu.c<br>
&gt;&nbsp;&nbsp; create mode 100644 dc/dml/dsc/rc_calc_fpu.h<br>
&gt;&nbsp;&nbsp; rename drivers/gpu/drm/amd/display/dc/{ =3D&gt; dml}/dsc/q=
p_tables.h (100%)<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/=
rc_calc_fpu.c<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/=
rc_calc_fpu.h<br>
<br>
That looks like the diff is somehow a bit messed up.<br>
<br>
Why do you have both dc/dml/dsc/rc_calc_fpu.c and <br>
drm/amd/display/dc/dml/dsc/rc_calc_fpu.c ?<br>
<br>
Regards,<br>
Christian.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">--<br>
</div>
<div class=3D"PlainText">Hi Christian,</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Thanks for catching that! It seems that my repo go=
t messed up. I will fix up and send out v3.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Thank you,</div>
<div class=3D"PlainText">Lillian<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&gt;<br>
&gt; diff --git a/dc/dml/dsc/rc_calc_fpu.c b/dc/dml/dsc/rc_calc_fpu.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..e9b40cbefd6d<br>
&gt; --- /dev/null<br>
&gt; +++ b/dc/dml/dsc/rc_calc_fpu.c<br>
&gt; @@ -0,0 +1,291 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2021 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;rc_calc_fpu.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;qp_tables.h&quot;<br>
&gt; +#include &quot;amdgpu_dm/dc_fpu.h&quot;<br>
&gt; +<br>
&gt; +#define table_hash(mode, bpc, max_min) ((mode &lt;&lt; 16) | (bpc &lt=
;&lt; 8) | max_min)<br>
&gt; +<br>
&gt; +#define MODE_SELECT(val444, val422, val420) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; (cm =3D=3D CM_444 || cm =3D=3D CM_RGB) ? (va=
l444) : (cm =3D=3D CM_422 ? (val422) : (val420))<br>
&gt; +<br>
&gt; +<br>
&gt; +#define TABLE_CASE(mode, bpc, max)&nbsp;&nbsp; case (table_hash(mode,=
 BPC_##bpc, max)): \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; table =3D qp_table_##mode##_##bpc##bpc_##max=
; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; table_size =3D sizeof(qp_table_##mode##_##bp=
c##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; break<br>
&gt; +<br>
&gt; +static int median3(int a, int b, int c)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (a &gt; b)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(a, b);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (b &gt; c)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(b, c);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (a &gt; b)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(b, c);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return b;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static double dsc_roundf(double num)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (num &lt; 0.0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num =3D num - 0.5;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num =3D num + 0.5;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (int)(num);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static double dsc_ceil(double num)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; double retval =3D (int)num;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D num &amp;&amp; num &gt; 0)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D num + 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (int)retval;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per=
_comp bpc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum max_min max_min, float b=
pp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int mode =3D MODE_SELECT(444, 422, 420);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int sel =3D table_hash(mode, bpc, max_min);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int table_size =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int index;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct qp_entry *table =3D 0L;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // alias enum<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum { min =3D DAL_MM_MIN, max =3D DAL_MM_MA=
X };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (sel) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444,&nbsp; 8, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444,&nbsp; 8, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 10, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 10, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 12, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 12, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422,&nbsp; 8, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422,&nbsp; 8, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 10, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 10, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 12, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 12, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420,&nbsp; 8, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420,&nbsp; 8, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 10, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 10, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 12, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 12, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (table =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; index =3D (bpp - table[0].bpp) * 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* requested size is bigger than the table *=
/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D table_size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_error(&quot;ERROR: Requested rc_calc to find a bpp entry that exceed=
s the table size\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(qps, table[index].qps, sizeof(qp_set)=
);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp; *p =3D ofs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mode =3D=3D CM_444 || mode =3D=3D CM_RGB=
) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((((bpp &gt;=3D&nbsp; 8) &amp;&a=
mp; (bpp &lt;=3D 12))) ? (2) : ((bpp &gt;=3D 15) ? (10) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (0 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) : =
(2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (0) : ((bpp &gt;=3D 15) ? (8) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (-2 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) :=
 (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (0) : ((bpp &gt;=3D 15) ? (6) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (-2 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) :=
 (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-4) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (-2) : ((bpp &gt;=3D 15) ? (4) : ((((bpp &gt; 6) =
&amp;&amp; (bpp &lt; 8))) ? (-4 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) =
: (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-6) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (-4) : ((bpp &gt;=3D 15) ? (2) : ((((bpp &gt; 6) =
&amp;&amp; (bpp &lt; 8))) ? (-6 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) =
: (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-6) : ((bpp &gt;=3D 15) ? (0) : (-6 + dsc_=
roundf((bpp - 12) * (6 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-2) : (-8 + dsc=
_roundf((bpp - 12) * (6 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-4) : (-8 + dsc=
_roundf((bpp - 12) * (4 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-6) : (-8 + dsc=
_roundf((bpp - 12) * (2 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-10) : ((bpp &gt;=3D 15) ? (-8) : (-10 + d=
sc_roundf((bpp - 12) * (2 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-12) : ((bpp &gt;=3D&nbsp; 8) ? (-10)=
 : (-12 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (mode =3D=3D CM_422) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (2) : ((bpp &gt;=3D 10) ? (10) : (2 + =
dsc_roundf((bpp -&nbsp; 8) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (0) : ((bpp &gt;=3D 10) ? (8) : (0 + d=
sc_roundf((bpp -&nbsp; 8) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (0) : ((bpp &gt;=3D 10) ? (6) : (0 + d=
sc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-2) : ((bpp &gt;=3D 10) ? (4) : (-2 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-4) : ((bpp &gt;=3D 10) ? (2) : (-4 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-6) : ((bpp &gt;=3D 10) ? (0) : (-6 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-2) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-4) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (4 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-6) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-10) : ((bpp &gt;=3D 10) ? (-8) : (-1=
0 + dsc_roundf((bpp -&nbsp; 8) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-12) : ((bpp &gt;=3D 7) ? (-10) : (-1=
2 + dsc_roundf((bpp -&nbsp; 6) * (2.0 / 1))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (2) : ((bpp &gt;=3D&nbsp; 8) ? (10) : =
(2 + dsc_roundf((bpp -&nbsp; 6) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((bpp &gt;=3D&nbsp; 8) ? (8) : (=
0 + dsc_roundf((bpp -&nbsp; 6) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((bpp &gt;=3D&nbsp; 8) ? (6) : (=
0 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((bpp &gt;=3D&nbsp; 8) ? (4) : =
(-2 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-4) : ((bpp &gt;=3D&nbsp; 8) ? (2) : =
(-4 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-6) : ((bpp &gt;=3D&nbsp; 8) ? (0) : =
(-6 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-2) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-4) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (4 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-6) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-10) : ((bpp &gt;=3D&nbsp; 8) ? (-8) =
: (-10 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 4) ? (-12) : ((bpp &gt;=3D&nbsp; 5) ? (-10)=
 : (-12 + dsc_roundf((bpp -&nbsp; 4) * (2 / 1.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +void _do_calc_rc_params(struct rc_params *rc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum colour_mode cm,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum bits_per_comp bpc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool is_navite_422_or_420,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int slice_width,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int slice_height,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int minor_version)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float bpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float bpp_group;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float initial_xmit_delay_factor;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int padding_pixels;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bpp =3D ((float)drm_bpp / 16.0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in native_422 or native_420 modes, the bi=
ts_per_pixel is double the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * target bpp (the latter is what calc_=
rc_params expects)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (is_navite_422_or_420)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bpp /=3D 2.0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_quant_incr_limit0 =3D ((bpc =3D=3D=
 BPC_8) ? 11 : (bpc =3D=3D BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 &a=
mp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_quant_incr_limit1 =3D ((bpc =3D=3D=
 BPC_8) ? 11 : (bpc =3D=3D BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 &a=
mp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bpp_group =3D MODE_SELECT(bpp, bpp * 2.0, bp=
p * 2.0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (cm) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_420:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D&nbsp; 6) ? (2048) : ((b=
pp &lt;=3D&nbsp; 4) ? (6144) : ((((bpp &gt;&nbsp; 4) &amp;&amp; (bpp &lt;=
=3D&nbsp; 5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_round=
f((bpp -&nbsp; 5) * (3584)))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_grou=
p)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D median3(0, 12, (int)((3 * bpc *=
 3) - (3 * bpp_group)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_422:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D&nbsp; 8) ? (2048) : ((b=
pp &lt;=3D&nbsp; 7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_grou=
p)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_444:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_RGB:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D 12) ? (2048) : ((bpp &l=
t;=3D&nbsp; 8) ? (6144) : ((((bpp &gt;&nbsp; 8) &amp;&amp; (bpp &lt;=3D 10)=
)) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp -=
 10) * (3584 / 2)))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)(((3 * bpc + (cm =3D=3D CM_444=
 ? 0 : 2)) * 3) - (3 * bpp_group)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; initial_xmit_delay_factor =3D (cm =3D=3D CM_=
444 || cm =3D=3D CM_RGB) ? 1.0 : 2.0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;initial_xmit_delay =3D dsc_roundf(819=
2.0/2.0/bpp/initial_xmit_delay_factor);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (cm =3D=3D CM_422 || cm =3D=3D CM_420)<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; slice_width /=3D 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; padding_pixels =3D ((slice_width % 3) !=3D 0=
) ? (3 - (slice_width % 3)) * (rc-&gt;initial_xmit_delay / slice_width) : 0=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (3 * bpp_group &gt;=3D (((rc-&gt;initial_=
xmit_delay + 2) / 3) * (3 + (cm =3D=3D CM_422)))) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((rc-&gt;initial_xmit_delay + padding_pixels) % 3 =3D=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;initial_xmit_del=
ay++;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_min_qp&nbsp;&nbsp;&nbsp;&nbs=
p; =3D ((bpc =3D=3D BPC_8) ?&nbsp; (3) : ((bpc =3D=3D BPC_10) ? (7)&nbsp; :=
 (11))) - ((minor_version =3D=3D 1 &amp;&amp; cm =3D=3D CM_444) ? 1 : 0);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_max_qp&nbsp;&nbsp;&nbsp;&nbs=
p; =3D ((bpc =3D=3D BPC_8) ? (12) : ((bpc =3D=3D BPC_10) ? (16) : (20))) - =
((minor_version =3D=3D 1 &amp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_det_thresh =3D 2 &lt;&lt; (b=
pc - 8);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_qp_set(rc-&gt;qp_min, cm, bpc, DAL_MM_MI=
N, bpp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_qp_set(rc-&gt;qp_max, cm, bpc, DAL_MM_MA=
X, bpp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (cm =3D=3D CM_444 &amp;&amp; minor_versio=
n =3D=3D 1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; QP_SET_SIZE; ++i) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;qp_min[i] =3D rc=
-&gt;qp_min[i] &gt; 0 ? rc-&gt;qp_min[i] - 1 : 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;qp_max[i] =3D rc=
-&gt;qp_max[i] &gt; 0 ? rc-&gt;qp_max[i] - 1 : 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_ofs_set(rc-&gt;ofs, cm, bpp);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* fixed parameters */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_model_size&nbsp;&nbsp;&nbsp; =3D 8=
192;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_edge_factor&nbsp;&nbsp; =3D 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_tgt_offset_hi =3D 3;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_tgt_offset_lo =3D 3;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[0] =3D 896;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[1] =3D 1792;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[2] =3D 2688;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[3] =3D 3584;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[4] =3D 4480;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[5] =3D 5376;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[6] =3D 6272;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[7] =3D 6720;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[8] =3D 7168;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[9] =3D 7616;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[10] =3D 7744;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[11] =3D 7872;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[12] =3D 8000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[13] =3D 8064;<br>
&gt; +}<br>
&gt; +<br>
&gt; +u32 _do_bytes_per_pixel_calc(int slice_width,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool is_navite_422_or_420)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float bpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes_per_pixel;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; double d_bytes_per_pixel;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bpp =3D ((float)drm_bpp / 16.0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; d_bytes_per_pixel =3D dsc_ceil(bpp * slice_w=
idth / 8.0) / slice_width;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // TODO: Make sure the formula for calculati=
ng this is precise (ceiling<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // vs. floor, and at what point they should =
be applied)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (is_navite_422_or_420)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; d_bytes_per_pixel /=3D 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bytes_per_pixel =3D (u32)dsc_ceil(d_bytes_pe=
r_pixel * 0x10000000);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return bytes_per_pixel;<br>
&gt; +}<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/dc/dml/dsc/rc_calc_fpu.h b/dc/dml/dsc/rc_calc_fpu.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..8f2cd1364b13<br>
&gt; --- /dev/null<br>
&gt; +++ b/dc/dml/dsc/rc_calc_fpu.h<br>
&gt; @@ -0,0 +1,98 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2021 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __RC_CALC_FPU_H__<br>
&gt; +#define __RC_CALC_FPU_H__<br>
&gt; +<br>
&gt; +#include &quot;os_types.h&quot;<br>
&gt; +#ifdef LINUX_DM<br>
&gt; +#include &lt;drm/drm_dsc.h&gt;<br>
&gt; +#else<br>
&gt; +#include &lt;include/drm_dsc_dc.h&gt;<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +#define QP_SET_SIZE 15<br>
&gt; +<br>
&gt; +typedef int qp_set[QP_SET_SIZE];<br>
&gt; +<br>
&gt; +struct rc_params {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_quant_i=
ncr_limit0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_quant_i=
ncr_limit1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initial_fu=
llness_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initial_xm=
it_delay;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first_line=
_bpg_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; second_lin=
e_bpg_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_m=
in_qp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_m=
ax_qp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_d=
et_thresh;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; qp_min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; qp_max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; ofs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_model_s=
ize;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_edge_fa=
ctor;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_tgt_off=
set_hi;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_tgt_off=
set_lo;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_buf_thr=
esh[QP_SET_SIZE - 1];<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum colour_mode {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_RGB,&nbsp;&nbsp; /* 444 RGB */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_444,&nbsp;&nbsp; /* 444 YUV or simple 422=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_422,&nbsp;&nbsp; /* native 422 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_420&nbsp;&nbsp;&nbsp; /* native 420 */<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +enum bits_per_comp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BPC_8&nbsp; =3D&nbsp; 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BPC_10 =3D 10,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BPC_12 =3D 12<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum max_min {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; DAL_MM_MIN =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; DAL_MM_MAX =3D 1<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct qp_entry {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; bpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const qp_set&nbsp; qps;<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct qp_entry qp_table[];<br>
&gt; +<br>
&gt; +u32 _do_bytes_per_pixel_calc(int slice_width,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool is_navite_422_or_420);<br>
&gt; +<br>
&gt; +void _do_calc_rc_params(struct rc_params *rc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum colour_mode cm,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; enum bits_per_comp bpc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool is_navite_422_or_420,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int slice_width,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int slice_height,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; int minor_version);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu=
/drm/amd/display/dc/dml/Makefile<br>
&gt; index 56055df2e8d2..9009b92490f3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile<br>
&gt; @@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_3=
0.o :=3D $(dml_ccflags) $(fram<br>
&gt;&nbsp;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o=
 :=3D $(dml_ccflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o :=
=3D $(dml_ccflags) $(frame_warn_flag)<br>
&gt;&nbsp;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o=
 :=3D $(dml_ccflags)<br>
&gt; +CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o :=3D $(dml_ccflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D $(dml_=
ccflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D=
 $(dml_rcflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o :=3D $(dm=
l_rcflags)<br>
&gt; @@ -84,6 +85,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_=
dlg_calc_30.o :=3D $(dml_rcfla<br>
&gt;&nbsp;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_=
31.o :=3D $(dml_rcflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_ca=
lc_31.o :=3D $(dml_rcflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o :=3D=
 $(dml_rcflags)<br>
&gt; +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o&nbsp; :=3D $(dml=
_rcflags)<br>
&gt;&nbsp;&nbsp; endif<br>
&gt;&nbsp;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o :=
=3D $(dml_ccflags)<br>
&gt;&nbsp;&nbsp; CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o :=3D =
$(dml_ccflags)<br>
&gt; @@ -99,6 +101,7 @@ DML +=3D dcn20/display_rq_dlg_calc_20v2.o dcn20/dis=
play_mode_vba_20v2.o<br>
&gt;&nbsp;&nbsp; DML +=3D dcn21/display_rq_dlg_calc_21.o dcn21/display_mode=
_vba_21.o<br>
&gt;&nbsp;&nbsp; DML +=3D dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_=
calc_30.o<br>
&gt;&nbsp;&nbsp; DML +=3D dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_=
calc_31.o<br>
&gt; +DML +=3D dsc/rc_calc_fpu.o<br>
&gt;&nbsp;&nbsp; endif<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; AMD_DAL_DML =3D $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h b/drivers/=
gpu/drm/amd/display/dc/dml/dsc/qp_tables.h<br>
&gt; similarity index 100%<br>
&gt; rename from drivers/gpu/drm/amd/display/dc/dsc/qp_tables.h<br>
&gt; rename to drivers/gpu/drm/amd/display/dc/dml/dsc/qp_tables.h<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..0436fc64948f<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c<br>
&gt; @@ -0,0 +1,287 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2021 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;rc_calc_fpu.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;qp_tables.h&quot;<br>
&gt; +#include &quot;amdgpu_dm/dc_fpu.h&quot;<br>
&gt; +<br>
&gt; +#define table_hash(mode, bpc, max_min) ((mode &lt;&lt; 16) | (bpc &lt=
;&lt; 8) | max_min)<br>
&gt; +<br>
&gt; +#define MODE_SELECT(val444, val422, val420) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; (cm =3D=3D CM_444 || cm =3D=3D CM_RGB) ? (va=
l444) : (cm =3D=3D CM_422 ? (val422) : (val420))<br>
&gt; +<br>
&gt; +<br>
&gt; +#define TABLE_CASE(mode, bpc, max)&nbsp;&nbsp; case (table_hash(mode,=
 BPC_##bpc, max)): \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; table =3D qp_table_##mode##_##bpc##bpc_##max=
; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; table_size =3D sizeof(qp_table_##mode##_##bp=
c##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; break<br>
&gt; +<br>
&gt; +static int median3(int a, int b, int c)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (a &gt; b)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(a, b);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (b &gt; c)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(b, c);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (a &gt; b)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(b, c);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return b;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static double dsc_roundf(double num)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (num &lt; 0.0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num =3D num - 0.5;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num =3D num + 0.5;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (int)(num);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static double dsc_ceil(double num)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; double retval =3D (int)num;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D num &amp;&amp; num &gt; 0)<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D num + 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return (int)retval;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per=
_comp bpc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum max_min max_min, float b=
pp)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int mode =3D MODE_SELECT(444, 422, 420);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int sel =3D table_hash(mode, bpc, max_min);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int table_size =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int index;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const struct qp_entry *table =3D 0L;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // alias enum<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; enum { min =3D DAL_MM_MIN, max =3D DAL_MM_MA=
X };<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (sel) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444,&nbsp; 8, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444,&nbsp; 8, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 10, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 10, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 12, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 12, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422,&nbsp; 8, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422,&nbsp; 8, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 10, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 10, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 12, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 12, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420,&nbsp; 8, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420,&nbsp; 8, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 10, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 10, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 12, max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 12, min);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (table =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; index =3D (bpp - table[0].bpp) * 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* requested size is bigger than the table *=
/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D table_size) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_error(&quot;ERROR: Requested rc_calc to find a bpp entry that exceed=
s the table size\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; memcpy(qps, table[index].qps, sizeof(qp_set)=
);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp; *p =3D ofs;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (mode =3D=3D CM_444 || mode =3D=3D CM_RGB=
) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((((bpp &gt;=3D&nbsp; 8) &amp;&a=
mp; (bpp &lt;=3D 12))) ? (2) : ((bpp &gt;=3D 15) ? (10) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (0 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) : =
(2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (0) : ((bpp &gt;=3D 15) ? (8) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (-2 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) :=
 (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (0) : ((bpp &gt;=3D 15) ? (6) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (-2 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) :=
 (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-4) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (-2) : ((bpp &gt;=3D 15) ? (4) : ((((bpp &gt; 6) =
&amp;&amp; (bpp &lt; 8))) ? (-4 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) =
: (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-6) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (-4) : ((bpp &gt;=3D 15) ? (2) : ((((bpp &gt; 6) =
&amp;&amp; (bpp &lt; 8))) ? (-6 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) =
: (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-6) : ((bpp &gt;=3D 15) ? (0) : (-6 + dsc_=
roundf((bpp - 12) * (6 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-2) : (-8 + dsc=
_roundf((bpp - 12) * (6 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-4) : (-8 + dsc=
_roundf((bpp - 12) * (4 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-6) : (-8 + dsc=
_roundf((bpp - 12) * (2 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-10) : ((bpp &gt;=3D 15) ? (-8) : (-10 + d=
sc_roundf((bpp - 12) * (2 / 3.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-12) : ((bpp &gt;=3D&nbsp; 8) ? (-10)=
 : (-12 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else if (mode =3D=3D CM_422) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (2) : ((bpp &gt;=3D 10) ? (10) : (2 + =
dsc_roundf((bpp -&nbsp; 8) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (0) : ((bpp &gt;=3D 10) ? (8) : (0 + d=
sc_roundf((bpp -&nbsp; 8) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (0) : ((bpp &gt;=3D 10) ? (6) : (0 + d=
sc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-2) : ((bpp &gt;=3D 10) ? (4) : (-2 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-4) : ((bpp &gt;=3D 10) ? (2) : (-4 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-6) : ((bpp &gt;=3D 10) ? (0) : (-6 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-2) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-4) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (4 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-6) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-10) : ((bpp &gt;=3D 10) ? (-8) : (-1=
0 + dsc_roundf((bpp -&nbsp; 8) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-12) : ((bpp &gt;=3D 7) ? (-10) : (-1=
2 + dsc_roundf((bpp -&nbsp; 6) * (2.0 / 1))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (2) : ((bpp &gt;=3D&nbsp; 8) ? (10) : =
(2 + dsc_roundf((bpp -&nbsp; 6) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((bpp &gt;=3D&nbsp; 8) ? (8) : (=
0 + dsc_roundf((bpp -&nbsp; 6) * (8 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((bpp &gt;=3D&nbsp; 8) ? (6) : (=
0 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((bpp &gt;=3D&nbsp; 8) ? (4) : =
(-2 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-4) : ((bpp &gt;=3D&nbsp; 8) ? (2) : =
(-4 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-6) : ((bpp &gt;=3D&nbsp; 8) ? (0) : =
(-6 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-2) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-4) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (4 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-6) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-10) : ((bpp &gt;=3D&nbsp; 8) ? (-8) =
: (-10 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 4) ? (-12) : ((bpp &gt;=3D&nbsp; 5) ? (-10)=
 : (-12 + dsc_roundf((bpp -&nbsp; 4) * (2 / 1.0))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; enum bits_per_comp bpc, u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; bool is_navite_422_or_420,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int slice_width, int slice_height,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int minor_version)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float bpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float bpp_group;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float initial_xmit_delay_factor;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int padding_pixels;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bpp =3D ((float)drm_bpp / 16.0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* in native_422 or native_420 modes, the bi=
ts_per_pixel is double the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * target bpp (the latter is what calc_=
rc_params expects)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (is_navite_422_or_420)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bpp /=3D 2.0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_quant_incr_limit0 =3D ((bpc =3D=3D=
 BPC_8) ? 11 : (bpc =3D=3D BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 &a=
mp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_quant_incr_limit1 =3D ((bpc =3D=3D=
 BPC_8) ? 11 : (bpc =3D=3D BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 &a=
mp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bpp_group =3D MODE_SELECT(bpp, bpp * 2.0, bp=
p * 2.0);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; switch (cm) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_420:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D&nbsp; 6) ? (2048) : ((b=
pp &lt;=3D&nbsp; 4) ? (6144) : ((((bpp &gt;&nbsp; 4) &amp;&amp; (bpp &lt;=
=3D&nbsp; 5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_round=
f((bpp -&nbsp; 5) * (3584)))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_grou=
p)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D median3(0, 12, (int)((3 * bpc *=
 3) - (3 * bpp_group)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_422:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D&nbsp; 8) ? (2048) : ((b=
pp &lt;=3D&nbsp; 7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_grou=
p)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_444:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; case CM_RGB:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D 12) ? (2048) : ((bpp &l=
t;=3D&nbsp; 8) ? (6144) : ((((bpp &gt;&nbsp; 8) &amp;&amp; (bpp &lt;=3D 10)=
)) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp -=
 10) * (3584 / 2)))));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)(((3 * bpc + (cm =3D=3D CM_444=
 ? 0 : 2)) * 3) - (3 * bpp_group)));<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; initial_xmit_delay_factor =3D (cm =3D=3D CM_=
444 || cm =3D=3D CM_RGB) ? 1.0 : 2.0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;initial_xmit_delay =3D dsc_roundf(819=
2.0/2.0/bpp/initial_xmit_delay_factor);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (cm =3D=3D CM_422 || cm =3D=3D CM_420)<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; slice_width /=3D 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; padding_pixels =3D ((slice_width % 3) !=3D 0=
) ? (3 - (slice_width % 3)) * (rc-&gt;initial_xmit_delay / slice_width) : 0=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (3 * bpp_group &gt;=3D (((rc-&gt;initial_=
xmit_delay + 2) / 3) * (3 + (cm =3D=3D CM_422)))) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((rc-&gt;initial_xmit_delay + padding_pixels) % 3 =3D=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;initial_xmit_del=
ay++;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_min_qp&nbsp;&nbsp;&nbsp;&nbs=
p; =3D ((bpc =3D=3D BPC_8) ?&nbsp; (3) : ((bpc =3D=3D BPC_10) ? (7)&nbsp; :=
 (11))) - ((minor_version =3D=3D 1 &amp;&amp; cm =3D=3D CM_444) ? 1 : 0);<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_max_qp&nbsp;&nbsp;&nbsp;&nbs=
p; =3D ((bpc =3D=3D BPC_8) ? (12) : ((bpc =3D=3D BPC_10) ? (16) : (20))) - =
((minor_version =3D=3D 1 &amp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_det_thresh =3D 2 &lt;&lt; (b=
pc - 8);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_qp_set(rc-&gt;qp_min, cm, bpc, DAL_MM_MI=
N, bpp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_qp_set(rc-&gt;qp_max, cm, bpc, DAL_MM_MA=
X, bpp);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (cm =3D=3D CM_444 &amp;&amp; minor_versio=
n =3D=3D 1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; QP_SET_SIZE; ++i) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;qp_min[i] =3D rc=
-&gt;qp_min[i] &gt; 0 ? rc-&gt;qp_min[i] - 1 : 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;qp_max[i] =3D rc=
-&gt;qp_max[i] &gt; 0 ? rc-&gt;qp_max[i] - 1 : 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; get_ofs_set(rc-&gt;ofs, cm, bpp);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* fixed parameters */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_model_size&nbsp;&nbsp;&nbsp; =3D 8=
192;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_edge_factor&nbsp;&nbsp; =3D 6;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_tgt_offset_hi =3D 3;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_tgt_offset_lo =3D 3;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[0] =3D 896;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[1] =3D 1792;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[2] =3D 2688;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[3] =3D 3584;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[4] =3D 4480;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[5] =3D 5376;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[6] =3D 6272;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[7] =3D 6720;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[8] =3D 7168;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[9] =3D 7616;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[10] =3D 7744;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[11] =3D 7872;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[12] =3D 8000;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[13] =3D 8064;<br>
&gt; +}<br>
&gt; +<br>
&gt; +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_navite_422_or_420)=
<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float bpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes_per_pixel;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; double d_bytes_per_pixel;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bpp =3D ((float)drm_bpp / 16.0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; d_bytes_per_pixel =3D dsc_ceil(bpp * slice_w=
idth / 8.0) / slice_width;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // TODO: Make sure the formula for calculati=
ng this is precise (ceiling<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; // vs. floor, and at what point they should =
be applied)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (is_navite_422_or_420)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; d_bytes_per_pixel /=3D 2;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; bytes_per_pixel =3D (u32)dsc_ceil(d_bytes_pe=
r_pixel * 0x10000000);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return bytes_per_pixel;<br>
&gt; +}<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h b/dr=
ivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..d3900ff7fa89<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h<br>
&gt; @@ -0,0 +1,89 @@<br>
&gt; +/*<br>
&gt; + * Copyright 2021 Advanced Micro Devices, Inc.<br>
&gt; + *<br>
&gt; + * Permission is hereby granted, free of charge, to any person obtain=
ing a<br>
&gt; + * copy of this software and associated documentation files (the &quo=
t;Software&quot;),<br>
&gt; + * to deal in the Software without restriction, including without lim=
itation<br>
&gt; + * the rights to use, copy, modify, merge, publish, distribute, subli=
cense,<br>
&gt; + * and/or sell copies of the Software, and to permit persons to whom =
the<br>
&gt; + * Software is furnished to do so, subject to the following condition=
s:<br>
&gt; + *<br>
&gt; + * The above copyright notice and this permission notice shall be inc=
luded in<br>
&gt; + * all copies or substantial portions of the Software.<br>
&gt; + *<br>
&gt; + * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF AN=
Y KIND, EXPRESS OR<br>
&gt; + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO =
EVENT SHALL<br>
&gt; + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMA=
GES OR<br>
&gt; + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWI=
SE,<br>
&gt; + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE=
 OR<br>
&gt; + * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; + *<br>
&gt; + * Authors: AMD<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef __RC_CALC_FPU_H__<br>
&gt; +#define __RC_CALC_FPU_H__<br>
&gt; +<br>
&gt; +#include &quot;os_types.h&quot;<br>
&gt; +<br>
&gt; +#define QP_SET_SIZE 15<br>
&gt; +<br>
&gt; +typedef int qp_set[QP_SET_SIZE];<br>
&gt; +<br>
&gt; +struct rc_params {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_quant_i=
ncr_limit0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_quant_i=
ncr_limit1;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initial_fu=
llness_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initial_xm=
it_delay;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first_line=
_bpg_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; second_lin=
e_bpg_offset;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_m=
in_qp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_m=
ax_qp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_d=
et_thresh;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; qp_min;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; qp_max;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; ofs;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_model_s=
ize;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_edge_fa=
ctor;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_tgt_off=
set_hi;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_tgt_off=
set_lo;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_buf_thr=
esh[QP_SET_SIZE - 1];<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum colour_mode {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_RGB,&nbsp;&nbsp; /* 444 RGB */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_444,&nbsp;&nbsp; /* 444 YUV or simple 422=
 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_422,&nbsp;&nbsp; /* native 422 */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; CM_420&nbsp;&nbsp;&nbsp; /* native 420 */<br=
>
&gt; +};<br>
&gt; +<br>
&gt; +enum bits_per_comp {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BPC_8&nbsp; =3D&nbsp; 8,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BPC_10 =3D 10,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; BPC_12 =3D 12<br>
&gt; +};<br>
&gt; +<br>
&gt; +enum max_min {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; DAL_MM_MIN =3D 0,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; DAL_MM_MAX =3D 1<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct qp_entry {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; float&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; bpp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const qp_set&nbsp; qps;<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct qp_entry qp_table[];<br>
&gt; +<br>
&gt; +u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_navite_422_or_420)=
;<br>
&gt; +<br>
&gt; +void _do_calc_rc_params(struct rc_params *rc, enum colour_mode cm,<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; enum bits_per_comp bpc, u16 drm_bpp,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; bool is_navite_422_or_420,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int slice_width, int slice_height,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int minor_version);<br>
&gt; +<br>
&gt; +#endif<br>
&gt; \ No newline at end of file<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu=
/drm/amd/display/dc/dsc/Makefile<br>
&gt; index 8d31eb75c6a6..a2537229ee88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile<br>
&gt; @@ -1,35 +1,6 @@<br>
&gt;&nbsp;&nbsp; # SPDX-License-Identifier: MIT<br>
&gt;&nbsp;&nbsp; #<br>
&gt;&nbsp;&nbsp; # Makefile for the 'dsc' sub-component of DAL.<br>
&gt; -<br>
&gt; -ifdef CONFIG_X86<br>
&gt; -dsc_ccflags :=3D -mhard-float -msse<br>
&gt; -endif<br>
&gt; -<br>
&gt; -ifdef CONFIG_PPC64<br>
&gt; -dsc_ccflags :=3D -mhard-float -maltivec<br>
&gt; -endif<br>
&gt; -<br>
&gt; -ifdef CONFIG_CC_IS_GCC<br>
&gt; -ifeq ($(call cc-ifversion, -lt, 0701, y), y)<br>
&gt; -IS_OLD_GCC =3D 1<br>
&gt; -endif<br>
&gt; -endif<br>
&gt; -<br>
&gt; -ifdef CONFIG_X86<br>
&gt; -ifdef IS_OLD_GCC<br>
&gt; -# Stack alignment mismatch, proceed with caution.<br>
&gt; -# GCC &lt; 7.1 cannot compile code using `double` and -mpreferred-sta=
ck-boundary=3D3<br>
&gt; -# (8B stack alignment).<br>
&gt; -dsc_ccflags +=3D -mpreferred-stack-boundary=3D4<br>
&gt; -else<br>
&gt; -dsc_ccflags +=3D -msse2<br>
&gt; -endif<br>
&gt; -endif<br>
&gt; -<br>
&gt; -CFLAGS_$(AMDDALPATH)/dc/dsc/rc_calc.o :=3D $(dsc_ccflags)<br>
&gt; -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dsc/rc_calc.o :=3D $(dsc_rcflags)<br>
&gt; -<br>
&gt;&nbsp;&nbsp; DSC =3D dc_dsc.o rc_calc.o rc_calc_dpi.o<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; AMD_DAL_DSC =3D $(addprefix $(AMDDALPATH)/dc/dsc/,$(DSC))<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c b/drivers/gp=
u/drm/amd/display/dc/dsc/rc_calc.c<br>
&gt; index 7b294f637881..87acec33b8d8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c<br>
&gt; @@ -25,264 +25,7 @@<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; #include &lt;drm/drm_dsc.h&gt;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#include &quot;os_types.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;rc_calc.h&quot;<br>
&gt; -#include &quot;qp_tables.h&quot;<br>
&gt; -<br>
&gt; -#define table_hash(mode, bpc, max_min) ((mode &lt;&lt; 16) | (bpc &lt=
;&lt; 8) | max_min)<br>
&gt; -<br>
&gt; -#define MODE_SELECT(val444, val422, val420) \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; (cm =3D=3D CM_444 || cm =3D=3D CM_RGB) ? (va=
l444) : (cm =3D=3D CM_422 ? (val422) : (val420))<br>
&gt; -<br>
&gt; -<br>
&gt; -#define TABLE_CASE(mode, bpc, max)&nbsp;&nbsp; case (table_hash(mode,=
 BPC_##bpc, max)): \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; table =3D qp_table_##mode##_##bpc##bpc_##max=
; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; table_size =3D sizeof(qp_table_##mode##_##bp=
c##bpc_##max)/sizeof(*qp_table_##mode##_##bpc##bpc_##max); \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; break<br>
&gt; -<br>
&gt; -<br>
&gt; -static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per=
_comp bpc,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum max_min max_min, float b=
pp)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int mode =3D MODE_SELECT(444, 422, 420);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int sel =3D table_hash(mode, bpc, max_min);<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int table_size =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int index;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const struct qp_entry *table =3D 0L;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; // alias enum<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; enum { min =3D DAL_MM_MIN, max =3D DAL_MM_MA=
X };<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (sel) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444,&nbsp; 8, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444,&nbsp; 8, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 10, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 10, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 12, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(444, 12, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422,&nbsp; 8, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422,&nbsp; 8, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 10, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 10, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 12, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(422, 12, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420,&nbsp; 8, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420,&nbsp; 8, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 10, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 10, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 12, max);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; TABLE_CASE(420, 12, min);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (table =3D=3D 0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; index =3D (bpp - table[0].bpp) * 2;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* requested size is bigger than the table *=
/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (index &gt;=3D table_size) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_error(&quot;ERROR: Requested rc_calc to find a bpp entry that exceed=
s the table size\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; memcpy(qps, table[index].qps, sizeof(qp_set)=
);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static double dsc_roundf(double num)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (num &lt; 0.0)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num =3D num - 0.5;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num =3D num + 0.5;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (int)(num);<br>
&gt; -}<br>
&gt; -<br>
&gt; -static double dsc_ceil(double num)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; double retval =3D (int)num;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (retval !=3D num &amp;&amp; num &gt; 0)<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; retval =3D num + 1;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return (int)retval;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void get_ofs_set(qp_set ofs, enum colour_mode mode, float bpp)=
<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp; *p =3D ofs;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (mode =3D=3D CM_444 || mode =3D=3D CM_RGB=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((((bpp &gt;=3D&nbsp; 8) &amp;&a=
mp; (bpp &lt;=3D 12))) ? (2) : ((bpp &gt;=3D 15) ? (10) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (0 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) : =
(2 + dsc_roundf((bpp - 12) * (8 / 3.0))))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (0) : ((bpp &gt;=3D 15) ? (8) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (-2 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) :=
 (0 + dsc_roundf((bpp - 12) * (8 / 3.0))))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (0) : ((bpp &gt;=3D 15) ? (6) : ((((bpp &gt; 6) &=
amp;&amp; (bpp &lt; 8))) ? (-2 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) :=
 (0 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-4) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (-2) : ((bpp &gt;=3D 15) ? (4) : ((((bpp &gt; 6) =
&amp;&amp; (bpp &lt; 8))) ? (-4 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) =
: (-2 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-6) : ((((bpp &gt;=3D&nbsp; 8) &amp;&=
amp; (bpp &lt;=3D 12))) ? (-4) : ((bpp &gt;=3D 15) ? (2) : ((((bpp &gt; 6) =
&amp;&amp; (bpp &lt; 8))) ? (-6 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))) =
: (-4 + dsc_roundf((bpp - 12) * (6 / 3.0))))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-6) : ((bpp &gt;=3D 15) ? (0) : (-6 + dsc_=
roundf((bpp - 12) * (6 / 3.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-2) : (-8 + dsc=
_roundf((bpp - 12) * (6 / 3.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-4) : (-8 + dsc=
_roundf((bpp - 12) * (4 / 3.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-8) : ((bpp &gt;=3D 15) ? (-6) : (-8 + dsc=
_roundf((bpp - 12) * (2 / 3.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D 12) ? (-10) : ((bpp &gt;=3D 15) ? (-8) : (-10 + d=
sc_roundf((bpp - 12) * (2 / 3.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-12) : ((bpp &gt;=3D&nbsp; 8) ? (-10)=
 : (-12 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else if (mode =3D=3D CM_422) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (2) : ((bpp &gt;=3D 10) ? (10) : (2 + =
dsc_roundf((bpp -&nbsp; 8) * (8 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (0) : ((bpp &gt;=3D 10) ? (8) : (0 + d=
sc_roundf((bpp -&nbsp; 8) * (8 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (0) : ((bpp &gt;=3D 10) ? (6) : (0 + d=
sc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-2) : ((bpp &gt;=3D 10) ? (4) : (-2 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-4) : ((bpp &gt;=3D 10) ? (2) : (-4 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-6) : ((bpp &gt;=3D 10) ? (0) : (-6 +=
 dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-2) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-4) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (4 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-8) : ((bpp &gt;=3D 10) ? (-6) : (-8 =
+ dsc_roundf((bpp -&nbsp; 8) * (2 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 8) ? (-10) : ((bpp &gt;=3D 10) ? (-8) : (-1=
0 + dsc_roundf((bpp -&nbsp; 8) * (2 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-12) : ((bpp &gt;=3D 7) ? (-10) : (-1=
2 + dsc_roundf((bpp -&nbsp; 6) * (2.0 / 1))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (2) : ((bpp &gt;=3D&nbsp; 8) ? (10) : =
(2 + dsc_roundf((bpp -&nbsp; 6) * (8 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((bpp &gt;=3D&nbsp; 8) ? (8) : (=
0 + dsc_roundf((bpp -&nbsp; 6) * (8 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (0) : ((bpp &gt;=3D&nbsp; 8) ? (6) : (=
0 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-2) : ((bpp &gt;=3D&nbsp; 8) ? (4) : =
(-2 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-4) : ((bpp &gt;=3D&nbsp; 8) ? (2) : =
(-4 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-6) : ((bpp &gt;=3D&nbsp; 8) ? (0) : =
(-6 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-2) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (6 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-4) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (4 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-8) : ((bpp &gt;=3D&nbsp; 8) ? (-6) :=
 (-8 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 6) ? (-10) : ((bpp &gt;=3D&nbsp; 8) ? (-8) =
: (-10 + dsc_roundf((bpp -&nbsp; 6) * (2 / 2.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -10;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D (bpp &lt;=3D&nbsp; 4) ? (-12) : ((bpp &gt;=3D&nbsp; 5) ? (-10)=
 : (-12 + dsc_roundf((bpp -&nbsp; 4) * (2 / 1.0))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *p++ =3D -12;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -}<br>
&gt; -<br>
&gt; -static int median3(int a, int b, int c)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (a &gt; b)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(a, b);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (b &gt; c)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(b, c);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (a &gt; b)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; swap(b, c);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return b;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static void _do_calc_rc_params(struct rc_params *rc, enum colour_mode=
 cm,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; enum bits_per_comp bpc, u16 drm_bpp,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; bool is_navite_422_or_420,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int slice_width, int slice_height,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; int minor_version)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; float bpp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; float bpp_group;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; float initial_xmit_delay_factor;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int padding_pixels;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bpp =3D ((float)drm_bpp / 16.0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* in native_422 or native_420 modes, the bi=
ts_per_pixel is double the<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * target bpp (the latter is what calc_=
rc_params expects)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_navite_422_or_420)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bpp /=3D 2.0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_quant_incr_limit0 =3D ((bpc =3D=3D=
 BPC_8) ? 11 : (bpc =3D=3D BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 &a=
mp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_quant_incr_limit1 =3D ((bpc =3D=3D=
 BPC_8) ? 11 : (bpc =3D=3D BPC_10 ? 15 : 19)) - ((minor_version =3D=3D 1 &a=
mp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bpp_group =3D MODE_SELECT(bpp, bpp * 2.0, bp=
p * 2.0);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; switch (cm) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CM_420:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D&nbsp; 6) ? (2048) : ((b=
pp &lt;=3D&nbsp; 4) ? (6144) : ((((bpp &gt;&nbsp; 4) &amp;&amp; (bpp &lt;=
=3D&nbsp; 5))) ? (6144 - dsc_roundf((bpp - 4) * (512))) : (5632 - dsc_round=
f((bpp -&nbsp; 5) * (3584)))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)((3 * bpc * 3) - (3 * bpp_grou=
p)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D median3(0, 12, (int)((3 * bpc *=
 3) - (3 * bpp_group)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CM_422:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D&nbsp; 8) ? (2048) : ((b=
pp &lt;=3D&nbsp; 7) ? (5632) : (5632 - dsc_roundf((bpp - 7) * (3584))));<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)((3 * bpc * 4) - (3 * bpp_grou=
p)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CM_444:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; case CM_RGB:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;initial_fullness_offset =3D (bpp &gt;=3D 12) ? (2048) : ((bpp &l=
t;=3D&nbsp; 8) ? (6144) : ((((bpp &gt;&nbsp; 8) &amp;&amp; (bpp &lt;=3D 10)=
)) ? (6144 - dsc_roundf((bpp - 8) * (512 / 2))) : (5632 - dsc_roundf((bpp -=
 10) * (3584 / 2)))));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;first_line_bpg_offset&nbsp;&nbsp; =3D median3(0, (12 + (int) (0.=
09 *&nbsp; min(34, slice_height - 8))), (int)(((3 * bpc + (cm =3D=3D CM_444=
 ? 0 : 2)) * 3) - (3 * bpp_group)));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; rc-&gt;second_line_bpg_offset&nbsp; =3D 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; initial_xmit_delay_factor =3D (cm =3D=3D CM_=
444 || cm =3D=3D CM_RGB) ? 1.0 : 2.0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;initial_xmit_delay =3D dsc_roundf(819=
2.0/2.0/bpp/initial_xmit_delay_factor);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (cm =3D=3D CM_422 || cm =3D=3D CM_420)<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; slice_width /=3D 2;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; padding_pixels =3D ((slice_width % 3) !=3D 0=
) ? (3 - (slice_width % 3)) * (rc-&gt;initial_xmit_delay / slice_width) : 0=
;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (3 * bpp_group &gt;=3D (((rc-&gt;initial_=
xmit_delay + 2) / 3) * (3 + (cm =3D=3D CM_422)))) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((rc-&gt;initial_xmit_delay + padding_pixels) % 3 =3D=3D 1)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;initial_xmit_del=
ay++;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_min_qp&nbsp;&nbsp;&nbsp;&nbs=
p; =3D ((bpc =3D=3D BPC_8) ?&nbsp; (3) : ((bpc =3D=3D BPC_10) ? (7)&nbsp; :=
 (11))) - ((minor_version =3D=3D 1 &amp;&amp; cm =3D=3D CM_444) ? 1 : 0);<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_max_qp&nbsp;&nbsp;&nbsp;&nbs=
p; =3D ((bpc =3D=3D BPC_8) ? (12) : ((bpc =3D=3D BPC_10) ? (16) : (20))) - =
((minor_version =3D=3D 1 &amp;&amp; cm =3D=3D CM_444) ? 1 : 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;flatness_det_thresh =3D 2 &lt;&lt; (b=
pc - 8);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; get_qp_set(rc-&gt;qp_min, cm, bpc, DAL_MM_MI=
N, bpp);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; get_qp_set(rc-&gt;qp_max, cm, bpc, DAL_MM_MA=
X, bpp);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (cm =3D=3D CM_444 &amp;&amp; minor_versio=
n =3D=3D 1) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; QP_SET_SIZE; ++i) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;qp_min[i] =3D rc=
-&gt;qp_min[i] &gt; 0 ? rc-&gt;qp_min[i] - 1 : 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;qp_max[i] =3D rc=
-&gt;qp_max[i] &gt; 0 ? rc-&gt;qp_max[i] - 1 : 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; get_ofs_set(rc-&gt;ofs, cm, bpp);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* fixed parameters */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_model_size&nbsp;&nbsp;&nbsp; =3D 8=
192;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_edge_factor&nbsp;&nbsp; =3D 6;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_tgt_offset_hi =3D 3;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_tgt_offset_lo =3D 3;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[0] =3D 896;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[1] =3D 1792;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[2] =3D 2688;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[3] =3D 3584;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[4] =3D 4480;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[5] =3D 5376;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[6] =3D 6272;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[7] =3D 6720;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[8] =3D 7168;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[9] =3D 7616;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[10] =3D 7744;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[11] =3D 7872;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[12] =3D 8000;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; rc-&gt;rc_buf_thresh[13] =3D 8064;<br>
&gt; -}<br>
&gt; -<br>
&gt; -static u32 _do_bytes_per_pixel_calc(int slice_width, u16 drm_bpp,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_navite_422_or_420)=
<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; float bpp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes_per_pixel;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; double d_bytes_per_pixel;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bpp =3D ((float)drm_bpp / 16.0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; d_bytes_per_pixel =3D dsc_ceil(bpp * slice_w=
idth / 8.0) / slice_width;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; // TODO: Make sure the formula for calculati=
ng this is precise (ceiling<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; // vs. floor, and at what point they should =
be applied)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (is_navite_422_or_420)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; d_bytes_per_pixel /=3D 2;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bytes_per_pixel =3D (u32)dsc_ceil(d_bytes_pe=
r_pixel * 0x10000000);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return bytes_per_pixel;<br>
&gt; -}<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * calc_rc_params - reads the user's cmdline mode<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h b/drivers/gp=
u/drm/amd/display/dc/dsc/rc_calc.h<br>
&gt; index 262f06afcbf9..c2340e001b57 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h<br>
&gt; @@ -27,55 +27,7 @@<br>
&gt;&nbsp;&nbsp; #ifndef __RC_CALC_H__<br>
&gt;&nbsp;&nbsp; #define __RC_CALC_H__<br>
&gt;&nbsp;&nbsp; <br>
&gt; -<br>
&gt; -#define QP_SET_SIZE 15<br>
&gt; -<br>
&gt; -typedef int qp_set[QP_SET_SIZE];<br>
&gt; -<br>
&gt; -struct rc_params {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_quant_i=
ncr_limit0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_quant_i=
ncr_limit1;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initial_fu=
llness_offset;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; initial_xm=
it_delay;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first_line=
_bpg_offset;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; second_lin=
e_bpg_offset;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_m=
in_qp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_m=
ax_qp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flatness_d=
et_thresh;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; qp_min;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; qp_max;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; qp_set&nbsp;&nbsp; ofs;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_model_s=
ize;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_edge_fa=
ctor;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_tgt_off=
set_hi;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_tgt_off=
set_lo;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc_buf_thr=
esh[QP_SET_SIZE - 1];<br>
&gt; -};<br>
&gt; -<br>
&gt; -enum colour_mode {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; CM_RGB,&nbsp;&nbsp; /* 444 RGB */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; CM_444,&nbsp;&nbsp; /* 444 YUV or simple 422=
 */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; CM_422,&nbsp;&nbsp; /* native 422 */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; CM_420&nbsp;&nbsp;&nbsp; /* native 420 */<br=
>
&gt; -};<br>
&gt; -<br>
&gt; -enum bits_per_comp {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; BPC_8&nbsp; =3D&nbsp; 8,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; BPC_10 =3D 10,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; BPC_12 =3D 12<br>
&gt; -};<br>
&gt; -<br>
&gt; -enum max_min {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; DAL_MM_MIN =3D 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; DAL_MM_MAX =3D 1<br>
&gt; -};<br>
&gt; -<br>
&gt; -struct qp_entry {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; float&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; bpp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const qp_set&nbsp; qps;<br>
&gt; -};<br>
&gt; -<br>
&gt; -typedef struct qp_entry qp_table[];<br>
&gt; +#include &quot;dml/dsc/rc_calc_fpu.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void calc_rc_params(struct rc_params *rc, const struct drm=
_dsc_config *pps);<br>
&gt;&nbsp;&nbsp; u32 calc_dsc_bytes_per_pixel(const struct drm_dsc_config *=
pps);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/driver=
s/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c<br>
&gt; index ef830aded5b1..1e19dd674e5a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c<br>
&gt; @@ -22,7 +22,6 @@<br>
&gt;&nbsp;&nbsp;&nbsp; * Authors: AMD<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -#include &quot;os_types.h&quot;<br>
&gt;&nbsp;&nbsp; #include &lt;drm/drm_dsc.h&gt;<br>
&gt;&nbsp;&nbsp; #include &quot;dscc_types.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;rc_calc.h&quot;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB2870958A354B7477697AC13EFBA49BYAPR12MB2870namp_--
