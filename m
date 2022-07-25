Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6D8C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 10:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB892BABE;
	Mon, 25 Jul 2022 10:32:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A303F2BABE
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 10:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFVZk+yh8DQZXpXaX11nve3pY8+PTmvmlW62lgzRN73UP9SfD8cQgNSKaR33e6Z92ku6Sni5BMerWrKv0m8dF55uLslchapK6+DK54mbf2sfXBqWlph/AGtv9SjlQmRhXmdkFHRtjQgZVAV4MvCgN2WZRIKJXaD7FxvdGor4ReAWNRfXfKa7vTKfTIw6j5QLJ0ifDDECDq53Bt2sWMyW+2AMXsdhwr0yXHCcU75fwGY8fUxysuZlHL0jdPxIs40kVhh/dw/t0w9E/bsIiinyllf79hIqcJhUD0qtFghnU7T6s1bdM2zo9Ag8He3NxYvZxPsfxDmc9VIHfySC8AgQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/vMjyrAYMXO3rK/6krlMHN4EP4GM7u7ISJsX5W/eWk=;
 b=exLeoQOFPcn507JQuRNPAFIw6mRqruD+rUbACEHdkvzVFqCrEETK4PJLstjK130F6XDuNUKr6Y+fvOcFxAIvKMxIM0BPi4Juo/dTZusmKb7Db0Si6ZxbQ0Aq9STAq45tR/a3d+XsyPo8Wcz9GeOAyAsjmsg5cbertK7o9osOYJ2sM4/ZtpitSzYNPH55VGBchYFWYxdgFemHHlKU582gsgEC9LrnN5BStnUSj12CuMVAY7zOqauRLEBUvPmwz9MNrvvlmcFRk7WbvBsSFBU+LTPNoCQ+1fsN18mDC9wZLsfwkHCHA+B1ZxfUfYXqo6WGQ7AqOaclV9ueU12Q+YmDlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/vMjyrAYMXO3rK/6krlMHN4EP4GM7u7ISJsX5W/eWk=;
 b=fOIZtc7Wj4/1iOGAaNP35Rn+zPRVwBd120tOY6XE8XM20JSlOCNcrM6KdmadQxDpwt8EddUdvkyuZ5eZvPqmovUfckLHQ3PllfK9b10BgAhSeTsLyYctNaPtlH7XVWZsXA1VEGi+Xub0xIPoadC7QHMr2ekOr2Y2WJ4vnr/5c00=
