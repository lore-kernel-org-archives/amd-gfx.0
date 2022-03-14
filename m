Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E672C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 02:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15F610E302;
	Mon, 14 Mar 2022 02:47:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FADA10E1D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 02:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPZEsM7mPxK66ppVK51Fr0iwB7sfLdcH9X4PIySpNi8LbnTuDHXeFktSgeQv85cxRZjcLGUJmdb+pCWHGM3Y65xUA4WE06+ovrcUvz31WuJjrAPlDmdMxzl8vzZeWsFjgrvU2RlqmfBqT71jZcNVoQqvQfqlWZ5s0QJUA4AkI82xma/BZxu5U1NlFCAl3OjfBdl3nOAQfEIt7iL2CJ5jMmtosDVkSpVddRdxSby7j1IRrzUMJwrOAsKj7jB6H/Cd97KTjpmKNBxqHJIBedcG/Actm2pnmKYBbP6IhUynZ1aSI7XKYQzbtUtoWBMYeH/iEkOFJRO2f3MdLpTh4oR4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP0FIpwkuI3NoeDSZnbWg+e7oaw/7dzsfNSOWBklii8=;
 b=HpV1xBKVx3yScxhncHJCcRvAUXdUVhp+pmtkdNa1ftFpczTtLWSjcIzptLC9HqJz6+STHTD7LDNsLLkF73t6/IMvzxzN/L9uEZ1X3jRpcIxeYxhUT6HxBe7lAwlsnnKEWQDHJSdDQTay/QaRFsFRwy3smgWLQyiXnz852BS5DzKi/a1f95/MY/xn4CPcNce/A7L0Emh8ehZIcLZcenrjgFNlBRZQe3Igis/j/XNsQHfI9S3GR2jko4s1HIG9KigFheTpHW9wPOqw/emt8Yg/xSzkHyjl0FkvTp6DcpAaRolHcaBBo1Svn5Nv4DguXzQyDPHx1f/3woFprLoaHsb71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP0FIpwkuI3NoeDSZnbWg+e7oaw/7dzsfNSOWBklii8=;
 b=sgPnWr14clU938A3pI3LvnZB2s2ogS6Fbdgi6+jDO/Ng/x5XTH+Stq7aOg1Be/5G/sZ0cIZ19eTAz2hZCJ18Om6pNx6gpR3xZ8CzsCWzIXLmZwrxhf7FxprBYWTeUbDQxdKpqK2hlm8c3LyglW8maL3I80G3OEoH9PiBkS9enoQ=
Received: from BN6PR20CA0062.namprd20.prod.outlook.com (2603:10b6:404:151::24)
 by BN8PR12MB2948.namprd12.prod.outlook.com (2603:10b6:408:6d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 02:47:04 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::70) by BN6PR20CA0062.outlook.office365.com
 (2603:10b6:404:151::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Mon, 14 Mar 2022 02:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 02:47:04 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 13 Mar
 2022 21:47:01 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: reject secure submission on rings which don't
 support it
Date: Mon, 14 Mar 2022 10:46:48 +0800
Message-ID: <20220314024648.2201565-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27be910e-8a2c-4477-cdde-08da0564ec00
X-MS-TrafficTypeDiagnostic: BN8PR12MB2948:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB294841F4E41E6A68FF5FDEDCFB0F9@BN8PR12MB2948.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5/EF4eKBhnwzsRhHnA/msAeSEXNF3LrQyyZ00ZSJJMJZm7gTKmwYLLqo65xPU8RqqYcISKEhMNKJBdXD4gKr9RWXwsVKAubX6HJEXWDKDipmFJrT6POYmV3NFMLUdNvVLv5j2T+FnCZl3Sc607d8fJS3o8ieRJryxg8iDLXFt1ObU4gH54X904SmBJZfiud/9l+azgIoHrAEWmAMbFaynOTEeVenURKCrAQYOp2iwF8gxELBp74+hrZyN75BTxpym8qnlTnuJ3lR0tZ5jGtJ0C1BdbiRP4Rct7tJ3ooAqHLCAX87GhX8VSIkB8pseK62aGYQZoZL5uq2oAxyGY2RachFc6xR4NGqQ2n1rerJr4U34tCdVcFyNZdO7Hhecp3S9gBsh/U8G4uoZz1NqXFOw4W7bBiTcrRDz+dPVKOCYPrEutjdlYZcD6LpPoPXwSdkT+TM9wOI7KHcQlqW+mhVCwvnPEtLQEFjCzNi6V7ftLrlzOH6Z3luVogcfEiGckh0lpgkwqLzShfwX/nFCGkpyH3WCDo70Q18GPzNaxveEThlQg1G5fzTYpkEqA0/MVZ0yoRd5V+ouivAvJ6onvMAEkcwjyOiiEiwDP55tXeMUhVLOO0WBpTQhLLKFU2E8HTeM3n7btUaCsy6rrrisGuxEM3c8DHrY1y1z+SaMA+iddi+j4PVsjezoQ2/elYkQ2E0xics6Jf4STq7NNMcH4Qqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(186003)(81166007)(16526019)(426003)(356005)(336012)(2616005)(82310400004)(86362001)(6666004)(7696005)(2906002)(1076003)(508600001)(47076005)(70586007)(4326008)(8676002)(70206006)(5660300002)(36860700001)(36756003)(8936002)(83380400001)(54906003)(6916009)(40460700003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 02:47:04.0065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27be910e-8a2c-4477-cdde-08da0564ec00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2948
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only ring GFX, SDMA and VCN_DEC support secure submission at the moment.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bc1297dcdf97..840304691b92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -166,8 +166,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	}
 
 	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
-	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
-		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
+	    !amdgpu_ring_secure_submission_supported(ring)) {
+		dev_err(adev->dev, "secure submissions not supported on ring <%s>\n", ring->name);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a8bed1b47899..3afe3d60e194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -363,6 +363,14 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+static inline
+bool amdgpu_ring_secure_submission_supported(struct amdgpu_ring *ring)
+{
+	return (ring->funcs->type == AMDGPU_RING_TYPE_GFX ||
+		ring->funcs->type == AMDGPU_RING_TYPE_SDMA ||
+		ring->funcs->type == AMDGPU_RING_TYPE_VCN_DEC);
+}
+
 int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
-- 
2.25.1

