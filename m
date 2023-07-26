Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4DEC001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 15:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C866710E0F2;
	Wed, 26 Jul 2023 15:45:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9264E10E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 15:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzc66RzGB3eLJuUvmc47A7ggK+ubeNC/rSI9JHaQvtFLQn9qAcyXj9qT3YGGhbSjag9FNrXQolfK/pq8GofkeUE1QqYKTLWpIdPLsnzmxi70tP7Toao3C44eu7igTsbtZNog4JwRtGogiFlv+yOPphsN0HuQejC+Al8t16Y+GR61B5NeJ5x5CIGv7ABKX10wHQjIuCn4N5Y+OMf9gp/U87VIkj08PC9Ty2e49GhhgHi9bmNDocTSVhBHsAKJ5ThxOMmReO89asAqJPH53eJqiktZWzwnFBlYSLqtNfHmM87OyfLov0KL+6FnH2DfUNX+67C2dTUa5Zn+ojTiBUJl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db3Z7h8VFGZT9/me1qUdJJZuoUJrOJokLCSQxDmajxg=;
 b=C/0RBru/HacrlQsFSiRglJjwnPLxq99MG6q+99j1yYOdSRDLy99Uss//yrCervb5BcdVw9k2JjY+DJkV8e5npdF/bMRJgq1rJFZAKDtOmZrDgCCGrPnPElHf6uV+l5M1BsGuCEXA6lBGwWKPswFjwbmqAqdooKaRbZZid2jbbVmTLGvarRj3R+VUtkk2qFCBnxl1oZkx90guvahyE2dNb40v1K3aHjAPhlVxiZP1YgJL1ksM3tW+PfgZFvlWdcvwkKEgS1z6gLJV8vz0jmSPyxV86nsPFWe+Y5QtIo420f5sLTjoZkQrLAqNtZAy+bBklVPcA0Hd+iAFG3xDPkAfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db3Z7h8VFGZT9/me1qUdJJZuoUJrOJokLCSQxDmajxg=;
 b=KQ3HCuLv0uweTMHagZyQGJ0QgcHyNy9jQpEu8BJaVtwqGqT8dHR1gAAURKrP8bysbmxGA9WEalggrHc8ESI91aDnKZ61R8Nfz/yq9rOdNPOF8ykPJTYPGpu7QvDwmoDVDsGrlqrAcseGCH6TwGFWPoUcJvWDqEnJ7eGgddO+eyg=
Received: from DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 15:45:19 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::da) by DM6PR08CA0045.outlook.office365.com
 (2603:10b6:5:1e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 15:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 15:45:18 +0000
Received: from pswarnak-Sharkstooth.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 10:45:16 -0500
From: Praful Swarnakar <Praful.Swarnakar@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix style issues in amdgpu_debugfs.c
Date: Wed, 26 Jul 2023 21:08:51 +0530
Message-ID: <20230726153851.2219088-1-Praful.Swarnakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 136fb576-b11e-487c-f418-08db8def504d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNSxcSDQ1ltycSkEaNfEYa87eHLz1sNGEANT/kE1iDUjGrX20G0JkhdVkpTmVp1+GdxqXhH2UZbs5JuKR+S+M58o+JgKUSiWbqr1caCeeWpQFBytfpRSjgaARoQvWkqPT9VCQGC90FXUWK2gVjTVsQpFf3+iKgZcw91AkQVbOdZmg/jw/Rs4cn8+Hbh62J3yVXVrZ09/QwD4qHb149UKFXuX9pG5/xpNuUsAJg61DkV0RjbDXzgyyMzYBdyTsqdLK9xjKAdwM2x665DlPWcgLZlM0iUIO7OrBcwpqbc2B5coEAS68iKbBUGle/qzdg+80RGB7mb1qmkBdtYc5/bdDMyMYykvPxu68XTcwdutUNpQbgsaGFKWhPEWInXxWt+ofaJY3ZPA91uxKOW1OmZiMW6zTwI0Pf7zHHivsZuHGRgUjgaGoOU/rvB+Zq4WFLJQLrPac10QcU3VcOW1d6h55ni2dshJjFZw17W1WDlieyxVaDDz4zb5Esn2k8jqlcQ7pcoVHqprznKSFB1z8M3jE8g//Jo+fN6uOD0mBqAAsqm3N6iG0cxwXJTLmtu9GqJHCIbtVVMkNyeOhIcbALOvqjd/SqAyIDCvYY4g51JDbizgI/Ky8X/lgQ12hFC7MK55Fzb1MktPrY4MezEqc1fmEN8pApY6r7sqlar6vH6KwVgEqfEEzPAj1XclVRSzzUz8DI2aD7nHo6guZP1ImgCBUuNogelblxQgSnG9AuV3AMPebPPOa2g59YUjDCk5QUeX1wAwajc2U3rF4X9QnzCnbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(7696005)(6666004)(47076005)(26005)(1076003)(2906002)(186003)(336012)(478600001)(81166007)(356005)(110136005)(16526019)(54906003)(36860700001)(82740400003)(66574015)(426003)(83380400001)(2616005)(40460700003)(70206006)(4326008)(6636002)(41300700001)(70586007)(8676002)(8936002)(40480700001)(5660300002)(316002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 15:45:18.6262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136fb576-b11e-487c-f418-08db8def504d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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
Cc: Praful Swarnakar <Praful.Swarnakar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following to align to linux coding style:

WARNING: Missing a blank line after declarations
WARNING: sizeof *rd should be sizeof(*rd)

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Praful Swarnakar <Praful.Swarnakar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 00ab0b3c8277..a4faea4fa0b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -375,7 +375,7 @@ static int amdgpu_debugfs_gprwave_open(struct inode *inode, struct file *file)
 {
 	struct amdgpu_debugfs_gprwave_data *rd;
 
-	rd = kzalloc(sizeof *rd, GFP_KERNEL);
+	rd = kzalloc(sizeof(*rd), GFP_KERNEL);
 	if (!rd)
 		return -ENOMEM;
 	rd->adev = file_inode(file)->i_private;
@@ -388,6 +388,7 @@ static int amdgpu_debugfs_gprwave_open(struct inode *inode, struct file *file)
 static int amdgpu_debugfs_gprwave_release(struct inode *inode, struct file *file)
 {
 	struct amdgpu_debugfs_gprwave_data *rd = file->private_data;
+
 	mutex_destroy(&rd->lock);
 	kfree(file->private_data);
 	return 0;
-- 
2.25.1

