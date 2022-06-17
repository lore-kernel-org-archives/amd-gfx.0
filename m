Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB14C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F3610F290;
	Fri, 17 Jun 2022 19:35:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2B510F21C
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7SCwecQPzPI93/CfCAtS58BtM+JFAdKQ4E2GyFg53RJwmroeoAFeF4utl0/rz7IAZvsihumDPHXCihoJOQALfNvjZNmWTCOXJzXZTcb9PnxQAOFXwdoaDBOFPhAHQnYXlNbeHaJrsfPGjz6zqXz40CjRuAVc/I8ab68Rl2HMJ5mOO7c9BHW6CloAQhSYCMTUEECJP8huXsP4xBv5gWRdXqZt/soDSMrxDyYhE2xnoi2pmXlZs56hPF/MBF7Zu19TfU/SSa53Ubwwnu71+c5Qt7q0/jBjGdM3GizoRSANE+rwqelne2bSgqyVPIRslzEu1n2W5/YgotuEBtJsHp97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEAuYRmmhSY8t/1KGmLNPhrowkITXk1E0fbTh8N2iXs=;
 b=bYyjkgUFj3nNfW2LVhZr+di/95B7UIiDLdeStdBm9Kauoloel3lHRRuzxa/vNE2X/x9hOx9QXcA5gVQhxHAavbtgwW4j6Ds01Bq1AkD3TzD1ZEQBvM4ekKrmAR6/gRqxnObUqlb6jLQJGJQMJtI+IwB5BAidfu81c7lVYgGWHsgNPnvekWXdj31CkaP2bmeurb2rZo3xc1jLAUWCHnLbhFCgeclO+X0Wr8H6e1bvtCBEvVxG/5cVQ6Q/NcTMXdSDVGQyzxNG/qsA8yuBcO4RVw6hx9layPjbavY30je4OGA35k5wW+MqqfNysE/sUW+9WOuhVWJJ21JDRP24Yvc+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEAuYRmmhSY8t/1KGmLNPhrowkITXk1E0fbTh8N2iXs=;
 b=lTEXy5i+t81iTOLtQdwsCL6apctgpNZ141MsYTV54oauVM0/G9jw8pHc+EUI6+RpcoKUPJme7JCcr0k2UcAHDBcwRdyKY76ZpBbPBsFoX5meBhqwxO79TnCJmVRW26ofovjNQhtqfi8uLgHLnIMYCqoeBDMzDsqNNR8Cazk68HI=
Received: from BN6PR14CA0038.namprd14.prod.outlook.com (2603:10b6:404:13f::24)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 19:35:37 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::b0) by BN6PR14CA0038.outlook.office365.com
 (2603:10b6:404:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 19:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:35:37 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:35:36 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/31] drm/amd/display: Remove compiler warning
Date: Fri, 17 Jun 2022 15:34:42 -0400
Message-ID: <20220617193512.3471076-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b62c52e5-d332-44c9-b0d5-08da50988dff
X-MS-TrafficTypeDiagnostic: CY5PR12MB6599:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6599A18632F389FEF01A50B998AF9@CY5PR12MB6599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp6cuzUntVgHPHbuhf7Dt16tJcpI4IetGsirem13zDX9fFsBaMF7mL84PxGsWvA+y+qa1Vpe7RfEV8dCAKgyhIAqfxRkRu0Qf9ZM5dZH097o1mV8CKibXwnP7Mgv37EFhQ2HBWlYVxaoo508VrfDasx9IsUkZV4RhBuTJMDzBkbawGE4D+F0dJYoztoy4jK0lqj+K513UvnGbz0qyBxU+iZMUpMKJtjBEUnvZPCKHMJQd5jCvhwk19ipdBKGovxppZIB3gPxwkP89HiVvR8Fcsx7MfHNXeq/bRV5KA6I3q/5nq+oljXut2rhYyOjedQ72/FqxjVtTd1P+u/Sh+kS52NRqv4GZ7zvj52coi8wmkp2Do+MC90Q6wmHX+o+8mw0n4RABzOrfmY0tGat20lQSMZQvY96hINU/lxGfuR7eoMjoAM0lWrPagMPToxaau8k6YFAg7DROXjyeXPrRRCN8WcNaeXp4SHaa5DufOpMy2ODX+t84aua8+JBPiscon3F+592PpRzSUmIXL8ozmPIzFgXp0cxQO/61UnW4B2SWMRx6Gqesi4JGq9ayllm2pj3cMf95Oh2+bHpT61nroR/Pnkd6vEb9jsCyPlhbvyVNG1MOC3UapcnLgAm0BfXiTOnBb3lhDITI8bB9Lgmn+cgoiU2XjRzzGF3Wwy64NSMR0mIaYgj91ZJ/D2nZwncHb60AZ6OjrvHmo1fdfSMH2vTlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6666004)(7696005)(82310400005)(2906002)(426003)(26005)(70206006)(316002)(36860700001)(54906003)(6916009)(4744005)(498600001)(36756003)(356005)(2616005)(4326008)(70586007)(81166007)(186003)(16526019)(83380400001)(8676002)(8936002)(5660300002)(1076003)(336012)(47076005)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:35:37.3317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62c52e5-d332-44c9-b0d5-08da50988dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Cruise Hung <Cruise.Hung@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
---
 drivers/gpu/drm/amd/display/include/fixed31_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 22053d7ea6ce..ece97ae0e826 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -322,7 +322,7 @@ struct fixed31_32 dc_fixpt_sqr(struct fixed31_32 arg);
  */
 static inline struct fixed31_32 dc_fixpt_div_int(struct fixed31_32 arg1, long long arg2)
 {
-	return dc_fixpt_from_fraction(arg1.value, dc_fixpt_from_int(arg2).value);
+	return dc_fixpt_from_fraction(arg1.value, dc_fixpt_from_int((int)arg2).value);
 }
 
 /*
-- 
2.25.1

