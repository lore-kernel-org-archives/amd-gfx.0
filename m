Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97930C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3700661090
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3700661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFC66EDEC;
	Fri, 24 Sep 2021 06:34:36 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38386EDEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 06:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3k7LiD5vd1akMPwqBFNuEwu5PYmYmqjr6x+BQLlzpw9sVZOOA+EGNC3xodM1JcntVhJ2PQYOySBLSjmOyXa17cJ2qG8a1BzVAtA9t47eQPTB5A90/YLHxNeEqWFEWdL2VVn8ilEstPfzq+dA/J4Yw9nRPKyz0FMCvdHaBl2COcM5vaFbyyDAEhhnAscN+7d4Wc5IRNeYqlbQSYW3TNbyUovXZClQDY/iu1DniIZ34zpMaFpNRc9M7TuGIWLO7sa+pFufwdwopYtJxD6JDA+MxqwtqoEOsVTlZ6SuZs9USptERtmzClCwJeR4+ZaJ16r6MsgOgWuxdYToN2eww+fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Hn1+YMRIfGynyWSeT1NjX4qyjB7HzgnkM5PIK8M0zCU=;
 b=OSqGNGVaSo9dG6phz6US076Fb8dC6iUTgZm6y7JWihAu2GSj4bNaLcQm4Rtb+eUIpT6aY+orktV3/XFSYXNglSFnCbonkQ1ma4GwYwoO0CBY+rz8XjlIGy6XrSWtO3pw5lX1nylzOCOTpe1f6WwuJ90aIT3C/XaweqAxOKAETwsBJKxcfIj3oq0hGFYIryK8bE2y2VrjtiuP8TVB3uDR+n9/W12cL9m9D5c4jjG8bkH0WeWDKPgjNqoNiuIhNDB5t5koxENCQVBu6g4RSVrWOy8gKtPnRFayby7nzcwhQPeIZh4PY2wlPfQy+HOmhCwMvMtrFmKCda3EAF5zozZ1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn1+YMRIfGynyWSeT1NjX4qyjB7HzgnkM5PIK8M0zCU=;
 b=hJxOrvT6PoBrV6uOArKy8KwkAXs+mRyl0ZXynwVmLdA+BHobRf9Z0BpMcHFW493p3lwNSwzw/ftmUbLCHlj8KF4LQZNQa9DmdcOKsshaqBBkgEsY3m30rgkHgrbGQnPIRWd0MIvoF/EViY8Ld2qFvBmc+YVVLg/8snFWi7oX8dw=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (10.141.186.137) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (10.174.107.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Fri, 24 Sep 2021 06:34:32 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 06:34:32 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcCAAAcjgIAAFGOQgAAVHgCAAPVIwIAAA0mAgAABUSCAAAILgIAAAYSg
Date: Fri, 24 Sep 2021 06:34:32 +0000
Message-ID: <DM6PR12MB4250D2851824AA4F27BE7FDBFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
 <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <dc3b075f-70f9-6724-9b00-3e00afa922fa@amd.com>
 <DM6PR12MB42507FAA5B24CB49218517ECFBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
 <066e138e-3eab-8c4c-04b9-6c7b5d6a4acc@amd.com>
 <DM6PR12MB425014A356EE6C8D865D5AC3FBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <6d9ae09f-4347-8a58-0cd4-1efb0955fe0f@amd.com>
 <DM6PR12MB4250C7EC2039EC6405C5EDAAFBA49@DM6PR12MB4250.namprd12.prod.outlook.com>
 <1ae03ed5-95ee-7e8a-b850-d0958aa974e6@amd.com>
In-Reply-To: <1ae03ed5-95ee-7e8a-b850-d0958aa974e6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T06:34:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2d7cc355-0225-4f15-9857-9fb67547c843;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72134de9-cef4-46e6-a37e-08d97f255e63
x-ms-traffictypediagnostic: DM5PR1201MB0203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0203D271E5EEEA187DCC14DAFBA49@DM5PR1201MB0203.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u+9wbMQ1DET9djWa9y8Qog4vzBw71gSDXMNe2JMe9qn3c/JwaXpI7GfKpK2RRz1i9pA23ME5c9lXSVtfugMoCcS89O58ICVd86FJ/kCSsog51Q+7J+jKRwjjpUKmmlnuL+7qapYvK/hXRgv0K1OmgRPObIsLzIEgUPaiQOXp6ggikclPTNdsvz5aRMChGdpm7V18PdlRP3R4x9h1N8vsQHzcBu1+L5EXYXo6Ts1aJvAiJBL7HumW9GQ8G6lTnXT9ytCXmO6fo57c/t85jnYk0NwtSW2wNWHd1PR7vQFhHqRZKIec42HuC2L/iwwN32YYXvMJNWlqzfOxKN719sUsPPQTab2Hdg2ZEb7+RX2l9X+DaW8Y3S/vfaIMWyL+q4wv5vwd0L1wevY/DRkG3p9Og1/u+0x4vt83uFyIM6hx3fHCwrY0eD1W7UMJ3SzMNcGXsrCm3PUvyy9Eet9i6nBxjHFBYr7GHmI6wdtok1n8CHWSNeXRjXw43PizjcoQE0hBHXp5dt/LNsxqR5dg9+SYkfSDq9UKw9WnlDkgxiNUJKZa9fs6Xb7AfV376xf247wQw5E/vAUCfDvBz3XsoLSL2U0MOXBwr5sa1NJc10LO9lMQqQWOOOC7LzQ/xXVHGofd1lKaq5VDUShAJ9gkfVPCyGJx9hpdkwI8GMcB/+iLF6o7wdgMH7la8Qf6+YDJSgP7Wk+aBvC1mf8tixuW53dWIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(52536014)(5660300002)(76116006)(110136005)(55016002)(4326008)(66476007)(8936002)(9686003)(2906002)(64756008)(83380400001)(71200400001)(66556008)(8676002)(66446008)(122000001)(316002)(66946007)(38100700002)(38070700005)(33656002)(86362001)(6506007)(186003)(26005)(7696005)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1VyYzBwMFN2T0J5bU5DbzJ0aFFBV1QwUE9HNk01bnBIUU1oeXh0TTM1SkF4?=
 =?utf-8?B?K3VXb1cxUTVLNElxcnh3amVvS0FtUlZ2SEkyZUM3cVFSdUFDZmRINGo0QmdY?=
 =?utf-8?B?Tm9TLzZpcXhQQXkxa2NwMU0zMnErTlJ3d0pudUlCU3l2V1g1eFJhZlN3TlNC?=
 =?utf-8?B?WG45NElXaERjSGZ3UkFvZ3FTYUVRUkNuVDJJWFpmem83T0RBbCsxZ1ZUTlFF?=
 =?utf-8?B?RTBuZGtvaU5CK2w4Z0F1Nmk2eGtvamkzdEVqNzFQQ0preGJsR2dRY1FTMzZQ?=
 =?utf-8?B?eU9EMkV3ZnFQYXhhNFdDWjRrT1BHZ2k1UFJZd29zdUViM0NhSVh5QWt6bEh5?=
 =?utf-8?B?dmVNRGxvQjJJQXRtQU8ybHhzekJFZzFQYzdGSVEwSVp1MEtFR1BUdzF3UjBU?=
 =?utf-8?B?Q1BHOGpKUlpocmdHeHRXYXdhRDZ0Qjd0c1YyejRMUU5qeEV0UkI0RzM0L3VG?=
 =?utf-8?B?VGY1cTRRTTErbDRqOHpYTHVaR2hvaWMyVDVzVjE3QVFnNGFOaUp0OFZsaGNz?=
 =?utf-8?B?SFhvcjdwVFlEZFkxZktUL3cyQmorWTAreFJRR2lNNHgvaEMySFFHcTVQYkhn?=
 =?utf-8?B?a21TWi9yT043OWR1MU5QN0t0MXN2djd0aXZwNTZKejNOU0NpdktKNGRMc0VY?=
 =?utf-8?B?eGlzOE16RVNrb2RadVJMS0VCODFiUHlKTU1VWGloMW4xdVFMWmNRUjcvMUZO?=
 =?utf-8?B?SEgxVVl2QmpBTVNSQmNGSFA3RGtja2dFaGk0T3ovZEtrbngwM0hQZUdUTWg5?=
 =?utf-8?B?Um5Yd0tLd0hueXkwamkwT1ovR2xkc2l0T0xydVJxZE5SWi93em9QUDZQWDBn?=
 =?utf-8?B?YnRhc3F5YXF5UnU4ZFY4WXdDRjVHNGh0UnF6V3JVUlhGNU1XYjR5eFNyUXI1?=
 =?utf-8?B?WVZvT2RuUmZRWUdjUFNxT2U0NlUxVVpzUmt2V3d4aUZLMnhQNTdqZE1LWlBH?=
 =?utf-8?B?MjByTjNKRHgyTnJYR0pMYmxkZTN4dHBDbkZwbFZ5T2d3OExRdFByc01nWFVn?=
 =?utf-8?B?VzN2b1ltWHZYdnhqbDVUSG9rWUNQS0krd1BVSEJsOTVHd1VXTHVWaGNGNzhY?=
 =?utf-8?B?SnZaNTF4eHVwVzk1bHU5ZW9DZXplMW43WXFGMmlMRTA1dS9TZzZxcUVReUVu?=
 =?utf-8?B?dG91Qlk0Nncyc01QSE9sY0tHL2U4a002c0R0Q282bHR3QVFvMUNzUURONFp2?=
 =?utf-8?B?VDlVYStHYkpwdkVaRDcyUnk5OHVBb3dacFFDSDdlRkdkc0JFWmJpNGs2dFNs?=
 =?utf-8?B?Y0gxbGFYcmVJQWNEdXFxMXpJVDdObWlUbmJwajBqKzc2dndHc0VMWHlPdVZt?=
 =?utf-8?B?NWhUTENSYnlGSklyUjJkV05BRmtCQStiMDZGbVdwSS96WHRjRHlBV2ExRHRO?=
 =?utf-8?B?anRRWWJiSG51djJ4REEzZU9ONStLU0JEQTJHd09IU0NaSTd5Ni8xZC9uU0Nz?=
 =?utf-8?B?b29LUC9nSllwQ0xOYzZFOEZvQjZwQVN2ZXRtUjJyMHg2TGFuMDRjUTRCUkxm?=
 =?utf-8?B?cDRKNExlQW5Mb2MzeVNWejlQQTJxdEg3bHlTeHQ3Nk43dmIxamlwQis3eWhB?=
 =?utf-8?B?VHY2S1JYdlV1cFZ5TXRQeTRCV3ZFMXpwWVBtS3B1eXovYkpPWEhBanFIRHFH?=
 =?utf-8?B?bWFGK0M1K3RPYmpISjc4aFF2Ykl1WjBtTXhxWHJKV0s5OWVqdEVYQTNiTzJL?=
 =?utf-8?B?bkg3R0JuUVBQUmRmdCswZGdySHMxNy84M2RONVlQTXdUbHcxbkhpMDJhaERE?=
 =?utf-8?Q?7czxhG8Q2OP9FpEnzCXisY/rRkGQXpqnzkjEJSH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72134de9-cef4-46e6-a37e-08d97f255e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 06:34:32.2347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5/cpmRWYJm4zGsfIuoJv6K3akJBQGNJPC+vqLVfBuO0IJ8vhL0UuHso5L5c1FBg8yuvRBQT/KjvMT4VknPXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
U2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjQsIDIwMjEgMTo1NCBQTQ0KPlRvOiBZdSwgTGFuZyA8
TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5DYzogS3Vl
aGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgSHVhbmcsIFJheQ0KPjxSYXku
SHVhbmdAYW1kLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBkcm0va2ZkOiBmaXggdHRtX2Jv
X3JlbGVhc2Ugd2FybmluZw0KPg0KPg0KPkFtIDI0LjA5LjIxIHVtIDA3OjUwIHNjaHJpZWIgWXUs
IExhbmc6DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4+IFtTTklQXQ0KPj4+Pj4+IEhp
IENocmlzdGlhbiwNCj4+Pj4+Pg0KPj4+Pj4+IFRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbiBh
bmQgYWR2aWNlLiBJIGdvdCB5b3VyIHBvaW50Lg0KPj4+Pj4+IEFjdHVhbGx5LCB0aGVzZSBCT3Mg
YXJlIGFsbG9jYXRlZCBhbmQgcGlubmVkIGR1cmluZyBhIGtmZCBwcm9jZXNzIGxpZmVjeWNsZS4N
Cj4+Pj4+PiBJIHdpbGwgdHJ5IHRvIGFkZCBhIGZsYWcgaW50byBzdHJ1Y3Qga2dkX21lbSB0byBp
bmRpY2F0ZSB3aGljaCBCTw0KPj4+Pj4+IGlzIHBpbmVkIGFuZCBzaG91bGQgYmUgdW5waW5uZWQu
IFdoaWNoIHdpbGwgbWFrZQ0KPj4+Pj4+IGFtZGdwdV9ib19waW4vYW1kZ3B1X2JvX3VucGluIGNh
bGxzIGJhbGFuY2VkLiBUaGFua3MhDQo+Pj4+PiBUaGF0IGlzbid0IHRvIG11Y2ggYmV0dGVyLiBU
aGUgcmVhbCBzb2x1dGlvbiB3b3VsZCBiZSB0byB1bnBpbiB0aGVtDQo+Pj4+PiB3aGVuIHRoZSBr
ZmQgcHJvY2VzcyBpcyBkZXN0cm95ZWQuDQo+Pj4+IFllcywgd2lsbCB1bnBpbiB0aGVtIHdoZW4g
dGhlIGtmZCBwcm9jZXNzIGlzIGRlc3Ryb3llZC4NCj4+Pj4gQnV0IHdlIHNob3VsZCBpbmRpY2F0
ZSB3aGljaCBCTyBpcyBwaW5uZWQgYW5kIHNob3VsZCBiZSB1bnBpbm5lZC4gUmlnaHQ/DQo+Pj4g
V2VsbCBub3Qgd2l0aCBhIGZsYWcgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4+Pg0KPj4+IFRo
ZSBrbm93bGVkZ2Ugd2hpY2ggQk8gaXMgcGlubmVkIGFuZCBuZWVkcyB0byBiZSB1bnBpbm5lZCBz
aG91bGQgY29tZQ0KPj4+IGZyb20gdGhlIGNvbnRyb2wgbG9naWMgYW5kIG5vdCBiZSBwYXBlcmVk
IG92ZXIgYnkgc29tZSBnZW5lcmFsIGhhbmRsaW5nLg0KPj4+IFRoYXQncyB0aGUgYmFja2dyb3Vu
ZCB3aHkgd2UgaGF2ZSByZW1vdmVkIHRoZSBnZW5lcmFsIGhhbmRsaW5nIGZvcg0KPj4+IHRoaXMg
ZnJvbSBUVE0gaW4gdGhlIGZpcnN0IHBsYWNlLg0KPj4+DQo+Pj4gSW4gb3RoZXIgd29yZHMgd2hl
biB5b3UgbmVlZCB0byBwaW4gYSBCTyBiZWNhdXNlIGl0IGlzIGttYXBwZWQgaXQNCj4+PiBzaG91
bGQgYmUgdW5waW5uZWQgd2hlbiBpdCBpcyBrdW5tYXBwZWQgYW5kIGlmIHlvdSBkb24ndCBrdW5t
YXAgYXQNCj4+PiBhbGwgdGhlbiB0aGVyZSBpcyBzb21ldGhpbmcgd3Jvbmcgd2l0aCB0aGUgY29k
ZSBzdHJ1Y3R1cmUgZnJvbSBhIGhpZ2hlciBsZXZlbA0KPnBvaW50IG9mIHZpZXcuDQo+PiBZZXMs
IHRoaXMgZnVuY3Rpb24gImFtZGdwdV9hbWRrZmRfZ3B1dm1fbWFwX2d0dF9ib190b19rZXJuZWwi
IGRpZCBhDQo+PiBrbWFwLCBidXQgd2l0aG91dCBhIGt1bm1hcCB3aGVuIHRoZSBrZmQgcHJvY2Vz
cyBpcyBkZXN0cm95ZWQuIFRoZSBmbGFnDQo+YWN0dWFsbHkgaW5kaWNhdGVzIGttYXAva3VubWFw
Lg0KPg0KPldlbGwgdGhhdCdzIHRoZSB3cm9uZyBhcHByb2FjaCB0aGVuLiBJIG1lYW4geW91IG5l
ZWQgdG8gaGF2ZSB0aGUgQk8gcmVmZXJlbmNlDQo+YW5kIHRoZSBtYXBwZWQgcG9pbnRlciBzb21l
d2hlcmUsIGRvbid0IHlvdT8NCj4NCj5Ib3cgZG8geW91IGNsZWFuIHRob3NlIHVwPw0KDQpUaGV5
IGFyZSByZXNwZWN0aXZlbHkgY2xlYW5lZCBieSAiIGtmZF9wcm9jZXNzX2RldmljZV9mcmVlX2Jv
cyAiIGFuZCAiIGtmZF9wcm9jZXNzX2Rlc3Ryb3lfcGRkcyIuDQpMZXQgbWUgcHV0IHRoZSBjb2Rl
IGhlcmUuIFRoYW5rcyENCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmQuaA0KaW5kZXggZWMwMjhjZjk2M2Y1Li5kNjViM2JmMTNmZDggMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgNCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaA0KQEAgLTgxLDYgKzgxLDcgQEAgc3RydWN0
IGtnZF9tZW0gew0KDQogICAgICAgIGJvb2wgYXFsX3F1ZXVlOw0KICAgICAgICBib29sIGlzX2lt
cG9ydGVkOw0KKyAgICAgICBib29sIGlzX21hcHBlZF90b19rZXJuZWw7DQogfTsNCg0KIC8qIEtG
RCBNZW1vcnkgRXZpY3Rpb24gKi8NCkBAIC0yNzgsNiArMjc5LDggQEAgaW50IGFtZGdwdV9hbWRr
ZmRfZ3B1dm1fc3luY19tZW1vcnkoDQogICAgICAgICAgICAgICAgc3RydWN0IGtnZF9kZXYgKmtn
ZCwgc3RydWN0IGtnZF9tZW0gKm1lbSwgYm9vbCBpbnRyKTsNCiBpbnQgYW1kZ3B1X2FtZGtmZF9n
cHV2bV9tYXBfZ3R0X2JvX3RvX2tlcm5lbChzdHJ1Y3Qga2dkX2RldiAqa2dkLA0KICAgICAgICAg
ICAgICAgIHN0cnVjdCBrZ2RfbWVtICptZW0sIHZvaWQgKiprcHRyLCB1aW50NjRfdCAqc2l6ZSk7
DQordm9pZCBhbWRncHVfYW1ka2ZkX2dwdXZtX3VubWFwX2d0dF9ib19mcm9tX2tlcm5lbChzdHJ1
Y3Qga2dkX2RldiAqa2dkLA0KKyAgICAgICAgICAgICAgIHN0cnVjdCBrZ2RfbWVtICptZW0pOw0K
IGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX3Jlc3RvcmVfcHJvY2Vzc19ib3Modm9pZCAqcHJvY2Vz
c19pbmZvLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgZG1hX2ZlbmNlICoqZWYpOw0KIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX2dldF92bV9mYXVs
dF9pbmZvKHN0cnVjdCBrZ2RfZGV2ICprZ2QsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQppbmRleCAyZDZiMmQ3N2I3MzguLjQ1Y2NiZTlm
NjNlZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jDQpAQCAtMTg1Nyw2ICsxODU3LDggQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1dm1f
bWFwX2d0dF9ib190b19rZXJuZWwoc3RydWN0IGtnZF9kZXYgKmtnZCwNCg0KICAgICAgICBhbWRn
cHVfYm9fdW5yZXNlcnZlKGJvKTsNCg0KKyAgICAgICBtZW0tPmlzX21hcHBlZF90b19rZXJuZWwg
PSB0cnVlOw0KKw0KICAgICAgICBtdXRleF91bmxvY2soJm1lbS0+cHJvY2Vzc19pbmZvLT5sb2Nr
KTsNCiAgICAgICAgcmV0dXJuIDA7DQoNCkBAIC0xODcwLDYgKzE4NzIsMjAgQEAgaW50IGFtZGdw
dV9hbWRrZmRfZ3B1dm1fbWFwX2d0dF9ib190b19rZXJuZWwoc3RydWN0IGtnZF9kZXYgKmtnZCwN
CiAgICAgICAgcmV0dXJuIHJldDsNCiB9DQoNCit2b2lkIGFtZGdwdV9hbWRrZmRfZ3B1dm1fdW5t
YXBfZ3R0X2JvX2Zyb21fa2VybmVsKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIHN0cnVjdCBrZ2RfbWVt
ICptZW0pDQorew0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IG1lbS0+Ym87DQorDQor
ICAgICAgIGlmICghbWVtLT5pc19tYXBwZWRfdG9fa2VybmVsKQ0KKyAgICAgICAgICAgICAgIHJl
dHVybjsNCisNCisgICAgICAgYW1kZ3B1X2JvX3Jlc2VydmUoYm8sIHRydWUpOw0KKyAgICAgICBh
bWRncHVfYm9fa3VubWFwKGJvKTsNCisgICAgICAgYW1kZ3B1X2JvX3VucGluKGJvKTsNCisgICAg
ICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7DQorICAgICAgIG1lbS0+aXNfbWFwcGVkX3RvX2tl
cm5lbCA9IGZhbHNlOw0KK30NCisNCiBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9nZXRfdm1fZmF1
bHRfaW5mbyhzdHJ1Y3Qga2dkX2RldiAqa2dkLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBrZmRfdm1fZmF1bHRfaW5mbyAqbWVtKQ0KIHsNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KaW5kZXggMjFlYzhhMThjYWQy
Li5mNTUwNmIxNTNhZWQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfcHJvY2Vzcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vz
cy5jDQpAQCAtOTQxLDYgKzk0MSw4IEBAIHN0YXRpYyB2b2lkIGtmZF9wcm9jZXNzX2RldmljZV9m
cmVlX2JvcyhzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQpDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBlZXJfcGRkLT5kZXYtPmtnZCwgbWVtLCBwZWVyX3BkZC0+ZHJtX3By
aXYpOw0KICAgICAgICAgICAgICAgIH0NCg0KKyAgICAgICAgICAgICAgIGFtZGdwdV9hbWRrZmRf
Z3B1dm1fdW5tYXBfZ3R0X2JvX2Zyb21fa2VybmVsKHBkZC0+ZGV2LT5rZ2QsIG1lbSk7DQorDQog
ICAgICAgICAgICAgICAgYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUocGRk
LT5kZXYtPmtnZCwgbWVtLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHBkZC0+ZHJtX3ByaXYsIE5VTEwpOw0KICAgICAgICAgICAgICAgIGtm
ZF9wcm9jZXNzX2RldmljZV9yZW1vdmVfb2JqX2hhbmRsZShwZGQsIGlkKTsNCg0KUmVnYXJkcywN
CkxhbmcNCg0KPlJlZ2FyZHMsDQo+Q2hyaXN0aWFuLg0K
