Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55722C3600C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 06:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4F10E5CE;
	Tue,  8 Apr 2025 06:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3ARMvFH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C620D10E5CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 06:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doNF7MZLEqB0QNGZ8c/RGQRJ/QII6y8xjKa9O4qop59hG2SjQ2COZZtSLwrSh4USxDQGiUUXTSF/EuxhtxNbxOFm1d756YU5pgpOLhLKeEweW0mOPC3djqernRnKGBoOc0CqnntJ29XU2c7aZ62ANND3GaZNJGTx4IuabI12fy2FbiO+4LXjPqU2ExnvG3sRhHy0idjA/lm5EccQJJ/hza7AfxbaOP7b2dl1zQafSviUXzEyNW0q6DjwuCpJXy7y6TIBEi8xlfRPAdVGFVdpuVBvIq9Qz/9wNSkY/p79ngL3rjljquxbHEjt32E3z/21YhwUvOvcU4AoV4t1IEopoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4IHpfWG2f5Ncrb4wLtLmnzIGmTSQFkffG/tkinF0Fc=;
 b=Wov0lIN4SDpi8GspTeGEMlkWQ3W3OPh7unW/z3gJswsdnhxQ8OiCyFDkWv33HQdxL5munLARQafFaHS/Vwr0oikTbFDEeCC9F3vRGVj3XtcKTTKN0no6hoEoZ5b94d2N1epIJSmxt+E+WvAFhtDVaPd3SKU7LDlZtoXrX9pFAgF1AQznsSNZKc8MT0ol/ASpK+9fEbEEFIHaA180izx2aRKrlRxj+rKmtrixP9h/J7doKKBLcu/0nGP2ur2c4/WNMxeDgdd0fIenHNKDDAQq2zbMSHIc/3ZXdwVLsT5KxC7C5TXMDg9bETNa/p1liPRbVhVE61Z0SrAhAlO2++JAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4IHpfWG2f5Ncrb4wLtLmnzIGmTSQFkffG/tkinF0Fc=;
 b=q3ARMvFHvl4JfFe6i8KjmJ/4J9YYf3aw32shfF2HMkfie9jI1MObR02M2uHkdr8Ap8kvAJ9+y1YzL8oGdrK5AF+z0HfMYGEaUw3aqptErozHJL7ZrohGUBSnQGYFuWA8BuW1fxg1ZEw2PZogpJNxi1PoOgx5m6zgOuTKwcis798=
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:33:01 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::20) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 06:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 06:33:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Apr
 2025 01:32:59 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 8 Apr 2025 01:32:52 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, <lijo.lazar@amd.com>, "Jesse.zhang@amd.com"
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v2 2/2] drm/amdgpu: Enable TMZ support for GC 11.0.0
Date: Tue, 8 Apr 2025 14:32:45 +0800
Message-ID: <20250408063245.2270202-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408063245.2270202-1-jesse.zhang@amd.com>
References: <20250408063245.2270202-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: d378716e-6a03-4061-155f-08dd76673569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6oS0q2cXes6/maIulUzQDeRk1e6a/8TpIsPev8tiAEb1luTkh/LS5IojG3C+?=
 =?us-ascii?Q?Qu6R4LuLBjdnG5G4PeSUkHXjA8puPm58ppsVe5lW05yWWhmBm3aJfv9kzrdo?=
 =?us-ascii?Q?bDqqw/tHq3hUPYeJkc8QnOOwcfwMEjTrg7D4Pgp/U/8DKqfOjSQin1t9jvVz?=
 =?us-ascii?Q?F9Fb5w8oc7wifhKvpFFhhaduEqbtp4FKWIKMsAFVMBxwE6xQFNoXarTt7aJo?=
 =?us-ascii?Q?ySXwyo4sNUVWEeTn9IAw8v4lUCjjmyfgoruJ6F2jtpA57SPr5SznNHddAC79?=
 =?us-ascii?Q?ShaVFWxlOwaFb2+vOYqM0ZV7Fw5aIh2xO3Z4i2Yq1M1aJ9dbJrwPQQo1mSSQ?=
 =?us-ascii?Q?PWvrbavvkAkmFy0WsrpBrRZu1+uaxPfpkhhoCtKnDrZ3u3B6gueAl4geItei?=
 =?us-ascii?Q?jTEO83SJ2BS2GuVfi8fNZ1EloUKjFz4eQhEb/uZFqX4n9XjbT9xwYeOlX8Ck?=
 =?us-ascii?Q?S5IfRz159PTNaK5BnEcmOIVR12UhCqEoB2q0DgWeIHUk7L/vVpoM/j98OyUJ?=
 =?us-ascii?Q?8oQWJXuteRY4vOQCmmhubvXD+1DMJoCYqRTFgrG8HdWA78q7ANvwoxvjfGQM?=
 =?us-ascii?Q?9I7QN1Ei9T6KCMIZ7h5GM+gvzz+CyIYDaiIDvPJnywba3wFbaBYJ3loEclPt?=
 =?us-ascii?Q?z+gYe2CK6Sr9JDWCg+P0J0QvGzWopqt2HvUC4NuGkoKAA0jojwra9tFftg85?=
 =?us-ascii?Q?5PjAzlzQmqt1YLPB2+XPTv+odHs9q3SQmwspB0UBfWI0JMe1kx12NQTr6hYl?=
 =?us-ascii?Q?b63P8MWKmg08zW5CRyT1PNQkg9sR5INKQwdPLQ3nI2p5FeMLhgZ2Lczk7m1R?=
 =?us-ascii?Q?DXbqPOTUMuSSbXU87keExSDWN4RIqmxP2rV8q6Ob6J9Le9M5YfmkDiiynSES?=
 =?us-ascii?Q?G6+7UKo6sGJTD5+Le38ebkChSaZukWPkf7ZQ1m5q6Yme9uPs405nlBhpSLJA?=
 =?us-ascii?Q?oQh3/DgoTYQIP613LF4XGUiaiAMZMfN3nY3juL4S4RM9G42l9X+S8h8JKGrJ?=
 =?us-ascii?Q?ZXHSmoZBD6ZtfrfJkmx/zF9yhOStpW9XxgGhNiaHVRuK5XjFVlCJfUz82FzT?=
 =?us-ascii?Q?q/xDS6r7heZZegZzQTh/wNYphkQPOAg0Ix71kbWA56zb5lItOdtzDHQtnbI8?=
 =?us-ascii?Q?XvyWcJnaIzW3KnQLMYxZL2GL9KK7nvkQQ3Cm2ohPw1OK6DrdVHQAVL+fstIo?=
 =?us-ascii?Q?4z7EHhBoVLQO9s4Av4oKfKaF5HtW+X5khDZFYN9W+EW/fJRcZRRZzBbr1wC2?=
 =?us-ascii?Q?2bmTFwgSfuuwqdU0qJaYTUKoCigpI6UI3KJbxpJam7VKAA+N3kgk6dd+Dmns?=
 =?us-ascii?Q?5rSVK9ZIRBjEwFJmoY8HbsThOcznAaRshUldQYFZtqwm5fXAIpWOVh2uv6HZ?=
 =?us-ascii?Q?kpktusO/5skQwx2RFrgcDV6MKVVBdLoZngSgnwuFmStBqwoC88YozRmxstxc?=
 =?us-ascii?Q?uuigkm7fgSoPRSTGLzUIiqjEHCi+BlRH946RNt29EilyeWngUoksxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:33:00.4704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d378716e-6a03-4061-155f-08dd76673569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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

Add GC11.0.0 to the list of GPU generations that support TMZ.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 464625282872..1eb9242436ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -843,6 +843,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(9, 3, 0):
 	/* GC 10.3.7 */
 	case IP_VERSION(10, 3, 7):
+	case IP_VERSION(11, 0, 0):
 	/* GC 11.0.1 */
 	case IP_VERSION(11, 0, 1):
 		if (amdgpu_tmz == 0) {
-- 
2.25.1

