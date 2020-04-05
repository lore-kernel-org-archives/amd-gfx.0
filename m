Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A981C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D46D20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WxqJ7cjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D46D20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9307E89FE6;
	Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF9689EB1
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNPz8FIhWJnoA7kWoBCE+G4ul7LeqlFSwx+p8+HGgCXT+3RrMlfsGHKpv4jBj887iyacQbx0WLo7SnTzZaRMHlDHZuGeRt/7eVkpZykbJqlkwrLQJaFP0p/0QALdeCFvZmZLBckW/QPPznYFPiGC7ZBJjxwheutMBs1Byxvt8xplBnH7sHominiaBshVlIvsSGfTtf3sw+KT4dZ6MwThDiZyux+WQRFyvY8s9sbssKWRnBCXrArzGH/8WpbAZFqzxPfpH283zLTHKiI+3fQ08/muHOV6BjkwW7f/xA38netzF/0Lwp0hd3jo7FLmQqUFu1XQFZ830TJRsc4qjm2q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye4WfzgbF7DBoP82WouMD0KuHHSWva36O33DQIqFAOk=;
 b=LvhxTfF/P1c0R10KsPj60XW91rSGCnWPKOSPeYjwdbH3aDTeuhymB7QUap1lmcmL4DmXcWb19zJq7CQJ7ydMQu87qUPka7a8yqMd8i3rZ4W44/6GK7SF8NjrbbvaXXrux0q66qcCj8HSQnKij39yhkQu0OAbwOnmEjVyuu0JUfTxM2Cw9otc4EcY1TZbtgmxnykG8SimQDJhm73ZRYIr3k8xHaz9/hASlj6jnp7FXQiwcq94g8tAVc9MjVVMdbkfxFj4DdeudS6xZ/l9dMzCe86VawpsFYBfgijO7YNBfvpnQGnxy38kaBReUbmg5JMO4rrjgWUpu9s04yk0YjRUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye4WfzgbF7DBoP82WouMD0KuHHSWva36O33DQIqFAOk=;
 b=WxqJ7cjr4nMxFI0Nk7B7fLD4u1ol5bmJPfOFl26/QicIc+QivOWTTktyhrvilfbdfve/Hv5R9vxRciTQhtk+qBTTEYQD0vIbSnw1HszqSZuwLLy5ELfhc59LgL6SSLItkyJvcpH+bY/Y/9bx90sLCQjlz+eNlB7nA0hjjnTlaxQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:45 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/36] drm/amd/display: blank dp stream before power off
 receiver
Date: Sun,  5 Apr 2020 16:40:46 -0400
Message-Id: <20200405204115.683559-8-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:44 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 603cf411-6aca-44a6-2619-08d7d9a1c15a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555D0D3809005523C7ACCC998C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h93zriY2dwnZHpDegYQCOr82uw9KkhzMbKMwXBU0lkrHhflR8vlnaoSpUEsgyX5isSJJnIRUShsEadM7ti0S5cpMl5M/JaNL2wYMIIKBX9U8jrslhSeFUhhYFWLMkQci/qo4LDvXrzlx82DJMQm3F7a+kn/u1o6LEXNOlqULxiYc4KSeocJDtNfK4QQOAzWesRaHNtEcpKC31PnT4SurgJKVLaF1lVWRPP4j4If/zZ2bcRkHEyo63ytqjf9R0qi6pdZHx2rgFQG7BXDunFcajRASKDFM5n3kXOXoiO2pQEZwzJCY2OEv00kC0FL6GeVWEG4/YSmuFNivPKgIaPmbkZozURqfCcMwqx9J9KCpO5j633Ut5x576EOliGgGZ4mT265uNp/kKr5PUQDMUwbPHRpRcyOU1t3VDl7YyGpB9ZojuhGirZSOw0CvCOtw4Inj
X-MS-Exchange-AntiSpam-MessageData: G8cp4akyHQ/RYiEbyLJwOIESDfTfSyP2Gg0iGJqinRYam2FGDby71oFSiP9q85nFqZlBYzoCcxldQr+nsWv1OTRkzl87YG15dDN0vCDILc0cRfQPxlGJMoxaBqrvvl80DVnjXaRchmjdeI8pNhlaL7/Ti6WbIXrsXi77/Not1CY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603cf411-6aca-44a6-2619-08d7d9a1c15a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:45.7334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpl3B4GEinGPKk8kqUEdzx8Speh6BvMPmbEasVUxJL1kQuhzag9N9nSTP9Yftc/K9r8czl1HgISLmnoH7/v+Dg==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Xiaodong Yan <Xiaodong.Yan@amd.com>, Harry.Wentland@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaodong Yan <Xiaodong.Yan@amd.com>

[why]
power off dp receiver directly cause garbage during hw init

[how]
blank dp stream and then power off receiver

Signed-off-by: Xiaodong Yan <Xiaodong.Yan@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index dad95f1a7041..079a33a96f90 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1328,6 +1328,14 @@ void dcn10_init_hw(struct dc *dc)
 		uint8_t dpcd_power_state = '\0';
 		enum dc_status status = DC_ERROR_UNEXPECTED;
 
+		/* blank all dp streams before power off receiver,
+		 * this should only impact DP
+		 */
+		for (i = 0; i < dc->res_pool->stream_enc_count; i++) {
+			dc->res_pool->stream_enc[i]->funcs->dp_blank(
+						dc->res_pool->stream_enc[i]);
+		}
+
 		for (i = 0; i < dc->link_count; i++) {
 			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
 				continue;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
