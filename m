Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82997CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 13:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152F710EA81;
	Mon, 28 Sep 2026 13:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ik6H3yr5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC6210EA81
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 13:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMlS+i/3KvPYOcXZOIUcXCyOiGNGKJVhqt8QKJdGG4UD/swdpvEvfs2ioLSMD5QEB9sdudsCcJkP6xOSS+YMWhEQ+bw3/eeCeOuesLcbGOfmvq32sMRsYteAPyGroK+EC7p07R9CmPDcBKezN90fasjRlrsK3QF1zeTBlsilnqSQrpUpCQ6FEbcgWd4R11EDEyQDlBP1UU1cGsENydwWMXjfVRch+borz8/xcm6KsKV/pyXT4VsLD8pjbhb1jKL5svPaUx71g5ydDI1elg8otuaMHLv4jw2XIu50JPyrdc076kFZecELifnTkCq9cMHdz9uXNnPTh8pFu1iJg9EjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WR8/Hl0NrnBekChb25Neze9Yhgd8qcn5h01ALTUFzI=;
 b=pae9QG6kmJbv2INkxogwtsnoMNdgkLg4VJz+dIcC1oBTjBkt63nvIwbDH7THGOboCLqApx+AyINjYtS3hOZQCtxBSQqYw9FJFFciN5zJHt65LCpOONsMPf4ccr1Z2v5430I9II0xbyeovMG5iPUzR9fjLtUyjQXeHTarGEZSCCKXtiEfgizEwjj4/WKrD3w5toFMLWmNQFqt+gmKiFQd6tReXFTlQZ5lrUI4T+e3YG23gOJz5+KRh1edhCw2w7E5rhw/pMRH3xLea0Dw+XePXRkkcXwyqebLVImYgO1/h/JW+ZeIY6Z79forYUs6pDGjbOKb3ComjCzq1vI0KhyA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WR8/Hl0NrnBekChb25Neze9Yhgd8qcn5h01ALTUFzI=;
 b=Ik6H3yr5asL+GlFKegPwKXpDxpGQJxvz7UBt/GPcjT/VxnGV7Hl0tLbliMWL1n7XWfzqV4CW0HgtFMHARpM+fNaTsBDPctErtKzqGAKmeBThOA+ulRMfNRNlNCBx8fv1d9tmtD3b+b/jQ9G74k5eMUsnyDV240AxaloXFkkBG2A=
