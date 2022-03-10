Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2C1C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2484210E98F;
	Thu, 10 Mar 2022 22:22:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F0E710E98F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:22:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3HM2kzY1lIOjb62jRnDujXrQWpQUMyzsFfTM8Mpw9VBQWHQHnMAvLGAwLnMbk1epyC2Q5cEIR35fMUKZc0hYCGf8lYiM0sksmP5fOO8v/F6aW3OvAw/4eFJyCCCtE8vg3QmENqyRQ56XQE+W/szSHbrd6W0wypikCzyPcuU5E2h3rDRv0iP32r5oVW9nzF2F68RfJt3sVyxsDN/0WuAtwDJjqMs5Q3pnhYV3t9PQB1Vi9UPdrL45I+GAjIobT56veK11aT2nFfWX+8T69UJb+tRcYf+k9fESkawP7FzdP1W+xOqwHDZDisfxzMd7agwFuCy5XpcmNQOI/5IRB6HYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnA0TqfZsYSkBPNs0X626lknWgFg7wXPuXjgLbgB6hU=;
 b=a2icth5vzJagij6cnLvxyqv82DVh5IrRBr7HB1bMm/z4lveTsS6uBZLQt6BH06ADZ4BWeA3LmGZSapoS+OSqNHUuGl9XS4ygL9Vh4yINa+SQM1F0PXLOTUvdgo4xP1DW6cJIvd8Op2FihR3mh3vxWxNbX+1Bpd93LMJ/6A1lmhzB4XormtDgruREjBlVrwGMg6puJ8P7jeWbKF9kIHlh0JDDz8MwjEeMMS5nK5WXOqsN1VnT3AxBDTkBT/s1QnAYRJdz5tr33yLtNfxG7zh/6dhdQoucEPCHuYKPuW1eB5Radxvcudty/9V0f2cz+djFO0u1Cz1SI0g8Pq1vG6A2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnA0TqfZsYSkBPNs0X626lknWgFg7wXPuXjgLbgB6hU=;
 b=2tje4BqD+dVsU9HFi+Zz3jula+8btba0XQSd4lert2cwjbU243tQjs3FRI5d3/lheXqFJUVC6VqMRfH/8mVn0RiIiZG/TGsNRYwIcmlBIYC5So1gPy0E8PHOZSbmQpfYaXE6is90BeevLGOcq/hLNUcEvnLmEg1RaoeqSAUkuzI=
Received: from DM3PR11CA0017.namprd11.prod.outlook.com (2603:10b6:0:54::27) by
 BN8PR12MB4772.namprd12.prod.outlook.com (2603:10b6:408:73::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.20; Thu, 10 Mar 2022 22:21:58 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::f8) by DM3PR11CA0017.outlook.office365.com
 (2603:10b6:0:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:57 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:55 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: 3.2.177
Date: Thu, 10 Mar 2022 17:20:45 -0500
Message-ID: <20220310222045.664867-13-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e74bde62-f3b1-44a0-c027-08da02e4640c
X-MS-TrafficTypeDiagnostic: BN8PR12MB4772:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB4772B7C892F82E0B0B18D33AF50B9@BN8PR12MB4772.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/NJwtsH2Oa29I0BZKvC9KcPldn3Koe76FQ1qdJqkPq6OUi02aTvfibnXDR0WD5nySNddoX7sqWeRUFMG6dHjT2jhk1UlAYYnlvCXj3+hwY4e9tHIIJ26LPXhaJ+cdcgSKqkHIU2JV+VDlUSNlV8f9ryV/c7c4Y76umY18BjXYI/Ft7SIufc9jUZ6pyZ67ZY0dnN16s6EKPNVjRT+MuMrRcRvU4Q1pl+BQLSzM/igWBgKZh++AnCiRUyi2fPm37/Yg948y9QBmEBQ7JXgeTlM8XJI+ZHFUEposP9RyzhCrDaVfM2VVA6/vyGlTEnQcvqg46lkAnqsIgbIgf847S4unKpBG/AKGtcNzZD4oy1OUgCHu4NoKOhnXCUlykP0A/+l9rgGwWhXTv/9YqFgTTR4GEMd3Nq355+SPbwdjrb38zLSYqdQJfyVzL1IdSUMn4jjSV6DTzD4YWbdgFOxIB+JLX32T5dDqH9Z+ziERxvS3+7E1QZTjWHlsMaTcDKYuS0yy4wwRFXrqxYQk7qAwFIp/LNmHM3CTJIq8y++k1QtafN9fMhzuyuYIYO3GjR/zyZzAz6o19/MKmdb5Sp5qwSSky/LLGkYZH80HQFr+IMCBOmjl7n7aLM8CrRQJgWS2wzilsvvgMLtDLt1/p0ICGrNXn47RUWuCUUwd+Gpk1K3YnPCtZgvNdiTpSRAiGCLLltIC/yM4CUSU7RktFPvyq6nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(8676002)(36860700001)(82310400004)(70206006)(316002)(6916009)(54906003)(508600001)(4326008)(6666004)(2616005)(47076005)(70586007)(426003)(2906002)(8936002)(336012)(5660300002)(356005)(81166007)(83380400001)(1076003)(36756003)(86362001)(44832011)(16526019)(40460700003)(186003)(4744005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:57.9609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e74bde62-f3b1-44a0-c027-08da02e4640c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4772
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

    This version brings along following fixes:
    - Added I2C escape to support query exist
    - Functionality to get pipe from stream context
    - debugfs entry fixes
    - Block zstate when more than one plane enabled
    - Update to engine ddc
    - Reading lante status during LT fixes
    - Null point filters
    - [FW Promotion] Release 0.0.108.0

Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bd5f718a9eb2..4ffab7bb1098 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.176"
+#define DC_VER "3.2.177"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.35.1

