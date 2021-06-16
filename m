Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3B7C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 12:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0724A61359
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 12:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0724A61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AE689148;
	Wed, 16 Jun 2021 12:59:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5906E89148
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 12:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLZM4me9z7I74utSb3Fgtje5nFo6QRwhlvkXHzsgHkWtbWFo0LqQhDliJOVNURYv9upSaD0JL9/rw6d8hMt3Qaf9mG/BF82FE7U3mBNDlQ6Pj/Zv0Bxr0vS9cEvdFomEDfinWcrtKiwT8GGYd2Da1D9tf2RvovS28wgH7NqlHX/Aj001gXqoaQokQWr6hF0v4OKo46QsH/CECU/OlnMVdhi8v+bjaiRiPlq0CJV9wSf2QYsW8yMnGNKf5kZ9kYuviQvediZ1icbX/ps371IzCpNIGerU7CnPI8N4PVEQFbd3n2OKOduvJ2o6FQXir4/amLFCo05uyHDDIv6gx9AcBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFR8P2j7Pl4DPPtbeesgECjAeu0J4L35WbmZR1GhAAA=;
 b=jX6wxEZZEjk9aMKSwl4cijHK3ToBowPM10yvC8fXLB0iEk28SP1+dp751x9zaPEvUlTF15pYi/xRWMB7QomOK/8mjHmzapalwsIFTV1vvUnLhSiWpH/NgRYpIKZvJPVc3wB9VutqSbdLo+qei28wUmit+2dwucZ0N58h+r/jIfmSlEHzUJAiKE58dOBVKAQcASwEGC8v4qFBQyvUQWpuV5la2cZTDWJE/2U9A2ADXuPBjiO3COTWszasnK+85w+efEGLJlBMXPAVEadevPaSjLHqwF0otya5hIKcHc+0A6Xz0OK4urbFIVtEysBbXHJDpRfCxJvrakjdsAYMvCa+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFR8P2j7Pl4DPPtbeesgECjAeu0J4L35WbmZR1GhAAA=;
 b=DXMqx7cZaDwwokD++S1RYDOCf9FgCXoBSGISUCY0F+t9A4a3DUatq+LaeIRwI/fwfgHVvFmeBKVBvKwhJTW+ufaszQng32oybdIixglZPLWgc+A9rr+T4UagO/+KW1ijHoxti4SqpLZUUJDaJMMEN+DWbPR9zOZvv9N7RjKZYsI=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 12:59:18 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::e8d9:df11:13d:7d9b]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::e8d9:df11:13d:7d9b%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 12:59:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: force enable vega20 gaming sku gfx
 ras
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: force enable vega20 gaming sku
 gfx ras
