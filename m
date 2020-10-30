Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DABC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 13:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6B7206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 13:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qcULKkjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6B7206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BDB6E9A3;
	Fri, 30 Oct 2020 13:00:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F171C6E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 13:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEEV6FjkVtsmt3C62FDRqDq+d3lmrwpbmbP1X9S8EauAA4CLRAtpq6Ir/YEW2bdc64Quowj9J4Axohw1UhSvTC6Fn2eu7AyMRWt03vbWF2nU6mS+uycbgo4fLbWwyu1PtaTNUn2XdI+zi0JaoBbESPmr9xW8HwJ2CJVsCLcah4bkD8dY77ZE3AOJ8vizvxCfRKGyA6kJNtWvPjVkWYM/kPZCr92NTpRQf1pQOZeKIZv4PufFcy99Q9Rp/1UwixvwevycE4HC5s0k1cjUkr2n1PIcrsPYRq+f8vKq3TpF7mKvr8BQxnUXczY6GWSoDr3iqWkEFlCiXVWjYiy8kKYQnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B4AAQave+BX34+YPIbgQEZsYQ+tWQaiRooEHg4i3Oc=;
 b=n3KmCjcejn01XzVVMIcUVu6RqaSMiNqZMdRa71LzUq/UufFAeNrC8lgOcTux64j52iuqaMwILAGXJsRo86Jmssu9HfdWyeBPbESKQECC43E45xaXe/yy5Pr/z5NapoQ/qHlRcgmX572lhCmof4lNF7WJiPF6w/uKw4QD/02g3O0LwkGeduztxtQp9kL8oty9NXlTO2/fUzBxlgQN/2tbCnKmBCC8YqFVPRfZEcC2whxTRLEy9oINe1cXHgZXC+d+pTSQvcTot2olD9KvMI/yxhGr1HDDsKe7IUKCS9hGS2NuCrhQo3ZNex/mAms8gkWlaFPUC5rrtoS+mGBX25Z/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B4AAQave+BX34+YPIbgQEZsYQ+tWQaiRooEHg4i3Oc=;
 b=qcULKkjAcQqk0Euoczysq3Sc67+GRZ0pcI/Jq2jSLuaOl5nWzQw+H+Z6VSj0dXS50Wf/dSzdh3+qfzCMGGZCcEkbFI6R1Pak2ZFksjDvVuxZuX8m/LXpnTXUXHFr3yzGUIGrHf2oBHMn9xb6Vi0LFANXFZI1YI5h3YVKE8X7urA=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Fri, 30 Oct 2020 13:00:37 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 13:00:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Index: AQHWrrBd3Q2HThetLk6rZZhYE/MTkqmwBwfggAAFagCAAA7xkA==
