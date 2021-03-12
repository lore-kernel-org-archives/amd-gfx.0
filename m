Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 04:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77AB64F93
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 04:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77AB64F93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A006F411;
	Fri, 12 Mar 2021 04:28:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2A76F411
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 04:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnnJ5FeDuaFMNyfUc/pUFQ790K9fcxka9okSTDvwx3P6QhMP9TBkzOdaCa1f/qiVT86zRPoFUtmcpdIcdDLSvzsL81DX22caxSwmaZmXOIAU+JqpAriLL8pbKnHDWmpUssIpnI1/rhC84VWUmv245hOLPyOZQHyHwEafCTv9/pG9Mdy5E55K+ycl3mi5YGRM+MvL5GkCKHfpeiQqwDw2FoR9+gmPR2trRvWDyhLWwqOYNSLpQbgEz7AQUcdosizQV0ysadRzkKekF5k55kYXbKEivy21kZOXxBPc7onqOv2ePIz4do/tvwHo5NSQ/x6Rx2/T8m194U3BnTfaQSdS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIb+yWyEBzxENI90wCfzR2jv+Qk7t3tRumgvVRpT6pE=;
 b=QmMhMWKvb+KQ+jCf+5dhikR0Cz2ePRFc7AX8EfUxqA7YUfdmpcB8nrnbwcMKwMXleX1x5lrxX4kW3E+v2N72cxwf88L0jQz5h/CWIieWgd/gnGzEl7o5J+lsRgDiei8Ds2kOz6QiP/5iSHKD5AKdmoUrems4BgUsIY/RB2vclwJAutLw6udDIelq1di5wvfst5NEvprMhdXiwiyHlFKvrD5jZ2Idbx0SW6ftZHB/66Fe2y+3+k5X3O+b2gbX96gaEKcguMH66MqWrO1ppHowRvSW+w4pKjKQhDy/OZ48u/EjXEjignysBvGSpRb0rq9cGCTsIQILHnrmJ95bljol/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIb+yWyEBzxENI90wCfzR2jv+Qk7t3tRumgvVRpT6pE=;
 b=0+M39l4lv4ntTyFKpe2Uq3Aql5D1XqF6bJJutdD+J208UpcMlb1oAsS5szVorsWXbeijUMLQyzxyAz/+yhfimM59xo/6+G7W11SGXEJ/lIsXWYbWH2V2XOkxQq5atrcMyHoQbF64Kuk6zAJwwr8uLWZN9f9o8DB6BotJZQYgQHc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.30; Fri, 12 Mar 2021 04:28:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Fri, 12 Mar 2021
 04:28:49 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/pm: workaround for audio noise issue
