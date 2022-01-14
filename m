Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8988C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 05:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762A710E16C;
	Fri, 14 Jan 2022 05:59:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF33010E160
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 05:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtY4i3uK2xNKNMz6XdfieY4w861XHYhF4VZvCRXOj9TQqNz7/yMt7p19e20yrfdSz8AK1TQy8ymqKqfjo3B/gb5bi1hUTG6xZQeZFQww76eDnB5fd+bCYhUO4bvXxtud+HWrJFU7jt9VYyjB+VfzAVxi5buGNfmxAUjgH876w4LpVv7nM3waVD4WOjLiZbdGf9VFPsurVe4o/gcax5NofsBUHfRwy6hSRMA3p/Iw+dzjggn0ys7jjUR4CZKJRqxuh7MMwGwqixLaFSqq+7RAj0T1u9/J6qm3VtrRpWrGGO7qIF/U84MZ1d9RSVsxGkL4AiMDEw/N7joTr+JFjKRYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyRiNQeU9vh4rMYAK1MSCIfDue/e4X/JDhBpXJ8j/do=;
 b=Ou8w8JbJqKdu40gItQUXVPqFoX6AZMbBQw09QKmz8BcQIf9sI1evEvIC/EN2sV7SJaxb+3vroaCHaY660tKTymScWCn42c7tVMaZLX5e5rGkgPad8Hsi3O3UiJVvo7H+3M0aUbd62YllAZ4uE5TL5oVpAW0EChe8lb4gipkrvIXh3hi6iVXuianz7K5mN0bCKtP4k5aa8EQTievOZFvV+rO94z+ccTJpgucOBZfX8FFIZ14B/qa9zwtOwXvxUF9joRYCNA6sI+bkBxItHwIhncjvAWimVI29eE0CDCs50Iew9UmXj10pPeGoJLZEyhY9s7KXYi5+ChIbQkp4gh8PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyRiNQeU9vh4rMYAK1MSCIfDue/e4X/JDhBpXJ8j/do=;
 b=DbT0sPMm+uSbzfdWW79/58oE+p1eJATaDnx2eH299jYTOxAK+14BXmKYTobZS3STG9haubHGpfUJGqXAGfwU0vpxYcN/YOgzb17WtLUGa8Ab4GaYt9GQqTcyxcW2ZBKJGWsXfiZOv45GL2amz2peXfhnnxXXyJeuB4NPuR+B5xM=
Received: from DM5PR15CA0032.namprd15.prod.outlook.com (2603:10b6:4:4b::18) by
 BN6PR12MB1314.namprd12.prod.outlook.com (2603:10b6:404:1e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 05:59:09 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::3a) by DM5PR15CA0032.outlook.office365.com
 (2603:10b6:4:4b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 05:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 05:59:08 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 13 Jan 2022 23:59:05 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <Hawking.Zhang@amd.com>,
 <pengju.zhou@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: drop redundant check of ip discovery_bin
Date: Fri, 14 Jan 2022 13:58:40 +0800
Message-ID: <20220114055840.12734-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4a1e176-32be-4e52-ffe6-08d9d722fb02
X-MS-TrafficTypeDiagnostic: BN6PR12MB1314:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1314A6AAE6459AE7BA7DD4BBF1549@BN6PR12MB1314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJ/VKRj6xcxUaOSzTNiO+dL/81q3SXgZMvQyUgHQMnftvOxTYUY69TdL/Z/hJ/8koKt95VHVw9Jaf5myJUR5njL6mhTNRjhpiTCkmIl/eVW6CboEXZTnsNuB6vM1THNmrYOB0B8/aswRf4me/U4gpR8yh25i3zGqK3dIXbsuhSlEkMizhmbEoYgEAGqR1LwShNTZ7JVuJwpqpiOqA9yCAbHJeBpL0OzVax0kNWNWGk6C7TTVWfo5HUCveeJ8EeMFvC6GvH4ypNhEBVQ9l8sWgcDjwP6h0VEa51DM/DVjWHOMUGq3wpXfcuwnBcc06K9DRKVNVlGMChoXCzt/uyNdRiOEqauI8CsnY3uCZErk0/2PmGwyP09vX0eYq0epYp6Sj8r45TFIozYNf8cHsb8n7nF/x8tiHJp60Y/enMebwdoDyKVUjCsPQZfquT7GSiAjhydiZGeXUevhEFJzsEubAaGkdt8d2xUuiObSp4RRFdELw5SZyUzt9UGcBO+23xcQo89wQjwoUJQuApAaBS+C1zKYxfMuFjiPfUSkG+HwCmLHDEwaapCq5OL3L7NaJnuaLB1+TEENZgKkcRuqccdjMzszcHGkxunZ7m3unzNWzncQ4v9Q9+aMPJSbQVQ6nSZfdGBlQ4b5to89AGwILITKtvcBQGdyUcN1/ETax4jKF4ClYzNk0MsYqjJrtbquBm4/u/jFgrsPwEZlB3ZHE4DnMWfF9icKZgUZQ84nPoGVqX+AuHAqohXHWRo+V0fzFJqFOzsrc0l7i3DahOiDFOv2ODg0ixbLYNr5gN8Fc7Ogem8wKSBoQNcnHQ6Rt+yhuccf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(4744005)(86362001)(508600001)(336012)(81166007)(2616005)(4326008)(426003)(1076003)(47076005)(40460700001)(82310400004)(8936002)(7696005)(6666004)(6636002)(356005)(8676002)(70586007)(36860700001)(83380400001)(5660300002)(186003)(16526019)(26005)(110136005)(316002)(2906002)(44832011)(70206006)(36756003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 05:59:08.8836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a1e176-32be-4e52-ffe6-08d9d722fb02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1314
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Early check in amdgpu_discovery_reg_base_init promises this.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 57e001d73ec9..2f891ae90bad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1194,11 +1194,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 			return -EINVAL;
 
 		amdgpu_discovery_harvest_ip(adev);
-
-		if (!adev->mman.discovery_bin) {
-			DRM_ERROR("ip discovery uninitialized\n");
-			return -EINVAL;
-		}
 		break;
 	}
 
-- 
2.17.1

