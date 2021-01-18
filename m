Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3B0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 02:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95756224DF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 02:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95756224DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D7589A4B;
	Mon, 18 Jan 2021 02:07:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D92389A34
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 02:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtzS5OMjqIl+tzI8abI1OnjGcESlry8rmYPzbmcoduZ7wFrtLF70UswgZdQL/cw51xYS1vkKvGQDnV0tbO5SI/PWASZafD9kVNrsR18f3d9ZXiJWR4QC18LiiGgEWyIiNidI5uCJ6aF1I7q+EJZN8N3N9o+VKTh4QP432IXuFKORE6fWIbsPIrXIKl94DlfwDxHW7kJfvueqEnaaSTEitgvo3mwquDc1TZS27bN1mDdF3R5Z+CkSdmDfHQ/g0ekgQYJUpEn75Y7PV4g3Vr2tO5mNI8W9yDfg9BnNCzB01Pi/CKn6Kpftmib4P/5YxzcS38znVyMoMRZXuShaG77wlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DywE8KggmwPJUJLYOB36iQ8j/bkpuooq1Mv8Sk/eKKE=;
 b=MW+xfrpKgTJa4ptcpvkTYpVpPUgTZjRygEGE7Rw+wd8GMdN4WFu2wTRbugpNuQB8xAJ+spIbf6/tzd1QP/IOTwjHeVnWXDZ6VmF7jlV3PjHf7nvFwLpTgsN7DaRdA6uOCBsWnLgRahyDP7BBXX5dwGhp/TByfixoVxGvN88y3HH9ik9zoNqPPBmLBp6BulfvpCv7wmXdQs1vMBCbsOEVO20zbNdsPS/7Ga0JtZL9ipkMa5AkjlOsTLnQR1CVL+lFMbbPnFYZnAWqc81c7xW9oNAskOieSsAMjIg+kaqRAQd4QtI7ycsMnBjckxgxC+XduZmgzLMjJdg8UVsAHb019A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DywE8KggmwPJUJLYOB36iQ8j/bkpuooq1Mv8Sk/eKKE=;
 b=JAi/y7G5f5+6exkf4OnmGoXyWzSgmaAB/6cGQlNS3FVrr3OQ9w6bfK3gWMxx993sSu1mE3hwAbvj/LDau/4aQ1gYtriIEA6RuwRadYRfAn1J8dpEYqSHoj1YTQyKMd0XzE7t0Ub24jcPCNjfTmZ2pXXcNr47IY1vXf+ma8k9uqU=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0119.namprd12.prod.outlook.com (2603:10b6:910:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 02:06:57 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Mon, 18 Jan 2021
 02:06:57 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Topic: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state
 retrieving(V2)
Thread-Index: AQHW7Tz21ePRtG435UCceXKUsiTbuKosooyA
Date: Mon, 18 Jan 2021 02:06:57 +0000
Message-ID: <CY4PR12MB1287D18491168A039F061F7BF1A40@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210118015452.418724-1-evan.quan@amd.com>
In-Reply-To: <20210118015452.418724-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-18T02:06:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b592278c-2673-44de-95a3-8edc48a3e18e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8d2df640-24fc-4552-703e-08d8bb55bc36
x-ms-traffictypediagnostic: CY4PR1201MB0119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01194092A0F485BA9BD562A9F1A40@CY4PR1201MB0119.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzS2ICJB+6XexJq3Z+ruV3QLSXZZkAogUFsDAh2Dwdx7VWPt+tTArBd0QgKDZjlyK3HP1XK2h4cgOmqzssxiXo4vduOtEmudu3N3XCP6Efu6YWWR8YXqnE8Qr1VdC660yphHwRf7OUwI7q3yUajyRjjs+WiuFCK3NIdum6qKcVvgi7njoRQF9Hx+LFZL7CozwdryQ+JHWWrz/cXxJhT+ntQcm+EWR6j2G+p6UsbjvgVh7ytqZUp9GeNqokTDXZjXI2cCXUopF+ytr77P8in8+WQgi7BXk3wlZCOxiUtnVrDZKkmtIfD68t5qG497KCZ31Il7KgpY+NsJhAArEz9W7iNCjdJj4gtaMZPSsPn+fEhAED6kW46CAeKWX4ffEuSyg2mTlOGF4NaZeS6aKNhO2ulFZAY6DpNu1EvxmgYoladkt1VRiJsrdOJ1vIWC0HhwR6wdzLTeeASom+NU8PVacw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(66556008)(66476007)(9686003)(66946007)(55016002)(6506007)(110136005)(186003)(76116006)(2906002)(26005)(33656002)(8676002)(5660300002)(53546011)(478600001)(64756008)(52536014)(7696005)(83380400001)(71200400001)(8936002)(316002)(4326008)(86362001)(66446008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VA2hiuVRd0lfcNkGq6lVKtKHJZashP+5A/tVnYuSMgnzXpHgZwRvdIyiKbSp?=
 =?us-ascii?Q?SujDy73XEATu/loyoCFVoYu7ssFd3CMkF3pwiuHVVbkB2NFUvKOeLSBFQK1t?=
 =?us-ascii?Q?CjyhfVVDAra1jUYtjfMs1wIt0JnuG5uVUAREUuhzwZEJK9JEGM0KI6D51Keg?=
 =?us-ascii?Q?wr3t+Y51bgk5Zr3Y1dp4bdVdjKR8XMyjJJvgz4y39jb6cOYqanjQhRE57b+X?=
 =?us-ascii?Q?O9Vnbmi9v9e+E5bRbuvKQT5Z5PrgDLP1l9ML1I4Fk11tChbcy2XGe5k4J07H?=
 =?us-ascii?Q?/qObqhENRyKZJzqgH91WbnvXM/vMZBJ/hXqtfk2LsjYXtw5tpqgcXD/e0uGs?=
 =?us-ascii?Q?HTYZXW+kq1RoE2nG+3vZdsi1kmiwK/TBRHxEPCsVmoAhox/5Z5tN+lWg/Vnf?=
 =?us-ascii?Q?RnelfPoBazJjEYdDF1QZRrssLTVXZSEtVeXMyYkIfQYRPw1ozLzjtxukkoJ2?=
 =?us-ascii?Q?cKUv+7FIX3PXZAL9WPnphqqLHIwWEqC/IVNkPVWzAeH0eUTPc4MkyXu5IPT2?=
 =?us-ascii?Q?Es5XbKHHta/0pLYVmN9dEGDPGqZ9s12IKqJEMvbheXEsr8qyL0ge8VbMfqc1?=
 =?us-ascii?Q?pzDa7ZvkNhUh32PB5r7gGCXuG8UTHO3DNsqTRdAVgAub5WpaInNHQGHGS1nR?=
 =?us-ascii?Q?iqCY8fuasEyKBmVMZlJfs95q0g8BUtj7ZaojcoECcusoepTWC1w5hbFJggx/?=
 =?us-ascii?Q?ONPGTUf1NlpXigmNA605Wjb0ul3yRdbR1O+KNW3pIUXrUyanxBpUmwLq/v1e?=
 =?us-ascii?Q?BoQEERgVtxauLFSgYVqOu048tCrGbDdFh1BhwJ8drmZWM5Ik4xyLeAdDAl0J?=
 =?us-ascii?Q?zyFu70Z78hotSV8mVTaP2fGaZxT5iVnsGJtb6r28kwOKw+rzrBLYCxf0Jtk7?=
 =?us-ascii?Q?UODoo1z9jGTo+o0Uj2FfHnixdqHJW+gN+KXgMizOs7qvODPfoCUmKNsJVv/O?=
 =?us-ascii?Q?eFRpaawbDrGOZZaC9lx9rEpL+/fpVaLhDR4bDXfGDns=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2df640-24fc-4552-703e-08d8bb55bc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 02:06:57.5744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0m5FdxXkH2AjTRFdq8OIMhw2DGpKGFve+h0z2MU7tOkzvFc20TELcrMtHjvyoCA4vRzPzsFX+KboELsAUCWpMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0119
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series are:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Monday, January 18, 2021 9:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fulfill the API for navi1x gfxoff state retrieving(V2)

Support Navi1x gfxoff state retrieving.

V2: some cosmetic fixes

Change-Id: I57aa506b82dc122bbead708c580a4720e536cfce
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 22 +++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 102a0cf12d7a..4d346f289ed8 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -287,5 +287,7 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 void smu_v11_0_interrupt_work(struct smu_context *smu);
 
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7ebf9588983f..93a3b6b60c8f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2482,6 +2482,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_fan_parameters = navi10_get_fan_parameters,
 	.post_init = navi10_post_smu_init,
 	.interrupt_work = smu_v11_0_interrupt_work,
+	.get_gfx_off_status = smu_v11_0_get_gfxoff_status,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..730a4880af08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2127,3 +2127,25 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+/**
+ * smu_v11_0_get_gfxoff_status - get gfxoff status
+ *
+ * @smu: smu_context pointer
+ *
+ * This function will be used to get gfxoff status
+ *
+ * Returns 0=GFXOFF(default).
+ * Returns 1=Transition out of GFX State.
+ * Returns 2=Not in GFXOFF.
+ * Returns 3=Transition into GFXOFF.
+ */
+uint32_t smu_v11_0_get_gfxoff_status(struct smu_context *smu) {
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t reg;
+
+	reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_EXT_SCRATCH0);
+
+	return reg & 0x3;
+}
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