Thread-Topic: [PATCH v2] drm/amd/pm: workaround for audio noise issue
Thread-Index: AQHXFkPb9KlCKBvgVECEQKWZAwlr6qp/w74Q
Date: Fri, 12 Mar 2021 04:28:49 +0000
Message-ID: <DM6PR12MB261904F679A979B2227E1C7EE46F9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210311065840.12080-1-kenneth.feng@amd.com>
In-Reply-To: <20210311065840.12080-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T04:28:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5afb48c4-0a9a-41d7-b922-d797b7b00226;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5140f366-09b0-4dee-2936-08d8e50f55c1
x-ms-traffictypediagnostic: DM6PR12MB4075:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4075AFA0473732C51342CCBEE46F9@DM6PR12MB4075.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FuuUxyziiHLMleCpxGiojTvB1M3IVvKeHm0cRok1Vb56KukQBraiFXtTyKEB3QGFrkVh4buoiwauBTHLsujsrEOESThPloNJrRQPag0Zd8a7O/R1fv9rl0jLGGEDkqHw4BbiVLuadVwToLw63+VEzlQf7AFW3zLXrYGrW9dWWoqyjMibELuw44hwejkjEgGYxPVtM9DwqU5gIeskI38Gr6fFfBVZsgNcBSKNhRjf5RkLJBMaBr2zGtGedKLQz1thpFnvR6FT60T9AKcbSMGPCPK/5s4gupVWLuNf/DuGqXNATu5etqlW0+GNwU906tq9FWC5ddXnDFjJFCcYbgtroUlv9X81EPPxzOxsA9i6BbJMkyYFLjsuFhFfwFKEDfQhr1GOcNEt9j6AH7rIDzc8aiQiGq4BSYjE2ivTn1VgoVixK/cY13XEqeMzXzHWq0J83b8WrExD3mbNcsQ+1U+LTeRClXqmRv0g420C3BrNd2TaZlA7O9S81vUUT12rPo203wa75Lx74xH18sjRJt3DZfRJx2z1I/zvP7qYCIiPUhVtZyRuZNsBYmx7bIKkYYyV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(55016002)(7696005)(5660300002)(26005)(53546011)(66946007)(76116006)(64756008)(66476007)(4326008)(45080400002)(66556008)(30864003)(9686003)(83380400001)(478600001)(6506007)(316002)(86362001)(8936002)(8676002)(2906002)(33656002)(186003)(52536014)(110136005)(71200400001)(966005)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EJaZdIn7nLoMaGyo5n0aty4i8nOYAdeYXu4RJKOQKLnWOMRnmSCuS70UDsFj?=
 =?us-ascii?Q?r3P2AdVE2GbupzBob4Cf9dfMWlks8ovvhP0qOdzNfpwUh6RaIMzkcOQfeNdZ?=
 =?us-ascii?Q?RU+pKdO/iaFy1Ee++/NDCN0uHXSy3dof4goZ//Tb6kIEeCMoa84n8uhMIvst?=
 =?us-ascii?Q?IYX9HY2og4UwLNgqT+Iyytf6Zkm9ncFYpp3f1zGPP7udqATFrvdkRzWPODFy?=
 =?us-ascii?Q?Nzj+VmZOGsxI/Uj4pmjaAeChjFKpPOsv+w+faqmEo0EvNY3Xe5K+UW7/ylh6?=
 =?us-ascii?Q?wPsOwv442arVRmrEBezGHbzlZD3VdTJs3K3CES7GlH3EDRUzKCwYSlefrt0X?=
 =?us-ascii?Q?FM7t90mWzikmS8yuusDsbC4VzDmmBXxR6OoXy8dwRzcOQ9EZFFjbFIcfoZL/?=
 =?us-ascii?Q?uHjkoaukzEklRL6VIDNIHc10c4+safx12I35e+B19Y5JUvPQpoSuqG4IROOO?=
 =?us-ascii?Q?9abYt2Be/caTy5bmUXvS2uYQkPMFeMb4aj7Ll3UA/O7ndcjBnTpvWUQrtD40?=
 =?us-ascii?Q?DIBUa4MQpw7RqCLk4ogQkk1FdbjaMegQlx3vmktAJ9cgJw5Tvcm34vCmchRw?=
 =?us-ascii?Q?vLrBqB+7IZfkiAo1kwe5ywQaZjzVEFTQV2w7ZubJ+zj8BrIuZBPy0f65Nk5W?=
 =?us-ascii?Q?0em6u0z3Q8I7ctbQaGeymw7O9pbZCZ49ZYXruKRnUTRRh0TXXWodcfhZDo/3?=
 =?us-ascii?Q?exeaCOSv7Q+TotNDVTRzRMOYCFJkEfVmGmmPI+zn03tjMVhUVo7z10jh7VUS?=
 =?us-ascii?Q?y5cKPk1ReBPpAut/kxujdqJ26It/Dzyu6dLbPEC+4s66N+soTidBl2ilCsMo?=
 =?us-ascii?Q?p0628WGw/ugD/YMUbeE3GZUm9ImhYkpg3O31ritSvJ53Ldsad+jKhK+CaU8F?=
 =?us-ascii?Q?3R4Wwyri/ZblcwW/cxINyW/dSD8GOpzqpSy5OLev9oN8033W7vgAOQoFq5kU?=
 =?us-ascii?Q?Z4vQUSb18+veF6f5Jk7JZHhI5zn0HPEVcMkHLzAW097S3UWnGiLAEYu9Kkou?=
 =?us-ascii?Q?KGIYBtCFeE90JwnpiiFaG9+sEqgHpQSbmNEaz1b9Kc6dvHIzzT1EfM9hVQUq?=
 =?us-ascii?Q?X6P9/+bDt9ib+3TUmV8j7o/crlnXWZExi2E0jdzv0H0d2XmRlMroZVDzXSs0?=
 =?us-ascii?Q?FDxY0GjdlUcjxNr3MhFshUb9ejb54K4uUF9dY+yXRrBgwV0PMXQMk/kGhgtE?=
 =?us-ascii?Q?xDNu2Oqx8lGHEtT5ydBSVynKAjxJA+xAP/c3NohM4tvODqa/91RgF4gWg+uP?=
 =?us-ascii?Q?b+ZVmRmP1q7ruUpYo/KpjiS0HbJObz35r0iuZA5+QIcmv1tbmMJmveHNEp1i?=
 =?us-ascii?Q?BUo0yfvl0Hy0SzvmdfOWPZWe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5140f366-09b0-4dee-2936-08d8e50f55c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 04:28:49.8208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gwpioplwD4BweIP0ROwm7XNF76nXcSqGifc3XDcC4X8vOcdC7xNqL2B+/7KqoS5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Thursday, March 11, 2021 2:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: workaround for audio noise issue

