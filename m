Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F94207BC
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iyUk0bTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F94207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282A86EB73;
	Fri, 10 Jul 2020 08:07:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01876EB73
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 08:07:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPLXwlWFDDORxXNIy/Jbq7FMwJ2TtBCQWnO5uLZj5FvRZVpEjl7cFYqYxufwfjLO0UU4Ir1qp2nk/6zOTBdaUxEF8atIZkgJkSCkrpNRVjuXr1EPTIvsCGK9+HG3BvHn1g8c2oamSwIPSqaPpn2Huh8ROWbSX8P5OuWbBZ3HbOnCejF9KAJpYaSO1uA6a8U1a6XdwWc14d2TzZebI/gah0mXaeBnZuFE002wwU9BOkRjATIXzDxP9rF/wSGhU//3ddzcuaGEzXjq7zaJmsWR4LfeIY4+O/j0UtMU7SaIcW6WbPRr16Y0NgA4q0HBn6bGUqcQyzVm9EHHKT3wFMaa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c3u6rbOj3Z12cWoj4aik0exNJix/bF3mJ5V6C3NSvk=;
 b=fEF6JPsoCjS4/519VSVSlVM4nH+q2l6vzsjxikSdYCqxPAafnYt37lfUSYVg+fnBuCKVVNJbtHcjXFoJQkMyXyTsrI2riW9ciltjdph/7Q9K30xgDPrgzXFwM/qD219lNUrd6rLrYvG6KvQk3DY/BSFTk70txv8bLXx0ybLG9FqVXiw2aRRUg5BLNsS/kh1q4B/pL2Cp9VxdXg5vwUeGjBK/rVUsImNwtHswFWlmClWgc8pxnmPRdX1UEjlV9b4smrNR5sCJ80BxRA5giqTneb9nTEXj8eP9uZeU17q1FGb1J9xsoLY/Jd01ycHf0KCvMAyMH2r8uYeXtgpyBJ+gNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8c3u6rbOj3Z12cWoj4aik0exNJix/bF3mJ5V6C3NSvk=;
 b=iyUk0bTXuGEbzma/v0SC8X3/3ibhO6wzem8j2OCg33iemMaTJ1g4CuVGUhY6oHQVYOH+oajSzlk6mF7GjvR6P0WjCpyWLpB3dZKB7ajjmU3C4cienqLihLl1yuxF15qfQsY8lW22uis1DlaMW3wC/hgoolpoSoRLrMe0JBetybI=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Fri, 10 Jul 2020 08:07:01 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 08:07:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Topic: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Index: AQHWVn1806epXjnlC0euHye63Ot9b6kAWQUQgAAHfQCAAAXFMA==
