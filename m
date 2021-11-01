Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3638DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 12:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E141160FE8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 12:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E141160FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E799C89D40;
	Mon,  1 Nov 2021 12:55:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ADDD89D40
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 12:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qi4tx90Hvzxvu+8xy3Qgj9cQ8WiuWY86SOxOjnTO6+TVcT+XIvDj0DzZmIuykTK8lWmJ4UVlYS6hfLaVFCUYQuu84q+kNu4M4XqxEZjdvLVy3LPsH81JkcNnTMuiysoF7+6IrQAGwXYJ3d3dQD1vGMT2mP9t0vqjlJ/EvfxhdUepPjzGUzg3JefEabqqcsIte9udlswxF1xmud4tSKWPvUIbjVDHX9uwuUeCAxCIxK7om4dFijhPGB4FzaR/lRC4GtihPWIRWMdXSyFlghgmWFqkEpkUzAVfxmxJ6RGH77/JfLvU9YzwysgV+nq16huUzPDM99a7+4+rjt2oWGsPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4N/qrzzQB8/gITpWN8i5EkNHjW1a9cvGo1tU7HBkXw=;
 b=UX91ey1Iw9435VFcEszLLltjb3xXfE0PhAqdKv3zOJ1trgzIKtLDgxbBR9ACBHWA9owo4qF7OsSkxHj52jO8T0z+gpEvCwaE1G4q5ezIUEovl47t9MRVsh4TlBlqSmaohQo4OYgfNgLGbZjHxyd7wzv2mb9s51Lg+uAaRnC5JCGIBnooi6C9/wBwJnXQZK26JzDWkBQgvBRlaqyKDKIdaLits4MlpnoxvQ6UBv6nNqmBiVKXTW4d67OJ1rSVNCNfWS64XG6N/HNk1x8Jm3YOezcHAYt8EyzACL5skkHpd84xYfeoiSDMthVJg3EXlXYxUmn+oW8LxJyRLYv+jqSjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4N/qrzzQB8/gITpWN8i5EkNHjW1a9cvGo1tU7HBkXw=;
 b=QfV6RuGTmRJ56yBFXLHv/pPsgouzUvDaNKSq7sxOUNUAnJyuKMb7xvFmfCW65NxqDGKL4fC7xlehNCIS14nOELNct9D1pOyITfI+y9jHJyQzYrFzi65FYSfcyscjA7+7XFwtdgB+IPYD+mKYn9Rsy2GB5NkiDDgcyvO2cNwW+x4=
Received: from CO2PR05CA0087.namprd05.prod.outlook.com (2603:10b6:104:1::13)
 by DM6PR12MB2633.namprd12.prod.outlook.com (2603:10b6:5:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Mon, 1 Nov
 2021 12:55:36 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::5f) by CO2PR05CA0087.outlook.office365.com
 (2603:10b6:104:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend
 Transport; Mon, 1 Nov 2021 12:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Mon, 1 Nov 2021 12:55:35 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 1 Nov
 2021 07:55:33 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Fix SVM_ATTR_PREFERRED_LOC
Date: Mon, 1 Nov 2021 08:55:11 -0400
Message-ID: <20211101125513.999187-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b183b8a4-2be1-4be4-0599-08d99d36e581
X-MS-TrafficTypeDiagnostic: DM6PR12MB2633:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2633732E470E4B02C3241FBC928A9@DM6PR12MB2633.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51EOQVdKJBbdqi1v7u4uZRA+W9WurRwYqA5tTlpR+XvEKOIgWanRehpBoF7cjhQ7OiKXbez3nd/gcU+XFFcwkxAAvvKhKlTiNGwT1i6BbBuQ32RmGsa2Q94eqB52ckn5tWpd9znxWfvafpQ/P77h3xUi21IDrk0g4D1ohJ+XnZsdnydb2fx0pubDR8jwZ2souESRVw0ykOmM3JP6WzTdBg3fDHzYOoMw3d0dEGBTz+5/P0zaUkTaIntwQqoAoOumxxhACUMsL4uKXRTv2X/MGCZmdZVTmvwUkoM7Uq5T+T9Tf2KJ00X47GiCjIaDX9nNTIosOB8casZl3DUEnV+n3G++uHPMUK0bkYSKbU1/GG7ZIfsbUMaPRe1C019e2ohe9rnOxamMvF7UIvnzrI7q7zxtKUGBwra56tUFBwmI/JiuuV/MOwZh/kWVSb8l3G+OPLRCdPL5/evynGy8rVeqUC4VrgOy/cTwM7M0Sqj7Ou9hcwwVBpsGV0dhkSmk0DtWRwx3AOe2MUfUDqa13H597JRF3tyxdAhUuJL2kyuO2VHqyjxA/CdhutM/XmYYqvnnbVb/UmMKttbSVpvQdkibo1vMfOfjsEo3WLVRR+juZyt+1XZlVGyvrHhvsGH5WT47neWm7De0K6xa/hOWUNCkQsqCRvc+EOeFgYwrLkgKggpl4F6ej5uS4ccbCUaWesO1OO1W1mQPbfBpo5b67aeJAvRzeN9gr2v3gDReMKHMVVs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(83380400001)(8676002)(1076003)(16526019)(186003)(86362001)(508600001)(36756003)(4326008)(82310400003)(70586007)(356005)(81166007)(70206006)(5660300002)(316002)(7696005)(336012)(426003)(36860700001)(2906002)(8936002)(26005)(6666004)(6916009)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 12:55:35.2229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b183b8a4-2be1-4be4-0599-08d99d36e581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2633
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The preferred location should be used as the migration destination
whenever it is accessible by the faulting GPU. System memory is always
accessible. Peer memory is accessible if it's in the same XGMI hive.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9a46ba190ea7..8d37ee755b34 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2250,7 +2250,7 @@ svm_range_from_addr(struct svm_range_list *svms, unsigned long addr,
  * migration if actual loc is not best location, then update GPU page table
  * mapping to the best location.
  *
- * If vm fault gpu is range preferred loc, the best_loc is preferred loc.
+ * If the preferred loc is accessible by faulting GPU, use preferred loc.
  * If vm fault gpu idx is on range ACCESSIBLE bitmap, best_loc is vm fault gpu
  * If vm fault gpu idx is on range ACCESSIBLE_IN_PLACE bitmap, then
  *    if range actual loc is cpu, best_loc is cpu
@@ -2267,7 +2267,7 @@ svm_range_best_restore_location(struct svm_range *prange,
 				struct amdgpu_device *adev,
 				int32_t *gpuidx)
 {
-	struct amdgpu_device *bo_adev;
+	struct amdgpu_device *bo_adev, *preferred_adev;
 	struct kfd_process *p;
 	uint32_t gpuid;
 	int r;
@@ -2280,8 +2280,16 @@ svm_range_best_restore_location(struct svm_range *prange,
 		return -1;
 	}
 
-	if (prange->preferred_loc == gpuid)
+	if (prange->preferred_loc == gpuid ||
+	    prange->preferred_loc == KFD_IOCTL_SVM_LOCATION_SYSMEM) {
 		return prange->preferred_loc;
+	} else if (prange->preferred_loc != KFD_IOCTL_SVM_LOCATION_UNDEFINED) {
+		preferred_adev = svm_range_get_adev_by_id(prange,
+							prange->preferred_loc);
+		if (amdgpu_xgmi_same_hive(adev, preferred_adev))
+			return prange->preferred_loc;
+		/* fall through */
+	}
 
 	if (test_bit(*gpuidx, prange->bitmap_access))
 		return gpuid;
-- 
2.32.0

