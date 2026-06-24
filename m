Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C236CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 15:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B877310EF61;
	Wed, 24 Jun 2026 15:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g42x9ruA";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C774E10EF61
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 15:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAZA8V1P3leKgzfkKqJIxE0tk5JAWAgHIijsQ/9JsPt96Kn8S1nMY33yQwSrUdVA2HrKdpxfrTjYcVkAmmpp3cNrumbTE13CXGdtLVAf93445/jcNDKIoDUvUgfodPif10Qg2RnJGBU+0pBcE90PITw+dTI74z9LW3NW1udmLe5GCsdes/W7iCbhVdA9aUZgl+ZEz4Lyr4A45LwWOSp4uhcryvgWBvGfSU1NKA0Dg4c0xfnwXg6Tg/WpUjirvO6QwuF31VZ/3hsn7MukE1vzuRYBhZI11EVqgw04F+RCDqMpmGbNDQxUHoKc2BqA7SDmBuA0h6NpaqSSvUzJ1qAtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BhdIzcT5Dz9FjLgSOV/BqBUXBOnKnce5U1NqA74HSc=;
 b=MAnnmTd/8W7gpqWmNWGfGfEIoyAStCkc5mUjieFaP/rRSFC577Rdf70rkuV7cSqXU9FNlAEh1xjv0a9ibdTCcdSckNlTPwt4fH8H8exY7YnVkCm1YziBQgu3PC0SCxBQAs8Ya46OMwO7tcmgJcnfNBRZIubB+B9nGcK9hpLeK1V3FVbHQc7by+rM3gzhO5KKpX5Gi/9zTQQ4zkC4I7G5pRDLiYO401mcIxhq7J6JjN2yVq3DukznffmGahRr3x1jHOx322Vx1UcE9Jto45H+enWCN8hwmzWbNMMl/5D+94Lie6oBWFSdcX6NAKryxQJerp/jM48aMix04H360ClukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BhdIzcT5Dz9FjLgSOV/BqBUXBOnKnce5U1NqA74HSc=;
 b=g42x9ruAoFq2MU7UDU3y3XDqXfTxlxQU1u1ej+KjWMT8QCQQxv9/UMC8z4sGWTfpDUiMfa5InyWENKBfAlP8UN7/PfpqyPwNwhVp5DruGFaiTDougFThcLGSEMbX2KbZ8vrAlR98/P8STFLc9M6jmSLuO+OotI0kmgz89AfmHz0=
Received: from MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Wed, 24 Jun
 2026 15:04:34 +0000
