Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D098C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 15:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078FA10E4F1;
	Wed, 19 Jan 2022 15:04:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 780C610E4E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 15:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnA0WLvioKl3u2/da87ogJmLl0P7CSCi8ANgMKYEvDDMdnNR2HPZ78S0+wAySBpXM4LyimIEjfoQ+eYNSjURTYLO8+at8oGOH1hJZCMLcH+We+65Ncm7RCVUwMxCgTEjssTjjqE5ntIeHCZEHzYnpvPjUPFX1Rh0rYnPL9paJlLbp9bWBzfvlxo0wcAkHo9Vq3YS+NetD60wg/KV+fLOyIPMawrE0yZ83hVZXgCvv4+lhhFVGPzNqxrPOQVI0yPUyUtb7xJn4EgH7e4T3y73IZ1Dh05Udg+mfewO3Z6cohXkdy70nrdSIOA0PEkpVY1Yu6FKJ7yqCqJYjWni/9Goeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9XLg5bo4mcbFFHVLAg2Wq8nYpBHBpa7L1s8Ze6iw8U=;
 b=e2duWTvXbjmA1MYKKcGSRRww4Vns40rWTL/7NOqndrzh6fRaBT/tmZLflLk0S4p1wpxt0Sz7CRtDXt8wyVd5xaQEYMBvCFWgzO0FGFHRysWCKOzVGk3yjw6Smvqud4APt6fHXtH5SK4mZExC2ChOj8uSXkYpunkYeLuI+UudBdXkkfUyUU0JhrNrcE/KdqX2zAWSXkrbHFna5rKVofvM6U6KB1jxnxzGWqv+T65kAkO+BE9RM78ybu5losnHpwvTZCJSNkss08acL0hLqjCKthrJT0rArDK+LtMeR7adBr++6aVmO7cxcstBYVN3u1NpIdree+Vuh3yXjnTS7SqRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9XLg5bo4mcbFFHVLAg2Wq8nYpBHBpa7L1s8Ze6iw8U=;
 b=rpRcYhvl4mTrsltdVmUP7FvkdvSg1ob9R7N6qsieK24jRQJTqwDpqtBrCZr3orX8wspOOSrWPkX6ho8l4s2nZjWSvdWsSm5fwbUWNvE6FytZ6maN+CraA7RsWIPRbolgsEaMNBTjB8fHEe+5a3oEfsDVAHwUb531z0if0GqphBs=
Received: from CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 15:03:57 +0000
Received: from CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::b07b:5bef:d605:6007]) by CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::b07b:5bef:d605:6007%9]) with mapi id 15.20.4909.009; Wed, 19 Jan 2022
 15:03:57 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Topic: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Arcturus
Thread-Index: AQHYDL0fyZH/Oz956ku+GOPqPt3eQqxpbwKAgAAIm0uAAAJpAIAA9A9QgAADF4CAAADOcA==
Date: Wed, 19 Jan 2022 15:03:57 +0000
Message-ID: <CY4PR12MB130301523CAB9202A0D4952185599@CY4PR12MB1303.namprd12.prod.outlook.com>
References: <20220118224513.26563-1-jinhuieric.huang@amd.com>
 <b4572e2d-7898-9740-c1f6-15c22aca12bd@amd.com>
 <DM5PR12MB1308928E28F9CAAB947F9E3585599@DM5PR12MB1308.namprd12.prod.outlook.com>
 <40522d1a-d759-c6c2-96e2-59923573d0ca@amd.com>
 <CY4PR12MB130369EB0000727C6269A84F85599@CY4PR12MB1303.namprd12.prod.outlook.com>
 <d5cd89ef-e303-7557-964e-afc251372ac7@amd.com>