Received: from BLAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:335::25)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:35:30 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::a) by BLAPR05CA0045.outlook.office365.com
 (2603:10b6:208:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Mon,
 28 Sep 2026 13:35:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 13:35:30 +0000
Received: from khazad-dum.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 08:35:28 -0500
From: Lancelot SIX <lancelot.six@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lancelot SIX <lancelot.six@amd.com>, Alexander Samoylov
 <Alexander.Samoylov@amd.com>, Jonathan Kim <Jonathan.kim@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Date: Mon, 28 Sep 2026 14:35:11 +0100
Message-ID: <20260928133511.155752-1-lancelot.six@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a01a44-5724-47e2-91ec-08df1d655d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: OdMR3AzoyIM5aClQDxAFkrjrP5k+ZfhxV+eSdr5EhoHIuJK+lTA5gSi4nmDPYeK6LiIlxRS09SW883p69K58U7ooJVaJGovYpj6Sd8yIG7L1NPWF/ci0bBiZ+vygU5W9/ZXKOb9DBZ1/IrVdIWSY0Tpq9LpL47mb34ROay86wsImta3gPEXImD6OCtBLptQBPbkEr1djTv0Ugyo4DVyHyKwmos6oGFqh6Ez0Nsqtq02btftubeeIUMW6ml5YQxCaRC+peRjdEqnk6D42SAv4Gx++tu+NWxUSIow3IwUzRJObCgnMc/3s0pXmFTMuOASqQvmftbViYc826VMj3aUoodO3fIcaEBS0cH8tn32+NOcm6VCnAsYgZTmk7UfefSaRqSMSfL4EegYlXnLrtD7ad8MFIzYsFkfR4hZ50SRyMOj23MyBs5bbaPh0BIXEhhQYmbUK1tLjE1NZ4zGrvsDsaTZ9hPLqns4Uk5TgBtKr1BbqdlMp/o9buuNt/g5sa0tepGpbwNPDd7SkftyaXCphC3HHJ7dzfSdkQCX5cV6kmX+N5lhxDTf+saBkg+wO+fobKigUf9mNL9vtZcIZDMGyYwCrzj4kpM6fYH6RPNJcE1qggWGtYe/wUSgHp0100Drxu2dm63GndZhAa0KZxjZG2ibiHCeIY9umKMUCGt75imc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NOduls+neBcCQI5COLPUvgNDPob0PCp1oCmHIUJY9Mtq0bYiAzO+BJWPR0lBSFpjskbPkyJujmYxXQ/j/WeKm63oLx8OU216xmdp+IetnoDVcopi3bX9/7bhHmp5IKMcAfZFdKvZCewfGyzbqTLknRuKfbxmOpYiMpy13x6aU2OIoOQLtieFOF8xGoiVyyJLXCXT6doQ20uB9dPSsY6M+NCxws4wMPH0z5aieHpQpWXvImdQCCon6DeDjIwaxQLwW4S5oGFU1jbmXEK6qU/2n+8QXhKZalJQJoABMShbBABvpZN+PaQF5QnOc8JcBAy0L1zOsTAfMVtdd0G7ZiqNkDo6nCF8AJspEBv8x2MUyFCnGRULcDzAWElX2CTWPZMFtmYq7G06v0c89mMl4j59Kpdl79rxRaCxflNk/GeEV5YZ67CxNFhwbmQW6mtiL/MY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:35:30.7438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a01a44-5724-47e2-91ec-08df1d655d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The device info structure returned to the debugger via the
KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT ioctl contain location of the
device on PCI (bus, device, function), but is missing the domain this
location belongs to.

This patch adds this information to the snapshot structure.  The overall
size of the kfd_dbg_device_info_entry structure structure, this new
field is placed in preexisting padding.

Tested using the following topic branch for ROCdbgapi:
users/lancesix/read-pci-domain
(https://github.com/ROCm/rocm-systems/tree/users/lancesix/read-pci-domain) and
the regular ROCgdb testsuite (https://github.com/ROCm/ROCgdb).

V2: Add reference to the userspace code making use of the new field in
    the public interface.

Signed-off-by: Lancelot SIX <lancelot.six@amd.com>
Tested-by: Alexander Samoylov <Alexander.Samoylov@amd.com>
Reviewed-by: Jonathan Kim <Jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 1 +
 include/uapi/linux/kfd_ioctl.h         | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0dd1fd448059b..2c14b03df0781 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1129,6 +1129,7 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 		device_info.capability = topo_dev->node_props.capability;
 		device_info.debug_prop = topo_dev->node_props.debug_prop;
 		device_info.capability2 = topo_dev->node_props.capability2;
+		device_info.pci_domain = topo_dev->node_props.domain;
 
 		if (exception_clear_mask)
 			pdd->exception_status &= ~exception_clear_mask;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 749d196e2114b..e7908a068d3d1 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -49,9 +49,10 @@
  * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
  * - 1.22 - Add queue creation with metadata ring base address
  * - 1.23 - Add profiler control ioctl to enable/disable profiler on a process
+ * - 1.24 - Add  PCI domain in kfd_dbg_device_info_entry
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 23
+#define KFD_IOCTL_MINOR_VERSION 24
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
@@ -151,7 +152,7 @@ struct kfd_dbg_device_info_entry {
 	__u32 capability;
 	__u32 debug_prop;
 	__u32 capability2;
-	__u32 pad;
+	__u32 pci_domain;
 };
 
 /* For kfd_ioctl_set_memory_policy_args.default_policy and alternate_policy */
-- 
2.43.0

