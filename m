Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83384C3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235D110E2C0;
	Mon, 12 May 2025 06:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FVHrw6lq";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7478410E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:39:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2ImgNuJvTVyOEGOkBgARvEoLyLnHGa3Kg2SU/DEOtkZdLXazjCFgNM2+VLa+6dzSn5GYtm1pV3b4CDAn2aTchq7ABqsM7beXDCWWyPc9wJasqojokzlu3kN0Sx9nsAxOoQlD1jauvCz72f7ENTqsV7ueRjsGxu64dmtDZDfhrRCWOAbnOstDHzfn/KWhM89PXToRSrKa8Nv0pOa3bdahQlY0y1bg3XTPtf+xB5q9qJvEpiyykFzGzKp6/yu2mqfQ7pg+e5XE0AA14lWkdR5riOAEd7/LW50ja0dt4VQy/HnK7LfXiyj9wlu5QNk06KqdKpZuSq+ynqvks2BRAEVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvWeU30rW/nOQCBJ5fuSZ4aegs/uSJ2Y75oQPR286XE=;
 b=uvX4PLxD63iDCJ/qHT6wSU8SKNjvgH41g1QHqxKrhXcWDtTh3CNbUQeHcphSFVqAJiSOT0M2pekJ4PpB+TB33849tjy1UTcKN22A+QYt2S635T4oykOVekymZypy8sHah+ZKQruSGU4QI9aKdsX+JUIUl/qjnpJXViPiawY5p3Xgf8mttIJIpQKs6j88zmKTfrlfsYmb82VjTfuTCc/oiWQgb1XYXPq1b/XSXX3z2MJt/D/brle6ufzvscMBvPQER8JSigHNtj8WDNw+SuQydRr/5hVHGAPO+jgoGW+q2C7pUTr4AkPNu4cU8OvaXYmdn1EckYA/cqAkUFDc5WYNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvWeU30rW/nOQCBJ5fuSZ4aegs/uSJ2Y75oQPR286XE=;
 b=FVHrw6lqyDJ+mAlyKukPVmfI26ZFoNfejN9NZGB4euz3y4+wMJX7F0pGqS/Ek9pABUuWoULO8XoGJcxxLeFV5YpfVSDJHOsbR1bD1NGJ0cICg/dXFdF88EwGVLZuv9kMvO6hc/rKzZu5BgEuV77NCBAywIxAI43MKcpWhdjMlqg=
