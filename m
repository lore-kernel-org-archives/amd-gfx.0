Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB56C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 23:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BFF20786
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 23:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qVHYPkxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BFF20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4666E10D;
	Mon, 27 Jul 2020 23:42:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDB16E13C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 23:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Reegh1C75fRhTCpGJgtIOVFwtpusvRyaKUwBfhqHMiiwIrtaCje1AT2UwJShK3rI0ksgd4KJT1429hMc2t25/Kuv5KrJysBcK6Iet69Y3afNBIRpOjeFQgl7zRAJ0XC02yYrnCaushHQedwber3PkgmcobzBxjqcCK6LraQe3kf9EuwYWcsHlYdj/z2PuhMRbbDlo/m3HUJprnjs1mto+Y5RFyhwR9klaO2q0SHoVxhA0iSALI9+QfHHJxNMcdCUKAD8bpM8zHzBMXubPSCBRWfXn9wEgzdNzjKtVso9O1iD2XqBIZIXsGLLWaBc41QkrlPqk7Cy2SV9/1c1sf6cbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF6Hj/RBLwQjSQQGd5YyDO+dkGMuKWrGWxrr+C7GiTM=;
 b=Pr4+r1IGzeqi3SRY+uC9CqaoiFzafFFRx5vHNF0kFSErwWpR7PRI+ReiPZ16W9D9janSUkKiyUtvp7Ap5j163v4shP3/ziUotZDNPnh9QEqX5+fIYL8gjvSwulyu1EkL59d98J9do9aqsB/MKFSsmLKsioHgaaBEGaar1y4C5AFTXVGx8LGJVE07j6JTsnZhbYv8AFROkUtDsP/BaLFcMcHxRZaygQBq6rQsgcy4Xh7x/+ap7mtkRjQW+ulbhuyz+MzXZ6Y8SMcq/KBj1Q38c1YZWxpORzLbhVhH/f//sJY2+BDzj590+ogMaKHzr4QX+OermWIX4EkpCFq9EjWUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF6Hj/RBLwQjSQQGd5YyDO+dkGMuKWrGWxrr+C7GiTM=;
 b=qVHYPkxQG1vhTm9aSqAtiwkxoISbcG4cLKYWRTVNCuBEHLIH+CUaMeNll/Vjo6WwbULjnUOtcEdBJd59jDBq+IetfR7+R51KuyjYWtmFGj5l3wjYhjB+xaBp2QI3JgOR22/ouGL3wwgxv1SBdjVEhma2upTDuvBUYkEuZ6YYacU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 23:42:21 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::5d1d:887c:3ba6:1d0d]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::5d1d:887c:3ba6:1d0d%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 23:42:21 +0000
Subject: Re: [PATCH] drm/amdkfd: Replace bitmask with event idx in SMI event
 msg
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200726212453.24106-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <aa3334cc-b0f7-3293-070a-5bb8481de577@amd.com>
Date: Mon, 27 Jul 2020 19:42:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200726212453.24106-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::10) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.61.76) by
 YT1PR01CA0101.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 23:42:21 +0000
