Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C9CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 03:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFF110E5A9;
	Fri,  8 May 2026 03:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkkS1f0R";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A8C710E5A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 03:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYbE0/PL4fs63XzIPgiL8ssDYoCqohjwjPBTaIlFs8HrXOq3GRWVJgMHHhFqH3fOePayUlaAM6i0zgqAzsfko+P5wL5Mo6siR8qbKLWwUp46/T0+val8OQwy7FUeoA6Plw6VY/TA7KtTxupOWprEXMEYeN0QXqsv1cKgpRn3n/AXCbbUI/MT5WDvk6Op5+o/GGtZ4XxHpxgSAPZffWQ4yvY58+wxGhsoJWVcZvh/JdHw8qGWbASd6bXnYHx54mytsgsYG9sUlV/c0cvZ7Ym0CTw1oe7maN6a/WLJeEmHfoo/yn/nAINmDTs03t3WATb3CjZxogex6D0Izey0u2EEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwtsEfgTyg8ymCXqB7g+crCZo+iW7zowQ6A1tGyUSKA=;
 b=dQGyQo+7VqgG40PW2OPTb/jX0Yjx4qq8UodTpQrG2vL625M5W26aQrJv27h8Fbx5/gMld7eM4TZuNgQ2zHhmoRfZ9B4ihTVSjG8qxbDxjaKVeGihPj8s+sINVDs13ntuqTi5AvfRevhjzaYUEyY4GrEKq4AQUQYlMi9pMTZz1hU8Q4tfSvG6bLkAoBkCTRiXgXGqP+I58v5PJeznu3W9kn9cMwnZy3QcGe3oua1P/uOXGvrMspXL2WmSILqgBsJEW5yHyN9TvB+ZHOFYFSpGzhCLH8KsiLfKIvgbZG3KRZ8TtzXr+w8ba6y19VTJshoYSA7RCJCCUsBYcbzFVSGD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwtsEfgTyg8ymCXqB7g+crCZo+iW7zowQ6A1tGyUSKA=;
 b=kkkS1f0RKc2IjDoXZ9M1DDtWckvmXDlF3rT3ytfp5GIjpB0pDhoTDrch8lTz8oqZ64rXomirB4Ch9RI6cvVU10AN5RESp1BrCpOUQ9CmUwtOLN1lkdONDNIx+Tui5RIzaZnKe6+X5zF5gibSv3w4Y/auatUBNmzH2V0h9kUzMCI=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 03:57:07 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 03:57:06 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Topic: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Index: AQHc3pmoE68lzqamlkOeKSKtCRwg6rYDfqCA
