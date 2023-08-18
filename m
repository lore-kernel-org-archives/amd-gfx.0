Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2C3C678DC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C3810E4EE;
	Fri, 18 Aug 2023 11:26:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A7910E4EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1l/BpB1btcJQT1GdwX3hoGwW/36t1EPrCAjbdP0NycfKhofjsp4/lv2QEXzX5CozcCGD7Ap8R4mfe+KriNqTVy7BWMQidg0Q92QZnexkJbdkwjiXgLDpO7X6PMSigzgqNvXa7tDYp/mF94hykww/rdia4rULE7csvK0aPa4rd1+WIFVha6dJYWffeGvMS3tF984ZhGK6aVAOUmCPax1qZU7U9iPxBqVp75axqIwSAA6KZrGJ9hCey9aLZ2APcz/z1NI9nY89Rgnthal6n1qyrnFHEIQ2wwW3WRK1kUCj08Tx+yc0i7aqKHpl4JcfVaA+2JkYw1Lsvf1bgub7aSfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoNGCNqBrNUtNH3iA+EFsw9FjhVOkOtjfAKehc9Q7iU=;
 b=EzMCzkE8RrgnMXZXoCv+k1iNDnEeOBefytkq3XijQ9lfbfxXfmH/nN+JIeQbtP9nmfax3zgRarBSbZ1e/aOj/zYjpyqgd+oZb/PS4D5ku9KIjwp8ySXiw30jv3EE4hP/sauSvqbqY43Ddv9lwTDz++8a73N8t8M8gllLLCwMfXhQTR/Aun1Exd5Sya3q+WPzV1Tb3zsCa2/RtrUVl23I6vv6ELrXh/eiqPG/X9fXWgVS7/70HpKForHQmma2PqtE3yzn7ssLoeTZHed/iw54qHiL7g7PC2jyKcysgeU+IDdcCJK9zFO/6tfq+FGQu6b3sC3x9Z9ybs3RzeHe0sb8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoNGCNqBrNUtNH3iA+EFsw9FjhVOkOtjfAKehc9Q7iU=;
 b=3l4NDAUiRJd6ZQ2sg7yMdnDVpf7imLjBHH7SJ2E6jm/X+/Y09LxtvKXDIrf4pIWKdFTbLSjAOie/k0IkY0RJ1S2vV5fzr7UVIaLdKYW3EWlF0k6N0TfGFQls611Pqq/rIJCW9GMVrnDqXQwSKoD1xzdMnr+5gtdmH6//ELRWZ/U=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:26:11 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::22f:b841:22b6:ab25]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::22f:b841:22b6:ab25%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:26:11 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use READ_ONCE() when reading the values in
 'sdma_v4_4_2_ring_get_rptr'
Thread-Topic: [PATCH] drm/amdgpu: Use READ_ONCE() when reading the values in
 'sdma_v4_4_2_ring_get_rptr'
