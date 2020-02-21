Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9945FC35646
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 18:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF5B24650
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yd2ztYHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF5B24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9276E46C;
	Fri, 21 Feb 2020 18:45:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F806E46C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 18:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBCqVNjTPGU13j8bueS9aG2gjtIpjio9/vVH1WG/m7WMTKnmbxpp6a+0wst+Q+90ZQTnZJ+4P1B+Z400v/Cp+Wb7EYz5Czlen1KAZqghTviGVEnAyv+f5cSGh5imBexFl8o/TR9kQTA+STyF3SYcoovqmVit5+sRTP69abGoj0/RQT07a2734mr0f2JLg2Ly3HN2Cu0zG5tn4K9NdXVmIypOseMx5nowLGZWDKefdlJEkMedHYPJZs+KldjBC7cx4a/jA51w3QRWvTqJpxHmJX3wmbCMnmu0CwqsfglHPHBSEvt6i1gcE4rEhR/Kfn8KVCLwX/DqmGMoDJVn6eK86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEn5FZ/drsIWFHW9dg0v6zIqxz/PehGTDD2K6DwpY6M=;
 b=SSxbISOtnZHwJcud0q41BuMefAEEwmq9C55NVPNt9RE3mPpozrHeSNvTw4YAhlDfSEfZPDutdrjt3Uc87HqOVy5pTliSsA3HWAej6pNbK3GXsqYLPJdtK2yKwh1GJNd7VrAOGtSifcpIPA6CCfZ4Yj2QZIUhmHSOmnU1e6CW1sXgBBndIOQVCt9UYao+vMpfDjsFG5LWy9ucogOStmSo/o8Xfqg1r8hiLC0e+c/+BAuRfy4XqwIqmEvI+sMzfQcB+hrPyswrkYz0INMPIAtj9OM1eKAPwsya/2azp4ZUQA3zJGeuQrpe5sjFt0he5M4pq6CYY1q+m2CULS5OhoqBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEn5FZ/drsIWFHW9dg0v6zIqxz/PehGTDD2K6DwpY6M=;
 b=Yd2ztYHJHXsendHvM/lZrPJOEEG8QX6ttSQdezv2NPtEOoKShWmfo38QKz7M1tPG7bFlkoYT0lxFAHewPj51hczXNrt7BCeUG9jfHYTDZ2lw217oYtPANhO1wjbHreUzLf0GyEl6PVsqAFkRu/U3F+y3C/J6ZzDegG8ifLS1JPk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from CH2PR12MB3927.namprd12.prod.outlook.com (2603:10b6:610:2d::13)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 21 Feb
 2020 18:45:20 +0000