Date: Fri, 8 May 2026 03:57:06 +0000
Message-ID: <DS7PR12MB607129C7685D7FE30F7272EE8E3D2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260508032019.1617320-1-kevinyang.wang@amd.com>
In-Reply-To: <20260508032019.1617320-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T03:51:13.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MW4PR12MB6949:EE_
x-ms-office365-filtering-correlation-id: e62d7a3f-baf0-4fc8-09b5-08deacb5df2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003|3023799003;
x-microsoft-antispam-message-info: 9ds9W5lnnJD6Z3uuac4C486QplBHByvcq4aHaO23noCyHQDmXImksR6rDpqWcw2jvboBN59iMoXyq9Gc8iRF4IFkfdbLd0IeD0iOfMVlH4A7LrjDH0ew/ZenX4/JNRpQjpsDfpvPjzGbPTDU/VnMmwD4/tQs1bGQc4phoF5cTQfjAwrVBC6mBTCOQ+3VgaPkMmWC+UIijKkrp0Bt9MovXeuOwixLZ/wLy6baJOVhKbl6A6vyvFDuZjVJ9AA3XkLGBwJJq+evZUDRMcgJg2zQe9ITEKQJeu8m6be22cbLnO8DozvBGUrpiefNpd3KLHq2SOJFPH4A8+b2TWQ43C3p1up91LuktJmwhSWx8Js8BxDIo3w+YhPYfB7tSCfbeN25TnNS434j/EHy5VYnu+Mb28jQj1aRa8w1P0Wxs07mola+sC1t60TG+G43kOVUIYOzdt+6H1nG4sQTMgPi7UXzdVr4AO7B1gFdXd2VXVcuBIYxpeMBEVyEnsB8ZiEKKEBWbYiHRep6QuSyvuPfR0d6KhQOTwxiD/241lP4P5hWWh+09vBkl+wp0j3iTqkYAul99wMu7j8BG31EUtJJfD41Cs/thuLWmGHqHX53MqLXQh06tedHuy9dOU40ruGM5ASvicH+bSOJLcX2f7Wz6jqng3dlUPsXrtlkttJQVYhCy8REKnSDSu/EN+/Pbj6sILg2IHMZD+C+lQ+KnHtK7+mSimr0mdbxAGsGnKaHgTjt/SoihG2CPqDwYp3OhpPqB1yZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzcotrBeAANani9dUvVyi/5ipCopfUSXnBHH1bfonqMla0cbyZwwXUX3ICSl?=
 =?us-ascii?Q?VJWGsj1gFzv0LCOO+OhS8fnGLZQA3phfYbVMcutEoee6T5xJ9zyyiDT4X2Qg?=
 =?us-ascii?Q?8B7y7suCg98kUEt0JkclC+OOHl5IRctCHK5/D5rQJpCxX7cZlC4/SVbHe20N?=
 =?us-ascii?Q?EDPDr8OvvLrC8+HBG6iLfTijzTtbO4RENUQnlhSJBDIGNlupI50TgL5FuhGA?=
 =?us-ascii?Q?14ElZXfAsyyqzk6rdsJNO5VM+VpS0fivthcIN8KiWe7ImE2LtbPHktiHHiqO?=
 =?us-ascii?Q?7rGtG1otDND87uIrl6Tt6HG5jtgy8ec2pSGGDVFnUwXXSt57wHypnZongXRu?=
 =?us-ascii?Q?KASfGpBVVjdqGL82KxuATRIjAxwORL4Osf/Mx96v6RMT7AdcKnon4Kj6flZp?=
 =?us-ascii?Q?onAueKxKqZWpk7ZGaw/MqlMhMYvb2wAbGE+0kFcIrkMZegRCh9f615E9ChyY?=
 =?us-ascii?Q?wow/ZK7f/pd3hctzq6YK/XHLwo7bbBTfKt9BxsSrGSP00s6G7whYq4ecuMh+?=
 =?us-ascii?Q?aA+Vsw8fhOXnhpsW4ufG0wBYiG6brYvPEEQeSWN7EcKod+pLIkNV6gd65mZo?=
 =?us-ascii?Q?44toe1xUG+sXVqyDayHfqgUd0rAf27v+8cfY9LWi46r1qHWlypt7sE4KCjZS?=
 =?us-ascii?Q?EDSnaGzXBQ4G3epwKW41WjH+dGLcHEuWP+2ESUmbUxN01WZy9pCiOBJVBpdb?=
 =?us-ascii?Q?/jPc9CZ27qrNiHTD/gfRraS/lcQgggnCJGGVmfrZtVBdC4wfb0b6eXL/Xy9Y?=
 =?us-ascii?Q?s1s+IkOkzg2SUF4zPIDcPBY5ETRYnwN3tAjjSkYmbM/LOpbWjfkwFwmQfhHn?=
 =?us-ascii?Q?uHdI6+51oEL1p1jPtuujxRghjb7oe3RR7wqSzWpU1TQFUNUJ51FYDoky09fU?=
 =?us-ascii?Q?GpDV3Ue7s5xkvJhP+9L8Y8zUhs/hxdBfsh//9QkjhCwNVuy9hrpGf3tb0cK/?=
 =?us-ascii?Q?f5wHMlLZ7eRz1srMd8jDPxM1kQhqMEE/QjzLuhcjPbYHnQuvH1PHInOCmMWv?=
 =?us-ascii?Q?8jzzWDxNGw6F0KcH8qGkjzxAaeVpOfZXKaRa1UoxfsO2QBLYl96u4w/K0vbw?=
 =?us-ascii?Q?XRTw/VTONmLrktylGnBgIQ5iopgVNcNT/XOYMC4p7zOnR5wqA6keIbQzBJzG?=
 =?us-ascii?Q?XtiDaolusIHKG6S3OgI+onSW2ceHXbEJgSHl4y6gIMiMNj4rKICLiNMtHqG2?=
 =?us-ascii?Q?bXY20IGwUYCa5J3Jh5QFKJBvziR3jNwTQq/KSRi9Mrwrp+1k05Gqmlo8/eHW?=
 =?us-ascii?Q?ldM+/qXxk2bvxliInj+MD/3ccrUdOJcQ8PyUnsKKLxTqZY8zRc4ir64L9A9U?=
 =?us-ascii?Q?/cj+EsyVaR0Ed+QoCOl0r+OTTLfwhT4YJkFiZSjiZnGb+SEa4fM36zAw2IaX?=
 =?us-ascii?Q?hcl267hQ7QWTPUeGPtWag3F0E7EjZIL1W6U6nJ19aCUmTXLB/xSJAKANbOv1?=
 =?us-ascii?Q?T1XmoGVGmvXNV8zY+eEKvqeMFl84QF9PljXo3bBx2XycbT9XHzznIhXi9iQ8?=
 =?us-ascii?Q?heNoUyxaXMNJ2/Ly+fItE2WhLfEDo4DPIfeYHSLJXGnvB5Zd1CM27ry2aQQA?=
 =?us-ascii?Q?psAGq5ULbXIXRktIx73HhwulDSUSpRVp9RZAKOLQHcD6Y8JYJX01XcBHtDDO?=
 =?us-ascii?Q?540+GPQ2s167P2aOjUvfqJXi223vfA4ayhYCa10J6KIuN/TRafEE5/f5JiAO?=
 =?us-ascii?Q?iUhC/4lX0cq/UVLr4ijmc/4iTJUjaZKbWLci2pdweLtl5ckQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62d7a3f-baf0-4fc8-09b5-08deacb5df2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:57:06.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPCrPAXAl5bV+EblT+LVTeh0VORzg+a7sghJ2yuCHfzX/GVZFJnGLZ7ioT6Mu8Lukt53+y5CFFhy+cNedeBemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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

