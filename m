Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2419C282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 00:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B175A24649
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 00:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="crL1CcgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175A24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB616E1E9;
	Sat, 11 Jan 2020 00:46:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97FD66E1E9
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 00:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3MuqCX0qN2dwj64lxIhMwzTJluQzIMuT5WM4M0EpKmvkqa1I7TdGTqejH3ybOqNgmDlYhguW/C0QmaNXGrQr9wpEQj/A+e/JJOOq6KwLT32H0BFN6XaaXBUiB0VtPqNdZ+ZIWJAf6HGY++tyokbedgZY7HmtTV/ZMMFqdSLMfAHQQOp0wAc6yhHnO76tPwrIdeu1LhqvvArNrPi6MEBaMv6DOQvtketmRmO+7JVJTOllnGru4IQnPp+rJNt0Pld0YTWhRZKdTwJ3MEtRjoF0XskfZB44hMD5vRVOEJYvZVlgAJQzlkQVDw9gdYCkpLs7JJW4Rnq/IfIRdt/zTrTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrGuEscnBvsoEk6eZRNz2jLW9WgKE6aotUQCcnPklRQ=;
 b=b423SHKeHfmy5KoQ4ySzIyaT6zLJwKEkw2si5ynwMMOYgEcJq/2tunIYs8tOXqhszDn1cUTOV8k3RXf2dFOMDjPSOJpdfuxSTt0Uu6Zk5pymQIk4fWQ1OzG3RhEzuiNUQFCX+JjTgF4ft0jJwIn5Rv70r6bkyri896ktGBpz7Pz8Pa+1VSwQ6BUZUhGFWzaFLiquKgwN3YZP2w7eIQyybiHJU0w1MFV/w6AQauA1aRTShQiEzSDgGFe28lQxm258Qx41wB0vc8+7p7X07Y+y7OGlcCWhfIPZKZJzRMJzzUSMUhmWDSD7xfFeQX4wQRkDlECrmRxNVKHh3mB33DOs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrGuEscnBvsoEk6eZRNz2jLW9WgKE6aotUQCcnPklRQ=;
 b=crL1CcgRxEdc+PvanOSMt997fUGqo3J3zwrD81RTp7w4N4VE4kdJd1ehDcMOiKO63fjQfs/N+YT1NHxcpip9i2MqzPecmLa4/S2YDOGDu+RUqfEDb40XLVQsbs0R8M3yd+R4McBnAFrHRBW5rjLII7F+l4zvJjk3RElg5E6QaYE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0251.namprd12.prod.outlook.com (10.174.106.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 00:46:28 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 00:46:28 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix a compiling warning
To: amd-gfx@lists.freedesktop.org, Yong Zhao <yong.zhao@amd.com>
References: <20200111004032.30224-1-Yong.Zhao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1fd13b0e-f2f7-75fc-7df6-01f1c023f6fa@amd.com>
Date: Fri, 10 Jan 2020 19:46:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200111004032.30224-1-Yong.Zhao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Sat, 11 Jan 2020 00:46:28 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98db5c86-f7ec-4d47-38cb-08d7962fb182
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0251:|DM5PR1201MB0251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0251B555C6B6213BF1005841923B0@DM5PR1201MB0251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(53546011)(2616005)(16526019)(5660300002)(186003)(36916002)(44832011)(2906002)(26005)(956004)(6486002)(6636002)(52116002)(6862004)(36756003)(81156014)(8936002)(8676002)(81166006)(86362001)(31686004)(31696002)(478600001)(16576012)(316002)(66476007)(66946007)(66556008)(37006003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0251;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ESfZ9ivFACuFn0kWrhjcXTyfmKBzYSDd/CguKjo3YUF46fO1VQ6WNtz8iTu/8Ij89zKfJyBLD5+zug0bEfgX3LsAtyfAtZSJ7PFzJppir0Ct+XlHYJE4QQ/Uitj52+piRV4qffvgZik0V5daRmFvcnOi9xCudQaqnfhXMZMzRGwsl0FWOU9nnq+3gHoV81tW5BFoZFMRXTZw31nd3/343qamMF1DxSqmbkyYtNnnAXzuJXck2YLvGvizDZPdqhCnlKC3c/p41Fuzrc53NnNKQTNYyzSJqRhS04/OObBexj/fPIU7YL48FZJhqqX75x+o7FwMvAVbnZrGamVGY1FzyCLi1SB9HZEwXeXzSEvrIo4ma7D/FTnR0cJdWNTL/2BfDsC2064JJmMsNJtkmQVTRak0I0oDNjyHi98R5XuuhOPZK7RU1y3EtWUyK5xVsVaU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db5c86-f7ec-4d47-38cb-08d7962fb182
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 00:46:28.4384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CGKfHhMoRhSs6UgVmZhJxh+s5r9BmjJd8Ud+jMGwUx1QpSfK/RwNyJ+XKW+dctpSUEjb7oxbOheXnmAzGqGZg==
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMC0wMS0xMCA3OjQwIHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBUaGUgd2FybmluZyB3
YXMgaW50cm9kdWNlZCBpbgo+Cj4gY29tbWl0IGI0MjY3ZjJlNjg3ZmY1ZTA0MDJhYjkxNWM5YTRk
NDdmOWE0ZWI3M2UKPiBBdXRob3I6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Cj4gRGF0
ZTogICBGcmkgRGVjIDEzIDExOjMxOjQ4IDIwMTkgLTA1MDAKPgo+ICAgICAgZHJtL2FtZGtmZDog
SW1wcm92ZSBmdW5jdGlvbiBnZXRfc2RtYV9ybGNfcmVnX29mZnNldCgpCj4KPiBDaGFuZ2UtSWQ6
IEk4N2RhNGYxYWQ4YTE5MDMyN2E0YTcxZjBmZjc4ODEyY2I5NDJkNmUwCj4gU2lnbmVkLW9mZi1i
eTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KCkluc3RlYWQgb2YgcXVvdGluZyB0aGUg
d2hvbGUgY2hhbmdlIGRlc2NyaXB0aW9uLCB0aGUgdXN1YWwgd2F5IHRvIHBvaW50IAp0byBhIHBy
aW9yIHBhdGNoIHRoYXQgeW91J3JlIGZpeGluZyBpcyB3aXRoIGEgdGFnCgogwqDCoMKgIEZpeGVz
OiA8MTIgZGlnaXRzIG9mIHNoYTE+ICgiY29tbWl0IHRpdGxlIikKCldpdGggdGhhdCBmaXhlZCwg
dGhpcyBwYXRjaCBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2FyY3R1cnVzLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfYW1ka2ZkX2FyY3R1cnVzLmMKPiBpbmRleCAyYjI2OTI1NjIzZWIuLmY5MDExYTA3
Y2I5MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1k
a2ZkX2FyY3R1cnVzLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
YW1ka2ZkX2FyY3R1cnVzLmMKPiBAQCAtNzEsNyArNzEsNyBAQCBzdGF0aWMgdWludDMyX3QgZ2V0
X3NkbWFfcmxjX3JlZ19vZmZzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkJ
dW5zaWduZWQgaW50IGVuZ2luZV9pZCwKPiAgIAkJCQl1bnNpZ25lZCBpbnQgcXVldWVfaWQpCj4g
ICB7Cj4gLQl1aW50MzJfdCBzZG1hX2VuZ2luZV9yZWdfYmFzZTsKPiArCXVpbnQzMl90IHNkbWFf
ZW5naW5lX3JlZ19iYXNlID0gMDsKPiAgIAl1aW50MzJfdCBzZG1hX3JsY19yZWdfb2Zmc2V0Owo+
ICAgCj4gICAJc3dpdGNoIChlbmdpbmVfaWQpIHsKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
