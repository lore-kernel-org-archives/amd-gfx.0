Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219DBC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3BF10E5CC;
	Thu,  1 Jun 2023 20:47:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67CB110E5CC
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAeM1XzoZ0K/DMWyp9lkfyVdhJRww/2egBIA6MwddGi1ndVdwOYKGGJJyYbLl5FB+3WqDJwibdtSRBnbA3bpa0MEB7K/UVEkgf8CL9l1i5X0jLeAXxzTiBY6vzjTs6cI/6NacIGKBxz/lkbhmX8XCoB1qdJkErbohTN1+yITpMu+UysmHL/hWk0U+Ef/2aDHi28LpF0WHRIxpxL3hXLHOzOKvk1RXzh9SWvBuSCrQyDx17Zw9hS4mCI88TM7pOUmGlF8EruLaSmQFzoV2V5jSMujQYd9gDbARxXUBJTUNH1TTNA3zQ8U0lSI4sQhFfolTH4qBb+0JEd1ZJYbyyEBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGlS9WscZML+AcILdXHziZJcs7pbpvdI06BfxUBp4Fw=;
 b=N6uvNHCj/4EQX6dVL0VcVuYUL5mlAkdzSSCemtoHSx1uwKCEAkLkMM8gG4eESO/YY2RZQqm/adaqA0qNZNo5jXJ3OkW+vt7p0knO6za6b7Pv5YeOk0yddSEsOl78WCo26VumV9+TMBDdLBBdjD/rAWMeY8SHQsWRfYjy+pLLVSH9hjEw87toF6alqF/LMUZ/HVPAUt9UWXRsuOU2hkz7kpaAK0UgclaDW2HCzJhmPPwj9NlOdJQJg85FLFS+ajVc/+HVo3U2ehkDHSpU9BfWeNeiJfntYNjhySf3/rWPVW7itHtGoleTbLX0ZJHDjAcT5TleUldtH69P/8kaiAUjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGlS9WscZML+AcILdXHziZJcs7pbpvdI06BfxUBp4Fw=;
 b=yHvtTFeVQZfg0KAabzMrThUL+dNuUnhGnc3VDXt3rFPz7W9XWdZcvBaFHH67md8ymjVK6JoccfqYuG67QcJGP2Bqpf/B4WA1nhEf0iJxQcoMuI5dhQNFiwHOi7NOA+BSMb/tkW2QC8mS+4NYFC2Q7SS81rKLL/0afGMvzhDdI/4=
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 20:47:53 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::5f) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 20:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 20:47:52 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 15:47:51 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: add event age tracking
Date: Thu, 1 Jun 2023 16:47:38 -0400
Message-ID: <20230601204740.1501616-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 336f0ada-0403-4719-15b9-08db62e17860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxvvVBnPrbYiKUzVLd/lacosq30/eLCcUcrPmGQs4bxQjgDRRSSRjmm1mMoKXzJIvo34KgaHIhYNtiT7fDa3Y/x31UFdITU3dWsZYLuLv19NLag10WCCFgz02mV0op6glACfOud4K5ser7QoPY/hk+PAZP9qZF2rWaCnm+TOHYMGazMSwjTQzxa3uQ6g9zLThl2QGRVvS8bm1N/7Z18SV9Bh6uxFcJB87lZ3IOH02a0mnwCQb6gzLHprwLRzOuiY16/jIVXAbPqEhmj7qTbUcvfqhD08z5B1SrA6A2GRB27Isouqw8k5TusyaWpwNSbGy866/NejhsyRXEm9xWyb1pEEkORXhVpZd7AJVk3j+5lr6Apc05WPY/9COqoUt6foKj5G9O51S/yRfsCfpX2THbkmRPJMiYs5rpD6INCX+IsqgnzGwWhAkNrwF8jd1IzSumAphQfyZPI3hFqAd+KpyoZy1LreVwTDYVR+YSFlhJS6GNcqt5rJo8DKKtWlYupZWQNPp0RBdAtaAN7+7r1Io1pSw16B99z/yFybgaxiSW3UrrM+4Q4ZDbS+Mx+aRK11Fkngg02eJWFRr+DdsQTw0n4nr+M6oSdFajk2QAG40GOPLrvnWyNhtChTBDjh4EZPRr6xJHuH+Zs4MLMY2zX950eaXVidbJ7uP/t1notmTSP0huF+eohBDPTjaxhXFONBprRPXDyFBG6tiknT3tlmOvFRdUflMjfgeCepxwPlhYk/auY7tDntU4F9klJ8mUKgePAQ1LYLymOBLHS2frw2MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(4326008)(70206006)(6916009)(70586007)(8676002)(316002)(41300700001)(5660300002)(2906002)(8936002)(54906003)(36860700001)(82740400003)(40460700003)(7696005)(6666004)(478600001)(356005)(40480700001)(186003)(47076005)(336012)(83380400001)(16526019)(426003)(36756003)(1076003)(81166007)(2616005)(26005)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:47:52.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336f0ada-0403-4719-15b9-08db62e17860
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
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
 include/uapi/linux/kfd_ioctl.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 7e19a2d1e907..bfbe0006370e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -38,9 +38,10 @@
  * - 1.10 - Add SMI profiler event log
  * - 1.11 - Add unified memory for ctx save/restore area
  * - 1.12 - Add DMA buf export ioctl
+ * - 1.13 - Update kfd_event_data
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 12
+#define KFD_IOCTL_MINOR_VERSION 13
 
 /*
  * Debug revision change log
@@ -693,6 +694,7 @@ struct kfd_event_data {
 	union {
 		struct kfd_hsa_memory_exception_data memory_exception_data;
 		struct kfd_hsa_hw_exception_data hw_exception_data;
+		__u64 last_event_age;	/* to and from KFD */
 	};				/* From KFD */
 	__u64 kfd_event_data_ext;	/* pointer to an extension structure
 					   for future exception types */
-- 
2.34.1

