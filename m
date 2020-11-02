Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370EFC388F2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 15:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35142222B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mF4oZurb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35142222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121EA6E0F5;
	Mon,  2 Nov 2020 15:38:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C7C6E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 15:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGQRcFcflw1qU02ghPZjj5IE8OP0nVUW6krMmtvFx0XOdNl5pNZmBZJkk/bpW7pkcFsaKUe7wKfY8n/5Ak3H02IYq6lJE/stp7grXsxN1CyJQW2mzV0uJeiQ+UISMJbRfRqdEKSg1a34TlTW7PTkTl2qh39KuOH3e2bkeZnN1IHqTW2EcOXW4Nu2EOYN+6aHLX1vcsPkawA9AyFAZpJIUm/1WrXYZNFgdICCTss9CJ1IQVuf+i2WD3FI73KBB3OxxGdeDvPxoR8OD8t7w8Yx2AS/EVO/U28KkVb9QwgKBXti17yL/M+T216qi0Bv/bYarKDM7T6Ro3M7CfknDqYwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly3edimIMr80srIrDHo6FVsQ2OJ2McniCs4Lf+h7gz0=;
 b=BckcBYoFVCVGo172ME3iyq+udFDIIwzeho/+PIYK7DayTa+e2K0HDBBZOlxf119PNemxRhl2Dnvk1IT0l4qWzv6EfZfLOgSVYeq9Xvwrq5d64mcV478cPqXE7QheXTeyuz62TPSA8RszAl8j0n+DaA+ZAslL2ceI2H54ZvwM96tALoyFOhdug680GcD/u/25oYDaqU4lLGQoe20jnZzldXaMlEf164I5PndLGYPE8UWgkg475KYH8D3UV4EmKIMlLhqSczOf8pgIyELq8w1h630fzpLUwqfCF4AAnN6dQkeQrW1NeNNUJ1Y47TR1bd7iygUngYEc21OX4Isj3/Mi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly3edimIMr80srIrDHo6FVsQ2OJ2McniCs4Lf+h7gz0=;
 b=mF4oZurbiLvvJxlG/bhs0B0Z/Vrl9RTvamW01kL33krWCGYt3SHInnLERZKvJ99oqKzHsImk0gfCt98wrj45xujk7r5Oi6cpxFYU1+HJDuzjew9SfxRd8s1+tX6LfkihOW8wgDAeG1BZ6o+vBEWQquMxs1GPlzLLuk5sVDIwLA8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4831.namprd12.prod.outlook.com (2603:10b6:208:1b9::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 15:38:52 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 15:38:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Index: AQHWrrBdLeu1oLRL/kqKJLzLOcksyKmwB8WAgAAErACAAA9/AIAAFBWmgAQIEgCAAMbc3Q==
Date: Mon, 2 Nov 2020 15:38:51 +0000
Message-ID: <MN2PR12MB4488796C43D6541EF6A7F1D8F7100@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201030113225.12675-1-tianci.yin@amd.com>,
 <DM6PR12MB407500CE6EB454B4DA0AE713FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB15464C58F1DEBA74E9F8BF2895150@DM5PR12MB1546.namprd12.prod.outlook.com>,
 <DM6PR12MB40759475D8727038A78C1985FC150@DM6PR12MB4075.namprd12.prod.outlook.com>,
 <MN2PR12MB448841C6B21000FE037FE975F7150@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <DM5PR12MB154644AD58D5A53211637E2695100@DM5PR12MB1546.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB154644AD58D5A53211637E2695100@DM5PR12MB1546.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-02T15:38:50.538Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4087b38-500f-4528-1563-08d87f456662
x-ms-traffictypediagnostic: MN2PR12MB4831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4831BE28A2BFF08DBFF89F08F7100@MN2PR12MB4831.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5dyT96zINHn64zQz3gtOk+3zGOlNaMMJ5W2mk6Uk0u3iDbLSQE0n19qz3tW8qJqpB0qFZw/YHAGaJWa8X+sMjJGVLeTEf9VwJkpAybrayBSUIBVxacIe0rn/SyCGaW3Xfrt1fCFGrLcK3ZvsG4bPc8OUg28AWYdIECCuiCe4AK0/K+KX2uyU6BX2qZXwEw9NmB3UJKQ8RZI2JiVAzMPEGZ9oE+l/zmuwcEQoe/sSthNAny/zR3ZAnMGZi4Va684RfxlC1aPe7KRPAieKc4HGfnn0EyvC7ivaWiGWoVoTp6byzliamyfzGqUNYbwmOO+AkbAFwIIC1j97uuNTHrYAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(86362001)(8936002)(8676002)(83380400001)(2906002)(26005)(33656002)(71200400001)(186003)(4326008)(478600001)(64756008)(76116006)(110136005)(55016002)(54906003)(9686003)(30864003)(6506007)(53546011)(66476007)(66446008)(66556008)(52536014)(316002)(66946007)(7696005)(19627405001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9X9NWnP2T5nmQzVoKHAbUA32ROVFdv9rU7owh7puQ2R96GLJwtHBk+PcFKD+Oz0yFmj8zsg/WwT/puWGELI84R8JiyJq1DfToKB7ELnuacRS0mBLg7GcpJFvTC4WB3LEdVBx9m0J9w/BXNWF2qdTbN1+TDTFB+K14O+WGkLveMhvcEwuiJ3IHJFTaOBWOxaTBedPcwr0mbS18wt2gLDbq0Mpq1XUWvXiFQl5y2a9FWZMujFlLMvVfuwnhO4Fdb0m8DFPMNiiKut94odDZHJh5tHqPVQbnnyh2jW1b9C5Nn1e/bC7Q9ZNAzDlRqAC0mlCcFql+MOBW88Fm1sBq9d04zxgftv3R34QBOc2RWfCcxQvj62bG2hiwfVSLywsmrt9sj7KDO9odgjtzB8kE//prS5Mesfl/mlcoU7ZAe05qzGtn1kttuQv/xyhlHUr0VxdidwK1dntucU9WtBQzCAMwTAklvXkY83vafjDq26+zyOmHeLxInse1mRhC1G0NYqWW68xIf4jeX/b4c+PWZdFcAaLTsF2HemLZ6dehHilpIV0VcDhN+LCEynVp4R6lZbmpTMCXOtVBK9niDxEETUiTIusKPkQUVVgrNagLh30B5op8KFd5UvdFYy7A/qBVZDPEBwlmCYMhonD5FIjgNPnWg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4087b38-500f-4528-1563-08d87f456662
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 15:38:51.8327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxsnyyA0fLp3GhOppkzvfFna0LySqGlO1SiFIAVYKQIyhRJ3F5ga7Dv17b2JAXhCTHqJyo3eO9LqcB6m75NZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4831
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
Cc: "Cui, Flora" <Flora.Cui@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Long,
 Gang" <Gang.Long@amd.com>
Content-Type: multipart/mixed; boundary="===============1977801331=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1977801331==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488796C43D6541EF6A7F1D8F7100MN2PR12MB4488namp_"

--_000_MN2PR12MB4488796C43D6541EF6A7F1D8F7100MN2PR12MB4488namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

That's the IP discovery table.  The Object header is part of atombios.  Do =
you have an vbios image from that system?

Alex


________________________________
From: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Sent: Sunday, November 1, 2020 10:46 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.o=
rg>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.com=
>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Ga=
ng <Gang.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU


[AMD Public Use]

Thanks very much Hawking!


Hi Alex,

The amdgpu_device_ip_get_ip_block() depends on the adev->ip_blocks that ini=
tialized by nv_set_ip_blocks().
In nv_set_ip_blocks(), whether add dm_ip_block depends on amdgpu_device_has=
_dc_support().
And amdgpu_device_has_dc_support() depends on amdgpu_device_asic_has_dc_sup=
port(),
So amdgpu_device_asic_has_dc_support() can't conditional on amdgpu_device_i=
p_get_ip_block(), it makes a dependency loop.

I have just checked the atombios object table in the headless VBIOS, and fi=
nd DCN and VCN are still there.
[  174.815714] [drm:amdgpu_discovery_reg_base_init [amdgpu]] DMU(271) #0 v2=
.0.2:
[  174.815771] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00000012
[  174.815829] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x000000c0
[  174.815887] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x000034c0
[  174.815945] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00009000
[  174.816002] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x02403c00
[  174.821854] [drm:amdgpu_discovery_reg_base_init [amdgpu]] UVD(12) #0 v2.=
0.0:
[  174.821908] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00007800
[  174.821962] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00007e00
[  174.822017] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x02403000
So I think DAL driver can't tell it's a normal ASIC or headless ASIC.

Thanks!
Rico

________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Friday, October 30, 2020 22:18
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@=
amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.com=
>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Ga=
ng <Gang.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU


[AMD Public Use]

Maybe it would be easier to check if the DCE IP exists? E.g.,
if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE) ||
(!amdgpu_device_has_dc_support(adev))
...

Also do we even need to skip DCN init for these cards, or will the display =
code handle it automatically since there will be no displays in the atombio=
s object table.  We didn't do anything special for display with the polaris=
 blockchain cards.

Alex

________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, October 30, 2020 9:00 AM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@am=
d.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU


[AMD Public Use]


[AMD Public Use]



I see, thanks for the clarifying. The patch is



Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>



I was thinking to have a new flag like AMD_IS_HEADLESS in amd_chip_flag, bu=
t after think it a bit more, that=92s just complicated the case, I agree wi=
th your current approach.



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

--_000_MN2PR12MB4488796C43D6541EF6A7F1D8F7100MN2PR12MB4488namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
That's the IP discovery table.&nbsp; The Object header is part of atombios.=
&nbsp; Do you have an vbios image from that system?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Yin, Tianci (Rico) =
&lt;Tianci.Yin@amd.com&gt;<br>
<b>Sent:</b> Sunday, November 1, 2020 10:46 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Haw=
king &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-g=
fx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guc=
hun.Chen@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;=
Feifei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top: 0px; margin-bot=
tom: 0px;font-family:Arial; font-size:10pt; color:#317100; margin:15pt" ali=
gn=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thanks very much Hawking!</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi Alex,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
The amdgpu_device_ip_get_ip_block() depends on the adev-&gt;ip_blocks that =
initialized by nv_set_ip_blocks().</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
In nv_set_ip_blocks(), whether add dm_ip_block depends on amdgpu_device_has=
_dc_support().<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
And amdgpu_device_has_dc_support() depends on amdgpu_device_asic_has_dc_sup=
port(),</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
So&nbsp;amdgpu_device_asic_has_dc_support() can't conditional on amdgpu_dev=
ice_ip_get_ip_block(), it makes a dependency loop.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I have just checked the atombios object table in the headless VBIOS, and fi=
nd DCN and VCN are still there.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:8pt">[ &nbsp;174.815714] [drm:amdgpu_discovery_reg=
_base_init [amdgpu]] DMU(271)</span><span style=3D"font-size:8pt">&nbsp;#0 =
v2.0.2:</span>
<div><span style=3D"font-size:8pt">[ &nbsp;174.815771] [drm:amdgpu_discover=
y_reg_base_init [amdgpu]] 0x00000012</span></div>
<div><span style=3D"font-size:8pt">[ &nbsp;174.815829] [drm:amdgpu_discover=
y_reg_base_init [amdgpu]] 0x000000c0</span></div>
<div><span style=3D"font-size:8pt">[ &nbsp;174.815887] [drm:amdgpu_discover=
y_reg_base_init [amdgpu]] 0x000034c0</span></div>
<div><span style=3D"font-size:8pt">[ &nbsp;174.815945] [drm:amdgpu_discover=
y_reg_base_init [amdgpu]] 0x00009000</span></div>
<span style=3D"font-size:8pt">[ &nbsp;174.816002] [drm:amdgpu_discovery_reg=
_base_init [amdgpu]] 0x02403c00</span><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:8pt">[ &nbsp;174.821854] [drm:amdgpu_discovery_reg=
_base_init [amdgpu]] UVD(12) #0 v2.0.0:</span>
<div><span style=3D"font-size:8pt">[ &nbsp;174.821908] [drm:amdgpu_discover=
y_reg_base_init [amdgpu]] 0x00007800</span></div>
<div><span style=3D"font-size:8pt">[ &nbsp;174.821962] [drm:amdgpu_discover=
y_reg_base_init [amdgpu]] 0x00007e00</span></div>
<span style=3D"font-size:8pt">[ &nbsp;174.822017] [drm:amdgpu_discovery_reg=
_base_init [amdgpu]] 0x02403000</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
So I think DAL driver can't tell it's a normal ASIC or headless ASIC.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thanks!</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Rico<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Deucher, Alexander =
&lt;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, October 30, 2020 22:18<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yin, Tianci (Rico)=
 &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@list=
