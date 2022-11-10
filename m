Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39ABC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Nov 2022 02:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519AA10E073;
	Thu, 10 Nov 2022 02:55:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86C510E073
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Nov 2022 02:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7p5mGkPwQ64RhFkvx3BTGL1/mPhzK3apWmvTGCwgXIClHpFivQJzF9A1sNR7z1lg4DCO9NxyZOeuB2MMIx+86yypoR6kbjcDoBeRZjR63gc/VO07Jb7vFZOH0GtPQ9jmLjbW2WYRDgG8ODsKRVwbTZra0j8eAZFqmO1mjuQSsgM7259CjP2VupF+DwelI9cBXHDwMkJxqfPBoOxy6XYqwD910CeOpjDO20ASjhSLop4I0huP6bUxVrjfcjGHo6CtkzL+x1YxtmX5CNKbxNpyWi449yMD0DPGQuo5KvDbxpqeKzQIgpMgR1mTnu4Ra+DxbGwyBEaufbQq+nU+VEVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv0ge4gUVa0fWijPsqmmkL9VaTcLOawxQkMA7KP+UtM=;
 b=RTIUkHSbIoiavHta/up8+OwARKfXCftO0pI897OFOqiGKxIdpUy6yCvsHSBjrLome+6TIZ6GVtqY92x/FzjZ3hHOHnXjw2guW4dWq9NjNBci2L2b/zDWLVYbJBW2FlzdwKdnQpQSjnBN7GI2qYcPnQTI42ppDdwWcLrGekSaHl+JbyPN9RHrwKIT8Meb7wsIBmnBm85Aji+Mu+r2B2mnk1c0SnYfWPDOTfuCU4N5+W7UCHYy71LHA4Kc2b2FWwXTZK4uoymEExdSiHBd2vBiR6VYhviU+YpbmqKQGuiM7RGP3rczlpehWzLpT5elhN1cnHfy7MLw6PdCS/5k9fqU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv0ge4gUVa0fWijPsqmmkL9VaTcLOawxQkMA7KP+UtM=;
 b=mHgu4oVIAEAJnCtWq1eDyGVHlDW7V49TWkNlcZ7cp2+lmjPsEFv4WV+wDPFzz6yRFcs8tZOsG5f2q4/DcKmle4VgjyfTPFc8g5lczohPVA128eFZyHqD2MqiaufCx1AJ2iyKCmgaHqWq78hdBGKuJv2x2wWame5tv0Dra0TUB8Q=
Received: from BN0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:e7::6)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Thu, 10 Nov
 2022 02:55:08 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::c4) by BN0PR03CA0031.outlook.office365.com
 (2603:10b6:408:e7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12 via Frontend
 Transport; Thu, 10 Nov 2022 02:55:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 02:55:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 20:55:07 -0600
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Wed, 9 Nov 2022 20:55:06 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: skip disabling all smu features on smu_v13_0_10
 in suspend
Date: Thu, 10 Nov 2022 10:54:42 +0800
Message-ID: <20221110025442.63642-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: aa87ef97-f4a4-4715-4080-08dac2c6fa5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBx7hcZmD6gY+Ai20dWhp+4gNltrZzptxNT3LYrL+iL90yBLTi80w6iOssTQvZRUiOs16RSVhjqb7wmEOXYeh6r0fivl+JziFsBN0rUffBQGew7XLnF3oCJClk3uN/BP2FC/2CCRGtSuITpBez0h4BxT3ORW0usPStDC0oREFJjWLw9iFUvXeZLW3d4+xaj8lVolq35qmPr7S+15cw+XBIwq7nNQbQkTcvbLNFBdolyQWmCKC/MTMohTY1hLFaCbO71ZmghPwfPGuWL80IgJXdK3dO6Y+T3T2RBDzZ1SjKm4U0JrijxQNoJBrtKdaSTP9RmgWg4k/6MX1ZnAYBjhJ5AKytawHjNOtBTX0xOnP8Cgat4wyNJZHIg83UFzdGetCitj/YIBYSIaIWz1oLM2OjRjAD8tWIg7betfheuW5L7kOuFSOKCT6IXzwb106GUOKYZDfW1uwvYr4fyosY3gRoLArurZHI4tDjRrzsSYFdNUYzu+wfnJxTz5MTcQRl1T6/WGLGvObHEq/IhSc0iMZuoRM0Ehgp5dJmRavriCv24JqwmIvcVd9Ojt0XY9ouUEEDprdqgIFAXbTwccxWhWNSCPFc2yTZEpgCkXki9BO6JH6TEWt9uUeGZ6W44bsFwNLYKdHloqpNFG/8cRZAdr+j+0uCL2YfdRKtZmtWGDEaL8i2gC2xWT4yqJtq6Yvhn+J2HwaH1ItOzh3RjKrVMdkr9PgceoQTatHHePVnNpce5nLYM+/FFVa9lav/AQXJs9sYmyEoXcq+GFbTVvgDoH5iUkjtefsWaRslLvUOYEXAQSOsi18YKOfZ7A6McofWe9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(356005)(81166007)(40460700003)(86362001)(40480700001)(6916009)(36756003)(316002)(26005)(478600001)(44832011)(6666004)(15650500001)(8936002)(4744005)(70206006)(5660300002)(8676002)(41300700001)(4326008)(82310400005)(70586007)(7696005)(2906002)(83380400001)(47076005)(82740400003)(36860700001)(426003)(336012)(2616005)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 02:55:08.5606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa87ef97-f4a4-4715-4080-08dac2c6fa5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip disabling all smu features on smu_v13_0_10 in suspend

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 4fe75dd2b329..320cfce1fef5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1449,6 +1449,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
 		return 0;
 	default:
 		break;
-- 
2.25.1

