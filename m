Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3D4C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C024C10EA89;
	Thu, 23 Mar 2023 13:48:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF0310EA89
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlVY+HT91TZz9pOaV0zGYVXiELyYFOWm9p1R13xTzcKllDT5TL8ebbVRDJuHpKttaAjjvGrXNUw1atyl+xaRcQA6R7OweINM16ISBV6A8iF+Lg5G1mVoFUhIn7ER9bUH4cRVlEUWAFjfl7fLBdZ8L1RJRKXpX2Xf9+zpTH1gf47lJoEH3lVUFiHhgNnPbRl7Ys4HNJi8t7+aXPik4ZY6KMdbaw5nqbrUw3Pk0XSYo2/468P4zklAnPXBe98dH8N2AIO3MMZMAHTWvNLOpxebYh29qvH4pH+0fOT8NNjv4oGhZi9Mk+16Q5gNMoJ7DFq6DVno5P3PujugCFRXrbA6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCGOoTcZ/i2M0LII0njqOQOsM/WJSzsVJIwZLowtEc8=;
 b=RjlukJh58d2d2yzfKus0STs7Qk48VgPeaLZzL9MCbYJ7mt4xtGB1hwuoIx/nhTSdyjgK2ZNm7PWRmXoEZUW0sXlyGUSTRoiQtMifBeDNCBLDZCqzR+9wQQNRRiClQQud1L5P2RbSMWqj0QO2UHjn6kwNB53m+Kyxe1ea4BSa5htqQVzlhATqs9qrr+xZqb86PNayncXB0MQHgPJwppAgJNDpWrlFroatpnriC8VbCzzrmXbf9x5bGw/YqZqwUcFrx7iAUz/OWcR+mjweoGoPlOr/wEcxgTK/tY/N+JLrVQCjMOYQ4Btl8xuAa+F8TZCxmtW6d/cd8LCg7NOJhBnggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCGOoTcZ/i2M0LII0njqOQOsM/WJSzsVJIwZLowtEc8=;
 b=TpkN8/jZGRhtcxui/Oa8qvgmuOOix4sD8TS8yvLOZgYoyky4tt2sjzNVuO6ZnCG1/NypgHg2n5ZfcY9Ml2ABOeYC3m2ho6Wnq2J1BUxdTBa9WIYW5jjMOv+PAUYnR7Bl/B9veSuwpRTi159qt2TXdbJTO0Gp1gxbQO0t5jPfpIk=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 13:48:55 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:48:55 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXX+20w+FZISrM02v7ekDk7+DS68IW/oAgAAFS6A=
Date: Thu, 23 Mar 2023 13:48:55 +0000
Message-ID: <MN2PR12MB41285690BF351A0A141D852790879@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230323120426.3960144-1-srinivasan.shanmugam@amd.com>
 <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
