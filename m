Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B23DC79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 06:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ADFB10F303;
	Thu, 10 Sep 2026 06:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kVi0eMBL";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E15510F30A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVjOC1LSLkvs9Veyw/0A5gJ2GImZ1GEn87+doZ3+c+ITElLYFceGLT78EvrFr0Mzg1I7t7u1zBrSDMHBW61wTwOcdO/OuLwAYD5SwkH4+hyxynkRCTMIAMrQlBaCr8fewRDtjoPaDWcIirDGuqjrQ5tCemvegHgqbXumvNQvNU0kjxDOr/aPdzfpPzVbgeMEDHfqnxs9YLLlmxYUfdJw4BEEzjm180LYL0zy2aS2WaqTOndpMAZxpl9SVDKjd/1SgynJ0ds4I3s9DJag1J6uv8j89wWJTzgpmlvUHYk3NcfiWp2AlOypzZ/mjPG+JLTtbWwEiir5VNS2wTTxebnu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEADpC/F29vshPjvFTPjPC3QtvcShQUL7a9DcV1NMvI=;
 b=v7Vx8FcpHyyMWrcwQ3ESGpkQhJ/AQl0VzDheGiMDvjkkLphNdA/HswymJudZ3uo2tnmbOy3aXU5IxDd5libR1quaLtOR2mB4HxmPRoKzbWpE134UcfnnOjdiHT2hiN6sspgsl8xk550EEq9SWO7FMVuGwZIlctPkh7sLF26X/oU6kC5VLEm/KwE4so3NKM7JcMaKnTC/LKcRN/FMp0V7TTMgQr6YGsgwx2XyixJTje3C7jqoR8EEAP1asxHTFqOHyhP5gmAXFbchwWi5jSeNBy69/qCLqYZ6f6cleKvYjvkkZReSuV2cqZi5MF1CgSYdTcP+mFXzd1PtuCi5Q9KVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEADpC/F29vshPjvFTPjPC3QtvcShQUL7a9DcV1NMvI=;
 b=kVi0eMBL/dhispPwzzD/dxLIK4GNjat6kecQLnQksealCzpqSfH9w9yb8Cira6vVw8NnmWanPqgJn6djvAA4yg5myB9ef2ZXO9EPXGspFX1+l5A2a/sOM0kIYLwIrQh9GQYWYUzvJuyufNhB5+FwJCo8GqNwsfshOp3cdPV13H4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 06:00:56 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 06:00:56 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: reserve root PD fence slots for userq
 eviction-fence rearm
Thread-Topic: [PATCH 2/2] drm/amdgpu: reserve root PD fence slots for userq
 eviction-fence rearm
Thread-Index: AQHdQL33IYDDXKXz1U+i5aaITaHftrbHUVCg
Date: Thu, 10 Sep 2026 06:00:56 +0000
Message-ID: <DS7PR12MB6005EDFFCE23B079AA3540C9FBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260910004701.94511-1-vitaly.prosyak@amd.com>
 <20260910004701.94511-2-vitaly.prosyak@amd.com>
