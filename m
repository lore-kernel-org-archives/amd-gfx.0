Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74416C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 00:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B1A10FAE7;
	Thu, 21 Mar 2024 00:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVg/ln6L";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD30910FAE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 00:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrKJHCanD2AEdzENUl/iy7/nCr+E3VX99IxPO8gzpQGMTapBlwEr+offMem4cViXvwEcvSPoFsTPP45HmR76UX5GoMF9y9vA+RiF4/wIB6GJ52SmHRk/8p1l8Vb4tdvrgBMkwsZopUsy+1x86ZX5bSRxTPtXhOHgKBNxKQk9u9Bkj4Mfb30AS/xnPoenhd7wFqk37VZxmpDy8bpZHHXAD7ZrZnuyFR+JveN8JTGtDRCZoRCk793PwDmY31sBC7U48nkJF+Cb1z8n0tZJEZd+TiROQ3Ib1d9EkGt5NyLIyZuhBTjblzJ2ZUKpXN07Jo98ovl+NfgKDUrRnmM4MVICoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dioiRK+VPBhJG+7Bc5eFsfKqpGd6XnKCkmDpvayqVfE=;
 b=esYS/Q1RFU/bODLPvC00KA9XotJ8U9ZfjIMeRsZv0JTYnCEiituP+GciV9LVEG0ISWdTobVy078JrujyJNgzwIpBs97TIujuV9/iUKodhdAjab376tXQJKSB3uX4j1I2CwJaTp51c8WilIpmEDYkUJzEIx4bwEVUAAVEfw7cXjMpiWalvhUa2lCRlJzEml+AafL1820+NKMoqHhR0lcg+QceOt2osjip3jaP0M7ehccbrgPYylbyF+lGiTTQinxwHA4DjRoqXSs3r/hDrxgNlKwZVj4Y1Y9qQf1hAi3I7HSkOlNjXF/XIPks63J/Mfx9SSaniIfA71b7QnSkkjHTag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dioiRK+VPBhJG+7Bc5eFsfKqpGd6XnKCkmDpvayqVfE=;
 b=nVg/ln6LpH0bVKHSF5t/ptqMBM1gCSPrRRJmvBGYG6n1jBP8K7O0j7GsgLN6wsBgs9y96LUbGChaAYMmb9oXVrsXmi2KoPp9N1iL9oQ11AcWIcRq4bLJDS652IJ66QUbyEC+6N5PMd8WAoRvOhNymE3q1IfI1VbvXMvCf8sSpTg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 00:25:27 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 00:25:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liu, Shuzhou (Bill)" <Shuzhou.Liu@amd.com>
Subject: RE: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies
Thread-Topic: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies
Thread-Index: AQHadgbJBYMjNHVgSUCWP9rnI64BqrFBYAPA
Date: Thu, 21 Mar 2024 00:25:27 +0000
Message-ID: <PH7PR12MB599741DFB3D1092411A6A7F882322@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
 <20240314115630.682937-2-lijo.lazar@amd.com>
