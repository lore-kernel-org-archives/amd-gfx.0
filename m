Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1122087E
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rWxeuuS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1122087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4756E958;
	Mon, 20 Jan 2020 13:36:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFC46E958
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 13:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNesgjUwMtuJIHt0T92c4r2/yCLD95aClcOjiavf+4r202RStFmnDx1HKApFPhv2TN2XIxEUn+6AngFR4bOlesS10p0FZdbG18WeE5pV/2WYUq21nfTYAeg34X2w0t0z9jOeS8OvHjrWZtQFHojtj99qHcprSMu2R9zZxU/O3Y5ybtcKbXm0T2W/1oKMDh6Y9R9dvrttaVi0PGuNKdl7Yrme6taReiF4xNfyEWKDdoE2COIgFDLqCEHq2lYyP9uVHAbm0e1Xz3SlZjWks+sXEPEEuzzOg+g8wGLv88442mOuJUyzgNjpydvyNcfMh5uhwxwOd/yFTyEJqY7hkT6Ojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9AbOs7AhGSKbWfpQXIRqvFpKJq3+jUql2miWLLa7nU=;
 b=DM8QteOSgMXa8hpgtCBSoEbBYFV21+Ja/oU884X45w8eZLtBfIOOJGJzJ/udiURitlZpBerqXFSdCHUm+cL6lg4DXYM1g7kShDU0Q+TfXOSpgksx4+e4w6MIA9sPEdcRIygabx8kA8jdqYFSMbo0Lbd0NDZvfAsvnJaMOQnCaO4j6l/nLpAPuhseL/6JYuAL9avuZU1J9huz1HOe/PuUPfSgurfHioE9hS37wFu5nZtj6yQ3nRp0t5JNGunEv/ndEUTaxO46kzjmklzByGP3hdHDAikEd4xaiI2A/AEdj28Pt5dJcj6CCDVW4nRgj+sJCPbs96nBoLzqC4XBkvG0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9AbOs7AhGSKbWfpQXIRqvFpKJq3+jUql2miWLLa7nU=;
 b=rWxeuuS8rGt2EqREQMOTagK2G8rpZkf45//3Y+t4PTzP/q7BkGFdesmfavtwAg7KfCZV5N9ZNyXgDVgFR/KUkvWd7Iuq8mziyKSx+qgGq+3g7g77i3SOGBRVeDhdGPnxEoKJ/8xEGzDOm6bqQzKLhasBfmukBMHfBb59MT0DlCI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2374.namprd12.prod.outlook.com (52.132.141.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Mon, 20 Jan 2020 13:36:47 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 13:36:47 +0000
Subject: Re: [PATCH] drm/amdgpu: fix a typo atleast -> at least
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org,
 luben.tuikov@amd.com
References: <20200120133621.7911-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1bb20182-0ddf-49ab-2dc8-e8e71b912bb9@amd.com>
Date: Mon, 20 Jan 2020 14:36:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200120133621.7911-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::19) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 13:36:45 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1774a437-6fdb-485f-b417-08d79dadcc1d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2374:|DM5PR12MB2374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB237447E53E3D97AD6B0F5FAF83320@DM5PR12MB2374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0288CD37D9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(66574012)(36756003)(316002)(52116002)(6486002)(478600001)(81166006)(186003)(2616005)(8676002)(81156014)(8936002)(16526019)(86362001)(6666004)(4326008)(31696002)(2906002)(31686004)(5660300002)(4744005)(66556008)(66946007)(66476007)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2374;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhUmZ3RdH9EI4jDHy7uWTvwwOaGpYcgdfK3vwKTaihQvFPcU4ACnyh39v0NDo4e8OHay/kfs31vtKHB6570J6GZt3JP2Eh1gdL5TxhykEZpRw+2WTaGJYIyqudLAhIOJgNhrGNaQbOOe7KTAziA5YKnXYRApVB4n1/s+DvYu+cJnAd475M3lyoifv2XUR/lJ+fj/nQY93KftcPUEpmlKQVZfhBdATIr8KSJVJfvDONtI6Y/wbKmJCeG0aOLFWxL6cCXMoOpzpaU4HkUEykY3XKXF/koeJtA0F2lwaYQs72up8PdhiRrp5w2rCM825noYZefbBfP5nshES0Zpqfvr3tilNWae+OEPPQZG0IPXYBlkdEJd654Mkrf8tJ0TMwW8XOcjtFtKm2EBgAlEUqZ49myKzXNc4AfqpBsJyPhBIxRwjp4RW8XBvIe35wYwm8a1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774a437-6fdb-485f-b417-08d79dadcc1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 13:36:47.7525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcK3Z48hY9X9GOmKrRwAGv/YlXKOzfM+RctsXcJ7zm2A+blgo47suE2bDoCU9ymd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2374
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDEuMjAgdW0gMTQ6MzYgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeGVzOiBiOGM4YjIz
ZjU4YzcxIChkcm0vc2NoZWR1bGVyOiBmaXggZG9jdW1lbnRhdGlvbiBieSByZXBsYWNpbmcgcnFf
bGlzdCB3aXRoCj4gc2NoZWRfbGlzdCkKPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5p
cm1veS5kYXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9lbnRpdHkuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIv
c2NoZWRfZW50aXR5LmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5j
Cj4gaW5kZXggZWM3OWU4ZTVhZDNjLi42M2JjY2QyMDFiOTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPiBAQCAtNDUsNyArNDUsNyBAQAo+ICAgICogQGd1
aWx0eTogYXRvbWljX3Qgc2V0IHRvIDEgd2hlbiBhIGpvYiBvbiB0aGlzIHF1ZXVlCj4gICAgKiAg
ICAgICAgICBpcyBmb3VuZCB0byBiZSBndWlsdHkgY2F1c2luZyBhIHRpbWVvdXQKPiAgICAqCj4g
LSAqIE5vdGU6IHRoZSBzY2hlZF9saXN0IHNob3VsZCBoYXZlIGF0bGVhc3Qgb25lIGVsZW1lbnQg
dG8gc2NoZWR1bGUKPiArICogTm90ZTogdGhlIHNjaGVkX2xpc3Qgc2hvdWxkIGhhdmUgYXQgbGVh
c3Qgb25lIGVsZW1lbnQgdG8gc2NoZWR1bGUKPiAgICAqICAgICAgIHRoZSBlbnRpdHkKPiAgICAq
Cj4gICAgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24g
ZmFpbHVyZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
