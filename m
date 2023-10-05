Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD533E936F8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Oct 2023 03:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9D810E110;
	Thu,  5 Oct 2023 03:32:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9B4810E110
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Oct 2023 03:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcp0bqk2TbP5z8pD2qbxPrt+jDhUtSBWUYSiyzUfA68UOf+7c9OOpJVM8V2Gom/g0oC7bUmQwZYlZiv6fZAcks6CCFitKr5xGydK9y24w3D2ek9Z3uSOnv/JgqFbIVE2ylkdoRq4Alp2+bVSOy864NV5c9TaAUY23fFoEQypZyq/ByaYsu/IdPJpoGonSZk3gyM7pu0ck5H9iHCX6RQ2EuKVMUQy91w+8VpdvQnyCkaXdDrRqBkTTiLf0Apq5ccnOF88QMhAa7G86TZWg+VTyCxoar+pXjT73B4TqyQzYEh8TffHYkETJWgz5SIJ67ZPSWGL6hPCqCLLBzDJ3XjuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++Yq0SXEm2dmaXRM/9S3Bqd0Xqya3Wb9D39EuedVrZc=;
 b=ROVKfwLpDBK2sfD7xvDJujlxYjgMrjBXGvwVAQK/HOcoGSEAxZD4WamMRsHOs3d8yAKA/l+nZiZEAdVXkCBW6rJ7Q8Hu2RbOmdzUyJRy6NsuqdvVEgoHdR5C/pA2xIuf1NQwKf97FOPpqBLNO1+ZB/L+BptBRDbAeJWIcMhpGms7bTgJXy5H/kSHzX8SjjZslexOmhcfleLkovc+PPnlAB7Tq4JFvBbPYt3r6e84fOAGhMamdJ3+QTk1hXxAbswPbQqeQNSeQdPTY0bur1pCPXWXfu8wYPwv0Cvn8ppWlIHfz3wubUr9c97CblvWpVUt8z5Am8SCVGDMigYrEeeCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Yq0SXEm2dmaXRM/9S3Bqd0Xqya3Wb9D39EuedVrZc=;
 b=C98nXCmnQCsXH60m37sjpSG9lX4hrlfL3hzPf8t3rRPkVCEoZl+shIKMNuEafx9s+utU0WSNTrTLO/SftamPHxl19WkvTMPEll3S+raGOCG9tISUgCJmMRLuC3QrNmV8+zMg9KGL6gQluaRgRhtQ3tpXNsHEw888qpIZfv1D0MA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 03:32:08 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 03:32:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active (v2)
