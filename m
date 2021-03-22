Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC0C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC0D61966
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC0D61966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF93489FD1;
	Mon, 22 Mar 2021 05:57:33 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ACB489FD1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mznT6gs3CCblD99Yyvft8PzufbK+RduP14tyd4FMPjl2zttxOTvTAnDTTJkb5oIEXjl3D7E3KbOszGCGD76P1ww0aAcYlEPRFPT47ndSmZ+QNzGjCe8CAoVU60ajDeUT0jD+8kXfDODvYswbjah+9AEJeMNM+hIHddonHabp7XhjStXkxH1CGpXu/i1yEfxcGciPnUOnDbu46mM2mpZM7c/YyMPiWNumW6wlSmXFpYCycp+xE4mjDVpD5y/J5dDzfiJaviWXXQgkmKjwRpyYf2RTNWIPtHbaIDQpGVXPQkCo0qd5GKP6+pzjkFBDB4woUJ2h+rPyOe5hQkhTVZ+ZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SMm8hWlmDiUFoIo6fnzbu8jMJ9F5RQ7ntDa16DMYnk=;
 b=I53HTj4zrBvQqOs7g2dzfQdgzcvObNmL5pDvoJHpnBmxZBuwWbuX7Gb13dyl8l0lX+XujF4mojLJx5lquKJvDEGO+Abakoccbs5Qy/f/onK3r4RYPudEP2jaWr5z9DZpp6QugXBD9O9uD6UDvSFLppu8rNeuy9mJXLXitZkB9r1I/m8S4TsEjGcdtPzsSZPuW44Yyequ3cOy9gsOUichPBErE1n1VbzsYgVZYBeYqayzMRLywk/f/irpXcv0xol92z6uCBwSkkKYJN+P5y+fSzbJsmbm8Jqf/XDOvz8obTsov8zM2jSgbKXA6qtGtgEonWL+Eh+xDiEU/eYd3LrqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SMm8hWlmDiUFoIo6fnzbu8jMJ9F5RQ7ntDa16DMYnk=;
 b=ALF6DarqRJDMfGX/hIYYB5XZ75jaWq8qgf2FZx/IKq0lyFPSzWbPr++33xJkUHJfnL7eyG5l1n+weH8lJyHD30NorzksyTubIrbX4Ub8rYSQ+rMA7UmEZsnx5HpxITpAgEt1UOb+KiIKWLGlf1Y6+hfNPz/OZFnSRVuVueP7JqI=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:57:31 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:57:31 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/8] drm/amd/pm: Add support for reset completion on
 aldebaran
Thread-Topic: [PATCH v2 3/8] drm/amd/pm: Add support for reset completion on
 aldebaran
