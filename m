Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA4C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 07:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4696C206F0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wEHfwZKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4696C206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EC289DBD;
	Tue, 14 Jul 2020 07:27:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9849489DBD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 07:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+jhTM31NgRstGenvydD5BLCvNeeDUrqVWjggFarp6WtYTP186BTz31P0+fN9HDPn6pb+EPChcUoUni98lvsbseiWVZ3JHzEX4meHY0szm5jFobdPazFWAxRsbUO6BvjSX417FMdi7DovAQipd3FdrbsQnNLamJ2tzb/DFgu357+8h4vDyO20x8+cGzdclp0EkpPWUq8jbKQWfvGbC5i8+txz+BiOaMl2lFkCPukC4dJ2kpKTRrhZMkvr+61/3qOSEvbmwZ1XadKaRKYg7ydzn2gU/jmS4lVQC6ruMFzYcxQPK+6ev/miZHa4fcCUZxNahgfCSDgsQM1To93AqwpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC5I9/UdvzaSkNvwPr1AXoclCXQ6BCGt7mkwQ07+5+k=;
 b=Wwm7EN2Y4pEnMH8HTNiLO0aki6wVfSQMLSNcdE7kXJ2syaeYnaqzw4gdDnbSwc3/bu+oMSb5gh/F1ywmyfgCZsUWcnenoTXe4oAxSh+g16eHgMa9K+nywhLSPGnvvOeiVQgUpZorJZxF8ZVB/ER+UcPansc4K+lJSjkcYbNRYdQPV3gmXYyNgYVZ8So3MeqaxCUEPQubvSP1mGRZ/9B+ngrf7CUWntpzEFE/Murpkb0H7hzBac2h74DqjhFGZhwpGgM0hGYHMd5VGBrITrHVlzAyoce3DhsN0YnEy8wzdGEZLDmmpgDLQ6pkZ61V6FRjuyxIQk+UEhCVojmzMPXdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC5I9/UdvzaSkNvwPr1AXoclCXQ6BCGt7mkwQ07+5+k=;
 b=wEHfwZKIgMM7G9kMbZpKkIGMiAcNUdpihLDzV3dHFXl6JIFV+j6VI4+LGa2eNv7azRY231cLz1h6DWeu9NrNlJmkuTDqn4sYWRxTmrTO9Ci2xVPv1JnYjmS+omaAQTNmJ+EY6J/XyFc72Jx+ML9Fy79/0N64QwbneTUujdIQXaM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 07:27:32 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 07:27:32 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: revise the outputs layout of
 amdgpu_pm_info debugfs
Date: Tue, 14 Jul 2020 15:27:03 +0800
Message-Id: <20200714072703.4122-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:27:30 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b8ded74-ca20-4bdc-d8b8-08d827c75ef0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3468659E4D748345E1EDD662E4610@DM6PR12MB3468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: if1dE/LQO/uNFGe+MhxP1cYWpDu+Wq9tYqb86yeKARZEk1ambkueP2+PaIxqqb42JR3yRVoMhRzicuToxqMiJWg9yO7yuAfi196b2g9x5u3lcj2ZWiBoH/yXfMCzTkmKC9O/Lz1AfNxDjC5qfPj3fFqR8dW2xiq4koTCHb0SbqCpIx3A+V8RLuvSaN8Ovc/LKDL5R/f21I1z+XrgLBebv/beYHtN6rbVtkLhHlfXdveR9XlgDi5IltRRAvzvsiPEdXNF2BA2nXHZYBZHi8JPDVhGUh8VKuqpYYus/Te+jRQ5gw3Tyqb2enhWyYqIsCVD8/gUwXeFdW/eZ2E9Z4MxSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(7696005)(16526019)(52116002)(478600001)(186003)(26005)(86362001)(66556008)(5660300002)(1076003)(66946007)(66476007)(6666004)(8676002)(6916009)(316002)(6486002)(83380400001)(2906002)(36756003)(4326008)(8936002)(44832011)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JBD3g1xgKbKoTbl0lvkbiB0LcBNsKknMlYRHmQIx5PMhOF234seRigXfp/o2AZkUyVe4JYF3QMC9H8qQgUk6Cxd9pUmHp2Twv1otUdoiyhiowjnPTDAQykcAqlRvc436DINZgcj8kofF3Mb/6aREtd9nLw/ThO5a+80jVkSm3sCzyS9G/3iSSPLTDByRjqXCNnChzsZqARy7NTmR/86e4Jh6MigUOnn5xw8bQJw2H7yTln7RIGsxNBQT7280yiZO8Vrrmpfa52wG3e7gfsrJDgDvqmosiBhU+3vRNEmALIVLXAaK637DZS7MrY3/2EJxZbe25IRKuIjJTp36T12CRwgebUz3EbNB9PYZY1tpU27e6LEzEVBPdRNmQmDnejflaxGA49JPNoxpBI60cf9YMMaBgvSTF5Ld9euZiGfDaJfRIrFE99sNy0gQNi4nQa/DQz7Yq/44d7V/XC6xytxLmdLHYM5djyRxyxG8kDZODcY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ded74-ca20-4bdc-d8b8-08d827c75ef0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:27:31.9811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qomKxgrotiDMNXeOzVApBFmnROrSSzyBGsyxu2u3DD9ctTQJ/GFfCLEjridgGrbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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

The current outputs of amdgpu_pm_info debugfs come with clock gating
status and followed by current clock/power information. However the
clock gating status retrieving may pull GFX out of CG status. That
will make the succeeding clock/power information retrieving inaccurate.

To overcome this and be with minimum impact, the outputs are updated
to show current clock/power information first.

Change-Id: Iff762d47ef0cc9ed309e805b1709ec8cb293d21f
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 20f39aa04fb9..2d379c00c138 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3879,11 +3879,6 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 		return r;
 	}
 
-	amdgpu_device_ip_get_clockgating_state(adev, &flags);
-	seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
-	amdgpu_parse_cg_state(m, flags);
-	seq_printf(m, "\n");
-
 	if (!adev->pm.dpm_enabled) {
 		seq_printf(m, "dpm not enabled\n");
 		pm_runtime_mark_last_busy(dev->dev);
@@ -3903,7 +3898,15 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
 	} else {
 		r = amdgpu_debugfs_pm_info_pp(m, adev);
 	}
+	if (r)
+		goto out;
+
+	amdgpu_device_ip_get_clockgating_state(adev, &flags);
+	seq_printf(m, "Clock Gating Flags Mask: 0x%x\n", flags);
+	amdgpu_parse_cg_state(m, flags);
+	seq_printf(m, "\n");
 
+out:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