Received: from MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2]) by MN2PR12MB2863.namprd12.prod.outlook.com
 ([fe80::f402:b1b8:c6bd:24b2%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 15:04:34 +0000
From: "Soltani, Shahyan" <Shahyan.Soltani@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 2/8] drm/amdgpu: move struct amdgpu_uid and helpers
 into separate files
Thread-Topic: [PATCH v3 2/8] drm/amdgpu: move struct amdgpu_uid and helpers
 into separate files
Thread-Index: AQHdAoFvI7VR3tami0GKINuhSv6MObZL1xMAgAHky88=
Date: Wed, 24 Jun 2026 15:04:34 +0000
Message-ID: <MN2PR12MB2863DB9ED30979697CE966B6F5ED2@MN2PR12MB2863.namprd12.prod.outlook.com>
References: <20260622195729.181216-1-shahyan.soltani@amd.com>
 <20260622195729.181216-3-shahyan.soltani@amd.com>
 <3bfbcf70-1af8-4795-a62f-8f0002e633f9@amd.com>
In-Reply-To: <3bfbcf70-1af8-4795-a62f-8f0002e633f9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-24T15:04:34.196Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB2863:EE_|BY5PR12MB4258:EE_
x-ms-office365-filtering-correlation-id: 5686f02c-a203-4138-3d74-08ded201e709
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|4143699003|18002099003|22082099003|6133799003|3023799007|8096899003|38070700021;
x-microsoft-antispam-message-info: RZbYfUOmPg+PSL40i5nvYc3KTG0W7GP4pfMb71x1e57FLZlXzFXp+hMsc0B1mUGNOj1ei+is84elX8S6Xzt3MUMgISLZH4djDK/u/m5gNFivUmlBi70ozKN1km3XkXMalpIwDWHbM97LW+XCId96FOc8hcxTAJG4o13Op72ODKM1TqWOjLncL8hB5rNSFe6sS0R7FzSbQS1If9Ud1lmYF80pWG/KTN+SKbicjp2JlACseFzKHnrZf/dGt1ogEGiZOqkBeti4hYv8UjjtMWc86EMMRs646fdTgNfbQvQ1IAOgGtAU+qSVpZTWzWu6L0EWy2G+aEZ0lqYucjLu1nm89AIyYTiK+VT5uo9MWSQipB11O3Sa2L1tKfY1HTULydgW/yY+Rw/arCpaVdWQTTJupyLKA6ziMA7knBn9mdNhPEjvlytyxaP7zU3tOdrMRYDiON76O+xGaSkbQNOUJCaUnl6pMTegINjs9z92IjaVmuaetBYQp/XB117Nt87o5oxRp0bjsMpjcrR6xlaC+gBSAmMYqGaT6tGsEyI5ilCcUoaW9tARSLXb1Ju+dN7O/NMGmvXEsrRnlKob9egPD26fsyQSbZCQU/I/4Hlwbfgk46F+X6r9QQsbLqBlP+6xq0mvpfhktMByVFfGD4Z+scxeqVeVnfJaQs2oPpapdOnN6ZRWbobLtWnzK8QynHzHkwdILudXquIV6y1hVVzFjY8D/bQpBxCovP3jwyVlUsLdBcg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2863.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003)(3023799007)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+xm0MQSDCRJN70naHScVwyKLMBGb4PvibP6U6BzR5M2IWt4kYsK69TjtLhB?=
 =?us-ascii?Q?DLPV8QS+L2WRRJAsKD4YHFnEK1Lr98pmK7pWy/A44jBTPnLE+CtBAVJMMk5u?=
 =?us-ascii?Q?YuiI1eC0ZZVKB5svV7qYwH6Q7/5LhiAzEXXHsvjv/qbbyT3F1mZAXbehuZD2?=
 =?us-ascii?Q?DKJN4MBVRPqu4RuRLnDIu4U/cJxF90riHubpFM5aHu+6CT7rvHJH6Nx8rtKp?=
 =?us-ascii?Q?xu1IHxBKCdtHP1RQMwt1snk5BCnKq3FLqWOo+2B68rZHD3w7+Sqn6x0VC/Ym?=
 =?us-ascii?Q?bt8+syCAn1oY2QiWNPHomZ18ggjAKfrwUVlv2VsxZfLohJSgR893/TZLafFm?=
 =?us-ascii?Q?MgaeVNlSJPWFpPToEIXlvifGaHovE+HpiM4CdGFtM9u53IWlsb3pqIRjrsSx?=
 =?us-ascii?Q?ntfA/qrZgZAgQWCiPHG3W4rGQl/zVd9iOyReeD1sTLWeF1MLSVnSA/ol5+5u?=
 =?us-ascii?Q?FOVbrgtDXlq6XXx4NtF9KrOKBSp8Rks6P2HNILOyTgr+6sZ8iZq1DH6FIrEq?=
 =?us-ascii?Q?6bEn7CNHaVdtbgw/UouPaskhwRhZd6Lnh1w5+yBanONbndT89bJtXkuAzzts?=
 =?us-ascii?Q?IiPrvkQEtBHAUL679NVWlCkQ+gutcxwDMTCyb3DyjodKZ/1iKDn8vNan1vIb?=
 =?us-ascii?Q?zZyerFIaJczlSlSVj7xXKCMRJFjHr0Jzj0sAMz/7bpMMDfF4YAxYNoMKYuYT?=
 =?us-ascii?Q?BWhoHUYlFAbYKbyrTwodqQWPUdHXKyhd88lsKtxxWKwgeTgZKAZ0z+fx4TeP?=
 =?us-ascii?Q?ZA5GCfiF2qtkCXBameMUGdhMpItGyfEkW4jOXvYiHBQcLT28esO7U5IXR7U/?=
 =?us-ascii?Q?ghVIe6TyS6GO914qvJPZeBIHVymjcJfIkP32zKMkvAKUIbDA0m8/vMoZ7UHj?=
 =?us-ascii?Q?Ubu+TwQuAcWKjpSquv4LjdlmyW00M8yEKeeXE/DlmdC7g8ojruSgdvfmhu/1?=
 =?us-ascii?Q?epgW/8kG0PBlfwkPVFaRzVQNrctW04N5nVrvsFDHj0X9cQYhiCF/v5/3mgiW?=
 =?us-ascii?Q?c6OxnizzCCKhUL0/m834NMRu+5sDL5wcCCVZSuXPeUEOXTOxv4J8rHbzPyev?=
 =?us-ascii?Q?nEOB88MIr+MeUjTYg2KMIUbUVLhd+Im0it0oY9zScyayU91+AaoJ6VPHevf6?=
 =?us-ascii?Q?wNRKnshaFXDj8aOlfZmMnJdlACKj4gJ7R4LIEiXTxHz14sZlvGhWNX0NLzPD?=
 =?us-ascii?Q?kDWhWguf53DwnAJU+CuI8EX7qyun1/FV1tdwDRE46qzhRk86vkSl5ewU/qRe?=
 =?us-ascii?Q?+/SV24GsMLgOTUk9tOoA9nzU5bFucwkNQ21ohWGRCX5ynKdZo/kYG7/5zFV9?=
 =?us-ascii?Q?8LdKiic4EsgG9Fzrq1emxSBVZNq0fEzg7dnOHSLycPSmh+NlrfTmtmH8LCIc?=
 =?us-ascii?Q?MrZzYA8yGQA2C19pZAMaBRnNdKah2GSe2DoFbgtRAAMC9ADV3VEnDimCwdAS?=
 =?us-ascii?Q?AgajXiuIFsJsxG/qP/p5TlA0icf2SY5TDZOIAu25q5zEBSjqj0P5IUVNOD0U?=
 =?us-ascii?Q?1O5XiUr0un3Fq8jxGuHzPSN1JRxlhPnp2F/uxgvPuHdj1/SbOyL9EklIh4iM?=
 =?us-ascii?Q?nCVaFSMlHOZIM10crRqsCl4Az/cLz0TxVWWTBpBS6aJKiDFl/TTSdqlHaftE?=
 =?us-ascii?Q?PTDdf86wNL7rDyWjFeOpWN5sRLQGkUqbCINCVVvGfERRWOA+lfDcXlREuYh+?=
 =?us-ascii?Q?ZQFaz6jb2UOPiwIHGWUUKJH6WW/U1oQ8XuNyvrFFVQg6QGxH?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB2863DB9ED30979697CE966B6F5ED2MN2PR12MB2863namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2863.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5686f02c-a203-4138-3d74-08ded201e709
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 15:04:34.5519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9nfufwW93zAvFeLkg995YpVry39BN+4/A9S0bXodfDFQCG5ZVdm7dlw3b9RoqQoqKNLB3pdgbllLda07gKFEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

