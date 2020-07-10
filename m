Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323EC433E3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485AB207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 08:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aDi8G8Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485AB207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57006EB9B;
	Fri, 10 Jul 2020 08:27:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389866EB94
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 08:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzVuQRhXQccgZC2CDFiMXomCKoGoPLGyjmo02YH2CIAZQwWvs+OrqBc3bqcoaZK37RnbOd5Z+NgEUyg4BXNre1Mxky0JRFIOlCJKRpor9O2Z/iD/BCbRV27vLz2j5q7vqbKKhPVmMMNn6mW47y2b/OP0xf9EXY44y2qAjROrW2F3ErtXmZw9t3U0wawexFrtRhMpMg8Cs4qUX8Cq8XrBnTVcPx/Bf9+J7yif++bhwvZoNkI0PBtW7cN1qjbegqedvNuItWD/MRYKTUKXiM2Ezqi64So2I7iV364EEqe6o3UhbaNbR3229RhXv+1m+t92+3+AEpLH/f77BJI3bD/PNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KanfbNel31yngSdsIJSAG4+yRdU8fhLjRlX9+D2JGR8=;
 b=OWVq3eE1gk3UX1LZZ57/9sD9GfvBi6lv8G2TQSYWV70lQzX197G6428HDN22A5ZjuquxxAf472mvr493SjdpPWj6H1zEMWqF9Z/b8aSl2UX0Epat6uPN4gvYelJGCBwc6ssyc1XpPCBReO9Uua05glg00YtSITxNJou/z3C9uBE6QAPCyov0M2sCTyzXDBRGcmLp5BRMFcFPdTQJ2UJ8jr315nwHsJcZ54cJ2T9XaTWTT0KlqOtnFLvKH0FXgG2HgVnPxCsSEV7AdVFDRTCe/BgfcyNYs/SqseFpBD3cthxLeIcWTA46G7fcxt6QPyCz9ArXae/RIGfE5MeyQk5btQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KanfbNel31yngSdsIJSAG4+yRdU8fhLjRlX9+D2JGR8=;
 b=aDi8G8VjWbLuLCuxRj7puIs2MqnXwAEclnGDv0KOavg8MBu0KjJvhbj1SH8O+c8A4Ba0Uyp6IfTqpDRLa6RAaFWlJlTyAtkqe/Do/5jiMXCqblHBdf6Q40ANhvSqiLoKJPmrYU4+CQNN798MsNd1kk8h8F7yJRlI+ogYxmqmN2k=
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 08:26:53 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%8]) with mapi id 15.20.3174.021; Fri, 10 Jul 2020
 08:26:52 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Topic: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode
Thread-Index: AQHWVn18m6ktZHNKBkaqeZkRCPujmKkAW4+AgAAC5fCAABa/gIAABURw
Date: Fri, 10 Jul 2020 08:26:52 +0000
Message-ID: <CH2PR12MB4101A4B1EC55B266D9A6155C8C650@CH2PR12MB4101.namprd12.prod.outlook.com>
References: <20200710054626.2487-1-Wenhui.Sheng@amd.com>
 <20200710054626.2487-2-Wenhui.Sheng@amd.com>
 <DM6PR12MB40752D83CCCC8F1891FF3115FC650@DM6PR12MB4075.namprd12.prod.outlook.com>
 <CH2PR12MB41012FB7A7DE5B1F13ABC3AB8C650@CH2PR12MB4101.namprd12.prod.outlook.com>
 <DM6PR12MB4075DA10EBDBB8D3BE6F12BDFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075DA10EBDBB8D3BE6F12BDFC650@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-10T08:26:49Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9eaac970-20b4-4c80-a340-0000abf73d66
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffe030ff-548f-4cd2-a273-08d824aaffee
x-ms-traffictypediagnostic: CH2PR12MB3688:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB36889BA16EACD1C9027FF2D08C650@CH2PR12MB3688.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdi/tfX4tcdJn/j5cdHTb2gtNHYybecG9JqedURzF7AtEn9YUArirI5nI9IN2YsPtq8zz9/ry9I65GRUuENxGgZeWbimaB/LM+1nEzsJ/areVA/eo0AwJngjkKqVwWJBSr1VeQMza0SJn2ApmKVXcGxGSTarP6oqmG9V2yw7CaGZpEAG51Un91Jt7oKrcrUWXBw/lg5gdPBVlCu2dA5O/R0qeviVV4wi+I93MErqe8ulNyo5JQttPwezsXh1XrmIhZcWTCEETX1oWRRI//9G6hndseIYIyqLhySs3fmEGvHsiJLVBBbBqhA9u7llc1YcsZYMZaSZs05lBgTjGGya/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(86362001)(83380400001)(71200400001)(5660300002)(4326008)(110136005)(53546011)(6506007)(7696005)(55016002)(66556008)(478600001)(19627235002)(9686003)(2906002)(316002)(33656002)(26005)(52536014)(66446008)(186003)(66476007)(8936002)(76116006)(8676002)(66946007)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: OpIuUs1+Z+Lyhx0BqW8ZJm79xlDItUr5vSpbqz3mMkEXuvMLwX5MZSrqAZXtTm/ivKirXiooAB+5pkaRPAJFj8d4Zz41HSfCjMsXBHFz3oie6u57xstLki6bnm+Jxlbfxp0C4mIKMMpV36zUYLOA6TlxH9KTe8YbGxlw48GxhvcvbXdj2tcDblOUJa0NWzeF70X0mvxt+D6GaKB7MPJQ6lN+CokpyusSM0wmNxNTvoMtj/R00XdVrTbMn/W7VK9ISBOB1Hza0xtY448M8G+lPD/U4g13yektM/3eF/cl5xOOM8Cwgr1R53Vr2ts20xTAvkFdgOnYPlY6RYBgbX7GyCdbJTrD/XbIJKt2rtO3QE0BU7C1aJ8WqcpJGydgZN/cO5r4pjczuu+vIMqiYOvF5echXroHsMGxFlQBjliZJd5fJ/8IBxbCmPFfeCUcTGwMPIJJ3wsRE/BRaJ8s0Ul93de6ZvihX1XAAgL7KRYM3QPCdzKuak2vXVOAVbYMxrCX
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe030ff-548f-4cd2-a273-08d824aaffee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 08:26:52.9257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDfSZcPWPCMyy59nlNka9l1aWFHsbU+DhzT0Q2c3wIQvx5uydcjIsZTlCTdl6NiNO0x2xNwjpE1nGJcGsZMj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3688
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

Got it, Thanks Hawking!

Brs
Wenhui
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, July 10, 2020 4:07 PM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: add psp mode1 reset mode

[AMD Public Use]

Hi @Sheng, Wenhui,

Regarding the following corner cases that need to differentiate legacy mode 1 and new mode 1

1). Emergency start
Create a new function in amdgpu_ras.c, called amdgpu_ras_emergency_start, where only execute the emergency start for the following configuration
Vega20 with PMFW version < 0x284300

2). the use_baco logic in amdgpu_device_gpu_recovery The remaining (in_ras_intr && !use_baco) are all serving for the emergency start case. we use in_emergency_start or other proper name to replace use_baco

3). the use_baco logic in amdgpu_device_suspend_display_audio
It's safe to unified legacy mode 1 and new mode 1 to AMD_RESET_METHOD_MODE1. The same behavior from driver perspective

4). Issue PP_MP1_STATE_SHUTDOWN (i.e. PrepareMp1ForShutdown) in suspend Same as 3). PrepareMp1ForShutdown is require for the new mode 1 reset as well. Please try it

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
