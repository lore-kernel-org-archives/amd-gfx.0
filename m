Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C45DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C982072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JvX+qBzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C982072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FCB89BB2;
	Mon,  8 Jun 2020 10:53:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6045F8933D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6Km1sFJv6UKNV4VEnstVizhkxScMJXAAoF9qcWPk8GC0ExllbQ4Zt+A4J55pkiAdn492+qE9/CKL207GBBQSQthEG+mesnYUv+xqemLMpQE3GLF6MDpprGvDY/Mbi54yQ64Y53xad61zGaoWCFn13s7evTTPMoQ2jneswBVPTYpG24R7w0i8tJDR3i5U57ka1IcakuwAsvdqwBE2OBub8E3KuOvtbKcVdOCFZecR5p9mlev7wC8pq4fofAKZHYmewjli8oAaCUKd+hGNIHYDHTTX6gIqc6PNxt3mp7YdJF3xHBnpmwR+M4vaP0NYc29S+iOkP6zw6fvGwipyfVxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxrcEyf1aLST+LHC98tinaY4uTrIa3PSKQuEZEDtBJ8=;
 b=IeLZy+udJKtkTB8oQJdfZACTd/RrLDGIO+Gey7eH/PyUYvxB/Lxk3ayNCh9B861rvNoI1H2lTDoUu/TcieT1RKDADps3C/cRfwSlpd4oq7nCxHfxYD+fgaIKV4Eg6C4mg9a27UlIUbZCKHHH0owBHFbgLSWKfL+BkVdTkLYeXEIem9Jff6xgVMoQUdoeCzjxBXKY31UCzhrb1/IFyzZgb7igJmnuWqGjHm3lOEAwYCrhKlNJ7tvzO90jBqKj9olgGxI0y+u+VHyg3Qqkt0TYRwEcCR41i/ObuM7bQVoMZ3o8KWYjPuB3BPKShNpj85n8hq51oU99pGxVDvjXffGxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxrcEyf1aLST+LHC98tinaY4uTrIa3PSKQuEZEDtBJ8=;
 b=JvX+qBzn5U9snRdMQdBaX+9ikvHuOQxHrdb7zi8O18Eda/gTHMPJc6IE6NhV58x88nBr+mICsGX3MZnpGf/tVsYhMwji7LU4hMaODHlc+A6QwmVw9H2gz4rhK83AfcJFy3G0Pf3o9jI/sLxwF7qoAeQkWJQ6iXY1l2ldv80gz8Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:31 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:31 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amd/powerplay: simplify the code around setting power
 limit
Date: Mon,  8 Jun 2020 18:52:31 +0800
Message-Id: <20200608105234.29864-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608105234.29864-1-evan.quan@amd.com>
References: <20200608105234.29864-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:29 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da4d7d8b-6d4e-4ce8-db58-08d80b9a2eb8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546163BAB95788D9A9CEC1CE4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLPcmmDUl1MwU3MW+a2P67+Vm/JSvN+SnPWt6IdV1YPw2XanTwGKj76vibmk3o2qvW78a/LxivMbMRMejTFNuahWrOH6KEWXSrMxRsypazFFP7pzs8ePUWh8ahifBYXaxsj/l6W3/MbxryMnA5B7FWz+vMPWHkQpPt7AfNpnVmrxiiWF5C8NAIhctCYFSIUj2M/0ai7bjMX9Yb21JhmEXVkuVBoSQkVPW86O+uiWecx3EqRJ29c7rudZXTX4nC4NGY1Zm3PIarxBDpX4xeTP/2Ub8x38d+OtknH1rdEkYp/Tu/6AYoEjOhUwSN8QCczXQ//qTIk/D0J7UJYtqH5nNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6666004)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hr2fArXCjzM7E0R3QtA5VOQoVVB2kVWwa5MaZoNQ+kGZgLkB/2PGQcGSXdZu+2+ifWL8u3eAMa39kfOHl3cs3D3Qw7+IW9GiD3b+TkehErwF3sEUxrBJpFAhu/eRWlmjg8f3VwDUJTjL3vYU3AqXZ0NRVqpwZPjS/sEeVQWca03YJmN4jCsTKwtOJR1SoHodTkCnPPLiNkxBxcvVO6d/VgulhAQv55vlzv7ywRxtx9Odz85oX+guNxAQ9m5cR2gBJw8Tf+KPECs+L8cMAp6M9ZGtLxUsmkVhw4D2ajuyCJ7gVRKLt8FNusOCjdQEMSIdLnLxSelRTsP+CY+BTKQERIIVsW1gOjLFsnNXqa3ZJMq33mr6utShRDGdRyw4yX9ktXq0SnLI7mTHtwq48OC4A8Z7Azjb9riLOTO1F1bkkdT2mjOO5tfDCUZUAAu0XLqTkZ+PMzJKf/o+nTgEZnbxox8R05jjfo7aMbN9lDNq7PC8+3Pgms96IKbX7Rcay4eT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4d7d8b-6d4e-4ce8-db58-08d80b9a2eb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:31.2799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJMOGfEO8WmdlUYY3sw25gZ0yapWmLPiD9rkT+KB0P0IP4nakpr0LBvGFfZGXqcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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

Use the cached max/current power limit and move the input check
to the top layer.

Change-Id: Iefc7a89b871ce20422c2e70b8cd7ac85a0a7beba
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c  | 16 ++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 6757f65fd87e..7cde80c9614f 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2239,9 +2239,20 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 
 	mutex_lock(&smu->mutex);
 
+	if (limit > smu->max_power_limit) {
+		dev_err(smu->adev->dev,
+			"New power limit (%d) is over the max allowed %d\n",
+			limit, smu->max_power_limit);
+		goto out;
+	}
+
+	if (!limit)
+		limit = smu->current_power_limit;
+
 	if (smu->ppt_funcs->set_power_limit)
 		ret = smu->ppt_funcs->set_power_limit(smu, limit);
 
+out:
 	mutex_unlock(&smu->mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 358c903c4a86..34e9ae813000 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1082,19 +1082,6 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 {
 	int ret = 0;
-	uint32_t max_power_limit;
-
-	max_power_limit = smu_get_max_power_limit(smu);
-
-	if (n > max_power_limit) {
-		dev_err(smu->adev->dev, "New power limit (%d) is over the max allowed %d\n",
-				n,
-				max_power_limit);
-		return -EINVAL;
-	}
-
-	if (n == 0)
-		n = smu->default_power_limit;
 
 	if (!smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
 		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
@@ -1106,7 +1093,8 @@ int smu_v11_0_set_power_limit(struct smu_context *smu, uint32_t n)
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
 	}
-	smu->power_limit = n;
+
+	smu->current_power_limit = n;
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
