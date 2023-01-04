Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2438AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 08:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 960D910E446;
	Wed,  4 Jan 2023 08:55:54 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB25A10E446
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 08:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqGr+lsGc1JGuuUz4h1OrSgSH25gRhkzvMKFYEFVTKIqq+Ci10byizh3aO1PV2EtFfV/PuyNRhA8XXevS5PU99iLYYYXPXsTfe59ID2aimDtVAhJHezR91SA/4az1h5j9mrwl89KK9ynNnfY9NhrqgrUBHVcu0+lKF+imeK7PPoOINbLeZVcJR3wo2RUQ/1CkDWOr75Yeywbbs0LmoFKCwfEPd4uulhSZ3AiB+fV6ui4ov5K7x+GJlkNIG8l3IC5PKf8UgxncGzfAZ/iEoAdmtZe8tkl1zl5L07er0LjJfmzu9LYwWmPRJH4KRrB2mxYtRTIph2MNiX7m5AQ2jQiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBAIf6BRXKDtkuSvwoxPLWHn40loHzH2OkFDV/1VfPU=;
 b=SdjHxsHcm5ototeDVHNrKOVzQGd/HKoIvRFgBFPg9ZWcGahs1YEuKlW5/vLimJT9zcPtMNle+PaR0/kFlFXzsDKa6Rufb0VOpNdz7qPUhotAm3EqEr0WjlfMKBrNiHIFstCGymBavgjzpzE+gFKjak0KznjPMp3j3gxsGW1PH8bBHdFZHc7aUGOr1AG3bPPY+9liQMsQBZiMIdiRnUqDHHzgAwrZ664tkK1kcVRsfnRko0NSzBWcQYe/o5wuctsMMG1emVroOfu4OsHuRMWVfMymqqv/lPSznuJKSihMxHJMNGxKu1s659B4WoS0vetNuyqi3Wk1R1/OovBXqNj37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBAIf6BRXKDtkuSvwoxPLWHn40loHzH2OkFDV/1VfPU=;
 b=x6j0psX5SQTjLqjLXkVprFpOFqJYQyZN3Fr3/Fn5SVSWrTMyUsjolcpdiGTLriKRw9T9HPgKrPfKVbKWj2rt3oghEYJAmqVb1qlD+LpdCgDOOUJbCPOXbcf4CD5X/WuxdNUmxMCnuB27hcP1Ow+K9XjSVI49rkGEzW9pxYc6AT0=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 08:55:45 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::7529:c56c:6824:b438]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::7529:c56c:6824:b438%9]) with mapi id 15.20.5924.012; Wed, 4 Jan 2023
 08:55:45 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Thread-Topic: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Thread-Index: AQHZFwYFVCmAsSoTmkajuRfZVEUm3q6OA4/Q
