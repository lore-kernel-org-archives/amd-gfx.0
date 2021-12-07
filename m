Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E40C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 06:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BF773903;
	Tue,  7 Dec 2021 06:40:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0754B73903
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 06:40:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7+MiOYgF4E7f9NcmsuteXetwOSrxywLdFPyMA722q/D0oMScfMRruNU02WS2UtBYURimFSkUdeVGgzZaJ9GUELXkGb5BpWQW2aHTnYA4lMlC4NiB598tONfDjSq8qQg2thC8XZKDzYvmbglLzCpwmYJ7wpIqZezB/M4ZvFcwvLL7ZMjQN+ViNfFshKWA7TpVgjLjYqV1RjFC8aBQtYcFlKQVCuWEHa9XQs4omMWS6WDeZZx4BxjPoG75A0/Yr3FgdgGx3VoKU0KIA/1oexDWDzVc05zKSLVtfkABQI8rRgpdK2ftKmY2o3s2uGhu26ICign0Fn0JjiKtO1RCTFwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvWoTD46M4mF5xMeC14dOwA4yXieqSR8x5TDFelLOK8=;
 b=XvcEDrcygCeYnc5fLQYnWjVrJ3dzG5dIlV+lRrAZ2bXfxbOGcX7uwzmz+qgFEwITQXYR7J9ey6UrzfI5Op4GwGnGdD0xG0TihU3NzExEWqWO7d/8B+xm84qbR4/wRobPEN4kQ8zWKyT9kQB3B6zK6/dpShD1DVNz8V+Xxba081gcEAUjWx3pd/fE5Zd/UnFpq6LpVWjWQL3oDNMCgz0MH0cCg6tvFBHcCcGN26smvYQRNrFUrKSJxnioBvtBL4nHlbUuCSwnGKL2kUGoTZ5ksO8yJ8qYb/Hd58MfKY/uwd4r50dup6y0vIq2jGF2MBt2oUiEo5idbV/XlzEoA90UqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvWoTD46M4mF5xMeC14dOwA4yXieqSR8x5TDFelLOK8=;
 b=YkNBSZxrjui73RlgAafHAViQbPOnI9d3jUY4X8tLAbaUD3lmefUu8jNki0b/liZEpvz3+tzNeUsiNElyz8Ay4NrpbiQ2Bj31LtqlmGcSONgpTsITeAN7e8nnd+Kpl3laZyY3jz+ru+w0Jvr10LzKCn3krYjewFzvFyrx7dR48Os=
Received: from MWHPR04CA0066.namprd04.prod.outlook.com (2603:10b6:300:6c::28)
 by MWHPR1201MB0253.namprd12.prod.outlook.com (2603:10b6:301:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 06:40:18 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::58) by MWHPR04CA0066.outlook.office365.com
 (2603:10b6:300:6c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Tue, 7 Dec 2021 06:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 06:40:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 00:40:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 6 Dec
 2021 22:40:09 -0800
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 00:40:06 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>, <candice.li@amd.com>,
 <yipeng.chai@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: skip umc ras error count harvest
Date: Tue, 7 Dec 2021 14:40:05 +0800
Message-ID: <20211207064005.14026-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa931b6-e21e-4193-2afc-08d9b94c6f3a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0253:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025304C5581D53056402AC6C9A6E9@MWHPR1201MB0253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/O1/ePla9uQDzgwoTpYmkmfxfoNFJ16ltjT1ebDwf9VJFU14BtPPq35CnWsuKuP1Jd8i6kkYhdq7KC5FCiKnNxJS4zK2b4nyRc5QmtVuactFo/lLZyQISIxrgQwvDYAPR+quhAiKEBwgLlziTElie75DnzqAtj+CXZ0Uj93nPjj1RJjPRksVdP1smpjQ3G0Hwadte7sgxuljDyTg0HNrfkAEltQumBP++vZu5vTtudxJk1dToIdWwXFFUSkjXo6J0PH/xvf1vIz1Q/ghdjRnmbI8Dwf8E/E2ZhznMoilePj6Fa7ooGSu9tcyYyBMCIvcmT/dm6E0dvIPyQgCbc0btY+oQIaYMlL384xSB0K/zfwYIeObk4zWuSDTYoW8usjfX4ujxT/FEI5YRVhGoS7ITbgVFV1050nH7ZcZgmhF8byPz7U4IAsMSSiWg28sxxlIPVQulZClLKJwoXSZHjHz8X3m5kti6Gn+CKqYCiuhB7ycnTZZa6rMMbPOUe83jUD2ejp5G3Wtn4059t8dV1V+D7MuI7g3UUvGJgu5h2pY//BFGLu2/2aYSwouS9SfNu9m+40fax3zeruUj+sYJhNjnGWcXLNZd2ztEfWFEGctM52GJVk5d+V3YyChuewjacKNUItX4HxJS8H3HAzhuFiUAPnT7XfMgW6zOjtL5RT4pR1ZGKiFD1kzwmPTRgolWP5pA4TezPnUdBWr9epJve3ZdexRHLTwX8gPfLo/rfiyBQaBweFUSNoglotnxWDscmmOPDYHD/6k52RTaXAAHHCTNOAq/aGDnD3uyH+BU6g+lw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(7696005)(5660300002)(8936002)(8676002)(70586007)(426003)(336012)(40460700001)(82310400004)(2616005)(36756003)(6636002)(1076003)(70206006)(26005)(47076005)(86362001)(316002)(110136005)(356005)(508600001)(36860700001)(81166007)(186003)(4326008)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 06:40:18.2809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa931b6-e21e-4193-2afc-08d9b94c6f3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

remove in recovery stat check, skip umc ras err cnt
harvest in amdgpu_ras_log_on_err_counter

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1043d41b6807..a95d200adff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -897,11 +897,6 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct ras_err_d
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	int ret = 0;
 
-	/* skip get ecc info during gpu recovery */
-	if (atomic_read(&ras->in_recovery) == 1 &&
-		adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2))
-		return;
-
 	/*
 	 * choosing right query method according to
 	 * whether smu support query error information
@@ -1752,6 +1747,16 @@ static void amdgpu_ras_log_on_err_counter(struct amdgpu_device *adev)
 		if (info.head.block == AMDGPU_RAS_BLOCK__PCIE_BIF)
 			continue;
 
+		/*
+		 * this is a workaround for aldebaran, skip send msg to
+		 * smu to get ecc_info table due to smu handle get ecc
+		 * info table failed temporarily.
+		 * should be removed until smu fix handle ecc_info table.
+		 */
+		if ((info.head.block == AMDGPU_RAS_BLOCK__UMC) &&
+			(adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)))
+			continue;
+
 		amdgpu_ras_query_error_status(adev, &info);
 	}
 }
-- 
2.17.1

