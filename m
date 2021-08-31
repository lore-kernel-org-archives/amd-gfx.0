Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F5C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 05:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F326101C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 05:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 67F326101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB48D89AFF;
	Tue, 31 Aug 2021 05:47:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11DA89AFF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 05:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP1mucwxDfrqua/KJT4K4OHzAmZZXL0tfpZjPTkywS/m+9w4DhvQxqdvl68w7lg/OIY427bEdPCBTNjf1JAJs4fuwEVFAxJoXUDvwgVz1agjagleg7k3vLDGq+2noWOHD4H07ZNKVcpEzMPVXqckcR91sAzPecGytYo4N+1aRnya+Ww5yHQZnl9t0zxxGz9z+hXJvQpbGqYEXN+eJMsziuLOYX4JzzPiWMNK/lViofAg7FWZ5AJdU+AGcBx6QshF5PakgQihj+shwqODTQXZQ4ZwdgpA1OrRhFSeeWJovFNaeC90KiL31tZMrPFo5ej0SFnhZImdsj50ktTY+USgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=crIfu+pSzEjaCOQ9EakqCLgrJWf6Cb3raA260POjo3I=;
 b=ZjQRz0dfr8n6zAN4FTYEC+qbiTO0NihHqR1ptq1/0gGNO8Ff34Vs3xcvCU7cfgwGB+YooLVobIeXqM4v1dYLQ+STY6s8yAKV10cESo3QMVmoebzJ3Q6/W5BmMN+RLQikdbwcHnqA3HOQhb10YFs/wHXvEveZBIE9N1FRKt3+xLiOZq4J0AL1chWwX2QMY/3VVsBh6aATBVb1W3nD/CAsh/rJtYuotRbSSn0jQVHs9jbVnjLCPTYnAKzJO+mp/YIsLh2Fd/Hjlb5AUyjB4Gjm+sBPfTLnmYEMF93mmnjqHrJhsdKRRYsVxohvPUGGPawlAxLyYY8Ugjf6GjivsrNtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crIfu+pSzEjaCOQ9EakqCLgrJWf6Cb3raA260POjo3I=;
 b=wMafpcXUR93g9yP2rL8+KiJwhJcLns/mnXRJwamHb0yY2Y3d345vYnjI37J0HN38KM+WJE49FUOdyByIbGxlzQnAvZaEwHgHuYsuuf63rxlKedmrlKudDdk10cFkqbGcLWkQVRt4nYXO7wBImgYLYCxjH6n4cX7cShteqkvEKWY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Tue, 31 Aug 2021 05:47:14 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 05:47:14 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
Thread-Topic: [PATCH] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
Thread-Index: AQHXnh05XbwK6k67P0+s+nQi5Faq9auNnsiAgAACYoA=
Date: Tue, 31 Aug 2021 05:47:13 +0000
Message-ID: <9AE27401-DFDB-44C1-86BE-064F3378D5D5@amd.com>
References: <DM4PR12MB5165AFECE854E6A4E82A05DF87CC9@DM4PR12MB5165.namprd12.prod.outlook.com>
 <0a52e64c-c5c7-ab65-4370-94374e2d0458@amd.com>
 <C4E7B450-18FA-4DA3-9AED-FCA03A24B279@amd.com>
