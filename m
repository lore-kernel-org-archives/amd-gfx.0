Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F122C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD462082E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nrg8w369"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD462082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1B936E878;
	Mon, 16 Dec 2019 20:06:54 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680085.outbound.protection.outlook.com [40.107.68.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFD06E878
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzrkRqQq6blpfGZOx1Js/H22fJNkE/DDO0ASyirUL7W9ZQRm9UKKCacX/H83LaxUFQXFoQ8PE2ZAgcPfhI5TDM0NrtxsX9H6jEkUxtIRBUDJecIBpuOKBixosnTTOnQ2/prYygdgrukr8sxmlnx4arKAX0PgqBd/INuOePzfcRzXrMPgc6avhWOEwLsvMxozHOHmN7Bp8Us+u3HY/SlaBRdrwDXBGCtxIpbQdoS3pEnWipr+oj40G1YhpxsiYyy2gNBKOvKqxASFqFOZhg2OqP2s/4EBPoJgPbZW73dauzmJUAZ1VnFvJl24dOvqcEALaRhL1C5CreHqF68yCaKSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjw6Ag+OiiNJAtka6qM6fA0hTqfzxXSsZR2kIG1ehe8=;
 b=OJ3XMQv80iX6kajPndAWa0PVULXgOAf+sBgV5Ke8jKl9CODZoipodwGH+q4OT4g5eGuQKmHKD56LtDUlG7YFdDVKpFHPFaggCx0B1hBIOewTmZsP0/qXjTNlgci21dPCqEZDpU4IMgSEtxUQXZ3Wb1+Y1htGilXLkipLL+RTnOA548sgJdOGdwYliLrQBGoVHzZybrdoDSutDvmaMFMteXhglTeuSD8TcaPi9szkAnzQqLS6tLjoviswGzkris1LBfI+kPKOyX+zVgoFvsqTOG0UJzMvr60QcfxZsXtfFUp3MlqUnOxPzvJhYD77Qk/NppfxNTlh22cChUu0Rx8tIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjw6Ag+OiiNJAtka6qM6fA0hTqfzxXSsZR2kIG1ehe8=;
 b=nrg8w369d38zxIxOKjuZFfKgTDXxiGazAz2Kse2M66ESrYVEBnOeLzrbsBLeteiOIPNJ1rud8MvNAAV755ER8Fd6/CrMV/5x2EM2LfNqHPt2XS2IepH4tjhagtPqZTM0H/+ZUmu6ICTWxAv8ZNTXZYn7ExW9L1N77q4uQlpUysE=
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB2538.namprd12.prod.outlook.com (10.172.85.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Mon, 16 Dec 2019 20:06:52 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::5878:940a:dd61:4d22%9]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 20:06:52 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()
Thread-Topic: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()
Thread-Index: AQHVsdO5S0nNl2m0kEG3xDZsxmhsPKe9LXaAgAAGOd8=
Date: Mon, 16 Dec 2019 20:06:52 +0000
Message-ID: <DM5PR1201MB0137E11E22AE6E13467F2EC1F0510@DM5PR1201MB0137.namprd12.prod.outlook.com>
References: <20191213163807.27139-1-Yong.Zhao@amd.com>,
 <34c29118-32e9-3c37-9b48-ad33a0de8b99@amd.com>
In-Reply-To: <34c29118-32e9-3c37-9b48-ad33a0de8b99@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-16T20:06:49.843Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a6fb3e13-8153-44b4-fc97-08d782637e0f
x-ms-traffictypediagnostic: DM5PR1201MB2538:|DM5PR1201MB2538:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB25381C01737BB31844A51A10F0510@DM5PR1201MB2538.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(186003)(86362001)(33656002)(110136005)(55016002)(71200400001)(4001150100001)(26005)(19627405001)(316002)(53546011)(6506007)(66446008)(66946007)(66556008)(76116006)(64756008)(91956017)(7696005)(81156014)(81166006)(2906002)(478600001)(8676002)(9686003)(52536014)(5660300002)(66476007)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2538;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wYxqpYDJfV33mEGB1Y/rf3xVHBLo8YiYatT03AHbyWznzts5OZrfIzQLo7C3q0f4z+/Iq52GFIEZ6DSy8atchb6YDFF1M0rScWqHyBiq4c1KguWS85VEgdq4cQlGh9guD7nNvopUdcXGL4Urp5dihA65YeHlpJDgR7OKo7N+OnF7OqCfPPjWzkEbFO2l9ezJNIXjB/HyFLcuIWTrvdeO0ywPinfJuEcwQUbrjfvaddRIOIlS8lunbg6LDbfB5vlyVbdpLiKpnzIUd03PBH8twQLQgFulZubrZ6ReLt9BjD30P30nEsY/lnX8GzA5e4AisXwz//6kk4pxGRTUSzbbpW6KVRK+tPVEqunNPEyTvUkB1stD0ge7NqLlAhAN35E20BIFrRbIkM/VoYxKwwwpU6V91GTKsVgIGwu2ms2aQr/k4YyZgVL7P14+1MYAMdEr
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fb3e13-8153-44b4-fc97-08d782637e0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 20:06:52.2695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ku/EBKdMocXUSvkep/EFNQXbxcJBjhZsaXXeFbpCLPgFSLt/OhIGSta47g5hSLGo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2538
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
Content-Type: multipart/mixed; boundary="===============0110722923=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0110722923==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB0137E11E22AE6E13467F2EC1F0510DM5PR1201MB0137_"

--_000_DM5PR1201MB0137E11E22AE6E13467F2EC1F0510DM5PR1201MB0137_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

The problem happens when we want to reuse the same function for ASICs which=
 have fewer SDMA engines. Some pointers on which SOC15_REG_OFFSET depends f=
or some higher index SDMA engines are 0, causing NULL pointer.

I will fix the default case in switch.

Yong

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Monday, December 16, 2019 2:39 PM
To: Zhao, Yong <Yong.Zhao@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_offset()

On 2019-12-13 8:38, Yong Zhao wrote:
> This prevents the NULL pointer access when there are fewer than 8 sdma
> engines.

I don't see where you got a NULL pointer in the old code. Also this
change is in an Arcturus-specific source file. AFAIK Arcturus always has
8 SDMA engines.

The new code is much longer than the old code. I don't see how that's an
improvement. See one more comment inline.


>
> Change-Id: Iabae9bff7546b344720905d5d4a5cfc066a79d25
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   | 64 ++++++++++++-------
>   1 file changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 3c119407dc34..2ad088f10493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -71,32 +71,52 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu=
_device *adev,
>                                unsigned int engine_id,
>                                unsigned int queue_id)
>   {
> -     uint32_t sdma_engine_reg_base[8] =3D {
> -             SOC15_REG_OFFSET(SDMA0, 0,
> -                              mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA1, 0,
> -                              mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA2, 0,
> -                              mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA3, 0,
> -                              mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA4, 0,
> -                              mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA5, 0,
> -                              mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA6, 0,
> -                              mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CN=
TL,
> -             SOC15_REG_OFFSET(SDMA7, 0,
> -                              mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CN=
TL
> -     };
> -
> -     uint32_t retval =3D sdma_engine_reg_base[engine_id]

I'm not sure where you were getting a NULL pointer, but I guess this
could have used a range check to make sure engine_id is < 8 before
indexing into the array. The equivalent in the switch statement would be
a default case. See below.


> +     uint32_t sdma_engine_reg_base;
> +     uint32_t sdma_rlc_reg_offset;
> +
> +     switch (engine_id) {
> +     case 0:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA0, 0,
> +                             mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNT=
L;
> +             break;
> +     case 1:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA1, 0,
> +                             mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNT=
L;
> +             break;
> +     case 2:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA2, 0,
> +                             mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNT=
L;
> +             break;
> +     case 3:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA3, 0,
> +                             mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNT=
L;
> +             break;
> +     case 4:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA4, 0,
> +                             mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNT=
L;
> +             break;
> +     case 5:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA5, 0,
> +                             mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNT=
L;
> +             break;
> +     case 6:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA6, 0,
> +                             mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNT=
L;
> +             break;
> +     case 7:
> +             sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA7, 0,
> +                             mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNT=
L;
> +             break;
> +

Do you need a default case for the switch statement? I think you get a
compiler warning without one.

Regards,
   Felix


> +     }
> +
> +     sdma_rlc_reg_offset =3D sdma_engine_reg_base
>                + queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_RB_CNTL)=
;
>
>        pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id=
,
> -                     queue_id, retval);
> +                     queue_id, sdma_rlc_reg_offset);
>
> -     return retval;
> +     return sdma_rlc_reg_offset;
>   }
>
>   static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,