Thread-Index: AQHXYqtuwPyUF59JOUKaziTCob8Zd6sWmMJw
Date: Wed, 16 Jun 2021 12:59:18 +0000
Message-ID: <BN9PR12MB536820508614585B9018D0B1FC0F9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210616123040.32629-1-Stanley.Yang@amd.com>
In-Reply-To: <20210616123040.32629-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-16T12:59:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5c827cf3-93bd-4035-aab0-3783d374e991;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9650ad20-02bb-4b3c-cd3f-08d930c68db0
x-ms-traffictypediagnostic: BN9PR12MB5097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB509700313B0FEFEBD7702ACFFC0F9@BN9PR12MB5097.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EquZZxMXJFwDnpQNa0hFDJeYYfclM//hRIEZdXyE8WZ/DfpQr2gr63UZXZi/DyHRlhYSEtS2SRUs/IIFWea9TEsESHQObgu0L+wfS2Fmkj+VXSUdqcDKR7GplolqPEpUMplkRUXo3v2HcEazUDdOyxd3r67Rz4KTt0FU9rEHcvhVsSTCdXjMjocs3kiPwLyCdZY/P0lHZmCUlws8cFdODgX9KIN8FSf8ojVxvjLNiyFeQJhjk5wzH2fgoeyHPOXVrusZjxhuqCvQBjzZ5GfnTwWxokY/cx4hyWu2KO9u70IZoP4J68iyuCYoif9E19zE41OLdgMoySS7vb6z6kJS6dDrpJhVKZzZuWU8lFlC+cGdGdI3aJbpfNuoAgqbmFNRkwH0TT9WM20+bHfKNSnMJMfia75GpwdlWueuH0sSqTrumZCauAVMh34uCiRpu3QsFuZvIl84ZGzm1McARDTrQtXUrbuu3uSKuMnAkP5EoEEbAv7eHTQNtOnNyyZGcdbdEsKb9njdWKq97zcfNEJjXEDv0+5knBbSljKZWuRvIjXI8UGcocuHUefrKJM0XkKVXdf7aSxxjNCJ2dzsLrl4cbXSN7Uilgy2kxO1aHUzSAc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(38100700002)(122000001)(5660300002)(316002)(64756008)(66446008)(33656002)(66946007)(66556008)(66476007)(4326008)(26005)(186003)(55016002)(110136005)(478600001)(52536014)(9686003)(2906002)(53546011)(86362001)(6506007)(83380400001)(7696005)(8676002)(76116006)(71200400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G07NkmGtGhkTevyneD9iUf3DWBSamqqRezrFMkXlNDsxD5Kh1QgA3eq/7RdT?=
 =?us-ascii?Q?jLSYOB7fEarCQQjdsDYkhemDWaRUfVakPqvUOL5J/HhgM9h45Jk7X9L3Pnt3?=
 =?us-ascii?Q?v+aEB0lHu4izaZMIMojeV0zhPFF7dTuWWGcMCxPm+exJ96lMayVhsxAJlVDi?=
 =?us-ascii?Q?zXUbkLzyDCUpbS0e038SSE/s96SvJ7Z5dS1AGcxN7N55aFIn/rdSnpx7Z194?=
 =?us-ascii?Q?ZEEmloZgX8BCJ8oOp2gsNdIDmQeqHaiLyF6zxa8O0COjboRVFn0mhkAr5/hh?=
 =?us-ascii?Q?Gm72+bZ8HSCs/TPDlC7eJsWNBppp8N6Xz9om3mgmTgrfA8U0OVrO6GKm3jM6?=
 =?us-ascii?Q?hyaOGN4gT3B4wvCrRrWKNZqFRCzV3as3iZ+i4va/wAKCociUiB5msv0ky+E4?=
 =?us-ascii?Q?U7U1//NKsuVcLZqbMssloIMTl9ZagvMIkKScjEOeSsEscLl0vUd2Yz//zDXR?=
 =?us-ascii?Q?C78i1ZgqWN/XlYY5dktLLGySvsN5QKOu1wWrQeDsku2czUFXuoVmfYWNaO70?=
 =?us-ascii?Q?fpFpiVt6v70tqyIg1aaJxM5j51YhBpC2fzb22rIBbkqWYqHS5C5+/SCnn1G6?=
 =?us-ascii?Q?KSaKlV9YttOQB2WpNFJC9DhfLTamvEFGzmJLM+rLVI6fBnsXyYOVCKrjJBTv?=
 =?us-ascii?Q?PmzHA4k7VinfnOEwlarwA8TPtsOJhqJkXv1TP4z4E7QYX9wuyWaugGlhTttD?=
 =?us-ascii?Q?VVXZG9xkgBGWZsUvF2ClGUvYcEJUvoav0RBdLNS/BOmQzAjP7NpdPpBQLq45?=
 =?us-ascii?Q?haAqGmvzV34lGdAw1HYAk5e4QI93q0qkUGaiVeUuLNlQW3tJruKt0QH+9sho?=
 =?us-ascii?Q?0bwdjVRQMDrEMmQm9DcHUgzEf2xQtuz4LeFpABKYJ7VxSC8hRwx6ayyInZHS?=
 =?us-ascii?Q?9kdOHCqxeDf4Wx+4lOKxOnjQDjXtQxyeerhAU2G4HxKC6Me3RTIT16BYd6b+?=
 =?us-ascii?Q?4KjO9YLBotUy7hVeZrLE07mBQ75mhBYiW5CsAUz1gVyb2Oo5w47YySxlVCsE?=
 =?us-ascii?Q?23rdUNglsx0wHZmS8hFCq/qtus60Yh4aU6oofeT0qidhAXiFtywtVfoX9Lnj?=
 =?us-ascii?Q?VCfdCt9xupKbJjpFR7Urk0k7+jhCyRVFSbzFqg3TuFdISkYfMp62M/vdf+Vu?=
 =?us-ascii?Q?CElJn4P3n1FQRsUHbRXVliSaVd2V86IquTZPBA7KIBl8XOhJKS8xuakANmO2?=
 =?us-ascii?Q?1j9PHxuyRgEATO5bT3uDimzBOMl7KJKV2apRP+bU1bn+cH4IUdrAvLrZuvVJ?=
 =?us-ascii?Q?t6s/TwUFBhZoIM8SSMOqndq8fFiLfD+fURsYpFDp70/6LVV4MRjTnYH2p+Z5?=
 =?us-ascii?Q?a2nZ0JSYFY8bl/gsKG4KsbCU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9650ad20-02bb-4b3c-cd3f-08d930c68db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 12:59:18.7153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VP6xcGFFeqby5d1/EjRsxcxrVsrEFG8lNaZGdECij419JRQce/v18jFmyH+djgFfph4KBb37Bfm+rdv+zqSEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Let's just say add vega20 to ras quirk list.

Regards,
Hawking
-----Original Message-----
From: Stanley.Yang <Stanley.Yang@amd.com> 
Sent: Wednesday, June 16, 2021 20:31
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: force enable vega20 gaming sku gfx ras

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f404c2321a6a..ca5a32944242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2083,7 +2083,9 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 		return;
 
 	if (strnstr(ctx->vbios_version, "D16406",
-		    sizeof(ctx->vbios_version)))
+		    sizeof(ctx->vbios_version)) ||
+		strnstr(ctx->vbios_version, "D36002",
+			sizeof(ctx->vbios_version)))
 		adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__GFX);  }
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
