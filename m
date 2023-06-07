Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92377C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 09:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152EB10E496;
	Wed,  7 Jun 2023 09:27:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1770B10E496
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 09:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrQ4TOhnqS4Gytph3TxbRgRLPUmllajT7FRa3hIe4Z4qrMaSiBskfnn5gfDrIZMUbzFxRCNOKDdwSKjFwEDG7zsE2YkmvRiaHqKtB3htR3GzVlD1U8VhPq4fH+HUELbJMI0x7cgQ9333P6feOJXGm6KB9VjFiMQ8b12SK82OtfUctOz+nWGCiU6TKrV30oBpNPNlluOUNPbaeIYvgcfjBB28vBYj+jfN7pEQF8X+QdFHsdnXL4sNmPoW8KMVNjAkzlGLaW6KvmWOwF4wEv3UHR+FRj2yg5aM8HvO6Qqu2EpwzG/v8Bb4Zo6tlZjFxC2kXmEX5RLzj5xLUQVLkSXt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W5YbEyf7dkjefi0FC62cCWD98+aQxAoVE+jrWZxvQY=;
 b=CgbPx/XDe1YumhsG7RDiiPpxOSn1vgOlXBh/vv28Gfs3JqUe4BmPFkIzmEe1+98f+FxkUNoxqnpJBhfouWfLde5PbKckmxr61C1LDpq/bBrKVC60xFXJHsGe1UxWZXqHt9dRk5hUWEfvmijHXe7RPZPCSb+0quJGAUaYsNz1SshmS/Wk5aNFcIou1i/qLWbTV45Y4ltjjQWksWo+/IpAYwYXiFs/aGfcC6RUrXHA2ZJ/F9Sj7MUw4KEu55jgC++dsUEezDO0xqIhwl/i+hhRn8wR68N6PxGanjespXkUW4BPhLpcvD3BscQeF9KRiL+pjg0f7RQrA9XWTfJqdASkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W5YbEyf7dkjefi0FC62cCWD98+aQxAoVE+jrWZxvQY=;
 b=cxYzKgcmd79vXh3vRdEPJCUFj9V/H5HxLXtDEyi9UPa2VVopaTqTuKwyy/HoRfqj67nkSB97+AVvZqSHsaYTW7GuXmk8usSkacc0e5GnyQqOlVpVO5mK0cmgLgC4qDvor1lB0pk2GfxoH5o44OgyDVQG6hMH+ghyKG62OstjSvU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 09:27:48 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::458d:c45b:487:9954]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::458d:c45b:487:9954%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:27:48 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/3] Add GPU page fault query interface
Thread-Topic: [PATCH 0/3] Add GPU page fault query interface
Thread-Index: AQHZjylb3mTRhZEPSUy5fF4HnpyjtK99/B0AgAEp8+A=
Date: Wed, 7 Jun 2023 09:27:48 +0000
Message-ID: <DM5PR12MB24696D4D3ABCE0A6779131BAF153A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230525165219.544671-1-alexander.deucher@amd.com>
 <CADnq5_PVG5tTSYc79_TMR9cY_kuame+asdG9SjRR1tih9DYVRw@mail.gmail.com>
