Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0383CC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7792225F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 07:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dkTL8bRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7792225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF9B6F477;
	Wed, 21 Oct 2020 07:56:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46AA6EA63
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 07:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMJ/QvOyNpON0e4fFM3BBJl91dYoAy4d+0Xq+mURST6PEOVPGUkjQkMdp7N9SJhrg7rVnlDK36H7xSZ2gHmYHl0eyLV52dLXZQskIyuT99//T206WZWbZ9CYiLBSZrKqBDFkOKcwcw9OKQ7JGJqj4wDbOEmhuMjBaygCdZP8qKyQVnDgVH6EILhMENUgVg0IzQmTFEoIsMzuL6Xx0YV0bdJhIz6+kFh0wEDts9vDGQks2luhBQHGhecTDLOmMw94b8GG74heJIGyUM+2imBmThBHs6HnSdM5ayC+Ciox2xEzKEyljZzcK26GwT/qJiuy2SWxx1hKpCafTCWI/60a/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsA5tyvGlpex+G0r9JG+UJDjPD1G7QLrw2iqP3IQdRk=;
 b=VDvtEZE/NINcK+bBUUxcpt+ZU97yGivLkBj6eOYeq84oZ2M0xOB4KSjBxCyEq2woO3jGK+ruCUYgQmU7l2qbjVjNzSoZZfT/4cKBBCoxhCx3TunlqMEUegRF3eKUPAaxUg1eKq5sOI4GVthetG2guLX70NyC4xaQJr7Howm3o9civmckN8SlM5Fx5fI0UUvNVqMrHR3zl2a71pPzP+sJjg2yZ9B+GBBOnUaOFl6dUxABzoZ2iJxXf6/2+dLFbvs/9MfZ8AU0MxsTFVpRmLJ2CJmb0lC3xkDPIH9j6t4aLnIT/ej1mQm+AFi96KaTiYXbIV2OB15i3GsZKKA6ndegFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsA5tyvGlpex+G0r9JG+UJDjPD1G7QLrw2iqP3IQdRk=;
 b=dkTL8bRtjBTUN4tXLUn36T0LEtkzdRV6r5ZFjLMOXld+5H45kpgWd7g5lhZ9uNrGrJw3Al6zcajtA7tzZaNhX1be8TrChnT5nAxAgZySH/BY3EVIMPxAXDXGOBM5Yo+PvuLa55OUuw96TOQkzv9xd7jSxDgS2VMBVSMUSpNkkX4=
Received: from DM3PR12CA0126.namprd12.prod.outlook.com (2603:10b6:0:51::22) by
 DM5PR12MB1914.namprd12.prod.outlook.com (2603:10b6:3:109::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 21 Oct 2020 07:56:14 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::41) by DM3PR12CA0126.outlook.office365.com
 (2603:10b6:0:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25 via Frontend
 Transport; Wed, 21 Oct 2020 07:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 07:56:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 02:56:14 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 02:56:13 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 02:56:11 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU
Date: Wed, 21 Oct 2020 15:56:06 +0800
Message-ID: <20201021075608.16785-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1ef868c-d719-44c5-2e8c-08d87596c88d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1914C8284A4AE366736F65E1951C0@DM5PR12MB1914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oWycLeKWYEb+MpZG4YpHVFCeGWKfGnHXG5BYrch0DpdQ+YHT4lvYOnGu5VOTQ47jyMFU2HN6WhnVLEAu3l9FuJ0j3T7Y+C+z0Q8XcdgIS3OUf3smV8D5xRuBiIIq1KhEThZo8bhmczTkjwyfh1q9CyjBJUpmD4oLpdpwr8Ln58ct2fVhDKpYWJ0VTAslgzne92YqQDWSVez19s0YNUuePDCRAqqawglqyEdm0Trn91kk7jQJft7kZq2HkG8pBZGAkH/wG0XHyuU1qND1orE5WTglQmvnbGSex/zn+PHr1zi634OOB1/brb2eT1O2/Z9cKOr8+jy8JucZE1nr/JvMiVQYnMAuI5z/4cp8Yy34b79EDUaeci05wZ1YfcKHmz6aOZp15rkdBiOxmhFQNpq3bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(1076003)(70586007)(70206006)(8936002)(8676002)(44832011)(2616005)(478600001)(86362001)(2906002)(4326008)(316002)(4744005)(186003)(336012)(26005)(82310400003)(36756003)(6916009)(47076004)(5660300002)(426003)(6666004)(356005)(54906003)(82740400003)(7696005)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 07:56:14.2245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ef868c-d719-44c5-2e8c-08d87596c88d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun
 Chen <guchun.chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

Change-Id: I58129e3aa88369c85929e4dde002cf43c3ff288a
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 564336c2ee66..13723914fa9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1066,6 +1066,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7319, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
+	{0x1002, 0x731E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	/* Navi14 */
 	{0x1002, 0x7340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
