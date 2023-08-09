Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A25C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 11:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CCCA10E034;
	Wed,  9 Aug 2023 11:22:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881D610E034
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 11:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmr4sMvMTyV9Z+3wzlQny9aIIxgBTR+dv7q1gBU5kiY7ciuy6hd7PFjFSf0Qkx9Vre6Qqfp3y4r5T/hCLc+lIUKMsDfzD2kdKmnX3Q4jr8ugKqhtCMPLCg0LhKLa0jLQE47jgKflTYogJD/E9gvGf0xCh9WXYwJQBMPewRqesRMM4WpqFZoasTKU3TR250WOx5f/TWvWtSFj5UAhAB7u3U/ts2jje1sUsdJl86GbRftoiS/1yLwi5uAB7e2VVCILzgAFBqUVceLrqRR+/NZ2CCIedcZnYlhDGBMJOtS96qqxTBaCNZZHT2V2kCe8mdzfjLJCJi8ebIti0XICc1g2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc0Kz1LzkUV5pnW95eQnp8R7jmlQ0FgyRpalP0ROc8U=;
 b=BxfK/7AuOulc57ZFvXMmJIQpOG7D1psxRdbFPqbCaIuZghs+I/zeNvZswR8reBasPDMmxZk+5HAmWhIkGW+HpSjXuP6n81cl0a4K0Cnc8Wc/mM7fRCmz0d2wrBZ9Iatv+sbqqq0Wn0+f+vcZWMQsitPB9qh2/yUQ0Mw8MdO3JF1PQ1y+kGCjVwh38yl8EnLEV2u9vldpaMiFhXJ9z+LgcmKrrEPh1nK1GizoBO1T0yy+zxtyslKEIvPZuktzK6D4cIoYZxGJdqTYN2lQYj0uS53OL7TM8yhWLYGEi/iCRZilwG05aGbehrrJoBaX0cubzfJUFh3fGHPo150IpFVGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc0Kz1LzkUV5pnW95eQnp8R7jmlQ0FgyRpalP0ROc8U=;
 b=r/2OF4YBsyH0w7CJIXoOLfSmPSWUI8iyCYOAq4vwGCWhPCul2eH8WMwPks7lxQmAZm+iF+rTZJxGyiA2ZP/2r1fmLJ4WtQt2wc4q/mnIs9HT8L5FriiSWPU51454HIbTO+hPLN4OtIn30Q2zczDZ6OzKY8FDEvo8MIzvTUtgDTw=
Received: from SA9PR13CA0100.namprd13.prod.outlook.com (2603:10b6:806:24::15)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.25; Wed, 9 Aug 2023 11:21:57 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::50) by SA9PR13CA0100.outlook.office365.com
 (2603:10b6:806:24::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.18 via Frontend
 Transport; Wed, 9 Aug 2023 11:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 11:21:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 06:21:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 04:21:33 -0700
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 06:21:32 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: Remove unnecessary ras cap check
Date: Wed, 9 Aug 2023 19:21:30 +0800
Message-ID: <20230809112130.20535-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 209978cd-327c-450b-b4f6-08db98cad75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQrLKRcZaSBgklzN8na4QJyWZANJl8msxY/2GiRJhzQiV1Bsvv7rUeNxmiIrqpc5E3OJXmuZTVR6fMBUwXPDg1tvtUK8nfLHpiJChVI7z5vM6sG30fSkQDL4mHrOFuzNnJyLMsZ/XA7c16e3YJr/2wSJfxSzQsIG/Vu9ArSMn0GYq6omzmpYWdnjKBldyy3lAdlg0jC6jdCxQuHcwlhRkZqEowQxgexnNFUE0Z4ecV/yiTTaBYrmZ8lndDiB9eGAdZJRhGyWq51QVpP5LRiy+7ps5s+79ZfNJSk4+3S0tyJ1imi6QR3lkikiszIGatevJA2Z2nTtzh7JJ6Y4XuHCcANsTujVmih89xARv2uwkmaLbsILgGUy647lubm3igY3eRYNc6TcW6WV9LK0tPQRrTvGVfEw3XiXmWxg/FgIAI5Hp+0vEAuX+2KgsxS5Q4LJkDhFgZH44NeKOpF2bMVehMLqyKDanPSVhCiS0hbrJF7unZ9BywCObjQ4LFEhws6vEAKmww+GIioTzjwaiVNzNQ2mIhr9wi0eZGahjAyasjppuRabJl5Ro1GIqfr6vnrdnZsqaXQDH9sWIi1CK1XVgD6ltonR3oBPISud3qCR8rTyEAKaLfBMQjNcuLDIizxd9ZaByXddvge4e0ErZGxWl3DzTO3IHei7E74VSx5cH2lNanUq1H5SjPDYOfMnprxi81htyRPvLUwnr5WwHE9SQj94rn3YpshCKk+X0Pda+Zme0S4nsWXY4Z2q37TRKq3ejZVvOgdqRvEm+6RuaPJJxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(1800799006)(186006)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(70206006)(6636002)(4326008)(2906002)(70586007)(316002)(336012)(7696005)(83380400001)(4744005)(5660300002)(8676002)(41300700001)(8936002)(36860700001)(81166007)(356005)(2616005)(110136005)(426003)(40480700001)(478600001)(82740400003)(26005)(36756003)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:21:56.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209978cd-327c-450b-b4f6-08db98cad75e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS global isr will only be invoked by hardware
interrupt. Don't need to query ras capability in isr
In addition, amdgpu_ras_interrupt_fatal_error_handler
ensures the isr won't be called from guest linux
side by accident. The RAS cap check in isr that
introduced to fix sriov crash is not needed any more

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 00658c2816dc..c58b31121fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2970,10 +2970,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
-	amdgpu_ras_check_supported(adev);
-	if (!adev->ras_hw_enabled)
-		return;
-
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
 		struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
-- 
2.17.1

