Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79826C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 02:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CE910EA5B;
	Thu, 17 Mar 2022 02:13:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C960B10EA5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 02:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/QQ+7B9Qlvrt1OEPG7xlzferii4jUHLxdBEqNv1KAvlDbbe9WunEjJP+prrf+vDzZB4zGfvDt2hx4ZXXTEV2YMwSrBHVyYutwq2AcGsN+NmHkcCBvh819CtgTt6YFdneI8UswiFrpih3cSpw1jV18snhcOI5DaS0b7qK4pS01khvnUAXgkVkONmCby0ZUnlvrdaK4WeW4mG43Cv8JNjboQuYZUVprBO8VSw/43vvHZafM6tbvNv5atxv237M/qPwPPmUtxJcv+SsgBZtXL9IQ3Wee8874y7m0TdSm/sIpOmwQ0pxQeUAuDMGUYwRALwIuPCm1fvnpOnborqXUPZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhOb5EJQznnmEN6C0fDobylL/Loljia4QaJzrMRdtNk=;
 b=QEnzyZMG4Fi05DNm15EPZ6H6z5s0+GbTER2WX5k68pargZAMuiwWvwSdvdjSwrF7oO+miKN5R7j0c34HMgcy8V5092pTkTlUqohJepfrpiU3jrjn9ehjIRD0qXu1L8oAL6A+ZeunR8yat6mienBSdurTHzwb9iObk99KQykRka99UCnmoAIeeIpWV+HNBg6h7HATUXiX6VHxuQVU0Rhg2tRI3DGchmd4Gj3VK+o5YyyipvYRfROER0wMUbBx1CqtYhwqjg4TGpJj7MmoPT7CFXwEIDhFtb+tezu3dH+VBdJKhY1LSNocWDGkglMEQN053bHV+id9ZgBXwo4q27JN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhOb5EJQznnmEN6C0fDobylL/Loljia4QaJzrMRdtNk=;
 b=ihgiTIyzd4ET+aISGOnXLW/zXKTfqg16JxRVOOHtGxLSASE/6CtKRrqZxhyBUtY2mIq8lgkQOTUXmbwwseIFrY+jLmJkENJr4hhryBSOY9WJHuls4WoXyzK1PHxo0YJTLL/vCA7dj7lzcMrtKWwuVoLftEgKBGE3D7QEAvCbCrY=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Thu, 17 Mar
 2022 02:13:02 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 02:13:02 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Thread-Topic: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Thread-Index: AQHYORfxWcWRLFzCXEGnKqr03gRJGqzCC0eAgADKZDA=
Date: Thu, 17 Mar 2022 02:13:01 +0000
Message-ID: <DM5PR12MB17702075BF545EF1F3DDAB50B0129@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
 <6b278e9f-a443-b297-ab59-c7126d324302@amd.com>
