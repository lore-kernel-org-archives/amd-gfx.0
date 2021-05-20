Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F88AC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F90E610A8
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 14:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F90E610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A200C6EB65;
	Thu, 20 May 2021 14:30:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F276E40C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 14:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRrlXGiprVrqWFJGqhuhfUiHLrT4zoT+KpTfI4LFCyt1BgIjMk+ns/hO99IvhgjZ/1hUotqAUsXyJZgmukCJPeORGq+1csQMzqe3q41V49UFPQ3xG8NJLQhjkMSCuo1c4HyNC+9kICib5vdX/KHFp6VWV2hR2in+Bj/k8FkztpBxRov17y9iggsFcdfapYtLP6ETyBo/yecC2gOKYnuS1wiAyFTXdF4zg7S/A28OTbOX4k/YkB1Pqvy5ZhkaoPFQXX3gcn8GmUp+UjJApDTU/p/fceKRtxzbQeTRNK+3J5zXVIQ7XoVj44ncmlzdf53X3GNPwXg91270Anvhrf6oYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcTtA0JZvr+wZqC4LafGOzQ8alAIELm7Dlpp/w+09mI=;
 b=A3swXw85nKLwXVpii5yo3ot38NOHksLvMillXxGXX7+4eS2cuqSKf4Z6PjsS7K9omM2aJ82Vieh9e/bql4RFP+igMuxQPVyoS5Mbb9PfM7m21apwB9J0r5Y4XAL4nWzHrlNDOBvyu8CDMFndKrNAIMyrJNmAxuCDCq4nfq0luw0CVnKnGNjFNhkgOmJKwIc95ucAskZx7Io+kngRCW1Z+w1fln4/Vbjk8JAXzzLFwOFIAvZlw6sTtZ3+i6prGRvhB8qziqdIF+MabipU7bQcwzUlutKFGX4c2FcWgFAFfwQf+siOnkWp/fNDAU4lMHCdG7+anp/pjFSw5JXJCs1yZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcTtA0JZvr+wZqC4LafGOzQ8alAIELm7Dlpp/w+09mI=;
 b=C2toJAMY8CxQ2nQirE5dYXbIWfhcjg71y7I7kVxct2gK0uXbJDXLo3Vah9qVGTVj0Ws34rZmwa+N3F0T+2tht9bjlukNo8qriEUXZy3XzfCYIWXxS5cW+MW3ra1XbN3ONcb2J0YKv2WkJz/peJm/ghONFGH2x+vFwFMoT/SOKdo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 14:30:20 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Thu, 20 May 2021
 14:30:20 +0000
