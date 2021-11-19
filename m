Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76EDC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6D2610A5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F6D2610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AB66E847;
	Fri, 19 Nov 2021 19:54:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8FF36E58A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6N4gb5dBqmONdlCrq+GRJtEYlmL07eHdwj3GHn6FvsuxrIOCB7vN6ibApx46bnHFoOCSiE0kN4vj/V3wLAC+P8MVFKcKA5LgytPeo/c8bLktKWfBjO//ljz43vBxBp3e53aRFSfpzG7Ac3nU1TR+KHQhfJo/984St5TBAQCnxhjJdxZV/nRVR0wPRSu2HqDXGInIiBg1Beq6EyRV1U2eiMweH38aIA70O1fGGV5NU6Wnsfo9t4WvFc5Y8LPIxMqr9ytsEro4mlSnKbKkPICCA62Nl7pn2+zhbKfnbX/9t8u8X77QxDFddn8GzftmvmzYMO6P2HnAIIyuMYo/S9XKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG4bkrppdhXGXMcyqE1Gxhlxtq9/0Ba5HavOa6COp0s=;
 b=d4su0ZtrqO06T6pPEwXjJPAmW0X4334l7b1PZwZfTocmjlQxVxxGBpwFI/E3AMx4JGKvJHLN8D33V46e3ydUNqDCdWjuQOXt4wsQghT6yBc/rENxqky7+6bivlmHNUiRh6LlF7j+y58U0z8A04jhtnuqrvba0v1sYX6nsWEU4gDZP3+PDiavGnhfEvLgBez1MZe36KjZYAEwdDsS173pcBXsLmZpYfhp9R8JWb6cUt10tKMgCYaszthnOPZFyG/TobO25iDbFY0MuHZMtzSyHtHA1c5mthzfIMJCopsKSzjNDqZgm7R1F26ksL9TaDKq+FmHMfVl17/gevzuDhOvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG4bkrppdhXGXMcyqE1Gxhlxtq9/0Ba5HavOa6COp0s=;
 b=KMDJVQrlkJtm8KrL4aHpZ6Xf6YWez/DMmw2QtbvVBtaPxnLUnWrwxl3M18Z9CNqcukQjwe8qqihsepDBiP1vhWZqrtMR4iZVza2TgTLwcVB/BJ6vgVw1EUB8BjpSkrALhsuh74bj7GbDcjJRHTPL0rMaCe45usYNlqUjsoCXKAk=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by BN6PR1201MB2499.namprd12.prod.outlook.com (2603:10b6:404:b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:53:55 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::63) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 19:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:53:55 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:53:53 -0600
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/4] drm/amdkfd: add kfd_device_info_init function
Date: Fri, 19 Nov 2021 14:52:56 -0500
Message-ID: <20211119195258.2173551-2-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119195258.2173551-1-Graham.Sider@amd.com>
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f62fb05c-a1cc-4071-f7bc-08d9ab9651bd
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2499:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2499FB8404BDAD64DC49EE6A8A9C9@BN6PR1201MB2499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WApFdWBRv0geldrs8zBuw3MBAR4zVoLPyX7qtkbJp3xp6nONmuo2VLmHZBXIQDY2VgSJPOzIUsMjQgu0HpQvrDrw0nBjPobYevGtoQxhkdfSCGKogwaxA4qWoWM/iBLGUIRzOY8rW+O5uN2ZJYwue7Xw121IZ3P104RzlcJUDuWKYtCqYw6HM0qBToRMLrm/wtwEQlKwdGk+UdmQQELcUxrkCoAE9bk53flyfRltPLEUpdK+jCtL4umsQxCgULaj5Znsylp4sdmtkAgk06QS/Hhe2VKxM5ge0f+ybEOHLeyMKH3Am8fKpnkDFuEJgeE381gNnDLYjt7TBXCTCIMtMvwsQh7sHDiPZI0bembdbdtaQ6m6zgOUSbFro8J2XgwA6v3I6GchdEoMQbNcclMTQbOPW7C0UYttfhE45adfRwxHrhqjKWCBMyeaAi6Gym9qVy5MhPlGcGurZ3hXOAMPFfJlNg6EO8JICfQoV/Vg6SWahk9AMP2Se3/pQlZHnbVZAu0AGwCWTTM8xLYN9k7QEzEQbmpYJmUjDkQ2b835ZVtXiePCYGT54316kV1xXBKSwOOSkWW32gXDmad9crORr7Ann2iYkljIiOv3Q4I9vUgmn7BnJ42f2D94QMQjZ1cOIZDrCQMoj8tBAnPr1uFOaA/csyBG33nsLeafwf9kPZxndbd9K0DzeWA0Y+EVCgXHjobqjQwc6yWFzZnQQfLNRmoyvVTd5IZLn6xekoJCs4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(336012)(26005)(6916009)(5660300002)(426003)(82310400003)(8676002)(47076005)(4326008)(356005)(2906002)(186003)(36756003)(70206006)(86362001)(7696005)(16526019)(36860700001)(81166007)(316002)(54906003)(70586007)(2616005)(8936002)(508600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:53:55.2895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62fb05c-a1cc-4071-f7bc-08d9ab9651bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2499
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initializes device_info structs given either asic_type (enum) if GFX
version is less than GFX9, or GC IP version if greater. Also takes in vf
and the target compiler gfx version.

Inclusion/exclusion to certain conditions for certain GC IP versions may
be necessary on npi bringup on a case-by-case basis, but for the most
part should be minimal (e.g. adding one || asic_version == IP_VERSION(X ,X, X) case).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e11fc4e20c32..676cb9c3166c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -511,6 +511,67 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
 
 static int kfd_resume(struct kfd_dev *kfd);
 
+static void kfd_device_info_init(struct kfd_dev *kfd,
+				 struct kfd_device_info *device_info,
+				 bool vf, uint32_t gfx_target_version)
+{
+	uint32_t gc_version = KFD_GC_VERSION(kfd);
+	uint32_t asic_type = kfd->adev->asic_type;
+
+	device_info->max_pasid_bits = 16;
+	device_info->max_no_of_hqd = 24;
+	device_info->num_of_watch_points = 4;
+	device_info->mqd_size_aligned = MQD_SIZE_ALIGNED;
+	device_info->gfx_target_version = gfx_target_version;
+
+	if (KFD_IS_SOC15(kfd)) {
+		device_info->doorbell_size = 8;
+		device_info->ih_ring_entry_size = 8 * sizeof(uint32_t);
+		device_info->event_interrupt_class = &event_interrupt_class_v9;
+		device_info->supports_cwsr = true;
+
+		if ((gc_version >= IP_VERSION(9, 0, 1)  &&
+		     gc_version <= IP_VERSION(9, 3, 0)) ||
+		     gc_version == IP_VERSION(10, 3, 1) ||
+		     gc_version == IP_VERSION(10, 3, 3))
+			device_info->num_sdma_queues_per_engine = 2;
+		else
+			device_info->num_sdma_queues_per_engine = 8;
+
+		/* Navi2x+, Navi1x+ */
+		if (gc_version >= IP_VERSION(10, 3, 0))
+			device_info->no_atomic_fw_version = 145;
+		else if (gc_version >= IP_VERSION(10, 1, 1))
+			device_info->no_atomic_fw_version = 92;
+
+		/* Raven */
+		if (gc_version == IP_VERSION(9, 1, 0) ||
+		    gc_version == IP_VERSION(9, 2, 2))
+			device_info->needs_iommu_device = true;
+
+		/* Navi1x+ */
+		if (gc_version >= IP_VERSION(10, 1, 1))
+			device_info->needs_pci_atomics = true;
+	} else {
+		device_info->doorbell_size = 4;
+		device_info->ih_ring_entry_size = 4 * sizeof(uint32_t);
+		device_info->event_interrupt_class = &event_interrupt_class_cik;
+		device_info->num_sdma_queues_per_engine = 2;
+
+		if (asic_type != CHIP_KAVERI &&
+		    asic_type != CHIP_HAWAII &&
+		    asic_type != CHIP_TONGA)
+			device_info->supports_cwsr = true;
+
+		if (asic_type == CHIP_KAVERI ||
+		    asic_type == CHIP_CARRIZO)
+			device_info->needs_iommu_device = true;
+
+		if (asic_type != CHIP_HAWAII && !vf)
+			device_info->needs_pci_atomics = true;
+	}
+}
+
 struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 {
 	struct kfd_dev *kfd;
-- 
2.25.1

