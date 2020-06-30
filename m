Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C4CC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 03:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC04206B6
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 03:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gYBzv0Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC04206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DA589B9E;
	Tue, 30 Jun 2020 03:54:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575E589B9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 03:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGXXDP3usZZTuWWG2YqtaXAu0m/8g8rSZ9Wi2eAUVkf6S3Mmia36ANL8cqxfg0mrOqF1baZTRqgXobqIspudgDidB4i6Vnc7nIuvPpjnNPf+sihCwFImzXnc5LcvR8L9fpe+BQRofdcSm+WHO84CfnZA6yMn4yG5Dky5hy+8Knf6V4TfkhFksrqEEx2IaHH29rvZoskc2N3j2tR8jiOLx32iw+adZv0HxJ4uH38S0BHcs+1Uy8S70SKTrVeG/bJ4TblFjEdBzdsbPJEPq+WowrAS6FQcUY10HSzahs04BloOyiZafU6qg80ESqty8frEDCOY6QPMtFBcgsBfTlUe6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8REumXEoqRTTRHntYYHoXGmRI1gVRDkObI6+Fc/UTA=;
 b=RowTt61dCICbNLLduSSzzP0UVgtNtK7M/Dbav8251PkywRzhajO1+q46Iczk4++xlGuG22WGbzXa/VaFOAAkpgbg4iwPHovCq40yoh7nROk0hcfh3vl5X/5r2Q+Jmj0PdftswQTxhYdcehB9xGOs4SrIext1jnGmAofDGGBZ9BSwIwh7C9g7RG1OZL8tuJHAJ7vk+u6WqdCt91T4ayup+7fZdfjhA96hpTSWEowaU+L5odjZwlVxZDssEXMDBArBjPH+L5yCNiDppIOqzSdutoIIL791JT4uD5xJNQE6a7YBMagzS0nJI9HwZcKFMmyl2bCpDXkI6GSYdbvShEgSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8REumXEoqRTTRHntYYHoXGmRI1gVRDkObI6+Fc/UTA=;
 b=gYBzv0Lq1qxx6IKCx9SrLc4mSzeP7/RD4ZcSzIa3Wt2wHJ36wXjZq5p/06a8elLpSjb+KN9MOwcGKrK387LIzTLVXOe3dj5vALP044ZivGbj+3k8YVxYmG5Pl2HM3bGLTFYPeSehI+/GsjX0rpPiaLxcDaIJ5IV5BbD61gYaHlA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.25; Tue, 30 Jun 2020 03:54:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3131.026; Tue, 30 Jun 2020
 03:54:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc
Thread-Topic: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc
Thread-Index: AQHWTT36aBwmDwg+XU2LIgrpIp3Gl6jvyUOAgAC/6zA=
Date: Tue, 30 Jun 2020 03:54:18 +0000
Message-ID: <DM6PR12MB2619EC0C31B9741F6B67D5EDE46F0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200628111848.1234-1-evan.quan@amd.com>
 <CADnq5_NnQbOXs+oWEeb3xvgeVZEPKLCjiRWkBaS7e8zRfeNuBQ@mail.gmail.com>