In-Reply-To: <6b278e9f-a443-b297-ab59-c7126d324302@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-17T02:12:59Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ec5de033-1e09-4f2c-a88a-373c630aca7e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-17T02:12:59Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: eaab6f8d-025d-4d8f-852b-93a5ec8cc93b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a70e3e84-9745-4d02-0e15-08da07bbaa2c
x-ms-traffictypediagnostic: BY5PR12MB3891:EE_
x-microsoft-antispam-prvs: <BY5PR12MB3891E6904170D4458BA26D8CB0129@BY5PR12MB3891.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /mcOn4RVLkkVDkm+Iw04qNMmYlbuo3SY9Kl1XPWrd83UqolY7Kr1NnC+tKlgKGoreKindLQ+dNDcD0m/nwpeEbMf7KkrFyMaa9oBnI+zf4y8X4V1YbI9F85yiiZDKrSj4Z8b0GpfVvY2CtPTM0dM+8Y8+DhZfR+tR4TBf0Y9lj3bQGdKEtYXr1jm6i+z4++AvowPUmeTQiJsb4PUQ5Ej+SDo3IBZOoHxVSSPwGJJX7UBN8JHQCUDJ8yeB2/5MRRf3CI9mRvmmVuCgEz0C76AjCrX+359fCGiLudlvjdnDnA1DRh0ZKR213DvHbDz1i+PBznoS29V0a0bgAHja7tQTPhSQrFRBdUW3rF5rRXw74tZWQT2yAUPAYDXXGQARuumWN0XPVR0psSup8TogGeRWVsP+Y36XTjO/xTfOEMkqfC8Eo1Fo8HOWhGH0Y1rpROAWr0V47udEmi5TZZHHxg+ev1muS24eDWk54JTUX05aLl8Z+DOCXJOt6Jf8jZf+ri3OMSvJWDJwDNTIw5dEuhfQFBDMQfoC3YnbDSteTGIehOPMj0Ef6oFrXKPmD5A/710Xg5BhpWcxZj2XDEUWV7UE++h9uyGY2f8DgQ+itYW6FshwQZFpjtWU1HLz9v1GuC3v5ijpUetgE9WV9xpe9s53PZvfgi5auvi2oUxRRmPPoEhIZTdBg4z96muQmXSJE6jHd+aJdTk4Au50iPyLaKtSA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(76116006)(66556008)(66476007)(66446008)(71200400001)(8676002)(64756008)(66946007)(6506007)(7696005)(9686003)(86362001)(38070700005)(55016003)(83380400001)(26005)(186003)(5660300002)(38100700002)(8936002)(52536014)(33656002)(508600001)(122000001)(316002)(6636002)(110136005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNsd1AzUlZsWDJpVUFJdlh4TVk3MkY5S0E4T04zVGtXZHU5Tndsa3gyR0hZ?=
 =?utf-8?B?Z1NEZkRKZ3JVeWFHVndOWjZDUlBCZzZWZElpMXhpS0pQRmhDdlRpTUNzdVFa?=
 =?utf-8?B?bmlNWlJhU3ZRUjV1b3dkNGx2SFpsRTB0eWtacGEwdDgvSm40QzFnUFFRSmxZ?=
 =?utf-8?B?YXdlYnhTUDlrK2pQYlBONXM3VXRUNVhwUnc5Ry9PeVdPTktXdmV1dkxqZmJW?=
 =?utf-8?B?N3I0d0FNajVTZ08vSEVrdXE4ODl3dmMwQnMwVFFFWGZpdVJOV3N4OGRBc3Jt?=
 =?utf-8?B?MjEyYnEyNHp0SExEMktRMnFYWEhBc1IzQlI4MFdxN3htR2Q3Q2U2VXdpL3Rt?=
 =?utf-8?B?YTJwOENjMGw0S3BSdXIzOWgzRlBNUmY2ZiswVkFCTTVrM0gzMEQyRWRMaUNk?=
 =?utf-8?B?V2phYUxrMDRPR0dJNVlvVUZFY2dSSEJYOWZydG1xWVVFVDE2dllNZXcvVC9u?=
 =?utf-8?B?WkNvZVBqNHJic0pNVDErODFPL1k3aVJvdGtBdk1pTFplOGxMN0tCSGszYXR5?=
 =?utf-8?B?Z2s5SVhDWVp6U0dMS0RKcTdyd2pYWFordm9FTUNESU9MNjJRVnFsaXlVLzdx?=
 =?utf-8?B?Yk0yZmxKVWdJWGZOWFUzbGI0Q0hiL0RYZ20xanluVEN1c250R2ZsOVBocEI5?=
 =?utf-8?B?ZnVFSUR3MGJEL0dKWTYyRzNEbElDRS91UDVYdkhHUk1ZZ1Zkemg0VGxDdmsz?=
 =?utf-8?B?ejVic09RQUdGQ2hmMFMvQnZwcDk2ZGpkSTZQMUI3b2dJTEpBb0FIcHd2cFhy?=
 =?utf-8?B?SEo0dy9lN3dFTVpQbVRIYWpEL0NJZmdPY0doaEowVDhaT0J0VXcvY1pITFNt?=
 =?utf-8?B?YU80Rk9va3ovYm50TFdaanc1NDZ3S3E1RVMyclkxVmloSVpUT3JXZ1lxTW1i?=
 =?utf-8?B?VE1yMUpVVlV0TGxQbGpxeDliMFBsTHFNTkltVmdUYm5uZnU3TzFYckx6VVhL?=
 =?utf-8?B?RElzeVp5Z1ZBQ0JOa1RTbmlFMXJwMEJiVUlia0plZ1VRdk5FTVdUNGFxQlFW?=
 =?utf-8?B?U1F5SW1WMVppZWtuaFd5U1Z6WmtiTUZKL1hNZ0ZkNFBMZy81Yy9FOE9wNjNB?=
 =?utf-8?B?QnhaZ3MycVBzZitSYTVZT3N5dExwSVcyWVVvZlZNUmJqVzViMzZsdFg0eVIv?=
 =?utf-8?B?SkkzakhFcmFXWkgxQkRXWjhtd2pkMzFFTERqTnFNV1crdEZaOXdwWFJZQnJh?=
 =?utf-8?B?N0h1T2s5NVNUY0h2aHdwTzVPNktDWDJNSElCeFBlS00xSDJlckJWT2x2Mml4?=
 =?utf-8?B?cG1TN1NiL0wwNHhNbmtBTkRKbmxIMzA5U054TWdkQzZxTDd3ZTZLRVVPY3dJ?=
 =?utf-8?B?RFoySHp4QmZxeHRBcC91R3FtWHhyWkZ3d1JZYnE4NnJsNS8xU2p3RXVmTTF4?=
 =?utf-8?B?ZFJPM0FrckE5bFFvbkV4KzVjMnA5SXM4aFVidkw4L0dhVXl0OGlybVBqanpZ?=
 =?utf-8?B?aWs4K3g4RFd6OWREOTZyYkg1K05rSHRFZll5REdYbzZaV3dCNTJ4OTNYWEJq?=
 =?utf-8?B?SzhEalg1ckI5eHkxZThYU2NSOW5sa05hdFFvSnovZzRTdHlJc1hmZCs2VDBT?=
 =?utf-8?B?RXBNcXowNUQwTFBkakZDMUJ5VldaS1JwVGZ1Q0h3TXBDUlNEb0pXZXBJaGdR?=
 =?utf-8?B?SytUaEdyNmxGTHJDUStvM0JKQjZZZ1pQTnJGYmRieXJDT2kvUXdETXA3dFdH?=
 =?utf-8?B?dC9yM09zK2JVZWpkTTFFdGo0OXQ0OVBoQ3F6SStEcTlOdlN0NzZIdlNaK0E4?=
 =?utf-8?B?TEpQeWVzSFFEZmFQdWY3bzU5VDZJb25sMnNXYWpFdHlUd0UrYnJIKzNkYkNr?=
 =?utf-8?B?Wmp1OHpyaEdqTmZEWDdLYTVPdDU3Vk9ENXFrQ2VqcnFXVmFXSC9NSWg4NGF4?=
 =?utf-8?B?enE3L2g3cXB3YytwdXBNZDI5T3dJUkZKdTIwSEdwUUVkMHFKd2ZHS2drYklM?=
 =?utf-8?Q?mjv4bgKCdF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70e3e84-9745-4d02-0e15-08da07bbaa2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 02:13:01.9764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1XbQ0nJtuZhY+LeeEzfaSK8EvMtsXME6hd3I0zFBZg3cs2kOIis5E3OWS5HgkiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
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
LS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIE1hcmNoIDE2LCAyMDIyIDEwOjA0IFBNDQo+IFRvOiBaaG91MSwgVGFv
IDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFu
ZywNCj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleQ0KPiA8
U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBDaGFpLCBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkcm0vYW1ka2ZkOiByZWZpbmUNCj4gZXZlbnRf
aW50ZXJydXB0X3BvaXNvbl9jb25zdW1wdGlvbg0KPiANCj4gQW0gMjAyMi0wMy0xNiB1bSAwNToy
NiBzY2hyaWViIFRhbyBaaG91Og0KPiA+IENvbWJpbmUgcmVhZGluZyBhbmQgc2V0dGluZyBwb2lz
b24gZmxhZyBhcyBvbmUgYXRvbWljIG9wZXJhdGlvbiBhbmQNCj4gPiBhZGQgcHJpbnQgbWVzc2Fn
ZSBmb3IgdGhlIGZ1bmN0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFvIFpob3UgPHRh
by56aG91MUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMgfCAxMSArKysrKy0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiBp
bmRleCA3ZWVkYmNkMTQ4MjguLmE5OTI3OThmZjhiNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gQEAgLTkzLDIw
ICs5MywxOSBAQCBlbnVtIFNRX0lOVEVSUlVQVF9FUlJPUl9UWVBFIHsNCj4gPiAgIHN0YXRpYyB2
b2lkIGV2ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb24oc3RydWN0IGtmZF9kZXYgKmRl
diwNCj4gPiAgIAkJCQl1aW50MTZfdCBwYXNpZCwgdWludDE2X3Qgc291cmNlX2lkKQ0KPiA+ICAg
ew0KPiA+IC0JaW50IHJldCA9IC1FSU5WQUw7DQo+ID4gKwlpbnQgb2xkX3BvaXNvbiwgcmV0ID0g
LUVJTlZBTDsNCj4gPiAgIAlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAgPSBrZmRfbG9va3VwX3Byb2Nl
c3NfYnlfcGFzaWQocGFzaWQpOw0KPiA+DQo+ID4gICAJaWYgKCFwKQ0KPiA+ICAgCQlyZXR1cm47
DQo+ID4NCj4gPiAgIAkvKiBhbGwgcXVldWVzIG9mIGEgcHJvY2VzcyB3aWxsIGJlIHVubWFwcGVk
IGluIG9uZSB0aW1lICovDQo+ID4gLQlpZiAoYXRvbWljX3JlYWQoJnAtPnBvaXNvbikpIHsNCj4g
PiAtCQlrZmRfdW5yZWZfcHJvY2VzcyhwKTsNCj4gPiArCW9sZF9wb2lzb24gPSBhdG9taWNfY21w
eGNoZygmcC0+cG9pc29uLCAwLCAxKTsNCj4gPiArCWtmZF91bnJlZl9wcm9jZXNzKHApOw0KPiA+
ICsJaWYgKG9sZF9wb2lzb24pDQo+ID4gICAJCXJldHVybjsNCj4gPiAtCX0NCj4gPg0KPiA+IC0J
YXRvbWljX3NldCgmcC0+cG9pc29uLCAxKTsNCj4gPiAtCWtmZF91bnJlZl9wcm9jZXNzKHApOw0K
PiA+ICsJcHJfd2FybigiUkFTIHBvaXNvbiBjb25zdW1wdGlvbiBoYW5kbGluZ1xuIik7DQo+IA0K
PiBJZiB0aGlzIGxlZnQgb3ZlciBmcm9tIGRlYnVnZ2luZz8gT3IgZGlkIHlvdSBtZWFuIHRvIGFk
ZCBhIHdhcm5pbmcgbWVzc2FnZQ0KPiBoZXJlPyBFaXRoZXIgd2F5LCB0aGUgcGF0Y2ggaXMNCg0K
Qm90aCBhcmUgbXkgaW50ZW50aW9uLCBwb2lzb24gY29uc3VtcHRpb24gd2lsbCBiZSBleGVjdXRl
ZCBxdWlldGx5IGlmIGV2ZXJ5dGhpbmcgZ29lcyB3ZWxsLCB0aGUgbWVzc2FnZSBpcyBoZWxwZnVs
IGZvciBkZWJ1ZyBhbmQgUUEncyB0ZXN0Lg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogRmVsaXggS3Vl
aGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IA0KPiANCj4gPg0KPiA+ICAgCXN3aXRj
aCAoc291cmNlX2lkKSB7DQo+ID4gICAJY2FzZSBTT0MxNV9JTlRTUkNfU1FfSU5URVJSVVBUX01T
RzoNCg==
