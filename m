Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6D4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB28710E1F2;
	Thu, 13 Jan 2022 07:35:30 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8116E10E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1gQnw5BoBVikeIbuXwjxnhzDmFaqztK3bcborzB3CS7ppvoyOif7LLVrIymT1IcrfDF3bMk8TWARoL1KEFs0wO/6L1FFD2XwDNNivlA3UEzzxc7ntmJVjhWXAibnSJo/AdsIgvMt8uUwJpP5zs1plUXjMv4g9ZsY8NGNW+a9PMo8GLLGxf8Gv6x8rHXQM56BOtEUTDgmN0UyjWz2RMrKZHKwMY9tdBkN9F1afLBi0ZaIC/tX6GSU0bC4isNoIqrp5WQa9BueGz3ISFKrSfn1bvxHe4iz70VrLNxh6Y2HXoUCd8YqS2pkHm0QOwq3im4tSWVzZduzBBcZYT9kY28gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dXxNrNj3PyYquvwjVmnfGdjHFJY3n05L2mbnxYc6Kg=;
 b=acwnvdHUyvF/Jo3iTWHqfk861KDdPt4bTyYq5XrB22XyYMKb6AlgcYzDUvj829KGJnAr8xE++y49fTAjaSIfmVQxllxscUopmdl9QoVTNvvCHLndRcp/S3TyYeHeU48dxfTNbsb+8tJ07G5uyStDaiEhDJPph+GQsoIAlcz9LKT7GpadmsaUekgGeLUgiJlSx9Jq4EJO5q8KkQbsxdKG6nashsGMSfCLbsFRE8NJKq3uNktCXGlbIGd1PUxVsI+kNJl0CtEeLMLkxrUlCb+24Snb/NpErn8VAykw4RVKUjOaJZdlGPMfYCyNgtnvuUBQMLwZ29BVNxzrqGWGVnn7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dXxNrNj3PyYquvwjVmnfGdjHFJY3n05L2mbnxYc6Kg=;
 b=1hGqy549VDSFba6GU+2HDPptPE09gbNGtLJx+uCwjeQ+V3S0mAEqBtYqVdOB8y9P4z9n7g8DfiN2NytCPrf19aW/DA+jqvVd2ZCLxlcNhYN30vIhY2jtzJb0r9YY4Z1XE2ZehREEOw3YcS7nrrgPZX2Mvw5zH9Sm0kg5d6PHVo0=
Received: from CO2PR04CA0199.namprd04.prod.outlook.com (2603:10b6:104:5::29)
 by BYAPR12MB3047.namprd12.prod.outlook.com (2603:10b6:a03:d9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 07:35:24 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::a7) by CO2PR04CA0199.outlook.office365.com
 (2603:10b6:104:5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 07:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 07:35:22 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 01:35:19 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Use ARRAY_SIZE to get array length
Date: Thu, 13 Jan 2022 15:34:35 +0800
Message-ID: <20220113073437.3140364-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aeacdba-0808-44bf-c204-08d9d66741e9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3047:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3047F64E1840260602D79096FC539@BYAPR12MB3047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:239;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rf/lCpdzn/BfH0IVpcSUIfG2RIrWwEr2ryD0PDIyiIzlLK0w8yNcO3/A0vO4uVzN13cJVJWN9TVIPRdru9FJd3BEKUWjvAKUjaFHjoZREgOQUNl6KNGCV8Il0Z7qS//SRpzCTA5edi9jfQDeTWxedB80boTHBDLOJsRaqPw67MyUAa5CpbUX/a9WtZa2//WD/axiX6MoDiwLcGN7guA27dMoE8fimDgT2t4P3iKSfP/McpoceaJsvP70U48s+hpAZjEHGMptWlPN9PHpdWvz92bkXNmKf86GrcHZeIebQsaL+nSDzBH9WxrQPBgUMJIwg9V9fN4HQ1SBHjaO6bTGbu4q63Y9ztafy+eCqcow9Gz9uIUyDnu4qfVe4nd82DbJC7XqTM1vHE7XzHBLUDabEybhR7SiIE02g81suxzpAcqhBDZu0hOknYogMasclaPmSdqqhhfNFTkkrgFxl+wr2G+iJvKHFHidi62qtOfcy+tQXxdp0l2VO45ieVh0ORa4bmElWmB88Ziw6QNzdUWFdTuNITzpp0D3IxjQ36cBAJBItyvr9VYJfFxCLhBJv/BLGCqvQfiHf4fCiLz+s0lRQ2x0tMBT12RVnJ5Nv8erYsOQTrbTZJkrhvEiICukyAIFDfofcy3QSjDUQOx9BW88tjuyECkbW0Kq8s5mXf0k7E2cRQuKE7i+tANJ4JgxVdVBZGlQWNZZDN63eYlDCrII15DKOR5rP/x7WubI8IuaytRHvSoMIFFAFTQL1ciDrJWcv1J6OclW6eImDb7coPuBi/+lRPHKZGVrqRiWlTZrsH1W5Ui7A5KB46VitKUkyImPFd2/xC2RUCE411Yx/IYCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(26005)(86362001)(5660300002)(2906002)(8676002)(36860700001)(16526019)(40460700001)(70206006)(47076005)(82310400004)(356005)(81166007)(6666004)(1076003)(8936002)(186003)(54906003)(70586007)(4326008)(4744005)(36756003)(426003)(336012)(6916009)(63370400001)(63350400001)(83380400001)(7696005)(508600001)(316002)(2616005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:35:22.3887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeacdba-0808-44bf-c204-08d9d66741e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3047
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ARRAY_SIZE to get array length.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 23f4290b2fde..394a18e3c6af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -89,7 +89,8 @@ const char *get_ras_block_str(struct ras_common_if *ras_block)
 	return ras_block_string[ras_block->block];
 }
 
-#define ras_block_str(_BLOCK_)  (((_BLOCK_) < (sizeof(*ras_block_string)/sizeof(const char*))) ? ras_block_string[_BLOCK_] : "Out Of Range")
+#define ras_block_str(_BLOCK_) \
+	(((_BLOCK_) < ARRAY_SIZE(ras_block_string)) ? ras_block_string[_BLOCK_] : "Out Of Range")
 
 #define ras_err_str(i) (ras_error_string[ffs(i)])
 
-- 
2.25.1

