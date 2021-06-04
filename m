Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09279C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18F96023F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18F96023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE7E6F5E6;
	Fri,  4 Jun 2021 09:12:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1363C6F5E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqXTGqIxEyYv73hyMmbV+L8X9XQYgnRSPwNTYF6b9o+t60ChJQtdkcvLHFrkcnoUB+U3BgQ7rn+DDChSbIeDTMyWe2XGhG3TWGPtb5pdKUpQfX1RT19Q6J2icdOWN7htXFSsIWviGW4UGN8SXggP/3sxkfI18z/PpNbuHWGyRhP9SonzhPgK6O1+LMfmdDkgurx1ngmVpX/eXu1Oi67VzcUeFtgSZbQrb1f1dh/PEM3TTAnYH2lEfUbRVukdrD+IuVgIf1feuCqIK36qBF/OzitroItgtqDRA3KTzO9dPBfD4A0QbZjG1AUGL9K0NtoaIxAE/CO9KHMPL06+c9rOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+LKemXDfbxXx663MXRv5vyHBgl1bF9fdezKVhLd1So=;
 b=Ziw+jkBaC7sVHuRnTpyXwNl6SQgpH/JjYfZL2/3bHLBew7M5qKs7t7CvGJIY/gdz3snLz6huX50LI+/a8sHqXJ+97JJU1UCxh2VHzkIEGTWzb66grnJQfx0pjt7IPCtnxQBlKUg0FIauEIO2al2FIL9n/zjtr9HIUArW3L7OjpCv/FcA0FLW633uA5/0iV4nEnRBGFfJwhy8uvu6SI0AvHq+1tjgs4vhPTf7yqhmw6aQELpTXetuvMp35vLrKC9mhTS3+Gxip/3vD6W472XtySPsxj5dnladV6JfFokDQrsR43rmUbrPwGHzKjaJLYgO9cs51BoFpd3PGAlALnEeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+LKemXDfbxXx663MXRv5vyHBgl1bF9fdezKVhLd1So=;
 b=cRbqIkRTqWxsDSuZeVKxN7NqjVO035Llek/8FYwiXVS048Dp+sThv3PSG6hggeMYSp2xc3TLFHr2NLdJhK+j11Qgz8aOYJlYpvggf+dznt1LF0P9qK/3Mfc9D7zNXPRJ+LCT0K0Z9JYtqoHjq4EQdrp1mstozHne+qTIHPinAMo=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 09:12:07 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 09:12:07 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: Read BIF STRAP also for BACO check