Thread-Topic: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active (v2)
Thread-Index: AQHZ9thIe/Qxdiefxk++tj5fDsmIMLA6iz6w
Date: Thu, 5 Oct 2023 03:32:08 +0000
Message-ID: <BN9PR12MB52571DA4201DF6772AE601C8FCCAA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231004153410.895387-1-alexander.deucher@amd.com>
In-Reply-To: <20231004153410.895387-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1d64daec-81a2-4339-85a5-b618c7713874;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-05T03:31:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8589:EE_
x-ms-office365-filtering-correlation-id: 0101ba72-7050-4a33-a6e8-08dbc553a73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /IL/oaoP8VU/WkV6mAHv5zkFQQFHnnwmBglCECJzSPyK9mDGf7p5mI6nlkG9SqPde/Nb5zXfbSi4l6BQcoqNHj/4I7f6ZpKJfVrBGy+J/f7Q1nKgzWDjWIV+EfrByOwAKLCbZlt7uMlwEGNyopsowhspktUByNNekPIWpYeneVz4F38SpmFsc44nsGjfHDUPL2NAS5Pj4zKqQmknxYxD1saWzoTZSe9BqZvBK5XE3+jR5gmP7FIfa4ceNZFULdKqXNxY4qkzKmSRKtnUIb2VvZDTq5Evt14UgZ96fsw0JWR7K19u+8UDfaWQeKd1xPVsE1oU5PV4cTz/mEUUchFNArYM25w76LsSePaHRJOsD+vr2gXhF+b5IaOYou+MsWaTQEF31Vrh0qBUYKX0MjN9O6ecScurzlbWTfqb/DYyD9L7wxGFJA+YGCBGvGITsjWZtHJzfGWN1bGtZUc81svp2ykmvNuzORnbBXet8U5cph2rAk2uWiUuCTdqv+29z/hTGoeHrw4hVXHRdNhlw8r8gSq7l1SfLh2kF2C8VZshwPw5TnFpOhv760DlaD4L4bWdnmyR9eQO/lPJhVFubVPkevPOe3+oQoa/oErRzeNsm/5Jtsa6eeYYixgIey7rLjei
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700005)(122000001)(38100700002)(55016003)(33656002)(2906002)(71200400001)(86362001)(7696005)(6506007)(5660300002)(53546011)(52536014)(26005)(478600001)(9686003)(66946007)(76116006)(64756008)(54906003)(66556008)(66446008)(66476007)(110136005)(316002)(41300700001)(8676002)(4326008)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d5GACZia27U3hblxLguN8UCIXDaRhnwiHrz1dDSiquI4/f4lcgFKOIGU0Wmz?=
 =?us-ascii?Q?mhXiNt7bKvRtGgAN2vPSLM0n7VL6u8XXPxs0oYb8kI8ym7wZgyYGgBGMAMDj?=
 =?us-ascii?Q?H1V2se8dshSYaGSEP7C20RqSZdWozSXR2fx+MAtzubYU0O2i+20dqd6alF49?=
 =?us-ascii?Q?OIuMFhKzFsdnzhNB7J4WiwpUU2VVITBA7Pq8XXOyLwl55fUq18Z+i2rNfycV?=
 =?us-ascii?Q?dfvY0u/Kw6T8uMa1JhD3bbDXSbO64WbNR2TfPR+bQc38tPxgIh12ltRHcrKn?=
 =?us-ascii?Q?Aw/wvfUiaXjQZ8/Pr9/FfZrgU5Mc9RYl5s6TWBTxkFA8BxfBsdNr/UOArsf5?=
 =?us-ascii?Q?bxT7nyGrJ3Fqw7gj01/BYHWEUdN5WzdrJDXPrxxxUCZ/V5vJ/sdlaX3YSA9/?=
 =?us-ascii?Q?ql78q2WzNsTrf2YbNhsOM3G8eavkCC3UiBgGEH4mhw2THjIpR75vMowEkjpg?=
 =?us-ascii?Q?R714ar7pSXd/UawebAfPnQlNdi+LzNEq1o0JLLPYN9umUzeSTT1RM9eDfIdH?=
 =?us-ascii?Q?n3F1IemsDMu4iWEfr7plnqfQv2CuRgay3NN8NjX7VIvUOBWePb53Mlg32pOC?=
 =?us-ascii?Q?Wf91Kr/t8K3Vv4xlSpr/QC2lWzQrmLkmXaHZuGTTLE+U+iBMMCxcy45Ngz40?=
 =?us-ascii?Q?a7RNzle5/K867QtRmQKqNMI5/NwpWh08XF8+jdlwmer0GC9hJO5sZiPA0j+T?=
 =?us-ascii?Q?PfKLwyCsaVpXBQNWcozRtn/y9XTtnQ2oa2qgI7y14GCVgZX7mTnkvV04J2mX?=
 =?us-ascii?Q?j2jt2opBiQ++hJBYLa4t3lFCDlIRTm/pUcF4/MMbTUu05M4wRBXIXl4ezrAI?=
 =?us-ascii?Q?ZUUSgTs/oNHf04WH+aikdtxiEDZ9b/ownS/xjiGIBYaKRTLvuVl3sScwbWYp?=
 =?us-ascii?Q?IWVpP+7BJqD9SA4V6p3Rp/9QGaJ4X7dTAoE/s72hY583j1wMbhbXYsqlScL9?=
 =?us-ascii?Q?SAQPqzcM9TngJU777L31NU6lup6lIlaGQUGfyFtKGwh0BzVxX0S5WI3XEPmt?=
 =?us-ascii?Q?eQl7J9m47bQARYpgPMg1ivTM/n0urPj11Txvf+wziTONcRJQGnnoRLD6037f?=
 =?us-ascii?Q?XIy+NCKDBdM/WFCtkcj+pIMoSI5Dm6XMI+SWT0iH98UOkFpzvZ4HWmoP41Qp?=
 =?us-ascii?Q?A7Tjf38cl8gd03lF29LaemBFP304iYU7UgcIXFpWIDWKz01ZiZ5ar1svr8vT?=
 =?us-ascii?Q?LEUSjhHp4DVtcqsZjDU2C1Esd5Lof1ssL5k+HiI3XsYNaZofuuLW8IZLLnf5?=
 =?us-ascii?Q?rWH6eFEqoO3xQ31NWxMnpgXwvzxazPTMKWRUDNukRYvTLYliHwedJYsQ0ieA?=
 =?us-ascii?Q?m5yNRUC3+hcGGhAzYQ9M8qycfY49y1e7re+NZEiyMNkQijXFDsrpBrJZw+wX?=
 =?us-ascii?Q?aB+8mIlUGMR2HTkEF2fdpD/7KvE2O3oIqDlJiXr3KxQ3NqvS8OrP9CBijCaM?=
 =?us-ascii?Q?iJSY0rfC44/5Qhk94c5gwt+ZOzzH850Nip5fH4PYhQzA4itvjC+ORwbYJnco?=
 =?us-ascii?Q?jV5bfRnrTiOCypuOHOcjPpqX+bQAp2k3p7WbwnlR1/xSng1WoLXK5THNjtY9?=
 =?us-ascii?Q?zVpAhCHO/wyD66iCcG8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0101ba72-7050-4a33-a6e8-08dbc553a73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 03:32:08.1294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pf6M+dwHbdMvU9Cgr60Pl9e5lbHZRv4UpJPD0nCe7hGw3fjHRF7kY5doFmDCgHv1seAJy0gI6axv+oSGMAmcDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, October 4, 2023 23:34
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Kun <Kun.Liu2@amd.=
com>
Subject: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is a=
ctive (v2)

