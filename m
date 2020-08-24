Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E11C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3472067C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mp2or8nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3472067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9696E3DF;
	Mon, 24 Aug 2020 16:55:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26776E3DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctvmKs/Ie2jGRwB3nfq2yGklFQG4xrnsqom3Njnk8C7ZOsSq+Y6c7vDxGSBqwk69GlDP1RvdOA9AuxkeQvEI3PO7cGRCVldbFvmmCt5+Gq4jpDg1crimOwm4Y0IrcfXuKf/0KCkgju71Gev/TAQT/0Ss8FoNPNlFviUvKgo9nkJTibnuc4UeNNN8I+gDJYxvmDy+Bsp6Ho9tRag/U/0D5mJhEzfIRbILzAgx9sm3a418Wf0l1fiHgriU5aLWKay2EcS3i//5aC8lH2YEV31IGfwx4WnNpPQ8PLEEOndmI4jBImDq3zRsBC+P6Ei0qe4B0uf6OQUZbl89tOoKm6wRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8bgBY+0sKy0H60SZ4risGxumSjvAfLuc1VMgEEkBVw=;
 b=P8ddp3WBlD9T8g2IaKv0PugZHNnuqtKfDaB4Hi7/4VvvonwgtUWF5v2EidYlQwvKQGtzDuem5vVuEsJLpgQJslr4oBCXGAH2RzgbafUk4JOSGNfdX/Qx6w3RSOEQtK1cjsdX4ILatB+mBO3PyVRdQNMJ0cfyR13a2jL0cB2qLhQLjCvc7m5vZhCJQk+tTJPE6sLP/z0B8OYE4DYT2O7lVj+vN/ig8eV75m0+3aBGRcmZdHTLy+sNhJMFs1l2ZZ/IQed2FcMaeUrH9nT3Sgl2OStyBU+9dUYPwQvO5y4+1fgk8aTCS6y/UWEHyuejpOCXfwMO4QnBM5iiMJxy4ewSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8bgBY+0sKy0H60SZ4risGxumSjvAfLuc1VMgEEkBVw=;
 b=Mp2or8nmC7havrhAzplF7bX5D2658dzO+jrOYyr68OxVe/Nv9O8mgwQM/MFf/MCcf96sBHRxBLNmBVCPl1cfhjuRCYmZDrPNFVXYwnB9bCmgydbUVtV1zBGAPRKmhlZO8OCfRO57DcvSpF2HMmOqvgdLRxOHbJD7DtDfmi68lYw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 16:55:56 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:55:56 +0000
