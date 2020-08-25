Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA62C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD73206EB
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bwvNGZuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD73206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC936E88C;
	Tue, 25 Aug 2020 07:49:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E076E88C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 07:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzMznFSrrSyG4ehEBaPcrMLeWBX20WdY6un+5WQZt+L0rtFxgO9DntSsJzhDcSNl8Fg4Qm82EOX/Qi2rK1zt5ygX8aBs87t3NnWV4HXdKYv7CUD4vQdIP2xcGV1xeAXUlgozm+ZEBkeiXEWUhOiZuqsoIERr2mvidyVQZONwJ7zz8jLdMujm7BiQsS83aFloIEdyMelrc/2BWGvF5INltjnLv1jM0nyNZByLg+F5ZSHxfFXA0l1gEmqI0SCR7ueIHFYicHpW5u09RHa2C9gNwI841E8HABI1S5a7yvXsIArfKBXxrJzljvuhtdpYJVJhgVoUDJ5+k5vI2t3drpSHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK6k4US4pcPamVSHj0pqM6H7//n0pxtMBSb07M107pM=;
 b=Z8IowqXTPQZ9ViVeG4MUiXG4BHna0byP8woMq/lXOSTcyGh5QD/dAUb5cZD00xGbQq/HNrXCnaLt8q2kiKaaojadd9CTwTx/10ok8a5DJ6FZQzIiApUMJBw+l2xtfP36tvpt2E0Rl9OzqoOSgjBV/PoDKgRd0urllWWra15S4GDr+BqsFkVErCm+4EC/hvhTnItnLW/5ondAOS9t7zeXSvHTUnqjLk4NrjpdNU5POISxk+/V6eJ9vuMyovUQRNstF+CSTWPb8KuJbYzw0sfE5ZAcbfo58yxzCLA4T/IJcpUcG5VRvKeZ0JA+jSYZKZHGAYaJuU23gecKL5I2gOpf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK6k4US4pcPamVSHj0pqM6H7//n0pxtMBSb07M107pM=;
 b=bwvNGZuy9a+dPLU6KWLPcRgBRoPLi92wpFTpacndUWDyE1Lp8HvuA7YEwZfKETC+9Qhekux7Gnlzmax+vsbgxAnwx4k8r0wLrlmYeNBB9fApoAOTLQiV3ObDVPnmuOMMxbBL4lferIhRNQj0HIVxE85ysk+1KoFXY5U84iQiXBU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 25 Aug 2020 07:49:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 07:49:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/pm: minor cleanups
Date: Tue, 25 Aug 2020 15:49:23 +0800
Message-Id: <20200825074923.32345-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825074923.32345-1-evan.quan@amd.com>
References: <20200825074923.32345-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR02CA0200.apcprd02.prod.outlook.com (2603:1096:201:20::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 07:49:54 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39631ad4-9246-4dba-92fb-08d848cb7563
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3083F98A622815AE47E36096E4570@DM6PR12MB3083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkZeAUyB2wHLzZQZppbj96aVjL9xQE8AmTS5YvMsxRqJeGMSwRF6hqJeQckUaxL/CpJHQNSN9xU0A69l99t2gMnjdoWny6viLAcWTf1sBLsbMHDTBDA6/dPIYAIR53k5TsRDBL4nHslbCtk4eIc0xGcU5ZGj2+CxzsJvE0FD3lpnZ+SO0KjeolwQaIB05XEla/DyZ/ZH+AwdlqGBpWzu/Rd3jZz1QSxHiFOgaUtoqkso9mx4u8fFEYSsXdZRHVAIr56BQo/9ZUyOzY9FBjeg8ntwhdXmilw7YIUCETPuUc/Cgau06KlR+By/qBGL1SPy0xwh6uVwHjuhvgkx7YtMlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(6916009)(2616005)(956004)(66556008)(66476007)(66946007)(52116002)(186003)(8676002)(316002)(16576012)(26005)(8936002)(5660300002)(1076003)(83380400001)(86362001)(2906002)(6666004)(44832011)(4326008)(6486002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y4BRP78pAY+TZNmo7MYRtoOIft6YkY7JDOcOrgXrcFtyqlPc05rbStr1i832O7Wh/kmJRHLZ/HJS4glWArsXGeXRkM6YoW6pugivjK3mU6ZmZEd8UdjqlKvAqje4YlRe3xveHOsbOD4v40VQyVP+n0gvviSVmMy73W1A/e4u26M8eNTV2oewtF3LyuvpnhCLKa0aHVbVOEPu3Ju8Bo04zVGjGvyY88orcUTZj9+sr72GncvGEPJe2tke+s9JFwyHo+jdZMMB2skA1BgUrD/bS3p/TsGIYGHIo/sQEZk86iRxfNFU96EeDDjUXaUbmqGUEaNZThrpkO8aprsMQgl+gvXKlXtVoG/iXJJU6n2qz5ewYqKYQ6w5cZZLfUhIXaZD+jVrBkEOKhhyIPhRcXT7mhgrLoIyK/wFT704NQlnLJT3rgHaGF7G5o343NjnF9YEpKCEJ2V0IFK4TR8Jlf6FSwJpvO0FTDRYjjPH56luV6Q5Mo01FjY/oLBMpR3idkdUyrNYsOqdC+sVAemjH3iDReg2H7RN1eW7rzG/nZWSXKnkIih/h+VnhozkGNPWrbV6mUQGE+iFNUoXnkQ+Hf6r3QZMic8u8bQCEbVYAeMJQJe6ya0jgjegHh+ff3X6kfT85eAkUCrUuTKcUYRMDKOKqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39631ad4-9246-4dba-92fb-08d848cb7563
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 07:49:56.0704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz1AL9SJzkBvapNWFxQZJpaeK64pW+pD3wjjUVYONCY4PrNCKqBHrSvrdpoVB3+F
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

Drop unneeded "ret".

Change-Id: If5eabb1e96153133a833d0e5b1dca9c0f0928891
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index a83b3635df40..e4d333d1b9ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1172,12 +1172,10 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
 				     uint32_t pstate)
 {
-	int ret = 0;
-	ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_SetXgmiMode,
-					  pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetXgmiMode,
+					       pstate ? XGMI_MODE_PSTATE_D0 : XGMI_MODE_PSTATE_D3,
 					  NULL);
-	return ret;
 }
 
 static int smu_v11_0_set_irq_state(struct amdgpu_device *adev,
@@ -1408,11 +1406,7 @@ int smu_v11_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 
 int smu_v11_0_set_azalia_d3_pme(struct smu_context *smu)
 {
-	int ret = 0;
-
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
-
-	return ret;
+	return smu_cmn_send_smc_msg(smu, SMU_MSG_BacoAudioD3PME, NULL);
 }
 
 static int smu_v11_0_baco_set_armd3_sequence(struct smu_context *smu, enum smu_v11_0_baco_seq baco_seq)
@@ -1511,13 +1505,7 @@ int smu_v11_0_baco_enter(struct smu_context *smu)
 
 int smu_v11_0_baco_exit(struct smu_context *smu)
 {
-	int ret = 0;
-
-	ret = smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
-	if (ret)
-		return ret;
-
-	return ret;
+	return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
 }
 
 int smu_v11_0_mode1_reset(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
