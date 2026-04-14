Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FF3F34C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 05:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D6EF10E55E;
	Tue, 14 Apr 2026 05:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fAWtuA2Z";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D404F10E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 05:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXA4fqDjEOfpGN84icmiilUxuWwmH9dPPiJAcjrpQrAghXQ6NmE3dWVSrxmIqk7Ir11MGtapDj5Q78txt1KQid/Nv/HezzlC+b/wgPgekf5zK7hpsRmNU2sKWGo2yqIYqoKJlo/twrZWUdOrJsxmh1Xvm5fGeEBfVLvqgdbtPB0JaaVixXQwb9e65VQaz9AQedf7SiqmW7h1DmrAnNl0NmcgZmGI5Fg6HlzRfovJoAMbe2NaBar2scRmFSqKkxWdLaNA2hS/aeJklQUP+qz8klf3xrgjH5biMSBDowrkKFm0pVTPfn2nTd+K1mL4y88J8CEXJKSiyzkaHxYzbBwHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pTA4Nhozi22RUONRCDNA+fWS/ixKLfCrh1tboXS9ro=;
 b=Ob8u16Yyv4t/NJQqVuc+jpv6oS/c/VzjjI67ESf60wBMVdX/vwNzBcvJbqhZ6IU8LwHVk+pvYbsLwu3EBh42hw74e0w0OySwzyVlA0PGwYMAmsDzcN90oYysqJceLBr8MdCRJI5UNWcCzmquhZPlUBvau+ESTdsIoyPBHt96vWgo7ZynrRJIMqg6BJlbC5207eO1MYfoB8cuEzCZyY3+rhzcZ2B0yCpzALGuilsRTXrbuw9LzbcWcpDSjNBFq8WAztcnm0n7CSyRWs0ltTPGDMJLeEAU1VvRaxn9Y5qunZwD7bDSUm7zmigIGGxC3rXxcId43c5M9oNeyvwwwHZxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pTA4Nhozi22RUONRCDNA+fWS/ixKLfCrh1tboXS9ro=;
 b=fAWtuA2ZG/mz9jqOqhpVE3lYQo+grbQMwdmg6cPWvujxeZ1RqJv6QpmrHLbdEdHdI3rgo5XKDhC+L0RGeB5ydIH0QmOzR/0UAsodGlqFnRPSs7dShD1QYhliKfV4HcIqfKjq/AsRiOPZbOwI2lbMvJYtvWmM9E9WcarqohlgZKM=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 05:03:55 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 05:03:55 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Rename CPER Fatal severity macro
