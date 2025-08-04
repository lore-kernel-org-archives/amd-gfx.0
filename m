Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF927C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 05:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05CF10E2A1;
	Mon,  4 Aug 2025 05:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="No20S114";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF05110E2A1
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 05:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCwzuW90aN199YZgH708bkYM7F4uY2xQ2nwEgEkEU6bwfvlFwhDTuJTI5znPWdc5uAyIc2TiJ/eiG8rv8Rx19s90gA7CI6l3zvpdxXON7hJZPveR0zIZKeveLmNRsmzwNRSeheuRZMfXKRFfqwCZx7BeVyV4ljRZKN2cmR1n3CgSXs0JJ52BnwAI3HR0+1QRhY5HNw2K4Ak7Cr1ColjmSetJobprn8iOI2CK5LvQ0ZDk8O70iNvs3/S7A8qmdscrEuRXfIZbkjtgkNDTfw+kLXkjz7uUCsYANH6nNgOW3PxZQFJptOV8EvSJqBPLhLOBUwJvJ03KVCWFCrqqycIXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3jjGEOsOumEwmv60gIsmM06+PWd7hUsb2NNNM61iW4=;
 b=xD+i42YUHLQv2oaa9KiHweozCGQL1gWIQLdz5Jlm5dVmbJPO7ClFHyTIUDfhf9EfbvU0yWHCadG6J6rGh7/v1mFhJypXZVszgXiFNy1kGzY3BwOz0hT9O7xqiWjP/aCTujVmGjYBdMtt9PGMAypx1z6TP2ntJCV+rBdJ5WZ9VlF6+2U0Xm5WrioVreR9InECj9261Lx8BSQWiZjkTUO83HWJAN1ujzGcN8mTpafMZhutLkkiM7ZHyWzvQ7OjCaSNXZACnfSMRPr4BEZcm8OCE5sFUfgELQ6exk3kVjtwvhvABtJ8eXo/K0qd6fjABSIQWSNpOR2SXbTTu7fAFU2uaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3jjGEOsOumEwmv60gIsmM06+PWd7hUsb2NNNM61iW4=;
 b=No20S1145/nFgPCnupW4x+4VHluF1oHX3Z//4he8sP5eDS+Bu1Pp2e8NI7iX7v0YDg1M8OYLENRVof7qKXAL6ST6Bt+xD2sRr7+0MChSrF92EwwTbVWakn8anSezb8wGluMs/D1SzxzNbGQhVuTxOex/d2vgOk+kuQe6RpFiT7Y=