Date: Wed, 4 Jan 2023 08:55:45 +0000
Message-ID: <DS7PR12MB63337071189F0F5D018D35DDF4F59@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-3-shashank.sharma@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=634afa00-df0b-4905-845f-7911a93c1836;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-04T08:44:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|MW4PR12MB8609:EE_
x-ms-office365-filtering-correlation-id: 5aaf607f-5b1b-44de-c234-08daee31778c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6uUQ0PsF7/8M809RI7GKiwgS508RRhHQU4icYTiovved42SvgMOWoLYDgsazHgk119rcH1P6ejwe4Zvv4V7DFqVLSKATUU0QWPgV5rnBLsA5FoqwK4wr7nLDGqc0/8szlbTR1sGBD33QFpStA/2OPqxVkQfLaMEXBoArNTTO1VjvCvVBaH0CyEerlGFUFArFhub20hFiT4i3bYRiX//bBCg/lEthf2lP2s/mXij7yL9ix/VT+WHUHYtJ7wrcDll6IiJSr2ML4bvPoSKCC0c3CFmOz/7yctFFOyMwoLngnL5EMi7FLI6Djlgqt2TDVPsaloVFUaTB6wxtgk8HwpeNc7m+MnONgZri+KPIvWN2uUnS32i4+EYIZWFOltXvA70EXa7ac0vEt0UtZwsMYPcNhvjA7agfkzWOLkNMTxbl9dBwboGkYo0MnEncfYKpeaiwxJxZiiPHuzIlh4hUhfRrUbmvaryqbxyIFTMDhgk3iC4ORri/6N4+ZC6/15nDyf0DEmLg0fMmGLFP4ny7dpY1dXQFySSBdqTS8Zkuu9efD1UUw41DSblIdA9oGaotxQX2ucLdAryR3dHKyp7ojNSbG7wNEw+Auvx3eqIRsHFMp32oDB+nmuIX98u9lqXzTjRu/GO4fzvqjsFcUDHU4zeINnF1unxM1CaON6VQvGiKvvjFZMkGskODlDz8EjMedrxdydprAN6XEPGNRc3Nlqfpow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(38100700002)(54906003)(33656002)(122000001)(38070700005)(64756008)(66446008)(41300700001)(86362001)(8676002)(66556008)(76116006)(4326008)(66946007)(66476007)(110136005)(186003)(55016003)(316002)(52536014)(2906002)(8936002)(5660300002)(30864003)(9686003)(83380400001)(478600001)(26005)(53546011)(6506007)(7696005)(71200400001)(66899015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vii8G9OQ7XEohW5EvdiaiNEIfAafJXeO36qz2hLfowK7YOhHnfLc6v1Ja2Mh?=
 =?us-ascii?Q?bGx/bfoF5MbjHUVmP4s01DvqUK3/18qAvDIIo/eIC5w9MRNBqzDp/CiUnvKD?=
 =?us-ascii?Q?sTz2Vxbi5nLqARP35Qs1dAHQJ+9FPweZktIN4yf/QKuon6o1w+uwAhK2DMMY?=
 =?us-ascii?Q?ECU4LQsebtRzrrJgl1oOtY163QHSUUbFGBWvblEaLDcXWalm1PpYefDgGeOm?=
 =?us-ascii?Q?vhC9VSE7+MNQcI15TvK5TuhWeRlUTbnhbbTWbkxym4s+mkilkJFq15d7a3pE?=
 =?us-ascii?Q?1/3bLUYS6y9vd8uGv4bBByUKAZmY4WK8aEcM/Hyh4NEZLdc9XvMZW7OtAgZR?=
 =?us-ascii?Q?fOPfjg03mfLSpjIxD1+xxUETSGbSUm6MEfWz8UJ+J53gwxmQI6uB+3i0AYUz?=
 =?us-ascii?Q?M/Z96Or1ZZrc9PlmUdNlMIxd9NrkWblkibeN1l2O+Rl3iZz5IbPWYAkkmSEn?=
 =?us-ascii?Q?8FO8TrX6XuKGVSqfZg1/VBZnrxdK//iU9wp0y3PxDIkTOJFfUsMDKmKROzaj?=
 =?us-ascii?Q?nfwqtbv2aZFrnGcxfXJfTntBet4jD8EfDlRysJqTc7/g1Uw5ZkGBKvYi6xCX?=
 =?us-ascii?Q?XKy94gh3x+U1hNAH74vLzHy7eqHAE7V412c6xEkWnTy9JfZD6jsP+qVBBiub?=
 =?us-ascii?Q?hnSV5uXNi5k3310rmRR5pP3y0yTTDNkgJdp+2gHdXMWXQDegxIhoEEz+uUzG?=
 =?us-ascii?Q?hu1LCa1w+41+nEpsk9WelUW58U9CTQ4qdzAfiffLcd+GBwBqBbsoTnk6fyVC?=
 =?us-ascii?Q?q2h9V3OpupRihJY6WKLFajK2uWqSEYjlYI3mDekxfVXEOnIcdO2eyca5kl1a?=
 =?us-ascii?Q?UIHs+I2ieZ6e/PR3KUkmmRXnBf178N2CEg8OhqzaDmHmzSbFKU5DS4p7BoJP?=
 =?us-ascii?Q?QkMYZDhCl5ltT7l2w73t69FrXwYxNJ1NKx3n3VtvxFpWetvDzycAjFkT74q8?=
 =?us-ascii?Q?ZMlA2M7R1Fiy2NWPO+QxAMXV6RgaiDW0IaW75NfG0cMWuVqwmztyKIo6FXPO?=
 =?us-ascii?Q?NWdxMKDeRpISL2MCREsnxWfGb+qbLUi4J/aSJff42+KSty+1+QQ5TN0SR2wi?=
 =?us-ascii?Q?mk4PJmNCH2yf9y6VhroCiB5YLRXrIHL+it70KgKTf2tNrHiWhVth2qr0R5dB?=
 =?us-ascii?Q?+9OHxouyCYmKOMhcijJfWJLDPul92Wl3VcYYX5yqdNyz6yTWbYTPGZiJChPX?=
 =?us-ascii?Q?Cq8M/3CQFPAyapSSCKJ5NWtpYlJIEkBSmxswRqYQZ6a/JfoTSUKvycd9g68D?=
 =?us-ascii?Q?Lxlgd9cJrBXxr0aFED5qmRqNuQmt1MLhXQYXML58EZr+K9cdHHL2LpQzVD/S?=
 =?us-ascii?Q?6tIRCJfIu44nlcac98gb0y4TiFvNvHwzoVLaHuCyRRyEA9DtYWGjHYsbVEze?=
 =?us-ascii?Q?biXFDysm7CoqanT9wu8vTF6xIsfMe379kizQUslKNjtCeyvH7Nv1DCKmgyeW?=
 =?us-ascii?Q?JqlIaH/zXgf4rEyNpuitBHeaT384gKnZN7DuVJEdKdN9HLiGl0OW+vNuAXui?=
 =?us-ascii?Q?znfWYyHl0sl7n8/02/y1ZmvAfchgwV7nJVcRIDGrU5gUO6FNhcCJineB2dn7?=
 =?us-ascii?Q?F9H4u/BMuEETLmodDKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaf607f-5b1b-44de-c234-08daee31778c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 08:55:45.2711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otEJWJCk2TxtCGpkVoQgVC3NhQkrVW4lGqonVNjvi6sLIM8UPMcD0u2bXORQJ8L2f+K64Mo77p1HaPGUdGeK9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Shashank,

