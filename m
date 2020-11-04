Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB3DC388F7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 09:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB8620781
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 09:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sI8gJ3NU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB8620781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D97E6E980;
	Wed,  4 Nov 2020 09:54:11 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722BB6E980
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 09:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPSdbaiRtMCg3ROkirhHBnR2cWqizUwXWuKYjtb5vEF44z0UmbZEQNBiGsaOp6TkfQqyFDt1RqyBAZhe0mVRcDWxgbUNZjyXB3exZ69ENL979rIuO3gtNI/5UfdHZbq/zN8EaNbxc6v6CI9gywubFGfvXOeKJ9yQx0jVDT/xcu5ZxKc5n0BLnVHWHcB8K1bBkZBfXiAwoujzE4kX9bFtuM9blZlM7fPMUxhvi/IuuRHuFhqQ/aRJBBQ40kb/kN0ON9ZA14BcxgayL/EwoNhLRzE84pIRu/UM0bcNL7BNYYbmcL6IYnQGKy1IsPtY5j4KW6c5ibLbRefJQ4KRg4M1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsBFt4sPibQzqCWULPOYLjRRoqnIPfA89fkHvZbf+dI=;
 b=D82nEeOIxw6DO/RRuE67ZvBcBi9a/owattvCAvMEMibI657/7DtvAigEeM34PnABAlkVjgM1saARUK5sD2dK45cOQD0/zxXd+TT+UCa16Mbf6LNn3EVqIeXi/vCSybIcTlcit6fGXiWE+DBVmKGg49XKPoW/HrObkEmUr4KjxCIwyoX2cbDgsN5kjjFIPqdvvjYAbwqn39bvahBi0vVMcThiq0LKwBEwU4FY6JOQVWKnsoyC2finPEqSQdod/UQkn9wG0n090GHXeSU5x4Bl1q8pZo8bZBhJEDbQZyHAQKbMkuD6uC/bPb84D0DqWszsKhdWtLsPtmV8VO6a8WuoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsBFt4sPibQzqCWULPOYLjRRoqnIPfA89fkHvZbf+dI=;
 b=sI8gJ3NUP6dHBRbOxijKbrSW5rTdB12M4H8h6cjm4351isQJiohhNbEEoqjaF3s17sv6JlRUJ+0hFpzDSrDgRZK4obkG/mLzyrsX4JWx52D2LGeLiE6jHrurwRVUmNvTKmbQUTNP9dPrdAdinMRZmnPDbx9siHWLWUg8mr4P2FU=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) by
 DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27; Wed, 4 Nov 2020 09:54:06 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::9413:d975:ac8e:39d%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 09:54:06 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Topic: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SKU
Thread-Index: AQHWrrBd/UrirzIdt0W5QD6bCrOAaqmwB8WAgAAAVFSAABPXAIAAFc+AgAP91AiAAM+SgIAAJHSAgACXMJSAAMCJgIABQ5WB
Date: Wed, 4 Nov 2020 09:54:06 +0000
Message-ID: <DM5PR12MB15463E9C2FA5E873E53A1B9295EF0@DM5PR12MB1546.namprd12.prod.outlook.com>
References: <20201030113225.12675-1-tianci.yin@amd.com>
 <DM6PR12MB407500CE6EB454B4DA0AE713FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
 <DM5PR12MB15464C58F1DEBA74E9F8BF2895150@DM5PR12MB1546.namprd12.prod.outlook.com>
 <DM6PR12MB40759475D8727038A78C1985FC150@DM6PR12MB4075.namprd12.prod.outlook.com>
 <MN2PR12MB448841C6B21000FE037FE975F7150@MN2PR12MB4488.namprd12.prod.outlook.com>
 <DM5PR12MB154644AD58D5A53211637E2695100@DM5PR12MB1546.namprd12.prod.outlook.com>
 <MN2PR12MB4488796C43D6541EF6A7F1D8F7100@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <CADnq5_O4q6jYeKQj8rFqNFpkEWRAjpq2CKmZG3AujPvM9xFa=g@mail.gmail.com>,
 <DM5PR12MB15460FCC1250718DD5E5F44795110@DM5PR12MB1546.namprd12.prod.outlook.com>,
 <MN2PR12MB44888DB7D47E1B92DC8003E3F7110@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44888DB7D47E1B92DC8003E3F7110@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Gang.Long@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-04T09:54:05.551Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d74f7f28-27b4-4ba2-aee7-08d880a791d1