On some Intel platforms, audio noise can be detected due to
high pcie speed switch latency.
This patch leaverages ppfeaturemask to fix to the highest pcie
speed then disable pcie switching.

v2:
coding style fix

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 54 ++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 74 ++++++++++++++++---
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 24 ++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 25 +++++++
 4 files changed, 166 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a58f92249c53..54bbee310e57 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -587,6 +587,48 @@ static int smu7_force_switch_to_arbf0(struct pp_hwmgr *hwmgr)
 			tmp, MC_CG_ARB_FREQ_F0);
 }
 
+static uint16_t smu7_override_pcie_speed(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint16_t pcie_gen = 0;
+
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4 &&
+	    adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 &&
+		adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 &&
+		adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1 &&
+		adev->pm.pcie_gen_mask & CAIL_ASIC_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	return pcie_gen;
+}
+
+static uint16_t smu7_override_pcie_width(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	uint16_t pcie_width = 0;
+
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 16;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 12;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 8;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+
+	return pcie_width;
+}
+
 static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -683,6 +725,11 @@ static int smu7_setup_default_pcie_table(struct pp_hwmgr *hwmgr)
 					PP_Min_PCIEGen),
 			get_pcie_lane_support(data->pcie_lane_cap,
 					PP_Max_PCIELane));
+
+		if (data->pcie_dpm_key_disabled)
+			phm_setup_pcie_table_entry(&data->dpm_table.pcie_speed_table,
+				data->dpm_table.pcie_speed_table.count,
+				smu7_override_pcie_speed(hwmgr), smu7_override_pcie_width(hwmgr));
 	}
 	return 0;
 }
@@ -1248,6 +1295,13 @@ static int smu7_start_dpm(struct pp_hwmgr *hwmgr)
 						NULL)),
 				"Failed to enable pcie DPM during DPM Start Function!",
 				return -EINVAL);
+	} else {
+		PP_ASSERT_WITH_CODE(
+				(0 == smum_send_msg_to_smc(hwmgr,
+						PPSMC_MSG_PCIeDPM_Disable,
+						NULL)),
+				"Failed to disble pcie DPM during DPM Start Function!",
+				return -EINVAL);
 	}
 
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 408b35866704..f5a32654cde7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -54,6 +54,9 @@
 #include "smuio/smuio_9_0_offset.h"
 #include "smuio/smuio_9_0_sh_mask.h"
 
+#define smnPCIE_LC_SPEED_CNTL			0x11140290
+#define smnPCIE_LC_LINK_WIDTH_CNTL		0x11140288
+
 #define HBM_MEMORY_CHANNEL_WIDTH    128
 
 static const uint32_t channel_number[] = {1, 2, 0, 4, 0, 8, 0, 16, 2};
@@ -443,8 +446,7 @@ static void vega10_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	if (PP_CAP(PHM_PlatformCaps_VCEDPM))
 		data->smu_features[GNLD_DPM_VCE].supported = true;
 
-	if (!data->registry_data.pcie_dpm_key_disabled)
-		data->smu_features[GNLD_DPM_LINK].supported = true;
+	data->smu_features[GNLD_DPM_LINK].supported = true;
 
 	if (!data->registry_data.dcefclk_dpm_key_disabled)
 		data->smu_features[GNLD_DPM_DCEFCLK].supported = true;
@@ -1544,6 +1546,13 @@ static int vega10_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 			pp_table->PcieLaneCount[i] = pcie_width;
 	}
 
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+			pp_table->PcieLaneCount[i] = pcie_width;
+		}
+	}
+
 	return 0;
 }
 
@@ -2966,6 +2975,14 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 		}
 	}
 
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
+				false, data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap),
+		"Attempt to Disable Link DPM feature Failed!", return -EINVAL);
+		data->smu_features[GNLD_DPM_LINK].enabled = false;
+		data->smu_features[GNLD_DPM_LINK].supported = false;
+	}
+
 	return 0;
 }
 
@@ -4584,6 +4601,24 @@ static int vega10_set_ppfeature_status(struct pp_hwmgr *hwmgr, uint64_t new_ppfe
 	return 0;
 }
 
