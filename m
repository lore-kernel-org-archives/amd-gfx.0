Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E3CCD195
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Oct 2025 18:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6DB10ECD7;
	Fri, 17 Oct 2025 18:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rIrNKdhl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0634B10ECD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 18:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKdTjrTnh3oyUiPQalFjzUy+KdjBP+oetI2YJUEHnFgUkUIjBj1JuM2AbEFym/2dh/fqwRykjYWVVqHCgrxeMB8YD5A5dTKhXbXPYzJtD+mjPUQcDQ5qATizfPUxE4IQEAPTeVF6SeJf5Aa4WrFkxiBwkmK30+RAdoFPNvaQcuxlNliy6z2TXra8dj4ANvR0QTR0HtnGyS77JockPK3eKXAJKswfnHu9Xfw43WRbHfH8nQOJIpNoJwLj/boH0bORooJYgKBHAl7lAngrprUJvw8FaX3SlhOty4pAkr3Qsr4uZUhkzyq/bm6ZjTvkqvHOnhIU4VEQroqfOcRG2G8NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAu5p2+dfXx/P0s8NO3YIOi+xh5VBEjh+36VPjYUlLI=;
 b=UAUucDW/6YmS5rGT6REDVyemnn6yoTq167ZfZg1HVbtyN/F6E6pwtO8mPcm+yC+8ujAegxZ6OGPpL2xZY1EJ8GYKZZtSFii2g13mY6ujasjzVwTLAJQSn/a2Mzpk7yhqeooX5jnxZjCGDngabP9Um+bubgYuIQEKCBEqxOJ6XtY9dlW3zxt+Z08uza7kv9X9VScDolqKRJkxfnMXiWfTICorMPevDF6jLyahzeHLx9RBReN5k+320Jc0Gdxi7WZE3rMbhNNo/Sugqm/U5UALI/Y8mBpZaxLSwZ8cqy1BKVSb1ausRFCvf0WAbpO2HgrVlEvejmGaqxUJOdt6eQ8ufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAu5p2+dfXx/P0s8NO3YIOi+xh5VBEjh+36VPjYUlLI=;
 b=rIrNKdhlc1nBzRonMbhU0ZTVv599osgAG5UPGiU4xTZagHTl39tomtTDkcRZOaiP/W1vKzUX9h9ACbM7wJqpEZcCI8jhcH7laJmWspyizZ+vwFvxt/pj1Og0kLPTXK5Fap/Qj00A47aJRuvoBX2hoa9UgS5xWGYwtIjD1hS3Qfg=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 18:38:29 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 18:38:28 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Clement, Sunday" <Sunday.Clement@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Clement, Sunday" <Sunday.Clement@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Fix nullpointer dereference
