Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F3BC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853F761212
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 08:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 853F761212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233BD6E0FB;
	Sat, 18 Sep 2021 08:08:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703EF6E0FB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 08:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqSkg9Y86uZ4bpGQwny9W9J08MJkek699bVXcDItEI2mQWpGm+PkOwDPI+CZO/Remrrwi8rOy5d4PWOpFYwyv++3/A8Fvz/TJ6rlg+9wBNuGaXIf4tpVKXsVfnD0sJxNwvK73zqKw8SI5Rfvin9/rjtJkzaNfP4qUtw6RmZA4tJOdVNV7vwI60VOAG4W6XEjbWd3rSew14nHZG/493Au+2anWWzb+BNJkTjAunDOGyRP3G52J337H2v80nkYEgsRSgWG17aOuMmq9+nKuzaxTf5mQYuMu54gQuLIxIBggYk8xtviaot5wib+eKyvt80RrYzYE6fQob3WJ7sACUXoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GEwo1wkD1tPd+34XJ9lOYLsC6p+fPNZZzGGj9McqfnU=;
 b=EsxeYttPT0qg3GcOJiQb2ba/0YET2iiNqwGbWQpAV8kr6YgQkagImNHuGkAG3h/bfYoXdG6u1QJULqGHp5nY9FTySWg96QRzK7eAngT7Dhgge3gE16qxpo2FfrJIeLjVslQywkfy6S7qCniHQ4/xQFV7OzcUyvp0+m1vmsC3e5LoyUzTVVBg5N7zJj0kHpDFzPJ0QEdWG7ootSsstyRy1Wsds6b/EdkEmNkxuLSmn7HPBdKe2jVIuZ3NRvn8R+8Zag/slcnD0GS+RPoA8Dhh/8DO/1/zfeIkAhn9IoN7Ewa0Cvvybny22VtyPiJRWP1LRyUYf4UXaEWWZO/TESTI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEwo1wkD1tPd+34XJ9lOYLsC6p+fPNZZzGGj9McqfnU=;
 b=uVHoG7w+Ev+nqGn5PZ08Sg2IiFRnMwaz1cdwU1LuAmh/LX1HQ9IivRny7DIQ/M+juUao23R40ay0uVi+ioa93GZfN3MmxB97c4O07vZ5oFPIxz0+/Cg2tWhHKhdlCbzrMrsfseeZd5cAaN0CiqfX7zgGex6usPzhBAg4BIiJzeo=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 08:08:09 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::44) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sat, 18 Sep 2021 08:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 08:08:09 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 18 Sep
 2021 03:08:03 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <john.clements@amd.com>, <stanley.yang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode
Date: Sat, 18 Sep 2021 16:07:51 +0800
Message-ID: <20210918080751.23615-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210918080751.23615-1-tao.zhou1@amd.com>
References: <20210918080751.23615-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f7e83c4-2b54-4f17-5900-08d97a7b73e8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55397634AD1790646DBF75D8B0DE9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2de9HbotxKVyNTwyj7TLCJ9Lh2WtsoSDrsuR8MASS/cKMwTXCFJphGvIusLdgAUwF1O3iyu/tyv3PfAAUCf0mRCXvvJ+opPOGUihXV6uxEfp03SzWLGeflBDPh7jii0Y1i8JqW71Q2wtmaUFTD/jxbxASK42ORc7EsgXFqg7bJnmz9NqJI6/2eob9Tw3F+8qQt7WjrW4OzCDSENF3+iQxYI08CX+4pfhlEEY9BWY4OaffGgaPA82GnCGxkn9RIzR5ar7pAqAq+arFmhCTvmRuKUj+Rk/Ol5b+3QirEWNw0014BvkCRkcE/FSOxv9dN7iaeuFSQpzFgZ7JO2am7NZzYuDXNQo6NTamWJ62JDJ27UZ2IeFcrXiZbpu0o1g5qVUNm6b+vPiAStVswGwB2yxls3owb670UrtlSGvLqHE4Dd1UIFpjBmUF1VBLGONQnd4Ygn5ZKz6vJidtwsR2dJR+MXMLe0O0vELkfCkgbEy6kiJOgUSd3maz9nebZEthMTyJiVnF82g9Eh94s4rKaSfy0T2XToXbrUIAR3JqKgmwbMMxbTku2EYHvbbKBQ96IibsSETDMnHFSTNvravO9PHHZHMzPVH0yQYHWHMf7HH5TWIjJxVYdwFFNrYWe41kvAnwqaj3UkpyJWzCvSDBYzDg8okZSkiB9JEkUi15VXe+cH5AUVd1Q4EYR91XeA0GG5FLRrGAX3vd1FLAEUOFdcFu2s78XVbHfqMaIbT9EDDKeI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8936002)(110136005)(26005)(7696005)(86362001)(36756003)(186003)(336012)(5660300002)(2906002)(2616005)(36860700001)(508600001)(356005)(47076005)(4326008)(316002)(8676002)(6636002)(83380400001)(70586007)(82310400003)(16526019)(426003)(70206006)(1076003)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 08:08:09.3379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7e83c4-2b54-4f17-5900-08d97a7b73e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
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

In ras poison mode, umc uncorrectable error will be ignored until
the corrupted data consumed by another ras module (such as gfx, sdma).

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 34 +++++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7b7e54fdd785..195637725c7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1473,22 +1473,28 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
 		data->rptr = (data->aligned_element_size +
 				data->rptr) % data->ring_size;
 
-		/* Let IP handle its data, maybe we need get the output
-		 * from the callback to udpate the error type/count, etc
-		 */
 		if (data->cb) {
-			ret = data->cb(obj->adev, &err_data, &entry);
-			/* ue will trigger an interrupt, and in that case
-			 * we need do a reset to recovery the whole system.
-			 * But leave IP do that recovery, here we just dispatch
-			 * the error.
-			 */
-			if (ret == AMDGPU_RAS_SUCCESS) {
-				/* these counts could be left as 0 if
-				 * some blocks do not count error number
+			if (amdgpu_ras_is_poison_enabled(obj->adev) &&
+			    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
+				dev_warn(obj->adev->dev, "Poison mode, no need to do page retirement"
+								"in UMC ras handler!\n");
+			else {
+				/* Let IP handle its data, maybe we need get the output
+				 * from the callback to udpate the error type/count, etc
+				 */
+				ret = data->cb(obj->adev, &err_data, &entry);
+				/* ue will trigger an interrupt, and in that case
+				 * we need do a reset to recovery the whole system.
+				 * But leave IP do that recovery, here we just dispatch
+				 * the error.
 				 */
-				obj->err_data.ue_count += err_data.ue_count;
-				obj->err_data.ce_count += err_data.ce_count;
+				if (ret == AMDGPU_RAS_SUCCESS) {
+					/* these counts could be left as 0 if
+					 * some blocks do not count error number
+					 */
+					obj->err_data.ue_count += err_data.ue_count;
+					obj->err_data.ce_count += err_data.ce_count;
+				}
 			}
 		}
 	}
-- 
2.17.1

