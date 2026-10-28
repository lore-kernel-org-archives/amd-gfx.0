Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37329606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Umb1JhGa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AE710FA88;
	Wed, 28 Oct 2026 08:58:15 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F2A10FA8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 08:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v79mzkbLXr11o6zIQeAJ8LMtV7cSC97J6O4X+HVrw/IPxxW3tvWE1Kbz38ljKZZyXUWaw0MJRuTtEIICpdrAUCAJPfBGeQ3JMkGd6vwihobviTmL2p+60UcWoSAt4MK7ZnvgguB2uenBgytM0Sa4jGpLTSxOH6thVMNf30dDOESbVddxW6iOMQQdPYmS5oFR6jh4pELb5DD8uNYnyOsnuiBJ318Y1uoad+orwCm+ydcx0jtngYizPuC49Vbo3ubGSqqYKxc0OOlK7rIiLPwZEhdMn0FBLfjYBI0EkjiMdJ8X4hdzCg6n3lPjpOX1TJuTnkwe9TJB2rRRbgsG0qfuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEg8FgoAPQXYoug4AxuKYSFu3PcgQgUinMVpXCVMKyA=;
 b=uaHtR+oXy/yQO7ePn0YznFQlWFviAljBFsFyU4TodhNZWy0Oqz+O5MlAa9WYO1mCvnWb1lx4gt5X1vA4DH4HGyvC30QOJoNELtUNbxZPInyR/uVyH6irSrvw3FhvZubA+Qgnegp3Kq9mnCT3uBieSyZLoK2/Uz7ODn+5CklNwut2N5yW2/WmaPhq6lF6Xy5FNkYbk/G9NQ/j6jzj+1nyej34m2rMBVUsm9DZCiLsmlerthVsQhuypnI7xAlDD9IMq4RU7GXjDVPJZTF0OkdNpIDaGCo2i5K0UHVHrNFk4EjRPHkY1kZ/s9vljoUbRtv1XkJ8SxP2DUrIHTqgwdLxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEg8FgoAPQXYoug4AxuKYSFu3PcgQgUinMVpXCVMKyA=;
 b=Umb1JhGaJY4j+8oUxpnr1c8UhcmPmaLoN3Cyuu5QD6pYWUouL4FHpqXvsiMuSKhs7aFJMxbVomc/wdvizQfTfEUJvSgTlFhvT6iGaXzqW2GyEKFstuB/L0F5EcC2KLvX4MVFJVzlhHYQqZjzTMbUawPZaV0ouWgh7Mu2F8SolOI=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:57:46 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::64) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 08:57:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 08:57:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 03:57:41 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 28 Oct 2026 03:57:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <timur.kristof@gmail.com>, <Mario.Novales@amd.com>, 
 <Manu.Rastogi@amd.com>, <Jiongyu.Zhu@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence at the end of
 a multi ring reset
