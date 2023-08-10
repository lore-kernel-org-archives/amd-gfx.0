Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D32C001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 21:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83D610E60B;
	Thu, 10 Aug 2023 21:27:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17FC110E60B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 21:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxBUhxP+fEIr9Kd9CcQgLmk6JBKPTpFeU2Z0hMLKf3G5zE5Cq9tuApMS+1DEBEpii9u2xJ7IK9W/5PhLrSN3py8eJXT8QiHe9iQrYV3HkCDzvWPNnzabRo09HlaatXFqJ891zyZCLpgN5VW55i9h4Ib6Qi/fmPzTiw40ocDEykpz6MvvS3FqsrzbKh8bWkzYLxz7zo3IcnPI2UjWZiEYA8HACFGX3LhoMqJ7mUcuZGFzY4yNIfUVUD/5wbD8+gx/T/784fYNKuaSwXTZPjIy+t363zhZaXU4IGeIz07PowubH2vHeoyswRuvUhYAtbJMS0fTrUr3j01Kh30QXRKeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KXJKjiGfPtwCtEaW9ySQ5JmAbUo5dtJQATBuQCES28=;
 b=LEa7gCMUgBlUmcW9+dY5u//STFgiw0A0pijppmsRJjfgtgWvI0wyNRM+0U0Zw8SeBZuSrzbglp68y0tTQJ5P6T2RgnXGAqHsiyvvUVkL43j3pohfdQjOGl5I2SZo/G1Dw5aVBevwgDWWcC3oy2en8esuuvDjmNh1ngQy1sS8sXUdrkVFqbppQrlGJ6M1LVIhlYeB2riZU3c0aqUJU2DdaeMDobSfMir3vuiBpiLjO5vRggHNT1+287oK4y/tKIMv5VVbk6UiBGu+ZE0AGdxEm3M95BpEXJP6t5okVYRbzH6xdiLVrDajSdxSopgQ4J1A9Hv61b6Jcy7g2wnTegxiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KXJKjiGfPtwCtEaW9ySQ5JmAbUo5dtJQATBuQCES28=;
 b=5XDO9hv5cRMD1yalkHSj9Q7emWr75wpcjEmE5v4+ctut7ACkKf9bXgTXfFgKh00X5FKAIuI4z/Ph8h4VCMChW/XPM8zGTzvSM+S9ykbVv+jEN3d+C2LwkS1TEfQ/hgJXjdAuHLAm7Ly6lrMJ4DTtXWfCgysdIMvbmig62VY/C3g=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 21:27:41 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 21:27:40 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Huang, JinHuiEric"
 <JinHuiEric.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Thread-Topic: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Thread-Index: AQHZy8v6ll+6TSeb/k+VOZbrWqFnv6/kBGsAgAAFYQA=
Date: Thu, 10 Aug 2023 21:27:39 +0000
Message-ID: <CY8PR12MB743551930E66E2C84AC089688513A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230810204744.195416-1-jinhuieric.huang@amd.com>
 <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
