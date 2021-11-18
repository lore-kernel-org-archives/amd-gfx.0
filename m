Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7415EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B89D61057
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 18:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B89D61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26956EA34;
	Thu, 18 Nov 2021 18:19:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671426EA61
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 18:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmjcCuQu4zgFkH/0cQGePfOFEQlcvwG+bWYab0Ljhsuopp9JULR5Y+UBHNYHD3524szA3mymQcU8LqOyHCEg6l98NbYeqd6Ck3rygIo2xpmkv1+l3p9+79isaUpBEKDJfm7Z+X4X/cSZyC7MPpMlGBR9JtqvlAPKtVmJdaA3g/LhyLTLJMZT1UjbnrRmXyiNEFnKLHAOI8Og7moz0fHQjgfBiIssEZrsNlWohI0hjdCknWMkxagTISGD7yRxxeuynaAsBv/6Ino5+uurqFm2Jjf/ZX3MLSZ5bEyN2xvOaVeF+uiaCndqVY071nswVR7uAhyw49XLkwynfiKbbsI/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZviafM32QOiQnO406MFk3jDOdql5ToLuijMxtJX8/A=;
 b=ja7e0CX/eV+EEr3zn5fa4JSAKKPgCdqzlcMt5LF3Y/0tM9YMtG2IQBZ9k1dTWe7iQ6VOJo5TFUz+IFlKCN159saaUPOzOIRarlyVuzl82W6rVlexWpfUD9+ssZmDgPAP8Ns4cAfkFLIMkswhyXZPujN0c9MeQIC3/iKyu4tOu7/zrfv+UJuSucbiuB+dGkSzwa4CZuf/SVdTiX1Z69uE+8B71Nv4sP9GSMXqdi/8z0txT4qcWndMgcPXHwPwhSlhXPvefQbuwPP+h4mqbaovUM6OnxCrjX7Cjq1UmiSa4b/37ASyi6fmNUM/lwXgwe3VqZI96IiNZvZ7YKGZpjauzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZviafM32QOiQnO406MFk3jDOdql5ToLuijMxtJX8/A=;
 b=nk84xGJhymXah6mJvZEFB2TgzDB3JYadpFdj6pgFbzGOcdF2VriP8mWx89rzfZD+eqNQI/8o3fz3kqKmC+t0us/TbFnmNiKC3u7Ogi1cNYeelhY0QRcVnGatNNJbiQag+ElU8hLnkLJXEevWZU7C+XHzDMqCEkTzN5UnpDc6mwk=
Received: from DM5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:3:23::34) by
 BN6PR1201MB0035.namprd12.prod.outlook.com (2603:10b6:405:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 18:19:08 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::25) by DM5PR13CA0024.outlook.office365.com
 (2603:10b6:3:23::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.18 via Frontend
 Transport; Thu, 18 Nov 2021 18:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 18:19:08 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 18 Nov 2021 12:19:05 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC 3/3] drm/amd/pm: Add debugfs info for STB
