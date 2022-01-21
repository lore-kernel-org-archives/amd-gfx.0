Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972BEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 01:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DAC10E74D;
	Fri, 21 Jan 2022 01:44:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8985C10E74D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 01:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJeQEcyiJElqOuhxorRADTh/g+U8dqvg4O2EnOIwbhW2ucHzLkXf2DnGEx+IYbalc5fLHYAo1fXuJR5QkNJqq2PthSUz6pcOLDbS/QmL74UQG5nqjrr7RD6ABY+C7vCvLYAwuxqvxM8ZufEtUU0b+JuIHC7+E4/wLSE5LxZWUs9XMx/sg8KeWSxXSYi+SGjS4DusrjqwISr+ftB2qTSoFbR1e4RQ6vHJf+jmlb+IsFtnhD7HpL77siZ/jbSI0chT8F1h1TpcHU35V+/D1sK0gRUK4WXvY82v54UmUINIeLgegjNu1g+ZUEH3xlpcn1LJvoD/mPw+KsEETDcEOvUqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c28su02TUzpYJrfOcMeRO1Y5EZl2md9sKsmJN5bnSRg=;
 b=P0e2Erh2a73LxnDqlARkadLO72lKZDbsEiYSnplVOeSY68NbCubrHZpnYKwduo+2StZCJLhWJf0C8EIwvLyApSkCsOTsPegkA/5pbMOyX6iyBaUwQ0qYtu95dqFgnxngeyORJxYQwg420P4vNHb/WUHORjEH6TZo4niu9glJYnYHQSNFWQgVH+kqZ4givWzP9Z1UfVQipRUDRD62XdXITjumnBE0HjRraPhjpJzUsiGY+A7MTOJut2QagvcerYfsvwtgIZTowAfhL6LHsizS+fQ1yCOB/IjeweV6CAFxMAcl02D2RZf/SDTYRdQnJkFPxIvglYeh9GxJ7WcRlLfHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c28su02TUzpYJrfOcMeRO1Y5EZl2md9sKsmJN5bnSRg=;
 b=3TG9RArnVOSRwvqJAbvhHF/GtGxgR3BFrgRBYdNEIGf6lNs3o8AsMuF4+O8kMWt8pLIhXnFcrupSYPrMeJZcMVXZ2mweFH0YMwSCdoij0KXUTOPanJm9tfjkmf+yVJfs/CL0aIzAU/E3XlPCMPxlDMhLXpIZBQBvvzP8pfgzE/M=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN6PR12MB1828.namprd12.prod.outlook.com (2603:10b6:404:108::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.11; Fri, 21 Jan 2022 01:44:25 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 01:44:25 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix kernel compilation; style
Thread-Topic: [PATCH] drm/amdgpu: Fix kernel compilation; style
Thread-Index: AQHYDljeTpDimnpIG0W0VO2XtNtju6xss/ww
Date: Fri, 21 Jan 2022 01:44:25 +0000
Message-ID: <DM5PR12MB2469BDC26AC4E356F258A827F15B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220120235227.90683-1-luben.tuikov@amd.com>
In-Reply-To: <20220120235227.90683-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-21T01:44:05Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c219df6c-6a04-444b-8b47-8023c9571e85;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-21T01:44:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: f9b456b2-2f59-457d-81f5-843ea1177a64
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e0bc81c-8fc0-485a-c3a6-08d9dc7f8e0a
x-ms-traffictypediagnostic: BN6PR12MB1828:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1828CC593A7209783FCA1770F15B9@BN6PR12MB1828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wAfDOd6+LNsPHytm+Ta5jIZKZvD6FRXupy6m31TdyTwPAyQKGIscJj6f9CAo+ka5vxNSDl6Lh0cHrpU5HJABD46v8rGfj1RHyFwfls9MAWx0yG+PzupYImzrz9e4Yan2Y+CuoIK11MXssP233HS4/Gep8EQtyTCZqB71lZ0Y82irXQ1utHrwNJnaZNVpu3b+7AgDd+561xWe+nQiJwe21VGnYvtIBkJ2DhS+HWbMRGTUtsc9Uly/iqPmM7KBaju6kRZdUvwFqwO6nUuc83DDcJhcLqRzIE0LN9H1gmxu/E5lyxGG1uMmVIj0vCZF/qHJSMbTPKuZEJedLxBtaADWly20eYpTYWkNV+t3ZaBSnkhcGBvjGXrILeZmUURI3nLm5tudLvEkoSmu/yNa6RY3q9nJ5t6RupblYgCmP62J5ncC1k5aX7DD+JOSUh0nZbjZE3fURNVeCkO484DQ9+H9ELDXHu/k7fZYC9+vcadyjduL2mDdVh4v/8Maxs9a3Sh/IAngZY92AaY7ejJR9cxLX1MTyTjl0K3GAG4EvaxOiCoHX/tZpWmWV3BqlHytk0t9rWdH+ODd7F0gGfIghBzHRSxz3JXrSPUSNh5VI9N4GPkhHUaQofhiFno++n6t1Xx6Um+Pf1SXLXUHTQTLhBbdoJCchAPV3H1BFV5hDH+aQJ9FRyFHc36fgKS7aJtvkuR7/JhKdEQqZcA4E7niFTjRbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(64756008)(76116006)(66446008)(66476007)(66946007)(6506007)(2906002)(4326008)(7696005)(83380400001)(38070700005)(71200400001)(66556008)(38100700002)(54906003)(86362001)(53546011)(9686003)(122000001)(186003)(52536014)(8676002)(316002)(33656002)(508600001)(55016003)(5660300002)(8936002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1dEMDQyNHk2YlBkdGFQTUxtbkkzR201UTB1dEIyd0lJTlNWMVBGdXVpY1BX?=
 =?utf-8?B?QTV0QkN1OUs4c3lJZXRoWERRWWNLMVJic01LYXRvUEVYbkNhY0svQkZtUERP?=
 =?utf-8?B?TDdCQW9aaE1FTlRhaUJnT09IL1ZzMWMvaitPd0dhSytWZkRXbEdBN3hxWThi?=
 =?utf-8?B?OTF6Sk9mY3pwaUpGajF5Q0JFTU5UMG9IekQzdVBnL040dFh4alpBeFJlOFMr?=
 =?utf-8?B?eUtWclBpREw3VVJsOWNQQ3N3aGkxTmM3Y2RPbDlCSFV4Uk9OU3JzS0dvMkxm?=
 =?utf-8?B?UG10UEozazJFZDRhSU9JcEs2TmRKaFpMYXc0RVo3c2J0VDZ4Z0hpampSNkpE?=
 =?utf-8?B?dmdSTGpyMUpQMjQ4b1h2SDNWL0UzRGhRYk1KYWRvenN4RUhzcWlHekRMN3lS?=
 =?utf-8?B?aC9HMlpZTzZHazZrblBvdzA1SnR6Ym0yQ00rUWZIUExpWlNBaFExNUFVRTZj?=
 =?utf-8?B?Y2pvK2lyWEhJb1NKZ29xS1hPR1NHTnZNd0hCRUlHQWtoRE5DMWNlZkd3cmJk?=
 =?utf-8?B?WE1WTTJzaHZYYVN5VVBuODRsTUJGd0xmcTV6N3cwNEhyYkZQbjNXNGFxMWpX?=
 =?utf-8?B?cHJQdWxvNFJnL3N4RmxRSGdRZFUvdVR3ZXpsR0lucWJNVGYxK1RIOCtGem94?=
 =?utf-8?B?QjhXNGdyUWdoWUtRSlQ3RjVpbDNOdTZ6dXZHcHpBSU56d29BSlBHTDA5Lzg1?=
 =?utf-8?B?N0ZEOStvSFIxZG05WVBuM3o0NGgxN3Q4V3JGcllXMm9oa3cxaHJqSGNpNWNT?=
 =?utf-8?B?aHdadTZMZVc1cEJ0ZDdLZ1MyN09LQ3IwTG5DcUNEdXkrM0lET2FQUEJCTnlX?=
 =?utf-8?B?d21Kbjg5anZ5cTQ3YTJ3VDM2TU5hUG9tWmRRZzRqYkVpaW9DTXpaakNPQWNV?=
 =?utf-8?B?VGYzOHNWVEJqNXdzR2lqTnpZdnBiN3diT2UwZ3NTc25ubFdhSkJKNzdzRklZ?=
 =?utf-8?B?cjhqc0RzTWhpa1RYTHZ1UEJ1ZlNuSkN0M0QxMWxyUWF0UDlOc3hzMkZKUlhB?=
 =?utf-8?B?NjVzSVczZXBkWjl1VndqWXBZRk9yR1V3SjJvd1QrTEtVR2xJM0tFTElWbEh3?=
 =?utf-8?B?S1crZ09KNlRsb1NNaGJIMEdUSVlRc0FtTnFTbW9iaEFDZEtJVDVKL1EvODBt?=
 =?utf-8?B?RDJ1a1pxV3QyQ2E2N1lHM1BhdUdzT3lOWm5lQ2FBS0p6L2JXZXJpTVVabXN6?=
 =?utf-8?B?T3FYSEljY21Ma2ExUUtlOENtTUtHb1BkbzZDRnJSOGhxeDdzcGllWjFSY0RS?=
 =?utf-8?B?WE1MU0Rmam9EYS9XSHE4UlVWcFliWFRhZERYaEo3RnFacDR2eHg4K3E5d3NC?=
 =?utf-8?B?a29naHVsYjZHK0k1cE1hVXZYNGxPODF6QWNmYko3ZkdTalhhb3ZvcTRhaExU?=
 =?utf-8?B?SE0yb0RwRXR2YTg4SG5OWWx1Wlkva2U0eHNtZ1RnRW9jSVZyRS9ieS81SjVW?=
 =?utf-8?B?MnQrQjRsQzVmSnkvcXdibkJSQTJ5OTdUTzRsMTN6RmV1NlVCcTFFTWlBUTF2?=
 =?utf-8?B?UCtHMEtVTktVazd6UDRTWEw3RUttUDVFaG53SlR4YzBmV3FVM3JjQW9VY0g3?=
 =?utf-8?B?b1V0WlE1Ny93SHN3N3gxZzk1amRsUDRBMDEzNUVqcnZGK0REVTE5UERnbnpZ?=
 =?utf-8?B?TEthNzdNTnI2blRWWlBmWmN1SG1BUmJIT2IydnU1K0JRUzVYdkVTYkovZXMw?=
 =?utf-8?B?UFpmNXBzNHljYkZJay93RlVvQ0NkR0lHS0JJcFZUd042T0NGWjZaeGdZdjVH?=
 =?utf-8?B?UzVlK1FoQk9obTFoZmRycWxKSnhmSkM1OThwQ0tsRklsVWs5VHJSV05IR29q?=
 =?utf-8?B?dDlaR2FvelN6eHRNSXFyKzRLMEZmRE1YT01BdzIxRmM5ZTA1NlFqbm4vWktz?=
 =?utf-8?B?QkxuSE4rQjlTL3VLVDlWTUNNcXhHOXFwdEt5Y3Q2aXBwblJZdnJES3Bnbmo1?=
 =?utf-8?B?TGZuS1ZLOXNwRUp2Y0M2eU1nL3gwR3FwWHpRM2w1aEZoK2NzcDh5YzBGam9m?=
 =?utf-8?B?Kyt1VldnN2tJTklNVC9BclhVZ2huenVOR01GT3VCeTQ1ZVlVa2tTallOSjly?=
 =?utf-8?B?V1BxM0VQYUdSQlVJN0ZTNjZHdlhDa0kycHBwNlYvOElXQ0RWbENFSTUvRmlS?=
 =?utf-8?B?ejYraUJDSkhaY3RJcTBySnh4S1hsM2JFazlMbnVoYUx4QUV2eldJQjRIZHZ6?=
 =?utf-8?Q?6rBqtTkEciNu0gv6QWra0Xg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0bc81c-8fc0-485a-c3a6-08d9dc7f8e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 01:44:25.0569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evam4cV4Ow/ROJPtq73gP/GU3+oxQT0SVpY30lM7pLBp7r07zMMSTGSeoughlUJgPOcKG05kLtrylEaF32j+Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>, "Russell, Kent" <Kent.Russell@amd.com>, "Liu, 
 Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZiBMdWJlbiBUdWlrb3YNClNlbnQ6IEZyaWRheSwgSmFudWFyeSAyMSwgMjAyMiA3OjUy
IEFNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBUdWlrb3YsIEx1YmVuIDxMdWJlbi5U
dWlrb3ZAYW1kLmNvbT47IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsgTGl1
LCBTaGFveXVuIDxTaGFveXVuLkxpdUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1k
Z3B1OiBGaXgga2VybmVsIGNvbXBpbGF0aW9uOyBzdHlsZQ0KDQpQcm9ibGVtOg0KZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYzogSW4gZnVuY3Rpb24g4oCYaXNf
ZnJ1X2VlcHJvbV9zdXBwb3J0ZWTigJk6DQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZnJ1X2VlcHJvbS5jOjQ3OjM6IGVycm9yOiBleHBlY3RlZCDigJgp4oCZIGJlZm9yZSDigJhy
ZXR1cm7igJkNCiAgIDQ3IHwgICByZXR1cm4gZmFsc2U7DQogICAgICB8ICAgXn5+fn5+DQpkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jOjQ2OjU6IG5vdGU6IHRv
IG1hdGNoIHRoaXMg4oCYKOKAmQ0KICAgNDYgfCAgaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KQ0K
ICAgICAgfCAgICAgXg0KDQpGaXgga2VybmVsIGNvbXBpbGF0aW9uOg0KCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikNCgkJcmV0dXJuIGZhbHNlOw0KbWlzc2luZyBjbG9zaW5nIHJpZ2h0IHBhcmVu
dGhlc2lzIGZvciB0aGUgImlmIi4NCg0KRml4IHN0eWxlOg0KCS8qIFRoZSBpMmMgYWNjZXNzIGlz
IGJsb2NrZWQgb24gVkYNCgkgKiBUT0RPOiBOZWVkIG90aGVyIHdheSB0byBnZXQgdGhlIGluZm8N
CiAgICAgICAgICovDQpIYXMgd2hpdGUgc3BhY2UgYWZ0ZXIgdGhlIGNsb3NpbmcgKi8uDQoNCkNj
OiBBbGV4IERldWNoZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpDYzogc2hhb3l1bmwg
PHNoYW95dW4ubGl1QGFtZC5jb20+DQpDYzogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1k
LmNvbT4NCkZpeGVzOiA4MjRjMjA1MTAzOWRmYyAoImRybS9hbWRncHU6IERpc2FibGUgRlJVIEVF
UFJPTSBhY2Nlc3MgZm9yIFNSSU9WIikNClNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtvdiA8bHVi
ZW4udHVpa292QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZnJ1X2VlcHJvbS5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZnJ1X2VlcHJvbS5jDQppbmRleCAwNTQ4ZTI3OWNjOWZjNC4uNjBlN2U2MzdlYWEzM2QgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5j
DQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQpA
QCAtNDIsOCArNDIsOCBAQCBzdGF0aWMgYm9vbCBpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiANCiAJLyogVGhlIGkyYyBhY2Nlc3MgaXMgYmxvY2tl
ZCBvbiBWRg0KIAkgKiBUT0RPOiBOZWVkIG90aGVyIHdheSB0byBnZXQgdGhlIGluZm8NCi0JICov
ICANCi0JaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KQ0KKwkgKi8NCisJaWYgKGFtZGdwdV9zcmlv
dl92ZihhZGV2KSkNCiAJCXJldHVybiBmYWxzZTsNCiANCiAJLyogVkJJT1MgaXMgb2YgdGhlIGZv
cm1hdCAjIyMtRFhYWFlZLSMjLiBGb3IgU0tVIGlkZW50aWZpY2F0aW9uLA0KDQpiYXNlLWNvbW1p
dDogMmU4ZTEzYjBhNjc5NGYzZGRhZTBkZGNkMTNlZWRiNjRkZTk0ZjBmZA0KLS0gDQoyLjM0LjAN
Cg==
