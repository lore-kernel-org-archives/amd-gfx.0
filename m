Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91602C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF16E247E1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RvaA8Hyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF16E247E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC3C6E051;
	Wed, 28 Oct 2020 16:10:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108446E051
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHAhPm0JU/HZSivQzbCaP/zT/us9Lw6i7RBfePph8NLwIi77CZexL9Q0FhTjIvaB+jUOMGnF50TYae/4sqgwUmMtfhB9VCkdKtpmjjudnYARkyW3GkW3rKqX9bXovk8wc8dTiritBy481NJT4wZ7/eZeXFBBHI1SM6AKS//VYQiM+3wYby8fjDoXPr4a53LAUCA24eCFyFG0WHSy1d2UQBNMxd4Vu6TnK0BvTXy9TiYrUYF+Z5LkZSZi0Pstq4/TwzX4zWy+2QVjQRoslBHLyZl+FtjAKdhL7NhxLLBvjeUgisNfP/UYHqGZFKuYIyNjOjFbn0375ftgRpnBJ0D6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e79DjfvNk6kVUkRkDLUGBWAdYCQUkay8laAOucprLiA=;
 b=g3BRgALK04nClgZRK0kkyolS3iiJDJHCrUZCw/tm9+XjPpZKZziIUrgDTmgMaqUIyXnMMLolquAokDARNO48DLxAy3jZfj+Dar3Mzdp0RkCK6oJr8DXNa1Z8qGcllkxvWgpmRvAB0nJnexGDBF09y8euMYQoof0j5q6P7dQ59/okvng9g0A/M/aB1V9pp7OWXpogerCL4leCVNDc+C6iWQgAx78Fo+jIHB+jlt7g0fAE0oqR3ZShRNR9ynITF8/Hs2ChQwrEvyY6+i2RZaiDm/D/O6GVjzKBJ/eSF0HjEBCAPmIZja2XIDNBH2cmnZ1xoBiwSDe/ARojTyuua03/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e79DjfvNk6kVUkRkDLUGBWAdYCQUkay8laAOucprLiA=;
 b=RvaA8HyfBcdsMf/MCF/d89RIgzwC0gekkqeNzPINI37ykPVjVPb3Xv+1//5UAftVWQZF+0sfAgVGGLhLk3iwaDKojWoJro9a1pOd04u/1SBx3LT2MUEuN0FuGKqrrEiJzEy6ZD/npRuZ4g1n6eAveFt0aOsORYcQ1IWoiXc14rI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 16:10:56 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::b07d:ede5:2f45:5de8%9]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:10:56 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201028152218.18485-1-kent.russell@amd.com>
 <20201028152218.18485-2-kent.russell@amd.com>
 <077bdbef-51f2-ac28-6392-84727a640525@amd.com>
 <DM6PR12MB3721E1DB3577D7B76A0ED52385170@DM6PR12MB3721.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c2d9fee1-5f4f-5cd5-79cf-a82e9f523b5a@amd.com>
