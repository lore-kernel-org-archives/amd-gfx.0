Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A97D77883
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0556210E2C9;
	Fri, 23 Jan 2026 17:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oLiz68mK";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38EB10E2C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWtPR+m8kjr/3wSly2nI16PZSMZw7D+96Vsedfn7N9OW4LwEsQRGR6CXdUDQ9eX6exLL7rIOc2U0t6d+xVJ5/EM17z7dydn6ouYMzQqMBUeTD6oFhdVSckUVCqYUkQmrPdJoUumqtvq8sYI/uz4Jij8vdljFt/P2X9D4M6rp1KcKnof1T43Aoe4hcUcwd8Utq3HWRf865j35kj82JztjFGGQE7GeHE1inGprhr5PaOe7KxRSz+VJ1GKXCrh07l1KAde3Uu2r0kGpwEmhT6CpLE+ilJ5k5SbX4e5Quo7wE4CfatYG/6910IM4fcDBBOROOY5HF0R+2DaFkgRygvidzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceo/1di4qpse7WRNK2ywqQoMGJQRZTK+EEXSCrsrnhA=;
 b=idUZEaPCYd3Fc4Ew8J1qu1caX3gIOUcWyhRBjyeGHRncIEH0YcHzR4myaOLpJnkmJtexJD6FySMqu0iPBtSg40czbuqvDtAfZqQ/JMPU9WFgTJl/YgoSF3yDxWNrLDi3I1eeLOefWBjfSNyMXY2bWGKaMXlyzL1sKVfv33i9kC6nGMDT3RfmwdSxeXKOqfqt12380hmd/UeXdl+U8KzMYIzWzj2b7c//hz7t0E0xDBewOfTCI5HbASiOXYaDFmTQnSpEJmIQMeCEEaZl1OeUcyX6d3CHNWD7n4GwwVOrALasHhBeR83P3R+V3gQg5P+JxpREhElNrnmkGU0zRQJ9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceo/1di4qpse7WRNK2ywqQoMGJQRZTK+EEXSCrsrnhA=;
 b=oLiz68mKGBmiG9bJ/xpNFYIUSIYV2b67hTGieItVAGPa3EBWJSYGWGDSigNbj5KBgdkAus5ywSZft6rCXQFgdnAzTB1SfVJSNkL8GN2rfqSwTp6i85c+8peDZlisy3dExjk2bhyazgksceEnYI0YmCUBVtzuz/vhOptrz+9IstU=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Fri, 23 Jan 2026 17:01:35 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 17:01:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Topic: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
Thread-Index: AQHci7NSeef9uDGClkKMq/doBL/CiLVfR4IAgACz+0A=
Date: Fri, 23 Jan 2026 17:01:31 +0000
Message-ID: <BL1PR12MB589834F3ACE3526E2AA118F28594A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260122152501.351937-1-kent.russell@amd.com>
 <PH7PR12MB87965382F541A9E18CB67EF9B094A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87965382F541A9E18CB67EF9B094A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-23T16:58:23.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS0PR12MB6632:EE_
