Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4389C43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 17:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7955124679
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 17:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xy6FGmI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7955124679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B35A6E115;
	Fri, 20 Dec 2019 17:18:12 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D135C6E115
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 17:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXJNNX+spmloBn5uBcSUB52/zVr3vDhbIKI6VY9rG0kLOQ+tg7TwIvCEreW26G271x8/umKHD4MgBExA8K7fRnK1ohykz8lSqQDtX/3Kl8X32uzJeZwEF6CnfR/4O/HsBbcICaYbbkVa3MjJ2dJIazvH6SbOL7OhpoDxgBide3qgfJldApso29Hb1YHeesHiRC4dlFe0zj/PZcvw5Kl+fJp+tzWWpv9hW6lFbjbllDY7uK8czEEdCUtzxpnGiLpGPBIOh9gXT5C2RhstWgpYnukpB/aOhJ01hKXA4yFBH5WCL4xrXQhAsJjSXDRHDr1zUDGHjcR2BXrDb0mvHH0Zhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiHnqklRyWd4fztHde/zBUDnH2sG+WosE5ZnRHop9IQ=;
 b=dfW7SM4GBFNfdbBkRMThexY7DasJTqnBcsTlFM0DEOTt6ljvebCMAaLmatL7Q6V/GPqEiogZEmVbChQwQsiqMejFjt8AGCzptqOYKOVZg2ojJOnajT4TzYQHNhGO/vMB3bnPo8N24rughYuRKQu/oAfmOPgLS5eb2wW6QoF1gbDN6jT/eRjelBWGVRT2ZvhINmxzYGyzjnJLt8NoFjCAW113yTgmy+6sXuoU3u5bIluob2Fjt+lczmf2xnAK1b+vZemi7dSOH+zrvF6pSgDL4QT9faIhLuOq6jRvHi4bK3YjEBL/kot3PuCg/rxO21aWefv07p2F8tEcODoZj87fow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiHnqklRyWd4fztHde/zBUDnH2sG+WosE5ZnRHop9IQ=;
 b=xy6FGmI/v0IWTXQnkud3AqxCT+gBxK9xxMv3U/3pFEA6gNEtvx1RS4lbLi8ucrPHUPa0QQ8QfuWwlaADVeSs9nGcW1r34RNa6igWCqR0KO3gpsmQHr//S7JOz2yW8aycaDukqmxC20NS98cU4cfD7FV6mG/lkupf3IT7S7HOFhg=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Fri, 20 Dec 2019 17:18:09 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::e84c:efb8:bd6c:1d9c%6]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 17:18:09 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdkfd: Improve HWS hang detection and handling
Thread-Topic: [PATCH 3/4] drm/amdkfd: Improve HWS hang detection and handling
Thread-Index: AQHVtw/F4htYvH/sjk6SjSSZ1W+mh6fDN9Lw
Date: Fri, 20 Dec 2019 17:18:08 +0000
Message-ID: <BL0PR12MB25802CC3D8C9C39ECA2B8FD8802D0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
 <20191220083001.30607-3-Felix.Kuehling@amd.com>
