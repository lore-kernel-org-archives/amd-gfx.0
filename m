Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D61C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DFA2084C
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xeMHANPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DFA2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D254E6E140;
	Fri, 16 Oct 2020 12:35:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770088.outbound.protection.outlook.com [40.107.77.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD4C6E140
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 12:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib39a5vGGLvzcgwZdekUj/ZMLrX8BEiKU3EObJDbFWeV8oveQ1HXXL2wp+xUctkOZHICiOVT2Q6D0gQEbsD7HyFywstk+EX+o1QqpfnQ/cIvD+z6qvRVpuG0MKIZdgEZ24awqZojmOLgXD0Q26vohZMz1/BHe9kWOARjUNdmQLHgYfUel5ihEXPkSNF7wVRxMYtqecsAt9fK3JWlUSs7BSPY7eXp008wvSJUutIxIc4Owgb7j277ezadx5j9ivvQI4N08EDZJo3v4lF5+cjYOs8mPG+FwQWDuIJPC3aoARJgnMXKeXXbp3pXs0cX+3s+APs/8TNL5S4TZWYdeW0QDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Pf0xB3nvCsgbhNSV+z/dM1eHAvIaJwgYvkOfub0hI=;
 b=NznY5TPGmLyaNP1olDvdrKh9KhAXWhJ+efv5vXIuI77T8B7CZ59k9EaeSgPHCraRM+lHd3+GF8MgME58LUHdHL+/6nV4hDuUgRTHaj8QhoPERZEU8zj5VWpdkMBJWY64/nfHtzf19EFAeC5WcNkPeT+7thpcnM1lljzEbeni2AuuwFG4sfYtMQIZ+ggRgpwWONNdonUDnL2AIU5L/ZV4eRvePk0VdAVIGkKoR6gpyD+stgYfRC7EzMKensFxfcIXLardoz4nhRpUHXPnFFeQg+F1+V62gjAWrNrXBeDWg6hQ4yRm+DjAR4+2ES+rXgnlwkDjyC2zv9fV2O0wJUUzuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/Pf0xB3nvCsgbhNSV+z/dM1eHAvIaJwgYvkOfub0hI=;
 b=xeMHANPZzh0ZMEw56zvYuT6KVB3o1WWwA0Ixoqvjh7qBlYCHYLR8MkoFqaWREWmQU84GFm91YsguTZacTNpmU+QELbtY4YTQFlTzHIfChvFUzQEHP1QqJ7r7+OP+YiEKnnuxniWBzOsQyYRTn+fdKDinAsMorftDbCrQhmmAXac=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 16 Oct
 2020 12:35:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 12:35:22 +0000
Subject: Re: [PATCH] drm/amdgpu: don't map BO in reserved region
To: Madhav Chauhan <madhav.chauhan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201016123307.23262-1-madhav.chauhan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <caa427c0-5c89-ada2-8b4f-d8f6f6c5cd80@amd.com>
Date: Fri, 16 Oct 2020 14:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201016123307.23262-1-madhav.chauhan@amd.com>
Content-Language: en-US
X-Originating-IP: [93.132.127.18]
X-ClientProxiedBy: AM3PR07CA0062.eurprd07.prod.outlook.com
 (2603:10a6:207:4::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.137.56] (93.132.127.18) by
 AM3PR07CA0062.eurprd07.prod.outlook.com (2603:10a6:207:4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.11 via Frontend Transport; Fri, 16 Oct 2020 12:35:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e8bdc551-9088-4cc2-27cb-08d871cff2dc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4689138930EC8F247D04400883030@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7eXMkwa9PmgYmcAxIH8z1dLggNS7Lj0Ho++0om8VD6hS8AHtWdVm0yZIcbv8dHc3zCOvgOThdx6R9W1rXyybcGhOZuMlwThOHHHkbDITj9823yON6Icn/OeOo+iY8PMleQ9YxUbYP2IkGiEBiwPdoHrgadiiqX3lgx+lpWc5VJCtniOkRp45hBCo5yh1UyUy1a+I3g8j32GFKixbNR3MSLMzXmWFz29WYnfroid0nNZHZ/RxMz1NfIFxUpNrbfAM8NfIcyaX/8KwEVtYw0bgycIiMdIAm46Cz68T1nIC/g0XVBKOpOYUr4M3qjwT1YItc9ago4BhomEh22KHrX58J9fDD05AtvUqRA0nCv3eNz9o+ddxWD7tat3R4wCBXe2lgnViFfcJDIZWT4fFIZlCfK2ZIEYFA7LHO5j41xyQGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(16576012)(956004)(2616005)(316002)(31696002)(2906002)(26005)(6666004)(186003)(16526019)(5660300002)(8676002)(31686004)(478600001)(8936002)(6486002)(66946007)(66476007)(34490700002)(66556008)(52116002)(86362001)(36756003)(66574015)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4vJv2PuFJSNysEJOcIoTuccrq5fC0YsWokj43Z6EVUYf7+HBNeoQXt6G1yvt0KbVXRHPPMIky17IrU9YjLShdvfWIeXPyjH8WvMg0Kt+zuq4lYm9FEs+m0x9UUAIGj2O0gDlUYdMQ9i9ZbQETthtsX6hn07nQXabDVVWHJuFzPtHYK+ZsQr/ad2kHvGRw+X5DogBZRQ10siBP+ZtJzbFpepvKaln5bHBZiiV4w+7DO37fLlrstgmEu6Fb6SSOFfOE79mkz3/6L5wN7d5UwVvPZ+ahcCqFBfFxUdrrcAeRNUhmRZ0unKvyKqB4zoNsj8Sxxy8wtqwUq2Z3WrwMaufjEar5CEUkxw/s2YbroWAGVyY3fnm6aC7T45N6o7Py5mVxr9X6pDvReD775E6a66ZwPpFFPtTmelyHPnJbVz6ELaAG3SMx/trnvjChJls3WIcKcc87XOxnR8wXJDeMSGwHzE/Zaj5dyjnDBsogn06ecbCq7ZfXwiUsCDIBxWzURJsqz1oMa+HRYlaqG/VKkQpgIotNYt3TtDfcWbBl6y8OHZyKJO6DcVrRv/7soEiq3e08aD8G6BgKcjl++u4s5pMcMlbaCiDD+b8YV7hkIBJS9zZcFNLg/8tZqDrYaLBggkJrkFY1ctwOAyDWR1TeG/NNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bdc551-9088-4cc2-27cb-08d871cff2dc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 12:35:22.4265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytcEMlyShr3kvRPtRAZRqY06A3PAD6dJJSimK4OaJAyXyfeRtztCKgjFjqoVTjtT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
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

QW0gMTYuMTAuMjAgdW0gMTQ6MzMgc2NocmllYiBNYWRoYXYgQ2hhdWhhbjoKPiAyTUIgYXJlYSBp
cyByZXNlcnZlZCBhdCB0b3AgaW5zaWRlIFZNLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWFkaGF2
IENoYXVoYW4gPG1hZGhhdi5jaGF1aGFuQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDEwICsrKysrKysrKysKPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jCj4gaW5kZXggNTA0Nzk4OWZlOTQxLi41YjUwODYwZWVjZTQgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4gQEAgLTU5Niw2ICs1OTYsNyBAQCBp
bnQgYW1kZ3B1X2dlbV92YV9pb2N0bChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRh
LAo+ICAgCXN0cnVjdCB3d19hY3F1aXJlX2N0eCB0aWNrZXQ7Cj4gICAJc3RydWN0IGxpc3RfaGVh
ZCBsaXN0LCBkdXBsaWNhdGVzOwo+ICAgCXVpbnQ2NF90IHZhX2ZsYWdzOwo+ICsJdWludDY0X3Qg
dm1fc2l6ZTsKPiAgIAlpbnQgciA9IDA7Cj4gICAKPiAgIAlpZiAoYXJncy0+dmFfYWRkcmVzcyA8
IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFKSB7Cj4gQEAgLTYxNiw2ICs2MTcsMTUgQEAgaW50IGFt
ZGdwdV9nZW1fdmFfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwKPiAg
IAo+ICAgCWFyZ3MtPnZhX2FkZHJlc3MgJj0gQU1ER1BVX0dNQ19IT0xFX01BU0s7Cj4gICAKPiAr
CXZtX3NpemUgPSBhZGV2LT52bV9tYW5hZ2VyLm1heF9wZm4gKiBBTURHUFVfR1BVX1BBR0VfU0la
RTsKPiArCXZtX3NpemUgLT0gQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkU7Cj4gKwlpZiAoYXJncy0+
dmFfYWRkcmVzcyArIGFyZ3MtPm1hcF9zaXplID4gdm1fc2l6ZSkgewo+ICsJCWRldl9kYmcoJmRl
di0+cGRldi0+ZGV2LAo+ICsJCQkidmFfYWRkcmVzcyAweCVsbHggaXMgaW4gdG9wIHJlc2VydmVk
IGFyZWEgMHglbGx4XG4iLAo+ICsJCQlhcmdzLT52YV9hZGRyZXNzICsgYXJncy0+bWFwX3NpemUs
IHZtX3NpemUpOwo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsJfQo+ICsKPiAgIAlpZiAoKGFyZ3Mt
PmZsYWdzICYgfnZhbGlkX2ZsYWdzKSAmJiAoYXJncy0+ZmxhZ3MgJiB+cHJ0X2ZsYWdzKSkgewo+
ICAgCQlkZXZfZGJnKCZkZXYtPnBkZXYtPmRldiwgImludmFsaWQgZmxhZ3MgY29tYmluYXRpb24g
MHglMDhYXG4iLAo+ICAgCQkJYXJncy0+ZmxhZ3MpOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
