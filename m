Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC90BC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 12:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAE32051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 12:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RuZD97/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAE32051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA0D89F75;
	Mon, 16 Mar 2020 12:17:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70B989F75
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 12:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEG+pfT09O+3PpIkYCR/Ly0F8bXIunpkCNhq2hvCaq8kiUwB9qEbGeosGX+ki5bydaKExiVR6FXNt7wfM7N71Dh4lfCNgjTNqe3WjL2cb6opTvuaOdi7mYWY+wQn5AG+K2tSXVP2a3YxPBXTWiyo5Pfgt9/YYEWpvX1bpwt0YDJZAinObfgqhTof6nQsLvngo5vCuay9BnWoWo+WLC0H7s4aPLvxZ4LfTwBWVpMdbAz0XGjDV8nMhTrzEkDefM0637AWQOdVxKFBiUfDriEjTjHW7rrZrJMKjtgyuNpKmwWutPlEUC8MiLpUO459Y8eNu/SNw+NYEhD9S+U4riVJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOxSq6384J3z03OvtqchvPxUma4IjBtmmpBcUKuOQRY=;
 b=TElrorSjbNKC6sdZjrCQyZ1xAA7n8PLRQd/RegwNafO/wjIqZS7svX5Swv6SfuP5t7tWaqqLncucm0lkqi7vaxlo9qs/ftBF46gWxhCUlw4ZtL1hZ285HcBg4err8ssmXqyjujzGc1SC7yMvgrmqpgnjmox2pt5VNTF8CoB9LdewsjMwDI72MTckOac4WtpZd6hBv11UMYdgSUVEYF7vADISfPnU0Z8EurYa9Dw/isdZcAoF0Hx2hPLXMHTOe7H2cI2sG9knqInab4QCK7MXgN2QwAMKBPw0G4QDWQN1sDPP91x30qKKUcVYvNOXlCTqFAl5nwMxzz9DePJsABkQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOxSq6384J3z03OvtqchvPxUma4IjBtmmpBcUKuOQRY=;
 b=RuZD97/mmiq5W9wUHK4YQoyiErfbMlljjepeuNlmOGgjn5UCRU8hgXzBk3xGVcrCV60YB1Kqf4htA5M4Mofuk9Hf9X6xEx3RV7GPA+YbHZCOoQXz5C/bXPatiMfXz3MP8og+ypERd+Y3XSe5blLoMNIcLQcLIa2YB7MRV3kZbMc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1420.namprd12.prod.outlook.com (2603:10b6:3:78::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Mon, 16 Mar 2020 12:17:22 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::50f0:a148:4f52:701f%11]) with mapi id 15.20.2814.021; Mon, 16 Mar
 2020 12:17:22 +0000