In-Reply-To: <CADnq5_PVG5tTSYc79_TMR9cY_kuame+asdG9SjRR1tih9DYVRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ccfedc19-6ec9-417c-b38d-1240504f3301;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T09:26:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN0PR12MB6053:EE_
x-ms-office365-filtering-correlation-id: c85ff0f5-88b9-47cc-8894-08db67397586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1P9oFdERVE8o0Cc1p8kv5yIPPOs1JaHWBG1rxTwuhN29gq7T+xZM2a4zjgghBNf9yxJb2xaigEYbP5jk47tVAXU+MECfKl23IoQHGVhJG/LnuSbdHGYNli9zaa2ohismaFq7sCm+Bwqg2b3zkVhLgGgjmU8cPnLHvO/6SfBFLbg4Fk0NgfNW8OPoINOxc1jB6AmM3Ui5EaoPh2zlat00tlXouC1GT4maMCJbF+oFZGkUgxw4Q/kFu4q4ASdY1sPUC2Qpt9la8X33Lqn1RK52axSCNi+tSy44N6cKpZXJevg85pxv7rXrZUVxuIUGP6XLAqR1wYmpMSt7Vn+nlDXP1E7Hj9+/ILnJyXzhHo7jBHavsazcnlJ+sGDaPm5lXF7ZGSGSc6Askwfxlat1EDQr3ZCe1/yKPZVtxpRRwWzqvDl1VcXoVwLCt9lvnqM7ko3Uvdzpd/QIFHyzE06cOyd7BFEB8OdDEcNQocISb7GaAOl6OtwXfTvbqG2v9qIZiUUcMzGv7Z9/Iw0n0TnFJHXT1Su7RGpdqoNn7mazp3XHCNHI5RaurkQKE6//ko1D0wKi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(55016003)(7696005)(966005)(6636002)(64756008)(76116006)(66446008)(66556008)(66946007)(66476007)(110136005)(54906003)(122000001)(4326008)(2906002)(5660300002)(52536014)(86362001)(38070700005)(38100700002)(41300700001)(316002)(8936002)(8676002)(33656002)(71200400001)(478600001)(186003)(83380400001)(53546011)(9686003)(6506007)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1BCdDI4eFhVUXdHUy95ek92MDJKNjVXRzF4aEVUdEFxTU9uMmcrMDBxQmRu?=
 =?utf-8?B?ODRuWHg3MVRuRXdNd0d5SDFMRmlRQVFwN3p5MlMxd1lKU3V1ZndTTitqSUZR?=
 =?utf-8?B?bXFPdlFoTzZiR1J2S1cxWWFFRVhoRlloa2xCWlp2MmZ0WDNyYjRqUUg2L0ho?=
 =?utf-8?B?WHIzMER5SExiNTlWUCsxUy9qdGhIQjg0aGZOYVBEaGVZMDU0OG9IaEk1UEtQ?=
 =?utf-8?B?M2MzbTh2eUZTbmxnTmhpQ0ZWMXV3U1kxZVJlc0RrVzVpSnNabmpqQTdFTmdM?=
 =?utf-8?B?WTBSaUZqSjBRZzl0UFBBS3FQbDVYS2l2cVVHNFJPZm5WM3JVRlpkLzRLaThk?=
 =?utf-8?B?SGRDc3g1NWpYUjQzc2liZnBncTRGWERpUDIwcHdUblNlMDdrekZaL25EcnVZ?=
 =?utf-8?B?ek1sNlFwTzJ6dVVXZnZWWHQ0bHU4K2tuOXRVUmo0WTFhTldWdUZ2MVFZV25z?=
 =?utf-8?B?Mk1BQ1l0OE0vRUN1ZDhvdHZVWVVZZ1Q3ZTE5N1hhcjUrdTFWcDVLbWFWVWVS?=
 =?utf-8?B?aUxKZWpRczFlZ2dFb1lMdnBpTnI1ZWR1NDBKMW1ZYUFodXNXU2dyd051eUYw?=
 =?utf-8?B?Nk9YU2dWMXlDSmpNRlBkdUdJWlhqMDV4UE5nL0hMRDB3NXh0M0c1dTV1QXJO?=
 =?utf-8?B?TnFPTlNJQjNqOFk2bkJvOUVSTjYvYjhFVHRoWllTNHBXejhhdXBzMDZZVUZE?=
 =?utf-8?B?N3ZWRE5JV21mVDVZRU5YSjRCeXhSbDF3aW5sa1IwazNkVGxjQVB4MDlvSkUy?=
 =?utf-8?B?eGpuZDNIeTF3a1liZXl6OXFZTC9qNW84dzlXWjhhSTlVbWVEZTh3VzBaVXNn?=
 =?utf-8?B?KzRvZ2F6bFZ2L2ZBcklPMTkvQzNJNkpiUlgrZU9vaURta0FzWmZvWlp0Slpl?=
 =?utf-8?B?UEZaZ3g4TFhLWk9uWE0rV0RVUytHWWVUWWxVR1FQL0JQSXlHTXhLb3dWZlZ6?=
 =?utf-8?B?N1dXRmg3a3l2UmU0UXlWMFVwbU5tM1RrY1RVdlhzMlVQYzhubjlmMzcwKzVK?=
 =?utf-8?B?Vk9rTHNpZ2FlaWsxK3hTNW8rQUhPSld4VldCZ1FiK3lKajgyVFVTdUNET2Nr?=
 =?utf-8?B?NEIwblNWVCsyUVRIb0ZGQzJReVpuNGNrc2taZkh2NEk1RFEvcmE3VWk1ZVVs?=
 =?utf-8?B?NzAzM3Zabzh4V3I0ZFRxWEUvTzJ0bWhPMkxnNFllcUZzakI1a21WSjUxNzEx?=
 =?utf-8?B?Q0ZReUJyMTZwMDhQbUxtb3NDR3p3V0haRHc3K29NbkNSRUNnZGZOYUZ1TjhJ?=
 =?utf-8?B?bFZ4MEFkOElrSDBqcm8yc3JCVmRwMm9ZUXlJMUhoeDdzWUVDZDRLeGVFbTJJ?=
 =?utf-8?B?amZLUC9vVHF3OW8vcFYvalcyUTZBbnBTaXNXUU1neFhjdE9od3V0Qi9rcVkz?=
 =?utf-8?B?eVQycHdDSXlsWXVZSGFFZks5Tys0SllOUXVQQXYySENaaVBQLzZRNVZVL1ZP?=
 =?utf-8?B?VVhkSmdxRSsxckFXc2I5aUtNb0h4MkN2ZHE0QVdxYUJpd2c0QXJjand1RzJz?=
 =?utf-8?B?RS9YOS92R3VrM3FpeCtNNUpLaW1OZU9qektoT1ZrN2preGJKcVk2THBlOTJ5?=
 =?utf-8?B?YXFlQ2x1b04zaEhNc21hdlFyY1V4RUxEM0pWdW4zYWduL21Fd0ZFYWovcUpK?=
 =?utf-8?B?VzY2N2tKeVV5KzdXeFdxY1czSTZKQ1NnaDZ4Qk5LbzZDdEJmTHNhek9mUzBJ?=
 =?utf-8?B?dXhncnlOS1Z6emIwTUR6ODVQMnNVZU1OVlZOTXA5NjZrYXprUWIyUVJIVzBx?=
 =?utf-8?B?SmR6SHd0Vk1ZU25VM0VlUWErM0VDMUNveE8ra1BSeXcrcDQwZFIxcDd2TWts?=
 =?utf-8?B?Y051djNla0ZncWR1NGlveEI4eGVOU2dmYTlCVms4K0o5YkJ6eHZ3RmlXakNR?=
 =?utf-8?B?ekdCbFpXMnlya0tDZ3NNWVRuQ3JNSm5sZU93T2lhRkF1V2lBR0JubjNRbWJ1?=
 =?utf-8?B?dng1OEhMTHNzKzZVNVdiRVpscjZhdXA3Y29XOXdyTTRIZ05HSVVseU53NTdk?=
 =?utf-8?B?NXBLRVY0M1JyZ2JLbTV4VzMzeVN2YjgrOGtRWDBOQzRYRlpJR0FQMEg2eU1O?=
 =?utf-8?B?WlR6ZFhOWDlzWm4yMnF6S3dMZEsyYnZTTEVFVHIyL2tyTUpuSHJBaTRHa09v?=
 =?utf-8?Q?pgXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ff0f5-88b9-47cc-8894-08db67397586
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 09:27:48.5328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lk67FEu3iMW75L5bsKuVoeXlT2dGDBnh96ti8/BGXsFeneBW4tOLgrR7f37ajTDhC/7aZuN0CsfDmnf6k1Hog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "samuel.pitoiset@gmail.com" <samuel.pitoiset@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KV2l0aCB0aGUgMyBuaXRwaWNrcyBmaXhlZCBpbiBwYXRjaCAxLCB0aGUgc2Vy
aWVzIGFyZTogQWNrZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KDQpS
ZWdhcmRzLA0KR3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
YW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxm
IE9mIEFsZXgNCj4gRGV1Y2hlcg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDYsIDIwMjMgMTE6NDAg
UE0NCj4gVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gQ2M6IHNhbXVlbC5waXRvaXNldEBnbWFpbC5jb207IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBBZGQgR1BVIHBhZ2UgZmF1bHQgcXVl
cnkgaW50ZXJmYWNlDQo+DQo+IFBpbmcgb24gdGhpcyBzZXJpZXM/DQo+DQo+IEFsZXgNCj4NCj4g
T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTI6NTLigK9QTSBBbGV4IERldWNoZXINCj4gPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgYWRk
cyBzdXBwb3J0IGZvciBhbiBhcHBsaWNhdGlvbiB0byBxdWVyeSBHUFUgcGFnZQ0KPiA+IGZhdWx0
cy4gIEl0J3MgdXNlZnVsIGZvciBkZWJ1Z2dpbmcgYW5kIHRoZXJlIGFyZSB2dWxrYW4gZXh0ZW5z
aW9ucw0KPiA+IHRoYXQgY291bGQgbWFrZSB1c2Ugb2YgdGhpcy4gIFByZWxpbWluYXJ5IHVzZXIg
c3BhY2UgY29kZSB3aGljaCB1c2VzDQo+ID4gdGhpcyBjYW4gYmUgZm91bmQgaGVyZToNCj4gPiBo
dHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vbWVyZ2VfcmVxdWVzdHMv
MjMyMzgNCj4gPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9kcm0vLS9tZXJn
ZV9yZXF1ZXN0cy8yOTgNCj4gPg0KPiA+IE5vdGUsIHRoYXQgSSBtYWRlIGEgc21hbGwgY2hhbmdl
IHRvIHRoZSB2bWh1YiBkZWZpbml0aW9uIHRvIGRlY291cGxlDQo+ID4gaXQgZnJvbSBob3cgdGhl
IGtlcm5lbCB0cmFja3Mgdm1odWJzIHNvIHRoYXQgd2UgaGF2ZSBhIGNvbnNpc3RlbnQgdXNlcg0K
PiA+IHZpZXcgZXZlbiBpZiB3ZSBkZWNpZGUgdG8gYWRkIG1vcmUgdm1odWJzIGxpa2Ugd2UgcmVj
ZW50bHkgZGlkIGZvciBnZngNCj4gPiA5LjQuMy4NCj4gPg0KPiA+IEkndmUgYWxzbyBwdXNoZWQg
dGhlIGNoYW5nZWQgdG86DQo+ID4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2FnZDVm
L2xpbnV4Ly0vY29tbWl0cy9ncHVfZmF1bHRfaW5mb19pbw0KPiA+IGN0bA0KPiA+DQo+ID4NCj4g
PiBBbGV4IERldWNoZXIgKDMpOg0KPiA+ICAgZHJtL2FtZGdwdTogYWRkIGNhY2hlZCBHUFUgZmF1
bHQgc3RydWN0dXJlIHRvIHZtIHN0cnVjdA0KPiA+ICAgZHJtL2FtZGdwdTogY2FjaGUgZ3B1dm0g
ZmF1bHQgaW5mb3JtYXRpb24gZm9yIGdtYzcrDQo+ID4gICBkcm0vYW1kZ3B1OiBhZGQgbmV3IElO
Rk8gaW9jdGwgcXVlcnkgZm9yIHRoZSBsYXN0IEdQVSBwYWdlIGZhdWx0DQo+ID4NCj4gPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgIDMgKy0NCj4gPiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgfCAxNiArKysrKysrKysNCj4gPiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgfCA0NQ0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgg
IHwgMzEgKysrKysrKysrKysrKysrLS0NCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYyAgfCAgMyArKw0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTFfMC5jICB8ICAzICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18w
LmMgICB8ICAzICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMg
ICB8ICAzICsrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICB8
IDExICsrKy0tLQ0KPiA+ICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCAgICAgICAgICAg
fCAxNiArKysrKysrKysNCj4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgMTI2IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDAuMQ0KPiA+DQo=
