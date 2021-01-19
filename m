Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BB8C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 06:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C96422E02
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 06:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C96422E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB376E825;
	Tue, 19 Jan 2021 06:21:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ABDA6E823
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 06:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx+r8oQVyYOddrAWrjGxbHDSxNDdeYWnaDYLxWoFkXE3OaSzjoWzLZrxQwnIn/efR1eRdFIUMFXiLW4izcnSKrcnqEZkBCnsHXpnqkGqeO+aTawDxWfhZ8sreFPwxL/5DRDJ8ruHXbE9v6IKssSw+BswqW/6FPuOFyToP1OWdpu73sf6oR6N027ewTEKPSBsLxhamedJE+9/7r87pgQlMic33ilOSEvX0qLrAmg2lU3twON57D5ay3O2OoQJ3dUWupV4N761jGZxHiiY2sW/M0zxizLy1PsJ1PVOhbpLMS7T2iYPTsroAllRvlLOO4G7cf57sT+CU+jkMGb7gH4JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAnu2NiymOhzAormDjy/vNq9GT3Ad07TjMULV8RxOj8=;
 b=MXYC1NDyepWamjpDYfzWR7QsctN1g+RJvWncay8p5ImWkZ2amo1WxHgzxYeLLlXRiH4rUvRPcZSxIOJAxboLdZJk42QVOnJ2rb4IOPiwEAiNEWcP8/T5jcTj0gbr1VZBt56qh+gl2dbXLOP7z+iobjGFQ1a3IAUaTRQuCvlq0+6o/0f2Xc+KCN/vDKFD2+LELGw8MbPVukhBCc8gcO98g86iVeNcCZZrnTJr/VsOJ9lbsnq0Tz1mWRwn0DOWw6TnBlAa5vJuXascAi1sZCBl51LGXb6+YcCigMZnrpZigOwUJ56Lcs5f6bVbuKwmiSuW4wvyrgeUcGgZ2isVhRd2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAnu2NiymOhzAormDjy/vNq9GT3Ad07TjMULV8RxOj8=;
 b=IoB6u8fBr2z68lxtPiMUYnp2tMWV7lyp1aQmuBh9zmsN8YvPz3B2OSyepUpcv5NCm2rtzjBWtxy47xIciRYMiCitB4dk8dPKFyhvekFsq29RkBQAzBv64Vvs3zGO0H3UjV+qHCy1eoNBrM/hEG57/fl01oHPzJL5Vi/srtxFiwI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Tue, 19 Jan 2021 06:21:11 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 06:21:11 +0000
