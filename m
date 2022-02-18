Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFFDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 14:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D0010E4A3;
	Fri, 18 Feb 2022 14:51:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D0E10E4A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 14:51:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH/dYTlqY5U++So8HqZyvPJFCA5ypfQwZff+EjxxzMxB7km9a9NG9AHStGqtUFsyMu9qjwiHM9Fnajy/KDXPdedmX0x27MtblEtbbbHnBKuAbh6fRZ7RK6Lj5e/o32uZBGZecmW5GaOAZfqklJiaZp+C/yTuMBukwvkPwsYCvyjCSniG4FElgrITg/Ddi050HVxSlVSkuBVObUeYjqDFitj5M8HB4jcFwFKRRv7Q44EriwBuo27lsaJhm6NdmP+GAOQMTznX05DW7bR0GmTk9zBhKtiG4J3kwlPcmUMk5EHKeBxM7tvm3FO6DTkhvZvuoAZhyxft+pEZ/88bKYlaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REj7+yCNS7AExRYZGV5tJ/3xesZu+Zf2BOtBg2W2P1Y=;
 b=ZA6MM92D8Q6AgE5lHFspuRfE4ttPLOWyGx2KW8VCuK3TAEGgM9atXFrSpBVlQ/0gsG+LZEsYtouMMfny69hYbqPaEDg+7vnf3YhTpgTiSV5DgBESoT045pR4jYUt9QEZZDdNlD+g9bvNxLUxhNGOdsxiryxFAZIUU0PVDyLm7bjVzS6xZgBwYklNLOCLznhVBHZlnf9NSIcLP7tUoWrGHHlyyhusxn6Xwmr0vmauzPCSzBB350u87eHbhQ4J7l89BtbbJO+2XVctplTC1tlr6GNi57cIjB0qr9NARuzo4fZgq7DBPYXdI8jxYTxgQp0cTsX4qop0pLbVdrbqDC/0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REj7+yCNS7AExRYZGV5tJ/3xesZu+Zf2BOtBg2W2P1Y=;
 b=oMz8h5yTDmV2v0b+gAcivNylgztkjOlf7Lsm8gSkwcyCk1w+TQitjyEfB2U2y/d06dshhCFQlaZHXsVEGd+dEdzHybcQhNURY3UbLYyGOBm+alXt2TV4cpxBuGwFGQmWVhQfUCCQFHEW/jzRnmZvzLxzoUeL2w3SKifGI24M9uY=
Received: from DM5PR18CA0095.namprd18.prod.outlook.com (2603:10b6:3:3::33) by
 MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 14:50:58 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ae) by DM5PR18CA0095.outlook.office365.com
 (2603:10b6:3:3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 18 Feb 2022 14:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 14:50:58 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 18 Feb 2022 08:50:55 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <Yuliang.Shi@amd.com>, <flora.cui@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: add modifiers in
 amdgpu_vkms_plane_init()"
Date: Fri, 18 Feb 2022 22:50:39 +0800
Message-ID: <20220218145039.7329-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a670600d-b7b4-4ee5-0fa0-08d9f2ee12f1
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB57135A86DABA48D5FC34EDEDF1379@MN0PR12MB5713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:211;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGDFz+6MzPJT21zlLE4L8KrLf4nOWoUsJb2QaM6tzzzRBhtWcaEGhacTexYE4e8Ex3ypnoOl5RijcrNm1wWMK8wdzEP/nR1cxfOC6SSznfeub+eflC3QUv1sjMiRDDudKprPW9whjCMpTpSYyBPKPSQ7rkmNPGA90hmcigVjYhABq0SHzmW8IpQ9I9SrdBEWUIGJVs+tphqtxvPQKM+hETQ+3Go+8yVrdIdmtT6e3DQeI4ulVp5J30I6v1YtGA3SXBZfEQH9ovD4Dj9r3PKCdKAlLZE3upnrI1m0khqLwrWOl6EncbLayZoJIOt+ziZTa+lI8HjudM1IbISA37qPM+oa0b86gXd2M8efvWKgGsGnBvzY5HwchvbfRHzqKdpROYcs4KRNhwIvEGinpCdy7mh3GpO6BNnBbaAQy63YthPhouNqQ8ULfjUXY3zTXO/mPDeMWIgJKg7OzNDTa3ovaWIkM+5EyLT379HTqJol6DUSm1sa5P5yIdpovWL81tcWoXykyP7ZrbpPABeCXGWTypCi7trD3t+xpJROHEQs+mrZudXsMhDTKc7OXn5FcpUqAfXhZind3maVbbHiXigLSrNAKNyPcdg9GqRx1I3/7vwY23EJ5G9q8dWi+eVSzbnsvR64jXIdPCZ4o2RSyTZ43ILyjeyGbNDHCZgHzf7EQFJgUSoZnfMrxqWGpTNuSn95P7KjlDQ7hNdaIaA6LhYGCfvFgUChFd3VxH7Ap89G3o0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7696005)(70206006)(44832011)(70586007)(81166007)(8936002)(6666004)(356005)(82310400004)(5660300002)(8676002)(47076005)(4326008)(40460700003)(86362001)(6636002)(316002)(110136005)(83380400001)(16526019)(2616005)(36756003)(2906002)(1076003)(508600001)(336012)(186003)(426003)(36860700001)(26005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 14:50:58.2155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a670600d-b7b4-4ee5-0fa0-08d9f2ee12f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 2f73d74ac4cd880beaa1c19fa9ef0296c3eb3b60.

No need to support modifier in virtual kms, otherwise, in SRIOV
mode, when lanuching X server, set crtc will fail due to mismatch
between primary plane modifier and framebuffer modifier.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d99c8779b51e..5224d9a39737 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -391,7 +391,6 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 						int index)
 {
 	struct drm_plane *plane;
-	uint64_t modifiers[] = {DRM_FORMAT_MOD_LINEAR, DRM_FORMAT_MOD_INVALID};
 	int ret;
 
 	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
@@ -402,7 +401,7 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
 				       ARRAY_SIZE(amdgpu_vkms_formats),
-				       modifiers, type, NULL);
+				       NULL, type, NULL);
 	if (ret) {
 		kfree(plane);
 		return ERR_PTR(ret);
-- 
2.17.1

