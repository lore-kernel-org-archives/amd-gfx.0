Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD56C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17265207F7
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 13:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SLoHqFJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17265207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F51889BFD;
	Thu,  1 Oct 2020 13:49:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95E189BFD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 13:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpyxuEmOWgEn2pwd00qb7dVoy4xoApaPOAthuroQPpnTYo6vBNkZ+C/EF6Q3z1V3Zw0KU+Jql2a3KH0OWjENWBRf5MthUcWR5dQBFABAiS9Mn/nahkz3FLU4of2uS60SGaF6Bn449kPlAczgyfy36aAeRXbmDMsY2LZ9sKwlbFORwg0sCWafYcRRr0is6c9vynzIOlHVQ0o2Fs5Z5PKiStkIkxgwQ1RoWKsi4Nf9O0qAgEfbiEVGC36VRZkMV125+XEjXq7psaD8/lXH5JDaObjS14pDoeuXfB/TmUzWrD1kWqlNmoQY11asF6titIqbFspjU1V9aLo4EALhy7pyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD3Q8fRKJdsPg4UriA2q2fr1vJzdVfcS8EiFKZMnpKc=;
 b=JQ90W+EuGjC5eCUWqEwf8uPVEeyFthkHAniKtuh1SAB4KDeKLnZecDKZvdqwzmnHU9tNruAexk5TtkFwxFgyJtvFcXwVdehv/WAtZ7/KrWVrhVdAaB9EQv2yJal9KNpiFW6X0TadhgS6uD9Y4oO2FWZvvC762mnQKTEUfcCg6ZF7IPJkNdBSbFLX1ZBah/8b05Upwc+92M0fjQHInEfHf+YKd8hb0RzRBANVqlfK7iJw9EXUydurOspeCf/b0Am/olEN4RKZCmZSCC5NCo03BQ+kKvFbIQLvIzfw/7fI4W8AF3DGNj/2NSiFMcLqr80b/eWrNu3yiFmOnAteyafLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD3Q8fRKJdsPg4UriA2q2fr1vJzdVfcS8EiFKZMnpKc=;
 b=SLoHqFJoNcQLySeArqOVzYsQ3CwThyC9q7U/h2x1hR8iPG1AVbBlnfbpIJHccXiWPEhKWNFJKnNG/L9XIDaJJYwFlmKTvIMT6r7ldknu8GAEIKAJI3jnojqDMHqnjWzREtitJqYoXHUPmLzNFPYbfTKMXdvP4s+5i5IiO2fIhGQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0207.namprd12.prod.outlook.com (2603:10b6:301:4d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 13:49:34 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe%2]) with mapi id 15.20.3433.036; Thu, 1 Oct 2020
 13:49:34 +0000
Subject: Re: [PATCH] drm/amd/display: Fix external display detection with
 overlay
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201001090607.12481-1-Pratik.Vishwakarma@amd.com>
 <648eacff-f8aa-ed2b-f24d-6ea25a8e3d62@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <993593dd-f944-9728-97c3-1ea7d94168d4@amd.com>