--_000_MN2PR12MB2863DB9ED30979697CE966B6F5ED2MN2PR12MB2863namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

On 6/23/2026 04:55, Christian Koenig wrote:
> I think we should really just move the defines in a new file called amdgp=
u_device.h.
>
> The uid is something device specific and it is a bit overkill to have a s=
eparate C file for it.

Hi Christian,

I made a amdgpu_device.h file in v1 of the patch however I was asked by Ale=
x to drop it
to keep core structures within amdgpu.h.

I'm not entirely sure if it would be better to create amdgpu_device.h file =
with only the uid
struct and helpers or keep it within amdgpu.h (dropping this patch). Any cl=
arification on the
this matter will be greatly appreciated.

Thanks,
Shahyan.
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Tuesday, June 23, 2026 4:55 AM
To: Soltani, Shahyan <Shahyan.Soltani@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3 2/8] drm/amdgpu: move struct amdgpu_uid and helpers =
into separate files

On 6/22/26 21:57, Shahyan Soltani wrote:
> Move struct amdgpu_uid and helpers from the monolithic amdgpu.h file into=
 a new amdgpu_uid.h file.
>
> Move functions amdgpu_device_set_uid() and amdgpu_device_get_uid() out of
> amdgpu_device.c into new dedicated amdgpu_uid.c file.
>
> Update amdgpu/Makefile to build amdgpu_uid.o
>
> This is part of the ongoing effort to reduce the size of amdgpu.h into th=
eir own respective
> separate headers.
>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
>
> ---
> This patch and patch 7 can be dropped if moving amdgpu_uid out of
> amdgpu.h is not desirable.

