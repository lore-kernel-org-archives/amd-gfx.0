Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904A6C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477A66108F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 477A66108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC586E1E9;
	Wed, 25 Aug 2021 11:55:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF8E96E1E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXY8FsH6velmKIVHE307q8q0fq3c0RvYsf3SRM/FvAWNrgMC6u6k6J7/DopzWwI3REtION5Umhg95TcK3fTUR36kiyK7xYmhBtOnIB65FlkAhtgHf67jyw7wFp9k0jICSVpXe1RfZG02VkyAeDjV9CXHpDnMfs309Z76IbVPdfFWur6BFgiyPsKJW9CL1oDL0Vi3DzQ420OWBIVu21M5ZzWPrHsU3gXMBDk6KEQ0AyAOtGR/kmVOwrrQDIY8ZuHlAs6FJl3fygNTaIRw6/HL0Xzu6i9OaEXhv87aS4hbdk7D9vRL5KFr+Gr6VMauuWFfb3oWA/y54Ic1YE++I8frLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkNosM3Reaa1Y44d2CR7Qx8vGgXp7XEPfneUlRovsus=;
 b=fUA3A2lE+XuRdfoL4bGSc8KdrVSpY2THkUesMHjAmeckVCdLUx7ww/zjpB1O2P+3tqc2KGGrEhu8SxxFxdK2wTeVXV/1fgWeKYux4ho9Xg7qgL+WRoFAtJUh2YkgevHvS4LIOHQRWIVwu8HQ8klVLuN9csejERBDQ7DyadIorKap/3ASOaaSbHXSIuAT9mD7bi34NskCzUB/U4GlypgoT5kj4/izHA1eA/SiNYQAl77aN4MRNzbFAsiaS5clz3dHxmivL0nGMuWyGOhfmZJ2Gfk78dSnA8zIsVuYyXlieN1EnHNAcYzlCM50q1x1tYbrPE2xhdiXslAAtMSVhuXvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkNosM3Reaa1Y44d2CR7Qx8vGgXp7XEPfneUlRovsus=;
 b=AKbv/XSgMQIo635j+Y7VeWajQeSqSHRH9T12MJfCFibXWsZPEJy+oRGPLTch4IOYfWqfsy3fvTv9n3SRRURCncyepLtbFWXEWQ2PnJL0DLWtl8o1468uBjPVQMnngrAuII61EQ8OqqvhbMEvUXRvYaYrg+2mmnBhmLYpGBuBP6A=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 11:55:16 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 11:55:16 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/sched: fix the bug of time out calculation(v2)
Thread-Topic: [PATCH] drm/sched: fix the bug of time out calculation(v2)
Thread-Index: AQHXmWev/1s0G88H/USG8+ifveLzjquDwuuAgABVUPA=
Date: Wed, 25 Aug 2021 11:55:16 +0000
Message-ID: <BL1PR12MB5269567906F233C0B938C32C84C69@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
 <1ef452fc-1f76-8dda-1c74-c540576fe6c6@gmail.com>
