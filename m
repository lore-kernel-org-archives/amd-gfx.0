Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32077C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AE564E2B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 08:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AE564E2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689CC6E44D;
	Mon,  1 Feb 2021 08:46:24 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700080.outbound.protection.outlook.com [40.107.70.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A5926E44D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 08:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcRp6UiwcJ9FGSNbWIJEUj3ldewwNWNvnV6QOfG5GcZvMzVgde+QKIiotEgaTm/JSsfE6Qbc8WkpR7w3c2NJHFdp383KihUThQU+HUgYW5nQ/RLNO/kGq2OerIWAzJrr65oxkMWR8EXrU0K/ijfAl7OT2YOnMKK7yCELs56Rn9ME72pkNEO7MKp3jekpDw554WihXnnTmB+3ekSyKIcwIVgkvPh9o1DyaqkLRgxrN6ZO8JEOO2IKt7btIxO3qJgCC+sok7w6btcSP2ahcRCPB113W/PqC0h9nRhYk2DeGRrnGqdyN/+Md8dzYZrJGBIso4bbV9T7xQsv8Yx73cT47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM/IED3Ti7blibkdmyOvJLaIe3JQ6FC+vPTO8Cxd+5g=;
 b=CDDRy+6Fu84i+JhHODhF2CNaLzaZzrvGOmushToS52ct3baRoirvf3FHRsHneyLvHXbyo1lyc7efMiKKwJECwcfDSS625TGOKnvijHuwpwF0MnL5Un5awssreEa595L6TTHN+QPxIR5YLKDFONFFB6uB6Ismv5AVJVY5Bd3txC46FVPTXBj8wjSGNyt5iMYmwnvkVvrD97vv1dhRySFuLK0dg17un+rph381H1ZL+6cf22WPgXWk/i1mS/SVuZas3482uClHRH4KXw9HZlyL6d61TQUwUR0a57GZEtZvqD7Un4pXsVA7onfmtMrg94hxaTeFhY0mqfs/ePUCGp4a2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM/IED3Ti7blibkdmyOvJLaIe3JQ6FC+vPTO8Cxd+5g=;
 b=qsewWzLHIN7XS9GIx9I7Gauc6uzc7dvMnuD/xibwRorp/KXgjbgcjqd3r4jhbm8u2IFeSCC07meEQ438MwpygIu1TOXhSEdFVFcQg3qzWtuwTwAQx2ZSk/QVDeX61tWPAr8xeqr2yw0btRzlvHHIKQmDMK7MvaoE3A5hfvoai5k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.20; Mon, 1 Feb
 2021 08:46:20 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::46e:9cf4:65c7:8913]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::46e:9cf4:65c7:8913%6]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 08:46:20 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: remove some useless code for vangogh
