Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB1C77B73
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 09:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42A710E37A;
	Tue, 30 May 2023 09:52:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F44910E141
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 09:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTm97K1el5o9KHnd2Bng9kuwlZlVF54NsV0sfbN+uFSzexlLb7oLzDnYIAG+Jmp1aUr4RQZrQs9jP1OMSYAuBIyrHi6pNdz4SVPFpMyEgNLF3xposfyl5vVLM/wAXGbe5J00USx7QBho6erl4sy0lIsS0YRD6946SZ/Nv+D1gaQqP9t+Vv2hCHcEqmYKuq9jprillmiI4HtWE2vPckHHqlF5XZ7vGeuMmrNbNpZQaotC6rbrl2cd82G0UaAU91JWgQ0UWNIsCxJb7pfd5AHs7lnPsyC/IdUaqs6AcFQ56kNmh3HyWCZIjKmS8D18Ot//9wtV6zGxElGuKi4QCLzH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43u3c+CoF72bue9mzmXNPlDX0FbPm6W3O4rHXUh13hI=;
 b=f1+B+4ZiXXfLBlsTU2fRYz4NzelKTob5PkC4JnnG54Du5kU+SPVk6X8eb0GvlkQNNoq/d/SksC87VpW7AsWNZlS0oOAWV9o4IicaiWv2idUAkgmPQv13OHe2ZDdq4CIcW4D0lL+h0snua0+0k0TXA5Uoh6E/XUypMRJU9tOfCZEfvrOk4uAVk9cHByVrdVs1ATo0N5mDW4AqvTN1bkJYaTLjAxmCW4QLQUSB6VCKZuDMNBJ063uwlv1gLsfEAO6ZEB5XPHkxD0SC6stXVV2ftDYcIulZR1nL6uVs5cf7Eem8N0FYUXjiCTqYsZU+QLJuTldRLWErwOKkxwhefZ7Qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43u3c+CoF72bue9mzmXNPlDX0FbPm6W3O4rHXUh13hI=;
 b=qd+Es2A8u43ciKhSaeaYByhGjqoJl7qt8cjTQIZPI4wezrYYczb7zuGXiiMbmoyJv99E63KG8GNo15Y1K7tLadmmhrz3ZX67nQyeMm6NbYG867FnN1ZczGrz792olHYItCtJ8K2HdMaFFLAzG/48i76tmp2LLh+Zkfrfo2FBUkk=
Received: from SJ0PR03CA0127.namprd03.prod.outlook.com (2603:10b6:a03:33c::12)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 09:52:23 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::c9) by SJ0PR03CA0127.outlook.office365.com
 (2603:10b6:a03:33c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Tue, 30 May 2023 09:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 09:52:22 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 04:52:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 02:52:21 -0700
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 30 May 2023 04:52:19 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <james.zhu@amd.com>
Subject: [PATCH] drm/amdxcp: fix Makefile to build amdxcp module
Date: Tue, 30 May 2023 17:52:18 +0800
Message-ID: <20230530095218.418845-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d49156-44d5-42a8-a002-08db60f390ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaCMFD87KCKd7VHHxbSArvSF7svVo9+6wffU9D1PvfB3ZdX7zLRO1qjm7Whb+y0DbgnrlUVQFPBfugB5FdzWtwkDoXErBEY72uzuWlvvCxshNsy1iJz9D7uRFLS4NRtXnkHScivm0kPytXAgU0mpOfap4q56RErh0oYaUTiLP7LoXLlaSACAXDlRGbtl8Lvz4pvcc0VKIGOZmOxbkqyOiB60yCzLminizSUfkrAevu1ZOGmJVT1IioBRq49fAa8xpm0XRfiEYFvI/dx6gwFdk1I++TfQ9mSsrDpTw+XaEuNwYzZQDdFINBA+Z1uPO2wlHhcjNB2my7spUBvn3EBoKT+Et3eDErwt0iPOTy8MYtOK+uR1VQt7nN4ZTwV9+QOMFIYdErXq89jj2Omz5jt8bYUxmZgPIEnd1LFtzmLwyIBXEFc3twv0jWbpom/XPuWoVxuguZTFTGJxWPFdMmQ9t9xy8RTVdi2mi1FPlo6iUK2S0ZEuGYJYUIotTzJuu8Jmuzgd3hVQyviZj64+MN955KEObyj8L1hYv5krngLstqCzkidm3Q7klfc3WHev4OxSQivsFV1z7ORZIHHJ2Ov3aZ5UA2NfapiWic2nf/ceCbTjDiT9rrL/NNItyHlTP6BfFJ0nZ1/c8C6ym43bb7JjvCxSH1g164W33oXHNrhp86xbhpBRNWIHHEl6FdSjzmY02wTx1wTWAVQovpz7epQj5dNDKbcD/cUxxgw94GpDI4z4RGFjo4h9u49Q6wqXnm6Ypxy/NZOu65PAdq3MvWWAhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(316002)(41300700001)(81166007)(82740400003)(356005)(6636002)(4326008)(86362001)(4744005)(2906002)(82310400005)(8676002)(8936002)(7696005)(70586007)(70206006)(2616005)(110136005)(36756003)(54906003)(44832011)(1076003)(26005)(83380400001)(478600001)(66899021)(426003)(336012)(47076005)(40480700001)(5660300002)(186003)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:52:22.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d49156-44d5-42a8-a002-08db60f390ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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
Cc: guchun.chen@amd.com, asher.song@amd.com, Bob Zhou <bob.zhou@amd.com>,
 jun.ma2@amd.com, yuliang.shi@amd.com, flora.cui@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After drm conduct amdgpu Makefile, amdgpu.ko has been created
and "amdgpu-y +=" in amdxcp Makefile isn't used.
So modify amdgpu-y to amdxcp-y and build amdxcp module.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdxcp/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdxcp/Makefile b/drivers/gpu/drm/amd/amdxcp/Makefile
index 5e1bd70748d4..870501a4bb8c 100644
--- a/drivers/gpu/drm/amd/amdxcp/Makefile
+++ b/drivers/gpu/drm/amd/amdxcp/Makefile
@@ -20,6 +20,6 @@
 # OTHER DEALINGS IN THE SOFTWARE.
 #
 
-amdgpu-y := amdgpu_xcp_drv.o
+amdxcp-y := amdgpu_xcp_drv.o
 
-obj-$(CONFIG_DRM_AMDGPU) += amdgpu_xcp_drv.o
+obj-$(CONFIG_DRM_AMDGPU) += amdxcp.o
-- 
2.34.1

