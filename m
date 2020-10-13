Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C62C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 15:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA7E251BE
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p3/VgpG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA7E251BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472276E3D8;
	Tue, 13 Oct 2020 15:32:14 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8348E6E117
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 15:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW3dB6fjuR3sI/KBqtfBL5Zd+g6V7NvB/GVdafd6WgXH1kGyHLD792BlArtbu2i1CYqQqKllt+QapDVmB/kEc5DCYRUMitSuZ6Ri30P25kAFzkLPjPKZe7HFWNrzGejf9zs+7YqsP2O6u8QgmGCbH3I03r945e3n8ay5yWR+QssON8dNlXbFTm0+rIv0MRgjrIbj7hUlosGQ3L0jZhTWw9W5ehzwzCJPd71xmIwgCtfE9WQVBWl82mZ1CsC3VZuAe7GkIcgeWNCvALjHduvbAm5fb2YSY8tF0umJfN4mEKx+JDw9IuNdF3OuvE5/31h3+WkptAJ1PzvQg1YJAVil+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qBeOpNzj1nfOk6jZjYk5p/iUSJgqy8BQd2R8AlOa7g=;
 b=I4fTMBiyUSVyebYIxNhELZOGnc5RQOQpPRtK59Tsv8se8PE8iKvSUOSWY7kv9PU+nanlzxnKguuJDk8ZSlWNWzqBEpczroUPmtKPrH3hYHMFNbkTkjTIDBNqcDbV70O+HgSWJ69OAfd/TCWMEamGmhHSp6g9xFaQUOpdQ6He6/IVF9SbCd6aUSjDDNNnlbAeSrq19hWuuNn+qxOLlA1LkeHy3mVarayMow2nTNRcHCT23Ao10nuPetiUgW0VlkXL1wjqd62roVvhcZiuUCY6LYgo+AFAOt6wl9jLibY9Q8d4IRKv2tggTjJAB1ym4nVXU3D8vLyuzcNN6WVB7UkwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qBeOpNzj1nfOk6jZjYk5p/iUSJgqy8BQd2R8AlOa7g=;
 b=p3/VgpG72qTKyLx6bIze80hrsD3Cn4ErnSCvUH/UjRbICZRo5+FqM6Afmbdqyw0RN18W9boXED1dYVDD2r8KrDXdXPsm8jSWz4U6wRJ4lSUL57srABFXgTHM+2hBDBWAg3nTduLWM0+Vm1hJo6BSYtLGJm9PbcAd9owp0Wi4K/c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 15:32:10 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::d850:b724:32ac:7bac]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::d850:b724:32ac:7bac%7]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 15:32:10 +0000
