Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71366EE0213
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E107610E4E7;
	Thu, 14 Sep 2023 02:02:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E169F10E4E7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAQel/SlrxuUOgURSdQplzLNTQUEyzagB689CdLCm8+GXMwwk49Ez8gUEXgZLXQR/9kiibzvrgfhfFBvOQuvIW8aWVxdlV4pRi6xf4SlNF7m/KAme8fiv23fN5n+PoqrLq0QDZJV5TZI83Ll9tmgZPvh6dFaYkJXbot+E8PyKiB+QyDmyXVnkWAWBBwct2azYImNxkjHZrMMM3uT3Kvg6yGJocJJXaNEf7FCfL+OJREE9GcxPEEsrKN+CobAhkoJ573BL4YPtsh70uq1v2Wi7vrFfCgdY2aLRfeZUw1QM3KuJo8El4lCPOtwoNiSEpERaB3Z03NXVTqzMJ03efTrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxFQD+2l3Q6yklM/QW4LSGuHcPGTthY2augZ1iqegK4=;
 b=QNr8qPHwaR0GK3YYYkPVUVtmnIy4wn8ntel+UDNM0vKixP1bw+4LVhWcjj/+p7M5mV+Cq0pjtQUMu3OESUV+3uCK84Lx58evY7SPbTeJdsh80st9UurOXhCcfoeWmobF6ZOn9IWce3JVfX9qJE/6vc1oQyIiFiOPnUDfhMv1v1DetTFSPaP4Gm5K+ZLxu7kGWFeYim82Uj0nVmYZmxUgLSvkcnXfdQMJMhLRg8LkTDrh+qR98dVsk6DLcx0Ek/U+8w72qMWrr3CyvmIDVnQiqqeGX2V9RK8gmL+4bvmnT4q4QS9iKz6XcX3mXZIL74CbtIcOEbu4tZ3g4A+MeWGUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxFQD+2l3Q6yklM/QW4LSGuHcPGTthY2augZ1iqegK4=;
 b=ivMGg0mQjNFORFHXUI65UfG3GeKjk3TP+zE+W/GyQSevAZRSfr+HgB8JbK1rH2do84xHgQPa0PdGflKCNFWluNg9VPNoGxRKS8spdZC3JJKQy6KrqM2hSc3mn2guNqrY5rGP7pqURpc8Tn/AEBEyyw4CEgpZ+CFMlScYmp8b/1s=
Received: from SA0PR11CA0048.namprd11.prod.outlook.com (2603:10b6:806:d0::23)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.35; Thu, 14 Sep 2023 02:02:20 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::2d) by SA0PR11CA0048.outlook.office365.com
 (2603:10b6:806:d0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:02:20 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:02:12 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/28] drm/amd/display: 3.2.252
Date: Wed, 13 Sep 2023 20:00:21 -0600
Message-ID: <20230914020021.2890026-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6ad05f-d34b-4a40-a32c-08dbb4c6a12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXBmO+G2ByM/aeeM5pwmFcttpLqgr4aq3pH2dqEm5XQBlJvwx9e6KaJbDOsS5Iycqh+Hew718kkNbKpDRoVSs8FHH1nr4MPG9ZseSe5CEmuyJIEL8wFAHb4aB8SKaOc2FVoLQ5EUiS6lrbf6UYKiWMxRs7urM6hKhph0CW0cOOjizMAjePyc428XNsNftQnmmsO6LjIVgUvYPBfUgxjYbz87dWjzIWTnebRq4/8V98GkyL902eDyx63n4nYG+iMy+r0Od07FBpTvVzsZS1M3NbzX+iZ6MSFEj+FL31Y5NTPz8r6ue/8mGfd6uFuUnRhVknGqLRKLp3TyIXsegl2KeySysdj1U9fjmgRKENv6f1achaEXrf76WHQFAMJBQP3lKZ2bKjoVFkUTv9IbY7CtolA5fDwio/U56LAmekzAykGvL/5jjZCLt3kKkMVx2XxEuqLMz4gbrAL2urBdYaXZN3s26uTghpS8GurJowhkWcwOvDJmZNUHdsBmSVICBuf7LMBHvxF39y2MlojlLUTPHAibNzLW8kY9z1v/qi91TtHJfEI3i8LAyTKxL0zIbR7DvBeJXAISayVhZkoNDkeVNzfKtB2DaMfhJ9hZCpifnH5uNtN+qS5tSMgDrY1iC6xfnBFqvSrn/Kmq6/9us1F3TMdqIj9SvGBiP6zuwlvQ8+huE4+lbb3VS1RGjpkzErumkcXbcVzuJ+n5iDb/k/V0frVv4TmYo1JzFIG9CiK4ULGFw6pYghv+Qyzyv55JQZCJ7/1wL9TzpEWbN4igWmRicw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(5660300002)(6666004)(41300700001)(426003)(47076005)(83380400001)(54906003)(1076003)(26005)(16526019)(36860700001)(8936002)(2616005)(316002)(70586007)(336012)(70206006)(8676002)(4744005)(2906002)(478600001)(4326008)(356005)(82740400003)(36756003)(86362001)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:20.3300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6ad05f-d34b-4a40-a32c-08dbb4c6a12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- Use optc32 instead of optc30 in DC
- Optimize OLED T7 delay
- Multiple fixes for MST, register mas, and others
- Update driver and IPS interop
- Improve z8 watermark mask
- DCN35 updates
- Enable replay for DCN35
- Temporarily disable clock gating

Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 48021d196484..fd5040966ba0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.251"
+#define DC_VER "3.2.252"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.40.1

