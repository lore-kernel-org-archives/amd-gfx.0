Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEADC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830B964E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830B964E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039C26EB97;
	Wed, 24 Feb 2021 22:22:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680106EB80
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCYMk0ABKtys65exe2i9siovp9MPsU9WK8qU8MuCAGxyy86QBzsI1JLNoxfaWBSF2YnqnSya9plIQeq87srwyo3qB13O6QTnfYei57NynOtpfQ5SUgM7AHPaFeN+RtQ55i04CPPIXzVLY6CsiKucHKeuQdj9nvCQGA6xgcXvYEAv9URuMkELylQNwMfmFlRgQzMkeoXHt/Sas0yqO0VAeE8jbIU1/eAz/ZG8yD7NtpzWXY/9LX6WhejRHSt1GaOt6+zWxt9YZ7qq+edllJbX5I1UWlk+UroL7rmP6monZbFN4EtC2NmlnEFwNJkmQwkwXVUS0Y9kQRlnDVolOT5ZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGbO5EA5Tn5O1pdtzlp2BEPGeyJGPV9Vqu7NQBk4zD4=;
 b=WGRFbhMPf3u6PdDOLVKr/SDenw5XYYfRMZT8D4ET7uhKXa6UsPJh1eqwnTDXYFBX5QdhnJcU5RPFaX0kNB7AGfOZQ1qH8RFXbn+1EK5AuW2fKSHkcmiNP3nbwOlEvUc/G0VQUaGGysnt/87V+2RXWcbfvbf+tYPW8cqoQinIqkjaddcLVlOjDyqP8ELs3hudCnm1dP48xvxdYadWr+HoX3OHuNkwIWPKW9nBPKhDqOd5HGZymrRjpoctFOR6sdOWI5dH6AvqfbwyN5TImekJjfA/sbSVTdDuy+/Ss8aX+h3m41IGFV/rdKXZ08KBt4SyDHZAYmtLDvd20runYm3WEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGbO5EA5Tn5O1pdtzlp2BEPGeyJGPV9Vqu7NQBk4zD4=;
 b=XMH9CGUEZMufdCfF/LJVrKm5CJf/mT4S2YET7xyD/BSSEfFfxYWRtiuYbPO4JV/SAkTH5tnW63bsrxEcv1CQpJxhz0IO39cC/ookqsriEjeAQ8SmKvCFHKKMRU+IPr/72suXXHlU/DGhWnDFGat++NL4FwSfHVm3C7g8AAyMbB0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:21:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:50 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 121/159] drm/amdgpu: mask the xgmi number of hops reported
 from psp to kfd
