Return-Path: <SRS0=Ip3g=OV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F66C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 17:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F0361A40
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Oct 2021 17:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09F0361A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7B46EE64;
	Fri,  1 Oct 2021 17:24:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626F16EE64
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Oct 2021 17:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z33UAgCqJcMqcSy8WEd41tprSGEP8qsh8wKeuaHCzEgspGXnKTG7pijcm6ACJnNxJaTxBwwF/Kyi1zIy0rZVGRMCB2ghgeu7tkyxEbiqaDj8idPU/NvOgU3hDDwnfA/Ce29HPLiIw+f803NZveuoOuu/9GULmIrP3X7SdXOCpn+mmkB2iKWEuRr7+HQtMkrWRUfB1NjBfHX2m+Eqjo5AFBRJT1/obYHentSUpoavJAYZ2wqhR4NOcq1VtEOIucB7UvMQOlMsvxklu2oKNxSZFiey0o1PZs1QAPo9DLLuckESAll60heJJbitCTwrk45OTosdayBb1HqTQ6VbuMtYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5Q+fbS48ozlX32dnkzY3JQQ0wy27Z14Q9xwZHpRcik=;
 b=icDxnAIN5vdpCWAC4zf3CR1NDze4jGDJ90yNLaxX/i0JK2/LYrLFXUSdCnFmWgVTF3XhjOCUfGpTNFGFeg6DN+apb712sRQe8caO3FFCSh0/iOK1LXNlHXm48IVBewla5nqkU0EPsR+EyEd7N/qkUAGrijCRw6t9sL65Ysm0hEuOtRs3hMw4cMt6qu2gyXy/DDmRy7yjApceYtSrnVOBuv1rdv0SgQdMbPOd6MBTrwowxZ14oMNoMP8FHLnilkF3d0rXMKsJZY3Z4Lymw/dLr0KHFKyGKc2RKhTYb4qjh3siM2USKDtZzYHywzBaF7UXHciPHWIaVJAUCkSGh/RqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5Q+fbS48ozlX32dnkzY3JQQ0wy27Z14Q9xwZHpRcik=;
 b=4apqvGXP+Pp+UGJO7MdnGqconBiMHw7FUpE2a0Qolsoln8f3uzdylG5rKCYoOnFuYu//BsqXhF82ekyMm5Kktu/pKxzTdxLnjzImJP9FJEaId6JByd4Qzg3peafgeVSQ24q540uiP4YzxWw0D6mkJ1X2WQiDrN98NHrv+qy2yw8=
Received: from DM6PR12CA0001.namprd12.prod.outlook.com (2603:10b6:5:1c0::14)
 by DM5PR1201MB2523.namprd12.prod.outlook.com (2603:10b6:3:e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 17:24:26 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::1c) by DM6PR12CA0001.outlook.office365.com
 (2603:10b6:5:1c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Fri, 1 Oct 2021 17:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Fri, 1 Oct 2021 17:24:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 1 Oct 2021
 12:24:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add missing case for HDP for renoir
Date: Fri, 1 Oct 2021 13:24:13 -0400
Message-ID: <20211001172413.1014287-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcd1ccc-54b1-48a6-1c16-08d98500514d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2523:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2523F12FCB1BD8E3CA3F9C39F7AB9@DM5PR1201MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKdgwQ0+W17Db71k4uoM4nqopKFrJi0WFr2RGlUUsYtaHVD9qNkzkkvcG4wBJxWEQpnrVV0Su7NAHOvkkVTc5irQch4JhG7WUu/Ma5KTaWBu9+SzXsBU+e2ECkSIiwh2GbAoeOLkvJSOaW1FiQu6Bs/dt4zMA072K+QDq+HSFxamBzsmLxMQ2oZ5egqBwIXGvofh6eLxAjMDe9gigZl+io71cqKXqSE8Xp9rGfPKPX0Lw1exY+cEZ32qEGfZzBxR2O3tn6njlH78JNKI2FOHDRP9qA/bgOOQSgBYGdQz4XDGZnpLdNv69I11qDpUQWlKNK9KyHfSPXMIZLUPSw52n2WUbig11w7nS3eBv/xMrZN1lJkgPpu23CCyO4r2aBe4hQqxtKQAY/vkjO45/0PvmhRF5e3lb1NdfWrj5wMt3Abgga0+p2SRFQPlt0AvQ99J/at9zx3Xn2aeq32O028GF2CQ4snh3nF225U4nt2/jHLAssxdt1SEH6qh830WDXroSOsieddtAm3e/RQMlsrSwby1Ci9gWrD0A/Mldn1qwRe0TKFURxEanG4uELTREag//aUvOIhV1bjv4qYLciVP4IAagHKr4OTQNXzwzcx/eB1Wi4+9OuiJYIVb895bXjsoMaCsLHvBZ8FC94FBc10N/3GFHyyusQCAmPz9qLBBTlIcY5d0iV0s4fsO9bzwaec3oYeCgPDsI2P4rC7AjqiJwzBigUgy4rSeo+S06WAKM6w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(82310400003)(5660300002)(4326008)(6916009)(6666004)(356005)(83380400001)(16526019)(7696005)(81166007)(36756003)(8676002)(47076005)(36860700001)(336012)(4744005)(70586007)(2616005)(86362001)(26005)(316002)(1076003)(508600001)(2906002)(70206006)(8936002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 17:24:25.9349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcd1ccc-54b1-48a6-1c16-08d98500514d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2523
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

Missing 4.1.2.

Fixes: 30bce8c7213829 ("drm/amdgpu: add initial IP discovery support for vega based parts")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 291a47f7992a..eca5515c34b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1151,6 +1151,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 1, 0):
 	case IP_VERSION(4, 1, 1):
+	case IP_VERSION(4, 1, 2):
 	case IP_VERSION(4, 2, 0):
 	case IP_VERSION(4, 2, 1):
 	case IP_VERSION(4, 4, 0):
-- 
2.31.1

