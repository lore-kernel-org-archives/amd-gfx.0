Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988ACC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 16:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9746197D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 16:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9746197D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D6426EA4E;
	Fri, 19 Mar 2021 16:17:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F706EA4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 16:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcHoqnnkGODmBr3DLZnis33r3hzlng0GgXLd4/lh+MVq8OwAxHPHTzIlqpaxLXd/aKZl4DH98iEcg4PGv1It+K0oIKXc0gYd+rcwMi948bfPhL33cbwbGgsOa+FkrTTD9NL6w6Ke3OmSNuQ3o95r23VEiinzb5z/PBsj9wGoZ/Er5WfgtfHFk1M0z3oKYENBoWn0sq0rzFck4J1jNIzJkabvzvpb91RO988V0YoI9zUQZRIDkW1PC0Rsye0xbDfko8TlAMx5xlkpsKevWdrh+Bo8hKG8JjVvxQSeZsLT64/Tc+T7CiYbi4/h5FxxzgcDk9IdBjBdu17NvOgj8BNmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNzxS4xaH4sapHU6iWZpWVvZWvH3fntX9/WclZRe6Jo=;
 b=ibrp9itEh95cWnCLuAbDVZ/eoKmpVvfrYyxTEj3IP2yxxyEpW735T+sbIe5qcoFlexSWm1UMtxHVfHSjMNkFZA1es2CnfRQDzMaiB0N1OMtTZJmOQumHZ47ZbDJschrh5NvvXrisu2uCkMXABhNNyYfLB7m4fvSnceGju8Bm8V2XPea8DWV15UyHqa6xrN3Rp5/0geQsyHUGoUi9pQ9S+D2RU3gw65OsCgSN9Bn/akoILPEN+mzbHWevfR/1tHOMQ5XhY6mjC27WJbGJkJA9ZB0Do14JvAb9NPOYHTIovNg2+YhCRESw/1bKPD5mGk1QIua3dxH8VwDMyRHIiryLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNzxS4xaH4sapHU6iWZpWVvZWvH3fntX9/WclZRe6Jo=;
 b=gDLU50SirpD5QPia4Zeut8TuYeOGvweGk8RiLFRClgMUAOYOsxP10moIMbPAxE9sVxtckUc5H+sPt6Tn75NRBHA0zlkdfeIMKn+etzs/HlbsSnRzukWaFShlTssj2AlLmq/nVrMFuzAffmgcRvVsRSf2dnGpXkzBiuMuwd3GQz0=
