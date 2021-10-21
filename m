Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E9D60F5D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 07:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13E9D60F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3FD6EB72;
	Thu, 21 Oct 2021 07:15:31 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2045.outbound.protection.outlook.com [40.107.96.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993FC6EB72
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 07:15:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYkwxogHgSI/J4FuEzgX+UKGIfSxtyqBn6QJLYK+iBI7rxIthZa1vkuyjSvj10onxrgupYs22IrikvDhj8S+RPTeMifUtsAOUpBTqTxqZ28DqJrP9UQ72r+jLi3xK2t73UFMkjw2kcJwTehmcxWp4LwHDHuC5SEteVvZSB4FcBnT0sUZMhFyN5EjV2lcKkJZ8ceADXXqRZtyi+Swk06Vl0CZA/YAXRXmEC8OsS3LTqZXzA74o9fuczG1p5EoB8h11dbVe16Iw2lmfxc60zGagEMaqIhbya8SGpPEaLlCDhvtpk0fF41nBYRkY29Qh+zDohSd43tGMImhpDLfOYW3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQu8tU5l2pWA6FEdkWj0nKJHheFtIRZJgrgeczbaL9c=;
 b=RGKxVXeHAv1mLzyZ4EImLEgT7/EvQdr8l9H/5npbDDEkibwSkaM0tgl7gH1LcZM55OMG6mRYXhrhPryWhPkpm1sPUEa4UpXCZPqvUZba90aL06w02ms2O7LsSpxmirfkwefo/Mwo95M9izzY7Rgi8X6RuCkUebzvGL51rQ/Ljx8ZJ7R0Iz4b5A5ZdHLkSCRRqe6LzDeleeWOBii4Of5Kv5bQUO4Sd0xJNHhcOvSv6zPt/zrpHX+2bUnLbA5e1jT3IzFfMkV3u0pDiTuLqLezeXmou79dcNl5Z61kyAXPw8MsFqVDIsv+pvsosXC7wGuJv70mYHEhtXYNPthAn3EmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQu8tU5l2pWA6FEdkWj0nKJHheFtIRZJgrgeczbaL9c=;
 b=pdM8TgRgvFjBdFmQjH4z5R43eup+EK/LObmwf+OX8iXqUvNJtIq1GfDvv21BLNO+FwOFuh1apYkPNr2CACR9t7dYLcfN1nc0M0sdlN5GurnzB7qXWCAohtVVyp7uTp6GmeCwW7QoTV2dYtOXouvW33qTiAg3+sauGBGdT83QS3Y=
Received: from MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15)
 by BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 07:15:28 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::d0) by MWHPR03CA0005.outlook.office365.com
 (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 07:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 07:15:27 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 02:15:25 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <xinhui.pan@amd.com>, <alexander.deucher@amd.com>, <leo.liu@amd.com>
CC: Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: limit VCN instance number to 1 for NAVY_FLOUNDER
Date: Thu, 21 Oct 2021 15:15:12 +0800
Message-ID: <20211021071512.20034-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6ff10f1-eac1-4501-ad8e-08d994628f08
X-MS-TrafficTypeDiagnostic: BL0PR12MB4994:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4994E5832C8D24F0E8532EE5F1BF9@BL0PR12MB4994.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8sAGLWEi8n0Zb7rXNH9VrKtep5Y5qkb96Ptc6xZ3w91qXIUDeZwZsF1idGkfFP7xXlTlgvAZUTUw+YADYRB8EuP9Z4bSn/5/xV699tPM1UZw8XiGsQ5uWw2xCNXo6YTAJRokVCCJwDPEXRh39qn3s/84B6ehPjhS9kCgiVIwOtxmWCzTOkTBVaqYEpJVmyWjUk23ve/jV6/CFVMcDtfS8lSb8JeyHshugOmVSyoHIr6j5i1TU60TppFcmlhbYP/MhuJjGfrhYxQHZzBn6qhu/A1+5ZfocF2AtvO6T7gqGSJAdCsY8OC5FCWwDABT8wx1fQa2iHNMl/NSdI90dhUlWNzFwygVlQagm+iWhyGya9CjMzcEDCsTQojoLYw/rRCurpQSYXNRYbJI5tk255Tg66gIkF2dxJWumMCDq/YqkJe+BpOIMfW9U2XMRxOByoLdm51C163CFk+mUb25UKkALyC/JkpjMcL1YTmzzv4phBZ+zdn/qMB90Pt/nJrFO2NesChbOyi98zcdu7QpJxOiXh30p0+P3c9OrJ2KyEadLbsN5Ya0rcHFOfY/glIb9oliOB+h6l96Gr3B4rbJUAkau6Y79320JvQLmdRwD+Te9fLR9fQySBC51rw+QEyeTlh4C1+40+1ti9s2unleMA6mN9P0+BETgzkTXlAuNmA03f22+ZlfqlhPa00SujA9a4g077ABG6QJC2252PQ4/t4nR58ZOvPUXHAUmBjVFQlyT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(2906002)(110136005)(186003)(16526019)(4326008)(356005)(6666004)(316002)(86362001)(2616005)(508600001)(6636002)(44832011)(8676002)(83380400001)(336012)(426003)(36756003)(47076005)(8936002)(70586007)(966005)(36860700001)(5660300002)(81166007)(26005)(70206006)(82310400003)(4744005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 07:15:27.5463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ff10f1-eac1-4501-ad8e-08d994628f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
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

VCN instance 1 is power gated permanently by SMU.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743

Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index dbfd92984655..4848922667f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
 			adev->vcn.num_enc_rings = 0;
 		else
 			adev->vcn.num_enc_rings = 2;
+
+		/*
+		 * Fix ME.
+		 * VCN instance number is limited to 1 for below ASIC due to
+		 * VCN instnace 1 is permanently power gated.
+		 */
+		if ((adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 0, 0)) &&
+			(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
+			adev->vcn.num_vcn_inst = 1;
 	}
 
 	vcn_v3_0_set_dec_ring_funcs(adev);
-- 
2.17.1

