Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670CDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 06:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5E110F577;
	Thu, 13 Jan 2022 06:38:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC0810F8B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 06:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0hk4wGG2fmselzhQ6mxgeaMbD6fshyijv54vdmNljHYbyFRBcy4MPrOgqVm1pqP3hnIX8xRDrchhTiNmvQm2QvsZgRN3+pve2kcUSyaCs1odXJ8j77GKOFrgVFItCBJ9p7lZQEjZUzLjs0pY3uYtLUKU9HejkJ3iaycQqywuYoMt1/fu7TzeEPHfnfDXSSe23Mn+b4kVeClNlJaczuT5GiDGsKpPP3M8+QtCfXuGJF0ZWINWXB2F1x+a2158KVqD9ohAzPJ3ugquAWOefnzdbqu1886rILiyfUtX77GCtZEunEsgRvEyx8HP5g4rqFxrMjjvAxTwS/r8RfKmHOxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpI3NY6JznCp1/UQPsubbvc/X6ytY5T9A4SYg352PHY=;
 b=jKACgvoMiLG2T/dj/ZAgK9jtXdCue8QnBsgs2HdDg/r0J+lr9ZzIrKlqo4x/v6O5Bfg9Gi4CE7sKGb2I4lIuiOTOCPxYAc8FeH5NxLUi0HvPDzCjJHoQAzozM8PT9EhuaIhehuPNlccPoGs2RWHgPp+dguc2lSHxNIA7Dy9qMEkBShTt4/HDRB9cCuxTfqyXlPPqCuJmBjGmPNIz+wuSF5Qu7m7jDCy9B5lK1tM1Ld3N8eeI+8968mX6myCfDKmVcoQgHkLyANdQf0sa3TcysbBZnoRHihXrkw858YEkDKWLg++/BuErdJm9Rd1fCOXUI/u2p8D4Hw7Pikp/NqWBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpI3NY6JznCp1/UQPsubbvc/X6ytY5T9A4SYg352PHY=;
 b=xySoDgy+j9JngR0i091KdAj4oMZ6qWmld3U3SCrH/FaLtPmL23Tg6lVk6Pl/3uPUdHcBQCP3Gpyf/CReVeevy4dA1+goeyZbOJFgnZApLR7ialpChjo1+zO3K+whgOuqCqbUbhYD0lOz9fhdA+84v1aU2qsPIalzs668XqM/+dg=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BY5PR12MB3874.namprd12.prod.outlook.com (2603:10b6:a03:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 06:38:28 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::a4fd:f836:9ebc:7c47]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::a4fd:f836:9ebc:7c47%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:38:28 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogaGFuZGxl?=
 =?utf-8?Q?_denied_inject_error_into_critical_regions_v2?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: handle denied inject error into
 critical regions v2