x-ms-traffictypediagnostic: DM6PR12MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4483A0539E6D00BFD144029895EF0@DM6PR12MB4483.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88nBris0V2kv0kV0ffPSpwTElgpccii53wPJrsLu0IdatQHeIUHui198n4kfnBhqzHKjihBhPEv3/CwZ3tIBUiCPvOBl717C4z5kjEvr2XT1y6dhYfdQEQHvYsdz76oquACekFqJmWuFMu7QRw8kpjGJw9Z8HbVKt0IIUWAvbxzgn46Jg+byZdmVEi+XxZQPmAWZ+tCDiyvOojClvAEH27PWXJEM8HQAwLFs8ZOhqFOAgzUOdc0hS7apXHpU/z6hqTQhJjMMVPehbzms3svLa5heJNyhy2q9ubAdJ2XBpH+szKDJZCNgXkpvQGjLtn8Vjl+Q/9wse6DDU+ZMwkxC7lZ6jo/XbetERqzWVwbDBS4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1546.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(478600001)(7696005)(30864003)(54906003)(2906002)(8936002)(71200400001)(8676002)(66446008)(66476007)(33656002)(64756008)(316002)(26005)(966005)(4326008)(19627235002)(110136005)(66556008)(66946007)(166002)(9686003)(55016002)(45080400002)(5660300002)(83380400001)(186003)(19627405001)(53546011)(76116006)(91956017)(52536014)(6506007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: frT9c0xKwFtSy+3EwesAEoEmJK4KbOIfpVryJoSB3600VVQ168BFm4bUwHeKGe2SjiIUcJaYq/m1tSAsKBqaMbx21LzW8ej9WNN0yzilFDyj9pdceWWaImNu3VYWtbpvZQrkGlo9MFn2EfTgYfoAFsAR4gnv7PdfoodPEsSDOqBUOJF4hBt1btzOw1ma6M3lXTJ7vDxF7DqiO5AbAXK9xjDRO2qzuXzoAFaGOXqzLH0eON/gXkYf07wsgaKziD4CEjDSizaM6W78O6QvaoMD+tf+5zmx78I5NxcNHuqh1ZcW7Yd3/g4Luir7rhYYUmrFfTeycsgUj7jq8SkJFVtyUhHRX3rYjKFoqBwqD5AU9wld743G/qOXhuV6qVpF07rq0tD5gH7GQcGisNb7rGTeeLCr05j6Bcg4aBWThNNCUGQumsEqslGsjxxNGf6I+7EDdHrDy18F2l4kFSlnPfsbQHyX0KIXxKYU+R5GvqA6a55nZEr+bLyXtpSUB7Uv8PFL3k7oKVthS/56XjJ8xr5U3d5LdgJ9ZyXKXt6HjdUG/VBfUB8o2HpBCE9UK1cSvXcGGF9/kmdI1Glhz4josJF4BFp0/52pvgMLoc4TJQNdxGHWdtHlzbxbv0yK4PXgLjlzv0HdRcYX8m6TSxL332M3Ew==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1546.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74f7f28-27b4-4ba2-aee7-08d880a791d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 09:54:06.4138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsVBjXGI6+rpC0BGEEAQ9Q9PR12shh1VnLrQhAZjFTsuiGskUyJY0BeFPF0IHtyDqXkKJorXU7ietcVfNRhNcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Cui, Flora" <Flora.Cui@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0608562222=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0608562222==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB15463E9C2FA5E873E53A1B9295EF0DM5PR12MB1546namp_"

--_000_DM5PR12MB15463E9C2FA5E873E53A1B9295EF0DM5PR12MB1546namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

With DCN enabled,  I take amdgpu_test/kfdtest/PhinoexMiner/S3 tests, they a=
re all PASS.
I ask @Long, Gang<mailto:Gang.Long@amd.com> to take a large coverage test, =
 if it's ok, I will enable DCN block.

Thanks!
Rico
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, November 3, 2020 22:19
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Alex Deucher <alexdeucher@gmai=
l.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei =
<Feifei.Xu@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Gu=
chun.Chen@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU

That should be harmless and we can fix that up.  Does everything work as ex=
pected other than the error message?

Alex

________________________________
From: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Sent: Monday, November 2, 2020 9:51 PM
To: Alex Deucher <alexdeucher@gmail.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei =
<Feifei.Xu@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Gu=
chun.Chen@amd.com>; Long, Gang <Gang.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU


[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

If we don't skip DCN in nv_set_ip_blocks, I find below error,
[  103.949926] [drm:amdgpu_dm_init.cold [amdgpu]] *ERROR* amdgpu: failed to=
 initialize hdcp_workqueue.

Thanks!
Rico
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Tuesday, November 3, 2020 1:49
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Zhang, Hawking <Hawking.Zhang@=
amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Cu=
i, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Tuikov, Luben=
 <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Long, Gang <Ga=
ng.Long@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless =
SKU

Does everything work as expected if we don't skip DCN in nv_set_ip_blocks?

Alex

On Mon, Nov 2, 2020 at 10:38 AM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Public Use]
>
>
> That's the IP discovery table.  The Object header is part of atombios.  D=
o you have an vbios image from that system?
>
> Alex
>
>
> ________________________________
> From: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
> Sent: Sunday, November 1, 2020 10:46 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop=
.org>
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, =
Gang <Gang.Long@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headles=
s SKU
>
>
> [AMD Public Use]
>
>
> Thanks very much Hawking!
>
>
> Hi Alex,
>
> The amdgpu_device_ip_get_ip_block() depends on the adev->ip_blocks that i=
nitialized by nv_set_ip_blocks().
> In nv_set_ip_blocks(), whether add dm_ip_block depends on amdgpu_device_h=
as_dc_support().
> And amdgpu_device_has_dc_support() depends on amdgpu_device_asic_has_dc_s=
upport(),
> So amdgpu_device_asic_has_dc_support() can't conditional on amdgpu_device=
_ip_get_ip_block(), it makes a dependency loop.
>
> I have just checked the atombios object table in the headless VBIOS, and =
find DCN and VCN are still there.
> [  174.815714] [drm:amdgpu_discovery_reg_base_init [amdgpu]] DMU(271) #0 =
v2.0.2:
> [  174.815771] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00000012
> [  174.815829] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x000000c0
> [  174.815887] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x000034c0
> [  174.815945] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00009000
> [  174.816002] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x02403c00
> [  174.821854] [drm:amdgpu_discovery_reg_base_init [amdgpu]] UVD(12) #0 v=
2.0.0:
> [  174.821908] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00007800
> [  174.821962] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00007e00
> [  174.822017] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x02403000
> So I think DAL driver can't tell it's a normal ASIC or headless ASIC.
>
> Thanks!
> Rico
>
> ________________________________
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Friday, October 30, 2020 22:18
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Yin, Tianci (Rico) <Tianci.Yi=
n@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Chen, Guchun <Guchun.Chen@amd.c=
om>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, =
Gang <Gang.Long@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headles=
s SKU
>
>
> [AMD Public Use]
>
>
> Maybe it would be easier to check if the DCE IP exists? E.g.,
> if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE) ||
> (!amdgpu_device_has_dc_support(adev))
> ...
>
> Also do we even need to skip DCN init for these cards, or will the displa=
y code handle it automatically since there will be no displays in the atomb=
ios object table.  We didn't do anything special for display with the polar=
is blockchain cards.
>
> Alex
>
> ________________________________
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, October 30, 2020 9:00 AM
> To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@=
amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headles=
s SKU
>
>
> [AMD Public Use]
>
>
> [AMD Public Use]
>
>
>
> I see, thanks for the clarifying. The patch is
>
>
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
>
>
> I was thinking to have a new flag like AMD_IS_HEADLESS in amd_chip_flag, =
but after think it a bit more, that=92s just complicated the case, I agree =
with your current approach.
>
>
>
> Regards,
> Hawking
>
> From: Yin, Tianci (Rico) <Tianci.Yin@amd.com>
> Sent: Friday, October 30, 2020 20:05
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@=
amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headles=
s SKU
>
>
>
> [AMD Public Use]
>
>
>
> Hi Hawking,
>
>
>
> amdgpu_device_asic_has_dc_support() is referrenced by amdgpu_pci_probe(),
>
> at that point, adev has not been allocated yet.
>
>
>
> My change can make it to right code path.
>
> int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
> {
>
> ...
>
> if (!amdgpu_device_has_dc_support(adev))
>
> drm_helper_hpd_irq_event(dev);               //right path for headless SK=
U
>
> else
>
> drm_kms_helper_hotplug_event(dev);      //wrong path for headless SKU
>
> ...
>
> }
>
>
>
> Thanks!
>
> Rico
>
>
>
> ________________________________
>
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, October 30, 2020 19:48
> To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@=
amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>; Y=
in, Tianci (Rico) <Tianci.Yin@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headles=
s SKU
>
>
>
> [AMD Public Use]
>
> I'm not sure I get your point on changing amdgpu_device_has_dc_support() =
interface by adding new parameter. but it seems to me change input paramete=
r from pdev to adev for nv_is_headless_sku is more straightforward.
>
> Regards,
> Hawking
> -----Original Message-----
> From: Tianci Yin <tianci.yin@amd.com>
> Sent: Friday, October 30, 2020 19:32
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guch=
un.Chen@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd=
.com>; Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.c=
om>
> Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless SK=
U
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> The crash caused by the NULL pointer of
> adev->ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),
> but this function should not be called on headless SKU.
>
> Fix the mismatch between the return value of
> amdgpu_device_has_dc_support() and the real DCN supporting state to avoid=
 calling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().
