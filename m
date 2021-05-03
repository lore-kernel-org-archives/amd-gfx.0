Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB25EC433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 13:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A6C61208
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 13:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A6C61208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7FD96E8BB;
	Mon,  3 May 2021 13:52:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81616E8C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 13:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUiAlvWWJxTPeZXjQ6jZ8/sXxL2aF+U1mnZ7rf/c54Wn53CY+HMBOU6x81DTXY7ukW43OrgLMc3ljbMDNIPRBdjqp2z6gdksgibjAOBfYJKJgKHUyJEedippL/f0nDeRZQt4fHg1dVkDsRXfZYrFdxyp3krM7ieaqby5QzUeEo4nyCw8Spr1NDHuxFqIzQUhPXwb/8rr4DLafsKrvlydmU4Iw4lzoOMdGsqiq+8avTEeSnQacaRRJUmDnqtotOak4JeYbdQ6JF8FEXGT9Tdn2sxcg8RJsGit3VNMKNqRSjMCwbIehUOACsePuVliptXj+1sgJhcLJl7eOlMIeaNIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpZF4ErGMxtZbATQLqy7OJQFKnjTdwsVo17tac4wr8c=;
 b=Tj5oDaQpYH24rr6f8asa2pLMAjTYTO3rSno97kQ3TupB6vtNm33ch6JiGTzw1FxfFhm35QQOUUuffV2ax36PJoQtycxPgQnDxnOBvJvi8C0SNSStFSxmEcQ9j8Tx0WFQ2q7PfzjAX+Fm2JiVD7hNPu4tLUpT5F34a/R8FjWoOBV+ebdUCLbVclwlk1nSiKedv0uW0hlvHVPr0S8GQkJyvRXsqzUVB4kbfHHLGfeJVskmR8YjTvBTMnlU9+U4X1yWJzjR4VKn+jXqi3A/Th+1NZX5i9YOBqVMLJxoSDASt9uPdJg3AeV3HU7Ap9r8PoItCsTC8Z3yDq4P49mPB84rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpZF4ErGMxtZbATQLqy7OJQFKnjTdwsVo17tac4wr8c=;
 b=HKIY8zlr1dvIogeNZdOjkWwelcCWYjg1g3to08+gnXTSp0BtKbES7Jpsx9yzmEtwzs14RiIyF6hZfcLo7n/ob+6EcuLWPtwJ4K85Owbog0+rDD4ThVuOhOzgHQ8S85nGFn+f7EcNXQ0hQc6ijcTyR6BYz6tSoWv3K0jKhr164dU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 13:52:24 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4087.041; Mon, 3 May 2021
 13:52:24 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210428151154.28317-1-jinhuieric.huang@amd.com>
 <cd262559-2395-1bb9-81a1-a42e4dd20b8b@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <34d61620-6489-8eb9-0561-76f26df0956e@amd.com>
