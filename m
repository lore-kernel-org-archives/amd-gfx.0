Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B3C2B9F4
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 02:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310AE60FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 02:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310AE60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC0A6E854;
	Wed, 23 Jun 2021 02:10:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 916A06E425
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 02:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6uJd6/oE4TXgYFuxkNsAW+/LGK64HWZb90Y8wzOTmYnEzimyOQa3EE6P7AvrfdY7kVWcok72yOvAfUM0iicX0hD1JNShqDgMQpBhhxuOwozjzDGQKKieKG4BSmPsk3vnjret4qrGdqM8WHcGcYlTNd5AXZRY0U24B9X4O4GrDF8shMnWFWgqsU17Teuy8ygg+JTfdOjDwNKAZFFpf39pj/AbYK6Isd1oywaq8kiaAKMoePn8R4lv7luKtiuiPR8CnWAz0Lrgtnd3GwdstvX9cLJz4wst5u9lb+5vqvSRhuzQoohjPLqLIhNGxTmvz2TL+9J2bJYP+nEG7BJSnqmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr5LDiGoH6UT3a6xdMPHl/sLG54iZlt9qRL/eddxZMU=;
 b=Ngkq02IT3n2icYw2A40yG69M3Xra3sBYZdzcWh3zzF57D4OuqQihArc6BNqO4mAdNzgcP0wCA6RahQQm6cBN/KMu0LwC2FehzF4/EgZm0uf58JJE623j+I7uQI1ydwM9B8Rbv3VecJAQQ5xttuWr/eM2uIgsWa0TuUX0wHS3cD/If8sLkiFNx8bXLpX9mrCBWp2wvsPHHmTCDwplFiJngl6gmC7STtCoYOaZduyfH5Z0SXuDlrVPZc+aNdS4femwT4AOlM/BomIQIZ7wJrNERQs13PNpApZqbiW+JPvYeI3yEFuDhoH1aT3DNsLmu6PT4RWEXq93YO5Bf+xq3f6YtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr5LDiGoH6UT3a6xdMPHl/sLG54iZlt9qRL/eddxZMU=;
 b=5k3X07bskfoPmLaYcNNbTn+Rf9s8FkvAu+1MvHfHmmt4y6cccs7rccf3w/qQUhh4zQd/7XwbDa9zyU0v6ARmYxJtl6adrabQSYnfHATLaIpNzpmerFHIvNglP+xvsyD5MWHgYrGDxwFNiUNzCY7hkZUO354nq6B+BAv9TUvLUR0=
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by CH2PR12MB3830.namprd12.prod.outlook.com (2603:10b6:610:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 02:10:24 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::d0) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Wed, 23 Jun 2021 02:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 02:10:24 +0000
Received: from aaliu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 21:10:22 -0500
From: Aaron Liu <aaron.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable tmz on yellow carp
Date: Wed, 23 Jun 2021 10:10:09 +0800
Message-ID: <20210623021009.2138018-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524320f9-8929-40ce-f103-08d935ec0fb8
X-MS-TrafficTypeDiagnostic: CH2PR12MB3830:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3830960D8165C7005072E89CF0089@CH2PR12MB3830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: da32JYtNJCN9bv2vGs9L4recnxah2gURousDCjqAAroWB/wWbr9bVDzl52RAOGgwnewqUdnmd0Y5xJYLVe1XBwO4FZ6ngsg3hkDSvJU3rfBLfxiTFUbnnHc4S+PGqadAGVNIpcm1sZ4v7wQMEqSfM84QDb24nx2vIZWkVZkmEES/rm5csXHBtRc/iIzWTxrjan8EmTJrhpBAfVEiZnw3Df//NrYzayjMdmYzKyfCZlwX5xJ7WXV0Y45NRWXnlP9zOOWyGuS/gbATBr2Sc7oDreyp+t4e/K0WEYmeMRJ/tGMyc06Tlk/zHCBOtdg7JUayVJAo5UurPtGVF+VTo5GlF6a4OMhLWVcSr+F4C2rupBBOue92OSNJEzuVDXQ+wnvTJJT2cYf8dKLZQkbMTrkaYWesmpjDvVW0aikZTDxpF58SQUmPCPRUmJbiItssl81Z+IgDFazR0VkfRvoQVfGmVQcnGM4ZnI6GpUC8nxYZG9ZeMlSHu1smGT42fgdku2ImKLAjudtBfnrTxy2s8v0ybIX6PXggPlsRWIa8LUpkYI6StDuWFC7kGSUDLIz9UbM0nmRWKxUTX7/Ixh2c2T7XfmaUAo+8eM8Fdscquy5aoJR20dVPURfSOt9JbBtoZ0suJJg7fKp2WKPIiW7Arl+SCs5D66KaL3OPZkg/7aUJQVBEd4LRv28lhdeuw7nSG11L
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(83380400001)(36860700001)(47076005)(186003)(70586007)(82310400003)(6916009)(70206006)(16526019)(81166007)(356005)(26005)(4744005)(44832011)(54906003)(316002)(8676002)(86362001)(1076003)(2616005)(36756003)(336012)(6666004)(82740400003)(2906002)(5660300002)(7696005)(8936002)(4326008)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 02:10:24.0259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524320f9-8929-40ce-f103-08d935ec0fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3830
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The tmz functions are verified on yellow carp. So enable it by
default.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3014985cbf47..1525d957e114 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -553,6 +553,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_VANGOGH:
+	case CHIP_YELLOW_CARP:
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