X-Originating-IP: [142.117.61.76]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24dedc71-0470-4001-2930-08d83286b4c2
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2829A4375ECB2D2D37F33FEB92720@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdEyh8oNLuYIhkvUUZrLWF+cE/vyubXgn3QFr6NglXOZoPzRzUKprZex/FiyS5fmgyYhrWLQHY7pD8g55I4g7xUdxbZoGjjheXnD8pgaKZqMYgBzMI0ThTUmMYiDZXZzxSFFHTVW0oFPKGPaM6HLCEN1cdI6+4XB4pPPkxsQu1d4J8f/XQQ3SqPz4Pn89k1v5GEBzPY2WZhniCChKwV076bQF0YRA3lWFoPkQIXBJkTiiRt0RTJpn/rZklDG5glVSzs34rASoEiQlcVLMVvf26Fu24hhE8N573JODm/Z4Gtwj8JK0W8yVGv939LGfF4Gbut4HnxU8XqHUzhUowwhKXp9tWJNqqjK7+Xdvyubc5GyEuz5jbSmtwRW+NKd4Y5U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(6486002)(2906002)(8936002)(186003)(44832011)(16576012)(956004)(16526019)(2616005)(316002)(66946007)(66476007)(66556008)(31696002)(26005)(86362001)(36756003)(478600001)(31686004)(52116002)(8676002)(83380400001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YiyogFxPiixBb6aB+OK26o3DMqO1+bbatr8nkoABuV7OTy3suaFBcpp6rEHG1re0F4RfN5o05FCh4ZpLe/Q0LWU3sXnWiZaI/6Qfk9elpqzHYeoE4fAccWnhW/7IeU5LPmSPw8f+6/SSd0s8cgCkb5HGlKFQYYyCKMgdcpJAulnGNJTonmxCXc43etsYQsW0Z4J7g0E5T5Ti/Gx0PfOVvqO7Zf/JE6Vp8K6E92KclJ5UeZviAYoLBoi9Egez1X3phl5MCIVcQVb6+j3rQxD+jCkxkDfnm99G7tFz+e3Dvk3J10XtnVrXaEq6JRwdTjAMStsqR29gpb8ef+Wy0kgwt66XK8kzyjP0TVdqN9HqwNDcdN+Ns1suPDX6spvPaUI6ELquBA7nVoeQ6AGQlFWblHxo33q7ZWrJxb2ZyrX5jOYN6VUe6qdgNbiAcz/GAaRIfzIRicIXauhsG5+PGxTECKJo8WSTtwRGOTj5o0GLRGRnwY0WwEbs3VoClH/NS3t9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dedc71-0470-4001-2930-08d83286b4c2
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 23:42:21.3984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVcinPF6XHK8yTkVq7lw6UrIwWnmeGyomHhDJxoyIIMqS3Wem5SGzQDM9TnbdColOUSv4PX9LU6BehG9mi/sXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wNy0yNiB1bSA1OjI0IHAubS4gc2NocmllYiBNdWt1bCBKb3NoaToKPiBFdmVudCBi
aXRtYXNrIGlzIGEgNjQtYml0IG1hc2sgd2l0aCBvbmx5IDEgYml0IHNldC4gU2VuZGluZyB0aGlz
Cj4gZXZlbnQgYml0bWFzayBpbiBLRkQgU01JIGV2ZW50IG1lc3NhZ2UgaXMgYm90aCB3YXN0ZWZ1
bCBvZiBtZW1vcnkKPiBhbmQgcG90ZW50aWFsbHkgbGltaXRpbmcgdG8gb25seSA2NCBldmVudHMu
IEluc3RlYWQgc2VuZCBldmVudAo+IGluZGV4IGluIFNNSSBldmVudCBtZXNzYWdlLgoKUGxlYXNl
IGFkZCBhIHN0YXRlbWVudCBoZXJlLCB0aGF0IGZvciB0aGUgdHdvIGV2ZW50IHR5cGVzIGRlZmlu
ZWQgc28KZmFyLCB0aGlzIGNoYW5nZSBkb2VzIG5vdCBicmVhayB0aGUgQUJJLiBUaGUgbmV3IGlu
ZGV4IHdpbGwgYmUgaWRlbnRpY2FsCnRvIHRoZSBtYXNrIHVzZWQgYmVmb3JlLgoKCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBNdWt1bCBKb3NoaSA8bXVrdWwuam9zaGlAYW1kLmNvbT4KPiBTdWdnZXN0ZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc21pX2V2ZW50cy5jIHwgMjQgKysrKysrKysrKyst
LS0tLS0tLS0tCj4gIGluY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaCAgICAgICAgICAgICAg
fCAxMCArKysrKystLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxNCBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfc21pX2V2ZW50cy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVu
dHMuYwo+IGluZGV4IDg2YzJjM2U5Nzk0NC4uNGQ0YjZlM2FiNjk3IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zbWlfZXZlbnRzLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc21pX2V2ZW50cy5jCj4gQEAgLTE0OSw3ICsxNDksNyBA
QCBzdGF0aWMgaW50IGtmZF9zbWlfZXZfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgZmlsZSAqZmlsZXApCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiAtc3RhdGljIHZvaWQgYWRk
X2V2ZW50X3RvX2tmaWZvKHN0cnVjdCBrZmRfZGV2ICpkZXYsIHVuc2lnbmVkIGxvbmcgbG9uZyBz
bWlfZXZlbnQsCj4gK3N0YXRpYyB2b2lkIGFkZF9ldmVudF90b19rZmlmbyhzdHJ1Y3Qga2ZkX2Rl
diAqZGV2LCB1bnNpZ25lZCBpbnQgc21pX2V2ZW50LAo+ICAJCQkgICAgICBjaGFyICpldmVudF9t
c2csIGludCBsZW4pCj4gIHsKPiAgCXN0cnVjdCBrZmRfc21pX2NsaWVudCAqY2xpZW50Owo+IEBA
IC0xNTcsMTQgKzE1NywxNSBAQCBzdGF0aWMgdm9pZCBhZGRfZXZlbnRfdG9fa2ZpZm8oc3RydWN0
IGtmZF9kZXYgKmRldiwgdW5zaWduZWQgbG9uZyBsb25nIHNtaV9ldmVudAo+ICAJcmN1X3JlYWRf
bG9jaygpOwo+ICAKPiAgCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGNsaWVudCwgJmRldi0+c21p
X2NsaWVudHMsIGxpc3QpIHsKPiAtCQlpZiAoIShSRUFEX09OQ0UoY2xpZW50LT5ldmVudHMpICYg
c21pX2V2ZW50KSkKPiArCQlpZiAoIShSRUFEX09OQ0UoY2xpZW50LT5ldmVudHMpICYKPiArCQkJ
CUtGRF9TTUlfRVZFTlRfTUFTS19GUk9NX0lOREVYKHNtaV9ldmVudCkpKQo+ICAJCQljb250aW51
ZTsKPiAgCQlzcGluX2xvY2soJmNsaWVudC0+bG9jayk7Cj4gIAkJaWYgKGtmaWZvX2F2YWlsKCZj
bGllbnQtPmZpZm8pID49IGxlbikgewo+ICAJCQlrZmlmb19pbigmY2xpZW50LT5maWZvLCBldmVu
dF9tc2csIGxlbik7Cj4gIAkJCXdha2VfdXBfYWxsKCZjbGllbnQtPndhaXRfcXVldWUpOwo+ICAJ
CX0gZWxzZSB7Cj4gLQkJCXByX2RlYnVnKCJzbWlfZXZlbnQoRXZlbnRJRDogJWxsdSk6IG5vIHNw
YWNlIGxlZnRcbiIsCj4gKwkJCXByX2RlYnVnKCJzbWlfZXZlbnQoRXZlbnRJRDogJXUpOiBubyBz
cGFjZSBsZWZ0XG4iLAo+ICAJCQkJCXNtaV9ldmVudCk7Cj4gIAkJfQo+ICAJCXNwaW5fdW5sb2Nr
KCZjbGllbnQtPmxvY2spOwo+IEBAIC0xODAsMjEgKzE4MSwyMSBAQCB2b2lkIGtmZF9zbWlfZXZl
bnRfdXBkYXRlX3RoZXJtYWxfdGhyb3R0bGluZyhzdHJ1Y3Qga2ZkX2RldiAqZGV2LAo+ICAJLyoK
PiAgCSAqIFRoZXJtYWxUaHJvdHRsZSBtc2cgPSB0aHJvdHRsZV9iaXRtYXNrKDgpOgo+ICAJICog
CQkJIHRoZXJtYWxfaW50ZXJydXB0X2NvdW50KDE2KToKPiAtCSAqIDE2IGJ5dGVzIGV2ZW50ICsg
MSBieXRlIHNwYWNlICsgOCBieXRlIHRocm90dGxlX2JpdG1hc2sgKwo+ICsJICogMSBieXRlIGV2
ZW50ICsgMSBieXRlIHNwYWNlICsgOCBieXRlIHRocm90dGxlX2JpdG1hc2sgKwo+ICAJICogMSBi
eXRlIDogKyAxNiBieXRlIHRoZXJtYWxfaW50ZXJ1cHRfY291bnRlciArIDEgYnl0ZSBcbiArCj4g
LQkgKiAxIGJ5dGUgXDAgPSA0NAo+ICsJICogMSBieXRlIFwwID0gMjkKPiAgCSAqLwo+IC0JY2hh
ciBmaWZvX2luWzQ0XTsKPiArCWNoYXIgZmlmb19pblsyOV07Cj4gIAlpbnQgbGVuOwo+ICAKPiAg
CWlmIChsaXN0X2VtcHR5KCZkZXYtPnNtaV9jbGllbnRzKSkKPiAgCQlyZXR1cm47Cj4gIAo+IC0J
bGVuID0gc25wcmludGYoZmlmb19pbiwgNDQsICIleCAleDolbGx4XG4iLAo+ICsJbGVuID0gc25w
cmludGYoZmlmb19pbiwgMjksICIleCAleDolbGx4XG4iLAo+ICAJCSAgICAgICBLRkRfU01JX0VW
RU5UX1RIRVJNQUxfVEhST1RUTEUsIHRocm90dGxlX2JpdG1hc2ssCj4gIAkJICAgICAgIGF0b21p
YzY0X3JlYWQoJmFkZXYtPnNtdS50aHJvdHRsZV9pbnRfY291bnRlcikpOwo+ICAKPiAtCWFkZF9l
dmVudF90b19rZmlmbyhkZXYsIEtGRF9TTUlfRVZFTlRfVEhFUk1BTF9USFJPVFRMRSwgZmlmb19p
biwgbGVuKTsKPiArCWFkZF9ldmVudF90b19rZmlmbyhkZXYsIEtGRF9TTUlfRVZFTlRfVEhFUk1B
TF9USFJPVFRMRSwJZmlmb19pbiwgbGVuKTsKPiAgfQo+ICAKPiAgdm9pZCBrZmRfc21pX2V2ZW50
X3VwZGF0ZV92bWZhdWx0KHN0cnVjdCBrZmRfZGV2ICpkZXYsIHVpbnQxNl90IHBhc2lkKQo+IEBA
IC0yMDIsOSArMjAzLDEwIEBAIHZvaWQga2ZkX3NtaV9ldmVudF91cGRhdGVfdm1mYXVsdChzdHJ1
Y3Qga2ZkX2RldiAqZGV2LCB1aW50MTZfdCBwYXNpZCkKPiAgCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopZGV2LT5rZ2Q7Cj4gIAlzdHJ1Y3QgYW1k
Z3B1X3Rhc2tfaW5mbyB0YXNrX2luZm87Cj4gIAkvKiBWbUZhdWx0IG1zZyA9IChoZXgpdWludDMy
X3BpZCg4KSArIDooMSkgKyB0YXNrIG5hbWUoMTYpID0gMjUgKi8KPiAtCS8qIDE2IGJ5dGVzIGV2
ZW50ICsgMSBieXRlIHNwYWNlICsgMjUgYnl0ZXMgbXNnICsgMSBieXRlIFxuID0gNDMKPiArCS8q
IDEgYnl0ZSBldmVudCArIDEgYnl0ZSBzcGFjZSArIDI1IGJ5dGVzIG1zZyArIDEgYnl0ZSBcbiAr
Cj4gKwkgKiAxIGJ5dGUgXDAgPSAyOQo+ICAJICovCj4gLQljaGFyIGZpZm9faW5bNDNdOwo+ICsJ
Y2hhciBmaWZvX2luWzI5XTsKPiAgCWludCBsZW47Cj4gIAo+ICAJaWYgKGxpc3RfZW1wdHkoJmRl
di0+c21pX2NsaWVudHMpKQo+IEBAIC0yMTYsNyArMjE4LDcgQEAgdm9pZCBrZmRfc21pX2V2ZW50
X3VwZGF0ZV92bWZhdWx0KHN0cnVjdCBrZmRfZGV2ICpkZXYsIHVpbnQxNl90IHBhc2lkKQo+ICAJ
aWYgKCF0YXNrX2luZm8ucGlkKQo+ICAJCXJldHVybjsKPiAgCj4gLQlsZW4gPSBzbnByaW50Zihm
aWZvX2luLCA0MywgIiV4ICV4OiVzXG4iLCBLRkRfU01JX0VWRU5UX1ZNRkFVTFQsCj4gKwlsZW4g
PSBzbnByaW50ZihmaWZvX2luLCAyOSwgIiV4ICV4OiVzXG4iLCBLRkRfU01JX0VWRU5UX1ZNRkFV
TFQsCj4gIAkJdGFza19pbmZvLnBpZCwgdGFza19pbmZvLnRhc2tfbmFtZSk7Cj4gIAo+ICAJYWRk
X2V2ZW50X3RvX2tmaWZvKGRldiwgS0ZEX1NNSV9FVkVOVF9WTUZBVUxULCBmaWZvX2luLCBsZW4p
Owo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmggYi9pbmNsdWRl
L3VhcGkvbGludXgva2ZkX2lvY3RsLmgKPiBpbmRleCBkZjZjN2E0M2FhZGMuLjc5NmY4MzZiYTc3
MyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmgKPiArKysgYi9p
bmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmgKPiBAQCAtNDQ5LDkgKzQ0OSwxMyBAQCBzdHJ1
Y3Qga2ZkX2lvY3RsX2ltcG9ydF9kbWFidWZfYXJncyB7Cj4gIC8qCj4gICAqIEtGRCBTTUkoU3lz
dGVtIE1hbmFnZW1lbnQgSW50ZXJmYWNlKSBldmVudHMKPiAgICovCj4gLS8qIEV2ZW50IHR5cGUg
KGRlZmluZWQgYnkgYml0bWFzaykgKi8KPiAtI2RlZmluZSBLRkRfU01JX0VWRU5UX1ZNRkFVTFQJ
CQkweDAwMDAwMDAwMDAwMDAwMDEKPiAtI2RlZmluZSBLRkRfU01JX0VWRU5UX1RIRVJNQUxfVEhS
T1RUTEUJCTB4MDAwMDAwMDAwMDAwMDAwMgo+ICtlbnVtIGtmZF9zbWlfZXZlbnQgewo+ICsgICAg
ICAgIEtGRF9TTUlfRVZFTlRfTk9ORSA9IDAsIC8qIG5vdCB1c2VkICovCj4gKyAgICAgICAgS0ZE
X1NNSV9FVkVOVF9WTUZBVUxUID0gMSwgLyogZXZlbnQgc3RhcnQgY291bnRpbmcgYXQgMSAqLwo+
ICsgICAgICAgIEtGRF9TTUlfRVZFTlRfVEhFUk1BTF9USFJPVFRMRSA9IDIsCj4gK307Cj4gKwo+
ICsjZGVmaW5lIEtGRF9TTUlfRVZFTlRfTUFTS19GUk9NX0lOREVYKGkpICgxVUxMIDw8IChpIC0g
MSkpCgpJdCdzIGNvbW1vbiBiZXN0IHByYWN0aWNlIHRvIHdyYXAgYWxsIG1hY3JvIHBhcmFtZXRl
cnMgaW4gKCkuCgpXaXRoIHRoYXQgZml4ZWQsIHRoZSBwYXRjaCBpcwoKUmV2aWV3ZWQtYnk6IEZl
bGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKVGhhbmtzLArCoCBGZWxpeAoK
Cj4gIAo+ICBzdHJ1Y3Qga2ZkX2lvY3RsX3NtaV9ldmVudHNfYXJncyB7Cj4gIAlfX3UzMiBncHVp
ZDsJLyogdG8gS0ZEICovCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