Date: Mon,  1 Feb 2021 16:45:58 +0800
Message-Id: <20210201084558.21708-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 08:46:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfbac9d8-a785-4caf-6d77-08d8c68dd877
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0148F6996D6346D2650C4186F1B69@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VcQMsLhMSOZ0aBsehf7rqhh0xwM67AQDPukYLQ3R/dzVl01oxrEune9JeEPREkyDs0lOLAwE9VStFuDWDXml6ZXZ9fjVe8dUxwc2cV0s0lRNenZYSzOneG+8XjODPtI41yai+K5spiu+nZ15nmafGMuhljGhbrBb+9/30G7givUk7ar+4qZQYh87L60uLoD16/AdbwFMiZOLPXfE3ShaykwCwK+0Z2il8tSVFYYHC4102MQqNYUuHrJ7DqG9yATSDK31Qyjo47oR9hwdYZsnJyyCiNODzNTnfE2W79juvn8a6skXOCcjeqzTBNuLCW43N7TNBU84qwfBb8M/B+/A4nkowa3NV/PLBd+fIlktWxCdA3cS2cZQuv8zwzta3XF3WU7C2md7x4uTSDAT75BcBIUmLWrKiQL9I8BDDLUq783R7zcugolGrgbB9UaPGeVIh9zfUBinxOW9SyHDb7oF8Xi9mwTiB2dwaztGRKgS7w6jaEcrobC66uCn3QSqPgFJDdeC8QPgBo7Ir3zBl31gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(5660300002)(83380400001)(4744005)(2616005)(478600001)(6486002)(4326008)(66476007)(66556008)(956004)(66946007)(6666004)(8936002)(316002)(36756003)(86362001)(186003)(52116002)(7696005)(6916009)(1076003)(2906002)(8676002)(16526019)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GrumSKK/yQPAfkJqzsx58mQkab0O290uCQ7bwH5ttU+WF9o1UFc7xPMkvqmt?=
 =?us-ascii?Q?VaWbHWTUa1pHttQM2/txqLVPANeHuAWZUn7S3EG/hvXOlkHIQwwyRht/2ii6?=
 =?us-ascii?Q?kn0gggE/kBg230tRcy1J36DhQX+2DayQ3jfCCRAju2TuPuywYHNkyVemqXwM?=
 =?us-ascii?Q?lXFb0slYvCjfo24Ja3O37jNhNOxgE7eg4x6X7eWa3ujIfrrIRJRKB1zqjBNJ?=
 =?us-ascii?Q?Q+pQ+d34D7UESP0mGLKQl61Lq2vBsJl8u6tBN/K4RHBl5POsL7bopIlSqKva?=
 =?us-ascii?Q?UshP+hL7GkIuXB2K011W3DSlRaGeoa5aEZAV0MFnD2npIir6NMRKMOd+WrFv?=
 =?us-ascii?Q?Qer4VxzSRgWeEdl2wWukLiVoX4dxHJS6ehVjxq0YoidmEU6Ucc0xmRQgkCzq?=
 =?us-ascii?Q?kLIeaWQsG70Ui1P3qrB2TckfosdDL88upWLOMXEXq80ZS/jYGchbgf0cH+JU?=
 =?us-ascii?Q?cyx/N9Zv+M6WdTrJ67Nzccx02BmkUaxFt6PcOB3Zphf9n+PymCEKiOb7vfiE?=
 =?us-ascii?Q?Wyxes/lcsAKRg8+SUemjQaQxpKTjrcxam/uKbi0rnJtsPYDBXjLLiPjkt2qW?=
 =?us-ascii?Q?WV+GwFaWD4qyD+O+JmabRmbvM1gEZxnvV1pQtarPi5m5J40GsKMCSlLiHMN8?=
 =?us-ascii?Q?2A1wDN18Cx+PN/vd3amEilQPbY9LavzSiAT4SMBuFLcRmeC5wBlFTQRXEWq8?=
 =?us-ascii?Q?sTsHzvrKF4+4AydevB8cPZqIVB5sAkgomAXTPC5zqLOMp/tzEEoRYeHp+YvW?=
 =?us-ascii?Q?mVdTJHTkLtC6qIuHH1bDABBi3CwKPKY5QSjNdddGu1qbjnj4XZLDcik/+tsq?=
 =?us-ascii?Q?6mlVfHXK2gALQ2AQNmgTHl9Ov6NcRXZpvL+QCwla3szurjhKoh7/g6uEjamY?=
 =?us-ascii?Q?nS2LpbBr3ZGN1YwAUf6kXyW22RE2FP+GswQCQCJFepimhVyHsm0JnqmZ5eUY?=
 =?us-ascii?Q?+qt12l2Rg9bnNV29QJtlnNojZooh5aDqWeHcIIGfapk4YRBa/aSDAC3YNt4A?=
 =?us-ascii?Q?82UoEp5NxwFsxSVCwnuxjP+NwmWm4LBWYn8lP/jre06uDBJPyozDKompPh87?=
 =?us-ascii?Q?o5XvQp6mXLfOjc8iMy+yPuWh+9QxfA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbac9d8-a785-4caf-6d77-08d8c68dd877
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 08:46:20.2716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdr/LdWP99L11cZtFzbSq7qfSDR2nJyNcsfqGV0HoC6/o2A2SdKqkbmczc1CLEE//MzkTTVDuoGeQkY+1hkIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
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
Cc: kevin1.wang@amd.com, ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>,
 evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to remove some useless code for vangogh.
In the earlier code, vangogh can't finish all the sequence of
smu late init. But now vangogh has one stable work state,so
remove the useless code.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f958b02f9317..30e2a0ac3279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,9 +612,6 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	if (adev->asic_type == CHIP_VANGOGH)
-		return 0;
-
 	ret = smu_set_default_od_settings(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to setup default OD settings!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