In-Reply-To: <1ef452fc-1f76-8dda-1c74-c540576fe6c6@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-25T11:55:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=51cc4fd5-d3c2-45a6-aa60-a9a0f3d2aeca;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e1cf9fe-1e2a-48c7-11fa-08d967bf344a
x-ms-traffictypediagnostic: BL1PR12MB5239:
x-microsoft-antispam-prvs: <BL1PR12MB5239BC1246E6CF0C40D00ABB84C69@BL1PR12MB5239.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKQDrMAeGnvUz3C67gibihzrwwb5VOrmfXFKZAHbycTNLAxUG/gnakhUjC6QO1ElglMpbYgDTwBCA8Ykrb7/CHRYC3XNQtCa8epp+I+iEbqZa76EYboiOAtyCnVhSBGIJEJHbgDWw0xQhIieQxwy2zejdpwgmmr/rueL7tUFS2UQ0Lgy3eqeQfEi8ThaVRBJ2yENOz/6aJZ1kaCs79E7towVRu3qq6MOVmYvGOpn3nHJao67L48UMCBE/PpfES7fP3BIQQ2OxcQAuHaj1F3TsqMrrRkVO7rPOvxsRnjcv1ZPYCiWBPoapkjiqQNDINs0EsOAANO101FgBIsF2fJnbYF3YdY2gtXxecm0PBeFaEqkX/AtHr+Sm2+jQ9UpJ0lILSkCQWd+QdGq18jinvEeO4PcJH8VbfeuzDE1mhLhteb5KZRX8ikOu+XdLk0jdAS1cUBmRzT+riUkuoSwCnnx55d0coljvTHdnsgxVJ7bXCngmQbsGIJ602DV3yBQR3LI7MRiiR2gOWcLaNfgYhWjjbSpzte2YO0ru1v04k5bQXEspgiyai4B44YRj4C0B+j0pg+OMRxBS9TMHJfDX1aYH8VUm6RJr2XD+KDjqBAJfUKReF8XiBQ+eArJWOMuOqWq6Jf3L5aZ7EaHhClfm7QlxOjGJI3WFrqMCHma8RyPMJsoKDeH2TYqA8MqamwT5N86IOKPbZrf/O68YBfxNNAW8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(33656002)(186003)(6506007)(26005)(38100700002)(122000001)(8936002)(53546011)(66556008)(8676002)(64756008)(66446008)(66476007)(9686003)(71200400001)(55016002)(66946007)(76116006)(52536014)(110136005)(5660300002)(83380400001)(66574015)(7696005)(86362001)(2906002)(316002)(38070700005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWFOQ0V0SmhqZ1VCY2xXMTREVGIwb1dYV1BqaUhFUHRXMkg1Vm05T214K1da?=
 =?utf-8?B?Q0l6b0VVejVIejJDR1NhYWNKbGtpM1RKdzNxQUZtMko3UGdYM3RhTjRUYmU4?=
 =?utf-8?B?dXd3MnMwNS91V3EzazZsMVErakJzZWxleTlvOGpQTTcyZDZOQjY3TW9YclpN?=
 =?utf-8?B?R1hoRHJaS1grelVRWHFGMGl4cTRmaDBEWVhLMXlMUFR2VTRVV0h3bHlmVStD?=
 =?utf-8?B?Q2paZUJwWmVHcW9pR2NuNVZmb1lhNS8xbFpjMWtnK1NYRXZKeWJVWmJJU01y?=
 =?utf-8?B?bVZGZ1dEMFhEamhBbVE5SWp1UkxmRmUrcFlWK0ZPYWUwcXM4dU9CUHFXQ0p2?=
 =?utf-8?B?clNTb05hejh0dWRXOTY5WWNBN3BsaTYvT0xmVEs3aHZRZndFZy9PeXhSN3J2?=
 =?utf-8?B?NHY0TVo0SmEwTUhrWXlZYVZsL3ZYcVl6MW00T1kwYVVTUUJGc1czb3JVMkUw?=
 =?utf-8?B?ckx0aUt3Wm1OekRCYkZZZTN2c2pXZDUyTnZXWWttcXlraEVQSEo4dmJYejhy?=
 =?utf-8?B?KzhRVzJidlhLbXdKYUZRZHcvOFpSQ1NhaGl4ODd0OCtqajdBc0Y1aXNKUjIw?=
 =?utf-8?B?NTd2cHh6aHZ2a2JOL0RFNnQ3R3J4ZU5NQUxGemFOUE1MalpvcGM5b2hFVzVj?=
 =?utf-8?B?K2V5aEhqRDg5K21TWE5xNFExTFRzd2pTMmk0c3NQRm12azJ1dlpoaHBGa01L?=
 =?utf-8?B?Vm5ZSkFzV1hhQWpVaTduamxqclFCdHdRKy9zWU0rZHdRMmFDNUNJc0tCUzJI?=
 =?utf-8?B?QXNjY28yN1lESUhMejJsOWx3d3lKZ1ZOL3pvMHMwVTdRQ1lTMVBxblgwZHJL?=
 =?utf-8?B?UHh0S3IvVVZPbWRjOWpBQ3Jua1ZwYWpYNFlkNCsrU3duaFdlbFpLK05lS3FU?=
 =?utf-8?B?em1nTjJaUUNzU0tINjlQdE00bzBBOE95anF4eVJjenB1SGoxU1hLU0Y0Tk4r?=
 =?utf-8?B?SXhad21zaFhjQWRtWGJrQTVNc0c2ZUFSSHh6RFZoY2lSakNvZTZ6VHNRaU43?=
 =?utf-8?B?elVQR1VBVGE0OUt6RHhxUDlPb3FtUVFxREswUjh0NDJYL2htWi9XclJmNUww?=
 =?utf-8?B?VDNjdzIwc3krdWl3QXozZml4NElPemxzMmJWdXFkWXFHU0V5SWNmRG9xSGtm?=
 =?utf-8?B?QlJXOUtWVy9YempzdmQ0d0IvRVNUWlNuVndoa3UwNDI1MTZ0SEZqd0NQdkE1?=
 =?utf-8?B?WVVKZkEvcWEzOEl2MHFtWkRVeUtkSjBVTXhvZTFBcytnZmJHRjF5YVI0anJR?=
 =?utf-8?B?WlNUUE5NTDBuU1d5WW53Z09EUTREenRhTjFEdWdzdVlLQVRjMmsyYWw4bUVX?=
 =?utf-8?B?M0lwblpkUzFYVjVvNjZjdmc2ZEtCdWw5NWd2ZDJGL3VrbDRReGtNL1lrNm16?=
 =?utf-8?B?NDRIZUdOeSttR096WG85L3R1MTZxUUxqcVJBSVJSMHU2ajBsOTR3STIwYVpJ?=
 =?utf-8?B?WUxKN1RJMHMrMDBLWThtdnNzS2FtUXJZZWoxdis2RDdIeXM1L2VJRENvc3p4?=
 =?utf-8?B?WnlMSDZ2TnU1Y2xJUkdtbFgvMGwydnVOT1NFZ2N6SXM1VURDemxuVVhIOXlK?=
 =?utf-8?B?MXJ3QmxIMjFVMTBjWVBIcFdqbERkODlnOTNCUzBJM1NpWXFiYW85UmJjbGZo?=
 =?utf-8?B?emVUZGVvQTVTZTJzTXpmV21pWjI3bG5KeEh5ZWhPR2NyaFExVXZ2UjRoa0hK?=
 =?utf-8?B?QzA5R1p5c2RWclJHTFJMKzdURStDTkRSQzlieDJMa3BPT3c2OGtLdTF1NThz?=
 =?utf-8?Q?vFigULAGNjduSYgojPwbw2q33dFMKyoM5B5BdJP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1cf9fe-1e2a-48c7-11fa-08d967bf344a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 11:55:16.2154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmroEcvMUFZdi6lVuj/30Dch3E5H2tTmC2g7UDFqAewrT3VHIKQ/S5kz8D8t0U4W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPj5UaGUgdGltZW91dCBzdGFydGVkIGJ5IHF1ZXVl
X2RlbGF5ZWRfd29yaygpIGluIGRybV9zY2hlZF9zdGFydF90aW1lb3V0KCkgaXMgcGFpcmVkIHdp
dGggdGhlIGNhbmNlbF9kZWxheWVkX3dvcmsoKSBpbiBkcm1fc2NoZWRfZ2V0X2NsZWFudXBfam9i
KCkuDQoNCk5vIHRoYXQncyB3cm9uZywgc2VlIHRoYXQgd2hlbiB3ZSBhcmUgaW4gY2xlYW51cF9q
b2IoKSwgYXNzdW1lIHdlIGRvIG5vdCBoYXZlIHRpbWVvdXQgb24gdGhpcyBzY2hlZCAod2UgYXJl
IGp1c3Qga2VlcCBzdWJtaXR0aW5nIG5ldyBqb2JzIHRvIHRoaXMgc2NoZWQpLA0KVGhlbiB0aGUg
d29ya190ZHIgaXMgY2FuY2VsbGVkLCBhbmQgdGhlbiB3ZSBnZXQgdGhlIGhlYWRpbmcgam9iLCBh
bmQgbGV0J3MgYXNzdW1lIHRoZSBqb2IgaXMgbm90IHNpZ25hbGVkLCB0aGVuIHdlIHJ1biB0byB0
aGUgInF1ZXVlIHRpbWVvdXQgZm9yIG5leHQgam9iIiB0aHVzIGRybV9zY2hlZF9zdGFydF90aW1l
b3V0KCkgaXMgY2FsbGVkLCBzbyB0aGlzIGhlYWRpbmcgam9iJ3MgVE8gdGltZXIgaXMgYWN0dWFs
bHkgcmV0cmlnZ2VyZWQgLi4uIHdoaWNoIGlzIHRvdGFsbHkgd3JvbmcuDQoNCldpdGggbXkgcGF0
Y2ggdGhlIHRpbWVyIGlzIGFscmVhZHkgcmV0cmlnZ2VyZWQgYWZ0ZXIgcHJldmlvdXMgSk9CIHJl
YWxseSBzaWduYWxlZC4NCg0KQ2FuIHlvdSBiZSBtb3JlIHNwZWNpZmljIG9uIHRoZSBpbmNvcnJl
Y3QgcGFydCA/DQoNClRoYW5rcyANCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KTW9uayBMaXUgfCBDbG91ZC1HUFUgQ29yZSB0ZWFtDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
PiANClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI1LCAyMDIxIDI6MzIgUE0NClRvOiBMaXUsIE1v
bmsgPE1vbmsuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL3NjaGVkOiBmaXggdGhlIGJ1ZyBvZiB0aW1lIG91dCBjYWxj
dWxhdGlvbih2MikNCg0KV2VsbCBOQUsgdG8gdGhhdCBhcHByb2FjaC4gRmlyc3Qgb2YgYWxsIHlv
dXIgYnVnIGFuYWx5c2VzIGlzIGluY29ycmVjdC4NCg0KVGhlIHRpbWVvdXQgc3RhcnRlZCBieSBx
dWV1ZV9kZWxheWVkX3dvcmsoKSBpbiBkcm1fc2NoZWRfc3RhcnRfdGltZW91dCgpIGlzIHBhaXJl
ZCB3aXRoIHRoZSBjYW5jZWxfZGVsYXllZF93b3JrKCkgaW4gZHJtX3NjaGVkX2dldF9jbGVhbnVw
X2pvYigpLg0KDQpTbyB5b3UgbXVzdCBoYXZlIHNvbWV0aGluZyBlbHNlIGdvaW5nIG9uIGhlcmUu
DQoNClRoZW4gcGxlYXNlIGRvbid0IHVzZSBtb2RfZGVsYXllZF93b3JrKCksIGluc3RlYWQgYWx3
YXlzIGNhbmNlbCBpdCBhbmQgcmVzdGFydCBpdC4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0K
QW0gMjUuMDguMjEgdW0gMDY6MTQgc2NocmllYiBNb25rIExpdToNCj4gdGhlIG9yaWdpbmFsIGxv
Z2ljIGlzIHdyb25nIHRoYXQgdGhlIHRpbWVvdXQgd2lsbCBub3QgYmUgcmV0cmlnZ2VyZCANCj4g
YWZ0ZXIgdGhlIHByZXZpb3VzIGpvYiBzaWdhbmxlZCwgYW5kIHRoYXQgbGVhZCB0byB0aGUgc2Nl
bmFyaW8gdGhhdCANCj4gYWxsIGpvYnMgaW4gdGhlIHNhbWUgc2NoZWR1bGVyIHNoYXJlcyB0aGUg
c2FtZSB0aW1lb3V0IHRpbWVyIGZyb20gdGhlIA0KPiB2ZXJ5IGJlZ2luaW5nIGpvYiBpbiB0aGlz
IHNjaGVkdWxlciB3aGljaCBpcyB3cm9uZy4NCj4NCj4gd2Ugc2hvdWxkIG1vZGlmeSB0aGUgdGlt
ZXIgZXZlcnl0aW1lIGEgcHJldmlvdXMgam9iIHNpZ25hbGVkLg0KPg0KPiB2MjoNCj4gZnVydGhl
ciBjbGVhbnVwIHRoZSBsb2dpYywgYW5kIGRvIHRoZSBURFIgdGltZXIgY2FuY2VsbGluZyBpZiB0
aGUgDQo+IHNpZ25hbGVkIGpvYiBpcyB0aGUgbGFzdCBvbmUgaW4gaXRzIHNjaGVkdWxlci4NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+IC0tLQ0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwgMjkgKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVs
ZXIvc2NoZWRfbWFpbi5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFp
bi5jDQo+IGluZGV4IGEyYTk1MzYuLjhjMTAyYWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfbWFpbi5jDQo+IEBAIC0zMDUsOCArMzA1LDE3IEBAIHN0YXRpYyB2b2lkIGRy
bV9zY2hlZF9qb2JfYmVnaW4oc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiAgIAlzdHJ1
Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkID0gc19qb2ItPnNjaGVkOw0KPiAgIA0KPiAgIAlz
cGluX2xvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsNCj4gLQlsaXN0X2FkZF90YWlsKCZzX2pv
Yi0+bGlzdCwgJnNjaGVkLT5wZW5kaW5nX2xpc3QpOw0KPiAtCWRybV9zY2hlZF9zdGFydF90aW1l
b3V0KHNjaGVkKTsNCj4gKwlpZiAobGlzdF9lbXB0eSgmc2NoZWQtPnBlbmRpbmdfbGlzdCkpIHsN
Cj4gKwkJbGlzdF9hZGRfdGFpbCgmc19qb2ItPmxpc3QsICZzY2hlZC0+cGVuZGluZ19saXN0KTsN
Cj4gKwkJZHJtX3NjaGVkX3N0YXJ0X3RpbWVvdXQoc2NoZWQpOw0KPiArCX0gZWxzZSB7DQo+ICsJ
CS8qIHRoZSBvbGQgam9icyBpbiBwZW5kaW5nIGxpc3QgYXJlIG5vdCBmaW5pc2hlZCB5ZXQNCj4g
KwkJICogbm8gbmVlZCB0byByZXN0YXJ0IFREUiB0aW1lciBoZXJlLCBpdCBpcyBhbHJlYWR5DQo+
ICsJCSAqIGhhbmRsZWQgYnkgZHJtX3NjaGVkX2dldF9jbGVhbnVwX2pvYg0KPiArCQkgKi8NCj4g
KwkJbGlzdF9hZGRfdGFpbCgmc19qb2ItPmxpc3QsICZzY2hlZC0+cGVuZGluZ19saXN0KTsNCj4g
Kwl9DQo+ICsNCj4gICAJc3Bpbl91bmxvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsNCj4gICB9
DQo+ICAgDQo+IEBAIC02OTMsMTcgKzcwMiwyMiBAQCBkcm1fc2NoZWRfZ2V0X2NsZWFudXBfam9i
KHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpDQo+ICAgCWlmIChqb2IgJiYgZG1hX2Zl
bmNlX2lzX3NpZ25hbGVkKCZqb2ItPnNfZmVuY2UtPmZpbmlzaGVkKSkgew0KPiAgIAkJLyogcmVt
b3ZlIGpvYiBmcm9tIHBlbmRpbmdfbGlzdCAqLw0KPiAgIAkJbGlzdF9kZWxfaW5pdCgmam9iLT5s
aXN0KTsNCj4gKw0KPiAgIAkJLyogbWFrZSB0aGUgc2NoZWR1bGVkIHRpbWVzdGFtcCBtb3JlIGFj
Y3VyYXRlICovDQo+ICAgCQluZXh0ID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZzY2hlZC0+
cGVuZGluZ19saXN0LA0KPiAgIAkJCQkJCXR5cGVvZigqbmV4dCksIGxpc3QpOw0KPiAtCQlpZiAo
bmV4dCkNCj4gKwkJaWYgKG5leHQpIHsNCj4gKwkJCS8qIGlmIHdlIHN0aWxsIGhhdmUgam9iIGlu
IHBlbmRpbmcgbGlzdCB3ZSBuZWVkIG1vZGlmeSB0aGUgVERSIHRpbWVyICovDQo+ICsJCQltb2Rf
ZGVsYXllZF93b3JrKHN5c3RlbV93cSwgJnNjaGVkLT53b3JrX3Rkciwgc2NoZWQtPnRpbWVvdXQp
Ow0KPiAgIAkJCW5leHQtPnNfZmVuY2UtPnNjaGVkdWxlZC50aW1lc3RhbXAgPQ0KPiAgIAkJCQlq
b2ItPnNfZmVuY2UtPmZpbmlzaGVkLnRpbWVzdGFtcDsNCj4gKwkJfSBlbHNlIHsNCj4gKwkJCS8q
IGNhbmNlbCB0aGUgVERSIHRpbWVyIGlmIG5vIGpvYiBpbiBwZW5kaW5nIGxpc3QgKi8NCj4gKwkJ
CWNhbmNlbF9kZWxheWVkX3dvcmsoJnNjaGVkLT53b3JrX3Rkcik7DQo+ICsJCX0NCj4gICANCj4g
ICAJfSBlbHNlIHsNCj4gICAJCWpvYiA9IE5VTEw7DQo+IC0JCS8qIHF1ZXVlIHRpbWVvdXQgZm9y
IG5leHQgam9iICovDQo+IC0JCWRybV9zY2hlZF9zdGFydF90aW1lb3V0KHNjaGVkKTsNCj4gICAJ
fQ0KPiAgIA0KPiAgIAlzcGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOw0KPiBAQCAt
NzkxLDExICs4MDUsOCBAQCBzdGF0aWMgaW50IGRybV9zY2hlZF9tYWluKHZvaWQgKnBhcmFtKQ0K
PiAgIAkJCQkJICAoZW50aXR5ID0gZHJtX3NjaGVkX3NlbGVjdF9lbnRpdHkoc2NoZWQpKSkgfHwN
Cj4gICAJCQkJCSBrdGhyZWFkX3Nob3VsZF9zdG9wKCkpOw0KPiAgIA0KPiAtCQlpZiAoY2xlYW51
cF9qb2IpIHsNCj4gKwkJaWYgKGNsZWFudXBfam9iKQ0KPiAgIAkJCXNjaGVkLT5vcHMtPmZyZWVf
am9iKGNsZWFudXBfam9iKTsNCj4gLQkJCS8qIHF1ZXVlIHRpbWVvdXQgZm9yIG5leHQgam9iICov
DQo+IC0JCQlkcm1fc2NoZWRfc3RhcnRfdGltZW91dChzY2hlZCk7DQo+IC0JCX0NCj4gICANCj4g
ICAJCWlmICghZW50aXR5KQ0KPiAgIAkJCWNvbnRpbnVlOw0K
