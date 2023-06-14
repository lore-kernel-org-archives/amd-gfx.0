Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA02EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 11:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258C910E120;
	Wed, 14 Jun 2023 11:28:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEF610E120
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 11:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc/olgkRt8baLRET4L8bhHecYicN6n1UwASZfXF05VGScd0X3GAr02QrebIfUxW+El9OSb3dhHlJJlIXsg6GYOPZRGYyViUowfuR2wHWmagFMxeNUQ09B4OEMct9xqk4r3W6kqREMKmAo5SVcKNt4zcXnWOqLodU5aTwV0PUeNT0f2XsH+SbrmsQs1e2GqQu7nVpiy9VmHKuuq7xospAKcNtciPH2rCkcHyuP3vBpde2+4lhY6zgOxCdIpusOHMvmz1s5dTEFQm+Kbp12A0/JW7ZE0HL4LN2qntvXWe/G3KY44/wgED5QfTU0xfgALOCr0i+BAbd+eLmLn21iP3q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUj406accyqRn7TxIYRCDvErfnrbpFHXsTLF99uJN7A=;
 b=FO2NN6FozECs7i6P/1Q3YVuWkoiozOPGl0UbzIKfnVPi8pyBeqK2AQDNjkjv7loAVHen+4O2+GMqlB+VvF73OcDJOxOZJ6PrpoQVnrHgwbjVSNL/D66ZQ5ThkDgCzSgr7VkNPidgBjNPNzalg5JUxDwd9szF//hihvwuqecmG0YqO8p/yV+Acqqg+MY5V4Nq6YiDISQc9KQ+8Hvw07oApGsbQioJO2675QMSPYQ8Rr2fTURXGGE+DcW36V0QyguwcJJlaUZu0j1IqLDlTW790Q46fOYhptL+xwO+M1ADghr7Nt1YhMzD1Nqh5YoCl0yd/lFt8BP5vNt51pPhDaopmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUj406accyqRn7TxIYRCDvErfnrbpFHXsTLF99uJN7A=;
 b=pid2Esv65rTLwXpnelLOajVCPbLbM4/OeU1Nxeww0ogr7nv3hVgj/Pwael6PEAgeD2KV1PknWwZvK/MEv/qNa3wUbkVICfUmmw3+AFqFrQkT+1O7kQrbwUkId96IoKIjApxAT5pZhcOtpNtV4TfT5mirrFTSsET5LY6uIG8R8VE=