Date: Fri, 30 Oct 2020 13:00:36 +0000
Message-ID: <DM6PR12MB40759475D8727038A78C1985FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201030113225.12675-1-tianci.yin@amd.com>,
 <DM6PR12MB407500CE6EB454B4DA0AE713FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB15464C58F1DEBA74E9F8BF2895150@DM5PR12MB1546.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB15464C58F1DEBA74E9F8BF2895150@DM5PR12MB1546.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-30T12:05:08.120Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-30T13:00:33Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Standard
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 455c0fdb-7a43-4074-9568-00007bb3fb53
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c7fc6a2-12ff-4f11-ded5-08d87cd3cbc7
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3274F7099A2E6344F5C2534AFC150@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 92L8NpOC0njUq6Gfr1GXoUtXdSDdwyk/bRXf3Hh0Yz66vsNBmB0cUL5hgzuIBgw7oqZg6mbPgE86NOqLHMhjDOJ33LegHg6I95vMXkB0OJ5DgP2BbGpP+b7rfOS9C9LGdicJT12iiGM/CQfTlXzZnc87b7Z3L6oQnmRc8BvpF+FA4OiBajSRgPoj/10Uj9k5gIaG7mlxgG0/JPZJ1XFPmwOp/f+TVe+Q1+ASjsbGpDU/ZOi9o7d+DOo6OmDUgNnthfn8n3Zg0/SbTuQjiCbW9Y6kZeP60NaQXoON84aEyx6SsjZ4d5M6u+PLkIXSUDvhFw4+g4+dPIekM5NbJFwxqw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(316002)(71200400001)(8936002)(8676002)(66476007)(4326008)(33656002)(54906003)(66946007)(186003)(478600001)(83380400001)(7696005)(5660300002)(64756008)(55016002)(110136005)(76116006)(9686003)(26005)(53546011)(86362001)(66556008)(66446008)(52536014)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: WNY2fi0r7FxpXtTP4xK9d1MP5flhJTWsI80OXA/rMOu4TZq8v7Tr8rM13BbJ18yXebWxK81rstLnwylwyDi+0OPuiMtABqQzVtQwcwioQ+Jvuykgwj59iNMRvOvs+sokVUdbmOnmUzLsL3zjoY+FswtvtL9vPW9FSKrakg8a7WVAqXdn+oEgjKaoMhkVRtHQZy0qrYD4NTNH32Ak8g/AYgZcJHqBPk/0f8IfeKtfdlQuAw1U8W5qmMutwtsR92L19vjrBexaR/0npggyaOOxgoidOqrC7YlakxsXbQklEMN7Q5ZYUT5JjbiRR5vTDKEwe5v1OC2zY2OVtOcXxsLYFPwfEc/n/TEqn3vawMsObqOqy6+BguH+hIrIM4kW4vdGdEsTidQYybq12ECSpi0zV/k9AO3a4yOgm7pomkXqL/qY35rF8u86gduEXdK8IvabHhsiHIELquaEyO4ybb3RMPzku/x62+eY78LEyD87fzHgU2dmoiTuiU0ZU1OWHLnfyBmIChfbMvelUUsIfRgy9vdrlpFc+wA5xSpGI4hWd6pwJ6aZaM2lOarLuw4eA0kK2fRXHBO2Ie2vfq5NtUeiHLDakCkP0iGZ/Puu9DZdeVSu7fhYnncqY81oPE/KyRz1stD0shKr8J+u/4i7uTSn1w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7fc6a2-12ff-4f11-ded5-08d87cd3cbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 13:00:37.0019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8S2+6o3165fj4psD3lC/NLrkW55Oto8ViKyja1a6SMjDlJT1LB3CcnMGhmymtkGSCIlMEVQDBo8hOc0WDssq2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: multipart/mixed; boundary="===============0749233149=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0749233149==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB40759475D8727038A78C1985FC150DM6PR12MB4075namp_"

--_000_DM6PR12MB40759475D8727038A78C1985FC150DM6PR12MB4075namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]


[AMD Public Use]

I see, thanks for the clarifying. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

I was thinking to have a new flag like AMD_IS_HEADLESS in amd_chip_flag, bu=
t after think it a bit more, that's just complicated the case, I agree with=
 your current approach.

Regards,
Hawking
From: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Sent: Friday, October 30, 2020 20:05
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@am=
d.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU


[AMD Public Use]

Hi Hawking,

amdgpu_device_asic_has_dc_support() is referrenced by amdgpu_pci_probe(),
at that point, adev has not been allocated yet.

My change can make it to right code path.
int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
{
...
if (!amdgpu_device_has_dc_support(adev))
drm_helper_hpd_irq_event(dev);               //right path for headless SKU
else
drm_kms_helper_hotplug_event(dev);      //wrong path for headless SKU
...
}

Thanks!
Rico

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Friday, October 30, 2020 19:48
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com<mailto:Tianci.Yin@amd.com>>; amd=
-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@l=
ists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>; Deuc=
her, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>=
>; Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Cui, Flo=
ra <Flora.Cui@amd.com<mailto:Flora.Cui@amd.com>>; Xu, Feifei <Feifei.Xu@amd=
.com<mailto:Feifei.Xu@amd.com>>; Long, Gang <Gang.Long@amd.com<mailto:Gang.=
Long@amd.com>>; Yin, Tianci (Rico) <Tianci.Yin@amd.com<mailto:Tianci.Yin@am=
d.com>>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU

