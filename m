Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE38C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BDE206EB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IXcmpWm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BDE206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24FFB6E887;
	Tue, 25 Aug 2020 07:49:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3E06E887
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy3u0hz9JyomZCXqT2oESUxHPeEoF5KjKyObWYVVmgKvhhwc4OFrAfxyxWafGPD59GnS7Q9/YWhHsqhps9kYbD1+d5ISJHVV9F964RzxW7hQNNV5xCSna8WMvCOl2KJtgqBA0hq0vAQdm8pLexUqG7akvQ8h9aeA/lh9RIyjuf3CE+VBwj+UNhBsUOxgHU39koeli+wUuXmhsCmWpjrQSlOyHjpFwX361zCuy/ErOVW+fo00M5OJnnhLr/Jzz+2cLt85AXQ0MAFtW+5f/tgKGNGSqn57QG9U00/0HHUWCCmUYqaMCd1TmXZAygl96judP/hbIhcBjJfa8Kn8eJRQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvUDJwfXJ61ytv0NB72JBpG3zCU9VdyV0UJorG8D3aI=;
 b=S4lBd0tZygeiF0RZjXu/k2XAvDJUBMrXnLa88bj/NDPzBIV3smhG8QWYo68r2/rAsuuaxv4LmGE3+vexoJCDHyPx0TUrKlsYEcjq19Y138oRel+T0EtFZsKHTtKUedxltUuJZnrHYHq6BCCiSMvtkn/likN0RddgMMHBx+5qfv9rZWLCCSWaIITDrULAWS26lVcNqGxtcxsMt8M90YTn1OqB9C9Tun5fNUmc2w6dEDGSYzad34tw213OJPBXyJTfZGGUkL6OBYQHoh1fMh/7/26JvoqSm02u6dJWSxZEXE24v8+neX++c3Bj7h1EKs+QVtYI6+N2pWGSsAOcBFDETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvUDJwfXJ61ytv0NB72JBpG3zCU9VdyV0UJorG8D3aI=;
 b=IXcmpWm3wp5KqkU/tBMrZ6EC8AmIa7AX6RH6tHys6mJdeayzmTiMslDvTPtUY0k5esFdAFM4U0rFep+VdwyHZvWNnQ+fTsBZaJZELBWo615yR5g4SkDMJSzJN5RdThckrlDPaeYQaKFjdPeud+5K3QmOocslD1l5B7DcvGrz8Uo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 25 Aug 2020 07:49:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 07:49:43 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
Date: Tue, 25 Aug 2020 15:49:20 +0800
Message-Id: <20200825074923.32345-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 07:49:41 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24ee67ad-d559-4166-7c1c-08d848cb6d97
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3083E953E739B1642A4218E3E4570@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: He+3YPazgf7B1lunRr6DArUwQM2LKOVOMEiOkpOCK7YnXoMFa9fHvDBt86pGBpWL2BOgKlZYYV9yRH2nkes0jeBvijYL0EATQR/Dq5kjeaAfZSsW+G4Vronz3vuyy4yn/eh8bKB8I4Zc3hceYxWyMwsVHxn7sG9LbYzQ2E4MheHUKty2+3OkhrbAVlLvoZyWFSxN85Nc4WJmvNxkoVwmanvoIfaTNeHx6xLsfMqztxSQjmQnaTfYX8FpoYh0SDlVknZpsbsAUdDawg8U7URqbhE6epGnIcAjn0YJWTjBOwGlcW9sClpFC3sjRfHPEh4+i51HQOIN2fhRd3JLAid7WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(6916009)(2616005)(956004)(66556008)(66476007)(66946007)(52116002)(186003)(8676002)(316002)(16576012)(26005)(8936002)(5660300002)(1076003)(83380400001)(86362001)(2906002)(6666004)(44832011)(4326008)(6486002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KBnX+5D/SF3rUHef/LJBR2BlSDv1ElaBWnWLu171yR7KcTiyYlhPoqct/dGPcy05bJ4L8vmjOdC5PMjzHSvP4FafO8eDXDuXM1BW2gnuVEeeKfZoGBYbM3fRKg6NHl4d/KuhcTU7cJc0SW9fLMqDzV1mqj70SAVF/ojNd8qMWZ5OBGUILMrOHYlyuCYCN+2W1tZs9Eh/hTjRalMI2r6zXFpK5xHVWBknHlc9ZHCbBOjHoY+hMRdVneUgBotciNTEin3nyNURAb/tGqFu+fdt3AkXi6ToW+v1cY5o9EdIeiKTAYAPSlawSNP3SExFHF7/WA6SKTQaJ2pUsagl9Uen+I/T+tJnNBJQMYUGuhu79IUlnpYCRmxZaPypwJvZ+MW9Kv5bfLp6E2AWTNVRKbPF/O7ZGbOLD2yyCEJEVW0VOXtmGhIjoAeUOss8LZhI+c8nhG1Ld6DwknDL6h/uwCJWzyPTVfW5m/i+OxkZAjS8Co5tDNAucpCZ96qILRDzTXSiwWwsDYUSmbHuCyCcP8R53l2KFfzHa9r5slaCJGm2DZYlqVKoIATAoTCFNYMW7Jvkp6QihHi9B0MO+U+gSRqEHZ67auAD95KwlRywraZT8PcOEYmh7BWFVne7IAMYZOJyJN6g6+b3zSlLLG+BjWlYOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ee67ad-d559-4166-7c1c-08d848cb6d97
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 07:49:43.0058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YS04ID/OoKTU8pPSo8ogNQvR0DutOq26kNMCIXgcEYywJCWLLrtCBCjwv3Y7HAgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
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

As these operations are performed in hardware setup and there
is actually no race conditions during this period considering:
1. the hardware setup is serial and cannnot be in parallel
2. all other operations can be performed only after hardware
   setup complete.

V2: rich the commit log description

Change-Id: I096d7ab0855ff59b0ecb56fd9d6d9946b3605fc8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 4 ----
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 --
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 09dc5303762b..b7cad8ef6153 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -361,20 +361,16 @@ static int smu_get_driver_allowed_feature_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t allowed_feature_mask[SMU_FEATURE_MAX/32];
 
-	mutex_lock(&feature->mutex);
 	bitmap_zero(feature->allowed, SMU_FEATURE_MAX);
-	mutex_unlock(&feature->mutex);
 
 	ret = smu_get_allowed_feature_mask(smu, allowed_feature_mask,
 					     SMU_FEATURE_MAX/32);
 	if (ret)
 		return ret;
 
-	mutex_lock(&feature->mutex);
 	bitmap_or(feature->allowed, feature->allowed,
 		      (unsigned long *)allowed_feature_mask,
 		      feature->feature_num);
-	mutex_unlock(&feature->mutex);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 548db1edd352..28a19ffd22a1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -721,7 +721,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 	int ret = 0;
 	uint32_t feature_mask[2];
 
-	mutex_lock(&feature->mutex);
 	if (bitmap_empty(feature->allowed, SMU_FEATURE_MAX) || feature->feature_num < 64)
 		goto failed;
 
@@ -738,7 +737,6 @@ int smu_v11_0_set_allowed_mask(struct smu_context *smu)
 		goto failed;
 
 failed:
-	mutex_unlock(&feature->mutex);
 	return ret;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
