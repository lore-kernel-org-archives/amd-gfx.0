Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E43C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 12:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C0420674
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 12:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C0420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C826E1B2;
	Mon,  2 Dec 2019 12:00:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770085.outbound.protection.outlook.com [40.107.77.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF51C6E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 12:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZnnjyJwsi8Aa8uEM6vC93oYcvEHGJNnH9B5sCHGddvalagVj4xRXLmzS2HjnSmpxVTdJrPkAOqGar04A8dnVhZnWuZQWcQZkG3hPV2Clnn5R+GMwcgq+mK918ICIym9WIqU5GTn2bPe04y/0uyvzE7PddBuR/LRFKqwI3B3Cb2ddnA2dzFhHMbeFeE7rYe+AkT+nQlXtn1P+7dOH2QmHmYLfhyP/wEe1uYIzFwWUiFfhyTdJHd0YxxaHTgLC4bx2HwM81jKIiENo1UqyBgdpLjpR+QnpL/uGrnkC0HzB1ZQ6klDc96CmZdcDHvicqae2F70knkA34o8TIIPIxukcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOve0LaWZT/Cr3leKbL2V7NV++s746Wcf79Trw9Ygtg=;
 b=e3A3lI/66MUNywKKYeHU/CcVFLxubnXSFgknCm86lAJxSgp3BfqznrYTWWzHfJV4glWhf1nBkxfX/ruuTCVzJu3s6DpUo37Uh8BHPq1+fD04ewk3PMPO8OlCpqZutGHevPpT0QJ0K/+qxrlC9Mj1JiRy/KZGkBisB+3NhAYfCSKj7ArSUofQbC5nhfuZ3fF4P0qjOi0uA8dSSxvG7Kwua86/NuXTRkDSxIeh9A6IZuK2bPas5gEYc/dj1PM5xVVR9PSOMPW4OmHDHngK5SoSGdynKzM4NZzhdZoqxdfkZdSFaG0zE9uvwhS/ICGBrZh9rjP70n1bMAJ30Ua8UH9B6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3296.namprd12.prod.outlook.com (20.179.80.139) by
 MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 11:59:58 +0000
Received: from MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3]) by MN2PR12MB3296.namprd12.prod.outlook.com
 ([fe80::b02a:3af3:a3c2:61f3%6]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 11:59:58 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: unify smu send message function
Thread-Topic: [PATCH] drm/amdgpu/powerplay: unify smu send message function
Thread-Index: AQHVqPfa5Syx+qoX1UqgQFX36ukcx6emvKQK
Date: Mon, 2 Dec 2019 11:59:58 +0000
Message-ID: <MN2PR12MB3296A359D8713488C313BE54A2430@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1575281023-2993-1-git-send-email-likun.gao@amd.com>
In-Reply-To: <1575281023-2993-1-git-send-email-likun.gao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-02T11:59:58.232Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db66db20-1907-4fa6-f08d-08d7771f2794
x-ms-traffictypediagnostic: MN2PR12MB3838:|MN2PR12MB3838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3838422735CE573C49C37806A2430@MN2PR12MB3838.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(189003)(199004)(8936002)(52536014)(81166006)(76176011)(9686003)(6436002)(54896002)(4326008)(6246003)(99286004)(102836004)(186003)(6506007)(55016002)(26005)(110136005)(446003)(478600001)(105004)(25786009)(11346002)(74316002)(33656002)(7696005)(81156014)(8676002)(53546011)(3846002)(229853002)(316002)(19627405001)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(7736002)(66066001)(6116002)(14454004)(2906002)(5660300002)(256004)(14444005)(2501003)(15650500001)(71190400001)(71200400001)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3838;
 H:MN2PR12MB3296.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gr8UzbpVcXZ3i+isCeypo3YISMXCHgULYIUt58vvn1M5RBne/d32mesuEKGt6mVpKGuLTUB+qa/OhbYow/wBmjYvTIw5A/bv4OYASrIicBoRwCq1zHl6cWYDvM0axLOD2qUqgAL6NYBYcTYMntalE+KgWWL3ye3biCCmYbtccGYOo6vxkjMLaPsss4BcCPZKl27jUhCNC5ah3Wcv522uMJDxXaF9dL5znPbUbyB61W4Qi+GZwvEmVdd6RfI8aaerojs8/jV27kG80q4CXOx8QRXhOs7fk0C/IIYg+0Ju8hCPBNF0J+V8u491mpIVE/K5kAHRgAcrFP7YiR9JqbPAtyY7Vw8j9bYcrIcDYzvcC1Cs4WBmkOHJJUDcCGiRbzts9X84BuU8MoFxGiQgXSfpD6Oy64Rtp1vY667367ahymKU6n+IP260xjBn7wCLKw82
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db66db20-1907-4fa6-f08d-08d7771f2794
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 11:59:58.6859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikKUeEf339PoVcBDjN7RKN/RLS1U9pmINJ6ddFgAgotY4GXldoo/zisHbHNS929P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3838
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOve0LaWZT/Cr3leKbL2V7NV++s746Wcf79Trw9Ygtg=;
 b=f0/cUBJy7JiHDkqleiV2nCdmBhcpGjQoa/OtB5WaKAPbyaktY+5ffh600QA0mlEY8KpodvGLGUI2+lFP1d2p/Wx6dm9C6zRBUI/Kg2iJ1PqISanxYvPYy8f8plQF8uKXwq8N7QG+bjDkR3hVLwefqxaeBq4OC0EiY8P3WlvVvBE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============0281061370=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0281061370==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296A359D8713488C313BE54A2430MN2PR12MB3296namp_"

--_000_MN2PR12MB3296A359D8713488C313BE54A2430MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]


