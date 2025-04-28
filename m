Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AEBC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 05:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAB5810E371;
	Mon, 28 Apr 2025 05:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PDzdQA3A";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F96210E371
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 05:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u77JleKBv4f/SuSFttV69s1EWSBmBwEd1irHC4R9aqJmtO0yHCXo8DbBrTVWfSPqTe5tQJ6Bim6pIihnIidpWBRKVlih1AvP20UTLuGX+gqzEEuJpDRWK8AJAfuUTLz2/vya6LVG3FPLS9ppCA5LkUjP8FWzzMiQ7TZcJNJgiz3R/S33EsSPdaBJLSY4Y0pdXvfgBj7Q/cqb8Y4PbsaDH48kxPcUdqdxgGD3mdZrydW1+Y2CQWog1ruR1QElfDlVUQqdD+D80qjuAg+2iePlx2nI+lFr9cHm1xxqmJFxXBcry3/q4IfwWoWio2Kjmk6qL+XQBMkdKnXR52MovY4i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQxl18bWvL9QTxOeMqSRNGFUWuxGagQb6d7vRrcJn8M=;
 b=bkFPIwEUbJufzPCGf40f58ePj2jNxDSbjqT8QTbbWF9jaiU0MufJVl6IoTNUOjNMs8CttS1V3BvLW9kTi9OcETN868OUbhRwFqFrNr4NnrLiitHMigFyaCmFsuI9d/VBWnu7iymiXOhKYOY+K2bVtHIQuzwaD5tajcGFyzHVykEC7WaJcF1hhMB6Lwdq8L70UuMU8ulM2sX9pdMZLVfUT67Z8nHVNa+immYDHdhf7TPKmK1Ln6wai0vdAitrYQDbiTxb4RsnTFRSXMER6Px/Cd9AnfGu+bfq1lYI1Gjxwt0AHd1FUbRJ6IWfeXG499qKMLZHu+UycqZ3R+RhxAYi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQxl18bWvL9QTxOeMqSRNGFUWuxGagQb6d7vRrcJn8M=;
 b=PDzdQA3AaXdA5nz1yuBL6UC8pTDohgpyo2PIh6gAt0Ri0MMxqgDyy9CFY0gLQxPGSQP+41t4nyfj5CfdfC+AOzD+mdknDgcYHL6s5eUjd4P/FIxlU/rttdu1UteoR6Et69COUWaxXQ7dmfTf9IEaPRH3W/5Hu1GSZ/STmgKVFxk=
