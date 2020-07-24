Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52394C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 06:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E044E20714
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 06:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qjxpOMiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E044E20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BF46E4A2;
	Fri, 24 Jul 2020 06:16:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1938C6E4A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 06:16:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ae2t1JRUX9eH3yu5szI3o8lNI2BTjWKuuuE6CppS2JY4iU0XaNZ8nGVjWXxi5eVCHQR7f0fkqSWp6x/YLQ6suhFtgkJk4P33RSxC+YaWSBYxqdmZYAf+bqRW88Tam5JUSJckTjZSD3sO3VqPVvSA7bgqzipmJYv4yeMqz0WnqodSGCLDyElrdhaGgZsbJmaEK1w6kXT+4saPPpASLtPoZ6Vt9SjI6ynTKzdhTISUWwa8T8tpABonsMqAbObPFO0ayYVTtvyRkf01hv81P+Mhdwh6xrm3boKc58DfS0pxIoiZgQnF9nCW9sRMgoLstatEy2i6Vo4uHRZSWmbWsZ/43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqWga8aSnSPCo8pXc84G4OirrpJ3VkwcZXxY3wC8XR8=;
 b=Qr/3Sn+hWWX4AVN2x+lrfQpJktrmEY8HgI11xbVr3VPqZS5/+cJuMGyvoDZ14FXXv8bZzB5D685RxoyVa7Wz8+zoplSNk/prTXNIYfID9949T4T3Krxp7yNGn5qUPHxjwlbfMqkHwQDOuMgmzUzykav9Q2vpSSWjDMznFPcGycReX//kjkX+zd7JxVWH95cYirMM1lGkVJxaFVJYSuVlqO1fvJu8HsA/Y37Fo5X1ysQjANKt9sNPrvVRIQhA9q8RPcBBpmSxZztDJFV0pMSjMqE9qqgw/4qoh9kvCjtmgUq6PbAQWyUQMJXWlwsKAB/jF8PE8v9XakWM/HneeBDpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqWga8aSnSPCo8pXc84G4OirrpJ3VkwcZXxY3wC8XR8=;
 b=qjxpOMiYnixQXKV5D0xYTicZrsdrRIeVvwyZ2w+5htjIUb8HvflRTjlTy1njgdB8iFgFyBMhFlfsu42Xrp/yP+fiGjOarV4dG2d63d52dmSaJxgIrGI/8NLLBMs38RjiAvAHHZ38d85G432XMERSOEAObO7pBWkjXBnZGZpECqo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Fri, 24 Jul
 2020 06:16:32 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::7d31:448f:70fb:bb13]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::7d31:448f:70fb:bb13%7]) with mapi id 15.20.3174.031; Fri, 24 Jul 2020
 06:16:32 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Evan.Quan@amd.com
Subject: [PATCH] drm/amd/powerplay: drop unnecessary message support check(v2)
Date: Fri, 24 Jul 2020 14:16:05 +0800
Message-Id: <20200724061605.17743-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0204.apcprd02.prod.outlook.com (2603:1096:201:20::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 06:16:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: daa2b7cc-456e-4d92-7427-08d82f991c54
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB351574A275AE40BBCF7FB502FD770@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJZdWMdWSPw37lzhuesnAAoNAzOGmb63oa2dBz5SsxNA98eEvlbs4qwBCSxh+kQD5lER/MiYFi5PfTKnbixRG5+tutHQ0iesthn5QmBEX6yGnZlnc6ROnj1kExdgZCXu3xSAuhLxexKsWJOCgVJvY0C3969bLgsP5AXTTlMNcVmYc8SuFCERHDi6CfKdFo4vvgrtjLws5R/KsEevnLhxLzCZ7UmyuMt8NndbzTNXzLDF2Xy6bghBqONATeaNiUA6htPGluWgVpnDtoAz+0iNTS5vXOndofgs+TxkP55YKTXB1n+aZA1ugRVakxSjJ4ZKk2tmrHVek+MC5TEQM11doA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(4326008)(6636002)(83380400001)(5660300002)(478600001)(36756003)(2616005)(956004)(52116002)(316002)(7696005)(66556008)(66476007)(8936002)(6666004)(26005)(16526019)(8676002)(1076003)(15650500001)(86362001)(186003)(66946007)(2906002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EzG1Q/usZE6FoeYkbpeNoNpU+hPJcUqla1vjeyGm1L6F2E8/Ll/rEzURgkVV7HdGXKWZtSnuYrR3bOb7kZyQZULZUlJ4CaqOWzLjnUlepNi/JBqRKM5OoqmxHwTQYNcOdnSaExK2T09v5OMb9YEqylCeSFt2eJ1Wa+gcuqMGQ/obKMAcxjQ/kQIA8G7n8To6BNb2e2QzDW75SyqArXxeyLwTZaDoH1IyWV3Y6MQg6Q/QBU43dLbUnmUqY6/OTiJ2xviJUUrQ5fpEh1vh4Uc52en9z1OnxBW3VWVlr73NoIduS0mDC9ZRi2lgpw/RK1SXYcEebD5CvSvFiuh/eXMhNAuS7Z+/XgO8/hpjklxRbVyIwIsjo8xiTL38zs/s3Bn9HzZuU+szxZTYARPbRDW397pTePItLIJTrgZ6WCJZy145Cwk8R82RNbU0BoTHcRIoElIT34qjMPX0anpvGlxD9rnICbAxWkrj5ArqsJFt8aeggPa7j7pD63nPNNzudy6T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa2b7cc-456e-4d92-7427-08d82f991c54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 06:16:32.7052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgJLlt+6zGJaBQ6jpoRRhP5XaO0EJgGZrFOjMFH3zXZWWgYvmYL3h/fFzzRfXF5QOiPbDaho+UpYl/+R+14MiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

Take back patch:drop unnecessary message support check
Because the gpu reset fail problem on renoir can be fixed by:
drm/amd/powerplay: skip invalid msg when smu set mp1 state
It needs to remove SWSMU_CODE_LAYER_L1 in smu_cmn.h to guard a clear
code layer.

Change-Id: I30cc2b435191ab243c6292ae58c6c099557d9bd9
Signed-off-by: changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 ---------
 drivers/gpu/drm/amd/powerplay/smu_cmn.h    | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 4cf37fe20935..34c7eaf64010 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -34,7 +34,6 @@
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
 #include "amd_pcie.h"
-#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -1590,14 +1589,6 @@ int smu_set_mp1_state(struct smu_context *smu,
 		return 0;
 	}
 
-	/* some asics may not support those messages */
-	if (smu_cmn_to_asic_specific_index(smu,
-					   CMN2ASIC_MAPPING_MSG,
-					   msg) < 0) {
-		mutex_unlock(&smu->mutex);
-		return 0;
-	}
-
 	ret = smu_send_smc_msg(smu, msg, NULL);
 	/* some asics may not support those messages */
 	if (ret == -EINVAL)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.h b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
index f9e63f18b157..98face8c5fd6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_cmn.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.h
@@ -25,7 +25,7 @@
 
 #include "amdgpu_smu.h"
 
-#if defined(SWSMU_CODE_LAYER_L1) || defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
+#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3) || defined(SWSMU_CODE_LAYER_L4)
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 				    enum smu_message_type msg,
 				    uint32_t param,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
