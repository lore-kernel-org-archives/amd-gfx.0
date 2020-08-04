Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50C0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 17:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557C5206C0
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 17:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tgq/BMJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557C5206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2E46E4AD;
	Tue,  4 Aug 2020 17:27:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42126E4AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 17:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvOObEolJJ6dIEmwqX0s9YuKvBfdflykCCV2Fki+qf/0i9vaQyLjP2Qt5fd4K5SN58hU6I8CB2D4YDC5Z84a81UDEJFqgZK8XTN671uH2iZPlP4ukJH6OhsriTsIc5S5F89+BHTaUCgtmREedBeUEfqfsdvXaBBGppqEiBgoVfmu/3UC2UH6DS37fSP1TZK3A8PI8ACC3N+qqBm2b84o6EzKSJVUzyB+AIBs+5oiZG38rVqWO4piq4IS5mWAiaJWoiyXZL38LNNeK0aWl7DyxnEk1mYFtVilFJfZ1f3rvnxSocqxRRN/tEvrGSWH2F0XZ9ykqo2mst6k1N+Pixivxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8wFUvzDp4m+v7gSQojSicU9RlM8uK9MqkYgv5lfcRE=;
 b=A6m/ORwJ3DmFI/0Jj9pm94XPbdtewdgrOw61jtNs6b+JXrf/U7/MrrTFffG8OYM7rS7An1Om93ca5HI1vNk9+RgYjW2QSDdDfzjodFbJKXQleskAulKtqrpKmOS/4Dep8HTRX1a3ZWGaYAAOS07JYcJqZCDqxHS+6SuUsiu2xk0BDJ+SusZLu2mH3zAo71C5CfZwPsvUiCymfFomRJQZuT7ZYeReGCuetRci18EMLki/ISw9xbdSehOooCsh1FiGSqdgftgyWmA0eyK6Os2eT1Uai5/fonHwqvwBTDTuxqrO3TVgoiOwWinaC+GQS2QV0a8Q6A2bWCDdrQh/uslvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8wFUvzDp4m+v7gSQojSicU9RlM8uK9MqkYgv5lfcRE=;
 b=tgq/BMJrGIN1tWPPj/QpTFGwt85xhADqUrSxqCO9++9EzzsE15ZX/yA2F/LDKZA8/7twq4isoZcf0l0TOCECIkFzRdbpId4gL1/nC5azD7jqrBf+RJKgOWyafnlufZBFsYVsGKAt80DjLDB4SnhdYd8ho1nV/so7ZgdWz3PaTck=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 17:27:43 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 17:27:43 +0000
