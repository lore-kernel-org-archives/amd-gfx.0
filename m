Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D94C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9CC2463C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nKZkbtYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9CC2463C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0956F6E4A2;
	Wed, 28 Oct 2020 08:30:59 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6DB6E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuHr98Rdn9ycgMXAvQM2EIsWlYONxGm7hxlFLhxqJiQfqOBm2JYSXIprI4CL8XmIgv88nZpIby6dG7I6oTgL4H3AEhd6PN02B0qiQNm2ToAdZbIuUXdvQon0u+TiVxUE7Wx5scoy9E8Jalce7uRAIl7H66RJl93fkh28s3KMDugIqid7YiP5lkIb6+EuB0d3mnIQUGme6Kji+MjbhSbDGr2nn19m4sidhThtMGhtFUFopRfmrP2kWSjSzRt5aFB6l3DQZP6mKhM8MITAChnz1uDOqfN9bIZZYU79HdxpWJR+U2WBLY+iFvVn/WjYuCEfiMfZR0mQ0RljNPzRlaPOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef3I4mCzvXV+kBGxNZoxZu40bpXt/zsZEKo3EebhWZc=;
 b=YzBM2ZP2LdkFNt4poxEuAoZr6l/uVkXXBWvr5IDs70n0j/L9Vn1u4R2Yww1/GwD16RjC1cf4nhV2XEcl8bOovD01k9XZfr72W+KuFMqIuWH32DZJnd51ezsXnyj40jCQBcwKmxwPRuqFaQY0JKpHgKRKI1f83N+USlEV+4dYCSMHo6c12Vt+8z6LgPTgfTZGuP8qsYa86knVxOR/oXnD49qzkuDIE+G5wCUM3Ju0Am1Gukm56EyWgSHCp2z2ABdRLOMz+v/MZcPS8AtFv2axIXqmFu7GiQhljS0VLMvX/J8vX5CyMB1zd3zXjX4FB52RH1jRq4PD4tfYNE3t6ejMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ef3I4mCzvXV+kBGxNZoxZu40bpXt/zsZEKo3EebhWZc=;
 b=nKZkbtYmeuSRIkBss0RHMXdJo1dMMUCS78Ue//BrCWLtKjj47OkSPxDtYIFEtSvm3whUETb3HIa2nRT5cUNpmjklDMDpXYHLJ1pRmOviXwn5yZtT/Rdow1FCJKlf0oR4iJdlhrlMn9Ck66ZU0v2VYf4FdXjxsTQvoACRSmNKygo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 08:30:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:30:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amd/pm: correct the baco reset sequence for CI ASICs
