Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1E5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 06:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA291132BF;
	Wed,  1 Jun 2022 06:05:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D751132BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 06:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMIYdgJjhT5kT/4UU0r1q9mxsb3qyDsl7bOzgmdhoE9GISVGBik7UufG8N1BORLHpOw9q0AbJN/iWi0fdAlS0FMqx9heAqHHGb5o0V1VQLqY3YO0K/QHXJdcgc6uDWUBxUN3Jtz9Zmd5QminXM+wioOjQ3NpZwegp8rgjKDgObX61Q3ckrHBEfWuslNpjDn91UD9bae6dgKaZ2NiTz1tLXU67mhxFXievdlpEgnBCqc8v1oOR+nAMYENzLfzg4vKv+RNjRDVYa2xkrz9t2/PvJvIghQeOemLYUjLjNxk/WXiBDcrMqmZiHNRRlBzA7SuRZ1tNvHOfIoUVLZY9j0auA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wvk5JCpT9j3ORljiTfHn1mOyLkbQVw98a8lCzSTQt0=;
 b=mxK5bOUxJBKXVeytQurcktYXNX+bt0sgI5a/c6tHgG9Ii1771Kgp6PWmVp6fCr0nz6V9Ytjybal7cRaJ/dxkgYND91eCVrR8STbrUaBkTKkz4Nf4mG6DCcrloSCE9KKmVh6mMH7bJnq+qNy+AEhMMjZRkgCS4dh0jGyNsSiQ6KBI9O2GvdIEkmtKhuoaELp1kYa87Fm5OLqAFFwF2JvD7z9LJGISeBenCl25W38LUjmIILCH0kLVeGhwGYgC1KHHUWvfdq+mU+HAJtkN7cxKlzntloLuIDp8IAOvEkDNxcZcSkrcKJNvVWCkCPJ8m1mo/OcwuYyVA/qGJP3dzKTLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wvk5JCpT9j3ORljiTfHn1mOyLkbQVw98a8lCzSTQt0=;
 b=LtGdakJaRbGoQkAR+THuK5npzdede6HkAzH4y61NaqaVy/G5IFLKJJiadmW6ay6/LNJdJfIK2tPpKk3lclwpcHiJa64fLuKp/wOqblCla+zU4mbT9qCW0KQa+oCkky5/QyN/A49y0JWLJWGavVV50Gd1aPMNsyavwN3khEU05Y8=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by BN6PR1201MB2530.namprd12.prod.outlook.com (2603:10b6:404:b0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:05:52 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::304a:47a2:4630:b3cb]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::304a:47a2:4630:b3cb%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 06:05:52 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: Lyude Paul <lyude@redhat.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/3] Fix issues when unplung monitor under mst scenario
Thread-Topic: [PATCH 0/3] Fix issues when unplung monitor under mst scenario
Thread-Index: AQHYZFRiB1CPAWuAFUe65RMbMYAkKa05g0YAgACuV1A=
Date: Wed, 1 Jun 2022 06:05:52 +0000
Message-ID: <CO6PR12MB54890ABF59E8D1F70CAED645FCDF9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220510095701.57375-1-Wayne.Lin@amd.com>
 <a8c85afd8940ae8368e152d72d937d7046f65c8a.camel@redhat.com>
