Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7980C77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 20:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AFF10E269;
	Mon, 15 May 2023 20:15:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C787D10E269
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 20:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUJFc8vUGvmZi8Xkc5xx1CjgrWeuYfcuy5eaGAzx2kGrKigFrj6/xWv73bchDDnxXpopOiKzwvJDDOe1TnnS+P9tdqdcBwV+uR7TVIWl+QniUZLf/Dx6L2ihV8WorKZdv+eFw7PkzE2oIf76fYmYe/FfMJSrE4Gpu1QDU1fBDuiFG2qttPbq7SI7TYPOHSRlaehy4AwYqQkSW+YfWMSrVCYtlnzrgenVy8sWHrWGHo81eNzOPBSMxQOnCfUR2z6pbfdKM4Z9/9YO2cRIfzVExD/59o3lhBNHH7lfMIjezzQqY70lTMpBqAgjqEPeepuGblhcbp9neFpxXkDgd5pODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjS2PnFb1Kqy6riz0LYK2AlW41pL1UyYUQMI5Gsnd6I=;
 b=if9D5MnrjkZ51LC64jIG4BSPoAD9x1Pc0Sr9cWpcLX1vzmverKDQdUncwIwZMRNh2XcV9I1PAjU3YL5JVCqlekY2X8bTdtLlQe2QPZ6WwRFiKBsONia4sGOYgywCJfE7DElJIxCaPpDN/S0KEGks9YqrUlfy19VgqT9Xq6q+nsrEHRGQpottsUZESdv0roouVSNtgRh7/Bkj2K2Hf+bIDw3Al7gDvPiNonXEqnS39Y0uo/ZM9bOMgGBuUd3VaKhYp/0ZJXR3g7yIlUJg/D6WXAfQkPJBuNXnsmsmHtqMxzbyO4ZZCKwBURNHLDKeJ3322vBuKc7bWgC3HD2BtHo3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjS2PnFb1Kqy6riz0LYK2AlW41pL1UyYUQMI5Gsnd6I=;
 b=mLtjqhd5PzHQip3IdRMWe+jpejV6CDFryXg5o9nsyjnYGK+VnaAAdd6xCyb3ea3FjhSggykXbzWwWzJuNrS5cgQowNLbByhKA60mvk08WLXBdMynxOEin6njnqo7o6RVKMbXkWfdn4eoDuHq5+oAwNQ/Ag05IReZHqyy3F7DQRk=
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by SJ2PR12MB8157.namprd12.prod.outlook.com (2603:10b6:a03:4fa::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Mon, 15 May
 2023 20:15:02 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::b3) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 20:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 20:15:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 15:15:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix null ptr access
Date: Mon, 15 May 2023 16:14:46 -0400
Message-ID: <20230515201447.2802578-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|SJ2PR12MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 13291b57-7173-41b0-dff6-08db558110a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBam5q49ZI6/mDpriNdOXXoCudJ8YEMmX9lnytZxlNPPnnlUs8383V5RKqT27f01g76jBIGE1Rvw1oFTF9Pk4i1WXtZ7RFE3q60r3gjE6E8AmBh+gIdNDnYGQ/vqf9TkxHK2msG+DluLzLJ4iLjuF6JCoysmyXbMq7WkLc4hE5XYhX4ls2vG7r+QguRPUJFZfb5Je3lgp2PLWpJbub82KAYRl6nsiL9dEkFMd9Fi7XloxUdoG+QNaNr1/nRt9F9QxF4EbsHj0LBHQi8k1E89py3P65ypEeO43HE5uIn6jazAOGaThvofLyWZrlc+NyCSHgJAxx7PUp7gKTHOwgqS9JlGv1B/k7cQDKz8DzZr3NUOM3Md7ZS7SDQeLqxZ2Chc5plXJTq9DBgMkPzatOdTOM/fVsiay5dYjnlVq9ERIJhhp2ECUwc5ZdRttiU9R6NtzypxXqHdxg+oYdEQD3yQbCQjwplBDqydBajdVmWpAemLafxSOrzzUdm6wVDlT/WPmKgJdTZtRkr5KMueJBXa6/VFfIo6oxG862YQlzvxI2lh7qE2rv0WTRIBpsili5gC3e1/eGv+SgCr1RpNIXSKC9aooJiwj92/2QLqZxOuz9gSH46NWwhUP+IpdeorHR3T+HzhxWxLJgBbKHgY262RqymQI9Ub55Kfy8MMis6p+gM/MV/s6lm+TceB7v6N1/0IBiKKjRcACcKhu4ZXJuq3hh78wlCr5Jh3JxKn0AjL6LeeUUmmwrz+DTk6g2PyRintx3wKCstts3MSmDGGpkC/zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(316002)(4326008)(40460700003)(426003)(2616005)(47076005)(6666004)(2906002)(54906003)(70206006)(478600001)(336012)(7696005)(70586007)(83380400001)(36860700001)(26005)(8676002)(16526019)(41300700001)(8936002)(5660300002)(1076003)(6916009)(186003)(40480700001)(86362001)(82310400005)(356005)(36756003)(81166007)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:15:01.8809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13291b57-7173-41b0-dff6-08db558110a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8157
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Avoid access null xcp_mgr pointer.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bf32e547182c..2cfef3f9456f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -644,12 +644,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 * If the VMID range changes for GFX9.4.3, then this code MUST be
 	 * revisited.
 	 */
-	partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr, AMDGPU_XCP_FL_LOCKED);
-	if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3) &&
-	    partition_mode == AMDGPU_CPX_PARTITION_MODE &&
-	    kfd->num_nodes != 1) {
-		vmid_num_kfd /= 2;
-		first_vmid_kfd = last_vmid_kfd + 1 - vmid_num_kfd*2;
+	if (kfd->adev->xcp_mgr) {
+		partition_mode = amdgpu_xcp_query_partition_mode(kfd->adev->xcp_mgr,
+								 AMDGPU_XCP_FL_LOCKED);
+		if (partition_mode == AMDGPU_CPX_PARTITION_MODE &&
+		    kfd->num_nodes != 1) {
+			vmid_num_kfd /= 2;
+			first_vmid_kfd = last_vmid_kfd + 1 - vmid_num_kfd*2;
+		}
 	}
 
 	/* Verify module parameters regarding mapped process number*/
-- 
2.40.1

