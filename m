Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C483DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 02:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8233A60E53
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 02:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8233A60E53
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA3A89DC7;
	Tue, 12 Oct 2021 02:22:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301B489DC7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 02:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH3LICIKYO4BGUuGIseuiMpBlhvAYeMyyOri4FnP95aA+76uMOp/6duUUUVJfU8Q8Gld0rzsVAK06y/rnLvDYF+Idp6FjKWVspAR0+vWxpfQr4c7m0vrXUbokUTNo42Do2BBYYZ1/5+UwP7PWFetl2IJQKSPhsvyrHPgHMyA5hIz4vVTetRG6vF2fd/QeNoX1g1p3+K9OROz9cpMeXRKcx5e7VNxjiYNpL5qxmfoXRze1VZeV1uBT8lCNftCdzF5AbARtkPTY6kY6OuSo6HCATOwMh/ZyOt2H/kHF4btf+sJf8n2M3uExiCaj+/1NemDMcjMnQWMpsM06XRBZYz45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivELkvRuV0vYGVl1Sl6uTVqbk2go4lYiCGAk0To99MM=;
 b=D8cOLO3YBlPT1y8ajj156bxPjIk1aRZYVm+2WmF85eDHLc5YE6QcqpA7Li3IL6ccDvCk59/nx9xV7OhmUEp9R7DFapnlbuqU/bPuGqQEUasPH+R9QLrRvEdvF+6/kpIGgdOX+7bEsZTlXjPXQ2nPLhZuxdqZfo+0VYl4/ZvLOw9lp0lzopm14qRzNTAqLuPxwMoAGMlHHiqwvCLO3T4Fl9oZV4gKiX1rdR9he5c0BVFId9wT737tolgPR1PFk+YUcHYvvgPMRUkpCFBC1moJrVr+w2UHSNyY+p5hq0pk7TEHl6+yQqwse26MsXC/gSDWV3uiGYfo3bW5ziEfUktqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivELkvRuV0vYGVl1Sl6uTVqbk2go4lYiCGAk0To99MM=;
 b=LtbdxVSrT8On6+QtXM+j2cTcvjwlw1A6gZ+hUnkbvfZp0Rh+tp/kxhvCznnmpa7++2Wx3tcBpPGQrmoobbciNDHBcBgZrkAwBoCrnmSy50eUryheLIHipfbNBxwbiNVaZGNwxxJa8+18FSkCakDi1LeDceNA+3CZRseUN4x1mH0=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Tue, 12 Oct 2021 02:22:24 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 02:22:24 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish
Thread-Topic: [PATCH] drm/amdgpu: query default sclk from smu for
 cyan_skillfish
Thread-Index: AQHXvnp/LKZGotaDt0WIprQNFBx+GqvNffuAgABdRoCAAMR8wA==
Date: Tue, 12 Oct 2021 02:22:24 +0000
Message-ID: <DM6PR12MB425015096DC95E4378B6942FFBB69@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211011083147.577024-1-lang.yu@amd.com>
 <53bf0be2-be7a-5a38-4c04-dbd82a928db0@amd.com>
 <DM5PR12MB2469C25979CA84EC98C0C793F1B59@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469C25979CA84EC98C0C793F1B59@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-12T02:22:21Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4c03b156-95d5-45ce-987c-52cc9b2bbd29;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daec7fd2-a082-407e-04a9-08d98d2720f2
