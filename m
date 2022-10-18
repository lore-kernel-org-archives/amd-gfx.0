Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B06DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 03:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7679E10E754;
	Tue, 18 Oct 2022 03:01:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C539E10E754
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 03:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsikpEJvy4IHso7sPRPP4UinstRZTL0/oB6y9w84RlbZFKLL8HpMDGu4YXmnWI15Af1WeGccc/wiUU5+ntBEIvfOM6L3MDzKK+HNqg9v4ntvziX/PDR4tJgyjK04m7l4yVl1XGYhebvwTQC2VIdUjuMsccbGMmj5baczIA7VLrDlXY+Q9yfM8MMFCDzjF0YZxaOx4h5XM6PqCnSAuEwZ+hu9ZjgTDfyWaqEiu9FN/cL6ZCcS5BJPGtXPOL+zJccOfvgtlIL/e6clU30JYyg2hvDsJBJ4Kgx1uafK0vbH0bNSsNbaDm0mpLyrfN5/zSeI8cOzynt7e0lVXSNwgz40OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn4DI/VPwfcLwZQnXxt4AP/KndceH3ZwBsKsEVa6yx4=;
 b=d/VZQbHS+1csuUt0r0ySItFy92MFcPTcSycXFjyEWoPgF+IbZlRQmJUygL0SvKlvJPdkKlvWB/iHJLKDgkje41kh30n7wPHMeWuMc9Gvje/xCjLKgK4e6HWjEPZgXHeeosM97Ad7p8Mdj+ezlyHrR6qpf72z3dPnqjc7UGvXvsKS+yyMD5EMJlc1diLTsQTagmH6R1jiBopjXmdXWlHZVMWGp71B2bOnKbpZTTAbwPfvPbrKceam0/uxx5Un+Jw8yDett6wbBExeIxe74Kio+CWq3DC9oXoROh6RT/JduhAwqIM28WwXNaNNYScRLbLWi3i23u9wfokxlnUdxbD4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn4DI/VPwfcLwZQnXxt4AP/KndceH3ZwBsKsEVa6yx4=;
 b=hlR0yMy/FHKcW9xxj90oiO3n7LSdH0MpQyNrpx0DTO0jC5fqfJ301gn/DbCW0XmHTFsG97LWHJiwbYSjkmU8dcySxdkqtkX5PAqbXw2mMe5swMk6U/LoSLTwwU/dyLtdDkqD1ItZaHwoTcY9zuAub9lvBpoWZSa1I7QhIfcK8Jk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 03:01:20 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::78b6:27fc:c590:d2c0%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 03:01:20 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sienna_cichlid: drop unused variables
