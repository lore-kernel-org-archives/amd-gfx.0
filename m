Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45282C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB136E0B6;
	Wed,  8 Dec 2021 06:46:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0DB6E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMrIO1wM73rl4hhqda3rp8yEmC86EgH19kns17ekqH6m2EkNlESQUAxYjhBs/7On7k231NlSy5h3Ou0qfoXea5j/Tjan0qTYujloyuz9qBnv65QhVmowenec7DWiHExb5/LFnxR4lSGjVjDt6ZeYqBF5Dquhm6s1sY6OxzdSYFqttePFjoOXDmj+9R09FC8i2PTV5E2N7ThY3RSHsIDSbn6B6ppwOnZyuyj1pCj4xRrkrMzW/USvpo3lZu+ManShAEd0VYr1YDSbW2Kg4Cm5WKn6dXPuVXZRVeI2Nh8jx2H7WO63xp5nfxjWAhE5ZIeRPwXATZOnCmua2u9oWvRrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1YI60A5qTDQM1r9hZeKpZQeQCysGFA5pPjAk/iIKko=;
 b=l+ADwgCq5Ze80KJ+D3/Slxc57qCjutbgSy+pTTzGqjHRFJ+CzZoXVxlv0vLNZAxo2YUrBFLA6xEjHAdXTOGN3BHcDZgvdRrbKB+2YniIL+Wew0pe8RXqNwjVX/3z5auBAOrRGHxnawkYZTDHim/5Zt8DE9BuoN0w4m78J+5KAaEJN346vsK/imfxGAjGVb7ThkMKn26zsUmPYn1YpblPAmxtGNPlglCn8/L87QHHAd+j/IWtEjt8N6H3PYI/BAw4A4hoPXyNnXrRHPBtx7RdVGtmLzTA8uMee3er5F+1rPABE/q0Ac9SBm+Cv/dAmfPD2ZnQV472lAtwCSAlZtkRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1YI60A5qTDQM1r9hZeKpZQeQCysGFA5pPjAk/iIKko=;
 b=PLP9Ao0nDEejJb0MacywR5tVUwqYf5stEuZ7DuMbRtTbF5yqmDWdY68UlO219HE04Hak9Uxp4U2wnM3a261RiMamerWJnb60MkafeLrli6+lpc70wBV/+/KVl41odepX1goxuj/1h6pTEODgfzKxC/mldEJaEkZ3/qO1gDby0qA=
Received: from PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20)
 by PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Wed, 8 Dec
 2021 06:46:40 +0000