Received: from MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 by MWHPR12MB1616.namprd12.prod.outlook.com (2603:10b6:301:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 16:17:38 +0000
Received: from MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::a10d:f9c9:4529:6422]) by MW3PR12MB4491.namprd12.prod.outlook.com
 ([fe80::a10d:f9c9:4529:6422%8]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 16:17:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: label these APIs used internally as static
Thread-Topic: [PATCH 2/2] drm/amd/pm: label these APIs used internally as
 static
Thread-Index: AQHXHIzAaQfklgv2UE2tBNcUDHTS3aqLfY6w
Date: Fri, 19 Mar 2021 16:17:38 +0000
Message-ID: <MW3PR12MB4491FB47C04FBBB17EFC14B0F7689@MW3PR12MB4491.namprd12.prod.outlook.com>
References: <20210319065344.511157-1-evan.quan@amd.com>,
 <20210319065344.511157-2-evan.quan@amd.com>
In-Reply-To: <20210319065344.511157-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-19T16:17:37.528Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a7d4866-9373-4016-dd85-08d8eaf2837f
x-ms-traffictypediagnostic: MWHPR12MB1616:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1616E76B92E9BD28101CCE11F7689@MWHPR12MB1616.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XwbuBdya9rXnG8NQ2U+VKRgd9VPsnjIGcU4DHRBvixKqWWIQtqlLxnr0XwRHaT02KWFgR5rb2Ues6Ww+lTICTnWfMx+RcGLc5m2p/DgAYixRNab5imptXpbX25NpYDAkSZgzHDREBo6FCyrhAe5ZsC+/+Gg6+AAgr18db3BbQgP24qYoEl6Sv8kmsBhGdtA7w/kpAku4PlUhi5aKpwa6aPzUqsCmgDYRtZjahUpXAoa9Y+slVp0gtk5C+mJhgbFU8f5zT+iNfoezQUBPzsoNkVstXQYLL2uIC/Z/xPBfTPjX5x4GCtDN5vGWWZ3gBVjg486Qxp8mZkI+yaZ7JTO8qynqqjjsGL5Dp9d/whgjvdSEDAn8YbXBMgRLeJ4cjOBiqoNaTSx3pVjS8t0mczxDO/USS8fL57euPVZj7s9dQtX2+aTw6LSsng8Jz+Q/HyGatzZJLWUyH3Kh137LOEHVFCk0QdJEd4nBq48vx+UZ/YKTGSOGvmxYN+ofrLe+JXsGPUITltKpzAyw0StkD+FE/poYxAQMK+y6pYPP1Pe7scUaF/qm5dTqnX1X3jFDlTwIuPJxr8Rf9XsnvxS+/NnSwmMnz41lA9gnAhVNIDjYS1/jt945t3V6hZvujD3wvsKpOLnBYkTypISuP4pvgbDlZi0bCFr8LKopv2hS2hHyBcUkbr+AZlgxWD41Q9gVgntZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(316002)(66446008)(166002)(5660300002)(53546011)(66476007)(33656002)(64756008)(6506007)(55016002)(66556008)(26005)(9686003)(7696005)(45080400002)(30864003)(52536014)(71200400001)(110136005)(8936002)(86362001)(2906002)(76116006)(966005)(38100700001)(19627405001)(83380400001)(8676002)(478600001)(186003)(66946007)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wgPn+oJJ9HNFTe/IPGreLJ4l7TWrPYt1oIuAqbVDQn9G2BwP2R6wKKMFanWC?=
 =?us-ascii?Q?LcAe/D9B2zUbINbkhzgixwElJ88EyXb5i76ZFMCLzPd4FZXkgnBoPVpixxie?=
 =?us-ascii?Q?4XtBvud66SH3aE95e7DYsvJ7oliyyCiw8NPly9Gu1JpffbA1GSukfdiZ84jG?=
 =?us-ascii?Q?FmvhR1pb3wgcK/89KRt/4U+UhCK/ud+kDxjJcYaLs5ALKf5OpjSKnsT3M0V9?=
 =?us-ascii?Q?Z+wnJUfDWtogLnFonPh8BAJdVyAd2cIDh+8PlaAYJgTo/XJamsTy96Umy7Qz?=
 =?us-ascii?Q?Elw+9hHrbWW3zGDcUYx9XwfMx7PAFlpES6txDRwSLSKuAqz20foGQJsuMH/2?=
 =?us-ascii?Q?QdNCV43onQ8iEKS0oPANhzcvGqg1fNqwIKw/zcyF0+/yyV0etMkgvJyIrK2H?=
 =?us-ascii?Q?0Tem+O4uF6EIb3wSnbdHBrDWD6fOuvZ/meto7KsQCNjXhEShBmn41dWDIl2j?=
 =?us-ascii?Q?B6Zc2zIw3xOBmZg9BGkZB0+KmNCw7S4gqDbqN8VE4yFPMGycuO5NqHfdgkNf?=
 =?us-ascii?Q?tmSgHFnzQ3EeLGMVHt7+il/rutjmbl8lE27R1kSOOQsvGpH/xSMsSRLT7dkY?=
 =?us-ascii?Q?VluJkyR6j8hq2UDLYGU/xup6yDJreUrUCl5U9MMBZIz+jaZvrCiFRwo6SaZR?=
 =?us-ascii?Q?hYs0qVZoqaFH01PIZuVPrN+jxWCV6ZGuNpnGRc20a9VCOJxU3ZOKhIAz0Mcz?=
 =?us-ascii?Q?4KbKZtXdhUBjvopZGDeMG3u3dmGuLlQlaFrJac/5E+xyJ0nEmNK2xZPa3xVb?=
 =?us-ascii?Q?WpL/bG4qFv3i9teL1nk/GcCsLUnseDOJzD4tJNefmAsZCVuPnTqrH/bwg83w?=
 =?us-ascii?Q?S3Lco2TZG5lb422TMok2Hrx/jVw3kL1YpRGgFGm1JKKCNNhVB7MTitTwnNVG?=
 =?us-ascii?Q?CyuWhmkm26dUSZBkADUPJLhQECzSl22elJTrRkv5mphJnUYABoupkwcBuHBm?=
 =?us-ascii?Q?CkhocxbCuejJ/5nh0IT3+vOosKqK4uKvKdXTYTAwS9QUNzr8wBZVEkiFcVw7?=
 =?us-ascii?Q?vwFEUqqB/FzZvTOQYCjDVKapz/JxutU0VIerlXzmyYInavLBAmMY/I7xZuw5?=
 =?us-ascii?Q?KAttWWLh3wpi6yXmRzJkQ7kXBdML6HUTNqn22M2SxneeKqGVVRD1cnKs92Hw?=
 =?us-ascii?Q?E25UiYvqWQx2d62LjmffijRlLIA/MxvfkUA/WGuHQFo8NnvSiGok29VbqPWo?=
 =?us-ascii?Q?4JQg1UXqJHp4ERuToQOTEmLh21dY9GdKv1/nlyG4wpLS3uBLDj2vR1d2tOjN?=
 =?us-ascii?Q?7cGBqvMmTG25PIhNHmUNCDKC2hi2lfv+LI2PeEMuCriu8xj8T81OSQl1BBaZ?=
 =?us-ascii?Q?8PXbyO/kquHx7UhnxrVALOUq?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d4866-9373-4016-dd85-08d8eaf2837f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 16:17:38.0582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCY+7H8yzgpqqXvwAFXksDNLGIHXCarA6MwmTDiqEJ2Lqqe8CK9yXEtTi4/8O15SubVQcFdgC0QpgsWgSWKVdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1616
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
Content-Type: multipart/mixed; boundary="===============1202684129=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1202684129==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4491FB47C04FBBB17EFC14B0F7689MW3PR12MB4491namp_"

--_000_MW3PR12MB4491FB47C04FBBB17EFC14B0F7689MW3PR12MB4491namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Evan Qua=
n <evan.quan@amd.com>
Sent: Friday, March 19, 2021 2:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: label these APIs used internally as static

Also drop unnecessary header file and declarations.

Change-Id: I877b48c32c599534798e14e271c3e700b0d6ebf6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |   1 -
 drivers/gpu/drm/amd/amdgpu/nv.c           |   1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c        |   1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  10 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  61 +--------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 159 +++++++++++++---------
 7 files changed, 98 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 33f748e5bbfc..1429c6897d3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -24,7 +24,6 @@
 #include <linux/list.h>
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
-#include "amdgpu_smu.h"
 #include "amdgpu_ras.h"
 #include "soc15.h"
 #include "df/df_3_6_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index d780b9c0926f..9a65ff871a58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -29,7 +29,6 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
-#include "amdgpu_smu.h"
 #include "nv.h"
 #include "nvd.h"

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index a31ef68ee2ab..e9cc3201054f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -34,7 +34,6 @@
 #include "amdgpu_vce.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_psp.h"
-#include "amdgpu_smu.h"
 #include "atom.h"
 #include "amd_pcie.h"

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 3808402cd964..c354a11e2fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -76,7 +76,6 @@
 #include "smuio_v13_0.h"
 #include "dce_virtual.h"
 #include "mxgpu_ai.h"
-#include "amdgpu_smu.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 74fa5fe89970..10c761b11ff7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -27,7 +27,6 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
-#include "amdgpu_smu.h"
 #include "atom.h"
 #include <linux/pci.h>
 #include <linux/hwmon.h>
@@ -930,14 +929,7 @@ static ssize_t amdgpu_set_pp_features(struct device *d=
ev,
                 return ret;
         }

-       if (is_support_sw_smu(adev)) {
-               ret =3D smu_sys_set_pp_feature_mask(&adev->smu, featuremask=
);
-               if (ret) {
-                       pm_runtime_mark_last_busy(ddev->dev);
-                       pm_runtime_put_autosuspend(ddev->dev);
-                       return -EINVAL;
-               }
-       } else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
+       if (adev->powerplay.pp_funcs->set_ppfeature_status) {
                 ret =3D amdgpu_dpm_set_ppfeature_status(adev, featuremask)=
;
                 if (ret) {
                         pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index ca5a0a436cad..517f333fbc4b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1281,50 +1281,22 @@ int smu_load_microcode(struct smu_context *smu);

 int smu_check_fw_status(struct smu_context *smu);

-int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
-
-int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
-
 int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
                         enum smu_ppt_limit_level limit_level);

-int smu_set_power_limit(void *handle, uint32_t limit);
-int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *bu=
f);
-
-int smu_od_edit_dpm_table(void *handle,
-                         enum PP_OD_DPM_TABLE_COMMAND type,
-                         long *input, uint32_t size);
-
-int smu_read_sensor(void *handle, int sensor, void *data, int *size);
-int smu_get_power_profile_mode(void *handle, char *buf);
-int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_s=
ize);
-u32 smu_get_fan_control_mode(void *handle);
-int smu_set_fan_control_mode(struct smu_context *smu, int value);
-void smu_pp_set_fan_control_mode(void *handle, u32 value);
-int smu_get_fan_speed_percent(void *handle, u32 *speed);
-int smu_set_fan_speed_percent(void *handle, u32 speed);
-int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);
-
-int smu_set_xgmi_pstate(void *handle,
-                       uint32_t pstate);
-
 int smu_set_azalia_d3_pme(struct smu_context *smu);

 bool smu_baco_is_support(struct smu_context *smu);
