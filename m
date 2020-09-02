Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEB8C433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D5220773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hHX1b/J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D5220773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5BD6E155;
	Wed,  2 Sep 2020 08:32:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6026E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNxpCeU0VMN0+RSoWWMKP2xhxQ9ooLRWnFne4B9nSn05d+rPyUpGV9wqQBeWVMqpsjBLxx2gZjpn9Lb+bTtFpKTceTialdJPcBlpuvmCeshhXXTNpNtz34Gqs0J8MrIEydzQgCO0lcbrvmZzxqPA87aS+UH/o53Ish+UE5KE3FlUhnYKK/2GOB4HMERvfl2Sh7jS6lmv9EQtipNZJhfm7VlB8FbNuPN2FJ0Y6A7DU9eEq7XgFLRmn6frZZVdQrxoIvSZktO4x8YIg15fRqpCxAoXAmliNmCdV1w2PxveNYszYrTHLaQmtYm6bwWoqf6/kH2ELAf82i4Yt1OPu/EBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+1RgotfZQHTyicKxXTr6pz5CjCOT7mqxVUWnHqlb7s=;
 b=V2RLO8bVpM1IPiOe8tVjkIdRlcxQAm1txWSbR0t/nszq3buNTqMC7s5msRmCQitea/5ex07djuU6uwrbAxt2z0qZl+Z4I38qcID6tPRwISj9jf3rxaI8Ykhy1xQ3CHh8/2iBMCoMfm4peIEo4uSdz6FmHuRUwhJacvTrzIqAlGGIQvXi0FrqakB2Zloma6P7ryyD4dj/6mMNjbgwA6dVTSgQD7NH6U1MOlZb55GrrAuNi0GpYFC73EPrd5+QVYIuDwwF0W8tCd8a7KzuSW/zTQxuiDF7aYCPAzGs1Gg4ZW2HL2E9iDnifHiegqSZ9s23CF++lWr4msZCJ7OE+pIgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+1RgotfZQHTyicKxXTr6pz5CjCOT7mqxVUWnHqlb7s=;
 b=hHX1b/J2yrCy2wtxHHJWU5bJVWKwfbCKkyubkfatDO5g+Okw4+vYEC8b36kMhqUUl79zVJiTT6H8ELxxEdb9OGGwYoqIqVYwyMiqsBzKeZy6OBBpgURHbYPO28sWSKVq8/GqUyV4nhg9ecqVAn/DeanKkh7tL5G3lqUhqAunCfM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:17 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:17 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amd/pm: make namings and comments more readable
Date: Wed,  2 Sep 2020 16:31:34 +0800
Message-Id: <20200902083134.25569-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902083134.25569-1-evan.quan@amd.com>
References: <20200902083134.25569-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:15 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 925c6409-50cc-421c-3b32-08d84f1ab364
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB386815F0C564F80B5EC8B41AE42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3o9d3XTweIaE/YNr6zc5dO3+IdBUYzIpxk7PZSvXiiOjn4NxvHY7NBo6zzFzwGznnuLxIUyQwjne6cXESDJ8BTJJdN4/qSYKhglrwIuziM+jc78dSmpLfEeN/Agh1mqwtgP04Xi88I1tQJuMK/Je6KLGAipm4J52a5q3gvexAFdf9xTgLz0jzzAuijuwwKn9xKUml1kBepU70eNJAMlmGk9QK4K98cRzvfHoxpD5xp0jX+PZRyIIaRhoZItF00f7hnnN3ItG1MDhKC1rs0DzlJmcjsS+PiDqr16ro+GPq1jba0OsHAb9tph9uPcBl8s5CLdXCYsJEkNaKMl3Vh0Ozw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(83380400001)(66574015)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: E48TlSuztxNqHUq4Xx4eTrA3iz+iEKMnInFfRXH/yQrF547NQLLPSI+udTd0uWrFFmqKSVItInmTLqs7MFEpjIT1H0o6vTClXF4CwCoiV09swMiIe1qA/QXa2x3n43dzAqdfaF8sHPLWMvPT3GptmvvOIQfvXrYY4krBu12RnZLknXEbWHMSNvh8Rp+ZGnKyJxkBI+7Wy97kq6TKIpjU9A/KmYzMvDp6Vz87SFv2LImeW7tEJaJiEBEM/gY1YQ/Lb2BSIwqcET0bIDUF5r4DEEXk+oyBt7h9xVN0r0mKY2i1x6Z/AQn9KajfZfDUKC8eQnasvl26V7q7LzTWcvWLfFk+PZww+mqaLdNBGn4zUt2rJAPsHJBkT4LBt7glCDIHZ+Mgxv0vnDq8L+wfy3H7ZkWaSVNDCYScfY8PlTv+Cl8DLBHvKJHYF9/4MCws1PUDIbK0aYq0EkNMudgHUuigHO0CbqG1uGTXknxOAnHG2rt4bZW86YqUErXGCBU0snShwXZAojeFxpJVKyO2HhzVmuUy9Eu5iLJAKcFOVyqnuJ0SmyyiduevRDVtWuGrAWMQpLwr7520aOERbqmWxgx3jp0TJYXCT3YjpnugrShvcT3qDeH0CPExlAfjaZXt91IlN7IXXuo7hjOWuFRudXSyyA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925c6409-50cc-421c-3b32-08d84f1ab364
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:17.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWSCS6n1tXJcCchx1oXfnF8eSLdwJWN4ksVt4XD7t16noayRgPwXKtbrwHgZKQZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And to fit more accurately what the cod does.

Change-Id: I2d917e66b55925c3a14aa96ac8e0c8c2110848c0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 801c92eb439f..cd5394d4beb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2185,7 +2185,7 @@ static int navi10_run_btc(struct smu_context *smu)
 	return ret;
 }
 
-static bool navi10_need_umc_cdr_12gbps_workaround(struct smu_context *smu)
+static bool navi10_need_umc_cdr_workaround(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
@@ -2276,7 +2276,7 @@ static int navi10_set_dummy_pstates_table_location(struct smu_context *smu)
 					       NULL);
 }
 
-static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
+static int navi10_run_umc_cdr_workaround(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint8_t umc_fw_greater_than_v136 = false;
@@ -2284,7 +2284,7 @@ static int navi10_disable_umc_cdr_12gbps_workaround(struct smu_context *smu)
 	uint32_t param;
 	int ret = 0;
 
-	if (!navi10_need_umc_cdr_12gbps_workaround(smu))
+	if (!navi10_need_umc_cdr_workaround(smu))
 		return 0;
 
 	ret = smu_cmn_send_smc_msg_with_param(smu,
@@ -2655,7 +2655,7 @@ static int navi10_post_smu_init(struct smu_context *smu)
 		return ret;
 	}
 
-	ret = navi10_disable_umc_cdr_12gbps_workaround(smu);
+	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
