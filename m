Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D66C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 20:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B4660F3A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 20:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7B4660F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BA6089CDB;
	Mon,  1 Nov 2021 20:42:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6138089CDB
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 20:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USoIWE7lfzwEHhIFixTnEn0eIbq9/9MNRRyEa/t0JgEfyeLXGtRrvKuyJvimQ+vdVGpHYRW3Pf8bmACbKg4IYhts1oZxl8JaL3ED9LwdK0VJ+Swf5GJmau3mwNjQS7gQlXq9fMNvOQkYL2FlzokjeCwZaOAqA9HA/JpvLyeyUYNIIyAauB4qbSo3eOZBMHmvZZhU/i/wtc3b1jbJ6by44xCxHbr59sqMeJPPmA8FRwoSEN/5E/rhlxF082u37HDSYaSB7QhcbG04RZpWF7bF/tR1rUsazXD5oFekLI331n1SWGyc5PhIL+zq1+vbDw/orw26G3Bayw2b3PL32J9Kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHzw0xYjxKTKR13mhOzSiYy5TRFcPwzfyIuzvyk3mh4=;
 b=l+b0fqBAIbb8SJlB02rSLEc4O5Gy/4q7Lzt8s2JgwdgyQAGN2HUz1H7E9vCqZn8J7fOQjOwcrtqvKDx9XgOWPIw3n2EMCBdprCFu7QG//wR0hZgg6O7GaG7ZekjPT5l1NPXX1ikOfBiEWmItAeXD9DdSg/oRE8Rn+MBhtMhQ0ghBGT4MtkCydjoIAWlPlXc332agIUCzJWyEbF5Hmz8miE0eAPZwsk4aCtvLEsJgBwufFGp9GAUcppqaHKFnlS2skHBGqAfLs3eAQoZJfAA28fApQjV9JCUY7uFhSQKVQQE4eC7UgnXR3sQzKWeelTjqOc55NYE8YQBMVHx/8EHlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHzw0xYjxKTKR13mhOzSiYy5TRFcPwzfyIuzvyk3mh4=;
 b=sWjYgOQ1XQbkappi19V99rjE4+La8lSLiFCHib7HPTxDQ00/2yMIHIFhk0S/ukbzY02D13sdOXMlaRjUQFq1ue7wwwmegCUMJwuKBtc4t6tQVxLU6ukGE/lXcAAhf9A5kB3H1+aEp7caopp2EPi4cKQOGxWC2cJ8QRVqRBPWHTM=
