Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E55C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 22:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7679510E073;
	Thu, 10 Aug 2023 22:25:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED32C10E073
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 22:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRKu1E2U40k5SwkXGkH2UdiijZNR6+iQ1zQRFrcJObFRQJ4iFFpAADHSgmouwC2tVYILMAZVof4rsxBxzmRpfcBnTtXGtpV0FnvKlMahoFMAEmB6ods2+lM1WpwpS1RxlIPIHnLs14YX2+YZi20TEN+6CV7yj39LrcMD5GUuaL4xNu8fsGTL1sxZ3yerJYOkDIOgHEP7aNCLqW4aD/wIu2ij7Arn915wU6iwrgMMXqWlU0MT4OmYKxxZy4yH8voKeNBgYG51wxXTKuzmD5a66eYcjNnVTLv3TSCnocYu2qzk8nvbvOd/Fr4iNGQjycQv6Kn38tGWIgKsRusm5g1Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=535px8T8qhSAhEAeSuTjpDXxxxdt4louyv6l2D6yhvs=;
 b=hJ7CKLSJ9DYK0fQu80gxGWpRlKX48wUod1KlwbwBPgO5Ye9nqnQfZ5+hKmc/n3CNi5sCa6+IoL/4uAAmd5oksu7xZNaxQQArfBBYevzOlEyZcHqbL/eKg8COtT/LJWBMoBFmszFp/FU3eBBvgZ3/PVdOqjpvw5jZAE5mZmhBOaU+X7Lecv1KpzXI15UG73guy11nM65XJuWcFmjefJXFGm88TpRclgBktsQQi5dRz3oqWiQHY3GekCrndte6igruuG4FXJ+NvhdfVr/8ZghzHYYGlL5/ZFrF9hyRhmDEbf71XK3EVO3Okfr+VzBVfKxl3vbNdEJ4aEoazdCl9qwefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=535px8T8qhSAhEAeSuTjpDXxxxdt4louyv6l2D6yhvs=;
 b=WS732ULN+GJNYU3N2ndG2iZ2ow8bSbcxmWabnNd5TiGgvsKAeYfk+QvpWRKjBlniwrvIhX+FK91948SmrLrNkju/eWB/Eh5yqk5oWCIa3rS/SaHKOKoJtJRXTOQYZ65Ea5TwIjQkgv3PAgXGwTXZhSxHC77+uc/Oe2U1Xdokfgg=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 22:25:28 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 22:25:28 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Thread-Topic: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Thread-Index: AQHZy8v6ll+6TSeb/k+VOZbrWqFnv6/kBGsAgAAFYQCAAAiNgIAAAQUAgAAAM0A=
Date: Thu, 10 Aug 2023 22:25:28 +0000
Message-ID: <CY8PR12MB7435457A27D5FADDB5B7D4578513A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
 <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a6f589e3-4023-31eb-6df9-1118f48b39ed@amd.com>
 <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