-int smu_get_baco_capability(void *handle, bool *cap);

 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state=
);

 int smu_baco_enter(struct smu_context *smu);
 int smu_baco_exit(struct smu_context *smu);
-int smu_baco_set_state(void *handle, int state);
-

 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
-int smu_mode2_reset(void *handle);

 extern const struct amd_ip_funcs smu_ip_funcs;

@@ -1334,48 +1306,23 @@ extern const struct amdgpu_ip_block_version smu_v13=
_0_ip_block;

 bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
-int smu_reset(struct smu_context *smu);
-int smu_sys_get_pp_table(void *handle, char **table);
-int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
-int smu_get_power_num_states(void *handle, struct pp_states_info *state_in=
fo);
-enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);

 /* smu to display interface */
 extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool =
gate);
-extern int smu_handle_task(struct smu_context *smu,
-                          enum amd_dpm_forced_level level,
-                          enum amd_pp_task task_id,
-                          bool lock_needed);
-extern int smu_handle_dpm_task(void *handle,
-                              enum amd_pp_task task_id,
-                              enum amd_pm_state_type *user_state);
-int smu_switch_power_profile(void *handle,
-                            enum PP_SMC_POWER_PROFILE type,
-                            bool en);
+
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_=
type,
                            uint32_t *min, uint32_t *max);
-u32 smu_get_mclk(void *handle, bool low);
-u32 smu_get_sclk(void *handle, bool low);
+
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk=
_type,
                             uint32_t min, uint32_t max);
-enum amd_dpm_forced_level smu_get_performance_level(void *handle);
-int smu_force_performance_level(void *handle, enum amd_dpm_forced_level le=
vel);
+
 int smu_set_ac_dc(struct smu_context *smu);
-int smu_sys_get_pp_feature_mask(void *handle, char *buf);
-int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
-int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t=
 mask);
-int smu_set_mp1_state(void *handle,
-                     enum pp_mp1_state mp1_state);
-int smu_set_df_cstate(void *handle,
-                     enum pp_df_cstate state);
+
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);

 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);

-ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
-
-int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);

 int smu_set_light_sbr(struct smu_context *smu, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index db56cb3693a3..35aa1d234535 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -51,8 +51,19 @@ static const struct amd_pm_funcs swsmu_pm_funcs;
 static int smu_force_smuclk_levels(struct smu_context *smu,
                                    enum smu_clk_type clk_type,
                                    uint32_t mask);
-
-int smu_sys_get_pp_feature_mask(void *handle, char *buf)
+static int smu_handle_task(struct smu_context *smu,
+                          enum amd_dpm_forced_level level,
+                          enum amd_pp_task task_id,
+                          bool lock_needed);
+static int smu_reset(struct smu_context *smu);
+static int smu_set_fan_speed_percent(void *handle, u32 speed);
+static int smu_set_fan_control_mode(struct smu_context *smu, int value);
+static int smu_set_power_limit(void *handle, uint32_t limit);
+static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
+static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
+
+static int smu_sys_get_pp_feature_mask(void *handle,
+                                      char *buf)
 {
         struct smu_context *smu =3D handle;
         int size =3D 0;
@@ -69,7 +80,8 @@ int smu_sys_get_pp_feature_mask(void *handle, char *buf)
         return size;
 }

-int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask)
+static int smu_sys_set_pp_feature_mask(void *handle,
+                                      uint64_t new_mask)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -142,7 +154,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
         return ret;
 }

-u32 smu_get_mclk(void *handle, bool low)
+static u32 smu_get_mclk(void *handle, bool low)
 {
         struct smu_context *smu =3D handle;
         uint32_t clk_freq;
@@ -156,7 +168,7 @@ u32 smu_get_mclk(void *handle, bool low)
         return clk_freq * 100;
 }

-u32 smu_get_sclk(void *handle, bool low)
+static u32 smu_get_sclk(void *handle, bool low)
 {
         struct smu_context *smu =3D handle;
         uint32_t clk_freq;
@@ -256,7 +268,8 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *=
smu,
  *    Under this case, the smu->mutex lock protection is already enforced =
on
  *    the parent API smu_force_performance_level of the call path.
  */
-int smu_dpm_set_power_gate(void *handle, uint32_t block_type,
+int smu_dpm_set_power_gate(void *handle,
+                          uint32_t block_type,
                            bool gate)
 {
         struct smu_context *smu =3D handle;
@@ -412,8 +425,8 @@ static void smu_restore_dpm_user_profile(struct smu_con=
text *smu)
         smu->user_dpm_profile.flags &=3D ~SMU_DPM_USER_PROFILE_RESTORE;
 }

-int smu_get_power_num_states(void *handle,
-                            struct pp_states_info *state_info)
+static int smu_get_power_num_states(void *handle,
+                                   struct pp_states_info *state_info)
 {
         if (!state_info)
                 return -EINVAL;
@@ -448,7 +461,8 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
 }


-int smu_sys_get_pp_table(void *handle, char **table)
+static int smu_sys_get_pp_table(void *handle,
+                               char **table)
 {
         struct smu_context *smu =3D handle;
         struct smu_table_context *smu_table =3D &smu->smu_table;
@@ -474,7 +488,9 @@ int smu_sys_get_pp_table(void *handle, char **table)
         return powerplay_table_size;
 }

-int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)
+static int smu_sys_set_pp_table(void *handle,
+                               const char *buf,
+                               size_t size)
 {
         struct smu_context *smu =3D handle;
         struct smu_table_context *smu_table =3D &smu->smu_table;
@@ -638,6 +654,7 @@ static int smu_set_default_dpm_table(struct smu_context=
 *smu)
         return ret;
 }

+
 static int smu_late_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -1538,8 +1555,8 @@ static int smu_resume(void *handle)
         return 0;
 }