Date: Wed, 28 Oct 2020 16:30:28 +0800
Message-Id: <20201028083031.1195496-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201028083031.1195496-1-evan.quan@amd.com>
References: <20201028083031.1195496-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4 via Frontend Transport; Wed, 28 Oct 2020 08:30:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b99dd6e-1248-4298-f707-08d87b1bcaa3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB469975C8780E47AB2C2A1ACAE4170@DM6PR12MB4699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAks9TA2slaLDSzvfL223rdlhAMmUKBarOm6WzKwig8BbDyBLmG6akeVeX2La4Dia9xfr/t3ESMfDcxJF3HH47y8hqdI4tv+G/iqDMQQ6It+iKFJYZg+THrVDrFovYJQmbaCH/JwTXbnXNxv1evWoq34aEKztBbhEH7PRIG9Nquv3LBvYI7RRKvKvAt+O2pfGHjyfGWc8zO5pr0CGk09Mv3UzVhrV9rzK2Qz8gqqpdHwq4d/wQF0Dub2kQrQMC7dyUiaUHlFH0ql23ZZ2BI6WhkZu9bL5z90NJ5W10nIeFsDuBaK392nRMHVxrPjfFbiX9WOnFHo7WW/IYZEDAoOGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1076003)(86362001)(52116002)(7696005)(26005)(66946007)(316002)(36756003)(8936002)(6666004)(8676002)(6486002)(5660300002)(66556008)(6916009)(83380400001)(186003)(2906002)(478600001)(956004)(44832011)(66476007)(4326008)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JZspMdiI0Ciu6v7f4om5Lb52ekrbB1D3DDKlu4RxuMi4XE7xslLGYF4IBLSbFRgBQJFFasa1fQTFmq5EW9cERVPjCKIchHf90rAy9hx9hON36joObYd+vv0DS6fNSYa0GeJAzYKjBqs5/7lJ3Lfy5kdlSPmwOWaNGg2YCQH2oFu23Kp6MXZe8TBkx5ZaiN5xmD8VZy+Gu9NxLu5l8zfGuhzY7jzdJdnCd3760+3NqPRdAsjCYUGN/Uhh01sereVU3sZLhBiO583Yra3dsHoAZlGuzYLNhEM6fNIea6pTWvJCLkNpXiccT1lez9C5QqfUWUDPiJ3Zo2aqXZzXC7+gIbQEAAR1O8bUti19q1mt+dA+UJP7/RQ7FKxN+maaOEf3kTGA4cieFre9BIhbh1eR/9RChGTjks93abSTBn4ehs0Oe/O51Be9ssXSUZYChW8mGPo6Fx+GVAR1Gh1Mp1dv//n3bJ5eF+/bt6Vdm/hBPDAYPCzwyaSVaki5/y5pjMA/NnOATFDvd3GNage9ibWGrv90QvfAgFpn53RKZRbIpu1li4AC0OKXWUokZcFhdzJvfYdIBVHr/NQ89FXfOl+cpP+8DwSr6y0Yg3NIm4eLoejMuEBRJzoZZu4pH3pIS0Fp911UVBZ+eyUSTC/Y8F3Hsg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b99dd6e-1248-4298-f707-08d87b1bcaa3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 08:30:56.8511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWGfEWAKD7S2MhAWsMwxs1w+jvaRJShsWubxBCRhkv2zQKcxA04qdKJ/IKnEcp3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
Cc: Alexander.Deucher@amd.com, sandy.8925@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct some registers bitmasks and add mmBIOS_SCRATCH_7
reset.

Change-Id: I416d7bee7e7ddd7b726dd921d0bb442da6ff4b93
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
index 3be40114e63d..45f608838f6e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ci_baco.c
@@ -142,12 +142,12 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_BCLK_OFF_MASK,           BACO_CNTL__BACO_BCLK_OFF__SHIFT, 0, 0x00 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_POWER_OFF_MASK,          BACO_CNTL__BACO_POWER_OFF__SHIFT, 0, 0x00 },
 	{ CMD_DELAY_MS, 0, 0, 0, 20, 0 },
-	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x20 },
+	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_BF_MASK, 0, 0xffffffff, 0x200 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ISO_DIS_MASK, BACO_CNTL__BACO_ISO_DIS__SHIFT, 0, 0x01 },
-	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c },
+	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__PWRGOOD_MASK, 0, 5, 0x1c00 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_ANA_ISO_DIS_MASK, BACO_CNTL__BACO_ANA_ISO_DIS__SHIFT, 0, 0x01 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_RESET_EN_MASK, BACO_CNTL__BACO_RESET_EN__SHIFT, 0, 0x00 },
-	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x10 },
+	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__RCU_BIF_CONFIG_DONE_MASK, 0, 5, 0x100 },
 	{ CMD_READMODIFYWRITE, mmBACO_CNTL, BACO_CNTL__BACO_EN_MASK, BACO_CNTL__BACO_EN__SHIFT, 0, 0x00 },
 	{ CMD_WAITFOR, mmBACO_CNTL, BACO_CNTL__BACO_MODE_MASK, 0, 0xffffffff, 0x00 }
 };
@@ -155,6 +155,7 @@ static const struct baco_cmd_entry exit_baco_tbl[] =
 static const struct baco_cmd_entry clean_baco_tbl[] =
 {
 	{ CMD_WRITE, mmBIOS_SCRATCH_6, 0, 0, 0, 0 },
+	{ CMD_WRITE, mmBIOS_SCRATCH_7, 0, 0, 0, 0 },
 	{ CMD_WRITE, mmCP_PFP_UCODE_ADDR, 0, 0, 0, 0 }
 };
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
