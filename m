Return-Path: <SRS0=k5/X=43=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665DC18E5B
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC412468F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2020 12:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pkswqW5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC412468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F24366E0AA;
	Tue, 10 Mar 2020 12:58:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED2B6E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2020 12:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF6EqI8lts6iD0l4E15yeNeDZ7yVh6TcMT3ZWEwK3APQFhL+Qpi9ix3zTqlmzP9uV99nyDfYcXzVb/8vu8S4SJ9z2uGEw5Lh3dt9MbX6ibJJZEZPj+pou1aN3yNRhJMhLydDqNYkA7PiITYxmatKv/wNTkg18mKUM13s0zfmGJqOZU36ijIYQAAgsv6c30e7Q7oqp1exZXJoyHnMDM1z9JUfLIsYTTxO1Q+2uZRrFP89E9cE9zDowI1/7i2Yy+F4G8nYg/ye0aD8Nfd35YsACiSqLZW2i1n2AvxaLFINg5XAYp644Il9uL6L/fJnlV2PERzVPPd5PTSkFcxpY6XNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc30oWBGIAjtF/FUF3jzBk0IHz4jID9qR+blJJZEToc=;
 b=PEIRgQn5lb4GEcJn+GW0j6Bo1rgRvyX5E7Yil4cDnF8dARj0px7RTEujlbGuEw8G+Hy46Clfl6zphWKZ0bPZkWZGyabKfbsuTtKK88JMeZqhlyluNBTbqJpC8k/ykJuVdJP2phqq3uQRaoyW8VhOfXJqun19TV98akHI7QheI+vMy6RO0w1J3pKVXYAHJerX7o6dUglPTL+kZe7T/AfSSAlmDZhnHgadFJGZ9wYGif3zaG7xXtMTM8zg9H0Q0G8HEhnyzlvL7h+bgYJ4UAB3I60IkJI9P48rII0XUH91cqCRrd3hSo9jukPY+lSAAEKdFCB3ACYma5qJjTaudUpXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oc30oWBGIAjtF/FUF3jzBk0IHz4jID9qR+blJJZEToc=;
 b=pkswqW5Pr6RpiOKaVM1oQNRUm8R6KrAAp/4IlHOs+rivcGfqy+zQZOGWBzcFfq3FwZZoDNn1IG7FxqV/QsCUvLA6OhOSyJxv81Z9si+H2ae7y1+Gy51nx6ep7FKWOx81nXhz6w4Siy/ZAFHDHVtc/hxkMXaCSuFDeUvZKXQUBFI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3165.namprd12.prod.outlook.com (2603:10b6:208:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Tue, 10 Mar
 2020 12:58:40 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2793.018; Tue, 10 Mar 2020
 12:58:40 +0000
Subject: Re: [bug report] drm/amd/amdgpu: Add debugfs support for reading GPRs
 (v2)
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20171128142919.4n4d5qfx6so6mllr@mwanda>
 <87088974-95bb-6b3c-a200-60169ec961e5@amd.com> <20200310122344.GA11601@kadam>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <3ad5cf1a-f977-ccb0-c6ea-0cc8753dd146@amd.com>
Date: Tue, 10 Mar 2020 08:58:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200310122344.GA11601@kadam>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::37)
 To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (64.231.93.139) by
 YQBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 12:58:39 +0000
