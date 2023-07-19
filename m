Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA36C0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70AA10E113;
	Wed, 19 Jul 2023 18:04:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C07B10E113
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWYAx58PBopmEjcZW7y8Y3q/Q0GWTXx54Gl3pQlPVySID6sfaewSOOXTM5OESAfzPchxguSymC3OtIrJX0g1Fc2Cd1nFQATYphgnGq2zcbgbNdUqzMhL+RXhMsSrDXd5Ig+pbELAjCOqa6M71zk9khvIpye+23xGBZjVbXNderYHEZGZF69aSRhRDbfiNUzMM3g3eHs5R/5AIpPMvXoJaMIFzjahouCnvEtdbDqBDytziYtv1flx2WjZXtCFeo40BBR97Ih/ZDFUMKu5kQCZl448Uv5mXx+yFpGFdKpD777SBYLN8SFnYWzz0QOcy5n9BD0bNJIo0CN0DLCys//dPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve75Du39/6NmZ2nMTsbO1yKn9idi2P+3peKn12ovvAk=;
 b=B3bB5rwD4GNsb1Rameh3vQB2RZ4mqzUSi3koRc4M32QHKBpAuD1q1S4OsJjHKdMYjoMVkp3Nti2qldS3CzkeJm5P7nHSmOSWdvt6dlEEN+0e1hmws1CyhUBoff5v4Dc57Rq8OBwX1/47wehCN7JDYcrkFWex1WO7QDVZUvO6zXqsuIRHRrgPrycIVk3AsOS89/hCXcO8XOOJQiqMY5QwfQXqMVD+5fCRobDzrWUIted8XAD/gpp2cEGltlbm+L/Pn1N9ev/bfXOo9xnT0qZV10Uq3cKOO4fYdDl1Qfm7oRss6WGzP+lrw7fy1Z2QE38VQ3qFmoVYKj2pBIb0iBg5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve75Du39/6NmZ2nMTsbO1yKn9idi2P+3peKn12ovvAk=;
 b=I5gq8H+4kWlhRHkqehDoHOTlr+43TLhNdPBT9KSXplvAmZcmtGV5igOXXt4RxE8K3rphHpsOquQoqKFfDMKzCxzXjkS9xuRi2lVMWuO+72ktNXQaERitBb5LeTZDQEKtAG2R9ieKR00LGbUEol1pkZkMPhLsVcpiRsxKHQzLwYg=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 18:04:08 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::40) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:04:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:04:08 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:04:07 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: avoid svm dump when dynamic debug disabled
Date: Wed, 19 Jul 2023 13:03:54 -0500
Message-ID: <20230719180354.23516-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f8e007-985d-439a-da7f-08db88828c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QhjgvP7452AlD7KCN9gK0nBToCDYWHiIQCHMGxNEB3Ks7sp4c/WwNxwyHJiZK6pg+ZYvng6r6zNgboVs1KB3+ylrtYXu3igTVrRJYV83NwMo9eYD6SuU/Lbx+75djK5OGsa2rtAJMWvXhVjMnkvCr18o3WnOdolh+b5JnbYqnpBTO1bqPJ5A0XnTZFtqveIcAeroJbUOxDI8GJ7Ax7CAtKdOlb/beZxHZxhR80P7uf02a4TTb72aE6HC8bVDtPYgVls3rdHzWu9lRRZQJcPS1ZcoXNu9pSzYfNWAnFRHXByUrcp21XAeNfyQ+s3B684F75+b6wPPZIhP79y9xCE+4A1l5fXye9yd2ZcIehB/phr8lUbnSzYV9O5PzvFsX1fGE3/zvaCLXhKSg9UArDMM+pcKL5Biu+dLbFTlOx30RcczgLl9OEoGIdtmavd4Q7wMechpu5AGH8cZs078dSb7+xw+TN1jay/zD/MkeNIw+iw5Cn62+/xr+a2lV8N49vySjwrog2iqYvpKJZDVYSzGtay/Si+9cnGNsvNu2J83+6+5QACfT14I7N+yIYlrZjpIVkOiRpT567tapG+cghNSrLvzV/jvYHoE42GEyzLvqpczlTadSmog8SzdAU2EOvo+iS8P+wodeFCCqhjWTPSzR6pAwc7T8+BYY2J0EM4nqtnzkGVNjX9cNaJHqiBJPNSIt9vEkoHNTBALmRroYt/Y27Ix25J/288VswuCxP0UXavPC0/P66/GX1UIhKD7X8dNFWxmBuZZ9W0pe5JJJ0h8/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(4326008)(7696005)(54906003)(6666004)(478600001)(110136005)(82740400003)(36860700001)(83380400001)(426003)(47076005)(2616005)(40460700003)(86362001)(40480700001)(356005)(2906002)(70586007)(44832011)(186003)(1076003)(16526019)(26005)(316002)(70206006)(336012)(81166007)(5660300002)(8676002)(41300700001)(6636002)(8936002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:04:08.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f8e007-985d-439a-da7f-08db88828c4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com,
 Felix Kuehling <felix.kuehling@amd.com>, jakub.kurzak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set dynamic_svm_range_dump macro to avoid iterating over SVM lists
from svm_range_debug_dump when dynamic debug is disabled. Otherwise,
it could drop performance, specially with big number of SVM ranges.
Make sure both svm_range_set_attr and svm_range_debug_dump functions
are dynamically enabled to print svm_range_debug_dump debug traces.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Tested-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 479c4f66afa7..0687f27f506c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3563,7 +3563,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 			break;
 	}
 
-	svm_range_debug_dump(svms);
+	dynamic_svm_range_dump(svms);
 
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 21b14510882b..ed4cd501fafe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -39,6 +39,9 @@
 #define SVM_ADEV_PGMAP_OWNER(adev)\
 			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
 
+#define dynamic_svm_range_dump(svms) \
+	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
+
 struct svm_range_bo {
 	struct amdgpu_bo		*bo;
 	struct kref			kref;
-- 
2.32.0

