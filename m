Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE31C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A26661262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A26661262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F146E8BE;
	Tue, 28 Sep 2021 16:43:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B76156E8BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG/iGgtFKIljf2Bz3GAcRFxGfA9bqOQjg9LD8S/BMwkyeU4TLJ0MvMbBi84+ahsKQcr7oHJblSkzqBSGWpMCBNM45Zx0IiZSvQyDq5kFdxrBgNpZVYuPLPVRznaCr0d494rnNRPETLd5PJgHtsnNv0JlSHuL58akCl0KVmuPE19KNhMeThU9iC8fueGX+7ZcMMDtLx38y2VucbE/AuVhSbhF5WDQp/tWhSfkFFi/31wFig2dnDihP2QLoY+w8cuSkh0ZeJSLNBrj+ki6MTqeqqt7wM3LaIPBWjoAD6horS7vehGQ18Dg9c2fnKPeRjwjX2hnsFqi/9CuyDXccQ6OTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nfiUy1jUt9qOQK6OxN61S/1OHI7eSRzWGtnhZoDSlEw=;
 b=dSZjy8dBG6s0Lwog2JAQnkLUF90m9RI8+5Trj645YwB2b9s7p3J7+k/65urFGK5plz++1MGjv63a50P6F85cOMkcZ3zYF3iX1B567iq5g3WhAKoZc7x+YAc1VqL4GkCxYnnvMa0jPlBvbivd/h2jmm8pFMxMoGlG5YanoV2M8YnrS1hP6r8ZrBr6qUrfeuhj6T1jbSEHo+k1CSseFVzXGAX46eCiznyYmDCFq9vrODq8qX7KGJLzdvctmnLlXK/4qIVcCeSoLB6jbR92cLeR0FI4oZt7AcigKQIYApRmCBgOZ+ygM/UzRL8zPJen1s7RyOU3lOgkQtalfIxOFQDJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfiUy1jUt9qOQK6OxN61S/1OHI7eSRzWGtnhZoDSlEw=;
 b=dysRwQNAAlhs/SiZT7WjuJmsXNAFMPv7BVzDJnM0hK1ZjhcVk9kTBnJ56yYAAggrChO7/guc7khgS0S/UwPqUhXKLu1+LsT0ONaowox716LWIRZemXYOm2++3TmqUTa8QqbmmU/hNhpqaFP6OFtQFzwjoynLH0YM6XCc4Ls9KNU=
Received: from DM5PR13CA0014.namprd13.prod.outlook.com (2603:10b6:3:23::24) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 16:43:56 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::22) by DM5PR13CA0014.outlook.office365.com
 (2603:10b6:3:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:43:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 15/64] drm/amdgpu: drive nav10 from the IP discovery table
Date: Tue, 28 Sep 2021 12:41:48 -0400
Message-ID: <20210928164237.833132-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3404aa1-e69a-41e3-3f51-08d9829f2987
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54935C400D96241B68045D86F7A89@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CedA5xyHUhXr4CJ2QQbUeM7yjTxy4sjKmqqs3t4CriI/TkJzdPhp4VMayyKu/u4DibEE9Vmo9jrDL+xkA8IiHgCvvd6NNCEDs4SV29E94Cxan8PyMKz6mHjqvtjB5J74Bocy/A/uCneUiEv/RIMScFVQvgmfxxtHCqcxPx5X7XK3atrZBn8wYysEw4bIgBxtgQzfqIVJTA9pkw7HBarRS4fnTpVWgaljU/Xc/5oD/HY8MtvP1SeDG28OuyNYsTAnQNhv6Vzm+AWg3e1L0V1YnvcL7gaH9QRYFm7KmE7mtauPPdv8sgPOAiopgARc4gxvFdVULucbLVHU0yNCZo1JTXZuh/IZLqvqq8nYc3Ig9/ks7hhlqxm+eEJpw9V2vd/Gort6JWfzEBHdI83RkbnI11LIF6V+5kkZ4b1mY+ROV8pO0/0+wcPxLEDKqZoGhCMDa0m1PIngpZsgrBhUAMUm9So4hfkRJCY1WpwWus6MPgjHzxlpWjXzqY/8hedipqcMuBdS9cz3URowWyoDKZVRcGkOlzcKC4Iz3zJZMpQTDiY2Pv/I6U2vWojp0o4GuIdQSIh5e3AtWkIyX7fXaByhUmUslMK/cvgceh1MZsvKL2LBRIPFVlLwTgaqhZN/36UFlLgB4rCdpyukygNqddharF3sHZpmzflvBQFu20M5PxHfrdcetpRFIezwUYtSVvul7B3SqtqkRbD3UPE2WOU2GMVOfc2sbZCz+nUiR4iFHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(26005)(6916009)(16526019)(86362001)(356005)(2616005)(36756003)(83380400001)(66574015)(4326008)(336012)(81166007)(1076003)(316002)(426003)(5660300002)(54906003)(4744005)(47076005)(8936002)(186003)(70586007)(70206006)(7696005)(82310400003)(36860700001)(508600001)(6666004)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:55.6976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3404aa1-e69a-41e3-3f51-08d9829f2987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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

Rather than hardcoding based on asic_type, use the IP
discovery table to configure the driver.

Only tested on Navi10 so far.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cf916d4f4e9a..5e0956b19d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2142,7 +2142,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
-	case  CHIP_NAVI10:
 	case  CHIP_NAVI14:
 	case  CHIP_NAVI12:
 	case  CHIP_SIENNA_CICHLID:
-- 
2.31.1

