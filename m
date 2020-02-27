Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A1C35677
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7532424656
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YHrTuVtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7532424656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F48F6E8E0;
	Thu, 27 Feb 2020 14:42:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644F16E8E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isETt3HDUPnfmglEuk4bJXPXTUmRUjGicZVRD+UFudntEi8N2rU4a+e9TzMcSE0zNn6K0Ia1e9KfvQF53WfimTFs9Lhxx07obcdLGKBjj/JtZDwIUXwsorEASHa6p08rNYxObmAqghrJxe9EI+VIzFdX9PNpB847UHsp/GZ/usIAOy+cb0ZiGtxu/mIA38FrjAyfXNHlGMdqFq9SccL9nfssXQnmz/IAtR2wWumgbyrd7BvHSEjyElhLjGhl4A3oqJagmNoZrb3E1G7Rni8kXzPa7ePdAg5sWWqk1I8qPHCPtbFVd9o3hO8daM+gRhUihRjNT2uaCsTDIt28gXnXoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xumIfDvU5dj8rhhWCNUQL47KUkIMn/QT3PtpSxiIdeY=;
 b=jVey5aho/dgVre55uWhctTJldtYhXy+7NbTTzTctbK1bPab+VVTLKezCSockvfbf065EXuIVwSpDNCAMN221E7HmAvabxj1wUuA4xFZWbecNNSAJTunBu3U/1uA7X7Fum7NxnI/mvbWZLkE+XiRx0MSurwPGMDXPKtyg9lr5GSi+cKzfhsSv9viumzlnvXauiRI95Rgw9i0uBmiXdWW84COhvWz1dU+Xaqf22GlgtHVBQCv22R295ogK87PY+dDbfh4NCT15q5V0Rr/iNXuUk3oxW9ttO9mALKYaFnwDmniwVVKFVjhBhyJailMMUY6yLOeQDOC7HgPEZPjC8+Rd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xumIfDvU5dj8rhhWCNUQL47KUkIMn/QT3PtpSxiIdeY=;
 b=YHrTuVtTGeCFoOJbQItLCrdYrLtZXKaAKIvhXrSX01Jk8bo/+j/CUCjXjWeKi8eNE1aGC8hYT22p6C/Hms9Jw+p6ACWFiVih1wCEWVz8O9gtKsX6iNIMch4Fg1UsgXZvtZK/h/LKfvEzrd3veRF/zUvnU3ZQIwDk5FmE7soAFpQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (2603:10b6:404:ff::20)
 by BN6PR12MB1425.namprd12.prod.outlook.com (2603:10b6:404:1f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Thu, 27 Feb
 2020 14:42:00 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::64:3847:8cd3:9e0a%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 14:42:00 +0000
Subject: Re: [PATCH] drm/amdgpu: release drm_device after
 amdgpu_driver_unload_kms
To: Yintian Tao <yttao@amd.com>, Alexander.Deucher@amd.com
References: <20200227142642.3661-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <331d3bea-bc02-bdd7-0772-3cd7c4937e1e@amd.com>
Date: Thu, 27 Feb 2020 15:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200227142642.3661-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::27) To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR10CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Thu, 27 Feb 2020 14:41:59 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e8b52a4-725a-4303-1518-08d7bb9333f0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1425:|BN6PR12MB1425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1425F02358C0BC5ADAEF433683EB0@BN6PR12MB1425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(39840400004)(346002)(189003)(199004)(6636002)(2906002)(5660300002)(2616005)(6666004)(16526019)(478600001)(45080400002)(6486002)(66556008)(66946007)(66476007)(66574012)(36756003)(186003)(8676002)(81156014)(81166006)(4326008)(316002)(31696002)(8936002)(31686004)(86362001)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1425;
 H:BN6PR12MB1699.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8xju7kYtwWWv69rFvYjmDlgzp6YikLmOT9APzcNLdzTOlSqkGlwDZuj9TkgZ1Z4+c4XIsxhYt3S3SbmSHaZNTvGK5bPpQpg5h+eIed+t4KsWdiXl1GBKskRUKuWpgp0FGjHHPSG5mum3F+43i2i5qpNq+4eJ8vQJUwT4seFKIKTmJ4q8nFV6835a5ET04zrMwLdFuCu0ffNEl7AtPa6m734wQ/OIRDOar6kgJiCOSJi+Ur656611WsvNSI7+UVqT5AAQOBQIFjhfqg9fwsNgDcCIy4Q24aTIVgkNaPezPJTcSvLm+cr6NedZ53tniHSPlAOZGR00+bxrTVJLm1aKWLQaqIeOdQZwnkEGKcT6oD/H2pvHJLckdg1LxqDd1QWCNXkwrJ6uVIpM620oJKGTBuL3Pw+hq1ITV8/AjQ6LKyr4bGH9JzxqjcW3dDsWAUc
