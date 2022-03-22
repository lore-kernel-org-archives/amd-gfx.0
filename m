Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CE7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 03:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A7610E039;
	Tue, 22 Mar 2022 03:51:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F25510E039
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 03:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1BGieOAxMa/0kjvYjoAzfCCEeYD9M2RjXqa0M4ZOQKtVkyfLt+van8Jwv+3jeUK0KIMuingj4b8M1hsf+YFJP2TrfT5dHGX0FMLhndt8XHV5vkkAtfWoOexnnmoiVGthFZyrjBVes6DYV0VdF7rIbsEJq4l7cHHv8PyvYn/puOZ1hf6czxqluh4g7WNpMUGpzl/X7cAlsburgF2Gg91GXByo5buoNx/uoCJxgq7xygjqg7zGAApMr9JIEbVdMrytMXd/2ioVh7F+B7wtkbRBQEcmsWqq1q0JsbHB56TMuG2FQRYLm85fEOlwvuGhxpRvrGB7QF1IY7g8CZF3nq+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NjXzZJLivn3ABCTTwWGYz7Pa9w+8bplvynkFnQXiDc=;
 b=ctUMBQS50Bwpr/Jm1tz2hvCRkugTolVZFhj5NedkTusGLtHTkvsC/RAoY7VQ2f2yArM1xGa50rydVpbHF7yfGa7kOuSyARzxhA7ga/5gtOBJ7rIb4CKcW6GuDcSxcsQlkcNGH5xRHE9B7YVhXFpo+iNyA3dA0lmzjLNhRUVgeIiadwKssBfHTtrMsLYOinnYK4Q22bz6HpAlvdz0S32CY8cUY3Y9amSPCa6GULb707yYXdL9YahYmtYBiA3PJ4fXYOi8dl8MFnmEaee8aQ7WF956Y+El5Rxyy6yDrwPWe0VjAmOlmA66jOR562A1LwtnG/xUukN46vM72n4bpeU0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NjXzZJLivn3ABCTTwWGYz7Pa9w+8bplvynkFnQXiDc=;
 b=IAQ/H+93+ErVtDmpxULCRyAetw07zxU6u25LwhJzUtGeFJRNNZaDVtPo8zCzlk0RUVehEMGzimkjrdv1uUlLztJrRDYl/AwTrFnWKmySm0UI1RWUjMGRDcEkCgKgptQqy6fPWjwWaV4g0+cJ52DX24iW0fR4O/VhxwsC91iw7bc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MWHPR12MB1840.namprd12.prod.outlook.com (2603:10b6:300:114::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 03:51:22 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5081.019; Tue, 22 Mar 2022
 03:51:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v3)
Thread-Topic: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v3)
Thread-Index: AQHYPZ0KgXOCdJyUCkSkIl6LOKer6KzKwnuAgAAAzlA=
Date: Tue, 22 Mar 2022 03:51:22 +0000
Message-ID: <DM5PR12MB17703C7CBAD02B3DE16737D6B0179@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220322032916.3074-1-tao.zhou1@amd.com>
 <3222c670-13fc-f47c-e463-08c7a6e61ed4@molgen.mpg.de>
