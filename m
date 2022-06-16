Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C88C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 10:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28BDA10E52D;
	Thu, 16 Jun 2022 10:20:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69E110E52D
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 10:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCjI6M3bfi/rZKcZgWofZfDcU7qmnb0xYThxeP3Qu3ouvT+q0STYwUMCxtk9m2uC2vUKUe2biYszUsmHcBFV81FQmGjynURP7U5rA9T3kaXL8aTgH7pM+sqp3Q2DExH6pb6kfu7cEAegrc2wEirjJBybP02TsCykvPdARDl+8DEv52gj+RR1ib6jtt3puvU1ESjkvogzwvTw+/Gg1L3NO0IZ3y/Zlf+zWovHq+B4/kexZrvHxY4CYJDHUo+1M0YwEIOnYZpntAD25p78eSy+uLkU9+21YqJz5t3Emd+6ufW8IG+QJOBipzJ/+pdDnGGhgsFDsftT8NAN6wD0mJxMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzTAjBootCNdZu9WdvWKul12te7wzW/X2M7i0f9Us1s=;
 b=gybadcSUDMa0k4zl9iQjsdxrkobmjeLC8qHxdDNys1h1EQdWPRKpg+ZV5mK2BlZ530tOl4CJPtxVhv+mpuVWXWSglXxJPXfqEi8VlmeKB8RLhvAK8Nx2etCOzS0ZKA/cq5hbHckzHmzZxhN09Jiv6/UK2oKXuVaJwwsyt4SmUUYhZ19LiRZomP92Y42DZityhu0hoRSnUHNmtPrm78cyHiQEvYB4r22gq65fnuO2NwQCfrtz9Gwu6vIVBD0wArMKmtkTQlMgZvpiySyK0rUXnQ5MNZACpLXtmq2RHyaPZRP5dreFt++2yW3LhEew1knwWsDpRnuvSAynn/DUmUinDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzTAjBootCNdZu9WdvWKul12te7wzW/X2M7i0f9Us1s=;
 b=SxegAJtaFinyZSo1rbiU0hIxA4kdYKcAfVgDfPwqA5EEaeEY1KpIFNBH3TK2++gORGI00GQgpWe0heKyPWMz9sScVUN0JlY85XjzOOz2x/bbJx5KFi39POv0W/BiBlWK/raG7TCH3BAM6P3FTUKD9lewo921MFjJs81W0yvEFNA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MWHPR1201MB2478.namprd12.prod.outlook.com (2603:10b6:300:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 16 Jun
 2022 10:20:55 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::549d:6717:5787:f21a]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::549d:6717:5787:f21a%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 10:20:55 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct
Thread-Topic: [PATCH Review 1/1] drm/amdgpu/pm: adjust EccInfo_t struct
Thread-Index: AQHYgTBYF4SMFbd1WE2EPGRUXu8aUq1RZW0ggAAHJ4CAAGZ3UA==
Date: Thu, 16 Jun 2022 10:20:55 +0000
Message-ID: <BN9PR12MB52570859A1663E1FC096A89FFCAC9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220616032222.9207-1-Stanley.Yang@amd.com>
 <BN9PR12MB5257AE3268E3C404A62FD923FCAC9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BL1PR12MB53346272EF2F476F7F936FF39AAC9@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53346272EF2F476F7F936FF39AAC9@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8ebd7c7-4daa-4058-a6b0-a30c486c8183;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-16T03:48:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9564de13-c0cf-43ac-f4cc-08da4f81e5c8
