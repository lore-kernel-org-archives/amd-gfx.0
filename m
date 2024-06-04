Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3624EC25B74
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 03:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 130C210E2EC;
	Tue,  4 Jun 2024 03:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMQLnQwC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A79410E2EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 03:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7PMJmC+ShRg+T9SFtm2RztvvrJcpRq1grwFY+mE8YDzMxbCkNnpmP2exUqzSXwKIyxcBNUgPVa9Y5vnY6PdwNRr8TD8gZhcEAZR7GvyJu/2ZT844je/q16pZ581kP8XZKHvl7dur0Nk2xbEXT2HVEYwqFAjrtofXTCO66/UuwcYjY7U3b/aU1eafJGp4He2JTARfhG4ZtOhq1Am8hBnIVmZG7/WWtbRAjt9ZfA/cVvolU7G0iLm3+FS/D4rJX4QKNcfC2iofYUmpWlxc/5THJLwD0eXvD5GCm0Qe5vTlTIDSlevWaFbcuSEq6DxqUgPR5fFUhCaZ/Qsgu0UWM7qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBlBRz5BM/eXoJaTlMYoqhZiRPtJrShg61mk21URuFs=;
 b=ANnp7pJHnCvNb81sxO0M4uFO+PbJxUfLqCZIn2AKRXkWYKLVJ1UKBLp2XBtOkjCsfW9XhIl7Haal9oI6uoYkZIBU+9QxO6+qdNKUatsrgOm5zZAyTjuRIbf6faKOHd+KzTlJpHHcUHZStv8dIW6c4uu+yCJgIqs3dP640hml+GIK9rrnbtJvsIaNrnhRlfTQWtLUL/TNiIWMfqxcOZ2WBh2R8hLcetmwvQ9D56eIR/DcmcHrl3kiZKwdj9LvbiuutztISFcnXPoYZSfaxPb3hRJkjmoN7KUKODdeCSWYNHP35W9/yBDTovmyDFHXFwnCG0rwXY3CPdOW3nfzIrOAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBlBRz5BM/eXoJaTlMYoqhZiRPtJrShg61mk21URuFs=;
 b=TMQLnQwCSrkKmCQEIc2DlsJqMxmJaDB0MFO/CU5FGbkNHut8SeFktpvF+DRvP1rF96r4bCFjTXTx5fse3eqAqBnmSGAG9uDXyrJeo3Rc/WdxWcHrWli07n0wTVMw2e7tGQ87EJ7NJMmRGwaf2Zdlf411WkGMs/Q+UkTX1s393hk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Tue, 4 Jun 2024 03:51:33 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:51:33 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Topic: [PATCH 05/12] drm/amd/pm: remove dead code in
 navi10_emit_clk_levels and navi10_print_clk_levels
Thread-Index: AQHatZK0Ej7ZmMphHk6JicZTctqH/LG1wBuAgAEOngCAABbdgIAABS2Q
Date: Tue, 4 Jun 2024 03:51:33 +0000
Message-ID: <DM4PR12MB5152C1D9F255F98E8B7531ABE3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240603084730.2569970-1-jesse.zhang@amd.com>
 <DM4PR12MB601207AD23D14B7BB64B3CB082FF2@DM4PR12MB6012.namprd12.prod.outlook.com>
 <DM4PR12MB515268FF505C25FCC69D0724E3F82@DM4PR12MB5152.namprd12.prod.outlook.com>
 <PH7PR12MB5997EDE36BBA361D761AF9D482F82@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997EDE36BBA361D761AF9D482F82@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=689ec0ae-dbd8-4a02-a8dd-a477a98b33ef;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-03T09:05:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB6448:EE_