Received: from BYAPR07CA0063.namprd07.prod.outlook.com (2603:10b6:a03:60::40)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 05:08:18 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::45) by BYAPR07CA0063.outlook.office365.com
 (2603:10b6:a03:60::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 05:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 05:08:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 00:08:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Fix comment style
Date: Mon, 28 Apr 2025 10:37:59 +0530
Message-ID: <20250428050759.946910-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: fece48ef-927f-413a-768d-08dd8612b051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QzKrgc54ZrwGRCLP3UyaZRhUb9Mh0lU9e5JZUZjEWG9dnUfvZHOtXM5uXDMu?=
 =?us-ascii?Q?w3b1vzBpPTq2xcGQfpn64S68ljwvC2UTOF4zw6OOphCD++nW8Ja0/IZG9KXy?=
 =?us-ascii?Q?rno9y2VaMSCpjmVEjGUrmSwpF0KWLmMl9jjczm0l9LuB0nqURc1z8x5H7mlh?=
 =?us-ascii?Q?FrNFXUhXSBQU2x62q4tiPMmegDfmvxnlECwwi0//caNIzQR2Puw6yra8b9qX?=
 =?us-ascii?Q?9u+873Dneg5fAfnow+m3mFGlK5D9tnswW8K5xSWiS2JHZ1MVeT8+AgsLrJdt?=
 =?us-ascii?Q?lbm+YvihlF9omZCIoaADqZgTp3LoNas99e97SXTUoZFzuhV1DGQ1j/Kn9DNh?=
 =?us-ascii?Q?78b4FjHgegjB30qi6G4/HX8650HAejGyGFZK2txu/+mLdZfTUYDL6LlQft+o?=
 =?us-ascii?Q?iGPYir9mruXcSA+YiNn35f9rEUv60EdR+aVV+QyL0t1DBKi7Z4pXwRqcrm2B?=
 =?us-ascii?Q?saEGJeItqdB38d3u/4wX83aWFRyrtMPRZCod/AkjL6v3ne/TbXoKJnsdpeBX?=
 =?us-ascii?Q?HlhhJZTSssnH0n7yNU4HcLVsiFcEWAUqbmJGIjErTw+pWGsyav86L0gs6Eqm?=
 =?us-ascii?Q?++2uEexS7OJshtdW7ZoDq8O4/fajs8y3mlKxpduxaz3bUYu2eguRGoHQ/p0z?=
 =?us-ascii?Q?PfiiGv3sfhI+TmesHiQBoa/3PjQ+i0PqgN6orfKKiU6pItDgJhbk6VVn0Uoc?=
 =?us-ascii?Q?Tm8+ofbo0IW9K/xHZaP9w1gKx0HLp0Jv23hS+G4d8b3rxRLzmVy6ctV9rTGW?=
 =?us-ascii?Q?wk9NScyImare2yxLY7Pvx6zHl7ECX4i2ep6+eAv4fl5ptG7YcF1IIsNntn7X?=
 =?us-ascii?Q?zNWIYqV5CzDrlETe5dgt1w3uUOgaHAMWGCBt0/fXwbHamv62u8NPgFjykvLr?=
 =?us-ascii?Q?N51wRsp4xORv1H6somBsQc5Hp+PuYVRten3O6LMfWJtBSmCSx6Aw88Yb6ktp?=
 =?us-ascii?Q?cyJNBlJg8QL/eY+zROqmDKWB6D8+TY1dg6qpF40aIjIXkUrEPC6W1YvQ+tMD?=
 =?us-ascii?Q?+X6E9kPBc9/TUD6Fdb5Kv681G8lexS6O7MMwwsior7j4sVhxDT4p4zDhUvZK?=
 =?us-ascii?Q?RV9w4qvg3hMBvkE6vgezV0VFhYCLJy52dxdqCFfopXNfEia/Pv/fFq/G8aso?=
 =?us-ascii?Q?GaA9buZlvy40l68ZPLbO7I5F7Ikczg33sBXwAactmxN8C0gmdXsNfRqEHp+l?=
 =?us-ascii?Q?q2cAwfRfnRCqqiC1OtWDY2H/F/0Z9TVb1uiy8ZBIovwtOcF8AGavdw7/VSSS?=
 =?us-ascii?Q?LHt8sjxl68Pq1dKaFIiv7EjAiMq0n027CKH8iduJ9Nn9wKBc63pedbcxFoZp?=
 =?us-ascii?Q?tabEiDz2U7DJu8G0EJPOkqmM6BLSvX737+xTEpJxQP3HZqkLte87zKJBOcj6?=
 =?us-ascii?Q?j/6JW0fI27qlN0fBKPclbvuqtw4Bpszmz5r+q87AXKFjN01UlmR4ALKr4I1F?=
 =?us-ascii?Q?bS10rCaHqooJ+hTNcVBsnGuCwen6Z0S6ycJMRvwVc6Iykwczjyo/oXomlQTn?=
 =?us-ascii?Q?ZAO3VcUAzZR7ID5pvGd9YtgS436/siD+4c3u4dlqgj4ZpSks6JrNJtkE1A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 05:08:18.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fece48ef-927f-413a-768d-08dd8612b051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
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

Fix code comment style

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504271826.xy2fFO28-lkp@intel.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 17f0911ee7e9..82013b495436 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2165,7 +2165,7 @@ void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 	/* Fatal error events are handled on host side */
 	if (amdgpu_sriov_vf(adev))
 		return;
-	/**
+	/*
 	 * If the current interrupt is caused by a non-fatal RAS error, skip
 	 * check for fatal error. For fatal errors, FED status of all devices
 	 * in XGMI hive gets set when the first device gets fatal error
-- 
2.25.1

