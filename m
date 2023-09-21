Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52BFCD4941
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 03:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6494410E099;
	Thu, 21 Sep 2023 03:33:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C98510E099
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 03:33:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBxmBaOg7Lm1h3axjBed/lOYxZWPRl1BTw02P5INDBSbW1A7U7sKicx7nKzaJGIc24I88wG5FoLM2i7h60d507XHXeEpLQUaccCQTPBjOfnu3LcY7pBWLgmKeZI0SVu7z01apqfjmV8iNPkmLp/NKS1Um/+jyvUI7QU0mKfiSWy20yXsXQ53LTxMRFABnkpRfNkSSx7ZtluwRPgoxfX8hFmHuYfmfwwP3N7xcV5fdLa2ghideej/DoCVb9BrT1Qkgb8Q+allYkCGDsCDOT6aI+PY60ke89RBf3nKgcZghiWKesbvkh7oFr+xtS5sfPMDuuxSTpf7wg3jWtcVEg9veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9soa1X/z15RAbs7ARi5M4JuyTHgm7P9EdDUBWeZDFi8=;
 b=jeFNUNa4pWEQTdapaMg2cYAuhnnKg/EFN+WY/nMEDKOMUxUkjYC9VFsdOZGJ9O1eXEGjdRJmsbbcTKcus+0itWMNANzO5JQ8LWne09gGM7Nw130AQ7621HUssHBW0gIn/gBO+DOZoC8QnXv06QJ/brK7IWiT/RaL2OdjFLaK8hv1cBLQPHTXq4zXJOTVUTpfcI56lDrAI59Cc4EDLWzr2ahUKr07a5Anu9xw0ua/8UCpettjZimx3e6sRtnLUBQ95Drp8w34QtcY6aG8FzmRNRFQvvj+IVP1LSCua8ir+08Tlzg6gx9ldesRmq2JKfwdkTim/JuHBTL95irosYNDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9soa1X/z15RAbs7ARi5M4JuyTHgm7P9EdDUBWeZDFi8=;
 b=hvMpQVwDNV2+MzYA1fowpnAC9fYv0ZEfh2XvNZc6gXETxPO5bE7VgPerM5RX5umlKt9XxPemlaTGwRUhoNB2IpTScyx8OYfKK65dfZQKv/tBOss/87qw3pVt8nrrBk1BEY673ID2GqjUc45nKLjMai7QFWUf+MZolWW/Yc9j4NY=
Received: from SN7PR18CA0016.namprd18.prod.outlook.com (2603:10b6:806:f3::20)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 03:33:10 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::cf) by SN7PR18CA0016.outlook.office365.com
 (2603:10b6:806:f3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 03:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 03:33:10 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 20 Sep
 2023 22:33:04 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Move kfd suspend before evict resource
Date: Thu, 21 Sep 2023 11:32:42 +0800
Message-ID: <20230921033242.22593-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: e045eccc-7b7f-4bc8-24e0-08dbba537ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7p7PIIiGQ+uYuf7EiIXV5JFCHMJY8ixMlpB/hXRLByYPWw62cfvFREhua6dMZG2FW217aKdOrLVcFtu3d1bckxP8NIwI54154EQqf0PlUOh0LZ1GTkp2pf38VjXb7kIZNCRFI99avgFydDjdvrOKS8SDs0+1NEuqWaHeLaoWF1GQcF9p8IVoRRQZPKmWuTYbroPXLpLZejBAqUbCT29xXUaRwpD/ALpdUwd6BNsiE2xY7oOSVggh4RnNXy0WX0WlUULOS5rwOILdVfKd15ZIvzle2MLQnrKpNWpkp6U07Vp6vLoPYkBT0Dt9vyxutlCPFKs8jiNMs6NQYK8vQqJhR4tJSD/xIAOQop5q1+QeIeqhBRi36XmS0Ww+nPqizlXLgCrNfndSeFcpOJ7SAV8160POpfw4F+hsBRQxHze0kL8BVhTs4K16o2wynHxAx1Uc+oDNytqnjtqIPAvA4N1wY8XsF7MrclCkJY3vM4RBMn+GhXyLCuIE8xV/sZCoaTx8bi75LCDBRcGoAVL/Zt211akuelLqN/c+xBefs+UHRURXIo0mvMK6a0zGLubfOi4JTLwbz1vAaMAHPWQzqKFak4IXZYZzjUzy9JYCjTEdBNLO+Pm8rqS7TlITzVe8BjaqStWobYrV1KYY5YKd0tAuFaV7Ecazx7EwwADmlUbf+jxvJgs4l2g/gHZj7HeYr086K6g13RduXZhK6bttGcpu+7HwkZMehW4Er8LaHnH7sw5sztdaMsJLT46rjpX2TfC2PqcoDWmiQpDtr0Ti4WVRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(47076005)(15650500001)(83380400001)(40480700001)(82740400003)(6666004)(356005)(4326008)(426003)(8936002)(8676002)(336012)(5660300002)(86362001)(36860700001)(26005)(16526019)(316002)(40460700003)(6916009)(70206006)(478600001)(7696005)(2616005)(36756003)(41300700001)(81166007)(70586007)(54906003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 03:33:10.7158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e045eccc-7b7f-4bc8-24e0-08dbba537ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Like amdgpu_device_reset_sriov does, kfd suspend should be called at the
beginning to make sure kfd BO is idle. Otherwise the extra
amdgpu_device_evict_resources fails or amdgpu_virt_request_full_gpu
timeout.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a084c3c58a32..ef7c7f2b3260 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4148,6 +4148,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
+	if (!adev->in_s0ix)
+		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
+
 	/* Evict the majority of BOs before grabbing the full access */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
@@ -4174,9 +4177,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_device_ip_suspend_phase1(adev);
 
-	if (!adev->in_s0ix)
-		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
-
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
 		return r;
-- 
2.34.1

