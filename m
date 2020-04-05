Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A30C2BA1B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AE020644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B9tUTN8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AE020644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A386C6E293;
	Sun,  5 Apr 2020 20:41:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6360F6E22E
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhosC8vsYtKiASa2vG6ulAfcZYSmLLom2dbz3VRw6o9OnaZBrCrf37vYx6iF0Ac8lyaFhcXLJJf91QT9q5S6lZZHoubEb+QSOv+jvQMLHQx8TNL07Evto0MXJVdT/C7UyHULozqnA0vrKxFBdViZLqf6QH1zxoJllV4r2vbufCWVwablqOKHRiD6D0xUTwr3+2AdmDDE3cJS2Vs/kYLLh4x8Q8QvsqgrWFPkRsZn0ydFuFvfCMmAngxHtfhQ92jHbKx75RY/IiNAUluqaYCgh9ELxYyJCqQAULkNRNQna2JhSe7jXe9ynIrV8IZIoUGZYqHTY0mNGFtnYZ/Aj2PxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj6YczhlcjsTZAmSiXBi987aeYd01rDw9+PjCoLm7ok=;
 b=cLmfEjwdw7KStSI9uGAh4w49xpwQXtIZ3Q1hEc+4ydlLqCWccTssL3/j5RmmJ+z8iLcP7OL8OaZFdvDnbrieWR/2Ql+By8Yrov6oUPYQT7tQzgndg/WklQWjK44iWeZgyoQ1aWuRCFEcfDYCpxucux0ZMOuDCXrmI6ZeyMrkJznwvsKKcu6ehF1+w5WGRygFGkFCnV4M2O8TAkX7Lmd+kEx7r+o2xiROfosP8NMbyFuVJBVTR6bGpLDuuOySL51ECU4JdsYhWBk54s29zD5RL/RC/cbvaxSLP/2BbyzVDDRaoFbsKzKmWJhsfGe0RHJRw7fULjnWbytRgKy/KIZmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj6YczhlcjsTZAmSiXBi987aeYd01rDw9+PjCoLm7ok=;
 b=B9tUTN8xxvf0j5cZWKENfvjII2Lk3mBx0H7RIiVjjAFJnE9cNEIj3m9Xzjcc0t6fikJPhbNzNtXpB1QWGyCjVSiW0qNmDk7Of4Kd3gdDi0su6Jaq+ElWKR49x5Tsv0SEZ8f3tMUIZtL0vCK9qI0JeDLR/yX4MmjjbegqPXLU6pU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/36] drm/amd/display: fix typo
Date: Sun,  5 Apr 2020 16:40:50 -0400
Message-Id: <20200405204115.683559-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:49 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a11a0d9d-df7a-43c8-97e3-08d7d9a1c3e9
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255560926409A2A34A311FD098C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OA3XQ4ywBDfFaG1TstaqUZ3Bshu9nXycCiFtx/lzK7tuQ0gIsNt7JHnjF7eORpwpTSEmbe6sc4eERIkelmskfKdxOdzCPmA2fbrP7y3jvlE4XMowrKhZAbnU8nMp/sQ/S7aGlP5K/pNRQfatal/9NnLXVB4nqvgIDw3/o2akygWvQDcR/pvYuA9/ogpFzs6rfuhYh9yR/h1igEpkcLCV3janMOtIAeG62ATw/HhtlvmLiYdLlvshgw0KRMMdxDCSuQGe9GwX+X72DgWw9PyjpINai67p+MGda3buFoyVTLePBoz/0h7rCS0UhzOeu7gJR4y9KAgYC7URfB2aZDjRzsrEPxXYknos5nC+4QpYjjU1FWVrSOIWlsMZBQX8ZwGQ6PHQWg89oCZMUPW93cOxn6YshUPrB0gLi3jEGMS6OgmrICykabuL08jcXrT63jA2
X-MS-Exchange-AntiSpam-MessageData: rbbM+z/b5g4dK+GMZXLzvoLGqyk16oYoSJey733S8UJsWPILgroc+I2BvcSfi7zPdlmUA16cd7xHEGabUm+S2KR3QuHpgtBtKxc7fCJqjZ8ZkSeWkVE/qVAB70q5g1G+rsv+ZPrVOJy8uY4WgQauOJN4inM5ufTYQB9KgyzsakY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11a0d9d-df7a-43c8-97e3-08d7d9a1c3e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:49.9080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nhpCcnUgCkXeOyQBDHPvVR5D75Qa13NrtZ2MNJJGsEZRKeiHb/VJoAY9V/l4RcoPGD5A0nRhC/HjJQk6xusIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, Joseph Gravenor <joseph.gravenor@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joseph Gravenor <joseph.gravenor@amd.com>

