Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EC8C531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 03:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A322910F2A2;
	Fri, 24 Jul 2026 03:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BVXWyfSi";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761E910F2A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 03:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH85bXlUc8RF40Kr5qJJp04dChDbe2utK1sE3cZRy2QGzOaTW2VAYI7Wnfb87R2xYGEtXbFe2absi5T7WTfHxBa5nQztZCMa7d33/SDKPPIswm29u7/p/4m8IVkaENy5+ObwG/D38K6x9avIuwNas/p7YedbqtteMtREG4wyde3Wbkm8JZvl4Wohwte5jbJAYLniNZIsixtwRWjcKkwVBVE5E3zSq277Ywonc4wapEyLBx5M0NBPRaoQnvihSkQxZd2zAAZeenDXtTR4Fs6KwC8mOm5f8Y3aKWWlR4woz0L47icntHBoML1EYXcfhTVHOkf8td9VVtxmp14kNftweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2Sux8fvo4GmMXpkvgGnZi3ll0pCpXG/3YX/KIjgLmA=;
 b=hIrZjj2C5LLrglsei8x3HmGOWVcOGCmQewcVXUEyWMiifXyvfsB5/DyNlpS1lzsfQrigpndwvMRa8Ek1nnanuGnYQwqcjkkexFIKc2a1SP3S2+2jbIg93O6T6bptL4Kvd7G0Oyt5VXY93Zk54+/IBVBO/xQEoVhis9VceCviiTxm4Y+DbFBcvyDxrzLS+92WmX6aWdKyagFRY7YA9daCoV/upuCLTDkystT+IrTVpwoZQirOfSbAfMY4KtFc/MhLcf8KpxbZ8o9lxlp1y4v0FAUpzk3lKPfUnH73o01FvCG50IuNlm1LpFYfC72lPBWrhzzpOpxrJH/lROzDybE1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2Sux8fvo4GmMXpkvgGnZi3ll0pCpXG/3YX/KIjgLmA=;
 b=BVXWyfSi89YCQlvsFRM06n3OMh1ibnTlcNG5OITkHVRpxTldABZzyS2hUMojvYmmY/OUyEdN/W5nhjYQDjpS3e/SZwaaqA5Nn8UDr2L3yVYpPhQfk3RPUpMqShKpBWjzEWZm2d8MEqdGVu90jIoYiDcpCLnk4H8aCFd3Wqn7LF8=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:20:46 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 03:20:46 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix pptable use-after-free