Thread-Topic: [PATCH] drm/amdgpu: Rename CPER Fatal severity macro
Thread-Index: AQHcy66LV4WSG6/yKk+fxrOE6NyAJLXeAMXw
Date: Tue, 14 Apr 2026 05:03:55 +0000
Message-ID: <PH7PR12MB879638DE2BFE2933200F8512B0252@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260414013150.3158534-1-xiang.liu@amd.com>
In-Reply-To: <20260414013150.3158534-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-14T05:03:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB7575:EE_
x-ms-office365-filtering-correlation-id: cc75f695-0de1-4a41-b918-08de99e33adb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: xCFlECGKiMn00pf71zEMY5m96qkOh8flNwYC2a92joiL4YDUm1jCcVbrzxA3EXtOvWzzMKB2BAaX5m14VuJIDqIGdJvN/pdBTa03psYqGGSM0Ot651r/fKPp12rD4By+u14LFrxRqnTJd6h9Wz7QmvS8UbZFHJ6lgZCSkFN3Rck3IVjqooBN0mpduxG64dMrxoxCcvOBzMfWHl82RkJ240NMme9zBe9wmbN86X3byjgoMJYJKGC2e49EGN7UrPfYJ+Mx9Xl7UsOs+BAq9e2oyMKCifUGwK9U7Vh9EFtzM3NIG1dV2bIooMairD1597dJBjPunpfWUdGCiCaTc70ELHv51C/k7WjEtMqNy5Y9hRF9nI4LRKUjXndF0ieUkae8F1m/oqkhNn0qiTrS0mmykE7jMilyQAfJCtaoRQx4Nbg4WoaJhL+p00f0QEALWR69yzS2jyELtI/O/rRxUMueEVzf+RCVDT8wgPCbTk815a0M8fQm4zCQvkZlalG+hpZULZgRkLL1YzolYxsUyvkOEHspVAHTJkFq4dDnrkUjxq0r+x+pIABQu+7DwJIL72DHpXePIMXozGgebhT3BaZq917uJjZUJDMl87MdcuTeiM5Mt9p7HwltXa/lGX7mS9xWGB9zRQNllgLfQ5fNB2OTh8v142pBaFVOwHiiwKemOfZba82+weqfB4swKx0VHx0s92PuiyKZ/HuWOovLlW+60YFjbfvQ4mT9J15AE+GAOswTM/rN+Auh3gEoWjFPT1lIPVzg4f7ZbKFBW2sigGy4+X32AWafRqxTKyDJlinDqqs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IhfgfTUdnibwulkeAWLVX4c2BGcOoqOV38jiHP8qqRvllMh8SNRFMNdfVe5c?=
 =?us-ascii?Q?4UCK4hi+YgWz1bDWz70O7QhIoP6Xdg3gTWS3Zj/IJgRjOSQFnHIUQG/1RntZ?=
 =?us-ascii?Q?Q7yDXyZYMqvj66gLT6pFYRcFtPF8hNHr035+tr49FmOSFXDxdWOvoyn9ZRW5?=
 =?us-ascii?Q?SIGHGahXa0OvVKONK57HfOzCK8qnuom8+s0nRxi9lppbMu7IvhwUskQ/0sTu?=
 =?us-ascii?Q?rv76ZV3ajwWS6++F/yr2qzy3t6387dDA3hy+k9DLa3k0XQtclVj4y3r06anr?=
 =?us-ascii?Q?RpiEj2ogJ+JfewRXbOrp4a+lop+zc4A0qdcJ6C0qagefEUjE6OYMyg7PEN1j?=
 =?us-ascii?Q?cS49BbEAgLPl9me13JN1yW9yutj3BHQGiRRLi+b+xH7BvidT/EofSMaN/eYj?=
 =?us-ascii?Q?c/spzv5G7Q2/UPFus/A/Kj9scFNIyx/joQRJsJzRdAuvRdQmOIxQm73WDsbk?=
 =?us-ascii?Q?mpWxfA4v9m72Ih0iajdQp4G5ST+N+h6ZI4HJNbTolqhap0n8S+Vy8soDnERf?=
 =?us-ascii?Q?gsbki2l2VYqSU1AFhiKqReP8UcbwjpNtqSalN1FVTCTfXJiddYINW6hzzeAb?=
 =?us-ascii?Q?gouUk/ZkYf6oym1L0RhqGXhPpTBYYtBi3+Sx+D/5PZi8oPB9BSsv2jZZ4M6x?=
 =?us-ascii?Q?17kcx/P54VrOG2eA1J0K5qhfJWT9o2b1rpEVndiUkxEj+VNAnYSa7dqZRWY7?=
 =?us-ascii?Q?oE0JzhMs18IJFLf222npXaWUwwvOv2J/ntWHieDWRnZCaUFeyBJbHfweo+/J?=
 =?us-ascii?Q?MEd+XhHZDd06aY75ZuFlTe/YwsSsIZMUBfejpGdiGcoEpBitkYdxf2BuM5+C?=
 =?us-ascii?Q?H52N/aiQnzJCjjhxuotKX0y6/TTPCh8vgcQzIvZrmPyf6ELuwFqHk/LHRmRI?=
 =?us-ascii?Q?tWERBip4t3LZG7NEGNOjMqif9ZFq2u/AP+RXeqo9RG9tmrymBDgaiSNH+2/c?=
 =?us-ascii?Q?XwtraWlSKzU3BBN9cuhq6kQ3ZD2QoPSDmwbENvvUklBQOsOPQT2ARXrJvcV5?=
 =?us-ascii?Q?8BcuoLCVg8fCDVbuIhbbLvod26uJEJk/dLudnlamMhXCwrU2XCBGGQmp51Pt?=
 =?us-ascii?Q?iZz4kdim9wseDZRK9QhmllMIZu8Ki/TwSeFlyT4Je9GHwkpgiYRlBFAo5hM6?=
 =?us-ascii?Q?zfUh4KuGSLbQSV9Ui2ICbIqRgpG0+dWSspL+N6FrQcPANO1gSbj9L2OCXVRx?=
 =?us-ascii?Q?cd7Y1C7lECdL73KkLv6GkO24r8W6G55zNV5sUhrBp4epltUql80N+ym5tsBT?=
 =?us-ascii?Q?ndsfhKCkFZspmYYZW4SR3zwTIHzBM9UbLep95mZwhNy38RxxgDAOkqvP0D7G?=
 =?us-ascii?Q?I4tQc4EklMU1j1WfLGtEfZeKRSk7w2AQO6ACif2lj+HszNypdhCZZX1vu/pF?=
 =?us-ascii?Q?Igy2Rag7vU1ZKxMvpkkKjdOht/Po+sRVl1AyvUYJPP6ZQRBTqzXUu7O6dJ9L?=
 =?us-ascii?Q?iffeami25uM4iOYvl8ULf57xVlkbuR4CF6+j0rBewGjQH6bIyoV5Ser4duDS?=
 =?us-ascii?Q?NeQejPdb3UG5Dz/b+VgU15HPuPhEhgrL6bkAQHhFNInpCawXlkPlyxXP8Xqv?=
 =?us-ascii?Q?GXGo0IwGYOoDyRzq7M4klqlvexp9HDXLUgMKnGx7dwkO++XtCqeNpH3ywJXw?=
 =?us-ascii?Q?RQC3HQmLpfAdJ8noRqURx3RkSBAcE4oIF+LnVP7u+QsvBiqf6d+cH1yc3UJh?=
 =?us-ascii?Q?RcAjDsgKu18t7qARlCTheC1oR4FABcdBXeWHwiDXGIGuezV2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc75f695-0de1-4a41-b918-08de99e33adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 05:03:55.7005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JEMCK4k1GDYSORZbh9lLUYKueo72gmLseHSYcITPNU/lG67e8oksj8cKGWwPILTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Tuesday, April 14, 2026 9:32 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Rename CPER Fatal severity macro