x-ms-office365-filtering-correlation-id: 7aff4434-6a84-4b95-7c24-08dc8449a049
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?j0LRCNlMZe6xajqpWYVQpEY5JC/MrYxic3jvmTBsmX74IRFu1RfZXVxKgBsa?=
 =?us-ascii?Q?eC/EopORnFD3YUdM04xHSqhrcse0j3fb0tTs0vWCwXk/EAo7x3xpmGaZFpIm?=
 =?us-ascii?Q?X9sntsz32h8YH6nx2621ffqgpHu1zlQFhYwbGpcjVUZAesOwcH6iJFGl3Gaj?=
 =?us-ascii?Q?FbXqvH+jjJx0roVQQS3bz7vLNyovz+/CZPkWnZzX4mSf/tUvlTK+/R9cfyhb?=
 =?us-ascii?Q?fruOhbA7gmY3WX9TLZXNaZnEjIbTPNuYjZt8Sx7DJ2EOEGFTSCWCYK3NTVfv?=
 =?us-ascii?Q?CNK/R1GXoJWhLkf0RyUAomRBKV+i1SFSqL3399t+vsODh6W4Gv/SJrc/eoCd?=
 =?us-ascii?Q?13OXzEdqRU9Ri3+gufO7C1ZHLbRZcPeoHL1rWSsK4pHr2aIa7zHNDTtEKGxv?=
 =?us-ascii?Q?LKlHz/ZR+uR9DZWa2s39HJklMEGGtvk4dh+d+isg0FUbCjC/4xL3TLYr/UvQ?=
 =?us-ascii?Q?CT6yj3wx/56DWO+vXvYALMkQQtVM1qc6sHzQmseLADbVE/r7Mwl4ZZDlrlM/?=
 =?us-ascii?Q?OQy2MHEhW6LCCqywesULrXdNov0sCGfmJyf7/cJXphdTHmzRahqJIt4EbrIO?=
 =?us-ascii?Q?8Tr5gGyOw1ljg3DYlE9aNIPlZ53kViQuRg4lqjpqunnsttfTB4rMXvkVVKSG?=
 =?us-ascii?Q?qkkmTk5CC0MkEZ1IP0ftBGPYcYqfVysEP1dWxaKubT1M8FzUUP/do6Wa1KMV?=
 =?us-ascii?Q?vk3OKIhZBCfTLe1Yd9y2nD9HpV5UFy2Rv9Z0c5HGu5dhFppMP/yi+g4NKkSG?=
 =?us-ascii?Q?RQ2otxdRhg96prhTLVGZN6p5mMP5m+LgRe+YkyoCODwwJzob5PVekoqt7nnz?=
 =?us-ascii?Q?sLkCRhQ13aQ8ncI6TH6riJxlAzMj/LsMBnfMQETgk2kGVCJ9mG9qj/wCcsMA?=
 =?us-ascii?Q?kKt4vFw/Cj3srxM0A6pbDSD55BYp/AjaIETiP4WjSUvLxQ8FTSV6hKx3B5Fa?=
 =?us-ascii?Q?1Xw+e7/np3lwjI/q0XhEgl2KvzfE0lAob2fTpjnngREbSF7TmfToxRJuN3HH?=
 =?us-ascii?Q?L0ReBIzJJe8+Vekpgr8MJeJrRYkxWaw7vcBv2sjbVlMbQpJ5b22jfIj5dRvP?=
 =?us-ascii?Q?NnU9iAUsm9c4rzTBBmEFn2xxvW74lTjc2LMhNzczCGpp9kaJ0HC1HUNn7+z4?=
 =?us-ascii?Q?3iozpHeBdcGH+UBReZboWx0cFRa1rf4du2Y2Rmmme2w6/vypceEM78o2cMWA?=
 =?us-ascii?Q?oywPdBwEdRqVkMCTFgjVZRLYpfKj+us1qMYo8qF3w5EjcEdvQG33INvQES3r?=
 =?us-ascii?Q?dxUZo7lRkeAPGddnbVVH6HcQlE/VjTJyhIhP9ivIvVuKJAcAsB3bIRMlIZCk?=
 =?us-ascii?Q?r/nEWGy9SNkN3AEn6cR3p9Itl7dAg4qQ3PFRys1qD6mf5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+7koaQGSDGIONbkTyFWOFoqllSkfCeTp1Ccg+E8iF5GpArJmVed5iuRJwzXx?=
 =?us-ascii?Q?IxE65cEzbKvaczy6Uzu59QjO8GjYffgvbQk0+LcPX0NsC/quxI16LUfAU5aR?=
 =?us-ascii?Q?MXbpUL1I/Iu42zPBjA+ApGntNgAcYGf4c98HCsXrl94LoIjC3VETreudT0i4?=
 =?us-ascii?Q?nZ1y4OcgyIH9fsH4WZf3iv7wFW1agtpdDw5zacXC9953NDFNxKspy3k9EQgB?=
 =?us-ascii?Q?6iDtT7Nb+e5fe8l3qaaaLLUdEV9gBdBHuNE6x4QqPcLrINKisg4ug5BYAve0?=
 =?us-ascii?Q?TJzNT9qXvneH+tOF58/oi+DoIvgvQcspVJOkHBx89e+46IUhz2FIMTW8QXlJ?=
 =?us-ascii?Q?i6J6J5S8Tm4KC4dVzPgj1p4LVzZeU36gMGd/lL65xJOryGXCpdZtZl0uGeDV?=
 =?us-ascii?Q?ucuAGktbg+fa4XVeWuchdM4dPh0fW5/sLVO5l+Z4pDlLgiNlpbxrtdci8Tqg?=
 =?us-ascii?Q?xfGT474RM5iPR8v4PVg4B/fljLnfm2IcuQhqKvTKHpK6ISAYvIYiV8mP09OR?=
 =?us-ascii?Q?li7G3gS5FnfygM+gP9I+DEulrmCat3vBpTv3uCTrXYwYRIRsXNtrRns2DeBb?=
 =?us-ascii?Q?BvD43hsAqwNryVNNsuc4dMcNurTs43ZQ1S7efJqcjBh8E5uzcY5PTNsV0nPo?=
 =?us-ascii?Q?fH4J05X0L52kaI2iECbvCj0KxR/QRivDbevnC/PKaLw28JsEeuHrkIKowCC7?=
 =?us-ascii?Q?iyrk2gdA1PKJ4GuM2t3cfvqX2dIVHx9Dw+NPzgg9NEe3qmt6WlcXTxlESD9C?=
 =?us-ascii?Q?YMJX68dzH6DbgE3XVeDdfY9G7RiDLgnDOz72iBaYuO9TCDPs2bcTgRA1vCPl?=
 =?us-ascii?Q?5U3oPoHWViWwFeXiVwsqXurSvpbG2nKx+rz2tOQ3PmYGDK8A1LamNZIKDBmF?=
 =?us-ascii?Q?iwTja5FbWivaPy0lCyx4qIyao7skMOJY5BYv0lrRVcqCUwXpKuOuvf14HP48?=
 =?us-ascii?Q?jcT96FzGYWEfgw8UqRapjIK95MsxiVVlvqWK8xxeYz436x5wr1l8NtIlKXuC?=
 =?us-ascii?Q?F20Pn9L/ZjrEswXrlaXfM6wGa5JOMn9UlCo4H7LqxGak5T9+K0lwLK2cw9/u?=
 =?us-ascii?Q?Y/QPt34oR6+ohenL0ovVFPg7Dh/VxOO7Z2mWKPaeyBbFmKvHLqIZbfDRTG9l?=
 =?us-ascii?Q?MKO2QXQUxyyZU6McoT3DcEuru3KcUlOpZI7yIXXAnlqLboxWqrLJwyy7Jpch?=
 =?us-ascii?Q?OCVbE+ZPna7uvNy18GR9KECuMXtmBx1zx2ViKVWuIpLM2qh543j5/ZeyyoHH?=
 =?us-ascii?Q?ZwGi9yNPOiy72duxsGFExEza2krAL/jEA6ZU0op2iuxQAlyYPyUFXKbjKN1C?=
 =?us-ascii?Q?tTAy0zC22cA+Pe0mC1hKNUi6+BvqJ/z44XAF7lObYZmWUldzNtJSAyT5Cam8?=
 =?us-ascii?Q?yyAQvT/EhGOEsf8Og0h+kPXXVqPm1QZVtYh0qDRXaN/an2lPcxWjMvHXPwFt?=
 =?us-ascii?Q?2EXoeCcWr8o8gUOhv00hUKQAUxdD2W6eLZbj3blZ6fJz0n8ZoJMcwNFYTMrC?=
 =?us-ascii?Q?kqXmvMJ/THoJuG0KGabYH5O/xWXFCI/FkBnBi5wegLHcMPmrBKCqznvyI+Km?=
 =?us-ascii?Q?G6q1o6cLstEeihq3F+s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aff4434-6a84-4b95-7c24-08dc8449a049
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:51:33.6217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQgDQpOHWCMGrlX28SgxyVnH5sSZWcUGQzOufAdWWPx5co56Uj59dneiyA1EE4wjNLjMA2/J4XShrfpYcmaSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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

