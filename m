Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2877AC43219
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C2A10E784;
	Fri, 18 Nov 2022 16:59:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC8110E782
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7B+MSC9mvJ/2iVgCL6dao5XWmDZtW8AOnFtFHkQNC/RjGvXm4pRMPfMHUEdC46gx0dvr8N9D4/otChxFr5IhcyWJLusR50w5FsxUDEzdfNva/4GCqPOZJDHCam4ImdtVZRUWJHXCFkzVYbhfyfEgK8/Lbl04X+rHozDtXugZmA9DitzbqwMPteN9oCUla5E5hSN+COiX2M2S98X4kt6uYR2l0e2KDVFqbvKVWRb9zd64xMEy0A7MocuQVabWVrv+djKMTiL17ekyZuF5jjgfNZPJx608Np6LBQ3+2TYOXlnkrqgjbdmaU2wE0xC56kQezUyCACAN/UcePdHHnme6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JT1JOhugr+GtzAsPk/cQ+/Bidgqm0RxnewSMLi1f60I=;
 b=OqsgNThqXjYISChs4LWyfXktBr8scJEmvc+tNaosiqomYxZLO57oHdGXrn4e4blnANcfXBO+4QIo5r/8C/aLQauPrw8c8UHT7Lynezt5MmYiLGyV5gm/UFsdYQHHZXose/C+jHfrlWUHePp/hxoGjZSZRKSejv7alvftEFXRiiHhDaW+gh9CJuWodiuSGs5X06ztX9YuLsv4Von1th99xM+BQ3Jpurdrd6DgY6jYkNB/TwzAYnJpndjfXFP5jf84pdVggb5mwFC3ELASqzhK/AFYGpFuwbpUHukxw55q8w0PpB+gCKw1GSZ0FPXSU6LFypdXCp8GH6eEjGHM2AdeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JT1JOhugr+GtzAsPk/cQ+/Bidgqm0RxnewSMLi1f60I=;
 b=5ojE+D5eKC3XZI2snda8OVkUx0Lrw7my1nCLhKLB5QHM9AkrJKspf0s4r/vAmbCkPJiwZFlZT1mTdblFEwQSVEvcm0GPiC2EIFtr6mFf0lG82rk6Km5J/xNLIvR6DzIsEOjoum0shufWnzEOIdUI9S8HRpMl/AWqlPMgeCytUcE=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 16:59:32 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::2) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:30 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:21
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: No display after resume from WB/CB
Date: Fri, 18 Nov 2022 20:59:16 +0800
Message-ID: <20221118125935.4013669-4-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: fecac395-6872-404f-8fbf-08dac9864372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+nI3MpUKFF24XvHwkCBMv2ovjWJ9Y41scAKk9KOSzMi9IFXKegArAp+v6SDrdByX4hcLkaS9/MuyiDwg4Zki1v4+6UtKFv5UDmPIknDGvG2PzNA9ls5eCuOqxhNefN0wzEebS5hGCipp9HzkdaHgKlsOFCDNrvI2dpqpj/XS9p3yKgPGm+pln2IXz3sC1A7NVbhehE00j+71giJgqYFo/EDKJARpmfJd60f5hoNLnxHPR7x9/h554DpUND7BFNPN7ShMFiwOGcZrXtyCHYkHRUEXyGvcwksACpCCPcpvRTaGWSpHarwGB51tiJ/iUIM+BKryxTXGJeUu8KnA9c1S7Ceo7EyHj/8YppYe7FJH1xuAUP+IDS5ATWgGsIYdAkFmw8/jNBJWC4V+6xZJmMFfFwk5prF4vhcHKoG43b5U1ngJflO+Owo0Ffye+t+R0dlL5u6WMcENoZ+vCciSViSRjxF3mE2FkA9xkD0X6JedJHqk/zD7q0y6cN/BOrpmdCYV0iDuI/yrty7P+S/hZU8vAEQjnO6gTqsyuQyN+m9rRX35eJWQI/K3Dbwf3/TzGvYQvTPDFR4z2H/x1kNRv41nUo14JoU2p/a7Ah1MdcwEJb7yXYCBI4HYaAsexlPXL78fCFmEiYYC41RIEqi99Dxx/h2ZnMbD2z7rvN3vmHN8MVQhUuikwvd1usD6GSe+K7acSSQuw/BBMc4W2YTUH/OMmxvid2SF/9W2iLDW/OnuadeU2A/B+HsNo2o+2ah3MnV3FdQt4X6G7DHWAFSGVWz1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(4326008)(8676002)(8936002)(5660300002)(40460700003)(41300700001)(70206006)(70586007)(81166007)(82310400005)(316002)(36860700001)(82740400003)(6916009)(86362001)(54906003)(478600001)(7696005)(26005)(36756003)(6666004)(83380400001)(426003)(47076005)(40480700001)(2616005)(1076003)(356005)(186003)(336012)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:31.9166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fecac395-6872-404f-8fbf-08dac9864372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 tsunglin <tsung-hua.lin@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tsung-hua Lin <Tsung-hua.Lin@amd.com>

[why]
First MST sideband message returns AUX_RET_ERROR_HPD_DISCON
on certain intel platform. Aux transaction considered failure
if HPD unexpected pulled low. The actual aux transaction success
in such case, hence do not return error.

[how]
Not returning error when AUX_RET_ERROR_HPD_DISCON detected
on the first sideband message.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: tsunglin <tsung-hua.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ad06e124aecf..5b97723ff6fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1369,6 +1369,42 @@ static const struct dmi_system_id hpd_disconnect_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3460"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010 Plus"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex Tower 7010"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010 Plus"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex SFF 7010"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex MFF 7010 Plus"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex MFF 7010"),
+		},
+	},
 	{}
 };
 
-- 
2.25.1

