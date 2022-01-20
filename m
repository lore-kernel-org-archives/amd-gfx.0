Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ECFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 17:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DF5710E8C2;
	Thu, 20 Jan 2022 17:49:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0747110E880
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 17:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFr5O7gSOiJSxG++ow+JIRR931IfAdbMts3KUAM4aEvObI8Mx+slpAmUgW2s6qR9qneln2lDMr7g8y+G/NBR+g1lhklHfMXJoLCQdRyNwBZFb+WVpJtc5nrtvSkVmBvyp4Efm58K0iNv/6uIpHWBOGtLB9yMjVad3aoNObJ9mi3nMSdM3AdqDDkpqMnafTGu93CwPUJ8MUoqbDHoX83ujGT56hmq/CxJ+iDN7Hrf1ngwVoAN6jaW5SZLh1QWgFogh7CfUFYK0c57gay8TkbpYIAZF11A/5MMGq8nVsv3lYgWs2wzd2sYpXARd4Iyy/0O/7je3JvttmpWdY777QI2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANOb1LQPo3TNhcLQnIgGyamYWL0LG5C5oGEkIo6f6oI=;
 b=jFwjIsSCmEb0c9reHyfAxKise8DICYUtPDNB2Oz7jFMikHCgn9eX0X702Q9zEF+tVAKUbXNtQPcFopvtA97uESyk3KVbbIXFI95+kbBe1S9Jg4f+7qbGp4jNTZvCU1QV4+vAEjjQLRWEKa9QTy01lVVW+bvHQgMBdrVhRJE4kRJWzqat1Wam3k9uTBZw8SWXpR9gdkaskMxprpw0QHcSo5TATnVpbotfUKu5ZFcz3nvi7KsHGMCPm4ejm1i1Ttg7SjamumHSC6SsFRkav6KahZz8UaJNOVxwks5Y4JCm31ysZq0rsPyznWlTXl52ZgMU63Oxw+146mkCJP2lr4HfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANOb1LQPo3TNhcLQnIgGyamYWL0LG5C5oGEkIo6f6oI=;
 b=VnW7cZpcwIDnEABuoXdRWQL+8kqxGT9pFo3jjKVIEvgFKRg7X2n/YBLYjiFNr/8J5TQav73clBUsFHfWPTV0pdIzTQpwQY4JxL/vNtOMOOVXhjEVK3fsPM3LUb0sUFqIK1uijqG5vVKldLhAI5L9/tMYMZfbq/6QGS755eb9scw=