-int smu_display_configuration_change(void *handle,
-                                    const struct amd_pp_display_configurat=
ion *display_config)
+static int smu_display_configuration_change(void *handle,
+                                           const struct amd_pp_display_con=
figuration *display_config)
 {
         struct smu_context *smu =3D handle;
         int index =3D 0;
@@ -1732,9 +1749,9 @@ int smu_handle_task(struct smu_context *smu,
         return ret;
 }

-int smu_handle_dpm_task(void *handle,
-                       enum amd_pp_task task_id,
-                       enum amd_pm_state_type *user_state)
+static int smu_handle_dpm_task(void *handle,
+                              enum amd_pp_task task_id,
+                              enum amd_pm_state_type *user_state)
 {
         struct smu_context *smu =3D handle;
         struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
@@ -1743,10 +1760,9 @@ int smu_handle_dpm_task(void *handle,

 }

-
-int smu_switch_power_profile(void *handle,
-                            enum PP_SMC_POWER_PROFILE type,
-                            bool en)
+static int smu_switch_power_profile(void *handle,
+                                   enum PP_SMC_POWER_PROFILE type,
+                                   bool en)
 {
         struct smu_context *smu =3D handle;
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
@@ -1782,7 +1798,7 @@ int smu_switch_power_profile(void *handle,
         return 0;
 }

-enum amd_dpm_forced_level smu_get_performance_level(void *handle)
+static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
         struct smu_context *smu =3D handle;
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
@@ -1801,7 +1817,8 @@ enum amd_dpm_forced_level smu_get_performance_level(v=
oid *handle)
         return level;
 }

-int smu_force_performance_level(void *handle, enum amd_dpm_forced_level le=
vel)
+static int smu_force_performance_level(void *handle,
+                                      enum amd_dpm_forced_level level)
 {
         struct smu_context *smu =3D handle;
         struct smu_dpm_context *smu_dpm_ctx =3D &(smu->smu_dpm);
@@ -1836,7 +1853,7 @@ int smu_force_performance_level(void *handle, enum am=
d_dpm_forced_level level)
         return ret;
 }

-int smu_set_display_count(void *handle, uint32_t count)
+static int smu_set_display_count(void *handle, uint32_t count)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -1881,7 +1898,9 @@ static int smu_force_smuclk_levels(struct smu_context=
 *smu,
         return ret;
 }

-int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t=
 mask)
+static int smu_force_ppclk_levels(void *handle,
+                                 enum pp_clock_type type,
+                                 uint32_t mask)
 {
         struct smu_context *smu =3D handle;
         enum smu_clk_type clk_type;
@@ -1925,8 +1944,8 @@ int smu_force_ppclk_levels(void *handle, enum pp_cloc=
k_type type, uint32_t mask)
  * However, the mp1 state setting should still be granted
  * even if the dpm_enabled cleared.
  */
-int smu_set_mp1_state(void *handle,
-                     enum pp_mp1_state mp1_state)
+static int smu_set_mp1_state(void *handle,
+                            enum pp_mp1_state mp1_state)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -1945,8 +1964,8 @@ int smu_set_mp1_state(void *handle,
         return ret;
 }

-int smu_set_df_cstate(void *handle,
-                     enum pp_df_cstate state)
+static int smu_set_df_cstate(void *handle,
+                            enum pp_df_cstate state)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2005,8 +2024,8 @@ int smu_write_watermarks_table(struct smu_context *sm=
u)
         return ret;
 }

-int smu_set_watermarks_for_clock_ranges(void *handle,
-                                       struct pp_smu_wm_range_sets *clock_=
ranges)
+static int smu_set_watermarks_for_clock_ranges(void *handle,
+                                              struct pp_smu_wm_range_sets =
*clock_ranges)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2143,7 +2162,7 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool en=
abled)
         return ret;
 }

-int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
+static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2202,7 +2221,7 @@ int smu_get_power_limit(struct smu_context *smu,
         return ret;
 }

-int smu_set_power_limit(void *handle, uint32_t limit)
+static int smu_set_power_limit(void *handle, uint32_t limit)
 {
         struct smu_context *smu =3D handle;
         uint32_t limit_type =3D limit >> 24;
@@ -2258,7 +2277,9 @@ static int smu_print_smuclk_levels(struct smu_context=
 *smu, enum smu_clk_type cl
         return ret;
 }

-int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *bu=
f)
+static int smu_print_ppclk_levels(void *handle,
+                                 enum pp_clock_type type,
+                                 char *buf)
 {
         struct smu_context *smu =3D handle;
         enum smu_clk_type clk_type;
@@ -2299,9 +2320,9 @@ int smu_print_ppclk_levels(void *handle, enum pp_cloc=
k_type type, char *buf)
         return smu_print_smuclk_levels(smu, clk_type, buf);
 }

-int smu_od_edit_dpm_table(void *handle,
-                         enum PP_OD_DPM_TABLE_COMMAND type,
-                         long *input, uint32_t size)
+static int smu_od_edit_dpm_table(void *handle,
+                                enum PP_OD_DPM_TABLE_COMMAND type,
+                                long *input, uint32_t size)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2320,7 +2341,10 @@ int smu_od_edit_dpm_table(void *handle,
         return ret;
 }

-int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
+static int smu_read_sensor(void *handle,
+                          int sensor,
+                          void *data,
+                          int *size_arg)
 {
         struct smu_context *smu =3D handle;
         struct smu_umd_pstate_table *pstate_table =3D
@@ -2387,7 +2411,7 @@ int smu_read_sensor(void *handle, int sensor, void *d=
ata, int *size_arg)
         return ret;
 }

-int smu_get_power_profile_mode(void *handle, char *buf)
+static int smu_get_power_profile_mode(void *handle, char *buf)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2405,7 +2429,9 @@ int smu_get_power_profile_mode(void *handle, char *bu=
f)
         return ret;
 }

-int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_s=
ize)
+static int smu_set_power_profile_mode(void *handle,
+                                     long *param,
+                                     uint32_t param_size)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2423,7 +2449,7 @@ int smu_set_power_profile_mode(void *handle, long *pa=
ram, uint32_t param_size)
 }


-u32 smu_get_fan_control_mode(void *handle)
+static u32 smu_get_fan_control_mode(void *handle)
 {
         struct smu_context *smu =3D handle;
         u32 ret =3D 0;
@@ -2469,14 +2495,15 @@ int smu_set_fan_control_mode(struct smu_context *sm=
u, int value)
         return ret;
 }

