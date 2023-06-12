Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB73C7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 00:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD5D10E0EE;
	Mon, 12 Jun 2023 00:08:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED8510E0EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 00:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSj16Q9yRGt3CtM+eGJfDaUXvrlpsJvHuLjpuv5cJFw1EM6SVgn2BSSsaWcLk1fi58IssD2duSR8dPWFHWnghslkSoHUf9nk9gjfRC8JRwPezRTQBv4A+K7B63Uuq1ETZAHRY5/bZqrt9Vv2LdQKarBeJP4cANZLpjg1xmWUDoK2hVhU/jD3F7eQpIrhnyxL+GmX6lFd2WoWVXf5o0z3DWQzand7xCItTRLQC7ZlgKrnJupugVIJA2bgqFF9DbD6I7T9lCS2LZpRzxiAc8RtIJWE0mHTqfpHTXrPGjpKhYNCSBonomCCMTDXGi3mtSqBhWUWC9nr8+nwepgZjmXfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wva5acmTXLXXPyxIb1fEH9XkQbaIgyEJQ2JHuC27Brc=;
 b=hBG6yO07hlffuRG9HrGU2sv9MNZJQvKXFtg/Siqn7WFx/Dp/JVjM9Avr1qiTM4Jw6EHmAm+l9v+Rs3fJrLgU5XPp+iN6kOsSk0V3fa3myAhDlzYJpPHE7bcs1EbsmgOqmtJw+g7VPz+KHAbs2ACfsqqhxqByQ8lUmMFA2qwbGWB6hx5bcQdrCxpS33tAE4S2Oub+AFe7mxbj2a+llNSw2XG1Zt9u1tfPOYURWF7Z+mCVH6FNFLAddGd8QFVs9U50j4wUvDZmrl2F83h+fm/M4wTnO7pCvTnwJPI1fgmHJJNIU1brGZOkodU7fjG2WlU80oIIBm58Hq80ojrC6ayVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wva5acmTXLXXPyxIb1fEH9XkQbaIgyEJQ2JHuC27Brc=;
 b=36t5+cVLa3g2NVUtLE1zRycuEXVbxRBiPd0uGZlvgpG/BzUZFj3rgAdNSBq/rGxUP1/AqePsttGXZCyY+mINDCIALgXYu47QAScvHvdNifaEcc+kY1D4TjFyKlsl6FOUB9ELFfP9KXp8cuSOr/36sPCUZHjP/l/gefIrpWNK/Dk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.29; Mon, 12 Jun 2023 00:07:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3bef:2463:a3e0:e51c%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 00:07:52 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gui, Jack" <Jack.Gui@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix memcpy() in
 sienna_cichlid_append_powerplay_table function.
Thread-Topic: [PATCH v2] drm/amdgpu: Fix memcpy() in
 sienna_cichlid_append_powerplay_table function.
