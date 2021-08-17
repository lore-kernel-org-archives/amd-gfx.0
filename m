Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F4C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 06:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9094560F5C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 06:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9094560F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F166E093;
	Tue, 17 Aug 2021 06:40:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC5C6E093
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 06:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1rYQhhUMgmJXeNxkZc01PsmeewZevcxWOIIfgfGWvl/d0q71hrxbhCfCSK5QZJVWAPTfb99GRS7Upuh/prBfIBJ8+bq3fVfqvwyW2xfqNh3Z1VmvQ1YqY7cvlUdhhGBb0v4R1a2XXOoylmt1M2MYQb9NKboSwIcnvUtWtK9wRnTKxpPtsZlY59RvrUOnAH2wi8IVO3nGfefZe7XFEYLArjTSZlcuPCcXiPyKK6KZ/0+K+vggDDjTUXwRdKzj8Zc19uFTzDUXTImAWcy91KWhseUlUR2O1VPBy4ZoH7om32uOXvk40rd1QERt6sh9pRyuS2AH7T5F23RSPu6FSIo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgqSWGfpgFS89HHOei2JsrzjMVHfYlDR5YEkCR4aTzs=;
 b=Omfpaqw8Zz/oR9F8quJEXuDcQsafrwYraWuxCJLZG+W7KLkHkaiFl0idicieqex2SslnqMR0CAo/nUo6NB+mBE6GahakcmtDaE1bYZNLojBy3gt/OhmEeXk3M7pjqtdPbaCVuDeP4Un7/n+1L9Ia08f5pK0tlDYmNaAgUeXh52W7S+fnw9oK5QDsaky8w0/xyG4BSi7lisdi0bcZEJ/M0+ElozeFzM1ct5Z7woHxEjPnbjnAegA40HFv5exog0uFmbrdLFhlDpBZmhl9LneOq78cglBkScDvixb6ZBup9gCs/Tg8JVjS/E5uGOXiWakZXCOC6U6U/MA2SsDeZEeyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgqSWGfpgFS89HHOei2JsrzjMVHfYlDR5YEkCR4aTzs=;
 b=aB5TXPJnCzP+tqdIFvQLKmwV5QUNPpdaSug2hfSCcF1YfndQHnqUoi3P0g1dx9q19FlZleNWYmcrAJ2Uqqqd9ZEBiFVGBB9j+B6/Ic3zIL8AjYB2HmMx1o4N2EKfa5qgCWn7zrR/0hPRiXvzK9lNXeWl58kSVoIJb12pfG6we2w=
Received: from MW4PR04CA0289.namprd04.prod.outlook.com (2603:10b6:303:89::24)
 by DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Tue, 17 Aug
 2021 06:40:21 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::96) by MW4PR04CA0289.outlook.office365.com
 (2603:10b6:303:89::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Tue, 17 Aug 2021 06:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 06:40:21 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 01:40:19 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, Evan Quan
 <evan.quan@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: properly powergate Polaris12 UVD/VCE on suspend
Date: Tue, 17 Aug 2021 14:40:05 +0800
Message-ID: <20210817064005.1437328-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18510c9f-7014-481c-2751-08d96149e2e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369A53893DADC681D2427A1E4FE9@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EUVPoDX+uIMrte/MJ/gvri7jx44c8tCKXhaXu00CVAqVFA1GP0c9Yb1W283+AR/N0ZWbK/6+e0i7GHq9jbsh2uUXACsfyVgTP4UzUcAuqaZwf4r2PNIF/sw19/NGRiVXfjMC0smNaFMy1pBP/IfDIM5/C7Dq826cG3BeN3dAGN7nkTEk8rTuhhk/n7tMmmPxXwth+h47balx+KxPLpv5qMSyuXTu1fYdwZgOaBHze0e6wdVptezISCkWvl2Fm7q7c+1bw8p0RF1EzIqTPhuMtJptAo9HDMC6yqR6NVKZ5rlVrIvBpN/4diyvoDilAmUDx959jtZzMJ+uHsoZVg60iQfHWke45mCDU7NEr8KWg02iV7lJFFpTf2TR0Qj2p2291Qlc69x8OS+PdDY2JIffYzJLgJbqeB6H32jJ4QHCWYI++gtQHxVA7GNj13YC/Vk7/e2ikRezK5Wr8i07SPhwd2uG7UxSV3aPIfqIafxkEkBEtJ+WxFPf2YewVuFL5Mp4Ytj2+sejXDUyDxrmobTSgGxgSM6dJd4nlqEtsLT5ac/Y6qCzOHnedax3dxx1f06n2NUAbt/uCWaLn6V88ghPzwZ3EVrd51f3A4xHLNdnCxXKnuv4GPcYUh6IBIZTIAVvjUMWgGdC+LwMI3u5ilc6auzrjEWSqYGEnKAza574ZjIrBZr5YRGRt9BESudisKXjb63ukyH+HaaRUqx0pBnpqVWNN24UwMXGhIlcJriAZ33B/i2D671MtaE/5uC89Mu6TchZf/OEN138XkuBLHJMSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(36860700001)(44832011)(6666004)(1076003)(86362001)(2906002)(15650500001)(4326008)(316002)(34020700004)(82310400003)(54906003)(36756003)(7696005)(26005)(70586007)(336012)(83380400001)(47076005)(5660300002)(81166007)(6916009)(2616005)(478600001)(426003)(16526019)(186003)(8676002)(8936002)(82740400003)(70206006)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 06:40:21.5102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18510c9f-7014-481c-2751-08d96149e2e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
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

If the powergating of UVD/VCE is in process, wait for its completion
before proceeding(suspending). This can fix some hangs observed on
suspending when UVD/VCE still using(e.g. issue "pm-suspend" when video
is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 4eebf973a065..2fdce572baeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,11 @@ static int uvd_v6_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * If the powergating is in process, wait for its completion.
+	 */
+	flush_delayed_work(&adev->uvd.idle_work);
+
 	r = uvd_v6_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6d9108fa22e0..f0adecd5ec0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,11 @@ static int vce_v3_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * If the powergating is in process, wait for its completion.
+	 */
+	flush_delayed_work(&adev->vce.idle_work);
+
 	r = vce_v3_0_hw_fini(adev);
 	if (r)
 		return r;
-- 
2.29.0

