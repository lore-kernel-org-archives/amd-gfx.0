Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D5C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C37510E9D0;
	Wed, 28 Sep 2022 19:42:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B66810E9B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXKVhyvnxdqE/jXC8G72HEDijtYUBcy7c7EB15pYHUsKlhTCaHk9ji2L3WAuTe817sgFHbf01canb8h5NHo44ZqffVrhCX4TwdhPPZ4hcwizHzbAD9liixzLAma2kg5rWGT7eAP+RweG6xk6efK0zussniSwZRnmbkQ7TrxnJiekUAwHoSJzf+XF5h91zWcspLhvnZ6KedjS8QZz3SJxpQRHExROzBgosvAwEeRKgpgwAEwp05X6vFRWWVLG4yyzqjtHP4ZEAjhPv+n1qGMjc6ql/+EzbcC9g0/wpMKV0bvfeq1Jjmr1AbS9FSl3ecKFyFT9TKQ9RyZijwFf54/SqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vgEjp+TDb9SvfojGrdAFYWYPkZfgw6Rgre6/blKmQI=;
 b=VSFEGI+EBMZM0feBcs7WxdtA3g7uHStHPvlcHDHILIhZBR54JQHE1C8l2xo7F4bMFHlVvj8Ucxc1w8odlLUqr4Hj1TARbS/3XCOSPr+TjtaR6UEOsD6bt5xrPIVd8fnmaB77BRxt3fpDNMQ6QotozNrjxX66ySlAOpej983xklyKzMtPl8QbYIlcH3mOiBHvSrnvEgBeFI9E1G/eXGfAhWifEz6Jnn6wmfN7RAh0lF2R4Kqs8pYp9tilAQQT8vWjUOfW8ZepR+cPggtg+diUQ8vtPc5STvUWx2AVECcc8sEhABpLo66KnFanwkbQsgx6gyMc0T7jJHbZ7la4Cjq5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vgEjp+TDb9SvfojGrdAFYWYPkZfgw6Rgre6/blKmQI=;
 b=OWwn/PT9rY62tT8u0kFBRg7ceaeyHhefVokwCiFNNFGxERH7uTIrL0oGxqTdKwoTMrnqR3MMfHwGg2aRLRt2jdezobeOsujVxOyf1G2keY6MWMb9AN6EmwP+F1ggyXxQyTchSa2ewLv/kOH91ut7CtJqs+VOursy1CVS/zCKkV4=
Received: from BN9PR03CA0684.namprd03.prod.outlook.com (2603:10b6:408:10e::29)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Wed, 28 Sep
 2022 19:41:03 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::e6) by BN9PR03CA0684.outlook.office365.com
 (2603:10b6:408:10e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Wed, 28 Sep 2022 19:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:41:03 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:41:01 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/36] drm/amd/display: AUX tracing cleanup
Date: Wed, 28 Sep 2022 15:40:03 -0400
Message-ID: <20220928194028.144879-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd7917e-71be-49ac-99ca-08daa1896102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avc3tOUcRnQJkZdaubO4qc7kClwkJGucEb9J912VjPj3HK9f+xAMdbV/LiiU2UhexOWHQAnJDVeQ6aRxNpkM6uerPFVjq4tjOdGwLmFPEmzj6h3oS+C4WnfvQggdX7nICM559kmQETM4O0OIbeLrfre/6l+tKLJQfzch6yAq9130UyBz3Wqn0Ke9MfO7trFRpHiHThDdC9A9kt3PXiECM5oKMOuEO39mirR6vq08CCydi1wkgkaQIPN/S+wRqfan8GbWkdyqtbVxQ/7EpVrcgO9oPZ8nGD/zzMCkddegTJ6OkEmgg6ZAMvh+BQZ/hKNsNhGCWHkLbuNQpgROwUr3ASeXXLufKmxJ7El5X5uMs1loRfn3ampqr3GEnQDNIi/SnvS5QBM9e1bbo71v3VUMeW2baXM9LSM14mvgFRBCEeFOzoMbA1VsfU705ZFex6iRrfP8CybE0dx1eBc5hrhNSgv2atnNbnuyNeiAf28u3OvYqoxdjH1s/rkvjLITZAs8gv+cnZcxaJFsQFQu8bakbt83rebd1X8IH2oMGdA8cb8dI7Q2EhMQ410Wuz0TVpBs5Auqv5QAeEXwEcJDN7DdJUkl4bpEHpVpK9oNrplklyghbb9WMLDxK9R7evz4V4b4aJo1lyXeqxxXELZmetm7Qu12piliTohWzayBaDJ4dy//0f1CwLrxcCOBu+d7r2wprroh1qYCbaiDg8NrL7IsuwUkd+pFhPUnznKfLXycoQbNZ7JNxAkqvHcrUjrYAibfjTVOBefEuUTj71LwTudJz9PGwiMaoxs3G0hIDo+Lmg/tEMx2wmfsXfGLlLt0tV+buv7B2iJnxQzRMuf9wd3AfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(86362001)(54906003)(6916009)(36860700001)(426003)(316002)(5660300002)(40460700003)(47076005)(41300700001)(8936002)(186003)(7696005)(2616005)(44832011)(336012)(2906002)(16526019)(70206006)(8676002)(70586007)(4326008)(83380400001)(36756003)(26005)(1076003)(81166007)(356005)(478600001)(82310400005)(40480700001)(82740400003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:41:03.4936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd7917e-71be-49ac-99ca-08daa1896102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
Remove the unnecessary AUX trace and use one trace for AUX failure.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 32782ef9ef77..140297c8ff55 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -942,10 +942,6 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		case AUX_RET_ERROR_ENGINE_ACQUIRE:
 		case AUX_RET_ERROR_UNKNOWN:
 		default:
-			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
-						LOG_FLAG_I2cAux_DceAux,
-						"dce_aux_transfer_with_retries: Failure: operation_result=%d",
-						(int)operation_result);
 			goto fail;
 		}
 	}
@@ -953,14 +949,11 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 fail:
 	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
 				LOG_FLAG_Error_I2cAux,
-				"dce_aux_transfer_with_retries: FAILURE");
+				"%s: Failure: operation_result=%d",
+				__func__,
+				(int)operation_result);
 	if (!payload_reply)
 		payload->reply = NULL;
 
-	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
-				WPP_BIT_FLAG_DC_ERROR,
-				"AUX transaction failed. Result: %d",
-				operation_result);
-
 	return false;
 }
-- 
2.37.2

