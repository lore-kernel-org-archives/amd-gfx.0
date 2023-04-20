Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0827DC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 09:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AF2110E025;
	Thu, 20 Apr 2023 09:19:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A724310E025
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 09:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwXmXLINwhF9aOtELJDNPBcQikwtjpj+VBnBNWrz/WCOy+Odsk9yC2v/+eO041EQcTkM6gJDVPRsL6BYNTHE+OMmLKJ4qouoUMteBbesMziB2I3DMDGlrXRzUX9q9i2/7lvZdlDzygUGrAQ+Mpbpeurfc0WAmSgMGMO5IXbRZ1woEy0ucALjZYPGRQ5qr/JcO3YUmlsH+QiFzXJ78wp+xqcqZZlPhWeC9tr19f4sFGJSvCCcLjPkuTAAnxmjD/XcR6iSkMsa6sLkzvx/i743IbuVoXMEZjLhfWwUPwbnIcJ7srzQvvOPLdmWQngNxR0bPZHgH4V/WemmXITDviyc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBjJyV1p17Tfa2Iwz9Dgq9Ex/8U0Wmpr3ZP6m3fmLFw=;
 b=jfvRme7z9kQbRnis4hXQWfgEf7C57XgM4C/zh4QCnGxN6rtXFq7PJ5QzGl0IegfFwB8gipMAP8NqnYA3gRYCrcZ9bGhX61jBLw/AI3eVH6GndFoOuKlRs/TXbl8FVGL2YFCL4h8y2vGD8SvaWz58tx5zH36gcjGvWiKB38E1mQ0c0uKgJ5HnQtAr2tlUrqvjzISOKXW7HcHy21/nKnAsCYuoAcdUiZwvCNjLJPChoY4rLpWle/Kk4q5t++6dbI1i7z0xf73sszgODmx+goG2u7IUyS9nfUMAwuJ+g7nc4Z63S+u4ZXsGR6sa72IDlOhLwWx7AY7e3PMqnW622IMK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBjJyV1p17Tfa2Iwz9Dgq9Ex/8U0Wmpr3ZP6m3fmLFw=;
 b=XSjDRjT1V2xsY7g+UIbUaD3btVNzS8iNZJtyQqvkJSo4G8VNMW1UK0nMvfjF2PZGsO5hAQj22z8A1A6vOs5XAeYrkJ0iYxu2iy/Pu7AX9znxhw75pO3iPI7fSUWgh4zTFAHMQJOPcNvDzLdKRUEZSzJlRynl4mhQ/+iEbloBHYo=
Received: from DS7PR05CA0088.namprd05.prod.outlook.com (2603:10b6:8:56::14) by
 SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 09:19:46 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::3c) by DS7PR05CA0088.outlook.office365.com
 (2603:10b6:8:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 09:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.23 via Frontend Transport; Thu, 20 Apr 2023 09:19:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 04:19:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 02:19:45 -0700
Received: from fc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 04:19:44 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: extend the default timeout for kernel compute
 queues
Date: Thu, 20 Apr 2023 17:19:42 +0800
Message-ID: <20230420091942.5981-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8dc319-3023-4341-cac6-08db41806230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XIzbQTITft0JyN8NRR9FiF5QqCB4nirzF0p79NaDydATaAcOMXK3gwg6Xn5nYEj355iazutguJLdDzJz5YFibeDJsRCP6Ua4JQ9eoBu/llzTKHM52/DGzbPjs2I3CoX4dvYyI/ONkDKiNYYUbq5gApRFeRvVfMuJAAS8Zq/qhWcfCC+RsCjGAXiz/zX9jB9XhXYiTLXIhdXKR0DoAuHMcmO/Pg2Zvm4LhZsGL6AzH0ISV0zIx/lxFN8hNdtUTqemPiyzyu1urFE+JA61t3pfT7U3U76HYWSBPZMEKKU6ho8kBjh06ka49oRLZd7RuprXaBHD0o+kXCGER7nfDEcvAlGTbkwq3Rrk84JU+AD3KzcB0Nzv1vA0NITcL6wqhm0iaNRHqGyXpWHuBqjBEwaVubPRcZ5NQzpGMu1zfl7LWub9FpapOXWV5brp4IQvUfQ3pSHB/XAKpI5Ao9fpkiaU8eeIoXlZvIOgHN3Ep3DoUH2wio/EVswZa/f+X0rsYpJ+QD3bYAtkE7WK4WY/1GkD24mrZYc+/rAxtJ4K3CWQe7BQGNbxWpsHNyD4ax1xtpeRn+KSqdxJCW6gnvbsdUCYstiY+7Y9pVeZcKsO6Oplaki4DaCg5Qhq3yvQXYvDprgmkzAsokcwipdxyB16PCMTN5OrvKfvzmEk2MUoK7uEHIMFEmA2BuZRA8ml19Yh4e5czlu+bMEuEoXUFSVzSm1LoL+LoqfjartEeuHiaquYuQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(8936002)(8676002)(356005)(86362001)(81166007)(5660300002)(36756003)(82310400005)(41300700001)(40480700001)(7696005)(1076003)(26005)(54906003)(82740400003)(478600001)(2616005)(36860700001)(83380400001)(47076005)(426003)(336012)(186003)(316002)(70586007)(70206006)(6916009)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 09:19:46.1260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8dc319-3023-4341-cac6-08db41806230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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
Cc: Feifei.Xu@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Extend to 120s. The default timeout value should also extend if compute
shader execution time extended. Otherwise some stress test will trigger
compute ring timeout in software.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e536886f6d42..1f98b4b0a549 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3475,7 +3475,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 
 	/*
 	 * By default timeout for non compute jobs is 10000
-	 * and 60000 for compute jobs.
+	 * and 120000 for compute jobs.
 	 * In SR-IOV or passthrough mode, timeout for compute
 	 * jobs are 60000 by default.
 	 */
@@ -3485,7 +3485,7 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 		adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
 					msecs_to_jiffies(60000) : msecs_to_jiffies(10000);
 	else
-		adev->compute_timeout =  msecs_to_jiffies(60000);
+		adev->compute_timeout =  msecs_to_jiffies(120000);
 
 	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
-- 
2.34.1

