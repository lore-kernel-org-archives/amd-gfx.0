Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC1C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 06:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6264222C9F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 06:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6264222C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2EF989C88;
	Wed,  6 Jan 2021 06:13:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DEFD89C88
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 06:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQ1QIXOUq0A9PwLnBN8aIu5cNo+LXMA4Vf+s+71HgJcyDKlxw5Yy7LwCkXV9hnyaUMbZvsl5dhLK25/ekpdM5oGWz4V4hSchnKlX6DjOhiPzNkGFd1XrGdVwoh38dPznBHFMDdRC4zcalIIqFiMvkooAJ0S18ZIK/nvtgSzMlXn4PMWpMe8B+m4B/fUqF5Vs0RtcRVYuzotdtWd9wvjnQ0MeKCxDHm8pP+LqTgi9qZ44jMl6kCHPKJyTy1cjRT3EsUufp+RVS0uemQOituPRWSPDYGar85MkqYxwigiwlMNeIyw7DpUfeUjtWYl0TRTpp2psykliWDO0Iry6uwY17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzC9Wna6aGLyeSs6Ezj6RKdxR5gb1SrEgylqBuUIU64=;
 b=Y58XWyeactSLPIVTMtHbBs2PvPC+Ck+k1GYoGNt9uXKw2oZnBvnQXPoFiI5tm5sQYXbOOwqho9yYM4r78lwLpKsqujpvxUsbn0b5GZxESfnGL/XF6YecSrPqwDhYrdqj5QgPtd+a1YIAaGeP6TLb9HzD9AvbUJxG6AvnPPSa666n2lR6JkCYHSW2uqwuBe6SiAtlttgmioJ/am9jQ+9TK+7n46wIeK8Oy+nPC2sIsNLF2pUt2I6daPAMoJILDA3ixN4ypgoV4wXXEXy4WLXPdMgdYnExaJDdZMplCrE9Qfz9/QIgU8aAOi+kWbgLOaHMYDyQ9W4P1NZT1+Q78MmXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzC9Wna6aGLyeSs6Ezj6RKdxR5gb1SrEgylqBuUIU64=;
 b=KxqSZr0J14+jzxtHGENQPpMwPDWme/8NEnU3R7NPpwY+Gpi76ThFS3V9smYBQWOdWHPHKJuExuod2i/3Ym0LPQu5Kmj3SA1chhD5AhGYC1IgcWa5IA3n3W9gwtYSo8B1u5zDpaAZk2CDBPEl1/OObLMJlPHsSmvZs1/pW8FQsTg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM5PR12MB1738.namprd12.prod.outlook.com (2603:10b6:3:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Wed, 6 Jan
 2021 06:13:43 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::4584:6ff5:8f00:aa72]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::4584:6ff5:8f00:aa72%7]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 06:13:43 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: check more client ids in interrupt handler
