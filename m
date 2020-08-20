Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314DCC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 13:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A4C208DB
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0TZ9nUWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A4C208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DC7892BC;
	Thu, 20 Aug 2020 13:22:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE7D892BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 13:22:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv4+xweV5RGYHOAbNGeNl+PqusTosiSwenl+XllU2I81VevyBtMAKDg+jPhffYNMWksfcWud1XinCi+y6qE0iqYwfZykxq0xSRBpvv/yZQjJeXiL8TliUZj49HZ1xKrnelQxLyEkUax1B1uuC44N0MzJci3rtrL8ae+PankNSTqifZGv+hf5nOu9ZoU+lY26A/Pc7LpS9Z1YMK2jSNhnVLh6iqmB1wjKe6xZg7ATIGYTGyidPN25UwC05ocS3xtg5iBRsCbmUdd9YOVUbabRqR3vCox71FGlfiX1hjWJNgLpSIYKHyY3KoTXCNhFtnaTyDUGOG92T/GUJaIPjvFOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyWtFNkKwKZIenhOk3CeJv3KM6KBUtKa6vuQYo+m68Y=;
 b=VHxS3TD9t2yNnibNXeEK0CKzYaCoEFvr7bdpVGqIQw9XtDfXyMPOhXxiG+H82/mC/+8wplQ/Aube8pv9FePaA9szweARplW7QJ9DW/1g5mWRoSSkk5i2dUlo34uTkpISAmwewUb06+lPtCyw6U9e/CSbyUxAWVN6vfnotMyGwMiYFMSKJQ6YEVl1oVBCtB22bXMemFfYAD4BSxJ9d8N8DqOEc1TskCHB/xnuWm2Kpk9oZ4GMuqlLKAfA9Po+jHUfrIjACRhDGC7G8uzAFE6lHhlxasgWyZaKs4nhmO4dnhB1HyUjyyj64fOOn91ubmgvFGlBMtKIIhwEHFYMpwFySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyWtFNkKwKZIenhOk3CeJv3KM6KBUtKa6vuQYo+m68Y=;
 b=0TZ9nUWMmr3E61La2LAYeH8aNPC1WjwOk2pJCA8bA2NBbzEW3Kj6hh+w0rPVToNLKgF7l+tTqBBGJboE7FOumqu54J/6lBoKOcQHmS0BU3MWGZCG/3cTPOJQE6DH/ZcV85TX5J0H+t5YLAKiTcIbBJXVUrHaWrg2Blsn7XuDJRw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 13:22:11 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 13:22:11 +0000
Subject: Re: [PATCH v3 2/3] drm/amdkfd: force raven as "dgpu" path (v3)
To: Huang Rui <ray.huang@amd.com>
References: <20200819110647.212404-1-ray.huang@amd.com>
 <20200819110647.212404-2-ray.huang@amd.com>
 <68a090dd-e929-94b2-4de2-b42f337882f9@amd.com>
 <20200819235617.GB215900@hr-amd>
 <e31242f8-78df-9b7f-5e5a-b57c1722d5c3@amd.com>
 <20200820003125.GD215900@hr-amd> <20200820093854.GA298091@hr-amd>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <508ffc35-0bde-90f7-abb2-ea3502013cc4@amd.com>
