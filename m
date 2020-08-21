Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD9C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864252075E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 04:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZkOXXmDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864252075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6D56E0CA;
	Fri, 21 Aug 2020 04:42:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115876E0CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 04:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjcUnAAPSocw640cayCpY9VFE8aDSI3Nsn+iSpuzoh5JyC9dlNjqRkkzBZbT92dea2vlLo6axpdOiv1nvS5F+h7FlH2rIOc9PQXl+09CTmaZrhRIc3GHkAbZpextii7I4otEE7tXBFzwx4ORjmDkBO93+eBL7ygPn89Z9zjx/fRiKiYMYfITOcOhWNOL9dM0FVqU3O8YTOcqcRUTmnNL7s/Sgr81b5y8oXWqOU1/mDBoRKxqwxnDGKdyHkvU8XeKzY6jDdgqsXpApaidopl7q3qlFpxKCwcwTRY64rN1HoNWQDb4/MEdK30pt5tr5mjEdTHxk0KKu594uYAAl+DU1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1M0ojO9xA54XPt+z2tCsILDQP+BKWJNWgcBIin9bu0=;
 b=g5iGhBNJrblEFBkyi3vR9FGHZ3tJGUFCXE0j44xOPgbKdvxPDKpbIL66b7qU6JQY3mND9QF087RZ5dPsgu85nwW7UCBlIMz44GM9aYGTf3ltjFL2fewoWkgT4mGmmtqMEJFvg2CiVfoZwGJ9fivnXRDwKZcgoMD9DGstdAbh0qCVlg2Yogy0oS3NsiR/ohl/C025NGYn5QkgWs8ttp+iDPlNQP4906Ohr990j2U23CMOZIT6NXh1yC75pfO2s4uupwr03QBOi4GsOhcYTCej9Wui30nREXLnJeK3+yooH6c1G9+nnxIi7TOdGcSuwhw9H3TYPI4LKTLVefjyiZtvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1M0ojO9xA54XPt+z2tCsILDQP+BKWJNWgcBIin9bu0=;
 b=ZkOXXmDNSugS8tIlXgCTlXdF9rIWNyEh7JYx4nmnOR8ZIaxSb8BvNi5CfgUobYhfsYB5fHQn0k3TnvdjkF1BEcnlXMr2T/s+GXqPL9sOxMaBUvAWBL+CleLPow8pAIS/wXKWoTi64Bgnp5QV0Uw55rvypMbb+FmDCxRKtIklzrQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 04:42:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Fri, 21 Aug 2020
 04:42:43 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/pm: correct Vega20 swctf limit setting
Date: Fri, 21 Aug 2020 12:42:12 +0800
Message-Id: <20200821044212.3039-3-evan.quan@amd.com>
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
 15.20.3326.0 via Frontend Transport; Fri, 21 Aug 2020 04:42:41 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 969d383c-04e5-4761-29a9-08d8458ca495
X-MS-TrafficTypeDiagnostic: DM6PR12MB4043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4043B7A7D5AC99EF22FA945FE45B0@DM6PR12MB4043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urh1pc5slLccRpmpj1fV+A3wy86lLWwr7N9USgA+W/8Ju/R7EFkFMBO7+Zd3m8O3dZN31ImwlmoYKc3yQcn5jO+rjW4o8DrIZpBCIgv/bbWJNuUisP961+PumLhZRrNlgGJtsOAkH4LIiw7eD4vTeU7/hS08LDwxXPMeq3Qnbl915WkZaMhTgx6S77PutqkgadGlC6LvtPe5QEXRx5PmfQgbXPOPjM6OjELjqklXb4szPFp3paCa6MnBdSBrXhV/fcs2pcfPDAs9ZaOD1cHEY2r18Ly+czucvdLd4OGIfXHov+WBIBBOkTrfTG65EnVx2JdNIYO4QPJy8AAZeELKtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(8936002)(1076003)(4326008)(2616005)(66476007)(6486002)(478600001)(66556008)(7696005)(52116002)(36756003)(44832011)(5660300002)(956004)(26005)(66946007)(16526019)(186003)(316002)(6916009)(2906002)(86362001)(83380400001)(6666004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6xfVZvj2hO3bpNHwepc81NYgoTqEk3tfgPZe94kB9BmUK/slHTNNvPGxqBCzbwlhcOwhBhEUwy0TgPND0eAmuRPi5YB7UmdTRYNuTZXDu038otTuw+vZnmSWauD+nbwPs2BY6b0v/frIEJL57lAZ7RVzM3b4awCkaJfBvLwjBffzjCewKU46OhGW3zJ8FNjoQH0++Ai0uuxmtNH6SBlm2MZNuOWIjBPyJh6cnwWlDoC+JmjuA3V0EtlqiBNrrqu/bIvsXgWlSP7z0DbpssTJX2ZFqiF3mNYGj0lA/Ci0/wDpeUL+QfPoiatkxCMTovO26+wTJEwWnzDWBfplIEA5DGhzCWMSY7yo6PBASkQ84TOf8ObZkc/eRpmpeh0GTgwk56ZveB7KDGZmrWdoJSg1cHoZey37NS/MwGEXFu9Myv1DPyXlMF7T6qQeAQrcNeMjpTf//DupDCLKEhSBEdMpxfOO2GqlWJnk9fOzAw4DgpeMZRCtXBxmgvfrsrbcrOrjW7NtlgeMq7Y2W2nZqPX6082VnunyaWaDeW+kmoJ3tqZmP87A2/l8K5lzszYa1XiSzdwanlZUdLMtnBxD11T/lG2bIPu0TZtFkg6mZXFbx4nGI/F+EwjchMe1Xn89if+aGdDSfn09ryRPV0y1rnJy7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969d383c-04e5-4761-29a9-08d8458ca495
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 04:42:43.7149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kTsnZh9gzA70EQu6MB1+hFazXSo87mrDRZScEx5HLZHGsHUE+wB2XihYNLDCjmc
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

Correct the Vega20 thermal swctf limit.

Change-Id: I6cec41152b5ac377177b1a9fda92d7b6cd982e9e
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
index 7add2f60f49c..a9bc9d16641a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
@@ -240,6 +240,8 @@ int vega20_thermal_get_temperature(struct pp_hwmgr *hwmgr)
 static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 		struct PP_TemperatureRange *range)
 {
+	struct phm_ppt_v3_information *pptable_information =
+		(struct phm_ppt_v3_information *)hwmgr->pptable;
 	struct amdgpu_device *adev = hwmgr->adev;
 	int low = VEGA20_THERMAL_MINIMUM_ALERT_TEMP *
 			PP_TEMPERATURE_UNITS_PER_CENTIGRADES;
@@ -249,8 +251,8 @@ static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
 
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
