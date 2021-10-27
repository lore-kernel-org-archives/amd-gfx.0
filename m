Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44131C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECB060F38
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0ECB060F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2796E8A6;
	Wed, 27 Oct 2021 14:26:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76E26E8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPkEF/nrJDN6bPfgAu+zx319MIDK5uPpHU2fnKwWuG1HUNEEusZ3U36z+z4XJMMbZVnx5la45LraVT+WlC+THiSGxrsVc7IisSf9xJTRPpIUVapr+JWoJqK3GlMNPlurs2z9f1vgVbSFr6D2v7EQoWYoWG71wBd3dV3A678jBDhlRu2J3K2EfzoU1C6dqthUmZ3M4O2YYDI0K+dY3ncw7Uleem77uWLPAkgPaPJvbqIAvn+44fTjTuz/oXNFa8R6CD2WMWFyzgJjfOHqEi2bAFUcqtO9IB06/wqh0ZTcI6rq/Tmi0il7BrWeQIaMeAQItsoCgxl+aWHfNE54SXMpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mztyTPAVNkMJUweE72YGVOhB17aA+1Ha8MG1ejboks4=;
 b=IkgzltMOxeKve9kpwizeFNQ/4DTtP+Tw21Y5NUR2mrOBZbZPTn+YO26GE6N9LNZ+DMaQHyFDfsLpMl6cmk2ClXX+V2LRpCN5hF7Kxr7L+1LQ/8v4MA7s/uqOoHR9AX+eGBC6cgwwk/teBZFPKrpHuibnL0eiow54RQ8s1t0aY9vMx/ZNjbth4o0SHVmzE3bMPwDb/uSe60fXU39nASipaLkOAXSFDP5JDx+vvipXQKsHf1UqAZPpTDd0V6tpLoDfs7ygQaA7PxG7+wHR6XHIeLWPnfOBIyV7+D7DHA+nyLE23OvZVKoJhtBgE6jWaacSZ1ff4+GWeeMoha2AugpbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mztyTPAVNkMJUweE72YGVOhB17aA+1Ha8MG1ejboks4=;
 b=rOZpyVRv1OYCCFSrGN+fJRsgyJy6Aak1PiHMun70IDTcZ5ZS9il4Z1V31Wu4ytH/kUaOYSbkmeAxKaxn+L5NDcVkrEpTgkxgaTtVagOBBCsg0hm3/O57kvJHjiPjeY2AwYYoQIUFQvJWIBwjl4ppT6kVBMEFiWHkPPPO0y5ugqQ=
Received: from BN6PR20CA0071.namprd20.prod.outlook.com (2603:10b6:404:151::33)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 14:26:42 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::50) by BN6PR20CA0071.outlook.office365.com
 (2603:10b6:404:151::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Wed, 27 Oct 2021 14:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 14:26:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 27 Oct
 2021 09:26:40 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Wed, 27 Oct 2021 09:26:39 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <rodrigo.siqueira@amd.com>, <patrik.r.jakobsson@gmail.com>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Don't allow partial copy_from_user
Date: Wed, 27 Oct 2021 10:26:33 -0400
Message-ID: <20211027142635.9459-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211027142635.9459-1-harry.wentland@amd.com>
References: <20211027142635.9459-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b036e906-8bdf-4da3-5aa3-08d99955cbd8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1945423D01128937A60658FD8C859@DM5PR12MB1945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVYCukk2CYaVCtcsY9JjkK0AMUk+15jKQn1rx1RAtApItfG1Q9m28xv9YnVtqQphpBClEqaXcvf8EwilTTd6R+5CDHdDC9nuw9hzzaynMt2QwrapbTHIhqJOAPf+MFcBSlmXm+HQcMl32os/d9rLUQBd9fsZG9pHXzgEy6o7FVhFeZw9jIbPf+Wk6Kujzu52s4GXdPTz6MY2R84ugN9gynu+nfEAY0CYVMTuQqDLcJk7vgsrm9CnQSQAt/QfVP/xLvVW/kkG3dFGVWqTatH32oBMfjEtX/vhsEJ47SY3HEXWPMwxwgYNkW0Ood6s4kSs3L7J7Pr7b4ngpC4HrZGcdOKI8WkCraTVfbuUdQ2Jvb1JTBLkBkdYX6er27yFYLpEqDjPPE7oZoJv6C1wufk3XXP1ZAvUoHw6+U8kZ3lp8IiJsCHFqiqGlNfQ+JHNXARRf/5KRi4xPeOJNLRxWHtVu/hF/YW+YGnPCPRWyPSNW/oQ9qWW+nVzmB1b8Iba5d4jv/3SxYjyLh3U88h6LqeXF3ZUpZIyWFw5pliWJizuc0SJKbwKjcU2Yt/mKxZtnMWduFssmIh/f8dg6u0T+5C/2G02W8OYOhzEwA+zs9Q49BP2wMArRMRhfVJv9jlEAHd4DLrV0Rot1j3JLgn1PoDXs8fHmsmOIB66MeiudSBqLBTsi/k7jZ2v/g9fKNvzU0beCc9UkKn+sXYaZ+FlSZLYttBqGBiSZ6v+bkwJUyZhgfKMZ1x2OFK0qi0W96v3HWJvWtZLpk5oawlOR1JG1r5Hu9K06yCzDg0JMi+i8/SOtJ50hQ52Y+noxYRiDQGivMHd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(81166007)(86362001)(36860700001)(2616005)(44832011)(4326008)(356005)(966005)(336012)(8936002)(508600001)(70206006)(186003)(7696005)(5660300002)(82310400003)(36756003)(8676002)(110136005)(426003)(70586007)(1076003)(47076005)(316002)(26005)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 14:26:41.7271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b036e906-8bdf-4da3-5aa3-08d99955cbd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
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

There is no reason to allow for partial buffers from
userspace in our debugfs. In this particular case
callers will zero out the wr_buf but if callers in
the future don't do that we might be looking at
corrupt data.

Linus puts it better than I can in
https://lkml.org/lkml/2021/10/26/993

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1a68a674913c..b30307ccff12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -78,12 +78,10 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
 
 	wr_buf_ptr = wr_buf;
 
-	r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);
-
-		/* r is bytes not be copied */
-	if (r >= wr_buf_size) {
-		DRM_DEBUG_DRIVER("user data not be read\n");
-		return -EINVAL;
+	/* r is bytes not be copied */
+	if (copy_from_user(wr_buf_ptr, buf, wr_buf_size)) {
+		DRM_DEBUG_DRIVER("user data could not be read successfully\n");
+		return -EFAULT;
 	}
 
 	/* check number of parameters. isspace could not differ space and \n */
-- 
2.33.0

