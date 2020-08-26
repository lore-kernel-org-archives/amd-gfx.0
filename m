Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C573C433E3
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 07:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E42207DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 07:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="reUIUpGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E42207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EEAB6EA2E;
	Wed, 26 Aug 2020 07:53:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4606EA2E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 07:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5rZLvaUkkf7mLSOgyBJEdN4CMSXG0Nb8SlTSd2TZN1mdUyaEBMZMYaXMdsa8MidGztMYgkJ3DxTIzkmtQb5+/8HX//4ZKaZf3E6Om404WZLqcniTUg3j84xwpCROLDkQDlcQcSjWC/jeYCwr0jM18OF/BBNhm3VBCT3ZdXvWssKzYkkwHbUC+erAfGPZoaPfmkurC60t6VyOz7l9FWx6W5bVzcLqXNK/JNEjINNoVLhfYpNFIZM9P7xxzevHqeesNdqAAFeVeOHaymvDdTIfdHTLRWgVGSYvOA7hCQ0/ncynSqzOsvsDyxPrBw702aawI5luYh4S4vD7BwUBgA7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrqEQI1qdaIU5tsulxH4Bwijpqh6MiYA+7D0KJHVFKk=;
 b=hv24m4uTQ441V1bx8fkQOOT4V45X/oBwIkgaE09oqeKLpoJpZtbbfSVx5MfcX3Iz8llQ5K5qmsQlb1azLPONJGZrRAPDnRr91ucu/J7Xu3OEeaGEY9re8mHCJsH+t8Uqlp97czoGtgGlw6qwPj48ttt0Ii8p+yKAkXDluDi//sG7ONZCX+72OGKarbsldSFUmAIe1mkoOa3nda8kxema7w/zIrGMoCO5j+w4Ebn4N/rHHRKxdimTsu+pbm4V2N8QQ1zw4H9IoIXMI8oEKRzM+8hzXHumi9OIBzAlRCTX4/weuS8yYW6FgsQQAN1LVI/EIk6rehWPfH6prh3X9PYEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrqEQI1qdaIU5tsulxH4Bwijpqh6MiYA+7D0KJHVFKk=;
 b=reUIUpGOR5iL9UdFfM/RKG0pMgmb+MJvxZpPnFq/BdqvDMlRcgwVByY+PpbkyUlnvG67oB2WIDdpsqt/nJStWNIRsEClRzUIbg8TytYANIQVDv8O5J8JMT6GLAlGRH1V+QSYpa+0MGCqwdhjwTVKmEb5ULQozVg1h9FDF9BiBlU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 07:53:07 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 07:53:07 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com
Subject: [PATCH] drm/amdgpu: correct SE number for arcturus gfx ras
Date: Wed, 26 Aug 2020 15:52:36 +0800
Message-Id: <20200826075236.28735-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:203:c9::6) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HKAPR03CA0019.apcprd03.prod.outlook.com (2603:1096:203:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.10 via Frontend Transport; Wed, 26 Aug 2020 07:53:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb014ff7-88d3-436a-9891-08d8499511e5
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB012052D69CEA748BF527806FF1540@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaYDivOoP80rAzkhK7IdkdsLi92RKUHPlr0aEHSr7mBayW3XddMr7WOMzjxhBrUsKdToLMHoyyMWIUw/s6NhckGD/rWMQdyClpXFfoA0ydRn1JFL9rWkacHChZDC1uOn3DHB6a7fQU4qMGgwH6GnoLD5rfkEV4x7NmWh3la8HDiMvIRnK7+NPNFp1qiIW1hWhPapk+JpnPr0cgi4KWbdB7lCdnDE91+weoWas68/TiBjXh3gWEmyLVrYUQ5dRoXnmrbPk1lTpIeL0V3m14VYgHk22QB8WbHZ4UbUfqkNvAqOETvA/7ZGUhOprgG/72+iaIH/YeLxkV2pD53/wnnGbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(1076003)(66946007)(66556008)(66476007)(4326008)(2906002)(5660300002)(316002)(2616005)(478600001)(6666004)(956004)(26005)(16576012)(186003)(6636002)(52116002)(44832011)(8936002)(86362001)(83380400001)(8676002)(36756003)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ImwbxksVJ5KLdzAgIFnKAUx21jeNBtmvOyBtfY+wZdq5yaxPLi5vkNxFjKKvAkeiG+tHpwmbr+3ZbsfN9RfgHsdzsX6RPYd2/VZBnwE1fj+/dqly4q/hbkVVjLyQsO0GwGXU8MlUi6DM/cTQHEv5CCPjqbQWJbCG7fTfnA8d3AakIN144uiuUvIxpmVXjgO2RupeuT3FEM5KBxWogjpQ00ylPGnuvYpdiq6cjPlviKYpQXiN/5JPps2wY/7ELLyO4xOxzMs1pkzGrUXzAA311/EndxHodxgXssja7cXtDJAUHXiW2WwsYVcqFG0u2JOyDkftAHJZJF8IL5xVdQWGFPjkGbvSSEveMw84nu6CIW4ctCZNYjvz6VJnFl13Wp+2/xBnty70xrMLfLHSzcY6QK4s+CxMQHSsw7cmwSsqUF+hXR06JWZmVVXrS1yWP9wX7xFyTGKMXlgqYZ8bLJ4bdx+7nCQDCXo0it+0KvTWbLbG+QnOqlDewftIlSEgXTXXpla7rQ4z4pQ1uFF4mgXn+uQnR8BwIh9HSvjcAtkt7Ttbu60i4jzqlebbntqguJGCZfnc+CCpyeI9738vwQZJxHR5ZPCiMvUblqsm1WusjmDdPAKO4Bq6PCWVMIIvAWCA2kMe9V3/j9qK5jh4OpcQZw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb014ff7-88d3-436a-9891-08d8499511e5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 07:53:07.5817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSq5fL8BL3wYUCfwibIhipGxgu+YVADFvZEPzQai3GUI01bvEGtCd60cOBrL9W+4M+x2wt3CMGW0IIPkfQ10eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arcturus GFX has 8 SEs and 16 CUs per SE, so when resetting EDC
related register, all CUs needs to be visited, otherwise, garbage
data from EDC regisger of missed SEs would present.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 46351db36922..bd85aed3523a 100755
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -57,10 +57,10 @@ static const struct soc15_reg_entry gfx_v9_4_edc_counter_regs[] = {
 	/* SPI */
 	{ SOC15_REG_ENTRY(GC, 0, mmSPI_EDC_CNT), 0, 4, 1 },
 	/* SQ */
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_CNT), 0, 4, 16 },
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_DED_CNT), 0, 4, 16 },
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_INFO), 0, 4, 16 },
-	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_SEC_CNT), 0, 4, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_CNT), 0, 8, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_DED_CNT), 0, 8, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_INFO), 0, 8, 16 },
+	{ SOC15_REG_ENTRY(GC, 0, mmSQ_EDC_SEC_CNT), 0, 8, 16 },
 	/* SQC */
 	{ SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT), 0, 4, 6 },
 	{ SOC15_REG_ENTRY(GC, 0, mmSQC_EDC_CNT2), 0, 4, 6 },
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
