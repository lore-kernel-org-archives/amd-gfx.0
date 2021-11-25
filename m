Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CEFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 04:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66576E0AF;
	Thu, 25 Nov 2021 04:58:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96BC66E0AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 04:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmfI6h1XPfjjNmsI3ye5ydyykLWjkGWd+g70Na5RCqNVVjbCLhhgDVYc+GKdZgoOXGDV/uJjBhVAlwYxuSy0EO3StelVzf2tqK3MPTw/XW54NeNN0QHtsRFY4nJ19x0iAMMJ1rwzVJBBWX/ZNYHuN50Yknwub2UeYE2rGFoSJ129HGLHQyyoNRQYTLTzkRHzqkvtLAhro8IkkzsCKIPXgiQZQ1NmohjNibrBfYF8YD75oJ4o9l7N1QdEIPXXwPzHAbcQLUKmFTx5mYmEY+v5egFCLTAB7t27SNuZGj6MreqWo7pSr+mCcLbDfZemsjWakQL7A+3l5sEs+CFCWpwgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc4rQ0UfAwB8EDlKudMVNAUWAqsIVl16OlCnaQJ8G6w=;
 b=feeQ7ZSCuE2JSqVRu8EZrD9p3FJVssI9wqUDRUI3MNoHUVh5G26lnszF3NVYih0dQlLMb4haBVlNxWBDRbEuNwmBiOcyiMG4rsmOBIUK9dMsMV+7Wem3WH9Abb6D0WiCf9YwHhntOxv2LLz3vEQKF3ovLo1IL4Ah1kGbdvaAWJ7Q3qyIE6xfBuVhoJSj2Lv1Tas+mbbUfGtC0T9NaS9tF0ZN8IZMEuO6d9wnfRtuSJS4ZlRKxn33i56tr1b/fBROMDRJ8rz3lb24QL1EKNT3efsaQui1McR/+1muZLeUtV6qSzsrXdcXpDCtd1vArCGdmIr9WCapKq+0ZRtg48n0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc4rQ0UfAwB8EDlKudMVNAUWAqsIVl16OlCnaQJ8G6w=;
 b=h0J8dA249lPkp6qJKd75RA1nP6/exxD1NIs7oaKdCpSadvElBBo6s30FJcPHp/0+dQo30Br/RdwN5KKOCqnXPBHwBXiazQ18okh/wwAfa7SyzHhy3mnMs+HsRTtSdEfPE9kNVnDVyacPZKsC54UPfTGNTlj/hDM2qMhDBhDCkk8=