Thread-Topic: [PATCH 1/3] drm/amd/pm: Read BIF STRAP also for BACO check
Thread-Index: AddZIJ6H5I9lXrgHTUaQozuU/A6Hwg==
Date: Fri, 4 Jun 2021 09:12:07 +0000
Message-ID: <CH0PR12MB5348CE5C35CE6C7F74807BD3973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T09:12:02Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d8efa63b-9717-495c-9f42-9a68f33cfe4d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:158d:ec71:65c6:5505:11d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 819261ca-ba5d-440b-128f-08d92738d403
x-ms-traffictypediagnostic: CH0PR12MB5233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5233B81D5BA2857003735408973B9@CH0PR12MB5233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ea2pyksbDi39fW5Uh5y4CFUEZqR2GWO1ZXuwqwcUSYzH6ZfXuyCWuTvuBwcW+2UDa38jHr3AcM4zCjBeb7awzufYOWqExBJGeSjrs9g3EFnkAHqMOkV+LNbgu33UgKUPke309clyKNj+YB5Ni3aJnkQabT5mtiR4LYV1GNLNk69N0gVzWvZ0ZNTCtwIxHkoEs2y9vLDEKSUim6qVJFWxsQSa4xvrWfCLEynbB8yzq1pAU+wqkc2+cwVS23t0+LssLEO/RGrJBIcQOi2JiemPr/sh5oAgJrRN6i01jG+syVYUB5SL9etR9fKBv42sXztVMkdlejct6DQuxTJ7BC06rFcNw+SvodvMJWGfgwh3ZcOzLN6c6/1edz+dfPB/rJYU/yErI1XlmAIal+VgWvFoImo52BxnFD+BDFUFwgSp275XCiGOzj6nTuiCk+YbnEsIxqhwE+XPjla9qnwM/vHYwBlJRmwJFTkIR/ytAMNZvYoYNvq5C4NSy7mv3sAXS8K24sMRkW50uFEpnix5+byEbwaRpikT9ovyhsNB37QjKH9DV88IwKPhvroaiWPoAo4DPyH1e/gLBNo5liwo+AisJlemorpLd908izVUkGESRz0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(2906002)(76116006)(9686003)(55016002)(8936002)(8676002)(83380400001)(186003)(66574015)(54906003)(71200400001)(6506007)(86362001)(33656002)(498600001)(7696005)(4326008)(5660300002)(38100700002)(66946007)(52536014)(64756008)(66556008)(66446008)(122000001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s4tXPxYkVZ37dUsPO5d+5iuIaa4nOLOndm+tGyUYG5+MqDXh5c50vYeWL1Fh?=
 =?us-ascii?Q?QMa3QgyQvassLoMj7aaeF0rulBbEni69TP41hrfWgd9OIPNG3HY9RAx98FNH?=
 =?us-ascii?Q?cT4iA+4+erq+Ni7zn4zesHBgzHnmLGMPYPoYis0vjNNtAFi4JDLBk6Km14s/?=
 =?us-ascii?Q?0pfggf2mJ9hUW8xMQoLorHM0iHkLRb6oaEYDsEOW/EEeRfGMtjZ1FCNgKY4u?=
 =?us-ascii?Q?onfv5bK442RM0E9K+zYb5n/PI/a6kVdBhoU9l3mr4oRCjX9ozEGf7rXspRXQ?=
 =?us-ascii?Q?iOeGt2TsuSgCDMYLJO7KPsJfAXkZqN7MAxNwheOUek0vX8+91Q11mNAKM+Up?=
 =?us-ascii?Q?UXewx95N6X72ANyqBY15sFPPMU7kAzwqjWHZrH8Fzav0a9tHK/CgRrxIIv/o?=
 =?us-ascii?Q?VGayKwOxN9O1+7wMeFlIhBuvxoLpN/D0OjSPsvdiajOM9XSMcAErD6g8LPC3?=
 =?us-ascii?Q?k+UGI+IhizLntEc/ynfpAlOeIdJ8GIumQMzjXfiRrhRYCqb8DcMIVZ6JOaAT?=
 =?us-ascii?Q?BGtm5n+ep8vTKFFtBGP7nZlG8kj23qnUK0GbsFzHDxx9QuBfSxbGry/rRH3P?=
 =?us-ascii?Q?SMrY48tdcIKPU6UZIbkwwaBxnz5ijQu/BrqG4DqEF6NjUfiaaPyiD+8+xjis?=
 =?us-ascii?Q?HW5fdBkPsq/GXl7/MEaLwzamZD7b0HFM4peEglM9nE/7QTF3v/UKBvzRUlWe?=
 =?us-ascii?Q?WIrKblTZfSCJMHFfocSPv+UaN7zMf0FJNkjqNTS/gj1wexe+iqWSfOHX9MrD?=
 =?us-ascii?Q?CR+rPgbmNM9dBlCAAuXwglgkmTTTTJ0G6gfu0uJpAg9+ssw2m7ipx177xprs?=
 =?us-ascii?Q?0LnMYnpT5X0YZ2WZjzzc9zcHPplOJ4C2VagGQDSm8OxASzuBlDerA/yR5an3?=
 =?us-ascii?Q?X5DJaYGJEf0QcicQY5P8sesNNLxFM5QQNWquOi8onImDsIrRjExHIxTaCao6?=
 =?us-ascii?Q?1Z3+yQCb/j60UUsxefqCgWWWpUD5itQ84sqPsvAkf6l8HkfPTzk6TVu/bUEy?=
 =?us-ascii?Q?k/4u8yWmY9JE/rOvi29WyEA2ktiSYHHbLxfbJvMy82XZ5Jqd1afU/c9bm+fd?=
 =?us-ascii?Q?Pn5kUcNQhUdCgWaNXTScoiEIYrg0VRI8xEqoJ9hl0Ar8YvWh8NqFvSXCY8Z2?=
 =?us-ascii?Q?jPOuK66wym58Ex5giRRMEKMsdn4ACcG1a4E72Yp7wSrz/deZ0lLMZRpfffvg?=
 =?us-ascii?Q?FpywIZfKDEc3xbadFShka/nJsR+Zv6bqTmEUbgGYkCD2xs1UP/WyVAZk7fyw?=
 =?us-ascii?Q?Q5a/XWgT8u5a0ym5wDOrTe8ujl53z2qkAAYMiwaExxTijsgxdzG+ejuPsSXu?=
 =?us-ascii?Q?Zig0rLdjxhExtY8G2wKLWEeQeOo51gNdW9n1cmseiJ0O8HxMB4t8OKMJyqj9?=
 =?us-ascii?Q?Ho8pVfFudQrmTpbNDTrb+aVofKPB?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819261ca-ba5d-440b-128f-08d92738d403
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 09:12:07.4943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZImXIyC4gStTbq+7SU6Zvosm4V2vQ9S9McYmz5suxbpAERGXDokLrmiO3WScPP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1283123788=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1283123788==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5348CE5C35CE6C7F74807BD3973B9CH0PR12MB5348namp_"

--_000_CH0PR12MB5348CE5C35CE6C7F74807BD3973B9CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Avoid reading BIF STRAP each time for BACO capability. Read the STRAP
value while checking BACO capability in PPTable.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
.../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 25 ++++++++++++-----
.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 27 ++++++++++++++-----
.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 27 ++++++++++++++-----
3 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..5c248accc4a6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -380,16 +380,31 @@ static int arcturus_set_default_dpm_table(struct smu_=
context *smu)
               return 0;
}
-static int arcturus_check_powerplay_table(struct smu_context *smu)
+static void arcturus_check_bxco_support(struct smu_context *smu)
{
               struct smu_table_context *table_context =3D &smu->smu_table;
               struct smu_11_0_powerplay_table *powerplay_table =3D
                               table_context->power_play_table;
               struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+             struct amdgpu_device *adev =3D smu->adev;
+             uint32_t val;
                if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_C=
AP_BACO ||
-                  powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CA=
P_MACO)
-                              smu_baco->platform_support =3D true;
+                 powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP=
_MACO) {
+                             val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP=
0);
+                             smu_baco->platform_support =3D
+                                             (val & RCC_BIF_STRAP0__STRAP_=
PX_CAPABLE_MASK) ? true :
+                                                                          =
                                                                   false;