I don't find how amdgpu_userq_ioctl is called, shall DRM_IOCTL_DEF_DRV(amdg=
pu_userq_ioctl...) be added somewhere to expose the ioctl?

Thanks,
Jiadong

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shashank=
 Sharma
Sent: Saturday, December 24, 2022 3:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank <Shash=
ank.Sharma@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, A=
rvind <Arvind.Yadav@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerS=
elvam@amd.com>
Subject: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work

This patch adds skeleton code for usermode queue creation. It typically con=
tains:
- A new structure to keep all the user queue data in one place.
- An IOCTL function to create/free a usermode queue.
- A function to generate unique index for the queue.
- A global ptr in amdgpu_dev

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
 .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
 5 files changed, 246 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 6ad39cf71bdd..e2a34ee57bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -209,6 +209,8 @@ amdgpu-y +=3D \
 # add amdkfd interfaces
 amdgpu-y +=3D amdgpu_amdkfd.o

+# add usermode queue
+amdgpu-y +=3D amdgpu_userqueue.o

 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH :=3D ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 8639a4f9c6e8..4b566fcfca18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -749,6 +749,11 @@ struct amdgpu_mqd {
                        struct amdgpu_mqd_prop *p);
 };

+struct amdgpu_userq_globals {
+       struct ida ida;
+       struct mutex userq_mutex;
+};
+
 #define AMDGPU_RESET_MAGIC_NUM 64
 #define AMDGPU_MAX_DF_PERFMONS 4
 #define AMDGPU_PRODUCT_NAME_LEN 64
