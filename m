Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB98461AE2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB98461AE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B886E2C8;
	Fri, 19 Nov 2021 19:10:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFD26E2C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhTkBI3swX/G+8pJ18oreSyq5OAWXpUCF3eDuyuWM9vkPECz0/TY6Q0WTLLZvDINI4H0B2mZDmTH/JE2S9FSPXEy29hQKEe9T1t9QXgiz8oRUI8h98JbkEo//vhsqc1gOpTSfNIYq1akzYnm/ziTwsVYaRuTZoW2sS49hV8zNICAd75IAPPZI+iF5ZFcP0ALsXICvpDAOet8BxIVePTGdtiFcq1mRqQleCDgaSx9DSWniLDrDfnOOdzcRcjjMzJNn81vzj7bOpglgeNR3Cc1qM1C4W+w+SG/31k2RkW6/OLAo1p9tQ4fIfs5SvEQCHRBLwTxKf4Nm2mccvp3iY1iwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKld0qoToADttlXcCxSURlKZ0P4Ip2NUmmeNkvv0hfk=;
 b=fUB8zY3jEVTo8GZ/DKinVBePBo0TGuLhBu5XAVpvo7uSZX6FX4Ry7KddKsIr4VzHMeHLJwwpVAsac7McDf010SIqezqo3Mz9yU5CvyNc6a7XwyyKuZeCfOeB3A+6GH6Jrz+ompLpublvZVKM16YzPM3dvl5JTYFpCAgDT3vUBy2c27YPWts5ctR5K4zK6JYRfaI1FVFROmvSeh7YOo3yYW4CTbe3zIRFSHAuBpFjGXCUwJ/+961jf1xp7mdrmA04nLhTXxmI5/310tNkFBjqqqNpaFPpU42Ekt9ay1m1Vq1f0QG5VLRKTNs0GMuSChqMYUUBPW5EFbqYjAhQUPk2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKld0qoToADttlXcCxSURlKZ0P4Ip2NUmmeNkvv0hfk=;
 b=EYboq+xqCrTecgBAK6be03mOI5vG4SNxHEzGVCzk8kAXqFbONTb5RwYH+tKWAybLrTeP41qH2WQgKaad49e0gZy1eDFuouGPWBquI9muUYgH+McNLz7E9FStx5QcL9IHOLHHQST58dpZrC+V10wPgQKub7tYytRO59G0heOYJjM=
