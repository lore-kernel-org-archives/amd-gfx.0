Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E5BC761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 09:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F9010ED5B;
	Thu, 30 Mar 2023 09:00:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3298910ED5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 09:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKDJY2M5fWgz8GcJMXXwd+/brKzSHhQfxrc+7Mm773+2jISzemToJUfgUdx6jUYn7fWBWBUSLHQghC/QSocSbVc7YgbqP2bvNxSatzpTa+vfubUpcrI/yZYq19LR7DpKJsVGjNgD5Am22FhFcSV+EKMTdrI1BX6ZdF2YwMymeJ9Phcs+6fxrycv5+qWlSGVTqrc+6TzLYffGVYE/sP0fiWEMo5LUNdO6b+v1wMZaXMcuy5n65SvfegrWX2RBPIFfHEw9OsD8VgWUKwduaGPmlVTMq186dmtpz6VSdlBAU1qdrsptWkoxpiYbfZa6PIVKoxeqbB4sZjM/bamMeRPOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdYSQ5lN4Oy/Iwc+9HUcrkK6Bgu4R1u3G1TS5A91CQY=;
 b=LC7YH1ENKe6YGqGbnZ3+saVoeLwL7elm5ZSYUr82ELhXHNKUatBG/NBzw2cBCixaN8+ZvIiBFVZ45z/5GIc7K60fbv+QizDTg4AuovzVKIf6k8LdcEhamRBKtuBpIhep+9cMT+NqlDUozeYd7dk9iurVQJYq2uByTMEnva9B2GKyQmBfG40J11L2F1mPi1fp2dp5G7NTs8OL8KMs2Jv82G7w7ZVbtENhoF/F7ArH57VNEft5KQuwxsx2f0OmTm4NnjRRunusoAWo7Cq9c8x9MFqeUupQI5poNMkqLWcYJjGaJU6mGBYXlkzF4NUyaSdPz6YArHqedaRQlqsoPYXiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdYSQ5lN4Oy/Iwc+9HUcrkK6Bgu4R1u3G1TS5A91CQY=;
 b=lkEGsVcMF6LDZLESFHqOCqTlnvIRALxNJ9Vj7NgWw5E/uX30S80dpr9Ykkhu05lNq8nmahAUNinLHTV6h1ytrtEGM/SKDsnpr55ZU6Xc30iSSA3xd/wUINMPL8q+mT7y0MoccHmOt3bqJ62itDx8pOdjxrN0Wl+6EqhiT4W0pfM=
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Thu, 30 Mar
 2023 09:00:24 +0000
Received: from BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::de) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 09:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT072.mail.protection.outlook.com (10.13.176.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 09:00:24 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 03:59:54 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amd/display: 3.2.230
Date: Thu, 30 Mar 2023 04:57:20 -0400
Message-ID: <20230330085720.3863-11-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
References: <20230330085720.3863-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT072:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: dfeaff84-f1b1-4f6f-67db-08db30fd3303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duulZ7UctHFXZXJSion+AxJX3zUTiM67GTRP2iFPoIh2gtHdM/QRmPAjgUw9yGpQ3ccVMRHTalwFuf6AdKDgBUIkuYlJe+8yEPaFW8u3F01rr+JUNATRYMe6UHl1JYXkpM0Bk2WWIQIddEM2eFTfQ/+x5VtV0mQROigFCVSaKGp0T+67c76E/2AJGCCgvRAD0jP5eHOrl3iOroQ+cB7NXgtXwdzYNnYHTRINCCTogyD9VWyzUBmVsCJH6UGh/1FpX3LfX5nJDY+CT0hua4kPBhMVRNLHzEwhi58VKJtqHrebnba8rqNYQ/mDHEY2+1knDy9SOPxP2NtwIuCiMnotGco9p96xbnMFG/cfZB1krrcEFQqbF4m0UAFV9Kkhec+e2+VXE9jIQwHAAsL5xvRJ1lnJaHgjwcdWmL58ktNsqaP9T3LNZ9n35rK/0wDoug6G2YbIeqUxBangMN+r9oNt8PwM/RKtpum4HII38qMbhzOOm0wFYVFSp5O8wi5EhsRojHBklT2EE+qxYD7ydbBkCtzcVnj2l5vvyyWMJmaqfnHjbFDhcHUcsrfFjZ6AEy20XMt6ZP+1opa4vkawgkd2yKGJI4sctAZrp6bUazom+y82D2kDAr0k6ZmAdTe2LFHhTqx+oXZZXwfqIXy5M6fZyhU6Y2c7EG1J/Zlt+tTgF8JRzwLcjVXZqWCNX0FOPHcXwTS7YSjaoatklQ/+eNSPHS8fJ0ENcj0TRTrxogC/fL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(70586007)(2616005)(356005)(86362001)(40460700003)(426003)(40480700001)(47076005)(82740400003)(82310400005)(316002)(41300700001)(478600001)(54906003)(16526019)(70206006)(36756003)(36860700001)(336012)(186003)(83380400001)(26005)(4326008)(6916009)(4744005)(2906002)(8936002)(5660300002)(81166007)(8676002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 09:00:24.3308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfeaff84-f1b1-4f6f-67db-08db30fd3303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This DC version brings along:
- FW Release 0.0.161.0
- Improvements on FPO/FAMS
- Correction to DML calculation
- Fix to multiple clock related issues

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 190e6a2e1334..23ee63b98dcd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.229"
+#define DC_VER "3.2.230"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