In-Reply-To: <20240314115630.682937-2-lijo.lazar@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3bd9d8da-ba9c-4809-8791-b8c78d8c9a85;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-21T00:23:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ2PR12MB8941:EE_
x-ms-office365-filtering-correlation-id: 433f9a57-381a-4d37-8aab-08dc493d687c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mCaad5x7bBEK0ZjDuJWLzauwaFbisYGTbnhjQi0fo8Tkk7Yoztu3dA/wYj4vFZUwYQ31Uvln21WaX9we2m+O/9FuPb/vBE8+UraXdFxvhPpBKc2yfylUjzxYPrMloIax7hi5LHqtbUH3GbP7ZqZbKu1xDCcsojoW8xG6CFIO9fnuCcVhf77wCahcnP0vOMCJ4ROY4pwZYQenChk1ZA9f4YpB/6tZ3k3eG2IizXmyDSdt2HegunucKRmb53HuvatGK8uSuuvLhhAr1xuy0txTJHam3OIEXK0vNa7y6bjkVnD7gVD7JEI+HVI+dAjWkqsrXTy1GvYEvty+nRphZ78e/PRbOsT4YmCEdSCXE5coONTbK9A+Ynoqg6it4j11LokCha4PpYA6J/yBYY7IjSWg57E8/MSTd4BQX/MBxpqhqn6em1udx0VSLMi6XFyURBTA/iTQj1jZLH9jxi/vVzNe0lJ866GOYGKXDBNINCyP85pYYGqCSOQaT77GF0UfHfEGg/FIEwnjBGGXc6+R/KvDuo6dkVBb11nRYjSn+DOg2GmdB6qrPrSh/lZIVRxzaeDBA/HS+XovA43pLElZw4Ux36dQ2Ke3a2bdHR0xx38euCPBP2XdAk8ifFqd1EKjmTDvBW7NyuIeliDbDNzTcdUOFvbnbRmono2Q20tGC7rLZb7SSjWZyTkPsaCls+1dKkbJh2N+lXeqXoBMdSeCN25gGSmC9JWRNq8kY8or6JaG7eE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jxg92xDS8jgKzKYeOavT00n2GfmLM364upTcl8CKpINmKrsyy1H+mz/EKPGV?=
 =?us-ascii?Q?X+PyXwgqhGEwsYjk1OyM2wUfLurQd8yFNxgjfCLzdxJk4BrCRz+iq7sz5QZ3?=
 =?us-ascii?Q?9Lkr95zxJTp/GI9YSgmH/B/t5+QTOioyIzpFNK9Wduj3vWUEPKWtD+7lZ+kg?=
 =?us-ascii?Q?9ZdnrzL9hzVpbWMFaSqgDkbpdi8hrfaHsJeMYpdJCwSaTEZJL+y+H3NR2znT?=
 =?us-ascii?Q?2H4kFFtE98+9eD95FHd2tZsBkfiiaDI5kVL+6wDuLnx9TJVqsya7MMLxQP8z?=
 =?us-ascii?Q?MtmiW8u6ss7ISVsr+T2GSULKwdCkCWwiSFR53Ujsf4l+uXQXYnEYNPDpbzoX?=
 =?us-ascii?Q?8UJgmkoeA4xfYWHvP439gp3btOp8fWUcbZKUIt/JpIrKNUz+m1UltYHJNjAA?=
 =?us-ascii?Q?qkbifapchOiq8SsjckqZdiz7wTycg04EFz9w8XhSbb82SXonBIXnaTp93lEP?=
 =?us-ascii?Q?xOL0jpzN/nDRDa7sH7FiyMG68U63q4uw/cVtCdczQ81lXNbktnH2hB6cCtyK?=
 =?us-ascii?Q?Yms4x7GbfmuiqOICgCdmJIcsfrB2dU6bNNPkijp0p6ra+TorTJo3Z5sW7GaH?=
 =?us-ascii?Q?Sce1F3MpCKU9+7kCkYdn3Y1dJTVBnaB+GN+FeNyyXOTYH5U9DiCCz0YKCZIi?=
 =?us-ascii?Q?LFT1cqFP7doO2FXIniCwjLp6JAxxIE5sW+VPPT9ziiysojtaTz60pvH1U0TT?=
 =?us-ascii?Q?7h3iAWg1TofrhUfm1POb2vTkowr2PJOBrJa3lNP0o5qqT6eRhjb4iI3EDB2V?=
 =?us-ascii?Q?DqCsframEg/W20hzuELKg6yhINWB+/TsjwI3fYsZb+/LNlB1EhbzeHDg0Uao?=
 =?us-ascii?Q?LerRs+XQJj1K62dDobNMuFyQ9Qzaee0Q45cn8Go+xAl8McOzWamtRsQG6qlg?=
 =?us-ascii?Q?1AopmcK+g8m/Olo9/zTs5mlU2ImcirLsa3M0MHi22hAP4C25EIkjN4frxLOR?=
 =?us-ascii?Q?y5FThyYdwjKmjJFnJpYVmU7EXIF3BoE31/P7pv2S2DYIKSzepe+5O0Hc6CB+?=
 =?us-ascii?Q?L2hfg4y/k5nGX67AUJXNE6sL8zpSe2QUmKDM6rS1BUv+GVvyzKN4qIGiGtEl?=
 =?us-ascii?Q?gXZEvEZx1uhL8kmCsxXAv5umf4eRJxFoyGvUIuAIpOFIDGwGnI6cO7UVHYU6?=
 =?us-ascii?Q?bUAr4dM6W+L36bA6bOlnxCSMuI6fBF+B0jqwiOSf2jkBE1hiLOPUY+DnJe9V?=
 =?us-ascii?Q?U/pbu5sgXFYkPF6AImDu0zlMy0UAt68r/GF8LoeOwaIv6F8MgPjJxQCVzhSo?=
 =?us-ascii?Q?Aw1H5iIym73AEEspa3YrxbDqE7Eb2RML7RRqp0Qs8ltkSplD89yBJHNYoynM?=
 =?us-ascii?Q?95Go1QYFFeHN7CfDkl6OmgQYzgV9eOzcc74TfxUiqZRQ3XpIqcHPkC75pOJ8?=
 =?us-ascii?Q?7zzEwRoDr4FtpRFjapmDGbZ9cT49B2RbYS0TFNIb7/isgHIfhmz2c9Mp9BFW?=
 =?us-ascii?Q?2nlNfJdF6nQ5mfLg+9Yp3tZiMF/V1TQD0QSsbuRPOLJZa8F3asVx9spY9beU?=
 =?us-ascii?Q?CgaWqii5X1AE7EbMQkmFq8lt5S+HTSszEs0hOBpFnVza89IGBuUFkIH6OR2M?=
 =?us-ascii?Q?hqKzHKQk7qAv8tNdG/g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433f9a57-381a-4d37-8aab-08dc493d687c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 00:25:27.4189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73Oxu39qg1xl7JjrQJlulyKX5lhJTywqXSs5scmwDz4rVislAJfvbwIF3WZx7svt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941
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

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, March 14, 2024 7:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Liu, Shuzhou (Bill) <Shuzhou.Liu@amd.com>
Subject: [PATCH v2 1/9] drm/amd/pm: Add support for DPM policies

