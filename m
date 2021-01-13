Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0ABC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 00:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EA32312E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 00:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EA32312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EBB8996E;
	Wed, 13 Jan 2021 00:54:28 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700050.outbound.protection.outlook.com [40.107.70.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BAB98996E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju2QOO/+GZbjtSYnumhd3KjtPzr2zB0yrdpLuxPM1/bFmuYx5qPww7azcEw08eqHWQT3UUjCcft7IGPXTMtc+L/fBeNL2LQdIBZC+nj7aPJDsTo2f/zLsTNNyIN1eKxMFCuufEKd+V8EF8gZiGp0/RgUKr9uI0I07Fko+3WD2Hi9JmHnvQExLDKa9iRie8PpsBp79URALf/LFXIrvlwP860zhuAfdKyvWp8/skjFZ1saWvoa/JxDQ5mNFI7DVIzeMkdFXxTURWTqLTvEZrENXzlwHBcj9uIPOlAc1laoelt314eATDP/LXoq1L0naIsLuhIEiF3Oh0NUfxEgEqwYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsb8eY0EkZ9wQXdhTYl6tNH4DsdEb34QLhsfakcagzQ=;
 b=BUKoRXjTXmHJpFBZBHNlvMnfoIs0I9TBc39cdCl9+k0JxoP9s6ntCP9sbR3DlbnUDnqnVSOC2tiRFSsii1gdG/pEIjkrDhRSo77ZeCOQYoghOIKknRQuDMhosqaDCxMcWecSs5n/RgyioiOXGdygY75aaEaxqQiLNjAYdv44yfsw1pFaU0YBdJb1aSnfT/P9qFjq+zfT/8nPA7YUUZCrzms91L+hYrDUQPoFLLfDBn1QvoYfeyGFNHEEDajYY6oRd3FiiuUYQkl6PJ5G9lA4QTQrr9DZu2uIgL9BZvvXbLh51p4e2YtU+A+7yHUKz0EfqA07IsMRxjqo+/cpBuMpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsb8eY0EkZ9wQXdhTYl6tNH4DsdEb34QLhsfakcagzQ=;
 b=e96lfEckRAsRvcSpjEhRDm6gV6TwyQXNb5RsjPUL2+wT47Z+vpT5pxxYxJGOqCXzPwWrj+q+CqkYEhNntAkhWJ6Qz8U+/tdeELnp1rdQMeORwmGxAj8d3F6q8DtzrwjjlS09IJ6iliKilCIya83Tt5MdpqMw602sXZ1VeA4o3lA=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.9; Wed, 13 Jan 2021 00:54:24 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::196d:529b:914e:a60a]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::196d:529b:914e:a60a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 00:54:24 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT
 interrupt work
Thread-Topic: [PATCH 2/2] drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT
 interrupt work
