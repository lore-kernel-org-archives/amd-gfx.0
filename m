Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82C5C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7317C10EB07;
	Wed, 29 Jul 2026 08:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xYRzUslG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013065.outbound.protection.outlook.com
 [40.93.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B1D10EB07
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 08:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4FLMttcwPDSmbCk8iDuS5cVhPfuPClheXL+aFHlEDklOoyzT445KcdqXoMn4PFBK3lLRheYQJ4ClOvoJZgZihsSt6R18PBgCxvrS7biXxsUeav5aDiBCdkKSG/Lv9/pqTEFFLrh20CYP68K895v90GgsxBba00jDSmDh+/8MNHGiP5otWcuKYiaZDCL+5DNf9Q5Z1zcjxFBWJS56elmZsaGpmR2KabOvi+hyX4qkqmoG8luVgkSWF4VHvmcFqt5R+k2EDN8zmfKYOtONZnoQ/ukyNOfGeqPdq9Ol7k6E9rJ8kHgACeXrckto0JEPUZ3ZKSyQKPr934kTeF22CHsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAqSA2QAfQ4qORKax6Jk7D6zwsvqpLLy4gsLrYRbC74=;
 b=b14j7e8VeKMIA+cI88OzNVrHacs3NqpWIWiIMyglcgOHnXmJYe4ABp2YHJDSXCt05tlvO55PF6TSOOZ+h0YzIh+5wL4Z4cYPLr0Bk/ggrG0MX12V4knwj5qiwh7/CEiZVdBNsndBcM7S1fShFRJUCYedTHxVvNRXFX4e3decqIdO35yZXa5EvM0ufFSNgz9vZJU7KKX5bCIt52pavCM+EllrIzCFI4rwSuu2gwtGIipKLN8iJ6rmAH8LW+fTLApDLjwf6xAa0JFtHLUSjIc5+novlzgY4tL+6fuhXn1cFs6OM8obJcwB+YN9TraL+omMCynB3FYgT0uJynQ1XCRYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAqSA2QAfQ4qORKax6Jk7D6zwsvqpLLy4gsLrYRbC74=;
 b=xYRzUslG05EJ9fTfvpewBYm/EWKmgpBLSLCMNkvqyLWxYRp167BoJ5+JMSO4dYkFXESuUT+DyzrGk9IjZHtysPpRDh6Udy9oyBvokRqWCgyypG/k9jPBZbqV7riLyHjRkZIMGiD9LFZ4Uerl48mA1YeT6mh7acAjgb6KquXri6Q=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by DS0PR12MB999266.namprd12.prod.outlook.com (2603:10b6:8:426::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 08:58:42 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::ac) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:58:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:58:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:58:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG
 mode
Date: Wed, 29 Jul 2026 16:58:16 +0800
Message-ID: <20260729085838.1338931-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|DS0PR12MB999266:EE_
X-MS-Office365-Filtering-Correlation-Id: 147fc8b9-0b04-49b1-b091-08deed4f9695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 2VNdIRkcQQnS32RC1CiIUsk+IxT0+t9C7A4oh2lcKbw8I2MsJ6899TQgA/9pTA0YBM1CeidAjrXwlvYub8z/KdSvDNeRQgU6lXXmITNAm2XGJSR9vqgJkA72fs68keEvxf1FZsw4eY7/UK/TcKp9moemJvl9KYuprZy4U3TCNX6qblPm0Jay5MxAawKmmTbytBk8mLe+NiWMCP5mk7MoJ1MjhZARpoqMaWJWHQZi0c3w3OxSt1T7/UMMwkjY5ZefvRyy0lvVSSCUKA5jGlXHUO9G2GDP1ZPohMYNn3fR7c50M6yhqNAxt1Sm/sdxmHa0FN/eV/n20//0Xs34l56luAXig46XzgLpYDZ3odWMs8ryOq7vC/j24rjlVCzOanmy2ZK4Wf5l/Z48kEBQDJxM7KIkfsvDIAi6TnvwjP1OPzzlMQCVmg4GRXefZcpFBJQSadn9qTpO8fUvi5aPWTeET30kNicS+GaDJSDU5ht+EYd5gKaKlBsA5qxQobpTV4uvggjJf8NjhznsZOMxyacMsqP9sXjuOnggShqoRExIxmW/LQtDlpHnu99L84dgfwtbS6lWy6+T/8kqTYMlpOvIId6O+Mh1y7V5Du/oYbeb9yn+7XdRvzqZ4qle3k0Ap6GxnI4TPXbSEdYMZNR4wtFJpF0HcB8Lp9x2OUMH0aAngrVt78h/mjUH07wFsQfxSmUwF9KnJhB/cEYtkvxVBxZGDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 511EYIYRjevA0vbYXzY+KqYbQiKAKHpbOSZeZAfyEHl6T2n4iGix2yiB5WnuqruLcwKOJpVNiAHkpJqGKMgeaNuXSioZm9S2PJZu6mzRmwu1QAVYRpIYRqW95E/Winyv9KnK0T8C/h0vSkjJ8Gy82l9iy1zpinFP33r3vifzz8XIOE9udjZSh4kv5jwhrQpj7pi0s/G/wl0kr8q5xmBwoFld+WL4yptuU2mDyBaFUfT1u2+LkPHnLPctRcfFQbECkHo14kvEmuMKDxHQozHn1gU5tMUZrSfB7T8bPzeGimndzES3loD3RaeLVTUUTtBU+TwvreUs0NwetjrrcWamln6bHAvbSGCRON0XfmWGchloxDVayQyXjf51Fyxncomz3nVvUcnDaae+mxQNfYDsHkL2BJyZSWEkLppmejZH242c20wPCb9BNXCmofGCd8uW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:58:41.6507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 147fc8b9-0b04-49b1-b091-08deed4f9695
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999266
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In DPG mode jpeg_v5_0_0_ring_reset() takes the DPG stop path, which only
clears the JPEG_PG_MODE bit and never resets the JRBC. A hung ring is not
recovered: the post-reset ring test times out and the driver falls back to
a full MODE1 reset.

Temporarily force the static power-gating path during the reset so the
stop/start sequence power-cycles the JPEG block (JMI soft reset + power
off/on), matching the jpeg_v4_0 reset which has no DPG path.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 1cdbe353ae40..e6e99f7e0a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -648,15 +648,28 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 pg_flags = adev->pg_flags;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-	r = jpeg_v5_0_0_stop(ring->adev);
-	if (r)
-		return r;
-	r = jpeg_v5_0_0_start(ring->adev);
+
+	/*
+	 * The DPG stop path only clears the JPEG_PG_MODE bit and never resets a
+	 * hung JRBC, so the post-reset ring test times out and the driver falls
+	 * back to a full MODE1 reset. Temporarily force the static power-gating
+	 * path so the stop/start sequence actually power-cycles the JPEG block
+	 * (JMI soft reset + ONO1 power off/on), matching the working jpeg_v4_0
+	 * reset.
+	 */
+	adev->pg_flags &= ~AMD_PG_SUPPORT_JPEG_DPG;
+	r = jpeg_v5_0_0_stop(adev);
+	if (!r)
+		r = jpeg_v5_0_0_start(adev);
+	adev->pg_flags = pg_flags;
 	if (r)
 		return r;
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
-- 
2.49.0