In-Reply-To: <aa5536b7-822f-3656-443f-46ac415659bb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6f374a03-bdb0-4e06-94fc-524bea836499;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-10T21:57:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB7823:EE_
x-ms-office365-filtering-correlation-id: beaa4c4b-3e62-48a0-ef67-08db99f0b351
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBbOiRsiFr7VBqa/Co6WntZGrHVjvCFwGBMXjCA6MFtIDvVDfIL5nkPpYVjqlBuK5IZwB6ZrS5jsqVG5Q79tAoslZgYlZF0IRLeGy0FjfC/c6ou5OkfBw9ISoXnRmuQUv9zzW/AL32pW58q/tdaCQANOkLml1c8SaZ8eFSOhX9WPUaiYQmSmqhK3YffyiyCkUAr/+35vQutatUqbBDj9VmaCsGtRpqVwwS/y/6GI7aGt/ppvpFlM62hZ/2xeosy79OK+TGzhAcyJ9XtGpyaNBA705e33cNAKgXwnhNTCD+hxCItCdzvzFwJgWnlWWCJGaSkzIjUqpPfoDxVx6aGts4LgB7ysmPTrUnoJ7pWRZwtWmfLU62mI3nsBxsnp7e9kozb0YwCwIQopm/wk0OfkPGjAvOF8e0bfgZMhpN9iDCj4CgTNUo0nvuC8rRnKP5d0wOElfX16xDcmbAIRXQ6L81I/NACcd5Wj07QNl9JHybjjurlFP+9vaJysqUofmA0JqAslkZ9Hmv/k1s+WklnXTX9ibdOY9QKiG5kmjarDn/2DKJJTD0jcsAI1ENsbRMHcbhYk1ODmBry+qtAz9ULOBgSOOHMxlOoWCTb+GFaGK2r0gxkx45tIJ7OpqFyTQuWA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(396003)(136003)(39860400002)(346002)(186006)(451199021)(1800799006)(86362001)(5660300002)(110136005)(38100700002)(76116006)(66556008)(64756008)(66946007)(66476007)(66446008)(38070700005)(52536014)(8676002)(83380400001)(41300700001)(478600001)(8936002)(316002)(2906002)(71200400001)(55016003)(122000001)(7696005)(33656002)(9686003)(26005)(6506007)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjQ0Q09ITzlmMlBLdWh4eUZlMWxoUmkzWHArc0xaY0Q1aXJFQkhPdWJlV0hI?=
 =?utf-8?B?bUVWU284NHdMdVRSb2lMdWp4UVJrTmRXTmtmVlcxMHAyeU1xc2NJTnY5Q2E5?=
 =?utf-8?B?bzA4U2x6RURQdGVqYWNuWE5sdUl4WTN0cGhucWphdEl4MTYyOTBPdVE2elVL?=
 =?utf-8?B?dnRRQXFScVFaYWdXK0tDcnhlM0JMcVIrZ0lPOUZDemRUd3AveDFkM0tTcDVz?=
 =?utf-8?B?akhXQWFBTGJHczhjU25kcUNDbDkyaEJveGtqYlNoQlRuZXdhUFdkeXphY09h?=
 =?utf-8?B?aXAxVk9XU2t5cldWWUNENjVKREUzTkRqNUQ4MFh3eUhMWGtBVFg5SVpGTUdM?=
 =?utf-8?B?MTdMVXVzNmNvVXFPeWRBSUJPZmZ0RFJYTkdleHRuZDhQUG5VWWhtWjVCYVlP?=
 =?utf-8?B?MTIvMmZVWHdoMm45VDVzcWZlRHQvcFR3YksxbG4zcWFCU2hFazFDMjJTVkox?=
 =?utf-8?B?VzVHSkhXSU8zY0VpMW0xY2VSM09YYjBucHJ0c2JwVzNZdEVpUHp3a3lObHJ3?=
 =?utf-8?B?OFlrVERhZDJXY015Q3BYRHArNlF6VlZ2VW5rcmRUYmJRWjBaVzg0N0xYUGRs?=
 =?utf-8?B?cWVLV1RsNWF1N1U4cXB1SEllRXgySHhZM0xhaGdJRWJvK1JsMlplcmw2bHVr?=
 =?utf-8?B?eWh3UTM1eEttdkpEZ2hwamt3d29sanpDQWQ1YndMYzFabkQrNnFSSEw5Nk9X?=
 =?utf-8?B?aCs2MHI0RlB4YjE3a3FMZk8xN3N0Q1ZWeEFIZ0N0cWx3ajN0dTJPaUZDRHc0?=
 =?utf-8?B?MzFQUnZsZWxhOWIxSXJibStWS290L3kxeEgxRnhjNzc2ODZyOEpLU0d0ZHY2?=
 =?utf-8?B?K3U0YnNkWkE3ZGd2ZXV2c3JBd25zc3NuME10QWJJb0pJWDd2WEx3YnMwYjF0?=
 =?utf-8?B?YWZCVWE4YVNkcitRSFdsMWU0VEtLeVBMeGpYUGlicVorbng3WGZIbGpVUWI2?=
 =?utf-8?B?RWl6Mk0xWUZvT0t4dGg2VE9Qa21VVkxHT29hWmNYUFltV3VPdlhtREgyb01M?=
 =?utf-8?B?cWplbyszeXp3cWpYK0FINXZ1Y0ZRbDNCWmNWc2xNTDE0bW5INFBUd2hXaGw5?=
 =?utf-8?B?dE1pUVE4b2NTU0J5YXFPdndxdTByek94bDAvZ2FmRlU1WWhuUStwNzBoZkls?=
 =?utf-8?B?bE44TW1WaHhrS2lMb3A2VFBma2ZDQi9DdzliaVJ0L2V6NkVwbjhKQVRnckdM?=
 =?utf-8?B?dFZHbkZKbmgvbVlvUFhraDNTTjdVa2gxTUFET2pLVjIzMmVJOURadXdJeWJU?=
 =?utf-8?B?WTlsdlp3cld2ZDBtQytvNW9oWml4N3BTVS9LdXdNaVdCeUs1emxPZUd5eUhi?=
 =?utf-8?B?cEZ2T3h4Qno1RFJPZjFJWnhSVkdPZkxJSmhudGV0VkxRekl2bzZKV2xZemND?=
 =?utf-8?B?cGpidUZGZDlMS2s2elN1T1djMHFOelROVjcwSU42L1lUc0VjY2xUR0NwMklt?=
 =?utf-8?B?SWpTZWtnTlJlQWp3VTB5QTRsKzY5alJNQWt2U2FMUTlURC9rQkxldTE5Tzl0?=
 =?utf-8?B?QkcwdE96M1NPNnRla3pMWnF0Sm9ERFVPUUR0a2JFcnhNYjRXeDBrL3R2YVl2?=
 =?utf-8?B?SHBvL09ac2pua3AzMCszaWZZMCtQTmtueGFUS2IySlg5K2dGaGVwNTdYYldj?=
 =?utf-8?B?RUVKVXZjWnI1b1h5S0MvWlNoTkhyYjhLY0EvbGhnbzE4bDVlMGZDTzFkdm8w?=
 =?utf-8?B?U00wVDZqUE96bVVKdWtVdnFPbHVWUzBWUjc0ZlllZ1dvVHI1bkU1QzFJaXFO?=
 =?utf-8?B?Nmx0SnVPQjU2YXY5RlNKSHRQdjRVREZsNGVQcS9QTWVHbUFqRGhnK3YrUE5w?=
 =?utf-8?B?REFVM01aa1FOOFdTNk9rQ3RoQnFMS2ZtendhYVgwUUU3b3Q3K0lkVTdLMkc1?=
 =?utf-8?B?bXoyb042ZFRXTHpXdjNNdHF5MHUvVGRvaDgzVGkvUlg1SFkveVJkRzZmVzBh?=
 =?utf-8?B?bWJybWg5Z3plSExqaWtZZk4xd2ZxcW9FK280OFpabWNXUHlJUW51cGc3OEdI?=
 =?utf-8?B?Nmp5RmllS0tjeVhJTEMwdlp5SUV1OHlXRm1nTTA1cE5SQm5LbEhHMmFRRDZF?=
 =?utf-8?B?SHlvZUdoSVg4T2VTUmhXbmZHdGF3enFZMDMvd3ZwckV5ZDFmbmJ1c2N6cTdy?=
 =?utf-8?Q?MQZs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaa4c4b-3e62-48a0-ef67-08db99f0b351
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 22:25:28.2661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PP8fneo4EgU41uTcb/rLVLDeRojqbaqzvB7LcwdDP0gVn/8dA2YMFL/HDvFeJRI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
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

