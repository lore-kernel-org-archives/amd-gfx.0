Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C50C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 20:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8BB2074A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 20:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bRUYC9de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8BB2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6B86E0F0;
	Fri, 28 Aug 2020 20:34:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5886E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 20:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnRWT2Zm1qdSsLw++Y+v8CI0gAAl4b0hw0kIKfUzLOCccHBpnI7JfFWBM161ocD4cuCrwZT9OPWHjfyBmxAhfYv4Baeh06uCiycA5mauVro7NoG3dPX0VJA0ZOOx9ZrQIvynyNTVeRrvKYjLvsBM/0iCdrBoBWr6ouuuUWLuc/lwel5h52EVcgt+BUgxkbnqzuClsYjfRZ5086VNVhTRVtE+4muprqD+FZ6FeAyeI31v771Av4FYTDiwxpZ7yAsNrglJK+aH9aoouksSXwj+XqwpjRO7LOYQgmu7gVxGspgF68IJ9Z0Z9b6mKMmsR9DxeCWHfP/m9gAxHpcwtca0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SizVQbGMsBZzZjwtQ3+ct2X5nOSidAXTN50L2RS42u4=;
 b=DaOE3rPVjEtkDYbpoyjeIn4/fXNd7FQZksyReFvUMKO1Gb0/Ih1m1MHYU1IPljlQDxyF94kp98D1XGi7jRsjbF6maTGtnek2F/bLLh/vT15+dTNMFe/2IU5CKe1h/HhNDSXzIAcndaG6a8a8T4bFldBpniQS8Qv0yoRqVhA2J7FDC4iCfyl9b2vFOeHNbs/6b3eUNuJldIViXJUb+4X0PgT4v2z+ookeAZv85MFlhI8pOUWZuPkSri/c5GbRhFU3bjtW1MkFCG2cgfTtQT4zJSwxG/cWebY0nfIlkezPjS1vMYfJvTc/KPjhSSLIcqNkIBH9dRzosIa/KoyAR10f+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SizVQbGMsBZzZjwtQ3+ct2X5nOSidAXTN50L2RS42u4=;
 b=bRUYC9dei0SKCbxXPTDTEbnvx1/pgvtqcuv9Lkoi0y8IfOUtDqzcaoUGuJRTQeO1MHDDKhqvklEbAtE2+MibG+iJbxw54U9OsZgUPO57UoVfWBGjfM053d1IRMm9rv26dbTWI0/oZchZZM3uajS5Y/MoAxIrON4iwtSqMYDt4Lg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 28 Aug
 2020 20:34:11 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 20:34:11 +0000
