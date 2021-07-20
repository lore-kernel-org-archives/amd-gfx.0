Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64436C07E9B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 22:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7F861009
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 22:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7F861009
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC3C6E479;
	Tue, 20 Jul 2021 22:05:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338406E479
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 22:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR0E6HARLIZIsrkzxAXUL8nQaKW4JPDZCZbK0xXtp2Ek4DTeHzbsBLJBZAE1ER1UKLlVn8JGJL3UGWeLEMnZUUfwobvD/ffyYisLbT6rRu+ybvfm2Y7Cs9D9Z1dQHqyYS/jXr+ijChM7eIoqTOqAu6vWV5rTk3OMATIFegP060x6lPsXqmgFIQEIt+8VX6CTTqKKZErd2JxmmGepgGU82EmdzK10nCJWszZf77SyzcIJQ7AGlhg4KySLPxyRsIIZNtQzTNYV6KNE2V/vfk1B6X/u0NsetWsUQ+qoMof2ilY4RNML6Yt1EArHEZFCDsqupkcHUyXSaWdL3b/1PC6Mvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT7ZwzG7pvoYtdV36wJlske86it2qtmB8rCn6GnlmU0=;
 b=hj7itmUJU/cJkifqwFB9950emlR8LFbCh9iv/GZ6AmrNHJG7pdAARbEUw5vSDTLA5O6DdKYxtwz/0LpjaQdCWjgTLK2RTzGajRe/vpJwCva38/TQoaeTfHHTaKlDrIwLQh+PJ9qOPwSAm4W+tziuKJWvOlQUbeYj53bKNOAtCTsijLqYMcnE9y2Qw9gV1zNX199RT+9rCUTR+eBLoPh31ZWnPsAJaqMoPeaTmXuvQn6CBQ3rcqkl5MXYwNB0SUFCuEIq1MG5zMGEyu3GYVuyQs1lpHC3pQ2d/L4RwZZhRjpJINIY+s1YPZVLh81B79rVkt0sKYxEtZTDoAg03SnhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT7ZwzG7pvoYtdV36wJlske86it2qtmB8rCn6GnlmU0=;
 b=XVZ/A35jMlTQn5iuHRxy3LKQc/pjcus4arEK+u/joqRoYIThE1iqBE14aeqYwdhM3/kdJRNIeamOBlOIDkZmY6olVV+oHDTliBRUxRqApp+v+EemVXK5Hm214gGZy+dgwM/gJMFNcwT47SxxRumvNSADImivFtebmWXkaBUzVmM=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM5PR12MB1929.namprd12.prod.outlook.com (2603:10b6:3:106::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Tue, 20 Jul 2021 22:05:40 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::d5fa:cf71:ef58:bdc7]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::d5fa:cf71:ef58:bdc7%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 22:05:40 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Update SMI throttle event bitmask
