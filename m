Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD242C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD87C10F62E;
	Sat, 16 Jul 2022 14:35:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E0A10E2AB
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 15:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCmt9FqAKUfyP7B+hfwRpNR2pA/W7iXlGyNxzQViGjKUrzFvI7qlxTETcWSW29ajurBmwwmx3Rwh+6eXP8mi/Y5YhMl9MJClYe5zqQ0Thc+xYnu/RAihz+7yt7V74gVLX4pG4QkyAZ9++hLaJ2VeCQhe9hSxDZJKXzhWBhnc8/UsPpzickwjlLFOJZHqTk0CTw1Ln8fn+lSKZfFWq3GZzAfHoq9DYg8YoS0GnAFkavZzg1mAsDMbv+CQxiw/eVzJNWBUiQz2ghBMHRoKypsoGKvvam0SnhMFnrl0qQCvzs/azmPIYTEgwk2mdnsmC9XPZjw8hV+XbY4rUEXxGMQ7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QltEuVbixzfKPDVjxd/iSAAyH52wb2cYGFl1S616HHM=;
 b=C2HzGCx6YJNBNiTKffrtZRwlRL872KepFoVWWVpZD/yYowyIghWgGrXUYtk6zg9j/gRCffwZCYB9VaHmJ1gqmwMK+f0Aeg40GjtWV0tZQXpfbv9CM5ZaAgHwM+bMMr5Zf2YI5RgyM+kKzefhAnT19UtyxKGHtCL81R9t2/lNI+eeQ+G+XnfY5ilxjMJtU/0loh8l+HRos2EfmfmtnZ0NhllZume+FNgw6qM3reKVcg+uH+in5Zy+TV8XMIWOvoTRr5bu6xeeCVlgAVmWcwcWW3ZvgpZrKwqMIP9Lw/XXpUUjmMa2+xeE+WkpcnIAb6oWmCiy/EfoRS5Vgwi3+IQMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QltEuVbixzfKPDVjxd/iSAAyH52wb2cYGFl1S616HHM=;
 b=vd30cPmqu2WXSKFkUlhtBn66/bMep0ZYikdLL7pgUuKlOrBTzfhEIjBWHWNvmBiZxj/ZBw4pFIG7bvcIESDBtd/m3nf5ejiBPXew2koSuNWD27/MSKlG9ZB/+3j0FM/+DFMLyPHiQEjqiXIVASmsWovLTRpcXRQcx8Wvh6CminI=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DM6PR12MB4716.namprd12.prod.outlook.com (2603:10b6:5:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 15:25:10 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 15:25:09 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Topic: [PATCH v2] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Index: AQHYmFl7skXeHK5nJkKo9mxJ8Z5/mK1/i4MAgAAAi6A=
Date: Fri, 15 Jul 2022 15:25:09 +0000
Message-ID: <SJ1PR12MB61944BB1E94EA522B4BD67F8958B9@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20220715144453.46786-1-ruijing.dong@amd.com>
 <c06f6582-46aa-9abb-5094-f027cf01c1c6@amd.com>
In-Reply-To: <c06f6582-46aa-9abb-5094-f027cf01c1c6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=30a967ba-ad82-4911-8842-bca23a8223cd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T15:20:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 453aac81-53f5-4875-a734-08da66763485
x-ms-traffictypediagnostic: DM6PR12MB4716:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpH13DZJOuQ6kyS2E9euPa+nTFUkoRn2VfXBDE4PVoucOIkfkW+DFlMzf2vp/yg5blMsq2dxiNiNo+8kIWNhlgBFVXvsmEt++BtT/caz3BogjN7m92nlSyVRaZRSVz6VoOuY6P/fg4Yl9OikRHWHfyvK/xo+SDwjL3RmDO/6yhOUS6nL/VrFx2BxWvJ9rl5wRWAB1Py4nMkj6aF3TfoPfIL4hlBnAIyNyuOz22mAAXppCG/K85e3f0jtQ0TO7kX2YOKuYECUfQ4sf3xx4LYz3fH3G9R5Mjls0T3tQRH6MIn4jwDSLBvkNqjjYfgZ4VAC4SKY+335V6V5JgSW8BTLU4fNslODXLW1fQFY6QdexjesdwxTJXM7LIiUFcE1BtMS8shM5CFtl2LfZEAx9R6f+IY4y7Xh9KH1S/F1EHe37nOJIkgO0wGV7og5DILUidyT5OPDFbukP0Lf1vSs5uDNzQt83bhCZgWiRfRhLh0Zqm1Y8WfppNUZRe5VR+Y6UYZ35uAPO8iY+gEY+R4+1q5lWZflhCAe4gtfkLR/DCJ0+fsm85JzVlJukmGJWkojGZcXIRL5oQOX8kbVdThApPBpqtFJAaQM7dQZWccI7ObqaV7Ir1eTxoiLrWVAJOAIkQhp+QcQac5AKQpCjXzi8+RDr/rrbT4kMFzhuxLsY4hzG5S8AnKqX/6B8GEThTp5wSkIDLU8YsJFuPbAzf1cB4eeAexnsEbQArKvmulaK0Li+5CH6812HVIg62euq0V2Ail2U5pIAy1oblVI+bA9ILD9uQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(86362001)(71200400001)(33656002)(478600001)(26005)(41300700001)(64756008)(2906002)(966005)(38100700002)(53546011)(7696005)(6506007)(55016003)(54906003)(5660300002)(186003)(9686003)(8676002)(66446008)(66476007)(4326008)(122000001)(110136005)(76116006)(66946007)(66556008)(52536014)(83380400001)(8936002)(316002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T00vV00wOUt6OEp2V3Y0UDZ6Ritza2VSbzZ0ZWhCcncxUThDNzlmTUlJZFBh?=
 =?utf-8?B?T1FZb0RKamJmZTdHRGVzVHRpQk5ZbW8yRlhFYjJuK1lESGhZTjByWGtVOUl5?=
 =?utf-8?B?d1FKVmh0SVhjR2ZlZExGR09abDZ2SlJhZm5SL2YwcWhOaU9JMzNETWlBKzFh?=
 =?utf-8?B?MXhPYVREbVU0N0xLNEQ1bmtsMVJRMmhXTHVDcGZLUnVMaEFjRVZCaDkxQU54?=
 =?utf-8?B?YUI5TU1NQWwyUmc4VURqT3RKRHBQSWRwRWZ4QXFnbGtxamhMNjk4UWdTNGp6?=
 =?utf-8?B?WmtkSzIzQkREdURkUzZvVXZlbTdyTnZlaWxHNExVaWxXQVg1THcwSW5wdjFL?=
 =?utf-8?B?QmZaSDQ4S05sbWtId0E3NUVsV01ya0V2Ky95WU9kR1AzWGIzMEZoV0hnMU9x?=
 =?utf-8?B?emFaZlFpOUkyaS94dmpUb3ZUakJFUnc1Y2xJR2JyZ3ZTZktiTHhSbSs2U3lF?=
 =?utf-8?B?V3UvUHpMcEFVZFNjU3VXd3pHZmM1cnpmckRtbWltc1d1WmJsaGlYNjdWN29W?=
 =?utf-8?B?YWRvd0lGSzNaa2E1UEdEOTJJdXFJa3E2WVRkRHhLcXhiL3k3ZENzRUUzVjBj?=
 =?utf-8?B?TENLb2pGQmpZRjFEM2ZTKzNZQ3orZTYwS2dlUDZTSGRPeG9lbzN5L3QrUGpp?=
 =?utf-8?B?RFFYYUpvNTh4bEd1UFBka29nUngvZzE3NmJBVWVuOElYMG9EamtzMC9QaFFO?=
 =?utf-8?B?YlBhOWdkbmtzTmN3Z25hdEY4WmswOWpXd0MvVGVuenhXa1NPR3RNS0pYdGVC?=
 =?utf-8?B?Wk93YzZlZGc2SXRrTFZFQzBkVTlIdHRubVVQOXo1VXBGcTY2UzV1L05UZlJD?=
 =?utf-8?B?aTAxbzd2UlpHOFExWGVVakZiVnlpVXVaRFkvNDFPQmdPMTRRREZLNXA3N291?=
 =?utf-8?B?UVlzUndtc1pPeHpuYnFCclJDaWlnRWRpZEdFMzZxWTQ5SlZyZEM3OTM1TGtN?=
 =?utf-8?B?anhORzV4VXMrZkNrMHIzMmdRNDRWQ0M1bzlaeTE0Y0huTm1uOTVjRHdDV0pw?=
 =?utf-8?B?SkFWVlNYWUxzUHl2eUE1cVBaZU1uVzBJTEo3ZTZaS3NoK3J0VEdnUW1CTDky?=
 =?utf-8?B?MkVubnJOZ2hNVy9qaUpvRnhNQ0FiQzF0dDlqaGMxOEs3eVRUa3VvNDB3M1RQ?=
 =?utf-8?B?Y3ozRXppdTVKNndOZW8xa0loeG1rbU1USmVmZ0RFOWtTaS9MRTRzMGlIaVFm?=
 =?utf-8?B?STB1emt4REJ2K1pscWJkcEoyMXQ0QWF4TkdUNndFODdHb0JWU2ZEYjNCbWxx?=
 =?utf-8?B?blA3SG9HZk9lNTNuNGxESCsvNTBGNEYzN3NGbkFEb01UazJXUmlkUWFGVjgr?=
 =?utf-8?B?aS9NMXA3allXdmZjNnRRS0xBU1BkUXdYL21tVUp4MGhnU2VNdHNRU2NaMU0y?=
 =?utf-8?B?bTJ5RHQ2Y1ZIZGZMZFFpYVBZUmprZDk4RTNGQlgwRm9ZaXFzNmdsa0VYdEN4?=
 =?utf-8?B?bi9LKy9CeStGdjJaWFc3aG9IT1czd3o3c1c1WTRnWkdXa2lUN1VsYWplU0NH?=
 =?utf-8?B?VUNIK2xRdHp3ZEYrdk1Pb1JCVGs4bXVGSm15YlAvc2FrcDMyRWlzbWRPeWdj?=
 =?utf-8?B?dDgxdFU4cmh4MjRkNC9FNmI2ZFpubkJuZkZiWkN1Ym15RFJFZzN4RUtVMlVB?=
 =?utf-8?B?c0tlakdtSUtQTmYvZ0FrL21PZWU4VmprS0pXSG83V1ZZWmtWalF3UmpGRkJO?=
 =?utf-8?B?MEZ0WUVDcGNoKzZjL0pLd3F6ZUNNL0RpL1dnWnJ6M1BIdmlneHlGemMxdGtD?=
 =?utf-8?B?TlhnU2FSNUNQdndweHNUVVlNS2FlZEJySklqbGRJZU5xQlNFRTJraW5HV0ho?=
 =?utf-8?B?KytjYlpXdDV0ZGVvTHpmUGFTUmxHRlV3RXJNMmpqNHI3UmdVYXV2SU9EdnFL?=
 =?utf-8?B?MVlYWUM3Q1NwdWo2MG1rVW9ZdDB1cll2cXQ4S1l0Wk1UUWkzdTJTakc2SGQ0?=
 =?utf-8?B?blU4UHZHbWpwMHRFUjZyNGx6amJIdjIvcUMvbHdHK1l4OXBaMHlNL1RDYlBC?=
 =?utf-8?B?cUtPZmZlTldJd0tIU2tZMWVBSHBJeXJvVkloRTc1aXZjSW81WGZBYUVIYVho?=
 =?utf-8?B?MlhEa09hSERqYm9NdFV6aGM0NXhoWldUdzlqR2pWR1RJTWFHaFQwZnAwN0tq?=
 =?utf-8?Q?ToO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453aac81-53f5-4875-a734-08da66763485
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 15:25:09.9382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDooqScZ7AwH/LONmnFntVm3J+XfDdW5c3Ca/ksrNRj6wUGh+Gt/k01yJY60SAmY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4716
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4+IFdoeSBleGFjdGx5IGRvIHdl
IG5lZWQgYSBuZXcgZGVmaW5lIGZvciB0aGlzPyBFc3NlbnRpYWxseSB0aGUgZW5jb2RlIHF1ZXVl
IGlzIGV4dGVuZGVkIHdpdGggbmV3IGZ1bmN0aW9uYWxpdHksIGlzbid0IGl0Pw0KPj4gU28gSSB0
aGluayB3ZSBzaG91bGQganVzdCBzdGljayB0byBBTURHUFVfSFdfSVBfVkNOX0VOQyBhbmQgbm90
IGFkZCBhbiBhbGlhcyBmb3IgaXQuDQoNClllcywgaXQgZXh0ZW5kZWQgdGhlIGVuY29kZSBxdWV1
ZSB0byBpbmNsdWRlIG5ldyBmdW5jdGlvbmFsaXR5LCBhbmQgdGhhdCBsb29rcyBsaXR0bGUgY29u
ZnVzZWQgd2hlbiBzZW5kDQpkZWNvZGluZyBqb2JzIHRvIHRoZSBlbmNvZGluZyBxdWV1ZS4gVGhl
biBJIGFzc3VtZSB0aGlzIGJpYXMgY2FuIHJlZHVjZSB0aGUgY29uZnVzaW9uLg0KDQpEb2VzIHRo
aXMgY2hhbmdlIG1ha2Ugc2Vuc2UgaW4gdGhpcyByZWdhcmQ/IGNlcnRhaW5seSB3ZSBjYW4gc3Rp
Y2sgdG8gQU1ER1BVX0hXX0lQX1ZDTl9FTkMuDQoNClRoYW5rcywNClJ1aWppbmcNCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIEp1bHkgMTUsIDIwMjIgMTE6MTggQU0NClRv
OiBEb25nLCBSdWlqaW5nIDxSdWlqaW5nLkRvbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0gg
djJdIGRybS9hbWRncHU6IGFkZCBIV19JUF9WQ05fVU5JRklFRCB0eXBlDQoNCkFtIDE1LjA3LjIy
IHVtIDE2OjQ0IHNjaHJpZWIgUnVpamluZyBEb25nOg0KPiBEZWZpbmUgSFdfSVBfVkNOX1VOSUZJ
RUQgdHlwZSB0aGUgc2FtZSBhcyBIV19JUF9WQ05fRU5DLg0KPg0KPiBWQ040IHN1cHBvcnQgZm9y
IGxpYmRybSBuZWVkcyBhIG5ldyBkZWZpbml0aW9uIGZvciB0aGUgdW5pZmllZCBxdWV1ZSwNCj4g
c28gdGhhdCBpdCBjYW4gYWxpZ24gdG8gdGhlIGtlcm5lbC4NCj4NCj4gbGluazoNCj4gaHR0cHM6
Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL21lc2EvZHJtLy0vbWVyZ2VfcmVxdWVzdHMvMjQ1L2Nv
bW1pdHMNCj4NCj4gU2lnbmVkLW9mZi1ieTogUnVpamluZyBEb25nIDxydWlqaW5nLmRvbmdAYW1k
LmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggfCAxICsNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+IGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmggaW5kZXggMThkMzI0NmQ2MzZlLi5mZTMzZGI4NDQxYmMNCj4gMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1k
Z3B1X2RybS5oDQo+IEBAIC01NjAsNiArNTYwLDcgQEAgc3RydWN0IGRybV9hbWRncHVfZ2VtX3Zh
IHsNCj4gICAjZGVmaW5lIEFNREdQVV9IV19JUF9VVkRfRU5DICAgICAgNQ0KPiAgICNkZWZpbmUg
QU1ER1BVX0hXX0lQX1ZDTl9ERUMgICAgICA2DQo+ICAgI2RlZmluZSBBTURHUFVfSFdfSVBfVkNO
X0VOQyAgICAgIDcNCj4gKyNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9VTklGSUVEICBBTURHUFVf
SFdfSVBfVkNOX0VOQw0KDQpXaHkgZXhhY3RseSBkbyB3ZSBuZWVkIGEgbmV3IGRlZmluZSBmb3Ig
dGhpcz8gRXNzZW50aWFsbHkgdGhlIGVuY29kZSBxdWV1ZSBpcyBleHRlbmRlZCB3aXRoIG5ldyBm
dW5jdGlvbmFsaXR5LCBpc24ndCBpdD8NCg0KU28gSSB0aGluayB3ZSBzaG91bGQganVzdCBzdGlj
ayB0byBBTURHUFVfSFdfSVBfVkNOX0VOQyBhbmQgbm90IGFkZCBhbiBhbGlhcyBmb3IgaXQuDQoN
ClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4gICAjZGVmaW5lIEFNREdQVV9IV19JUF9WQ05fSlBF
RyAgICAgOA0KPiAgICNkZWZpbmUgQU1ER1BVX0hXX0lQX05VTSAgICAgICAgICA5DQo+DQoNCg==