In-Reply-To: <98edaa70-bba0-77c9-1ece-64700a3562b6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T13:48:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77d318f3-fecd-4df0-ab24-819aef0deead;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SA1PR12MB8742:EE_
x-ms-office365-filtering-correlation-id: 40a1c2d9-0752-46df-175c-08db2ba55848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAaWRDb2YQ41UIHPoVogUdl6j397K9omxqYVegZIgDpL6ymErUqk0d46i3WtjuudDWjy2IR1r/bQJnjKqRjLdnrDGUfAhSq8a5eGSQU9HURpwH02Yq+59CTVt3EbqgrixH0+s8bIPnIvdezxYcarlLjs1UWrSyFEqN4HpUEByjhk1+UNKvHpufwfGw22YGriDLIarq5iUyyNOykLYcIFma9qpAVY/vZexRK5yQEtzeaE5nTZ7jOLRy9YwDC1p87N1tvVhXcVRKiLyod8kdYhH0gaz8MUj/BWyzHx1K0K6pqFy5n9rMLl9es5kK86NzL1jGgp9LkjSa27ZnkwPcv1UMCE2u8AqISaAamVGfxZ9XRUUNDzMk8Na5J6+N53iD1xgFIdRXG9+zmPFNtXxFlIdfXKmNBHGwBP0geWhdrmR5XjEkmi9dGwVz1ggZ6VTR7TgWrA3iAYBalsoJkW3qGvz1kfomVFNdynRs+QzSmXaPQSnagUl6dlTjUbBmS89qPht2AU5XdZcyXgtBpyML3ApPxWMdSReovA9+NM0w+o4aIQPXkNRaO9WpLqduUxXYbrAK1Q11jCgp/XSle7c/Y67pQ9By/kVEAFe0JLsfebxXB4LmSmzP9y4ZmixVBSd/7qHd8flPqyxso2rWe77z0G9/IGzxewHSYy9U1SpFYmDRP4fLvua4soRkV0HnPEhjwWqxgaX/gNJXuOb7pxHfXk1LIoXx3H3A94HpOe4/MqNx8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(41300700001)(66446008)(52536014)(5660300002)(8676002)(4326008)(66476007)(2906002)(38070700005)(64756008)(921005)(33656002)(86362001)(38100700002)(122000001)(71200400001)(7696005)(26005)(76116006)(110136005)(478600001)(6636002)(316002)(8936002)(66556008)(55016003)(6506007)(66574015)(83380400001)(66946007)(53546011)(186003)(9686003)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmVCM2YxMmdiYlJ1MnVpUFpjU1IvUVhROFF0RnIxTlVPbTIvOElWcU5zcUZl?=
 =?utf-8?B?Y3N3U0k5VmtucFhJeVM2dzdkc0JZTUxxT3JQOGoxOEh3SWFPTXpWS01Kd0p5?=
 =?utf-8?B?SWhWTG1ocnFDMzhaQVhmcWFNUGVodnpxYVVSMFA5MUJ1MjJ4ZUxBVkNsdFpv?=
 =?utf-8?B?SUQ5dm1ad2UxU2l5dWFnQktIaWxMUEx1MWVhVUZBRnQrbVNLL3dwWFRoeG9x?=
 =?utf-8?B?WGNkRG9FVlo5UUFXdm1tdFJWVFVvek90dWExbXozZ21TU0lLN05QS2Vwd0x2?=
 =?utf-8?B?TnMvMCtyWmpHOUZxazJ6alFYemJjcFB1aHlMWDdLN214eTAyejZKN2drNCsz?=
 =?utf-8?B?K2JFd2Rra0V2Y2tNWGFFOVhGU1I1bFJaLzRrZXFEd3FmUkg5MkJTa0JLN3dV?=
 =?utf-8?B?M0U0ZjFLNFNEMWNtZzNNRGlhVm14YXBiZDN0MC9xaHNYVXZ6RjFYM1pzcWly?=
 =?utf-8?B?TUo4aXYyMjB6dDN6TEFSaDdTbTlDalZ2NzIyei8rYStqMVlxNWVFV3RlV01y?=
 =?utf-8?B?dTdldUVrSmZOTk5hNm5iUDZLZVZOeHNidTczY3RNS05rV3VnLzZ1ME80VDVQ?=
 =?utf-8?B?RXdCZkszOTZDclVVMk5vTjZ1Q0JLdUJBYm1XR1NrdnJRRXBrRGtoTjBycEV0?=
 =?utf-8?B?anRjOXozSkdqM1pzQnlhSVczckwyU1UydTBDTGIwUFBMVlNtdXJBYXord3RG?=
 =?utf-8?B?QzNGWEJpVVBTbkxWcWZyUVJqdVlRNkI0S2RnZURJV1gvMmVvNE5aa3ZGTzNa?=
 =?utf-8?B?N1puRms1YWVCdjJsNU5oWHhBc3RPUnliVzBYLzF1WUM3ZDhneWN0YjB4Ly9m?=
 =?utf-8?B?bDdLOGp6OFRYa3R0VzhtZHFxLzF6aE1JN3NSZjFlc3ZiTlBYcG9BenQveGJv?=
 =?utf-8?B?R1IranJVZGxBbFJPSnNiakhvS3BCM1M1ZWw3d2dUM2dzbVNTYUNaSUVOL2FX?=
 =?utf-8?B?bjhLUjQ5L2NCanlGUHZnQjRtdXFGeVJTc1hiZEcyeGN5MHMvUms2a2poRWJm?=
 =?utf-8?B?eDY2NUFCMXFoeFNhTmUySFZHSW03RU54WnE4ODQzM0hVUjZpLzdhTTIwQkZq?=
 =?utf-8?B?SGQ0SEdaMFhFbzRtYnFzUUVXMGhGenkweGJGeTZxK3ZBZWZtYklXZGM3d2hI?=
 =?utf-8?B?cUU1RTVhSkhRdjNXWkxDanV2WEdvSFdodC85ZjVQMDV5SXVxanFxRHQwTCtX?=
 =?utf-8?B?VWNtK3RSanFSZTlBM1Q5bG8xdk1XTHo0dXE2bzZ4bG41bXNMK214WTRuc3BW?=
 =?utf-8?B?U2c2WHJGTzNlZFd4MXU0Nm4veTkyNUc2S2Zka2t0bVBXbzVUQWtvT1hJZDBq?=
 =?utf-8?B?bmNmaHlXdUNwaXdoNC9ja0ZBemdDUk56amprK0t6KzIySHlicWtqTStydTZZ?=
 =?utf-8?B?R29ncVJ2RlYwQi8xRnVwVzgvSXlTcXJsRWFqdk5zZjhZMlNSbk1wWGY2d1A3?=
 =?utf-8?B?ZFJicUFWRHdBUngrZlhPOVBIV0szWUNkeGUwUFo1SUIvUDhvdFhQMzhYdHlk?=
 =?utf-8?B?bU42SkFBUlNwUlQxS3Z6ZHVkM2VGeGRYbFRJRXp5N04wVFhxSkxacUJ3MjVs?=
 =?utf-8?B?L3FhMXlGZldCa2xCUUJaZmNNQTc0TGhIR25meUJ1eWZrNTNxcE5rTThYaCtk?=
 =?utf-8?B?aGZVbkxqQmltWVBVYzhFYmhnc0NMakU2ZTJ3R1RmeCtEaGpCSmtValFxSTlp?=
 =?utf-8?B?dzBCUXlnQnNzTlNXamhxdVhhZElaU0hhR0wvQjZka1Nzd2htdVdTYTdFd29k?=
 =?utf-8?B?Qm9sQ3grTXo3eXVZTWJIdHN5SmsxeXlLeXVkNzFrbzFCTm5DcWFETDR3eUpB?=
 =?utf-8?B?UnVsczdrc01XTzNyeCtXZW4vQkJvdDNJZHBPeVhoTlR4ZVJXRit3dEpGWXFJ?=
 =?utf-8?B?RUw0djYyc1M0dGwwMG14eHduTWNzeWZMQld1Z0J5RStUajVBamplYUNVODRj?=
 =?utf-8?B?akxmSVdqZnkxQk8zemJmSnlZR3ErMEcyTmZNTFBLcnRKcjdXcERmanRPc2VX?=
 =?utf-8?B?b1U0L3BHWkxCMzEvZDFuelVWMk05UjZ2RHdjTy9KblpxcXFkVEdlbkswekxY?=
 =?utf-8?B?d2lqMHlyS0R2ZWthemV4UktxOUJrTTJ3OFh6SGlMNkY2K0E0MTVPeFkwTGFE?=
 =?utf-8?Q?8Qz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a1c2d9-0752-46df-175c-08db2ba55848
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 13:48:55.3150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHrQ9//46RvkeJolMYFIxNvXycVk/UBEu6lbw9XE3a6Rx2mN2aIrgMhW4R2U7XiPdCvkI7qCe162eU0uPilh9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBhIGxvdCBDaHJpc3Rp
YW4hLCBtdWNoIGFwcHJlY2lhdGUgZm9yIHlvdXIgaGVscCENCg0KQmVzdCBSZWdhcmRzLA0KU3Jp
bmkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXksIE1hcmNoIDIzLCAy
MDIzIDY6NTkgUE0NClRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1V
R0FNQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBaaGFu
ZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgVHVpa292LCBMdWJlbiA8THViZW4u
VHVpa292QGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBGaXggbG9naWMgYnVnIGluIGZhdGFsIGVy
cm9yIGhhbmRsaW5nDQoNCkFtIDIzLjAzLjIzIHVtIDEzOjA0IHNjaHJpZWIgU3Jpbml2YXNhbiBT
aGFubXVnYW06DQo+IENDICAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5vDQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYzoyNTY3OjI4OiBl
cnJvcjogYml0d2lzZSBvciB3aXRoIG5vbi16ZXJvIHZhbHVlIGFsd2F5cyBldmFsdWF0ZXMgdG8g
dHJ1ZSBbLVdlcnJvciwtV3RhdXRvbG9naWNhbC1iaXR3aXNlLWNvbXBhcmVdDQo+ICAgICAgICAg
ICAgICAgIGlmIChhZGV2LT5yYXNfaHdfZW5hYmxlZCB8IEFNREdQVV9SQVNfQkxPQ0tfX0RGKQ0K
PiAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+Xn5+fn5+fn5+fn5+fn5+
fn5+fn5+fg0KPg0KPiBQcmVzdW1hYmx5IHRoZSBhdXRob3IgaW50ZW5kZWQgdG8gdGVzdCBpZiBB
TURHUFVfUkFTX0JMT0NLX19ERiBiaXQgd2FzIA0KPiBzZXQgaWYgcmFzIGlzIGVuYWJsZWQsIHNv
IHRoYXQncyB3aGF0IEknbSBjaGFuZ2luZyB0aGUgY29kZSB0by4gDQo+IEhvcGVmdWxseSB0byBk
byB0aGUgcmlnaHQgdGhpbmcuDQoNClRoYXQgbG9va3MgbGlrZSBhIG5pY2UgY2F0Y2ggdG8gbWUs
IGJ1dCBJIGRvbid0IHJlYWxseSBrbm93IHRoZSByYXMgY29kZSB0aGF0IHdlbGwuDQoNCkhhd2tp
bmcsIEx1YmVuIG9yIHdob2V2ZXIgaXMgbW9yZSBmYW1pbGlhciB3aXRoIHRoYXQgc2hvdWxkIHBy
b2JhYmx5IGNvbW1lbnQgYXMgd2VsbC4NCg0KQ2hyaXN0aWFuLg0KDQo+DQo+IENjOiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IENjOiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFy
aW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFu
bXVnYW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gaW5kZXggNWIxNzc5MDIxODgxMS4uZmFjNDVmOTgx
NDVkOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jh
cy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiBA
QCAtMjU2NCw3ICsyNTY0LDcgQEAgaW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikNCj4gICAJCQlhZGV2LT5uYmlvLnJhcyA9ICZuYmlvX3Y3XzRfcmFzOw0KPiAg
IAkJYnJlYWs7DQo+ICAgCWNhc2UgSVBfVkVSU0lPTig0LCAzLCAwKToNCj4gLQkJaWYgKGFkZXYt
PnJhc19od19lbmFibGVkIHwgQU1ER1BVX1JBU19CTE9DS19fREYpDQo+ICsJCWlmIChhZGV2LT5y
YXNfaHdfZW5hYmxlZCAmIEFNREdQVV9SQVNfQkxPQ0tfX0RGKQ0KPiAgIAkJCS8qIHVubGlrZSBv
dGhlciBnZW5lcmF0aW9uIG9mIG5iaW8gcmFzLA0KPiAgIAkJCSAqIG5iaW8gdjRfMyBvbmx5IHN1
cHBvcnQgZmF0YWwgZXJyb3IgaW50ZXJydXB0DQo+ICAgCQkJICogdG8gaW5mb3JtIHNvZnR3YXJl
IHRoYXQgREYgaXMgZnJlZXplZCBkdWUgdG8NCg==
