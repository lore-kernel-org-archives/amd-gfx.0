Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 21:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913A464F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 21:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913A464F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2905E6EB29;
	Wed, 24 Feb 2021 21:16:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA756EB28
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 21:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYBKZh2gu1wxOEZif07/8kRGcL52lBYQ6XTKDQLtV6hl4B6AU8RuoYRjuW2oMZLtKlCLmjhzvO96avXTldmPETfV0bpdpkIh4cSxdTBKgTBsLcyM0ICzfAiYybmPsuh9sYv1W+5Ja1KxaVypA3En8wqPRXPhUxp2PxI8hc8A6OXQ3hMhFO6G4/+gNMAKMsWU4w/Q0gZDHb3PoMtisXABauy+17jQnyKE1Fw3A8PvdQLkEGcAOIDGoMgKyJ+CgDN87M/uuKpVcWkaz+g3dL7CPVh8OuwYs5ap4wEEH+xjrsL5HMvB+wwIwNoq9Zrz79Jj2Ex6WQ0vwJgrWx5HZUPFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhe0B9QUdMeIqktFY3+50GrKYCJ41Ym71x9wbb8OCCg=;
 b=gjKoHPDekVUAObtuRgIAlmgOZQAkg8IPNfNt4UphqL5Ou5M1DbE28zrVmn7CaHvhCn1f1pn0rXIujkZYyKo9myYzievTcKcGyPGZwE388nMygU8SYZLKJfyuJCqrgjUifov21jKxVAU/cWeyiM2jEg5SVYv0PbdoTx81ndz1JXiEJLdRAzpekBgjieN96gElxjzynQIrq+Ll7YrVWOPpxLQa+qfF004kaSFYMwoImIFMEab6tbiklzvEIvqXVlP+RwrIcjHIiRkH5H5fVBGEgd65IhHtvE59SP8Mhl0tv9AXAfIzl9Pwy2a49P7v8ygdLpTyjZDUBgm7rkLz9HE06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhe0B9QUdMeIqktFY3+50GrKYCJ41Ym71x9wbb8OCCg=;
 b=MtX+PiDzmKM0ZKCjtvamLm2Ece2++onIH/olkjP36MP1EwHebk9NyXEaE0EyOWCGKij4OBeYVZqDGDOHE6HrOXPuKpZk7RrIHPcuAP4zEB9maG19Te7foDI9X1asXhiOtIPgISptJLmbHv209D6qKCbYjhFGcQ/N9IOENphscC0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 24 Feb
 2021 21:16:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 21:16:34 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for
 disable
