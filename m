Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF204C54E60
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 02:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9CE10E688;
	Mon, 18 Mar 2024 02:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSJopRRa";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5908B10E688
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 02:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ0pgt8FDcUED4jp5JMzTK58X5QfzRdwpWg9s7p8yAcYY1rp85iVK+3PV3d6ywGQXzkJtL5yPGO1Z+pOcNm4louB5BBwH9qet5QifIKbmUE/GtOhaKLGcRTj3LN4+cR/06T84y8Ws3tgPWYQrVTFr0Eqfycv8HtVcNsZDXhgROcImXZ6kiHSAQzaG00c7wUuy6ZpZdv7jnlj32IhPNTcveXizAiiTlWQcdx4wdj+pKWhl9pZWunnGOcVbtW333mlAZHfiFiFEybkpw3mmqGnXP/DKRuPsKTvxTIoSE9YnDbX0OsQ1Gqa8k7UrGQsYHcpDFqIvSgMIYu8fuo+3wC5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql22fh+qgXpgWRKcDFQ56Mh59tgvK5u8gi4L0dUaF2A=;
 b=CxvlMAkf3YBNKk9qqtvLlmzn5lG6lxJL7BKC6mMcCuEcLaFzT7hQ6NnNLCIsphnhkN5+40w/IGOtKwHv0rUhraTXzmy7wYKhAtSd8zvH0vD7Io8OMjsYOXutEshaFpQ9TKI8XxAQ1zuEeZweGXjldrdeBu2tsArRFOqPov3IgVkWeGvAsfrG1dOiNRTF2XCKLTPwamS63yWWRGZuzmwbz35V+XHCLdDE7JeVSRfLP6VW3OHW/SKNrGIsOyws5zpwBjJRpv5bvSd+JFlQdoVW3wwI6XnWC5eWi82gBV/koyqTbFp2/nUKYf0vF0/CiStWTbq7RqVYVIqOH/s4ZPqgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql22fh+qgXpgWRKcDFQ56Mh59tgvK5u8gi4L0dUaF2A=;
 b=JSJopRRayjx8s3wjT0MUB8cLZ2qnuTElSuApVFDZNf8ZEZZvRO93uTTkpgcRE0OWPIVb9AjfQbDvTgPzBN8Vn/BG9RP9ASl7mbz7ullPF025wZ7RkcQp0UeqdNsRDEYg9orv6fCuLtnJeiMl71JqPu90dWiB/6lrdqFsXYqmtmE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:58:25 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 02:58:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ras event id support for ACA
