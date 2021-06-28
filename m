Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ACC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F282261C43
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 09:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F282261C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5416E3BB;
	Mon, 28 Jun 2021 09:28:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C425C6E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 09:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiA+Pgc+5ofRGjcqwLm9qm1AUACdcDatkB+RUOIDexgmwxlALTeCXcznpMQqDWgt52r0L92FNjwaYu+QJa0ZL3/SB2sBqpPgf2Y/DL+fDasvchT14jMTDszC4o6WxUieb4UHP13uHBgGIuA27rjc3p7swBu/IpCwkmpv1xK/U6fYLlwJVPxinz8858jGxmLISpEwF+DvWJN5PYRonrH5gGKDsfOOvYUxM7S2jfxQ6uR+K9QZ5RINdQ7Yg7QT4PtUf+Gg4GGsdwBiYlYWnTXptjtuHz6JB4f+zVDShpM1XNMCSFOpPAh04YQP54LH3gZjWlfSERhl1dKdM0AqixGyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8QVOKibPu0DY+gzm5Gf3nikdmM2GxpbyjCfX7ivq6A=;
 b=MoPsBKcEUftwtdm8naA3SxJIKkELrLU9Yizc6Da9JNhJwVkwLUWXXV1PaGmiVOyXnEWfHZ8dM9OxqmY72geUgy49+emZmqaCxoXUOShlOeiaLEcU5IhatmS/MTZbiXMEl+Kl7LUa5qDQ5UWU5QO+OGa/yV1CdnQbCJjgtSCxRUr59l9ShA0sXJ2i/j07GkNwNUtIM+m/vgxLlhPTjXkqemP9GGewNZz/Kop6pmmPKmBVI34w8zMVhu1S+HP3j/Omnvi5N4kzGdwEQM31plYW35uHKZGI2ax+30lUbwP88IdEQOtRUuah5XeZD+KHT9ABjosD7hAasQPpNGGsh/Lbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8QVOKibPu0DY+gzm5Gf3nikdmM2GxpbyjCfX7ivq6A=;
 b=P1XKl6AxBZkR4cRhC2j9W23D2ax7hWF/Dt2XBi1bbTqpjdOZr6aCx9iF6NTVknaN+3QOhNlY6lei79Xf+OEwozd5Znze563kERpKmsD0ffyOu7OdMSwoQ/268tImT0dZJWibv4WphO86sKl99gb+OZHoRzw+zsGmKeLsOKnFgA8=
Received: from BN9PR03CA0176.namprd03.prod.outlook.com (2603:10b6:408:f4::31)
 by MW2PR12MB2489.namprd12.prod.outlook.com (2603:10b6:907:d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 09:27:56 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::54) by BN9PR03CA0176.outlook.office365.com
 (2603:10b6:408:f4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 09:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 09:27:55 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 04:27:53 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <rodrigo.siqueira@amd.com>,
 <aurabindo.pillai@amd.com>, <harry.wentland@amd.com>, <tianci.yin@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: fix null pointer access in gpu reset
Date: Mon, 28 Jun 2021 17:27:30 +0800
Message-ID: <20210628092730.4722-2-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210628092730.4722-1-guchun.chen@amd.com>
References: <20210628092730.4722-1-guchun.chen@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82435303-db57-4392-5725-08d93a1702fe
X-MS-TrafficTypeDiagnostic: MW2PR12MB2489:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2489FCD9A0962BDDDDBC4F81F1039@MW2PR12MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqK5KC/gy901Nr2GdyR0MYGhOQdo2E4kmCkc6d0MKIMCnVf/NZHRu943g2SWtoOptunzcJpMV4RH7zobP4GrmVeI7mbNnZ8bFFiKQjAKUnbovhBsciWqjGMa/a+poIl1jTaZKei7P4MnCqvxlQBNyMMLkhSRJxgeqTr7YpzsI5zJOGdKPCPV/DRdYqCZbnP/H6WYY4kafb+EZMXkBXLJY+Fg80FaY9bWc7IDQgccuQLNymRd8VsRVDVpK/B58jRJckCCcBPuWpt3YFqiscV+62BBGtUnkWmbdk2mNa8Rlf5Vt/lfs0Y4so7DtEdfaZGvFWA4FWLD3BJ5s5ebI1fL6zz/Ck0fCxciPGv/NlV0x7K5pJYnqcVJFf2D3UyqKMPBCNhqzqZYs+AHTTs19vKQarU8gxMP5tjl73+VOkepdI3Mhp7+vnvjBlZ56w3QQRNnKbO5iR4iNv7R5d6u418e0gvlx7GXD11nrVhaSISMb3rnPL4Fi35R1vOY8FKnrtEDjOlcdGJjKyvHbRm2n4mGrt8Ek+TkDdI1aD7yqMuIX0CWFZ2O66VM4iuy+h2rvdM2rF5gmHcVsgNehOtaE3fQsj2M7VBrYJSWSabIHmM/MhH8a06hi8QwZi5qMj8lJqb9rwG/X9ImLp1dnKi0lkiTRWiSmTQfPdoqNdA0cIucv/KTrX3BGePdEF5ZtBfReRlS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(356005)(8936002)(82740400003)(110136005)(2906002)(86362001)(36756003)(8676002)(44832011)(70586007)(4326008)(6636002)(81166007)(83380400001)(7696005)(70206006)(16526019)(186003)(5660300002)(426003)(2616005)(316002)(336012)(36860700001)(6666004)(26005)(1076003)(478600001)(47076005)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 09:27:55.7987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82435303-db57-4392-5725-08d93a1702fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2489
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During GPU reset, when receiving a DMCUB OUTBUX0 interrupt,
DAL code will set it to be OUTBOX interrupt and sets hw interrupt.
However, OUTBOX interrupt is not registered yet, so a NULL pointer
access will be executed.

Call Trace:
  dal_irq_service_set+0x30/0x90 [amdgpu]
  dc_interrupt_set+0x24/0x30 [amdgpu]
  amdgpu_dm_set_dmub_outbox_irq_state+0x22/0x30 [amdgpu]
  amdgpu_irq_update+0x77/0xa0 [amdgpu]
  amdgpu_irq_gpu_reset_resume_helper+0x67/0xa0 [amdgpu]
  amdgpu_do_asic_reset+0x219/0x260 [amdgpu]
  amdgpu_device_gpu_recover.cold+0x8c5/0xb64 [amdgpu]
  amdgpu_debugfs_gpu_recover_show+0x2c/0x60 [amdgpu]
  seq_read_iter+0xc2/0x450
  ? do_anonymous_page+0x22c/0x3b0
  seq_read+0xf9/0x140
  full_proxy_read+0x5c/0x90
  vfs_read+0xaa/0x190
  ksys_read+0x67/0xe0
  __x64_sys_read+0x1a/0x20

Fixes: 85465bd6dc6e drm/amdgpu/display: remove an old DCN3 guard

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index 5f245bde54ff..a2a4fbeb83f8 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -119,7 +119,7 @@ bool dal_irq_service_set(
 
 	dal_irq_service_ack(irq_service, source);
 
-	if (info->funcs->set)
+	if (info->funcs && info->funcs->set)
 		return info->funcs->set(irq_service, info, enable);
 
 	dal_irq_service_set_generic(irq_service, info, enable);
@@ -153,7 +153,7 @@ bool dal_irq_service_ack(
 		return false;
 	}
 
-	if (info->funcs->ack)
+	if (info->funcs && info->funcs->ack)
 		return info->funcs->ack(irq_service, info);
 
 	dal_irq_service_ack_generic(irq_service, info);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