Received: from PH0PR12MB8773.namprd12.prod.outlook.com (2603:10b6:510:28d::18)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 06:39:14 +0000
Received: from PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296]) by PH0PR12MB8773.namprd12.prod.outlook.com
 ([fe80::47a4:8efb:3dca:c296%2]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:39:13 +0000
From: "Zhang, Morris" <Shiwu.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Topic: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Index: AQHbvwp3+7tl5Bq+w0qYOyfDvO+3+bPIea6ggAFc+4CABLTIgA==
Date: Mon, 12 May 2025 06:39:13 +0000
Message-ID: <PH0PR12MB87734DD27DEE9922EA0D4CCDF997A@PH0PR12MB8773.namprd12.prod.outlook.com>
References: <20250507044159.1006093-1-shiwu.zhang@amd.com>
 <PH0PR12MB8773D3ADD8CD6D40D46D7127F98BA@PH0PR12MB8773.namprd12.prod.outlook.com>
 <BN9PR12MB525754FD1CB54E142B15AD05FC8AA@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525754FD1CB54E142B15AD05FC8AA@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1edc1c76-3d9b-40da-b3cd-3400b86ebdb6;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T09:30:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB8773:EE_|PH8PR12MB6914:EE_
x-ms-office365-filtering-correlation-id: 189ffe7c-a3c2-4a26-31b9-08dd911fb5d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ySPqRBRbkIcIzcVbI5ps4E6/tZgDtPgxHiYcE0sWiRUFFaH8fWi4i+rWyklb?=
 =?us-ascii?Q?ddaWZmO9SJHdCinoijvSfb61HhbyE9pl2JaoRoIznhZnEEeLEKk9XbY660wv?=
 =?us-ascii?Q?H+0BHF5sqzKGVm0RpBLJY8TLEJmGUqsPT9xsMrBS8OyGfKLq6J/Ah4C0QqWR?=
 =?us-ascii?Q?TLMtiRGtCBsL0ny3YqLknd6fOo039EeoIjpVJ823624InFhhZNjVEd+MMeWR?=
 =?us-ascii?Q?OciWeSqXofZpgpHtA9zR6CPkT4bw9Q8eKqeM3xuffUmmGX5vxm2o7XRxX/fr?=
 =?us-ascii?Q?Zn90IUalzzgo/Q1HGrBxhvxyWTtZ2rtiDdVxOWxZiepSHRI+HGBTW6QRTTag?=
 =?us-ascii?Q?EN7Xxqg+TgTUvwLA38GmqAudQOr8KZDS47fQBqfmMWSb6pCnzFn7aauAJAYg?=
 =?us-ascii?Q?ukiGrP57vHCjv5RiljDrV9O+OJEOixKjliIg2bkqax+aBvmJWV88iNkPF5az?=
 =?us-ascii?Q?s5idvnmYW3MSYUyeql9P8lEXuVLux/+VxT4efi6p3VY/rlouvgtTN5fNqZQI?=
 =?us-ascii?Q?DghYvQimYskNvnXSsXfGonmmJucywhA+jjfT/MiyIfCGITtLP7vD3UbAK0Lw?=
 =?us-ascii?Q?4KdmCGE2JMi3GWyDhrxdLXD6ipUio7vxnlNJyuu1/kajxEkrOBi4tUCOwDkM?=
 =?us-ascii?Q?hcD6+EtFs8S/y+4SMfEy10C8+JRLjTR/NR0Nnezw+b6dS9bn+L/Imc3WFYc3?=
 =?us-ascii?Q?IgtKqdEFuqMvJKuzpOa7JpWdTAcPscpbCQSq9GT7xiOt2eccMamtr/nu3ihh?=
 =?us-ascii?Q?Po9iFQtz3/oEdMndO2JyDHsJ4AedTGVcDQebCCvGHoTtHmQ5ZG4pEFf75RDk?=
 =?us-ascii?Q?bb/lYylsdT/9zQKbQ1/tt7BEkxChdTGL/zz+IL+OPZK1oBEki4+vl9L73rg7?=
 =?us-ascii?Q?kYgZCBaV4HAeMhSmvghLMWuWArMNESSAJpsWvKbfyUDmNxAQWGYVnml+VIYM?=
 =?us-ascii?Q?TGOSKOze/o4AQ7iH96g+OI23wy1zn9UB0Ia+QareIB2IZVxBsxhI3AQB0Is3?=
 =?us-ascii?Q?zZSQ2V934aLnZh1yRF5cv6BSt7vdUKgpZBuYz52t02IsBR1FbYXkVa+Tt8Ep?=
 =?us-ascii?Q?F7iQNCQnz/GGxh15zcYXYy1iTFwcp7z4MD7O7xGxaF3zI52BbOaYJeaN5ZtM?=
 =?us-ascii?Q?9cDjgR7oUj6jTNbjgFR25TN7bCHZHeiblDvxUPNj2Bk+wHA2FAvCylQwEg79?=
 =?us-ascii?Q?ojEGar2gSPCKr+PgjHSujQDGX8TcQgmVvZBljZrUm93/b449cbh6PbXbMR9J?=
 =?us-ascii?Q?NGkMLERWmYmpnXQicfkgrw8oOBF9IkaVewpD7wlTMU1awpLYwVolrBUYB3T0?=
 =?us-ascii?Q?OcjWMmV+zILvLEzr7v6wwa86mA8ygN/8CaSnEV4a44yXdkm4ab4EZpIV1uvn?=
 =?us-ascii?Q?demX1yA356rlLEcrEiQober15fZsrXo0CnOkuc6gDNxbCD2Li7n5j6xtc0+P?=
 =?us-ascii?Q?6XhdQZmVfSAUmsyzKq3mnwJyFRwug0pHD3gwYvkKDwwwk/hXCxmncaGGDPtw?=
 =?us-ascii?Q?WOkfb0F/PsrXiZg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB8773.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?shGhPcG8yJ8dD/M6D149NwQVbsuu2P2+46ErO1Ot0PKvLbxnAWwT4C8UFz8r?=
 =?us-ascii?Q?bueFAFBd4wSsNzVJGqaROjPsKcYLuC86N1bCCQXCQw3GZz7Pd6S1RLeXMLF/?=
 =?us-ascii?Q?MxWgNbc1E/JIp1kPZZFasH/eUV71mYsGvFBgYcMGXQUckEi/huv1R9Ahlnu2?=
 =?us-ascii?Q?CXyk4fIso9/3EFQesYkTsmSio4kw7ApiYTb7ZVVcsctLRhEJn70Ei73Any/t?=
 =?us-ascii?Q?zI5VQL+ZsjzjmnlfX2ljMnV6S3fkY9PceOPiZmiZhDVpDqSoWGeinKSy5ZBP?=
 =?us-ascii?Q?Ywi/5BHt881HAZ39ud0BkJC/smpCi3rT8hkN9uPGGCtTd4QZMEZe3hj7mBji?=
 =?us-ascii?Q?ZfDsBH9/6i4wipjEJBX3xUtAgAXbOrKqqt2duEjHgTziY+zjnR5nlg+rPTK2?=
 =?us-ascii?Q?oomI8mqO7QN8mP7miZG5kOXco5xBkMqU6Bb9PL9Ln2I3vU5mlV4K/LNIYkyC?=
 =?us-ascii?Q?flUVZxaZ2b3/xtcJhbzNfa73KBFgFWAffr6FaO1mWK5oxEFhQ84CuZW2FgIT?=
 =?us-ascii?Q?22QsRUwZC7FYCZ9N935G/HzUtmYr652sw4djJDayLPS9yicXQKMogR/KJEU0?=
 =?us-ascii?Q?LMpVzxCXvwnRefhexHRzA/QEpDn8BPpFSpzYhm9keLNHi9g2lu5jYsef9GUs?=
 =?us-ascii?Q?ih6Jsa/kt7d/vk5YFLfYRFSuQUqA2FBMc/h1Oa/KebHXzr0zwHLBltCIBBJz?=
 =?us-ascii?Q?GIjwy0kfQl0AK2HPmKW4fUE3UYOfwL8SkNHOBgEZPrRUhqeO/8vzwxM+rysa?=
 =?us-ascii?Q?q13f3AjRsbRLmL5JxHsZHMvV8uZPMDcIX/BQ3H92EPNEACuhE97xRUoyDsWZ?=
 =?us-ascii?Q?qOFUiZ5yTOXufv7mVmMkeWX4DZoVcLZ+2L69rKheBHPE9Deb79+ez4hupohr?=
 =?us-ascii?Q?fRf0IYhQlRab6KzTId4Kl6J4xe0eW0vvtmqbSMEb/eEGksZEq2CloX8PrHow?=
 =?us-ascii?Q?2RsC6EvJP3yJoWHLta0kk9YqageJcVdpNqD7QdD5LbkCRkhEQ0xJRVVBT4wB?=
 =?us-ascii?Q?TZsdR8Jife4zLlK2Y56y6IOI6XbKRe2q+8kabhnOsvmAS/xc6tRn67VE45ky?=
 =?us-ascii?Q?ZKLBm3jn9ra0jyI44Cr14WXMq0LmB410/bdg4MEx0IsyqXBduK8/whIbTMWP?=
 =?us-ascii?Q?IFy/2fyuZu4cCt5X5uvp6xaGiFYh64YQVMaC7CeFsYgmhUOFvfzaYpD8TiXr?=
 =?us-ascii?Q?UGa7dBj8CLo8aDd7eDVI+lk3QZBaSdLyyNxR/SIbEgh2f6vOkH28LJRCKRkI?=
 =?us-ascii?Q?T70K3dvZFVP/tMp/+L08P06+AdUwzTzfasspWISAmniPlFZ69eLtB+kjjbvN?=
 =?us-ascii?Q?kjdIK+MN8LE/0JF4i/xO9O7VCBxfvz0NqYpHmUdALI219cOqcXCHs4y+xdti?=
 =?us-ascii?Q?pDjE2TA3c+UQGBaXyyl3t3FyyxGfBCT6vCru04sc3IKlM4Ts8VhvDmJFR3Eo?=
 =?us-ascii?Q?t8mp6jbCrdFHr0DEXB+7+JstwYT7uyQ6dDpUG4FILoCozHYDKgYSMQq6m732?=
 =?us-ascii?Q?/BUsR0pjJ0dnZQZkVDdR9graifLeflV3I5QDt05gqWncjZfm7DgDDbyC7RSu?=
 =?us-ascii?Q?Qhalk2YMZk/t2GkKdRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189ffe7c-a3c2-4a26-31b9-08dd911fb5d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 06:39:13.7094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMNI/ysgEoWqjxyp8L230NR7NpeGv5WvTqH4eWalAlGK9JS+e7GzneOT4zaFFZ//426Flfoho9C5i4HDawJ41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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

Hi hawking,
thanks for taking your time reviewing. simple_read_from_buffer() is just a =
linux wrapper around copy_to_user() and it handles the reading count and bu=
ffer position checking well so it can clean up the code a little bit. FYI.

And the one-time handshake with psp is put into the .open() for 1. Normally=
 user will call syscall open() only once but can call the read() multi time=
s and 2. The mutex operations include buffer allocation and handshake can b=
e put into one place so that the .read() and .release() can eliminate the n=
eed to request the mutex. Thanks!


> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Friday, May 9, 2025 2:20 PM
> To: Zhang, Morris <Shiwu.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>;
> amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Morris,
>
> I will review the change later today. At first glance, it seems that some
> implementations are not included in the patch. For example, I couldn't fi=
nd the
> implementation of simple_read_from_buffer. Did I miss something?
>
> +       return simple_read_from_buffer(buf,
> +                                      size,
> +                                      pos, bo_triplet->cpu_addr,
> +                                      AMD_VBIOS_FILE_MAX_SIZE_B * 2); }
>
> Regards,
> Hawking
> -----Original Message-----
> From: Zhang, Morris <Shiwu.Zhang@amd.com>
> Sent: Thursday, May 8, 2025 17:34
> To: Zhang, Morris <Shiwu.Zhang@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping. Thanks!
>
> --Brs,
> Morris Zhang
> MLSE Linux  ML SRDC
> Ext. 25147
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Shiwu Zhang
> > Sent: Wednesday, May 7, 2025 12:42 PM
> > To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun
> > <Likun.Gao@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: [PATCH] drm/amdgpu: add debugfs for spirom IFWI dump
> >
> > Expose the debugfs file node for user space to dump the IFWI image on s=
pirom.
> >
> > For one transaction between PSP and host, it will read out the images
> > on both active and inactive partitions so a buffer with two times the
> > size of maximum IFWI image (currently 16MByte) is needed.
> >
> > Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  17 ++++
> >  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  40 +++++++-
> >  4 files changed, 161 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 4835123c99f3..bfa3b1519d4c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)
> >       amdgpu_rap_debugfs_init(adev);
> >       amdgpu_securedisplay_debugfs_init(adev);
> >       amdgpu_fw_attestation_debugfs_init(adev);
> > +     amdgpu_psp_debugfs_init(adev);
> >
> >       debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
> >                           &amdgpu_evict_vram_fops); diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 6f9bcffda875..210a7bdda332 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -4185,6 +4185,110 @@ const struct attribute_group
> > amdgpu_flash_attr_group =3D {
> >       .is_visible =3D amdgpu_flash_attr_is_visible,  };
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +static int psp_read_spirom_debugfs_open(struct inode *inode, struct
> > +file *filp) {
> > +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +     struct bo_address_triplet *bo_triplet;
> > +     int ret;
> > +
> > +     /* serialize the open() file calling */
> > +     if (!mutex_trylock(&adev->psp.mutex))
> > +             return -EBUSY;
> > +
> > +     /*
> > +      * make sure only one userpace process is alive for dumping so th=
at
> > +      * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is
> > consumed.
> > +      * let's say the case where one process try opening the file whil=
e
> > +      * another one has proceeded to read or release. In this way, eli=
minate
> > +      * the use of mutex for read() or release() callback as well.
> > +      */
> > +     if (adev->psp.spirom_dump_trip) {
> > +             mutex_unlock(&adev->psp.mutex);
> > +             return -EBUSY;
> > +     }
> > +
> > +     bo_triplet =3D kzalloc(sizeof(struct bo_address_triplet), GFP_KER=
NEL);
> > +     if (!bo_triplet) {
> > +             mutex_unlock(&adev->psp.mutex);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret =3D amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B *=
 2,
> > +                                     AMDGPU_GPU_PAGE_SIZE,
> > +                                     AMDGPU_GEM_DOMAIN_GTT,
> > +                                     &bo_triplet->bo,
> > +                                     &bo_triplet->mc_addr,
> > +                                     &bo_triplet->cpu_addr);
> > +     if (ret)
> > +             goto rel_trip;
> > +
> > +     ret =3D psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> > +     if (ret)
> > +             goto rel_bo;
> > +
> > +     adev->psp.spirom_dump_trip =3D bo_triplet;
> > +     mutex_unlock(&adev->psp.mutex);
> > +     return 0;
> > +rel_bo:
> > +     amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> > +                           &bo_triplet->cpu_addr);
> > +rel_trip:
> > +     kfree(bo_triplet);
> > +     mutex_unlock(&adev->psp.mutex);
> > +     dev_err(adev->dev, "Trying IFWI dump fails, err =3D %d\n", ret);
> > +     return ret;
> > +}
> > +
> > +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char
> > +__user *buf,
> > size_t size,
> > +                             loff_t *pos) {
> > +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +     struct bo_address_triplet *bo_triplet =3D
> > +adev->psp.spirom_dump_trip;
> > +
> > +     if (!bo_triplet)
> > +             return -EINVAL;
> > +
> > +     return simple_read_from_buffer(buf,
> > +                                    size,
> > +                                    pos, bo_triplet->cpu_addr,
> > +                                    AMD_VBIOS_FILE_MAX_SIZE_B * 2); }
> > +
> > +static int psp_read_spirom_debugfs_release(struct inode *inode,
> > +struct file *filp) {
> > +     struct amdgpu_device *adev =3D filp->f_inode->i_private;
> > +     struct bo_address_triplet *bo_triplet =3D
> > +adev->psp.spirom_dump_trip;
> > +
> > +     if (bo_triplet) {
> > +             amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_ad=
dr,
> > +                                   &bo_triplet->cpu_addr);
> > +             kfree(bo_triplet);
> > +     }
> > +
> > +     adev->psp.spirom_dump_trip =3D NULL;
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations psp_dump_spirom_debugfs_ops =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .open =3D psp_read_spirom_debugfs_open,
> > +     .read =3D psp_read_spirom_debugfs_read,
> > +     .release =3D psp_read_spirom_debugfs_release,
> > +     .llseek =3D default_llseek,
> > +};
> > +#endif
> > +
> > +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev) { #if
> > +defined(CONFIG_DEBUG_FS)
> > +     struct drm_minor *minor =3D adev_to_drm(adev)->primary;
> > +
> > +     debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_=
root,
> > +                             adev, &psp_dump_spirom_debugfs_ops,
> > AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> > +#endif }
> > +
> >  const struct amd_ip_funcs psp_ip_funcs =3D {
> >       .name =3D "psp",
> >       .early_init =3D psp_early_init,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > index 3876ac57ce62..8fc4a7bb865e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > @@ -138,6 +138,7 @@ struct psp_funcs {
> >       int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_m=
c_addr);
> >       int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver)=
;
> >       int (*update_spirom)(struct psp_context *psp, uint64_t
> > fw_pri_mc_addr);
> > +     int (*dump_spirom)(struct psp_context *psp, uint64_t
> > + fw_pri_mc_addr);
> >       int (*vbflash_stat)(struct psp_context *psp);
> >       int (*fatal_error_recovery_quirk)(struct psp_context *psp);
> >       bool (*get_ras_capability)(struct psp_context *psp); @@ -322,6
> > +323,14 @@ struct psp_runtime_scpm_entry {
> >       enum psp_runtime_scpm_authentication scpm_status;  };
> >
> > +#if defined(CONFIG_DEBUG_FS)
> > +struct bo_address_triplet {
> > +     struct amdgpu_bo *bo;
> > +     uint64_t mc_addr;
> > +     void *cpu_addr;
> > +};
> > +#endif
> > +
> >  struct psp_context {
> >       struct amdgpu_device            *adev;
> >       struct psp_ring                 km_ring;
> > @@ -409,6 +418,9 @@ struct psp_context {
> >       char                            *vbflash_tmp_buf;
> >       size_t                          vbflash_image_size;
> >       bool                            vbflash_done;
> > +#if defined(CONFIG_DEBUG_FS)
> > +     struct bo_address_triplet       *spirom_dump_trip;
> > +#endif
> >  };
> >
> >  struct amdgpu_psp_funcs {
> > @@ -467,6 +479,10 @@ struct amdgpu_psp_funcs {
> >       ((psp)->funcs->update_spirom ? \
> >       (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> >
> > +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> > +     ((psp)->funcs->dump_spirom ? \
> > +     (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> > +
> >  #define psp_vbflash_status(psp) \
> >       ((psp)->funcs->vbflash_stat ? \
> >       (psp)->funcs->vbflash_stat((psp)) : -EINVAL) @@ -578,6 +594,7 @@
> > int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
> > bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);  int
> > amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
> >                                  enum psp_reg_prog_id id);
> > +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
> >
> >
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > index 17f1ccd8bd53..78f434f84c22 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> > @@ -79,6 +79,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
> >  #define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2  #define
> > C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3  #define
> > C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> > +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
> > +C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
> > +C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
> >
> >  /* memory training timeout define */
> >  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US        3000000
> > @@ -710,7 +713,8 @@ static int psp_v13_0_exec_spi_cmd(struct
> > psp_context *psp, int cmd)
> >       /* Ring the doorbell */
> >       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
> >
> > -     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> > +     if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> > +         cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
> >               ret =3D psp_wait_for_spirom_update(psp,
> > SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
> >                                                MBOX_READY_FLAG,
> > MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
> >       else
> > @@ -766,6 +770,39 @@ static int psp_v13_0_update_spirom(struct
> > psp_context *psp,
> >       return 0;
> >  }
> >
> > +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> > +                                uint64_t fw_pri_mc_addr) {
> > +     struct amdgpu_device *adev =3D psp->adev;
> > +     int ret;
> > +
> > +     /* Confirm PSP is ready to start */
> > +     ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> > regMP0_SMN_C2PMSG_115),
> > +                        MBOX_READY_FLAG, MBOX_READY_MASK, false);
> > +     if (ret) {
> > +             dev_err(adev->dev, "PSP Not ready to start processing,
> > + ret =3D %d",
> > ret);
> > +             return ret;
> > +     }
> > +
> > +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> > +lower_32_bits(fw_pri_mc_addr));
> > +
> > +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> > C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> > +     if (ret)
> > +             return ret;
> > +
> > +     WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
> > +upper_32_bits(fw_pri_mc_addr));
> > +
> > +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> > C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D psp_v13_0_exec_spi_cmd(psp,
> > C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> >  static int psp_v13_0_vbflash_status(struct psp_context *psp)  {
> >       struct amdgpu_device *adev =3D psp->adev; @@ -898,6 +935,7 @@
> > static const struct psp_funcs psp_v13_0_funcs =3D {
> >       .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
> >       .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
> >       .update_spirom =3D psp_v13_0_update_spirom,
> > +     .dump_spirom =3D psp_v13_0_dump_spirom,
> >       .vbflash_stat =3D psp_v13_0_vbflash_status,
> >       .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_qu=
irk,
> >       .get_ras_capability =3D psp_v13_0_get_ras_capability,
> > --
> > 2.34.1
>
>

