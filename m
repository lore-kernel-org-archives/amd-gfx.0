Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9FCA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 13:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5716310EA8A;
	Mon, 28 Sep 2026 13:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tQVZi29t";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A076710EA89
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 13:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vebqoB7WSm7zeTfJ798vO15FhP1di5UafaCG3BYeo0d8Zflks6aYPBxyNQFNCFGGCguLNk82GjUBwqsNNHOpTPV9gi32C2YkNwfe1K0VWPcuYOTnlWIXlY1CFhBDQaHTRfsg+fQSxnTjbP+D3JCmwnbUZbOu7Dz8aH6VV5sp55/pAqW+K/U8PKZ54Q2azEAzXXGrjC8FfGUaoBoTT2nu2XMf3UUtmsmAV0ulOnhW3klwH3QiISn5UvNIV1ZQE7eZ3z/eE6T43nvKZzZ8xJlwtLjVRjbJFTz3VZ3ROSNLsbikIVGceKZzFilTZWND8DsY/gtNkxjN0hTBAOTRfT4D6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDn9NKL/VkV3WG7tQlQ6lh72X9Y+qQzZsoYLVgSeCvw=;
 b=qVD20+rjIZev9xe7eEnx5MaDmSNDK4nK6z1RYPWjeUOS/1TMKrtZrcsUnC4BikHY2Omd3S+VHJOWAOz2Dfc/21nEXBf9MzQBfnxYneSvUh5hPslknPGBRKsR8aNvYeOXc3L5bczhFmLsb01vyvFTxtHtQkMjf+TEv+KRLa+I474dE0vA8o+6kZxBQFUgjMcP2u9LfDSs+FOwuv5404ffC2bPlGH1gqDkihFXYcMwZPsyraqiRypPqSyy5UeJRrbIrjDzmOGE8kS1nqbvQf0D7FCsgEQUZpxt4bjL/gwzF4WnX3zbuYzTa3IHXKmUs6ZXei5S9EOHi/r/af6kBq8DVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDn9NKL/VkV3WG7tQlQ6lh72X9Y+qQzZsoYLVgSeCvw=;
 b=tQVZi29tN4IXCuBTwZIQFjR4wu1XPaOi1/pMITfHzJKm9lsEiBjNIhLCU9NhpkYf0hEPDdtruKJTZWypw24eFFBvCi5+bFV3aFjpsloWOQ5uypJE9kbhODs92I/RNolf5umOtTTL/LnpUdaZOC43o8fEmJgOSTf/gZLL0pG6rQE=
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:49:50 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 13:49:49 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhu, James" <James.Zhu@amd.com>, "Ma, Bing" <Bing.Ma@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
Thread-Topic: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB
Thread-Index: AQHdTNGMt3AQ6wUtnEe4vsESL6m/ebbkBrrg
Date: Mon, 28 Sep 2026 13:49:49 +0000
Message-ID: <SA0PR12MB7091927251394D32F43248A7978D2@SA0PR12MB7091.namprd12.prod.outlook.com>
References: <20260925093718.2737342-1-lijo.lazar@amd.com>
In-Reply-To: <20260925093718.2737342-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-28T13:49:45.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB7091:EE_|CH2PR12MB4152:EE_
x-ms-office365-filtering-correlation-id: eaec0de7-2614-4480-9370-08df1d675d70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|6133799003|10067099003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: jlo/DVnNl3vAEeVI+vKPF8qduMNMXMerWAGQTCjUfClG+EDcJhmHW+dngsGksXqIebj2uKU6eOuyxBY8FC+QMkUkDHJRDrT0yzvtfc82IEHpBdH37qP6tgz6S9u4e6D/zvlb6IT8vpvpJDeb/rZQYfJwEt4e4D3I1i85O9RyR+AdHgs9GhqSreDbY8oGy36JZ6T4CppX7j58mwTnNNxWhpK1zdhPjXYXZGpVatV6zS3ow1rgmTLl468w0+ciIG9drJN/GnXA1F4pp9oBK+aRA8DV+QGVthCsv+qFz6atOvN/76NhQ+lOMWO6P2h8xT7buWfJTxIvulLZ1jXgEr02aOSdHBPbeM18u+/IHtFQaY1KWXv4lGVqevYM+y+8X/vZuvbx7Fn0lt6V2KW8gCPKl4i5iZSEu+wcOTfR4M8VvYGdrxLueoVXxi5Ke3eJW2JYZqXta0spoZ77/1skdTnVNQ47EI8Bjpm2EfaR3p8Q4F3H2b8t7V5aOw5lstyrOe3fSz5ejWGyg1LPTMQJrvFh/U3/gmKNncpQX/Q5UrD/4fl6N6WdDYOFKx2875oiFeJOrNCrocgwoIRc6kaYucpGDncpBBtpNb18a3RqazN6+3YNSUyD/qAZAFaGqtewK5Wm+KA6TNXDxKJ9RZAFH7tGyBullopAaZjGzsS+Hhx3Ew2mgGssGE/qafARE2cFigC3tD94krUnL/oD0Cuu3gMPWpXqQ5wuf/tiFoquziDWpb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6oyMJWEOJn7DEDtQY/0fZDA+WfXkUwwoiHfCeMBNyxn2t0+F4u1RTc1rri/v?=
 =?us-ascii?Q?/LYS4QllrHWAyQsPZeDNOqBDOzVONnHDdRaJME7ViCiNjtmcjqPOgaVtROMB?=
 =?us-ascii?Q?bBaWfXocOjqOPtga5u9IacWJTwX8I7GD7yjK4Qh1jiKvfwprWwQPJAFG0Gzk?=
 =?us-ascii?Q?D9cHtTX9eXeB7ZjLoT3LXJ/fr/6S6mccqsvXNYSizOXYc83pk4BoB0VQBBTY?=
 =?us-ascii?Q?onh/3Zcx5hLQt8wQzTXA/a7hQuaOdI1gtkTPVa2DncjVatdXS3e3kUjR12+H?=
 =?us-ascii?Q?+pTLXhKfy8vCC2EpNkVgAIyrD9vMD2AhvK5zQB5G2nzs/sEY4AUNF/rRdY3F?=
 =?us-ascii?Q?BeJbqJH9WilJxvj8O4i24aKJRtf0ouN03Bjb+X5QRwV4nteJ5kebk4VfAqYs?=
 =?us-ascii?Q?C7I5BKiRbJrCgh30LaEBTw5H9ZAZZWz/qupeA3/QKlqu3gAjydBZk/oE684l?=
 =?us-ascii?Q?5/XtSgpFFwSoBwepvAgj8crKdbEnqfLNF/HNGNAGVOblL6NVE3yO0dtphfCi?=
 =?us-ascii?Q?HtLozEQ7Hmuq+PJPItptusg/X4d1HUY5c7b/P/l9J6WjcCEaDBNKAx8gH820?=
 =?us-ascii?Q?obrya6ZGDUxs9HDDqoVMejb+jXX5EmLzBSCVTsxG+p1v6a2bRa7zE4YxeV2n?=
 =?us-ascii?Q?/OMariuweI93I2DqtBhiw548lEk9fu1wmN7RY8KEjPQd+fz/ZwiNm6nT+gUj?=
 =?us-ascii?Q?DDPAhG8lsTZ8n0gAMZ31tjvQXydutlm/BlEBqLJda9YdDsAH9hvQSm7ur8SA?=
 =?us-ascii?Q?9ydResVQl6ZGDXlWTvtqOGG5XsvpqyArrEoTS2EH3pUdyA4tK9BnWBaR7MZk?=
 =?us-ascii?Q?kzKaHMxLVrWZQeWKep4Qq2KerRTfAz0cqylICev1ErUheCky+udBQWfpKOCh?=
 =?us-ascii?Q?pPR/McQ6ndLrRyGtEq/aspMdwOzzGVPmf8QMgsZZDEvgYTvVPIeWDLDBHwZy?=
 =?us-ascii?Q?Iz1dDR4iIqTSmWjiuOw4qt1xA1xDey/nifgXA1ZT1lLOy5CkWJIqgC5M3MwF?=
 =?us-ascii?Q?G8Qr8Lv17nqjztrI9zDlUflv5PBlSqU6eG18tsgK9f6waeBnDwTV4RbQfc11?=
 =?us-ascii?Q?mgC+T306FaCP7tS53KPp5W+i8JK4JOW676ExYzN3RnLitWAQuM189IliDILn?=
 =?us-ascii?Q?fl+pSmL3sp+Jsj6W13cJ+DYeeqDYH+jbTCRIR0X9FjUAwpO8aMfCXEwHm0EF?=
 =?us-ascii?Q?pjv8hX5dXS6f8E6LebH+DMlCyPE++aVZ8+G902q4N5nf1AfkGvWYOVlGxglz?=
 =?us-ascii?Q?UU+0CD9hOKBOmAt6+W4cqN7zmUXlnXP0Cz18apkjaCz/sx3dp/C4oylTK1gQ?=
 =?us-ascii?Q?J7paeMPL2EN4TaBf02uLtUl0dVZcT8m+63ZqoD7WiSrBleeVeTR1krfou/+f?=
 =?us-ascii?Q?jtH2KkGM+wmVW4XXw5eAwCNo3HN+eMVFlmVKnN2fC8sqVrezEzE+4NdDNnsK?=
 =?us-ascii?Q?+b6OIaJfOCbdmBldfk8Yb/pJNpfGlkXsB8utx1ojyc2SlcyK4tJQx1Znsr0C?=
 =?us-ascii?Q?PTlzE3Ns9a0xMmk3KBt907Ja072nO7unLmOVc5E8VaKbfS8qZH370L012xz2?=
 =?us-ascii?Q?vbInCu8CaXad7kExdG3GtG6asYFuivzQbwNlXE1mNRnP8rq/8c8qntz0ccQR?=
 =?us-ascii?Q?LHHigXcZ+YR0wmajMesLL0Huxr4tN96xGuthAVW0iMIQdQpEkXBGys2nMWtu?=
 =?us-ascii?Q?PGISVH5JvV8xegC4iDHaS3gd/WetP8Ab8NqFIze6Njx34VCz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec0de7-2614-4480-9370-08df1d675d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 13:49:49.5267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xdWDKQSDZK0CGkvOF3dJxi+MepGmOdLDVu+0AaZhFQ07J8BUdK2qGNlbQT+g404w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152
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

