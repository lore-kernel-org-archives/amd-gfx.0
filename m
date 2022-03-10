Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 06:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF9910ECC4;
	Thu, 10 Mar 2022 06:12:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B3C410ECC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 06:12:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmnw2SIGQw7421Fs1/8/Fj9FAswmoKj9o14LxzpIU5T6ozxfxnRyBaxM1umlEFxizaC/AWUGagAabzHS4RvN9cpGAD3N8Vj1lwB5gXgYyXKBz4aiihnMdsBhHHKTgycfWfM5TjOWY1c8At2uEsjBtjoqN35uNNxBef52Aa6x04FBLLOyk8RwAKsnJV7vc1l65PG3WedV7gG5Ln8PTLAulebRQW6tPk5xD7cX6D/Cn0js5RLELvtsm1XHvETW0lt0d7ARw8j9Fn4s7mfqAxAmQ+KWVzquX7P3Sr6lGmUt7Et1tGJJMKKITEHdgYec+tMIeeLNUsBYo2q8/K68chNfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VibafGCNUmrhjo/7n4dzF57C7mF9FcECbODjtt+UPE=;
 b=F9xtA8xc4LxPaPZhiVUJBmfrb2GwpGXHxwgwBeVyBh01nvz5TxnupDZvyNCBASpbfD7QQODEKsuotDDtWK4vhDVp4ztuMR6ggcPef6c/g0QFE6ckflPH5hifL32guG+3WSwrlTin22uQCpCr8B5NF9sqwXgF8c0/9ybsU2J1nPdZ9kYD/RatJ9/zW/eKHt1CCdLjgVBZmHYtWvslUL0NCWbT2aqenQVg/lMUbYjmqn+LaHMyWxxntimMoH50iiLGqCI4gtE+IN6YY2QKNyofZ3j6dZ9P15F6rHvsqBeNRAHApybRXdnEI77Ps6Hwoj7CqE/9EQRWEF2F5XWeNi90Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VibafGCNUmrhjo/7n4dzF57C7mF9FcECbODjtt+UPE=;
 b=KzhasBa/fmq7BJZTs4FB+WlrcyFJp4lUDaxznNSYlp/G6tNcjgkaOqyAFWIszBiBzM5RiPDYMBN+v0dBL8IMqlfjL9uru4Jt6pbnE13Jw6TPxJ2zLjlIATkWcajxD+WCBljUDaCJiTLFt1kz07PAJxe4FQdFWaOCm3DG1tgGlLs=
Received: from DM6PR21CA0025.namprd21.prod.outlook.com (2603:10b6:5:174::35)
 by BN8PR12MB3553.namprd12.prod.outlook.com (2603:10b6:408:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 06:12:05 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::3a) by DM6PR21CA0025.outlook.office365.com
 (2603:10b6:5:174::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.5 via Frontend
 Transport; Thu, 10 Mar 2022 06:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 06:12:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 00:12:03 -0600
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 10 Mar 2022 00:12:02 -0600
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add param soft_reset_enable
Date: Thu, 10 Mar 2022 14:11:52 +0800
Message-ID: <20220310061155.39292-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310061155.39292-1-Victor.Zhao@amd.com>
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a462840a-aa50-454d-9f6b-08da025ce5fd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3553:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3553AA12958B71580C0689EEFA0B9@BN8PR12MB3553.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZvdeFkD5oWqd84navYSN8WfymH6JcGxf36duWxy+elktx4PiPRB739HADVeWZti/E/SstJ68RTY85r5LFNxO1Zw3yzehe8X0yWAfLqh4nk4VXRQemWtlnDHO3XQ2ilT/vW2fIYy9awLWX3wpTU0NuHQQajgA0kjVw84bWW01p4QSWN57s1neh60QeqlTRZJXQfhLoEUMEqfuZ9oXqXFKivwwcBwWefSXCGMU1QG1UX9ZIAplUMVLFXu97raNfmqSlQmdw+tm4Q6bX4esvqYjHsx4eZax5ALFvAFQ3FgTOEJ2a64gYxffK9NgBbzvo3LVO/kzdeIz3nMdY3OXwWcV0U1jopj6MQYB5ClpCg7w0rkPHY1viUVZbAe1dZ4WLpI3bgW/h0gLSyilqEQXIZFqEM6de+cf6d1O8yGxdZ0c6xUt14tc2Im5uaoH+NcnXJVUUkynS7aEG53hn8JFNxLO/SCoUo2cu4w3kJ225hSSJYSyF+rEemEiW8QSTH1MR0i6ck7nw5bZMOIQHcAWWC2WMnEgU6Ngmd+zDi+46ktPU0E57ht0s5qUx+gfZtzLeGjXVxcRCu7qJkoQ38PCLmo+u9rMhsfPzGkii5gHOjZ9EZXWvJkVBVdTVNM/p494Kndsy/UivbXQq6AoF0gsfbLBiK7/U6d6tkWBWBAfjD7n+Z7UXpLsJaAR020PLZrPw/JjF4d4gXfVKrF5tnWdyBRIdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(6916009)(81166007)(82310400004)(86362001)(70586007)(40460700003)(54906003)(316002)(508600001)(186003)(26005)(6666004)(336012)(2906002)(36860700001)(1076003)(83380400001)(47076005)(2616005)(7696005)(4326008)(5660300002)(8676002)(36756003)(8936002)(70206006)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 06:12:04.4103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a462840a-aa50-454d-9f6b-08da025ce5fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3553
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
Cc: emily.deng@amd.com, Victor Zhao <Victor.Zhao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add parameter soft_reset_enable to control the enablement of
soft reset

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c         | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1f3c4521d348..22b846c359b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -238,6 +238,7 @@ extern int amdgpu_si_support;
 extern int amdgpu_cik_support;
 #endif
 extern int amdgpu_num_kcq;
+extern int amdgpu_soft_reset_enable;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b3fc5ae5fe6e..09daff7727b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -201,6 +201,7 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
 	.period = 0x0, /* default to 0x0 (timeout disable) */
 };
+int amdgpu_soft_reset_enable = -1;
 
 /**
  * DOC: vramlimit (int)
@@ -931,6 +932,14 @@ MODULE_PARM_DESC(smu_pptable_id,
 	"specify pptable id to be used (-1 = auto(default) value, 0 = use pptable from vbios, > 0 = soft pptable id)");
 module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
 
+/**
+ * DOC: soft_reset (int)
+ * Used to enable grbm soft reset
+ */
+MODULE_PARM_DESC(soft_reset_enable,
+	"enable soft reset (-1 = auto(default) value, 0 = disable, > 0 = enable)");
+module_param_named(soft_reset_enable, amdgpu_soft_reset_enable, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 59eafa31c626..fe9b9d896dc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -620,7 +620,10 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 
 static bool nv_need_full_reset(struct amdgpu_device *adev)
 {
-	return true;
+	if (amdgpu_soft_reset_enable <= 0)
+		return true;
+	else
+		return false;
 }
 
 static bool nv_need_reset_on_init(struct amdgpu_device *adev)
-- 
2.25.1