Thread-Topic: [PATCH 1/2] drm/amd/pm: fix pptable use-after-free
Thread-Index: AQHdGxfqLJXn81SF9k+cCmJlFPWdfrZ7/a8w
Date: Fri, 24 Jul 2026 03:20:46 +0000
Message-ID: <MW4PR12MB6803F509262370FF67A295418ECF2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260724025522.800587-1-kevinyang.wang@amd.com>
In-Reply-To: <20260724025522.800587-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-24T03:10:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|CY8PR12MB7219:EE_
x-ms-office365-filtering-correlation-id: 4757a662-492e-44e2-b447-08dee9328d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 5Ad5DYHfPoZvPGy1k61jHxGBQs2qFGdgR1wGJMTyR5uIs4MU73ioMnfVtNAbBXUw5IlLAXZ6mgNKAhJ1tbzllK061mZjdPJIWSL3K4uLhlaV7H+Vh7ZJlXnu+BjhPJR0lpzT+dKl/N5L3pL1n69TrmGx3e0kz+bzOdz6IKerjC4t130JkibT2gUxUmSRg9YDDGQUqWgRCj1Blqn9F4eVjIVhc/ysCWtUNM4obqnRSzYGAOSHpY+nt8R/tu8aejYg39It7UpB43bnXH69WmJH/KPEFUSYRZ/gHqNsCoGXCBBM8La79zBOmUqKkvgmiebQs+Xxs99hQt9azsNmZKZc0iawY7YZseHJWy4P00MuxFQy0WZFeSGZEUdzwPY7raVBaWdi5VGiJjGvMnENmzvaI6HQX9ZoKlxaralmYDhgSWQJ5gjgtIaIdZwNrRTer1q6u078lEjCxVfJBLNtYcUC2P2gYdZbcOUoZA8482lTO0viOZamJT0xjM7zo/OCKGaVV0LyG/auxJURPEojce2CcEfawWCgm9MeKBr1cWeIZJ26Hk0OIdMLf3ctQHcx1EYpkmBWXTQaff6zrNnShaSMfyhQyKGlBi+VbTFMLflbWCp1emOpVrsw06mo+FP1yJ+pg0UotbhLccZRo+6vGIOMKT5D92yTmqcdE+WRAwsoiSM3KWtCKJ7SlFKgxHfnHp3f0v1sZHoRFDFHifOe96AqOg3ILbeu31NvJWjdauonduE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QexvZ20NQb2t3z1p4UlcXZTdjwMdzef/VsvydvaLtqwa2Rg/3sygZwfGbza0?=
 =?us-ascii?Q?hbBinnbqmTqmgsOx45bYNTllsSz9F66/g08zrTzTz2VP7q3cVRPLV2yxIpi8?=
 =?us-ascii?Q?rowTAdiAbzB/bvjOXn85WNKA/I4DzHMx/7ASMcUFdmst2fk78G7ypJLV5uu+?=
 =?us-ascii?Q?1LgPbJJCRvX50uTh0d4ccd5qweOa3YeLk7wjMHkiT+KOQYqppp6BJUiZbd7N?=
 =?us-ascii?Q?4w7wCuZP0AJyI5JzerxkkPjIC8tZ101FBaFWjRh/cfcNU9CGvaDCdL8LNmoM?=
 =?us-ascii?Q?+emmUZXxda2gK1MR4d3B3WVnE4VLXRYC5vhtr5v0SUcpYykn+Oq8zPadUEyK?=
 =?us-ascii?Q?3B7Ze+Ut/8sfs9BCZDQy6fzQN4sH0l6IjPuO+FYerb6jgPjWp3Pw2yUoW/Ni?=
 =?us-ascii?Q?R+i09iZMXRRgGJBYW3WxA/Z04/PB4OF9H5fRqHnKQs/8K5WWSsnCXP6nq9m6?=
 =?us-ascii?Q?RtMnKuuw/scdd3DEzQ6ol3dqes5s/Bv8fI3KFNnA2BalUJFnvVtyUQII3d/5?=
 =?us-ascii?Q?0/utbtMIJZbEUEbw5WnBxgZ3eZl0Ik/LS2sOt+oPmYmQEarR1T4re/5XM6RI?=
 =?us-ascii?Q?sWjwYjmC+T7uY5/Ul9zt4DjEXfdM1TiY33Lgwixb+OAdFx9i8E7D5oChW4fb?=
 =?us-ascii?Q?bDr3gc1fmeyTVK/214lWZOPU65GzLG0bowtSxlN1pn4TpzCpFUZdHWg9kEQP?=
 =?us-ascii?Q?10JP4TTxCzxNOvZhx6gdyjHULxAALp5HTajvEEcHkC0YbV8GPBHai+TaMZeu?=
 =?us-ascii?Q?nN0NxRfi6suzDG7vdEP65GYHSjjTjjstKJ4r25Ro2MWQzUq0LmhVhml61Vff?=
 =?us-ascii?Q?2+0QfiAWWVMfwTr3Q/GkU2MLY4L903hFepMQCfDIwkm7f6qf4A3wVbJ6Paoc?=
 =?us-ascii?Q?Zt5ScSpGR0K7gpT/mTKlAgrFSFqNDbEK4sdHHQPXTNEvE/Y9NsIONi1ieuX2?=
 =?us-ascii?Q?U/eSQU4vFFipjuGzPqGKqen3Qt+E2vRMk6tjpPvMvX+izoTTHxLzdhaE24Qw?=
 =?us-ascii?Q?S62zsOvGzbAvmje57InOqx2OfKrq7sPiVGCBp3zMixvbeFtMbOI1zyF/crwY?=
 =?us-ascii?Q?SQR1rv6t0jtCngrJ6dfnkjxIqaSragASN6ZDiAz62qd+8eVTZ9ppRNmoY74V?=
 =?us-ascii?Q?PN/HAxMCK4vsufp8/1kKj+kHxYCV+WpH9ikL96EarJeu6aargyf2WoRyEhdG?=
 =?us-ascii?Q?g4EMNKqtDEVpst85k1k5GZiBYBWLgJgJkYdYp3w26RRvLdvMRz6DYdxVqK5I?=
 =?us-ascii?Q?HewGgW0XYGEUPbtIuiG06bGxRjIDp1TcsLQpRuorSZPr5ZjT+BoqkCHZ8snb?=
 =?us-ascii?Q?mYYsz6PNLRVQQ6QLcnRsuRBYKF+2jntkg42y5uFkFBrDZQdzT4YRixjDW/UV?=
 =?us-ascii?Q?6LK7SW+oDGaCLWDY70YF4x5gdTQam3B0r17+getdWFAkPSS0chup4OKTARrc?=
 =?us-ascii?Q?ynivVMd0CIQcMrMs6j9SmkI/pv/1gwQlzB7AUGul9oB83kfatkRhx0GasBwx?=
 =?us-ascii?Q?v0JWFtvAdOnzW4R6KoXnXu5vfq4VSt24trAU0VDwOf9UUWeP19/e8qqWdbh0?=
 =?us-ascii?Q?grkxnVnYhI5n6sDRpjkzjAPTARaH+csBySMt6n2U3A9rh01DYXRFLiqIm9Ea?=
 =?us-ascii?Q?beVynqV+OPJ0gMDoPcKzvGA5h+16Ma4JVR04C7gE6LYvx+Ni+AwYxnmQMFC8?=
 =?us-ascii?Q?kZi9Y/7OiCaR2fnVhDzKcXyrxJSaNIqqtuD+MpFMbA+vZq8Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4757a662-492e-44e2-b447-08dee9328d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 03:20:46.3340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlyNaBr3QuJ3CWZYvazlIjWyZ1wxtN5T1VUcQZsnLOuD+AgXOjJ4nXibY+8QY7W5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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

