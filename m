Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D933C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 17:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1D110E318;
	Mon, 21 Nov 2022 17:27:33 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB17510E318
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 17:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQDRzPxEAxLrYDit7WF29KDesA6QycrXKI3OgnJHMsJYoxNTMO/EPTFJe45AeMIF2mEvoRWeyt4OMWsdTHm/r+Y0geYEyCJQxqPtPRZM0Z/pE0C/0HSv2oRcL3Ao9OLlJQzs7AYSp6r+T8edaML+cFAg0DbwMFH/jiPVtmUGsU7mgJqSw4qFMqEpo0T7Qy1tEVVmCdZgbkWsRHAfuMO1A8XXclKiPLbeiTmFMY0bbjLQKFW0fWcwU3OvU1uoJCnCFyCjNkqhiyE9mHjJxsZxygl1CocF7tQxx9AuTXL7xP2cNecQqA9HpF22hYRlb5j1Xly/9pTtICM72rC9xbCYbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE9JotsdbSIkmLooAAzm+gYgany/urDN9/FGMpPPcKo=;
 b=lcbwXM6BHepmPxBjDYlClrYrSheYewt4ccje3IVdJLNl0rNSKM6V+AvMJxAroqvfGCvGZPRvv2UdlkoT38o/0L9duvDxxCChtScZWWsB+D+f8hOguBreC6yNmbktFj/JleB6TBYoTZ7MmCRS0RxA5MS2SHQzEXEggXyygRg8FZ+4ucE2SFa7xyf36ZfrdmEs/W3J0oSPDsRQqEo0AfhvciD1oj69wHm47UlGB241xxP3i0CMifSKZCDcK0B7fl971J/WS9dCDZCYDY5LQWIzi4mdAiwHWnITgVLQrQPsNTXLIyIyDEwz/S6OSTZ0Vr0VURmj1WxvIFHag/UfDqrTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE9JotsdbSIkmLooAAzm+gYgany/urDN9/FGMpPPcKo=;
 b=Ma6cVnsaWG56Jj5BmQmw5sT3G/fOETUY+4BZV7g8/QauB4wRGZkcj+6S/bnv/48wUUcdmrwGHOq/EdrN7AxdPNPbCz4BzqsuO4dOgBeE1B0PbodC4NU757gcOpaDfQLBNprc0UqhPFPsOGyUtsapweIRmCh9Q6Jpsdpc+Wr388A=
Received: from DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) by
 SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Mon, 21 Nov
 2022 17:27:27 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::ce) by DM6PR01CA0004.outlook.office365.com
 (2603:10b6:5:296::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9 via Frontend
 Transport; Mon, 21 Nov 2022 17:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 17:27:27 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 11:27:26 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix minmax warning
Date: Mon, 21 Nov 2022 12:27:10 -0500
Message-ID: <20221121172710.58490-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-check-string-leak: v1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8dcaf-0abe-4d03-eae3-08dacbe5a953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGWNwZbu5o4a11lM3rHsoxkv3rS/DekGHNXC1kLsWFKyJVPIFt+TGXxeTaptGoS8djt6+1BN3gwlque33E/zLQ/wpvlBlxUR7GXZRyFHtBitNRTI5mK/N6N7rURv7D4RVtoC+jtyU5NjabwzHOMLSzssbr/VSECrJz+fTWuf4RfhG66/rVpXUQCdcQiAagZJIh66kjmLH7KsyOP9c11e3Z8DFTI0kHakVpIlEBOzFhdJ2/GH9rfjY0RxC+/nOfYy+N2V7UND0k3h0Xopga0rwGgB97tQy37lqOdiGlW8fUi1w6cVblxkClq/pOn1c5fRc59L2QYKW0VNDVMPbBmZdrI4O/e1NCiNhgDVkjY++JC4fCKVIaSC1+7YKQc91HiNjxpAPBMdAg+KSSnh72nooo+Lq4SCXBBnMJo3Gr553a9+N7+6mYIeMYYNyTqwNz7QT3x58rVAXjQ8h2ZTw241NLLjR7gviDZnnsSbBTevPzVp674PZ8l8RBZP+U8xJhTcq93Uj2NZdBqCw9aVDrJNTO3uqRGApfLftfKbep2ct/is8Q5q9dWT6AtXf+W3cPtDie53oONFW5zgQ6saSxRKK+SWGwHfTR3S321Bhr956l2EarvpMDAqE4WYaxs4gaXc324LtOhtZfAk5ZKoJadJaY3Cy3TweT9VTDDzEzXmyKJHDKmOSt33wsub9FfnabTxyIPJAjjkTYcnO0P4ldOVlrVGntK5FOCCrxLR8bPts5g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(70586007)(81166007)(356005)(82740400003)(83380400001)(70206006)(36860700001)(8676002)(36756003)(41300700001)(5660300002)(2616005)(47076005)(4326008)(186003)(2906002)(336012)(426003)(1076003)(478600001)(40460700003)(44832011)(16526019)(8936002)(26005)(40480700001)(6916009)(86362001)(316002)(54906003)(82310400005)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 17:27:27.4519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8dcaf-0abe-4d03-eae3-08dacbe5a953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix minmax warning by using min_t() macro and explicitly specifying
the assignment type.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 5a905002252d7d..53abd770924229 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1436,7 +1436,9 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 			case 0x8:
 				high = smu->thermal_range.software_shutdown_temp +
 					smu->thermal_range.software_shutdown_temp_offset;
-				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP, high);
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     high);
 				dev_emerg(adev->dev, "Reduce soft CTF limit to %d (by an offset %d)\n",
 							high,
 							smu->thermal_range.software_shutdown_temp_offset);
@@ -1449,8 +1451,9 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
 			case 0x9:
-				high = min(SMU_THERMAL_MAXIMUM_ALERT_TEMP,
-					smu->thermal_range.software_shutdown_temp);
+				high = min_t(typeof(high),
+					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
+					     smu->thermal_range.software_shutdown_temp);
 				dev_emerg(adev->dev, "Recover soft CTF limit to %d\n", high);
 
 				data = RREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL);

base-commit: 51005ef41b7e91d1e24e2defec22bc4f1eeb7040
-- 
2.38.1