Add support to set/get information about different DPM policies. The suppor=
t is only available on SOCs which use swsmu architecture.

A DPM policy type may be defined with different levels. For example, a poli=
cy may be defined to select Pstate preference and then later a pstate prefe=
rence may be chosen.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
v2: Add NULL checks before accessing smu_dpm_policy_ctxt

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 16 ++++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 29 ++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 92 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 95 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 29 ++++++
 6 files changed, 265 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index afb930b70615..84dd819ccc06 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -273,6 +273,22 @@ enum pp_xgmi_plpd_mode {
        XGMI_PLPD_COUNT,
 };

+enum pp_pm_policy {
+       PP_PM_POLICY_NONE =3D -1,
+       PP_PM_POLICY_SOC_PSTATE =3D 0,
+       PP_PM_POLICY_NUM,
+};
+
+enum pp_policy_soc_pstate {
+       SOC_PSTATE_DEFAULT =3D 0,
+       SOC_PSTATE_0,
+       SOC_PSTATE_1,
+       SOC_PSTATE_2,
+       SOC_PSTAT_COUNT,
+};
+
+#define PP_POLICY_MAX_LEVELS 5
+
 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index f84bfed50681..db3addd07120 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -411,6 +411,35 @@ int amdgpu_dpm_set_xgmi_plpd_mode(struct amdgpu_device=
 *adev, int mode)
        return ret;
 }

+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
+*buf) {
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_get_pm_policy_info(smu, buf);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+                            int policy_level)
+{
+       struct smu_context *smu =3D adev->powerplay.pp_handle;
+       int ret =3D -EOPNOTSUPP;
+
+       if (is_support_sw_smu(adev)) {
+               mutex_lock(&adev->pm.mutex);
+               ret =3D smu_set_pm_policy(smu, policy_type, policy_level);
+               mutex_unlock(&adev->pm.mutex);
+       }
+
+       return ret;
+}
+
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)  {
        void *pp_handle =3D adev->powerplay.pp_handle; diff --git a/drivers=
/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index efc631bddf4a..7ee11c2e3c61 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2179,6 +2179,96 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct de=
vice *dev,
        return count;
 }