>
> Rename CPER severity macro to avoid conflicting with UEFI definition.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 12 ++++++------
>  drivers/gpu/drm/amd/include/amd_cper.h   |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> index c72c345334d0..0b83b61e12f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -151,7 +151,7 @@ int amdgpu_cper_entry_fill_fatal_section(struct
> amdgpu_device *adev,
>                  FATAL_SEC_OFFSET(hdr->sec_cnt, idx));
>
>       amdgpu_cper_entry_fill_section_desc(adev, section_desc, false, fals=
e,
> -                                         CPER_SEV_FATAL, CRASHDUMP,
> FATAL_SEC_LEN,
> +                                         CPER_SEV_FATAL_UNCORRECTED,
> CRASHDUMP, FATAL_SEC_LEN,
>                                           FATAL_SEC_OFFSET(hdr->sec_cnt,
> idx));
>
>       section->body.reg_ctx_type =3D CPER_CTX_TYPE_CRASH; @@ -213,7
> +213,7 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct
> amdgpu_device *adev
>                  NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
>
>       amdgpu_cper_entry_fill_section_desc(adev, section_desc, true, false=
,
> -                                         CPER_SEV_FATAL, RUNTIME,
> NONSTD_SEC_LEN,
> +                                         CPER_SEV_FATAL_UNCORRECTED,
> RUNTIME, NONSTD_SEC_LEN,
>                                           NONSTD_SEC_OFFSET(hdr-
> >sec_cnt, idx));
>
>       section->hdr.valid_bits.err_info_cnt =3D 1; @@ -310,7 +310,7 @@ int
> amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
>       reg_data.synd_lo   =3D lower_32_bits(bank-
> >regs[ACA_REG_IDX_SYND]);
>       reg_data.synd_hi   =3D upper_32_bits(bank-
> >regs[ACA_REG_IDX_SYND]);
>
> -     amdgpu_cper_entry_fill_hdr(adev, fatal, AMDGPU_CPER_TYPE_FATAL,
> CPER_SEV_FATAL);
> +     amdgpu_cper_entry_fill_hdr(adev, fatal, AMDGPU_CPER_TYPE_FATAL,
> +CPER_SEV_FATAL_UNCORRECTED);
>       ret =3D amdgpu_cper_entry_fill_fatal_section(adev, fatal, 0, reg_da=
ta);
>       if (ret)
>               return ret;
> @@ -335,7 +335,7 @@ int
> amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
>
>       amdgpu_cper_entry_fill_hdr(adev, bp_threshold,
>                                  AMDGPU_CPER_TYPE_BP_THRESHOLD,
> -                                CPER_SEV_FATAL);
> +                                CPER_SEV_FATAL_UNCORRECTED);
>       ret =3D amdgpu_cper_entry_fill_bad_page_threshold_section(adev,
> bp_threshold, 0);
>       if (ret)
>               return ret;
> @@ -351,14 +351,14 @@ static enum cper_error_severity
> amdgpu_aca_err_type_to_cper_sev(struct amdgpu_de  {
>       switch (aca_err_type) {
>       case ACA_ERROR_TYPE_UE:
> -             return CPER_SEV_FATAL;
> +             return CPER_SEV_FATAL_UNCORRECTED;
>       case ACA_ERROR_TYPE_CE:
>               return CPER_SEV_NON_FATAL_CORRECTED;
>       case ACA_ERROR_TYPE_DEFERRED:
>               return CPER_SEV_NON_FATAL_UNCORRECTED;
>       default:
>               dev_err(adev->dev, "Unknown ACA error type!\n");
> -             return CPER_SEV_FATAL;
> +             return CPER_SEV_FATAL_UNCORRECTED;
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/include/amd_cper.h
> b/drivers/gpu/drm/amd/include/amd_cper.h
> index a252ee4c7874..baa0f30b9c4d 100644
> --- a/drivers/gpu/drm/amd/include/amd_cper.h
> +++ b/drivers/gpu/drm/amd/include/amd_cper.h
> @@ -58,7 +58,7 @@
>
>  enum cper_error_severity {
>       CPER_SEV_NON_FATAL_UNCORRECTED =3D 0,
> -     CPER_SEV_FATAL                 =3D 1,
> +     CPER_SEV_FATAL_UNCORRECTED     =3D 1,
>       CPER_SEV_NON_FATAL_CORRECTED   =3D 2,
>       CPER_SEV_NUM                   =3D 3,
>
> --
> 2.34.1