X-MS-Exchange-AntiSpam-MessageData: 89d+lFBR8u7hck55k2jrZaYqNSqRwyokCBfwSoDpJoEshr+58vHwXw+LUFDUTKL1o2g0AavlcpLM9UtH3C4cOBGbVOG3rS/GD3OkmeL2XQpEjT2szhlH3Azbltc+kBKsnbsNZbfKMe+QTcM/ZmYC53y6wFN5A3EGgnKDqpXzMBxOpSn97T08X0OXDaKNa7J+eQ64jLgPe/kPnwnC5dwZhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b52a4-725a-4303-1518-08d7bb9333f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 14:42:00.3892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGNpzP4Q4YDYXGaNq57g4abkg4MkyBy3yt0CoMo5Y07v1V/J6lAhg+PNF/3N4puV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1425
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDIuMjAgdW0gMTU6MjYgc2NocmllYiBZaW50aWFuIFRhbzoKPiBJZiB3ZSByZWxlYXNl
IGRybV9kZXZpY2UgYmVmb3JlIGFtZGdwdV9kcml2ZXJfdW5sb2FkX2ttcywKPiB0aGVuIGl0IHdp
bGwgcmFpc2UgdGhlIGVycm9yIGJlbG93LiBUaGVyZWZvcmUsIHdlIG5lZWQgdG8KPiBwbGFjZSBp
dCBiZWZvcmUgYW1kZ3B1X2RyaXZlcl91bmxvYWRfa21zLgo+IFsgICA0My4wNTU3MzZdIE1lbW9y
eSBtYW5hZ2VyIG5vdCBjbGVhbiBkdXJpbmcgdGFrZWRvd24uCj4gWyAgIDQzLjA1NTc3N10gV0FS
TklORzogQ1BVOiAxIFBJRDogMjgwNyBhdCAvYnVpbGQvbGludXgtaHdlLTlLSjA3cS9saW51eC1o
d2UtNC4xOC4wL2RyaXZlcnMvZ3B1L2RybS9kcm1fbW0uYzo5MTMgZHJtX21tX3Rha2Vkb3duKzB4
MjQvMHgzMCBbZHJtXQo+IFsgICA0My4wNTU3NzhdIE1vZHVsZXMgbGlua2VkIGluOiBhbWRncHUo
T0UtKSBhbWRfc2NoZWQoT0UpIGFtZHR0bShPRSkgYW1ka2NsKE9FKSBhbWRfaW9tbXVfdjIgZHJt
X2ttc19oZWxwZXIgZHJtIGkyY19hbGdvX2JpdCBmYl9zeXNfZm9wcyBzeXNjb3B5YXJlYSBzeXNm
aWxscmVjdCBzeXNpbWdibHQgc25kX2hkYV9jb2RlY19nZW5lcmljIG5maXQga3ZtX2ludGVsIGt2
bSBpcnFieXBhc3MgY3JjdDEwZGlmX3BjbG11bCBjcmMzMl9wY2xtdWwgc25kX2hkYV9pbnRlbCBz
bmRfaGRhX2NvZGVjIHNuZF9oZGFfY29yZSBzbmRfaHdkZXAgc25kX3BjbSBnaGFzaF9jbG11bG5p
X2ludGVsIHNuZF9zZXFfbWlkaSBzbmRfc2VxX21pZGlfZXZlbnQgcGNiYyBzbmRfcmF3bWlkaSBz
bmRfc2VxIHNuZF9zZXFfZGV2aWNlIGFlc25pX2ludGVsIHNuZF90aW1lciBqb3lkZXYgYWVzX3g4
Nl82NCBjcnlwdG9fc2ltZCBjcnlwdGQgZ2x1ZV9oZWxwZXIgc25kIHNvdW5kY29yZSBpbnB1dF9s
ZWRzIG1hY19oaWQgc2VyaW9fcmF3IHFlbXVfZndfY2ZnIGJpbmZtdF9taXNjIHNjaF9mcV9jb2Rl
bCBuZnNkIGF1dGhfcnBjZ3NzIG5mc19hY2wgbG9ja2QgZ3JhY2Ugc3VucnBjIHBhcnBvcnRfcGMg
cHBkZXYgbHAgcGFycG9ydCBpcF90YWJsZXMgeF90YWJsZXMgYXV0b2ZzNCBoaWRfZ2VuZXJpYyBm
bG9wcHkgdXNiaGlkIHBzbW91c2UgaGlkIGkyY19waWl4NCBlMTAwMCBwYXRhX2FjcGkKPiBbICAg
NDMuMDU1ODE5XSBDUFU6IDEgUElEOiAyODA3IENvbW06IG1vZHByb2JlIFRhaW50ZWQ6IEcgICAg
ICAgICAgIE9FICAgICA0LjE4LjAtMTUtZ2VuZXJpYyAjMTZ+MTguMDQuMS1VYnVudHUKPiBbICAg
NDMuMDU1ODIwXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlY
LCAxOTk2KSwgQklPUyAxLjEyLjAtMSAwNC8wMS8yMDE0Cj4gWyAgIDQzLjA1NTgzMF0gUklQOiAw
MDEwOmRybV9tbV90YWtlZG93bisweDI0LzB4MzAgW2RybV0KPiBbICAgNDMuMDU1ODMxXSBDb2Rl
OiA4NCAwMCAwMCAwMCAwMCAwMCAwZiAxZiA0NCAwMCAwMCA0OCA4YiA0NyAzOCA0OCA4MyBjNyAz
OCA0OCAzOSBjNyA3NSAwMiBmMyBjMyA1NSA0OCBjNyBjNyAzOCAzMyA4MCBjMCA0OCA4OSBlNSBl
OCAxYyA0MSBlYyBkMCA8MGY+IDBiIDVkIGMzIDBmIDFmIDg0IDAwIDAwIDAwIDAwIDAwIDBmIDFm
IDQ0IDAwIDAwIDU1IDQ4IDg5IGU1IDQxCj4gWyAgIDQzLjA1NTg1N10gUlNQOiAwMDE4OmZmZmZh
ZTMzYzEzOTNkMjggRUZMQUdTOiAwMDAxMDI4Ngo+IFsgICA0My4wNTU4NTldIFJBWDogMDAwMDAw
MDAwMDAwMDAwMCBSQlg6IGZmZmY5NjUxYjRhMjk4MDAgUkNYOiAwMDAwMDAwMDAwMDAwMDA2Cj4g
WyAgIDQzLjA1NTg2MF0gUkRYOiAwMDAwMDAwMDAwMDAwMDA3IFJTSTogMDAwMDAwMDAwMDAwMDA5
NiBSREk6IGZmZmY5NjUxYmZjOTY0YjAKPiBbICAgNDMuMDU1ODYxXSBSQlA6IGZmZmZhZTMzYzEz
OTNkMjggUjA4OiAwMDAwMDAwMDAwMDAwMmE2IFIwOTogMDAwMDAwMDAwMDAwMDAwNAo+IFsgICA0
My4wNTU4NjFdIFIxMDogZmZmZmFlMzNjMTM5M2QyMCBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEy
OiBmZmZmOTY1MWJhNmNiMDAwCj4gWyAgIDQzLjA1NTg2M10gUjEzOiBmZmZmOTY1MWI3ZjQwMDAw
IFIxNDogZmZmZmZmZmZjMGRlM2ExMCBSMTU6IGZmZmY5NjUxYmE1YzY0NjAKPiBbICAgNDMuMDU1
ODY0XSBGUzogIDAwMDA3ZjFkM2MwOGQ1NDAoMDAwMCkgR1M6ZmZmZjk2NTFiZmM4MDAwMCgwMDAw
KSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCj4gWyAgIDQzLjA1NTg2NV0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwo+IFsgICA0My4wNTU4NjZdIENSMjog
MDAwMDU2MzBhNTgzMTY0MCBDUjM6IDAwMDAwMDAxMmUyNzQwMDQgQ1I0OiAwMDAwMDAwMDAwMzYw
NmUwCj4gWyAgIDQzLjA1NTg3MF0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAw
MDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKPiBbICAgNDMuMDU1ODcxXSBEUjM6IDAwMDAw
MDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMAo+
IFsgICA0My4wNTU4NzFdIENhbGwgVHJhY2U6Cj4gWyAgIDQzLjA1NTg4NV0gIGRybV92bWFfb2Zm
c2V0X21hbmFnZXJfZGVzdHJveSsweDFiLzB4MzAgW2RybV0KPiBbICAgNDMuMDU1ODk0XSAgZHJt
X2dlbV9kZXN0cm95KzB4MTkvMHg0MCBbZHJtXQo+IFsgICA0My4wNTU5MDNdICBkcm1fZGV2X2Zp
bmkrMHg3Zi8weDkwIFtkcm1dCj4gWyAgIDQzLjA1NTkxMV0gIGRybV9kZXZfcmVsZWFzZSsweDJi
LzB4NDAgW2RybV0KPiBbICAgNDMuMDU1OTE5XSAgZHJtX2Rldl91bnBsdWcrMHg2NC8weDgwIFtk
cm1dCj4gWyAgIDQzLjA1NTk5NF0gIGFtZGdwdV9wY2lfcmVtb3ZlKzB4MzkvMHg3MCBbYW1kZ3B1
XQo+IFsgICA0My4wNTU5OThdICBwY2lfZGV2aWNlX3JlbW92ZSsweDNlLzB4YzAKPiBbICAgNDMu
MDU2MDAxXSAgZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFsKzB4MThhLzB4MjYwCj4gWyAg
IDQzLjA1NjAwM10gIGRyaXZlcl9kZXRhY2grMHgzZi8weDgwCj4gWyAgIDQzLjA1NjAwNF0gIGJ1
c19yZW1vdmVfZHJpdmVyKzB4NTkvMHhkMAo+IFsgICA0My4wNTYwMDZdICBkcml2ZXJfdW5yZWdp
c3RlcisweDJjLzB4NDAKPiBbICAgNDMuMDU2MDA4XSAgcGNpX3VucmVnaXN0ZXJfZHJpdmVyKzB4
MjIvMHhhMAo+IFsgICA0My4wNTYwODddICBhbWRncHVfZXhpdCsweDE1LzB4NTdjIFthbWRncHVd
Cj4gWyAgIDQzLjA1NjA5MF0gIF9feDY0X3N5c19kZWxldGVfbW9kdWxlKzB4MTQ2LzB4MjgwCj4g
WyAgIDQzLjA1NjA5NF0gIGRvX3N5c2NhbGxfNjQrMHg1YS8weDEyMAo+Cj4gdjI6IHB1dCBkcm1f
ZGV2X3B1dCBhZnRlciBwY2lfc2V0X2RydmRhdGEKPgo+IFNpZ25lZC1vZmYtYnk6IFlpbnRpYW4g
VGFvIDx5dHRhb0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMK
PiBpbmRleCAwMmQ4MGI5ZGJmZTEuLmJlYzQzMzcxNTZhNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtMTEzOCwxMCArMTEzOCwxMCBAQCBhbWRncHVf
cGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKPiAgICNlbmRpZgo+ICAgCQlEUk1fRVJS
T1IoIkhvdHBsdWcgcmVtb3ZhbCBpcyBub3Qgc3VwcG9ydGVkXG4iKTsKPiAgIAlkcm1fZGV2X3Vu
cGx1ZyhkZXYpOwo+IC0JZHJtX2Rldl9wdXQoZGV2KTsKPiAgIAlhbWRncHVfZHJpdmVyX3VubG9h
ZF9rbXMoZGV2KTsKPiAgIAlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7Cj4gICAJcGNpX3NldF9k
cnZkYXRhKHBkZXYsIE5VTEwpOwo+ICsJZHJtX2Rldl9wdXQoZGV2KTsKPiAgIH0KPiAgIAo+ICAg
c3RhdGljIHZvaWQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
