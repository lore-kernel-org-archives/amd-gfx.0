Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1817FC5472D
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Aug 2024 03:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7434A10E143;
	Sun, 25 Aug 2024 03:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vkfdGwlg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C031910E143
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Aug 2024 03:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xuee7fKZNxd+mYCY1bjpEkGE4MbqlZHkkPecEtDO9t4W8wEwQQheM8cECQdtaHLRz6ElNUhNVYhV1X/3X1073lnJZhHrmKnHEmv3IJ07IBXDjWtRLn9K4e2Tpe962qdvkW+n/45A7gHPmMBiLsZ0GgH5kMpmTpdjTxDRPEq9PBUhKOk9QwzX+JbFIQr02hb/JNfTylOk+FFDxc/TZJvqMOThikg0d843FVwGoOgFhLOq5acFdNT2yR6K0chL5VDbjAfaLULWPjVop1snG4SPKWCZ2u8v0w/qHV+f6rgdgxPGOAFRnEX/LrBypvW1oVfvYAnb03yBmkEju/9hq2bwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpcGrNI4EB74ECgJxHLrxG9OZJwtmiWYOeuLlrAdxC8=;
 b=Cw4Y0UcXSmZkcBX/AIH4R5PLXY2HfJKtlw0dHGP9F8Jpr47ZK7agoC7w2gRcFKqcLnBHcQyeOm5Niyhsy8n20FK9G/dMvb1Db1HyFo+O9DlM84hGpkXNdwudKSBHqXNqzI8FPzc24+/FWdlnU4hD+x1/X/dQ/5MELzZmnnr96nY0tFXGBW3wcnmY6wOZf66+gfsG0/OpHYWoge0DQWHLftiKQlr41ghqkyoBkMDeC8e8GLVG5qM+48oPStfN1ZYN0FSIk+m4+Z9abwa+0YNAH/rOkhmQTJj+2+kxhiI2udtiiaL7NGGEVvdEVRK7MKo7WFyjORKOABI4RgN1AT0MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpcGrNI4EB74ECgJxHLrxG9OZJwtmiWYOeuLlrAdxC8=;
 b=vkfdGwlgTx3KTLOjzcjzbjrFAJE4KK4Yb2TRsktV0T4BtlqhiWq32YCSHIXSt0aBxEvGyf93vPhDqduTtyF1NYD6ljuKeanjwm6PsD3IYuZW9KJTxK6cLlFEiOdCqB+7Z7DlvrJT7NtuVg41twkFuOk2gdJqnToYdDICzaJIY4w=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Sun, 25 Aug 2024 03:45:58 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%5]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 03:45:58 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/swsmu: always force a state reprogram on init