@@ -955,6 +960,7 @@ struct amdgpu_device {
        bool                            enable_mes_kiq;
        struct amdgpu_mes               mes;
        struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
+       struct amdgpu_userq_globals     userq;

        /* df */
        struct amdgpu_df                df;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.h
index 0fa0e56daf67..f7413859b14f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -57,6 +57,7 @@ struct amdgpu_ctx {
        unsigned long                   ras_counter_ce;
        unsigned long                   ras_counter_ue;
        uint32_t                        stable_pstate;
+       struct amdgpu_usermode_queue    *userq;
 };

 struct amdgpu_ctx_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userqueue.c
new file mode 100644
index 000000000000..3b6e8f75495c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_mes.h"
+#include "amdgpu_usermode_queue.h"
+#include "soc15_common.h"
+
+#define CHECK_ACCESS(a) (access_ok((const void __user *)a,
+sizeof(__u64)))
+
+static int
+amdgpu_userqueue_index(struct amdgpu_device *adev) {
+    int index;
+    struct amdgpu_userq_globals *uqg =3D &adev->userq;
+
+    index =3D ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
+    return index;
+}
+
+static void
+amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct
+amdgpu_usermode_queue *queue) {
+    struct amdgpu_userq_globals *uqg =3D &adev->userq;
+
+    ida_simple_remove(&uqg->ida, queue->queue_id); }
+
+static int
+amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct
+drm_amdgpu_userq_mqd *mqd_in) {
+    if (mqd_in->queue_va =3D=3D 0 || mqd_in->doorbell_handle =3D=3D 0 || m=
qd_in->doorbell_offset =3D=3D 0) {
+        DRM_ERROR("Invalid queue object address\n");
+        return -EINVAL;
+    }
+
+    if (mqd_in->queue_size =3D=3D 0 || mqd_in->rptr_va =3D=3D 0 || mqd_in-=
>wptr_va =3D=3D 0) {
+        DRM_ERROR("Invalid queue object value\n");
+        return -EINVAL;
+    }
+
+    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >=3D AMDGPU_=
HW_IP_NUM) {
+        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
+        return -EINVAL;
+    }
+
+    if (!CHECK_ACCESS(mqd_in->queue_va) || !CHECK_ACCESS(mqd_in->rptr_va) =
||
+        !CHECK_ACCESS(mqd_in->wptr_va)) {
+            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
+            return -EINVAL;
+    }
+
+    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
+    return 0;
+}
+
+int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *f=
ilp,
+                            union drm_amdgpu_userq *args) {
+    int r, pasid;
+    struct amdgpu_usermode_queue *queue;
+    struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+    struct amdgpu_vm *vm =3D &fpriv->vm;
+    struct amdgpu_ctx *ctx =3D amdgpu_ctx_get(fpriv, args->in.ctx_id);
+    struct drm_amdgpu_userq_mqd *mqd_in =3D &args->in.mqd;
+
+    if (!ctx) {
+        DRM_ERROR("Invalid GPU context\n");
+        return -EINVAL;
+    }
+
+    if (vm->pasid < 0) {
+        DRM_WARN("No PASID info found\n");
+        pasid =3D 0;
+    }
+
+    mutex_lock(&adev->userq.userq_mutex);
+
+    queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
+    if (!queue) {
+        DRM_ERROR("Failed to allocate memory for queue\n");
+        mutex_unlock(&adev->userq.userq_mutex);
+        return -ENOMEM;
+    }
+
+    r =3D amdgpu_userqueue_validate_input(adev, mqd_in);
+    if (r < 0) {
+        DRM_ERROR("Invalid input to create queue\n");
+        goto free_queue;
+    }
+
+    queue->vm =3D vm;
+    queue->pasid =3D pasid;
+    queue->wptr_gpu_addr =3D mqd_in->wptr_va;
+    queue->rptr_gpu_addr =3D mqd_in->rptr_va;
+    queue->queue_size =3D mqd_in->queue_size;
+    queue->queue_type =3D mqd_in->ip_type;
+    queue->paging =3D false;
+    queue->flags =3D mqd_in->flags;
+    queue->queue_id =3D amdgpu_userqueue_index(adev);
+
+    ctx->userq =3D queue;
+    args->out.q_id =3D queue->queue_id;
+    args->out.flags =3D 0;
+    mutex_unlock(&adev->userq.userq_mutex);
+    return 0;
+
+free_queue:
+    amdgpu_userqueue_remove_index(adev, queue);
+    mutex_unlock(&adev->userq.userq_mutex);
+    kfree(queue);
+    return r;
+}
+
+void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file =
*filp,
+                              union drm_amdgpu_userq *args) {
+    struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
+    struct amdgpu_ctx *ctx =3D amdgpu_ctx_get(fpriv, args->in.ctx_id);
+    struct amdgpu_usermode_queue *queue =3D ctx->userq;
+
+    mutex_lock(&adev->userq.userq_mutex);
+    amdgpu_userqueue_remove_index(adev, queue);
+    ctx->userq =3D NULL;
+    mutex_unlock(&adev->userq.userq_mutex);
+    kfree(queue);
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+                      struct drm_file *filp)
+{
+    union drm_amdgpu_userq *args =3D data;
+    struct amdgpu_device *adev =3D drm_to_adev(dev);
+    int r =3D 0;
+
+    switch (args->in.op) {
+    case AMDGPU_USERQ_OP_CREATE:
+        r =3D amdgpu_userqueue_create(adev, filp, args);
+        if (r)
+            DRM_ERROR("Failed to create usermode queue\n");
+        break;
+
+    case AMDGPU_USERQ_OP_FREE:
+        amdgpu_userqueue_destroy(adev, filp, args);
+        break;
+
+    default:
+        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
+        return -EINVAL;
+    }
+
+    return r;
+}
+
+int amdgpu_userqueue_init(struct amdgpu_device *adev) {
+    struct amdgpu_userq_globals *uqg =3D &adev->userq;
+
+    mutex_init(&uqg->userq_mutex);
+    return 0;
+}
+
+void amdgpu_userqueue_fini(struct amdgpu_device *adev) {
+
+}
diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/=
gpu/drm/amd/include/amdgpu_usermode_queue.h
new file mode 100644
index 000000000000..c1fe39ffaf72
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef AMDGPU_USERMODE_QUEUE_H_
+#define AMDGPU_USERMODE_QUEUE_H_
+
+#define AMDGPU_MAX_USERQ 512
+
+struct amdgpu_usermode_queue {
+       int             queue_id;
+       int             queue_type;
+       int             queue_size;
+       int             paging;
+       int             pasid;
+       int             use_doorbell;
+       int             doorbell_index;
+
+       uint64_t        mqd_gpu_addr;
+       uint64_t        wptr_gpu_addr;
+       uint64_t        rptr_gpu_addr;
+       uint64_t        queue_gpu_addr;
+       uint64_t        flags;
+       void            *mqd_cpu_ptr;
+
+       struct amdgpu_bo        *mqd_obj;
+       struct amdgpu_vm        *vm;
+       struct list_head        list;
+};
+
+#endif
--
2.34.1