x-ms-traffictypediagnostic: DM6PR12MB3018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB301849EE5195862919AC7697FBB69@DM6PR12MB3018.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OlTG2YDbayi67UGeMzff+MMgr80U85lIrmZHcqLgKVzvRaJcHmMJNtefVIehxMxJfTCyLI0qOMDXtNZVfRnW2kVHOMUIx9q8JH4UnXdY6uR1dONMG7VkkqFt0ifpHze5hHp/kg3OMscTG/SrbKm1S34OI3PIBvqGTnkQkUoY1aXF2lLqquAEKanYwkCYF6jnWIwAQJHpGrs2blY6d6P3moGrQTRi/Mzd5ZZBoJ0Kuyc16n2d63B4t/YhWTyYfwGb2ULSjNM2JgWFRBJ5Bl8jEr6eWBBL03eXZZuKZzS7vun3Mzu6hOHJ1Mx5a/y4jDCM6sdncef+e2k7pJRhjyxMbvyU7svhUIg82Wl/fYl/AohJFKREh3EngwNhOhwqAb+Efli3YwTcrJOqlLJ/mlZGEs2exQFiX/XuD6p/IjNzoQKQu17yD8qKKpHPk0t57IU71a9M4Pv2SbqEogqvYJJ5v3/3cqnpzRR4TRuOHpTXS1BjM5ROZ/88yXEgr8RZSVOYywTB2aDC8NkcVQjLtIhCllVA76A0MpifD8JNipQoVuUF8MQ9LDZWCjQzx8L42GlQdZhztgsf9qoWt+3Q6XCS9CLN1CR9bFFnljlutT34jf/5R2PIE2icfAVJ3oegDS3U3CBxbPvLQpD639rSVPNzYQVFVQYH/WwGeWcM3gm+bCMvvveCHezCVXeFGR8XdqDm5z3xRIJ6vutI73HB2OTsEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(4326008)(110136005)(86362001)(8676002)(8936002)(316002)(9686003)(83380400001)(55016002)(54906003)(122000001)(2906002)(5660300002)(71200400001)(66446008)(64756008)(66946007)(76116006)(66476007)(186003)(66556008)(52536014)(508600001)(38100700002)(38070700005)(26005)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkhaSGJXNTJzS1J0YXRnYWNLbU9aU1JvWjQrcTdxOE9HUGxRTGVIZVdCNVRI?=
 =?utf-8?B?Q05zRUoxNHQrMmFtVkFrcDAzUnRoNnhHK2l2SWdDWEIxVGNNclVnTEJkRnV2?=
 =?utf-8?B?K0xSbUU2ZDhIVHlJZytuS3lYdVpHMTV0b3Y3VjBHTzlFeEpJRUdNY2JXRXBh?=
 =?utf-8?B?L0tHK2xaT1BpQVErZ0JBbDE5NmlIZTJXTzd3SnNCMzFuV2R6TkE1bGFIUU90?=
 =?utf-8?B?K3I1RlRtWC84akcyQnBQZm42QVFpa0JUUnFYZEkvd0pMNUMyaUxBU2VnRlEr?=
 =?utf-8?B?RGR4RjZKVHVMQUk4Q0N0ZWVHeVJkTjlMQWwzZitiY25ZdVdJZjB4L0E3ckNI?=
 =?utf-8?B?emdxMEtoZ2N4WUM1U1o0WUlZeVBQNEZLSHJUQWJ6QTVNa3pGV1Mrb0pWNU9u?=
 =?utf-8?B?STdKZEsyN0oyWDJRVkxXUEdXb29iaTFoNG9kZWVTeWVuNjgrSUVNZ01sTGdT?=
 =?utf-8?B?N0s0bGRxNVZrVUZwNGRGS04ySGh4MUhUSGhGSG5BL1djYUpTTUd6SHh1TFJG?=
 =?utf-8?B?RWVjNE9YWHREVHdwbDBjQ2FJeUhWWUxrcUtUbkQvMHpFUnpVQXc0V3N1eXlo?=
 =?utf-8?B?WHFuSkhodnVBdkdGMHNNMXpCaGZGak9XR0FESmc4K29TbXJrVnF0Wis0TFRv?=
 =?utf-8?B?TXdnaE9WYi9XREF3Vy9NOTJUN05lcDhNUW4xb25VdzVyS3RDTGY0R0VST2tU?=
 =?utf-8?B?NEZJRFFiV2lRQjlTeVFCdDFENWx2bWhuQVI3ZCtwRzE1RStiK1Z1MUF3SFk4?=
 =?utf-8?B?czNCZ0cxNXJrUzVZeU5KUUJELzVXWSt3N0xSSTZ1UHdZUkJSaHdINUpka09F?=
 =?utf-8?B?RUlUTE9GV0FMSDI1ZU1XU1ZITnRSeE4vekVPaWNtTm9pVERFTmpIaFdZMGdG?=
 =?utf-8?B?T0Z2MGYvTExqWkxPNzFIS08vYkpuQUl2bTJCd2ZLSldEUkUwa1ZxNzlZQVBZ?=
 =?utf-8?B?dHplNmZYZE51R1EyeXZ5WE1JbnBYbUZFcStyMUFzTnY1Ylo2SzBLQTh6OVVN?=
 =?utf-8?B?TzUwWDA0Z3krU01iZnBROVZPWGVTWUd4TkFnY3lQWjBBbkFkay9oaXFGcENO?=
 =?utf-8?B?Mit0czBaSjBMNGRnMGs0M2JQSW8wSnI2M2krS1NvdmVyVGR6a3Z3ZVdhQ1pz?=
 =?utf-8?B?MjRoa2pNdXkrdjV5MDBEZnFURTZWb05sdncvdi9Hb3JCbU5RN2R4dWZ6Nmt4?=
 =?utf-8?B?T0Q4ZEQ2VzJXNGppSEFSZjZIVmZkbTVWTjFOeENNTWZhYzZ4bU9tY2pyNEt1?=
 =?utf-8?B?dlIwMHZRN3VmUis0QU1iVFpqbGF2dzNTeUxMdmVkT0xTWUxIZ1ZQSVBDQ0xZ?=
 =?utf-8?B?NUNEVGsxRmZ1eVlhRUpZcmJ5OHg4bk1UNFBGK3RJWkk3dDFBOTY5Wm1ZWGZq?=
 =?utf-8?B?Uzd2dGNBbEI3U3N2ZWwwT204QTcyYy8ranBTdmMrOUpQYmVnMTdrOEdCSmFY?=
 =?utf-8?B?cWdhOGoyRXYwNlA1eGJEYm1oY1FmVUNZSlZQZHlRdDhiSlVOQ21kVDgyR0Vv?=
 =?utf-8?B?eWE0dHB0RE9PZjBGUWRJUFRxMjRObVp0UGt5LzBQVjRIaHRuZFN5MndIbkZO?=
 =?utf-8?B?bC9uNFpHNjJEMVozZ1ZvOWtnWWpHMzh3c1JuNWlrVGlYVkRQR3Joc2dnV1pq?=
 =?utf-8?B?bkZGRDBNd1BlL0sveGlLTklnbFZtQ1JIODRQNDZuSTRlVUpMYys3aHZyUGJJ?=
 =?utf-8?B?OFFzUVhCZGV5RFpXQjlzdk95c3dPWUJWdXhXczZKY0NGMU1DRTNNNzJCTXR1?=
 =?utf-8?Q?YlRrJnkdGGxUzfT/Cct2tZn3FGayKheHoGUanCq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daec7fd2-a082-407e-04a9-08d98d2720f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 02:22:24.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IBkRRQ82l+7D1Qih+th7e0t2ytclkGKLewRKfZ2xNodXjLPfezkl9noURFJVmMfr3Lbuekd1en17pajE9PKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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