Thread-Index: AQHZmq7Avtpj5wgSJU+zhEiBKIZgHK+GTliQ
Date: Mon, 12 Jun 2023 00:07:52 +0000
Message-ID: <DM6PR12MB2619570C389FFD93213110F2E454A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230609084513.261487-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230609084513.261487-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8b36d22d-6f11-420c-86f4-a855b35d59eb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-12T00:07:20Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM8PR12MB5414:EE_
x-ms-office365-filtering-correlation-id: e62e10d6-bf6b-44ed-bb0c-08db6ad910be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BL87EhWnet4Q4xu6zrA2W8a9pKnd3NhR6KQV1y9t881P9bc9WnxnaYlwJGXN2Jk/8LPBC+7is8c4trpuCRbhECX5Y57Vz2J0sHE/VeWPUHVF8FeAYn6QbHw3gEMjSnjOU8PZ4y9F3mnIdwzmDmD24yOz8x4PfP9PuN/aB9bM6JAM5wh0S/ue7DrtecXoBzOFXwtVMp+8Fl7CpsLD/atnMU7XOM5zvnc3O309F6qfwdnowJqEW/T4y1VSWtNSG6JhVOrDBBvh6Ud0ut0kx0GVPiFJm5vp2BXPU/9pSHDi6bvs4ngP7+WVBLLaJ+r/6g2P3FQyYgTSdPRsuFT3x0ZbayIyNKryl+06MxK8N9atC1OCp0sFx68zWe+h9YWr/NN0YO+hx8v2okXl9yuLF0aSMDIfWXN57HEEoNht1mjjaQEPowoWC2YOBYmDo8W/18Gb1aYyepoSnCDWRLINmIDvS7jfVWMnNFADJzBJqPBcQ4TCkkEKKR5o9i7WzPhnEAbAomMdqDN7WKkd8fF9UVLTtYQ4Q9DmfOcBbbHuznuDbpMNj/vFMJ+/Q5buk2zd/YevcKLSf6Av42/XMKFycYjW/u8GeLOnhrY9EeLKM1kDmnBpx/srU8GJgLdSXqzQyeTfRxSMVGXGBOZ20991GYQWRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(66574015)(83380400001)(33656002)(38100700002)(86362001)(122000001)(55016003)(38070700005)(478600001)(110136005)(19627235002)(4326008)(7696005)(71200400001)(8936002)(8676002)(2906002)(5660300002)(52536014)(66556008)(66946007)(64756008)(66476007)(66446008)(76116006)(6636002)(41300700001)(316002)(53546011)(186003)(6506007)(9686003)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2FwblZoRW9IRENlYVpMVDZzK2ZnOXk2WEZWa2gxbzZwbGhFc0MzUmVVNGtJ?=
 =?utf-8?B?cUl6Nk1NUmUzaVp1U2FpTnVPYjZkN2VITWdncGRtTFpEeTBoVmpaTmlEb29X?=
 =?utf-8?B?clpKVnpJVlZsOEs5ejhRWGdVVmdBbUVRRloxM2NqUjdSSE1qZjdYTzZQblEz?=
 =?utf-8?B?dm9yY01CY3o4WVlIdklNbTd0Z282MCtFclQrZXp4akp4V2huQnJxVGxLdTVR?=
 =?utf-8?B?eVBYUjVNSXJBMjM5a0c4d2VTR0dsVUIyeFRpRE0yb213dkpUampxaXZLVzlM?=
 =?utf-8?B?bEV2Z04vSWlXVERjd2JudXdsZmhkbSs1SHU4MU8rNnFzNndqV3dncVdSMUxW?=
 =?utf-8?B?NUkxUmpjMXhqYy9RZm03eDVmN1FteS94YnNpbVgxTHBlOXZ4eDVSTjJBVFI4?=
 =?utf-8?B?OEx5Z1pkQ0EwNExtTWFoMkhKRFpCSzBSREJrYXBKUXZGWUxNWTVSSXhOQXBI?=
 =?utf-8?B?SnBzWFRiTmwvSEdHZHVWZG1INVFoUkp0QUFKQnZOUlZzZXo2RXBhYmUvNmJk?=
 =?utf-8?B?QXlzRDZDQ2hpZ0h0aDVVdzYrUmgzQm84YlJGOVJqKy9vOHE3MkY1aGJ0RE5L?=
 =?utf-8?B?UENndWxKc09DT29nZHE2bUpLdHorU0VBQnQ3aUZFaDZPd2Z5TFVwSzFQbVRB?=
 =?utf-8?B?Nkd5RE5NbjlSMEVTQTVlRGVzSjQ1USs3V0RyS1RWSk5IVzJVNnB1WG1tVWFp?=
 =?utf-8?B?dkVQRExKdklYdUFWOHR5aWo5QkowTnZRRjVzdHp5c0lsZHhJTkQzYm1mTGlz?=
 =?utf-8?B?R2ZPME1UZWQ0Y2k3N1owcEgzam5ueTVaNmJqbnMxWk9zRTJ2ZkRZelMwMUpY?=
 =?utf-8?B?bnNmSHVmRGpKdjMrRDRnckhKaWMzaWl2MXE2b0Jia1FQWHVvK2xTb3QxQ0g5?=
 =?utf-8?B?dnBnYzFMQUY1V0YrTTJBOXNVbU9xS0crNTV6dEJ1ZUdCalorZ3A0d2VnQXdQ?=
 =?utf-8?B?bDF4ckdkUFZ5TTRzaWZrR0UvckJkR2dPaU5SV1R5VVI0NTZHMzBiUm9odmwv?=
 =?utf-8?B?UWEwOENReHJ2eEJhalh1bU9XSHNremU5cWtlaHdvZmZNRWhBZjBLVWpFRmtG?=
 =?utf-8?B?ZHp6NlpXVFBPMktTakZaK0JRaU9LMHB1T0VTT0RFU3lqQUNLb2NXNnpKM3pw?=
 =?utf-8?B?K252TUQxVXhWa1YycGhoSWRSZU1TT0ZCYzlRRC9yaVgrUUx3eW5SRit4N05q?=
 =?utf-8?B?UlhhMzFXSUNGYzZoVzJweDV1YUdrTmVkcXBQRHVqSXFkNUhBNlBpVnQra0F1?=
 =?utf-8?B?QjBaMEJ0emxNUlJ5ME8ySVNGS0UvalNLa2hTU24wYWttaEtZVmxXa2Fldnky?=
 =?utf-8?B?OFBLWFBhc21DZVR6UDFIeWtYdkszUGNOU0p0UHVKWHVRL0FtaXg0WDNoNW90?=
 =?utf-8?B?Yjh5bXM2TjdmUjhHc2dyS0pncUEwcEJzdVh5cjMrZlFCNnBlOWdob0tvMUtF?=
 =?utf-8?B?QTJjQ3pZVnFrczMrZllXdWNTWjNHUVBkK1lEeXh0TDE1Wjh3Rnk1RjdCNFN1?=
 =?utf-8?B?dSt4VGF1SlVuT3N6dnVYeUs3b3RRYnFZcUtFV1VTV1lOL1lsZmcwSytXUk41?=
 =?utf-8?B?KzVONWJmK2Z2UGxYWnRQSEkrelpUdHlkQ1BwOFU0WFhEbGs3Vk41eHNwQXdF?=
 =?utf-8?B?VjVrbEk2RXRWdit2SXprcS9wY2NMUVhxdEc5ajFRRTZzMUQ3OVE0WTUzY3hN?=
 =?utf-8?B?NEl2ZWIwa0lnQ0RSUnYycG8vVW8zaW82VXM5ZWhvRHhBempscm4vSlZxa3dx?=
 =?utf-8?B?QkkwTFBOelprS0lkYUQvRU5Fa2FoWHhqcHRHK0FjTGlrRVM0cFhMR2t6VldP?=
 =?utf-8?B?QmdUeGN0RXR5a2oyL3AwMFNwWnJFKzAxcHB5aFJTZTNZdTVpYjJ3eEE2a1Rj?=
 =?utf-8?B?YmN3NnI2WVlSMmg1dnJ2bVhqajhmK2JFRmliNnlpV0JQY3YyU0ttNFlFVU5O?=
 =?utf-8?B?YS9sWlVScGdSZ3d3bTUwamZTU3gyWjYvYjl0L1hDbzZkQTFkVWtqQVVnTHI3?=
 =?utf-8?B?b0lZZ2g2a2lqOS9qOG54R2p2Z1puemQ5TitWVkVidlhXWHJtbG1kNDZrUHJS?=
 =?utf-8?B?MG5DWmI3SXBMNmhSNnZlV3liV3lXN0YwU2JrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62e10d6-bf6b-44ed-bb0c-08db6ad910be
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 00:07:52.4100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1RXjQSh+81OhO4htlKtRGmHlMkEAdHqcBfVQlgZd+RVhPNww3fOwAZAFlfvTk7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNv
bT4NCj4gU2VudDogRnJpZGF5LCBKdW5lIDksIDIwMjMgNDo0NSBQTQ0KPiBUbzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4N
Cj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQu
Y29tPjsgR3VpLCBKYWNrDQo+IDxKYWNrLkd1aUBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5T
SEFOTVVHQU1AYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBGaXgg
bWVtY3B5KCkgaW4NCj4gc2llbm5hX2NpY2hsaWRfYXBwZW5kX3Bvd2VycGxheV90YWJsZSBmdW5j
dGlvbi4NCj4NCj4gRml4ZXMgdGhlIGZvbGxvd2luZyBnY2Mgd2l0aCBXPTE6DQo+DQo+IEluIGZp
bGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvc3RyaW5nLmg6MjUzLA0KPiAgICAgICAg
ICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2JpdG1hcC5oOjExLA0KPiAgICAgICAgICAg
ICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaDoxMiwNCj4gICAgICAgICAgICAg
ICAgICBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1bWFzay5oOjUsDQo+ICAgICAgICAg
ICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oOjExLA0KPiAgICAgICAg
ICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaDoyMiwNCj4g
ICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5o
OjUsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVh
ZF9pbmZvLmg6NTMsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvdGhy
ZWFkX2luZm8uaDo2MCwNCj4gICAgICAgICAgICAgICAgICBmcm9tIC4vYXJjaC94ODYvaW5jbHVk
ZS9hc20vcHJlZW1wdC5oOjcsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGlu
dXgvcHJlZW1wdC5oOjc4LA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4
L3NwaW5sb2NrLmg6NTYsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgv
bW16b25lLmg6OCwNCj4gICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9nZnAu
aDo3LA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlLmg6
NywNCj4gICAgICAgICAgICAgICAgICBmcm9tDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jOjINCj4gNjoNCj4gSW4gZnVu
Y3Rpb24g4oCYZm9ydGlmeV9tZW1jcHlfY2hr4oCZLA0KPiAgICAgaW5saW5lZCBmcm9tIOKAmHNp
ZW5uYV9jaWNobGlkX2FwcGVuZF9wb3dlcnBsYXlfdGFibGXigJkgYXQNCj4gZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmM6NA0K
PiA0NDoyLA0KPiAgICAgaW5saW5lZCBmcm9tIOKAmHNpZW5uYV9jaWNobGlkX3NldHVwX3BwdGFi
bGXigJkgYXQNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vc3dzbXUvc211MTEv
c2llbm5hX2NpY2hsaWRfcHB0LmM6NQ0KPiAwNjo4LA0KPiAgICAgaW5saW5lZCBmcm9tIOKAmHNp
ZW5uYV9jaWNobGlkX3NldHVwX3BwdGFibGXigJkgYXQNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmM6NA0KPiA5NDoxMjoN
Cj4gLi9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6NDEzOjQ6IHdhcm5pbmc6IGNhbGwg
dG8NCj4g4oCYX19yZWFkX292ZXJmbG93Ml9maWVsZOKAmSBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0
ZSB3YXJuaW5nOiBkZXRlY3RlZCByZWFkDQo+IGJleW9uZCBzaXplIG9mIGZpZWxkICgybmQgcGFy
YW1ldGVyKTsgbWF5YmUgdXNlIHN0cnVjdF9ncm91cCgpPyBbLQ0KPiBXYXR0cmlidXRlLXdhcm5p
bmddDQo+ICAgNDEzIHwgICAgX19yZWFkX292ZXJmbG93Ml9maWVsZChxX3NpemVfZmllbGQsIHNp
emUpOw0KPiAgICAgICB8ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPiBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4NCj4g
dGhlIGNvbXBpbGVyIGNvbXBsYWlucyBhYm91dCB0aGUgc2l6ZSBjYWxjdWxhdGlvbiBpbiB0aGUg
bWVtY3B5KCkgLQ0KPiAic2l6ZW9mKCpzbWNfZHBtX3RhYmxlKSAtIHNpemVvZihzbWNfZHBtX3Rh
YmxlLT50YWJsZV9oZWFkZXIpIiBpcyBtdWNoDQo+IGxhcmdlciB0aGFuIHdoYXQgZml0cyBpbnRv
IHRhYmxlX21lbWJlci4NCj4NCj4gJ0ZpeGVzOiA3MDc3YjE5YTM4MjQwICgiZHJtL2FtZC9wbTog
dXNlIG1hY3JvIHRvIGdldCBwcHRhYmxlIG1lbWJlcnMiKScNCj4gU3VnZ2VzdGVkLWJ5OiBFdmFu
IFF1YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogRXZhbiBRdWFuIDxFdmFuLlF1YW5AYW1k
LmNvbT4NCj4gQ2M6IENoZW5nbWluZyBHdWkgPEphY2suR3VpQGFtZC5jb20+DQo+IENjOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFz
YW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiAtLS0NCj4NCj4g
djI6DQo+ICAtIHR1cm5lZCB0byB0aGUgd2F5IHVzZWQgZm9yIG52MXggKEV2YW4pDQo+DQo+ICAu
Li4vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jICAgIHwgMTggKysrKysr
KysrKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+IGluZGV4IDg1ZDUzNTk3ZWIwNy4uZjdl
ZDNlNjU1ZTM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4gQEAgLTQzMSw3ICs0MzEsMTMgQEAg
c3RhdGljIGludA0KPiBzaWVubmFfY2ljaGxpZF9hcHBlbmRfcG93ZXJwbGF5X3RhYmxlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211KSAgew0KPiAgICAgICBzdHJ1Y3QgYXRvbV9zbWNfZHBtX2luZm9f
djRfOSAqc21jX2RwbV90YWJsZTsNCj4gICAgICAgaW50IGluZGV4LCByZXQ7DQo+IC0gICAgIEky
Y0NvbnRyb2xsZXJDb25maWdfdCAqdGFibGVfbWVtYmVyOw0KPiArICAgICBQUFRhYmxlX2JlaWdl
X2dvYnlfdCAqcHB0X2JlaWdlX2dvYnk7DQo+ICsgICAgIFBQVGFibGVfdCAqcHB0Ow0KPiArDQo+
ICsgICAgIGlmIChzbXUtPmFkZXYtPmlwX3ZlcnNpb25zW01QMV9IV0lQXVswXSA9PSBJUF9WRVJT
SU9OKDExLCAwLA0KPiAxMykpDQo+ICsgICAgICAgICAgICAgcHB0X2JlaWdlX2dvYnkgPSBzbXUt
PnNtdV90YWJsZS5kcml2ZXJfcHB0YWJsZTsNCj4gKyAgICAgZWxzZQ0KPiArICAgICAgICAgICAg
IHBwdCA9IHNtdS0+c211X3RhYmxlLmRyaXZlcl9wcHRhYmxlOw0KPg0KPiAgICAgICBpbmRleCA9
DQo+IGdldF9pbmRleF9pbnRvX21hc3Rlcl90YWJsZShhdG9tX21hc3Rlcl9saXN0X29mX2RhdGFf
dGFibGVzX3YyXzEsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNtY19kcG1faW5mbyk7DQo+IEBAIC00NDAsOSArNDQ2LDEzIEBAIHN0YXRpYyBpbnQNCj4gc2ll
bm5hX2NpY2hsaWRfYXBwZW5kX3Bvd2VycGxheV90YWJsZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNt
dSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHVpbnQ4X3QgKiopJnNt
Y19kcG1fdGFibGUpOw0KPiAgICAgICBpZiAocmV0KQ0KPiAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+IC0gICAgIEdFVF9QUFRBQkxFX01FTUJFUihJMmNDb250cm9sbGVycywgJnRhYmxlX21l
bWJlcik7DQo+IC0gICAgIG1lbWNweSh0YWJsZV9tZW1iZXIsIHNtY19kcG1fdGFibGUtPkkyY0Nv
bnRyb2xsZXJzLA0KPiAtICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCpzbWNfZHBtX3RhYmxl
KSAtIHNpemVvZihzbWNfZHBtX3RhYmxlLQ0KPiA+dGFibGVfaGVhZGVyKSk7DQo+ICsNCj4gKyAg
ICAgaWYgKHNtdS0+YWRldi0+aXBfdmVyc2lvbnNbTVAxX0hXSVBdWzBdID09IElQX1ZFUlNJT04o
MTEsIDAsDQo+IDEzKSkNCj4gKyAgICAgICAgICAgICBzbXVfbWVtY3B5X3RyYWlsaW5nKHBwdF9i
ZWlnZV9nb2J5LCBJMmNDb250cm9sbGVycywNCj4gQm9hcmRSZXNlcnZlZCwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNtY19kcG1fdGFibGUsIEkyY0NvbnRyb2xsZXJzKTsN
Cj4gKyAgICAgZWxzZQ0KPiArICAgICAgICAgICAgIHNtdV9tZW1jcHlfdHJhaWxpbmcocHB0LCBJ
MmNDb250cm9sbGVycywgQm9hcmRSZXNlcnZlZCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNtY19kcG1fdGFibGUsIEkyY0NvbnRyb2xsZXJzKTsNCj4NCj4gICAgICAgcmV0
dXJuIDA7DQo+ICB9DQo+IC0tDQo+IDIuMjUuMQ0KDQo=
