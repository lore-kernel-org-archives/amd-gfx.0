Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBDAC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 14:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64D110FA0A;
	Tue, 28 Jun 2022 14:51:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD0910FAA1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 14:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2fqtLve7tWoJbRH5f5J+jJIdbsTlIY6speSG3+Z2v7cU/r6Xpg4CX1vIMtTEN0pKU7cgszmx0pGKenZSsFRQzcV3yrjLH4sl0fMy2yyTUlE2z1QCiI3KIg9a3Db3FtYGyBpQSAMcOmnFE3ixGdEk9sd1xW+XWeDhwDhRMHvGzUrQCjPhbD2MZEK5Zqo4gkURBYR3K4eTFZNr9hHXl9jz/w2Xur6Q/iXR94651Pvl/vrXBO5fHzIhiPRCO8EjEQuM9R4eZMhbgvSLWO8aM3di3XwCeiRR5jn5VK++Snk1PdAH/0lfCwzaXcxLPM0FnX/XmhCoCj4VHHl2Vvc/9I6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfQqtJ5nSQdmPn88gronGKp+7twTAHAv++s2ndnjhvI=;
 b=lp3OlR5mJmI3IBOfERNYGE3ayCQ4r4a1rxDr5/Hxbl3reUAe20SAGHdrLkULoBcEX87l+5mkVwNLQ5Ghkh7EGXUDZn567Cjd9rR11YobTvJEB/zc0K7jswdOS+QL/9vp+uABDcfdo60ZV4SAJypjfq7GgcbUOwJVyE7sfsRfQpA387iHUSs8ECFC/s9d8VpsCk+AkcRA835r4Ow7MFznz2RUCZ264H27Ml3T+fcvhYHmCgqVhoXP79qVolBUwAXk6YJNu5FN1jkDDgrCNsJzJ/7Y+x/d1QAQ5fOgTd4t2QR/yogOTx+uBVBHygWhQ2nT0iIPa05VE8vpzWbHhCAVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfQqtJ5nSQdmPn88gronGKp+7twTAHAv++s2ndnjhvI=;
 b=Z7biB0VB5iTYvkv31sQ8/DqV9vhPTFM/l974SclX+nlDHXO1gVLjzvdU8N9ujhtmu75yQ9WO/7jQHFJeuaWhevqAbTuKpl1EnTWM9ensspFjVtUaFM8c/+XuRW8FUUbGYx6OlvzOvigsjYeK39nqbb9QnyrJKX0no2E+u7IBjl8=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 28 Jun
 2022 14:51:29 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::7b) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Tue, 28 Jun 2022 14:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 14:51:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 09:51:23 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 8/11] drm/amdkfd: Bump KFD API version for SMI profiling
 event
Date: Tue, 28 Jun 2022 10:50:17 -0400
Message-ID: <20220628145020.26925-9-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628145020.26925-1-Philip.Yang@amd.com>
References: <20220628145020.26925-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 230f9abc-aac4-4e4b-564d-08da5915aed0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5050:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kphimzYPabiz65B8GLtlCEZhGRd31lDoyzHKRA1ItR8WeJdjRAJliJP7QnqNQCk1pio8i5Ovvsc8X5d3TNHzytpcJdNr/NbG9KhDcRHSqjtL9BKbtuY67rwP/FXpzdQ4aZSof6ue9cwVZAfrSIVeBoUMY+NGyZKpWK94TG9JAVfLmzYmMu2xTiqsmtwJ6K9EnE5eHZsySqfhkxlCy2uD6XDs/JSgT7a9T13A97f+9CcC3q42j4AmWbG2kp2BQxj6Yhj9SHQRryb55l26NPKfi6pshFMKJlAh2vvLyPlvvvXc4Gk31bL3SzN0fHIEOQDQ4JnCWHZl5Nwc0hz3YHKitB/ovMVw2VyyBvaDw7hI3MluFknC/eCsrbPjLBtPirlbC1KuRbDMe0pqUjae71XfZoN1L1HLqbCLySG0zjFJYiVMVXSLgdFCp8gzdgOq/xrEhlXALKuQ4PxsHX9vNQ5/CU/2wQWtH5HE9IPZv4CkSaHDOX5FqsP8b14FdwgotvZD15/ueAA55XfdS1EZLNCtIDtsbngM4ojhBaB5UASQYd7kKFiJu16eEnI+/dE9FVOl3mKz/ThqJXgt3r30eejmEQbxs0Ck5fXFlq4DAOZ4duJM3apUJHxsL5tqXzqukhRmizyz1iC/GImf747VVGB3jPoCVUO5GYUE4iY6q3cus9z5VVr++lGgUzPrrScMBOHlxoswB0ixWvefkeMN+XIdUKgu/s+50z4ssEu/3+V2Ht1nP7O47arWzPkapf5ng6m+KUZ/bdC9viIHpr79wR6kfn6TGLjaoNojhiJStnce1cwQ4eg9ZYUtGjGYawvUCjzhlbFcwpZCQkE794wVWY47A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(40470700004)(46966006)(36840700001)(6666004)(36860700001)(316002)(47076005)(7696005)(4744005)(2906002)(336012)(426003)(41300700001)(6916009)(54906003)(36756003)(356005)(82740400003)(70206006)(70586007)(81166007)(82310400005)(8676002)(478600001)(40480700001)(4326008)(83380400001)(8936002)(5660300002)(2616005)(40460700003)(1076003)(186003)(16526019)(26005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:51:28.6702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230f9abc-aac4-4e4b-564d-08da5915aed0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Indicate SMI profiling events available.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index f239e260796b..b024e8ba865d 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -35,9 +35,10 @@
  * - 1.7 - Checkpoint Restore (CRIU) API
  * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
  * - 1.9 - Add available memory ioctl
+ * - 1.10 - Add SMI profiler event log
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 9
+#define KFD_IOCTL_MINOR_VERSION 10
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.35.1

