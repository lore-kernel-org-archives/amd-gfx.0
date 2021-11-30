Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4892EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 20:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82566E4F9;
	Tue, 30 Nov 2021 20:10:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CE026E4F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 20:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQXR+4dHeeSTRqOVWyRHFMXYIhcy8U8Z5tCOnuNnl2kTu/tYM5inWcNvjn8X+OxUjnWG097jgcWPXcd//NkTWSKi+SolTKZZpXj4BE5+O9SNdHwyJ5d3ioY1oiyvpEkcLqhVAcQf04WRvhFj3hs3S9OkuY1h8hysFAKchXmFozs/tte3i1asf9l5TY872Att+6K8OP6vGora3FHXRlxywHy/+2GZPT1I/Oj7PPx/U6ob+1kKquN52EGcngAG5BRbrZNRqA/VXFm8N9kOSf4pdFcVFIAhnzcBfOqnlCRLvU30mYQEnqUQAf/hhSONscYmE+FLp+ElphzdrIlHWuPUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LMZF3+BPVDhQ4IQYyMIRFeCaoUe1QEGEPMtSHn6kz4=;
 b=dHm4EA2xuk4BNp7ZO/Y82zi4paYGOnzdTac4IpccyFDLYk81JnT2pUL1MlIh2sj31sZT48UbSrCpmhhYOUvEfQsXqfJSbkyBmN2ab0MD4AX0wikNF0NVLeO4nHG3GPBwxAv3xXFN+w7vEmo/m8Kcr1C18NITCSB6LsYn+pvvYp33xmOJHYMErDwLDp89B9djJmecG+TeHTYEcvlQYqUeMRk3XBGUVlSwQLvAAs/FDw5RwDrvSpY6Hdtn8dEAy2UOQD8IAhTf2w1uSk8rtReBFAlabBly8xaDbZtpmKBqaUSIlCN1TR1phhM2IkMIrynbccT8kutMLU7Rmw1OeVw/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LMZF3+BPVDhQ4IQYyMIRFeCaoUe1QEGEPMtSHn6kz4=;
 b=UzGKLY5swAbFmU9HHp4SCrEAEjUQ/qRozZrglO+aqzMYaL3iEHP+Gun6NvGVDaEK9gF8o+OiK41cK3zeuD2nChN43IzZQUicFI9QHIZ9QXsPnIKZG8eW/8/ccLbqUNufu1HvrbELJjC66tAMHAuOClkyCwVLr3ZHlYTjPxXUISg=
Received: from DM5PR21CA0052.namprd21.prod.outlook.com (2603:10b6:3:129::14)
 by MWHPR1201MB0014.namprd12.prod.outlook.com (2603:10b6:300:e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 20:10:06 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::fe) by DM5PR21CA0052.outlook.office365.com
 (2603:10b6:3:129::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.2 via Frontend
 Transport; Tue, 30 Nov 2021 20:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 30 Nov 2021 20:10:05 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 14:10:04 -0600
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov/vcn: add new vcn ip revision check case for
 Navi21 SRIOV
Date: Tue, 30 Nov 2021 15:09:45 -0500
Message-ID: <20211130200945.108691-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfd75aa1-62a7-43e0-8462-08d9b43d66a8
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0014:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0014386DA5810705603EF0EDF4679@MWHPR1201MB0014.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Xz+mNcur8ULsSAV+kcPprWrHVifR22caIyiIvaUT2oT43Ox5I2LsuU5P5uO1rp5amdGHgzisLaJU0UgLd1OUCKZCDjU9G59cIKQrM8n2eQLOAMK64N0bvhMf8QqF6uI5MSoabBsb2aQRIWHsflqoI68MYe3jmQygOYRjDDcKFD81I7XQygvmprMcoITvOulM2hieTiQr7V5g8fHyvi3WYVMYC+BQfH79y0bX8oMDvPt3SGjgvx33uHP3XpSwGsl0YrDpJNB3Vye6PtaBTtF+1bqyWURGQ29uHuQEZ+gEY3ydEgCfFUtXbpoKXSiCTT4+hMAqAAdWoWGta1n+pj+cbmtLZ6Sv9o8aMqPhG8O0ExfwrRgSHd1WC16103IrJLnKGvI7dJHa7w/cN95/1c3MB8WQWT+pxfBbHDuhwEbr7TS/boaSubaAnlBDe8sC8tEo5P6LzX3OHfZhGZn0ymPBMzuD4kjrfUUKw2KfqCdyFT2hiA0BvPZGRv9HQtyadV0GZLvACCk0OUxUPizlhR3JbRff1nr+NvrSxaG+nS1nB75Yl8nfZPit++H2B9F1KbjOZTp0atDdmDSSqpZbs3uPofe/jmlf/XfI8SAFmg5UlDCTMEok8NM4jqOSByWZCb5QbDrZ76r61p1ICQ9YYLtBNuJtAKWeCsMSlHBxwmVPFPX8Y1LNfw6+xEx+0JdmYUj8Tvs4fn3dnNoIoJIiJcpt4iQekFaP8AXlh/z+ZU62GYw8TNRCW5JBaQirA0fC1tMk8JOS3z+/SkZgDa+4LviS8xzq5yQBgdnYm/WZB4aDt8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(81166007)(2906002)(8936002)(356005)(426003)(70206006)(83380400001)(36756003)(6916009)(26005)(508600001)(36860700001)(70586007)(8676002)(7696005)(16526019)(1076003)(186003)(86362001)(5660300002)(316002)(40460700001)(4326008)(82310400004)(2616005)(47076005)(6666004)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 20:10:05.7112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd75aa1-62a7-43e0-8462-08d9b43d66a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0014
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Under SRIOV, there will be dynamic VCN assignment controlled by the host
driver. The VCN assignment information is passed using IP discovery data
and VCN revision. The revision ID can be 64, 128 and 192.

The swIP code (vcn_v3_0.c) will handle the initialization according to the
revision ID of each VCN instance. In the common code path (amdgpu_discovery.c
and amdgpu_vcn.c), we will simply add the IP block for above mentioned
revision ID.

Note that, we actually support decode under SRIOV, but we decide to disable
it for now.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
Change-Id: I2bb44d590fc01ed413efb0e689c491079628454b
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c               | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ee19548cf22c..02644abcfc06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -915,9 +915,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(3, 0, 0):
 		case IP_VERSION(3, 0, 16):
-		case IP_VERSION(3, 0, 64):
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 64):
+		case IP_VERSION(3, 0, 128):
 		case IP_VERSION(3, 0, 192):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 585961c2f5f2..6d1eb7eabc90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 64):
+	case IP_VERSION(3, 0, 128):
 	case IP_VERSION(3, 0, 192):
 		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
 			fw_name = FIRMWARE_SIENNA_CICHLID;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2ec1ffb36b1f..f236fa233b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -183,6 +183,7 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
 	switch (adev->ip_versions[UVD_HWIP][0]) {
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 64):
+	case IP_VERSION(3, 0, 128):
 	case IP_VERSION(3, 0, 192):
 		if (amdgpu_sriov_vf(adev)) {
 			if (encode)
-- 
2.25.1

