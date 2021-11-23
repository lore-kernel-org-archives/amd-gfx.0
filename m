Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBC9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 01:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9935389F8E;
	Tue, 23 Nov 2021 01:59:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598C489F8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 01:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6+rdj+Q+wDEle2MeE4HW9uplG2z11OvKT6cuWv1pw6BT5skW4x/xOXayYMSumylgbZVi5nsFj9tzZHWyPhC3AtiCS0RzZ2IQwvkRZzR/86cAFy64xgDc32w8hRmo+xyba/LPQG2pbyyWsl8pxfxbAdwnRjhfF+y3zZY7cEmos1IUqwjxo4WipUGLA/K0qF3eoOykHWeWD8DclslS6VzjCd1z46GRW7qbf0ekfndf+ub/m8du81F5XOipytPNhcCWhfOXwivslrIxRmKjNxeHrtHuNcGLYTwh22uYFjtUXzNBavmPoOxd5ueahur4CmuG9/SZw94JH5+NAQToRmE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urc2FY70wOBtDP9gs/pCzGWg63O2mr3f8sZiixgrxp4=;
 b=chLmh0FYCQSI6EaXz8NQye/qu8AwbpZbJsEj+jurw3e4oNVDBXVQmfBdglnIPVCdJkhgz0eVK9S/E5Z1ZC4kNX1uxjjVkFpNslW6vQsYFQD73wvRzt7raF5BJS3gvNKU3COYm/nKZY3bkVhLgWRDd0bTPmKyEi/FrGfsoOofIt/ZOJyHhBVWA+281dz2/5PObLpzki+sxdCPI0H5cyY/BGjZP7iHNe5xPXZ4R5IOiGy6g6SF7ETzztT0qAkpON99LDBdjS/XrSqRCfs3cw8FWHPHNbya4PWdVVV0NSeomuMHIcZ6TukhWGUzAcZPJl8QycoF3kbG6p3tb0Ctge7Ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urc2FY70wOBtDP9gs/pCzGWg63O2mr3f8sZiixgrxp4=;
 b=Ol3wZOUeHeGozK2S+2mfP3LD2iGCcy73GIA0TAwIccirUck27t5yTwlkJO3mApWZqoZ1VCCrH1TPUQlrHbTWafHpAkG4PDeRi82qJ5nC1z6SRRtvlfBRHRasKKVJHwgDg1iPu6KFCV7kZM1qyHWMBl4ZudD2MMK0cpWuejMMoIQ=
