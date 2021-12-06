Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026D2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB2D7AEAE;
	Mon,  6 Dec 2021 10:21:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCAB073C36
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 06:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjsrZZAg2RBY2phdfP9Ij8ZZCkA5wn5pnAfDxXpP5/7IgXBR8NtGO/AzVy8z0F6ZWjysm5btRa15kubk58w0rPAIHSTe81KX91jCW7deTto7ym6PL5TPApvA6JgUTJkcxrAGCReOndM6T8LqmsU1cdySNABr0KuqGe4+j+iCQ1zLWS6PhiOGlZktGX2zEwcLhUnT9WTGzTsr0da4JBwmKSZVnx5RulgOqtVGN2LX8+mdjllo7FGXgw30bsyEhjrTrP583g0Jp12mE2YKhbP59VfmJLwFdAf3Fpb2m5bLLz81qa45OafoyGUohYLNo1jFm4knjB7SMNFrNsx0C/Jvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwYWGiNTJGAdRO2CouogZFkMWFW+tnzlWfIBTxix1jQ=;
 b=Bxu9CUJPpVj6dyJDVQUy4MLrCA/cyH1UB7Dambr8lR91qP21d/WPKEl3eEBkFZ5nlOgEiEXWk3O35ccVjD7lWZcIL+dutQMy63Rrxb6xudCYwUFKCIzWzDLti+bOhOsAE4LMpewR80WYtiM2m+XpZtwTRp9eXs5v9MgK/V22wrBa1+Qd/Eb/5amJf+2i0mL/u1Vb+jUmZZmWkm9lyEtqUe4QUvco9mhuxVTQzfvJP//VJtFRMv/tbA1CWpDpGHGu3kwGY9BDVvVh1FZ7yadjxOLeLHgPyzU+iJYqDfC6bxivD1fNQgwXaKuu3qXuA73umw858d6KRsPjJPX67mZOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwYWGiNTJGAdRO2CouogZFkMWFW+tnzlWfIBTxix1jQ=;
 b=TLv+cMScIOy7uc2g0nw1/cmRUgvcOzqLuL1m9WpYcOOEnYf5u7fjRDZk6ty8X388OKQDl+xcCwa2SciaFAge7HXov6DUWQeMi2HC3mdv+dp3ATJ0rkeoHb1NEG5Ensw5H8IgNLymDzaBVKkUNhgqGjRG6l1bJP0ID+wcyUt6kEI=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Mon, 6 Dec 2021 06:47:13 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 06:47:12 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when
 dpm is disabled
Thread-Topic: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
 when dpm is disabled
Thread-Index: AQHX6BKd6VxxmsBvHECw3m2gr5Y+dqwghsoAgAQ/fRCAAA/YgIAAMWnw
Date: Mon, 6 Dec 2021 06:47:12 +0000
Message-ID: <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
 <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