Thread-Topic: [PATCH] drm/amdgpu/swsmu: always force a state reprogram on init
Thread-Index: AQHa9YyUlXyBM+3bTEiU7qktRyFt3LI3V3Mw
Date: Sun, 25 Aug 2024 03:45:58 +0000
Message-ID: <DM4PR12MB516512A88810C503AEA568248E8A2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240823184443.2032149-1-alexander.deucher@amd.com>
In-Reply-To: <20240823184443.2032149-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7ba6a500-25f2-45fe-b4f7-36783f953a6c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-25T03:45:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DS0PR12MB7898:EE_
x-ms-office365-filtering-correlation-id: 848981a4-3cb1-45fd-f96e-08dcc4b86e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0ZkDGiTTURsRr7db92BUPmvgiOuf5ii12W/WL4eiQDnE1NadO7qN21nFnToQ?=
 =?us-ascii?Q?eztb/wy7BeYGqr5paUzAn7kFY/U/kUexQyMrADQYRpv8RmHpZqlviFLAl0/u?=
 =?us-ascii?Q?MBbdeBWe+t+gUap7vC41n/+NjksdiAazvsRCGSjioqM73eUv5GTdWb3GS/Og?=
 =?us-ascii?Q?XhDPHZvojhKCGquAZi0LwD71Fyr97wtImQz2hxyTbOfB2Wp8iH04ZF+UOm4o?=
 =?us-ascii?Q?FfHvKlrRXX+3Koaz2SYOKFk0Ci40BJ8R7zGRsZ5rluvBrpnXt1Od02R44CRJ?=
 =?us-ascii?Q?rr1YoYmrFbTD60lxTIt7kMgzOO4Qj0YaK8gl4RKPq2iIomQ/P3jlAPSncPK6?=
 =?us-ascii?Q?p628vyWGrqqODAx2d+dAN0v/ijfT9sYQCslO2pObqd0WYNn483zkXBFCamKy?=
 =?us-ascii?Q?u1oot9W4Yi3L9wjOPdY3VRyJ76b+xRIFHCI/CtPo0cNe+9rj9YMjaXEzO217?=
 =?us-ascii?Q?JrSn2t6tQMrBv6YOutZfIXAOzRbWL5zL/IIRVgv6zGvwGT1y3G6RFEmhVcBp?=
 =?us-ascii?Q?5yt1VUckbYVkEnTmfSylPxRRP9jUhXEvmDWPvf6n4pEIrTTpUr/u+ZkB5DuB?=
 =?us-ascii?Q?o8BMWSsTRyfNtN73ivRhuwDTodv0QW/frz2DSG1cAWBcM2GItyIrIQrP/M4I?=
 =?us-ascii?Q?Yt9lDKR9pzq908VIyxTU4JPUw8qhVHPLGBdY/HG99UYN4xxrMC0ou3IrVipv?=
 =?us-ascii?Q?MH5neXAp5JQQIvqL0ELh1dqlOEDKtMOSvLOVNwXIgbeTXS2EB97N8Lw7MHaU?=
 =?us-ascii?Q?RPEW8J0x0+BR/meyb6LHajkdcWeJViAsB0n4XyjTM6o/CdwPKp9bf5ciYRYn?=
 =?us-ascii?Q?kmcevsUM208R0pKwIlOP+sOcyNA9ZAOpPKEsulsOc4q+yTe5iCvcyk4bVC3r?=
 =?us-ascii?Q?Yg8GCzuFiiqxKRunKIGWp8ekiAtDfCvYLF2jL6c5Oip3bZ0G+O8q/mS5d5+A?=
 =?us-ascii?Q?W1+Uzl02C7PVOhnejjnt/P6Dc9Ho6rdrMyqQ59yneUVvmAweavLvBFCOfH4u?=
 =?us-ascii?Q?7HtsOjk2xM9XWjXGESV0H4tbkzpS0NiFKAmM9JmjCFzTWU2XUqYPC48NsXw1?=
 =?us-ascii?Q?/psn7zzfSrV0roaTqvSKjYlJSyYQJTPog9WU/7l9pvBdfGjJZ+waBI5OVRFa?=
 =?us-ascii?Q?gwmDo08ietEQH3ao+ytn7ArX5H+dmVrgwTvds0kw4rNR/MLdipU+tPknDKuZ?=
 =?us-ascii?Q?YHen1nxtPCt2UAcis3Mr6+7AUAFbE47pXwBySJbV72nojx58Z+q+8kjUOVL4?=
 =?us-ascii?Q?3ycVQONRuLZ+UhL+I8Bz31O3fdMN4L8YN8jpihSZa9zSxFe6WzyLVh872BjE?=
 =?us-ascii?Q?alKSfpFZfV/Uw2EJl+ayiQFQMtSzV6XUgdyYHPCt37mVSQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWeD1PZVqepuejvsVEEmWK4WoXda01JbxZz1Ue7HVadalGskmUN3KQKi9ZgV?=
 =?us-ascii?Q?qbJLSi3j9AXlYjtvhHHbJiMA07WRKReYBJkTVrXihyr9ZbG8GX8Z0jmAZW9n?=
 =?us-ascii?Q?B1AQ87pPpok4JI2vAHISUt3qIR1v/xAZLKIzHPbtmzN9yyAlZFo34U2Cspdx?=
 =?us-ascii?Q?jJIVpDxgZQ3G/p3yIVIpBrkoEIvPDvIwS4E/4nKzikQv5E2FpQfXGK08cQ7x?=
 =?us-ascii?Q?mIHd7hRCojMle4ilKqyLwv889s6UUg1Yu+xkk47rudzCXOXaXD/TPcjMfMP+?=
 =?us-ascii?Q?t2StFHGceNxRRM/Mtbf1sfmMJf4FosZqiLbqi435k/bFiLK1d/iejPofqANG?=
 =?us-ascii?Q?hEMLowz38Qgascl9mwwdvLVd8QmqnwQX3uJjqINkbrkBiCpKCxUAqBbhbIA7?=
 =?us-ascii?Q?IwJC7djigR3t3k1IeuFQ9wWr6d/1FKeLGgBRrACrnj/20FRSJ6Lhprw+obd3?=
 =?us-ascii?Q?bNqCK5UyJrqJOYDBAiwCvot2ONgLvxA+1NdQGQjO+yTg+2/4NV+REJ08b/eh?=
 =?us-ascii?Q?wh+2BcyvGYCxfE/HlFgIkkErYGvat0+QD6DxHl6ddyGX8bE1dO7FvBpao2VX?=
 =?us-ascii?Q?Fy/UqZTvGUEnbu6ZcPI7qcxKhBuSVUGpY6ba1cJBNd/AYMN0RFf5cxCFH8HY?=
 =?us-ascii?Q?8ifjTZnEcPQsrHwmyvrYSkqkZmcK+ShZbfPgIwxRmZBtdoB0zMu+Ax2g1VrK?=
 =?us-ascii?Q?ojhNV+VvTE891my6VIEYwihoxyMbDE2X0c/8CzkrZYfpi1pSPo9sJf+EN50U?=
 =?us-ascii?Q?Rd/qZvTTMoMggisS+xfF/9RljaGFPtHV3ZLqxcWWcuJsSZbSwhmO9uUBi/Pp?=
 =?us-ascii?Q?pSFLzVH52K4sqvh/pNiZurI8pFkZ/zFLpXmvtJ3P4ZH5U8GDaGT2J9bSwdmu?=
 =?us-ascii?Q?J2VfVmXl9/H2nDnbPJvJ8XsFkhyzF0r5B6c3N2QzLCdfIraXrrI1YLraMhVT?=
 =?us-ascii?Q?irb7VuxS03ORG8nYKUkIBm0FtFQ0UZx1FWOE02eA9/TmVKeU9LuxhV+Wb4Um?=
 =?us-ascii?Q?ZOhAwyXUDo6r5auoqwGXn/GKP2dEjsdPGMwwvSj7an4cwNn02ra41HPTW+YI?=
 =?us-ascii?Q?8GWcjCUKls6yO1OxeLKHwyen4EA4PCfRE5QtSl7cUDl+x3W/UdRltrurO+Tg?=
 =?us-ascii?Q?h5xyyiVaiofHMWMPX/eETreKYS3afVIfVMBKQB6rXnjQGiuyP0zlJYOLHhK4?=
 =?us-ascii?Q?ToyNktrRGZ/SSN0sZT1b/9bqdU4+3YAXzXsHP1uAPA6J61PBUM8DtN7WDf0D?=
 =?us-ascii?Q?qzsEjtILTbJbuJwR75S8l5CYJTjypIgPpi3FuJl5igzMbrdH70jiMWnFS9rT?=
 =?us-ascii?Q?by5pPv6uJ8FiBPmCdXuQn87Azx9+gLQHh4QiWBUkKhSSVLDoHAwdBQP0tiLl?=
 =?us-ascii?Q?K0HDiptI929joNQ058gEy+UzpRZ52lFQV1Q1lrjENw7284CzykA55+uOeZWz?=
 =?us-ascii?Q?FSZUSgX8DG+r3MDPc47SZSj6zNFueyz2Zm2grnez4ou2rhA7Nc4aPniVgRi4?=
 =?us-ascii?Q?bhO+YsnXvR5r69PhDhZBZt2aEW9dJQ8U8fJvlj65o+7carQLwm2AlNktwuA1?=
 =?us-ascii?Q?m8nQWoETknUajdHfTKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848981a4-3cb1-45fd-f96e-08dcc4b86e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2024 03:45:58.2722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGH2yKyJkPlL9ZfHSy+cU6o7rByXi+7K10CrlR/WdrOX5eJXQ1Z6YgJzaWU/PGbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, August 24, 2024 2:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/swsmu: always force a state reprogram on init

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Always reprogram the hardware state on init.  This ensures the PMFW state i=
s explicitly programmed and we are not relying on the default PMFW state.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 12d30af431fe..c1cd785b4aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2224,8 +2224,9 @@ static int smu_bump_power_profile_mode(struct smu_con=
text *smu,  }

 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
