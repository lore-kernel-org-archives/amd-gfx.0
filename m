Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF54C71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 15:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8DA10E381;
	Tue, 29 Aug 2023 15:25:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743B010E381
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 15:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vovh/iqcGpsfWaETgQ2KIEaANyZW7j/mVvn/IgPim4jbU9o+lDsGHJik1meKu3LSMv+3eyd+YgfNxfFK8gdb2vXxphE+QVMod+pkXjL3sIEgWy2UlR3tW4KOx0Ve1DlsXiKqyMdUbYWQtgw04+lR2SVYqszGeYxiHqQW1QrpfyPMj0LAds0NwmyxZD5kJynVQwFlO+Z5Wxt5O2LR6Hh++AX93CdUMtSsVMySLaKF6mey96J4PF4x7rm+LmednopvRgmvZc3LzpGki0sOxsBoWZIrUQsiLsuZz3LDDPPyWbuZGfjm2kEAOZTLUuKMEn03+bNaBbvOvwM+K8wTuexnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iC3KttEW5Wu8kvAoHAbr2jLObaf4tEzkVqkrHmu1RY=;
 b=RULvPVljeWD3cI7+8V0DqA9VpUWiXhNWSKU8eclxkZq0RZaQOeLgEE9DOPMxxLU81hnAW/4CVDTL2R9DRT1c5Nxydprcev3H6k68NSqbelH/biM5PUfw0C9qJO06gI0kVA4wIUf3zSu2HF0jKCgZr6k/NCuaS+SD4+fALEURVfyqIKll0ku35MR62F1Nb5JjbcAyqwzTR87+mZtbSoyUU7MR8o/TTnaMCh9X2wxjvfXPpTrY7WdJRpheE6w5gCLXjq1e2jBB4Qb8KgMDwzXl5h0aUBCDjM717Wa5zpzXSMW4lcUyotTC5b7kSOznX7KnVlJphKJYk5+sOQVbcE3vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iC3KttEW5Wu8kvAoHAbr2jLObaf4tEzkVqkrHmu1RY=;
 b=yjxlFeIV4FO3e6ALMlwRYzCZX0Pm7evPJ5JTo1C3owoPuxRtnj46dRZ5nWFaURrmH5Cd068mNaPS/UYeWuag9JPgmEc67OuoLue+q02tbXiq+lWVgcxBfclCdSakon574+I+WaRtFP2Q74CwQrD0gefninjMfQy78lPrwZHmVr4=
Received: from SJ0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:a03:33a::23)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Tue, 29 Aug
 2023 15:25:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5a) by SJ0PR03CA0018.outlook.office365.com
 (2603:10b6:a03:33a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 15:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 15:25:53 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 10:25:50 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Date: Tue, 29 Aug 2023 23:25:13 +0800
Message-ID: <20230829152513.30544-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|BL1PR12MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: ed17e6ea-c1df-4c9f-a2ba-08dba8a43c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xUicOb8Fz3QpCc3JMS1xa0gjsh3Sh+7TSz6TFzBhSv963VH9dwRTbk539UzUMNEtoPEEEZZP9K7Vl899AHpM1WSesM3MOJtVoNGpme4Y4MmqvSo+v7QG/ytNenrOxlNom8nQrEq7Pn7vlZGq0xtxsc7qxp008VK0khR57I8euIQzkXNqb/wIZ8mnsmADmaCIYnKKLEY5k4q7GdEL4gqdwy0XyEvNNCokzy5SV28ZWqvm9lXq9srtFtq4fZpDx6kwDW8OLz65YEQAbmo5i6L/LN7Fznzz7eyg9JorbdAXkBetMTI3pifzws/XBo+dzJ1mOur90NiPm67gQDjuS7XyFefLhLAR3735sXtAhJgtLp/UfFtTyJeyfWVJLz3i4nvcmYXo84KMSqnhDBVVigMwGQSvP99urxlgUzKIsXCS66T4wcdLtdxYly6/9Ecx0ehg9G6lXckW6XeScN7mmZInbnqaWiHCofgbp/WnSGeqMG3w/EK1t1uu31dnp+Kj0y39lXkVx4d9xOpd09LCAhi7kRSms3Vdo1S1PJERDy3+Lfp0aV7Xf2hFmpL6HDYpmMZi7neaEtllMkmZz7HpbfPJh8CNnDvqo+LmPJF9ptYr1EwmZ4otMOSCHm27JVYcPZQlvo2c1B2IssDi9loH8gPrmUKnij2ENRuZdeoSVpociYigaE/DFgijqjcomJaDXzGCW2riy77AajJ2CkXvDHN8f842HK1k7K09JqUBtUZMksDIpi2VmJVFit7H7NG4s5tOIWW6+MgRu/Lna/ZBkcqaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(1076003)(2616005)(110136005)(6666004)(86362001)(478600001)(81166007)(83380400001)(47076005)(36860700001)(426003)(336012)(26005)(16526019)(82740400003)(356005)(40460700003)(36756003)(4326008)(8936002)(8676002)(5660300002)(6636002)(316002)(70206006)(70586007)(41300700001)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 15:25:53.6337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed17e6ea-c1df-4c9f-a2ba-08dba8a43c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do not access the pointer for ras input cmd buffer
if it is even not allocated.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Stanley Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e47600a8e88e..8eb6f6943778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -764,7 +764,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	union ta_ras_cmd_input *info;
-	int ret = 0;
+	int ret;
 
 	if (!con)
 		return -EINVAL;
@@ -774,7 +774,7 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Force issue enable or disable ras feature commands */
 	if (head->block != AMDGPU_RAS_BLOCK__GFX &&
 	    !amdgpu_ras_is_feature_allowed(adev, head))
-		goto out;
+		return 0;
 
 	/* Only enable gfx ras feature from host side */
 	if (head->block == AMDGPU_RAS_BLOCK__GFX &&
@@ -802,16 +802,16 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 				enable ? "enable":"disable",
 				get_ras_block_str(head),
 				amdgpu_ras_is_poison_mode_supported(adev), ret);
-			goto out;
+			return ret;
 		}
+
+		kfree(info);
 	}
 
 	/* setup the obj */
 	__amdgpu_ras_feature_enable(adev, head, enable);
-out:
-	if (head->block == AMDGPU_RAS_BLOCK__GFX)
-		kfree(info);
-	return ret;
+
+	return 0;
 }
 
 /* Only used in device probe stage and called only once. */
-- 
2.17.1

