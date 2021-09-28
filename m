Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E35C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC93161262
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC93161262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 410C66E8E6;
	Tue, 28 Sep 2021 16:46:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 097296E8E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVthcvzPvWCIwvqyWveUb+eusvkwePsmiWkGYYYiHLYreUaNQ5xvzvJ4G3LsH1uSZ6fTeIjsHGh6AiwxUrSGrtRV+Q+m0CNbtK75+l8+R2FzrTlE1JtZFK9tifcY7Tz6clOePEr22wWxpNlt0+/m1kUc7flPxlaFR6iHudnKgcmIDLd/B271lVThMF6cXUDAKVZLTyjT7SCiFpWzlB95aRuHEzLanbxqmM+CbI0S24895EIddB0i/mIKpd06WV/sncIXecHoPf/xgvu3ZU6KnB4T0AKJPCcJq5twZ5Ag2rxdcey3T5E19z+QpBywHOAQb10OZ0KgR25ASja2Nj99vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Z1cEtxJ1POvY+PoZr/fOKKTUblPoi89mm3mTnZZker8=;
 b=j3KMSkuYiu86XlU3yFcEXQI+tNzaAITQcuEb5K08FgZcsQni4HEuQp7A7f0IuPn9EWT9B+Ds7ArZ9rl1qh183EydH/JfMdk/Muxl08CD/pYlnlHNfOQRBoZ52U+Ih2AcpzGGjTXbnS+8VrNqsrbhRnOdngL7wLEAOltczEZx6wlvfc9NvNRzZuWKWMxuu0RjnARgqVInxvreC/Yh3WHS3rlqgd0rhm6SBxqC78b5lDQPIltA9P5KZABMsf4hEIzmfUL315ULMAOeVnrGKZxbdIdbS/7/FAceitXmGGtMK1RwwafqYJj680z0jULFTT43dDB3cJMrxr/4mn3rSiCCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1cEtxJ1POvY+PoZr/fOKKTUblPoi89mm3mTnZZker8=;
 b=gyVQ1oR4l0QagDXsPZ0YK+HavYiCYiEMm8cJPz2hkx76xa5Y4cebC6uRleMEqRfKWpadgdpHBOmSI4baTu7Hl3AVhoSU4giTKLzeQkZb/xZBh3ZzGpgdbPST6Jc/oVgjyyrxptBev3DmrStHfwUzoUoo/Mw+grvrJKe8Lg0Thhg=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 BN6PR12MB1220.namprd12.prod.outlook.com (2603:10b6:404:1e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Tue, 28 Sep 2021 16:46:00 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::cc) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 50/64] drm/amdgpu: add VCN1 hardware IP
Date: Tue, 28 Sep 2021 12:42:23 -0400
Message-ID: <20210928164237.833132-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 712c29a0-46ec-49b9-776f-08d9829f73d4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1220:
X-Microsoft-Antispam-PRVS: <BN6PR12MB12201705D49D76EE4384C0D5F7A89@BN6PR12MB1220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzUrEopQZGP4/VSs/FA6NuPW65OnkGOtbskbiIRr883U+MJcSgGYm8cyTMM4QKHVzad82twNOfQ/4ZqY+BxqsYieKdXPN5dU+o9FIWZS50CvLxj84SyoilBQc4xKKCJpdOE2PyN2yIIy70rqzcbHbNgPq/y2Yw3HlgrAXXgSOeY90/hzIaDEWSu+XlkKvaVyXzezA1AEqKKq+pI1fpG+oNvKVnbwBTqNSG9i7YkP1zPuZqAL0D+NtFdW4amFvScy4bSrPjgBMTvNDyPfdIHfOecBE5f39+BzBds6nIrsaTuXynUsgKzcRdwUCYwDcnoc42LBn2NkH2w74Kwm/UGSDAZ+0mt2csqZU0dWV5Fbsf4o+NkcrxeOIwmVh0+g2p0d1rKxSuHwpGne+EyPeHKJezMUerOAdyJmnwpxvhpqu6BS8lDUo66ZTslw0wLAS/+EabmdyVF4yFR0+K2Kv4hD/nBzGPj4YK+ZLb6deXv436TjKADDmHB/HP9tdLKG5Z+sctWZncmeydpoovw6fc8gLcmpEqk6uJk2+zwVysJb6tystyb1g9YwLhO2pPRmMRqeXbUGjmkVnVRUNG0uy0yxCMupI4XxkQH4EbmezQigxmg8UR+ya34rViMM3k4//v4JBOckVc7ANh+DgQS3zJJHRXB6ds66i0DvtszNannnTvbDQh6AxKokWh1TfdUhbolhmGp2z1AOMpHJUXe2EYGO7OIiSMr3I1E9z5jsTbpjwuY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(26005)(6916009)(426003)(356005)(316002)(4744005)(81166007)(36756003)(2616005)(16526019)(186003)(36860700001)(47076005)(508600001)(86362001)(83380400001)(6666004)(82310400003)(8676002)(8936002)(70206006)(2906002)(7696005)(70586007)(4326008)(5660300002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:00.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712c29a0-46ec-49b9-776f-08d9829f73d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1220
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

So we can store the VCN IP revision for each instance of VCN.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 815db33190ca..b153c3740307 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -744,6 +744,7 @@ enum amd_hw_ip_block_type {
 	UVD_HWIP,
 	VCN_HWIP = UVD_HWIP,
 	JPEG_HWIP = VCN_HWIP,
+	VCN1_HWIP,
 	VCE_HWIP,
 	DF_HWIP,
 	DCE_HWIP,
-- 
2.31.1

