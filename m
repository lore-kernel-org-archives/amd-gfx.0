Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7435FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 13:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D948B6ECCF;
	Thu, 25 Nov 2021 13:36:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B486EC4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 13:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjBE4FO9MgBgiBour1wT6FsU1jK+7jWGGdSNuc/9TlEYq/LnLfDyasuohFrbXaZR8mqbyBEVzlIVCNpWbSvDLhhT2cjVHeJsxrsvrybJif07NYlY3RetM3H9U3WBjJggPTqo1yQ+OJRJEU5N16GmVJrIcTg7PYWR6ChJDq0r/qQb9J/8mJVRq8hakoIXOqg1ijf/Im1Gv2Hk0tyFU5oxiCIRLgzZfkbgRQFWnz/WSa7keTj8wo/jBHxrqJnXl24fw4gYO3yHlSjnkhch5bf99fNTtzsfv8T89wK/+rdofevQIJ/5wZuX41buLwkvoWPQuvkt1Ow6t4/twh0504F5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59dgRg9RW9yMijeoRuwoT1XVgWepq0fQCdUSHtB/8J4=;
 b=oWmBLoI9a6CJ/EGMX2Xy84l46WLhVD9ONnB2FezGYapLJp24NQo8zg2pRKIDKd/G6djIKt0Re48qwmkUIBqWiA9ZgfGiQLEQ2XU2avRdvdxuQXSnpf+wDpfSR+6eRYaUG7Jc8JS16zv6NZFFoYiEVPSVy+N+qzecvBqG6Mg+lUVPToqAzxZUBs0j1fUd8AUxyGZ8U8NAB7uZf4HYXifSBWMECzduOIbN01LDr8fmvXUCWpB1Zg74mk8igE014MPIM3tZrNSKedWLUEJ57vGkmlheaj3mU/qBieVNxzteTv1iC69JLBnc+aCdRTPmF5DLQfLHEyEefd5LtFwdsyGa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59dgRg9RW9yMijeoRuwoT1XVgWepq0fQCdUSHtB/8J4=;
 b=3ITYaZAkAPRKcyvA458wDzKvdzf1IL0LAnvjo++nGlODZQlR0hDeqI2+D4I7xxpgcuW0Efhr4N4zH/Pw+d2mw8LwrA1lSpV6hrJQXNhvkjdLSnchitDA2aSqM5EHAnaThO8Dngyhtlgwbq7r6kLxRtn9oQ+BOT3uJZFA4JG2KgI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Thu, 25 Nov 2021 13:36:52 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 13:36:52 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Thread-Topic: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Thread-Index: AQHX4fLC0IzgKa/UtkqbnkLhalwitqwUOtRAgAADCQCAAAENQA==
Date: Thu, 25 Nov 2021 13:36:52 +0000
Message-ID: <DM5PR12MB24698C51816B51682BFDC131F1629@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211125115049.122591-1-lijo.lazar@amd.com>
 <DM5PR12MB2469D8345E74CB6B2299130AF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
 <a5e2b887-2f61-247f-b279-3db57b68766b@amd.com>