Thread-Topic: [PATCH] drm/amdkfd: Update SMI throttle event bitmask
Thread-Index: AQHXdCBBtwnu+YofeUKZcxlKfzFwQ6tMeo0A
Date: Tue, 20 Jul 2021 22:05:40 +0000
Message-ID: <DM6PR12MB276128B0A71B78DB4E0FBE488CE29@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20210708173856.3391-1-Graham.Sider@amd.com>
In-Reply-To: <20210708173856.3391-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-20T22:05:39Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6044b493-683c-469b-ac16-44d54fa5ad7c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3210e378-3d00-4020-98ff-08d94bca834e
x-ms-traffictypediagnostic: DM5PR12MB1929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB192957C1370B7AA4F2CC76B08CE29@DM5PR12MB1929.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:40;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9Fo0wQBgcZiaArIxDPQkKs5S9be0D7Bfr672Lb3MlncrJwiidlQfo28odxrq+mRVa7N+HpxgfUDmn8ZxJ+4ZS3lGx9gHeWCFWzV3XM8aeoStPcj0nqEO06GT5gh7gAZ7Pl5d5tVztagDKzxpH/SDqfXAYJdFJNGGqOm0LFibojYYul3TchJsOFTThcHDYdPicTS3/hCgmL/QTUSiO1MXMHKkv/FzctF56mPLaVnhRQrBfHm6vb2DVAEIRvJ4K+ADpFnfoe2LXqiS2t3WMAcMB4furG6XbAcCl6jr6DzWI2t9ZY5YcY1Nwx5t8XpwF0K4eLUy44ARO3SQYrUqLuUg9IMK/uwbMrnxtH6NSZXka4quexWQn8leUoupZoaGb6wE0O4eeFEoMx+YR9Ll2o4feq8ZTsnJRGI+R9XnCyepMeIZHEDyw7jVr1xFEu9jABlCMF2yJk5/Ao31vOajcPyGw+VeB5ec/74WbRxh+JwO/LNPiSRpCPjlgXORLXafPPrplPvRDt0v1FycdGIH5MBfDZPyqDezrPgREMWPzfqZrvtVsT3giRNx2oqr337ZkxOMUjbVET32qBqSvcgyDYjZ48HaoxHsCzOE3U9hEv87+uA7FGKvD3AlXuqrKmeTtV0GQo170VPOuTdKNX3X7buItQMv+p1lARFUbT2mWuJbpJKw6w5vhi8ZhkKDFT73JAK7/ikzk+Wr1cov//0gVuVrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(186003)(9686003)(478600001)(71200400001)(8936002)(55016002)(66556008)(66476007)(38100700002)(122000001)(66946007)(76116006)(2906002)(83380400001)(86362001)(52536014)(8676002)(15650500001)(64756008)(33656002)(316002)(66446008)(110136005)(53546011)(6506007)(7696005)(26005)(5660300002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YvMSvbPKmgpEu5uvI1Sx2Jyw+KuXbYsmPrEfLiIN1yxAbQAIZIk05SFuppWE?=
 =?us-ascii?Q?vCmkZ7776CdzpAxRCwzfKnXb1KpJo8p04LJk8ujOaTHQBcODoK1EJLGtFTCc?=
 =?us-ascii?Q?QsUYv+LC91ytuX4vyqCezCQg6izyldvvhvgUK2FB6//as+UNhfaccccV8dgV?=
 =?us-ascii?Q?ISyocgUa0hCmAESDNOIfblmPQEDx1uDgaTEQBctxoQ7+c9lejp4GeDizj2H2?=
 =?us-ascii?Q?YHqlupLVsTx+vvTIcfcmlRm0RtWkWDjfyfavvr91/tJkOX40Lxfkfz7os4pM?=
 =?us-ascii?Q?7/n31IEJds5iRL8KKKc/D5yN2RnPM1rUhpy0Ax+slrNHsCJvii1C+lPtWKTf?=
 =?us-ascii?Q?fUmvo34nCqdIsiSJ2/PEHtWLyHFTxOySJaucAJ8IMmzXX/xm/25ZEjfUnx5m?=
 =?us-ascii?Q?PwLlTfN19r+jf5TEys+H8vf5njI6FRAdHIEd0jWJU0gmRa9COuaNqh4MHpvt?=
 =?us-ascii?Q?Sec8hBlLIAw8IxadBqgRqJ+MYJy8x6Gz5UG1O0guLtzVSfvrDfCJ3583nIOE?=
 =?us-ascii?Q?THKUfx7j1uDVSmcZ7eNTy1PMQ3Evukfl2voEMz0kXstvyZTzeXmDl8CJWILG?=
 =?us-ascii?Q?u9mpP413HXErmd9xTxtfzPKi97jVFLcUrgFOm9BdMZj9o/IX9N6Mj3Z96tJJ?=
 =?us-ascii?Q?oyvwFR7jEzOklYieCdY1bglRcp2DUILJKAqWVsllBDRrBMT1ih1hu4LZvjic?=
 =?us-ascii?Q?A6sAnHbaIvJP+A2OypBUAGALcYB9cGbl99iG8ZLtQUVzEdLHza1YRUSwOQKS?=
 =?us-ascii?Q?TGjXIgU0kK8JQ4F9H7YQFtjk1L4kw7Pc2CM1PXI5QwyNFDdn8vV6jdMUBIfU?=
 =?us-ascii?Q?wygJDXAI0mrGqFbkfnNf+D675PnDho5lGspypRmV0zW9BYQ175ELeTwDD6a7?=
 =?us-ascii?Q?q0Z5fi8/agtENyuxvE7uoniPUXRZmd+kbY/cKHwxDtYaUk8+e696i9ThhOzS?=
 =?us-ascii?Q?qlzQA2otHkmxqAVeavsdfJWG15PHHKxsn66DTM8vvYmESTuJPlHetEyToaL6?=
 =?us-ascii?Q?mDho8sCBfUlyLTyXTpokdsDrddzkMA/gBitcgz+qWkCFTwVYIlZkz3cWEIlR?=
 =?us-ascii?Q?exHIuKbmuic3C47bFX1bGyglY0tR+SYnobqs65oPguX9Cjtx/uu0xfXK/60N?=
 =?us-ascii?Q?pfxRd8T59vmnbIS2GVPOB1cMWwaGXRE9KadcsZAq7Syu8U8jtM+RtG0eV9nF?=
 =?us-ascii?Q?coH/0xMynQj8BLabAd00ZQ4rBTR6w/gPNI9UoT7z3RLvOzPwpvUq8OBIXz+H?=
 =?us-ascii?Q?qDcigdjUvMIfJgpMyca9pv5ZmAD+67CayUTKK8T01jStHVH4vafi3KlII1Bd?=
 =?us-ascii?Q?05nSbr6rT0UiSsxMeGAKeu2T?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3210e378-3d00-4020-98ff-08d94bca834e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 22:05:40.6969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UH9OGBYKoTXdAvROyuoR5t8UBz1hZd5DASEM7NsyBKOpAZbrAFWleL9g1ePJGp3JQ4h/FXi52Zj7Air8+CEkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1929
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

