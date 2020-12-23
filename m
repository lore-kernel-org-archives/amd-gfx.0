Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE61DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 07:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC5C222F9
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 07:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC5C222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED166E8C9;
	Wed, 23 Dec 2020 07:28:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F816E8C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Dec 2020 07:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGedEyAjBt8+zzABh7WXwXRnFSmaaGH1+qa/fmTggzK8Yxjle0bsE2j2U0ebVygKZYGdcqpy9uJxf+VJOkQ3xy8C8PBNq2Wo6iGPmCkTXpalx6Jf9TXiaVNnL8M08WPqk6ZQEYUaPhXONSbnZcuZ0lyo1kjUDvWnqrNncHJRAAEQ4Pn8+mgu4el7I8SDopqlO1CApl3ylhS065pqtVA3bJLfPnrOklIxBJGeeLXWbJyrQ6aS4+Gkgx7nJHi9IwPLZizUDm7Y2qmHa2OlLcVDfGaBnpUyMYL45f7OevENYmO6GcN4uplakbsXTRiMKR+K55Wl1zf481zywqXqjxpWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK4glaFKHdEuBNus/RCWCaxhOKeXtEmIhCVXf9dwc94=;
 b=G8XALFRwyRThf820NyieyzrKwpcJf7/0dSembju7ainOZwQKJyh45pNeL9iXHNOJoyORirXL2GsY0+OaeiTUbbcLzpaY/Te9wJadSALhYgu2WNvEVFaOnzXUPFs4vRf2CVzmbKtLH6c9zaWOp57ACYJfbdaM6Bxo2euvHcvPLeqeU7RXxQKu7FnLC3CsXz9qLEGr8k6u/PpVifM20sF2/2BZtMm8wJ2BL3CQwQvuuWvUFn1YSG2BTiT3tUPZNCRt4QSP15BWvbJugRF8LiO/9MAiNl+MMaCW647UdB7fD+CjiK5+Fmi4xWSM7pstI0R5LyjjtGF7wgzPC6QQDO/meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK4glaFKHdEuBNus/RCWCaxhOKeXtEmIhCVXf9dwc94=;
 b=AnRcKfHxo/Ct7i4Mein6q7tXuTT1LjRrW/m7voRjONJtPz/BmluWwjxzRGjjKOWpCgkT7zcc3Z/dMYbQMvcj/bnTqDe59cAw8yIKn0cUlFqeVqrpWvpp2HpglzjGvXE3Jvlb2QUffzG2DZwcTwtONQ9Pb1mh2RUuBa30EA0a4uc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.29; Wed, 23 Dec 2020 07:28:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3676.029; Wed, 23 Dec 2020
 07:28:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: revise the mode2 reset for vangogh
Thread-Topic: [PATCH] drm/amdgpu: revise the mode2 reset for vangogh
Thread-Index: AQHW2NCCyJMVH+F4/kelakw2Y3yFLqoERztQ
Date: Wed, 23 Dec 2020 07:28:18 +0000
Message-ID: <DM6PR12MB26190A8D4E35A9FEFF93D431E4DE0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201223020739.2383191-1-ray.huang@amd.com>
In-Reply-To: <20201223020739.2383191-1-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=140420de-7e72-46d4-ae1b-cfd60c431a9d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-23T07:22:54Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 818f873b-5ec5-4833-a2a3-08d8a7145215
x-ms-traffictypediagnostic: DM6PR12MB2892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2892A948D33CCD32DDD8FED6E4DE0@DM6PR12MB2892.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLmklr7rDk8hmdglyPi+FT6EjYI8Z7DBSSLBCYgS2qFcJb6J3o9SZSnSyCadS5yk4ATnbnRPGp26cLIPHRfKfYjs8BG5fcUdbKH7XQ08WmVEMhll75ePFFvO/ksr9ZbIt5kIRwkbFH7+eUrO8busRUzUPun2VfOmvTbtOpZ5ZA8/DgrrpbPC3ZL7M2UuHG2lOBSQ6nGOpQrvWq/B6ne9b3LWQq/5JUdUXU3S+ihrN/K2n3v3X3fTMSloycnFp89AQFyJL5uZNyqSGP0fRv9WY/vLtTvCnq2DooKFAdz9ydm8VOmqN3sOfTpshnJI5XD+5PDqzDuNB7BqHIMzv2Hjm16ufTHiomPbLzAY35FEipfhkYZPz7BtPJc2sn/MHge9ftMJ39LdzzELRPlR13R8APFl9o1MtPYdLaF00j7aK+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(9686003)(66946007)(966005)(66446008)(55016002)(66476007)(2906002)(7696005)(76116006)(64756008)(5660300002)(478600001)(66556008)(53546011)(186003)(52536014)(26005)(6506007)(8676002)(86362001)(33656002)(4326008)(45080400002)(83380400001)(54906003)(316002)(8936002)(71200400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8Q3wnDk7F7nDPTfPBa/agyMJW/0QbcIxg85w0eLUwC3hTAtI1BuAPvbo7iMf?=
 =?us-ascii?Q?6Ry6FNghFZNC4ABkaeXhaVi85poFFZnxgIQ3HB1B0hqS54mEk7CilDeGZhr0?=
 =?us-ascii?Q?FS+ImaeVpav2bCIN7b5uBrrkxsJHO5gKBvUbqWne/6OKAFSV0ztSD/kZo+5P?=
 =?us-ascii?Q?fxfaC/QUVoylA9gx/OWqd1ocvBeB1CD34oNCBTBIiG/f5Lgc8DU3e7C6iZww?=
 =?us-ascii?Q?LvD3JiI/V3oOk9uL72eXUzfhX8mqPRYNArFZtLoQpFsruYsCNpz5QAAm3UFJ?=
 =?us-ascii?Q?qHe4dknZDVT6QA9RTwYAMoxLoS1vAe6P43SY8tWd8nfz7GIqf2BOWNWrZ18w?=
 =?us-ascii?Q?GG9fi0kOVvG7mS08/E4HfYlvQ8r0Nw4jYrprCNfaCmnMgJ4g96SNFHV5Yoe2?=
 =?us-ascii?Q?mlPfGENJctQCB80u0N3s9SFmpQXbJYT6XWi3dvycFstVWzHM4ynMbGs4vDiN?=
 =?us-ascii?Q?HeH3YvCexIRg9zQQlpBX6HKZxMFG4TdrQJha1k3sRoOYGvLm4y74QQZN1H9q?=
 =?us-ascii?Q?50KY3lJjcPvyjDH9GdUVtw6sgAnz/zlNgIDJvS/5pq+biepe6knbENHRZ7TV?=
 =?us-ascii?Q?AWCliP2sGv/Gtpl3RjhCCHZabpOdjrRAl8tZcd69OPPTLirkiA8KTHbucPlb?=
 =?us-ascii?Q?Y7DSi/mwK448v41pdvHp/dnM7usDPTH9gQ8aZsyyvbcESk7Q8WQv79ruu1L0?=
 =?us-ascii?Q?JXjLqk6jesiNALDrBbCEdsD9GV9qrVKjy993CcJ2R33hKZVixRMyYWQga+bY?=
 =?us-ascii?Q?Wjnn1F0+g0pc92DemREYSYXy1iMvv4u0c/wyz2Oyvhavw73jlEVIT1enMTTo?=
 =?us-ascii?Q?fNug+X7B04NMpmHs4+5/UN7OhU2UxskiXIoDT+mJwmd/2mtdOXLiL/Vl2FMC?=
 =?us-ascii?Q?0qCCXTAzw1dcXHzFabKoC409Guz9lr7Okq3iAMnEpzOCMa4tMo1XVzPYwqdo?=
 =?us-ascii?Q?jMw3lnWV09E/2n+bKVKIhn+L3rfDgRsZbAosnRQRmtg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f873b-5ec5-4833-a2a3-08d8a7145215
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 07:28:18.9810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an6fp7aD+rhdpGLMF/YOr+J66W4kwyqbjDyARNxLkJpXRD47Im3MWzBd/hzbsGG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Su,
 Jinzhou \(Joe\)" <Jinzhou.Su@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Wednesday, December 23, 2020 10:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: revise the mode2 reset for vangogh

PCIE MMIO bar needs to be restored firstly after the reset event
triggers. So it's unable to access the registers to wait for response
from SMU. Becasue the value of mmMP1_SMN_C2PMSG_90 is invalid at that
moment.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 22 +++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 42 ++++++++++---------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 +
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 49864efdeffe..93328eaec0da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -888,9 +888,29 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 return 0;
 }

