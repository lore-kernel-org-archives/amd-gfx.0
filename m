Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B82C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 21:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6305610E421;
	Wed,  6 Apr 2022 21:06:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5614910E421
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 21:06:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBkvqVPpRDAau9d0ZFv/e0lWmEUHgkSwt+CQFDZ4fZPOXjs75+/FIiWFanl7ES9qyi4T00Quuy4O5zVe2Qe0GfdOk0IB2vP6OcoBnVIJkKrgP9VHRHNohTsm/91FN7q6BLH8OB5AnXb7iRYlkrmQqtQyqCuYPgDdEf/i2hdfpnqziwwP3zAUX5NP0BCU/hH7ORn+4QgzcxTeFGRQME3o/CeXmOlR7fdGHiC6yoYmFiIwo1jtdOjCvAzVdBUu0VLglRvq7p5HgIuDeQ8am+ul+iygEVFsR/F1BTerYclRNLDejq0lGmBFJvpBusSZWoiX3N+akoSs7DTfdzYjOeo/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGdwXxrztsgdAQ7UOJJVFMR4FZnSAfJjNik1xaKEB9I=;
 b=R8ot0+rkajhe3V1g88fMl8w2nL926N5cKtRGsZ9IhPrBgeeP81Kn7u4lYrDU+ZVyEMnO+8jrJCMnzh0Re1v3460nijLgoZ/SymgQ+qCj8uCzGeU+xfnPyfVPhV8AZXII1hGhLlNGvLdDA2Y6VvEzje6FVKonhLdQ25VuNoyAYd0bIDHg2QR7igt/JkCRJNV8NK8x1fNmFU/uzV8WUEH5gDxL7zpnzDNmY8nMghNVOpNWqO8jIXkhbXytz87Fq+KAl3+qYKtbT5rdneg5ko2mVanY+FU4zsI0alfwySibDOZ4OQe2yHZlEFvQT6BYrs38VbjMs6kUbCrFthTaibSgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGdwXxrztsgdAQ7UOJJVFMR4FZnSAfJjNik1xaKEB9I=;
 b=h4pJLwwXkfPNKTKfDgpZ1eUrb2UvWKBvqKLgOY8JUC5OZ2bT7P+F+ztR/veyDFA0SM8T28qUL8idUL4hjpy+O9u7QRfOh0Q3316iEKv2HID3m9q+PWR97SIKjKgH8uEs7Odhpy9aiOPRWjMedkVhaR7uRp20Gua2os0PhxtcLY4=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 21:06:29 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::cd) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 21:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Wed, 6 Apr 2022 21:06:28 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 16:06:27 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference
Date: Wed, 6 Apr 2022 17:06:16 -0400
Message-ID: <20220406210616.133483-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b32ec61d-52b9-463a-9171-08da18115133
X-MS-TrafficTypeDiagnostic: BY5PR12MB4871:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB487137384EF0538FD00FADD392E79@BY5PR12MB4871.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5AltozzukWYWCfWWARRXxQq5QyjLQDmE0rvdgr0Y1VNyt34xnCSKDSORunnSNRfO9DUQmlR+lPA2qCR0a2h3EsymTX8fFxtC8QtJk8oDJ02XDTYTKuI0IqmvNkKCMOGIhOfgnW8nwpW+SdRaf2rCWqUJbmm57D441Ty10wKVlGCaHDAzDcCkemfzCnRqYMYIgKiscLtyyPLSXBZPJqIz/HR0YdiSVBt6VwjAPiOi2rSXguJJwLom85ix5f2QK7w6CRJQpX0UBEBldc4dKLo4W4JaUxvgomCPKI+CuzmEYcpKE9WVttgcm3+jVMH0keYBlbNv3+22k13S2SeHNIgC4NPNQj4xJ94Di+Gk+3QE3oz0qCTEtETuWvRCsII6MJabEGoFXHkYqMlZicDJnTyReqAMgAUgSQA7/cpp41JajvwFrBWagNBeUxsBhBvNssxatxAJ6jY0/wfsrYpRQ5MP1avt5O37ueZQ2NLChdavBYXwvcYprwqEYlRzlVh5nV/rcROjKqT9KkaC5TCVfs76DWxyFO6W2Xp19tUEoRKlPwuIBH665tMOLE0SAwfm6czarV+0f3UA8V7PuZfZJP+/BYT5SqhFuUlyUL4oTGhaWOwYTJCTCioVxS69J3KV8T3J23bmsYJbFlszjNBTufonqgwZPZgCgt8uiDL/vijkjgrbFSZKPfefnDNfeXbNITeo69kOJZj65cpnrW+umlapw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(81166007)(26005)(186003)(2906002)(16526019)(6916009)(4326008)(70586007)(83380400001)(8676002)(356005)(70206006)(6666004)(316002)(8936002)(86362001)(40460700003)(47076005)(426003)(4744005)(1076003)(5660300002)(36756003)(36860700001)(7696005)(2616005)(336012)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 21:06:28.1566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b32ec61d-52b9-463a-9171-08da18115133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check that adev->gfx.ras is valid before using it.

Fixes: f385fc0d19ce ("drm/amdgpu: add UTCL2 RAS poison query for Aldebaran (v2)")
CC: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c18c4be1e4ac..64c6664b34e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -727,7 +727,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bo
 
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
 {
-	if (adev->gfx.ras->query_utcl2_poison_status)
+	if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
 		return adev->gfx.ras->query_utcl2_poison_status(adev);
 	else
 		return false;
-- 
2.32.0