Date: Wed, 24 Feb 2021 16:16:15 -0500
Message-Id: <20210224211615.2814913-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: MN2PR14CA0001.namprd14.prod.outlook.com
 (2603:10b6:208:23e::6) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 21:16:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04bac9a1-aa15-4c8c-252c-08d8d909769f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB408059D73A8D16E8BD707E8FF79F9@MN2PR12MB4080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQdLD1er9uMnC6r1AAjSkdsWlIRGwbbeGuZMQ0oDKs7hc3BB+i4ZgAyE4EQpK3wOkSnWUaNGbHz6PrKG43uB2fhG6u9RcJZtMWGSo9D52wme2H76AUBRO9GYjI6Y6m0xxikb0f26ydIctTaESfDnZYz6aTjgM1KnBPNBKsHqSM9I9f95CG56imDhtstQAgeUTPGTyLPTxiLDJ0nzykK3CTNgof/RTKk13YwbOqZid0CuSJbYGdaJXltWHRUT/d+YFN01S2kAE40BLZ98FikVnUKLER3O0UCmWeR95uDAiYA0c8sHufOuYanfedcJF/cvajrrGQLwkDJ6dYmzEGtFI8NqOdd7LlnExOLbFKirIYPFeOM9MBjLJDJXxW18fKScrlALuGsFcESwIobWX6jrhC58bJqPnXp+OFMzd0jpD7x6SYxOYozng7U5jD+TWGOBKYzUfnviZlMaw4UIyybR3FzJZwtJtYW3sV8u6pfsF9plEkpHR1DTZvFaDDTRRtfKgzOL1AllXp7TydU+uyrDz0fdlHURkIt1aqrWNc6oTlQ1CLeEwPRnyVFJKEKzafZvDuSrZkhHMM48zfeeEpukKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(6512007)(4326008)(6486002)(478600001)(186003)(5660300002)(6666004)(52116002)(83380400001)(66476007)(66946007)(66556008)(86362001)(6506007)(6916009)(36756003)(8936002)(316002)(8676002)(2616005)(956004)(69590400012)(26005)(1076003)(2906002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Thfpggx63leZFHF8ZAkZiHw5dbCsxSQnfTj1mLZHRxTAsZ6PLLXFenvqhY32?=
 =?us-ascii?Q?QBG2/epK0eDDmvAcGgMHh0a0IEh+IpFkZKJSorbpV+m3VmPwRzu/FvSHs5r1?=
 =?us-ascii?Q?RT/9YPLPFklO660p11+SzHYMmk8YaBhI5T9vbEf+2CuBz1+zrY8HyZfpHm0b?=
 =?us-ascii?Q?cRIiTeS5Nbgb1/0IhW0xO0+xjMb0aLpYke5zy3OirM90+1+I5pXuwa1Wyrg0?=
 =?us-ascii?Q?fQvnYkw3mqSBNO7fqzFqzUGdA9w+7gUu1cDrl1w84GyWhXW2MVmjvYzqDksK?=
 =?us-ascii?Q?EMzVlY3CM76oEg13W4BqhNAzwcMpfNH8LYvE7nmroNj9aXIYBXQ/qfKxFKjE?=
 =?us-ascii?Q?uUpNK8dzeqO9Q4PAKJ6+5g245UssWrAvfpjX3HsjOsAna7yxj++knyIwdLPp?=
 =?us-ascii?Q?IN/K2GQf/SXJWJWFUDRFKs1hetozRO87GdW8Jf6x2Kt55TK3VHR5eRBqv4wa?=
 =?us-ascii?Q?Zf9vrwdSlftoMcDeVsLOFdpeNOgDe5mEZFCbnr3NarekbI23d9vKHPFxpNs/?=
 =?us-ascii?Q?g3LlgFWjuZYmn0y4idfb89YckFFT6nwyzKvVAqZmQXBL94grxD6B4pO7a0n9?=
 =?us-ascii?Q?pMxfoEpDI4RRe7xLGxkKcKCLRSdiC6JiAVzO+Rw5RGA09B6+svBEFLh/BQML?=
 =?us-ascii?Q?V6fjtwocLUC+CVisZnbXlyQ9pKqKVNhKyCIRVbrxtO2Gits+nKIlj7elHXm3?=
 =?us-ascii?Q?J7Y0y48vdLkPQtL1tYLmKoneyHNJi1Mi4glvo9WdyEg9hLtRKc+87lqAz5X/?=
 =?us-ascii?Q?A8Onh5UpeFMYV8unJ//+xBtbitXkE/+adqbWRiR+drNBgBVDmZZvAuSeGDsA?=
 =?us-ascii?Q?snRIPZtnfm3XO79O8aCMEQynyeeQ0ywmeFLcI2QVqyLeSDj7cF92+4DsbOei?=
 =?us-ascii?Q?pJno/2nTdAtAxlN+XX8nwzolb+i3Q3FutD+AGDRgLGmGIVblM/vgg+NBCc5L?=
 =?us-ascii?Q?jJiQKmmims7pSzVShmPJgu86rDD4FnMLL7b1lsQ5GGf7psitoTiatxBt2KkG?=
 =?us-ascii?Q?kt25/VkegEfpnjizeHXsY+Oo9GOSP6/sSW6O+v/pTtrIXrTADBNlboYZW3Am?=
 =?us-ascii?Q?eT33g2S0sY7V4a9dEY7ZKj+ehCndi8CAX+WgzMI1RRdhTvxENmUc0kmoY1Bj?=
 =?us-ascii?Q?fjY88XlvApK+RI+98bBUE94tTOoGSP0CKIANhTlfgmzQBFnwlRngKakWyeb+?=
 =?us-ascii?Q?1GO2/TLbWupOgGztmjwQxhYGAwfqDllMcj5EiDWGh8u/5Wz0VDxoQBhUqfjd?=
 =?us-ascii?Q?3TiycisQ6dh+i4wMLhavE5OlCo/9d3FYxSjIrnshAHmMjxDsIzrigtv16J2H?=
 =?us-ascii?Q?sFm+nwZddf4x/a+LFzxpppxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bac9a1-aa15-4c8c-252c-08d8d909769f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 21:16:34.3418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faZToM02sJQzpiB4DGjJyPGEgD/UScKDIH/ZOQ486/AB8kYloBWYi++yJbB6qdD+JBaF09CQbeQrqChiM7s5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Per discussions with PMFW team, the driver only needs to
notify the PMFW when the RLC is disabled.  The RLC FW will notify
the PMFW directly when it's enabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index fd5539f8b53a..3f815430e67f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1647,9 +1647,9 @@ static int vangogh_system_features_control(struct smu_context *smu, bool en)
 	uint32_t feature_mask[2];
 	int ret = 0;
 
-	if (adev->pm.fw_version >= 0x43f1700)
+	if (adev->pm.fw_version >= 0x43f1700 && !en)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
-						      en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
+						      RLC_STATUS_OFF, NULL);
 
 	bitmap_zero(feature->enabled, feature->feature_num);
 	bitmap_zero(feature->supported, feature->feature_num);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
