Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6A7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 10:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005966FA3A;
	Wed,  1 Dec 2021 10:56:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA45F6FA3A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 10:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/6muS0yZ/GFqE6z54SyGhpJsp765B5mS237CMSbwmMbP0nJaHtDsgn35BA6s2Lwq1Be0o5v0IoJEHsk8Zpr5udn9q/zB1jPaNy/jmNDjqQ2YJzuGywYdTvl+qsmQGManAO8a8tS48ieF3Gtr/NXOGZAm1Vs61+4RQAANNlJV1GDQujH5HQm7RjhDoGFM5PuIHgZWz4Mk2UwFyg5NkBfllMEyBTcFKzHpVs++sJhocSxs+WVqz3s2eIV1tQecnTpIVXi27nY8vimy8zhY/9oOf4Ox6aAtjIEO3OT3RcZgaO4btfQ9UyhKZ8VPKBluCaVQq0PgKDqQHj3AC99NnWl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxv50bNMA+JKqFAhYzBuxg5RziyQGUmgWgpIOMVuqTA=;
 b=PZnwd6nAyCh5zx9SGv/7uXx7iyYgT66R8bRIInzN44rVZ5L+Gd5Py9wtBI8puZdlUmDPAfiWt8OhWHnEbtm5/B3Qv5b51P4nTh3D6SSz5oC8hNlt0DDambYQOOt5PMEVfXqRlMXbnsCdpn1tTC7c1YwVg1VikSB1RUzD4tPuGaa1r2IWDSFPsm7rwWOn35K+QLYf0a06snzxfbN1M6IEFk5SxY8qH7JGzJiTTk5XGeIErbTxiIRGyZ+VdiH1gX/1Ap75G6Dkh5yqBsM9PA+Zzud6veIXPB0/Yl/M7SqFmoFx6L3IUrcTILKGevF1vyq4T/4SHWkeDpV9YbLnkjqx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxv50bNMA+JKqFAhYzBuxg5RziyQGUmgWgpIOMVuqTA=;
 b=gMzMtHMobAWAFXDg1Sp4+1R+K5AzK3vbG+0CEVhM4YnGkis9tO6kXL28FgE8m7BapGS40vNpq6bjWKOuNA6h93BwzaY53RfshpDWd2s7pPqy2raE3dRLeJchzOpePKyTIPgxBayCFyxAKOwjh04vXb7QE2vS5ZstCOlrNPyw714=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (10.141.186.137) by
 DM6PR12MB3929.namprd12.prod.outlook.com (10.255.175.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Wed, 1 Dec 2021 10:56:33 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 10:56:32 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Topic: [PATCH] drm/amdgpu: add support to SMU debug option
Thread-Index: AQHX5pVcc3LghN55bkmOkF3w2Pkmd6wdY7IAgAAJ63CAAAaIAIAAAXmw
Date: Wed, 1 Dec 2021 10:56:32 +0000
Message-ID: <DM6PR12MB4250A6A7CDE29DB1D584F271FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <1f8f87f7-acac-acb7-5e1c-8baa643de7b3@amd.com>
 <DM6PR12MB42508C1A0E5EFA6D522C02D0FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <fbf8277b-27e1-03c0-3f9b-ee1defd7fdb2@amd.com>
In-Reply-To: <fbf8277b-27e1-03c0-3f9b-ee1defd7fdb2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-01T10:56:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=291f4d2d-3d18-4448-8ac4-402f23d556da;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-01T10:56:29Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 875ffdcd-a1c8-4e1e-b5c0-e1cf8d4cb0a2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4e853d3-4a75-46d5-8aa0-08d9b4b93c5d
x-ms-traffictypediagnostic: DM6PR12MB3929:
x-microsoft-antispam-prvs: <DM6PR12MB39290E5A99EEA33E229ECEB4FB689@DM6PR12MB3929.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeNoI8AO/oNRKsUJlwt+iSaqUwwpFEToDBlFEE3d05mV4R/ujoqD55GTDCTAMmfKZsPI8/wOw0EJ4Bf4DsVRYC3o0n5hxUFo34S+ls2smO2uVbIJ+lpi+EPtX9XzFVYZqIVWm4Tm373GGGgLHbj2tBNYCGmZ+N391O9P8TbSHavyYhZes8xPxSQlL1sXQE5/QoQIbebmpqf2RsH8kg6oLbQMTiyjWcbryNgOyd46S22VsLKB06ByEQ2bVPEX/DOp/V+eN6w65XBbKuIj9j5rEuKIUcrUe/e+PSPDdlMVHrJXxufiWhR8GQh/PKsd0RcfhRTuui5pqL+44xW9U3+vDI66HPBgSAd1xmCAQx60HixAbSnAcX6P7hrWb7g31adEF7RT1hdtW5uqUJ1fsMHKSSmX+zLnYUh2Emupc8Mwg2mgZ78jjCh9NFJTQnVX0yW/jsSZ7G+Oee8QXbTIHJPytY2QHdTw7chlVmFAIBi/UcK1LO1MOmvR5X7oi01ZZgRn0ijd0Snxmh38NySAnDau5QTqUvNwGK73/oi+JW4JPSv9HShMOLu5DBvNxUNUq9quvZQq9p0mpub9OAAmRxG/ZiTI73fBYEeHzQ4wm+FczHrM9cfnAoLr5M3ZQTQjWt8tzKS3Fka0blcZ/b3xRkYSHHjHEDOoWybSyv4NCVcl2DjvHx042X1jER6FdhZevnXkT0dT4pWOOl5BkIiN1NDfag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(86362001)(54906003)(110136005)(33656002)(316002)(7696005)(508600001)(5660300002)(2906002)(38070700005)(38100700002)(66476007)(66556008)(64756008)(66446008)(186003)(66946007)(4326008)(8936002)(55016003)(76116006)(122000001)(71200400001)(8676002)(9686003)(26005)(52536014)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjBXcWZlSFBZdTE2U1RUVUY2Q1gxQ1o0SEJyRERUWkV4cmdxQjAzVHJ2ZkZI?=
 =?utf-8?B?NWxOdnByYmhBcmNvdkVEVTY3bUZiTVNaVlphYTVxQXNKMjRQOU5oMDlyVlFu?=
 =?utf-8?B?eWFiWEVmWlBPNmRnNUZodG5tV01TOE9wRzBJTllIL21MdEJjZDJ4NFVMK3Na?=
 =?utf-8?B?MDBhbmxvNVZ3MWhSRTVIbit2ZEgrOWRxN29FR1ByMUJkK1ZBS2ZNNllZVlVP?=
 =?utf-8?B?UmxGOFYwSzAvcUVVS0IxdGtMQkx5UTR2eSt0YXNMUGR2K0ZPZmhRSHJ4M29n?=
 =?utf-8?B?cDFBN3lyL05VUXEvNmFxRHc0Q25GUWVQdm4zN2ErS3l2eC9PUG0vcnFSaU40?=
 =?utf-8?B?a3Z1UVp1dThBS1NvR2wxYkQvcFRKZEp5NTVBa043ZWw1eHRlajdCMHlRWktP?=
 =?utf-8?B?NXVHN05VUVBwSlJTbFZFQVZibkRJM3RINHNYRGZRTC9yUjFCbGNVaTZGWE5m?=
 =?utf-8?B?L21tbDlsVnBYdHVkK1Y3RVNCTVIyZUR3SnJ1ODEvQ08vZmVwRjVwd25mVlRM?=
 =?utf-8?B?WkI0QnU5MnV2dExQSXppK3lPN2JuOHZHTHI1cDliOElDSGdjVm1XaXZuUExI?=
 =?utf-8?B?MjV3aVZxSSt5S3poRlVoRFNsbnl3TXdFTE4rNi85OGh4ZHNIcVY0Z1NQUXpq?=
 =?utf-8?B?ZXJCSjhMaWdDcGR0VVpSOHNqdTZGN2lRUGFDZko0S3BwUFpxa1JHSERmSkVI?=
 =?utf-8?B?Tnp4SjhoSGVDYnRobnEydkMvVkN2VXR4aW5URzRxLzgrUjY4aGQyeklVVXNt?=
 =?utf-8?B?bVl0all4L1hsY2FTMVh3SkozSXlpV2FEQVVEdFZsM0wveFNKVEc0UnZIR0o5?=
 =?utf-8?B?TGpjMG5kdGhqallORnZObldNY3JRQ05CSkh2QmdZOXVHaHk5cjcweHh2Mm9O?=
 =?utf-8?B?NC9rZTg2MHp6QkxlNW9BWmErZlBDZ0QzL1RZM2hpR2loY1NBbE16QXROcUhJ?=
 =?utf-8?B?eWdKZ0NHSjJzN0RwQmhOYWFVczVLZUVob3NtbWVDR0VqckpRM1FtMFRrSE81?=
 =?utf-8?B?M2R1a2RaWmxOQ2Fta2NiOFFTdzhJMXpGS1Fud2tlRXd4YkpnRmlHb3hWSlNq?=
 =?utf-8?B?VXU2cnlOTnRSN1hHVUlvRllhZGd5WVgwMitqem5SVSt6TXZBQU40dzFJVnll?=
 =?utf-8?B?Q0V5WTV5M204cUZma3RRRW13SmE0MzBvalE5bVhmWlovNmphS3g0ekJFbGVK?=
 =?utf-8?B?V1loYlRGOEZ1anJUbUNleXMzNDlxZVhMd3E5MXRScGV0bWV2c0lvSEtxMzQ5?=
 =?utf-8?B?NDk4QjUxVXdNZ2ZzRExnejF4Y3orYm9GbHZmaS9qMTVmaVRTRHBtOWo1ZHBN?=
 =?utf-8?B?c0FSV1dOS2hoRWN2RXZ6V3dGN0JjaXZTTGU1Nmp2VDFnSVZMZG1DK2NVeWlh?=
 =?utf-8?B?bGpEd3BlQURDZ3oyYWIxRitNZ3kxSlh0Q1hqelFxUHZVRWlsMnE4MFVGL3Az?=
 =?utf-8?B?UWpTMkdaQWIrYjBzeXFyK2VVVSt1QURwWU14UlV6azVRSXBvR1FLb0cwTkpE?=
 =?utf-8?B?N1F1MUZoRDZHNFFML1hXbUtGRjR3VE0yM0plVUdULzBwbGZWeWFlWjlRVTEv?=
 =?utf-8?B?MnprQlBidlRiL0RXdldtN3R3dVcybi9na3NKSEFUcDQxTzlqMW85eGdRVEFo?=
 =?utf-8?B?TWdQZVR4VVE3a0dZUkZtTHE2QW83ZitZek1nN0ZvTFhsbGVIZDduTG9POXN6?=
 =?utf-8?B?R05WWTFpV05oVy8yQXRIa1FteEdTVW9uOGlyVG5tT2NreTZSczhpNXpaRnF6?=
 =?utf-8?B?WXEvMGxwUXFJTmJRb3FaMk5SR3BMVkRiNmR2clkyK2RBakRrUG9XeUkwZWNU?=
 =?utf-8?B?eE9mQ2YvS0RFQkhnWnlvUHVIc2F4SDBwUUdWeTF1RHZxSGU0TDMvMVhmcDVl?=
 =?utf-8?B?NysvMFJMUjJneGluM2dwZW1uekxQZHRBaW1UTHFpTm5qUFB3OStKemdjRGdY?=
 =?utf-8?B?ZXJiQzZKSjNNdkRBVEp1TTFvNVNrbml2dVlBV2lnVDJDcGtpOUNqZG91czIv?=
 =?utf-8?B?ZFF1cDRlSDQzNlRmSjRlcngxazYvUUl1YkVYVFFlRGJGT0ZpOCtOWWp4UE5L?=
 =?utf-8?B?VEIybXRhd3AzY1FRY1VkQ1hEd3NvTkdwL2xuTDZBczkxbFJOZTlFUWo1TGlO?=
 =?utf-8?B?ZGJvcXo3dWsyTkJLMW4rQk5MNzJtbC9GYmpUUFI3SlE4S1UxNUdjcTVLNy82?=
 =?utf-8?Q?NkfrvPz+Vlor+ovgZ6LM2Xg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e853d3-4a75-46d5-8aa0-08d9b4b93c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 10:56:32.3114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asrtvNcwVK3SCOJqTQaRXPuccIS13sW/UbEx0/Q40HlKWoGFBJCqUBMDyrb42bu4pg1rRZLQkSBVAcmAv1UOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
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
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+U2VudDogV2VkbmVz
ZGF5LCBEZWNlbWJlciAxLCAyMDIxIDY6NDYgUE0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5n
QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBzdXBwb3J0IHRvIFNNVSBkZWJ1
ZyBvcHRpb24NCj4NCj4NCj4NCj5PbiAxMi8xLzIwMjEgNDowOCBQTSwgWXUsIExhbmcgd3JvdGU6
DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4NCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNv
bT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDEsIDIwMjEgNTo0NyBQTQ0KPj4+IFRv
OiBZdSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgSHVhbmcsIFJheQ0KPj4+IDxSYXkuSHVhbmdAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZGdwdTogYWRkIHN1cHBvcnQgdG8gU01VIGRlYnVnIG9wdGlvbg0KPj4+DQo+Pj4NCj4+Pg0K
Pj4+IE9uIDEyLzEvMjAyMSAyOjU0IFBNLCBMYW5nIFl1IHdyb3RlOg0KPj4+PiBUbyBtYWludGFp
biBzeXN0ZW0gZXJyb3Igc3RhdGUgd2hlbiBTTVUgZXJyb3JzIG9jY3VycmVkLCB3aGljaCB3aWxs
DQo+Pj4+IGFpZCBpbiBkZWJ1Z2dpbmcgU01VIGZpcm13YXJlIGlzc3VlcywgYWRkIFNNVSBkZWJ1
ZyBvcHRpb24gc3VwcG9ydC4NCj4+Pj4NCj4+Pj4gSXQgY2FuIGJlIGVuYWJsZWQgb3IgZGlzYWJs
ZWQgdmlhIGFtZGdwdV9zbXVfZGVidWcgZGVidWdmcyBmaWxlLg0KPj4+PiBXaGVuIGVuYWJsZWQs
IGl0IG1ha2VzIFNNVSBlcnJvcnMgZmF0YWwuDQo+Pj4+IEl0IGlzIGRpc2FibGVkIGJ5IGRlZmF1
bHQuDQo+Pj4+DQo+Pj4+ID09IENvbW1hbmQgR3VpZGUgPT0NCj4+Pj4NCj4+Pj4gMSwgZW5hYmxl
IFNNVSBkZWJ1ZyBvcHRpb24NCj4+Pj4NCj4+Pj4gICAgIyBlY2hvIDEgPiAvc3lzL2tlcm5lbC9k
ZWJ1Zy9kcmkvMC9hbWRncHVfc211X2RlYnVnDQo+Pj4+DQo+Pj4+IDIsIGRpc2FibGUgU01VIGRl
YnVnIG9wdGlvbg0KPj4+Pg0KPj4+PiAgICAjIGVjaG8gMCA+IC9zeXMva2VybmVsL2RlYnVnL2Ry
aS8wL2FtZGdwdV9zbXVfZGVidWcNCj4+Pj4NCj4+Pj4gdjM6DQo+Pj4+ICAgIC0gVXNlIGRlYnVn
ZnNfY3JlYXRlX2Jvb2woKS4oQ2hyaXN0aWFuKQ0KPj4+PiAgICAtIFB1dCB2YXJpYWJsZSBpbnRv
IHNtdV9jb250ZXh0IHN0cnVjdC4NCj4+Pj4gICAgLSBEb24ndCByZXNlbmQgY29tbWFuZCB3aGVu
IHRpbWVvdXQuDQo+Pj4+DQo+Pj4+IHYyOg0KPj4+PiAgICAtIFJlc2VuZCBjb21tYW5kIHdoZW4g
dGltZW91dC4oTGlqbykNCj4+Pj4gICAgLSBVc2UgZGVidWdmcyBmaWxlIGluc3RlYWQgb2YgbW9k
dWxlIHBhcmFtZXRlci4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8bGFuZy55
dUBhbWQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RlYnVnZnMuYyAgICAgICAgfCAzICsrKw0KPj4+PiAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL2luYy9hbWRncHVfc211LmggICAgICAgICAgICB8IDUgKysrKysNCj4+Pj4gICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMgfCAyICsrDQo+
Pj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jICAgICAgICAgICAg
IHwgOCArKysrKysrLQ0KPj4+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMNCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+Pj4+IGluZGV4IDE2NGQ2YTllOWZiYi4uODZjZDg4OGM3
ODIyIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGVidWdmcy5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMNCj4+Pj4gQEAgLTE2MTgsNiArMTYxOCw5IEBAIGludCBhbWRncHVfZGVidWdmc19p
bml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+Pj4gKmFkZXYpDQo+Pj4+ICAgIAlpZiAoIWRlYnVn
ZnNfaW5pdGlhbGl6ZWQoKSkNCj4+Pj4gICAgCQlyZXR1cm4gMDsNCj4+Pj4NCj4+Pj4gKwlkZWJ1
Z2ZzX2NyZWF0ZV9ib29sKCJhbWRncHVfc211X2RlYnVnIiwgMDYwMCwgcm9vdCwNCj4+Pj4gKwkJ
CQkgICZhZGV2LT5zbXUuc211X2RlYnVnX21vZGUpOw0KPj4+PiArDQo+Pj4+ICAgIAllbnQgPSBk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCJhbWRncHVfcHJlZW1wdF9pYiIsIDA2MDAsIHJvb3QsIGFkZXYs
DQo+Pj4+ICAgIAkJCQkgICZmb3BzX2liX3ByZWVtcHQpOw0KPj4+PiAgICAJaWYgKElTX0VSUihl
bnQpKSB7DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRn
cHVfc211LmgNCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgN
Cj4+Pj4gaW5kZXggZjczOGY3ZGMyMGM5Li41MGRiZjU1OTRhOWQgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2FtZGdwdV9zbXUuaA0KPj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9hbWRncHVfc211LmgNCj4+Pj4gQEAgLTU2OSw2ICs1Njks
MTEgQEAgc3RydWN0IHNtdV9jb250ZXh0DQo+Pj4+ICAgIAlzdHJ1Y3Qgc211X3VzZXJfZHBtX3By
b2ZpbGUgdXNlcl9kcG1fcHJvZmlsZTsNCj4+Pj4NCj4+Pj4gICAgCXN0cnVjdCBzdGJfY29udGV4
dCBzdGJfY29udGV4dDsNCj4+Pj4gKwkvKg0KPj4+PiArCSAqIFdoZW4gZW5hYmxlZCwgaXQgbWFr
ZXMgU01VIGVycm9ycyBmYXRhbC4NCj4+Pj4gKwkgKiAoMCA9IGRpc2FibGVkIChkZWZhdWx0KSwg
MSA9IGVuYWJsZWQpDQo+Pj4+ICsJICovDQo+Pj4+ICsJYm9vbCBzbXVfZGVidWdfbW9kZTsNCj4+
Pj4gICAgfTsNCj4+Pj4NCj4+Pj4gICAgc3RydWN0IGkyY19hZGFwdGVyOw0KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMN
Cj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQu
Yw0KPj4+PiBpbmRleCA2ZTc4MWNlZThiYjYuLmQzNzk3YTJkNjQ1MSAxMDA2NDQNCj4+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4+
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9hbGRlYmFyYW5fcHB0
LmMNCj4+Pj4gQEAgLTE5MTksNiArMTkxOSw4IEBAIHN0YXRpYyBpbnQgYWxkZWJhcmFuX21vZGUy
X3Jlc2V0KHN0cnVjdA0KPj4+IHNtdV9jb250ZXh0ICpzbXUpDQo+Pj4+ICAgIG91dDoNCj4+Pj4g
ICAgCW11dGV4X3VubG9jaygmc211LT5tZXNzYWdlX2xvY2spOw0KPj4+Pg0KPj4+PiArCUJVR19P
Tih1bmxpa2VseShzbXUtPnNtdV9kZWJ1Z19tb2RlKSAmJiByZXQpOw0KPj4+PiArDQo+Pj4gVGhp
cyBodW5rIGNhbiBiZSBza2lwcGVkIHdoaWxlIHN1Ym1pdHRpbmcuIElmIHRoaXMgZmFpbHMsIEdQ
VSByZXNldA0KPj4+IHdpbGwgZmFpbCBhbmQgYW1kZ3B1IHdvbid0IGNvbnRpbnVlLg0KPj4NCj4+
IE9rLCB3ZSBkb24ndCBoYW5kbGUgc3VjaCBjYXNlcy4NCj4+DQo+Pj4NCj4+Pj4gICAgCXJldHVy
biByZXQ7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9zbXVfY21uLmMNCj4+Pj4gaW5kZXggMDQ4Y2ExNjczODYzLi45YmUwMDVlYjQyNDEgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5jDQo+Pj4+IEBA
IC0zNDksMTUgKzM0OSwyMSBAQCBpbnQgc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShz
dHJ1Y3QNCj4+PiBzbXVfY29udGV4dCAqc211LA0KPj4+PiAgICAJCV9fc211X2Ntbl9yZWdfcHJp
bnRfZXJyb3Ioc211LCByZWcsIGluZGV4LCBwYXJhbSwgbXNnKTsNCj4+Pj4gICAgCQlnb3RvIE91
dDsNCj4+Pj4gICAgCX0NCj4+Pj4gKw0KPj4+PiAgICAJX19zbXVfY21uX3NlbmRfbXNnKHNtdSwg
KHVpbnQxNl90KSBpbmRleCwgcGFyYW0pOw0KPj4+PiAgICAJcmVnID0gX19zbXVfY21uX3BvbGxf
c3RhdChzbXUpOw0KPj4+PiAgICAJcmVzID0gX19zbXVfY21uX3JlZzJlcnJubyhzbXUsIHJlZyk7
DQo+Pj4+IC0JaWYgKHJlcyAhPSAwKQ0KPj4+PiArCWlmIChyZXMgIT0gMCkgew0KPj4+PiAgICAJ
CV9fc211X2Ntbl9yZWdfcHJpbnRfZXJyb3Ioc211LCByZWcsIGluZGV4LCBwYXJhbSwgbXNnKTsN
Cj4+Pj4gKwkJZ290byBPdXQ7DQo+Pj4NCj4+PiBOZXh0IHN0ZXAgaXMgcmVhZGluZyBzbXUgcGFy
YW1ldGVyIHJlZ2lzdGVyIHdoaWNoIGlzIGhhcm1sZXNzIGFzDQo+Pj4gcmVhZGluZyByZXNwb25z
ZSByZWdpc3RlciBhbmQgaXQncyBub3QgY2xlYXIgb24gcmVhZC4gVGhpcyBnb3RvIGFsc28gbWF5
IGJlDQo+c2tpcHBlZC4NCj4+DQo+PiBJIGp1c3QgdGhpbmsgdGhhdCBkb2VzIHNvbWUgZXh0cmEg
d29yay4gV2UgZG9u4oCZdCB3YW50IHRvIHJlYWQgcmVzcG9uc2UgcmVnaXN0ZXIuDQo+PiBUaGlz
IGdvdG8gbWFrZXMgZXJyb3IgaGFuZGxpbmcgbW9yZSBjbGVhci4NCj4+DQo+DQo+VGhpcyBjaGFu
Z2UgYWZmZWN0cyBub24tZGVidWcgbW9kZSBhbHNvLiBJZiB0aGluZ3MgYXJlIG5vcm1hbCwgZXJy
b3IgaGFuZGxpbmcgaXMNCj5zdXBwb3NlZCB0byBiZSBkb25lIGJ5IHRoZSBjYWxsZXIgYmFzZWQg
b24gdGhlIEZXIHJlc3BvbnNlIGFuZC9vciByZXR1cm4NCj5wYXJhbWV0ZXIgdmFsdWUsIGlmIHRo
ZXJlIGlzIGFueS4gc211X2RlYnVnX21vZGUgc2hvdWxkbid0IGNoYW5nZSB0aGF0Lg0KDQpUaGFu
a3MsIEkgZ290IGl0Lg0KDQo+VGhhbmtzLA0KPkxpam8NCj4NCj4+IFJlZ2FyZHMsDQo+PiBMYW5n
DQo+Pg0KPj4+IFRoYW5rcywNCj4+PiBMaWpvDQo+Pj4NCj4+Pj4gKwl9DQo+Pj4+ICAgIAlpZiAo
cmVhZF9hcmcpDQo+Pj4+ICAgIAkJc211X2Ntbl9yZWFkX2FyZyhzbXUsIHJlYWRfYXJnKTsNCj4+
Pj4gICAgT3V0Og0KPj4+PiAgICAJbXV0ZXhfdW5sb2NrKCZzbXUtPm1lc3NhZ2VfbG9jayk7DQo+
Pj4+ICsNCj4+Pj4gKwlCVUdfT04odW5saWtlbHkoc211LT5zbXVfZGVidWdfbW9kZSkgJiYgcmVz
KTsNCj4+Pj4gKw0KPj4+PiAgICAJcmV0dXJuIHJlczsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+Pg0K