W1B1YmxpY10NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW4s
IEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMTEs
IDIwMjEgMTA6MjcgUE0NCj5UbzogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT47IFl1
LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtDQo+Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zw0KPkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBI
dWFuZywgUmF5DQo+PFJheS5IdWFuZ0BhbWQuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRy
bS9hbWRncHU6IHF1ZXJ5IGRlZmF1bHQgc2NsayBmcm9tIHNtdSBmb3IgY3lhbl9za2lsbGZpc2gN
Cj4NCj5bUHVibGljXQ0KPg0KPkdsb2JhbCB2YXJpYWJsZSB0byBjYXJyeSB0aGUgc2NsayB2YWx1
ZSBsb29rcyBhIGJpdCBvdmVyLWtpbGxlZC4gSXMgaXQgcG9zc2libGUgdGhhdA0KPm1vdmUgYWxs
IGludG8gY3lhbl9za2lsbGZpc2hfb2RfZWRpdF9kcG1fdGFibGUsIGxpa2UgcXVlcnlpbmcgc2Ns
ayBmaXJzdCBhbmQNCj5zZXR0aW5nIGl0IHRvIGN5YW5fc2tpbGxmaXNoX3VzZXJfc2V0dGluZ3Mu
c2Nsaz8NCg0KMSwgV2UgbmVlZCB0byBxdWVyeSBkZWZhdWx0IHNjbGsgaW4gc211IGluaXQgcGhh
c2UgYW5kIHVzZSBpdCBpbiBvZF9lZGl0X2RwbV90YWJsZSwNCnNvIGdsb2JhbCB2YXJpYWJsZSBp
cyBuZWVkZWQuDQoyLCAgVG8gbWFpbnRhaW4gInNldCB0aGVuIGNvbW1pdCIgY29tbWFuZCBydWxl
IG9mIHBwX29kX2Nsa192b2x0YWdlLA0KZ2xvYmFsIHZhcmlhYmxlIGlzIGFsc28gbmVlZGVkLiAN
Cg0KUmVnYXJkcywNCkxhbmcNCg0KV2UgbmVlZCBzb21lIGdsb2JhbCB2YXJpYWJsZXMgdG8gc3Rv
cmUgdXNlciBzZXR0aW5ncyBhbmQgDQo+DQo+UmVnYXJkcywNCj5HdWNodW4NCj4NCj4tLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0
cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBMYXphciwNCj5MaWpvDQo+U2VudDogTW9u
ZGF5LCBPY3RvYmVyIDExLCAyMDIxIDQ6NTQgUE0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5n
QGFtZC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogcXVlcnkgZGVmYXVs
dCBzY2xrIGZyb20gc211IGZvciBjeWFuX3NraWxsZmlzaA0KPg0KPg0KPg0KPk9uIDEwLzExLzIw
MjEgMjowMSBQTSwgTGFuZyBZdSB3cm90ZToNCj4+IFF1ZXJ5IGRlZmF1bHQgc2NsayBpbnN0ZWFk
IG9mIGhhcmQgY29kZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFt
ZC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5f
c2tpbGxmaXNoX3BwdC5jICB8IDEyICsrKysrKysrKy0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5fc2tpbGxmaXNoX3BwdC5jDQo+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvY3lhbl9za2lsbGZpc2hfcHB0LmMN
Cj4+IGluZGV4IDNkNGM2NWJjMjlkYy4uZDk4ZmQwNmEyNTc0IDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9jeWFuX3NraWxsZmlzaF9wcHQuYw0KPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9jeWFuX3NraWxsZmlzaF9w
cHQuYw0KPj4gQEAgLTQ3LDcgKzQ3LDYgQEANCj4+ICAgLyogdW5pdDogTUh6ICovDQo+PiAgICNk
ZWZpbmUgQ1lBTl9TS0lMTEZJU0hfU0NMS19NSU4JCQkxMDAwDQo+PiAgICNkZWZpbmUgQ1lBTl9T
S0lMTEZJU0hfU0NMS19NQVgJCQkyMDAwDQo+PiAtI2RlZmluZSBDWUFOX1NLSUxMRklTSF9TQ0xL
X0RFRkFVTFQJCQkxODAwDQo+Pg0KPj4gICAvKiB1bml0OiBtViAqLw0KPj4gICAjZGVmaW5lIENZ
QU5fU0tJTExGSVNIX1ZERENfTUlOCQkJNzAwDQo+PiBAQCAtNTksNiArNTgsOCBAQCBzdGF0aWMg
c3RydWN0IGdmeF91c2VyX3NldHRpbmdzIHsNCj4+ICAgCXVpbnQzMl90IHZkZGM7DQo+PiAgIH0g
Y3lhbl9za2lsbGZpc2hfdXNlcl9zZXR0aW5nczsNCj4+DQo+PiArc3RhdGljIHVpbnQzMl90IGN5
YW5fc2tpbGxmaXNoX3NjbGtfZGVmYXVsdDsNCj4+ICsNCj4+ICAgI2RlZmluZSBGRUFUVVJFX01B
U0soZmVhdHVyZSkgKDFVTEwgPDwgZmVhdHVyZSkNCj4+ICAgI2RlZmluZSBTTUNfRFBNX0ZFQVRV
UkUgKCBcDQo+PiAgIAlGRUFUVVJFX01BU0soRkVBVFVSRV9GQ0xLX0RQTV9CSVQpCXwJXA0KPj4g
QEAgLTM2NSwxMyArMzY2LDE4IEBAIHN0YXRpYyBib29sIGN5YW5fc2tpbGxmaXNoX2lzX2RwbV9y
dW5uaW5nKHN0cnVjdA0KPnNtdV9jb250ZXh0ICpzbXUpDQo+PiAgIAkJcmV0dXJuIGZhbHNlOw0K
Pj4NCj4+ICAgCXJldCA9IHNtdV9jbW5fZ2V0X2VuYWJsZWRfMzJfYml0c19tYXNrKHNtdSwgZmVh
dHVyZV9tYXNrLCAyKTsNCj4+IC0NCj4+ICAgCWlmIChyZXQpDQo+PiAgIAkJcmV0dXJuIGZhbHNl
Ow0KPj4NCj4+ICAgCWZlYXR1cmVfZW5hYmxlZCA9ICh1aW50NjRfdClmZWF0dXJlX21hc2tbMF0g
fA0KPj4gICAJCQkJKCh1aW50NjRfdClmZWF0dXJlX21hc2tbMV0gPDwgMzIpOw0KPj4NCj4+ICsJ
LyoNCj4+ICsJICogY3lhbl9za2lsbGZpc2ggc3BlY2lmaWMsIHF1ZXJ5IGRlZmF1bHQgc2NsayBp
bnNldGVkIG9mIGhhcmQgY29kZS4NCj4+ICsJICovDQo+PiArCWN5YW5fc2tpbGxmaXNoX2dldF9z
bXVfbWV0cmljc19kYXRhKHNtdSwgTUVUUklDU19DVVJSX0dGWENMSywNCj4+ICsJCSZjeWFuX3Nr
aWxsZmlzaF9zY2xrX2RlZmF1bHQpOw0KPj4gKw0KPg0KPk1heWJlIGFkZCBpZiAoIWN5YW5fc2tp
bGxmaXNoX3NjbGtfZGVmYXVsdCkgc28gdGhhdCBpdCdzIHJlYWQgb25seSBvbmNlIGR1cmluZyBk
cml2ZXINCj5sb2FkIGFuZCBub3Qgb24gZXZlcnkgc3VzcGVuZC9yZXN1bWUuDQo+DQo+UmV2aWV3
ZWQtYnk6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCj4NCj5UaGFua3MsDQo+TGlq
bw0KPg0KPj4gICAJcmV0dXJuICEhKGZlYXR1cmVfZW5hYmxlZCAmIFNNQ19EUE1fRkVBVFVSRSk7
DQo+PiAgIH0NCj4+DQo+PiBAQCAtNDY4LDcgKzQ3NCw3IEBAIHN0YXRpYyBpbnQgY3lhbl9za2ls
bGZpc2hfb2RfZWRpdF9kcG1fdGFibGUoc3RydWN0DQo+c211X2NvbnRleHQgKnNtdSwNCj4+ICAg
CQkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgIAkJfQ0KPj4NCj4+IC0JCWN5YW5fc2tpbGxmaXNoX3Vz
ZXJfc2V0dGluZ3Muc2NsayA9DQo+Q1lBTl9TS0lMTEZJU0hfU0NMS19ERUZBVUxUOw0KPj4gKwkJ
Y3lhbl9za2lsbGZpc2hfdXNlcl9zZXR0aW5ncy5zY2xrID0gY3lhbl9za2lsbGZpc2hfc2Nsa19k
ZWZhdWx0Ow0KPj4gICAJCWN5YW5fc2tpbGxmaXNoX3VzZXJfc2V0dGluZ3MudmRkYyA9DQo+Q1lB
Tl9TS0lMTEZJU0hfVkREQ19NQUdJQzsNCj4+DQo+PiAgIAkJYnJlYWs7DQo+Pg==