Date: Wed, 28 Oct 2020 12:10:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB3721E1DB3577D7B76A0ED52385170@DM6PR12MB3721.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [142.116.113.11]
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 16:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bdf5fea-5629-41e8-0182-08d87b5c0d27
X-MS-TrafficTypeDiagnostic: BL0PR12MB4659:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB46592ECAF942F977598BC11B92170@BL0PR12MB4659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: da003zm8tRwg18+M7jGIiDC1Apn9r7anNvCcej2WJBHkNG3XkLFxujMbaWQF34NDnlOjm3aL2cq+zIVw7la/1oD1g/isNWgXYQybtbEdPpCeZpKw4dzkoiIFiB6ke+rB3RYL+j8FcWnhd6BfNUcnUsaBZhTgyWIitagwSBS4g9B1Y8wPI8TtZe0EkoT7bIQhe4qq8ED23rmsUzV9WGowNVBLf0cM8RbqitdC1HjBE1ytaZrDj0N7SYZzbjTp30he7EBp9bIrfxWxxBjK8uzlxV3H8n7EbYXcZ/Ia5cc1FPcal8ruBId4hcW5vUaM3mDGEgQITnA5YQaYbFGz2g4XpO/eyqqsNfiHp+jQf3nnar6o9z+OuA7DiAVHkfjI5T5Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(478600001)(36756003)(66476007)(66556008)(110136005)(44832011)(8936002)(66946007)(8676002)(31696002)(16526019)(186003)(86362001)(2616005)(956004)(83380400001)(26005)(4001150100001)(5660300002)(6486002)(316002)(31686004)(2906002)(53546011)(16576012)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2IVf7TfuHhxmxLdV0OnJc9bfBid2zleWdr/eHBc5kJEh8Lz0HKSFYHGA2kU0g/Lu/q3DwUuX6CJDeRViTqVZB3cld+4lvcMPSQ6cT64y4HwU6DTD7ZSF7G3pjksG4r6U2wy1K2F+bPY84FuM84FxML05YwkEv7AI285xSUzb0GxwyckIeGskPl0HNxMvau+wpZuXwg2YzpxFGNyAhukBFtGwQJT7UuqRGbj2VjT7jVaUHEuAcucTn5Vb0L2vuYOvLR3IfQa5F0f1I+7zZzR6qE73Hsx3fwdu/xxctmfRS9fwtpK/fCGCIRC+LIHY7m9/P+3nILK9HpCKbQZHMtvNZQzPot0FghVs468ZhXj8xHz8PG9GkwAzVm0Ox2zBXv3Sl8E366CB/lluylVvfqGyoEOCYMe9jeNRG5jANV+guQkRlMWok4/3DheZwNvHW1pGsjvkRM4znqUFxKUy/NdzevcoHVsoMlxasmT1xKe90E9hn39uUJAjf8giCBRjx46OVhw8yJALds/WP9a+0XSm4LiXYilZtQr3gXErPrNRMnMTNaW1/PYeB6I2qcGA6VP0XiIttH8WdpFVy+hNzNVORYiI5rYjcU8/45PEBszOfra9tsHe13Xdj13iodCeAaUbjZDZvKAS8tZ40UCNZJji5w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdf5fea-5629-41e8-0182-08d87b5c0d27
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 16:10:56.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k802SsqLkMX6bV73beYL65bFAplap8B/BmYMveEPWcYDrqOZXb8+ZAp+8M6vGUY9yezTRSiaZt9KBUj/fmQ13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4659
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

