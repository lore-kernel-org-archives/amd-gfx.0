Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00D4C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 16:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A33510E683;
	Wed,  8 Mar 2023 16:30:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC28410E683
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Mar 2023 16:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkMNTMpgnwhfZhh28X0fTrvd7osxWfl2lSS/2c6AAgMyBk8VUcOEuJIdsCPxMjgFYppR/0Y7QhcK5Er8/9md/frbVVrwmFNRbYDe/twjT4Ro16fJy9KmBncsra7aPA5oxdlGCnuA5HgUNmClICzrDHbflm1N0yQT5Yd1mbSqu2xUIa57I2eH3swkiPAYRIvbJ23zlkJrw3C9VgEja6QIvB7ZLseeMWWKTnT1n1dEMTyq11lvLZWpgp6DmYq+aDTu70OMC4qHevidw2Kmz/V0u/eT7NRvtXFAdqaVnGO3oB2h0GVSyr1qB7b0T/Ao4CfT2R7WC7CgDLod6RYCh+AIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUaSkA7BCw5m410d3IL7fA1GbYeV6/JELfs0QJ+Dj04=;
 b=YZeTF8AzaR/Mejl/HOXyhHZM5HSFU/910idK2weJdFch4edCvGzsmkekM4HFCRC64JPQ6RNh31miRbGO/BQ9A2YZVGLkf4824p/IvrYV5/Zgc6XA8wwkKK9p4i397A8fv2Rzn36MlIp3d04Ws5oRSRioJdix/5wQvxK5vQrBlRed/ojSW1OXnJTMZ+REsqxxtyDiHJ6WskJCpYcXnzdSlnsxkJG3OoUBX9h2As/cxUNK3Ubq+zlGTfA9zdsuTau+5bQzooKvaYOQx5SU4kH0C+LYbTcGkcTqU34wjT9qgk94XWr8SydalsEnuo5p2QlXHyVHycdwP/R1wYrS70SVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUaSkA7BCw5m410d3IL7fA1GbYeV6/JELfs0QJ+Dj04=;
 b=DLuNXQRuUu2dB7f4Rar+qAEqb0Rh5SRJjqHwMZvAkumYXRrzGEGZFjJy1n/NTE/yzQJY/X2gUsNddP+nfHRvEBtGnyjExLRVIJ+8ONI1Ei7W006l3wMZhPNTYGHj4cOGa8Q66sWzy7EXdUZfxfQPMF9ehCzph8+zA84HZ/HJ62E=
