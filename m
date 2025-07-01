Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB6CC83038
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 252FE10E5FF;
	Tue,  1 Jul 2025 18:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DcMv8igP";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B064A10E621
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf64EFPTb88iJa5uuoYa/xQZCbSvzxHKRhcG0FgcC0NMzGvvAI1/1g4u+zY3plgYIW07ybbqRiY7/atH55dfemHoMJoQOG7xK2lvgrn7Zk5F+PjvL8JePCYPdDzcqazKFItggeDbzsOKH3Q+jSND7siBw+5HbS5EKbXuWithoYHL3/SMLCSXXDwBH3YTQE0ApEMo2Jbwqa9Jjl3DJdBkBwSytiuXkcl5Xe5B839RbqnA4kTXxuz30C8O7Ejy6c7hR/WghXbHTna1z072E41pHfmcmJ5kyEkwqYEAm7Hiejp+ffeK0HA5FYQMxbWEb8+OuGdxrE6yuEXqcC0cbOGRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/KpmHvlM63VhkzaCFQKVLGeP2N2HKJfGm9QhWBQrK8=;
 b=fyugy3URyfT6c80+RZreiLNGmll08a+Rtm3QvFpa9eBNtri4BgRVdHCdabGn+vviVofKBXluKWyf9jAlERvjKTeYomTZH5x/ylY7mgSxLVooB6UD0enXx8gTrmjAK1av1Js/DDLdzBXR/YQkTyeg5jKiCMpyCZajltDD4Yk/zFYad4vp8jzXhZp61uEe1r/Z1KuMK3KVD1ZhFJHN5QiKDmDVBbap/GOb15HRjxPri7pwbLs1qvqesNzQfsTUQ6pXHI/pF9tWqDhhRB+9ZYchUGk7oX6FKf8JngC1XevwCDapJ+2qSXQaYi2X/1Ags7iFx2MbW8MDD2wc9zuMQpBz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/KpmHvlM63VhkzaCFQKVLGeP2N2HKJfGm9QhWBQrK8=;
 b=DcMv8igPwHwUAHhBC8w2IN38+RfinBL3CKuco9kxk4VUn8OzPQ1MPa3ZN3jy3Ld5mqdfuKtLDrpmw860G8Iu6L17nVd+7Jn/zwN6yBeeEWUreV5aqrpIV/gf0DDRDCZPzRiB1XtnvggKH4+eiOmSI7SxbS6zhbXaM8HoS7sVF/0=
Received: from SA0PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:d3::23)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 18:45:13 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::75) by SA0PR11CA0018.outlook.office365.com
 (2603:10b6:806:d3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/28] drm/amdgpu/sdma5: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:32 -0400
