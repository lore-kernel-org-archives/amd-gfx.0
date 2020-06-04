Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E8C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E6E2072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QeJT1UiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E6E2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39256E196;
	Thu,  4 Jun 2020 04:47:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54B66E196
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH4Dpe3x6mXVHT4x91rmNZTZOXK/nKt6UL6TyzgPvoQ6ZDV1U7SkTqo0IVznon1DV+0CqwOVX4nd8XmCLicUrTWR3WXmk5BbMl/6N7M/4BXti2LWtxWANMJkTVGIKZ2gb0Ja9D7cU3Izr4Z1ttkNDyOQgG0NwRy3+y83m+0ol+pFhoNkon5DGOvwKkepW0SDI4F8sGUub9vKFkoaXHEmTuBpOU7R0Y3oiAokBBkYqIwsPdFHcnlvUakgdw/+RlcdgL3jFxXMdSw/wbkEGRPpobgcpAC/9raAPvq8NuQSMTHPKA5PJ3Fb6RiTZomr74sJal75724XeFeN5S5sumIbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5asWcYYzozYjyKd6NImgtEUvsCbgD5jJSE4AyMscy08=;
 b=DleZ/0mkduhcjSFU+bcDSfimvpQwb2nwt/09Zoe4x67WrKv5GAbiqUmEokeP+sr4vR8/X9P4G1CJjqKuJXIG6vvgr7EExIXPhzxnC0KSW8hz9QMQchGrl1wHJDWMbRIhUyGkQI7r2iBnG9Fx38k9iSXeD1VrgwkTlGGxWrIxIXYrdB6DxmQPmPSR4txkZEUegp5Wi3Ml5EvFP7csd/HTfBu0lXUd7ixInvZaKztCMsEUvtuEo5/NoybY/G7Qdv+vAcy9rBgapeGydhcl1yoG7yy7CgkU7yRycMRJIcZ5OOyrGdBDA9genmazX/iDafUWcRNlkMPcGY0JNjkjfLOuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5asWcYYzozYjyKd6NImgtEUvsCbgD5jJSE4AyMscy08=;
 b=QeJT1UiWE0r9AoqKJwKNfugnGGsrUdIw/1DmmAplLr+7jIaFVlcqbDPE+YwA/DpXPgfbrEVlZnZUpWFUi5eE5zTdhFJUh+crEbHseGEUjNtMFHc9yXoCaN4qEypCW2Z5V2Q6PaaHAzKYBY3DQQJbEydu3k1tSlbtg5TZSZqr2kE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 04:47:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/16] drm/amd/powerplay: max code sharing between .hw_init
 and .resume
Date: Thu,  4 Jun 2020 12:46:13 +0800
Message-Id: <20200604044619.18658-10-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:08 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 840a3ba7-9b9e-4bb5-e297-08d80842576a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32120B1266CF5B127EC0E688E4890@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKc3xtj8HJ4+ER4QAEdGvtLct2herx7SX1nC/qELbAUoLpsxGS4PQ+mOgY8++81XPiw9lrGPLjsl3sABkCpTC091YqEOevpph09l2S4OqvbmbJH2Z4wdZlY3/F47AwWa0HEJv8FyNOz8juR1+pkLDVr8r3MEVFiQFqbvG1SliSGZZQsBG19/xT1Nqg+sMU1blcp8xKrZC8MhP9RMxlt6EKoz0FtCwqm21XgS7o+RnEb8aQDbutQkwbNB5PgncU/NjSs20kZ2vCVoMOug5rbghiqP+DsWpOcyXjy7CHfezRDOhGY+RSil9+JJhvyufBA/vsw0RVaqHdtwsRw/pSAIJiJX6wfpvw7CGkUepRlhP61BTzY7RzvPNICTFI48PoTW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(8936002)(8676002)(316002)(2906002)(6666004)(6916009)(956004)(186003)(66556008)(1076003)(6486002)(16526019)(478600001)(52116002)(7696005)(4326008)(83380400001)(36756003)(2616005)(66476007)(66946007)(5660300002)(86362001)(26005)(44832011)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: M10s9nsWsqN7Dz3DoxrVhgWpKJI+f/gQfTLABgBnxVWooRE9qoOfCqBpMeW9P3CvtBZT0vwcBMVbTon0GB72ueQj6tY/kbrNnrYHmZQRan9r/F0R3jiC7XJDYgpaDHH8If0Jp0+LQgSjTLIVL2cRVPLmaup/uzQIslTZYdlZUnCoq9opOvnHu9HVOMFkF8IX62eLbO8xfPjZyzfTGBL3ZNEv174R7xalgk2ab56CzbI/kXYNFgHY7bjMAZ77UmFMxF63w5tDLnBIdUFgVSGDoq2qJXLPdCjmGJVFV77dYD1JItDHjVJY+ivmbc37bHtAFBMXO/0mKbudiJik9U+lplqeRkZvDhMEUb1ERueyf4NUp5Ul3cuhYPySHS9Viry2TwNT4xjhxsBw2h9STEKo2o/QNd9UNjNrnmaFOuC6HftZ2VDrQJ1KVUViYd0jKL5H6YVoqNdipd3l3YRcNFFbrUgMnqczhZChCJrkVTnZ8vEaukmHXRZvacTAPFGcOole
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840a3ba7-9b9e-4bb5-e297-08d80842576a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:10.2350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fK4JvL5Svfyke6oJbEf5c+RtpRIWGcyYkf1EzQBHfYx8n9VEaFOSWdfQN++sNF2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Then redundant code can be dropped.

Change-Id: Icbafbb7ffc8189a09f4236786aea6702ee73f9f4
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 42 ++++++++++------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 3bd6b9a5b63c..4c1f7c36b74b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1193,10 +1193,28 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	 * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
 	 */
 	ret = smu_set_tool_table_location(smu);
+	if (ret)
+		return ret;
 
 	if (!smu_is_dpm_running(smu))
 		pr_info("dpm has been disabled\n");
 
+	/*
+	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
+	 * pool location.
+	 */
+	ret = smu_notify_memory_pool_location(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_enable_thermal_alert(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+	if (ret)
+		return ret;
+
 	return ret;
 }
 
@@ -1276,22 +1294,6 @@ static int smu_hw_init(void *handle)
 	if (ret)
 		goto failed;
 
-	/*
-	 * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
-	 * pool location.
-	 */
-	ret = smu_notify_memory_pool_location(smu);
-	if (ret)
-		goto failed;
-
-	ret = smu_enable_thermal_alert(smu);
-	if (ret)
-		goto failed;
-
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-	if (ret)
-		goto failed;
-
 	adev->pm.dpm_enabled = true;
 
 	pr_info("SMU is initialized successfully!\n");
@@ -1488,14 +1490,6 @@ static int smu_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = smu_enable_thermal_alert(smu);
-	if (ret)
-		goto failed;
-
-	ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
-	if (ret)
-		goto failed;
-
 	if (smu->is_apu)
 		smu_set_gfx_cgpg(&adev->smu, true);
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
