Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABBCC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA5320709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AgRYHB2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA5320709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735746E156;
	Fri, 20 Mar 2020 14:30:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D8266E156
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVZ/r3/zY1cxdrq3aCA0SNKSI0FEDWKAUbNx8E8qRLsQyPUH1N16cxA5lO/Ij9pPe5kSblbHtQvk+ktl4v4hjaA+Q3RthPmHJ6+Qd1BL5LBITl4NEeo46eWCbpwt/1u3kBm/btOV1bo+tyfUVoDYxN0lP9Rc9qbX5DlrXNStnPQzRrPhCKh1bgVDnKO4bERtixhEEO3FgQNjmZugmXDR9aClJg9vqpp32pGfWBk5KKUGs+FxwQSGj7iRdhCDjDCV/F5xR1r+/uRofcEmWuyYYAkHDxY55ca/ipi5UFm/MSU52jgnxzl2cMI0EgArThxmhAGywNX5FC3BUcbMwZ+bnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nmoCrY6Xwk1hEMCmZRRlqksyEhaXHsBOkmXfIj9H+A=;
 b=aInrIqkGfuCsojEFdQEBDucBicw7giSMCY7E4X4TtSSmnPAs6XXiPltAnFQ7p3mjGIgr7f5QBgIsYlznIkh7uGtWgDryCq1xaiKqb/RpJs3g+fNSFMqDieFbIc00r470RLk0UgKXpCkCCu4MtnsgUojwixnVm6TQfZs1TyRRWpUpDZzfoB5GaJ3yOUOBYw3wWtwh7r66RtjHMgYMcQJ24xmZoJTlgr/XzPy9LZYjibK39IfzlsvoCE17WpZx28U7fKG+o0F/29LvVzqLWBD0UiwsSXQ/+d/OWWg2GAyDYxuPHhUCNyon33rbyos+ESj4bDQgSFEk38iUKMfic6wTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nmoCrY6Xwk1hEMCmZRRlqksyEhaXHsBOkmXfIj9H+A=;
 b=AgRYHB2o7UjAVieo2uXmtVBOnN+nfyY7DhPFQ3Ar76W/nAh+P5HReqS6XHDB4AkIxhioxwI0LRMB0c021wOPU9o3kVPbTJyJ5TPVhnFV5VTwF2wIjt89v25Nsjy2Evhu+KMcpKo3kTsmACWnbKHCxl1cRX85NqbT+rnlJyjSD7Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0233.namprd12.prod.outlook.com (2603:10b6:4:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Fri, 20 Mar
 2020 14:30:38 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d%5]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 14:30:38 +0000
