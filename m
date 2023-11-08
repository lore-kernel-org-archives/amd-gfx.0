Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB31CC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B0610E383;
	Wed,  8 Nov 2023 04:42:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D13FA10E383
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHLp0rinnfdYHraLDeg17+Q5fNKq7BH7GZLOGPWwXoC8lqlKOAj6oYyVx3/R08zaHtvs6Hn5EE9Oiju6sNtR5lN9mtzV0aCEOujspnFMFlvr7yR901FDt0q2OLmvXOALKlLU18fAwwmdskc0ce9mE+qII3qldQ3ioWuzcM9MvhxtcgSh4rLvcfzFP3khTGxq1AeNv8PRzO3thGE+0pTV6u6CSzR8YSVK1reed1rMyiSXaAHXB1vpZgUXcFvwqHpI4RkZ/k41kINtjNQEE44RHbUBdI8vtcFqtuTVGE6sABv/yg1YPMYPZP0h8Ox9WwKW7im7X9TnNuyJExFPqCakRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNjUo+1utL9ZOWSKMaKLvwXiJKGkU/KfOWzjS7VwWZw=;
 b=mwKDAuvZ6HrNeKxrJ4T6mfEcCsYuvrDnzVEkC5pmjwJ8+xE5m1qKutyt8extfAKaoeaoS7BUrOatH/yMJ+zawQHx9Y/eK7stOYRQgBjsXNN3wTJcvDNIYhGrTrL9gUTfOipVLLqNPbX6pSCD2aRtFhze7tmlXMRW6FjXj00j8LU95skr2smkycICK+YCjVtakNR4cq8TN5uSnYX2mGbg4NSLOFXNRse1foYav20CdwK2wZB36na6OkmuyJ1vAgpyXGmA/HEl4ec3PND1Tk74c5VX436+ksenzr+4PeLc2yQLJnedHCXWgPzY/aHaUpFje58EL33XhVeLgJaPl9QS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNjUo+1utL9ZOWSKMaKLvwXiJKGkU/KfOWzjS7VwWZw=;
 b=Em/bWVCASVssrmgALd0WVqg6Bl+SC6PDIMRe+afOwlr4uQUqjIEqUl8fRj+nEC+LT2hgnslh/qaxzaofy0QlAdW3iA1e6k+4GlkUqxlocw3Q3r29gvtr9RIIGugTUGOIKSQeDWNoF3P2b20cy/eWsIxWG8wRT0DYHSnAVcvEDac=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 04:42:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 04:42:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/4] drm/amd/pm: Add support to fetch pm metrics sample
Thread-Topic: [PATCH v2 2/4] drm/amd/pm: Add support to fetch pm metrics sample
Thread-Index: AQHaEfswI4dUo1sbA0eJ2yStvcTtiLBv19yA
Date: Wed, 8 Nov 2023 04:42:31 +0000
Message-ID: <PH7PR12MB5997C0D90BBA9256A980598182A8A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231108042207.528357-1-lijo.lazar@amd.com>
 <20231108042207.528357-2-lijo.lazar@amd.com>
