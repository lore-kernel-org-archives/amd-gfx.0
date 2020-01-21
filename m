Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8EAC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 21:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C93324653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 21:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4TnfVMKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C93324653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9986E213;
	Tue, 21 Jan 2020 21:08:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399486E213
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 21:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfAZwd8Ff+50N2m/wHLOu0FjKlIaN4z1tk0q3b3uHstH0yRtGjQrTlf/UY9d7d/8OaliEQ0lHEjpk7TbfD49SpG+2q1Tv4Hkr8as1rR4lWKEuhhiBr/XOHbDPnt9KZpY8kVVebZPQ2l/Ol+hKXuXYwfUQndd+sW0GXDCtZDYkhEmnAhYuSsqtAwrUze6dS2SkcV9mlgAJyEEvsLj26za+xtazV/jvZY/SSDMVZbRSw1KREP290aq1wI+uhs6xTpmDjyBko3slsrneHLzD8umiT1lps5vBAk6eXI6AZEDmVzvFgYY0rkbwFl49xHIurANQO2vuWNIIl9qPxDbIltBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxyU64f6oqIEwbm9mr+NM2HgmIo9cz8ERsDMm0ynTOc=;
 b=H9TDOj1QC+LUHxEkLXZNg4hRdgH6aBYiyhYL/pEx2jq3461czK1m3510s9IMeL+nGWd0q2Q/F00Eac5O5LbVIDiIGfYJ6dxDmfubxDKPxxIP2h3JmVEHJClTMRE3QGxsBxNIWfMGEvlG3X9BQVpj083CHwbzAQruoQFpq/Pt5OWIwTQMuYR/cl7twL2ZM6qkG2Qr71eP6VllbvRD9WYZ0K7ksEOIkSW53FZs7Z9TAWCUMwGJCUbVfKqRL6FyS80gPCcTtx9hGYGvZCBGZMre+LO1/ZhsSCjggQCKRpuiCTjSRixkv8sQ/wfBpEAC6e7sDOoA0tJNlplg6py1XUCE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxyU64f6oqIEwbm9mr+NM2HgmIo9cz8ERsDMm0ynTOc=;
 b=4TnfVMKdgvjGsTUDGxgW6FsSlH/mDdZawZcL7k94AYbHnRMnZ8tcI21cHD3rQEf29eQHlJngFOR/R83N4QOcVp8Rn9ebNUSVgidtw+E2kirG4DbiSWiYHvpDn+hxzSPUxqsjngzCjeHfW5CGLhAly5zCwMO42NhO4ArEtDoKyOk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3177.namprd12.prod.outlook.com (20.179.105.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Tue, 21 Jan 2020 21:08:41 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 21:08:41 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn: use inst_idx relacing inst
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
 <67ae3044-0701-1e76-e5ef-683222b4f458@amd.com>
 <cd7c56b2-6c0a-a594-1970-ce9849c7c17d@amd.com>
 <18b47160-2b45-b313-42be-a35dc88fa68f@amd.com>
 <f9803f06-7526-4fbd-5bdb-53e4cd4601d5@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <98ccb0ae-9e60-1824-5993-f31872445d8a@amd.com>
Date: Tue, 21 Jan 2020 16:08:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <f9803f06-7526-4fbd-5bdb-53e4cd4601d5@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::20) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 21:08:40 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17b34966-57b9-48b6-563e-08d79eb6175a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3177:|DM6PR12MB3177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31778370F750B707EE43D9CCE50D0@DM6PR12MB3177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(66946007)(66476007)(5660300002)(31686004)(53546011)(66556008)(8936002)(16526019)(8676002)(81166006)(956004)(81156014)(44832011)(2906002)(2616005)(186003)(52116002)(16576012)(478600001)(26005)(36756003)(31696002)(36916002)(316002)(86362001)(6486002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3177;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cd92T8g+oLohKM5Nv2JfLOo/teQjjizw0pmmr9gb62iQ6R6gZsewbRdA70RnHM2nwZBxF+CawmFgw4Q8qGecudZ3gM6VHKd90XR+7lYs8ZqvrarX0EeUXKIGwfzgcf07Ra995GmPhCiIOAkaiogNgD1BfkTR6F8l1Uwkp+0zCeiM0qE5L5GRb5efEWclNEd+5a2cHlEhb/+sRQ3MEGkSrlzVrqAO2XjpKDxZ4UW5PUL5thUyUKI3FKL9CKeiw8bY9y0CpAQiWNp+q9lFDer2BdMneEE18h/j8cDVEllTfwW+tL8UfEU5dtuwuBVDFIYkczMVGF6vUSHEIQArDAzRGBSyXe3fvPkpUXEAkvbApMrwTl3ULnYHre9mZiFF7hKPK6WOCnqzneXBvpC6eloO0nCoKnZUyIi8IhAYmF4g83RJZTuUfPxtXUqPk3rsWndW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b34966-57b9-48b6-563e-08d79eb6175a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 21:08:41.1476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/ZJ59ARB3VTxVq8dUAlYHJhm+/jC2Z1jg59jTPPiw6iR7tkKVA4RHEgcAZN5H7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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

Ck9uIDIwMjAtMDEtMjEgMzo1OCBwLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4gQWN0dWFsbHkgUlJF
RzMyX1NPQzE1X0RQR19NT0RFXzJfMCBoYXMgYSBidWcgaW5zaWRlIHRvIG1pc3MgdXNpbmcgaW5z
dCAKPiBhcyBpbnN0X2lkeCwKCklmIHRoZXJlIGlzIGEgYnVnLCB5b3Ugc2hvdWxkIGNsZWFybHkg
c3BlY2lmeSB0aGUgYnVnIGluIHRoZSBjb21taXQgCm1lc3NhZ2UgYW5kIGZpeCBpdCBpbiBhIHBh
dGNoLCBhbmQgdGhlbiBpZiB5b3UgdGhpbmsgdGhlIGNvZGUtbmFtZSAKY29udmVyc2lvbiBuZWVk
IHRvIGJlIGZpeGVkLCB5b3Ugc2hvdWxkIGhhdmUgdGhhdCBpbiBhIHNlcGFyYXRlZCBwYXRjaC4K
CkxlbwoKCj4KPiBTbyBJIHdhbnQgdG8gY2xlYW4gdXAgdGhlIGhlYWRlciBmaXJzdCB0byB1c2Ug
aW5zdF9pZHggZm9yIAo+IGFiYnJldmlhdGlvbiBvZiBpbnN0YW5jZSBpbmRleC4KPgo+IEphbWVz
Cj4KPiBPbiAyMDIwLTAxLTIxIDM6MzAgcC5tLiwgTGVvIExpdSB3cm90ZToKPj4KPj4gT24gMjAy
MC0wMS0yMSAxMjo1MCBwLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4+Pgo+Pj4gT24gMjAyMC0wMS0y
MSAxMjo0MyBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMC0wMS0yMSAxMTox
OSBhLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4+Pj4+IFVzZSBpbnN0X2lkeCByZWxhY2luZyBpbnN0
IGluIFNPQzE1X0RQR19NT0RFIG1hY3JvCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphbWVz
IFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tCj4+
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkK
Pj4+Pj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uaCAKPj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmgK
Pj4+Pj4gaW5kZXggNjBmZTNjNC4uOThjMTg5MyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAo+Pj4+PiBAQCAtNjUsMjMgKzY1LDIzIEBACj4+Pj4+
IMKgIC8qIDEgc2Vjb25kIHRpbWVvdXQgKi8KPj4+Pj4gwqAgI2RlZmluZSBWQ05fSURMRV9USU1F
T1VUwqDCoMKgIG1zZWNzX3RvX2ppZmZpZXMoMTAwMCkKPj4+Pj4gwqAgLSNkZWZpbmUgUlJFRzMy
X1NPQzE1X0RQR19NT0RFKGlwLCBpbnN0LCByZWcsIG1hc2ssIAo+Pj4+PiBzcmFtX3NlbCnCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4+IC3CoMKgwqAgKHvCoMKgwqAgV1JF
RzMyX1NPQzE1KGlwLCBpbnN0LCBtbVVWRF9EUEdfTE1BX01BU0ssIAo+Pj4+PiBtYXNrKTvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1
KGlwLCBpbnN0LCBtbVVWRF9EUEdfTE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcCj4+Pj4+ICsjZGVmaW5lIFJSRUczMl9TT0MxNV9EUEdfTU9ERShpcCwgaW5zdF9pZHgs
IHJlZywgbWFzaywgCj4+Pj4+IHNyYW1fc2VsKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+
Pj4+ICvCoMKgwqAgKHvCoMKgwqAgV1JFRzMyX1NPQzE1KGlwLCBpbnN0X2lkeCwgbW1VVkRfRFBH
X0xNQV9NQVNLLCAKPj4+Pj4gbWFzayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIAo+Pj4+PiBtbVVWRF9E
UEdfTE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4KPj4+PiBJ
IGhhdmUgb25seSBzZWVuIHlvdSBhcmUgdXNpbmcgaW5zdF9pZHggdG8gcmVwbGFjZSBpbnN0LCBo
YXZuJ3QgCj4+Pj4geW91PyB0aGlzIGlzIG5vdCBuZWNlc3NhcnksIGJlY2F1c2Ugd2UgYXJlIHVz
aW5nIGluc3QgYXMgdGhlIGlkeC4KPj4+Cj4+PiBTaW5jZSB3ZSB1c2UgaW5zdCBmb3IgaW5zdGFu
Y2UgaW4gc3RydWN0IGFtZGdwdV92Y24uIFRvIGF2b2lkIAo+Pj4gY29uZnVzaW5nLCBJIGNyZWF0
ZSB0aGlzIHBhdGNoLAo+Pgo+PiBJZiBvbmx5IHZhcmlhYmxlIG5hbWUgY2hhbmdlcywgcGxlYXNl
IGRyb3AgdGhlc2UgcGF0Y2gsIHdlIGFyZSB1c2luZyAKPj4gaW5zdCBhbGwgdGhlIHBsYWNlcy4K
Pj4KPj4gTGVvCj4+Cj4+Cj4+Cj4+Cj4+Pgo+Pj4gSmFtZXMKPj4+Cj4+Pj4KPj4+PiBMZW8KPj4+
Pgo+Pj4+Cj4+Pj4KPj4+Pj4gVVZEX0RQR19MTUFfQ1RMX19NQVNLX0VOX01BU0sgfMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Pj4gLSAoKGFkZXYtPnJlZ19vZmZzZXRbaXAj
I19IV0lQXVtpbnN0XVtyZWcjI19CQVNFX0lEWF0gKyByZWcpwqDCoMKgwqAgXAo+Pj4+PiArICgo
YWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3RfaWR4XVtyZWcjI19CQVNFX0lEWF0gKyAK
Pj4+Pj4gcmVnKcKgwqDCoMKgIFwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPDwg
VVZEX0RQR19MTUFfQ1RMX19SRUFEX1dSSVRFX0FERFJfX1NISUZUKSAKPj4+Pj4gfMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChzcmFt
X3NlbCA8PCAKPj4+Pj4gVVZEX0RQR19MTUFfQ1RMX19TUkFNX1NFTF9fU0hJRlQpKTvCoMKgwqDC
oMKgwqDCoMKgIFwKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShpcCwgaW5zdCwg
Cj4+Pj4+IG1tVVZEX0RQR19MTUFfREFUQSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXAo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgUlJFRzMyX1NPQzE1KGlwLCBpbnN0X2lkeCwgCj4+
Pj4+IG1tVVZEX0RQR19MTUFfREFUQSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Pj4g
wqDCoMKgwqDCoCB9KQo+Pj4+PiDCoCAtI2RlZmluZSBXUkVHMzJfU09DMTVfRFBHX01PREUoaXAs
IGluc3QsIHJlZywgdmFsdWUsIG1hc2ssIAo+Pj4+PiBzcmFtX3NlbCnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+Pj4+PiArI2RlZmluZSBXUkVHMzJfU09DMTVfRFBHX01PREUoaXAsIGluc3Rf
aWR4LCByZWcsIHZhbHVlLCBtYXNrLCAKPj4+Pj4gc3JhbV9zZWwpwqDCoMKgwqDCoMKgwqDCoCBc
Cj4+Pj4+IMKgwqDCoMKgwqAgZG8ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Pj4gLcKg
wqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdCwgbW1VVkRfRFBHX0xNQV9EQVRBLCAK
Pj4+Pj4gdmFsdWUpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZEX0RQR19MTUFfTUFTSywgCj4+Pj4+IG1h
c2spO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVH
MzJfU09DMTUoaXAsIGluc3QsIG1tVVZEX0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIFwKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5z
dF9pZHgsIG1tVVZEX0RQR19MTUFfREFUQSwgCj4+Pj4+IHZhbHVlKTvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgXAo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KGlwLCBpbnN0X2lk
eCwgbW1VVkRfRFBHX0xNQV9NQVNLLCAKPj4+Pj4gbWFzayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIAo+
Pj4+PiBtbVVWRF9EUEdfTE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBc
Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9X
UklURV9NQVNLIHwgXAo+Pj4+PiAtICgoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3Rd
W3JlZyMjX0JBU0VfSURYXSArIHJlZynCoMKgwqDCoCBcCj4+Pj4+ICsgKChhZGV2LT5yZWdfb2Zm
c2V0W2lwIyNfSFdJUF1baW5zdF9pZHhdW3JlZyMjX0JBU0VfSURYXSArIAo+Pj4+PiByZWcpwqDC
oMKgwqAgXAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8PCBVVkRfRFBHX0xNQV9D
VExfX1JFQURfV1JJVEVfQUREUl9fU0hJRlQpIAo+Pj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNyYW1fc2VsIDw8IAo+Pj4+
PiBVVkRfRFBHX0xNQV9DVExfX1NSQU1fU0VMX19TSElGVCkpO8KgwqDCoMKgwqDCoMKgwqAgXAo+
Pj4+PiDCoMKgwqDCoMKgIH0gd2hpbGUgKDApCj4+Pj4+IEBAIC0xMTEsNyArMTExLDcgQEAKPj4+
Pj4gwqAgwqAgI2RlZmluZSBSUkVHMzJfU09DMTVfRFBHX01PREVfMl8wKGluc3RfaWR4LCBvZmZz
ZXQsIAo+Pj4+PiBtYXNrX2VuKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXAo+Pj4+PiDCoMKgwqDCoMKgICh7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+
Pj4+PiAtwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFZDTiwgaW5zdCwgCj4+Pj4+IG1tVVZE
X0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFZDTiwgaW5zdF9pZHgsIAo+Pj4+PiBt
bVVWRF9EUEdfTE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4MCA8PCBVVkRfRFBHX0xNQV9D
VExfX1JFQURfV1JJVEVfX1NISUZUIAo+Pj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFza19lbiA8PCBVVkRfRFBH
X0xNQV9DVExfX01BU0tfRU5fX1NISUZUIAo+Pj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0IDw8IAo+Pj4+
PiBVVkRfRFBHX0xNQV9DVExfX1JFQURfV1JJVEVfQUREUl9fU0hJRlQpKTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