Thread-Index: Adce3vtmAyk2bhPSQtqTMLZRxC03mQ==
Date: Mon, 22 Mar 2021 05:57:31 +0000
Message-ID: <MN2PR12MB45495FA1E76284CD652E0C9B97659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b44c57ca-008f-4995-b176-965c3fcd4f21;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3bb5d29-8b59-43c5-1f79-08d8ecf761ce
x-ms-traffictypediagnostic: MN2PR12MB4302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB43025BAA71C4D6FFF8D36F3F97659@MN2PR12MB4302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MmE5tl+pYPNUbrcQ7DHBpFqGVkPzWVk+XiTTHX91Al2iY6XEVadOF9w4I3Vpsy4UAgBpUhuc1dFG4xPf6kN6Z85TWG1SYmcuca1cYIzPqGDthI7ySXGoe9TsRH+QdNYjvh0X37p8dFN0ejcn65ZE+GhvGrKdltvP6zUufuAkBItiAhJ7iVjekB+zA54OsDNJDg6s6HFxzG2yCcFMjYoM8V+tiCIsGBDm9pVqLbL6pezoyswvz1WE1agOLWRrSnJa1yRtwV0NZxhuK9WKFITuce+dg308/IP0lOiHWhbu3/ro5JW355dsmhKfjtjBgSNrLtHE1m9Pj+Biq5lopbeYGHleenCfeAT9Ibm2T6BttbqcLUIsCiZCkPE93iEdOzig26jbV3H7FGddMx7c2fu3L+Lm4RcRyRTphs3oIFsy+octwFZTV7g7SSxqi7B75DOTEpeS8KfuHAzcb3RAW4yUFk7IMdeBhqpK36PKuOAqy2e/8FJ/Ui09W5aJpMxw6QMRNcz8rAtVDUJevKKq4DgZcdL0C1cXySESuM6RQWufq3a6zMPMwLqraHKMqNZPslBdN7mYK4SuXZNw2Ze1ria63Ef1Jy5bWzFx75iWAQCgre2EqP0vCfSRWbnL3BkPhSh3ifoWf+XXFy684jE+srwjgRsAxAJoWpIcEnnZvHkIZfU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(64756008)(66476007)(55236004)(33656002)(66946007)(38100700001)(6506007)(8936002)(5660300002)(4326008)(54906003)(186003)(76116006)(83380400001)(7696005)(66446008)(66556008)(8676002)(71200400001)(2906002)(52536014)(55016002)(26005)(478600001)(316002)(6916009)(86362001)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f3cm1KVKD48zFwyw/k5VsX0T07oQp6DasYGgWWQUdONOALHqQuYu2S1DDfMr?=
 =?us-ascii?Q?T5U02PFJsJht3NLSZbhMdfymgn3Cj+AGNqAxN/Zd4Meki4UyYZBt+svME06C?=
 =?us-ascii?Q?LSF0PsiQxVbbyxF2T+aWUhnNUUCt9xZKaQH/Ntl0PGJ9KMijnAZcyjQwj0if?=
 =?us-ascii?Q?gs7E0VKYDXSXopmIhvyC9JoIbrn65An1ZsjZCRJ89p62vJu0fOSqfYUaagiK?=
 =?us-ascii?Q?3gbSIdpKHJBTBwb5JLAFkjtBbWdL6k0JdkVTHfefOEHsXDPDHBB4UJwB5+QU?=
 =?us-ascii?Q?ekDgrx09wnzMnuK9965Hc+5d/9IUG9Tsc0x3A86PqQZGA55QzaT/xHv7ZLSY?=
 =?us-ascii?Q?eqH+mJM2bJpipgtN+wxlzT+HtF7WBGZIvwQbSk41YYZ3H0WwyHgc62fl5H/l?=
 =?us-ascii?Q?/vciMbFz65Ay0Wh1aUdC2WeWiULsZCRNWTUiFQsnYm069KU91DN+G9pO9hH1?=
 =?us-ascii?Q?nWuETdl/mO21apCmdBJZRy0G45EgOVsWZ2iZvyfhy8DPhTKXRO/BzISMpo7g?=
 =?us-ascii?Q?QWiu5oWnUswtr1PK0mxpX3ioTIys76BG9jMGInL3W6lk372rQWg2ESM0ZyYp?=
 =?us-ascii?Q?XRhYdEjNydrk95edZ8USWDiXkNGbGvIuSlWjh5E1EKN8zOnhhdnEMNDYI90n?=
 =?us-ascii?Q?JBdb4IT0zaJlLhjLEm8tiHf1xdE9b+OQ4hNzAnPaB9B68/V5gMxJ92H47qSE?=
 =?us-ascii?Q?EJEm8akShYwFiwhLnzRFxq+Icl7T6zyvs1xaULn51iRsrCedGEgNVKIF0r4d?=
 =?us-ascii?Q?7UKd35IptE9Xfdp7NrmbWLEGqpHfYNtvgfnGVT/SjZmpefBJ9oYaGTbNQrJy?=
 =?us-ascii?Q?ndnGbfGTDihk8UTgOWJvd7btr4A8Y4k4SVLL997MXbL8PyOSxwGlKjve6H72?=
 =?us-ascii?Q?rp984XR4C2s9a6WH5K2zYxFc9nPszhCT3ho2VKBLE8TKKEgorCLiDiiPUofI?=
 =?us-ascii?Q?tuixMLcox4AWyDGLHZmhMYH2Nz+dbgHyuRZJPX79nm3KewWK88YZcI1h4zDM?=
 =?us-ascii?Q?QyZFScIy5+OyXKTaNrgz0LlhGHT5YRUgLdxWvTQmzjg0F/zyFo7asT811FZz?=
 =?us-ascii?Q?gEG8olWZLdWvTzM8yO/R2vFM3lSTRJWs9dor7ogpXujYClYk6LnEQ+IYz+g+?=
 =?us-ascii?Q?ik1t/JMdbhBH7WajnN80onuUPaTJ4CgrK0INOlMMgL3/hSuGJrC3m0N2M1tS?=
 =?us-ascii?Q?cI1m/PdwnmYBTuqTXfAHiWABi9+fFwlrMFe0SCxXqZx7EUUeVEXtI4D5btdk?=
 =?us-ascii?Q?scD0tmqiCRjKCW19oKnoXETEKTM31sMoOjiOeGF/YSwpi7F9950FPTxVZr7T?=
 =?us-ascii?Q?h7RJXKs7weXkiCblMiTsVgQu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bb5d29-8b59-43c5-1f79-08d8ecf761ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:31.3078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bAK3b3+icgApeLu4GNs/ZAaYkfblkPlfT64KjTj7vcwqI/KKpbNjHJPPhdv1fMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1721078072=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1721078072==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45495FA1E76284CD652E0C9B97659MN2PR12MB4549namp_"

