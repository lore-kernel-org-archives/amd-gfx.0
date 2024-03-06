Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBDBC54E58
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 03:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B383112E4D;
	Wed,  6 Mar 2024 03:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4/tLpmv0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40152112E4D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 03:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4QLfCyjVrixsSheD8wPP6ruoeoud8VfUph3JCdrP+KXZkVYW354TYJVxe0/pSRHwaRnhhYIRPDi3b+MByOAo8nS+FDFbbccCWcSQZmai5XR6t1d2qCF+SI7j51Ca2d2lQeaB3sqkBrbBodg1Doj0kSXr5HgS2fHxhBfsGXCg8j5ygqFk0N4hQ0KMKHbIHByRjkzXzkOD9MQDX9fdwI29ld4ewOq9DUelR/5k5GuNZKi+0GR2GXlAAWhKZLrOnoHRg6kJMXC74Bpo6jpr5DixowJsXHBQ+jQedAZ1aF7TIdT0/UgKPIqSvL12N5zPLPbWJLRXNAFrxBr1I4WaLqshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6Wm0Q7qf5ivz+ApHSn/gW+jlQbM0Aq8/YJirHHZAkU=;
 b=Hycv1uQwsEwhG9J/yLVQpXZXM1RMHM7tDgvv+GVwe4qaXdIrPpnQHqJXefmwQQ9peJgPFFoNEVWKMMxjmoNI4TccJWQBy8qD4L0zge7o9q2+a8F+3+GYaUwT1YVCHkYfB6KZjqmke+IEz7aQEkrmk9Zt4XHmZei6T88PZBJ71PF3rrVoQmZ0z11m2DGuFoOWrIgOqEf41FGSoBmWu47RQAe0i2ty9QkLO9SXtLkhzg59sOHvpA18xbyURVU+5VREiwe9GmoZT9a1+t7/ZKnAaYbYOIPSo60kaMmbN4QbPvBZz9NT678DHW+XYS4VpQV0GnF9SXIw5JthSyEFEgbSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6Wm0Q7qf5ivz+ApHSn/gW+jlQbM0Aq8/YJirHHZAkU=;
 b=4/tLpmv0b0CpDgQjUJOsucTZsRqOt0Z2ovqcc9/o5A5UuwX7fxpioGt+mlYmS4vuL0UhsksOz4L9muW95dbfwj8nuCXmF2eARcuo5uDjkB9gO7+jx6qlFWgIj/6x17quIeB67DPkamE5Q23oHQQI/VN99T8PKXmI+ugN1Wr+ScQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6615.namprd12.prod.outlook.com (2603:10b6:8:8d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.39; Wed, 6 Mar 2024 03:08:48 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::a1c6:58af:2578:8ff6]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::a1c6:58af:2578:8ff6%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 03:08:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support
