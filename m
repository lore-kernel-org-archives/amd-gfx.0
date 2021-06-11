Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3B7C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52469613AD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52469613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4416EF3F;
	Fri, 11 Jun 2021 17:04:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A500D6EF3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeqFnkVdy8UbGCYrQQzmIb67SBeX5VjJyUpuvBl4MeH9aDBK39BgyQPCZw7D53wtPnKUaaRwR5686KdoOaztHNSVfqZo/vCOObAjMtnZ57UyowjVFjQzAj2p4lL99pBlaF5oKw+3u71dkPY2mbyLec4gZx5GEQbSIHpx0810vewH//v5Sb2dbGxzXOZEW4WcKM+QhjWcU2qSmotfzoh1XNSdCaEOyW59MNk1Le30mWNwP5ta+ZoTFAeFZ8e/G7LkfKDX91Mi8tnW5WqKja1hUltcvPwEVYPUcrQdBYULMI3mvbT8/DkuwHo/+7MPEtNAkWg98SeJaOJxNcptcqetYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v6d0oMxp0eLk4UtDyBSweTZhKbSZ2l02Hl/KiPRoIs=;
 b=Yb4T500As2pmRzfN+Ty24QeUSOzDUmYGwDzlnJmDGNQ8nBadsFRscr3IrYOznRiep0a2VpFrxl5LZNEf4qtjAqBpWzi+/FuwG6EoISrZ0XXx/urxeyTu9CMfcdaIYr+cOC2ZEzoLkSeTST3999dzdGTpQ1c3zcEyEBHgNVxpch8KA3LnKmUkZZpesN3ozJ7ZOaLBRstyClf5s6+MoeE0/gCBit8yXuqyM1NE5ABNcDkDQ53BFF9o54MFVRRNvsiAH0EZNtf1oudNCtL/zO73Dhs6A7jlchC4P1Coxets4dtzFdXY2cwKIVUXUdz6nvRtg/5VpE/AM/eDU2+BaWJRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v6d0oMxp0eLk4UtDyBSweTZhKbSZ2l02Hl/KiPRoIs=;
 b=PVTX4+UZk0vnSph1S0iQlesTOSAQ2DrWjJjXqdhA9s3QnG4iiXaOLBDsuCa0e9KfJK1CGi/QrDmMqU3Wpkoy+qwZfAMjZsHEhaTAGXO++amSZaQ1AVMP/WiuGLkuuOONGjvMkm2sSXQPTdpLMJLjs1MIlds0wHwJu8J9DzcTDc8=
Received: from DS7PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:3bb::25)
 by MWHPR12MB1725.namprd12.prod.outlook.com (2603:10b6:300:106::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Fri, 11 Jun
 2021 17:04:31 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::c8) by DS7PR03CA0080.outlook.office365.com
 (2603:10b6:5:3bb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Fri, 11 Jun 2021 17:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 17:04:29 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 11 Jun 2021 12:04:27 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <john.clements@amd.com>
Subject: [PATCH] drm/amdgpu: correct psp ucode arrary start address
Date: Sat, 12 Jun 2021 01:04:13 +0800
Message-ID: <20210611170413.9447-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bd8abad-d49c-49f1-966d-08d92cfafa29
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17258657D9794307F4970B81FC349@MWHPR12MB1725.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKhCIVClXA3lyj83jDjQHKK6uj5stFao8qL9K2oH4N0TN4a+xgCTwHIxcgR6rXtJYGQxUv0OerSiFCg7vpka15hGNf+nU49UwH+pHhHDRZX0yesL+EQoNNVUfZ4msZ04Jabwem6y+bmoSt0/Y3F1tlYWQ6c7b1OEjgw5ikM60EIpubOMQ6LHgPth1r9jIfodFn5JvjkpEdWEEWu7+WpgeYnICchf19b6ZvUOoQIpLomyw4q7nDbr3Xul/4zfTF1h0p5kCwB0yWy2uaie7DVLSKvYt8Rv16qLpkF+9Nqpa2QQDxKDPFbe+bmNgpnrDiaKKSdOSJlNWuxTmlVyQLT+9tOpslJme7VyPpKGWFVby+rlDPjoBNqOrHeMAKIylcN09uVra4A8E8M5OvrJpQnp1HlqlTHREOy+EjmXhFkRDteXjW02bwPTahV1wqU5Y1rib7wJ+PZVjc3lmIc4f0OsWrcETAVHxgaUo1qvmEmu6Dub5HOVIpZ4Co3x0A+sxxqqIO0tkMZP/LexD4i/yGU+KosatyzkKLrenqWVND87CHPW3dmUbFkZEW4cmekFjVdThd/NZW96USxIj9+TVwERtQrCGJAtsH9OfF26QQJ99Vzr+7b4+U6Dj3youqhcqzIfA0+fkjQ7THWkrDLKEXsHJpb+kQp7Ju9xmo3mhRsSJQXZjPVX47Fh6hN5KyVD/IlS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(82310400003)(36756003)(8936002)(36860700001)(70586007)(7696005)(81166007)(6636002)(82740400003)(356005)(8676002)(2906002)(83380400001)(6666004)(70206006)(110136005)(47076005)(478600001)(54906003)(63350400001)(426003)(2616005)(63370400001)(316002)(336012)(16526019)(4326008)(186003)(1076003)(86362001)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:04:29.9052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd8abad-d49c-49f1-966d-08d92cfafa29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
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
Cc: Candice Li <Candice.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For ASICs that need to load sys_drv_aux and sos_aux,
the sys_start_addr is not the start address of psp
ucode array because the sys_drv_aux and sos_aux actaully
located at the end of the ucode array, instead, the
psp ucode arrary start address should be sos_hdr +
sos_hdr_offset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 066d1cb1a5e1..f7fbf0604631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2957,19 +2957,21 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 {
 	const struct psp_firmware_header_v1_0 *sos_hdr;
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
+	uint8_t *ucode_array_start_addr;
 
 	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
+	ucode_array_start_addr = (uint8_t *)sos_hdr +
+		le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
 
 	if (adev->gmc.xgmi.connected_to_cpu || (adev->asic_type != CHIP_ALDEBARAN)) {
 		adev->psp.sos_fw_version = le32_to_cpu(sos_hdr->header.ucode_version);
 		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr->sos.fw_version);
 
 		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr->sos.offset_bytes);
-		adev->psp.sys_start_addr = (uint8_t *)sos_hdr +
-				le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
+		adev->psp.sys_start_addr = ucode_array_start_addr;
 
 		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr->sos.size_bytes);