Date: Thu, 18 Nov 2021 13:18:27 -0500
Message-ID: <20211118181827.237115-4-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
References: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031d8d7d-61aa-4c3c-545a-08d9aabfe97f
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0035:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0035D0F2E5D3BCE85F2B8C79EA9B9@BN6PR1201MB0035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkEoCKLhJIEuTmbnNA/Cnv0VQgH3AgyEVPPz9HwRoVOLcL1v/fDZ+A96dpBxcSg6jMcnjKtJtZDsBPRftXsa2uozoosduOkpdSBmk0EXfHPPhAQxOLtbTVswN//I1NZYDBW48JHZk7HjVsQJH3HatW731CSi7YeVeNPjNDJInvpx8O22E8Zx8u7Gm/zcFGhxuB2+ABPLLCXn/YmN5FW3vaqqdDzJyEkuvY4nH/tmlNj7nTkyoeRTrnCaprqkNEQx6tiAT4tOwM8yWNlrrT7sCau+Scxt72adS6mveZaP+KYKy0OVgL5l1IsY1AYPV1H7LC1imFZ8ElpbCZ9QdVAOws1L4wjMBfUeMiOWd+4yzPROx+3n0EZTSZrE8QQ6nBITxfqdF7DXhtQKO9wRv8C+zWv77B0engvkt737euUHeHn6a4OSviQqLi4XH2IYKVSGVgRd+c9PmAEN1YQH5rOQZZDwszu9bxI1bwnFZK3rMwLiFmQ+P2FABK3rHlT6ZOXdjhleV9bzU2ayakgKUxonhsJobkecYZ8pDOxzObxqRfLOWoKgA6OTLGIx+yEYkt7Wo7zZU07wHle7jBtA74Dn7IbC2mFap1V67/bYwa+qNN5ev+p/pc+A5iygDO6wjbBDT0VO/w29s5fmpRe7MfUikJGB0tbWE2Cb7r1DCln32ScRULHW+UyuRZH6EaJqEAFHsu/IcAxrwFaLat+INkSc50ca9VETiiRKHlWRTT1oTMg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(86362001)(47076005)(316002)(5660300002)(1076003)(8676002)(6666004)(44832011)(336012)(2906002)(54906003)(426003)(7696005)(70206006)(8936002)(81166007)(186003)(508600001)(36756003)(16526019)(356005)(70586007)(4326008)(6916009)(36860700001)(82310400003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 18:19:08.1497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031d8d7d-61aa-4c3c-545a-08d9aabfe97f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0035
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
Cc: alexander.deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 luben.tuikov@amd.com, Shyam-sundar.S-k@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add debugfs hook.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  2 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 86 +++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 41472ed99253..49df4c20f09e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3759,5 +3759,7 @@ void amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 					 adev,
 					 &amdgpu_debugfs_pm_prv_buffer_fops,
 					 adev->pm.smu_prv_buffer_size);
+
+	amdgpu_smu_stb_debug_fs_init(adev);
 #endif
 }
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4301403af761..f738f7dc20c9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1420,6 +1420,7 @@ int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
 		       uint64_t event_arg);
 int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc);
 int smu_stb_collect_info(struct smu_context *smu, void *buff, uint32_t size);
+void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev);
 
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 97bafba4c5c9..f5e739d40b04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3193,3 +3193,89 @@ int smu_stb_collect_info(struct smu_context *smu, void *buf, uint32_t size)
 	 */
 	return smu->ppt_funcs->stb_collect_info(smu, buf, size);
 }
+
+#if defined(CONFIG_DEBUG_FS)
+
+static int smu_stb_debugfs_open(struct inode *inode, struct file *filp)
+{
+	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct smu_context *smu = &adev->smu;
+	unsigned char *buf;
+	int r;
+
+	buf = kvmalloc_array(smu->stb_context.stb_buf_size, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	r = smu_stb_collect_info(smu, buf, smu->stb_context.stb_buf_size);
+	if (r)
+		goto out;
+
+	filp->private_data = buf;
+
+	return 0;
+
+out:
+	kvfree(buf);
+	return r;
+}
+
+static ssize_t smu_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
+				loff_t *pos)
+{
+	struct amdgpu_device *adev = filp->f_inode->i_private;
+	struct smu_context *smu = &adev->smu;
+
+
+	if (!filp->private_data)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf,
+				       size,
+				       pos, filp->private_data,
+				       smu->stb_context.stb_buf_size);
+}
+
+static int smu_stb_debugfs_release(struct inode *inode, struct file *filp)
+{
+	kvfree(filp->private_data);
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+/*
+ * We have to define not only read method but also
+ * open and release because .read takes up to PAGE_SIZE
+ * data each time so and so is invoked multiple times.
+ *  We allocate the STB buffer in .open and release it
+ *  in .release
+ */
+static const struct file_operations smu_stb_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = smu_stb_debugfs_open,
+	.read = smu_stb_debugfs_read,
+	.release = smu_stb_debugfs_release,
+	.llseek = default_llseek,
+};
+
+#endif
+
+void amdgpu_smu_stb_debug_fs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+
+	struct smu_context *smu = &adev->smu;
+
+	if (!smu->stb_context.stb_buf_size)
+		return;
+
+	debugfs_create_file_size("amdgpu_smu_stb_dump",
+			    S_IRUSR,
+			    adev_to_drm(adev)->primary->debugfs_root,
+			    adev,
+			    &smu_stb_debugfs_fops,
+			    smu->stb_context.stb_buf_size);
+#endif
+
+}
-- 
2.25.1

