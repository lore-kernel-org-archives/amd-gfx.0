Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A091C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 08:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB56010E8D9;
	Tue, 15 Mar 2022 08:52:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1F910E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPnghF6LsKz+Hz35WOMstumTyYpUEgjBP4S20JQcGPnI4rhJanvcw8lbSwafG5GmbnE33UNgUT16WKQ1KuWay7XQFieowY0GWKXcG2xl4NTZXu/xaWVD776AKdzoLegfEOb1bwDFDcPIVh5X5ZHXOaevpjoFtdCdvCeItE4uiOTQcDgt6RAdKu36xE2tOzOnoCK2Ffa0YBeH2Jx59zLKmC0Nsh2dLVH670QGnQuyniDaZeQ/ILqDwYT1RFoujvs/JkzWLmxpt/gQbhSFdApekuiZL+mUmxJ5iuKzJU3wk0v62YobGSFadnR35YGvTIxrR84RCCSBeHDsepOHu5nWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eFayCLL/CYWbfIF1//1NnMQw5+VyFvejN5dN1EULNs=;
 b=VImiE4E8Z8EAsx+UMB0jCvEdL+vXkM68/O6Mo6ZWyh1nwYq7VYP7JVOaDKq+R4LjqEDifZJ7IohM0iIvszEMQ3fdoO3MDgCR9iSvmbGoGIddjyKnYKvGi7NAGYNlYTJsb691wUNiiTfz/FUNCyYIAI9RS5QAvIuW+U8bfN0QwDZ9g8keDe2pa+Dja+pUeegekm1Cn6DfLzGfaLdzuYngvcTCtWG6hFYJmCZTiYLrYM5Pr6e5u8mkltattMApOnkf0UDB9P3O6fodkKybkRZduZ+0qNVCT1mnU65i+KVp9MCg6mWe5ks+yYZTDsGyol8Zq/KNByplE/eFqypjRpOevg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eFayCLL/CYWbfIF1//1NnMQw5+VyFvejN5dN1EULNs=;
 b=bhJLDvSXZ8kf9/kCQw7r9zmWHqav3rmPymXFkwCzbwXTGGAXt+thasrA9usrQbWoRpB6qYcEhgx8xtr6/BZUqzTCQu9tSjeMJ149QmrCA2kH+BSFjWwkUvgdNxpdLpx/rJ+5iRBs5wG6GxdvsyJEY4hCfh+2a7+u1QX+xg+yFFA=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 08:52:25 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 08:52:25 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Topic: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Index: AQHYN3Gnmh0rVuZ5PUyC0L/FY4MrH6y+o2OAgAFuEQCAABD4gIAAAhkA
Date: Tue, 15 Mar 2022 08:52:24 +0000
Message-ID: <DM5PR12MB1770B21224B86A2B84160EE2B0109@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
 <0480be6a-3bf1-d120-8923-06819d7479bd@amd.com>
 <DM5PR12MB1770C04DED1C0A8C7EB6DA9CB0109@DM5PR12MB1770.namprd12.prod.outlook.com>
 <1298d67d-bd43-6e9b-79e2-b2f19bbe5be7@amd.com>
