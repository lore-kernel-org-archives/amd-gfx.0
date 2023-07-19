Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC874EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 04:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CA210E0FB;
	Wed, 19 Jul 2023 04:42:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2080810E0FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 04:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXvauUid1dS+JcpOfvCT5klZYVF+6tFVWfbf6/E0mJuh3woUbJEcEk44drNFdLBN+gHWirlGc1uF+QYWz2AFW8+yP9LYkjSWG+kLcRQ1EPxRhlD4HfXy5elBXZUKeYh0DbPleUBPccT0qapj4s3WBOoQuhAvEiinDN5D9PEFCmh+IhGv5IuRc3aJ2trEz1o2KI1S2py4fHZoJuttgt9M0OLQovvcDTVVceJ7ligHTnzZ45mMxun27/Z9+3pmU0+cy6hPdbTEhWO8AEgsWY9d7WAVSaFMl7616dGa/tM/vMol3rFRRHcBEJnqXVk0qMulb17ilgV8s+rBHn50Sg5+qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QmXls2evT0Ukzz2eRq4EXQwR59R03igKOcgRjobJcE=;
 b=gXQmX/MtGzLzPHoYI3evRxA8nH0MxNnL5qJVLW1sXhGWxTqDTjNxx41df0mcLVvqKi/bxBH4U0My5rCCeKOSgIQ+P8Hjepr14RdPm0JnvODxKP5Mn95MkD1azVv5KQ7TBIvcOk2LoP9ABbhv0jNYH/P2pl93+MCWurFz2vZDWyiLyJgLxOREwvnazsW7U2Ng9ZvTNpmWvxoB/XFUJFMpGNZYIngqMCoCRHK++GTD9MmtE0qg45+ltgkWX9qhKa//FTHZ1HTVYcn9N+Ih7ewVS+urz8NegnLs6fv/qfYddUxQS4oPIz6UVm1x3aNDmCR8oJR/WtGyO2Jlttf9eKkbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QmXls2evT0Ukzz2eRq4EXQwR59R03igKOcgRjobJcE=;
 b=YPJNehtaJyxAKJvTba3MLb1Cdd9GSpbzukiZNfBHBtoNofJzi5RFGFJ9PDUsdAWMwnbz8XI612z2vdeZtVbOc1BY+2SHBGoYaSuwuMmuNtQ+sJGyT1P4kXCEEkvQUpky19HjN1XLBCICn/I9z8ZgANnHaFmCiX1DcI/P3TjORIs=