Subject: Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
To: amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <2ab4f027-e9c0-f60e-53ed-507bae3c7cf4@amd.com>
Date: Fri, 20 Mar 2020 10:30:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200320002245.14932-1-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::44) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.21] (142.116.63.128) by
 YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Fri, 20 Mar 2020 14:30:37 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e076ca47-f33c-465a-9662-08d7ccdb423d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0233:|DM5PR1201MB0233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0233C591B10BB4C9A700C9BC92F50@DM5PR1201MB0233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(186003)(2616005)(53546011)(66476007)(52116002)(66556008)(956004)(8936002)(44832011)(2906002)(81156014)(31686004)(66946007)(81166006)(8676002)(6636002)(478600001)(5660300002)(6862004)(16526019)(36756003)(316002)(37006003)(26005)(6486002)(86362001)(31696002)(16576012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0233;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WixSeJQ0AmQu9GGoKrlmjcbbkKx6T9FQA7U5cB+HYwHvcqPixp4c8fNcrVZJzLzxss1ayY/azWJV7jD5yVOntmLEvBPyeGXBfyZ4zb0NIr434n79d9peFxbwkaBvfgjAh+5wbLn3T9BM/Ef3lYWQr6pN/we6hfnMkiz01EEQvLWVmKQZIIeIb5Ko81NW+LzKvhEzRJvUIGkd4I7930fPC3LDIxWRmBWf2v8NZ5x7yO7ObonBw3hD/C+uvBYzPV2jG7yA+gYp5SYY+6Y8m2aRQ5r1WqsPZtvHQaeq9SJSezZoYJjqmtDYzjZDPZMMYjWJ8VL/eScKzYOnxS4KjdoF4KHP6FFgXGCohqlcfXsZ4Xza7kUyXmFgl3Ai4+aZvYpVWORZX0qRKDuHisk2RXUP/gwB/npUwjyotgH7fo9r0atAnBooADCjAJGbYN+yKpJu
X-MS-Exchange-AntiSpam-MessageData: mm3G5lLKpfTfUUwKxgfSud4st6wBLspsbDXvVpOm4C61DeaF8CX032Sq+sgOR9MzNd9yH4mrJVyDg76En8+r17TUiEvabfamhUHBRLQKDcNjfmnAnbihERZPgKcYroxlbQzYFuBUHqrjW8IYcpH2bg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e076ca47-f33c-465a-9662-08d7ccdb423d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:30:38.0579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCrqZh4YbyQGQ/EeVSOS+iGPz03DJWk4+EtBYZCtUjOf8+NuZnOUjbc41pdfixcwwcCgpeolM73vdu15neYoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0233
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

T24gMjAyMC0wMy0xOSAyMDoyMiwgQWxleCBTaWVycmEgd3JvdGU6Cj4gQXJjdHVydXMgYW5kIHZl
Z2ExMCBzaGFyZSB0aGUgc2FtZSB2ZWdhMTBfaWgsIGhvd2V2ZXIgYm90aAo+IGhhdmUgZGlmZmVy
ZW50IHJlZ2lzdGVyIG9mZnNldHMgYXQgdGhlIGloIHJpbmcgc2VjdGlvbi4KPiBUaGlzIHZhcmlh
YmxlIGlzIHVzZWQgdG8gaGVscCBjYWxjdWxhdGUgaWggcmluZyByZWdpc3RlciBhZGRyZXNzZXMK
PiBmcm9tIHRoZSBvc3NzeXMsIHRoYXQgY29ycmVzcG9uZHMgdG8gdGhlIGN1cnJlbnQgYXNpYyB0
eXBlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMgfCA0ICsr
KysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuaCB8IDEgKwo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaXJxLmMKPiBpbmRleCA1ZWQ0MjI3ZjMwNGIuLmZhMzg0YWU5YTliYyAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKPiBAQCAtMjc5LDYgKzI3
OSwxMCBAQCBpbnQgYW1kZ3B1X2lycV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+
ICAgCQkJCWFtZGdwdV9ob3RwbHVnX3dvcmtfZnVuYyk7Cj4gICAJfQo+ICAgCj4gKwlpZiAoYWRl
di0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMpCj4gKwkJYWRldi0+aXJxLnJpbmdfc3RyaWRl
ID0gMTsKPiArCWVsc2UKPiArCQlhZGV2LT5pcnEucmluZ19zdHJpZGUgPSAwOwoKVGhpcyBjYW4n
dCBiZSByaWdodC4gcmluZ19zdHJpZGU9PTAgd291bGQgcmVzdWx0IGluIGFsbCBtbUlIX1JJTkco
Li4uKSAKcmVnaXN0ZXIgYWNjZXNzIHRvIG1hcCB0byB0aGUgc2FtZSBwaHlzaWNhbCByZWdpc3Rl
cnMuIFNvIGVmZmVjdGl2ZWx5IApldmVyeXRoaW5nIHdvdWxkIGdvIHRvIHJpbmcwLgoKUmVnYXJk
cywKIMKgIEZlbGl4CgoKPiAgIAlJTklUX1dPUksoJmFkZXYtPmlycS5paDFfd29yaywgYW1kZ3B1
X2lycV9oYW5kbGVfaWgxKTsKPiAgIAlJTklUX1dPUksoJmFkZXYtPmlycS5paDJfd29yaywgYW1k
Z3B1X2lycV9oYW5kbGVfaWgyKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaXJxLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfaXJxLmgKPiBpbmRleCBjNzE4ZTk0YTU1YzkuLjFlYzViNzM1Y2Q5ZSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmgKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmgKPiBAQCAtOTcsNiArOTcsNyBAQCBzdHJ1
Y3QgYW1kZ3B1X2lycSB7Cj4gICAJc3RydWN0IGlycV9kb21haW4JCSpkb21haW47IC8qIEdQVSBp
cnEgY29udHJvbGxlciBkb21haW4gKi8KPiAgIAl1bnNpZ25lZAkJCXZpcnFbQU1ER1BVX01BWF9J
UlFfU1JDX0lEXTsKPiAgIAl1aW50MzJfdCAgICAgICAgICAgICAgICAgICAgICAgIHNyYm1fc29m
dF9yZXNldDsKPiArCXVuc2lnbmVkCQkJcmluZ19zdHJpZGU7Cj4gICB9Owo+ICAgCj4gICB2b2lk
IGFtZGdwdV9pcnFfZGlzYWJsZV9hbGwoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