Hi  Kevin

I guess you didn't apply the patch correctly.
This patch doesn't remove default branch  for clk_type.
In the case of SMU_OD_VDDC_CURVE in function navi10_emit_clk_levels ,
The variable i ranges from 0 -3, so the default branch in case SMU_OD_VDDC_=
CURVE  cannot be executed.

static int navi10_emit_clk_levels(struct smu_context *smu,
                                  enum smu_clk_type clk_type,
                                  char *buf,
                                  int *offset)
{

        switch (clk_type) {
         ...
        case SMU_OD_VDDC_CURVE:
                if (!smu->od_enabled || !od_table || !od_settings)
                        return -EOPNOTSUPP;
                if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_O=
DCAP_GFXCLK_CURVE))
                        break;
                *offset +=3D sysfs_emit_at(buf, *offset, "OD_VDDC_CURVE:\n"=
);
                for (i =3D 0; i < 3; i++) {
                        switch (i) {
                        case 0:
                                curve_settings =3D &od_table->GfxclkFreq1;
                                break;
                        case 1:
                                curve_settings =3D &od_table->GfxclkFreq2;
                                break;
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
                        default:  //don't need the default case.
                                break;
                        }
                    ....
        }

Thanks
Jesse

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, June 4, 2024 10:39 AM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

  CC [M]  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.o
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c: In function 'navi10_emit_clk_levels':
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_VCLK1' not ha=
ndled in switch [-Wswitch]
 1275 |         switch (clk_type) {
      |         ^~~~~~
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_DCLK1' not ha=
ndled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_ECLK' not han=
dled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_DISPCLK' not =
handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_PIXCLK' not h=
andled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_PHYCLK' not h=
andled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_LCLK' not han=
dled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_CCLK' not =
handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_VDDGFX_OFF=
SET' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_CURVE'=
 not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_ACOUSTIC_L=
IMIT' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_ACOUSTIC_T=
ARGET' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_TARGET=
_TEMPERATURE' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_OD_FAN_MINIMU=
M_PWM' not handled in switch [-Wswitch]
/home/kevin/Work/disk/linux/linux-next/drivers/gpu/drm/amd/amdgpu/../pm/sws=
mu/smu11/navi10_ppt.c:1275:9: warning: enumeration value 'SMU_CLK_COUNT' no=
t handled in switch [-Wswitch]
  LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o

After applied your patch , the kernel will show above compile warnings with=
 'W=3D1' flag.
# grep -nR -A 1 "default:" drivers | grep -i 'break' -B 1 And the above com=
mand will show all similar cases in kernel driver folder.

So, your patch is not necessary as my understanding.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Sent: Tuesday, June 4, 2024 9:23 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Kevin,


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, June 3, 2024 5:09 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_=
levels and navi10_print_clk_levels

[AMD Official Use Only - AMD Internal Distribution Only]

Could you share the problems you encountered?
Some compilers may prompt you to forget to handle default cases.
[Zhang, Jesse(Jie)] These warning scan by Coverity. These are useless redun=
dant codes.

Thanks
Jesse

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Monday, June 3, 2024 4:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Huang, Tim=
 <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 05/12] drm/amd/pm: remove dead code in navi10_emit_clk_leve=
ls and navi10_print_clk_levels

Since the range of the varibable i is 0 - 3.
So execution cannot reach this statement: default.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index cf556f1b5ed1..076620fa3ef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1389,8 +1389,6 @@ static int navi10_emit_clk_levels(struct smu_context =
*smu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        *offset +=3D sysfs_emit_at(buf, *offset, "%d: %uMHz=
 %umV\n",
                                                  i, curve_settings[0], @@ =
-1594,8 +1592,6 @@ static int navi10_print_clk_levels(struct smu_context *s=
mu,
                        case 2:
                                curve_settings =3D &od_table->GfxclkFreq3;
                                break;
-                       default:
-                               break;
                        }
                        size +=3D sysfs_emit_at(buf, size, "%d: %uMHz %umV\=
n",
                                              i, curve_settings[0],
--
2.25.1




