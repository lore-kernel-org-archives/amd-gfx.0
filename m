Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4DD358E5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 08:56:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AFA10E819;
	Thu, 29 Jan 2026 08:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgvonbhQ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE8810E819
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 08:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnRuqoS6WHtPBQhNG4E2tSTYGGuCVM1Hmubhww0Jn0i6M7KGya1ZGpcl7zcrjgagAWu3YG1khNXNQlH/eG+cWxHgT8pCnAgeKtIDSWY46K8dCPtpwUAHYIqlJnP68NXV7lmwuqNJwJczsHqNDIhV5v9RDzykPCS1EiSv42NlL7nz6R46Jfh1dUsYLNT/Yr0+SgPMAJXHtiPYjTu40rIJXULes2s9sjSsWyDR6B1BM81zYZI1tyR+GCsq9Nb5Zo9T2gr/rxvnlbiS8jmI8K3FhCnO8CKuDGyZotGqqEfdJdnO+VWRhqSu1pH35F53eSaNQGeWAl3PfvFgcurpROzNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vo2c/gTzhCeWYL7+cYRoHrrUevAj0hgEx26jUoJwWtY=;
 b=sqtdKp+fXuPvhrylkq4GUmwphruIvkvGQgB+gVr9mnFOoeCkDLVCeVL1+S0DHzIkvfaooEzZrRuFUUvKfTui38EwMxYD3AKMcVD+LDB5UaiO60CI3snqDWnlRoRurMdmvOxGXf9mHqTp7S5nEvXWU6KOne4ZEd9yaraf61OoX384pEZXVL/Rl82IbIZNai4DsoBD+FC3tSCfyyqgj/sfzTv9hBWkEejeSfhFW65HRY2z9z8IHJeoqsLenfCsXrOpeKLOx50qHn0qm/EZnD9BXCEKmDcf8mlgyUk/phn/eCuc0HF28i7IHqsVwyoWaxTuVTT+xMslk18RJLV4RLiGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vo2c/gTzhCeWYL7+cYRoHrrUevAj0hgEx26jUoJwWtY=;
 b=lgvonbhQUE+2DrRe1SP34Oma2ZUHzqofDVqh91R4iceQY+ZmCQZGGDi0mQyUCtRDiT4M6vQ/FetoyDN84QFTktNwRiZ5GahfFH6ks5pqn5h1hv/YZ78RtkgXPn+ha+t3k2ypylXKw1RU0LqT3ASb0MWTcKnBNs/prcf7doX9aBw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 08:56:26 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 08:56:25 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu/gfx11: adjust KGQ reset sequence
