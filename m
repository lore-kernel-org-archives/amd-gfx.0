Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458ACEE57CF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 18:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF52D10EA75;
	Wed, 11 Sep 2024 18:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mOjxVOuY";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC0010EA66
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 18:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtI4Iwcsfbtn99sVxWfobKo+ludiSbaxHqYrvJvCsq3UiIoAe9RVQP/loJDrWNeh5AHbKyVdBlr5aU+jZEPYmj0MzEaIpJOjvocYtb8UXFI1+EUZtnK6lowI8wRzqNxFOrMFf8tIzgGAKFaRdBkD7fvXHuGyFcDtuT5bdPFh2DYSlzRRq8rmvEcCu94opj8dwgcTmRF+3Xk9mI+XU7OQ7eE9dIirO9QOBZrXUPabeTsbfPvbxyPDWe/5me0Rf1U3xKWMagPJSNFqVNGqWp0s2NaEddg2wMAeBn18cofprX9ziK3Mkuww2djSRkhgZIDr6LcWS24BKGnN+aj7h0Skbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX4U+FnK+IjgO090jeaGjJEJBq/fhckjPvHT/xfSJOc=;
 b=rStbdXOOgdpYbO2zu7Cvukx9DkJ11U7ZG8m9QXe6KuKixk3tBFty6CsQSr9+HMjN+CigxJPw9LJsUlSodNLC203km4/dUijaNTp51r8VdPpGCNJ/ZnW/g0boxwAO5fcI6eglBMuA8ksnDp27SfWkLLu79X03PQ6/N/aHXJloaxc76td5LSyQpCv+suVkwK5xA3grhrkKPilidjWRA7yIoN5ujm67oZ+OLDbscNBD45dOXbvHiMxeM3120VxQhZKWRJHHmAGoiAP5mLne6bJscUt6zkAHH3uX9I/IqEOe3Juv7hHWpVwvWvAzcOb8ztoHqdjVTk2e++/iBnPwKzIsrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX4U+FnK+IjgO090jeaGjJEJBq/fhckjPvHT/xfSJOc=;
 b=mOjxVOuYmHU0wjK6qp1ig4VUwPo2rF8w9XG/sx2UOqNww0UgrLsV7/UWRtapJogxn3VtL83f+tEUcOL4LdJ3FcZUFRWHys0p3VGMU1LIdC4DTgRTKCoRCct2OzlP7cscjh4e22ZsVjBSO/OQTvseQ+xwYkHoql1257C0ecCQ81w=
