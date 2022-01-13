Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24901C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DE810ED97;
	Thu, 13 Jan 2022 07:35:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6673710ED97
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DguytCwPO4N9jTtOdriJ5OCnynPhckkf9DTffYhjD04vrHesiEZEj4rgLdhZdqL59A12SAdLBwq+fhMXkynLRv+zTH96WbMMANk3ZS/q6J82jlkWOkyydwAffuRQuoJO5Ag4ws4mz/1UMWbO5ER+/kD6eebOGv4O/ZYA8F2I3Ih5mSUo+VUG18bleMiWvEcM3DLfykwwvx+ih/lVhUHpxNPXODWiukZ1pstxRifiYXGnPujajT2YeJirCM+DxF06f1oTWYuZrsU2x0ADThK0CP0vBfkfrYtH/WA+kXdcMbmSaMahl9DXVIbqdegBra7hGvQ1/2ZYTlaigInCuH3O3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+3Qv1klGmZHMjJb93vlWA4XfuPeK/o6/G3IeuIJXgo=;
 b=CggPUDDcOTDr2eagy1R0rhRrAmKV6nLfAHxlZj8F+xzueVp7xcgN5jGGMSiJ36Dyqp+CPJGHWkvBUjjSmlTnArJzLb/OWYBNQb7JPD2cip2cZtWhXqx8LF641L+L1kaV9bCnrKbMcnccAt73tbn3Yo5wBV66k5hcwzIkKD8u0K4yD9Ygnn1bfWFsy3cDDtixGNmM+NYgEo5HGYtG4dvJzEL1Q3zreTGyUWVEfaIUK0YD/mBl+/ptqaXmUQTmt2YwflmZfGFDoGuq4sCicz09AtsiVwuh1u9GEu35rSYl9TxoOUgUhq/6WZHerdODPrmYud9uPrhdq6G9Zv7snVuSaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+3Qv1klGmZHMjJb93vlWA4XfuPeK/o6/G3IeuIJXgo=;
 b=x+Co5yf48urr3qgfivO71uMY/xtAO1PgW6yYD/5cayHyPJ+R4ZPW8Fni+0h2g7eWoF933BH6MSuBpVa0ycl7I+QyaATRHH51SMRdQQDIgqK4qvNeXX+OEQH+22uuAJwGi2pNnA1+h8CxJrAPGHDUEdJNAlIwMiG1O0CmoU6OYgs=
Received: from MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::16)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 07:35:28 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::88) by MW4P222CA0011.outlook.office365.com
 (2603:10b6:303:114::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 07:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 07:35:27 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 01:35:24 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Adjust the code format
Date: Thu, 13 Jan 2022 15:34:37 +0800
Message-ID: <20220113073437.3140364-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113073437.3140364-1-YiPeng.Chai@amd.com>
References: <20220113073437.3140364-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a543360-11e6-4419-a62c-08d9d6674534
X-MS-TrafficTypeDiagnostic: DM6PR12MB5023:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5023F9232A2E6C40D254B539FC539@DM6PR12MB5023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9P2LhSZnq65WGAVf7AHYWVfvsxp2s4HnxE9/e/1hgrv6P0wL+enCd6YLU1Zu64EKq/sHqCtxLHSGiL4j7iEEg7m8fe0bZrcAQ5b+li8+dKPegh5HIjGJIrejch8Bfdmv39pabG6Y4DpWVvQOFA96E1V8qKRV+fsEFND0seQx2eW8zDPv1Y9yIF8LBTym3vacT64uhRYMzQpca7F3i2SoaqfJKj0/v9iw88EanV3qZ/sOZU64NbCJQZnvYyUvUhCOvBBQy+VHXZttCdawgblG2lki5zhuEvsaAImXly7y2RD25xGl1aN+QwlF6vaQ8Qj0b3OM/CciGOrYQz7WecuHH9PurHYpFk8mGVjHx04fRhJ+2GGBptRbY53ve2Wi36+iyoqqbX1Kneh8qQbT7UKBRkjaQTmvESbhpWjc57LZu4TriI1r9bdpGSTgwxrsuP+jZn6sFQ8J4QKFb2F0BtndFmrc61M2wsghA3jFBw9hYdhkJBmHN2XiN0jCESIUD9N6PHzt9xFgkMemNqpf3aFg/RnyTeiwlJr2u/Bcwbu28H6REG59ucRgNnjmPLzu6yOsfYoY9vi2PaHeucjIFIMDTF89T5IrsSrOKDUA/3qk26aC8faaI9QzBMF0Jl9rwbqJXEyWG6H9r4l0CKKb6IToyoCowQ6CreIBTWJxaaWtJ+KTZGtcNHZ/M1PxdDAqPHPKnmZU3uEgFO69sNJ7hHyPoZRRxm/U+hgLr3suYxiMeMDT1FGAbEVhliL23D3QRQs3XA7asI2SsTlaSygSwWuSFE4Os855fapcG4R/MzLJTJj1LoYdcRgki5WCWNoQXUq28eE9AjN4FA3ISt1abOOUGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(316002)(336012)(2616005)(356005)(2906002)(47076005)(83380400001)(70206006)(426003)(70586007)(82310400004)(36756003)(54906003)(81166007)(86362001)(40460700001)(6666004)(1076003)(8676002)(36860700001)(16526019)(4326008)(8936002)(186003)(26005)(4744005)(5660300002)(508600001)(6916009)(7696005)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:35:27.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a543360-11e6-4419-a62c-08d9d6674534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
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

Adjust the code format.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7afeec4255bd..54d807b021fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2764,9 +2764,8 @@ int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
 
 	/* If the ras object is in ras_list, don't add it again */
 	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
-		if (obj == ras_block_obj) {
+		if (obj == ras_block_obj)
 			return 0;
-		}
 	}
 
 	INIT_LIST_HEAD(&ras_block_obj->node);
-- 
2.25.1

