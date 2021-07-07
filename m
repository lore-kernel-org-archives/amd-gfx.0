Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A17C07E9C
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 18:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE4961CCA
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 18:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE4961CCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF7589DD5;
	Wed,  7 Jul 2021 18:34:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489A889DD5
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 18:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz6OvYpyLeu/jA5XJvdZ0Nm228LMBdBQ+jQBb+3tORWiL0drbXk3HlwaUuOBUbld5WXdXlOOujod213Kc+6M7dmnjWdfWS/O4vFzi/5Sx+BgKfUX/z+8uZJdWtUTjpdeAHdHYFSrkTLZgSVyhL0NZ3cklo3j65TWUHf2LXWbtPQJwg5WI41TQm3cq2SaLi9WxVwTDbySWzosT3sLhQrHueqfnHGRsmmkiKl6PfXasXItOe4m5mXzb598mFrm9wzAFDuL9OFK+THHrXm4bslFtEOvjSOV1LodOdcpcClBuTttEnK7JxzU3+Gsj85MQZs2y2iqnZroRUmAtLI+fIzO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw9cK8b0TkOgq8ITtDLVvI+qdP8LBWMfII8VoCzNqjs=;
 b=bDIptA9TUzA+GMQuP0F2juEZu6fb42OWbN+1wq6iBMLyjEYKTURcSFz8cdIwLD5YgcXNFmGgTw654D45/OZ0c+1d0yUeGz7/v/gdy1a8KnJEa7k5U2fjOzNy/Cpl4hPSDu4ZjUjTk4QUWYXZftT6PBN2REXAUD+pDT4+urpLjf9Wrt8CLPCAdjz4DIz6F97T9s70p2elgnITNISyJ9+9Ty1XclPaz2Pr7472uAqPQHIDFa5dkMBMa34+B0Ay6Pyq0nncqdhP0Ez9qWt1xTsUTh/6CV/44VbW/xr/3bE4mGvPjRbGqpJfvnUTlEbB3STQTpN8z1VBKwTE20n7vzXiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw9cK8b0TkOgq8ITtDLVvI+qdP8LBWMfII8VoCzNqjs=;
 b=YFnM0GNG7tR0VA3K4NuChZuTjy35FAZ+MfcdRc09u5EySClNqIC5+NQ2qV5/DhdAKjismGoUqPbHjSce9pM3bKoqX8q88uMVBVv6a9MIj64/8FUL+BvIozwif2g5fWeuVOPniv/kyyBuU0ryLLVTo5SwmeRjL3ImAdwgKHz98u0=
Received: from DM3PR12CA0109.namprd12.prod.outlook.com (2603:10b6:0:55::29) by
 BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.33; Wed, 7 Jul 2021 18:34:24 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::45) by DM3PR12CA0109.outlook.office365.com
 (2603:10b6:0:55::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 18:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 18:34:23 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 13:34:22 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: handle fault counters on invalid address
Date: Wed, 7 Jul 2021 14:34:09 -0400
Message-ID: <20210707183409.23316-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9035e1b-f210-445b-d601-08d94175d7b6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2632:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2632FAF736018EFE202A8D3BE61A9@BYAPR12MB2632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/NDQShUpMurEKU0hGdXtnVfTIzunHfow475XWsatKF1FHL3uIQc3YbK/KIO003zx0rVk0S489oLuvHG/tRgW7ApWwEFEY+1ftDoCIVMD0sBnSOtwBw0U2JsRglHcdkC/wlwhql+snlbOjYfyV/UlBPaR1/TdAUyi5nlGHZPJTL57AweAkDDwx64xhV+HrLGMcZQD4FN3IN+uhc2eMJg23zGuKJyH8Ip8pH0Vbeqy+kWxm3lssdTtGCSk+Cu0E7mRGHtiU5bVipmUSzEf8+KOQ5PSQqoFmI1mVk6yy4wEc6LKxsMj1etGlVr2jcbwPCa1kDIuwFGMi8+kyMAeDpIcTgoe2qRmIFNnEorSKDbbvuujem3lt+Ny3ljK9tlph4l7qhvzjhuPyy2rCcltjc3aTgG1jR6yokLBUFlznq07DPlCKm8O8iQ37AQgsOnZO6975CEi91QJaJ+xlA+CSzvz5qGudeJx0kERc6VrknE+nxgAKEfqRH/tzMoS/ADwvHsxiyJSDeT+cCkscFWucSJguLEoDvbXQ0miN/UvSkiJJOYhrCmBWl4Y2FTJgsLxWPysVzi5m5owrb6CK8sGAwjt/aZfYGx+mxYH+xi6o6qAmBM3fV/mA0UtYgDv0caFd+/tjxfFqX2dpWLsBXJfsgyiibHa4/0dSEabksMRAmSsV/W9S9qMFqc/PWj5ScjgIsNFsaIZdgvMKm0o+AOJB44GCtmB3/rtGlsAbnrmdYoAn0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36840700001)(46966006)(356005)(70206006)(2616005)(316002)(7696005)(36860700001)(82740400003)(16526019)(426003)(36756003)(6666004)(86362001)(2906002)(70586007)(83380400001)(1076003)(6916009)(81166007)(4326008)(82310400003)(8936002)(26005)(8676002)(336012)(47076005)(5660300002)(186003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 18:34:23.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9035e1b-f210-445b-d601-08d94175d7b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

prange is NULL if vm fault retry on invalid address, for this case, can
not use prange to get pdd, use adev to get gpuidx and then get pdd
instead, then increase pdd vm fault counter.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 31f3f24cef6a..e7e99c5070b9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2375,21 +2375,27 @@ static bool svm_range_skip_recover(struct svm_range *prange)
 
 static void
 svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
-		      struct svm_range *prange, int32_t gpuidx)
+		      int32_t gpuidx)
 {
 	struct kfd_process_device *pdd;
 
-	if (gpuidx == MAX_GPU_INSTANCE)
-		/* fault is on different page of same range
-		 * or fault is skipped to recover later
-		 */
-		pdd = svm_range_get_pdd_by_adev(prange, adev);
-	else
-		/* fault recovered
-		 * or fault cannot recover because GPU no access on the range
-		 */
-		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
+	/* fault is on different page of same range
+	 * or fault is skipped to recover later
+	 * or fault is on invalid virtual address
+	 */
+	if (gpuidx == MAX_GPU_INSTANCE) {
+		uint32_t gpuid;
+		int r;
 
+		r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpuidx);
+		if (r < 0)
+			return;
+	}
+
+	/* fault is recovered
+	 * or fault cannot recover because GPU no access on the range
+	 */
+	pdd = kfd_process_device_from_gpuidx(p, gpuidx);
 	if (pdd)
 		WRITE_ONCE(pdd->faults, pdd->faults + 1);
 }
@@ -2525,7 +2531,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&svms->lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(adev, p, prange, gpuidx);
+	svm_range_count_fault(adev, p, gpuidx);
 
 	mmput(mm);
 out:
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
