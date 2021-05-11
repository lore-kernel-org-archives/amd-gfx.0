Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D64C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 08:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB9D610F8
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 08:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB9D610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AC06E9DD;
	Tue, 11 May 2021 08:07:15 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14186E9DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 08:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5ylw5FLii8LNDVhxMzOMtsR3I9DvBnrUMBr4jiL7ckbsLV+lMZ1PIC23/hmCMegmxokUISCro2EVcgznNru8Db0Lmog3jiKwLza1QuCnbbWVJBPA2GFZGVpbwMAuvIVkrDMzPMdMakoljU2b1CPJqCyQ2A+0ZXFH53CDE1Mql5YKFvClCFV53mFyB7+WPspHhkBzMVLPe8tYGQSGcszQWANQuzLAcfUscUJl3SdFfPFi6ZEbXXfMslWN7N4QSUb7J+3Eo1CVlbxReGMxZmqf1kyrgD6YzkYf6CApv2CTVFBsSsoQTzTk01gNvK16TUl9v8hqkQsYS5twTUpYMbMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rJThmokN0KS/7+c+0dd81sFfvsEhnnkK5HYgqvq4Ns=;
 b=nDiyK9qj/gv/WocJxOCENUZ79R0K7Ja+/XnjlY7ZMNQDMTpY6VrRcHtkwI/TTTbaWKN/94RBFqgj2kh52Zfja1ap8KOLCKw7Q54wN+aczz8MTogoV4L0SD2F/iq+2cHKndF+bmqISDX02nt++REYlyOA2YGPROTsscQphuA+VToXpdlb5qzTFZ5FkkicXJ1Qzz6XY2vAfpnWHiY9DgZ7nPap2Jq9Y0IUFEx7Mm0GJryjEdYXxevjbt9aR9MkW+RsSoue/OZ6/2BMgyo+CwaMyTDJPMFtkWvhno5ZRSe5gotDvMR9nHJsjaTKWT2ZzBOZ/RdKFBHWmJh9UEoahqxogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rJThmokN0KS/7+c+0dd81sFfvsEhnnkK5HYgqvq4Ns=;
 b=BcoVdW20wzPPV2S07SIgMsczfxwd3Z9keJn3mwvRrJzgyt2pY1yeIp211Upn2c+ANuW5eATeOM+83DzbXNIr7oBak7EjYzO3LiCHGn0otMGuKk/ESkKB2claIi+yKsGTWDhsUgZ6Ijgg3/6ZQO67roa4/OoDpSsLXQAgZn0G76A=