[AMD Public Use]

I'm not sure I get your point on changing amdgpu_device_has_dc_support() in=
terface by adding new parameter. but it seems to me change input parameter =
from pdev to adev for nv_is_headless_sku is more straightforward.

Regards,
Hawking
-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com<mailto:tianci.yin@amd.com>>
Sent: Friday, October 30, 2020 19:32
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>; Deuc=
her, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>=
>; Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Ch=
en, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Cui, Flora <F=
lora.Cui@amd.com<mailto:Flora.Cui@amd.com>>; Xu, Feifei <Feifei.Xu@amd.com<=
mailto:Feifei.Xu@amd.com>>; Long, Gang <Gang.Long@amd.com<mailto:Gang.Long@=
amd.com>>; Yin, Tianci (Rico) <Tianci.Yin@amd.com<mailto:Tianci.Yin@amd.com=
>>
Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU

From: "Tianci.Yin" <tianci.yin@amd.com<mailto:tianci.yin@amd.com>>

The crash caused by the NULL pointer of
adev->ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),
but this function should not be called on headless SKU.

Fix the mismatch between the return value of
amdgpu_device_has_dc_support() and the real DCN supporting state to avoid c=
alling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().

Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d
Signed-off-by: Tianci.Yin <tianci.yin@amd.com<mailto:tianci.yin@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 10 ++++++++--  drivers/gpu/d=
rm/amd/amdgpu/amdgpu_display.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/nv.h             |  1 +
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index ba65d4f2ab67..f0183271456f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev,
                                    u32 pcie_index, u32 pcie_data,
                                    u32 reg_addr, u64 reg_data);

-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,
+struct pci_dev *pdev);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);

 int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device=
.c
index 1fe850e0a94d..323ed69032a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(struct =
amdgpu_device *adev)
  * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
  *
  * @asic_type: AMD asic type
+ * @pdev: pointer to pci_dev instance
  *
  * Check if there is DC (new modesetting infrastructre) support for an asi=
c.
  * returns true if DC has support, false if not.
  */
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,
+struct pci_dev *pdev)
 {
         switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
@@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic=
_type asic_type)
         case CHIP_VEGA20:
 #if defined(CONFIG_DRM_AMD_DC_DCN)
         case CHIP_RAVEN:
+               return amdgpu_dc !=3D 0;
         case CHIP_NAVI10:
         case CHIP_NAVI14:
         case CHIP_NAVI12:
+               if (nv_is_headless_sku(pdev))
+                       return false;
+               else
+                       return amdgpu_dc !=3D 0;
         case CHIP_RENOIR:
 #endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
@@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)
         if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
                 return false;

-       return amdgpu_device_asic_has_dc_support(adev->asic_type);
+       return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pde=
v);
 }


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 9e92d2a070ac..97014458d7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu=
_device *adev,
          */
         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
             amdgpu_bo_support_uswc(bo_flags) &&
-           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+           amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev))=
 {
                 switch (adev->asic_type) {
                 case CHIP_CARRIZO:
                 case CHIP_STONEY:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 4b78ecfd35f7..b23110241267 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
         bool supports_atomic =3D false;

         if (!amdgpu_virtual_display &&
-           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
+           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev))
                 supports_atomic =3D true;

         if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) { diff=
 --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c =
index 026e0a8fd526..97446ae75b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
         adev->virt.ops =3D &xgpu_nv_virt_ops;
 }