Subject: Re: [PATCH v2] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
To: Chengming Gui <Jack.Gui@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20201013151348.4382-1-Jack.Gui@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <63ca8d8a-3c0d-7512-e5d8-acb21368345a@amd.com>
Date: Tue, 13 Oct 2020 11:32:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201013151348.4382-1-Jack.Gui@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20 via Frontend Transport; Tue, 13 Oct 2020 15:32:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 818c277c-e938-4642-2288-08d86f8d26a6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4848ADBFC74BF1ECF0762A9992040@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvF7G8091twCr8oBdy+hmGKXZ0Tn45wuyvcD8lbY0h4hRom9vGVTx8L6xMrOA3a91LMP6CsWtAXgunfh4MvkB0V5fYu7+J3t9UvG7db2FuF0RKzFUBbURxbAJzzazQ9j1bc7anvTTJ25qhFj7SPkv0sYdAPS1tdChdtRHxrtT2+1oBqR9BTSMkVGH+IaKz6WaNmBwbtu6I9evnh3SUggakypwn0op/0HeYbuz70tgzcvlDF/DA8r19V7XkeckabS5SSdV1xzy8Qc/g+Zj017Cjgg7R4nw7iNU4hXGrsyMwCJXBbAigev85XC9YqiCbuSMgwCFUWPttdpldc1Omq+MfmnTbiDhwvl1WUWADbYly8+TzfUfzOb/dUvdfUQgJQ4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(83380400001)(8676002)(52116002)(6486002)(8936002)(16526019)(186003)(86362001)(4001150100001)(44832011)(956004)(36756003)(26005)(2616005)(6636002)(66476007)(478600001)(4326008)(31696002)(66556008)(316002)(31686004)(16576012)(66946007)(2906002)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XsfzipYP6tM3b5UIaqAAotPnjPV3EpKoDIf4fVjxKmQP/aCd6QCCkP0n66hYo19qXEJWwEcpAweV5c2pO3ABqfIY8rtk5qN3tYwYxTZiPTI2Hb8gmC905zeEYulEV/v9xiWfQ0MU8uTOlVhrDg06sQH2XnKxqy9i417BXOGPrv2BHYXq5JSkVPHFwCqxktKf7M5a4+syPdLRQY6ShV6ZSfVLZDq9EtXYd6oXChzdEZGivl/RtfkzTeVdYUwtI+FT0ajXz8zjOI930wsn65DEH0TOb6zRTZc5iiwK0B8afFRj+brHpsPVZsux/TBAchS4QxSJkpiTi8jPDqY19R/KWki8r+fvJjLxFqL023+xcsV9xY2Za2N0fEuT7k+W8QQrpZW29qAKFj80utEwLyp0tTRFRVhuIPVbPS1Ks9UIN4v58q3OrUqDXWvFyGwGpz0SSNSLQUor1FmxbW5TFC4VNpiY/RLOxu3qujV659fxmKY1Fk1cLbt+YpniATbkYoOdhAaPvxC8JQKWCZud3pYRJUyvomyJlvSQwxdqSyYnW1JlofcJuuHKoQ0zh3PXVqIMqmk3cIDqn5EM0XRtmt7L3gN8wBwtKB0BoAFelTRx6V/XoFfaJToueyep6YiiibHhrWXtN/7/x2gM20uExEz2Kg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818c277c-e938-4642-2288-08d86f8d26a6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 15:32:10.4604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDb25PNlD7VRsJABlrpjY7G8GP1eOMXs9AHewG7IONkGqnGiPgv0sZ34MIZfSTGo9nbqp6/cOe6601L+Yg473w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
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
Cc: Tao.Zhou1@amd.com, Ray.Huang@amd.com, Guchun.Chen@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RG8geW91IGhhdmUgbW9yZSBkZXRhaWxzIGFib3V0IHRob3NlIHRlc3QgZmFpbHVyZXMuIEluIHRo
ZW9yeSB0aGF0IHRlc3QKc2hvdWxkIHBhc3Mgd2l0aCBub3JldHJ5PTAuIElmIGl0IGZhaWxzLCBJ
J2QgcmF0aGVyIGxvb2sgaW50byB0aGUKcHJvYmxlbSB0aGFuIGhpZGluZyBpdCB3aXRoIGEgd29y
a2Fyb3VuZC4KClJlZ2FyZHMsCsKgIEZlbGl4CgpBbSAyMDIwLTEwLTEzIHVtIDExOjEzIGEubS4g
c2NocmllYiBDaGVuZ21pbmcgR3VpOgo+IG5vcmV0cnkgPSAwIGNhdXNlIHNvbWUgZEdQVSdzIGtm
ZCBwYWdlIGZhdWx0IHRlc3RzIGZhaWwsCj4gc28gc2V0IG5vcmV0cnkgdG8gMSBmb3IgdGhlc2Ug
c3BlY2lhbCBBU0lDczoKPiB2ZWdhMjAvbmF2aTEwL25hdmkxNC9BUkNUVVJVUwo+Cj4gdjI6bWVy
Z2UgcmF2ZW4gYW5kIGRlZmF1bHQgY2FzZSBkdWUgdG8gdGhlIHNhbWUgc2V0dGluZwo+Cj4gU2ln
bmVkLW9mZi1ieTogQ2hlbmdtaW5nIEd1aSA8SmFjay5HdWlAYW1kLmNvbT4KPiBDaGFuZ2UtSWQ6
IEkzYmU3MGY0NjNhNDliMGNkNWM1NjQ1NjQzMWQ2YzJjYjk4YjEzODcyCj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyB8IDI0ICsrKysrKysrKysrKysrKyst
LS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiBpbmRleCAzNjYw
NGQ3NTFkNjIuLjNiN2I5YTVlOTc0OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ21jLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ21jLmMKPiBAQCAtNDI1LDIwICs0MjUsMjggQEAgdm9pZCBhbWRncHVfZ21jX25vcmV0
cnlfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAJc3RydWN0IGFtZGdwdV9nbWMg
KmdtYyA9ICZhZGV2LT5nbWM7Cj4gIAo+ICAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiAt
CWNhc2UgQ0hJUF9SQVZFTjoKPiAtCQkvKiBSYXZlbiBjdXJyZW50bHkgaGFzIGlzc3VlcyB3aXRo
IG5vcmV0cnkKPiAtCQkgKiByZWdhcmRsZXNzIG9mIHdoYXQgd2UgZGVjaWRlIGZvciBvdGhlcgo+
IC0JCSAqIGFzaWNzLCB3ZSBzaG91bGQgbGVhdmUgcmF2ZW4gd2l0aAo+IC0JCSAqIG5vcmV0cnkg
PSAwIHVudGlsIHdlIHJvb3QgY2F1c2UgdGhlCj4gLQkJICogaXNzdWVzLgo+ICsJY2FzZSBDSElQ
X1ZFR0EyMDoKPiArCWNhc2UgQ0hJUF9OQVZJMTA6Cj4gKwljYXNlIENISVBfTkFWSTE0Ogo+ICsJ
Y2FzZSBDSElQX0FSQ1RVUlVTOgo+ICsJCS8qCj4gKwkJICogbm9yZXRyeSA9IDAgd2lsbCBjYXVz
ZSBrZmQgcGFnZSBmYXVsdCB0ZXN0cyBmYWlsCj4gKwkJICogZm9yIHNvbWUgQVNJQ3MsIHNvIHNl
dCBkZWZhdWx0IHRvIDEgZm9yIHRoZXNlIEFTSUNzLgo+ICAJCSAqLwo+ICAJCWlmIChhbWRncHVf
bm9yZXRyeSA9PSAtMSkKPiAtCQkJZ21jLT5ub3JldHJ5ID0gMDsKPiArCQkJZ21jLT5ub3JldHJ5
ID0gMTsKPiAgCQllbHNlCj4gIAkJCWdtYy0+bm9yZXRyeSA9IGFtZGdwdV9ub3JldHJ5Owo+ICAJ
CWJyZWFrOwo+ICsJY2FzZSBDSElQX1JBVkVOOgo+ICAJZGVmYXVsdDoKPiAtCQkvKiBkZWZhdWx0
IHRoaXMgdG8gMCBmb3Igbm93LCBidXQgd2UgbWF5IHdhbnQKPiArCQkvKiBSYXZlbiBjdXJyZW50
bHkgaGFzIGlzc3VlcyB3aXRoIG5vcmV0cnkKPiArCQkgKiByZWdhcmRsZXNzIG9mIHdoYXQgd2Ug
ZGVjaWRlIGZvciBvdGhlcgo+ICsJCSAqIGFzaWNzLCB3ZSBzaG91bGQgbGVhdmUgcmF2ZW4gd2l0
aAo+ICsJCSAqIG5vcmV0cnkgPSAwIHVudGlsIHdlIHJvb3QgY2F1c2UgdGhlCj4gKwkJICogaXNz
dWVzLgo+ICsJCSAqCj4gKwkJICogZGVmYXVsdCB0aGlzIHRvIDAgZm9yIG5vdywgYnV0IHdlIG1h
eSB3YW50Cj4gIAkJICogdG8gY2hhbmdlIHRoaXMgaW4gdGhlIGZ1dHVyZSBmb3IgY2VydGFpbgo+
ICAJCSAqIEdQVXMgYXMgaXQgY2FuIGluY3JlYXNlIHBlcmZvcm1hbmNlIGluCj4gIAkJICogY2Vy
dGFpbiBjYXNlcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
