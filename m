Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFCEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 07:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE63B10EAC3;
	Wed, 27 Apr 2022 07:32:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9FF10EAC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 07:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2ws2EvGpsm+GeUeX6TBRdkf5GSydgRKigejQT1a0hsYrUg2Do+7sj+Wlsag03EQRYoouG24iVa8lEscF0Tkp8DZlut5Ud1QmBliMZgUxZBQKWq/4OBHQn1jc/8rMRZj2QpDUsvcK8oQ9NOXq3TGCgZsf4uaUdDI5POBkC8CZlkYGy5FLi8ZmbGF7Ufx8PTubpH5sh62gxB0EIokTs4XL0lkVIZQeLeouYW5KFeqes3h3rL6JPNhZD9FjEcHyBnKRCNy2PNrMpiNYEDjGNR0kQ8y+CokF2A0VTvt+2U6jkTD3JI0Dc4fj8sRDUDuwb1kyb8guWTmaMUaSqo2dOzLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBNw1P82BK4ZQngo385sK6p3fi/pBxNFxahm5RD+l+w=;
 b=ShXtIUTGQFXRbXnyJMWmidYGjLx3ZEqedmVW1MOdkc8UXA1dkbVstzMFbUNMHc2Ol/PQdJ7Sdx/3hYU1SFFYLRJfWg1lrysUXfqhd//aTnrKid3jHAhjy6WaQiro4zOS73lzSl3pbNiqb2jkgfBFHJRh/3H9IYvOzwoM3i/PDmJDd1j2npaj2zBB6zzqQni7vkFEUEbShCR4OFrAv0oDrAdRfUU3NDtKJuQhW3zEVyaERqP+Jf26snuCT0Ap5jIpqxTqjHlrI79EddEBIxdr3j3JKBjDlAfZuHxoBVwmtyw575PGO7Z+nZPmsi7WLugI1HoHwhY9Icc2XXXxrwf83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBNw1P82BK4ZQngo385sK6p3fi/pBxNFxahm5RD+l+w=;
 b=xlaJx9opMmCRqbdpC5hDHYgMnGAFX6k/cnkiFWfw4baC9ouAkl4OK9ZV1qu/DqDbMhclPhDs2tDEW4YCjZZ/YE2nujz123EQzBl7TNkUdSsYOitnExdMb+QuuMxkT0TStAdTKZghk+Qcdftz5OfYkcZcys68AEVfT9sfwTyYt0U=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 07:32:48 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::bc5b:45a3:477e:258d]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::bc5b:45a3:477e:258d%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 07:32:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Topic: [PATCH] drm/amdgpu: keep mmhub clock gating being enabled during
 s2idle suspend
Thread-Index: AQHYWHGNCSvmg4Vj8EOz/S+SlVusl60CDd8AgAEZb8CAACkQgIAADgeA
Date: Wed, 27 Apr 2022 07:32:47 +0000
Message-ID: <BYAPR12MB3238009376AAAD9676E7C98DFBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1650869553-28976-1-git-send-email-Prike.Liang@amd.com>
 <1603bd63-71f0-87a6-0d18-339bf43568c4@amd.com>
 <BYAPR12MB3238D716386D4F0E246F2189FBFA9@BYAPR12MB3238.namprd12.prod.outlook.com>
 <685cbc01-6acb-a980-7358-b1e815dd0f36@amd.com>