From: Jinzhou Su <Jinzhou.Su@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: modify GCR_GENERAL_CNTL for Vangogh
Date: Tue, 19 Jan 2021 14:20:51 +0800
Message-Id: <20210119062051.28436-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0167.apcprd02.prod.outlook.com
 (2603:1096:201:1f::27) To DM6PR12MB2812.namprd12.prod.outlook.com
 (2603:10b6:5:44::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jinzhosu-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0167.apcprd02.prod.outlook.com (2603:1096:201:1f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 06:21:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b7bdf95-0a66-45a7-8a1e-08d8bc426a24
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4402B746FA0D31CE248B608990A30@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Mf2947t3n6OZEgSGzX8PX4S13x1qC4BkjrxXpVu0E7RaHW4x5cuBEWPIbvKeSmuHTm/dZmG/4+efQmRDBNWi3GwBp7FYL4oKFj2e57wUNfX+Za+1BWu0t7nRwxiGzZCEnuwAU2PAQn1KYffz4XadEARwO0Zo2V5ymRmKz5idAq3GWLoVl2Mux7EKGw82TZC7VEPhWlaizNecz4/H13+xB0x/Gp7/iiRZQdDnhjfTfAPXkf/S0kTnjCVJBIFcaFVKKH4kbZPbEeI6tdpQt4ooGdxN35n8ExVtSDBaJWHpaAEfI2/rGPo0nZAmkWh2seoX//GZSAw8obDVKfk6zznuIW3E/1GiFUXit+Ce9dmAvaE2VcvD/+mWMXVWCE4V6M6zGnaWchayX7qZJtdEmcVtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(6486002)(956004)(2906002)(52116002)(66946007)(66556008)(186003)(478600001)(16526019)(86362001)(36756003)(26005)(4326008)(2616005)(7696005)(6666004)(1076003)(8936002)(66476007)(83380400001)(316002)(6916009)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ILK7ffwPX15x1BCp2HG5R3uD6jXaGqPiYQgAu2VUSbaBB2E8F2UpojflNA0c?=
 =?us-ascii?Q?ezsDLLcUao+DjUrIWh7a7jMklAknLYIHF3SjsLIyhl547cpxaMiNn+rTCW76?=
 =?us-ascii?Q?g28ll2pMooFhMSHq0jixmeJdCOvxzv6yk+QyGH+wTzORZpHMdWKdCBUGyXta?=
 =?us-ascii?Q?aDEUL8K54tkWahPq6qQHKQUC23LOhnFtQ8saxltxYBoyHZnVPWwLY01gapYc?=
 =?us-ascii?Q?6HaynvWJufPqkZQQbd7kEqqsjPlFL1DM1fZWXqUPQdhPMX1PvIbWDyucmnYr?=
 =?us-ascii?Q?I5du2B0hhg2/lFTGSW3K8EAZXuNpLXsNz5Gksa8L1G/bIvO5Rxm1RbvFbKjU?=
 =?us-ascii?Q?aoviv0UyBUgDeJw8OCYE6Mbtdu+T6DPuOT7MgdXIbgoUy5Jxr5j95NZKsJZU?=
 =?us-ascii?Q?sYZkSBGIEpwe7LS8xA7yYAi1X+T4p5b5AAQm+xiR6luApOoiZBcwkzhT43Zz?=
 =?us-ascii?Q?LwNc7cecPhLeRXy0fDNZeW0HMJVeKeOrguKa4gCCxVSx2AmqNmHz0OkHE2Bj?=
 =?us-ascii?Q?kpBVayOh2WpYdIjwps/a6Tl+WgF3xM+IDhB9kq8EEN7gV1QymNHsH2Ym+4Y4?=
 =?us-ascii?Q?jdwWuzginACs9dkvfJzkEpcWA1Do4iMwU1hOroq/iGYDd6VZspWkdypdLaJT?=
 =?us-ascii?Q?SGfd7SlonM6KizjtPJn/1rIhUKqw6ZzYwyjIcgP/MEWFAsyiD2cq/oYZJeyF?=
 =?us-ascii?Q?5manWX3pmae/JEY1zILGrzqkkig1DkzG1Ve75Z50ZbxQeInI+F5tRprGDH+t?=
 =?us-ascii?Q?3IvUSRixosIiGrOudDG+6wkjf/lJOV7FQI9sF2IqRqsbY8joV6w68Emvrwqn?=
 =?us-ascii?Q?ECk+SIFiv8PTFD/TDfuHcldDlkHJnbj5oEbPxvXV4LQf+l7seo99bTYWiSaT?=
 =?us-ascii?Q?LVGNF/TsmxJfu5W3JRJedYEV4Ze37xDnGt707IWKuKz2NZuJW768fLhmn3KA?=
 =?us-ascii?Q?yX/L09G+1PY+zv6iNPebEuB6xor793Ow7AWphMB5cOdknppAPTVMn6nLdb/F?=
 =?us-ascii?Q?cA25?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7bdf95-0a66-45a7-8a1e-08d8bc426a24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 06:21:10.8940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T18UokyeW8qZwuj89vBq/28RUv84VQUxo5JL8ywAmQ5+eFzUx+nigNx22MDf81NtoK0TKikn9ZrIUxB9XVt+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GCR_GENERAL_CNTL is defined differently in gc_10_1_0_offset.h and
gc_10_3_0_offset.h. Update GCR_GENERAL_CNTL for Vangogh.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4d3b30a2dd45..1d604fcb9b77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -118,6 +118,8 @@
 #define mmVGT_ESGS_RING_SIZE_Vangogh_BASE_IDX    1
 #define mmSPI_CONFIG_CNTL_Vangogh                0x2440
 #define mmSPI_CONFIG_CNTL_Vangogh_BASE_IDX       1
+#define mmGCR_GENERAL_CNTL_Vangogh               0x1580
+#define mmGCR_GENERAL_CNTL_Vangogh_BASE_IDX      0
 
 #define mmCP_HYP_PFP_UCODE_ADDR			0x5814
 #define mmCP_HYP_PFP_UCODE_ADDR_BASE_IDX	1
@@ -3243,7 +3245,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_ADDR_CONFIG, 0x0c1807ff, 0x00000142),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL, 0x1ff1ffff, 0x00000500),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Vangogh, 0x1ff1ffff, 0x00000500),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL1_PIPE_STEER, 0x000000ff, 0x000000e4),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_0, 0x77777777, 0x32103210),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2_PIPE_STEER_1, 0x77777777, 0x32103210),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
