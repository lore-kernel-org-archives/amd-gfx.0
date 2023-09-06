Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90F0EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C7B10E643;
	Wed,  6 Sep 2023 12:51:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C318610E645
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnvaWD+qnUiIDcnCNpw0QC6Qv/xA4wKsbtpeNFR9tZ3PO+7YTcaojj9Wi7spiMCT7FN6oX7MxPUk+m5sseIbIVgiBhEFTjWmyi+s6EK7eNmRdYSXhkcxgnCE5rsLOVQLU30DSgnF47/SW7GXy/dmaC2wYzq7mNkMkJtoOydZpRyiqmw5VXF6TFmVFqA8chqQrpt7WKuvpr8+KnkqdeDOswN2MevgpREz0AqauNBf9O7gGsTtWsAKhMNRqBXEKuV5KFCcrg9AvM93m1ktjV6HFNP1FPcSMqa3xoQbRHZs4XQ8hfsXKQrLLS78NAu4i1vKY/9U83Y50wnlhNO4R03oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svuiqxm6vjQGkdz0onH4bk9kMQmoxmOK/MukKLOF0g0=;
 b=ep82LLxXSFAm0DnrCwnaQOyj1N/+LCW0OXJWoo3wQXxnqYJSPrRphr3FENuNxGxwz/JtI4/4Q8MzR2ypnHAjvw5P0qksiXVGVNKJNQD6tTlQfJlfzuAhyxnLba/iSeZHFdhLNVjrYb5vbMPGJpGqC7BQJUTqwg908lvPhcADVxYAjpUNc7h0ywZ8jFu/qPOeMXWk1Zq2mqPbEI0qNorEKg2ubPyn147GJdG72sgdbKQCi5YIeu3u2gxYwp5txcjqu0z1tD5Zh9GGz4FPMiC8k3wMb/a9eqGQnLmEGRS2nkDoIpEglpF9o5/sM4xT/byAV89VEESdw77H0n6FAksUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svuiqxm6vjQGkdz0onH4bk9kMQmoxmOK/MukKLOF0g0=;
 b=EM2IDOF1LwzL+3jj6OvA/aGluWAp/Gi14m5ahBGs7sOUTh15ERN7iGyqChIqAjRC9RrvbMi6tZjBDTfZ57V4hWOOp8UQGN9jLVLs7i0Ly9M51sHfShCsP+jUmqgcYWWRmyGsdjq35k+S0wXJeX4vFLWeofUxh9EBeOecrGcejiU=
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:55 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::b2) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:55 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:51 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/28] drm/amd/display: 3.2.250
Date: Wed, 6 Sep 2023 20:28:28 +0800
Message-ID: <20230906124915.586250-24-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: ee042fa5-21fc-4628-bb9a-08dbaed80cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxtyHCJob4WgLBZwLvTph0nhKER8t0JzvsvFTCYFfGRGMG7Pip/GjB4Za43xr1Hz+hZ2+117vSTK4cYRw/kVRO4LAeAHVp081sY+6NcPDcdGFsdC97G8DRbcIZVFeS3I4J1zEvy7l9aOx7YvPcQUxwiyXhrJKHDmFAaWuevhWPsNK4S2xYcNiL7Tno9+K0f8wLw7V+IeDqkVRGF+8+CFFZsBr8yVUcdUkBIa9QKGpKVlsdmhQ7Sv4ibrI8yMHdJESQ1xeTD6z8rXapyb4QIIBnVyL9uD/9GkWQl6dVBy3+dgt4hzbcIJexKnq+DYpBIZf7S/7FAKiC8YuEXakxH15CbvRH9JTNgVht/NgdocEsh32ssGhTJJsadk/6xw8d3EIdGKLvIshzcKfHfdIs6SjuOJcYQsRr+4tGSixsOR0UTeWce9WS/Jw2yhXTKB6EKAu2L7T5/V27R9WBEp+yBQM9/TNIEgExJF9bp407ZjsnpcZp1DeNgkmmxorTs4V7/Xeertmpbud1ZgTjC4vmf3Y54aG1a9LWQTDxKMfYxZwhUHJa5fCLnBLE8/2thtYxyFcrTZp1zLplAsMWovmk1fVF4aJI7xdo7di4vRjbw6lBRv1XDe8Py0uOIKDuEdjVLE+Fn6+h9PiNVAUDOQU0DBWSTu0WgmhquHTva8xohQpT6HeCzFcH2vKrFLkt9QVxci4QUq/MgvAiJQyBeNaPXJ2n24iVtML/l/MwbYXhbwutPPEmpGnEzhIJ29tRkkl1qPwzoQolyIm3FecmWAQrpifw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(82740400003)(356005)(6916009)(7696005)(6666004)(5660300002)(44832011)(86362001)(1076003)(36860700001)(316002)(81166007)(2906002)(4744005)(2616005)(16526019)(26005)(70206006)(54906003)(47076005)(70586007)(4326008)(41300700001)(36756003)(8936002)(8676002)(83380400001)(40460700003)(40480700001)(426003)(336012)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:55.6279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee042fa5-21fc-4628-bb9a-08dbaed80cf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 05ab24c81041..bece61d2508b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.249"
+#define DC_VER "3.2.250"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.42.0

