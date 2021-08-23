Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A020C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29DC61262
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 08:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F29DC61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916F489CD4;
	Mon, 23 Aug 2021 08:35:40 +0000 (UTC)
X-Greylist: delayed 15453 seconds by postgrey-1.36 at gabe;
 Mon, 23 Aug 2021 08:35:39 UTC
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (unknown
 [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708A489CD4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 08:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzErp7Cp17xMzjIQKUiP1OYRWsgnOFYFmfm0bhtkSK6TZh3/Pxd34ckCOEle1MIVoZZXULxgitjDbVYUuWLNuSFonRNn/Lm+vX+V38yyZcjGsesbwqGQdTVTzzV3jTtTu4FUo9wCoQal3CfCTALrra+AHmfDqEhmmjvOJ/07Pg3xi5xPeginJcu/npjMhJh+5ba3o7uYdn4tY92tMXKgSNUJlCdHX9dm97WK90oWXJvPn5qzDlOsQVG7w5dlyuTEvwRQ90l9EiKZ07Yhyt/KINemYijyakLwQpVUtWVZDSlvgGp+vWQM5BntEvQ+q5+KuibeQumEbQ1AxKtQBSMxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO6YUUAVuiP+/F/RliZSG6QGWQseammcLWoPxTuOJcA=;
 b=Eh1TezoP059HlSp6R+nYV3uL6M7+0WDvElwEQh1eTGraJ6CbURa/gpEgxOk1LNrtvdSS1rq0klvA7evPrOlpTGg3p5CUfB8BixA6alSgEHhQr9K6xrL/j0R4Gt7kZbhM/DsZN1oogs1FhsAFe/rLTMdV7E66tiVSkfvQbBRk2kRiLSarC9V7xxdIYFzImUyXO+OQR5Trxn/3gaYaL3zihWjI/K5h5qSLaT2uus22VMBuMFsj3beuyZpq1YRN10bKQEBzk5T3l44gU9zC8vYjAHpr6+Ns2MbBDSoO/oG3bckFGkZPyr6pkasxRO7cGli/FNCHbY8zWmuxPmTN0hxA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO6YUUAVuiP+/F/RliZSG6QGWQseammcLWoPxTuOJcA=;
 b=kXS5JjWNicqKvH7vuSEuqUjyxwbN+2Aymcp39u5uwbpi38LJiLhecPScj6tzq56LFAf+1UqXTqZktbvlx5PpJycXqFzj9UR0huyHLjPkjIREr50z8bF+IsUVIFm1y6UHZX9Pnrsmte9C0dncdpq8ymeyIQMyq0IZjCSgValG49o=
Received: from MW4PR04CA0164.namprd04.prod.outlook.com (2603:10b6:303:85::19)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 08:35:37 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e5) by MW4PR04CA0164.outlook.office365.com
 (2603:10b6:303:85::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 08:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 08:35:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 23 Aug
 2021 03:35:33 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH V2 3/3] drm/amdgpu: drop redundant cancel_delayed_work_sync
 call
Date: Mon, 23 Aug 2021 16:35:05 +0800
Message-ID: <20210823083505.53711-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210823083505.53711-1-evan.quan@amd.com>
References: <20210823083505.53711-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776efa1e-cf50-4e56-4790-08d96610fb3b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4925:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4925D3B770BFC2F21D011D93E4C49@DM6PR12MB4925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KK83nwb7pYUvTwAKJQc8QaR7uS4DPuamQjUImwqy2/MJYFdWRmfuaXpL3zT+QQCwto0M2pVfepzWpNDmi05AGJ06NDCzfXklEJoFbtXbI2JSUvbGg6ddoH0NgJPkLA6XM6+hm/u4AAjzJJn6RAZ/RKPXOqeh5QolY9kApfX69dl7LJOkrnev0464yJ6uGM00VmMpz4FHCYCpcplqzOd+V0gk7PuQcnGMbEyfNh9suCuLcxE6JZQX1e6K40voELwC49TOmDVpyklSkqetFAifVK+cjANdVJwh5tK9NAw7EbzyweJ7neZcdE1VFk/lre3ixb4srKnxljFc5PqMVaBwh5o9W/TgNsZZaVfS544Mtk8F6tncUwvFYyFi6fAW6ithC1akSZrhOQ6arh77bMiKJU3tVqXgnyUQsqm3B62oo3Re/RdPMNDs/EH3sSA3wyPSSkyqOSvsIRnw4aFzrn4Y70jAk4XTTzIEtVznKLMZdffM8NuiChw2x8rSXprs33ZILF4vp6kDeQlrWIguihvyJZa96Ki2e2QwjMd1bm94miamkRMbMG7ShOthDfcsvl5BZa56opVWykv+IMSv1WEKwflwSv5KrUfYLLOPPdkWnbxUar+w4lL4tI8sfDv7E9Yv/l9/7/+o5mYUeAJdOy2rLD4Vd/VcPa6NBCvoox7FurJKzT+iaq9t6Ld1RhTc+eEk9ODM7s/mecepXXKeg2kHAmo9fxRvznAgz7a6A54IV9cQ6KK5mwkN9F6vW2s9iCNnknsmw09iDY5l13wCIZNkEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(2616005)(8676002)(8936002)(44832011)(36860700001)(36756003)(70206006)(2906002)(70586007)(426003)(83380400001)(26005)(6916009)(336012)(47076005)(16526019)(186003)(316002)(7696005)(478600001)(6666004)(4326008)(82310400003)(82740400003)(34020700004)(356005)(81166007)(1076003)(5660300002)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:35:36.8442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776efa1e-cf50-4e56-4790-08d96610fb3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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

As those _sw_fini() APIs follow just after _suspend() APIs.
And the cancel_delayed_work_sync was already called in latter.

Change-Id: I7f092e39242a1ffbc3c29e1fcd7bf31b769b0ef5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 2 --
 4 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 8996cb4ed57a..9342aa23ebd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -47,8 +47,6 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 {
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
-
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 445480b50f48..57849bef0cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -325,7 +325,6 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
 {
 	int i, j;
 
-	cancel_delayed_work_sync(&adev->uvd.idle_work);
 	drm_sched_entity_destroy(&adev->uvd.entity);
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; ++j) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 7ad83da613ed..e38d494cc413 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -217,7 +217,6 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 	if (adev->vce.vcpu_bo == NULL)
 		return 0;
 
-	cancel_delayed_work_sync(&adev->vce.idle_work);
 	drm_sched_entity_destroy(&adev->vce.entity);
 
 	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 84b025405578..1f21e8fceab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -257,8 +257,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 {
 	int i, j;
 
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
-- 
2.29.0