Thread-Index: AQHZxpcVbFlTSye9KEm2PX02xQdj4a/wAErQ
Date: Fri, 18 Aug 2023 11:26:10 +0000
Message-ID: <PH0PR12MB5404DD2A81A5702A9A8AD99CF61BA@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=12c094cd-8aed-4183-a81b-93c5488a8985;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-18T11:25:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|SJ2PR12MB7866:EE_
x-ms-office365-filtering-correlation-id: b85ac2d4-ccfe-4374-d42a-08db9fddeca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmRQ+YSEntKFjLRtheSjyxvzbrvcOIgajx6PIdbAx1h4O1C9gAZq2XwF85zILkKcHeTRuWUKNoti0WU41DprGSs9U4E4+lzS/yCIW75wBr0jwIpPZXBp/vgx77VtJrRaz96mj3wZITfnuWmHlcmg8wMWjzmJf5m0aeUmGCBxqvixFpdRglCR0YuMYwQfGLwIPFqfHwa1FzFKKgAKJUvFhcwYVgNRtOk2YC7g5IolJptc6MsB88PfQ0skQRrjah7szXqR52CgEogjx2fxNQV1PWcMJCfzrsGXf5agbDv6smmOVm6q6SN3QnLcxQ72aq499LKGC1VrzUArwfj2Xy6xD7q9UmcQryFvF4hOd1of6dsFCUhc1JgceLDcU3v3FlRwAfY5d84ig+xfSsn5Ug8HoVOLvzXgn7lR/NzHGnJ8zFig84D5b2agMA5EbXGgmAwwZXf4h6YFWBeGeYYP4X2X9rk+N2ByyjEDSdg6WPkyV51R2hzl15bJw9SwdcgNDLrti6sxhBH8jTXu6lDKS89NCTeVEjJDwTGb0QOpMLibZFlStpem+l6oZUSMiXOCG6wIVrafM751nGgp3iwi87hVFTHGPl1WMGJJdQy+pBGsJ112N3SrbrVtK6eqFYEnzwfAbbk02QOjFVkDrzk0pOYvS2KpkH1Y7Rbwg4HS0u0Fi70=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(71200400001)(6506007)(7696005)(38070700005)(38100700002)(9686003)(122000001)(53546011)(86362001)(55016003)(83380400001)(921005)(33656002)(2906002)(54906003)(64756008)(66946007)(66476007)(66446008)(66556008)(316002)(6636002)(41300700001)(110136005)(76116006)(5660300002)(52536014)(8676002)(4326008)(8936002)(478600001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1R4L1lVYmwwV2k5amg4SnZ4OXJjRlliN2R5YmxjMXR1OXZHNEQ3L0U2QlhD?=
 =?utf-8?B?WUNWaUcrS3lFMnhtRHZyVUsvR1AyamNyMzVnOCt6REp4OXpKazZvUlRNOG50?=
 =?utf-8?B?bGU5WVBhS3Q2ZTFINWVuWkVPVStkUWtvbWtDZXlnaWlyMWxrL2Y3ZklwNUxv?=
 =?utf-8?B?Q3dMUk5ucVdEQVhLam1MclprVHRIdy9VbHhFSjk2NVpXQXhOcnk2SFl5UjN2?=
 =?utf-8?B?MjA4Q1dyVlJFOFIyTEtqRjhzVmNhOXhYaUVWYVdGN2NlWlg3eEQ5U1VaU2JN?=
 =?utf-8?B?V3o0U3BYVXFuTEJnK2ZIZHY2R2hwRUVrV1BXb2RNb3JzdmxGOTVweEhFTFJD?=
 =?utf-8?B?bUszUnJlc2dlOE4wQkZFSmhPOXd5RzVhYklZcCtNWGV2VS9xUytLbUI4ZHl3?=
 =?utf-8?B?Y2tQTVFTOU96S1ZMWUhRdlRLdm1FbjkzMXIwSTRWNUFVRS9YblhFNTE5MlM1?=
 =?utf-8?B?S3pLM0h4eXRxNU1HdEltcGx2azZQQU5paDFTVUtDMTBPYURkampWOHNwbDdF?=
 =?utf-8?B?cE9PRGlrY0xVSTdLc1VQTnJqUXpyL2g2NkhlQytvdVhieUNBQ2tMaVJWd3V4?=
 =?utf-8?B?dTI2RzB1K0pFQmVRSWIwS0lzTmlMU2c3SUFGUHhnQjl2L0tzd3A0RDJOV0NJ?=
 =?utf-8?B?eGZqWjBGOHk4a2xneW9vdno1MEdTWmZXR0dSTFJtKzlMN09hTjVHNGFuMkFB?=
 =?utf-8?B?Y2piVWFpS3c4eEFlYmFNbjJZVEdVeVJKZ0FxTHZzSHU3dG5ycWFieDJKS1Jo?=
 =?utf-8?B?ckJmRlk4ZXROWkwxNm85QlBuVyttdVJ5TDZEdkdXNVNXMUpiZHpEWFhJS1RJ?=
 =?utf-8?B?WnV5Q3JveEZsNmMxMzRaeERXRTR0UGM4MjhHWmhsUVAzZzd5ejFSSkQ2bW4v?=
 =?utf-8?B?OXM5dHJoYnFvaWlXZUZ6bUE4SjIxem9WUUJ5RFh5bVQzZWJZMFk2Q2hrRldC?=
 =?utf-8?B?VDV6UGlIR243UGlBbmcxUWp4N1NUYU1kWW9UcVY4ay9lbE9MZmZMVStia1Fi?=
 =?utf-8?B?OTM1K0pmbWdTbzcvaVdQUlJYdUR2dWQzUjE4c1VmU0Q1Rm44UXZxckxMSWQy?=
 =?utf-8?B?WUVkLzh6WHErbmdTcW4rTCtmQmZvSzJsSmZkRC9rc1IzT0gwd3VtWW42cHRW?=
 =?utf-8?B?cm11QlZielR3MWcyZ2IweFltMWtVTTVsUEdwcFlBdHlwOThCTnl6dWkwSzBn?=
 =?utf-8?B?NDhiUDFvWWl1VEdVMGgyL2tZRzV4eGpRalJGbTc4ZGM3WTBZUmZMaERyTmNv?=
 =?utf-8?B?aElRdFVacjJNOElOWkNPUW83SFdOVEl3RmwybVJlL0ErU3JKU2szRXRvU1F1?=
 =?utf-8?B?WTl0L2Y0RzRGQ0UvaTNiOXlrOENSZ0VoZ0o4SzBXaC9XQk83d2RMMjJEdGwr?=
 =?utf-8?B?T3hhTVo5UGcyV2VTL0trb2lqOS96MFRWOEE1ZFZFVmlqT2k0c1g4b2hCV05S?=
 =?utf-8?B?SnkvZGhjbmJNVGtYN3g0N3QvWHB1L0ZHU3B6NXZ3OU01U3NaS2dWOS84RVpK?=
 =?utf-8?B?NTRwM2hlOXNCRE4vUGF4UFZmczdVaWRZUmpJbjlaRDE0amZjdW9MSFR5a2FW?=
 =?utf-8?B?YnpSQVY1U0Zmd08ySnRDMnp0UkEyRVN5RkhnWGdOMjV2NXpSR1h2MXpUNzdy?=
 =?utf-8?B?NHpzRHNkaUtSS3RGVFdoQnh0QWhvZXowSlpCVjZGL0JMcTJPRzRJMEMxNjIy?=
 =?utf-8?B?QXFXbm9aellhYnRrK1hCUldrbkZjNmNVYWRLWnVacXJic1V1aFp6a1FBdGky?=
 =?utf-8?B?aWZzd0FOMVdDcmJFZE0rUGg5dVpwdFZsTGtMZ2c5NmxJQWpPWDZwTG9iTk52?=
 =?utf-8?B?c0R2ck5KUjM2ZmVTQU1CODlvZzFialFwek5kcmhzUlUrNmNjY05TSmRJVXQy?=
 =?utf-8?B?RFVsT0VHaURLRDU0aW9TRWF1N2VuRENOc0d4MFl6ZlkzQlpzWlUzM0xid1dX?=
 =?utf-8?B?d3lSK0E1Rk9OQjUwL2o3YkZjUHMzYW1PRHF0Tk16d2gwKzNlT21KN3dKTmNV?=
 =?utf-8?B?Yy93V3RtN25EREdLbTRIa1NoblErOEJmSjIxRVhBeExDcXFsTlJab0k2N1hH?=
 =?utf-8?B?YS80TktoR2xNQ1JpRVcxUTFSdHU4THlscUJSdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85ac2d4-ccfe-4374-d42a-08db9fddeca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 11:26:10.9243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kkhGyfPAzKRpfVdHlj+mLfl/KzRAwanpfL3V276Yfx7zekeYVi+M8dWtD8Y4MAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBMZSBNYSA8
bGUubWFAYW1kLmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
SEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNl
bnQ6IEZyaWRheSwgQXVndXN0IDQsIDIwMjMgMTo0NyBQTQ0KPiBUbzogS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNv
bT47DQo+IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FODQo+IDxTUklOSVZBU0FO
LlNIQU5NVUdBTUBhbWQuY29tPjsgTWEsIExlIDxMZS5NYUBhbWQuY29tPjsgWmhhbmcsDQo+IEhh
d2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1k
Z3B1OiBVc2UgUkVBRF9PTkNFKCkgd2hlbiByZWFkaW5nIHRoZSB2YWx1ZXMgaW4NCj4gJ3NkbWFf
djRfNF8yX3JpbmdfZ2V0X3JwdHInDQo+DQo+IEluc3RlYWQgb2YgZGVjbGFyaW5nIHBvaW50ZXJz
IHVzZSBSRUFEX09OQ0UoKSwgd2hlbiBhY2Nlc3NpbmcgdGhvc2UgdmFsdWVzIHRvDQo+IG1ha2Ug
c3VyZSB0aGF0IHRoZSBjb21waWxlciBkb2Vzbid0IHZvaWxhdGUgYW55IGNhY2hlIGNvaGVyZW5j
ZXMNCj4NCj4gQ2M6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiBDYzogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzogIlBhbiwgWGluaHVpIiA8WGlu
aHVpLlBhbkBhbWQuY29tPg0KPiBDYzogTGUgTWEgPGxlLm1hQGFtZC5jb20+DQo+IENjOiBIYXdr
aW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5p
dmFzYW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMgfCA4ICsrKystLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gaW5kZXggZjQxMzg5
OGRkYTM3Li4yNjdjMWI3YjhkY2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
c2RtYV92NF80XzIuYw0KPiBAQCAtMTU0LDEzICsxNTQsMTMgQEAgc3RhdGljIGludCBzZG1hX3Y0
XzRfMl9pbml0X21pY3JvY29kZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAq
Lw0KPiAgc3RhdGljIHVpbnQ2NF90IHNkbWFfdjRfNF8yX3JpbmdfZ2V0X3JwdHIoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nKSAgew0KPiAtICAgICB1NjQgKnJwdHI7DQo+ICsgICAgIHU2NCBycHRy
Ow0KPg0KPiAgICAgICAvKiBYWFggY2hlY2sgaWYgc3dhcHBpbmcgaXMgbmVjZXNzYXJ5IG9uIEJF
ICovDQo+IC0gICAgIHJwdHIgPSAoKHU2NCAqKSZyaW5nLT5hZGV2LT53Yi53YltyaW5nLT5ycHRy
X29mZnNdKTsNCj4gKyAgICAgcnB0ciA9IFJFQURfT05DRSgqKCh1NjQgKikmcmluZy0+YWRldi0+
d2Iud2JbcmluZy0+cnB0cl9vZmZzXSkpOw0KPg0KPiAtICAgICBEUk1fREVCVUcoInJwdHIgYmVm
b3JlIHNoaWZ0ID09IDB4JTAxNmxseFxuIiwgKnJwdHIpOw0KPiAtICAgICByZXR1cm4gKCgqcnB0
cikgPj4gMik7DQo+ICsgICAgIERSTV9ERUJVRygicnB0ciBiZWZvcmUgc2hpZnQgPT0gMHglMDE2
bGx4XG4iLCBycHRyKTsNCj4gKyAgICAgcmV0dXJuIHJwdHIgPj4gMjsNCj4gIH0NCj4NCj4gIC8q
Kg0KPiAtLQ0KPiAyLjI1LjENCg0K
