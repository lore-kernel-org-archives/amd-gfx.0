Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC5C433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 11:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F86207C3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 11:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yzUHPBRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F86207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810176E0AA;
	Tue, 13 Oct 2020 11:45:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00F46E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 11:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVTgxCmT3TZY+rX/YjiZa6Wdk7aZym9uQOXv7EVQj8C49eCS/Ud4I2xWimEjUMb3EFd2/NzFM0TIr6gV2JhlpbSIb6Zq8tpsMmYxgemo9Ss1i/V5JYlHnGVFQgnmg0964WiYeUY4yWMWozAu6wQGqWCt06twYf0QLhor9V4f0caNPWRK54qO76nlreQFChQVHTnlgV/QKKNikCWBw3R9rlTaekD08r06CI24PNxi1ns+sz975i6PxEXhQB1OlLMGrh0MwQ7XmRfT8tSQK4v45tZP2AE9SqMLFzhEyRTlXvcHDfMNZeELU4kOCy6YkbXRjTgu66QCRRQk8OokY9Ifjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avnht1NdHT88PQnpgfmFG9DJObCDZKlz4SKqcmCECBk=;
 b=F3bg+L84dxxR088XUGma5UOwHf3pFo4LymeGkgwcsHZA0eb5Ei4b06U4m3AY/EPOWbpjafNKWBiaf4xzvDLrBvOQgLAvj167mrx66DXz8/yuaft2x3eNV7cB71nkBcrpNZYNoFU5bTwS40RUFQgNbXuVKGYFwgJeJWpc8IfjUGBCtbWn3TgB+RjBY/ZMU7U06e5c3EX+97BalrDgGyrQlyy0jKsfYmtTcDhUDJ+eRDV7Ep3UZEvPVYEEFUzRvR1WH9gbA+V+nzhbOFw/wWQ3cB/sb/Cp9x6F6809Ju1jCGbIgaHVOD0ghPL9n4gCQl28EAN35quxtWCiVz8ZoYO3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avnht1NdHT88PQnpgfmFG9DJObCDZKlz4SKqcmCECBk=;
 b=yzUHPBRdbbCeUNPkCnnpHWRlb52IuXvXCzXvkwHzd3v1BRJDNMGMTRwsftVpvTNAkkeP5142jKpmSqztqnqJoEEzp+ZVp3cP7Gwo8NHDFBSIlEPeKQHW19IBvpg4NRpZC+z2j//A4kGoSjgmus4V03Xg02hmnJ4p2w9V4PlwUnI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Tue, 13 Oct
 2020 11:45:30 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3455.031; Tue, 13 Oct
 2020 11:45:29 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the issue that apu has no smu firmware binary
Date: Tue, 13 Oct 2020 19:45:02 +0800
Message-Id: <20201013114502.3479215-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0177.apcprd02.prod.outlook.com
 (2603:1096:201:21::13) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR02CA0177.apcprd02.prod.outlook.com (2603:1096:201:21::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Tue, 13 Oct 2020 11:45:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac3dd89a-e84e-4ecd-6eea-08d86f6d7be2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25227C216B72A710008C64A2EC040@MW2PR12MB2522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mo3WgewogF+tDW9W46QMctnuge6Ez6aRwAzdXuWUpFF3UNRcxQJolD+VuIrZjn6ZA09sOY/fUpr8BiLwBeULidllTO/qJc934nEASfI6FnF5Mt75eWSb2Glm35mqQ7IaV7j0HSX6AZajusaWiWft6CybgGR44ggfTFjnpjfxbdKZm1lS5fuyudPBr/OLtWhWTTh49lxlBIU/w4fw5qKNTeXo6J0O6yzx6vhN2vk+uPXZ9JtVcqnaSVMxFkfI0MUg/7hG8CTUD2KROEldFSTud1Wy4qcIkv5ri+8DVycsM3Yi+CaG8wZ2JL5OzSh9hPHyON2jVN4FIhcYeO0AT1ZXzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(8676002)(83380400001)(86362001)(6486002)(6666004)(478600001)(6916009)(66556008)(956004)(26005)(186003)(52116002)(16526019)(36756003)(7696005)(316002)(2906002)(1076003)(4744005)(66946007)(2616005)(4326008)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NrqSpTsyXYj6jBIRoh9VOhxnv6QvRYC0h3XaTK0P3VMFQdFxLqQ5z6OmwLROax9k+xb3Wrhp6bBFq35fv3i9Il40RvoRRZKaaIIsOZj2L5qT4DuLfki/6ZEFsiQIokvzn1PCi3W9WewH38EVc5ZJV3GnnSrbd6vmVTJjlHY0Tyo3G6df8jXmDs8nRah9ygpnk6F5CllOZfT9TuXj5OwiXW/V7VF2UPkIm5B8g2sVtGxzqsW50xugtGOJxdE3ytK7CLQbODExKak+CXBx1/jh+RQUqA9YLAuobruOii8jT+X9HcK8v66mRrLuEFCCfXkLXXFyp5llksg00EJmrRWHqGbYcVUVa8UOxcd4PnbUpV9Fm51FJL8izNSSYpuIYF3//5IhLkrO06LERngL8g/gUbvihdGIpJKc3M+IWbv6eKlc3UkS6/lcSNZsInEh57/GcvSIA/qDapIfjMzeUfSnxnXABQwm4L7y5r2ld8itSlczAp2VIz7f4IKxTcg3ES9EEZ22Hkszjg9vFs6xPtS+NnERyl0mbyssAJkt7Ta5rpwP1rprDNCcTIIqkYx3WAou2PQeKmRDiw/dGrcd1g7FVaLqKIfDEhCSKcSWCwE+JZAQwA5GomB3KJ6MbsDxAX1gzslpVzJSQ2T33bofxDeChg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3dd89a-e84e-4ecd-6eea-08d86f6d7be2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 11:45:29.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaK7aSj27iZxJrXK0CJnXWa+piXwYswcJUC5UzODEtx9xkpwpo7DVIvXZRaBwqITpzmBQPWpftutG8STn4jeNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver needn't load smu binary on APU platforms.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9d31f9339e02..042ad5e4292b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7049,7 +7049,7 @@ static int gfx_v10_0_hw_init(void *handle)
 		 * loaded firstly, so in direct type, it has to load smc ucode
 		 * here before rlc.
 		 */
-		if (adev->smu.ppt_funcs != NULL) {
+		if (adev->smu.ppt_funcs != NULL && !(adev->flags & AMD_IS_APU)) {
 			r = smu_load_microcode(&adev->smu);
 			if (r)
 				return r;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