Date: Mon, 3 May 2021 09:52:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <cd262559-2395-1bb9-81a1-a42e4dd20b8b@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::20) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:150d:2265:cbad:a5fb]
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38 via Frontend
 Transport; Mon, 3 May 2021 13:52:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca68c42b-9b38-4c08-0358-08d90e3aadc6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4140B7CC38CF94A69CB831C7825B9@DM6PR12MB4140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MXWjRsSA6Xwn11H4MFfxbEsPpHaNwi+ytGin4BHCsynWKPaa1RBfqHCYWZtDRqwDNATKN3CwrTKrPBBCVWnmm8T5/1XGwD6Wh82SfpG2oPc13KBq4jMMYzq3QvwYqA09VIwXEyGoTLxT4uvixSuR5uka2u12buVrOv3Bt++j4ozc3ea/Qh62HNzyBSj67FSRn/jpNNZX0vskn/E1qIOvWF7nKUnCd8TU/TC4rPwG87Dn7U7vbcqd8PAQSIhLCyXwbkVHDfdtvWY1JNfXOYFSa7yM3uHDf6dW2Ct7K3sDD7aGnEteNhliiBnHDqEV24jgoThIRJPWqYKaYpS+J5yXv6w/nRjUy6SRp1O56pCgsPxr465HFvZJXHLd+45VHAopFbSu8DHntuwKVaCGGq/f8Qi8Eor4iAo8FijvfNM7nJYENOxRp35mdCttqWt5OaSVYxo9miv6EP3Yk8BidlFeESU+vIOOBg2e4swn7qJv/FOkaG18y1Zf1Rzts1894ExOOzIQtAAVqakTSQ4ZGgIHYH2FujRRo4zIxp4pSQihHDYF/RP2nU7wX+36ave4+2GkEJa+fwPom/iL/5Nwjtg7D12GRPCNGSOAJ4yv1WiCAzo/sE8Xs+JD+N1w2stk3fth9Fvx7OydlQeHyw72kQ6DHIEffEPiKY0cf6P5aD2MqQ4Oi35XkL6+D/fHaSQheaX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(5660300002)(2906002)(38100700002)(8936002)(478600001)(83380400001)(316002)(8676002)(66556008)(186003)(16526019)(66476007)(2616005)(53546011)(86362001)(31696002)(66946007)(6486002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WDlGZVJCWWRWRnEreU80TmJJamFNZERZcmN0ZnlnMFBCbHFvcTRvdEN0Nkxo?=
 =?utf-8?B?ODBLY0hNeklldmNCWU9yYmx0RUNpZjJhVkJxeVMwd1A1cVp6ZEEwYWdwLzlT?=
 =?utf-8?B?N29MMHR1ZVpaQVQyRXdQUUxzaDRML2dWZlMwby9vVUsxdm5Vd3F6VzZQcTd0?=
 =?utf-8?B?S25hcklXcklYRXhweml1YnpHQW9RSDdHUDRpVGMwRzZGb2ZUVDhjNkpqSldX?=
 =?utf-8?B?bmR1eXNjR1N1NnhhYTJSYnc4WVQvSGczaFN6TzRVdk9EQ2xhTzdXcSs0VFVu?=
 =?utf-8?B?Y1ljRGxRZUhJNUhiYlpMM3RsaXZFbWhqRE5NV1lQUlFOZjNrZ0d4QVI4SUFm?=
 =?utf-8?B?U0dnZGZNTEljRFlWcTk4TDc4a2o1QTA2RGVmenJmR2E3aHFlS0xHWVZXZVhL?=
 =?utf-8?B?UjdDY2hzSVNPeWRxNEMyRVQwMnJ2RzIvZ2xpS1luWk11ZDdYZHpCbkFUTUFY?=
 =?utf-8?B?R0pHS1FCRzZZMDJuKzlzQWF0Qk94QWwva1E5UVlUeXhvYXNhdWg4THRKeEdW?=
 =?utf-8?B?M3pLdjRKM0dhb0kwbmg1MUduanRBUXNCOHkwQkhQL3BndDBYU08zcm5FMGpj?=
 =?utf-8?B?a1UyTWlSQ2x4ZUNLS3F4ZE5qNXdPYTBUaEtwcDQvWE1zdzBSY3hqTW1qVEJp?=
 =?utf-8?B?V0xSUk9URVdZeWZjVnYyN0tNMXoyTTljdkphQTlSZmp5Mko5ZWVVdHdVbmZX?=
 =?utf-8?B?VWtyNXpmZXZjcmliTjFOT1VaSk15U1FqNTlQTFFnSXY2WmtnaHRxQS85dDJK?=
 =?utf-8?B?VjhrL2pERUszTnhXMnFZZ0lJbUFlNS8wdUhjNVZBcTdwdzQzS1RKM2I5OTVy?=
 =?utf-8?B?dXJFbXFqUFNwZ25Zcjd0ck5CUmZSNnBSL0J4NCs2MXRpbWVzcHF2Ny9PRjc4?=
 =?utf-8?B?Zk1PK2NwaWpQcnZ3QzdQVnhSeVYvSUFWR2NENXI0N3RzeTdiSC8vNHF5VlN0?=
 =?utf-8?B?Tll5Q1h0RW5kMUxYYk9ZUHYyR3VqeVFsbDhwSm1lalQ3ak10ZkM5VHFHdDVs?=
 =?utf-8?B?ZnZkMGRsYW5XYVgxZ0pqbnl4cUZLRThRbkhBejlibjRwdjIyZUV6ZWtEZm9t?=
 =?utf-8?B?dWVkSjZFRmpPQWgwdXRDQUtzMi9NblpXNEJFUkZUR1FzMXc5NlQrMEp1dm04?=
 =?utf-8?B?SEtZTFB6eHpjYnFzMytOYmx0Ylp4QkNOTmZUUnU1bmt6d0dBTXBWQkUwSk9Y?=
 =?utf-8?B?eCsxKzFQNi9nTjNicFVxbHJoZk9KS1VETlNVWUMrQlN1RHdCRzlnWEZBcERH?=
 =?utf-8?B?YW93Z2o2Y2NnZkFHRTZIeWp1aXpDNVNGVGZzaDZUR09vcDhLSWVSemwwMHBY?=
 =?utf-8?B?Rmt5bkhseUZHb2o4N040VGFEUVFLeHRFTVFjMWwrZjk5S3ZsNkxSQVE5ZlY5?=
 =?utf-8?B?b3RyMVBTV3VQcStkck0wQ0haUTdObEE2N21wb2ZTdC9IcE9uNUUrcTNZRm9R?=
 =?utf-8?B?YzgwQTNnM2U1NUJMMUx5d3ArRWpHNFlva1pQcFRIQXlsR1ZOTlc0czFnejJE?=
 =?utf-8?B?K0FsbTl2dWdzbWJvU0h5cEFRd1NhK2FYT281amVCa0RaV3kyU3U5NXgxb2ZL?=
 =?utf-8?B?MDlpMEJVT3JTcjJNcFZrU1ZRRVdJTFhCbTgwVnBnYmZaMmtXcXJIYjhwd3la?=
 =?utf-8?B?Y1haemdnNmo1VCtJdHJFTVlyeFRMdXpvdks1OGJmQmZIV1ZIMER6NmtaSWp3?=
 =?utf-8?B?VTVCell1TENRYmFVZGtYcGFuaDFIL2p4bGErWTJObS9WUloxVWxBTW5QdHJC?=
 =?utf-8?B?NVowL2JBTlVPazVBN3dZWlMrR0dwWDFqdW4yS0lhdVJWUXdhZlJjc0FKS0RE?=
 =?utf-8?B?RVQxZjJULzhvaGNmbGNSMXpXdmpuS1VtYUovNnEvREc0dnU0KzdCU013enZq?=
 =?utf-8?Q?RQTBP9uAocjMZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca68c42b-9b38-4c08-0358-08d90e3aadc6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 13:52:23.8971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbOACS2NRwAwH8h6DUNBN+r98qiE/dYukIg/6KXL1E51F6SZpUHjd6dw11dAVfs9/qy7yZSVGoq879LF7Naokw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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

VGhhbmtzIEZlbGl4IGZvciB5b3VyIHJldmlldy4gSSB3aWxsIHNlbmQgYW5vdGhlciBwYXRjaC4K
CkVyaWMKCk9uIDIwMjEtMDQtMzAgNzo0MiBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBB
bSAyMDIxLTA0LTI4IHVtIDExOjExIGEubS4gc2NocmllYiBFcmljIEh1YW5nOgo+PiBJbiBOUFM0
IEJJT1Mgd2UgbmVlZCB0byBmaW5kIHRoZSBjbG9zZXN0IG51bWEgbm9kZSB3aGVuIGNyZWF0aW5n
Cj4+IHRvcG9sb2d5IGlvIGxpbmsgYmV0d2VlbiBjcHUgYW5kIGdwdSwgaWYgUENJIGRyaXZlciBk
b2Vzbid0IHNldAo+PiBpdC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8amluaHVp
ZXJpYy5odWFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY3JhdC5jIHwgOTQgKysrKysrKysrKysrKysrKysrKysrKysrKystCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDkxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+PiBpbmRleCAzOGQ0NTcxMTY3NWYuLjU3NTE4MTM2
YzdkNyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQu
Ywo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4+IEBAIC0x
NzU5LDYgKzE3NTksODcgQEAgc3RhdGljIGludCBrZmRfZmlsbF9ncHVfbWVtb3J5X2FmZmluaXR5
KGludCAqYXZhaWxfc2l6ZSwKPj4gICAJcmV0dXJuIDA7Cj4+ICAgfQo+PiAgIAo+PiArI2lmZGVm
IENPTkZJR19BQ1BJCj4+ICtzdGF0aWMgdm9pZCBrZmRfZmluZF9udW1hX25vZGVfaW5fc3JhdChz
dHJ1Y3Qga2ZkX2RldiAqa2RldiwKPj4gKwkJaW50ICpudW1hX25vZGUpCj4+ICt7Cj4+ICsJc3Ry
dWN0IGFjcGlfdGFibGVfaGVhZGVyICp0YWJsZV9oZWFkZXIgPSBOVUxMOwo+PiArCXN0cnVjdCBh
Y3BpX3N1YnRhYmxlX2hlYWRlciAqc3ViX2hlYWRlciA9IE5VTEw7Cj4+ICsJdW5zaWduZWQgbG9u
ZyB0YWJsZV9lbmQsIHN1YnRhYmxlX2xlbjsKPj4gKwl1MzIgcGNpX2lkID0gcGNpX2RvbWFpbl9u
cihrZGV2LT5wZGV2LT5idXMpIDw8IDE2IHwKPj4gKwkJCXBjaV9kZXZfaWQoa2Rldi0+cGRldik7
Cj4+ICsJdTMyIGJkZjsKPj4gKwlhY3BpX3N0YXR1cyBzdGF0dXM7Cj4+ICsJc3RydWN0IGFjcGlf
c3JhdF9jcHVfYWZmaW5pdHkgKmNwdTsKPj4gKwlzdHJ1Y3QgYWNwaV9zcmF0X2dlbmVyaWNfYWZm
aW5pdHkgKmdwdTsKPj4gKwlpbnQgcHhtID0gMCwgbWF4X3B4bSA9IDA7Cj4+ICsJYm9vbCBmb3Vu
ZCA9IGZhbHNlOwo+PiArCj4+ICsJLyogRmV0Y2ggdGhlIFNSQVQgdGFibGUgZnJvbSBBQ1BJICov
Cj4+ICsJc3RhdHVzID0gYWNwaV9nZXRfdGFibGUoQUNQSV9TSUdfU1JBVCwgMCwgJnRhYmxlX2hl
YWRlcik7Cj4+ICsJaWYgKHN0YXR1cyA9PSBBRV9OT1RfRk9VTkQpIHsKPj4gKwkJcHJfd2Fybigi
U1JBVCB0YWJsZSBub3QgZm91bmRcbiIpOwo+PiArCQlyZXR1cm47Cj4+ICsJfSBlbHNlIGlmIChB
Q1BJX0ZBSUxVUkUoc3RhdHVzKSkgewo+PiArCQljb25zdCBjaGFyICplcnIgPSBhY3BpX2Zvcm1h
dF9leGNlcHRpb24oc3RhdHVzKTsKPj4gKwkJcHJfZXJyKCJTUkFUIHRhYmxlIGVycm9yOiAlc1xu
IiwgZXJyKTsKPj4gKwkJcmV0dXJuOwo+PiArCX0KPiBBZnRlciBhIHN1Y2Nlc3NmdWwgY2FsbCB0
byBhY3BpX2dldF90YWJsZSB5b3UgbmVlZCB0byBjYWxsCj4gYWNwaV9wdXRfdGFibGUgYmVmb3Jl
IHRoaXMgZnVuY3Rpb24gcmV0dXJucyB0byBhdm9pZCBsZWFraW5nIG1lbW9yeS4KPgo+Cj4+ICsK
Pj4gKwl0YWJsZV9lbmQgPSAodW5zaWduZWQgbG9uZyl0YWJsZV9oZWFkZXIgKyB0YWJsZV9oZWFk
ZXItPmxlbmd0aDsKPj4gKwo+PiArCS8qIFBhcnNlIGFsbCBlbnRyaWVzIGxvb2tpbmcgZm9yIGEg
bWF0Y2guICovCj4+ICsKPj4gKwlzdWJfaGVhZGVyID0gKHN0cnVjdCBhY3BpX3N1YnRhYmxlX2hl
YWRlciAqKQo+PiArCQkJKCh1bnNpZ25lZCBsb25nKXRhYmxlX2hlYWRlciArCj4+ICsJCQlzaXpl
b2Yoc3RydWN0IGFjcGlfdGFibGVfc3JhdCkpOwo+PiArCXN1YnRhYmxlX2xlbiA9IHN1Yl9oZWFk
ZXItPmxlbmd0aDsKPj4gKwo+PiArCXdoaWxlICgoKHVuc2lnbmVkIGxvbmcpc3ViX2hlYWRlcikg
KyBzdWJ0YWJsZV9sZW4gIDwgdGFibGVfZW5kKSB7Cj4+ICsJCS8qCj4+ICsJCSAqIElmIGxlbmd0
aCBpcyAwLCBicmVhayBmcm9tIHRoaXMgbG9vcCB0byBhdm9pZAo+PiArCQkgKiBpbmZpbml0ZSBs
b29wLgo+PiArCQkgKi8KPj4gKwkJaWYgKHN1YnRhYmxlX2xlbiA9PSAwKSB7Cj4+ICsJCQlwcl9l
cnIoIlNSQVQgaW52YWxpZCB6ZXJvIGxlbmd0aFxuIik7Cj4+ICsJCQlicmVhazsKPj4gKwkJfQo+
PiArCj4+ICsJCXN3aXRjaCAoc3ViX2hlYWRlci0+dHlwZSkgewo+PiArCQljYXNlIEFDUElfU1JB
VF9UWVBFX0NQVV9BRkZJTklUWToKPj4gKwkJCWNwdSA9IChzdHJ1Y3QgYWNwaV9zcmF0X2NwdV9h
ZmZpbml0eSAqKXN1Yl9oZWFkZXI7Cj4+ICsJCQlweG0gPSAqKCh1MzIgKiljcHUtPnByb3hpbWl0
eV9kb21haW5faGkpIDw8IDggfAo+PiArCQkJCQljcHUtPnByb3hpbWl0eV9kb21haW5fbG87Cj4+
ICsJCQlpZiAocHhtID4gbWF4X3B4bSkKPj4gKwkJCQltYXhfcHhtID0gcHhtOwo+PiArCQkJYnJl
YWs7Cj4+ICsJCWNhc2UgQUNQSV9TUkFUX1RZUEVfR0VORVJJQ19BRkZJTklUWToKPj4gKwkJCWdw
dSA9IChzdHJ1Y3QgYWNwaV9zcmF0X2dlbmVyaWNfYWZmaW5pdHkgKilzdWJfaGVhZGVyOwo+PiAr
CQkJYmRmID0gKigodTE2ICopKCZncHUtPmRldmljZV9oYW5kbGVbMF0pKSA8PCAxNiB8Cj4+ICsJ
CQkJCSooKHUxNiAqKSgmZ3B1LT5kZXZpY2VfaGFuZGxlWzJdKSk7Cj4+ICsJCQlpZiAoYmRmID09
IHBjaV9pZCkgewo+PiArCQkJCWZvdW5kID0gdHJ1ZTsKPj4gKwkJCQkqbnVtYV9ub2RlID0gcHht
X3RvX25vZGUoZ3B1LT5wcm94aW1pdHlfZG9tYWluKTsKPj4gKwkJCX0KPj4gKwkJCWJyZWFrOwo+
PiArCQlkZWZhdWx0Ogo+PiArCQkJYnJlYWs7Cj4+ICsJCX0KPj4gKwo+PiArCQlpZiAoZm91bmQp
Cj4+ICsJCQlicmVhazsKPj4gKwo+PiArCQlzdWJfaGVhZGVyID0gKHN0cnVjdCBhY3BpX3N1YnRh
YmxlX2hlYWRlciAqKQo+PiArCQkJCSgodW5zaWduZWQgbG9uZylzdWJfaGVhZGVyICsgc3VidGFi
bGVfbGVuKTsKPj4gKwkJc3VidGFibGVfbGVuID0gc3ViX2hlYWRlci0+bGVuZ3RoOwo+PiArCX0K
Pj4gKwo+PiArCS8qIHdvcmthcm91bmQgYmFkIGNwdS1ncHUgYmluZGluZyBjYXNlICovCj4+ICsJ
aWYgKGZvdW5kICYmICgqbnVtYV9ub2RlIDwgMCB8fCAqbnVtYV9ub2RlID4gbWF4X3B4bSkpCj4+
ICsJCSpudW1hX25vZGUgPSAwOwo+IEEgc3VnZ2VzdGlvbjogSWYgeW91IGZpbmQgYSBzZW5zaWJs
ZSBOVU1BIG5vZGUsIGNhbGwgc2V0X2Rldl9ub2RlIGhlcmUuCj4gVGhhdCBzaW1wbGlmaWVzIHRo
ZSBjYWxsZXIuIFNlZSBiZWxvdwo+Cj4KPj4gK30KPj4gKyNlbmRpZgo+PiArCj4+ICAgLyoga2Zk
X2ZpbGxfZ3B1X2RpcmVjdF9pb19saW5rIC0gRmlsbCBpbiBkaXJlY3QgaW8gbGluayBmcm9tIEdQ
VQo+PiAgICAqIHRvIGl0cyBOVU1BIG5vZGUKPj4gICAgKglAYXZhaWxfc2l6ZTogQXZhaWxhYmxl
IHNpemUgaW4gdGhlIG1lbW9yeQo+PiBAQCAtMTc3NCw2ICsxODU1LDkgQEAgc3RhdGljIGludCBr
ZmRfZmlsbF9ncHVfZGlyZWN0X2lvX2xpbmtfdG9fY3B1KGludCAqYXZhaWxfc2l6ZSwKPj4gICAJ
CQl1aW50MzJfdCBwcm94aW1pdHlfZG9tYWluKQo+PiAgIHsKPj4gICAJc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilrZGV2LT5rZ2Q7Cj4+ICsjaWZk
ZWYgQ09ORklHX05VTUEKPj4gKwlpbnQgbnVtYV9ub2RlID0gMDsKPiBTaG91bGQgdGhpcyBiZSBO
VU1BX05PX05PREU/Cj4KPgo+PiArI2VuZGlmCj4+ICAgCj4+ICAgCSphdmFpbF9zaXplIC09IHNp
emVvZihzdHJ1Y3QgY3JhdF9zdWJ0eXBlX2lvbGluayk7Cj4+ICAgCWlmICgqYXZhaWxfc2l6ZSA8
IDApCj4+IEBAIC0xODA1LDkgKzE4ODksMTMgQEAgc3RhdGljIGludCBrZmRfZmlsbF9ncHVfZGly
ZWN0X2lvX2xpbmtfdG9fY3B1KGludCAqYXZhaWxfc2l6ZSwKPj4gICAKPj4gICAJc3ViX3R5cGVf
aGRyLT5wcm94aW1pdHlfZG9tYWluX2Zyb20gPSBwcm94aW1pdHlfZG9tYWluOwo+PiAgICNpZmRl
ZiBDT05GSUdfTlVNQQo+PiAtCWlmIChrZGV2LT5wZGV2LT5kZXYubnVtYV9ub2RlID09IE5VTUFf
Tk9fTk9ERSkKPj4gLQkJc3ViX3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3RvID0gMDsKPj4g
LQllbHNlCj4+ICsJaWYgKGtkZXYtPnBkZXYtPmRldi5udW1hX25vZGUgPT0gTlVNQV9OT19OT0RF
KSB7Cj4+ICsjaWZkZWYgQ09ORklHX0FDUEkKPj4gKwkJa2ZkX2ZpbmRfbnVtYV9ub2RlX2luX3Ny
YXQoa2RldiwgJm51bWFfbm9kZSk7Cj4+ICsjZW5kaWYKPj4gKwkJc3ViX3R5cGVfaGRyLT5wcm94
aW1pdHlfZG9tYWluX3RvID0gbnVtYV9ub2RlOwo+PiArCQlzZXRfZGV2X25vZGUoJmtkZXYtPnBk
ZXYtPmRldiwgbnVtYV9ub2RlKTsKPj4gKwl9IGVsc2UKPj4gICAJCXN1Yl90eXBlX2hkci0+cHJv
eGltaXR5X2RvbWFpbl90byA9IGtkZXYtPnBkZXYtPmRldi5udW1hX25vZGU7Cj4gSXQncyBiZXR0
ZXIgc3R5bGUgdG8gdXNlIGJyYWNlcyBvbiBhbGwgaWYvZWxzZSBicmFuY2hlcywgaWYgb25lIGJy
YW5jaAo+IG5lZWRzIHRoZW0uCj4KPiBCdXQgd2l0aCBteSBzdWdnZXN0aW9uIGFib3ZlIHRoaXMg
d291bGQgYmVjb21lIHNpbXBsZXI6Cj4KPiArI2lmZGVmIENPTkZJR19BQ1BJCj4gKwlpZiAoa2Rl
di0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05PREUpCj4gKwkJa2ZkX2ZpbmRfbnVt
YV9ub2RlX2luX3NyYXQoa2Rldik7Cj4gKyNlbmRpZgo+IAlpZiAoa2Rldi0+cGRldi0+ZGV2Lm51
bWFfbm9kZSA9PSBOVU1BX05PX05PREUpCj4gCQlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21h
aW5fdG8gPSAwOwo+IAllbHNlCj4gCQlzdWJfdHlwZV9oZHItPnByb3hpbWl0eV9kb21haW5fdG8g
PSBrZGV2LT5wZGV2LT5kZXYubnVtYV9ub2RlOwo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+
Cj4+ICAgI2Vsc2UKPj4gICAJc3ViX3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3RvID0gMDsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