In-Reply-To: <a8c85afd8940ae8368e152d72d937d7046f65c8a.camel@redhat.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-01T06:05:47Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a3a27820-f5cf-4959-96dd-5a464d82ae52;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8601034d-02c1-453b-0c30-08da4394c8b5
x-ms-traffictypediagnostic: BN6PR1201MB2530:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB25308E79CA9A525FE1860872FCDF9@BN6PR1201MB2530.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5tRDM4WWTT+F9w7U7myGgu1JLOAqUN64J3cZYABKMz+i2E+II5wsQWdBD21cMyma8rSQ/qFdYgGGs2Jzunys6ZCiHf5/G9+kKeJ8k/f5/f4WTbRQ/nYNVtTc0gbzXNa6cfPY2e0iSQTrqTFrRw6JpSzBoz4t674L0YC7cx2juOIvugYjCIkWcniwfkg81KsmUR6Uz4xdgDqEXolFSAnkFifgtX4fzva57h2l/S2lQQ4x4kd0K7yWgxruZI+OsAuU9TDH46NXitorQqz9FxPv139d6rq8QD7EjxyM0DMaMtKAqLGCQUjBw+XHIK2X3WqAr3JJnBtm2fT4QxRloWil11KL5++dhhV3ao+qynhM/TTBhHz9Tuwk1XdrjQYqsryRd61849l/i38A6sTSXUk5zA4h9+4vynTNz6oqCIO5VDIz/PPt6XeKf3htgxnBednTIO4S80JLjdYYTjIEHg9QNBIlILCUXpM+6SSf4C0n/UMU4eyJaSjlKgObW7MMQUcOVGLEu3ctZlhjl2zIhiYxyYpvwFr6XFtZiwfS9iHfM/2oEVzh0XcimMIQI7EizoLlF1Vm41J6FxFjgdoCwnryvTcOOT0H6diOwAdqVI2tjhr6UTyEzrogxNAwc3b8fBJQdJnEevSF6cTLvf7ACYXiau1+tGlvahzyKL337jLHMX5bfTL5s0jzTF9tvXd/vPIGOpJeAv+oKi6ONaJQWpVzedWKn0mSjiBu0IwoYwm4oMtUf3GQrA5d0KxIWoJ9TOquA1ktmxCajymDgCY9z3hhqhSBcVQ+kO8GiKM8tzlQmQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(6506007)(9686003)(53546011)(7696005)(55016003)(86362001)(33656002)(71200400001)(54906003)(110136005)(83380400001)(38070700005)(26005)(38100700002)(66476007)(2906002)(8676002)(66946007)(76116006)(4326008)(66556008)(966005)(64756008)(66446008)(8936002)(186003)(5660300002)(45080400002)(508600001)(52536014)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SbUW0/VpwtMIFNRbqeLGjyMlaHMG1DLpkNsHPrsYDZK+xmOk7JDynjxK/e?=
 =?iso-8859-1?Q?s0pqQ0UqyWKshIoCFIvW099jth2A9A0wMfF4o+aKSe+JSMeuH7DQwK84S4?=
 =?iso-8859-1?Q?q5FzZx0Txg6TI6mIXsNCrunMqOwYF8wIZfbZmkZzOlbhBLwPgBUAlSefBm?=
 =?iso-8859-1?Q?GhA1S2IsYbOpBvM8ZZtMy1NjrqG0mw4zWTMw+yAJ1yuHA74xqDHWOwmr+8?=
 =?iso-8859-1?Q?Ypa0S9rgKzhnHv9rvBwSNGJvGy5XGEVAvrsDeBqueIobh8Hu/3oxhi+XKN?=
 =?iso-8859-1?Q?kvGu0IwPVMV9v7zk0a4YH+dtVxVmDiFSMQfR5SeNiy4f0Lf/pdMF7QTQ8f?=
 =?iso-8859-1?Q?uLof2NFCBGFEwp7TjDIHL9fwCXmVoc6BmsWr2sqhBFWWG15N5o2dN5aa/e?=
 =?iso-8859-1?Q?NvUGr/7U+wKpouk1VmN4+v60Qsgh8dNJmRAl7P059ZUFS+1ce0rpyqgiJJ?=
 =?iso-8859-1?Q?szHK27ZUWggzmfcv4MVmoyxH2EZQaJS59YIjsZPYibj9Cp9Z4jlVkbW+Tb?=
 =?iso-8859-1?Q?+THw3RBZ36U4Rc9BiS3i3WFU3Ib1OL9obZl1sDpr/A/4qKtPt7LcqY+UEH?=
 =?iso-8859-1?Q?Rzy7MxJonsw/W0sYvOfmqRnuej+YvuaOjnWJijlggkBn/cKAfL0JRnsoUA?=
 =?iso-8859-1?Q?jg8DMOtAJTY9QmyzTY50YXuYg9+UJ0ENPLu0dKIalR6Ex/i7KrZyR4vcCQ?=
 =?iso-8859-1?Q?7dEQ6lf26X8bUWVtCMQnF0O66QjzRjr4MvA292OozBzS6T0KC3d7xH+OzM?=
 =?iso-8859-1?Q?TFWlkTPGCrfV7L1aYrkNXogZlSnKn2eYX7DGEGj/UDc42TZt75p131utEw?=
 =?iso-8859-1?Q?aNE/9pU4Z5bZkeIEumfFTaqjtrMaHRexNFz/QFouJDK8jxD1XvcSKmqlm6?=
 =?iso-8859-1?Q?3UBOrx9zWfhiaa0fxJrlnDXoST2nfJNqHV8biK4ge5LNDYYZXFoPbc8/EN?=
 =?iso-8859-1?Q?3Udf2LkmpwarBrDk7CMCWOnHZStA3YLlns+YR+qkEKGWyn4dwfb2SZRO/p?=
 =?iso-8859-1?Q?/4VcAD00+RIdb1f7/b1DtvgDBqLu5/WBkkUQKsPWyGX9vo8ROj9JbBNHZ4?=
 =?iso-8859-1?Q?AgQYopCz1KNhvUs0QciwM0baUfEs1YM3nhuhe5ZRHE3Lw2VzYFvmiuFyKI?=
 =?iso-8859-1?Q?FH27AHJJhLgg7TPpBqNmpBW+p4au+RbvIqEiv9QkMib2MhalFhBTlGfzry?=
 =?iso-8859-1?Q?TWKS2peUFjJNRgbEyhyky3Y1QPHAXyXMCSQTwH/SUTm7kPZYY2HgHlkvN4?=
 =?iso-8859-1?Q?dqh3w8sqsX9aEa00Je5b5WhP3/O9fcusyaYyvtqg2MKxf1I/AXdpRUdA6T?=
 =?iso-8859-1?Q?9s4TNPQHhq9ZOVoaheEaErHw3b93XX9cWVPaGUOwtUV5Bof9OKp1k0rRqY?=
 =?iso-8859-1?Q?pWcLmeqQ3KlH0VJXq9DNJDluqWhWoFzcPQ60w2u0buDPrfLenYFQjRA2nJ?=
 =?iso-8859-1?Q?lgNeSSELQCQo+B/HntzjiAoZ5L14L3d6fnB+GynxaP50Rd7ITF0Jju3QSH?=
 =?iso-8859-1?Q?NG4Am5ULR9JIRcQDHkVH6gWvDx+aHtkqhQmEGVD/8f/UR267HxiN+PZDGN?=
 =?iso-8859-1?Q?ch8cXRjc2tqmxQehzV2geTDKNE8yFvUofOk+keCNlTT0lbwucvifysTDJB?=
 =?iso-8859-1?Q?QGiqLBizxqdgg+uEDfJwFTwrOWgZj0Z1Au10lp2ona+op2VvfyOk+hhBHA?=
 =?iso-8859-1?Q?xwrXmk1aQy0dRFe4Dzmp4BSwjXYuFyCOXy6zI0pj/oXixuDirXjQGGwqNW?=
 =?iso-8859-1?Q?hwq652i9/0p/LD4UyNZFoUrCuQFVZz/r3wMFi7rKeHFtM7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8601034d-02c1-453b-0c30-08da4394c8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 06:05:52.7562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZ/8EYyjdTObK+uZTAiRpdION2empW7yxrL5FHT/GC/eP+HO80AkRmhYLkRJgSTomsnS7gpSaKHNi53wHB7A7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2530
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
Cc: "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks for your time, Lyude : )