-		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+		adev->psp.sos_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr->sos.offset_bytes);
 	} else {
 		/* Load alternate PSP SOS FW */
@@ -2979,11 +2981,11 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr_v1_3->sos_aux.fw_version);
 
 		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr_v1_3->sys_drv_aux.size_bytes);
-		adev->psp.sys_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+		adev->psp.sys_start_addr = ucode_array_start_addr +
 			le32_to_cpu(sos_hdr_v1_3->sys_drv_aux.offset_bytes);
 
 		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr_v1_3->sos_aux.size_bytes);
-		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+		adev->psp.sos_start_addr = ucode_array_start_addr +
 			le32_to_cpu(sos_hdr_v1_3->sos_aux.offset_bytes);
 	}
 
@@ -3005,6 +3007,7 @@ int psp_init_sos_microcode(struct psp_context *psp,
 	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
 	const struct psp_firmware_header_v1_3 *sos_hdr_v1_3;
 	int err = 0;
+	uint8_t *ucode_array_start_addr;
 
 	if (!chip_name) {
 		dev_err(adev->dev, "invalid chip name for sos microcode\n");
@@ -3021,6 +3024,8 @@ int psp_init_sos_microcode(struct psp_context *psp,
 		goto out;
 
 	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
+	ucode_array_start_addr = (uint8_t *)sos_hdr +
+		le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
 	amdgpu_ucode_print_psp_hdr(&sos_hdr->header);
 
 	switch (sos_hdr->header.header_version_major) {
@@ -3047,16 +3052,16 @@ int psp_init_sos_microcode(struct psp_context *psp,
 		if (sos_hdr->header.header_version_minor == 3) {
 			sos_hdr_v1_3 = (const struct psp_firmware_header_v1_3 *)adev->psp.sos_fw->data;
 			adev->psp.toc_bin_size = le32_to_cpu(sos_hdr_v1_3->v1_1.toc.size_bytes);
-			adev->psp.toc_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.toc_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->v1_1.toc.offset_bytes);
 			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_3->v1_1.kdb.size_bytes);
-			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.kdb_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->v1_1.kdb.offset_bytes);
 			adev->psp.spl_bin_size = le32_to_cpu(sos_hdr_v1_3->spl.size_bytes);
-			adev->psp.spl_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.spl_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->spl.offset_bytes);
 			adev->psp.rl_bin_size = le32_to_cpu(sos_hdr_v1_3->rl.size_bytes);
-			adev->psp.rl_start_addr = (uint8_t *)adev->psp.sys_start_addr +
+			adev->psp.rl_start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr_v1_3->rl.offset_bytes);
 		}
 		break;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