x-ms-office365-filtering-correlation-id: 5b10388b-e734-4561-e6fb-08de5aa10ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NvIqqCj1MyJtYMSuoAO0Wx/P6GspoIMR3+mw7Z7qGuJPVRwtHS/Lf+Ftnp7O?=
 =?us-ascii?Q?z64x0F4Y4daNV/BjtozfW9HL/XtRTgqVF+ZSz0XrL4EGGEA0YXvemaWp4f0N?=
 =?us-ascii?Q?FJywLOPUZpsxbVUf0jCMefhEEiW1agXelyzsh00LOdr1b4xRNOH/k2IFBofX?=
 =?us-ascii?Q?HlHHB0vwGLKNTo5N4wKdJLSI1qyKlcqQpWvVKHduRdaR+lmceM2lU7ol5B1d?=
 =?us-ascii?Q?KJcF4fHPMfnFTio/gxL4L0Dp1sbqJzhmV4gO2MKHUIXwyJIkA3kpOVKMvdKn?=
 =?us-ascii?Q?pAliNgmvilQ/ANX7lg4jQpJ3bCx/XTHNJyTI4uWKcCHlrhhYWwToSAgfb3TC?=
 =?us-ascii?Q?Vg/C5tNjLY293+54ATOaQ3USjmmLsRw6vC8Ouhgqfzlj/AyYOOxO1tAUjD5J?=
 =?us-ascii?Q?AD5sxCGvh5USpw9AWibp7MwKZjQ5HNrd/8iW3Bj5hvpGqwV8F0hNgRS/U4pu?=
 =?us-ascii?Q?Nsbd6YunY5QSSuTrapztEC7hrPoyOeFGhLLUWoszuYVMDHtwxKFN4d7UDhfe?=
 =?us-ascii?Q?gWlSLWLA22Y4F4AHYrvPH9yjnc3dSPRKR/4mJU3xMBV0dETVq6EIr3TVQZSA?=
 =?us-ascii?Q?VyvDxx6GkwEyyM/EUuAGZ0zwBCzziwMUUaCwsEIvuNSyuzwdi/wYQsBW8Oe1?=
 =?us-ascii?Q?TSCq+XjuSUiWUPBdyxQagaYYgku3ZmooDbYjOMb6E5wVDD9aEcu5eHD6BVB6?=
 =?us-ascii?Q?pZJJSVMIldFfp8z5Q/nrF0clApWh1n56XHyK0M/Ab01aED+jxqRFinnMA7xX?=
 =?us-ascii?Q?+89SZ+MyRf+9OU1ZQU+IWpRDX+i16oqbcXgJwgdFkKmjri1T/ZSpaIzmLE8D?=
 =?us-ascii?Q?YYQkBtpC1f007HjgZwprXp/Y4YOSTcViDAwkNYZwsUrGqMfJVGKvJiKl23Su?=
 =?us-ascii?Q?zhMBm1zWDlXMwrLDXR9X/enqcGg8lekwpjLWHAycvMatWRypmmrykqokOzv7?=
 =?us-ascii?Q?nFxTqZ0Zcg1jl6RchPc7wGzKOkGoz/+hNE/dnXx8bRtv1lrCOPOX3g11yXFd?=
 =?us-ascii?Q?DKrbGV79ier2Uss0qm4+iZ/uaLA2AgzhpL4ULg1LR9MzbYL/+I/7KgJm16E2?=
 =?us-ascii?Q?rLc56lcQshHxVhYGJbQgpkoaOJNl0UkaffJp0U13uBsrzHmRTc20zJisnOGb?=
 =?us-ascii?Q?Z76VeMuXwQo7I9RUumBONZ/7XrXJfUFcKL3Hng1VkAFLs3tAxP8lgsnK1gcM?=
 =?us-ascii?Q?JvnSipZSSWQahZIz/W1Ju+SndPwqRn9z4tmCPHCQktkefS4ioGPxfh6BymMX?=
 =?us-ascii?Q?S9USfPe6UMVofyxMPUwelzkTiiFTEr0nbqE3Xe0WnWH0kcXph9v6d/nVfudd?=
 =?us-ascii?Q?OYZWpkOFZVIF/xNvKOTRtZtMwFDYR3nuVP53ozUXrJAMqJXEwvY58VapNiy7?=
 =?us-ascii?Q?0lNLeUUNrBXh/XakOoGt8dHm/hvA9ZMAMMeV+g9h4QQ1lJoDZ7PzzcJsUfbO?=
 =?us-ascii?Q?MX73G9r2TXFCK8Xv6hFnMAkBhou9MB7v0grGdxr0UdyBTspo/T451CZUm1+n?=
 =?us-ascii?Q?sO+hlYHrXIREhgeDf4SDjMqYIhmITINBil8IvX+gmNkquOH7hbUKfwtEBJOQ?=
 =?us-ascii?Q?FH4h/oWVkF7KOdMEP0LDyQNBfu4Ofjob0aK6dEKz0mp4lJx5Xa+A6nxZBWMC?=
 =?us-ascii?Q?oXHKLD0ovLStpuySnBJpFOs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cJm+EXugsluMe+EH4d9PvcQubiKK4S7CbnHCKD5L3LXGpYebCFvMXreZfsK1?=
 =?us-ascii?Q?bHNjrZusdoWwYgG144Pt9X08cvnhxoJGqyuserNBQJuQWpPJEy3Z6Oy/1tAh?=
 =?us-ascii?Q?iPkH5xF2cFRW0hP35JOY4/Ikzu5oboAg5WiC5fOW9lGnhJbuPh5OKkh4xaFB?=
 =?us-ascii?Q?dDeE5OGpctXTZutF09HLLBuUKWN5oUHpl8gBGRHoprB3pCUjNmfomfZfsEv+?=
 =?us-ascii?Q?hp06Nqf/DbdmFEKEzxwBGB5ecbsrEC0YGzRswr7nQte307nYyJaAwAChun6n?=
 =?us-ascii?Q?H5qlZn9ThXIK3HvBCF9CoLE/UagppHoHsO37kGvbDHSques0HUPbY1jdwfGx?=
 =?us-ascii?Q?n9q62nSbpgQW+SjqZUtZWxIrjkZ2qbB1lj2ubYph+XqIi1CmyxOar82v3Xo+?=
 =?us-ascii?Q?ZTZyO3UY9voj7xxswB/EZA4kx4KCREvAQnMWy0dCfsZlPSsi3Uj40FHF+ikH?=
 =?us-ascii?Q?vseN0WSCvuCDt9xwGBCXWaPa3sxNpx6VjYNdYmRyo+LoRuCGHdnu5LGolDY6?=
 =?us-ascii?Q?L/rM3lYMtA+iaamlapzLPkkw18f7p5J6ytfVqWZxOvGE0b+nzlhVZPdW3AGi?=
 =?us-ascii?Q?yXtY++t+b8iykj8LgpFKBMhRgf9Og00abnxWcU9llAuTzOrKGabP+5YToSsm?=
 =?us-ascii?Q?uuXkK420r7aGM/Cp+mmWcgcpUb/cg96oWfSItLd3kKbIyKFO212vFq2Fsv29?=
 =?us-ascii?Q?NYOP638/BXtjYIoIuMkDlUXRwY6E7P3RlENKc2nfofuOu2JJghOJGx0KM34k?=
 =?us-ascii?Q?G9lw6gGc7swGWUG4gfrUVbhpqUHTg4pVMx/6Ca6V9qkCjstKeGtYeB+K1bw7?=
 =?us-ascii?Q?66vNsFfm4YEDUsRYQWtJXAQJiYARm+IMHgCf1med2V6+qehdt/SCU4ZQnokL?=
 =?us-ascii?Q?A/xUvBtcXrKzDeNEpJWWrXIfe0sCtk8EydBYfZfAINtLZV4uwGzfxyqbEFZw?=
 =?us-ascii?Q?ZIeMy3jpXB8jwo+tn5ycrh7RlGh76X8fHfeJyemv7dk/WbZ9S1jeUDH929Fs?=
 =?us-ascii?Q?rdC0+A7HG1PCpA5wnLIaxqqagALWdOqeI1bTWl7sRXGuVYsJSB34+gMjM261?=
 =?us-ascii?Q?/pMWvz6NKwU8RgElhPLRaMYxUIWi0/LD1HzxIHYbSLkYrg2JnX91ZDhYuhA7?=
 =?us-ascii?Q?0uHoU0di+TjxTm1S/Y+87Kah6JXuj1udbfAVgOww0Ni7jVifHnGBp8zZyex4?=
 =?us-ascii?Q?aFLFu6bH+Brgf44fAjKh3irYJHL7KePzYKeIb/KXd/zidVJUoxtlfTEBUeL3?=
 =?us-ascii?Q?eV9m0jeQioCZOAWLv9Ihgnd+CXIbylKjLGWlfalsUgv2VTE3EzGrRKS/vwwl?=
 =?us-ascii?Q?OiIgR9irTy7gAdPcCSXJr6e5w52pg9dEy5uFtZyluoTBuLSr3zcEUsmVEQip?=
 =?us-ascii?Q?QAJWyibUVsJkxN6xh0Ae+ZUnusP+Cq0NHypoymFTXsP0jcqgpvgkEm7llaj/?=
 =?us-ascii?Q?dBRQ6gqSSy+FSMEZKuqgGxaT+3Ptnx0yrl+pU2W8iwNgObNQ0Tg9odbC4im6?=
 =?us-ascii?Q?PI8zmIK77pwkvSVEd6xg1oTGLj/I3VEA7sbea0eE+QRyOzzMw7Xi/ftFtQmF?=
 =?us-ascii?Q?b2CWS0oov01MJaOnlc9/9FL35HcQntCmjP1uWFewrx+HQjaXXbEo6BTmUPvz?=
 =?us-ascii?Q?yxtRCxH3yZH0HzFw6iIXbmD8zYekmKEkYX50Fks9+X6IlJq3gggA5mCq4Z2R?=
 =?us-ascii?Q?T6eJCc4/z6aKz0KF0BBO6c59+8maVAZ7dm6hDzJ9VtC1GwEX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b10388b-e734-4561-e6fb-08de5aa10ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 17:01:31.4699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbJJHP4jirPJTMCmJbW4BNoqnNPO4p0UGTq3ArolvfenLcnvR/uoZXaexijAU5Rlllpi8Y30lgU/zlMUZPZtGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632
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