Message-ID: <20250701184451.11868-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f5d204-79e2-4fcc-ab55-08ddb8cf6934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aInZUP6DTINXgAlgPIyQJ0ITksIm0kfcojKkCZgGJVwSrPCC5I88/0Vg7tl2?=
 =?us-ascii?Q?xViuV1fLwdJ+Kr+jKSl0RZE5rReNzfaUuWHef6nEKrbswB72OLPQ76mOGLpt?=
 =?us-ascii?Q?JqNvf6RqRUzqmuYb+cO6WgA8U3hQmm5ojdEEcOXbvr7yDoiBZS9mb8Y3wuwY?=
 =?us-ascii?Q?RiGHDcROwNST3fMWS44p1SdB/vu6kP/WFWeNraecc4fQxnw7mvm3/Eecl2oM?=
 =?us-ascii?Q?lq2o7sqK9E7Yx4QuyXdgpFtJQZwORo0Yd5egAeXI86RV8GwZxf/5TEmwbQIW?=
 =?us-ascii?Q?3l8zvOn7XYjfoljEZzVGLTH9OQ56Adu41jz699EQ75j2qDyUWmRPtQTTkfAu?=
 =?us-ascii?Q?679dnm4F1Ze9ulRswkBuFUWwST9c5dw5BGHIo0IfgZ2a4fefVi5IkJ1//e61?=
 =?us-ascii?Q?jkjZ20s4S224y1zcNmRb4xYWPxTURuQpR2Lyhvc3ZhVuMSMBOk8W37f96nmu?=
 =?us-ascii?Q?8u3SiLac/w6cFjC97ac79oRHjIn0ONjdY0HeeiK0sG8g6imvqTrcvv7AQhaz?=
 =?us-ascii?Q?NsKbCzxEOjXhMNDjqKIkKm1tT/6RHMbHC1EP8n2Lm/dgg+JWr6FCvjSrItnq?=
 =?us-ascii?Q?t16dezye7BSH7H26mXMYH7wr72/n0t30vllaPk5I+Kbbg7LahqSOYHcVNFdz?=
 =?us-ascii?Q?62Kmle2Z8H1FZ7tC09QTT4Aw9wAd6ZTh494dlL59ua6jZuyw6y//0Rsd0IVK?=
 =?us-ascii?Q?/p78hISYdZyQy5DXGPOiwZkxaqxj4IcmfSmoNCrtKCVRuZ7c5gH8j/JNqyVr?=
 =?us-ascii?Q?A6yB22ZjvFDAC8vpVEkXd3lh2FJpyi6dqXza7B4D5Fqfa6ENbY8ct1AhuHbF?=
 =?us-ascii?Q?3rZt0a5tdhRabbnuenk8td2fpHJQ0XOvRq+K3wOIHUH8u5COSVOupdphTvpU?=
 =?us-ascii?Q?5qMyhERqZo10YvQgu0qERxvW/80r51JBeFjfUTCM61gfcTAV/Q5SamA8QtMV?=
 =?us-ascii?Q?Ypy/0+L5L35dhtcaJe/xBHmzXS/9aFn3zUHgt1SNmDZgxRbhbImfZh6Wb8wD?=
 =?us-ascii?Q?yjXhb4M6haLs8vJMCAC6JC8N9dMyne+8aGyt1UHvXtVVXtG0rPnLk7leeQkV?=
 =?us-ascii?Q?WLT6sHIWnAFsX3/gyMesb0sAqeNFyLf8AzBfl97hu9TN4H2jpnv/XEH0S9rN?=
 =?us-ascii?Q?aUMxe/VaFTOaJJw+klacyf36eu5iL+Pj2cGsHRgXzL6BstpRSirv0cPikHA8?=
 =?us-ascii?Q?YJSrpvvvpYhjjocm074Eh9UuSmjxDQjScg+jhAaHHAY0/7A/67o1O8Cq++2A?=
 =?us-ascii?Q?XLv//fa+rcICYYiOyvkJhU97aOaO28QFCt1L1MwcyrWqHZjieN8AhjtbXpbK?=
 =?us-ascii?Q?niyyeY7kLvxFpWKokg9DS4DBDCjVi2N64WsORB5d+whDSn5oYFAqNC5apDf4?=
 =?us-ascii?Q?YJgRIFOO0YbMj+gaFC6XsRXCelKZdWejtjwbhk+UPBnVu448a98rYFz06Utt?=
 =?us-ascii?Q?O9qPJukSVM1uCCqF+rW2YuYHzM//Kd/7UMWqkiXZ1gjC1KRkclDelWyrdlh9?=
 =?us-ascii?Q?dPX5w+n4heWy89xgy8QzrZWht0nW2Ycs8sCx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:11.8620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f5d204-79e2-4fcc-ab55-08ddb8cf6934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5a1098bdd8256..577b002fe566c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1544,14 +1544,25 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_id = ring->me;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	if (ring->me >= adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, inst_id, false);
+	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
 	amdgpu_amdkfd_resume(adev, true);
+	if (r)
+		return r;
 
-	return r;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
-- 
2.50.0

