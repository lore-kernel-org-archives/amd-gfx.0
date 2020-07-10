Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3AC433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C702020748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s4amJYOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C702020748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F686ED0E;
	Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FEB6ED09
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvMxjB5dK/WOw6fhy98GsRWhP6SNhlICPdDoI5T9Yo25EFhJle5zGlBGoA+YyRTEuP9SXfnxTOvuFd+1LqY0u1kGnP/NNbl5l/xuwPtZxI8U4+HP6d5l1mjsrPUgqdFGpzv0AQXEyyj/8k76RIwisYsaYmTbVRZyo0NizmqOmrx0M07QWjpBip2+M3Xdza8X3E/b3JMzxANUC9xaV+C3vomqPVQ9KsY2g8k7bovuQyPt+W1s+zB0ueGtgj+DWNLTXtyyqO22S/fpzWO9o8/mlAmLErl326JkqZy/ZO/ZbWE5REsMuzUVpFKVNftCUrP2xJrA6h+a8wRDUSHAPzh90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLD0Pe/QEq+snMt1iKyjOcNwRUWLakWQBOOn33uf4dk=;
 b=R+h9bkUv0BpHRgyuUKHhkAqmuv/m23QaHYFN5oJLPXtEodbsB6iqA5MOsiqQWaQzioBe5BQnrS0M1ua6ex7dyUv8D7dT37iuoHt35tDZHtog0DjxTA6xzygmcpNMdezFRCO93oY1aVe7sduGrLdl7BUiYhYUS9l7lm/6LASrW/2Q+XrEM4LjQtorx9KfrHdTtk8fHleEUHhYOpI6/oBnxnvL3yX/2guveyLT+42c21tRmKrDWUe0FzNphg+eg0QtMC3hd21SEuIUEwekaN1WCXPmFG0OtRYpbnTUsngaM9FY/i/232zAuquUkL5ilA3p3QQm7wEjGn/gLItkn4pTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLD0Pe/QEq+snMt1iKyjOcNwRUWLakWQBOOn33uf4dk=;
 b=s4amJYOQBZu0WfNEFyHu7bYTM8lwTllpVCQ7ELbx6OfAl6spkeqrI9N+xNRxR9JqRdRBeAChq6U7rYSy2ErRdDvEH3c0181B9XtdzxDXZj5h8obHFFK1yZ6v4AU5/wFIzGmqo5j4jNpgHhyS8tC5ZhBzrG6+FF9vwYU6GqivWKs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:03 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/10] drm/amd/display: [FW Promotion] Release 0.0.24
Date: Fri, 10 Jul 2020 16:33:22 -0400
Message-Id: <20200710203325.1097188-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:03 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87164f6a-a3e1-4537-923d-08d8251095ba
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42310029EAE773AA9D5D148D98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chJS7tbKjTvo6WOnAIrvg1Fr9TULaIlioQA8C6989NHqvWtbVqwdoclLY9fIaadb1HoDaQU1yf4ue2pveBv8vv2gY8Y6byEpwkXXugePx9bFXeHvLiVtdlmfB5ITj9GfT9KFy+3wfZNK4tzAackALFPVe/vuSh9jWk3rVtlfTYLd+0HpKV0RzxqIq9EGqgohhkKJeBOzx0DVGJyoAq+y1287I1vq8KZt5RnGV+CqpgNYWUn/jAUeNkirE0gcfaQE7PMHMAC0yy7qlwc3kPWwd+dIhc/z2dNdschtQh+v/iVeeLb53rKKFG8YrEX1Bsy9+0pIxvuLmhVzIu5xqEaJbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(4744005)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1RGWgfePWesHqK/mM4hylWNPKkAE+BUpKPErY369+sxDthb+Pk0PUQ8D+s8Z4/z6U/faYgPDAsIN5GaHY6r1/ndnzn1NQMB8AEkhID40NgoiX3PgkH4/rGPrgOC22SXikNJDfFqp+2I3Up+Cbi2OauOXI/ZpIn8pAMCnFb2HyHMT8nXIbQOyvGRymaLRMdn+qHIA0w8eMXihDAiOxS3juUaYsij/RTqqXgJ0sjrXHU3ewUn0ne3607vdJG44Fttgqo+Y01FsyYBz/n+/uikh3qi+BPO613WfTpYgAyrJ1YRD6JMCCOjQkcb26humR5U9zgn+XKC2f8s+0955ICUt0TQ3KrQ093qjW87Jepqo3MzYjH1dsrAGzQTmb86SJpxPH6gbr0cWUADjkusvV+BD1fms1plE9ZF5I98AZXtwnucifYukdJQPvApNOrSaHfWjVmXI7QA07848/X6AJDshyIeWEc2pjFruaMrD4ruyokkIwU667vrOkXpy59gNNwmKhOED/E0VZiM3tvHIgwSk3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87164f6a-a3e1-4537-923d-08d8251095ba
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:03.6255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R2R3cKR3Uv6TXavgsai+IQLfeyGX2fJpDYyku7cbRLGuANxn8py5hSa67M9/whu7/Y8fqJm8vUBQfUn2cHREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index ce96143c402a..513a5f8f817e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x5ad38d883
+#define DMUB_FW_VERSION_GIT_HASH 0xf675c6448
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 23
+#define DMUB_FW_VERSION_REVISION 24
 #define DMUB_FW_VERSION_UCODE ((DMUB_FW_VERSION_MAJOR << 24) | (DMUB_FW_VERSION_MINOR << 16) | DMUB_FW_VERSION_REVISION)
 #endif
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
