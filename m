Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F379C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C07222C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xXgMp4hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C07222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F44F6EB2E;
	Wed, 11 Dec 2019 12:20:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D03D6EB2E
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 12:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDcJZ2Tqd1mpq67SmU/KBz4Hc/ssENMfxxN8comVHkNcj9t7y8dpXNIZAZJRZuoh349soq4bTacxCvePI7tnIzgN/dgclqNAxrrqkeFTI2TxxH2V1bHo6XQHCXOdJ1WPt4A6RVDOUnW1dHDZlQ8+VugZpbKtmVqgFoj3wkU5ZTbT0uhdIKnRbwzRdCNuBnT/6f2cZtrAVnp/9NShD0KgOE0zHmz/YMeo1dvRK5F0uiqhYC2xgrEK65nn5T4nR8GVq0KHJu/33seGSsPvFeWx65A9IP0WPT2ZDnfGL+2wHybiC88aJLFIYLYUd3RVRNteqMpIirYEc6TKBPwRGpvbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ56HTKJFIisMT99BUWVrZLJv6lRqBRap5xNCqSVqOM=;
 b=mzJpLWRX4x8XBFaNhajoeMRJNweAhqCHpyvt3bMJmxKe2o7NpiOJPPrTmfWHhCbDEeL3h/9M5Aj3PSFpQ4WXpB1N02+08lQrkomF4fNe3kljbGipgmXk6NBQJSfgz0fOkWnuwE9iVBKsVCp1ACqhkp9BGeeROMKHM2DXa7bZeLgbEh2cGMwXJKLyfca8KiolNuK4EN7YWghAWKubSC3NXTJbThLu+4EI1cizNmubBG2Ccy9Sgy1ihMaGd9mMWvdchXg+AM92iWL4CcbjqSvG8n/JJlEZmTq//6eUDCb7stzYeiBLlQtVA7Q88ijIiFG8xHNTykZ4nluh8XM13P+klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ56HTKJFIisMT99BUWVrZLJv6lRqBRap5xNCqSVqOM=;
 b=xXgMp4hjv49M8QN+OYDQ2btWfcxuiHsXA08H8Z9BQv4sYHASFpOReOOp/d30bX8sgaTOZ7uUOFJxP/CtOdiTh5gilQDisu2fZHltrd7gG2vYYRb+xvnEhLTIRUOLmIxI1xNZEgx7kkoLxXarDVu2OWtJyRx7SDTP5xvT7OLt6Bo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.34.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Wed, 11 Dec 2019 12:20:28 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 12:20:28 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: add invalidate semaphore limit for SRIOV
 and picasso in gmc9
