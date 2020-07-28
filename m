Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A4CC433F7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC9D22B3F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MtPE4jEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC9D22B3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3131E6E228;
	Tue, 28 Jul 2020 07:50:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA8306E22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnx0RJ9BrNqlUjqF1NpSdcpRSHyVrcTD0PoJ2g2i9q0jbIZKl7Po8UEF3bR3rGFxducfYkzmAAHMQplmRCjGFAMdbaH4atyXhKZSUHMwOn3fhZT3B5v3Z/fmk1+MEOexDxUf+umcjZUof5iyCScGxuw++S2/lArnsnMhkEMOfgGSyLPb+OnhcDNAVsyqOTKdoUOfnt9Cs1Mg/ObSf6TxUxLWwwUU5vtLt3mtyJETRx0pLh8/YDqxmD+PrdYrp2hB7n9vsrSyXFUOCRsO4migUCMLVdabjsZpdguAQuJJpvZpPUZwN3ETDbr8sLU/Vme9P9QUXEeAkvW5eelaCQHGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sM1GiJmXGrgnvhwNqOgYVerkm9DAOqE71oViVKlE7Y=;
 b=mpf59jhusz6FSYIpRP3al+dnQCZH0x/KnsPni4rDw7TtWRpTuUm2eZI+fwJyuXoBAwTqrF9YL0GvCbZtBSHxV/zKn6+Hor8R3b94YFVg7i8+teliOYdqDua+yjqkWukH3zYuN75oYMAz8fG5PqyTnO/dnt5giXsZAwE1I86WkoOatUwqb0TE0NY1Zfu4WI5+a4iPadJXrkdKINz+0c5MUPg+MfdnZ8etqhHwjf/FEiQRCKRUAuCANHGa9lXXNzTDANh3kxbKfhuOAlevavergIfDuIaMXIQGYc/yT9Df90JFq7gsJehCkGav8QHP6XT5C0P73h5Bm6DftepgSeYq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sM1GiJmXGrgnvhwNqOgYVerkm9DAOqE71oViVKlE7Y=;
 b=MtPE4jEi+OJzRqdP1p/s+JM3BtLx8NkBwGMt6AJ0p2oLE1SWS+b61YJn3ew91Vpw0orUoFrXKMOw+pYIdfoNA0zV0veTEHY1KV71CZT6ncn1JPr+aG+tkEeArTfooAUbWLlK2rOItADV8nWZjoV5ImJolMJbWksLTyW2Vy+ZomM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:32 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:32 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 11/12] drm/amdgpu: disable page reservation when
 amdgpu_bad_page_threshold = 0
Date: Tue, 28 Jul 2020 15:49:33 +0800
Message-Id: <20200728074934.12490-12-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08e8af59-8a11-4d28-4b09-08d832cae77c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1752C686E962C771AFB22F96F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdvRNNAUHuntaS6Iy3qW7UNe1G40Q/b8vzchRzLlUnPvfVfyVwqnoObvAkdwAbID9C6cAaHLA64mxC36WvzEIbr1geZbJd0GvdYIK1pYVxZkbLnKBG9lAX296LoQER4N148lllVd53gM1p9Vvb1Va17QWY0BU2455KcYv6vCWgCgDQqTwoL2to9UC8pNxL2dpKW8mAHeY0O9Vl9wZN3K09mIdF6hWON4UubYHxy4tV/x/S6G/DedO2IyRRAfDDwBLP7a19R09qfIw3ndLoVhKd6U4Hu9fqMDC6dc7SYjIi8vVkccWVsIq2KxCFxWvxs5MV+3Xazd6yKMI3iBrpXfjCzfR26Ok8Yvr3EeS4JM8Yfy8tSp7ntE81Qj9CWC7f3O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oFa95FrL/r4C///AdQB6GDQBfO0qnV9+BlXafL5kFx6mTIjCkJvcu+n6XlF7RE6wU63q3tjtsVI/1lvS94cp2m8dwzbm4SLL2MNqR9jqiREMKFopBKb59M1mrgLNlWTPIFzOb9oo5AmktNjW3KIO+MNWV7tnIXTflwJ6HzZhBNHrr7liDlkVz7YuVU9nPWgqUpWPmFFJy88ZlDm2sXMd/4PT9JXtTUUhtAz/qJueHzbs39gcEVLDxRGen/tZDYw/X9qXoSCu/IHDnprlWKMtIo8WuX6st6ii8wFjx2FTWGXlpB4DTGJKjy5XYsiWAO0MxsAmCTHTZwSm+H+gbrB+zvJOUkjN9Jn/7VvWJxy5AwavIfeHULW/8z9tavjC0K8G7RH+Tc0inEg9Ife87qiduX2gu8QSLo4DGK4bh0uET0vV7YjvfLWlgV3L4z+tkm9gYXJibUzAOnREA8WSCxIilJVZWgd0qE5fZdpCHmPRu0YjCWOQcFfV30VD3K28J0mL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e8af59-8a11-4d28-4b09-08d832cae77c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:32.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEPROKSPpO1aWbyR6ESQn3NYzZntUOuy8/IvcCwkXnqgCFgqzVEDu++4OsR70VYAmgylJqWtnZI871KZeH2TAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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

When amdgpu_bad_page_threshold = 0, bad page reservation stuffs
are skipped in either UMC ECC irq or page retirement calling of
sync flood isr.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ddcf2470a20b..bbff89caf8c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1678,7 +1678,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	int ret = 0;
 
 	/* no bad page record, skip eeprom access */
-	if (!control->num_recs)
+	if (!control->num_recs || (amdgpu_bad_page_threshold == 0))
 		return ret;
 
 	bps = kcalloc(control->num_recs, sizeof(*bps), GFP_KERNEL);
@@ -1782,7 +1782,8 @@ int amdgpu_ras_reserve_bad_pages(struct amdgpu_device *adev)
 	struct amdgpu_bo *bo = NULL;
 	int i, ret = 0;
 
-	if (!con || !con->eh_data)
+	/* Not reserve bad page when amdgpu_bad_page_threshold == 0. */
+	if (!con || !con->eh_data || (amdgpu_bad_page_threshold == 0))
 		return 0;
 
 	mutex_lock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index af1b1ccf613c..262baf0f61ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -125,8 +125,9 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 				"detected in UMC block\n",
 				err_data->ue_count);
 
-		if (err_data->err_addr_cnt &&
-		    amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
+		if ((amdgpu_bad_page_threshold != 0) &&
+			err_data->err_addr_cnt &&
+			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
 						err_data->err_addr_cnt))
 			dev_warn(adev->dev, "Failed to add ras bad page!\n");
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
