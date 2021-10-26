Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4AFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10742603E5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 14:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10742603E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F4389B18;
	Tue, 26 Oct 2021 14:45:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A20D89AA6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 14:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R12qJq9ji6FzIusrzAJzWynYT+NoRTahGxlIClCbOi1/NwjnS5l6A6y87Bj2q5VJp8OfxI/bc8oYQmZwmCLqSmPCVaboFC79fIK/qKG4vmhTu8oy3zbYUukTYkpnfHEwk9BDjaH7hayygPAN8U93mz7KSHuloxE275IAkDbsjvHiDPpV9JEs7rU/U0MKlAB2Jq04kcnRVFPfWKBbbQKCKKGg4jou13Qa+dhihoC1BXLyv/ukPaa8y/ERCB8kuoYA4/7udX2n0KajR5WbKJtwDIBAyTUzWV18KXTsGTbvWf+dc1Lhfn4trE9yfnpaCBFxQNWcgVC/RIpdZjnBw07Neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKwEIFVNR57Ihe5nsQbivNq+yp16oDFbWrgIYWUDV9I=;
 b=EpGcSwuWMxhNSd8NJUUs/lEWC7Lb1NttgKE7cnYPnhPfdrmkOg8sC4IT5BkWHtZgQ/wCd65xn52xA6yqhnvy19GP/K0fIaeHxnbw93g+Md2bav225mcNEa7sudVi62hZnsaF3DMhwW4qrHaDqOp26/kwzPIMBo4YT0VcJxvSAQ7VtUb2hnGA77ilfr8QTkR0U1Nvz9gUGeI9heziCTYCceGF22DqnpydKGIaVm+IiLVnWMJ3UDqmDJJIkHI/26O23JOWpml8yUCZg70J2ghSUuklsZPvNIVgQpxjKGy7Dk4yQjkRiYPTe8Wani4xwcg7ar4IuXlaQt7jtt7n+pmElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKwEIFVNR57Ihe5nsQbivNq+yp16oDFbWrgIYWUDV9I=;
 b=LztXeIW8+IDViYC2m42S6rfVOTdOovfEfvLRSKlMGYIDSyMM1StpOn5ljPu6NBBo82OkGMp0ZSMM0dDNYMaeu4p0nIwHMBP0XvVDDl+kvEN2Tl4oU5xL2A7mCHuthUJfvbWaNQyOT3kmxm1FnjXpffSA9sRvV9OeXzx7kEJ5uGY=
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 14:45:50 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::84) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Tue, 26 Oct 2021 14:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 14:45:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 09:45:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/discovery: add UVD/VCN IP instance info for
 soc15 parts
Date: Tue, 26 Oct 2021 10:45:34 -0400
Message-ID: <20211026144535.191727-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc538ac-c880-4b31-04d2-08d9988f4ddf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173EBEC81F4A2FB5950EDC1F7849@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BhTyKlrcVEuGzHngsqLG1rSizkBCWTyGvOmtF9Uhow88fwUaAoqVWqWDVKAo1prlTZWbt1jsGyoAjAyOlbGUtBwj9ZlqcItMWEDQQyrCI2lCCx4Ldtp4+uYne5lLyJ8drq1V/XFIoDN6yM+Hg8d6x0tMv6dFhNchJyGTeNPkg72jXBDF1b9SLS2uHJIZM4+PHZHoD95l5def3e98seFYggx1PHRrsnt6pUctZMz8aWb+AqZOv9Uk3mcZ97KOxIAKdLRdJf3g6RuZuOoJt7Vrozc8yqMvgWRYN5LrLYBVa5JRpanuZev0ONYtENCbuc+cQE4TI3C58cVJWD8MNhZYvZCHTLKgSjsZWY4S31yOCGqQ5WdSe5uzxf9dSb/DmsT+vc+rYHPqC2kYS38FAZYjN93gFX2onT85KDIFHPMWlu94AXF1VCgpEpv4lhoN3jeh/r48xJYjXMHpjYIUceo8afTT0LR7PKFf/OjptuOtjJYU+/5pohdW+rjsFUx7+dwrQ2kGYX+/4EfbSnBD0bkcWgeIdxHTRON+R37wFVdUd7smAArsAFNRZaGgZauAk+apciXkefxMCGM1m6y1mDkOCXWWNlGxcIZa5lRjVfWDy8jokOX5boQrMPb5waGUuKEOMHELiqbzInFE8T40YZ0pWU7PN7eI08Trk4ClzZMShzew2j0I+IkFXp0ViD5RwlgoHe8tGpxq1vzM27BWkwjPdCVpSS6Wf8Ym3Uret6E++y4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(86362001)(8936002)(47076005)(8676002)(336012)(82310400003)(7696005)(6666004)(36756003)(36860700001)(70586007)(2616005)(426003)(186003)(26005)(1076003)(16526019)(508600001)(5660300002)(70206006)(83380400001)(2906002)(4326008)(356005)(81166007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 14:45:50.3412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc538ac-c880-4b31-04d2-08d9988f4ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
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

Add secondary instance version info for vega20, arcturure, and
aldebaran.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 208a784475bd..44b0821b6ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1018,6 +1018,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 2);
 		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(7, 2, 0);
+		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(7, 2, 0);
 		adev->ip_versions[VCE_HWIP][0] = IP_VERSION(4, 1, 0);
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
 		break;
@@ -1039,6 +1040,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(11, 0, 3);
 		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 5, 0);
+		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
 		break;
 	case CHIP_ALDEBARAN:
 		aldebaran_reg_base_init(adev);
@@ -1058,6 +1060,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[SMUIO_HWIP][0] = IP_VERSION(13, 0, 2);
 		adev->ip_versions[GC_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[UVD_HWIP][0] = IP_VERSION(2, 6, 0);
+		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 6, 0);
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
 	default:
-- 
2.31.1

