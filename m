Return-Path: <SRS0=lnB5=AU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC66C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 10:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4473820708
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2020 10:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DttUfllo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4473820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9C56E1E2;
	Thu,  9 Jul 2020 10:40:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B03BA6E1E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2020 10:40:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E17nfNiGiobSIIvnCrU3svF6SVhKBLoH491mHmw8a8daurGCTmEZ2T9VYSx6uypMQkd0fKbCEbNaeEkvwnAIeiK2UdNn+pihpD1k5JObBRyTVqUAb0rn6XumFOcegb8R6n3JtjvvVrqayls6Xh7D79PYAGRevqEU093qRFQxi5wui0NE+nqAzxqhGYnZ5PWmkGBpf7y9LBmtUcIZA/+UDTBJrlCwp9SmCx5Bp+xmWjm3bFihSyVJX72vWUk8hHWIQaPSrh5mwQwfu92QNllmqW1MxFAgwAnNZmJM4f+YTAvyqqxFSWFNGz8x+shDVsNfyG49W4KG4uuTiQWao1ch/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovPHTXaCQVbggEV2nS5PEduiiegR4Fg1+QxodNkscxc=;
 b=klTbXcXeXuHW5J3mok2tmY5WX2+VyHgwRSFjN9doV9YF3Mmn4eTfPbfgWxTlHoY0FwnwRXpyJb+PcrQMbnD3c76oqbKNYzG1ks3vGkPuBF4+231NwVK+ggVBdmp4wnWgCQDz8+ni3qjWXS0ewISmouFOw9BhgVG9SRSKMY+fJf+tqrV7J1Zy872ifL+cpr0XpymbROft6Ym1DSX5QqogS47FxLAFTFLSGvOJN+8XilfCguFeRgx2SnjXXrmqQs0XWv/U9VskMMC9VWmpoy62deP/6B0wCel4pY3dhEeQ1nVO+iTK+e7ryZq4LgXdgfi31xlXYsK5AtDHNnBSio3/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovPHTXaCQVbggEV2nS5PEduiiegR4Fg1+QxodNkscxc=;
 b=DttUflloPGYZu4LjOMyVvlTC6XHrLDR9MEo8v8YAUdObf/bDU33F1J7WL5G5gmeHZp6mgMmgHbT5HxNgRkKivCu4ROxA66VWwUtpIlvNnk1i6ljA5aVxRlk6LZWYTg1e1WYHAKyGgcPGtGoTMoxKI8JfBd6u4cbgRhy0xoESLaY=
Received: from MWHPR13CA0014.namprd13.prod.outlook.com (2603:10b6:300:16::24)
 by BL0PR12MB2580.namprd12.prod.outlook.com (2603:10b6:207:3e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 10:40:56 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::98) by MWHPR13CA0014.outlook.office365.com
 (2603:10b6:300:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Thu, 9 Jul 2020 10:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 10:40:56 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jul 2020
 05:40:55 -0500
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jul 2020 05:40:54 -0500
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/smu: correct a mistake
Date: Thu, 9 Jul 2020 18:40:51 +0800
Message-ID: <1594291251-5282-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966005)(70206006)(82740400003)(8936002)(36756003)(47076004)(2906002)(26005)(186003)(426003)(2616005)(336012)(86362001)(4326008)(316002)(5660300002)(54906003)(6666004)(478600001)(8676002)(70586007)(82310400002)(7696005)(6916009)(356005)(66574015)(81166007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0e9ea27-7a46-49be-7fcc-08d823f48fae
X-MS-TrafficTypeDiagnostic: BL0PR12MB2580:
X-Microsoft-Antispam-PRVS: <BL0PR12MB25801DBEA87020F6AC980A1B9D640@BL0PR12MB2580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya83DTDcXRFFlGwfsxS1z8aV/Aj1d8mQoqTE5mxpQSQQsd0vYBVpbZeuD2H+4s+bQJir04u8w+cQi/+7dqCrYrcOPJqcPQor+fWc3CBPcwqu8jIxYpVci99oAE+Jc7cdxULDY0yW4MuLZ1X05DBZRLc5sOWvR71wqPz4yJCZCCRA0mdWj7x4HSnuZJp+YDc3Z6iMPL1dqfyaVDq/LUIDQKi8xdBmUJMoyTPv+JzZxRZCo2Gkp1xWFX5jXwj7naY3EWjVFXK/5XSzuCD39tJjQX71HFULvVljNkSNcHdfMi72x7PV1ewkY+adk7722JWER4b+uOb2GMPb2aezwCt3xoLnvjqQfsdJ+3hKUSlZiE71qeeDWhzrZyO/oup5RnCrrBNCh/gSA/CSNYH0Yo2yPw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 10:40:56.0776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e9ea27-7a46-49be-7fcc-08d823f48fae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2580
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
Cc: Evan.Quan@amd.com, chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Corresponding to smu_workload_get_type(smu, type) is "get_workload_type"

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index afd786b..31e1fcb 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -77,7 +77,7 @@
 #define smu_feature_get_index(smu, fea)					smu_ppt_funcs(get_smu_feature_index, -EINVAL, smu, fea)
 #define smu_table_get_index(smu, tab)					smu_ppt_funcs(get_smu_table_index, -EINVAL, smu, tab)
 #define smu_power_get_index(smu, src)					smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, src)
-#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_smu_power_index, -EINVAL, smu, type)
+#define smu_workload_get_type(smu, type)				smu_ppt_funcs(get_workload_type, -EINVAL, smu, type)
 #define smu_run_btc(smu)						smu_ppt_funcs(run_btc, 0, smu)
 #define smu_get_allowed_feature_mask(smu, feature_mask, num)		smu_ppt_funcs(get_allowed_feature_mask, 0, smu, feature_mask, num)
 #define smu_store_cc6_data(smu, st, cc6_dis, pst_dis, pst_sw_dis)	smu_ppt_funcs(store_cc6_data, 0, smu, st, cc6_dis, pst_dis, pst_sw_dis)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
