Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38506C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 19:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A580010E055;
	Thu, 27 Apr 2023 19:39:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355A310E055
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 19:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BypIEDZ+qQTDcEUN0wsiK9oiJ0caKNRtfLndDjJwogQ4wQWyHDEacaD/eLamFD1y8SJ86JB8sETaZdBD1wbWzqrzYW2bGD4sHIDp9qY6zKxzIUwcFYT9lH1kDI+Kv8PLBBzI7UkjtR17pYJdLknGn48SN5TJWA9uqmi7EC21idxDkCQN0w4O9UUmiO55T/bPudpeIcf5y4qx8S6p8jLWfn1/3iRQgnWa17GFz429S1CEhVog0daJgWsAOXZLuUAOMFJsORz5/jlX0mdbm5v9di/J0f78vjLk6IuIpjNDVM4xgDMzbHI4Zboy4T28y54LbAtojUKk0tLWSIljyV/vPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIp9v0EwwOFCNYzsut3DFL8mQBDe+/BrGp89wDOWLRg=;
 b=dqTKEEu/1OnXjqDwgFXDM8KbBPJqZH1sey2i+9nyPXw+yQV2Ls04QvRSo9nfcILlui0qE7Qu6U0QqcYPEw7/gSfVEgv+zuArgoCnKRanLT+2btAxksIvaqCvvIA2BBGOXHB/ajQvtZSfHTicCRSlQCjXTAzQ5xrIaW12inaXRDAD+YNpnvdiagMYlQT7a6kzDev/GyGYP5MofftdU40E11EUf7sjaHTKHtXnNAjIryUZYfAWc0KDDLqt/SDBemBqvENUsOADAcXndCls4lL+p6McsuJxqNm27HkAzY4H74qWQfESLyV8nVWIgiB7Zid4Mn5EAoqpH66pVrGCL5roJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIp9v0EwwOFCNYzsut3DFL8mQBDe+/BrGp89wDOWLRg=;
 b=jbGVJXlPu9W1MyOpguzCgdy/g3IY8GAiey9PBr2N6CA8hqfC6qNXXwlcAv0ZIObgVuu5OtEl77ozQIbbeWBntumXfxp0TVWtev4HXOpSECh7YhHqp1wU5zfu/QbQthHoXU+5piu9u0JVcfHzyrHffTNe0pd1M+LEUAyz2BCEgZs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Thu, 27 Apr
 2023 19:39:00 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 19:39:00 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Simplify switch case statements in
 amdgpu_connectors.c
Thread-Topic: [PATCH] drm/amd/amdgpu: Simplify switch case statements in
 amdgpu_connectors.c
