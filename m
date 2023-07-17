Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66391EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 02:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B2810E122;
	Mon, 17 Jul 2023 02:26:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E91A10E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 02:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMYD/iRPDLqnbCoItpBMXtM452orBRuLjqYdgVBkkG2sgxHdWlwjxpVKZcCfeMcK841ZNl8z9yq4569s76aY6J6maL+M9+Ufp3lSRQ55MKvZi6G5WrQQ1GC8iVGT+XE3yL7D1WceqKTQk1dAjWk3HHx/fPPQ9BLhb2+CEw4ktSZzLuk8RnhmzvvKc5xb+FN1FnXtSfi+VrRwyu+j7eBRIcWb4hN4UHZ1JuZEJHWPQgFQ1DU6/SmWk5AgBwzjp2f6FV7ui1nuQldVFN+SqZhoMfMQ8s9EibkvmNacexDru98RjFFdzkLfaQznoaJJ/9Pc+BInwdxwbIRZghHgT/cSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYufTGDY3g90HarOFnNCbYc6ygYAkelNihBEmK3OSPg=;
 b=oHiSE2WOZzZKg5zb3xpQ3y0ao/oYcK04Hw2ZHVTsglfhmpcnWW2MptFCgg+9vuzvmyd6Eyy7iRVuMnWsAwLiaptEL11LPH6VtoUsHp5Aq+RCUW/5j4JkdP/v4VESad9xCVpTkF4xs2Qnu8I/m4JFB6h+OYYOEaHMhrjpCn+OsC1yxW7ki2lKPqUlgqR5LF6vhqZOzcb5YEIL8p959l2wuFlQNgF2dEa1mzMf8rQPM0mm7pH4vEAMCcPbYbmOCb1+HX/BuaUgHR7WE7d4GuMieqFMFkrnc8Gek8V4eW6LEzBdQA1fQiHSv6BPpfgS3kNzJ2p8KFCtGjHC3FHTGhtS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYufTGDY3g90HarOFnNCbYc6ygYAkelNihBEmK3OSPg=;
 b=bSo4jHPWKZFR1TqHSzpRpcF6YO8VXOJIlYwlvBESPH+IdqR0xWUf1nB2fSgg+TmRCuMzUjxX3/bF8spGvyLwJ6ymQ3qt2Kw6juamUZCX0IBUes0nhAa2eUQnfZ23uTbm5C/PP0yY+8p5NElpmo/+PcpjttH8V1ARufXjuVoDKtY=
Received: from BN9PR03CA0561.namprd03.prod.outlook.com (2603:10b6:408:138::26)
 by CH0PR12MB5155.namprd12.prod.outlook.com (2603:10b6:610:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 02:26:37 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::fd) by BN9PR03CA0561.outlook.office365.com
 (2603:10b6:408:138::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 02:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 02:26:36 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 16 Jul 2023 21:26:33 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Allocate root PD on correct partition
Date: Mon, 17 Jul 2023 10:26:16 +0800
Message-ID: <20230717022619.3833601-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|CH0PR12MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a8bce4-84a0-4685-d224-08db866d3ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OK+G5zFxcM/RyYSmUsQtZHWVSombN1LitBMWYJJZoOvGMHzg+mrWUMmtUN+VrMKDJFZEgckg58lUrNslYBsvNxI91ceu74x1SVWY2/wPfMjL425tqMYTttXYp4gc+Q6S1xBU45XjiMQ7pM+a70zP+uwp+DZTP6DwxNkIS+OtVUnl+5gwNMwopeIQrCqalU1F7gA+No7Lt9RkHcFiLdzOEndbEzWQAYshsSmhGcXW5F6Zz/qeUjg9eUlJhzDRyNEkqAlqmcYpXDyOCJe4PX0HnoRc0GCvqRI0xfHx68lXOCphcSvy+nXHCGb1CYjD1ZPJ9Q0dte6NJeXu8KAie4HRaRM+U15/HI0ejcrtxZ4OMBR9Pe0mDzv49Ef8BeSesNGrJW/BWoXd/SI2ISNd9BQzIl99s0XIW7M/X/Tkm5gaYDfbFOq/ftl9r7IeytQ02Nv0jRNhtPznNK5qvd7PjYaY53K2on2THub5hjLy+CjCbXiEmbpiPXdEmwrE3DS6NIurHJsn7DENl+JPBPxMzWWmo14o/sRFECwbvs3QUAYCbm/CzADvBdT8Kha4UyPQ8sdYtm71EYrJmTaaE5wFQEjwK1OmJloy4zsWeJdy4W0m0S2iPpK2t0WP94e65wStVrX2STM26nd4PK5+VtoyZCirfWeEZJrA9GvBcQ8OkV/fJ6Y8muR1sRjdXb0cMy1h8Jz1WSrR+0GlxuC85CIC7tACmOLtCilnHr7SZkPSBVX5c9tMUmQgXhw8UVMTog9+iEwSRKqWe+5rrZ2nH8QBoHtICcK7DdpsTc4tZj2oOjraKr8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(6666004)(110136005)(82740400003)(356005)(81166007)(7696005)(478600001)(41300700001)(5660300002)(8936002)(8676002)(316002)(6636002)(70586007)(4326008)(70206006)(2616005)(16526019)(336012)(426003)(36860700001)(186003)(83380400001)(47076005)(1076003)(26005)(86362001)(36756003)(44832011)(4744005)(2906002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 02:26:36.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a8bce4-84a0-4685-d224-08db866d3ec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5155
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

file_priv needs to be setup firstly, otherwise, root PD
will always be allocated on partition 0, even if opening
the device from other partitions.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 85a0d5f419c8..53a024cf0544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1232,13 +1232,13 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		pasid = 0;
 	}
 
-	r = amdgpu_vm_init(adev, &fpriv->vm);
+	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
 	if (r)
 		goto error_pasid;
 
-	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
+	r = amdgpu_vm_init(adev, &fpriv->vm);
 	if (r)
-		goto error_vm;
+		goto error_pasid;
 
 	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
 	if (r)
-- 
2.25.1

