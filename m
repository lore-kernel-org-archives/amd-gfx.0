Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B74C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F74861957
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 04:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F74861957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 711A46E49C;
	Tue, 30 Mar 2021 04:41:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564B06E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 04:41:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rnp6Kil0Ap/PqiLbXD+IgxO1XmU42CYlA0UqNopdrixi6QANhjW2zKJdiWtXxTUC770wjWxbvJdr9PEPD31WbZCC1pFsbU8qR93oeIUEXDfKht1ONVIzccjkaZZOK9HmRfbtMDjY56K5PtibQrigHiR4A5BnV00cZwZbWlW5VHshivBejvfVvjC2Jq/oP188O4UHSx5nPpCl8a8MWtIvIJyZjwDFUub8de8MOcgrlCoBBNeCGm4pYLHwQ0t7JsyqPmRSEV2OkuiK7s2PzPzwnveTpssDZ6jhW3QbKcwwc3N7Rlwe6XmB804B+zKxBUh4a9bKhOvKabCfmP9/1nx+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23QdIXHGQ8uQkOqriKc45BxIe1fj2IbayC9mRIwTV+k=;
 b=d05zJApwyjwE6xmx7PkzTQVE89qGf51AJg81ltkgqjo5YG0SbGpyhZ20JGFy1WJqDI0HqzpPY5ME1s+1Lbz+jLJchzaMn6yGNMUzTH9bDoRlLzZyVDPJ1U0JzG47MIO0o2xjwOe5Mco/n+qYqNszPRKi/aVEICcXQVeLstqIm58c6QUZaKiXjywEZ0VymjO/BztFvAIBn/+Pnvcmur6g5j131e9m/LJsZkMySD+0bK7bDHbk3KbMfhYRfQIZfjGTMX/bwIEr9uEvcvK9z4P3dgpGknYsEY4NOKdHFYENrW4QmX2NEJYAmUvVczP6Lk95USqsxWXVosb+iu9r7HidLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23QdIXHGQ8uQkOqriKc45BxIe1fj2IbayC9mRIwTV+k=;
 b=dMiMoUzYo5AyI/aWtD9jTtSAygHzn0YseSedcZO9/gN7Nvl5E+nG6xRvpB1FQpro7MrcYGHo4nSDK3VmEGpBTiVvBRcqGD/Wbu8ICLjzmfDLPH8e/hhIrzCy6X53s7G4LzBdwua7wdawlNK50QWRqiTxJHbPZrieqVz4XiC8HH8=
Received: from MWHPR18CA0065.namprd18.prod.outlook.com (2603:10b6:300:39::27)
 by BN6PR12MB1265.namprd12.prod.outlook.com (2603:10b6:404:1d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 04:41:52 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::c3) by MWHPR18CA0065.outlook.office365.com
 (2603:10b6:300:39::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32 via Frontend
 Transport; Tue, 30 Mar 2021 04:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 30 Mar 2021 04:41:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 29 Mar
 2021 23:41:50 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 23:41:49 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: Disable vcn decode ring for sriov navi12
Date: Tue, 30 Mar 2021 12:41:42 +0800
Message-ID: <20210330044147.57802-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9edd679e-f918-44fa-e307-08d8f3362334
X-MS-TrafficTypeDiagnostic: BN6PR12MB1265:
X-Microsoft-Antispam-PRVS: <BN6PR12MB126585D8B88FBEE5E40333118F7D9@BN6PR12MB1265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQDWf/uO+o+OrrWsJvJkd6EOM1+kPt3c1pEr6qMMCl1ov9qFK/5CmtlE0rabdtKHUfc0r4xfKqJp6MJbO2xjBF6lYg0nxsd+WbpfEauRe6R3F0Cgd4fgmqxMapQCGuhl2uMOL8lV+szll4+Qbt0DmzuorlLTkG/F/fpkqfY/AzlyGNw27SHumjiHD5WvE6k2TKZsrUzrJVkeNfPQj10Mj/kLWvDDSUeujfLpjyGf1eNScsnm/m2i75Mf1xKe4bBoyHhj6yi1Y/hnqb7MwP4kL5efCm7m9ftbTl945qYSz95s3oRKz12VL0zJrV3BMiVACRI7B3AOIWTj6ArnMwN59ICobQw5P7AWAdSc98YFxTdNJj8UMeipv0CPtuIjuiYhO8KbZ+s6/WbCbUNDryDOLqiO1FaY+OUnYEG60tphwQqqtEVgzfd/OQL5WBYm3l8ZBGUg6j84cxnPEw204G2xpFONnnNsIf3N6Wd+kKZFoK5xMaXNKSqPaZqudsX8YUdY4XNOgYzL3x9o6Q0Hr4rtXq+jwSPD9s0/5XdS/o3l5+NqLkRBDsE555yqXSLuNk9s052YuUh3ssVt1ZIhSaqwA4X82GKeG4rBJzq/h87nJhZWzmtGmyZTNe47we8KIgXDmiBRrZuadVM6U/yu5Jb92goZw+ntH6hJyyBnQRllJYMTvHl70ukFPO/HqZ4YH+v/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(36840700001)(46966006)(2616005)(5660300002)(86362001)(6916009)(4326008)(81166007)(2906002)(356005)(478600001)(36756003)(186003)(336012)(7696005)(82740400003)(36860700001)(26005)(8936002)(1076003)(82310400003)(426003)(47076005)(70586007)(316002)(70206006)(8676002)(83380400001)(6666004)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 04:41:51.5778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edd679e-f918-44fa-e307-08d8f3362334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1265
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
Cc: Emily Deng <Emily.Deng@amd.com>, "Frank . Min" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since vcn decoding ring is not required, so just disable it.

Signed-off-by: Frank.Min <Frank.Min@amd.com>
Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 29 ++++++++++++-------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8844f650b17f..5d5c41c9d5aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->uvd.harvest_config & (1 << i))
 				continue;
 
-			if (adev->vcn.inst[i].ring_dec.sched.ready)
+			if (adev->vcn.inst[i].ring_dec.sched.ready ||
+				(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev)))
 				++num_rings;
 		}
 		ib_start_alignment = 16;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 116b9643d5ba..e4b61f3a45fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -220,21 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
-	int i, r;
+	int i, r = -1;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 					     ring->doorbell_index, 0);
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		vcn_v2_0_start_sriov(adev);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		goto done;
-
-	//Disable vcn decode for sriov
-	if (amdgpu_sriov_vf(adev))
-		ring->sched.ready = false;
+		if (adev->asic_type == CHIP_NAVI12)
+			ring->sched.ready = false;
+	} else {
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			goto done;
+	}
 
 	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
 		ring = &adev->vcn.inst->ring_enc[i];
@@ -245,8 +244,11 @@ static int vcn_v2_0_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
-			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
+		DRM_INFO("VCN %s encode initialized successfully(under %s).\n",
+			(adev->asic_type == CHIP_NAVI12 &&
+				amdgpu_sriov_vf(adev))?"":"decode and",
+			(adev->pg_flags &
+				AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -1719,9 +1721,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 	unsigned i;
 	int r;
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 4);
 	if (r)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