Received: from PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 16:29:58 +0000
Received: from PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3bb0:da9a:5a44:8e32]) by PH7PR12MB5831.namprd12.prod.outlook.com
 ([fe80::3bb0:da9a:5a44:8e32%4]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 16:29:58 +0000
From: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/amdkfd: Fix build error with unmatched
 argument type
Thread-Topic: [PATCH 2/2] drm/amd/amdkfd: Fix build error with unmatched
 argument type
Thread-Index: AQHZUaEz0sRFa3ajqkK/zgbM2WmeSq7xCWmAgAAJPXA=
Date: Wed, 8 Mar 2023 16:29:58 +0000
Message-ID: <PH7PR12MB583118531A90920B445BA4C1FBB49@PH7PR12MB5831.namprd12.prod.outlook.com>
References: <20230308093408.239331-1-qingqing.zhuo@amd.com>
 <20230308093408.239331-2-qingqing.zhuo@amd.com>
 <76a93d71-2a37-5dde-08a9-5460dddb6379@amd.com>
In-Reply-To: <76a93d71-2a37-5dde-08a9-5460dddb6379@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-08T16:29:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2774115a-bb11-4bfe-97c2-d052cc3cc67a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-08T16:29:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bda50157-fa09-4d08-87ee-8c47db0fbb47
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5831:EE_|PH7PR12MB8122:EE_
x-ms-office365-filtering-correlation-id: 94a78388-17fb-4de9-dd23-08db1ff25be0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mBQHoAcE6n3Z5K8PpqtNKHwLlcaCJ8i7cdd3wKP1BDWeq6mqYZeEEOGdGR1T+NCDOV68qvBZhYHr12/fmi4kTvgHIYmdSArWwIjWik7mMJCiAN0U1VgFUIICIcb9Vjo8PE6z/SyfXD5nmtn4nBXpQP9+oOr88GN2APKW4/71jbVH2S8SMXfWW4Ru3Mo7p6G0NPU+atKGjAFJGs9ANLditdc/uIquTJV6JPdvhchwlNwUf9vPDeiJvdpiFrsekC4c206jo65BVkzp1ukCEg0Eeg40xCIEQyxzMLEEoV5ivgg4NuYzIoZ2OY+9K2OzL8G939J/HhT/rdT0NMFhsP5ICrS0c9POVHtNyh1ciAx3RVkoPgIieQ8GFwSPQD9trCvKFf9pPm8gH7CpP4bIduGpTNrxDW1MLMm2fdxnA0ZnVQV6qNM1MmNwH5dDbpoVy2uGMV0jFTyTEMBYkih8qa6CU56Jpz/xJej4M9FkexlFBroQwU2+SmlVEo4XqZISp8k1DU0eIlQnfKO3VxHTrVcBZTwGfaObMOEajAPxIYfka8tHnL0qPmYV1H3umd5F+yNU5W4+i/P7vIkKI6Hu2adOgxdUYLsdJJnqWlFyWwnzWCoLQJhSV/GCSrjohusWCdzUXeO2YizkhplDKuSLL53zNg1ASy050YJvWHrz2lTcYCPUoGyF6pe5grzY1A6bBo6ArcmiFtpGRQiBAxitiDJfaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5831.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199018)(38070700005)(38100700002)(122000001)(8936002)(33656002)(4326008)(86362001)(8676002)(41300700001)(64756008)(5660300002)(2906002)(52536014)(66946007)(6506007)(26005)(55016003)(66476007)(9686003)(53546011)(83380400001)(186003)(110136005)(478600001)(316002)(54906003)(66446008)(71200400001)(66556008)(76116006)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFpWa2RrZ0VwM0hGVXRvZDNnVVl4WWRQSDhiVHpsRTREdGJ6V3MwQ21CbndL?=
 =?utf-8?B?M2ptNlhvQ0d4dHVVRWl6ZzJHV1VSdEU3L0JVZ2J4V1h0dWwrZnRoVWwyYXJv?=
 =?utf-8?B?ZTZJNTBsQWI2bVVIZTRiL3YwSWtMMEExUVFqdGlMWFRvQ2VYMzRoc0NtdHhC?=
 =?utf-8?B?SUFmQ09BV3FBeCt5SENhRlRpMFE3VXRqMUpLQlcrZjQzUTZYd0FHaFhuQzR5?=
 =?utf-8?B?WDVxS1dVcFd5MXZzY21admhTTUV2UkE4QlFhVDRweENSZmx0R2Q1V1dVNG1G?=
 =?utf-8?B?ZWdobVVJMXhaWHN2aVpnSG9Pbk1paVAwcnB3ZzRZWUJaeW0xYkFsNW5xWWxB?=
 =?utf-8?B?UDg3eEl0Mk9xSTJMdVVLV2JBNzJEZzA5OEQvbGRDZnZLRnhPVXpYWDJhQkVS?=
 =?utf-8?B?ci9ERTduRkIrM2lia1U2TkVtVXd5YllZZTNQQXJvV3hHeVl5OExEY3FtM1Qv?=
 =?utf-8?B?TWpPZUozeEowZDJHcUNTT1RTM2RQdkN2V0tCSW1BUXRMcit6MC92SU1vRkxN?=
 =?utf-8?B?Vi9US2JPQzg2QzVuNU16NzQ5Sm5SNGdTekk2TFl0Z3QvZ3o0QUlhY0dDRVAw?=
 =?utf-8?B?V1lTZUd2SDMxbTVxL0R4SnorbHVmQk9vNlJwaUQ0VmlKc2RJNW80VEhROTdD?=
 =?utf-8?B?WXJIMFUrZWNXWGlzdUJLakttVXdjRmdta1VNOGI4VE9vWVN5dkk5MmRWNHVQ?=
 =?utf-8?B?VUM5dVVDVlNLYkZkVjVGNWVuakhnamhIVFBTR1pRMUdSR21pQmtNWmpZNUMx?=
 =?utf-8?B?SzZhUEpvYnU3aDRwckJOUldlUnlyQU5UWWU4cXNBaytMWlJVdkRZZ0h0ZG9X?=
 =?utf-8?B?RDdRNnJGZldkeEJMcGJJeGNsRFllUVZRYXVvdjhxcWNkVERXbW43eXpIcmZG?=
 =?utf-8?B?ZVF2eXZCT3psSlBCZE5RWUpyR05DQlBGRjVKUEZUTE9xM1RSRlpFbThWa0ZT?=
 =?utf-8?B?TjlFQ0lEMjlQWGlDRlZQekZzSEFESVN0MnBuaEdLNE05WC9VUHE0YUYrMFhh?=
 =?utf-8?B?cUpJV0NmYjlVMlhrOFNMWkpTSTNzSXo0NEZDVFFaU3ZIR01mUTJvamhiRzVT?=
 =?utf-8?B?OWdza3gzZFcveDNyb1BCcWhsU3Z2RlZHVi90QUFmNE1OT1QybGF3cFEyUHZR?=
 =?utf-8?B?ZDZKOE5JRjFmV3F1Zkk0ZWYvaElia2kxNmZtbFQyYXBXSWZndllvT0tUbjR2?=
 =?utf-8?B?b1ZZc1l1QUt3RTFlTnA0SlBQM0lwbk5kRDRGRVBydE8rR1J1NjhCMjM4SEEv?=
 =?utf-8?B?RCsvS2Rrc0Y3UEN0VFpLcFFkUUo2UHZjRGhUTGYvV3h3Ynl6bEV3ZE1xUmdH?=
 =?utf-8?B?TWdmOHFxN1VYVzRrMFNicGlLem5yTjZLaFlmK3c4MmlOdm9xNVVNd00yb3JG?=
 =?utf-8?B?RlNiQ0lJdTJuVkw3K2ZrZzBWK2lHNVRUTlIvN1Zyb2pUWTZHaDZBWFlZeldX?=
 =?utf-8?B?UVFvNnJOaktEbGMyYU5ObmJsYS8zMndlSTBMUGFqQjBNNDFWMHJGUFdOczcw?=
 =?utf-8?B?VTlZWkFGYjJoSm5vTko5dFRMMUxqVWJjZ2NLR1piZXJxYnlvdVZMQ01DMmVl?=
 =?utf-8?B?VFNRUE5rSVZQSi9ZVE0yOUtuVDNCR3EwNlhDQnpzTkpJWUJFODhXcGhDOFVx?=
 =?utf-8?B?dkdXZkIxdUZDbGpZS08xSm43RHYzTEFQQXBDK0VnM2RlUnpsT2NxOThIOXNP?=
 =?utf-8?B?NVJiU3ByUlFXSmMwTGtHb3pOSFhGZlpLYUVLUnh3MXpYaHlETVU0QUtWVEtU?=
 =?utf-8?B?eDFFKzFIL2pJS2diSVFPNzlmL2F4eW14Vy9KWFc3eG5MTllJTlZ5WHo4TGZE?=
 =?utf-8?B?YlJhVEY4Snl6K1M2RU9Rcnd1VVFRM1dwRTByWEQ3NzJWblZxVGF3bmlFblpH?=
 =?utf-8?B?dytDN2JoOHJmNnA4MW9JMlcvNk5YSStIVW5YUlFtaCtDSnBlWTRCSEFBODQv?=
 =?utf-8?B?VmN2UlhDUDdPZHhPQXNnY0Z4T1BwYTRraFc3Vzg5UVI2bU9NWkFWSlVCM2VD?=
 =?utf-8?B?U2Y1aU1GRXNZcGNxNDM2dlUxV0dFckRzYTNEY2F0U2ZBMFdWSEhZMi9KUWo2?=
 =?utf-8?B?RWN4VjFPMlYycjd4cXViSmJ6WmRuSnFOOGhydWM1cVJHc1REUGNRQ3p5djJy?=
 =?utf-8?Q?zO9A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5831.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a78388-17fb-4de9-dd23-08db1ff25be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 16:29:58.6754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ueuBZuPlHkaVqT3zuUm1wxZT9Z6+Hoh4pU3KlYM/6UfZNnyhSSzVc6xwfAnhCsn/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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