--_000_MN2PR12MB45495FA1E76284CD652E0C9B97659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

v1: On aldebaran, after hardware context restore, another handshake
needs to happen with PMFW so that reset recovery is complete from
PMFW side. Treat this as RESET_COMPLETE event for aldebaran.

v2: Cleanup coding style, info logs

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h  |  3 ++-
drivers/gpu/drm/amd/pm/inc/smu_types.h        |  1 +
drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |  3 +++
.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  4 ++-
.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 27 +++++++++++++++++++
5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/aldebaran_ppsmc.h
index 433dd1e9ec4f..610266088ff1 100644
--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
@@ -100,7 +100,8 @@
#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrHigh 0x40
#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow  0x41
-#define PPSMC_Message_Count                      0x42
+#define PPSMC_MSG_GfxDriverResetRecovery 0x42
+#define PPSMC_Message_Count                                            0x4=
3
 //PPSMC Reset Types
#define PPSMC_RESET_TYPE_WARM_RESET              0x00
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/p=
m/inc/smu_types.h
index 5bfb60f41dd4..89a16dcd0fff 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -225,6 +225,7 @@
               __SMU_DUMMY_MAP(DisableDeterminism),                     \
               __SMU_DUMMY_MAP(SetUclkDpmMode),                         \
               __SMU_DUMMY_MAP(LightSBR),                                  =
          \
+             __SMU_DUMMY_MAP(GfxDriverResetRecovery),
 #undef __SMU_DUMMY_MAP
#define __SMU_DUMMY_MAP(type)    SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h
index 80208e1eefc9..6db3464c09d6 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -268,5 +268,8 @@ int smu_v13_0_get_current_pcie_link_speed(struct smu_co=
ntext *smu);
int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
                                                     bool enablement);
+int smu_v13_0_wait_for_event(struct smu_context *smu, enum smu_event_type =
event,
+                                                  uint64_t event_arg);
+
#endif
#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ec485308b921..472829f5ff1b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -126,7 +126,8 @@ static const struct cmn2asic_msg_mapping aldebaran_mess=
age_map[SMU_MSG_MAX_COUNT
               MSG_MAP(SetExecuteDMATest,                                  =
 PPSMC_MSG_SetExecuteDMATest,                   0),
               MSG_MAP(EnableDeterminism,                     PPSMC_MSG_Ena=
bleDeterminism,                    0),
               MSG_MAP(DisableDeterminism,                                 =
  PPSMC_MSG_DisableDeterminism,                   0),
-              MSG_MAP(SetUclkDpmMode,                                     =
              PPSMC_MSG_SetUclkDpmMode,                            0),
+             MSG_MAP(SetUclkDpmMode,                                      =
  PPSMC_MSG_SetUclkDpmMode,                                        0),
+             MSG_MAP(GfxDriverResetRecovery,                            PP=
SMC_MSG_GfxDriverResetRecovery,                           0),
};
 static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] =3D =
{
@@ -1583,6 +1584,7 @@ static const struct pptable_funcs aldebaran_ppt_funcs=
 =3D {
               .mode1_reset =3D smu_v13_0_mode1_reset,
               .set_mp1_state =3D aldebaran_set_mp1_state,
               .mode2_reset =3D aldebaran_mode2_reset,
+             .wait_for_event =3D smu_v13_0_wait_for_event,
};
 void aldebaran_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index fa0d8ca29982..586b178b7c70 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1374,6 +1374,33 @@ int smu_v13_0_mode1_reset(struct smu_context *smu)
               return ret;
}
+static int smu_v13_0_wait_for_reset_complete(struct smu_context *smu,
+                                                                          =
        uint64_t event_arg)
