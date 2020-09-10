Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20603C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987F121556
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 09:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XHj2WZuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987F121556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507E86E8D4;
	Thu, 10 Sep 2020 09:25:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A645E6E8D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 09:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2p+7F4qXQWDzcsWNR5CfWKqXm13CyTUofn1jYo7ULq/ZlnamKTzDgEQ/d6ZYXRqNjD3K9n1c57wFM6g3ANx1hx5pbKUFN46LOpR55cW+rK/cQq9Zo9ehAo84kO6nQWA/6nluRaYpdHzyRD+jnOSFGg8HhGwRchdgE2XC0SHSNJY2PXncx5ZZTZ5FM3LPss1Y+LKIH51b3BuT4W21gIFxgWLv0Fw6UJGqJck4S2OV1kWvGqTNRzd4GYFoI6fmo+LmZSyEQSZHnjdn6HlfLhV5ZY34LhSRXP54uyM6Bku76me5ukpOPfHEtn6wJR8oOv9dkHQM3N4c81KoJueWGkLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4DYtpmWunIK04fyh8mpK7VkzZ/SlYivKJSP2CZhFSo=;
 b=DkFRf+ClPiDG5DTpUfhzDxZ5BlTJTENzLqyzD7tc7vQUCMPoX35x0Koam4r2JNU9XGy/Q49ynr8GAF9GsX/evjEc/PPF3Pa4wIdeXM9Xzk9Pn8kQOGsTfJ7HsWeca9e716GZCArhYQzzrOMwfeoYkSMK06o1766RrjZiis1MxNo3W6qToAje8Ze9e3ps5vthWccTaxdwW47r/5dnIeUrBrAnvnv/i/L4p2X2KM9xJhitX9KRTFiTaUslCJQ9d4F1oM1EyaBth8MVTs23XB254uub352nPeZZVKy2+SV/jQM8ZRRAAhlrd7qi/yRSgbL4nfE0gqLKoikVYmay8WKYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4DYtpmWunIK04fyh8mpK7VkzZ/SlYivKJSP2CZhFSo=;
 b=XHj2WZuINC54C+Ha/zK+vgSBK0i1viC/CBAf4zCZnmBsJzsgqU2KXbZyxnH8kwNPH3HWc6T+HdaxizVZ/YFAE45VS1lBgB77oHcAOleZewChX+B/R94opHS1ZO/alGB92mWELfVCIDKeMTADEn42uri1pdEOhI5w2jkIGMBE5aQ=
Received: from BN6PR19CA0100.namprd19.prod.outlook.com (2603:10b6:404:a0::14)
 by MN2PR12MB3294.namprd12.prod.outlook.com (2603:10b6:208:af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 09:25:48 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::7b) by BN6PR19CA0100.outlook.office365.com
 (2603:10b6:404:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 09:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 09:25:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 04:25:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 04:25:47 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 04:25:46 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update driver if version for navy_flounder
Date: Thu, 10 Sep 2020 17:25:35 +0800
Message-ID: <20200910092535.4326-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19654098-6e43-4485-7661-08d8556b80bd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3294:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3294D3AB5131512217884544EA270@MN2PR12MB3294.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqwKr9y469T2/UsCxlOjLprSdUrkoWW6TJ8wOyTidozJLeQ2tHJmtbn+egICkeMHb6so8/z6FOoN/SuEVrPUQfQOfgIJt+xJ/xtAANe5YlAPoLx7AGELucd3jSUHv//XleEj7oLhDUw8Tfhcshc75zx1gybFkqk+tn8GKj7OvuKTcjcqvoYkQNxHecq7eVUYSKfmT8Jw306zbVOVTIBAkiGU5GTZ4/aAEMQniayFj44CUsA1oLbZyenaptSBfShfqO/hnsIu71RVh/7XqsllGVi5O2Yl33Mvkc85CISDcxwwnbTOse5RljQuaBtUf/VjUKU6u3xkrM5+32MlzbKnZAck3UPMEGTfUgZ+k6+2MZa/V+q29s9Tuhgs+p+P1P6u4DCzfXf4tOttjaUmiWqFbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(47076004)(83380400001)(356005)(8936002)(82740400003)(81166007)(2906002)(54906003)(86362001)(36756003)(82310400003)(70206006)(4326008)(70586007)(316002)(26005)(186003)(5660300002)(7696005)(2616005)(478600001)(8676002)(6666004)(1076003)(426003)(6916009)(4744005)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 09:25:48.2237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19654098-6e43-4485-7661-08d8556b80bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
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
Cc: tao.zhou1@amd.com, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It's in accordance with pmfw 65.8.0 for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Iddb07c2123c0fd5dedff68f9a3a2f43685600117
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 1f9575a4dfe7..21d65d20e569 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -31,7 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x36
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x35
-#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x4
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
