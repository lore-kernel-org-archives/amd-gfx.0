Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 09:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E9761A79
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99E9761A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C75E6ED72;
	Fri, 19 Nov 2021 09:28:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AEE6ED72
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 09:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzBWqCGOC07TVSycqQmYfx4WKMmUp2LQ1J019nLOd38O3eV+xBNK9b31Y/m6fMRMRREsrXFNpAuaA++rBLTc0Zm7fxQW2L8CpawgkKMPuZy+GgZWzScXPQc+3eyZsGhy5Cqx9bfrPMTjYIc+1yp/8kedrf+DRpRIqt8zCfjvnLCH1Kpv3G7QOKS89lSoNEWdE/noM65U58S1ifaVs86Lyc707to9uJwcb8I9ORifYTx9A0px0lbXRZJMtQZHnTDxoxS0hUioLBJUvycAP0eKky9ONRGrNBiKE4nA6VoWYglSUrwRVr6kI7HKxjD9QOtZJYiqkJP6F7bCYXU/icNyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXl/dZkCvHu+IFbaf8ArexnyqSgB/lZcNGOSiKkhcCU=;
 b=burBnUTCjUl1Z8RZVS345SwNlhm+D325EaXkRs2xmHA1MRQZyiqKE9JgUL4ZgIPSqUujrL3lHfkK6W0RsBpubMIJ54Z8c2D/GzJ6VEWxpxZ1hbN8tEZw5Jo7vLEPdoCh4VQKnIL8FoLdfHNbDaBdW63M6rylxY49q/9mBPk+9dSg/X+32+eyvN4cnQ5ywlco8Bly//Q6x4f8hGClHOLpH6Eg2RapaPGA6fz9eJEm03cU+VHlw94lxXGxi2wzh75l1f3LfCDiB1frpxBIdbwaB+frRIU0LBbMc03ZfCbzBBhqH8B3Tb1MyZf1TLbwzDvMH0VN74x6f3Cmj+NFcHXZbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXl/dZkCvHu+IFbaf8ArexnyqSgB/lZcNGOSiKkhcCU=;
 b=Lp2QuotJwn9z+CeWmTpAj+HStnkuGYTEGewb6A/jkd0u2WwtgYmzk+YYlqWAUhig2pZmBZXCTSKmXdldyH2jSW2QSlbnLxXHREwMMjcvefmZX3OsYTx80TkwAi77PHMiVMUXhnUxUI6SWFPrfcNhnxn7teEeg/3zIdRUV1CVR1k=
