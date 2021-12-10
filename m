Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E52C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 15:05:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A76E10EA07;
	Fri, 10 Dec 2021 15:05:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1CD10EA01
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 15:05:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASOYIiqtdlCiVeILtnBf1ynISmO9Zp+1LmK/5MY9RaL+mn36JGZb0jYEEIHJ2Qx21I/hJwnCbka54SHuv+hgLi+ap/5EmWNXq9fvH5VJpsQ1qgHNXZnIqLa9ibP2t0rkn3mWH447Ii7FeCbcaVIyHx+x3e6Q9SarDGYsSTlQP6zA31O6mIKn7y/1pdYeUvzDUKYgNjXIlbqU+fhS22CdZVdfwOL4lcMb3dNE0Pne5hHgUG8owYhM15mRL8ku7MttlGXzZDMKr+9GwFonljubYumqEppc5TA1aMQ6f+eyUlfDsAkZKJbfYpzCWDhzfhjcWt/4S7R/jRXSErQ/yBHlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nVjjXKUFAR1GMlQ0iKHuwUlg85e9HPax/f3VosZ3/Y=;
 b=YxPnh/kY0+yF8Aulujt3hwH/AUlxLoLjpeRTvbP1euV07n/oAU/GTMrc2DKDM90MKijP8s+12ZtdjpMvwXv2C8zqGLuyg9X6chOdTGrmvg0OUBCtdYIfMXLnTXxvhIvTKQ4JaywnuHdUtvnny9+cSrIbwc+wrlGl5pdc1sAKXCzLMkTAl1/IAsVY+WGyUWDZdhmEYYJNBmBkmMfUF5YdLTqpkE6iGJMxepg+d3nooALfYKMuK+ooAS6zcxgt/rz7upjASzliQOKvoh8tbYGaarC5cFoA8LFr93zNFYQVab07tedwdBZV7jSAjQzEhhqMJDpMC3qJbrNhA9dbnqMBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nVjjXKUFAR1GMlQ0iKHuwUlg85e9HPax/f3VosZ3/Y=;
 b=4WIQ2c+MZ9iVNjoPShOnTlPxMEVB2s+D4SGKwE2wwU01OlPq7lSJ3GoTXy9eEwRR2qD8vEaiTCUWewKIV+JbS/T3TpjzeTPlYX8kLh9bn4L98935GYHG7mTOaKsd6NuCFqJLu79M4InFMsXHrB5PEtfovgvg8LXWMhQ+FkgPPQY=
Received: from BN8PR16CA0030.namprd16.prod.outlook.com (2603:10b6:408:4c::43)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 15:05:44 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::cb) by BN8PR16CA0030.outlook.office365.com
 (2603:10b6:408:4c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Fri, 10 Dec 2021 15:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 15:05:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:05:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 09:05:43 -0600
Received: from haijun-target2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 09:05:37 -0600
From: Marina Nikolic <Marina.Nikolic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Date: Fri, 10 Dec 2021 23:05:33 +0800
Message-ID: <20211210150533.1509-1-Marina.Nikolic@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb8a2a5-7dac-4273-751e-08d9bbee8a16
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB513045B214D98360D79417AA8E719@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLAaCUUbHUVAkw2zkzn08Om92Uss3JzQ+6BCHjO7NF0THJtJx5IMbCND5XGx1RUy6UhKA1W3WOSpnQqeZI1HIHUJkQBSA5SFbWfAOoYxxFPag/QyWhflSAcdYtB2ItdLcNVS1sIacAq+pfeS177Yf8VrpYqzTU7bPmmwqKIeN3mWtMcvvCCOHp+xT1mBJxEz/AJartCrN85LarKFwdLWQCpWfEw7j8ifHQstYq4NkLxooWDFNK5V/8GYY+l4+mYEtvVNFBwkxWEdgk5EzRqizcrGNt9XU7cJd+wLgzrjn/yH8wolxHahj6TE8s1P/YHA+3gLKOMfIQbxKNwnVdeF9eP95rFEm/NPh1ubfQ0EXW39B4Li5z6u+oW/CBuJ/bnLdKsh3rYyRAX7So6MRc8dJkJwdIzssPchvfdmHREsOJNKd+FeETgPYwgw3Hx1S09d5GlviAAuLBONLDCbQ1JCr9W4mepRDZ5FSEpVRstOZ86e4eRBd2IVuCz7Xo1bsFJEZn5mXZKYB1NqamBA+kjDJt4LZJR9LHzFNmJS6SfcTBqFxdtz2ZD8vIz9xFYnwL9+iLwg+LhChSRpsa0kZar230McoQknU8uOIs257gybBYtb9CwUca/H/1ze5/CLolBpFd/bmMsoleNRdBd+tdAm/VHE01HxgAa4VFKHa+yPpFdNIiNIlBg4MonyeWVPjT/kfiqF55tsMNSyFtz12VBZy/PGhnnQ0xQFRBKMx6fAYZQ2uiD1oXKZvkqNgcw7mfYObvMRNJfVbGLkFC98mduiprUZhBMJCii5g51qYGVg5Ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(40460700001)(356005)(83380400001)(26005)(186003)(36756003)(6916009)(7696005)(426003)(2616005)(4326008)(6666004)(81166007)(82310400004)(336012)(508600001)(86362001)(8936002)(1076003)(70586007)(8676002)(47076005)(36860700001)(2906002)(70206006)(54906003)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:05:44.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb8a2a5-7dac-4273-751e-08d9bbee8a16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: Marina Nikolic <marina.nikolic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

== Description ==
Due to security reasons setting through sysfs
should only be allowed in passthrough mode.
Options that are not mapped as SMU messages
do not have any mechanizm to distinguish between
passthorugh, onevf and mutivf usecase.
A unified approach is needed.

== Changes ==
This patch introduces a new mechanizm to distinguish
ONEVF and PASSTHROUGH use case on sysfs level
and prohibit setting (writting to sysfs).
It also applies the new mechanizm on pp_dpm_sclk sysfs file.

== Test ==
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.

Signed-off-by: Marina Nikolic <marina.nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 4 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 082539c70fd4..0ccc23ee76a8 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,				ATTR_FLAG_BASIC, ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
@@ -3504,7 +3504,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		break;
 	case SRIOV_VF_MODE_BARE_METAL:
 	default:
-		mask = ATTR_FLAG_MASK_ALL;
+		mask = ATTR_FLAG_BASIC;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index a920515e2274..1a30d9c48d13 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {
 			     amdgpu_get_##_name, NULL,			\
 			     _flags, ##__VA_ARGS__)
 
+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...) 	\
+        AMDGPU_DEVICE_ATTR_RW(_name, _flags_full, ##__VA_ARGS__),		\
+        AMDGPU_DEVICE_ATTR_RO(_name, _flags_restricted, ##__VA_ARGS__)
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
-- 
2.20.1

