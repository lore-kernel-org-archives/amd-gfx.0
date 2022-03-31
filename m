Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0087FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 01:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8629C10F0F8;
	Thu, 31 Mar 2022 01:03:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2199310F0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 01:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFEgmKrYeUaZB3L7IX/EuIfv/MHcZ9q0ejxCeEc1Ig8y+x/a/jSAZix0uxzo3Ww99AKD3kY9AhcPreQFXWvATet8WNJUJF9YOrw4A3r8lWzM4V2neoyZQlrdbrApAoNMEJgC3YKBRl5SeNpL+Fsy/E9/heg+6eczfgj5xBIv7x8anicft5Z7RQrrRlnGOaQAAKJ35OTxVgr7CVl+b7QM0ahngYA5QLntYcYF4uEZAAcZyDtZTc5yavdohevkGXCRS/oksrrwelXyDFSnk3Co49gfEKoEvjkEOcMw7ehNPFfh3IVo2HkvqOwaHCAqsm+UEoh5LnbvpMzTiOz/RWon3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF6/BHXmayx08VayX9wOCvgvFX+LOeZlwKEsEVVp9Ls=;
 b=B89JYiyeH47bOGLxrjwbxSKq7JQ/EsDoKr24AYMD1FDVZUM90+LWmiihAQaY3kP4iK1GpOKLXq0Xwr/K5ffIGCdfUDiAt4tOCcUyqFVGIHnY7KBnfU2ax70MkTW16eDuTAtBkvNo+wAGa81mUWbA+jxDTMgsT5IcZLhlNWjv0Y8IZeVvPR4nnq7RSOUTcGiWU9OUOeMxFvvJJTMWp2sC5EzENujhin2ozb7QPvVmjmvtffh8b4wUdUqYPblE8f6LWmhbPSosoh9jieDaiy34SkuLE0XJDabRQiwnYaLW5IyCyoCiu/OypBrPJdLeqzIfAGA7mMq51EsSy+DG62QZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF6/BHXmayx08VayX9wOCvgvFX+LOeZlwKEsEVVp9Ls=;
 b=S/P/d5K7yngmuXLwDC+XGdVGrPcwvNMl6pzGoYdUMv2sfYziaVs2HPjQjTqVvkhDL7R404NPwoBqeIFsh4qyDc0ZGfoHlioMN/s/x+x58YiB3ffZ8GXFpT/vzpG9zAfmkBp4vFdWSJmNnQYL6lf0XcpUHF7rZ+9TF4bt3CHt+Bk=
Received: from DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16)
 by BN6PR12MB1394.namprd12.prod.outlook.com (2603:10b6:404:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 01:03:50 +0000
Received: from DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::c942:62dc:e487:1a7e]) by DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::c942:62dc:e487:1a7e%5]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 01:03:50 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH V2] drm/amdgpu/vcn3: send smu interface type
Thread-Topic: [PATCH V2] drm/amdgpu/vcn3: send smu interface type
Thread-Index: Adg/opkFnx88RrSfRM6GR+M7HG+yjgAahWMAAACVAwABIvPKwA==
Date: Thu, 31 Mar 2022 01:03:50 +0000
Message-ID: <DM6PR12MB4843E0514C872E6491A0036087E19@DM6PR12MB4843.namprd12.prod.outlook.com>
References: <DM6PR12MB4843192241F9620519190F0487199@DM6PR12MB4843.namprd12.prod.outlook.com>
 <35bed3c6-3e37-8a49-3b50-c65b0af9ac88@molgen.mpg.de>
 <11809024-ffb3-8d86-de08-85a658582515@molgen.mpg.de>