U28gcm9jbS1zbWkgcmVhZHMgdGhlIGRlY2ltYWwgYW5kIGNvbnZlcnRzIGl0IHRvIGhleD8gVGhl
biBjaGFuZ2luZyBLRkQKd2lsbCBicmVhayByb2NtLXNtaS4gSWYgeW91IHdhbnQgdG8gZml4IHJv
Y21pbmZvLCB5b3UnbGwgbmVlZCB0byBmaXggaXQKaW4gdGhlIHJvY21pbmZvIGNvZGUgdG8gZG8g
dGhlIGNvbnZlcnNpb24gdG8gaGV4LgoKUmVnYXJkcywKwqAgRmVsaXgKCkFtIDIwMjAtMTAtMjgg
dW0gMTI6MDIgcC5tLiBzY2hyaWViIFJ1c3NlbGwsIEtlbnQ6Cj4gW0FNRCBQdWJsaWMgVXNlXQo+
Cj4gcm9jbWluZm8gdXNlcyBpdCwgYnV0IHRoYXQncyBhbGwgdGhhdCBJIGFtIGF3YXJlIG9mLiBJ
IGNhbiBkcm9wIHRoaXMgdGhvdWdoIGFuZCBzdGljayB3aXRoIHBhdGNoMSwgSSBqdXN0IGRpZG4n
dCBrbm93IGlmIHdlJ2QgZW5kIHVwIGdldHRpbmcgY29tcGxhaW50cyBvZjoKPiAiV2VsbCwgcm9j
bS1zbWkgKGFtZGdwdSkgc2F5cyB0aGF0IHRoZSB1bmlxdWVfaWQgaXMgRiwgd2hpbGUgcm9jbWlu
Zm8gKGFtZGtmZCkgc2F5cyB0aGF0IHRoZSB1bmlxdWVfaWQgaXMgMTYiIC4gUHJvYmFibHkgdG9v
IGxhdGUgdG8gdHJ5IHRvIGNoYW5nZSBpdCBub3cgdGhvdWdoLCBhcyB5b3UgcG9pbnRlZCBvdXQu
Cj4KPiAgS2VudAo+Cj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEt1ZWhs
aW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4gU2VudDogV2VkbmVzZGF5LCBP
Y3RvYmVyIDI4LCAyMDIwIDExOjU1IEFNCj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+Cj4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8yXSBkcm0vYW1ka2ZkOiBDaGFuZ2UgdW5pcXVlX2lkIHRvIHByaW50IGhleCBm
b3JtYXQKPj4KPj4gVGhpcyBpcyBhbiBBQkktYnJlYWtpbmcgY2hhbmdlLiBJcyBhbnkgdXNlciBt
b2RlIGNvZGUgdXNpbmcgdGhpcyBhbHJlYWR5Pwo+Pgo+PiBSZWdhcmRzLAo+PiDCoCBGZWxpeAo+
Pgo+PiBBbSAyMDIwLTEwLTI4IHVtIDExOjIyIGEubS4gc2NocmllYiBLZW50IFJ1c3NlbGw6Cj4+
PiBhbWRncHUncyB1bmlxdWVfaWQgcHJpbnRzIGluIGhleCBmb3JtYXQsIHNvIGNoYW5nZSB0b3Bv
bG9neSdzIHByaW50b3V0Cj4+PiB0byBoZXggYnkgYWRkaW5nIGEgbmV3IHN5c2ZzX3ByaW50IG1h
Y3JvIHNwZWNpZmljYWxseSBmb3IgaGV4IG91dHB1dCwKPj4+IGFuZCB1c2UgaXQgZm9yIHVuaXF1
ZV9pZAo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFt
ZC5jb20+Cj4+PiAtLS0KPj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xv
Z3kuYyB8IDQgKysrLQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xv
Z3kuYwo+Pj4gaW5kZXggYTNmYzIzODczODE5Li5kMTNjNjhjNTJiYmMgMTAwNjQ0Cj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYwo+Pj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMKPj4+IEBAIC0yMTcsNiArMjE3
LDggQEAgc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2UgKmtmZF9jcmVhdGVfdG9wb2xvZ3lfZGV2
aWNlKAo+Pj4gIAkJc3lzZnNfc2hvd19nZW5fcHJvcChidWZmZXIsIG9mZnMsICIlcyAldVxuIiwg
bmFtZSwgdmFsdWUpCj4+PiAgI2RlZmluZSBzeXNmc19zaG93XzY0Yml0X3Byb3AoYnVmZmVyLCBv
ZmZzLCBuYW1lLCB2YWx1ZSkgXAo+Pj4gIAkJc3lzZnNfc2hvd19nZW5fcHJvcChidWZmZXIsIG9m
ZnMsICIlcyAlbGx1XG4iLCBuYW1lLCB2YWx1ZSkKPj4+ICsjZGVmaW5lIHN5c2ZzX3Nob3dfNjRi
aXRfcHJvcF9oZXgoYnVmZmVyLCBvZmZzLCBuYW1lLCB2YWx1ZSkgXAo+Pj4gKwkJc3lzZnNfc2hv
d19nZW5fcHJvcChidWZmZXIsIG9mZnMsICIlcyAlbGx4XG4iLCBuYW1lLCB2YWx1ZSkKPj4+ICAj
ZGVmaW5lIHN5c2ZzX3Nob3dfMzJiaXRfdmFsKGJ1ZmZlciwgb2ZmcywgdmFsdWUpIFwKPj4+ICAJ
CXN5c2ZzX3Nob3dfZ2VuX3Byb3AoYnVmZmVyLCBvZmZzLCAiJXVcbiIsIHZhbHVlKQo+Pj4gICNk
ZWZpbmUgc3lzZnNfc2hvd19zdHJfdmFsKGJ1ZmZlciwgb2ZmcywgdmFsdWUpIFwKPj4+IEBAIC00
OTcsNyArNDk5LDcgQEAgc3RhdGljIHNzaXplX3Qgbm9kZV9zaG93KHN0cnVjdCBrb2JqZWN0ICpr
b2JqLCBzdHJ1Y3QgYXR0cmlidXRlCj4+ICphdHRyLAo+Pj4gIAkJCSAgICAgIGRldi0+bm9kZV9w
cm9wcy5udW1fc2RtYV9xdWV1ZXNfcGVyX2VuZ2luZSk7Cj4+PiAgCXN5c2ZzX3Nob3dfMzJiaXRf
cHJvcChidWZmZXIsIG9mZnMsICJudW1fY3BfcXVldWVzIiwKPj4+ICAJCQkgICAgICBkZXYtPm5v
ZGVfcHJvcHMubnVtX2NwX3F1ZXVlcyk7Cj4+PiAtCXN5c2ZzX3Nob3dfNjRiaXRfcHJvcChidWZm
ZXIsIG9mZnMsICJ1bmlxdWVfaWQiLAo+Pj4gKwlzeXNmc19zaG93XzY0Yml0X3Byb3BfaGV4KGJ1
ZmZlciwgb2ZmcywgInVuaXF1ZV9pZCIsCj4+PiAgCQkJICAgICAgZGV2LT5ub2RlX3Byb3BzLnVu
aXF1ZV9pZCk7Cj4+Pgo+Pj4gIAlpZiAoZGV2LT5ncHUpIHsKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
