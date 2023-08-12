Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33951C001B0
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 14:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9225310E02D;
	Sat, 12 Aug 2023 14:48:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9748310E02D
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 14:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUTX6bWA5tIPKksd6zdiimeeq1taSDILGhj73Tykg+TwAoSVnn7x2G6gqkB1HHtCLa6dlNsdXTWUOmL+V899r5rVzhRk4+RAgnyGuLrwznN2ZhMG4yRnpyPUOjOHmNifQX7Q8M71eJ/uio7UMeIOZT+tc+nFCRg/oWKipznhdw32UAf0l/u7cnXEvqVAVO4DtgnWl+PiSQGTjjKlmXMEJPCMHFFAqxL2W/ojN5bU33i739quGBjXqwQDC8eqPobWti1pBECkzRBF2DVWpUQtq0gmaSSBi5lF1PWzk2ajdYwMjBUKi2vVFUtnPwbRztbqgMgHXxr9kWyxQ02B47c71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ4d3UjpBcVKRBqgNq0qNWSSYsdJtRyCVOw43yMpnVw=;
 b=CbE45b+GDgeDKQKt6HksvLYEW40P4IPt/ehys11DkFGJH91R/5kz+MHzc41X2CsktrgpOIdGlySzf13fMuyZWIkbNtV04FCNSj4GlhND/rTQmt4Hx6rq/oVzHakKtybMcAtcp10bu2U5MElkSGPg+VtPqh3DYT7F01Ppk57hijzKeKCXdgpEIVXIyq/s3frT1i7QJhqqajbCy89FdFHJcJW0Y0uXMQ/UpnM6LnevhnkqazyGHXYSoH5dVROpDkErJCCTnDnLPNbmXyMJ3S4a9YUZWQr6Jq0ddA8AGJmMYpWAzvNOadBLZ8IEzf0hDVpyytLjDMGrCnoGl+Hbdxtj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ4d3UjpBcVKRBqgNq0qNWSSYsdJtRyCVOw43yMpnVw=;
 b=H7jmQf7oG5A8S9XF7vh/5dVzbvu7t/YKLw40RdOTG9nEQDBcAZtZzC3Fkla5tH/P4iugp6XvH7FIS5YEhxzA4s8MXHWzwQWvli0m80mQ6Tsdd9Pc2LwJjVCUlYGtMVtCElIWJ5lu9rFEmPSCli3us1zQU8LaKDnX22SWG9pSy7o=
Received: from DS7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:8:54::32) by
 PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Sat, 12 Aug
 2023 14:47:55 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::ba) by DS7PR06CA0050.outlook.office365.com
 (2603:10b6:8:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sat, 12 Aug 2023 14:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.22 via Frontend Transport; Sat, 12 Aug 2023 14:47:54 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 09:47:52 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>, "Pan
 Xinhui" <Xinhui.Pan@amd.com>
Subject: [PATCH] drm/amdgpu: Replace ternary operator with min() in
 'amdgpu_iomem_read'
Date: Sat, 12 Aug 2023 20:17:24 +0530
Message-ID: <20230812144724.468189-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 595e1e18-5a9a-49b8-bdd7-08db9b431ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXllC+Fk64+6Fhb7j/6rLqJOS7/tlR9bUcVvWl3GbsrzY1FXJ+s05yl0l1W5FKVZ+BVbD45/5hBeKQIU+QKcMOttGb/d/MzQS7Cn8zvkFd6Qz5lbXiOB6RRv7RhNbg5F8VeBCchDHjBP4cQVdB5Cna1Zz+3DK87K4U07H9+5WRwV9hdHi6vlthB+qZfz+yZ6ra8pxPrFOFty1zuoATWVBbBvKECTssu05wTc8e+k/MIZl+H1dMwuImzDH/9pH9dKZ8nFlTNHDYY2zmNsqgBBBm8ekLmydh5luyLLyTYOTBpQmnVYrF4C47fuSow019xXwQmnOCUM6JHgyuxcVaWgbExwMJES+58qFe6nagW6AC2w7n6EfCADkPRIPjisSh2/sSgumUoXHde0I3+s8X6nw3PQKJK1juE+cMqpiltfT3mwlINhQ4t1Bf6dfByz8F7B4MHBFStf/pROzzeijpDKD3yb8Q7j4q4pvTnvx1S+OdNaMWlKrNkPeX07nVD/eLgeeI2G5SdJnzveW1vZ1RXdFYYHtUYRZM74w7JayTleETArOJur+1dxFJqQhF9WxMzgGTA1Qkvu3DQD9sfnY1J8SGrIZYynMR0c0gUBtzaZq+3QYt9Pb6WqespFkPg8ObEHsAypUetCfF6t8wRkPbSbJ/1KtusjJYx6XX/w4Azpt676yDJ+PrEP46iirIsdcSKUG80fbnMBmJjXAnWvvLMjLnswYBj42/xSb7UbgwHhSokHvDaxjPzZ9O2fs/qzviaoZ6oPCMAGRuuo5SZbdns/MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(186006)(1800799006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(41300700001)(70206006)(4326008)(8936002)(6636002)(70586007)(8676002)(81166007)(5660300002)(316002)(356005)(36860700001)(44832011)(54906003)(110136005)(40460700003)(83380400001)(47076005)(7696005)(6666004)(86362001)(478600001)(40480700001)(2616005)(66574015)(426003)(1076003)(336012)(36756003)(26005)(2906002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 14:47:54.7973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595e1e18-5a9a-49b8-bdd7-08db9b431ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2427:16-17: WARNING opportunity for min()

min() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index df32785a8b36..c03fe7ee555b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2424,7 +2424,7 @@ static ssize_t amdgpu_iomem_read(struct file *f, char __user *buf,
 		struct page *p;
 		void *ptr;
 
-		bytes = bytes < size ? bytes : size;
+		bytes = min(bytes, size);
 
 		/* Translate the bus address to a physical address.  If
 		 * the domain is NULL it means there is no IOMMU active
-- 
2.25.1

