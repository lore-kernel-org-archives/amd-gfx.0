Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6CC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BB861C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BB861C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5240A6EDA3;
	Wed,  2 Jun 2021 16:50:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A3146EDA6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWsN4M0zgcvnqaHJg+sD02RcQvRoVGAfRAes9pOrnAN7IP3Gbb4oasUAArHPxUp2mdFRw9RL2f+MkaszMaPVQgVeYxIetSMlwWWHclbmvae9OxhmFVe0S6I+j/whN3aQ14aj83xoWi6LJskhXBwBxZ+OR7mWlDlR/IKf7mN2i3boMmKdQOPg0o0ORiO+UGyAyfDKKbbQkC/dgNuDRF30cNBnOA+qN780WtHu6lf6EfgyAyDqFVusLSDKPQah+/+cfdzUzOxvMAN9uL5w3e1513mhqNaqEmmzf+2cyRAMyuJa8PAa7hxevMa3e0KPBVwlobQAqKmrnBu8aMZIO7t/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU41J2zhGiYrHg8hhxUquIGj9Ar3NLkTJR22yhuKXas=;
 b=ctBp8wL/f0yISY/hw66R38o9FSbfa2wWA8m12zQSyrXjlY1l9Iho/FlNdM1BW7jMjEgzVxOAkzphWj9M2LRsMkewnYGBmwSIPamGDAx6mk9IOEjpGdvaz6oybEF9m2PlkSAWrwPqbEnx21BosMlTnXm8N5u3+AvX0Ufyo/Ert49EFkp/3hdSwGFs8fWxFtttUZy/NFBvCCvZSZPubC5WnSpbPlzWyu4WO1kTROdqjzHUaFF6aYSReXrIVi/hyJvdMeZ9YEG6kHwvKpjZMrlplDUAgoCRMMWyc5toqDmnto3ZSe9prgtQ5CvzQ/kwF6VPbzNDXhm4eX/4qjKXgXNtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU41J2zhGiYrHg8hhxUquIGj9Ar3NLkTJR22yhuKXas=;
 b=qrbD99uFdDZIOMuLaqj6IMWbYYTB5qxMWMaFa7efUEmUtDxRG7DHKa5q59zdAuHqxWOp92+xpR5Aa6QJkqEu/J8gI1d0qT81aRqjaxMrkPHxgIECIJEdIG8j88aOXx4ds+O2pEEaZ0NDXYH7eDF9AdJSHhVQtSbakNz/1Bs5UBQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 40/89] drm/amd/pm: add vcn/jepg enable functions for yellow
 carp
