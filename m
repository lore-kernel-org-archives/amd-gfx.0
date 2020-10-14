Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03026C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7413E22201
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 13:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J/yjNEPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7413E22201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6026EA98;
	Wed, 14 Oct 2020 13:21:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 332CA6EA98
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 13:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIRPjdEWIukmWJIyqL5eAx6NMrVMYK5CG01p7sK/vgdqhrlSdHOHo7P/c8AerDoKaxR453Cxk49zbazCcIY6UDkYCTOSpR9C8FAWp34uxna803f/2w++O3zkukB0xsgTTT8lJpw0IHjeuZYfeCeP/M43Mej2hMz5lz47uue3Bea6jPs0thbywTfq4gPifetJEZlzYZ4/p50bNLX9Dgx87sgJTniQ1GNu39YvDzkUkc+s37JIo+HBq3bMyCr14qI6K+/g5/wtw+/JnQG3x8w7e9efAbYesCa5261z98IvDezJdAFuszjqFw726Cw+2QzFr+I44B+iqQDRWhXk5LyOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBSYhfCHCTwVWk4jbT2AmLAZW5QHye6nd7FJxn38YKY=;
 b=NZIxr4tEmgYfd6P1EjKL+0bBdkpm1yRe/T0svBCQFgufvUwuCDLPMoUUvCOz3xEAJBUIlyjbTTxykO+UugkSjukFo7kgNaCuLcbABnEojG77zkBN4W6ND6datnra2Z4fs/Z7sMbT7Hddx1+5OzMxkRxwLEct3/T1QCnJF8xBpOyBXWeHrJpqn5CmJpr5RbLNhMWyevr3v+h6OS08k9bTWBgp/VR77qNaS+7cWGdUWkPzB5tqWBtkHaSIRptq1ZeCVf5ZfXtfXiqYIxw0+U+5+UDTlc57Sw8fbtdWnF9oNcnnLidXehYKmKxwWHV0G6yVRRK7j+QjQH8uXhYqexVYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBSYhfCHCTwVWk4jbT2AmLAZW5QHye6nd7FJxn38YKY=;
 b=J/yjNEPxX/NWajch6JZ1mJ3dhWhsTFvw5PT1A0/5FFTwofB9PD5NZWj4tZZ7dExGeIEHI76r7oFcrre5ia7a2gUyGdD9ID9AISxomJQjL4I7HwZ4vNLcUWySWid+283FEkKBjpGyBAQuJR3uRMWNmKCWwlqlba6Cfv8gqw6j5xw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 14 Oct
 2020 13:21:37 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5eb:6935:456d:c18f]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::5eb:6935:456d:c18f%5]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 13:21:37 +0000
Subject: Re: [PATCH 1/2] drm/amd/display: setup system context in dm_init
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201014070431.32207-1-yifan1.zhang@amd.com>
 <2ee6e905-ea6f-ded8-d72f-b14aac541b76@amd.com>