In-Reply-To: <d5cd89ef-e303-7557-964e-afc251372ac7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=51c3bc1d-c4ea-44bd-8e47-7781550a3c07;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-19T15:03:33Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86cc3a38-6d76-47fa-077b-08d9db5ceae3
x-ms-traffictypediagnostic: BY5PR12MB4289:EE_
x-microsoft-antispam-prvs: <BY5PR12MB42892727B08AC7079A9847C185599@BY5PR12MB4289.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwbUELq8nZnx87InFVIM4M89QVHWMhmboYQkYll1/l2WWb6nWx8nF14ROhcaAmGKVdLHMfQ60AtNBpmtL0Ym9H174r7Cwhlz8FBzAGC5TMxAkoKngxEE3AmpmIWsn+kDEwpkSzx1rgmFb4zJ4MIBVeDXyUDkas1Vc1Bq6bHPcdjGoMZJQo31XXM+OE3cT44vsMyb9HSm57KBYxsDev6XErogYOJFwscRMv4i761LH0/8QL1aJXrSwmAkQQdMjNMN+bcvs+k+BJc71Y89YpTwyuERWxh+NBGWF0aVbYAGNlZiHhGuGr/YdWXHe34l11Q1FZBVT0W37Pi6w5v6B3pdHpen5/Z+pnOGlRfR3v1YvdXcv9Mvr2W3Gils6d36oWavh/aAYz3xJf8waGoRiFKdyhuCW9ds95Hj0sGJaJsSiE9EiKCPWNGe4aDpSo2j/UKJp5VCnMVkek2uxUGYWCam0Sc8IsZDoVHTnoRMFZhWXYTyZJxHl4iEFB+TjEX/ynADemu1NwNntoRiZmlvdrbbL0WTUO44y1ce6ll1XJSaVzDJDXung+VrKugQGRnbnRyXmBlFfaHZqb8cOzS+mX13zOFggoMrj39Kp1uhyIsKymY+e7sZ5t2GP9W8uB/tfX3JMXqIcM67u6To5L1H1+gREAj4N0yeHfOwxsthkj22yDRh+5P/06N0bBpVzepff7KPvJs08KYtAxRsEPYN9ruMIpf472TPLh2qEUdu0YGB6tk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1303.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(26005)(76116006)(52536014)(5660300002)(66556008)(64756008)(66446008)(66946007)(8676002)(186003)(55016003)(122000001)(38100700002)(38070700005)(33656002)(83380400001)(86362001)(9686003)(53546011)(6506007)(40140700001)(7696005)(8936002)(508600001)(110136005)(71200400001)(2906002)(316002)(16393002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2RWMTBpcUxjMWhqejdrMlRkWkFQcUtWVTlpT1pwT2NmUTcrb0RyL2xGNnR4?=
 =?utf-8?B?Y0FVOGlRTCtUM0ZDWnRQaFNNZ3R2eWJ0ZVErRUJ0T0VnOHZSMlczV3orNlJV?=
 =?utf-8?B?QlR4WDF5Q0d6ZzQ2ck4vMGgzQS9EMWpxNEhqeEViMHJJWVQrT2E2YUlBUjEr?=
 =?utf-8?B?VnpwNWJzOXN6dEJRRjc2Z25OOGlLWUVEcmtucGZmbGlaem9MUFIwZEluTnJt?=
 =?utf-8?B?a0hpVHBvRU1TcEZvY1p0VnFNb3VrR0lzZTQyTUYrdEZsT3lWUUdVTU45eFdo?=
 =?utf-8?B?YnJLSEhtSG02M3d1Q2U2YmM2QmFCOFphVTIvbm5ETDVlaUhZUmJBNzcvQklG?=
 =?utf-8?B?RWkvZEprSlVlTlUzc1o3U2FpWDRGdVNVWXN0Szg0MUJtN3p1NnpLVCs0cU9Y?=
 =?utf-8?B?dVFRUkU4YVBtRkdxM0IvZ3VXanVzc2M4WllxTEIzOHdGOFk3MHUwQkVNaU5Z?=
 =?utf-8?B?QmxMeCtsY1pjamN3N0UyRFFIVTFjMlZsejZOcGl6WkUvZDBETjBNMkR6ZUF0?=
 =?utf-8?B?ZVhGcmZtMEVNRy9jbHlUZFRxWUswMTgzNmFnc2hYMWNydFFlWk91NjdubnZP?=
 =?utf-8?B?ZlVQd1RTVmxEWDhwNWFiRHl0VGEyZTdZdlloQ1Ewc1dqK2l4TFZlSzFFeWp3?=
 =?utf-8?B?QXpnZ3BoY3pWbFU1OFNKRlhVVkpuTC9aZ0dNMzNLODZXaUF0RjNCcWdLV3cv?=
 =?utf-8?B?Z0FxdnVpTnl4VERvSEpXaUR4alpOenFrcVhQWXpmdFZ4bTN0Q042dEhIbXJK?=
 =?utf-8?B?WFYzNmZ3STV0cUxrWVI3NVZJL2IrSXZUeHZ1TG5NSStrUEFpL29lckZYMXZL?=
 =?utf-8?B?RUo4OUFOWm1QV2hnTDhwRUFYNE1zb05WQUFRM3FrWG9NdTBzSUpQalJDSTZ1?=
 =?utf-8?B?YnpYZXFJelBidmdMUzV1ZWRWdW9OWmlyWDFtUjJXYmgweWFVa3dkNmlVZHNQ?=
 =?utf-8?B?L2puVUtCd3h6YnUyK3JHN0phWUxCb21yemFSaVltRTNuTnZkeCt6SmVCZDJp?=
 =?utf-8?B?am5iNVYzeTkzTFVSZHNyNjJoYjdJbEdqMXl6RUlyUGtBVlVyb2xkQURtNnpC?=
 =?utf-8?B?Qk1rbTJsMGRJSSs2SzNrckp6MiszaklUV1FzME51UndoWXU0T2p3VkNOS1Y4?=
 =?utf-8?B?RDhqWlpRSWZyUFdiWUd3L2diTmtuaHcwRXhta205V0VxVU1PYlpOeG42TURk?=
 =?utf-8?B?bGNudUZkODY1aG1Bd1J3MmRKaE1hSXpvMERpSkM4ZmRTc21Fckx5cXdRRFpV?=
 =?utf-8?B?cUQzaStxU3JlTjNsbVljSkJnL0daaXdEZHFmWE5vRHd5a2JrSkNQN1V1M01t?=
 =?utf-8?B?WUxEM2trMGRwZkpUek1pei90NVAwekVpUE8rQm5hNk9YNlV2QXVrSWNrS2Vk?=
 =?utf-8?B?ZHhmQWFsY0dCR3c3bjF5UGJKekpEUWVRUERRZWw4dkxTUnhsZjhpVCtESzQz?=
 =?utf-8?B?TUtCbUFLTWVYZWxnZ3NDUzZ1a08zN2l4WExybEV1VGlqaURQai95bzVvbnJW?=
 =?utf-8?B?WXV3aDQ3Wit0ZU9oSGd6TzFSZzZoNW5IcFdVZkx5WDVPYTR2UzZtVTViTjQ5?=
 =?utf-8?B?Z0ZEV0ZSSHlyRFZWdDY3b3pyd2xScmdYT3pyMHdVZHhJR2k4RVBmN2k0dWNP?=
 =?utf-8?B?dWd6WG1Calpsd1k4N05TcStDaVVaY2FPQlpkSkdXQ1drSWxQbHFNKzl6cDA4?=
 =?utf-8?B?NlAvU0NCenBaRmdRcDl3bWNuZjNJV1lpNFNzU0ZwMk15QS9WcExiZ0N1OUFm?=
 =?utf-8?B?ekVWaDNTNDY4Z0xYakZQRUl1bVluQncxUWN6QnAvdUJrNVJmWkQzcSt6Wlkw?=
 =?utf-8?B?NmpvWWVZK0FKMFl3cExKRUZQTVJLdEQ4WEVjZ0F3b0NGV1pkbWxXZ3YrY0NV?=
 =?utf-8?B?ak8rRWU2ZHFHREdjY25wMU5RN01UWVRSWUlxRWNEeUl3WHFnallSSXRua1pK?=
 =?utf-8?B?QTl1S1F6Rkhtb3BTTmdPS3lQS0R3VFZnRGlLak53b3VDZEFiSUNVWE1EVDI1?=
 =?utf-8?B?YUVCTHl6NWpySk4vSkREV29KSmZ4WUd4SFpxdkE4TVdJTFNGN0hiMlcwRFB3?=
 =?utf-8?B?YnBBY2prVE1DY2pPTlNTZ3FYVEh2RFh3RTVxODlBaFlFS21pOEQwVjJVYkRT?=
 =?utf-8?B?SnB4NzN6a21wcDc4SHVnY1FpWEgvT3dmV2lJRTRvSTJkdS9XTUxnWGtVeEMy?=
 =?utf-8?Q?DUtuU4n3IYoIxcx+lkGUz20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1303.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cc3a38-6d76-47fa-077b-08d9db5ceae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 15:03:57.1982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4o6329Dio4/NGtCBZ6dIwMuxutJoflUuHoVYHqEH/JJDXldCWCm+bCmCIflpaZ/zFr2xKjFc7TlxEEm1k7JYvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBIdWFuZywgSmluSHVpRXJpYyA8SmluSHVpRXJpYy5IdWFuZ0BhbWQuY29tPg0KPiBT
ZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTksIDIwMjIgMTA6MDEgQU0NCj4gVG86IFJ1c3NlbGws
IEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPjsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZW5hYmxlIGhlYXZ5LXdlaWdodCBUTEIgZmx1c2gg
b24gQXJjdHVydXMNCj4NCj4NCj4NCj4gT24gMjAyMi0wMS0xOSAwOTo1MCwgUnVzc2VsbCwgS2Vu
dCB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3Vl
aGxpbmdAYW1kLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAxOCwgMjAyMiA3OjE2
IFBNDQo+ID4+IFRvOiBSdXNzZWxsLCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47IEh1YW5n
LCBKaW5IdWlFcmljDQo+ID4+IDxKaW5IdWlFcmljLkh1YW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2Zk
OiBlbmFibGUgaGVhdnktd2VpZ2h0IFRMQiBmbHVzaCBvbiBBcmN0dXJ1cw0KPiA+Pg0KPiA+PiBB
bSAyMDIyLTAxLTE4IHVtIDc6MDggcC5tLiBzY2hyaWViIFJ1c3NlbGwsIEtlbnQ6DQo+ID4+PiBP
bmUgcXVlc3Rpb24gaW5saW5lDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+ICpLRU5UIFJVU1NFTEwqKioN
Cj4gPj4+DQo+ID4+PiBTci4gU29mdHdhcmUgRW5naW5lZXIgfCBMaW51eCBDb21wdXRlIEtlcm5l
bA0KPiA+Pj4NCj4gPj4+IDEgQ29tbWVyY2UgVmFsbGV5IERyaXZlIEVhc3QNCj4gPj4+DQo+ID4+
PiBNYXJraGFtLCBPTiBMM1QgN1g2DQo+ID4+Pg0KPiA+Pj4gKk8qKygxKSAyODktNjk1LTIxMjIq
KnwgRXh0IDcyMTIyDQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4g
KkZyb206KiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBv
biBiZWhhbGYgb2YNCj4gPj4+IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29t
Pg0KPiA+Pj4gKlNlbnQ6KiBUdWVzZGF5LCBKYW51YXJ5IDE4LCAyMDIyIDY6MzYgUE0NCj4gPj4+
ICpUbzoqIEh1YW5nLCBKaW5IdWlFcmljIDxKaW5IdWlFcmljLkh1YW5nQGFtZC5jb20+Ow0KPiA+
Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPg0KPiA+Pj4gKlN1YmplY3Q6KiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBlbmFibGUg
aGVhdnktd2VpZ2h0IFRMQiBmbHVzaCBvbg0KPiA+Pj4gQXJjdHVydXMNCj4gPj4+DQo+ID4+PiBB
bSAyMDIyLTAxLTE4IHVtIDU6NDUgcC5tLiBzY2hyaWViIEVyaWMgSHVhbmc6DQo+ID4+Pj4gU0RN
QSBGVyBmaXhlcyB0aGUgaGFuZyBpc3N1ZSBmb3IgYWRkaW5nIGhlYXZ5LXdlaWdodCBUTEINCj4g
Pj4+PiBmbHVzaCBvbiBBcmN0dXJ1cywgc28gd2UgY2FuIGVuYWJsZSBpdC4NCj4gPj4+Pg0KPiA+
Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4N
Cj4gPj4+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNv
bT4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwgIDYgLS0tLS0tDQo+ID4+Pj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jICAgICAgICAgfCAxMCArKysrKysr
Ky0tDQo+ID4+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4+Pj4gaW5kZXggYTY0Y2JiZDk0M2JhLi5h
Y2I0ZmQ5NzNlNjAgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jDQo+ID4+Pj4gQEAgLTE4OTIsMTIgKzE4OTIs
NiBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9tYXBfbWVtb3J5X3RvX2dwdSgNCj4gPj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRydWUpOw0KPiA+Pj4+ICAgICAgICAgcmV0
ID0gdW5yZXNlcnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4gPj4+Pg0KPiA+
Pj4+IC0gICAgIC8qIE9ubHkgYXBwbHkgbm8gVExCIGZsdXNoIG9uIEFsZGViYXJhbiB0bw0KPiA+
Pj4+IC0gICAgICAqIHdvcmthcm91bmQgcmVncmVzc2lvbnMgb24gb3RoZXIgQXNpY3MuDQo+ID4+
Pj4gLSAgICAgICovDQo+ID4+Pj4gLSAgICAgaWYgKHRhYmxlX2ZyZWVkICYmIChhZGV2LT5hc2lj
X3R5cGUgIT0gQ0hJUF9BTERFQkFSQU4pKQ0KPiA+Pj4+IC0gICAgICAgICAgICAgKnRhYmxlX2Zy
ZWVkID0gdHJ1ZTsNCj4gPj4+PiAtDQo+ID4+Pj4gICAgICAgICBnb3RvIG91dDsNCj4gPj4+Pg0K
PiA+Pj4+ICAgb3V0X3VucmVzZXJ2ZToNCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4+Pj4gaW5kZXggYjU3MGMwNDU0Y2U5Li40ODVkNGM1
MmM3ZGUgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2NoYXJkZXYuYw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9j
aGFyZGV2LmMNCj4gPj4+PiBAQCAtMTU5Niw2ICsxNTk2LDEyIEBAIHN0YXRpYyBpbnQNCj4gPj4+
IGtmZF9pb2N0bF9mcmVlX21lbW9yeV9vZl9ncHUoc3RydWN0IGZpbGUgKmZpbGVwLA0KPiA+Pj4+
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPj4+PiAgIH0NCj4gPj4+Pg0KPiA+Pj4+ICtzdGF0aWMg
Ym9vbCBrZmRfZmx1c2hfdGxiX2FmdGVyX3VubWFwKHN0cnVjdCBrZmRfZGV2ICpkZXYpIHsNCj4g
Pj4+PiArICAgICByZXR1cm4gS0ZEX0dDX1ZFUlNJT04oZGV2KSA9PSBJUF9WRVJTSU9OKDksIDQs
IDIpDQo+ID4+PiBEbyB3ZSBuZWVkIHRvIGFkZCBhIGNoZWNrIGZvciBzZG1hIHZlciA+PTggaGVy
ZT8NCj4gPj4gV2hhdCdzIHRoZSBzaWduaWZpY2FuY2Ugb2YgdmVyc2lvbiA4IGZvciBBbGRlYmFy
YW4/IFRoaXMgY29kZSB3YXMNCj4gPj4gd29ya2luZyBvbiBBbGRlYmFyYW4gd2l0aG91dCBhIHZl
cnNpb24gY2hlY2sgYmVmb3JlLiBEaWQgd2UgZXZlcg0KPiA+PiBwdWJsaWNseSByZWxlYXNlIGFu
IFNETUEgZmlybXdhcmUgb2xkZXIgdGhhbiB2ZXJzaW9uIDggdGhhdCBmb3IgQWxkZWJhcmFuPw0K
PiA+IFdlIHJlbGVhc2VkIHY1IGZvciBBbGRlYmFyYW4gU0RNQSBpbiBST0NtIDQuNSAuIElmIEkg
cmVtZW1iZXIgdGhlIHRpY2tldCBjb3JyZWN0bHksIHRoZQ0KPiBzYW1lIGZpeCBmb3IgQXJjdHVy
dXMgd2FzIHJlcXVpcmVkIGZvciBBbGRlYmFyYW4gYW5kIHdhcyBwYXJ0IG9mIFNETUEgdjguIEJ1
dCBFcmljIGlzDQo+IG9idmlvdXNseSB3YXRjaGluZyB0aGUgdGlja2V0IG1vcmUgY2xvc2VseSB0
aGFuIEksIHNvIEknbGwgZGVmZXIgdG8gaGltIHRoZXJlLg0KPiBZZXMuIEFsZGViYXJhbiBoYXMg
dGhlIHNhbWUgYnVnIGFzIEFyY3R1cnVzIGluIFNETUEsIGJ1dCB0aGUgYnVnIGRvZXNuJ3QNCj4g
Y2F1c2UgR1BVIGhhbmcgb24gQWxkZWJhcmFuLiBBcyBGZWxpeCBzYWlkIGhlYXZ5LXdlaWdodCBU
TEIgZmx1c2ggaGF2ZQ0KPiBiZWVuIHdvcmtpbmcgb24gQWxkZWJhcmFuIHNpbmNlIGl0IHdhcyBl
bmFibGVkLCBzbyB3ZSBkb24ndCBuZWVkIHRvDQo+IGNoZWNrIHRoZSB2ZXJzaW9uIGZvciBpdC4N
Cg0KQWggcGVyZmVjdCwgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbiENCg0KIEtlbnQNCg0K
Pg0KPiBSZWdhcmRzLA0KPiBFcmljDQo+ID4NCj4gPiAgIEtlbnQNCj4gPg0KPiA+PiBSZWdhcmRz
LA0KPiA+PiAgICBGZWxpeA0KPiA+Pg0KPiA+Pg0KPiA+Pj4gfHwNCj4gPj4+PiArICAgICAgICAg
ICAgKEtGRF9HQ19WRVJTSU9OKGRldikgPT0gSVBfVkVSU0lPTig5LCA0LCAxKSAmJg0KPiA+Pj4+
ICsgICAgICAgICAgICAgZGV2LT5hZGV2LT5zZG1hLmluc3RhbmNlWzBdLmZ3X3ZlcnNpb24gPj0g
MTgpOw0KPiA+Pj4+ICt9DQo+ID4+Pj4gKw0KPiA+Pj4+ICAgc3RhdGljIGludCBrZmRfaW9jdGxf
bWFwX21lbW9yeV90b19ncHUoc3RydWN0IGZpbGUgKmZpbGVwLA0KPiA+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnAsIHZvaWQN
Cj4gPj4+ICpkYXRhKQ0KPiA+Pj4+ICAgew0KPiA+Pj4+IEBAIC0xNjkyLDcgKzE2OTgsNyBAQCBz
dGF0aWMgaW50IGtmZF9pb2N0bF9tYXBfbWVtb3J5X3RvX2dwdShzdHJ1Y3QNCj4gPj4+IGZpbGUg
KmZpbGVwLA0KPiA+Pj4+ICAgICAgICAgfQ0KPiA+Pj4+DQo+ID4+Pj4gICAgICAgICAvKiBGbHVz
aCBUTEJzIGFmdGVyIHdhaXRpbmcgZm9yIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZXMgdG8NCj4gPj4+
IGNvbXBsZXRlICovDQo+ID4+Pj4gLSAgICAgaWYgKHRhYmxlX2ZyZWVkKSB7DQo+ID4+Pj4gKyAg
ICAgaWYgKHRhYmxlX2ZyZWVkIHx8ICFrZmRfZmx1c2hfdGxiX2FmdGVyX3VubWFwKGRldikpIHsN
Cj4gPj4+PiAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGFyZ3MtPm5fZGV2aWNlczsg
aSsrKSB7DQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgcGVlciA9IGtmZF9kZXZpY2Vf
YnlfaWQoZGV2aWNlc19hcnJbaV0pOw0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGlm
IChXQVJOX09OX09OQ0UoIXBlZXIpKQ0KPiA+Pj4+IEBAIC0xODA2LDcgKzE4MTIsNyBAQCBzdGF0
aWMgaW50DQo+ID4+PiBrZmRfaW9jdGxfdW5tYXBfbWVtb3J5X2Zyb21fZ3B1KHN0cnVjdCBmaWxl
ICpmaWxlcCwNCj4gPj4+PiAgICAgICAgIH0NCj4gPj4+PiAgICAgICAgIG11dGV4X3VubG9jaygm
cC0+bXV0ZXgpOw0KPiA+Pj4+DQo+ID4+Pj4gLSAgICAgaWYgKEtGRF9HQ19WRVJTSU9OKGRldikg
PT0gSVBfVkVSU0lPTig5LCA0LCAyKSkgew0KPiA+Pj4+ICsgICAgIGlmIChrZmRfZmx1c2hfdGxi
X2FmdGVyX3VubWFwKGRldikpIHsNCj4gPj4+PiAgICAgICAgICAgICAgICAgZXJyID0gYW1kZ3B1
X2FtZGtmZF9ncHV2bV9zeW5jX21lbW9yeShkZXYtPmFkZXYsDQo+ID4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAoc3RydWN0IGtnZF9tZW0gKikgbWVtLCB0cnVlKTsNCj4gPj4+
PiAgICAgICAgICAgICAgICAgaWYgKGVycikgew0KDQo=
