Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EDDC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 08:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF9A22D06
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 08:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF9A22D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BD56E131;
	Wed,  9 Dec 2020 08:37:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE9E6E131
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 08:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9Ti8T6tF2b3aokeSxTDJcg/rfIYpIT5D5TID7qCn1TLHcki8jFLeFXOHC4Yl1OpN0522jISw5g6VBl53Am/IwscRhgsuTPYdk5l3YT9a1tfx75aQ3YPt1BAQXOtpGs3Sg6NkzuHTHWA4qpCiTMJYYSdkyux9eo9g/DwRz79QYrSbS6AR1A4PLP/9eDz2G0AB0kSoez4tTF7eSDsI6J94YC8jiHBREC1ui7b5gQ58YLMiJo/2euhJHbUaO6WEFDGqG0slQzHqCNtLS90kqjVd7sdTbTFiIWqIV4ldYHQL5ntIHHEZ5uPY0cFnpzLy5D/AsK1xL7O2G9dJtqb3XbDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7AzFWK4JiyI2kWEVaHD4KK++ia2MBBZI6fCBcolsdI=;
 b=UPl+cHJqFZWoHAVQ7W+mizxEr3L+Mev0CvWKhGkt8Xkfr4uNlRwkm6X71sl9G2dbIWBqZ6ZT2Mv9RDr5qRwUCjD7QHiiPDUZxNm3M+g53QdHvCj+TKLzGw5hrV4w/cz4BXHEOCvJrzpMHb92SvkK82vC54I4AAnrj2MKEehhLZmxzJtzugRSsB/1M8ukbc/PHT6MfuTgRPm3tKLh1Jnqn7qcwgSMYjYr3gNu4hU5j7guo0uP3dUwCjYYoInIlIEeAUa01AjTM7wTLQeY971RBNmbVfOFzctPFaMOM5kNcVHHgbQC+jH5XEFBkBMYDiZ9oNEMVrLJUA1wh2W2G/LSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7AzFWK4JiyI2kWEVaHD4KK++ia2MBBZI6fCBcolsdI=;
 b=dSjUiVR1rp78G/eWiWikIh7YwSxo+WhY7Em5GI5gXRPT7iYOG9ASpO1xkbjKVrZ2tQdAGLze5eldDcV1kmg3juWdujtTGX3Xz2PG1qO4lWjSny9+Z4P57nPsMbZsT+vA/L+IscjBSxT5oV3o2fRMQ38utX57d00EbeD9GC6faZI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.18; Wed, 9 Dec 2020 08:37:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 08:37:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: typo fix (CUSTOM -> COMPUTE)
