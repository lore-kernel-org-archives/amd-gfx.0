Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C1DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 12:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA7960EBB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 12:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AA7960EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD04E6E48C;
	Mon, 11 Oct 2021 12:15:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 125BC6E48C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 12:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD2MG/lhBnHcPj6cuWIgipAbiIi7ZEvGuSiIN/VXaAItsl7jg5cREAIwPDQaq0WW7PotVcqcgpAjpYNhVb8LLMKZODI7NkTZmUIPWcPniDRTs9ItSGWhDpbefU5k94IMnvUDzreIeojj1ody8ZeYHFodBrv9BfUJNjACqjLKVUw3te3HTVTAI+zaaehff85GoSBB+tTb0MbTopzjItek+u+UmYk/TSU9lq8Xh7Z28N8MbyFtHI5AV4O0+A6dbYkaaRCkKcR+qqZ6c07DpSjB32LAgunnHb5XUCO4l5fI7fTcYyvroXTUK8OQ2WorTX6wGE7YuZChtazYewJpv0lV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3SLbpXF971ryNmYT0PwXOiWIIEbfOzgMsAzvr908fc=;
 b=MKo9jfSku991FzbRzM/R0Gp7mlxAmcd7aC7SlB5sel9SdyB1t6lju2zd3BJ9ZLmiKNKBBi48aUPWofzX+xYq1h3e2NwSS5nuJAMWHS+8YqTk7DlQBv/j/XGmnNnEKsBA7nnQUpXKPMZ2xe4qs27mvJEHsq9LCMU5QcwPj0cHTxAV2r2kHeHQL+e7y0/oXtFXtYRolxgShzGBfBUKlgb6ZQkPgkkTdNxwVVl1iWBaAvXTQmSMbnl9RJrHSbDo4Z2LYuqgD/zH86U/nyeaJILAx8kw/PU2DD+0HLhcWYiRExwUVBgiGf5UOA7Lt+5/JiZrFbClTm/8q7WqP+1IoE2HuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3SLbpXF971ryNmYT0PwXOiWIIEbfOzgMsAzvr908fc=;
 b=Fh/Z55x9go7wpg2KxxFzLfMo8xIGxqrklipViAK4Xw5C/2rxYBI551J5F67XYH1+sdsuIJNkp53xa5rf/j8zTtocpByySfJT61RmO4+fKjxWb990tze7YE8Uj9n4dTXe/vQLuCfcJ1uEWNK/e4P2Qh5WDl8xxRzV8kSBdlJl3NI=
