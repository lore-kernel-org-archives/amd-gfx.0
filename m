Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74037C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 15:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7A610E985;
	Mon, 25 Mar 2024 15:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Su7jtMi1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D438610E968
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 15:18:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHnfqIO0dwchKgKfSBeaj0qSeuINiNS7HNSrPBKjMpcK+1D59qYiemLOIQG4D2x5cC+Tr5q50YxGhnznrsGHTwJIuhjgXLb569bATaqEnRLCHHmuRBdS3p8hywiO4CRBqbm7WvgqlKYzeu8t5mnyu6ZodsHNGWNX51t1qW1r6Y/cP97JbtQyUuXQIBgsVZQeZSu6ZrMj2ccG+aLwmSwdbNH2jb/tSHDrhW+vHBNZrEwV3CYZ1PY6ZXLO3lBlEagIZ08RN/CSh5jKame8fwd2XTkDBeWY7Rd1gl4fSOMnGUk+nGYTYMf/CEcD/M3d/84qz0yLbSINgiXvhLAwy1MRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAc459+GcxQdi+rP2OEKjg40Az96T7PLnjchyLyxfm4=;
 b=IgqA8aTQPsFVPG0wDAdTBFDG1j/yPDAMQJ6HehyEGZdAnI5SMKtNTEBqrAzwsumzmr/jgW6F4nOtRxUN/+r4C5qZgxkt+kM9DqZ3cXRaeD/JNScmxsTtstSdBIrTtLCR+hovLKe7Gq7uppzLO7Bf+HMlRLxvZn+gGIO5XM5DnmZ1adwY9hNWoP9D+pjeSLNyDTWWCSAaLWb01qNRTVpeeQfDebG3Q0j3k0aMAv8+1yK4HUaLJju7xpDNsZck0ofPtLm1iJQHWE5dPF0uPNqVsvCdd7wWCIs0PVlaMZPaCZiBqxz+cjGJY9yuYOzuyZVdkWX18lEFEJWLJ/fKooz8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAc459+GcxQdi+rP2OEKjg40Az96T7PLnjchyLyxfm4=;
 b=Su7jtMi15QbFD/jqGWjpOvrMf+b8+k9JQgLmPWwRxZF2Wj7k54W7eeFnRp3YBD8qs1vUw9wD/iNmCdxkpgw9yQionRTU/+J9rdiRWaSh+mxQs1SuHNSaSblPGuYfUGTmguUZ/Gql1BwpH7fPjVHTEFY0wNOAlkyjr4F5GV1Anjc=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 15:18:28 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::eb) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 15:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 15:18:28 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 10:18:26 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Sashank.Saye@amd.com>, <Jeffrey.Chan@amd.com>,
 <philip.yang@amd.com>, <lijo.lazar@amd.com>, Zhigang Luo
 <Zhigang.Luo@amd.com>
Subject: [PATCH 3/3] amd/amdgpu: improve VF recover time
Date: Mon, 25 Mar 2024 11:18:05 -0400
Message-ID: <20240325151805.6379-3-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325151805.6379-1-Zhigang.Luo@amd.com>
References: <20240325151805.6379-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|MN2PR12MB4272:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e881b8-c07d-4753-d475-08dc4cded2b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSiMOpINt9RN6x/Q8T4B1OYI4d2IrnC9CPvt11ZlsThi3si4if6Tcou8hUsEJJbeVILQq8fx2ca20QAkfZhV9IoNTd0dhkv5xyA6JtWmwZP9r3wVyn3CAArVgCQZH9QvHO5pY4tE7f1Af83pNrf9sfuCdzgTDyDFRijI69YjkXBnZ4IzMFlwEJngM4LHe1EydnGS5RONvvlclDmr2KjX3NA7RLlQ6qQnLxjZt8NjJ/Ult/LiA40tai/iUwFBR2VJVyOkmBdiYItZy0IluGVA3R5GMhB4FGBGuPIQoogWEq2O9btLDMkcWieRfdVmeA2wZ6d/Rw+K1ABREQ9W0LQuVM660iYWpty2HXZVv/qfmYjemjvABNOlzE3zJzz0OSyyl6Rj7z880Lsm9/NI4VcbvsFQOB0eEFgVMCWxGR4Bx0HLs1yChTDPQCD4GuFkXRXI433f8VxX8XibtSzNEwjMmOomPukdE1OwolDVv38iXpwQ2jlYCr3+XMNTewR7ExiB76PMwGzbC7KXeeiF+DiQMxd8zRViWsW8vO54t1iTW5G2wg5P6GHs8/4Vig3gbYMGp6bHQWQFXRITotbjVYFD4Pa5e72zgDE5tSJfZRZMuFZxWEaSEKgvf7VHZE6QvmstMH5FlWiY9uwlpcOlu1X8cvpkO2idn43kUA0YGq6DrfwAbIBoCdjU95vDb3i23T3p00VR/yVbQB7AQ9ywwbwnxl53ngpGlUQt6SZCzdvl5rl7DRRiESSCt82GYm5ufB4M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:18:28.0362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e881b8-c07d-4753-d475-08dc4cded2b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
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

1. change AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT from 30 to 5.
2. set fatel error detected flag.

Change-Id: If1e0357deffa4549d4e83e925c8d764f7f8c9f42
Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2867e9186e44..50f87fff778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4984,6 +4984,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 		r = amdgpu_virt_reset_gpu(adev);
 	if (r)
 		return r;
+	amdgpu_ras_set_fed(adev, false);
 	amdgpu_irq_gpu_reset_resume_helper(adev);
 
 	/* some sw clean up VF needs to do before recover */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index aed60aaf1a55..4b6e50cfba08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -593,6 +593,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 		adev->virt.vf2pf_update_retry_cnt++;
 		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
 		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+			amdgpu_ras_set_fed(adev, true);
 			if (amdgpu_reset_domain_schedule(adev->reset_domain,
 							  &adev->virt.flr_work))
 				return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index a858bc98cad4..0a57b637c4bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -52,7 +52,7 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
-#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
 
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
-- 
2.25.1

