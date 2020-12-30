Return-Path: <SRS0=0XED=GC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D400C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 06:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26B121973
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Dec 2020 06:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26B121973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A468935A;
	Wed, 30 Dec 2020 06:45:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A7D38935A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Dec 2020 06:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5nSH0qLdQRLnsdvQOVjO8ykpY7alYQ26pPvgxfr/g1T6ef6n9j+XqSI5uUlutHvdEdMnZaoBO4SJ0BO985z+4dz7TOMOLEVYpSCPWA2wup/kobHRqBC+jxfIo7NeL/d7ii+es0hjYVBwkqEPyJlk2W+YFCQaK0+kmZT73IY76xltCCSSTQdZRcSrqrdpy4JPWkJj+tkeGFCkttE7owZNdSni/tn8WR3DWa+BDIiYonLGirVEPID1vvvH02y70YHLU0KsUDABx5B8XCp6D4+r0F8vfFMGZF0xmFL6WfHLLbfdtiwkzhW9MlGsWVp0pZiRv+I/bnDhyhEYpJaFxwzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq1bUuj6iSqh/xFJ4H+Zeu0/USQd+nFkdZlcdaoyhQA=;
 b=IaPlfYhUhKxRZowRg3eDHmT1VAPf2ETHzJwCfRjL3e5MyrSfm2KWXjAbiCYCjrTL6k1gdIK5eVdC8K+CLDoxd6Cx2r31/eRYvcWwKoGkRh0uqOcdLuK3M8KLXIAhCAs6iLQpWcbMF6sq4joYOSee52dtQaxXzri+yD3uj1ZAflVIykzxCh/S/2tJY3ht5kbJ+rC5/UZulzdxaK11CrDBSZR70725queE2OaKQThhNX0OxXcakLRYlKpxWrFNwpzW3Afc1gtgLP1j6qqX/n/7fwyJcdJ9m/0/M682K95Kn3DzUZ3DDR/+ULYxVSTOT7pbiRjp6SEF9nIUje2ySnVopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bq1bUuj6iSqh/xFJ4H+Zeu0/USQd+nFkdZlcdaoyhQA=;
 b=O14Z1acISCfIOfG9AdeY1M5wLtR4q5VNH5RgoyobzPCeReEygvTVx8l3Vj+eRC+zHJgkX/Nt58+oKgsGeKRwVMxGTjS/vnKy+kmy7IZ5/GOfcQd4Bh6Z9GAXxsGcJ96e1C7OHxuZyJXt2o+X6wVgLDPo2GbAiL8HGltR0E2VNpQ=
