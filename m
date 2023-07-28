Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15DAC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 15:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C84E10E713;
	Fri, 28 Jul 2023 15:23:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0C210E713
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 15:23:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxPl7TgHPDICOchkxSeEuqDLlkNHesK2UVVjHwgFw2O/b7eI65LSZsTuBYt4PT72AaQ+UPr8xA33nNrGs+OpZ5auWnHQ3tX/E8FzpE8r+KOm8J5qJy7ZElgQ98Y7AzNOcEPLZHI0SIlIIy+mXwLddl5pWl+rN1DMHquh6d/sGJFRq5MRaPG/s/bPjv2GuDkiZjxSzG4J84b5sYDcMDe+PTbcwLGqsXciv35iuiOm80jGGMJKnaaZ4DRdZAwgdG4TSL6vN87d0nyouk89scHBc4BgFsrk4dUC97EDgX1mQHnIWFiAv58jmPaeCg12BLEZS+VEWdjLX6RKuWLvqqFO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwZzjc2PWvUHmR9jwzP7FcFnw3ipN4qkRdJNhiAkXzI=;
 b=Idt5SgAxUSMnH1Mltb2jhOZSLBPb0dIxbY8lPU/afEB1sbho9KHrnXkVzxePfdt3rT0lHNFsOAwvGp9yStTaW7JTYLmPvDgkvOtQ1q/qlaNDE/KeyHLvSzhT17/No1Efdk25tgxYZAFft9Mg0ZmvUyL16TGwt/r52OBI84glN3ptpMdKtQrlACE86uedz/0f1ayROXckqyn2M1yQavIFc1r9dvBDzsZdsJenvJMaQk9ks3533JkPx4tTcAum8buID01FLONHdNH+VVPwNXcdzntV8rUvc2gtcaC3nppUVJnAUbqgV7ffMo1l35gF7ABum1kx/2/9CIbYKmtwAW1guA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwZzjc2PWvUHmR9jwzP7FcFnw3ipN4qkRdJNhiAkXzI=;
 b=kL55QoUidBZI0mRMxeJeqWbEZYNQZSpar6SvzS132YuwKpK4sBihOzRLGYOVwEf3HOFoVMJ6LMNgRyaJGvO82jyg4bkTVpa0AVuG1kYt3gDOWbd9qS70u3lNVBN4rimZKmt0/zWVNjnw+XUzDkra3T/mjjsrEY6az7fyUwWX6o4=
Received: from SJ0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:a03:331::31)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 15:23:04 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::2d) by SJ0PR03CA0086.outlook.office365.com
 (2603:10b6:a03:331::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 15:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Fri, 28 Jul 2023 15:23:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 10:23:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix possible UAF in amdgpu_cs_pass1()
Date: Fri, 28 Jul 2023 11:22:48 -0400
Message-ID: <20230728152248.3290911-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 866ef88b-0100-4b41-85fe-08db8f7e89f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVt/ubYsUHh5+IIJtSkIOqS1LsjkTYsWOPduiBliAWmAV73zbQZHbqd15ViABy7c0i6AfMTnPI0TrfPjxQ6moJtGHpXnUCNgolQmXqOjOluGXlkt0Fvzi8GiqmOc9VicHBjObOmJ/B4jIwUfaiTX95sz7QzMMpjv03O3k5fyaWFYsNk+CnyLsiSGQ1n+Z4eEIjx92p1uEuJUOgsAXJvThWQ69QWZkQnJC3Lp3U5LcFP4wP80NB+0pjZf3C/tOB0VInGPgTmSKE+EMiWH8TjmJgPJ6hQIjge+rBZgskQpOqsfgsbtjUaBpUV0QymF3/6xEDg4C2bdcipwhMvQ3la3C2BmZBofktMxKeUpD7pLUlMqKVL5T8UyW9rnyje17U2pmSwUqZDlLbd1gnYNQt+PJNULpZeSB/6eINj+AuyUl94LFiP3/S6fsYREsmXVgeQI51AN/hXD3G8K0wNTew6CwPysCj6G3bgzE0S+RKE8B7CJ7jRHXzZ6h26RKSc4S1SM5et1PjHhalDU+YiF1e13IYIZg/D+DVNrIrgBXr8shE3d8xGqHSTOY+vA0VwLgMYrJ29YgQ1naIrYF4f8qsfpR9Wgu7+6x3M2VUfpcSp2rLIgazZ3iMHxqx46aKaNebsJZ20bseFOGnKsOqPZABt2lM2Yp6SJvwAPjxoH1weecM99hfBEmMDq5eUENYcjOFQQ/SpRIYooRrjrkjntmQ2W+TRQ/7r3qbAScTPbr2Xp9ydyWZT0t0b0XtoX7QL2a8e1xaSNeP/Bhs7KcCbbEnSyfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(82740400003)(478600001)(356005)(83380400001)(47076005)(26005)(1076003)(6916009)(70586007)(70206006)(81166007)(336012)(186003)(426003)(36860700001)(16526019)(4326008)(2616005)(5660300002)(86362001)(41300700001)(40460700003)(316002)(2906002)(4744005)(8676002)(8936002)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 15:23:04.4805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866ef88b-0100-4b41-85fe-08db8f7e89f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since the gang_size check is outside of chunk parsing
loop, we need to reset i before we free the chunk data.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 040f4cb6ab2d0..fb78a8f475879 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -295,7 +295,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 	if (!p->gang_size) {
 		ret = -EINVAL;
-		goto free_partial_kdata;
+		goto free_all_kdata;
 	}
 
 	for (i = 0; i < p->gang_size; ++i) {
-- 
2.41.0