Thread-Topic: [PATCH] drm/amdkfd: Fix nullpointer dereference
Thread-Index: AQHcP3L07dBhOJuIjkyCiC7rFJn1/LTGqJJw
Date: Fri, 17 Oct 2025 18:38:28 +0000
Message-ID: <CY8PR12MB7435B8B4D3B7F5A11E80600785F6A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251017143239.1483587-1-Sunday.Clement@amd.com>
In-Reply-To: <20251017143239.1483587-1-Sunday.Clement@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-17T18:27:54.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ0PR12MB8168:EE_
x-ms-office365-filtering-correlation-id: 0a210d83-a105-4041-aa04-08de0dac5d8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?J5GYzlPsl1zsA4kWa0tGGfsXvkkIHCef9mbAuS4dAigZsxDeplNp+1GTpTQL?=
 =?us-ascii?Q?FgJ6lZSUOrlElP6zNj6rpIMPlMMpOAUULwPKfWODm5QlLCH6jYXy2BW5jThn?=
 =?us-ascii?Q?5ikrhPV5hAzZS/Sdiv2t3Gc+emKTeChPOpG3cbvQMgRs6h3aMM9TVEk135qP?=
 =?us-ascii?Q?RD3AmPa4Ivsd42gfCeG5ZokwZdbieJDeqYphhcrPpB4Xi3Gll/dKcxh5YYpt?=
 =?us-ascii?Q?dcSMGdgRTrLxBvbJpxzL4NJG5ZRfTZnjD7n5q35PtdDV9RoFCjE22J635EAj?=
 =?us-ascii?Q?33aoR8r4QLMOLXMshMbnvRPmQ/2TY8lvkimdYJfOf1CbHajrT9c0+bJ0on3h?=
 =?us-ascii?Q?ea0sZORTdXXnimL1eqIKeYDB+F/MZ4XDCB/4zpP30aZUwOtWjnMmd7Q1svW0?=
 =?us-ascii?Q?mbF5g+yCLl/RVEYhGnuUqXAv+QeuOa17UIjl6VplKMOjQ5Cq180mWvezNDuk?=
 =?us-ascii?Q?eamJdm16UNghuuiPRZAjb6Wuz5zeNvcj4wwCMW9l+q3taYablIdnu0r80+xu?=
 =?us-ascii?Q?I1RfVMQTN3d3ibkCcSFY+3gFjqlyhYPcFf+a9cK+Zjano803aWFh59eeJmFb?=
 =?us-ascii?Q?VofX5IsXq8tME9NUMjw818LADRxSaH/OGvAOFfzBxnbGfXcDBgFycn7arKqk?=
 =?us-ascii?Q?eTRgQ4rOd/RJs3ccimEzKswpVfC2xN3IdlgSB+QQboR7sd68qN5hICxA8cuH?=
 =?us-ascii?Q?QNHJ60bLc8ms42RrNPYmZMdqPFyo3+iN9+rci31tecxP4bq2avnbPYXfmflX?=
 =?us-ascii?Q?4dwEGQfHBSuLrcTMv4huCZ1x0vL4mEXnRKmxdtrOaBzTFeKsrLhtaeP0pMaK?=
 =?us-ascii?Q?SZYSpi5MRoAapsCKudqt2xRtZApmZCzXgBQueImPDIhqQadM7/o9mIaTOKs0?=
 =?us-ascii?Q?OxeIe5HX/42B/mg7WrUaaRIj4P4oHdJQpx5spVmjyBwIcGykyDdznO8aagGm?=
 =?us-ascii?Q?ARoDWH9sB67riSVTsvXvYpIOHvxP1/NUBwe0zR1VoWrm4+Z7EkCjoqHheWBa?=
 =?us-ascii?Q?NSfcH002x9HHkriV+kXPF3ePLkq9NOBGTiSyLt1CQOSFQMSW1jsvaGhlgaIe?=
 =?us-ascii?Q?2mdX8leTElgUDdPgNoU6yMbIiBEmXR/CXREpiQth4xPol0G3x7wbDhka8f66?=
 =?us-ascii?Q?a/NMjnhNxlhQnXceCAoBuVfWdJUMJmufiss//B91aV97I81TBvFU/N/GlEOe?=
 =?us-ascii?Q?WoUR4X2fxUJMJcY5XKME0MPJPqZoI/gioHljU29KnIJf/mEAZY86IyKSbCwi?=
 =?us-ascii?Q?YZWkkfiQPtOufiVWCjsGIzRI7+eWze2UH0liFHQecjdOuCLlfW3j4wHy/wSA?=
 =?us-ascii?Q?hM818mdUl1Cr52KzHWiuQS00SWIs8kRpr+yCw2UsftyBV6X0bBCN/ePZsA84?=
 =?us-ascii?Q?FTB0y+5YOQuCOSUKiVyOXMnWLgyyC8gtFeHg+scoq5GrHu8w5AGgeq+xPg6T?=
 =?us-ascii?Q?Mzp83BgaLgXa71/bSZi/8JlfXDKZCqbU8jn6951EFXNG+aFHGjmxYHFC3VVb?=
 =?us-ascii?Q?nVAmT/aP0wo/XkxLzqtyrf+1shV5gQZ6UXUW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8tjJ4VwdPbmKtoPDRpA1EtcTNy83ZnQgnTcDNVE2AvApTXuc7JqkJfzj+/Vs?=
 =?us-ascii?Q?P1iT1Dv9+4hkMT5n38Q5MgOFy6afYDOI9tmZshXBZlJ/EN23L6DjzGQSkYmN?=
 =?us-ascii?Q?0SAKczOcvVENPnz3PMDhkCpbFmwXXONK/h5fLE+xs5xb/Fi536wccg7u4mJn?=
 =?us-ascii?Q?h3Totx0FjABw94OpMf2CxckcX2TgTxtJUg12y6UiUUpELFBpA6nw2RU7S3Gu?=
 =?us-ascii?Q?ZqFoDiVgvAZz7pvZc+ScK9CRegUYb+LM9xkdG4d54i8U0OKdWxoP3zbXoLKT?=
 =?us-ascii?Q?UthPz3jRBZ3FijqFDxeqBL2ikqbf3ZGGFie7k3/VREPyhnMDo+vFwdNbRmv1?=
 =?us-ascii?Q?WsR9lvxF1G3ApB/arUc6yKMvHVqG2u01PuD4zLCJE8+WCQrBLEes1RY9ZFMP?=
 =?us-ascii?Q?vpomUD8OYSZMq8TtcX/+gTIolsQpITPBrC0t1OriRWT74kMKyXREJfNw88AU?=
 =?us-ascii?Q?O0KNAk8hv2VqnzzVZMa9cwIi+5SieqgNqM0e9TVrjlkRt6+VX01W19pP6/pF?=
 =?us-ascii?Q?fzxm9Zc3pmmRjIbN2eV3vub6zNZL84nfv0F3n4rskhZoDSzllxmN6zWk4TqN?=
 =?us-ascii?Q?ltZmLtM+NGu2NTioT1se8E0tJmi2wp5cNyHF+TsYgoMYniv2rsRkrA4ODkI/?=
 =?us-ascii?Q?AsNgZyr0d+nylQ3IMuTRBGKcDnk2xDjv15s0NXfDecluJ8Zv9YkrSINXAjJp?=
 =?us-ascii?Q?f/ZffEW6Qx3FowLP0s+Ob6/x8zmJ6Rj/jr5nTf/ME/Idwa/+eJPhSS3PYzJ2?=
 =?us-ascii?Q?ESeEpWNpFEg/k3p0QT+8Ygo1KQL2aU1jrXMoy/EVe1+M8fNHzpV8IYkk1sgz?=
 =?us-ascii?Q?l94I33W9rTAh+ydANXRfnyd8u5AZ0krHKs0/rpiR8Z56AuDH867fV5NOGbIv?=
 =?us-ascii?Q?erxNhqnTbXxHae6UzBLYZxyiaPLlUzy52FeJeSqCnUSIfEQhlJjNjKbOq27p?=
 =?us-ascii?Q?ejRKU6EFW/oniewpZX9bO2AdrtsrEjmlz/xsm9Lw/axpz6NBwW6+GPU5tByA?=
 =?us-ascii?Q?CmAKc2AR4bRUZla9RoMQIkD5rnVf+0NOE5rxI2m0qsR3QJhFGPAvEo575I9K?=
 =?us-ascii?Q?3vwNOklYdlED4GPW7sFboRyMAEkIPQqS1j5ohkiSddNorTELF+6teAO9vzXA?=
 =?us-ascii?Q?W9/f9hCorXudH3qiUEv+fpwiPAAEfCX9HyTTXgNENBauJDMy3Tg7VFAXp+hM?=
 =?us-ascii?Q?diUocbfraP5dHyocg3zru7clcu9luD3bAaAbpbf/3qrsjdZ04g/hedhJ1UYg?=
 =?us-ascii?Q?bBlkGLYCy85iQhQUmOE2W9Mx5C7pHZJqTnePD8x2c3TIU6jTKP/OdJ08b878?=
 =?us-ascii?Q?QDngY3H6/Aru/zJRvFwn0PMvsN3bIglSyTfdahpGqPR9KdsqC3B3qS9b6UXF?=
 =?us-ascii?Q?VDk0zTMySMMTeNo1ir+JY1bROmi3ojn5SFdAuCpgH6qxof+IEgJVLou7uYRZ?=
 =?us-ascii?Q?eXSb7Phm3svXSmncGyElW4dIC8rfWj59OgchiI6a9PGygpcSpq7r3Wh1cmy1?=
 =?us-ascii?Q?qYP4qh1N4cKv4A7RaYOIz02HbSsYTqLpZklp6a4s3C5MnNgleAbY0ICprvDY?=
 =?us-ascii?Q?tqS34g2w49GsGHR/R30=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a210d83-a105-4041-aa04-08de0dac5d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 18:38:28.8363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzqszGT9JQOAM0CXeTCs01tAfPV+bUkykBLA45g2qU2EdQFa2kSb2x/jfj5wXqXQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sunday
