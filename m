Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9C6C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F048910E378;
	Tue,  6 Jun 2023 16:00:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB5410E15B
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeZJQZbDruHOFWA0pWh+Gbn3ZfZQEb3X0yZ1k9c+qjRJZYLlsbWDkPs+7xOIOFaYM3/05sTB16iVococ7uf+m6KuHl8UpK8AjnFgeNMFYs9QC0W59P+jJkaE+2WI+6LUODTC9i2J/zn122l0Fw2Hce9dNnuz6goJsgD8frT6Wo0d9RY9/HodWINGIbUkxdOQ1sjck0hdbyh2iePTgiejV1JZofGvkrBX4O/Gj6TfIx6dMhjk30PvIAsp5ZWvr19CHwPEVL1WxSRcd5BMZ41tZrr96dHjAvDkxh8CeqO6amM85aCqNqaqLVO2h2/hReoxpSfs5KKfL8nG/PWfCmU+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDFMlQ+pzDlDvRActCHKUTFThF3marVjDXlW0LQog3k=;
 b=O7EOIzFzwEKFRb3omm4R4xOG/9HxV/180xwFXEjJSCVbOBi8AfuIoJ4ymOZ8g1nbk41p5gEbC0mkpR0KrWQAbqkgcDq0TY11ShU/rnWfKTUZ/qCatjf0uCjeJ/o+MmqJF35MopVSouQVm7he8kWmQykTfz+XNKpw295XwCxAHokPosfJDqiaPCcNP6lE19JY7EGA4wS+6jZw2xM1/76avLfXdDxjKXWVq+n06+hJAJ7J1fWydkbBPO/MWSYB8XyNxTmkpLjiJF5GQNtpPFMXjvIWV4TuJYygTlIcm7fuYN9G0GECYLZzdwtQ4rxUaMYzlGKpwAKkmu6cTVQNLCSTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDFMlQ+pzDlDvRActCHKUTFThF3marVjDXlW0LQog3k=;
 b=Fv1cSyQD6HUHNUf4rB+1vbt3ZCufrtsbqjMs1pw1NLhXIz9Ng1fLfDh+/ODmzDA8J6XMwF4UbjxFpjD0mH63vs31wOm6y77Elr0mjPUGq6RyA5tOelnT/GfduI74Wea0P/9RmC98t6qekOOTFxCZs3kRwDVltCt8mc+hiVrZQPg=
Received: from DM5PR07CA0089.namprd07.prod.outlook.com (2603:10b6:4:ae::18) by
 DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 16:00:23 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::f) by DM5PR07CA0089.outlook.office365.com
 (2603:10b6:4:ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 16:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:00:23 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:00:22 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: add event age tracking
Date: Tue, 6 Jun 2023 11:57:58 -0400
Message-ID: <20230606155800.1859694-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606155800.1859694-1-James.Zhu@amd.com>
References: <20230606155800.1859694-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ab0bdd-990a-49b0-8c78-08db66a72308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dnK3JJ8G+dZ9mjOQ+OJK8dEbEYETcOylAQa4Z0A8w3OliYoiP3Kq6oNoS4tW65IA51U02PeYdQBxzUeBwCfQcUNEj9iYCjenbmjVMlEYnkNyP6Jq/nn8iZUBphl2JPvNRzkwDYYTX0zkSW4ma3aaVJ8jaIagqq1gg1LdFL+1t6iaxmCTbTyunpOD/S10R7JkJYXZw2RIsNGkeQyzsaS23hLvdJcQLfNs2cBs2CIkkM1KFHcbM4lnRUncnX2HAjlczHr2QVFa2Vu65V6AOSSyqXqdylmBe1JxzfcV7A7MbcWSupUX1bQaMiVNGVj5gLMRD+rt0Z0i+1gVJJGYKV/w12TQoqmOTuHkF8PP2L8SU23Boft7fgvF3FRy2OeYrcxqncO9Uionm1yTpzEWBuKGhBzOWq/A2EAT3RqtOBVRH8/SvDpb785T6byhQdYKPtUb32RWZvREnIo0EqrN9NuK5DO/WuohapFc9LqOvWEzWYMjJVqLsuO1p13SpE6H2VaPQS53YCHG6vAwBafxzLVZQ2p2ekham607L4XEabmn5WTfsGnoisXycaAD+iU/8wbbFxRxIDXnfO3r+xGd91HQyaoOAL+oSMmZZyJSGyG6NXxgqiIzjf86QPhnQN6h5pMZAAzwQJNk2IPNNoxlrZ2WUv0n9SEUYKth/yU5Qirsc4e7RjxIT1u4STlCO/qQ11fIXWhzkp9dZ7sLqNIQWbqJ8jmoHuypD23h/xaK5Cw0zoynIG3cCx8QSi2FZC5h/YKs1S4vDJSNQY8+2oWCIgrmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(426003)(47076005)(2906002)(336012)(83380400001)(2616005)(82310400005)(86362001)(36756003)(356005)(81166007)(82740400003)(36860700001)(40480700001)(7696005)(41300700001)(6666004)(5660300002)(316002)(8936002)(8676002)(54906003)(478600001)(70206006)(70586007)(4326008)(6916009)(1076003)(26005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:00:23.5610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ab0bdd-990a-49b0-8c78-08db66a72308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add event age tracking

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 1781e7669982..eeb2fdcbdcb7 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -39,9 +39,10 @@
  * - 1.11 - Add unified memory for ctx save/restore area
  * - 1.12 - Add DMA buf export ioctl
  * - 1.13 - Add debugger API
+ * - 1.14 - Update kfd_event_data
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 13
+#define KFD_IOCTL_MINOR_VERSION 14
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -320,12 +321,20 @@ struct kfd_hsa_hw_exception_data {
 	__u32 gpu_id;
 };
 
+/* hsa signal event data */
+struct kfd_hsa_signal_event_data {
+	__u64 last_event_age;	/* to and from KFD */
+};
+
 /* Event data */
 struct kfd_event_data {
 	union {
+		/* From KFD */
 		struct kfd_hsa_memory_exception_data memory_exception_data;
 		struct kfd_hsa_hw_exception_data hw_exception_data;
-	};				/* From KFD */
+		/* To and From KFD */
+		struct kfd_hsa_signal_event_data signal_event_data;
+	};
 	__u64 kfd_event_data_ext;	/* pointer to an extension structure
 					   for future exception types */
 	__u32 event_id;		/* to KFD */
-- 
2.34.1

