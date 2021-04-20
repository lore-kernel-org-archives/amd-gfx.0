Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DCFC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 09:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC54E610A1
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 09:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC54E610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852026E525;
	Tue, 20 Apr 2021 09:32:58 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700066.outbound.protection.outlook.com [40.107.70.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E796E525
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 09:32:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaoqY41Q9H795L0CCSmiOQ3fIJ6PweuGnNSF+EtN1Tig7EP4ynFImHZ/LOg6uFV/pKTWoGhX+1AInR5C/3sNH2GQycR0Ojd51WNJhKPj3JxV0pI5U5XoJ8J3yWj57doO9kJ94lTdlW3orz9+5B70DkYAkPq78I2L4SbJcOO/vcPqIpQmqEEV3fRXenEIc82Egya6KLw03Nws5wSiIA1oYnM/Y9aDG2KbVw7WmTQskM44ZQwhIfximWM6XV1kNY701vA2lRn0C3Inw8pNruMEdz6cZU2B3U+HbXpwGtyZWCSHfjlKkVmFRfK+GFR/6FRdX/+hD+xe2w5GSJBbIWbc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q+Rv7Pb8TpaZ3/Q27ZNinDMB+oZ2wEtarZkDKzFjLg=;
 b=OjGXs5A/Vyh+sJUGYvR0E7DRweZrfA7TtQWCBdPmrHBmbGqmViMjZSbEdPZAko+LBeL/DHNWB71qxDmPmPPsZPgoo0VWE+AOrM6aHEETkwo+DSH4If5vsFw0B1kHrGWYCchXuwqSTuJT7tAuL8hH3pg0mQFUA+nA/L5GcVrV1xRcsJjsL4M4hD2B2Go1Udu6PmfcDcWFUDZDhf5rBOZ0mU8YUeBU6b/iRK6OLn3Ngi4nduFPEissoMacfMBx6wQGaWgj1A/VA4CvrGD03U5r/ZLc6xUM1L4vlmzeVPJx7n+XotK9KZc/RlX77OUmiFtW28rgCQ8EeXLuGxWK/ZbsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q+Rv7Pb8TpaZ3/Q27ZNinDMB+oZ2wEtarZkDKzFjLg=;
 b=4NnF3Jc4Lt/+I8HDEfxXZf+4A2pmLUFYCE/D3cxWQ9A9jR0GolvTsFVZImxB7nItwPFO8GZuqN2pflmD4mxIh1yDlE8yHBDFSfPla5jI4YAOhNW12C6c8S42gSd3r7Ikfmi0eNdOq06FEs5fLOhn5aXLD3lDEf6LXXxUjWY3s58=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 09:32:54 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e%2]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 09:32:54 +0000
Content-Type: multipart/mixed;
 boundary="_000_BY5PR12MB41152B09FB91C66FCFB4677C8F489BY5PR12MB4115namp_"
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "Sun, Roy" <Roy.Sun@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
Thread-Index: AQHXNOT21hvSX0OYoEqT8ipDcRHcAKq9G5uAgAAKYjA=
Date: Tue, 20 Apr 2021 09:32:54 +0000
Message-ID: <BY5PR12MB41152B09FB91C66FCFB4677C8F489@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210419062624.27688-1-Roy.Sun@amd.com>
 <20210419062624.27688-2-Roy.Sun@amd.com>
 <CY4PR12MB160684A2AD3C7F6A2EAE664CFF489@CY4PR12MB1606.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB160684A2AD3C7F6A2EAE664CFF489@CY4PR12MB1606.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: <BY5PR12MB41152B09FB91C66FCFB4677C8F489@BY5PR12MB4115.namprd12.prod.outlook.com>
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-20T08:53:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8d31dff2-86ef-49b7-bcc9-485ad6d7eeab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daa0fd88-6e6b-436d-f639-08d903df4699
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB400122BE27170B5D16DB1DA88F489@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3hkzRJOnCk3kO1w7WEpNwcamKY370WzlI2J5V18rz5VoRFsjMGTjVHn0/KkMrpunAuXfNmceTs0HxLFottkuogz8D2O/DRL+gIqKffu0jntoLDAt+/gxGCx9CBwZVuVXo99b6bL+RAWoetaZsdQ7COlCfyG2NOB3G4jnbM7FUryhtWFdW+HMh3SribZByT1GMYqwoKMXxqiT6AhoXf+tRz0onlsfHma9x7Rk2b9krJXt8piNOCmRZAiJWAQdVqEl3bDT8FaL/BEEGOirjlk1kMSJaZ9HlUy9eNfq2acvP7cXOdu9B2FJjdHGWzEjHi3/2aEclnrzbf7FXQXotSD6pTk7G+98Tsv5O8IO4qpQu9jesZ5a5z/EIATWfgFc9fpSOrBEjEN8wl9fpxw9NXAc8aq3VcjJAFeZAmyvpWZ5MpdhHWIeSWx94oSqYJeiavdK18M3vtpQ1ER9/R6UypODeiaFU9hZk5f/z+1jsI3416qCsnIdUB912TogcizpZehAsTADrr1xMvhaDC7QxOpocwMpI5R/6OkQBIMNtQdpxl37vpG6FVhuSIV9QBvhJK8X7k4KIm5VM/cCrV3HE31Ccl0CI0tiz+biHa64NxTGJi7KEAsrEAKrsR/+OF+q/R9UvDfdULM9VDwm6E0f8u3v2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(45080400002)(7696005)(76116006)(71200400001)(54906003)(9686003)(66946007)(6506007)(52536014)(33656002)(30864003)(8936002)(478600001)(316002)(66446008)(122000001)(38100700002)(5660300002)(26005)(8676002)(83380400001)(186003)(66476007)(55016002)(110136005)(66556008)(4326008)(64756008)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Rnbn3P8TEEfsVanpqkYg4ptYbZBdNuU/NCYpQvFRaByJZ/wNoidANGrVdT?=
 =?iso-8859-1?Q?xZsu8iceh+8nxa+dTvleajIiSU9Nz+WWDF6xXRe3/YsvjdQonU7NKXhueh?=
 =?iso-8859-1?Q?eVP+TA5OHb77PPcsFfd/R4q6qUtAwvWGF/LSlRPPsPBu3F73VX09SIUdNf?=
 =?iso-8859-1?Q?H69Cgtk1aFXQWqopJKUSV0ONKP7ynRfEeGGk3QuZ1uY/EYOzJJLkvNdDAT?=
 =?iso-8859-1?Q?iA8ef6IzPzLUGo2P2XMb7VaVpc7oZCPVLrKTrUZ1q3XD9NFsCcoEacS5dQ?=
 =?iso-8859-1?Q?qCGUx8ee2/Q/jkJK/5yLeXiRkGuewRz21bABrF9e2wRtjKoA7ImQg/eSfF?=
 =?iso-8859-1?Q?9rI3wg8gy8p8MPwWwWZB9qxaxMvm45k+UhC2IUwSGoANDBUaDiknQciEuJ?=
 =?iso-8859-1?Q?GsN0zEpJBDc1tdz9BoNxxsbQ7FHm5Fw3cW1ssk8HJf73+7dpEw86bkZn0y?=
 =?iso-8859-1?Q?378Z+UZwsRXUuFsmBXzm+XG3MVRx46/fZa0znDi9lJXBWNyJN972/OZT7I?=
 =?iso-8859-1?Q?PuHu6IhJZzQQWTVjCDZEtwFu5/KfhdavcA99t9UwjsbrXAemNdLWdJdmrm?=
 =?iso-8859-1?Q?NgGkZGFFaonxsC7DFNnH6GIHzmRssXt1j9agPwp2e/KOlnZ3i6NJ/yzuQl?=
 =?iso-8859-1?Q?EBM4/Oe+Q7L1GFSWeuBveuswPrI6vMnWWHTA67hN01G7OP7+eQArTAuJbR?=
 =?iso-8859-1?Q?TPWpa7DBmlxhw34Bz1/5K9X/kpg6XN93G6wyb0XD82JeLNvR4irMT+Bfin?=
 =?iso-8859-1?Q?EUggGURXanUUplaR73IFBuKtYMe/ukTS4n+DUAdBdtE/ejbCS07z6anwdB?=
 =?iso-8859-1?Q?+epv/0IX4/5YAe9Ony3VNCnpTtN0IwZ7T3x35zGx7Imo8uqNMqmYbkq8FW?=
 =?iso-8859-1?Q?rpA+R9G9Ku0z2GFFVdwSoBfyQcMDXPJt3iGpTCR6RcZZxQ4mGf9mzRNhzi?=
 =?iso-8859-1?Q?onvEyZ6yZnEgTjl+K4NmvN85gXejBVT8DtAs9r0x4bgyjXdByx3y6UXEov?=
 =?iso-8859-1?Q?UcSvnh2VS/dzR/4sMHQ3cuJl38jbxD/GMvPbssBlTLsq4k40owIBTlGnqI?=
 =?iso-8859-1?Q?kZ8glp5z3yGf+zMfV4y60A0XL7Hf99xHKAzF5clfKfgFWrJMh/ufBD+tkw?=
 =?iso-8859-1?Q?i//jSEZUHNfGAHOlwQBlOkjeScZvU/ZWWLOBxiTDPF3CVW7H9DQYfkH4h4?=
 =?iso-8859-1?Q?wvw7lVb/729jXgnIGikzb9w40gmFRYTplwpbaD0KKeXuSXmivaXuz/gJXp?=
 =?iso-8859-1?Q?1Qfd8D+5/BiTqERwSxPxOHULfYeq+NTEz/sI7KUbRG1i5OrqSsAi+PKFDA?=
 =?iso-8859-1?Q?uFyElIJxp2/Dq3t4qkn6GCX2FqvRhmFmGQEctUIKe0LmXN3OEmYj5NsrVb?=
 =?iso-8859-1?Q?g0S6j+N5zI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa0fd88-6e6b-436d-f639-08d903df4699
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 09:32:54.5018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EqYixlKephhjueaZnulYc+N9bN3ky0IvhyhQyk4U0yvbrFmLD0Ga4sfUakX1nSO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Cc: "Wang, Yin" <Yin.Wang@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Kuo, Richard" <richard.kuo@amd.com>, "Nieto, David M" <David.Nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BY5PR12MB41152B09FB91C66FCFB4677C8F489BY5PR12MB4115namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,
     Could you help to review these patches again, thanks.

