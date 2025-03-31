Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC64C28B20
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 02:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56CBF10E07C;
	Mon, 31 Mar 2025 02:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MYFE5j/P";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C1F910E07C
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 02:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuIAcpo2AgTKPexi1yMQt8HCjAOsgzHLOBSz3Y0tP8ojkEDA3cedkyMqhhDqL3T0FB+AqZs8AHzpNsjS1uER4yXC3WelKrX126IVHga2VRQKlnBVFCERRZ307ovfC7SekBUqVsY63a5ZBaSduOfYsV+rDQ57fMQNf0iW9GrILPhE/WJNbTcpZ6+shDzj/NM0RxgMzPjkR9KssAGS5s5/aG0j06wRG7bfES8z3hBfSvciLkl7J5vgvgbCVRtiHIGHk/pchwPiOoUNfuup/Nqv5E2E+Qwi7favRlWo7WBaysn244S6xW0cnLyvIdmAet+kHdMUMI2i9jxjnOeLeV9wNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGWWO985cVjFtoeEqlAQkiX4oOLR+kaZzV53QWVPACM=;
 b=gcpUL+1s/+UeJzHd12S28OSoeq6lleb4aFunWUclf/6SM7LtUWU/tnUNOKAqklpwWBJ5zwfh10jhnFqzdPAQlXqys5292Ajb8BMmSBnYWGlUNk0EhQ2Wn9DD5eAJbwZpxAwhXQ0Q7wpZMa5F9mPjMwXvClQdWCwMsBIrh4vzMAX3B2LfJvFPkVCMgQRp8SDz5j0bYhwvih93dPtppvekrVBYvr7uUAS95hp9xP/A+mluM0VQc9JHvEz+QynPdLA8gv2Ya4/GkcdIasscW1SNWeQZn5tk5DgiqKimhxlw9Zhxyfc9rSF239NuwEwqSQZfTKgc+gzCw3fRYqa0QQ9L1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGWWO985cVjFtoeEqlAQkiX4oOLR+kaZzV53QWVPACM=;
 b=MYFE5j/P3w/Iz/F0RAl9O44ZX8Owx7MAv3xeVEjWTv3UMbXgcT6MhBi1vssQwH2UpsOZuMNHKns0QSeh8wWZahCGgRBTjvJvszRjxREV1ssNRdssRl+qJvg7xQDEUWUyz3fbjPfQj7K1yt4sRWE92BQSr059wz2501ft/Cu+JYg=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Mon, 31 Mar
 2025 02:03:27 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 02:03:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu/pm: add workload profile pause helper