In-Reply-To: <20191220083001.30607-3-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-20T17:18:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c663d1c0-52c0-413c-ba1e-0000b6bd3123;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-20T17:18:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2aba0dd5-3793-4dbd-b9db-0000001fed2a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82a04928-3607-443a-3245-08d7857095c4
x-ms-traffictypediagnostic: BL0PR12MB2580:|BL0PR12MB2580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2580D86F750291BDD303EDA2802D0@BL0PR12MB2580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(43544003)(199004)(189003)(13464003)(2906002)(86362001)(53546011)(45080400002)(966005)(64756008)(186003)(81156014)(66946007)(8676002)(66476007)(81166006)(33656002)(6506007)(5660300002)(55016002)(316002)(9686003)(52536014)(110136005)(66446008)(76116006)(66556008)(7696005)(478600001)(8936002)(71200400001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2580;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46uTKkpyzl25Sj4wBp/W+FFUr1RWk5SfQ79JydX6EI5ftAy49pPKYQaU0VBI9BlCl3vA/oGlAmICj2WbJ/kGOxJpdUgTyNMID/s7nEmltlVHmNZVHpBfcQnfAPdKyDClcjTkH+EPVrdpjz8A+AG5AiRHNt62Q687tFF4NGSwL1x19bpfEgl1p75mv9URf8hqenLnPE4ne2+ZgYp7njp4f+emrmayA910Oz3I2G83GASWht5BOgt8wBrse+VrmVOBSPxwYsuO63+5imiMQfvxrTyjGkRHnpQYsA3Sp64yxkU/3JmaYkTDJMKL03PvqQni8Aja3acRMsQt0xvzsmgrWE3Ihqf7lExeVuayvVW5FsG39r59uVXc3whUfh2bxofnUGtPSkj+9+Pw/L4TfcyqHG9XWZTufFTO32bmXpHzy+lE+5pOwk187JeEiKHqmWJewPWXDvQIyz7Ze+Ak2UTukHAsUN8IxNP1YgkM/9KHIkT6Nw4BhB0JdUB9VnBU/bME95wOarg3FDT8MOHffL7X5higktnoCR4imUFP9ao6N3vMNmSAHlAyi3pNkeDEOzL4
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a04928-3607-443a-3245-08d7857095c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 17:18:08.9280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtj4K0Y0KJY4vLzmqGJKdC9cf79ta6Y8g5ciVcn8FmerA/qmWa8GYA758rYr/SQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2580
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

With this improvement, it is still possible that two reset be scheduled. There is a period of time after HWS hang and before kfd pre-reset is called, during which, if a thread already passed the is_hws_hang check but was scheduled out, then it will also schedule another reset. The whole sequence is:

Thread 1: call unmap_queues_cpsch, pass the is_hws_hang, scheduled out before sending unmap command to HWS
Thread 2: send unmap to HWS ->hang, schedule a reset
Thread1: before the reset worker thread is run(resetting is still false), thread1 continus, another reset is scheduled.


Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
Sent: Friday, December 20, 2019 3:30 AM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdkfd: Improve HWS hang detection and handling

Move HWS hand detection into unmap_queues_cpsch to catch hangs in all cases. If this happens during a reset, don't schedule another reset because the reset already in progress is expected to take care of it.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  3 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++++++++++-----  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c6b6901bbda3..2a9e40131735 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -728,6 +728,9 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)  {
 	if (!kfd->init_complete)
 		return 0;
+
+	kfd->dqm->ops.pre_reset(kfd->dqm);
+
 	kgd2kfd_suspend(kfd);
 
 	kfd_signal_reset_event(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 558c0ad81848..a7e9ec1b3ce3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -952,6 +952,13 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
 	return 0;
 }
 
+static void pre_reset(struct device_queue_manager *dqm) {
+	dqm_lock(dqm);
+	dqm->is_resetting = true;
+	dqm_unlock(dqm);
+}
+
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q)
 {
@@ -1099,6 +1106,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	dqm_lock(dqm);
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm->is_hws_hang = false;
+	dqm->is_resetting = false;
 	dqm->sched_running = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1351,8 +1359,17 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	/* should be timed out */
 	retval = amdkfd_fence_wait_timeout(dqm->fence_addr, KFD_FENCE_COMPLETED,
 				queue_preemption_timeout_ms);
-	if (retval)
+	if (retval) {
+		pr_err("The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
+		dqm->is_hws_hang = true;
+		/* It's possible we're detecting a HWS hang in the
+		 * middle of a GPU reset. No need to schedule another
+		 * reset in this case.
+		 */
+		if (!dqm->is_resetting)
+			schedule_work(&dqm->hw_exception_work);
 		return retval;
+	}
 
 	pm_release_ib(&dqm->packets);
 	dqm->active_runlist = false;
@@ -1370,12 +1387,8 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
 	if (dqm->is_hws_hang)
 		return -EIO;
 	retval = unmap_queues_cpsch(dqm, filter, filter_param);
-	if (retval) {
-		pr_err("The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
-		dqm->is_hws_hang = true;
-		schedule_work(&dqm->hw_exception_work);
+	if (retval)
 		return retval;
-	}
 
 	return map_queues_cpsch(dqm);
 }
@@ -1769,6 +1782,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.initialize = initialize_cpsch;
 		dqm->ops.start = start_cpsch;
 		dqm->ops.stop = stop_cpsch;
+		dqm->ops.pre_reset = pre_reset;
 		dqm->ops.destroy_queue = destroy_queue_cpsch;
 		dqm->ops.update_queue = update_queue;
 		dqm->ops.register_process = register_process; @@ -1787,6 +1801,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		/* initialize dqm for no cp scheduling */
 		dqm->ops.start = start_nocpsch;
 		dqm->ops.stop = stop_nocpsch;
+		dqm->ops.pre_reset = pre_reset;
 		dqm->ops.create_queue = create_queue_nocpsch;
 		dqm->ops.destroy_queue = destroy_queue_nocpsch;
 		dqm->ops.update_queue = update_queue; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 8991120c4fa2..871d3b628d2d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -104,6 +104,7 @@ struct device_queue_manager_ops {
 	int	(*initialize)(struct device_queue_manager *dqm);
 	int	(*start)(struct device_queue_manager *dqm);
 	int	(*stop)(struct device_queue_manager *dqm);
+	void	(*pre_reset)(struct device_queue_manager *dqm);
 	void	(*uninitialize)(struct device_queue_manager *dqm);
 	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
 					struct kernel_queue *kq,
@@ -198,6 +199,7 @@ struct device_queue_manager {
 
 	/* hw exception  */
 	bool			is_hws_hang;
+	bool			is_resetting;
 	struct work_struct	hw_exception_work;
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7Ca59ace5396cb46ed384708d78526df99%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637124274434007022&amp;sdata=g%2B57MBWpTbFzbchp6%2Bi2dfmUzYXlsf77InUj3R1XaaY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
