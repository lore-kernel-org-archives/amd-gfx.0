Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF1C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 23:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327662083E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 23:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tDJG2R8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327662083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B2F6FA51;
	Thu, 30 Jan 2020 23:07:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6324F6FA51
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 23:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBCNhBwqnV2gGe9INt7zrrfdHaqarxclVRc162mF98z9seAPTG5Djv6rkAV1xobooA/0Mk0NKoaA88A2CP3izz1CRT02wIhGM4U4iCgjPPac5rW6kUl3UQea7Y9Mmnf6hWkponi5tt+EAfTq0OudI0aPz3hFJW1AXECOV6qq3ufy4CdWujgDKYEuWoB/VnMYuuia5Clltyl+UJxkbWmBgezFa5XsqJnsxHu60ImTCbeXKaEeVFxbpep6qWCyiIoERZULiWNAdosQM9o2HeFw48i+XRQCFmrveowCtxU1pvhopWbXiw7hHoodUlASuqY8zcaTaOUQlfG0/4S35aJfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z4pdI4x+T4UXNxQC2OOR6x0Lwmx9wAQZEvQs9OKX0g=;
 b=XWUVLaFVFH6ve3TOTzZqfH8hRFDfvFatihq9txOSbXWljNEVgVmNUDly82IXs507dvK/C2f72HQdTS5L6b7deE4lTgjPHUPB7robaWSsAPR7rxgGIt+E94trb2e1cQUsmOWfrwi3nEGmSIk1XujQstFowr/jlk7NgcRiEGUEu9nf4QyhMiWFHLdSevrK8C4Szv/Zn5n8vmG8XOmgcZaN5Rt6gfSZEF5nRofwkDGC/I5qtJGbBaiKu3h8RTdf93+u8ooT1Et7TyKrJC/gtKfspVBsTpS1EcnzDsNUA+xQusnB5DI8o4sflrU6RTB7cUEdu0ZJ8wxOvdXolP2S837sPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z4pdI4x+T4UXNxQC2OOR6x0Lwmx9wAQZEvQs9OKX0g=;
 b=tDJG2R8zrd502hnd35iErB1viO8UmtN7bhI0y+afV51jUHk/b8RVR1t7dHUWBjTuw4+iCOrYPxaZ/6+VTL1nVssrJT0Lg5zw0jm7XRj/QRZPYhXU1Pk5vMqA9yRvG6SQQ3VRf28u+bjPwd5gT2dlPAcJbMSXR0nnzxg//vnLIQA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB3864.namprd12.prod.outlook.com (52.132.244.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 30 Jan 2020 23:07:12 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 23:07:12 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix a bug in SDMA RLC queue counting under
 HWS mode
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200130222908.1403-1-Yong.Zhao@amd.com>
 <5f7d507f-25f9-bebc-a1d5-cf3b509c060a@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <b4934a13-b00e-d81a-454b-779eaa779af0@amd.com>
Date: Thu, 30 Jan 2020 18:07:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <5f7d507f-25f9-bebc-a1d5-cf3b509c060a@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from [172.27.227.155] (165.204.55.251) by
 YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 23:07:11 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82ede6bf-c26d-4044-8244-08d7a5d92384
