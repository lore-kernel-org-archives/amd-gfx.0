Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1FC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 09:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AFCB10E3ED;
	Wed, 16 Mar 2022 09:26:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DEBE10E3CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 09:26:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlC19lukYDFmkXCE2nkP+odHI9Ss7taarpWyyFhMessslMIn3GuP8JFXzYHZb/UQiVi6nDBZ0GWqZje879UlRDJqdGh4WfEstSE1opL0rNrYixBlBH50MXfDGWcB5wnHYU6nJRkxSgZKgMA10B2JV84inxKaVABgurO+bAXIehmjXZ53Feo9+MdcMgS/H9w4Q4IWiQUaBp+gYgLPqjqOSFDleZ93jqihgB2RlkWzeBEIg0/gNVUNym0UsuC1SQdl2LbV7KU0nW7LbsLHU+gnt8PzIg6dy2qOiKwLP+kFqAFM6QJu5OPZK5qBvS0f63HdOPJRDzX6WbfBQUf8rM4gVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebmep+f2wLFZ8P2UJae/tZkAP/hBio4y8bsO+um94uA=;
 b=iKqAkaWrrL5Xtm7HVzUgJ+FhTYIgYqwvs7DpRbc0n3DEF5IiAEAXMUxoGbJ9vnmIuNSsn0I+V13k7ukcLqOy0rIdjlPJbO8tVruAutYA7MUQ067OgfCmOmL2xu7sB01XY+zsHBcaAfYMUfcBYgoorFN3zVaqPcMx6FJ/NZayzNCoUwSncvqgccJZXO3ihWAkCugiavDSacF+42JiEpRvkhFfzto6vm4Nu3Gq5g7Zm/sVRhTm1Of3sRitpIJTyjq9oX9pdKVyLqk7/FFeJ8mfm9nSaLHSJxmcglVXp5tMG8X9q5Uoxmke6Ha3MKogin8vX4kkoaBJumnLiYUuD7Gz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebmep+f2wLFZ8P2UJae/tZkAP/hBio4y8bsO+um94uA=;
 b=BrJbIucUQa/M3S78lhevSv1yH9gWjjf6RdbpptZe7IgfAmSW7LpKRa7chqM+a0ijg+0iLDK2T4+KgreuoRBKcoSN6jPIO1B5JNBr1w+ovJOG7N094cs8E7lD2y24WmvWHMRbnl23GUC2qj2yBTlL7bNh+NnP1Q2Vj/0sWAGixH0=
Received: from DM3PR12CA0098.namprd12.prod.outlook.com (2603:10b6:0:55::18) by
 MN2PR12MB4030.namprd12.prod.outlook.com (2603:10b6:208:159::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 09:26:42 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::7e) by DM3PR12CA0098.outlook.office365.com
 (2603:10b6:0:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 09:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 09:26:41 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 16 Mar
 2022 04:26:38 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/4] drm/amdkfd: replace source_id with client_id for RAS
 poison consumption
Date: Wed, 16 Mar 2022 17:26:25 +0800
Message-ID: <20220316092627.17359-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316092627.17359-1-tao.zhou1@amd.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e59e27e-c843-4ff1-071b-08da072f147e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4030:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4030159FCC9111B6E662DF7BB0119@MN2PR12MB4030.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAGPOsmD4SNFGTNJdZ5AlKWA1FBbTB7+kU+rfjMR0hFLu757HFgp5K9RmCCR/fFTtlZFHtAa1hEvbYZyMPNhuFqWmBCP4NI2IhjvKMx6ysqze8+tSIB7VZWzXRq7XxJDJswez3eg8543P3RZTHDg00D//DmlQniFkolppwZ98pZQi1sqDp+CVAFkfLhT2HK80ZQdeKylBNG7vJcKVh2fOGkA8/fBdIVeumsWF2dREQyX0d68Xa469ZEljbFgrBSCU6Qt2vpxOK/JJS9f+XXx8umsnRycgXvDV0/6EZegJXFmfzHXxsQaBaaJjQjl+gHhfnlA4x232AeZ9EfGkjftZef5rp2RjZOSQXYnbLC0xpYRhzX34WllKSrCq/GQ2YcdvBBj7xbMNuANQWq5sR/8g/N4Bm24psAPz9wE+XQYYVbCp61juG1wIykLr64LTz9j5WzY+YpUn5Wo93XXQLQ3lbgcE5cO8QryQPV64Ys/d7lME9TP3cEfQYE/6FQD1WVhw4uMvcxfPxPoAHrjRgUWV2fqZqizAybC/APOAZAhkgKN5jGML0sHfH/PRADzTaiuJPAvJp0m3SnEYo2Tkx/I2h6OpBI4A8ufrJG5Lbo8N95+rm6hqq4LMnfTQJTPIqRU9oR7ak/VADHSIlzOYADaeGJ0e85iam10NgoRD/TiWKj9wB1SKOL0MKGBIGeZ8RJd2Uy1mOyNfZE6zuxvy2CXtg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(6636002)(110136005)(86362001)(356005)(81166007)(1076003)(316002)(83380400001)(36756003)(26005)(186003)(426003)(16526019)(336012)(8936002)(70206006)(8676002)(4326008)(70586007)(508600001)(6666004)(47076005)(40460700003)(2616005)(7696005)(82310400004)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 09:26:41.3913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e59e27e-c843-4ff1-071b-08da072f147e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4030
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

client_id is more accruate here and we can deal with more different
cases.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index a992798ff8b6..e5f03f79546f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -91,7 +91,7 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
 static void event_interrupt_poison_consumption(struct kfd_dev *dev,
-				uint16_t pasid, uint16_t source_id)
+				uint16_t pasid, uint16_t client_id)
 {
 	int old_poison, ret = -EINVAL;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
@@ -107,11 +107,24 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 
 	pr_warn("RAS poison consumption handling\n");
 
-	switch (source_id) {
-	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
+	switch (client_id) {
+	case SOC15_IH_CLIENTID_GRBM_CP:
+	case SOC15_IH_CLIENTID_SE0SH:
+	case SOC15_IH_CLIENTID_SE1SH:
+	case SOC15_IH_CLIENTID_SE2SH:
+	case SOC15_IH_CLIENTID_SE3SH:
+	case SOC15_IH_CLIENTID_UTCL2:
 		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
-	case SOC15_INTSRC_SDMA_ECC:
+	case SOC15_IH_CLIENTID_SDMA0:
+	case SOC15_IH_CLIENTID_SDMA1:
+	case SOC15_IH_CLIENTID_SDMA2:
+	case SOC15_IH_CLIENTID_SDMA3:
+	case SOC15_IH_CLIENTID_SDMA4:
+	case SOC15_IH_CLIENTID_SDMA5:
+	case SOC15_IH_CLIENTID_SDMA6:
+	case SOC15_IH_CLIENTID_SDMA7:
+		break;
 	default:
 		break;
 	}
@@ -269,7 +282,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					event_interrupt_poison_consumption(dev, pasid, source_id);
+					event_interrupt_poison_consumption(dev, pasid, client_id);
 					return;
 				}
 				break;
@@ -290,7 +303,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
 		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
-			event_interrupt_poison_consumption(dev, pasid, source_id);
+			event_interrupt_poison_consumption(dev, pasid, client_id);
 			return;
 		}
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
-- 
2.35.1

