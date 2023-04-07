Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DEC761A6
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 03:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D8D110E14B;
	Fri,  7 Apr 2023 03:20:33 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3029D10E14B
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 03:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbOnLy4rBS4TlxflFuoPe16qrzw0feHisGmx3zvPQTxRAyY/w2CxDpCyGUYtG2svrISbMxzLz1B1ZsRrTUDOlXRxdnAMSAybklr8JfjZEPrZ/6greTNIugg4FJHcBTcsdie1LywzsCwlDKxi2FCctFtOckETMtpbsZG6z4V0gOa9KR2N9420G5PN8UW4W1JpQ9Naowow81HLc22uO4+MKYBev9J+v6EdGQGiTN2GBmelhH6oubpr0XdT6NHi4H5CfmmhES12pjXED10jPXVxzi4Ae43W++oRiT5Mkx+ENlnqFVLZydUk1DmS99it3FZHLQYZ5J4zDq3yBOxrjbA20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsFwjgFXrCUf8XyTP93c4SDBbMIrokamyl07CLQSe5Y=;
 b=cIsuRfpd5vHdx9b2XCtSQgLcFgpPgTVPKOYc0xqcFjj3QwYhEGRDhMQnc9+/W+PBzoG5mJUsNC1Gr71fIGx7Ws+/xutMl9o7Zmd6CXPFqQBuK4JRiogY2cNJJahlwGasHrbgE/dEVL/PRkit2yYUhLbpk4KU71YcXTCH45CB3fgS4xQGKfMfc0qxi7pJVg53NU3Ne1qx34LA0q0DV/5ZoPOwKNUruDebUFRs0U9r2TxzBKV7i+AkAb4dFLATujQhk7hOfvthaIrtZZIDiRH2JmI9W5UmK5ziPM/tO2R3BUfeOiMtKeVvDCh6pnZyTd1+Ipl4DsbV1PnpfStUYC3aIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsFwjgFXrCUf8XyTP93c4SDBbMIrokamyl07CLQSe5Y=;
 b=tEWy5qNKNFsE6YRjVR+vnKVhDqXxVD9wK1pIwHV1MgbbqDImX6TjXjFSZKaIiS0IabsZM9kZwjq1qGVfzagM8oyQooooL4Di4PlNmeSYpLmINO6KuVk3sKMusUCWWFFkMvF2l/Yw0E8GbKs/Rx2WokhE7km2jyeqN8dGZ/zY8eg=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 03:20:29 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::3e72:eac:4e50:d003]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::3e72:eac:4e50:d003%4]) with mapi id 15.20.6277.030; Fri, 7 Apr 2023
 03:20:28 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH v5 1/2] drm/amd/pm: Add support to check SMT state
 periodically
Thread-Topic: [PATCH v5 1/2] drm/amd/pm: Add support to check SMT state
 periodically
Thread-Index: AQHZaIWuHR1ZCyyBdE6QKY0Uzjzcj68eUZmAgADc86A=
Date: Fri, 7 Apr 2023 03:20:28 +0000
Message-ID: <DM6PR12MB35318CDCA382E72825C8F8E9FD969@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230406124514.2906870-1-WenYou.Yang@amd.com>
 <20230406124514.2906870-2-WenYou.Yang@amd.com>
 <005a0f80-d009-79e1-c019-58ef63692eca@amd.com>
