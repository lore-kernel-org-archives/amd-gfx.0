Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:06:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2F320732
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 03:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uWWxRx42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2F320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD396EA88;
	Fri, 21 Aug 2020 03:06:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313886EA88
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 03:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0GepwQfqWGfv4g/ILWda7bMpEudr/DWMsXusxPEHTKZrm5jnPDmDKori+YFiCFR4DMAT5Jec6Lak4SRimw80gyhlUu13P1yuf20+XOoyDrczrt0vN549ngh/Q652/IQ/n3XUUlIhRcflVuWZ+9ihv1GdKxG5ULIgkUu1YFPtn+UjP23ix2UnU4K75aejrNiaFJ58a3R5WkpXRaBfExMgs0B5X8NyRNEiSxsKGWB47r8JpdQdU/wzWG6TUWWgxBfWF7YMjdYGet2so+RV+u2USjA9yoqHEEexLY/uFKV4L6UYdiMR7AJpFoOCIjprXdxFSMoYlo2DuY0hy6u8qEVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XTS2eaWka6hduTzrCt7jPTCmKtXfQcKMF8y3g9dfvU=;
 b=aAIGuxsZyxlDn45WSUQWhG+5h3HFQqycz0Qy+76v9CxS1cENPAbJgSuwLVlz4E+6jcfoUw8rfRUJQ35zYn7IIiePKZu+lNTcv0u8ffVvBZomubK9V7NSKnnScqQC+CWCETIYOVeo35uIszPUtjy+qllPficqYDL9H5ngKb4vP8K5lIx0wl9YdZMaBW8gtihJHS3E9kZIQEZQOYfceXP/y6JbuKxbOL4RdkPywSfnzTDa1Dbt1CpXkyEvE9/Yuy+MClWxVh9w15LYI5naq0dxUJzdx4XAXVF4dMQpNgms8jylhEaBrAC31k6nCPVARPU4/1BoAJ7zq2/C8WpjQspbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XTS2eaWka6hduTzrCt7jPTCmKtXfQcKMF8y3g9dfvU=;
 b=uWWxRx42Ro5xRhORwweluQVOZqCjk2RzYl0/udbXUxV7JYAU/nZYJYHaV+Qm7QGVCPOyka+FDAhMi/UJ9PxHGt4QdE3oqoLAJ8rrlH0cLKUWCtJsbX5gpxNL1vT5NQc4h8zlmSq88Bhe7GwZFlQ6R7LMs/PzNWPQS6E53EBxTM4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 03:06:06 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 03:06:06 +0000
Subject: Re: [PATCH] drm/amdkfd: ignore userptr NUMA auto balancing event
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200819180023.5352-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <242b2854-a239-eb4f-eb69-40bf8ae4cd38@amd.com>
Date: Thu, 20 Aug 2020 23:06:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819180023.5352-1-Philip.Yang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 03:06:05 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec137b63-4f7e-4a43-7399-08d8457f2539
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44311462C367FC42B35BB3BB925B0@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1wACi6uhYN0C7IjL6f43F6nBYKSyRk0P05xUeoQbb+WhNajGaC/Y90wpqayyRd3bGjMKDe8CSIoFoBnZpi6eETaO+OZfR0XdNwX/hqUmVhqqTWo4/3zg7ZZU7rY8TkifuxrRWEqElZYlbqEIbmmFY1Gs8NkmEJ1dDTs+l9yKp1EczZXHJfVu8Z1zgooNC3gEJ0mzoUikc2VN1ulyYnc96jkpHUEOb2RyrblTotRTn6/lp2dXB5ilEXq6u9AIwJZdd+pwW3NT5Cgxg2IVWkrkALJYWx1rz+kb7w+XiyGdbz0EwLoaZJHj+1UHn1u5xpwBD7RaPEEg7+SqJe0OM8TloAhuByjSaUV6pAzifYm7rd7+UCP4EXYn1SDCvhyor3Te738Ax/G5JOkKjsQqZ9ENMxQmaq65L0PI+TYmSQys8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(66556008)(66946007)(5660300002)(478600001)(6486002)(86362001)(66476007)(31686004)(186003)(110011004)(8936002)(16576012)(36756003)(8676002)(26005)(2906002)(316002)(31696002)(83380400001)(2616005)(52116002)(44832011)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8uXDphU6jEvW8VqNsrEOGUGHkrTz21w32Q9vJ/lBO6GMUcrl1tcpNG/4YnWvGLts8JNAEUpThBEzev9nabrcGYd75yxxXUHOQRwmHh7GIPlHM4JQFdkFtkQ0hcy4Eesb+AWbflJSw+FlWEs7Ke3r7tOZUsJrSVF2a18Y/EQ1qIanpWi+61QTRoLySHaccWPLw5lv3SY3uAnaB44ptGUdYYkQkFzTPdhmj966wvKeScAfmxPN7dm+q9z7P1+m45XBt/EZTEtKFZxFB7wg7syhHZqhlDjlGJhd9ae5vfLvJt1/je+JSzcPsyUgeAAnSKgTcyLaERFipn/QUgfczdv/nnYyi0TaCJaa7lkSm8NQBtLjNaBCEgzFp4cdz4wOiZdzh9nAlYgwdgVl8bFUiK5u2INvUZY/pZV9Xh86/bwMLPETaPeZOxOotKYKxWm/dMj5r0T6zBYx640QK6sstigVmwZndc+gmOd6Tcmb+kygzyjDqwm8SotS9RN/NvYPL+15AEBi/U8rAxBlo7j2me9ZCI38PGLovkPVk3QOoN6qzAoUVDxIg/5g2u7NHjcDa1BeGjrZRyncM37+Hy34LWhzL7EKeVuG5Zj+s7AeQw2AJVfqNjZ+FiyhFJplq4I1Ar9WAC+DncHX7QTLGnwVwtGUJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec137b63-4f7e-4a43-7399-08d8457f2539
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 03:06:06.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC2wfDU8reZop+E/vkdd2Dqvkyw1pPsQ3/oJe7Tnwlwc0EovvPxSaFSQg5V092LNDjRUABlrjfxdBk3lJLgodA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