Received: from DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 01:59:42 +0000
Received: from DM4PR12MB5118.namprd12.prod.outlook.com
 ([fe80::cdfa:8b04:6d82:82b]) by DM4PR12MB5118.namprd12.prod.outlook.com
 ([fe80::cdfa:8b04:6d82:82b%9]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 01:59:42 +0000
From: "Cui, Flora" <Flora.Cui@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
Thread-Index: AQHX34A62BveMfofokmfnGnPyzpbYawPkIEAgAAwlYCAAJolUA==
Date: Tue, 23 Nov 2021 01:59:42 +0000
Message-ID: <DM4PR12MB5118A3B5FE4D3271F5793057FA609@DM4PR12MB5118.namprd12.prod.outlook.com>
References: <20211122090353.1399178-1-flora.cui@amd.com>
 <DM5PR12MB2469709B28E24F1C8FCB573EF19F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BL1PR12MB51440B523B58CA96EA7BC0C0F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51440B523B58CA96EA7BC0C0F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-22T16:43:15.383Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4158d6a-9b50-4d5b-0d10-08d9ae24ea7f
x-ms-traffictypediagnostic: DM4PR12MB5039:
x-microsoft-antispam-prvs: <DM4PR12MB503904DA42B355890EF13AFFFA609@DM4PR12MB5039.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MH0419UCEWcqWF7Un1Tz3c329rqCYuInu88Ew9yw51kT7/VQwgBgxo6TZIjWgOQkXZS3XPQM5ARam8p9OmVHfmiE8U/kO9itc/PC7vPoRGxcWTfAsgZffsSnhu6DK+cnbVqgMCMVxKWy6wcN5YVCo8E8Q3vYIeNhCl1+7W2D+P/2rebwbca8CLKPh5YSRBP+T9SiX9fDGoatu1h9IkjJ5mCuLQZakB829E6A6rSaYi9+iomv8GWyJPS2bXH1oMXe3ETTX1WgMq3Pro3LlcolYMa4wUqzGrxqfUepI6F56A5D7b/ot86qrtkYI3GbUABjACF9P0oopoimJ97YNyx5hV9OWaxswg9qkW6EHKKUXzmJzupgzL9sTtSEk7Sq5/xsjNMr2euIvw+8P4E1PhN3Iz6mw8dXU+bmz+jbcy3KumiddRdr7xh1G6+x4h9Y2wbp6yyjk4bjT6kLn6MS9Nqo9gXfVM2wsqPWMWxO+D/0qFTxY8HGRPbZ675cn6z0k9uTsRUitxFdlImrV53ARQ4Z+ZR+czMWWcDmK0loSh6cdf5TJIrCc90rSQv7fbyyBf2KOcBXeMTIpdCek/CWIkzddxaLUmBBrQ27Zs9C9/nhVOTH3Pmznv8tKbY4iAZGOQ0xbxvhpUFsCc3VoQiS72upiJ7l42luCLzOqKtFaKNtqpV1jPM5iSofzxhIgF8acrNk2Njryi+OzkUzCXLHp65U9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5118.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(7696005)(9686003)(6506007)(53546011)(26005)(38070700005)(55016003)(8936002)(110136005)(316002)(508600001)(71200400001)(64756008)(66556008)(66476007)(66946007)(76116006)(38100700002)(122000001)(5660300002)(66446008)(83380400001)(33656002)(2906002)(86362001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Nmwza1NaNU1aRnJleFRjYkl0Smd6QVU3NVZHYTBJNUFjSG9xREVxOWcyNGRr?=
 =?gb2312?B?aFN1cjIvdzBQM25MUDV2bTkvRktYcHlvbk5sK2RBcGJwZWs5bWtpUytrNThh?=
 =?gb2312?B?MHpTaUZTTit4MXUyeXlYOHE2RTVjVU1HQjN5WHVCd1NKVHoyYWwycTJIVkF4?=
 =?gb2312?B?clFhWVAyMWk1WEk5RVNlRHZRUWtnZnA5bjFrUmx0VVJEU1VROUVJMkhwTFd0?=
 =?gb2312?B?clpVSmxvTTdYcFNXVEhUUUVtWTRUMVVveDVOdDFCdFhEdE5teHBLRFFCOE9u?=
 =?gb2312?B?WDc5THVrZjBSWTlHOUlyZUs0bTVuZkZUZ0l1TElrVEEwaFpCNjFMdDNGTEF4?=
 =?gb2312?B?RGxGUXJsVFhYZFN3YldQYWNvV1Y0d3g0dnljOGVmTSt3enl0M1JvMVdDY2Vq?=
 =?gb2312?B?bjdtSCs3UUhNVGpDZWprc3c2WngrTWZjRm9YbnRNRzZiTUMvYmF1cmxMQ21m?=
 =?gb2312?B?cW0vN0NrVjBGNFo1RXl1cURBaEhreGY0bitZbGJHZ0ZTM3VUYjRkUmdaS1Ru?=
 =?gb2312?B?ZnNGc1NRWmJmckoxMWg5eEZwV1o1Uk5pbktMUWtPUFFkeGh3NUd1eEJwYm9o?=
 =?gb2312?B?RngxL3NHQVgvQ2N6OHZNQ2JLTjJUZmh2aFJjTnZ6Y2xlRmhiSG1kL2ovT0Zj?=
 =?gb2312?B?MklrL0FvL3Z2WUhRYktLaEMwS1BMZkZuQXBvWGc4NEZSenZsdVJWTGhVazgr?=
 =?gb2312?B?bGZpWlVOVi9BN0owUVczclh4dy9YZ3QwUDgzQ2hxMXE0SC90Ri9FS29jQnU1?=
 =?gb2312?B?YTZIOVRYak1QR0dBbUxaLzM0YmVhdmRPVkphRUtFa2I3WkpXMERJZkNOWmhI?=
 =?gb2312?B?eUxRSG1KV2VFRlB6bkZJZlBqMUJNYnFjSk1DU3EwYUxjY3k4eUM5L1pHVlVQ?=
 =?gb2312?B?dDZwbTdOdnRhRHVoUEtxS3JVQnlwZWMvTjMrQUxVRkMxSlN6SWFVc09UZXVo?=
 =?gb2312?B?a01Qa1NjQUlKZzZtNGdTSTh1d1JPSnJJV3ZlUEM5K2p5Q0tjQ2I2SENtblhq?=
 =?gb2312?B?MGI1OHRjcjdrVnQ3L3FmajdHYUNTTHBJamtYMTd5N05HOUE5amM2Qnl5dEIx?=
 =?gb2312?B?UDN0RDlXSHBUdUlvazhidTMrTmJBaS95WDVUTVZrK0o2bDhXZG1DQ0JxTjJH?=
 =?gb2312?B?VS9qL050Tm5HR21JWFQ4NE9kelNCbXp3ZU5CNVlJZDhIczE1L2I4M0NGRUxK?=
 =?gb2312?B?TkdDZVFObVlGU2Nka1hINUpSRVRrNWVwRWdBL3BYOE9penVWUzBSNWRHeWVE?=
 =?gb2312?B?RmxLT0dIa3FxU0g1SVA4MGJzMEdwWkxmQ0I0Vk4yeENQWkpkMlRCSW0rcU16?=
 =?gb2312?B?ZUczWldXSlk0NmJwd0grS1JBeFJhZGFFaVNrNjdrWGRudGlBK09BdG9xK0Zq?=
 =?gb2312?B?OEJSQ1E3L0JmUnluWGhjRTlacDJ5WmRiNDc0TTVURXA4WDgxTnF2OFhoYXBL?=
 =?gb2312?B?NXhVZnZZcitDYmc5RWh6YXErSHppYjNnK3VtSjlSMURyTW14ZU4wSldScG9h?=
 =?gb2312?B?cVNDNElWdTNqbk5WZEc0Z2M3QVRLaGRmNmJOSlJUOEtoUFQzczJDazN0MU5p?=
 =?gb2312?B?cmhXWTJGdEhBTVlDWWY1QUs4b2dZNmlBVUZzZFh3M0VPQmxaMWdpYXR3QVFz?=
 =?gb2312?B?bnQyYjd3VjE0RkcwMDF1OFNiaHNtMk1kQ2h6NEFxSGdNOVRZU2R0dUtmVXE0?=
 =?gb2312?B?TmhpNC9OaUtLNkxidFFmYXFRZVMzV3JiTytsQUxDZU8rYmtnb3B0MzVES0Nj?=
 =?gb2312?B?YytHYjRCTjBJZlR3VERZaEZOQS9aTTdaMUh3NU42dEI1STJPaHN4V2cvNGNt?=
 =?gb2312?B?NGpPK3hRVnVlNkFPOHhBM1RGK3h2cXJ1YytZbU4xUUZhUENPWXgzZ09NS1M3?=
 =?gb2312?B?bWJxK2tCWXNyOFZlbFovZDVaQkZaVjdoSGF3ZGhLQ00vU2UwMTg5cGRGU01v?=
 =?gb2312?B?WjJtekVHSUZ2aTFFeDdPK2dSK1cxZThOTnQrTU5mSGNZZ2U2Y0xUTmtnMzFj?=
 =?gb2312?B?YXBGVmRxVmNid2dDcDE4Ky9BSkNSdXExMitNRVhjanJOYkZOQ2pCd2lmUWtw?=
 =?gb2312?B?ZS9iMmpjQi9Pb3hxWjJzRW1MTzF2R21ESWUycVljQzRZYng0b3c2NzZjQjgz?=
 =?gb2312?Q?gH4Y=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5118A3B5FE4D3271F5793057FA609DM4PR12MB5118namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5118.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4158d6a-9b50-4d5b-0d10-08d9ae24ea7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 01:59:42.4751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dZ9/enwOtioEGi33fDVkoEagayv31uWcGR7DMkGQ8gFJALIuVnKWkt8jldOYeJs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
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

--_000_DM4PR12MB5118A3B5FE4D3271F5793057FA609DM4PR12MB5118namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W1B1YmxpY10NCg0KTW9kcHJvYmUgLXIgYW1kZ3B1IGdldCBvb3BzIGluIGFtZGdwdV92a21zX3N3
X2ZpbmkoKQ0KICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgYWRldi0+bW9kZV9pbmZvLm51
bV9jcnRjOyBpKyspDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT5tb2Rl
X2luZm8uY3J0Y3NbaV0pDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaHJ0aW1lcl9jYW5jZWwoJmFkZXYtPm1vZGVfaW5mby5jcnRjc1tpXS0+dmJsYW5rX3RpbWVy
KTsNCmFkZXYtPm1vZGVfaW5mby5jcnRjc1tpXS0+dmJsYW5rX3RpbWVyIGlzIG5vdCBpbml0aWF0
ZWQgYXMgdmttcyBpbml0IGl0cyBvd24gYW1kZ3B1X3ZrbXNfb3V0cHV0LT4gdmJsYW5rX2hydGlt
ZXIuIFRoaXMgcGF0Y2ggZHJvcCBhbWRncHVfdmttc19vdXRwdXQtPiB2YmxhbmtfaHJ0aW1lciBh
bmQgdHJ5IHdpdGggYWRldi0+bW9kZV9pbmZvLmNydGNzW2ldLT52YmxhbmtfdGltZXIgdG8ga2Vl
cCBhbGlnbiB3aXRoIGFtZGdwdV9kbSAmIGRjZV92eF8wLmMNCg0KDQpGcm9tOiBEZXVjaGVyLCBB
bGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTZW50OiAyMDIxxOoxMdTCMjPI
1SAwOjQzDQpUbzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgQ3VpLCBGbG9y
YSA8RmxvcmEuQ3VpQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCB2a21zIGhydGltZXIgc2V0dGlu
Z3MNCg0KDQpbUHVibGljXQ0KDQpDYW4geW91IGV4cGxhaW4gaG93IHRoZSBjdXJyZW50IGNvZGUg
aXMgZmFpbGluZz8gIEl0J3Mgbm90IGltbWVkaWF0ZWx5IG9idmlvdXMgdG8gbWUuICBJJ20gbm90
IG9wcG9zZWQgdG8gdGhpcyBjaGFuZ2UsIGl0J3MganVzdCBub3QgY2xlYXIgdG8gbWUgd2hlcmUg
dGhlIGN1cnJlbnQgY29kZSBmYWlscy4NCg0KQWxleA0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KRnJvbTogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPG1haWx0
bzpHdWNodW4uQ2hlbkBhbWQuY29tPj4NClNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjIsIDIwMjEg
ODo0OSBBTQ0KVG86IEN1aSwgRmxvcmEgPEZsb3JhLkN1aUBhbWQuY29tPG1haWx0bzpGbG9yYS5D
dWlAYW1kLmNvbT4+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxtYWlsdG86YW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzxt
YWlsdG86YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+PjsgRGV1Y2hlciwgQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPG1haWx0bzpBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPj4NClN1YmplY3Q6IFJFOiBbUEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBmaXggdmttcyBocnRp
bWVyIHNldHRpbmdzDQoNCltQdWJsaWNdDQoNClNlcmllcyBpczoNClJldmlld2VkLWJ5OiBHdWNo
dW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbTxtYWlsdG86Z3VjaHVuLmNoZW5AYW1kLmNvbT4+
DQoNCitBbGV4IHRvIGNvbW1lbnQgdGhpcyBzZXJpZXMgYXMgd2VsbC4NCg0KUmVnYXJkcywNCkd1
Y2h1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ3VpLCBGbG9yYSA8Rmxv
cmEuQ3VpQGFtZC5jb208bWFpbHRvOkZsb3JhLkN1aUBhbWQuY29tPj4NClNlbnQ6IE1vbmRheSwg
Tm92ZW1iZXIgMjIsIDIwMjEgNTowNCBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPG1haWx0bzphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IENoZW4sIEd1Y2h1biA8
R3VjaHVuLkNoZW5AYW1kLmNvbTxtYWlsdG86R3VjaHVuLkNoZW5AYW1kLmNvbT4+DQpDYzogQ3Vp
LCBGbG9yYSA8RmxvcmEuQ3VpQGFtZC5jb208bWFpbHRvOkZsb3JhLkN1aUBhbWQuY29tPj4NClN1
YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCB2a21zIGhydGltZXIgc2V0dGluZ3MN
Cg0Kb3RoZXJ3aXNlIGFkZXYtPm1vZGVfaW5mby5jcnRjc1tdIGlzIE5VTEwNCg0KU2lnbmVkLW9m
Zi1ieTogRmxvcmEgQ3VpIDxmbG9yYS5jdWlAYW1kLmNvbTxtYWlsdG86ZmxvcmEuY3VpQGFtZC5j
b20+Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYyB8IDM4
ICsrKysrKysrKysrKysrKystLS0tLS0tLSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZrbXMuaCB8ICA1ICsrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyks
IDE1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZrbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21z
LmMNCmluZGV4IGNlOTgyYWZlZmY5MS4uNmM2MmM0NWUzZTNlIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuYw0KQEAgLTE2LDYgKzE2LDggQEANCiAjaW5jbHVkZSAi
aXZzcmNpZC9pdnNyY2lkX3Zpc2xhbmRzMzAuaCINCiAjaW5jbHVkZSAiYW1kZ3B1X3ZrbXMuaCIN
CiAjaW5jbHVkZSAiYW1kZ3B1X2Rpc3BsYXkuaCINCisjaW5jbHVkZSAiYXRvbS5oIg0KKyNpbmNs
dWRlICJhbWRncHVfaXJxLmgiDQoNCiAvKioNCiAgKiBET0M6IGFtZGdwdV92a21zDQpAQCAtNDEs
MTQgKzQzLDEzIEBAIHN0YXRpYyBjb25zdCB1MzIgYW1kZ3B1X3ZrbXNfZm9ybWF0c1tdID0gew0K
DQogc3RhdGljIGVudW0gaHJ0aW1lcl9yZXN0YXJ0IGFtZGdwdV92a21zX3ZibGFua19zaW11bGF0
ZShzdHJ1Y3QgaHJ0aW1lciAqdGltZXIpICB7DQotICAgICAgIHN0cnVjdCBhbWRncHVfdmttc19v
dXRwdXQgKm91dHB1dCA9IGNvbnRhaW5lcl9vZih0aW1lciwNCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdmttc19v
dXRwdXQsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2YmxhbmtfaHJ0aW1lcik7DQotICAgICAgIHN0cnVjdCBkcm1fY3J0YyAqY3J0YyA9
ICZvdXRwdXQtPmNydGM7DQorICAgICAgIHN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1X2NydGMg
PSBjb250YWluZXJfb2YodGltZXIsIHN0cnVjdCBhbWRncHVfY3J0YywgdmJsYW5rX3RpbWVyKTsN
CisgICAgICAgc3RydWN0IGRybV9jcnRjICpjcnRjID0gJmFtZGdwdV9jcnRjLT5iYXNlOw0KKyAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3ZrbXNfb3V0cHV0ICpvdXRwdXQgPQ0KK2RybV9jcnRjX3RvX2Ft
ZGdwdV92a21zX291dHB1dChjcnRjKTsNCiAgICAgICAgIHU2NCByZXRfb3ZlcnJ1bjsNCiAgICAg
ICAgIGJvb2wgcmV0Ow0KDQotICAgICAgIHJldF9vdmVycnVuID0gaHJ0aW1lcl9mb3J3YXJkX25v
dygmb3V0cHV0LT52YmxhbmtfaHJ0aW1lciwNCisgICAgICAgcmV0X292ZXJydW4gPSBocnRpbWVy
X2ZvcndhcmRfbm93KCZhbWRncHVfY3J0Yy0+dmJsYW5rX3RpbWVyLA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG91dHB1dC0+cGVyaW9kX25zKTsNCiAgICAgICAg
IFdBUk5fT04ocmV0X292ZXJydW4gIT0gMSk7DQoNCkBAIC02NSwyMiArNjYsMjEgQEAgc3RhdGlj
IGludCBhbWRncHVfdmttc19lbmFibGVfdmJsYW5rKHN0cnVjdCBkcm1fY3J0YyAqY3J0YykNCiAg
ICAgICAgIHVuc2lnbmVkIGludCBwaXBlID0gZHJtX2NydGNfaW5kZXgoY3J0Yyk7DQogICAgICAg
ICBzdHJ1Y3QgZHJtX3ZibGFua19jcnRjICp2YmxhbmsgPSAmZGV2LT52YmxhbmtbcGlwZV07DQog
ICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZrbXNfb3V0cHV0ICpvdXQgPSBkcm1fY3J0Y190b19hbWRn
cHVfdmttc19vdXRwdXQoY3J0Yyk7DQorICAgICAgIHN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1
X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRjKTsNCg0KICAgICAgICAgZHJtX2NhbGNfdGltZXN0
YW1waW5nX2NvbnN0YW50cyhjcnRjLCAmY3J0Yy0+bW9kZSk7DQoNCi0gICAgICAgaHJ0aW1lcl9p
bml0KCZvdXQtPnZibGFua19ocnRpbWVyLCBDTE9DS19NT05PVE9OSUMsIEhSVElNRVJfTU9ERV9S
RUwpOw0KLSAgICAgICBvdXQtPnZibGFua19ocnRpbWVyLmZ1bmN0aW9uID0gJmFtZGdwdV92a21z
X3ZibGFua19zaW11bGF0ZTsNCiAgICAgICAgIG91dC0+cGVyaW9kX25zID0ga3RpbWVfc2V0KDAs
IHZibGFuay0+ZnJhbWVkdXJfbnMpOw0KLSAgICAgICBocnRpbWVyX3N0YXJ0KCZvdXQtPnZibGFu
a19ocnRpbWVyLCBvdXQtPnBlcmlvZF9ucywgSFJUSU1FUl9NT0RFX1JFTCk7DQorICAgICAgIGhy
dGltZXJfc3RhcnQoJmFtZGdwdV9jcnRjLT52YmxhbmtfdGltZXIsIG91dC0+cGVyaW9kX25zLA0K
K0hSVElNRVJfTU9ERV9SRUwpOw0KDQogICAgICAgICByZXR1cm4gMDsNCiB9DQoNCiBzdGF0aWMg
dm9pZCBhbWRncHVfdmttc19kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgZHJtX2NydGMgKmNydGMpICB7
DQotICAgICAgIHN0cnVjdCBhbWRncHVfdmttc19vdXRwdXQgKm91dCA9IGRybV9jcnRjX3RvX2Ft
ZGdwdV92a21zX291dHB1dChjcnRjKTsNCisgICAgICAgc3RydWN0IGFtZGdwdV9jcnRjICphbWRn
cHVfY3J0YyA9IHRvX2FtZGdwdV9jcnRjKGNydGMpOw0KDQotICAgICAgIGhydGltZXJfY2FuY2Vs
KCZvdXQtPnZibGFua19ocnRpbWVyKTsNCisgICAgICAgaHJ0aW1lcl9jYW5jZWwoJmFtZGdwdV9j
cnRjLT52YmxhbmtfdGltZXIpOw0KIH0NCg0KIHN0YXRpYyBib29sIGFtZGdwdV92a21zX2dldF92
YmxhbmtfdGltZXN0YW1wKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywgQEAgLTkyLDEzICs5MiwxNCBA
QCBzdGF0aWMgYm9vbCBhbWRncHVfdmttc19nZXRfdmJsYW5rX3RpbWVzdGFtcChzdHJ1Y3QgZHJt
X2NydGMgKmNydGMsDQogICAgICAgICB1bnNpZ25lZCBpbnQgcGlwZSA9IGNydGMtPmluZGV4Ow0K
ICAgICAgICAgc3RydWN0IGFtZGdwdV92a21zX291dHB1dCAqb3V0cHV0ID0gZHJtX2NydGNfdG9f
YW1kZ3B1X3ZrbXNfb3V0cHV0KGNydGMpOw0KICAgICAgICAgc3RydWN0IGRybV92YmxhbmtfY3J0
YyAqdmJsYW5rID0gJmRldi0+dmJsYW5rW3BpcGVdOw0KKyAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Ny
dGMgKmFtZGdwdV9jcnRjID0gdG9fYW1kZ3B1X2NydGMoY3J0Yyk7DQoNCiAgICAgICAgIGlmICgh
UkVBRF9PTkNFKHZibGFuay0+ZW5hYmxlZCkpIHsNCiAgICAgICAgICAgICAgICAgKnZibGFua190
aW1lID0ga3RpbWVfZ2V0KCk7DQogICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KICAgICAg
ICAgfQ0KDQotICAgICAgICp2YmxhbmtfdGltZSA9IFJFQURfT05DRShvdXRwdXQtPnZibGFua19o
cnRpbWVyLm5vZGUuZXhwaXJlcyk7DQorICAgICAgICp2YmxhbmtfdGltZSA9IFJFQURfT05DRShh
bWRncHVfY3J0Yy0+dmJsYW5rX3RpbWVyLm5vZGUuZXhwaXJlcyk7DQoNCiAgICAgICAgIGlmIChX
QVJOX09OKCp2YmxhbmtfdGltZSA9PSB2YmxhbmstPnRpbWUpKQ0KICAgICAgICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCkBAIC0xNjUsNiArMTY2LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1f
Y3J0Y19oZWxwZXJfZnVuY3MgYW1kZ3B1X3ZrbXNfY3J0Y19oZWxwZXJfZnVuY3MgPSB7ICBzdGF0
aWMgaW50IGFtZGdwdV92a21zX2NydGNfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1
Y3QgZHJtX2NydGMgKmNydGMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJt
X3BsYW5lICpwcmltYXJ5LCBzdHJ1Y3QgZHJtX3BsYW5lICpjdXJzb3IpICB7DQorICAgICAgIHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3RvX2FkZXYoZGV2KTsNCisgICAgICAgc3Ry
dWN0IGFtZGdwdV9jcnRjICphbWRncHVfY3J0YyA9IHRvX2FtZGdwdV9jcnRjKGNydGMpOw0KICAg
ICAgICAgaW50IHJldDsNCg0KICAgICAgICAgcmV0ID0gZHJtX2NydGNfaW5pdF93aXRoX3BsYW5l
cyhkZXYsIGNydGMsIHByaW1hcnksIGN1cnNvciwgQEAgLTE3Niw2ICsxNzksMTcgQEAgc3RhdGlj
IGludCBhbWRncHVfdmttc19jcnRjX2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0
IGRybV9jcnRjICpjcnRjLA0KDQogICAgICAgICBkcm1fY3J0Y19oZWxwZXJfYWRkKGNydGMsICZh
bWRncHVfdmttc19jcnRjX2hlbHBlcl9mdW5jcyk7DQoNCisgICAgICAgYW1kZ3B1X2NydGMtPmNy
dGNfaWQgPSBkcm1fY3J0Y19pbmRleChjcnRjKTsNCisgICAgICAgYWRldi0+bW9kZV9pbmZvLmNy
dGNzW2RybV9jcnRjX2luZGV4KGNydGMpXSA9IGFtZGdwdV9jcnRjOw0KKw0KKyAgICAgICBhbWRn
cHVfY3J0Yy0+cGxsX2lkID0gQVRPTV9QUExMX0lOVkFMSUQ7DQorICAgICAgIGFtZGdwdV9jcnRj
LT5lbmNvZGVyID0gTlVMTDsNCisgICAgICAgYW1kZ3B1X2NydGMtPmNvbm5lY3RvciA9IE5VTEw7
DQorICAgICAgIGFtZGdwdV9jcnRjLT52c3luY190aW1lcl9lbmFibGVkID0gQU1ER1BVX0lSUV9T
VEFURV9ESVNBQkxFOw0KKw0KKyAgICAgICBocnRpbWVyX2luaXQoJmFtZGdwdV9jcnRjLT52Ymxh
bmtfdGltZXIsIENMT0NLX01PTk9UT05JQywgSFJUSU1FUl9NT0RFX1JFTCk7DQorICAgICAgIGFt
ZGdwdV9jcnRjLT52YmxhbmtfdGltZXIuZnVuY3Rpb24gPSAmYW1kZ3B1X3ZrbXNfdmJsYW5rX3Np
bXVsYXRlOw0KKw0KICAgICAgICAgcmV0dXJuIHJldDsNCiB9DQoNCkBAIC00MDEsNyArNDE1LDcg
QEAgaW50IGFtZGdwdV92a21zX291dHB1dF9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsICB7
DQogICAgICAgICBzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yID0gJm91dHB1dC0+Y29u
bmVjdG9yOw0KICAgICAgICAgc3RydWN0IGRybV9lbmNvZGVyICplbmNvZGVyID0gJm91dHB1dC0+
ZW5jb2RlcjsNCi0gICAgICAgc3RydWN0IGRybV9jcnRjICpjcnRjID0gJm91dHB1dC0+Y3J0YzsN
CisgICAgICAgc3RydWN0IGRybV9jcnRjICpjcnRjID0gJm91dHB1dC0+Y3J0Yy5iYXNlOw0KICAg
ICAgICAgc3RydWN0IGRybV9wbGFuZSAqcHJpbWFyeSwgKmN1cnNvciA9IE5VTEw7DQogICAgICAg
ICBpbnQgcmV0Ow0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZrbXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92a21zLmgNCmlu
ZGV4IDk3ZjFiNzljMDcyNC4uNGY4NzIyZmYzN2MyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZrbXMuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZrbXMuaA0KQEAgLTEwLDE1ICsxMCwxNCBAQA0KICNkZWZpbmUgWVJFU19N
QVggIDE2Mzg0DQoNCiAjZGVmaW5lIGRybV9jcnRjX3RvX2FtZGdwdV92a21zX291dHB1dCh0YXJn
ZXQpIFwNCi0gICAgICAgY29udGFpbmVyX29mKHRhcmdldCwgc3RydWN0IGFtZGdwdV92a21zX291
dHB1dCwgY3J0YykNCisgICAgICAgY29udGFpbmVyX29mKHRhcmdldCwgc3RydWN0IGFtZGdwdV92
a21zX291dHB1dCwgY3J0Yy5iYXNlKQ0KDQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBhbWRncHVfaXBf
YmxvY2tfdmVyc2lvbiBhbWRncHVfdmttc19pcF9ibG9jazsNCg0KIHN0cnVjdCBhbWRncHVfdmtt
c19vdXRwdXQgew0KLSAgICAgICBzdHJ1Y3QgZHJtX2NydGMgY3J0YzsNCisgICAgICAgc3RydWN0
IGFtZGdwdV9jcnRjIGNydGM7DQogICAgICAgICBzdHJ1Y3QgZHJtX2VuY29kZXIgZW5jb2RlcjsN
CiAgICAgICAgIHN0cnVjdCBkcm1fY29ubmVjdG9yIGNvbm5lY3RvcjsNCi0gICAgICAgc3RydWN0
IGhydGltZXIgdmJsYW5rX2hydGltZXI7DQogICAgICAgICBrdGltZV90IHBlcmlvZF9uczsNCiAg
ICAgICAgIHN0cnVjdCBkcm1fcGVuZGluZ192YmxhbmtfZXZlbnQgKmV2ZW50OyAgfTsNCi0tDQoy
LjI1LjENCg==

--_000_DM4PR12MB5118A3B5FE4D3271F5793057FA609DM4PR12MB5118namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:=CB=CE=CC=E5;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@=CB=CE=CC=E5";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Modprobe -r amdgpu get oops in amdgpu_vkms_sw_fini()=
<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;mode_info.num_crtc=
; i++)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mode_info.crtcs[i])<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_cancel(&amp;adev-&gt;=
mode_info.crtcs[i]-&gt;vblank_timer);<o:p></o:p></p>
<p class=3D"MsoNormal">adev-&gt;mode_info.crtcs[i]-&gt;vblank_timer is not =
initiated as vkms init its own amdgpu_vkms_output-&gt; vblank_hrtimer. This=
 patch drop amdgpu_vkms_output-&gt; vblank_hrtimer and try with adev-&gt;mo=
