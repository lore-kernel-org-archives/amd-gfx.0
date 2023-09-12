Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC163CA0EC8
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 02:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C826F10E237;
	Tue, 12 Sep 2023 02:04:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C4110E202
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 02:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJEGTHvwZ0qfYTfeZsMch3lgg0ZRxwJSD/Q2hkgArd7vNrpNBmGDC4hwKB/K1js9k84yE3EZlTGI06L5yoAWHkzobEVU6PlWV4k+UIjS34glMJagZMq7YUSr2MoJEI/YXqyslrgumA+7CpWMhPY78cHSYA3bYJ63cwXxzqbyktyiHm3F/0JtAmvBEQoakP0skd5V7zME2jrz0o/GKTbXHojgZPjalQWi7yU2/9nxS6oU07/WGBOlz5dbGJZqsk3heYdphPY2J2a1mQPW2Yfr9JGFo2L/0YSECOP1f5QKgaPtqOeCLE5gteMrwXIdpF8UEzWj9CfQyVuOZFHcGP7VdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8ApzVe5iqQHWQx6FndyWvCkbGu4rzt8RmYxUMZg0J8=;
 b=D7fsq+NwLqQivn3zMMi3HgvBVI/lsek7KYci9FN8F1ExlZuOvbjsXrlj6E10YasFdIpft2WRnUaZ40hza4mHHrxOYKHPpmvCLSufdTrMQFxEdF4mei6IKYfrOonW4XrJiMcamzenuQoWp4y8wsKrShERA1MfAd1xH28glyAVD2B0Ni6TcNWmMuGaXIBugSFFM3Lxx4qAAl0UHrG7qeTe+YsdI4JL/ycaxvz+/+9rCeQ5+FZtuIx6Oi6ZIH24cr304dUPwGrhr90gw3TBbKRMbd67SGmelqQ1ce4Ipqfamz5GMWo5Uo/uDtPsDY1GsEFpAgNkdrvUXoIVdTAX3/Uacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8ApzVe5iqQHWQx6FndyWvCkbGu4rzt8RmYxUMZg0J8=;
 b=dTaYJoZzRPLkTGhEkilBhYTbDujnqFPtw2Hfs4fIabT0tgJQpbR27MoAdP+IElV6PRm6nYZOjYH+rKsGp3zn8MzfBSdX4hTKuliq8li/pbvHlf6SF72IkQsaETyKFjxQ5sQzeuTzN9Yd63oenTsiWzjS1GX8S13TJWNbMcv/GAc=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 02:04:00 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::66) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37 via Frontend
 Transport; Tue, 12 Sep 2023 02:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 02:03:59 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 21:03:57 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
Date: Tue, 12 Sep 2023 10:03:43 +0800
Message-ID: <20230912020343.753175-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SJ0PR12MB5408:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b77be8-3d7f-42d6-5c3a-08dbb33487b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6Av9wwZR6NfWMTbXz5y5N4yrjk4FiEZaQ5Bvsx642qLyfy70Jwx84WHf09xBtQ49nABPTUFn58ty6qutm5CA7uM8K0iN4TW/P/Pd7ukZNwFGG2qppzIA/qW5E++A6+5PFhEpQsfkqlE2HZyF9d1R2UKcj+3OXBufsBMAY/ZV16lFTesHMx7E25JPehn9Q9zDYUJSVL0CIXlZK2ysTepb8hzSyRy100H4swqwftxqkNEBFTH/kxYn7u2fc1phgja0/X9xl2jJJRzL4xTDQesgwd0ZtP6GSLaBiBVTneYz+L8SwMRiv7wvzIx9lzSrA2XfktEHWKm+woyzTkbfAdnfK5G2G+Jm/R9rhsOj9GSVOR+DqinNKgiK0OwBFezzyUzfq0izHFWX5u2VDMxYFG0hYDxVT0FhlhNtW5KRVrmj+PENZfu7SCRhrocGoNuAujsyRTJKjZ8TKZgjmUDP2QmG9HEaFL5MXuISYG7r9F2lPXHHa25SBmWl5IbSaXABJMfOheg5Y7TW1xxd34pMk873b8Ke4mz2AgbnlXduk5ZMIO806zyh5ejCwLFZ/pBB5bw/UZN7O1wWcMM08xGS1NR7+hhCOrtE1J6NSvWgfLHALpQS8mGozPtEGXCRUmvI1XZVjyazevuoGJ08G0kdLq413kO/byPnb+xE6PYv6YkKoKxydSI+WYlpNmyHRwUypav0SM+QuOZr3DgCa5rSGJ7nmn8Yx+PuDvjOYSlWjoKrTue1AlsA8jHzT/FJhCNffmuejDVugv4yf+gSg98zCZ96A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(5660300002)(7696005)(6666004)(83380400001)(478600001)(15650500001)(26005)(426003)(2616005)(336012)(41300700001)(16526019)(2906002)(81166007)(8936002)(54906003)(6916009)(316002)(70586007)(8676002)(70206006)(4326008)(40460700003)(36756003)(40480700001)(47076005)(1076003)(36860700001)(86362001)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 02:03:59.7844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b77be8-3d7f-42d6-5c3a-08dbb33487b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
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
 christian.koenig@amd.com, shikang.fan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some BOs might be in use or locked and then the first eviction's failure
will abort the suspend sequence. We will try to unlock or stop any user
accessing these BOs afterwards during suspend. So only the second
eviction should succeed.

Actaully the first eviction has evicted most BOs, so that should still
work fine in sriov full access mode.

Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call during device_suspend.")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c0e2b766026..f381cb90c964 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
-	/* Evict the majority of BOs before grabbing the full access */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
+	/* Try to evict the majority of BOs before grabbing the full access
+	 * Ignore the ret val at first place as we will unlock or stop accessing
+	 * any BOs afterwards.
+	 */
+	(void)amdgpu_device_evict_resources(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
-- 
2.34.1

