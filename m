Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8913EC4727E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 15:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C7E206F7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R4iFbH4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C7E206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED9B89A35;
	Wed, 30 Sep 2020 15:56:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F9B89A35
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 15:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehAD99iUnC4Ns1gC7u5rTJe6oihuFQ3lymbr+IYIcJrPC5Wfj9I1NMpx7NVzZ84huz4DGYIDH6wSMG2ZjIYt4CMaDdkC4H9gqw/KlcJQQWWLSxfilaSkxlRBcQEPqcAkrCchNmD41biJk0pscWUCA/wD36Z6g3Hg6T8kEv5ZOwvZl5PZh6t5vVbkUyyxT1AN5CLiZMJOSYECMP38Jr2b/DKxYLWINzmrZnxf7tvir7HzycZKcG74O1k8+K5ugkdgRFFBLeDz17ihKNBuTsPiJbHTfwnOzO7Z16rMFp/UO96KB8tE9mfRMmkEOtfqZWDgNOqV7FLNNIj7XQSIazRo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CeGe/1tfujQuvxdX1Y05vCgYU7uSuJUmBW6z0OGN8U=;
 b=UwrJ640WqQ+MnUviPQq0cySk++Qo1PlIE7j41t/Ammcx1h4hIsCExQy5vJU/D4+r/7Mia1+1GAWFUenua4whL+dOfdnzHGikSNiHoYvd/zQ0PLVM8PSzd9iNyAkd3SaMJs8L4u4ph62xA/M56BrakOSFBcRLIPoq5kYSOEGlq7wm71HPm/62wrduDb2iCskR/WgJ9tETTdPRxuFc7YzVHZ+homMTa6ThabYWzu62vOnK9OdMwVphaB78gnYKZAfTnyHQGNuZHihtjR5p61whmo/hFQ5Pqnx0d4xSDbx3ef+GJDXMpckl6AUZf/xKFoKCver+/LMUsVfda1zAridMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CeGe/1tfujQuvxdX1Y05vCgYU7uSuJUmBW6z0OGN8U=;
 b=R4iFbH4eWtkZ4ye/08tRrkOvNs9RKED+PZWbuPNMgYMVpCPLuxiGJTPljmO95IH/GYhoraV2yeadF+k/lGQWpN0GN9qM4Fzrol6vm8ZDYCb4xrjYS9mZbQNwGvWorG5844AnJB2yegc9kVPokthEMsx5XI9Q/G7EOAbbi7usizs=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM5PR1201MB0012.namprd12.prod.outlook.com (2603:10b6:3:e7::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36; Wed, 30 Sep 2020 15:56:02 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 15:56:02 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amd/amdgpu: Define and implement a function that
 collects number of waves that are in flight.
Thread-Topic: [PATCH 3/4] drm/amd/amdgpu: Define and implement a function that
 collects number of waves that are in flight.
Thread-Index: AQHWloW+gkSd71SkFU+koIsSj5AJVamAJzfg
Date: Wed, 30 Sep 2020 15:56:01 +0000
Message-ID: <DM6PR12MB276164B54DE4C82CB74007FC8C330@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200929172611.24980-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200929172611.24980-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-30T15:55:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3e72c91a-304c-4c2e-b8f4-838f4dd69c83;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:f5c7:44e5:3b68:a5fa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b4eb49e-fe16-4f68-b644-08d8655954ad
x-ms-traffictypediagnostic: DM5PR1201MB0012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB001246B0F36C0C86CA110F2F8C330@DM5PR1201MB0012.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDOX7XM64FgEThXILZDq7RGMiwTFo+Hfic/AO5IkqZ/BRG9Hj0AvA8ApjKJzmzOebkte3PwdhMQeVXpI0UaNXnV4xY+tlNPppivZgxTcUQ3FcxGO59eBGEWNoSPnOKrK9Kugew7Sb+8YWqVv/pbLyg6755Bwpz/9Ha8jCe0RCHo81u7N+d7Xo+194kIpdVbr2zd2iMXWAzJ+7ahms1WRpw0YwhlmijBNCdvSrqed6v1ruf/gZuPythuKuitxpLCzmTEez/OVBIkqXIulykdvPWPOmNC8a2Nh6mVgK0r+HQrgzsqmOmIIcunduKIG5pVcMcHvrQak5beHldQP7ZSIf0WdFqg17/6jVXgQK0xnHyI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(8676002)(71200400001)(8936002)(55016002)(4326008)(86362001)(45080400002)(2906002)(33656002)(478600001)(66946007)(76116006)(110136005)(316002)(53546011)(6506007)(966005)(83380400001)(186003)(7696005)(66446008)(66476007)(66556008)(5660300002)(52536014)(64756008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: A+Jmf8/AiLgdKcGtzB3KUEwSBTGZZZaYML2oVLKg39TCtAF3TwQ51rBD77NypdnQ0MfO6vJKCnsQjiwoAflGbMOLpqMKKKNPAWTvoG7T3aUy6KJ2sgSBLEEgYE0sME9FuFHX9fG4eUExArQYyfRTVisvh/Ji8rZQN8kv7CkwyvaXKuOAUZAeZ6hCSb0Fn4lFV4pt1kRzUwLySgXP2TVl+a/4u5rZtTO9jrMNFtT4LXXo+lBc95IYhI0oL7jp0UxgaqC/AGXfCvNgITsRg+dYxsIZcqmo+jUrzyC/pWYNPNUoCQ1zsrHzZqLoM2gVa4Q3FpxZtB7tEXySEchmnGk5aXj4AHnKqWxOgwIro2qxxHLSOMiM2Uuf0FnIdU3dn9ArjY+jySMv27bdCCkL1LcpyVEj58NJYSiltPE3GqkshXARINdFbKJSubsOnIzT1MznnrCPp6MYX637EfzBFH0AJUbDGrwpBb1eQTQkefmW2S3TatM+5wW1+36wS0cZ1BqZno7RLNsakgDYb1oOQ/9qxAj9wCb7WM0fcWuHizgnUstn6I2QAVKsSQLfou4SQM1o1a6yBTYrOciGnhqV9TM9S7xEP09FFEvJJGstX0QmG4Zgw7wFAYpaDNewoxKAENLruacuveZrN18Ec2ihYLH2HF5ahciBKeH44UFv1N1OwV440zW+tTre56j23ANwFNuCRrsx5Ig9BgqSgng9+cVrlA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4eb49e-fe16-4f68-b644-08d8655954ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 15:56:01.8941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjS5woe5vBULwy8yHPmCIkv2Yrd57a8lw7ZQrW+MQTNw4wiZxaX5nkpDao1ufz5R7bxBSjpXCv2s6inZA1EmLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Minor typo. See below. With that fixed this patch is
Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
Sent: Tuesday, September 29, 2020 1:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 3/4] drm/amd/amdgpu: Define and implement a function that collects number of waves that are in flight.

[Why]
Allow user to know how many compute units (CU) are in use at any given
moment.

[How]
Read registers of SQ that give number of waves that are in flight
of various queues. Use this information to determine number of CU's
in use.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 176 +++++++++++++++++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  12 ++
 2 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e6aede725197..14a0f277e53e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -38,7 +38,7 @@
 #include "soc15d.h"
 #include "mmhub_v1_0.h"
 #include "gfxhub_v1_0.h"
-
+#include "gfx_v9_0.h"
 
 enum hqd_dequeue_request_type {
 	NO_ACTION = 0,
@@ -706,6 +706,179 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct kgd_dev *kgd,
 	gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
 }
 
+static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->srbm_mutex);
+	mutex_lock(&adev->grbm_idx_mutex);
+
+}
+
+static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
+{
+	mutex_unlock(&adev->grbm_idx_mutex);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/**
+ * @get_wave_count: Read device registers to get number of waves in flight for
+ * a particular queue. The method also returns the VMID associated with the
+ * queue.
+ *
+ * @adev: Handle of device whose registers are to be read
+ * @queue_idx: Index of queue in the queue-map bit-field
+ * @wave_cnt: Output parameter updated with number of waves in flight
+ * @vmid: Output parameter updated with VMID of queue whose wave count
+ * is being collected
+ */
+static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
+		int *wave_cnt, int *vmid)
+{
+	int pipe_idx;
+	int queue_slot;
+	unsigned int reg_val;
+
+	/*
+	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
+	 * parameters to read out waves in flight. Get VMID if there are
+	 * non-zero waves in flight.
+	 */
+	*vmid = 0xFF;
+	*wave_cnt = 0;
+	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
+	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
+	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
+	reg_val = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
+			 queue_slot);
+	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
+	if (*wave_cnt != 0)
+		*vmid = (RREG32_SOC15(GC, 0, mmCP_HQD_VMID) &
+			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
+}
+
+/**
+ * @kgd_gfx_v9_get_cu_occupancy: Reads relevant registers associated with each
+ * shader engine and aggregates the number of waves that are in flight for the
+ * process whose pasid is provided as a parameter. The process could have ZERO
+ * or more queues running and submitting waves to compute units.
+ *
+ * @kgd: Handle of device from which to get number of waves in flight
+ * @pasid: Identifies the process for which this query call is invoked
+ * @wave_cnt: Output parameter updated with number of waves in flight that
+ * belong to process with given pasid
+ * @max_waves_per_cu: Output parameter updated with maximum number of waves
+ * possible per Compute Unit
+ *
+ * @note: It's possible that the device has too many queues (oversubscription)
+ * in which case a VMID could be remapped to a different PASID. This could lead
+ * to an iaccurate wave count. Following is a high-level sequence:


Typo > inaccurate

+ *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
+ *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
+ * In the sequence above wave count obtained from time T1 will be incorrectly
+ * lost or added to total wave count.
+ *
+ * The registers that provide the waves in flight are:
+ *
+ *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON if a
+ *  queue is slotted, OFF if there is no queue. A process could have ZERO or
+ *  more queues slotted and submitting waves to be run on compute units. Even
+ *  when there is a queue it is possible there could be zero wave fronts, this
+ *  can happen when queue is waiting on top-of-pipe events - e.g. waitRegMem
+ *  command
+ *
+ *  For each bit that is ON from above:
+ *
+ *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
+ *    number of waves that are in flight for the queue at specified index. The
+ *    index ranges from 0 to 7.
+ *
+ *    If non-zero waves are in flight, read CP_HQD_VMID register to obtain VMID
+ *    of the wave(s).
+ *
+ *    Determine if VMID from above step maps to pasid provided as parameter. If
+ *    it matches agrregate the wave count. That the VMID will not match pasid is
+ *    a normal condition i.e. a device is expected to support multiple queues
+ *    from multiple proceses.
+ *
+ *  Reading registers referenced above involves programming GRBM appropriately
+ */
+static void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
+		int *pasid_wave_cnt, int *max_waves_per_cu)
+{
+	int qidx;
+	int vmid;
+	int se_idx;
+	int sh_idx;
+	int se_cnt;
+	int sh_cnt;
+	int wave_cnt;
+	int queue_map;
+	int pasid_tmp;
+	int max_queue_cnt;
+	int vmid_wave_cnt = 0;
+	struct amdgpu_device *adev;
+	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
+
+	adev = get_amdgpu_device(kgd);
+	lock_spi_csq_mutexes(adev);
+	soc15_grbm_select(adev, 1, 0, 0, 0);
+
+	/*
+	 * Iterate through the shader engines and arrays of the device
+	 * to get number of waves in flight
+	 */
+	bitmap_complement(cp_queue_bitmap, adev->gfx.mec.queue_bitmap,
+			  KGD_MAX_QUEUES);
+	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
+			adev->gfx.mec.num_queue_per_pipe;
+	sh_cnt = adev->gfx.config.max_sh_per_se;
+	se_cnt = adev->gfx.config.max_shader_engines;
+	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
+		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
+
+			gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
+			queue_map = RREG32(SOC15_REG_OFFSET(GC, 0,
+					   mmSPI_CSQ_WF_ACTIVE_STATUS));
+
+			/*
+			 * Assumption: queue map encodes following schema: four
+			 * pipes per each micro-engine, with each pipe mapping
+			 * eight queues. This schema is true for GFX9 devices
+			 * and must be verified for newer device families
+			 */
+			for (qidx = 0; qidx < max_queue_cnt; qidx++) {
+
+				/* Skip qeueus that are not associated with
+				 * compute functions
+				 */
+				if (!test_bit(qidx, cp_queue_bitmap))
+					continue;
+
+				if (!(queue_map & (1 << qidx)))
+					continue;
+
+				/* Get number of waves in flight and aggregate them */
+				get_wave_count(adev, qidx, &wave_cnt, &vmid);
+				if (wave_cnt != 0) {
+					pasid_tmp =
+					  RREG32(SOC15_REG_OFFSET(OSSSYS, 0,
+						 mmIH_VMID_0_LUT) + vmid);
+					if (pasid_tmp == pasid)
+						vmid_wave_cnt += wave_cnt;
+				}
+			}
+		}
+	}
+
+	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	soc15_grbm_select(adev, 0, 0, 0, 0);
+	unlock_spi_csq_mutexes(adev);
+
+	/* Update the output parameters and return */
+	*pasid_wave_cnt = vmid_wave_cnt;
+	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
+				adev->gfx.cu_info.max_waves_per_simd;
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -726,4 +899,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
+	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 };
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index fc592f60e6a0..e37b4b9f626d 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -212,6 +212,15 @@ struct tile_config {
  * IH ring entry. This function allows the KFD ISR to get the VMID
  * from the fault status register as early as possible.
  *
+ * @get_cu_occupancy: Function pointer that returns to caller the number
+ * of wave fronts that are in flight for all of the queues of a process
+ * as identified by its pasid. It is important to note that the value
+ * returned by this function is a snapshot of current moment and cannot
+ * guarantee any minimum for the number of waves in-flight. This function
+ * is defined for devices that belong to GFX9 and later GFX families. Care
+ * must be taken in calling this function as it is not defined for devices
+ * that belong to GFX8 and below GFX families.
+ *
  * This structure contains function pointers to services that the kgd driver
  * provides to amdkfd driver.
  *
@@ -286,6 +295,9 @@ struct kfd2kgd_calls {
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
+
+	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int *wave_cnt,
+			int *max_waves_per_cu);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7C18d26e9bd82745b2c12c08d8649ccdfa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637369972214631652&amp;sdata=OLI2bS7M9coJedEDBGDWapo0N0%2B6o7dvldTxXblAuEU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