Date: Fri, 10 Jul 2020 08:07:01 +0000
Message-ID: <DM6PR12MB4075DA10EBDBB8D3BE6F12BDFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
 <20200710054626.2487-2-Wenhui.Sheng@amd.com>
 <DM6PR12MB40752D83CCCC8F1891FF3115FC650@DM6PR12MB4075.namprd12.prod.outlook.com>
 <CH2PR12MB41012FB7A7DE5B1F13ABC3AB8C650@CH2PR12MB4101.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB41012FB7A7DE5B1F13ABC3AB8C650@CH2PR12MB4101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Wenhui.Sheng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-10T06:35:10Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c7832111-3d76-42aa-9bd4-0000dacf5f0d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T08:06:58Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4e882a60-329b-4ff0-8f45-00000d0cf813
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c0902153-909b-4c09-48dd-08d824a839a4
x-ms-traffictypediagnostic: DM5PR12MB2358:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB23588857F57024FC540892FDFC650@DM5PR12MB2358.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JklNV8rRTQP0hwoPnd2MUVum7Edj9AqN13JGkesAEtF2qzZ4PJn77erF1lXml2ISUabj/j8DNd/g1GI/YllazHUhd9E7tjfyD6dpuxs8+kQtJUuHpXO5DpzwTtpJbY2eUwjFR9075g8WlW9DpvQqvsz7o0LNqgFQtjssHEYBUBR0IPCsVDLgzIzQY6TR7HrMmaXRn97t1D2mDcd7vOwGfbB09o6jyG5+OocicYFALlePruv80w1xKt5IngEDUEjaeJMoMEAP6enLHoByj4UcRb2YbnmLtNSlUWKPGYkVn3C3K6Vz3jC8wIWjAtOHQdHHp3bi/3bR0ko0lxkf14E80A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(55016002)(110136005)(9686003)(86362001)(478600001)(316002)(33656002)(83380400001)(71200400001)(5660300002)(52536014)(53546011)(7696005)(6506007)(19627235002)(66446008)(66556008)(66946007)(66476007)(64756008)(76116006)(2906002)(26005)(4326008)(8936002)(186003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LauzW3WGpbAK/9+WikFQwLx13zNCI3DUgYFkzCHoMuR9AOb2pl0ehCpNrUCkNa/WfuaOAxtt9HhpVDn2m52qkGmlC6oP0IRENkob4iC93G6VSxqupxLymieyyDmwzM66uXyafwesqbZ1qO/DLEQ4eaLvUJL7IunAzYDbgPeqzj9+sHMIz8g2FF/APnORZk/oqhZoh+nBVGRNnGZ5Q9CNUULI9cT9XiHriu29X9wOzriTAL3ac+dkjCoeFIy3l0Jv/FG8CPlirdJnllq6QtWNSBd7fhfGeRnVP1uRK2WDLddjPcNIVrTvUohz6VKd7DMESocpX5GVwnx9nNYxiNWFgZwkKffGNRB7CgBQaiU1mGlV/WU3DPjJ1nju2+97He9wduo1kDGsvfpSnkJyBXvkmdosJymwqYJ2pRGPInQ9vzG08z9cjQi5LS6jmTGayFGEl2QUUQXTIa9A2YsfPq6uuPsSZWGy+6SgMytMZNA1I2ReB8Z8bP0/yNSYeDTcDNpH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0902153-909b-4c09-48dd-08d824a839a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 08:07:01.1475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3d34eaksBqOncCOtzT5wxQUUOeLlfHtgtPCcJYoUAk29Q0jIXLBnXSxD0DCIx2RK3uMB+2CA3kpISWyJz3/tLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi @Sheng, Wenhui,

Regarding the following corner cases that need to differentiate legacy mode 1 and new mode 1

1). Emergency start
Create a new function in amdgpu_ras.c, called amdgpu_ras_emergency_start, where only execute the emergency start for the following configuration
Vega20 with PMFW version < 0x284300

2). the use_baco logic in amdgpu_device_gpu_recovery
The remaining (in_ras_intr && !use_baco) are all serving for the emergency start case. we use in_emergency_start or other proper name to replace use_baco

3). the use_baco logic in amdgpu_device_suspend_display_audio
It's safe to unified legacy mode 1 and new mode 1 to AMD_RESET_METHOD_MODE1. The same behavior from driver perspective

4). Issue PP_MP1_STATE_SHUTDOWN (i.e. PrepareMp1ForShutdown) in suspend
Same as 3). PrepareMp1ForShutdown is require for the new mode 1 reset as well. Please try it

Regards,
Hawking

-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Friday, July 10, 2020 14:53
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

[AMD Public Use]

Hi @Zhang, Hawking

I tried to hide mp0/mp1 mode1 reset under AMD_RESET_METHOD_MODE1,  while it seems that we need to tackle the difference in function amdgpu_device_gpu_recover, like following change in 3rd patch:

@@ -4275,16 +4277,18 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	struct amdgpu_device *tmp_adev = NULL;
 	int i, r = 0;
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
+	bool is_full_reset = false;
 	bool audio_suspended = false;
 
