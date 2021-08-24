Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEF7C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AD161262
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3AD161262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C9FD89DE1;
	Tue, 24 Aug 2021 06:10:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AFC989DE1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:10:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1lsHAXMZ29mC+d3qJApDIGlI1nlIYTYokVVc6vzLRvFjBFkmpM5jnmaLp3Dh8hY3BaP0Qmu7ijoE0Id5kCv6Omy/m8kPl4oOB6z1lLXOd+fr9/PmShNy2zl2FXScIpOXx9uCwDq5+2f6NFntu6SxyLkX4NkyuQzDjWetREY6/RsxH1s/2ovwEPUdiQDwtiZKkrZvQC7IX/QeTYUbJ1IRRZelpZeHStiuA7S8zgnrzEVF79Z0pNMShNBw1SJJOgdcTPNGOnXu/K7JKGQfJ+N3aptrKgYmpOWgp8ZAVTvZmE8kD6LnHAb6JaMmXVFNJXZ9UlGfRrCg5leGVtWuZ0NGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Hju0DdpSxXa/kx3/eLaK67e+5MbV9HrgNb0Ob8ioQ=;
 b=oZnomtZbIAs/qbka68a2+TrwQS7Idy3X4a1z0iBmGe4i3bwBNaeKtPVAfNcdskOekd01nMI6UeZsgau56gEresjrgnPysSsFpc8Yo8xsho1jsaipIRltfRzax0PMnH766MWDS+2vR3K4ZA0AK6Yd/Fa1azbl781cmUL9q8PbdPGTn3HTyesrYqiTfVi0SLuXcMHpaUpaetlpTjEs80g10fJgOTCF86GInyK4EKy4Xt/8NWh2X1WQX9s8jfXgX1N/oaJZpu/HRrTDgcada3c5bSU6DSIx2mnaUrMUvMMFVCBRox6fs7JzmgtVn4PScg1MH+mWXgcLIgs725HH5k54Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+Hju0DdpSxXa/kx3/eLaK67e+5MbV9HrgNb0Ob8ioQ=;
 b=Tkk4kBc1C2JA56BaMov1nIx74WMuqWJj772dMiNp/dfkxKGrylUe3lKQs7QqLvgk4iHLQzPpf5oZ+7bfM/1rO60Bin7snTAvj4Kri8ynIbYw8+7wuwOoasK/VtXCf9tuEeZUnJkkAWq6PftKc4e500kdyycv9ixy9awc4/Ks7oI=
Received: from DM6PR13CA0012.namprd13.prod.outlook.com (2603:10b6:5:bc::25) by
 CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 05:56:15 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::7b) by DM6PR13CA0012.outlook.office365.com
 (2603:10b6:5:bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9 via Frontend
 Transport; Tue, 24 Aug 2021 05:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 05:56:13 +0000
Received: from amd-Celadon-CZN.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 00:56:10 -0500
From: Satyajit Sahu <satyajit.sahu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, <shashank.sharma@amd.com>, <nirmoy.das@amd.com>,
 Satyajit Sahu <satyajit.sahu@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/vcn:set vcn encode ring priority level
Date: Tue, 24 Aug 2021 11:25:09 +0530
Message-ID: <20210824055510.1189185-4-satyajit.sahu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824055510.1189185-1-satyajit.sahu@amd.com>
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d44e320e-9d9f-44cd-5441-08d966c3e195
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005666CE9AF585C0EE8F07D6F5C59@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuVVp9psS96xd2N+cIdDD1QBRrXiFvHv3/jrmEW8pGzX+x5hAoq4ozil393On4ZuHR7a6pu5GEYVsjlBx5WJbWYGZNNPfpaTpex8eLqid6FG4Lg1M79m7wM1D4VQvWKwyQP9xzq4r5sMdKUAI2WWvdk+qwpPErRn3OK9/BxIySN5qhgqXDAdj6Uj2y1379MkkS0NTqwrzF/gKbmCe/InWTdGqj8rYNlyEZ4ndusIa0VyBwWh4L/dDrnomn9STM6u0pH8jhYHzBHxeW6uRxBJa6+9W6YbXOGNTzocVxC50S8kp+++yhRAnrNMt8oh0TUz1T2DTsEGH8RXbC/toP/kNtGfsJlnWBGeYrFCpkIPtbhr7kRxm4yHKarwb1G6at+GjCkv6W4ru5hfKnuo9IKTkZecQqdqw80YXzq39uYCmxZKxx1MsZ8Q50UylfzDraNoLtwuNA9rylFOJ2yDHmt9Xehs0OR7FgrQO6owBk3vLmFE7firdnj1yKTfj2mj7CoPOX8CBe964U1iIvBBOIOa9MbL0aLmVDSSAbt81jFURmnex8CHHB00g4IuYi0DWZvlIZaByuHxRHi0BvxU/r69MRblpRJWRMXVjo9bmiEcRo6v2z07nM56qNs4NhpcEWdFnyE5VDuBMvsK+KW3jw1j/OrUx8pYzvOqTGd4MlNj4MPoKLI+3Ew7t2nvXjLYIucU0UQfUd7K5SoUPf9uk9PTwCvMibmG3TBrnIhrcUUEQo5RVDDIqOHFJGfXg6127ShOK862INfkKlC67Tew60HqRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(36860700001)(82310400003)(34020700004)(70206006)(70586007)(336012)(1076003)(82740400003)(86362001)(83380400001)(47076005)(2906002)(7696005)(36756003)(26005)(8676002)(4326008)(81166007)(426003)(6916009)(16526019)(356005)(8936002)(5660300002)(44832011)(478600001)(186003)(316002)(2616005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 05:56:13.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44e320e-9d9f-44cd-5441-08d966c3e195
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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

There are multiple rings available in VCN encode. Map each ring
to different priority.

Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 6780df0fb265..14075f2c33f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	return r;
 }
+
+enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
+{
+	switch(index) {
+	case AMDGPU_VCN_ENC_GENERAL_PURPOSE:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	case AMDGPU_VCN_ENC_LOW_LATENCY:
+		return AMDGPU_VCN_ENC_PRIO_HIGH;
+	case AMDGPU_VCN_ENC_REALTIME:
+		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
+	default:
+		return AMDGPU_VCN_ENC_PRIO_NORMAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d74c62b49795..14dcf23fcf0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -290,6 +290,19 @@ enum vcn_ring_type {
 	VCN_UNIFIED_RING,
 };
 
+enum vcn_enc_ring_priority {
+	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
+	AMDGPU_VCN_ENC_PRIO_HIGH,
+	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
+	AMDGPU_VCN_ENC_PRIO_MAX
+};
+
+enum vcn_enc_ring_type {
+	AMDGPU_VCN_ENC_GENERAL_PURPOSE,
+	AMDGPU_VCN_ENC_LOW_LATENCY,
+	AMDGPU_VCN_ENC_REALTIME
+};
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
@@ -307,5 +320,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
+enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
 
 #endif
-- 
2.25.1

