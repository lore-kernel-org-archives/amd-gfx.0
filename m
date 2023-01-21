Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE628C05027
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Jan 2023 02:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A1510E089;
	Sat, 21 Jan 2023 02:14:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511C510E089
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Jan 2023 02:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyHgfLfCYzGnFm8xDOHpAkAn5gGUJbcxsqn0D2Qxk56yEYYS32o7jmZlNlBQ9iCStqrWq2b5QYG4MWw61qakSfyyflvuVwWKSH8NZD4a7FnJkzozFqPxq7f8Ot8sWmBLBeGR+5D1sSMdigTz1li+zbs7/Xfj6JKWknqeqLbcYAJ48Qhyk6+zkx0JglJ6/ZdBYkow8ZqiM6okUtJ7nG/fRqDni2hPWeJtZpqJEYYJ20DdV3z0CUMI5nhbjkNxDD03LS3rooRaFn6D5ozULA3uHrvxW9A8fqGcc6/D0z84H90WIUr0eRZhdzJAASAFS5zAfSMbSO54FVqQZxMYgHYBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSF5ddnLvQFPTltA6QCjb63i4tV1qFjdi6LipUWvKk4=;
 b=ZgEK6cWa7Djo0TiK6gMbJ5eCdJ1l08LTuRiyR8D6hWldEXsx/HKurCKyD2g+wi1uZSY5ax0hKftTl6DNK9PQZ/aCTIkWHnGJax7osyCgkHD89QMleijAGS6GnmXZDlRrckJQ2nrY2lVku0vK4WnQKkh392oCrs4gWsnXVwU6UtSy0MulM75249868iJ/6t7DafWSq2tSOaTnNWzSrn+pOriWwRUM87B5KU2Fhm/SMnYL7LNYPOGumLei5oW0PZKWfW1tHVJqyJDg8ZJzEtIfbX9ObBVrfPWjKO3MKyOyXxk/WtzxvydsHQm847KAxt11VcHIwbQaSTE/MLKQsX1pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSF5ddnLvQFPTltA6QCjb63i4tV1qFjdi6LipUWvKk4=;
 b=Zc0IbUBFJ7ZCy7qKVxGg5CK10J+C6pp5TP+qKSmGUe/xN+Q2p9YX8pCVQeGZYTuQu9W8KJV8iD4HCy5/RLnxujBIdj7CB8TwowI4NmK1JfGGlordxquwLWdd4q2iEmxl1ppp+3KHjh10/TmHVCCxSLgyCdqnYCYV/YhrC1rBlFk=
Received: from MW4PR03CA0187.namprd03.prod.outlook.com (2603:10b6:303:b8::12)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 02:14:36 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::70) by MW4PR03CA0187.outlook.office365.com
 (2603:10b6:303:b8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Sat, 21 Jan 2023 02:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Sat, 21 Jan 2023 02:14:36 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 20:14:33 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH RESEND] drm/amdgpu: skip psp suspend for IMU enabled ASICs
 mode2 reset
Date: Sat, 21 Jan 2023 10:12:16 +0800
Message-ID: <20230121021216.1596133-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 90db0f92-8cf2-416e-6c08-08dafb553e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7gfDGVlwERShWTEaFtkiMQhcWb8NSN0lG4n03KAdNIW2Q38JU7EUsImDn4nPTMZwh3jQl8zDznQCaJuhTG6uefJ9nDJUQmGqhp4l0lfjh+rghN9LGj/u8UMDYJql4J5UzDnXU6ujrG9ryKiwqJ8641jxYBN9ekV1J/CmzXp9cBIn3t69mJiS/rg3KiqtY3fkzKpIxq6gaj5uUbdCEKSmiJtTZj5c+iqGRGU7AXaASIww26dhPM9pSXl2LFSTIX/+WjQK4ePOPGB9/oDOYC+KoGUx9D1TZtF09Ut3X+nf30lF4N+kOEGDg0RrwAyvVHNK6+Uu9FCs2SannL2gExuifPTDsqIqNL7+431x2ZevfOz7ISXTGsm2YNqjsm417+S8y6Ip55S0Jx0C9K/j+LNT6xYr3iE/1jjZkq049ejBto4bi0ic2nS3G+QTR7vWCzO+LspCxyk2f+Ue0HwhoPfCZgAGrO1nl7tWUNA0VXPCv2cPzWzAZFkeYCklg6IdR6GLILIEgY2UBeAzLImzbIub89slPf8FQEKdvsjntiGA/WF0QLRxgkyo64JWAkOnW5zY3Gzv3WtnuEVFJPGGJOCzAxjFeBMYFUWAqR+NiLTdM3OhPyWdqqyhL7jLlkk3UzHmPYEiusmde26NJNW0n0fM8RIfxDg7sYk70Z/WF3rEfOW8cwSFcvEZs7+FOnN9CfuvEqFSqmheDsZSsSKXWi7SGlmgUe2yuvcBFDxOsdA0goneAGHxm8G4cecDAKWsy5tZKTScOXyCE87mSvf7mdCaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(15650500001)(5660300002)(8936002)(4326008)(44832011)(8676002)(82310400005)(70206006)(6916009)(70586007)(83380400001)(6666004)(478600001)(54906003)(2906002)(186003)(26005)(16526019)(36756003)(7696005)(316002)(2616005)(41300700001)(40480700001)(82740400003)(81166007)(36860700001)(40460700003)(86362001)(1076003)(47076005)(336012)(356005)(426003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 02:14:36.3892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90db0f92-8cf2-416e-6c08-08dafb553e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>,
 stable@vger.kernel.org, mario.limonciello@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The psp suspend & resume should be skipped to avoid destroy
the TMR and reload FWs again for IMU enabled APU ASICs.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index efd4f8226120..0f9a5b12c3a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3036,6 +3036,18 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
 			continue;
 
+		/* Once swPSP provides the IMU, RLC FW binaries to TOS during cold-boot.
+		 * These are in TMR, hence are expected to be reused by PSP-TOS to reload
+		 * from this location and RLC Autoload automatically also gets loaded
+		 * from here based on PMFW -> PSP message during re-init sequence.
+		 * Therefore, the psp suspend & resume should be skipped to avoid destroy
+		 * the TMR and reload FWs again for IMU enabled APU ASICs.
+		 */
+		if (amdgpu_in_reset(adev) &&
+		    (adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs &&
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
+			continue;
+
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
-- 
2.25.1