--_000_DM5PR1201MB0137E11E22AE6E13467F2EC1F0510DM5PR1201MB0137_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The problem happens when we want to reuse the same function for ASICs which=
 have fewer SDMA engines. Some pointers on which&nbsp;<span style=3D"font-f=
amily: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quo=
t;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetic=
a Neue&quot;, sans-serif; font-size: 14.6667px; background-color: rgb(255, =
255, 255); display: inline !important">SOC15_REG_OFFSET
 depends for some higher index SDMA engines are 0, causing NULL pointer.&nb=
sp;</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">I will fix the
 default case in switch.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px; backgr=
ound-color: rgb(255, 255, 255); display: inline !important">Yong</span></di=
v>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Monday, December 16, 2019 2:39 PM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Improve function get_sdma_rlc_reg_o=
ffset()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On 2019-12-13 8:38, Yong Zhao wrote:<br>
&gt; This prevents the NULL pointer access when there are fewer than 8 sdma=
<br>
&gt; engines.<br>
<br>
I don't see where you got a NULL pointer in the old code. Also this <br>
change is in an Arcturus-specific source file. AFAIK Arcturus always has <b=
r>
8 SDMA engines.<br>
<br>
The new code is much longer than the old code. I don't see how that's an <b=
r>
improvement. See one more comment inline.<br>
<br>
<br>
&gt;<br>
&gt; Change-Id: Iabae9bff7546b344720905d5d4a5cfc066a79d25<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c&nbsp;&nbsp; | =
64 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&gt;&nbsp;&nbsp; 1 file changed, 42 insertions(&#43;), 22 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; index 3c119407dc34..2ad088f10493 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<=
br>
&gt; @@ -71,32 &#43;71,52 @@ static uint32_t get_sdma_rlc_reg_offset(struct=
 amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int engine_id,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int queue_id)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base[8] =3D {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA0, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA1, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA2, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA3, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA4, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA5, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA6, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNTL=
,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; SOC15_REG_OFFSET(SDMA7, 0,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t retval =3D sdma_engine_reg_base[eng=
ine_id]<br>
<br>
I'm not sure where you were getting a NULL pointer, but I guess this <br>
could have used a range check to make sure engine_id is &lt; 8 before <br>
indexing into the array. The equivalent in the switch statement would be <b=
r>
a default case. See below.<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_engine_reg_base;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_rlc_reg_offset;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (engine_id) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA0, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA1, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA1_RLC0_RB_CNTL) - mmSDMA1_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA2, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA3, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA3_RLC0_RB_CNTL) - mmSDMA3_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA4, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA4_RLC0_RB_CNTL) - mmSDMA4_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 5:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA5, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA5_RLC0_RB_CNTL) - mmSDMA5_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 6:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA6, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA6_RLC0_RB_CNTL) - mmSDMA6_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 7:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sdma_engine_reg_base =3D SOC15_REG_OFFSET(SDMA7, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; mmSDMA7_RLC0_RB_CNTL) - mmSDMA7_RLC0_RB_CNTL;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;<br>
<br>
Do you need a default case for the switch statement? I think you get a <br>
compiler warning without one.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; sdma_rlc_reg_offset =3D sdma_engine_reg_=
base<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43; queue_id * (mmSDMA0_RLC1_RB_CNTL - mmSDMA0_RLC0_R=
B_CNTL);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;RLC register =
offset for SDMA%d RLC%d: 0x%x\n&quot;, engine_id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id, retval);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id, sdma_rlc_=
reg_offset);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return retval;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return sdma_rlc_reg_offset;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int kgd_hqd_sdma_load(struct kgd_dev *kgd, void *mq=
d,<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR1201MB0137E11E22AE6E13467F2EC1F0510DM5PR1201MB0137_--

--===============0110722923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0110722923==--
