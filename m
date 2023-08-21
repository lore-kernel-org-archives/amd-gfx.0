Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144EBEE4996
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 06:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA2910E1E1;
	Mon, 21 Aug 2023 06:35:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74ED10E1E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 06:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az20rRvNHMIcFLbz7SLlq7Mg7ZClQEGTRWYAro61eGtrGkv5Z698/NyREzA/C0aMy5VnrvgraeJjR+sqSA0rusyeZSXO7sRRGbQRNwoHLB737mcsN5myD8AWkYdW7RU3VBgcxYDchcwrvBGlsjr5GIXr5eJZGa8tx85hTpeNxY9sdhzu+7npMsm7TIpL6X+q6qOC+uNSsoC9iCLVvRYlHvgUvGGq9XLfGb3fre2Uli0CMBiRnudNJ1oKCtQ0PMSrSb3wRQAcccbVdINp0+vrENFDFjC5rFiJDgMWeDHHIM1a1lWnNeg07kUfOssDTIII9AWuddsvRsxbPufdKD9BDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbckMqPGqJQEZjirNLsjD/bQ43mwEkbmYOrUz1rCtjw=;
 b=UCYI+VXbXHtWeOOLQ/QakENbAonGeARTNJTxYyDbXze0KVh3wikwWOLIXWF0hqZxO/SgOe5AAxBGYPNLXwEyJD/HjC9HkDsOk2hA9AOi2CW5Cc/sOsFAmXkpr65RTue5wXddIWVTJQfrc7IqUJ2PFxOpYk4npenLo+KfHSklziJPZsP1RiwTV3J8c0rnJ/yxacp6xqU1kJJuP4MxeSw6yd3wBMDOqibLOHwwFx7G/QWYgUGo8JrovWbacUJ1+Sbmp/m7I+pbXkJ4v5TOCUMU2mWvLtZ7aUhFTW0BXcvmqZAQE7A1seuuY1zuD6wWUv5cc0Cn/UDFVbtV1nZy9E6aPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbckMqPGqJQEZjirNLsjD/bQ43mwEkbmYOrUz1rCtjw=;
 b=lsddqJdXtH3C8llxTEfblBqb8ef03X+//DuX2MLjbBxR6io9Tf08NNx9nN04K5cfWnLp9ZyF+sB3NWsFaE6Fl+wOQ+lI1XihxYENQHy4gF50bP6V+2g5sZpNuEm9g+Ylxz5Jp6UJVW8sRP11ZGzlLjn2inKIleEr47WPz5OMJN0=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 06:35:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f%5]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 06:35:07 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] A new set of Linux OD interfaces
