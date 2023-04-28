Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2161C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 10:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F06210ECCB;
	Fri, 28 Apr 2023 10:48:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB16110ECCC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 10:48:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrxPk0kaQ89BNvpR3FGqpJm9qz5G39GlxoGcpnpJF4FLZk77LyCUXFefSDA5slahTHFDTwSpRyfXb4YIIyE3ipGTf4CwS2RVWr98jZo/Njeyvu8d421jdHTgaXizKSt5hRQ1WSPhC7qFTiOcBtrRwxSkQnoNSgDhj8rELoonwdDP8CSgTomdRHU9Ob+DQbrK200dYNNVZLmg0rXacmtiZ90f9xSps2mWXNU5gA9FF2iQ5NHIuv9egD3bImcWKUmt2t4AgXVH9LGqSENn+NuzuJjFVpUy5UdfUaNL2gjKaWN2sheMbcnEKLdUpuHfvcXR/kOKPyB76qwJYO6GpD6Gwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkuwy/GoGwYju6K+OX0NulkN7hJMxcUU1gLuTatXRsc=;
 b=S09JdWGmR/wdPJSyPanDEiqdZTOVmy42yhjU0WVHhRMV7vu8ng2C2/+i28l5HKC/TNIgbUzwWF0LjC5PeazNo4ifNyUlDLgLnZuCVbwSKGZAfJVV5rVIFHmLsaf/wJqtxmsmd0AIjuGYWgYYL0+xRmO2okvOeoOxiTMD93EAL9lvgQUXf5yBNougXzso8B9J4qJV8NZV8he9HMPBZLDOrsrPWZAbMHyzl7mvQ5CWQ1+SQOahKgzyO3Wu6Q2k0MyC1KuObybWDxZ5t1jhUqnPTgmAYHgqDTCGDyX5aXMQcueaumdLjyLSf5ybPq5w/SYCE4LeoBGiTrmXGyfTngjxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkuwy/GoGwYju6K+OX0NulkN7hJMxcUU1gLuTatXRsc=;
 b=JdwV+Y8yVuO5tgFjdVJSrDGANh/FoVTpTQ1RmksZds9O8AS9Calj33IVDT6AeT0exC2OUNmKF7hcqlEPctvU+H+zVPRF+HeusiJKVhD0vP0svf6gEC9A4ywBb2udktlI/64mlbLlpt44CqDBNP6F0wjTm/vT+iz56M7CQG1X3rY=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 10:48:32 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::7a) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 10:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 10:48:32 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 05:48:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix style problems in amdgpu_debugfs.c
Date: Fri, 28 Apr 2023 16:18:15 +0530
Message-ID: <20230428104815.4183212-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: d32433fb-8a5f-4e74-c780-08db47d61c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxbyRNKGapCABrJTd9v0/kKIIxyQRMchoTpXgiLJcqheJdOd3M2omLxq+f8MZi4PDcMc4h/pvGyvoo3WBR2KZi5U4znQLCtEXPOBwEHK6UAEnvkqzQxXhrR8H6fF54PKDgLRO5VfuoyPcqGBRMEGnwj7p18vrIgKqhLaa7/zqBQvrUF1NX99DhTJZWKqCGzzGrz8bqowcvxblbfmg3AKb1Jf4xc6JybOiivIIayjtQokIkQVsSf/LF6rSPbHGBnIiqF61BKbP+O4U8TENdrB2LgP4mNs2HGTrUG1oc6+e8Mwr3R+YlV29FLSQ1gyM924laZ73xdw+jrkS0ZrJZD3UQ2QCbBOa3xYkDFiD2csd9o73xQW75ndG5Lo4Huj1cWiy28HZ89Yhv1Dinyjx7NnxtKZa/9/5ZI4kCrW2qBGPNKmLjEskse+nnRXMzwM5z5FHN/dPoWOroTZ6M5eJcxbCvQX0A1KyNds1LHrU5W76LBGE4WInWAXFJCMyfwyJRfIjqTIsOqA78er02KI7B9QrTjGvcGNwLISRa7hcITjDmuNcH/dqAis4ckrhSS0dBtKkFgO36hV4U81IGYJxx4dtKeao3hn97dihMk6p+HSR7gy9eJKSUWIRhLfqL7DbCOIfoMZw93/FkE5a/H6EF6eYec+nVwWFjhuBmj0igYEMZtZRlXlM6zCfef9KJfi762e+NDM2myDaEgAWgt2aFTiGEXSafAFhvH+yjA16QY9Fhg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(41300700001)(26005)(1076003)(47076005)(2906002)(66574015)(5660300002)(40480700001)(8936002)(336012)(36756003)(8676002)(426003)(44832011)(81166007)(40460700003)(83380400001)(356005)(16526019)(54906003)(186003)(110136005)(478600001)(7696005)(70206006)(6666004)(82740400003)(36860700001)(82310400005)(4326008)(6636002)(316002)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 10:48:32.3873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32433fb-8a5f-4e74-c780-08db47d61c31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following issues reported by checkpatch:

WARNING: please, no space before tabs
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
WARNING: sizeof *rd should be sizeof(*rd)
WARNING: Missing a blank line after declarations
WARNING: sizeof rd->id should be sizeof(rd->id)
WARNING: static const char * array should probably be static const char * const
WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
WARNING: Prefer seq_puts to seq_printf
ERROR: space prohibited after that open parenthesis '('

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 28 +++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 547abe155820..b95e458f86c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -56,14 +56,14 @@
  *
  * Bit 62:  Indicates a GRBM bank switch is needed
  * Bit 61:  Indicates a SRBM bank switch is needed (implies bit 62 is
- * 	    zero)
+ *	    zero)
  * Bits 24..33: The SE or ME selector if needed
  * Bits 34..43: The SH (or SA) or PIPE selector if needed
  * Bits 44..53: The INSTANCE (or CU/WGP) or QUEUE selector if needed
  *
  * Bit 23:  Indicates that the PM power gating lock should be held
- * 	    This is necessary to read registers that might be
- * 	    unreliable during a power gating transistion.
+ *	    This is necessary to read registers that might be
+ *	    unreliable during a power gating transistion.
  *
  * The lower bits are the BYTE offset of the register to read.  This
  * allows reading multiple registers in a single call and having
@@ -76,7 +76,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	ssize_t result = 0;
 	int r;
 	bool pm_pg_lock, use_bank, use_ring;
-	unsigned instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
+	unsigned int instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
 
 	pm_pg_lock = use_bank = use_ring = false;
 	instance_bank = sh_bank = se_bank = me = pipe = queue = vmid = 0;
@@ -208,7 +208,7 @@ static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
 {
 	struct amdgpu_debugfs_regs2_data *rd;
 
-	rd = kzalloc(sizeof *rd, GFP_KERNEL);
+	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
 	if (!rd)
 		return -ENOMEM;
 	rd->adev = file_inode(file)->i_private;
@@ -221,6 +221,7 @@ static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
 static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
 {
 	struct amdgpu_debugfs_regs2_data *rd = file->private_data;
+
 	mutex_destroy(&rd->lock);
 	kfree(file->private_data);
 	return 0;
@@ -324,7 +325,8 @@ static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigne
 	switch (cmd) {
 	case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
 		mutex_lock(&rd->lock);
-		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
+		r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data,
+				   sizeof(rd->id));
 		mutex_unlock(&rd->lock);
 		return r ? -EINVAL : 0;
 	default:
@@ -863,7 +865,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
  * The offset being sought changes which wave that the status data
  * will be returned for.  The bits are used as follows:
  *
- * Bits 0..6: 	Byte offset into data
+ * Bits 0..6:	Byte offset into data
  * Bits 7..14:	SE selector
  * Bits 15..22:	SH/SA selector
  * Bits 23..30: CU/{WGP+SIMD} selector
@@ -1429,7 +1431,7 @@ static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_gfxoff_residency_fops,
 };
 
-static const char *debugfs_regs_names[] = {
+static const char * const debugfs_regs_names[] = {
 	"amdgpu_regs",
 	"amdgpu_regs2",
 	"amdgpu_regs_didt",
@@ -1447,7 +1449,7 @@ static const char *debugfs_regs_names[] = {
 
 /**
  * amdgpu_debugfs_regs_init -	Initialize debugfs entries that provide
- * 				register access.
+ *				register access.
  *
  * @adev: The device to attach the debugfs entries to
  */
@@ -1459,7 +1461,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 
 	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
 		ent = debugfs_create_file(debugfs_regs_names[i],
-					  S_IFREG | S_IRUGO, root,
+					  S_IFREG | 0444, root,
 					  adev, debugfs_regs[i]);
 		if (!i && !IS_ERR_OR_NULL(ent))
 			i_size_write(ent->d_inode, adev->rmmio_size);
@@ -1494,12 +1496,12 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 		kthread_park(ring->sched.thread);
 	}
 
-	seq_printf(m, "run ib test:\n");
+	seq_puts(m, "run ib test:\n");
 	r = amdgpu_ib_ring_tests(adev);
 	if (r)
 		seq_printf(m, "ib ring tests failed (%d).\n", r);
 	else
-		seq_printf(m, "ib ring tests passed.\n");
+		seq_puts(m, "ib ring tests passed.\n");
 
 	/* go on the scheduler */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
@@ -1982,7 +1984,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		amdgpu_debugfs_ring_init(adev, ring);
 	}
 
-	for ( i = 0; i < adev->vcn.num_vcn_inst; i++) {
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (!amdgpu_vcnfw_log)
 			break;
 
-- 
2.25.1