In-Reply-To: <3222c670-13fc-f47c-e463-08c7a6e61ed4@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-22T03:45:25Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=29d51197-14a3-4a9a-bf3f-9e3321803ee4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-22T03:51:20Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8569f41c-e0a0-4af6-895e-095b313065b0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3926ffa6-98c7-422c-a115-08da0bb73ae4
x-ms-traffictypediagnostic: MWHPR12MB1840:EE_
x-microsoft-antispam-prvs: <MWHPR12MB18405025D093441ED5C45A1BB0179@MWHPR12MB1840.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V99Mxo9QMW55lh1Slil1HK7mzlM2TlBHV07W/Lzmh4RimHTDELbNVX+fCGFQOlPZBKAkuSqonoPOPGdvO80jLipTFtsu1xRfLqygQM8Ixr3ONS5Yj+TJcu6CDocSVn0YofMBh1/blq8QGXxLSUL8Ygat5T2IwOj+m8csFft0Rya2ZghBKQS3CWMSx9L3QZ3syzAt6QZW6lPoFz7BvaSLLc06/4uWzNMq7QYtulMcV5Dv8WzDp96nkdA3M34rTpETbBKh2lsW3t2EfcG3cwrEGE+rXRVECn05MVk4iHJ9ItluiVtXiRHaZIra1JvreFPmGzOJkJMRz4S7fxWD2ZgLWuJRlAFcg+J8/o4JbWohfXufBbfPa9ietAFklzcknad+CNo3WNn+rhIVygn8pluZ8zwcuxKJ42/lARPcb2l8mQkd7PBKMTKtEZkd6qFdGQk4iT9LyZQRt1EncMEcZ1MB4zVBD64Dtph+qE2+I8RruBqc9TKW8NwRVrTyBq+11CTT8KL4IbLDYLpuJ610SZrQR0mW+n7OMXerlg1PxJTzUBEF6PsHyH/NOiITYKzf6NkMyDj3M0plWWkXMs3fcYobPfnphe1kmlhQjVZrPApZo0ptl/dbqXpDro2qAyflsOq/5cAJrZXH7wJ0elAPL/eczYqpYTDDZrhcLk1NEadxOEtoHr7m1c6p9dVqQ0SO29Nt7cKdMZZ18F2wqYd+1Gvpxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(52536014)(8936002)(38070700005)(71200400001)(86362001)(508600001)(26005)(186003)(64756008)(66446008)(66556008)(2906002)(9686003)(53546011)(7696005)(6506007)(4326008)(6916009)(54906003)(122000001)(55016003)(316002)(76116006)(5660300002)(33656002)(66946007)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dExrWFNJbDZKVitFVUVSbW9CZ2hPRHYwaTNMUnp3cm1CdVBOMlJsYkh1SlBk?=
 =?utf-8?B?aGdpeEEzQTFBcStWZ1VIanF6T0dZMzh6TXh1VGxmMytPc1pXQUR6dzIrZSsx?=
 =?utf-8?B?eW51Z2VKRUZLNnhRdWhOWmZydFpOWm1oL21KM2Zpa2RKQkdKYUQyeTVrNk5Y?=
 =?utf-8?B?eFpSN0hZTlN4bFo3aEpGbFlZNFg2dlduZXl0L2hneFZVSnNqVzIwNlZMUjZn?=
 =?utf-8?B?SzBzdnhLaFliZmJMM01oZ2x2UGhibmFNbUxIS3g3YVVVQjcyZ2hGQ0tSaS9l?=
 =?utf-8?B?d1c5dUNEOUxndDlQRThJYjdZL0tsUkNsdC9zbEsvM1RBODJGdkRzK0E0ZjJx?=
 =?utf-8?B?R092blVKaW5yMHN2ODlXL3FFZUV4TTZUb2xxYWh0TkVSNWxLM0JRcVRaQ1h5?=
 =?utf-8?B?WEJCMW1mN0NBMkFGb3pWc0ZuR21OUjArYkN2WDMzd0tqU21sVzdsdmJyT240?=
 =?utf-8?B?YkxIU1lWS3pYQldmQXJtVGN4ejlzVGlxYXU2cWJyWXVsMFkrdlhjTTFGbmRv?=
 =?utf-8?B?RnRFVmdrTTVycnhIV0V5cDZpeVcrL3pyOXlzei92ZVVjRStxUURuT3lUNm56?=
 =?utf-8?B?Y3NFK3NJVzlUaWtodUFhVjdsWXFyTkEyVDdCK040WVZTd3JOcGNtVzFuOFJG?=
 =?utf-8?B?OExZalptdU9Ha1F4Rk5hdDQxVzNRTFJtblJqTEo0RjBOeTlORDZnNlo5VXRv?=
 =?utf-8?B?RmY2SXBmZnNJSHNDMVhZSzZ0U3pkM0NHY3U1clhiMkpXb2pMMXFQbWhvMmtY?=
 =?utf-8?B?dU83Q3NabUlSNkNOWTRSekpCQ2FNeG9uZ3RlVnlpVFJWenMza2JUbHdNNHF3?=
 =?utf-8?B?UE8vWW1ONGswUXAxdlY2clZqTStyK2JxM3BtZ1NKaXhYNHpUYWJVNUx3M1VU?=
 =?utf-8?B?MjNMOHpvSk9WNU9pbXNTcG1IbnFCaWFNMUVZY1VNU0tVMHdTY3pHOEhSTzB4?=
 =?utf-8?B?UlVEbTBjMjZJWUdCRjVWVHJGYkxabG5aMURMWGVNUkVvSTkwZUFhTTRsZlF0?=
 =?utf-8?B?bmpveFdtRTRDSVhJSEwyckt3WVBnVjAxT3ZUbjMwVEMzdThhL29ZaERiSnlM?=
 =?utf-8?B?TU1OaDVFeGlNSDJXVFAxcWhpYVlEb0I1Y0p3MDZkUjhmeTJ1eUxaalAwWWJ3?=
 =?utf-8?B?alpEKytSVWRXeHluR0pLdkdpZGE4a3JMcmNhOHNnLzVYcDRXeXZMTE1MZ2J4?=
 =?utf-8?B?Yy9JeHNtQ0k0ZU1oNm1TdjhxZllVaXpvOUM3R0JVL0tpSXJZK2xKdCszb05a?=
 =?utf-8?B?YVV5QlF4TFlyQmZhckdGdXdFUFFOSnQvRkVFUU9JRTdva3NabzdpNEVVWTA5?=
 =?utf-8?B?ZCtLYjNzOVF4dCtncTNsNWU1SnJveTJqNWFJR1R0Sm1ScU9hdjVnQ2FnU25s?=
 =?utf-8?B?NkNmeGtBbUNGTk13dC9RMi90SkFlTWpmaysyWFNrdS9zaFVVek1OYU84SW9B?=
 =?utf-8?B?Q3FPRzRvL2RPNEo5ejBQRFZ0L1p1YnJRUE1OK2dGeXl4MDZiTGpkUjh0a0hR?=
 =?utf-8?B?Z0RNVGVIbWlpemVaT2pVdmlZdVdvdDlPNG1TUS84Kys5VXEvbjF0R3E2Yi91?=
 =?utf-8?B?amlYZGJaMFZHR1dTdHpBZEFLSjhxaEtDY2tZUVBkTEFoRHVwekE2WnI1bnRI?=
 =?utf-8?B?VXFhYzFUaGk3TEpjZVpyVUNFSmZkSFlhWE81eVJoLytoZnI0R2pSU3FkYk5t?=
 =?utf-8?B?em9Eb2FiU05xRERmRU5OWkVsWmpmejNTbW1ROGtLYzJ6YXpSUzU2THlxNTVT?=
 =?utf-8?B?NjcyQmtWbWZEbW5SWGJMQXZLQzBSdFNhTnhCU01PaW1Jc3BZcGtXM3JHWHJM?=
 =?utf-8?B?a2VnTHdtSW1nNENycVNuMEZBY3J6cmdkYlgwRFVERG8vTHNoNWF1TEhNQ0xF?=
 =?utf-8?B?OHY5R1k1MElpQnVjVUl6dTJWQ1FEK0dVRWltd1ZTR2x0WTluUTNCcU5aSm5a?=
 =?utf-8?Q?Gt/CmnRHtrZs9RuSPKBfBB570NxOK8Vw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3926ffa6-98c7-422c-a115-08da0bb73ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 03:51:22.0704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVVwX1NhsvuvncCmimeZA30R+tZJPThOLu/ae0SrlZ12k2drdn2GCdqBtE991RO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1840
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDog
VHVlc2RheSwgTWFyY2ggMjIsIDIwMjIgMTE6NDIgQU0NCj4gVG86IFpob3UxLCBUYW8gPFRhby5a
aG91MUBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5n
LCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBZYW5nLA0KPiBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1k
LmNvbT47IENoYWksIFRob21hcyA8WWlQZW5nLkNoYWlAYW1kLmNvbT47DQo+IExhemFyLCBMaWpv
IDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6
IHByaW50IHVubWFwIHF1ZXVlIHN0YXR1cyBmb3IgUkFTIHBvaXNvbg0KPiBjb25zdW1wdGlvbiAo
djMpDQo+IA0KPiBEZWFyIFRhbywNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHJlcm9sbGluZyB0
aGUgcGFjdGguDQo+IA0KPiBBbSAyMi4wMy4yMiB1bSAwNDoyOSBzY2hyaWViIFRhbyBaaG91Og0K
PiA+IFByaW50IHRoZSBzdGF0dXMgb3V0IHdoZW4gaXQgcGFzc2VzLCBhbmQgYWxzbyB0ZWxsIHVz
ZXIgZ3B1IHJlc2V0IGlzDQo+ID4gdHJpZ2dlcmVkIHdoZW4gd2UgZmFsbGJhY2sgdG8gbGVnYWN5
IHdheS4NCj4gDQo+IFRoZSB2ZXJiICpmYWxsIGJhY2sqIGlzIHdyaXR0ZW4gd2l0aCBhIHNwYWNl
Lg0KDQpbVGFvXSB3aWxsIHVwZGF0ZSBpdCBiZWZvcmUgcHVzaA0KDQo+IA0KPiA+IHYyOiBtYWtl
IHRoZSBtZXNzYWdlIG1vcmUgZXhwbGljaXRseS4NCj4gDQo+IGV4cGxpY2l0DQoNCltUYW9dIHdp
bGwgdXBkYXRlIGl0IGJlZm9yZSBwdXNoLg0KDQo+IA0KPiA+IHYzOiBjaGFuZ2Ugc3VjY2VlZHMg
dG8gc3VjY2VlZGVkLg0KPiA+ICAgICAgcmVwbGFjZSBwcl93YXJuIHdpdGggZGV2X2luZm8uDQo+
IA0KPiBQbGVhc2UgZ2l2ZSB0aGUgcmVhc29uLCB3aHkgdG8gZGVjcmVhc2UgdGhlIGRlYnVnIGxl
dmVsLiAoSSB3b3VsZCBhbHNvIGRvIGl0IGluIGENCj4gc2VwYXJhdGUgY29tbWl0LikNCg0KW1Rh
b10gcGxlYXNlIGNoZWNrIG15IHJlcGx5IHRvIExpam8uIEl0J3MgaW5mb3JtYXRpb25hbCBtZXNz
YWdlLCBidXQgcmFzIHBvaXNvbiBjb25zdW1wdGlvbiBpcyBzcGVjaWFsIGV2ZW50LCBib3RoIGRl
YnVnIGxldmVscyBhcmUgT0sgZm9yIG1lLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbyBa
aG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jIHwgMTMgKysrKysrKysrLS0tLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3Nf
djkuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5
LmMNCj4gPiBpbmRleCA1NjkwMmI1YmI3YjYuLmNjOWRkYzRiNGNiOCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4g
QEAgLTEwNSw4ICsxMDUsNiBAQCBzdGF0aWMgdm9pZA0KPiBldmVudF9pbnRlcnJ1cHRfcG9pc29u
X2NvbnN1bXB0aW9uKHN0cnVjdCBrZmRfZGV2ICpkZXYsDQo+ID4gICAJaWYgKG9sZF9wb2lzb24p
DQo+ID4gICAJCXJldHVybjsNCj4gPg0KPiA+IC0JcHJfd2FybigiUkFTIHBvaXNvbiBjb25zdW1w
dGlvbiBoYW5kbGluZzogY2xpZW50IGlkICVkXG4iLCBjbGllbnRfaWQpOw0KPiA+IC0NCj4gPiAg
IAlzd2l0Y2ggKGNsaWVudF9pZCkgew0KPiA+ICAgCWNhc2UgU09DMTVfSUhfQ0xJRU5USURfU0Uw
U0g6DQo+ID4gICAJY2FzZSBTT0MxNV9JSF9DTElFTlRJRF9TRTFTSDoNCj4gPiBAQCAtMTMwLDEw
ICsxMjgsMTcgQEAgc3RhdGljIHZvaWQNCj4gZXZlbnRfaW50ZXJydXB0X3BvaXNvbl9jb25zdW1w
dGlvbihzdHJ1Y3Qga2ZkX2RldiAqZGV2LA0KPiA+ICAgCS8qIHJlc2V0dGluZyBxdWV1ZSBwYXNz
ZXMsIGRvIHBhZ2UgcmV0aXJlbWVudCB3aXRob3V0IGdwdSByZXNldA0KPiA+ICAgCSAqIHJlc2V0
dGluZyBxdWV1ZSBmYWlscywgZmFsbGJhY2sgdG8gZ3B1IHJlc2V0IHNvbHV0aW9uDQo+ID4gICAJ
ICovDQo+ID4gLQlpZiAoIXJldCkNCj4gPiArCWlmICghcmV0KSB7DQo+ID4gKwkJZGV2X2luZm8o
ZGV2LT5hZGV2LT5kZXYsDQo+ID4gKwkJCSJSQVMgcG9pc29uIGNvbnN1bXB0aW9uLCB1bm1hcCBx
dWV1ZSBmbG93DQo+IHN1Y2NlZWRlZDogY2xpZW50IGlkICVkXG4iLA0KPiA+ICsJCQljbGllbnRf
aWQpOw0KPiA+ICAgCQlhbWRncHVfYW1ka2ZkX3Jhc19wb2lzb25fY29uc3VtcHRpb25faGFuZGxl
cihkZXYtPmFkZXYsDQo+IGZhbHNlKTsNCj4gPiAtCWVsc2UNCj4gPiArCX0gZWxzZSB7DQo+ID4g
KwkJZGV2X2luZm8oZGV2LT5hZGV2LT5kZXYsDQo+ID4gKwkJCSJSQVMgcG9pc29uIGNvbnN1bXB0
aW9uLCBmYWxsYmFjayB0byBncHUgcmVzZXQgZmxvdzoNCj4gY2xpZW50IGlkDQo+ID4gKyVkXG4i
LA0KPiANCj4gVGhlIHZlcmIgKmZhbGwgYmFjayogaXMgd3JpdHRlbiB3aXRoIGEgc3BhY2UuDQoN
CltUYW9dIHdpbGwgdXBkYXRlIGl0IGJlZm9yZSBwdXNoLg0KDQo+IA0KPiA+ICsJCQljbGllbnRf
aWQpOw0KPiA+ICAgCQlhbWRncHVfYW1ka2ZkX3Jhc19wb2lzb25fY29uc3VtcHRpb25faGFuZGxl
cihkZXYtPmFkZXYsDQo+IHRydWUpOw0KPiA+ICsJfQ0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0
aWMgYm9vbCBldmVudF9pbnRlcnJ1cHRfaXNyX3Y5KHN0cnVjdCBrZmRfZGV2ICpkZXYsDQo=