[Public]

Thanks Tao. This was really just to get some feedback on how to do this. An=
d if there were any dependencies. Ideally we want to send out a CPER for th=
e situation in the commit message. I can definitely add that as a comment.

For the 2nd part, I am not sure. The big issue is that systems that rely on=
 CPERs to know when a GPU is bad will not have a CPER for this type of situ=
ation until they take a new UE. So we want to alert them every time we load=
 more than the threshold. Would in-band also benefit from that? Is there a =
drawback to having both? I figure more alerts is always better when it come=
s to unhealthy HW.

 Kent

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, January 23, 2026 1:14 AM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> > Sent: Thursday, January 22, 2026 11:25 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent
> > <Kent.Russell@amd.com>
> > Subject: [PATCH] drm/amdgpu: Send RMA CPER at bad page loading
> >
> > Some older builds weren't sending RMA CPERs when the bad page threshold=
 was
> > exceeded. Newer builds have resolved this, but there could be systems o=
ut there
> > with bad page numbers higher than the threshold, that haven't sent out =
an RMA
> > CPER. To be thorough and safe, send an RMA CPER when we load the table,=
 if
> the
> > threshold is met or exceeded, instead of waiting for the next UE to tri=
gger the
> CPER.
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > index 64dd7a81bff5..469d04a39d7d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> > @@ -1712,6 +1712,10 @@ int amdgpu_ras_eeprom_check(struct
> > amdgpu_ras_eeprom_control *control)
> >                       dev_warn(adev->dev, "RAS records:%u exceeds 90%% =
of
> > threshold:%d",
> >                                       control->ras_num_bad_pages,
> >                                       ras->bad_page_cnt_threshold);
> > +             if (amdgpu_bad_page_threshold !=3D 0 &&
> > +                     control->ras_num_bad_pages >=3D ras-
> > >bad_page_cnt_threshold)
> > +                     amdgpu_dpm_send_rma_reason(adev);
> > +
>
> [Tao]: 1. Better to add comment to describe this special case;
>
> 2. Do we need to trigger in-band cper as well? Like:
>
> if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
>     amdgpu_cper_generate_bp_threshold_record(adev))
>         dev_warn(adev->dev, "fail to generate bad page threshold cper rec=
ords\n");
>
> >       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
> >                  amdgpu_bad_page_threshold !=3D 0) {
> >               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
> > --
> > 2.43.0
>

