Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024F3C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 21:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF9010E10A;
	Wed,  9 Aug 2023 21:27:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9046710E10A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 21:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mywth/Mkh4SmjypZkHN0+d3yIgGBb5mqKrgMF1iGCFs5JEPu+NgiYb7LW7Izf+x4yVXjrXT28CiE9KYjMAcB2LTFrl/5qcHCM7KBSU1u5qoZj0hEq1/Zvz+/uOZBydxQnmkTJgDVAFhDSxBG7QqOsoma95MtWiy81R+CFkIforIw7ZytGkCm4hnv5JnxXdldhZPjEPayRiRiGJWbF5b755n+vuSW0g5F+8M0i2p3aC9ZsPIvNlny2BsPFe+bM7olBlAHqBK3XID34V9qAd2d+F+aFMFWJE0AkdbKbvokaf7QRWzDuEMyjoue4z4fDfgjtHoMzJkCTIQZOOa9kbU5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ptOrPyavRpPJ1e3TIg/h0v46J8svYwft6IAO4pGq+M=;
 b=fPdw2easKeK+442xz0U+Dnl0Qsb/So/WOnEbZ4l85tGvaUn/XCLwKV4dDdiV6WgrE0c6tZc1LJVhD3IoVtUdjtqNv0/Y99CLnjyOFSgUGPeBJQAXLdb48w8jn6QCbn+zP0I47XYmddyfmkueAcjF6gE0DkqLIEckgSjX+47H2g5kXyOS3VLRcuJrPXm0klRyZxgTkt5XxgyDpGnAuASAJV3r0HkYK5kz/Mptt4WmjhMCVVkwPBvcZWPU53CGzAT5tTrDDNTOMhKmph2Zkdk3vIVICPbIrEB4Vvxrzu7jsKwVAvoEoZWKui3F5XvqjeVzh4MOskFqgQRkvjL2YzywbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ptOrPyavRpPJ1e3TIg/h0v46J8svYwft6IAO4pGq+M=;
 b=TUbbL2tVyE79z/JxShmLjp9+5ykTwbaa+KWa+CS93msTHieLx51AquYSvXPlXM02Z3rbpD8+AAvYs8FxybWIOdldXRXQRFqcPf6jCngX3sGMpxMygOUPPqeJz0bqMTgpfHWj1EdZhIk9DAu+uAFsd0W8Zm6SClSpuh44LhBDpZ8=
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 21:26:56 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::3a) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 21:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6678.19 via Frontend Transport; Wed, 9 Aug 2023 21:26:55 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 16:26:55 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add missing tba_hi programming on aldebaran
Date: Wed, 9 Aug 2023 16:26:15 -0500
Message-ID: <20230809212615.137674-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 74944bd4-7a9e-4f24-99e5-08db991f5b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdBhWlvsM0Mvf6Po8DuqjH4HnHfmtxz05KuLbkcj9H8HzPQUHd5JZaGE9JZrG+mckQakAZKq8Cv2tEA8/QuT7OdolI/Hqh+7Oa9zrdeeRzbwOfPEcIFssNgREF6+f8siGQCdTta0DhbPIpCz7xgqQRyRpwHN0f5SXvumtp2zeDeTi8MpUp3/wTIpZpBGhEBa4ZlsiMaKdqaOSjw25xUiyT5rpzcEUjNJW8igkqPMN/J7cQSRTHT/vNZ4uvNtej4+Wsbuuek+JGMHREwuivgmXr0jiby+/Nw9iQe8cLTGtTytpAZj0wMoJfF6UpR+i2OqZ+vk4Y6fAvUpRXdHYFMnS1yLJBUxwkwocm5tAkknBMYIWTMztJvmbP/Dm6zRe2SarKBwABTby6kz88YJ6T5qdh6Rujlnbdl5Xm0rOR5Px4KZh5wmOSISAcFwQmyxVeEszd9Y6zN2oqmznDil3MYHJvbRLCsdzGIErS4nmYmczuSuhsb/+D9Ds6Ycy8faquXDbsK7sxYsl406dwwo3rop+104/hkWImqnoudV063M1ExxKZTJFqVN2c3Lw6zGSNIbr8O/yjTZ/xT5wCsXeHpMUd+DIcHI6nW5NF7shVNt5um85SfD9zVP/jVg7IksJ8YyOdvzXSRZGBOq/E+S3NgQ3L/v5x9AEltDhn6p8WUM6W+VKnCQ3jJBqItketILQq53neUxGpENAIk0LuFGeOJToaDZulVRjv+Jk1HwBdXwHFbcKZWQPWjKTFSAvcgS4AlrmvV7dU44Bvd8HWcr289+5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(1800799006)(186006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(82740400003)(86362001)(26005)(1076003)(16526019)(47076005)(6666004)(426003)(2616005)(356005)(478600001)(81166007)(2906002)(36860700001)(336012)(4744005)(7696005)(36756003)(40480700001)(70206006)(44832011)(70586007)(5660300002)(8676002)(8936002)(41300700001)(4326008)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 21:26:55.6085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74944bd4-7a9e-4f24-99e5-08db991f5b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
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
Cc: Jay Cornwall <jay.cornwall@amd.com>, harish.kasiviswanathan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Previously asymptomatic because high 32 bits were zero.

Fixes: 615222cfed20 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fda16e6fee6..8ce6f5200905 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -121,6 +121,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 	packet->sh_mem_bases = qpd->sh_mem_bases;
 	if (qpd->tba_addr) {
 		packet->sq_shader_tba_lo = lower_32_bits(qpd->tba_addr >> 8);
+		packet->sq_shader_tba_hi = upper_32_bits(qpd->tba_addr >> 8);
 		packet->sq_shader_tma_lo = lower_32_bits(qpd->tma_addr >> 8);
 		packet->sq_shader_tma_hi = upper_32_bits(qpd->tma_addr >> 8);
 	}
-- 
2.25.1

