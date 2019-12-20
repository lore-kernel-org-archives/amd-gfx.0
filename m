Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1479DC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 17:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD575206A5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 17:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iTdMtq1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD575206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BD96EC77;
	Fri, 20 Dec 2019 17:22:40 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690045.outbound.protection.outlook.com [40.107.69.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02996E124
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 17:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVsWi+SgxbmXAyxp/aqvmajHdA9BdeyTeNFbGfraT/Npn1Ltwxxd3NCTe55ffOKrjsxjwmbBNS1dnZ6Z7CZ6Qzsjdge+ZJF8C1jK9mnakemht/DEyH1+0/OeRrwzh+u8DuMhYxRMu88fMWUwflW1cXwbPXQKMoY5Q8RHI6YxI5SuI1X0QCLZ2TbUF7Msiy18IVkhEt5aNHtoN6qIhWYXTV+IlYS4UTYV7Wn18tgktrYX23pOWGWd8V2rsuu7b8z4jci9vmiMi6Eq5AzRNUB7Xlyzilaia0rhY5DacZrtXo7wG0m4nTcursp7FMs1qMpq/3MJwbCb/xDxK4ABZwNDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbV2IB0hAs6Xy6yX4Np/UzugV6xOtYncG8glFnYhtVQ=;
 b=nXL+0taZpbscaXjC4d97Wc++y3LeFvaupwPwWhstXCVik5oZnHw8rzpiemfqp16TIIF03yOzUw/CDhO9BKVIzquQ/pi7b3JerATyu3NhEdi/q/RiGCOcoQ1xmjI6ijDERXCThKJ5g90TQ45e9cIEjmwFo7GuNANgIyRiQKKf1VajKx/2epp9VlthO0/hnxDPyQFHDhboIMh7u9aHJyLfdBNnS9wIV/j6NVwa5po/KkHbIAsoJa56ejDJQXWixN7sni1N8xA3Wgs5IdC2pvW/CPpaxM20o39F2vKgZoWFcBadtfIoNc7dh8GgmzBJqn8QUsg2LlAbNAQ3UzCeuV6Vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbV2IB0hAs6Xy6yX4Np/UzugV6xOtYncG8glFnYhtVQ=;
 b=iTdMtq1ENEi+NNc3paAbsjS2t5ox1J5f89DU3vwO1jI7Z9JcrBmv4pAGHedv6F+zEZtx//nugNSrSMbeclBxdLAW2WDPXqwLSimdXc+r1twwbUYmkMBASkODLbO9GTxWASpBZZVTT/okaI9augssi2uJTCgagn4AZg3SG9g4aNQ=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2562.namprd12.prod.outlook.com (52.132.29.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 17:22:37 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c%6]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 17:22:37 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch
Thread-Topic: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch
Thread-Index: AQHVtw/DdL8x2ZD3tkaM4XUXHCHR6KfDPN1Q
Date: Fri, 20 Dec 2019 17:22:37 +0000
Message-ID: <BL0PR12MB2580D024E6FF1996A61CAD6A802D0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
 <20191220083001.30607-4-Felix.Kuehling@amd.com>
In-Reply-To: <20191220083001.30607-4-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-20T17:22:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5dec2fc3-032f-4fff-b323-0000c2587f55;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-20T17:22:35Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fb61e15e-0fef-4e0e-9bc1-0000602eea6b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed34fc47-d55a-4743-6ee9-08d7857135b7
x-ms-traffictypediagnostic: BL0PR12MB2562:|BL0PR12MB2562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2562D3D3A493F32D98AE8673802D0@BL0PR12MB2562.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(13464003)(26005)(8936002)(2906002)(71200400001)(86362001)(186003)(66556008)(81166006)(76116006)(81156014)(33656002)(64756008)(8676002)(5660300002)(52536014)(110136005)(966005)(66446008)(55016002)(9686003)(316002)(45080400002)(7696005)(66946007)(53546011)(6506007)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2562;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Mk7Fsgy5BxnqluKNHqtcvMJ6TfC9BVNrKDntVM3kv8cNOYfsgbEzvRXkXKMVKbv1gto8N/E8D5MQkvfJzfES/hQIMK9Ns9b6tjVyYO9BBczU2r/tXDOtj5h4J/y4hse2EjpeXdDo8st8NCrzREqhuFYxlnG7LGHeER/haFdpG10RtQpqV+an22uMcOfNXIX2otbIBS4s+y+98yLGVDxxH5L7pI8ne5KmpgnD0GS+0JkyHDKOKGSyHG67Evka0Zlq5FXM/RsN/AiOnJ8EwNrl+y3ndffCf7i3pUk3Ue8evCWEuE8PSklAH8/XVPd7irVgjUHH3E/wLmf9uxfk6j3TdBrdLaE0IMOmqchIDo5pglZ5wQ4BR+Vl/Rdx37+UEo5wlASH22fVbo4Y0lNgwiQc1C1tPezmmVoB54CbYG+ISEnsXkjc7jXRMs0VN/jHEAKTcGNqZtFXSUFqqGKIoM9T5j6R4x2xPSQzfvdmDjuXl1qrFtkgK6A3bJpENHnaZK6tX+XeQA04qbjZmQit9zudalHQkkPrBDAg9cMae6Vnxg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed34fc47-d55a-4743-6ee9-08d7857135b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 17:22:37.3308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/Fzr19jvp/TpF9pd8QNkmGDvFuWkCo0mwvEL19utxXSjeOTdaNdrVltQdKqK71o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]



Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Friday, December 20, 2019 3:30 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdkfd: Avoid hanging hardware in stop_cpsch