________________________________
From: Gao, Likun <Likun.Gao@amd.com>
Sent: Monday, December 2, 2019 6:03 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@am=
d.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu/powerplay: unify smu send message function

From: Likun Gao <Likun.Gao@amd.com>

Drop smu_send_smc_msg function from ASIC specify structure.
Reuse smu_send_smc_msg_with_param function for smu_send_smc_msg.
Set paramer to 0 for smu_send_msg function, otherwise it will send
with previous paramer value (Not a certain value).

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     |  8 ++++++++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  1 -
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  3 ++-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h  |  2 --
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h  |  2 --
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     |  1 -
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c     |  1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h   |  2 --
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 26 ----------------------=
----
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c      | 25 ----------------------=
---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c     |  1 -
 11 files changed, 10 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index 36001a4..e039904 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2567,3 +2567,11 @@ uint32_t smu_get_pptable_power_limit(struct smu_cont=
ext *smu)

         return ret;
 }
+
+int smu_send_smc_msg(struct smu_context *smu, uint16_t msg)
[kevin]:
please use "enum smu_message_type" replace "uint16_t" type.
+{
+       int ret;
+
+       ret =3D smu->ppt_funcs->send_smc_msg_with_param(smu, msg, 0);
[kevin]:
i think use function smu_send_smc_msg_with_param() replace it is better.
after fixed,
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
+       return ret;
+}
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c
index 68107de..3f13986 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2137,7 +2137,6 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .notify_memory_pool_location =3D smu_v11_0_notify_memory_pool_loca=
tion,
         .system_features_control =3D smu_v11_0_system_features_control,
-       .send_smc_msg =3D smu_v11_0_send_msg,
         .send_smc_msg_with_param =3D smu_v11_0_send_msg_with_param,
         .read_smc_arg =3D smu_v11_0_read_arg,
         .init_display_count =3D smu_v11_0_init_display_count,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index ada4a8d..fae1026 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -500,7 +500,6 @@ struct pptable_funcs {
         int (*notify_memory_pool_location)(struct smu_context *smu);
         int (*set_last_dcef_min_deep_sleep_clk)(struct smu_context *smu);
         int (*system_features_control)(struct smu_context *smu, bool en);
-       int (*send_smc_msg)(struct smu_context *smu, uint16_t msg);
         int (*send_smc_msg_with_param)(struct smu_context *smu, uint16_t m=
sg, uint32_t param);
         int (*read_smc_arg)(struct smu_context *smu, uint32_t *arg);
         int (*init_display_count)(struct smu_context *smu, uint32_t count)=
;
@@ -725,4 +724,6 @@ int smu_get_dpm_clock_table(struct smu_context *smu,

 uint32_t smu_get_pptable_power_limit(struct smu_context *smu);

+int smu_send_smc_msg(struct smu_context *smu, uint16_t msg);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index 5a27713..80b1d20 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -177,8 +177,6 @@ int smu_v11_0_notify_memory_pool_location(struct smu_co=
ntext *smu);
 int smu_v11_0_system_features_control(struct smu_context *smu,
                                              bool en);

-int smu_v11_0_send_msg(struct smu_context *smu, uint16_t msg);
-
 int
 smu_v11_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,
                               uint32_t param);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v12_0.h
index 44c65dd..f709f6e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -44,8 +44,6 @@ int smu_v12_0_read_arg(struct smu_context *smu, uint32_t =
*arg);

 int smu_v12_0_wait_for_response(struct smu_context *smu);

-int smu_v12_0_send_msg(struct smu_context *smu, uint16_t msg);
-
 int
 smu_v12_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,
                               uint32_t param);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index f842246..15403b7 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2083,7 +2083,6 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .notify_memory_pool_location =3D smu_v11_0_notify_memory_pool_loca=
