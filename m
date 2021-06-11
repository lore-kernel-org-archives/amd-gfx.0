Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA7C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BCE61364
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BCE61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A769C6EE30;
	Fri, 11 Jun 2021 07:05:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DFD6EE31
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbQX32gc3jkV3rQ5yRij20+q6a0cavaqueXyNBKjgIGYa2rTW0nKHYX3FdbZukamKgVfwdzJ8ttbp8z5ShXfYESPDtgzeoNGxarggXumaZmjgvJT0M4nc9Mv7ysaWyzx+fvxdLDgDPnM1lNan9im1/U1y6p6qxOsOtUjKMQ3g0AdBEAcCvPWmuaF7bpWKrwlgdAai6ESkDAXsKepbw5kb9ADw+4CEN1mbcH3uZwkSCObIkg9x8SfFI/0HTO5MbbnoPOuX7pO5fYHTPj67vhLj5z9znX0joq2FS66TYutngKLTvx1NNYJ6LYg1ZZA1jky+9JH+MD9D5ohubIDPw9AVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYYPlnYyRz867uXZ+T/4H0R08doUdhhRBa1dKv6dMQc=;
 b=AETnLA28QhPU58Ob6eM88fP4bhq2tROZCnTiNYQKQNcwHHzA8XQPl4BDg/StU5w6aql9VlbMRplcakRzzUfg5G2LsCZ/8IkxJ+XhreDqrkdKDtTMk50mKjNE45768ikU98oJ5JsIoICDRH/q2a4SMyqppO9YJksdg+71DDPO6HoTykjabeXPrQAN7K5MFayB0xloF5C53tvfFr2i9LB88S+2tY/CS3WYgz3HIC63zKT9kKK3afzy4+Xifw99R0n38AfwvferFbwZxfYDhnf702FF2dr+e1usItwc/PSCUy3F3eozp1fGIy9EvSUqyXLi4YcHsRitdj1rv7Qh2hjmTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYYPlnYyRz867uXZ+T/4H0R08doUdhhRBa1dKv6dMQc=;
 b=1POcDovB/P5u1XN/IaoZPFMtmo9EFlqkuk62/II+IOmPyOUuoeA8S7eELobn1wqLTDEtcIZZVm7PA5dWCxnapjM2GqBfxscf8Vkbv0AmX1+Dv7h6Y5kud1iDEbXunSB0DIibrMifiEvadvm+ilkkf1do7RL/HXxs6INpRT7eNyA=
Received: from CO1PR15CA0077.namprd15.prod.outlook.com (2603:10b6:101:20::21)
 by DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.29; Fri, 11 Jun
 2021 07:05:54 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::e5) by CO1PR15CA0077.outlook.office365.com
 (2603:10b6:101:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:52 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:51 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: add helper function to query gecc status in
 boot config
Date: Fri, 11 Jun 2021 15:05:41 +0800
Message-ID: <1623395146-2162-3-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9aab8a6-c4ba-4d61-9a46-08d92ca75aa0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3721:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3721C3252886DB6E9049480DFC349@DM6PR12MB3721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/KOb0JzTZmOMKrJllz64j8aijkc5tUmFvqpItOyGcQYdHPuOYWv9Tpk5jrOV9yEF9WdVoOBVWcTAripcp+ToMnraltIjh+jBcVfvtU65PAxN0k6YIaaaHSIkMOfVlKZ+hBR4dthnPnpFg30kdVRNveB1nJePBPCq4Q1BuQ4AtXUMZxsvmW5eeDFdREWbruXQRZkD/wRtvF6AH+capofxW05DYtTiYGwvT1gXn3VbsqNYIaAn57qenAoKElewj18VZ1gXlcF3MhJ0KVednQh12ir7EF2Q95IW5uKD/kS0UY7anTnCMwBJTwqxvyq9ra+vNIAyKqasMgsB7aRp3WbRwwnB0r4MnZLIdUNeLFKpyOc1sw+gERHt7lbTi2s/xi86KjKfm4hfuTHOYzCtRzU4Gtxl3jy/tcKw+sqIxiwQA0OhKG78M6F9KVp22YcF+kf4TJUHGCM/2lgjhlILR7wC1rYQOgioiqr7+rIKJv/LwrDz/aF75qEs09jopW+TgZ1F1td8pSdC0/giNZVDqVg7UeLd7OtOnQ2jLbP+AOcIK74UydwvF/5i/zysDRkqwQ4GAjFGaJr9UuPZSwP5kB5ckRAv1TuOVu5/UqvK+E9VTUZrbZnFV2V/4byepOMFxQzp3e4zi2wabkq9Cw9+CTsFImSe2oFnMEnoeRmthCj25I0WY8Dj0+PMrgBsfAz2TO4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(6666004)(36860700001)(336012)(6916009)(2906002)(426003)(47076005)(82740400003)(356005)(4326008)(186003)(26005)(70586007)(316002)(8936002)(8676002)(70206006)(5660300002)(36756003)(81166007)(2616005)(86362001)(7696005)(82310400003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:53.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aab8a6-c4ba-4d61-9a46-08d92ca75aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
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

Query GECC enablement status in boot config

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a8856697733e..d509d52dd235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -535,6 +535,29 @@ int psp_get_fw_attestation_records_addr(struct psp_context *psp,
 	return ret;
 }
 
+static int psp_boot_config_get(struct amdgpu_device *adev, uint32_t *boot_cfg)
+{
+	struct psp_context *psp = &adev->psp;
+	struct psp_gfx_cmd_resp *cmd = psp->cmd;
+	int ret;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
+
+	cmd->cmd_id = GFX_CMD_ID_BOOT_CFG;
+	cmd->cmd.boot_cfg.sub_cmd = BOOTCFG_CMD_GET;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+	if (!ret) {
+		*boot_cfg =
+			(cmd->resp.uresp.boot_cfg.boot_cfg & BOOT_CONFIG_GECC) ? 1 : 0;
+	}
+
+	return ret;
+}
+
 static int psp_boot_config_set(struct amdgpu_device *adev, uint32_t boot_cfg)
 {
 	struct psp_context *psp = &adev->psp;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
