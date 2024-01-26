Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BA0C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 20:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966CD10FE76;
	Fri, 26 Jan 2024 20:40:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA3610FE76
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 20:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbuVR16LC/+uXjDpAsOGW0h6ajU0Zknl2vtq3DIT0tspkaLg4qFazS8t1nPldvJobTJ2CezlcXTDoj7dXFhNr2FqiFV0T+ShyNWQTjPaOPMrJS0s7C3+6Uc0rdMQb3jlrsIP/f2GoJd8mW3/4xU8FKyfnxzNYQWRom4rcyPLsrYDKmol4Nj5UiGgMO6yXMlNFsIfTSZ0T4CxMfcHF5nWNWMvwE7qUfkyVYiY7aASocO/R06LC+R/lKL23i8kIBxZTijWPwGctA2EGQ17uGVyX8JVar7e/vPF3fHW5Yc4z1xZInHQ2gF//qL1mQ62qfICNAdo4yYDfmxBGsNgRaKjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxhSyC9ipblEThIoAeLmZ3xKv3ST8UWChUz6TrfYyZw=;
 b=h2OGfOKvWntmleKzCgMO5QfA+xn2Mvd+yW5PWcNqXqEoWTbUbId/J2AD1Ybgv5b6hUlVeALBqHThAB5bIcWU75G38pbvHq0FNZmpwvkCOk43YxClnYuXceSUg5rbFkXFrdLGWhH7HejV8sh4TRZ/InyYhlgAvEDiqlK+bGA/KI4ZH8XBLr/yeN4AC+Ux1pQzoAMCR+w+wWOhIGVl99uJ4N6d4YSOd7pDceYXHlV2uLMluG4mE1SulcqkbH17wE47VKkcZF452mSMpAVaeXW+Tl71GWdH00U8e06sj2s+JN96OmzszIXl7oQ3NftfdpuLezKIfIOty7WN6nqvq1kNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxhSyC9ipblEThIoAeLmZ3xKv3ST8UWChUz6TrfYyZw=;
 b=VxOqwqlXAiLyu4oY7X9xO1mpXhAO6ggK/HhJ9HagJTDqabMQ6RsZxfKT78yqTd06Czf8AEjZpaR3AElzo97tge1OQjFUDvM38VzGmryWfoLWja48l1I9ln8lUAXGsbBLoj/6xBILHlK25+3AUe7pYwahsTr6wn1AI2JqLGJrpAk=
Received: from CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::31)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 20:40:41 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::83) by CH3P221CA0030.outlook.office365.com
 (2603:10b6:610:1e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Fri, 26 Jan 2024 20:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 20:40:40 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 14:40:39 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Use correct drm device for cgroup permission check
Date: Fri, 26 Jan 2024 15:39:43 -0500
Message-ID: <20240126203943.439296-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7d3082-b775-4452-ae46-08dc1eaf0f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4UlsuifL3e+6r1IPYAdieKuqNgcZ3PqTfPZMGIa+9RLpFmJjgB8ZGT2RHqnp2skYfoWZV5IhSJd6OYht4E5rhD1VNWbiuwxmiKltcuJDTQMD9n2lfxOuL+5l0j2ViD3iyzd8eX1CzZ1q3KzZGzme0FKZ7wDPdard+vStT+GcUa52xFPY0jfQ8FHx4gl0xvMWJRq8s+wElrf5Sp0i8oSqtNI2M3EzCmg+Sl/SXPE/01IoyiLymOGhxzIuSL7jlgaasn6Y6v5SEW6YLvwgK6YQ+Kl04JdccKJsrKsbw0oq8oOk5vhXkLt68TwRMCKUz9LBKA6PPLGoW4X5XvtWmpW6meAdolH6UL41PkkLw6Vm7fV+eOfI3XeSIH9Xu6tkHQUA6BM2ePJK+lJNucdTv7hyVKTF9TJ6Z150v2SyZELvHwa155UtkaY1nHoVhVNxfzYs8JtwUnS+qc4kJXkdiNyI6IqiviEWOeC7eQMhuh3tqbnc7qNY8kizmzHEigIdthaH4nd28kuHkAMz/F0ALS9lQe2rxngeNWfP18Abb5v3X1pFre+0Azf9N/ApeBz2vNydUskldygVLQNQSQL0fEehzfQZdyFMAzXPq6NJF5zmWI5NfxfS+mAHEs6d9uWTPPxURnwMN4vfQrqjfv9AKHcmCy/yieAHRf2IOc89WWUhEQzzG0n08cPYqscge7Oqa9e2GnHC6yfeSkP79LmFpbjIXwDT7dI9RCificKteVPWX9TJUyn1RTYPVaCdPDjyWvEtIGMa21sNd3Tr3E7S+n0Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(83380400001)(40480700001)(44832011)(40460700003)(16526019)(26005)(426003)(336012)(36860700001)(478600001)(81166007)(5660300002)(2616005)(8676002)(8936002)(1076003)(4326008)(47076005)(2906002)(86362001)(316002)(54906003)(6916009)(70206006)(70586007)(7696005)(6666004)(41300700001)(356005)(82740400003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 20:40:40.5272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7d3082-b775-4452-ae46-08dc1eaf0f5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFX 9.4.3, for a given KFD node, fetch the correct drm device from
XCP manager when checking for cgroup permissions.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 17fbedbf3651..677281c0793e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1488,10 +1488,15 @@ void kfd_dec_compute_active(struct kfd_node *dev);
 
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
-static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
+static inline int kfd_devcgroup_check_permission(struct kfd_node *node)
 {
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
-	struct drm_device *ddev = adev_to_drm(kfd->adev);
+	struct drm_device *ddev;
+
+	if (node->xcp)
+		ddev = node->xcp->ddev;
+	else
+		ddev = adev_to_drm(node->adev);
 
 	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
 					  ddev->render->index,
-- 
2.35.1

