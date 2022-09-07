Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA20C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 15:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA7510E7B2;
	Wed,  7 Sep 2022 15:38:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF5F10E7B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 15:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnEtnzEFXPXM6nkzcOW0kGdgWd9aHhZJa9FkNU0DONEKB7sqWayE8Mn1dlXRwqTKnZxuMwFdW0g1i4ybuoaHSqhSsMuRi+yVTEMiknUz7vXw+i1oAzluvqNXAqAYw/uWCTnMq2qf5g62hXHbmUz/1/1u+QLMZeU+ILdUA4JZtz22SLFslmVt52bsL2Vop+wCZ3VQuP0gmxgSDyrCoAghDHRd0om7UjpZbXteM/Dvio4/HD93j2GjgAl54sGNOlMLTkiGckeG+SM8chaeRaV2tre3dGJX/31arsyaz2rPxPVsnmrGVhIOxEh/YxSD0BihvF2ysQ60dhfT/TWPELZqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvdi7W5/KKTZjHiDPC0jatHVKLSP2NMJHxdQ55P5laA=;
 b=FCsSmyPCvQ6KxqIcgjKBeiUd+6yecxhEd2APqxITWA8V69thGUJ0HB81nblTPxUbUfokzoWP+azLb8mSehKScgyvOvZ3uSC/IxUZ6dOBRdRW57pYaG/bK/HDu4QJtOUpvlmvoICiay7Zr1i7R4/Y7YLzXff4+yd0me0gGdJQ4/M30YoDSWVxJcrGe1GvTsoHn6fubfDTnP07fWtrDn9hB0wdcQBtEVusHWovKA04Vbi4su9FPIBUV5YGfGZuBZQ45ekRgQptqOMLq3nzjWL9tyRhqBr3/mGAkr6ksjwLkg5Sy/5xvzBEbBQdCUnZKQSSSBsnmALY2X/zfgs9q4LAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvdi7W5/KKTZjHiDPC0jatHVKLSP2NMJHxdQ55P5laA=;
 b=pHlQ3eWvC+EW+d/AVn2SOME6JgAoXWzuPmx6NNhxcf/DTMjJxbnIlz1GXFiFGpRSW8dLl4unRVlKl0UfBQEn4DLvkdsiq55TGTaaGWS2n3jVxMy1e+7zhDBA94SbiUOYPRdekFowVYYIZDSNPuRrXAmFC3mx5LHdRWimcv+dNcA=