In-Reply-To: <11809024-ffb3-8d86-de08-85a658582515@molgen.mpg.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=114238ae-a022-4491-8728-0f2204c0680d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-31T01:01:14Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: bf73cda5-425d-4463-8cf8-e975d2cae31d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c65ff9c4-55c2-4ea4-a8bc-08da12b25175
x-ms-traffictypediagnostic: BN6PR12MB1394:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1394F5F7616FF59DA68D57E987E19@BN6PR12MB1394.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VbZwSxxZTqAM5yVfc32PV66myY36p4cdaXBFzllec3zbypovNFSzK2BnZBas88W7vf8nft8TfIbsep8dJhYJo/aGjqRa+I+PpUT99KJ+pbfNkGSE2S8DTBAjGwgnP5RDx1JgOPEur1i7pxfV68xrTKj6WiO7vwJ+N1J6pC2ubLlBENV+8Y/W6zky49DTMnPs87+GdtQOM275lxi9WyNsjpJ1kNOVAZT8xD7Lw4N22cvJUpO70YacG7F7B2BvkwEBBfGyU77Z36K/eg4KIE/ehcluirb11tsJRxU7tDtutyr3ibMYghTwVy83fgnyWI+eN098Y+WakMKklxS9lNyErNLa0YH30SqqVnD0yWHHTcYLH1XxhRdL0rQy2CkTuEYqMr9PiUszWPPhlsbIcC+6z4Kz/Hhm14dgsPRlxS9NUIcph9Pwu7vDC2vuO4q454lcgOF1EXE1RM4rFyQRCCZepUR/vyDqKCsUCxZ9bRwPgF/mq8PfCgpOL9VVEOVc/V8cUvt2VbKgXmYOc+cd1TVjMer00r0OBnLqaptjVrzNwYeoSlX1qAEXG+Q1g/gWnwtUG4FXNxi9pd+x4UVG6v0Xs7f+75MuF/1wqy+GHUImbmawP214m60h6sJ/ROuEDyMX8+TmIDsnTpR7PKSYQIEVqvwyh03S0FWp5q98yVn/dw5jDdAsfqTLZoULXoWvlqdKTMJHcPmyFvYos9OQQjmzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(64756008)(4326008)(66446008)(66476007)(71200400001)(66946007)(86362001)(54906003)(76116006)(26005)(186003)(53546011)(33656002)(6916009)(7696005)(6506007)(38070700005)(316002)(55016003)(508600001)(9686003)(66556008)(2906002)(38100700002)(5660300002)(52536014)(8936002)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0FsL094dzdVd0J3bnBLNkoxemVQd1VwL2xOV0h3UUc0UHFWc2thQXRxQ2cw?=
 =?utf-8?B?N2N3bGVPVlJYTG84bVhSZmJaNmx5RnhPUmJhRnA0anNLTlo0SDdaemtQWk1x?=
 =?utf-8?B?WDJpam1xTE9ENldxMmpXNHd5RFhZd3ZGeDRiaVplRlpEYlVpaWJiVUNtUE45?=
 =?utf-8?B?WkF3Wk5rcEx6aW9tZS9ETGw4TzdmYjVGMTlsczlDVGcyY1llM251UTJNVkZi?=
 =?utf-8?B?U3BYb0FOek1iNUNSYkxrdFNZdjE0MzdwWlE0N0psOU9HT3FDVzZKbGY0VnBB?=
 =?utf-8?B?KzZDZnk2d01ySWFkdXlqa2d4djJKK2d0VU1SVS9QMFpScmg1OWVsNFhSNHZ5?=
 =?utf-8?B?UUYzNFNHSjhVVHhJZUpwQ3dZOUJZSTdmVkNMeit6aUJOdjhETS81MFREU1ZT?=
 =?utf-8?B?UTdEMjUwQ1hVYXA4aFpGSUlHcHNmWHkrS1k2V3ZKOXRjVXI1ZE15dkp3Smts?=
 =?utf-8?B?RDROVXlMejBNSW9ZTHJJU1NYTXlzOVVzdVZHdFFrWHF5WnBXbzNTYU4zODk3?=
 =?utf-8?B?RXF4TE9tYW5yQkJyQzdzT1Z0QmhhQmR6emVoY1NNL3FHZ2dVWW9FQnFqcDJM?=
 =?utf-8?B?VWNOSk1ROWo1ZFl1MkY1Y0RTTDlnb3pNYndMT1RobmhmVkY2M1pCYmVIVGJD?=
 =?utf-8?B?QkpkdXlnWDU0Q20zeWt4UVdEQjRIS1FnSzBlWWYrYzZseDd0RW55enRubkU0?=
 =?utf-8?B?MURaOUtUWlhDOFp3QldEeUIxRkxERDJTQkFLdGlLVWZtVlRPNCtrdEl2MzFs?=
 =?utf-8?B?KzQxdjAzbE9EcHEzdVVFQkVNWnFUTGpqUFRSSnpvWno5V0NRUlBsV2I0U0x5?=
 =?utf-8?B?MU5QRmczNHhneHJYVG10U2tHNHB0bCtnNGVSUXRFUXdxZ3VOV2E4Uk1QbkxQ?=
 =?utf-8?B?ckRGRnZUcGI2L3Z1TnR0UTdGSkVzNmdUWjVkMmEvSU93VnljdThZaGVreDlH?=
 =?utf-8?B?SEVKVUZ5Y1BDYzJNa08zMitud3ZTVFovTDRHajlkbUk4NlpsNHIwY0JVNEls?=
 =?utf-8?B?UUdJQmRvOFQ4bW9yeC9ucG9kdTVSQzVaTWczKzVEV29ibTRiTDVBUWZVSDYw?=
 =?utf-8?B?a3lzcEkrbUxnb0pTUGpGaDdRVjZTUEFId2lmOG1MYTNxWEpuWngwVkV4VXpF?=
 =?utf-8?B?TEpHMVJObldIa1Yxb2JDbXl3Mml4NUMzaVNRL2FoR0tNWWR1M3JHcGk2WEFJ?=
 =?utf-8?B?TzRQTVlqaGYwYzhHVmkyTXpGWWtub1BNYWN6My84dm9nWWRGUHVyQzVXWElU?=
 =?utf-8?B?TUlEd0lwRk45bEN5RjVhdEtSMkpOTVo0MHRpc1BCUTlBd2pJd05jNmpaTjdU?=
 =?utf-8?B?LzFPUnAveE04dnhJUjVIMXVmb1NaZTRnSXMzbk1DaHRjczU3VTRYeDJnblJV?=
 =?utf-8?B?Q1dnSithYzkweXZzNEt6NzdJL0FuMzZGRkZCN3FKOVFDMzNrc2JOS09iT2U4?=
 =?utf-8?B?L2ZWNmhZczdUL2FHYjZFeDlSWXpxOGRheVhJSDFaTWdiMHdMQityZS9FRVJW?=
 =?utf-8?B?aXBqano0eDhZZ0ZrN1pkYnd2cUVPNmdpZW1ncnVHck1HWnBaTjdpdWpSYjRp?=
 =?utf-8?B?cWhRRlZrWXpCUi9FVlYxdnFXbUFEK05BYUFrRlpxUlJDbDJWSFRzUEY3UDVv?=
 =?utf-8?B?bFEvUFNiQjd1eHh2dTd5ei9NM2JRWFAzTGcrOWw3R2FCd09JTXk0dXdMdGtt?=
 =?utf-8?B?UGozK1pkSy9KZDlnZEY4T09pN3graGtrb1oySFRPcVNVcDlhemhCSWVtVENv?=
 =?utf-8?B?QzFZTmU1MjdEMnppajB0S3FjQW1lT3ppeHpHTDR4WTc1aEgxdFowdmtiOUIr?=
 =?utf-8?B?aFova2ZsQUdVeTE4M2U5SGNvRnVERzNVUjdPbHpxMUt2WVZ3U0hncEJjRXhw?=
 =?utf-8?B?eW9pL2Ntc09ZWXBDd2F3RDVVeUNvNUdVeDREaVNPZUVOUENSakw0WndZdGFU?=
 =?utf-8?B?b1Noei84b2hkNUtoWHpuUGtQN25ZZ1ByNElHZS9tZ3VRekVoQjBOQjEzMFhm?=
 =?utf-8?B?SDhGK08yaGVMZEFYbzNKU0ZCYnZVRUFZdXFtcGhkL2srR0sxeVQ2N3Rpa2h0?=
 =?utf-8?B?L00yRWt4eGhRQmRQc2tpT2Y1NnZIajlTeDl4RVQ3MWVsNGp2bm1xVTNzcFpK?=
 =?utf-8?B?dm5qUXo4L0t3RDBNeHEyQWUrRjFsYXBON0VHVkh2MTBRdU91RnBsNHM4dG43?=
 =?utf-8?B?QW9Bc0NGUStDbXpXamxQTG1nSWd2cnVNTjlWVVpodXhlUFF4S3RFMHBCUmpN?=
 =?utf-8?B?Y3FnNW1XQTkzdCtTVVBQVHFZRDdXdlpzYi9DZ3hQWjZSNGIzOUVPOGZjbFgx?=
 =?utf-8?B?ZG55Nm5mYlBXZGY4S1pDZFFNVHdwV2FJOVBOcTJHL242T2JTSzVxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ff9c4-55c2-4ea4-a8bc-08da12b25175
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 01:03:50.5709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGnpQIkCqviaujQb5MxpOR3NE5FGMtOLNIX/8HP0b/a7nWMpX1Bwr9EOD06AM6Kqz8kcSK56yccDV/6Dw2rVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1394
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgUGF1bCwNCg0KSSBqdXN0IHNlbnQgb3V0IFYz
LCB3aGljaCByZS1vcmRlcmVkIHRoZSBpZi9lbHNlIGNvbmRpdGlvbiBhcyB5b3Ugc3VnZ2VzdGVk
Lg0KDQpCeSB0aGUgd2F5LCBib3RoIFYyIGFuZCBWMyBjYW4gYmUgYXBwbGllZCBzdWNjZXNzZnVs
bHkgb24gbXkgbG9jYWwgbWFjaGluZS4gSW4gY2FzZSBpdCBzdGlsbCBkb2Vzbid0IGFwcGx5IG9u
IHlvdXIgc2lkZSwgY2FuIEkgYXNrIHdoaWNoIGJyYW5jaCBhcmUgeW91IHVzaW5nPw0KDQpUaGFu
a3MsDQpCb3l1YW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdWwgTWVu
emVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+DQpTZW50OiBNYXJjaCAyNSwgMjAyMiAyOjEwIEFN
DQpUbzogWmhhbmcsIEJveXVhbiA8Qm95dWFuLlpoYW5nQGFtZC5jb20+DQpDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhhbmcsIFlpZmFuIDxZaWZh
bjEuWmhhbmdAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgTGl1LCBM
ZW8gPExlby5MaXVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJq
ZWN0OiBSZTogW1BBVENIIFYyXSBkcm0vYW1kZ3B1L3ZjbjM6IHNlbmQgc211IGludGVyZmFjZSB0
eXBlDQoNCkRlYXIgQm95dWFuLA0KDQoNCkFtIDI1LjAzLjIyIHVtIDA2OjUzIHNjaHJpZWIgUGF1
bCBNZW56ZWw6DQo+IERlYXIgQm95dWFuLA0KPg0KPg0KPiBUaGFuayBmb3IgdGhlIGltcHJvdmVk
IHBhdGNoLg0KPg0KPg0KPiBBbSAyNC4wMy4yMiB1bSAxODoyNSBzY2hyaWViIFpoYW5nLCBCb3l1
YW46DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPg0KPiBObyBpZGVhIGlmIHRoaXMgd291
bGQgY29uZnVzZSBgZ2l0IGFtYC4NCj4NCj4+IEZyb206IEJveXVhbiBaaGFuZw0KPj4gPGJveXVh
bi56aGFuZ0BhbWQuY29tPG1haWx0bzpib3l1YW4uemhhbmdAYW1kLmNvbT4+DQo+DQo+IFlvdXIg
bWFpbGVyKD8pIG1hbmdsZWQgdGhlIHBhdGNoLiBEaWQgeW91IGVkaXQgaXQgaW4geW91ciBNVUHi
gJlzDQo+IGNvbXBvc2Ugd2luZG93Pw0KPg0KPj4gRm9yIFZDTiBGVyB0byBkZXRlY3QgQVNJQyB0
eXBlLCBpbiBvcmRlciB0byB1c2UgZGlmZmVyZW50IG1haWxib3gNCj4+IHJlZ2lzdGVycy4NCj4+
DQo+PiBWMjogc2ltcGxpZnkgY29kZXMgYW5kIGZpeCBmb3JtYXQgaXNzdWUuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogQm95dWFuIFpoYW5nDQo+PiA8Ym95dWFuLnpoYW5nQGFtZC5jb208bWFpbHRv
OmJveXVhbi56aGFuZ0BhbWQuY29tPj4NCj4+IEFja2VkLWJ5IEh1YW5nIFJ1aSA8cmF5Lmh1YW5n
QGFtZC5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uaCB8IDcgKysrKysrKw0KPj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YzXzAu
YyAgIHwgNSArKysrKw0KPj4gMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaA0K
Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgNCj4+IGluZGV4IGUy
ZmRlODhhYWY1ZS4uZjA2ZmI3Zjg4MmUyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmgNCj4+IEBAIC0xNTksNiArMTU5LDcgQEANCj4+ICNkZWZpbmUgQU1E
R1BVX1ZDTl9NVUxUSV9RVUVVRV9GTEFHICAgKDEgPDwgOCkgI2RlZmluZQ0KPj4gQU1ER1BVX1ZD
Tl9TV19SSU5HX0ZMQUcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoMSA8PCA5KSAjZGVm
aW5lDQo+PiBBTURHUFVfVkNOX0ZXX0xPR0dJTkdfRkxBRyAgICAgKDEgPDwgMTApDQo+PiArI2Rl
ZmluZSBBTURHUFVfVkNOX1NNVV9WRVJTSU9OX0lORk9fRkxBRyAoMSA8PCAxMSkNCj4+ICAgI2Rl
ZmluZSBBTURHUFVfVkNOX0lCX0ZMQUdfREVDT0RFX0JVRkZFUiAgICAgICAgMHgwMDAwMDAwMSAj
ZGVmaW5lDQo+PiBBTURHUFVfVkNOX0NNRF9GTEFHX01TR19CVUZGRVIgICAgICAgICAgICAgICAg
ICAgICAgICAgMHgwMDAwMDAwMSBAQA0KPj4gLTI3OSw2ICsyODAsMTEgQEAgc3RydWN0IGFtZGdw
dV9md19zaGFyZWRfZndfbG9nZ2luZyB7DQo+PiAgICAgICAgICAgICAgICAgdWludDMyX3Qgc2l6
ZTsNCj4+IH07DQo+PiArc3RydWN0IGFtZGdwdV9md19zaGFyZWRfc211X2ludGVyZmFjZV9pbmZv
IHsNCj4+ICsgICAgICAgICAgICAgdWludDhfdCBzbXVfaW50ZXJmYWNlX3R5cGU7DQo+PiArICAg
ICAgICAgICAgIHVpbnQ4X3QgcGFkZGluZ1szXTsNCj4+ICt9Ow0KPj4gKw0KPj4gc3RydWN0IGFt
ZGdwdV9md19zaGFyZWQgew0KPj4gICAgICAgICAgICAgICAgIHVpbnQzMl90IHByZXNlbnRfZmxh
Z18wOw0KPj4gICAgICAgICAgICAgICAgIHVpbnQ4X3QgcGFkWzQ0XTsNCj4+IEBAIC0yODcsNiAr
MjkzLDcgQEAgc3RydWN0IGFtZGdwdV9md19zaGFyZWQgew0KPj4gICAgICAgICAgICAgICAgIHN0
cnVjdCBhbWRncHVfZndfc2hhcmVkX211bHRpX3F1ZXVlIG11bHRpX3F1ZXVlOw0KPj4gICAgICAg
ICAgICAgICAgIHN0cnVjdCBhbWRncHVfZndfc2hhcmVkX3N3X3Jpbmcgc3dfcmluZzsNCj4+ICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Z3X3NoYXJlZF9md19sb2dnaW5nIGZ3X2xvZzsN
Cj4+ICsgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9md19zaGFyZWRfc211X2ludGVyZmFjZV9p
bmZvDQo+PiBzbXVfaW50ZXJmYWNlX2luZm87DQo+PiB9Ow0KPj4gICBzdHJ1Y3QgYW1kZ3B1X3Zj
bl9md2xvZyB7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3YzXzAuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jDQo+PiBp
bmRleCBiMTZjNTZhYTJkMjIuLjk5MjViMmJjNjNiOSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92M18wLmMNCj4+IEBAIC0yMTksNiArMjE5LDExIEBAIHN0YXRpYyBpbnQg
dmNuX3YzXzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpDQo+Pg0KPj4gY3B1X3RvX2xlMzIoQU1ER1BV
X1ZDTl9NVUxUSV9RVUVVRV9GTEFHKSB8DQo+Pg0KPj4gY3B1X3RvX2xlMzIoQU1ER1BVX1ZDTl9G
V19TSEFSRURfRkxBR18wX1JCKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Zndfc2hhcmVkLT5zd19yaW5nLmlzX2VuYWJsZWQgPQ0KPj4gY3B1X3RvX2xlMzIoREVDX1NXX1JJ
TkdfRU5BQkxFRCk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmd19zaGFyZWQt
PnByZXNlbnRfZmxhZ18wIHw9DQo+PiBBTURHUFVfVkNOX1NNVV9WRVJTSU9OX0lORk9fRkxBRzsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT5pcF92ZXJzaW9uc1tV
VkRfSFdJUF1bMF0gPT0NCj4+IElQX1ZFUlNJT04oMywgMSwgMikpDQo+PiArDQo+PiBmd19zaGFy
ZWQtPnNtdV9pbnRlcmZhY2VfaW5mby5zbXVfaW50ZXJmYWNlX3R5cGUgPSAyOw0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAoYWRldi0+aXBfdmVyc2lvbnNbVVZEX0hX
SVBdWzBdDQo+PiA9PSBJUF9WRVJTSU9OKDMsIDEsIDEpKQ0KDQpBcyBjb21tZW50ZWQgb24gcGF0
Y2ggdjEsIHBsZWFzZSBhbHNvIHB1dCAoMywgMSwgMSkgZmlyc3QuDQoNCj4+ICsNCj4+IGZ3X3No
YXJlZC0+c211X2ludGVyZmFjZV9pbmZvLnNtdV9pbnRlcmZhY2VfdHlwZSA9IDE7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYW1kZ3B1X3ZjbmZ3X2xvZykNCj4+DQo+
PiBhbWRncHVfdmNuX2Z3bG9nX2luaXQoJmFkZXYtPnZjbi5pbnN0W2ldKTsNCj4+IC0tDQo+PiAy
LjI1LjENCj4NCj4gVGhlIHdob2xlIHBhdGNoIGNhbm5vdCBiZSBhcHBsaWVkLiBEaWQgYHNjcmlw
dHMvY2hlY2twYXRjaC5wbGAgbm90DQo+IGRldGVjdCB0aGlzPyBQbGVhc2UgZml4IGFuZCByZXNl
bmQuDQoNCg0KS2luZCByZWdhcmRzLA0KDQpQYXVsDQo=
