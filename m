Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AA4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 07:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD3B10EA38;
	Mon, 28 Mar 2022 07:43:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD7910EA38
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 07:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSfYovxCre/52xE3zTW4ZP/yNMxzdxoTVGA796CeOd67BrJ+ggyRlzbH98WjqC1ryYlRQCU82AHNKgbsZZPRbb/I3U8kdc2DjFyn29sKA27gTQHeYiY12ZePUYjUTAi5OUBLuCFH4XFGj5T6eliiuE6TCXJsIv2CrI5zO5BndLhQbjayXvwJz8/uHGYrem6pIsrH4GpjCc9BNnn6hJHskFo+fEuQ7GRgb6DRZ1A5UCWnP9SZBy2aOhoK7310OPKEk6H2DxUellZH0VBhPUprfNvWv0mJXMTQc2OeoJyoM7g4lHQH8cpLIEM03hD7sugcM+/sAypLuUucjtzZlnJy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbEJX5OAX0vaPaI5bZgvFDxGK+THtE5OjSNncowE5Jk=;
 b=CegaTSHNFvjKIqRJbpnR6SbYpb2LgWVxD6/kqlU29ugQAv7HeVQloGKFFPDEfT5Q8PHBeQKFFMgniUxcDHKM/mMqjPrV6nTwgBYT0F3MhuibL2XhrAWzArdDGsa2Uz9c566xi8CXj6w4cHTzZXnTKxTcH0bMB2LLksAPPUBNdofqpT39Nh/lmNYiXviU80LStm342O8cbYjOJoAZ2Z46LqUjursPcgQ+rAxuXHGlBAMYC9WXVr/8+JOpU0l/c+kAL3ijG/8G04NizpqJGsof3PzCmdSK167p+mN177Ra0AQpIBM0SLfT88bkts+W++2SH/q183eHuFfl0KBDB49Xmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbEJX5OAX0vaPaI5bZgvFDxGK+THtE5OjSNncowE5Jk=;
 b=RACd0yLNyQRn2I261NM2g1UmUb9ZOP8eTS3yvidtsoF7cSGFpQ4mZwcZuvmiVuTJoMzFdCm+YnNMmxQ3U0OOiN3VXsx6T8LwmPOSbFK/wEv2PunYB8aXAfaW7FqctyEs17Cnuh5a3FD2C7KtKHbRWe1Hg3gGTeuH8r7ZhxtVFnE=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 07:43:21 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 07:43:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Thread-Topic: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support
Thread-Index: AQHYQmya+449NAFu6EOUHh5jm4YppqzUaMWQ
Date: Mon, 28 Mar 2022 07:43:21 +0000
Message-ID: <DM5PR12MB17706851354758760795883DB01D9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
 <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