Subject: Re: [PATCH v3] drm/amdkfd: Add GPU reset SMI event
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200828175319.12125-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <94533098-ffd8-40a0-07bc-d23df794db25@amd.com>
Date: Fri, 28 Aug 2020 16:34:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200828175319.12125-1-mukul.joshi@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 20:34:10 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4f62c2a-3507-495f-58f1-08d84b91b863
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384A38F4B9959DE65F5D7D792520@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zghS0K4KJ30SoNh/sQKBP77LnEYAUvLha5DubI/1kugTVzpGl/Xm/qXQUvh+fnGBBkssYiqeIJeINWIcQ7n+jBfVv4JY3XPDyQqX2/aZoE7vh2tBN41Tg3m3VWawI6x1xseiFvW63svuqVF8DWZWqMUVpAc1hOyvV1JwsZG3cEd7A7V51/RgRVhX0+dJsNaOCQpa0H+xBpuWslrIdOYcnpRoUbvk9SKW5dTLCtPRoflqqWyKK1UwGtkvxX5I8W9vCdv+qShXmBjDMSE8juB1BQWWdTR230FRk7p/6gn95AkdF218vMNhokeDbzcQ456o1nRyNVk/lVYojz5/zpCfQh6MthdFf8NDwFKLJjm4uYnw+yKSTToW9+RiTmqKgHcA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(66946007)(66476007)(66556008)(186003)(5660300002)(478600001)(26005)(6486002)(8676002)(8936002)(83380400001)(36756003)(316002)(44832011)(956004)(16576012)(2616005)(52116002)(2906002)(86362001)(31686004)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6cjvT/tDNZkIcn3MUSJ7mk3DxUFPzJCd0TPXnLYdEc3OBlxs2KE9y3jqUv73vLgU2XcbZqY2ZLSWMp6mbTimekr8z8PmjC5Zst9FxFrvSrXBvb1Fb+lmc4PZ/tyrciV9OZWQKHUj+wQJsF25OW2ylw5AIRNXshBq84gC8F4EVwrd8BbFIwt0vqWdzGl7m32e8k5nLUTes3+Jn5LddsUjjGvosjns+MZA6pfrFz0USBmQnT+f67E3ZDW6jEJLFyHTHRrnx95VtqKq5dXdAgp0uEds5iGQ8z6Akk/c9Z0k+2PjH6qR/1vcN8X/m7BLjcCwCjrj+ZuRNPVP4YQYAvFL/Hf2SjCJsu1V/ybJH4R+3kGGJp0t/r7SLzuw+vLdEUiODzpYaIKg+lR88+b72CvuOz/0chLre59wvmoyeNqIsSkarluE3WbaXLlkHk705FUqygn50yyXTxTYTsgFBm/n3h+8gnQkAQBQq/SIG/e+4vtf62lMIiC+ZdQ9B9RLimH26uMSax7AEE5FYbn1yufs4nV6lnLvzeP2LMHQJZH4NA8x4AHaz/mQzx9l0IGW3b39L+ib/UN7EdPvLVBPImoSyLYoT+rqx4+sHoPwHq4MQykoPZCVI4jy1AUawyWx+cypfq9gAt2nktTOKWcmwncWTw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f62c2a-3507-495f-58f1-08d84b91b863
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 20:34:11.0064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNcyHD0W/PaHxSkSa974zMyGqvaH3Gj7ElzuQunhvlDnYiUxb7cuFebYB6f0WPUMlOVCgRFEVdPCYTd7SWvgyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
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