-void smu_pp_set_fan_control_mode(void *handle, u32 value) {
+static void smu_pp_set_fan_control_mode(void *handle, u32 value)
+{
         struct smu_context *smu =3D handle;

         smu_set_fan_control_mode(smu, value);
 }


-int smu_get_fan_speed_percent(void *handle, u32 *speed)
+static int smu_get_fan_speed_percent(void *handle, u32 *speed)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2494,7 +2521,7 @@ int smu_get_fan_speed_percent(void *handle, u32 *spee=
d)
         return ret;
 }

-int smu_set_fan_speed_percent(void *handle, u32 speed)
+static int smu_set_fan_speed_percent(void *handle, u32 speed)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2517,7 +2544,7 @@ int smu_set_fan_speed_percent(void *handle, u32 speed=
)
         return ret;
 }

-int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
+static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2535,7 +2562,7 @@ int smu_get_fan_speed_rpm(void *handle, uint32_t *spe=
ed)
         return ret;
 }

-int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
+static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2552,9 +2579,9 @@ int smu_set_deep_sleep_dcefclk(void *handle, uint32_t=
 clk)
         return ret;
 }

-int smu_get_clock_by_type_with_latency(void *handle,
-                                      enum amd_pp_clock_type type,
-                                      struct pp_clock_levels_with_latency =
*clocks)
+static int smu_get_clock_by_type_with_latency(void *handle,
+                                             enum amd_pp_clock_type type,
+                                             struct pp_clock_levels_with_l=
atency *clocks)
 {
         struct smu_context *smu =3D handle;
         enum smu_clk_type clk_type;
@@ -2593,8 +2620,8 @@ int smu_get_clock_by_type_with_latency(void *handle,
         return ret;
 }

-int smu_display_clock_voltage_request(void *handle,
-                                     struct pp_display_clock_request *cloc=
k_req)
+static int smu_display_clock_voltage_request(void *handle,
+                                            struct pp_display_clock_reques=
t *clock_req)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2613,8 +2640,8 @@ int smu_display_clock_voltage_request(void *handle,
 }


-int smu_display_disable_memory_clock_switch(void *handle,
-                                           bool disable_memory_clock_switc=
h)
+static int smu_display_disable_memory_clock_switch(void *handle,
+                                                  bool disable_memory_cloc=
k_switch)
 {
         struct smu_context *smu =3D handle;
         int ret =3D -EINVAL;
@@ -2632,8 +2659,8 @@ int smu_display_disable_memory_clock_switch(void *han=
dle,
         return ret;
 }

-int smu_set_xgmi_pstate(void *handle,
-                       uint32_t pstate)
+static int smu_set_xgmi_pstate(void *handle,
+                              uint32_t pstate)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2696,7 +2723,7 @@ bool smu_baco_is_support(struct smu_context *smu)
         return ret;
 }

-int smu_get_baco_capability(void *handle, bool *cap)
+static int smu_get_baco_capability(void *handle, bool *cap)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2769,7 +2796,7 @@ int smu_baco_exit(struct smu_context *smu)
         return ret;
 }

-int smu_baco_set_state(void *handle, int state)
+static int smu_baco_set_state(void *handle, int state)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2854,7 +2881,7 @@ int smu_mode1_reset(struct smu_context *smu)
         return ret;
 }

-int smu_mode2_reset(void *handle)
+static int smu_mode2_reset(void *handle)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2875,8 +2902,8 @@ int smu_mode2_reset(void *handle)
         return ret;
 }

-int smu_get_max_sustainable_clocks_by_dc(void *handle,
-                                        struct pp_smu_nv_clock_table *max_=
clocks)
+static int smu_get_max_sustainable_clocks_by_dc(void *handle,
+                                               struct pp_smu_nv_clock_tabl=
e *max_clocks)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2894,9 +2921,9 @@ int smu_get_max_sustainable_clocks_by_dc(void *handle=
,
         return ret;
 }

-int smu_get_uclk_dpm_states(void *handle,
-                           unsigned int *clock_values_in_khz,
-                           unsigned int *num_states)
+static int smu_get_uclk_dpm_states(void *handle,
+                                  unsigned int *clock_values_in_khz,
+                                  unsigned int *num_states)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2914,7 +2941,7 @@ int smu_get_uclk_dpm_states(void *handle,
         return ret;
 }

-enum amd_pm_state_type smu_get_current_power_state(void *handle)
+static enum amd_pm_state_type smu_get_current_power_state(void *handle)
 {
         struct smu_context *smu =3D handle;
         enum amd_pm_state_type pm_state =3D POWER_STATE_TYPE_DEFAULT;
@@ -2932,8 +2959,8 @@ enum amd_pm_state_type smu_get_current_power_state(vo=
id *handle)
         return pm_state;
 }

-int smu_get_dpm_clock_table(void *handle,
-                           struct dpm_clocks *clock_table)
+static int smu_get_dpm_clock_table(void *handle,
+                                  struct dpm_clocks *clock_table)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
@@ -2951,7 +2978,7 @@ int smu_get_dpm_clock_table(void *handle,
         return ret;
 }

-ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
+static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
         struct smu_context *smu =3D handle;
         ssize_t size;
@@ -2971,7 +2998,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **=
table)
         return size;
 }

