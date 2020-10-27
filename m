Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B3C56201
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3089622202
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H6ayZA5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3089622202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CE96EC61;
	Tue, 27 Oct 2020 20:53:17 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700073.outbound.protection.outlook.com [40.107.70.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BA96EC64
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRQoY5SncXt/mlam8Z5QLOt82+k2LMdkR8FCZ24NNZNi+RJIPIayS4X5wZ8eLdc80th7o/mFPKJSLD7qU4LoY3ZJNGI5/InvARk7tuBpOlaRGEEHH2wISIqHm0q8W/kEyHw3GLjqu14lhAmaCm+tXr6llMPySfgiMBLBQ78fGgQefPC5OvJWVq4+niwy9yZt8Pt4yq2sf1CJoLbOhDcBTQS9dPUPjZF/Al4HIuBzE9sSXjrppkMIr06j7rSrvo5Xsjg0jOqo2iQ1hgXAFrPWKEfnC0dAKWlhflNOnfcLnO64CwSGDX7x8M5GV80d6aQtaT0v7HOK0EVenQ+5Moez/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3p3wAW5+p50hD3cczrRRG6YS5IkuaXxygSQWkA9GKc=;
 b=KMwjeA9hpHk6ckNTffPTDMSV9fdegFmOrrHmDOtVvWgSWJTeM5Aya0YsrgMz8sE0xshEWtY6M9T+6bqiYWCdrv8mTwcucigyxmNRpOl4hkSNI9TItQiqgOtd18Tx9XlvemoOToAfYd796pvs3NfP7BpyS6OgGyHNPFFK4utN/XMnNpAVil+GhlRIN67OvdylQHr3GarRI9AagTxfJIiOScBURjCF67fe9CZ7jOYWuaxKdLL39TCgVlbeASXtDop3REi5D3/3R92wPr6RNsYpayQYn6biHbDrmtY4gtnxDyoJAze/3ooSfkco0Au5rMfcrxmjiJFBInCWvi8UrDA/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3p3wAW5+p50hD3cczrRRG6YS5IkuaXxygSQWkA9GKc=;
 b=H6ayZA5IINyQvHxZLOVYyAZw4F3nuTjF7lFA+2PdHGvAvoOkNlvbpjPmHKPg0NQh1MmimvpwBbpPtqu6chPrDlkbSWPRFaV55BLAYgvUIKKRnW7bGOxySGxR3BmXSVmHVzNXoaqsT40DJkjxR0TsnLX0Cjig9xvaZRqULzMOPZ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:06 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:06 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/25] drm/amd/display: [FW Promotion] Release 0.0.40
Date: Tue, 27 Oct 2020 16:52:32 -0400
Message-Id: <20201027205234.8239-24-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:53:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbc2a968-58f7-40b9-df29-08d87aba4a76
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595117784D74A8A758488B9FB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gW7jNenZw6mbbSWT6xXkbfdRpOFzkF/E0SzbqiyzGT/gHlixD0bCbJACqd9Mrw7Q1kebgXYWNqvrYykkxIlH0rxgG+b2vMqts16GF3e0w3PHiFqUuMQg6nUq/a+ywktkxEdDAB3AqROmHQSm/c+1GV5D70/MUPJu6/8zbhjH0peAO7eDZPE3xA7ony/a2cjrRRm5o1U0qVaHsBX877zh10Rv8VelWipi4esOQhkEaakpEkHdrlEuGSnw60nZ1anXqSGSOqjxt8ayrNdtqV7iLycnsigOma6q6e1lhQG2AmThOtAuR0P9r5IjSUP28lVfCrKm6fWvGbwu7h2ajzBHrS3wYqE/tCuqFVv8g7xFtdr9PJALPALKy+L+THr3Pe1W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1wbW+h6cpXVDT2wNceiIbKNkG6R+6lpxAvFieNdq/S/9Qp42FwU+eWq0Hz6Y6HY7QbbxYr08G6nkM7vPRKxFp9jDHN7pMqiXMd1XatQKY5Zn+ohvImbqznm802ax8xnG43yiFVj2WswP8HYMLqBI3KDcPUoq8v6964pnMgFoo3zTrdQYGTeJXZh4eowre1Jfu1Qus4QEhcg/ckesGahVylfGGsythIrZDn1zXiciGsq3smwNkm/alORkYSwRTMKoPZvLpnrXFN2Hg0sMaBNU6CcZuTbzVOOlkmEX1afsftbNSlb1ZLSJqZW1c2IurBUMXn1ObKEewIaFrgf5u04zJ8d71/ppzO/ldP2P80XlI0XWcXMKq8Uj/NohWnmTSa+O7MSIWGzevoqPAcbigDCBa4vUskMvI6fLB8QEDrC4d1BmtyAnrmuqOM1SCxWCL9bvA6f6nZmLm+5N1xkGj5DfTsMOm2yeTiiJt2Ql7Z0p1HwQtKKhkZcWmsp3tjE0VO8rVLJkmFowY/hblGRBL1RErYEmoaWfeYdR75a/nRUh/zRQpQ83OTP0os7CeL3HIFO+3SWTgYLe3zVZrDHnSZXZWewEci/Md8Ow4ocsuvXMsVEorZrE/86DrgOpAkeGp/8ZD2DgpXDIendVoED1UxTIqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc2a968-58f7-40b9-df29-08d87aba4a76
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:53:00.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fA8RqC+2FW+/VjcWeAYv1ZFldEvYQXROUQj++vDWYcpvwxcjaiOMuPVqhk6f3PWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
  - Add command for retrieving PSR residency
  - Add command for forcing PSR static

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 221bb2d65c1c..81433c22fb51 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x26ad601d9
+#define DMUB_FW_VERSION_GIT_HASH 0x9f0af34af
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 39
+#define DMUB_FW_VERSION_REVISION 40
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -274,6 +274,7 @@ enum dmub_gpint_command {
 	 * ARGS: Stream mask, 1 bit per active stream index.
 	 */
 	DMUB_GPINT__IDLE_OPT_NOTIFY_STREAM_MASK = 8,
+	DMUB_GPINT__PSR_RESIDENCY = 9,
 };
 
 //==============================================================================
@@ -583,6 +584,7 @@ enum dmub_cmd_psr_type {
 	DMUB_CMD__PSR_ENABLE			= 2,
 	DMUB_CMD__PSR_DISABLE			= 3,
 	DMUB_CMD__PSR_SET_LEVEL			= 4,
+	DMUB_CMD__PSR_FORCE_STATIC		= 5,
 };
 
 enum psr_version {
@@ -643,6 +645,10 @@ struct dmub_rb_cmd_psr_set_version {
 	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
+struct dmub_rb_cmd_psr_force_static {
+	struct dmub_cmd_header header;
+};
+
 union dmub_hw_lock_flags {
 	struct {
 		uint8_t lock_pipe   : 1;
@@ -800,6 +806,7 @@ union dmub_rb_cmd {
 	struct dmub_rb_cmd_psr_copy_settings psr_copy_settings;
 	struct dmub_rb_cmd_psr_enable psr_enable;
 	struct dmub_rb_cmd_psr_set_level psr_set_level;
+	struct dmub_rb_cmd_psr_force_static psr_force_static;
 	struct dmub_rb_cmd_PLAT_54186_wa PLAT_54186_wa;
 	struct dmub_rb_cmd_mall mall;
 	struct dmub_rb_cmd_abm_set_pipe abm_set_pipe;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