Thread-Topic: [PATCH 0/8] A new set of Linux OD interfaces
Thread-Index: AQHZz1R8vJV4E5xF0UmwiH0IdOFyzq/0VHyA
Date: Mon, 21 Aug 2023 06:35:07 +0000
Message-ID: <DM6PR12MB2619645605002F3CA2AB7857E41EA@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230815084231.3229009-1-evan.quan@amd.com>
In-Reply-To: <20230815084231.3229009-1-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=73140742-8d86-4add-9aa8-fa5ff6416ae4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-21T06:34:44Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MW4PR12MB7358:EE_
x-ms-office365-filtering-correlation-id: c2990ad6-b653-40b8-6b16-08dba210c2ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B05kqAza9DivrVhloBNXr+tZO/N/MRAi2SnijKRj04bJ/5utRHOOcWbnMQpAewR9/DzOQb4qtVUXUxrvBR7o5FSNc8kqOmmCJ/UhmBqoKAs+NvYDJ3BOQHLAzJzv4Gjq6kGLYicE9/Ss0n2hAErJ1hNI8ZvgfYrtmChXf9obGIVSWp7/bRtO2ybSByNsRim3CRdAPTSJC72Uf/ydSqyeGIvCVoQN9UIFCSpiSZeiQHHdknfL8a5G/5JFQxjUxd1s9h4UYrhXeQ1UsXkd6K3LS+UbdLo3mq78Y7vWWYuNi9tsM5pEFwwMUp8CIfCB+R2pqEdwE64uGY3rUdZtViM++YCgNiJSo91gmaUqdXLSLemlmosIHSSoc7EX3tt8KTTxzskA7ZzQhfuWIo1DlGOsaeDwfzBccW5Yq93Zrq+dMv2+fliZw5TcvjvnDSYH7pYPxKG3gRI19RT3F+UvLp2VumuPBRcgugs/PZGVg+iCeZwZETwvQo3Y3V6fYTM8GCll0uMsYPJohDY0LGkJzSmKRIyuMoIsC7zSVyA7sGldYwT+E3p3VClqUyhBzErSc7B0sa1f7l6023qMQrQM0GpwF9q2AszR20UhNW7tmhaHCRJYs2v5tBUEDnOdJ9yG1hHV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66446008)(64756008)(6916009)(66476007)(76116006)(66556008)(66946007)(316002)(9686003)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(71200400001)(55016003)(38070700005)(7696005)(38100700002)(53546011)(6506007)(2906002)(83380400001)(86362001)(5660300002)(33656002)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3hGWXBXWXV4b1dKb1ZaVTdhUjVUVjlKekZDOEN5MXdWNmF5SEw5L1dpWGky?=
 =?utf-8?B?cnJxRUtDT0QrSzUvdXJYMnZQVkFDMTdKajlUem5MaExObEpPZkRWbGQrQkpv?=
 =?utf-8?B?L05JLzM3dVpabCt0MnF3YWUzQkpBaVg1ZmZrS0hDVzNYeGxROG1xR3FHWGVE?=
 =?utf-8?B?T0YxWncyU0NLSGo1Y0E0clV2TklkcS8wTkFhUGM4ZFAyWFNlWUFzR0JwenlF?=
 =?utf-8?B?V2tFY3VzOXVqVlRnVkNNcm8rT0JyMjQrUkl6MnhsRjNHaTYvZzJjc09Lak5F?=
 =?utf-8?B?ZnJsdXVucjN2eTgveng2dkQ0YVdsVmtHZzRBbmZXQXRYcWZvSklUZ0o2ZG5M?=
 =?utf-8?B?RDJ5WnA3b01DOGVQL0VlQUFkTG9JRUx4ajVWSjBmMEFPZU9nUGZRR1BOV2NQ?=
 =?utf-8?B?OWZFcS9aZGdGR2c2YVRqUmZvVThxdmpxWHQrK0hob3AwMDNxanlVZUZvTEhw?=
 =?utf-8?B?R3l0aXlYN08rUmM5M01ZV1Q3bWdXengzSWFCVHMvcHY3RU4wcnMvMEhhVTd5?=
 =?utf-8?B?TlFiQXdqUkxudEQ2anE5ZnREdFNvTmVCUjVmK2s2R0lzWDBqK21Sd0VtYW9L?=
 =?utf-8?B?amc3RnNWRlJLandHTTZrcEthL2ltY255dlFlbFlGUjNUNjlkTzBkWXVmNDR4?=
 =?utf-8?B?V2lXU1Y4a1QweDc2Z1pvRHA2RkhKaHVuTEtDWDdTZTFHeDQzNXdVaktnMUx1?=
 =?utf-8?B?VEVCWFk5MDE3b2I1ZmpSd2FHbVlwcnk5R2thTUlFQ3ZTMHRtdXZEZzljZ2F6?=
 =?utf-8?B?K3lXcEZZcU5QM3dyQ1ZWNGxndzNMRisrbU9qTjJFUTNBbFRSaXJqcmV0UGZq?=
 =?utf-8?B?SzJwZHNVZTg2VktNczFyVnptRG10bi9hWDRSQjVxYWIrTU91RnN0UzNTbHBw?=
 =?utf-8?B?TGlBZEZxKzRVeVdsNTU0UVpVakFmWWJqOGtjMU9oK05DVno4Rmd1YW93ZkRL?=
 =?utf-8?B?cnZvN3dET3k0T0JNNUJjVTdCc1lRdElqdXYwRDFFNE43RGVOa3lZZGNSNkRC?=
 =?utf-8?B?OVdNY0N3VmIraVpxNnpyMEZ6SXBRTUtkWXVmZDRPYmJiT3M0bWU4RUxkYWFN?=
 =?utf-8?B?ckRmQ0kvS0RRM3p2YjdxN3lwWjNKT2tSbDFwT2ZrL3dhQlU3Nk02R3g2S3Nx?=
 =?utf-8?B?V1gxcitCSlF5NzNNeVlNM2QvSk1uMDdLcmE0K2tBN2JPUDdqSXh5SVhhU3c5?=
 =?utf-8?B?V3JpY3J4UEFWRWt1M1F4akRlZWU5MU9maUxZaFNTWkZIeW1RRmpJOTFMR0k0?=
 =?utf-8?B?dURWYUNyOVMwTUpEVFo5WDdVc1U3WjJoK0huZzhUNDZ2Vnppa0xXa0UzVEJ0?=
 =?utf-8?B?cHphT0MyTDc4OUF6UkM3NmoxQlJveE9QdW5jbnVjZ0ZFSWlwNmdHQmJ6ZlJh?=
 =?utf-8?B?ZXlLTERxRFB3L1ZpeFBadGw1bkZZT2s1Yk8wVzl2SHdrdTNBVGhpR0JRZUpa?=
 =?utf-8?B?WUQ2STRtc0JLaHpkQjhVQ3I1WVNrMjMxSkdkQXRpQnlENFJZMEQydmFqQ21u?=
 =?utf-8?B?U0hWL0c0RUlqRWQzNW1GVWtBRytIVFlMSEc2UFJkR2Q0N1BZRFRYR0lRQWdF?=
 =?utf-8?B?WXRsRzZiZWw5bUhERlk0aElIaFA2dXBwaDZ2YXgxWnFCNFVhSE9OWmQ2R2xX?=
 =?utf-8?B?OWsyejFrL2h6bE5id0F6enFxOVB6ZjB4RzVIdW5OTC9lZk5PSEV1ci9QWHlk?=
 =?utf-8?B?dExUS2xZcE4xQXVybFlXcDlac0VwTEUyOVNjY3dVK3dBeWNXV2gydkQ3R0x5?=
 =?utf-8?B?V3FRKzR5MVgvUjlwaDB0d2tkV3R3MENISXB5aCtscW02RkFtN2h3UWlZR1dL?=
 =?utf-8?B?UUNsSE0vYTZZYmtldEpOOW1FWGh4dFk5cTBlYktMaXdVKzZqVFNRUDNFNXVD?=
 =?utf-8?B?NXJub1paRE15NHdCYUJLZjVVbEVWc0JUNEc5anJhMWtLdTh3OWo3eHQzS2Jq?=
 =?utf-8?B?RzArVGNHNXAxbjdzS2dPVzNmVzhFd3NhczhJT2IvUXJKRWZyZ3MrZ0RBa2Nx?=
 =?utf-8?B?NjhqYjlRenhRZGFucjJ3MitjMlM2dUJqb2FhTk5JREFDbkJ6OXVRanE5VGFY?=
 =?utf-8?B?K0ptM3RvbGtIZ1lSVzZpd2x3Nmh1VWRFaUZ5MkJUVGpvM2RScWRsNVZ4R3lB?=
 =?utf-8?Q?e3Qw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2990ad6-b653-40b8-6b16-08dba210c2ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 06:35:07.6387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dViAtJMj5GYxGdDYyE4M49GA5js5H3rffExctwPbEAFryS06xqwmeRVlOCVobHvL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClBpbmcuLg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29t