+             }
+}
+
+static int arcturus_check_powerplay_table(struct smu_context *smu)
+{
+             struct smu_table_context *table_context =3D &smu->smu_table;
+             struct smu_11_0_powerplay_table *powerplay_table =3D
+                             table_context->power_play_table;
+
+             arcturus_check_bxco_support(smu);
                table_context->thermal_controller_type =3D
                               powerplay_table->thermal_controller_type;
@@ -2150,13 +2165,11 @@ static void arcturus_get_unique_id(struct smu_conte=
xt *smu)
static bool arcturus_is_baco_supported(struct smu_context *smu)
{
               struct amdgpu_device *adev =3D smu->adev;
-              uint32_t val;
                if (!smu_v11_0_baco_is_support(smu) || amdgpu_sriov_vf(adev=
))
                               return false;
-              val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-              return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true =
: false;
+             return true;
}
 static int arcturus_set_df_cstate(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..31e9cc3f3ea0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -340,19 +340,34 @@ navi10_get_allowed_feature_mask(struct smu_context *s=
mu,
               return 0;
}
-static int navi10_check_powerplay_table(struct smu_context *smu)
+static void navi10_check_bxco_support(struct smu_context *smu)
{
               struct smu_table_context *table_context =3D &smu->smu_table;
               struct smu_11_0_powerplay_table *powerplay_table =3D
                               table_context->power_play_table;
               struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+             struct amdgpu_device *adev =3D smu->adev;
+             uint32_t val;
+
+             if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP=
_BACO ||
+                 powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CAP=
_MACO) {
+                             val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP=
0);
+                             smu_baco->platform_support =3D
+                                             (val & RCC_BIF_STRAP0__STRAP_=
PX_CAPABLE_MASK) ? true :
+                                                                          =
                                                                   false;
+             }
+}
+
+static int navi10_check_powerplay_table(struct smu_context *smu)
+{
+             struct smu_table_context *table_context =3D &smu->smu_table;
+             struct smu_11_0_powerplay_table *powerplay_table =3D
+                             table_context->power_play_table;
                if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_C=
AP_HARDWAREDC)
                               smu->dc_controlled_by_gpio =3D true;
