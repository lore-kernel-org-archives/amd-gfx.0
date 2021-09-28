Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E673C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5E46101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C5E46101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981C86E8DD;
	Tue, 28 Sep 2021 16:45:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A976E8DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cxd6EXT9ExzFyn7AwV52DB06eIImjazBnpT3ZpVbJHvi9QbpKer9bNemWjC5GazT2E9ld/HuB+01udAjYWxhpCSuyN6ijYJ1FGRO7ZLWchQykcZffhXVR/NFNCmIGKIi6CVErR3MSgYrveGTqIQllqNySwUtHO2U8lBBYxoKkWTapngOROdGo8gUxoAJW/VOkg3H4UlhUJh5k6u84kt/2Sks6gTBSSL1m7lik75oJycJA5ILXcK8F4aH9Da3d3S/AbjmxoMJ6wfkFoGq75d/cFV76gzmu5AmHuNpu9cP8vSxYp4stWrvvz1J7y3pHYLq5bKegRQ7WrXKMZXlivHXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=DlBGe/ilPVb6Mt0EFO5smFFc2KxY2cQohhC3NW+wSFw=;
 b=URXM/y5WC/k9bMGrdMWbxleM9H3avypKeNn8kXJbLpfRMKfLz3tJEBJoqnHmBpp0MZgdV+qqFOkMphz0OhUKiSVCDUn1u9+RSJDAUGhRErjmIHsexsDNUgad14l4KkTiyuUtSg5bHOBW5Sfa3V5GfrQKmVxWBVEqeaDK6+0hJuVI/62jeMCJcdA8RStKRq8mVCpeekeAo99AZNN5fu34oAZQMiJdq6DNYtLEuQZPi/T9a1ZuPsNogXiQ2njSKFJPEhFGrKlVC4exk//FiEAVwmRF0TkB76Fa2a0EWGlv7XZjc2olEeEuolyQ9wUu5bKKA+I3mvg/C2EO2WVrs/J3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlBGe/ilPVb6Mt0EFO5smFFc2KxY2cQohhC3NW+wSFw=;
 b=V6M1QzYpMYfBD+aG/RROeIr14XaV4M2fq13/ibsYCPq6XEYXYE6ktdlO301P5kUgt0Nfq0qVJ4Mcou6AoQ35v+toeBwMpw7MoF3HXXrvPjj4MX0qd1O7dsTr5XlijbspvuMsd76OxSxOuCm2H1XJ/BVrpC8XtX64a+Te4t8SrPs=
Received: from DM5PR07CA0131.namprd07.prod.outlook.com (2603:10b6:3:13e::21)
 by DM5PR12MB2519.namprd12.prod.outlook.com (2603:10b6:4:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:45:36 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::be) by DM5PR07CA0131.outlook.office365.com
 (2603:10b6:3:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 43/64] drm/amdgpu/pm/smu_v11.0: update IP version checking
Date: Tue, 28 Sep 2021 12:42:16 -0400
Message-ID: <20210928164237.833132-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80605393-f404-4def-c6cb-08d9829f6552
X-MS-TrafficTypeDiagnostic: DM5PR12MB2519:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2519F8FE16DB4141A84823ADF7A89@DM5PR12MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ov7fldOycBIMAHGzO06qGZe0YguTPw8Wsu+W33ro07Lm2QhayViULFA8begyKRUIHuO93yVKKNQwtob7WKIz9k44/t5D9arP5PzVBGj8sbeBq3p+HdvowCVG/dvl3dD4vk+BxtMbaOnXqj5gLNDy5ASnNI83/ZdO7BJehZLNhgvf1gC4O2fDcHyNmng+KfQ28Rczgzf0HwmBjruuu9LfxJTMF/cHaJ6e1CpaWrmRIDt0e5MUH35HZIktwEpPwMuLTENeV5O4kC36OAH1xj3Aux7b/Rebm4splUdnZI/Iscx+7nqXwPoNkG9QsKdbpcunGPCUGQm5VGoYAXfeYvSoOg4JxEhANX8aCGSZS4+UUbDqPlBDTzV7gXoO3hTY0aMiy4zFGIi1M1FSuL3CYbsw2TSFZGvJsUWuKeIE8fFLAgJ07LZY8XbCdIU4QNDRr/L5ZdF37RoN7GL/C0WX7T5LrHc7Tu5d0cOit8uqbrlyxpzGSIO89hutrRDWQdfm0zQVA3os3rNTzs7/pHA4FDFw1saqtL+7n7f3ploB0l+SGx+jF7Xgt0Uf5XqaMITWG5UkUD+Q6jIKGjjITFwBJo729FFX3wuLkrnkztdeyCz+WlgmOizvNcCqS5G7ta/iFc9N3Z/sgsBfUvPhOoUSaavmRS/8tJEwzlNOhai2rUevW4CPeAEEi+t390pWxh2p/MrQd0OFOHE/JMWd6/hbGSBgvsrJrMSztV7X28qGn8vsg9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(8676002)(26005)(316002)(186003)(426003)(1076003)(7696005)(6666004)(66574015)(8936002)(2616005)(4326008)(54906003)(82310400003)(70586007)(16526019)(508600001)(336012)(6916009)(81166007)(2906002)(356005)(83380400001)(5660300002)(36756003)(70206006)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:36.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80605393-f404-4def-c6cb-08d9829f6552
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2519
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 5af7c8b7806f..1ae8b8dc3bd3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -116,12 +116,12 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	case IP_VERSION(11, 0, 13):
 		chip_name = "beige_goby";
 		break;
+	case IP_VERSION(11, 0, 2):
+		chip_name = "arcturus";
+		break;
 	default:
-		if (adev->asic_type == CHIP_ARCTURUS) {
-			chip_name = "arcturus";
-			break;
-		}
-		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
+		dev_err(adev->dev, "Unsupported IP version 0x%x\n",
+			adev->ip_versions[MP1_HWIP]);
 		return -EINVAL;
 	}
 
@@ -267,12 +267,12 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(11, 0, 8):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
 		break;
+	case IP_VERSION(11, 0, 2):
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
+		break;
 	default:
-		if (adev->asic_type == CHIP_ARCTURUS) {
-			smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_ARCT;
-			break;
-		}
-		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
+		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
+			adev->ip_versions[MP1_HWIP]);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
 		break;
 	}
@@ -1653,7 +1653,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		default:
 			if (!ras || !adev->ras_enabled ||
 			    adev->gmc.xgmi.pending_reset) {
-				if (adev->asic_type == CHIP_ARCTURUS) {
+				if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 2)) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
 					data |= 0x80000000;
 					WREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT, data);
@@ -1935,7 +1935,7 @@ int smu_v11_0_set_performance_level(struct smu_context *smu,
 	 * Separate MCLK and SOCCLK soft min/max settings are not allowed
 	 * on Arcturus.
 	 */
-	if (adev->asic_type == CHIP_ARCTURUS) {
+	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 2)) {
 		mclk_min = mclk_max = 0;
 		socclk_min = socclk_max = 0;
 	}
-- 
2.31.1

