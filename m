Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423C606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bOXCmX/r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D10810F8CB;
	Wed, 11 Nov 2026 01:42:10 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEEC10F8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BGP6plRug7gPGmLdRY+vcPOblGKbHy9daEh/kb3foFF2AgLCuf+0eOo6mb0KrYY5mt6brbFgdYworb2f/Vkd57eFPEjgn8iUmaeQAGJaorhicbUoiPrPtMnvZp3XtvEk4BcPnRqy5hc4/Ue05d1nhkJDzCgaVlOqhCaKGhEC7DTMVRvuNcoDLrJrEOe+rj/hKKfu7siYBUItlWEvSBJbji2alCXz75Vz6IJt++GLqMNAdC6wnzLh6ay2pSfqM49P52ZOHqglz88Ru5GsYR9UGJitbfoGadtQ0ZI+4K8i2llp3JXEszKhZlhJPriQyIoK7CRKaXzTghY68A1Wn3TeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeSxWqU8i5fK0bWXpm6DIELn9Gx/OJfOzQdyYeA1uTs=;
 b=DJtgP+1N/vN4oJzltjV5SpjvXyTEh8YRoITiyq3lrdYX207+GyC1ZAICHqF205Zfh4sfS9ZPPgyUVkHPDxcAkVhLXvyQU+bqKtcRr6YSINyOFlUJR9yDVQiqkeggDExFEr+GY5+vsMOHiYDegB3ISjPDEM5g3cihy77Wy67v5cnk8ALOXTnDEg7v1uvR/N7vjT64jRudip+8iaLMHivIMdUJISayy0ggUtV8oX1ow0i4vlGWihemaYNktdudh5qhUHDR1YdsImcvUq+QizRl+BmGp4bNfDicY3FxQIoerLbTo3TP1hjRsBONEd565IJL/wJBv/HQvyVnv1hjS6cefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeSxWqU8i5fK0bWXpm6DIELn9Gx/OJfOzQdyYeA1uTs=;
 b=bOXCmX/rdAXy9tsCfrccYQ4EvLSFO8x7HtSQElH+358OnHuTAnNXVyazaNbYWAckUNqbkDGzoLfX0z9RQt9THu/UbrkIOoaSuhLF0PN9zypwHbWNfExlchZyNHBlMpW508Sz3wwzOpJ8YaNEFvk+gd78mWvhqjvz6dgM58BTV88=
Received: from CH2PR14CA0025.namprd14.prod.outlook.com (2603:10b6:610:60::35)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:59 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::66) by CH2PR14CA0025.outlook.office365.com
 (2603:10b6:610:60::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:57 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:54 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 25/74] drm/amd/display: Don't let HPD IRQ handler take dc_lock
 in reset
