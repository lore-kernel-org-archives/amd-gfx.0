Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B606C55178
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A233D2224E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HhGOcKk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A233D2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAFB6ED88;
	Thu,  5 Nov 2020 15:22:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480A66ED88
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 15:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwK3QHFnAzHxaBsCtCj2gFL8HdLkHZim4ArcDL7gVtkB8Qbg+yhCZe1+qBTjDSZp3z+gF0CBvBcLummPtIpDdDQTheAzYFCgvK11I/x823wO4lUJMxpmzMQX0dodabFndPegsl47qQ6G6SIAQqgfREoOZX0KrwsNQ8OmppxB+YXSuf3LIqckAnq/o9ptx94s65iClcZDKcIw8CaZ9WhpacCByODSHjL+1XgJ7gcjx6cHRlkHu1ggzZhDkhEBACPdM1ihWW4SC1xxz28q0lNlA/81Fnq/ujYt8BDeq+blx8psAfNrO//kqELh6SVCXF3eKx0IjLzzlfQHTYMNmXt5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saA6BBfE0+y0v6ohroNWe6JCGbdLO5nLJzmv3pK92y4=;
 b=maZcSzz5j7Sl1tOBRs1PGVQ+WnQ1We4SLADATsanc8oJKmJ7JzgW6KyEL72bfmOM4kqdc94WrIWFb12owCz3IYHbEDWdfl2TvAundiKeeuXnhpsd4R393XvMf5dn7moPX9wU7Rq1Ur8EGYjeb7TVCK51Q3aW8ZEvniKn367BjvZNKKQW7TKuWB08i/jvEcMQDdppwJt2phoYy1BbJnyrtb9eJLTYCG7HLLzVxXZugWLQAiHFx5RcoQ39vY1EoFUxXKXUBeGrdT0rfqSjn1TLNlWQoI9HA+lj60xelCypQNryO0c8rZCqwDLP800lDdWpuQ0t/aBd/aeG9+nLF8Npuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saA6BBfE0+y0v6ohroNWe6JCGbdLO5nLJzmv3pK92y4=;
 b=HhGOcKk6Y23oQ56JH3kQNfKAp3Ja6KCiim3FBGldXtw1tkv4jHr66HrO9/I4KIw8t4av+zVvEmm8QkB2bhCTL/7TWV1wy3L2WENBglLC9YONSj+MgVyl0l/gwCpU9pxb97i+PJAB3wmqvYNnZpPTjpHnah5Yd/Oqv5fOMQmGtVk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 15:22:19 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 15:22:19 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix Arcturus fan speed reporting
Date: Thu,  5 Nov 2020 10:20:19 -0500
Message-Id: <20201105152019.3651-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::25) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0086.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 15:22:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da84fa41-7c80-4acd-418c-08d8819e95bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29563AA0D4FAA0AFE4F4B18885EE0@DM6PR12MB2956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Tn5oOu3XwaJ/7lIe/Wut957gHDPtUW+PnAEWMLcSjlvy1fhWO/8skGULZurheSIDXTVtPyMuopzeykSXwhcOEHUfIg/vmGFW+fPpg1P3wGH1zFbjvV6RGe3/4zjr2XOros8g6BK75rnfjhYuQ4OZ0ZVv6dQ0yIgN1fZa0lraGZGsbWUbL6igfASWh4LjaPBWH88dPWoi9n45Wv2jdN3eRCvwSwOgYmTTllSB+f5Z3jrzv0t2vpCRLslOMqpi66Z6Sys5GmOQHjxLfVdceTgo6aMGgljX+PierE82I+qlzZuREwIln+Q5LvaIpL6SSo8ms1N2coGlI3/Anp5nO7xPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(36756003)(1076003)(5660300002)(86362001)(44832011)(66946007)(66476007)(66556008)(83380400001)(7696005)(2906002)(8676002)(316002)(26005)(52116002)(956004)(186003)(6916009)(2616005)(8936002)(478600001)(16526019)(6486002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7YGx1LiSlGuhzrGX4Fq80LT8BBiFwhw7pV9iDBhvrqsSMGMe8xTJiq1WCpl6AQD7rERVm80kAPnajYYQzirRZ8NZ7qbEoiVxImX+cdDiY72ooXFWG58DcNWYjgxF4CGYE+UIixaJB1mbtoWN8AQyHPwZ37P3xeLvFG9LzD92tPRqabwpy1MH9fp//yoOK+7Yii3IP3Kp+L1sb1roygBDefWMPlUFWReKkXgb4fkSITYQMjPYMWsWV8PR0ISEUZWQDk9Vf0gM8kbpfmPV+1LOGrgtYtGt1dzVinndiJ4FEY5icuCIDpzKPi+C44tcxdVa7OTpHp3zt51e/D2SMvapaOPgeyG/ypL5axi08k5xsbNTf6BgAVqtX9ZqWScuYH+ySfkkauRM3Ci7grC6c9iqb69rRhQMu3epZlC9UZpQPMVWP/rCQX2obxu4elT5E9kYtppsQUbNRzymDdKUBjHTwyoAK22Jbp9M4acvdE4z4mLInuNwMdihbY2LVe+iGaK5lT23+QFqY2PlBMUsPBTp4hSVt6is5+JKLKFNwXjOuBwZ5PyDkViy1M+qlA5EN/qBx+7p9fe6KwCsx8gBhDRpxqEw+qfceklblCod0iQcg7Pda+N1KijBiiTf4eEH63XMEdvI1oLvwciMS+6dRd9+Lw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da84fa41-7c80-4acd-418c-08d8819e95bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 15:22:19.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MTyj31fhNXR6hs9r3QoRNwwIu5r1z8mqHZqpql/Ex6yI+7If0jWjrAgI8PQCDJSJ0Jzwmk6cHVANOlRf0RCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Arcturus doesn't have a fan. The assumption of "if the manual fan
control bit isn't set, it's on automatic mode" does not hold true if the
fan is missing, and results in exposing an invalid value for fan speed.

The SMU metrics table accurately reflects the lack of fan and will
return 0 for the fan speed. Trying to use the
smu_v11_0_get_fan_speed_rpm function will return invalid data, so just
stick with the SMU metrics for Arcturus

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d96048e98237..4fd850e58004 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1139,14 +1139,9 @@ static int arcturus_get_fan_speed_rpm(struct smu_context *smu,
 	if (!speed)
 		return -EINVAL;
 
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		return arcturus_get_smu_metrics_data(smu,
-						     METRICS_CURR_FANSPEED,
-						     speed);
-	default:
-		return smu_v11_0_get_fan_speed_rpm(smu, speed);
-	}
+	return arcturus_get_smu_metrics_data(smu,
+					     METRICS_CURR_FANSPEED,
+					     speed);
 }
 
 static int arcturus_get_fan_parameters(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