In-Reply-To: <20260910004701.94511-2-vitaly.prosyak@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-10T05:58:27.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB7245:EE_
x-ms-office365-filtering-correlation-id: 0f076252-b41f-452b-3cdf-08df0f00e16d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: F4SMOXVM/MNZK+m7JqVDxgbSXNAPq4NcwgsgXaHsatDQ2QZDbZ/rsUBZegXt8VzXSCzUN4Ewqcr30+g57hnO7GdaMN4RfsQq6ZrYskKIs6rs9CiysmPy9MISyXq5gUE3e99RG2Cf9pFD4O/0qXJKnMbXWwU63QdlR7nxkro2gnPN33G7VDVQwyW2MnK2QePOtPvNsH/UioiKnmiIEkHlSu9dZkieilxmcNVl6p2fu1i0vU611AiNGIhQV9Ec+VnZR9Q2hkowMSXFUQ/RVjS6NX3J2NKTyzIRK+YUmza6FUTuY/8hsN9We6tZflA4L8fPhS67zcSXb7FhXE69ncAb6OgZzFr/ilyAHj3kuYViGp9DvcfIV2V3xLODljYsEK9KwjMtVDtHX/el6TmKBFS7JRPKjyrXcZMT5g//JepbHskFCoec/5bkqFQheZyMi7brN1jhCqALpB+bg6pCc6VaEf0qnp72uM6V0GGYx0kETlx8QjV5hk01TrjdGxSv5j9d2TXILmLeWyDWHZivNg5yXCnNh7q77d0jyZOMswdIRCVEWtxM6j12ukUwvtYR/+PopL6zAOXzyO3WPBOBoj+OeNCWQsDlmBBOtraptt68QzY6UeZab2tsRcP2O+189Ji/t6XAIt1coj2oHSDHZvqQ5e1WUXi4r1YDvSRL5W/6n1yp803qq8EVX0cQXzd7OWSIRGbygLjk00zg6+2a1mLgDL1TvMoXuPcmUpIBlsVUw5I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzlYVW5oRnA4dWhXNDBObG1tL2o5aWEwSWhsSTRZcUpML21Pa25PbzBXZkpP?=
 =?utf-8?B?cVJPMFVPdjFOdXdRUmhFTUo4SHhQalNVdU9WTWxCUm5aaCttR2RkTXh4QmMv?=
 =?utf-8?B?cDF6dWltT2N2ZWU2akhZTkdhZk44cmx6TFRrbnBScDRHYndVbXduakZRWXJL?=
 =?utf-8?B?WmhnSDQ5ZGU2WCtpYndYeVpZaGdHaFd3MDFySjV2Ykk5eXo0bWh6VlJUVjlo?=
 =?utf-8?B?ejIyT3dpMHQ0emZ2SzFZOXRwbGdsOGxuOGxCT25xcnFkRFFQb0h5aVA2TmZP?=
 =?utf-8?B?ZGxvanBSK1dFbmlBNkovanh4b3FLaytYNC9NMk1lai9CWTZ6YWFERFNUWXhE?=
 =?utf-8?B?NzVCUjJZT1huTWF6UVpHZnkxNnBLM3dPWlRxNEdiRzdlOTdTUHY4TzU4Mm9x?=
 =?utf-8?B?ZnVUcStQVU5GUVJYUTZtOFEyME9RbzdyUzBTT1AvczZaUzZ2by84ZnhjWEJh?=
 =?utf-8?B?SHNvSkpjQVpkVE5wYzdKL2tWVVVDc1cwMDFFSEVGT2JoSmVpYkZOYmlzU3Jn?=
 =?utf-8?B?T01MdlY4UG9YeU5MTFBuc2k3U0x2QjREQnJDTisxUkNteUczOXZrY0xnL1dn?=
 =?utf-8?B?ajVNbTNuV0hueDIxcWxJMjFld2FFZDRXNGRuOUQ2ZmRQZEJ6dGM0NGdQOWpq?=
 =?utf-8?B?dnFleGhlZ2k0Z1FVV2UxTDNvQWVoU3FGQ3RuNXFXSDFEeXMyTnhpZ1RNaG13?=
 =?utf-8?B?UThyMEFrS0g4aDVoSlN4MndIVnd0Z09MZ0tHTlMwcWduN0R6Y3Zla0ZjSlo2?=
 =?utf-8?B?ZHAzVTBEQ1NUMlhlV2s0SmNSQnVvUC9zU2F2VjFZRzYvZzJ3dXRVai95UnIz?=
 =?utf-8?B?T0pEaWl2RXNydXlsaUFMS1Q1cmc3K0pHck5YN1NXaUVSNVA2ZzhUMmdkU2Ju?=
 =?utf-8?B?M3hGYjVOaDlSUzUvem5xKzl4UmhrNUVwTGxPbHBTS1F4ZFVkMll0THdUUGZM?=
 =?utf-8?B?c2ZFZHBKdFFTa3JycHZsVmdhU3g5STNzZGtmU3R2a1htdkQ3dG8wNDVtK1FH?=
 =?utf-8?B?YzNSTUlGQ3FKTVU1aVhscFF6ZHdEVTNpUWU3U3AxRFFOMVBXRUVCMlNjZjZv?=
 =?utf-8?B?Tk1seVI5cGpXdHQxU21la3VlWExCVzQ1TzQ0VEZtdDJ3Z3pRa0dMWDhyNUtv?=
 =?utf-8?B?Q1BScU9pV2lnMVFxdnpWNWhoMkFXQWIreVFBYTlJRkNlYVQ1UVkxWERQN002?=
 =?utf-8?B?cUdpUHM1RUh3THNQbFVSMTU2M1RndkRMN2tKMjI4dFpqU1JYR1l5dEpkdGRq?=
 =?utf-8?B?enJtTklzUkVtRHR2TlN6aGljcDU2NWx6N2Y2eFZQNjlUS3BNc2duRGZNb0Fm?=
 =?utf-8?B?aGFuc1JsanNIZkxDY0dXV3RoWG5XdG81UmduSC83a0Uzc2xuajFveDdjakYz?=
 =?utf-8?B?aXBCZ0lTQ2NhUzcvWkgwY25FRXdQbGFkZzhXL3ZwTmZkQlYxUGkreVQwOWhz?=
 =?utf-8?B?TjYvR3BKTnBYNzJsd1NZNWljd2l6ZjhXeVc5aEt1VFBJQzBpVkNkKzZtOWt6?=
 =?utf-8?B?WEtTclpCWlJCMGNJbkxybUQ2NHpVVHNqaEFmWmhBdmZQdmY5Z0h3M2MzZC9Z?=
 =?utf-8?B?N2djcCs3VWlNSjF2alJFUHJ2RzN3WjZsWEZzWnNUc2xoNmliL0ZFOWFGRkRy?=
 =?utf-8?B?Z0dpV3FtVHAxaTFjUStnTll1YSt2WjVVYXF2SUFyUkZ0MFdjcUdLTWxkWXBH?=
 =?utf-8?B?NmIxSWV0RXk4UE9kYzYyaXJOWmpUaGp0d1FEWWJDcFZoVVJTdHVNVzgvTTEy?=
 =?utf-8?B?bEZCZ0xPUnliMFJ0R0RXeWJxSXZpeTFZNjZhRFZRT3dreHh3eVhZUjQrL3U0?=
 =?utf-8?B?SlZXcExHNnMxb1dHWnBKbGc1emhJZ2x6QkJvMTZXS2VsSXNqN0tyRG93a3Iy?=
 =?utf-8?B?dWs3WTFpNi9kYzBXMzNNMnJNQ3FSR2FqRHZMdkxXd3FGS2hqTHZBVGZIVVQz?=
 =?utf-8?B?YktVTXQ4bkJXRlREcWtyZkZGZmJ1YS8vY1l1cFFEbXBTUktuVGhNTmtPVVRL?=
 =?utf-8?B?NzlwY05BY1BFQnBVWWV6ejRhVVJVQ1RPeVRlaTVUOFY3WmlNOC9HdUhUWFFa?=
 =?utf-8?B?blVTZkVESTV1SHNFOUFZSkVjNHV3SVZwcmhpc01qeWx1N0RaMVdyQXJCOUtW?=
 =?utf-8?B?TVIzSzZMbzJYRUs3cEVNZWJ0eXkrRXRYUGkrclBrbzdlNTErNmZ4U01CbC9X?=
 =?utf-8?B?UnJlV1Rocm5pUGl6S0NjWDF3VnpkSGh0R09LUVg5eFF1UUhTOEQyWlNId3dl?=
 =?utf-8?B?MFNBVEw3SE4rSml5RkpEMGZIVG5yc2cyOGlVRjl6MVA4M3NTYjYxRTVwa1F6?=
 =?utf-8?Q?3zyBObLhbjdeE6PVlX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f076252-b41f-452b-3cdf-08df0f00e16d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 06:00:56.5829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLesrf3W54LzoZ9wshgxu/xNkXs7BwngPCWWX1Iheb6vg4vF9Q1QCkyszQ72T3Xp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+IHZpdGFseS5wcm9zeWFrQGFtZC5jb20NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAxMCwgMjAyNiA4OjQ2IEFNDQo+IFRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogUHJvc3lhaywgVml0YWx5IDxWaXRhbHkuUHJvc3lh
