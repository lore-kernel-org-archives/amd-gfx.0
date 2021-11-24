Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6A2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 09:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3196E9DB;
	Wed, 24 Nov 2021 09:54:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD0C6E9DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 09:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOjZJa+CxMzRL5xzIy8zZ5ZO4i+Ye4woAyvgHW685ReAZtg94ud4659ij/gPe9l5Xh90OhXFQ4GhP0sj9p/O6RP3u7rGyI4ovMD8ir3iLgCfWZUzif5aRVE7LQES9q3WkE9LjbvN2HQNZP5gVi1QYI70r6MIpqZF5bGfDmu0m5v6KGKn5vVFmIKCthw4Qibp/Y6+sVX0luupNQp4lHWX+eHO9KJ6Cp9Us2WVXPuu9gSXe/DuJwrGL53515eK13+DaGYQYom8EL2n692S5yjgVQIycnh0Vi3wpINXwCBdjOJkfPX/Ajfx1ul3/tcYzELDcznRe22YFCcIRbn27eqLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdS4CuTVnz2tDNM4RHDnA/QfZevOkH9QpGN0S+4VOdE=;
 b=kLVi++o9P4sTEJsCLCyeNTeELyjvS7901PwE9Z1f9+ky2/ie0w8fvqIsjxzWE1+i/rxVZWQffcu15wCkBn1cTi+Xt9vxTs3IuoUFZvuGHtobOI1rik5X3+xixkxIEFdvqDzmMBod18g6N6Iij5xv+DXGrtNuSypUbwPwhvlO2KD7NaVRymdxd/qfhn6aHimFRJhCrS96aJz2cyLks79swwipcAhghWvJr7Nz//fuUr+WQuQmbUSyAgKpXggF30bri4/tgrJKhCf89pbhnf0FI2t8CkJ/7CUht1+UmQ2xqBCQCQJESHodU1XBov55LfmkxGyZjJuWXiPtONjC/jCYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdS4CuTVnz2tDNM4RHDnA/QfZevOkH9QpGN0S+4VOdE=;
 b=B+Kp9nYCgHNgLdExb91+dR7kKf0czolJkyYmTtdVNA7A5rI4ngBVKE1Yyc1lE2kq0VMDztbJTHjxi+VWkjktipGmxliQkpAco0do51EeHmsMT4UX0fGYGk2A9BbxXKtV8vc+xl9fRDMd6uP+UteYmva1g6jYWelVTr0WiOnzgXQ=
Received: from MW4PR04CA0293.namprd04.prod.outlook.com (2603:10b6:303:89::28)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 09:54:22 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::63) by MW4PR04CA0293.outlook.office365.com
 (2603:10b6:303:89::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25 via Frontend
 Transport; Wed, 24 Nov 2021 09:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 09:54:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 03:54:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 01:54:20 -0800
Received: from jane-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 24 Nov 2021 03:54:18 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <Alexander.Deucher@amd.com>, <guchun.chen@amd.com>, <jingwen.chen2@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip init
 for SIENNA_CICHLID
Date: Wed, 24 Nov 2021 17:54:15 +0800
Message-ID: <20211124095415.11379-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f745548f-f69f-4aa9-d214-08d9af3063a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210B84C209AC5B4D0C26FDCFF619@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOYbDC617d29xDp2LMQaTOKxnvGtopFvJG6VyuiFs5OXAt1hgWP4QN1Yc1j+6laJBvIaKMgjpRhbGxGveVv8X/4Kz4P0rSx/WU6gKk+WtWXXmQ/Pri93n6NB/ZzdHb8WsfSfjlwGfL1XR6Yhib82u6Dewpb0bWZPVZb30P0wIoV7BMv7y6DOljxsxA0wL4NeYJ9S+zD53+yzjRqkX02zPAW6SRt6x1ZKaj8zfGfpLr+0mBYtxytV2leGLx/VRoRFPzJwiAujlFE+/rGoNvYcG9tmpJTRBNjBVcM2SdlOlx2YfYLQWarKZctrH8haYBP2wocjEergoCgf0p7bb0sqGieIk8SeNSH+EaSqZVvfxHGGod94SYq3APcEnbJsGTzmUWOmOdFfDGM9jr1K8OrBuYMO+2UMljGkDnav4rsMDeLgGk785wq+rwBG4TeC7NFszje5Xbk3eEA+jUdTNKBkoO4OKQU1awf0CXqw2flLXJFKCJHdBarrCLxXJop0pR37FfU+m2hJNp56U1PZPdMDlnHYdFi0LlDfLw8G1f3gEDtIxZrltl0d9LtD/88NA8HiUHcNpT80hZtmhdu0n6b6hclnXmMjD5XulvqXA1Ke5UXaFMzDEJEbsg9viTZ6B2D1Zuqj7ezntzsuGpHe9r/o34eMqncBfJ9tGUIkjDv29h+eo2wrQimbc+hoNiLqCaUsDfQiX1kWDib7mEa4uUhaqc1wf14U7/2Zg/eyuAKrYAw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(186003)(7696005)(70586007)(8936002)(81166007)(83380400001)(508600001)(356005)(86362001)(4326008)(1076003)(110136005)(336012)(26005)(2616005)(54906003)(426003)(47076005)(82310400004)(6636002)(5660300002)(316002)(2906002)(6666004)(36756003)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 09:54:21.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f745548f-f69f-4aa9-d214-08d9af3063a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
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
Cc: Jane.Jian@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
add new version check for vcn0 disabled revision

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 503995c7ff6c..1dabbcbc3970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -925,6 +925,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 33):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			break;
+		case IP_VERSION(3, 0, 192):
+			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+			break;
 		default:
 			dev_err(adev->dev,
 				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4f7c70845785..27125e5e3092 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -143,6 +143,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case IP_VERSION(3, 0, 192):
+		if (amdgpu_sriov_vf(adev))
+			fw_name = FIRMWARE_SIENNA_CICHLID;
+		break;
 	case IP_VERSION(3, 0, 2):
 		fw_name = FIRMWARE_VANGOGH;
 		break;
-- 
2.17.1

