Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAF5C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:27:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD5810F014;
	Thu, 28 Mar 2024 03:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OUetLgMQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B86310F014
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ+2qgy4Nair8rq2F7tOpuX1SYAIeSOJKs/VuluiRLVIU4w1nhTvR1ncYBKTqBLDPiVmGNBba9Zt0LghO5VA2AqX9+u7VrJwOURhMxL3kqaTmCs1s9v/FVBvKDIV9anoyUepXHXE/01BSWHRpP3crqBV+Lowbr0xKuTZA73VzYoEeoAVOcIy65ulrfttR07YO8orY1oH0ax1PWMRSIDdRqdkfpbfDdN2akSFk1ZtxKu/WXXf/ABUVJ3AhefSanZnVJ5Moj7NlvFKAhe3yLyphH6vmbbJKw1ei57nyuOSeyqPikXeQRh+dv0HLoaec3eB7MoWxn88J+IaZnBuKmRSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e97YR8hNtTAL+mBya9GcumCqx8XVCon/3+XNAEdTvNE=;
 b=VSWvFgoEQ/TKbK7gFOrNyRv3xIStHDnxpI36KNlGNqNS1kkZc6foRA5Cs+m53UIx9lXLlFIkmIdThs7XreFpdxYqnMH3ybTgChP+XcFiQ8pj23nsy4rZ07ndOdtNtXMbzQZ/maNcdeJAOnOqi+c8aMgbJ3hwA508PgrDwa9HoqGMoSEqI/OfgXOAG1x+nZ59BKRMnquNq+RjRSSvy3mzQg8A7WqsAX4+Tkll/mfpcF0OrGgiTRzqBhJquG3tAeLUjf90qotXTzSy1JzpqLiMAD0wYR7YJ+Qf/ZIEtf1FmTfNv1qsNeT9WdNR9Eif12GdMVxfp0NT4HVXZsIujgRt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e97YR8hNtTAL+mBya9GcumCqx8XVCon/3+XNAEdTvNE=;
 b=OUetLgMQZQ9Ym+qHyLPfh0paCtz2l0tTzrG4wKx3iaLO38wpX33lqp3btzT9AjyFXm8gYDdcyDiR53e/ksaes7o4mXOHAgg5yS/FeC8CkXRcQ8HXmHBO/luhcn8zPIV63GK1PdcVDMY22I495qjowOVHdK4wStqliH3bktmPwPg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:27:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 03:27:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
Thread-Topic: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
Thread-Index: AQHagLi6H7okmbECjEmbQXHBwNj+urFMfTOw
Date: Thu, 28 Mar 2024 03:27:04 +0000
Message-ID: <PH7PR12MB599784C8DC7295A8D239B126823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
 <20240328023544.820248-2-lijo.lazar@amd.com>
