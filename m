Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14886C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 09:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982FC64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 09:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982FC64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F926EA68;
	Wed, 24 Feb 2021 09:11:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DE36EA68
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 09:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOWNejBTo9s/cIlBWADHGp9Hbu/8BVygG8K+4S9PyQ0dtaqAmfoa+Id0yb3GNc9CHdjPQNwc3+U5/uKegIMGaoa4dbTyG3IEmUTtHhvOXWPrsXTMHJlLtL0h6CS9Rt70d0XgnPbw/C5sFXQa4qphBPO1ZjeYjYc3+GxnEUIyiP0thJ07guQYutAEFjd7Y2gZs/5yyJG7H4XeNDzbZSPYgc5bIBKfb4lYZX5Ui6j+pnd5lEtlhRA8i7s0vark3iCmnKTRPNOE32LyWwH5d0bm3Wp7An5m6A7FLkfpi1MgekJhJc1KhKVouu1kkn80OlgkdtwNP4wsN98a0HAeoqGrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTnW5EGfXNBL7/xFCYr3nOQAfGOQQIXAXp3yGgqLmwY=;
 b=aNQGUHzYpfhiGJ9kg9EjBojxw42symGCo4tY7XUTIVaGhw2A1oZLYg5UPLl1fNb7u26no7jhWu1tbT4vdPP/qtv3EtA5kZo0hC5JrHvr1lekFPsbOjVK1Ou5Xx994F7pdWp+8w0bDc+OJwlKAbUgQN3jtyFCznv/y4FK8k0enPNDKO550cdXEZkvBXmEjB5JiPmOraHGRGuWCrb88KHYxNBMvPe+f/gq9s0dTRos5Zz/h5nUff1STbqwokMralwnfFiViRJHgZps93i7gDMkzhEPBPSBlVHceqp6NigFXgISyUKfFiSnOElHF9qpTgF+Thys9ukjdbIERxDpc6lLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTnW5EGfXNBL7/xFCYr3nOQAfGOQQIXAXp3yGgqLmwY=;
 b=Z5BFImDqTSnKMwCzlkejwFYnOTlsck/ujYt+CBda3LeemftzZzxXGYmLlMXnnUQfo9WC0o8Tp3I8WPaet2ald/WRPMwKXmuMaEuqvyKk6pwq62XiDA0+EwtjHaA7QEvyFIgVP8/wBsGhQWQnGmYk16dSBNB1qT+8/Zf5aErGztY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29)
 by MWHPR12MB1869.namprd12.prod.outlook.com (2603:10b6:300:111::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 09:11:25 +0000
Received: from MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::8d82:5144:c5fa:ad51]) by MW2PR12MB4684.namprd12.prod.outlook.com
 ([fe80::8d82:5144:c5fa:ad51%3]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 09:11:25 +0000
From: changfeng.zhu@amd.com
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com,
	John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: decline max_me for mec2_fw remove in
 renoir/arcturus
Date: Wed, 24 Feb 2021 17:10:55 +0800
Message-Id: <20210224091055.3410-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To MW2PR12MB4684.namprd12.prod.outlook.com
 (2603:10b6:302:13::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Wed, 24 Feb 2021 09:11:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f6b3144-1332-4d2a-7367-08d8d8a4290a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB186996004F55D2A04AC65384FD9F9@MWHPR12MB1869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RdRcNwRB3oBeydg8yXR3Y1WfjcQIZ/QbrVg402sg3UfiDeFuKS6/2xfL2647Z0Sj9B6TmXZydBBoQZUZTOmH9/Hy19lxV5T/onhilkqXKlumkd3oS/1Jn9upIb2ybGzy26Xx88ehEJXvnSdn0SEh0hC6k11pYM4U8lPnrdkDnpCJ3gwOQA7/quTAU3DmECx52dPw9ap4BpduCtIQWo6wxBOpIohVxVGP1PIgO2w8yykmSKbatFPnf3EJGgCaJ2tTe2NAIRRszdUoH//g7UsE5Q0s8+MOhH2LJi/zqvIDHvOyOPYZgxtmOy3iK5wYxuRztsZ5JVuST71fubGecUvLAgOkQVik+AldR7+rnMfoT7h39amD67Qh8ZV3wAH6XzwgF9QaKOT6PVzs0sINfBkCX2fU+22IO6ieQEZiJpQiIwhr5rj4ERVY8aYiOno5ILEaLBrlYAlES1vIBv52sAVnztEXmmOdG2nW7RR6vyoUjlW7xH/lVxPVfWRxfcySVqxsLMyNx4BASzkhoSM8RXZtAI2WiMZhVVn+Cnz87P9WAvZ76moxZ3XmEFSGVjlk6rVfYSRhQZZowmUryn7ZI03zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(36756003)(4326008)(16526019)(186003)(8936002)(26005)(5660300002)(83380400001)(1076003)(66476007)(9686003)(6486002)(66946007)(316002)(66556008)(2906002)(8676002)(6666004)(7696005)(478600001)(52116002)(86362001)(956004)(2616005)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9PYUQR725XP+WQ6cJ91Lfs3+l9stKrfa0fqV93UawX7618us6LKDHhsZyU7g?=
 =?us-ascii?Q?uczADK9PXY/+/mpQ082butsFbSMuoL7e8m27nJwRlK5n7LuLyMRhoWtvx4Tw?=
 =?us-ascii?Q?RnjUSDsDVMJjzO0G/Vd3VxlQHJ8A5rmqkaMh5kmaviKOJC/tjPJLAX0nwJfq?=
 =?us-ascii?Q?rii9JxAb5QgzXIFE4VmFOBH158tv8OF5GojPlLutgd4rbvJldYI2ITuvc/bc?=
 =?us-ascii?Q?grcZPtjYEkos8VDR2+m9t6DDj4a3RsV0DjF+MqhVIjQXtu0ZqCiVHoliyPXW?=
 =?us-ascii?Q?AcHvDfEOR+LTizm7JSzLMEyI9ZgIA2dpEXHEr0QHLbQvcBnRLi1l8qj+m4uc?=
 =?us-ascii?Q?V9grTr7Kv7gk95290Xdu9TAnczaLO8ZZrYcWfieZocZQjIfUKyAhc2EG6ukD?=
 =?us-ascii?Q?PvkDgtNFlDCMfoNkeg6G8OUTjGEvODlsmnHoXn3YC/iubX3+HkvNVvfmpXsY?=
 =?us-ascii?Q?o9kTtvYQ12Hpyt3G9dEaRvLi897axr+gIcU2MTXIPJS+/NRydlnG6C1LbRyV?=
 =?us-ascii?Q?iJUCt8ugHkAuMtmGpubumfZDeBSuLByWICC6iVbzWFXmnJR/0vyBJ9c2ai2d?=
 =?us-ascii?Q?wTy6oG5+G05t8SrGum7b66RybiQUUUOb6Lvh4iksYJkRqfPYs1V9NsOFWekf?=
 =?us-ascii?Q?3SPlnX/XEkhM8qlA+CLChLgGnWvYNUSidGp5iym8CaEfbYmRUPt3eqJgkQNm?=
 =?us-ascii?Q?+uJD4arbihiorRV+GXOtaVPozaJu+1xNkB5OvumgLvIKhYl0hp5pbCd2eaqi?=
 =?us-ascii?Q?IALqY0IXU6+Ovnu//E5tKHCsk+tYb2BGD1urCQBBUjmsLrQJoytyTUSRmhX1?=
 =?us-ascii?Q?+x+YrI0a8l7+Yro6F/JytgHuPzEVdSciSoKRAPGSQgtHtZP54V9WgZ3RWu2t?=
 =?us-ascii?Q?+raupQ8x9K/INAW+QHtIGxajBhWLsFqe6NHyE7Xps/gjKTgHKI8KW+nYI65A?=
 =?us-ascii?Q?StAP1lPcGgDRNicTHlPaYL8Um2PBjGEmQ4ek4y6vmFveEZMHfHGuV1cb+Nsg?=
 =?us-ascii?Q?uNGfM1iqsyTapE3V4ietvxzy4XRUe6Vx/45Nwfhdo9i9sds4YMI+5SMIjhnr?=
 =?us-ascii?Q?Ba0LbaEEjSfLeS4mVwbEdd0MSAuYb495Z8JOe3aG5+qIOvgScAnEgxEOpUko?=
 =?us-ascii?Q?bdVyQZ6yYYqEglC4JzBGJQmOakuqiPHJ/5WdnjioCztUYah1suWT7nRnkhW9?=
 =?us-ascii?Q?q7YoTVFIojNADHw2DbwPxf2AKiVoBagXWmtsNKkPxtIUlsslHIxWF2D8Ie5S?=
 =?us-ascii?Q?WBOnkMmrOC9WRIDI2uJwf3Lqzmx8a9iGyj9yX2fs7y7pVBy2DRsDSbQnSt9P?=
 =?us-ascii?Q?lt5H39a/herezzdTdBCrIqDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b3144-1332-4d2a-7367-08d8d8a4290a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 09:11:25.1889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC/BTGEMxIYuGww8X2vd5erOIHnJ7DriBB1QZyLlUip9qe/di6ZBu1+okqJRgwfS+WimLrAPh8MiQl20cvi7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1869
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

The value of max_me in amdgpu_gfx_rlc_setup_cp_table should reduce to 4
when mec2_fw is removed on asic renoir/arcturus. Or it will cause kernel
NULL pointer when modprobe driver.

Change-Id: I268610e85f6acd9200478d0ab1518349ff81469b
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2f56adebbb31..300a07227597 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1890,7 +1890,10 @@ static void gfx_v9_0_enable_lbpw(struct amdgpu_device *adev, bool enable)
 
 static int gfx_v9_0_cp_jump_table_num(struct amdgpu_device *adev)
 {
-	return 5;
+	if (gfx_v9_0_load_mec2_fw_bin_support(adev))
+		return 5;
+	else
+		return 4;
 }
 
 static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