In-Reply-To: <20231108042207.528357-2-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7c323e7e-6ed9-47d5-bcdc-e06e04a6ff98;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-08T04:42:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB7247:EE_
x-ms-office365-filtering-correlation-id: 6628923f-b7a3-4446-804d-08dbe0151ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAmisAtrjOjzQGDGVmrTTcGMNGHAddFj7e3G4DRmUigHCnaD+/K1Ou0rfah3vlELF5B9QLm7ODReOFtmhQ6jEjXQ5LFEr2nGFLx++tWxvwVIlBtu8RaVaviZ7EKLxcalWmRaWFbfqP5eTPAKyYvSX9pONp0nb22i+5skIeyBNw0NDsANdkuTYZ74Yo89p/E36nHKUGeGzsU4fvTY+gVjC8kl59ijHoj2RoVbx5dTlyTfz3WbhK1Zn8CiWMKDc5J6ZYCebIwbgA53r3KW+PdagmO41SyBnwyllv6qDiqzxC8/fmH467bxY+/G9m1o9BmKPUkOW3bEQm3nowK52aWQ9laeZYgL3TuAAU/B17W7M0knbiqqthbgygQNCfgQBVUL5Dp+29aMiZeGzAvAyg6hek8p7aQlraJaTYMMNcd6+Ltv+rk+zRzuSvUE7bPAMLJL/9QCRVSa0YsRCy+W2lr4cYDs+iQAj3GrPt11lo3BvQef3Tv6ChRYvSMgmUkP0kmbwkl/Cm2kOdw4JWvclEOx7BdiASKw6cRSXN9zN+58ki4SLG7+C4L/IEuNp8bcqtqVG/cml9+3NArDtvdQqOFfiG2nT6BueDoVPyuOGaY4S9jZ5G7FYqfC3e399eeOynDy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(38100700002)(7696005)(71200400001)(6506007)(53546011)(83380400001)(9686003)(122000001)(86362001)(316002)(41300700001)(2906002)(76116006)(33656002)(8936002)(5660300002)(66946007)(4326008)(8676002)(52536014)(64756008)(54906003)(66556008)(66476007)(110136005)(66446008)(26005)(478600001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dtk11ifAOMS9+xQFk4QBG+xUGFvWp8uF94Z5A2qSYKO9gQwX7rrMT4slQxIF?=
 =?us-ascii?Q?idvdw0NsUOeEPFb1KkL3ZT8wRO6GzXyn34yD01tACSnDg83x4L+Aqcy3HHwY?=
 =?us-ascii?Q?QPR1roafzcK7mska+8Q8uJyCrobUSjZPJCVMi/a/jmg0YKPyeyd0KteoHu4o?=
 =?us-ascii?Q?M6tFMIlLSELIspkeMp/djfhC2hzWsmhmZy+0HKvEPg2Os3PuSx4uDaTEAm2N?=
 =?us-ascii?Q?uS4U3PhAucz0ydi6GuNEdWq83hmUek3O6zgGbLdk0/IB9oRDO0RZgqQF3tsB?=
 =?us-ascii?Q?3/tyiEdcI6IYoM0TJfNimGmuqKboqoN1Poore14w6osyfjhX/Il3ySucyMJ7?=
 =?us-ascii?Q?5ut+HY4NI8Zkv/TvJIQaqquVyR35IMj8KWdj8PSUmH9VL4IKaEf3v5uR7UFx?=
 =?us-ascii?Q?J8fZmL8PUPCYzHSFqcc0/+GYlyoz8U3fmuQOfkpYSybiynKZhIW52hOhWb4r?=
 =?us-ascii?Q?lVwDtWyV5ATcGVnnJnUh/4Fdb621VOBXiVINgvZTov/1zoDSfAM19s7brTwP?=
 =?us-ascii?Q?4f98NiVR7HnhG85i+XkL9Y96viJOZfidIhn7XjjZFGy8iXJlyfVEjjA0Warx?=
 =?us-ascii?Q?5d0KX/ILKc7zBAOCRXdftWybnrmD3UHAKv8PuDeqRlPWSWJXBNjxa/ebDZBR?=
 =?us-ascii?Q?il9X0KG9GM2O84TTMTPapqdjs1eivhwlWzQbzKfgwM7ZkENCHkZpuQm1WNAm?=
 =?us-ascii?Q?bG5spE+iTjMoYNHk6Xo2hqIXQdKZ6mnB7bZsX5Nwj+Sgog9+OC0oq5KX6zmE?=
 =?us-ascii?Q?K3cHF1Nbc9fRYrKqq9zfk2ijZIrrFgztAiipKvnrs9beAxlDSh2abKdiH+t/?=
 =?us-ascii?Q?JsF+lX0hWio9dicqiCWrk2vw8gOIUIYIYSta+Llna3+jAuOmFZquZt5nkcG+?=
 =?us-ascii?Q?cxKKMcQIXqd7vBllOfUlPFz557NvdPTzhNZh2AZQyKvpQcl6Aj/2oXB7Ncd+?=
 =?us-ascii?Q?oFIT1okw6QQ4cFqyMNMop7OeB3xfEoyy8qRklr5Unq7sfKBJcfvI5PuM5wka?=
 =?us-ascii?Q?M5cZavdt4WbFoRJJqojKIevhWvafSXxK/DiSigSps31oRpSjuqvT98vBCu9v?=
 =?us-ascii?Q?sr3q9I6bxQpdM1hmrdoPP7DTJn+/2mMOa21Lrex//QjkZLDzjXNVoXzXtexd?=
 =?us-ascii?Q?SExTlzioR4N6M4H+BkrTIjZtV58BnIUMOTtMbs5Af4QvfwO2Xm0ltUgmngAo?=
 =?us-ascii?Q?z9ygv3IysCasyx2LlqQ0BGAHhrxgyB6Kg4aQ3j7pXB58T5HJ8Pf1MZljOUWJ?=
 =?us-ascii?Q?Sy/7WTNE1aIDWkTY8nCDbVYC6CWVeml8hta2HB56LlzXFQQ+EsEq6vSYDNdV?=
 =?us-ascii?Q?nGJsSBLSXsdvX4zaNpP5/LKRQRzQZoM2fAVK4uCZpp1Mva3yAvLW+xJb5ugI?=
 =?us-ascii?Q?61XxW5YuSsKJe1gV/qyGYV+q+jBEE6vSiGkftXcLyl8M1412hXc8GoUfql3i?=
 =?us-ascii?Q?KlHUSmUWMDWUkDigjdDIddkWwK1RafrxauOoQ2gUF5T5XwX45SNACQBv/crp?=
 =?us-ascii?Q?90O9OAtm78BPAZRdp84asQHcQm/ibrQBDv8tQj5QVCte7v7rHhhjSXiuuXCM?=
 =?us-ascii?Q?lNgZGMvDGA0mAyuLYDI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6628923f-b7a3-4446-804d-08dbe0151ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 04:42:31.5598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDk88FyYqGUNL9BFcWEFKLHCZLWGIDeD7LqZNC9fNs3I6vnAeTdaTzLhR88uDAR3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is.
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, November 8, 2023 12:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: Add support to fetch pm metrics sample

Add API support to fetch a snapshot of power management metrics from PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2:
        Return EOPNOTSUPP if callback not implemented (KevinYang)

 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 17 +++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        | 12 ++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h   |  3 ++-
 6 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index f9c438d16c56..6a1d31e8fdd1 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -431,6 +431,7 @@ struct amd_pm_funcs {
        int (*set_df_cstate)(void *handle, enum pp_df_cstate state);
        int (*set_xgmi_pstate)(void *handle, uint32_t pstate);
        ssize_t (*get_gpu_metrics)(void *handle, void **table);
+       ssize_t (*get_pm_metrics)(void *handle, void *pmmetrics, size_t siz=
e);
        int (*set_watermarks_for_clock_ranges)(void *handle,
                                               struct pp_smu_wm_range_sets =
*ranges);
        int (*display_disable_memory_clock_switch)(void *handle, diff --git=
 a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.=
c
index 1ae3b81548fa..4717884a2bc4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1299,6 +1299,23 @@ int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device =
*adev, void **table)
        return ret;
 }

+ssize_t amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_met=
rics,
+                                 size_t size)
+{
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       int ret =3D 0;
+
+       if (!pp_funcs->get_pm_metrics)
+               return -EOPNOTSUPP;
+
+       mutex_lock(&adev->pm.mutex);
+       ret =3D pp_funcs->get_pm_metrics(adev->powerplay.pp_handle, pm_metr=
ics,
+                                      size);
+       mutex_unlock(&adev->pm.mutex);
+
+       return ret;
+}
+
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
                                    uint32_t *fan_mode)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_dpm.h
