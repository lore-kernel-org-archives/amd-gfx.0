Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37582C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A73110EA62;
	Fri, 15 Dec 2023 16:00:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670E410EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLBz36hCMfFuSWKhECvQXygt+w+/bB0qz8aKR3m1AJpSyByOSdQnmULVIqUEiNuqjWb/pic/+IAZutXsGGETef2xfJOmqszvST4H4Ee/YWUU47JkKmXzn0EJBhynkOrudbzTH6ntI4Hg5yj1PuirkKGM+Mvw2G9FanyuJd57xbWOjiG7Vvqd+w/40mAU5JsRl0vWFXeT6+gqH4BuouEMDFR3GY/F1Xd32+4Km5fhb7+m0KzuCgSMRZhxrhEIYBAXAcDV3Z58sieJyNysu7ER41oHVqdKP3EvbdQ/gmch1z+q6aUbGuVUiuhS5w51neM7CTIIs7ywyOavuh0JbQHkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfJJtxlaWx78I3m2maJ589MApU12YuPe74DKm35qw50=;
 b=AEJaEPs/ScVMNoKQft18B2za9L6EVElRJjRPecjIAdpBfyJkfl2+j+Q4Ae2nZmGM0NVhCiXaSX43/EvlsvpDnvfNMWloXD3T8LyKjyXi7KwGYkjrZDw1G8NMvjtg8aJ496lX4uKkA9K5rAQBGtqs1uZeAw5qDi9ssHd9y/PCgg687aJiYF4qpeeizwlvtBbBzr2zq9ZzvlTYraYW17E6JN2iiPMRQ73pi6PnHltXUDDpIrtA0hPkSf6B3jtk2ZdchpHUrmwrN1vzRf5wd1B39FkGOHUA/oVT2S4fkjmHRdviG3QoD2OyKO7CSJlTPgTMT7GGTjlkkoVdaVgzygNULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfJJtxlaWx78I3m2maJ589MApU12YuPe74DKm35qw50=;
 b=1mZ/h+5UONZ2SXFmrtb83EsiGJLd1v4bnyg6QjaRplg01OarGufBHD3oJJGHFSLrjnnnT/ld2rD78dW0XgF95FXIDPwWCENyfa3dZ4BWOfpYDSLrKOrxc7W1KU69EMvbtv2KtXxoj5jk97ZIqg+0pjIPdwgxmv9mbpP3uJuUVJs=
Received: from SN1PR12CA0092.namprd12.prod.outlook.com (2603:10b6:802:21::27)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::76) by SN1PR12CA0092.outlook.office365.com
 (2603:10b6:802:21::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:46 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:43 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 17/24] drm/amdkfd: add setting trap pc sampling flag
Date: Fri, 15 Dec 2023 10:59:44 -0500
Message-ID: <20231215155951.811884-18-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: bf03a9a1-e158-4f27-5027-08dbfd86ffda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9+YWWnNe9Vrz99cDqOyhX2uXXw8LLrYVxkvcX4Zg5Cru0kHHptcLHZIEVNl9NucHryiB3eQcz9R1GyJRRYV+XW6CfhGW5d6ENUbOaEy/mqEKWVhkPc0tkt5fOPp2PgH71xt+YYx8N30gC1fc6+VoRSSYg2Jg9eTa+6vH2twlJEDUNHfB60+hlErcj9oL9SUG1igHmi2LDQ4gwt8FIxrzqB70aDCKTxqGRsQvkG0NnonRCLTyMCRWAejxKSsMaZACRAhSitJohSEkbCpUVdJRm0Wlz05e3qEkvh+VJAm45I/JBE8mq9gkBjQWkb9yu6kpqZFRxYu3moPeK7Ik99hpXhQeh4v3WoHukawNh4p0se4bUq4B/flJjMO6AR4AKiYBGPKG8y2wdjhB+ZPZ+olpoN1HHqlVBW/3uhzr5cANsMceblVBIg0o1Mzx5LT/V46QBUTyUmP27hj/NwXmi3aZvGAoeGf8x4k/eXYnJM2zigQT7F1fzmDQ/a9T52YLlJ6fvIesbY9ei21nmE1VtER3d1SBWjGBt22+u5pwLhm/djosHSSGFiL6MQ90sNWWrwb3lpqQX8P1mcgihFeEa8zUGz13Leaue/o6eZa4FV6i9z6/SnI7lAQnj3N+JhcqFw2QuWC8y54Y93SEEPedpaA5Mww5FNueUOxJN9/mGLFaYFHS4XH6Vr2neD2nM2li1de+dRFmKKuhwbxRCQtfcSATAtj6yU/aOnufpVi+h+M2wGKcKxH+WZI9RRpPkMZeTmy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(81166007)(82740400003)(356005)(40460700003)(2906002)(36756003)(41300700001)(86362001)(2616005)(4326008)(8676002)(8936002)(478600001)(40480700001)(426003)(336012)(70586007)(70206006)(6916009)(54906003)(316002)(7696005)(36860700001)(5660300002)(1076003)(16526019)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:46.2218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf03a9a1-e158-4f27-5027-08dbfd86ffda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
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
index 7ca7cc726246..b9a36891d099 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1198,6 +1198,8 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tma_addr);
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled);
+void kfd_process_set_trap_pc_sampling_flag(struct qcm_process_device *qpd,
+				     enum kfd_ioctl_pc_sample_method method, bool enabled);
 
 /* CWSR initialization */
 int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1a31b556a5ff..6bc9dcfad484 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1460,6 +1460,19 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
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

