Return-Path: <SRS0=ROs4=M4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D0C4338F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 02:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E8260F41
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Aug 2021 02:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1E8260F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8BE89B61;
	Thu,  5 Aug 2021 02:37:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2B289B7B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Aug 2021 02:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MY+mmmTgcDKVzocEwyAKLt80hE/FondZ3nm2IQFLtO5rcLh3CLERvKn0x7pfuJ5gMuo9s49TrLNlsC0JCaBBG/tJ/PYXfXtvOq7Fvk6c9QaOmvj2LTvVHvbJ2StFhteelT+pfnHBP0z4v1IU615fhztEgYuQgQXl7evksi5YSA8AoqqFJS7G1ZLrEJYhnFuaDyDOgjEIuzr6pwsuyM1TpbKRkjJkWQSbWCysNBJRZLaiHfD6kW2slxd4IJXjzrfBjjFIrAiK8bHr6q5r+CooA577THkuE4JasKUeBwHjEdBQ/73BI1lP8jfrZcvMUV8Ji1tYpzgIHabRo/DvZHyoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9ngrh+rh9d2LGNqUSKI5yL3DPrL/Zh134VUcVK1duE=;
 b=ZYaS20gn2Q2JLFtX5tQP+PwYmK+NjTLiKXbmp+CHAoXGW5BgnE6EAHyKdXooF9jR4AaOabuhADcyh/otZEdTFF9WSo+lRTadn7Cx+RgZtri6cRTSmfu3i7fKZrjAoEn3LI6pYSQif4r3wPMOT34hvcc5Wu0n+kPbmBYYKM8gmmXxHKcl7f/XVNwKE+yZKRAIUvezoNkpRgo3nVzhF0oZCb1Jd5BkOTD7l+cZVi8QW2C+7WvT1RKJOIk2XnRCVv+Ga95GVisCKHF/oAJzoEM+j28nOgby8mGmQ1CLFbIEzBO/vo1P5ln9IUInzmg8WfXhZWQXOdPGaObZXxJD6XLUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9ngrh+rh9d2LGNqUSKI5yL3DPrL/Zh134VUcVK1duE=;
 b=PZWqoqJkw+5NUy2meZQWmtdlR1f+WCFJjPUVUsutVSX9zkXB+3Do6NKdfwNd/HOKEwi4XunBtAmj4sI+bjJPxKbJMp+qdo6VsXM3Sp1xa+/bRWGjB4FvxB6OvhfgLn4y/6/CAJ/71dsacLpUdC6p8jtXzg9IkBh2EiNOPm6avvQ=
Received: from DM3PR12CA0096.namprd12.prod.outlook.com (2603:10b6:0:55::16) by
 BN7PR12MB2596.namprd12.prod.outlook.com (2603:10b6:408:29::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.16; Thu, 5 Aug 2021 02:37:43 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::75) by DM3PR12CA0096.outlook.office365.com
 (2603:10b6:0:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Thu, 5 Aug 2021 02:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 02:37:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 21:37:42 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 4 Aug
 2021 19:37:42 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Wed, 4 Aug 2021 21:37:39 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Evan Quan
 <Evan.Quan@amd.com>, <horace.chen@amd.com>, Tuikov Luben
 <Luben.Tuikov@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Monk
 Liu" <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang
 <Kevin1.Wang@amd.com>, YuBiao Wang <YuBiao.Wang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: skip locking delayed work if not initialized.
Date: Thu, 5 Aug 2021 10:37:36 +0800
Message-ID: <20210805023736.699291-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b1dc5e0-b704-4cd8-034e-08d957ba0062
X-MS-TrafficTypeDiagnostic: BN7PR12MB2596:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2596A49DA88CB6747579DD8DE5F29@BN7PR12MB2596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JQ7G2cdKQenRunP4OVfStUfuO8aA9zmUnbRInrN6uzF/Sjh0brELX5+SwnIQVlykcSydqR2f2dIZ0wjmrYwi25iyLH+/NlW9AI/G7DFbebJT4IkuzD5VjxFRUgVS+/S0/R/pAsJz0ReDN+8tpaP9wZ6jdBbp6cy+e/cmAFWZ1+jx8Ua4yIMibQaDEHTqt9INnbfinmH5BfpaMerhsGY8fogFjcRChjmSjOBkFJ/HTzuLy+Jm1D3qtLeryPtFa8QsTZ4aDg1x1nLIgthO95XWqGDnNO2gHQnNV3Qby+EE66qc+rj+OisZP5Iv914y0egH4Bh2GLhiwrOOWJMNDAqJp4/D/NIH6dzxdqFk2OE4axb3GbALwqnj1KmxK6wt2DD5FTFEf9d/xnmzl2XKTfBsw0J+LH+KHl9Yc7c/FT3oGqAfHaEf/lgJQ5q/B0Hm+12Gqxnp3XgGotTorjnk9jXVVUTFTlCAjzgLY739HCN0SA22lLCphthnBKe8AL9s1ENARLJxw/tHapHgATdoRE8WrxFrCHsBitQLYpaga1w5T+WlqgOjKJbg/AOm7j1zOFeVqLTxXkzlcZH7ZyLzj1/ygKn7ixKV2NoFjK/IJDQdalx/SeabSuLp4l2YbVbGDAbsP2R8CwNVCtTbCE0/YuHaSMIt6NAfTynmsm+DkyICWADcgErEpkvF4sot59zJl8wj5RG0wFF7fR1T6/+CHFFktOsoy4TsQ0tjbnR//kpXOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(36860700001)(186003)(336012)(70206006)(47076005)(8936002)(83380400001)(478600001)(81166007)(82740400003)(26005)(82310400003)(70586007)(356005)(2906002)(8676002)(6666004)(4326008)(4744005)(36756003)(86362001)(2616005)(426003)(5660300002)(6916009)(316002)(1076003)(54906003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 02:37:43.0623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1dc5e0-b704-4cd8-034e-08d957ba0062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2596
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

When init failed in early init stage, amdgpu_object has
not been initialized, so hasn't the ttm delayed queue functions.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9e53ff851496..4c33985542ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3825,7 +3825,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
-	ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+	if (adev->mman.initialized)
+		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
 	adev->shutdown = true;
 
 	/* make sure IB test finished before entering exclusive mode
-- 
2.25.1