Received: from DM5PR20CA0011.namprd20.prod.outlook.com (2603:10b6:3:93::21) by
 DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Tue, 11 May 2021 08:07:11 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::87) by DM5PR20CA0011.outlook.office365.com
 (2603:10b6:3:93::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 11 May 2021 08:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 08:07:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 03:07:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 03:07:09 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 03:07:08 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: refine the poison data consumption handling
Date: Tue, 11 May 2021 16:06:57 +0800
Message-ID: <20210511080657.14628-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be8c9f3-b561-408f-078b-08d91453c752
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:
X-Microsoft-Antispam-PRVS: <DM6PR12MB378691FADFDC6BE0F1AB87F0ED539@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tq9CRr912WtrEQ2hdPPuamkHCQYxowIhX4cBeVvat0kutMUGfQqk4m3iZjNn8uR0FS4Nl1YgDvRXez/0jtQaF/rOTc7ii9mn395/ChekiIrS1L0x+rQm0HmqCLF83ZY8O4nWboAXjlVidVjdcZ3XDSo8KDAdnt/7KvINkw6qopeQpZwY0M5al9sbeSVsPtryAfW7nqCY1jROm7pB/VeU95NWfJ16ghwKATsyp+OU7HR5D+EVxOp7hVpP0+tTT+KSxNYYJIdAcsYXlb8sOhPnRcT2uNAYjgv1YzF2lI8TnSsPtRfrGTTtPseagCLiRDG8qhFdPuiGzMpNDlybkr1j1sVGbha+G/Ast4GKB/s0zIVFvn5hLCb67r1XIxzLfvQhKNuG8f7/yE77h4ZbiV2FEjxVSVTwxAhe9Zkq90g85ZEbjctk7VqJ+TUrfl8PoIqSOQAg3M+jXT3m8uuhaRT5hHkrfnpxNBl9efET3kx+9K5GqEbRF8Fgd3DxpmwFRG3GRUt8tunlZgSxSHCkMJ5JfcLX1CuWaG8BsPAEvJqJP61pAShMq6HKHMfFcgRrDc9/PHxujOCfuq9PekwT5L2VvromV/1HYNfzeiqeZQ/fPVBiR2H1nCXtUOWceHCtPansGnZ3qSzclZmu3X9hCSbvfWjYMLJEYLVho8s8Q/QrhE+9OmlhVFGjikWMvbsQ51MYaVM3sBxyeN0XpG1MHdHpxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39850400004)(376002)(396003)(346002)(36840700001)(46966006)(83380400001)(6636002)(8676002)(426003)(2906002)(8936002)(336012)(70586007)(4326008)(2616005)(70206006)(356005)(81166007)(36860700001)(82310400003)(1076003)(86362001)(26005)(7696005)(5660300002)(36756003)(82740400003)(186003)(478600001)(316002)(110136005)(6666004)(47076005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 08:07:10.7599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be8c9f3-b561-408f-078b-08d91453c752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The user applications maybe register the KFD_EVENT_TYPE_HW_EXCEPTION and
KFD_EVENT_TYPE_MEMORY events, driver could notify them when poison data
consumed. Beside that, some applications maybe register SIGBUS signal
hander. These applications will handle poison data by themselves, exit
or re-create context to re-dispatch works.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ba2c2ce0c55a..4d210f23c33c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1050,3 +1050,42 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 }
+
+void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
+{
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_hsa_memory_exception_data memory_exception_data;
+	struct kfd_hsa_hw_exception_data hw_exception_data;
+	struct kfd_event *ev;
+	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
+
+	if (!p)
+		return; /* Presumably process exited. */
+
+	memset(&hw_exception_data, 0, sizeof(hw_exception_data));
+	hw_exception_data.gpu_id = dev->id;
+	hw_exception_data.memory_lost = 1;
+	hw_exception_data.reset_cause = KFD_HW_EXCEPTION_ECC;
+
+	memset(&memory_exception_data, 0, sizeof(memory_exception_data));
+	memory_exception_data.ErrorType = KFD_MEM_ERR_POISON_CONSUMED;
+	memory_exception_data.gpu_id = dev->id;
+	memory_exception_data.failure.imprecise = true;
+
+	mutex_lock(&p->event_mutex);
+	idr_for_each_entry_continue(&p->event_idr, ev, id) {
+		if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
+			ev->hw_exception_data = hw_exception_data;
+			set_event(ev);
+		}
+
+		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
+			ev->memory_exception_data = memory_exception_data;
+			set_event(ev);
+		}
+	}
+	mutex_unlock(&p->event_mutex);
+
+	/* user application will handle SIGBUS signal */
+	send_sig(SIGBUS, p->lead_thread, 0);
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 97c36e3c8c80..9f9b1dfb9c37 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -230,7 +230,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					sq_intr_err);
 				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
 					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
-					kfd_signal_hw_exception_event(pasid);
+					kfd_signal_poison_consumed_event(dev, pasid);
 					amdgpu_amdkfd_gpu_reset(dev->kgd);
 					return;
 				}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 64552f6b8ba4..daa9d47514c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1144,6 +1144,8 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
 
 void kfd_signal_reset_event(struct kfd_dev *dev);
 
+void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
+
 void kfd_flush_tlb(struct kfd_process_device *pdd);
 
 int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