I think we should really just move the defines in a new file called amdgpu_=
device.h.

The uid is something device specific and it is a bit overkill to have a sep=
arate C file for it.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 22 +------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c    | 75 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h    | 50 +++++++++++++++
>  5 files changed, 127 insertions(+), 72 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 10dc7cfd607e..ab5fdbb5e4b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -72,7 +72,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o amdgp=
u_doorbell_mgr.o amdgpu_kms
>        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu=
_lockdep.o \
>        amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_=
dev_coredump.o \
>        amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_=
ip.o \
> -     amdgpu_wb.o
> +     amdgpu_wb.o amdgpu_uid.o
>
>  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 4ffcc0cc6404..fe951a901d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -116,6 +116,7 @@
>  #include "amdgpu_wb.h"
>  #include "amdgpu_ip.h"
>  #include "amdgpu_sa.h"
> +#include "amdgpu_uid.h"
>  #if defined(CONFIG_DRM_AMD_ISP)
>  #include "amdgpu_isp.h"
>  #endif
> @@ -551,21 +552,6 @@ struct amdgpu_mmio_remap {
>        struct amdgpu_bo *bo;
>  };
>
> -enum amdgpu_uid_type {
> -     AMDGPU_UID_TYPE_XCD,
> -     AMDGPU_UID_TYPE_AID,
> -     AMDGPU_UID_TYPE_SOC,
> -     AMDGPU_UID_TYPE_MID,
> -     AMDGPU_UID_TYPE_MAX
> -};
> -
> -#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID ty=
pe */
> -
> -struct amdgpu_uid {
> -     uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
> -     struct amdgpu_device *adev;
> -};
> -
>  #define MAX_UMA_OPTION_NAME  28
>  #define MAX_UMA_OPTION_ENTRIES       19
>
> @@ -1530,10 +1516,4 @@ static inline int amdgpu_device_bus_status_check(s=
truct amdgpu_device *adev)
>
>         return 0;
>  }
> -
> -void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> -                        enum amdgpu_uid_type type, uint8_t inst,
> -                        uint64_t uid);
> -uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> -                            enum amdgpu_uid_type type, uint8_t inst);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index d6931e1184d0..8d55658ecb31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6717,53 +6717,3 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint32_t=
 supported_reset)