X-MS-TrafficTypeDiagnostic: CH2PR12MB3864:|CH2PR12MB3864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB386451DF7777825B79419B76F0040@CH2PR12MB3864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(478600001)(16576012)(8676002)(31686004)(2616005)(2906002)(52116002)(316002)(53546011)(5660300002)(81166006)(186003)(44832011)(81156014)(956004)(31696002)(36756003)(8936002)(16526019)(26005)(86362001)(66946007)(66556008)(66476007)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3864;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQLeg808SCrW7Pi76mZXCf/98Hd0zI3SQvLHeTD+MdDrUkAt70qJCwlYqbEjgX9EkeUMRSukAeVnGTuDR8kJ9fZDUj9ogeFqoIllDHP7eRVrNqOig7yiqlJnGxtwXQaYQbp8XUDsAexVdm4A7tSGBuIM0TDD8E+WnbCzvnidJd7BkrAxVWrCrc8ei60DdpBiHSEVeQxMH6gqYtQ8ia7ZCtPaFFv4Rv7ccGt1AquUP3gyv5amOYc0OCweX6ADHiWG1IZzPXNLsS3HcAtpfscmlo7nOqg/AbdFrGyKn3soDsFa+KvjNYkaPc/kDIJkmJskjAFkLRO+SswxIFlGyvRvhAVNjyMEoJ5qyMbYeNOq+1ek/BDrsOJz3AhZjOULqcveVz+maD06q0Gs3qNBRT0kvlORr8msesrFFuBdVrH4/W9eEgw5lp5H+kV8j82nKVEd
X-MS-Exchange-AntiSpam-MessageData: KV9TA6d493gvrUF3Jvu8qKLxWVqbR5aIWW4tyH0OFQcyUajPjcXGRbdDo9ziSAT3DATXH8nsGY1yDPTIgc1FSlbuPg/ITO2zHWf3BWcFd+uPnRttzFnlgRG1KOSZgREicac6KKXuP/VOw/GAmL8RyA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ede6bf-c26d-4044-8244-08d7a5d92384
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 23:07:11.9796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmepDYcQ6flFlR+iY6jh+96BGcnbz09w95GnEM2r6w8jwHCFI/3Fm80AQoOPUkby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3864
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