Thread-Topic: [PATCH] drm/amdgpu: add ras event id support for ACA
Thread-Index: AQHaeNusstV7PfkRVkyWdpcDPbbkfLE8xjaQ
Date: Mon, 18 Mar 2024 02:58:24 +0000
Message-ID: <BN9PR12MB525728E903CD226627D7D162FC2D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240318022520.168079-1-kevinyang.wang@amd.com>
In-Reply-To: <20240318022520.168079-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b11f46ab-25fe-4cde-bed0-24a36fa86077;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T02:28:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7842:EE_
x-ms-office365-filtering-correlation-id: ad4ac82c-c770-41a8-2549-08dc46f74768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KGJZkmjKjbD+31ZZowXhNMs72BUGCo4bRm2LnEv+griaQABheS0LlbmGVHolMUeGnN8EM5wE1tViI34xeTDHQJ7iEWuNA2S1S0yqkxpNxXAOzEEq/qESNWC0xqCCDGZF4vhV6ciuXNYXBaiOUkpTAQOpE2eku4IDTyJDL/rTgBsPTsuVc+wxoOq66GZBU0GKopq0Vsdjdlqdfz7WzBhYMwO1APrMsft8xNmIYbfhOwUEBnYy6t24P0GhRYCgc7n4/SJukdQVh7pbDB1hyV1kYMGE1a6pUxD6JTAkq1wB0lF/ck3OPVcs5YaqGYEv2pdmKUmR0fhDOsNF9n5UZQeTr/IeuMy7PIwzGsm0w0pJa1HPmo6r4KmOjap947uGN3hL5YB+EcR7TqhtW9FfBsoxQSuzEZ6VBFgSb4SiyYOU2jClE8fJhsgRtptn8d0UxgtSVFgITIOXd2TcTXqc6fn7Jdr+CJ8qX9vyGEQx8eg0l15swSYE2VRoVZpQJzmUJ3jAdczFPwyG3oxJYtGTI3lUOov/PIR1/Q+QNKZdLGWZi8qFkbuN9UsJEBzqKXNZFLeS2oJf1+BHgb/HLDmwW+9wCPLEshnaFjYJYPBuzMr53herxKEbT+r3qd5HSkdVTbFokRvLBLTSJDj6BO+4BF6UpD2+0BR9zIZ6bfWcwIj11IYc6H1jMe2d5wBo4L0ko7/6NYw+QRsvbAM4tBs6JXb6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lw2A1+KnEelFiqyViJsI2GUXJry8lH8ZZbgmpXlIZ3fwaxasYCuvCEaWrKVp?=
 =?us-ascii?Q?tDBZ9hQKuU3b56BepZTGUzIxqQT2NMs9+qhHieK6nJdTYddleuFT8CfNwH5S?=
 =?us-ascii?Q?JkdtKMjnEr01xVEA9cnsq2OxRXtKX0BdUutQ5Qmmi96ZJvCdCfYXnXEwyfti?=
 =?us-ascii?Q?wjXdsYW9y39RKgbpMjkNzesSGvda3m0e6fm+H4GvAAG3kqGnFPBs9A16F9U1?=
 =?us-ascii?Q?1RnacKc3AKXgGMJaH4bzKK1dC9pyZEVD1lgKrAhPb5nNEnk/9knqEqv1YGj2?=
 =?us-ascii?Q?D7+mh+JquM0B/C7ID2K0MNkmezozgawOLbdtAM9K64AC6WxJ77o86eh8mZJc?=
 =?us-ascii?Q?4PHU3HPBfgNfEt34mlbeEqzVSMkr+N/uaI0LgrAVMHel0tr5K/x/F7cbOtl8?=
 =?us-ascii?Q?s6vGl+jVRXU69++L3V2PV5M59+JItaGlNDjRxJfEw9sFzK1QX99CXz2xKSWi?=
 =?us-ascii?Q?id3gYxrEjV1JSrg8J662aSHP6O22Oq09ZRz7Z3fToR0XjDuo8g2ZcKSu9eO7?=
 =?us-ascii?Q?QFWTJymT+RJGkxVrqZkPjqBvXxggIaKJISUiujnJ3iEcP4klkv1RyD8MztRH?=
 =?us-ascii?Q?Hi728cLwdoXqmpjg6ofXXHTZReLfSi8fWs0lDZt+TYWNB91S7qLCmrz/6RH0?=
 =?us-ascii?Q?LhZyZUi30Sz9/uVeNLcMJs6xL13ZQnoUoy/IQdmAkf8RVFktM4znxkDwrNdG?=
 =?us-ascii?Q?RCSuJQundgjYOpA656NNWzT5UTfuN6l/W7ljisKt+xbkZUynEkvGOZhI8ZFg?=
 =?us-ascii?Q?NDD+8vuFoCjYCAxhmAPglIK3C3uLAZX/HKueG/36t5Hfyi/UrtPDriKdjEJi?=
 =?us-ascii?Q?VA9RQnOIiPspJJABrnFz7KdJzQujVBDuv2rGtGEg550P2Q5obMcV82TOos21?=
 =?us-ascii?Q?7kChgAMTnPuLEt/DDzsty7OK/QLbIvPT/oljopNbEJkL8J3yToCBLFN8PCC1?=
 =?us-ascii?Q?viJzqkfiOb0MlJb6X0kq3Ornziss2wGXPzg/fAyJGZRaukTf65QQeBExoALP?=
 =?us-ascii?Q?U2JvSsPHhaDHeTLaehkBlS+C4HGszWYl9oMj9XidWuSuW0w6c8/jqdnlPmdQ?=
 =?us-ascii?Q?DJvXnbdc9ZnLYDxvIPNwY6MsifLLXrlCOIZrT458dZzK7KD1SK0AcrMeSO+0?=
 =?us-ascii?Q?4J+ZPUb05Av/PZYXoy5spZ6i+V9G4MpHwdGlnN6pbYoUwmCamZsZIr/Smz+t?=
 =?us-ascii?Q?eSva/dZUV6jhE0pInrjBLNxFp5pP/vuKvLIuU/CmvENIPP9FkzxjnY1bIbCB?=
 =?us-ascii?Q?hHPtFUxx3Z53D00/OSE3zFZnOS4SKARNPoc5pGkU0Z2liNckXbIkaBGh4LpS?=
 =?us-ascii?Q?swBrQpiy8qBfS6q7QWT1VsgSBvRkYYd2PaVL3VVwWmtOphpnOP3NdGu2QqjB?=
 =?us-ascii?Q?c0+vlt5+M/2JllI/3n+f65ObUYTVnsdJmLtmQfxktalPZnIm9ywAY9hJX7cQ?=
 =?us-ascii?Q?MWVZDuqd3FcC326XmmQvjx2zXOWys6/hga/4p2/5OEnBECQGIPySMY5EiLWo?=
 =?us-ascii?Q?NmyGr16beQC3m0rDoGlIkobHu+F6hYFMxbM+8GrwRxDeDKiPOShVBcqI/2fG?=
 =?us-ascii?Q?e1vSFjl30K6oCtRpDl4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4ac82c-c770-41a8-2549-08dc46f74768
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:58:24.8420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuMf632aDUw/ZIRlP3WEf8dd08nRdnPYrtZFHbTiXC8F3wovGyh73r8jBwRCJ5Zk2Kx7t7A/cM17345FN1+zNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, March 18, 2024 10:25
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: add ras event id support for ACA