Thread-Topic: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support
Thread-Index: AQHabxFTHO+ivYT3/ECuCwiyenTbPrEqCL6w
Date: Wed, 6 Mar 2024 03:08:47 +0000
Message-ID: <PH7PR12MB59975AA2DFDF97410C91CB9682212@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240305152446.1268829-1-alexander.deucher@amd.com>
In-Reply-To: <20240305152446.1268829-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4feeb0b9-3cea-4509-8014-c5be18aa0a65;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-06T03:07:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6615:EE_
x-ms-office365-filtering-correlation-id: 2b3c1f49-8c5e-4b68-4a57-08dc3d8abd62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHx0jmYj4oeDwdr3q9L413iWghbqn42Sc7qT4h7JlCzdvdrWDDOtCmDeVrxsmBU3dV2sZuCtw/1Z7tz+GqbUXXdmMwAnXOpe8hJhteYNPbgy0DmnXkcvDr/17Ykt7AMDT/7yWafOO9Z0CoWvCDUi3LOBicXwoo9b+7GECaB3iLliOq+Ibwqy38eMJIQWjXaRMyUBx61D8nTi7L1992z+wnbJgVZrmR+8pD7UOHrJiVpUdckGS82oqghTpOIOpJhMvabgNUApI/xFVBh9aXxK+ST1rBG1Ofckt3c/kyy/LYfA9Ux3vm5c3eNIVjI5lGKQBkrnJVgDpN9SB+z5Funv9djQf66SMlsPFx/OrFSGVbBYTUQSxpCBP0WqqJqsEq8ai9QY8J2/qFXm3k+N5p2MIV9kc7YjSoBw9FJ3aR6znV9fe4Cks2zKBJB4CORwk814EdAowmjXP9U98vRxD2Ej9HdR+ioQk1X1gZu9Gq2HgRl414dPELebTTMgMxN/SZW2TTXxvrFJVsNWFD3fpwYB2G/8ykNBIscuPkFtxltJgMzvNyQAj7wQ6Bp98b5kmB/NAwx3EzLcFczDJ8P/ylENwr0yo3w/A8/R3+FNabntOH7dLTZlX2UUozl7Wk+k4Wjzsh2RIeqcbRcdoRaXsFnoc0uuvFEHR00Dzt1IerSw8191BSPwRn1fUSiQr4TxYOoVTRMpc4ylm6jcRZ5PhL/k4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/f9aqVKF3kvCfnV8DsA9OoP2sMUr6jJtd6cDgGVsr2H2/zvkHh3BOogNJ7dg?=
 =?us-ascii?Q?nDY6u1L4315pKG7kG41zY1f+XjHKfMtbvnwn1K6CsfpkeBXa9dqoGDZgosdC?=
 =?us-ascii?Q?RsdNS+lb/5EJHI+plUCd+gSD+XOxCNZJADctFpr5zfvrG7aPK79JuLQQISFq?=
 =?us-ascii?Q?IjcXxs4WwlBLY5xzi5gMHNGDqcvtb3F+VjiKMYQjcCFJDm9/CHR7NeWbl8CI?=
 =?us-ascii?Q?bLVKlhOVfBJE9wQUDHxZ3wy/4u38in4c/4zeJTIWmPIs7/ymcfOsYhKYLWkn?=
 =?us-ascii?Q?9wyty+6fnjjJhF8ml2TkleW5QK8nWzHS4z1qk39+wS4IgxQrcEygqkwzBgYg?=
 =?us-ascii?Q?E/6OdF9yuqeik/FQWCpSlTysWBrK17ceF0F3QuxmmLoi2RMx9rjSCee1JKST?=
 =?us-ascii?Q?2zAzaSDPTTvNo2AdpUOODsg5C9/lKx4UOzbHNOaGnS59jAel2QLrREYzKdit?=
 =?us-ascii?Q?iXJtRW18dupPYLpycFAJJ1KFi6wSg40f7lU58msDkNinuNqsKx899gSFjLeQ?=
 =?us-ascii?Q?TAGIgrdRsZINJfow2jOoG+GyiIRYi4Db/7an2BO/zi14RG3Nt834epAc2WQJ?=
 =?us-ascii?Q?s3gshNhbeW11SQwyu+f9OPt5XKF0kkWDZTK87ECjxx0hFn0G2133U95SEj3D?=
 =?us-ascii?Q?E3PT/ChqLuIDgzZCBnJvlQgiJFwdK/0el+cvJyiOdAeYDThIwhpPDoWL/S0Q?=
 =?us-ascii?Q?ZaGCOKu8PHmA7iauSt8UUSHD7z6gDDwNB+Y0kmChUwqbVpbRF+YKXVHBWbcG?=
 =?us-ascii?Q?6MN6Z/f1+DiJTiAvYVIuYaOhpGpCQdv9CBA+RkrPA44Z+NpOYm1Vptmi3nXP?=
 =?us-ascii?Q?QTA61ZLldpvNZk9Y15JZiHbneDBvHI2y8xTIabUdpWTpg6cbLJOtD6lq0m49?=
 =?us-ascii?Q?wPKqGay+3K60VQhAcIGprZ69+j2cz8yY9qDwEDpF34xfIQZypE3aXM5VB5KD?=
 =?us-ascii?Q?iCX2ptOu4Jg1CjeNIY+ZiI5ivD3FAbWr+H8mWwnhhIuYYNXrD3TreYCBXU90?=
 =?us-ascii?Q?ajJN4dxk7dXsFRw0FdSKQaKg5eX2nfEDFDrjqBy25jqHoBfeDW76/vB1Q9EA?=
 =?us-ascii?Q?npL4jdvNRNhdTC73714zgVdkcmzfV9pf2o3jaywDOTJKKoE7ZfhBdGYBs0Ph?=
 =?us-ascii?Q?PEtPrZ0x/KxuQ6J1hLL5Ny3HOADaF7vPCDLD1p+hSFuvtX/Kc65XjCfa0MSV?=
 =?us-ascii?Q?k9yjCdaZ99BeJ6tSXfkHL1XWM51Mb0Vc7yFofXsXvk2FXglnhVkTnrTvpSyi?=
 =?us-ascii?Q?cnRJmlP6OpiWy0AV5EIGXXBv+3pujcrPsrjM9KpMOTxb/YhLDajjTEqtfKYO?=
 =?us-ascii?Q?NdvPBCXDn/wc3dZk+1ZB2nqqhNflPu3In5xitwM2epASOKT2BMqCcqRS452r?=
 =?us-ascii?Q?fIQMD5ji32Bz0p/dEr9/WQ/dYaY3opGakzRiAHZUBH0eU1gZForUhWQRD2e9?=
 =?us-ascii?Q?G5SLW45wRoWDEC1TYkxosOnYKaxSvRFbua0hx6vzre7hHs8Bbw3A/OaRcdIK?=
 =?us-ascii?Q?voi4w3Qx3fdBP0Fsei/OgzwhJTTxEK6ahN3FDauwnmt75QrWJawd33biQsRe?=
 =?us-ascii?Q?DpidmxpuftdXvChyR9o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3c1f49-8c5e-4b68-4a57-08dc3d8abd62
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 03:08:47.1546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VC0RSm1xAd/jyX9vzREk0m1CnqmSIqtTlyp6ex77HpAiCP3t+pz6K5g9+cjGtiSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6615
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, March 5, 2024 11:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add smu 14.0.1 support

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch to add smu 14.0.1 support.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index eedb9a4f7e2d6..246b211b1e85f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -712,6 +712,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
                smu_v13_0_7_set_ppt_funcs(smu);
                break;
        case IP_VERSION(14, 0, 0):
