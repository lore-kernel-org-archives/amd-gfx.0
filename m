Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F346AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C0C2075E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xUexOg9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C0C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828C26E096;
	Fri, 21 Aug 2020 04:42:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E1AB6E096
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 04:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVqET4aHfaaUA1g9+1Tjw6CTsEZfyCyDTlxejprsiTfsGBBzEZmwqgwgENdaPZujEXdv7Y2yV6LH0o7qb4V5mncS7iwfc4bltldXmrNs0vb5COu/8wIH4pVVk3SLjgAtrBPz2MZX7+dFbo7Mihx+0DpDUdJbdp9jMB+2BjltNC9gNlg+/6BtbcDzTXR1nu6OPP+E7wCrc1ni5xGkP5wHFJKfNZbt6r0mgyYj+x1QQvc7Tc6Ro5cX2DUSA1U9YNjQ/X+Rku4ct/fg9vR9sSrsGhnAjl7AJJhWN0vZFmJAjvzEHQJWxSS98cLcXNHUFlDmGOiu5ioQKdppprv8gckKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS7TD2FeoveTsT8jkFpVhMkZKPZYbk2PDzceb/Zmgqs=;
 b=Z57kiNo5B363gPSuIMrlaJoMpA07ZfzTHH/2spraNo9M8aMwENesSmRdjt2ZggK/+mv4QM5rYuKnzQ1UpySKdSBYHhlff9LHqOzoD+tg7/oMUvBM3u7TFVF1BBkH9ys0Pioqg+PN5wAmNQY3OYgBg39VZt/bLH7+c9wSgBAS33FomW+zAfpYkqt+lM1iovLuH2OOjaKqh16WMEW/kJqX+alN4g97obVyIpYPS7gNB2nXkVb6PvHfsU6vCUli1iduI1mFMSX9FLNWBr7229eUUDK6WVFU3KZ/lulviVjN4TKjXCCURHG6ICNmO31kaYeX4eYP3ADsJaKjdAY1MsJ7Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS7TD2FeoveTsT8jkFpVhMkZKPZYbk2PDzceb/Zmgqs=;
 b=xUexOg9GvxxT6GIei6XzLXXvOB6R9UV1/Ggvn1ViL+zTntIm7LvYuYEN4ukxcD4JzmzfQfqXr3eOiM4wlM83+QtlM4G3H0GQaq1wSb9FwmCU9/0lIrB5AV4jjtQOQ+mSkfWTJ2bW48Rg1GABSvf+eCE609pSMZbpMpYSCGMXaD0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 04:42:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Fri, 21 Aug 2020
 04:42:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amd/pm: correct Vega12 swctf limit setting
Date: Fri, 21 Aug 2020 12:42:11 +0800
Message-Id: <20200821044212.3039-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821044212.3039-1-evan.quan@amd.com>
References: <20200821044212.3039-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.0 via Frontend Transport; Fri, 21 Aug 2020 04:42:38 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9720967-9586-4900-0c43-08d8458ca28e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4043FD00103DBF143F783FDBE45B0@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xi3604lwmisorOspKB+YMf4dm6yV2pWdnIevfctWcKkaxkNnM2caYH8XThMnA09cYyYnW0Fixaki/1ECZheTMRvF3IwA+avMVCrh4R1lUiz6bmElyGl4pTukQucp4Y90oWqohcbeNNvcaxowypmwQfZ4TtNt7JLs5OLIlK54aEHRXZJBSs784Mk63i0wQZbteo/1wZY4BvCLKbpuM9SttZcZKYn2w9BO/7ZiWx2VG0YanFD71sE2UIqLV1R8qW1JYgpENPCgjbb3coYSFp042Fb3ZII+u3tF4Sbl9k2Og84GPft9HlUDw66e8Z1mMm5RZg/5lQpZFxWcjmzmivGxow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(8936002)(1076003)(4326008)(2616005)(66476007)(6486002)(478600001)(66556008)(7696005)(52116002)(36756003)(44832011)(5660300002)(956004)(26005)(66946007)(16526019)(186003)(316002)(6916009)(2906002)(86362001)(83380400001)(6666004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JPNulfccVZvfZe71b0jw9Ol1oFabmUO/abnKa9yqsbTWIk8OW47IidT05hr/D9lMB8BK52GHQoRXrtSG53ejo/BUPqLLv9nOWXS3mqnhXeQ6Jk/AgRg1nv/F+3NThiHcjEsO9xwQbn2LocTzNg2dhMwm23e8W0EMQmCG4SCcvEZqAu1ar2qixpQkgFjjxOU6SPeRKqmYVTN4DYrQTDp1YSAIrkbfF03eQec9cpCVxKFITQhn1sOYxxISnimD3FGU/i3Lb5t7NgGZ278M30KBBhODNz1sg95jE7coRjonWRcplaBWHARnPtKVvIZxt27qD6a75XfADB0/S9zw2fwoeUFPlIscujgI34kAhomZYLMpG/9hb7/PcxLYccsWldpQKrixX4Q+o4X1t6myQK5cNG3yC91IshrmBPaY84BDHj936Ag7GDEAv0scfKwyt1KmuOONF7KQ3yZBLeIdXIBTC8FQBbAiBxgl1LVWELgRHC5tY9mqsyw54f3MBB/ZyYR/JEygchpqNRbq2bOTDHWJDUEWjD348RMLUMqrPnCoixBDFfbiRi0Kcs329MXBBPSDrilBEYLONLJ7ebrnD4GlDZFqXC0lpjw8G5PlBHq7HCJNdfEw+dxX6T1Rbm4FMcjrZKwhAU0liy5qyC1wIuaBpA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9720967-9586-4900-0c43-08d8458ca28e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 04:42:40.2588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFLLGStUdRpseS2uymjxkfGxqhi1HD4tPoKmPDtgnLa+YitJPYA/PXGJVaTaDroC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

Correct the Vega12 thermal swctf limit.

Change-Id: I369e1adf9f177a8d9558282db9aa908b5a25bbb3
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
index c15b9756025d..e755fc0c9886 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
@@ -170,6 +170,8 @@ int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
 	int low = VEGA12_THERMAL_MINIMUM_ALERT_TEMP *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -179,8 +181,8 @@ static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 
 	if (low < range->min)
 		low = range->min;
-	if (high > range->max)
-		high = range->max;
+	if (high > pptable_information->us_software_shutdown_temp)
+		high = pptable_information->us_software_shutdown_temp;
 
 	if (low > high)
 		return -EINVAL;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