Subject: Re: [PATCH V3 1/1] drm/amdkfd: fix set kfd node ras properties value
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200824103337.2334-1-Stanley.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <434b579f-b47e-6ed7-43db-00f5b75ef8e4@amd.com>
Date: Mon, 24 Aug 2020 12:55:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200824103337.2334-1-Stanley.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 16:55:55 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed149624-6d2b-463b-a012-08d8484e91c8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438257723D36678B99F0986892560@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQH6JUagyhyhI62I7pYCmDM0vpLcz3L8BrLCu29M/hPPqlpUz2YCAPkHqfy3KaksWZbQzGsgHzmyBy80ovQNQF3/tat5iDXYBIdQrZR4ie0CUbREIUUroeFH8FaZku1Xe4kGXbyVVv2utcNRvtVzHLnb9p24F5XUM0yTHp0ZeoPl39dwH5K5kN2APsM8bhNI4/u/l9eCo64CF1rOhUh0RnL8whd7AX9P2m7p20+I4IMPraCbjw453M5G8RXFP2vW+CFxQtj9dn7/lspI00TvWUa9hGVPnjuw1aPRqs+DqvZYBDltvd6rUxXWJ7nbKaQ5DaX3MuT5BXIOZw3xmDer6ShqCR0rNSTsmheOUgLWdy/iLfnGxIT03dGGi/tdKvqQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(8936002)(186003)(6486002)(44832011)(52116002)(4326008)(2906002)(16576012)(316002)(86362001)(66946007)(2616005)(36756003)(66476007)(66556008)(478600001)(8676002)(31686004)(956004)(26005)(31696002)(5660300002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HqUm37fD3IGhp1LPkEiINgoP9l12xA+IrJi3sLHPYhvlphL1nHdMSW6l/B0M8741ffKWyhbYs1MqACzgcaTL5hlWq545PKxgHTahSTcJ3hhPoDD9gZQF+9+j4vlU4yHlxqghM6Kc4woWyYZChRf5jLzyXUjpyrPKY10T52UuVAUA1Xrv05qzRvwbuF8rePqvnNWjfCj+a4nLla/uaDIYjDkOJudQw7gk1uz/2MoP6hbuLfh6Q3uCZDRSSDuEcl3jrkGqFGCE3M1KJqlQO6tdiRCqMfq7Uqiezp4LFohY13TR4rwWDZe+Plb8ATC2LL3e+28+N12aU2YXCcSxPmkUGwYBfH4YWr9CpHla2a7xyyebWt/ochC2mrev6T/tg/BFUhpd1WsIIn979rP8F1He2Vu+S6dl+/nEhj3ZAbTSh2khSHtrygY32H+9A01PeAV9JOw9WoMmuXgwhfxWz5+jSZNfnVUj8dgoSIEr+I75wQn81W74fb2axKv/LZVdRXTWRDhrBNdhdefWKjIzdGwdafeOGK2kNkPXGmHTLEwMIVZgCQYgbWXKfWM6ott4QiI4yMd/N3N7F2ALhI9Taz/oRYiAZ6LEcsog9rjiGjMAT2QGO3eZnumutj20uwD08/qKNBguokPNmdwZsSkYTxsqUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed149624-6d2b-463b-a012-08d8484e91c8
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:55:56.5047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYYn7DNryy6H5N3a08UWvAoBSN7kXhrQaEygynI5UrgnZrNlKKYv2Xt+cwuQYtyVn2mLE66/Jbum6jaG6GQvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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
Cc: Tony.Tye@amd.com, Dennis.Li@amd.com, Guchun.Chen@amd.com,
 Hawking.Zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIEtGRCBwYXJ0IGxvb2tzIGdvb2QgdG8gbWUsIG90aGVyIHRoYW4gdGhlIFNETUEgY29tbWVu
dCB0aGF0IEd1Y2h1bgpwb2ludGVkIG91dC4gV2l0aCB0aGF0IGZpeGVkIHRoaXMgcGF0Y2ggaXMK
CkFja2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KClRoYW5r
cywKwqAgRmVsaXgKCgpBbSAyMDIwLTA4LTI0IHVtIDY6MzMgYS5tLiBzY2hyaWViIFN0YW5sZXku
WWFuZzoKPiBUaGUgY3R4LT5mZWF0dXJlcyBhcmUgbmV3IFJBUyBpbXBsZW1lbnRhdGlvbiB3aGlj
aAo+IGlzIG9ubHkgYXZhaWxhYmxlIGZvciBWZWdhMjAgYW5kIG9ud2FyZHMsIGl0IGlzIG5vdAo+
IGF2YWlsYWJsZSBmb3IgdmVnYTEwLCB2ZWdhMTAgc2hvdWxkIGZvbGxvdyBsZWdhY3kKPiBFQ0Mg
aW1wbGVtZW50YXRpb24uCj4KPiBDaGFuZ2VkIGZyb20gVjE6Cj4gICAgIHdyYXAgZnVuY3Rpb24g
dG8gaW5pdGlhbGl6ZSBrZmQgbm9kZSBwcm9wZXJ0aWVzCj4KPiBDaGFuZ2VkIGZyb20gVjI6Cj4g
ICAgIHJlbW92ZSB3cmFwIGZ1bmNpb24sIHJlbW92ZSBTUk1BIEVDQyBjaGVjawo+Cj4gQ2hhbmdl
LUlkOiBJMWUzZmY4OTliZjA2NjYxMWZlNTc3NWU2NzEwNGNlMmUwYmY4YjdkMAo+IFNpZ25lZC1v
ZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5ZYW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oICAgICAgIHwgIDEgKwo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgICB8IDE2ICsrKysrKysrLS0tLS0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDI0ICsrKysrKysrKysr
LS0tLS0tLS0tLS0tCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjAgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+IGluZGV4IDFmOWQ5
N2Y2MWFhNS4uNTczZTI3MTJkZjM1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
LmgKPiBAQCAtOTg2LDYgKzk4Niw3IEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsKPiAgCj4gIAlh
dG9taWNfdAkJCXRocm90dGxpbmdfbG9nZ2luZ19lbmFibGVkOwo+ICAJc3RydWN0IHJhdGVsaW1p
dF9zdGF0ZQkJdGhyb3R0bGluZ19sb2dnaW5nX3JzOwo+ICsJdWludDMyX3QJCQlyYXNfZmVhdHVy
ZXM7Cj4gIH07Cj4gIAo+ICBzdGF0aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfZGV2aWNlICphbWRn
cHVfdHRtX2FkZXYoc3RydWN0IHR0bV9ib19kZXZpY2UgKmJkZXYpCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IGluZGV4IGNkMTQwM2Y4M2RjZi4uZDQ2MjI0NDg2M2Y2
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IEBAIC0xOTc0
LDcgKzE5NzQsOCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2NoZWNrX3N1cHBvcnRlZChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCSpzdXBwb3J0ZWQgPSAwOwo+ICAKPiAgCWlmIChh
bWRncHVfc3Jpb3ZfdmYoYWRldikgfHwgIWFkZXYtPmlzX2F0b21fZncgfHwKPiAtCSAgICAoYWRl
di0+YXNpY190eXBlICE9IENISVBfVkVHQTIwICAgJiYKPiArCSAgICAoYWRldi0+YXNpY190eXBl
ICE9IENISVBfVkVHQTEwICYmCj4gKwkgICAgIGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX1ZFR0Ey
MCAmJgo+ICAJICAgICBhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9BUkNUVVJVUyAmJgo+ICAJICAg
ICBhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9TSUVOTkFfQ0lDSExJRCkpCj4gIAkJcmV0dXJuOwo+
IEBAIC0xOTk4LDYgKzE5OTksNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2NoZWNrX3N1cHBv
cnRlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCj4gIAkqc3VwcG9ydGVkID0gYW1k
Z3B1X3Jhc19lbmFibGUgPT0gMCA/Cj4gIAkJCTAgOiAqaHdfc3VwcG9ydGVkICYgYW1kZ3B1X3Jh
c19tYXNrOwo+ICsJYWRldi0+cmFzX2ZlYXR1cmVzID0gKnN1cHBvcnRlZDsKPiAgfQo+ICAKPiAg
aW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiBAQCAtMjAy
MCw5ICsyMDIyLDkgQEAgaW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgCj4gIAlhbWRncHVfcmFzX2NoZWNrX3N1cHBvcnRlZChhZGV2LCAmY29uLT5od19z
dXBwb3J0ZWQsCj4gIAkJCSZjb24tPnN1cHBvcnRlZCk7Cj4gLQlpZiAoIWNvbi0+aHdfc3VwcG9y
dGVkKSB7Cj4gKwlpZiAoIWNvbi0+aHdfc3VwcG9ydGVkIHx8IChhZGV2LT5hc2ljX3R5cGUgPT0g
Q0hJUF9WRUdBMTApKSB7Cj4gIAkJciA9IDA7Cj4gLQkJZ290byBlcnJfb3V0Owo+ICsJCWdvdG8g
cmVsZWFzZV9jb247Cj4gIAl9Cj4gIAo+ICAJY29uLT5mZWF0dXJlcyA9IDA7Cj4gQEAgLTIwMzMs
MjUgKzIwMzUsMjUgQEAgaW50IGFtZGdwdV9yYXNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5pbml0X3Jhc19jb250cm9sbGVyX2ludGVy
cnVwdCkgewo+ICAJCXIgPSBhZGV2LT5uYmlvLmZ1bmNzLT5pbml0X3Jhc19jb250cm9sbGVyX2lu
dGVycnVwdChhZGV2KTsKPiAgCQlpZiAocikKPiAtCQkJZ290byBlcnJfb3V0Owo+ICsJCQlnb3Rv
IHJlbGVhc2VfY29uOwo+ICAJfQo+ICAKPiAgCWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5pbml0X3Jh
c19lcnJfZXZlbnRfYXRodWJfaW50ZXJydXB0KSB7Cj4gIAkJciA9IGFkZXYtPm5iaW8uZnVuY3Mt
PmluaXRfcmFzX2Vycl9ldmVudF9hdGh1Yl9pbnRlcnJ1cHQoYWRldik7Cj4gIAkJaWYgKHIpCj4g
LQkJCWdvdG8gZXJyX291dDsKPiArCQkJZ290byByZWxlYXNlX2NvbjsKPiAgCX0KPiAgCj4gIAlp
ZiAoYW1kZ3B1X3Jhc19mc19pbml0KGFkZXYpKSB7Cj4gIAkJciA9IC1FSU5WQUw7Cj4gLQkJZ290
byBlcnJfb3V0Owo+ICsJCWdvdG8gcmVsZWFzZV9jb247Cj4gIAl9Cj4gIAo+ICAJZGV2X2luZm8o
YWRldi0+ZGV2LCAiUkFTIElORk86IHJhcyBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHksICIKPiAg
CQkJImhhcmR3YXJlIGFiaWxpdHlbJXhdIHJhc19tYXNrWyV4XVxuIiwKPiAgCQkJY29uLT5od19z
dXBwb3J0ZWQsIGNvbi0+c3VwcG9ydGVkKTsKPiAgCXJldHVybiAwOwo+IC1lcnJfb3V0Ogo+ICty
ZWxlYXNlX2NvbjoKPiAgCWFtZGdwdV9yYXNfc2V0X2NvbnRleHQoYWRldiwgTlVMTCk7Cj4gIAlr
ZnJlZShjb24pOwo+ICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
Ywo+IGluZGV4IGYxODVmNmNiYzA1Yy4uMGJhOTYwYTE3ZWFkIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPiBAQCAtMTIzOSw3ICsxMjM5LDcgQEAgaW50
IGtmZF90b3BvbG9neV9hZGRfZGV2aWNlKHN0cnVjdCBrZmRfZGV2ICpncHUpCj4gIAl2b2lkICpj
cmF0X2ltYWdlID0gTlVMTDsKPiAgCXNpemVfdCBpbWFnZV9zaXplID0gMDsKPiAgCWludCBwcm94
aW1pdHlfZG9tYWluOwo+IC0Jc3RydWN0IGFtZGdwdV9yYXMgKmN0eDsKPiArCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2Owo+ICAKPiAgCUlOSVRfTElTVF9IRUFEKCZ0ZW1wX3RvcG9sb2d5X2Rl
dmljZV9saXN0KTsKPiAgCj4gQEAgLTE0MDQsMTkgKzE0MDQsMTcgQEAgaW50IGtmZF90b3BvbG9n
eV9hZGRfZGV2aWNlKHN0cnVjdCBrZmRfZGV2ICpncHUpCj4gIAkJZGV2LT5ub2RlX3Byb3BzLm1h
eF93YXZlc19wZXJfc2ltZCA9IDEwOwo+ICAJfQo+ICAKPiAtCWN0eCA9IGFtZGdwdV9yYXNfZ2V0
X2NvbnRleHQoKHN0cnVjdCBhbWRncHVfZGV2aWNlICopKGRldi0+Z3B1LT5rZ2QpKTsKPiAtCWlm
IChjdHgpIHsKPiAtCQkvKiBrZmQgb25seSBjb25jZXJucyBzcmFtIGVjYyBvbiBHRlgvU0RNQSBh
bmQgSEJNIGVjYyBvbiBVTUMgKi8KPiAtCQlkZXYtPm5vZGVfcHJvcHMuY2FwYWJpbGl0eSB8PQo+
IC0JCQkoKChjdHgtPmZlYXR1cmVzICYgQklUKEFNREdQVV9SQVNfQkxPQ0tfX1NETUEpKSAhPSAw
KSB8fAo+IC0JCQkgKChjdHgtPmZlYXR1cmVzICYgQklUKEFNREdQVV9SQVNfQkxPQ0tfX0dGWCkp
ICE9IDApKSA/Cj4gLQkJCUhTQV9DQVBfU1JBTV9FRENTVVBQT1JURUQgOiAwOwo+IC0JCWRldi0+
bm9kZV9wcm9wcy5jYXBhYmlsaXR5IHw9ICgoY3R4LT5mZWF0dXJlcyAmIEJJVChBTURHUFVfUkFT
X0JMT0NLX19VTUMpKSAhPSAwKSA/Cj4gLQkJCUhTQV9DQVBfTUVNX0VEQ1NVUFBPUlRFRCA6IDA7
Cj4gLQo+IC0JCWRldi0+bm9kZV9wcm9wcy5jYXBhYmlsaXR5IHw9IChjdHgtPmZlYXR1cmVzICE9
IDApID8KPiArCWFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKikoZGV2LT5ncHUtPmtnZCk7
Cj4gKwkvKiBrZmQgb25seSBjb25jZXJucyBzcmFtIGVjYyBvbiBHRlgvU0RNQSBhbmQgSEJNIGVj
YyBvbiBVTUMgKi8KPiArCWRldi0+bm9kZV9wcm9wcy5jYXBhYmlsaXR5IHw9Cj4gKwkJKChhZGV2
LT5yYXNfZmVhdHVyZXMgJiBCSVQoQU1ER1BVX1JBU19CTE9DS19fR0ZYKSkgIT0gMCkgPwo+ICsJ
CUhTQV9DQVBfU1JBTV9FRENTVVBQT1JURUQgOiAwOwo+ICsJZGV2LT5ub2RlX3Byb3BzLmNhcGFi
aWxpdHkgfD0gKChhZGV2LT5yYXNfZmVhdHVyZXMgJiBCSVQoQU1ER1BVX1JBU19CTE9DS19fVU1D
KSkgIT0gMCkgPwo+ICsJCUhTQV9DQVBfTUVNX0VEQ1NVUFBPUlRFRCA6IDA7Cj4gKwo+ICsJaWYg
KGFkZXYtPmFzaWNfdHlwZSAhPSBDSElQX1ZFR0ExMCkKPiArCQlkZXYtPm5vZGVfcHJvcHMuY2Fw
YWJpbGl0eSB8PSAoYWRldi0+cmFzX2ZlYXR1cmVzICE9IDApID8KPiAgCQkJSFNBX0NBUF9SQVNF
VkVOVE5PVElGWSA6IDA7Cj4gLQl9Cj4gIAo+ICAJa2ZkX2RlYnVnX3ByaW50X3RvcG9sb2d5KCk7
Cj4gIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