+       case IP_VERSION(14, 0, 1):
                smu_v14_0_0_set_ppt_funcs(smu);
                break;
        default:
@@ -1895,6 +1896,7 @@ static int smu_disable_dpms(struct smu_context *smu)
                case IP_VERSION(13, 0, 4):
                case IP_VERSION(13, 0, 11):
                case IP_VERSION(14, 0, 0):
+               case IP_VERSION(14, 0, 1):
                        return 0;
                default:
                        break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7ac9bc0df8fd7..a65c618c2f98e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -231,6 +231,10 @@ int smu_v14_0_check_fw_version(struct smu_context *smu=
)
        case IP_VERSION(14, 0, 0):
                smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_0;
                break;
+       case IP_VERSION(14, 0, 1):
+               smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_=
V14_0_0;
+               break;
[kevin]:

There is a typo or share the same version with 14.0.0 ?

Best Regards,
Kevin
+
        default:
                dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
                        amdgpu_ip_version(adev, MP1_HWIP, 0)); @@ -734,6 +7=
38,7 @@ int smu_v14_0_gfx_off_control(struct smu_context *smu, bool enable)
        switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
        case IP_VERSION(14, 0, 2):
        case IP_VERSION(14, 0, 0):
+       case IP_VERSION(14, 0, 1):
                if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                        return 0;
                if (enable)
--
2.44.0

