Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7805EC624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 15:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E8E10E2EB;
	Mon, 31 Aug 2026 15:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P+oxAMGs";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3832710E2EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2iNDJlfyCVNRyYsAymSC1ws8Et7IcNEn7WtM4Cu2oFdqWL1mCV5N8WzVwTUm49XFydhaxR11tmXyKYUZ/CSjH4g+le60r/59M7lv2PYx21t0L9WZodFtZdCJPLZA/vBqXyE3ZfnIjOrtfI5UDKoNkAlxI1UvsNy3MWznvsGLo9aB+18DW4Xzl1ES4bAUXd6YVm+YEcre0Rhepuupobqx//3IhdBgHijMDJkcXsPftbEYZBiL9qJIZrN1/IaLSzPeeyhX8GrEPc76q70xDS6BkwqidNbrm/bpOz/RzoblldXrPlYCb/87rKtmXvs2d3eH0QaK0js6mzymdaqezG1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43y41PihNVUW9H8w6XeLBUp35y4C4iDvWpT9cj6YcaA=;
 b=T4a1EgW6T8/yw0U7GOXyAXzC95YiBJrqU0HD8rde37A2WRZryrKKZxB+EgVBgMGC24q0jpfhWUKgn7vz+V0JbsyzStvtAhyWpVP1p4A7mt4UIf81uk6weh3XM0Btdh4GLFPZNYkH9z7cPswPPWLLKoYaNNDedE3hPUjrLan4qw8gAB+wtwwoK8RgIqsb3/nEt51tobsxtBhJoRUuxB/4Xj2ifLcAdfvfw1FPah5X6e3udT8EwUqxqNuuGxCZTGry61hQlm9WEqhrbDWdgyvVnlP+QlHL2tr1/fBDSL7sOGmH9An1x/ldUGq9u3nwaJO0spVlytiQGhBWVwhHKSvmFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43y41PihNVUW9H8w6XeLBUp35y4C4iDvWpT9cj6YcaA=;
 b=P+oxAMGsNuTUuVwt49DgkIvQWOwZgKJPcz0OlV5oTeZHi1OTqU0krnarkLGIRRBCvCA+YiL4M/KEmwGBv91RotS6mnOFGFVgWupamVRUUibVGiIhr/cDvNo6lOf+WqvifiWK61jDmU3clCiSsqUg5qt3B8HlotiQIrWe0+5qoSk=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:27:19 +0000
Received: from LV8PEPF0000005E.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::57) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 15:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005E.mail.protection.outlook.com (10.167.245.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 15:27:18 +0000
Received: from ram-Splinter.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 10:27:16 -0500
From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Pratik.Vishwakarma@amd.com>
CC: <Kanala.RamalingeswaraReddy@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH] drm/amdgpu: Skip accessing psp rum time db for APUs
Date: Mon, 31 Aug 2026 20:57:01 +0530
Message-ID: <20260831152701.1162137-1-Kanala.RamalingeswaraReddy@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005E:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f980a3-e718-43fd-86d6-08df07745810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: zUWH7AwijDvK7gFhj2Wd57MotcBRvZse6VqBgvw9TdbBv5b3kArkXARPbw4HaEv2n2p7DZcdRi12PnQSexVlssN5Rkhwv/LfvWiecUewK65ThqhTu5sU8OI5yC/ljqSBQlgIOGvFqflsYntDXV8YBR+/+UfEFUPmLvn17aoG1a2zXV0z+xF4EIa4P2RrauE0Cww/3GWWB9FkaCKuJLAt6st+4K5jVgBhvfDv+ab47x1TLpNQ9iXmjPkhUTInKULI1Mpc7Ru5Hejopw8N7T3CMG8aNH/XpQFulaRUWkNK+yE4ALXKSKA9U0klsNrUFEIcwRB0mybR2n4ZeoymCipLsj5ctCl9BGmXkdtC1Z0GUN/4Xr/YaPuImI1YyVA4IMl61An/d0IzBuMelp0WO4d0M+R4MmfK5MGyUaN2Tri1IHZcotZBPF7xXyzhQVVsqLUHXUaII0S9ofsSUq67I2XC00HDcn0T60sPwFCK9a+TLebyMBymWJaHLUjl3d95YLkZ4Izl7RkOn6yHO3eXmQJflqmlY9Fip3B8MLg4UiKkur5fG2SniZx6Ry2g/LVg1Wps1Ju3pm65JyBBWrh9Pp9BOqdEm7B4iFxoePLNHsTkogjdRcOnVZeGrg2nsHcUv+NbR9s0wygRRnsu2RRejqRN/F69oKvmorrSLyUkhzCNPAPMqkzCxUyTjCuy0jcoA4F14u79Ntgn+ytpYQUVfEHDCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fN4UUBySQrDxD97yqIl/8R6sUufFoIqdS4j8ljY5d8fu+NjCTQid4H++160vW7NKVWJ4W8d6ijHatA0qrWNzH9txGYpxgE2QZJCH0GiPcZPsnny/agZzGfB4XOcX9I+MasyXy2yQwHPyrpNlJ80B5Y1SJshFdTkShWH9SLHhDY3W87GiGFwG+R19AQD6rueEeVtbiP03J/QzEs6jM+7gnLgOTn3ui6vysR6qtxbMTlA+Zvx69apape9gh0Mz7STqJ7dMqjRnxU0WbfvPf4TNi1wTfAyfzHJJmNDLd0zYlFOqWU5nJTUO7X6rNh8apyKIHfUub3UdZ2K6hU/IBZkd36RsL1EZ3yTIoZR6QPceBZhRLeiQWv6Gjvnkp+9o1mevkYnK/Yz7qI+y0+Iu6BLE0zUMUDSlRt8w1WmV5CZc7FjgjTQ0S7dhNoUMnGx0cJci
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:27:18.4554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f980a3-e718-43fd-86d6-08df07745810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

Psp runtime DB is for dGPUs only.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a0f6df5067e6..62d906ede42a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -398,6 +398,13 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	bool ret = false;
 	int i;
 
+	if (adev->flags & AMD_IS_APU) {
+		/*
+		 * Runtime DB is for dGPUs only.
+		 */
+		return false;
+	}
+
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
 	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
-- 
2.53.0