CkFtIDIwMjAtMDgtMjggdW0gMTo1MyBwLm0uIHNjaHJpZWIgTXVrdWwgSm9zaGk6Cj4gQWRkIHN1
cHBvcnQgZm9yIHJlcG9ydGluZyBHUFUgcmVzZXQgZXZlbnRzIHRocm91Z2ggU01JLiBLRkQKPiB3
b3VsZCByZXBvcnQgYm90aCBwcmUgYW5kIHBvc3QgR1BVIHJlc2V0IGV2ZW50cy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3NoaUBhbWQuY29tPgoKTWlub3IgY29kaW5n
LXN0eWxlIG5pdC1waWNrcyBpbmxpbmUuIFdpdGggdGhvc2UgZml4ZWQsIHRoaXMgcGF0Y2ggaXMK
ClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCkFu
ZCBJIG5vdGljZWQgYSBjb2Rpbmcgc3R5bGUgaXNzdWUgZnJvbSBhIHByZXZpb3VzIGNvbW1pdCB0
aGF0IGNvdWxkIGJlCmNsZWFuZWQgdXAgaW4gYSBmb2xsb3cgdXAuIFNlZSBpbmxpbmUuCgoKPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICAgICB8ICA1ICsr
Kwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgICAgIHwgIDIgKysK
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVudHMuYyB8IDM1ICsrKysr
KysrKysrKysrKysrKystLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc21pX2V2
ZW50cy5oIHwgIDEgKwo+ICBpbmNsdWRlL3VhcGkvbGludXgva2ZkX2lvY3RsLmggICAgICAgICAg
ICAgIHwgIDIgKysKPiAgNSBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9k
ZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+IGluZGV4
IGUxY2Q2NTk5NTI5Zi4uZjVlMWIzYWFhMTBjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2UuYwo+IEBAIC04MTIsNiArODEyLDggQEAgaW50IGtnZDJrZmRfcHJlX3Jl
c2V0KHN0cnVjdCBrZmRfZGV2ICprZmQpCj4gIAlpZiAoIWtmZC0+aW5pdF9jb21wbGV0ZSkKPiAg
CQlyZXR1cm4gMDsKPiAgCj4gKwlrZmRfc21pX2V2ZW50X3VwZGF0ZV9ncHVfcmVzZXQoa2ZkLCBm
YWxzZSk7Cj4gKwo+ICAJa2ZkLT5kcW0tPm9wcy5wcmVfcmVzZXQoa2ZkLT5kcW0pOwo+ICAKPiAg
CWtnZDJrZmRfc3VzcGVuZChrZmQsIGZhbHNlKTsKPiBAQCAtODMzLDYgKzgzNSw3IEBAIGludCBr
Z2Qya2ZkX3Bvc3RfcmVzZXQoc3RydWN0IGtmZF9kZXYgKmtmZCkKPiAgCWlmICgha2ZkLT5pbml0
X2NvbXBsZXRlKQo+ICAJCXJldHVybiAwOwo+ICAKPiArCgpVbm5lY2Vzc2FyeSB3aGl0ZS1zcGFj
ZSBjaGFuZ2UuCgoKPiAgCXJldCA9IGtmZF9yZXN1bWUoa2ZkKTsKPiAgCWlmIChyZXQpCj4gIAkJ
cmV0dXJuIHJldDsKPiBAQCAtODQwLDYgKzg0Myw4IEBAIGludCBrZ2Qya2ZkX3Bvc3RfcmVzZXQo
c3RydWN0IGtmZF9kZXYgKmtmZCkKPiAgCj4gIAlhdG9taWNfc2V0KCZrZmQtPnNyYW1fZWNjX2Zs
YWcsIDApOwo+ICAKPiArCWtmZF9zbWlfZXZlbnRfdXBkYXRlX2dwdV9yZXNldChrZmQsIHRydWUp
Owo+ICsKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3ByaXYuaAo+IGluZGV4IDE4YmM3MTFmOTdhZS4uN2U4NzY3OTM0NzQ4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oCj4gQEAgLTMxMiw2ICszMTIsOCBAQCBzdHJ1Y3Qg
a2ZkX2RldiB7Cj4gIAkvKiBDbGllbnRzIHdhdGNoaW5nIFNNSSBldmVudHMgKi8KPiAgCXN0cnVj
dCBsaXN0X2hlYWQgc21pX2NsaWVudHM7Cj4gIAlzcGlubG9ja190IHNtaV9sb2NrOwo+ICsKPiAr
CXVpbnQzMl90IHJlc2V0X3NlcV9udW07Cj4gIH07Cj4gIAo+ICBlbnVtIGtmZF9tZW1wb29sIHsK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVudHMu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zbWlfZXZlbnRzLmMKPiBpbmRleCA0
ZDRiNmUzYWI2OTcuLjAwMWNhY2IwOTQ2NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfc21pX2V2ZW50cy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX3NtaV9ldmVudHMuYwo+IEBAIC0xNzQsNiArMTc0LDM3IEBAIHN0YXRpYyB2b2lk
IGFkZF9ldmVudF90b19rZmlmbyhzdHJ1Y3Qga2ZkX2RldiAqZGV2LCB1bnNpZ25lZCBpbnQgc21p
X2V2ZW50LAo+ICAJcmN1X3JlYWRfdW5sb2NrKCk7Cj4gIH0KPiAgCj4gK3ZvaWQga2ZkX3NtaV9l
dmVudF91cGRhdGVfZ3B1X3Jlc2V0KHN0cnVjdCBrZmRfZGV2ICpkZXYsIGJvb2wgcG9zdF9yZXNl
dCkKPiArewo+ICsJLyoKPiArCSAqIEdwdVJlc2V0IG1zZyA9IFJlc2V0IHNlcSBudW1iZXIgKGlu
Y3JlbWVudGVkIGZvcgo+ICsJICogZXZlcnkgcmVzZXQgbWVzc2FnZSBzZW50IGJlZm9yZSBHUFUg
cmVzZXQpLgo+ICsJICogMSBieXRlIGV2ZW50ICsgMSBieXRlIHNwYWNlICsgOCBieXRlcyBzZXEg
bnVtICsKPiArCSAqIDEgYnl0ZSBcbiArIDEgYnl0ZSBcMCA9IDEyCj4gKwkgKi8KPiArCWNoYXIg
Zmlmb19pblsxMl07Cj4gKwlpbnQgbGVuOwo+ICsJdW5zaWduZWQgaW50IGV2ZW50Owo+ICsKPiAr
CWlmIChsaXN0X2VtcHR5KCZkZXYtPnNtaV9jbGllbnRzKSkgewo+ICsJCXJldHVybjsKPiArCX0K
CllvdSBkb24ndCBuZWVkIHt9IGZvciBhIHNpbmdsZSBzdGF0ZW1lbnQuCgoKPiArCj4gKwltZW1z
ZXQoZmlmb19pbiwgMHgwLCBzaXplb2YoZmlmb19pbikpOwo+ICsKPiArCWlmIChwb3N0X3Jlc2V0
KSB7CgpUaGUge30gYXJlIE9LIChhbmQgcmVjb21tZW5kZWQpIGhlcmUgZm9yIGNvbnNpc3RlbmN5
IHdpdGggdGhlIGVsc2UtYnJhbmNoLgoKCj4gKwkJZXZlbnQgPSBLRkRfU01JX0VWRU5UX0dQVV9Q
T1NUX1JFU0VUOwo+ICsJfSBlbHNlIHsKPiArCQlldmVudCA9IEtGRF9TTUlfRVZFTlRfR1BVX1BS
RV9SRVNFVDsKPiArCQkrKyhkZXYtPnJlc2V0X3NlcV9udW0pOwo+ICsJfQo+ICsKPiArCWxlbiA9
IHNucHJpbnRmKGZpZm9faW4sIHNpemVvZihmaWZvX2luKSwgIiV4ICV4XG4iLCBldmVudCwKPiAr
CQkJCQkJZGV2LT5yZXNldF9zZXFfbnVtKTsKPiArCj4gKwlhZGRfZXZlbnRfdG9fa2ZpZm8oZGV2
LCBldmVudCwgZmlmb19pbiwgbGVuKTsKPiArfQo+ICsKPiAgdm9pZCBrZmRfc21pX2V2ZW50X3Vw
ZGF0ZV90aGVybWFsX3Rocm90dGxpbmcoc3RydWN0IGtmZF9kZXYgKmRldiwKPiAgCQkJCQkgICAg
IHVpbnQzMl90IHRocm90dGxlX2JpdG1hc2spCj4gIHsKPiBAQCAtMTkxLDcgKzIyMiw3IEBAIHZv
aWQga2ZkX3NtaV9ldmVudF91cGRhdGVfdGhlcm1hbF90aHJvdHRsaW5nKHN0cnVjdCBrZmRfZGV2
ICpkZXYsCj4gIAlpZiAobGlzdF9lbXB0eSgmZGV2LT5zbWlfY2xpZW50cykpCj4gIAkJcmV0dXJu
Owo+ICAKPiAtCWxlbiA9IHNucHJpbnRmKGZpZm9faW4sIDI5LCAiJXggJXg6JWxseFxuIiwKPiAr
CWxlbiA9IHNucHJpbnRmKGZpZm9faW4sIHNpemVvZihmaWZvX2luKSwgIiV4ICV4OiVsbHhcbiIs
Cj4gIAkJICAgICAgIEtGRF9TTUlfRVZFTlRfVEhFUk1BTF9USFJPVFRMRSwgdGhyb3R0bGVfYml0
bWFzaywKPiAgCQkgICAgICAgYXRvbWljNjRfcmVhZCgmYWRldi0+c211LnRocm90dGxlX2ludF9j
b3VudGVyKSk7Cj4gIAo+IEBAIC0yMTgsNyArMjQ5LDcgQEAgdm9pZCBrZmRfc21pX2V2ZW50X3Vw
ZGF0ZV92bWZhdWx0KHN0cnVjdCBrZmRfZGV2ICpkZXYsIHVpbnQxNl90IHBhc2lkKQo+ICAJaWYg
KCF0YXNrX2luZm8ucGlkKQo+ICAJCXJldHVybjsKPiAgCj4gLQlsZW4gPSBzbnByaW50ZihmaWZv
X2luLCAyOSwgIiV4ICV4OiVzXG4iLCBLRkRfU01JX0VWRU5UX1ZNRkFVTFQsCj4gKwlsZW4gPSBz
bnByaW50ZihmaWZvX2luLCBzaXplb2YoZmlmb19pbiksICIleCAleDolc1xuIiwgS0ZEX1NNSV9F
VkVOVF9WTUZBVUxULAo+ICAJCXRhc2tfaW5mby5waWQsIHRhc2tfaW5mby50YXNrX25hbWUpOwo+
ICAKPiAgCWFkZF9ldmVudF90b19rZmlmbyhkZXYsIEtGRF9TTUlfRVZFTlRfVk1GQVVMVCwgZmlm
b19pbiwgbGVuKTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X3NtaV9ldmVudHMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zbWlfZXZlbnRz
LmgKPiBpbmRleCAxNTUzN2IyY2NjYjUuLmI5YjA0MzgyMDJlMiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc21pX2V2ZW50cy5oCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3NtaV9ldmVudHMuaAo+IEBAIC0yNyw1ICsyNyw2IEBAIGlu
dCBrZmRfc21pX2V2ZW50X29wZW4oc3RydWN0IGtmZF9kZXYgKmRldiwgdWludDMyX3QgKmZkKTsK
PiAgdm9pZCBrZmRfc21pX2V2ZW50X3VwZGF0ZV92bWZhdWx0KHN0cnVjdCBrZmRfZGV2ICpkZXYs
IHVpbnQxNl90IHBhc2lkKTsKPiAgdm9pZCBrZmRfc21pX2V2ZW50X3VwZGF0ZV90aGVybWFsX3Ro
cm90dGxpbmcoc3RydWN0IGtmZF9kZXYgKmRldiwKPiAgCQkJCQkgICAgIHVpbnQzMl90IHRocm90
dGxlX2JpdG1hc2spOwo+ICt2b2lkIGtmZF9zbWlfZXZlbnRfdXBkYXRlX2dwdV9yZXNldChzdHJ1
Y3Qga2ZkX2RldiAqZGV2LCBib29sIHBvc3RfcmVzZXQpOwo+ICAKPiAgI2VuZGlmCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC9rZmRfaW9jdGwuaAo+IGluZGV4IGNiMWY5NjNhODRlMC4uOGI3MzY4YmZiZDg0IDEwMDY0NAo+
IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9rZmRfaW9jdGwuaAo+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC9rZmRfaW9jdGwuaAo+IEBAIC00NTMsNiArNDUzLDggQEAgZW51bSBrZmRfc21pX2V2
ZW50IHsKPiAgICAgICAgICBLRkRfU01JX0VWRU5UX05PTkUgPSAwLCAvKiBub3QgdXNlZCAqLwo+
ICAgICAgICAgIEtGRF9TTUlfRVZFTlRfVk1GQVVMVCA9IDEsIC8qIGV2ZW50IHN0YXJ0IGNvdW50
aW5nIGF0IDEgKi8KPiAgICAgICAgICBLRkRfU01JX0VWRU5UX1RIRVJNQUxfVEhST1RUTEUgPSAy
LAoKTG9va3MgbGlrZSBhIHByZXZpb3VzIGNvbW1pdCBkaWRuJ3QgdXNlIFRBQnMgZm9yIGluZGVu
dGF0aW9uIGhlcmUuIENhbgp5b3UgbWFrZSBhIGZpeCBmb3IgdGhhdD8KClRoYW5rcywKwqAgRmVs
aXgKCgo+ICsJS0ZEX1NNSV9FVkVOVF9HUFVfUFJFX1JFU0VUID0gMywKPiArCUtGRF9TTUlfRVZF
TlRfR1BVX1BPU1RfUkVTRVQgPSA0LAo+ICB9Owo+ICAKPiAgI2RlZmluZSBLRkRfU01JX0VWRU5U
X01BU0tfRlJPTV9JTkRFWChpKSAoMVVMTCA8PCAoKGkpIC0gMSkpCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
