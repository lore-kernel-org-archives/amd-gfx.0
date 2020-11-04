Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D2C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 05:06:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1152F20639
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 05:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OswBjZPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1152F20639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E686E93F;
	Wed,  4 Nov 2020 05:06:30 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576266E93F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 05:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMkU+3W7+E+c2EiHE3sDea/7OqHvOMWD3Mkb7RebBx1q9WxdET7Khjz41F65wP2WFp0hLWh+vxT60yWrQCeXOUFfpGgSl9jmqYh3QHZj5BNJcRl3QKU6M1+J1H0tvdoOfFLMWwCtlJ9GgWrjYx7kSs1FEetHSg5heB1wBy7InCyOKI56r/pSuEo951ceqaqIlrB0TMr2MAojJDC3v3OO/Kxz/gZRDZdC/7f0wJjggD7LraBT9dLcKePwSaaLac6fawf0fn/8pQ31YdILi6gXY1hGyp9pVjQ+7H6d3mcvapgemPtpFdfSxhhWs9HnjF5+FL8PuUfww0hjdV7tblYFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfQ3cCIX6EZ6Z1qB5GV7V08LwY3iQychYn/x+yTvI4Y=;
 b=IjnVP1hX2CvSlRfKybg2EPA/FBi/AnMt25+2HCwpyxs0lKYxneyDwmkY8XdWFyhROppk8nSEGD9PAaEkzE3mNlwfaAK/INVMCuexh805vyINBAMymj5x8fYtZo5U2NI6CKjVD8qRGL5ll1RjzWDnIVn+9Ay96pUpjQ9BRN+eUczQlnnvO/ptm72fdqth7+L8I+EyhES8blgTl6CyBUBtJ9kPxYzS/Wfg1vb/mp7zmzeH3aVAmirQO76eVnJlLUH45Cq2BS0wjtY/CQJqSJPUjJVn1ik5CmGrn7GIbLY+5m9YUuOR5lTs4YfLzKHHQYfcVhktDfinU6LzVwhudcAv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfQ3cCIX6EZ6Z1qB5GV7V08LwY3iQychYn/x+yTvI4Y=;
 b=OswBjZPCpie6moyhgICElgrQunMem74e4cIrA5W3m/UfN97Vq7p0zvnrpyH12SrJ2Dp2w3EA6c4/07xWZlhtT0+9ihXDuan8gy0kxPgXixsFHFO0n5ypWRwSeiuujWbwoi2umOeUXV6/77mxdYoBiU3v62swf5ZIoZKwsIB708I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2863.namprd12.prod.outlook.com (2603:10b6:208:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 05:06:27 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Wed, 4 Nov 2020
 05:06:27 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: cleanup debug information in
 amdgpu_set_pp_features()
Date: Wed,  4 Nov 2020 13:06:08 +0800
Message-Id: <20201104050609.20571-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 05:06:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18e6bb43-5443-460a-89ed-08d8807f61e7
X-MS-TrafficTypeDiagnostic: MN2PR12MB2863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2863D34FBFD53AA3673F0241A2EF0@MN2PR12MB2863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzSnIXVAtf5EfLYkvR3rB6yNp2vfDfarqutkf3ISK8B++fhQQZogD/J9FYaYHr8XXMfyugsoYr/9tlil9t5Ik2HiQIkkQBGnePzgUMtH6+DcTHb4sA9vFZKzbr4MpQlpj+Uipfc/B2bp7iTUPp2bXbXMchKxQduxLoX10CIqY5sKEt4UKJmuwMG3+cHEOUmM4E3ix5iCMWqlCxHOUM5phBnbriLbJnDX3cVlVZVdxnQ0AZL/O0LWHXy1idDhuCQ4L2cZNb1tueTyWK2+frF0h7fcYYEI6s638w3o6uokYjJfUunpcriugyXCpvm32tdMdoB3nPw+5Xq9+YGfHBJMww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(7696005)(6916009)(4744005)(26005)(16526019)(66946007)(86362001)(316002)(5660300002)(66476007)(83380400001)(52116002)(66556008)(186003)(8676002)(6666004)(478600001)(36756003)(956004)(2616005)(6486002)(2906002)(8936002)(1076003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zUuE8ax3mrPGLe9Y4tvlf09bafmnnERhVK720tVuv4O66HGSQOiqBKl95qGCTOlHS+SA0I05BEokZlaKhc72bNog75+pEQMDfhoSYfbdw1Lyt9MuZryGVf+hprBdDQjwu0l0JXYc1XAGs3qcceVWOetr36qDwhu9gvTjJiX97gJVwt/k3T2myBNZs3fQG9ulxupymqDddEIuSXTm/rzT1o0+78q5KNvV6xV7Wnxiwth0axdDF0ZbjgV4jIJ1bdIJatHOApsJg5ShE2pZJaH3WBgQOs+22awPO7an456lFrpjjZ9Fv/AphqrpPhmiItpxRUxphEGqLhKW64lbKvqpUgMYERlIbZ3MdELjRYceXxYRnnKgE8t7C+2F/BlUPQwzsBnb5GhUrUrP5DbgOsUpP6VQPKoUugL8JTxKBjUZkKx+5qVfCJn6CgoJOrab0/GdAv4lFG5xiuEPYAcnxonPBiwcCSQuccPYdOVhxoZqXlhF3t1QOm+3lfcKOlxE+D6sseTBiTWA/3QhA664UCq+G9pseWJ+Uy8ZRJl9/mRE8FFZm1hSBD5+OyEBbRnjdtCE2zfEK/Ir4geCUIJ23Wx/su/YOojuBHYES26dwf7BGA24mAR1GGgTRopZFjpIa5wfa9FDM8MfsATeLGRauKVYTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e6bb43-5443-460a-89ed-08d8807f61e7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 05:06:26.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/ylSfLrrHmJv64nLJQbq+9r/uMhVvtufdclDH+0rtFQIu6anN3SU3+mSb0eReo2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2863
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
Cc: alexander.deucher@amd.com, evan.quan@amd.com,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e57153d1fa24..a33b1cc50008 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -941,8 +941,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("featuremask = 0x%llx\n", featuremask);
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(ddev->dev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
