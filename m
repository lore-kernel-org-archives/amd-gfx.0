Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD4C4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 14:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DC620727
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hERVcKVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DC620727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451B86EDC6;
	Fri, 30 Oct 2020 14:57:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AC36EDC6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 14:57:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0KQK6MXO78MOXJ2ZTtVuFRxYHgVRyeWXjEKK2KTphE957VZEbRuA8/KQIo8Ovc19D50CpDAiVqAZn0B0oVlCSiiflTM3zro9eWxhjCdnRD05/6eWJ3+H5oLPVR3L70pC67DhpKib2Q1ukVF5hZf6CX3t1L/xrA2DYGigR0cDRjEIlf+U9BqiGsKHsAsHniC7pMQEeiPMoXa06/eZv+WuES4oDhiqUmXvw3RH6OOAJn4PjZVVe9QA8x4mVGNQYNqFRlLflFzyWldtgNw4+66JpCOCqFYqLHfgZxmjs5xyUyd0Ps2N/07zwxMK3EZWm5EFhlGQd7/0JmGVi4GWpzDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHtw5AQ27/MLHiJwjTXTYjfilP2Rc1/Mw4GRTxN+WWs=;
 b=Fg6cX1ZbyPkHXWgk/XOmL+Vwgw84AARD12vQW+6E3s7J7mqXTCofsBE5uN4/soHsfu2/I9cp5tbJLKl5ukjrVjgcy8f0ETO5Dow/CWlVBxvKCr2sA7+R6LB3wTbrelK/uOWBdxMNtLp0qigiUnDHt41tVHxYcP3WfckSiYCd4sTBXkxdhjftLofRwE53XO4lPV5EmjF0gvUpOM1IkIL/AqmH+erAc3/6MJniFeR1qymo30vHbKjTGt86dKKgT30s/pXHyRNrM2YdQauVeciPaHt1g/rVrOgLqHxnzoPk0hLOpwXUXKN9DgDDBYCL0DKd2SMuJqzLmF5nkBPOL3n37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHtw5AQ27/MLHiJwjTXTYjfilP2Rc1/Mw4GRTxN+WWs=;
 b=hERVcKVS2ZKeqPELTKdEqBp5yz1ku1qWGpO5DlDCd4NYjwfMIBr4BAwOiW0mq30Mngde4JiHZVpe1WIidvEJmaGshDgbRpEe05hc+x0l8o0r73xRJxKr4iHIMxrVj5S6xCtSB6YeFQgBNbD8QGe8BmD6tVdHgP7pZI+Rmm8Ne2A=
Received: from DM5PR06CA0040.namprd06.prod.outlook.com (2603:10b6:3:5d::26) by
 BN7PR12MB2801.namprd12.prod.outlook.com (2603:10b6:408:2d::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.28; Fri, 30 Oct 2020 14:57:41 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::62) by DM5PR06CA0040.outlook.office365.com
 (2603:10b6:3:5d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 30 Oct 2020 14:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3520.17 via Frontend Transport; Fri, 30 Oct 2020 14:57:40 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 30 Oct
 2020 09:57:40 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 30 Oct 2020 09:57:38 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: disable gfxoff if VCN is busy
Date: Fri, 30 Oct 2020 22:57:22 +0800
Message-ID: <20201030145722.132135-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5cd64d-0ed8-46bd-7cb1-08d87ce42654
X-MS-TrafficTypeDiagnostic: BN7PR12MB2801:
X-Microsoft-Antispam-PRVS: <BN7PR12MB280180EF562D4D861E3C90D7EA150@BN7PR12MB2801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhgaetNa5gt1zeJMvnewaRv3l89I+Eaba9DP1TwhNBfZVkzF64HEtdqEShXc2ccHJz4hcGdi3DAUNu9TKEhdWjRXuPNPB9MF7w58G68UvJT/D/REyVkXUH9lzNwrfcAEXVurQlMwlh93twtQnNXAOr7xK2HZ8fglBDnPsSuF5n9odOFhgzuJi5d98safOK8Bwf1JlvjROwyMKObkZWc11FQutPKME9/4k/rHFEngEcJcyXXCYpIGZjRcSV0PVGYpfeGSbuO3jO589Kr2yTTEtZTCL/ftAmE1b+VlZ3+CxG0N5vyvjyeHoC8SU4/Zjc+wxckCiaXu97NZIkMhELGsMa/Oqvq20c9QnSyPCrcevII7CY2fiD6CKu67qMyLNeX4HsTLxuO463S6Vf+QIydSCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(36756003)(2616005)(356005)(47076004)(82740400003)(478600001)(81166007)(336012)(6916009)(82310400003)(7696005)(316002)(83380400001)(86362001)(70586007)(70206006)(426003)(4326008)(8676002)(5660300002)(8936002)(6666004)(186003)(2906002)(26005)(1076003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 14:57:40.9394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5cd64d-0ed8-46bd-7cb1-08d87ce42654
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2801
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>, james.zhu@amd.com,
 leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Toggle on/off gfxoff during video playback to fix gpu hang.

v2: change sequence to be more compatible with original code.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I5b938c446884268c2cda0801121a53da980e603a
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 277a8435dd06..ef0878e848de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -358,6 +358,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	}
 
 	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
+		amdgpu_gfx_off_ctrl(adev, true);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 		       AMD_PG_STATE_GATE);
 	} else {
@@ -370,7 +371,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	atomic_inc(&adev->vcn.total_submission_cnt);
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	if (!cancel_delayed_work_sync(&adev->vcn.idle_work);)
+		amdgpu_gfx_off_ctrl(adev, false);
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