Received: from DM6PR06CA0099.namprd06.prod.outlook.com (2603:10b6:5:336::32)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 15:38:30 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::23) by DM6PR06CA0099.outlook.office365.com
 (2603:10b6:5:336::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 15:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 15:38:30 +0000
Received: from shaoyunl-dev1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 10:38:29 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use per device reset_domain for XGMI on sriov
 configuration
Date: Wed, 7 Sep 2022 11:38:03 -0400
Message-ID: <20220907153803.24370-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|BN9PR12MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e774e99-e899-48f5-15fd-08da90e703fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0/BW6SzQb4aEgOXbIzMzB/rQzEn7ThOsH7bUGlRQ3HAnGMqRxh28pNYgHzOyzo+IiZ/01uVPQvJX+2JD4P3wM5GzzEQU60PADtNg0gJZtWcfSv5Q/chqDzpPvy5u3UKVhPooUDGMbvH9iSm4MzQkVjp9c60CfPmNDgHyd8qgXdXuy1InlhzMSeeOqIZnwJQKhiE+PQ7W0WoPuvpp1vm8lpuIQumAKabh+37U5ULeKQ/v0/6qSh5YZ6pHmpR635d2SjKkef0nFl5uNO3iwHBYA7SvUOV26SSsdBFWF7K/ZhM4LWzUqn9w8HjYMrsLZz2IDdV3Oy3bWNgq9SICaVI9HLL7Ccav2kAVG7TnTH1Vufs4qMJWGcr41Z8bztfwhnNRTZB+1WJislgi9WhOx4BljH81VALJpvvhJDa9yk3zuV0fzsJhwrpx2OfjTN3M4QRopjOx126zo2udF+b0sK3qCF5xu+11ogka6RYXW3KN06eYVyx3EAb3cEjM9i0pWndXsAS6p+AMgqvEQxrE9xHstH8bnfTf8H8YBAYv02Zz1jesZGbPLJrg/QKELJ5S7b34lv+JOtJs2Fo+qdKJnfEvr/tcWh5Gdi+y5HH85zhRuJqvcKd9xbjsSO/FiYqQW/fWSyetR3OsJPXsMMWLpHng9JTiHyEJ7e7cnMOmBDO/DjWbBC9Oz+UvRQlkB89Hvm6EFKmbFq5HsCtUWDD3NQToleAz50bnfGLbLAzAYvwVbL6UfvdQWPz68SJMOhpww5XPDI9Qt0gkmRfZ9XiUcIOQBdMvTkJvsUdMUkjlnDGD70UFYjDPYiAeLu67Pwqkkm58s8rU/c8iMf0w2Y0rUtcMCjW7CZHHj5R/aSYJGUbEeg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(40470700004)(36840700001)(46966006)(82740400003)(8676002)(2616005)(186003)(47076005)(426003)(86362001)(1076003)(16526019)(26005)(6666004)(478600001)(41300700001)(82310400005)(966005)(336012)(7696005)(81166007)(40460700003)(356005)(5660300002)(83380400001)(40480700001)(36860700001)(2906002)(36756003)(70206006)(4326008)(316002)(70586007)(8936002)(6916009)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 15:38:30.3950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e774e99-e899-48f5-15fd-08da90e703fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV configuration, host driver control the reset method(either FLR or
heavier chain reset). The host will notify the guest individually with FLR
message if individual GPU within the hive need to be reset. So for guest
side, no need to use hive->reset_domain to replace the original per
device reset_domain

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 36 +++++++++++++---------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 62b26f0e37b0..a5533e0d9d6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2453,17 +2453,19 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		if (amdgpu_xgmi_add_device(adev) == 0) {
 			struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev);
 
-			if (!hive->reset_domain ||
-			    !amdgpu_reset_get_reset_domain(hive->reset_domain)) {
-				r = -ENOENT;
+			if(!amdgpu_sriov_vf(adev)) {
+				if (!hive->reset_domain ||
+				    !amdgpu_reset_get_reset_domain(hive->reset_domain)) {
+					r = -ENOENT;
+					amdgpu_put_xgmi_hive(hive);
+					goto init_failed;
+				}
+
+				/* Drop the early temporary reset domain we created for device */
+				amdgpu_reset_put_reset_domain(adev->reset_domain);
+				adev->reset_domain = hive->reset_domain;
 				amdgpu_put_xgmi_hive(hive);
-				goto init_failed;
 			}
-
-			/* Drop the early temporary reset domain we created for device */
-			amdgpu_reset_put_reset_domain(adev->reset_domain);
-			adev->reset_domain = hive->reset_domain;
-			amdgpu_put_xgmi_hive(hive);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index d3b483aa81f8..a78b589e4f4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -391,24 +391,32 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 		goto pro_end;
 	}
 
+	/**
+	 * Only init hive->reset_domain for none SRIOV configuration. For SRIOV,
+	 * Host driver decide how to reset the GPU either through FLR or chain reset.
+	 * Guest side will get individual notifications from the host for the FLR
+	 * if necessary.
+	 */
+	if (!amdgpu_sriov_vf(adev)) {
 	/**
 	 * Avoid recreating reset domain when hive is reconstructed for the case
-	 * of reset the devices in the XGMI hive during probe for SRIOV
+	 * of reset the devices in the XGMI hive during probe for passthrough GPU
 	 * See https://www.spinics.net/lists/amd-gfx/msg58836.html
 	 */
-	if (adev->reset_domain->type != XGMI_HIVE) {
-		hive->reset_domain = amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
-			if (!hive->reset_domain) {
-				dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
-				ret = -ENOMEM;
-				kobject_put(&hive->kobj);
-				kfree(hive);
-				hive = NULL;
-				goto pro_end;
-			}
-	} else {
-		amdgpu_reset_get_reset_domain(adev->reset_domain);
-		hive->reset_domain = adev->reset_domain;
+		if (adev->reset_domain->type != XGMI_HIVE) {
+			hive->reset_domain = amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
+				if (!hive->reset_domain) {
+					dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
+					ret = -ENOMEM;
+					kobject_put(&hive->kobj);
+					kfree(hive);
+					hive = NULL;
+					goto pro_end;
+				}
+		} else {
+			amdgpu_reset_get_reset_domain(adev->reset_domain);
+			hive->reset_domain = adev->reset_domain;
+		}
 	}
 
 	hive->hive_id = adev->gmc.xgmi.hive_id;
-- 
2.17.1

