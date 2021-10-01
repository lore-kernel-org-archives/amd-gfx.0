Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9312EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 02:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4207F61A4F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 02:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4207F61A4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C9436E4BB;
	Fri,  1 Oct 2021 02:00:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095B56E4BB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 02:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/2MaHmGomZywcCzvgAZ/LZLKtcACB8WgBU8dFbaCjkZIR4lTID5+hzvE+M3gtNtuaUaGUHFetD6loEbYbxlbhbzbn9OBDrozQOetmxqJTB5IYHkrYA94iCdNtRDdQHqJbdyXqh6NHBGRBoOT4tpYno93S3dDdXQaQH/DrxRC3zHHHmQsmCY+Cl84xJJdW+VQJeqkcAgNknxVqciPhePeMTWFUQMWAxA1H4e/WSQBM/iY30tJHaEevm4FatmjkQyk0oQkfJZrfIm1pxGGy2UMnFZCOZWFWUUhAserT+ioVpCHhRDWQozJMoK0Gr0UMmfWubndXl1hWMwMvvUxdp4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Slgq5i+kn5AMIZcO22GO4bJogzDAzUShW0oJ5jAyRQk=;
 b=BKjgL24ZJx1FcDI8MW0BvLM0N7EdZYVozzPQ0oBNnJxmCcKRNIezNfK5NniK7YNj8y7cc+pdUvUP541wYQ4sSi6xqlwZFXNnAV3l0Fl/8j3/l2/0tle57+DnWV2vdx7GX9+CH8+KU4REcF3zJkU59TJkWM2lx/s/U+B8PD4aOPsNW47a788F/5CDeuR1rm87AjxEGj8auPTuhxDfKO9enrUFz2VlbG3CAkJPHRWfCjWZvcAPub5UTmRolg+tePJ4o/POk3K4kZOP3xCbJqUD0nwTDsydgQPhDNavfylKSd40/keLQdX3fSLhdbQ1p+FVbDU4reyikwGIs6PkPT+mxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Slgq5i+kn5AMIZcO22GO4bJogzDAzUShW0oJ5jAyRQk=;
 b=W+PN4g4c0FUZtAw7yakzf+/70kTtyAnea0jG7dHMcj9A3IcD0U/3zpkQQ0j/xd5K3UU+qAkk+s9RzgY0lQOqAHTlAdd8+7Y53v2HPwaQj39wW0aWmT+Cpm6LZWlPj7EYlWRbBCDEQEJRq4Bq42eBbGROWGwubF1gqNhsNNxQhWA=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by BN8PR12MB4626.namprd12.prod.outlook.com (2603:10b6:408:72::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 1 Oct
 2021 02:00:18 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::27) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Fri, 1 Oct 2021 02:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 02:00:17 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 21:00:15 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>,
 <andrey.grodzovsky@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: add missed write lock for pci detected state
 pci_channel_io_normal
Date: Fri, 1 Oct 2021 10:00:00 +0800
Message-ID: <20211001020000.14501-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420d1704-34b0-48f4-4ee9-08d9847f3775
X-MS-TrafficTypeDiagnostic: BN8PR12MB4626:
X-Microsoft-Antispam-PRVS: <BN8PR12MB4626BA56EDD1E2E2F3EFD393F1AB9@BN8PR12MB4626.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: If+BqHu08bqJmlLAzFR/mWMmDqnuuLvOxcqYeUxIJ+qjBPj8IdoEvStS28Uh1fwqNLxS+5cMPW63cyzIL9UHPZEd9wET6tc53BN16sV9brHxhPUPwq8dYji3zY3LR1H48mvp6OsK+Zii428MxblNkHqQgR/uWmsibRIsmY7DEe+/aXveU4b0fjWy8vFR/xRwEes7KhfysMzr1QoSi0yEuMnEKpI8xyb7MjL2t5T6dSYaLOON5wsXQeh3a++oY7LkvMIEntho2wBO9csj9v4skRyhRicUjW3e5SjRoTrOvYjeDXADmLkErpn+cquJvMBQFjLgEVlj5t8LPlG7wjxG303qFgtKDDi7xFV3mdRRfyykSTLnPSan+IvbCywwTMFSLSwXwB2wPTIkLnkVuq+d9ty8OzanoXk76D+RwbNDj09pPhoQJ6Zw8cWCx0Ad2vFVTiXwQzg3p/eLluTd49YvBtS0zHpFWerMWcKF3Ef3EIUFgeIS8BsHqhxlyg4wsGUCZCXfsGqKNRS0pHvCNNEP/Z88ir0kXIcOsaVgJtHwkHzsqZ5qct81fl0FwxM3HlIzHH/GhBbufpSIDjx9cn2edctZ/kR7sF6yNiCVpZ88Vo9g62aaysDM9nq9kBrcDC7Tvsj3LBfRxR4uWCjfJRFl1KlU2A4GKa8NPQGJRqU6eL/PFB8Ru5N45iihFxOyOI0+pN4W+VXyjLXmQSEj0uSxdty/6d/w+1OpdTuEkxt5dX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(16526019)(47076005)(2616005)(83380400001)(8676002)(7696005)(5660300002)(70206006)(70586007)(6636002)(44832011)(36756003)(110136005)(426003)(26005)(336012)(1076003)(186003)(6666004)(8936002)(356005)(4326008)(316002)(508600001)(36860700001)(2906002)(86362001)(81166007)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 02:00:17.5359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420d1704-34b0-48f4-4ee9-08d9847f3775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4626
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

When a PCI error state pci_channel_io_normal is detectd, it will
report PCI_ERS_RESULT_CAN_RECOVER status to PCI driver, and PCI driver
will continue the execution of PCI resume callback report_resume by
pci_walk_bridge, and the callback will go into amdgpu_pci_resume
finally, where write lock is releasd unconditionally without acquiring
such lock.

Fixes: c9a6b82f45e2("drm/amdgpu: Implement DPC recovery")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bb5ad2b6ca13..12f822d51de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5370,6 +5370,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	switch (state) {
 	case pci_channel_io_normal:
+		amdgpu_device_lock_adev(adev, NULL);
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	/* Fatal error, prepare for slot reset */
 	case pci_channel_io_frozen:
-- 
2.17.1