>        size +=3D sysfs_emit_at(buf, size, "\n");
>        return size;
>  }
> -
> -void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> -                        enum amdgpu_uid_type type, uint8_t inst,
> -                        uint64_t uid)
> -{
> -     if (!uid_info)
> -             return;
> -
> -     if (type >=3D AMDGPU_UID_TYPE_MAX) {
> -             dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> -                          type);
> -             return;
> -     }
> -
> -     if (inst >=3D AMDGPU_UID_INST_MAX) {
> -             dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\=
n",
> -                          inst);
> -             return;
> -     }
> -
> -     if (uid_info->uid[type][inst] !=3D 0) {
> -             dev_warn_once(
> -                     uid_info->adev->dev,
> -                     "Overwriting existing UID %llu for type %d instance=
 %d\n",
> -                     uid_info->uid[type][inst], type, inst);
> -     }
> -
> -     uid_info->uid[type][inst] =3D uid;
> -}
> -
> -u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> -                       enum amdgpu_uid_type type, uint8_t inst)
> -{
> -     if (!uid_info)
> -             return 0;
> -
> -     if (type >=3D AMDGPU_UID_TYPE_MAX) {
> -             dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> -                          type);
> -             return 0;
> -     }
> -
> -     if (inst >=3D AMDGPU_UID_INST_MAX) {
> -             dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\=
n",
> -                          inst);
> -             return 0;
> -     }
> -
> -     return uid_info->uid[type][inst];
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uid.c
> new file mode 100644
> index 000000000000..6cf6b3f12271
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
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
> + */
> +#include "amdgpu_uid.h"
> +#include <linux/dev_printk.h>
> +#include "amdgpu.h"
> +
> +void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> +                        enum amdgpu_uid_type type, uint8_t inst,
> +                        uint64_t uid)
> +{
> +     if (!uid_info)
> +             return;
> +
> +     if (type >=3D AMDGPU_UID_TYPE_MAX) {
> +             dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> +                          type);
> +             return;
> +     }
> +
> +     if (inst >=3D AMDGPU_UID_INST_MAX) {
> +             dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\=
n",
> +                          inst);
> +             return;
> +     }
> +
> +     if (uid_info->uid[type][inst] !=3D 0) {
> +             dev_warn_once(
> +                     uid_info->adev->dev,
> +                     "Overwriting existing UID %llu for type %d instance=
 %d\n",
> +                     uid_info->uid[type][inst], type, inst);
> +     }
> +
> +     uid_info->uid[type][inst] =3D uid;
> +}
> +
> +u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> +                       enum amdgpu_uid_type type, uint8_t inst)
> +{
> +     if (!uid_info)
> +             return 0;
> +
> +     if (type >=3D AMDGPU_UID_TYPE_MAX) {
> +             dev_err_once(uid_info->adev->dev, "Invalid UID type %d\n",
> +                          type);
> +             return 0;
> +     }
> +
> +     if (inst >=3D AMDGPU_UID_INST_MAX) {
> +             dev_err_once(uid_info->adev->dev, "Invalid UID instance %d\=
n",
> +                          inst);
> +             return 0;
> +     }
> +
> +     return uid_info->uid[type][inst];
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uid.h
> new file mode 100644
> index 000000000000..d92ddcce9f58
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
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
> + */
> +#ifndef __AMDGPU_UID_H__
> +#define __AMDGPU_UID_H__
> +
> +#include <linux/types.h>
> +
> +#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID ty=
pe */
> +
> +struct amdgpu_device;
> +
> +enum amdgpu_uid_type {
> +     AMDGPU_UID_TYPE_XCD,
> +     AMDGPU_UID_TYPE_AID,
> +     AMDGPU_UID_TYPE_SOC,
> +     AMDGPU_UID_TYPE_MID,
> +     AMDGPU_UID_TYPE_MAX
> +};
> +
> +struct amdgpu_uid {
> +     uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID_INST_MAX];
> +     struct amdgpu_device *adev;
> +};
> +
> +void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
> +                        enum amdgpu_uid_type type, uint8_t inst,
> +                        uint64_t uid);
> +uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
> +                            enum amdgpu_uid_type type, uint8_t inst);
> +#endif


--_000_MN2PR12MB2863DB9ED30979697CE966B6F5ED2MN2PR12MB2863namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"></s=
pan>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
On 6/23/2026 04:55, Christian Koenig wrote:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I think we should really just move the defines in a new file called am=
dgpu_device.h.<br>
&gt;<br>
&gt; The uid is something device specific and it is a bit overkill to have =
a separate C file for it.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Christian,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I made a amdgpu_device.h file in v1 of the patch however I was asked by Ale=
x to drop it</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
to keep core structures within amdgpu.h.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I'm not entirely sure if it would be better to create amdgpu_device.h file =
with only the uid</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
struct and helpers or keep it within amdgpu.h (dropping this patch). Any cl=
arification on the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
this matter will be greatly appreciated.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Shahyan.</div>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"></s=
pan>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 23, 2026 4:55 AM<br>
<b>To:</b> Soltani, Shahyan &lt;Shahyan.Soltani@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v3 2/8] drm/amdgpu: move struct amdgpu_uid and h=
elpers into separate files</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/22/26 21:57, Shahyan Soltani wrote:<br>
&gt; Move struct amdgpu_uid and helpers from the monolithic amdgpu.h file i=
nto a new amdgpu_uid.h file.<br>
&gt; <br>
&gt; Move functions amdgpu_device_set_uid() and amdgpu_device_get_uid() out=
 of<br>