In-Reply-To: <a5e2b887-2f61-247f-b279-3db57b68766b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-25T13:36:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7677532d-b0a1-4af0-9183-aa22e4a83b61;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-25T13:36:49Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 145c59e1-0203-4832-a411-c28a20c54275
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e9913f7-d900-4b03-a216-08d9b018a3d8
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-microsoft-antispam-prvs: <DM6PR12MB495950668C7EEC18AFBA5362F1629@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tyiq6T6EEKGpFbxHFuUdO8/vCi3kms4DaXZqsl1RV1jALXJT04dlgMdlDhXCxVnXZGvIh2qcNhgkzdEJ2oAy2p0Heb4KOfNYjlftjnC+RcMrP+VVKTVvwtOHaWyTJvdAiv2YUif6nH+lEy0kJU0d7UELCferyy3e/NY0bcunC3WUzDnxNodvX91m8l/W9OVQ+8Xh/MOTVw9G7ptJimvObye5kqbKnnxDxntFlTqTvsKVzu7yOMmVQYORXjZf4Qb55f7mppEhXAgUPEDD57QJIZ5/tQcLDoJgXzZk6hDcJyE43HkzLnFp/6gy36l1oDntlHheDp+wDFX0ZOvjyuIAvaWxVNXr5iZWAxX5R5CXrJVrt2uWA+A7Kv7hX29TjPoMCdoBxLyLnJJwfO3A9v1WI2Tcur+MyO8NIi8tvcEVIY7HqMI2jrWGoxS+ONJLiS7a/GjtKn1GQKcs/S1io0E4gTd9igd5EQxb65VxrBTv/w9CyZnSEbsE4eoNMhfjTIefq9Bq3zENt+nLKF0lQsG8Zr5wrGVomr7Zxrn1AZAh7owacGhbIOYuWT1pHygr1Z2wO3LpTv1GHGGx8vVhhMta4d8i0J/lSv7vPUTKzF2TQH+LaTEU2PoMRl6mInFCChflL7AyO738mzNAT4NDmzm2AmoDtjNwZdg27GUpUehurpUNTFxp9CzX9ifAFRI0OuBYIXKgL7KiOSllSzZ/Javyeg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(71200400001)(86362001)(66446008)(64756008)(66556008)(6506007)(38070700005)(66476007)(7696005)(66946007)(26005)(53546011)(33656002)(83380400001)(52536014)(508600001)(38100700002)(76116006)(55016003)(4326008)(2906002)(186003)(9686003)(54906003)(110136005)(316002)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1Y2RDNmaFF2RVBNMWlaeWExV1JGL3lxVzFIZEQ1eTkyb044MVRsSGJ1M3Yr?=
 =?utf-8?B?THJibU9QQm1BcDMzU2FPeVh0M210dFE5L0svcmJONUgxQ2x0S3dPdTRPNElz?=
 =?utf-8?B?UVdwWTdrdTA0Y2d4bFhFcWFUN3M0clMyNXFrR3dDWk1EdmpkWW1abWRUdXpF?=
 =?utf-8?B?Mk54L1lkalVHMFdOam82QTF1dDc5VHduQllkVXp3elFUbWRUZkMyY3FQMXhO?=
 =?utf-8?B?bXhNQ3VTQ1VNSytZRkNFakVnV0t6TFZEcjR2NEV6RHAzWVVER01BMnF2c21D?=
 =?utf-8?B?YlA4cjJrZXlFK0xWOVVua1VXamtoUXJlTUMrM1pZNW9lYUd1QmNkT3h0amt0?=
 =?utf-8?B?YzNvWWk1ZVJiRUlDczE4NVU3WFp6dDNuc04wMEJ5bkM0ZmhZYnhjbTZoSUNn?=
 =?utf-8?B?SDhUNk9COXhHS3VxSHJKMUVOU0I3Y0VnOHl4UXhzblo3ZlhFNDRyTjgxdjI4?=
 =?utf-8?B?VlJINXZGbWhFc0RFRUY0VDlRK3RZUTh2UjIzcjFla2tpUXVHYTJEZVZCUW9O?=
 =?utf-8?B?L2w0SmtpRktWU2Q5dlduc0pmdXVWcnZJT2lwUTNxaEpxSEg0Mnl6cHhKdVlW?=
 =?utf-8?B?UU5KUFF6ZWR6S05WYlBzR0E3emhHY05VZ3RibXJjRTNRZFVhbHZjWnkyUTBO?=
 =?utf-8?B?M2tuSHNHZWM5Ykk2dUE4eXJaeXNXRG9qM1BnblNZZUlwSGZaMWUxUlZXc3dD?=
 =?utf-8?B?OUVSeFU1cUZldUM3eVg5Wk9JWDArbFRtaDk0ZHhibnBsaUx4aDhmamlic3ky?=
 =?utf-8?B?enRVaGFUMU9WSVFyNkhXcEVydDJsbmZlQTdzaGwxcVpkSFB3WlRQYVNwTk5B?=
 =?utf-8?B?MlZQZEp1UGV6ak9WVWNyNkh5cjNOdFpvYkJlbllBcWd3U3duV25CVU9xdkg2?=
 =?utf-8?B?OGhtanJ6bXV5czZNVXVXQk9GVkozZlVrZTJ5aHhkcDJ2OXpMVDJhZkRjSGtL?=
 =?utf-8?B?V2xOZTRicUpCZG5LWUFNR2g2TlA5eGNTOGNxK21Gd1RRQnV0NmFQcUJscnNM?=
 =?utf-8?B?U2xSNXJDZThrQ0UyRHRGLzN0cklUc2xCSm4xOGg2NEFUYzhMYmdJV3RTZnRF?=
 =?utf-8?B?Q2NqbTlZeU5jbVkxZTM4ODgrckhrYy9OTVFxaThrZVFQV2g2QXlVbUliZlhh?=
 =?utf-8?B?UlBnQVFuVi9BdXpjcFp3d1ZhRUVHTktaMm56YmpmOWRKc2tLZjJZRWN0ak8x?=
 =?utf-8?B?RW1SOStjeXdVVUVNM0RhMUF1a2xuM0t5T2V3c2ZpSEF3Y05uOEtNMXJCeDdH?=
 =?utf-8?B?U3ZMTWhQNk9WU05EWVBsUDhRUXpRQUlBdHR0Q0FwYnM1c1hmNGhnakUwcUhJ?=
 =?utf-8?B?WEZDbzY0VitjQkRRYVZQVjVwM0lJN0VkT3N4TlN2Zy91ZXJNSm1JVkZIamlW?=
 =?utf-8?B?QXFMYjFiR2Z6b244V2RPL2gyc2J2QW9ZU0ROWVo2YW5id3FoVjF3VE5NT2x6?=
 =?utf-8?B?UVdsOW8rR2t2WStZQ2VlVzl2Nm5BVUZpM05aSFV1SG5BWmJhbDJTaE1OUW5n?=
 =?utf-8?B?eXd1SDBJc1BJQTdVTktzaHpCakhkbUJWY0NFNThPeEh4VHlFdXhZZmdkUHB3?=
 =?utf-8?B?VzA1UmVGM0s5VXdCRDRrcXBqUTlUT3VRakx6R1NDT0FDbGVyRFgzV1ZoTUNK?=
 =?utf-8?B?ZXB4a1J1RE84RlVib0JkS0hMQWNtZ2VsNU5aY2RIaTdQZmp2UFo0QlVPSlBT?=
 =?utf-8?B?QXlLYnhVMWJCeE1SRW1WeE1reGxETTdnWURPaGI1dEUxTmEzSS8vQkMyUHlK?=
 =?utf-8?B?M3AxT1d4UUNvaWtGQ2wxZGJ5c2lRN0RpTmRhcmpLUCtDTnk3NThFSzVvWDly?=
 =?utf-8?B?dE85a3ZXNDZXejU3OVNBN3c3UTZIUmJxdXc1dGI0Ym51T1RTZCtJb1BYRUls?=
 =?utf-8?B?T2pmbmIvaGFrV3phZnNzZUgyQzlvZVdhNUdRZnZrSlFGejNSdGp3UFo1bm85?=
 =?utf-8?B?cWNJcmNLd082c1RaaHh4RHZNRTdrT3JVYzdNeDR3VHpzZ3dRQXZlcTh4RE9F?=
 =?utf-8?B?em1vU2kwUXZBMzJ6cE0zVnZPTzhXRVVCMU5TcW5xaElpVzlLbkVBd1VTL3Yy?=
 =?utf-8?B?bzRpWisyWWtXM3A4VnlkYnpuWlpuSXVWOTgyTjhUYTh6MXBpV0dJK2hFcXZV?=
 =?utf-8?B?YzhaN2o3Ty9vRmhJdGt6MkZuTFJJdFQxall0TzVQSjhZQlRkajF5Y2hFaGFr?=
 =?utf-8?Q?CIBsQKockwrFqMLHV++xxAI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9913f7-d900-4b03-a216-08d9b018a3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 13:36:52.3403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCBPSBDsXKzXyfWpuUHDjNw4OKHRngUDlfj2AV9GDQaDAUNqDl/z7BxnLxZDJxjf8hjHXVnkG8miXBG1sTyCGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLCBMaWpvLg0KDQpSZXZpZXdlZC1i
eTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpHdWNodW4N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxh
emFyQGFtZC5jb20+IA0KU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAyMDIxIDk6MzIgUE0N
ClRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47
IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kL3BtOiBBZGQgd2FybmluZyBmb3IgdW5leHBlY3RlZCBQRyByZXF1ZXN0cw0K
DQoNCg0KT24gMTEvMjUvMjAyMSA2OjUyIFBNLCBDaGVuLCBHdWNodW4gd3JvdGU6DQo+IFtQdWJs
aWNdDQo+IA0KPiBVc2UgZGV2X3dhcm4gdG8gYmUgbUdQVSBmcmllbmRseT8NCg0KVGhlIGludGVu
dGlvbiBpcyB0byBnZXQgYSB0cmFjZSBhcyB3ZWxsIGFsb25nIHdpdGggdGhhdC4gVGhlcmUgYXJl
IG11bHRpcGxlIHBhdGhzIHRvIHRoaXMgZnVuY3Rpb24uDQoNClRoYW5rcywNCkxpam8NCg0KPiAN
Cj4gUmVnYXJkcywNCj4gR3VjaHVuDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBP
biBCZWhhbGYgT2YgDQo+IExpam8gTGF6YXINCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI1
LCAyMDIxIDc6NTEgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaW1vbmNp
ZWxsbywgTWFyaW8gDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgWmhhbmcsIEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL3Bt
OiBBZGQgd2FybmluZyBmb3IgdW5leHBlY3RlZCBQRyByZXF1ZXN0cw0KPiANCj4gSWRlYWxseSBw
b3dlciBnYXRlL3VuZ2F0ZSByZXF1ZXN0cyBzaG91bGRuJ3QgY29tZSB3aGVuIHNtdSBibG9jayBp
cyB1bmluaXRpYWxpemVkLiBBZGQgYSBXQVJOIG1lc3NhZ2UgdG8gY2hlY2sgdGhlIG9yaWdpbnMg
aWYgc3VjaCBhIHRoaW5nIGV2ZXIgaGFwcGVucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpam8g
TGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9hbWRncHVfc211LmMgfCA1ICsrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jDQo+IGluZGV4IGUxNTZhZGQ3YjU2MC4uZTBmOGFiOGJl
OTc1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9z
bXUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0K
PiBAQCAtMjc3LDggKzI3NywxMSBAQCBzdGF0aWMgaW50IHNtdV9kcG1fc2V0X3Bvd2VyX2dhdGUo
dm9pZCAqaGFuZGxlLA0KPiAgIAlzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9IGhhbmRsZTsNCj4g
ICAJaW50IHJldCA9IDA7DQo+ICAgDQo+IC0JaWYgKCFzbXUtPnBtX2VuYWJsZWQgfHwgIXNtdS0+
YWRldi0+cG0uZHBtX2VuYWJsZWQpDQo+ICsJaWYgKCFzbXUtPnBtX2VuYWJsZWQgfHwgIXNtdS0+
YWRldi0+cG0uZHBtX2VuYWJsZWQpIHsNCj4gKwkJV0FSTih0cnVlLCAiU01VIHVuaW5pdGlhbGl6
ZWQgYnV0IHBvd2VyICVzIHJlcXVlc3RlZCBmb3IgJXUhXG4iLA0KPiArCQkgICAgIGdhdGUgPyAi
Z2F0ZSIgOiAidW5nYXRlIiwgYmxvY2tfdHlwZSk7DQo+ICAgCQlyZXR1cm4gLUVPUE5PVFNVUFA7
DQo+ICsJfQ0KPiAgIA0KPiAgIAlzd2l0Y2ggKGJsb2NrX3R5cGUpIHsNCj4gICAJLyoNCj4gLS0N
Cj4gMi4yNS4xDQo+IA0K