In-Reply-To: <0a20bc13-312c-15b2-ea40-33cce76bb8eb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f10d196-c1fd-473d-a9bb-47566aff3232;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-10T21:21:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM4PR12MB5357:EE_
x-ms-office365-filtering-correlation-id: 9d1a91cc-a079-425c-71d3-08db99e8a00c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQ9YViznvB5Uv4p0ie3hslqN3NLE+nUcIorNCJipai4UFWbmiD2XIMG5/mheApakhigLrvJpEpeXjjyJkTEYUyIOsM1q5rESMk+D/YhtXb64dam3bKGdSdORGPK5pW9UTeQ65KRVqaeMtIthUv0g9tiG9JP98Ms5RTlmQJqvp+mpMusrKcTlWytHJ+5RwxmD/FwBuha2YxheXmZfMl44UHId0Qnso8OrTINgYqHzZYa/+fOah+lf6mA08urDGUGSyyKqtCRNgkPz+KRs1b1/HcN+/i7O9yt8ECXdDESYJCpJ/+BLMhaGu25MKOb+x4uspKf1wEPK7J651hKgBXZaGowZTEO6RS+8QSOdpvjEErqm4PPVG/ukjuOiCgPhREHuLuqIYaKmUVnieF98PuLkO3R37GGuCvssAVOTyqLkukx1HhqbIKQXzhvMrBF6wGDDbLsZk1S3iQjbSJtE8XLm/GuEFGx7YQVBv6TD250kyMa3sXh0ALXEpb3wx7S32Z9/JKaweMmHcKVfSZgc8K9ntTJChDl28aISGpTwtbtoSwHjreKrZfndtDp+fwPxBAd1vfC0azZzyqbYbqwvSuyJH1h6gEXzd+E92Vq+txqEsCm0QDUKSXAw/adgsqVjE0AR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(186006)(1800799006)(38070700005)(33656002)(86362001)(55016003)(6506007)(2906002)(53546011)(8936002)(71200400001)(8676002)(26005)(83380400001)(478600001)(316002)(110136005)(41300700001)(9686003)(7696005)(52536014)(5660300002)(76116006)(66476007)(66556008)(66946007)(66446008)(64756008)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dThzTGdqSzhPelpURjgram1pLzRxVnBrWnBRQk1iY2xlTWx3ekJseDQ3YlQw?=
 =?utf-8?B?U0xqLzdtQytoZW9MVzF5S3FwaDY4SjFTMkFlVGJlQTZ2bVR3SlNHQlJhdE5O?=
 =?utf-8?B?RG5LbmR1WkJxL2R3dXhIT0U4U0k3d2I1UHplVUNILzk4bHdMTENXYUtSeXk2?=
 =?utf-8?B?aHlCakwrTkxkSm5GaEJVWHlZYmRJQmhYVG5NUGozcks1dnhnbVBtK3hFRHly?=
 =?utf-8?B?NmZTMi9LYWtKeXM1dXAzQ3hHRXAvVWZCY1ZCTm50aDcvMW9wL2RzOEFqOFZ4?=
 =?utf-8?B?T2d6MkV4NU1MSWVPNnZ3YUhoWFk4dVI3TUFRSGtSVTFkVjBkTkxCbEtRMGRq?=
 =?utf-8?B?dHZkVFZWVE9LaHQyYVU5bzV6V2d2SEwvRjVOSndZK2MxMjRvaTIxajd2bTg1?=
 =?utf-8?B?ODdIQkV5NlNsNUIybEg4OEhJVmExUStycWxudjlXSWFYbmRsNGpodlNCQU8v?=
 =?utf-8?B?ZVA2ZUpJWHc0bDA5aEFvT3NMS3VJUTdhOEdaelRTZ3UzOUovYTFtL1VCSUlZ?=
 =?utf-8?B?VVFzZ0NyQWFVVWtNUXF2dXdZUnhaZFlLdHYxUzV0M1I3MVAyTW1iL3BYWGt5?=
 =?utf-8?B?MWVTdlNxVHNtZ0VGd0YrLzVqbHVXQk9leENQNnBiUjZ2S0NlRkR5VklHbkMx?=
 =?utf-8?B?VDRDMWh4eG1GZG9CMEN2a1pHV2pjc3hsQ1FXcWhUV0czK3J5TnFZblFIbFZv?=
 =?utf-8?B?SzUzcHdJcG5zdjJKU1NxaGZ3Ykt3RE5XWDNja3U4TDRsNVZoaHlLQUVYRGxT?=
 =?utf-8?B?NWUzcnV4TUt0TVY1N2dRempSaEoxU1NHMzVib2pzUXlUb09Pcjhkbjd4cGVL?=
 =?utf-8?B?ZEo3d0psV1ZldG1EQUtobEpWU0tJdnAyWXJUWGVweGpvSnlxK1dJMHdZRi8z?=
 =?utf-8?B?Qi9seTRSQ1I0NU9vcXQxNWN3Uit4a1hFNDQvbzB6SnZZUHEzdzNBMkVqVzd0?=
 =?utf-8?B?MSthZGJMMGlNVXZvc0NPSGZ3ZDFBQjhYM0ozcHZEYTFrVUVLdjE1MEJLVDdW?=
 =?utf-8?B?R2RrZGhMSE1SNDdrTldpbW9xT2ZpZ2crRDRBbGFmL0pBSFp5WjdOMXEwUFVP?=
 =?utf-8?B?cUpMWnNxSWJTNHMzUFlObk9XZGk1WjhoU2ZLekhkNnZ0NittejJyQUxONmNt?=
 =?utf-8?B?M1BTY0s0dVExUWl6UVNZODAzRHE5UTZnZXB3UkFWVE5LN3JITUpZTHJudTND?=
 =?utf-8?B?MzRrdm5FKzZoekZNdGFlSWhWNGtIaFRDc05ybnpaYjFiWTFvMTVWakRvUHZp?=
 =?utf-8?B?K2QwY1h0Kzd4YjdHdEZSZkREN2VGSG0xbmxoN1VJSktwNDJVaklJOVI1dWp6?=
 =?utf-8?B?MEYzeDlhTHlmMWN2aTZRblNPd0VDS3phT2FjNTBjTHl1cTQ2U2ErNzRvMHdo?=
 =?utf-8?B?T0ZZNERKbXRYWE9STVlNUGtsSmJDWmxkemM1Y0Q3TUJFM3p1SCtrM1JCc095?=
 =?utf-8?B?SnJwa0FJZ21odEhXMXdKWGRaY1ZCb0x3dll5VjRDQ2lRcEdUaEl3QzY1WjJa?=
 =?utf-8?B?c1I1TXJwTDN3VHhlVjZlVmNYRkp6RFc5WEU4Wjl4R2Q5ZHRSc09vL1VQL05Y?=
 =?utf-8?B?eFd5YndGS1FrM1pGKzVaOGxOYUF5bWtzZnhkYXNGdXFyWDlLdVYwOTZuZWdF?=
 =?utf-8?B?T2EzOEVpS3BWWkJxM3MvSDJUbjZ2cXJBVmJEcHRDK2ExQnd5MDNBQ1VCZmFV?=
 =?utf-8?B?RHUrZk1mbWZTSFFxdFhteTNHMVNubUE4SlZOenlkMEVnczZVQ0FLVkI0Zmph?=
 =?utf-8?B?clBhWjRZK0xDQjN2d2t2bzd1ZUtHYU9zMkZHSHZUcVJpOUVuNnF2VVhiTGxH?=
 =?utf-8?B?eTU4ZHB4WktTT09qVEd4cXVEcENYMG5VdkFMWkVBNWxhVTAwRWQrNDZmQnlO?=
 =?utf-8?B?eXY1Q0thTHdieXNoZURHZk9XUWdZcytmUVV1RCtudzJLRmdONk9aSjRla1F2?=
 =?utf-8?B?TmNaakN2eHZmbDk5TkNiVWRFbTFiM010Q3lMSEFVVzZUV0V0eW1MY0RFM0Q3?=
 =?utf-8?B?VWZHVm1SNlBkYVlDODJERUFkTjA1UGlER3M4eVU1OHNkQkI4djBQSHZ5cWRV?=
 =?utf-8?B?VzBLWGd3a2c0RGdaNGFnczVxR2hUbWtITGJONCtmUmNrbVFJU1YxcWFxOXly?=
 =?utf-8?Q?Q4Yg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1a91cc-a079-425c-71d3-08db99e8a00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 21:27:39.9351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhmlRA4jQrSzidSC81TkJ1gBnDkLiBXwa9o6wo63KxfopS5kAy0hT5SBtjjIMclA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgaXMgYSBzdHJhbmdlIHNv
