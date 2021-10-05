Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A241C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0140961372
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0140961372
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920186EB7B;
	Tue,  5 Oct 2021 13:11:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82E66EB7B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 13:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6350P/thL8ueeHkHPFKH1eHeZ7Ieo8MM3drRMMIOMcn8r6yiYw6Akj7vLHx04TSEb29hfW8M1s2wjhV9JtUsHRswdGedf4BRM0Nb4a/Q7BVKuRGRf5Nj8+oxzHl1FuE0Jyc0x6rpiBr7LuPiRWkGtQpXrkip0AaQ0umWW/PhoKJ7wubRUDYDcxo3nZBhRhA1OMH4VuBlFDvvH2WNZhomw0JHWsA6QJByt2rl6u5TlMNdzQ1VMcDx7keV2ovzmG7FBw9Uyv8R2qAtt+EFMBwWs2SvtCm717XVls1Zur7x/MtboO7+GHIpUQjz4iGC8Ec9d7VJS1n4PLjSDmhvqMbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiiPR/4zU/fG2eCsS9zTWRlrbqLFTcsPxj84O5N4nCo=;
 b=IUuu1Z6rVUgDtYSmLYu3t0Yk6IruIB6X1cjYG/G0PrsBFCR10wVCwYhQMcX5mxiHlveBx3sM26zk29isb9hhYhKYef9SbWHDN/a7qSJ19i2QyMNUxnQm+DMAmUaX6JliFV3eHnEWdLmSh8V+qYZnNaUYyavDWV53Qtpg7guLea0lTDWenYxL0FfdSLSZ4kJ7tchg1mM5wMxx5Xb2BKpKO37aR6BYrl0XD+qC6AALWpnu1yMPPbtxD0Zgq7C+i+7Dzj66U/cyc3jRe/X8L5WpC3ej3XxSH3rZRwXWE37N6tfUvNcLa8Ad+1i0yhH9FgY/TsjWLMVFymoujycrP+eOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiiPR/4zU/fG2eCsS9zTWRlrbqLFTcsPxj84O5N4nCo=;
 b=V7XOWu7NOZDW5gxOAKTJbpH3sil5GEHAaNkb7P1cNiNAUmF0aTTaoYANV9VmEwEfieYMRYPNc8cW9JecgWprQo6OVTpN4UdJ7rcQh2s1huS41QOmXbnN4etnkjm08P1MVBD4nCnokXl+VZOM0qTYM7wNPxOulRAAcBih/dTaWjk=
Received: from BN9PR03CA0603.namprd03.prod.outlook.com (2603:10b6:408:106::8)
 by MWHPR12MB1501.namprd12.prod.outlook.com (2603:10b6:301:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 13:11:29 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::6f) by BN9PR03CA0603.outlook.office365.com
 (2603:10b6:408:106::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Tue, 5 Oct 2021 13:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 13:11:29 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 08:11:27 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <shashank.sharma@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: ignore -EPERM error from debugfs
Date: Tue, 5 Oct 2021 15:11:15 +0200
Message-ID: <20211005131115.25595-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f7fed86-b8de-4845-e299-08d98801a4f6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1501:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1501C87DF23961D7EA431C228BAF9@MWHPR12MB1501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zrno1vBZiROkjwDoYy9AxC0NsqTuTlMNrsR+EScsnv21hfAWb3uxk6zmYxjoE7ZsoMqs/JgVA/yv5F4HhClrpKoHrw2ea++p5Q3u7WB1VhYUisGymlKzfz1MTtVZezGzxJgycfHU0gkLBC3V2kN+rqhqsr7xvwtx+AUojKMJoBbQD0RWmLhsCQRzEHsCeUmWjwUAWu4TyyXASRL0fFOGuEUPDQlNs8OsriygDSZM18E4WsUvzHCB13QWz2m/PXqcVgK9XG6q726D/EVkoT3hI1j+eBoQguSxr/tAAozs1OAObiZmjUBZ7mA6xAAEmfkuRhYY/RmLD/X62P6mCFD9KV+2Cxc9WxlADqAO7LZAW9VSipBIrVaykAI52QVlf+1I35XxdgitKMod+2Is+8//FTwS8LU7Xxn39DaGd2jKMzFWSuXiVn2vqp1+5kpQ2Rah/D/R744+IeI/GxrqTYiPsIJ757PUmAp8cfky4yshJdx7hPPOO9ZEeaLEUxN9laKfPojUB4u+N3k1Lj78XXUpUEbybp/jQLsLlPFKAqdR6bpNY32/AC9AbM07F9vd4W2u9BIcdC0sVr2pcjC4mYBdockNeyBzQQAcxE/PB2SNp7X28GfhD/lEmMq9yulGVZ9sIgD8X3AeFGgmR0nPjB1SVI9v6rghbsXSpN2ZTZKx+Ycls7jE4MJ4MM+wRpOf3pE5S/X+CKHY/0Kntim65Dy6FEsNPxbdcEEWKF38Ohl3OQM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(2906002)(44832011)(82310400003)(26005)(36860700001)(186003)(16526019)(1076003)(6916009)(70586007)(8936002)(47076005)(8676002)(4326008)(7696005)(86362001)(508600001)(426003)(36756003)(5660300002)(81166007)(2616005)(316002)(356005)(54906003)(83380400001)(6666004)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:11:29.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7fed86-b8de-4845-e299-08d98801a4f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1501
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

Debugfs core APIs will throw -EPERM when user disables debugfs
using CONFIG_DEBUG_FS_ALLOW_NONE or with kernel param. We shouldn't
see that as an error. Also validate drm root dentry before creating
amdgpu debugfs files.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6611b3c7c149..d786072e918b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1617,6 +1617,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;
 
+	if (IS_ERR(root)) {
+		/* When debugfs is disabled we get -EPERM which is not an
+		 * error as this is user controllable.
+		 */
+		if (PTR_ERR(root) == -EPERM)
+			return 0;
+
+		return PTR_ERR(ent);
+	}
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
-- 
2.32.0