Subject: Re: [PATCH] drm/amdkfd: option to disable system mem limit
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20200727132455.26657-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <406653af-5b66-6c77-1104-8fdf89be5c99@amd.com>
Date: Tue, 4 Aug 2020 13:27:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727132455.26657-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::30) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YQXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Tue, 4 Aug 2020 17:27:42 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f99b01d-4b1a-43f4-6c1f-08d8389bb1cb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43492CE7C57F87697C81B02E924A0@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaiNWmhx8Pvp5oedOLBQqTaVa3LRVuJ/WH94ZNHq0KBMNFPbljOnJO+qrSKmXOVsnE+Rix3WKySvaEYz9Gc8bn7/z7kFMFFHLZysYbUfVbkuwDzyj9AvN9CUC9kS9G3DmMtWTGIZFX7K9g5Sm1eZOhRKJZHweDqDVhkeyAnRw0Np4j6Emt+seY2QJtM0N5KE7ei7TloF8njJexJk/YpbKe28xLC50TrfypOEdTB+gHZ4p60+hUJtXFtusq8zum2OJD1v7gQMqHT0wdQcz2sAyIBVLa0uEncS0UMm2VWLRkudX3SaYgoizYK2ydR9JUCLZMqwTv37NKejJ1LVGo1EqGMszByF70JroJ8klCK/MEUCQ6+GyG81isO0j+OyhYxS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(86362001)(52116002)(16526019)(478600001)(956004)(26005)(2616005)(186003)(66946007)(83380400001)(2906002)(44832011)(31686004)(6486002)(316002)(6636002)(6862004)(36756003)(31696002)(16576012)(37006003)(8936002)(66556008)(66476007)(5660300002)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: x60Rg2jAH886xELz7sDa4irv2fck4bYM8mnEVF/D6rIIqGJ09Qiiq8YCiPfA+nKHQfGkDr1nDRP1ZtuQFpM/JsaokhN6+yvSb1Kw8uQgWmgH+QiGHThl44uEo9RJVpnAxiMvraPgGQ1WyjD7JkYOYFMsQUR+zczvz/uD2KNi8WYPwrPVVkjq5NkLfNfgRLJ+L7tCxB68mDbprLxz77CJADYxbJxT+bTOdFh+Ii7Xw84cbDdAHOY0yb5gwDHrCKD+55gW3k12sXRC59f/7qNvh1jwkjdG27cY8SlXgKe582EkjWyuZoMukcUblPgtmip+2Nb30ZJ7+KudPfHk17O7s3PDNBqZA6r7vegBm7vYD8sLKqeeShCA09WUH/mdZQcLpYr3+w6m7FmYmyo1LDCVyxHVdMnfWTFVX+oBb2uXSydlSa1lHCoHhiCvV1WgLOVpITswDgUpVCKU1IyILyqkr8BwRYFYxlQaLHOLyE6hkcw05G6C+1Gx/CfBOet8YBPXhcrjAhHqSS0358i6/pIV1WqB579LTnfXeXf1uw8BcqR3HZsBN8/eI4nJdhiQBPZ33Ps2zo6R3vLNiZiO2DkFsMcLVWaKmMOHAp9j22NsRQhzue0IboUXjeGLX3NZ47QT9/h8rIw+6RlKtQ3Ayb2Xnw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f99b01d-4b1a-43f4-6c1f-08d8389bb1cb
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 17:27:42.8529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KtZ+Q1TcU82c3ovLOrwdkLvZsiG4UibLhlr+y6Dm/TO9txMHASPQsqDt8gadVSh2xw2eyejUZeq5JDZDPvBIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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