Pg0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMTUsIDIwMjMgNDo0MiBQTQ0KPiBUbzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IFF1YW4sIEV2YW4NCj4gPEV2YW4uUXVhbkBhbWQuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggMC84XSBBIG5ldyBzZXQgb2YgTGludXggT0QgaW50ZXJmYWNlcw0K
Pg0KPiBUaGUgZXhpc3RpbmcgT0QgaW50ZXJmYWNlIGBwcF9vZF9jbGtfdm9sdGFnZWAgaXMgdW5h
YmxlIHRvIG1lZXQgdGhlIGdyb3dpbmcNCj4gZGVtYW5kcyBmb3IgbW9yZSBPRCBmdW5jdGlvbmFs
aXRpZXMuIFNpbmNlIHRoZSBidWYgdXNlZCB3aXRoaW4gaXQgY29tZXMgd2l0aA0KPiBzaXplIGxp
bWl0IGFzIG9uZSBwYWdlLiBXaXRoIG1vcmUgT0QgZnVuY3Rpb25hbGl0aWVzIGFkZGVkLCB3ZSB3
aWxsIGhpdCB0aGF0DQo+IGxpbWl0IHNvb24uDQo+DQo+IFRvIGJldHRlciBtZWV0IHRoZSBncm93
aW5nIGRlbWFpbmRzLCBhIG5ldyBzZXQgb2YgT0QgaW50ZXJmYWNlcyBhcmUgZGVzaWduZWQuDQo+
IFdpdGggdGhpcyBuZXcgZGVzaWduLCB0aGVyZSB3aWxsIGJlIG11bHRpcGxlIGludGVyZmFjZXMg
ZXhwb3NlZCB3aXRoIGVhY2gNCj4gcmVwcmVzZW50aW5nIGEgc2luZ2xlIE9EIGZ1bmN0aW9uYWxp
dHkuIEFuZCBhbGwgdGhvc2UgaW50ZXJmYWNlcyB3aWxsIGJlIGFycmFuZ2VkDQo+IGluIGEgdHJl
ZSBsaWtlZCBoaWVyYXJjaHkgYXMgYmVsb3cuIE1lYW53aGlsZSBhbGwgZnVuY3Rpb25hbGl0aWVz
IGZvciB0aGUgc2FtZQ0KPiBjb21wb25lbnQgd2lsbCBiZSBhcnJhbmdlZCB1bmRlciB0aGUgc2Ft
ZSBkaXJlY3RvcnkuDQo+DQo+IGdwdV9vZC8NCj4g4pSc4pSA4pSAIGZhbl9jdHJsDQo+ICAgICDi
lJzilIDilIAgYWNvdXN0aWNfbGltaXRfcnBtX3RocmVzaG9sZA0KPiAgICAg4pSc4pSA4pSAIGFj
b3VzdGljX3RhcmdldF9ycG1fdGhyZXNob2xkDQo+ICAgICDilJzilIDilIAgZmFuX2N1cnZlDQo+
ICAgICDilJzilIDilIAgZmFuX21pbmltdW1fcHdtDQo+ICAgICDilJzilIDilIAgZmFuX21vZGUN
Cj4gICAgIOKUnOKUgOKUgCBmYW5fdGFyZ2V0X3RlbXBlcmF0dXJlDQo+IC4uLg0KPiAuLi4obW9y
ZSB0byBiZSBhZGRlZCkNCj4NCj4NCj4gRXZhbiBRdWFuICg4KToNCj4gICBkcm0vYW1kL3BtOiBp
bnRyb2R1Y2UgYSBuZXcgc2V0IG9mIE9EIGludGVyZmFjZXMNCj4gICBkcm0vYW1kZ3B1OiByZXZp
c2UgdGhlIGRldmljZSBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZXMNCj4gICBkcm0vYW1kL3BtOiBh
ZGQgZmFuIG1vZGUgT0Qgc2V0dGluZyBzdXBwb3J0IGZvciBTTVUxMw0KPiAgIGRybS9hbWQvcG06
IGFkZCBmYW4gdGVtcGVyYXR1cmUvcHdtIGN1cnZlIE9EIHNldHRpbmcgc3VwcG9ydCBmb3INCj4g
U01VMTMNCj4gICBkcm0vYW1kL3BtOiBhZGQgZmFuIGFjb3VzdGljIGxpbWl0IE9EIHNldHRpbmcg
c3VwcG9ydCBmb3IgU01VMTMNCj4gICBkcm0vYW1kL3BtOiBhZGQgZmFuIGFjb3VzdGljIHRhcmdl
dCBPRCBzZXR0aW5nIHN1cHBvcnQgZm9yIFNNVTEzDQo+ICAgZHJtL2FtZC9wbTogYWRkIGZhbiB0
YXJnZXQgdGVtcGVyYXR1cmUgT0Qgc2V0dGluZyBzdXBwb3J0IGZvciBTTVUxMw0KPiAgIGRybS9h
bWQvcG06IGFkZCBmYW4gbWluaW11bSBwd20gT0Qgc2V0dGluZyBzdXBwb3J0IGZvciBTTVUxMw0K
Pg0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jICAgIHwgIDM5
ICstDQo+ICAuLi4vZ3B1L2RybS9hbWQvaW5jbHVkZS9rZ2RfcHBfaW50ZXJmYWNlLmggICAgfCAg
MTQgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMgICAgICAgICAgICB8
IDY3NiArKysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2Ft
ZGdwdV9kcG0uaCAgICAgICB8ICAxNiArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L2FtZGdwdV9zbXUuYyAgICAgfCAgMTIgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9pbmMvc211X3R5cGVzLmggIHwgICA2ICsNCj4gIC4uLi9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L3NtdV92MTNfMF8wX3BwdC5jICB8IDMxNiArKysrKysrLQ0KPiAgIC4uLi9kcm0vYW1kL3BtL3N3
c211L3NtdTEzL3NtdV92MTNfMF83X3BwdC5jICB8IDMxNiArKysrKysrLQ0KPiAgOCBmaWxlcyBj
aGFuZ2VkLCAxMzcwIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAy
LjM0LjENCg0K