In-Reply-To: <20220328062453.4156191-6-Mohammadzafar.ziya@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T07:43:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=12604f5a-e55f-4b40-a1cc-73fbb7efd049;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 838dc085-f511-4d0a-f5c0-08da108ea1ce
x-ms-traffictypediagnostic: PH0PR12MB5629:EE_
x-microsoft-antispam-prvs: <PH0PR12MB56297F4619AD993540D4C5F6B01D9@PH0PR12MB5629.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7UXulMUPoNdYNRUaaiC+E+hDVpM3hDk6DVPTaFLEEcKYTP48Yb59O7IaN84VREsKitwORU3sSLP/wafQ3aosJWVH5sEqPDtRQS4AyojPcw3o31dxz8l2FyAiGz0kaa/PoAfoSqAvpnqgjI+v/Z1T8YBEwXXaVzMQ+p836xARikmGAZGhTnLuxyCFQo+lvN2RcdiLVaE7SrPAoz8ZqmFXuQ61Ti9Nwy8kcqTsuqaunYuz+pyANIagaDwxUKeDc93q9GLOnkl/dmV2O/vRwpGycIg3fouFuNEsGEiHiN7KnylcXYoDNWD3CWmXMWZp/sULps8EZp8U3D/ijn+twWOmjHvVX1qObBpAUYBlukZbO6ZgYTuI4aIFWRk69Uyj3d7DvGS248BdRjyDKPsw9wlZKZR/dh/PGvT48JmbioZUTJRtn/Bhj5I9FipZUwn8Wx7d1TK4kISKACbx/fXWS0atsqqKVUdfRWAD8nYAtEGmIc2R851Bxsv4pJvFcIHHrXxQ9AZ4HM36UG9Bhx3Vh9UKPPGBgT9TB/gWi14VfFUZ5Hp4obbE/DlyrDvjaGMwPJNog46NA+Migr/ZSK8iDerv1pnz73u/4M5BJdJlYwRVebY/4xKzIWAYfnafUIArm3ufLTirwoFM/lMBgWxO1nnaI9684GW7zxSbdEVYM00oK6dyWDxDQLS2Q3Xxz8m06VeQIKRLqA7JIUTRcXSBfNzlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(6506007)(7696005)(8676002)(53546011)(8936002)(508600001)(33656002)(186003)(26005)(2906002)(55016003)(66446008)(110136005)(122000001)(64756008)(54906003)(66476007)(76116006)(66946007)(66556008)(71200400001)(4326008)(38100700002)(83380400001)(316002)(38070700005)(5660300002)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p3nxoRc93HWq6xGyTUslHtV+TeVnuFNnffaALIeYfIhfwgYnD573fgzqFrIR?=
 =?us-ascii?Q?R0aeDyj1v5Rme0XP32AwfAmCJ8IKxWY1i0O/gkQyTZNZv9yt2lAziJuQMasa?=
 =?us-ascii?Q?Z7hxlkXJs31oON4lXAr3OPhn/tY/A7Fy2FwDEQWIAhqssGMLHu2O0XY14Ngd?=
 =?us-ascii?Q?1Lpxr12Xi8L1KgdiZrU+Zt98KsSeA9qMhLsv1OqyHIeCRxZ8OfPHi4cyV9bw?=
 =?us-ascii?Q?hISpRC7G7fSbqQJ9uqpEuPoQvEdg/b/iDd3ekObdf+aUc1wrmpchG9H3ySzy?=
 =?us-ascii?Q?XAzxWsrjQjW7+chcZ9G+E7fwIPaVV7Mg0wjLy7g+u1vT30SH/d/mnkFiZsSu?=
 =?us-ascii?Q?4sgFZOfJKzwbwfuoJcPrpijxz0pBtvjx9kazjjusa2vYyWDBE0x3zFsDKgus?=
 =?us-ascii?Q?3s6e0uMRu9gTWUF5HJhzTa7dS/fQ5HhQAwDabZLBZ1DgM4sE5n5vznZ9Yqnr?=
 =?us-ascii?Q?c3jBmU87C5Kz+uVldv4m7jK+gJcyzdPvh6oC0884EIHmNPF7c+8C2KJYrOEq?=
 =?us-ascii?Q?CzCOCRKMrcLrclltb5b12U43+LsVuesoKNNPfwy55kKcumdYv1QXZp+kQRjO?=
 =?us-ascii?Q?uDVb6INBU+3awYGLZrqjF5Yrzk/aKsOH0oBUb+txX8t5qqXlFglclD1FGqS1?=
 =?us-ascii?Q?VDbVjeg+Tfo2rkYzp4uhZyYgSoZemFOT/hgdoViMF0TonTFQlrwAb0/4z/kX?=
 =?us-ascii?Q?VpPW/457LzVdxxGff2Azkr9qKJXcV/eTX8wGV1PdilEd6SPgS0MXnw2kgW5o?=
 =?us-ascii?Q?6wJtCbuwv7VWZSXaAKskRegIrwq66/kMYqOEWxqJsIX1RGPu547h3bNyqx5e?=
 =?us-ascii?Q?VA4VlIA7fiydr3XFyIzn3rEDwXwFH9AJ4Zs+noF9XJX8ItrDX8LHuhiz/y5K?=
 =?us-ascii?Q?Fzsdw1E3p0hJXy/Msd8OhxbEGtW/9/xPMhjYUEDRwTct+e/Jv1Oz0sBZuhX2?=
 =?us-ascii?Q?bPRs/UvmzGl56qpXx9onZvUBfV29gjgbho6fyuiRAuwLSYx8NnH4YT2QIlPk?=
 =?us-ascii?Q?6gp9aIuJj4tAmKicLj+//VNuyCQOZOEWp+dCloBaxLKHwCsmGY/KRypE7Psb?=
 =?us-ascii?Q?0WZu7LFyAPNUo4BLj6tDSsKMf+4TaaSVKLw9p1bKxy2jC3euofinkWkCoOH/?=
 =?us-ascii?Q?h0MVGX0nkcIdV6mKCGNkWxQkLMtoxCoXpLuwaJgrSCQZ+zh2KfBaL4bPnZdL?=
 =?us-ascii?Q?lls1rMBGMACYD0RRAZzrcp323EwXB04U0L64P/QxAtF2DwMOKo+kEekrCYiT?=
 =?us-ascii?Q?yHCPe0DN70hdHlZz3RZyKGgEmaxqxNC1n1FHHTwlEYUxDb8u0uU3N0TurWLs?=
 =?us-ascii?Q?veHpCosFYKmQbIxXjO0vQiwulcdvmgE2vQGGbtE20u3dvkZwqQLHdmBn6aWH?=
 =?us-ascii?Q?A0iCzAj7XHkue36dsq4gHCVN8oW7/wlKOnnMWLhNYgm8U39heFcS0zXFR+Yh?=
 =?us-ascii?Q?UJnJJlweggPTZuhUNpUoZFQYR2OUAqTyqhvwXcoIWjyZqYDh3gmVFI1IXf/h?=
 =?us-ascii?Q?Xnsd4+RlRufT0fcxRcwTeORbiJaQx7q+jQpJZT4Xnlj54d87BoTNpKubYDDd?=
 =?us-ascii?Q?RI8swOmLxYz0U/7Zmnk7+fe8vZH9pxYg5X4ut0m6E5OrFhHwoGnBHVIGJ5AB?=
 =?us-ascii?Q?3gYRn6eXDpNrhEH54sPb+03pZdCWR36yFYQykaEl6H0HaaJv2F0tcyVDSzg1?=
 =?us-ascii?Q?fZ3sVWH+zazKhiFNUJKVcuEcPWb/y8Wcslxe699naxcsjcH6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838dc085-f511-4d0a-f5c0-08da108ea1ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 07:43:21.0723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jspbFQAkggNLJl0UUJhHNyMjE3Zhe9izBkhjyO/EekSw6HuFw6BrkYjoLhp+HOs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