Received: from BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21)
 by BYAPR12MB3142.namprd12.prod.outlook.com (2603:10b6:a03:de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 19:10:03 +0000
Received: from BYAPR12MB3064.namprd12.prod.outlook.com
 ([fe80::7d11:62f3:5ae2:c251]) by BYAPR12MB3064.namprd12.prod.outlook.com
 ([fe80::7d11:62f3:5ae2:c251%3]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 19:10:03 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/4] drm/amdkfd: add kfd_device_info_init function
Thread-Topic: [PATCH 2/4] drm/amdkfd: add kfd_device_info_init function
Thread-Index: AQHX3WKAoGq81re+0UetvabZyaIW1KwLMwEAgAACYBA=
Date: Fri, 19 Nov 2021 19:10:02 +0000
Message-ID: <BYAPR12MB3064E62271B429C18624ACA98A9C9@BYAPR12MB3064.namprd12.prod.outlook.com>
References: <20211119162800.2111819-1-Graham.Sider@amd.com>
 <20211119162800.2111819-2-Graham.Sider@amd.com>
 <CADnq5_NHuMzfXGJAtVfxSwLGYtO+ipxP2noHYWKNjukrw3z=EQ@mail.gmail.com>
In-Reply-To: <CADnq5_NHuMzfXGJAtVfxSwLGYtO+ipxP2noHYWKNjukrw3z=EQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-19T19:03:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=df6644c5-4f06-458c-9829-5613a8274b3a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-19T19:10:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 8841a01c-2ab7-4d44-8627-167b878295f9
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f8300cd-3664-47d2-af62-08d9ab9030c1
x-ms-traffictypediagnostic: BYAPR12MB3142:
x-microsoft-antispam-prvs: <BYAPR12MB3142B932A4C91B1D9599D2BA8A9C9@BYAPR12MB3142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XTT1T0EhOXLq/Vs+hnxb4l9YRNxvKPP43GSG7FH+FJHXIYjj7j6Yb17qDK27hX5svystokedYEwFX/ycCE4g6Dw0ZRp4P8FVwey6Fb1+gLoiPlwEpA3azQNylPhtDrf2P0EK4v5vgiLD2Pp+OnK3WRhF7q4qMndNs19ZYrQSaf3aHCjNo2vvcvWl/Ho2Ipgu4cKXeAxHQpyg339R5DIlzr9swKKCjKEhzZLNtH9YlYql0jMptshjVQqEpWbkFv6JG3nWC5UZpYe4Hu3XuGNoVk6Vu6sX5lsv0PAcy9cVG8DmRIsLCfsiFcq/PGh+kMUtG9NMD5Sg6fzcHgaV5CaL6SoKqiNLOTqsKOLbjztrEutk9sZ6yndmONIlt9BkwS9SY9SWwtcjugWoQbnbmMAcwnQcsSyxPGGksXf8WnT00BHCux8hSjcFIDPA2gQgWsr0YwqncmfQKsaQjjPvtTXJPKydAYffXWWgT3ReF89FKXheP+oMfQhHf5JnrtOXl19xUgjssDvvXAR3oUhya2FTWJIBa4bpDk2EB91CDbr+MEa8PNXxXphxOddaILeDXmXUX2Hsav4+lCkctCA2engmbQR2OfdRkAU4SlMFrlWiI30RNIY0QNj1M8OYV8E2KrTyWClbab9NUIme/oxZrcdbaJE4y58690LFLg1YB8pmJ0XK/OxRSfWxi7abB40TIC0RxfhYxAVXxExTkX0ijdRMig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3064.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66446008)(66556008)(6506007)(186003)(66946007)(53546011)(33656002)(6916009)(71200400001)(64756008)(38100700002)(8676002)(316002)(8936002)(76116006)(83380400001)(54906003)(9686003)(2906002)(52536014)(55016002)(122000001)(86362001)(26005)(4326008)(508600001)(7696005)(5660300002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDFKcmNjcEd3ZFJZK1ByMGx5WnJVVUR4NFhVMXE5cnpoR1Nrb2JoaHVxdXRt?=
 =?utf-8?B?L1d3STVDTDU2QUZnOTBiTU8wSS84NDNNTU9QUVNoOThWOGNjdWsxL2VCamV2?=
 =?utf-8?B?QlR3YUNidUVEc3JhWFV5Y09lUWRFVlNqY2NKbUZwTVJQSlFkMXVkSEtVbjdK?=
 =?utf-8?B?VXN6VWN4MU1ENE1DOFNjZWtGSG5JT0dJSDVaWVB4Q3RCblFvZkNFUDBUNmdZ?=
 =?utf-8?B?ODdXMlhDWFFERi9wbS93NlcyZzVHY0RCSmVuY1c2YXZYTlBkK3dlZkFLZEFz?=
 =?utf-8?B?RWVFQklQQmJ0ZUZmRWZwZ2h2VTVzRUtQYlpTYnVBdngydE9MdTJvVkdpREQ5?=
 =?utf-8?B?SHRyczlROHpva3A1V3BaeTVsMFhFRWN1QTBobGNCL1A2bml5NXVEbUJKY0Ry?=
 =?utf-8?B?ZVZRcEtzK3kvS0x2c2NPVFBzdGJrU2QvekI2ZlRpRVdhN2lzMnZSSXZ6Zk16?=
 =?utf-8?B?dTZDb25zak1oR24wNVdBSFNvRkhEcnd2RVNkNEJmMEt3YjJjVG9LNDQzMEox?=
 =?utf-8?B?THUvbVN5a0hYN2lEYW14aVBvZWdnbDBjWFRGUmMraE4wQWZYSURla2w3clpR?=
 =?utf-8?B?clAvbTVwSHpjVTBIbXgrN1Z2ejN4YzRTRUVsOURsaytKcVNvWDRBS1hpNTln?=
 =?utf-8?B?bWJGOE5lOFR3OTdKa0hWMlBVN2lPTm5ndEd1VjZtK2JaVkFXdlduSmF5UXp6?=
 =?utf-8?B?SUt6R1VyRmU0SG12QjB3ME5HSjlsWWZrdi8yK0lSaURWcEFkejJaR3ZZSkdw?=
 =?utf-8?B?MDg4cFhIbUE5MlVNUEJwNE1lWE5wUmdycEVRNlBoZUZmelNaSGM0QjhTc2Vz?=
 =?utf-8?B?dE1SSWl4dEcyMjBibEZ5dUgrUEZ5OVJDWXpsVEEvWVBOcjdObUZXVDhOQmNo?=
 =?utf-8?B?c2VCVFFUZlliL0hJaGlQODZSUHZjQ2ZtQ2hxcmdxWXkzdTBVVGpCQXZRcEl4?=
 =?utf-8?B?YXgvKy92R0loQU93dHAxTnE0ays3ZEZnditTUlljdm1Rc016clFaVFJ5VzM4?=
 =?utf-8?B?VU1GNlNZU2NlSTVxQlNoK0F6dWllK09OUVRLRFpUMVJCbml4dVRxb2hRZDlk?=
 =?utf-8?B?a3FKd3ZUT0UyaGxWa0hpTmhKeWw1SVFCYmh4cWxtZUlVOGloZjlWQWt0NDRu?=
 =?utf-8?B?c3ZSNmFVN3Z3Wm1yKzZCclRaUzk0azN5U0wxdGtodW00RnErWHRLRzlENGll?=
 =?utf-8?B?ci9kRjVqdDg2bXdSdFJJd2Z1aUFJcWRGS0tlOUNkUVNidU1Uanc3dFpYNnlp?=
 =?utf-8?B?RnhIOVdKZlpFamt1U3p4R2xWdnk5NWkzeHRtWmhvQngzVVozTWNBWTdIMUZJ?=
 =?utf-8?B?TTZBNzBsZmJDOG5SMmpWQkN6bHBqV2VOOFErdXNYeUNFb25wYW9UcUhkSk5v?=
 =?utf-8?B?MzlNWlJRUElHQWM0WnV5U21vak9oYTUxWWI2RWZyYTBPdDBqT1l4NlhrdGdj?=
 =?utf-8?B?aFNNc3ZYaHlPbmVCU2Y2dFhpOWp0MGIvUE1ySUV6RFV6ald5cFV5WkRIdGJV?=
 =?utf-8?B?RFozMUwxUXp5UVNrQWJvckE1UjhId08xSTZiaWNWMHBWNk9vdFZ6Rzdqd2ZF?=
 =?utf-8?B?aWUvSDNVVDJjamFkMks4UjlCYzNUWHBiQTNlcVFTYXBsMnhISVZyRTlyNmxG?=
 =?utf-8?B?MytnVnBYR0dUMmRSSTZ3Z0FlSFMvRmFCYlNINW11QWZqcXVjZ3ArWDdaTmJo?=
 =?utf-8?B?K294N3hBL3c1aDBqWEFKTm1PS2piRGNXTEhLdTR6VmlWcGY5THNsRlZ5ODg5?=
 =?utf-8?B?N1ZuTEpVdzVyMFFZSmVLajFJVTBHc3hpSDQ3M2VjNSs4TmpmRkhSL1Q0amlS?=
 =?utf-8?B?eXNYUnQwMmFMdm1vWlJFcStncnJxRThMWjdsQWI4bW9WZHd5N0hTZTZQbnFY?=
 =?utf-8?B?VzNDa2hYQTB3bkwrN2xML3E2ekd4QkxiZWZ5YzMrM2U4dHJEeDhhSEszRU1x?=
 =?utf-8?B?dzdTTEtUb3krVjg0bysxUk50NDVoWXVTb1E4YUVPV2x4Qy9pcWhLYnFnOSt5?=
 =?utf-8?B?cmtwWHZWN0ZSRTV2MEhUR1JERGNiNCt3TUwvWmZydGRkWUhjTE5jdWs3Mm1p?=
 =?utf-8?B?ck5VVXZUa01Ca0VoQ055SExwRDM5cHV5TzNVTWFDUE14R2JEMW9LVjJBVkZz?=
 =?utf-8?B?YkV5Y2cvaWx2blhTdnVmVDhoMFRwSlZDNXFQakhZVEVuYTdUNi9DMWh6SkdY?=
 =?utf-8?Q?ZkLKYXQoAefOu1oEV9BnJJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8300cd-3664-47d2-af62-08d9ab9030c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2021 19:10:02.9966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A8mE8oOXaYIDAJOCdXYTgdIwVCU7nOoD9y9XwlLzxUEcvTCaan+kU39Xt58JQ/cYl460PY78iWqsF/y1k766PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3142
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxOSwgMjAyMSAxOjU1IFBNDQo+IFRvOiBTaWRlciwgR3JhaGFtIDxHcmFo
YW0uU2lkZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+OyBLdWVobGluZywgRmVsaXgNCj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80XSBkcm0vYW1ka2ZkOiBhZGQga2ZkX2RldmljZV9p
bmZvX2luaXQgZnVuY3Rpb24NCj4gDQo+IE9uIEZyaSwgTm92IDE5LCAyMDIxIGF0IDExOjI4IEFN
IEdyYWhhbSBTaWRlciA8R3JhaGFtLlNpZGVyQGFtZC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
SW5pdGlhbGl6ZXMgZGV2aWNlX2luZm8gc3RydWN0cyBnaXZlbiBlaXRoZXIgYXNpY190eXBlIChl
bnVtKSBpZiBHRlgNCj4gPiB2ZXJzaW9uIGlzIGxlc3MgdGhhbiBHRlg5LCBvciBHQyBJUCB2ZXJz
aW9uIGlmIGdyZWF0ZXIuIEFsc28gdGFrZXMgaW4NCj4gPiB2ZiBhbmQgdGhlIHRhcmdldCBjb21w
aWxlciBnZnggdmVyc2lvbi4NCj4gPg0KPiA+IEluY2x1c2lvbi9leGNsdXNpb24gdG8gY2VydGFp
biBjb25kaXRpb25zIGZvciBjZXJ0YWluIEdDIElQIHZlcnNpb25zDQo+ID4gbWF5IGJlIG5lY2Vz
c2FyeSBvbiBucGkgYnJpbmd1cCBvbiBhIGNhc2UtYnktY2FzZSBiYXNpcywgYnV0IGZvciB0aGUN
Cj4gPiBtb3N0IHBhcnQgc2hvdWxkIGJlIG1pbmltYWwgKGUuZy4gYWRkaW5nIG9uZSB8fCBhc2lj
X3ZlcnNpb24gPT0NCj4gSVBfVkVSU0lPTihYICxYLCBYKSBjYXNlKS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEdyYWhhbSBTaWRlciA8R3JhaGFtLlNpZGVyQGFtZC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyB8IDU4DQo+ID4gKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTggaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5j
DQo+ID4gaW5kZXggZTExZmM0ZTIwYzMyLi4yM2UzNWE0NjZjZjAgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQo+ID4gQEAgLTUxMSw2ICs1MTEsNjQg
QEAgc3RhdGljIHZvaWQga2ZkX2d0dF9zYV9maW5pKHN0cnVjdCBrZmRfZGV2ICprZmQpOw0KPiA+
DQo+ID4gIHN0YXRpYyBpbnQga2ZkX3Jlc3VtZShzdHJ1Y3Qga2ZkX2RldiAqa2ZkKTsNCj4gPg0K
PiA+ICtzdGF0aWMgdm9pZCBrZmRfZGV2aWNlX2luZm9faW5pdChzdHJ1Y3Qga2ZkX2RldmljZV9p
bmZvICpkZXZpY2VfaW5mbywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCBhc2ljX3ZlcnNpb24sIGJvb2wgaXNfc29jMTUsDQo+ID4gK2Jvb2wgdmYsDQo+IA0K
PiBJJ20gbm90IGNyYXp5IGFib3V0IHJldXNpbmcgYXNpY192ZXJzaW9uIGZvciBib3RoIHRoZSBH
QyB2ZXJzaW9uIGFuZCB0aGUgYXNpYw0KPiB0eXBlLiAgU2VlbXMgbGlrZSBpdCB3b3VsZCBiZSBl
YXNpZXIgdG8ganVzdCBwYXNzIGFkZXYgYW5kIGFjY2VzcyB3aGF0IHlvdQ0KPiBuZWVkIGRpcmVj
dGx5Lg0KPiANCj4gQWxleA0KPiANCg0KVGhhdCdzIGZhaXIsIEkgd2FzIG9uIHRoZSBmZW5jZSBh
Ym91dCBpdCBhcyB3ZWxsLiBJIHRoaW5rIHNldHRpbmcgc29tZSB2YXJzIHZpYSBhZGV2IGluIGRl
dmljZV9pbmZvX2luaXQgaXRzZWxmIGlzIGEgZ29vZCBtaWRkbGUgZ3JvdW5kIGluIHRlcm1zIG9m
IHZlcmJvc2l0eSAod2hhdCBJIHdhcyBhdHRlbXB0aW5nIHRvIGxpbWl0IHRvIGEgZGVncmVlIGhl
cmUpLiBUaGFua3MgZm9yIHRoZSByZWNvbW1lbmRhdGlvbi4NCg0KR3JhaGFtDQoNCj4gDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgZ2Z4X3RhcmdldF92ZXJz
aW9uKSB7DQo+ID4gKyAgICAgICBkZXZpY2VfaW5mby0+bWF4X3Bhc2lkX2JpdHMgPSAxNjsNCj4g
PiArICAgICAgIGRldmljZV9pbmZvLT5tYXhfbm9fb2ZfaHFkID0gMjQ7DQo+ID4gKyAgICAgICBk
ZXZpY2VfaW5mby0+bnVtX29mX3dhdGNoX3BvaW50cyA9IDQ7DQo+ID4gKyAgICAgICBkZXZpY2Vf
aW5mby0+bXFkX3NpemVfYWxpZ25lZCA9IE1RRF9TSVpFX0FMSUdORUQ7DQo+ID4gKyAgICAgICBk
ZXZpY2VfaW5mby0+Z2Z4X3RhcmdldF92ZXJzaW9uID0gZ2Z4X3RhcmdldF92ZXJzaW9uOw0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChpc19zb2MxNSkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZp
Y2VfaW5mby0+ZG9vcmJlbGxfc2l6ZSA9IDg7DQo+ID4gKyAgICAgICAgICAgICAgIGRldmljZV9p
bmZvLT5paF9yaW5nX2VudHJ5X3NpemUgPSA4ICogc2l6ZW9mKHVpbnQzMl90KTsNCj4gPiArICAg
ICAgICAgICAgICAgZGV2aWNlX2luZm8tPmV2ZW50X2ludGVycnVwdF9jbGFzcyA9ICZldmVudF9p
bnRlcnJ1cHRfY2xhc3Nfdjk7DQo+ID4gKyAgICAgICAgICAgICAgIGRldmljZV9pbmZvLT5zdXBw
b3J0c19jd3NyID0gdHJ1ZTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmICgoYXNpY192
ZXJzaW9uID49IElQX1ZFUlNJT04oOSwgMCwgMSkgICYmDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgYXNpY192ZXJzaW9uIDw9IElQX1ZFUlNJT04oOSwgMywgMCkpIHx8DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgYXNpY192ZXJzaW9uID09IElQX1ZFUlNJT04oMTAsIDMsIDEpIHx8DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgYXNpY192ZXJzaW9uID09IElQX1ZFUlNJT04oMTAsIDMsIDMp
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV9pbmZvLT5udW1fc2RtYV9xdWV1
ZXNfcGVyX2VuZ2luZSA9IDI7DQo+ID4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBkZXZpY2VfaW5mby0+bnVtX3NkbWFfcXVldWVzX3Blcl9lbmdpbmUg
PSA4Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgLy8gTmF2aTJ4KywgTmF2aTF4Kw0KPiA+
ICsgICAgICAgICAgICAgICBpZiAoYXNpY192ZXJzaW9uID49IElQX1ZFUlNJT04oMTAsIDMsIDAp
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldmljZV9pbmZvLT5ub19hdG9taWNfZndf
dmVyc2lvbiA9IDE0NTsNCj4gPiArICAgICAgICAgICAgICAgZWxzZSBpZiAoYXNpY192ZXJzaW9u
ID49IElQX1ZFUlNJT04oMTAsIDEsIDEpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRl
dmljZV9pbmZvLT5ub19hdG9taWNfZndfdmVyc2lvbiA9IDkyOw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgLy8gUmF2ZW4NCj4gPiArICAgICAgICAgICAgICAgaWYgKGFzaWNfdmVyc2lvbiA9
PSBJUF9WRVJTSU9OKDksIDEsIDApIHx8DQo+ID4gKyAgICAgICAgICAgICAgICAgICBhc2ljX3Zl
cnNpb24gPT0gSVBfVkVSU0lPTig5LCAyLCAyKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZpY2VfaW5mby0+bmVlZHNfaW9tbXVfZGV2aWNlID0gdHJ1ZTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgIC8vIE5hdmkxeCsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFzaWNfdmVy
c2lvbiA+PSBJUF9WRVJTSU9OKDEwLCAxLCAxKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBkZXZpY2VfaW5mby0+bmVlZHNfcGNpX2F0b21pY3MgPSB0cnVlOw0KPiA+ICsgICAgICAgfSBl
bHNlIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2aWNlX2luZm8tPmRvb3JiZWxsX3NpemUgPSA0
Ow0KPiA+ICsgICAgICAgICAgICAgICBkZXZpY2VfaW5mby0+aWhfcmluZ19lbnRyeV9zaXplID0g
NCAqIHNpemVvZih1aW50MzJfdCk7DQo+ID4gKyAgICAgICAgICAgICAgIGRldmljZV9pbmZvLT5l
dmVudF9pbnRlcnJ1cHRfY2xhc3MgPQ0KPiAmZXZlbnRfaW50ZXJydXB0X2NsYXNzX2NpazsNCj4g
PiArICAgICAgICAgICAgICAgZGV2aWNlX2luZm8tPm51bV9zZG1hX3F1ZXVlc19wZXJfZW5naW5l
ID0gMjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChhc2ljX3ZlcnNpb24gIT0gQ0hJ
UF9LQVZFUkkgJiYNCj4gPiArICAgICAgICAgICAgICAgICAgIGFzaWNfdmVyc2lvbiAhPSBDSElQ
X0hBV0FJSSAmJg0KPiA+ICsgICAgICAgICAgICAgICAgICAgYXNpY192ZXJzaW9uICE9IENISVBf
VE9OR0EpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2aWNlX2luZm8tPnN1cHBvcnRz
X2N3c3IgPSB0cnVlOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFzaWNfdmVyc2lv
biA9PSBDSElQX0tBVkVSSSB8fA0KPiA+ICsgICAgICAgICAgICAgICAgICAgYXNpY192ZXJzaW9u
ID09IENISVBfQ0FSUklaTykNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZpY2VfaW5m
by0+bmVlZHNfaW9tbXVfZGV2aWNlID0gdHJ1ZTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAg
IGlmIChhc2ljX3ZlcnNpb24gIT0gQ0hJUF9IQVdBSUkgJiYgIXZmKQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGRldmljZV9pbmZvLT5uZWVkc19wY2lfYXRvbWljcyA9IHRydWU7DQo+ID4g
KyAgICAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0cnVjdCBrZmRfZGV2ICprZ2Qya2ZkX3By
b2JlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIHZmKSAgew0KPiA+ICAgICAgICAg
c3RydWN0IGtmZF9kZXYgKmtmZDsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