&gt; amdgpu_device.c into new dedicated amdgpu_uid.c file.<br>
&gt; <br>
&gt; Update amdgpu/Makefile to build amdgpu_uid.o<br>
&gt; <br>
&gt; This is part of the ongoing effort to reduce the size of amdgpu.h into=
 their own respective<br>
&gt; separate headers.<br>
&gt; <br>
&gt; Signed-off-by: Shahyan Soltani &lt;shahyan.soltani@amd.com&gt;<br>
&gt; <br>
&gt; ---<br>
&gt; This patch and patch 7 can be dropped if moving amdgpu_uid out of <br>
&gt; amdgpu.h is not desirable.<br>
<br>
I think we should really just move the defines in a new file called amdgpu_=
device.h.<br>
<br>
The uid is something device specific and it is a bit overkill to have a sep=
arate C file for it.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 22 +------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ---------------<=
br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c&nbsp;&nbsp;&nbsp; | 75 +=
+++++++++++++++++++++<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h&nbsp;&nbsp;&nbsp; | 50 +=
++++++++++++++<br>
&gt;&nbsp; 5 files changed, 127 insertions(+), 72 deletions(-)<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd=
/amdgpu/Makefile<br>
&gt; index 10dc7cfd607e..ab5fdbb5e4b4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&gt; @@ -72,7 +72,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o am=
dgpu_doorbell_mgr.o amdgpu_kms<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_eeprom.o amdgpu_mca.o=
 amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_mux.o amdgpu_xcp=
.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_cper.o amdgpu_userq_f=
ence.o amdgpu_eviction_fence.o amdgpu_ip.o \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_wb.o<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_wb.o amdgpu_uid.o<br>
&gt;&nbsp; <br>
&gt;&nbsp; amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index 4ffcc0cc6404..fe951a901d20 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -116,6 +116,7 @@<br>
&gt;&nbsp; #include &quot;amdgpu_wb.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_ip.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_sa.h&quot;<br>
&gt; +#include &quot;amdgpu_uid.h&quot;<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_ISP)<br>
&gt;&nbsp; #include &quot;amdgpu_isp.h&quot;<br>
&gt;&nbsp; #endif<br>
&gt; @@ -551,21 +552,6 @@ struct amdgpu_mmio_remap {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; -enum amdgpu_uid_type {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_XCD,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_AID,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_SOC,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_MID,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_MAX<br>
&gt; -};<br>
&gt; -<br>
&gt; -#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID=
 type */<br>
&gt; -<br>
&gt; -struct amdgpu_uid {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID=
_INST_MAX];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&gt; -};<br>
&gt; -<br>
&gt;&nbsp; #define MAX_UMA_OPTION_NAME&nbsp; 28<br>
&gt;&nbsp; #define MAX_UMA_OPTION_ENTRIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 19<br>
&gt;&nbsp; <br>
&gt; @@ -1530,10 +1516,4 @@ static inline int amdgpu_device_bus_status_chec=
k(struct amdgpu_device *adev)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; -<br>
&gt; -void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
amdgpu_uid_type type, uint8_t inst,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t uid);<br>
&gt; -uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; enum amdgpu_uid_type type, uint8_t inst);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index d6931e1184d0..8d55658ecb31 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -6717,53 +6717,3 @@ ssize_t amdgpu_show_reset_mask(char *buf, uint3=
2_t supported_reset)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size +=3D sysfs_emit_at(buf,=
 size, &quot;\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt;&nbsp; }<br>
