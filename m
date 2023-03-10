Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B870C6FD1E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 22:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F2610EA1C;
	Fri, 10 Mar 2023 22:17:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AAE10EA1C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 22:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkfxpaRczj552LgkF3umGQPXXCKDC+7BVVIt/2D4HlS7oHFl6ZXOVH5ytjW4l0LkNhpamRFsNH+LZewG8SYr/mRjeKMe9Wg/t8I2ZVl3hwAFn35eaxuU2nzTJMx4F0+kHEbG6g+d96aBXLeRfGZJBwT3a2zVsRY3AtYHOL3Je0VLXDFZOWPIDlzAtjhIgdFDzD+icziFs6LaJrr69WzdJ0g7atT512Cr5GAITd7tiRu6ODFkyLEwtjUc6H7vXuZNhqZ1AsAC6IZVZE5ACngObHrB+FGiQvnyhVp/zCm3LVmShxbGzdyWc8dyp8BpHSRGRkx9K4ITCp2qtil221O6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjYCQVukO7nZToj79V6spS7NVOx9pTkrUe6QXBW9xWA=;
 b=RsQV7RPAIvxYaxsALlmx+4Jo85h9n+sGZFiHxsclAVY/7ajXZfMuptwniZ7O0VYwGc+0gVXLvx/TA0e72KrRl2gfnmqpfJm2ofJZFB2pUV2s8ga2eFJ7hcatWfsSpkRbo4El/aFC2oh48lxqzuGvGvx6AAJED1to6ZTTDaf2ShjY3Rp5LeQZf3eatt9q4N0WPyD954Ce1+UbZ/BYAq/c7EgkjucGvYSYh931jUrMrkYYRw9xMGF7Atd0XB96doPa1CIihh/CFTqyg9JJZMIf2RNDPhVuQRu4dgN/g6ntUkoWdI8ksNclNPJsDnWoE2rg47G858T3ywWRxv8LyFJ9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjYCQVukO7nZToj79V6spS7NVOx9pTkrUe6QXBW9xWA=;
 b=CcCYwIvLfquYhHoo8X1hAZT6l9nV0S2y810R7h4WlA/DSUVibPK7fr2jGSe2tN9a/SZVlgF/rBXWbbivRDoZUNLUD5Hz1Vn7uL8FrVRsDmkJ7W3RZ0FUiJ5hmK80CNqKj1Wz6+02DD+ZhSjHDHhMdk9jNHXA6r2uGGnul08iv5E=
Received: from BN1PR10CA0005.namprd10.prod.outlook.com (2603:10b6:408:e0::10)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 22:17:08 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::f5) by BN1PR10CA0005.outlook.office365.com
 (2603:10b6:408:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 22:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.19 via Frontend Transport; Fri, 10 Mar 2023 22:17:08 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 16:17:07 -0600
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 2/2] drm/amdgpu: Dummy CS for VM sync of compute VMs
Date: Fri, 10 Mar 2023 17:16:13 -0500
Message-ID: <20230310221613.1647188-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
References: <20230310221613.1647188-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: be2d6b0c-4782-4494-fb75-08db21b53022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMbKg8JswePhkhutAorPB06CZ8xhcZEEtW1pSPBP/0eyDg0W8qytLvrL5GN8rISEqpzEjT28hUMbez3RetUMa612tD0LZqh2pNf8XPDahrFrzLZwSic4dMSaQ6mv9uPZ04+4xN1NSfibmUbacFV33tNcBtqrLhrEvW2+IOwQSMYjnjs1PDHyH6IJQkHrgG0hFZNbeSFdPrTF5S8uDBPantsFmG6luL0Km6lB3r6injSIyBbPY/+NFWX/bALsX8IFXSRzcTWTY/zdmXJa1lV6LbR2BJPwP7/sh3IcBvGU8qmPz8Ob0I3KnCa1E/5t3XPfJWo12hxz6PZSlNFI6Yk3oUNtX6TfHZ//2e+ueTEITQT3EN2/xzsu3GzsHRMe1Rt0D3cMQW2SnFFSFAP9Sw77lsOfzVztjPZBT0xQM0RqgXlxvOTrsWHKmisYQ1i6rVqs/3xBS+lXnStaaCS7MgWWkmXs9XwXsvC/co83cT/Bk+bpX782s77LIdYEwch6EePSNCxRSkVA8X0lNSAgs3GTjyGWH28vX/65tC9slgkFpyND6o65KAVC1oDnlQgFD5jjqbS+TSwWSoO4gJUvNju4BIGx+87LVu+nXyJU99lEOGU6AjzgkxhFNug8ik0g7vDRtj3v1OzTU8DMFZxp5usAlMJ4kKZMJFIDyt6y3B6jrfs02XZ25C3Rh++idEPrUPTJAScofX3uxNg0S2DZfFJOY7jxkkncr5NqyEzAto362/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(40460700003)(426003)(6666004)(47076005)(83380400001)(82740400003)(36860700001)(26005)(7696005)(186003)(16526019)(478600001)(336012)(2616005)(8676002)(2906002)(40480700001)(6916009)(86362001)(8936002)(4326008)(70206006)(5660300002)(70586007)(41300700001)(356005)(81166007)(1076003)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:17:08.3140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2d6b0c-4782-4494-fb75-08db21b53022
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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
Cc: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use dummy command submissions with a 0-sized IB on a compute VM to flush
TLBs and signal the fence in SW. This allows applications with user mode
queues to sync with asynchronous VM updates through the CS API.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index bcccc348dbe2..3f35d04bd4f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -171,6 +171,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		return -EINVAL;
 	}
 
+	if (ib->length_dw == 0 && vm->is_compute_context) {
+		/* Hack: Dummy CS. Just flush TLBs and signal the fence. */
+		r = amdgpu_amdkfd_flush_tlb(adev, vm, TLB_FLUSH_LEGACY);
+		if (r)
+			return r;
+		*f = &job->hw_fence;
+		return dma_fence_signal(*f);
+	}
+
 	alloc_size = ring->funcs->emit_frame_size + num_ibs *
 		ring->funcs->emit_ib_size;
 
-- 
2.34.1

