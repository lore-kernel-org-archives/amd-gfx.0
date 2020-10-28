Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460D4C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D832463B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jSZZ7tUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D832463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36EE76E4B0;
	Wed, 28 Oct 2020 08:31:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700043.outbound.protection.outlook.com [40.107.70.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46CA26E4AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSpga0GlhEsRr/OOh35nTjmXjvIi58srU2SMKkR5wRYwQCq8zYzZK1POlW4uc8fwhpTQ9JM0g3JrhB/N96xAnoYHzTrjisiAkqxPwJiILwaNQTnsI9RqqgGHuQ9WNYgsuThRnRjy509P+oqRRjvtIQWInPlzpiepiKaUqx322puqQQl0ioZYRlf7sNkFL3MuW22o5jA6yN+7FwO8/KSZzjXQSycujd8tatXx6nfozEyAecyJUxQaWAHFO/JiO+W6hb786eyWdyacW6YfhFOAmJAbPmFExwKh0QXEUW1kAO5diROeNkYznF+nbK23g3I/keQ9/gU5pmdBjTdSKRJh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVwTMty/4feyfYyGdyuKI0tdOvpYXDo4NGs0gWNIzvY=;
 b=X6GO+rMOcpCkMdg2CytQGnu0lCzkvvtodP0lkeL2wvQ+Tjf5eKJyrMz4KS90KT/f3M3Jvmmui/t+DV63tCV7kwyaFKRmafKLX464FeSiJ1klcowk/mygmJ+h6598yBwu+dkRxq4VUpEk7L06wdpPGoVbxSmdpNQcaKMIVEuZS6WpeezAsz4tMFxePLooppOhDT1uyY9gL4skGJto+ML6L4af3s6zMn4uJ0iwyg5dXPedvjJOEpI9LViUIMVtVqCxXDXgUutGnJ12jRrQsDNxG7DDxhfyvaQgTCG34s40zVYHMhIwoQdu2E08DZ1qUc8cT6yIKDiRrf2KOBXDXbQr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVwTMty/4feyfYyGdyuKI0tdOvpYXDo4NGs0gWNIzvY=;
 b=jSZZ7tUueszUULBwmB++7h500W5dlRiuuqBiEvkxsuIhyaV1zegV8P+Tf9/xYBxnh/pKMxuqNZMLhyPGLpAtXtsPClow17C2yS870qOd8+lFxdISkqvZmftJNSHfCgUacgjQg8ViSLJebFPQEDrKxO8UUvLtzRoez0a4g+rkkaY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 08:31:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:31:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amd/pm: do not use ixFEATURE_STATUS for checking smc
 running
Date: Wed, 28 Oct 2020 16:30:31 +0800
Message-Id: <20201028083031.1195496-5-evan.quan@amd.com>
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
 15.20.3499.4 via Frontend Transport; Wed, 28 Oct 2020 08:31:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 636f8bf7-0218-493c-a3b8-08d87b1bcfd7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46993EC456E3E26AAD31144FE4170@DM6PR12MB4699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:328;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJA2MfjJax9Pj0QZJobFIw/ROBrGUnwG2yQvVtYde6/TAH5+tRBRnhOtmo7SKNObkTSoC0hIS6hbkzaN6vD7G3FjCnmw2uJx13calnDzbqxhioWZJMKbSmqKFYsQ8cyPNxRZLjP5iPjISpn7jWDGZmRkklu287vnvBIZOYeDrwVPf9M/lv24HCOS+KWt9zNbiUhDOF9bN9tJ2Isg5y2gaEkBEE1ezEPQQntXkk3C41ynQx9yF3lkgFmVYqVti3IUDwgbt5jatmuzpWIF5U/ECaXU6Za2l3DepYgWjsQO0K+pacCUJvswS97ScgSAntC9XfZvl+NX9PGpnEsYJHyOCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1076003)(86362001)(52116002)(7696005)(26005)(66946007)(316002)(36756003)(8936002)(6666004)(8676002)(6486002)(5660300002)(66556008)(6916009)(83380400001)(186003)(2906002)(478600001)(956004)(44832011)(66476007)(4326008)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eG2mqh6wbGFsepFYBls4SB8yG+P7okImhOgUNEk+574Z5oiL4vGPFI11X4GY0icTl2CicnTpAYTXcSDe2RzbEfTiUyD/zMenesh8XIEdQBr/XuMOBh/nKaw9dTY3myQr66g3PyRfwMJQRENWbNgTddDl/UagzN96FUZEdgKdI2CLUJqHjQwMuzhC5IF58YoAteqWwEPZQ4PveucssUw/efKZdBtrFqKP8TkxHWxjCw8tW5feGU2H/S+JJ/AuCa8vby+wrsP9AByPkLxhhK653qCZ7t+eCk8XD9UVVSz58zt0QS4LK6u0wddcazgN1p1Qx8eX4vs8a173ia5glKLNjqDo5NzvFWygxoiDoQwQXeaB2zhyweD4IkisxE0coPyk14taj0uLsMsnizVaz5YgoNr+4iPQfwH9hj5FDevp0erztS3dEwIneagnN0dC0mGAwhTMa7tauZdeCdd/CmQNi65RHgviVxMKu7x1FR6znUvt5c/rJJ4GwyH0CJIfZJuw/piPwzB3SOudgvvtooo4L0hzitaoPcYs4Saj8zVwENLLTxyJRo8IeqcjvvWVay4mvFq+84wQl1t0TZA1ax0q2786A5lmwJ6Z9PXwqJPPuGw38MQpmfW/kNyv/m/+p7s/iamLB3lf9lFK12eylbxfNg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636f8bf7-0218-493c-a3b8-08d87b1bcfd7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 08:31:05.7332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAIjFtE+oJl08wYKxp2bdOxh8hBqdvaLjDE3VvpiZHh8iM/D2S4PLam+dUK0FE9z
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

This reverts commit f87812284172a9809820d10143b573d833cd3f75 "drm/amdgpu:
Fix bug where DPM is not enabled after hibernate and resume".
It was intended to fix Hawaii S4(hibernation) issue but break S3. As
ixFEATURE_STATUS is filled with garbage data on resume which can be
only cleared by reloading smc firmware(but that will involve many
changes). So, we will revert this S4 fix and seek a new way.

Change-Id: If9eed2f5a9c1168fb20be92057b583d854ad779e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 09128122b493..329bf4d44bbc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2726,10 +2726,7 @@ static int ci_initialize_mc_reg_table(struct pp_hwmgr *hwmgr)
 
 static bool ci_is_dpm_running(struct pp_hwmgr *hwmgr)
 {
-	return (1 == PHM_READ_INDIRECT_FIELD(hwmgr->device,
-					     CGS_IND_REG__SMC, FEATURE_STATUS,
-					     VOLTAGE_CONTROLLER_ON))
-		? true : false;
+	return ci_is_smc_ram_running(hwmgr);
 }
 
 static int ci_smu_init(struct pp_hwmgr *hwmgr)
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