+static ssize_t amdgpu_get_pm_policy(struct device *dev,
+                                   struct device_attribute *attr, char *bu=
f) {
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       return amdgpu_dpm_get_pm_policy_info(adev, buf); }
+
+static ssize_t amdgpu_set_pm_policy(struct device *dev,
+                                   struct device_attribute *attr,
+                                   const char *buf, size_t count)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+       int policy_type, ret, num_params =3D 0;
+       char delimiter[] =3D " \n\t";
+       char tmp_buf[128];
+       char *tmp, *param;
+       long val;
+
+       if (amdgpu_in_reset(adev))
+               return -EPERM;
+       if (adev->in_suspend && !adev->in_runpm)
+               return -EPERM;
+
+       count =3D min(count, sizeof(tmp_buf));
+       memcpy(tmp_buf, buf, count);
+       tmp_buf[count - 1] =3D '\0';
+       tmp =3D tmp_buf;
+
+       tmp =3D skip_spaces(tmp);
+       if (strncmp(tmp, "soc_pstate", strlen("soc_pstate")) =3D=3D 0) {

[Kevin]:
It is better to use 'sizeof() - 1' instead of strlen() function to calculat=
e const string size.

Best Regards,
Kevin
+               policy_type =3D PP_PM_POLICY_SOC_PSTATE;
+               tmp +=3D strlen("soc_pstate");
+       } else {
+               return -EINVAL;
+       }
+
+       tmp =3D skip_spaces(tmp);
+       while ((param =3D strsep(&tmp, delimiter))) {
+               if (!strlen(param)) {
+                       tmp =3D skip_spaces(tmp);
+                       continue;
+               }
+               ret =3D kstrtol(param, 0, &val);
+               if (ret)
+                       return -EINVAL;
+               num_params++;
+               if (num_params > 1)
+                       return -EINVAL;
+       }
+
+       if (num_params !=3D 1)
+               return -EINVAL;
+
+       ret =3D pm_runtime_get_sync(ddev->dev);
+       if (ret < 0) {
+               pm_runtime_put_autosuspend(ddev->dev);
+               return ret;
+       }
+
+       ret =3D amdgpu_dpm_set_pm_policy(adev, policy_type, val);
+
+       pm_runtime_mark_last_busy(ddev->dev);
+       pm_runtime_put_autosuspend(ddev->dev);
+
+       if (ret)
+               return ret;
+
+       return count;
+}
+
+static int amdgpu_pm_policy_attr_update(struct amdgpu_device *adev,
+                                        struct amdgpu_device_attr *attr,
+                                        uint32_t mask,
+                                        enum amdgpu_device_attr_states *st=
ates) {
+       if (amdgpu_dpm_get_pm_policy_info(adev, NULL) =3D=3D -EOPNOTSUPP)
+               *states =3D ATTR_STATE_UNSUPPORTED;
+
+       return 0;
+}
+
+
 static struct amdgpu_device_attr amdgpu_device_attrs[] =3D {
        AMDGPU_DEVICE_ATTR_RW(power_dpm_state,                          ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
        AMDGPU_DEVICE_ATTR_RW(power_dpm_force_performance_level,        ATT=
R_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -2218,6 +2308,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[=
] =3D {
        AMDGPU_DEVICE_ATTR_RW(smartshift_bias,                          ATT=
R_FLAG_BASIC,
                              .attr_update =3D ss_bias_attr_update),
        AMDGPU_DEVICE_ATTR_RW(xgmi_plpd_policy,                         ATT=
R_FLAG_BASIC),
+       AMDGPU_DEVICE_ATTR_RW(pm_policy,                                ATT=
R_FLAG_BASIC,
+                             .attr_update =3D amdgpu_pm_policy_attr_update=
),
        AMDGPU_DEVICE_ATTR_RO(pm_metrics,                               ATT=
R_FLAG_BASIC,
                              .attr_update =3D amdgpu_pm_metrics_attr_updat=
e),  }; diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/=
drm/amd/pm/inc/amdgpu_dpm.h
index 621200e0823f..a98d1bda4430 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -594,4 +594,8 @@ enum pp_smu_status amdgpu_dpm_get_uclk_dpm_states(struc=
t amdgpu_device *adev,
                                                  unsigned int *num_states)=
;
 int amdgpu_dpm_get_dpm_clock_table(struct amdgpu_device *adev,
                                   struct dpm_clocks *clock_table);
+int amdgpu_dpm_set_pm_policy(struct amdgpu_device *adev, int policy_type,
+                            int policy_level);
+ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev, char
+*buf);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 246b211b1e85..1c23e0985377 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3465,6 +3465,101 @@ static int smu_get_prv_buffer_details(void *handle,=
 void **addr, size_t *size)
        return 0;
 }

+static void smu_print_dpm_policy(struct smu_dpm_policy *policy, char *sysb=
uf,
+                                size_t *size)
+{
+       size_t offset =3D *size;
+       int level;
+
+       offset +=3D sysfs_emit_at(sysbuf, offset, "%s \n", policy->desc->na=
me);
+       for_each_set_bit(level, &policy->level_mask, PP_POLICY_MAX_LEVELS) =
{
+               if (level =3D=3D policy->current_level)
+                       offset +=3D sysfs_emit_at(
+                               sysbuf, offset, "%d : %s*\n", level,
+                               policy->desc->get_desc(policy, level));
+               else
+                       offset +=3D sysfs_emit_at(
+                               sysbuf, offset, "%d : %s\n", level,
+                               policy->desc->get_desc(policy, level));
+       }
+
+       *size =3D offset;
+}
+
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf) {
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       struct smu_dpm_policy *dpm_policy;
+       size_t offset =3D 0;
+       int i;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt =
||
+           !policy_ctxt->policy_mask)
+               return -EOPNOTSUPP;
+
+       if (!sysbuf)
+               return -EINVAL;
+
+       for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+               dpm_policy =3D &policy_ctxt->policies[i];
+               if (!dpm_policy->level_mask || !dpm_policy->desc)
+                       continue;
+               smu_print_dpm_policy(dpm_policy, sysbuf, &offset);
+       }
+
+       return offset;
+}
+
+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+                                        enum pp_pm_policy p_type)
+{
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       int i;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       for_each_set_bit(i, &policy_ctxt->policy_mask, PP_PM_POLICY_NUM) {
+               if (policy_ctxt->policies[i].policy_type =3D=3D p_type)
+                       return &policy_ctxt->policies[i];
+       }
+
+       return NULL;
+}
+
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+                     int level)
+{
+       struct smu_dpm_context *dpm_ctxt =3D &(smu->smu_dpm);
+       struct smu_dpm_policy *dpm_policy =3D NULL;
+       struct smu_dpm_policy_ctxt *policy_ctxt;
+       int ret =3D -EOPNOTSUPP;
+
+       policy_ctxt =3D dpm_ctxt->dpm_policies;
+       if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled || !policy_ctxt =
||
+           !policy_ctxt->policy_mask)
+               return ret;
+
+       if (level < 0 || level >=3D PP_POLICY_MAX_LEVELS)
+               return -EINVAL;
+
+       dpm_policy =3D smu_get_pm_policy(smu, p_type);
+
+       if (!dpm_policy || !dpm_policy->level_mask || !dpm_policy->set_poli=
cy)
+               return ret;
+
+       if (dpm_policy->current_level =3D=3D level)
+               return 0;
+
+       ret =3D dpm_policy->set_policy(smu, level);
+
+       if (!ret)
+               dpm_policy->current_level =3D level;
+
+       return ret;
+}
+
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
                           enum pp_xgmi_plpd_mode mode)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..39405e4ef590 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -362,6 +362,27 @@ struct smu_table_context {
        void                            *gpu_metrics_table;
 };

