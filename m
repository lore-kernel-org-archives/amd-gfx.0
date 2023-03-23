Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD82C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 13:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2061910EA9C;
	Thu, 23 Mar 2023 13:49:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B180710EA9C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 13:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9I/2IAiPI7Dy8Jw3erKLMod+dJkqFLYX3IHrUFPSekd0oiViEs5ObYr05vRWnE/QPQdlYkQt+xYkxmI1mWpOok9lAa4gWn3mCorvuAQHt7olugQle4RQ4R/cLJIIzDDC76/B4e3cSfkLCmrSwwz+l/6aOEHdVpT3CwGIZ4O09qPFNSHqBkiLqiUoKTC3lwVcZf+KrHC+stMfZyYR77swhfcNJwNH3v2hIZVeyfe7q5+5oTHJ0HPmLtqmbfVVMhbSoE/jMZVZ38sI61HcOHsXvvDesdpm0mBRNUQt6mAVOyzjZ/OgdyTgjCXNbkxV0L1SZVJuIshDjAbShOVk4nh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdRzfGwJCsjKlUcGHEVNf7Y4N40TDQ9lIAxV+X4esg8=;
 b=Wz4uQFkAAo3ID5JZ77eJsq+/S+q5aEzm8aUb3MaP0LF/5CI7YhZ8Lsta8x7W9t9xKEW+nv5PtV+NN6HEGHJZkMOmDCf/odckF6JoBFNOay+s0I+Dkkqaxwv4cBV4JVlY7OjWxpBCK/AGvZPLw7nP+u7caPc8F/Lp5eRHVawNJfP6fu22AWkXBUn4e1AFyPOwZUCDAMQpokxCEManxNWwJ30Nh84Szdd+bNxvn9FNT+Infk12xwmlxqdz0mwcKqg6nbXMF69IwbrNlyaSpj0Fy9+6Ius1CvnKQ6M7SVmmNxrCur/WqSTDR8ZtHfL1rdzp7XrFDv+Xppfu28E/imCeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdRzfGwJCsjKlUcGHEVNf7Y4N40TDQ9lIAxV+X4esg8=;
 b=Qnuu5iqZvDe1Ml4NqPXcCzaXuQGC1Jh5JVD7d36uOZV3q1zh3twuCs4tYFqptdaRw0EsEnp/W/aMVK/mejuG6px1Lb3+qzSGpqZxy9m2Z6sGJRUS/CFxgoejGl0uqc4Ayr3LxwjpryQ4qpDb9Zck0Tyak7ZQlG4IEIkovHP0oZ0=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 13:49:40 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::64bb:77a5:6d11:821%6]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 13:49:40 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix logic bug in fatal error handling
Thread-Index: AQHZXYOURkYCGNefDUK3mypny9B1vq8ITEEAgAAAWvCAAAFcAIAAE43g
Date: Thu, 23 Mar 2023 13:49:40 +0000
Message-ID: <MN2PR12MB412896A32B32E78BE0D99CF390879@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230323123224.3970818-1-srinivasan.shanmugam@amd.com>
 <MN0PR12MB6101863E54001078B11FA04FE2879@MN0PR12MB6101.namprd12.prod.outlook.com>
 <MN2PR12MB412862810D7180FAD76DB3BC90879@MN2PR12MB4128.namprd12.prod.outlook.com>
 <MN0PR12MB6101A603F1AB913006B243F0E2879@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101A603F1AB913006B243F0E2879@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-23T13:49:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=33df8f09-a99d-44cd-bded-b4c8200031ee;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|SA1PR12MB8742:EE_