Thread-Topic: [PATCH 1/3] drm/amdgpu/pm: add workload profile pause helper
Thread-Index: AQHboA6cR2DamA/liUiDr93Vz/Cxf7OMgeAw
Date: Mon, 31 Mar 2025 02:03:26 +0000
Message-ID: <DM4PR12MB516564F891A5EB10F1F7BD6E8EAD2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250328182342.17110-1-alexander.deucher@amd.com>
In-Reply-To: <20250328182342.17110-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=20c3e724-1b9e-4500-a288-651b04350476;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-31T02:02:45Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW4PR12MB6828:EE_
x-ms-office365-filtering-correlation-id: 6ae774ea-4051-4ad7-9b16-08dd6ff839d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ICQq7ncflNa8xkryF5QCp0MXHECksMg+MfP4+hq1O/prdrVuny2yPmqIDpRu?=
 =?us-ascii?Q?h1kOC2EGNBz4QJPcoPWZcsqJLuFhs2DcBwRPj5o+ucoG50bqMBGq1JuKssxO?=
 =?us-ascii?Q?pqIF3Y9bjc2S5BMe2H3IthIXyo1oF5eP4PixPaQF+dtVvFXX8mBx7xhD3ejR?=
 =?us-ascii?Q?a8W8ycaFo8kUtFbMZRl0e179YAvn8hBCAs/PkvDh4Nn+U0mW14bP2jThyVzu?=
 =?us-ascii?Q?ofPwovG7FCO839aTHXTVKqJHjh6ipFkZiXyNUMQdSI84Zjw4VDgExy3NirYZ?=
 =?us-ascii?Q?rHM63JsZ9JH5utBe1Qde436E0FexjVNjTYKfQstSoLqr8jegz52D3RkoRYeN?=
 =?us-ascii?Q?/euXgFO1zp4lUMTMPviQ2skY4OkSXEW6Y+SZVSqK1vj/sSXxq1PEasYBDu5D?=
 =?us-ascii?Q?i6uAjJBn5fyQw+x1HAK+EFLsRjF8zDuvm4bPhSHjkU6dWVWm50xCazmAcMil?=
 =?us-ascii?Q?1D4cyOGY87St81zame1beMz4ZlHhBJC2NcokS7vptNtSVpBlTlh3J+B09Q7S?=
 =?us-ascii?Q?595zMRCFEuiOuiNcOOkA+4yUov/lgCiOy0xylPGKuQ32+5FFSlNQcDxkRi3B?=
 =?us-ascii?Q?bmDa6VK5ok4dN4M0npkRUnjirT9BSesQtTPgKpt7QubKdIffOFqQV+1Mn+Of?=
 =?us-ascii?Q?7LhD43+3ZWuwaG04EzWILzkqSBPwXnTiRuQ5Ax85Wv3ENDNUrRgEEiePH3hw?=
 =?us-ascii?Q?b2SrefHQmDCYflft/J2kFXJFmaxvX52rJypcLCjpK3F7NITFO29f53pzLIVy?=
 =?us-ascii?Q?ocjiEmu0KA9P1qr7S8NI0gr+VlBA0ygsrT1FERrLn6wnZcstHX6YE52aFrcS?=
 =?us-ascii?Q?MvX+JPBVHgJAGa7RA0XC2RJOBkokYjrKxQjJ3Kb/0NgqFrJSBjzJVX+fchLa?=
 =?us-ascii?Q?iSXE/RMZDLjeznZH4KDrAc+71X/Zba9MAnqog4PNm0USj9LzW5DO4b7VPafD?=
 =?us-ascii?Q?okhJz4CZ7AVj2BwBYnkkSmeGAaDyiqZLKkQAHAuUz9WiboHqmwoa9slpYLRT?=
 =?us-ascii?Q?1zL/xN9n9yJD8x0X5XWOXih0yPEnd8P7LG7mMqL/wLbuxsFmnh+AJBGQjuis?=
 =?us-ascii?Q?uvFb8wZlDLlS+ejLAc6Z1hpCrDR6ze6buVUXtjPh7ULHOCjKP3/EbzEzHgi9?=
 =?us-ascii?Q?bAnQEjrAmQB1ogMvEpQ9vEtGsAmfI3L32EMWr0/wUMDfc43osvbyvTIqChGc?=
 =?us-ascii?Q?1JbtDBPDyxGdOUGRy/ImxeVBCao800qXnjdZ00PWXmBequlMjG2reVyvxlzI?=
 =?us-ascii?Q?Rtn7fML9Mcqf+zxzMNthL3Uqw1/eJcJgycwIY891yB7IXm5jJMauivll63I6?=
 =?us-ascii?Q?uPPAFrH5WA1QBSdfICvofsMvi8FidcGYFpwcz3f6GBRZIXmpd737XLSeu9EO?=
 =?us-ascii?Q?J7tisURMUE6/kvimGa8sJU34Z8R6eX8NQezYd2ju2YTh9WTKiAGZoUJz+fVI?=
 =?us-ascii?Q?cTrssCS+Gis=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B4Pm+ip9hdd2DHnD2UdoSQUPJr4iScgkhBpBV9DEafUmSngVQKIQvjcQ8F5K?=
 =?us-ascii?Q?JF9+Ui6YB9N/RijB6r2+nw7AHQpPkow0LTKOXwXBBY0Xy44FJuHlxB90Oi26?=
 =?us-ascii?Q?j8SzQV5KdGUPrl9exRguC4fhlP7H23BCHcreWsjznmCQ12qR4C2KnBMEV1zc?=
 =?us-ascii?Q?5+YYLt/Z6euXuuTtiDzeSiaKScqY+AgBA0kmhlrQjpt8Z1biyUAVmgVHVSwq?=
 =?us-ascii?Q?mZxivtQflV2pkmU9x7rKPpyrcnVBo/lopg9yWizqrSDL8+ocQDEdd5TK1BxP?=
 =?us-ascii?Q?ZFehjPxnEqzl2WOWJu/sfZh9/lguBVVxDTzYhmkqAl9kKYodExpBToG8OYo/?=
 =?us-ascii?Q?X44UxIxaWpzmuAIMMpeR32YccnssLA/FLZcFlKOAiyPBCB8148BOoCcuzTTd?=
 =?us-ascii?Q?W7N+UOl6DOgp16VgSgOc9lufAAvRdfpl/xzQv9cfGDzyidl9+WsYLccDVeDL?=
 =?us-ascii?Q?d+wwthqc5pZh0MywICm5wkHA1Zc7pXzcjteBWJxZyEunF2o8noYP/Ec6VZKN?=
 =?us-ascii?Q?M9eII44VQX+pakTDtDvhVCQEIRlhd6QSaek7MOhIL93PTEvMdTGk/kaPoc78?=
 =?us-ascii?Q?hdoOx2dBZ340c8CN/5fREmNbNhbmXVMRvchejMeWDOaWAfcmO5/+9vD963XV?=
 =?us-ascii?Q?03MOufAh0hoIOv6xq9VAfJKnAy4p4AI+ArsLHp6EpMw4j8ZI8V7Skh6FS1YH?=
 =?us-ascii?Q?Jn8MCkgrnxOtIXU4laynK3grYXuWl+l4zkCMMAxDPziesOLca/RWA+7/6OdB?=
 =?us-ascii?Q?NOriL+RjpyX4ZOxrwpZxSYoAUtVPkZVcpJXuaJ+Bqd03ESdRYYXpP/UDJrd/?=
 =?us-ascii?Q?QS1sRMxb6g+JoiMbuc17I5bKRQ7YaMMNc3FpAf409Tvp7ewFjhxSSv69GULC?=
 =?us-ascii?Q?ZvLVx3nzBQ6nGYpx4Ak5K7eTW7isibpLkbjqc2YN/e8QEi5miszk5cKji5WS?=
 =?us-ascii?Q?4JkxBqippRKhFkYRYb53vxl7DLdzBgsmqdr/fSyC7yguAUXO8ywL5q+gxdwa?=
 =?us-ascii?Q?0ZTT7Mh5uPUKrZFBT2q5ImCGoEepqj7qlNwjl8NjGlw0Q5TCcOnx/RAyKysn?=
 =?us-ascii?Q?c8rZzCJB3jS2IZ6AaHTeAmW+52mVvJyIPhYc6i58V+Kwev4U28Qnhnazjn+H?=
 =?us-ascii?Q?CsXRtNPnsytK9k5k6VtvoPXxrlBGcgH8nRrKDmaFEYgYKc5q54veJLhGsbwY?=
 =?us-ascii?Q?yJUYbp0wZAUVbrOU2mJYPF4oD5EINzAgn5uooFXIYZrc5hIPgCfuMvd8fcS3?=
 =?us-ascii?Q?bwdJfFPMMNM/qnFSnBefQB0sOj3sxHU2Sza/C1hvHwOCDN471t799mU9kRpp?=
 =?us-ascii?Q?ER+z3S1dZv8uoB1dfdZmyHtBYYXDhh8LhqULb1DO2P+Okej5K7RDniOSem0T?=
 =?us-ascii?Q?zaiVT/cFyxclyJmeGP1M+2ROYdxPRl2LdRp6uOyT2cxmC667DFqNoSLMU1RR?=
 =?us-ascii?Q?7q3QaLJSLzcgyf2iyXth9SiJDatHqUwWXRgPa5WfJt0WXUnFAZUFbKcFa5Oe?=
 =?us-ascii?Q?2XK8zX8JfTqaOgHAtPPVM/Va2cAV6lzeOhTPZWrs9N0V7qRppUAmfDsmbnNt?=
 =?us-ascii?Q?UT4Vcq6lhlWa3noBw5c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae774ea-4051-4ad7-9b16-08dd6ff839d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 02:03:26.9190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUmptk21eRVaJqREafyyKSojrVZeAsKi8175J9gBsgLSL9tRWhUK0NM3HPDL+cQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, March 29, 2025 2:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/pm: add workload profile pause helper

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


