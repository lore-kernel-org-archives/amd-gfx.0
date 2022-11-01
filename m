Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C357BFA373D
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 08:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA2710E245;
	Tue,  1 Nov 2022 08:40:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4F010E245
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 08:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPEQtnNjzAGWjRnLvOKPegqfkm2JevqA1SsSf+RX7z5ye7yuAak5WkCzFGjytrhq6Lkyk3wR52QG5lxgBG5dS42GnqJFbUgpFGxZV4y7SsT6eKI++3kVUS2LSeLbsPrSP+notAvHGOJ9zYOsyunDAR0I9aeEfZguyzsccFeO2CtqLaBKEZG2ZPiP58JD2XQGY2xTuBuCrJ0NY9RMZrOhjwsyRFRUHstOaqewyqZTmC5J/3Gpph8zAPxIk5njZseMSnDFLZ+iibzp4ADBjse1ENhlYIG/DiqPhORrijkpdV7Z9Vf8KUGbN5e1J5QShMw9SSsErq2fc8mPJ2o79fdIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQuXDMXeva2CjW6UG1XvyYBuwM5qCMCLpc2h0VO4B84=;
 b=EaEPMz7Hzzeh0wJu7+52QaZ7hTKLsDuPOJOrRLTMVmmGgB1Y7o58bieqJgPFe/z3i7plFOfMn/okbaEiQW1eoqK5oPVU1YAvlz+oJZ23U60UEKtaOOW4NkEp8+xIYnRfuIroIk1qOjdNCucAg3vDdsteAXL8h997O9keERELdOoOZ94QkKaiSxub8ko3PwxD570rRZHqYpEjtgoBEOKY8nNE8vVFFYiAhC4U1544ijVjRMXTsC4XrI9IdWSLQ7JPn3fbZ7nLwDo6mMY9HNh4cjXJT0RK8/SEwkd7CkrEuCSnWZi8bnc00JJlbGA0LshxaQpSrHDn9bmQDu4fb5BJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQuXDMXeva2CjW6UG1XvyYBuwM5qCMCLpc2h0VO4B84=;
 b=K7rHVVZMZCHCBAalejpLSITTG1VFARkAK/Wp8x/8r6GJyy0n6/S5iqoqRkHjaeP7ILVATH52qJglEhOiIwHND8shI3r36un+rkOsWhwEkb7v4twQrzpFdoAk17uoXzmLusBGYKVDGBro1Ub6VN7uYcE7EMRh1AJH8Dz7NqugQzU=
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by DM4PR12MB6421.namprd12.prod.outlook.com (2603:10b6:8:b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 08:40:27 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::cf) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 08:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 08:40:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 03:40:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 03:40:22 -0500
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 1 Nov 2022 03:40:20 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Clean up soc21 early init for sriov
Date: Tue, 1 Nov 2022 16:40:00 +0800
Message-ID: <20221101084001.707650-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bd3cc8-ce9f-4fa1-bb66-08dabbe4b9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bluu25zM8eLFK9IfKp3AGqd9Tc3ho2vBE6lIeyO2KufVWGmTLJyQGyfW02DfqV0B8AHFpLpzKpq43J8mV4trR8D0w1oL2y2mmeQSuA4aGLA5wenjsWmaFO6LQIS9fbHdOF/JV4OT1T7LQAUJOg8SCFozQHIqLwbU9k4g3vjld5DZZXNZeBtaTDwToefMDs/5jjLqTtziYnmpbrRd2ObqEsjDzMg6Ovx2v/32QGi+Ibe3eiSq12e/IjpKSJojZ8Ggzgr23GO9fuMQeVTxPONox1HGPaJNMCXJ0h1rhtDl0iZ07r4+GgmNA7eXvuTEdu/O0dVOQuFz0JuEdgLTspEw4Esd5phCAZGyt1PO0QfxPPnOePHKFR+pBLeZV7pWYZnG+20LSUiLqFqqJzxF/nE5G9bmVsUS8iglqpK3wE1ws5xhlSW2EliiX5piBbVo2lYU5ietuHlwRmK45kCSEyBYCBPNYHx3OCO5yzfdar/cqQImUz6+oKph/gKEO5ptap8SO0wUYeGdLufxxby0A23mkZ+er3TQ4dhtpK2tbppTDz7kRkunhm/fTXl/JVc7MTh92YXpS9TdT5qNrCpQAOt/KpIvT46CK1VHQq+2q2hRKT3mHVLMgwMBgwU1xCfYdakdvucg5WwAhRu6S5h5inUfy8CXXeGgKwl00KMeAkG1sxVtbV+0prhU+l3RJPRqo6Uufy+oC63ZSoThmBtJPySG5qz2EQXNc5+N6xIDuY7h8VZeGTgMYSKWLF2HWVmFU6Qaa2TJ/ZLHgiWr0WN2Y30Ioo0xrgj1Vm8Hda3j81h8TrQdKhp2PHbNYkWSilUSAQdY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(8936002)(41300700001)(2906002)(44832011)(40480700001)(4326008)(54906003)(316002)(5660300002)(47076005)(186003)(40460700003)(336012)(1076003)(2616005)(8676002)(6916009)(82310400005)(70586007)(86362001)(70206006)(83380400001)(356005)(478600001)(426003)(26005)(82740400003)(7696005)(6666004)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:40:27.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bd3cc8-ce9f-4fa1-bb66-08dabbe4b9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6421
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
Cc: alexander.deucher@amd.com, horace.chen@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use virt_init_setting instead of per ip version setting.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index e08044008186..1d4013ed0d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -584,10 +584,6 @@ static int soc21_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_ATHUB |
 			AMD_PG_SUPPORT_MMHUB;
-		if (amdgpu_sriov_vf(adev)) {
-			adev->cg_flags = 0;
-			adev->pg_flags = 0;
-		}
 		adev->external_rev_id = adev->rev_id + 0x1; // TODO: need update
 		break;
 	case IP_VERSION(11, 0, 2):
@@ -645,11 +641,6 @@ static int soc21_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-		if (amdgpu_sriov_vf(adev)) {
-			/* hypervisor control CG and PG enablement */
-			adev->cg_flags = 0;
-			adev->pg_flags = 0;
-		}
 		adev->external_rev_id = adev->rev_id + 0x20;
 		break;
 	default:
@@ -657,6 +648,9 @@ static int soc21_common_early_init(void *handle)
 		return -EINVAL;
 	}
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_virt_init_setting(adev);
+
 	return 0;
 }
 
-- 
2.34.1