In-Reply-To: <005a0f80-d009-79e1-c019-58ef63692eca@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-07T03:20:26Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d3ccc15f-7075-4fec-a00b-48f6444366d9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|DM6PR12MB4909:EE_
x-ms-office365-filtering-correlation-id: e68abac6-3dfa-4573-3318-08db37170965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+VQ3aZrJ5BAgkUGqfJfkPYm1knT8QNUxmI/2Vt4ZDij5Qcj9SxQ1UGfNZjbfP3hp3cY7svqRSk1I/QXd0pVa868OYOZpUv3ZLZX8FPKJ4HvOO7eS1zJMiNXZrPFIIsQjQG3RdfZ++14hXER4BzUNyoaSwQA2oiidnIjnUmCza1mTY6e/jbl20ouCTbnc4xXcxRJXl/hXJ8igeV0LKhte4ESj7vIo2NivWTB09WOE2rHoX2puHOIDXvO9ZV0c7dDyLE63Ij1GvnmbdGhnC/7fZ470BAvvtdP6Yk/bGvjXhzB93kimmZ+58vUwFx08I2fq2I4eMx7+RqWsLeVANQibYnBB44YbYFqSP45a4XcqQn6N0sLO/snJKB+dwL37nnZZoN1zUzm/rVj0uPjdP0Rwt5plDCOat48ZylP28bFaNA7dcJXgxXrquFkyxuoc28ig9xrw/xivnPindJ8vVGK/BhNqR7UC3Pj56VHYCa10BpQ132SX9eJhxLxvAZiKCMSiPcEDJy2fhEqVOXWkQaVbzNpx4mpY07diDXezr3WXYncra1Kmjl9AqVATM4U96IPM9uMo3JHAbitYOcmOS7jyMfkNF2HEq0VcWNlvTeR/5bYiiE8KjsLvAqN68Q9gkK7g8TQHAg+1GqNV4VDoSsZvQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(7696005)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(54906003)(6636002)(478600001)(71200400001)(66946007)(41300700001)(76116006)(110136005)(316002)(86362001)(33656002)(83380400001)(6506007)(9686003)(53546011)(26005)(52536014)(2906002)(5660300002)(8936002)(55016003)(38100700002)(921005)(186003)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkJSaHpWaEtMcFdHYkpYVFhUOVZhYitta0g0dVc2bU5teUk1U3ZUd0tITnRD?=
 =?utf-8?B?Rk82MDcwbmlPd0RzaS9nSnd2b2RBM0JBNnFUQnJGaEhjRFM4dEV6enBQOU1I?=
 =?utf-8?B?aTVtVW9YNGNOU2ZndWFwWmpEblYzZlptTjZRbkVnMUhpS3pJbDdwVUpGTWd0?=
 =?utf-8?B?RnRpWURQK25HSzNjQzM0b1RidFBlcXhGM3dIWTBWcFhDMUZDWHNrdk41S1F5?=
 =?utf-8?B?MXF0K3IxVXJha0RJY3NKdE5aNml6ZWpwY1JFL1lNTmZielY5QnJSRGlaMVB5?=
 =?utf-8?B?RURWakx0N1lSMTJnVVVWUXdxMWpDVU1QSHRWTzR1cndDRG0zMVliUHhYb082?=
 =?utf-8?B?M2RkN2wzdWMrM05Ed2trTnNlMEZnM3c3WWpYc1VVYWVvbzNtTW9RUEhORFdq?=
 =?utf-8?B?a2R2b3p1d1RETCtxSTlaVmcvNnVQUWVHUElOaXVUUnZ6NHNQOU9OQTNyN0Q3?=
 =?utf-8?B?THJpSDk4RlErRlArcWVpUk4vVWZEQkFVcHBkQlRLcXZhaVdTbFlFMDhRQmVY?=
 =?utf-8?B?OUhRTkRtRHZzYmhVTHlNL1luWEZYTm5MNUhIZDhaM1hFM0RFdjNCR0ZnKzE3?=
 =?utf-8?B?ZXZ5M2pWQWcrTGRDU0puZGIwdDJ6S05HSThLd1l2ckZGNVlzRW1SOGpzQ0V2?=
 =?utf-8?B?KzVISGlOenhTT0hHRU5CQ2tnL2ZGZjJhcjFCSVlEZVdSUkYvZkg2Q2lsTmRI?=
 =?utf-8?B?NXdGT2daVTRjbmdhbTdmYmF2cFpJZytBSTNsZTM2M0UxOGlVbitUZTB5S2ZM?=
 =?utf-8?B?ZUhBaEJoSXdPNFh3MUVpQ2VLRmdvU1JWT2pzVmNYK2pMSUl4bWRNNEE1Rk9x?=
 =?utf-8?B?SXd0Y3I5TmhFdkVvbVZPcmVGYzhKR25iTEJSQkdkMzVHOUptZkVUemdQNDh3?=
 =?utf-8?B?Qm11OHAwSmRzYWRVR3pYZklTaVB1TDBYMndXbW5DRVA3Z1Vid1JxVG9IMXJ4?=
 =?utf-8?B?UGZQWG9QdldCNEcyUVVjajZjU3JzbERQMTRRVHBjN2pmM3AwRmsrUjdobkFI?=
 =?utf-8?B?aEFqMXNKcVppMHJrZ0NGei9FQ1ZBbjVTeU8rSzZsRytDdy9Hbk5RZmN0dDM2?=
 =?utf-8?B?T21mbjdIN0daekNSY0dsbGdXQ2p5SHVkN2ZwcW1VSVlxTDVMTW5YenJZY0Fs?=
 =?utf-8?B?YmpMeDVvdS9xNnIxMHdDakZscmpzV04zVEkxVXpELzFnWTdocldYTFMydnF3?=
 =?utf-8?B?ZDFkMUk3SWI5Q2cycHJVT0tRTEFXWWtGQldoOHdNaTN5WFovaGpkRmgzSmVu?=
 =?utf-8?B?NUxTS3dueU00bi8xRWJ0bmQrTTQ5MDFkcjQzV2NFWEc3UHdzUXhMM0hjc0RD?=
 =?utf-8?B?OXZKSTVNMWRrMnVpZElKdWZHRHJOY01CVTM3WUVPSEhJSklwM3QvMnFzQ2Rs?=
 =?utf-8?B?bkk0dndBOUE1bUIwY3VJUWJ5Ky9MUkluRXgrc0J5ZWt5bHkxbzk3aEpoeGZ2?=
 =?utf-8?B?NG5vaEhxUlhEVVhPU1JEUU5IVWQwVjh0UkpuZWlpMURVTVRRUElmU2xxVFRl?=
 =?utf-8?B?N1ZabUt1Y3lLazhNc1hFNHNBYVlhU1o5SmZ6b09OYmNEMzNlNFdsZHoxeVVw?=
 =?utf-8?B?M05PMlU3YlozR05VbzRMSHBPaFRRN3JYM3Jya0pBSktnOEJEamJFMVpJR2xP?=
 =?utf-8?B?aVJDTk44VnYrQ2dSRzZ0WGFodC9tVWhmQXNFeURsUEIvTWpMR1FMd0ZKSk1o?=
 =?utf-8?B?RmlPVFJNY0FxTGd3OVZ2eFkzUko1clNQN3NwcnZZT0IwS0MrQXdVV1liTmdP?=
 =?utf-8?B?ZlBDa1Y0a3ZsSzV6Y2ZMS1VVTHk2SXEyVzhhWHF1UkFLRWRUQzdSU3dBRGxO?=
 =?utf-8?B?UDlwUVdaOW1hcGlwUmdheG5WWVhJcEVFdW5tVDA4c2VRSFFHaXNzSDVTTXRC?=
 =?utf-8?B?NncvbGJFNUxVVnhkSGcwQlFzOUdLRHlsbmFkakQ0eThleGswSGRyMG53WDEr?=
 =?utf-8?B?bGUvKzUwY0tYdHRORFBTZFV6MFJHWmhURzRta2N5S1NXcGc1SndLR090UFU5?=
 =?utf-8?B?K0tJSTBPYkNWeWViK1l4NjBjTmFyWDNONHpzaHNWNSsvN3gxRmdkbFdiUW16?=
 =?utf-8?B?Yjk5Nmg0ZTdGaHRlM25kaHUwOGQxZWg2NGplejJrTEJidTFLSjU0RXNiWWJR?=
 =?utf-8?Q?NCWU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68abac6-3dfa-4573-3318-08db37170965
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 03:20:28.4093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82bIUIc3mT26HptThn5kjAsM4dOt1Il5kAD5/GvChOVkEq7FeTfMJv90G1z3+LB7maCwpC7ZE8uJ98Ho+8z6cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
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
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Ying" <YING.LI@amd.com>, "Liang, Richard qi" <Richardqi.Liang@amd.com>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLA0KDQpUaGFuayB5
b3UgIGZvciB5b3VyIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBBcHJpbCA2LCAyMDIzIDEwOjA5IFBNDQo+IFRvOiBZYW5nLCBXZW5Zb3Ug
PFdlbllvdS5ZYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT47IFF1YW4sDQo+IEV2YW4g
PEV2YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNv
bT47IExpYW5nLCBSaWNoYXJkIHFpDQo+IDxSaWNoYXJkcWkuTGlhbmdAYW1kLmNvbT47IExpLCBZ
aW5nIDxZSU5HLkxJQGFtZC5jb20+OyBMaXUsIEt1bg0KPiA8S3VuLkxpdTJAYW1kLmNvbT47IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMS8y
XSBkcm0vYW1kL3BtOiBBZGQgc3VwcG9ydCB0byBjaGVjayBTTVQgc3RhdGUNCj4gcGVyaW9kaWNh
bGx5DQo+IA0KPiBPbiA0LzYvMjAyMyAwNzo0NSwgV2VueW91IFlhbmcgd3JvdGU6DQo+ID4gQWRk
IGEgdGltZXIgdG8gcG9sbCB0aGUgU01UIHN0YXRlIHBlcmlvZGljYWxseSwgaWYgdGhlIFNNVCBz
dGF0ZSBpcw0KPiA+IGNoYW5nZWQsIGludm9rZSB0aGUgaW50ZXJmYWNlIHRvIG5vdGlmeSB0aGUg
UE1GVy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbnlvdSBZYW5nIDxXZW5Zb3UuWWFuZ0Bh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMv
YW1kZ3B1X3NtdS5oIHwgIDggKysrKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXVfY21uLmMgICAgICAgIHwgNDQNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmggICAgICAgIHwgIDUgKysrDQo+ID4g
ICAzIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+IGluZGV4IDA5
NDY5Yzc1MGE5Ni4uZmM1NzFjMTIyZTg3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+IEBAIC01NjYsNiArNTY2LDkgQEAg
c3RydWN0IHNtdV9jb250ZXh0DQo+ID4NCj4gPiAgIAlzdHJ1Y3QgZmlybXdhcmUgcHB0YWJsZV9m
aXJtd2FyZTsNCj4gPg0KPiA+ICsJYm9vbCBsYXN0X3NtdF9hY3RpdmU7DQo+ID4gKwlzdHJ1Y3Qg
dGltZXJfbGlzdCBzbXRfdGltZXI7DQo+ID4gKw0KPiA+ICAgCXUzMiBwYXJhbV9yZWc7DQo+ID4g
ICAJdTMyIG1zZ19yZWc7DQo+ID4gICAJdTMyIHJlc3BfcmVnOw0KPiA+IEBAIC0xMzU0LDYgKzEz
NTcsMTEgQEAgc3RydWN0IHBwdGFibGVfZnVuY3Mgew0KPiA+ICAgCSAqIEBpbml0X3BwdGFibGVf
bWljcm9jb2RlOiBQcmVwYXJlIHRoZSBwcHRhYmxlIG1pY3JvY29kZSB0bw0KPiB1cGxvYWQgdmlh
IFBTUA0KPiA+ICAgCSAqLw0KPiA+ICAgCWludCAoKmluaXRfcHB0YWJsZV9taWNyb2NvZGUpKHN0
cnVjdCBzbXVfY29udGV4dCAqc211KTsNCj4gPiArDQo+ID4gKwkvKioNCj4gPiArCSAqIEBzZXRf
Y3B1X3NtdF9lbmFibGU6IFNldCB0aGUgQ1BVIFNNVCBzdGF0dXMuDQo+ID4gKwkgKi8NCj4gPiAr
CWludCAoKnNldF9jcHVfc210X2VuYWJsZSkoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wN
Cj4gc210X2VuYWJsZSk7DQo+ID4gICB9Ow0KPiA+DQo+ID4gICB0eXBlZGVmIGVudW0gew0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmMNCj4gPiBpbmRleCAzZWNi
OTAwZTZlY2QuLmIwZTBjNjY2NGFjMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdV9jbW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
c3dzbXUvc211X2Ntbi5jDQo+ID4gQEAgLTI2LDYgKzI2LDcgQEANCj4gPiAgICNpbmNsdWRlICJh
bWRncHVfc211LmgiDQo+ID4gICAjaW5jbHVkZSAic211X2Ntbi5oIg0KPiA+ICAgI2luY2x1ZGUg
InNvYzE1X2NvbW1vbi5oIg0KPiA+ICsjaW5jbHVkZSA8bGludXgvc2NoZWQvc210Lmg+DQo+ID4N
Cj4gPiAgIC8qDQo+ID4gICAgKiBETyBOT1QgdXNlIHRoZXNlIGZvciBlcnIvd2Fybi9pbmZvL2Rl
YnVnIG1lc3NhZ2VzLg0KPiA+IEBAIC0xMDU4LDMgKzEwNTksNDYgQEAgYm9vbCBzbXVfY21uX2lz
X2F1ZGlvX2Z1bmNfZW5hYmxlZChzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+
DQo+ID4gICAJcmV0dXJuIHNuZF9kcml2ZXJfbG9hZGVkOw0KPiA+ICAgfQ0KPiA+ICsNCj4gPiAr
I2RlZmluZSBUSU1FX0lOVEVSVkFMCTIwMA0KPiA+ICsNCj4gPiArc3RhdGljIGludCBzbXVfc2V0
X2NwdV9zbXRfZW5hYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29sDQo+ID4gK2VuYWJs
ZSkgew0KPiA+ICsJaW50IHJldCA9IC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJaWYgKHNtdS0+cHB0
X2Z1bmNzICYmIHNtdS0+cHB0X2Z1bmNzLT5zZXRfY3B1X3NtdF9lbmFibGUpDQo+ID4gKwkJcmV0
ID0gc211LT5wcHRfZnVuY3MtPnNldF9jcHVfc210X2VuYWJsZShzbXUsIGVuYWJsZSk7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgc211
X3NtdF90aW1lcl9jYWxsYmFjayhzdHJ1Y3QgdGltZXJfbGlzdCAqdGltZXIpIHsNCj4gPiArCXN0
cnVjdCBzbXVfY29udGV4dCAqc211ID0gY29udGFpbmVyX29mKHRpbWVyLA0KPiA+ICsJCQkJCSAg
ICAgICBzdHJ1Y3Qgc211X2NvbnRleHQsIHNtdF90aW1lcik7DQo+ID4gKwlib29sIHNtdF9hY3Rp
dmU7DQo+ID4gKw0KPiA+ICsJc210X2FjdGl2ZSA9IHNjaGVkX3NtdF9hY3RpdmUoKTsNCj4gPiAr
CWlmIChzbXRfYWN0aXZlICE9IHNtdS0+bGFzdF9zbXRfYWN0aXZlKSB7DQo+ID4gKwkJc211LT5s
YXN0X3NtdF9hY3RpdmUgPSBzbXRfYWN0aXZlOw0KPiA+ICsJCXNtdV9zZXRfY3B1X3NtdF9lbmFi
bGUoc211LCBzbXRfYWN0aXZlKTsNCj4gDQo+IFlvdSdyZSBpZ25vcmluZyB0aGUgcmV0dXJuIHZh
bHVlIGZvciBzbXVfc2V0X2NwdV9zbXRfZW5hYmxlLiAgSWYgdGhlDQo+IG1lc3NhZ2UgZmFpbGVk
IHRvIHNlbmQgdGhhdCBtZWFucyBzbXUtPmxhc3Rfc210X2FjdGl2ZSB3aWxsIGhhdmUgdGhlDQo+
IHdyb25nIHZhbHVlIGFuZCB0aGUgbWVzc2FnZSB3aWxsIG5ldmVyIGF0dGVtcHQgdG8gc2VuZCBh
Z2FpbiB3aGlsZSBpbiB0aGlzDQo+IFNNVCBzdGF0ZSBldmVuIHRob3VnaCB0aGUgdGltZXIgdHJp
Z2dlcmVkIGFnYWluLg0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIGRvIGl0IGxpa2UgdGhpczoN
Cj4gDQo+IGlmICghc211X3NldF9jcHVfc210X2VuYWJsZShzbXUsIHNtdF9hY3RpdmUpKQ0KPiAJ
c211LT5sYXN0X3NtdF9hY3RpdmUgPSBzbXRfYWN0aXZlOw0KPiANCg0KWWVzLiBXaWxsIGNoYW5n
ZSBpbiBuZXh0IHZlcnNpb24uDQoNCj4gPiArCX0NCj4gPiArDQo+ID4gKwltb2RfdGltZXIodGlt
ZXIsIGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKFRJTUVfSU5URVJWQUwpKTsgfQ0KPiA+ICsN
Cj4gPiArdm9pZCBzbXVfc210X3RpbWVyX2luaXQoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUpIHsN
Cj4gPiArCXN0cnVjdCB0aW1lcl9saXN0ICp0aW1lciA9ICZzbXUtPnNtdF90aW1lcjsNCj4gPiAr
DQo+ID4gKwlzbXUtPmxhc3Rfc210X2FjdGl2ZSA9IHNjaGVkX3NtdF9hY3RpdmUoKTsNCj4gPiAr
DQo+ID4gKwl0aW1lcl9zZXR1cCh0aW1lciwgc211X3NtdF90aW1lcl9jYWxsYmFjaywgMCk7DQo+
ID4gKw0KPiA+ICsJbW9kX3RpbWVyKHRpbWVyLCBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcyhU
SU1FX0lOVEVSVkFMKSk7IH0NCj4gPiArDQo+ID4gK3ZvaWQgc211X3NtdF90aW1lcl9maW5pKHN0
cnVjdCBzbXVfY29udGV4dCAqc211KSB7DQo+ID4gKwlkZWxfdGltZXIoJnNtdS0+c210X3RpbWVy
KTsNCj4gPiArfQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdV9jbW4uaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXVfY21uLmgN
Cj4gPiBpbmRleCBkN2NkMzU4YTUzYmQuLjkyOGRkOWUzMGQ4MyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdV9jbW4uaA0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211X2Ntbi5oDQo+ID4gQEAgLTEyNyw1ICsxMjcsMTAgQEAg
c3RhdGljIGlubGluZSB2b2lkIHNtdV9jbW5fZ2V0X3N5c2ZzX2J1ZihjaGFyDQo+ID4gKipidWYs
IGludCAqb2Zmc2V0KQ0KPiA+DQo+ID4gICBib29sIHNtdV9jbW5faXNfYXVkaW9fZnVuY19lbmFi
bGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsNCj4gPg0KPiA+ICt2b2lkIHNtdV9zbXRf
dGltZXJfaW5pdChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7DQo+ID4gKw0KPiA+ICAgI2VuZGlm
DQo+ID4gKw0KPiA+ICt2b2lkIHNtdV9zbXRfdGltZXJfZmluaShzdHJ1Y3Qgc211X2NvbnRleHQg
KnNtdSk7DQo+ID4gKw0KPiA+ICAgI2VuZGlmDQo=