Date: Thu, 20 Aug 2020 09:22:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200820093854.GA298091@hr-amd>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 13:22:10 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 986859c0-eef4-47ee-e3cc-08d8450c0b51
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB241612EBB6FAFA1DBD4FCF87925A0@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vR174im71G74tYVt/izul3hw88aV80fLxxWBVBK1Hrxx7GYAlpbcr2vENDX+KXcaScXcWO2++fNRzLw/YGmnyBTyMajUBsftnGpZyXvxv039aBbYdu6yf+KDm3BDclr5FgJH/1frio4QF9Ny/+ESHd01jAEoiXECVsfaGzBiw8knHcxSV+AT33qu3r257Trq8p7C4h5nWQ8aepYRz6vI/y4uVmsU93qNaJLT7JdoL3r78Um9TWSfaN3RBkmw3ZOTFFc6LN5bALkw6rOFI8AK0PRjXg7V6OZeXMn7bJ2rpLlhtkXTg5/TD67Pch+lGkFfH1PeedWy8SLn8sZJwZE1/c4eJ/fX1i7G/eTFX642gJ3uzcd/6K6PnSzzw5mp6ois44qJ4excojbxvD4W1e2oC1R729XOAFol3ywKft5hzDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(2616005)(956004)(44832011)(31686004)(6862004)(26005)(52116002)(6636002)(8676002)(4326008)(2906002)(110011004)(36756003)(6486002)(86362001)(37006003)(16576012)(478600001)(186003)(316002)(83380400001)(66946007)(66476007)(5660300002)(8936002)(53546011)(66556008)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DEn4n9F/hza6XHrt/vND3ppxmnlfbYbuJ4xTwiv+oMFnjuy+YvM8LopLllUKv8qJ0fXuxASW5WFYGq3MP8eBTNnuOyw3/RUe9XTzMQXmzIyAl7Xqw7XE/EUF6ktojhxJ+Fgbz/2AqYkVOYv/wKed0Btv4AGqBKWVfJBOAfPQ/hSQGAMRI0yZfOn24YHafH5bzMIzUWWrn2R6yNaTHjWgoKmIK7O8W7uJid7r4q3whPHBPkvNQ0hDS7I6qpzdiFHDHutx8leji/RGdbZYnMFTY6M9SFADe/YNlP7hiQE0nmUl3h0bPWgTTg63bR64aA+cNmHdu2IY0hl8YwpFnE3Fj7uzeBHwtPb9r6M82QrB42GZ99vZtvwuPdHxyDvIpIFecLwrR7vVKscfY4OsiuoAlsMJafcatk9x5wrtGnv6B9xuPzK6S5SpUOyNiY5v9IFyy0h0/fBC16uxHTDVlpRnr4vKOP8uHYGPluJSRJuJLEiA5NUPAc7WS+Bvyk35eeuZPh8JKVupn7guPJgiz6iL0PwfBfpwCVHFnEw2q7Y07E5tV8sfmgeTTSTbD34uQCseP/meMg/IPh2IL5U2bYjpZPGNDloeKR0nP3cfrQrnJnLf1agITkn5whuZ+heWfmIWr2pFy0PTMYejz2x6ebze/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986859c0-eef4-47ee-e3cc-08d8450c0b51
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 13:22:11.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4GeOWgo+sNOcRM04F7cfWduQQlHfMeQkyVkpgjdf7AFXMu170G7rUEUkHNGNUg0tOCEwfnAO+fzE1cmR6QtuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjAtMDgtMjAgdW0gNTozOCBhLm0uIHNjaHJpZWIgSHVhbmcgUnVpOgo+IE9uIFRodSwg
QXVnIDIwLCAyMDIwIGF0IDA4OjMxOjI1QU0gKzA4MDAsIEh1YW5nIFJ1aSB3cm90ZToKPj4gT24g
VGh1LCBBdWcgMjAsIDIwMjAgYXQgMDg6MTg6NTdBTSArMDgwMCwgS3VlaGxpbmcsIEZlbGl4IHdy
b3RlOgo+Pj4gT24gMjAyMC0wOC0xOSA3OjU2IHAubS4sIEh1YW5nIFJ1aSB3cm90ZToKPj4+PiBP
biBXZWQsIEF1ZyAxOSwgMjAyMCBhdCAxMTozODozNFBNICswODAwLCBLdWVobGluZywgRmVsaXgg
d3JvdGU6Cj4+Pj4+IEFtIDIwMjAtMDgtMTkgdW0gNzowNiBhLm0uIHNjaHJpZWIgSHVhbmcgUnVp
Ogo+Pj4+Pj4gV2Ugc3RpbGwgaGF2ZSBhIGZldyBpb21tdSBpc3N1ZXMgd2hpY2ggbmVlZCB0byBh
ZGRyZXNzLCBzbyBmb3JjZSByYXZlbgo+Pj4+Pj4gYXMgImRncHUiIHBhdGggZm9yIHRoZSBtb21l
bnQuCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBpcyB0byBhZGQgdGhlIGZhbGxiYWNrIHBhdGggdG8gYnlw
YXNzIElPTU1VIGlmIElPTU1VIHYyIGlzIGRpc2FibGVkCj4+Pj4+PiBvciBBQ1BJIENSQVQgdGFi
bGUgbm90IGNvcnJlY3QuCj4+Pj4+Pgo+Pj4+Pj4gdjI6IFVzZSBpZ25vcmVfY3JhdCBwYXJhbWV0
ZXIgdG8gZGVjaWRlIHdoZXRoZXIgaXQgd2lsbCBnbyB3aXRoIElPTU1VdjIuCj4+Pj4+PiB2Mzog
QWxpZ24gd2l0aCBleGlzdGVkIHRodW5rLCBkb24ndCBjaGFuZ2UgdGhlIHdheSBvZiByYXZlbiwg
b25seSByZW5vaXIKPj4+Pj4+ICAgICAgd2lsbCB1c2UgImRncHUiIHBhdGggYnkgZGVmYXVsdC4K
Pj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
Pgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYyAgIHwgIDUgKysrLQo+Pj4+Pj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y3JhdC5jICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKysrKystCj4+Pj4+PiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2UuYyAgIHwgIDIgKy0KPj4+Pj4+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICAgfCAgMiArLQo+Pj4+Pj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8ICAxICsKPj4+Pj4+ICAgNSBm
aWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pj4+Pj4KPj4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+Pj4+IGluZGV4IGE5
YTQzMTljMjRhZS4uMTg5ZjlkN2UxOTBkIDEwMDY0NAo+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPj4+Pj4+IEBAIC02ODQsMTEgKzY4NCwxNCBAQCBNT0RV
TEVfUEFSTV9ERVNDKGRlYnVnX2xhcmdlYmFyLAo+Pj4+Pj4gICAgKiBJZ25vcmUgQ1JBVCB0YWJs
ZSBkdXJpbmcgS0ZEIGluaXRpYWxpemF0aW9uLiBCeSBkZWZhdWx0LCBLRkQgdXNlcyB0aGUgQUNQ
SSBDUkFUCj4+Pj4+PiAgICAqIHRhYmxlIHRvIGdldCBpbmZvcm1hdGlvbiBhYm91dCBBTUQgQVBV
cy4gVGhpcyBvcHRpb24gY2FuIHNlcnZlIGFzIGEgd29ya2Fyb3VuZCBvbgo+Pj4+Pj4gICAgKiBz
eXN0ZW1zIHdpdGggYSBicm9rZW4gQ1JBVCB0YWJsZS4KPj4+Pj4+ICsgKgo+Pj4+Pj4gKyAqIERl
ZmF1bHQgaXMgYXV0byAoYWNjb3JkaW5nIHRvIGFzaWMgdHlwZSwgaW9tbXVfdjIsIGFuZCBjcmF0
IHRhYmxlLCB0byBkZWNpZGUKPj4+Pj4+ICsgKiB3aGVodGVyIHVzZSBDUkFUKQo+Pj4+Pj4gICAg
Ki8KPj4+Pj4+ICAgaW50IGlnbm9yZV9jcmF0Owo+Pj4+Pj4gICBtb2R1bGVfcGFyYW0oaWdub3Jl
X2NyYXQsIGludCwgMDQ0NCk7Cj4+Pj4+PiAgIE1PRFVMRV9QQVJNX0RFU0MoaWdub3JlX2NyYXQs
Cj4+Pj4+PiAtCSJJZ25vcmUgQ1JBVCB0YWJsZSBkdXJpbmcgS0ZEIGluaXRpYWxpemF0aW9uICgw
ID0gdXNlIENSQVQgKGRlZmF1bHQpLCAxID0gaWdub3JlIENSQVQpIik7Cj4+Pj4+PiArCSJJZ25v
cmUgQ1JBVCB0YWJsZSBkdXJpbmcgS0ZEIGluaXRpYWxpemF0aW9uICgwID0gYXV0byAoZGVmYXVs
dCksIDEgPSBpZ25vcmUgQ1JBVCkiKTsKPj4+Pj4+ICAgCj4+Pj4+PiAgIC8qKgo+Pj4+Pj4gICAg
KiBET0M6IGhhbHRfaWZfaHdzX2hhbmcgKGludCkKPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX2NyYXQuYwo+Pj4+Pj4gaW5kZXggNTk1NTdlM2UyMDZhLi5mODM0NmQ0NDAyZTIgMTAw
NjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4+
Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4+Pj4+PiBA
QCAtMjIsNiArMjIsNyBAQAo+Pj4+Pj4gICAKPj4+Pj4+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS5o
Pgo+Pj4+Pj4gICAjaW5jbHVkZSA8bGludXgvYWNwaS5oPgo+Pj4+Pj4gKyNpbmNsdWRlIDxhc20v
cHJvY2Vzc29yLmg+Cj4+Pj4+PiAgICNpbmNsdWRlICJrZmRfY3JhdC5oIgo+Pj4+Pj4gICAjaW5j
bHVkZSAia2ZkX3ByaXYuaCIKPj4+Pj4+ICAgI2luY2x1ZGUgImtmZF90b3BvbG9neS5oIgo+Pj4+
Pj4gQEAgLTc0MCw2ICs3NDEsMzAgQEAgc3RhdGljIGludCBrZmRfZmlsbF9ncHVfY2FjaGVfaW5m
byhzdHJ1Y3Qga2ZkX2RldiAqa2RldiwKPj4+Pj4+ICAgCXJldHVybiAwOwo+Pj4+Pj4gICB9Cj4+
Pj4+PiAgIAo+Pj4+Pj4gKwo+Pj4+Pj4gKyNpZmRlZiBDT05GSUdfQUNQSQo+Pj4+Pj4gK3N0YXRp
YyB2b2lkIGtmZF9zZXR1cF9pZ25vcmVfY3JhdF9vcHRpb24odm9pZCkKPj4+Pj4+ICt7Cj4+Pj4+
PiArCj4+Pj4+PiArCWlmIChpZ25vcmVfY3JhdCkKPj4+Pj4+ICsJCXJldHVybjsKPj4+Pj4+ICsK
Pj4+Pj4+ICsjaWZuZGVmIEtGRF9TVVBQT1JUX0lPTU1VX1YyCj4+Pj4+PiArCWlnbm9yZV9jcmF0
ID0gMTsKPj4+Pj4+ICsjZWxzZQo+Pj4+Pj4gKwlpZ25vcmVfY3JhdCA9IDA7Cj4+Pj4+PiArI2Vu
ZGlmCj4+Pj4+PiArCj4+Pj4+PiArCS8qIFJlbm9pciB1c2UgdGhlIGZhbGxiYWNrIHBhdGggdG8g
YWxpZ24gd2l0aCBleGlzdGVkIHRodW5rICovCj4+Pj4+IEFyZSB5b3Ugc3VyZSB5b3UgbmVlZCBz
cGVjaWFsIGNvZGUgZm9yIFJlbm9pciBoZXJlPyBGb3IgUmVub2lyIHRoZQo+Pj4+PiBkZXYtPmRl
dmljZV9pbmZvIGFscmVhZHkgdHJlYXRzIGl0IGFzIGEgZEdQVSBhbmQgYWx3YXlzIGhhcy4KPj4+
PiBSZW5vaXIgYWxzbyBpcyBhbiBBUFUsIGluIG90aGVyIHdvcmRzLCB3ZSBtaWdodCBoYXZlIGdv
dCB0aGUgY29ycmVjdCBDUkFUCj4+Pj4gdGFibGUgZnJvbSBTQklPUyAodGhlIENSQVQgdGFibGUg
aW4gU0JJT1MgZm9yIHJlbm9pciBpcyBicm9rZW4gc28gZmFyKS4gSWYKPj4+PiB3ZSBoYWQgZ290
IENSQVQgdGFibGUsIHRoZSBrZmQgd291bGQgY3JlYXRlIGFuIEFQVSBub2RlLiBUaGF0J3Mgbm90
Cj4+Pj4gZXhwZWN0ZWQuCj4+PiBrZmRfYXNzaWduX2dwdSB3aWxsIG5vdCBhc3NpZ24gYSBSZW5v
aXIgR1BVIGFzIHRoZSBBUFUgZnJvbSB0aGUgQ1JBVCAKPj4+IHRhYmxlIGJlY2F1c2UgZ3B1LT5k
ZXZpY2VfaW5mby0+bmVlZHNfaW9tbXVfZGV2aWNlIGlzIEZhbHNlIGZvciBSZW5vaXIuIAo+Pj4g
U28gUmVub2lyIHdpbGwgYWx3YXlzIHNob3cgdXAgaW4gdGhlIHRvcG9sb2d5IGFzIGl0cyBvd24g
ZGlzY3JldGUgR1BVIG5vZGUuCj4+Pgo+Pj4gSG93IGRvZXMgdGhpcyB3b3JrIHRvZGF5PyBSZW5v
aXIgaXMgYWxyZWFkeSB0cmVhdGVkIGFzIGEgZEdQVS4gQnV0IHRoZSAKPj4+IENQVSBub2RlIGlu
Zm8gKC9zeXMvY2xhc3Mva2ZkL2tmZC90b3BvbG9neS9ub2Rlcy8wL3Byb3BlcnRpZXMpIGZyb20g
dGhlIAo+Pj4gQ1JBVCB0YWJsZSBzdGlsbCBzaG93cyBHUFUgY29yZXM/Cj4+Pgo+PiBZZXMsIFJl
bm9pciB3b3JrcyB3ZWxsLiBJbiBmYWN0LCBJIGZvdW5kIHRoZSBwcm9ibGVtIHdoaWxlIEkgd2Fz
IGVuYWJsaW5nCj4+IHRoZSBkR1BVIHBhdGggZm9yIHJhdmVuIGJlZm9yZS4gRXZlbiBJIHNldCBu
ZWVkc19pb21tdV9kZXZpY2UgYXMgZmFsc2UgaW4KPj4gcmF2ZW4ncyBkZXZpY2UgaW5mby4gVGhl
IGtmZCBzdGlsbCBjcmVhdGVzIHRoZSBBUFUgbm9kZS4gKGluIHYxIHBhdGNoKQo+Pgo+PiBMZXQg
bWUgcm9sbGJhY2sgdG8gY2hlY2sgaXQgYWdhaW4uCj4+Cj4gSGkgRmVsaXgsCj4KPiBJIGRvdWJs
ZSBjaGVjayBpdCBhZ2Fpbi4gSWYgUmVub2lyJ3MgQUNQSSBDUkFUIHdlcmUgZ29vZCwgd2Ugd291
bGRuJ3QKPiBjcmVhdGUgdmlydHVhbCBDUkFUIHRhYmxlIGZvciBSZW5vaXIgYXQgdGhpcyBtb2Vt
ZW50LiBUaGVuIHRoZSBwdXJlIENQVQo+IG5vZGUgaXMgdW5hYmxlIHRvIGJlIGNyZWF0ZWQuIFRo
YXQgY29uZmxpY3RlZCB3aXRoIG5lZWRzX2lvbW11X2RldmljZSBmbGFnCj4gKHdlIGhhcmRjb2Rl
IG5lZWRzX2lvbW11X2RldmljZSBhcyBmYWxzZSBmb3IgcmVub2lyKS4gVGhlbiB3aWxsIGJyZWFr
IHRoZQo+IHVzZXIgbW9kZSBkcml2ZXIuIChwbGVhc2Ugc2VlIGJlbG93IHJvY21pbmZvKQo+Cj4g
cm9jbWluZm86IC9saWJoc2FrbXQvc3JjL3RvcG9sb2d5LmM6MTA3OTogdG9wb2xvZ3lfc3lzZnNf
Z2V0X25vZGVfcHJvcHM6IEFzc2VydGlvbiBgcHJvcHMtPkVuZ2luZUlkLnVpMzIuTWFqb3InIGZh
aWxlZC4KPgo+IFNvIHdlIHByb2JhYmx5IHdvdWxkIGJldHRlciBoYXZlIGEgc3BlY2lmaWMgaGFu
ZGxpbmcgdG8gbWFrZSBzdXJlIFJlbm9pcgo+IHdpdGggdmlydHVhbCBDUkFULgoKT0suIFRoYXQg
d291bGQgYmUgYSBzb2x1dGlvbiB0aGF0IHdvcmtzIGZvciBSZW5vaXIgb25seS4KCkknZCBzdWdn
ZXN0IHRyeWluZyBhIG1vcmUgZ2VuZXJhbCBzb2x1dGlvbiBpbiBub2RlX3Nob3cgaW4Ka2ZkX3Rv
cG9sb2d5LmMuIElmIHdlIHNlZSBhbiBBUFUgbm9kZSAodGhhdCBoYXMgQ1BVIGFuZCBHUFUgY29y
ZXMpIHdpdGgKbm8gYXNzb2NpYXRlZCBHUFUgKGRldi0+Z3B1X2lkIGlzIDAgb3IgZGV2LT5ncHUg
aXMgTlVMTCksIHdlIGNhbiByZXBvcnQKaXQgYXMgYSBwdXJlIENQVSBub2RlIHRvIHVzZXIgbW9k
ZSBieSBqdXN0IHJlcG9ydGluZyB0aGUgc2ltZF9jb3VudCBhcyAwLgoKUmVnYXJkcywKwqAgRmVs
aXgKCgo+Cj4gVGhhbmtzLAo+IFJheQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
