Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6285C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 06:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F7810E5A4;
	Thu,  3 Nov 2022 06:26:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1754010E5A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 06:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfHqdhlmBIlStQppz7b6CfFwLNd2qo1iWuoWBX6ca+AK96OOOEHbWKMKh2F3rqJMOHsIaqmmmtTOwb8JosQvIuj7Lgm7EXIaGzgrpgwwiYvomibZkJdFPgzn/aOGnNYizLaio1HpI9u+No16cC/lbgcQ5ltfqRi2pY1WHZsy1qiurJLesoyqhHqyV6zwtb34oNgxmV7h9La58ZdVAuK8O7zVSD5J/tBF0/JNkNxvlhZZT2FG3YVlWdkQosASIn1EO7hAWyZhPYfIYtMmIGYayV/YWANjOW/k8n+rS+6vUcSGeNwvWZzdPkqNyxirYWY8BviI7/ulJ7MFLNZ/pUV8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUHqMYrXxn6mI6RdbjqWQxgo0a64ZGdne+7O56kxuAw=;
 b=e0NdU3Mj9vSHGXZb4wyajYsjgx5jSsqjN3QE4E9looVvlDfU/n3nuPkwpWiN+rXRjkh/zK+KUQE1aA+pqhJISYvNvUduJTc31v+jX0Cr9uPNU4AOC1WUTrqQQ8jvv6u1gGInUSMp7lE5Yiqc3uXeP9PPJPB+q6EPPYOeg1AmUK1voTcoMi+eMiAY7n/2AK+JRy86xQTATu/ndm7ONDjI8leJxFyaPvpG/10OttCSej240PNwVd1YgOh2AnPPxyjvvXNMaQFLjErZyTOLflW0ZjeQN5G7gFmBs+KTRuJPdyQgbYRo226wWANS0cFdED5yXTZQaAyd5MMUAaYeR7u5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUHqMYrXxn6mI6RdbjqWQxgo0a64ZGdne+7O56kxuAw=;
 b=V0U1BpNBtj2CnX3on+jmiB0eXlg1vZbJHfqob0joit6TUTCdECUw2B1+na4igblOvxONd3lUlMmkrUNAaz9vLpTnCiPXmGZO8GXqDzBb+TzkhvluQyUtqw4jdZpvlaW/4rjbU2uu8NoqbtGToCdXE9CTrIXEAhCOHom48bH66mc=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 06:26:20 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::3bf0:6f5b:fe42:4149%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 06:26:20 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2 2/3] drm/amd/display: change GPU match with IP version
 for Vangogh
Thread-Topic: [PATCH v2 2/3] drm/amd/display: change GPU match with IP version
 for Vangogh
Thread-Index: AQHY7tyAg9khjLoBnEe0Rn6SQ2PVz64r32UAgADcmGA=
Date: Thu, 3 Nov 2022 06:26:20 +0000
Message-ID: <DM4PR12MB527833B031F6D77E46C62D209C389@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221102165914.1995657-1-Perry.Yuan@amd.com>
 <20221102165914.1995657-2-Perry.Yuan@amd.com>
 <CADnq5_NB93v-2B4N-7L+jQzQQS+n=1+kKwuHxVZdqiv=HjkbGQ@mail.gmail.com>