-              if (powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CA=
P_BACO ||
-                  powerplay_table->platform_caps & SMU_11_0_PP_PLATFORM_CA=
P_MACO)
-                              smu_baco->platform_support =3D true;
+             navi10_check_bxco_support(smu);
                table_context->thermal_controller_type =3D
                               powerplay_table->thermal_controller_type;
@@ -2245,13 +2260,11 @@ static int navi10_overdrive_get_gfx_clk_base_voltag=
e(struct smu_context *smu,
static bool navi10_is_baco_supported(struct smu_context *smu)
{
               struct amdgpu_device *adev =3D smu->adev;
-              uint32_t val;
                if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(sm=
u)))
                               return false;
-              val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-              return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true =
: false;
+             return true;
}
 static int navi10_set_default_od_settings(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75acdb80c499..6614dbb723be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -323,19 +323,34 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_co=
ntext *smu,
               return 0;
}
-static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
+static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
{
               struct smu_table_context *table_context =3D &smu->smu_table;
               struct smu_11_0_7_powerplay_table *powerplay_table =3D
                               table_context->power_play_table;
               struct smu_baco_context *smu_baco =3D &smu->smu_baco;
+             struct amdgpu_device *adev =3D smu->adev;
+             uint32_t val;
+
+             if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_C=
AP_BACO ||
+                 powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_C=
AP_MACO) {
+                             val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP=
0);
+                             smu_baco->platform_support =3D
+                                             (val & RCC_BIF_STRAP0__STRAP_=
PX_CAPABLE_MASK) ? true :
+                                                                          =
                                                                   false;
+             }
+}
+
+static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
+{
+             struct smu_table_context *table_context =3D &smu->smu_table;
+             struct smu_11_0_7_powerplay_table *powerplay_table =3D
+                             table_context->power_play_table;
                if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM=
_CAP_HARDWAREDC)
                               smu->dc_controlled_by_gpio =3D true;
-              if (powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_=
CAP_BACO ||
-                  powerplay_table->platform_caps & SMU_11_0_7_PP_PLATFORM_=
CAP_MACO)
-                              smu_baco->platform_support =3D true;
+             sienna_cichlid_check_bxco_support(smu);
                table_context->thermal_controller_type =3D
                               powerplay_table->thermal_controller_type;
@@ -2088,13 +2103,11 @@ static int sienna_cichlid_run_btc(struct smu_contex=
t *smu)
static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
{
               struct amdgpu_device *adev =3D smu->adev;
-              uint32_t val;
                if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(sm=
u)))
                               return false;
-              val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
-              return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true =
: false;
+             return true;
}
 static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *sm=
u)
--
2.17.1


