Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 16:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBD661183
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 16:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EBD661183
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7466EB9E;
	Fri,  5 Nov 2021 16:58:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210276EB9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 16:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Q5Z5PXzkVAfkeyA077QmugQXrFsPXdoV6V3wc2iYO9Yf/R+0iWZoB9Lv4INFxVvnnk6VjZ6uwqldn+l/ZDtYcKFE9GGUEGCFyNrmCMum+UY1351gGDYs3gdkXioDjstf8zQs/luwyz5jTXrKX+KHT/7iOLsAxq6/vlFE8tTcv7ZE1jlYHuMX8bgUkSvKU+8R0XN4gFZUM37t+a/3T7zw4ValBi4UWZV7eKTn+moHoys+RDo/vYEVWyBsd+Sg1eqnEfQe3ONwN7aQ3r0spV/PmkN9+RtJqv9hmt0McvFYTMsJ7Z6+llp2CtWMT/kybuASOH4gD0YaPBk7iwzPfmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nMCmKX4XxaiPrMLXlQN84znKGHT632I4eZZ2ML2DaI=;
 b=iZdzkIfDZyfsmbARh8JIQ26mIu2i1pApod9DsRDxTOWJm9lKDE3MDsjGsqXjy7plW32Ej1oYkSeHgy4Ak04guLBtTBng46fBAcAQsGuxuH2QdWjlNGwKm6OG7Bt7ca7EkhcY1i06MSeAAMDnl3lzGbB+fmVPfvzlJYHRO/AZCURwd0lcofqlBB4GoRjRZkpE0t81nV8lUa+dUguc+pdT7kmdcbVjcpKMKpxLvXAlJSLlvAN6fjH+tlTQRdY9K3afxDjxppPsEbXXCIqJNQnFI8xujh5nLGsQoPpgaTkobZxGFefm9PsOrIjdMFMmXVFqXdXMgTdkfb5RSlomH+/Vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nMCmKX4XxaiPrMLXlQN84znKGHT632I4eZZ2ML2DaI=;
 b=igkCH66QiAygDvNYW36eppLujkKPMCiEeHQXB8rTFfo3JeBmzrujeW+QI2Nei883+bbtvaB4ALlnJTTSSoJFudFO1zc+20O6AGSBTMe2kQVtt5gDYl0N83yq+sVYVyF3uVGys+B1zQtSXN/gzjfz44PL8f+gJMnqX2U+PydlwOk=
Received: from BN6PR19CA0074.namprd19.prod.outlook.com (2603:10b6:404:133::12)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 16:57:58 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::8b) by BN6PR19CA0074.outlook.office365.com
 (2603:10b6:404:133::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 16:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 16:57:57 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 5 Nov
 2021 11:57:54 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
Date: Fri, 5 Nov 2021 12:57:41 -0400
Message-ID: <20211105165741.2617-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31295e05-5dcd-4e20-5b3f-08d9a07d6b04
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4237F2EB2116A5912E3D88DDF48E9@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHQzp80fi3CLOJch62+eFVxaGDoLPsKlU7C94knun0A3TejymsHcb3J0X4EFS8P+oGh57MQuNOR7GEaRq0dHIBwxq/eJh5op/1Xqqx8cKHBy/LShxRenX7B39j7+BqBNXshHK/7HCCjbh8gvxIkqzdAPTgQd2gT0K98nc6XIlNXGVlm7TqzV9+DTEAef1+VlkOMyyaA5tdaJXAWVYPVWAuKwuUrkCr1BNWECz8i9z+BWLHa2uC/ZcveQhKw+WcuWwpOVajnXVXmwAKKms8GbO0KSSdU7jLDJRe2h1JFmGi5dsOrQ6AAV5vO44iZkmKPO0o4wOBYSJoa7Y2ZJeMGTQ8XPFUUIIOmckHe8Ij0+4Ovi5I9gfAc/UGarsN5pjlPPwDrNMR7l3A36C4qohAU1VrpHOAH67LjaIENZyM8NagLxahL7cuSIidGBXuknQvVGJqNAXk56RFtaGNmvusXiFg3F3akD3d8AgV9exE1fYeUGyrP0UHjM+FuRZiOj5bmBRuV/pIUj9rOqIKoHtBskAN1SzXef8m2iesDLRTjdgtC7V00/sHdepbARMWeivGVYr8Jwx6rXBuDwP8bu72IW9Zv+qU7m99vK1n4yn2CJWO36DfzGea19gtvyYr+vE7NQ9oj2TktHkPN/GKCAU8USfK3ftBl+zTc5TO+jLQ4E9Ieh9Kw8wUEV9X6OoUgioHw/y6MGJTxrxMeAP4OSPmVjwY23YAwtY7WxGE7ANUiGZQJQ96fgv3Z43PaG5OQdr8a0b085EAmraD4CEyg73hRNwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36860700001)(70206006)(426003)(8936002)(70586007)(6666004)(316002)(7696005)(5660300002)(47076005)(82310400003)(336012)(36756003)(8676002)(186003)(2906002)(508600001)(16526019)(6916009)(356005)(86362001)(1076003)(83380400001)(4326008)(2616005)(81166007)(26005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 16:57:57.6009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31295e05-5dcd-4e20-5b3f-08d9a07d6b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The KFD pre_reset should be called before reset been executed, it will
hold the lock to prevent other rocm process to sent the packlage to hiq
during host execute the real reset on the HW

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 95fec36e385e..d7c9dce17cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4278,8 +4278,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	amdgpu_amdkfd_pre_reset(adev);
-
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
@@ -5015,8 +5013,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
 
-		if (!amdgpu_sriov_vf(tmp_adev))
-			amdgpu_amdkfd_pre_reset(tmp_adev);
+		amdgpu_amdkfd_pre_reset(tmp_adev);
 
 		/*
 		 * Mark these ASICs to be reseted as untracked first
-- 
2.17.1