In-Reply-To: <CADnq5_NB93v-2B4N-7L+jQzQQS+n=1+kKwuHxVZdqiv=HjkbGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T06:26:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=af223e34-20b8-47a2-8f11-4bf500f485ac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-03T06:26:16Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0d50354e-f319-41c5-88ce-1eb25a7c76bf
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: c0232f50-3ff7-4416-deca-08dabd645272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7Bgl+VAwPFnmrb0f9oHQMOlT8jvXk6xMr1yI7AXISm3lt+/tAQALvZ8RmHkDAT/dxG3SH6r2majG6uOPD5YW6VFoI0Krt0TvH9OBfA9XZnJ/LPD2n/9DR5taNeonwgC6tloFDuqdm40W/6y4NnzULPhyvErNL8btQWRlb9fFWgo1NBmp4GnXV+9elZLIWsEYDG+Nw937EfqnGTtWUCWR7yIRlf14hb7I5teNNQ0T2ZIjlk0us2w54Ag9UUXmGBUa928KIzDb1Q/GDFLKrZcjUgELXURzb73RiEprf51FWP+TrPjrxWBVuUbiHV0Dbkaany+rn1jsLw8GoWwkYr5zAp/RajEG44Z7i55j17xL7YCD7ptSCwXvLE9FNRlx9Jj7zT6vOIwlLgGWYlNUQohRk1GnUiSx12iO+psXJYLyr+E4Lvk+sR0fHd2iH+LManDuqmsLHOYLTbhUxPJDOiEdw8gPr4izvUVVVH5H73pMLG/TZ48f8rwth4yj8UgWQ+I/ZpH4m5hnus1ZLTEL8lff9jJOxeTa/1g2eKmzW8BP1wQgeNfTvJyz4Y4N3mmQRgLSve7RzeDfeZvRdm6jLRZq1RCamtNvhMwUfGuAY1Ut3JAAwQXs+xCUAoY0nxr94RExL0j4btPUd1hqSj3s+NaAIxKgLIUwVy68IDrqjAsouFe3Ub6gWi6/aLV2IDRONVguMfN3hh30UAjEqU/95CqVRFg1IZ9qg/oZd6LbB+fqAfXD8+Wx+zB0TUByiAX479StQX2POspPhdZacpMuPFhyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5278.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(83380400001)(316002)(54906003)(6506007)(6916009)(7696005)(66446008)(53546011)(8676002)(71200400001)(66556008)(66476007)(4326008)(478600001)(76116006)(66946007)(9686003)(26005)(38070700005)(8936002)(52536014)(5660300002)(2906002)(41300700001)(186003)(64756008)(33656002)(122000001)(38100700002)(55016003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1lYMXI2aTBmZUZZL1dVUm5xVHlkR0VEYzFYQXpRb29sQTA4KzBoRXdJQ3VP?=
 =?utf-8?B?T3cwdlpiOUpDOTRLR1RVVGJxQkNUS3E3NU10aTdVTllldWRSRkVqTDM1VW1T?=
 =?utf-8?B?YkN6RUc1cUNFWVl5OWRXdVlpWi9pYzFNNzdMdmJvREpGVWxiVklYZVFoUDU5?=
 =?utf-8?B?b2NJT2Vqd0M1c0R1YmlYMkJKWENkSlh4WHNyb2Q3VmE0MGgrRCtFWm5JSS85?=
 =?utf-8?B?bXBSa2tMZW95T3ZySHgraHdEVEZvVjh1ck1SVi9RdWkwUHd5Y3NqRXJPNlJi?=
 =?utf-8?B?SVVNVmN1L2xyancyNEVUaTNzWG5ob2VYNCtnUVJMSENNdDV5REQ2WW1MK1Vq?=
 =?utf-8?B?cjhRdzhrbnVUTklLM3U4RkFMTFE4Zmh1TnBBUHNYbDVyaGV3RUZyM09rNk9m?=
 =?utf-8?B?bGNWNHRDbE9sV2h3YTRCcU50a1IreHIydVY2MlIxMGkwTGw4alpweExWZExZ?=
 =?utf-8?B?MHc1WjlMRVJ0U3NjbW9JVFNwa2VvcjBRaGxyOU9CZ2ZUVVRwbUozUU5aMTdP?=
 =?utf-8?B?OWE2OWdPRzVaYzdNZXk3NElxdXk0MzdsZjRxM3pzaE1KM2JhVklON3M2QVlx?=
 =?utf-8?B?SEphbHo5N054aFBzbUJleG1QdzlzdldGTXJJRW91ZEQ0MzhJVkpQU3pWZi9t?=
 =?utf-8?B?b3N1NDFPeG5UdmNLaUFaa0NRck1wMDRweG1xZlVPK2RWVktFVFJZeHpwaUR6?=
 =?utf-8?B?KzlDOXBxTG9XZmhEM3d5UFFuWWJvMmxJTFJ3M0J6a2c0eW1Md2laZmV5RVQr?=
 =?utf-8?B?SlBCMkJ3VStwaHZxMm5YWHdMVlYvbTd4M1V3R082MXhyeU5CWkUvb2hGa25H?=
 =?utf-8?B?KzdtYnlrT2xySmd3MVB3eFlUbjFmOUFzYS9hbGRoNk9OUEd4QkhxREJ4MmJ6?=
 =?utf-8?B?WURTMEVpTG41YTFpa0YxQkhWRkJZWUppejFTRm41bk9wWlIxdzBwc3M3Qkpu?=
 =?utf-8?B?UVBFRUFRTmVRRDhwOC9YdUdRdlJMYlJKbEFuK2Q0cDhrckc5VmI4WEhMSFVZ?=
 =?utf-8?B?QWNlWFFTQmFLaFdYeGtaQ3c4MWNTd0lDZmRJRGN4eTdaTXBFRjBLSGJuMzBu?=
 =?utf-8?B?V1R4aVVjdHNxMW9Ddzh1Qm9mRWwvUGc2U2M1OVQyZExaZmRxNHd2OHQwNDF1?=
 =?utf-8?B?SVY5UXVlb2w5YldGcGpJcnhpMFl1VEpoVlorUGNjVXZ0QlVUUEwzYzhyYjhO?=
 =?utf-8?B?ODNKRG9tTFRRa3N3Z3QvVDlORGNONHhoWmZHVjF6b1kwUDdyWEloeUlLZUdO?=
 =?utf-8?B?VzBoRHdOTGZ1TkRzYlZhUUp0eGhFdHdINk5zN2hidmtwa3l3OGlZRmwwZjRz?=
 =?utf-8?B?cFgxdkthb0lLNGNpZFUzKzZPNE44ZEpHT1ZRNUhKOGNxTUhTb2plN2NGdFFS?=
 =?utf-8?B?Q3ZObUN6WnFqMit1Vml1ak93UjZJNW5zRFpXeHJCK1hsUEpXS1JmSkZiVE94?=
 =?utf-8?B?cWJVYnc4eEtqVENPQWQwWjVieGh6dUFpaDlSS0poS0tNNEt3Rm1WNFM2Zk1Y?=
 =?utf-8?B?L216SHMvYzhHcTREcDRkcVFLbE9FY0lXYUNRWVVrNmJJL2xNMnRkT1c4eXdM?=
 =?utf-8?B?TlN2MVNVTzY2c3dNcWtBbGtGR09HaWZWdjdFUU03M2F5SUd3ZXBuZi9zRWZh?=
 =?utf-8?B?cG1RMkJGVXZScHFhMEZIWGxCbXFZVVdoVVhGSzViUkRMT010Wjk5cEZSTW0y?=
 =?utf-8?B?WmtIaW1ocmNNbExKMzlLQ3FtN3hOVGhCcWdBSmNUdExYNitxTnhuYWQrZkFz?=
 =?utf-8?B?R3V0VzZEVW93dWd3ZUlHSkhtczdKTjlaYUp5OEdQMlk5R3RodTVFNkZ0SFhI?=
 =?utf-8?B?MzU2N1VPNU10WDZibi9HQ0ZCaVBGdnVERXNLekZwRTFUWU1DTlM4VFVrek16?=
 =?utf-8?B?MFlLR0N0SEFsMWI0UDFEd0JtYnI0WTdOUWh2MVZ6dEtSUEVLak9XWDBDVldl?=
 =?utf-8?B?RkZxU29ub1JuV3Q1STVFejd2SERQYkxuWmxRN0t0NDE0UDVtR3c2YTdFNGdT?=
 =?utf-8?B?VnJ2RVJzSW4vK2tqL25TS1pXZFNIakI4bEpTN0pXeWwxdVhLeWpHTytQRHJF?=
 =?utf-8?B?YjZHTzhvckZFRDJrWlVFUk80NG9XZ0VVOENVSGM3dHJzYXgxbWsweDVFQnlW?=
 =?utf-8?Q?jbZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0232f50-3ff7-4416-deca-08dabd645272
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 06:26:20.3360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ocIqE+6n2ezVUB+C7d9Xafva8P10j6PDWNeTSCjEDYGUmtJT0hrGbp+DyW8nTGSdL3IA3OPNl4BkCFqCF8Pww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang,
 Shimmer" <Shimmer.Huang@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEFsZXguIA0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJA
Z21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMywgMjAyMiAxOjE0IEFNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGlhbmcsIFJpY2hhcmQgcWkNCj4g
PFJpY2hhcmRxaS5MaWFuZ0BhbWQuY29tPjsgSHVhbmcsIFNoaW1tZXINCj4gPFNoaW1tZXIuSHVh
bmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBMaXUsIEt1bg0KPiA8
S3VuLkxpdTJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNdIGRybS9hbWQv
ZGlzcGxheTogY2hhbmdlIEdQVSBtYXRjaCB3aXRoIElQDQo+IHZlcnNpb24gZm9yIFZhbmdvZ2gN
Cj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwg
U291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBj
bGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gDQo+IA0KPiBPbiBXZWQsIE5vdiAyLCAy
MDIyIGF0IDE6MDAgUE0gUGVycnkgWXVhbiA8UGVycnkuWXVhbkBhbWQuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IFVzZSBpcCB2ZXJzaW9ucyAoMTAsMywxKSB0byBtYXRjaCB0aGUgR1BVIGFmdGVyIFZh
bmdvZ2ggc3dpdGNoZWQgdG8NCj4gPiB1c2UgSVAgZGlzY292ZXJ5IHBhdGguDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA0
ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbS5jDQo+ID4gaW5kZXggMWVmZTdmYTViYzU4Li45MDYzNmI4OGQ2YmYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMNCj4gPiBAQCAtMTAyMDIsOCArMTAyMDIsOCBAQCBpbnQNCj4gYW1kZ3B1
X2RtX3Byb2Nlc3NfZG11Yl9hdXhfdHJhbnNmZXJfc3luYyhib29sIGlzX2NtZF9hdXgsIHN0cnVj
dA0KPiBkY19jb250ZXh0DQo+ID4gICAqLw0KPiA+ICBib29sIGNoZWNrX3NlYW1sZXNzX2Jvb3Rf
Y2FwYWJpbGl0eShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCj4gPiAtICAgICAgIHN3
aXRjaCAoYWRldi0+YXNpY190eXBlKSB7DQo+ID4gLSAgICAgICBjYXNlIENISVBfVkFOR09HSDoN
Cj4gPiArICAgICAgIHN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbR0NfSFdJUF1bMF0pIHsNCj4g
PiArICAgICAgIGNhc2UgSVBfVkVSU0lPTigxMCwgMywgMSk6DQo+IA0KPiBIb3cgYWJvdXQ6DQo+
IHN3aXRjaCAoYWRldi0+aXBfdmVyc2lvbnNbRENFX0hXSVBdWzBdKSB7IGNhc2UgSVBfVkVSU0lP
TigzLCAwLCAxKToNCj4gDQo+IFNpbmNlIHRoaXMgY29kZSBpcyBtb3JlIHJlbGV2YW50IHRvIHRo
ZSBEQyBJUCB0aGFuIHRoZSBHQyBJUC4gIFdpdGggdGhhdCBmaXhlZCwNCg0KWW91IGFyZSByaWdo
dCwgVGhlIERDRSBJUCBpcyBtb3JlIHJlYXNvbmFibGUgdG8gbWF0Y2ggdGhpcy4gDQpWMyBzZW50
IGZvciB0aGUgZml4Lg0KDQpQZXJyeS4gDQoNCj4gdGhlIHNlcmllcyBpczoNCj4gUmV2aWV3ZWQt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gDQo+ID4gICAg
ICAgICAgICAgICAgIGlmICghYWRldi0+bW1hbi5rZWVwX3N0b2xlbl92Z2FfbWVtb3J5KQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