QW0gMjAyMC0wNy0yNyB1bSA5OjI0IGEubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPiBJZiBtdWx0
aXBsZSBwcm9jZXNzIHNoYXJlIHN5c3RlbSBtZW1vcnkgdGhyb3VnaCAvZGV2L3NobSwgS0ZEIGFs
bG9jYXRlCj4gbWVtb3J5IHNob3VsZCBub3QgZmFpbCBpZiBpdCByZWFjaHMgdGhlIHN5c3RlbSBt
ZW1vcnkgbGltaXQgYmVjYXVzZQo+IG9uZSBjb3B5IG9mIHBoeXNpY2FsIHN5c3RlbSBtZW1vcnkg
YXJlIHNoYXJlZCBieSBtdWx0aXBsZSBwcm9jZXNzLgo+Cj4gQWRkIG1vZHVsZSBwYXJhbWV0ZXIg
dG8gcHJvdmlkZSB1c2VyIG9wdGlvbiB0byBkaXNhYmxlIHN5c3RlbSBtZW1vcnkKPiBsaW1pdCBj
aGVjaywgdG8gcnVuIG11bHRpcGxlIHByb2Nlc3Mgc2hhcmUgbWVtb3J5IGFwcGxpY2F0aW9uLiBC
eQo+IGRlZmF1bHQgdGhlIHN5c3RlbSBtZW1vcnkgbGltaXQgaXMgb24uCj4KPiBQcmludCBvdXQg
ZGVidWcgbWVzc2FnZSB0byB3YXJuIHVzZXIgaWYgS0ZEIGFsbG9jYXRlIG1lbW9yeSBmYWlsZWQK
PiBiZWNhdXNlIG9mIHN5c3RlbSBtZW1vcnkgbGltaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQaGls
aXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1LmggICAgICAgICAgICAgIHwgMiArKwo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMgfCA5ICsrKysrKysrLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgICAgICAgICAgfCA5ICsrKysrKysrKwo+
ICAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gaW5kZXggZTk3YzA4OGQwM2IzLi4zYzBkNWVj
ZmUwZDUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+IEBAIC0xODcsOSAr
MTg3LDExIEBAIGV4dGVybiBpbnQgYW1kZ3B1X2ZvcmNlX2FzaWNfdHlwZTsKPiAgI2lmZGVmIENP
TkZJR19IU0FfQU1ECj4gIGV4dGVybiBpbnQgc2NoZWRfcG9saWN5Owo+ICBleHRlcm4gYm9vbCBk
ZWJ1Z19ldmljdGlvbnM7Cj4gK2V4dGVybiBib29sIG5vX3N5c3RlbV9tZW1fbGltaXQ7Cj4gICNl
bHNlCj4gIHN0YXRpYyBjb25zdCBpbnQgc2NoZWRfcG9saWN5ID0gS0ZEX1NDSEVEX1BPTElDWV9I
V1M7Cj4gIHN0YXRpYyBjb25zdCBib29sIGRlYnVnX2V2aWN0aW9uczsgLyogPSBmYWxzZSAqLwo+
ICtzdGF0aWMgY29uc3QgYm9vbCBub19zeXN0ZW1fbWVtX2xpbWl0Owo+ICAjZW5kaWYKPiAgCj4g
IGV4dGVybiBpbnQgYW1kZ3B1X3RtejsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCj4gaW5kZXggODcwM2FhMWZlNGE1Li41MDJlODIwNGMw
MTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtm
ZF9ncHV2bS5jCj4gQEAgLTk5LDcgKzk5LDEwIEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9p
bml0X21lbV9saW1pdHModm9pZCkKPiAgCW1lbSAqPSBzaS5tZW1fdW5pdDsKPiAgCj4gIAlzcGlu
X2xvY2tfaW5pdCgma2ZkX21lbV9saW1pdC5tZW1fbGltaXRfbG9jayk7Cj4gLQlrZmRfbWVtX2xp
bWl0Lm1heF9zeXN0ZW1fbWVtX2xpbWl0ID0gbWVtIC0gKG1lbSA+PiA0KTsKPiArCWlmIChub19z
eXN0ZW1fbWVtX2xpbWl0KQo+ICsJCWtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQg
PSBVNjRfTUFYOwo+ICsJZWxzZQo+ICsJCWtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGlt
aXQgPSBtZW0gLSAobWVtID4+IDQpOwo+ICAJa2ZkX21lbV9saW1pdC5tYXhfdHRtX21lbV9saW1p
dCA9IChtZW0gPj4gMSkgLSAobWVtID4+IDMpOwo+ICAJcHJfZGVidWcoIktlcm5lbCBtZW1vcnkg
bGltaXQgJWxsdU0sIFRUTSBsaW1pdCAlbGx1TVxuIiwKPiAgCQkoa2ZkX21lbV9saW1pdC5tYXhf
c3lzdGVtX21lbV9saW1pdCA+PiAyMCksCj4gQEAgLTE0OCw2ICsxNTEsMTAgQEAgc3RhdGljIGlu
dCBhbWRncHVfYW1ka2ZkX3Jlc2VydmVfbWVtX2xpbWl0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAo+ICAKPiAgCXNwaW5fbG9jaygma2ZkX21lbV9saW1pdC5tZW1fbGltaXRfbG9jayk7Cj4g
IAo+ICsJaWYgKGtmZF9tZW1fbGltaXQuc3lzdGVtX21lbV91c2VkICsgc3lzdGVtX21lbV9uZWVk
ZWQgPgo+ICsJICAgIGtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQpCj4gKwkJcHJf
ZGVidWcoIlNldCBub19zeXN0ZW1fbWVtX2xpbWl0IGlmIHVzaW5nIHNoYXJlZCBtZW1vcnlcbiIp
Owo+ICsKPiAgCWlmICgoa2ZkX21lbV9saW1pdC5zeXN0ZW1fbWVtX3VzZWQgKyBzeXN0ZW1fbWVt
X25lZWRlZCA+Cj4gIAkgICAgIGtmZF9tZW1fbGltaXQubWF4X3N5c3RlbV9tZW1fbGltaXQpIHx8
Cj4gIAkgICAgKGtmZF9tZW1fbGltaXQudHRtX21lbV91c2VkICsgdHRtX21lbV9uZWVkZWQgPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBpbmRleCA2MjkxZjVmMGQy
MjMuLmU5YWNkMGE5ZjMyNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMKPiBAQCAtNzE1LDYgKzcxNSwxNSBAQCBNT0RVTEVfUEFSTV9ERVNDKHF1ZXVlX3ByZWVt
cHRpb25fdGltZW91dF9tcywgInF1ZXVlIHByZWVtcHRpb24gdGltZW91dCBpbiBtcyAoMQo+ICBi
b29sIGRlYnVnX2V2aWN0aW9uczsKPiAgbW9kdWxlX3BhcmFtKGRlYnVnX2V2aWN0aW9ucywgYm9v
bCwgMDY0NCk7Cj4gIE1PRFVMRV9QQVJNX0RFU0MoZGVidWdfZXZpY3Rpb25zLCAiZW5hYmxlIGV2
aWN0aW9uIGRlYnVnIG1lc3NhZ2VzIChmYWxzZSA9IGRlZmF1bHQpIik7Cj4gKwo+ICsvKioKPiAr
ICogRE9DOiBub19zeXN0ZW1fbWVtX2xpbWl0KGJvb2wpCj4gKyAqIERpc2FibGUgc3lzdGVtIG1l
bW9yeSBsaW1pdCwgdG8gc3VwcG9ydCBtdWx0aXBsZSBwcm9jZXNzIHNoYXJlZCBtZW1vcnkKPiAr
ICovCj4gK2Jvb2wgbm9fc3lzdGVtX21lbV9saW1pdDsKPiArbW9kdWxlX3BhcmFtKG5vX3N5c3Rl
bV9tZW1fbGltaXQsIGJvb2wsIDA2NDQpOwoKVGhlIHBlcm1pc3Npb25zIHN1Z2dlc3QgdGhhdCB0
aGlzIHBhcmFtZXRlciBpcyB3cml0YWJsZSBhdCBydW50aW1lIHVzaW5nCnN5c2ZzLiBIb3dldmVy
LCB0aGUgcGFyYW1ldGVyIGlzIG9ubHkgcmVhZCBvbmNlIGR1cmluZyBtb2R1bGUgaW5pdC4gU28K
YW55IHJ1bnRpbWUgY2hhbmdlcyB0byB0aGlzIHBhcmFtZXRlciB3aWxsIG5vdCB0YWtlIGVmZmVj
dC4KCllvdSBjYW4gZml4IHRoaXMgaW4gdHdvIHdheXM6CgogMS4gTWFrZSB0aGUgcGFyYW1ldGVy
IHJlYWQgb25seQogMi4gQ2hhbmdlIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBhbWRncHVfYW1ka2Zk
X3Jlc2VydmVfbWVtX2xpbWl0IHRvCiAgICBjaGVjayB0aGUgcGFyYW1ldGVyIGV2ZXJ5IHRpbWUg
YW5kIG9ubHkgYXBwbHkgdGhlIHN5c3RlbSBtZW1vcnkKICAgIGxpbWl0IGNoZWNrIGlmIG5lY2Vz
c2FyeQoKSSB0aGluayB0aGUgc2Vjb25kIG9wdGlvbiBpcyBwcmVmZXJhYmxlLCBiZWNhdXNlIGl0
IGFsbG93cyB1c2VyIHRvCmV4cGVyaW1lbnQgd2l0aCB0aGlzIHdpdGhvdXQgcmVib290aW5nLgoK
UmVnYXJkcywKwqAgRmVsaXgKCgo+ICtNT0RVTEVfUEFSTV9ERVNDKG5vX3N5c3RlbV9tZW1fbGlt
aXQsICJkaXNhYmxlIHN5c3RlbSBtZW1vcnkgbGltaXQgKGZhbHNlID0gZGVmYXVsdCkiKTsKPiAr
Cj4gICNlbmRpZgo+ICAKPiAgLyoqCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
