Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE55C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 06:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2D06E1BA;
	Mon, 29 Nov 2021 06:26:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2186E1BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 06:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccl0hlJ91KC4vuez1FGOnywpsv7fDyzpuNRE/AAcuJVmCs+27Y0ONLID6RM2TodBbAKE3qk1glzqwmbbDNFV3EV2KI5Wuxc4W+UHeG1tSpqakn0wP1CAAjIdxS8wa4qFsCD4kHkJtpZr4v4m5cV3yGK5zI6KYxMJdaDsZVBxu8tjmpjTj+1qe0NR1rD60OLXx4yUQuzUnrmILPMMNJpx59lvlvRbml9RQqt/hlaKtlpa5fovNx/JFS5nBLT1EhPDQwXGAzJ9XsAHzXjKTMb1fio8np3CN4M6y0iuOuK3i49+OI4fP0bK7AkN+EyeMgIgqwF1pJkuft/bCwbL4icy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AFdGeXvX2XQm34GM6QTQEyPS09cV7EyAB/jC2yZDb0=;
 b=mhk6G/pdo1/ouUadBgpCM8kWPJ5lqG8M5O2P3xoxi96I79rPGXfzmyi9ekVtRW3yC/kQuDAgcnCGVnckqogtql8KgYdDxyv1jw4Rvtembq1tHxxT50hxYpl7qlJbvY+jLsn7j6gsHJe3gg19cCSKT4iAF4eYofAPp/iA4WXznvngJ6EE5WzyDC/zGuDSIPnPo9brKkdznzXa9b4frlhod/M+BLjW/a6yZNsYibZD/hDNZ8QicvbWv14SDkcATMbNqH2QQNdkflvR11NCg1mFkCsF8uXh4UMZsjmgPeOB+rcgQZeYJU5H3VTwRSN/u65XMaTAsHr7RVagzTTx48fS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AFdGeXvX2XQm34GM6QTQEyPS09cV7EyAB/jC2yZDb0=;
 b=VYaqrtfdK95OIkblopjPWBupxS1v3RmVF0K6UIPqSzO0zr52/L4XTP6Ct8Wn+iSQXL7VjOEeFuxXDoC8ijp3tBR/tBk0DFM7sa1DJ5DLncPgANVIUxaRX/f6rnUDnKl7yv6NQDuO+MPdJvb15L8p5kBQdN7F9Yl+R/X3b+vo4i4=
Received: from DS7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:8:54::27) by
 MWHPR12MB1855.namprd12.prod.outlook.com (2603:10b6:300:10e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 06:26:38 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::4d) by DS7PR06CA0047.outlook.office365.com
 (2603:10b6:8:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Mon, 29 Nov 2021 06:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 06:26:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 00:26:37 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 00:26:37 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 29 Nov 2021 00:26:36 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: adjust ip block add sequence on
 aldebaran
Date: Mon, 29 Nov 2021 14:26:34 +0800
Message-ID: <20211129062634.8559-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac369c2-e826-49aa-5bde-08d9b301333d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1855:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18550D9FD8DBB3D43E5CB7949A669@MWHPR12MB1855.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:73;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzBXdORJN+nMA+HZzdZOM6O9HZVmd2HykkcXRZvSiWiJUsq7S300uNAe00UGjpBq7ORxwM2etLw554C/MySS0luVbFUr5/Ep/yPwNvfyp+RvsjJpe/m0wZV3sST0w2Dkf8iiBsK9CUsybi5fbL3rhPr8SyogYOqAleumytuahfIHCFDOQBIbUqeaMhIX+rNrklvtOWx+K6puf7nqqUtnMZHKah8gyyYB5NF9jUiUzaXagXy1LVfTg0aU05gGL3/zan5/y4b8kbZFdrbAgzu4ES0qVkgMOuDWKg9HEebWdS2QS9KamMwthDppGEId25QvXpIujPnWGpaPT80z+k8uThR/U+uyMtM1HlHbGlMys8gWgKStixy0SwyYgX65ikcMqIgWnt1CY7AV739E6Ldn/qknOkfnLaeAawojDAyb77Zfuw2qe0QGGqcayoDb+dJpI2uowewELlz7B4gvSNpfXEwbkOVJop85PzfqYR9qiZsuoqT+x6SR/Do01udMT7DdMOnNt2QkeR3AgfzT4mke8p0SFX+TreAbeoI/lPJLOtf4EWd9afh0Wyg814AMHu7Ymc01W/dvue5wMXbXvASb/f9J0qrOyi7I0WgI4574EO2VXsTCPB5AcBYqfwRp87FB3eriIgvFiWwRVKubJVwOCBY95AaymSZgWYRoG6YEu6SQpIi0dQGNegx569o67WXLSR0m8lzRYuGMn6P1RLMtlWaYsfgubBkZ73ZYvO48TL0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(81166007)(26005)(2616005)(6636002)(8936002)(47076005)(110136005)(2906002)(36860700001)(7696005)(316002)(36756003)(356005)(336012)(70586007)(82310400004)(186003)(83380400001)(8676002)(508600001)(86362001)(5660300002)(426003)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 06:26:38.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eac369c2-e826-49aa-5bde-08d9b301333d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1855
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reason:
{
    [  578.019986] amdgpu 0000:23:00.0: amdgpu: GPU reset begin!
    [  583.245566] amdgpu 0000:23:00.0: amdgpu: Failed to disable smu features.
    [  583.245621] amdgpu 0000:23:00.0: amdgpu: Fail to disable dpm features!
    [  583.245639] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62
    [  583.248504] [drm] free PSP TMR buffer
}
Adjust ip block suspend sequence on aldebaran, it can fix disable smu
feature failure.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..dc1d88a31f91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1309,7 +1309,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		}
 	}
 
-	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+	/* move add smu block after add smda block for aldebaran */
+	if (likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+			(adev->ip_versions[MP1_HWIP][0] != IP_VERSION(13, 0 ,2))) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
@@ -1327,8 +1329,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
-	    !amdgpu_sriov_vf(adev)) {
+	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
+	    !amdgpu_sriov_vf(adev)) ||
+		((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0 ,2)) &&
+		 likely(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP))) {
 		r = amdgpu_discovery_set_smu_ip_blocks(adev);
 		if (r)
 			return r;
-- 
2.17.1