Received: from MW4PR03CA0176.namprd03.prod.outlook.com (2603:10b6:303:8d::31)
 by MN2PR12MB2942.namprd12.prod.outlook.com (2603:10b6:208:108::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Mon, 25 Jul
 2022 10:32:23 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::bf) by MW4PR03CA0176.outlook.office365.com
 (2603:10b6:303:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Mon, 25 Jul 2022 10:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Mon, 25 Jul 2022 10:32:22 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 25 Jul
 2022 05:32:18 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: extract a helper to import dmabuf more
 flexibly
Date: Mon, 25 Jul 2022 18:32:03 +0800
Message-ID: <20220725103205.2085630-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21d30794-80ee-4d2e-18d2-08da6e28f607
X-MS-TrafficTypeDiagnostic: MN2PR12MB2942:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJdRdl2oy+z7yBk/hYdT7RS1YQOEYMvYkMpelKfeOe81ItahOq18pwLz5VGMVEdOKfrNL1tiuo9RlIE81DNUdpVs6R51WPzsu2g8ULH/wp2nu/aCQG87Dn7UQyiC+SNmdnUhaYI0i5FQgt584UnyjPavy3NOOFeYPOZYvtXpEXCtwSpUe6/60rfFtd9rEqCcs+H9rZwp+Ja6Gtp3PV3qXvM4TJ1jJ1BLOmtChYmqFReCoTV/8h9L7BuuOj992nQb099c2isY5zWtXIl98sZHWc0ycN4p/l6Jl5v8PU7KQE1nEPAgCK4w19h3eWiWosWU0f0ltLA6XHZWRkAd1cUG/vJJpihyc+6WBBrsn9dIQtT00H/CLyaBegHKWxi2nq8IfmBymORLeIlWd34RLi154CS78HKhcaYWKbCr9CxeXroggTMX1bfP/ALzSXQ1g6h5tJvOAp+jiM59rRw7Pt5jNF1fBvL2cbQnOq8zzmNiPYpXP+ergJEmLdbjZTVpSlZogsdmYpTyGdVCaonjmEIyLey1yH7TLpAJyfgZuLkAEAcuuJ66OER2G0bDVUV82mpFhfqPuRaLeYpZHvC5uijPqK7F1O9yGVF/IOifJG12SdRPJGV09GyXXwx969CosekbY2FaKg18FNRKoJTZkHEvBONWNVSeEkLunUVTf7qRh4spL99kvkao5POinleSLmbmJkDE5pohcBfnKMccHXLOXePaS0eVXM8//T2mOr0Yj4LIExu+BXTtzw0y2tO3ugO6zmAvbfbnf8jL8teNRmX9RsW7Y4h645ZNGShLVjZrgPcrWQfx/yQV88pmio0XmQG0Lqesn6sIrYB0W+QkogVVjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(40470700004)(7696005)(26005)(40480700001)(8936002)(5660300002)(1076003)(40460700003)(478600001)(16526019)(186003)(2616005)(83380400001)(336012)(426003)(47076005)(6666004)(2906002)(41300700001)(316002)(82310400005)(70586007)(54906003)(6916009)(82740400003)(4326008)(36756003)(356005)(8676002)(86362001)(36860700001)(70206006)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 10:32:22.9879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d30794-80ee-4d2e-18d2-08da6e28f607
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2942
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For clients(e.g., kfd) who want to determine whether to
create a buffer object by themselves especially when
importing a gfx BO based dmabuf.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 38 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  2 ++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 579adfafe4d0..83bbf54d5562 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -429,6 +429,28 @@ static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops = {
 	.move_notify = amdgpu_dma_buf_move_notify
 };
 
+struct drm_gem_object *
+amdgpu_dma_buf_create_obj_and_attach(struct drm_device *dev, struct dma_buf *dma_buf)
+{
+	struct dma_buf_attachment *attach;
+	struct drm_gem_object *obj;
+
+	obj = amdgpu_dma_buf_create_obj(dev, dma_buf);
+	if (IS_ERR(obj))
+		return obj;
+
+	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
+					&amdgpu_dma_buf_attach_ops, obj);
+	if (IS_ERR(attach)) {
+		drm_gem_object_put(obj);
+		return ERR_CAST(attach);
+	}
+
+	get_dma_buf(dma_buf);
+	obj->import_attach = attach;
+	return obj;
+}
+
 /**
  * amdgpu_gem_prime_import - &drm_driver.gem_prime_import implementation
  * @dev: DRM device
@@ -442,7 +464,6 @@ static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops = {
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 					       struct dma_buf *dma_buf)
 {
-	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
 
 	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
@@ -457,20 +478,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	obj = amdgpu_dma_buf_create_obj(dev, dma_buf);
-	if (IS_ERR(obj))
-		return obj;
-
-	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
-					&amdgpu_dma_buf_attach_ops, obj);
-	if (IS_ERR(attach)) {
-		drm_gem_object_put(obj);
-		return ERR_CAST(attach);
-	}
-
-	get_dma_buf(dma_buf);
-	obj->import_attach = attach;
-	return obj;
+	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
index 3e93b9b407a9..3b89e3af7c06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
@@ -27,6 +27,8 @@
 
 struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 					int flags);
+struct drm_gem_object*
+amdgpu_dma_buf_create_obj_and_attach(struct drm_device *dev, struct dma_buf *dma_buf);
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *dma_buf);
 bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
-- 
2.25.1