s.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guc=
hun.Chen@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;=
Feifei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</font>
<div>&nbsp;</div>
</div>
<div dir=3D"ltr">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top: 0px; margin-bot=
tom: 0px;font-family:Arial; font-size:10pt; color:#317100; margin:15pt" ali=
gn=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Maybe it would be easier to check if the DCE IP exists? E.g., <br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE) ||</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:black; font-size:12pt">(!amdgpu_device_has_dc_support(=
adev)</span>)</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
...</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Also do we even need to skip DCN init for these cards, or will the display =
code handle it automatically since there will be no displays in the atombio=
s object table.&nbsp; We didn't do anything special for display with the po=
laris blockchain cards.<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" fa=
ce=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Zhang, Hawking &l=
t;Hawking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Friday, October 30, 2020 9:00 AM<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;;=
 Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;=
; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</font>
<div>&nbsp;</div>
</div>
<div style=3D"word-wrap:break-word" lang=3D"EN-US">
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top: 0px; margin-bot=
tom: 0px;font-family:Arial; font-size:10pt; color:#317100; margin:15pt" ali=
gn=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div class=3D"x_x_x_WordSection1">
<p class=3D"x_x_x_msipheader251902e5" style=3D"margin-top: 0px; margin-bott=
om: 0px;margin-top: 0px; margin-bottom: 0px;margin-right: 0in; margin-left:=
 0in; font-size: 11pt; font-family: &quot;Calibri&quot;, sans-serif;margin:=