x-ms-traffictypediagnostic: MWHPR1201MB2478:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB2478C602897509B70CBC6C0EFCAC9@MWHPR1201MB2478.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wrlmPuyABXl5uRRBxmYF6saREKqlNFnb7YPq83YqzKe1h/pjJbskMT8nI2JGcOh/F+E1iL4EJIoRVdY/toKkFXaYN/NiowaKPt0PsXF0rUMkSPWZfVtziUQgusj4vLAVwcyQarXsAGg+J4KGSNiZO3iFAfXcTXkaM9FCId1iTRL8nGZyx0q4Wm5HSDStbq5Rfy9x//ZW7ZRPn6+T67gCGnYKKsIp15bbk63DjX5D0dqsqi3/lw/bicfl1sfQSxK8FSOjUtKzfygOktza+QZE0RYFpuXY33ckrUekwQ9JHUjAv+p+9JiV6Wuk056ku4iNXFmSy6nST0cbieDK3QsA8376CHdjZs0ES3GbK37XQRU/9h8Goej7keL+S23D32kGwlYDV7zgN/NaS0kZ/aRDo8ehnz7u5ify/i8ZxutMOd/BiBQrtvXF0atJoASKfuDQUzLSpWO8hBw7nqneYrCqooEcyyNIMpguHuGXpQQKD+VT9Bc32UCgqanDRPsIs2jTV/ZtQwp2qHSKQLcT45Q4zpzMwETCVq/UdWNBBZuT/KXhQdfSOZzJLKFwVl1eqOaqT0HVdoSggbGZk3Pac0+p7f2rMOiGgEAhF9FMOEotN/6HBMoPaFHtHxHGOCmPUcrPM5j3iL0Xb85vIC+pfdYgjyu3LlfPSjdvLNui1zoLBcUt4Lg/Hhy335Zi4XRG5Daz3T9wNdx7ynIdfShDglepTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(64756008)(38070700005)(9686003)(71200400001)(316002)(26005)(186003)(66476007)(83380400001)(66556008)(66946007)(6506007)(53546011)(8676002)(6636002)(7696005)(110136005)(33656002)(55016003)(76116006)(2906002)(5660300002)(38100700002)(122000001)(52536014)(508600001)(8936002)(86362001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWhGUlpSNkxXeW8yYUFnVkJSeC92Z2NySmF6SUVEd1JIaVAySVhTeGwreXdQ?=
 =?utf-8?B?clJUUjF4aUhUelcyWVdwYStkYjVJWDZ4VGx1NVJ1QzZGbmJQcWl5OVV4cHMx?=
 =?utf-8?B?emM2VnpaRXdlUkVJQkYxblFiVDNNb2E4VjB5bEl1SldVdUdyK0hCV0VUUW41?=
 =?utf-8?B?a0YwRkswdmlxNU9jTDdmV0wyaWpYalAwY215ZlNhcEo5OCs0cURUZzVXaFZT?=
 =?utf-8?B?R0xtVkFob2R4YmRFT2JMNnNkSTlNcm1mN01jVVVqc3ZhQVkvTDZhaDFZK0E5?=
 =?utf-8?B?WlU4VHVZTEFLbDB0Y082eHUwWnhyWFhkaVdBQVlOSXIwdGdrZ21MQ0hMdWQ4?=
 =?utf-8?B?MU1SakhySWJhaUlQckUrRHgxUEJwM2RFQ3hpdnFncm9xeHZIMVkwR1JqNW5w?=
 =?utf-8?B?TzlheVdMQ21MY09scXhvbkdjY0lsVzZBYllqY3dWVUpYVlZ4ZUt6R1ZpLzdn?=
 =?utf-8?B?NjF3QnRDdVAzbUFpVDg4VkJyMkxkNC9oTW9aN2tyZTRtZWJGYm4yRmJIdUJ0?=
 =?utf-8?B?d0JvTzl3UU0vOVJrWkJHVThTL0ZHaGNxNXhpenhUZEZERm4rbFliaUR1ZCsz?=
 =?utf-8?B?RXk5aFhmKzBmVmZTcTV5ODR3a2xaNW9uN0pLdUVQRXNWVGpyVDVGa0RQU3Jk?=
 =?utf-8?B?ZVo2dnp1STZ0TWVRWGl3RUgreVI0WHo5KzMzZjJtck5WbVFMRTlJWnROck1I?=
 =?utf-8?B?QnFKWkJURU1zU2xaZjJyS014ZTU3VzVvNkRiZEhreVJrVDY5UXZYNDJ4UWdH?=
 =?utf-8?B?RmRQQ0VzckZZR1Z6QTRGd21CejhIMjRQMWV1V3VnZDN3S3liZUVockptRVE4?=
 =?utf-8?B?QnV0b3c4Mnc0dnhaNy9jNmF6U0VXYXpPZEJ2WVJQMzNxaHRZNnJyUHpHQ05v?=
 =?utf-8?B?WnNnNi9LQUNBK2RXZEhpNjI1SHBMeXUzRzJjUDFSZmFPYlZBaHN4dTFvSVpo?=
 =?utf-8?B?TUJGVzdjY3FvbEluZ2VRNm9RdUpWbjNvaFBHY3dndm9YSEpJQXFHK2JBR2tp?=
 =?utf-8?B?TDJ5QklVOHU0WVRydTNVUXNDcCtZcW13Z2JzOFVDbUdES3p0TlhFOFpYYngr?=
 =?utf-8?B?K0djWW1YZGVvMnpnajVBYlNWY3VWYVFmc2FoTTlJTWZXeGI0bFVDT1JLeW91?=
 =?utf-8?B?ZXpZdklkQi9FS1MrdXY5VzFQR29ZeE53dlVRK292Y3hPUWxldWxmU3hETFNG?=
 =?utf-8?B?d3oyY0JsKzFSb3pkNWtyZzZTS2lIUGNTcUtXVjFGQnpZcUVFbDhLdFhldjJN?=
 =?utf-8?B?VXozTE4weDVrL042emVsU05hNm5mVVdoeUpIVXdnMzUxV0ZUNVk2YlhIWG9J?=
 =?utf-8?B?MFUzcXNrZkxTc3IrbGR1TjlHU3pPQWNSaWhucERLNHV0YjlKSjdKZUJmbHhD?=
 =?utf-8?B?R201cWpkbnk5clpkSk5lQ2ZHSVNkRzZZN0VNRVdnWGtPczd1aWlUbldaQStO?=
 =?utf-8?B?UVRscjNQTUNDUmxnelAvWkszbzV5c2pQTUg3RlVBdDF4R1BUWGFya0UwYmdu?=
 =?utf-8?B?eHVwRzd5ZFpEU0lkQUNwcXhlQ0hmdzdUQTZpbEVRdlRnVXR4ZUFGbEdRUEhJ?=
 =?utf-8?B?UXpHZDJqNWJoTjlSVk5oZC9uNjhFeW1CUC9paG9rQ0RiTFlCc2N2M0hxUzlm?=
 =?utf-8?B?cnBNSlZPODI1MWY3c0ovQ0p4ZklOOEt2Sk5VWjU5Q3A0MzJJY3l4by9iL01x?=
 =?utf-8?B?S0VpUW1nby9heUc5cENRTFNuYUZNZmpOWjFXenBaMmNUNVJ2S3ZDQUJxelIv?=
 =?utf-8?B?NDNBNG5idE9Cbm84OHpLK0piQlVmMEFnVWMzZTdFTW9HYXBzZDUyZTBLWlRS?=
 =?utf-8?B?Um11WjN0RjFNa05iT2VHZ285L1FheXdPaE5VdU04RWkxMTcxRllkSEhNZUJF?=
 =?utf-8?B?dThzYU1zUUttV1hBMTJrZDROajIwWHE1UWpGSkVuakZ2Z3NpNE9GZVpTM0Qv?=
 =?utf-8?B?dGZEQm1acUduVFc5aDRSZ2dCS0NjTFlhNDNldThIcFkxNUk2cU4zbkpueG1t?=
 =?utf-8?B?MFBTNVNmRHN3R2d2aW0xdjJoM21hRjN1U0JmdVRGZ2cyQmMvTEIyY3U1ZlFq?=
 =?utf-8?B?ZlB2WnJ4b25uc3Q3QUFBaWtHRFVlUGdXZC9XSGUydjZkSEtzV0M3cTRHbmp0?=
 =?utf-8?B?Y3IvYkxvc0lSLzBVZEljVGtRcWlMcUpuckk4VG9MOXVuNEJKdEwybkpaN3Fy?=
 =?utf-8?B?WHoxZUk3dndWbkh5TFYwRHdNMGN4a0dLS2I3YlFWaEVuNVl0TDBkMGxIelkx?=
 =?utf-8?B?SnVvQ2Rtbk5LV1lkSFA0RERiTzZGNlpPNHlPa1ZONWFoYmlNR2NIMmJFclNx?=
 =?utf-8?B?WHFialJqdzZ4dUJuTU9VbVNhNGdCOGJILzdoZnYvZEp6dTQ0U0ZYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9564de13-c0cf-43ac-f4cc-08da4f81e5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 10:20:55.0405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWSTgcKQq1oL7KfEjlnnxo/E70Xa6h6KwywoNCVqckRZ0dQBsAiQMWcrYAFHeNEVyqtgY/IzYt1a17Sg/UYR2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2478
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkkgc2VlLiBUaGFua3MgZm9yIHRo
ZSBjbGFyaWZpY2F0aW9uLCBTdGFubGV5Lg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFt
ZC5jb20+DQpTZW50OiBUaHVyc2RheSwgSnVuZSAxNiwgMjAyMiAxMjoxNA0KVG86IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8Q2FuZGlj
ZS5MaUBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQpTdWJqZWN0OiDl
m57lpI06IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1L3BtOiBhZGp1c3QgRWNjSW5mb190
IHN0cnVjdA0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCg0KVGhhbmtzIGhh
d2tpbmcsIGluIHRoZSBwcmV2aW91cyBwYXRjaCBpdCBoYXMgY2hlY2tlZCBwbWZ3IHZlcnNpb24g
YW5kIHRoZSBFY2NJbmZvX3Qgc3RydWN0IGlzIGNvbnNpc3RlbnQgb24gZHJpdmVyIHNpZGUgYW5k
IHBtZncgc2lkZSB3aXRoIHBtZncgZGVidWcgdmVyc2lvbiA2OC41NC4xMzYgZHVyaW5nIGRldmVs
b3AgdGhpcyBmZWF0dXJlLCBidXQgaXQncyBjaGFuZ2VkIGluIHRoZSBvZmZpY2lhbCByZWxlYXNl
IHZlcnNpb24gNjguNTUuMCwgc28gZHJpdmVyIHNpZGUgaGFzIHRvIGFkanVzdCBpdC4NCg0KUmVn
YXJkcywNClN0YW5sZXkNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFpo
YW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IOWPkemAgeaXtumXtDogVGh1
cnNkYXksIEp1bmUgMTYsIDIwMjIgMTE6NTAgQU0NCj4g5pS25Lu25Lq6OiBZYW5nLCBTdGFubGV5
IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZzsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBMaSwgQ2FuZGljZQ0KPiA8Q2FuZGlj
ZS5MaUBhbWQuY29tPjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+DQo+IOaKhOmAgTog
WWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+IOS4u+mimDogUkU6IFtQQVRD
SCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1L3BtOiBhZGp1c3QgRWNjSW5mb190IHN0cnVjdA0KPg0K
PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gR2VuZXJhbF0NCj4NCj4gRm9yIHRoZSBzdHJ1Y3R1
cmUgaXRzZWxmLCB0aGUgY2hhbmdlIGlzIG9rYXkgdG8gbWUuIEJ1dCB5b3UnbGwgaGF2ZSB0bw0K
PiBhcHBseSBwbWZ3IHZlcnNpb24gY2hlY2sgaW4gdGhlIGltcGxlbWVudGF0aW9uIHRvIG1ha2Ug
ZGF0YSBtYXRjaGVzDQo+IHdpdGggZncgc3RydWN0dXJlDQo+DQo+IFRoZSBwYXRjaCBpcw0KPg0K
PiBSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPg0K
PiBSZWdhcmRzLA0KPiBIYXdraW5nDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDE2LCAyMDIyIDExOjIyDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgWmhhbmcsIEhhd2tpbmcNCj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBU
YW8gPFRhby5aaG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UNCj4gPENhbmRpY2UuTGlAYW1kLmNv
bT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogWWFuZywgU3RhbmxleSA8
U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0v
YW1kZ3B1L3BtOiBhZGp1c3QgRWNjSW5mb190IHN0cnVjdA0KPg0KPiBUaGUgRWNjSW5mb190IHN0
cnVjdCBpbiBkcml2ZXJfaWYuaCBpcyBhcyBiZWxvdyBpbiBvZmZpY2lhbCByZWxlYXNlDQo+IHZl
cmlvbiA2OC41NS4wIHR5cGVkZWYgc3RydWN0IHsNCj4gICAgdWludDY0X3QgbWNhX3VtY19zdGF0
dXM7DQo+ICAgIHVpbnQ2NF90IG1jYV91bWNfYWRkcjsNCj4NCj4gICAgdWludDE2X3QgY2VfY291
bnRfbG9fY2hpcDsNCj4gICAgdWludDE2X3QgY2VfY291bnRfaGlfY2hpcDsNCj4NCj4gICAgdWlu
dDMyX3QgZWNjUGFkZGluZzsNCj4NCj4gICAgdWludDY0X3QgbWNhX2NldW1jX2FkZHI7DQo+ICB9
IEVjY0luZm9fdDsNCj4gSXQncyBkaWZmZXJlbnQgZnJvbSB0aGUgZGVidWcgdmVyc2lvbiBkcnVp
bmcgZGV2ZWxvcCBwcmludCBjb3JyZWN0YWJsZQ0KPiBlcnJvciBhZGRyZXNzLCBzbyBhZGp1c3Qg
RWNjSW5mb190IHN0cnVjdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleS5ZYW5nIDxTdGFu
bGV5LllhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAuLi4vZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1m
d19pZi9zbXUxM19kcml2ZXJfaWZfYWxkZWJhcmFuLmggICB8IDMgKystDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQNCj4g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZlcl9p
Zl9hbGRlYmFyYW4uaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3BtZndf
aWYvc211MTNfZHJpdmVyX2lmX2FsZGViYXJhbi5oDQo+IGluZGV4IDZmOTIwMzg0NzBlYy4uN2E2
MDc1ZGFhN2IyIDEwMDY0NA0KPiAtLS0NCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZlcl9pZl9hbGRlYmFyYW4uaA0KPiArKysNCj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdTEzX2RyaXZlcl9pZl9hbGRl
YmFyYW4NCj4gKysrIC5oDQo+IEBAIC01MjEsMTIgKzUyMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCB7
ICB0eXBlZGVmIHN0cnVjdCB7DQo+ICAgICAgICAgdWludDY0X3QgbWNhX3VtY19zdGF0dXM7DQo+
ICAgICAgICAgdWludDY0X3QgbWNhX3VtY19hZGRyOw0KPiAtICAgICAgIHVpbnQ2NF90IG1jYV9j
ZXVtY19hZGRyOw0KPg0KPiAgICAgICAgIHVpbnQxNl90IGNlX2NvdW50X2xvX2NoaXA7DQo+ICAg
ICAgICAgdWludDE2X3QgY2VfY291bnRfaGlfY2hpcDsNCj4NCj4gICAgICAgICB1aW50MzJfdCBl
Y2NQYWRkaW5nOw0KPiArDQo+ICsgICAgICAgdWludDY0X3QgbWNhX2NldW1jX2FkZHI7DQo+ICB9
IEVjY0luZm9fVjJfdDsNCj4NCj4gIHR5cGVkZWYgc3RydWN0IHsNCj4gLS0NCj4gMi4xNy4xDQo+
DQoNCg0K