Thread-Index: AQHW4l887vXbH/oRiUG4Vi4a4ZyNF6ojlgDggAExo+A=
Date: Wed, 13 Jan 2021 00:54:24 +0000
Message-ID: <DM6PR12MB2602BB06DF419732C61BC49BE3A90@DM6PR12MB2602.namprd12.prod.outlook.com>
References: <1609740098-32603-1-git-send-email-xiaogang.chen@amd.com>
 <1609740098-32603-2-git-send-email-xiaogang.chen@amd.com>
 <DM6PR12MB2602BC4EAE9C70F573C504C0E3AA0@DM6PR12MB2602.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2602BC4EAE9C70F573C504C0E3AA0@DM6PR12MB2602.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-12T06:37:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0885edfe-4a3c-42a3-a80b-0000dadc764b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-13T00:54:17Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: cca9c0b9-7f37-435a-b6d0-0000adcac0aa
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [99.129.135.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bef8b191-f46b-4b91-bd82-08d8b75dc592
x-ms-traffictypediagnostic: DM5PR12MB1881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1881D8887B2E2C64997DE6B5E3A90@DM5PR12MB1881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWHSSXcJ7RBX79ktJePfuV1UTwyGmd6T2VxreGdN9khu2bC31a0IjqPzv5KxE6PMAxP4llukJzzKHQkNH1ljkHYFNAy4epoiDHm+TFDk35l6mDbnsACkHEVsfPgNNOaP5Dj7jhV8Dnnte2UqxTFaqT/e27k7Myog4ptLC+ns/FB8FUbvvmrxvQtII4dlmOH0KyBN1b7667chOXlxaOiNCmLoFf08pbfzZMULixgLmC3pkkYsdqRIk1AVXjNpkeF35GNjH+GiuYiJXO2/DKthJcaXMAavnwVfeUsO/rggO2j/bBFsE4mNsuaMY/c55e0SendyvmJTeg7VjY+w3wj9SxuiLnf6a5RKtsG5WF+25ekRY0Q9nANhBhS1gScBiiFjfWhoqcUfhJIXkmvEzmqWwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(376002)(136003)(396003)(346002)(8936002)(110136005)(66556008)(64756008)(66476007)(316002)(7696005)(6636002)(76116006)(83380400001)(8676002)(66446008)(186003)(9686003)(52536014)(55016002)(33656002)(53546011)(2906002)(6506007)(478600001)(5660300002)(86362001)(66946007)(26005)(30864003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iIW4r2pAVmEDhRgBfOQXEL+gkdHqRXGJFQbAjForSLQU+pNJQRTMv1ax49WD?=
 =?us-ascii?Q?orWP3/42BLt/wFFJsGUNROInAtDL9k/nG4QXMdUjRqLlQThigMvjvqmRqn1S?=
 =?us-ascii?Q?PpQLEbYKWDKtlFTqP4u0yEoCyXDJN2Jab99psx/yQWJQb61Pg54uNhjsVWpt?=
 =?us-ascii?Q?QUhpBYqr39Y5X4Ih9CyH965l5LBGpqbXgBFctuILdb6FmuFzIrz7r6ho28Sy?=
 =?us-ascii?Q?2Nir8Gxeq+yVt3ZYVUWrw3AZHncDkWdX89EgEd3L1mnKpd33OHAqm/012UhV?=
 =?us-ascii?Q?vJDA7WrJlppUN3/P8MkJiB5ah9Xur78y3LxyST4FLWdOrCKwQ0htQCzqDVIW?=
 =?us-ascii?Q?P/wBQmW9HO2f8mXOY3YwaSkUcIs7AJg5VR1f4tlXv1Iaeo9H7d622wVGvU3C?=
 =?us-ascii?Q?oUVrL4USslbHCtJ+QvKzlU6pQV/M/XZ9ak1eqdztIzDkYqio4tL3SNfBnJaW?=
 =?us-ascii?Q?0cwThMz2k871yfzjZDwPmqUcYBDkrzul0QabVK7F9WgXEIeoODW1bD8+B9S3?=
 =?us-ascii?Q?JH3Fl2YDP7U3R7WJUm4d8VKDxj2eZJdymRkKwF07/IsiKfl6pelTBx3RaP4U?=
 =?us-ascii?Q?a6IWRV+UDEMvuLCV3A6we7oHqK++YLq1xnjAqPc4Ki4ZDOaCvDjNb5rPG/hz?=
 =?us-ascii?Q?aTxVB7NJl55vtcayLmjXrZfyeqsKj//uxKUDPu/eXNRQtZ9Ob3I4q1rp/3hg?=
 =?us-ascii?Q?eRfKrAnzFvfbXPomJJ1EebsRou7wLP4eD9cKyntWD038Xw/saXNDVDtjIq/j?=
 =?us-ascii?Q?9nrrUWjt+ep2lkAtnAwPYi6HnRiOf+kYKsQ46Ayikkzvf93O2Wqgr8SCT8rO?=
 =?us-ascii?Q?4grsgljQQ8JdAFns/irZwTY6BoqMvlro8cNC8lvldtHoxNbVvzw+au3hpAa0?=
 =?us-ascii?Q?khMuG4/0c+P9D/9g2rn4WJxg+wLPt6t4kCsDWHcLlqSy6WIFWRwuz7s1KWez?=
 =?us-ascii?Q?L2OmOVC03J3L/embZNT0ExcXrz8pcoDhd8WVLJ/0HGU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef8b191-f46b-4b91-bd82-08d8b75dc592
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 00:54:24.6895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyJXF6zOHD8pbjuja7OLAZ4HDsqPDT178M8HwDi+gt7l2GBGYZ5EyIdhLMQ5JnM8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
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


Would you give review?

Thanks
Xiaogang

PS: Remove drm mailing list as this patch addresses amd display specific.

-----Original Message-----
From: Chen, Xiaogang 
Sent: Tuesday, January 12, 2021 12:38 AM
To: amd-gfx@lists.freedesktop.org; Wentland, Harry <Harry.Wentland@amd.com>; dri-devel@lists.freedesktop.org; airlied@linux.ie
Subject: RE: [PATCH 2/2] drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT interrupt work

[AMD Official Use Only - Internal Distribution Only]

Any comment?

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Monday, January 4, 2021 12:02 AM
To: amd-gfx@lists.freedesktop.org; Wentland, Harry <Harry.Wentland@amd.com>; dri-devel@lists.freedesktop.org; airlied@linux.ie
Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT interrupt work

From: Xiaogang Chen <xiaogang.chen@amd.com>

amdgpu DM handles INTERRUPT_LOW_IRQ_CONTEXT interrupt(hpd, hpd_rx) by using work queue and uses single work_struct. If previous interrupt has not been handled new interrupts(same type) will be discarded and driver just sends "amdgpu_dm_irq_schedule_work FAILED" message out.
If some important hpd, hpd_rx related interrupts are missed by driver the hot (un)plug devices may cause system hang or unstable, such as system resumes from S3 sleep with mst device connected.

This patch dynamically allocates new amdgpu_dm_irq_handler_data for new interrupts if previous INTERRUPT_LOW_IRQ_CONTEXT interrupt work has not been handled. So the new interrupt works can be queued to the same workqueue_struct, instead discard the new interrupts.
All allocated amdgpu_dm_irq_handler_data are put into a single linked list and will be reused after.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  14 +--  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 114 ++++++++++++++-------
 2 files changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c9d82b9..730e540 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -69,18 +69,6 @@ struct common_irq_params {  };
 
 /**
- * struct irq_list_head - Linked-list for low context IRQ handlers.
- *
- * @head: The list_head within &struct handler_data
- * @work: A work_struct containing the deferred handler work
- */
-struct irq_list_head {
-	struct list_head head;
-	/* In case this interrupt needs post-processing, 'work' will be queued*/
-	struct work_struct work;
-};
-
-/**
  * struct dm_compressor_info - Buffer info used by frame buffer compression
  * @cpu_addr: MMIO cpu addr
  * @bo_ptr: Pointer to the buffer object @@ -270,7 +258,7 @@ struct amdgpu_display_manager {
 	 * Note that handlers are called in the same order as they were
 	 * registered (FIFO).
 	 */
-	struct irq_list_head irq_handler_list_low_tab[DAL_IRQ_SOURCES_NUMBER];
+	struct list_head irq_handler_list_low_tab[DAL_IRQ_SOURCES_NUMBER];
 
 	/**
 	 * @irq_handler_list_high_tab:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3577785..ada344a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -82,6 +82,7 @@ struct amdgpu_dm_irq_handler_data {
 	struct amdgpu_display_manager *dm;
 	/* DAL irq source which registered for this interrupt. */
 	enum dc_irq_source irq_source;
+	struct work_struct work;
 };
 
 #define DM_IRQ_TABLE_LOCK(adev, flags) \ @@ -111,20 +112,10 @@ static void init_handler_common_data(struct amdgpu_dm_irq_handler_data *hcd,
  */
 static void dm_irq_work_func(struct work_struct *work)  {
-	struct irq_list_head *irq_list_head =
-		container_of(work, struct irq_list_head, work);
-	struct list_head *handler_list = &irq_list_head->head;
-	struct amdgpu_dm_irq_handler_data *handler_data;
-
-	list_for_each_entry(handler_data, handler_list, list) {
-		DRM_DEBUG_KMS("DM_IRQ: work_func: for dal_src=%d\n",
-				handler_data->irq_source);
+	struct amdgpu_dm_irq_handler_data *handler_data =
+	 container_of(work, struct amdgpu_dm_irq_handler_data, work);
 
-		DRM_DEBUG_KMS("DM_IRQ: schedule_work: for dal_src=%d\n",
-			handler_data->irq_source);
-
-		handler_data->handler(handler_data->handler_arg);
-	}
+	handler_data->handler(handler_data->handler_arg);
 
 	/* Call a DAL subcomponent which registered for interrupt notification
 	 * at INTERRUPT_LOW_IRQ_CONTEXT.
@@ -156,7 +147,7 @@ static struct list_head *remove_irq_handler(struct amdgpu_device *adev,
 		break;
 	case INTERRUPT_LOW_IRQ_CONTEXT:
 	default:
-		hnd_list = &adev->dm.irq_handler_list_low_tab[irq_source].head;
+		hnd_list = &adev->dm.irq_handler_list_low_tab[irq_source];
 		break;
 	}
 
@@ -287,7 +278,8 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 		break;
 	case INTERRUPT_LOW_IRQ_CONTEXT:
 	default:
-		hnd_list = &adev->dm.irq_handler_list_low_tab[irq_source].head;
+		hnd_list = &adev->dm.irq_handler_list_low_tab[irq_source];
+		INIT_WORK(&handler_data->work, dm_irq_work_func);
 		break;
 	}
 
@@ -369,7 +361,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,  int amdgpu_dm_irq_init(struct amdgpu_device *adev)  {
 	int src;
-	struct irq_list_head *lh;
+	struct list_head *lh;
 
 	DRM_DEBUG_KMS("DM_IRQ\n");
 
@@ -378,9 +370,7 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)
 	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
 		/* low context handler list init */
 		lh = &adev->dm.irq_handler_list_low_tab[src];
-		INIT_LIST_HEAD(&lh->head);
-		INIT_WORK(&lh->work, dm_irq_work_func);
-
+		INIT_LIST_HEAD(lh);
 		/* high context handler init */
 		INIT_LIST_HEAD(&adev->dm.irq_handler_list_high_tab[src]);
 	}
@@ -397,8 +387,11 @@ int amdgpu_dm_irq_init(struct amdgpu_device *adev)  void amdgpu_dm_irq_fini(struct amdgpu_device *adev)  {
 	int src;
-	struct irq_list_head *lh;
+	struct list_head *lh;
+	struct list_head *entry, *tmp;
+	struct amdgpu_dm_irq_handler_data *handler;
 	unsigned long irq_table_flags;
+
 	DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
 	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
 		DM_IRQ_TABLE_LOCK(adev, irq_table_flags); @@ -407,7 +400,15 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 		 * (because no code can schedule a new one). */
 		lh = &adev->dm.irq_handler_list_low_tab[src];
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-		flush_work(&lh->work);
+
+		if (!list_empty(lh)) {
+			list_for_each_safe(entry, tmp, lh) {
+
+				handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
+									 list);
+				flush_work(&handler->work);
+			}
+		}
 	}
 }
 