In-Reply-To: <1298d67d-bd43-6e9b-79e2-b2f19bbe5be7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-15T08:52:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0ba24a55-5a33-4467-a9d2-286bc1ba2cb0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T08:52:22Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9f474fc1-1132-4a20-b51d-1de9939ffc01
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7c34c9b-5253-4928-361c-08da0661205f
x-ms-traffictypediagnostic: PH7PR12MB5831:EE_
x-microsoft-antispam-prvs: <PH7PR12MB5831EDB8E487DED312BB950DB0109@PH7PR12MB5831.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjLoyN4pmxF2imazeHqtdF86N24TjKR6tjPN8r+vc22Ow2zx+Pp6fdn0YpfdkYUhPqfmOY99TKcxcZFt9TYeqx93Ug3Mu61NimFCjvEDUFCiNEHErDH9hRtBZADG7zCaeL8AHZ+QaSDnxwyXMFD2iehY1/+YAX8UsUYV51+BluMdli5g2CwycAvy6669oV6N4wfqegl+xn7CyBMs0xCREG737Nu3oQ4Sswf4FS8XlzCIxp+0CnhlRfbrYSohlqfM1WjDfiUBZJOfFbFTpknn5TcLMf1D3NGeR+U4xKAUX+gQB8f5aWhP3sVQeXdTD2WLYBVFPsdMKdABKID5KlyRNMu6x3viY9dOMp0izDCEaIVgU85hM6yCje32paRae0rvO3rnExHtCra/G9m2Gs1T8wMTDUccoX/ChJmvMK+WMlp78SEO8R2GVMBhFBVXT/t/2fubVN27lcOkREhYJ/BVVu53o2mikzqNyo90s9vg2UTMcd6RkmDgNa3mYyvrjPNWgUuE03Df5jOmYS7J2DpTO1rbX4j9IkyYB5QF+mxSsDWMz1EJ4tpvdE+azjjKXVMejg0yssKYQmNVfYCR5wuD+8lj+LDEo7w5hgVY0vTb1DXoUVV7oJwt+vG343m5SZa+mnM6JsMgHileSVLz/0tgE+ma6XiPYzq2g7ectnusBbvzGFBO2xCQ/7HDf2wYngp36trz5P2Zxa0yY61IQ2DqRw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(66476007)(66446008)(64756008)(508600001)(8676002)(76116006)(9686003)(86362001)(33656002)(38100700002)(55016003)(26005)(122000001)(71200400001)(53546011)(7696005)(6506007)(110136005)(6636002)(38070700005)(316002)(52536014)(5660300002)(8936002)(83380400001)(186003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REVMekZzNzFRSWZUVEZtaDJUc3Y5LzV6RHVMOFBkRmxSNjNBaHdXbDNORjl2?=
 =?utf-8?B?MExtUnRnazdWeG1HUkZlakhjanFoSGZxK0N4RjJXU2lrVHk4N1dmQllkVExh?=
 =?utf-8?B?Ty85d2pNUnVQbDdPa0YzcnJBbkpyRHlKMXhxQ3RsenpDaEpldHh6bWEvTDMy?=
 =?utf-8?B?bWZ1empFRU5PQ3M1ZjZoUUxpVHJueDhCYTNab3pJaWtwZ1pNd3p2enZ4VlJY?=
 =?utf-8?B?N0h0R0M5U2dNeVFrcU1xNlZ3Z3o0Q1Z2TndGeWlZZkJyUHhCOTVpQnBLKzdL?=
 =?utf-8?B?T0lra1d0aFZibG94TWNISk1HODljZkJiaHhRdXJIaVRNeXhDZjQrTUV0cHRh?=
 =?utf-8?B?TnlCbGRkLzUrbVNhcU5uRzlwZ2hWcUlidnVMUWlBbHVqUkxSTlR4SlN2cWV0?=
 =?utf-8?B?RFV3S245Q2ZiSzVFY3BSWEZuajdqKzB1dERNbTNJVnQwWHIzYjU5OG1HZVJJ?=
 =?utf-8?B?VjNzTkJ1VEtVSUJUZnBIUnk5Sk9kYm40MENnUVpsUEprWlZLWFpQWFhmVGg0?=
 =?utf-8?B?VFRPNWRMclJ6R0N0T3RLWTZ1S3dpT1FDbnYzNW5yM1V4anAzc2UxVk9CR2JC?=
 =?utf-8?B?M2VWMmJVeXBtUmFuN29WSHdrV01nb1pwTXErMzE1YWZPdEd1bHRRRWEyODNH?=
 =?utf-8?B?RkFjTlB6c2RFc0ppYjBIUnpyUnBXQStPZVJwNWNQOEFzZDVHTG04aHJDOU5R?=
 =?utf-8?B?M2ZOdTA3SjZNYk5zSlFEbVNKWnQ5dW1OQVMvMU92YXVtMGRMVmI1WHcrUW50?=
 =?utf-8?B?Y0w0MXRjRTVheEl2QS9YWXZOSTFrU2lVZlREZUxrTlowOTNFTm5nY0hlUllF?=
 =?utf-8?B?UFgzSHdrUzhPM0ZDeld2dW9CVXhIdHY0K3UwNzdGRHdaRFN1ZjRBK2oyZmN0?=
 =?utf-8?B?V3Q3NUgxY1c0UHpPWVBlVUF6eWZtNDU3UEVSdytHZUJNRUdPSkNIZ1BWeTI2?=
 =?utf-8?B?aTFrWWJ0bVZIV3ZPMGdHYm5NbXM5V05xUk02aUNSOTVzN1phYmdUMUc2Si9j?=
 =?utf-8?B?bkI1OWdPR0tMc3o5dWtzMU1kSTdBWTllVGhkWGJkWlBScXZ1Ymh4ZUorSG1r?=
 =?utf-8?B?dkk1OC9wNzNDcW05ZStoV1h0Q1BqVWpJV24wZE1uMzVWbmR1cVJicnU3aDRL?=
 =?utf-8?B?QjFhQ2l2Yk5DQUpHV2JjcHJWMmJxM0RSSTRCcGZhSFpFK0tZR01vUUtWaFJs?=
 =?utf-8?B?NTVEaWZiNEIyRnc5VTBvamdzbFhwRm1TTkY4bktlWGoyVjdnc0YwQ2V6aEdo?=
 =?utf-8?B?OFB1Yi9TU2lYa0ZLc1RNcFlEU0NwN2NXdFJCR08rZUxsMHczVjVpa1VJSXNY?=
 =?utf-8?B?QWk3SUM1Q0RzeFhablZiZzJrQmhjVFUrMVkwWHB6dkQ4T2ZJVDdVZGd0MmRk?=
 =?utf-8?B?REFlNHh3SWtjOFpQNlFjSW82VWp1QUFmbGZEMTFGUE5vVGZGbm5XUmQ3RHMr?=
 =?utf-8?B?eFlVN0RHSGxXaWU3c21ITU1GaEhNalBxajZpZlhKZGphd2cxVkpHTFdqUGpT?=
 =?utf-8?B?Yk1nRnBTeDZ4OXdYVzhRS0cycm9EMlBndFVvdUZWSmNpOUpzVlVQczJIamtn?=
 =?utf-8?B?cTZqQ0ZJT0puZHE2N2tRWnlQUzZpd1RCekVXcVM1ZnFqUnZmUGZ2MUh5VTFr?=
 =?utf-8?B?SHU4RkowYWFUckRtSkw5N2V4WUk3d1gxRmZ0eTZVZzZCeURSWlU3L2lJcEhp?=
 =?utf-8?B?bUh4S2dENEw2N2cyZUYrREZ5NnJDLzJZWHZxSi9ldDZDU2pXOWRPZXc3U3Jw?=
 =?utf-8?B?dkRXWkZiTUhxUG5mRzF3eHVYYlFIMVVCSFh3MG9odmptNEw5Y1BpOEw0SVpQ?=
 =?utf-8?B?SGtkbkhyZW8yNUFvQW9JNC9XQjg4ZGJvclA3dGZIazhFOGhmOTA2eHZOLzM1?=
 =?utf-8?B?aFpPb29MVXNEV1gyWDJWdkU5Q3hjUDVJNlhJanYzOTVVOWJxZmcvaHJQMW1i?=
 =?utf-8?Q?iTmT126Zze1S7UFzxrKhiYPrKTS4dS+D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c34c9b-5253-4928-361c-08da0661205f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 08:52:24.9176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utceI5KPPW32LDhcakTdsfOLQduVJNDFF2X01GVHUhRaU4eddqj0UksFuJ201psc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgTWFyY2ggMTUsIDIwMjIgNDo0MyBQTQ0KPiBUbzogWmhvdTEsIFRhbyA8VGFvLlpob3Ux
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsDQo+IEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkNCj4gPFN0YW5sZXkuWWFu
Z0BhbWQuY29tPjsgQ2hhaSwgVGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDMvM10gZHJtL2FtZGtmZDogYWRkIFJBUyBwb2lzb24gY29uc3VtcHRpb24g
c3VwcG9ydCBmb3INCj4gdXRjbDINCj4gDQo+IA0KPiANCj4gT24gMy8xNS8yMDIyIDE6MjIgUE0s
IFpob3UxLCBUYW8gd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCj4gPg0KPiA+
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTGF6YXIs
IExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBNYXJjaCAxNCwg
MjAyMiA1OjUyIFBNDQo+ID4+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiA+PiBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleQ0KPiA+PiA8U3RhbmxleS5ZYW5nQGFtZC5j
b20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMy8zXSBkcm0vYW1ka2ZkOiBhZGQgUkFTIHBvaXNvbiBjb25zdW1wdGlvbg0KPiA+
PiBzdXBwb3J0IGZvcg0KPiA+PiB1dGNsMg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAzLzE0
LzIwMjIgMTI6MzMgUE0sIFRhbyBaaG91IHdyb3RlOg0KPiA+Pj4gRG8gUkFTIHBhZ2UgcmV0aXJl
bWVudCBhbmQgdXNlIGdwdSByZXNldCBhcyBmYWxsYmFjayBpbiB1dGNsMiBmYXVsdA0KPiA+Pj4g
aGFuZGxlci4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3Ux
QGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICAgIC4uLi9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2ludF9wcm9jZXNzX3Y5LmMgICB8IDIzICsrKysrKysrKysrKysrKystDQo+IC0tDQo+ID4+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9w
cm9jZXNzX3Y5LmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9w
cm9jZXNzX3Y5LmMNCj4gPj4+IGluZGV4IGY3ZGVmMGJmMDczMC4uMzk5MWY3MWQ4NjViIDEwMDY0
NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNz
X3Y5LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJv
Y2Vzc192OS5jDQo+ID4+PiBAQCAtOTMsMTEgKzkzLDEyIEBAIGVudW0gU1FfSU5URVJSVVBUX0VS
Uk9SX1RZUEUgew0KPiA+Pj4gICAgc3RhdGljIHZvaWQgZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9j
b25zdW1wdGlvbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+Pj4gICAgCQkJCWNvbnN0IHVpbnQz
Ml90ICppaF9yaW5nX2VudHJ5KQ0KPiA+Pj4gICAgew0KPiA+Pj4gLQl1aW50MTZfdCBzb3VyY2Vf
aWQsIHBhc2lkOw0KPiA+Pj4gKwl1aW50MTZfdCBzb3VyY2VfaWQsIGNsaWVudF9pZCwgcGFzaWQ7
DQo+ID4+PiAgICAJaW50IHJldCA9IC1FSU5WQUw7DQo+ID4+PiAgICAJc3RydWN0IGtmZF9wcm9j
ZXNzICpwOw0KPiA+Pj4NCj4gPj4+ICAgIAlzb3VyY2VfaWQgPSBTT0MxNV9TT1VSQ0VfSURfRlJP
TV9JSF9FTlRSWShpaF9yaW5nX2VudHJ5KTsNCj4gPj4+ICsJY2xpZW50X2lkID0gU09DMTVfQ0xJ
RU5UX0lEX0ZST01fSUhfRU5UUlkoaWhfcmluZ19lbnRyeSk7DQo+ID4+PiAgICAJcGFzaWQgPSBT
T0MxNV9QQVNJRF9GUk9NX0lIX0VOVFJZKGloX3JpbmdfZW50cnkpOw0KPiA+Pj4NCj4gPj4+ICAg
IAlwID0ga2ZkX2xvb2t1cF9wcm9jZXNzX2J5X3Bhc2lkKHBhc2lkKTsNCj4gPj4+IEBAIC0xMTAs
NiArMTExLDcgQEAgc3RhdGljIHZvaWQNCj4gPj4gZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25z
dW1wdGlvbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+Pj4gICAgCQlyZXR1cm47DQo+ID4+PiAg
ICAJfQ0KPiA+Pj4NCj4gPj4+ICsJcHJfZGVidWcoIlJBUyBwb2lzb24gY29uc3VtcHRpb24gaGFu
ZGxpbmdcbiIpOw0KPiA+Pg0KPiA+PiBkZXYgaXMgYXZhaWxhYmxlIHRocm91Z2gga2ZkX2Rldi4N
Cj4gPg0KPiA+IFtUYW9dIG5vdCBzdXJlIG9mIHlvdXIgbWVhbmluZyBoZXJlLg0KPiANCj4gSSBt
ZWFudCB1c2UgZGV2X2RiZyBoZXJlIGFmdGVyIGZldGNoaW5nIGRldiBwb2ludGVyIHRocm91Z2gg
a2ZkX2Rldi4NCg0KW1Rhb10gb25seSBwcl9kZWJ1ZyBpcyB1c2VkIGluIHRoaXMgZmlsZSwgSSB0
aGluayBhbm90aGVyIHJlZmluZW1lbnQgaXMgbmVlZGVkIGlmIHdlIHdhbnQgdG8gY29udmVydCBw
cl9kZWJ1ZyB0byBkZXZfZGJnLg0KDQo+IA0KPiA+DQo+ID4+DQo+ID4+PiAgICAJYXRvbWljX3Nl
dCgmcC0+cG9pc29uLCAxKTsNCj4gPj4+ICAgIAlrZmRfdW5yZWZfcHJvY2VzcyhwKTsNCj4gPj4+
DQo+ID4+PiBAQCAtMTE5LDEwICsxMjEsMTQgQEAgc3RhdGljIHZvaWQNCj4gPj4gZXZlbnRfaW50
ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+Pj4gICAg
CQlicmVhazsNCj4gPj4+ICAgIAljYXNlIFNPQzE1X0lOVFNSQ19TRE1BX0VDQzoNCj4gPj4+ICAg
IAlkZWZhdWx0Og0KPiA+Pj4gKwkJaWYgKGNsaWVudF9pZCA9PSBTT0MxNV9JSF9DTElFTlRJRF9V
VENMMikNCj4gPj4+ICsJCQlyZXQgPSBrZmRfZHFtX2V2aWN0X3Bhc2lkKGRldi0+ZHFtLCBwYXNp
ZCk7DQo+ID4+DQo+ID4+IFNpbmNlIHRoaXMgZG9lc24ndCBsb2dpY2FsbHkgYmVsb25nIHRvIHRo
ZSBzd2l0Y2ggY29uZGl0aW9uLCBiZXR0ZXINCj4gPj4gdG8ga2VlcCBpdCBvdXRzaWRlIG9mIHN3
aXRjaC4NCj4gPg0KPiA+IFtUYW9dIHdpbGwgYWRkIHNvdXJjZSBpZCBkZWZpbml0aW9uIGZvciBp
dC4NCj4gPg0KPiA+Pg0KPiA+Pj4gICAgCQlicmVhazsNCj4gPj4+ICAgIAl9DQo+ID4+Pg0KPiA+
Pj4gLQlrZmRfc2lnbmFsX3BvaXNvbl9jb25zdW1lZF9ldmVudChkZXYsIHBhc2lkKTsNCj4gPj4+
ICsJLyogdXRjbDIgcGFnZSBmYXVsdCBoYXMgaXRzIG93biB2bSBmYXVsdCBldmVudCAqLw0KPiA+
Pj4gKwlpZiAoY2xpZW50X2lkICE9IFNPQzE1X0lIX0NMSUVOVElEX1VUQ0wyKQ0KPiA+Pj4gKwkJ
a2ZkX3NpZ25hbF9wb2lzb25fY29uc3VtZWRfZXZlbnQoZGV2LCBwYXNpZCk7DQo+ID4+Pg0KPiA+
Pj4gICAgCS8qIHJlc2V0dGluZyBxdWV1ZSBwYXNzZXMsIGRvIHBhZ2UgcmV0aXJlbWVudCB3aXRo
b3V0IGdwdSByZXNldA0KPiA+Pj4gICAgCSAqIHJlc2V0dGluZyBxdWV1ZSBmYWlscywgZmFsbGJh
Y2sgdG8gZ3B1IHJlc2V0IHNvbHV0aW9uIEBADQo+ID4+PiAtMzE0LDcNCj4gPj4+ICszMjAsMTgg
QEAgc3RhdGljIHZvaWQgZXZlbnRfaW50ZXJydXB0X3dxX3Y5KHN0cnVjdCBrZmRfZGV2ICpkZXYs
DQo+ID4+PiAgICAJCWluZm8ucHJvdF93cml0ZSA9IHJpbmdfaWQgJiAweDIwOw0KPiA+Pj4NCj4g
Pj4+ICAgIAkJa2ZkX3NtaV9ldmVudF91cGRhdGVfdm1mYXVsdChkZXYsIHBhc2lkKTsNCj4gPj4+
IC0JCWtmZF9kcW1fZXZpY3RfcGFzaWQoZGV2LT5kcW0sIHBhc2lkKTsNCj4gPj4+ICsNCj4gPj4+
ICsJCWlmIChjbGllbnRfaWQgPT0gU09DMTVfSUhfQ0xJRU5USURfVVRDTDIgJiYNCj4gPj4+ICsJ
CSAgICBkZXYtPmtmZDJrZ2QtPmlzX3Jhc191dGNsMl9wb2lzb24gJiYNCj4gPj4+ICsJCSAgICBk
ZXYtPmtmZDJrZ2QtPmlzX3Jhc191dGNsMl9wb2lzb24oZGV2LT5hZGV2LCBjbGllbnRfaWQpKSB7
DQo+ID4+PiArCQkJZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbihkZXYsDQo+ID4+
IGloX3JpbmdfZW50cnkpOw0KPiA+Pj4gKw0KPiA+PiBJcyBpdCBleHBlY3RlZCB0aGF0IG5vIG90
aGVyIGludGVycnVwdCB3b3VsZCBjb21lIHVudGlsIHRoaXMgRkVEIGVycm9yIGlzDQo+IGNsZWFy
ZWQ/DQo+ID4+IE90aGVyd2lzZSBzdWJzZXF1ZW50IG9uZXMgY291bGQgYWxzbyBiZSB0cmVhdGVk
IGFzIHBvaXNvbi4NCj4gPg0KPiA+IFtUYW9dIE9LLCBJJ2xsIGNsZWFyIGl0IGFmdGVyIGNoZWNr
aW5nIEZFRCBzdGF0dXMuDQo+ID4NCj4gPj4NCj4gPj4gQmFzaWNhbGx5LCB3aGV0aGVyIHRvIGRv
IHRoaXMgb3Igbm90Pw0KPiA+PiAJMSkgQ2xlYXIgRkVEDQo+ID4+IAkyKSBIYW5kbGUgcG9pc29u
IGNvbnN1bXB0aW9uDQo+ID4NCj4gPiBbVGFvXSBJIHRoaW5rIHdlIG5lZWQgdG8gY2xlYXIgc3Rh
dHVzIHJlZ2lzdGVyLCBvdGhlcndpc2UgdGhlIGVycm9yIHN0YXR1cyBpcw0KPiBhbHdheXMgdGhl
cmUuDQo+ID4NCj4gDQo+IFBhdGNoIHNlcXVlbmNlIGlzDQo+IAkxKSBIYW5kbGUgcG9pc29uIGNv
bnN1bXB0aW9uDQo+IAkyKSBDbGVhciBGRUQuDQo+IA0KPiBJIHdhcyBhc2tpbmcgd2hldGhlciB0
byByZXZlcnNlIGl0LiBZb3UgYWxyZWFkeSBjbGFyaWZpZWQgaXQgYWJvdmUuDQo+IA0KPiBUaGFu
a3MsDQo+IExpam8NCj4gDQo+ID4+DQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+
Pg0KPiA+Pj4gKwkJCWlmIChkZXYtPmtmZDJrZ2QtPnV0Y2wyX2ZhdWx0X2NsZWFyKQ0KPiA+Pj4g
KwkJCQlkZXYtPmtmZDJrZ2QtPnV0Y2wyX2ZhdWx0X2NsZWFyKGRldi0+YWRldik7DQo+ID4+PiAr
CQl9DQo+ID4+PiArCQllbHNlDQo+ID4+PiArCQkJa2ZkX2RxbV9ldmljdF9wYXNpZChkZXYtPmRx
bSwgcGFzaWQpOw0KPiA+Pj4gKw0KPiA+Pj4gICAgCQlrZmRfc2lnbmFsX3ZtX2ZhdWx0X2V2ZW50
KGRldiwgcGFzaWQsICZpbmZvKTsNCj4gPj4+ICAgIAl9DQo+ID4+PiAgICB9DQo+ID4+Pg0K