x-ms-office365-filtering-correlation-id: 61e3f803-9187-4d99-ce76-08db2ba57321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gb3o4LNq25AU2kjYNAjFJ5a9UtN2Ws58nIJsnp2TtD+zV/5LixNxmwm6fnEsGEEAXpqmPshIVxMC9hSGkLmlhS6EmQy269CxOTcyY/GYiUsH3NADcwFyh9NjSnU02QpuKL6eRqdXwXEFlc9w4EKnxvkdKLJelJNrZLzin+EFqcjUQ4Jh165fF6wSe2eBjGHFGHquhsjnzN5SkVaBYcvWObdF/NK4BZWfDgPWltffafOHLO4tGISbZirNXXqEhIRWOvXxpLanYHYgp20K69YwIiRdaTf1qaNWt91zyiSAth6EaN+LvFGDbdyweBDAg/ds84FmWqqXBwpzn/SZunhElwrFGsU95sNdWybpdsWt+S0ILRGc3ged49thygxIzsSGUNAaesymXsJdDI8j63U4qyjAQuTJk9KETllj8d4Fwve4zYhsPIqeEagIYvi0u5sLjlPVxo4A2xH9CQsOeElwY9Bco0nEJPaRblkkmNe9B5HTAq44tSIZeMrjSOe/6IHHfU2g+daoddLS8X/Xj2c90FT8mtBDXZxQJnffTnjrmzQgWKjFKgL+1l8PdVKPJTKBOubnIwfV5CP7Y9XW4kGMILO4JZCfuqmAWYAAmrhR6FdWJxxXE2lEtobKdbR5aIl7uCjkJeLoV/2kC5BXD36exNi6zb7VPDxIKGY8+12bmxYd6bKg6rFrkEX8MrIJJKE4XOihgvFAafAkuC/RwK+eCBD6QXw0W02pDSH7/47yqg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(41300700001)(66446008)(52536014)(5660300002)(8676002)(4326008)(66476007)(2906002)(38070700005)(64756008)(921005)(33656002)(86362001)(38100700002)(122000001)(71200400001)(7696005)(26005)(76116006)(110136005)(478600001)(6636002)(316002)(8936002)(66556008)(55016003)(6506007)(66574015)(83380400001)(66946007)(53546011)(186003)(9686003)(55236004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azJOMVBMejhoSkMrSFhUN2F0WjN2WHpFRnVDcWJ3eU1pbWNoL0VoT2ptM1FQ?=
 =?utf-8?B?eGNGT281SDRRMU5IbXR4aEdIRW9qRE1uVFpNZ1N0MkUxaU4wdzV5NlBEOFJZ?=
 =?utf-8?B?MktBWEk4SW1BRkhiT0tmd002QmVFMCs1MDBRMmd2Tlgvb1JkUXRxa0pUUmxp?=
 =?utf-8?B?MWtwNVZEdkxOaTI1aWJGWFJwNEVRajEza3czODlwcTNjR0VvcnhCY3c1K3h5?=
 =?utf-8?B?ZDhaYzlzOFlwNyswejFWQVFSMHc5dUoxbWlOclNqS1lsWUI0MDB5bVowUUJU?=
 =?utf-8?B?bWt5U1l5a24zM2JDV1Fod2hHdVBrN1hwSHhNdXpGVUM5eXBISXZwVlJVbFdt?=
 =?utf-8?B?T01pc1A5RGNNTHRRRTdjYVl2dDVsa2dBMnMyY085ZHVKVFA2YmEwSkZib3Rv?=
 =?utf-8?B?blBJNENpYzRYaEZnUE1ISmdnb3A1VlExVTRjbnpZbFh4bEdkUTFWT016eVJs?=
 =?utf-8?B?c25DWnByTTJXbXh4anRZdE9pV05ENS9PcmhSU0VrSjFsbWw4S1NaUVZRaVhR?=
 =?utf-8?B?bkhWdWxTQ0UrMCtSeGFiUXF0U1Bmc2hkUjJJYkoyRy9hOXlaZktjOXkrT3E5?=
 =?utf-8?B?a0R6YzJrQ1JhcnBVTUdwNXVuclJ4YS83c2pyaUVhUVFiVFpYcFZnYUVyRGdK?=
 =?utf-8?B?Y2REY0toMysrSCtIcS9hWG1CeDFxQTNhdXZJZEgzY21CR2h4YVNERjR6anZY?=
 =?utf-8?B?SkdiL1JNaVE2R0tlTDRKREQ2aktSYkxnRXBGVVVwQlhrWjJLUzUvMHdVT0FP?=
 =?utf-8?B?U3Nwajk0ZTVYYWU1VUs0N3A1WEhEcUdzUmtaa2RaeVBkL1hJOUszSHdNRjdj?=
 =?utf-8?B?aFpsUmpxSkZFTXZQTnIyZEhzN1hEbjJmNU1hU3BENmJCL3FrSlZIZ01rM0lq?=
 =?utf-8?B?ZE05ZUwxQXN2TFZaQXVKa3YwUGJqbHAycnVjM00wMmVWS3Z3eUNLVU1vUFRR?=
 =?utf-8?B?eHZGVGxRYTk1MndjancrTlpBR2lubENoWXVYcDFDd3JyUFZiVmVyQk9WeDJh?=
 =?utf-8?B?VVUrRkhIZkpRblRUKy9yc3FrSm52RnlyU3RWT0J5ellxOVp4UEFHR2J1dVEr?=
 =?utf-8?B?N1k0QTVJMWhBbEZQbjRsWUM0OWJ6OVVibmlENlF0UDJEQnVhV2lOdFBUeU1T?=
 =?utf-8?B?c2U0UXdLOU5wVlUxcUtoMU5jbzVqUENhOWlRcmZ3aVFFQU9Nc2QzSFBYc3Ez?=
 =?utf-8?B?UzJ0bEhKTTVNZ2JWcWVOY3FaWW9sak5zK1dQdUVxOEpOOFh1UFVCYU1hMXc5?=
 =?utf-8?B?UTJqcVdtOFRERVE1M0M1Yjhhc2RsUTNyYXVRNWRkWS8yWEFzVGY0QzZtWTJl?=
 =?utf-8?B?VkFQUXVCcGQ1NVIyNzljZUpMNnBOa0x5ZkEzYXhIaG9SaC9iSXhBMFN6aTV5?=
 =?utf-8?B?TThrWG41Ulk4L2lEUDhmakhyNHFrN0FHV1ZiTkVndE9ZaDNzbGJpM3Q3ZUxD?=
 =?utf-8?B?K1VIVy9lLytuUmFHS1V4c0duckJIZFYrbSt3Q0d6NUN6eUJ2QjFrTGNvQ1BN?=
 =?utf-8?B?WkNJUnRVczNXSFVvb25tVDBaRjFtZ1h5TFNuTlY1MUtPQlVQNW5GT0U5Nmt0?=
 =?utf-8?B?R3h1ZjRwT1pCRGVseitPcm5kYllPWWt3bytyNEh1UUFUcTZCeTd0eFBMVXhz?=
 =?utf-8?B?VFE1RGpqTVA3cHZXalFsMjNRcTIrVnJwOGU5VUErSXk2dVc5YXhBUlVJZWxo?=
 =?utf-8?B?U2JKeEZjZUd5L3J1ZlZIa1MxTWU3MVYySWE5RzUvaEJIWjN2S0hZODdHZmhK?=
 =?utf-8?B?TFRlRjRqTXE1ak1TMjlrem44V0pLU1B3Z1dySnlpSFU2MlBRdDNoWFhyS1U2?=
 =?utf-8?B?cDlYM3ZDbDRNc0JTMXhLYUpaeDU1K0J2bW1tRDVqTzZsbGpGdWdGRndIbDVz?=
 =?utf-8?B?K2N1K0RWTWkzcnZzMDNMWHNUZGFvNURwTDFHOEZXNWExK0c3VFIrZEF1VEdW?=
 =?utf-8?B?YXhyc3lNR3VnZUttZmRLZ1diVGxuWW5PNVJ5VG9sTWFNYjNsMEp4Zms1QUIr?=
 =?utf-8?B?cEY3b3cyVFMrK2w4SXpkZzRDWFI2UzMyYXd3Qks4K0FwZk1yeExxaXR5ZS9S?=
 =?utf-8?B?bzl3QVlQdWhCOVVtaXNRM3VHeWVaUTN2ZWh2K1hUUFMzb3p1ejJyS0ZpODNY?=
 =?utf-8?Q?GnLY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e3f803-9187-4d99-ce76-08db2ba57321
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 13:49:40.3781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4pUD/3ge7AHrbVUQntzV6dmM0FFi2IOJEhbDUIKRLsybyjiHuxdRRMmo8/JGRISXifx6dlVCc4svgycTKq90A==
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

W1B1YmxpY10NCg0KVGhhbmtzIGEgbG90IE1hcmlvISwgbXVjaCBhcHByZWNpYXRlIGZvciB5b3Vy
IGhlbHAgaW4gcmV2aWV3aW5nIQ0KDQpCZXN0IFJlZ2FyZHMsDQpTcmluaQ0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPiANClNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyA2OjA5IFBNDQpU
bzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPjsg
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFs
ZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNl
LkxpQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0v
YW1kL2FtZGdwdTogRml4IGxvZ2ljIGJ1ZyBpbiBmYXRhbCBlcnJvciBoYW5kbGluZw0KDQpbUHVi
bGljXQ0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyAwNzozNw0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlv
IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gDQo+IDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgDQo+IDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IFpoYW5n
LCANCj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6
IEZpeCBsb2dpYyBidWcgaW4gZmF0YWwgZXJyb3IgDQo+IGhhbmRsaW5nDQo+IA0KPiBbUHVibGlj
XQ0KPiANCj4gSGkgTWFyaW8sDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIGl0IHdh
cyBvbiAiIG9yaWdpbi9hbWQtc3RhZ2luZy1kcm0tbmV4dCINCj4gDQoNCk9oLCBpdCdzIGEgbmV3
ZXIgY2hhbmdlIGp1c3QgbGFuZGVkIHRoYXQgSSBuZWVkZWQgdG8gdXBkYXRlIG15IGxvY2FsIHRy
ZWUsIHRoYW5rcy4NCg0KRml4ZXM6IDU3NzhiNDc2MjZiNTEgKCJkcm0vYW1kZ3B1OiBBZGQgZmF0
YWwgZXJyb3IgaGFuZGxpbmcgaW4gbmJpbyB2NF8zIikNClJldmlld2VkLWJ5OiBNYXJpbyBMaW1v
bmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KPiANCj4gQmVzdCBSZWdhcmRz
LA0KPiBTcmluaQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAyMywgMjAyMyA2OjAzIFBNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+OyBLb2VuaWcsIA0KPiBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciANCj4gPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBMaSwgQ2FuZGljZSA8Q2FuZGljZS5MaUBhbWQuY29tPjsgWmhhbmcs
IA0KPiBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTog
Rml4IGxvZ2ljIGJ1ZyBpbiBmYXRhbCBlcnJvciANCj4gaGFuZGxpbmcNCj4gDQo+IFtQdWJsaWNd
DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBT
SEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4N
Cj4gPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjMsIDIwMjMgMDc6MzINCj4gPiBUbzogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRl
ciANCj4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbyAN
Cj4gPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxp
QGFtZC5jb20+Ow0KPiBaaGFuZywNCj4gPiBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
DQo+ID4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5J
VkFTQU4gDQo+ID4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+ID4gU3ViamVjdDog
W1BBVENIXSBkcm0vYW1kL2FtZGdwdTogRml4IGxvZ2ljIGJ1ZyBpbiBmYXRhbCBlcnJvciANCj4g
PiBoYW5kbGluZw0KPiA+DQo+ID4gQ0MgICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLm8NCj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmM6
MjU2NzoyODogZXJyb3I6IGJpdHdpc2Ugb3IgDQo+ID4gd2l0aCBub24temVybyB2YWx1ZSBhbHdh
eXMgZXZhbHVhdGVzIHRvIHRydWUNCj4gPiBbLVdlcnJvciwtV3RhdXRvbG9naWNhbC1iaXR3aXNl
LSBjb21wYXJlXQ0KPiA+ICAgICAgICAgICAgICAgaWYgKGFkZXYtPnJhc19od19lbmFibGVkIHwg
QU1ER1BVX1JBU19CTE9DS19fREYpDQo+ID4gICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+
fn5+fn5+fn5+Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gUHJlc3VtYWJseSB0aGUg
YXV0aG9yIGludGVuZGVkIHRvIHRlc3QgaWYgQU1ER1BVX1JBU19CTE9DS19fREYgYml0DQo+IHdh
cw0KPiA+IHNldCBpZiByYXMgaXMgZW5hYmxlZCwgc28gdGhhdCdzIHdoYXQgSSdtIGNoYW5naW5n
IHRoZSBjb2RlIHRvLg0KPiA+IEhvcGVmdWxseSB0byBkbyB0aGUgcmlnaHQgdGhpbmcuDQo+ID4N
Cj4gPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+
IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gQ2M6IE1h
cmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+IENjOiBIYXdr
aW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+ID4gQ2M6IENhbmRpY2UgTGkgPGNh
bmRpY2UubGlAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdh
bSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPiA+IGluZGV4IDViMTc3OTAyMTg4MTEuLmZh
YzQ1Zjk4MTQ1ZDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5jDQo+ID4gQEAgLTI1NjQsNyArMjU2NCw3IEBAIGludCBhbWRncHVfcmFzX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpDQo+ID4gIAkJCWFkZXYtPm5iaW8ucmFzID0gJm5i
aW9fdjdfNF9yYXM7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAljYXNlIElQX1ZFUlNJT04oNCwgMywg
MCk6DQo+ID4gLQkJaWYgKGFkZXYtPnJhc19od19lbmFibGVkIHwgQU1ER1BVX1JBU19CTE9DS19f
REYpDQo+ID4gKwkJaWYgKGFkZXYtPnJhc19od19lbmFibGVkICYgQU1ER1BVX1JBU19CTE9DS19f
REYpDQo+ID4gIAkJCS8qIHVubGlrZSBvdGhlciBnZW5lcmF0aW9uIG9mIG5iaW8gcmFzLA0KPiA+
ICAJCQkgKiBuYmlvIHY0XzMgb25seSBzdXBwb3J0IGZhdGFsIGVycm9yIGludGVycnVwdA0KPiA+
ICAJCQkgKiB0byBpbmZvcm0gc29mdHdhcmUgdGhhdCBERiBpcyBmcmVlemVkIGR1ZSB0bw0KPiA+
IC0tDQo+ID4gMi4yNS4xDQo+IA0KPiBUaGlzIGNoYW5nZSBnZW5lcmFsbHkgbWFrZXMgc2Vuc2Ug
Zm9yIHdoYXQgeW91IHNob3dlZCBhYm92ZSwgYnV0IHdoYXQgDQo+IHRyZWUgaXMgdGhpcyBhZ2Fp
bnN0PyAgVGhhdCBkb2Vzbid0IGxvb2sgbGlrZSBhbWQtc3RhZ2luZy1kcm0tbmV4dCwgDQo+IExp
bnVzJyB0cmVlIG9yIGV2ZW4gc29tZSByZWNlbnQgdGFncy4NCg==