tion,
         .system_features_control =3D smu_v11_0_system_features_control,
-       .send_smc_msg =3D smu_v11_0_send_msg,
         .send_smc_msg_with_param =3D smu_v11_0_send_msg_with_param,
         .read_smc_arg =3D smu_v11_0_read_arg,
         .init_display_count =3D smu_v11_0_init_display_count,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index b44ce14..b076589 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -800,7 +800,6 @@ static const struct pptable_funcs renoir_ppt_funcs =3D =
{
         .powergate_sdma =3D smu_v12_0_powergate_sdma,
         .powergate_vcn =3D smu_v12_0_powergate_vcn,
         .powergate_jpeg =3D smu_v12_0_powergate_jpeg,
-       .send_smc_msg =3D smu_v12_0_send_msg,
         .send_smc_msg_with_param =3D smu_v12_0_send_msg_with_param,
         .read_smc_arg =3D smu_v12_0_read_arg,
         .set_gfx_cgpg =3D smu_v12_0_set_gfx_cgpg,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h
index b2d81d3..dd3642d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -77,8 +77,6 @@
 #define smu_set_default_od_settings(smu, initialize) \
         ((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set=
_default_od_settings((smu), (initialize)) : 0)

-#define smu_send_smc_msg(smu, msg) \
-       ((smu)->ppt_funcs->send_smc_msg? (smu)->ppt_funcs->send_smc_msg((sm=
u), (msg)) : 0)
 #define smu_send_smc_msg_with_param(smu, msg, param) \
         ((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send=
_smc_msg_with_param((smu), (msg), (param)) : 0)
 #define smu_read_smc_arg(smu, arg) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c
index b90eb81..acdbb8d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -91,36 +91,10 @@ static int smu_v11_0_wait_for_response(struct smu_conte=
xt *smu)
         return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90) =3D=3D 0x1 ? 0 : =
-EIO;
 }

-int smu_v11_0_send_msg(struct smu_context *smu, uint16_t msg)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       int ret =3D 0, index =3D 0;
-
-       index =3D smu_msg_get_index(smu, msg);
-       if (index < 0)
-               return index;
-
-       smu_v11_0_wait_for_response(smu);
-
-       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-
-       smu_v11_0_send_msg_without_waiting(smu, (uint16_t)index);
-
-       ret =3D smu_v11_0_wait_for_response(smu);
-
-       if (ret)
-               pr_err("failed send message: %10s (%d) response %#x\n",
-                      smu_get_message_name(smu, msg), index, ret);
-
-       return ret;
-
-}
-
 int
 smu_v11_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,
                               uint32_t param)
 {
-
         struct amdgpu_device *adev =3D smu->adev;
         int ret =3D 0, index =3D 0;

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c
index 0451673..143650c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -77,31 +77,6 @@ int smu_v12_0_wait_for_response(struct smu_context *smu)
         return RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90) =3D=3D 0x1 ? 0 : =
-EIO;
 }