-                                  enum amd_dpm_forced_level level,
-                                  bool skip_display_settings)
+                                         enum amd_dpm_forced_level level,
+                                         bool skip_display_settings,
+                                         bool force_update)
 {
        int ret =3D 0;
        int index =3D 0;
@@ -2254,7 +2255,7 @@ static int smu_adjust_power_state_dynamic(struct smu_=
context *smu,
                }
        }

-       if (smu_dpm_ctx->dpm_level !=3D level) {
+       if (force_update || smu_dpm_ctx->dpm_level !=3D level) {
                ret =3D smu_asic_set_performance_level(smu, level);
                if (ret) {
                        dev_err(smu->adev->dev, "Failed to set performance =
level!"); @@ -2270,7 +2271,7 @@ static int smu_adjust_power_state_dynamic(s=
truct smu_context *smu,
                index =3D index > 0 && index <=3D WORKLOAD_POLICY_MAX ? ind=
ex - 1 : 0;
                workload[0] =3D smu->workload_setting[index];

-               if (smu->power_profile_mode !=3D workload[0])
+               if (force_update || smu->power_profile_mode !=3D
+ workload[0])
                        smu_bump_power_profile_mode(smu, workload, 0);
        }

@@ -2291,11 +2292,13 @@ static int smu_handle_task(struct smu_context *smu,
                ret =3D smu_pre_display_config_changed(smu);
                if (ret)
                        return ret;
-               ret =3D smu_adjust_power_state_dynamic(smu, level, false);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, false,
+ false);
                break;
        case AMD_PP_TASK_COMPLETE_INIT:
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true, tr=
ue);
+               break;
        case AMD_PP_TASK_READJUST_POWER_STATE:
-               ret =3D smu_adjust_power_state_dynamic(smu, level, true);
+               ret =3D smu_adjust_power_state_dynamic(smu, level, true,
+ false);
                break;
        default:
                break;
--
2.46.0