Date: Wed, 28 Oct 2026 16:56:33 +0800
Message-ID: <20261028085736.3808569-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: d535715e-9643-4aa3-e469-08df34d186fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|261009223327099003|261009220027099003|261009223027099003|261021121427099003|261009221227099003|261021123027099003|261009221727099003|261022105027099003|10067099003|56012099006|261026140227099003|3023799007|22082099003|18002099003|261026121527099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: UaqonZLeVm3KeWzMj7m70I4dJ7abVFEcZYQG0gtaWwp813pjx+dHav0B4POV4ELfbzQGBs1GNe/giOr5JfwXEg6jXQ+rws6T3OQTBCoDj9KXNfxdcGydzI3Fi2kZbZooIEqH3JccYsupzG74H0K/34gBLqnyqlJZ54vHguPzv98sh8RvGqBbQ8A5Mv1vYNwc2Mw16ogu9XfmgRHroL+AllmKljSSB7GWaag/wbcp6GyMMjFBLRlunHHdKdb7EOkd4/12lqVu6NOZsnIQ8CumqIZAQLnHHTXqELPqbhA0thd0ac2caOwN6hbanndx5SiRWAW2ginsjGMG4TzVlRfBFX+cHxukefu5m3c7a80bDhTE6W8LrUOj4HI0WSzvUoqQR32+qV8iZXrpw7bnXZDYq3j0bLocemZjvAOjrv/Zqbv1bkUXEJsxf+vL4gnAMBo1cRzrRcnadyM/QUJRCkz7E/Stvt/iJ1PJOhCLS/VrrK14HNy3hVcGzlVvnxwF3VVw+h1igEWkJbM06u+8GjeQdwB1NJ3gN/uQa38PYt5fsCfZvbjADzCqUEAxpbOYoEjFKJNjppnS5AfUoMbv8Z3EYMsx/obJn867h3YPyE1f/VvICZeGN7MxNpxfqPgJ3U1ITKu5pgpY65tkAe48d/JY+TMVWDi4jq6/2F4th49cAsmwBSLHoR3eXYg+HyCEjbufQRcoZBW7+0JHAtVsNyGSTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(261009223327099003)(261009220027099003)(261009223027099003)(261021121427099003)(261009221227099003)(261021123027099003)(261009221727099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(3023799007)(22082099003)(18002099003)(261026121527099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: beHcIuwEBFGmSfZYwtyyyNJQ3LvA9kg2VEkdeLNAss8YTnwy4C4udluK1xV0OoeMVhHXCuveX4DnwbplQ1YecGgiEqLlzVsqx3sBd6Kp6nTpP4x3cDS3xFTY6F87xtLSfJ2d/LyK23KRiyL3G78DlGqPwIn8YFJfTX2p05puqnqb6eeSfCyHM+wa7aIfjY0PZSfROOK1DK2E9nToEFfd9Uz5knauI7kFVQ0GKsGCIVfoMqmhbMrbaB9ZgEdfXQzWuaZjm1GLCxblqC6ydlJE7EZhJ7VESUTXHYfSAIYB+4obLZSscEpGei36WXgZsd/umwbGhLNh3QpxKXzZwHOcdhMbaEBq0iDCCHsTcv3VUMiFFer4QTZQ98SuRGCjMT49Y5uJ/vnQOUSEL/Wpowu7327ZMaxw+12WNw+nd1XUyS7c2DFhOCHodLjttVFemOda
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:57:42.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d535715e-9643-4aa3-e469-08df34d186fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_ring_backup_unprocessed_commands() skips the backup of a ring and
clears ring->guilty_fence when it sees the same guilty fence again, to
avoid replay loops. That happens when the IP block soft reset follows a
failed ring reset of the same job. amdgpu_multi_ring_reset_helper_end()
then restored the guilty ring with ring->guilty_fence, NULL by then, so
neither the guilty fence nor the rest of the ring was completed: the hung
job stayed pending until it timed out again.

Pass the guilty fence to the end helper, and use it for the guilty ring.
For the other rings, and when the backup didn't drop it, nothing changes.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 13 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index d0b0d3eaffc5..2eea18965fd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -469,7 +469,8 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 
 	r = ip_block->version->funcs->soft_reset(ip_block);
 
-	r = amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask, guilty_ring, r);
+	r = amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask, guilty_ring,
+					       guilty_fence, r);
 	amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index edae764eb0c4..7f0f0ae6650a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -1038,6 +1038,7 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
  * @adev: amdgpu device
  * @ring_type_mask: Bitmask of affected ring types
  * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
+ * @guilty_fence: The fence which didn't signal on the guilty ring.
  * @ret: Return code from the reset function.
  *
  * After calling amdgpu_multi_ring_reset_helper_begin()
@@ -1050,7 +1051,8 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
  */
 int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
 				       const u32 ring_type_mask,
-				       struct amdgpu_ring *guilty_ring, int ret)
+				       struct amdgpu_ring *guilty_ring,
+				       struct amdgpu_fence *guilty_fence, int ret)
 {
 	struct amdgpu_ring *ring;
 	int i, r;
@@ -1080,8 +1082,13 @@ int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
 		if (!(BIT(ring->funcs->type) & ring_type_mask))
 			continue;
 
-		/* Restore contents of the ring */
-		r = amdgpu_ring_reset_helper_end(ring, ring->guilty_fence);
+		/*
+		 * Restore contents of the ring. The backup of the guilty ring
+		 * may have dropped its guilty fence, eg. after a failed ring
+		 * reset with the same fence: still complete it.
+		 */
+		r = amdgpu_ring_reset_helper_end(ring, ring == guilty_ring ?
+						 guilty_fence : ring->guilty_fence);
 		if (r) {
 			dev_err(adev->dev,
 				"Failed to recover ring %s after soft reset\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7e6ed43771f2..349c7d503e5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -643,7 +643,8 @@ void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
 					  struct amdgpu_fence *guilty_fence);
 int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
 				       const u32 ring_type_mask,
-				       struct amdgpu_ring *guilty_ring, int ret);
+				       struct amdgpu_ring *guilty_ring,
+				       struct amdgpu_fence *guilty_fence, int ret);
 bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
 					 u32 reset_type);
 #endif
-- 
2.50.1

