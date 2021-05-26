Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C4C47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C105B613CE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C105B613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AD26E170;
	Wed, 26 May 2021 16:43:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E23D86E170
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 16:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfC1B46oIrbo7Zx/zqa0tigi9eyVgM1kjqNeUI5mjnzt9NsPMBL+iCh38odJg+DoexK1sBD/Exa+kmyVOLMe68Uso/3wTW7UpxHfWgwTf1xE2Kx3LFeOeneXvvW+yOUN3Qbu4EPkSYtxvjKjDklMt9NJEcW9JZSNiG+XXdtKsvvviiePuGgg9HIgaDjZ7Dn2lP4+fk3uWt5Qiy4Jgl/lqYRkHEzI4M2JRVT6A7QrQUdGMe7k12YRMqv1MhWNfTm8YGs8GyW3ziDZq5OEv4ptNAdaE3yftEvINWxsQtgWak6l+F2RQfWuTRxTYQ7GZoXBd7x7sHd0GNngB1CPMY5KIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9w/ArS5ZkLoiVhKxF12xfNJAeen6bgDK9gfXnyLbhw=;
 b=ARKFzFVYlrAejbCSQ1svhVV/XkxmwHQ+aMIAgGz48+wrX0QBc/NBtNMJMoJyhB6dHQSPXPBvVYB9UDfMTeJrPM6hxvTqLIx4Lmi85Z0JFsRRrf/JrRPz6zeqL824sCU++NVL+fTlqkKfE/Cg7J8+tkV7OarDPlpZvukTis/zr9STM+9iAS56wFMFmt6qSdgRksW0SWvFO4A4xnW5W7Ofj06qIWHs/h5rX7nDnQPBomEcELvYhoYSPcY07Bj6U7x/GR+r09P0zLJoL8vSpkhyjSDtLa8UqslNI+VOOW9rB74wCXvT1YO++hBlo57/Wl1mcFQzYBiHckSXeqZ+EHkqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9w/ArS5ZkLoiVhKxF12xfNJAeen6bgDK9gfXnyLbhw=;
 b=CdOt/KfsIN3wqmSEETAG7WTwPDF/mzM6as+A/J5YmYIMRUNee5S47fRHg4p6P8P6msygigunBBrqC+7EjT/V9Z9G+de6WKnx52IL+CEvtgTqUFK6SZUednS6w/2Vr1q32pRIBf7NlQfw9etJmMrLFK1ge5+iOPrL6k+h8P7qJhY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 16:43:31 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 16:43:31 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Fix RAS function interface