In-Reply-To: <20240328023544.820248-2-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c48b6c68-c28e-43ce-bcce-10c70f7faa27;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-28T03:23:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN2PR12MB4045:EE_
x-ms-office365-filtering-correlation-id: e20c1ed3-871e-4098-71c4-08dc4ed6f06e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Y5ZhoxWPYweY9+7/ZBGL7tkK64EXNFNFF2ba8+0OANJQqeYx7RoEAM5WtIaak2KF9iSYxLLviMJlIl/tqsN0JVGWKFWvRS+PRHig/41JqWHfg88ykrvLy7etSq5+DXBL8YaUZnTkvKlCww6S4j0/CTBNyG/BNJ9u5x6eIXb4skg5wmgAPu/x3rE1EOI8YKMNVhzch3mMjwqVt8rGNMGlmRgSjDDZZvwrWnxyLPAONNvPqykKezpRYaptMwZjk88nrs03O5JavRO7Biri8PF41CNBVbtULGENIFYI5w/V2OxTHKyZiPVaHV9F54zs00szohzAJX/Puqr5nJD89PEPz67wZJYpUv7kKAUEc/pIRCvM7KhOLp82sgFzF+asKEV0S3Jz8EjEJklkQVeeuOIR05Y+5vvmoMyBhvvyUshwAmz5ARQSvyEIEat6I2VUJJu/v3yO9DIzkjkc9iIMU3qnLPJEpr0Zq3HZs4Z40YXsvFxFJhSXTHJeGYH1HJgo5lO/gVrCWTN7pdw3aX7RmGp4o59U1Cm5ncnSWlLSBp5BVo0ARRcgPX+cOJRevJk1LWzcykUKsSXUC4X23ZgSUY4UqN666Qc1krEdRkiPDmhsYo1tJliQWmPW1o3Lb4TsRvUQeWuEwGRPXpa79AKjYoyv+mu6OA6NEGE/xSV8M0GjIHf7h8YB+QJnD7vR53usLpqcBwMfsJKIY8A8DnDZxk5Zn56N+y83Mv7lK9jfsw5erI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D+c2v8+3DtxOC6ky+t/fM0EzPo8g3Q6HUXoGKzcWqA0tiOlxuSJ8TJKWk049?=
 =?us-ascii?Q?KhT+BmrdaZt5IxNpRtVSnPEa82i6+7Bp8k7kL92qz3XWtIR5qh4pYVTJ1Wze?=
 =?us-ascii?Q?sgpbKWNjWESi9d8UjtaKjNSW8/RSQoGasDheUWJcnV/jEujQZl6OUEswQHdp?=
 =?us-ascii?Q?rZ+oaMNZ+Oivle0SIJrxjQF/HHWKleAfAwXmFFz26re7wuIJ9oYZg2duIIBC?=
 =?us-ascii?Q?IUqG7ApT/vSQ0ZOTDDVvuTzYt3UKVuE7efD6+/X0FU281Y/+OpFd0QmHmngf?=
 =?us-ascii?Q?Z+EOK4O/ZpHfwPchzxbTUyQtHRPM3KF/GAONAvy/MyZUYf1IAPbvo3Dw5rhy?=
 =?us-ascii?Q?fUfEZfsczKyfRh39AKcAH9V8FdnSjCP1XkDQBtqEhWv9Fj4LJMuAUYDF/8V4?=
 =?us-ascii?Q?QHguidTA1SllxlhYzdfnwrKCMQ1LIr1RmUXLxgmK5h2eOcDJ2cZ6SETQ4+Qt?=
 =?us-ascii?Q?bUHMksrqe0BesbZY7kVTksad0i/Ikg1L8qqvhm2rR8SCL1wmL21elkZr27Wa?=
 =?us-ascii?Q?opGqXUR9ZtbIg+qseItHr8injnTlOWI9NP3s9oqSP85HJCv6xC6LKtXzc3bS?=
 =?us-ascii?Q?d3V0qg8Yqsv89D0kvdxaW4Il9tQDbgrKsP2//04lWoQFQrgqLg6jLS4QS9vL?=
 =?us-ascii?Q?N3yapPSVmz/kNapsYausSV4al3YGnpuXHtJOmyCi1Alag7lCN88UE+FTavCk?=
 =?us-ascii?Q?Vigye1o2ViL+Tzbh6U1xRVgegpfLQ+Aozo0f12uUNRfhuj5g3Bvc+jBZd4ld?=
 =?us-ascii?Q?NOrfIALcJ1ZSpYec0IPyWFtMY3TD3no0IbY2BeA9HoeDoyUnoSI6xCcmfcDV?=
 =?us-ascii?Q?L8YqXDC3xWm3obo64Lv5MUV5qZRsIpmLgmMJjMnjmrZS9VzJyFHk6ptisCGn?=
 =?us-ascii?Q?Q0mYw4jA3jmEBxYWnrwmLebrnn84djCxLNSGa8q59/3cDKqY8NDAdE3ihx31?=
 =?us-ascii?Q?rAajtFY7cl2nWOQ+O3aE0l5Iv0X/LTF1b/pB/AzURjE9gu1s1W2pqPZc852p?=
 =?us-ascii?Q?tljplzN3rP65dM19/EOpur1OJHl0s8DEvwSv7abIiseV8qVUOhiiKZLuT+rk?=
 =?us-ascii?Q?2BDQw9zvH3H7PQp8E+63NnAeMRUOr3JUbkHlmG9g6HSGd0VsPE2pLX9S/JUq?=
 =?us-ascii?Q?URSU4sgY0boq8SQdCpWvOcwo39aFry88v7WZlYZrzSFs23CIxTQu/YFqcTq4?=
 =?us-ascii?Q?Rnsy8opAYP9gK8RSnz9BK/yMDpLVMPs5ta+SmZUf11Rw6rwoIfO9vJBjAic2?=
 =?us-ascii?Q?6tN96zr6XhXm9GIG5Et3pA7uFGubb08ltylWVtgpSzvStPBQOEeum42YP9h4?=
 =?us-ascii?Q?N1oqbMEulAFrE4xtz9Ky8guHz6wKOipUlJ9x4RfY/yjQ5Nm0Lb3rGE86GHy2?=
 =?us-ascii?Q?Qqz2vdacf+qUhJzWdct7D9gHCD00mgcWd+12V+rEBDU8bGn2RaT+MqqRFyJu?=
 =?us-ascii?Q?BDQcs/vs/tH35L7CuwO6GM4z8R/aGa1HY8XCvG577wFAiRdbilyFL1oxZYyo?=
 =?us-ascii?Q?zRh3wSuHqJJUfGGhWPyd42FjNuOgc7LI93UzQn7zey4DcgT+yhZagBFocX0v?=
 =?us-ascii?Q?/P4lw4n0LnecOu7VE7c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20c1ed3-871e-4098-71c4-08dc4ed6f06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:27:04.3032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxpRcZYUw5EsdhftRfpOEm3DrWClhpRLxBgMOMDjFmqGnH08NaEWlkx4fuwsr6ck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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
