Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AC6C7EE24
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3E010E530;
	Wed, 10 May 2023 21:23:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F05110E52C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPN3wLiON/88P24sNAAWa3qhubah/wghAylG0Dd6FySJY3auCYBKD4CeZ30VrQya2d78YVmnv5hJ3FJ3Svi86fBqJaQ2eL2W0g5WD9P7VgLGP+jysaFkVXnIE7+j0LcMPE/iGNgafxNQlpiDqOzpGawKHB715S8oK8JLHtFaEWijrFFk63NjbYt0trXBEfaSTs++c045x+T4wlTdY85mmUoRAZS44nxARAUAmHRWKwTRUqUpSsQO1Gahl+cdB5eDO+SeqiryTdLGjgT5B0sNvSjGFy5wDPK1wsOeyqokw969F8pC2pB90/wB3GEswA5sArwc3O6fEoJKzCYwASf7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ji44oMKXVncMWA3J9xEPPRAGAqOnVN5SU/0sLjsSWc=;
 b=daCQIGlcWiIWjx9d53fe3QeoeyX1NO/9rzIqGu3ZlERfsX/k2r50kOZZlOusj2PkBmI8m5MAyLBcy9MIrCgYP7bxiNvzEsMnaP6Xotu10JDzhuZfIiMLj/RztohWrcWOdOSFZq3xFDGv0HQ++nc23aqSez/B+B38EPLws0QKXGpm5+bGOqPzlGpMbkRPgD1dURS2rTX+TeHP25iyA2njiusYfX4tUYatxeezRsmFEdy45mRE+mpJbG2eX5MLrc4GQbMfbTzGvoEkpqlyEY9zAI972gVC5cCBFh68P+j8kO+DRNi2XeLCmMFhBXGlxZDvjmJyAOHoEXUh+PVpdiOQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ji44oMKXVncMWA3J9xEPPRAGAqOnVN5SU/0sLjsSWc=;
 b=OtU4uZdumng6BAM9vIn6y1vmDdhKihlfrBxU/H6XClubZ22h1DyEVBnHH1EgclGOPsrMBUzSX6yhe4i/6rOGei3tbQ6EYtDUfhxMMJaYcNK4rwfCg6oFBBQWczfAXVTZMHAJMB+d8rTktBEspEZpzo+FAKiKJ91/nAL/p+lPz0s=
Received: from MW4PR03CA0075.namprd03.prod.outlook.com (2603:10b6:303:b6::20)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:23:49 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b7) by MW4PR03CA0075.outlook.office365.com
 (2603:10b6:303:b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:23:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/29] drm/amdgpu: find partition ID when open device
Date: Wed, 10 May 2023 17:23:06 -0400
Message-ID: <20230510212333.2071373-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: a113f4b0-bc54-4f50-820a-08db519cd8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xka/ZzVUyuyEhMP3kpd1koElE7w/y73JL6nO6hz/772f/uETemWRfYkMBvaVuP8CknmYitxNC/98UyTAPQJlxS4y01ELkjYPCcP+UZHQiKfoYKYeIHCAaiz75NYvmtSw3BWv7hX7eBN6qVMSlr21JnO2ioqJU8tUnpm9HAouBsssXhMR41in2IZg1vBTxyGuPL4ASsgeqFnPn0iPBXtFIEiAOOjfZuh6I5C0pGuMoau0O+PGDxgkCm7WmNYqoBqU5Yhr2hPXtbyqnSHW488h5w8rdLzoEMpzYvOojPZtP83/6/2afNFqHIvDM1jl5AO0+RF8NwKyYZkc6ygQjd+YB3nT8K9aT0F2DEGtcFEqz3g3zciig+uEWGYlPYf1lQiIhuKtVFTIMO7axiEQEtc6Kjh1mAAH8px+GWDz4vzHytDlkUeGh7xNwZLMrk6BimkqLVKi4T7aDbvjUfllBwp/JTVa9NGe2Md6TWJwGJu29x9N73TGrWT8XTqKSvNp0SxVD3OvOAwtWaQIiH55XieinOQ+dw8zBnnNjrLhSD+b0Y0C572Bc+sj9oD/J1NgraxlYIUrmgEBD/+nyyxTMSD3qFg6c7a9sRUW5kGLDhMEJIVoo7b0eJGSvWFlbu/ftsnNLJtGOcodK17+SzWJUJdP0vKX4aHcsYAcHYTLIUayvsVGGToZuIrIONilc+eV4s4MbS5GPND35eQE7FXaS48v6Y7QA5m2v+rvD7nZiup7/Q8bJI/Nd7OQ48Bw6kYeoZgYZ83WP67rhbEprWtN4BvYQrUA59SY22Ydr1007qdvi1c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(336012)(40460700003)(426003)(16526019)(186003)(2616005)(2906002)(83380400001)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(66574015)(47076005)(36860700001)(40480700001)(8676002)(7696005)(316002)(6666004)(8936002)(41300700001)(5660300002)(54906003)(70586007)(6916009)(4326008)(70206006)(1076003)(26005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:23:49.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a113f4b0-bc54-4f50-820a-08db519cd8a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 James Zhu <James.Zhu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Find partition ID when open device from render device minor.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-and-tested-by: Philip Yang<Philip.Yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 29 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  3 +++
 4 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 45c6522ee854..4fb43baddf96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -488,6 +488,8 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	/** GPU partition selection */
+	uint32_t		xcp_id;
 };
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 44997c7ee89d..879718598fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1223,6 +1223,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
+	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
+	if (r)
+		return r;
+
 	pasid = amdgpu_pasid_alloc(16);
 	if (pasid < 0) {
 		dev_warn(adev->dev, "No more PASIDs available!");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 8b28b18e4291..9b627a8b1d5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -335,3 +335,32 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
 }
 
+int amdgpu_xcp_open_device(struct amdgpu_device *adev,
+			   struct amdgpu_fpriv *fpriv,
+			   struct drm_file *file_priv)
+{
+	int i;
+
+	if (!adev->xcp_mgr)
+		return 0;
+
+	fpriv->xcp_id = ~0;
+	for (i = 0; i < MAX_XCP; ++i) {
+		if (!adev->xcp_mgr->xcp[i].ddev)
+			break;
+
+		if (file_priv->minor == adev->xcp_mgr->xcp[i].ddev->render) {
+			if (adev->xcp_mgr->xcp[i].valid == FALSE) {
+				dev_err(adev->dev, "renderD%d partition %d not valid!",
+						file_priv->minor->index, i);
+				return -ENOENT;
+			}
+			dev_dbg(adev->dev, "renderD%d partition %d openned!",
+					file_priv->minor->index, i);
+			fpriv->xcp_id = i;
+			break;
+		}
+	}
+	return 0;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index dad0b98d1ae7..ad60520f952c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -119,6 +119,9 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 				const struct pci_device_id *ent);
 void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
+int amdgpu_xcp_open_device(struct amdgpu_device *adev,
+			   struct amdgpu_fpriv *fpriv,
+			   struct drm_file *file_priv);
 
 static inline int amdgpu_xcp_get_num_xcp(struct amdgpu_xcp_mgr *xcp_mgr)
 {
-- 
2.40.1

