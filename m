Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DC6C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 15:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE64F10E3B2;
	Tue, 25 Jan 2022 15:58:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD1210E3AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 15:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNKFYJpvDpg24prBpQ0RWbi49CmPI3pPjwWjSNwxgBHMNo5vettzqRh6d5z484aCcOCKjzhhRHa4XcBa+TOInMqhnorRqQbWl1i7+g6iKZneLT9ixcUik7FAHjRn1IiwxZa7qI1cTWRVw1CPlrLdZa9sAHBvWttPvSBhiY7AYNRtolRmruQsvmd9vAafDXsCWiQAkPITzmBqR0z7iGLVnIvbWIp28Oo5X+KrkselOhqQanuxe/sStSu2Ivlz7OAZL2MqOzWuzwMtJDyxgBXFEXToyzw49ZZGeBNQ0U8zm1xrqJbrSTcXSEBeibCvpquLpM521MmGdAynBxnvh4lcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CFwEXgi4Pj1a4xFS/hRdXy3IMEJo8sPNDDTFIAUCW8=;
 b=Dzpd3PnDjTGh7iUvKWYypPswfxNRNUZsJxVNKyN5ylGI/zJD6EEHGFdfc1KYTeNJwHwMTVNoh9boOPgyIbXfhD2aRHqxZCprxOqP4mbzVpgyft2wCLLwlqti+Q8RqmJhlTxaIEAEMTvKTyb2sulxMotajwRPlS81lGGmkC4/LP0/pq7fwwgu317JjlyXghEOeIa8qodMTI40Ki7Kdg1cxUEauo9RAZ+4nLMd9EYmCzikE3XWNBuwBCeLGIELXC0CuIID8G3XFtNOWgGRy9avKDpP2vNkXesfXb7FNQA7Qfjdia+wQ825jx0BS3LpCUHT7LzEBNOL+gvB3McSPipX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CFwEXgi4Pj1a4xFS/hRdXy3IMEJo8sPNDDTFIAUCW8=;
 b=CMyuhXfFBq4YWcbMH5/hkXD4uKwJafGhZKzuK+GBOg08Daiv3Rj5KxJJUIlHZXlsqCqe0Sq7TZJ+TmzYDKqdBBOd4iAUPG3aZTuukHXNJPoERBiUPK9VCkT5eq8ax4bj0hIg4/6/k5qGNpoumdb3wvoZPOCmk2YhNDlREyQ92+g=
Received: from CO2PR04CA0167.namprd04.prod.outlook.com (2603:10b6:104:4::21)
 by MW2PR12MB2346.namprd12.prod.outlook.com (2603:10b6:907:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 15:58:32 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::e8) by CO2PR04CA0167.outlook.office365.com
 (2603:10b6:104:4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 25 Jan 2022 15:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 15:58:32 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 09:58:30 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Wipe all VRAM on free when RAS is enabled
Date: Tue, 25 Jan 2022 10:58:02 -0500
Message-ID: <20220125155802.938003-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bd1d8ad-1749-4358-fd3c-08d9e01b8955
X-MS-TrafficTypeDiagnostic: MW2PR12MB2346:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23460C6D9B175AFF52047D33925F9@MW2PR12MB2346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6sEo4iq93KHnzls186susEVVR+0nsnFEM+DxL8fisPLuYiYRJ+/zeJExeD60p+afJ7X3Fl279OFJ6EmoKL8ta//6lXGx8gvkytOw+Bb8NoxekCwFmdJIR6DPZSRu5fTGgwzIAs+ehFwspytjpiV2Uggp2ZmwsqrIhmJ41e89W3JP//mLZO6KlSxwaw7BjNxlM0p4zogHt+w69/WRVN+ESfn2QDGA2Sasfbmo8EZqt+cAJa2lYocaQt+mTZajuFIN0kWrzXvotNVK64v6BCNCVf3v8ejcED1RyHPUzY48JkFT/EPqr9d5LBZjkeeaRjbv3quaX014Jt37RXqdVbRtbEWBpWELtezOErrKxviABBYAWrpGc+rGuribXk9aCszJ5FERC02mvSm/97z5N688l1Xg5e2+/tErv3BIxvq9D1vtUJAyulrLRChuy2bc36XOMWkfjQWzWyQRXsLWrOLws18oruU/B4gh+SdXczIrSRbyYHWAPDW8+JL/nW8qmcivJZBmfdvK2Gzz/J4ZEd+VHwXIW2M6lPwZLcSY3iom5MXoZk1wk1fUY8J8rYM571SRF1MZi3yQrpHkq4Mn16XMk2oV6dw/1EIfWnwHZOZoSp+5Pprp0qGF+Wy/eMS0GzPU6vQNDpfWPX6V77nnpI1RzbSiBi0JisvM+67yB3+lAMEoqKFHowH/ZeFcPwjo+WVboNwvYAIL9NfPkMC+soBB8uCdquBfvuA887EiwXar5+h63SUo+biz5m02bBcqFmgAFIeYpXlGG2JXXpULriEdwhnueVNW+tCcE04w3Qtrxo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700004)(36840700001)(47076005)(186003)(82310400004)(83380400001)(86362001)(356005)(7696005)(54906003)(36860700001)(40460700003)(4326008)(316002)(2616005)(426003)(336012)(36756003)(26005)(8936002)(8676002)(16526019)(5660300002)(6666004)(508600001)(2906002)(6916009)(70206006)(81166007)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:58:32.0769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd1d8ad-1749-4358-fd3c-08d9e01b8955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2346
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
Cc: Vilas.Sridharan@amd.com, christian.koenig@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GPUs with RAS, poison can propagate between processes if VRAM is not
cleared when it is freed or allocated. The reason is, that not all write
accesses clear RAS poison. 32-byte writes by the SDMA engine do clear RAS
poison. Clearing memory in the background when it is freed should avoid
major performance impact. KFD has been doing this already for a long time.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ff9dc377a3a0..36bb41b027ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -575,6 +575,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_support_uswc(bo->flags))
 		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 
+	if (adev->ras_enabled)
+		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+
 	bo->tbo.bdev = &adev->mman.bdev;
 	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
 			  AMDGPU_GEM_DOMAIN_GDS))
-- 
2.32.0