+static int vega10_get_current_pcie_link_width_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_LINK_WIDTH_CNTL) &
+		PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK)
+		>> PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT;
+}
+
+static int vega10_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	return (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+		PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+}
+
 static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, char *buf)
 {
@@ -4592,8 +4627,9 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
 	struct vega10_single_dpm_table *soc_table = &(data->dpm_table.soc_table);
 	struct vega10_single_dpm_table *dcef_table = &(data->dpm_table.dcef_table);
-	struct vega10_pcie_table *pcie_table = &(data->dpm_table.pcie_table);
 	struct vega10_odn_clock_voltage_dependency_table *podn_vdd_dep = NULL;
+	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
+	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 
 	int i, now, size = 0, count = 0;
 
@@ -4650,15 +4686,31 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 					"*" : "");
 		break;
 	case PP_PCIE:
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentLinkIndex, &now);
-
-		for (i = 0; i < pcie_table->count; i++)
-			size += sprintf(buf + size, "%d: %s %s\n", i,
-					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s, x1" :
-					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s, x16" :
-					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s, x16" : "",
-					(i == now) ? "*" : "");
+		current_gen_speed =
+			vega10_get_current_pcie_link_speed_level(hwmgr);
+		current_lane_width =
+			vega10_get_current_pcie_link_width_level(hwmgr);
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			gen_speed = pptable->PcieGenSpeed[i];
+			lane_width = pptable->PcieLaneCount[i];
+
+			size += sprintf(buf + size, "%d: %s %s %s\n", i,
+					(gen_speed == 0) ? "2.5GT/s," :
+					(gen_speed == 1) ? "5.0GT/s," :
+					(gen_speed == 2) ? "8.0GT/s," :
+					(gen_speed == 3) ? "16.0GT/s," : "",
+					(lane_width == 1) ? "x1" :
+					(lane_width == 2) ? "x2" :
+					(lane_width == 3) ? "x4" :
+					(lane_width == 4) ? "x8" :
+					(lane_width == 5) ? "x12" :
+					(lane_width == 6) ? "x16" : "",
+					(current_gen_speed == gen_speed) &&
+					(current_lane_width == lane_width) ?
+					"*" : "");
+		}
 		break;
+
 	case OD_SCLK:
 		if (hwmgr->od_enabled) {
 			size = sprintf(buf, "%s:\n", "OD_SCLK");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 196ac2a4d145..b6d7b7b224a9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -133,6 +133,7 @@ static void vega12_set_default_registry_data(struct pp_hwmgr *hwmgr)
 	data->registry_data.auto_wattman_debug = 0;
 	data->registry_data.auto_wattman_sample_period = 100;
 	data->registry_data.auto_wattman_threshold = 50;
+	data->registry_data.pcie_dpm_key_disabled = !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 }
 
 static int vega12_set_features_platform_caps(struct pp_hwmgr *hwmgr)
@@ -539,6 +540,29 @@ static int vega12_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 		pp_table->PcieLaneCount[i] = pcie_width_arg;
 	}
 
+	/* override to the highest if it's disabled from ppfeaturmask */
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			smu_pcie_arg = (i << 16) | (pcie_gen << 8) | pcie_width;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+			pp_table->PcieLaneCount[i] = pcie_width;
+		}
+		ret = vega12_enable_smc_features(hwmgr,
+				false,
+				data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap);
+		PP_ASSERT_WITH_CODE(!ret,
+				"Attempt to Disable DPM LINK Failed!",
+				return ret);
+		data->smu_features[GNLD_DPM_LINK].enabled = false;
+		data->smu_features[GNLD_DPM_LINK].supported = false;
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 78bbd4d666f2..213c9c6b4462 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -171,6 +171,7 @@ static void vega20_set_default_registry_data(struct pp_hwmgr *hwmgr)
 	data->registry_data.gfxoff_controlled_by_driver = 1;
 	data->gfxoff_allowed = false;
 	data->counter_gfxoff = 0;
+	data->registry_data.pcie_dpm_key_disabled = !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 }
 
 static int vega20_set_features_platform_caps(struct pp_hwmgr *hwmgr)
@@ -884,6 +885,30 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 		pp_table->PcieLaneCount[i] = pcie_width_arg;
 	}
 
+	/* override to the highest if it's disabled from ppfeaturmask */
+	if (data->registry_data.pcie_dpm_key_disabled) {
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			smu_pcie_arg = (i << 16) | (pcie_gen << 8) | pcie_width;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+			pp_table->PcieLaneCount[i] = pcie_width;
+		}
+		ret = vega20_enable_smc_features(hwmgr,
+				false,
+				data->smu_features[GNLD_DPM_LINK].smu_feature_bitmap);
+		PP_ASSERT_WITH_CODE(!ret,
+				"Attempt to Disable DPM LINK Failed!",
+				return ret);
+		data->smu_features[GNLD_DPM_LINK].enabled = false;
+		data->smu_features[GNLD_DPM_LINK].supported = false;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C204c73118a5c4e11cdc008d8e45afc13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510426734120914%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kGNZEQXos7IQwAgrhqwoVcBTUU0hBoCcRnkHM4Q0TT4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
