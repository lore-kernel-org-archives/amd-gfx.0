Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3086C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C247920768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LDNms7BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C247920768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749EB6E261;
	Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3826E260
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g03z8Gbu9mnselksTGxoFP2AaUiwYm66FYRC3emIP3XvynOQsJFyc2mcVCGe6CcqGUnmHHbXt/4DlGueIh6PkQB6kbnuIWLHITJJNAlENTmELEJOgLDwCEN7RbHDRRviezNp+bt2pxIfh9JSVgTcZfGR1KjOhDr8hYa1SEasNP7LePwtJf4HVXkq7mKpBcH4CIpyKOP2cldy7Uflo7cdp8Pb8mD7LvtbMUHZCjsZRAagRcHUTBqdUPlYt/WqzoNQBAzTnTMS/5E4ocxLIVBCFrBh9aGlERpiNAEN+Rt5FqQ3ylOPNWF745Dzf9oVZwhwQXc0WXcI9+3UmsRissjgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVb5R7456fmwc/Z9nSoyO9KW4wZjFKZBynWLr9qEIew=;
 b=eeQ7ZL9OdUeWFKeio1qfkkqmg4Y+cMgHD/ym3Pb3wbLqZpt/auL/raDi1M6UxQALch/9vrFB6m+TXe2tCLRUjBiaUkwcCDUpsMpkqrcBks0ziGe8cVUOoD8rXQpJM7msw1YEBidwWwIQ8H3AFy3o6JQLMVDnJ+vHOu2lLKhJvk0L7+TlcF1BeLWuY+Xm1axVOg1v5F0wrUP5M2+zzX0s2A3eBnKxLKLtQC5M/gjssfx/MXtp7kWWK7BxCRDzRrdWLbFyD3+M/qo++shKYZYszEOGUI6h4opRXhW0T3fwApvcAUUYTa7YL7aLVdpw+j+/QD33qkx5K3VamfuaAm70JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVb5R7456fmwc/Z9nSoyO9KW4wZjFKZBynWLr9qEIew=;
 b=LDNms7BEIUAtQBffR7Dd/nQEgPlApQMCvjzdxeW0QLH3A/bUc3K60hNTN11BaVZc3tdoLl8QQaU41zvMw9IjMp4CITWjq0+WyTY6MRhhUEy66JjYTDFGIaExvmaJsoqq1d8KoHDZRrbGtrLByK7N+FvszR3RR2xAcqho6QxrXtM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:32 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:32 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/17] drm/amd/display: fix dcn3 wide timing dsc validation
Date: Thu, 13 Aug 2020 17:33:50 -0400
Message-Id: <20200813213356.1606886-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:31 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f9332bc-b739-4107-7961-08d83fd0ce78
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355EAB49D1EB3784B3BC23F98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrriR8FhXX9uzC2vU9Nka9KOGl8QvfBIN9N87u+s/hhwib2yE9FsN3SfjS0W/koJ5ZV6EKdFB4EqTwM0/+KppmMlY0YJ6T7qFyspEt10xZmqTRYpf99EzGibMvJpKCqsXwtr6VMKDqJ1Trdm7DxdoSQvlzrqcLz605XvLnnNeXB6xBH8KwKTLwLBB90+k3rRFlEWdBzf1WJZlSSxaECzF20hVuj2KDFCt1iEgnsMlUQkMDlrSFeIM/ySzwZuzKlAJQSKohbpDD+B1ueHmD7ZsFNxIm/8ilXpST4C+zKI+RTgJy9PVDbmvcKVJCkW3gH2e703IcWcHxAxAgHyR354bHhCHeAopWzt2ktgY0rhBbmqh0UuJ81iM45iomx+glQd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(54906003)(16526019)(8936002)(5660300002)(186003)(86362001)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 49g6zUQiMKU1ylfsQLMYS7E5rSjffv1erYmV88SHzTGQGYFRLiZ7+KwFyNTg8VSZeI0gye5rpa5ce/O715rnx5qGGvviJqcOhE35V2J5wnJCFfcT0A66sR/zuafpzZviEcDuHecYWbX2rKjxmTKiKn2AF78z2gExi//TwodvNXcNkxLIIawYOFPrytrH5yB2MpVVaJ3b+0v2Arq4HYE9osSwA0MkIvBoS6PAV5wKps8TLFhecrwPogL8prickSVZoQvhxVHGqY3u/ZB6O+lOZ9qnIhVRmgOPDp/3KyJoUQsmXGXFU4T4QgD2qktiEYOb0BLC1Gh2n78DWo/s/Tw0QFxIrq7NZOE8DyKjXDfAy2WaLVMev9rDeR3atuRZhXsWW+4t107kxZz4j9VmBXff0EDGwPMrF3eUGUPhbcqWrwsIPpowa+R6GWKU6osboUerwMXfJUVE2FKIns0qWuHZiQUaQYaUuRGmiAVHpDRWz8WHIF9nqkyBa/uUhFAmm6O4TtM3oPEuYEA6ETrKUzFeZfO3WlctVhQ4jZNr+EAtqExSV+HLkoxamBtwtbk5eo9HyUr8dZTztEWHud1DY39FnJpPwAjVBHTLLe4Cv7sKSZeqPOPntq9gQUMNyHkAo7Cr8pU7w2oIF//Au22NJ6KIcWCOyY0blEgO8kW7QqMLINKwtnLT6/xGWaxG7+rBfipE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9332bc-b739-4107-7961-08d83fd0ce78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:32.4327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYeiAGkEMddsU8SW3xAsZeTKSUb/MAiUBPWWoD0clZBp/yGNziWbli5m/8lW3is1qdBFjdn1Agba0yaV8HJgFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Wide timing DSC requires odm. Since spreadsheet is missing this dsc
validation we have to modify DML vba code ourselves.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index b54814f11b74..2beb284f89b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -63,6 +63,7 @@ typedef struct {
 
 #define BPP_INVALID 0
 #define BPP_BLENDED_PIPE 0xffffffff
+#define DCN30_MAX_DSC_IMAGE_WIDTH 5184
 
 static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib);
 static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
@@ -3984,6 +3985,9 @@ void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				} else if (v->PlaneRequiredDISPCLKWithoutODMCombine > v->MaxDispclkRoundedDownToDFSGranularity) {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
+				} else if (v->DSCEnabled[k] && (v->HActive[k] > DCN30_MAX_DSC_IMAGE_WIDTH)) {
+					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_2to1;
+					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithODMCombine2To1;
 				} else {
 					v->ODMCombineEnablePerState[i][k] = dm_odm_combine_mode_disabled;
 					v->PlaneRequiredDISPCLK = v->PlaneRequiredDISPCLKWithoutODMCombine;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