AMD General

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, July 24, 2026 10:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix pptable use-after-free

amdgpu_dpm_get_pp_table() returns a pointer to a driver-owned power table a=
fter dropping adev->pm.mutex. The sysfs path then copies from that pointer.
A concurrent pp_table write can replace and free the allocation during the =
copy, causing a use-after-free.

Change the DPM interface to copy into caller-provided storage while the mut=
ex is held. Keep the size-only query for attribute discovery without exposi=
ng the driver-owned pointer.

Fixes: 1684d3ba4885 ("drm/amd/amdgpu: change pptable output format from ASC=
II to binary")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 14 +++++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 13 +++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  3 ++-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index c09c60ad3f38..df863a451f26 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,12 +1183,14 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *=
adev,
        return ret;
 }

-int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+                           size_t size)
 {
        const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       char *pptable =3D NULL;
        int ret =3D 0;

-       if (!table)
+       if ((!table && size) || (table && !size))
                return -EINVAL;

        if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_=
enabled) @@ -1196,7 +1198,13 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_d=
evice *adev, char **table)

        mutex_lock(&adev->pm.mutex);
        ret =3D pp_funcs->get_pp_table(adev->powerplay.pp_handle,
-                                    table);
+                                    &pptable);
+       if (ret > 0 && !pptable) {
+               ret =3D -EINVAL;
+       } else if (ret > 0 && table) {
+               ret =3D min_t(size_t, ret, size);
+               memcpy(table, pptable, ret);
+       }
        mutex_unlock(&adev->pm.mutex);

        return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index f5a5d72b4108..d473976ddae5 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -595,25 +595,19 @@ static ssize_t amdgpu_get_pp_table(struct device *dev=
,  {
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
-       char *table =3D NULL;
        int size, ret;

        ret =3D amdgpu_pm_get_access_if_active(adev);
        if (ret)
                return ret;

-       size =3D amdgpu_dpm_get_pp_table(adev, &table);
+       size =3D amdgpu_dpm_get_pp_table(adev, buf, PAGE_SIZE - 1);

        amdgpu_pm_put_access(adev);

        if (size <=3D 0)
                return size;

-       if (size >=3D PAGE_SIZE)
-               size =3D PAGE_SIZE - 1;
-
-       memcpy(buf, table, size);
-
        return size;
 }

@@ -2733,10 +2727,9 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_table)) {
                int ret;
-               char *tmp =3D NULL;

-               ret =3D amdgpu_dpm_get_pp_table(adev, &tmp);
-               if (ret =3D=3D -EOPNOTSUPP || !tmp)
+               ret =3D amdgpu_dpm_get_pp_table(adev, NULL, 0);
+               if (ret <=3D 0)
                        *states =3D ATTR_STATE_UNSUPPORTED;
                else
                        *states =3D ATTR_STATE_SUPPORTED;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index c7ea29385682..a1d1c9f5b1d4 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -487,7 +487,8 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *=
adev,  int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
                              enum amd_pp_task task_id,
                              enum amd_pm_state_type *user_state); -int amd=
gpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table);
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+                           size_t size);
 int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
                                      uint32_t type,
                                      long *input,
--
2.47.3

