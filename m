Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC36A60FF2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 10:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC36A60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617CA6ED88;
	Wed,  6 Oct 2021 10:14:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A386ED88
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 10:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8ByLkIGVrpp2Z6YldHJtzxy1SI4CrlXiL0K3CFa2wr84flSeKgNCupI+L5+gmPAPaO29hlx/GolVNyW3+dIF3WdprGRdgyw5oQgTGkyi6gGS3BupQ51OZ+G3SbBewS0+hzgKWgGBHhNH1hoEnLP9oHfKxBphJXfcGImjdGi7a4dlPmJXNxiUC54DFYIESIlpoI4JLd4v+m5yIiysXGh4pFI/qCbD7yfa4V6DM+Kc1Destny9HjH32yAznMjaN/UIacsnLkRKKtdXXWC4rOTpZTq7VyS2MQmqgmhJfwqO7O3nZRk3vuj+0MqOaS+KBYrkzgrAzbWoHT1fA7bDkkGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wgPG4CzMXoHsFH4kK48EOIfyRmGMis3aN101/vnkEA=;
 b=hTgWitXdoirrHfvauDR3jmqwBfFdr8Ad+6uyG9up9H/NKxMpbVpo90qX/K8pCb6mHbLIuhPOhQSOeqsve412uS8HfqiE7Il7SZfvpNzuC0+bWyJOWPw8ITo8jp0r16+NosIRkqn0KVX7NIVhesm1Uyntve9rzvQ7cTRTQ07yQ9qnulFBUxpHyRHDR3kx7kMK8VBryxkuP87h4zoN3IvgHjaz7ZOQ62JTUaTniZ7BpSkV80IOf3FZugJYBeEn5i/j30enB+6wmBEDQmiaYtaI7fCNbl8B2p+aaCnRLd33JtW6POCLOsglJs0Z4503NCpkPgiiSJbjxC0yvUDeeRmmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wgPG4CzMXoHsFH4kK48EOIfyRmGMis3aN101/vnkEA=;
 b=iyDlxS+A90cm1qT2aI+laH+ey7rm5mrKZEtTG/9GooCYgvGG39LZctcpIVlVLSH+k0dlCHJsTibWJuK+HyzIXgl7pe9O/zBUPdJhm94r+hhtwW/mjCzetfnEC3GEKRFhTawV430M/a8GaxePYTJ1I5CJte4oTaCA0kW7snw95oM=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by CO6PR12MB5459.namprd12.prod.outlook.com (2603:10b6:303:13b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 10:14:38 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::14f7:9173:d617:e87c%2]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 10:14:37 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "Wang, Chao-kai (Stylon)" <Stylon.Wang@amd.com>,
 "Shih, Jude" <Jude.Shih@amd.com>, "Kizito, Jimmy" <Jimmy.Kizito@amd.com>,
 "Somasundaram, Meenakshikumar" <Meenakshikumar.Somasundaram@amd.com>, "Lei,
 Jun" <Jun.Lei@amd.com>
Subject: RE: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP
 link training
Thread-Topic: [PATCH v2 19/23] drm/amd/display: Add debug flags for USB4 DP
 link training
Thread-Index: AQHXub8bFV9A5Kq0aE2v3YqOrJdZnavEpHCAgAEVgKA=
Date: Wed, 6 Oct 2021 10:14:37 +0000
Message-ID: <CO6PR12MB5489C5E88F098D2C6BC7AF69FCB09@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-20-Wayne.Lin@amd.com>
 <33774abc-c31d-e3d6-43ec-b80bc7e946c5@amd.com>
