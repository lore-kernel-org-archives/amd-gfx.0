Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0CDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 02:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504E111292C;
	Tue, 31 May 2022 02:27:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FCD011292C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 02:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo3NTdsJp3u/lOXKqK8f3/06dzeZ4PJMjti0gjCfg59EyPve6QzjIyU2ZT4w2/e3OQEs9XCDl1L6xTAlke6OBIN9DVLqPdVGwBkldkpruzX/9w8VybQw94LgMSTsI2N34/7DvOnCzE2w/9Ns4ek4mAUZEpj0iOANPOoBx0UPKb7EXOJJfQdveIHjFo0PeWFwwclVMeWqLbDb7mooZxj9rsf0U3r4eRdaDMdh72I2bSCYtfXKoBGq+n4zSVHcoQJbucE51ZgqiGs1WPH/RUm7JwSMiiqi2aTZJqJnVFun8Qw4gxB8kK3N375/W9bzU2buI6HRfzi9WlIwWo9zgvp5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGULV9mrUXkUOvg+ayc4g5xg1DyVpCfyjVWVBvyCJeI=;
 b=adNoifBopqlWELxmbClzvnvqys58kiAqkQWe+mZRqMyDa+LO059efQ8pK95dxp2vng4wrKrpE1GLTVo9a4gDVvJlEArFlzAb3/RP4fXZzhhfadUMybjzXoq37UdSuFCNnKu5H0zpMYRUiw/bW7/2xz58nE67BTSJiue5uneD6O9BT8ejG9DRQMHiK0NsXtZ0nk6AdnJloAgeE8FHFNFmJ3EjBVrbXMBjMNx1YEGrDokn/nJXOdaAyN57bePSFwvqloutzhig0ckm4rdlpN6LkhGe5SyJ5y3k2kgIUNCb+u6vHyZZdqUPB7fd5PluWIi/7Cmj4GWik9imKzpSCWxU/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGULV9mrUXkUOvg+ayc4g5xg1DyVpCfyjVWVBvyCJeI=;
 b=YBasJCS9SYHNESgjhQIbZo7OTKYSujv8sSWaCabQtS9KZAC7RwA3pVxt5cLg5n8vW2pCDlVXcnK+vCrxkNJWrgjLrbv9erCrxOe1L1BRsNnunGmt0N9UtO/MfPk4To8Ssv8QK8t8VrSTDy4zDwNdhj47mWBHmPOO/9KVfmL3BHI=
Received: from MWHPR08CA0047.namprd08.prod.outlook.com (2603:10b6:300:c0::21)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 02:27:41 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::2b) by MWHPR08CA0047.outlook.office365.com
 (2603:10b6:300:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 02:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 02:27:41 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 30 May
 2022 21:27:38 -0500
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: enable tmz by default for GC 10.3.7
Date: Tue, 31 May 2022 07:57:22 +0530
Message-ID: <20220531022722.2516610-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca295aca-71b5-4c1e-568d-08da42ad2335
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1660336978C369CD717A79DD93DC9@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puN7w9rYzmRONwT9uOOgobKUzkqNxQTHbrtiSIEUCh/StNl5XDNHZXjxadAvscodDY6XamrKNkm2Yqgel03OG9KLilrIpeytK6c0CBG+eUrISFm7jQumW/dya0G9at+t14HJp24MRLobdmSnE7lSPTYl36v6umi2BaOTEqN0aeAnCgAJidLyfuV0g7ZBhXfLuk+6WDDrTyde1zo1Em3v8LWnH/w8j3h8h13HtJaKBYjM/LQ6SGvadDuTjqRfoYcrq89JhWIf1vK8ZJLRIKIDXBf9V9GFJNr6bFKuoqCkimJVuKhTReRQPUHBawTILzsphPHe9SevlWkpDwf0jJXAsJVU4GfIM5RTOSR5LUztIs+C8/bD+kO8OdaSD3dZZvvYD7qlsnwEUtYZMZgXmarL2xhEV2mEal0WEX5pMxhCgO1nr1Hbsq3RSeVpO1Gz3+ggAxkLpa9aiR5Jg4JOERYYcH87x7JKWQlH1As+PazsnsG4Idk6Ezv7ALlKzBOscVNkMuxyPt/hG6VVpOfdfSI26I1K+66KO+gegCmyUHeEaV2yq6xsHFaDP9D3oujW8T0YIhdc5+dsvSUVjDEtbmZs229QBUbPU0olpHAal4sb/kU+ykT+nKS/OYJRURw32UKjMYfb7fHCNYtUIWbP0ZzaE/973ZeNRNwHQR0VLCNjwJVbl0D3SXBql5fiWJWAKAYjRMSIOHwYnJa0/uIkIITrag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(186003)(26005)(508600001)(86362001)(1076003)(7696005)(2616005)(83380400001)(44832011)(2906002)(426003)(47076005)(40460700003)(336012)(8936002)(36860700001)(4326008)(54906003)(8676002)(6666004)(6636002)(4744005)(70206006)(82310400005)(356005)(70586007)(316002)(81166007)(36756003)(110136005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 02:27:41.1945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca295aca-71b5-4c1e-568d-08da42ad2335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
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
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add IP GC 10.3.7 in the list of target to have
tmz enabled by default.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 798c56214a23..aebc384531ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -518,6 +518,8 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(9, 1, 0):
 	/* RENOIR looks like RAVEN */
 	case IP_VERSION(9, 3, 0):
+	/* GC 10.3.7 */
+	case IP_VERSION(10, 3, 7):
 		if (amdgpu_tmz == 0) {
 			adev->gmc.tmz_enabled = false;
 			dev_info(adev->dev,
@@ -540,8 +542,6 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 1):
 	/* YELLOW_CARP*/
 	case IP_VERSION(10, 3, 3):
-	/* GC 10.3.7 */
-	case IP_VERSION(10, 3, 7):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

