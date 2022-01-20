Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 20:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D635210E356;
	Thu, 20 Jan 2022 20:02:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE3510E3EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 20:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoMYHW19nlK3MZm3RzZtE5ENSxUuQm7v2bfwY2qV4Wg/5ukXtjJy+KV75ABDuLk6u8NzAjEVWzKwcOuU4yvtQ9y7KHtf+JrZaB8xeS/HPcRFezYxMLx+H7Urbtp24jMy09/pSbkB9zoB+reD4lqHGRJ58xa5Jtc+TV74wQ6RCe87Orhwbdg42I85Tn7Wtt1n3tuOf7jBPiqTRjdD0Irq8agqVqtizcT3vj7TIptFKi+Wfy/Fb+gd9eIntfMTf4hF/e+8kUqOm9d1hvMhN/GVz4eV4bSPpp00wVY1PVb2/eH8iiCSlrC2rqMHPWhcSKlDAhy0jp2gtaR6/jhuL/Cs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6VPFg8SotjLYDSboYgWmqDv+MH/KM/DAJ57o03XjfM=;
 b=dRBMT6VBuXvBq2506b9KBCuJxgzj1URVpj6ydtTrTeAZ6E3pDma/UKcW2dhysWB+eMhAthJ7GvJV5gOGvJwXjJLsSViVvIaDIbickzYXh+P0JJtA3GUqfpSqR9gJxIaWhE1wZ0KEDL52Yr9osfJx8nHnSdWGf1BlQXZmhWj3/gOuXtRACsOoJzK2ahx0Lat4+rtptOjjgGmEO/yz0LIsp3ijZYV40AwdDl2TK/i9Q7h7Kut1SoRYBuE+91ZJSfOp+mMZvJTlgdOogx1vsusHb9bXz7/uKsH1XHTbjQpiWY6/HCitnmGtV+Qb4VMHO9gbBGu/8ojczAme/BntIwMy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6VPFg8SotjLYDSboYgWmqDv+MH/KM/DAJ57o03XjfM=;
 b=0HeKTJBL6M7KsjmIFRYG9EXWSN0X04clWgmvnac4ugUNsSQfC1n6D29hRGN3lZLyP5E5nRQ0BQpH5H3WIchVnVJjBolfh8a6ewFtqSyWSwXytLd4n9Lwq6gWaBU3Vq4fAyVsB54JB/lttXNzWLGk6dzUK1owiI8ycJKcAuMNBmY=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by BN9PR12MB5193.namprd12.prod.outlook.com (2603:10b6:408:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 20:02:00 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::614e:f156:68e8:bdbd]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::614e:f156:68e8:bdbd%4]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 20:02:00 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Topic: [PATCH] drm/amd/display: Not to call
 dpcd_set_source_specific_data during resume.