Received: from DM5PR1101CA0007.namprd11.prod.outlook.com (2603:10b6:4:4c::17)
 by BN6PR12MB1713.namprd12.prod.outlook.com (2603:10b6:404:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 17:49:13 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::1a) by DM5PR1101CA0007.outlook.office365.com
 (2603:10b6:4:4c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Thu, 20 Jan 2022 17:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Thu, 20 Jan 2022 17:49:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 11:49:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: filter out radeon secondary ids as well
Date: Thu, 20 Jan 2022 12:48:58 -0500
Message-ID: <20220120174858.597208-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a130e2e-4b9a-4f05-80b3-08d9dc3d2bbe
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17132BB605F2EDBC0EBB477AF75A9@BN6PR12MB1713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMr1YYxzA+r+Q0PYHNfk1rQBiQyLuBBRsr13gCYXJt/73sl/DqnzPX9pVfKSGvGy0pNInbhL/y7Y4j6jxG+t0+HwXAQJi2FWe14MTIXcyWH8w7f9er6q6v1np2TL7vSxJ3d8rpWzDsJ8LSY2JQj8yyBQTVywUZOtgc4D/ppGicYF2G+eVIHQuoPKm6SRdxKUgIQLSn5zhny5HnAYSHekT48/ZEH9qss+uYXvVU/b8CAqiQl3+atwO3phg/z5Fp1+mHgrl0yLEhLgrH6jZtB1hvrhfC7x07MTNiHHvDG6LNFoF6gYs91RPsQU53YQhMsoNRTWA29d4b0XxIAcjo347TCL4In2EYUbKf68al3FQ+Te41flsLD9MDp66Wl53ORxM6y8USFapkLo0Kd/cKS1Zyn1hVKIiKs3JvSFrOgsIEFrd2cqvyLFV7+7AAikywi62oia5oJeIwUto1irB3ujmuLiYwG8b+cyc4PcDGfzh+51hp9QTIuG5QJtk57YiuewjvM1meiZfI4jIoJ8vLglXSwDyRGkDhNUHc2Axyit2ivqAzaWW3XH5GhWUDcwck7GWInYNyNNVIMkH4jd5GIYlzUjZtFbLHxt3pSo/KRpplVQmze89ElfYQRJ1wyHL7BhhvguEjb/2KCKYcF8zYx/ihLONjALmlnPYOn/bgxfa3HOIfM7jfrChv+ddcF2a9f/3eADnFkTV/Wct3cUI5Cms3O9uD8fTUlHy0sQ7pnJhkHSBvGIot3X9kvlhWoxtuVt1Lj49O9DydxAoJETPP+/037JYt0Sosziy1N20xotTYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(4326008)(81166007)(426003)(16526019)(6916009)(70586007)(508600001)(356005)(336012)(8676002)(186003)(26005)(8936002)(82310400004)(7696005)(40460700001)(6666004)(1076003)(70206006)(316002)(5660300002)(2616005)(47076005)(36756003)(86362001)(2906002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 17:49:13.3875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a130e2e-4b9a-4f05-80b3-08d9dc3d2bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Older radeon boards (r2xx-r5xx) had secondary PCI functions
which we solely there for supporting multi-head on OSs with
special requirements.  Add them to the unsupported list
as well so we don't attempt to bind to them.  The driver
would fail to bind to them anyway, but this does so
in a cleaner way that should not confuse the user.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 81 +++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1527decd7e30..75ceb43392b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1499,6 +1499,87 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 	0x99A0,
 	0x99A2,
 	0x99A4,
+	/* radeon secondary ids */
+	0x3171,
+	0x3e70,
+	0x4164,
+	0x4165,
+	0x4166,
+	0x4168,
+	0x4170,
+	0x4171,
+	0x4172,
+	0x4173,
+	0x496e,
+	0x4a69,
+	0x4a6a,
+	0x4a6b,
+	0x4a70,
+	0x4a74,
+	0x4b69,
+	0x4b6b,
+	0x4b6c,
+	0x4c6e,
+	0x4e64,
+	0x4e65,
+	0x4e66,
+	0x4e67,
+	0x4e68,
+	0x4e69,
+	0x4e6a,
+	0x4e71,
+	0x4f73,
+	0x5569,
+	0x556b,
+	0x556d,
+	0x556f,
+	0x5571,
+	0x5854,
+	0x5874,
+	0x5940,
+	0x5941,
+	0x5b72,
+	0x5b73,
+	0x5b74,
+	0x5b75,
+	0x5d44,
+	0x5d45,
+	0x5d6d,
+	0x5d6f,
+	0x5d72,
+	0x5d77,
+	0x5e6b,
+	0x5e6d,
+	0x7120,
+	0x7124,
+	0x7129,
+	0x712e,
+	0x712f,
+	0x7162,
+	0x7163,
+	0x7166,
+	0x7167,
+	0x7172,
+	0x7173,
+	0x71a0,
+	0x71a1,
+	0x71a3,
+	0x71a7,
+	0x71bb,
+	0x71e0,
+	0x71e1,
+	0x71e2,
+	0x71e6,
+	0x71e7,
+	0x71f2,
+	0x7269,
+	0x726b,
+	0x726e,
+	0x72a0,
+	0x72a8,
+	0x72b1,
+	0x72b3,
+	0x793f,
 };
 
 static const struct pci_device_id pciidlist[] = {
-- 
2.34.1