Received: from CYZPR05CA0040.namprd05.prod.outlook.com (2603:10b6:930:a3::17)
 by CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 11:28:14 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::fd) by CYZPR05CA0040.outlook.office365.com
 (2603:10b6:930:a3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Wed, 14 Jun 2023 11:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 11:28:14 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 06:28:13 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add amdgpu_timeout_ring_* file to debugfs
Date: Wed, 14 Jun 2023 13:27:58 +0200
Message-ID: <20230614112758.120429-1-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CH3PR12MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: a2247a0e-522e-4628-8876-08db6cca716b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eec2YefjspcF9E49wrYwhuqx178L7SM1yCpJpJ4CXSSaBm4uooC3kCYnbFyeAar1NYqpFSMH+DHVnrZUmlP2iImgqk/Ry7yoZnq0ix0Z6E3cLyPYb9pYXf6MPpoUmuL0RrTI1ZCxotkDIHmgfXMiJxZOSoDDnTKY9IgV8hUkWW78UDiO6uDX7s4kCHrE/txgPlTE/NDoZ3RGOsBCo5xNw96cEaEoRPNy7zCHoJzgERVM86AgV+S9yXyK6S1V8zicJ+Mp9kZYGEOc41vkQ8m/pW8DtqdfcNGuiQIWCZX1PxuD0tvZHAHJ1I7HlHHSPHqlagbb22CI5YMTt17QuGOUi0bo/JlMTd9e8qMXOaAxFVzeeXHBnEwXDnBWsHp9zwtfjFcslK3EK9I+b8Ni+yr+KIQmgLfXPwjQyb1ga2uzOGPmaDcs/IXOMg3rdoWgr3n3npGxammvqtGXG3wzaSUHiXkRU3hTWHRbNwY9jJQnmHbon+kZ3uHIYnnXgKcPWpuyaAm3k5diQkh140+6JgrahpoENGYqgCtvoQtLfoREr1/YYgu9hQ9Z+v37nCk2+0Sk/dgk4xAUTyKXeyoHx+/VZfUbq7ElP93TqSTvg3iVXyZBhM9/uhvq6vTvceozZLLiDfoZI2CXHw7gh7wGRo5UOjaGeaGsjkzUM8xaljnBfmXiYRCx122LJf/VsGI1ONesrnLaxKTzDyQSWljbK2mKgB9rlrPZqsEr1LjNIce8gjONnd0cN+sZAjtUqAxlUtjiD2T7zjNo96AwdtBorBBQHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(70586007)(70206006)(478600001)(8936002)(36756003)(5660300002)(8676002)(6916009)(6666004)(4326008)(82310400005)(336012)(426003)(41300700001)(40460700003)(7696005)(316002)(356005)(81166007)(82740400003)(186003)(47076005)(2906002)(86362001)(83380400001)(40480700001)(36860700001)(66574015)(2616005)(26005)(1076003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 11:28:14.4029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2247a0e-522e-4628-8876-08db6cca716b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9193
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Report the per-ring timeout in milliseconds and allow users to adjust
the timeout dynamically. This can be useful for debugging, e.g. to more
easily test whether a submission genuinely hangs or is just taking very
long, and to temporarily disable GPU recovery so that shader problems
can be examined in detail, including single-stepping through shader
code.

It feels a bit questionable to access ring->sched.timeout without any
locking -- under a C++ memory model it would technically be undefined
behavior. But it's not like a lot can go wrong here in practice, and
it's not clear to me what locking or atomics, if any, should be used.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 32 +++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..32d223daa789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -471,35 +471,65 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 	return result;
 }
 
 static const struct file_operations amdgpu_debugfs_ring_fops = {
 	.owner = THIS_MODULE,
 	.read = amdgpu_debugfs_ring_read,
 	.llseek = default_llseek
 };
 
+static int amdgpu_debugfs_timeout_ring_get(void *data, u64 *val) {
+	struct amdgpu_ring *ring = data;
+
+	if (ring->sched.timeout == MAX_SCHEDULE_TIMEOUT)
+		*val = 0;
+	else
+		*val = jiffies_to_msecs(ring->sched.timeout);
+
+	return 0;
+}
+
+static int amdgpu_debugfs_timeout_ring_set(void *data, u64 val) {
+	struct amdgpu_ring *ring = data;
+
+	if (val == 0)
+		ring->sched.timeout = MAX_SCHEDULE_TIMEOUT;
+	else
+		ring->sched.timeout = msecs_to_jiffies(val);
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_timeout_ring_fops,
+			 amdgpu_debugfs_timeout_ring_get,
+			 amdgpu_debugfs_timeout_ring_set,
+			 "%llu\n");
+
 #endif
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			      struct amdgpu_ring *ring)
 {
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
-	char name[32];
+	char name[40];
 
 	sprintf(name, "amdgpu_ring_%s", ring->name);
 	debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
 				 &amdgpu_debugfs_ring_fops,
 				 ring->ring_size + 12);
 
+	sprintf(name, "amdgpu_timeout_ring_%s", ring->name);
+	debugfs_create_file(name, S_IFREG | S_IRUGO | S_IWUSR, root, ring,
+			    &amdgpu_debugfs_timeout_ring_fops);
 #endif
 }
 
 /**
  * amdgpu_ring_test_helper - tests ring and set sched readiness status
  *
  * @ring: ring to try the recovery on
  *
  * Tests ring and set sched readiness status
  *
-- 
2.40.0

