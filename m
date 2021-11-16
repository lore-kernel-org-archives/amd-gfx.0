Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214B7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91B96152B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D91B96152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85A3D6EE1A;
	Tue, 16 Nov 2021 07:23:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCADD6EE1A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 07:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xhz8OC3AK/ECsDfJdxCF5gL5lEJ0JLkFDIfzBxioyQ3+wn4am5Wm0xBHF0fps4WHfWCkzlB0HtEddNzvUjA1tMJLtrn2NqjThOTXSh9hJXcOdBaXeWspk0sTKBTF1M7OzOYHp1qpn7rya3Ilfw95JmE4ZzyP6l9iowKFy+DIGXbOl0USMN1Dis3W6wCtP59JEU/t4qg3BKqCMYar54h363aM5SbBsccnvNNcIPxKcXrwC4uWTUCe2FcxOoEkGMJ3uyRR97cIKcrJYJO0FVIm1rRJ9sb7ZVIKg6vsXd4Hy2Etwd9++ZSfd9jx2qvAk7IxSb9/AmqrQOj8HalY6toT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Koxl3+wE8kjwWiiKXyBTfn1AEv4kK22AitsM10zqgxc=;
 b=WdoU0oJXnsoLgqYtAEJc8wj4LSl6jJ6eExLJYURtOXsa7cmxmcFJW2SGDJOXPrHufqg+997G41mCGbUpOSweyIMSrRJIZtVL9Qys2/j3vWw3tZAWCDpzYuxW+OPZuIQ0VeTZtE6WNAW3dUwlN2nzpCeOlAk4oEsOhLl4Eu3me5cZmkCDFx6BHODaDdsT3uKSWO6w144lz/VaZ/JXtIj6YUhu38q9mIH7tQGVo+gSoODb2lVABHQFm5rtAnxy4bI2G6sdIZXtptkCty9pu2ztujDgZ9cwWBeBB48Ynv/gEoi/LXNcymP288JgJqKxmyP0vWNFkK5PJccevPUe1DZ6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Koxl3+wE8kjwWiiKXyBTfn1AEv4kK22AitsM10zqgxc=;
 b=HKOD4UluktcAomgZY//pTn0oI2eG5HBDtbh7+8+Z0nO25CR8hxxRYVOMilTQ+xNFbXEJiOl5+tAgxaODLVdm9hl+xAJYm7xTYfwvBfP1Q/YDmFO52Sf+qoBwT6jMHEK6Y371Yf4U/yRPLEZspq7WOixz5llWUIZ10D6FNXR2nzQ=
Received: from CO2PR04CA0185.namprd04.prod.outlook.com (2603:10b6:104:5::15)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 07:23:49 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::73) by CO2PR04CA0185.outlook.office365.com
 (2603:10b6:104:5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend
 Transport; Tue, 16 Nov 2021 07:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Tue, 16 Nov 2021 07:23:49 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 01:23:46 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>, <equan@amd.com>
Subject: [PATCH] drm/amdgpu: support new mode-1 reset interface
Date: Tue, 16 Nov 2021 15:23:37 +0800
Message-ID: <20211116072337.29600-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a324d7-72f2-4f25-5c50-08d9a8d208d0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB389552354498D07A24B76D68B0999@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2i5VF/fhHcXbpy7CJn/BONV5B0f9xut153/lA0VZ5CsrZgldbZeZ59AHaI2qjtW3dygBD27YrP2KgTst8xFrUrOQjh2mC5BQf6eq8d59gwwpgvrSe03pjmN9Ut5Y3jYUJgA5XxPmRuP/iM9jTZ2Bi1kR3egURKMzUN6SgVjLC2930rAVIRFO9UpdMCbyqhEU7HRGmJEYeQRAWvviUSFSWG0BwS7rvKw8VjJRy2D+nnHTKSv8JNW0rrqpF7l2pcWdfAXzTXQ0TIGixMu+01nbjCL9AIGrFegjSTmV7eGiez2CYJP6uaO7T+p6BGrs06GgaVWGk2wwYuF+QYjkQjQZoufaR1EZaKYUejjROju8Zas0iAXYxD5PQcO70l/WlCQX/QZXNrRUHK46yvIoaBg3TdE+KFXcDxXLICYJQu9OSGKie3Swy9ko7WWjGPZ+4P8p8Z1OVIsKwLBLUeUOPoryrDZirJXoTL74gwSp0lRIAfM1k8E4x/D6KJXCNnvun9IcW8RH/L0ev16j9mygYu5UVJ5CJjTpEc6MFg7tpYmkd1rF5GqZZ+lWNCKmHmSGY7sYT7UdYG4zHx9hSW2V31bHeT0VM5rWCkbInl4T/DLZNeJj4/S4fsRjLQZcyje2p3HGpBXNYuxfq7g/clSlKs4HkqRH5+i5dD6KbPzV+lVPZztu3aVkReboSYuKM/bPjIoqbLI6g8g//cD0qxWSw2ewheS/Feo1+F5TuRiNPOBarHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(70586007)(2616005)(110136005)(8676002)(2906002)(36756003)(86362001)(5660300002)(6636002)(1076003)(8936002)(16526019)(186003)(26005)(6666004)(426003)(47076005)(508600001)(4326008)(81166007)(82310400003)(356005)(316002)(83380400001)(70206006)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:23:49.2448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a324d7-72f2-4f25-5c50-08d9a8d208d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
reset message.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 35145db6eedf..6f3d064a8232 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1426,16 +1426,31 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
 
 int smu_v13_0_mode1_reset(struct smu_context *smu)
 {
-	u32 smu_version;
+	u32 smu_version, fatal_err, param;
 	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	fatal_err = 0;
+	param = SMU_RESET_MODE_1;
+
 	/*
 	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
 	*/
 	smu_cmn_get_smc_version(smu, NULL, &smu_version);
 	if (smu_version < 0x00440700)
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
-	else
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
+	else {
+		/* fatal error triggered by ras, PMFW supports the flag
+		   from 68.44.0 */
+		if ((smu_version >= 0x00442c00) && ras &&
+		    atomic_read(&ras->in_recovery))
+			fatal_err = 1;
+
+		param |= (fatal_err << 16);
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+					SMU_MSG_GfxDeviceDriverReset, param, NULL);
+	}
 
 	if (!ret)
 		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
-- 
2.17.1

