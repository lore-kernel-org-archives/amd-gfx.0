Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA73C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 21:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3456710E40A;
	Tue, 15 Feb 2022 21:23:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DFA10E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 21:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkx4FNAoAM897HTgH8TOg94EUN+2MmpKlurvleDto1yrqRv4dj2LRXT7dgJRr3fzP8fnWqMNBxVFZJo600vokGF50bCoocxqOUc+KGa3IeVUtX9u/hCArIcSLyZrCGgXWedvTCAesLqt1F5CgdKVcKL6RddsO9ylzSHfGeZsiQ6TI0NBPQtwXcytnFN4Fdha2vRjxfSbzsRRtWLuQSJrAbwuluTmkjowSBoouZxtx8FJkdikahhBbxgxw5qypxeABjBIyIBt4wGr09DLrst3Vs98mpSOCg4ezHpgTeS9OimRLWMWZPONvrVMpSju3dyyBfy8FvWnbDMvNHbxucyzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GY+/DgWr1B6w25S5DNh9Fn18JEmeXSws1CjjnJ0STh8=;
 b=I7d2sz77oSjbNGrbYSFZC+zwjd/4VbBDdGaEQ6FipE1LPGeWtMuJyM9H4Ca2h8KvqblHio4qF1jUzfB6/IAPHHroXZSaEJLwwLUFGOuePjoi2l9Rmb4dsY7XJC7sdWApt7QfPcoyoKnqyuluEO9D9DtnoECJ+kssvMP80JO/tobTjVDW90kMseTuP1wZPenx12dxcmwdEisz6le3JvBryGho8g0P0wvUQ7+W1npYW0t88cLiX/G5om7x8f391sIcnFfRgwk/kBNgq2tSDzLjmoOl4hWgO8+o5GElT2GYmNdz3o+XnJgGRT8pMdEUKXWidRj1HhE7P0l+idB7ZcK3KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GY+/DgWr1B6w25S5DNh9Fn18JEmeXSws1CjjnJ0STh8=;
 b=ebbG/DvlDwZb8BKFG+hqtZtRZ+IJRJheBH/giLlqKbXDb3MvqAxekRshd2QU2AzrTWDEjvAbh/gjgCxx9n09RG5mCg3rXgIdTzrIIss6+Q36mS/nOGzH0LHWfzGJxpfunF+x6W78hU2RYrvzIzi/1VMqIdohNFyv4G8cMPdquRE=
Received: from CO2PR18CA0061.namprd18.prod.outlook.com (2603:10b6:104:2::29)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 21:23:09 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::3c) by CO2PR18CA0061.outlook.office365.com
 (2603:10b6:104:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:23:09 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 15:23:03 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/8] drm/amdkfd: Correct SMI event read size
Date: Tue, 15 Feb 2022 16:22:41 -0500
Message-ID: <20220215212247.16228-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215212247.16228-1-Philip.Yang@amd.com>
References: <20220215212247.16228-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e699c5b-4d0b-4d9f-7fe0-08d9f0c95d3a
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5444A6B53A1CED18628B6B89E6349@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jp8M+tD/f+dTYCsKBpp1kDRVtxn8LihsRl++pXUc2k+6LgqmGxoLUDiQG5sMhzJbTrj9hZjRaYOANwCXB3vnRhQpKDegnlPleCSXzyw8SFbsoZADLhI0a3+IPCYzF0kppsl9fKv5pvKZW4aPxME3DHVZm0dLNbw/qnm6Peu2tSHN//8yXL/Fix3RXAGKKMD07FueLIhRo2LiwDo8bwz0Kn129KXTTIy4vFb0C+uoaQmaenRI61aSjJqg7mNobRLT3OWbAsL0DWsTn4Z01Q2doavPXXwxrnmGrkyDD3Vekcker0zxQ42i8JTpVYmECghQZUXEscBq8DXptSLgSsbmdDZ0jRSC8NnxKm6mliI8bzWYLkCa3/R9TwpiA4GPx+dukKrq0+4E6JrDi52QMzhpe74edpfAR4d4iT23blNFDPVlSZue75rKN9po10MPtZFPYKf5iOzVRClRbUF2nutXFXUznjoDBDy/ebhVWFj/NWkl2RiOzTtRmTqmIGArYDhq3S4mLHG/9ZS78FP9MoK/rIhJXA2iia4qWWNUslsjlRhspYLmoMjHzjWykAH1qpBKXOjJ+LjTkvdoL/hyR24MhRWPNyngYzCAqLghsBywxyPjrc9ZZ/BJ+nRngBIQPqRlhUD/YyKf/bhQNq2uJqTtFHj1hyHsVq5dvVSjVBj4Vk/lcO6vPtB8naL71s9mVUo4gmyuM358GW4ugI0dAS2ntA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(2616005)(47076005)(40460700003)(6916009)(36756003)(16526019)(508600001)(316002)(83380400001)(426003)(6666004)(81166007)(70586007)(336012)(8936002)(26005)(8676002)(86362001)(4326008)(82310400004)(7696005)(2906002)(186003)(5660300002)(1076003)(70206006)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:23:09.1124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e699c5b-4d0b-4d9f-7fe0-08d9f0c95d3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

sizeof(buf) is 8 bytes because it is defined as unsigned char *buf,
each SMI event read only copy max 8 bytes to user buffer. Correct this
by using the buf allocate size.

Use KFD_SMI_EVENT_MSG_SIZE to define msg size, the same size will be
used in user space to alloc the msg receive buffer.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index f9eafc796e70..ce78bbd360da 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -82,7 +82,8 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	struct kfd_smi_client *client = filep->private_data;
 	unsigned char *buf;
 
-	buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
+	size = min_t(size_t, size, MAX_KFIFO_SIZE);
+	buf = kmalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -96,7 +97,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 		ret = -EAGAIN;
 		goto ret_err;
 	}
-	to_copy = min3(size, sizeof(buf), to_copy);
+	to_copy = min(size, to_copy);
 	ret = kfifo_out(&client->fifo, buf, to_copy);
 	spin_unlock(&client->lock);
 	if (ret <= 0) {
@@ -183,7 +184,7 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 	 * 1 byte event + 1 byte space + 8 bytes seq num +
 	 * 1 byte \n + 1 byte \0 = 12
 	 */
-	char fifo_in[12];
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 	unsigned int event;
 
@@ -215,7 +216,7 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
 	 * 1 byte \0 = 37
 	 */
-	char fifo_in[37];
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
@@ -235,7 +236,7 @@ void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid)
 	/* 1 byte event + 1 byte space + 25 bytes msg + 1 byte \n +
 	 * 1 byte \0 = 29
 	 */
-	char fifo_in[29];
+	char fifo_in[KFD_SMI_EVENT_MSG_SIZE];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
-- 
2.17.1