Date: Wed,  9 Dec 2020 16:37:02 +0800
Message-Id: <20201209083702.149435-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::31) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2P15301CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Wed, 9 Dec 2020 08:37:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aaa2800d-62a5-407b-cb92-08d89c1da707
X-MS-TrafficTypeDiagnostic: DM5PR12MB1771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17719E79F343488EAC5AA018E4CC0@DM5PR12MB1771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8IvnKzqzK68j/NA303cJLSLhQovqBwRNGH1BXZ6GNAxJy8ytZRl+ER+rBnS8dfjYRCGFWYn0BwpoHf9WUuuWh6Thw60K/HoBiGGVW1XbAVDXYjBA47Lkbn2MHipxWw/TNJaSyISb0Rrag6pWh9JZgsmNK+FAe87HZpjPdcRh2VAY9Hu+gzrqFgj/Db7z7YDbwaX8VJixOOuW5a0UoDyUjOUsV6um9Mz1BvTzj9NPanKZxSn8rkhM2ewEmiqjN3WwlQQzVWfDHatditGhGBwAdh2e0evw9BA8An5JhveiVN0M/v6t/02Bt0hdUJH6iQILwit0HWZM+wEe92vAWiOnGJvqvCtaCBUtkb8GSpJkdxadEWJg7jeWn8Ou9O9ZVGf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(4326008)(83380400001)(8936002)(1076003)(2906002)(508600001)(16526019)(8676002)(34490700003)(2616005)(44832011)(956004)(186003)(5660300002)(6916009)(6486002)(6666004)(52116002)(36756003)(26005)(66556008)(86362001)(66476007)(7696005)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rvCZvNJYbSXM3QeqGI3xXe4PWdxlLalCtBdDWeJeb30hnL3zJbkdYt6opKnK?=
 =?us-ascii?Q?Q7AcG7g7jeB9sN92jtRZkYg4sEcQ5QAu4FBmvf48SSbyU1ApjVNbD5tooOxL?=
 =?us-ascii?Q?iwojeY/dMYdaAhZq2cOv6QD3yZvQl58HZpGe/H/fER9Qi2UkpQDkQWEYKoVP?=
 =?us-ascii?Q?QhOlfEZgQgau61K/PPNLHl2kp3iZDPVYtxFUIckdYkMi2e28ny0iXtQJT+yZ?=
 =?us-ascii?Q?pL+zsyKCbX0YNKpRFuD5xus4l7We5Gk2Gat5fDpBMmvsrns7qfm4RxXUZfi1?=
 =?us-ascii?Q?KZblXidl6CMlVlRUGJFG51QDS0KnO+lLrqA9+6/ba16gnL01KZcgEySCpK2M?=
 =?us-ascii?Q?OzucNg16DRjPD02kUe6HTB/jHR9zea4EslESGFTIcnZCpq+c1UH3xpvSSBFv?=
 =?us-ascii?Q?I1jwzEHBBri6VA5T/phrDYgmO0LkKJjao1w0OtwcqyIUCWkEeVNDwJywjXEH?=
 =?us-ascii?Q?cqni+FQnxBIJd5pG3pETb6au54rKAZ3WGPrsnGA7H9gA6u4UDqYicF/OcvlO?=
 =?us-ascii?Q?KZuN/E8trcnLIAuCQTcasnV69t9ZlOukPvDU/R0xa5B6er3aDJrvYyK95eyM?=
 =?us-ascii?Q?2l9RjTgNUHeWAmPOqN9urhjx1t+JzAXrVTSQ4uvp0A1aMsMTAr0WqGu0ljNa?=
 =?us-ascii?Q?GTuLmL41EswUZzOd/sl0LTMXwCqpImI8CXLYhOceMGSpxBZlGukkOzDcdkf3?=
 =?us-ascii?Q?hrOIjlkCYfHuJxWK7vfG7vp0Zd5yZS9yFlKAQjBShMi9fUMaZioChDfgyCzX?=
 =?us-ascii?Q?20UdKB5HviFmo6QFUCSdnZ8pMVtayyN3V6vhmUxIStMU5Ld08Bgutp/nFn2Y?=
 =?us-ascii?Q?b+CeWfh17LP1Pcf9HF00W5tUz1JXQZ0CXu7wGJHk2MqDPKVXeoTz/Jv+q/5V?=
 =?us-ascii?Q?6qTLEBOhidCFZgvSoGm3u/A3A57Y0dUzZ9t41ncia9ZnFOl73L+fIHTAzCsL?=
 =?us-ascii?Q?3J0a1b592Mpgzq6BSlB6JAyGu0Ibc7qFEmv/CZp747ajYAcbvO567svcCsGk?=
 =?us-ascii?Q?PYSA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 08:37:24.2346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa2800d-62a5-407b-cb92-08d89c1da707
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP0BYzflUAkdQKdUbBhbFY1VZV9/tSMBO13U9TRGiolJsOZ4Q+IyeueOJ6Py4Q5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "COMPUTE" was wrongly spelled as "CUSTOM".

Change-Id: I44a6c93ea8badec2af883eb5b39261789baba036
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3fb70cac72ea..23d0dc31789f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -220,7 +220,7 @@ static struct cmn2asic_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,		WORKLOAD_PPLIB_POWER_SAVING_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
-	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_CUSTOM_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
