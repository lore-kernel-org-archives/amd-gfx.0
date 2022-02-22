Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169CDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 09:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C6010E682;
	Tue, 22 Feb 2022 09:36:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261B910E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 09:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWVOQ5gRodrCaxxErJAOrbYAKzFs3T8jyV4ocsofsIyC8ebFO93VLU7hv7q431+cBZ8O8NALmtoE7R/T86s3BBji9+BEaPTTp4zbrAgSUeKKEkpPhhwk/t5fzUbHlb+WjHEq2Xjr9kAoVKkTkU/tnIKjo+wSzH0yg5+zPgZg1ahVozQnFcJL1mNdISlWUaamBnVQvP/awRwj2EXSKfRzVfhK46I2tiXiIOq0RkGedIbdGQnGYOTnT5i1qC4D19l5/q1krnutxvCWJ6+vTpFP0OOEm2Qyj8YZqvOgbKR8JUrYwEWuMQOf7PpMu3fTzSBMW2ArCpyI1R66R+ovKAjw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkN+JPEfcHsK0ugoeHseDdSeWwD/+Mzrx60GDRbZvvE=;
 b=gtKudNSnoqXepJBq5kpYmgptc7hHif9Q2NyCiW7Y4D/D35c9aLJVSZnSVqLrDf7+UWqg6kBDOQIab+nfPxgz1wMHAke6IH6X4AVgBWEPpBIAZLSozPMAW4QfYxEpu3Whtr1yUdeV3gXKMZFmQv1fClmnxHdGzcdhbewSw9G8iQXJhj5AhettXxLqavxBjcTbLmITJzVcMLw7gvaFHZhRJIaD404vkNB7+aEjGDIZsGQc2oYE4JD5kCYxsd5cowkn9s6znlWu39AvnJtCfeaxEQdMr/skD//Uf21mfReJqr3qtPFamet1tDXte+qbFPA06gNppnIG0k61za8gAbIYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkN+JPEfcHsK0ugoeHseDdSeWwD/+Mzrx60GDRbZvvE=;
 b=xF//Tr1g727h9AQp7Tsozd1QOi45WA4ZZNuRVuS7wCYvLpoVTgasIGCe+1b3QDZcw/4dALQIGSXCgGRTyS75DaZc3Gz9Wnq18wl8xRuGv46O8Cbk0xT3aGDkwrpDnXz7mtLDKM1lSIqm+cJOy3xpkJrfu5Y2gngGg5uHZ3tyBYc=
Received: from BN9PR03CA0897.namprd03.prod.outlook.com (2603:10b6:408:13c::32)
 by CY4PR12MB1398.namprd12.prod.outlook.com (2603:10b6:903:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Tue, 22 Feb
 2022 09:36:31 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::f8) by BN9PR03CA0897.outlook.office365.com
 (2603:10b6:408:13c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Tue, 22 Feb 2022 09:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 09:36:31 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 03:36:28 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v10 2/2] drm/amdgpu: add reset register dump trace on GPU reset
Date: Tue, 22 Feb 2022 15:05:59 +0530
Message-ID: <20220222093559.2829-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220222093559.2829-1-Amaranath.Somalapuram@amd.com>
References: <20220222093559.2829-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c0e4e13-e247-4b32-49c2-08d9f5e6ceec
X-MS-TrafficTypeDiagnostic: CY4PR12MB1398:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13988E81D6685A0DA51A5660F83B9@CY4PR12MB1398.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkLGmWd4JQZPFNz4PgTFZN+sfmohz2kiLe/DGk2UnZ40ZpvtqUN8O2WzCvH9WB6BssIeIa8hRNSDHesKOGyqF8NkXk3Y8OmvtDBVxn7sY5rYFzH1GLgm7ByHN+fVHUmVQQ37Ra/bI+qz0DKPx2Ie/k2Jnhcoto8Syi1w0tspUIan7RsPtcbtNrMDqOVpAlJ3GZi4O/84r1O54/DKU/WKCgN+ENRuG1SyJiP/wcYgNTPo3mwbfbzRQstU7E3lkWI9dykePiPIs0j9POboOIrYVFgJU1k6rWX5U6hBnaeNFm9CqQEJNrtqDuc9gzRDH1x2XR+hA/hN/xB0CQT6rg7WW3j/8OtOGSDWLM3/A6xU6Qv4eoxsROCdQb5QDh2fMek0E8/MMO2h6GLXo2MuBIdclBuVWy7Hd4LGyhyD4NVuSHY++LWzjXNIbTeQMeZjO36ES78TLuCvfEtUxcst00YwhGo5vrw08VhqkhPQGUCAJf+q4PL7SB0rqra4g2iF7+bVuACgCFCuMp904qzV2gGSUmSmQvMqpCDg6bYaHZOvRGNhlWvyfKwVhz3HoGxjxYCyeW1YdABTm3tGOoq7/F4YzWLQVbpDnttEM9T5qjuze0TStujKmTQ/HP6xep2EZAkZA1Fq5WjsZhiss8MLPvfr+8SbDUdrsOEC8vlGKyg7Lx1OqsCiT8CRjZDfrLglWwOP3yUeVnXI1+QQ9snXrD9Rzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(186003)(26005)(70206006)(70586007)(1076003)(2616005)(36860700001)(7696005)(6666004)(86362001)(54906003)(82310400004)(508600001)(316002)(6916009)(356005)(81166007)(8676002)(426003)(336012)(83380400001)(4326008)(47076005)(5660300002)(8936002)(2906002)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 09:36:31.1729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e4e13-e247-4b32-49c2-08d9f5e6ceec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1398
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dump the list of register values to trace event on GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..0eedcd4e2227 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,21 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	uint32_t reg_value;
+	int i;
+
+	lockdep_assert_held(&adev->reset_sem);
+
+	for (i = 0; i < adev->num_regs; i++) {
+		reg_value = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+	}
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4544,6 +4559,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
+	amdgpu_reset_reg_dumps(tmp_adev);
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
 	if (r == -ENOSYS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..b9637925e85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(amdgpu_reset_reg_dumps,
+	    TP_PROTO(uint32_t address, uint32_t value),
+	    TP_ARGS(address, value),
+	    TP_STRUCT__entry(
+			     __field(uint32_t, address)
+			     __field(uint32_t, value)
+			     ),
+	    TP_fast_assign(
+			   __entry->address = address;
+			   __entry->value = value;
+			   ),
+	    TP_printk("amdgpu register dump 0x%x: 0x%x",
+		      __entry->address,
+		      __entry->value)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.25.1