de_info.crtcs[i]-&gt;vblank_timer to keep align with
 amdgpu_dm &amp; dce_vx_0.c <o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> 2021<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=
=C4=EA</span>11<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=D4=
=C2</span>23<span lang=3D"ZH-CN" style=3D"font-family:=CB=CE=CC=E5">=C8=D5<=
/span> 0:43<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Cui, Flora &lt;Flora.C=
ui@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings<o:p><=
/o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Can you=
 explain how the current code is failing?&nbsp; It's not immediately obviou=
s to me.&nbsp; I'm not opposed to this change, it's just not clear to me wh=
ere the current code fails.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.=
com">Guchun.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, November 22, 2021 8:49 AM<br>
<b>To:</b> Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@am=
d.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings</span=
> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[Public]<br>
<br>
Series is:<br>
Reviewed-by: Guchun Chen &lt;<a href=3D"mailto:guchun.chen@amd.com">guchun.=
chen@amd.com</a>&gt;<br>
<br>
+Alex to comment this series as well.<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@amd.com=
</a>&gt; <br>
Sent: Monday, November 22, 2021 5:04 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a>; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun=
.Chen@amd.com</a>&gt;<br>
Cc: Cui, Flora &lt;<a href=3D"mailto:Flora.Cui@amd.com">Flora.Cui@amd.com</=
a>&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings<br>
<br>
otherwise adev-&gt;mode_info.crtcs[] is NULL<br>
<br>
Signed-off-by: Flora Cui &lt;<a href=3D"mailto:flora.cui@amd.com">flora.cui=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 38 ++++++++++++++++-------=
-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |&nbsp; 5 ++--<br>
&nbsp;2 files changed, 28 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.c<br>
index ce982afeff91..6c62c45e3e3e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c<br>
@@ -16,6 +16,8 @@<br>
&nbsp;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&nbsp;#include &quot;amdgpu_vkms.h&quot;<br>
&nbsp;#include &quot;amdgpu_display.h&quot;<br>
+#include &quot;atom.h&quot;<br>
+#include &quot;amdgpu_irq.h&quot;<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * DOC: amdgpu_vkms<br>
@@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] =3D {<br>
&nbsp;<br>
&nbsp;static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtime=
r *timer)&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output *output =3D=
 container_of(timer,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_hrtimer);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;output=