W1B1YmxpY10NCg0KWWVhaCB0aGlzIGlzIGEgcmVjZW50IGJ1ZyBzbyB0aGlzIHdvcmthcm91bmQg
aXMgbmV3LiAgTW9yZSByaWdvcm91cyB0ZXN0cyByZXZlYWxlZCB0aGlzIGlzIHByb2JhYmx5IGEg
bWlzcyBvbiB0aGUgRlcgc2lkZS4gIFdlIGV4cGxpY2l0bHkgcmVxdWVzdGVkIFVOTUFQX1FVRVVF
UyB1bmNvbmRpdGlvbmFsbHkgaW52YWxpZGF0ZSB3YXRjaCBjb250cm9scyBkdXJpbmcgdGhlIGJl
Z2lubmluZyBvZiBkZXNpZ24gdG8gcHJldmVudCBhbnkgd2F0Y2ggcG9pbnQgcmFjaW5nLg0KDQpO
b3RlIEdGWDExIE1FUyBjYWxscyBhcmUgZGlmZmVyZW50IG9uIHRoZSBzdXJmYWNlIGJ1dCB1bmRl
ciB0aGUgaG9vZCBpdCdzIHRoZSBzYW1lIChyZWdpc3RlcnMgZ2V0IGludmFsaWRhdGVkIG9uIHVu
bWFwIHRoZW4gZ2V0IHVwZGF0ZWQgb24gbWFwLiAgT25seSBkaWZmZXJlbmNlIGl0J3MgYXQgdGhl
IHF1ZXVlIGxldmVsKS4NCg0KSSdtIGZpbmUgd2l0aCB0aGlzIHNvbHV0aW9uIGJ1dCBJIHRoaW5r
IGl0J2QgYmUgZ29vZCB0byBkZXNjcmliZSB0aGlzIGFzIGEgd29ya2Fyb3VuZCBzb21ld2hlcmUg
KGFzIG9wcG9zZWQgdG8gYSBkcml2ZXIgaXNzdWUpIHNvIHRoYXQgZm9sa3MgYXJlbid0IHNjcmF0
Y2hpbmcgdGhlaXIgaGVhZHMgbGF0ZXIgb24gbG9va2luZyBhdCBjb2RlIGZvciBHRlgxMSBhbmQg
dXAgYW5kIHdvbmRlcmluZyB3aHkgd2UgZG9uJ3QgbnVrZSB0aGUgY29udHJvbCBzZXR0aW5nIHdp
dGggdGhlIEtGRCBmb3IgdGhvc2UgZGV2aWNlcy4NCg0KVGhhbmtzLA0KDQpKb24NCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTAsIDIwMjMgNTo1NiBQ
TQ0KPiBUbzogSHVhbmcsIEppbkh1aUVyaWMgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT47IEtp
bSwgSm9uYXRoYW4NCj4gPEpvbmF0aGFuLktpbUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IGFkZHJl
c3Mgd2F0Y2ggY2xlYXJpbmcgYnVnIGZvciBnZnggdjkuNC4yDQo+DQo+IEkgdGhpbmsgSm9uIGlz
IHN1Z2dlc3RpbmcgdGhhdCB0aGUgVU5NQVBfUVVFVUVTIGNvbW1hbmQgc2hvdWxkIGNsZWFyIHRo
ZQ0KPiBhZGRyZXNzIHdhdGNoIHJlZ2lzdGVycy4gUmVxdWVzdGluZyBzdWNoIGEgY2hhbmdlIGZy
b20gdGhlIHRoZSBIV1MgdGVhbQ0KPiBtYXkgdGFrZSBhIGxvbmcgdGltZS4NCj4NCj4gVGhhdCBz
YWlkLCB3aGVuIHdhcyB0aGlzIHdvcmthcm91bmQgaW1wbGVtZW50ZWQgYW5kIHJldmlld2VkPyBE
aWQgSQ0KPiByZXZpZXcgaXQgYXMgcGFydCBvZiBKb24ncyBkZWJ1Z2dlciB1cHN0cmVhbWluZyBw
YXRjaCBzZXJpZXM/IE9yIGRpZA0KPiB0aGlzIGNvbWUgbGF0ZXI/IFRoaXMgcGF0Y2ggb25seSBl
bmFibGVzIHRoZSB3b3JrYXJvdW5kIGZvciB2OS40LjIuDQo+DQo+IFJlZ2FyZHMsDQo+ICAgIEZl
bGl4DQo+DQo+DQo+IE9uIDIwMjMtMDgtMTAgMTc6NTIsIEVyaWMgSHVhbmcgd3JvdGU6DQo+ID4g
VGhlIHByb2JsZW0gaXMgdGhlIHF1ZXVlIGlzIHN1c3BlbmRlZCBiZWZvcmUgY2xlYXJpbmcgYWRk
cmVzcyB3YXRjaA0KPiA+IGNhbGwgaW4gS0ZELCB0aGVyZSBpcyBub3QgcXVldWUgcHJlZW1wdGlv
biBhbmQgcXVldWUgcmVzdW1lIGFmdGVyDQo+ID4gY2xlYXJpbmcgY2FsbCwgYW5kIHRoZSB0ZXN0
IGVuZHMuIFNvIHRoZXJlIGlzIG5vdCBjaGFuY2UgdG8gc2VuZA0KPiA+IE1BUF9QUk9DRVNTIHRv
IEhXUy4gQXQgdGhpcyBwb2ludCBGVyBoYXMgbm90aGluZyB0byBkby4gV2UgaGF2ZQ0KPiA+IHNl
dmVyYWwgdGVzdCBGV3MgZnJvbSBUZWosIG5vbmUgb2YgdGhlbSB3b3Jrcywgc28gSSByZWNhbGxl
ZCB0aGUNCj4gPiBrZXJuZWwgZGVidWcgbG9nIGFuZCBmb3VuZCBvdXQgdGhlIHByb2JsZW0uDQo+
ID4NCj4gPiBHRlgxMSBoYXMgZGlmZmVyZW50IHNjaGVkdWxlciwgd2hlbiBjYWxsaW5nIGNsZWFy
IGFkZHJlc3Mgd2F0Y2gsIEtGRA0KPiA+IGRpcmVjdGx5IHNlbmRzIHRoZSBNRVNfTUlTQ19PUF9T
RVRfU0hBREVSX0RFQlVHR0VSIHRvIE1FUywgaXQNCj4gZG9lc24ndA0KPiA+IGNvbnNpZGVyIGlm
IHRoZSBxdWV1ZSBpcyBzdXNwZW5kZWQuIFNvIEdGWDExIGRvZXNuJ3QgaGF2ZSB0aGlzIGlzc3Vl
Lg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBFcmljDQo+ID4NCj4gPiBPbiAyMDIzLTA4LTEwIDE3
OjI3LCBLaW0sIEpvbmF0aGFuIHdyb3RlOg0KPiA+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0g
R2VuZXJhbF0NCj4gPj4NCj4gPj4gVGhpcyBpcyBhIHN0cmFuZ2Ugc29sdXRpb24gYmVjYXVzZSB0
aGUgTUVDIHNob3VsZCBzZXQgd2F0Y2ggY29udHJvbHMNCj4gPj4gYXMgbm9uLXZhbGlkIGF1dG9t
YXRpY2FsbHkgb24gcXVldWUgcHJlZW1wdGlvbiB0byBhdm9pZCB0aGlzIGtpbmQgb2YNCj4gPj4g
aXNzdWUgaW4gdGhlIGZpcnN0IHBsYWNlIGJ5IGRlc2lnbi4gIE1BUF9QUk9DRVNTIG9uIHJlc3Vt
ZSB3aWxsIHRha2UNCj4gPj4gd2hhdGV2ZXIgdGhlIGRyaXZlciByZXF1ZXN0cy4NCj4gPj4gR0ZY
MTEgaGFzIG5vIGlzc3VlIHdpdGggbGV0dGluZyB0aGUgSFdTIGRvIHRoaXMuDQo+ID4+DQo+ID4+
IEFyZSB3ZSBzdXJlIHdlJ3JlIG5vdCB3b3JraW5nIGFyb3VuZCBzb21lIEhXUyBidWc/DQo+ID4+
DQo+ID4+IFRoYW5rcywNCj4gPj4NCj4gPj4gSm9uDQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMCwgMjAyMyA1OjAzIFBN
DQo+ID4+PiBUbzogSHVhbmcsIEppbkh1aUVyaWMgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT47
IGFtZC0NCj4gPj4+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4+IENjOiBLaW0sIEpv
bmF0aGFuIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4NCj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRrZmQ6IGZpeCBhZGRyZXNzIHdhdGNoIGNsZWFyaW5nIGJ1ZyBmb3INCj4gPj4+IGdm
eCB2OS40LjINCj4gPj4+DQo+ID4+PiBJIHRoaW5rIGFtZGdwdV9hbWRrZmRfZ2NfOV80XzMuYyBu
ZWVkcyBhIHNpbWlsYXIgZml4LiBCdXQgbWF5YmUgYSBiaXQNCj4gPj4+IGRpZmZlcmVudCBiZWNh
dXNlIGl0IG5lZWRzIHRvIHN1cHBvcnQgbXVsdGlwbGUgWENDcy4NCj4gPj4+DQo+ID4+PiBUaGF0
IHNhaWQsIHRoaXMgcGF0Y2ggaXMNCj4gPj4+DQo+ID4+PiBSZXZpZXdlZC1ieTogRmVsaXggS3Vl
aGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IE9uIDIw
MjMtMDgtMTAgMTY6NDcsIEVyaWMgSHVhbmcgd3JvdGU6DQo+ID4+Pj4gS0ZEIGN1cnJlbnRseSBy
ZWxpZXMgb24gTUVDIEZXIHRvIGNsZWFyIHRjcCB3YXRjaCBjb250cm9sDQo+ID4+Pj4gcmVnaXN0
ZXIgYnkgc2VuZGluZyBNQVBfUFJPQ0VTUyBwYWNrZXQgd2l0aCAwIG9mIGZpZWxkDQo+ID4+Pj4g
dGNwX3dhdGNoX2NudGwgdG8gSFdTLCBidXQgaWYgdGhlIHF1ZXVlIGlzIHN1c3BlbmRlZCwgdGhl
DQo+ID4+Pj4gcGFja2V0IHdpbGwgbm90IGJlIHNlbnQgYW5kIHRoZSBwcmV2aW91cyB2YWx1ZSB3
aWxsIGJlDQo+ID4+Pj4gbGVmdCBvbiB0aGUgcmVnaXN0ZXIsIHRoYXQgd2lsbCBhZmZlY3QgdGhl
IGZvbGxvd2luZyBhcHBzLg0KPiA+Pj4+IFNvIHRoZSBzb2x1dGlvbiBpcyB0byBjbGVhciB0aGUg
cmVnaXN0ZXIgYXMgZ2Z4IHY5IGluIEtGRC4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6
IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+
PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2FsZGViYXJhbi5j
IHwgOCArLS0tLS0NCj4gLS0NCj4gPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDcgZGVsZXRpb25zKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hbGRlYmFyYW4uYw0KPiA+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2FsZGViYXJhbi5jDQo+ID4+Pj4g
aW5kZXggZTJmZWQ2ZWRiZGQwLi5hZmYwODMyMWU5NzYgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hbGRlYmFyYW4uYw0KPiA+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYWxkZWJhcmFu
LmMNCj4gPj4+PiBAQCAtMTYzLDEyICsxNjMsNiBAQCBzdGF0aWMgdWludDMyX3QNCj4gPj4+IGtn
ZF9nZnhfYWxkZWJhcmFuX3NldF9hZGRyZXNzX3dhdGNoKA0KPiA+Pj4+ICAgICAgcmV0dXJuIHdh
dGNoX2FkZHJlc3NfY250bDsNCj4gPj4+PiAgICB9DQo+ID4+Pj4NCj4gPj4+PiAtc3RhdGljIHVp
bnQzMl90IGtnZF9nZnhfYWxkZWJhcmFuX2NsZWFyX2FkZHJlc3Nfd2F0Y2goc3RydWN0DQo+ID4+
PiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+Pj4+IC0gdWludDMyX3Qgd2F0Y2hfaWQpDQo+ID4+
Pj4gLXsNCj4gPj4+PiAtICAgcmV0dXJuIDA7DQo+ID4+Pj4gLX0NCj4gPj4+PiAtDQo+ID4+Pj4g
ICAgY29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgYWxkZWJhcmFuX2tmZDJrZ2QgPSB7DQo+ID4+
Pj4gICAgICAucHJvZ3JhbV9zaF9tZW1fc2V0dGluZ3MgPQ0KPiA+Pj4ga2dkX2dmeF92OV9wcm9n
cmFtX3NoX21lbV9zZXR0aW5ncywNCj4gPj4+PiAgICAgIC5zZXRfcGFzaWRfdm1pZF9tYXBwaW5n
ID0ga2dkX2dmeF92OV9zZXRfcGFzaWRfdm1pZF9tYXBwaW5nLA0KPiA+Pj4+IEBAIC0xOTMsNyAr
MTg3LDcgQEAgY29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgYWxkZWJhcmFuX2tmZDJrZ2QgPQ0K
PiB7DQo+ID4+Pj4gICAgICAuc2V0X3dhdmVfbGF1bmNoX3RyYXBfb3ZlcnJpZGUgPQ0KPiA+Pj4g
a2dkX2FsZGViYXJhbl9zZXRfd2F2ZV9sYXVuY2hfdHJhcF9vdmVycmlkZSwNCj4gPj4+PiAgICAg
IC5zZXRfd2F2ZV9sYXVuY2hfbW9kZSA9IGtnZF9hbGRlYmFyYW5fc2V0X3dhdmVfbGF1bmNoX21v
ZGUsDQo+ID4+Pj4gICAgICAuc2V0X2FkZHJlc3Nfd2F0Y2ggPSBrZ2RfZ2Z4X2FsZGViYXJhbl9z
ZXRfYWRkcmVzc193YXRjaCwNCj4gPj4+PiAtICAgLmNsZWFyX2FkZHJlc3Nfd2F0Y2ggPSBrZ2Rf
Z2Z4X2FsZGViYXJhbl9jbGVhcl9hZGRyZXNzX3dhdGNoLA0KPiA+Pj4+ICsgICAuY2xlYXJfYWRk
cmVzc193YXRjaCA9IGtnZF9nZnhfdjlfY2xlYXJfYWRkcmVzc193YXRjaCwNCj4gPj4+PiAgICAg
IC5nZXRfaXFfd2FpdF90aW1lcyA9IGtnZF9nZnhfdjlfZ2V0X2lxX3dhaXRfdGltZXMsDQo+ID4+
Pj4gICAgICAuYnVpbGRfZ3JhY2VfcGVyaW9kX3BhY2tldF9pbmZvID0NCj4gPj4+IGtnZF9nZnhf
djlfYnVpbGRfZ3JhY2VfcGVyaW9kX3BhY2tldF9pbmZvLA0KPiA+Pj4+ICAgICAgLnByb2dyYW1f
dHJhcF9oYW5kbGVyX3NldHRpbmdzID0NCj4gPj4+IGtnZF9nZnhfdjlfcHJvZ3JhbV90cmFwX2hh
bmRsZXJfc2V0dGluZ3MsDQo+ID4NCg==
