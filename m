Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239E1C43457
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F02206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KHfqp13m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F02206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441906EA89;
	Fri, 16 Oct 2020 03:28:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441A16EA86
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZGsxxOwoqItCnvIeAUaxrLDWPF+3f/ByrgjsaN9jVSx+ZrXcYlOFkH0g2okY9QpgFvaldfrPe25733eOtlVWJhhf9WZCOByxL4QRMpW52fz0G+m1aik6mGPLBo4HkWdm35IXHuQwRz7JBxq7Icnnkrs17fOohfgaqSpv2KnE5Oly3y66fAN7P0nx92Gsn5qe9nTg0GXTxs8m1ghTO8oi3MT2g+4iZ1gnvCbwZuVGGx6LYWtuTiRuld40ru+wIMTv/uiJ33IvMKDBWp8dBCQZX2QJ0E0ow0vL6kx1a2Pe+GLcYmkPhgEnba30kUxZJOtCyIgBopnpcz5rufXFkDQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGodYI06cOB6Snv6wrQ4O4ge2kVDoJH2YYA0IOr5grA=;
 b=i/11uOd7pHo+VyhDT1wJOWQKi+C1XlMypsESxikWzu9cJW0RL5XZmB1QqiLemc6bbBY031BVAPSnlXbX4BSrcXlAW6OH/bPKYb/F8xI5QVOPhu3AaWXmPO/5PnAgZNeoe4KcsX4aPL/p6dSl/AwuMSl3qW9eI6/HV+YbLe265lCzj5Wdi1KqcW8w3S1UyuNwYUdto6FtUYEK28Bh3wK+mWqaoGpviw7XvlZrGYrjcP5Q/kzjd+wON0zd9MGATvm4Vi5a0TkJipRgX5eKSNkDDwlPMqukwTH8kn0bMZDcBw+9SdDpUkBy0xw2zoCSn8Q6fIw2vyy0E9x+vsFsIlXjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGodYI06cOB6Snv6wrQ4O4ge2kVDoJH2YYA0IOr5grA=;
 b=KHfqp13mG8MxxyqvcHmubuAiGyLwAL2zDQZestfctKJRmPNaO5mXfCpsP3MhemjEslWXFXUqepa+JbPrdKsjsZFf6/UOsuKa4vbmGT7h7jRc2UaKreA7iZuGMYPj4u50S85eJYA+idIUjjwWA1D323i5840A6elza02VpXSxV2w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:23 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:23 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/40] drm/amd/pm: correct smc voltage controller setup
Date: Fri, 16 Oct 2020 11:26:41 +0800
Message-Id: <20201016032652.507-30-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48f863fb-ac5b-4230-c751-08d871838986
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13549F61CFBDA7211F1280D9E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvxP78JZrIC5Z+HA//EwD6cYdx+3ArKstXrzCSefRnBZyh6VX5FEHbiOE7JubR/6SZmNhM0ppLM7FDgWhbudjnmwjjLsS9paCb9f+Qlo7Zm5WnxZBgWiNZL9phO/1NKXWH8Rsa4xv28ug/sR4RCMx0cmsx6IUwQKdzjxhmHGPUqW9ILJD+X08Cqa90CIb3JLq2/pf7cEmlXM+VBm5VakwJmpgTtVLDobQZokOYQ45zwB5WIyQKk4M2pRPoYxzLLkUJMuR2quGG6dIDEHpJ2iKMVg+Md4OJbDHo7TVEijeRzhG3Zpq61mJ2QoL8EgkU3rLDLNEdtL0Mcs/iij9d/dkq7KxkFQxaBsqQ2y6nqwixKEXknlr+7hgJlHbscYZqNe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ki5RUiAQIlvGK4g3dWC9DG2P2OCHTg81JMYRvFRZFEQ8UH56WfCBKKpKD4KzxFFsuM5N4T2IEaU5RaBrEJdZ36VKNbx7xH//KvRmEyF/PCo792UTITQVEPvQgDbH4hbeFcm0rxU2NclVH4ZyeN7IDpBJ79Aad4wZ13FRUB9v7BHHAkbNwZBKNY51o54pCtODWwKrSJVEfvGW4TvFuN39mSbpSILYznF8+zUy4ZLthSFcu/K3/fmZ6P7ZUM8XXzpH3DLotZ1qBNgZPqarKR0maLT9DNX6/+r1Wc+DlxqbAP/Cy+4zt5KVzMEr/Y62qnEP7S/IDte3FHeAT3QwyuBlWiuGUzB+uzzlwllgvATw9IMIzV7xhj15yb9CI+nuSYv6aOx+HKyyx95ouMpHKEiYc1vYCTJ2KIVXw8ks+rExGUD7NB3q6kpMJUU3tSIDFrl5ruiSyWazDyExWFnMxQSt5lAr/J+qRHuyjMiCa2m3OA1R1g4hH6rxQNgHv17RvV3/ufsakRA8abqI9bpavf7WLpAkUPhz0KVtp54cI0UGOEMlcVF+bZRSUbucd241Aw2MBGHwWsvfbZQps5MFyZvHJHm6jGBJsoX1pbJ8EqcbCjrinuhMrKsnN5/Kmoz8sTYgLnqL7EgBW1i/cDD3syoMsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f863fb-ac5b-4230-c751-08d871838986
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:23.8179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSP78e0egoNSTluWLbIK9siaP9tqb5A+4EVfJqalf6qvPmqpveBVgcYRSeuLicyU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 smc voltage controller setup.

Change-Id: I819b0b9648074f1af5af6ea285972ec3b3f693d8
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 122b15dc76e1..7ec83a826816 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -237,7 +237,8 @@ static int smu7_get_current_pcie_lane_number(struct pp_hwmgr *hwmgr)
 */
 static int smu7_enable_smc_voltage_controller(struct pp_hwmgr *hwmgr)
 {
-	if (hwmgr->chip_id == CHIP_VEGAM) {
+	if (hwmgr->chip_id >= CHIP_POLARIS10 &&
+	    hwmgr->chip_id <= CHIP_VEGAM) {
 		PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device,
 				CGS_IND_REG__SMC, PWR_SVI2_PLANE1_LOAD, PSI1, 0);
 		PHM_WRITE_VFPF_INDIRECT_FIELD(hwmgr->device,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
