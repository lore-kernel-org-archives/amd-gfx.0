Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1517CC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9274D10E7FE;
	Thu, 26 Oct 2023 14:20:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C84F10E7F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1zAkYCu+3puD7zvr9znLO6nLG2hBgXSHxHiDtKNNSIfioMJqT+ltjLqI7WY9f8DWJEJcOxSorZsnGEylceeOITtU8nCJq9iiitDXdScx4FuqHB0j96kp0yIzP3XsPVZdPFj3WBcu+GiqjgqagFRSq98zbjXb3SwhvU/fPYjlMIbLXUeaewfHMKjLJjhJ4Y4vivHobwtwQFmVZo0UDiO9YOlhYewIaPO3jcMB0vdL2yMBwLYjAkqhnEiEbK1R0gl3Vd/+QLWqfWUmOtYY/KsTi4ciahHzkWVYiAlmaTUJW4gKs5bOl0Xii+P8y0VTBgC7FLQQg3Rd+hbRJdBn/iFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7/8ovmqWLCIFPak8+8conepVutkbqHzQlaoIbaSUaw=;
 b=bIOjY0ovCrHEgHtx/kdNgpRR67UPQdC5nlA3zT2su23Lewv1x8OJpb7FkvJFdVOisC2lC/mLTsRVFPYIvHCVco3hklYQ1uOd3Sm50b5tU1ojhhIqwhxZ/YZkjdG+m16APDV89Oiqz6gcBZzPFLqrNC1g0otbE3CRzX9ULceZob8b1yvJ/ymq3RF3rYrsb9g4oQQGr9EIaqi7GN8CvQWrLDiAS7KnBGDKp3G8q5OywYQNQxVkuC0AhTj9mV9xU3YCMDX+IKkQkHo1cbvlx2KWLcW3GifBhGGIOInpaRbk8miJxz12bLwDEw5nLQnTTuptqQQXgQ1ZskbxwJBLViOJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7/8ovmqWLCIFPak8+8conepVutkbqHzQlaoIbaSUaw=;
 b=aYRa+qZnqBJE5a740H/a2c2wspdUHU3jdMtgn9SSjMOwuiWtSipUY7uO89hBHkctVLGZNk1jFfoW0xGbxamZg9UMhpiykWPJjK8eL9xstYu8GeDLOmKm77y9fbrAjpJTl7PaSpwyFWBKW2tm5qiJJzKujn25qRkC9dgiB/AOzWU=
Received: from CH0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:610:cc::34)
 by SJ1PR12MB6097.namprd12.prod.outlook.com (2603:10b6:a03:488::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 14:20:33 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::70) by CH0PR03CA0089.outlook.office365.com
 (2603:10b6:610:cc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 14:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:20:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:30 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:29 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/25] drm/amd/display: Enable fast update on blendTF change
Date: Thu, 26 Oct 2023 10:19:59 -0400
Message-ID: <20231026142020.67861-5-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SJ1PR12MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0df44b-f8d1-4ffe-7fdb-08dbd62eb6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZK7f4J7zfYG5o5H2Njot8FKLvqhiDATMYrzvdvK7gAb5QGKbVMnbzYEetbuzcn1RMVC0UUSoHWXwZaSNv3zMvvFtV0S5xoeIrrVnTbyMPvinZilH0Hoq4bOhJgO1OocOXPC9ASRDomCL++EoC7Kvb0jLvuX1F6Tsymz3wpaOp1IYszFu+ZsvctKfaLs9Ph2v3blkSaRlSxrQJyVD8GjTKDae7GCmBhLttRkMq94c7ADm5eFBeS1jNo4iLd7eLkht9tk5XJSwU6ioBSeOncpyUfft05SzsJ0VrqM5G80Bsa56Ik5wjDTkv+qxUwUjggTpZtTZTiRE0R9m84N6OSskMvEoGDq5LMo3004GVK4LInVrAj6AA4YuVfQkJY/lalII/sRcot+duwaNiWVH8ecGyV9IazwLbRPFYXVq2opL7T1bPSkMUyQ75S4Fg4CsZ/H4GcTX7Sw8tkzDWbtPKi3ck2MiVFMBIRsOqk7BPQu20NBWR/g+Jzvw1eizWEUAsqcMN5JLtg9fX9nlK86VSsxUyupmy+lCsdioegzmR+K9BgolWaRaf4Lxn0e86sgOUKDNjjJZtPxC8uyRuDpvJ8uxnJ/Jh7a2zLKkZHaXiH5SjLVAEtjB8KP+Ima2rSLDLphFuwk4LzSgGJ1fuceB73gALLO4b/GAz8MQNkDvTunyIIURxS9RQyPLitvB3mSSP5lNn8a0nqZiXy5D4TIYmROTq76/RT7e5BHmvQG+56vqPrYj4jIBuh6Wc3ZXgBnN1Xtla9rxJ5ErdJo1nxU04Tz8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(15650500001)(2616005)(6666004)(54906003)(426003)(26005)(316002)(478600001)(70586007)(86362001)(1076003)(356005)(47076005)(83380400001)(82740400003)(36860700001)(81166007)(336012)(70206006)(5660300002)(4326008)(41300700001)(8936002)(40480700001)(36756003)(8676002)(4744005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:20:32.6082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0df44b-f8d1-4ffe-7fdb-08dbd62eb6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6097
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
Full update is not required on surface blend TF change.

[How]
Update full_update_required condition.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 74c21d98b4de..4360a696f10a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4348,7 +4348,6 @@ static bool full_update_required(struct dc *dc,
 				srf_updates[i].in_transfer_func ||
 				srf_updates[i].func_shaper ||
 				srf_updates[i].lut3d_func ||
-				srf_updates[i].blend_tf ||
 				srf_updates[i].surface->force_full_update ||
 				(srf_updates[i].flip_addr &&
 				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
-- 
2.25.1

