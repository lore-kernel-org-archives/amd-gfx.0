Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83762E8FDD7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 07:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F05F10E33D;
	Wed,  4 Oct 2023 07:40:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8186210E33D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 07:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBQw7C2b6rH2tsAaV/8N3gROwoaa+cfItuVIVpnIeyE+cS5EneiU188l+7DFG4/pjmNqLQhTfLcibfAsiM+1btoB/sOuZY8xEOefFsVady74Zy6gkdw+7pZvvh2/JA3yD9AnoCAf5qunHWwZDtr2Eb3FL0S2L6bmd4X9M5OiiHwGCM6qHwA1tD2Ef/dVls1U83RGRSwShYi+mXoG/OdpQ7JwKlzHLsrBKVRJOXdeJKPwDQHN2Ql87WGZXKLBXzjoeERYt5lQPjg3IS5nZev7rtdhcOuDfeY+zWQCuktnnCw3XFh8pLImMzeaOzbgC3dnkFiB1RdkQHWNCrQnlBU9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnXL/jh86HtxdacKt8Yl1ovn5sA2NTEIreNzcltmIBc=;
 b=HurfN2kxz+Oc0fLai2KC/f2BLZ8PkQ5szuIMgWiL8/9kaMZ58AUHRKtWWVDrMac9ceVVooi1djM2KRJmjJf1zi2G2dbkMMtABBcrRNKirrt/ZK6ZebQFypICyOJD6PIa3Wppkg0lMt8bOporD926gMQYSNxMcjlOrP7LlFFtgSJZq7d7FsN7tLul4AN+gyBb13GLEziYEi7bnSrUaKRuCieXYLT6+nwwID1k57QIWoIZnbSfly/jZ5M22tCqeuRjM32MoSmsvxC31aVcc52GDgKeFWV5ENki7Vnk2PTnN+Z4h+ZomjpqToYCuvi3LgjE2Xn8nuX4wq5XozcMVFAKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnXL/jh86HtxdacKt8Yl1ovn5sA2NTEIreNzcltmIBc=;
 b=vMvLBYzZhCBVGqTPz9vjgX6MBPf1xe05YuIjqAvCYvJ6k+8PfO4e5VKAKFLNUWgA99+nPq7L4RpMoUxALjmywTg2X7BqcXC/0rysZg6TiTTsmZIb6W/meilhsz48+EbnpGdhi+vJvd9VoUzOEPn6dFKFEi96pgMc0LyKLYUsrtQ=
Received: from DM6PR18CA0019.namprd18.prod.outlook.com (2603:10b6:5:15b::32)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 07:40:01 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::b4) by DM6PR18CA0019.outlook.office365.com
 (2603:10b6:5:15b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 07:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 07:40:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:39:59 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/5] drm/amdgpu: Add more smuio v13.0.3 package types
Date: Wed, 4 Oct 2023 13:09:38 +0530
Message-ID: <20231004073941.1489693-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004073941.1489693-1-lijo.lazar@amd.com>
References: <20231004073941.1489693-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2f7e36-234d-40c8-cb79-08dbc4ad1df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QdWDqc2p1XgfJN+021nWknuOhlZWV4FXZdbcYC2JtvrPvumeSJxMI7bhFrPQPJwMgcsOJd3MfP1l42nf36CVjyV1Z+E0Gm6XZMe4hP3Pb3J60vp2iU9hYYhDp+scJWXuMxvhms9ZS5WhASagVVsG25HgKq3bJF56eERKv09hpPxto4pcSQkq8wk9sN6Z9C/D8SkW4sduLKKzLxdw9UnMeoNCLv2/5kZgR0GEkf0yXMP7Q6C5Hb2e5yFjTb7PGoacofVoU5p1a19+mBib80aNmi26RQI786A+czOGK38PMFAs6FdPtvb8sg1SC4US1WnRrQ/QASnK8hWH/n2JshZs/th3cjN0DCJToSNQPXMaoMCPfOP2jdpnFY5OtlpbDEEgnP9GfLK5r5KkqrviRAnS46tLqQ8pdn7Eyr5QZNq+Xn7fqn1TMlIufyP4G+vsorOSnjugJW855wUDWwLN9g62iGj19OmF+66hDU1qaunbL/r2en/cI258wwrVGUaPP2Vl0ZRcllddYXz7cb9npiuYe6kFRVHbkYEFi9OWlgJcHbOG1ZW0RJ2iD65AP1O6xdDUvkHzdc03D99n6eBSq0EYTDQwpCg3QZIQAtj40lvkVxlwEi/dFKniYjfJ2m833SM+ztjm7sFD38KWpwgrNCvSCm6r4IioqWKjfV6y+lTLJg6+ALKync5rJdF8aOtTYNBwlA3II3FaGLfffiHA4J9ghgQHYTiKhvpsWQnJIOIYw/p6J8cmZpV5PDpTLZi1KIJKLhOeFkyKnzedCrkQycb9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(426003)(2616005)(478600001)(7696005)(54906003)(8676002)(6666004)(26005)(8936002)(41300700001)(47076005)(4744005)(316002)(70206006)(44832011)(70586007)(5660300002)(6916009)(4326008)(2906002)(40460700003)(36756003)(16526019)(356005)(336012)(36860700001)(86362001)(81166007)(40480700001)(1076003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 07:40:01.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2f7e36-234d-40c8-cb79-08dbc4ad1df1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expand support to get other board types like OAM or CEM.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
index 4368a5891eeb..5461b5289793 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v13_0_3.c
@@ -84,6 +84,12 @@ static enum amdgpu_pkg_type smuio_v13_0_3_get_pkg_type(struct amdgpu_device *ade
 	 * b0100 - b1111 - Reserved
 	 */
 	switch (data & PKG_TYPE_MASK) {
+	case 0x0:
+		pkg_type = AMDGPU_PKG_TYPE_CEM;
+		break;
+	case 0x1:
+		pkg_type = AMDGPU_PKG_TYPE_OAM;
+		break;
 	case 0x2:
 		pkg_type = AMDGPU_PKG_TYPE_APU;
 		break;
-- 
2.25.1

