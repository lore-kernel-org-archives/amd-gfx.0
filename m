Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED0C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21758206B5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bzH/GWdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21758206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EA46E991;
	Fri,  7 Aug 2020 09:31:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2C56E991
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 09:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCbOxuEDln37HBJTglapTpONS2S35FyItkhhj5jQBl+JO6l5fGMNHbOndiZIg7aoPlTLor+0ZF/0ekBmvGvgIQIYZ7i8lFuK6yxsjhxqfWS8RSmb1rdb7Il67ApHG4Vtsp7FweTeQU0S8jKspmvKgJoMI/+dkUTqhwRVzB5ZviyXafwC7ZvjReVUgPngPscaKo51ARIH77r0uFrzfEsRJDH+yc5bJfwRtJKA6crhdyp68tfu6IdnFkTIxZY0X7bDdlNrDdTTsAqZ5fF/O09UeHRZZSGdboKcLdSqjGo9gyeHPAFRhUwnSLljP493giIKCTFTlMBpMST9Fd40wTuwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58SlYvPV2zJx0uRjMya/Mc2yLJv6ssc+kfx0NpUedG8=;
 b=Chn0vHwXj4sPnjfLkBFn1MooNv4tRdjKcFVnvZRDPHrEp6hVg/kl8t6jfuo2mFVfMbqtuFpPK3xItVnZKrx5g8G3IzUV5VdfuncatDhvGwwigU8kylBATDsojjpyfiI5JpzSucYHKbbBPDmnhYjtgt5vrLnkWPZcmsGhKNjD26Xb6oWaUxSS74tgulp7gaboz/JRTsi+8ljW99oqw+9a3HvtJoEBEw4V8tIxa9LenANeARQsfl4ttO5M/DRSyxtM+opLbs3gmeTRbQ6l2BUTtRt3X7ixpdsbLWD7hxx40lRtd0hJQEK+w7Hf+D2zRL0WDLP/lhtGsXpANhr0yAb5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58SlYvPV2zJx0uRjMya/Mc2yLJv6ssc+kfx0NpUedG8=;
 b=bzH/GWdmhpKVa01P1sG3uPj/C2ObnqMO+G0HFecD4IcU62g5WYEd9UyCDWuJsCC1936tpjJl7jV5JF6TUXoPX15YVNsm8YKCEwd5O/wdrUp+ApcmhmqbQrBs/KnB+iMPgjUkKRoTHBlFgT5Sy7zJRM6bYBLITN3KHzRiyZ0snlE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 7 Aug 2020 09:31:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.022; Fri, 7 Aug 2020
 09:31:46 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: correct UVD/VCE PG state on custom pptable
 uploading
Date: Fri,  7 Aug 2020 17:31:25 +0800
Message-Id: <20200807093125.562-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19 via Frontend Transport; Fri, 7 Aug 2020 09:31:44 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72ccf442-3550-4c04-85a1-08d83ab4b3a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360CD0812E7E142E31FCAABE4490@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziPjAaKHzfPSIqfv4IKDKQQoFERfsw2RxXGqlXhDXYSCz76A32+/IhIG43O9Zh3KoYfVsjBzMaz/n4xxxJ2klD8gleZGyceLuKpzWykYQNnqNPfpw+jWcy92bMyM5rkDRXPWPYdQ3FbxoKmuFQvKi8F7rR/03zR7O6lKIUbZrX009RNDkBmv3vNLUEBULM2JjAVLJXNkjofYvxSFe6Dqcqi0pcdHs/olfarIRqPid7kWgWjoTkolwp0F6Fr+5TVDCI4M0UMSktL9zWkQ39/RZcB2yNxgmo7SZJcOePmxeVLAqd5X6U7p/dgNTXDuzXeQbUK8NqIQ5TcWs/hPkkpDCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(316002)(4326008)(44832011)(1076003)(956004)(2616005)(478600001)(4744005)(6666004)(6486002)(6916009)(36756003)(52116002)(86362001)(186003)(26005)(16526019)(7696005)(8936002)(2906002)(66556008)(66476007)(66946007)(83380400001)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pZ/Jp3Sd5Wady6QQgUepFcHPafGWc5cBVEss80mFrN308gvzmg/7rRvvR+eLKBvxopgerRwnmdkfIcUuv/09ZoIUHiBYB5t59OeN25kDcqskYrEO/N6Z7ZlIZlw05C0TEMd/EX0DIrefdzvgzgga0fOETVnyJzJ2JioJDqag47B+rONAnG/eBCry7Wj3hT9cwWgZ57DDjNsWfQgQpxDAkBocbQpoHYYZG8UrOGre3AchGkSp58Pymm5U08OKw6xZpSs8/R34Yh1UeO6hPyVYMpAMOPOxV2WihJ1TMswQnr8RB2Wh0/EJrAilSq6TEAh1LIDDwab8ijXPlWBp+3sW4/meKcaPa+Zyle+y+uslDecuzyrgH+yMi+YMUSrIeuVwMIJfWgoCjx4WUKSCirXzdfmh6lq6wXBnhUdGSXs3e1Lcq/v2wuqCfEjVyp7DzBCaXTdso+QAMZXbkapeu8n92TXWLz3YulC2xywiDdPcgSqTR8OZzOmO+hmmrVqX+N4AZSpLOZuZ2DuffEzAOsJnafm+29kbnQH5ikhH9CkdgnYR0L54rKUU2+nnyw+Q6J0w9HKF36JbEdYvl2rJtyfAQzdYdx9z8qw0QV+ztmhlVTE168MVauXrvi3x5bVUt/vSNmJ4ydnZBFJE5EzX5/moiQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ccf442-3550-4c04-85a1-08d83ab4b3a1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 09:31:45.8484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZePXFbKt2E3d/I1zJpAGPUuJZ0C/RhfETL+rpIqW7990mHByySeNjHH6w5EK9cT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

The UVD/VCE PG state is managed by UVD and VCE IP. It's error-prone to
assume the bootup state in SMU based on the dpm status.

Change-Id: Ib88298ab9812d7d242592bcd55eea140bef6696a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index acc926c20c55..da84012b7fd5 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -1645,12 +1645,6 @@ static void vega20_init_powergate_state(struct pp_hwmgr *hwmgr)
 
 	data->uvd_power_gated = true;
 	data->vce_power_gated = true;
-
-	if (data->smu_features[GNLD_DPM_UVD].enabled)
-		data->uvd_power_gated = false;
-
-	if (data->smu_features[GNLD_DPM_VCE].enabled)
-		data->vce_power_gated = false;
 }
 
 static int vega20_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