In-Reply-To: <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-06T06:38:14Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7dbe8117-c56d-46d2-a862-6fe557c43f50;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-06T06:47:10Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3fd86806-223d-40d5-8d72-cde9a173104c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 952bd8f9-aa8a-45a0-00c6-08d9b8843be3
x-ms-traffictypediagnostic: DM5PR12MB2488:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2488048AD57BB33B0B8FE090FB6D9@DM5PR12MB2488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLJdSigqqGrNn1BOAl4H/J0a4AJjsH6CwNLQgN16CPu1d+Y3zLssPcyQSK2X96qb+On7JbMzMV58PLn0vZKVzIcYj6Y7SSx/pvZCz/deWwwB/kjRmsjGxDg5aTxcL3flj5nzppN1kfcqYbjWtKBMuZ787DdLfT8D9y5bFH1fQCrXKPtPTVJA0WOJoxdU3XECPPWco7Mt9+guTEMfUVX5iPahxaHSi2oeWL3zS4yi+utbi+MCyht0L2iMHWuX2/hqdDAD/ub//6+WYLu43nlZ/WvFkHQ+chLyMUuGv1w/xUuSiUsTXUQqt+pJ6SaWHjtHN5k5aFrDrMzKCNp4oM/UeZKBG1Vyp2w9hqLRvaQscmlXqzTjzXHw9HEThd4F0vUbhXe2hhlqWDk+lNRkIalJQNPaEe9yeXwi1s72bJN7Jb26W5RNWz0uY/Ysh8lO9Sqc5WwnsFwKEzvn9ObfGDNXyt2yTXXy+HdjvKdKslJoSz2cx3vpbszFHnabtKCRI1kaNj+Lyot+dqrDZQazug0WT0mIXC02bQOKybDEzVophaj9dO3k5+MlcB4VOo94ja3EL+yM8QvwSSrYYc0blM/Pt9KRfVyVZfzdir1GfCGBFy80g/PXb9uU1AnMOjVX7bqY506EWo8jcPzIR2WmP4U2Ko8PL8jTb/QNSxI4+5VaXBNEoh1wwdd3GYNCMpmrGpqg0yMvPRxRGkddFQi+NrBQAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(33656002)(71200400001)(6506007)(66556008)(186003)(83380400001)(66476007)(316002)(8676002)(76116006)(7696005)(53546011)(508600001)(54906003)(15650500001)(66946007)(122000001)(86362001)(38070700005)(55016003)(5660300002)(26005)(66446008)(52536014)(2906002)(110136005)(8936002)(9686003)(4326008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2k3LzZSQUxlNmVlK0lianZONFVDQThYMXIyQkIxdkNaWDdFYVp4MElKbFI1?=
 =?utf-8?B?amJsczdlQzdtRFkvcUlyRzNQeXg1V1ExQUFvRzJkWEo5WWhmYmpyL1ZaYUY2?=
 =?utf-8?B?dXhBL0V6a3gvNUsxMU1QOXFkTVdjeXAvYkNOTWdpZU1LRlBoZmhPNzJkS2lz?=
 =?utf-8?B?ZklBSWR6TFJhMzd4SGdqQVZxU1FESmc5OUtXVTErbWN4YlFIUHZtWDRBVnRS?=
 =?utf-8?B?dktOdDU5R29mWklySDY4YlVQakZlUEczaDBhY2REc1JsUXM5MjBFdHdNNWJj?=
 =?utf-8?B?SHlzKzd4WVk4T3Y1MkRKMmRqcmVIVW1uM1R3TFZtakliaFExM3N2T2xzT2py?=
 =?utf-8?B?d2F6SFQ5M1NVMzhrR3JKMHdtN3E5ZmhQWWV3WUdFRUNGWjVHajFrQXBPVmV5?=
 =?utf-8?B?djNkSGZQUHBpN0RFWjRHd2dhUzJVSzRMY094UzJWMGpraVRzeldheHJUVXlO?=
 =?utf-8?B?OW5zZDBlblp6M1FDK21RT3g2aVh4K2hpZGlPdC9PakhEdjNCWCs3cnBaSFZO?=
 =?utf-8?B?ZE52TnJ0MEQvdWdPWE4rd2ltTk9CL1BiS3NxcXhCaHVCMCtYS0dUbzNWQ1Z6?=
 =?utf-8?B?eUpVbnZXVjhTc3o2emcrbTdoU05rTGh3ZG5IUGdnM1NoWUxyVFRYaWlyQThZ?=
 =?utf-8?B?VExpZDhDeUg2VHptd2txRFNqTHUzMEhUaVg0Ris3b2FBdFRGWVdIMWMrTnJD?=
 =?utf-8?B?SW1NYkNxUlRkM2pFbXFsQmFwckh6cTNHTG1aSzBqVmFQZTFyZU1odjgyV1c4?=
 =?utf-8?B?djAzS0NZR0c3R0MvQUFJOWl1Uk5ISk9GNnJjb2hsL3RGMFliR3pzNzRDS2x5?=
 =?utf-8?B?Qlc3akpmbmtoczc1SFA0bjRhU0VLYVJ2V0tYWXkzTStCRS9Iemc5N0VXZkxS?=
 =?utf-8?B?ZGQraUFJcUZVK0dUNTBaRExTMUtoRFpxTWpyeUE5QmNjVmZKUFlaVHNPZm9x?=
 =?utf-8?B?NDFwRGpoYXVoeEpEMm1MQm9FQU01T3dQdVNHdnZYWmdUQ3BOelhLQzVMWHQv?=
 =?utf-8?B?UjRreTNpQnZYR0RHZFNXK2VjSU8xSUZ6a1JCUTBZZTV3ZDhvTVJhdm9USnB3?=
 =?utf-8?B?SzNqalFQRllmcUQ2WmkxajBYNCtOWGlEek9TRUF4cWNjOTFBTzlyaHRoMHRl?=
 =?utf-8?B?SnN6S1MvZko5QXpiZlJwZVIxNEVNN3EzWWlrbkhUU0d4WGEvaXdka0lGN1Ft?=
 =?utf-8?B?ZTUxZUVhNDk2Ym5INkFVaVU3My9LRnpvQWkxT0lKYnZnb0RkejM1ZlBRRU9U?=
 =?utf-8?B?K2wrSmZ0cUJUMktLMDJ2Q21iZWwxTVVLZERvYTNLaEdVdVJBckNLSWZ6b093?=
 =?utf-8?B?bi8xZng3UmNLTGJWVjQ2QWVIdXNJeDI2WlQxYUNXcm5hRXhkRks5bkRpRjBa?=
 =?utf-8?B?SlZoRWR2UmdPbW0raURWWmd3NXhQdjlhWHlKTmxMYzFKUkpPdnpIY1J0L3dE?=
 =?utf-8?B?czl5Ui9LNTNEeUJVTDhURlZPOXhQdFRWK3FZSXBtUVNYMm9TdFBrQVVnUE93?=
 =?utf-8?B?c3RKRnlmK0Y0eHo2ejY1NWhzanNQMzlLT3AyT3R6bk41Qmx5V1d4emc1K1Vl?=
 =?utf-8?B?aHZCMTA0WXpWU25tcXVxYTFRc0R6OWhrVXp0d0FRVk5vQjFUYXpQN0lWVWNr?=
 =?utf-8?B?T1FTV0VsZmxsREt6alFSUWNaRXI5eGovV3FPSzlXZHVDallZSnVrS0VDOS9D?=
 =?utf-8?B?YzZSVFFEa1gxL0REOFBOVE5zTEU1VkU0ekFtUmx3c2tTenUvMTErVHQzWUkx?=
 =?utf-8?B?dWRXa3hvQUdyWnI1cm1mb0xsdTBOMy91eHZNb2JyY0V2MHB5cEsrbmJ4aHdw?=
 =?utf-8?B?VDd5cTRPN3poQjdYV3E2VUFZQUVGclZQb0IyZmxyTEFHRXROSEZPUzJqUC9B?=
 =?utf-8?B?U00yQW0wNitNei96Y1FINmVYVE1POTgxbG5ZZlRkV0J3WGlWa1Z1c2hGcjkx?=
 =?utf-8?B?N21oWGlZaWxXWmQ2eWYzWk9GKzgyK3NTY3JjRDNHb1MrUk9CdzRWVTdIem5Q?=
 =?utf-8?B?czgxQXFXU2Rtb1JKcGVTdmZBMGM1RHBYemFYbk9NMndEbHdaSnBlUHJTckJk?=
 =?utf-8?B?MzVIcUI2elQ5V3pxcVZ2UGMwZWZnbTcvMjNFN0FmaWtVMzZod1ltWlNCaFA2?=
 =?utf-8?B?YUJXSlZOSTRQa0k5QjJPY0V0WnpWb0w2WEtpbXJ0MmpxM0l5UnRramZvdEdk?=
 =?utf-8?Q?IaRw3njvL0vWlDE1wolr0W0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952bd8f9-aa8a-45a0-00c6-08d9b8843be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 06:47:12.7909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDNqp5WZ4jfsravGGkqLmXIsr6M6UWAGduEdyp3dfOxYuegbJVqvCv3TAcYLm4J5O6I5CwtZwpFU2TSJ4MovhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2488
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExhemFy
LCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+U2VudDogTW9uZGF5LCBEZWNlbWJlciA2LCAy
MDIxIDExOjQxIEFNDQo+VG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgUmF5DQo+PFJheS5IdWFuZ0BhbWQuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBhbGxvdyBBUFUgdG8gc2VuZCBwb3dlciBn
YXRlIG1lc3NhZ2UNCj53aGVuIGRwbSBpcyBkaXNhYmxlZA0KPg0KPg0KPg0KPk9uIDEyLzYvMjAy
MSA4OjE5IEFNLCBZdSwgTGFuZyB3cm90ZToNCj4+IFtQdWJsaWNdDQo+Pg0KPj4NCj4+DQo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5M
YXphckBhbWQuY29tPg0KPj4+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMywgMjAyMSA1OjUyIFBN
DQo+Pj4gVG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+OyBIdWFuZywgUmF5DQo+Pj4gPFJheS5IdWFuZ0BhbWQuY29tPg0KPj4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBhbGxvdyBBUFUgdG8gc2VuZCBwb3dlciBn
YXRlDQo+Pj4gbWVzc2FnZSB3aGVuIGRwbSBpcyBkaXNhYmxlZA0KPj4+DQo+Pj4NCj4+Pg0KPj4+
IE9uIDEyLzMvMjAyMSAxMjoyNCBQTSwgTGFuZyBZdSB3cm90ZToNCj4+Pj4gVGhlIGdlbmVyYWwg
aHcgZmluaSBzZXF1ZW5jZSBpcyBTTVUtPiAuLi4gLT5TRE1BLT4gLi4uDQo+Pj4+IFdlIG5lZWQg
dG8gc2VuZCBwb3dlciBnYXRlIG1lc3NhZ2UgdG8gcG93ZXIgb2ZmIFNETUEoaW4gU0RNQQ0KPj4+
PiBod19maW5pKCkpIGFmZXIgZHBtIGlzIGRpc2FibGVkKGluIFNNVSBod19maW5pKCkpLiBBbGxv
dyB0aGF0IGZvciBBUFUuDQo+Pj4NCj4+PiBUaGlzIG1lc3NhZ2UgaXMgbm90IHJpZ2h0LiBJbiBB
UFVzIHRoZXJlIGlzIG5vIG1lc3NhZ2UgcHJvdmlkZWQgYnkgRlcNCj4+PiB0byBlbmFibGUvZGlz
YWJsZSBEUE0sIGl0IGlzIGRvbmUgaW4gQklPUy4gUmVwaHJhc2UgdG8gc29tZXRoaW5nIGxpa2UN
Cj4+PiBhZnRlciBzbXUgaHdfZmluaSBpcyBjb21wbGV0ZWQuDQo+Pg0KPj4gSXQgaXMgcG93ZXIg
b24vb2ZmIFNETUEgbWVzc2FnZS4gTm90IGVuYWJsZS9kaXNhYmxlIERQTS4NCj4+DQo+QmFkIGNo
b2ljZSBvZiB3b3JkIDopIEkgZGlkbid0IG1lYW4gRlcgbWVzc2FnZSwgaXQgd2FzIGFib3V0IHRo
aXMgbGluZSBpbiAiY29tbWl0DQo+bWVzc2FnZSIgLSAiYWZlciBkcG0gaXMgZGlzYWJsZWQiLg0K
DQpPay4gSSBnb3QgaXQuDQoNCj4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8
bGFuZy55dUBhbWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9hbWRncHVfc211LmMgfCAyICstDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPj4+PiBpbmRleCAyZDcxOGMzMGM4ZWIuLjI4
NWEyMzdmMzYwNSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9hbWRncHVfc211LmMNCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9h
bWRncHVfc211LmMNCj4+Pj4gQEAgLTI3Nyw3ICsyNzcsNyBAQCBzdGF0aWMgaW50IHNtdV9kcG1f
c2V0X3Bvd2VyX2dhdGUodm9pZCAqaGFuZGxlLA0KPj4+PiAgICAJc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUgPSBoYW5kbGU7DQo+Pj4+ICAgIAlpbnQgcmV0ID0gMDsNCj4+Pj4NCj4+Pj4gLQlpZiAo
IXNtdS0+cG1fZW5hYmxlZCB8fCAhc211LT5hZGV2LT5wbS5kcG1fZW5hYmxlZCkgew0KPj4+PiAr
CWlmICghc211LT5wbV9lbmFibGVkIHx8ICghc211LT5pc19hcHUgJiYNCj4+Pj4gKyFzbXUtPmFk
ZXYtPnBtLmRwbV9lbmFibGVkKSkgew0KPj4+DQo+Pj4NCj4+PiBUaGlzIGNoZWNrIHdhcyB0aGVy
ZSBiZWZvcmUgYWxzbywgb25seSB0aGUgV0FSTiBpcyBhZGRlZC4gVGhhdCBtZWFucw0KPj4+IGl0
IHdhcyBza2lwcGluZyBzZW5kaW5nIG1lc3NhZ2VzIGluIEFQVXMgYWxzbyBhbmQgc28gZmFyIHRo
aXMgd2FzDQo+Pj4gd29ya2luZyBmaW5lICh1bnRpbCB0aGlzIGdldHMgbm90aWNlZCBiZWNhdXNl
IG9mIHRoZSB3YXJuaW5nKS4NCj4+Pg0KPj4+IE5vdyB0aGlzIHdvdWxkIHRyeSB0byBzZW5kIHRo
ZSBtZXNzYWdlIHRvIEFQVSB3aXRob3V0IGFueSBjaGVjay4gVGhhdA0KPj4+IGRvZXNuJ3QgbG9v
ayBnb29kLiBJZGVhbCB3YXkgc2hvdWxkIGJlIHRvIGZpeCB0aGUgc2VxdWVuY2UuDQo+Pj4gT3Ro
ZXJ3aXNlLCBzdWdnZXN0IHRvIGRvIHNvbWV0aGluZyBsaWtlIGJlbG93IGFzIHRoZSBsYXN0IHN0
ZXAgb2Ygc211DQo+Pj4gaHcgY2xlYW51cCByYXRoZXIgdGhhbiBzZW5kaW5nIHRoZSBtZXNzYWdl
IGJsaW5kbHkuDQo+Pj4NCj4+PiAJaWYgKHNtdS0+aXNfYXB1KQ0KPj4+IAkJc211LT5wbS5kcG1f
ZW5hYmxlZCA9IHNtdV9pc19kcG1fcnVubmluZyhzbXUpOw0KPj4NCj4+IHNtdV9pc19kcG1fcnVu
bmluZyhzbXUpIHdpbGwgY2F1c2UgZXJyb3JzIGluIHN1c3BlbmQuDQo+Pg0KPlRoYXQgaXMgaW50
ZXJlc3RpbmcuIFdoYXQgaXMgdGhlIGVycm9yIHlvdSBnZXQ/DQoNCltkcm06YW1kZ3B1X2RwbV9l
bmFibGVfdXZkIFthbWRncHVdXSAqRVJST1IqIERwbSBlbmFibGUgdXZkIGZhaWxlZCwgcmV0ID0g
LTk1DQpUaGF0IG1lYW5zIEVPUE5PVFNVUFAuDQoNCkFjdHVhbGx5LCBpbiByZXN1bWUgcHJvY2Vz
cywgYnV0IGFkZXYtPmluX3N1c3BlbmQgIGlzIHN0aWxsIGZhbHNlLg0KRm9yIFJlbm9pciBzZXJp
ZXMgQVBVLCBzbXVfaXNfZHBtX3J1bm5pbmcgaXMgaGFyZGNvZGVkIGFzIGZvbGxvd2luZywNCg0K
c3RhdGljIGJvb2wgcmVub2lyX2lzX2RwbV9ydW5uaW5nKHN0cnVjdCBzbXVfY29udGV4dCAqc211
KQ0Kew0KCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gc211LT5hZGV2Ow0KDQoJLyoNCgkg
KiBVbnRpbCBub3csIHRoZSBwbWZ3IGhhc24ndCBleHBvcnRlZCB0aGUgaW50ZXJmYWNlIG9mIFNN
VQ0KCSAqIGZlYXR1cmUgbWFzayB0byBBUFUgU0tVIHNvIGp1c3QgZm9yY2Ugb24gYWxsIHRoZSBm
ZWF0dXJlDQoJICogYXQgZWFybHkgaW5pdGlhbCBzdGFnZS4NCgkgKi8NCglpZiAoYWRldi0+aW5f
c3VzcGVuZCkNCgkJcmV0dXJuIGZhbHNlOw0KCWVsc2UNCgkJcmV0dXJuIHRydWU7DQoNCn0NCg0K
U28gd2UgZ290IHN1Y2ggYW4gZXJyb3IuDQoNClJlZ2FyZHMsDQpMYW5nDQogIA0KPlRoYW5rcywN
Cj5MaWpvDQo+DQo+PiBIZXJlIHdlIGp1c3QgIHNlbmQgc29tZSBJUCBwb3dlciBvbi9vZmYgbWVz
c2FnZXMuDQo+PiBJcyBpdCBuZWNlc3NhcnkgdG8gZW5hYmxlIERQTSB0byBzZW5kIHN1Y2ggbWVz
c2FnZXM/DQo+Pg0KPj4gUmVnYXJkcywNCj4+IExhbmcNCj4+DQo+Pj4gVGhhbmtzLA0KPj4+IExp
am8NCj4+Pg0KPj4+PiAgICAJCWRldl9XQVJOKHNtdS0+YWRldi0+ZGV2LA0KPj4+PiAgICAJCQkg
IlNNVSB1bmluaXRpYWxpemVkIGJ1dCBwb3dlciAlcyByZXF1ZXN0ZWQgZm9yICV1IVxuIiwNCj4+
Pj4gICAgCQkJIGdhdGUgPyAiZ2F0ZSIgOiAidW5nYXRlIiwgYmxvY2tfdHlwZSk7DQo+Pj4+DQo=