Date: Wed, 11 Nov 2026 09:28:31 +0800
Message-ID: <20261111014100.3596072-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7a7281-9cb5-4bd6-7b08-08df3f94f998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hcb1ZsAGUQwo9SpK03J0mzjORx7Zr30sW7hD8UU51DosaeNKW154qrP/kKfNCS1QGywgyVdpEBtWZrAe7VjDgGDa8y1mjn/zKQh7M7BPjLeuYUbnIRtkHtDxcc16fNw23FrP8QgBeq51Jogs5kkhC/rpwXAiUBdqTW1yMkdcrT9xZVJccxKO7o0mCD/SlaGRGM/O9zEnHRPGPmnxl8IT6RzTRru3sn5k2VtbyIVCrIPFbP8MOXSWxD7SkDiMRH8OdD4tV3PJ3jtiGFrNO66eASFn5Wm83hIKER4dwXmxMy2DVi3ZMHShJr/G6SAscWJnFjcGi9rMFbUiX9rJQh95gLl1XmTZYVAKiDO2jNP8dDu8mmveFopaGG3qSVD7Tlc8nw3WPJTdf5Yy+P8976CSIv1L7WP92Wlkw3x2B2OPj6SMoxOjE8I1xyaQmM5VM4esdOTaSXfByNFhgGPJDw+7sePtC+z0bBSCjZmuPgJfIupyO9if4uYO9zLZ0JQqxbHC6QJ9CAJfyExSZWRU58wwUkXv/7bEhtmoeVsr10K+5PsZJoWZylYIUYRMfKkduHXQ7L7FLzRqHGkBQ8TtOOGX2kDsOweZV9x97fQEYTWdcna3UN1p9E19+N/7SE95AdQD9mmUDmmEyTmsZNDSNRFuUpLrZW2nrRZifkJoY7DFHF38xeyBZcSL3mXrz/qzB7/PCfcvALa3EuZ1aL606gmbdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hedqU6Cpa420tz/TjUD+eTK+coXipnlruZlV/IFHp4EWYX5KaKvAbxaw2qrr6Y3sKGMFEsTVnZt4BwHI3Ky+YJizV/qZyDmoIdIwgPbmZk3UeDjFyjGNkKobw71D4Blr6JfQWu0cquqZ90jmMoMEo8kf/A1Nfwn/dcp8CVIHz+eypSzvbzQpoxekagoxJNCdOEMDkteNl26xCF/zU19+zdyCdEKnRTdoPrLSgczljcxdWtYyfk25SxqShPsnRNJogFjxzRmvWQMga3y5dF7RlKXS6zfw4Bgf2ckEOwGFFNPPI+3YY9eazo6KjcA1nhVh4g4vv3BqjUgIAxIpUNrKbp6lO8uNkfMRiUezjs/kn1jg4iDk4RaqeqCvAn92V+/guWnpz8h0B+z5G4ARVdaDWNHzPXYJF1DXsJUvdpvZO4MZhxQrYq0IO1ygxJSs9IBP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:58.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a7281-9cb5-4bd6-7b08-08df3f94f998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Zhang <george.zhang@amd.com>

If an HPD event occurs during gpu reset, dm_suspend will take dc_lock.
dm_suspend then calls irq_suspend, which will flush the IRQ workqueue.
This will cause any pending HPD work to try to take dc_lock, causing a
deadlock.

Don't take the lock in the HPD handler if gpu is in reset.

Also fix some KUnit tests that now requires a non-NULL
adev->reset_domain.

Cc: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 10 ++++++----
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   |  6 ++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5b4ff079cd55..18060a9ee890 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1444,10 +1444,12 @@ STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
 			return;
 
-		scoped_guard(mutex, &adev->dm.dc_lock) {
-			dc_exit_ips_for_hw_access(dc);
-			ret = dc_link_detect(aconnector->dc_link, reason);
-		}
+		if (!amdgpu_in_reset(adev))
+			mutex_lock(&adev->dm.dc_lock);
+		dc_exit_ips_for_hw_access(dc);
+		ret = dc_link_detect(aconnector->dc_link, reason);
+		if (!amdgpu_in_reset(adev))
+			mutex_unlock(&adev->dm.dc_lock);
 		if (ret) {
 			/* w/a delay for certain panels */
 			amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index c0c913d95aec..105e3ba38290 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -2746,6 +2746,9 @@ static struct amdgpu_dm_connector *dm_test_setup_hpd_irq_helper(struct kunit *te
 
 	adev = dm_kunit_alloc_adev(test);
 	mutex_init(&adev->dm.dc_lock);
+	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain),
+					   GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->reset_domain);
 
 	aconn = dm_kunit_alloc_connector(test, adev, NULL);
 	mutex_init(&aconn->hpd_lock);
@@ -3462,6 +3465,9 @@ static void dm_test_dmub_hpd_callback_hpd_type(struct kunit *test)
 
 	adev = dm_kunit_alloc_adev(test);
 	mutex_init(&adev->dm.dc_lock);
+	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain),
+					   GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->reset_domain);
 
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dc);
-- 
2.43.0