Message-ID: <ce07d251-fb08-fd91-f5ea-be55fc580753@amd.com>
Date: Wed, 14 Oct 2020 09:21:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <2ee6e905-ea6f-ded8-d72f-b14aac541b76@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 13:21:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56eea852-8702-4000-5e4a-08d870441432
X-MS-TrafficTypeDiagnostic: BYAPR12MB4597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4597670DBE1D1FB2FAD3F584EC050@BYAPR12MB4597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYCT41F45xS9H/RT23TbgbnUCpTrjeTGEYWaAGwzsjuWc8nb9h52EEgG8wRaw/rmxcBZSrITcr8x7QYI0RceZ+iV385/F1yqWHznzNniVveA2KIGTpLKq6HKYgyNe6KKOR0L/oR62H2it1y2YeZYEgL7pSb+K/KrIb8ZKLZzNrV+1ofm42Wcz7lz8mrf9FRPEP3+rCBJYy47ocFBUX4SH3aEQ/PcoNoaJ76aOw0sYX7mruaiq90F7VJUe7A41hwkuVDz8ZKABYnVmsxlw4Un86HieqzxUpTDXS3JqCBMJqPO2xv74coZ3x8qc5zjWwPVk9DzxeCEAoJ9WwfJ99/T3kIPtEOhqc1hTk6L3mpExEaajsZT1fLs8/rFPw+r0DOQ2lbxk1d3WkRFIDKC72X4q7VAizED8IGZq1CQcpDb/bA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(966005)(31696002)(956004)(53546011)(5660300002)(31686004)(2616005)(16526019)(186003)(36756003)(66476007)(66556008)(66946007)(26005)(478600001)(8676002)(8936002)(86362001)(83380400001)(2906002)(316002)(6486002)(4001150100001)(4326008)(52116002)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GibEYH2BUvQHLZZ2XnBcILq2gDuEPOBkpRGQHC3lS+xKwr8+Lp2WpIOdVkhaRNSdD4SuSEt3NAixlb7KcaCnro6P64/Tobol1SctxIpFl1ZGHzVGdxynWQaqd7oK5wWwOmEq+1E0WB2Mrl4QoMVvd2ADZWvfRQL4s6LSoi4odnybHo6zc1eNMwajqFlcf71AurIyZSP43BywQBuGS23iXfQFwKjf9iRhj49gSEZyMcAhF1VSMcbXzuO43w6o+TxuF58Adk8JrydYQIl38GEjZqIkOaeTo2mFlUCJ/Rk+B03jm5ROGuW+WlNLuwpyKatJVsmcH71RVz/YtHV8ba171FJdpG1ytokLEXNJUK1SKIaYFrysbmBn+1wHvDY6Va+auxJAewQN9/YyCm/qcOaixHVCG56ROtEbigbmcRugN266/z+GC0avYS4sUlp29gmU4x7cUUk/QcosgTncICXWzCq9rlBoLw0bxQyydY7Fkuvk4oRyiWKOBuijwF1f49Ti9N6lasFc6V8yrqtrab+VB4wcG0sLLNDLgjhBN49Y/W7uUn3k49NYDCwjwb6ZoRTFDnXBMCugDSN1YM28JW5N4XQxr22gTmruhK46t5O4vNPorabWnuLCyKC/Dv9//piXT/wuKZv3C9rAFfk9Fur3jA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eea852-8702-4000-5e4a-08d870441432
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 13:21:37.4795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNiNoCxghviEd7ShVVlZV0GPxQgrmqeTl9g+g20lv/UvOQtXLT79KCaD6nBioquCHdlDDZ8WbfVXxK+YKEDYtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4597
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
Cc: sunpeng.li@amd.com, harry.wentland@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0xMC0xNCA5OjIwIGEubS4sIEthemxhdXNrYXMsIE5pY2hvbGFzIHdyb3RlOgo+IE9u
IDIwMjAtMTAtMTQgMzowNCBhLm0uLCBZaWZhbiBaaGFuZyB3cm90ZToKPj4gQ2hhbmdlLUlkOiBJ
ODMxYTVhZGU4Yjg3YzIzZDIxYTYzZDA4Y2M0ZDMzODQ2ODc2OWUyYgo+PiBTaWduZWQtb2ZmLWJ5
OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCAuLi4vZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA2MSArKysrKysrKysrKysr
KysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5j
IAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
Pj4gaW5kZXggM2NmNGUwODkzMWJiLi5hYWZmODgwMGM3YTAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiBAQCAtODg3
LDEyICs4ODcsNjcgQEAgc3RhdGljIHZvaWQgCj4+IGFtZGdwdV9jaGVja19kZWJ1Z2ZzX2Nvbm5l
Y3Rvcl9wcm9wZXJ0eV9jaGFuZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4gwqDCoMKgwqDCoCB9
Cj4+IMKgIH0KPj4gK3N0YXRpYyB2b2lkIG1taHViX3JlYWRfc3lzdGVtX2NvbnRleHQoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIAo+PiBzdHJ1Y3QgZGNfcGh5X2FkZHJfc3BhY2VfY29uZmln
ICpwYV9jb25maWcpCj4+ICt7Cj4+ICvCoMKgwqAgdWludDY0X3QgcHRfYmFzZTsKPj4gK8KgwqDC
oCB1aW50MzJfdCBsb2dpY2FsX2FkZHJfbG93Owo+PiArwqDCoMKgIHVpbnQzMl90IGxvZ2ljYWxf
YWRkcl9oaWdoOwo+PiArwqDCoMKgIHVpbnQzMl90IGFncF9iYXNlLCBhZ3BfYm90LCBhZ3BfdG9w
Owo+PiArwqDCoMKgIFBIWVNJQ0FMX0FERFJFU1NfTE9DIHBhZ2VfdGFibGVfc3RhcnQsIHBhZ2Vf
dGFibGVfZW5kLCAKPj4gcGFnZV90YWJsZV9iYXNlOwo+PiArCj4+ICvCoMKgwqAgbG9naWNhbF9h
ZGRyX2xvd8KgID0gbWluKGFkZXYtPmdtYy5mYl9zdGFydCwgYWRldi0+Z21jLmFncF9zdGFydCkg
Cj4+ID4+IDE4Owo+PiArwqDCoMKgIHB0X2Jhc2UgPSBhbWRncHVfZ21jX3BkX2FkZHIoYWRldi0+
Z2FydC5ibyk7Cj4+ICsKPj4gK8KgwqDCoCBpZiAoYWRldi0+YXB1X2ZsYWdzICYgQU1EX0FQVV9J
U19SQVZFTjIpCj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIFJh
dmVuMiBoYXMgYSBIVyBpc3N1ZSB0aGF0IGl0IGlzIHVuYWJsZSB0byB1c2UgdGhlIHZyYW0gd2hp
Y2gKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBpcyBvdXQgb2YgTUNfVk1fU1lTVEVNX0FQRVJUVVJF
X0hJR0hfQUREUi4gU28gaGVyZSBpcyB0aGUKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB3b3JrYXJv
dW5kIHRoYXQgaW5jcmVhc2Ugc3lzdGVtIGFwZXJ0dXJlIGhpZ2ggYWRkcmVzcyAoYWRkIDEpCj4+
ICvCoMKgwqDCoMKgwqDCoMKgICogdG8gZ2V0IHJpZCBvZiB0aGUgVk0gZmF1bHQgYW5kIGhhcmR3
YXJlIGhhbmcuCj4+ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+ICvCoMKgwqDCoMKgwqDCoCBsb2dp
Y2FsX2FkZHJfaGlnaCA9IG1heCgoYWRldi0+Z21jLmZiX2VuZCA+PiAxOCkgKyAweDEsIAo+PiBh
ZGV2LT5nbWMuYWdwX2VuZCA+PiAxOCk7Cj4+ICvCoMKgwqAgZWxzZQo+PiArwqDCoMKgwqDCoMKg
wqAgbG9naWNhbF9hZGRyX2hpZ2ggPSBtYXgoYWRldi0+Z21jLmZiX2VuZCwgYWRldi0+Z21jLmFn
cF9lbmQpIAo+PiA+PiAxODsKPj4gKwo+PiArwqDCoMKgIGFncF9iYXNlID0gMDsKPj4gK8KgwqDC
oCBhZ3BfYm90ID0gYWRldi0+Z21jLmFncF9zdGFydCA+PiAyNDsKPj4gK8KgwqDCoCBhZ3BfdG9w
ID0gYWRldi0+Z21jLmFncF9lbmQgPj4gMjQ7Cj4+ICsKPj4gKwo+PiArwqDCoMKgIHBhZ2VfdGFi
bGVfc3RhcnQuaGlnaF9wYXJ0ID0gKHUzMikoYWRldi0+Z21jLmdhcnRfc3RhcnQgPj4gNDQpICYg
Cj4+IDB4RjsKPj4gK8KgwqDCoCBwYWdlX3RhYmxlX3N0YXJ0Lmxvd19wYXJ0ID0gKHUzMikoYWRl
di0+Z21jLmdhcnRfc3RhcnQgPj4gMTIpOwo+PiArwqDCoMKgIHBhZ2VfdGFibGVfZW5kLmhpZ2hf
cGFydCA9ICh1MzIpKGFkZXYtPmdtYy5nYXJ0X2VuZCA+PiA0NCkgJiAweEY7Cj4+ICvCoMKgwqAg
cGFnZV90YWJsZV9lbmQubG93X3BhcnQgPSAodTMyKShhZGV2LT5nbWMuZ2FydF9lbmQgPj4gMTIp
Owo+PiArwqDCoMKgIHBhZ2VfdGFibGVfYmFzZS5oaWdoX3BhcnQgPSB1cHBlcl8zMl9iaXRzKHB0
X2Jhc2UpICYgMHhGOwo+PiArwqDCoMKgIHBhZ2VfdGFibGVfYmFzZS5sb3dfcGFydCA9IGxvd2Vy
XzMyX2JpdHMocHRfYmFzZSk7Cj4+ICsKPj4gK8KgwqDCoCBwYV9jb25maWctPnN5c3RlbV9hcGVy
dHVyZS5zdGFydF9hZGRyID0gCj4+ICh1aW50NjRfdClsb2dpY2FsX2FkZHJfbG93IDw8IDE4Owo+
PiArwqDCoMKgIHBhX2NvbmZpZy0+c3lzdGVtX2FwZXJ0dXJlLmVuZF9hZGRyID0gKHVpbnQ2NF90
KWxvZ2ljYWxfYWRkcl9oaWdoIAo+PiA8PCAxODsKPj4gKwo+PiArwqDCoMKgIHBhX2NvbmZpZy0+
c3lzdGVtX2FwZXJ0dXJlLmFncF9iYXNlID0gKHVpbnQ2NF90KWFncF9iYXNlIDw8IDI0IDsKPj4g
K8KgwqDCoCBwYV9jb25maWctPnN5c3RlbV9hcGVydHVyZS5hZ3BfYm90ID0gKHVpbnQ2NF90KWFn
cF9ib3QgPDwgMjQ7Cj4+ICvCoMKgwqAgcGFfY29uZmlnLT5zeXN0ZW1fYXBlcnR1cmUuYWdwX3Rv
cCA9ICh1aW50NjRfdClhZ3BfdG9wIDw8IDI0Owo+PiArCj4+ICvCoMKgwqAgcGFfY29uZmlnLT5z
eXN0ZW1fYXBlcnR1cmUuZmJfYmFzZSA9IGFkZXYtPmdtYy5mYl9zdGFydDsKPj4gK8KgwqDCoCBw
YV9jb25maWctPnN5c3RlbV9hcGVydHVyZS5mYl9vZmZzZXQgPSBhZGV2LT5nbWMuYXBlcl9iYXNl
Owo+PiArwqDCoMKgIHBhX2NvbmZpZy0+c3lzdGVtX2FwZXJ0dXJlLmZiX3RvcCA9IGFkZXYtPmdt
Yy5mYl9lbmQ7Cj4+ICsKPj4gK8KgwqDCoCBwYV9jb25maWctPmdhcnRfY29uZmlnLnBhZ2VfdGFi
bGVfc3RhcnRfYWRkciA9IAo+PiBwYWdlX3RhYmxlX3N0YXJ0LnF1YWRfcGFydCA8PCAxMjsKPj4g
K8KgwqDCoCBwYV9jb25maWctPmdhcnRfY29uZmlnLnBhZ2VfdGFibGVfZW5kX2FkZHIgPSAKPj4g
cGFnZV90YWJsZV9lbmQucXVhZF9wYXJ0IDw8IDEyOwo+PiArwqDCoMKgIHBhX2NvbmZpZy0+Z2Fy
dF9jb25maWcucGFnZV90YWJsZV9iYXNlX2FkZHIgPSAKPj4gcGFnZV90YWJsZV9iYXNlLnF1YWRf
cGFydDsKPj4gKwo+PiArwqDCoMKgIHBhX2NvbmZpZy0+aXNfaHZtX2VuYWJsZWQgPSAwOwo+PiAr
Cj4+ICt9Cj4+ICsKPj4gKwo+PiDCoCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGRjX2luaXRf
ZGF0YSBpbml0X2RhdGE7Cj4+IMKgICNpZmRlZiBDT05GSUdfRFJNX0FNRF9EQ19IRENQCj4+IMKg
wqDCoMKgwqAgc3RydWN0IGRjX2NhbGxiYWNrX2luaXQgaW5pdF9wYXJhbXM7Cj4+IMKgICNlbmRp
Zgo+PiArwqDCoMKgIHN0cnVjdCBkY19waHlfYWRkcl9zcGFjZV9jb25maWcgcGFfY29uZmlnOwo+
PiDCoMKgwqDCoMKgIGludCByOwo+PiDCoMKgwqDCoMKgIGFkZXYtPmRtLmRkZXYgPSBhZGV2X3Rv
X2RybShhZGV2KTsKPj4gQEAgLTEwNDAsNiArMTA5NSwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV9k
bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldikKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGdvdG8gZXJyb3I7Cj4+IMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgIG1taHViX3JlYWRfc3lz
dGVtX2NvbnRleHQoYWRldiwgJnBhX2NvbmZpZyk7Cj4+ICsKPj4gK8KgwqDCoCAvLyBDYWxsIHRo
ZSBEQyBpbml0X21lbW9yeSBmdW5jCj4+ICvCoMKgwqAgZGNfc2V0dXBfc3lzdGVtX2NvbnRleHQo
YWRldi0+ZG0uZGMsICZwYV9jb25maWcpOwo+PiArCj4+ICsKPiAKPiBUaGUgZGNfc2V0dXBfc3lz
dGVtX2NvbnRleHQgc2hvdWxkIGNvbWUgZGlyZWN0bHkgYWZ0ZXIgZGNfaGFyZHdhcmVfaW5pdCgp
Lgo+IAo+IFdpdGggdGhhdCBmaXhlZCB0aGlzIHNlcmllcyBpcwo+IAo+IFJldmlld2VkLWJ5OiBO
aWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Cj4gCj4gVGhl
cmUncyB0aGUgdm1pZCBtb2R1bGUgYXMgd2VsbCB0aGF0IGNvdWxkIGJlIGNyZWF0ZWQgYWZ0ZXIg
aWYgbmVlZGVkIAo+IGJ1dCBmb3Igcy9nIHN1cG9ydCBhbG9uZSB0aGF0J3Mgbm90IG5lY2Vzc2Fy
eS4KPiAKPiBSZWdhcmRzLAo+IE5pY2hvbGFzIEthemxhdXNrYXMKCkFjdHVhbGx5LCB0aGUgY29t
bWl0IG1lc3NhZ2VzIGNvdWxkIHVzZSBzb21lIHdvcmsgdG9vIC0gd291bGQgYmUgZ29vZCB0byAK
aGF2ZSBhdCBsZWFzdCBhIGJyaWVmIHdoeS9ob3cgZGVzY3JpcHRpb24uCgpEb24ndCBmb3JnZXQg
dG8gZHJvcCB0aGUgQ2hhbmdlLUlkIGFzIHdlbGwuCgpSZWdhcmRzLApOaWNob2xhcyBLYXpsYXVz
a2FzCgo+IAo+PiDCoMKgwqDCoMKgIERSTV9ERUJVR19EUklWRVIoIktNUyBpbml0aWFsaXplZC5c
biIpOwo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pgo+IAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeCAKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
