Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E1AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 23:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D90110E818;
	Thu, 20 Jan 2022 23:13:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B968610E827
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 23:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoxyoR7G8+rpS8YLRwfFdoLuBOtujWGKrNNOfCSQva69FXTYVGc/mgo4CDJmOpscdfPZDOpVrMdMV3hvKxMAT77J15pvQ6ktMddwBjEdmvm8QL9SV1yFcCCPCmvVTOTjm68HTsLjlhORecDe0KoPzz3fVTwNG7fQInSrd1w19lsTsfrERLs7Zi5V9lrB/1pVqPDz50h6zfDKpT9jQJ/4hCqfxND/n41/ySL1hCHTrxLq7rNElQw+UOFMXmOHX1B7tpBQEKhA1z1VHY0YXOi9yPo/CYB1EyxknKQpn6agb1GyuYX5EBh8Y8tm8tv3O3HJnWtARMWH5lGTdYjoxriu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nqllJmdm7ZaHo7n3fxKZfZVRYnJX4JBi586vxxr29M=;
 b=VD7zyAJdavAm2dQrMty85888GXUOGvWnAxrZYpGnfmPwUDf9WVfMXeUFB8topvMcxq93+OiPd4npzL3Y+NUFC+gnypvbJoC+xltOs+6W0HLdY2M5jp6ckkWun3SIqVnyDkacRSzpBWG+9PqMIJA0s8+ftUVFZI/l16Lwtg0Je9xmThNNzH5WkEz9+TCt527U2L9eEMTspK0sFYuqjqKm/g1f8/7a8chokuJn4tI+IdmBgtJbXM80qcF4PsWpt4A+4aNufNJHEk93p/2O69wmM5NHkGHgxOs6pFJY28inN0bGt07QHnqRLDDvc9/lzfEJNNhkRcs5nzV763OgBG9jBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nqllJmdm7ZaHo7n3fxKZfZVRYnJX4JBi586vxxr29M=;
 b=e5O1Hwrxtn4lmzH5Y4ipX7mnCovZm1sf3H9bh/s2ZYypt2n586rjlyUVnBsjip2Y9VMRy6iiqrLLZKwPSHJABKfqMho4y1im+3A4jKEZV80nOA0WVEsVMYdQfy8/a9SGMvwf57e1GiTay3jyjgP2h1Pv3Qz/xsgt9wWX3AQEgak=
Received: from MWHPR19CA0092.namprd19.prod.outlook.com (2603:10b6:320:1f::30)
 by BL0PR12MB2339.namprd12.prod.outlook.com (2603:10b6:207:4e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 23:13:42 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::26) by MWHPR19CA0092.outlook.office365.com
 (2603:10b6:320:1f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Thu, 20 Jan 2022 23:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 23:13:41 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:13:38 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 8/8] drm/amdkfd: Bump KFD API version for SMI profiling
 event
Date: Thu, 20 Jan 2022 18:13:22 -0500
Message-ID: <20220120231322.10321-9-Philip.Yang@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93787328-21af-4c46-ccff-08d9dc6a7fca
X-MS-TrafficTypeDiagnostic: BL0PR12MB2339:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2339E1391CE904FBE6F17196E65A9@BL0PR12MB2339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkEOkse5H4k9E7taIe82sbSLqGSG9P1+CND/m/aguLfonR9uLnkr2eLnYlytCEwzdO1glzOrqMOBwoCEDpNofLca22AMdd4f37QGvcB8m3uKqL99i36uuwT8tZFh4xjinXGD6GEFuUaTAqACxIzr0swQLxttD81smsMphwTJSCxfigxVABSS29qMYu89ZeyywUVS7eof6S5o/g7D5W/YjxfL232ulSRBAeRBQy6A2AS56JDEWBLQaE9Sf3eKh6L7Cv4uVqXCLYyJZE2CnVdXs65rpmwZAHF+uJSb9q39O5XTo4UsabSsYFooZfZ/w5QveT1w5PBjpcJnaMLV6jjOzIo3XsVuZ6XklafQbYvhH8Mm23ljf/pY6gSXRxgo2FUFC4wq9S9D6hIue/c7VQnb+LG8glbcGyQOZCdOH6Md2NGLMIiIPHiBCApUbPQtAWbbQ+9ZI8ne5OMvCgGpHQWiUHtEukRbATlJLckPPCtGcGisllr6xZmx5E/brmjzCFHgP3OQkYoYLE/D+8k+zRS+bdC7VnFlIdqYFNVzaeMbVDucTRycr7JO5iUC7oIs1bV7lRkteyKxchjWlGWacNaZdYrjfBCb6VFF3XU+h4jpUFInivo3SBz9ljgNPX/XmAanvN0vKJLmQHgnXayaaRlp19haTbLv/NRmc3rzu7oHIDtd70H8iLtXIRC+NZRTg6arUaOCoag/0MulyFXS7bp+cN1VTe1CaeAkqxIYVCXppkr4NmnZUnYidofMUn4z3S6q1s8qxNWwQHolyhapZtpGyH96+i02IjAxqyorFRCKhqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(7696005)(6916009)(336012)(40460700001)(82310400004)(36860700001)(508600001)(81166007)(426003)(316002)(16526019)(186003)(8936002)(26005)(8676002)(47076005)(54906003)(2906002)(2616005)(86362001)(70586007)(4326008)(83380400001)(4744005)(6666004)(1076003)(36756003)(356005)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 23:13:41.6714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93787328-21af-4c46-ccff-08d9dc6a7fca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2339
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

Indicate SMI profiling events available,

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index de0b5bb95db3..1236550d1375 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -32,9 +32,10 @@
  * - 1.4 - Indicate new SRAM EDC bit in device properties
  * - 1.5 - Add SVM API
  * - 1.6 - Query clear flags in SVM get_attr API
+ * - 1.7 - Add SMI profiler event log
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 6
+#define KFD_IOCTL_MINOR_VERSION 7
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.17.1

