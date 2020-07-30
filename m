Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A161C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8CF206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bLWokWK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8CF206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A136E95A;
	Thu, 30 Jul 2020 19:12:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87EE6E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiRAucw99/9vSRTIgg1ZdQHxf1S+wJPsvJFHAn8T34iSpy6cKcao8Him/LcLAZAw0iei0FDvYJCd6xvnkAXmn+rRPaFoRGash20fysRUfuJGD5+eUnMEKRiUb7eRvIrA997tMzN2ms+zVQLwN+nlzWNPC2sRk7ehh76a/OviaH62P69AC1HwlvXiuSfI0oQKJ+bm9C/hbEIpMqtU94rvFOZfUB1FapASV1aVx8q0TCc/VX5JiwStCJbdQQaKIrdtU1plAV/AhaVzRIraZLGgjvOKKlVV1KdpdNGaKEccrXxcHKwfFaTr+QFMYcPSWgms+2cq6wkS2APUqJMACoSWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erq2/27R1H6iJE6jrP+cUTWq/6hwnaOAHv1Frda+d3k=;
 b=Rmh7UY7kL9glkX1z7746RP0DhtiBL+QX9Z17j29o3pQJtTa7V8oil4OcFCMO3Bnrz8gb5hHzm4ynmmlLb41YhGpnoTZKRIkTMgVVWSY/y/PHKh9Pa2JFbJav58Os9epk+j/bF8EcxV1+bdmrdzA+CMBfp0u0ZHTBAqoTAdoKE/u9u7bitR0X3RtG72PFyFwGAQ/WLTHqbciRoECJkx2qb0GWyn/Krqi7AU0yRDmb4pVAWfSt1HeH3oT2uD75xNXnfONvvuncoblmZVlElzGUm/mFxajIYRIbbJeoQiymF97la5czI8AgO7pBB0S2Tg2DYr7jn5KTMKaB+gQPAFP3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erq2/27R1H6iJE6jrP+cUTWq/6hwnaOAHv1Frda+d3k=;
 b=bLWokWK7DWqpPurupm63m3AJNN9a/iPrPeyTdx1EfUsPxEZlB7G4TrFJoloKTekeuOOo8+6IK1pFyV0y8CMsiZst0pjbtsTFHbU7ue0PbKKRf41zvscEsfREZKVBi999nKlLqRkCvZvRy4cdjYDX5Cdei+UgmHh7HjQOhgg5C3Q=
Received: from DM3PR12CA0060.namprd12.prod.outlook.com (2603:10b6:0:56::28) by
 CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.26; Thu, 30 Jul 2020 19:12:32 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::aa) by DM3PR12CA0060.outlook.office365.com
 (2603:10b6:0:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:31 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:31 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:30 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amd/display: AMD OUI (DPCD 0x00300) skipped on some
 sink
Date: Thu, 30 Jul 2020 15:11:39 -0400
Message-ID: <20200730191146.33112-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 165bf3d8-7097-45c5-29e3-08d834bc8279
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-Microsoft-Antispam-PRVS: <CY4PR12MB128559063912D0A469F1D6978B710@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baDCC8VYkYnZ6AFG2r2GN/YFFMcAB/XIwWBrc/fozIqvVj+MWYkcQ5KNTinayia1e0TMS8MqQ2Et0Uiny9EqoisAF8Jr1hnASm0w/e56vgMKithqCcO0vFhUzi01O9lZT9vnkOarAuV+1vbInruPv0ZNcX1h4lE5n+SxOrKCBKkIgPjKh3qZkdljbxC5pec4Osv737ICCvxo6VyqVDUdw1Oe/TGR5nCIfwLiYWUYrT7Yr6lYq5p+Pbm3JRmIs+rZfoaFnjVScHNlCEp8E2vmW9LzFRxK2E0EiEtZO9OPtn/ROxXCz2eKRW5o76dmFB+lsvE0ffBNYkYTMnQM4cSIjoPKnIVAbhgq9Yp+7kATGSI8bpGi0UN8PhibERNluDwmPPmW/p9QRhAT2TxaX6CfBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(336012)(8936002)(19627235002)(316002)(2616005)(8676002)(54906003)(426003)(7696005)(83380400001)(44832011)(86362001)(478600001)(5660300002)(6916009)(82310400002)(2906002)(1076003)(36756003)(81166007)(4326008)(70586007)(186003)(70206006)(47076004)(82740400003)(26005)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:31.9490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165bf3d8-7097-45c5-29e3-08d834bc8279
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
Sink OUI supported cap is not set so driver skips programming it.

[How]
Revert the change the skips OUI programming if the cap is not set

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 2bfa4e35c2cf..1032551f84fc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4339,22 +4339,6 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
-	uint8_t dspc = 0;
-	enum dc_status ret;
-
-	ret = core_link_read_dpcd(link, DP_DOWN_STREAM_PORT_COUNT, &dspc,
-				  sizeof(dspc));
-
-	if (ret != DC_OK) {
-		DC_LOG_ERROR("Error in DP aux read transaction,"
-			     " not writing source specific data\n");
-		return;
-	}
-
-	/* Return if OUI unsupported */
-	if (!(dspc & DP_OUI_SUPPORT))
-		return;
-
 	if (!link->dc->vendor_signature.is_valid) {
 		struct dpcd_amd_signature amd_signature;
 		amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