Date: Wed, 26 May 2021 12:43:15 -0400
Message-Id: <20210526164316.20547-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210526164316.20547-1-luben.tuikov@amd.com>
References: <20210526164316.20547-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 16:43:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7734bf9e-865b-4200-bd45-08d92065656a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4942EBE10BCAF39EEA16E2E499249@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrXF2o0fjKttlB4TNuHouvz/NCaqKOj7rRIUIBG57Yg6KGf/J0wPPOHNmxTrTdr0afK/E6pvXbBQfvJxQAybBICGctAKBN4cML4cTCf6RY7T+mmCFmfAmt31Gp+VX0gu8/XLbfJvZqXgigMvpaRfmSA+TFO5q9K+Fow+ESUGbm/sh3E/HFI8o487gj18iS9cBTHVnMqruFU3VWLW5g7k6Ms2zu9iOe0Ok7uznPV/dR6EsKdDHRotpvstsCG6cCWJEF+BCmk85IDsrRNYDzG7JFSALBxgtVogxhEkZ4j59EZlCDAXh9QKEOZNY0DfrV/NU5SMGHN+NmJiagnS4dzGA+l3gHOd9g0lQL7oOGkfpltaVvn+P+RdqYwgfB817Q83Xas7Z+cnksr3iL43nJGFfaBiGGssYzN76zTezK96Loy3SFbIH1/ieVqwSAldAjkkcKFP2CgWjG/Oh9K3Lk10sSE77oLcTONSNq+KeYf4pcpVdKrDx7BrdaZ1MbM+AIzvByN9EoDF3HgDMSNT2/ue4o2Tx8pUzA5ZXLY1lSal3hiRypeTCj/R/1ifO/BN2prqxDuGpLwDuPv+fN/6gX2DHOawRCunF3UFpVMDgxugxSWjQ4cmpkTK1vRFCY0D0iOt/nAIDM+9zor3Uwl1zqXUXHis5qiDFzfDhCTOGJttrTnfOTY8c7tSPMvG9isdQJEU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(55236004)(52116002)(6506007)(38100700002)(38350700002)(83380400001)(54906003)(86362001)(316002)(8936002)(6512007)(6666004)(8676002)(4326008)(6916009)(478600001)(6486002)(2616005)(956004)(2906002)(44832011)(16526019)(186003)(26005)(66476007)(66556008)(66946007)(5660300002)(36756003)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gen+p7fBuM4DdSlWjFbxWlphb25XCBAOa6Cn9N0pADLrd36Hs3fAWJV5Sr+M?=
 =?us-ascii?Q?r/7li2jdnZSLq1shBsYEQJi8dbH/9VGlryo01cI5ayMezqoCaF8nPPx6q/AA?=
 =?us-ascii?Q?/5Zfa69Ras5p9ojNIeYDnWb6mRPzWzLtH+Lqqk1sBRq/2XpKZqE6x4Uov8GJ?=
 =?us-ascii?Q?tlJZWbT4638Y2IqArxBWP5DTmKuiJ3pW6ILIxmz4UYy1JV9irfrOMApKt/Ss?=
 =?us-ascii?Q?g1CU5UePXwxXLOcY6uR8+GGDbqAY8q/swrco4+wLv7Xdwd9CiE9XMw4q7ni0?=
 =?us-ascii?Q?j699l5A10elXUTOZCrbTMqOPdbbjyqVo+zXueB3TM3M97vSiHZ5CFHh2TYZ4?=
 =?us-ascii?Q?lciwqexEfQaRLq0p0WlvCZtFztdEKGOpV5YvdIhJoK5kAOo1VMMqoXwwSfiN?=
 =?us-ascii?Q?j6C+BZKMnWxROdtdNvPWs9WRovgXGZER2gibdQHbczoA4dd5bOuHM+j3coVJ?=
 =?us-ascii?Q?cC01VIc8CQpv2sUQZWGn1o8d8cTeKsIziRc0JQHf/xXVrGxbvuqYp3PcM7OO?=
 =?us-ascii?Q?D9CcXo9IRimokRhQN+keDbHmz/0bpueyjaM+vQ+0tFaqjJbrejxlST+OvfNI?=
 =?us-ascii?Q?AD1sorAk6mftkS64vbrHAuxqG+odmdKCOM6vE5PQdLNy+l948oU8FWHEddqe?=
 =?us-ascii?Q?41SsScFcoZfJ4QmPSubjGBPy1qWNr26zQBHKnXeGIRfQnZXbzQoQCEDP8o8j?=
 =?us-ascii?Q?TMdsigkhscS3K56/gCgWucqS4yuiUdnTo7X/jM5JnY/keclwF/1BteB6/PnV?=
 =?us-ascii?Q?2t4k+N2is3oKHay7YYGOUKt0CyVdSzkWuHrwzCLYpF1LfAv0DeXVxxLAvOVm?=
 =?us-ascii?Q?MiGJ0ndQHiqOcbJhk2stsQMSsboa6K+awCXpbiXx7Y1WuRW/MP5+av67ayyv?=
 =?us-ascii?Q?Kyjkawv17VuSTjamtOHNdhSTTv0Gwd8iGl2B0XpKJ5C7X8nhiyRoP62CEaA1?=
 =?us-ascii?Q?kwXQ+1NR2zurams3R6FBBDYeuhsALschSeYvymEK20p7zcglke6jBCl0kE8u?=
 =?us-ascii?Q?x+u7Nfd5f5DfEe3hKbOVuLDhDklW0Mr3hT8U62pevs3yeviNGb/jNlD3brkz?=
 =?us-ascii?Q?/u7KyK0qcDEmNOvi2Z1+SIw8TKzzWW/uQNHJ0Um/eb+O7z3c0hHSiM+dARVB?=
 =?us-ascii?Q?ZI4JsynR86vc9FNZAxKrcjSOAaU+hYKwNnE8hWomHOy+/IVWs1V4lHn5cOtQ?=
 =?us-ascii?Q?lphXdgo2YyHBvcbCt1k05jBWXbPJ3Uov0xjx8zvzlrwL7ZoyhpLGw+55HI47?=
 =?us-ascii?Q?L9q2N2o9RtZ982D3+lUvmYxkrMR2dttLE7e9Xlm9uybIs95Jpu+SEszt/KXG?=
 =?us-ascii?Q?0eICA/VpIGhfjN1CYTVeKEgq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7734bf9e-865b-4200-bd45-08d92065656a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 16:43:31.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTvUXaz3K+MRuiOex23NTjVy5Hc3FwQrl7vKy1cKwInnFpBGpCrPxONyYfih1g5A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The correctable and uncorrectable errors
are calculated at each invocation of this
function. Therefore, it is highly inefficient to
return just one of them based on a Boolean
input. If the caller wants both, twice the work
would be done. (And this work is O(n^3) on
Vega20.)

Fix this "interface" to simply return what it had
calculated--both values. Let the caller choose
what it wants to record, inspect, use.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 23 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  5 +++--
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e3a4c3a7635a..ed3c43e8b0b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1043,29 +1043,36 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
 }
 
 /* get the total error counts on all IPs */
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce)
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+				  unsigned long *ce_count,
+				  unsigned long *ue_count)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_manager *obj;
-	struct ras_err_data data = {0, 0};
+	unsigned long ce, ue;
 
 	if (!adev->ras_enabled || !con)
-		return 0;
+		return;
 
+	ce = 0;
+	ue = 0;
 	list_for_each_entry(obj, &con->head, node) {
 		struct ras_query_if info = {
 			.head = obj->head,
 		};
 
 		if (amdgpu_ras_query_error_status(adev, &info))
-			return 0;
+			return;
 
-		data.ce_count += info.ce_count;
-		data.ue_count += info.ue_count;
+		ce += info.ce_count;
+		ue += info.ue_count;
 	}
 
-	return is_ce ? data.ce_count : data.ue_count;
+	if (ce_count)
+		*ce_count = ce;
+
+	if (ue_count)
+		*ue_count = ue;
 }
 /* query/inject/cure end */
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bfa40c8ecc94..10fca0393106 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -485,8 +485,9 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 void amdgpu_ras_resume(struct amdgpu_device *adev);
 void amdgpu_ras_suspend(struct amdgpu_device *adev);
 
-unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
-		bool is_ce);
+void amdgpu_ras_query_error_count(struct amdgpu_device *adev,
+				  unsigned long *ce_count,
+				  unsigned long *ue_count);
 
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
-- 
2.31.1.527.g2d677e5b15

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