X-Originating-IP: [64.231.93.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82303169-8812-41f4-ee2e-08d7c4f2c112
X-MS-TrafficTypeDiagnostic: MN2PR12MB3165:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3165F96F0B6E5B553299EA61F7FF0@MN2PR12MB3165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(6512007)(8676002)(52116002)(186003)(26005)(36756003)(66556008)(16526019)(2616005)(81166006)(8936002)(53546011)(31686004)(6486002)(66946007)(4326008)(66476007)(81156014)(956004)(478600001)(2906002)(6506007)(86362001)(5660300002)(31696002)(6916009)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3165;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcsgsZAJlCSSORb83AhN7ZhopO93GTZ+b5gClps0/PjeVgilOHUbeafsdqg9TSnAdMdVggfc2mhLRHEqh1p7w8FYMQ9jtml8Emzv12tso4SolKGLCh2Gsq77jQsicO/HxWiYPyROjysKFvLzey5iXn6JznS/09JogRc8tB3Jnio/jfO/Va17IdDraV12q7NGckqhZh64044SJ85cSxkIcljnNldoe+hMqbC+f2kNzecCErqtTu/MKe6BtHaf2dGNPW928zmPK+noCoY+yftkMRmJZ4pOMICQlqq3Y4WKo2/YiUfWDTFZNntMA2EDogyUNwC9y8j9ZTDV9wRqgQZRS4W+60M8PqMoJM/Mi96ZlEB6cQkD7hpjOr6hiSj/00U3OK+S4N0wd1BHJ3MOoWbPF3ydi9LNWwXkNOhA5w12UfzAzFnkCZKXPgaCdgRPp/KV
X-MS-Exchange-AntiSpam-MessageData: QYdjv6ucv538lfMJZy+kIzi7qKa2Xy4r5KzJcV8pgmfasnFJbYCH/9cXNsSSYZfLWI4simRbZmNKSY+Kqj1iNJob5MBtyt2JuHnhryZjMsH5vPD67O31/3kH2xDAfKaMmSqZlN2lL9hAsBgUGivRRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82303169-8812-41f4-ee2e-08d7c4f2c112
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:58:39.8376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMD4xjx90TkOJJwDP/4iWA/ZzMBCWv2fUOl60zskov3yDEfrcoacF+hebzKs4u7aydOi5lwdz+zMgvp7Vo5/mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3165
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U29ycnkgYWJvdXQgbWlzc2luZyB0aGF0LsKgIEEgZml4IHdhcyBzZW50IHRvIHRoZSBsaXN0IGEg
ZmV3IG1pbnMgYWdvLsKgIApJdCBhbHNvIGhpZ2hsaWdodGVkIGEgYnVnIGluIHVtcidzIHJlYWRp
bmcgb2YgdHJhcCByZWdpc3RlcnMuwqAgSXQncyBhIApnZW51aW5lIHR3by1mZXIhCgpUb20KCgpP
biAyMDIwLTAzLTEwIDg6MjMgYS5tLiwgRGFuIENhcnBlbnRlciB3cm90ZToKPiBPbiBUdWUsIE5v
diAyOCwgMjAxNyBhdCAwOTozNzo0NEFNIC0wNTAwLCBUb20gU3QgRGVuaXMgd3JvdGU6Cj4+IE9u
IDI4LzExLzE3IDA5OjI5IEFNLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+Pj4gSGVsbG8gVG9tIFN0
IERlbmlzLAo+Pj4KPj4+IFRoZSBwYXRjaCBjNWE2MGNlODFiNDk6ICJkcm0vYW1kL2FtZGdwdTog
QWRkIGRlYnVnZnMgc3VwcG9ydCBmb3IKPj4+IHJlYWRpbmcgR1BScyAodjIpIiBmcm9tIERlYyA1
LCAyMDE2LCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIHN0YXRpYwo+Pj4gY2hlY2tlciB3YXJuaW5n
Ogo+Pj4KPj4+IAlkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmM6Mzc3
NCBhbWRncHVfZGVidWdmc19ncHJfcmVhZCgpCj4+PiAJZXJyb3I6IGJ1ZmZlciBvdmVyZmxvdyAn
ZGF0YScgMTAyNCA8PSA0MDk1Cj4+Pgo+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCj4+PiAgICAgMzczMSAgc3RhdGljIHNzaXplX3QgYW1kZ3B1X2RlYnVnZnNf
Z3ByX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCj4+PiAgICAgMzczMiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBzaXplLCBsb2Zm
X3QgKnBvcykKPj4+ICAgICAzNzMzICB7Cj4+PiAgICAgMzczNCAgICAgICAgICBzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGYtPmZfaW5vZGUtPmlfcHJpdmF0ZTsKPj4+ICAgICAzNzM1ICAg
ICAgICAgIGludCByOwo+Pj4gICAgIDM3MzYgICAgICAgICAgc3NpemVfdCByZXN1bHQgPSAwOwo+
Pj4gICAgIDM3MzcgICAgICAgICAgdWludDMyX3Qgb2Zmc2V0LCBzZSwgc2gsIGN1LCB3YXZlLCBz
aW1kLCB0aHJlYWQsIGJhbmssICpkYXRhOwo+Pj4gICAgIDM3MzgKPj4+ICAgICAzNzM5ICAgICAg
ICAgIGlmIChzaXplICYgMyB8fCAqcG9zICYgMykKPj4+ICAgICAzNzQwICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7Cj4+PiAgICAgMzc0MQo+Pj4gICAgIDM3NDIgICAgICAgICAgLyog
ZGVjb2RlIG9mZnNldCAqLwo+Pj4gICAgIDM3NDMgICAgICAgICAgb2Zmc2V0ID0gKnBvcyAmIEdF
Tk1BU0tfVUxMKDExLCAwKTsKPj4+ICAgICAgICAgICAgICAgICAgIF5eXl5eXgo+Pj4gb2Zmc2V0
IGlzIHNldCB0byAwLTQwOTUuCj4+Pgo+Pj4gICAgIDM3NDQgICAgICAgICAgc2UgPSAoKnBvcyAm
IEdFTk1BU0tfVUxMKDE5LCAxMikpID4+IDEyOwo+Pj4gICAgIDM3NDUgICAgICAgICAgc2ggPSAo
KnBvcyAmIEdFTk1BU0tfVUxMKDI3LCAyMCkpID4+IDIwOwo+Pj4gICAgIDM3NDYgICAgICAgICAg
Y3UgPSAoKnBvcyAmIEdFTk1BU0tfVUxMKDM1LCAyOCkpID4+IDI4Owo+Pj4gICAgIDM3NDcgICAg
ICAgICAgd2F2ZSA9ICgqcG9zICYgR0VOTUFTS19VTEwoNDMsIDM2KSkgPj4gMzY7Cj4+PiAgICAg
Mzc0OCAgICAgICAgICBzaW1kID0gKCpwb3MgJiBHRU5NQVNLX1VMTCg1MSwgNDQpKSA+PiA0NDsK
Pj4+ICAgICAzNzQ5ICAgICAgICAgIHRocmVhZCA9ICgqcG9zICYgR0VOTUFTS19VTEwoNTksIDUy
KSkgPj4gNTI7Cj4+PiAgICAgMzc1MCAgICAgICAgICBiYW5rID0gKCpwb3MgJiBHRU5NQVNLX1VM
TCg2MSwgNjApKSA+PiA2MDsKPj4+ICAgICAzNzUxCj4+PiAgICAgMzc1MiAgICAgICAgICBkYXRh
ID0ga21hbGxvY19hcnJheSgxMDI0LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsKPj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl4KPj4+IGRhdGEgaXMgYSAx
MDI0IGVsZW1lbnQgYXJyYXkKPj4+Cj4+PiAgICAgMzc1MyAgICAgICAgICBpZiAoIWRhdGEpCj4+
PiAgICAgMzc1NCAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+Pj4gICAgIDM3NTUK
Pj4+ICAgICAzNzU2ICAgICAgICAgIC8qIHN3aXRjaCB0byB0aGUgc3BlY2lmaWMgc2Uvc2gvY3Ug
Ki8KPj4+ICAgICAzNzU3ICAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPmdyYm1faWR4X211dGV4
KTsKPj4+ICAgICAzNzU4ICAgICAgICAgIGFtZGdwdV9nZnhfc2VsZWN0X3NlX3NoKGFkZXYsIHNl
LCBzaCwgY3UpOwo+Pj4gICAgIDM3NTkKPj4+ICAgICAzNzYwICAgICAgICAgIGlmIChiYW5rID09
IDApIHsKPj4+ICAgICAzNzYxICAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdmeC5mdW5jcy0+
cmVhZF93YXZlX3ZncHJzKQo+Pj4gICAgIDM3NjIgICAgICAgICAgICAgICAgICAgICAgICAgIGFk
ZXYtPmdmeC5mdW5jcy0+cmVhZF93YXZlX3ZncHJzKGFkZXYsIHNpbWQsIHdhdmUsIHRocmVhZCwg
b2Zmc2V0LCBzaXplPj4yLCBkYXRhKTsKPj4+ICAgICAzNzYzICAgICAgICAgIH0gZWxzZSB7Cj4+
PiAgICAgMzc2NCAgICAgICAgICAgICAgICAgIGlmIChhZGV2LT5nZnguZnVuY3MtPnJlYWRfd2F2
ZV9zZ3BycykKPj4+ICAgICAzNzY1ICAgICAgICAgICAgICAgICAgICAgICAgICBhZGV2LT5nZngu
ZnVuY3MtPnJlYWRfd2F2ZV9zZ3BycyhhZGV2LCBzaW1kLCB3YXZlLCBvZmZzZXQsIHNpemU+PjIs
IGRhdGEpOwo+Pj4gICAgIDM3NjYgICAgICAgICAgfQo+Pj4gICAgIDM3NjcKPj4+ICAgICAzNzY4
ICAgICAgICAgIGFtZGdwdV9nZnhfc2VsZWN0X3NlX3NoKGFkZXYsIDB4RkZGRkZGRkYsIDB4RkZG
RkZGRkYsIDB4RkZGRkZGRkYpOwo+Pj4gICAgIDM3NjkgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZh
ZGV2LT5ncmJtX2lkeF9tdXRleCk7Cj4+PiAgICAgMzc3MAo+Pj4gICAgIDM3NzEgICAgICAgICAg
d2hpbGUgKHNpemUpIHsKPj4+ICAgICAzNzcyICAgICAgICAgICAgICAgICAgdWludDMyX3QgdmFs
dWU7Cj4+PiAgICAgMzc3Mwo+Pj4gICAgIDM3NzQgICAgICAgICAgICAgICAgICB2YWx1ZSA9IGRh
dGFbb2Zmc2V0KytdOwo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5e
Xl5eXl5eXl5eCj4+PiBXZSdyZSBwb3NzaWJseSByZWFkaW5nIGJleW9uZCB0aGUgZW5kIG9mIHRo
ZSBhcnJheS4gIE1heWJlIHdlIGFyZQo+Pj4gc3VwcG9zZWQgdG8gZGl2aWRlIHRoZSBvZmZzZXQg
Lz0gc2l6ZW9mKCpkYXRhKT8KPj4gSGkgRGFuLAo+Pgo+Pgo+PiB1bXIgb25seSByZWFkcyBmcm9t
IG9mZnNldCB6ZXJvIGJ1dCB0byBiZSBjb25zaXN0ZW50IEkgdGhpbmsgeWVzIHRoZSBvZmZzZXQK
Pj4gc2hvdWxkIGJlIC89IDQgZmlyc3Qgc2luY2Ugd2UgZW5zdXJlIGl0J3MgNCBieXRlIGFsaWdu
ZWQgaXQncyBjbGVhcmx5IGEgNAo+PiBieXRlIG9mZnNldC4KPj4KPj4gVGhhbmtzIGZvciBmaW5k
aW5nIHRoaXMsIEknbGwgY3JhZnQgdXAgYSBwYXRjaCBzaG9ydGx5Lgo+Pgo+IFdoYXQgZXZlciBo
YXBwZW5lZCB3aXRoIHRoaXM/Cj4KPiByZWdhcmRzLAo+IGRhbiBjYXJwZW50ZXIKPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