a0BhbWQuY29tPjsgTGlhbmcsIFByaWtlDQo+IDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgS2hhdHJp
LCBTdW5pbCA8U3VuaWwuS2hhdHJpQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiByZXNl
cnZlIHJvb3QgUEQgZmVuY2Ugc2xvdHMgZm9yIHVzZXJxIGV2aWN0aW9uLQ0KPiBmZW5jZSByZWFy
bQ0KPg0KPiBGcm9tOiBWaXRhbHkgUHJvc3lhayA8dml0YWx5LnByb3N5YWtAYW1kLmNvbT4NCj4N
Cj4gUm9vdCBjYXVzZToNCj4gLSBJbiB1c2VycSByZXN0b3JlL3JlYXJtLCByb290IFBEIHdhcyBs
b2NrZWQgd2l0aCBhbWRncHVfdm1fbG9ja19wZCh2bSwgJmV4ZWMsDQo+IDEpLg0KPiAtIExhdGVy
IGluIHRoZSBzYW1lIGRybV9leGVjIGNvbnRleHQsIGFtZGdwdV9ldmZfbWdyX3JlYXJtKCkgYXR0
YWNoZXMNCj4gICBCT09LS0VFUCBldmljdGlvbiBmZW5jZXMgdG8gYWxsIGxvY2tlZCBCT3MuDQo+
IC0gSW4gdGhpcyBmbG93LCByb290IFBEIHZhbGlkYXRpb24vdXBkYXRlIGNhbiBhbHNvIGNvbnN1
bWUgbW92ZS1mZW5jZSBzbG90cywNCj4gICBzbyByZXNlcnZpbmcgb25seSArMSBhdCBQRCBsb2Nr
IHRpbWUgaXMgbm90IHN1ZmZpY2llbnQgdW5kZXIgc3RyZXNzLg0KPg0KPiBGaXg6DQo+IC0gUmVz
ZXJ2ZSBjYWxsZXItc2lkZSBzbG90cyBhdCB0aGUgYWN0dWFsIHNvdXJjZSBieSBzd2l0Y2hpbmcg
dG86DQo+ICAgYW1kZ3B1X3ZtX2xvY2tfcGQodm0sICZleGVjLCBUVE1fTlVNX01PVkVfRkVOQ0VT
ICsgMSkNCj4NCj4gVGhpcyBrZWVwcyByZXNlcnZhdGlvbiBwb2xpY3kgaW4gY2FsbGVycywgY29u
c2lzdGVudCB3aXRoIENocmlzdGlhbiBLb25pZyBmZWVkYmFjaw0KPiBhbmQgd2l0aCBhbWRncHVf
Z2VtX29iamVjdF9vcGVuKCkgd2hlcmUgY2FsbGVycyByZXNlcnZlDQo+IFRUTV9OVU1fTU9WRV9G
RU5DRVMgKyAxIGJlZm9yZSBhdHRhY2hpbmcgZXZpY3Rpb24gZmVuY2VzLg0KPg0KPiBDcmVkaXQ6
DQo+IC0gQ2hyaXN0aWFuIEtvbmlnOiBjb25maXJtZWQgZmVuY2Utc2xvdCByZXNlcnZhdGlvbiBi
ZWxvbmdzIHRvIGNhbGxlcnMgYW5kDQo+ICAgYXNrZWQgdG8gaW52ZXN0aWdhdGUgd2h5ICsxIHdh
cyBzdGlsbCBub3QgZW5vdWdoLg0KPiAtIFByaWtlIExpYW5nOiBjbGFyaWZpZWQgdGhlIGluaXRp
YWwgdmFyaWFudCB3YXMgd29ya2Fyb3VuZC1vbmx5IGFuZA0KPiAgIGRldmVsb3BlZCB0aGF0IGlu
aXRpYWwgdmVyc2lvbiBpbmRlcGVuZGVudGx5Lg0KPg0KPiBDYzogUHJpa2UgTGlhbmcgPHByaWtl
LmxpYW5nQGFtZC5jb20+DQo+IENjOiBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29t
Pg0KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBWaXRhbHkgUHJvc3lhayA8dml0YWx5LnByb3N5YWtAYW1kLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDYgKysrKystDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IGluZGV4IDM5MzhmN2I4
ZWM0Yi4uMTJmYmZmMDJlNGI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdXNlcnEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXNlcnEuYw0KPiBAQCAtMTA0Myw3ICsxMDQzLDExIEBAIGFtZGdwdV91c2VycV92bV92
YWxpZGF0ZV9hbmRfcmVzdG9yZV9xdWV1ZShzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJxX21nciAqdXFf
bWdyKQ0KPiAgcmV0cnlfbG9jazoNCj4gICAgICAgZHJtX2V4ZWNfaW5pdCgmZXhlYywgRFJNX0VY
RUNfSUdOT1JFX0RVUExJQ0FURVMsIDApOw0KPiAgICAgICBkcm1fZXhlY191bnRpbF9hbGxfbG9j
a2VkKCZleGVjKSB7DQo+IC0gICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X3ZtX2xvY2tfcGQodm0s
ICZleGVjLCAxKTsNCj4gKyAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAqIFJlYXJt
IGFkZHMgb25lIEJPT0tLRUVQIGZlbmNlIGFuZCB2YWxpZGF0aW9uIG1heSBxdWV1ZQ0KPiBtb3Zl
IGZlbmNlcw0KPiArICAgICAgICAgICAgICAqIG9uIHRoZSByb290IFBEIEJPLCBzbyByZXNlcnZl
IGNhbGxlci1zaWRlIHNsb3RzIGFjY29yZGluZ2x5Lg0KPiArICAgICAgICAgICAgICAqLw0KPiAr
ICAgICAgICAgICAgIHJldCA9IGFtZGdwdV92bV9sb2NrX3BkKHZtLCAmZXhlYywgVFRNX05VTV9N
T1ZFX0ZFTkNFUw0KPiArIDEpOw0KDQpJSVJDLCB0aGUgUEQgcmVzZXJ2YXRpb24gZmVuY2Ugc2xv
dHMgaGFkIGJlZW4gY29ycmVjdGVkIGEgd2hpbGUgYWdvIG9uIHRoZSBkcm0tbmV4dCwgY291bGQg
eW91IHBsZWFzZSBmdXJ0aGVyIGNoZWNrIG9uIHRoZSBsYXRlc3QgZHJtLW5leHQgYnJhbmNoPw0K
DQo+ICAgICAgICAgICAgICAgZHJtX2V4ZWNfcmV0cnlfb25fY29udGVudGlvbigmZXhlYyk7DQo+
ICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KHJldCkpDQo+ICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIHVubG9ja19hbGw7DQo+IC0tDQo+IDIuNTQuMA0KDQo=
