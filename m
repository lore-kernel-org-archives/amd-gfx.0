Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B15FC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 21:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEAE421775
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 21:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="koo9zcqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAE421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5C66FDC2;
	Fri,  7 Feb 2020 21:50:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 397D46FDC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 21:50:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwaJBGgYCg17n6TM17flNR3Dc9FfntZSroqH37AbGMC3vTqQ4VAXc1ljEW0ZwsiJvRzlCm/SKpTp2ePi67J4kGqLqEva/+z3HPI1oTVVd+WcRmu/6DJOVpOlqnhzP2WFFRBl/+dYNWwA+Jr+vcgIG76ZYStpVsg5NCoMXUJPJrq62fPxWHLyUXqEag5TPG1QKcoH8NHIOgpnwaiS+UtX/eJlrnxSkV1CRRnGUI9PeJEdqwitWMtyVKldkTIOZcvnfGyQ9qRCjPQNdiPzy6M6qYj+QXeisiAwgHCTx8LiE+jlgGs+W5bdX7Mm+wgg1lQl92+EvvaUyQd8GnvymYHPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3lqwqndzjex8hm6ybiJcgUN9joazJ1XPmNuGQIug7g=;
 b=nQR4rYzSSMv8W1rVdRNq/mKQRbJhRMZKLD2MNQrqqv5TZ3ceZRBhQq4kjDbL+LFzN+PiD8mt+dSmgiXqnB4Ncu1+YdCAFVV+NAjkOVScGXaCIznnJHWOgnI3gjxeSVBMjld3WiWeOP8lCu/8QOR8UH//B9GCNa46I8GAet1WnWP7QAYt8QrqVeam1AA5zkeNOxgpLUqZb8f+q4PjJl7A7bMm6lZT0aLQHirXm5S7xsjDFNou/8VMTce/cBZcEmsfGV8kN0NqzWfj+zoXCQJyokhf/OzxR5ZFZSG7w5g7BzDnw13ooh5Ao64NPzRomf+++VvfFqkDi7qlZ7dvEBZkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3lqwqndzjex8hm6ybiJcgUN9joazJ1XPmNuGQIug7g=;
 b=koo9zcqMytjlQKOfjutFw5yNR2vpJP78Qe2CfDo5+1S2hGjRJ6cvUwULhrh6Wjvlypv2W0bdB0I9zIVAoxry5QbNVcIXEVoVknrSdq/R6z06cR3Ze6+Dgy8xFGf4lwM0dN0Q81LfS+NVuWCKbsDU8Fpc+uQYE0bb3UNp2a1r3as=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0251.namprd12.prod.outlook.com (10.174.106.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 21:49:59 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2686.036; Fri, 7 Feb 2020
 21:49:58 +0000
Subject: Re: [Patch v3 3/4] drm/amdkfd: refactor runtime pm for baco
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
 <20200207000911.19166-4-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <e73350f5-c604-8f2d-97fb-5c3226dfcf74@amd.com>
Date: Fri, 7 Feb 2020 16:49:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200207000911.19166-4-rajneesh.bhardwaj@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 21:49:58 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8819b39b-94e9-4ec8-65f7-08d7ac17ad2c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0251:|DM5PR1201MB0251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02519FFD475C14ABB471BB7F921C0@DM5PR1201MB0251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(44832011)(66946007)(16576012)(8936002)(81156014)(8676002)(81166006)(26005)(66476007)(66556008)(53546011)(316002)(478600001)(16526019)(186003)(86362001)(5660300002)(52116002)(36916002)(36756003)(2906002)(6486002)(31686004)(31696002)(2616005)(956004)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0251;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDTNA8QUaRK5XAfJjlp/b/gQa9R2tTWJns0UJeNEI4995LQuRFpVtKRO8O+SNtBEzyXnUJ3haviog6TgN4FtOEDruXiCkrzey8xKLzrlHHM/1JVtKWvPLtS3CHLjnnAIi3koeKgxwio1s51Zxs4h2WltjhLM5CoXAMgqdLqIYiZhsn6GAYEuAfywc1XA95nEINHkhTsoaS8PpSEd8AJP4FA2WXMAA5/PwrEi+5LsmmGoUhx79CpDdg3sWaj6tCzs3bEBg5moAXFfxPTLu9Z+UlzCxJqjZxF3iZOgAq3DIyFPseSIrm7S0qi+583n14LNMj+aRXGXsNAy7A0UDhq07/pcqkNsPC8jBd0Pf6irHgxcrdWzmOA3WNK2Toj+5MQuAnVEEk7RG3esIlVMCfmR3iXNJ5+GivmajKPORkw8tyC9MGVvzVNTl25CsAvI5F57
X-MS-Exchange-AntiSpam-MessageData: Z5150rVwZlhKIYQbM4SSkZp+lLS1HHRSFyboFTuNdLj89JsEeJ/xuJsQz2fR+87SDnbScmP9sq6A4UesbzM3wPHXQ72NxcH8Ij2q3ao6NFR+u3MaX7QMnv4kN9zq1KetevsdTCeYfUZTTM/TB+nBiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8819b39b-94e9-4ec8-65f7-08d7ac17ad2c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 21:49:58.8846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfA14eRWkjQkuT3tbk8h1aUmIClQwISHo0Pah0r7gCA2GUjCoKofYMc3j2rMKCWTJr0ICWax0zmDSCgoZQa0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0251
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T25lIG1vcmUgbml0LXBpY2sgYW5kIG9uZSBlcnJvci1oYW5kbGluZyBwcm9ibGVtIGlubGluZS4K
Ck9uIDIwMjAtMDItMDYgNzowOSBwLm0uLCBSYWpuZWVzaCBCaGFyZHdhaiB3cm90ZToKPiBTbyBm
YXIgdGhlIGtmZCBkcml2ZXIgaW1wbGVtZW50ZWQgc2FtZSByb3V0aW5lcyBmb3IgcnVudGltZSBh
bmQgc3lzdGVtCj4gd2lkZSBzdXNwZW5kIGFuZCByZXN1bWUgKHMyaWRsZSBvciBtZW0pLiBEdXJp
bmcgc3lzdGVtIHdpZGUgc3VzcGVuZCB0aGUKPiBrZmQgYXF1aXJlcyBhbiBhdG9taWMgbG9jayB0
aGF0IHByZXZlbnRzIGFueSBtb3JlIHVzZXIgcHJvY2Vzc2VzIHRvCj4gY3JlYXRlIHF1ZXVlcyBh
bmQgaW50ZXJhY3Qgd2l0aCBrZmQgZHJpdmVyIGFuZCBhbWQgZ3B1LiBUaGlzIG1lY2hhbmlzbQo+
IGNyZWF0ZWQgcHJvYmxlbSB3aGVuIGFtZGdwdSBkZXZpY2UgaXMgcnVudGltZSBzdXNwZW5kZWQg
d2l0aCBCQUNPCj4gZW5hYmxlZC4gQW55IGFwcGxpY2F0aW9uIHRoYXQgcmVsaWVzIG9uIGtmZCBk
cml2ZXIgZmFpbHMgdG8gbG9hZCBiZWNhdXNlCj4gdGhlIGRyaXZlciByZXBvcnRzIGEgbG9ja2Vk
IGtmZCBkZXZpY2Ugc2luY2UgZ3B1IGlzIHJ1bnRpbWUgc3VzcGVuZGVkLgo+Cj4gSG93ZXZlciwg
aW4gYW4gaWRlYWwgY2FzZSwgd2hlbiBncHUgaXMgcnVudGltZSAgc3VzcGVuZGVkIHRoZSBrZmQg
ZHJpdmVyCj4gc2hvdWxkIGJlIGFibGUgdG86Cj4KPiAgIC0gYXV0byByZXN1bWUgYW1kZ3B1IGRy
aXZlciB3aGVuZXZlciBhIGNsaWVudCByZXF1ZXN0cyBjb21wdXRlIHNlcnZpY2UKPiAgIC0gcHJl
dmVudCBydW50aW1lIHN1c3BlbmQgZm9yIGFtZGdwdSAgd2hpbGUga2ZkIGlzIGluIHVzZQo+Cj4g
VGhpcyBjaGFuZ2UgcmVmYWN0b3JzIHRoZSBhbWRncHUgYW5kIGFtZGtmZCBkcml2ZXJzIHRvIHN1
cHBvcnQgQkFDTyBhbmQKPiBydW50aW1lIHBvd2VyIG1hbmFnZW1lbnQuCj4KPiBSZXZpZXdlZC1i
eTogT2FrIFplbmcgPG9hay56ZW5nQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFJham5lZXNoIEJo
YXJkd2FqIDxyYWpuZWVzaC5iaGFyZHdhakBhbWQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgMTIgKysrLS0tLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oIHwgIDggKystLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8ICA0ICstLQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICAgIHwgMjkgKysrKysrKysrLS0tLS0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICAgIHwgIDEgKwo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyAgIHwgNDAgKysrKysrKysr
KysrKysrKysrKystLQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAyNiBk
ZWxldGlvbnMoLSkKPgpbc25pcF0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3Byb2Nlc3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9j
ZXNzLmMKPiBpbmRleCA5OGRjYmI5NmIyZTIuLjZkNmMyNWZlMjY3NyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+IEBAIC0zMSw2ICszMSw3IEBACj4gICAj
aW5jbHVkZSA8bGludXgvY29tcGF0Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvbW1hbi5oPgo+ICAg
I2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4K
PiAgICNpbmNsdWRlICJhbWRncHVfYW1ka2ZkLmgiCj4gICAjaW5jbHVkZSAiYW1kZ3B1LmgiCj4g
ICAKPiBAQCAtNTI3LDYgKzUyOCwxNiBAQCBzdGF0aWMgdm9pZCBrZmRfcHJvY2Vzc19kZXN0cm95
X3BkZHMoc3RydWN0IGtmZF9wcm9jZXNzICpwKQo+ICAgCQlrZnJlZShwZGQtPnFwZC5kb29yYmVs
bF9iaXRtYXApOwo+ICAgCQlpZHJfZGVzdHJveSgmcGRkLT5hbGxvY19pZHIpOwo+ICAgCj4gKwkJ
LyoKPiArCQkgKiBiZWZvcmUgZGVzdHJveWluZyBwZGQsIG1ha2Ugc3VyZSB0byByZXBvcnQgYXZh
aWxhYmlsaXR5Cj4gKwkJICogZm9yIGF1dG8gc3VzcGVuZAo+ICsJCSAqLwo+ICsJCWlmIChwZGQt
PnJ1bnRpbWVfaW51c2UpIHsKPiArCQkJcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShwZGQtPmRl
di0+ZGRldi0+ZGV2KTsKPiArCQkJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQocGRkLT5kZXYt
PmRkZXYtPmRldik7Cj4gKwkJCXBkZC0+cnVudGltZV9pbnVzZSA9IGZhbHNlOwo+ICsJCX0KPiAr
Cj4gICAJCWtmcmVlKHBkZCk7Cj4gICAJfQo+ICAgfQo+IEBAIC04NDQsNiArODU1LDcgQEAgc3Ry
dWN0IGtmZF9wcm9jZXNzX2RldmljZSAqa2ZkX2NyZWF0ZV9wcm9jZXNzX2RldmljZV9kYXRhKHN0
cnVjdCBrZmRfZGV2ICpkZXYsCj4gICAJcGRkLT5wcm9jZXNzID0gcDsKPiAgIAlwZGQtPmJvdW5k
ID0gUEREX1VOQk9VTkQ7Cj4gICAJcGRkLT5hbHJlYWR5X2RlcXVldWVkID0gZmFsc2U7Cj4gKwlw
ZGQtPnJ1bnRpbWVfaW51c2UgPSBmYWxzZTsKPiAgIAlsaXN0X2FkZCgmcGRkLT5wZXJfZGV2aWNl
X2xpc3QsICZwLT5wZXJfZGV2aWNlX2RhdGEpOwo+ICAgCj4gICAJLyogSW5pdCBpZHIgdXNlZCBm
b3IgbWVtb3J5IGhhbmRsZSB0cmFuc2xhdGlvbiAqLwo+IEBAIC05MzMsMTUgKzk0NSwzOSBAQCBz
dHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICprZmRfYmluZF9wcm9jZXNzX3RvX2RldmljZShzdHJ1
Y3Qga2ZkX2RldiAqZGV2LAo+ICAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiAgIAl9Cj4g
ICAKPiArCS8qCj4gKwkgKiBzaWduYWwgcnVudGltZS1wbSBzeXN0ZW0gdG8gYXV0byByZXN1bWUg
YW5kIHByZXZlbnQKPiArCSAqIGZ1cnRoZXIgcnVudGltZSBzdXNwZW5kIG9uY2UgZGV2aWNlIHBk
ZCBpcyBjcmVhdGVkIHVudGlsCj4gKwkgKiBwZGQgaXMgZGVzdHJveWVkLgo+ICsJICovCj4gKwlp
ZiAoIXBkZC0+cnVudGltZV9pbnVzZSkgewo+ICsJCWVyciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
ZGV2LT5kZGV2LT5kZXYpOwo+ICsJCWlmIChlcnIgPCAwKQo+ICsJCQlyZXR1cm4gRVJSX1BUUihl
cnIpOwo+ICsJfQo+ICsKPiAgIAllcnIgPSBrZmRfaW9tbXVfYmluZF9wcm9jZXNzX3RvX2Rldmlj
ZShwZGQpOwo+ICAgCWlmIChlcnIpCj4gLQkJcmV0dXJuIEVSUl9QVFIoZXJyKTsKPiArCQlnb3Rv
IG91dDsKPiAgIAo+ICAgCWVyciA9IGtmZF9wcm9jZXNzX2RldmljZV9pbml0X3ZtKHBkZCwgTlVM
TCk7Cj4gICAJaWYgKGVycikKPiAtCQlyZXR1cm4gRVJSX1BUUihlcnIpOwo+ICsJCWdvdG8gb3V0
Owo+ICsKPiArCWlmICghZXJyKQoKVGhpcyAiaWYiIGlzIGFsc28gcmVkdW5kYW50LiBJZiB0aGVy
ZSB3YXMgYW4gZXJyb3IsIHlvdSBhbHJlYWR5IGRpZCBnb3RvIApvdXQuIHBkZC0+cnVudGltZV9p
bnVzZSBzaG91bGQgYmUgc2V0IHdoZW5ldmVyIHdlIHJldHVybiBzdWNjZXNzZnVsbHkgCmZyb20g
dGhpcyBmdW5jdGlvbiwgc28gbG9naWNhbGx5IHRoZXJlIHNob3VsZCBiZSBubyBleHRyYSAiaWYi
LgoKCj4gKwkJLyoKPiArCQkgKiBtYWtlIHN1cmUgdGhhdCBydW50aW1lX3VzYWdlIGNvdW50ZXIg
aXMgaW5jcmVtZW50ZWQKPiArCQkgKiBqdXN0IG9uY2UgcGVyIHBkZAo+ICsJCSAqLwo+ICsJCXBk
ZC0+cnVudGltZV9pbnVzZSA9IHRydWU7Cj4gICAKPiAgIAlyZXR1cm4gcGRkOwo+ICsKPiArb3V0
Ogo+ICsJLyogYmFsYW5jZSBydW5wbSByZWZlcmVuY2UgY291bnQgYW5kIGV4aXQgd2l0aCBlcnJv
ciAqLwoKSSB0aGluayB5b3UgbmVlZCBhbiAiaWYgKCFwZGQtPnJ1bnRpbWVfaW51c2UpIiBoZXJl
LiBJZiB0aGlzIGZ1bmN0aW9uIApkaWRuJ3QgY2FsbCBwbV9ydW50aW1lX2dldF9zeW5jIGFib3Zl
LCB5b3Ugc2hvdWxkbid0IGRvIHRoZSBjbGVhbnVwIApiZWxvdy4gT3RoZXJ3aXNlIHlvdSByaXNr
IGdldHRpbmcgdW5iYWxhbmNlZCB1c2FnZSBjb3VudGVycy4gSW4gb3RoZXIgCndvcmRzLCB5b3Ug
bmVlZCB0byB1c2UgdGhlIHNhbWUgY29uZGl0aW9uIGZvciBwbV9ydW50aW1lX2dldF9zeW5jIGFu
ZCAKdGhlIGNsZWFudXAuCgpSZWdhcmRzLAogwqAgRmVsaXgKCgo+ICsJcG1fcnVudGltZV9tYXJr
X2xhc3RfYnVzeShkZXYtPmRkZXYtPmRldik7Cj4gKwlwbV9ydW50aW1lX3B1dF9hdXRvc3VzcGVu
ZChkZXYtPmRkZXYtPmRldik7Cj4gKwlyZXR1cm4gRVJSX1BUUihlcnIpOwo+ICAgfQo+ICAgCj4g
ICBzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICprZmRfZ2V0X2ZpcnN0X3Byb2Nlc3NfZGV2aWNl
X2RhdGEoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
