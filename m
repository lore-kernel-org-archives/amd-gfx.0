Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A631C77B6D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E256210E92C;
	Tue, 28 Mar 2023 15:15:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D11E10E91B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kpq+sUq6e93qk5TjAMKodESVDb00yw3ySEqmWl8wttSvvV9/Dp4dIlYOKG4lkvHjS512hOUjnl9YLSTjaJbH+EjuTKA0s/qDBIEri1PlKhUlRQCra66noLu4lH0q9agA9Zr64JfGB1e1JBRMX4x93oeZpr6bwXCAx3YmOcOcRNx91/gL12pSJP2AnbMD+i4ve+YuoHcNwDNgsABeldPekqvE3ZHVCdmq4WpgPgrjRzfwfcooPgF7xw7LzAfPP91buYp+RMvF1cfxWQpRIs+I+3BW4UdO9gjzs45QMTdzhQtLCFnBRqNLMDkFGgm9JvNqGMMAQwvpQu5ZIV37gxAhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+2b/jZd7B/aFNV3D8o/1hP42XzXHobRjpboSvsM2LI=;
 b=DAMWel7M2KhOkDTqZCSKoc76lCz2vvwMfs4G8rLW8M3U6a4+E67kNmOf0+3NDeq9icwGVVfEXmeR9Io4zZsxdmoNhec1r2jqT5Hec+rAJfdeSs96tApuYwyYbgOpqgHe7M2ja/KN5uhlM8aQWugwZ7il29f6J9lEFD6Vq9g/rzlzRQJX4yfe19Hy8LoivF+CZSxmt/ycnl7in7vfXv+ZWYC5nqpHH5iVDHWcGBT0kg6kJnO9mXRdVs0vPeOxwdIH2hdd8iKobiE4dME5FCTv9qdvz1jNCsyOPpwRmNcStj7HbLNuvrLDMkkN89zMJYAasfRtLEYq6c888PLS1Nt/fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+2b/jZd7B/aFNV3D8o/1hP42XzXHobRjpboSvsM2LI=;
 b=Zo++rJ2tfsfbgV8dAkXJN0OUbro8ymOBSvGK7RZ4+55w403x0qsgw8X+AG2WHaxkbKGpqO8UyRCLEjbIIUmjNee79ufmBhibOgFny417GDRdQvVJVG7mJJgcZ6bfkYOemfuCCQp2ao1EaEqVjr6SuzXuldG5/k1DaK6CVy2tkGw=
Received: from BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::30)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:14:52 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::97) by BLAP220CA0025.outlook.office365.com
 (2603:10b6:208:32c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/32] drm/amdgpu: set mmhub bitmask for multiple AIDs
Date: Tue, 28 Mar 2023 11:13:40 -0400
Message-ID: <20230328151344.1934291-28-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: ba129c13-2029-4373-8c5d-08db2f9f2d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDaPtCw9S0XqU8I7S1UT4oZ6GaO3q2f1gWHmT3r+rwc9gw0xCT667NlrTOrbWxiwogg9UMdScHhUJKLC9lra1fb7pvGMOH0f92Kv0w4nrOO5fmKNY0tsWQzrQy/Gie1bR19npihQ20hOg5mX6MjsVoo/9zqeXycx12D7HM9ZEqPrvon5Dk+GccPeJ/km2ehBdeIQX+ji19CXDrpo0nDBmOUCc0WJZLlBq/o9DyyULCqo7IlX57DtwbKICImQBGWBOYZbi6DLVVDaM8+m8JLSD+/aXILHhvPaUyBYkrvgH/rXUoDXt8kmMbdTPL/DFmc3kAC79qJinWkvHF6oTKXrIh7k/DnP6wpTPuTux7crOoF6yiFqx6rxSSpLCp7BwbupLEp3LjvEa8utpjBJnhQZ+jKhw2EwmFKOsPy/PGooRIpCgSb5+ynjaz9P2ZCSJ5qszwOFHSY7uXJrY21kT/G+Wk9XKBoTN9VcBiAb5I/9w2SQXs3CTrlR8+dcU1hlGmxN00PQtSJdJya7e+lAxO/vxJG/yiJpIhX/elkBG6TfEDc09g0HU2serY7bf/SsYBTeMMu50sBoYaSAUrNNWw6eBPTzLMShu+EnUEs0BKOwAH2ELTu4iJoHUvw0VBKH0+k0m5qIAl9t5NvLV4NI3i4wf8du8b73eBj8kmnZzGBc8q4CQuQL/X1uA2fOeUkqSWBQ6eVQFGdCOyBRAggwfkgUYVsnhs8AYyq/xJDhB01BTjM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(6916009)(70586007)(70206006)(4326008)(16526019)(5660300002)(36756003)(2906002)(4744005)(83380400001)(336012)(356005)(47076005)(86362001)(426003)(82310400005)(36860700001)(81166007)(82740400003)(8936002)(8676002)(186003)(40480700001)(54906003)(7696005)(316002)(2616005)(478600001)(6666004)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:51.2187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba129c13-2029-4373-8c5d-08db2f9f2d7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Like GFXHUB, set MMHUB0 bitmask for each AID.

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index cb8ea1f5bc44..44573689a5ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1713,7 +1713,7 @@ static int gmc_v9_0_sw_init(void *handle)
 		break;
 	case IP_VERSION(9, 4, 3):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0), adev->gfx.num_xcd);
-		bitmap_set(adev->vmhubs_mask, AMDGPU_MMHUB0(0), 1);
+		bitmap_set(adev->vmhubs_mask, AMDGPU_MMHUB0(0), adev->num_aid);
 
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
 		break;
-- 
2.39.2