+	if ((amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ||
+	    (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_MODE1))
+		is_full_reset = true;

That's the reason I add new AMD_RESET_METHOD_PSP_MODE1.

Brs
Wenhui

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, July 10, 2020 2:35 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

[AMD Public Use]

Hi @Sheng, Wenhui,

I'm thinking of hiding the MP0/MP1 mode 1 reset under AMD_RESET_METHOD_MODE1. the callback function reset is per ASIC function, where nv_asic_reset and soc15_aisc_reset serve for NV series and pre-NV series respectively.

The new mode 1 reset will be used starting from sienna_cichlid. It should be quite strait forward for us to either initialize a flag like is_smu_support_mode1 during sw_init or even check the asic_type in nv_asic_mode1_reset to decide whether we use psp_gpu_reset or smu_gpu_reset.etc.

That's saying, we don't need to change the reset_method interface, where we decide whether we go to BACO/mode reset/pci config space reset.etc. We just differentiate the approach (i.e. psp or smu) in nv_asic_mode1_reset.

Thoughts?

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Friday, July 10, 2020 13:46
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

AMD_RESET_METHOD_MODE1 will be used by SMU
mode1 reset for sienna cichlid, so add
AMD_RESET_METHOD_PSP_MODE1 for psp mode1 reset.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/nv.c            | 6 +++---
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 6 +++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4de93cef79b9..0682a270c17b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -580,7 +580,8 @@ enum amd_reset_method {
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
 	AMD_RESET_METHOD_MODE2,
-	AMD_RESET_METHOD_BACO
+	AMD_RESET_METHOD_BACO,
+	AMD_RESET_METHOD_PSP_MODE1,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fec6cf3f0c8a..565dc59a9e89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2119,7 +2119,7 @@ static bool amdgpu_device_check_vram_lost(struct amdgpu_device *adev)
 	 */
 	switch (amdgpu_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_BACO:
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		return true;
 	default:
 		return false;
@@ -4174,7 +4174,7 @@ static bool amdgpu_device_lock_adev(struct amdgpu_device *adev, bool trylock)
 	atomic_inc(&adev->gpu_reset_counter);
 	adev->in_gpu_reset = true;
 	switch (amdgpu_asic_reset_method(adev)) {
-	case AMD_RESET_METHOD_MODE1:
+	case AMD_RESET_METHOD_PSP_MODE1:
 		adev->mp1_state = PP_MP1_STATE_SHUTDOWN;
 		break;
 	case AMD_RESET_METHOD_MODE2:
@@ -4220,7 +4220,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 	 */
 	reset_method = amdgpu_asic_reset_method(adev);
 	if ((reset_method != AMD_RESET_METHOD_BACO) &&
-	     (reset_method != AMD_RESET_METHOD_MODE1))
+	     (reset_method != AMD_RESET_METHOD_PSP_MODE1))
 		return -EINVAL;
 
 	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 356849136d1d..1d27dd3676ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -265,7 +265,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -274,7 +274,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -310,7 +310,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev) && smu_baco_is_support(smu))
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int nv_asic_reset(struct amdgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8c739b285915..86ce2f165038 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -479,7 +479,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
-	dev_info(adev->dev, "GPU mode1 reset\n");
+	dev_info(adev->dev, "GPU psp mode1 reset\n");
 
 	/* disable BM */
 	pci_clear_master(adev->pdev);
@@ -488,7 +488,7 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
 
 	ret = psp_gpu_reset(adev);
 	if (ret)
-		dev_err(adev->dev, "GPU mode1 reset failed\n");
+		dev_err(adev->dev, "GPU psp mode1 reset failed\n");
 
 	pci_restore_state(adev->pdev);
 
@@ -559,7 +559,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
 	if (baco_reset)
 		return AMD_RESET_METHOD_BACO;
 	else
-		return AMD_RESET_METHOD_MODE1;
+		return AMD_RESET_METHOD_PSP_MODE1;
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