Subject: Re: [PATCH] drm/amdgpu: miss PRT case when bo update
To: Yintian Tao <yttao@amd.com>, Alexander.Deucher@amd.com
References: <20200316100845.1150-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <43ff132e-7fc4-ac19-93e9-5bb870816d0c@amd.com>
Date: Mon, 16 Mar 2020 13:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200316100845.1150-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0076.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::17) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0076.eurprd06.prod.outlook.com (2603:10a6:208:fa::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 12:17:20 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96739b26-c4bd-495d-9474-08d7c9a3fa89
X-MS-TrafficTypeDiagnostic: DM5PR12MB1420:|DM5PR12MB1420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1420D8D9F5707FF97B19696683F90@DM5PR12MB1420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(199004)(66574012)(5660300002)(31696002)(4326008)(36756003)(6636002)(66476007)(66556008)(66946007)(52116002)(86362001)(15650500001)(6486002)(81156014)(8676002)(81166006)(2906002)(6666004)(316002)(8936002)(31686004)(2616005)(16526019)(478600001)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1420;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tukctQIIy2uACt8zFiUB/xgPMV2qsR90yyWexsnIuU/CJGy4qogeKgM8trJe4f7bkNTIy1vbZFcYeR5uuAG5MMY4eBxTKFTo5cNWyBAh75tak3uGMDl0WP//rNo2QjulGinOGoIAFeo9W5j4x69UY6L2WhwpbVl/XTWXZiSw/vQOVIXZjqmUMW0ul0QI33LSbLPXlxkmTP5GiOceoAP83i74opa9cbEpzdFSuikqFiDHZ889T66k+g3WWz6d03D1M4HFRb+1iJOZhQrsf3VezriV+5R4ZJ8z91V2pK/rmy24MU8bbLliRraZ5Idm/AYgy20kbm+qUEVr4JAu/6nLickZvC3smh3cKRGcFuu6//ANa+kHVS0gOQLTi0mlyfkjf+/o5r6AcP2mJfMncEvl7P6WkBBJ9hzWTFZZsP1SSefjE3bMbdXDbl2B55EvTO2
X-MS-Exchange-AntiSpam-MessageData: IK0C272vM4Fnl7Ua4l6T6lrvhgF3xELfTsiyeB7YagmzmUSnn711WXajBP3HOglFeJfyN7cPA+MPOImGT0y1AIS0QMyssiaiwwPZ49eXD/NqMdKrfkp3DDXO/8nE9cykXb6a7U8VZoHjf20nyCenBNIKK/np8YOE6zdmaEoCbbTMsZ1UzQmPUqSwA88M4EDT2z21s7h9qVU2MMqM0/3wQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96739b26-c4bd-495d-9474-08d7c9a3fa89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 12:17:21.8656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKCdsKmqDCsvipuVgltMkZab8l0Y0b0pXJe4rqauIkRbLcrJ+GOxs3dRY9OxOMPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
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

QW0gMTYuMDMuMjAgdW0gMTE6MDggc2NocmllYiBZaW50aWFuIFRhbzoKPiBPcmlnaW5hbGx5LCBv
bmx5IHRoZSBQVEUgdmFsaWQgaXMgdGFrZW4gaW4gY29uc2lkZXIuCj4gVGhlIFBSVCBjYXNlIGlz
IG1pc3NpZWQgd2hlbiBibyB1cGRhdGUgd2hpY2ggcmFpc2UgcHJvYmxlbS4KPiBXZSBuZWVkIGFk
ZCBjb25kaXRpb24gZm9yIFBSVCBjYXNlLgo+Cj4gdjI6IGFkZCBQUlQgY29uZGl0aW9uIGZvciBh
bWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcsIHRvbwoKR29vZCBwb2ludCwgeWVzLiBGZWVsIGZy
ZWUgdG8gY29tbWl0IGl0IGxpa2UgdGhpcywgYnV0IHdlIG1pZ2h0IHdhbnQgdG8gCmFkZCBhIGRl
ZmluZSBmb3IgKEFNREdQVV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1BSVCkgYXQgc29tZSB0aW1l
IHRvIAptYWtlIHRoZSBjb2RlIGVhc2llciB0byByZWFkLgoKR29pbmcgdG8gdGFrZSBjYXJlIG9m
IHRoaXMgYXMgYSBmb2xsb3cgdXAgY2xlYW51cCBhcyBzb29uIGFzIHRoZSBwYXRjaCAKbGFuZHMg
b24gYW1kLXN0YWdpbmctZHJtLW5leHQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IHYzOiBmaXgg
b25lIHR5cG8gZXJyb3IKPgo+IFNpZ25lZC1vZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQu
Y29tPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8
IDYgKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA3MzM5
ODgzMTE5NmYuLjYxNTdmNmE5ZGNjOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4gQEAgLTE0NDYsNyArMTQ0Niw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wdGVzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+ICAgCQl1
aW50NjRfdCBpbmNyLCBlbnRyeV9lbmQsIHBlX3N0YXJ0Owo+ICAgCQlzdHJ1Y3QgYW1kZ3B1X2Jv
ICpwdDsKPiAgIAo+IC0JCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsKPiArCQlpZiAo
ZmxhZ3MgJiAoQU1ER1BVX1BURV9WQUxJRCB8IEFNREdQVV9QVEVfUFJUKSkgewo+ICAgCQkJLyog
bWFrZSBzdXJlIHRoYXQgdGhlIHBhZ2UgdGFibGVzIGNvdmVyaW5nIHRoZQo+ICAgCQkJICogYWRk
cmVzcyByYW5nZSBhcmUgYWN0dWFsbHkgYWxsb2NhdGVkCj4gICAJCQkgKi8KPiBAQCAtMTYwMyw3
ICsxNjAzLDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCX0KPiAg
IAo+IC0JaWYgKGZsYWdzICYgQU1ER1BVX1BURV9WQUxJRCkgewo+ICsJaWYgKGZsYWdzICYgKEFN
REdQVV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1BSVCkpIHsKPiAgIAkJc3RydWN0IGFtZGdwdV9i
byAqcm9vdCA9IHZtLT5yb290LmJhc2UuYm87Cj4gICAKPiAgIAkJaWYgKCFkbWFfZmVuY2VfaXNf
c2lnbmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKPiBAQCAtMTcxOCw3ICsxNzE4LDcgQEAgc3RhdGlj
IGludCBhbWRncHVfdm1fYm9fc3BsaXRfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPiAgIAkJCQkJQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRTsKPiAgIAkJCX0KPiAgIAo+
IC0JCX0gZWxzZSBpZiAoZmxhZ3MgJiBBTURHUFVfUFRFX1ZBTElEKSB7Cj4gKwkJfSBlbHNlIGlm
IChmbGFncyAmIChBTURHUFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9QUlQpKSB7Cj4gICAJCQlh
ZGRyICs9IGJvX2FkZXYtPnZtX21hbmFnZXIudnJhbV9iYXNlX29mZnNldDsKPiAgIAkJCWFkZHIg
Kz0gcGZuIDw8IFBBR0VfU0hJRlQ7Cj4gICAJCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