+struct smu_context;
+struct smu_dpm_policy;
+
+struct smu_dpm_policy_desc {
+       const char *name;
+       char *(*get_desc)(struct smu_dpm_policy *dpm_policy, int level); };
+
+struct smu_dpm_policy {
+       struct smu_dpm_policy_desc *desc;
+       enum pp_pm_policy policy_type;
+       unsigned long level_mask;
+       int current_level;
+       int (*set_policy)(struct smu_context *ctxt, int level); };
+
+struct smu_dpm_policy_ctxt{
+       struct smu_dpm_policy policies[PP_PM_POLICY_NUM];
+       unsigned long policy_mask;
+};
+
 struct smu_dpm_context {
        uint32_t dpm_context_size;
        void *dpm_context;
@@ -372,6 +393,7 @@ struct smu_dpm_context {
        struct smu_power_state *dpm_request_power_state;
        struct smu_power_state *dpm_current_power_state;
        struct mclock_latency_table *mclk_latency_table;
+       struct smu_dpm_policy_ctxt *dpm_policies;
 };

 struct smu_power_gate {
@@ -1547,6 +1569,9 @@ typedef struct {
        uint32_t                MmHubPadding[8];
 } WifiBandEntryTable_t;

+struct smu_dpm_policy *smu_get_pm_policy(struct smu_context *smu,
+                                        enum pp_pm_policy p_type);
+
 #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !def=
ined(SWSMU_CODE_LAYER_L4)  int smu_get_power_limit(void *handle,
                        uint32_t *limit,
@@ -1594,5 +1619,9 @@ void amdgpu_smu_stb_debug_fs_init(struct amdgpu_devic=
e *adev);  int smu_send_hbm_bad_pages_num(struct smu_context *smu, uint32_t=
 size);  int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_=
t size);  int smu_send_rma_reason(struct smu_context *smu);
+int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
+                     int level);
+ssize_t smu_get_pm_policy_info(struct smu_context *smu, char *sysbuf);
+
 #endif
 #endif
--
2.25.1