> Clement
> Sent: Friday, October 17, 2025 10:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kuehling,
> Felix <Felix.Kuehling@amd.com>; Clement, Sunday <Sunday.Clement@amd.com>
> Subject: [PATCH] drm/amdkfd: Fix nullpointer dereference
>
> In the event no device is found with the given proximity domain and
> kfd_topology_device_by_proximity_domain_no_lock() returns a null device
> immediately checking !peer_Dev->gpu will result in a null pointer
> dereference.
>
> Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 4a7180b46b71..6093d96c5892 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2357,7 +2357,7 @@ static int kfd_create_vcrat_image_gpu(void
> *pcrat_image,
>       if (kdev->kfd->hive_id) {
>               for (nid =3D 0; nid < proximity_domain; ++nid) {
>                       peer_dev =3D
> kfd_topology_device_by_proximity_domain_no_lock(nid);
> -                     if (!peer_dev->gpu)
> +                     if (!peer_dev || !peer_dev->gpu)

Is this a real failure?
If so, we should figure out why our assumption that proximity domain ids as=
 a counter for valid devices should work but actually don't.
Either way, probably better to throw an error (something like -ENODEV) rath=
er than continue since IO link data has now been assigned garbage and we pr=
obably don't want to keep building the hive at this point.

Jon

>                               continue;
>                       if (peer_dev->gpu->kfd->hive_id !=3D kdev->kfd->hiv=
e_id)
>                               continue;
> --
> 2.43.0