--_000_CH0PR12MB5348CE5C35CE6C7F74807BD3973B9CH0PR12MB5348namp_
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
<p class=3D"msipheaderc10f11a2" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Avoid reading BIF STRAP each time for BACO capabilit=
y. Read the STRAP<o:p></o:p></p>
<p class=3D"MsoNormal">value while checking BACO capability in PPTable.<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 25 +=
+++++++++++-----<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nb=
sp; | 27 ++++++++++++++-----<o:p></o:p></p>
<p class=3D"MsoNormal">.../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nb=
sp; | 27 ++++++++++++++-----<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 59 insertions(+), 20 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arct=
urus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<o:p></o:p></=
p>
<p class=3D"MsoNormal">index 1735a96dd307..5c248accc4a6 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -380,16 +380,31 @@ static int arcturus_set_defaul=
t_dpm_table(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static int arcturus_check_powerplay_table(struct sm=
u_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+static void arcturus_check_bxco_support(struct smu_=
context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powerplay=
_table =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;pow=
er_play_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D &amp=
;smu-&gt;smu_baco;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t val;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_cap=
s &amp; SMU_11_0_PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform=
_caps &amp; SMU_11_0_PP_PLATFORM_CAP_MACO)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_supp=
ort =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform_caps =
&amp; SMU_11_0_PP_PLATFORM_CAP_MACO) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mm=
RCC_BIF_STRAP0);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_support =
=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (val &amp; =
RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int arcturus_check_powerplay_table(struct sm=
u_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D &amp;smu-=
&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powerplay_table =3D<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;power_play_tab=
le;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; arcturus_check_bxco_support(smu);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_controller=
_type =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table-&gt;t=
hermal_controller_type;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2150,13 +2165,11 @@ static void arcturus_get_uni=
que_id(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">static bool arcturus_is_baco_supported(struct smu_co=
ntext *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;ade=
v;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_v11_0_baco_is_support(smu) =
|| amdgpu_sriov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return (val &amp; RCC_BIF_STRAP0__STRAP_PX_CAPA=
BLE_MASK) ? true : false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static int arcturus_set_df_cstate(struct smu_c=
ontext *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi=
10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 78fe13183e8b..31e9cc3f3ea0 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -340,19 +340,34 @@ navi10_get_allowed_feature_mas=
k(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static int navi10_check_powerplay_table(struct smu_=
context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+static void navi10_check_bxco_support(struct smu_co=
ntext *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powerplay=
_table =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;pow=
er_play_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D &amp=
;smu-&gt;smu_baco;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t val;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_caps &amp; SMU_11_0_=
PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform_caps =
&amp; SMU_11_0_PP_PLATFORM_CAP_MACO) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mm=
RCC_BIF_STRAP0);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_support =
=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (val &amp; =
RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int navi10_check_powerplay_table(struct smu_=
context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D &amp;smu-=
&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_11_0_powerplay_table *powerplay_table =3D<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;power_play_tab=
le;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_cap=
s &amp; SMU_11_0_PP_PLATFORM_CAP_HARDWAREDC)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;dc_controlled=
_by_gpio =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_caps &amp; SMU=
_11_0_PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform=
_caps &amp; SMU_11_0_PP_PLATFORM_CAP_MACO)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_supp=
ort =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; navi10_check_bxco_support(smu);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_controller=
_type =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table-&gt;t=
hermal_controller_type;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2245,13 +2260,11 @@ static int navi10_overdrive_=
get_gfx_clk_base_voltage(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">static bool navi10_is_baco_supported(struct smu_cont=
ext *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;ade=
v;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (!smu_v=
11_0_baco_is_support(smu)))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return (val &amp; RCC_BIF_STRAP0__STRAP_PX_CAPA=
BLE_MASK) ? true : false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static int navi10_set_default_od_settings(stru=
ct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sien=
na_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<=
o:p></o:p></p>
<p class=3D"MsoNormal">index 75acdb80c499..6614dbb723be 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cich=
lid_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cich=
lid_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -323,19 +323,34 @@ sienna_cichlid_get_allowed_fea=
ture_mask(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static int sienna_cichlid_check_powerplay_table(str=
uct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+static void sienna_cichlid_check_bxco_support(struc=
t smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =
=3D &amp;smu-&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_11_0_7_powerplay_table *powerpl=
ay_table =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;pow=
er_play_table;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_baco_context *smu_baco =3D &amp=
;smu-&gt;smu_baco;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t val;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_caps &amp; SMU_11_0_=
7_PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; powerplay_table-&gt;platform_caps =
&amp; SMU_11_0_7_PP_PLATFORM_CAP_MACO) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mm=
RCC_BIF_STRAP0);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_support =
=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (val &amp; =
RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true :<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int sienna_cichlid_check_powerplay_table(str=
uct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_table_context *table_context =3D &amp;smu-=
&gt;smu_table;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct smu_11_0_7_powerplay_table *powerplay_table =
=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;power_play_tab=
le;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_cap=
s &amp; SMU_11_0_7_PP_PLATFORM_CAP_HARDWAREDC)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;dc_controlled=
_by_gpio =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (powerplay_table-&gt;platform_caps &amp; SMU=
_11_0_7_PP_PLATFORM_CAP_BACO ||<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;powerplay_table-&gt;platform=
_caps &amp; SMU_11_0_7_PP_PLATFORM_CAP_MACO)<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_baco-&gt;platform_supp=
ort =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sienna_cichlid_check_bxco_support(smu);<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_context-&gt;thermal_controller=
_type =3D<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; powerplay_table-&gt;t=
hermal_controller_type;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2088,13 +2103,11 @@ static int sienna_cichlid_ru=
n_btc(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">static bool sienna_cichlid_is_baco_supported(struct =
smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;ade=
v;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (!smu_v=
11_0_baco_is_support(smu)))<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return (val &amp; RCC_BIF_STRAP0__STRAP_PX_CAPA=
BLE_MASK) ? true : false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static bool sienna_cichlid_is_mode1_reset_supp=
orted(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CH0PR12MB5348CE5C35CE6C7F74807BD3973B9CH0PR12MB5348namp_--

--===============1283123788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1283123788==--
