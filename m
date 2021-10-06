Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0316761130
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 09:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0316761130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB62F6ED20;
	Wed,  6 Oct 2021 09:51:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03F986ED20
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 09:51:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/ZQqI5EzhYS0UWRe8GlyhAYBPlpCV6oSE7616eyI7F7St3w9wD4IMaGLeRYlR8EbmiDKR8X+VTa/s76MMUKIZZe5m05JWApZsDQbzHi4uFoAMx0hP9ups2VQZXaK5d/sPBMIJ0HApdhlm4z9DKlxnCFtYVqkbVy5IYJOwXyQgYVD1K0zlBXFQ+qgqVKy7bkVMMZtBLXd15+6ELffoPkHxoTdnW3h88fgNxeQxn/RKIXF3A4/v3nvqjohCoX683LJDnsrvw1aja2RbcIWDbKoFvBExS44YjSXD99P/JnLhYOCR+PqJKi7fLd9ztSFGp7MajHn/BA1lMDxtkFtsWcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXXBroM0hhgtaq9kr45txzcsJQ0ppp8UKdKssU9KZkc=;
 b=j5NFbLCtL/D4nGPvIpi/GWJ/2J02v7A9TW6vwjy4Hg5tew5uhsrraI/LmXx53toaZvAt5/YmP4XcxRjCc6XdBU+3/F9w1PK5t84eNGdUNbfExNLe65NuslOO4cyogfLI4bP3x3lE/mWx3QYXW16Givts33L7Uk7BB7rBhE2u+3Aa3oaRdvSjyMaPgRSvDQnlJtoxvdtF3e8i6ildEUVq7FOYzXDH743LXOC1xlB72zIDE491cCSZxGwwwyF4w061fgkey1Yt3zIO87Etc0Lrs4HYSkjggNu7rUPpn2fTb7Nu83lJqqe7VOcpnzwGTJEFhe9j+GUGlYBm4/erbPXiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXXBroM0hhgtaq9kr45txzcsJQ0ppp8UKdKssU9KZkc=;
 b=P6PEUW4JGG0vkqF7VQ/vuGHNxtdVfNaAqlYPOKO9hOqhVIoi36UAbqAaOKKzY+Pld7U6rl0nkMiVhc3rE+3gteUX1LBQtqShtb/P2FXJWpEAyHqq850vHzO2uU56GlKjodrnS9yMuMKAwZXdpZW1Q52ESco4+7e8uujCuoYG9rE=
Received: from MW4PR04CA0346.namprd04.prod.outlook.com (2603:10b6:303:8a::21)
 by MWHPR1201MB0270.namprd12.prod.outlook.com (2603:10b6:301:4f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 09:51:28 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c3) by MW4PR04CA0346.outlook.office365.com
 (2603:10b6:303:8a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Wed, 6 Oct 2021 09:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 09:51:27 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 04:51:25 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>,
 <shashank.sharma@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: return early if debugfs is not initialized
Date: Wed, 6 Oct 2021 11:51:16 +0200
Message-ID: <20211006095116.6221-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e25c77d5-1d2e-4cb5-3182-08d988aedddd
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0270:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0270639AFB37345075C7F8AE8BB09@MWHPR1201MB0270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +78rUNsHv0URve4NtVutBchJL3jxJGZfSdr0hJ4r89HX4e7AGYE9C8omo8qQ08+MfnGg8UqJ8/Kjm+xil0NenDvkubYdT6vSnVSzFHROCBCzbwd8mSlPkvQ+FMB9qHirXyBAHbyJ0sLVh5yHcJ/IoGj3Y7ky1pmIymfQM0mURVB41kmfWCapCflrxLrqX6jBZfdKRWIRpvqE389EzIzwPYYr4QyOYCOJYTiROsZQMBFEwrpa5sVxQStHR5/DWJJJyZxxSRrtlPjYcZUob5DQygBQ6opKXhN0IxGzhAwShEfoeAxUhzHElVVZmTA3DH+T8r+Od5ppjuvOmskrw3zJ4zQCflGEq6VzZacsfjRTtEVx9XgqI8aQ0K59vmM7XvqGRb7/TfmHia5nA1c5yLfCYKYPQoLnnFuhyU4L7Rved45sZrLzNSZvHqEVFn8Ya7aH+MXe5xT0Fffz2HgxvpWS5zTf2wmq6kLilY7VhBKsVfnBMtnch0Jn2LGW4gsl6uJ3Ao3kcvVGE4mHhcjakD4XZ6in2rYqTS3n97H4pOWNoLT8/Y1tL0WYNg/FUNbXjp6W5nLCKJfGUiF/dQX9agh1OQUTKAKh5pPM7n0Ew7G3vg0u7qy0BjvHZDdk3Qcas4sOxItmGBbePxNy26GzJxn5cNvtHduMCGZd+oqYaHIr5xcRUkhSPcAzXnMPrd5kIXv51ic1mT8AImG0l0PU2UQKSjA2051IrsPpnHEJ/sk1Iec=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(508600001)(8676002)(1076003)(4744005)(36860700001)(5660300002)(70206006)(44832011)(2906002)(966005)(47076005)(6916009)(36756003)(54906003)(2616005)(6666004)(70586007)(26005)(81166007)(7696005)(336012)(316002)(426003)(186003)(16526019)(82310400003)(4326008)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 09:51:27.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25c77d5-1d2e-4cb5-3182-08d988aedddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
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

Check first if debugfs is initialized before creating
amdgpu debugfs files.

References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 6611b3c7c149..5497e2d31d1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1617,6 +1617,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	struct dentry *ent;
 	int r, i;
 
+	if (!debugfs_initialized())
+		return 0;
+
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
-- 
2.32.0

