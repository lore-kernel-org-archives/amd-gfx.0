Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7481CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 07:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0903510E237;
	Mon, 14 Mar 2022 07:03:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94B310E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 07:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCFG26i158QVwwCZvXMpHiqeDNgGeXuJGuLVM5lJ6CEgZKeMIbs7tllUyUpkl+ZDsG5MBmbluXF9iooIuU44XF9UYH/dpoF4krYp+5AxYPhFVSFFoXuzKRIfT24/wkQqFzSzJdHev1RzCvXgYsEU/Z/bsL7q4u8aQ60sLP4LsFe9HOH6lJsIf1KUrxTSFxJESLvMTNglDgLjdURhejQuoEWwHGUPBaAJqDOaSgk9Qlwp6x0il0WR9KeS7BnaQthPn7MhgINigpVA+ntUtjGJIpmq8mQI7cGJMced0al+vUUlrNW2LFwhFTJSreh52vfZ/4RP13rUpLQUB/HCHAr/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWuQ8ZnA3TOqKzdRji7Ved4nAicf+M4LR9Be+oqx6jA=;
 b=dNlk5Ohwwf6txXBDERJ/vWseyG4t09u9k1kwBER/pNxlqXwqNrFTxN0K4oo5r8gIa1I5DGfXN2VOo6sx4wvQY7TZLxly4q5JprRWC0PRrIEWFTajnChu07U8nXjqiaqjziKBMTRlV07tMzIOjCOMf6ZR45rxf4QJwEuFvV05ePQ07yY/cUq+bQYb9i2SpX+iAK+J/Wv/dlgIxovduYOyDin1IDdLR09pVuumlmNAm1lr56+OhlrZ6xX9GLB3ZyvYdkYJ0vrt5MTSVvw3KJ1/SUH5W5RhzsS4DqTBLSXlkNxCg36XMPp/YcAnl0IKZAOZzzClodyEMolFdJiuMVbRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWuQ8ZnA3TOqKzdRji7Ved4nAicf+M4LR9Be+oqx6jA=;
 b=RC5Dl4gI/8+/pxOUeS+zWqIN1lar4y2X49VXZEZ140xKXF7pDIDp0yhXYJ21xIQjpnwLXjBneVecim+kxAnP8Htvb7yqv1hNjkQpmYs4j/PTvlOBSq9k2xL0cenCkmm/6mjcrg6P6afEne7FUvZhZf3IYaU+8T85Z2cKuugDpjg=
Received: from BN6PR13CA0047.namprd13.prod.outlook.com (2603:10b6:404:13e::33)
 by BN6PR12MB1890.namprd12.prod.outlook.com (2603:10b6:404:106::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 07:03:47 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::48) by BN6PR13CA0047.outlook.office365.com
 (2603:10b6:404:13e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 14 Mar 2022 07:03:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 07:03:47 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 02:03:43 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for utcl2
Date: Mon, 14 Mar 2022 15:03:26 +0800
Message-ID: <20220314070326.21828-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314070326.21828-1-tao.zhou1@amd.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95e9761a-66ee-460b-5752-08da0588c923
X-MS-TrafficTypeDiagnostic: BN6PR12MB1890:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1890DF8047EC1F0B2C81A898B00F9@BN6PR12MB1890.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjx2RM/lVHc0f4zX3MiHeseV3JWuSwKepmRJd3wIt8C3d8LDhvJrz2HITo7OQdPFPFRQ5lwlzJY4RQhjIiO8TrVjF/SagqOaY9i6DYtxYjUArbV6/YdIg39ZW/8McxP/hpz+e29P7t8lJ4STAOPkNCH5vC6xlo4a3I3go8AEBhLwwUfLtZ8dmxyFG6pFMVumGDBU2EdCNFrJDjxWa3UHiPyeCS7ooFzRyotZa2VlhKrIM3p9RRSHU9PAOD/SC7p2+rwEA5SHpqoR9zwwrfNPuwrUpxel+j13s1lhxbx+4AI9yVn33R2OsvRQqQML8vMdMqASX3E+kVhbd8myhA+eYYkY0sxfjIbTYeRj/zDgavPcSLEMgtqiu48lhNX62U+QRPEvntfWLSSf2nu1DR9GgAiNFJzuWJUrTsffVdpcYpHRMi2NkwO2FhXtAax4+vAiQ02Kr7Q6TJXRhO0L63cJWy0wCQ5t6zg5yd71Zg00+9sfQHCJqnppC8GgiRtiOhVfosu6uLEXAw7IpZAek6IHSunaZhEYQqiCXkZy7abtbs+IFBZh8RZ+OTxQU2SCjUFZV8FsNeyRMc0Rd9dFdl1OcKHOVLLRv/lE3rOf1HDHTpL0Fp7O5kFMEOgxFarsf5jDd0q2R8Oq+DDSXXS8ztqZow5SSgQnLX1s+nVE/WFvnFoHwDLJFNQfW/58+zPE1/A9pUt1z9ngRvlASc+7r0dYLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(8936002)(6666004)(356005)(1076003)(70206006)(70586007)(508600001)(7696005)(16526019)(26005)(5660300002)(81166007)(186003)(6636002)(426003)(336012)(110136005)(36756003)(2906002)(83380400001)(316002)(82310400004)(40460700003)(8676002)(47076005)(4326008)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 07:03:47.0668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e9761a-66ee-460b-5752-08da0588c923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1890
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do RAS page retirement and use gpu reset as fallback in utcl2
fault handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index f7def0bf0730..3991f71d865b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 				const uint32_t *ih_ring_entry)
 {
-	uint16_t source_id, pasid;
+	uint16_t source_id, client_id, pasid;
 	int ret = -EINVAL;
 	struct kfd_process *p;
 
 	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 
 	p = kfd_lookup_process_by_pasid(pasid);
@@ -110,6 +111,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 		return;
 	}
 
+	pr_debug("RAS poison consumption handling\n");
 	atomic_set(&p->poison, 1);
 	kfd_unref_process(p);
 
@@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
+		if (client_id == SOC15_IH_CLIENTID_UTCL2)
+			ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	}
 
-	kfd_signal_poison_consumed_event(dev, pasid);
+	/* utcl2 page fault has its own vm fault event */
+	if (client_id != SOC15_IH_CLIENTID_UTCL2)
+		kfd_signal_poison_consumed_event(dev, pasid);
 
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
@@ -314,7 +320,18 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_write = ring_id & 0x20;
 
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
+
+		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
+		    dev->kfd2kgd->is_ras_utcl2_poison &&
+		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
+			event_interrupt_poison_consumption(dev, ih_ring_entry);
+
+			if (dev->kfd2kgd->utcl2_fault_clear)
+				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
+		}
+		else
+			kfd_dqm_evict_pasid(dev->dqm, pasid);
+
 		kfd_signal_vm_fault_event(dev, pasid, &info);
 	}
 }
-- 
2.35.1