Sent: Thursday, March 28, 2024 10:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags

Add flags to categorize messages and PMFW capabilities.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 ++-  drivers/gpu/drm/amd=
/pm/swsmu/inc/smu_types.h  | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..aa835df7ba1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -458,7 +458,7 @@ struct smu_umd_pstate_table {  struct cmn2asic_msg_mapp=
ing {
        int     valid_mapping;
        int     map_to;
-       int     valid_in_vf;
+       uint32_t flags;
 };

 struct cmn2asic_mapping {
@@ -538,6 +538,7 @@ struct smu_context {
        uint32_t smc_driver_if_version;
        uint32_t smc_fw_if_version;
        uint32_t smc_fw_version;
+       uint32_t smc_fw_caps;

        bool uploading_custom_pp_table;
        bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index af427cc7dbb8..c48214e3dc8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -445,4 +445,11 @@ enum smu_feature_mask {
        SMU_FEATURE_COUNT,
 };

+/* Message category flags */
+#define SMU_MSG_VF_FLAG                        (1U << 0)
+#define SMU_MSG_RAS_PRI                        (1U << 1)
+
+/* Firmware capability flags */
+#define SMU_FW_CAP_RAS_PRI             (1U << 0)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index b8dbd4e25348..3227e514e8ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -437,7 +437,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *=
smu,
                        return -EINVAL;

                if (amdgpu_sriov_vf(smu->adev) &&
-                   !msg_mapping.valid_in_vf)
+                   !(msg_mapping.flags & SMU_MSG_VF_FLAG))
                        return -EACCES;
[kevin]:

Is it possible to use smc_fw_caps uniformly to handle sriov cases (likes FE=
D/ras msg.flags) , which would look more reasonable?
+       smu->smc_fw_caps |=3D SMU_FW_CAP_VF ?

Best Regards,
Kevin

                return msg_mapping.map_to;
--
2.25.1