-int smu_enable_mgpu_fan_boost(void *handle)
+static int smu_enable_mgpu_fan_boost(void *handle)
 {
         struct smu_context *smu =3D handle;
         int ret =3D 0;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C14fbcd618ad346544e6208d8eaa3e199%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637517336878050566%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D27i1t6T9kwjKHp5gfPdmiCBcFeGVbPGqkLBoCBo3T1Q%3D&amp;reserved=3D0

--_000_MW3PR12MB4491FB47C04FBBB17EFC14B0F7689MW3PR12MB4491namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, March 19, 2021 2:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: label these APIs used internally as=
 static</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Also drop unnecessary header file and declarations=
.<br>
<br>
Change-Id: I877b48c32c599534798e14e271c3e700b0d6ebf6<br>
Signed-off-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp; |&nbsp;&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp=
; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 10 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp; |&nbsp; 61 +-----=
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 159 +++++++++++++--------=
-<br>
&nbsp;7 files changed, 98 insertions(+), 136 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c<br>
index 33f748e5bbfc..1429c6897d3f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<br>
@@ -24,7 +24,6 @@<br>
&nbsp;#include &lt;linux/list.h&gt;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_xgmi.h&quot;<br>
-#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;df/df_3_6_offset.h&quot;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index d780b9c0926f..9a65ff871a58 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -29,7 +29,6 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_gfx.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp.h&quot;<br>
-#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;nv.h&quot;<br>
&nbsp;#include &quot;nvd.h&quot;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index a31ef68ee2ab..e9cc3201054f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -34,7 +34,6 @@<br>
&nbsp;#include &quot;amdgpu_vce.h&quot;<br>
&nbsp;#include &quot;amdgpu_ucode.h&quot;<br>
&nbsp;#include &quot;amdgpu_psp.h&quot;<br>
-#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &quot;amd_pcie.h&quot;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c<br>
index 3808402cd964..c354a11e2fd9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
@@ -76,7 +76,6 @@<br>
&nbsp;#include &quot;smuio_v13_0.h&quot;<br>
&nbsp;#include &quot;dce_virtual.h&quot;<br>
&nbsp;#include &quot;mxgpu_ai.h&quot;<br>
-#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;#include &quot;amdgpu_xgmi.h&quot;<br>
&nbsp;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 74fa5fe89970..10c761b11ff7 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -27,7 +27,6 @@<br>
&nbsp;#include &quot;amdgpu_drv.h&quot;<br>
&nbsp;#include &quot;amdgpu_pm.h&quot;<br>
&nbsp;#include &quot;amdgpu_dpm.h&quot;<br>
-#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;#include &quot;atom.h&quot;<br>
&nbsp;#include &lt;linux/pci.h&gt;<br>
&nbsp;#include &lt;linux/hwmon.h&gt;<br>
@@ -930,14 +929,7 @@ static ssize_t amdgpu_set_pp_features(struct device *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_sys_set_pp_feature_mask(&amp;adev-&gt;smu, featurema=
sk);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_=
last_busy(ddev-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_a=
utosuspend(ddev-&gt;dev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerplay.pp_func=
s-&gt;set_ppfeature_status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;s=
et_ppfeature_status) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_ppfeature_status(adev, feature=
mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_ru=
ntime_mark_last_busy(ddev-&gt;dev);<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index ca5a0a436cad..517f333fbc4b 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -1281,50 +1281,22 @@ int smu_load_microcode(struct smu_context *smu);<br=
>
&nbsp;<br>
&nbsp;int smu_check_fw_status(struct smu_context *smu);<br>
&nbsp;<br>
-int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);<br>
-<br>
-int smu_set_fan_speed_rpm(void *handle, uint32_t speed);<br>
-<br>
&nbsp;int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
smu_ppt_limit_level limit_level);<br>
&nbsp;<br>
-int smu_set_power_limit(void *handle, uint32_t limit);<br>
-int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *bu=
f);<br>
-<br>
-int smu_od_edit_dpm_table(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum=
 PP_OD_DPM_TABLE_COMMAND type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long=
 *input, uint32_t size);<br>
-<br>
-int smu_read_sensor(void *handle, int sensor, void *data, int *size);<br>
-int smu_get_power_profile_mode(void *handle, char *buf);<br>
-int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_s=
ize);<br>
-u32 smu_get_fan_control_mode(void *handle);<br>
-int smu_set_fan_control_mode(struct smu_context *smu, int value);<br>
-void smu_pp_set_fan_control_mode(void *handle, u32 value);<br>
-int smu_get_fan_speed_percent(void *handle, u32 *speed);<br>
-int smu_set_fan_speed_percent(void *handle, u32 speed);<br>
-int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);<br>
-<br>
-int smu_set_xgmi_pstate(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate)=
;<br>
-<br>
&nbsp;int smu_set_azalia_d3_pme(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;bool smu_baco_is_support(struct smu_context *smu);<br>
-int smu_get_baco_capability(void *handle, bool *cap);<br>
&nbsp;<br>
&nbsp;int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *=
state);<br>
&nbsp;<br>
&nbsp;int smu_baco_enter(struct smu_context *smu);<br>
&nbsp;int smu_baco_exit(struct smu_context *smu);<br>
-int smu_baco_set_state(void *handle, int state);<br>
-<br>
&nbsp;<br>
&nbsp;bool smu_mode1_reset_is_support(struct smu_context *smu);<br>
&nbsp;bool smu_mode2_reset_is_support(struct smu_context *smu);<br>
&nbsp;int smu_mode1_reset(struct smu_context *smu);<br>
-int smu_mode2_reset(void *handle);<br>
&nbsp;<br>
&nbsp;extern const struct amd_ip_funcs smu_ip_funcs;<br>
&nbsp;<br>
@@ -1334,48 +1306,23 @@ extern const struct amdgpu_ip_block_version smu_v13=
_0_ip_block;<br>
&nbsp;<br>
&nbsp;bool is_support_sw_smu(struct amdgpu_device *adev);<br>
&nbsp;bool is_support_cclk_dpm(struct amdgpu_device *adev);<br>
-int smu_reset(struct smu_context *smu);<br>
-int smu_sys_get_pp_table(void *handle, char **table);<br>
-int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);<br>
-int smu_get_power_num_states(void *handle, struct pp_states_info *state_in=
fo);<br>
-enum amd_pm_state_type smu_get_current_power_state(void *handle);<br>
&nbsp;int smu_write_watermarks_table(struct smu_context *smu);<br>
&nbsp;<br>
&nbsp;/* smu to display interface */<br>
&nbsp;extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, =
bool gate);<br>
-extern int smu_handle_task(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; enum amd_dpm_forced_level level,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; enum amd_pp_task task_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool lock_needed);<br>
-extern int smu_handle_dpm_task(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_task task_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type *user_state);<br>
-int smu_switch_power_profile(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum PP_SMC_POWER_PROFILE type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; bool en);<br>
+<br>
&nbsp;int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type=
 clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t *min, uint32_t *max);<br>
-u32 smu_get_mclk(void *handle, bool low);<br>
-u32 smu_get_sclk(void *handle, bool low);<br>
+<br>
&nbsp;int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_typ=
e clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; uint32_t min, uint32_t max);<br>
-enum amd_dpm_forced_level smu_get_performance_level(void *handle);<br>
-int smu_force_performance_level(void *handle, enum amd_dpm_forced_level le=
vel);<br>
+<br>
&nbsp;int smu_set_ac_dc(struct smu_context *smu);<br>
-int smu_sys_get_pp_feature_mask(void *handle, char *buf);<br>
-int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);<br>
-int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t=
 mask);<br>
