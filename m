Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE2BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCEC46E0FC;
	Wed,  8 Dec 2021 02:55:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74686E0FC
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELqiMtZJLv+i3ff4PbHy5Dgfq7Hm/emtknRq9tzH/gsmvMWeVmuVm+GNeO+ZLXWtje/tgjLbQUlBOVVOXRvi2m+Wnla56QBm7klUCJo7YHeCmhWWAazILyM2crubkPhthdT0pgrZiwgougk31VbncTvR1wjRjpGDq96dlJJ4mt/XkmAmayjFhqAO0HegD0SHCDgH9y7b7vdua1xHrlPiPLs7ezRApcovw0EI9olv7G6oaO5vyOQAAj51p/DDLqhfC58JROrnEHX4sYtU/6YRzPMqaGuyDQBn1S0MXD9Iq7CDFBa81CVGqS1g8WaFVLUaUlXTW+G+hq98zyRYQCDdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MfjYgF0ypgx6flass/YqByCUCeTuOGNfFNz56WlbDQ=;
 b=I4m3SDxK16rBdgPIAeCc37nybb4Y6G0qdSEsFaylVc14z1e+CYVCMt5qV/dbvgydKD5LnyhMQMsRsaPmU+vSMZfghrPOf1FzZFIo/h4JIphzwBaM83Vc9sAX/jZ9/+TqRrAOCvK3UXiAA1BEB2osEXin2MU3KfzSgnK7xrgWUl0Xbbbwji4sD32flH5UnTAaZuaeqd/v3GvhcmXY2a8fNIspDo7NERraTEWigev5YSFMFPIAHslela+EzZZPdt+KRL21jqCL0lw5SgWBI7hbChJW5vshFwn8EIiYEvOP6PcrOqzDL1THupREmjMUnPqvo5NAb7nerhH8vdSQCLWI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MfjYgF0ypgx6flass/YqByCUCeTuOGNfFNz56WlbDQ=;
 b=AiPgf+bOEIlWdoZkwcdt6P478vSPPsPcBsK0nvNHMDUMoUKDWpmHJ7RKmrqhfBfRuUPUPPDTHTnipnzl8yiBn6UantzogixYmEU7d6sKu0G1EhPxn6a2b3fHggF9+PdSsFNr67mFf7kcUScsALmBP+4J5RWPEv0Bqk2HMcTn0KA=
Received: from DS7PR07CA0021.namprd07.prod.outlook.com (2603:10b6:5:3af::23)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Wed, 8 Dec
 2021 02:55:13 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::67) by DS7PR07CA0021.outlook.office365.com
 (2603:10b6:5:3af::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 02:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:55:13 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:55:10 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: drop those unrealistic thermal_type checks
Date: Wed, 8 Dec 2021 10:54:50 +0800
Message-ID: <20211208025450.1814289-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208025450.1814289-1-evan.quan@amd.com>
References: <20211208025450.1814289-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccfdb8f2-c6b9-4aec-6aaf-08d9b9f627f1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4890:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB48904D6C04FBD1E3BC3E7E3CE46F9@CH2PR12MB4890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ht/ltKikf2mrqsoLLqiEtIdLeHEx5cUzr+GzQLR1rzAxsuabTes6yuGLLD5F7y/WfTgSNzh4UmxRXIRP++OqG0lK4/sDToLO8Tuoj16223SwFcCufkCGRnYVVCYmHJmMvuUr4R3pjguNMJdXQ5Xft5MP5Z2y8kEzWv3WXCzN2TzE5BaWBHimJYt/j6k3UR2TqR4EShqm7GZz0n6lXPM7cT09zvO25kGlBRVsAR7XjoKv1KmypFJilpR8hCZehE/dnfTrtdwqxCFpiWHa4rNhc2VKjRSFJgALgq6feQqIVkfmkLaj/RE4GXP6zqTliiYzmlplFdM1DvlkvJmJUps4eMeK8y7DZsgjt8s4FZhpqOOLwE4xZi5Xp0Hg8zssU34zRAEXfs2yFPGSUQMaCo20bodjKU/puf7mqFfe8MDnQQG+csz+E+GvBNhsyAsxrNlF/GqHXgRMezNKxJu2S7XlXunPigpElBlyFE/vbxDKxmSMfciZo01Ws1qU3iUIgBVV40j+l0SI81zpkiEW8kiUSRxKm+7h47VocIk2ZEIm1CVIf+wl+xWGw9bM/0D+nihMwaOTRRBinIZ8AuljgBoG5ZX6dQ6zIhPWZERcqSRX3IylsA5gz4jHp0bZ9tKmQYdbRQOQoBEoSnLP9x2iAAiwtPYgFHBQyVavFJKfmo5bA587DhwQEUHqtQ92QP2ud8M7jQ6JX4Y5qlFrLDOw6lJ1byPgsKQDDr2WstAn0D7TMZFW4dhFED/Rjhj3ajvovsqDoNnOHtfRBebjTgsp0mxKYvmSU2JpWmzMCPZV4duCQhc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(44832011)(83380400001)(36756003)(70586007)(1076003)(54906003)(36860700001)(336012)(316002)(86362001)(2906002)(8936002)(16526019)(81166007)(6916009)(5660300002)(8676002)(6666004)(26005)(356005)(426003)(186003)(7696005)(508600001)(4326008)(47076005)(82310400004)(2616005)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:55:13.1924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfdb8f2-c6b9-4aec-6aaf-08d9b9f627f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As it's impossible the thermal sensor of KV is one of them.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I52783cb50f037df06f76fbab997e0dc0fd445203
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index b37662c4a413..8b23cc9f098a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1260,18 +1260,8 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 static bool kv_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
 {
 	switch (sensor) {
-	case THERMAL_TYPE_RV6XX:
-	case THERMAL_TYPE_RV770:
-	case THERMAL_TYPE_EVERGREEN:
-	case THERMAL_TYPE_SUMO:
-	case THERMAL_TYPE_NI:
-	case THERMAL_TYPE_SI:
-	case THERMAL_TYPE_CI:
 	case THERMAL_TYPE_KV:
 		return true;
-	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
-	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
-		return false; /* need special handling */
 	case THERMAL_TYPE_NONE:
 	case THERMAL_TYPE_EXTERNAL:
 	case THERMAL_TYPE_EXTERNAL_GPIO:
-- 
2.29.0