Date: Wed,  6 Jan 2021 14:13:13 +0800
Message-Id: <20210106061313.4521-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4650.namprd12.prod.outlook.com
 (2603:10b6:5:1fd::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.4 via Frontend Transport; Wed, 6 Jan 2021 06:13:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0db875c-5670-47e0-7500-08d8b20a37fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17382FCAAF9E5F3059042641B0D00@DM5PR12MB1738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmi4KBIAieGjzAS7QJfKP7QqGESFdriFu+cE/ByRO6uq7n8V4hH3MixuuxPN3RsrkzN0UfwzHXYpEz9x0y630bF0/pZRE8fx7guKZEIV3lnFx7kBhFvp6ldNI0RglmZhMy8T12mNG8SKTf9N+S6ij0n4D/SJhMqhsFV0Bsvd3AhxWYDn4a2u6neGFbFXfjMNu/huJuf4RQw7ovnweFhP7SdVCh/9wSWS2tFfuHuDbMS1kwPmut8HsQXbpmKojo48+iUdaXxf1G6dQjYzClZEdg5dvQKe3uGWBVmK7N7/n3SnVHd9Bs02ZnfOBJc0Kp/hZCO1Woy0CfPgAZxaH/zkMgJCA7GR/zpLz0OtNUZTKV9yPnlFX4NfFl0HaHX+WVhXrsonYMbXM6w1i2/XPZQmdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(83380400001)(52116002)(36756003)(7696005)(66946007)(66556008)(316002)(6666004)(186003)(16526019)(8936002)(66476007)(26005)(2906002)(956004)(4326008)(2616005)(86362001)(6486002)(5660300002)(478600001)(1076003)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0FNEu4ayaIJS91XRmajpwJGFSmHDIeToxnSs6+IO802rkFf9nI2YI9r8Y7oh?=
 =?us-ascii?Q?PWN15nEHFE+KaPTvjSJmz2lxjFIWfectPu3S5wEif8Xm0y9cixTSBRFa/EJZ?=
 =?us-ascii?Q?jIQAvo1VX0CRkDCZrRU5kdjKX+48N8O04mQhGYvcdGEvJoZKxyZyOzbPXaok?=
 =?us-ascii?Q?gNHNtb87SC5Z/9gesaMVmpZsr6oPTMaalTd7SZ4KEDDupjf0fC+HmlM2M+O/?=
 =?us-ascii?Q?/GzzeTZ2wH18iSyWXuvihH3seQfk9BYkk50VooEfM2k2joXNp7cOf/H1MLgu?=
 =?us-ascii?Q?v8khzSvEo1uLrE14ymMIuiOPeOaqw4qcKRiSLVhNPN/Dxo0rRgOYdBJ24d+S?=
 =?us-ascii?Q?T05unvMEHImhQZJqZmQsQJEsL1Ju91o6nHws0cKcwb0/VbfTdu7V78RBsOfh?=
 =?us-ascii?Q?PLmG3SKJASUR0U6HYyX3aIQp004jEd7N3hwG9S+Fc4VhCXyXZ3Y9XjjNc/jg?=
 =?us-ascii?Q?BcdAYfwIAqjj+dx0sivDYmoYR0aHdFBFNDhV9WuprWjpFS5qky8RFGdpY80Y?=
 =?us-ascii?Q?7db1j3A42COSdEiWE4+uFR+bF0H7FHkZuMGuebc+iX702ivE5BrAFZmOof6I?=
 =?us-ascii?Q?jGAZ4G25oavfLQcvYqRRWE7Ki9ecQknN7mERmqmaXI9NsA5fjP+Kfr6HOUVo?=
 =?us-ascii?Q?eP3Np1b9LbhCipO5rmXflhGFiBIqCuvzrSACY6xUbYrKIiRGs/QROaxR+Esg?=
 =?us-ascii?Q?IAHz+nxwHDxc81FUcnTz02/luX9z/SxmYs3M2yUYfKvfVZCjRtawMBKJX9Kr?=
 =?us-ascii?Q?HgdAbhswMzolA5YuyEj7D4UTpSpBjme5k5wO01eQyaUwH/AKe73v0gMte/BR?=
 =?us-ascii?Q?6GZHOGbS2Y020cCEAKWwqKNtggawFwN+y2qkPsF3VSc3ZbeQ8YKG9NG2+u3E?=
 =?us-ascii?Q?K7FD7n4WBbQSYIIfagHx3lZyCnbpsxUnjd6BK090GA+zYwfElPlcS7BlAxvk?=
 =?us-ascii?Q?234VkfupnPZecVhOo4VaTmt0cdBPxZxhFjrxIOuDoBqkZJ6WMpUuVBy5ktUJ?=
 =?us-ascii?Q?fhHY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 06:13:43.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e0db875c-5670-47e0-7500-08d8b20a37fc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nXhuEF7IsImgEUxMA1rbnqTAXIhsgo4+EDERHtglMj0EEFKoqSz4YbfdNNe5j6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add check for SExSH clients in kfd interrupt handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 0ca0327a39e5..74a460be077b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -56,7 +56,11 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
 	    client_id != SOC15_IH_CLIENTID_VMC &&
 	    client_id != SOC15_IH_CLIENTID_VMC1 &&
-	    client_id != SOC15_IH_CLIENTID_UTCL2)
+	    client_id != SOC15_IH_CLIENTID_UTCL2 &&
+	    client_id != SOC15_IH_CLIENTID_SE0SH &&
+	    client_id != SOC15_IH_CLIENTID_SE1SH &&
+	    client_id != SOC15_IH_CLIENTID_SE2SH &&
+	    client_id != SOC15_IH_CLIENTID_SE3SH)
 		return false;
 
 	/* This is a known issue for gfx9. Under non HWS, pasid is not set
@@ -111,7 +115,11 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
 	context_id = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
 
-	if (client_id == SOC15_IH_CLIENTID_GRBM_CP) {
+	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
+	    client_id == SOC15_IH_CLIENTID_SE0SH ||
+	    client_id == SOC15_IH_CLIENTID_SE1SH ||
+	    client_id == SOC15_IH_CLIENTID_SE2SH ||
+	    client_id == SOC15_IH_CLIENTID_SE3SH) {
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 			kfd_signal_event_interrupt(pasid, context_id, 32);
 		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