-----Original Message-----
From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>=20
Sent: Monday, March 28, 2022 2:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang=
, Hawking <Hawking.Zhang@amd.com>; Ziya, Mohammad zafar <Mohammadzafar.Ziya=
@amd.com>
Subject: [PATCH v4 5/6] drm/amdgpu/vcn: VCN ras error query support

RAS error query support addition for VCN 2.6

V2: removed unused option and corrected comment format Moved the register d=
efinition under header file

V3: poison query status check added.
Removed error query interface

V4: MMSCH poison check option removed, return true/false refactored.

Signed-off-by: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 71 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h   |  6 +++
 3 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 1e1a3b736859..606df8869b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -508,6 +508,7 @@ struct amdgpu_ras_block_hw_ops {
 	void (*query_ras_error_address)(struct amdgpu_device *adev, void *ras_err=
or_status);
 	void (*reset_ras_error_count)(struct amdgpu_device *adev);
 	void (*reset_ras_error_status)(struct amdgpu_device *adev);
+	bool (*query_poison_status)(struct amdgpu_device *adev);
 };
=20
 /* work flow
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.c
index 1869bae4104b..3988fc647741 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -31,6 +31,7 @@
 #include "soc15d.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v1_0.h"
+#include "vcn_v2_5.h"
=20
 #include "vcn/vcn_2_5_offset.h"
 #include "vcn/vcn_2_5_sh_mask.h"
@@ -59,6 +60,7 @@ static int vcn_v2_5_set_powergating_state(void *handle,  =
static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);  static int vcn_v2_5=
_sriov_start(struct amdgpu_device *adev);
+static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
=20
 static int amdgpu_ih_clientid_vcns[] =3D {
 	SOC15_IH_CLIENTID_VCN,
@@ -100,6 +102,7 @@ static int vcn_v2_5_early_init(void *handle)
 	vcn_v2_5_set_dec_ring_funcs(adev);
 	vcn_v2_5_set_enc_ring_funcs(adev);
 	vcn_v2_5_set_irq_funcs(adev);
+	vcn_v2_5_set_ras_funcs(adev);
=20
 	return 0;
 }
@@ -1930,3 +1933,71 @@ const struct amdgpu_ip_block_version vcn_v2_6_ip_blo=
ck =3D
 		.rev =3D 0,
 		.funcs =3D &vcn_v2_6_ip_funcs,
 };
+
+static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *ad=
ev,
+			uint32_t instance, uint32_t sub_block) {
+	uint32_t poison_stat =3D 0, reg_value =3D 0;
+
+	switch (sub_block) {
+	case AMDGPU_VCN_V2_6_VCPU_VCODEC:
+		reg_value =3D RREG32_SOC15(VCN, instance, mmUVD_RAS_VCPU_VCODEC_STATUS);
+		poison_stat =3D REG_GET_FIELD(reg_value, UVD_RAS_VCPU_VCODEC_STATUS, POI=
SONED_PF);
+		break;
+	default:
+		break;
+	};
+
+	if (poison_stat)
+		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
+			instance, sub_block);
+
+	return poison_stat;
+}
+
+static bool vcn_v2_6_query_poison_status(struct amdgpu_device *adev) {
+	uint32_t inst, sub;
+	uint32_t poison_stat =3D 0;
+
+	for (inst =3D 0; inst < adev->vcn.num_vcn_inst; inst++)
+		for (sub =3D 0; sub < AMDGPU_VCN_V2_6_MAX_SUB_BLOCK; sub++)
+			poison_stat +=3D
+			vcn_v2_6_query_poison_by_instance(adev, inst, sub);
+
+	return poison_stat ? true : false;

[Tao] just want to confirm the logic, if the POISONED_PF of one instance is=
 1 and another is 0, the poison_stat is true, correct?
Can we add a print message for this case? Same question to JPEG.

+}
+
+const struct amdgpu_ras_block_hw_ops vcn_v2_6_ras_hw_ops =3D {
+	.query_poison_status =3D vcn_v2_6_query_poison_status, };
+
+static struct amdgpu_vcn_ras vcn_v2_6_ras =3D {
+	.ras_block =3D {
+		.hw_ops =3D &vcn_v2_6_ras_hw_ops,
+	},
+};
+
+static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev) {
+	switch (adev->ip_versions[VCN_HWIP][0]) {
+	case IP_VERSION(2, 6, 0):
+		adev->vcn.ras =3D &vcn_v2_6_ras;
+		break;
+	default:
+		break;
+	}
+
+	if (adev->vcn.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->vcn.ras->ras_block);
+
+		strcpy(adev->vcn.ras->ras_block.ras_comm.name, "vcn");
+		adev->vcn.ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__VCN;
+		adev->vcn.ras->ras_block.ras_comm.type =3D AMDGPU_RAS_ERROR__POISON;
+		adev->vcn.ras_if =3D &adev->vcn.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_=
init */
+		if (!adev->vcn.ras->ras_block.ras_late_init)
+			adev->vcn.ras->ras_block.ras_late_init =3D amdgpu_ras_block_late_init;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_5.h
index e72f799ed0fd..1c19af74e4fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
@@ -24,6 +24,12 @@
 #ifndef __VCN_V2_5_H__
 #define __VCN_V2_5_H__
=20
+enum amdgpu_vcn_v2_6_sub_block {
+	AMDGPU_VCN_V2_6_VCPU_VCODEC =3D 0,
+
+	AMDGPU_VCN_V2_6_MAX_SUB_BLOCK,
+};
+
 extern const struct amdgpu_ip_block_version vcn_v2_5_ip_block;  extern con=
st struct amdgpu_ip_block_version vcn_v2_6_ip_block;
=20
--
2.25.1