[why]
MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION and
MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION were supposed to be
MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE and
MOD_HDCP_STATUS_HDCP2_ENABLE_ENCRYPTION_FAILURE. Because of this
it always seems like mod_hdcp_hdcp1_enable_encryption
and mod_hdcp_hdcp2_enable_encryption are always passing

[how]
rename the elements to what they were supposed to be called

Signed-off-by: Joseph Gravenor <joseph.gravenor@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c | 8 ++++----
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c | 4 ++--
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h  | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
index 44956f9ba178..fb6a19d020f9 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
@@ -98,8 +98,8 @@ char *mod_hdcp_status_to_str(int32_t status)
 		return "MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE";
 	case MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED:
 		return "MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED";
-	case MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION:
-		return "MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION";
+	case MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE:
+		return "MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE";
 	case MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE:
 		return "MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE";
 	case MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE:
@@ -158,8 +158,8 @@ char *mod_hdcp_status_to_str(int32_t status)
 		return "MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED";
 	case MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY:
 		return "MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY";
-	case MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION:
-		return "MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION";
+	case MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE:
+		return "MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE";
 	case MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING:
 		return "MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING";
 	case MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE:
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 1b54f169392a..39834c8e9993 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -239,7 +239,7 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
 	psp_hdcp_invoke(psp, hdcp_cmd->cmd_id);
 
 	if (hdcp_cmd->hdcp_status != TA_HDCP_STATUS__SUCCESS)
-		return MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION;
+		return MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE;
 
 	if (!is_dp_mst_hdcp(hdcp)) {
 		display->state = MOD_HDCP_DISPLAY_ENCRYPTION_ENABLED;
@@ -760,7 +760,7 @@ enum mod_hdcp_status mod_hdcp_hdcp2_enable_dp_stream_encryption(struct mod_hdcp
 	}
 
 	return (hdcp_cmd->hdcp_status == TA_HDCP_STATUS__SUCCESS) ? MOD_HDCP_STATUS_SUCCESS
-								  : MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION;
+								  : MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE;
 }
 
 enum mod_hdcp_status mod_hdcp_hdcp2_prepare_stream_management(struct mod_hdcp *hdcp)
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index eae9309cfb24..eed560eecbab 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -60,7 +60,7 @@ enum mod_hdcp_status {
 	MOD_HDCP_STATUS_HDCP1_KSV_LIST_NOT_READY,
 	MOD_HDCP_STATUS_HDCP1_VALIDATE_KSV_LIST_FAILURE,
 	MOD_HDCP_STATUS_HDCP1_KSV_LIST_REVOKED,
-	MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION,
+	MOD_HDCP_STATUS_HDCP1_ENABLE_ENCRYPTION_FAILURE,
 	MOD_HDCP_STATUS_HDCP1_ENABLE_STREAM_ENCRYPTION_FAILURE,
 	MOD_HDCP_STATUS_HDCP1_MAX_CASCADE_EXCEEDED_FAILURE,
 	MOD_HDCP_STATUS_HDCP1_MAX_DEVS_EXCEEDED_FAILURE,
@@ -90,7 +90,7 @@ enum mod_hdcp_status {
 	MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_NOT_READY,
 	MOD_HDCP_STATUS_HDCP2_VALIDATE_RX_ID_LIST_FAILURE,
 	MOD_HDCP_STATUS_HDCP2_RX_ID_LIST_REVOKED,
-	MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION,
+	MOD_HDCP_STATUS_HDCP2_ENABLE_STREAM_ENCRYPTION_FAILURE,
 	MOD_HDCP_STATUS_HDCP2_STREAM_READY_PENDING,
 	MOD_HDCP_STATUS_HDCP2_VALIDATE_STREAM_READY_FAILURE,
 	MOD_HDCP_STATUS_HDCP2_PREPARE_STREAM_MANAGEMENT_FAILURE,
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