>
> Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 10 ++++++++--  drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/nv.c             |  2 +-
>  drivers/gpu/drm/amd/amdgpu/nv.h             |  1 +
>  6 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index ba65d4f2ab67..f0183271456f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_de=
vice *adev,
>                                     u32 pcie_index, u32 pcie_data,
>                                     u32 reg_addr, u64 reg_data);
>
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,
> +struct pci_dev *pdev);
>  bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>
>  int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/drivers/=
gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_devi=
ce.c
> index 1fe850e0a94d..323ed69032a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(struc=
t amdgpu_device *adev)
>   * amdgpu_device_asic_has_dc_support - determine if DC supports the asic
>   *
>   * @asic_type: AMD asic type
> + * @pdev: pointer to pci_dev instance
>   *
>   * Check if there is DC (new modesetting infrastructre) support for an a=
sic.
>   * returns true if DC has support, false if not.
>   */
> -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
> +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,
> +struct pci_dev *pdev)
>  {
>          switch (asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC)
> @@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd_as=
ic_type asic_type)
>          case CHIP_VEGA20:
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>          case CHIP_RAVEN:
> +               return amdgpu_dc !=3D 0;
>          case CHIP_NAVI10:
>          case CHIP_NAVI14:
>          case CHIP_NAVI12:
> +               if (nv_is_headless_sku(pdev))
> +                       return false;
> +               else
> +                       return amdgpu_dc !=3D 0;
>          case CHIP_RENOIR:
>  #endif
>  #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
> @@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_dev=
ice *adev)
>          if (amdgpu_sriov_vf(adev) || adev->enable_virtual_display)
>                  return false;
>
> -       return amdgpu_device_asic_has_dc_support(adev->asic_type);
> +       return amdgpu_device_asic_has_dc_support(adev->asic_type, adev->p=
dev);
>  }
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 9e92d2a070ac..97014458d7de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct amdg=
pu_device *adev,
>           */
>          if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>              amdgpu_bo_support_uswc(bo_flags) &&
> -           amdgpu_device_asic_has_dc_support(adev->asic_type)) {
> +           amdgpu_device_asic_has_dc_support(adev->asic_type, adev->pdev=
)) {
>                  switch (adev->asic_type) {
>                  case CHIP_CARRIZO:
>                  case CHIP_STONEY:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4b78ecfd35f7..b23110241267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>          bool supports_atomic =3D false;
>
>          if (!amdgpu_virtual_display &&
> -           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> +           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK, pdev=
))
>                  supports_atomic =3D true;
>
>          if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) { di=
ff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.=
c index 026e0a8fd526..97446ae75b0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
>          adev->virt.ops =3D &xgpu_nv_virt_ops;
>  }
>
> -static bool nv_is_headless_sku(struct pci_dev *pdev)
> +bool nv_is_headless_sku(struct pci_dev *pdev)
>  {
>          if ((pdev->device =3D=3D 0x731E &&
>              (pdev->revision =3D=3D 0xC6 || pdev->revision =3D=3D 0xC7)) =
|| diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgp=
u/nv.h index 515d67bf249f..7880ad0073c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.h
> @@ -29,6 +29,7 @@
>  void nv_grbm_select(struct amdgpu_device *adev,
>                      u32 me, u32 pipe, u32 queue, u32 vmid);  void nv_set=
_virt_ops(struct amdgpu_device *adev);
> +bool nv_is_headless_sku(struct pci_dev *pdev);
>  int nv_set_ip_blocks(struct amdgpu_device *adev);  int navi10_reg_base_i=
nit(struct amdgpu_device *adev);  int navi14_reg_base_init(struct amdgpu_de=
vice *adev);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CTianci=
.Yin%40amd.com%7C7bb51412bcd34843e77508d87f57a76b%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637399361731262326%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6=
HI1w2buiO4YlD%2BWFrV9suA7gmlVRX2IlJmYiAkukcM%3D&amp;reserved=3D0

--_000_DM5PR12MB15463E9C2FA5E873E53A1B9295EF0DM5PR12MB1546namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Alex,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
With DCN enabled,&nbsp; I take amdgpu_test/kfdtest/PhinoexMiner/S3 tests, t=
hey are all PASS.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I ask <a id=3D"OWAAM92843" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-=
nlr ms-fcl-b" href=3D"mailto:Gang.Long@amd.com">
@Long, Gang</a> to take a large coverage test,&nbsp; if it's ok, I will ena=
ble DCN block.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!<br>
</div>
Rico<br>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2020 22:19<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Alex Deucher &lt;=
alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Cui, Flora &lt;Flora.Cui=
@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Tuikov, Luben &lt;Luben=
.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
That should be harmless and we can fix that up.&nbsp; Does everything work =
as expected other than the error message?</div>
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
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Yin, Tianci (Rico) =
&lt;Tianci.Yin@amd.com&gt;<br>
<b>Sent:</b> Monday, November 2, 2020 9:51 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Cui, Flora &lt;Flora.Cui=
@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Tuikov, Luben &lt;Luben=
.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Long,
 Gang &lt;Gang.Long@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Hi Alex,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-size:12pt">If we don't skip DCN in </span><font size=3D=
"2"><span style=3D"font-size:12pt">nv_set_ip_blocks, I find below error,</s=
pan></font><br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"color:rgb(200,38,19)">[ &nbsp;103.949926] [drm:amdgpu_dm_ini=
t.cold [amdgpu]] *ERROR* amdgpu: failed to initialize hdcp_workqueue.</span=
><br>
</div>
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
<div id=3D"x_x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;=
alexdeucher@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, November 3, 2020 1:49<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; Zhang, Hawking &l=
t;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@list=
s.freedesktop.org&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt=
;Feifei.Xu@amd.com&gt;; Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;;
 Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com=
&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 he=
adless SKU</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Does everything work as expected if we don't s=
kip DCN in nv_set_ip_blocks?<br>
<br>
Alex<br>
<br>
On Mon, Nov 2, 2020 at 10:38 AM Deucher, Alexander<br>
&lt;Alexander.Deucher@amd.com&gt; wrote:<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;<br>
&gt; That's the IP discovery table.&nbsp; The Object header is part of atom=
bios.&nbsp; Do you have an vbios image from that system?<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
&gt; Sent: Sunday, November 1, 2020 10:46 PM<br>
&gt; To: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
&gt; Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guchu=
n.Chen@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Fe=
ifei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 head=
less SKU<br>
&gt;<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;<br>
&gt; Thanks very much Hawking!<br>
&gt;<br>
&gt;<br>
&gt; Hi Alex,<br>
&gt;<br>
&gt; The amdgpu_device_ip_get_ip_block() depends on the adev-&gt;ip_blocks =
that initialized by nv_set_ip_blocks().<br>
&gt; In nv_set_ip_blocks(), whether add dm_ip_block depends on amdgpu_devic=
e_has_dc_support().<br>
&gt; And amdgpu_device_has_dc_support() depends on amdgpu_device_asic_has_d=
c_support(),<br>
&gt; So amdgpu_device_asic_has_dc_support() can't conditional on amdgpu_dev=
ice_ip_get_ip_block(), it makes a dependency loop.<br>
&gt;<br>
&gt; I have just checked the atombios object table in the headless VBIOS, a=
nd find DCN and VCN are still there.<br>
&gt; [&nbsp; 174.815714] [drm:amdgpu_discovery_reg_base_init [amdgpu]] DMU(=
271) #0 v2.0.2:<br>
&gt; [&nbsp; 174.815771] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00=
000012<br>
&gt; [&nbsp; 174.815829] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00=
0000c0<br>
&gt; [&nbsp; 174.815887] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00=
0034c0<br>
&gt; [&nbsp; 174.815945] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00=
009000<br>
&gt; [&nbsp; 174.816002] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x02=
403c00<br>
&gt; [&nbsp; 174.821854] [drm:amdgpu_discovery_reg_base_init [amdgpu]] UVD(=
12) #0 v2.0.0:<br>
&gt; [&nbsp; 174.821908] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00=
007800<br>
&gt; [&nbsp; 174.821962] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x00=
007e00<br>
&gt; [&nbsp; 174.822017] [drm:amdgpu_discovery_reg_base_init [amdgpu]] 0x02=
403000<br>
&gt; So I think DAL driver can't tell it's a normal ASIC or headless ASIC.<=
br>
&gt;<br>
&gt; Thanks!<br>
&gt; Rico<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
&gt; Sent: Friday, October 30, 2020 22:18<br>
&gt; To: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Yin, Tianci (Rico) &=
lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.=
freedesktop.org&gt;<br>
&gt; Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Chen, Guchun &lt;Guchu=
n.Chen@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Fe=
ifei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.com&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 head=
less SKU<br>
&gt;<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;<br>
&gt; Maybe it would be easier to check if the DCE IP exists? E.g.,<br>
&gt; if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE) ||<br>
&gt; (!amdgpu_device_has_dc_support(adev))<br>
&gt; ...<br>
&gt;<br>
&gt; Also do we even need to skip DCN init for these cards, or will the dis=
play code handle it automatically since there will be no displays in the at=
ombios object table.&nbsp; We didn't do anything special for display with t=
he polaris blockchain cards.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
&gt; Sent: Friday, October 30, 2020 9:00 AM<br>
&gt; To: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freed=
esktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; C=
ui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; =
Long, Gang &lt;Gang.Long@amd.com&gt;<br>
&gt; Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 head=
less SKU<br>
&gt;<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I see, thanks for the clarifying. The patch is<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I was thinking to have a new flag like AMD_IS_HEADLESS in amd_chip_fla=
g, but after think it a bit more, that=92s just complicated the case, I agr=
ee with your current approach.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Hawking<br>
&gt;<br>
&gt; From: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
&gt; Sent: Friday, October 30, 2020 20:05<br>
&gt; To: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
&gt; Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; C=
ui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; =
Long, Gang &lt;Gang.Long@amd.com&gt;<br>
&gt; Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 head=
less SKU<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi Hawking,<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; amdgpu_device_asic_has_dc_support() is referrenced by amdgpu_pci_probe=
(),<br>
&gt;<br>
&gt; at that point, adev has not been allocated yet.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; My change can make it to right code path.<br>
&gt;<br>
&gt; int amdgpu_device_resume(struct drm_device *dev, bool fbcon)<br>
&gt; {<br>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt; if (!amdgpu_device_has_dc_support(adev))<br>
&gt;<br>
&gt; drm_helper_hpd_irq_event(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //right path for headless SKU<=
br>
&gt;<br>
&gt; else<br>
&gt;<br>
&gt; drm_kms_helper_hotplug_event(dev);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //wro=
ng path for headless SKU<br>
&gt;<br>
&gt; ...<br>
&gt;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
&gt; Rico<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt;<br>
&gt; From: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
&gt; Sent: Friday, October 30, 2020 19:48<br>
&gt; To: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freed=
esktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
&gt; Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; C=
ui, Flora &lt;Flora.Cui@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; =
Long, Gang &lt;Gang.Long@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd=
.com&gt;<br>
&gt; Subject: RE: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 head=
less SKU<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; [AMD Public Use]<br>
&gt;<br>
&gt; I'm not sure I get your point on changing amdgpu_device_has_dc_support=
() interface by adding new parameter. but it seems to me change input param=
eter from pdev to adev for nv_is_headless_sku is more straightforward.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Hawking<br>
&gt; -----Original Message-----<br>
&gt; From: Tianci Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; Sent: Friday, October 30, 2020 19:32<br>
&gt; To: amd-gfx@lists.freedesktop.org<br>
&gt; Cc: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt=
;; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Cui, Flora &lt;Flora.Cui@amd.c=
om&gt;; Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Long, Gang &lt;Gang.Long@amd.=
com&gt;;
 Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: fix NULL pointer crash on navi10 headless=
 SKU<br>
&gt;<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin@amd.com&gt;<br>
&gt;<br>
&gt; The crash caused by the NULL pointer of<br>
&gt; adev-&gt;ddev.mode_config.funcs in drm_kms_helper_hotplug_event(),<br>
&gt; but this function should not be called on headless SKU.<br>
&gt;<br>
&gt; Fix the mismatch between the return value of<br>
&gt; amdgpu_device_has_dc_support() and the real DCN supporting state to av=
oid calling to drm_kms_helper_hotplug_event() in amdgpu_device_resume().<br=
>
&gt;<br>
&gt; Change-Id: I3a3d387e6ab5b774abb3911ea1bf6de60797759d<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp; | 10 ++++++++--=
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/nv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +<br>
&gt;&nbsp; 6 files changed, 13 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index ba65d4f2ab67..f0183271456f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1090,7 +1090,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu=
_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
pcie_index, u32 pcie_data,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 =
reg_addr, u64 reg_data);<br>
&gt;<br>
&gt; -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);=
<br>
&gt; +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,<=
br>
&gt; +struct pci_dev *pdev);<br>
&gt;&nbsp; bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);<b=
r>
&gt;<br>
&gt;&nbsp; int emu_soc_asic_init(struct amdgpu_device *adev); diff --git a/=
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amd=
gpu_device.c<br>
&gt; index 1fe850e0a94d..323ed69032a7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -2960,11 +2960,12 @@ static void amdgpu_device_detect_sriov_bios(st=
ruct amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp; * amdgpu_device_asic_has_dc_support - determine if DC supp=
orts the asic<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * @asic_type: AMD asic type<br>
&gt; + * @pdev: pointer to pci_dev instance<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * Check if there is DC (new modesetting infrastructre) sup=
port for an asic.<br>
&gt;&nbsp;&nbsp; * returns true if DC has support, false if not.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)<=
br>
&gt; +bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type,<=
br>
&gt; +struct pci_dev *pdev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (asic_typ=
e) {<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC)<br>
&gt; @@ -3000,9 +3001,14 @@ bool amdgpu_device_asic_has_dc_support(enum amd=
_asic_type asic_type)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20=
:<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RAVEN:=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return amdgpu_dc !=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10=
:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14=
:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12=
:<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (nv_is_headless_sku(pdev))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return fals=
e;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdg=
pu_dc !=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_RENOIR=
:<br>
&gt;&nbsp; #endif<br>
&gt;&nbsp; #if defined(CONFIG_DRM_AMD_DC_DCN3_0)<br>
&gt; @@ -3033,7 +3039,7 @@ bool amdgpu_device_has_dc_support(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov=
_vf(adev) || adev-&gt;enable_virtual_display)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc=
_support(adev-&gt;asic_type);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_device_asic_has_dc=
_support(adev-&gt;asic_type, adev-&gt;pdev);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; index 9e92d2a070ac..97014458d7de 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; @@ -516,7 +516,7 @@ uint32_t amdgpu_display_supported_domains(struct a=
mdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((bo_flags &a=
mp; AMDGPU_GEM_CREATE_CPU_GTT_USWC) &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_bo_support_uswc(bo_flags) &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(adev-&gt;asic_type)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(adev-&gt;asic_type, adev-&gt;pdev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_CARRIZO:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_STONEY:<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 4b78ecfd35f7..b23110241267 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -1117,7 +1117,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool supports_at=
omic =3D false;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_virt=
ual_display &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(flags &amp; AMD_ASIC_MASK))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_d=
evice_asic_has_dc_support(flags &amp; AMD_ASIC_MASK, pdev))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; supports_atomic =3D true;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((flags &amp;=
 AMD_EXP_HW_SUPPORT) &amp;&amp; !amdgpu_exp_hw_support) { diff --git a/driv=
ers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 026e0a8=
fd526..97446ae75b0b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
&gt; @@ -493,7 +493,7 @@ void nv_set_virt_ops(struct amdgpu_device *adev)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;virt.op=
s =3D &amp;xgpu_nv_virt_ops;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; -static bool nv_is_headless_sku(struct pci_dev *pdev)<br>
&gt; +bool nv_is_headless_sku(struct pci_dev *pdev)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((pdev-&gt;de=
vice =3D=3D 0x731E &amp;&amp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (pdev-&gt;revision =3D=3D 0xC6 || pdev-&gt;revision =3D=3D 0xC7)) |=
| diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu=
/nv.h index 515d67bf249f..7880ad0073c9 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/nv.h<br>
&gt; @@ -29,6 +29,7 @@<br>
&gt;&nbsp; void nv_grbm_select(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 me, u32 pipe, u=
32 queue, u32 vmid);&nbsp; void nv_set_virt_ops(struct amdgpu_device *adev)=
;<br>
&gt; +bool nv_is_headless_sku(struct pci_dev *pdev);<br>
&gt;&nbsp; int nv_set_ip_blocks(struct amdgpu_device *adev);&nbsp; int navi=
10_reg_base_init(struct amdgpu_device *adev);&nbsp; int navi14_reg_base_ini=
t(struct amdgpu_device *adev);<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7CTianci.Yin%40amd.com%7C7bb51412bcd34843e77508d87f57a76b%7C3dd8=
961fe4884e608e11a82d994e183d%7C0%7C0%7C637399361731262326%7CUnknown%7CTWFpb=
GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C1000&amp;amp;sdata=3D6HI1w2buiO4YlD%2BWFrV9suA7gmlVRX2IlJmYiAkukcM%3D&amp;=
amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7CTian=
ci.Yin%40amd.com%7C7bb51412bcd34843e77508d87f57a76b%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637399361731262326%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sda=
ta=3D6HI1w2buiO4YlD%2BWFrV9suA7gmlVRX2IlJmYiAkukcM%3D&amp;amp;reserved=3D0<=
/a><br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB15463E9C2FA5E873E53A1B9295EF0DM5PR12MB1546namp_--

--===============0608562222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0608562222==--
