Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC6DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 15:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3AA10E483;
	Wed, 30 Nov 2022 15:22:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C775E10E482
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 15:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIwifV3Sdhk0l7Gz4xh/2o4SA0MvDpvVsvmmsDbZDNnnCceHnbrObQsTr9hmyps7AKl2BDnTW9nchzA86JZAWp6XMriiFUkxf2Ga0usHpjSnf05BRXZ5VLiNey1tEeNQ0Rn+Cn+ptSmrq1fOKlAWpGPdVk6JhyJ5twaeHJ5Ly+8YMRJcceG5mJ+r0H0JHrkZ25JsOuqggr4Jz3oAxltBUKKieckHgBuynxyy88illNK3wmQhQoxT17eltgG9t549MMmSZHuyNWv9WJSuW8jfWXI+zzuZA8gDjkQ5z8wLp38IVsEaS9IH1eNC0RZtRkNZoFznFiwSIJN91ujGQBbkkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqrxXswd+PP2UsFft4js9v/o/niMzpkn/pGhiF2t7zE=;
 b=Yp4zQ3bZDG/KVfkyk9xPd+HFTWgE1uEqLxWxCe1prZM2qJrgG2qVRPX3B3nO3eQ+Vr34OWw+KQC6YB5+oH1JHB9GgTGOCdNt/MMfrgRn5RcjwUGh4buorws4apCfQp0ihT0CnkCOtYN1vKgfEDfGL6s0Si5w8cvhm4/Snks/Ftm85OBwJMkinvC6ZPphizIkoWnsIrp98HQdUPZ12gZylPdrZMX979iKPfe+967gMebN4buenn6VFfnJko+V0P/9S8nMnUVVYjx8E6arw5HKSVirmNz1o/4EH07Vz1Pe8ziNpt1rLz+u3zuRc4RyyiUliGc6N+U1/HBxHaIuvQ3ZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqrxXswd+PP2UsFft4js9v/o/niMzpkn/pGhiF2t7zE=;
 b=m7qTSz0Krx9GBcpkCzoyE3Hkpd/6vq3FDDxebz2xKqhj8fWYJvqYFWj1cIUzv00jK/31zFJBNgIAlxsCevA5S9HL2TDtSo9cGlKTJIAeLIpfl966eROwNu1ANGx5jjaPFrKs61L1qryRJlpaHrRb8pAoDBtuKBjI4s8Sgj+V+UY=
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 15:22:28 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::a9) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 15:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Wed, 30 Nov 2022 15:22:28 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 09:22:26 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: Tom StDenis <tom.stdenis@amd.com>
Subject: [PATCH 2/2] umr: Get rid of unused variable warning
Date: Wed, 30 Nov 2022 10:22:12 -0500
Message-ID: <20221130152212.16913-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0.rc0
In-Reply-To: <20221130152212.16913-1-luben.tuikov@amd.com>
References: <20221130152212.16913-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: e73404ed-632e-417a-8001-08dad2e6b156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldDKVquqJZJ0EOmr54UhAzKTfLIhFS+D7QIARLK1Np8K+eZfzBtDq47dFCVepFIXPvpcpYyxAfj9p8PGZykzVle/l2he+GaRdZQVayU1w1mHD38SiyFI1RE7ukmQtVjfRCFxgN9QU6UdAVJJlStrFnmzSTJxdXVF8mKEArad6nZUms13jbglxuxX+k3dym+fM1JCBABi4+pN4hu4rTcQ9vhP/xvZz/+lWVWvG+mqhSyHR4DjsqpV+UM9s9s8UIH5+NEPjLHYBbxod5FycsLQV6v3wAuijgRmL6ZOysKRUxdCiTaSs/ezNVXryDP2lRZt4BVjPqYP1/NE0N7KWtiqGiBsU1yCSX8HCZf/RIfksmCRo3SCo6v6ehrHoYehLEjRAsj6GyVTG8tHLBITVEBIcOU6/2fUQpKCNv9XEiHU5D2kWlRYfd2O6GPEtYlisKietg5zwELEEOmSFO6QJvOeE8p5S/8RzzalPJlTUBjGsVYn0pSJNc1FiDv/BIw4M/V22C5AcuYjD6mtMiuYEOpKfZqUnosSITMZQZ88bX/0v223gpSWTho6Fp7xLyOzTDIaRLCDrfpVN340df1t5vxnsHb8LxXzX+FGxOdwrrWmfdzCRSur1uAAghQORprNjKZynqtZtraUXFeYk7M3s35TlnmXbw1WvBqT2yagVOL8kLdaoLrFInR/QUxD3eu2cLEtZeNuc+VNrJBAoma7sjodtoDzXjG7XHlxgNkiORzousd5hn7apAaQrLh6HOMCFIpUVIXpO1IcNYJTQYtcwIFriirrr9Bl7b7umnbacPW7BA4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(356005)(40480700001)(6636002)(81166007)(86362001)(16526019)(2616005)(8936002)(41300700001)(336012)(70206006)(40460700003)(6862004)(8676002)(26005)(6666004)(478600001)(7696005)(4326008)(316002)(70586007)(36860700001)(44832011)(83380400001)(82740400003)(4744005)(54906003)(2906002)(426003)(37006003)(47076005)(186003)(5660300002)(1076003)(36756003)(82310400005)(26583001)(36900700001)(358055004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 15:22:28.4331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73404ed-632e-417a-8001-08dad2e6b156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get rid of unused variable ‘limit_ptr’ warning.

Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/app/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/app/server.c b/src/app/server.c
index 07fa42425765af..e1966b426b1775 100644
--- a/src/app/server.c
+++ b/src/app/server.c
@@ -1352,7 +1352,7 @@ JSON_Value *umr_process_json_request(JSON_Object *request)
 		char *ring_name = (char*)json_object_get_string(request, "ring");
 		uint32_t wptr, rptr, drv_wptr, ringsize, value, *ring_data;
 		int halt_waves = json_object_get_boolean(request, "halt_waves");
-		int limit_ptr = json_object_get_boolean(request, "rptr_wptr");
+		/* int limit_ptr = json_object_get_boolean(request, "rptr_wptr"); */
 
 		/* Disable gfxoff */
 		value = 0;
-- 
2.39.0.rc0