+static int vangogh_mode_reset(struct smu_context *smu, int type)
+{
+int ret = 0, index = 0;
+
+index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
+       SMU_MSG_GfxDeviceDriverReset);
+if (index < 0)
+return index == -EACCES ? 0 : index;
+
+mutex_lock(&smu->message_lock);
+
+ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
+
+mutex_unlock(&smu->message_lock);
+
+mdelay(10);
+
+return ret;
+}
+
 static int vangogh_mode2_reset(struct smu_context *smu)
 {
-return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
+return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
 }

 static const struct pptable_funcs vangogh_ppt_funcs = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 76ca41653354..39d5edb8c16b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -68,14 +68,6 @@ static const char *smu_get_message_name(struct smu_context *smu,
 return __smu_message_names[type];
 }

-static void smu_cmn_send_msg_without_waiting(struct smu_context *smu,
-     uint16_t msg)
-{
-struct amdgpu_device *adev = smu->adev;
-
-WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
-}
-
 static void smu_cmn_read_arg(struct smu_context *smu,
      uint32_t *arg)
 {
@@ -104,6 +96,26 @@ static int smu_cmn_wait_for_response(struct smu_context *smu)
 return RREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90) == 0x1 ? 0 : -EIO;
 }

+int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+     uint16_t msg, uint32_t param)
+{
+struct amdgpu_device *adev = smu->adev;
+int ret;
+
+ret = smu_cmn_wait_for_response(smu);
+if (ret) {
+dev_err(adev->dev, "Msg issuing pre-check failed and "
+       "SMU may be not in the right state!\n");
+return ret;
+}
+
+WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);
+WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
+WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_66, msg);
+
+return 0;
+}
+
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
     enum smu_message_type msg,
     uint32_t param,
@@ -122,18 +134,10 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 return index == -EACCES ? 0 : index;

 mutex_lock(&smu->message_lock);
-ret = smu_cmn_wait_for_response(smu);
-if (ret) {
-dev_err(adev->dev, "Msg issuing pre-check failed and "
-       "SMU may be not in the right state!\n");
-goto out;
-}
-
-WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_90, 0);

-WREG32_SOC15_NO_KIQ(MP1, 0, mmMP1_SMN_C2PMSG_82, param);
-
-smu_cmn_send_msg_without_waiting(smu, (uint16_t)index);
+ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, param);
+if (ret)
+goto out;

 ret = smu_cmn_wait_for_response(smu);
 if (ret) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 01e825d83d8d..08ccf2d3257c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -26,6 +26,8 @@
 #include "amdgpu_smu.h"

 #if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
+     uint16_t msg, uint32_t param);
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
     enum smu_message_type msg,
     uint32_t param,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C7f292c1025234e6c2d2b08d8a6e7a3d5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637442861103766873%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6qYjw519hhNI77EiaBSgDskyt%2BOoHyoD9KOQW6on0aw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