&gt; -<br>
&gt; -void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
amdgpu_uid_type type, uint8_t inst,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t uid)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!uid_info)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (type &gt;=3D AMDGPU_UID_TYPE_MAX) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID type %d\n&quo=
t;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (inst &gt;=3D AMDGPU_UID_INST_MAX) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID instance %d\n=
&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; inst);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (uid_info-&gt;uid[type][inst] !=3D 0) {<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn_once(<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uid_info-&gt;adev-&gt;d=
ev,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Overwriting exist=
ing UID %llu for type %d instance %d\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uid_info-&gt;uid[type][=
inst], type, inst);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uid_info-&gt;uid[type][inst] =3D uid;<br>
&gt; -}<br>
&gt; -<br>
&gt; -u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu=
_uid_type type, uint8_t inst)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!uid_info)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (type &gt;=3D AMDGPU_UID_TYPE_MAX) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID type %d\n&quo=
t;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; type);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (inst &gt;=3D AMDGPU_UID_INST_MAX) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID instance %d\n=
&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; inst);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return uid_info-&gt;uid[type][inst];<br>
&gt; -}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_uid.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..6cf6b3f12271<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.c<br>
&gt; @@ -0,0 +1,75 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0 OR MIT<br>
&gt; +/*<br>
&gt; + * Copyright 2026 Advanced Micro Devices, Inc.<br>
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
&gt; + */<br>
&gt; +#include &quot;amdgpu_uid.h&quot;<br>
&gt; +#include &lt;linux/dev_printk.h&gt;<br>
&gt; +#include &quot;amdgpu.h&quot;<br>
&gt; +<br>
&gt; +void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
amdgpu_uid_type type, uint8_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t uid)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!uid_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (type &gt;=3D AMDGPU_UID_TYPE_MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID type %d\n&quo=
t;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (inst &gt;=3D AMDGPU_UID_INST_MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID instance %d\n=
&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; inst);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (uid_info-&gt;uid[type][inst] !=3D 0) {<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn_once(<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uid_info-&gt;adev-&gt;d=
ev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Overwriting exist=
ing UID %llu for type %d instance %d\n&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uid_info-&gt;uid[type][=
inst], type, inst);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uid_info-&gt;uid[type][inst] =3D uid;<br>
&gt; +}<br>
&gt; +<br>
&gt; +u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu=
_uid_type type, uint8_t inst)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!uid_info)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (type &gt;=3D AMDGPU_UID_TYPE_MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID type %d\n&quo=
t;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (inst &gt;=3D AMDGPU_UID_INST_MAX) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err_once(uid_info-&gt;adev-&gt;dev, &quot;Invalid UID instance %d\n=
&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; inst);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return uid_info-&gt;uid[type][inst];<br>
&gt; +}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_uid.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..d92ddcce9f58<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uid.h<br>
&gt; @@ -0,0 +1,50 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0 OR MIT<br>
&gt; + *<br>
&gt; + * Copyright 2026 Advanced Micro Devices, Inc.<br>
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
&gt; + */<br>
&gt; +#ifndef __AMDGPU_UID_H__<br>
&gt; +#define __AMDGPU_UID_H__<br>
&gt; +<br>
&gt; +#include &lt;linux/types.h&gt;<br>
&gt; +<br>
&gt; +#define AMDGPU_UID_INST_MAX 8 /* max number of instances for each UID=
 type */<br>
&gt; +<br>
&gt; +struct amdgpu_device;<br>
&gt; +<br>
&gt; +enum amdgpu_uid_type {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_XCD,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_AID,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_SOC,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_MID,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_UID_TYPE_MAX<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct amdgpu_uid {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; uint64_t uid[AMDGPU_UID_TYPE_MAX][AMDGPU_UID=
_INST_MAX];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum =
amdgpu_uid_type type, uint8_t inst,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint6=
4_t uid);<br>
&gt; +uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; enum amdgpu_uid_type type, uint8_t inst);<br>
&gt; +#endif<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2863DB9ED30979697CE966B6F5ED2MN2PR12MB2863namp_--