Thread-Topic: [PATCH 1/2] drm/amdgpu/gfx11: adjust KGQ reset sequence
Thread-Index: AQHckNlSD2l0gKrMO0ejqB5w88GF17Vo2Ecw
Date: Thu, 29 Jan 2026 08:56:25 +0000
Message-ID: <DM4PR12MB5152E224A4068DA82B195746E39EA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260129043936.33607-1-alexander.deucher@amd.com>
In-Reply-To: <20260129043936.33607-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-29T08:55:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ2PR12MB9087:EE_
x-ms-office365-filtering-correlation-id: 50a3a3fc-250e-4487-9ac8-08de5f1448ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/2CKEjlWeqj8DxMnD6QGM5YO13yZGMsctij1HvDn3zYnWRxhAkpNyk9OKuOw?=
 =?us-ascii?Q?LszUHjJ6jxQZQRbqp+CRy69EAoiGepQMFgoInut8tqcG3pbxfSA8pztOLwNq?=
 =?us-ascii?Q?++nIVYsIIb5sJ9dr8EQCATYS3+GYu211gZ+uWirCGf/Up8Vc1Uao1Ak24Y/5?=
 =?us-ascii?Q?iFuL56yUzxTK1rBmMK6RDfIUTPm1gDGKBGAD7SVUyCrflPUl4Uy7dSofh7ib?=
 =?us-ascii?Q?GJVTUQrzl+3+pGcwLnsABGeCn5y4I1TPYf1ondgebIDB39A1IUoAChtKizn1?=
 =?us-ascii?Q?uTI0nGiSEIeQQVp19yveK6VTRIZBOKuT7eAQ+wyxqP4pzoNLS9yS0xDOE4ex?=
 =?us-ascii?Q?pH/hNYo8qiGBF030VcmPPO5aS3URKk4WmqoR5aJ088MtJP/qpAwtfNEvRM8J?=
 =?us-ascii?Q?dBkpWPqL+CdKNkLSdK3n7v/icueISshym86NEaXYTzKXsPz+swrEokesKqPd?=
 =?us-ascii?Q?u5FOeVvSNLU07iqP86SkLAhlWmvpmyQ9ONt8ZEzbjdNxGp7dE7157N3+GfW4?=
 =?us-ascii?Q?6+GskyhixCCcoaqBmaI7uu5fHXkH6eiiS3k4WeiXyaLBOvaFj+sxFzyQtj8s?=
 =?us-ascii?Q?33NH+++t5GasvIlNLeeWsfucqNgM0w/zDdLDIEbQQHRguh+I1qeKnJe/Fr9s?=
 =?us-ascii?Q?TJ9F7hmrtBMUiq2tWaK+mKVPq76ON6KedzAzUOkWuYzkz3xvghILBjZkFtXV?=
 =?us-ascii?Q?Tn4At9oTu4T0MTnAZjxO+OIzgqG/G6CcsB8NwkkqgtMd/in+1J/vluc0f78f?=
 =?us-ascii?Q?a0VvCx47w1E/1q7xB3Z01mayMcEsNr0UdWSCZCZLRGNYMnvp+jqHrAZDwbce?=
 =?us-ascii?Q?69iojRWkCdZVdxmgmHGPubZYQ/1s6o1LNCsFH/Re8WJt4GxnF5gu1zxY98i3?=
 =?us-ascii?Q?ocDCt+A3F9Iqavt/zkGUMPJSTj8UAWnbHiQjI9m9AAxmsoRvVJlp7nS/fauf?=
 =?us-ascii?Q?Y4xS7biZc64Xn3D6RZUTYG6W4DFB3S/45HJOcDoprgDk9DyoizTLIlmyBcU8?=
 =?us-ascii?Q?2BTYxf7m8mGDixX+3lM+vjuGcyZL7xQ8AgtQP411tIYTuQEISYIX2HbZ5tqJ?=
 =?us-ascii?Q?0Ed/XladAvpkaPvZxAuL4Xv0xDJTJfUj8jNGBBC8ig8ahQndwTsO8GgItdMG?=
 =?us-ascii?Q?6w2o4Kc9Uii9Kw4vh77f8T7iJ5+YtY82bPFQO61nI4M4JKzyVXqWnyRv6pBM?=
 =?us-ascii?Q?6MdYuCb6kPQ50xrAKKMB8RybNKTNfHG03fXHDArhuL1NOhR+pDKv5w1YzzuP?=
 =?us-ascii?Q?GzhJp+cXK+dJg8F/9ohP8N2ReB6+cdVzjneEVWNwsemAgK6ALQk0mAP8eTrO?=
 =?us-ascii?Q?dWvf9fnTjbh1hk+PI1G8imhUTgLbXnmPf8mUMEAIvv0mBjcJTZhMv1V15v84?=
 =?us-ascii?Q?63Py/y6MQ9HDs5u3WY1As1sA0ZAIRrBsTEUmHa/gpPlqvC2QrGglBWyhYL23?=
 =?us-ascii?Q?9+jNFhb3d07pji3ETxhg4wM7jdW3QYNJo6cSVZJEDxMIqm7wxlRhqhLil7qn?=
 =?us-ascii?Q?wG6TrmnMjjPfg/D0cYe23VUaA1U7sriosfQC4MDJf7rJYYXS1Vv/f1L9iEGN?=
 =?us-ascii?Q?TPMmBRj6+nIADMEPjfo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Xq/NPSyhmF2565rU8zKpyUugJqk8IGzlZeCkVTZzry/gWMAaXNbYrkyCpi2?=
 =?us-ascii?Q?b4UoKongtL112u/QNn+WvL40W0WC+tp9r4L1Bumz4K3+gQDWt/X99y0kPnIe?=
 =?us-ascii?Q?HoYpC6FrVWFgYSV5fcbrksthgVKTw8mxU0TT22e3WU11NYLlTZQMKkyeLJr0?=
 =?us-ascii?Q?JbqjVWyw7dkByqORdrd2s7sHnGj5c5IUyiFmTm4caJCGZ7KZIsS76EFGTb72?=
 =?us-ascii?Q?P6XhmS4KYR7zFRraA1xyUI+Fvegn949d67mqrSQ5yysmyLM5ZvNF2zV8rwaK?=
 =?us-ascii?Q?VYk11tgcVCgkY+V4Nty2swS4JJ4rw1Mn+bWLUy42swEdsGQqPX6JgBdGAGBE?=
 =?us-ascii?Q?h1GfpTJTmBI+ZxVenRpli0wt1mrWc32RJriMR85+JLJ9v5kyMaOXFzt0yGIL?=
 =?us-ascii?Q?dm6IoNkX8QMLnMscCtZ96PZjwXYHDRyNlKZMrqxHMJDDcmo2BJ1oPNWQd7Zp?=
 =?us-ascii?Q?7ya0vZstp1dZ/e3/6PNQu/Kc353ztR64xjfg5gEWB/TwHYnAsphfByKanKPA?=
 =?us-ascii?Q?xeSD1K+QphJFED2SN+oMHH6m8nhV6nWzbd9iNle1NXYeKKPurJa6wA0cjNcf?=
 =?us-ascii?Q?R1Fz7ZPqRQbgGMrkq1TIC2iuATR61VPc4dsuVbk19YBIU7W51sa2KiRv9Q0f?=
 =?us-ascii?Q?5WhbBfWWGDvrCsnsVWn5NvDMOEPqpKeF4wIGGzXgclewK0GPPyQYZCGpBcdp?=
 =?us-ascii?Q?k3rmkM1LUmHIoHUFisQAdE74exehqzYRpBuX0h1QdQSHSnPBFbrWoY00ZVRz?=
 =?us-ascii?Q?b45h0Jh0Vtm7LmVFCfx62nSZXYgZtr+S73ErrnnEScsk5kezkJON9hdJKPrl?=
 =?us-ascii?Q?m9BOTSTnpBienIgR8KjUHXMe22/25hF2BKokjlbXi40gXFoJc90kKb0WHxFV?=
 =?us-ascii?Q?ev4T/FjihCEjFo4nHW/xQe1NPkUGGokEILJIvC2pSvRNY1BzMp6mES6Gakt1?=
 =?us-ascii?Q?cd+qdY3iQOgLbVfwH7IIxvi6ZPgcWj4FqpO4uDPhcCmXMJcBoQOAHqWRHUFz?=
 =?us-ascii?Q?YkkR824fXvyiRaDXhiOqKRKiEx7yJBQbag9mcPisXwJDMGg2KSvQeudjrkDA?=
 =?us-ascii?Q?xd1nDncCw0KKvChy/9HSH6l9zW5/I0jeZmzdqitSRyg2EaCIOD9HrWYFrJBj?=
 =?us-ascii?Q?MFx9nX0vuviY+39CgvVirB/uMYIdY5CXKw1ZhTUbk9OiQBRP2IpaNOndbTE5?=
 =?us-ascii?Q?QKAAB1z/Nqg8isqGcO79lYbNZDbn2nGyJwJ+QaRkLOSjfyv14hVWB3Ic231q?=
 =?us-ascii?Q?SZtEiMSGR+foXLLtdP1B6Ngocxuy6rF55J0/41iXn5b4l2lv6ie+ymNHCjiV?=
 =?us-ascii?Q?38n8GzccNOHDcMcUCN5Ct57rQxuNiPyFLC55JHLnSGXNKPSS+gQQz2OHPJXQ?=
 =?us-ascii?Q?3DBxyBjka3HothzVBHunMlZZQWntCXeQndJd80wpOTPNNUM/7om3XrkK18PZ?=
 =?us-ascii?Q?1kxgteGfcS35hCRXn3BcuaTI/4ujAXOWH0pvbCo+O/sT0RpWt2q4zkyDw3d+?=
 =?us-ascii?Q?Q6hM107bP9izoTH3ietO6xbTmOmcuSSviBOako+E+XVI+GBAUVssMDCBKpQZ?=
 =?us-ascii?Q?X+3LRNVQsvlt0e/Dp5RUhdUDDvXGlsiM27M5cdrLBjvqzcdw2qr++KEyZNen?=
 =?us-ascii?Q?yZGvNo9817j4P4lqAFeTcDi2k//7Dk/EHGTPX4WLUrMLvEg1QOlS4jjHAony?=
 =?us-ascii?Q?tGGYG4Cl9xV4WtnpJxGbvG6YtzfxQL96yYBN8e98M+U6hy00?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a3a3fc-250e-4487-9ac8-08de5f1448ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 08:56:25.6084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+FnI7YmsIPChScaoLCATf1Dya9KZokzCs1i0v9fYePTmqmaHNszzbH8CZqz8JCSo//x74sdkvjVLuvVW7XwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, January 29, 2026 12:40 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu/gfx11: adjust KGQ reset sequence