Best wishes
Emily Deng
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sun, Ro=
y
>Sent: Tuesday, April 20, 2021 4:54 PM
>To: Sun, Roy <Roy.Sun@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Nieto, David M <David.Nieto@amd.com>
>Subject: RE: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
>
>[AMD Official Use Only - Internal Distribution Only]
>
>Ping.
>Could you help review this patch again?
>
>BR
>Roy
>
>-----Original Message-----
>From: Roy Sun <Roy.Sun@amd.com>
>Sent: Monday, April 19, 2021 2:26 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Sun, Roy <Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
>Subject: [PATCH 2/2] drm/amdgpu: Add show_fdinfo() interface
>
>Tracking devices, process info and fence info using /proc/pid/fdinfo
>
>Signed-off-by: David M Nieto <David.Nieto@amd.com>
>Signed-off-by: Roy Sun <Roy.Sun@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/Makefile        |  2 +
> drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 61 ++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  5 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  5 +-
> drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 95
>++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h |
>43 ++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 24 ++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  4 +
> 10 files changed, 239 insertions(+), 2 deletions(-)  create mode 100644
>drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>b/drivers/gpu/drm/amd/amdgpu/Makefile
>index ee85e8aba636..d216b7ecb5d1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/Makefile
>+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>@@ -58,6 +58,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
> 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
>amdgpu_rap.o \
> 	amdgpu_fw_attestation.o amdgpu_securedisplay.o
>
>+amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
>+
> amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o
>
> # add asic specific block
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>index 125b25a5ce5b..3365feae15e1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>@@ -107,6 +107,7 @@
> #include "amdgpu_gfxhub.h"
> #include "amdgpu_df.h"
> #include "amdgpu_smuio.h"
>+#include "amdgpu_fdinfo.h"
>
> #define MAX_GPU_INSTANCE		16
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>index 0350205c4897..01fe60fedcbe 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>@@ -651,3 +651,64 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr
>*mgr)
> 	idr_destroy(&mgr->ctx_handles);
> 	mutex_destroy(&mgr->lock);
> }
>+
>+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct
>amdgpu_ctx_entity *centity,
>+		ktime_t *total, ktime_t *max)
>+{
>+	ktime_t now, t1;
>+	uint32_t i;
>+
>+	now =3D ktime_get();
>+	for (i =3D 0; i < amdgpu_sched_jobs; i++) {
>+		struct dma_fence *fence;
>+		struct drm_sched_fence *s_fence;
>+
>+		spin_lock(&ctx->ring_lock);
>+		fence =3D dma_fence_get(centity->fences[i]);
>+		spin_unlock(&ctx->ring_lock);
>+		if (!fence)
>+			continue;
>+		s_fence =3D to_drm_sched_fence(fence);
>+		if (!dma_fence_is_signaled(&s_fence->scheduled))
>+			continue;
>+		t1 =3D s_fence->scheduled.timestamp;
>+		if (t1 >=3D now)
>+			continue;
>+		if (dma_fence_is_signaled(&s_fence->finished) &&
>+			s_fence->finished.timestamp < now)
>+			*total +=3D ktime_sub(s_fence->finished.timestamp, t1);
>+		else
>+			*total +=3D ktime_sub(now, t1);
>+		t1 =3D ktime_sub(now, t1);
>+		dma_fence_put(fence);
>+		*max =3D max(t1, *max);
>+	}
>+}
>+
>+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr,
>uint32_t hwip,
>+		uint32_t idx, uint64_t *elapsed)
>+{
>+	struct idr *idp;
>+	struct amdgpu_ctx *ctx;
>+	uint32_t id;
>+	struct amdgpu_ctx_entity *centity;
>+	ktime_t total =3D 0, max =3D 0;
>+
>+	if (idx >=3D AMDGPU_MAX_ENTITY_NUM)
>+		return 0;
>+	idp =3D &mgr->ctx_handles;
>+	mutex_lock(&mgr->lock);
>+	idr_for_each_entry(idp, ctx, id) {
>+		if (!ctx->entities[hwip][idx])
>+			continue;
>+
>+		centity =3D ctx->entities[hwip][idx];
>+		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
>+	}
>+
>+	mutex_unlock(&mgr->lock);
>+	if (elapsed)
>+		*elapsed =3D max;
>+
>+	return total;
>+}
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>index f54e10314661..10dcf59a5c6b 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>@@ -87,5 +87,8 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
>void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);  long
>amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
>void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
>-
>+ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr,
>uint32_t hwip,
>+		uint32_t idx, uint64_t *elapsed);
>+void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct
>amdgpu_ctx_entity *centity,
>+		ktime_t *total, ktime_t *max);
> #endif
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>index 0369d3532bf0..01603378dbc9 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>@@ -42,7 +42,7 @@
> #include "amdgpu_irq.h"
> #include "amdgpu_dma_buf.h"
> #include "amdgpu_sched.h"
>-
>+#include "amdgpu_fdinfo.h"
> #include "amdgpu_amdkfd.h"
>
> #include "amdgpu_ras.h"
>@@ -1692,6 +1692,9 @@ static const struct file_operations
>amdgpu_driver_kms_fops =3D {  #ifdef CONFIG_COMPAT
> 	.compat_ioctl =3D amdgpu_kms_compat_ioctl,  #endif
>+#ifdef CONFIG_PROC_FS
>+	.show_fdinfo =3D amdgpu_show_fdinfo
>+#endif
> };
>
> int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv) =
diff --git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>new file mode 100644
>index 000000000000..781a06101c22
>--- /dev/null
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
>@@ -0,0 +1,95 @@
>+// SPDX-License-Identifier: MIT
>+/* Copyright 2021 Advanced Micro Devices, Inc.
>+ *
>+ * Permission is hereby granted, free of charge, to any person
>+obtaining a
>+ * copy of this software and associated documentation files (the
>+"Software"),
>+ * to deal in the Software without restriction, including without
>+limitation
>+ * the rights to use, copy, modify, merge, publish, distribute,
>+sublicense,
>+ * and/or sell copies of the Software, and to permit persons to whom
>+the
>+ * Software is furnished to do so, subject to the following conditions:
>+ *
>+ * The above copyright notice and this permission notice shall be
>+included in
>+ * all copies or substantial portions of the Software.
>+ *
>+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>+EXPRESS OR
>+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>+MERCHANTABILITY,
>+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>EVENT
>+SHALL
>+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>+DAMAGES OR
>+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>+OTHERWISE,
>+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>USE
>+OR
>+ * OTHER DEALINGS IN THE SOFTWARE.
>+ *
>+ * Authors: David Nieto
>+ *          Roy Sun
>+ */
>+
>+#include <linux/debugfs.h>
>+#include <linux/list.h>
>+#include <linux/module.h>
>+#include <linux/uaccess.h>
>+#include <linux/reboot.h>
>+#include <linux/syscalls.h>
>+
>+#include <drm/amdgpu_drm.h>
>+#include <drm/drm_debugfs.h>
>+
>+#include "amdgpu.h"
>+#include "amdgpu_vm.h"
>+#include "amdgpu_gem.h"
>+#include "amdgpu_ctx.h"
>+#include "amdgpu_fdinfo.h"
>+
>+
>+static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] =3D {
>+	[AMDGPU_HW_IP_GFX]	=3D	"gfx",
>+	[AMDGPU_HW_IP_COMPUTE]	=3D	"compute",
>+	[AMDGPU_HW_IP_DMA]	=3D	"dma",
>+	[AMDGPU_HW_IP_UVD]	=3D	"dec",
>+	[AMDGPU_HW_IP_VCE]	=3D	"enc",
>+	[AMDGPU_HW_IP_UVD_ENC]	=3D	"enc_1",
>+	[AMDGPU_HW_IP_VCN_DEC]	=3D	"dec",
>+	[AMDGPU_HW_IP_VCN_ENC]	=3D	"enc",
>+	[AMDGPU_HW_IP_VCN_JPEG]	=3D	"jpeg",
>+};
>+
>+void amdgpu_show_fdinfo(struct seq_file *m, struct file *f) {
>+	struct amdgpu_fpriv *fpriv;
>+	uint32_t bus, dev, fn, i;
>+	uint64_t vram_mem =3D 0, gtt_mem =3D 0;
>+	struct drm_file *file =3D f->private_data;
>+	struct amdgpu_device *adev =3D drm_to_adev(file->minor->dev);
>+
>+	if (amdgpu_file_to_fpriv(f, &fpriv))
>+		return;
>+	bus =3D adev->pdev->bus->number;
>+	dev =3D PCI_SLOT(adev->pdev->devfn);
>+	fn =3D PCI_FUNC(adev->pdev->devfn);
>+
>+	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem);
>+	seq_printf(m, "pdev:\t%02x:%02x.%d\npasid:\t%u\n", bus, dev, fn,
>+			fpriv->vm.pasid);
>+	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
>+	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
>+
>+	for (i =3D 0; i < AMDGPU_HW_IP_NUM; i++) {
>+		uint32_t count =3D amdgpu_ctx_num_entities[i];
>+		int idx =3D 0;
>+		uint64_t total =3D 0, min =3D 0;
>+		uint32_t perc, frac;
>+
>+		for (idx =3D 0; idx < count; idx++) {
>+			total =3D amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
>+				i, idx, &min);
>+			if ((total =3D=3D 0) || (min =3D=3D 0))
>+				continue;
>+
>+			perc =3D div64_u64(10000 * total, min);
>+			frac =3D perc % 100;
>+
>+			seq_printf(m, "%s%d:\t%d.%d%%\n",
>+					amdgpu_ip_name[i],
>+					idx, perc/100, frac);
>+		}
>+	}
>+}
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
>new file mode 100644
>index 000000000000..41a4c7056729
>--- /dev/null
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.h
>@@ -0,0 +1,43 @@
>+/* SPDX-License-Identifier: MIT
>+ * Copyright 2021 Advanced Micro Devices, Inc.
>+ *
>+ * Permission is hereby granted, free of charge, to any person
>+obtaining a
>+ * copy of this software and associated documentation files (the
>+"Software"),
>+ * to deal in the Software without restriction, including without
>+limitation
>+ * the rights to use, copy, modify, merge, publish, distribute,
>+sublicense,
>+ * and/or sell copies of the Software, and to permit persons to whom
>+the
>+ * Software is furnished to do so, subject to the following conditions:
>+ *
>+ * The above copyright notice and this permission notice shall be
>+included in
>+ * all copies or substantial portions of the Software.
>+ *
>+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>+EXPRESS OR
>+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>+MERCHANTABILITY,
>+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
>EVENT
>+SHALL
>+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>+DAMAGES OR
>+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>+OTHERWISE,
>+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
>USE
>+OR
>+ * OTHER DEALINGS IN THE SOFTWARE.
>+ *
>+ * Authors: David Nieto
>+ *          Roy Sun
>+ */
>+#ifndef __AMDGPU_SMI_H__
>+#define __AMDGPU_SMI_H__
>+
>+#include <linux/idr.h>
>+#include <linux/kfifo.h>
>+#include <linux/rbtree.h>
>+#include <drm/gpu_scheduler.h>
>+#include <drm/drm_file.h>
>+#include <drm/ttm/ttm_bo_driver.h>
>+#include <linux/sched/mm.h>
>+
>+#include "amdgpu_sync.h"
>+#include "amdgpu_ring.h"
>+#include "amdgpu_ids.h"
>+
>+uint32_t amdgpu_get_ip_count(struct amdgpu_device *adev, int id); void
>+amdgpu_show_fdinfo(struct seq_file *m, struct file *f);
>+
>+#endif
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index 39ee88d29cca..b2e774aeab45 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -41,6 +41,7 @@
> #include "amdgpu_gem.h"
> #include "amdgpu_display.h"
> #include "amdgpu_ras.h"
>+#include "amdgpu_fdinfo.h"
>
> void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)  { diff -=
-git
>a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>index f95bcda8463f..773acb4437f7 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>@@ -25,6 +25,7 @@
>  *          Alex Deucher
>  *          Jerome Glisse
>  */
>+
> #include <linux/dma-fence-array.h>
> #include <linux/interval_tree_generic.h>  #include <linux/idr.h> @@ -322,=
6
>+323,7 @@ static void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base
>*base,
> 	base->vm =3D vm;
> 	base->bo =3D bo;
> 	base->next =3D NULL;
>+	INIT_LIST_HEAD(&base->bo_head);
> 	INIT_LIST_HEAD(&base->vm_status);
>
> 	if (!bo)
>@@ -329,6 +331,7 @@ static void amdgpu_vm_bo_base_init(struct
>amdgpu_vm_bo_base *base,
> 	base->next =3D bo->vm_bo;
> 	bo->vm_bo =3D base;
>
>+	list_add(&base->bo_head, &vm->bo_list);
> 	if (bo->tbo.base.resv !=3D vm->root.base.bo->tbo.base.resv)
> 		return;
>
>@@ -2541,6 +2544,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device
>*adev,
>
> 	spin_lock(&vm->invalidated_lock);
> 	list_del(&bo_va->base.vm_status);
>+	list_del(&bo_va->base.bo_head);
> 	spin_unlock(&vm->invalidated_lock);
>
> 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) { @@ -
>2800,6 +2804,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct
>amdgpu_vm *vm,
> 	spin_lock_init(&vm->invalidated_lock);
> 	INIT_LIST_HEAD(&vm->freed);
> 	INIT_LIST_HEAD(&vm->done);
>+	INIT_LIST_HEAD(&vm->bo_list);
>
> 	/* create scheduler entities for page table updates */
> 	r =3D drm_sched_entity_init(&vm->immediate,
>DRM_SCHED_PRIORITY_NORMAL, @@ -3267,6 +3272,25 @@ void
>amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> 	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);  }
>
>+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>+				uint64_t *gtt_mem)
>+{
>+	struct amdgpu_vm_bo_base *base =3D &vm->root.base;
>+
>+	list_for_each_entry(base, &vm->bo_list, bo_head){
>+		struct amdgpu_bo *bo =3D amdgpu_bo_ref(base->bo);
>+		if (!bo)
>+			continue;
>+		if (amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type)
>=3D=3D
>+				AMDGPU_GEM_DOMAIN_VRAM)
>+				*vram_mem +=3D amdgpu_bo_size(bo);
>+		if (amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type)
>=3D=3D
>+				AMDGPU_GEM_DOMAIN_GTT)
>+				*gtt_mem +=3D amdgpu_bo_size(bo);
>+		amdgpu_bo_unref(&bo);
>+	}
>+
>+}
> /**
>  * amdgpu_vm_set_task_info - Sets VMs task info.
>  *
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>index 848e175e99ff..72727117c479 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>@@ -150,6 +150,7 @@ struct amdgpu_vm_bo_base {
> 	/* protected by spinlock */
> 	struct list_head		vm_status;
>
>+	struct list_head		bo_head;
> 	/* protected by the BO being reserved */
> 	bool				moved;
> };
>@@ -274,6 +275,7 @@ struct amdgpu_vm {
> 	struct list_head	invalidated;
> 	spinlock_t		invalidated_lock;
>
>+	struct list_head	bo_list;
> 	/* BO mappings freed, but not yet updated in the PT */
> 	struct list_head	freed;
>
>@@ -458,6 +460,8 @@ void amdgpu_vm_move_to_lru_tail(struct
>amdgpu_device *adev,
> 				struct amdgpu_vm *vm);
> void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
>
>+void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
>+				uint64_t *gtt_mem);
> #if defined(CONFIG_DEBUG_FS)
> void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>#endif
>--
>2.31.1
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.=
fre
>edesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=3D04%7C01%7CEmily.Deng%40amd.com%7Cabab61f43c93486c53e
>308d903d9d7fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63754
>5056441135860%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
>joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DXopEZtTM
>LCpj%2BUD69HmXdNBKHAwCdrvIAJWpt5Xox3g%3D&amp;reserved=3D0

