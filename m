Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E0C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 10:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E2C2082E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l/HMknlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E2C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FED6E187;
	Thu, 30 Jul 2020 10:13:59 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE1A6E187
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 10:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoFejRVzQI2DOn20fwLh62FnEesrdlOrMYTZZbGHS31vxAjhZaEFc1T4+4bigX12YyOWGAKAIJIt4cL07Tvf43ewq2XjbWHM81b9JWqP9/zARNpDkJSVS6L8S0mdsKnk/MGAfEq/m8KdLnDzOT0Ys19uBM9IlR7CMJhWa7OgIfy/F7m96SQkLpwDt9FeyRQHz34DEWhD//9gPoiAy2J9LzMrGdBa3KzmsSOsgAsqutVi2maGVPISVJcA7z7dJAJKsYfRv3bp3qTX97r/wLVrJLs3sb3pg3ivkjRkLKE0TeC6cY7C3b0dC9H8EOZh+41ne2BZXWDB61ngzU3q0jhMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkzTSO59TxxySuwty/UW70L7hYMVkWwZ5XXC96h8vJo=;
 b=aG8A375oC+yp16iwENdsw2sobB/AW8mRYZsA9Ze/PRGWu6V+Rn5acK9tYfWXZuDokVhh440MxZ8oy3m6fJ0vnLYm+b+gKzbouzMkxDf4LXP3KI6Okq/HC/vNZflP4ZZHae/r11vePVRCxCXQK3FNo8IZ4LacNWBGjv6EIGJhH5GJnlENvMZi0aGXgwVlmS/Tl81ZUr0rMgC2xBJUshCQVBI3wjwAJbk2eCZBhNAfWS8CzUFNOallBmHme1yye8+yxnj8CSgIDKj9b8/7EvgvvqVZcPxvcylBHBi/A7bV2WPaZMlwgVFnKXlOv5Yg8Ck230QWOEelthRJJr9H/xbB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkzTSO59TxxySuwty/UW70L7hYMVkWwZ5XXC96h8vJo=;
 b=l/HMknlY3q0pJgvanxUF3cdX33185CAagUuzNwUy+AeXv8kYZUaadrnTCVseVDFoLtk848Ko1adkqFRUwgJf+E9gtgQ1+36peDYD1BtvM4GzuprZquKebDh2G86P9/EHbsDQ+2/ENKOiY1NDs189wSgQkL5WbfbXEvUjSpbQrQ0=
Received: from BN6PR08CA0084.namprd08.prod.outlook.com (2603:10b6:404:b6::22)
 by MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Thu, 30 Jul
 2020 10:13:56 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::b5) by BN6PR08CA0084.outlook.office365.com
 (2603:10b6:404:b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Thu, 30 Jul 2020 10:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 10:13:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 05:13:55 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 05:13:55 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 05:13:54 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder
Date: Thu, 30 Jul 2020 18:13:45 +0800
Message-ID: <20200730101345.3424-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ca02a3-ce74-4590-bbf7-08d8347144ad
X-MS-TrafficTypeDiagnostic: MN2PR12MB2975:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2975B1866F285088848C2BE4EA710@MN2PR12MB2975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLD9eXDSYzV1ng+WSQMg86uNGYkoA3CYuxY9wuHvDUcaWNSpXz6cg3FLSMAqRJPCncGMCAsUc4+DGzUVmUp0qvV9c5LhwM9qpsI7XZgSef0sUt9fhJX12rP1j5i/LJELFvtHOS0jo12x+78f0IbnxUO/MzMd4SfymLuBRXLj4yiSq1iCLALTs9HQoAqHtAVBBK7n/z4m4ZciEoayPQpVVZUzAgJNWj+DHvdYX6h8EiZdRNWFF8Ede/d1yTKbXq2yg4jhjmSrqB/6VWWVwuylGu/B7lYOpD031yF0tfz5mu6L8NIbQVbNa3CrMQWMtRZnRe62DVU5wK09rf5W3njuUfF9xiED1E4SBN2VKNfWSke33E9HZWBTeAjYU1gQ19TlSwo309kl/vodDgdYlil/wA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(5660300002)(47076004)(82740400003)(1076003)(478600001)(2616005)(8676002)(54906003)(186003)(26005)(81166007)(356005)(86362001)(2906002)(316002)(6916009)(70206006)(70586007)(36756003)(7696005)(6666004)(4326008)(426003)(336012)(8936002)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 10:13:56.0670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ca02a3-ce74-4590-bbf7-08d8347144ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2975
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

Enable GFXOFF for navy_flounder.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Ia49c1ad70e3521447b9db101f5c0eae70b1df665
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ca16f01956d3..fe8ccc9be682 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7529,6 +7529,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index a9453ec01619..7d7de854a826 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1029,6 +1029,7 @@ int smu_v11_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
