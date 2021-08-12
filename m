Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A95C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247E760EB9
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 06:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 247E760EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DA18800B;
	Thu, 12 Aug 2021 06:46:19 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D316E24E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 06:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5r0J9CQSmdDesFsAY+Piyk48j5dh2MdpTWYUu+u8201y6lU7OyC7VEjmBNzZiqaBolzOghJrKHt8nInJz9uNzCBi1/ZqAoseEug+IhqDIyVFgxO2+jZKxnrVkLdmQQcRBk+NQJG5E+sQV3Gp7eNu6DxYupxOu2Jka/WKCC+J8w0WuHBaWPE6Vc2R+LY29oRUDBKccJftU+XBd1eHFU6I1H6xk/8pQy6Rz4avbw5IYdz7kMM4xKdWSeYF/XGIEYu2iGB6013fJUlEgRmxRetD66b8Lqz6U+JPFP5Y00ZIPsS7Ftj7wQppuRC71Qu1EUZK7Idoic8l9Q2X9MVeHjTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBh8MSrR8i+rCH2NbnMVwixghgwCD1QjQcQnWEKkgvA=;
 b=IBzZ1hs2XX4daugUh9G2ZZgeytKBnEumsHDnTPqr4uLCIJ28WgW8qIVjdrdtyAA5TI3TQaPKPXPH0JizqUZoxJZekAXX0Bp9XfJZrJtJ2Z1aAHSQOwGqeOzAfQehSyEb0hVf/wFvo1nSVEhvLgLtpjMnN/XI8DPFLVFErH68Ffejx6qO4JRs4VbcqGGe6SR19BowodP3vWsGXcMdlsHYwodEJlKDwv26Gu/iEdjjm9qRdzp5yTmNZqQBrtE6vlvtdNOBgC1ADDtTIe6VtQtMbnyz4y8BOJG7Eq4x6bPIGb8YCxJ7mVafbGRTrormZF2Sa4pU1Ithh9PJegZhSppu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBh8MSrR8i+rCH2NbnMVwixghgwCD1QjQcQnWEKkgvA=;
 b=T2giAhcYf7SWCfaZ/Z7JVr/TwESm3xPNvuJ0uETrk39yl9Pf+auL8qWCVEdsPjyzrM6E4glOWB/HJZsPtJvdIlwFheWfatUb/vfnzy+ZTuXVE6JJ/2iBybP+cOESp7AQkI88PZud81KpyVCoIBqMd/z7gJHOCqMNskGTM/hiGv8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4812.namprd12.prod.outlook.com (2603:10b6:5:1ff::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Thu, 12 Aug 2021 06:46:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::e9f8:55de:32f0:a7e6%7]) with mapi id 15.20.4415.017; Thu, 12 Aug 2021
 06:46:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "nils.wallmenius@gmail.com" <nils.wallmenius@gmail.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>
Subject: RE: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
Thread-Topic: [PATCH V2 6/7] drm/amd/pm: drop unnecessary manual mode check
Thread-Index: AQHXjy7EX5/K0IP6F0aXogKv63o5XqtvZKUAgAAHXdA=
Date: Thu, 12 Aug 2021 06:46:13 +0000
Message-ID: <DM6PR12MB2619197EFEF711E675799ED7E4F99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210812040110.1293682-1-evan.quan@amd.com>
 <20210812040110.1293682-6-evan.quan@amd.com>
 <0d76361c-e28e-cc8a-a050-668f38d4e251@amd.com>