bHV0aW9uIGJlY2F1c2UgdGhlIE1FQyBzaG91bGQgc2V0IHdhdGNoIGNvbnRyb2xzIGFzIG5vbi12
YWxpZCBhdXRvbWF0aWNhbGx5IG9uIHF1ZXVlIHByZWVtcHRpb24gdG8gYXZvaWQgdGhpcyBraW5k
IG9mIGlzc3VlIGluIHRoZSBmaXJzdCBwbGFjZSBieSBkZXNpZ24uICBNQVBfUFJPQ0VTUyBvbiBy
ZXN1bWUgd2lsbCB0YWtlIHdoYXRldmVyIHRoZSBkcml2ZXIgcmVxdWVzdHMuDQpHRlgxMSBoYXMg
bm8gaXNzdWUgd2l0aCBsZXR0aW5nIHRoZSBIV1MgZG8gdGhpcy4NCg0KQXJlIHdlIHN1cmUgd2Un
cmUgbm90IHdvcmtpbmcgYXJvdW5kIHNvbWUgSFdTIGJ1Zz8NCg0KVGhhbmtzLA0KDQpKb24NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZl
bGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTAsIDIwMjMg
NTowMyBQTQ0KPiBUbzogSHVhbmcsIEppbkh1aUVyaWMgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNv
bT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogS2ltLCBKb25hdGhh
biA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRr
ZmQ6IGZpeCBhZGRyZXNzIHdhdGNoIGNsZWFyaW5nIGJ1ZyBmb3IgZ2Z4IHY5LjQuMg0KPg0KPiBJ
IHRoaW5rIGFtZGdwdV9hbWRrZmRfZ2NfOV80XzMuYyBuZWVkcyBhIHNpbWlsYXIgZml4LiBCdXQg
bWF5YmUgYSBiaXQNCj4gZGlmZmVyZW50IGJlY2F1c2UgaXQgbmVlZHMgdG8gc3VwcG9ydCBtdWx0
aXBsZSBYQ0NzLg0KPg0KPiBUaGF0IHNhaWQsIHRoaXMgcGF0Y2ggaXMNCj4NCj4gUmV2aWV3ZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPg0KPg0KPiBPbiAy
MDIzLTA4LTEwIDE2OjQ3LCBFcmljIEh1YW5nIHdyb3RlOg0KPiA+IEtGRCBjdXJyZW50bHkgcmVs
aWVzIG9uIE1FQyBGVyB0byBjbGVhciB0Y3Agd2F0Y2ggY29udHJvbA0KPiA+IHJlZ2lzdGVyIGJ5
IHNlbmRpbmcgTUFQX1BST0NFU1MgcGFja2V0IHdpdGggMCBvZiBmaWVsZA0KPiA+IHRjcF93YXRj
aF9jbnRsIHRvIEhXUywgYnV0IGlmIHRoZSBxdWV1ZSBpcyBzdXNwZW5kZWQsIHRoZQ0KPiA+IHBh
Y2tldCB3aWxsIG5vdCBiZSBzZW50IGFuZCB0aGUgcHJldmlvdXMgdmFsdWUgd2lsbCBiZQ0KPiA+
IGxlZnQgb24gdGhlIHJlZ2lzdGVyLCB0aGF0IHdpbGwgYWZmZWN0IHRoZSBmb2xsb3dpbmcgYXBw
cy4NCj4gPiBTbyB0aGUgc29sdXRpb24gaXMgdG8gY2xlYXIgdGhlIHJlZ2lzdGVyIGFzIGdmeCB2
OSBpbiBLRkQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5odWllcmlj
Lmh1YW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2FsZGViYXJhbi5jIHwgOCArLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYWxkZWJhcmFuLmMN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2FsZGViYXJhbi5j
DQo+ID4gaW5kZXggZTJmZWQ2ZWRiZGQwLi5hZmYwODMyMWU5NzYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9hbGRlYmFyYW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfYWxkZWJhcmFu
LmMNCj4gPiBAQCAtMTYzLDEyICsxNjMsNiBAQCBzdGF0aWMgdWludDMyX3QNCj4ga2dkX2dmeF9h
bGRlYmFyYW5fc2V0X2FkZHJlc3Nfd2F0Y2goDQo+ID4gICAgIHJldHVybiB3YXRjaF9hZGRyZXNz
X2NudGw7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIHVpbnQzMl90IGtnZF9nZnhfYWxkZWJh
cmFuX2NsZWFyX2FkZHJlc3Nfd2F0Y2goc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCB3YXRjaF9pZCkNCj4gPiAtew0KPiA+IC0gICByZXR1cm4gMDsNCj4gPiAtfQ0KPiA+IC0N
Cj4gPiAgIGNvbnN0IHN0cnVjdCBrZmQya2dkX2NhbGxzIGFsZGViYXJhbl9rZmQya2dkID0gew0K
PiA+ICAgICAucHJvZ3JhbV9zaF9tZW1fc2V0dGluZ3MgPQ0KPiBrZ2RfZ2Z4X3Y5X3Byb2dyYW1f
c2hfbWVtX3NldHRpbmdzLA0KPiA+ICAgICAuc2V0X3Bhc2lkX3ZtaWRfbWFwcGluZyA9IGtnZF9n
Znhfdjlfc2V0X3Bhc2lkX3ZtaWRfbWFwcGluZywNCj4gPiBAQCAtMTkzLDcgKzE4Nyw3IEBAIGNv
bnN0IHN0cnVjdCBrZmQya2dkX2NhbGxzIGFsZGViYXJhbl9rZmQya2dkID0gew0KPiA+ICAgICAu
c2V0X3dhdmVfbGF1bmNoX3RyYXBfb3ZlcnJpZGUgPQ0KPiBrZ2RfYWxkZWJhcmFuX3NldF93YXZl
X2xhdW5jaF90cmFwX292ZXJyaWRlLA0KPiA+ICAgICAuc2V0X3dhdmVfbGF1bmNoX21vZGUgPSBr
Z2RfYWxkZWJhcmFuX3NldF93YXZlX2xhdW5jaF9tb2RlLA0KPiA+ICAgICAuc2V0X2FkZHJlc3Nf
d2F0Y2ggPSBrZ2RfZ2Z4X2FsZGViYXJhbl9zZXRfYWRkcmVzc193YXRjaCwNCj4gPiAtICAgLmNs
ZWFyX2FkZHJlc3Nfd2F0Y2ggPSBrZ2RfZ2Z4X2FsZGViYXJhbl9jbGVhcl9hZGRyZXNzX3dhdGNo
LA0KPiA+ICsgICAuY2xlYXJfYWRkcmVzc193YXRjaCA9IGtnZF9nZnhfdjlfY2xlYXJfYWRkcmVz
c193YXRjaCwNCj4gPiAgICAgLmdldF9pcV93YWl0X3RpbWVzID0ga2dkX2dmeF92OV9nZXRfaXFf
d2FpdF90aW1lcywNCj4gPiAgICAgLmJ1aWxkX2dyYWNlX3BlcmlvZF9wYWNrZXRfaW5mbyA9DQo+
IGtnZF9nZnhfdjlfYnVpbGRfZ3JhY2VfcGVyaW9kX3BhY2tldF9pbmZvLA0KPiA+ICAgICAucHJv
Z3JhbV90cmFwX2hhbmRsZXJfc2V0dGluZ3MgPQ0KPiBrZ2RfZ2Z4X3Y5X3Byb2dyYW1fdHJhcF9o
YW5kbGVyX3NldHRpbmdzLA0K
