Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B591C001DE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 02:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A461C10E269;
	Mon, 24 Jul 2023 02:54:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8752010E269
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 02:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNuYL5at/tghXTIQK+4AGkKXWFBUA1jUjRD4FsEmeRjQuR1VBvBIyfN88lshkbnmCnmTFYaqTsufAGfBUoFyfzweixZafL2NPLE5O/4KJAacomaZ1VYn5DaTllicRZJvyHSDs005/gFAdoS7Y3EXhQqxylR63oQiyxHjX/FL53U6cyCNDwWyylhf8TWNjPN+ze27lBLKmWHHm+LyUbjzpbeixa0GM59nnZZyXV0DTSZ+MoD5ceq/C1umNYC0crmPpEz9OKnjWJqruuCG0rDhRgR5wYxU1Le3Hx7+aAi6u2fjmQrwPGLV2sUutQkw3txxir3xEhM9CtEvSyirESiqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRuVLokiUuTHzT3FK3845gfh9q5xjMUvxdKHvWXYOGo=;
 b=FinWbjT5Ski+WXyaTH2Q57G1A9xxDutiJrtnICLP8zLfOcowrHZO+8QKLubVf6Ki5DOY36kTuYtK9giHbrYgiANinRaF/gTPfrZjH8bA1Kg2+VAFs/hklCcZuH4xlnYbkFNLXyLypHNGhTZ8L2ChJOvW532nZFq0c76vwXEb+tpOTlZIQHyb8qf/uIdcezoYBM4HP8aIrbbbDdkUWdtKRyCpaVGhC2orvYHG1I/+07jjNDT6pEL0epix2izuB8WTuoar+k6j3yvxVHuIdn07SbCTwPIdjFwXFzzJ/xrPLLiPoZxmIvL4sclnjBENJc2OoumvZIAXN07tf+58HkcUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRuVLokiUuTHzT3FK3845gfh9q5xjMUvxdKHvWXYOGo=;
 b=1tlzL7Gku1hU7ArYAwcUW6TuCBeoYIm0gKNc3y1vVSlEKCSIBuxbSAI4Lh3jwRBBU5LwkVx3Q/aTrsCiKDLHkS9tnKfQVlag+whxTNC9lkhEqnY0h4OqJO6c0bL4NPVL7r6tAcqFLLWog++oSmidAxW8zjT5BdyF6u7eO1sgLZ0=
Received: from DM6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:100::41)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 02:54:36 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::13) by DM6PR03CA0064.outlook.office365.com
 (2603:10b6:5:100::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31 via Frontend
 Transport; Mon, 24 Jul 2023 02:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Mon, 24 Jul 2023 02:54:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 23 Jul
 2023 21:54:35 -0500
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 23 Jul 2023 21:54:34 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <jonathan.kim@amd.com>
Subject: [PATCH] drm/amd: remove repeat code for mes_add_queue_pkt
Date: Mon, 24 Jul 2023 10:54:33 +0800
Message-ID: <20230724025433.426974-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|BN9PR12MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: f77801d9-a4a9-455d-9704-08db8bf150da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKjaF+AeQWR/veZYeBBkBWr2WCkDAvqqsBPnWjffPSowjPa/JghLb8/SNe+AqmM6pFdV6GXM0YJT9H/LzCPh6ygOqgK+iBT9JrbNLM68GEJekPXMO5WtxJ9e4FMQZfa6uehValq5Ujf7rWudhl+ZmJ4rj0kTKOMaWvn6Q62Rkbswbhm/uSa3xpuMUuaF4PCqYwZGjtSoJUamgY5SXQxZ5p8J7Frczndd9VJqclxnIoxEKJxFeQDFauxQbWXfIXinaDD9sUGEq6UT+mEBKe6bM9VxBF3lRiSSNtdhn7TsXpKk72LeHcgeAkEieiqcQyghrESM89CH0R7aemXu7zGD1pSZWqucTV4XYRnK+kQYbw5JWzPJmunSu66ihMHkkgas+ThEf2HDiTlxtVfbDfdwum7f0ZKixuHB77VnnGRQO5u4yb2WksJ9HLBGgDxd10sVot/TF2TEi7uzARnZuCPhLhstQEZP12EekDBpTJuwiW3vOe8BOWF8yMXYOvQ6O2fJOkdHv7vY/WehaNyEbRYQo1I3r2Sac+rGUkJVfZC50WS4AiBjNxetf12h50U0RhRRz7X0Uoi6+UEOE/5UtHM1Q4L+461iIrdM+CXCt01MOdG65RZRYBOldLJL9kOZYTiD0TYEQocv6vXYwg1r1eSAKWR5eMmzsGqaMSp4d9KDu+IZ5+7f/DyHd6U7Ld2ocz/WwtBIG0qYe6reBz1H0bc/ooTI3Oe/oiACErcEWd0OJNzlyJMhRgkiwjdO7jkRt3HOLKRoQJ0G0ozuMnZlXybEjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(356005)(81166007)(40480700001)(36860700001)(36756003)(426003)(2616005)(47076005)(83380400001)(8676002)(8936002)(44832011)(5660300002)(110136005)(54906003)(478600001)(6636002)(4326008)(316002)(70586007)(70206006)(41300700001)(26005)(186003)(336012)(1076003)(7696005)(4744005)(2906002)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 02:54:36.2157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77801d9-a4a9-455d-9704-08db8bf150da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
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
Cc: Bob Zhou <bob.zhou@amd.com>, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The setting of mes_add_queue_pkt is repeat, so remove it.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 8e67e965f7ea..e806331fee42 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -210,10 +210,6 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
 	mes_add_queue_pkt.gds_size = input->queue_size;
 
-	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
-	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
-	mes_add_queue_pkt.gds_size = input->queue_size;
-
 	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-- 
2.34.1