In-Reply-To: <0d76361c-e28e-cc8a-a050-668f38d4e251@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-12T06:46:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7e5b517b-b088-44f6-b27f-21df5444e823;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ada6a0f6-f340-44e0-3f05-08d95d5ce07b
x-ms-traffictypediagnostic: DM6PR12MB4812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB48124B247FED906827F6A419E4F99@DM6PR12MB4812.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0E3CW7GUgfqZbT6qF2SxrKggbDV/CdkXKmxVDrM0bI1VQEz+xMMPL9nI3uLv7KWYro8to64S8t4J++FI+bHoC7VyBFFW7zGcYgdj1m2UyFcvT2/h3Y5RPkNJ6HoHL6I5PpdC/4SgwGYDfcuW8I7KRZGOgohgBxEgGrT6LHD/XA+uVun/hupPS5teZOfoQyTVFA/MAbjdj3fafblhlrzRckZBNsUc/5bFZ0ZwwsPwY4SE4ZvpPYFVSGd+aF8PWV3VB1xTYmHXeKA6/v1FxA+3E5ipFMyJKUaQRqRlrupB/nkpkITVx1bWKeBviJwko/ky87styO49ILfjbt6gNi8D6TkLmvclQBaBQjn61cX6mjT9TfqLBCc1jRbs9ffOgW9SYqN69xip4EF5elEMus/UfjjL4ycifm9oo8m5s8bnLiqzgD3dNVqYb5Tm2XhLYfb5fWemwlr8y494+I+UnS00a1SpuUMC3kEg7NF6ZWtVvyJ0OLjv/femDXE8J3IAPCVIPlhauR9e7PmbG3HFIq+loMfp5JcdYUtbr6SKrzJpVTfmYV4NatxSauYGeoT4QFJxHJqB5iXLfLn/s1LjZT3WFg+VeaF13egYDBPdbCxl4KKpfkViKP6OxsWIlf/ZQAzuMKHRjhANz7+SZYgzP4CZj9XcO9DAv/IrMvPwfacKuzFEt7k+aH/9TCG1gpAZcYedva1duYEh9miYdgVMBg7Xvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(8676002)(76116006)(7696005)(6506007)(122000001)(110136005)(66946007)(52536014)(53546011)(8936002)(26005)(316002)(38070700005)(71200400001)(33656002)(38100700002)(66476007)(64756008)(66556008)(5660300002)(4326008)(66446008)(186003)(508600001)(86362001)(83380400001)(9686003)(55016002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHFoV1JhRGlkWGN5aUR5WU9hYjFpKzJBRmVYekZvWXdFbHRxSGVuRjJBdTR3?=
 =?utf-8?B?YlI5MUxQbjllcGROMzNLWTlzVXNOcDI4dVg4blRWZjZXRCtTd2VRUGdGb2tE?=
 =?utf-8?B?RENaU29rSklWMVJMRWJ0ZDFZdVp0TXNicysyeGdESkt2cEVCejRXb2pwaXBu?=
 =?utf-8?B?eUl6UDVuR3g2ZWZGUzRrV1FkMDBGcVJmblNET2xxd1dNSVc0ZVcrZnNDTFRl?=
 =?utf-8?B?MytnOXkwNGxRM3IxYWJwUUlGMTl5M3doNXNLNGVsQlAyTkM5ZjdONWR2dU9q?=
 =?utf-8?B?N1kyeVB4S2ZGSTg3eTRUMktlZ01RZTVEV1NIdEtrbVBWL2oxWHFrY25yNjho?=
 =?utf-8?B?N1plWlZ2N2ZwNVQ2L3k1QVpZT1A1R29MTkIxVFlaNEJldTliWTJjS01ZNDNj?=
 =?utf-8?B?eFRySmhiWSt1Wnc1anhWaW5ieUxNNUYrWnZxSU9SOEszNmRTZ0JlYyt4d29k?=
 =?utf-8?B?UlNWdjVhVkRJck5kR2FWZFgxaUtRUFJlQWtNRXlXVVAxRjBVcGZLSmtqNEF3?=
 =?utf-8?B?WStLeHo3ellza1FBUmJ2VnVRMVlYay9SdG9VQ3ArSmJNQS9STVF2THVFRE1F?=
 =?utf-8?B?YktIb2o0SDRySHFWdFV2aHpCRlNBUzk3Qi9kQVpIV2syampuSVB5VXpmZXkz?=
 =?utf-8?B?ZDBWdkxYTW5PZ2RZTThlVng2dkpxTTI0RjJPdHl0aVUrWndudDZlRU9YTXU5?=
 =?utf-8?B?OGhremdmYTMvRjBPKzNvVU1wcVdBMGZyMGNSb0twWmdobnBnU0lxc1JGVjRL?=
 =?utf-8?B?NFpQbGkxbW1nUzR3VXBoajh6cGtYNFErdEUrYjBCeHVwU292SzlnTC8zZDEx?=
 =?utf-8?B?a2RVaU40eDJ6dlBHa2MxTU9SRjhONVdPRENSNXVEU0s4bmc3azhhczlsUzEy?=
 =?utf-8?B?aVJqS0F6enlQMklNNGYvOVJNWk0yRlFxUFVIeGVqaHcxekE5TGc1WGJJQ3c0?=
 =?utf-8?B?dGx0czVGNjVINFluYTNjQUQzb1lSTlFEb0pDcTRlREhnVW4vSDhLcC9jNEd2?=
 =?utf-8?B?TENwRmprZ21oU1hoWmRiTnVHVzluNVJpZkFvTTFKcDRseUlJYzJuQzBqY2J5?=
 =?utf-8?B?dkxGbmhxUDV0aFBDc0w0LytJeDlnZGxFL2g5bFFuOHIwMlAySWgwZVpBUU1X?=
 =?utf-8?B?UVY2QWwzaUdjM3NXNEJFVHBLSzlEZnp3d2dZL3ZucEZ5TVJmS0hESHhNTmxS?=
 =?utf-8?B?dUxmclUrVlBZMmEwT0dIbG84aVVYOTh5VGgzdXp6aDRFazR1cGp6VFllK0cw?=
 =?utf-8?B?RE5BNzN5Y2JVUlFFZXBWbGRPUWM1STdRTTBiN3dOVmsxRVhMeFA2OTZBWUVa?=
 =?utf-8?B?K05SOEVLTWNneXRLUEVkM09tYkJLSVFSellqUzFxV0RZelZ1RWVMa04rRDhx?=
 =?utf-8?B?SFAzMmJBbjRJUUt2ZlZxMGo2Zy9rWXYzaTR6UWZFL1hzaU44dU1iQkxOT1Zi?=
 =?utf-8?B?L3grZGNDTVBOQVRYK2ovMVJkdWV0QmQvMGQyMWgxT0VqckpFaU5jczI5T1hP?=
 =?utf-8?B?OVhZd3NvUTdwdm5jMk1YbU1EcEFhK0l4bkU5NFVoREVxdjQ2REdWM3RnZDFY?=
 =?utf-8?B?azA2clJtYmlRSjVXUzVpTnJEYXFiSVBTaklxQTNkamVDdDJqOGRpQTQvd0E1?=
 =?utf-8?B?YUxpbEVqajdYbGtWK0VNTkN2S1JucDVqcnpBTnUzRzVzTkd3ZFByanZCbDZK?=
 =?utf-8?B?a2p3VEFDYjRJTmRMWm0xZEloZ2xOZjdLUDI5VEhuZTE5RStuZkJJbTBQSngw?=
 =?utf-8?Q?ww37ksfmi7kWzR+6MhQCjJqHEGgrqozt019pdR8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada6a0f6-f340-44e0-3f05-08d95d5ce07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 06:46:13.3274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaIl97C1bd0CAPbSu2B0eljsvCsQwfm60EBoWKAimeDrgT8+OsPHScPherQJF9GA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4812
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
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSAyOjE2IFBNDQo+IFRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBuaWxzLndh
bGxtZW5pdXNAZ21haWwuY29tOyBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgNi83XSBkcm0vYW1kL3BtOiBkcm9wIHVubmVjZXNzYXJ5
IG1hbnVhbCBtb2RlDQo+IGNoZWNrDQo+IA0KPiANCj4gDQo+IE9uIDgvMTIvMjAyMSA5OjMxIEFN
LCBFdmFuIFF1YW4gd3JvdGU6DQo+ID4gQXMgdGhlIGZhbiBjb250cm9sIHdhcyBndWFyZGVkIHVu
ZGVyIG1hbnVhbCBtb2RlIGJlZm9yZSBmYW4gc3BlZWQNCj4gPiBSUE0vUFdNIHNldHRpbmcuIFRo
dXMgdGhlIGV4dHJhIGNoZWNrIGlzIHRvdGFsbHkgcmVkdW5kYW50Lg0KPiA+DQo+ID4gQ2hhbmdl
LUlkOiBJYTlkNzc2MTQxZWM0YWEzOTI1NWFjY2JmMDBkN2U3ZWQ4MWM4NDI0ZA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFfMC5jIHwgMTIgKy0tLS0t
LS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDExIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTEvc211X3YxMV8wLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvc211X3YxMV8wLmMNCj4gPiBpbmRleCA5MDAxOTUyNDQyYmEuLjIwZWNlMDk2M2Y1MSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFf
MC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjEx
XzAuYw0KPiA+IEBAIC0xMjA4LDkgKzEyMDgsNiBAQCBzbXVfdjExXzBfc2V0X2Zhbl9zcGVlZF9w
d20oc3RydWN0DQo+IHNtdV9jb250ZXh0DQo+ID4gKnNtdSwgdWludDMyX3Qgc3BlZWQpDQo+ID4N
Cj4gPiAgIAlzcGVlZCA9IE1JTihzcGVlZCwgMjU1KTsNCj4gPg0KPiA+IC0JaWYgKHNtdV92MTFf
MF9hdXRvX2Zhbl9jb250cm9sKHNtdSwgMCkpDQo+ID4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
LQ0KPiANCj4gVGhlcmUgaXMgYSBGQU5fQ09OVFJPTF9OT05FIG1vZGUgd2hlcmUgaXQgaXMgc2V0
IHRvIGZ1bGwgc3BlZWQuIElzIHRoYXQNCj4gYWZmZWN0ZWQgYnkgdGhpcyBjaGFuZ2U/DQpbUXVh
biwgRXZhbl0gVGhpcyBjaGVjayB3YXMgZGVzaWduZWQgdG8gYmxvY2sgImF1dG8iIG1vZGUobGlr
ZSBJZiBpdCB3YXMgdW5kZXIgYXV0byBtb2RlLCB0aGVzZSBtYW51YWwgc2V0dGluZ3Mgd2lsbCBi
ZSBub3QgcGVybWl0dGVkKS4NClRoZSBGQU5fQ09OVFJPTF9OT05FIG1vZGUgaXMgbm90IGFmZmVj
dGVkIHdpdGggYW5kIHdpdGhvdXQgdGhpcyBjaGVjay4NCg0KQlINCkV2YW4NCj4gDQo+IFRoYW5r
cywNCj4gTGlqbw0KPiANCj4gPiAgIAlkdXR5MTAwID0gUkVHX0dFVF9GSUVMRChSUkVHMzJfU09D
MTUoVEhNLCAwLA0KPiBtbUNHX0ZET19DVFJMMSksDQo+ID4gICAJCQkJQ0dfRkRPX0NUUkwxLCBG
TUFYX0RVVFkxMDApOw0KPiA+ICAgCWlmICghZHV0eTEwMCkNCj4gPiBAQCAtMTIzNywxMSArMTIz
NCw2IEBAIGludCBzbXVfdjExXzBfc2V0X2Zhbl9zcGVlZF9ycG0oc3RydWN0DQo+IHNtdV9jb250
ZXh0ICpzbXUsDQo+ID4gICAJICovDQo+ID4gICAJdWludDMyX3QgY3J5c3RhbF9jbG9ja19mcmVx
ID0gMjUwMDsNCj4gPiAgIAl1aW50MzJfdCB0YWNoX3BlcmlvZDsNCj4gPiAtCWludCByZXQ7DQo+
ID4gLQ0KPiA+IC0JcmV0ID0gc211X3YxMV8wX2F1dG9fZmFuX2NvbnRyb2woc211LCAwKTsNCj4g
PiAtCWlmIChyZXQpDQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPg0KPiA+ICAgCS8qDQo+ID4gICAJ
ICogVG8gcHJldmVudCBmcm9tIHBvc3NpYmxlIG92ZXJoZWF0LCBzb21lIEFTSUNzIG1heSBoYXZl
DQo+ID4gcmVxdWlyZW1lbnQgQEAgLTEyNTcsOSArMTI0OSw3IEBAIGludA0KPiBzbXVfdjExXzBf
c2V0X2Zhbl9zcGVlZF9ycG0oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4gICAJCQkJICAg
Q0dfVEFDSF9DVFJMLCBUQVJHRVRfUEVSSU9ELA0KPiA+ICAgCQkJCSAgIHRhY2hfcGVyaW9kKSk7
DQo+ID4NCj4gPiAtCXJldCA9IHNtdV92MTFfMF9zZXRfZmFuX3N0YXRpY19tb2RlKHNtdSwNCj4g
RkRPX1BXTV9NT0RFX1NUQVRJQ19SUE0pOw0KPiA+IC0NCj4gPiAtCXJldHVybiByZXQ7DQo+ID4g
KwlyZXR1cm4gc211X3YxMV8wX3NldF9mYW5fc3RhdGljX21vZGUoc211LA0KPiBGRE9fUFdNX01P
REVfU1RBVElDX1JQTSk7DQo+ID4gICB9DQo+ID4NCj4gPiAgIGludCBzbXVfdjExXzBfZ2V0X2Zh
bl9zcGVlZF9wd20oc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+ID4NCg==
