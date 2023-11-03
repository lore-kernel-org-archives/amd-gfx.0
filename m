Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F51EC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED7810E9D1;
	Fri,  3 Nov 2023 13:12:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D3110E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+rJxnuw394E5/c1aCMj+OgeMDa1+L0pbG9fkS8lYDiyMPJU9ohN6M5E5EujniTuGiX3/Uo8R4OMd11NK5F0FSfBj6rF2NmirYtNj3if3tKKl7hzuyV9aO6IP4EtoZJFPpV7VAdPeeq59czZQpjskKxuifBe5f0DprDHjOKSfEY35/SiCDBzRuhcKrlCf1kHZ6M0q0Ez8jEr/UK7+KuOmYs/VnU/IeYVuxwL5ixIIQgQf2S6WVO0w45nkqzRZvu/wqB9Q+wkF4phO0oONYf06I9K4FtUJGM7g0Y4o0SR4OLnPXjT8jjgOZtQBB1+8EouV00i1KJWA8GdtaK1cZGDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0FU/xZvnyMxEn/p4OvoIeZDVdX/lhQY75jbBqB3bHU=;
 b=Of36ES4VxAWwHz1oysTVlBX18Y5RjqOySAjvu1ZLht+uHyPQPvL4NGk/IUl28s0nrKbFEH8PXJDK1JHKFMleE9qKwqvsRiR+1U+YBjoDniYl03eLYC+GFYsyB97AxyQLWIwxZe2/4svRy0yLHBGL8PeNbc8DugNXxzxMEDuNPZjUuJ7Qwqg1pPx1UDSD7FRg7ud7BDlNC/NdlaxBoa8xu4kGe0aDGpIVjbVzGBrBArMlo1k4/W4hj3UmwUDWNN/9/fhHbNsusw+Hc5vuD8P3R6gVvfhfq6VDWqjGr+Vb26uOEF77fH9KZWB+Pq7TtOy7Lc4X5i6xhGL59hejZzvuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0FU/xZvnyMxEn/p4OvoIeZDVdX/lhQY75jbBqB3bHU=;
 b=yqEblH+CxcliAy8XOR7eBO7xBhvzB9c1m9j8iRukhrm4XH0Hk9sx1qPvmuwgTXwnJ1oPRgAJZ6X4w2C9CIx9Tz/gp77P4deTlIiAW6hQ5vbM5BrMKOtcRDZqmb7x0IzrGRf8ebeieHQKqvOk4BJbpXJuzq0O9eySci7sv/wd9n0=
Received: from DS7PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:3b7::9) by
 SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:09 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::21) by DS7PR03CA0094.outlook.office365.com
 (2603:10b6:5:3b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:09 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:06 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/24] drm/amdkfd: add setting trap pc sampling flag
Date: Fri, 3 Nov 2023 09:11:32 -0400
Message-ID: <20231103131139.766920-18-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 531950dd-4795-48e6-7ede-08dbdc6e7c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kX97UtDhLCTyyljk2Ob2S7/IisEI6VLhyM+nKfvf1z3NkSw4HZ0xW+CG2gUIE3hIwsw7sPYKlaxguNwSU3aaXrTZuEXtssWExA2rRHOGWw4M9P2ynGHUsSy+ZgcMQsaQP1FXCewDRYJWa1pTCCCjHR/VsIEr0UYaegt5oJSG+pwqWw3ubghknQEwubCu4pbKzBbF3V08LykgZO1zVQ51zE/bWrhQ7oNWKh+YUnJlepQ3PgVdRM9IWj7FCsmMIczCYOxCQttaBG4oesfcC/uIIIU0XxzM/E774/DkkPJTZajkfL1hdBcZu/tD6QqndR0fHdxVxIa6W2FvKx1E4V/oyxJHT4E+xATZF+SP0dPj+wiixrso0xNG7VN7rUe97ANa28zUpbMisTHzZ3/DD3MzFozIhvog7LpCneXk+9FRUmVavZe3GGBREzm2wy9NsZdSK6kv4vqJ+qInes8qn+FlGdkozL69uzX737Mjrhgmx4WiR8quK73LrJm32kvsFZLXnargfJlBgQMo6LZMnJvl7tUVt3lI7+ytiRkXfraRVH28ku2RqxrbIyqrFXdYabULm2qZYXdT8wlKJ9JN50wvbl1/tr/23d9CIDJaFSvGfgUBPYfdlEgqxub18PbX39UGOsnHVLiPgPicSkY+pJJNQx1jY8IU7LlOFgws3SMeT7zIxQUOqF8cLj9xqrx/GRAm0Vjye3QHXdlzLpxcBbsKojWdbgf2cYgKukaRfJRS72fZp6CF6MqD4g+EB9M3R5pd9qtjo75p0G3F+yCSRe3PAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(316002)(6916009)(70586007)(54906003)(70206006)(478600001)(6666004)(40460700003)(2906002)(5660300002)(86362001)(41300700001)(8936002)(4326008)(8676002)(82740400003)(36860700001)(1076003)(2616005)(40480700001)(81166007)(336012)(426003)(47076005)(16526019)(356005)(26005)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:09.4828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531950dd-4795-48e6-7ede-08dbdc6e7c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add setting trap pc sampling flag.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 642558026d16..6670534f47b8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1186,6 +1186,8 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tma_addr);
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled);
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled);
 
 /* CWSR initialization */
 int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a0b729c65a7c..d22d804f180d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1454,6 +1454,19 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 	}
 }
 
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled)
+{
+	if (qpd->cwsr_kaddr) {
+		volatile unsigned long *tma =
+			(volatile unsigned long *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		if (enabled)
+			set_bit(method, &tma[2]);
+		else
+			clear_bit(method, &tma[2]);
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
-- 
2.25.1