TU1VX05PVElGWV9QUk9URUNUSU9OX1ZNQSBpcyBub3Qgc3BlY2lmaWMgdG8gTlVNQSBhdXRvLWJh
bGFuY2luZy4gSXQgY2FuCmFsc28gYmUgdGhlIHJlc3VsdCBvZiBhbiBtcHJvdGVjdCBzeXN0ZW0g
Y2FsbCB3aGljaCBhY3R1YWxseSBtYWtlcyB0aGUKVk1BIHJlYWQtb25seS4gSSBkb24ndCB0aGlu
ayBpdCdzIE9LIHRvIGlnbm9yZSB0aGF0IG5vdGlmaWVyIGluIHRoZQpnZW5lcmFsIGNhc2UuCgpS
ZWdhcmRzLArCoCBGZWxpeAoKCkFtIDIwMjAtMDgtMTkgdW0gMjowMCBwLm0uIHNjaHJpZWIgUGhp
bGlwIFlhbmc6Cj4gTlVNQSBhdXRvIGJhbGFuY2luZyB0YXNrX251bWFfd29yayBwZXJpb2RpY2Fs
bHkgY2hhbmdlIG1lbW9yeSByYW5nZQo+IHByb3RlY3Rpb24gcHJvdG8sIGluIG9yZGVyIHRvIHRy
aWdnZXIgQ1BVIHBhZ2UgaGludGluZyBmYXVsdCB3aGVuIENQVQo+IGFjY2VzcyB0aGUgbWVtb3J5
IGxhdGVyIHRvIGNoZWNrIGlmIHRoYXQgbWVtb3J5IHJhbmdlIG5lZWQgdG8gbWlncmF0ZSB0bwo+
IGRpZmZlcmVudCBOVU1BIG5vZGUuCj4KPiBHUFUgY2FuIHN0aWxsIGFjY2VzcyB0aGUgbWVtb3J5
IGFmdGVyIE5VTUEgY2hhbmdlIHRoZSBwcm90byBiZWNhdXNlIHRoZQo+IG1lbW9yeSBpcyBub3Qg
bW92ZWQgeWV0LCBzbyBpdCBpcyBzYWZlIHRvIGlnbm9yZSB0aGUgTU1VIG5vdGlmaWVyIGV2ZW50
Cj4gTU1VX05PVElGWV9QUk9URUNUSU9OX1ZNQSB0byBhdm9pZCB1bm5lY2Vzc2FyeSBxdWV1ZSBl
dmljdGlvbiBhbmQKPiByZXN0b3JlLgo+Cj4gQmVmb3JlIE5VTUEgYXV0byBiYWxhbmNpbmcgYWN0
dWFsbHkgbW92ZSB0aGUgbWVtb3J5IHRvIGRpZmZlcmVudCBOVU1BCj4gbm9kZSwgZHJpdmVyIHdp
bGwgcmVjZWl2ZSBNTVUgbm90aWZpZXIgZXZlbnQgTU1VX05PVElGWV9DTEVBUiB0byBldmljdAo+
IHRoZSBxdWV1ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllhbmdA
YW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmMg
fCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5jCj4gaW5kZXggODI4YjUxNjdmZjEyLi5kYzRlMjMxN2Rj
MzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21uLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfbW4uYwo+IEBAIC0xMDYs
NiArMTA2LDggQEAgc3RhdGljIGJvb2wgYW1kZ3B1X21uX2ludmFsaWRhdGVfaHNhKHN0cnVjdCBt
bXVfaW50ZXJ2YWxfbm90aWZpZXIgKm1uaSwKPiAgCj4gIAlpZiAoIW1tdV9ub3RpZmllcl9yYW5n
ZV9ibG9ja2FibGUocmFuZ2UpKQo+ICAJCXJldHVybiBmYWxzZTsKPiArCWlmIChyYW5nZS0+ZXZl
bnQgPT0gTU1VX05PVElGWV9QUk9URUNUSU9OX1ZNQSkKPiArCQlyZXR1cm4gdHJ1ZTsKPiAgCj4g
IAltdXRleF9sb2NrKCZhZGV2LT5ub3RpZmllcl9sb2NrKTsKPiAgCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