Thread-Topic: [PATCH] drm/amdgpu/sienna_cichlid: drop unused variables
Thread-Index: AQHY4kg6NoRVACWQF0eOApPy9vIOqq4Tdw7w
Date: Tue, 18 Oct 2022 03:01:20 +0000
Message-ID: <DM5PR12MB2469632EED4F51EC38416375F1289@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221017164731.1277472-1-alexander.deucher@amd.com>
In-Reply-To: <20221017164731.1277472-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: ea9e92ef-4a00-42ce-bd85-08dab0b5088f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbs0p/upFkraYnhou87Fi4xoPa8fZ6fAQREe7nCxNCrK+oCRe+FvlcEH6/dmzU4vT07aWo1TwL9Y6CUedImMMBuC7GOXSU2nqsIdmfk/5d7twtUsv6W1bvhS4JHIEx4PiOkuOx+vnZF3KJya/3OeK0QvRVE1VPGYxTG6uA2KUoV3JfxQv913pofHiOulUjS/5oqNVItfx++TCp/05m03XCDM7e+1exVLaQsQPVl/rXDLv/9vel+c6I5HPdVjfK6neV8EQr0Rgz3ZEWK+cHsgi4xfJM7iesdwP+esBZ5pF7+Twvrg3/ybujaOWDlw9nNYTQSkwrCAg2VNkTeK4MDbDVQaSCw/Vha2WxbooHjDl4NkOfJntvG/A4z8udFiM0aPjRLxOiwrHkvVvAvFWJHYehjEDMW6nvqlQNZbyDQzhhI+2k34GCm/FqLYCGaehSViaMiYCawO7wEK8YnR6EGc/ZIIfpQn0wF+mBpB92SK8JB1NoxMRfT/NG6UtkCDYP4jNjBCuVNEUDA24vtnP76wIDnEaF/WysE4/OiJ2oo3SYVADqXlCuKQBUCtK7Qog+8MGuKxdGyUzxwMEYTv+ccQ50Wf+cd5QSxejPykdBiBtUH7C81qcn/P1B6My8YnPeVQPqohPg4awPnVo+h0UenwWN1NCXsdO8R0SdGe6in7YWH5k3DnFtqWCUkLvXM4mpBWu+Oau5zDIJkBDLMhHcmbcaIK1yOBo74jn8Jge0tJ1SCaWuvbNeOXhsLl9LA6bnopG0GnbhAtOMNACN83CkgD9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(316002)(478600001)(54906003)(71200400001)(66556008)(66946007)(76116006)(66446008)(64756008)(4326008)(110136005)(66476007)(8676002)(52536014)(7696005)(6506007)(53546011)(9686003)(41300700001)(8936002)(26005)(186003)(2906002)(5660300002)(83380400001)(122000001)(38100700002)(55016003)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?joPthDwBi3Md1Id/xmjP75TGnzpNUfswm7YKf8jt/C3P0rk9Sy5wtTUyY/dB?=
 =?us-ascii?Q?hS1AgXxRIa5KG0ZSPlxTdwvsz39eHeWPmjjmq6NSfRKNY4o9AoGJ/wfaDrOn?=
 =?us-ascii?Q?cSeyIDi/yTrFvte80mUEzgnyFUAEpHO4unxBW22a4oN4bKm5XT9EW5A4NNMR?=
 =?us-ascii?Q?sD8k7VZv530kzHQ8o/l+sSTGiPoIZQIldD8FSGzZZ1f6ZU8TfXNYSdohI+7X?=
 =?us-ascii?Q?YMMSTm7YJSx2zp3wRgd6nqRyeJ9kUOTkdiS/nHiWqBkrjy64sCZJJv6lWmDU?=
 =?us-ascii?Q?11yG5TloyQc0abRhxb/95mTNBxz/SnoTcnuUZT/Jz16cUKNvxs5wnfRAfR3d?=
 =?us-ascii?Q?XN1OzltC+lWpYzV+MdlU3n5quB1jdbd2swPDfHtdeWhp9Zf+xUvd1iSOT9kO?=
 =?us-ascii?Q?wdUdZ+5ky4rHL5lyBJ8jCfz9C+VDKNpxVoHcO9QsMjnoUaQ8OS4LE7oJzY1j?=
 =?us-ascii?Q?l9N+TApclTxFt6f1SqLWYTOyuoE6UoB2yyreZky2LwYRNCgybO3as4V7JwME?=
 =?us-ascii?Q?AhrAJcGhWdoH0NITXx/13ENrhIQ3jRlVoBU4FiRQChSxd7cPxaIQnMJhCkvV?=
 =?us-ascii?Q?RVADcxPRicLJDgpLQ3uxYbIMjzQHpz7rxXrkvGOU6uY6PIx6S8UlND/JTvpl?=
 =?us-ascii?Q?RFfvbyTQIfdROCtoJF5+bggnlKAqxQv+vhMZ9jk3pb6OYol7nKJJFBQ6EuRF?=
 =?us-ascii?Q?DJdDwSTaLOyIj0qC1w4xLMmEr99zw9/pTegEujy7pDYb0C/qSWXBIBflO76V?=
 =?us-ascii?Q?z1in6TPtyysx4zFj/wmrZGCCi99VDKz1TDQwQHN03T/mr/SZW20JMC/56iqF?=
 =?us-ascii?Q?NEUdvsRsb/cKtAhYp0dCpDcKkg0W9Q726edKDeyoQe6dz+DlZNAaCljXPYe2?=
 =?us-ascii?Q?saRxHHjkXQnn7bROdoaaVz1zx1ufujKvQt0MHvvArER/Wp4PxcktmzuqRAeS?=
 =?us-ascii?Q?Flhga8fcWOMTzsu837JRYz+utMZe1FI4Z5OnyHyuizdNdMFp1yHHkEdGbgrP?=
 =?us-ascii?Q?vT8bPaH0xAdmn/Tg3VrnPWzzO6dpgTVK28mifpxreAsC8Ge1xOQLvRwD5xFz?=
 =?us-ascii?Q?Jwlijzolj7E0a0+uxeS8lXXBppliw+V/s8Qqhr2HzG8Pult+QZzW1AmPr94f?=
 =?us-ascii?Q?b798PJSMLMePEqusogZdYOUD1Qc3gdlWp5JYQN3zL/75+ObFK5lpZQtn4tlu?=
 =?us-ascii?Q?Bjj59JfKVv5GrVE8R4dwA5nweRtssSQ1DF4GcpiVWdCCfck+BasLQ/ZBLGVO?=
 =?us-ascii?Q?SBN0C/PLJvWqEU08yumwptubMbHRxLrHX4sQ47iYeNGemec33E82Q2ZCNsnh?=
 =?us-ascii?Q?0WTdeOiFUWQifCly23f+lFmLPLcQ/Qi+AbfN74NwrgZunyRF6qRUeTx4TiY+?=
 =?us-ascii?Q?Wj5XtQ+lzvhr48gJ52cwvj7A3OLurjcnzC++wPbUKFj4kWwDnrfD5HEGEltN?=
 =?us-ascii?Q?HFgd4JATvEU/LMS9aEN0FuSKfLeF1up2UnTPwk1i13QAwCS2vGSikvcrlwus?=
 =?us-ascii?Q?JSbldcwFMceTu1iJeiR/p+j0CmChdqLJ2dPkYhzYYxJcBTev1Fzsaw5K3P34?=
 =?us-ascii?Q?Ww2/on7qgeGwWYrjRPjQSE/8t1mb3Ao29ivoJjnj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9e92ef-4a00-42ce-bd85-08dab0b5088f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 03:01:20.5084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXglhgZfWeDtSTa3AXlfVxQ5oip74R08oBxbGKBuHGjN+RWNAWranozDzYQ/Qc7ZQKV78l12hjkK9Xq4QxDi8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, October 18, 2022 12:48 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhao, Victor <Victor.Zh=
ao@amd.com>
Subject: [PATCH] drm/amdgpu/sienna_cichlid: drop unused variables

They are no longer used so drop them.

Fixes: 498acd86a942ae ("drm/amdgpu: Refactor mode2 reset logic for v11.0.7"=
)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/=
amd/amdgpu/sienna_cichlid.c
index a096f0b740ce..81a6d5b94987 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -33,8 +33,9 @@
=20
 static bool sienna_cichlid_is_mode2_default(struct amdgpu_reset_control *r=
eset_ctl)  {
-	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->handle;
 #if 0
+	struct amdgpu_device *adev =3D (struct amdgpu_device=20
+*)reset_ctl->handle;
+
 	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(11, 0, 7) &&
 	    adev->pm.fw_version >=3D 0x3a5500 && !amdgpu_sriov_vf(adev))
 		return true;
@@ -47,7 +48,6 @@ sienna_cichlid_get_reset_handler(struct amdgpu_reset_cont=
rol *reset_ctl,
 			    struct amdgpu_reset_context *reset_context)  {
 	struct amdgpu_reset_handler *handler;
-	struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_ctl->handle;
=20
 	if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
 		list_for_each_entry(handler, &reset_ctl->reset_handlers,
--
2.37.3

