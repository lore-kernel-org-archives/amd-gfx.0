Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A0EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:46:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00373603E5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00373603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A409C89AA6;
	Tue, 26 Oct 2021 14:46:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDD589AA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 14:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfFageigCrhDVKWfQ+5FIOFxeQ00GCSJ10dMAAjrSenJXVgsTD7O6rmgpLOSuYsP/A98LCA4PlyJFn+hUTYvdBmBx/C5nXy+Ixk+qWsvs5T9UjNvZI8qgj/YOoALy3WE6NqXC7BFHSER9TeiWT17A3A505SyaS6EoQRjJeWpNJewTOVM67cCC0Tc5G6SwkhYUrQK+E7y9/OorX8Tt2Uf5rbZzAjbUx9LuUgCefvMJwxBGiTCGHYaNe3DvZMwe4zLf0TmZfid/DVVyQy8dOlXiviv3baj+8kpKbg+ZXba1RHYB8v9am3zbWbxMIP664TMix9aMAorROFRpKdHheqMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpTSj0DqA3Hgsr+nMyoS8ZYnzMikQqd5WkQ5QFCxOmQ=;
 b=ApW9mHICui8QuGBjqrG/fZqo/3usXjNgP5Zou+O2EObvKt5LYDB3xdKyEmWtduTXOUjrNz0HjU2mrZkkr36hNEoeXcQC6fnKlExqFnu06qcj9PrbLE+KYYnHuRmGjQAu14z+GP/CCA+0HZZw7pwpGmIJwNnQ3tPmPill1Zbk5/QJhgOmGcrdd75XXi8X69y6SI4q3x7MyhtT/4ioEiroDN6K+Hxegq374Z/kTwUdUP4XBbotfP0QwO2RBX+tO5WK73HJaa69t85p3yygLMpbBiobEpqQdUwEWDOWVTaKIexMiKWoIoEcIsf+ta0NOqVGPfKizqiEOeA5BZkx5FCl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpTSj0DqA3Hgsr+nMyoS8ZYnzMikQqd5WkQ5QFCxOmQ=;
 b=Ss1PGSBpegFzW2koCmgTRqE25AVvKNFB4P+fII5do67GBhUcriJHABh0f9ZE8RlzJARPlPn1N8ofb+JMNz2TAFcN7SF1RSSKKxd4G9dE+TNLNvh3AjXtpyg4lXmPlT7zQzp4Ni/rtEuGnh/0vzxo88SWMwaaYuhrIyU5a9+xinE=
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 14:46:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::7) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Tue, 26 Oct 2021 14:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 14:46:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 09:46:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: look up current_level for asics without pm
 callback
Date: Tue, 26 Oct 2021 10:46:39 -0400
Message-ID: <20211026144639.191828-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ae933a4-1a7c-487a-df1b-08d9988f726e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1890CAFF4A98DA9A06CA6241F7849@BN6PR12MB1890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CulVX3BhCyGEkWfJSFE/vgvTzyfgsJv9H/cU5HqF8sdIeSNnbnd0h/DzsqJtbzbuUh6sOAKVLdMj8D4dHwzC1YjLMpBygX3M/U7HH0kqPJYMfj8QanMLhl7FEdJLrFCOkvCi16lKj1tDxaborVgRcBk8z0QVSy/hJxLeRcpED9wZLLdMo5RLUUp8dICl4BoAbYLNMp3jjYM8GZo/kAP+1YB9zJ8JSAcA7gvrXDuWaXjzUIWWQDfIvOogGR/P3nEIdZGU7H9ZQwMAVEqJz1NUwLU+6Si53EABtux5BF5mTFNDlW9g2JOzuSaPFNl5XrS1DxGdt19eAk28n9v31balI+EOGWnCtYVCELJ2hY7bWI457vd5TvwotxydCQ1JXriVgUF3yps5uPgvs4tywYfATl2mDjyqiEOn8INgEdNaMl99Pm75aZdgEmzNB1vtPD492IWIR4Xt13CKcJqV9xeYsvJaZ1oPpRNkzzK8FIz6BmgA+vjyYPYx0A10LMZSsrVcNF5h9zUgVyLxEzPOaLWs/2+CaWfLheYuHC/CDI4Fb7841KnkDYcovisfFQ/VtPClaRjF5gR2CsvrjBjT/msOWACaiG8WH4Nu74ULfn/pVYS1uMwss77aPEYOe2v6ZeGfAZi7sZika8jceN/Faa7ztewO/18XG8wtjNeJC2aqEImWfEpA96xE3JZg0c4Jmz/pbiFY1uAMmO6e9b6QY1+OP0bGIO9lNhb3HF4LUc1S19k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(36756003)(82310400003)(47076005)(2616005)(508600001)(86362001)(2906002)(5660300002)(1076003)(26005)(186003)(70206006)(70586007)(4326008)(8676002)(36860700001)(356005)(81166007)(8936002)(16526019)(7696005)(336012)(426003)(83380400001)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 14:46:51.6820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae933a4-1a7c-487a-df1b-08d9988f726e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
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

For asics without a callback, use the current level rather than 0xff.
This can avoid an unnecesary forced level set on older asics when
set by the user.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 01cca08a774f..49fe4155c374 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -310,7 +310,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
-	enum amd_dpm_forced_level current_level = 0xff;
+	enum amd_dpm_forced_level current_level;
 	int ret = 0;
 
 	if (amdgpu_in_reset(adev))
@@ -350,6 +350,8 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 
 	if (pp_funcs->get_performance_level)
 		current_level = amdgpu_dpm_get_performance_level(adev);
+	else
+		current_level = adev->pm.dpm.forced_level;
 
 	if (current_level == level) {
 		pm_runtime_mark_last_busy(ddev->dev);
-- 
2.31.1