Thread-Index: AQHZeRk+N+SmXnVDTEeud45BDJh6UK8/jRoQ
Date: Thu, 27 Apr 2023 19:39:00 +0000
Message-ID: <BL1PR12MB51443793A577AE1F30F05377F76A9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230427150154.2073742-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230427150154.2073742-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-27T19:38:59Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=910658a5-a2dd-4931-b270-66432f644848;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-27T19:38:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 8d66ee8b-7098-4dfb-86d8-a7b031f78f8c
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB8818:EE_
x-ms-office365-filtering-correlation-id: d6cf27a6-c563-4a35-b9ed-08db47570cfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOjA/JjYupEuiE0oF+QFWbO0K5MmYmd3IVq8Yb4NqdlTFD2M9PFRpr7/ZYVgQcfzoEhDoe8+07nclzMZz7QiCseE17d6BAvYvxoZVHXYg14zSGhve3dHeDVcMM0lBuf466Nwl3336DNoG8LyCaM4/SLQQAcCnYTxKpW7Jxp0xUjyidRphZkevipVVoNyhdnQUfJF56zhc0lps5PLKZ8MYnkolHFolu14RXJbO5y+BnzT4+oijcq5VJSduHpcJyUWKqB5tzlLIO5/97X0dj9qD5qPK16F1bF2r1syRb9gN43FzPFRUGV4JIDVVcUPFJ3tuCRbOTYnR/lTkwEBlf4P4hSRRJaH55kVdSUVX+HO7BRcUToCtbVrmRUDotuLfjvISyS3yL9cAV1SbFj7+lBa747JYpJsMblGnMIat3l8WpRA5IBzD8cafblzSxsguISslIjf8PYkyN/GgKGOGGi8ThJZ+TihRpf6kA6+zVDlFv3s1Y5X3ZII91AlPKdl2MB2U+RhETB3qVqPaU/NFhVTYtBXugQOca756BJeeMlzdYJd32jxdVRRt+OmDZD/HCt0FVkWKlg4ALUVgGon3LY0aTSiucgO8TNom0Y3quwfagN9FxzzipdJtRZG2WUYg3x7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(33656002)(66446008)(4326008)(186003)(76116006)(66574015)(53546011)(83380400001)(71200400001)(110136005)(7696005)(26005)(478600001)(9686003)(6506007)(55016003)(8676002)(5660300002)(52536014)(122000001)(66946007)(2906002)(86362001)(64756008)(38100700002)(66476007)(6636002)(41300700001)(66556008)(38070700005)(8936002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eml6dmpyd2txRUtQcUc5OUpnSFN4a3h5OVhaVnlYcDYrV2lWc3FLU2JhZWJV?=
 =?utf-8?B?eE1XZEw3VStDZktHaldoWjZDaWZPMGFlQmJtYjVXMEx2cE04dHVHSVdhNFg5?=
 =?utf-8?B?QVRyNXRXTGNCbVphaDYzMkV6U2RUd0hBL3llZXlxb3FZZnFsNVNCY1h5YjR0?=
 =?utf-8?B?Z1hJZkgrSm03TXhKR0d5RUd1N2krMzBiZ2h3ZnNURERqeUg3czI3V3hndFhS?=
 =?utf-8?B?dlpueXljQzlSNGZjbmx0S0RlUDIrbkdDMWx5dlBtNG52S3dCNGxleTFCc3pJ?=
 =?utf-8?B?SEJLSWk5aVpzTm51OStMR21mREdhbU5ZMjFnQmZ2UnEzaVNFYkNoQVJtWW0y?=
 =?utf-8?B?dzN2ZER3V0VBVzZuS0ZWQ2o2Z0tzdGZhTFYvdk9nWW94d0hkRml3U1hnY2xu?=
 =?utf-8?B?NEJ5VXlPMlExdmx1RkZMKzdrNTIyM1RSclprY1crM3VKOFRIa1Q3L2VIU2p3?=
 =?utf-8?B?RCtMVnZGSFkwTkgrV3VEc3JVS3RPdy84OGxvQTBIZStJNmxDMEU0UDcxSEFm?=
 =?utf-8?B?cnFjbjMzeTBmeWNHb003TXdjL05acmswZnFqeHgrZG9rTklSa3h5cWhqbnZH?=
 =?utf-8?B?TVlzbVlZMEhYNG1palQvWW1HdmQ3VyszQmkzZ2RlT1FVbElTbDE0RGlvcWVa?=
 =?utf-8?B?UjZ3bkJFMXhXWW01TTlRUGx2UmVYOUhoTGlCYjZ2NHRBMDg3TWNuT0lnbGwz?=
 =?utf-8?B?NTlLcjZrK2pPaXgvRFVndVNTOVJwY1U5L3gvUHZRWkVnb2RlSzhldG9EbHdF?=
 =?utf-8?B?VWptTlRaMDBqakVGdFBrLzVCc2NBWW5ieFhkQ1VOd0pSQWhxVkNkV0ZpcFdh?=
 =?utf-8?B?K0EwbkdTTHFFTTd3VXhCL29pY0RqNHBUd3FZSHg1SXR0cmVPcmFEcVlYUHdO?=
 =?utf-8?B?aTJWNjg4NWNqdVlNTjZ0alF0Zm1DM2F3L0VBZjBxUm0vWURaUUZRM3BJM3hY?=
 =?utf-8?B?UzcrdTBoVGhoZ3NYb1lPZ09JeTE0NGpQaFRMTmp4OFZvcVJoeXVmSWhGdDYx?=
 =?utf-8?B?cURNL0JMa1NxMkhucG1xTEZWaG53ZUYyQ25tWlRBbnpONTgvRFFYaGNtUG16?=
 =?utf-8?B?bkx5T2xwckV6TFM0RHU3OXRWamJWTjZFaEdxL2pPV1hpYTlCczhqcmdwVVIy?=
 =?utf-8?B?eHF2L2l4ZGNvb2g0aXFVbmxwcE9qQWpPREVGL2tXMUQ2enloYWdXRGlHTlBI?=
 =?utf-8?B?enlnUGlIaHVyMGh5em1TNHB1S0QzSTI4WGxMRWNKbkJVWG5Oa3RjeXB6Z0Z6?=
 =?utf-8?B?SEdaNFh5L21XQ2tXTTRCQ3g4MU5GS1Y4UWtoeU9MWng3UXpJbVpySmxkTm5h?=
 =?utf-8?B?WGRXeFYvT0oxaUt4NGNuMUc3djhmbVE0M2cyTlNrWFk2NVJ1alVCL1h2TEFQ?=
 =?utf-8?B?clNRQWc4SFJ4dm1sZnhUZ05wRkJCbk4xWmRZblRQOTArN0RHQm5UVmQvYk1m?=
 =?utf-8?B?SnpObTgzQkdMdmx3L3NNYzlLOXFOMWhqa0ZWMmpORUhsY1h0Y0ZLOXVldW10?=
 =?utf-8?B?QU1uNWxQeGJ6azFOMWFIa1QzZlVTWHltTHBpVGk2YWREbEo1aTVXR2pEU1ha?=
 =?utf-8?B?M0kwUjZxMGRDVVNDdUJGUHpVbkorS3hjKzRqMWQrQ3pnWVVsUlRLTllQb2dE?=
 =?utf-8?B?dWNkU056cDV6clBwRzBjY2poYTRYdW8xbHg4anBzOHhTNzhPNXpRRGV0OWFm?=
 =?utf-8?B?elYwcG5aaE0rSk5VZ0ZqdjJ1TDczT0lXT1FrWWgraXU3UlhNNDh0ZiswWHJH?=
 =?utf-8?B?WXpwV2UzUU42TVdKOWhaNnBqaDd1ODBhQ3dvRzArNFowTzBNUUVpZ2hCamNF?=
 =?utf-8?B?WEJ0aGllWS9GczFOVTdXZWRET2FSaExmT3p2bWFWYWplb2lhT0h5azEzUCtp?=
 =?utf-8?B?SENlZzdTYjY0MVVEMVpRcTNvN011VGdDUzBkWmdwODh5dGlQM3paR21uL0la?=
 =?utf-8?B?QUZadTlZeHZsYmJDMHhkS1RnWXgvcDJOb1ZKcWsvbHVCbEtOcyt4Z0JmVDRF?=
 =?utf-8?B?S2U2R09vN1dPTDRvVHNBUTFvN0hjQ0YwLy95Qlppb3FJYXFzanhHRk4wbWF3?=
 =?utf-8?B?Qm5vZWR5WjV2WHR4VDNKSFRnQ3NXOGxRbmdqOG5COWp1aERuWndQeTBRSnI4?=
 =?utf-8?Q?CG4w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cf27a6-c563-4a35-b9ed-08db47570cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 19:39:00.8645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPMkv9/uGmd3/Jm/Bj8p3hGN3WNNzK8ctP1o/rhgQVIMEx/p+d3iJ1cP9w3618RAn7icXN287E6vEc1Bqy6Mdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTSEFOTVVH
QU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQo+IFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAyNywgMjAyMyAxMTowMiBBTQ0KPiBUbzogS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZC9hbWRncHU6IFNpbXBsaWZ5IHN3aXRjaCBj
YXNlIHN0YXRlbWVudHMgaW4NCj4gYW1kZ3B1X2Nvbm5lY3RvcnMuYw0KPiANCj4gRml4IHRoZSBm
b2xsb3dpbmcgY2hlY2twYXRjaCBlcnJvcnM6DQo+IA0KPiBFUlJPUjogdHJhaWxpbmcgc3RhdGVt
ZW50cyBzaG91bGQgYmUgb24gbmV4dCBsaW5lDQo+IEVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRl
ciB0aGF0ICcsJyAoY3R4OlZ4VikNCj4gRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCB1c2UgdGFi
cyB3aGVyZSBwb3NzaWJsZQ0KPiANCj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVnYW0gPHNyaW5pdmFzYW4u
c2hhbm11Z2FtQGFtZC5jb20+DQoNCkkgY291bGQga2luZCBvZiBnbyBlaXRoZXIgd2F5IG9uIHRo
ZXNlIHBhdGNoZXMuICBJIGd1ZXNzIHRoZXkgZml4IHVwIHRoZSBjb2Rpbmcgc3R5bGUsIGJ1dCB0
aGV5IGFsc28gbWFrZSBhIGxvdCBvZiBjaHVybiBpbiB0aGUgY29kZS4NCg0KQWNrZWQtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiAtLS0NCj4gIC4uLi9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYyAgICB8IDM5ICsrKysrKysrKysr
KysrLS0NCj4gLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Nvbm5lY3RvcnMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jb25uZWN0b3JzLmMNCj4gaW5kZXggZDJhYmQzMzRiMWI1Li4wOGEzN2I3YTM0ZjQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYw0K
PiBAQCAtNTkxLDExICs1OTEsMjAgQEAgc3RhdGljIGludCBhbWRncHVfY29ubmVjdG9yX3NldF9w
cm9wZXJ0eShzdHJ1Y3QNCj4gZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yLA0KPiANCj4gIAkJc3dp
dGNoICh2YWwpIHsNCj4gIAkJZGVmYXVsdDoNCj4gLQkJY2FzZSBEUk1fTU9ERV9TQ0FMRV9OT05F
OiBybXhfdHlwZSA9IFJNWF9PRkY7DQo+IGJyZWFrOw0KPiAtCQljYXNlIERSTV9NT0RFX1NDQUxF
X0NFTlRFUjogcm14X3R5cGUgPQ0KPiBSTVhfQ0VOVEVSOyBicmVhazsNCj4gLQkJY2FzZSBEUk1f
TU9ERV9TQ0FMRV9BU1BFQ1Q6IHJteF90eXBlID0gUk1YX0FTUEVDVDsNCj4gYnJlYWs7DQo+IC0J
CWNhc2UgRFJNX01PREVfU0NBTEVfRlVMTFNDUkVFTjogcm14X3R5cGUgPQ0KPiBSTVhfRlVMTDsg
YnJlYWs7DQo+ICsJCWNhc2UgRFJNX01PREVfU0NBTEVfTk9ORToNCj4gKwkJCXJteF90eXBlID0g
Uk1YX09GRjsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIERSTV9NT0RFX1NDQUxFX0NFTlRFUjoN
Cj4gKwkJCXJteF90eXBlID0gUk1YX0NFTlRFUjsNCj4gKwkJCWJyZWFrOw0KPiArCQljYXNlIERS
TV9NT0RFX1NDQUxFX0FTUEVDVDoNCj4gKwkJCXJteF90eXBlID0gUk1YX0FTUEVDVDsNCj4gKwkJ
CWJyZWFrOw0KPiArCQljYXNlIERSTV9NT0RFX1NDQUxFX0ZVTExTQ1JFRU46DQo+ICsJCQlybXhf
dHlwZSA9IFJNWF9GVUxMOw0KPiArCQkJYnJlYWs7DQo+ICAJCX0NCj4gKw0KPiAgCQlpZiAoYW1k
Z3B1X2VuY29kZXItPnJteF90eXBlID09IHJteF90eXBlKQ0KPiAgCQkJcmV0dXJuIDA7DQo+IA0K
PiBAQCAtNzk3LDEyICs4MDYsMjEgQEAgc3RhdGljIGludA0KPiBhbWRncHVfY29ubmVjdG9yX3Nl
dF9sY2RfcHJvcGVydHkoc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwNCj4gIAl9DQo+
IA0KPiAgCXN3aXRjaCAodmFsdWUpIHsNCj4gLQljYXNlIERSTV9NT0RFX1NDQUxFX05PTkU6IHJt
eF90eXBlID0gUk1YX09GRjsgYnJlYWs7DQo+IC0JY2FzZSBEUk1fTU9ERV9TQ0FMRV9DRU5URVI6
IHJteF90eXBlID0gUk1YX0NFTlRFUjsgYnJlYWs7DQo+IC0JY2FzZSBEUk1fTU9ERV9TQ0FMRV9B
U1BFQ1Q6IHJteF90eXBlID0gUk1YX0FTUEVDVDsgYnJlYWs7DQo+ICsJY2FzZSBEUk1fTU9ERV9T
Q0FMRV9OT05FOg0KPiArCQlybXhfdHlwZSA9IFJNWF9PRkY7DQo+ICsJCWJyZWFrOw0KPiArCWNh
c2UgRFJNX01PREVfU0NBTEVfQ0VOVEVSOg0KPiArCQlybXhfdHlwZSA9IFJNWF9DRU5URVI7DQo+
ICsJCWJyZWFrOw0KPiArCWNhc2UgRFJNX01PREVfU0NBTEVfQVNQRUNUOg0KPiArCQlybXhfdHlw
ZSA9IFJNWF9BU1BFQ1Q7DQo+ICsJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+IC0JY2FzZSBEUk1f
TU9ERV9TQ0FMRV9GVUxMU0NSRUVOOiBybXhfdHlwZSA9IFJNWF9GVUxMOw0KPiBicmVhazsNCj4g
KwljYXNlIERSTV9NT0RFX1NDQUxFX0ZVTExTQ1JFRU46DQo+ICsJCXJteF90eXBlID0gUk1YX0ZV
TEw7DQo+ICsJCWJyZWFrOw0KPiAgCX0NCj4gKw0KPiAgCWlmIChhbWRncHVfZW5jb2Rlci0+cm14
X3R5cGUgPT0gcm14X3R5cGUpDQo+ICAJCXJldHVybiAwOw0KPiANCj4gQEAgLTExMjUsNyArMTE0
Myw4IEBAIGFtZGdwdV9jb25uZWN0b3JfZHZpX2RldGVjdChzdHJ1Y3QNCj4gZHJtX2Nvbm5lY3Rv
ciAqY29ubmVjdG9yLCBib29sIGZvcmNlKQ0KPiAgCQkJCQkvKiBhc3N1bWUgZGlnaXRhbCB1bmxl
c3MgbG9hZA0KPiBkZXRlY3RlZCBvdGhlcndpc2UgKi8NCj4gIAkJCQkJYW1kZ3B1X2Nvbm5lY3Rv
ci0+dXNlX2RpZ2l0YWwgPQ0KPiB0cnVlOw0KPiAgCQkJCQlscmV0ID0gZW5jb2Rlcl9mdW5jcy0N
Cj4gPmRldGVjdChlbmNvZGVyLCBjb25uZWN0b3IpOw0KPiAtCQkJCQlEUk1fREVCVUdfS01TKCJs
b2FkX2RldGVjdCAleA0KPiByZXR1cm5lZDogJXhcbiIsZW5jb2Rlci0+ZW5jb2Rlcl90eXBlLGxy
ZXQpOw0KPiArCQkJCQlEUk1fREVCVUdfS01TKCJsb2FkX2RldGVjdCAleA0KPiByZXR1cm5lZDog
JXhcbiIsDQo+ICsJCQkJCQkgICAgICBlbmNvZGVyLT5lbmNvZGVyX3R5cGUsDQo+IGxyZXQpOw0K
PiAgCQkJCQlpZiAobHJldCA9PQ0KPiBjb25uZWN0b3Jfc3RhdHVzX2Nvbm5lY3RlZCkNCj4gIAkJ
CQkJCWFtZGdwdV9jb25uZWN0b3ItDQo+ID51c2VfZGlnaXRhbCA9IGZhbHNlOw0KPiAgCQkJCX0N
Cj4gQEAgLTE5ODksNyArMjAwOCw3IEBAIGFtZGdwdV9jb25uZWN0b3JfYWRkKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+ICphZGV2LA0KPiAgCWlmIChhbWRncHVfY29ubmVjdG9yLT5ocGQuaHBkID09
IEFNREdQVV9IUERfTk9ORSkgew0KPiAgCQlpZiAoaTJjX2J1cy0+dmFsaWQpIHsNCj4gIAkJCWNv
bm5lY3Rvci0+cG9sbGVkID0NCj4gRFJNX0NPTk5FQ1RPUl9QT0xMX0NPTk5FQ1QgfA0KPiAtCQkJ
ICAgICAgICAgICAgICAgICAgICBEUk1fQ09OTkVDVE9SX1BPTExfRElTQ09OTkVDVDsNCj4gKw0K
PiAJRFJNX0NPTk5FQ1RPUl9QT0xMX0RJU0NPTk5FQ1Q7DQo+ICAJCX0NCj4gIAl9IGVsc2UNCj4g
IAkJY29ubmVjdG9yLT5wb2xsZWQgPSBEUk1fQ09OTkVDVE9SX1BPTExfSFBEOw0KPiAtLQ0KPiAy
LjI1LjENCg==
