Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41E0C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B90610E3EB;
	Tue,  9 May 2023 22:14:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE53D10E3EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8eO6uqBAEvBe1iOjQbmaYu5RUsY/Y8wbJJMVjIARiKBTtKn5L/Bjo3kYFBYTtUZnM6ASH6OZsN8OMuRfPi9DBwc5g5nOijobco6SaVOrcXqGWy1MJvPms7RdjDPRciwAn90smyY8S7RTrT0bbnzalJ3AH153uElCatxxkI/e3uXXdnyIzQcaPdPGUKHQfrk13+qJ0CAdvOx9mUs+Foji52L4RQ9qL65jaxF07gEujF2HdTayFMnMI2WH0PnivmXlkOBWkq5cRnsl05ghq8B3miSBFmBAjUMHcrpCO5hBD0pDmHLjvEtdUD1RQIADRCDclNGBXba+IEZPSQtqduDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmH6T4LwfsQOXXGzhzk0alJAhImIwMsbdTx0M9mKJpM=;
 b=T/Aqv8ciDFzsjLh3umHWo3FzojpoGczmCwxbMV0eRgeUoGyUpz0SRB8KAjFYqklI5HXaOBJA3q5RlLI7Mds2PdcDmQMSekb3IVKEV0zZ6zdzCLzjIb9lqoNiZJz3uxhmaGdsx9QfiK7WLPgMVD0sDVX4MBpVPx0wRZLRZ9bqZuX9Oo29+CcKvJVo5Ywdodf13kECm+nmHUQjSypgokYLNkskNxTFUsu7Nhh+stB5KygtJ53m9HS5e7LuA0EtWxrYIvlAFzplykDX4WIgKIkT0nte128HreKsXYOcHl3pFWOzb6Mixz4T6mWa6Hnvq7NhwF0YXAQLddAqLmZlTiTkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmH6T4LwfsQOXXGzhzk0alJAhImIwMsbdTx0M9mKJpM=;
 b=BeY72JRzC2lL6qeK7vcO2Ex3igY/jixLgpiEAwOo0mh4vvSUpwV1DRgjkikybJNLzNDjvouUVKqDvNUA/e2m+tIp5NU915nZJFA9gYz1wERrQU0fSycx6yZDwP9IRZU8JNOdmTvQGWsYKw8MpXiL3+n6oT3XukVDKTuXvVAaBMI=
Received: from BN9PR03CA0058.namprd03.prod.outlook.com (2603:10b6:408:fb::33)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:27 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::3c) by BN9PR03CA0058.outlook.office365.com
 (2603:10b6:408:fb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amdgpu: Add callback to fill xcp memory id
Date: Tue, 9 May 2023 18:14:02 -0400
Message-ID: <20230509221408.476829-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: c640aa0a-8339-42e0-52d5-08db50dac0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eX73SwVqDG4004r7Mrm/zQbspOt6XT8JLphtY9G9iYKgOFeOJjRsM8aEGdRDq8dDedXllLEJkChCEy2Y07ZVAwrG6Pm0b3vPPTiC0ow/+i4Q4vjl5kdR9L2WGMhI2veB9xJeNlkz12tibu0i8fNKK+0YgmPDZvfsVjAMQecuyGzO3HXvu03MNa5bOl3IUJPPsOrOGlwLGgaZJtxrkMjXXHEKqgKV4j5QhLOiE16JpM8kxD3ZwHUEK7/7tf1swTW2PUm0Q+rrK+bUExN2kUMbXbl8moIvDV7CaxvvhWhusDyndPHhjvjay9uiR9CmVDuVAtQoSY9JtuLCWlVN3X3L1SsNC8aFRJD5xYCTdThG8xbni6fIFjUEJY7ciotrKg47lGF+bC2dPib7Y6RRuV1kM2EAuSbwlPrzLnCRnUfjNIMLKs+8SqskzVwwaC4YlBeiFuJRoelvM+i6He9I7kVpP1IY9RApNpc0L/RlYOqgT9RVHMvCpoieUUqhuGGEr3jwW00r9d39ZkW1IHWuwsSyS1ZAUclgF8yLHknGlRXekNZ4++UpZ62pBBAlf3JN7Ft0u2z1pLzopgHi1XneNu+4BCmNGq9SMpzbSXFiwYG3FZS//Oy38SG4BNW3naFf9UXRMXtHd6N5sw7aOjfjY5XXcknfuD2rTW7VCAPOQ5zQebiY52j+JruQQohzkWVbGrU8bPO5TDjt1FT9lEjyNnJC6Ukw0raoSxEB9VIhYgobm3U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(83380400001)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:26.9707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c640aa0a-8339-42e0-52d5-08db50dac0c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Add callback in xcp interface to fill xcp memory id information. Memory
id is used to identify the range/partition of an XCP from the available
memory partitions in device. Also, fill the id information.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 337d558a3145..e1d3727036a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -116,6 +116,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 static int __amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps)
 {
 	struct amdgpu_xcp_ip ip;
+	uint8_t mem_id;
 	int i, j, ret;
 
 	for (i = 0; i < MAX_XCP; ++i)
@@ -130,6 +131,17 @@ static int __amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps)
 
 			__amdgpu_xcp_add_block(xcp_mgr, i, &ip);
 		}
+
+		xcp_mgr->xcp[i].id = i;
+
+		if (xcp_mgr->funcs->get_xcp_mem_id) {
+			ret = xcp_mgr->funcs->get_xcp_mem_id(
+				xcp_mgr, &xcp_mgr->xcp[i], &mem_id);
+			if (ret)
+				continue;
+			else
+				xcp_mgr->xcp[i].mem_id = mem_id;
+		}
 	}
 
 	xcp_mgr->num_xcps = num_xcps;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 45d590d7fd95..7e7e458d307e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -68,7 +68,7 @@ struct amdgpu_xcp {
 	struct amdgpu_xcp_ip ip[AMDGPU_XCP_MAX_BLOCKS];
 
 	uint8_t id;
-	uint8_t mem_node;
+	uint8_t mem_id;
 	bool valid;
 };
 
@@ -89,6 +89,8 @@ struct amdgpu_xcp_mgr_funcs {
 	int (*get_ip_details)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 			      enum AMDGPU_XCP_IP_BLOCK ip_id,
 			      struct amdgpu_xcp_ip *ip);
+	int (*get_xcp_mem_id)(struct amdgpu_xcp_mgr *xcp_mgr,
+			      struct amdgpu_xcp *xcp, uint8_t *mem_id);
 
 	int (*prepare_suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 	int (*suspend)(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
-- 
2.40.1