index feccd2a7120d..9b3fef5474b1 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -511,6 +511,18 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_de=
vice *adev,  int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *ad=
ev,
                                      long *input, uint32_t size);
 int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+
+/**
+ * @get_pm_metrics: Get one snapshot of power management metrics from
+PMFW. The
+ * sample is copied to pm_metrics buffer. It's expected to be allocated
+by the
+ * caller and size of the allocated buffer is passed. Max size expected
+for a
+ * metrics sample is 4096 bytes.
+ *
+ * Return: Actual size of the metrics sample  */ ssize_t
+amdgpu_dpm_get_pm_metrics(struct amdgpu_device *adev, void *pm_metrics,
+                                 size_t size);
+
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
                                    uint32_t *fan_mode);
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev, diff --git a/=
drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/am=
dgpu_smu.c
index 37c2605f9b35..930e7e3532ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3189,6 +3189,20 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle,=
 void **table)
        return smu->ppt_funcs->get_gpu_metrics(smu, table);  }

+static ssize_t smu_sys_get_pm_metrics(void *handle, void *pm_metrics,
+                                     size_t size)
+{
+       struct smu_context *smu =3D handle;
+
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+               return -EOPNOTSUPP;
+
+       if (!smu->ppt_funcs->get_pm_metrics)
+               return -EOPNOTSUPP;
+
+       return smu->ppt_funcs->get_pm_metrics(smu, pm_metrics, size); }
+
 static int smu_enable_mgpu_fan_boost(void *handle)  {
        struct smu_context *smu =3D handle;
@@ -3330,6 +3344,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs =3D {
        .set_df_cstate                    =3D smu_set_df_cstate,
        .set_xgmi_pstate                  =3D smu_set_xgmi_pstate,
        .get_gpu_metrics                  =3D smu_sys_get_gpu_metrics,
+       .get_pm_metrics                   =3D smu_sys_get_pm_metrics,
        .set_watermarks_for_clock_ranges     =3D smu_set_watermarks_for_clo=
ck_ranges,
        .display_disable_memory_clock_switch =3D smu_display_disable_memory=
_clock_switch,
        .get_max_sustainable_clocks_by_dc    =3D smu_get_max_sustainable_cl=
ocks_by_dc,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index 8def291b18bc..32600ba74bf1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -253,6 +253,7 @@ struct smu_table {
        uint64_t mc_address;
        void *cpu_addr;
        struct amdgpu_bo *bo;
+       uint32_t version;
 };

 enum smu_perf_level_designation {
@@ -1252,6 +1253,15 @@ struct pptable_funcs {
         */
        ssize_t (*get_gpu_metrics)(struct smu_context *smu, void **table);

+       /**
+        * @get_pm_metrics: Get one snapshot of power management metrics fr=
om
+        * PMFW.
+        *
+        * Return: Size of the metrics sample
+        */
+       ssize_t (*get_pm_metrics)(struct smu_context *smu, void *pm_metrics=
,
+                                 size_t size);
+
        /**
         * @enable_mgpu_fan_boost: Enable multi-GPU fan boost.
         */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index 9dd47d91093e..ea8ea99b7436 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -259,7 +259,8 @@
        __SMU_DUMMY_MAP(PowerUpUmsch),  \
        __SMU_DUMMY_MAP(PowerDownUmsch),        \
        __SMU_DUMMY_MAP(SetSoftMaxVpe), \
-       __SMU_DUMMY_MAP(SetSoftMinVpe),
+       __SMU_DUMMY_MAP(SetSoftMinVpe), \
+       __SMU_DUMMY_MAP(GetMetricsVersion),

 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)  SMU_MSG_##type
--
2.25.1