In-Reply-To: <33774abc-c31d-e3d6-43ec-b80bc7e946c5@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4155d2b6-7ab3-46ec-950f-ec3617b08dde;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-06T09:44:39Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ded2674-a944-4c58-13f4-08d988b21a6d
x-ms-traffictypediagnostic: CO6PR12MB5459:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB54591DF51624E8EA2433ECEEFCB09@CO6PR12MB5459.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TI/zG+njhm/9VyETVcAJuUbeprmkY59dIVJmIsMOHVlaP4vz/tvnOwAMnyarclYw4MulzdEGqBEysLgu//5WdBAoZX2LzuO9L5l9SZvAVkOPXycVaWumEzIT2IVXbd90fMjeBcSjyvtHxrui99LSX+qOCyZWCF64a5ga4EAUF2zTSJ0bMxvLT7BAQYDzjZfLLKd2BiRGHl7C7fOevTW3gM0l2/O09bHAn1Bc7d+Eq1kJ4pdi8jVdwQ/y2HbTU4EtlzneNBtuMlpD/+r5FzCNDo+nM5t3NBVqopgsB5S9g8153Vv2YHvosZO9Imaya8gaopIH9Nsk5xIKWW142prCfOmhGTeS0FIAX1xsub/tPbJy5chgbBVMk//plZZyU9e5spBzMu+hArjoW5rarUEWb0k81naiW35bPEwsLW/LINQ+F6GAGmp2JIQ/VtDSR5vw/tzEFCMoZKXcLkZcB1wiKW5+p2heWaCVkjEzorJpr3a7l+sKkF4PKk2Rdiy8xYICvQifad4L0rewsy7Q1ogWkd5HjNPqeDKQCpeVU2kUIRJTtIBTwANQU8Y6XNm7BMRBHEZuCTRaRcU2A5tDwAnFMUFYu2sPYEg02O12iQs5ufj3ffgAUokLE+svaBbUEHMGkk8kUEQA+y+Cpqg4vmzCB5NTKpWBEbYvtCOVSQpSIwD5gNaqfCvadBIbvTlJzdnDdQi4xUkI+8mhHKmKT6pHtA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(8676002)(66446008)(64756008)(66556008)(66476007)(508600001)(53546011)(76116006)(316002)(8936002)(26005)(4326008)(110136005)(186003)(54906003)(55016002)(71200400001)(7696005)(2906002)(52536014)(86362001)(83380400001)(5660300002)(6506007)(38070700005)(38100700002)(9686003)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxsV2N0NzR6TlIxOW9VNmZ1Z1FjWGVhbHpsTnUzU1dVSjJOWndXbVpHQ0cz?=
 =?utf-8?B?eE40emZNMnpYcVNJeDNRUGlPZmlTcGg4OG13YXV1cnR4aXRsQjUwd3V6THYr?=
 =?utf-8?B?SnRsOUJ4Vy9kU0ZOM1NGNGdHV0F5TE1MWnp0NDJWT0tVV3FQNFBUY0hiZyti?=
 =?utf-8?B?UGF2NkFGcy9IeFBBZ1JrWldSd0ZOcU1uUGEzUk4yeUVZaUlmTnNtMmlTNHJG?=
 =?utf-8?B?R0lBVDNBTHBTYUNTMHBIekdWYi9wa1RJL1YvMU43UDNEYjc0d3A4L1hGQmZ6?=
 =?utf-8?B?WHJYRUFza3QwUis0VDkrYlVneko0cGluOFM3VXBtcjFZVUFMYlBhTmxMYTZV?=
 =?utf-8?B?S3I1dkVJa3BIWEFmRmgvOVdqakFJQzRxZk9qeXN2OSt2RFVUVVJzZllUSjRw?=
 =?utf-8?B?TkhoNnB0eGdQbklMVXZYa2kzdlRlc0R2YjJGbk9BRmNYR1ZmZlhMdDY0a3Q4?=
 =?utf-8?B?a0RRVTZJcmZDaDlDV1N1WXNyWVZoWTI1RXFld1h4WXc3ajNwN2dERk9wUEM1?=
 =?utf-8?B?Q2sveG11czg2ZkNzQWRYcm5wL0UyYmhHQ0Q1ZGtOR3U0UFd1RUZOdEhRbzBH?=
 =?utf-8?B?eTdlbDVOeVMrV3ZBa0ZSUGpib2JPM0hKZkx5cDllZWc5ZlhWeStVRDU5ZXBu?=
 =?utf-8?B?TTl2VVRGTXk5cjZ0cEl3WnVJRDRFRGMyUW14eTd0d1o3bWdSZ1ZFTytGa3Iy?=
 =?utf-8?B?TUxzYlRubFFpUjZjL3hHRHZWaHZ5ZjVHMCtsZ0I1NnY1cmwwdkdlYmFkcE0y?=
 =?utf-8?B?aENtZUlrVmdDZEFRNS8zcUpubzVnZVJJRnl4WHZLUjZvakg5SnJ5T0gyQ2Yz?=
 =?utf-8?B?NHVpdk1kL0tEdG55U1hoNzc3SVZoRjlMdmN0c1RZaVhMQ2phcit3RTRTRFJz?=
 =?utf-8?B?YkNabTVpckY1K0FDR24rSTc3S2NnZUREdjh1eXJhOUNReFl4NU1IM0t0WitL?=
 =?utf-8?B?cGRSMXlINTJKM0s4dWxCSk0yRTRpWG1FbFVGZmM1OXdsejBtbVNsVkxpOUVR?=
 =?utf-8?B?a1NMemFINWlPRFh1a2RZdUdXOTJDRUlSQU8zenZJenVycDlSSnVkVyt1aUNp?=
 =?utf-8?B?dkdEVTV5OUJ0cGtiVUw1aWNkUjRiQzBaelUrTDNyVk1UeERJQzhDZ3VQY2tE?=
 =?utf-8?B?YWhKL1V4V01RSEc5YWdSRk42aTZidjk5dGpTMWtYQ2R6b3Z0RFhqTElSZVhN?=
 =?utf-8?B?R1FXSTVnbVNIMHNJQVdtNldCVFV2c0VqemNkRkpuOVVub3VOZ05BRlBKV1M2?=
 =?utf-8?B?Z0svR0FJdTluaEVOZytiSXVQQWhPZFVsaUMzYkIvaW5tc2x5bUl5VHBUK1Mz?=
 =?utf-8?B?VUIrUUdUWG9QbDRRUVMzc2NRYll6L2dMaG5Mdld4dHVhaFZjN0lmSnE4cnFD?=
 =?utf-8?B?cndsSG1TRWMvQkVFUjBtbmlzcVZjUXh0MHdLWncySTZ4dFA4Nlkvc2VMdkVv?=
 =?utf-8?B?MzBoWVRtRDU4OXRwSkJra1BhL0JYb1JLY2NsZ1JaMkhTN0RrcTh0V1h6andj?=
 =?utf-8?B?ZUlRTUhmUTNXcXpoVENMSFdlT2hGLzNQejZ1SWtYQllaOHA0NVROVEZ3MzNm?=
 =?utf-8?B?QksxdnRWNVoxcUpQaytEVnh0dVFWdHo3YU0xbkNEcE13dzVTZWFaOU8wWUl4?=
 =?utf-8?B?RG1KbE42SEVhU3g5ZVlCRmNYbFFrL0UrQVdHUlo2eDhPMUJxdWlXR1l3OUtY?=
 =?utf-8?B?S3R4MlQ5RmM3NFFEcE9WeUZMMGdvc3JYWTBUamd3RDhUbG54YmQ3bkZZbWF4?=
 =?utf-8?Q?pASSyBBHdwjMJ9/TLugJwloLF9g7xkdeHzCUJGy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ded2674-a944-4c58-13f4-08d988b21a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 10:14:37.4993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MW43wG0qBljwgn5x7AGjpC2kxVDGlCW/77qhQcjZIxMGMkHFRrRvsosD9qvIOhLJD9vjgHCJiv7bkFPorehqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5459
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXZW50bGFu
ZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0
b2JlciA2LCAyMDIxIDE6MTEgQU0NCj4gVG86IExpbiwgV2F5bmUgPFdheW5lLkxpbkBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRl
ciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEthemxhdXNrYXMsIE5pY2hvbGFzIDxOaWNo
b2xhcy5LYXpsYXVza2FzQGFtZC5jb20+OyBTaXF1ZWlyYSwgUm9kcmlnbw0KPiA8Um9kcmlnby5T
aXF1ZWlyYUBhbWQuY29tPjsgV2FuZywgQ2hhby1rYWkgKFN0eWxvbikgPFN0eWxvbi5XYW5nQGFt
ZC5jb20+OyBTaGloLCBKdWRlIDxKdWRlLlNoaWhAYW1kLmNvbT47IEtpeml0bywgSmltbXkNCj4g
PEppbW15Lktpeml0b0BhbWQuY29tPjsgU29tYXN1bmRhcmFtLCBNZWVuYWtzaGlrdW1hciA8TWVl
bmFrc2hpa3VtYXIuU29tYXN1bmRhcmFtQGFtZC5jb20+OyBMZWksIEp1biA8SnVuLkxlaUBhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDE5LzIzXSBkcm0vYW1kL2Rpc3BsYXk6IEFk
ZCBkZWJ1ZyBmbGFncyBmb3IgVVNCNCBEUCBsaW5rIHRyYWluaW5nDQo+DQo+DQo+DQo+IE9uIDIw
MjEtMTAtMDUgMDM6NTIsIFdheW5lIExpbiB3cm90ZToNCj4gPiBGcm9tOiBKaW1teSBLaXppdG8g
PEppbW15Lktpeml0b0BhbWQuY29tPg0KPiA+DQo+ID4gW1doeSAmIEhvd10NCj4gPiBBZGRpdGlv
bmFsIGRlYnVnIGZsYWdzIHRoYXQgY2FuIGJlIHVzZWZ1bCBmb3IgdGVzdGluZyBVU0I0IERQIGxp
bmsNCj4gPiB0cmFpbmluZy4NCj4gPg0KPiA+IEFkZCBmbGFnczoNCj4gPiAtIDB4MiA6IEZvcmNl
cyBVU0I0IERQIGxpbmsgdG8gbm9uLUxUVFBSIG1vZGUNCj4gPiAtIDB4NCA6IEV4dGVuZHMgc3Rh
dHVzIHJlYWQgaW50ZXJ2YWxzIHRvIGFib3V0IDYwcy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBN
ZWVuYWtzaGlrdW1hciBTb21hc3VuZGFyYW0NCj4gPiA8bWVlbmFrc2hpa3VtYXIuc29tYXN1bmRh
cmFtQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEp1biBMZWkgPEp1bi5MZWlAYW1kLmNvbT4N
Cj4gPiBBY2tlZC1ieTogV2F5bmUgTGluIDxXYXluZS5MaW5AYW1kLmNvbT4NCj4gPiBBY2tlZC1i
eTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEppbW15IEtpeml0byA8SmltbXkuS2l6aXRvQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAu
YyAgIHwgNiArKysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfbGlua19kcGlhLmMgfCA2ICsrKysrKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGMuaCAgICAgICAgICAgICAgICB8IDQgKysrLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvaW5jL2RjX2xpbmtfZHBpYS5oICB8IDMgKysrDQo+ID4gIDQgZmlsZXMg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+
ID4gaW5kZXggYmZiYTFkMmM2YTE4Li40MjNmYmQyYjliMzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jDQo+ID4gQEAg
LTQ1MjgsNiArNDUyOCwxMiBAQCBib29sIGRwX3JldHJpZXZlX2x0dHByX2NhcChzdHJ1Y3QgZGNf
bGluayAqbGluaykNCj4gPiAgICAgICAgICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgICAgICAg
ICBsaW5rLT5sdHRwcl9tb2RlID0gTFRUUFJfTU9ERV9OT05fVFJBTlNQQVJFTlQ7DQo+ID4gICAg
IH0NCj4gPiArI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfRENfRENOKQ0KPg0KPiBXaHkgaXMg
dGhpcyBndWFyZGVkIHdpdGggRENfRENOIHdoZW4gYWxsIG90aGVyIERQSUEgY29kZSBpc24ndD8N
Cj4gSXQgbG9va3MgbGlrZSBpdCBtaWdodCBiZSB1bm5lY2Vzc2FyeS4NClRoYW5rcyBIYXJyeS4N
Cg0KU2luY2UgZGVjbGFyYXRpb24gb2YgZHBpYV9kZWJ1ZyB2YXJpYWJsZSBpcyBndWFyZGVkIGJ5
IENPTkZJR19EUk1fQU1EX0RDX0RDTiwNCndlIHNob3VsZCBrZWVwIHRoaXMgaGVyZS4NCg0KVGhh
bmtzIQ0KPg0KPiA+ICsgICAvKiBDaGVjayBEUCB0dW5uZWwgTFRUUFIgbW9kZSBkZWJ1ZyBvcHRp
b24uICovDQo+ID4gKyAgIGlmIChsaW5rLT5lcF90eXBlID09IERJU1BMQVlfRU5EUE9JTlRfVVNC
NF9EUElBICYmDQo+ID4gKyAgICAgICBsaW5rLT5kYy0+ZGVidWcuZHBpYV9kZWJ1Zy5iaXRzLmZv
cmNlX25vbl9sdHRwcikNCj4gPiArICAgICAgICAgICBsaW5rLT5sdHRwcl9tb2RlID0gTFRUUFJf
TU9ERV9OT05fTFRUUFI7ICNlbmRpZg0KPiA+DQo+ID4gICAgIGlmIChsaW5rLT5sdHRwcl9tb2Rl
ID09IExUVFBSX01PREVfTk9OX1RSQU5TUEFSRU5UIHx8IGxpbmstPmx0dHByX21vZGUgPT0gTFRU
UFJfTU9ERV9UUkFOU1BBUkVOVCkgew0KPiA+ICAgICAgICAgICAgIC8qIEJ5IHJlYWRpbmcgTFRU
UFIgY2FwYWJpbGl0eSwgUlggYXNzdW1lcyB0aGF0IHdlIHdpbGwgZW5hYmxlIGRpZmYNCj4gPiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHBpYS5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwaWEu
Yw0KPiA+IGluZGV4IDc0MDdjNzU1YTczZS4uY2UxNWEzOGMyYWVhIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHBpYS5jDQo+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcGlhLmMN
Cj4gPiBAQCAtNTI4LDYgKzUyOCwxMiBAQCBzdGF0aWMgdWludDMyX3QgZHBpYV9nZXRfZXFfYXV4
X3JkX2ludGVydmFsKGNvbnN0IHN0cnVjdCBkY19saW5rICpsaW5rLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkcF90cmFuc2xhdGVfdHJhaW5pbmdfYXV4X3JlYWRfaW50ZXJ2YWwo
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGluay0+ZHBjZF9jYXBz
Lmx0dHByX2NhcHMuYXV4X3JkX2ludGVydmFsW2hvcCAtIDFdKTsNCj4gPg0KPiA+ICsjaWYgZGVm
aW5lZChDT05GSUdfRFJNX0FNRF9EQ19EQ04pDQo+DQo+IFNhbWUgaGVyZS4gUGxlYXNlIGRyb3Ag
dGhpcyBndWFyZCBpZiB3ZSBkb24ndCBuZWVkIGl0Lg0KPg0KPiBIYXJyeQ0KPg0KPiA+ICsgICAv
KiBDaGVjayBkZWJ1ZyBvcHRpb24gZm9yIGV4dGVuZGluZyBhdXggcmVhZCBpbnRlcnZhbC4gKi8N
Cj4gPiArICAgaWYgKGxpbmstPmRjLT5kZWJ1Zy5kcGlhX2RlYnVnLmJpdHMuZXh0ZW5kX2F1eF9y
ZF9pbnRlcnZhbCkNCj4gPiArICAgICAgICAgICB3YWl0X3RpbWVfbWljcm9zZWMgPSBEUElBX0RF
QlVHX0VYVEVOREVEX0FVWF9SRF9JTlRFUlZBTF9VUzsNCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+
ICAgICByZXR1cm4gd2FpdF90aW1lX21pY3Jvc2VjOw0KPiA+ICB9DQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmgNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oDQo+ID4gaW5kZXggZTNmODg0OTQyZTA0Li44NmZh
OTRhMmVmNDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGMuaA0KPiA+
IEBAIC00OTksNyArNDk5LDkgQEAgdW5pb24gcm9vdF9jbG9ja19vcHRpbWl6YXRpb25fb3B0aW9u
cyB7ICB1bmlvbg0KPiA+IGRwaWFfZGVidWdfb3B0aW9ucyB7DQo+ID4gICAgIHN0cnVjdCB7DQo+
ID4gICAgICAgICAgICAgdWludDMyX3QgZGlzYWJsZV9kcGlhOjE7DQo+ID4gLSAgICAgICAgICAg
dWludDMyX3QgcmVzZXJ2ZWQ6MzE7DQo+ID4gKyAgICAgICAgICAgdWludDMyX3QgZm9yY2Vfbm9u
X2x0dHByOjE7DQo+ID4gKyAgICAgICAgICAgdWludDMyX3QgZXh0ZW5kX2F1eF9yZF9pbnRlcnZh
bDoxOw0KPiA+ICsgICAgICAgICAgIHVpbnQzMl90IHJlc2VydmVkOjI5Ow0KPiA+ICAgICB9IGJp
dHM7DQo+ID4gICAgIHVpbnQzMl90IHJhdzsNCj4gPiAgfTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9kY19saW5rX2RwaWEuaA0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2luYy9kY19saW5rX2RwaWEuaA0KPiA+IGluZGV4
IDc5MGI5MDRlMzdlMS4uZTNkZmU0Yzg5Y2UwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvZGNfbGlua19kcGlhLmgNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2RjX2xpbmtfZHBpYS5oDQo+ID4gQEAgLTM0LDYg
KzM0LDkgQEAgc3RydWN0IGRjX2xpbmtfc2V0dGluZ3M7DQo+ID4gIC8qIFRoZSBhcHByb3hpbWF0
ZSB0aW1lICh1cykgaXQgdGFrZXMgdG8gdHJhbnNtaXQgOSBVU0I0IERQIGNsb2NrDQo+ID4gc3lu
YyBwYWNrZXRzLiAqLyAgI2RlZmluZSBEUElBX0NMS19TWU5DX0RFTEFZIDE2MDAwDQo+ID4NCj4g
PiArLyogRXh0ZW5kIGludGVydmFsIGJldHdlZW4gdHJhaW5pbmcgc3RhdHVzIGNoZWNrcyBmb3Ig
bWFudWFsIHRlc3RpbmcuDQo+ID4gKyovICNkZWZpbmUgRFBJQV9ERUJVR19FWFRFTkRFRF9BVVhf
UkRfSU5URVJWQUxfVVMgNjAwMDAwMDANCj4gPiArDQo+ID4gIC8qKiBAbm90ZSBDYW4gcmVtb3Zl
IG9uY2UgRFAgdHVubmVsaW5nIHJlZ2lzdGVycyBpbiB1cHN0cmVhbQ0KPiA+IGluY2x1ZGUvZHJt
L2RybV9kcF9oZWxwZXIuaCAqLw0KPiA+ICAvKiBEUENEIERQIFR1bm5lbGluZyBvdmVyIFVTQjQg
Ki8NCj4gPiAgI2RlZmluZSBEUF9UVU5ORUxJTkdfQ0FQQUJJTElUSUVTX1NVUFBPUlQgMHhlMDAw
ZA0KPiA+DQotLQ0KUmVnYXJkcywNCldheW5lDQo=