Received: from CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::54a8:8b32:7a8f:488c]) by CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::54a8:8b32:7a8f:488c%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 18:45:20 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Add gfxoff debugfs entry
Date: Fri, 21 Feb 2020 13:45:10 -0500
Message-Id: <20200221184510.636829-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: BN6PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:404:23::32) To CH2PR12MB3927.namprd12.prod.outlook.com
 (2603:10b6:610:2d::13)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 BN6PR03CA0022.namprd03.prod.outlook.com (2603:10b6:404:23::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Fri, 21 Feb 2020 18:45:19 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d742b09b-db5c-463e-348e-08d7b6fe3399
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:|CH2PR12MB4277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42776013A2CDB98BD1978A9FF7120@CH2PR12MB4277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(189003)(199004)(2906002)(66556008)(66476007)(956004)(1076003)(4326008)(6486002)(5660300002)(6666004)(36756003)(66946007)(316002)(86362001)(6916009)(81166006)(81156014)(8676002)(16526019)(186003)(2616005)(26005)(7696005)(52116002)(478600001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4277;
 H:CH2PR12MB3927.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMUqiEQRbuVTFXm3gOKBt49fHnu6CRKGFex4IDhY2sImoayAyQ5bjrnnSqkGCC+0tGExkyJeRHD1Tzf3QaSG0jjuXmZlGTUv25Pbxm3lZIJIYUpQFAOlZBH8OFHceupRb6QLSy4767PZZ2jVUvFq0O1gaoWqaE6cPmMWufvLmW69p6NbbIeea6oeJjjk0+7FArcMwFFiOfTV4whw9Wz/qBJkU+VuwEd3FY2nJDqb1HXdvx9nlCSnoC9qTSLK9b3aCrAwguRVua4rKqV6A4g9IKTPy6D18uUMjzTsgb0uUTajGTBg+h2TrYYyjf3VodIh7f0doXRBBOFtavy/68joaVWdGStEcVBDWXBWt9GjxEr38lIc5zob5N9FuIHq1azksBuuS4d0QSSlF2oMj3ro9mON/LPuJixrtWwyGjweiT7d+2P1R41RYYJ2tuvp3NMx
X-MS-Exchange-AntiSpam-MessageData: I6/vTyPC0PIUNuR8E50tGaB/rstXH92iyzCidbnF33asbXFrPjAHxAUD+HEDAE7r6NUUxnWz20URw9UvE+k162PbRAS0iQcxL+7EzVtRKq22ZxtErhOLvQZ4GNunf/3cHdT7bc/qFbnuSCfQN2/Cjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d742b09b-db5c-463e-348e-08d7b6fe3399
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 18:45:20.2310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQNpj4J8r412hlq2Lo/VgZQf3357M7xkIPGXyb3kmLluAMm84NRQ9PsbQ6LcsCoXW96Zr74rEeNoGe4sD4XeCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Write a 32-bit value of zero to disable GFXOFF and write a 32-bit
value of non-zero to enable GFXOFF.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 56 +++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 7379910790c9..3bb74056b9d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -842,6 +842,55 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 	return result;
 }
 
+/**
+ * amdgpu_debugfs_regs_gfxoff_write - Enable/disable GFXOFF
+ *
+ * @f: open file handle
+ * @buf: User buffer to write data from
+ * @size: Number of bytes to write
+ * @pos:  Offset to seek to
+ *
+ * Write a 32-bit zero to disable or a 32-bit non-zero to enable
+ */
+static ssize_t amdgpu_debugfs_gfxoff_write(struct file *f, const char __user *buf,
+					 size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = file_inode(f)->i_private;
+	ssize_t result = 0;
+	int r;
+
+	if (size & 0x3 || *pos & 0x3)
+		return -EINVAL;
+
+	r = pm_runtime_get_sync(adev->ddev->dev);
+	if (r < 0)
+		return r;
+
+	while (size) {
+		uint32_t value;
+
+		r = get_user(value, (uint32_t *)buf);
+		if (r) {
+			pm_runtime_mark_last_busy(adev->ddev->dev);
+			pm_runtime_put_autosuspend(adev->ddev->dev);
+			return r;
+		}
+
+		amdgpu_gfx_off_ctrl(adev, value ? true : false);
+
+		result += 4;
+		buf += 4;
+		*pos += 4;
+		size -= 4;
+	}
+
+	pm_runtime_mark_last_busy(adev->ddev->dev);
+	pm_runtime_put_autosuspend(adev->ddev->dev);
+
+	return result;
+}
+
+
 static const struct file_operations amdgpu_debugfs_regs_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_regs_read,
@@ -890,6 +939,11 @@ static const struct file_operations amdgpu_debugfs_gpr_fops = {
 	.llseek = default_llseek
 };
 
+static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
+	.owner = THIS_MODULE,
+	.write = amdgpu_debugfs_gfxoff_write,
+};
+
 static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_regs_fops,
 	&amdgpu_debugfs_regs_didt_fops,
@@ -899,6 +953,7 @@ static const struct file_operations *debugfs_regs[] = {
 	&amdgpu_debugfs_sensors_fops,
 	&amdgpu_debugfs_wave_fops,
 	&amdgpu_debugfs_gpr_fops,
+	&amdgpu_debugfs_gfxoff_fops,
 };
 
 static const char *debugfs_regs_names[] = {
@@ -910,6 +965,7 @@ static const char *debugfs_regs_names[] = {
 	"amdgpu_sensors",
 	"amdgpu_wave",
 	"amdgpu_gpr",
+	"amdgpu_gfxoff",
 };
 
 /**
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