Received: from BN6PR12MB1187.namprd12.prod.outlook.com (2603:10b6:404:1b::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 12:15:05 +0000
Received: from BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d]) by BN6PR12MB1187.namprd12.prod.outlook.com
 ([fe80::84b6:69c0:9fb7:cd1d%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:15:04 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: youling 257 <youling257@gmail.com>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu, James"
 <James.Zhu@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Topic: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Index: AQHXtELZo07wLtaE6kqRLoUB3h9VLqvNZa4AgAABQ4CAADzXAIAABtsAgAAf/GA=
Date: Mon, 11 Oct 2021 12:15:04 +0000
Message-ID: <BN6PR12MB1187DADEBF773651F2C1BEC5C1B59@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20210928082819.205231-2-yifan1.zhang@amd.com>
 <20211011061326.13718-1-youling257@gmail.com>
 <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
 <BN6PR12MB1187E3D949682D0714EA6253C1B59@BN6PR12MB1187.namprd12.prod.outlook.com>
 <CAOzgRdZmOcg19wL00u-S6MSCwBufJBzpVDo2mQYKiReF7JE0Zw@mail.gmail.com>
In-Reply-To: <CAOzgRdZmOcg19wL00u-S6MSCwBufJBzpVDo2mQYKiReF7JE0Zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-11T12:15:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e00afb17-383a-4808-bd1d-222377cfa5fb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ed87d4-47d4-4fb9-e947-08d98cb0c220
x-ms-traffictypediagnostic: BN8PR12MB3282:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3282F2CB961E9A45289D277FC1B59@BN8PR12MB3282.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s979oTBQPBLnrJdY3nFvemS7b0h8ldGhknckhNc3TndI+/Dx/IaZd+X0fd3IeF3rUublOhgCHcA1TOjHJBl8Tvt/fEQJWGP8NEluYgNTMkEwGeC5PjXIhLK8XTD+aqiC9kQV7IlzqdwI6pVzC+VRzSCmoeRqPbntAnX8I+RJBGy/20/xSG8xML1WfJLQYHmPJ0IBkb9cMUDt3i85+VAA7bZfv9jbXxhPtcrAey1+WTpeqWdjaJuuNdt+2WlRyRjrTSTogsj45HU2Ny8nLideMiHHe7dNuZTZJKTKiLdC2U231j5sN2YoHU2aROKQROrgGqR0bml98ybpVuRooHEFZ1+HhcuGlOrsABaU1uXvEg98CRSzmqS3h4U5KxL18GrmGt93q6p0wc/NPQe0PNLvqafsIWjI0UF6UTjI5/vtCiQm1oZXltB8GPudINB9wt7dj16Lv5bcWOL4+LpZxW0XPY3GABleYxIyRVqlbh0mcsHjHAY9zQWuFjALFWDWHPp//ALE9+xOyyfc9XXXV/lJPZ8nBIvLycczKYgGJ+CMeD1UlNpNjKJgDfb/VVKx7gxCWVc/xwO9iZTdWv51CBIEe/YqbdxJ0aM6qOzMlofs5PHZdtFpIKuvKXnf+hdY6UcMZMqgbneKzpm6ne5nMch8LNvtFOA4VtG0HGdOGAk/HMsq9a/xLBnb2Gx1Uhr9FIKZO1RflkLghA+YrTlsNiuEpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(2906002)(66446008)(38070700005)(52536014)(83380400001)(38100700002)(6916009)(4326008)(71200400001)(86362001)(508600001)(76116006)(33656002)(7696005)(64756008)(66556008)(66946007)(9686003)(26005)(66476007)(186003)(55016002)(54906003)(5660300002)(6506007)(53546011)(8676002)(4001150100001)(316002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXVTUGJqL0h5M0plZ1cvVytpamZEQVNYdXRodVp2dk5zbk1QbFJnRXYrZVdm?=
 =?utf-8?B?M1NacExNT0p5VkhpQUpkcHZNVFZEdlNIV05tbTF0N1IxVmxNbEJSdEZTSTUw?=
 =?utf-8?B?Y3A1NUdqZkpjL2g2eDllVkY1UmNFU252N0dGRHlkcytDMFlZVWZvcmlzTjBi?=
 =?utf-8?B?cU9mZTE3VXRsajFnbEFza0tGTUFsTm43U2YzZjlBZk9NTEdHTHNYQWlVMHJL?=
 =?utf-8?B?UW1YdjZFekZZUHZyOEpobWNHNkFKMHgrTFdWUExEeXNxWlRKMk9ERFlmNGZm?=
 =?utf-8?B?R3lQblhZL0YzNDluU28wVXhUR3FCdVNpbmdzQ0RZR2IvQ3FKR1VjQmRhOEdU?=
 =?utf-8?B?ZVZ0V0QxSEJEWjcxRzY1SEFKL2pyM01GZVlMN2FHcy9pQmR1ejV5d2NxKzNC?=
 =?utf-8?B?L0ZXeTlocDFremphQWJqSVVmcG1QVVNva1kwWWhNOE9ENWRQZjU3MDRvckVC?=
 =?utf-8?B?SVNaQkNacStBTmdrSEFUWWtzemxTdjE3OHNKZFQ1RVhTQ3RGbmFhdGoxVEtF?=
 =?utf-8?B?eGt0bGxpWWtzajlOQ3ptRHNKZmU4UFhEZVlOOGxhcE52RVdXWU92YzJKNXo2?=
 =?utf-8?B?QmZFUEJiMEhJb2VBTWtYS2xGM1hDTjY2dFBDWEpaODNmWWNreFhwWWlEWXJL?=
 =?utf-8?B?eHZkdHp0cGRROEFxYkFleWlqY0lQQjVlelpTNklncFcxSUhTazFsd2VJV2Fo?=
 =?utf-8?B?R09vRGdKRDZsOWprQTl1bVNSNk0xYnc3MWc4SmZUaWVqdm9mYldQZGx5blhY?=
 =?utf-8?B?ckQ4dlEwWXFqV0g2WHRoT2Q0WkNrNjNVeWFyd2xrcHA3NjhrcW51QXNSMEUv?=
 =?utf-8?B?Um9TU1F4akMySk9OUVQ5elZvVmRpd1krd052VEYySXJ4dmRZRUxSQms2dGow?=
 =?utf-8?B?cHRwa05mY3pjK1FFK2FFY0pZT0xSaFMwMThTanhxTkhZZFNIMTlTY2dwK3cr?=
 =?utf-8?B?QkgxUzJiSnJjaytacW1PU2krQS9IM205ZTBpQ3I0YzlZbGZPS3hIeGpNOTJq?=
 =?utf-8?B?b2xmc2pCUDNyNzJLNDJOWnR0a3REcXpxRlE1d1N0aUphV0FodExDaHRFQkd2?=
 =?utf-8?B?eHFyRk5QckRsRTBrNzBQSnluSWl3S0ZYVzRPYS9lNGtyUE5OWnlVRVJIMnA2?=
 =?utf-8?B?b0NGVmROdmpBTnVUeVc5WHJwdWo4Z1pVbGRGRUdrM1h4UkNyc2JtMW1CZ3J4?=
 =?utf-8?B?SXlJZC9rei80RndNWFpoaTFqc2pHL0p1dHN6UUc0aWMyeExkcWcwYUkrbHdC?=
 =?utf-8?B?b01sZnF6Q2VOOHM0ZmhBTEpXQXI4aTNjWFVjL2w2SVorZEY1a2dNRHpZMTMr?=
 =?utf-8?B?ZW1JR2hzSWhzdkdXRXlUTGY5QlJBVk9nV2lWSzRpNVhDY0VNbU4xL05SdGJz?=
 =?utf-8?B?amtadWIzaGt4Q2ZSdjRaS0FQMUtlYUp0b1ZVY0pEQ0ZuVEVkNVZuK0lobjll?=
 =?utf-8?B?ejN4cm4zbTc3YUJVaU02K1JObU1jcENPczZFeDNJNXg4cFVWR1BqUTRkZngv?=
 =?utf-8?B?TlZKSzFML3g1N295UUg1T0x3MzhsTm92emx2TmlOeVUxN2o1cVE2d2VFYU9N?=
 =?utf-8?B?Sk11K3F6RnB0elVQQ0F4YnFOcXRwOXpPZmpDclppZUMyN01Sa2JRbXF3Y09s?=
 =?utf-8?B?aHhGN2dOc3A0Skp5YmhsOTl4ZitUNjA1MWhRanQxQTA1SGw5Mjc2SFdvanZO?=
 =?utf-8?B?eGFFeVBRNmVoQzdPYndrWTN6bW44ODFyZXgxTjNoR0s1ZjN6QWlBQnZvM3M3?=
 =?utf-8?Q?Eyko30aGmY5vNM/l5hRlB6yy3wZT6Gh8dvh7GOM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ed87d4-47d4-4fb9-e947-08d98cb0c220
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 12:15:04.6486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n968dAfpny0I7nZHs6Tu/EZUpzZswGDCkCxwTfPPhq52MZBcigNRcQSmarklFRYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KR3JlYXQuIFRoYW5rcyBmb3IgdGVzdGluZy4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IHlvdWxpbmcgMjU3IDx5b3VsaW5nMjU3
QGdtYWlsLmNvbT4gDQpTZW50OiBNb25kYXksIE9jdG9iZXIgMTEsIDIwMjEgNjoyMCBQTQ0KVG86
IFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+DQpDYzogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7
IFpodSwgSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IGRybS9hbWRncHU6IGluaXQgaW9tbXUgYWZ0ZXIgYW1ka2ZkIGRldmljZSBpbml0DQoNCnRlc3Qg
dGhpcyBwYXRjaCBjYW4gZml4IG15IGJvb3QgYW5kIHN1c3BlbmQgcHJvYmxlbS4NCg0KMjAyMS0x
MC0xMSAxODowMyBHTVQrMDg6MDAsIFpoYW5nLCBZaWZhbiA8WWlmYW4xLlpoYW5nQGFtZC5jb20+
Og0KPiBbUHVibGljXQ0KPg0KPiBIaSB5b3VsaW5nLA0KPg0KPiBXb3VsZCB5b3UgcGxzIHRyeSB0
aGlzIHBhdGNoID8NCj4NCj4gQlJzLA0KPiBZaWZhbg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiB5b3VsaW5nIDI1NyA8eW91bGluZzI1N0BnbWFpbC5jb20+DQo+IFNl
bnQ6IE1vbmRheSwgT2N0b2JlciAxMSwgMjAyMSAyOjE4IFBNDQo+IFRvOiBaaGFuZywgWWlmYW4g
PFlpZmFuMS5aaGFuZ0BhbWQuY29tPg0KPiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPjsgDQo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBpbml0IGlvbW11IGFmdGVyIGFtZGtmZCBk
ZXZpY2UgDQo+IGluaXQNCj4NCj4gZHJtL2FtZGdwdTogaW5pdCBpb21tdSBhZnRlciBhbWRrZmQg
ZGV2aWNlIGluaXQgYnV0IENPTkZJR19BTURfSU9NTVU9eSANCj4gQ09ORklHX0FNRF9JT01NVV9W
Mj15DQo+IFsgICAgMC4yMDMzODZdIEFNRC1WaTogQU1EIElPTU1VdjIgZHJpdmVyIGJ5IEpvZXJn
IFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiBbICAgIDAuMjAzMzg3XSBBTUQtVmk6IEFNRCBJ
T01NVXYyIGZ1bmN0aW9uYWxpdHkgbm90IGF2YWlsYWJsZSBvbiB0aGlzDQo+IHN5c3RlbQ0KPiBb
ICAgIDcuNjIyMDUyXSBrZmQga2ZkOiBhbWRncHU6IEFsbG9jYXRlZCAzOTY5MDU2IGJ5dGVzIG9u
IGdhcnQNCj4gWyAgICA3LjYyMjEyOF0ga2ZkIGtmZDogYW1kZ3B1OiBlcnJvciBnZXR0aW5nIGlv
bW11IGluZm8uIGlzIHRoZSBpb21tdQ0KPiBlbmFibGVkPw0KPiBbICAgIDcuNjIyMTI5XSBrZmQg
a2ZkOiBhbWRncHU6IEVycm9yIGluaXRpYWxpemluZyBpb21tdXYyDQo+IFsgICAgNy42MjI0MzBd
IGtmZCBrZmQ6IGFtZGdwdTogZGV2aWNlIDEwMDI6MTVkOCBOT1QgYWRkZWQgZHVlIHRvIGVycm9y
cw0KPg0KPiAyMDIxLTEwLTExIDE0OjEzIEdNVCswODowMCwgeW91bGluZzI1NyA8eW91bGluZzI1
N0BnbWFpbC5jb20+Og0KPj4gbXkga2VybmVsIGNvbmZpZyBDT05GSUdfQU1EX0lPTU1VPXkgQ09O
RklHX0FNRF9JT01NVV9WMj15Lg0KPj4gbGludXgga2VybmVsIDUuMTVyYzIgImRybS9hbWRncHU6
IG1vdmUgaW9tbXVfcmVzdW1lIGJlZm9yZSBpcCANCj4+IGluaXQvcmVzdW1lIg0KPj4gY2F1c2Ug
bXkgYW1kIDM0MDBnIHN1c3BlbmQgdG8gZGlzayByZXN1bWUgZmFpbGVkLCBoYXZlIHRvIHByZXNz
IHBvd2VyIA0KPj4gYnV0dG9uIHRvIGZvcmNlIHNodXRkb3duLg0KPj4gbGludXgga2VybmVsIDUu
MTVyYzUgImRybS9hbWRncHU6IGluaXQgaW9tbXUgYWZ0ZXIgYW1ka2ZkIGRldmljZSBpbml0Ig0K
Pj4gY2F1c2UgbXkgYW1kIDM0MDBnIGJsYWNrc2NyZWVuIHdoZW4gYm9vdCBlbnRlciBteSB1c2Vy
c3BhY2UuDQo+PiBpIG5lZWQgcmV2ZXJ0ICJkcm0vYW1kZ3B1OiBpbml0IGlvbW11IGFmdGVyIGFt
ZGtmZCBkZXZpY2UgaW5pdCIgYW5kDQo+PiAiZHJtL2FtZGdwdTogbW92ZSBpb21tdV9yZXN1bWUg
YmVmb3JlIGlwIGluaXQvcmVzdW1lIiBmb3IgbXkgDQo+PiB1c2Vyc3BhY2UsIHJ1bm5pbmcgYW5k
cm9pZHg4NiB3aXRoIG1lc2EyMS4zIG9uIGFtZGdwdS4NCj4+DQo+DQo=