0in">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
I see, thanks for the clarifying. The patch is</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
I was thinking to have a new flag like AMD_IS_HEADLESS in amd_chip_flag, bu=
t after think it a bit more, that=92s just complicated the case, I agree wi=
th your current approach.
</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
Regards,<br>
Hawking</p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<b>From:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt; <br>
<b>Sent:</b> Friday, October 30, 2020 20:05<br>
<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;;=
 Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;=
; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</p>
</div>
</div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;margin-top: 0px; margin-bot=
tom: 0px;margin:15.0pt">
<span style=3D"font-size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; =
color:#317100">[AMD Public Use]</span></p>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
<div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Hi Hawking,</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">amdgpu_device_asic_has_dc_sup=
port() is referrenced by amdgpu_pci_probe(),</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">at that point, adev has not b=
een allocated yet.</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">My change can make it to righ=
t code path.</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">int amdgpu_device_resume(stru=
ct drm_device *dev, bool fbcon)<br>
{</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">...</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">if (!amdgpu_device_has_dc_sup=
port(adev))
</span></p>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">drm_helper_hpd_irq_event(dev)=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; //right path for headless SKU</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">else</span></p>
</div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">drm_kms_helper_hotplug_event(=
dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //wrong path for headless SKU</span></p=
>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">...</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">}</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Thanks!</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">Rico</span></p>
</div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<span style=3D"font-size:12.0pt; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_x_x_MsoNormal" style=3D"margin: 0in; font-size: 11pt; font-=
family: &quot;Calibri&quot;, sans-serif;text-align:center" align=3D"center"=
>
<hr width=3D"98%" size=3D"2" align=3D"center">
</div>
<div id=3D"x_x_x_divRplyFwdMsg">
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
<b><span style=3D"color:black">From:</span></b><span style=3D"color:black">=
 Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@=
amd.com</a>&gt;<br>
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
</p>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_x_x_MsoNormal" style=3D"margin-top: 0px; margin-bottom: 0px;m=
argin-top: 0px; margin-bottom: 0px;margin: 0in; font-size: 11pt; font-famil=
y: &quot;Calibri&quot;, sans-serif;">
[AMD Public Use]<br>
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
2.17.1</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB4488796C43D6541EF6A7F1D8F7100MN2PR12MB4488namp_--

--===============1977801331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1977801331==--
