Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB56C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E3F10E7FA;
	Thu, 20 Jan 2022 23:13:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAAA10E7FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzmBDmHTuAJsYm8gmdTtcf7sW3NE8SN46GNJvhuiCIW/tl88wZUMkDfNySG8Eh7fvGifsgOkUz3bJ9Lbme0ak857xZ8cg1Sor/5kL5QBLwdwuRD34rgifSGeWWn+BAQrhP9HVtUC3KCnTVMdxcLua3RLDIAg5YhHmEsFRqj1Y5acDRXieO1i3Q4PlgfFQTNwzl5Trt6CkqGSVse+pu2IdX6+q+og4Zva2LGtGLJHAvB13ATDtMdEt9oj49GH+8abOunks12PTNOJdNwFi+hD2MGfFxMpe5ZueCbptZ/3qpVjacDROfld4WxxzqU99IaXqSfk+AoNOnf/+vPjGhJCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFTijju9ZpLoEtVaC00EwNPW5avobB3pRp3BPfJ8V1M=;
 b=XEHxAVloEuvcegvNHfzrKXXCr8hAufJcKPeTzT3J1Lc1Pwi0dxOVJ8L5cb9v96nqTIgwl8F9VN4jHIUxyJoGxxz1Cu6pyHWGhicbcZ2e5b4F3RzwhHZdjihIgqXKOJHKjohNjcpQP1aMg76JkkWD/wmt8HBGdafsvJvUagj1eOPvh9FMfz1Pwqj7bXaq1Yp9oksHeUdl6RuGMUDcaRLbvK01kjDqktlj9nOmmHxUmwL3DykitH+2jlqccYZMZ/q6AvwM0vEAuhDmheURB0GBkfcCISEaJwaXGOHknKmJfNWEPh+LTB57Wdfbdsu4YFUUR9my1NMRixz79ja8oSFpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFTijju9ZpLoEtVaC00EwNPW5avobB3pRp3BPfJ8V1M=;
 b=ha7xBLsI2HoBJ+YGLfQ91H8AH3VdLWLOmX6j7Zgrsa3Vi4DzDGWPXNveUGpTL3ExqSnhMk0BR04o31NdA1Gxe65Au8t9p91b/Awb2jBZrYB4pEnBNR884O1J71gWqbEJPcgNi98/7d1mO1egQIOvjiiKLY6QfSH7P2jgMSB8UQc=
Received: from MWHPR19CA0089.namprd19.prod.outlook.com (2603:10b6:320:1f::27)
 by DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Thu, 20 Jan
 2022 23:13:39 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::28) by MWHPR19CA0089.outlook.office365.com
 (2603:10b6:320:1f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:35 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/8] drm/amdkfd: Add KFD SMI event IDs and triggers
Date: Thu, 20 Jan 2022 18:13:16 -0500
Message-ID: <20220120231322.10321-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220120231322.10321-1-Philip.Yang@amd.com>
References: <20220120231322.10321-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c6f040a-c97c-4aca-9dd8-08d9dc6a7deb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1195FFF5930F485D0F057133E65A9@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6764+u5Cc/TSF8LuSY4coJeFX3D/1BEOdyobuEKwcPLxQptBn1tvhxtiuRv+vpc3z3Gvr1BhbcJLeXNZRBuIWWIi2G7XYc7bkZGSdlIfyB0w1nad6u6JZNSC3HpUC/yu+TuvJ9oJWCg1K+99fWPnpFMvHlNCPfVUp0Aml10l99jg2HWxcKGbHxMyss9C9rtMnrGRaik+YHx1MemoOFbKQosMyQKVA3Crq0qx6H/jDz8MrofOnpqX4UFhCm+a044FlkelszhNActaSmOpf8+1BuKAdg8Ct9pYASzO393q6pDXqFSvDU0D+b+SrfxFAszaOYD0yH3Gd8BctWFZdKnDK95kcYYauHRS3uEweDOyugISU2yXa0Lh7TkCvkHnVQU+CwyqKXfkRGnn7Ni+niGkaJl/QDCLvZUGFU7c6YxzAz/BgwRxwfpsjylAlOf7wRyq2LS4VZj/ZAcBDH3muHMmx8hDhGXi3y0LVejvkCbctFtNhMyhYyDvsD7thWvpaiN4nEfywMZtqEiVgSKr+eDM+39EIa9oT2n63SC6GaM0/GFpkW0zPyrJ6xT8gk+XnNMm4WJVO9ZJ5U/acWjZY+sX9hL7pIvV1b4ailgkC5Mxzhdwjen48LDiQOqi2yZtV5Ll12/R4uqDaj1lv4yI55nGnS4fgVsx1VTWZ8CRzruLn1vA7g+ALQ/kwmVYBYDwYg7ZMF8t5S7jO6P5BPZU8JHui3DVPx4ZKN3HTvJnQo+qvkDPRTsLgp2EwSLVUqV+Z+oCIALQK4+Ai/vZ6NKFVAsRaMH2caALeNGZGAD2nYYf/nE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(336012)(8676002)(47076005)(16526019)(508600001)(6666004)(70586007)(36860700001)(8936002)(82310400004)(316002)(36756003)(26005)(426003)(2906002)(356005)(6916009)(54906003)(86362001)(7696005)(2616005)(70206006)(81166007)(4326008)(40460700001)(83380400001)(1076003)(5660300002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:38.5310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6f040a-c97c-4aca-9dd8-08d9dc6a7deb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Define new system management interface event IDs, migration triggers and
user queue eviction triggers, those will be implemented in the following
patches.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index af96af174dc4..de0b5bb95db3 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -459,10 +459,37 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
 	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
 	KFD_SMI_EVENT_GPU_POST_RESET = 4,
+	KFD_SMI_EVENT_MIGRATION = 5,
+	KFD_SMI_EVENT_PAGE_FAULT_START = 6,
+	KFD_SMI_EVENT_PAGE_FAULT_END = 7,
+	KFD_SMI_EVENT_QUEUE_EVICTION = 8,
+	KFD_SMI_EVENT_QUEUE_EVICTION_RESTORE = 9,
+	KFD_SMI_EVENT_UNMAP_FROM_GPU = 10,
+
+	/*
+	 * max event number, as a flag bit to get events from all processes,
+	 * this requires super user permission, otherwise will not be able to
+	 * receive event from any process. Without this flag to receive events
+	 * from same process.
+	 */
+	KFD_SMI_EVENT_ALL_PROCESS = 64
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
 
+enum KFD_MIGRATION_QUEUE_EVICTION_UNMAP_EVENT_TRIGGER {
+	MIGRATION_TRIGGER_PREFETCH = 1,
+	MIGRATION_TRIGGER_PAGEFAULT,
+	MIGRATION_TRIGGER_PAGEFAULT_CPU,
+	MIGRATION_TRIGGER_TTM_EVICTION,
+	SVM_RANGE_EVICTION,
+	SVM_RANGE_MIGRATION,
+	USERPTR_EVICTION,
+	TTM_EVICTION,
+	UNMAP_FROM_CPU,
+	SUSPEND_EVICTION
+};
+
 struct kfd_ioctl_smi_events_args {
 	__u32 gpuid;	/* to KFD */
 	__u32 anon_fd;	/* from KFD */
-- 
2.17.1

