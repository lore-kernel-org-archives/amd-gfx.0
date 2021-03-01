Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A53C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5692564E07
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 11:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5692564E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AA16E5AB;
	Mon,  1 Mar 2021 11:43:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA016E5AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 11:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeLtZ55KJJW1JxUrJRMxKOq4h1iGzFAwbhc2+9Zxz8oN7LJhx6Nq6a+ayADh8VhXaB5DGYtpD5BJ49Qt9ogog5EVurguRPGBeVlZ+I3cMD5z78H04naV1DvWYXDjXEVYhXunpYnoXTQjQZWw/DXmhtpn+N4wBeTHMcK1XYgIl3YZS/xrNCT1i9HUSb4VYxcj53e98q8QrBOqM67jpJdq6z6+gXqSVZaOtzyEH9KC/ndNOItdHmypOqEMGiaorH1F0CUCQFzEdM2JToraJfZNb6KoiyHHpTjVLcXbbYMBhpC2LlGpaXxshvYYtw1P3HvAC7LmSADf/Ns5O9sWsepKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnnC44EZ3P+0xkM5UV4Xhn+4vws5Th2V38UqoLNmN9g=;
 b=lFT8C/urr6+34MAAOtyz4iXS+5iquyEWTeagWjfb1jfkBvG98E9kFv7NK07XgNoru3uvuUI+mW14xBA7bff8sCwcTiF5ZjZFx/zTEWj5S1SLAL4CPY+6oNqZs/8ducbr6l5pV/hm/JYmtnvrciAmaSvowOWU1ya3aHUj96hndj8SY8QbVC2HrWzlZBzBKc3rp1T78DCKmEqpzXMhjiF/6ymhOXylGH6CR2zyoddja7ALTvcG/DEjQS0zD0k8gfu2LGiNkrj9sfdU6EsezZifkGEzbk3jqNYWyzG26AlBTOygRpWI+W56bzpRnyF2YuVXisauUEZil0KAyL/f6sMoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnnC44EZ3P+0xkM5UV4Xhn+4vws5Th2V38UqoLNmN9g=;
 b=Y0fGdpu7aFApqdUsHHoAmmSsH5ACC3atULATiFBC2MG+0x7K6BOhHEBgChvb2CZ03zXTkp5Y1qFnvXFUD0eW13KXwZjmZE5CCD+Z/Jz5z58Ja2ecfoJHGMH20rVM6JMfs83M/PDoW7EvocrBhZcLcUEN7uynBXB7v6EAtVYDVlM=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 11:43:22 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::7c8b:b3e8:be0d:e84a%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 11:43:21 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: block hardware accessed by other threads when
 doing gpu recovery
Thread-Topic: [PATCH] drm/amdgpu: block hardware accessed by other threads
 when doing gpu recovery
