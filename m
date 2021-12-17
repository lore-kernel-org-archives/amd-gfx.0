Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C67C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 21:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C0A10E6B4;
	Fri, 17 Dec 2021 21:24:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC61110E6AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 21:24:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGYWeW5jYM+VBk9rg27wv1sdDLvTQGPn/qY+gAOn1vVPDcy0TZo7BGgsbRuZpRnNVEalGnIKGGN4uKcXlH9X2xukXQt6nmir/v6fGe24q2/+T2XtGzsJL1gWZItKBuZNQMENKe4qBn/1yfK6Zz9H78x6C8LoQETtqrTvwqJgRZHUlnGjx5qqHcBBkPrvJMf8Q9VwXftX4+JfjCVKc3jipqE3zwLKbwfGrIJvVOUOKxtxOBySPabJ4rQjGi2LVpQJllUV7wguy8HpkJsMC0enHBEYxzdgClRs1ToikaJ3MD4FvlPngjVhX+rYn5z4kYOzJn8vwJortjh8PC15xcwp8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atbn6MiZ6RAekPa1Nq4YRiuzaOsDnsYCjrGx1RQoKCQ=;
 b=aZJqL11FcnmLd069vEAwMFmYx9tBsVblPtTxNxLzylZIa/ZiHOV16k5OQ/yGUSH5vd4sIw1RKSZLfSJd2i+ZL1e/jRml0Ld/CPZXj3TCbffN9Q5c9ELAF6fHz1i+nqtUsJjj9py+/D0eZwGkD4zjbuQzhy5JNcxMZbdLeISfr64SgQcA3tR56M2hq7d/zBY/8Nn5H52gQgiHvjTYRmdBpYTUnTibierWaIXFWdhQhWtunQIu+UI9o9/0LY6eWc40sH+VK0SaAf5CFIHZtMu5Ql9m7EIIWkVUvJOyhjnukej6XIssirzdiCtV3fW95JNuZi/Lj0tg+9b212kxU4WkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atbn6MiZ6RAekPa1Nq4YRiuzaOsDnsYCjrGx1RQoKCQ=;
 b=r6cBsQTHiHqKOSl+6cdSsQgyiBVZK7ZufvLAS/ktYQ8i7a/70HTI/IiJsnfUrwIqtW0q9BWwonSUIQUqrxj4fpyQi6TY1zP1BQ0/UY7wRPYz0v+45T4p0pd6Y58EG2DEvonZOsLcSxhMkrl/9OnOlwgZHcfp3N8+xRL+Wn8ftj8=
Received: from MW4PR04CA0263.namprd04.prod.outlook.com (2603:10b6:303:88::28)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Fri, 17 Dec
 2021 21:24:39 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::f4) by MW4PR04CA0263.outlook.office365.com
 (2603:10b6:303:88::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Fri, 17 Dec 2021 21:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 21:24:39 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:24:37 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: 3.2.167
Date: Fri, 17 Dec 2021 16:24:02 -0500
Message-ID: <20211217212407.3583190-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
References: <20211217212407.3583190-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75b60b90-b914-4101-e608-08d9c1a3a24e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5106:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5106712CA9608E7D1BDF3FC698789@CH0PR12MB5106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdL2pgtLTZW6hlcXGxvH62pE2s3g8wxqfuvAN3XwXCYEYW2QWpOzU2L40EXX6ceWBhBm0XKqkP2P4sayxphlFbeCjyZjhuwKrmbhkiDSkyn1varERFrSnjGVouunhQjxdHIq80cUS08wRJ+naoczH7ecSZgoLe8epn7mHrfQbrVZnfJ8DoFi96OW1LNpyCY1Z+UYYqlZKc0ihLAPBCelBlYMY6e/zUcML1VT5M65lQxM2BCKzG/XQgSUcf012q/Xb3svi7jREnGrfPP0s10ac/l+Wi+S14334Pr2MQcMy3Z++BJl4UmwIZu/p8x+Y1iYPx5RTD4vx34DzjBIsXXEQYXcno051loLMZnrRHtMJ0XbBQKbvaCBMfAgQPCZ97CJS+JusnQt+Hksj1grn/oxVCYTvrDNxIRwTSGPYXaOmtW8wc5p+xODgDVFHxUu1eEM/bJlMKFTYeMT7ZNborFljOyK426ThML/wtdmVg3IB9kP/RWm5YYiuA/2mNUEHfu9z9WcivAs45OeoEG2+o24MOrPuT+qTdebFAWo77Kp/qIU7U6HfOQwKNIot/qDAp2KA8Fgo99bnDOV4EamEfD7uPfE+/7coV0Ux11wZ5Me+DVrkbHHBsVZFrtKn5yrMFUZyPo7fe8Z3r19a0Y4dtRw2F2RKpViHxTYAZxg/sAghzDOrVQ/DGGlM8dRfQTRzFX/TJddNRf3AvZTWxHq2eGxxbmTubBWv45JOYOrZCNYE4Ssjovx9rnq+U9CQ/UTqCh5KSXjcteu/ihr6iMTm/MVhQdwX38mACqDEuWME0jgh5k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(2616005)(70586007)(1076003)(356005)(426003)(316002)(2906002)(36756003)(6916009)(86362001)(336012)(47076005)(5660300002)(4744005)(83380400001)(508600001)(54906003)(36860700001)(81166007)(40460700001)(8676002)(6666004)(186003)(16526019)(82310400004)(8936002)(26005)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 21:24:39.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b60b90-b914-4101-e608-08d9c1a3a24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
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
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along the following:

- Fixes and improvements in the LTTPR code
- Improve z-state
- Fix null pointer check
- Improve communication with s0i2
- Update multiple-display split policy
- Add missing registers

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 18e59d635ca2..1be74d6223df 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.166"
+#define DC_VER "3.2.167"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

