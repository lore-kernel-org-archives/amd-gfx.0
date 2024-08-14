Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA9C52D7F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 08:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF4A10E43D;
	Wed, 14 Aug 2024 08:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ucU1eO4a";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964E210E43E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 08:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssISRfSEoroxwv8Ua2dOCo9aNqO2ARfBXHGGY+pSTabcaciQx5Qqxwx66jKYWpz6KkPX9e34f3U7dFGWCFiXH4w5dnmbY3AkcjHYoZq/BnVyVLZTGvQSEZjBEwj7MfokOxhi6DDfY/9c7WUf2VwoP1goK3hjYajauYwJVWzli1D1034j3beebuCsdMeOXuPYEudE11RUUGHnvrfvAXJILza/MY53Tm44sM74GjDIOFDV4Kyl1E93Zi4hJ37MbzO/AOHnCWTbBSLY/4FumDpPjzrFoUTNFHtm/H5Udy6mI2nVB4Z2U5VQaw5V2iv5PHx7O3gWyMPnlCLKmixVn9SdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdQWxppQVFdolYmLD6NzwTt5/TdHmzFC+jU0X2oKXXE=;
 b=a+67xk06EHozBQoOLAk3pHNgnAOhGGUp1sdU7SXN+EKuJ0fWuDAz96b7pzRwUBDjcbBtgYh/h8a7jQw2COfpCz4RJ6bX50AgJP/x67Ca0x4ClLrpwfl+vJemV75qVrfzLuLWl+dElObAzF8LygcPhftHmozT+QIsxMVGAQGAufNqUhPZ4gx70pmaDlnJ53kZZXMXJpHzrSVgCMKi6wsAdITaZrR7f1YJcycVQjnDL5R9QEOOn7kmQQIHGO+W63jzcCIF+vfEv+HnkgTDiPL6XaBqTRq1rtoVBcCz0zpUazdRm5DKVGPdM7PGH8eGmjhgJT8r/CT1yY2DAZR+JyrcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdQWxppQVFdolYmLD6NzwTt5/TdHmzFC+jU0X2oKXXE=;
 b=ucU1eO4ax7xLOwz4BQkWgZPCgng+iZKUKehpUhKoz5zzMSOdCHNZwHuYcyCJ1N8Hr0Ov1NHW9ONxVCFUWoeNmLVyaPViR6L6k9g0PY99cZbH+p75r27jjPiZh5rOxWW25zbtjeKuM/BQxyhf/GScTZu/G0vx9NHrJPpOhlaRGtM=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 08:59:15 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 08:59:15 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: ensure the fw_info is not null before
 using it
Thread-Topic: [PATCH 2/2] drm/amd/pm: ensure the fw_info is not null before
 using it
Thread-Index: AQHa6i72L+yQpcTG/ky1U7SZDtztH7Ime9iQ
Date: Wed, 14 Aug 2024 08:59:14 +0000
Message-ID: <DM4PR12MB51520300686B76D103E45F69E3872@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240809073425.54632-1-tim.huang@amd.com>
 <20240809073425.54632-2-tim.huang@amd.com>