To: "Changfeng.Zhu" <changfeng.zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 Ray.Huang@amd.com, Xinmei.Huang@amd.com, Alexander.Deucher@amd.com
References: <20191211073605.27847-1-changfeng.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dd13bdb1-b425-5f9f-9d0c-3fa2d4138a91@amd.com>
Date: Wed, 11 Dec 2019 13:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191211073605.27847-1-changfeng.zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f84a3e88-d93b-4113-2cc3-08d77e3481a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:|DM5PR12MB1692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16928A70CF6C6EB3099CE64D835A0@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(478600001)(36756003)(81166006)(31696002)(8676002)(52116002)(5660300002)(86362001)(8936002)(31686004)(81156014)(186003)(2616005)(6486002)(66946007)(2906002)(6512007)(6636002)(316002)(6666004)(6506007)(66556008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1692;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvL3IoYGHWBsyZQpe8O9WvwBZYLxGTw0WDbk2Ryqf8lwR984fkMljfcB5rnzkO+shGSXv0cOL3il/bW2l3Hgj1OZy6h1+10E+m58gmhxSEtKdj9hJcVuwCC988uUDQ/vuj2WHi2MySS3TFicb3Gpvpr0n8UrkIJw4MmqZKkBSbj1TEBuYzcfaD0VrucLkTifzwDWY68N1S6SOwhfSl+/nzLU7FJ7WJFr2Oj9ATNvsaBeLqQIk9sJEnsimo5qbE1SO5nqCXLM4EEiBMq1bAAVxVYr8xnzFd+ZRcxOuGRCwQ0oYcqjTaFdpilqUKycw6VL1ENmEOWSovP15ok6l+KmRY0vADZsdftZ8TS8XDx5qSO4WH2mxCLxUgArXcOSbc7abdUgBNYFohCsHNVdPhXevBv32FYc1WuuMk/xMSI0CzOGD+mcHyQkmU1ZrTrvmXwn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84a3e88-d93b-4113-2cc3-08d77e3481a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 12:20:28.2733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqIZP5GVguNoSDEJoPpN/ODnnmmx5Wspd2YEbawvOf8FYq47kiB3kUhlxPfzDw0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMTIuMTkgdW0gMDg6MzYgc2NocmllYiBDaGFuZ2ZlbmcuWmh1Ogo+IEZyb206IGNoYW5n
emh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4KPiBJdCBtYXkgZmFpbCB0byBsb2FkIGd1ZXN0
IGRyaXZlciBpbiByb3VuZCAyIG9yIGNhdXNlIFhzdGFydCBwcm9ibGVtCj4gd2hlbiB1c2luZyBp
bnZhbGlkYXRlIHNlbWFwaG9yZSBmb3IgU1JJT1Ygb3IgcGljYXNzby4gU28gaXQgbmVlZHMgYXZv
aWQKPiB1c2luZyBpbnZhbGlkYXRlIHNlbWFwaG9yZSBmb3IgU1JJT1YgYW5kIHBpY2Fzc28uCj4K
PiBDaGFuZ2UtSWQ6IEk4MDZmOGU5OWVjOTdiZTg0ZTZhZWQwZjVjNDk5YTUzYjE5MzFiNDkwCj4g
U2lnbmVkLW9mZi1ieTogY2hhbmd6aHUgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KClJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGUg
c2VyaWVzLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMg
fCA0NCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z21jX3Y5XzAuYwo+IGluZGV4IDYwMTY2NzI0NmExYy4uZWZhNTVlOTY3NmJlIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gQEAgLTQxMiw2ICs0MTIsMjQgQEAgc3Rh
dGljIHVpbnQzMl90IGdtY192OV8wX2dldF9pbnZhbGlkYXRlX3JlcSh1bnNpZ25lZCBpbnQgdm1p
ZCwKPiAgIAlyZXR1cm4gcmVxOwo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBnbWNfdjlfMF91c2Vf
aW52YWxpZGF0ZV9zZW1hcGhvcmUgLSBqdWRnZSB3aGV0aGVyIHRvIHVzZSBzZW1hcGhvcmUKPiAr
ICoKPiArICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICsgKiBAdm1odWI6IHZtaHVi
IHR5cGUKPiArICoKPiArICovCj4gK3N0YXRpYyBib29sIGdtY192OV8wX3VzZV9pbnZhbGlkYXRl
X3NlbWFwaG9yZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiArCQkJCSAgICAgICB1aW50
MzJfdCB2bWh1YikKPiArewo+ICsJcmV0dXJuICgodm1odWIgPT0gQU1ER1BVX01NSFVCXzAgfHwK
PiArCQkgdm1odWIgPT0gQU1ER1BVX01NSFVCXzEpICYmCj4gKwkJKCFhbWRncHVfc3Jpb3ZfdmYo
YWRldikpICYmCj4gKwkJKCEoYWRldi0+YXNpY190eXBlID09IENISVBfUkFWRU4gJiYKPiArCQkg
ICBhZGV2LT5yZXZfaWQgPCAweDggJiYKPiArCQkgICBhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgx
NWQ4KSkpOwo+ICt9Cj4gKwo+ICAgLyoKPiAgICAqIEdBUlQKPiAgICAqIFZNSUQgMCBpcyB0aGUg
cGh5c2ljYWwgR1BVIGFkZHJlc3NlcyBhcyB1c2VkIGJ5IHRoZSBrZXJuZWwuCj4gQEAgLTQzMSw2
ICs0NDksNyBAQCBzdGF0aWMgdWludDMyX3QgZ21jX3Y5XzBfZ2V0X2ludmFsaWRhdGVfcmVxKHVu
c2lnbmVkIGludCB2bWlkLAo+ICAgc3RhdGljIHZvaWQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKPiAgIAkJCQkJdWludDMy
X3Qgdm1odWIsIHVpbnQzMl90IGZsdXNoX3R5cGUpCj4gICB7Cj4gKwlib29sIHVzZV9zZW1hcGhv
cmUgPSBnbWNfdjlfMF91c2VfaW52YWxpZGF0ZV9zZW1hcGhvcmUoYWRldiwgdm1odWIpOwo+ICAg
CWNvbnN0IHVuc2lnbmVkIGVuZyA9IDE3Owo+ICAgCXUzMiBqLCB0bXA7Cj4gICAJc3RydWN0IGFt
ZGdwdV92bWh1YiAqaHViOwo+IEBAIC00NjQsMTEgKzQ4Myw3IEBAIHN0YXRpYyB2b2lkIGdtY192
OV8wX2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZt
aWQsCj4gICAJICovCj4gICAKPiAgIAkvKiBUT0RPOiBJdCBuZWVkcyB0byBjb250aW51ZSB3b3Jr
aW5nIG9uIGRlYnVnZ2luZyB3aXRoIHNlbWFwaG9yZSBmb3IgR0ZYSFVCIGFzIHdlbGwuICovCj4g
LQlpZiAoKHZtaHViID09IEFNREdQVV9NTUhVQl8wIHx8Cj4gLQkgICAgIHZtaHViID09IEFNREdQ
VV9NTUhVQl8xKSAmJgo+IC0JICAgICghKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX1JBVkVOICYm
Cj4gLQkgICAgICAgYWRldi0+cmV2X2lkIDwgMHg4ICYmCj4gLQkgICAgICAgYWRldi0+cGRldi0+
ZGV2aWNlID09IDB4MTVkOCkpKSB7Cj4gKwlpZiAodXNlX3NlbWFwaG9yZSkgewo+ICAgCQlmb3Ig
KGogPSAwOyBqIDwgYWRldi0+dXNlY190aW1lb3V0OyBqKyspIHsKPiAgIAkJCS8qIGEgcmVhZCBy
ZXR1cm4gdmFsdWUgb2YgMSBtZWFucyBzZW1hcGhvcmUgYWN1cWlyZSAqLwo+ICAgCQkJdG1wID0g
UlJFRzMyX05PX0tJUShodWItPnZtX2ludl9lbmcwX3NlbSArIGVuZyk7Cj4gQEAgLTQ5OCwxMSAr
NTEzLDcgQEAgc3RhdGljIHZvaWQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKPiAgIAl9Cj4gICAKPiAgIAkvKiBUT0RPOiBJ
dCBuZWVkcyB0byBjb250aW51ZSB3b3JraW5nIG9uIGRlYnVnZ2luZyB3aXRoIHNlbWFwaG9yZSBm
b3IgR0ZYSFVCIGFzIHdlbGwuICovCj4gLQlpZiAoKHZtaHViID09IEFNREdQVV9NTUhVQl8wIHx8
Cj4gLQkgICAgIHZtaHViID09IEFNREdQVV9NTUhVQl8xKSAmJgo+IC0JICAgICghKGFkZXYtPmFz
aWNfdHlwZSA9PSBDSElQX1JBVkVOICYmCj4gLQkgICAgICAgYWRldi0+cmV2X2lkIDwgMHg4ICYm
Cj4gLQkgICAgICAgYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkpKQo+ICsJaWYgKHVzZV9z
ZW1hcGhvcmUpCj4gICAJCS8qCj4gICAJCSAqIGFkZCBzZW1hcGhvcmUgcmVsZWFzZSBhZnRlciBp
bnZhbGlkYXRpb24sCj4gICAJCSAqIHdyaXRlIHdpdGggMCBtZWFucyBzZW1hcGhvcmUgcmVsZWFz
ZQo+IEBAIC01MjAsNiArNTMxLDcgQEAgc3RhdGljIHZvaWQgZ21jX3Y5XzBfZmx1c2hfZ3B1X3Rs
YihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgdm1pZCwKPiAgIHN0YXRpYyB1
aW50NjRfdCBnbWNfdjlfMF9lbWl0X2ZsdXNoX2dwdV90bGIoc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nLAo+ICAgCQkJCQkgICAgdW5zaWduZWQgdm1pZCwgdWludDY0X3QgcGRfYWRkcikKPiAgIHsK
PiArCWJvb2wgdXNlX3NlbWFwaG9yZSA9IGdtY192OV8wX3VzZV9pbnZhbGlkYXRlX3NlbWFwaG9y
ZShyaW5nLT5hZGV2LCByaW5nLT5mdW5jcy0+dm1odWIpOwo+ICAgCXN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2ID0gcmluZy0+YWRldjsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtaHViICpodWIgPSAm
YWRldi0+dm1odWJbcmluZy0+ZnVuY3MtPnZtaHViXTsKPiAgIAl1aW50MzJfdCByZXEgPSBnbWNf
djlfMF9nZXRfaW52YWxpZGF0ZV9yZXEodm1pZCwgMCk7Cj4gQEAgLTUzMywxMSArNTQ1LDcgQEAg
c3RhdGljIHVpbnQ2NF90IGdtY192OV8wX2VtaXRfZmx1c2hfZ3B1X3RsYihzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcsCj4gICAJICovCj4gICAKPiAgIAkvKiBUT0RPOiBJdCBuZWVkcyB0byBjb250
aW51ZSB3b3JraW5nIG9uIGRlYnVnZ2luZyB3aXRoIHNlbWFwaG9yZSBmb3IgR0ZYSFVCIGFzIHdl
bGwuICovCj4gLQlpZiAoKHJpbmctPmZ1bmNzLT52bWh1YiA9PSBBTURHUFVfTU1IVUJfMCB8fAo+
IC0JICAgICByaW5nLT5mdW5jcy0+dm1odWIgPT0gQU1ER1BVX01NSFVCXzEpICYmCj4gLQkgICAg
KCEoYWRldi0+YXNpY190eXBlID09IENISVBfUkFWRU4gJiYKPiAtCSAgICAgICBhZGV2LT5yZXZf
aWQgPCAweDggJiYKPiAtCSAgICAgICBhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgxNWQ4KSkpCj4g
KwlpZiAodXNlX3NlbWFwaG9yZSkKPiAgIAkJLyogYSByZWFkIHJldHVybiB2YWx1ZSBvZiAxIG1l
YW5zIHNlbWFwaG9yZSBhY3VxaXJlICovCj4gICAJCWFtZGdwdV9yaW5nX2VtaXRfcmVnX3dhaXQo
cmluZywKPiAgIAkJCQkJICBodWItPnZtX2ludl9lbmcwX3NlbSArIGVuZywgMHgxLCAweDEpOwo+
IEBAIC01NTMsMTEgKzU2MSw3IEBAIHN0YXRpYyB1aW50NjRfdCBnbWNfdjlfMF9lbWl0X2ZsdXNo
X2dwdV90bGIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCQkJCQkgICAgcmVxLCAxIDw8
IHZtaWQpOwo+ICAgCj4gICAJLyogVE9ETzogSXQgbmVlZHMgdG8gY29udGludWUgd29ya2luZyBv
biBkZWJ1Z2dpbmcgd2l0aCBzZW1hcGhvcmUgZm9yIEdGWEhVQiBhcyB3ZWxsLiAqLwo+IC0JaWYg
KChyaW5nLT5mdW5jcy0+dm1odWIgPT0gQU1ER1BVX01NSFVCXzAgfHwKPiAtCSAgICAgcmluZy0+
ZnVuY3MtPnZtaHViID09IEFNREdQVV9NTUhVQl8xKSAmJgo+IC0JICAgICghKGFkZXYtPmFzaWNf
dHlwZSA9PSBDSElQX1JBVkVOICYmCj4gLQkgICAgICAgYWRldi0+cmV2X2lkIDwgMHg4ICYmCj4g
LQkgICAgICAgYWRldi0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkpKQo+ICsJaWYgKHVzZV9zZW1h
cGhvcmUpCj4gICAJCS8qCj4gICAJCSAqIGFkZCBzZW1hcGhvcmUgcmVsZWFzZSBhZnRlciBpbnZh
bGlkYXRpb24sCj4gICAJCSAqIHdyaXRlIHdpdGggMCBtZWFucyBzZW1hcGhvcmUgcmVsZWFzZQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