From: Kun Liu <Kun.Liu2@amd.com>

When ROCm is active enable additional SMU 13.0.0 optimizations.
This reuses the unused powersave profile on PMFW.

v2: move to the swsmu code since we need both bits active in
    the workload mask.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 684b4e01fac2..83035fb1839a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2447,6 +2447,7 @@ static int smu_v13_0_0_set_power_profile_mode(struct =
smu_context *smu,
        DpmActivityMonitorCoeffInt_t *activity_monitor =3D
                &(activity_monitor_external.DpmActivityMonitorCoeffInt);
        int workload_type, ret =3D 0;
+       u32 workload_mask;

        smu->power_profile_mode =3D input[size];

@@ -2536,9 +2537,23 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,
        if (workload_type < 0)
                return -EINVAL;

+       workload_mask =3D 1 << workload_type;
+
+       /* Add optimizations for SMU13.0.0.  Reuse the power saving profile=
 */
+       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
+           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 0)) &&
+           ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
+            (smu->adev->pm.fw_version >=3D 0x004e7300))) {
+               workload_type =3D smu_cmn_to_asic_specific_index(smu,
+                                                              CMN2ASIC_MAP=
PING_WORKLOAD,
+                                                              PP_SMC_POWER=
_PROFILE_POWERSAVING);
+               if (workload_type >=3D 0)
+                       workload_mask |=3D 1 << workload_type;
+       }
+
        return smu_cmn_send_smc_msg_with_param(smu,
                                               SMU_MSG_SetWorkloadMask,
-                                              1 << workload_type,
+                                              workload_mask,
                                               NULL);
 }

--
2.41.0