Received: from SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 20:42:42 +0000
Received: from SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2]) by SA0PR12MB4399.namprd12.prod.outlook.com
 ([fe80::91ba:8d66:bd75:2ac2%7]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 20:42:42 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Russell, Kent"
 <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Make sure to reserve BOs before adding or
 removing
Thread-Topic: [PATCH] drm/amdgpu: Make sure to reserve BOs before adding or
 removing
Thread-Index: AQHXz10YwubPuRH900GqcLXs2bO0VqvvHFiAgAAGx5A=
Date: Mon, 1 Nov 2021 20:42:42 +0000
Message-ID: <SA0PR12MB43998918B431C47777886AEAE38A9@SA0PR12MB4399.namprd12.prod.outlook.com>
References: <20211101201421.1689492-1-kent.russell@amd.com>
 <b3975b84-6dbb-bdac-2e3f-63f868754b02@amd.com>
In-Reply-To: <b3975b84-6dbb-bdac-2e3f-63f868754b02@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25202d7b-42b2-4d70-5cd6-08d99d782716
x-ms-traffictypediagnostic: SA0PR12MB4398:
x-microsoft-antispam-prvs: <SA0PR12MB4398A7614F621A218CABF2B2E38A9@SA0PR12MB4398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X4ASfd8hF88+q8hwOSkflncge8VKdDOKYwbSKLQqQUZFsmK8QHgxfmYcU79Rq1RV0ZW9w1ngFsfEHGcsrLQZ3dkDJGRnpKE7vQ5luHefGU1RHR9PDSqWs/3B+6CrVXDnX89fwIXCRgDWx0CS6iGPFlf9TzNrXi1+LB7QcC4SqOjQ9kxLW9Zy1xKSgNej8yhAHN5WfX8/gSyPuQJdzjmu5Lu0QDL3mINNc0GE8o3q6pEDX3WgW5V1VqNj95VJnCSfKF0gWv9jUgVImY74p+fIOQnvUX3Z7wYocexT1x3d4J13HEwN2I/cYOCDyoFhaQtNzQOnhD/C979pgfkY1HTs7VfwQmmCWekt3cEfum3hpH3OZNvEaB1yuLybgxZkFub+2rGaq0zxOiPOQNa/tj2kUheke054Vp5NXcYJYmC4r2rpMe29vt3FCO5d2casRx2gyxUXUubZVws5H60HajMc55MUU5kZuvARbATGDI0yf7+3etjeKeoIw81zT00Dobk5gLq8mErA9CSBiZHxXy9AHZF29M5kDd+DHSzVc0p9uhazpUXJiD0papZXoiEB5zNtrdEEsp3+c2KUeWrVIOSZTSunXQsNXloauVm1VjJykULJ5l1akxh+e/SUHq6TZ5928+aNfhng5Ur1fwN3ssOifkdftYt++MARfx+iw9BjJJt46a+GQklzEKfvvS9syNCg/4NpPjDSD9J+8OkW3dS4YQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(186003)(71200400001)(52536014)(86362001)(83380400001)(66946007)(66446008)(64756008)(66476007)(66556008)(76116006)(8936002)(110136005)(33656002)(8676002)(9686003)(55016002)(38070700005)(2906002)(38100700002)(508600001)(26005)(6506007)(53546011)(7696005)(122000001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0ZrUVBuZ2dxejJsUllibnRkVHFuR1R2NXJKWnM4RkJwdWMzaWJkdE9scUpp?=
 =?utf-8?B?SzFvUGR5T2w1cFV2MitibFBwRmpZU1ZhWmxaVE1ROWYzaHNpSDloVUVkM3NJ?=
 =?utf-8?B?endyYmxIQmFraElrZ0xoSVo2anpIU0RiaEZmN2VEZ3JlV1BBYjk3bmgvcExN?=
 =?utf-8?B?NWVOcUdpNzE5SnFXUHhKaGttSForQU1uTU1odGRhNSs2M21BRkg4WndleWVa?=
 =?utf-8?B?RHY3djk5ZU8wNkVuWGxCSlFLd3Z5WnFpbkh1NFBxdjNRMEllb3h3dTQreTVH?=
 =?utf-8?B?NWVWcVBRM2xURTRDY2owN0xOQlhLZW4vK3hIaUdzdnBaOHdLdFB2NTNvWlFO?=
 =?utf-8?B?UUp3QTh1ejIvcHZESjE4a0ZWcnRRTFovdHVmdUhaOUtSZkNFVWlteFRDbHg0?=
 =?utf-8?B?YUw0a09oK1F5bFZQVFhaR1p5bXJEY08wdld5anZZVGJ5d2J0Sm5nVTFtMFpZ?=
 =?utf-8?B?SmszVmk5WFp2c1NYSHMwWkNOY1pBVW1sc0JjS0hMaUZuMi91SFJvNS9iU1li?=
 =?utf-8?B?aEhjT2ZCcTFXUlFoYmk1THIrZkFYSFhYMlJRcUI1MzV5N040Q3lkOFJwZG9M?=
 =?utf-8?B?LzFTQ0l1RzhXc0xWU0hGdjBEUzVvR0VYRklzTjhPcTMyODREeEsxakpMdDBu?=
 =?utf-8?B?SHB5ZXQ0MkVKWDVQUDhTMmFieklDVlB4R0pvN1lvdTFwbWgvTGlEUFloZWEy?=
 =?utf-8?B?TkpIU2VmTDZ3bUtLT1N3T2pKU2l6WW9XOFY5L3ZUK2dMQjh3aEVZdEZhYmxi?=
 =?utf-8?B?Qk5iT0dOb2doODVlQmJ4b0M5R04yOHdZU0xUc3U5TVkxWU44TlQ2NE8rS0Y0?=
 =?utf-8?B?QlFkOGtXcCs0QTNIY3JETlQzZjV1NUpHZXFGd1AwRlFaWUwxay9xekFuQWN4?=
 =?utf-8?B?RjU4aGo3clVYWE02YXZNVXBuTHUyMFNFRHhlNDBoMVZOZWZPWE1USHpKMFdx?=
 =?utf-8?B?c3RJNXE3K3RCbjFOS3UvNndPbmphdDdsY3RONzhzNVB6RHpIZXRKa0tqbm9H?=
 =?utf-8?B?L3hqOUdaVmt0VjI5NmYrOE9RLytZUXdQamFJMzNBb3hpL09kMFNCMjg4TkxD?=
 =?utf-8?B?c2JqOU96WitlMDljKzAzNlZaaS9LWWpEOEs4M1RFbWJWSzhWelhoSHJIdkoy?=
 =?utf-8?B?NUxEelcrZ3BJZ3pGZDViVmYyRXNDSFd0NC93alg5ejI5NWpBaXdsaE1WM0Uv?=
 =?utf-8?B?YXJPVEtTdFJCWW5HLzFvZkZzSnZyTmpVQ1luVUpENWVGcnpCc2xjdGFtSnFQ?=
 =?utf-8?B?L1JIcytRckJwd1RiY05PMmZlNDZyTk9wRGhmS2NJSHZ4UDVacWxnUUpOb0N0?=
 =?utf-8?B?MXJ5bERaSExndHhKaTZ3RU5Xa25zMCs1c3QvaXlIMVUzWk5POXorZmhIN29B?=
 =?utf-8?B?VUtTaHVZajVpcElVTzFLYm1pWDFTNURhOC9IMndyN0VTc292L0c1dmx1QTZu?=
 =?utf-8?B?TTJuSlprckk3ODh3cVc1WVMyZmhzdkNyalR5LzUxaWxHM21KTE81YmtLQjIx?=
 =?utf-8?B?ZzZCV041UHZJSS8wQjA0dnF1YVoxc0s1REFISEE1ekV3aFVMaDJiT0hqSmdy?=
 =?utf-8?B?Y09TNy95UEp0c01qYlkvWlJzeGEydzd0V0owN0tFNXRFQ3Z5YUQrSkhkMzZC?=
 =?utf-8?B?VHVORWE2aVM4UktLK0ZqSmdScXJRVVd4TE5Mb2I0RkFseXEvSkkwcnlFZWRH?=
 =?utf-8?B?bDg0YXN1enUycTdwdSt1ZFBFYVF4V0o3ZkF5NjZiTXZ2Sms5TCs2dkxSdTB1?=
 =?utf-8?B?NWVLZFNkcS9vc1J1cjlTWGFKSUJmZjlOdWJ4ODlqb3g1UWY1Vng2U3A3ZWdq?=
 =?utf-8?B?RFdZMy9zTmtYaVVjdEpZRkZWaEd0cHZTdWVGU1haTkpCekw4cjh4NDZ3YVM1?=
 =?utf-8?B?Skcza1hudnBEczg0TEE1QktuaGdVVFpUc0xveHlGTGJHZVU0RGhIWStyV2dW?=
 =?utf-8?B?djNBdmpZUHFIL2ZzQzQzUStRRTRBVkprTDJmQjhJelpmdGhoZUR2VG8weVl2?=
 =?utf-8?B?WG82M0VqSnl2dE81bG5wUXI4Q0lkSmtaeWxDbG5maWJLdURoWUtUM2JxWjh4?=
 =?utf-8?B?eWw0ODVHQ2V4dlM5TVRRZktjZG96aEhYZXFLeUhyb1h6MjlzVThobE1zNW5I?=
 =?utf-8?B?TlVLNTI0VjZZNTdXUjIrREF1SlNJMXJUSHBGb0VneGVabHpEeVJxeGxJZTlJ?=
 =?utf-8?Q?Pe2LFhKyW63+wRBZiNIYdiE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25202d7b-42b2-4d70-5cd6-08d99d782716
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2021 20:42:42.5784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWrR+CZCkWgJ6CWpg+SW9B6UdMa030bO5BEVGYkIKk3jnXs4idyHv4RGQOuF7wtZkBMqJkDqRfi+WwKD4b+2SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

S2VudCwgdGhlIGNhbGwgdG8gbWFwIGhhcyB0aGUgc2FtZSBzdHJ1Y3R1cmUuIElzIGl0IG5vdCBw
b3NzaWJsZSB0byBjYWxsIGtmZF9tZW1fYXR0YWNoIGFmdGVyIEJPJ3MgYXJlIHJlc2VydmVkPw0K
DQpSZWdhcmRzLA0KUmFtZXNoDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBh
bWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYg
T2YgRmVsaXggS3VlaGxpbmcNClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMSwgMjAyMSAzOjE4IFBN
DQpUbzogUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogTWFrZSBz
dXJlIHRvIHJlc2VydmUgQk9zIGJlZm9yZSBhZGRpbmcgb3IgcmVtb3ZpbmcNCg0KW0NBVVRJT046
IEV4dGVybmFsIEVtYWlsXQ0KDQpBbSAyMDIxLTExLTAxIHVtIDQ6MTQgcC5tLiBzY2hyaWViIEtl
bnQgUnVzc2VsbDoNCj4gQk9zIG5lZWQgdG8gYmUgcmVzZXJ2ZWQgYmVmb3JlIHRoZXkgYXJlIGFk
ZGVkIG9yIHJlbW92ZWQsIHNvIGVuc3VyZSANCj4gdGhhdCB0aGV5IGFyZSByZXNlcnZlZCBkdXJp
bmcga2ZkX21lbV9hdHRhY2ggYW5kIGtmZF9tZW1fZGV0YWNoDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBGZWxp
eCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgMTMgKysrKysrKysr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2dwdXZtLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jDQo+IGluZGV4IDYxNzg0YmJmZDdmZC4uOGQzMGNjZDcwODAwIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+
IEBAIC03OTgsMTQgKzc5OCwxOSBAQCBzdGF0aWMgaW50IGtmZF9tZW1fYXR0YWNoKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qga2dkX21lbSAqbWVtLA0KPiAgICAgICAgICAgICAg
IH0NCj4NCj4gICAgICAgICAgICAgICAvKiBBZGQgQk8gdG8gVk0gaW50ZXJuYWwgZGF0YSBzdHJ1
Y3R1cmVzICovDQo+ICsgICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X2JvX3Jlc2VydmUoYm9baV0s
IGZhbHNlKTsNCj4gKyAgICAgICAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICBwcl9kZWJ1ZygiVW5hYmxlIHRvIHJlc2VydmUgQk8gZHVyaW5nIG1lbW9yeSBhdHRhY2gi
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW53aW5kOw0KPiArICAgICAgICAgICAg
IH0NCj4gICAgICAgICAgICAgICBhdHRhY2htZW50W2ldLT5ib192YSA9IGFtZGdwdV92bV9ib19h
ZGQoYWRldiwgdm0sIA0KPiBib1tpXSk7DQo+ICsgICAgICAgICAgICAgYW1kZ3B1X2JvX3VucmVz
ZXJ2ZShib1tpXSk7DQo+ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFhdHRhY2htZW50W2ld
LT5ib192YSkpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FTk9NRU07DQo+ICAg
ICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIkZhaWxlZCB0byBhZGQgQk8gb2JqZWN0IHRvIFZN
LiByZXQgPT0gJWRcbiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4g
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW53aW5kOw0KPiAgICAgICAgICAgICAgIH0NCj4g
LQ0KPiAgICAgICAgICAgICAgIGF0dGFjaG1lbnRbaV0tPnZhID0gdmE7DQo+ICAgICAgICAgICAg
ICAgYXR0YWNobWVudFtpXS0+cHRlX2ZsYWdzID0gZ2V0X3B0ZV9mbGFncyhhZGV2LCBtZW0pOw0K
PiAgICAgICAgICAgICAgIGF0dGFjaG1lbnRbaV0tPmFkZXYgPSBhZGV2OyBAQCAtODIxLDcgKzgy
Niw5IEBAIHN0YXRpYyANCj4gaW50IGtmZF9tZW1fYXR0YWNoKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3Qga2dkX21lbSAqbWVtLA0KPiAgICAgICAgICAgICAgIGlmICghYXR0YWNo
bWVudFtpXSkNCj4gICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAg
ICAgIGlmIChhdHRhY2htZW50W2ldLT5ib192YSkgew0KPiArICAgICAgICAgICAgICAgICAgICAg
YW1kZ3B1X2JvX3Jlc2VydmUoYm9baV0sIHRydWUpOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
YW1kZ3B1X3ZtX2JvX3JtdihhZGV2LCBhdHRhY2htZW50W2ldLT5ib192YSk7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGJvW2ldKTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgIGxpc3RfZGVsKCZhdHRhY2htZW50W2ldLT5saXN0KTsNCj4gICAgICAgICAgICAg
ICB9DQo+ICAgICAgICAgICAgICAgaWYgKGJvW2ldKQ0KPiBAQCAtMTcwMCwxMiArMTcwNywxMiBA
QCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUoDQo+ICAgICAgIHBy
X2RlYnVnKCJSZWxlYXNlIFZBIDB4JWxseCAtIDB4JWxseFxuIiwgbWVtLT52YSwNCj4gICAgICAg
ICAgICAgICBtZW0tPnZhICsgYm9fc2l6ZSAqICgxICsgbWVtLT5hcWxfcXVldWUpKTsNCj4NCj4g
LSAgICAgcmV0ID0gdW5yZXNlcnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4g
LQ0KPiAgICAgICAvKiBSZW1vdmUgZnJvbSBWTSBpbnRlcm5hbCBkYXRhIHN0cnVjdHVyZXMgKi8N
Cj4gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGVudHJ5LCB0bXAsICZtZW0tPmF0dGFj
aG1lbnRzLCBsaXN0KQ0KPiAgICAgICAgICAgICAgIGtmZF9tZW1fZGV0YWNoKGVudHJ5KTsNCj4N
Cj4gKyAgICAgcmV0ID0gdW5yZXNlcnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsN
Cj4gKw0KPiAgICAgICAvKiBGcmVlIHRoZSBzeW5jIG9iamVjdCAqLw0KPiAgICAgICBhbWRncHVf
c3luY19mcmVlKCZtZW0tPnN5bmMpOw0KPg0K