Received: from CO2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:104:2::21)
 by CH2PR12MB3944.namprd12.prod.outlook.com (2603:10b6:610:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Wed, 30 Dec
 2020 06:45:47 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::f2) by CO2PR18CA0053.outlook.office365.com
 (2603:10b6:104:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Wed, 30 Dec 2020 06:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3700.29 via Frontend Transport; Wed, 30 Dec 2020 06:45:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 00:45:45 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 30 Dec
 2020 00:45:44 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Dec 2020 00:45:43 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <John.Clements@amd.com>,
 <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix a memory protection fault when remove amdgpu
 device
Date: Wed, 30 Dec 2020 14:45:34 +0800
Message-ID: <20201230064534.6224-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ddfc322-2445-45d3-d105-08d8ac8e8947
X-MS-TrafficTypeDiagnostic: CH2PR12MB3944:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3944121E4483BA1EA75D8734EDD70@CH2PR12MB3944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDOCv1qtJFonpVvv9ztlW60Oxb0U12BFRrdJIcCxN+8d7gxrr2hI/K5NssJWXmiFT+oYjVySeRybqJ+W7Kq6pmS1eu638xmvb3xKyzJpT7wxRFdYjQ2kYmdxHqakOn7YrWFgPI1jpwTvmkloaV2FD7yNBEcww+X3mZTm6YAe2ZLKtWUv7kDTJawjJHLhXxdnrcRjk62ik4CTBEi0TPMrgUqcMykZTJp1QpCjc+jJOU46RwEzNIIQUAKUJKONs0vYHusrozMq+bKIpyPCAVzfX5o/zOPcqsm8QzM66Fu4iBm8ox+ItSNCXEQREdj4BPMQEp71PhOHEdfaHpvTfCPtmMbcACmivx1IQ7NUqKyQWH38ZvZeKRI5nDc4hRefHIAvi5A7SCQdvRG2Oy0PEpkCuhJ6xjt7G77btNeUGUABDksODCv4Lc7JVS8DrSXcN2Nn2ukHe+UVgBftFYC+5UIUTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(5660300002)(186003)(2616005)(36756003)(356005)(1076003)(6636002)(478600001)(110136005)(316002)(82310400003)(4326008)(336012)(86362001)(70586007)(8936002)(7696005)(6666004)(83380400001)(82740400003)(26005)(70206006)(426003)(81166007)(8676002)(2906002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2020 06:45:45.9854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddfc322-2445-45d3-d105-08d8ac8e8947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3944
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ASD and TA share the same firmware in SIENNA_CICHLID and only TA
firmware is requested during boot, so only need release TA firmware when
remove device.

[   83.877150] general protection fault, probably for non-canonical address 0x1269f97e6ed04095: 0000 [#1] SMP PTI
[   83.888076] CPU: 0 PID: 1312 Comm: modprobe Tainted: G        W  OE     5.9.0-rc5-deli-amd-vangogh-0.0.6.6-114-gdd99d5669a96-dirty #2
[   83.901160] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
[   83.912353] RIP: 0010:free_fw_priv+0xc/0x120
[   83.917531] Code: e8 99 cd b0 ff b8 a1 ff ff ff eb 9f 4c 89 f7 e8 8a cd b0 ff b8 f4 ff ff ff eb 90 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 54 53 <4c> 8b 67 18 48 89 fb 4c 89 e7 e8 45 94 41 00 b8 ff ff ff ff f0 0f
[   83.937576] RSP: 0018:ffffbc34c13a3ce0 EFLAGS: 00010206
[   83.943699] RAX: ffffffffbb681850 RBX: ffffa047f117eb60 RCX: 0000000080800055
[   83.951879] RDX: ffffbc34c1d5f000 RSI: 0000000080800055 RDI: 1269f97e6ed04095
[   83.959955] RBP: ffffbc34c13a3cf0 R08: 0000000000000000 R09: 0000000000000001
[   83.968107] R10: ffffbc34c13a3cc8 R11: 00000000ffffff00 R12: ffffa047d6b23378
[   83.976166] R13: ffffa047d6b23338 R14: ffffa047d6b240c8 R15: 0000000000000000
[   83.984295] FS:  00007f74f6712540(0000) GS:ffffa047fbe00000(0000) knlGS:0000000000000000
[   83.993323] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.000056] CR2: 0000556a1cca4e18 CR3: 000000021faa8004 CR4: 00000000003706f0
[   84.008128] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.016155] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.024174] Call Trace:
[   84.027514]  release_firmware.part.11+0x4b/0x70
[   84.033017]  release_firmware+0x13/0x20
[   84.037803]  psp_sw_fini+0x77/0xb0 [amdgpu]
[   84.042857]  amdgpu_device_fini+0x38c/0x5d0 [amdgpu]
[   84.048815]  amdgpu_driver_unload_kms+0x43/0x70 [amdgpu]
[   84.055055]  drm_dev_unregister+0x73/0xb0 [drm]
[   84.060499]  drm_dev_unplug+0x28/0x30 [drm]
[   84.065598]  amdgpu_dev_uninit+0x1b/0x40 [amdgpu]
[   84.071223]  amdgpu_pci_remove+0x4e/0x70 [amdgpu]
[   84.076835]  pci_device_remove+0x3e/0xc0
[   84.081609]  device_release_driver_internal+0xfb/0x1c0
[   84.087558]  driver_detach+0x4d/0xa0
[   84.092041]  bus_remove_driver+0x5f/0xe0
[   84.096854]  driver_unregister+0x2f/0x50
[   84.101594]  pci_unregister_driver+0x22/0xa0
[   84.106806]  amdgpu_exit+0x15/0x2b [amdgpu]

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Change-Id: Icc981a421499dff844855d5a662e91d1730c2754

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index eb19ae734396..b44b46dd60f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -564,7 +564,7 @@ static int psp_asd_load(struct psp_context *psp)
 	 * add workaround to bypass it for sriov now.
 	 * TODO: add version check to make it common
 	 */
-	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_fw)
+	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_ucode_size)
 		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
@@ -2779,11 +2779,10 @@ static int parse_ta_bin_descriptor(struct psp_context *psp,
 
 	switch (desc->fw_type) {
 	case TA_FW_TYPE_PSP_ASD:
-		psp->asd_fw_version	   = le32_to_cpu(desc->fw_version);
+		psp->asd_fw_version        = le32_to_cpu(desc->fw_version);
 		psp->asd_feature_version   = le32_to_cpu(desc->fw_version);
-		psp->asd_ucode_size	   = le32_to_cpu(desc->size_bytes);
+		psp->asd_ucode_size        = le32_to_cpu(desc->size_bytes);
 		psp->asd_start_addr 	   = ucode_start_addr;
-		psp->asd_fw                = psp->ta_fw;
 		break;
 	case TA_FW_TYPE_PSP_XGMI:
 		psp->ta_xgmi_ucode_version = le32_to_cpu(desc->fw_version);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