[AMD Official Use Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: Sider, Graham <Graham.Sider@amd.com> 
Sent: Thursday, July 8, 2021 1:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdkfd: Update SMI throttle event bitmask

Update Arcturus/Aldebaran thermal throttle SMI event path to use
ASIC-independent throttler bits when logging.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h        |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  4 +++-
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index fabc68eec36a..9c505ac0be8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -330,7 +330,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
 void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
 void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask);
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask);
 #else
 static inline int kgd2kfd_init(void)
 {
@@ -389,7 +389,7 @@ void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd)
 }
 
 static inline
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e4a05e937f0..5b06bc308782 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1370,7 +1370,7 @@ void kfd_dec_compute_active(struct kfd_dev *kfd)
 	WARN_ONCE(count < 0, "Compute profile ref. count error");
 }
 
-void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint32_t throttle_bitmask)
+void kgd2kfd_smi_event_throttle(struct kfd_dev *kfd, uint64_t throttle_bitmask)
 {
 	if (kfd && kfd->init_complete)
 		kfd_smi_event_update_thermal_throttling(kfd, throttle_bitmask);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 246522423559..ed4bc5f844ce 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -205,23 +205,23 @@ void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset)
 }
 
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
-					     uint32_t throttle_bitmask)
+					     uint64_t throttle_bitmask)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dev->kgd;
 	/*
 	 * ThermalThrottle msg = throttle_bitmask(8):
 	 * 			 thermal_interrupt_count(16):
-	 * 1 byte event + 1 byte space + 8 byte throttle_bitmask +
+	 * 1 byte event + 1 byte space + 16 byte throttle_bitmask +
 	 * 1 byte : + 16 byte thermal_interupt_counter + 1 byte \n +
-	 * 1 byte \0 = 29
+	 * 1 byte \0 = 37
 	 */
-	char fifo_in[29];
+	char fifo_in[37];
 	int len;
 
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%llx\n",
+	len = snprintf(fifo_in, sizeof(fifo_in), "%x %llx:%llx\n",
 		       KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
 		       atomic64_read(&adev->smu.throttle_int_counter));
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index b9b0438202e2..bffd0c32b060 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -26,7 +26,7 @@
 int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
-					     uint32_t throttle_bitmask);
+					     uint64_t throttle_bitmask);
 void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev, bool post_reset);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6b3e0ea10163..6ec8492f71f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2178,7 +2178,9 @@ static void arcturus_log_thermal_throttling_event(struct smu_context *smu)
 
 	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 			log_buf);
-	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
+	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev,
+		smu_cmn_get_indep_throttler_status(throttler_status,
+						   arcturus_throttler_map));
 }
 
 static uint16_t arcturus_get_current_pcie_link_speed(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c16ca0c78e93..e1575d974315 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1627,7 +1627,9 @@ static void aldebaran_log_thermal_throttling_event(struct smu_context *smu)
 
 	dev_warn(adev->dev, "WARN: GPU thermal throttling temperature reached, expect performance decrease. %s.\n",
 		 log_buf);
-	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev, throttler_status);
+	kgd2kfd_smi_event_throttle(smu->adev->kfd.dev,
+		smu_cmn_get_indep_throttler_status(throttler_status,
+						   aldebaran_throttler_map));
 }
 
 static int aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
