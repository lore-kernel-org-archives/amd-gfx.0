Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F054C10F25
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 05:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09E6208C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 05:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gjX95lG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09E6208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A596E41A;
	Wed, 11 Mar 2020 05:53:01 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190826E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 05:53:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND3LiHV15iHx92lCYqUR5C3T560+OdMbqH7z8btHZdneWlzYi4ZA1dAcIPMzkHYBd5GG78+BEqDERGoFpDLyrc1EDO8GZD12ItgAKTt6XGQkEpbDDwZWUgK+P6f7qpofG6Er3EosLeJ3kqGt/UHVN+edMoKBxi9mpkLh4rug3wFO6x7ByIk2bi9llMc+y+bchU9icddvPBk3qOBTXcB8DP31R5N4SODA4NF0iVdSSvgYpjgGJ+dPIFHR5nGGpVBGmEUBqvEPnogY9fxf/7MbSQxBI1VfyCfIOfE9HbKYjU6veAaOs3WfgEOpygW0DcsIGhXYKqknx+nk/gHCBp2mLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFfLi1HckSPJ8+12SXgivQSpeSrI86TbU1XGGb/HToA=;
 b=J9pMUMxoDw1NKoYBZTTZVEmnqDbkqqs6EMSu6xxzSHx4pD3d6YuHwu/rT6wJiCEZUVwhkVabBtvehizExkxgJP4TgmsXQQrizZPVAvV6jBB+A3OdZF2EbGBg76/Ob7KTlGp3IKBp/ZIwoGjTB2ZxyLXHHrTqUl06tXxZeR17NQnw9Pdpfq9FEEhYDI1GTXVDyQueaJ/k4n5+op7tyUJTrpSEjkNQAse/JyXr0GA4pQQPm0GI3jPpVDmMPuoMP2/qErgjdkQ+RNL+cqCBFWQiE/RcxTnmvM3NozvoBa8EfJ2rxBMeG7DIqr0dEVpBUTgYp01QFnybQq/TcMIZVwKObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFfLi1HckSPJ8+12SXgivQSpeSrI86TbU1XGGb/HToA=;
 b=gjX95lG4ygDDIakrlydgFkCWpV3+UFJ3cnvlL0mZ7FbKNG5rrZYp5tkjSVrx05sJtNeSEsvbfrwEPQj6+egEcrOUBjyyLiMDDDk9uoYq025pjY4Y3rNLLf2yuwsCgolispWIblk0pLDI4MsRSxQw6PqV6PjczKPvXqoJh/XuyqI=
Received: from MWHPR14CA0034.namprd14.prod.outlook.com (2603:10b6:300:12b::20)
 by BY5PR12MB3924.namprd12.prod.outlook.com (2603:10b6:a03:1af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Wed, 11 Mar
 2020 05:52:58 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::3e) by MWHPR14CA0034.outlook.office365.com
 (2603:10b6:300:12b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Wed, 11 Mar 2020 05:52:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 11 Mar 2020 05:52:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Mar
 2020 00:52:56 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Mar
 2020 00:52:56 -0500
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 11 Mar 2020 00:52:54 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "Tao
 Zhou" <Tao.Zhou1@amd.com>, John Clements <John.Clements@amd.com>, Dennis Li
 <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: check GFX RAS capability before reset counters
Date: Wed, 11 Mar 2020 13:52:46 +0800
Message-ID: <20200311055246.30089-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(428003)(199004)(8936002)(36756003)(8676002)(6636002)(81166006)(186003)(81156014)(110136005)(70206006)(70586007)(2906002)(26005)(316002)(4326008)(426003)(2616005)(478600001)(7696005)(6666004)(336012)(5660300002)(356004)(1076003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3924; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc72cac-e4db-460b-5aba-08d7c5807353
X-MS-TrafficTypeDiagnostic: BY5PR12MB3924:
X-Microsoft-Antispam-PRVS: <BY5PR12MB392403F166C98D442E0B3221FCFC0@BY5PR12MB3924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0339F89554
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twW0h08TFz4nZjRyPsMFTkLmkKT2QYq3ccXPYXvretMoIBw+U4m+CaJW0WOtMDC/8CiH8QK6GiUxYvOpumGEukt7cT4oJj5CdIdmm0uOYalWj1DE7jnzlwJtl8JQj5aDpve/gCR4Mq43eQ36f16tgHCF5AMcRkwirdp6RINHACjvrhK4dwRS7jcGiljqcffq+8vy995OnsGKLX1qBhyiWRdZvHkQOopZSWGwGUwMPJLcqe0fm1M1Rv8bA5I9XMvND3MR2CvOyuaC7d82C8GUutf7Qb2Pl3tbQYq4Jio6yM/S91sTXS0xm3o6zTqdiPI8r7HKYsU3xv13ZVRmDD9zVOVlxMSW7eDTVISlzKGIrlqM3YBg4o+U8nurOo7eCc0N9O4TLsFDSDML8xYrFLF5GTbz1/jf+GP//9XW7/HTXFsmAOS8weT0W4Ufo4LeLUj8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 05:52:57.5933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc72cac-e4db-460b-5aba-08d7c5807353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3924
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

disallow the logical to be enabled on platforms that
don't support gfx ras at this stage, like sriov skus,
dgpu with legacy ras.etc

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index efd52bcf8785..dd8e68fdbd90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6328,6 +6328,9 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
 	/* read back registers to clear the counters */
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index 17f1e7b69a60..cceb46faf212 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -897,6 +897,9 @@ void gfx_v9_4_reset_ras_error_count(struct amdgpu_device *adev)
 {
 	int i, j, k;
 
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return;
+
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_4_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_4_edc_counter_regs[i].se_num; j++) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