In-Reply-To: <20240809073425.54632-2-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0d529d71-7b8a-447a-83f6-13e8853947f7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T08:58:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB5664:EE_
x-ms-office365-filtering-correlation-id: 2b608355-93af-4352-b881-08dcbc3f5f6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hzRi9MgymtY69rui1GDA6zr6uzeGaZ9Yyf5QffTZxPaSU/0qxVBFAzxv+VLy?=
 =?us-ascii?Q?uFf7quaVCRnwETeuHuaDcmPIFrJZJMgyunIJwI06DnbRLQqR/8BI2HtkMEI6?=
 =?us-ascii?Q?eKG813YjjE5YlMr+3rd9DLJNmXqAv4wiYFhZMdcc04eRKBfIBzn8YRoS+sMH?=
 =?us-ascii?Q?uOX3rKfH5qmxwDKCITPBqfHXoFLAc5XEKBP4Hx0+c9IpnxjpHpaWQbBwCw35?=
 =?us-ascii?Q?27OEQk3XyGZyKndf2qg1XMS00ePuWT6jxAcWGsOhjdZzzuyssuZ69FqLXiN3?=
 =?us-ascii?Q?GmjfbYXspGs4TpLxNtKa1Hk8sZlKLItLmP4TM+qM3B4ifCUWMhLFVjQKF0qI?=
 =?us-ascii?Q?YP8zxVnO1M82jUhPFBX7F3gNeeT2sszLVmDdX7gdMPM7yTKBRiq4tPfFRJwl?=
 =?us-ascii?Q?viMlfhZJG65ATISrqzJWKTkli9UtB2x0iN5L3H47I39vCXUKf9y4szlMpY7M?=
 =?us-ascii?Q?216zLBmeqJnqNxEINFS/j30FVYBWQ0oarXsdiVfs8YdH6YXByvEhANeecYl3?=
 =?us-ascii?Q?7ag2yCFNt6AwdpZf+OBUUfDlhdn+XDlQLIwhCUH8W77fHzr+FIgBk/tvZB2Y?=
 =?us-ascii?Q?gHk4sktDwRAuGMopU+l/PaMACWhS696uvsdZmlYEBUOXzlB3//5nbheV4Ngh?=
 =?us-ascii?Q?boDiSDmf1Q69OKhamZO0MWqiBc8SKN4x3S8QPpwFaPihaBKbUHRrHXZKgr+v?=
 =?us-ascii?Q?3V2k36BKGunYqkSMuFGXHYBcoWpoW3oPLktuLnIhr5KhefwG+LE9W3XzSBd0?=
 =?us-ascii?Q?nyaae18TbD7DEYW87atNRw9qtOhEmEKkaHXA5a+QL7oyh3FQu4Fp6/3pQDZp?=
 =?us-ascii?Q?lFJUkhfvYwn2GXdJcFAy08UHz44H4LaSGrCIj6mEFMYbgmcpfaupi25uWoaq?=
 =?us-ascii?Q?fW8kfcfNtL4zutJSXwWK0R6TIT3NKOl5OqdPBKRMT20qIMmoUIM4UWgUlzxF?=
 =?us-ascii?Q?HJ3OQAJjw3Wr9OMSQwyhooClmO9mGKJdiDT1x44zEW4lqVcjd87kkEEnBNDv?=
 =?us-ascii?Q?UEyal8dd2v2g5SF+08TuhuO8uD/tMLMpihKRWyINyYwGKBI5WGD6NOMMNVqF?=
 =?us-ascii?Q?kXudxqVyRKTxDHu3rel+wEUpKQt62/50HWsQlSRw4U+hAsI9B6dRETC07TyJ?=
 =?us-ascii?Q?l8NObM+cZoDaMwv0IBD295d7tg/xbS0sghKMGq+SIaRSQHpd+/6qdqNwuQ0n?=
 =?us-ascii?Q?wN4+vDuZjdIN+b4bSUi1lDzWYkCooaczk0z6FBNQB9ZraDlyjR9OSkIMALnW?=
 =?us-ascii?Q?kO52fYvoaSUX3+TI/rHn3uaswo8kBJlIVXie+5wwj6PD4JUBaMKEhuBHB4Jn?=
 =?us-ascii?Q?8SZknPqY2GcdF7dWXUA2eDu4quu+Lwv2TMwEu01C/G0gO/qyLXIs7nXIzhZ/?=
 =?us-ascii?Q?/lyx0GGk2LJ6S4XLu/MKh3y8kKyZyWBq4f8+kJnXyI3ruXuoqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KiX1FvPfa4Dbai7ZvimalxRapdgCOcH1cuZwVGqfdDTBUS/fxjrIh8BDXqmF?=
 =?us-ascii?Q?1avV714o/JxpSzIUanWSLjeQjLLZWybw+8J7wFfKXBPvN2xwoGUlGjnrBzoD?=
 =?us-ascii?Q?R3SMptJ5trxaEgo3iFFGMxogzBCO+NG+LO7P1LwHxUr7tzTbE6MUKQcEFXsK?=
 =?us-ascii?Q?rz4kopF0VS8jZl52C67nt/8MFbcLwCV2GWdngRNolkln0Kypr6x5ueeDeoW1?=
 =?us-ascii?Q?Q8rjgMG1wa0UB4DvwP6OW7YA2+ik/F8dCgf6Ja/5N27EIrQWmPKHqcV2L2cu?=
 =?us-ascii?Q?9Bg/YsbQh3gqzZ7QJGNa6q/stCiBATKeteJ1SbHkzf9YAzAv+x6pHw04Iycx?=
 =?us-ascii?Q?/xsSTsCAwt2dDqFGtDCL/calmLBUjPnx5FTQyfQUWtoyda7RhJ076EkMoPTJ?=
 =?us-ascii?Q?jQ6RPEtAESJScl3sFqS052ihoz5OaVMejG+rVKBoEnVkzRD+Ie8c3slNiEdQ?=
 =?us-ascii?Q?yMUKWEu4K2xlreo70bdXgeRTT6xaQ1XqDP+Qg7yIaZ5JqOPq2++3antsHKzl?=
 =?us-ascii?Q?iQ2DjxRWg/T7pK4YQRiQyvziye/s4hRNC74hORydrj0xxiCmmJgDWH7qferr?=
 =?us-ascii?Q?4Erz3IYQxFmBhsLzNcJD7GqST+pBItfhs4omtZ250RTwR60ppWPdQxHuT+aK?=
 =?us-ascii?Q?ROeNXYS8iS1kvM8j8FdwdqCnGHtWnMfJwceZBLcmSrrt+3/Mfh9VsooAg55h?=
 =?us-ascii?Q?pMnJU73sYITFcCWUlQu2gZuUfsYBRk6HzV5cjeFZ6sOaIAH8lUkS7vFh8izm?=
 =?us-ascii?Q?pY5WzXs5H1VSCGeSRBLzZnPFXnvuZqTdAsVsy/2gd1Wm1uDov9ch0wF1ztZs?=
 =?us-ascii?Q?jkalV7yxyKzc3r5oy1BI3D3psVrSsgodIPG3DsB9mCGYFUJHf09VrJkTNIE5?=
 =?us-ascii?Q?MqpVTkKcthdmRKKMha4hNubGyAUnvqYgyc3NDSQPdAQZGeM70nFwCAD5t7Cr?=
 =?us-ascii?Q?H8GioljLmdqQrPyaePprqFNMIgKW2V1Yg/dHBwSVFFy0OhOiGBAhd9CQQ29g?=
 =?us-ascii?Q?KJt38bCmqMcE1m5pS9zuA7n/nUnHaTW545kSi53JSs4fXgqWwikFy97ihPGN?=
 =?us-ascii?Q?UquOsXTy9NIfUpqCLVOVrhK1stM11MhVcGk95C0+VUlh0MdlgOr/1HRaD3Mj?=
 =?us-ascii?Q?ayuI8+3ZBBbq3X+XG97QsH+mJGnyBHb9ac1M2nZyrM0fdw9RQ9qxsG7y7JAc?=
 =?us-ascii?Q?e0cYMcMBVUwMt8B7Wh+CM66JkYuQsLARyUFdGqdXB/A+D1LaRd4rVpJQkZ+c?=
 =?us-ascii?Q?Jznb7hljFlwrgYIZcDfiHnKrLP7xMTy/9h/3bVvoZB4gOaqKuSYJBGUsRCQ0?=
 =?us-ascii?Q?Geh8Oypvtm/kJRqUuCNFwGwzTfgkcrgbMCPclKn6tDdLFT65y3AcDJyJH6TC?=
 =?us-ascii?Q?gs0N+ROr4LnLQa+rHbIOrvj8D8jW3G76JM8mX8r1VXU9zoWlXRq12TL1tyA/?=
 =?us-ascii?Q?jSWwKbyFk61Y6GJSWSOpNgawHhfgZpbEwqB54CUtKowMBCeopnHkJ1ZaB7on?=
 =?us-ascii?Q?oPWtUdNEMCx4BWVMldcvSeyns+oAHkiKC1IqD/2bRlih+12Wsz0T0y7SoJKx?=
 =?us-ascii?Q?Wg7Tjyk9lcx6KxGjjKg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b608355-93af-4352-b881-08dcbc3f5f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 08:59:14.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtRB+8BzNub7drp3/5h187LVD08aEBkR5VmSXGilTedHDVLsNZtAJhrOmkLOfRMQnJ+0+ccV4tCh8tgoHwRjWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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

[AMD Official Use Only - AMD Internal Distribution Only]

This patch is
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Friday, August 9, 2024 3:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhou, Bob <=
Bob.Zhou@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: ensure the fw_info is not null before usin=
g it

This resolves the dereference null return value warning reported by Coverit=
y.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/dri=
vers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index ca1c7ae8d146..f06b29e33ba4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -1183,6 +1183,8 @@ static int init_overdrive_limits(struct pp_hwmgr *hwm=
gr,
        fw_info =3D smu_atom_get_data_table(hwmgr->adev,
                         GetIndexIntoMasterTable(DATA, FirmwareInfo),
                         &size, &frev, &crev);
+       PP_ASSERT_WITH_CODE(fw_info !=3D NULL,
+                           "Missing firmware info!", return -EINVAL);

        if ((fw_info->ucTableFormatRevision =3D=3D 1)
            && (le16_to_cpu(fw_info->usStructureSize) >=3D sizeof(ATOM_FIRM=
WARE_INFO_V1_4)))
--
2.43.0