--_000_BY5PR12MB41152B09FB91C66FCFB4677C8F489BY5PR12MB4115namp_
Content-Disposition: attachment; filename="winmail.dat"
Content-Transfer-Encoding: base64
Content-Type: application/ms-tnef; name="winmail.dat"

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
AHBqmuCHMABENjlIbVhkTihCS0iroENPoHZJIkGq4HB0NbCAeDM/nQCvQJ+DXtagEDaVfX0DNuC1
oB8AQgABAAAAGAAAAEQAZQBuAGcALAAgAEUAbQBpAGwAeQAAAB8AZQABAAAAJgAAAEUAbQBpAGwA
eQAuAEQAZQBuAGcAQABhAG0AZAAuAGMAbwBtAAAAAAAfAGQAAQAAAAoAAABTAE0AVABQAAAAAAAC
AUEAAQAAAGAAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAIBEAGUAbgBnACwAIABFAG0AaQBsAHkA
AABTAE0AVABQAAAARQBtAGkAbAB5AC4ARABlAG4AZwBAAGEAbQBkAC4AYwBvAG0AAAAfAAJdAQAA
ACYAAABFAG0AaQBsAHkALgBEAGUAbgBnAEAAYQBtAGQALgBjAG8AbQAAAAAAHwDlXwEAAAAuAAAA
cwBpAHAAOgBlAG0AaQBsAHkALgBkAGUAbgBnAEAAYQBtAGQALgBjAG8AbQAAAAAAHwAaDAEAAAAY
AAAARABlAG4AZwAsACAARQBtAGkAbAB5AAAAHwAfDAEAAAAmAAAARQBtAGkAbAB5AC4ARABlAG4A
ZwBAAGEAbQBkAC4AYwBvAG0AAAAAAB8AHgwBAAAACgAAAFMATQBUAFAAAAAAAAIBGQwBAAAAYAAA
AAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAgEQAZQBuAGcALAAgAEUAbQBpAGwAeQAAAFMATQBUAFAA
AABFAG0AaQBsAHkALgBEAGUAbgBnAEAAYQBtAGQALgBjAG8AbQAAAB8AAV0BAAAAJgAAAEUAbQBp
AGwAeQAuAEQAZQBuAGcAQABhAG0AZAAuAGMAbwBtAAAAAAALAEA6AQAAAB8AGgABAAAAEgAAAEkA
UABNAC4ATgBvAHQAZQAAAAAAAwDxPwkEAAALAEA6AQAAAAMA/T/kBAAAAgELMAEAAAAQAAAA7zEz
EVmtokKpqYhpp8sCdQMAFwABAAAAQAA5AABnvCPINdcBQAAIMPBPByTINdcBHwA3AAEAAABwAAAA
UgBFADoAIABbAFAAQQBUAEMASAAgADIALwAyAF0AIABkAHIAbQAvAGEAbQBkAGcAcAB1ADoAIABB
AGQAZAAgAHMAaABvAHcAXwBmAGQAaQBuAGYAbwAoACkAIABpAG4AdABlAHIAZgBhAGMAZQAAAB8A
PQABAAAACgAAAFIARQA6ACAAAAAAAAMA3j+vbwAACwACAAEAAAALACMAAAAAAAMAJgAAAAAACwAp
AAAAAAALACsAAAAAAAMALgAAAAAAAwA2AAAAAAAfAHAAAQAAAGgAAABbAFAAQQBUAEMASAAgADIA
LwAyAF0AIABkAHIAbQAvAGEAbQBkAGcAcAB1ADoAIABBAGQAZAAgAHMAaABvAHcAXwBmAGQAaQBu
AGYAbwAoACkAIABpAG4AdABlAHIAZgBhAGMAZQAAAAIBcQABAAAAIAAAAAEB1zTk9tYb0l9DmKBK
k/IqQ3ER3ACqvRubgIAACmIwCwAGDAAAAAAfADUQAQAAAKIAAAA8AEIAWQA1AFAAUgAxADIATQBC
ADQAMQAxADUAMgBCADAAOQBGAEIAOQAxAEMANgA2AEYAQwBGAEIANAA2ADcANwBDADgARgA0ADgA
OQBAAEIAWQA1AFAAUgAxADIATQBCADQAMQAxADUALgBuAGEAbQBwAHIAZAAxADIALgBwAHIAbwBk
AC4AbwB1AHQAbABvAG8AawAuAGMAbwBtAD4AAAAAAB8AORABAAAARgEAADwAMgAwADIAMQAwADQA
MQA5ADAANgAyADYAMgA0AC4AMgA3ADYAOAA4AC0AMQAtAFIAbwB5AC4AUwB1AG4AQABhAG0AZAAu
AGMAbwBtAD4AIAA8ADIAMAAyADEAMAA0ADEAOQAwADYAMgA2ADIANAAuADIANwA2ADgAOAAtADIA
LQBSAG8AeQAuAFMAdQBuAEAAYQBtAGQALgBjAG8AbQA+ACAAPABDAFkANABQAFIAMQAyAE0AQgAx
ADYAMAA2ADgANABBADIAQQBEADMAQwA3AEYANgBBADIARQBBAEUANgA2ADQAQwBGAEYANAA4ADkA
QABDAFkANABQAFIAMQAyAE0AQgAxADYAMAA2AC4AbgBhAG0AcAByAGQAMQAyAC4AcAByAG8AZAAu
AG8AdQB0AGwAbwBvAGsALgBjAG8AbQA+AAAAAAAfAEIQAQAAAKIAAAA8AEMAWQA0AFAAUgAxADIA
TQBCADEANgAwADYAOAA0AEEAMgBBAEQAMwBDADcARgA2AEEAMgBFAEEARQA2ADYANABDAEYARgA0
ADgAOQBAAEMAWQA0AFAAUgAxADIATQBCADEANgAwADYALgBuAGEAbQBwAHIAZAAxADIALgBwAHIA
bwBkAC4AbwB1AHQAbABvAG8AawAuAGMAbwBtAD4AAAAAAAMAgBD/////AwATEgAAAABAAAcwOkrG
I8g11wECARAwAQAAAEYAAAAAAAAA0Un5ECDdm0q8aDLoS6dGrwcAs9nUjibPQEmw88+9wzfmBQAA
AOn/WAAAAY6WcVvQ/UaUCbc3NxwX0QAChERdqgAAAAACARMwAQAAABAAAADWG9JfQ5igSpPyKkNx
EdwAAgEUMAEAAAAMAAAAsQQAAFnPCWJIAAAAAwBaNgAAAAADAGg2DQAAAAsA+jYBAAAAHwDZPwEA
AAAAAgAASABpACAAQwBoAHIAaQBzAHQAaQBhAG4ALAANAAoAIAAgACAAIAAgAEMAbwB1AGwAZAAg
AHkAbwB1ACAAaABlAGwAcAAgAHQAbwAgAHIAZQB2AGkAZQB3ACAAdABoAGUAcwBlACAAcABhAHQA
YwBoAGUAcwAgAGEAZwBhAGkAbgAsACAAdABoAGEAbgBrAHMALgANAAoADQAKAEIAZQBzAHQAIAB3
AGkAcwBoAGUAcwANAAoARQBtAGkAbAB5ACAARABlAG4AZwANAAoAPgAtAC0ALQAtAC0ATwByAGkA
ZwBpAG4AYQBsACAATQBlAHMAcwBhAGcAZQAtAC0ALQAtAC0ADQAKAD4ARgByAG8AbQA6ACAAYQBt
AGQALQBnAGYAeAAgADwAYQBtAGQALQBnAGYAeAAtAGIAbwB1AG4AYwBlAHMAQABsAGkAcwB0AHMA
LgBmAHIAZQBlAGQAZQBzAGsAdABvAHAALgBvAHIAZwA+ACAATwBuACAAQgBlAGgAYQBsAGYAIABP
AGYAIABTAHUAbgAsACAAUgBvAHkADQAKAD4AUwBlAG4AdAA6ACAAVAB1AGUAcwBkAGEAeQAsACAA
QQBwAHIAaQBsACAAMgAwACwAIAAyADAAMgAxACAANAA6ADUANAAgAFAATQANAAoAPgBUAG8AOgAg
AFMAAAAfAPg/AQAAABgAAABEAGUAbgBnACwAIABFAG0AaQBsAHkAAAAfAPo/AQAAABgAAABEAGUA
bgBnACwAIABFAG0AaQBsAHkAAAAfACJAAQAAAAYAAABFAFgAAAAAAB8AI0ABAAAAAgEAAC8ATwA9
AEUAWABDAEgAQQBOAEcARQBMAEEAQgBTAC8ATwBVAD0ARQBYAEMASABBAE4ARwBFACAAQQBEAE0A
SQBOAEkAUwBUAFIAQQBUAEkAVgBFACAARwBSAE8AVQBQACAAKABGAFkARABJAEIATwBIAEYAMgAz
AFMAUABEAEwAVAApAC8AQwBOAD0AUgBFAEMASQBQAEkARQBOAFQAUwAvAEMATgA9AEIAMABEAEMA
NwBFADUAMwA4ADAARQBDADQANQAwAEEAOAA5AEUARgA5AEQARAAxADcAQgA4ADYARQAwADYAQQAt
AEQARQBOAEcALAAgAEUATQBJAEwAWQAAAAAAHwAkQAEAAAAGAAAARQBYAAAAAAAfACVAAQAAAAIB
AAAvAE8APQBFAFgAQwBIAEEATgBHAEUATABBAEIAUwAvAE8AVQA9AEUAWABDAEgAQQBOAEcARQAg
AEEARABNAEkATgBJAFMAVABSAEEAVABJAFYARQAgAEcAUgBPAFUAUAAgACgARgBZAEQASQBCAE8A
SABGADIAMwBTAFAARABMAFQAKQAvAEMATgA9AFIARQBDAEkAUABJAEUATgBUAFMALwBDAE4APQBC
ADAARABDADcARQA1ADMAOAAwAEUAQwA0ADUAMABBADgAOQBFAEYAOQBEAEQAMQA3AEIAOAA2AEUA
MAA2AEEALQBEAEUATgBHACwAIABFAE0ASQBMAFkAAAAAAB8AMEABAAAAGAAAAEQAZQBuAGcALAAg
AEUAbQBpAGwAeQAAAB8AMUABAAAAGAAAAEQAZQBuAGcALAAgAEUAbQBpAGwAeQAAAB8AOEABAAAA
GAAAAEQAZQBuAGcALAAgAEUAbQBpAGwAeQAAAB8AOUABAAAAGAAAAEQAZQBuAGcALAAgAEUAbQBp
AGwAeQAAAAMAWUAAAAAAAwBaQAAAAAADADdQAQAAAAMACVkBAAAAHwAKXQEAAAAmAAAARQBtAGkA
bAB5AC4ARABlAG4AZwBAAGEAbQBkAC4AYwBvAG0AAAAAAB8AC10BAAAAJgAAAEUAbQBpAGwAeQAu
AEQAZQBuAGcAQABhAG0AZAAuAGMAbwBtAAAAAAACARVdAQAAABAAAAAfltg9iORgTo4RqC2ZThg9
AgEWXQEAAAAQAAAAH5bYPYjkYE6OEagtmU4YPQsAAIAIIAYAAAAAAMAAAAAAAABGAAAAABSFAAAA
AAAAAwAAgAggBgAAAAAAwAAAAAAAAEYAAAAAEIUAAAAAAAALAACACCAGAAAAAADAAAAAAAAARgAA
AAADhQAAAAAAAAMAAIAIIAYAAAAAAMAAAAAAAABGAAAAAAGFAAAAAAAACwAAgAggBgAAAAAAwAAA
AAAAAEYAAAAABoUAAAAAAAADAACACCAGAAAAAADAAAAAAAAARgEAAAAyAAAARQB4AGMAaABhAG4A
ZwBlAEEAcABwAGwAaQBjAGEAdABpAG8AbgBGAGwAYQBnAHMAAAAAACAAAAAfAACAE4/yQfSDFEGl
hO7bWmsL/wEAAAAWAAAAQwBsAGkAZQBuAHQASQBuAGYAbwAAAAAAAQAAACoAAABDAGwAaQBlAG4A
dAA9AE0AUwBFAHgAYwBoAGEAbgBnAGUAUgBQAEMAAAAAAB8AAIAfpOszqHouQr57eeGpjlSzAQAA
ADgAAABDAG8AbgB2AGUAcgBzAGEAdABpAG8AbgBJAG4AZABlAHgAVAByAGEAYwBrAGkAbgBnAEUA
eAAAAAEAAABKAgAASQBJAD0AWwBDAEkARAA9ADUAZgBkADIAMQBiAGQANgAtADkAOAA0ADMALQA0
AGEAYQAwAC0AOQAzAGYAMgAtADIAYQA0ADMANwAxADEAMQBkAGMAMAAwADsASQBEAFgASABFAEEA
RAA9ADAAMQBEADcAMwA0AEUANABGADYAOwBJAEQAWABDAE8AVQBOAFQAPQAzAF0AOwBTAEIATQBJ
AEQAPQAyADsAUwAxAD0APABDAFkANABQAFIAMQAyAE0AQgAxADYAMAA2ADgANABBADIAQQBEADMA
QwA3AEYANgBBADIARQBBAEUANgA2ADQAQwBGAEYANAA4ADkAQABDAFkANABQAFIAMQAyAE0AQgAx
ADYAMAA2AC4AbgBhAG0AcAByAGQAMQAyAC4AcAByAG8AZAAuAG8AdQB0AGwAbwBvAGsALgBjAG8A
bQA+ADsAUgBUAFAAPQBEAGkAcgBlAGMAdABDAGgAaQBsAGQAOwBUAEQATgA9AE0AaQBzAG0AYQB0
AGMAaAA7AFQAUAA9AFIAZQBtAG8AdgBlAGQAOwBUAEYAUgA9AFAAYQByAHQAaQBjAGkAcABhAG4A
dABDAGgAYQBuAGcAZQBkADsAVgBlAHIAcwBpAG8AbgA9AFYAZQByAHMAaQBvAG4AIAAxADUALgAy
ADAAIAAoAEIAdQBpAGwAZAAgADQAMAA0ADIALgAwACkALAAgAFMAdABhAGcAZQA9AEgAMQAsACAA
VABDADsAVQBQAD0ANQAwADsARABQAD0ANQAAAAAACwAAgAggBgAAAAAAwAAAAAAAAEYAAAAADoUA
AAAAAAADAACACCAGAAAAAADAAAAAAAAARgAAAAAYhQAAAAAAAAsAAIAIIAYAAAAAAMAAAAAAAABG
AAAAAIKFAAAAAAAAHwAAgAggBgAAAAAAwAAAAAAAAEYAAAAA2IUAAAEAAAASAAAASQBQAE0ALgBO
AG8AdABlAAAAAAACAQCAE4/yQfSDFEGlhO7bWmsL/wEAAAAuAAAASABlAGEAZABlAHIAQgBvAGQA
eQBGAHIAYQBnAG0AZQBuAHQATABpAHMAdAAAAAAAAQAAAEoAAAABAAoAAAAEAAAAAgAAABQAAAAA
AAAAAAAAAGYAAAAAAAAAFAAAAAAAAACnAQAAJwIAAAAAAAAUAAAAAAAAADcDAAD/////AAAAAAAA
CwAAgBOP8kH0gxRBpYTu21prC/8BAAAAKAAAAEkAcwBRAHUAbwB0AGUAZABUAGUAeAB0AEMAaABh
AG4AZwBlAGQAAAABAAAAAgEAgBOP8kH0gxRBpYTu21prC/8BAAAAQAAAAEMAbwBuAHYAZQByAHMA
YQB0AGkAbwBuAFQAcgBlAGUAUABhAHIAZQBuAHQAUgBlAGMAbwByAGQASwBlAHkAAAABAAAALgAA
AAAAAADRSfkQIN2bSrxoMuhLp0avAQABjpZxW9D9RpQJtzc3HBfRAAUMIKRmAAAAAAsAAIBQ42ML
zJzQEbzbAIBfzM4EAQAAACYAAABJAHMAUABlAHIAbQBhAG4AZQBuAHQARgBhAGkAbAB1AHIAZQAA
AAAAAAAAAAsAAIATj/JB9IMUQaWE7ttaawv/AQAAABwAAABIAGEAcwBRAHUAbwB0AGUAZABUAGUA
eAB0AAAAAQAAAAMAAIBQ42MLzJzQEbzbAIBfzM4EAQAAACQAAABJAG4AZABlAHgAaQBuAGcARQBy
AHIAbwByAEMAbwBkAGUAAAAbAAAAHwAAgFDjYwvMnNARvNsAgF/MzgQBAAAAKgAAAEkAbgBkAGUA
eABpAG4AZwBFAHIAcgBvAHIATQBlAHMAcwBhAGcAZQAAAAAAAQAAAHAAAABJAG4AZABlAHgAaQBu
AGcAIABQAGUAbgBkAGkAbgBnACAAdwBoAGkAbABlACAAQgBpAGcARgB1AG4AbgBlAGwAUABPAEkA
SQBzAFUAcABUAG8ARABhAHQAZQAgAGkAcwAgAGYAYQBsAHMAZQAuAAAAAgEAgAggBgAAAAAAwAAA
AAAAAEYBAAAANgAAAEkAbgBUAHIAYQBuAHMAaQB0AE0AZQBzAHMAYQBnAGUAQwBvAHIAcgBlAGwA
YQB0AG8AcgAAAAAAAQAAABAAAADJL4YIJ0dOSLrnHmeDTSN7HwAAgIYDAgAAAAAAwAAAAAAAAEYB
AAAAGAAAAG0AcwBpAHAAXwBsAGEAYgBlAGwAcwAAAAEAAAA+BAAATQBTAEkAUABfAEwAYQBiAGUA
bABfADcANgA1ADQANgBkAGEAYQAtADQAMQBiADYALQA0ADcAMABjAC0AYgBiADgANQAtAGYANgBm
ADQAMABmADAANAA0AGQANwBmAF8ARQBuAGEAYgBsAGUAZAA9AHQAcgB1AGUAOwAgAE0AUwBJAFAA
XwBMAGEAYgBlAGwAXwA3ADYANQA0ADYAZABhAGEALQA0ADEAYgA2AC0ANAA3ADAAYwAtAGIAYgA4
ADUALQBmADYAZgA0ADAAZgAwADQANABkADcAZgBfAFMAZQB0AEQAYQB0AGUAPQAyADAAMgAxAC0A
MAA0AC0AMgAwAFQAMAA4ADoANQAzADoAMQAzAFoAOwAgACAATQBTAEkAUABfAEwAYQBiAGUAbABf
ADcANgA1ADQANgBkAGEAYQAtADQAMQBiADYALQA0ADcAMABjAC0AYgBiADgANQAtAGYANgBmADQA
MABmADAANAA0AGQANwBmAF8ATQBlAHQAaABvAGQAPQBTAHQAYQBuAGQAYQByAGQAOwAgAE0AUwBJ
AFAAXwBMAGEAYgBlAGwAXwA3ADYANQA0ADYAZABhAGEALQA0ADEAYgA2AC0ANAA3ADAAYwAtAGIA
YgA4ADUALQBmADYAZgA0ADAAZgAwADQANABkADcAZgBfAE4AYQBtAGUAPQBJAG4AdABlAHIAbgBh
AGwAIABVAHMAZQAgAE8AbgBsAHkAIAAtACAAVQBuAHIAZQBzAHQAcgBpAGMAdABlAGQAOwAgAE0A
UwBJAFAAXwBMAGEAYgBlAGwAXwA3ADYANQA0ADYAZABhAGEALQA0ADEAYgA2AC0ANAA3ADAAYwAt
AGIAYgA4ADUALQBmADYAZgA0ADAAZgAwADQANABkADcAZgBfAFMAaQB0AGUASQBkAD0AMwBkAGQA
OAA5ADYAMQBmAC0AZQA0ADgAOAAtADQAZQA2ADAALQA4AGUAMQAxAC0AYQA4ADIAZAA5ADkANABl
ADEAOAAzAGQAOwAgAE0AUwBJAFAAXwBMAGEAYgBlAGwAXwA3ADYANQA0ADYAZABhAGEALQA0ADEA
YgA2AC0ANAA3ADAAYwAtAGIAYgA4ADUALQBmADYAZgA0ADAAZgAwADQANABkADcAZgBfAEEAYwB0
AGkAbwBuAEkAZAA9ADgAZAAzADEAZABmAGYAMgAtADgANgBlAGYALQA0ADkAYgA3AC0AYgBjAGMA
OQAtADQAOAA1AGEAZAA2AGQANwBlAGUAYQBiADsAIABNAFMASQBQAF8ATABhAGIAZQBsAF8ANwA2
ADUANAA2AGQAYQBhAC0ANAAxAGIANgAtADQANwAwAGMALQBiAGIAOAA1AC0AZgA2AGYANAAwAGYA
MAA0ADQAZAA3AGYAXwBDAG8AbgB0AGUAbgB0AEIAaQB0AHMAPQAxAAAAAABIAACAa8U/QDDNxUeG
+O3p41oCKwEAAAAcAAAATQBTAEkAUABMAGEAYgBlAGwARwB1AGkAZAAAAKptVHa2QQxHu4X29A8E
TX8DAA00/T8AAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAC4AAABhAHUAdABoAGUAbgB0AGkAYwBh
AHQAaQBvAG4ALQByAGUAcwB1AGwAdABzAAAAAAABAAAA1gAAAGEAbQBkAC4AYwBvAG0AOwAgAGQA
awBpAG0APQBuAG8AbgBlACAAKABtAGUAcwBzAGEAZwBlACAAbgBvAHQAIABzAGkAZwBuAGUAZAAp
ACAAaABlAGEAZABlAHIALgBkAD0AbgBvAG4AZQA7AGEAbQBkAC4AYwBvAG0AOwAgAGQAbQBhAHIA
YwA9AG4AbwBuAGUAIABhAGMAdABpAG8AbgA9AG4AbwBuAGUAIABoAGUAYQBkAGUAcgAuAGYAcgBv
AG0APQBhAG0AZAAuAGMAbwBtADsAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAAB4AAABhAGMA
YwBlAHAAdABsAGEAbgBnAHUAYQBnAGUAAAAAAAEAAAAMAAAAZQBuAC0AVQBTAAAAHwAAgIYDAgAA
AAAAwAAAAAAAAEYBAAAAIAAAAHgALQBtAHMALQBoAGEAcwAtAGEAdAB0AGEAYwBoAAAAAQAAAAIA
AAAAAAAAHwAAgGvFP0AwzcVHhvjt6eNaAisBAAAAEgAAAE0ASQBQAEwAYQBiAGUAbAAAAAAAAQAA
AP4BAABbAHsAIgBpAGQAIgA6ACIANwA2ADUANAA2AGQAYQBhAC0ANAAxAGIANgAtADQANwAwAGMA
LQBiAGIAOAA1AC0AZgA2AGYANAAwAGYAMAA0ADQAZAA3AGYAIgAsACIAdABpACIAOgAiADMAZABk
ADgAOQA2ADEAZgAtAGUANAA4ADgALQA0AGUANgAwAC0AOABlADEAMQAtAGEAOAAyAGQAOQA5ADQA
ZQAxADgAMwBkACIALAAiAHAAaQAiADoAIgAwADAAMAAwADAAMAAwADAALQAwADAAMAAwAC0AMAAw
ADAAMAAtADAAMAAwADAALQAwADAAMAAwADAAMAAwADAAMAAwADAAMAAiACwAIgBuAG0AIgA6ACIA
SQBuAHQAZQByAG4AYQBsACAAVQBzAGUAIABPAG4AbAB5ACAALQAgAFUAbgByAGUAcwB0AHIAaQBj
AHQAZQBkACIALAAiAGEAYwAiADoAMQAsACIAbwBwACIAOgAxACwAIgBjAHQAIgA6ACIAMgAwADIA
MQAtADAANAAtADIAMABUADAAOAA6ADUAMwA6ADEAMwBaACIALAAiAG0AdAAiADoAIgAwADAAMAAx
AC0AMAAxAC0AMAAxAFQAMAAwADoAMAAwADoAMAAwACIALAAiAHUAYwAiADoAbgB1AGwAbAB9AF0A
AAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAAACIAAAB4AC0AbwByAGkAZwBpAG4AYQB0AGkAbgBn
AC0AaQBwAAAAAAABAAAAJAAAAFsAMQA4ADAALgAxADYANwAuADEAOQA5AC4AMQA4ADkAXQAAAEgA
AIAIIAYAAAAAAMAAAAAAAABGAQAAACIAAABOAGUAdAB3AG8AcgBrAE0AZQBzAHMAYQBnAGUASQBk
AAAAAACI/aDaa25tQ/Y5CNkD30aZHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAALgAAAHgALQBtAHMA
LQBwAHUAYgBsAGkAYwB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAAAAAAAEAAAAMAAAARQBtAGEAaQBs
AAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAAUAAAAHgALQBtAHMALQBvAGYAZgBpAGMAZQAzADYA
NQAtAGYAaQBsAHQAZQByAGkAbgBnAC0AYwBvAHIAcgBlAGwAYQB0AGkAbwBuAC0AaQBkAAAAAQAA
AEoAAABkAGEAYQAwAGYAZAA4ADgALQA2AGUANgBiAC0ANAAzADYAZAAtAGYANgAzADkALQAwADgA
ZAA5ADAAMwBkAGYANAA2ADkAOQAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAANgAAAHgALQBt
AHMALQB0AHIAYQBmAGYAaQBjAHQAeQBwAGUAZABpAGEAZwBuAG8AcwB0AGkAYwAAAAAAAQAAAB4A
AABCAFkANQBQAFIAMQAyAE0AQgA0ADAAMAAxADoAAAAAAB8AAICGAwIAAAAAAMAAAAAAAABGAQAA
AD4AAAB4AC0AbQBzAC0AZQB4AGMAaABhAG4AZwBlAC0AdAByAGEAbgBzAHAAbwByAHQALQBmAG8A
cgBrAGUAZAAAAAAAAQAAAAoAAABUAHIAdQBlAAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA0
AAAAeAAtAG0AaQBjAHIAbwBzAG8AZgB0AC0AYQBuAHQAaQBzAHAAYQBtAC0AcAByAHYAcwAAAAEA
AACiAAAAPABCAFkANQBQAFIAMQAyAE0AQgA0ADAAMAAxADIAMgBCAEUAMgA3ADEANwAwAEIANQBE
ADEANgBEAEIAMQBEAEEAOAA4AEYANAA4ADkAQABCAFkANQBQAFIAMQAyAE0AQgA0ADAAMAAxAC4A
bgBhAG0AcAByAGQAMQAyAC4AcAByAG8AZAAuAG8AdQB0AGwAbwBvAGsALgBjAG8AbQA+AAAAAAAf
AACAhgMCAAAAAADAAAAAAAAARgEAAAA4AAAAeAAtAG0AcwAtAG8AbwBiAC0AdABsAGMALQBvAG8A
YgBjAGwAYQBzAHMAaQBmAGkAZQByAHMAAAABAAAAEgAAAE8ATABNADoAOAAwADAAOwAAAAAAHwAA
gIYDAgAAAAAAwAAAAAAAAEYBAAAAOAAAAHgALQBtAHMALQBlAHgAYwBoAGEAbgBnAGUALQBzAGUA
bgBkAGUAcgBhAGQAYwBoAGUAYwBrAAAAAQAAAAQAAAAxAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYB
AAAAKgAAAHgALQBtAGkAYwByAG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEAbQAAAAAAAQAAAA4A
AABCAEMATAA6ADAAOwAAAAAAHwAAgIYDAgAAAAAAwAAAAAAAAEYBAAAARAAAAHgALQBtAGkAYwBy
AG8AcwBvAGYAdAAtAGEAbgB0AGkAcwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUALQBpAG4AZgBvAAAA
AQAAADIFAAAzAGgAawB6AFIASgBPAG4AQwBrADMAawBPADEAdwA3AFcARQBwAE4AdwBjAGEAbQBL
AFkAMwA3ADAAVwB6AGwASQAyAEoANQBWADEAOAByAHoANQBWAG8AUgBGAHMAagBNAEcAVABqAFYA
SABuADAALwBLAGsATQByAHAAdQBuAEEAdQBYAGYATgBtAGMAZQBUAHMAMABIAHgATABGAG8AdAB0
AGsAdQBvAGcAegA4AEQAMgBPAC8ARABSAEwAKwBnAEkAcQBLAGYAZgB1ADAAagBuAHQAbwBMAEQA
QQB0ACsALwBnAHgARwBDAHgAOQBDAEIAdwBaAFYAdQBWAFgAbwA5ADkAYgA2AGIATAArAFIAQQBX
AG8AZQB0AGEAWgBzAGQAUQA3AEMATwBsAEMAZgB5AEcAMgBOAE8AQgAzAEcANABqAG4AYgBNADcA
RgBVAHIAeQBoAHQAVwBGAGQAVwArAEgATQBoADMAUwByAGkAYgBaAEIAeQBUADEARwBNAFkAcQB3
AG8ASwBNAFgAeABxAGkAVAA2AEEAaABvAFgAZgArAHQAUgB6ADAAbwBuAGwAcwBmAEgAbQBhADkA
eAA3AFIAawAyAGIAOQBrAHIASgBYAHQAOABwAGkATgBPAEMAbQBSAFoAQQBpAEoAVwBBAFEAZABW
AHEARQBsADMAYgBEAFQAOABGAGEATAAvAEIARQBFAEcATwBpAHIAagBsAGsAMQBrAE0AUwBKAGEA
WgA5AEgAbABVAHkAOQBlAE4AZgBxADIAYQBjAHYAUAA3AGMAWABPAGQAdQA5AEIAMgBGAEoAagBk
AEgARwBXAHoARQBqAEgAaQAzAC8AMgBhAEUAYwBsAG4AcgB6AGIAZgA3AEYAWABRAFgAbwB0AFMA
RAA2AHAAVABrADcARwArADkAOABUAHMAdgA1AE8AOABJAE8ANABxAHAAUQB1ADkAagBlAHMAWgA1
AGEANQB6AC8ARQBJAEEAVABXAGYAZwBGAGMAOQBmAHAAUwBPAHIAQgBFAGoARQBOADgAdwBsADkA
ZgBwAHgAdwA5AE4AWABBAGMAOABhAHEAMwBWAGMAagBKAEEARgBlAFoAQQBtAHkAdgBwAFcAWgA1
AE0AcABkAGgASABXAEkAZQBTAFcAeAA5ADQAbwBTAHEAWQBKAGUAaQBhAHYAZABLADEAOABNADMA
dgB0AHAAUQAxAEUAUgA5AC8AUgA2AFUAeQBwAE8ARABlAGkAYQBGAFUAOQBoAFoAawA1AGYALwB6
ACsAMQBqAHMASQAzADQAMQA2AHEAQwBzAG4ASQBkAFUAQgA5ADEAMgBUAG8AZwBjAGkAegBwAFoA
ZQBoAEEAcwBUAEEARAByAHIAMQB4AE0AdgBoAGEARABDADcAUQB4AE8AcABvAGMAdwBNAHAASQA1
AFIALwA2AE8AawBRAEIASQBNAE4AdABRAGQAcAB4AGwAMwA3AHYAcABHADYARgBWAGgAdQBTAEkA
VgA5AFEAQgB2AGgASgBLADgAWAA3AGsANABLAEkAbQA1AFYATQAvAGMAQwByAFYAMwBIAEUAMwAx
AEMAYwBsADAAQwBJADAAdABpAHoAKwBiAGkASABhADYANABOAHgAVABHAEoAaQA3AEsARQBBAHMA
cgBFAEEASwByAHMAUgAvACsATwBGACsAcQAvAFIAOQBVAHYARABmAGQAVQBMAE0AOQBWAEQAdwBt
ADYARQAwAGYAOAB1ADMAdgAyAHcAPQA9AAAAAAAfAACAhgMCAAAAAADAAAAAAAAARgEAAAA4AAAA
eAAtAGYAbwByAGUAZgByAG8AbgB0AC0AYQBuAHQAaQBzAHAAYQBtAC0AcgBlAHAAbwByAHQAAAAB
AAAA9AMAAEMASQBQADoAMgA1ADUALgAyADUANQAuADIANQA1AC4AMgA1ADUAOwBDAFQAUgBZADoA
OwBMAEEATgBHADoAZQBuADsAUwBDAEwAOgAxADsAUwBSAFYAOgA7AEkAUABWADoATgBMAEkAOwBT
AEYAVgA6AE4AUwBQAE0AOwBIADoAQgBZADUAUABSADEAMgBNAEIANAAxADEANQAuAG4AYQBtAHAA
cgBkADEAMgAuAHAAcgBvAGQALgBvAHUAdABsAG8AbwBrAC4AYwBvAG0AOwBQAFQAUgA6ADsAQwBB
AFQAOgBOAE8ATgBFADsAUwBGAFMAOgAoADQANgAzADYAMAAwADkAKQAoADMANAA2ADAAMAAyACkA
KAAzADYANgAwADAANAApACgAMwA3ADYAMAAwADIAKQAoADEAMwA2ADAAMAAzACkAKAAzADkANgAw
ADAAMwApACgAMwA5ADgANgAwADQAMAAwADAAMAAyACkAKAA0ADUAMAA4ADAANAAwADAAMAAwADIA
KQAoADcANgA5ADYAMAAwADUAKQAoADcANgAxADEANgAwADAANgApACgANwAxADIAMAAwADQAMAAw
ADAAMAAxACkAKAA1ADQAOQAwADYAMAAwADMAKQAoADkANgA4ADYAMAAwADMAKQAoADYANgA5ADQA
NgAwADAANwApACgANgA1ADAANgAwADAANwApACgANQAyADUAMwA2ADAAMQA0ACkAKAAzADMANgA1
ADYAMAAwADIAKQAoADMAMAA4ADYANAAwADAAMwApACgAOAA5ADMANgAwADAAMgApACgANAA3ADgA
NgAwADAAMAAwADEAKQAoADMAMQA2ADAAMAAyACkAKAA2ADYANAA0ADYAMAAwADgAKQAoADEAMgAy
ADAAMAAwADAAMAAxACkAKAAzADgAMQAwADAANwAwADAAMAAwADIAKQAoADUANgA2ADAAMwAwADAA
MAAwADIAKQAoADIANgAwADAANQApACgAOAA2ADcANgAwADAAMgApACgAOAAzADMAOAAwADQAMAAw
ADAAMAAxACkAKAAxADgANgAwADAAMwApACgANgA2ADQANwA2ADAAMAA3ACkAKAA1ADUAMAAxADYA
MAAwADIAKQAoADEAMQAwADEAMwA2ADAAMAA1ACkAKAA2ADYANQA1ADYAMAAwADgAKQAoADQAMwAy
ADYAMAAwADgAKQAoADYANAA3ADUANgAwADAAOAApACgAOAA2ADMANgAyADAAMAAxACkAKAAyADkA
MAA2ADAAMAAyACkAOwBEAEkAUgA6AE8AVQBUADsAUwBGAFAAOgAxADEAMAAxADsAAAAfAACAhgMC
AAAAAADAAAAAAAAARgEAAABGAAAAeAAtAG0AcwAtAGUAeABjAGgAYQBuAGcAZQAtAGEAbgB0AGkA
cwBwAGEAbQAtAG0AZQBzAHMAYQBnAGUAZABhAHQAYQAAAAAAAQAAAIIKAABSAG4AYgBuADMAUAA4
AFQARQBFAGYAcwBWAGEAbgBwAHEAawBZAGcANABwAHQAWQBiAFoAQgBkAE4AdQBVAC8ATgBDAFkA
cABRAHYARgBSAGEAQgB5AEoAWgAvAHcATgBvAGkAZABBAE4ARwByAFYAZABUAHgAWgBzAHUAOABp
AGMAZQBoACsAOABuAHgAYQArAGQAVAB2AGwAZQBhAGoASQBpAFMAVQA5AE4AegArAFcAVwBEAEYA
NgB4AFgAUgBlADMALwBZAHMAdgBqAGQAUQBvAG4AVQA3AE4ASwBYAGgAdQBlAGgAZQBWAFAAKwBU
AEEANQBPAEgAYgA3ADcAUABQAGMAcwBGAGYAZAAvAFIANABxADYAcQBVAHQAQQB3AHYAVwBHAEYA
LwBMAFMAbABSAFAAUABzAFAAQgB1ADMARgA3ADMAVgBYADAAOQBTAEkAVQBkAE4AZgBIADYAOQBD
AGcAdABrADEAYQBGAFgAUQBXAHEAbwBwAEoASwBVAFMAVgAwAE8ATgBLAFAANwB5AG4AUgBmAEUA
ZQBHAEcAawAzAFEAdQBaADEAdQBZAC8ARQBZAE8AegBKAEoATABrAHYATgBkAEQAQQBUAGkAQQA4
AGUAZgA2AEkAegBQAHoATABVAEcAbwAyAFAAMgBYAE0AYgA3AFYAYQBWAHAAYwA3AG8AWgBDAFAA
VgBMAHIASwBUAHIAVQBaADEAcQAzAFgARAA5AE4ARgBzAEMAYwBvAEUAYQBjAFMANQBkAFEAcQBD
AEcAVQB4ADgAZQBlADIALwBRAC8AagBrAEoASwAvADUAeQBMAGUAWABpAFIAawBHAHUAZQB3AFIA
egAyADEAYgBBAEIAcgBGADkAZQAyAHcAUgB0AGoASwBvAEEANwBJAG0AUQBnAC8AZQBTAGYARgA5
AHIASQAzAHcAZwA4AGcAeQA4AHAAOABNAFAAdwBXAHcAVwBaAEIAOQBxAHgAYQB4AE0AdgBtADQA
NQBrACsAVQBoAEMAMgBJAFUAdwBTAEcAbwBBAE4ARABCAFUAYQBEAGkAawBuAFEAYwBpAEUAdQBK
AEcAcwBOADAAegBFAHAASgBCAEQAYwAxAHQAZAB6ADkAQgBvAE4AeAB4AHMAYgBRADcARgBIAG0A
NQBGAHcAMwBjAFcAMQBzAHMAawA4AEgASgBmADcAMwArADcAZABwAEUAdwA4ADYAYgBrAFoAbgAw
AHkAMwA3ADgAWgArAFUAWgB3AHMAUgBYAFUAdQBGAHMAbQBCAFgAegBtACsAWABHADMATQBWAFIA
eAA0ADYALwBmAFoAYQAwAHoAbgBEAGkAOQBsAEoAWABCAFcATgB5AEoATgA5ADcAMgAvAE8AWgBU
ADcASQBQAHUASAB1ADYASQBoAEoAWgB6AFEAUQBXAFQAVgBqAEMARABaAEUAdAB3AEYAdQA1AC8A
SwBmAGgAZABhAHYAYwBBADkAOQB0ADkAVQB3AGoAcwBiAHIAWABBAGUAbQBOAGQATABXAGQASgBk
AG0AcgBtAE4AZwBHAGsAWgBHAEYARgBhAG8AbgB4AHMAQwA3AEQARgBOAG4ASAA2AEcASQBIAHoA
bQBSAHMAcwBYAHQAMQBqADkAYQBnAFAAdwBwADIAZQAvAEsATwBsAG4AWgAzAGkANgBOAEoALwB5
AHoAdQBRAGwARQBCAE0ANAAvAE8AZQArAFEANwBMADEARwBGAFMAVwBlAHUAQgB2AGUAdQBzAHcA
UAByAEkANgB2AE0AbgBXAFcASABUAEEANgA3AGgATgAwADEARwA3AE8AUAA3ACsAZQBRAEEAcgBU
AEEAdQBKAGIAUgBUAFAAVwBwAGEANwBEAEIAbQBsAHgAaAB3ADMANABCAHoAMQAvADUASwA5AFgA
LwBrAHAAZwA2AFgATgA5ADMARwA2AHcAeQBiADAAWABEADgAMgBKAGUATABOAHYAUgA0AGkAcgBN
AFQAKwBCAGYAaQBuAEUAVQBnAGcARwBVAFIAWABhAG4AVQBVAHAAbABhAFIANwAzAEkARgBCAHUA
SwB0AFkATQBlAC8AdQBrAFQAUwA0AG4AKwBEAFUAQQBkAEIAZAB0AEUALwBlAGoAYgBDAFMAMAA3
AHoANgBhAG4AdwBkAEIAKwBlAHAAdgAvADAASQBYADQALwA1AFkAQQBlADkATwBuAHkAMwBWAE4A
QwBuAHAAVAB0AE4AMABJAHcAWgA3AFQAMwB4ADMANQB6AEcAeAA3AEkAbQBvADgAdQBxAE4ATQBx
AG0AWQBiAGsAcQA4AEYAVwByAHAAQQArAFIAOQBHADkASwB1ADAAegAyAEcARgBGAFYAZAB3AFMA
bwBCAGYAeQBRAGMATQBEAFgAUABKAHQAMwBpAEcAcABUAEMAUgA2AFIAYwBaAFoAeABRADQAbQBH
AGYAOQBtAHoAUgBOAGgAegBpAG8AbgB2AEUAeQBaADYAeQBaAG4ARQBnAFQAagBsACsASwA0AE4A
bQB2AE4AOAA1AGcAWABlAGoAQgBWAFQAOABEAHQAQQBzADkAcgAwAHgANABiAGcAeQBqAFgAZABC
AHkAeAAzAHkANgBVAFgARQBvAHYAVQBjAFMAdgBuAGgAMgBWAFMALwBkAHoAUgAvADQAcwBNAEgA
UQAzAGMAdQBKAGwAMwA4AGoAYgB4AEQALwBHAE0AdgBQAGIAcwBzAEIAbABUAEwAcwBxADQAawA0
ADAAbwB3AEkAQgBUAGwARwBuAHEASQBrAFoAOABnAGwAcAA1AHoAMwB5AEcAZgArAHoATQBmAFYA
NAB5ADYAMABBADAAWABMADcASABmADkAOQB4AEgASwBBAHoARgA1AGMAbABmAEsAZgBnAEYAVwBy
AEoATQBoAC8AdQBmAEIARAArAHQAawB3AGkALwAvAGoAUwBFAFoAVQBIAE4AZgBHAEEASABPAGwA
dwBRAEIAbABPAGsAagBlAFMAYwBaAHYAVQAvAFoAVwBXAEwATwBCAHgAaQBUAEQAUABGADMAQwBW
AFcANwBIADkARABRAFkAZgBrAEgANABoADQAdwB2AHcANwBsAFYAYgAvADcAMgA5AGoAWABnAG4A
SQBHAGkAawB6AGIAOQB3ADQAMABnAG0ARgBSAFkAVABwAGwAdwBwAGIAYQBEADAASwBLAGUAWAB1
AFMAWABtAGkAdgBhAFgAdQB6AC8AZwBKAFgAcAAxAFEAZgBkADgARAArADUALwBCAGkAVABxAEUA
UgB3AFMAeABQAHgATwBIAFUATABmAFkAZQBxACsATgBUAEUAegAvAHMASQA3AEsAVQBiAFIARwAx
AGkANQBPAHIAcQBTAHMAQQBpACsAUABLAEYARABBAHUARgB5AEUAbABJAEoAeABwADIALwBEAHEA
MwB0ADQAcQBrAG4ANgBHAEMAWAAyAEYAcQB2AFIAaABtAEYAbQBHAFEARQBjAHQAVQBJAEsAZQAw
AEwAbQBYAE4AMwBPAEUAbQBZAGoANQBOAHMAcgBWAGIAZwAwAFMANgBqACsATgA1AHoASQAAAAAA
1ME=

--_000_BY5PR12MB41152B09FB91C66FCFB4677C8F489BY5PR12MB4115namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BY5PR12MB41152B09FB91C66FCFB4677C8F489BY5PR12MB4115namp_--