Received: from DM5PR17CA0052.namprd17.prod.outlook.com (2603:10b6:3:13f::14)
 by BN8PR12MB3554.namprd12.prod.outlook.com (2603:10b6:408:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 19 Nov
 2021 09:28:10 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::be) by DM5PR17CA0052.outlook.office365.com
 (2603:10b6:3:13f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Fri, 19 Nov 2021 09:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 09:28:09 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 03:28:07 -0600
From: Perry Yuan <Perry.Yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Ray.Huang@amd.com>
Subject: [PATCH v1] drm/amd/display: add connector type check for CRC source
 set
Date: Fri, 19 Nov 2021 04:27:55 -0500
Message-ID: <20211119092755.2225156-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d24428a-f3e3-4ab1-7160-08d9ab3ee6ea
X-MS-TrafficTypeDiagnostic: BN8PR12MB3554:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3554A658EA09E778352FC92F9C9C9@BN8PR12MB3554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kfEodXwiqDz/96DGd8jINi9lc+c+hKxJzFAuNKJzMJIjNECwm/5Fq5IJYc++woLBM+Qj6FNuI01wY98Fe2d15F04ZI6oLyFJmBEoDX2NtdFauRaGEBIXoASQFtfnqcEcl0R11FQU70kUO6RAg+cGPK2is1jryS5rJwxAiQhnrJ8tapThtxkts8/TiM0SuIZDk5gkXDRwWO5VFDstnrIAWga9zVz1ROLBNuw8vN1/FCiKLSoRk721Pop6hYUGS/jvKfxa2IRKPvm6JuDWS+VTlPyTRKh33mE6UwzyAIvkULMlxu1nZS+bPPFaeGijjGq2yrsHyX1gK6+q6pnN49HFF+WKJToGWSfNgDd6uvS6KEZj4/3ZIRaAIN4byyPpN5VZqnTjIN6pN3HW7rU+u7cDo2vaNoZAdRYTXcmQuOyhVOj9+XEk4uXBfhrAoz0Ih/vn0kRtTBgXppuiN3HBsh/yiEDTMut4C3+g6KbMPUwvOdnQ4M+OR3QSVTuYLADFBh7SDAMTiS940e7XCAuvAOTFso3qLrqau1jf3BvT+bzs6+OhjlO20B+8WfVxh+uDbVmtfPDDXE26GL+d514oamIsambM+ABH3JHZHfyTSSdJf5nustCSv1paddgyO41adnI5vVSP1uou1WbxRFYfF4hv0u77tzB9YOmuT5GMoh++MMM8Ji1vQ6N26/uno+FDLQ9JR4Y7TZtYMLJjLzCTMp5jNTtnFWSYtj2VpTcv5SP0x8RrkAsRDyYEDDOsc+BDO9AV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(70586007)(26005)(336012)(16526019)(70206006)(6636002)(7696005)(36860700001)(1076003)(54906003)(110136005)(86362001)(4326008)(36756003)(81166007)(426003)(508600001)(5660300002)(2906002)(356005)(47076005)(966005)(8936002)(83380400001)(8676002)(82310400003)(316002)(6666004)(2616005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:28:09.9222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d24428a-f3e3-4ab1-7160-08d9ab3ee6ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3554
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
Cc: Harry Wentland <harry.wentland@amd.com>, Xinmei.Huang@amd.com,
 Perry Yuan <Perry.Yuan@amd.com>, Mario.Limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 [Why]
 IGT bypass test will set crc source as DPRX,and display DM didn`t check
 connection type, it run the test on the HDMI connector ,then the kernel
 will be crashed because aux->transfer is set null for HDMI connection.
 This patch will skip the invalid connection test and fix kernel crash issue.

 [How]
 Check the connector type while setting the pipe crc source as DPRX or
 auto,if the type is not DP or eDP, the crtc crc source will not be set
 and report error code to IGT test,IGT will show the this subtest as no
 valid crtc/connector combinations found.

116.779714] [IGT] amd_bypass: starting subtest 8bpc-bypass-mode
[ 117.730996] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 117.731001] #PF: supervisor instruction fetch in kernel mode
[ 117.731003] #PF: error_code(0x0010) - not-present page
[ 117.731004] PGD 0 P4D 0
[ 117.731006] Oops: 0010 [#1] SMP NOPTI
[ 117.731009] CPU: 11 PID: 2428 Comm: amd_bypass Tainted: G OE 5.11.0-34-generic #36~20.04.1-Ubuntu
[ 117.731011] Hardware name: AMD CZN/, BIOS AB.FD 09/07/2021
[ 117.731012] RIP: 0010:0x0
[ 117.731015] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
[ 117.731016] RSP: 0018:ffffa8d64225bab8 EFLAGS: 00010246
[ 117.731017] RAX: 0000000000000000 RBX: 0000000000000020 RCX: ffffa8d64225bb5e
[ 117.731018] RDX: ffff93151d921880 RSI: ffffa8d64225bac8 RDI: ffff931511a1a9d8
[ 117.731022] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 117.731023] CR2: ffffffffffffffd6 CR3: 000000010d5a4000 CR4: 0000000000750ee0
[ 117.731023] PKRU: 55555554
[ 117.731024] Call Trace:
[ 117.731027] drm_dp_dpcd_access+0x72/0x110 [drm_kms_helper]
[ 117.731036] drm_dp_dpcd_read+0xb7/0xf0 [drm_kms_helper]
[ 117.731040] drm_dp_start_crc+0x38/0xb0 [drm_kms_helper]
[ 117.731047] amdgpu_dm_crtc_set_crc_source+0x1ae/0x3e0 [amdgpu]
[ 117.731149] crtc_crc_open+0x174/0x220 [drm]
[ 117.731162] full_proxy_open+0x168/0x1f0
[ 117.731165] ? open_proxy_open+0x100/0x100

BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1546
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index cce062adc439..8a441a22c46e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -314,6 +314,14 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 			ret = -EINVAL;
 			goto cleanup;
 		}
+
+		if ((aconn->base.connector_type != DRM_MODE_CONNECTOR_DisplayPort) &&
+				(aconn->base.connector_type != DRM_MODE_CONNECTOR_eDP)) {
+			DRM_DEBUG_DRIVER("No DP connector available for CRC source\n");
+			ret = -EINVAL;
+			goto cleanup;
+		}
+
 	}
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-- 
2.25.1