-int smu_v12_0_send_msg(struct smu_context *smu, uint16_t msg)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       int ret =3D 0, index =3D 0;
-
-       index =3D smu_msg_get_index(smu, msg);
-       if (index < 0)
-               return index;
-
-       smu_v12_0_wait_for_response(smu);
-
-       WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
-
-       smu_v12_0_send_msg_without_waiting(smu, (uint16_t)index);
-
-       ret =3D smu_v12_0_wait_for_response(smu);
-
-       if (ret)
-               pr_err("Failed to send message 0x%x, response 0x%x\n", inde=
x,
-                      ret);
-
-       return ret;
-
-}
-
 int
 smu_v12_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,
                               uint32_t param)
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index 02ede5c..12bcc3e 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -3231,7 +3231,6 @@ static const struct pptable_funcs vega20_ppt_funcs =
=3D {
         .set_tool_table_location =3D smu_v11_0_set_tool_table_location,
         .notify_memory_pool_location =3D smu_v11_0_notify_memory_pool_loca=
tion,
         .system_features_control =3D smu_v11_0_system_features_control,
-       .send_smc_msg =3D smu_v11_0_send_msg,
         .send_smc_msg_with_param =3D smu_v11_0_send_msg_with_param,
         .read_smc_arg =3D smu_v11_0_read_arg,
         .init_display_count =3D smu_v11_0_init_display_count,
--
2.7.4


--_000_MN2PR12MB3296A359D8713488C313BE54A2430MN2PR12MB3296namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Gao, Likun &lt;Likun.=
Gao@amd.com&gt;<br>
<b>Sent:</b> Monday, December 2, 2019 6:03 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Feng, Kenneth &lt=
;Kenneth.Feng@amd.com&gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/powerplay: unify smu send message functi=
on</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
Drop smu_send_smc_msg function from ASIC specify structure.<br>
Reuse smu_send_smc_msg_with_param function for smu_send_smc_msg.<br>
Set paramer to 0 for smu_send_msg function, otherwise it will send<br>
with previous paramer value (Not a certain value).<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 8 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/arcturus_ppt.c&nbsp;&nbsp; |&nbsp; 1 -<=
br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |&nbsp; 3 &#43;&#43;-<=
br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h&nbsp; |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_internal.h&nbsp;&nbsp; |&nbsp; 2 --=
<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v11_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 26 --------------------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smu_v12_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 25 -------------------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp; 1 -<br>
&nbsp;11 files changed, 10 insertions(&#43;), 62 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index 36001a4..e039904 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -2567,3 &#43;2567,11 @@ uint32_t smu_get_pptable_power_limit(struct smu_=
context *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&#43;<br>
&#43;int smu_send_smc_msg(struct smu_context *smu, uint16_t msg)</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">please use &quot;enum smu_message_type&quot; repla=
ce &quot;uint16_t&quot; type.<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu-&gt;ppt_funcs-&gt;sen=
d_smc_msg_with_param(smu, msg, 0);</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">i think use function smu_send_smc_msg_with_param()=
 replace it is better.</div>
<div class=3D"PlainText">after fixed,</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt=
;</div>
<div class=3D"PlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r=
et;<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm=
/amd/powerplay/arcturus_ppt.c<br>
index 68107de..3f13986 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c<br>
@@ -2137,7 &#43;2137,6 @@ static const struct pptable_funcs arcturus_ppt_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_memory_pool_locati=
on =3D smu_v11_0_notify_memory_pool_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D smu_v11_0_system_features_control,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg =3D smu_v11_0_send_msg,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg_with_param =
=3D smu_v11_0_send_msg_with_param,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_smc_arg =3D smu_v11_=
0_read_arg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_display_count =3D sm=
u_v11_0_init_display_count,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index ada4a8d..fae1026 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -500,7 &#43;500,6 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_memory_pool_l=
ocation)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_last_dcef_min_de=
ep_sleep_clk)(struct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*system_features_cont=
rol)(struct smu_context *smu, bool en);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*send_smc_msg)(struct smu_contex=
t *smu, uint16_t msg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*send_smc_msg_with_pa=
ram)(struct smu_context *smu, uint16_t msg, uint32_t param);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_smc_arg)(struct=
 smu_context *smu, uint32_t *arg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*init_display_count)(=
struct smu_context *smu, uint32_t count);<br>
@@ -725,4 &#43;724,6 @@ int smu_get_dpm_clock_table(struct smu_context *smu=
,<br>
&nbsp;<br>
&nbsp;uint32_t smu_get_pptable_power_limit(struct smu_context *smu);<br>
&nbsp;<br>
&#43;int smu_send_smc_msg(struct smu_context *smu, uint16_t msg);<br>
&#43;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index 5a27713..80b1d20 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -177,8 &#43;177,6 @@ int smu_v11_0_notify_memory_pool_location(struct sm=
u_context *smu);<br>
&nbsp;int smu_v11_0_system_features_control(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en);<br>
&nbsp;<br>
-int smu_v11_0_send_msg(struct smu_context *smu, uint16_t msg);<br>
-<br>
&nbsp;int<br>
&nbsp;smu_v11_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v12_0.h<br>
index 44c65dd..f709f6e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h<br>
@@ -44,8 &#43;44,6 @@ int smu_v12_0_read_arg(struct smu_context *smu, uint3=
2_t *arg);<br>
&nbsp;<br>
&nbsp;int smu_v12_0_wait_for_response(struct smu_context *smu);<br>
&nbsp;<br>
-int smu_v12_0_send_msg(struct smu_context *smu, uint16_t msg);<br>
-<br>
&nbsp;int<br>
&nbsp;smu_v12_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index f842246..15403b7 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -2083,7 &#43;2083,6 @@ static const struct pptable_funcs navi10_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_memory_pool_locati=
on =3D smu_v11_0_notify_memory_pool_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D smu_v11_0_system_features_control,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg =3D smu_v11_0_send_msg,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg_with_param =
=3D smu_v11_0_send_msg_with_param,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_smc_arg =3D smu_v11_=
0_read_arg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_display_count =3D sm=
u_v11_0_init_display_count,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index b44ce14..b076589 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -800,7 &#43;800,6 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_sdma =3D smu_v1=
2_0_powergate_sdma,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_vcn =3D smu_v12=
_0_powergate_vcn,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_jpeg =3D smu_v1=
2_0_powergate_jpeg,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg =3D smu_v12_0_send_msg,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg_with_param =
=3D smu_v12_0_send_msg_with_param,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_smc_arg =3D smu_v12_=
0_read_arg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_gfx_cgpg =3D smu_v12_=
0_set_gfx_cgpg,<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm=
/amd/powerplay/smu_internal.h<br>
index b2d81d3..dd3642d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_internal.h<br>
@@ -77,8 &#43;77,6 @@<br>
&nbsp;#define smu_set_default_od_settings(smu, initialize) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;s=
et_default_od_settings ? (smu)-&gt;ppt_funcs-&gt;set_default_od_settings((s=
mu), (initialize)) : 0)<br>
&nbsp;<br>
-#define smu_send_smc_msg(smu, msg) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;send_smc_msg=
? (smu)-&gt;ppt_funcs-&gt;send_smc_msg((smu), (msg)) : 0)<br>
&nbsp;#define smu_send_smc_msg_with_param(smu, msg, param) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;s=
end_smc_msg_with_param? (smu)-&gt;ppt_funcs-&gt;send_smc_msg_with_param((sm=
u), (msg), (param)) : 0)<br>
&nbsp;#define smu_read_smc_arg(smu, arg) \<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v11_0.c<br>
index b90eb81..acdbb8d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
@@ -91,36 &#43;91,10 @@ static int smu_v11_0_wait_for_response(struct smu_c=
ontext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0=
, mmMP1_SMN_C2PMSG_90) =3D=3D 0x1 ? 0 : -EIO;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_v11_0_send_msg(struct smu_context *smu, uint16_t msg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D smu_msg_get_index(smu, msg)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &lt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return index;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_wait_for_response(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_90, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v11_0_send_msg_without_waiting(sm=
u, (uint16_t)index);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_0_wait_for_response(s=
mu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;failed send message: %10s (%d) response %#x\n&quot;=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_get_message_name(s=
mu, msg), index, ret);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-}<br>
-<br>
&nbsp;int<br>
&nbsp;smu_v11_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param)<br>
&nbsp;{<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index =3D 0=
;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/am=
d/powerplay/smu_v12_0.c<br>
index 0451673..143650c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c<br>
@@ -77,31 &#43;77,6 @@ int smu_v12_0_wait_for_response(struct smu_context *=
smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(MP1, 0=
, mmMP1_SMN_C2PMSG_90) =3D=3D 0x1 ? 0 : -EIO;<br>
&nbsp;}<br>
&nbsp;<br>
-int smu_v12_0_send_msg(struct smu_context *smu, uint16_t msg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, index =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D smu_msg_get_index(smu, msg)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (index &lt; 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return index;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v12_0_wait_for_response(smu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG=
_90, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v12_0_send_msg_without_waiting(sm=
u, (uint16_t)index);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v12_0_wait_for_response(s=
mu);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_err(&quot;Failed to send message 0x%x, response 0x%x\n&quot;,=
 index,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-<br>
-}<br>
-<br>
&nbsp;int<br>
&nbsp;smu_v12_0_send_msg_with_param(struct smu_context *smu, uint16_t msg,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t param)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index 02ede5c..12bcc3e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -3231,7 &#43;3231,6 @@ static const struct pptable_funcs vega20_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_tool_table_location =
=3D smu_v11_0_set_tool_table_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .notify_memory_pool_locati=
on =3D smu_v11_0_notify_memory_pool_location,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D smu_v11_0_system_features_control,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg =3D smu_v11_0_send_msg,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg_with_param =
=3D smu_v11_0_send_msg_with_param,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_smc_arg =3D smu_v11_=
0_read_arg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_display_count =3D sm=
u_v11_0_init_display_count,<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB3296A359D8713488C313BE54A2430MN2PR12MB3296namp_--

--===============0281061370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0281061370==--