Received: from BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 04:42:55 +0000
Received: from BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::7794:8bfc:194d:583f]) by BL0PR12MB2465.namprd12.prod.outlook.com
 ([fe80::7794:8bfc:194d:583f%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 04:42:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Thread-Topic: [PATCH] drm/amdgpu: Update ring scheduler info as needed
Thread-Index: AQHZuXJrsC8odZOAM02mqmvvZ7/enq+/jWyAgAAFT4CAAA4RAIAADKMAgAAEIwCAAADYgIAAmyrg
Date: Wed, 19 Jul 2023 04:42:54 +0000
Message-ID: <BL0PR12MB2465A275C88351932936B5FEF139A@BL0PR12MB2465.namprd12.prod.outlook.com>
References: <20230718122120.2938177-1-lijo.lazar@amd.com>
 <843196d3-fc53-77f3-26c5-8df479539f7e@amd.com>
 <c4ea8242-ff13-f395-2eb4-b15633253dcd@amd.com>
 <5de2cb5b-ccc2-68a6-aacf-f1882885817c@amd.com>
 <23ca1d49-ea6d-0980-1bdc-f24a48a880ab@amd.com>
 <7c6c2699-0732-9e6b-4c5c-f36bcfa83814@amd.com>
 <844c21ed-fdeb-d6d7-f103-c4d0660544ae@amd.com>
In-Reply-To: <844c21ed-fdeb-d6d7-f103-c4d0660544ae@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4ed1054f-72b2-4bd5-98a1-dc00da5abb45;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-19T01:28:08Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2465:EE_|CH3PR12MB8754:EE_
x-ms-office365-filtering-correlation-id: ddcb5efd-b18f-4769-266d-08db88129dcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIox1f1xLePXiHjg23f2P8pPcjfaUPKTX1w6jHntJZ5Ao+X1obe+StlyVwgdAFT5xtiesQIaXAlVrTEnZTKA9joDKGWvNLasORaEpFftkEYoGA5JEndbbScQvk/KbswKi1fB8y4cWJQSJ0EkTqf3bw4QcZPxyYdCODWI/3AQ8Bk5ArfZb82nYKqcNwuQFXB6DTNPFEnPisZ33R4RA6qI4tLNALQ/tkUbKXwLqo9ob0ZMI1oS3MUIlGNZ53XhJy/KPslKlXeq5FOn6AXnBtFWGXOQo9JBKBoEJfoxS6A5XtKrn/Dkd/utII/zlzUSKmB9MUyV7WFusoUfyw0bmbRojvQLojC/Gz5TtyJmAhGJ3jejfjm3AqNex7ElfMQlpq/J+Emp+QkioQuttoA/SXw16koXz9lKTlvpsXvRrANRK1dQnoOPRzMvBhKs9G4ArFX97mjq9asYWwwLMAzbrsbFBRkrcy9nQERpxGM0eo3RfUuIkE+CdcQ4WxUqJnv7elQQzKwa89ysaYOqSzBXHzEpbEQAMNzukEsrsJ/IZfyEZPd4U0wk/P/saYUqJyBSBJFcGfBD3rcq1IWLImpNDXbwSbwxkb/rzvWOdQmi/mo6yhtYrY8oFmRrK6f+etLYa4qi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2465.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(41300700001)(8676002)(7696005)(66446008)(66476007)(2906002)(66946007)(8936002)(15650500001)(66556008)(54906003)(76116006)(122000001)(86362001)(4326008)(52536014)(316002)(64756008)(5660300002)(9686003)(38100700002)(83380400001)(186003)(26005)(71200400001)(6506007)(53546011)(33656002)(38070700005)(55016003)(110136005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NklOUnlEN1NCVWJNakFFdURGbTc2aisydElORG9NQWpoOTdSUk9wdDBadnRX?=
 =?utf-8?B?SVEvVHRsK3R3WWZuZUZZUUlTOVR0N3V4RFI0UWVkT2lRb3BDOE1hY2xWd2Ru?=
 =?utf-8?B?U0dhUDJXLzk4MGd5a3hsTnE2VW8vWG5XYkUxSGN3dWszSXIvK0EwTHlTWktm?=
 =?utf-8?B?QUNmTkJGakZwdlNRak1EMDZ6QlA1VzBvaE5rN2NadG5oMTB5M1diL3dCenNu?=
 =?utf-8?B?S2tFOGdEYzZYc3JQK2tsQVJmZGQ0YVY0NnFoUllvTmMvdGxXR24rcmw4ampG?=
 =?utf-8?B?MlI3N2JLUkxkQmJjcGk1NkVUcisweWRMSTRKU0tJMjhjek5CNFhuWWU3VEZQ?=
 =?utf-8?B?U3FVMkF0RVZMbDgwVUFWdG9TTjFOc3pXQm5rd1l2L2RZeW9KK0JVQWQrbTl5?=
 =?utf-8?B?Yk9WU2lMd1R6azdkVkM3VndSM0c5U1FJVjk0MXB5dVcxYisra2ttTTVaeS85?=
 =?utf-8?B?SkRhdHJsSVg3Z055cUE4K2lzMjR4SUZQVzg3N1FsSk1Ib1dSNklVc2FIdTlX?=
 =?utf-8?B?bkN3NEFwVUZDblpjckU4MDIrMk0yNkllUTZtOTR2Q2pVbXQwNGFxVEFhMDZu?=
 =?utf-8?B?WFFGdHRFY3E4Q2pZaWlIUlZnOEJRaFVxcm5sMlExbTgvOUJwbytLU3JxU2t1?=
 =?utf-8?B?aTRlS1NmeVpTOTNsWVBQQjJ3UDh3U2lZQmRSRjFOSUkrSi9UQk5lbE9RVmcx?=
 =?utf-8?B?Q2hZVFBrVmFyYmpldHR0cEk5alcwTFpEcklxdG5oUzN1dUQ1K3FwV0pra0R0?=
 =?utf-8?B?OThYc3cvRC9GWDhudmdhK3JTT2taQXYreTh4aTFnZW42eDJneVFOVGlSalZo?=
 =?utf-8?B?dmFheGlhODFWVFNLMmhKcXBsN0lZMGU2bTNXMlBKU0krdm1lYUk2Y1VRYjZi?=
 =?utf-8?B?djFaVkxCYzhVdHZmaXhScnp3R3IvZXVDQzdxYi9xSlg0RitlRi9Ob29xTjRo?=
 =?utf-8?B?S2NFZS80bmc5VzhKbVJDaXNMYUtNY1NHeEM4RnhUWFg3dXZMbGVKZjNZaHQ4?=
 =?utf-8?B?WHhFSEN1UXEwVEp0OG1pb2QxK3lRUWlSejFHMTVPKzc3SXAvSDJQRW5XYk85?=
 =?utf-8?B?OEJMdWx2c2ZpcEp3RzRnd3lKaElHdU9RSStzMnJ3YUd3b2ZzUzRleHRMVmVT?=
 =?utf-8?B?VCtEbWFMRERkU3R5N3Iya1g1aUFXdWJzVXVTblJ5ZkFIVzF2M050TUx4ckpp?=
 =?utf-8?B?TWlNMDE5L0doaEZpZlh0ZG9tc0w5WldiL1JQOW53SHQrOTl0Qk1tZ3JlUmpw?=
 =?utf-8?B?QjVxVGtHU2VNOHBFT1FibU14UmpZUXlxTGZ2Ky9yNk9GcUlkZXNWTDlid0Y1?=
 =?utf-8?B?YTR3OVVEbUkwS0F1dzh6RUo2R3JRN0ZBQWViQ0JoUGJLVFFVNm5BMFVEUUVk?=
 =?utf-8?B?dDJqOVIwMUJ4RW9zb2dhMTNDaGtVRHlNVXR3SE9MTEtRdmNwUW5HNk4zaHpY?=
 =?utf-8?B?RVA1Zk5wN1l0V1hLU0J3Y09zVlI1QkV0RjlScG5JaGJYeU1Bbjh3VUdqdWNy?=
 =?utf-8?B?djhNbkliNUR5QlZkRG9XbENqaDVSN3FiaUV1Y1JLQjNlVnhZc0ZhQWgzc25M?=
 =?utf-8?B?c0FPdnhqTTZhaDJjK3NSTTZPT3RGUC9YSlhlV0VPd3BZL1FGRTNHOG9MUENI?=
 =?utf-8?B?aUhaU1BaNGZuKzk4NThBNkdrZFpFZVVlWWpxeUVxVXZudjFqVlN1T2pCenVE?=
 =?utf-8?B?VnJQY0tocm04UWV4MDM1L2N4Wkt0U2FEdVJ0WlNtLzJDZkhLbUtkeWJtVGRn?=
 =?utf-8?B?NWNITnF2d2p5S3p1L0ZndER4QVFJSGQzU1lDdWpaZGNnVWtrdWhhZlJOMm5W?=
 =?utf-8?B?Tnl6OXp1NFJNUVlDVjBDQVlITlhhY3VPMG9TMkE1S3lzRk4xT21DQkJhbFZS?=
 =?utf-8?B?Ky9nUDFVQklZZTBiMHZYSVBTNDFIUTMzc1JMUzduSFRINk5ncExBT3hGcUxa?=
 =?utf-8?B?T1hHU1BiTmcwUkhuTlc3dkNZZUlMRXc5UXM0WmczTnRHbDROcHpPTVFKMUFv?=
 =?utf-8?B?UzgrZGlodE1wRFhMenJ6RXc3RUU4aE5pdGZrWkVKek9EaElEOXBYb1lzVWhq?=
 =?utf-8?B?VDl1OVlFY2ZVMlJDaUJib3lnOVZtNkhJaktrTFZzbmZVUGJvVkFEeDl2ZUl2?=
 =?utf-8?Q?Ham4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcb5efd-b18f-4769-266d-08db88129dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 04:42:54.1103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfu6+4Jux+UUyEuqilBDCYD5RlXAsWxLwRcvzuFyNjOUwiqzIJosoqdmHbg1/Ylix0HZF0GxY5A6EnyFgplzhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgTGF6
YXIsDQo+IExpam8NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE5LCAyMDIzIDEyOjEzIEFNDQo+
IFRvOiBaaHUsIEphbWVzIDxKYW1lcy5aaHVAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBaaHUsIEphbWVzDQo+IDxKYW1lcy5aaHVAYW1kLmNvbT47IEthbWFsLCBBc2FkIDxB
c2FkLkthbWFsQGFtZC5jb20+OyBaaGFuZywNCj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBVcGRhdGUgcmluZyBzY2hl
ZHVsZXIgaW5mbyBhcyBuZWVkZWQNCj4NCj4NCj4NCj4gT24gNy8xOC8yMDIzIDk6MzkgUE0sIEph
bWVzIFpodSB3cm90ZToNCj4gPg0KPiA+IE9uIDIwMjMtMDctMTggMTE6NTQsIExhemFyLCBMaWpv
IHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA3LzE4LzIwMjMgODozOSBQTSwgSmFtZXMgWmh1
IHdyb3RlOg0KPiA+Pj4NCj4gPj4+IE9uIDIwMjMtMDctMTggMTA6MTksIExhemFyLCBMaWpvIHdy
b3RlOg0KPiA+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBPbiA3LzE4LzIwMjMgNzozMCBQTSwgSmFtZXMg
Wmh1IHdyb3RlOg0KPiA+Pj4+Pg0KPiA+Pj4+PiBPbiAyMDIzLTA3LTE4IDA4OjIxLCBMaWpvIExh
emFyIHdyb3RlOg0KPiA+Pj4+Pj4gTm90IGFsbCByaW5ncyBoYXZlIHNjaGVkdWxlciBhc3NvY2lh
dGVkLiBPbmx5IHVwZGF0ZSBzY2hlZHVsZXINCj4gPj4+Pj4+IGRhdGEgZm9yIHJpbmdzIHdpdGgg
c2NoZWR1bGVyLiBJdCBjb3VsZCByZXN1bHQgaW4gb3V0IG9mIGJvdW5kDQo+ID4+Pj4+PiBhY2Nl
c3MgYXMgdG90YWwgcmluZ3MgYXJlIG1vcmUgdGhhbiB0aG9zZSBhc3NvY2lhdGVkIHdpdGgNCj4g
Pj4+Pj4+IHBhcnRpY3VsYXIgSVBzLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNvbT4NCj4gPj4+Pj4+IC0tLQ0KPiA+Pj4+Pj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hcXVhX3ZhbmphcmFtLmMgfCAyICstDQo+ID4+
Pj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
cXVhX3ZhbmphcmFtLmMNCj4gPj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXF1
YV92YW5qYXJhbS5jDQo+ID4+Pj4+PiBpbmRleCA3MmI2MjlhNzhjNjIuLmQwZmM2Mjc4NGU4MiAx
MDA2NDQNCj4gPj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FxdWFfdmFu
amFyYW0uYw0KPiA+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXF1YV92
YW5qYXJhbS5jDQo+ID4+Pj4+PiBAQCAtMTM0LDcgKzEzNCw3IEBAIHN0YXRpYyBpbnQNCj4gPj4+
Pj4+IGFxdWFfdmFuamFyYW1feGNwX3NjaGVkX2xpc3RfdXBkYXRlKA0KPiA+Pj4+Pj4gICAgICAg
Zm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7IGkrKykgew0KPiA+Pj4+Pj4gICAgICAg
ICAgIHJpbmcgPSBhZGV2LT5yaW5nc1tpXTsNCj4gPj4+Pj4+IC0gICAgICAgIGlmICghcmluZyB8
fCAhcmluZy0+c2NoZWQucmVhZHkpDQo+ID4+Pj4+PiArICAgICAgICBpZiAoIXJpbmcgfHwgIXJp
bmctPnNjaGVkLnJlYWR5IHx8IHJpbmctPm5vX3NjaGVkdWxlcikNCj4gPj4+Pj4gW0paXSBhbnkg
Y2FzZSBmb3IgcmluZy0+bm9fc2NoZWR1bGVyID0gdHJ1ZSwgYnV0IHJpbmctPnNjaGVkLnJlYWR5
DQo+ID4+Pj4+ID0gdHJ1ZT8NCj4gPj4+Pg0KPiA+Pj4+IGFtZGdwdV9nZnhfa2lxX2luaXRfcmlu
ZyBzZXRzIG5vX3NjaGVkdWxlciBmbGFnIHRydWUgZm9yIGtpcSByaW5ncy4NCj4gPj4+PiBhbWRn
cHVfZGV2aWNlX2luaXRfc2NoZWR1bGVycyBpbml0cyBzY2hlZHVsZXJzIG9ubHkgZm9yIHJpbmdz
IHdoaWNoDQo+ID4+Pj4gZG9lc24ndCBoYXZlIG5vX3NjaGVkdWxlci4gSG93ZXZlciBpbiBnZnhf
djlfNF8zX3hjY19raXFfcmVzdW1lLA0KPiA+Pj4+IHRoZSByaW5nIGlzIG1hcmtlZCB3aXRoIHJp
bmctPnNjaGVkLnJlYWR5ID0gdHJ1ZTsNCj4gPj4+Pg0KPiA+Pj4+IEknbSBub3Qgc3VyZSB3aHkg
aXQncyBkb25lIHRoaXMgd2F5LCBidXQgdGhpcyBpcyB0aGUgY2FzZSBldmVuIGZvcg0KPiA+Pj4+
IGdmeHY5Lg0KDQpEcml2ZXIgc28gZmFyIHN0aWxsIGhhcyBzb21lIGNvbmNlcHQgYWJ1c2Ugb24g
c2NoZWQucmVhZHkuIEluIGFtZGdwdV9kZXZpY2VfaW5pdF9zY2hlZHVsZXJzICwgaXQncyBzZXQg
dG8gYmUgdHJ1ZSBvbmNlIHNldHRpbmcgdXAgc3cgc2NoZWR1bGVyIGZvciB0aGUgcmluZyByZXF1
aXJlbWVudCwgaG93ZXZlciwgYWZ0ZXIgZHJpdmVyIGlzIHVwLCB0aGlzIGZsYWcgd29ya3MgbGlr
ZSBhIGhpbnQgdG8gdGVsbCB0aGUgY29ycmVzcG9uZGluZyByaW5nIGlzIHJlYWR5IGZvciBIVyBz
dWJtaXNzaW9uIGFmdGVyIHJpbmcgdGVzdCBzdWNjZWVkcy4NCg0KRm9yIHRoaXMgY2FzZSwgaXQn
cyBwcm9iYWJseSBjYXVzZWQgYnkgYW1kZ3B1X2dmeF9lbmFibGVfa2NxICBjYWxsaW5nIGFtZGdw
dV9yaW5nX3Rlc3RfaGVscGVyLCB3aGljaCBzZXRzIHNjaGVkLnJlYWR5IHVuY29uZGl0aW9uYWxs
eSBiYXNlZCBvbiByaW5nIHRlc3QgcmVzdWx0LiBUaGlzIHdpbGwgbGVhZCB2YWx1ZSBtaXNtYXRj
aCBiZXR3ZWVuIHJpbmctPm5vX3NjaGVkdWxlciBhbmQgcmluZy0+c2NoZWQucmVhZHkuIElmIG15
IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCwgSSB0aGluayBhZGRpbmcgYSBjaGVjayBpbiB0aGlz
IGhlbHBlciBmdW5jdGlvbiB3aGljaCBvbmx5IHNldHMgc2NoZWQucmVhZHkgd2hlbiBub19zY2hl
ZHVsZXIgaXMgZmFsc2Ugd2lsbCBoZWxwLiAgU28gSSB3aWxsIHByb3ZpZGUgYSBwYXRjaCBzb29u
IHRvIHByZXZlbnQgdGhpcyBtaXNtYXRjaCBpbiBmdXR1cmUuDQoNCitpZiAoIXJpbmctPm5vX3Nj
aGVkdWxlcikNCisgICAgICAgcmluZy0+c2NoZWQucmVhZHkgIT0gcjsNCg0KUmVnYXJkcywNCkd1
Y2h1bg0KDQo+ID4+PiBbSlpdIEkgdGhpbmsgdGhlIHNjaGVkLnJlYWR5IGNvbmZ1c2VzIHBlb3Bs
ZS4gaGVyZSBqdXN0IG1lYW5zIHJpbmcNCj4gPj4+IGlzIHJlYWR5IGJlIHVzZWQuDQo+ID4+DQo+
ID4+IFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIE9uZSBxdWVzdGlvbiBpcyB0aGVuIGRv
IHdlIG5lZWQgdG8NCj4gPj4gY2hlY2sgcmluZyByZWFkeSBzdGF0dXMgZm9yIGFzc2lnbmluZyB4
Y3AgaWRzIG9yIGp1c3QgY2hlY2sgaWYgdGhlDQo+ID4+IHJpbmcgaXMgYXNzb2NpYXRlZCB3aXRo
IGEgc2NoZWR1bGVyPw0KPiA+Pg0KPiA+PiBLZWVwIG9ubHkgdGhpcyAtIGlmICghcmluZyB8fCBy
aW5nLT5ub19zY2hlZHVsZXIpIHRvIGFzc2lnbiB4Y3AgaWRzDQo+ID4+IGFuZCBsZWF2ZSB0aGUg
cmluZyByZWFkeSBzdGF0dXMgdG8gdGhlIGxvZ2ljIHdoaWNoIHJlYWxseSBhY2NlcHRzDQo+ID4+
IGpvYnMgb24gdGhlIHJpbmc/DQo+ID4gW0paXSBJIHRoaW5rIGtlZXBpbmcgcmluZy0+c2NoZWQu
cmVhZHkgd2lsbCByZWR1Y2Ugc2NoZWR1bGUgbGlzdCB3aGljaA0KPiA+IHdpbGwgc2F2ZSBhIGxp
dHRsZSBzY2hlZHVsaW5nIHRpbWUuDQo+DQo+IEZpbmUsIHdpbGwganVzdCBwdXNoIHRoaXMgb25l
Lg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+PiBMaWpv
DQo+ID4+DQo+ID4+Pj4gVGhpcyBwYXRjaCBpcyBSZXZpZXdlZC1ieTogSmFtZXMgWmh1IDxKYW1l
cy5aaHVAYW1kLmNvbT4NCj4gPj4+DQo+ID4+Pj4gVGhhbmtzLA0KPiA+Pj4+IExpam8NCj4gPj4+
Pg0KPiA+Pj4+Pj4gICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPj4+Pj4+ICAgICAgICAgICBh
cXVhX3ZhbmphcmFtX3hjcF9ncHVfc2NoZWRfdXBkYXRlKGFkZXYsIHJpbmcsDQo+ID4+Pj4+PiBy
aW5nLT54Y3BfaWQpOw0K