Thread-Index: AQHXDovQDfomJFrIeU+I5OPbibq97KpvAYXw
Date: Mon, 1 Mar 2021 11:43:21 +0000
Message-ID: <BY5PR12MB4885CF6A9C406DC1AAAD94F9EA9A9@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210301111225.11330-1-Dennis.Li@amd.com>
In-Reply-To: <20210301111225.11330-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5d19e78e-5182-4dbb-acb4-b40f5bbf0d51;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-01T11:37:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89e6abd1-59dd-452d-955f-08d8dca73756
x-ms-traffictypediagnostic: BYAPR12MB2919:
x-ms-exchange-minimumurldomainage: lists.freedesktop.org#0
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2919B3BC155514EA7EB841F7EA9A9@BYAPR12MB2919.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: De1wKcPD0OLiKGI6fBs23oXgs7GZeTJy/4Gy7V3LqDcCIN8qpbV2cI4iHb5APGMUi8a3JGDzK1GWnM6b/pfG1id2nGmWerRfrAWd4YFds9pke2/2s0yAMOKKKaYxL2YwJ2gtbDxCMqtmrWgdips84J1r8XbX4l9+bMRILiisSSgFQe08Csgu6y1EENfyqcqhR0R1zqQASVBMvY0VpiKzopeOYi4KGa4+HjrwWIpKFHFvMdQ4Iqn5QLHbNbZksu0yy2rwbb94nvUFFcYoXzDLOn0ydMbEBcahQTsUyuQUyenZJXvFCAB8nxM0wGf2+2lR0yS6SszbuiWwcH2x3rYK64QfuJAt3qrQsSPZZTPTbcK7dUmiU9FhK6Ihwjhbf8DfnzIdH2qDgQn8mXZau8GEBAKTayAtD1B3mShxRpFAVCndIs6GaHlI0G+DAuUhQqPLGgFBoBAg1bK2149j+nOWif/iatrt7PVaRAMASA3ArKimcsK+7ZZpqqfOq4dG8cnYOnZgKyKRP6/B9fOb1o5FZoimqKQ9gdSpZqiMtlteFiqL2uH6/kzmyt8+rtl08r/kwoAVxOhc5F+Lo4lwKH2nvFSnOYLn1viPFIGPWSIuBeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(26005)(52536014)(316002)(66556008)(478600001)(8676002)(7696005)(186003)(86362001)(5660300002)(64756008)(66446008)(83380400001)(6636002)(966005)(8936002)(921005)(71200400001)(9686003)(66476007)(66946007)(45080400002)(33656002)(53546011)(2906002)(4326008)(55016002)(76116006)(110136005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PKEANIoBXIQGNVotHJLsXpczXTu/fVfJwrof/Ok/uD5g7SnbQhtxYbk67Ug3?=
 =?us-ascii?Q?9TN0hvun33tuPX+YuDe/s+1AY0fNcIX7DmmAJWU5q8cvvpvyufpynSJHC39x?=
 =?us-ascii?Q?gGI7FpVBaRT7pCqLIpI3C8cNSa8u3zRltGDNsYwJf0Jc306PTnIeTHaqpjBe?=
 =?us-ascii?Q?0zzDSDdepe0eXGyHSAmBeaWTPNDXEjlGvmYvQWK0n4oKqgNHcRfXAOwXid6p?=
 =?us-ascii?Q?s+xkD4NdysuKyHNjVaAxUDTWCEFlncwfoK13w34shfTj3DHmMxttLiO+4Ksa?=
 =?us-ascii?Q?0YGfTTpqpHVF8TQca/RnHrmW2TiSv9nQaDvLpCqnaIRMEoCACk86EegVjRCo?=
 =?us-ascii?Q?hDxwPuLvn0xMRSSCrY6KJIarsy8O+BDR2A3CnS7OiMTSXpOBks0znfmyeC4S?=
 =?us-ascii?Q?0K+95rh01xs6040GgP/+4KGh6Hy3Aem5keEST07hNIBj9X+ZgXbXKlCRFzqv?=
 =?us-ascii?Q?MscNkf5qNQcQdjqK4Vn9Qyf5Ymb5V69AlpkN/OZm2FRbYKM7NbrFXiVp1CQM?=
 =?us-ascii?Q?KnyfHb3QdhHQ9CZ80oqKeYCeO/L7+CNJNkq2G9IOPwUqwk+lgtEXdnDhFJHi?=
 =?us-ascii?Q?6IeRHJk82+HqPZdnSH7Kbdrc+br/ti4L1FLChls0tIvt6o0GZKhD+GeebETo?=
 =?us-ascii?Q?2Mqyp+ppMqTDelMTsIDRnTMFQdO+XDfCocuv0cWUoOq7buCPnPGI4xghqIJI?=
 =?us-ascii?Q?D4xP1CIsDtGueidM44KKB3onQIjB4PRJEijapak6ftjFZR8uooTlcPuLvVoZ?=
 =?us-ascii?Q?aDmHxGbJvu87zdj4bSYXB8gRkCQMasPtrjyTfB8w+amU9FEJkr5Tw7pB4iPq?=
 =?us-ascii?Q?+KJ3Zb/Mm3oGJsgr9gSCn4siOTeXCLa5PAiPgk2o5m7NdfHoxZOwb2msr4pa?=
 =?us-ascii?Q?F1dovuuGCV8+5/80vAiLDzEjTa0yalk+1nvDv/qnFM65CS3I8HOjwbBp7+WI?=
 =?us-ascii?Q?ADwF1c2liTpEaug0R7AhOvB+0S0Ep3B30Kfmv4mGpN1ozqwHlxL2TqVemoDe?=
 =?us-ascii?Q?T3vA6y+gJp0+vzulYZ91Okosh+hxQdsSEHQ7LDyrAckwZ45Xn6CwCEC5h+3C?=
 =?us-ascii?Q?T6I0KBXPkzY+omQvStiQ5zui9HHu5WgB+xe48D+wXX/c+cgzCFtPQ+uhR6x+?=
 =?us-ascii?Q?p+MtQ8l7mMhipBtfq5lr4UlPaeG/Kv5zu5F80d1ClD7cnl39Nb6G9cUhzof5?=
 =?us-ascii?Q?1SHUa93vm5EnQTrxupJqquGY8Fhh9kdOKARiEQO1QiP1Hs02AqB9GexN+NIA?=
 =?us-ascii?Q?Nj9ykHrzOu0X/z8pm3s8AMMV6CfHuuNaCj83j/7CmXQdS7smEaISft/D4JWB?=
 =?us-ascii?Q?fp4xBbBnrBW7jXvK0W3Sis4S?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e6abd1-59dd-452d-955f-08d8dca73756
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 11:43:21.7073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0YCcuQ0WKDG4/zuZgCpyM27EgwCUbcEgVM7kWVNZQP0vw94VM7f1sd4HaiPWBiL2eiGd9zMH0gnokKaqRL3yIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

For all the "locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();",  logical operator "&&" should be used,

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dennis Li
Sent: Monday, March 1, 2021 7:12 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: block hardware accessed by other threads when doing gpu recovery

When GPU recovery thread is doing GPU reset, it is unsafe that other threads access hardware concurrently, which could cause GPU reset randomly hang.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1624c2bc8285..c71d3bba5f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1033,6 +1033,7 @@ struct amdgpu_device {
 atomic_t in_gpu_reset;
 enum pp_mp1_state               mp1_state;
 struct rw_semaphore reset_sem;
+struct thread_info *recovery_thread;
 struct amdgpu_doorbell_index doorbell_index;

 struct mutexnotifier_lock;
@@ -1385,4 +1386,13 @@ static inline int amdgpu_in_reset(struct amdgpu_device *adev)  {
 return atomic_read(&adev->in_gpu_reset);  }
+
+static inline bool amdgpu_in_recovery_thread(struct amdgpu_device
+*adev) {
+if (unlikely(adev->recovery_thread != NULL) &&
+adev->recovery_thread == current_thread_info())
+return true;
+
+return false;
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71805dfd9e25..7c17a5468d43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -401,13 +401,22 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
  */
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)  {
+bool locked;
+
 if (adev->in_pci_err_recovery)
 return;

+locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+if (locked)
+down_read(&adev->reset_sem);
+
 if (offset < adev->rmmio_size)
 writeb(value, adev->rmmio + offset);
 else
 BUG();
+
+if (locked)
+up_read(&adev->reset_sem);
 }

 /**
@@ -424,15 +433,19 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 uint32_t reg, uint32_t v,
 uint32_t acc_flags)
 {
+bool locked;
+
 if (adev->in_pci_err_recovery)
 return;

+locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+if (locked)
+down_read(&adev->reset_sem);
+
 if ((reg * 4) < adev->rmmio_size) {
 if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
-    amdgpu_sriov_runtime(adev) &&
-    down_read_trylock(&adev->reset_sem)) {
+    amdgpu_sriov_runtime(adev)) {
 amdgpu_kiq_wreg(adev, reg, v);
-up_read(&adev->reset_sem);
 } else {
 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 }
@@ -440,6 +453,9 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,
 adev->pcie_wreg(adev, reg * 4, v);
 }

+if (locked)
+up_read(&adev->reset_sem);
+
 trace_amdgpu_device_wreg(adev->pdev->device, reg, v);  }

@@ -451,9 +467,15 @@ void amdgpu_device_wreg(struct amdgpu_device *adev,  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
      uint32_t reg, uint32_t v)
 {
+bool locked;
+
 if (adev->in_pci_err_recovery)
 return;

+locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+if (locked)
+down_read(&adev->reset_sem);
+
 if (amdgpu_sriov_fullaccess(adev) &&
     adev->gfx.rlc.funcs &&
     adev->gfx.rlc.funcs->is_rlcg_access_range) { @@ -462,6 +484,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 } else {
 writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 }
+
+if (locked)
+up_read(&adev->reset_sem);
 }

 /**
@@ -496,15 +521,24 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)  {
+bool locked;
+
 if (adev->in_pci_err_recovery)
 return;

+locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+if (locked)
+down_read(&adev->reset_sem);
+
 if ((reg * 4) < adev->rio_mem_size)
 iowrite32(v, adev->rio_mem + (reg * 4));
 else {
 iowrite32((reg * 4), adev->rio_mem + (mmMM_INDEX * 4));
 iowrite32(v, adev->rio_mem + (mmMM_DATA * 4));
 }
+
+if (locked)
+up_read(&adev->reset_sem);
 }

 /**
@@ -679,6 +713,11 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 unsigned long flags;
 void __iomem *pcie_index_offset;
 void __iomem *pcie_data_offset;
+bool locked;
+
+locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+if (locked)
+down_read(&adev->reset_sem);

 spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4; @@ -689,6 +728,9 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
 writel(reg_data, pcie_data_offset);
 readl(pcie_data_offset);
 spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+if (locked)
+up_read(&adev->reset_sem);
 }

 /**
@@ -708,6 +750,11 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 unsigned long flags;
 void __iomem *pcie_index_offset;
 void __iomem *pcie_data_offset;
+bool locked;
+
+locked = likely(!amdgpu_in_recovery_thread(adev)) & !in_irq();
+if (locked)
+down_read(&adev->reset_sem);

 spin_lock_irqsave(&adev->pcie_idx_lock, flags);
 pcie_index_offset = (void __iomem *)adev->rmmio + pcie_index * 4; @@ -724,6 +771,9 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 writel((u32)(reg_data >> 32), pcie_data_offset);
 readl(pcie_data_offset);
 spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
+
+if (locked)
+up_read(&adev->reset_sem);
 }

 /**
@@ -4459,6 +4509,8 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev,
 break;
 }

+adev->recovery_thread = current_thread_info();
+
 return true;
 }

@@ -4467,6 +4519,7 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
 amdgpu_vf_error_trans_all(adev);
 adev->mp1_state = PP_MP1_STATE_NONE;
 atomic_set(&adev->in_gpu_reset, 0);
+adev->recovery_thread = NULL;
 up_write(&adev->reset_sem);
 }

@@ -4609,7 +4662,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,

 dev_info(adev->dev, "GPU %s begin!\n",
 need_emergency_restart ? "jobs stop":"reset");
-
 /*
  * Here we trylock to avoid chain of resets executing from
  * either trigger by jobs on different adevs in XGMI hive or jobs on
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Caecef0bf855040342e4c08d8dca2f1aa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637501939694268859%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jqlfLSc4UOBdOlzxBC2e5Aq13HqBawnJ3t1Oz9F4M2Q%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