Thread-Index: AQHYCBzk5ZdgBeQURku6v8LCaruToqxgSx+AgAA03BA=
Date: Thu, 13 Jan 2022 06:38:28 +0000
Message-ID: <BL1PR12MB533401B779FE7E4406CB94029A539@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20220113012829.27726-1-Stanley.Yang@amd.com>
 <CY4PR12MB176788FD3646CE7D5DB37886B0539@CY4PR12MB1767.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB176788FD3646CE7D5DB37886B0539@CY4PR12MB1767.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-13T03:28:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=156385e4-1994-42d7-9915-7d829c7d7b36;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-13T06:38:24Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: fb565dc8-6ea8-4f0d-ab16-6cf05f067742
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e5026d6-9318-4662-c712-08d9d65f4f18
x-ms-traffictypediagnostic: BY5PR12MB3874:EE_
x-microsoft-antispam-prvs: <BY5PR12MB38746081387322CEC0CDF4289A539@BY5PR12MB3874.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZHNgoQy+6K81FTqb5loV/5vrLI9PYhoHW1CxPE1iiLaY7bOaTnh44+8cGr/dP3a5FHsRkPD+M2JQjzvWr/4L/9nPVNz+0mYrUlV9BwvGH7G0WlD/9AVsAHd9iJw3QmaUPki/oKVAE81DSchpMJtHJrIzUrTX0i7VyRaXCK0lw968wXGSluF3R2AM69/pE61sZ7wzvYS0JBnni705zYnZk39WTZttCWOuUYpb3BKBcZSU8tD1exD4fluvU82e0r91NsLtW1exGoR0wVi4qGiTI/Qm928G6KMfgkBqOLG559JZosXC8+EiPyYl17XB1sLcSIpLeA8wYy8+7U1Co7as7Zo9Kaezk58bT+Zdk7xdRX9B9iKtpmCMmb8aem8VwLiAfudGucZKMBE2s9Sazi/2ukm3Le+v9Er34LfueepR20DfiEbA7sB9P0fRuG6LIGlDf08OcjHoDkSgH7/xiHFIp2vwZXaxh0whzAE30iYpw/+EcGnI/YuoakHnLU7ez46i3Oc23g4YOrqgf0lE2oRJpgw/kR94CAz4p539AOsHigN4hZQhTDH84weaNksVssbT/N6v4ao8KWJMILWOTtXzud4SVrv6MBRgIdNu26oA6ZWLVV4irLft2kgXziXNuxcF6JMEIlSygvpu0xa1R6lH2FYIgtEkJoqqp9blu154RhhOPTHMUDqkFtSgb6iSaRhkL67VYJKvnkqaPMNeO2LVe1QCzZTTNVmC026FvNkfTjdlx/GtKpe6TAcGUFoQ3SR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(53546011)(38070700005)(6506007)(4326008)(38100700002)(8936002)(122000001)(26005)(66946007)(33656002)(9686003)(86362001)(54906003)(66556008)(2906002)(64756008)(76116006)(71200400001)(66446008)(52536014)(316002)(66476007)(83380400001)(224303003)(5660300002)(7696005)(110136005)(55016003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE0zaElWK1RlMCtadjdUYXFjTEUzcWZKcWlVdlUrRDREVEFONUlYZXZxdDQ5?=
 =?utf-8?B?K0QrNUtCdDNHSGc3dG01eXlCSC9sS0k1UStKYUpycDVhQXM4b3p2Y1FOY3NK?=
 =?utf-8?B?RFN2cFlwVjllTExTT24wRnhyUGg3RnpkQnJ4Vnh4Rm1FSVllVy8wQ3ZMbU5s?=
 =?utf-8?B?NG9ZZ3BYUXR5S2Z1UlRpdWNRZWh2eEh5aFB0elNYa0NoRDk5SktXc2dqWUZM?=
 =?utf-8?B?V2RoOEQrRnp0c042QTVpeHVRQU52NkJBV3JXMXpudVQxRzVUZVVKZ3pxNGIy?=
 =?utf-8?B?TTErSlVMY1lNZm5RWlN6NUJOczZyNmdpNE9VeCtuTG5tMUQvS2kzand3c2ox?=
 =?utf-8?B?QW1HUDVVdHdWMUNWZGRrTDhhb3JBcVArMXRacHE3blFqaTJRaUt2QlNrZHBv?=
 =?utf-8?B?Nzdpd0ZoQnBaenlkQzlHMGNTTjB2Q3M0d2FyMk9ZMHRCcWJrbEhnNVdwSW5y?=
 =?utf-8?B?SCtkeVpTb1hOZlcyNStXckhMQndSTWFjQVV6ZUlSTUU2QUh0UjN1M3kyRVo1?=
 =?utf-8?B?MzF0UDQ5bTlkS2txa2FPTmcvQnAyeHA3ZW5wQnFoMytUSy96N0NXOGRuYVRB?=
 =?utf-8?B?OGkyTFVnb2UycXd3c1ZaWnBDR29TOTY1K3NyMmk5OWxHWVJ6NWZkcDJSZDFi?=
 =?utf-8?B?SFpVR3lPaTJDa3QwZWlrczdoeDl3cmlrWmxtVWZENkhRMkM0RHJjNHorTWJi?=
 =?utf-8?B?SkFoUzBjaFpKT0JOaVFMTEY2UDNmcThHOXk5ZUtaSFAxdTUzL1VoeHRvaWxE?=
 =?utf-8?B?UEJVeEdRTmh0aFN1c09ZRmN4T3BOT2paMEZJSkltdVVnQ0x5d3JkT0t0ZFB1?=
 =?utf-8?B?UDY4YWd3U2plRXNOZ29nOExLc0pzMHE4YzV0NThkV2lac0tKd0gxODVJRkJJ?=
 =?utf-8?B?ZlBjejBtMTlPU1k4OW9CeXZrKzhUUmpTZTU1cFJCdWxnTU5RUUJhL3I1cG9q?=
 =?utf-8?B?ZUR4djlCUlJ1ZUFibTcrTjltTWtjME1nT1Ntd1R4am0zblFUbTVHZVFZMGFw?=
 =?utf-8?B?RDAxYUJFN28xSW5WKys3VkFmMnlCTmkzM29vTXZ0V25IMW55NUlFVDRKTjUw?=
 =?utf-8?B?cTZCbnAySktUbGhLd2VyZGFna0RIZkJOakpiZWttQy8zTjZvdjdWVGo0S09P?=
 =?utf-8?B?L0R4Ry9MRmYyRVFUTjRXSlZGaEFsYmo5R3VGSENZQURJRDN1TW0zcTJuM1NI?=
 =?utf-8?B?ZFNxU3U0M0hWSTJLSVNRSXJyc3NFRGl1ZlVRL3d0OFhKYVViQndvQ2x0ejdV?=
 =?utf-8?B?aUU5dFVZYTBpZXJ0amN4REJrYlJmdGNZeGNnWjdNSUJ2Vi91OUtxY1RvTy9F?=
 =?utf-8?B?cjA0TTh0RGd1RG5rNU44ZWFjclhHdHNZak9FdXAwSnJUMmFkVGFVZW9XajlF?=
 =?utf-8?B?ZFVRb3Q4M2xkMUwvU2xTM1JVRFBTTVV2RFRCSCtpSVdRa3VqbnJqL2xacTBx?=
 =?utf-8?B?VlNhSVhMTVRMUmszN09DZkdIREp2KzltK3JwYlBFWlZxSVVxNmZyVHBJSm9H?=
 =?utf-8?B?MW10b1N6MW0zS2RxeWRmbUQrdlR3VDZrVzY0bE1hS3hiY1EyeG5mb1hlNFRH?=
 =?utf-8?B?cTdqcWhjbGN1MUdkVkZqNFNGZk9ncFNxZERmNTl5V3FzY1FjaDRNNkYzQSsx?=
 =?utf-8?B?VXdIVVhlNU9qZnZDaVJCQ1M5a1lDZlZWQk5aOHBDK0NRR1Axek1rSVZSK0Nu?=
 =?utf-8?B?bURXdEpndWNhZGZYdXQveDlGeDltelJ6elRCTDFXNUtLR0piOEVSREg5dVM5?=
 =?utf-8?B?OC96TEVKRmxKYWxzeUg5YVArLy9hL2dIVkxqZWlqVHBDYW1SclNIdmkzOGo0?=
 =?utf-8?B?QWRuZkZCeC9tTGY2SlZrWEVrcUh2emxiMjFkMkYvSG1zZ1JlZWU0cnhIY203?=
 =?utf-8?B?S0FKUWgxc0FibmRYVURuNWRhVzVFUkRqY1YwVGVVeEo0VGlhblAzTFQxRzRw?=
 =?utf-8?B?M0dmVnNpOWdENHkyczZxbVQ1emwya3FqN2xSTXFKMEFFQ29zVTJFUXlzSGt1?=
 =?utf-8?B?ZVgrZzZKa2VuamlVbUNLbWFUdTlQNDVCMGRMbk5HYWU0R050ZmN1bkVkRDR3?=
 =?utf-8?B?clNOSURFTUZYQU96MU9hSTJzQWtYL2lsYmxHMWJaRlkwZXNrL1ZSZXJQT0VT?=
 =?utf-8?B?MUdEZ1o1dU5JaVA1cngzMk41ellPMGlVbHoxTjdyeFh6NWJvTjJtYVYyMjFu?=
 =?utf-8?Q?fp7Zhcep5arQFiUcOFOBzv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5026d6-9318-4662-c712-08d9d65f4f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 06:38:28.6272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir9qV95v3Jaq47EW1RjUnRE9rqflSwrM4uVRX/P0YUtZeDWoRvqiprK6j6xj8z/Oynn+iR69SwdmHEouK0djJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3874
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzLCB3aWxsIHVwZGF0ZSBiZWZvcmUgc3Vi
bWl0Lg0KDQpSZWdhcmRzLA0KU3RhbmxleQ0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWP
keS7tuS6ujogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQo+IOWPkemAgeaXtumXtDog
VGh1cnNkYXksIEphbnVhcnkgMTMsIDIwMjIgMTE6MjkgQU0NCj4g5pS25Lu25Lq6OiBZYW5nLCBT
dGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiDmioTpgIE6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
OyBDbGVtZW50cywgSm9obg0KPiA8Sm9obi5DbGVtZW50c0BhbWQuY29tPjsgWWFuZywgU3Rhbmxl
eSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+DQo+IOS4u+mimDogUkU6IFtQQVRDSCBSZXZpZXcgMS8x
XSBkcm0vYW1kZ3B1OiBoYW5kbGUgZGVuaWVkIGluamVjdCBlcnJvciBpbnRvDQo+IGNyaXRpY2Fs
IHJlZ2lvbnMgdjINCj4gDQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+IA0KPiBTaW5jZSB5
b3UgdXNlIGRldl93YXJuLCAiUkFTIFdBUk5JTkciIGlzIGJldHRlciB0aGFuICJSQVMgSU5GTyIg
aW4gdGhlDQo+IHByaW50IG1lc3NhZ2UsIHdpdGggdGhpcyBmaXhlZCB0aGUgcGF0Y2ggaXM6DQo+
IA0KPiBSZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KPiANCj4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFN0YW5sZXkuWWFuZyA8U3Rhbmxl
eS5ZYW5nQGFtZC5jb20+DQo+ID4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMTMsIDIwMjIgOToy
OCBBTQ0KPiA+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IENjOiBaaGFu
ZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4NCj4gPiA8
Sm9obi5DbGVtZW50c0BhbWQuY29tPjsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBZ
YW5nLA0KPiBTdGFubGV5DQo+ID4gPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiA+IFN1YmplY3Q6
IFtQQVRDSCBSZXZpZXcgMS8xXSBkcm0vYW1kZ3B1OiBoYW5kbGUgZGVuaWVkIGluamVjdCBlcnJv
cg0KPiA+IGludG8gY3JpdGljYWwgcmVnaW9ucyB2Mg0KPiA+DQo+ID4gQ2hhbmdlZCBmcm9tIHYx
Og0KPiA+ICAgICByZW1vdmUgdW51c2VkIGJyYWNlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
dGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgfCA5ICsrKysrKysrLQ0KPiA+IGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyB8IDIgKy0NCj4gPiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS90YV9yYXNfaWYuaCAgfCAzICsrLQ0KPiA+ICAzIGZpbGVzIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMNCj4gPiBpbmRleCBjNzQyZDFhYWNmNWEu
LjE0NDE3Njc3OWY5ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcHNwLmMNCj4gPiBAQCAtMTMwOSw2ICsxMzA5LDExIEBAIHN0YXRpYyB2b2lkIHBzcF9yYXNf
dGFfY2hlY2tfc3RhdHVzKHN0cnVjdA0KPiA+IHBzcF9jb250ZXh0ICpwc3ApDQo+ID4gIAkJYnJl
YWs7DQo+ID4gIAljYXNlIFRBX1JBU19TVEFUVVNfX1NVQ0NFU1M6DQo+ID4gIAkJYnJlYWs7DQo+
ID4gKwljYXNlIFRBX1JBU19TVEFUVVNfX1RFRV9FUlJPUl9BQ0NFU1NfREVOSUVEOg0KPiA+ICsJ
CWlmIChyYXNfY21kLT5jbWRfaWQgPT0NCj4gVEFfUkFTX0NPTU1BTkRfX1RSSUdHRVJfRVJST1Ip
DQo+ID4gKwkJCWRldl93YXJuKHBzcC0+YWRldi0+ZGV2LA0KPiA+ICsJCQkJCSJSQVMgSU5GTzog
SW5qZWN0IGVycm9yIHRvIGNyaXRpY2FsDQo+ID4gcmVnaW9uIGlzIG5vdCBhbGxvd2VkXG4iKTsN
Cj4gPiArCQlicmVhazsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4gIAkJZGV2X3dhcm4ocHNwLT5hZGV2
LT5kZXYsDQo+ID4gIAkJCQkiUkFTIFdBUk5JTkc6IHJhcyBzdGF0dXMgPSAweCVYXG4iLA0KPiBy
YXNfY21kLT5yYXNfc3RhdHVzKTsgQEANCj4gPiAtMTUyMSw3ICsxNTI2LDkgQEAgaW50IHBzcF9y
YXNfdHJpZ2dlcl9lcnJvcihzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwNCj4gPiAgCWlmIChhbWRn
cHVfcmFzX2ludHJfdHJpZ2dlcmVkKCkpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4NCj4gPiAtCWlm
IChyYXNfY21kLT5yYXNfc3RhdHVzKQ0KPiA+ICsJaWYgKHJhc19jbWQtPnJhc19zdGF0dXMgPT0N
Cj4gPiBUQV9SQVNfU1RBVFVTX19URUVfRVJST1JfQUNDRVNTX0RFTklFRCkNCj4gPiArCQlyZXR1
cm4gLUVBQ0NFUzsNCj4gPiArCWVsc2UgaWYgKHJhc19jbWQtPnJhc19zdGF0dXMpDQo+ID4gIAkJ
cmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiA+IGluZGV4IGU2NzRkYmVkMzYxNS4uOGJk
YzJlODVjYjIwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yYXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYw0KPiA+IEBAIC00NDksNyArNDQ5LDcgQEAgc3RhdGljIHNzaXplX3QNCj4gPiBhbWRncHVf
cmFzX2RlYnVnZnNfY3RybF93cml0ZShzdHJ1Y3QgZmlsZSAqZiwNCj4gPiAgCX0NCj4gPg0KPiA+
ICAJaWYgKHJldCkNCj4gPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQlyZXR1cm4gcmV0Ow0K
PiA+DQo+ID4gIAlyZXR1cm4gc2l6ZTsNCj4gPiAgfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS90YV9yYXNfaWYuaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdGFfcmFzX2lmLmgNCj4gPiBpbmRleCA1MDkzODI2YTQzZDEuLjUwOWQ4YTE5NDVl
YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS90YV9yYXNfaWYu
aA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3RhX3Jhc19pZi5oDQo+ID4g
QEAgLTY0LDcgKzY0LDggQEAgZW51bSB0YV9yYXNfc3RhdHVzIHsNCj4gPiAgCVRBX1JBU19TVEFU
VVNfX0VSUk9SX1BDU19TVEFURV9FUlJPUiAgICAgICAgICAgID0gMHhBMDE2LA0KPiA+ICAJVEFf
UkFTX1NUQVRVU19fRVJST1JfUENTX1NUQVRFX0hBTkcgICAgICAgICAgICAgPSAweEEwMTcsDQo+
ID4gIAlUQV9SQVNfU1RBVFVTX19FUlJPUl9QQ1NfU1RBVEVfVU5LTk9XTiAgICAgICAgICA9IDB4
QTAxOCwNCj4gPiAtCVRBX1JBU19TVEFUVVNfX0VSUk9SX1VOU1VQUE9SVEVEX0VSUk9SX0lOSiAg
ICAgID0gMHhBMDE5DQo+ID4gKwlUQV9SQVNfU1RBVFVTX19FUlJPUl9VTlNVUFBPUlRFRF9FUlJP
Ul9JTkogICAgICA9IDB4QTAxOSwNCj4gPiArCVRBX1JBU19TVEFUVVNfX1RFRV9FUlJPUl9BQ0NF
U1NfREVOSUVEICAgICAgICAgID0gMHhBMDFBDQo+ID4gIH07DQo+ID4NCj4gPiAgZW51bSB0YV9y
YXNfYmxvY2sgew0KPiA+IC0tDQo+ID4gMi4xNy4xDQo=