Date: Wed,  2 Jun 2021 12:48:19 -0400
Message-Id: <20210602164908.2848791-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d2cd8a-d8cf-4b73-bce9-08d925e673a1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675578E297ECDC68B08CE7BF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+A6Vqqw7r8ySGtdKwYGmEjM9U16eLaYA7DEJnd+vslUG/e8NLI406cIx8eOYUt6dO5ueeL6qbpI3Zr/btV1TIx+tyWyPH+b9fURSI2gSEAvQiF9q1v75n40UvR450m0ZSOZiZMyBJNl43Dbpu8tPtRWUfTzVGpWo6wYXflTHf6US/nwsi1tDB+yiU6mlN2HkQ6JMtQY+3BBP5vOT+P5pxOWDGUfQr0RucRLvN122ehZTLvACzz5Glw/kV6VEtw5zgAKhBzUvdHwMZu6uEXnpYRlfqGrdMVE2fUJ1j94BGIzSjkNeYKjwROMVnL9M2wI9SLF2uBC18+jAdQog7EskPr6wifgCsokndqAbgZXaJ77467+rZZY5JW5EriW546W7KGGKxg1hb5dkYqbvnTCjzuLOT6Euth6lNoAHGqIWxaZ/D7xn2xXHzpUYYQHGcvA8yF1t61kbJ+ojt0MvIrDi3tZKALBPV3IhK96O+tzSgwDGFzMd6UP5y45UWMPzRHv+yN3P2f226r8HZHYlxqXXOWBkExpE/irTjopmKK4S4pc22mXDLDeYtwfUK2EOFg5e9Uu84jxCMeYWI54jV7JL50qxy6OP2sPbVmob/oOQqu4VaqCZXNonfga4EXnfZqkRhZ5Dde2Fnczx2bp2ASI2Qosge7BK8vYrQTKNM+4zAFbWaki0OZcAM+9aHU0i3Jp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ElXLR8vdwfLdoGCbFTWM42BSYRcJatzobX9URQIfZp7M3nFTK9wdpYTAI6L5?=
 =?us-ascii?Q?BxWW9vYtzQVjaz5w9DTlsyf4rLMAXM356Lm1z2/9Yq3TDSUv/2XBFVPL6luV?=
 =?us-ascii?Q?oZILX2yLAhOY4yUunogBKL/9ztGIVE8zwojhXokl6bnh9yJIzuAuC+8v5C8M?=
 =?us-ascii?Q?9XtW2YtZ5XoVcTk2oXMqrE2Q1jcKI9pdCjUT5zuA1m+liROtANGKuA801A5n?=
 =?us-ascii?Q?T+/zji8gUr+KPqpkTG9QhuuRkewbAEGVPrh6zCxhHwKn+PPKxplsskTyqP/V?=
 =?us-ascii?Q?JgSB+OtSHoRMQysmjGR12ZcF88LP3zjTXBhi/72ZIUMA+N+KDJgpMtz1Z94r?=
 =?us-ascii?Q?nbo08G27k8+hSP4hU2kLRoWqfxpGYzQunE+BUOIgBAoA/7L64oZG2dvy6ha+?=
 =?us-ascii?Q?3W+ExmpxSpbseVl0EbRGzeMfmaDRyWOJqYZVeW23B6PwLT66hPoqjhNdHjeA?=
 =?us-ascii?Q?u5TzS0aKtbWtLZaZqVP4BLOMhRt7YOWX9djAV1qceLVjySWM9TAu671bjIza?=
 =?us-ascii?Q?F21AiTaB9MBHHNuRdIy9XMYr/hVK0SDxBKSbXtoWpYOH2ggOYbAVRvfPvUQq?=
 =?us-ascii?Q?4JIx6AGR9OUWP/WMfgTtHekwfDNsqnCAaoB+DwWMvhxzV8mP2bpthjobCsbw?=
 =?us-ascii?Q?SvWSu1P8IuY5HBC6KsS1nhRGc4U0jkubMkdvP8/JkH/Gp687DeeDDyvWYHYM?=
 =?us-ascii?Q?FOTWNlI6jOTKGkAWSefmlNGENp/47ifXJoaO7psF7VxekV4f1CRPGRdQNBTA?=
 =?us-ascii?Q?uPJbRKqTqx1hYLxqYYGDVWuvTkZttsy6Cjz52LnTcGkI4CwwqD0X6+t187pN?=
 =?us-ascii?Q?tkF1An1pfcN4kmTkhirnhuM18CFzrGRiLH4spJ2fvEI9MP2AcIoODOiWWKNW?=
 =?us-ascii?Q?WgNGam/bCFjCg23rjUuovHwrHDnGJhYf/dhFUc/dp3mYPbaIQU64WAEy3Gka?=
 =?us-ascii?Q?PV448gzL3UX4+0jtU78ZhvpsuE9Bl3WjoaGuZ7LQTevlUvVJOWyWxN0vPtl8?=
 =?us-ascii?Q?s3OuiqWJx2W0TUnrXj5wgErICEMMqwtDmbaHax0Rc5BV27nVIF8E5OdQFB2a?=
 =?us-ascii?Q?1JWICPihz9jCbe7frdHKPlW2ElAiOIWvzxv6r3i6QwVCuy/S8uUbxWbLVCvO?=
 =?us-ascii?Q?6j8aLkjr2p3gL5EU3P8+U/B0xXFmHeX1gfWE1TNpfeJsJJYIa2ffGdq5l7R2?=
 =?us-ascii?Q?pZ/cmOvNuzEfFZkQs8Kbnmfr7ziBa9DFk3bhQitlNoRtT2eMW0EB3V04WFoV?=
 =?us-ascii?Q?wG7ZvzDpzR7BUbov/H8pFoOoD7hwzCL9GezPDqScSxSZSP9QPJYgcHA/Imwz?=
 =?us-ascii?Q?YH4mnp5k48chKp9TPqfQg0MJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d2cd8a-d8cf-4b73-bce9-08d925e673a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:56.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4KddPRPhWOYgqcOrDkTcLHTwQ6JEcKaqz6nARjdHEvZJrKiJ99CIxBd5gX27mY3az5sZVqP96zH7AHpT0AqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Leo Liu <leo.liu@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 James Zhu <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch is to add vcn/jepg enable functions to power up/down them
with smu messages. VCN/JEPG are poweroff by default.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Tested-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 1e83adad556a..8cc0f8c28263 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -124,6 +124,37 @@ static int yellow_carp_init_smc_tables(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	/* vcn dpm on is a prerequisite for vcn power gate messages */
+	if (enable)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
+						      0, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
+						      0, NULL);
+
+	return ret;
+}
+
+static int yellow_carp_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	if (enable)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg,
+						      0, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_PowerDownJpeg, 0,
+						      NULL);
+
+	return ret;
+}
+
+
 static bool yellow_carp_is_dpm_running(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -159,6 +190,8 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.fini_smc_tables = smu_v13_0_1_fini_smc_tables,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
+	.dpm_set_vcn_enable = yellow_carp_dpm_set_vcn_enable,
+	.dpm_set_jpeg_enable = yellow_carp_dpm_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_1_set_default_dpm_tables,
 	.is_dpm_running = yellow_carp_is_dpm_running,
 	.get_enabled_mask = smu_cmn_get_enabled_32_bits_mask,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