+{
+             int ret =3D 0;
+
+             dev_dbg(smu->adev->dev, "waiting for smu reset complete\n");
+             ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverResetRecov=
ery, NULL);
+
+             return ret;
+}
+
+int smu_v13_0_wait_for_event(struct smu_context *smu, enum smu_event_type =
event,
+                                                  uint64_t event_arg)
+{
+             int ret =3D -EINVAL;
+
+             switch (event) {
+             case SMU_EVENT_RESET_COMPLETE:
+                             ret =3D smu_v13_0_wait_for_reset_complete(smu=
, event_arg);
+                             break;
+             default:
+                             break;
+             }
+
+             return ret;
+}
+
int smu_v13_0_mode2_reset(struct smu_context *smu)
{
               int ret;
--
2.17.1


--_000_MN2PR12MB45495FA1E76284CD652E0C9B97659MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">v1: On aldebaran, after hardware context restore, an=
other handshake<o:p></o:p></p>
<p class=3D"MsoNormal">needs to happen with PMFW so that reset recovery is =
complete from<o:p></o:p></p>
<p class=3D"MsoNormal">PMFW side. Treat this as RESET_COMPLETE event for al=
debaran.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2: Cleanup coding style, info logs<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h&nbsp; |=
&nbsp; 3 ++-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_types.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +++<o:p></o:p></p>
<p class=3D"MsoNormal">.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbs=
p;&nbsp; |&nbsp; 4 ++-<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbs=
p;&nbsp; | 27 +++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">5 files changed, 36 insertions(+), 2 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_pp=
smc.h b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 433dd1e9ec4f..610266088ff1 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h<o=
:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h<o=
:p></o:p></p>
<p class=3D"MsoNormal">@@ -100,7 +100,8 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrHigh =
0x40<o:p></o:p></p>
<p class=3D"MsoNormal">#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow&n=
bsp; 0x41<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x42<o:p></o:p></p>
<p class=3D"MsoNormal">+#define PPSMC_MSG_GfxDriverResetRecovery 0x42<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x43<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;//PPSMC Reset Types<o:p></o:p></p>
<p class=3D"MsoNormal">#define PPSMC_RESET_TYPE_WARM_RESET&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<o:p></o:=
p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h =
b/drivers/gpu/drm/amd/pm/inc/smu_types.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 5bfb60f41dd4..89a16dcd0fff 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -225,6 +225,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(DisableDeterminism),&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(SetUclkDpmMode),&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(LightSBR),&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; \<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __SMU_DUMMY_MAP(GfxDriverResetRecovery),<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#undef __SMU_DUMMY_MAP<o:p></o:p></p>
<p class=3D"MsoNormal">#define __SMU_DUMMY_MAP(type)&nbsp;&nbsp;&nbsp; SMU_=
MSG_##type<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h =
b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 80208e1eefc9..6db3464c09d6 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -268,5 +268,8 @@ int smu_v13_0_get_current_pcie_l=
ink_speed(struct smu_context *smu);<o:p></o:p></p>
<p class=3D"MsoNormal">int smu_v13_0_gfx_ulv_control(struct smu_context *sm=
u,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bool enablement);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+int smu_v13_0_wait_for_event(struct smu_context *sm=
u, enum smu_event_type event,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; uint64_t event_arg);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/alde=
baran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c<o:p></o:p>=
</p>
<p class=3D"MsoNormal">index ec485308b921..472829f5ff1b 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_p=
pt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -126,7 +126,8 @@ static const struct cmn2asic_msg=
_mapping aldebaran_message_map[SMU_MSG_MAX_COUNT<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetExecuteDMATest,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetExecuteDMATest,&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0),<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(EnableDeterminism,&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_EnableDeterminism,&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0),<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(DisableDeterminism,&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_DisableDeterminism,&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0),<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetUclkDpmMode,&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetUclkDpmMod=
e,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; MSG_MAP(SetUclkDpmMode,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetUclkDpmMode,=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0),<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; MSG_MAP(GfxDriverResetRecovery,&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GfxD=
riverResetRecovery,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0),<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static const struct cmn2asic_mapping aldebaran=
_clk_map[SMU_CLK_COUNT] =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1583,6 +1584,7 @@ static const struct pptable_fu=
ncs aldebaran_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode1_reset =3D smu_v13_0_mode1_reset,<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D aldebaran_set_mp1_state=
,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D aldebaran_mode2_reset,<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .wait_for_event =3D smu_v13_0_wait_for_event,<o:p></o=
:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;void aldebaran_set_ppt_funcs(struct smu_contex=
t *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_=
v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index fa0d8ca29982..586b178b7c70 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c=
<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1374,6 +1374,33 @@ int smu_v13_0_mode1_reset(str=
uct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+static int smu_v13_0_wait_for_reset_complete(struct=
 smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; uint64_t event_arg)=
<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(smu-&gt;adev-&gt;dev, &quot;waiting for smu r=
eset complete\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GfxDriverRe=
setRecovery, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int smu_v13_0_wait_for_event(struct smu_context *sm=
u, enum smu_event_type event,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; uint64_t event_arg)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (event) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case SMU_EVENT_RESET_COMPLETE:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v13_0_wait_for_reset=
_complete(smu, event_arg);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">int smu_v13_0_mode2_reset(struct smu_context *smu)<o=
:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45495FA1E76284CD652E0C9B97659MN2PR12MB4549namp_--

--===============1721078072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1721078072==--