>
> Kernel gfx queues do not need to be reinitialized or remapped after a res=
et.  This
> fixes queue reset failures on APUs.
>
> Fixes: b3e9bfd86658 ("drm/amdgpu/gfx11: add ring reset callbacks")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index b5a2d09fc3469..489edf517f91c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6854,18 +6854,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring
> *ring,
>                       return r;
>       }
>
> -     r =3D gfx_v11_0_kgq_init_queue(ring, true);
> -     if (r) {
> -             dev_err(adev->dev, "failed to init kgq\n");
> -             return r;
> -     }
> -
> -     r =3D amdgpu_mes_map_legacy_queue(adev, ring, 0);
> -     if (r) {
> -             dev_err(adev->dev, "failed to remap kgq\n");
> -             return r;
> -     }
> -
>       return amdgpu_ring_reset_helper_end(ring, timedout_fence);  }
>
If it's reset by mmio, we might need to keep it.
So, how about adding a check like this:
static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
                               struct amdgpu_fence *timedout_fence)
 {
        struct amdgpu_device *adev =3D ring->adev;
+       bool use_mmio =3D false;
        int r;

        amdgpu_ring_reset_helper_begin(ring, timedout_fence);

-       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false, =
0);
+       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, user_mm=
io, 0);
        if (r) {

                dev_warn(adev->dev, "reset via MES failed and try pipe rese=
t %d\n", r);
@@ -6874,16 +6875,18 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *=
ring,
                        return r;
        }

-       r =3D gfx_v11_0_kgq_init_queue(ring, true);
-       if (r) {
-               dev_err(adev->dev, "failed to init kgq\n");
-               return r;
-       }
+       if (use_mmio) {
+               r =3D gfx_v11_0_kgq_init_queue(ring, true);
+               if (r) {
+                       dev_err(adev->dev, "failed to init kgq\n");
+                       return r;
+               }
             ...
        }
> --
> 2.52.0