Thread-Index: AQHYBgFyS5MCmRNJKUqsQta1vZWUxaxcc1WAgAEBCYCAAI0TAIAOW7uAgAAFgvA=
Date: Thu, 20 Jan 2022 20:02:00 +0000
Message-ID: <DM6PR12MB4156B5A0F56BA4A2CA6F5167FD5A9@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20220110090652.3759559-1-rajib.mahapatra@amd.com>
 <44d54537-82b6-b1aa-c9a6-8dc6b16440e0@amd.com>
 <BY5PR12MB46434EFB35BC0F88E63B30E3F2519@BY5PR12MB4643.namprd12.prod.outlook.com>
 <bd73c50e-4a55-8943-d1d9-2b279d39e66f@amd.com>
 <MN2PR12MB41731529058B7DD886A883E0F25A9@MN2PR12MB4173.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB41731529058B7DD886A883E0F25A9@MN2PR12MB4173.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T19:53:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=db656518-5bac-44f4-a7e9-ff82ff482a86;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-20T20:01:56Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 40660165-ae98-44e5-88d9-d0495464299f
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cdd8368-c2a0-43a3-40ba-08d9dc4fb86e
x-ms-traffictypediagnostic: BN9PR12MB5193:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5193C39B42484BFDBB1D0396FD5A9@BN9PR12MB5193.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MxY4IZ66y4LAw6rGYkIo6jpyiZA0eEC+wxWgGuo+JT3WJx1yBSfMM+pMXUnsVe2cbAjnI1ijdU6BJWHS/HVjFs/Dv49dn50qu0TprIjV33bgI5TgtdMIoFatyNxDG0dlSbaAfYRqe0lmNgxLgD45hya7qE8/rMVSpQFbK9bxn1n9spoiaeJy7uDekueskFX195cExgXNVDrtVUVKlwqAKACUzw4irnR7V/XqLRpx5TaOyErLmHQum2swaSSNrxVjd13vx/3bylPoqZ+RolRSb8ZY26tXK2xrrTwXm7dHyi9jeHIOaHssGoR9l6Ta4HngbTmysqP6pCzdpyPb6bA4GS1QiQaxXiJCX+Jb0uuKG7Dnv5zr2IfQI3COKD5+EWhZo+PWna462NZQxhfmoFhpNve3xVf5DEQVbj6OAaJMepKAeeKUsP//BMFnqmqs3aKSndSOp8m5quf51Mi0FWYqxVmysM0PByoejsVaFIZkAaJTp13A2rpy4QNslHrg4VMQSwfJqFszwHBBZWzSPbRVrl6u8zVB40CnExO5+Jit4RSqf/H0KknYdmYP6iA3vXbBLMPQjrPiLlay6JBep/DSvNIopK8B1PEjhlFjUTB+2tYETnNMJ71ktZVhtncCEbaPbPyTiLnlShIbX6Bor76tdv04cMJINfkCo5EPRs6pMBQadLhQqfCK+9m0D4MnpTxeVuZ46/MlvKRmH1zMqHEjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(9686003)(66946007)(71200400001)(86362001)(64756008)(66476007)(66556008)(66446008)(55016003)(8936002)(38070700005)(7696005)(8676002)(33656002)(53546011)(26005)(6636002)(508600001)(6506007)(38100700002)(122000001)(76116006)(52536014)(316002)(186003)(4326008)(83380400001)(5660300002)(54906003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW5jZ2xqa1JOd0lxek9YNFRlM05teXRSM1JQZk16NFRBS2w2bTNsNm0yVlJJ?=
 =?utf-8?B?YklPaUI3MEtSTUdYYlBPME9GM1diMC9qS016ZWY5OVdqa3l1R2VYNDNvMUpR?=
 =?utf-8?B?SGJnVjdmQ21GdUZibnBVakhuSGlUbldkT1ZqMkZBVVJYRDZGOFRUZ3VmTnR1?=
 =?utf-8?B?MFNqQUhYRENQdzg3NnFvckpwUldlUDZLK2Nlc2VlazNLb0MwSTdFcEpObkxu?=
 =?utf-8?B?ckVCcDhmY2FJWEhYZWs4NW8ycDFIYXI5d1N6T0ovVFFJL0VaekhSbzdETFlj?=
 =?utf-8?B?cWNaSzNOaTV4Y3M0dFFyTUxhdkEzaFhMSU9zQWNGVEFEUlc0VjhGM0lFOEsz?=
 =?utf-8?B?aUVBakdFUXUrbFZxdEEzN2F0OU1kazlpZHlOM3FFcDgyZ1djSEN0S1ppWUdn?=
 =?utf-8?B?SU41T1ovRDZlOThGcWsvZnRlNXJJTmhLM2EzTG9NRDZhVnl0cEU3OHFHQ05S?=
 =?utf-8?B?Z0dzL2xIWGpHaHNkN2paMWlGZ0ZlMXhpRzNWVzVOMER0b0RZUXZvaUZKaTBy?=
 =?utf-8?B?OU1DL1ZqZmE5VnZIbmFjc044RlZUYkRJVnQyWjEvN0gyNjVjVXFLbmJDc3Vt?=
 =?utf-8?B?bEJ0RGhQWitsWEhNN3VqaStqMytKZ0xJOSsyRk1VL3pBc1ZZSmN5aURzT1Vq?=
 =?utf-8?B?Q0pjUGtjdk1QWmRaTnNybjJJZElyR2xBMnlIcmJodHB3YzRmYkFDcE5Rd20x?=
 =?utf-8?B?ak15bGZ5L3RqUU1tMEtPdEJLSXhGVnRQdURIYlpQbk9QTWpOK0txaHdrOEZI?=
 =?utf-8?B?ODNOSnR1RllkcmdiZ3RFV3NsMGZocHJCVm9GS3Y3MFkrUlYvaHl1MnF6dmkx?=
 =?utf-8?B?VVdpd2cxL05VdUlkVm1waWJuYUNucGgxWmgxWkZkLzhXWkJYNXNneldJVmVn?=
 =?utf-8?B?Z1kzWWplbzY5WmY1VklnUFZjTUJVZEpNU2ZLL3FBYURFbHN2cVZkUXVUMHUv?=
 =?utf-8?B?UmZsM0VJNmVaYkFhUFhzaVNDU0pmZG9HckxkMFNZL2svVW1GdTY0YnhsLzRx?=
 =?utf-8?B?ZGFlK1JvRGtMTDlIR2RUY1NMRnNQRHZHcXByOWlsSFhrNzZqT2JTUk9xMEN1?=
 =?utf-8?B?Z0p0M0d4cU1CUXk5c3dMWHRzNFA3c3laVGZmc2sxQ0lWMyttYnl6TjFHNXBN?=
 =?utf-8?B?bGVjSWE4dXBkTkg0ZDNyNWQ2bGt6ZTlHckMrbHpUMmJ2NThKU3NsMW9UbnVq?=
 =?utf-8?B?Zk8rZG9IVlhmeVlCdGJicHlYTW9ZdTJmQ21BMDExZ1JLQVdmRDFPdHZQb1ZE?=
 =?utf-8?B?NUYzZHJhcnZNblJPNWRnYVFwQktCbGw1QkVrWS9LZ0pWcWIzS0MvK0Y0bU9i?=
 =?utf-8?B?M3R5OE90SDdKQjBiYjdBYmNLTzFXUU10ZDRadDNqdHFqa2gzU1VuWnB6R0U3?=
 =?utf-8?B?bitwTXRVR3J0RUk4SFlQVVZxekVTcjJmNUVJUFZIUUU1cFBvbnNndVZpMDBz?=
 =?utf-8?B?bTBwc2xwQkd5UDF1N1l3b3hUS0dURlBpNzhadkVXWG5NRi9oankyRWxsS1lG?=
 =?utf-8?B?L2lJQTBaUHJjL2tvT3ZYY2w1YURTbXhabTdGekNKNFJSOFZ1WmtEZHIyblQr?=
 =?utf-8?B?Y1Rxb2VKU3NlK3hBL3h3a3JPeDZZQzZFMXBuY3gvR0ZKTFg1TWZ4VVRlTzFq?=
 =?utf-8?B?ZDhzelg5dCtFK2J3RFpwWWZ0S0tKLzRxZ0FQemFmSjZXenRSU0RUZmZqN2V4?=
 =?utf-8?B?Mis0cmowU25aYWdTaWZnQ2l0dlIxV2NtWC9KQlE0WkpqRWdkOW1kK2ovY2hV?=
 =?utf-8?B?cXNOdWJmYlNmWUVlWmdjRUZCbCtFZitaVkgyWTkzWVkyNWtLd2d1Z3hPQm5H?=
 =?utf-8?B?L01lZThoeVNXN0NCWmpCd21HVWtqZ2twcHRyck90WWplaHF5UysySjk5Wmxa?=
 =?utf-8?B?MEZBL21iNmtyU2ZTQ3NlZGl6endzWUF6dHBZTm9VQWdOMFJiWXVSbTJhazBa?=
 =?utf-8?B?NTlMOTBuK2hpdi9uTWdZaVZQdU5INGFUL2NjMlNnTVQyb1NtOWlkZ2xLMG16?=
 =?utf-8?B?dEsyRWo3RFFjcmNLOHg1Y3BlTTdqb2ZyRk1MbWlZY2xpeTE0NCtGeUtmNTNX?=
 =?utf-8?B?c2lxcE84SU9zaVE0ajBTWWppZHI1Wjd5OHZrTG05bUlnUWlweHdYdDhwSEZJ?=
 =?utf-8?B?ZUhoMWI3aGRudFRUeG1DNGlIajh2c29UMEFNR1dtM25xeU5rcTVjSmxaU09x?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdd8368-c2a0-43a3-40ba-08d9dc4fb86e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 20:02:00.2990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrL6Lu/Xs+TMlnZi1ckGxs39t6GS/2qCv80YGr+dNCLGM9cQJYuK3mK89pJgL6ESU6EsdpXPjrQYy/FBSUYxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5193
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgUmFqaWIsDQoNCkZvciByZXN1bWUgZnJvbSBz
MyBvciBzaTAzLCB0aGUgY2hhbmdlIHNob3VsZCB3b3JrLg0KDQpSZXZpZXdlZC1ieTogSGVyc2Vu
IFd1IDxoZXJzZW54cy53dUBhbWQuY29tPg0KDQpGb3IgYm9vdCB1cCwgYXQgdGhlIGxvY2F0aW9u
IG9mIHlvdXIgY2hhbmdlLCBsaW5rLT5kcGNkX3NpbmtfZXh0X2NhcHMuYml0cy5vbGVkID0gMC4N
Ck9MRUQgY2FwcyBpcyByZWFkIGJ5IGRwY2RfcmVhZF9zaW5rX2V4dF9jYXBzIHdoaWNoIGlzIGNh
bGxlZCB3aXRoaW4gIGRldGVjdF9lZHBfc2lua19jYXBzLg0KDQpGb3IgYm9vdCB1cCwgd2UgbmVl
ZCBhbm90aGVyIGNoYW5nZS4NCg0KVGhhbmtzIQ0KSGVyc2VuDQoNCg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFoYXBhdHJhLCBSYWppYiA8UmFqaWIuTWFoYXBhdHJhQGFt
ZC5jb20+IA0KU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjAsIDIwMjIgMjozMyBQTQ0KVG86IFdl
bnRsYW5kLCBIYXJyeSA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IFd1LCBIZXJzZW4gPGhlcnNl
bnhzLnd1QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFMsIFNoaXJpc2ggPFNo
aXJpc2guU0BhbWQuY29tPg0KU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9kaXNwbGF5OiBO
b3QgdG8gY2FsbCBkcGNkX3NldF9zb3VyY2Vfc3BlY2lmaWNfZGF0YSBkdXJpbmcgcmVzdW1lLg0K
DQpIaSBIZXJzZW4sDQpJIGFtIHdhaXRpbmcgZm9yIHlvdXIgY29tbWVudHMgaGVyZS4NCkkgdGhp
bmsgd2UgY2FuIHRha2UgdGhpcyBjaGFuZ2UgZm9yIHJlc3VtZSBwYXRoIGF0IHRoaXMgbW9tZW50
Lg0KRm9yIGJvb3R1cCwgd2UgY2FuIGhhdmUgc2VwYXJhdGUgcGF0Y2ggZm9yIHJlc3VtZSBvcHRp
bWl6YXRpb24uIA0KDQpUaGFua3MNCi1SYWppYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFuZEBhbWQuY29tPiANClNlbnQ6
IFR1ZXNkYXksIEphbnVhcnkgMTEsIDIwMjIgOTo0NyBQTQ0KVG86IE1haGFwYXRyYSwgUmFqaWIg
PFJhamliLk1haGFwYXRyYUBhbWQuY29tPjsgV3UsIEhlcnNlbiA8aGVyc2VueHMud3VAYW1kLmNv
bT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgUywgU2hpcmlzaCA8U2hpcmlzaC5TQGFtZC5j
b20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6IE5vdCB0byBjYWxsIGRw
Y2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19kYXRhIGR1cmluZyByZXN1bWUuDQoNCg0KDQpPbiAyMDIy
LTAxLTExIDAyOjUyLCBNYWhhcGF0cmEsIFJhamliIHdyb3RlOg0KPiBkcGNkX3NldF9zb3VyY2Vf
c3BlY2lmaWNfZGF0YSBpcyBub3Qgc3BlY2lmaWMgdG8gT0xFRCBwYW5lbC4gIEl0IGlzIGNhbGxl
ZCBmcm9tIGJvb3QtdXAgcGF0aCBhbHNvLg0KPiBIZXJzZW4gV3UgaW50cm9kdWNlZCBpdCBpbiBy
ZXN1bWUtcGF0aCB3aGlsZSBlbmFibGluZyBPTEVEIHBhbmVsIGZvciBMaW51eCBpbiBiZWxvdyBj
b21taXQuDQo+IA0KDQpJZiB3ZSBzZXQgaXQgaW4gdGhlIGJvb3QtdXAgcGF0aCB3ZSdsbCBwcm9i
YWJseSB3YW50IHRvIHNldCBpdCBvbiByZXN1bWUgYXMgd2VsbC4gVGhvdWdoIEknbGwgbGV0IEhl
cnNlbiBjb21tZW50IHNpbmNlIGhlIGtub3dzIHRoaXMgcGFydCBtdWNoIGJldHRlciB0aGFuIG1l
Lg0KDQpIYXJyeQ0KDQo+IFNvIGhlcmUsIEkgZ3VhcmQgaXQgYnkgY2FsbGluZyBzb3VyY2Ugc3Bl
Y2lmaWMgZGF0YSBvbmx5IGZvciBPTEVEIHBhbmVsLCBhbmQgSSBjYW4gZ2V0IGFkdmFudGFnZSBv
ZiBhcm91bmQgMTAwbXMgZm9yIG5vbi1vbGVkIHBhbmVsIGR1cmluZyByZXN1bWUuIEhlcnNlbiBu
aWdodCBoYXZlIGFuc3dlciBhYm91dCB0aGUgaXNzdWUgcmVsYXRlZCB0byByZWdyZXNzaW9uIGZv
ciBvdGhlciBwYW5lbHMsIHdhaXRpbmcgZm9yIGhpcyByZXBseSBhYm91dCB0aGlzIGNoYW5nZS4N
Cj4gDQo+IGNvbW1pdCA5NjU3N2NmODJhMTMzMTczMmE3MTE5OTUyMjM5ODEyMGM2NDlmMWNmDQo+
IEF1dGhvcjogSGVyc2VuIFd1IDxoZXJzZW54cy53dUBhbWQuY29tPg0KPiBEYXRlOiAgIFR1ZSBK
YW4gMTQgMTU6Mzk6MDcgMjAyMCAtMDUwMA0KPiANCj4gICAgIGRybS9hbWQvZGlzcGxheTogbGlu
dXggZW5hYmxlIG9sZWQgcGFuZWwgc3VwcG9ydCBkYyBwYXJ0DQo+IA0KPiANCj4gDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdlbnRsYW5kLCBIYXJyeSA8SGFycnkuV2Vu
dGxhbmRAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDEwLCAyMDIyIDEwOjAzIFBN
DQo+IFRvOiBNYWhhcGF0cmEsIFJhamliIDxSYWppYi5NYWhhcGF0cmFAYW1kLmNvbT47IFd1LCBI
ZXJzZW4gDQo+IDxoZXJzZW54cy53dUBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7IFMsIFNoaXJpc2ggPFNoaXJpc2guU0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kL2Rpc3BsYXk6IE5vdCB0byBjYWxsIGRwY2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19k
YXRhIGR1cmluZyByZXN1bWUuDQo+IA0KPiBPbiAyMDIyLTAxLTEwIDA0OjA2LCBSYWppYiBNYWhh
cGF0cmEgd3JvdGU6DQo+PiBbV2h5XQ0KPj4gRHVyaW5nIHJlc3VtZSBwYXRoLCBkcGNkX3NldF9z
b3VyY2Vfc3BlY2lmaWNfZGF0YSBpcyB0YWtpbmcgZXh0cmEgDQo+PiB0aW1lIHdoZW4gY29yZV9s
aW5rX3dyaXRlX2RwY2QgZmFpbHMgb24gRFBfU09VUkNFX09VSSsweDAzIGFuZCANCj4+IERQX1NP
VVJDRV9NSU5JTVVNX0hCTEFOS19TVVBQT1JURUQuIEhlcmUsYXV4LT50cmFuc2ZlciBmYWlscyB3
aXRoIA0KPj4gbXVsdGlwbGUgcmV0cmllcyBhbmQgY29uc3VtZSBzaWdmaWNhbnRhbW91bnQgdGlt
ZSBkdXJpbmcNCj4+IFMwaTMgcmVzdW1lLg0KPj4NCj4+IFtIb3ddDQo+PiBOb3QgdG8gY2FsbCBk
cGNkX3NldF9zb3VyY2Vfc3BlY2lmaWNfZGF0YSBkdXJpbmcgcmVzdW1lIHBhdGggd2hlbiANCj4+
IHRoZXJlIGlzIG5vIG9sZWQgcGFuZWwgY29ubmVjdGVkIGFuZCBhY2hpZXZlIGZhc3RlciByZXN1
bWUgZHVyaW5nIA0KPj4gUzBpMy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSYWppYiBNYWhhcGF0
cmEgPHJhamliLm1haGFwYXRyYUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGluay5jIHwgMyArKy0NCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYw0KPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4+IGluZGV4IGMwYmRjMjM3
MDJjOC4uMDQwODZjMTk5ZGJiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfbGluay5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kY19saW5rLmMNCj4+IEBAIC04OTIsNyArODkyLDggQEAgc3RhdGljIGJv
b2wgZGNfbGlua19kZXRlY3RfaGVscGVyKHN0cnVjdCBkY19saW5rICpsaW5rLA0KPj4gIAkJKCFs
aW5rLT5kYy0+Y29uZmlnLmFsbG93X2VkcF9ob3RwbHVnX2RldGVjdGlvbikpICYmDQo+PiAgCQls
aW5rLT5sb2NhbF9zaW5rKSB7DQo+PiAgCQkvLyBuZWVkIHRvIHJlLXdyaXRlIE9VSSBhbmQgYnJp
Z2h0bmVzcyBpbiByZXN1bWUgY2FzZQ0KPj4gLQkJaWYgKGxpbmstPmNvbm5lY3Rvcl9zaWduYWwg
PT0gU0lHTkFMX1RZUEVfRURQKSB7DQo+PiArCQlpZiAobGluay0+Y29ubmVjdG9yX3NpZ25hbCA9
PSBTSUdOQUxfVFlQRV9FRFAgJiYNCj4+ICsJCQkobGluay0+ZHBjZF9zaW5rX2V4dF9jYXBzLmJp
dHMub2xlZCA9PSAxKSkgew0KPiANCj4gSXMgdGhlIHNvdXJjZSBzcGVjaWZpYyBkYXRhIG9ubHkg
dXNlZCBieSBPTEVEIHBhbmVscz8NCj4gDQo+IERvIHdlIGtub3cgdGhhdCB0aGlzIHdvbid0IGxl
YWQgdG8gcmVncmVzc2lvbnMgd2l0aCBhbnkgZmVhdHVyZXMgb24gbm9uLU9MRUQgcGFuZWxzPw0K
PiANCj4gSGFycnkNCj4gDQo+PiAgCQkJZHBjZF9zZXRfc291cmNlX3NwZWNpZmljX2RhdGEobGlu
ayk7DQo+PiAgCQkJbXNsZWVwKHBvc3Rfb3VpX2RlbGF5KTsNCj4+ICAJCQlkY19saW5rX3NldF9k
ZWZhdWx0X2JyaWdodG5lc3NfYXV4KGxpbmspOw0KPiANCg==
