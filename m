Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5463DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 11:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA86710E550;
	Fri, 10 Dec 2021 11:15:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCC610E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZBjaBsRoh/1bJiirRcaLs9nZFrGU3Vao+Tt9pCifcsRy31Ra7WbvthlS+lzsYMdlBBT2JmRwhKS31pvCElBJgV/fiUin3r3WMnmz3A3qo/XKzH3g+Ndw4UQBKsGEPJJniIdzSzh6ueEhhmvp0Uxc9R9fMlY3gv59TOjmdYn5n1SwnWbtRN2EI7yDwFsXt5UVn4Z7z3iqtA2xlMslK2F/4XqkISq+0o+pU6wnHNCuQanvq+Of6KOaIzE8ZPRL5+tr/Bh0m+oWM7frgCKkysOzRd2WIntKgnG6sv6d7ZRCiUJwGc6ot+BOt3uIYItTFVRldgIgDM9P4cHs3obrW8u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkXjDlYZE476PR3OALgeDsXx/yqCmPz2+YV7hfrVE+E=;
 b=dkdW9kxlAGOIfSFHnXNkHO9IhKLXqFbl7a+TD6y1ztvxDGn0/hDd8oRNUUM9Aa3IThnxm/i/FWqnfP3i9XxIiMLj0cSWVlRABuAUlKF1k1L36tO796rVl+cWh/sD6XtPYo2QTWQgvYNUjdM16Z91RtzCp8DSRq7+RP36dSiiBoAlm4JjiQ+TGBKPpDrGHx/oJZPlB9T7F0FDrw6D3h86JKFhB/O75ZZRHz0uEkvs/9e+mZXGrFEe3MjJ5id4VaFw/sHbGqGACvtuQIGWaHZnht79V8aWkpxyWC611zXc3Y78qRtW1ppTGNqi/fKB0b5SkdZWuqI7RQDBR+NhuoLA0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkXjDlYZE476PR3OALgeDsXx/yqCmPz2+YV7hfrVE+E=;
 b=eQmImwGA479VJKggTm8EfRhulyfkU4tov2LFdSnqODldChhOYzVGKtrXlTeNGXR26ZNE2hWduJWxnAf3VOHKN5Qph5zt9LSS4yd6lTMUw8v0OTH7jH7XAJUr3vx6GkQOvg0dEEYf7NOIIjspxEFYOIQJ7r8UKrvXjMOcpY6wcjI=
Received: from BN9PR03CA0102.namprd03.prod.outlook.com (2603:10b6:408:fd::17)
 by BY5PR12MB4933.namprd12.prod.outlook.com (2603:10b6:a03:1d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Fri, 10 Dec
 2021 11:15:18 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::93) by BN9PR03CA0102.outlook.office365.com
 (2603:10b6:408:fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Fri, 10 Dec 2021 11:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 11:15:17 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 05:15:15 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <thomas.chai@amd.com>, <Felix.Kuehling@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add gpu reset control for umc page retirement
Date: Fri, 10 Dec 2021 19:15:00 +0800
Message-ID: <20211210111502.17384-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb9fa566-9646-43d3-ca80-08d9bbce58f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4933:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4933F4E39E750A86A9FF7813B0719@BY5PR12MB4933.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9uEfcnBZPPdCFsExRkCulPypK8MddiYfkr3TCw12CaBm8M5DGg/WSbK7v7XV02euuzfWQSO3Vh2TESnS9RZaKEq4qQ0Vq8NrUe3eew0rcpPClt8ckBzdf4kErneXygxSi/ebKUeZA4Q+KH05HlGnUfAXL37vyUG/Xj4YIgc1O6JocXXBf4D5qDt8ueNudhaH9hJXIDwPyrDghcn09MUIru/sDWJnPfq8G7ka83TlKY5SHEB5LGDplKJngEqyDepfXBlLcagcmxEfwPt808Ihh+bvxJRWQ5m/f91JOf7kzprCgMtbEDU/s0Ye9UBZV1vWhYFid9rZ5WiOhlHiG+sTfBln3eDdrfKb2JZZSTW9I1TLfiSYT+vlEOB6XWg1Xn1qXfUPCZexC1zhRijmhM3y90A1c6WEqHkJTfpWORsEcMX+YqQs4CqDChTOJeZ6hA5PeISrC9qnwbBGdw7EyNVoDUZfwVkrpXUshla0N7WF5nExh0JdV5NwHQjwSf1hYGhs73bl9v7wc7ENb+YC7S3bZhmFpihA35Cw7Fzc49EUscPZyj6ir+PfulTophwHYpgZjTsflSsNbVN7h6LxfmHHfGzz6SIwcQY86gpCU29CQJHpIypem/wTG4E6x8l/byLlY9vgEQvhv1ailyHsIZckVWsR/w2o2dmu966cSfwXHYFxyLNdI5gZgHzYa3zVFHV9Ka6pfdnkHEkCBCqkfrj63NOEML0q4Y+kJi8G4KBDu6NqnCQx6fwAixwzVH8bwnYO09zbnFsPAVIqCD6mxNe7Y3gSJdilO7MZNmB1BYuDHc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(16526019)(426003)(2906002)(186003)(8676002)(83380400001)(110136005)(336012)(4326008)(1076003)(2616005)(81166007)(26005)(508600001)(316002)(70206006)(70586007)(356005)(36860700001)(40460700001)(36756003)(82310400004)(86362001)(7696005)(6666004)(8936002)(5660300002)(6636002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 11:15:17.8794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9fa566-9646-43d3-ca80-08d9bbce58f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4933
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a reset parameter for umc page retirement, let user decide whether
call gpu reset in umc page retirement.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  5 +++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 6e4bea012ea4..0c33f367a4e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -23,6 +23,13 @@
 
 #include "amdgpu_ras.h"
 
+static int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+		void *ras_error_status,
+		struct amdgpu_iv_entry *entry)
+{
+	return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry, true);
+}
+
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -88,9 +95,10 @@ void amdgpu_umc_ras_fini(struct amdgpu_device *adev)
 	}
 }
 
-int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
-		struct amdgpu_iv_entry *entry)
+		struct amdgpu_iv_entry *entry,
+		bool reset)
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -164,7 +172,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 				adev->smu.ppt_funcs->send_hbm_bad_pages_num(&adev->smu, con->eeprom_control.ras_num_recs);
 		}
 
-		amdgpu_ras_reset_gpu(adev);
+		if (reset)
+			amdgpu_ras_reset_gpu(adev);
 	}
 
 	kfree(err_data->err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 9e40bade0a68..8d18d5121f66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -78,9 +78,10 @@ struct amdgpu_umc {
 
 int amdgpu_umc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_umc_ras_fini(struct amdgpu_device *adev);
-int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
+int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 		void *ras_error_status,
-		struct amdgpu_iv_entry *entry);
+		struct amdgpu_iv_entry *entry,
+		bool reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
 		struct amdgpu_irq_src *source,
 		struct amdgpu_iv_entry *entry);
-- 
2.17.1