In-Reply-To: <CADnq5_NnQbOXs+oWEeb3xvgeVZEPKLCjiRWkBaS7e8zRfeNuBQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0b48b288-e1e7-44b0-8f7e-0000e67e5746;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-30T03:52:11Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76c30018-fd1d-4539-06f2-08d81ca94418
x-ms-traffictypediagnostic: DM6PR12MB3868:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB386891C406CEA485B0FA50E2E46F0@DM6PR12MB3868.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:247;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lFhKxrZQR9RZtAw4alyeDtKG7NJvC1b/Und/ovKIT/b4smf2AIofmTAvB9x4B/z0B2G6XbwVLXEL3RIxCoWtK74/BY3cGMUlQ6uiKetdjhruIgGWxf0m+G8mEwDXMh1yTxB9jthaLcs+YxOZPe+xJ8Ri7M8VP4bZulBZTtMjF2ZYUXsIC5f+4KMzLmEg28TQZDaSQAkX9VKlo/yPD56YV925gtGxp4jLwSgSfdwHuT8P3P6mr2Og05EOn78eUWhKFYgemAbaHm6Aw1Yf8myiytmth0Z+yxUu9RQHFmqs/LGCxRCBOqNOv0xZHT2e7KrygQNT3M5b+6914iE8cUQZbZpK8YpxWKt1J6yqFkYzK440asdWjpfran/v+ZEowqXCrzcd/NIYtsGcCQ+nIRF2Mg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(7696005)(26005)(2906002)(83080400001)(76116006)(66946007)(66446008)(71200400001)(5660300002)(6916009)(66476007)(66556008)(64756008)(52536014)(53546011)(33656002)(6506007)(186003)(8676002)(9686003)(86362001)(4326008)(55016002)(83380400001)(8936002)(54906003)(478600001)(316002)(966005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DQhf5yZ0TTqxMpA0zkgCKkI739ImW5y7VZKWi18zAOXNABYiSAFH83JCLYLT1p3AiotgwSegCj7FJJlpdxR+e42xQ0gorXo7CMEIbjTjfVa9OJ2x6H1bW1Abia/V3H7ljwF+jR/GgkY9GD7x/7GPLCMSb3JmyShhAgDCfv3JdNgaoaBirvnckZNkEvrvEqA9+2+E1m8XzftcRgbVN7L1BHv2hpBpxCexnUNDCa6EP4/aIsefJ2u8UI6ZxM2I+qnY2ceLJcA7ENY2EvhVjki0QAZVhOAary9FH62a0OeOYKNsVYsppvH/SoqF7OoNLKlfHRj+GRThDKgOYNxJKXIvNc+gku9+jYzJVdT+nDykQG4mlnJcf/t36wlaqtJ2uVjXzzjx2roiIs2+DZJ3eaKW9bIQem7ZmMihnRW6TSXEYHTsWTdjTX/XMaRWgpNYIIxO3qEepW3ATV5LLOVZi7vNfu+I8Eqf31ZDh4CXiRL4udIZe/WrtXpR2V2I+i6rDDF4
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c30018-fd1d-4539-06f2-08d81ca94418
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 03:54:18.9072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqOK9oKrJxR6U8dNLfXI5rWfGC3vQM626eeiHemLfinaq+LZ+Q0CEAtvpxDgGyVQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

That's because pr_warn/err/info are forbidden to use in power routines.

/*
 * DO NOT use these for err/warn/info/debug messages.
 * Use dev_err, dev_warn, dev_info and dev_dbg instead.
 * They are more MGPU friendly.
 */
#undef pr_err
#undef pr_warn
#undef pr_info
#undef pr_debug

BR
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, June 30, 2020 12:25 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc

On Sun, Jun 28, 2020 at 7:19 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Fix the compile error below:
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0_init_microcode':
> >> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of
> >> function 'pr_warn'; did you mean 'pci_warn'?
> >> [-Werror=implicit-function-declaration]
>       22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
>          |  ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:176:3: note: in expansion of macro 'BUG'
>      176 |   BUG();
>
> Change-Id: I4e969082c41f8a8c91f1b0d19eb853eb0a2e0c0d
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

I think this is probably a missing include.  We use BUG() elsewhere in the driver with no problems.

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 677f8adb920c..48e15885e9c3 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -173,7 +173,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
>                 chip_name = "sienna_cichlid";
>                 break;
>         default:
> -               BUG();
> +               dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
> +               return -EINVAL;
>         }
>
>         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin",
> chip_name);
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C2962b4be8d5e4e72009308d81c49098d%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637290447307762780&amp;sdata=v5oJldXwh7UQN
> e0ETjZ048xkqODiPe6LiwmMIHu0Ur8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