Received: from PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::acef:ade2:769c:1685]) by PH0PR12MB5451.namprd12.prod.outlook.com
 ([fe80::acef:ade2:769c:1685%5]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 06:46:40 +0000
From: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Topic: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Index: AQHX6/u0j1lM45rI5EGmPOQUsOZt06woJl7A
Date: Wed, 8 Dec 2021 06:46:39 +0000
Message-ID: <PH0PR12MB5451A2FD1BB367183E3EBA78986F9@PH0PR12MB5451.namprd12.prod.outlook.com>
References: <20211208062020.6445-1-tao.zhou1@amd.com>
In-Reply-To: <20211208062020.6445-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T06:46:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c138d4a8-7fbe-4039-a37f-118cf9372bb5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-08T06:46:35Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f7d2e513-89f1-42f0-8b49-0379a4be9d45
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78a2b883-30c2-473a-8493-08d9ba167d4b
x-ms-traffictypediagnostic: PH0PR12MB5434:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54348DD25801A0CF362D5F50986F9@PH0PR12MB5434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: et7GCKkrt26eA0i+3/XCSBYxcqeuVwxDoMlzeqYWN2nq7b2PRodpPzW+r9drJOhpLXT3XdzHQbV/pSzmDg3pakm/VE/fy4ewgFCsMXpqGvSQ6jvLBhe6Xf4LbN5YdtVYOwX4mGTUh48h6MbSovH6XCtia3vdhxbmJSi1cIIulo2Bk3hNhB6Nrel0TyA3V+6uUqYhSCKz0evi27x6G8ubpA8fo816C9Tk+3QpOYdCevIsOhkn0IUNPDWCCH4uLVGpUWAfGS6ecbD5L3Yr5m77rTSd8Njndo993GNXtpYaVFIYE4EV/kYTUDL20/Xxw5R9d4lkZKZ9U49kzp2rvQOnev2bRfLU+4akSoSdm8SCVgWhIvSzALt0QGHO5sSIaJSyOo9C6ukO0fjLND/3cwErvyqYzypSmQ28bLxZlkTpta9BToWtPZB4DBAly9naFwcEikGIIHbqckiwt9pPBdYVtaucqjoiWP31zgZFs4beD+H8100QCo7iWJfWvZgDVa/ZRn4a2OwZ8OSEFmp2RCWsgfpI5QMSQfwA+AahvULsoD/Eq+CR6L3/h3nd5ViCPo19lcd7XCU3QEoe5ibAK3tL9qjvJAwOsXD0QkCAbJKttzyMMNMFSKU74GiH9JhbbBY/dFCbXudgN628guW28ckhTJw50Hof1BWCnOvv34liMrqe5kZjxVdKpk6ejyUBbyZYx7sckHEPBi/fkGh1bE1TkA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5451.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(55016003)(9686003)(66446008)(8936002)(66556008)(6506007)(66946007)(64756008)(71200400001)(38100700002)(2906002)(52536014)(508600001)(55236004)(38070700005)(6636002)(122000001)(5660300002)(86362001)(83380400001)(76116006)(8676002)(26005)(316002)(110136005)(186003)(33656002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dzN1x8HYJAVs9RrT7U82t3xS0uGzr6OUzK6yvBH+M3PMHI4G2r+dGGh8aY/J?=
 =?us-ascii?Q?SAcxKJ3SsVs/qulJ8RRgmUZ9K2PTcApt2P+ntxwgoLQrGWol7Mh2S75Hzzsy?=
 =?us-ascii?Q?Pnw3rzJVhxSFliD9Bcp8hGkSsJ5SHqG/Gs5Ocn4oHPaLXynuNdCTs+WZlgit?=
 =?us-ascii?Q?97EeEYDgJz43ajV4KK6tv/HbvDdxOtBK/YCrv+fqGzP4RWHVoUDALJ5RJxTv?=
 =?us-ascii?Q?QLTav02hHW+mWIGWTL5i1M2ee0hQEjox+wNhZvpVuohFOT11uosKsXXSnsIw?=
 =?us-ascii?Q?ELwcseMR5my2rkV8APTDO4VbvIH6CNVGSVL4XyzepjFRRFnrHKDW0Tfp3wf6?=
 =?us-ascii?Q?xN87bFvrQrodysroRQk4fCat5ZsKF1ZpvM2c4HYoF0xlB92ZUgYoFyxKeH/j?=
 =?us-ascii?Q?ASqKWdf07tWCe5VZyCR5AKDw8LLJ2m/Ds62IZ8EobqXiPS5P4OTCF8qICIsH?=
 =?us-ascii?Q?IO61cobQyg/RHgM3+k09oYuaGlpRU2Veszj1wZU5YI12c57tefKsmF+XtzB2?=
 =?us-ascii?Q?H3iSyygUTe58Z2wi//u/OBbTzuUeZISeWwS0JqFnCui15Hyd9qpQ0aIUEMUl?=
 =?us-ascii?Q?VbAMmJfLIQ9TdVPo6f+Kj1DF/EnwqVX9JjDRC02XPGULcguOmDDvMyHkfZ4/?=
 =?us-ascii?Q?rkEOl+Z/9RYDwcu+cL5sioZfnNA2D0d9B1/TpZp3Is4PgKUWMG18uTzSsKl+?=
 =?us-ascii?Q?KIvdhJvN8G/YlsQ9jQOp26pf75e4QokTRGYlRSO7TE6keWhF2mnsienYNYDP?=
 =?us-ascii?Q?zV0uT3kXYxkw9M9okVC1vrJRQrltzMTZIb1wOkkDs4F0iyHgQhJHB4+6AVGL?=
 =?us-ascii?Q?8g11HR+Jkn9lWn7SUv56ssHdccFzWks4orIq2uvrCmzDZfgUX2o7JQeFrmzV?=
 =?us-ascii?Q?H3xCFQQTqgG3ZrE2lcM/iMgO/YEsmiUyMhSRmuRIrvGQJ6/1ULONjqjazOYL?=
 =?us-ascii?Q?3NkP9HJRLRwA+ImipiXeG84W5lFBk3FqIzQDk+oQDkI/9JMc3vci0dNiGCtq?=
 =?us-ascii?Q?55/ZnHkdIy4xkchv3Ju3Bs1uscsWVTdEhNSzVLyzshg0o5/gZC6pGH60PnSX?=
 =?us-ascii?Q?ANwgAc7kFLxRtfXFRuVaNlAn4Sn4ZEfldQcdZYy/vwvq6uOjgtwC4bsTXfYf?=
 =?us-ascii?Q?PHBbAwkrNzPgL5m5+7QsabJJFAXaTpiSgVj9BrFa6ys+MQ92ZbDmsctRS+5N?=
 =?us-ascii?Q?f6bV4uJbVlWh30VXYFaQhQR3MbvZo+EHeJfu5LxxNkkuVPgLmlLxglh2zdUs?=
 =?us-ascii?Q?Fo704GxzQvIvMu3QEVff3ydByW8LN2LLxMvtFT6uAGjdca8V2ZXA9YjHhcRv?=
 =?us-ascii?Q?DLdjFhGTRHBH2d3wVQYkqDwFCW/b2pBIWp35SYc3HCjkTH423H0G0VsVxoiw?=
 =?us-ascii?Q?XLySrwB4pQTmsfL87wmfJpKSZeoGUybxQY3g1GK0lhwfdIxoRdfVsIsJ0PT9?=
 =?us-ascii?Q?xTDdoLRP5kZ7w3irNbgttNwHa34iUnWqpjpaDJhTxyPlqQy7EWFDNXoSZ+cJ?=
 =?us-ascii?Q?9Bg7gdOTslfHOWa3SSwR6I640IMkUeIEYH3ZbuWbLb7XoESRWUV4EZKv/Ha4?=
 =?us-ascii?Q?BHud1hftXF3Q2CdSyHY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5451.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a2b883-30c2-473a-8493-08d9ba167d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 06:46:40.3017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1V1aQn6bqmWACs0Mwra/vnA26XrsnBywpKekUNhP3txIlA1AiNhO0h+KUYE8CUL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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

[AMD Official Use Only]



>-----Original Message-----
>From: Zhou1, Tao <Tao.Zhou1@amd.com>
>Sent: Wednesday, December 8, 2021 11:50 AM
>To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
><Hawking.Zhang@amd.com>; Ziya, Mohammad zafar
><Mohammadzafar.Ziya@amd.com>
>Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
>Subject: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is
>connected to CPU
>
>The RAS poison mode is enabled by default on the platform.
>
>Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>index a95d200adff9..0003f2c64da8 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>@@ -2372,7 +2372,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
> 	}
>
> 	/* Init poison supported flag, the default value is false */
>-	if (adev->df.funcs &&
>+	if (adev->gmc.xgmi.connected_to_cpu) {

Why not considering PCIe interface connected device by default? PCIe interf=
ace connected device will not see this issue?

>+		/* enabled by default when GPU is connected to CPU */
>+		con->poison_supported =3D true;
>+	}
>+	else if (adev->df.funcs &&
> 	    adev->df.funcs->query_ras_poison_mode &&
> 	    adev->umc.ras_funcs &&
> 	    adev->umc.ras_funcs->query_ras_poison_mode) {
>--
>2.17.1
