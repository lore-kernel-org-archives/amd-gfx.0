Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F81C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEB7611C7
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 20:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DEB7611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B116E1E8;
	Tue, 19 Oct 2021 20:11:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D477B6E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 20:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6eN4EN+B7nerT6ZI/UKxOoDTbVv7ZHlCv8w5kVn/vzg5FyywQbVSQcYFNw+0R2irFEYmpGCkkMW7oG1UP7puo27hzXYsK9zt8+DDJPgNkuFfqS3fn9JGXQamGXQuxih0ywbdGeKT9Z02XPn58cV8D9ZhhVpbGW1V9qTYMadfofaLv9uCPgHOVpj9acD9V4EsFUUGCYUVvTdng8bzQttvF8TgVHcmXB3fpHC6Eo/8tNaUf+1yyil5lteJ0cs4O+ZF2PmbHUSV4yyd0QIoojoXvxlLg2Xjy+esZsZNcL/Wv4I1S6/2VKmXwpWMc3GanUsLybkS1J1gC6OH/VKDwHgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWEK/VTIsuKY2WadbrzL/D9Gq2A87UccXNroWQc82Cg=;
 b=c53lVUWMOpnj4bmXAlB79qAEn4cWXpOYLoXgf5X8460z9XpgObWKHwku3YJ3nqqTF5DHrNkybiGy5IQS4UWj214WX6d+BZkX2q5ZJ7g8mS9kWk5LfvldcgBNCzAE30O5M2c+i28h9IPTqXk0I3PppkBAITJaOKNqmHa0mBWtJzQdD4Cz+zj23xrFUjWClJsD7Gz2HRKVYIup+a6g4SH6ycCFO6TyhuRHx8T4XsaeIzAPjvTMJXYBfb0rhD8HQ2IeC4q31j/mQOLDrKOnzVdLCrCiuWISz52GKrdrkeif/LQQJVdMtDBR0Y6s9k7216bpoHSTlW4gr7irpifvPeJyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWEK/VTIsuKY2WadbrzL/D9Gq2A87UccXNroWQc82Cg=;
 b=HvX4xaCy7lj2Mp5W1Fm5TbcUMnbLSP8u9vAsELYjxz9oZi7OJHkFYkA50Jox2LRd7UsBDF33iU+Ud40WGI9bnOFlVyetsyt6UZz1sJfr3gQY7YPbSO8ejhyoANi1u5hyvY/5do6Ng1jKceFZuOSpIqDSrURw0hGwUkSjy0xazyA=
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by MWHPR12MB1535.namprd12.prod.outlook.com (2603:10b6:301:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 20:10:59 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::83) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Tue, 19 Oct 2021 20:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 20:10:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 15:10:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/vcn3.0: handle harvesting in firmware setup
Date: Tue, 19 Oct 2021 16:10:41 -0400
Message-ID: <20211019201044.426871-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c69b81-b63b-4329-cc02-08d9933c90f4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1535:
X-Microsoft-Antispam-PRVS: <MWHPR12MB153580B85C522AA32E89ED87F7BD9@MWHPR12MB1535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lid0nF7w5LY9REjRsj7IohujgHYSg/ItZC2X2H5jNQbznB4zzHLfDsSGZkGWCvTV2i7fZZZvle+iiKDZOrKeULbMUHLn/WDHwXio6PAuVh5uO6PTQH/h7tNV3k4sGO+k/1CWi71HrCmxUrDovuP3K6B806T9nG84jrpnzIj5X4vfl/CO0FK9YPM2zEilqdBm4VZbSmKe1St8I2vQxnSxq82jqPe7QEtO7XT++Jmw6XSBfwtDY2KXsekVLaCfmxPTP2CMTdrv4Tfqo7mGUIvFwOtnogrsT5CHdMN7pA2BLTO1BeYV98VWmWvoAYILHFJlS/0/0PB2h3tlet3NcUiWej8ZP25DjDVnG9mNWwjf/QbWkA7gVw66RoCrgUR/wdbB+Uiu1n/9HU6YzmboW1Yq1lV24gwxyscsMzAwMoDpttvfGO+9TAmEZpqIAxLRTjVtCizLculsdVUe4RgSJrzUoRqFNOHRQ0LATu6Dy3oLXCwrjPi5KcnLlkknFh3M/GfRZ4h86IeN0HUR9Aui+O3le1rv134heQtmRt3ggm9DrIntX5n8OdODRcequJlNxKXXHPelmvDcH3Q3tvxHcx8IEeidqDTey3+RqavtT7apoY/hSIPKjFSM9yOhEz7C5NCqUL9cp8rMiIGHrCv0JpoVWeSNX7VuuFRFLY3ayA45WlkYvCJUxpqZS8lGYpdYlmc3LDiXWRhjLeubH03iQVq7fH423gYnieqaPoQOCYGCCQk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(70206006)(16526019)(336012)(186003)(86362001)(1076003)(83380400001)(2616005)(426003)(508600001)(54906003)(6916009)(5660300002)(70586007)(47076005)(36756003)(4326008)(7696005)(8936002)(26005)(316002)(82310400003)(8676002)(81166007)(36860700001)(2906002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 20:10:58.8379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c69b81-b63b-4329-cc02-08d9933c90f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1535
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Only enable firmware for the instance that is enabled.

v2: use AMDGPU_UCODE_ID_VCN + i

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index dbfd92984655..49752574a13c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -123,6 +123,7 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
+	unsigned int idx;
 	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -133,14 +134,13 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-
-		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
-			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
-			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
+
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			idx = AMDGPU_UCODE_ID_VCN + i;
+			adev->firmware.ucode[idx].ucode_id = idx;
+			adev->firmware.ucode[idx].fw = adev->vcn.fw;
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-- 
2.31.1