Cc: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9uIDMvOC8yMyAwNDozNCwgUWlu
Z3FpbmcgWmh1byB3cm90ZToNCj4gW1doeV0NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vYW1ka2ZkL2tmZF9taWdyYXRlLmM6IEluIGZ1bmN0aW9uIOKAmHN2bV9taWdyYXRlX2NvcHlf
dG9fdnJhbeKAmToNCj4gLi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRncHUvYW1k
Z3B1Lmg6MzU6MjE6DQo+IGVycm9yOiBmb3JtYXQg4oCYJWx44oCZIGV4cGVjdHMgYXJndW1lbnQg
b2YgdHlwZSDigJhsb25nIHVuc2lnbmVkIGludOKAmSwgYnV0IA0KPiBhcmd1bWVudCA2IGhhcyB0
eXBlIOKAmHVpbnQ2NF904oCZIHtha2Eg4oCYbG9uZyBsb25nIHVuc2lnbmVkIGludOKAmX0gWy1X
ZXJyb3I9Zm9ybWF0PV0NCj4gICAgIDM1IHwgI2RlZmluZSBwcl9mbXQoZm10KSAiYW1kZ3B1OiAi
IGZtdA0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn4NCj4gDQo+IFtI
b3ddDQo+IHVzZSAlbGx4IGluc3RlYWQgb2YgJWx4IGZvciB0dG1fcmVzX29mZnNldC4NCj4gDQo+
IEZpeGVzOiBkNWRiOWQzNzdjMDIxICgiZHJtL2FtZGtmZDogRml4IEJPIG9mZnNldCBmb3IgbXVs
dGktVk1BIHBhZ2UgDQo+IG1pZ3JhdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IFFpbmdxaW5nIFpo
dW8gPHFpbmdxaW5nLnpodW9AYW1kLmNvbT4NCj4gDQo+IENjOiBYaWFvZ2FuZyBDaGVuIDxYaWFv
Z2FuZy5DaGVuQGFtZC5jb20+DQo+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdA
YW1kLmNvbT4NCj4gDQo+IC0tLQ0KDQo+IEkgYmVsaWV2ZSB0aGlzIGhhcyBhbHJlYWR5IGJlZW4g
Zml4ZWQgYXMgb2YgY29tbWl0IDI3MWFjYzU0MTMyNw0KPiAoImRybS9hbWRrZmQ6IGZpeCB3YXJu
aW5nIGluIFNWTSBkZWJ1ZyBzdGF0ZW1lbnQiKSwgaW4gYW1kLXN0YWdpbmctZHJtLW5leHQuDQoN
ClRoYW5rcyBmb3Igc2hhcmluZyBpdC4gUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIHRoZW4uDQoN
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jIHwgMiArLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMgDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21pZ3JhdGUuYw0KPiBpbmRleCAzNzNjZDdi
MGUxY2EuLmZkNTRhMDBlNzIyOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21pZ3JhdGUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbWlncmF0ZS5jDQo+IEBAIC0zMDQsNyArMzA0LDcgQEAgc3ZtX21pZ3JhdGVfY29weV90b192
cmFtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2Us
DQo+ICAgCXVpbnQ2NF90IGksIGo7DQo+ICAgCWludCByOw0KPiAgIA0KPiAtCXByX2RlYnVnKCJz
dm1zIDB4JXAgWzB4JWx4IDB4JWx4IDB4JWx4XVxuIiwgcHJhbmdlLT5zdm1zLCBwcmFuZ2UtPnN0
YXJ0LA0KPiArCXByX2RlYnVnKCJzdm1zIDB4JXAgWzB4JWx4IDB4JWx4IDB4JWxseF1cbiIsIHBy
YW5nZS0+c3ZtcywgDQo+ICtwcmFuZ2UtPnN0YXJ0LA0KPiAgIAkJIHByYW5nZS0+bGFzdCwgdHRt
X3Jlc19vZmZzZXQpOw0KPiAgIA0KPiAgIAlzcmMgPSBzY3JhdGNoOw0KDQotLQ0KTGlsbGlhbg0K