Public

<Ping>

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, September 25, 2026 3:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhu, James <=
James.Zhu@amd.com>; Ma, Bing <Bing.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Derive RLC SPM xcc from GFXHUB

RLC SPM is updated for GFX subsystem related performance counters. Only job=
s on rings that use GFX subsystem need to be updated. Some rings like SDMA =
could be inside/outside of GFX subsytem based on SOC. Identify the rings us=
ing GFXHUB assignment and use hub id assigned to find the right GC rather t=
han relying on xcc id. xcc id may not be necessarily assigned properly for =
all rings.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_rlc.c | 31 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/a=
mdgpu_rlc.h |  2 ++  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 +-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index 0f8b097001e3..6ea73ef6e672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -212,7 +212,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct=
 amdgpu_job *job,
                amdgpu_ring_emit_pipeline_sync(ring);

        if (emit_spm_needed)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ri=
ng, job->vmid);
+               amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);

        if (emit_gds_needed)
                amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_rlc.c
index 002fae3c380e..f791e1bcbf17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -27,6 +27,37 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"

+/**
+ * amdgpu_gfx_rlc_update_spm - update RLC SPM VMID
+ *
+ * @adev: amdgpu_device pointer
+ * @ring: ring the VMID got assigned to
+ * @vmid: VMID to program
+ *
+ * RLC SPM counters are used only for GFX and GFX Cache subsystem. Only
+jobs submitted to
+ * rings in GFX subsystem need to update RLC SPM counters. Derive xcc_id f=
rom ring->vm_hub.
+ */
+void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
+                              struct amdgpu_ring *ring, unsigned int vmid)=
 {
+       int xcc_id, num_xcc;
+
+       if (!adev->gfx.rlc.funcs->update_spm_vmid || !ring)
+               return;
+
+       if (!AMDGPU_IS_GFXHUB(ring->vm_hub))
+               return;
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
+               if (AMDGPU_GFXHUB(xcc_id) =3D=3D ring->vm_hub) {
+                       adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, =
ring,
+                                                            vmid);
+                       return;
+               }
+       }
+}
+
 /**
  * amdgpu_gfx_rlc_enter_safe_mode - Set RLC into safe mode
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_rlc.h
index 959d60c90dcd..1410954da5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -370,6 +370,8 @@ struct amdgpu_rlc {
        struct amdgpu_rlcg_reg_access_ctrl reg_access_ctrl[AMDGPU_MAX_RLC_I=
NSTANCES];
 };

+void amdgpu_gfx_rlc_update_spm(struct amdgpu_device *adev,
+                              struct amdgpu_ring *ring, unsigned int vmid)=
;
 void amdgpu_gfx_rlc_enter_safe_mode(struct amdgpu_device *adev, int xcc_id=
);  void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_=
id);  int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws); diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgp=
u/amdgpu_vm.c
index 29a66e39f3d6..dc8f85176b8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -865,7 +865,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct a=
mdgpu_job *job,
                amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);

        if (spm_update_needed)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ri=
ng, job->vmid);
+               amdgpu_gfx_rlc_update_spm(adev, ring, job->vmid);

        if (gds_switch_needed)
                amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
--
2.49.0