@@ -417,6 +418,8 @@ int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	struct list_head *hnd_list_h;
 	struct list_head *hnd_list_l;
 	unsigned long irq_table_flags;
+	struct list_head *entry, *tmp;
+	struct amdgpu_dm_irq_handler_data *handler;
 
 	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 
@@ -427,14 +430,22 @@ int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	 * will be disabled from manage_dm_interrupts on disable CRTC.
 	 */
 	for (src = DC_IRQ_SOURCE_HPD1; src <= DC_IRQ_SOURCE_HPD6RX; src++) {
-		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src].head;
+		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
 			dc_interrupt_set(adev->dm.dc, src, false);
 
 		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-		flush_work(&adev->dm.irq_handler_list_low_tab[src].work);
 
+		if (!list_empty(hnd_list_l)) {
+
+			list_for_each_safe(entry, tmp, hnd_list_l) {
+
+				handler = list_entry(entry, struct amdgpu_dm_irq_handler_data,
+									 list);
+				flush_work(&handler->work);
+			}
+		}
 		DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 	}
 
@@ -454,7 +465,7 @@ int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 
 	/* re-enable short pulse interrupts HW interrupt */
 	for (src = DC_IRQ_SOURCE_HPD1RX; src <= DC_IRQ_SOURCE_HPD6RX; src++) {
-		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src].head;
+		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
 			dc_interrupt_set(adev->dm.dc, src, true); @@ -480,7 +491,7 @@ int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 	 * will be enabled from manage_dm_interrupts on enable CRTC.
 	 */
 	for (src = DC_IRQ_SOURCE_HPD1; src <= DC_IRQ_SOURCE_HPD6; src++) {
-		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src].head;
+		hnd_list_l = &adev->dm.irq_handler_list_low_tab[src];
 		hnd_list_h = &adev->dm.irq_handler_list_high_tab[src];
 		if (!list_empty(hnd_list_l) || !list_empty(hnd_list_h))
 			dc_interrupt_set(adev->dm.dc, src, true); @@ -497,20 +508,53 @@ int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)  static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 					enum dc_irq_source irq_source)
 {
-	unsigned long irq_table_flags;
-	struct work_struct *work = NULL;
 
-	DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
+	struct  list_head *handler_list = &adev->dm.irq_handler_list_low_tab[irq_source];
+	struct  amdgpu_dm_irq_handler_data *handler_data;
+	bool    work_queued = false;
 
-	if (!list_empty(&adev->dm.irq_handler_list_low_tab[irq_source].head))
-		work = &adev->dm.irq_handler_list_low_tab[irq_source].work;
+	if (list_empty(handler_list))
+		return;
 
-	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
+	list_for_each_entry(handler_data, handler_list, list) {
+
+		if (!queue_work(system_highpri_wq, &handler_data->work)) {
+			continue;
+		} else {
+			work_queued = true;
+			break;
+		}
+	}
+
+	if (!work_queued) {
+
+		struct  amdgpu_dm_irq_handler_data *handler_data_add;
+		/*get the amdgpu_dm_irq_handler_data of first item pointed by handler_list*/
+		handler_data = container_of(handler_list->next, struct 
+amdgpu_dm_irq_handler_data, list);
+
+		/*allocate a new amdgpu_dm_irq_handler_data*/
+		handler_data_add = kzalloc(sizeof(*handler_data), GFP_KERNEL);
+		if (!handler_data_add) {
+			DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
+			return;
+		}
+
+		/*copy new amdgpu_dm_irq_handler_data members from handler_data*/
+		handler_data_add->handler       = handler_data->handler;
+		handler_data_add->handler_arg   = handler_data->handler_arg;
+		handler_data_add->dm            = handler_data->dm;
+		handler_data_add->irq_source    = irq_source;
+
+		list_add_tail(&handler_data_add->list, handler_list);
+
+		INIT_WORK(&handler_data_add->work, dm_irq_work_func);
 
-	if (work) {
-		if (!schedule_work(work))
-			DRM_INFO("amdgpu_dm_irq_schedule_work FAILED src %d\n",
-						irq_source);
+		if (queue_work(system_highpri_wq, &handler_data_add->work))
+			DRM_DEBUG("__func__: a work_struct is allocated and queued, "
+					 "src %d\n", irq_source);
+		else
+			DRM_ERROR("__func__: a new work_struct cannot be queued, "
+					  "something is wrong, src %d\n", irq_source);
 	}
 
 }
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
