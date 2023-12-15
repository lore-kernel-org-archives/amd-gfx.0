Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F20C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD00F10EA7D;
	Fri, 15 Dec 2023 16:00:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F8910EA61
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZ32HbqXYRQn9AAzegR5LaGAtnL71NJaQ03UVRC3vZ8U8RFev7dH6To6SZq8gckgNNKK5T+Bu3aUqwuud9IamBpQTaIcMbSmSHs2xt9Ikhn3P+cgw/UqbJ6T04POKIEplck/5Gzi+U+We6rxSLqH6CbesGr9tIVvncvse4WOx5D7XQEAjHG+BbHDqBlVqZQE93yKZrgWpTB2lHCB+IYx03AR/FqkB63fGxNau673Lg2XVyY9JpDe2pKG1HWW0OqwnNanJ7SVeItljjy4DqZ4Ovdl1zeECY/OQHmplOM+MFEtTflOkap6gjPaKbmXaxVPi2izcJT4wuUUcYttQv/GOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=Fa25gG4rWVxqDKvnmld1rHrexHG4RgPvuHl1LVIBpJHhd+b4U7IoTq6u1goigSR9FEtRZ5k55g6dI01pnrDLx7I9W0iCsK+cV4oPgk5HiaMnwA/yUOuJ7dKgRknF/IB6p8p1aI3Qt0zS1y2bHGb+HpsC4gle4RtN5hQocmHVn3CCAGU3fiLy87f6vK9cADSEc7FR3YSbforQRvhINfQ0POtDUarIr2MEs8YVCO8vzLRZUSVkPHXMm38xz2cb1Zpw8JWK1k8MOhioGptpP8GEck8dgCffw+4WyjhQHYAlgBRueQ2mfMWPfObfnZ2riXPvwQkBoB1XjyfySXJfFJL2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=PnAPwM0s6nDPMtqn4breeZvo9mZJ2ZcWYZDib+UmU0HxtA+wOzC46lgiIchHW8nxhWKfcPPaFeC5CuYN7t1yCmfStenF8XQQ/gwhR1hb6zFOEdn4mSHNzCvgXzCSDDHD6ytZLq02pri/7Egzsu+8waHJ2Odq81LkiOq51QBCdFA=
Received: from DM6PR06CA0014.namprd06.prod.outlook.com (2603:10b6:5:120::27)
 by PH8PR12MB7232.namprd12.prod.outlook.com (2603:10b6:510:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:00:46 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::7b) by DM6PR06CA0014.outlook.office365.com
 (2603:10b6:5:120::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:00:45 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:42 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
Date: Fri, 15 Dec 2023 10:59:42 -0500
Message-ID: <20231215155951.811884-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH8PR12MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 97605f40-4b7e-42df-b33e-08dbfd86ffb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO6nfhKgCjWAt4liwEtVZEpVOUE/Lt2Bx7Er6ERKQSnEUCmGWglro0nuay4omLnZSdq1RADYlNteDWtvRhwfTBCHYA/7NvJ1NyE9XbIiDiIb6el33NVNrfK/+rtjG0QM6DpFp9RstWzS7DFbgK0EzP1sGB3ERsnWgpOXuKIyUzP69uFfpwFX6dtqCi8nYiTD73tklYmBp6hzkVKSek/erzQ+We2YB4qnXKZw46gu2xld3Seo9r/KlFzPz3vMHd/vpSPCOoG3GTHFphF7H+1iq8wY6wcohuDRYps9pEblChLphwrp/MDU+lnRukAXKNUGmM5nY1SJNyTcZvlnNO9QlFispwhlMNQItIq64iBoK3yzcoYjdeUJFNlSBo963elYPd73L/rz6gT0UFQAg9++D0mSbFyYrPP2EdPamX0hbRIPM1AwZJg824smcSzdeqS9rEL1/Y9IygzEhnHy3wXJDiZOUZc8Ak0oxibay2P5rbZSlRIW1fEI+1/z2+syHnGIvLXQovDCyChiIHdZdWdmaeS7oJv0F5ERA631Jb8zclvPsc8fhFe+FKg2Nri1gE4eYnPxUbSQDOzkQqV6yK6YE9Et6BI3dhPKQPIsPl4pd4NocvGZ6MsExlVetWOVF3Q+gFCFiFtojhZ1tYiN9qw6yKsuSnmqAgHaoGNdYlY9XcFIrXegPkWYL+PuDl4HNpg6aZ5z1qAJzVldqCxn7A/6YZkQGYfaTNcqb5EbJJ1lfsIxEoMyV0ZFlqZodnoFkSpJ9J90rtlQ8JVlRjYLsM0fhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(356005)(81166007)(82740400003)(2906002)(40460700003)(36756003)(41300700001)(86362001)(426003)(336012)(4326008)(8936002)(8676002)(40480700001)(26005)(54906003)(6916009)(16526019)(70206006)(70586007)(316002)(2616005)(1076003)(5660300002)(36860700001)(478600001)(47076005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:00:45.9728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97605f40-4b7e-42df-b33e-08dbfd86ffb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7232
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement trigger pc sampling trap for aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index aff08321e976..27eda75ceecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -163,6 +163,16 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
+static uint32_t kgd_aldebaran_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 8, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -191,4 +201,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_aldebaran_trigger_pc_sample_trap,
 };
-- 
2.25.1