add ras event id support for ACA.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 29 ++++++++++++++-----------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  2 +-  drivers/gpu/drm/amd/amdgpu/a=
mdgpu_ras.c | 11 +++++-----
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index 53ad76f590a1..ddcb68e60a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -116,20 +116,22 @@ static struct aca_regs_dump {
        {"CONTROL_MASK",        ACA_REG_IDX_CTL_MASK},
 };

-static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int tot=
al, struct aca_bank *bank)
+static void aca_smu_bank_dump(struct amdgpu_device *adev, int idx, int tot=
al, struct aca_bank *bank,
+                             struct ras_query_context *qctx)
 {
+       u64 event_id =3D qctx ? qctx->event_id: 0ULL;
        int i;

-       dev_info(adev->dev, HW_ERR "Accelerator Check Architecture events l=
ogged\n");
+       RAS_EVENT_LOG(adev, event_id, HW_ERR "Accelerator Check Architectur=
e
+events logged\n");
        /* plus 1 for output format, e.g: ACA[08/08]: xxxx */
        for (i =3D 0; i < ARRAY_SIZE(aca_regs); i++)
-               dev_info(adev->dev, HW_ERR "ACA[%02d/%02d].%s=3D0x%016llx\n=
",
-                        idx + 1, total, aca_regs[i].name, bank->regs[aca_r=
egs[i].reg_idx]);
+               RAS_EVENT_LOG(adev, event_id, HW_ERR "ACA[%02d/%02d].%s=3D0=
x%016llx\n",
+                             idx + 1, total, aca_regs[i].name,
+bank->regs[aca_regs[i].reg_idx]);
 }

 static int aca_smu_get_valid_aca_banks(struct amdgpu_device *adev, enum ac=
a_smu_type type,
                                       int start, int count,
-                                      struct aca_banks *banks)
+                                      struct aca_banks *banks, struct ras_=
query_context *qctx)
 {
        struct amdgpu_aca *aca =3D &adev->aca;
        const struct aca_smu_funcs *smu_funcs =3D aca->smu_funcs; @@ -165,7=
 +167,7 @@ static int aca_smu_get_valid_aca_banks(struct amdgpu_device *ade=
v, enum aca_smu_

                bank.type =3D type;

-               aca_smu_bank_dump(adev, i, count, &bank);
+               aca_smu_bank_dump(adev, i, count, &bank, qctx);

                ret =3D aca_banks_add_bank(banks, &bank);
                if (ret)
@@ -390,7 +392,7 @@ static bool aca_bank_should_update(struct amdgpu_device=
 *adev, enum aca_smu_type  }

 static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type =
type,
-                           bank_handler_t handler, void *data)
+                           bank_handler_t handler, struct ras_query_contex=
t *qctx, void
+*data)
 {
        struct amdgpu_aca *aca =3D &adev->aca;
        struct aca_banks banks;
@@ -412,7 +414,7 @@ static int aca_banks_update(struct amdgpu_device *adev,=
 enum aca_smu_type type,

        aca_banks_init(&banks);

-       ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks);
+       ret =3D aca_smu_get_valid_aca_banks(adev, type, 0, count, &banks, q=
ctx);
        if (ret)
                goto err_release_banks;

@@ -489,7 +491,7 @@ static int aca_log_aca_error(struct aca_handle *handle,=
 enum aca_error_type type  }

 static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_han=
dle *handle, enum aca_error_type type,
-                               struct ras_err_data *err_data)
+                               struct ras_err_data *err_data, struct ras_q=
uery_context *qctx)
 {
        enum aca_smu_type smu_type;
        int ret;
@@ -507,7 +509,7 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
        }

        /* udpate aca bank to aca source error_cache first */