Received: from MW4PR03CA0104.namprd03.prod.outlook.com (2603:10b6:303:b7::19)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 18:06:44 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::36) by MW4PR03CA0104.outlook.office365.com
 (2603:10b6:303:b7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Wed, 11 Sep 2024 18:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 18:06:43 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 13:06:42 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Retry i2c transfer once if it fails on SMU13.0.6
Date: Wed, 11 Sep 2024 14:05:45 -0400
Message-ID: <20240911180545.519385-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b0f0d2-f451-4bf4-dd71-08dcd28c7e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bD24MHIAvA7uK7gdysMPrLaIWYOGvP/6MrGQT5k7sepjHI7m3bFwQvsnvW1D?=
 =?us-ascii?Q?NnrJIUVdW+N9R3edYLkPimCfee1kc9+77+WOF4jAZug9m7GccxZ3Q+id1CQD?=
 =?us-ascii?Q?QCroF/wI865hTw0CbfOznaL3M6/2dFtiSLs36j5nEIMrrG7eES6+9uOYRrAY?=
 =?us-ascii?Q?wvPJBZLmxta3gGb7LPt6L5b7FBNPz/BmYjbvx2WliitJ/J0hf/ysySCbEo5I?=
 =?us-ascii?Q?LTpAz/xjDxX5dXCbu/b+IO8beciow+RkHJIgRsm8jojiPwETDZ2fHIV20snS?=
 =?us-ascii?Q?558CvtMUHAtzi/R4k5sUHmWO+r6iJzZadg3bC5En+GyB94kiA/C9deSno3dR?=
 =?us-ascii?Q?oc6mkLBceBLqXdA3PMmiWPk+q8lWpGp5+ihnyf6qVjABS0I/CEUt2DMLFVQ5?=
 =?us-ascii?Q?k1dgtrVHuqsTSxxKwXqGHlbFGjCDOwtoJR3pHLD9BlLR0T+alv7CFKLIwqDU?=
 =?us-ascii?Q?zMKrZ5ZrwE1kGVhAiFKmP4tBEd6UmMvTrMBJRJNR15u1pmZsuJZPmT4OYd5u?=
 =?us-ascii?Q?tv/gIEiJZfMnXzRqUadmIu7GPmdUPkiAd6P3Dc6RGyTvAZpoXEKqCG5JsyYy?=
 =?us-ascii?Q?Y5pSzFQxhfwZbvbrCiGSbs1e4oyk7bbdd10xsgpGs4UEbCbKBSIkAkamX3jc?=
 =?us-ascii?Q?iDb1JKODgpPCt7HxLapxy9bpogTH9fADXft5mCN6FAi6BbG5SOWTLmLtNjA3?=
 =?us-ascii?Q?7CitOQFn2spYjQRDYC69S+imrpnwHmpby5NR7iAo8TOcGmtVZWs5iOXrqsCf?=
 =?us-ascii?Q?AWgIsx4ry4PyDsQkOLeOp01REKoDwd0jn27gCdyYK2nIodyGFWsRwakpvKZZ?=
 =?us-ascii?Q?Vi96rY3/94wBfNF5PnAfmx1uw4SIzXtMAgf3WhjEV2e3J/Yp3P2zBD7CLOVU?=
 =?us-ascii?Q?pzFEfqLBbPMcSG/K6OtZFjdO7UeMJArRcIMQ8TKEhJd0eadREIt7/+2BjIN9?=
 =?us-ascii?Q?ue8vWopXi7tTojN+Favtt8vbJ1ilEGaijXbif/3yLUqxhEOn4C7+n+4r1SEC?=
 =?us-ascii?Q?RQdNUargTRVOaCFQnjXxv+4X3bVONEBYLrAxhl0+CUc1fswnRiztN51Vj1D+?=
 =?us-ascii?Q?mr/MklH0Wf9qkDjnDQQZmHeM9eKaFUhpehE7M6i6ysYocfHwwDDeLwBBkMQc?=
 =?us-ascii?Q?TsjRgvKBueRv3nEIi+VUXeiHWsstHci2INoHMWJ9OAXK8C26gmBBetE/Uvx7?=
 =?us-ascii?Q?MBFVJ0GYLOrV14MQ1y56Nf50sM4i5RxHYBPZdSIfk/pTfRXfIIq+MrOBirdw?=
 =?us-ascii?Q?YzvbtlMqSXmH0MihfvQmJcJ3F57aDxH9QQRFZbxxqmZ1NTYlH4/gqFzdj6ra?=
 =?us-ascii?Q?bQEgudoh5EjgK4Nhpde99nntzFyxtGo4wqEng3wlOhaBkAVBmcfZ3+MNT1Ns?=
 =?us-ascii?Q?NWNK5zeduk52LR7KQlRqJ7yREcMMkRti4O0L64q43ugCOcezA11VMeWdIqn4?=
 =?us-ascii?Q?DNo2pDGXC/maJ3Nu8En+ouX4IG8OLCby?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 18:06:43.9734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b0f0d2-f451-4bf4-dd71-08dcd28c7e9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
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

During init, there can be some collisions on the i2c bus that result in
the EEPROM read failing. This has been mitigated in the PMFW to a
degree, but there is still a small chance that the bus will be busy.
When the read fails during RAS init, that disables page retirement
altogether, which is obviously not ideal. To try to avoid that
situation, set the eeprom_read function to retry once if the first read
fails, specifically for smu_v13_0_6.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 9974c9f8135e..65d24c2f7e24 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2107,8 +2107,12 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_v13_0_6_request_i2c_xfer(smu, req);
-	if (r)
-		goto fail;
+	if (r) {
+		/* Rrtry once, in case of an i2c collision */
+		r = smu_v13_0_6_request_i2c_xfer(smu, req);
+		if (r) 
+			goto fail;
+	}
 
 	for (c = i = 0; i < num_msgs; i++) {
 		if (!(msg[i].flags & I2C_M_RD)) {
-- 
2.34.1