In-Reply-To: <685cbc01-6acb-a980-7358-b1e815dd0f36@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c16a94f0-ca06-4bee-aab1-878e0b328661;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-04-27T07:23:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 274a6209-148f-48b0-b056-08da282020a6
x-ms-traffictypediagnostic: DM4PR12MB5961:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5961DA1BA5398ED7D4CEF12AFBFA9@DM4PR12MB5961.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gygTJ3e2GJtCohAZiCskiNVN7SY9QolMg2rAeUjUmxNGjjbuXawfzvkQzwFOqV9EyG7dO0f72K3e9KeWz0hqmWxybLC4zOZB/ZHaF24xdN02A0SR1z3O3wEdGfGzm11dQUGV3AqOh1FhWsj1a4wb2H9fwfEmzNEGMHoAFOC+r9BEcYemePOkKwjB2pCD+EwqWTKJUiCzPhnlfSRazyDxN74xS84fD1zdAPEmTCioKu/GfPHs8De9zwQJ+9MwgiKOWFFoFZSJB57m3fRUmtsQjDyUc1hYpvDrTT9n2ZC62y2FFz6xO7TfO+NKlUtIuTDIXibMGeyAEGwH8A0OYz9ZIJBJ2+swNLojp10M5ln/yUvYaRkHTe/quP5a7f0VNgvbt/TdOXJKAVsfcysHwIM1XbznxVFmnNWjxBQXOD+Cy1e/IA9s5RSc84HjjrfY00t3TuaMatWm9386lVDzgfW68lwFQ3Go+HQ6K2lHRnOyniGgFHP5VQGvqtr6Hp0oy1P0sDOUcOeD0fQCIYe9NRnUBXlblFix5OrLtd6thdQr/62ThG7m7ZQEXxGBODue46GtWE0+FJBdJyvzq3K8hv1jsta+uY05UmQ3zs172tmcTQT0o4G8Tug/m8Ebqnv8L1zVni1bM1BT8x3uBljaaMuxrxNerjy0rFD8OiqnCp4zi26geC2qDugWE/QMydmqr3ZPNXIjF4UN1bo8fnMs/ep13Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(316002)(33656002)(55016003)(4326008)(110136005)(66556008)(66476007)(8676002)(66446008)(76116006)(64756008)(86362001)(52536014)(122000001)(54906003)(66946007)(71200400001)(38100700002)(38070700005)(6506007)(15650500001)(5660300002)(53546011)(2906002)(7696005)(9686003)(26005)(83380400001)(186003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk00VWVlZk41dmJMY01JV2Jub1pLSmJ6VVpMOXhVMWQ2bHd6dCtMUzBOSXRu?=
 =?utf-8?B?TEw1TElpK0p5YlBoNkZlcHFUREZFUmFDWU0wQTVxb3hNYkJlSEVFbTI0OW4r?=
 =?utf-8?B?cWY1K3hiTkVkMXZzSU5GTGlRaWdCeUtTbUQwTVhja0NxNVZPQnR5dE9KdjJP?=
 =?utf-8?B?SzVCK1R1dEdUMEZBbzRFSEFySHVDZ09nUmt0WUFlMk1hc1BtemRZS3FRamNB?=
 =?utf-8?B?eUxjOUdIQkJvOHJKeW9DdWl2UEw5UFVlaTVuYzhJbkdhMVN4TXJCOGp4TUVw?=
 =?utf-8?B?UGNvSFdtSUlYR3R0aWQ2SHFTdFpmOGdpN29ma2hjUUpYdnZvK3hUNFk2NDRM?=
 =?utf-8?B?MUtTcTc0US9MQkNYY3Z3L0dwK1d5eVlFMWVmRlNXUVNneFMwWUFQb2E1OGoy?=
 =?utf-8?B?c2lrdUxsK0Z6QmVJclFiSWxEbkJ2ekJ1Q2lVUWJYaWVDZko3ZkZDRkhoTGZn?=
 =?utf-8?B?NXJvSnFmOVJNeFRiZjNDMVZQWmNOaW9mV1RMbW9zZlNyUklHOEZ3SHlyQUUr?=
 =?utf-8?B?TWV4c2tRK1hLYWNoK3RDV1c1TWZDYlN1MVdGSTY0TUJ1NmpsZkIwK3o0QkQv?=
 =?utf-8?B?U1JPY1RXQzJhcmN3SWhFMWs5aWRCYVp1ZitQU2dsaVhjZ0E3bktsbHNjN0JS?=
 =?utf-8?B?WFcxTlEwSU5DY0g1TnMwdGpjWExUOFoxdmg3Q2FYOHdRVjVoajlMUUNDV3dH?=
 =?utf-8?B?aXVxNmdoK3BSY0RrUzY0OEpQYk5iMlNHVFpaTVhRRXpha2dPTE1VRFpXNnpU?=
 =?utf-8?B?dFJRZEJvbjVOR1ZEd21Mcy9nZnZmdUp2eVZCVnZ1MlhDMzRqSG11SEJvRmgr?=
 =?utf-8?B?U3ZXRWxGcjJxMXFNZEVra084Y3Erakx0TEpkUS9WV3c3Wm4zcTdmYncrMHFN?=
 =?utf-8?B?TitndTBUbC9RY0xCbTZva3VocnU0SG16dWsyTnB5V3grU2xZdnl2RTZRTVRr?=
 =?utf-8?B?Ri9OK2xneUNGY0pRUVFOeW1RNXBSdE9CUDRLcGM3RkFnMHJsQzdIUHQwMWYr?=
 =?utf-8?B?R3pKZmREVTg4LzVSY000SGZObFBlQ1k3a2lVZytoNkNRSjdvaVZDNStUWGlO?=
 =?utf-8?B?MUswakdIS29GN0dMV1R6cnE4T0U3NDdrL3BNVE1ReTBSdE12L3grVmFNeWtZ?=
 =?utf-8?B?TTNjcXNiYytRUEttTGxHY0tRTjNuQ3JwOEgyeDB4K0w0dDFiNlZ1MmJCbm1C?=
 =?utf-8?B?M1VuTmFPZUVoa2N3Q29EamRHVERoVDlTeWtwbk9yRnhseFFQZDRBVktkaEpK?=
 =?utf-8?B?SW5ob3BCYVVWWjNYWlBZRmRNMGlNbHFBV3p2T3FZUVQ2QWdxbTlrM1RYQTZB?=
 =?utf-8?B?SFE3V0tabGJJMEFNemNFOWlQUklWT1VKczhwS2ZybjVvbTBsOElabEVIemRy?=
 =?utf-8?B?MDluUkpRbUk1cEFRQjI3QUVxNGMwbk1INVpQNDhCakIwQ1JDb0k2YUFKV05v?=
 =?utf-8?B?UXE0S3gwZlo3YllsTURkZ2hPcGFkblFIN0E4VXQ1ZVNmRnlKQjM0enpUT0g4?=
 =?utf-8?B?ZHBkT3RVT1o1YzNncHlyanBlQ0lPL0M1eEpTdTRSUUIxODNYVnRJM2p4K1NP?=
 =?utf-8?B?Q21XcitaUjZXVERwZ3BXNVJTOWNrUG9XREwyN2Z2WElHTWx2WEpLbFhYaEVr?=
 =?utf-8?B?bWtlU3dGYytTd015SzZJUmxWS3poWk0xYjdqWkhmMi9QMjAzNTQrWE9Da3Rl?=
 =?utf-8?B?aEhRb2lqQjZNMXZZeTVIUGkwZGppS0FYQmxrMS9SNG83L1dzTmUvMG5CUWty?=
 =?utf-8?B?VlBTekdncnUyOWIzVzE3MWErMHhwQUxsTlE3c3FNcER5OUlDM3BZNGN2MDlX?=
 =?utf-8?B?RVlKNTIrZ1NVdGxMc1Z3RHVlYW9aOWx0VU9NQlF5Zk90Rkk2YktEZ0NGWmZF?=
 =?utf-8?B?NERhejdxdzZDS3gxc0NkUkIrRTBucHp1SjFiVFpoUENLMkI1Q3ViL0ZibFU3?=
 =?utf-8?B?MVFjbUxsODN5ZVZSY21iR0MxYkw5OTRVWi9xamliWVQ5a3ZMN3pHVFU4Mm1U?=
 =?utf-8?B?WWdqc3RpQVY0VGtxY3pGV2pEeW52L3pGaU51c3pCbTQrWnFLZ1ZyT2d3ZDF4?=
 =?utf-8?B?d3dPRnl1Ykt2S1Y1Z3YwYXlFdkluQ2o3aytoQUM5RTRSaWg1NTlkYithYUNy?=
 =?utf-8?B?SGNtYUpHYmRVd0RHM2w3dDI5MkhXNHlzWVIrdkJHdHo0b3laOWpwWWhxSW5M?=
 =?utf-8?B?a3dWSEpvQ083RFRva1hSVEh5NHF2YmVGdlBnZlRKVGRrQVZ2VjBDV1JtUmRl?=
 =?utf-8?B?dVpIa2srZzRKaHo5ZlVPc3JoVVgxLy90T2YwcmVtOCtPQ1MySU5LK2RNaE1F?=
 =?utf-8?Q?yQcJJbSBlSiQdWfj1u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a6209-148f-48b0-b056-08da282020a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 07:32:47.7581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 924/rVA4HG4/kn6Cvx4ohgHwweVy+W6FX6FEcPPZQZlodpMof8urGhN76lVcbfJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBBcHJpbCAyNywgMjAyMiAyOjMzIFBNDQo+IFRvOiBMaWFuZywgUHJpa2Ug
PFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgSHVhbmcs
IFJheQ0KPiA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHU6IGtlZXAgbW1odWIgY2xvY2sgZ2F0aW5nIGJlaW5nIGVuYWJsZWQNCj4gZHVyaW5nIHMy
aWRsZSBzdXNwZW5kDQo+DQo+DQo+DQo+IE9uIDQvMjcvMjAyMiA5OjQ0IEFNLCBMaWFuZywgUHJp
a2Ugd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiA+PiBT
ZW50OiBUdWVzZGF5LCBBcHJpbCAyNiwgMjAyMiA3OjE5IFBNDQo+ID4+IFRvOiBMaWFuZywgUHJp
a2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
PiA+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
SHVhbmcsIFJheQ0KPiA+PiA8UmF5Lkh1YW5nQGFtZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGRybS9hbWRncHU6IGtlZXAgbW1odWIgY2xvY2sgZ2F0aW5nIGJlaW5nDQo+ID4+IGVu
YWJsZWQgZHVyaW5nIHMyaWRsZSBzdXNwZW5kDQo+ID4+DQo+ID4+DQo+ID4+DQo+ID4+IE9uIDQv
MjUvMjAyMiAxMjoyMiBQTSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4+PiBXaXRob3V0IE1NSFVC
IGNsb2NrIGdhdGluZyBiZWluZyBlbmFibGVkIHRoZW4gTU1IVUIgd2lsbCBub3QNCj4gPj4+IGRp
c2Nvbm5lY3QgZnJvbSBERiBhbmQgd2lsbCByZXN1bHQgaW4gREYgQy1zdGF0ZSBlbnRyeSBjYW4n
dCBiZQ0KPiA+Pj4gYWNjZXNzZWQgZHVyaW5nIFMyaWRsZSBzdXNwZW5kLCBhbmQgZXZlbnR1YWxs
eSBzMGl4IGVudHJ5IHdpbGwgYmUgYmxvY2tlZC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5
OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCAxMCArKysrKysrKysrDQo+
ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiA+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiA+Pj4gaW5kZXggYTQ1
NWU1OWY0MWY0Li4yMDk0NmJjN2ZjOTMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ21jX3YxMF8wLmMNCj4gPj4+IEBAIC0xMTUxLDYgKzExNTEsMTYgQEAgc3RhdGlj
IGludA0KPiA+Pj4gZ21jX3YxMF8wX3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkDQo+ID4+ICpo
YW5kbGUsDQo+ID4+PiAgICAgIGludCByOw0KPiA+Pj4gICAgICBzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsNCj4gPj4+DQo+ID4+PiAr
ICAgLyoNCj4gPj4+ICsgICAgKiBUaGUgaXNzdWUgbW1odWIgY2FuJ3QgZGlzY29ubmVjdCBmcm9t
IERGIHdpdGggTU1IVUIgY2xvY2sNCj4gPj4gZ2F0aW5nIGJlaW5nIGRpc2FibGVkDQo+ID4+PiAr
ICAgICogaXMgYSBuZXcgcHJvYmxlbSBvYnNlcnZlZCBhdCBERiAzLjAuMywgaG93ZXZlciB3aXRo
IHRoZSBzYW1lDQo+ID4+IHN1c3BlbmQgc2VxdWVuY2Ugbm90DQo+ID4+PiArICAgICogc2VlbiBh
bnkgaXNzdWUgb24gdGhlIERGIDMuMC4yIHNlcmllcyBwbGF0Zm9ybS4NCj4gPj4+ICsgICAgKi8N
Cj4gPj4+ICsgICBpZiAoYWRldi0+aW5fczBpeCAmJiBhZGV2LT5pcF92ZXJzaW9uc1tERl9IV0lQ
XVswXSA+DQo+ID4+PiArIElQX1ZFUlNJT04oMywNCj4gPj4gMCwgMikpIHsNCj4gPj4+ICsgICAg
ICAgICAgIGRldl9kYmcoYWRldi0+ZGV2LCAia2VlcCBtbWh1YiBjbG9jayBnYXRpbmcgYmVpbmcN
Cj4gPj4gZW5hYmxlZCBmb3IgczBpeFxuIik7DQo+ID4+PiArICAgICAgICAgICByZXR1cm4gMDsN
Cj4gPj4+ICsgICB9DQo+ID4+PiArDQo+ID4+DQo+ID4+IFRoaXMgb25seSBpZ25vcmVzIGNsb2Nr
IGdhdGluZyByZXF1ZXN0cyBhcyBsb25nIGFzIHMwaXggZmxhZyBpcyBzZXQuDQo+ID4+IEFzIGZh
ciBhcyBJIHNlZSwgczBpeCBmbGFnIGlzIHNldCB0byB0cnVlIGV2ZW4gZHVyaW5nIHJlc3VtZSBh
bmQgc2V0DQo+ID4+IHRvIGZhbHNlIG9ubHkgYWZ0ZXIgcmVzdW1lIGlzIGNvbXBsZXRlZC4gSXMg
dGhhdCBpbnRlbnRpb24gYW5kIGlzDQo+ID4+IHRoaXMgdGVzdGVkIHRvIGJlIHdvcmtpbmcgZmlu
ZT8gSSBzdWdnZXN0IHRvIGtlZXAgdGhpcyBzcGVjaWZpY2FsbHkgZm9yDQo+IHN1c3BlbmQgY2Fs
bHMuDQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gTGlqbw0KPiA+Pg0KPiA+IEl0IHJlYXNvbmFi
bGUgZm9yIGFsc28gbm90IHJlZW5hYmxlIHRoZSBjbG9jayBnYXRpbmcgb24gdGhlIHMyaWxkZQ0K
PiA+IHJlc3VtZSBzaW5jZSBjbG9jayBnYXRpbmcgbm90IGRpc2FibGVkIG9uIHRoZSBzMmlkbGUg
c3VzcGVuZC4NCj4NCj4gR2VuZXJhbGx5LCB0aGUgQ0cgc2V0dGluZyByZWdpc3RlcnMgYXJlIG5v
dCBpbiBhbHdheXMtb24gZG9tYWluIGFuZCB0aGUNCj4gcmVnaXN0ZXIgc2V0dGluZ3Mgd2lsbCBi
ZSBsb3N0IG9uY2UgaXQgZ29lcyBkb3duLiBOb3Qgc3VyZSBhYm91dCB0aGUgc3RhdGUgb2YNCj4g
dGhpcyBwYXJ0aWN1bGFyIElQIHJhaWwgZHVyaW5nIFMwaTMgY3ljbGUuDQo+DQo+IElmIHRoZSBD
RyBzZXR0aW5ncyBhcmUgZHJpdmVyLWVuYWJsZWQsIHdlIHJlcHJvZ3JhbSBDRyBzZXR0aW5ncyBk
dXJpbmcNCj4gcmVzdW1lIC0gYW1kZ3B1X2RldmljZV9yZXN1bWUtPmFtZGdwdV9kZXZpY2VfaXBf
bGF0ZV9pbml0IC0+DQo+IGFtZGdwdV9kZXZpY2Vfc2V0X2NnX3N0YXRlLiBUaGlzIGxvZ2ljIHBy
ZXZlbnRzIHRoaXMuIE1heWJlLCBpdCB3b3JrcyBmaW5lDQo+IGR1cmluZyB5b3VyIHRlc3Rpbmcg
YmVjYXVzZSBpdCdzIGRvbmUgYnkgRlcuIElmIHRoZSBzZXR0aW5ncyBhcmUgcHJvZ3JhbW1lZA0K
PiBieSBGVyBjb21wb25lbnRzLCB1c3VhbGx5IHJlcHJvZ3JhbW1pbmcgaXMgdGFrZW4gY2FyZSBi
eSBGVy4NCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQpJbiB0aGUgUzBpMyBlbnRyeSB0aGUgZ2Z4
IHBvd2VyIHJhaWwgd2lsbCBiZSB0dXJuIG9mZiBidXQgTUVNX1MzIHBvd2VyIHJhaWwgaXMga2Vl
cGluZyBvbiBhbmQgaW52b2x2ZWQgZGV2aWNlL0lQIGNvbnRleHQgd2lsbCBiZSBzYXZlZCBpbiB0
aGUgbWVtb3J5IGFuZCB0aGVuIGVhY2ggY29udGV4dCByZXN0b3JlZCBieSBQTSBmaXJtd2FyZSBk
dXJpbmcgUzBpMyByZXN1bWUuDQoNCj4gSGF2ZSBtZXJnZWQgdGhlIGZpeCBmb3Igbm90IGJsb2Nr
aW5nIHMwaXggc3VwcG9ydCBmb3Igc29tZQ0KPiA+IHVwY29taW5nIGFzaWMgYW5kIG1lYW53aGls
ZSBzdGlsbCBuZWVkIGRpZyBpbnRvIHdoZXRoZXIgdGhlIERGIEMtc3RhdGUsDQo+IE1NSFVCIERT
IG9yIEJJT1MgbW1odWIgcG93ZXIgZ2F0ZSByZXF1ZXN0IGRpZmZlcmVudCBvbiBHQyAxMC4zLjcN
Cj4gaW50cm9kdWNlIHRoaXMgaXNzdWUgYW5kIHRoZW4gbWFrZSBhIGdlbmVyaWMgc29sdXRpb24g
Zm9yIHN1Y2ggdGhpcyBpc3N1ZS4NCj4gPg0KPiA+Pj4gICAgICByID0gYWRldi0+bW1odWIuZnVu
Y3MtPnNldF9jbG9ja2dhdGluZyhhZGV2LCBzdGF0ZSk7DQo+ID4+PiAgICAgIGlmIChyKQ0KPiA+
Pj4gICAgICAgICAgICAgIHJldHVybiByOw0KPiA+Pj4NCg==