Don't use the HWS if it's known to be hanging. In a reset also don't try to destroy the HIQ because that may hang on SRIOV if the KIQ is unresponsive.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c        |  8 ++++----
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c      |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a7e9ec1b3ce3..d7eb6ac37f62 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -946,7 +946,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)  static int stop_nocpsch(struct device_queue_manager *dqm)  {
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
-		pm_uninit(&dqm->packets);
+		pm_uninit(&dqm->packets, false);
 	dqm->sched_running = false;
 
 	return 0;
@@ -1114,20 +1114,24 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	return 0;
 fail_allocate_vidmem:
 fail_set_sched_resources:
-	pm_uninit(&dqm->packets);
+	pm_uninit(&dqm->packets, false);
 fail_packet_manager_init:
 	return retval;
 }
 
 static int stop_cpsch(struct device_queue_manager *dqm)  {
+	bool hanging;
+
 	dqm_lock(dqm);
-	unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	if (!dqm->is_hws_hang)
+		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
+	hanging = dqm->is_hws_hang || dqm->is_resetting;
[Oak] I don't think dqm->is_resetting is necessary. If is_resetting is true, is_hws_hang is always true. Those two flags are always the same except a period during which hws hang is detected but kfd_pre_reset is not called. In this period, hang is true but resetting is false, so "||resetting" doesn't help. 

Also see my comment on the 3rd patch.

	dqm->sched_running = false;
 	dqm_unlock(dqm);
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
-	pm_uninit(&dqm->packets);
+	pm_uninit(&dqm->packets, hanging);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2d56dc534459..bae706462f96 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -195,9 +195,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,  }
 
 /* Uninitialize a kernel queue and free all its memory usages. */ -static void kq_uninitialize(struct kernel_queue *kq)
+static void kq_uninitialize(struct kernel_queue *kq, bool hanging)
 {
-	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ)
+	if (kq->queue->properties.type == KFD_QUEUE_TYPE_HIQ && !hanging)
 		kq->mqd_mgr->destroy_mqd(kq->mqd_mgr,
 					kq->queue->mqd,
 					KFD_PREEMPT_TYPE_WAVEFRONT_RESET,
@@ -337,9 +337,9 @@ struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 	return NULL;
 }
 
-void kernel_queue_uninit(struct kernel_queue *kq)
+void kernel_queue_uninit(struct kernel_queue *kq, bool hanging)
 {
-	kq_uninitialize(kq);
+	kq_uninitialize(kq, hanging);
 	kfree(kq);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 6cabed06ef5d..dc406e6dee23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -264,10 +264,10 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 	return 0;
 }
 
-void pm_uninit(struct packet_manager *pm)
+void pm_uninit(struct packet_manager *pm, bool hanging)
 {
 	mutex_destroy(&pm->lock);
-	kernel_queue_uninit(pm->priv_queue);
+	kernel_queue_uninit(pm->priv_queue, hanging);
 }
 
 int pm_send_set_resources(struct packet_manager *pm, diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 087e96838997..8ac680dc90f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -883,7 +883,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev);  void device_queue_manager_uninit(struct device_queue_manager *dqm);  struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
 					enum kfd_queue_type type);
-void kernel_queue_uninit(struct kernel_queue *kq);
+void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
 int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int pasid);
 
 /* Process Queue Manager */
@@ -974,7 +974,7 @@ extern const struct packet_manager_funcs kfd_vi_pm_funcs;  extern const struct packet_manager_funcs kfd_v9_pm_funcs;
 
 int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm); -void pm_uninit(struct packet_manager *pm);
+void pm_uninit(struct packet_manager *pm, bool hanging);
 int pm_send_set_resources(struct packet_manager *pm,
 				struct scheduling_resources *res);
 int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index d3eacf72e8db..8fa856e6a03f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -374,7 +374,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		/* destroy kernel queue (DIQ) */
 		dqm = pqn->kq->dev->dqm;
 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
-		kernel_queue_uninit(pqn->kq);
+		kernel_queue_uninit(pqn->kq, false);
 	}
 
 	if (pqn->q) {
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7C7602eef96b0545baac8608d78526dde0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124274407587881&amp;sdata=BlPgWgLi%2FrtkcPQLu%2FbK0dOrvg6qm4IsGVfuoUo%2B%2B1g%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
