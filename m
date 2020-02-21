Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8795CC35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D028222C4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ITErO4DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D028222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DB16F4A6;
	Fri, 21 Feb 2020 16:04:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC7A6F4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI4Epyh6zczo7M5S4BP5KgA7VoOHlUCq3nNN0WjvAVq7XantSYd91f13ToYa9o/IQhJ5g6O551dCEUo8w0U5gKZGkCA13RllPGN7YU3TSPmR02owSQwlGB1qYC5vvqW3XTqRqdSZPE6gvHPrwbt10+gG/CJMapfl1Y7tqBadBqGrSXh3UC1wcB0okMAj9/t8L4qTD+FFiMjdG5ueYfg+1/7dY6NMTLwU311XHrpqim0XMzXJKEH2unxo7c2KVgz6YZpRuy+egDe+Dq0Beo29EDC4RqlGM+1EJhiPnSFKoHROMrJZEJ7MEj8HnMDT78wgS1rtQSxr5IKCFWmxar39ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOI97U2U1x95FFCR4KkBCnTcj1p20JLjYRTsoy3F/uk=;
 b=ataz6uyYnE0PczZwVaY/zTqyWvbbeduLD0TwLKAcgfsU4q84P+P2YiPCp26P5sTxu5vxOuRaDvKvlYufOWzXtmuQ/bZIWbCfTIsBLEhwaaNoOC/e0ke92eugGDnSeqFFKLzM4ymb982A1gRvwcMInr2hZxwndBKkxBzh27vrBbyGIsuD15HpF5URGSKYn0BQDzZ/6ZwHbmXEPphT3ww0PxKFx2YlaflXqGL6Q68xlsAVUALNgraEyNovYL8FVxrn515Eure+M3nTkl0jLNOjkmlkmrS7e7iEWJPzFSSLWf2H9lEPZuVTpmk8I1hQrnzOBmBU9Texm1NAzZum2v6tJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOI97U2U1x95FFCR4KkBCnTcj1p20JLjYRTsoy3F/uk=;
 b=ITErO4DPqegq/TtUuYCWcQcFPp33P+kiXzQVzPY7KiZ5cLz3J0p928x1H7fKr5xQPEbDXWHE9+uv9TXA+LUE/SbXCMJRcMR2tiQ5wDvWDL5LbFGmy/C6u1b4Wvq2gtRkL37kTfrsAmBCXHKDodVefTUXFDCoKRGmDT866QYmhjE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:04:01 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:04:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/35] drm/amd/display: Add DMUB firmware state debugfs
Date: Fri, 21 Feb 2020 11:03:07 -0500
Message-Id: <20200221160324.2969975-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:04:00 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4dc3fa4f-2eca-47e9-acfa-08d7b6e7aa61
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2409643E09DF0694A2D3A2C998120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiUGsAVVW1fZPFW59p9U2zgzRScdZF7VFJcXxpSPTPj+hXbqY4ZXtkIPEQwi/VSqbl5DlYZPSr9eRc/szS4IrfjMR4kr6CQTnpBglq3e1rBZI+u0BkjHQpzg+CNiFHeTcI5z6irtR4sA+BNq2VmSQ0Nln2q4njCHlhNvH6IIyn69HY1mIETG6z6WdVtxM/z89MxMIMAizrnw93kTUm18SXZkcrDzq0J9NLSEuf5SW0xf6WRuCCvYlZR/DjVanCc59ZUixED729gAjMzxAL+KeIxNROVDidR1MlXmSmkHJRHhiQis8bnu2tHnbiqKhD0tKx9sDQyJeQApPSbf1/s1j5TKrQrUQuralEwaW2cqPpzkjMUV3FLQdHUKfTwGR5c9nEtNT8uajCBlcYmrGiqeP6nMYFrhv6RtoOwzV8zqAmdzEfL/hySxo8C5uYNK5MTR
X-MS-Exchange-AntiSpam-MessageData: mDQTgD+0DSL90J6aEYyfXnwfsy5nYw0irkTF+mDkCqBw7w72TjORl8uKZwTPmc3hxcCN/RGluwoNpgiwOqZSoAK/kzPc0Ry8uNs8MSREHR4w1mcMhZqJy+4/jexvnkgYDlo6e1DhuQSyYqzIa30eWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc3fa4f-2eca-47e9-acfa-08d7b6e7aa61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:04:01.0681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae1e3jktCDvSxN4Ume6EqaqSVjb/EQO0A/9j67ZSfY0UtW90zegCTVm93UZtS0PNyd2XqyG9JOrJmavzr0f+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Firmware state helps to debug sequence issues and hangs for DMCUB
commands and we don't have an easy mechanism to dump it from the driver.

[How]
Add a debugfs entry to dump the current firmware state.
Example usage:

cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_fw_state

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6bc0bdc8835c..0461fecd68db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -732,6 +732,29 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+/**
+ * Returns the DMCUB firmware state contents.
+ * Example usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmub_fw_state
+ */
+static int dmub_fw_state_show(struct seq_file *m, void *data)
+{
+	struct amdgpu_device *adev = m->private;
+	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
+	uint8_t *state_base;
+	uint32_t state_size;
+
+	if (!fb_info)
+		return 0;
+
+	state_base = (uint8_t *)fb_info->fb[DMUB_WINDOW_6_FW_STATE].cpu_addr;
+	if (!state_base)
+		return 0;
+
+	state_size = fb_info->fb[DMUB_WINDOW_6_FW_STATE].size;
+
+	return seq_write(m, state_base, state_size);
+}
+
 /*
  * Returns the current and maximum output bpc for the connector.
  * Example usage: cat /sys/kernel/debug/dri/0/DP-1/output_bpc
@@ -937,6 +960,7 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
 	return read_size - r;
 }
 
+DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
 DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
 DEFINE_SHOW_ATTRIBUTE(output_bpc);
 DEFINE_SHOW_ATTRIBUTE(vrr_range);
@@ -1252,5 +1276,8 @@ int dtn_debugfs_init(struct amdgpu_device *adev)
 	debugfs_create_file_unsafe("amdgpu_dm_dmub_tracebuffer", 0644, root,
 				   adev, &dmub_tracebuffer_fops);
 
+	debugfs_create_file_unsafe("amdgpu_dm_dmub_fw_state", 0644, root,
+				   adev, &dmub_fw_state_fops);
+
 	return 0;
 }
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