Date: Thu, 1 Oct 2020 09:49:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <648eacff-f8aa-ed2b-f24d-6ea25a8e3d62@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.62] (198.200.67.155) by
 YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Thu, 1 Oct 2020 13:49:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a309e0a-0634-4bed-bcb1-08d86610d468
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02077089D10A2B248C520B238C300@MWHPR1201MB0207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tgezEC+t39tdqZEgQSQ8YanhBVFJ/avz5CSEf4OaawUSCROLF+yaKbyEMYGwFy0K0cUm3rRj2tdzHK1Uk2ZiSeNwJpwKyEfWlchPNyrbf2jaDgXsbRVq9AXMbC2ajs3RycSv7jOXaswn4T7Slla7QtZZB3TrB7HT7HbSKlC5jOFR8EHIARJkAQiYpBqh0JTNufuVGmpUO+XH8toMKsUFNgXW2TmHe36ymL6+u/xCY3NOBRc35qUZ0ywDXtOJqbV6i/OuNXPQyMlCtMRq+S5BSTc6GNuMPD0O/aoHOi43t1d1QiZ/3M4wrfWZoGfEFRWLn3u4Or8d3lvvA8Eq/zKVLTmkBwC2widW9JcSYSGVDGTjUnx3mU/y1B037iEyDBWx3wLsLjiFZqMyTJGPuzF44vbDmMkpQs7HoU+e7x8XwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(53546011)(83380400001)(2616005)(956004)(966005)(36756003)(8676002)(6486002)(26005)(44832011)(5660300002)(45080400002)(2906002)(478600001)(31686004)(16526019)(52116002)(186003)(316002)(110136005)(66476007)(16576012)(66556008)(31696002)(66946007)(8936002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UVsqLXcu53ieTrj+YPoxhJ3pdkdii9CSpUstDoyzSP8F69GA4YtN7QdMzfdlIGUKoPADCE1r9pucU8/MaA9+wHw2F2oKwpJ9/2014aBqY/zSsaJu4Evi970ZF405SplL1HKMwQq2fgQ8pCEew5non2qIinqEYci44CeExnF5iCYVfO7jVtX6Q4DWKoLD2uE9MI7PPrdxVeWylhZsKfCWxW3lbAEA7AN0FHg12PkCtpWvCykTORC6RvivwQpxLmSZpe39A0AL++FtWELc6QIFM/hkF5J51+G/7XzN1Es48Qlafuwu/ZAulI8KIZU6Rzxd7Pu0ySEUOGqZTF/aa4F2tu0ppFoQwtAkQbPLurIJJu58wNDeffOzAfLl36TGLj67igbHzp38mugyDMBSOpoFX0i5bnLTzLlO9bEgZPLcxnhCGStQIVCAGBWRNo5uF2a9wW4R84s9TMTUCKQvgDhQ2JKUUNBxeHbXfwpxxX1tRs43IUbl/pLdKyUhDrEFDsjB0y4wZxlspiNzZwQGne7H6UkubYTDa79uRmJC8Yw4NN2xcWqLPvSRcId4YeYI/+8bSzBTecL77w2gb0HRezdvju5NEG2Ouelq5FX/3amHQWX1f4Ah9Kdo3fPXyKG1XcdmdRsjlMNTJc0euQmzbsWxUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a309e0a-0634-4bed-bcb1-08d86610d468
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:49:34.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oyi0My4BZW5OltvMpYeQZF4jP5PL3het4vpauGEtpfDOWbU5YR5NIdWeSBKWYX9KPu3dX7h6tkrCqeVe1jagkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0207
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

CgpPbiAyMDIwLTEwLTAxIDk6MDYgYS5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4g
T24gMjAyMC0xMC0wMSA1OjA2IGEubS4sIFByYXRpayBWaXNod2FrYXJtYSB3cm90ZToKPj4gW1do
eV0KPj4gV2hlbiBvdmVybGF5IHBsYW5lIGlzIGluIHVzZSBhbmQgZXh0ZXJuYWwgZGlzcGxheQo+
PiBpcyBjb25uZWN0ZWQsIGF0b21pYyBjaGVjayB3aWxsIGZhaWwuCj4+Cj4+IFtIb3ddCj4+IERp
c2FibGUgb3ZlcmxheSBwbGFuZSBvbiBtdWx0aS1tb25pdG9yIHNjZW5hcmlvCj4+IGJ5IHR5aW5n
IGl0IHRvIHNpbmdsZSBjcnRjLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQcmF0aWsgVmlzaHdha2Fy
bWEgPFByYXRpay5WaXNod2FrYXJtYUBhbWQuY29tPgo+IAo+IFRoaXMgd2lsbCBicmVhayBvdmVy
bGF5IHVzYWdlIG9uIGFueSBvdGhlciBDUlRDIG90aGVyIHRoYW4gaW5kZXggMS4gVGhhdCAKPiBp
bmRleCBpcyBhcmJpdHJhcnkgYW5kIGNhbiB2YXJ5IGJhc2VkIG9uIGJvYXJkIGNvbmZpZ3VyYXRp
b24uIEFzLWlzIHRoaXMgCj4gcGF0Y2ggYnJlYWtzIGEgbnVtYmVyIG9mIG91ciBleGlzdGluZyBJ
R1QgdGVzdHMgdGhhdCB3ZXJlIHByZXZpb3VzbHkgCj4gcGFzc2luZy4KPiAKPiBVc2Vyc3BhY2Ug
c2hvdWxkIHJlYWxseSBiZSBtYWRlIGF3YXJlIGlmIHBvc3NpYmxlIHRvIHVuZGVyc3RhbmQgdGhh
dCAKPiBvdmVybGF5cyBjYW4ndCBiZSBsZWZ0IGVuYWJsZWQgYWZ0ZXIgbWFqb3IgaGFyZHdhcmUg
Y29uZmlndXJhdGlvbnMgLSBlZy4gCj4gZW5hYmxpbmcgZXh0cmEgcGxhbmVzIGFuZCBDUlRDcy4K
PiAKClRvIGVsYWJvcmF0ZSBhIGJpdCBmdXJ0aGVyIG9uIHRoaXMsIEkgc3VnZ2VzdCB1c2Vyc3Bh
Y2UgZmlyc3QgZGlzYWJsZXMgCmFueSBvdmVybGF5IGJlZm9yZSBlbmFibGluZyBuZXcgY3J0Y3Mu
IEl0IG1heSB0aGVuIHRyeSB0byByZS1lbmFibGUgdGhlIApvdmVybGF5IGFmdGVyd2FyZHMgKGlm
IGF0b21pY19jaGVjayBhbGxvd3MgaXQgYXQgdGhhdCBwb2ludCkuCgpIYXJyeQoKPiBSZWdhcmRz
LAo+IE5pY2hvbGFzIEthemxhdXNrYXMKPiAKPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCj4+IMKgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyAKPj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+IGluZGV4IGU4
MTc3NjU2ZTA4My4uZTQ1YzExNzYwNDhhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4gQEAgLTMxNDksNyArMzE0OSw3
IEBAIHN0YXRpYyBpbnQgaW5pdGlhbGl6ZV9wbGFuZShzdHJ1Y3QgCj4+IGFtZGdwdV9kaXNwbGF5
X21hbmFnZXIgKmRtLAo+PiDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKgwqDCoCBwb3NzaWJsZV9j
cnRjcyA9IDEgPDwgcGxhbmVfaWQ7Cj4+IMKgwqDCoMKgwqAgaWYgKHBsYW5lX2lkID49IGRtLT5k
Yy0+Y2Fwcy5tYXhfc3RyZWFtcykKPj4gLcKgwqDCoMKgwqDCoMKgIHBvc3NpYmxlX2NydGNzID0g
MHhmZjsKPj4gK8KgwqDCoMKgwqDCoMKgIHBvc3NpYmxlX2NydGNzID0gMHgwMTsKPj4gwqDCoMKg
wqDCoCByZXQgPSBhbWRncHVfZG1fcGxhbmVfaW5pdChkbSwgcGxhbmUsIHBvc3NpYmxlX2NydGNz
LCBwbGFuZV9jYXApOwo+Pgo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZs
aXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0hBUlJZLldFTlRMQU5EJTQwYW1k
LmNvbSU3Q2MxNDBmODZhOGVkYzQ4ZmFiMzVhMDhkODY2MGI5OTliJTdDM2RkODk2MWZlNDg4NGU2
MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzM3MTU0NzMwMDY3NDM0MSZhbXA7c2RhdGE9
USUyRkdwS2JqWEtwckRWWUZxeXVONjJVUmdmTHp2bEcxVE1pcGxMd3FidW9BJTNEJmFtcDtyZXNl
cnZlZD0wIAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