To be used for display idle optimizations when we want to pause non-default=
 profiles.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index 2a9606118d899..21dc956b5f35d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -429,6 +429,7 @@ struct amd_pm_funcs {
        int (*set_pp_table)(void *handle, const char *buf, size_t size);
        void (*debugfs_print_current_performance_level)(void *handle, struc=
t seq_file *m);
        int (*switch_power_profile)(void *handle, enum PP_SMC_POWER_PROFILE=
 type, bool en);
+       int (*pause_power_profile)(void *handle, bool pause);
 /* export to amdgpu */
        struct amd_vce_state *(*get_vce_clock_state)(void *handle, u32 idx)=
;
        int (*dispatch_tasks)(void *handle, enum amd_pp_task task_id, diff =
--git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu=
_dpm.c
index 0bcb82b2f3ae0..0e4d243641c8f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -381,6 +381,25 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_devi=
ce *adev,
        return ret;
 }

+int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
+                                  bool pause) {
+       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
+       int ret =3D 0;
+
+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
+       if (pp_funcs && pp_funcs->pause_power_profile) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D pp_funcs->pause_power_profile(
+                       adev->powerplay.pp_handle, pause);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
                               uint32_t pstate)  { diff --git a/drivers/gpu=
/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 72565fab60673..df8850a01ea6b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -410,6 +410,8 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *ad=
ev,  int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
                                    enum PP_SMC_POWER_PROFILE type,
                                    bool en);
+int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
+                                  bool pause);

 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);

--
2.49.0