Regards,
Wayne

> -----Original Message-----
> From: Lyude Paul <lyude@redhat.com>
> Sent: Wednesday, June 1, 2022 3:38 AM
> To: Lin, Wayne <Wayne.Lin@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Siqueira,
> Rodrigo <Rodrigo.Siqueira@amd.com>
> Subject: Re: [PATCH 0/3] Fix issues when unplung monitor under mst
> scenario
>=20
> For the whole series:
>=20
> Acked-by: Lyude Paul <lyude@redhat.com>
>=20
> This looks a lot better for sure :)
>=20
> On Tue, 2022-05-10 at 17:56 +0800, Wayne Lin wrote:
> > This patch set is trying to resolve issues observed when unplug
> > monitors under mst scenario. Revert few commits which cause side
> > effects and seems no longer needed. And propose a patch to address the
> > issue discussed within the thread:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w.
> > mail-archive.com%2Fdri-
> devel%40lists.freedesktop.org%2Fmsg396300.html&
> >
> amp;data=3D05%7C01%7Cwayne.lin%40amd.com%7Ce9f99928cc0a4d2fd1cc08d
> a433d1
> >
> ce2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63789622700307
> 6525%7C
> >
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1h
> >
> aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DE75eUgMj3%2Fek
> MsLUjpzBCfU
> > Y45twQE5w44%2B2KyxzT6c%3D&amp;reserved=3D0
> >
> > ---
> >
> > Wayne Lin (3):
> > =A0 Revert "drm/amd/display: Add flag to detect dpms force off during H=
PD"
> > =A0 Revert "drm/amd/display: turn DPMS off on connector unplug"
> > =A0 drm/amd/display: Release remote dc_sink under mst scenario
> >
> > =A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 49
> > +++----------------
> > =A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |=A0 2 -
> > =A0.../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c=A0=A0=A0 | 16 ++----
> > =A0.../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 18 +------
> > =A0.../display/amdgpu_dm/amdgpu_dm_mst_types.c=A0=A0 | 39 +++++++++++++=
-
> -
> > =A0drivers/gpu/drm/amd/display/dc/core/dc.c=A0=A0=A0=A0=A0 | 13 -----
> > =A0drivers/gpu/drm/amd/display/dc/dc_stream.h=A0=A0=A0 |=A0 1 -
> > =A07 files changed, 46 insertions(+), 92 deletions(-)
> >
>=20
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