Received: from MN2PR12MB3246.namprd12.prod.outlook.com (2603:10b6:208:af::21)
 by MN2PR12MB3229.namprd12.prod.outlook.com (2603:10b6:208:102::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.26; Thu, 25 Nov
 2021 04:58:43 +0000
Received: from MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71]) by MN2PR12MB3246.namprd12.prod.outlook.com
 ([fe80::70b6:8476:4368:fd71%5]) with mapi id 15.20.4713.024; Thu, 25 Nov 2021
 04:58:43 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: reset asic after system-wide suspend
 aborted (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: reset asic after system-wide suspend
 aborted (v2)
Thread-Index: AQHX4TEB0ZwUcJmseUqyLytBr8YFRqwSrIKAgADTA+A=
Date: Thu, 25 Nov 2021 04:58:43 +0000
Message-ID: <MN2PR12MB324636D16AC911B510B52AFDFB629@MN2PR12MB3246.namprd12.prod.outlook.com>
References: <1637757791-3210-1-git-send-email-Prike.Liang@amd.com>
 <b46176de-3f94-e85d-1a6d-a6966a905c52@amd.com>
In-Reply-To: <b46176de-3f94-e85d-1a6d-a6966a905c52@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d660afa6-2401-41f6-8895-cf543978f9e1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-25T02:06:01Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bafecfb9-334f-4eae-26b0-08d9afd04157
x-ms-traffictypediagnostic: MN2PR12MB3229:
x-microsoft-antispam-prvs: <MN2PR12MB3229A18C2AD8AB3FC7197634FB629@MN2PR12MB3229.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDWLNQMOI/6dQhSkIGXikj0gwbVisB5chvnXmEqwqYx/pcOVzDj/WBwiMjE2fBMKvZ6mMUwVE82sZrNzYyiHMVBDVVnR5tHabOaS+7HfLFsgKYBdTPMcJgIGMf6YFO/7VUkCb3DggCooQkZKOVgiWmxVwSOV+1fOzQJaRi4iw4/J19gSk/aYLO93o/6s7YLd2ziNQiM3uO+lf9gNtRQrb+wvurFfSgFvSgd4f4vWaQfibXOyNNXidtBi6+kBH5g/rG+LXUOrcPYVhjU3BqOwygTFy1cjXwpJeyF7eXMSGbVKXMM9a09XF7vxmz0KGSxxniRMTQL2Q2a7htJztusyKaEQM8xy/MRptJIEDMsYAHXNnnq2k0StXPSPXUfgEdd1SXwYYEqqLGFYcXWYN74dfGcjnRjkgc2d7/bjczmJN6qRtwg9Q3JiR2/56HMd8oZv5E4zgTe0X3xvZWaygqZnE6wLaxL+hdVjoz9V1CJxnSQ7KSSDlyJR+DVdboQVqX/1+nDiID0FPq1fFkaV8aZK6BNVcZhFejz1jA/lxpxxZfX8B4qfDN700LDH2N7E5kpb05nHRmQV3dw/yoOiT0M+0WIKRoG9W3YSWLfl8G46StQAb+6Nn7uuD/oi5936eBdB4lkuGHuXF7CqoTtppkl18CqdG8dqd+6/2/afYe649maiqWZZ5VXo0Ae7evMVNHYngVic6oTdEKkFOJvHPlL3iQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3246.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(38070700005)(38100700002)(55016003)(71200400001)(66446008)(64756008)(508600001)(76116006)(66476007)(66556008)(52536014)(83380400001)(5660300002)(6506007)(4326008)(8676002)(110136005)(54906003)(33656002)(316002)(8936002)(86362001)(186003)(26005)(15650500001)(2906002)(7696005)(66946007)(122000001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2g3VlhSdVB0ZklzRlQwY0tiaHk0T3g0NnBLSjBXVkdTL1FuRzRsb0JINmpi?=
 =?utf-8?B?TmhsbkFhNGNvcXZheUFxR2FWWHFkRHFDaXVKYnBPT2NlcHFoTEw1aWFaL0Rs?=
 =?utf-8?B?dG93d1JjTzhUdExoZk1vL1dqZjk5b0lqQ0tSdlIwVmdOTUV4VFlIR1R0U3VB?=
 =?utf-8?B?akVxdUZoUk1jRzU5WWt1V3NWT21hSkx5Z3BpUG5udFNRTzdZSEoveXN1Tmpn?=
 =?utf-8?B?L1BvWVZxVldOcFY5WHZMTTQ4ODhwcW94QzBIZTdjYStJMHVneUU5eWxpVkZR?=
 =?utf-8?B?SThzU2hPZFI4MDdXbjFRd1VaTUpXSGd1TWQyU1I0VWVnaUcxNCtDMXBsd1dL?=
 =?utf-8?B?NFp6R1V3eU5mSUcvazRpYlFrMXFwNWQvenZPaDI0ZWFSZlR5VVQwU0hKOHBV?=
 =?utf-8?B?WjRjQ0t6eWx4R2JwbzZqMGJETEgzc1lCOW9hcXpOektEb1dsa3oxbHJTSXBG?=
 =?utf-8?B?a1ZySWZJZTNnQVl0S3ZlcVBLQjdqYjZzVFpad2xnTnFMaWRaM282VUR1dFFO?=
 =?utf-8?B?N3VYUVZRMC9MK1NXc3FYYXphNHBaZE5iQTdXNzNGeGVIZlNtaEYwbHVRZnY1?=
 =?utf-8?B?Q0RxZmdmcDVoQmgvMXFUcFFCb2xVUmVBLzQzNkIvcGFNb05kelFoSGNXQXFX?=
 =?utf-8?B?N1pUTE9lTzRFbGkwVEdBWWdUTlZTZ0xxSjVGbXJBZ3JXQzBuL3ZoVnZtcm1y?=
 =?utf-8?B?RnVNVzhtUEpscnpSNjBiZVNvTmhoS0lPYVVjUjZOeEhVQmV1S0VRT3FhamNt?=
 =?utf-8?B?L1lpWmFBZ0w3SzJlMTBMYUlYemNvUTYwaUwyN2lQYWxiVUMwdy80YjFlMkxw?=
 =?utf-8?B?VksvZmlIMDhRdHIrMVA0QUN5WHBvZjV0MUp4OExFbjY0ZTFHQmg3dGk1THMy?=
 =?utf-8?B?YUo2TFRsdGkvVU8vcmFPYWZXQjlRbnNhQVhPbHJvNDg3czJ2ZnZEUkkwZG5x?=
 =?utf-8?B?UFFIZEE3Y0FBN2pVc0ZCakFqckJXb0IwU3FIUHJZL3pENjBNY1dOUGZVOElv?=
 =?utf-8?B?eUUwSWFoRGJBZWNiTzRNN201QlB0aHhMdU1CS2Jmd2x3MmtadkxNRjlGKzFk?=
 =?utf-8?B?NmNwSG5PK0JOWEcxdFYzUGlMMVoxVkhqVExMN1ZROTBKYnZnZzRrT0JZUTd6?=
 =?utf-8?B?dS9Mb09jalRRSTVrSlRSNUJKU2twVVBHdzBKblhoN2NrOW5pTWptL1hKZTJL?=
 =?utf-8?B?Q1NMNTMyNTI1cVIxcmtxQ3FoZWUybExuUHhJbklBSi9CTGZvZ1dwOTBWUEhM?=
 =?utf-8?B?anYybHVHOVVjczhaZGpmSnpoWFRDcUR4YXlJRTRiTHFjK1JGVW1iV1JEejRu?=
 =?utf-8?B?NVA3cG1SNGFoK0wreEtxNHBkYW1sQzYrUE0wUjRxaDlSaUJ1OTZGcmYzTEg5?=
 =?utf-8?B?cXFOdkt4YXdoRzdib2tkV1lCMzZjTGxhcWljaEs1V0tnai9RbnV5N3NyM0xq?=
 =?utf-8?B?bjd6ckk2RTdxVXhLR3FJOUFnNHhmMlNrUFZ4NFBZeTdHUExwVUgwQkNFRitK?=
 =?utf-8?B?MVVyb1Z2NGIwcm1ZN2tOMm5ScUVpRmM5V2xnRENXekJweWZtcTM4Y0F5OGZM?=
 =?utf-8?B?NTRlWG5GUnJGRmhsdENpQTFnSkExTVJDSERVK2tCdTUyZ3RYYms2VTV3TUda?=
 =?utf-8?B?bTNUOGlpZDdZTGlXZXc0UTBUTTM5MXdtYVJkUHhkYS8yUWJoZ0pIOGdSb1cr?=
 =?utf-8?B?c1E2bVhQK25ZT05USGs0dzFSL1A3YTJ2YzR3MndPeGJQNmlqVXVyMkYwWkRi?=
 =?utf-8?B?TnNEdkZOYk9MWWMwWU1nNklXRHBwUkREbWJ0SGhvSytDMzlidHRkK3dPSFdN?=
 =?utf-8?B?ZWd2eDR6WjlYQzlEQXY2aW5xYmtHZFlwSU1Yd1d6L2p5YlZiQzZzWWhPdWRS?=
 =?utf-8?B?ZnV5UENEODFjTWNjSlZ2a3FPUVE4Z09HclRVQTNFakJkbUh0bFVtQTVPTU8z?=
 =?utf-8?B?L0luSDI0ZUlSUFlNQzkvbFNMQ0dDUTlYMEhYUFd5bWpZaVFTbS9zTERRWVVV?=
 =?utf-8?B?K0JQanR2M1pGSU9hcmRpdE9UVVF4dHI3a3JVTkdzZVVxNWNaaDhBYldkUEMr?=
 =?utf-8?B?Y0lrUGFXeStuZS9VVWRNLzdTaHBzY2JIaW1pOUhBNFBDQ0gxc01HdlhicU5J?=
 =?utf-8?Q?drhU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafecfb9-334f-4eae-26b0-08d9afd04157
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 04:58:43.1825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jEvR+roa3ujGZnR7LzkQ6z879VyXaC1Nk37XacvVVzdNecqLQB8ngrifBJZGKjPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3229
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwg
TGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI0
LCAyMDIxIDk6MzAgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTogcmVzZXQgYXNpYyBh
ZnRlciBzeXN0ZW0td2lkZSBzdXNwZW5kDQo+IGFib3J0ZWQgKHYyKQ0KPg0KPg0KPg0KPiBPbiAx
MS8yNC8yMDIxIDY6MTMgUE0sIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IERvIEFTSUMgcmVzZXQg
YXQgdGhlIG1vbWVudCBTeCBzdXNwZW5kIGFib3J0ZWQgYmVoaW5kIG9mIGFtZGdwdQ0KPiA+IHN1
c3BlbmQgdG8ga2VlcCBBTURHUFUgaW4gYSBjbGVhbiByZXNldCBzdGF0ZSBhbmQgdGhhdCBjYW4g
YXZvaWQNCj4gPiByZS1pbml0aWFsaXplIGRldmljZSBpbXByb3Blcmx5IGVycm9yLiBDdXJyZW50
bHksd2UganVzdCBhbHdheXMgZG8NCj4gPiBhc2ljIHJlc2V0IGluIHRoZSBhbWRncHUgcmVzdW1l
IHVudGlsIHNvcnQgb3V0IHRoZSBQTSBhYm9ydCBjYXNlLg0KPiA+DQo+ID4gdjI6IFJlbW92ZSBp
bmNvbXBsZXRlIFBNIGFib3J0IGZsYWcgYW5kIGFkZCBHUFUgaGl2ZSBjYXNlIGNoZWNrIGZvcg0K
PiA+IEdQVSByZXNldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlr
ZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jIHwgOCArKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+ID4gaW5kZXggN2Q0MTE1ZC4uM2ZjZDkwZCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtMzk4
Myw2ICszOTgzLDE0IEBAIGludCBhbWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2Rldmlj
ZQ0KPiAqZGV2LCBib29sIGZiY29uKQ0KPiA+ICAgICBpZiAoYWRldi0+aW5fczBpeCkNCj4gPiAg
ICAgICAgICAgICBhbWRncHVfZ2Z4X3N0YXRlX2NoYW5nZV9zZXQoYWRldiwNCj4gc0dwdUNoYW5n
ZVN0YXRlX0QwRW50cnkpOw0KPiA+DQo+ID4gKyAgIC8qVE9ETzogSW4gb3JkZXIgdG8gbm90IGxl
dCBhbGwtYWx3YXlzIGFzaWMgcmVzZXQgYWZmZWN0IHJlc3VtZQ0KPiBsYXRlbmN5DQo+ID4gKyAg
ICAqIG5lZWQgc29ydCBvdXQgdGhlIGNhc2Ugd2hpY2ggcmVhbGx5IG5lZWQgYXNpYyByZXNldCBp
biB0aGUgcmVzdW1lDQo+IHByb2Nlc3MuDQo+ID4gKyAgICAqIEFzIHRvIHRoZSBrbm93biBpc3N1
ZSBvbiB0aGUgc3lzdGVtIHN1c3BlbmQgYWJvcnQgYmVoaW5kIHRoZQ0KPiBBTURHUFUgc3VzcGVu
ZCwNCj4gPiArICAgICogbWF5IGNhbiBzb3J0IHRoaXMgY2FzZSBieSBjaGVja2luZyBzdHJ1Y3Qg
c3VzcGVuZF9zdGF0cyB3aGljaA0KPiBuZWVkIGV4cG9ydGVkDQo+ID4gKyAgICAqIGZpcnN0bHku
DQo+ID4gKyAgICAqLw0KPiA+ICsgICBpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNpY2FsX25v
ZGVzIDw9IDEpDQo+ID4gKyAgICAgICAgICAgYW1kZ3B1X2FzaWNfcmVzZXQoYWRldik7DQo+DQo+
IE5ld2VyIGRHUFVzIGRlcGVuZCBvbiBQTUZXIHRvIGRvIHJlc2V0IGFuZCB0aGF0IGlzIG5vdCBs
b2FkZWQgYXQgdGhpcw0KPiBwb2ludC4gRm9yIHNvbWUsIHRoZXJlIGlzIGEgbWluaSBGVyBhdmFp
bGFibGUgd2hpY2ggY291bGQgdGVjaG5pY2FsbHkgaGFuZGxlIGENCj4gcmVzZXQgYW5kIHNvbWUg
b2YgdGhlIG9sZGVyIG9uZXMgZGVwZW5kIG9uIFBTUC4gU3Ryb25nbHkgc3VnZ2VzdCB0byBjaGVj
aw0KPiBhbGwgc3VjaCBjYXNlcyBiZWZvcmUgZG9pbmcgYSByZXNldCBoZXJlLg0KPg0KPiBPciwg
dGhlIHNhZmVzdCBhdCB0aGlzIHBvaW50IGNvdWxkIGJlIHRvIGRvIHRoZSByZXNldCBvbmx5IGZv
ciBBUFVzLg0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4NClRoYW5rcyBmb3IgdGhlIGlucHV0LCB0
aGF0IG1heSBuZWVkIGEgbG90IG9mIGVmZm9ydCB0byBzb3J0IG91dCByZXNldCBtZXRob2QgZnJv
bSBtYW55IGRHUFVzLg0KU28gaW4gdGhpcyB0aW1lIGxldCdzIG9ubHkgaGFuZGxlIEFQVXMgZmly
c3RseS4NCg0KPiA+ICAgICAvKiBwb3N0IGNhcmQgKi8NCj4gPiAgICAgaWYgKGFtZGdwdV9kZXZp
Y2VfbmVlZF9wb3N0KGFkZXYpKSB7DQo+ID4gICAgICAgICAgICAgciA9IGFtZGdwdV9kZXZpY2Vf
YXNpY19pbml0KGFkZXYpOw0KPiA+DQo=
