Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF4CC48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD14261364
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD14261364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00236E5CA;
	Fri, 11 Jun 2021 07:05:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E356E580
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9DdXcepCT98mxtVmNVVNqxwkApgNLWxwnVGacYA0deqNLI3LVCGfeLq5oL1IkP9zfcbGa6kgB6FNH+34afJpTXwS8dmXuU0hgWfq6o9urYo6WIgEMV0MFBpAQxHYYcCqGvSfnxwLupVQXNKYldUbq9TbvEjVhRWo4948ro61nDIJR/fGeBkDhz5YbsFpuTIaxF1fWr72soBtpXtvyB6B6APZZQjhxB5H/DlGG28IWLZ+jf9jm1hWvatBMRCtfaYOEqM+4LK9oVW1x+O5pHaiT/7vjMYcLash3p6GnNH1tCdHBDriCtUcAggfVjhsghLSt649dMKjL8zb0lWz9Si9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aniGI39vVF84y10w3Alf3i1rGc3zLKCb64E7Nw3qkZM=;
 b=NIOFagB26qBHyvYra838LFFR0M+Vs1+PTVghpFXG0M3W1k5X39xaFKldOqbcnfoYT4cXEffy7WPxaCdFaJ57zrl84OR05Ht9XsvuU7OJgEhh1wAIXfr9RPNAhbcCcLiipphM1qkKMy5EGm9WHTluyanwTjguciU7ugDhyyPC8Gh/3qYDVTK1ouford7FH06GSDUdh81oAb5oySZG/n2AAJW2Jv/nldonFq+lU37RUb+z4WfutOb/PwgzbSXq0m6hv0jzidLYKOAUUDWU3vQITcz+WYaudflbn1vsMyYzlTnAzwri1/YcbPpD5N3eYHL8hk0Nk6+YTaiUuRLGhifonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aniGI39vVF84y10w3Alf3i1rGc3zLKCb64E7Nw3qkZM=;
 b=4cpF6KFRL39UKxCjxf2ORIQ+oHlJPgPHlc0dIyD+687S611bYbRLkvfym6Olg1omfccqrlpiYAn4yRkynVWxOZnsrp0k+M/D0JB5h8NU4PIvpYlaUodIfaFDkOfJZTggQfL2+ElggXWbXhBQDiqWFRean3ZwM6eA/HcepmS5X4w=
Received: from BN9PR03CA0583.namprd03.prod.outlook.com (2603:10b6:408:10d::18)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 07:05:50 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::53) by BN9PR03CA0583.outlook.office365.com
 (2603:10b6:408:10d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:50 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:49 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amdgpu: update psp gfx i/f to support dynamic GECC
Date: Fri, 11 Jun 2021 15:05:39 +0800
Message-ID: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ec94ed-186f-4fca-d012-08d92ca75880
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:
X-Microsoft-Antispam-PRVS: <CO6PR12MB542599B5F4E69A1FD9DAFE34FC349@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mco4AkxWUF+inqhgypjRv9gIDtwJa95F4lV4btqgZH5wM0Md48ubEXrXhc4ZvrdL+1b6PwYeTdilPPKnTAxxQrfl97OyYQddIUyG68Biv1JslCDOANwRuqX6IVmY++kzZFiwGE2sC9LoIoJQ5YFP7C1kexhlgYcm7oRAJI8Z/MZihoppmJteF53rygHD0JPgWkSopr4kQ0dpXpe0s+xM/8MhMAH+IWzgPA1YS0K5ASh9XBm7aPK9teOXbRrF4vvAAJ1CVD402gG/0vw5rzu5L6/eBKEJiEaVRWFCpggWx0KqkdK8l5zl3E7g8+odPMB00Vv9oOa6z8GGyLAqzSIDxyP1zS3NSLq5ZVnYaB8ZnsGvj2Gvqxw1mzbFT+r62QaEXSpIIgTK2bHTM1xGNuTFYhFBBSUGZsqCncQlM7figh0AvyJAO+/fNvzi3WB+YKve8Nk33Oj14fIoOf04MmK+OvePgHlSfS1MS/+O/q7PvWg4rGe7x2K7YbqBJeDYsFjdhqJs8CYgqLNtcNKt3VvsLjIbW21J46pd8iKopxeElJHu3Aj1TmnfGlsFvSbxAnAVgG6ukGGIARbL2onbpShxTSICbf8tgLBZ5H9vh4tIK/ZSbBfxVvfuuGI9RjZ5ZH17FCuIWvajfotcdl2OwBeLpk7ozBDc3PN30RD/mmu9RBAeyGvN5oX+ug3QK2UchCdc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(6666004)(7696005)(26005)(83380400001)(36756003)(4326008)(36860700001)(2906002)(186003)(478600001)(86362001)(426003)(5660300002)(82740400003)(2616005)(356005)(82310400003)(316002)(81166007)(8676002)(47076005)(70206006)(70586007)(336012)(6916009)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:50.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ec94ed-186f-4fca-d012-08d92ca75880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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

psp_gfx_uresp_bootcfg is used to inform driver
bootcfg settings maintained by tOS

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index f6d3180febc4..dd0dce254901 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -332,11 +332,16 @@ struct psp_gfx_uresp_fwar_db_info
     uint32_t fwar_db_addr_hi;
 };
 
+/* Command-specific response for boot config. */
+struct psp_gfx_uresp_bootcfg {
+	uint32_t boot_cfg;	/* boot config data */
+};
+
 /* Union of command-specific responses for GPCOM ring. */
-union psp_gfx_uresp
-{
-    struct psp_gfx_uresp_reserved reserved;
-    struct psp_gfx_uresp_fwar_db_info fwar_db_info;
+union psp_gfx_uresp {
+	struct psp_gfx_uresp_reserved		reserved;
+	struct psp_gfx_uresp_bootcfg		boot_cfg;
+	struct psp_gfx_uresp_fwar_db_info	fwar_db_info;
 };
 
 /* Structure of GFX Response buffer.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