In-Reply-To: <C4E7B450-18FA-4DA3-9AED-FCA03A24B279@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cde3dd0b-8c5c-4ba4-ccb4-08d96c42c8b9
x-ms-traffictypediagnostic: DM4PR12MB5071:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5071B8796A508AF9036B1B4D87CC9@DM4PR12MB5071.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npZzkH4dWAzsOE9xawwm8K3MPCcPZwDBbuywhpqWfwQtBO71DkPnk5Dp+8DJyb3cxX+CJJ02F1mK5qp05/vYq+/A6NlVTjQBZAPyt9Vz9cVda6sb/5ReCvjqA2tdufREk5fmYvxOmHdoBIOn84etyaiTV5dExCzFqeihoLPjy5UcpVN097IjeOh7tQ6EmwaqjZqHBhxgXXD7lGGlR5XI3HUfXZSwfxMEeLrtggKZ1YGchwzhZgFSQTz6O5K15Iii4pLU8EScO7chy5/RFon6ges8VALRLwN1pbqTz4bX9IH2jAY164qEt8Nbzgg1+oitu5ugytXwEXAFl8guwtmB3PE2LHev2rmr2fl7AFJmB4//n202ejf3Qj4fSZVVC6v8vAuXLRquIaGFa0fyCrDdEsMIZ8xzcmY7NbFMjDjow8ikxqt938FwUTHgBGEt+JvOyyks5KPagmSM6Jc0WzzpOjq8g0pzHjcVh+v6pJNZFW3m3LxixVNK/VmkDfuf6VYw5SC5UrYZJIsGdR9Dy4bSki2FhMJDgngZFDrP73cwv4Kn6HYSjPFqmGnOw3kL0FnHj691E6dBcS+YHdk6d9XrdlRTIa+XesE92XVgQjTLegYFDYFaj3ntjPjE0cqY7dxbebP/5osMpN38eZUJYV7HGKgy06MtgKTDgJvGJWYRUfZ9nPzswb/dUflci5V4NMUYIp0q5i4cMdjHcVfXvY/Q1bGk89qpP2aM4TkqXkgok0QeNBCVWOY90RV4AOwig5W1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(2616005)(8676002)(8936002)(316002)(6512007)(110136005)(4326008)(6486002)(54906003)(91956017)(76116006)(66476007)(6506007)(53546011)(66556008)(64756008)(66446008)(2906002)(186003)(86362001)(66946007)(38070700005)(26005)(5660300002)(71200400001)(83380400001)(478600001)(36756003)(38100700002)(122000001)(33656002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em1vMWhnWXJ1NmZkMnZ1a2xJUTA5WkRLNStzQWo4aXJEYkhyUXF0eGNVTStB?=
 =?utf-8?B?T0FHQUJ5Y3l3NnpjQ0NCNloybVZReUpOR0hmY1RPWFplVjlocXo5QVFCR1dV?=
 =?utf-8?B?and5eE56YXJjTnh3U3psTUlMNitNSVhEb1I1Z1lpQy9PVnA3a1FNWGdSbm5F?=
 =?utf-8?B?RHI1ZzZ6aWtLUzRVS05ncmovKzBOV2dMVzNWQ0wzOFFzM2JlaEhhRVJGRGZh?=
 =?utf-8?B?N1dCN2JmNGlHWGEwRDhaazRLaDJTQXhDTTJ2SmdORmpLbmQ1M0xoZ29NeW5Y?=
 =?utf-8?B?dXJTWGZDL3RyYnRjbW9mYUlKd3lRQXp1L2V2L0VDS2VyTkFBNCtWcFJvc3JI?=
 =?utf-8?B?V1R5WDcwZWtUcFp4UTBxdUNBT3oybmRCSlZWeCt5MklwbkREZ2Nqc3p4Tmtr?=
 =?utf-8?B?Yy8zMTJoVkovM1NNZ2o3MFNkczhqMTBBRXlLc0pGNHBVMFNQTyt1b051LzZV?=
 =?utf-8?B?VGVPM1hwY3FPODQwYjNybDJPYWJwUG5FMWtOeWVJVUJESWxuODRuR21wSkV4?=
 =?utf-8?B?dk5mOEZCb0lzc3h2U00rby9zQTV3QjVpRUMvRmxIcE9MMlNZSTZyVkVNMnJZ?=
 =?utf-8?B?YkRzZEZqdEo1cHVheFd0N2JUR2Z6QWZiMXhuK24wRUlZMFdvWVlidVEzd0hv?=
 =?utf-8?B?RjhlRjF6VUlGcnNLSk5HTHpJUDJtNGRrQ3hzZlF0ak5tNWRUWGRvUlVnbEJ4?=
 =?utf-8?B?YVM1akYrSW4ra3NDelNpSUZ6WDNaNzViVHJ2eFhrajZWdFQ2VW5jd21meCts?=
 =?utf-8?B?VkQwM1ZEdVBVdGZlWDQ3TWh6b3FNZjhoMlg2bEM0ZzZVVHF5ODA3ZWNsRDho?=
 =?utf-8?B?bmlSamFjSWUzbkZuQjhpdWFNMmFySnpmcWtXdjlwL29CaDhQSFhPWUVNT0Mr?=
 =?utf-8?B?WVRvTVdoeGNBTHliK0hqS1FIUEJhNG9Hc0N0cWNZdmRUcVZ0TzhqekZUT2RF?=
 =?utf-8?B?NmdIcmk4SC9yTzJEODB1cHYrdWlEaDEvM3dENkQwcE1QeXhNMkhtZ0lTTStv?=
 =?utf-8?B?MWRYS01QQXRrakxuNXVDbnlmd3F5UURkNmRWYldKTzg5UVZZNU4vWDA2dUIx?=
 =?utf-8?B?eDdOKzlxdlEwMFVrcDRwQ2RTdXRTN2s3V3RYTlNCZGl0U09lMWdLMTh6ZGFY?=
 =?utf-8?B?TFQxWWdNaVFicUlkNFUwOFJRRFNTZDFNeFpmNDJRanppMHMvZUNEQUFMZWRt?=
 =?utf-8?B?bWZzanIyOEpsMTVOa3BKcUNCU2swYVZ4THBQK3VsejEwaXBacEE3TzJJRFhu?=
 =?utf-8?B?MFlldHpTaDJSTnB6OHpEakQ1aHl0ak51TSs1Q09UMllVWU42NnduNmtiQlhn?=
 =?utf-8?B?NDVLeVJhYU5UWTB5TlZYVURodmZwS2pPR0sxMnBUcjdVeEhZczM0TFRNODI2?=
 =?utf-8?B?N3JjRS9CVHZMTmR2TEZuVWZVaWZINjdtQ3dpeVJCT2Y5dVl0NnZZNU55R3h2?=
 =?utf-8?B?bjdmYkgvVGRmdE5HNHlIYXYwZkhGdENZdWR6NGxZWGc4Vmt1OVh6b1JSQ3kw?=
 =?utf-8?B?cHdvZ21ESXNTWVY0U3JBV1dBMlQ5WE5hNEZMazl4enRlZVFNMUs2d3hlWW15?=
 =?utf-8?B?MXdtZjFRWjk2N2tPdHJJWmVzZXBzVnJ1RitBZlZxWEVzWlJ0M3NYZDQvRnE0?=
 =?utf-8?B?bkVVYnNZZjh3Rkk4dDNrY01oelN3dkl5ZlhoMDEwZ1QzQXloZXZGTFpmTDJU?=
 =?utf-8?B?dnlxOWoyenpGYWdkdGsrOEN4dmtLRGEvcm1IYldpTEpIdmw1N0FJa0o2cmlZ?=
 =?utf-8?B?bnA0aUpLMEh5VXZ3RmlCLzJWMVdhS29UOFZ0Zy9nUXlsVjJIYTVLZngyL21C?=
 =?utf-8?B?SDZnMjdoR2lRM3NGYVRIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3C4AECD6247EF4FADDFCB3DF226ADFC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde3dd0b-8c5c-4ba4-ccb4-08d96c42c8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 05:47:13.9443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8aq47ij4gxClsj3Z4ZsJGdFNIRMxtDrtW5o9/IRkInRU/wzBNSfmhKdjsemjRr5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
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

