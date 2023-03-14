Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798EBC6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 17:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0031D10E1AE;
	Tue, 14 Mar 2023 17:54:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D168B10E1AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 17:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhjlCYVVDo/DH/1kSoqLNXXcuYBLySczjtuCFnYf5qNqXSEmdNpGCC8ppBN5WN+4KAQbLdOyktbD5habcH8OGuk/BU1efE7wefsb/gRMGBUX/jhszYGUF4R27ChAik+uVDcAP/whWTWqAyirUq1tu7TOVcsTIH+35ICXbWhTAfRs7gLsnd8S47nCaG5Fo1/sK86B1igx6t/iM4qKAW62oJrAgntkd+ACcJAjx3QcBHqfqanBHeKV6mXQ6n2QIwqEdaz3G0pMRbivaGC8fdrdphxKSX+bFHtDjkh6WwpL6g3W3YC7GRVQC4RL1EMmyQTUEnq/SPYIrS8gWg3rpIr5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rUTYxHZ5fsYKqxUwmstB3VE7ZMFqkQSNVgyDbpeHFM=;
 b=DSvYA/FYVA7dVQe05KCVIBxYK9ZpKg0AAiA6AdcS2QSRhBmK3MbfIKxYtU8Kt0SIQebtLWP21Z0nU1nmmobpxD0rgZfC4OcNYzRtGXUTjp6WJrfQNQ8V+lgW3R7K12FB5ua8kdVap5T3Qfx0RNgaZIpAXHNRtCMGYj7KoK2It83xhU+luYzjcvZo1RrKQTNLbbb4cWtMrC9OBiIcJRZtohOHeI1n3TLaA+7YmKHNzqf7htYD2aGzNuPWIm2Ex1eESnPzF9nBx59YASKv3NcUH0tNVoCneOnVBmPOSFbDji/Ovv0xvRCqOhQLsno5mOI4N35ec7gU3fdcJM16pLX/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rUTYxHZ5fsYKqxUwmstB3VE7ZMFqkQSNVgyDbpeHFM=;
 b=NV0TSE6PNpKB6/Quxpdic1PyRHlE+F8tbf/IukETJHBjGz8+xum73ttz+IF1Oad6UJCSA3WCg3d3dAmVhjzWJRiOXF+hENZN0kboMO+CyjEKkaJkjkXoW0deO+omYNmb9nfhKRp/VM2NmhWGjH3bUWW+yQdjktCtA9HT8RsADfA=
Received: from BN8PR15CA0047.namprd15.prod.outlook.com (2603:10b6:408:80::24)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 17:54:21 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::7d) by BN8PR15CA0047.outlook.office365.com
 (2603:10b6:408:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 17:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.11 via Frontend Transport; Tue, 14 Mar 2023 17:54:21 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Mar
 2023 12:54:20 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Don't resume IOMMU after incomplete init
Date: Tue, 14 Mar 2023 13:53:59 -0400
Message-ID: <20230314175359.1747662-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3f827c-1c73-4ab7-d928-08db24b5240e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwdE6uiGeygpr7e7vV/sYY5aPLt5uODybGIepYEJMR/Rm8AL4n6e0yVOJIcYa67DahRRHJ2BEFBAIR7h9oFElEL5QyLfj2eZAIQfFlSARur/4qvll3kyrpv2niZPaT4BPpcrEn7RA8rdnyv4gixCDadUXztfE41pu638b+76utTQvWdNBXCzrhUAvK1BHSqV/PL80eGLdStX6t6XIVU+/jcCoj6u44h9PHCMBgM+cc+Xjmpr9/LSLfgMmQ4pGeNdxsBiA4xbjzsB3bhFlMq6mMC0K22dzgKG7g08i1D3ErXk5MGUH1311IneSHTZwLZR4Hzju3SrsJiI+e61hoMBf3mFmkuZQr9XDOG2vv+/g7YhxXtaxowLDF3nkGyfIUuALJjkuAsR9XEVX0MjpEZk72u9zVMQFalG/fxP6nYLWBzgfpCo0LvntIGZ9wu9jTx8LvowEImZniP4CGlVTQoZ4MfowrJqFk5Tu8gNpGO8QcyVktNJT8dcXS8z4XexL4A9Yqbkh72GBm3iMwcoo+DonXENPf4iswVk18U3QNuZg79A7UfhiysBN6uePxr3X6K9bJ7MlUUPlDaXioLlfAqSsepZbal9XS65L7ODlztlZQIPOlsYo1Vp6BP9GCRxlYzHQJ9vrS4wbL4X07QLrq9kC/BIke9MD5iVgIuSrtj7KMScA2baT6fDRGU8HpDDtZtBksG7fUlVDZ6Et9B/rJ3VU2c++Gie5br5rXOpm9MfxTQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(478600001)(83380400001)(426003)(47076005)(70586007)(82740400003)(82310400005)(2906002)(81166007)(86362001)(8936002)(5660300002)(356005)(7696005)(36756003)(36860700001)(8676002)(4326008)(54906003)(316002)(41300700001)(40480700001)(2616005)(26005)(6666004)(186003)(1076003)(336012)(16526019)(6916009)(70206006)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 17:54:21.5221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3f827c-1c73-4ab7-d928-08db24b5240e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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
Cc: Linux regression tracking <regressions@leemhuis.info>,
 Vasant Hegde <vasant.hegde@amd.com>, stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check kfd->init_complete in kgd2kfd_iommu_resume, consistent with other
kgd2kfd calls. This should fix IOMMU errors on resume from suspend when
KFD IOMMU initialization failed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217170
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2454
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Linux regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 521dfa88aad8..989c6aa2620b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -60,6 +60,7 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
 static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
+static int kfd_resume_iommu(struct kfd_dev *kfd);
 static int kfd_resume(struct kfd_dev *kfd);
 
 static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
@@ -625,7 +626,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	svm_migrate_init(kfd->adev);
 
-	if (kgd2kfd_resume_iommu(kfd))
+	if (kfd_resume_iommu(kfd))
 		goto device_iommu_error;
 
 	if (kfd_resume(kfd))
@@ -773,6 +774,14 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 }
 
 int kgd2kfd_resume_iommu(struct kfd_dev *kfd)
+{
+	if (!kfd->init_complete)
+		return 0;
+
+	return kfd_resume_iommu(kfd);
+}
+
+static int kfd_resume_iommu(struct kfd_dev *kfd)
 {
 	int err = 0;
 
-- 
2.34.1