AMD General

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, May 8, 2026 8:50 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran (=
gc 9.4.2)

Split and correct DPM clock attribute constraints for GFX 9.4.1 (Arcturus) =
and 9.4.2 (Aldebaran) ASICs:

- Arcturus (9.4.1): Keep restrictions for mclk/socclk/fclk, update comment
- Aldebaran (9.4.2): Add dedicated per-clock constraints:
  * mclk/socclk: Only support voltage control, disable level setting
  * fclk: Mark as fully unsupported
  * pcie: Move multi-AID check into 9.4.2 case, disable level setting

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index fd2e63530e8c..9ee3053973cf 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2033,16 +2033,11 @@ static int pp_dpm_clk_default_attr_update(struct am=
dgpu_device *adev, struct amd
                       gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
                       gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num=
_vcn_inst >=3D 2))
                        *states =3D ATTR_STATE_UNSUPPORTED;
-       } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-               if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
-                   amdgpu_is_multi_aid(adev))
-                       *states =3D ATTR_STATE_UNSUPPORTED;
        }
 AK: With the global pp_dpm_pcie block removed, amdgpu_is_multi_aid(adev) i=
s only evaluated inside case IP_VERSION(9, 4, 2). For any other GFX version=
, pp_dpm_pcie is no longer forced to ATTR_STATE_UNSUPPORTED on multi-AID. T=
hat includes 9.4.3 / 9.4.4 / 9.5.0

Thanks & Regards
Asad

        switch (gc_ver) {
        case IP_VERSION(9, 4, 1):
-       case IP_VERSION(9, 4, 2):
-               /* the Mi series card does not support standalone mclk/socc=
lk/fclk level setting */
+               /* Arcturus does not support standalone mclk/socclk/fclk le=
vel
+setting */
                if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
                    DEVICE_ATTR_IS(pp_dpm_socclk) ||
                    DEVICE_ATTR_IS(pp_dpm_fclk)) {
@@ -2050,6 +2045,25 @@ static int pp_dpm_clk_default_attr_update(struct amd=
gpu_device *adev, struct amd
                        dev_attr->store =3D NULL;
                }
                break;
+       case IP_VERSION(9, 4, 2):
+               if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_socclk)) {
+                       /* Aldebaran mclk/socclk DPM only supports voltage =
control,
+                        * not allow to set dpm level directly */
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+                       if (amdgpu_is_multi_aid(adev)) {
+                               *states =3D ATTR_STATE_UNSUPPORTED;
+                       } else {
+                               dev_attr->attr.mode &=3D ~S_IWUGO;
+                               dev_attr->store =3D NULL;
+                       }
+               } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
+                       /* Aldebaran does not support fclk dpm */
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+               }
+               break;
        default:
                break;
        }
--
2.47.3