Received: from CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 05:08:29 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::e6) by CH2PR17CA0025.outlook.office365.com
 (2603:10b6:610:53::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 05:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 05:08:28 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 00:08:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Make static table support conditional
Date: Mon, 4 Aug 2025 10:38:10 +0530
Message-ID: <20250804050810.1729100-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: b91fc70e-4066-4b5b-aa07-08ddd314f2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tzO+ccfjqnBRU2D+x//L0t868kdkGKoOCU1CVvcz4l939/t3TkJMBiL0zTY9?=
 =?us-ascii?Q?9rdhZwteIG11ec+kJ7/8wEDSUdUFfvNBrxcIpAiDOBUJ+e8NWWmnxhcbp5WG?=
 =?us-ascii?Q?LvbfwLLB0C6hk9wD3Cp8it8CE3MlmQEbx8s1coDKZbu4bm9E9DvUOMZiWofM?=
 =?us-ascii?Q?zxdXxQkrcb5gPTt06Wpg0jcBp1fysB5wzI0fIHWAL+SCtZZQ2UNfL/oIEh9D?=
 =?us-ascii?Q?fAXFBRtm0uCLa/kHy5Z9DL1kAXY0MEMYCXtsbyr8vQiWVchtaE/VQxlt8OS0?=
 =?us-ascii?Q?D2VfGKASscI/otGzGWUZB6i8My/rK07VW6LE/ekPVudt8vylHAhif7sdClA7?=
 =?us-ascii?Q?IqJecyj/sCGHmzZo3DpDa9GJY9tGRcbx3w2y247PWu65kZ014d2Pc5HWlYYI?=
 =?us-ascii?Q?Isjs1vVtPUtPNlC881Dptd+qFtzLmDT5Bq1t20IzaOiGL+f6p/H1bf8TuS6q?=
 =?us-ascii?Q?9JeipjV1M0PGTkUvKuc5080+vdgLmiE02w6axmIv7DImp1/4wx30nS+y60pv?=
 =?us-ascii?Q?ylYJABRU0cDuCdkFMQ3iDpV5V9Cx6HM1HHrN2QJX+CxupVmHJfjNbgQanmRH?=
 =?us-ascii?Q?RbPsH/q5RyI3s2is+oBTDcgVYZRpavXZ4aJg3CWRy32Y3ArR4+zDywqxuogB?=
 =?us-ascii?Q?iCnZvOVyKJJllvPZhQQ5Oo4+/GfCkR4Pc7GSq2Zu1odTF6/6kNakq1mFmWip?=
 =?us-ascii?Q?5J2f2wAPHEvQzuzDXLxJswfDUsSrTfRfA3oEsjfPClUIBByUAk57A+5AgZMS?=
 =?us-ascii?Q?5peONLyO5P3C/qBvZgIoPEmahf74caNFG9H4k33oCApK5Db1pX4NkXCBHY1+?=
 =?us-ascii?Q?c6bI6feu6KIDd+IVthLK16mGQN4DXTxcjDUCY6Vg6JNECb0iOyKpkzMkHHB+?=
 =?us-ascii?Q?+Y/sJ3dkEZZQO5B62h2zYJtRLhc9D16NPIYNnEYIXXD85/g4wifCCUAy9dwc?=
 =?us-ascii?Q?Od1Qn15C5VKR/c+wvTu/nY2HIrIK1HPG/twsXoSCiVolHQfBbcT9oMhQUZmx?=
 =?us-ascii?Q?dGs7EKpHfyJ5Zpq5YHTl3lvTVoAfJP3YrNgkbLNXewGkEU3remmuO+tO94xm?=
 =?us-ascii?Q?Sx7uRTHsc1YxPYVCyCY8HiwvJpdg2cUqrxTwCJfiXiA0hhQT+pA9yTQ2mA2V?=
 =?us-ascii?Q?n1p+hItC2ht4fUCRPfoHwnhzLz2L36bpJkDhn5FoynKxbyO+QNTgeQcci6m9?=
 =?us-ascii?Q?N+9Lc/htZivo1ioHUwNiqAAWW0G5ASNhGaYcQPR3OgIDRfOaB1XLBS92PXaD?=
 =?us-ascii?Q?dPIN5tjpQ31t80bQQUm4/t2ZlTLLCcT/O8M0JknQlV3uPdDPJfmPLZwLPKpQ?=
 =?us-ascii?Q?rWqLH6IIqp9fvii2BO/odG7XUghw4XHA+QssD4Rr/JF55UTxDowW2Dje8JFy?=
 =?us-ascii?Q?hksuFlyjF1+BFh9rgoDrky79Tw26CnBl9xJkdspUjqUAS8ABXblDPz0EeCzy?=
 =?us-ascii?Q?OjIh9fgLoAfwvxGeheqm02RnLsSDLA06Kn34EXgdq6qM1gXHdJJXZs2I20fC?=
 =?us-ascii?Q?YNLXFgR4/gk3cviPLQmwOh22AABWECGYbzqz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 05:08:28.3618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91fc70e-4066-4b5b-aa07-08ddd314f2e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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

Add PMFW version check for static table support on SMU v13.0.6 VFs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ad014b50c300..21cef59dbcce 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -402,14 +402,28 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
-		if ((pgm == 0 && fw_ver >= 0x00557F01) ||
-		    (pgm == 7 && fw_ver >= 0x7551000)) {
-			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
-			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+
+		if (amdgpu_sriov_vf(adev)) {
+			if ((pgm == 0 && fw_ver >= 0x00558000) ||
+			    (pgm == 7 && fw_ver >= 0x7551000)) {
+				smu_v13_0_6_cap_set(smu,
+						    SMU_CAP(STATIC_METRICS));
+				smu_v13_0_6_cap_set(smu,
+						    SMU_CAP(BOARD_VOLTAGE));
+				smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
+			}
+		} else {
+			if ((pgm == 0 && fw_ver >= 0x00557F01) ||
+			    (pgm == 7 && fw_ver >= 0x7551000)) {
+				smu_v13_0_6_cap_set(smu,
+						    SMU_CAP(STATIC_METRICS));
+				smu_v13_0_6_cap_set(smu,
+						    SMU_CAP(BOARD_VOLTAGE));
+			}
+			if ((pgm == 0 && fw_ver >= 0x00558000) ||
+			    (pgm == 7 && fw_ver >= 0x7551000))
+				smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 		}
-		if ((pgm == 0 && fw_ver >= 0x00558000) ||
-		    (pgm == 7 && fw_ver >= 0x7551000))
-			smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
-- 
2.49.0