Date: Wed, 24 Feb 2021 17:18:21 -0500
Message-Id: <20210224221859.3068810-114-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ab87d95-d625-47e3-b2d7-08d8d9126e77
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807C92D671802AF66E8B453F79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xcb2gvUfOdZAQZtFcqMWE965xKYAJ3C609uRTTmUITHaE49SRzR6j8NGnMnIrh9irtOZ+fcVUW2uPIWYaRjWAcN5H5l2XMToljkllubyHY71DRRkof8rCB7C9zaohInIifRGjSgctefowxphgS7cMIig1NBCM4M2FNWYLfjrLXoQa7Sxlx8P23R9juYitflXJm+17qTOVjROl5+u2dVjx0u4GKibBCva/bh6YdcMn8zvyDNlNrxn8Hy2yiuCPU5NYDT+Dqf7NlnDHFa2sE2EXLRyv82SDNkaY8JWTxnO2bv6O1lKt5QTY7B1qQIO1sBMaMJVM5C6KbegZC1nAkjQtTJZ5KLXjVtI+yqIuIEdIHEMycho5mLM9hlfDPfxYlIppy9idNy8SaH1B4VrpFBNPVC6Z8ZPnWANR+yFEsjXDYQkY/ZCnJUa6ZhUrYJB1/5sL+uyFBNAJEuFx5VG/zTERJ/1DQTc7D+/6vxAD7M03jG4edwBX5hAPs6UCycYIAoXfswHuC2Vx+nUmkewJqLW33iTAqWZzHPc4j5oSyvJPM99k+i+PKjSTTu+qcy28+A0cHrVwIJbYfuAjJEz4D8Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7N3QA1gqsc4EPVEdGouv5L9fzb0L8PzzAhgkHC6tlKKazQpEv86ezskPMds2?=
 =?us-ascii?Q?K9tAV9jlUoBRM61MedMDYYsxgbTTAfM+FSUWanQ+Q5uGQJR79h9wZqNLXdEq?=
 =?us-ascii?Q?A8g5zxbxpkIV6TJsUMWEiS/JMzaoLAoa0UlN9pQ76r69SSzwQUn2PG1Yyf8z?=
 =?us-ascii?Q?aDei9LTBAKv5P/GHKurRRCS3Lwdk5lNI9wlUJSdFSLaK6q61615xXrcsB8DF?=
 =?us-ascii?Q?Yw7jT3E7nrEQ6J7K/58weIVoUs2XqNVDwmTmv2xlIfVAEyAkBof0xoelUlCK?=
 =?us-ascii?Q?RA4FuJyfTzHyRSKRFI/nbs1+bX+bfGYR7a8FGLfcemIfhDjzOfkwIudLeD9i?=
 =?us-ascii?Q?RJef4JhVqJSjvBQYBR9pCetCYLOzlM4B2mKYoMrUi3MEMl7j3tR3J1GnEZCM?=
 =?us-ascii?Q?cBW8IBPM8KXAEWPyaFtsYes8kIPUwrrfC2pvLUkv+nPX7h4ycQ7l0IikpSLG?=
 =?us-ascii?Q?Kg9GVPWFnl0L0IM6DKwx0y2cFyd/4M4j4Uc9F/JdHSNMQ7P/6UQnUkyYwKFj?=
 =?us-ascii?Q?vJ/6cHMMtMJzOYGjBODI3+Qk3bSidfOU+h6tXPWxwl98aYF92u7DRFPRv/P2?=
 =?us-ascii?Q?TwbhXFrTPuCpRgVQ1mfU80zFDBZlAGaJ+j+QVxvnU6W7G9or0RAMLXn9K9YB?=
 =?us-ascii?Q?wn86c+1fK4ojb/TqKofMX41b9tJvZDU9fGngSF4NISDwVapP2tB25yhAkGWE?=
 =?us-ascii?Q?0noVJ1kRnEudGrcto/DOk8KJf2cJs8y+CaxCGn+TOBRlCXT4RQcEN6aKh4VF?=
 =?us-ascii?Q?syqFmOeHdgmq4/yVmu/SkaPfIqkmw6ndcO3pPMGXowiAFasrwTG0ITnSpeip?=
 =?us-ascii?Q?XBCf94IQpUX+dzLQ2eEZBKYJM/qCDJSARNNBlMe93e3zvc5JgqXL84y+slJs?=
 =?us-ascii?Q?2HdT3WgIrDtYHlVYvTjpG8p9qZpT3nm/lRZL0nplzUKei9dCMSYEAsz+zfJt?=
 =?us-ascii?Q?4KKQbk4vTa0DieKNMFncwJWr1eqj1F6XXzKhqewhA9Are+l22FtOi+7kJAw/?=
 =?us-ascii?Q?l4VbIzofMniBWyqMC6gQBdjqfRqnDWukAhHScEeZZyMGdf4UH0Sdm2aQ5lz9?=
 =?us-ascii?Q?ZPf863ZyAmwERrqAlN26w2MgvNa1qT48RroOT5noBWQu9L/YaVJNMjNPIk1D?=
 =?us-ascii?Q?UG+8wbJFiEsmjOk974iIwlMZfXU6tgiiRje80ikVRTd/sdj7sftiCo9lMf8C?=
 =?us-ascii?Q?NgleFZfVs6+Db1EBI6e3t3rB3kruc+Q8kp/q6UPWcXddFQWeyxfe9OVizB91?=
 =?us-ascii?Q?cvFARTEurwXcrZezI1Ff85WXN7awYIeVWNb5v7KQmQEWHtkW1ut5smoTT9Ee?=
 =?us-ascii?Q?wsyrPdXONRfBdOJy1nov1hMs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab87d95-d625-47e3-b2d7-08d8d9126e77
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:46.0744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ekw4fbdBlAGZvPXi0Ozmilexmk8SOil5lMbGSMNr7OfVZCo/7Sievh+Kx3jrTAJnyLSg/47yF1kIVVksZDkxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Amber Lin <amber.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

The psp supplies the link type in the upper 2 bits of the psp xgmi node
information num_hops field.  With a new link type, Aldebaran has these
bits set to a non-zero value (1 = xGMI3) so the KFD topology will report
the incorrect IO link weights without proper masking.
The actual number of hops is located in the 3 least significant bits of
this field so mask if off accordingly before passing it to the KFD.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Amber Lin <amber.lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 659b385b27b5..4d3a24fdeb9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -468,15 +468,22 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 }
 
 
+/*
+ * NOTE psp_xgmi_node_info.num_hops layout is as follows:
+ * num_hops[7:6] = link type (0 = xGMI2, 1 = xGMI3, 2/3 = reserved)
+ * num_hops[5:3] = reserved
+ * num_hops[2:0] = number of hops
+ */
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
 		struct amdgpu_device *peer_adev)
 {
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+	uint8_t num_hops_mask = 0x7;
 	int i;
 
 	for (i = 0 ; i < top->num_nodes; ++i)
 		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
-			return top->nodes[i].num_hops;
+			return top->nodes[i].num_hops & num_hops_mask;
 	return	-EINVAL;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