-&gt;crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D c=
ontainer_of(timer, struct amdgpu_crtc, vblank_timer);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;amdgpu=
_crtc-&gt;base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output *output =3D=
 <br>
+drm_crtc_to_amdgpu_vkms_output(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 ret_overrun;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_overrun =3D hrtimer_forward_now(&=
amp;output-&gt;vblank_hrtimer,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_overrun =3D hrtimer_forward_now(&=
amp;amdgpu_crtc-&gt;vblank_timer,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; output-&gt;period_ns);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(ret_overrun !=3D 1=
);<br>
&nbsp;<br>
@@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc *c=
rtc)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pipe =3D drm_=
crtc_index(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_vblank_crtc *vb=
lank =3D &amp;dev-&gt;vblank[pipe];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output =
*out =3D drm_crtc_to_amdgpu_vkms_output(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_calc_timestamping_cons=
tants(crtc, &amp;crtc-&gt;mode);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_init(&amp;out-&gt;vblank_hrti=
mer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;vblank_hrtimer.function =3D &=
amp;amdgpu_vkms_vblank_simulate;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out-&gt;period_ns =3D ktim=
e_set(0, vblank-&gt;framedur_ns);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_start(&amp;out-&gt;vblank_hrt=
imer, out-&gt;period_ns, HRTIMER_MODE_REL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_start(&amp;amdgpu_crtc-&gt;vb=
lank_timer, out-&gt;period_ns, <br>
+HRTIMER_MODE_REL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)&nbsp; {=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output *out =3D dr=
m_crtc_to_amdgpu_vkms_output(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_cancel(&amp;out-&gt;vblank_hr=
timer);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_cancel(&amp;amdgpu_crtc-&gt;v=
blank_timer);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc, @=
@ -92,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_=
crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int pipe =3D crtc=
-&gt;index;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vkms_output =
*output =3D drm_crtc_to_amdgpu_vkms_output(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_vblank_crtc *vb=
lank =3D &amp;dev-&gt;vblank[pipe];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!READ_ONCE(vblank-&gt;=
enabled)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *vblank_time =3D ktime_get();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vblank_time =3D READ_ONCE(output-&gt=
;vblank_hrtimer.node.expires);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *vblank_time =3D READ_ONCE(amdgpu_crt=
c-&gt;vblank_timer.node.expires);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(*vblank_time =
=3D=3D vblank-&gt;time))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms_c=
rtc_helper_funcs =3D {&nbsp; static int amdgpu_vkms_crtc_init(struct drm_de=
vice *dev, struct drm_crtc *crtc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; struct drm_plane *primary, struct drm_plane *cursor)&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to=
_adev(dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc *amdgpu_crtc =3D t=
o_amdgpu_crtc(crtc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_crtc_init_with=
_planes(dev, crtc, primary, cursor, @@ -176,6 +179,17 @@ static int amdgpu_=
vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_crtc_helper_add(crtc, =
&amp;amdgpu_vkms_crtc_helper_funcs);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;crtc_id =3D drm_crtc_=
index(crtc);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.crtcs[drm_crtc_ind=
ex(crtc)] =3D amdgpu_crtc;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;pll_id =3D ATOM_PPLL_=
INVALID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;encoder =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;connector =3D NULL;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;vsync_timer_enabled =
=3D AMDGPU_IRQ_STATE_DISABLE;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_init(&amp;amdgpu_crtc-&gt;vbl=
ank_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_crtc-&gt;vblank_timer.function=
 =3D &amp;amdgpu_vkms_vblank_simulate;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,&nbs=
p; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *conn=
ector =3D &amp;output-&gt;connector;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_encoder *encode=
r =3D &amp;output-&gt;encoder;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;output=
-&gt;crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc *crtc =3D &amp;output=
-&gt;crtc.base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_plane *primary,=
 *cursor =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vkms.h<br>
index 97f1b79c0724..4f8722ff37c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h<br>
@@ -10,15 +10,14 @@<br>
&nbsp;#define YRES_MAX&nbsp; 16384<br>
&nbsp;<br>
&nbsp;#define drm_crtc_to_amdgpu_vkms_output(target) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(target, struct amdgpu_vk=
ms_output, crtc)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(target, struct amdgpu_vk=
ms_output, crtc.base)<br>
&nbsp;<br>
&nbsp;extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;<br>
&nbsp;<br>
&nbsp;struct amdgpu_vkms_output {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_crtc crtc;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_crtc crtc;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_encoder encoder=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector conne=
ctor;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hrtimer vblank_hrtimer;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t period_ns;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_pending_vblank_=
event *event;&nbsp; };<br>
--<br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5118A3B5FE4D3271F5793057FA609DM4PR12MB5118namp_--
