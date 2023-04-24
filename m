Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942ADC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 19:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CACA10E1F7;
	Mon, 24 Apr 2023 19:38:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63E210E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 19:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO0v2sF253+UzuNg/9mHtywp7JgMsGiVmlarPOB/Z8HBegIFVryiic2A3pqXTyc+jeunUajaM/tQqglnDY3GdpVbLHjVF3qkRHE3AjTvdR0El8pSg9XExxKWUF5scU49sBd3DTw5TgKborIhMX90EwvWOq+Ezf4L3PumDflaC3BpYDyWS7nPtSt8mg0jYMr9NjNHB+r0Iab57/+nFmFK3PaFMT2dEEC229dwSqri36FgINmqpdjnQgKkiO8BV/y5DD1GwY39VvDc5K7rE6L+2Ys02bYy3zt3WtXoCMP4jHehRGrCFRNk187TKyyyNjYXESETy84FkvLoGG4UNYTa0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub3tE4oVVLI3STELRCooJsvRKIT5Z+Z6xJCghyvYb10=;
 b=gUExQZ9Z2B8fGDt/GBSN2fmXZ42qAXEsdbCHudu9OMOZNPGr9oCMaB769sOu2Np5p+5nKxqoJS83tlfQCGMQBM78eTU2nRzN3CNLYh4J3/bDcDeWMbcUXLNGCc84XK5/NyK3+ZhvFMWMZdTCLPXRMZIH1uwsTp1VE/L92Hc2MGhXjWgrujfeFYyVZWS/6LFW+u2T6nKpSP9PXRbXAQAB+au3pB3EDPkdd4Cz5ikMcPtNI3vhFnuCr/i1jvyLu0e26wnWdJ8S0sJpmKM/1PCWw+GukAbgc5xIOnP0kMWZXhUbVdOGVWWggjG+60KrQlFRc5DvS2wvJNCz5Fcz8nynEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub3tE4oVVLI3STELRCooJsvRKIT5Z+Z6xJCghyvYb10=;
 b=0jBFizpby/f5r4Ih0cRt/0eXKPE3Te1w1y8Vr5/HfkGk0lFLORyqVYGNQb2+D2tuMhblE4iXpyw9NQpbELwvAeUWub8bjQt/6G31xDaHl/9VQLNLruDXWpPXXIiSs17ohH+6P8qtUa+2D2RfeY/lxzcG25X6mUDEPi6BUVRc0Tg=
Received: from BN9PR03CA0487.namprd03.prod.outlook.com (2603:10b6:408:130::12)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 19:38:28 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::87) by BN9PR03CA0487.outlook.office365.com
 (2603:10b6:408:130::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 19:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 19:38:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 24 Apr
 2023 14:38:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Optimize svm range map to GPU with XNACK on
Date: Mon, 24 Apr 2023 15:38:08 -0400
Message-ID: <20230424193808.10383-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e648521-604a-4f07-dce3-08db44fb7a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ff6BJZ/S1gRnp6KngQDzeWQOzF/njoq+D9RqZuS+1BYG+pWbT3CYK4Ut8vqQrdlmky9QAvkhDVRmp+BVb1Ngmu2YrLoQDyLzbd/PvVyE4jWC7ar/pVbpfXhRHbtlx/dJnn8+OhrrKfQYJ9+s083hbw7G1sikOOju6ZKk2n/d362C8TUzvJe8F6c+xFomOaDUC49TIB+6l/SBscc12ob0eWPZSSK//XqxvjT42D3HWt1BjGxbpXjN5RykSfXljpSapc+ytjROKam0YXAlsMmnzX2IKKKiTO9rOVXqOe9lyI1h020oK8BjafufzKLapLaTiKRXYHId9sk5yLGU5aypJjHqZEVgeJ+QQoG2RkeFVW4Aovvtzc7FkRvtU1LrHG78I55p2HUBFDBM6uDtA4u4zBz8jh26zw8i3yoveR+cK9vSbN9FtIwfd49USDFH9DDZaogWfkdEq58UvJZUUPStUJfj+8feRfKhZcxOmwl3RXhsX9kF0gV3snb3XLsNOT/VSLoVoem+BFRXJbGsarkQTp+1sJa5KDEU1vCRBJFCfdccNgcPc5Zc8N68MEjlfFXA8HCBehFwQXfBYRUXCh1/kNq3OdJiLFyCnaiG4rKCLjBlp5jZqaI+h42koFGZLoRkl3rXOnjP8fUXHMlz6xze8uqkQu5COZiihGX06Ip/cA+8smjAI7ts+S6kra38/w0L4cW/vU3uHQbfWrGMi8dg2zhWKeA8WqBkTW+Z+g5fTNU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(82740400003)(83380400001)(2906002)(36860700001)(40480700001)(26005)(1076003)(82310400005)(316002)(6666004)(4326008)(6916009)(47076005)(2616005)(426003)(356005)(8676002)(41300700001)(81166007)(8936002)(336012)(5660300002)(7696005)(54906003)(86362001)(40460700003)(478600001)(16526019)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 19:38:28.4088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e648521-604a-4f07-dce3-08db44fb7a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With XNACK on if svm_range_set_attr set the range access or
access_in_place attribute, we don't call svm_range_validate_and_map to
update GPU mapping. This avoids prefaulting the range pages on system
memory if the range is not prefetch to VRAM and not mapped to GPUs.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 129ef44f41e9..af7594b1b4c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -734,7 +734,9 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
 		case KFD_IOCTL_SVM_ATTR_ACCESS:
 		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
 		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
-			*update_mapping = true;
+			if (!p->xnack_enabled)
+				*update_mapping = true;
+
 			gpuidx = kfd_process_gpuidx_from_gpuid(p,
 							       attrs[i].value);
 			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
-- 
2.35.1