From: Graham Sider <Graham.Sider@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amd/pm: Add ASIC independent throttle bits
Date: Thu, 20 May 2021 10:29:25 -0400
Message-Id: <20210520142930.8369-1-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::23) To DM6PR12MB3067.namprd12.prod.outlook.com
 (2603:10b6:5:115::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from grasider-dev.amd.com (165.204.54.211) by
 YT2PR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 14:30:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0738d230-240a-46b6-7d89-08d91b9bcbf2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579AC5BA139606E21D218888A2A9@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EI5iVslt2OTpcqEdn6FfS9tOyE/DLWJsrRbPdBiXGsi2vTrc/q5J2PhAS8mdLD3IkNdUkwQxF5aI+WP6WCMMsMs8yUx7QGmvLuf53D/Q+yeF/EP5zc6U+Z1ttfFUeKKZE1FJvN1bInkSN682aBYknewngSxXw4+s8c1uRP8Y86HAY7a8l+g2UvwaMfLyWf7QD58UPJxd/wWSEGNhV4L1fpXTOpc0k7PhVubSzhuDsGx+cNupEYmeVZ04UFS+hx+472QRzROTKEb2b3tg3DiyNTeWJTNaM6gS53Y+KWQ7vice81QNhoCNpuAfAje9LaGfIo3zxm3taiMvYFjiMUmtYapjBH4dxetFmFQzJKfCighl/EsVF3o6H2vJ/XvgPuKaM8VaSZ7MgB5ABz6OH5idHqMhhyH2F9qmhe7zdRaanXcWwGK7+Y10e4N/WWuK4s7cr/EoamH0sz5oqvLN7Q+5K8xK7f4p3WHjslyhrsh9ZEXzeixi84dTByyAB1LI1eXUKPW6rqp5ILAzozAOW1kmozYOGnttidBMTymbtHFOGtExQrmzZUBYW9oKk21Id7MO2LfJwthUWzts5Kw/kHGK/MqhhxOzzKyN7DtJBgNsaipxIzDYeYfn7belmTUjex2EUAKw2QOHFS4HGtAsZlabSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(2906002)(52116002)(38350700002)(7696005)(8936002)(38100700002)(316002)(66946007)(83380400001)(6916009)(8676002)(1076003)(478600001)(66556008)(66476007)(6486002)(86362001)(5660300002)(956004)(36756003)(2616005)(4326008)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t9MfzBk0uPEXNUbQLOoBySSIUliQsFDYLSXBnn/Mk0DxRqtKA+DYa66ESVSc?=
 =?us-ascii?Q?DasbsuaKU4yQdMO6MgY4KDvTBt7Eg7okcTOhB3EWApkBUZ5rpwRapFyx1z8y?=
 =?us-ascii?Q?dSuyz9bU43qgDbSy0Mjzyr/Kj9IublYMdBOuq41CT/ve7/Eqd629D1Uffc72?=
 =?us-ascii?Q?NiNn6niMMq6T2j+CePhSmRkQJIbbP7s3W+kKnf6nBup5xSLnruN59Lv4nwMX?=
 =?us-ascii?Q?VSsl8OLMD42oOQazyd7rQv91TkIObHSQ+s0q1YtQz7b0UTWugpNc7VyacsZs?=
 =?us-ascii?Q?fsJNT4/sIJoNz/ID4WjhsHdpkqXUw8qhSaUMOIJoKBnH1sdCI5ZobyK6Y2lY?=
 =?us-ascii?Q?7n9mX3JSWPM2+qlqqmL716P/l7jUk6ZPKGjWODAAPkRhyr7+PTqD43WkQlpl?=
 =?us-ascii?Q?cIlRrkYaSDJOD9b1SWExQnNdP0jC3WM4Bzb6SwGxAP5zb93Uvi87AJILG2tj?=
 =?us-ascii?Q?wykXFJhFdBZD53olDQVNy+UciQospkqEMP8teSUMOA7AMqj2C7t5LF86MXoM?=
 =?us-ascii?Q?Szlhv0hWpny8GHaTKcztbPflm/MnP2Z/EsprgnoiTrg1Ffl6xllP+Ab/FEuf?=
 =?us-ascii?Q?P7JTj1Gz13IwjQwgtPuZw4akx3nA+xX1pzQzht9ioscpwaBFZqWQtpK2kr9H?=
 =?us-ascii?Q?XH58qU6gMfkaBHTkkU1unIVmbuFoAds1vBtRgRO2Y4rJacwI7ODW/mHMizxx?=
 =?us-ascii?Q?0yYcdaSl0mr3P1SXwx+hAtnO03rz3IvGN23FHOI+qAlJXcUgfLXZiXcRv2+E?=
 =?us-ascii?Q?xjDzic1u1FJIghEGcxPQ56PyvuBLnp3aSfDZGcYK5yYf9OZxfQ8jWUyoXF3n?=
 =?us-ascii?Q?6W//BXNqZg8XtKdzVmmufBrm8o9UNLwFDtXyxIAZ6fJDkepBq0Qs9ajwQMbt?=
 =?us-ascii?Q?55r5KPX/VZ9+IFOPGt33w921iG22XifVSBDBRlvSEpUj9fHg6K0Xeu0/aF5O?=
 =?us-ascii?Q?xbrwvkcBWwMLd8qkIObfxoz2j+giQ1XuyI5ts9qzKh+GY9xKWnbJ7f+eLMc7?=
 =?us-ascii?Q?y2YQv1e/pdYuXvVmsjl0ULEC/21/BHHMM8/dl7Re8D8KXujXJGmJc5eYbAnj?=
 =?us-ascii?Q?6+W1ytKYn3ACMFDYUxNt8Iu0JBhmjEmd5y0YE3oS1Qh2bDbexjPR1igMbXJq?=
 =?us-ascii?Q?aCEDmTkYDd45speM/4rEN+anU47HYR/eAPQBLB6oeZdzZpPAn4Y4ZtkeDVWm?=
 =?us-ascii?Q?D4w/mnL1c8uE01FYzFeu6pFgSCARUgCmKXengR0CpjsFCj6qa9TZCI15SCo0?=
 =?us-ascii?Q?Hh/xbwLFJ+jgPNuF50+FCmdMS6rSzqvuZod95L2qahShbBaKE9WoVEdiiNi7?=
 =?us-ascii?Q?H3dpfqudZEHDA+bAv2esg22B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0738d230-240a-46b6-7d89-08d91b9bcbf2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:30:20.7112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR05AKXqfGczAZR+D6k4LthlBrKDhbUR62QhDvyObC0Hl9k3/bp3yN2NPiZMN8Rg1DgjfkbfhuIAnYWTYzjoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: Harish.Kasiviswanathan@amd.com, Graham Sider <Graham.Sider@amd.com>,
 Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add new defines for thermal throttle status bits which are ASIC
independent. This bit field will be visible to userspace via
gpu_metrics, replacing the previous ASIC dependent bit fields.
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 523f9d2982e9..fbbebb1da913 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -35,6 +35,38 @@
 
 #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
 
+#define INDEP_THROTTLER_PPT0_BIT		0
+#define INDEP_THROTTLER_PPT1_BIT		1
+#define INDEP_THROTTLER_PPT2_BIT		2
+#define INDEP_THROTTLER_PPT3_BIT		3
+#define INDEP_THROTTLER_TDC_GFX_BIT		4
+#define INDEP_THROTTLER_TDC_SOC_BIT		5
+#define INDEP_THROTTLER_TDC_HBM_BIT		6
+#define INDEP_THROTTLER_TEMP_GPU_BIT		7
+#define INDEP_THROTTLER_TEMP_MEM_BIT		8
+#define INDEP_THROTTLER_TEMP_EDGE_BIT		9
+#define INDEP_THROTTLER_TEMP_HOTSPOT_BIT	10
+#define INDEP_THROTTLER_TEMP_VR_GFX_BIT		11
+#define INDEP_THROTTLER_TEMP_VR_SOC_BIT		12
+#define INDEP_THROTTLER_TEMP_VR_MEM_BIT		13
+#define INDEP_THROTTLER_TEMP_LIQUID_BIT		14
+#define INDEP_THROTTLER_APCC_BIT		15
+#define INDEP_THROTTLER_PPM_BIT			16
+#define INDEP_THROTTLER_FIT_BIT			17
+#define INDEP_THROTTLER_VRHOT0_BIT		18
+#define INDEP_THROTTLER_VRHOT1_BIT		19
+#define INDEP_THROTTLER_STATUS_BIT_SPL		20
+#define INDEP_THROTTLER_STATUS_BIT_FPPT		21
+#define INDEP_THROTTLER_STATUS_BIT_SPPT		22
+#define INDEP_THROTTLER_STATUS_BIT_SPPT_APU	23
+#define INDEP_THROTTLER_STATUS_BIT_THM_CORE	24
+#define INDEP_THROTTLER_STATUS_BIT_THM_GFX	25
+#define INDEP_THROTTLER_STATUS_BIT_THM_SOC	26
+#define INDEP_THROTTLER_STATUS_BIT_TDC_VDD	27
+#define INDEP_THROTTLER_STATUS_BIT_TDC_SOC	28
+#define INDEP_THROTTLER_STATUS_BIT_TDC_GFX	29
+#define INDEP_THROTTLER_STATUS_BIT_TDC_CVIP	30
+
 struct smu_hw_power_state {
 	unsigned int magic;
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