-int smu_set_mp1_state(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_mp1_state mp1_state)=
;<br>
-int smu_set_df_cstate(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_df_cstate state);<br=
>
+<br>
&nbsp;int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);<br>
&nbsp;<br>
&nbsp;int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value=
);<br>
&nbsp;<br>
-ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);<br>
-<br>
-int smu_enable_mgpu_fan_boost(void *handle);<br>
&nbsp;int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)=
;<br>
&nbsp;<br>
&nbsp;int smu_set_light_sbr(struct smu_context *smu, bool enable);<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c<br>
index db56cb3693a3..35aa1d234535 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -51,8 +51,19 @@ static const struct amd_pm_funcs swsmu_pm_funcs;<br>
&nbsp;static int smu_force_smuclk_levels(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_t=
ype clk_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask)=
;<br>
-<br>
-int smu_sys_get_pp_feature_mask(void *handle, char *buf)<br>
+static int smu_handle_task(struct smu_context *smu,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; enum amd_dpm_forced_level level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; enum amd_pp_task task_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; bool lock_needed);<br>
+static int smu_reset(struct smu_context *smu);<br>
+static int smu_set_fan_speed_percent(void *handle, u32 speed);<br>
+static int smu_set_fan_control_mode(struct smu_context *smu, int value);<b=
r>
+static int smu_set_power_limit(void *handle, uint32_t limit);<br>
+static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);<br>
+static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);<br>
+<br>
+static int smu_sys_get_pp_feature_mask(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
har *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0;<br>
@@ -69,7 +80,8 @@ int smu_sys_get_pp_feature_mask(void *handle, char *buf)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask)<br>
+static int smu_sys_set_pp_feature_mask(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int64_t new_mask)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -142,7 +154,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-u32 smu_get_mclk(void *handle, bool low)<br>
+static u32 smu_get_mclk(void *handle, bool low)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_freq;<br>
@@ -156,7 +168,7 @@ u32 smu_get_mclk(void *handle, bool low)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return clk_freq * 100;<br>
&nbsp;}<br>
&nbsp;<br>
-u32 smu_get_sclk(void *handle, bool low)<br>
+static u32 smu_get_sclk(void *handle, bool low)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_freq;<br>
@@ -256,7 +268,8 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *=
smu,<br>
&nbsp; *&nbsp;&nbsp;&nbsp; Under this case, the smu-&gt;mutex lock protecti=
on is already enforced on<br>
&nbsp; *&nbsp;&nbsp;&nbsp; the parent API smu_force_performance_level of th=
e call path.<br>
&nbsp; */<br>
-int smu_dpm_set_power_gate(void *handle, uint32_t block_type,<br>
+int smu_dpm_set_power_gate(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; uint32_t block_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; bool gate)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
@@ -412,8 +425,8 @@ static void smu_restore_dpm_user_profile(struct smu_con=
text *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;user_dpm_profile.f=
lags &amp;=3D ~SMU_DPM_USER_PROFILE_RESTORE;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_power_num_states(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct pp_states_info *state_info)<br>
+static int smu_get_power_num_states(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_states_in=
fo *state_info)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!state_info)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
@@ -448,7 +461,8 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)<br=
>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-int smu_sys_get_pp_table(void *handle, char **table)<br>
+static int smu_sys_get_pp_table(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
@@ -474,7 +488,9 @@ int smu_sys_get_pp_table(void *handle, char **table)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return powerplay_table_siz=
e;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)<br>
+static int smu_sys_set_pp_table(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
@@ -638,6 +654,7 @@ static int smu_set_default_dpm_table(struct smu_context=
 *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+<br>
&nbsp;static int smu_late_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -1538,8 +1555,8 @@ static int smu_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_display_configuration_change(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct =
amd_pp_display_configuration *display_config)<br>
+static int smu_display_configuration_change(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pp_display_configuration *dis=
play_config)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int index =3D 0;<br>
@@ -1732,9 +1749,9 @@ int smu_handle_task(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_handle_dpm_task(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_task=
 task_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_stat=
e_type *user_state)<br>
+static int smu_handle_dpm_task(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_task task_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type *user_state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm =3D &amp;smu-&gt;smu_dpm;<br>
@@ -1743,10 +1760,9 @@ int smu_handle_dpm_task(void *handle,<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
-<br>
-int smu_switch_power_profile(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum PP_SMC_POWER_PROFILE type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; bool en)<br>
+static int smu_switch_power_profile(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_SMC_POWER_P=
ROFILE type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
@@ -1782,7 +1798,7 @@ int smu_switch_power_profile(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-enum amd_dpm_forced_level smu_get_performance_level(void *handle)<br>
+static enum amd_dpm_forced_level smu_get_performance_level(void *handle)<b=
r>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
@@ -1801,7 +1817,8 @@ enum amd_dpm_forced_level smu_get_performance_level(v=
oid *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return level;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_force_performance_level(void *handle, enum amd_dpm_forced_level le=
vel)<br>
+static int smu_force_performance_level(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e=
num amd_dpm_forced_level level)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_dpm_context *sm=
u_dpm_ctx =3D &amp;(smu-&gt;smu_dpm);<br>
@@ -1836,7 +1853,7 @@ int smu_force_performance_level(void *handle, enum am=
d_dpm_forced_level level)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_display_count(void *handle, uint32_t count)<br>
+static int smu_set_display_count(void *handle, uint32_t count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1881,7 +1898,9 @@ static int smu_force_smuclk_levels(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t=
 mask)<br>
+static int smu_force_ppclk_levels(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type=
;<br>
@@ -1925,8 +1944,8 @@ int smu_force_ppclk_levels(void *handle, enum pp_cloc=
k_type type, uint32_t mask)<br>
&nbsp; * However, the mp1 state setting should still be granted<br>
&nbsp; * even if the dpm_enabled cleared.<br>
&nbsp; */<br>
-int smu_set_mp1_state(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_mp1_state mp1_state)=
<br>
+static int smu_set_mp1_state(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum pp_mp1_state mp1_state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -1945,8 +1964,8 @@ int smu_set_mp1_state(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_df_cstate(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_df_cstate state)<br>
+static int smu_set_df_cstate(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum pp_df_cstate state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2005,8 +2024,8 @@ int smu_write_watermarks_table(struct smu_context *sm=
u)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_watermarks_for_clock_ranges(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct pp_smu_wm_range_sets *clock_ranges)<br>
+static int smu_set_watermarks_for_clock_ranges(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_smu_wm_range_sets =
*clock_ranges)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2143,7 +2162,7 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool en=
abled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_fan_speed_rpm(void *handle, uint32_t speed)<br>
+static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2202,7 +2221,7 @@ int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_power_limit(void *handle, uint32_t limit)<br>
+static int smu_set_power_limit(void *handle, uint32_t limit)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type =3D li=
mit &gt;&gt; 24;<br>
@@ -2258,7 +2277,9 @@ static int smu_print_smuclk_levels(struct smu_context=
 *smu, enum smu_clk_type cl<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *bu=
f)<br>
+static int smu_print_ppclk_levels(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type=
;<br>
@@ -2299,9 +2320,9 @@ int smu_print_ppclk_levels(void *handle, enum pp_cloc=
k_type type, char *buf)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_print_smuclk_le=
vels(smu, clk_type, buf);<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_od_edit_dpm_table(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum=
 PP_OD_DPM_TABLE_COMMAND type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long=
 *input, uint32_t size)<br>
+static int smu_od_edit_dpm_table(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND type,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *input, uint32_t size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2320,7 +2341,10 @@ int smu_od_edit_dpm_table(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)<b=
r>
+static int smu_read_sensor(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; int sensor,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; void *data,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; int *size_arg)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_umd_pstate_tabl=
e *pstate_table =3D<br>
@@ -2387,7 +2411,7 @@ int smu_read_sensor(void *handle, int sensor, void *d=
ata, int *size_arg)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_power_profile_mode(void *handle, char *buf)<br>
+static int smu_get_power_profile_mode(void *handle, char *buf)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2405,7 +2429,9 @@ int smu_get_power_profile_mode(void *handle, char *bu=
f)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_s=
ize)<br>
+static int smu_set_power_profile_mode(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *p=
aram,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t param_size)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2423,7 +2449,7 @@ int smu_set_power_profile_mode(void *handle, long *pa=
ram, uint32_t param_size)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-u32 smu_get_fan_control_mode(void *handle)<br>
+static u32 smu_get_fan_control_mode(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ret =3D 0;<br>
@@ -2469,14 +2495,15 @@ int smu_set_fan_control_mode(struct smu_context *sm=
u, int value)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-void smu_pp_set_fan_control_mode(void *handle, u32 value) {<br>
+static void smu_pp_set_fan_control_mode(void *handle, u32 value)<br>
+{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_set_fan_control_mode(s=
mu, value);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-int smu_get_fan_speed_percent(void *handle, u32 *speed)<br>
+static int smu_get_fan_speed_percent(void *handle, u32 *speed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2494,7 +2521,7 @@ int smu_get_fan_speed_percent(void *handle, u32 *spee=
d)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_fan_speed_percent(void *handle, u32 speed)<br>
+static int smu_set_fan_speed_percent(void *handle, u32 speed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2517,7 +2544,7 @@ int smu_set_fan_speed_percent(void *handle, u32 speed=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)<br>
+static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2535,7 +2562,7 @@ int smu_get_fan_speed_rpm(void *handle, uint32_t *spe=
ed)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)<br>
+static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2552,9 +2579,9 @@ int smu_set_deep_sleep_dcefclk(void *handle, uint32_t=
 clk)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_clock_by_type_with_latency(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e=
num amd_pp_clock_type type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct pp_clock_levels_with_latency *clocks)<br>
+static int smu_get_clock_by_type_with_latency(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_clock_type type,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock_levels_with_latenc=
y *clocks)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_clk_type clk_type=
;<br>
@@ -2593,8 +2620,8 @@ int smu_get_clock_by_type_with_latency(void *handle,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_display_clock_voltage_request(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
pp_display_clock_request *clock_req)<br>
+static int smu_display_clock_voltage_request(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_display_clock_request *clock_r=
eq)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2613,8 +2640,8 @@ int smu_display_clock_voltage_request(void *handle,<b=
r>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
-int smu_display_disable_memory_clock_switch(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_memory_clock_switch)<br>
+static int smu_display_disable_memory_clock_switch(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool=
 disable_memory_clock_switch)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
@@ -2632,8 +2659,8 @@ int smu_display_disable_memory_clock_switch(void *han=
dle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_set_xgmi_pstate(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate)=
<br>
+static int smu_set_xgmi_pstate(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pstate)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2696,7 +2723,7 @@ bool smu_baco_is_support(struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_baco_capability(void *handle, bool *cap)<br>
+static int smu_get_baco_capability(void *handle, bool *cap)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2769,7 +2796,7 @@ int smu_baco_exit(struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_baco_set_state(void *handle, int state)<br>
+static int smu_baco_set_state(void *handle, int state)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2854,7 +2881,7 @@ int smu_mode1_reset(struct smu_context *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_mode2_reset(void *handle)<br>
+static int smu_mode2_reset(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2875,8 +2902,8 @@ int smu_mode2_reset(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_max_sustainable_clocks_by_dc(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pp_smu_nv_clock_table *max_clocks)<br>
+static int smu_get_max_sustainable_clocks_by_dc(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_smu_nv_clock=
_table *max_clocks)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2894,9 +2921,9 @@ int smu_get_max_sustainable_clocks_by_dc(void *handle=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_uclk_dpm_states(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; unsigned int *clock_values_in_khz,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; unsigned int *num_states)<br>
+static int smu_get_uclk_dpm_states(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *clock_value=
s_in_khz,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *num_states)=
<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2914,7 +2941,7 @@ int smu_get_uclk_dpm_states(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-enum amd_pm_state_type smu_get_current_power_state(void *handle)<br>
+static enum amd_pm_state_type smu_get_current_power_state(void *handle)<br=
>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type pm_=
state =3D POWER_STATE_TYPE_DEFAULT;<br>
@@ -2932,8 +2959,8 @@ enum amd_pm_state_type smu_get_current_power_state(vo=
id *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pm_state;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_get_dpm_clock_table(void *handle,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct dpm_clocks *clock_table)<br>
+static int smu_get_dpm_clock_table(void *handle,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpm_clocks *clock_=
table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -2951,7 +2978,7 @@ int smu_get_dpm_clock_table(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)<br>
+static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
@@ -2971,7 +2998,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **=
table)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_enable_mgpu_fan_boost(void *handle)<br>
+static int smu_enable_mgpu_fan_boost(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context *smu =
=3D handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-- <br>
2.29.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C14fbcd618ad346544e6208d8eaa3e199%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517336878050566%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D27i1t6T9kwjKHp5gfPdmiCBcFeGVbPGqkLBoCBo3T1Q%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7C14fbcd618ad346544e6208d8eaa3e199=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517336878050566%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3D27i1t6T9kwjKHp5gfPdmiCBcFeGVbPGqkLBoCBo3T1Q%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4491FB47C04FBBB17EFC14B0F7689MW3PR12MB4491namp_--

--===============1202684129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1202684129==--
