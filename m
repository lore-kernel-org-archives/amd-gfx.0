Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86908C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 03:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5EE11B9AE;
	Fri, 10 Jun 2022 03:52:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08C4411B9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 03:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKSrJgtitMnEjC2M/+BWiO+LG+5mF4cOse8BbAayIAWtM7OmMBhbCUJg2PVw0S9KjOUhKgXuxcG5KHkHmVK8bOcc6NqDvDWN+RE7KxAJzcjnscrVhTh/Kc+iV5rO00ISQMN297bSbRaFwnit98Dw360s4Lhd5zk+vFh3yYl9kZQzJIVtK+ONDXX1XEfUyTEO0kjEYCk9gb27amU1T2vrcOPLlkskCnUy5f1h/iLvi7y3hqfdukTuOQNQcJISjEZ1ZjUcXBljjDaf+MB4VFWdzem3yVmVTNKoMP09LX22StW+45kGt6Akda4xsXz0Ku9uijlyaqx3Q3d3lvQs90hQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6ng2U0TKbjxMrJ+8rFuMvjjZg4/DmxKboRANoWbhNE=;
 b=OGtvE1y7AWnVO98TXNg/epZ+7MfHVDtwpojIdFay4MdBuR3Bb0MUwUp3DbdUI2otlvvB8SQLZnfK+TftVOT2HQivXD2JYLG0ST51MZFRtyT7i0vYs4uYMAAAmmrJOsMYBbz9G4DSDwcKMpzx5lz8CL5dtvBmpoYxdD2LzruXQ0BgYh3qvi6jSUjIt1x94q2M9X4oqEFUEa3PgR6ve/6YGvdrt6GxUVFk60t4QQ/1Pr+92OIlindjGEVB+09fMcuELrh/veK04PRr20E6Z30uZFSsYpzJHU/q1rrQVEfZZjWGJR/yN3K5rPwUUetJQX4ZBA+7Cd0darehKcEq6aY7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6ng2U0TKbjxMrJ+8rFuMvjjZg4/DmxKboRANoWbhNE=;
 b=DiJgVFzmS/wWizmQkaD3rY7Q7JpLpzo/CQcYVNwKBdSmmtv+m+HbEjl2n2GUT4HHG3dgMDzIBp/0RwaVPUNzBjgR0QGE5FSoAkRy8+EUmONTWCHja1q0A3y3z/hxMvhbrUkdbcUOI7Z0rP/7XTI//xeXgBNNkrrLFgRUmLcAS2Q=
Received: from MW4PR04CA0179.namprd04.prod.outlook.com (2603:10b6:303:85::34)
 by DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 03:52:26 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f) by MW4PR04CA0179.outlook.office365.com
 (2603:10b6:303:85::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 03:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 03:52:25 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 9 Jun
 2022 22:52:23 -0500
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: skip to set mp1 unload state in special case
Date: Fri, 10 Jun 2022 11:52:12 +0800
Message-ID: <20220610035212.3514499-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb903db-d465-4c7a-f662-08da4a94a1ee
X-MS-TrafficTypeDiagnostic: DM6PR12MB4732:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4732D8D859DF0C3BEA088AF882A69@DM6PR12MB4732.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aLTlmGV33WbcxHWfMoFQd2S7H7bWTcrBMM9o8JDzPHuHoaBm1gxNSQ+Wow6j7IQDSQfYSDc++fvFXQwgeJHuQH0WcSvmngRdsW/RzM16o5yaKDo2UugLDV8NDEp0zBa5WaFd0yb7TNeF8T4ei0yujHVFU1FtpMfUYFgYaBHHTPn7D1E2o2fH2ujYouzoT9oPC5rprJN02J1bqFFChceWqbxOEHjSqUVjOwExOgnnT9i47tPYpzskxLCOJVPUXtvvvyyOa67hXmzTMlp5fRyl65Tdc2U3+BhcV58b7H1wRkiwLMAt4vrLNhz+CXO2so0nsSVW4I4KGtwN20dq8584KARVr8DIoobevptCZT27UNrVcRUO56zSPcQq8fxHKu4asWfXuaVQkz8Q+CKkP+vX4FerqLKtCO6gbspoCIvGl17LiSq+C8UPqiiZQM/xY8cToSek142ZcOWg5JWpFoLAcvXCs6whPqYOwJIu3KLeOJw8e8HSnN4MSVsf2LdOWQ3s5a7Uqi4dxH7ATawqvaFYRiUOuJBBCXL/mHPJcuJayl2nitAX+K+x3CYiXP/WmLSANOnFz1/Aw8zj+LmyFficJrys79wEvpPTXbXECzQZrxKU/HMHujCkM2T012/ePyJtKQ1LG8lCg+UbwtvMNqGqN6t+PCUxQBWK2/e2zDrCJmbeeJ0ngviG3BizyKoDyIAxBkd4xDY/Cv4vEQg/k84yig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(16526019)(82310400005)(6916009)(54906003)(426003)(336012)(36860700001)(83380400001)(36756003)(47076005)(40460700003)(2906002)(2616005)(1076003)(86362001)(26005)(8936002)(5660300002)(70586007)(8676002)(316002)(70206006)(4326008)(7696005)(6666004)(81166007)(508600001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 03:52:25.6879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb903db-d465-4c7a-f662-08da4a94a1ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4732
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
Cc: kenneth.feng@amd.com, Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

set mp1 unload state will cause the SMC FW can't accept any SMU message,
skip to set mp1 unload state to avoid following case fail:
- runtime pm case.
- gpu reset case.

Fixes: 826126d8f805 ("drm/amd/pm: fix driver reload SMC firmware fail issue for smu13")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3d269d1c2749..fd79b213fab4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1415,12 +1415,13 @@ static int smu_disable_dpms(struct smu_context *smu)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
-		ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
-		if (ret) {
-			dev_err(adev->dev, "Fail set mp1 state to UNLOAD!\n");
-			return ret;
+		if (!(adev->in_runpm || amdgpu_in_reset(adev))) {
+			ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
+			if (ret) {
+				dev_err(adev->dev, "Fail set mp1 state to UNLOAD!\n");
+				return ret;
+			}
 		}
-
 		return 0;
 	default:
 		break;
-- 
2.25.1