-static bool nv_is_headless_sku(struct pci_dev *pdev)
+bool nv_is_headless_sku(struct pci_dev *pdev)
 {
         if ((pdev->device =3D=3D 0x731E &&
             (pdev->revision =3D=3D 0xC6 || pdev->revision =3D=3D 0xC7)) ||=
 diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/=
nv.h index 515d67bf249f..7880ad0073c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -29,6 +29,7 @@
 void nv_grbm_select(struct amdgpu_device *adev,
                     u32 me, u32 pipe, u32 queue, u32 vmid);  void nv_set_v=
irt_ops(struct amdgpu_device *adev);
+bool nv_is_headless_sku(struct pci_dev *pdev);
 int nv_set_ip_blocks(struct amdgpu_device *adev);  int navi10_reg_base_ini=
t(struct amdgpu_device *adev);  int navi14_reg_base_init(struct amdgpu_devi=
ce *adev);
--
2.17.1

--_000_DM6PR12MB40759475D8727038A78C1985FC150DM6PR12MB4075namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I see, thanks for the clarifying. The patch is<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com=
&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I was thinking to have a new flag like AMD_IS_HEADLE=
SS in amd_chip_flag, but after think it a bit more, that&#8217;s just compl=
icated the case, I agree with your current approach.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.c=
om&gt; <br>
<b>Sent:</b> Friday, October 30, 2020 20:05<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;;=
 Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;=
; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Hawk=
ing,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">amdgpu_=
device_asic_has_dc_support() is referrenced by amdgpu_pci_probe(),<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">at that=
 point, adev has not been allocated yet.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">My chan=
ge can make it to right code path.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">int amd=
gpu_device_resume(struct drm_device *dev, bool fbcon)<br>
{<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">...<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">if (!am=
dgpu_device_has_dc_support(adev))
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">drm_hel=
per_hpd_irq_event(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //right path for headless SKU<o:p></o:p></=
span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">else<o:=
p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">drm_kms=
_helper_hotplug_event(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //wrong path for =
headless SKU<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">...<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">}<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks!=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Rico<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@=
amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
<b>Sent:</b> Friday, October 30, 2020 19:48<br>
<b>To:</b> Yin, Tianci (Rico) &lt;<a href=3D"mailto:Tianci.Yin@amd.com">Tia=
nci.Yin@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@amd.com">Luben.=
Tuikov@amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.=
Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;; Chen, Guchun &lt;<a hre=
f=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a>&gt;;
 Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@amd.com</a>&=
gt;; Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@amd.com<=
/a>&gt;; Long, Gang &lt;<a href=3D"mailto:Gang.Long@amd.com">Gang.Long@amd.=
com</a>&gt;; Yin, Tianci (Rico) &lt;<a href=3D"mailto:Tianci.Yin@amd.com">T=
ianci.Yin@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
I'm not sure I get your point on changing amdgpu_device_has_dc_support() in=
terface by adding new parameter. but it seems to me change input parameter =
from pdev to adev for nv_is_headless_sku is more straightforward.
<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: Tianci Yin &lt;<a href=3D"mailto:tianci.yin@amd.com">tianci.yin@amd.c=
om</a>&gt; <br>
Sent: Friday, October 30, 2020 19:32<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@amd.com">Luben.Tuikov@=
amd.com</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher=
@amd.com">Alexander.Deucher@amd.com</a>&gt;; Zhang, Hawking &lt;<a href=3D"=
mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;;
 Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.co=
m</a>&gt;; Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@am=
d.com</a>&gt;; Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.X=
u@amd.com</a>&gt;; Long, Gang &lt;<a href=3D"mailto:Gang.Long@amd.com">Gang=
.Long@amd.com</a>&gt;;
 Yin, Tianci (Rico) &lt;<a href=3D"mailto:Tianci.Yin@amd.com">Tianci.Yin@am=
d.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU<=
br>
<br>
From: &quot;Tianci.Yin&quot; &lt;<a href=3D"mailto:tianci.yin@amd.com">tian=
ci.yin@amd.com</a>&gt;<br>
<br>
The crash caused by the NULL pointer of<br>
adev-&gt;ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),<br>
but this function should not be called on headless SKU.<br>
<br>
Fix the mismatch between the return value of<br>
amdgpu_device_has_dc_support() and the real DCN supporting state to avoid c=
alling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().<br>
<br>
Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d<br>
Signed-off-by: Tianci.Yin &lt;<a href=3D"mailto:tianci.yin@amd.com">tianci.=
yin@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 10 ++++++++--&nbsp=
; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&nbsp;6 files changed, 13 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index ba65d4f2ab67..f0183271456f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_devi=
ce *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 pcie_index=
, u32 pcie_data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_addr, =
u64 reg_data);<br>
&nbsp;<br>
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);<br>
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, <br>
+struct pci_dev *pdev);<br>
&nbsp;bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_d=
evice.c<br>
index 1fe850e0a94d..323ed69032a7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(struct =
amdgpu_device *adev)<br>
&nbsp; * amdgpu_device_asic_has_dc_support - determine if DC supports the a=
sic<br>
&nbsp; *<br>
&nbsp; * @asic_type: AMD asic type<br>
+ * @pdev: pointer to pci_dev instance<br>
&nbsp; *<br>
&nbsp; * Check if there is DC (new modesetting infrastructre) support for a=
n asic.<br>
&nbsp; * returns true if DC has support, false if not.<br>
&nbsp; */<br>
-bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)<br>
+bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type, <br>
+struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_type) {<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC)<br>
@@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic=
_type asic_type)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return amdgpu_dc !=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (nv_is_headless_sku(pdev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_dc=
 !=3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR:<br>
&nbsp;#endif<br>
&nbsp;#if defined(CONFIG_DRM_AMD_DC_DCN3_0)<br>
@@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_devic=
e *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) =
|| adev-&gt;enable_virtual_display)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc_supp=
ort(adev-&gt;asic_type);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc_supp=
ort(adev-&gt;asic_type, adev-&gt;pdev);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 9e92d2a070ac..97014458d7de 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu=
_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((bo_flags &amp; AMDGPU=
_GEM_CREATE_CPU_GTT_USWC) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_bo_support_uswc(bo_flags) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(adev-&gt;asic_type)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(adev-&gt;asic_type, adev-&gt;pdev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 4b78ecfd35f7..b23110241267 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_atomic =3D f=
alse;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_virtual_displa=
y &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(flags &amp; AMD_ASIC_MASK))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device=
_asic_has_dc_support(flags &amp; AMD_ASIC_MASK, pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; supports_atomic =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((flags &amp; AMD_EXP_H=
W_SUPPORT) &amp;&amp; !amdgpu_exp_hw_support) { diff --git a/drivers/gpu/dr=
m/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 026e0a8fd526..974=
46ae75b0b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops =3D &amp=
;xgpu_nv_virt_ops;<br>
&nbsp;}<br>
&nbsp;<br>
-static bool nv_is_headless_sku(struct pci_dev *pdev)<br>
+bool nv_is_headless_sku(struct pci_dev *pdev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((pdev-&gt;device =3D=
=3D 0x731E &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (p=
dev-&gt;revision =3D=3D 0xC6 || pdev-&gt;revision =3D=3D 0xC7)) || diff --g=
it a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h inde=
x 515d67bf249f..7880ad0073c9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
@@ -29,6 +29,7 @@<br>
&nbsp;void nv_grbm_select(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u32 queue, =
u32 vmid);&nbsp; void nv_set_virt_ops(struct amdgpu_device *adev);<br>
+bool nv_is_headless_sku(struct pci_dev *pdev);<br>
&nbsp;int nv_set_ip_blocks(struct amdgpu_device *adev);&nbsp; int navi10_re=
g_base_init(struct amdgpu_device *adev);&nbsp; int navi14_reg_base_init(str=
uct amdgpu_device *adev);<br>
--<br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB40759475D8727038A78C1985FC150DM6PR12MB4075namp_--

--===============0749233149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0749233149==--