VHJ1ZS4gSXQgaXMgYSBidWcgdG9vLiBJIGFtIGxvb2tpbmcgaW50byBpdC4KCllvbmcKCk9uIDIw
MjAtMDEtMzAgNTo1MSBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBPbiAyMDIwLTAxLTMw
IDE3OjI5LCBZb25nIFpoYW8gd3JvdGU6Cj4+IFRoZSBzZG1hX3F1ZXVlX2NvdW50IGluY3JlbWVu
dCBzaG91bGQgYmUgZG9uZSBiZWZvcmUKPj4gZXhlY3V0ZV9xdWV1ZXNfY3BzY2goKSwgd2hpY2gg
Y2FsbHMgcG1fY2FsY19ybGliX3NpemUoKSB3aGVyZQo+PiBzZG1hX3F1ZXVlX2NvdW50IGlzIHVz
ZWQgdG8gY2FsY3VsYXRlIHdoZXRoZXIgb3Zlcl9zdWJzY3JpcHRpb24gaXMKPj4gdHJpZ2dlcmVk
Lgo+Pgo+PiBXaXRoIHRoZSBwcmV2aW91cyBjb2RlLCB3aGVuIGEgU0RNQSBxdWV1ZSBpcyBjcmVh
dGVkLAo+PiBjb21wdXRlX3F1ZXVlX2NvdW50IGluIHBtX2NhbGNfcmxpYl9zaXplKCkgaXMgb25l
IG1vcmUgdGhhbiB0aGUKPj4gYWN0dWFsIGNvbXB1dGUgcXVldWUgbnVtYmVyLCBiZWNhdXNlIHRo
ZSBxdWV1ZV9jb3VudCBoYXMgYmVlbgo+PiBpbmNyZW1lbnRlZCB3aGlsZSBzZG1hX3F1ZXVlX2Nv
dW50IGhhcyBub3QuIFRoaXMgcGF0Y2ggZml4ZXMgdGhhdC4KPj4KPj4gQ2hhbmdlLUlkOiBJMjAz
NTNlNjU3ZWZkNTA1MzUzZDBkZDlmN2ViMmZhYjUwODVlNzIwMgo+PiBTaWduZWQtb2ZmLWJ5OiBZ
b25nIFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Cj4gQnV0IEkgdG9vayBhIGxvb2sgYXQgcG1f
Y2FsY19ybGliX3NpemUuIEkgZG9uJ3QgdGhpbmsgc3VidHJhY3RpbmcgCj4gZHFtLT5zZG1hX3F1
ZXVlX2NvdW50IGZyb20gZHFtLT5xdWV1ZV9jb3VudCBpcyBub3QgcXVpdGUgY29ycmVjdCwgCj4g
YmVjYXVzZSBzZG1hX3F1ZXVlX2NvdW50IGNvdW50cyBhbGwgU0RNQSBxdWV1ZXMsIHdoaWxlIHF1
ZXVlX2NvdW50IAo+IG9ubHkgY291bnRzIGFjdGl2ZSBxdWV1ZXMuIFNvIGFuIGFwcGxpY2F0aW9u
IHRoYXQgY3JlYXRlcyBpbmFjdGl2ZSAKPiBTRE1BIHF1ZXVlcyB3aWxsIGFsc28gY3JlYXRlIGVy
cm9ycyBoZXJlLiBXZSBwcm9iYWJseSBuZWVkIHRvIGNvdW50IAo+IGFjdGl2ZSBjb21wdXRlIGFu
ZCBhY3RpdmUgU0RNQSBxdWV1ZXMgc2VwYXJhdGVseSBpbiBEUU0gdG8gZml4IHRoaXMgCj4gcHJv
cGVybHkuCj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgfCAxMCArKysrKyst
LS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
X3F1ZXVlX21hbmFnZXIuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2
aWNlX3F1ZXVlX21hbmFnZXIuYwo+PiBpbmRleCAyODcwNTUzYTJjZTAuLjgwZDIyYmY3MDJlOCAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1
ZV9tYW5hZ2VyLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMKPj4gQEAgLTEyMzcsMTYgKzEyMzcsMTggQEAgc3RhdGljIGludCBj
cmVhdGVfcXVldWVfY3BzY2goc3RydWN0IAo+PiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLCBz
dHJ1Y3QgcXVldWUgKnEsCj4+IMKgIMKgwqDCoMKgwqAgbGlzdF9hZGQoJnEtPmxpc3QsICZxcGQt
PnF1ZXVlc19saXN0KTsKPj4gwqDCoMKgwqDCoCBxcGQtPnF1ZXVlX2NvdW50Kys7Cj4+ICsKPj4g
K8KgwqDCoCBpZiAocS0+cHJvcGVydGllcy50eXBlID09IEtGRF9RVUVVRV9UWVBFX1NETUEpCj4+
ICvCoMKgwqDCoMKgwqDCoCBkcW0tPnNkbWFfcXVldWVfY291bnQrKzsKPj4gK8KgwqDCoCBlbHNl
IGlmIChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0gS0ZEX1FVRVVFX1RZUEVfU0RNQV9YR01JKQo+PiAr
wqDCoMKgwqDCoMKgwqAgZHFtLT54Z21pX3NkbWFfcXVldWVfY291bnQrKzsKPj4gKwo+PiDCoMKg
wqDCoMKgIGlmIChxLT5wcm9wZXJ0aWVzLmlzX2FjdGl2ZSkgewo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZHFtLT5xdWV1ZV9jb3VudCsrOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dmFsID0gZXhl
Y3V0ZV9xdWV1ZXNfY3BzY2goZHFtLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIEtGRF9VTk1BUF9RVUVVRVNfRklMVEVSX0RZTkFNSUNfUVVFVUVTLCAwKTsKPj4gwqDCoMKg
wqDCoCB9Cj4+IMKgIC3CoMKgwqAgaWYgKHEtPnByb3BlcnRpZXMudHlwZSA9PSBLRkRfUVVFVUVf
VFlQRV9TRE1BKQo+PiAtwqDCoMKgwqDCoMKgwqAgZHFtLT5zZG1hX3F1ZXVlX2NvdW50Kys7Cj4+
IC3CoMKgwqAgZWxzZSBpZiAocS0+cHJvcGVydGllcy50eXBlID09IEtGRF9RVUVVRV9UWVBFX1NE
TUFfWEdNSSkKPj4gLcKgwqDCoMKgwqDCoMKgIGRxbS0+eGdtaV9zZG1hX3F1ZXVlX2NvdW50Kys7
Cj4+IMKgwqDCoMKgwqAgLyoKPj4gwqDCoMKgwqDCoMKgICogVW5jb25kaXRpb25hbGx5IGluY3Jl
bWVudCB0aGlzIGNvdW50ZXIsIHJlZ2FyZGxlc3Mgb2YgdGhlIAo+PiBxdWV1ZSdzCj4+IMKgwqDC
oMKgwqDCoCAqIHR5cGUgb3Igd2hldGhlciB0aGUgcXVldWUgaXMgYWN0aXZlLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