DQoNCu+7v+WcqCAyMDIxLzgvMzEgMTM6MzjvvIzigJxQYW4sIFhpbmh1aeKAnTxYaW5odWkuUGFu
QGFtZC5jb20+IOWGmeWFpToNCg0KICAgIA0KICAgIA0KICAgIOWcqCAyMDIxLzgvMzEgMTI6MDPv
vIzigJxHcm9kem92c2t5LCBBbmRyZXnigJ08QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4g5YaZ
5YWlOg0KICAgIA0KICAgICAgICANCiAgICAgICAgT24gMjAyMS0wOC0zMCAxMToyNCBwLm0uLCBQ
YW4sIFhpbmh1aSB3cm90ZToNCiAgICAgICAgPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KICAg
ICAgICA+DQogICAgICAgID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCiAgICAgICAgPg0KICAg
ICAgICA+IFVucmVzZXJ2ZSByb290IEJPIGJlZm9yZSByZXR1cm4gb3RoZXJ3aXNlIG5leHQgYWxs
b2NhdGlvbiBnb3QgZGVhZGxvY2suDQogICAgICAgID4NCiAgICAgICAgPiBTaWduZWQtb2ZmLWJ5
OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQogICAgICAgID4gLS0tDQogICAgICAg
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgfCAxMSArKysrKy0t
LS0tLQ0KICAgICAgICA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCiAgICAgICAgPg0KICAgICAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2VtLmMNCiAgICAgICAgPiBpbmRleCA4NWIyOTJlZDVjNDMuLmM5ZGI3ZDJjNTgxNiAx
MDA2NDQNCiAgICAgICAgPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMNCiAgICAgICAgPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMNCiAgICAgICAgPiBAQCAtMzU1LDE5ICszNTUsMTggQEAgaW50IGFtZGdwdV9nZW1fY3Jl
YXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQogICAgICAgID4g
ICAgICAgICAgICAgICAgICAgICAgICAgIERSTV9ERUJVRygiRmFpbGVkIHRvIGFsbG9jYXRlIEdF
TSBvYmplY3QgKCVsbHUsICVkLCAlbGx1LCAlZClcbiIsDQogICAgICAgID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplLCBpbml0aWFsX2RvbWFpbiwgYXJncy0+aW4uYWxp
Z25tZW50LCByKTsNCiAgICAgICAgPiAgICAgICAgICAgICAgICAgIH0NCiAgICAgICAgPiArDQog
ICAgICAgID4gKyAgICAgICAgICAgICAgIGlmIChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1ZN
X0FMV0FZU19WQUxJRCkNCiAgICAgICAgPiArICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVf
Ym9fdW5yZXNlcnZlKHZtLT5yb290LmJvKTsNCiAgICAgICAgPiAgICAgICAgICAgICAgICAgIHJl
dHVybiByOw0KICAgICAgICA+ICAgICAgICAgIH0NCiAgICAgICAgPg0KICAgICAgICA+ICAgICAg
ICAgIGlmIChmbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1ZNX0FMV0FZU19WQUxJRCkgew0KICAg
ICAgICA+IC0gICAgICAgICAgICAgICBpZiAoIXIpIHsNCiAgICAgICAgPiAtICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICphYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKGdvYmop
Ow0KICAgICAgICA+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICphYm8gPSBnZW1f
dG9fYW1kZ3B1X2JvKGdvYmopOw0KICAgICAgICA+DQogICAgICAgID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgYWJvLT5wYXJlbnQgPSBhbWRncHVfYm9fcmVmKHZtLT5yb290LmJvKTsNCiAgICAg
ICAgPiAtICAgICAgICAgICAgICAgfQ0KICAgICAgICA+ICsgICAgICAgICAgICAgICBhYm8tPnBh
cmVudCA9IGFtZGdwdV9ib19yZWYodm0tPnJvb3QuYm8pOw0KICAgICAgICA+ICAgICAgICAgICAg
ICAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZSh2bS0+cm9vdC5ibyk7DQogICAgICAgID4gICAgICAg
ICAgfQ0KICAgICAgICA+IC0gICAgICAgaWYgKHIpDQogICAgICAgID4gLSAgICAgICAgICAgICAg
IHJldHVybiByOw0KICAgICAgICANCiAgICAgICAgDQogICAgICAgIFRoZSBhYm92ZSBlYXJseSBy
ZXR1cm4gc2VlbXMgdG8gYmUgbmVlZGVkIGZvciAtRVJFU1RBUlRTWVMgY2FzZS4NCiAgICAgICAg
DQogICAgICAgIEFuZHJleQ0KICAgIA0KICAgIFRoZXJlIGFyZSB0d28gcmV0dXJucy4gRVJFU1RB
UlRTWVMgYW5kIG90aGVyIGVycm9yIGFmdGVyIHJldHJ5IGFyZSBhbHJlYWR5IGhhbmRsZWQgYnkg
dGhlIGZpcnN0IHJldHVybiBpbiBpZiB7fS4gU28gdGhlIHNlY29uZCByZXR1cm4gaXMgbm90IG5l
ZWRlZC4NCiAgICANCiAgICBUaGFua3MNCiAgICBYaW5odWkNCg0KQWxzbyB3ZSBjYW4gZG8gc29t
ZXRoaW5nIGxpa2UgYmVsb3cgd2hpY2ggaXMgc2ltcGxlci4NCkBAIC0zNTUsNyArMzU1LDYgQEAg
aW50IGFtZGdwdV9nZW1fY3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQg
KmRhdGEsDQogICAgICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUcoIkZhaWxlZCB0byBhbGxv
Y2F0ZSBHRU0gb2JqZWN0ICglbGx1LCAlZCwgJWxsdSwgJWQpXG4iLA0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemUsIGluaXRpYWxfZG9tYWluLCBhcmdzLT5pbi5hbGlnbm1l
bnQsIHIpOw0KICAgICAgICAgICAgICAgIH0NCi0gICAgICAgICAgICAgICByZXR1cm4gcjsNCiAg
ICAgICAgfQ0KIA0KICAgICAgICBpZiAoZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WTV9BTFdB
WVNfVkFMSUQpIHsNCiANCiAgICAgICAgDQogICAgICAgID4NCiAgICAgICAgPiAgICAgICAgICBy
ID0gZHJtX2dlbV9oYW5kbGVfY3JlYXRlKGZpbHAsIGdvYmosICZoYW5kbGUpOw0KICAgICAgICA+
ICAgICAgICAgIC8qIGRyb3AgcmVmZXJlbmNlIGZyb20gYWxsb2NhdGUgLSBoYW5kbGUgaG9sZHMg
aXQgbm93ICovDQogICAgICAgID4gLS0NCiAgICAgICAgPiAyLjI1LjENCiAgICAgICAgDQogICAg
DQogICAgDQoNCg==