-       ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_error=
, NULL);
+       ret =3D aca_banks_update(adev, smu_type, handler_aca_log_bank_error=
,
+qctx, NULL);
        if (ret)
                return ret;

@@ -523,7 +525,7 @@ static bool aca_handle_is_valid(struct aca_handle *hand=
le)  }

 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handl=
e *handle,
-                             enum aca_error_type type, void *data)
+                             enum aca_error_type type, void *data, void *q=
ctx)
 {
        struct ras_err_data *err_data =3D (struct ras_err_data *)data;

@@ -536,7 +538,8 @@ int amdgpu_aca_get_error_data(struct amdgpu_device *ade=
v, struct aca_handle *han
        if (!(BIT(type) & handle->mask))
                return  0;

-       return __aca_get_error_data(adev, handle, type, err_data);
+       return __aca_get_error_data(adev, handle, type, err_data,
+                                   (struct ras_query_context *)qctx);
 }

 static void aca_error_init(struct aca_error *aerr, enum aca_error_type typ=
e) @@ -853,7 +856,7 @@ static int aca_dump_show(struct seq_file *m, enum ac=
a_smu_type type)
                .idx =3D 0,
        };

-       return aca_banks_update(adev, type, handler_aca_bank_dump, (void *)=
&context);
+       return aca_banks_update(adev, type, handler_aca_bank_dump, NULL, (v=
oid
+*)&context);
 }

 static int aca_dump_ce_show(struct seq_file *m, void *unused) diff --git a=
/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgp=
u_aca.h
index 674a5a9da862..247968d6a925 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -198,7 +198,7 @@ int amdgpu_aca_add_handle(struct amdgpu_device *adev, s=
truct aca_handle *handle,
                          const char *name, const struct aca_info *aca_info=
, void *data);  void amdgpu_aca_remove_handle(struct aca_handle *handle);  =
int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle=
 *handle,
-                                    enum aca_error_type type, void *data);
+                             enum aca_error_type type, void *data, void *q=
ctx);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);  v=
oid amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *=
root);  int aca_error_cache_log_bank_error(struct aca_handle *handle, struc=
t aca_bank_info *info, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 357349fcfcca..41b9315099a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1269,7 +1269,8 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev,=
 enum amdgpu_ras_block blk)  }

 static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum =
amdgpu_ras_block blk,
-                                        enum aca_error_type type, struct r=
as_err_data *err_data)
+                                        enum aca_error_type type, struct r=
as_err_data *err_data,
+                                        struct ras_query_context *qctx)
 {
        struct ras_manager *obj;

@@ -1277,7 +1278,7 @@ static int amdgpu_aca_log_ras_error_data(struct amdgp=
u_device *adev, enum amdgpu
        if (!obj)
                return -EINVAL;

-       return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type, err_=
data);
+       return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type,
+err_data, qctx);
 }

 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attrib=
ute *attr, @@ -1334,15 +1335,15 @@ static int amdgpu_ras_query_error_status=
_helper(struct amdgpu_device *adev,
                }
        } else {
                if (amdgpu_aca_is_enabled(adev)) {
-                       ret =3D amdgpu_aca_log_ras_error_data(adev, blk, AC=
A_ERROR_TYPE_UE, err_data);
+                       ret =3D amdgpu_aca_log_ras_error_data(adev, blk, AC=
A_ERROR_TYPE_UE,
+err_data, qctx);
                        if (ret)
                                return ret;

-                       ret =3D amdgpu_aca_log_ras_error_data(adev, blk, AC=
A_ERROR_TYPE_CE, err_data);
+                       ret =3D amdgpu_aca_log_ras_error_data(adev, blk, AC=
A_ERROR_TYPE_CE,
+err_data, qctx);
                        if (ret)
                                return ret;

-                       ret =3D amdgpu_aca_log_ras_error_data(adev, blk, AC=
A_ERROR_TYPE_DEFERRED, err_data);
+                       ret =3D amdgpu_aca_log_ras_error_data(adev, blk,
+ACA_ERROR_TYPE_DEFERRED, err_data, qctx);
                        if (ret)
                                return ret;
                } else {
--
2.34.1

