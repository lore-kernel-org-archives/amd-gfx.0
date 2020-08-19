Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108EC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63441206FA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kAQXXNnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63441206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C421C6E02F;
	Wed, 19 Aug 2020 13:09:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4446E02F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 13:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcnCINtMNA7X9fFD578aUrciegfi2c5lIn8iWrdbRvqB4Qy6pfOYPvaZW3wgJa3ZvI58iecroHBmE/lUZmuKIgsiMnb91MsfNx+NOaneyUDOSL2q5yB1dOY8a6cR0viM0bzm3rFchr1b+4lDHxDQMsVN7+lcwoSk8LgU9iDZXSRxINY/z8QDLhTLTx1eFGVJHmJbXzo7GOOP2cIb0iwmjaNV0UdY1urBt92Q7PU35fOkLWNfcExX1/GbmAhuJ6b70SSK5G6G+2WBLdjUO91jOOnvc871tpJZL0KBbAZ2Xzd93McF3MNjIoI2MzjKoDsluee/RZuR7SzSYeppJhjLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGOYZHRE86r+GZRhT/18fB17ZbwYkV7vORcMvULzfsY=;
 b=QGDIhFeOQQF91oukC5qFSvF1512UAeyh7RJSU/yNfiXDlM+c0tjFg9JsFGjH0DHdGFnY16aFZT6bjEYQBi7LwkmqPywduihmj83IQe4Ierz9wwJpCV76x9kpgKA9ew/rD2EXntdvTOK329zCljg3Dca/U2vMPTsqb9fVfAABRBHFnXa69y89STWFWutYE6jL7NlgDII9CP1hUbQe3wvZn7DPboeCz49aONxI8248dNZ4O8hXmrX/AAJsFWSus/GvzgFo8HlRqCcnHo068Ky1JLNxal9bFderpAwxAkxHplYBLK7ba8oPzU+ES6rs3v0vdXCJCodrK4m8CcbbtCyBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGOYZHRE86r+GZRhT/18fB17ZbwYkV7vORcMvULzfsY=;
 b=kAQXXNnHgWcrDgR4L6UdQTehD9T8SzOh4K+NAWr0tB+mxDenKXNmiekX9AVJW6p0U1tVH5kORsL5oNxNFsQyuZsC6A+vwUEH4eBoR+1nlKLQOWTCGD7/ZbNQNXMGVVWgOe6Yy1A5A0ILVXcKxqKytYWZaLsCJvL0uxmsha671Lw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 13:09:03 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 13:09:03 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
 <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
 <99ecca3a-c2bb-f11a-6786-e0dfb853ba88@amd.com>
 <451e4ec1-40a8-f00e-d4c7-cbb34927062c@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <0a707d0d-935e-464a-388a-e25c9c0c6c41@amd.com>
Date: Wed, 19 Aug 2020 18:38:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
In-Reply-To: <451e4ec1-40a8-f00e-d4c7-cbb34927062c@amd.com>
Content-Language: en-US
X-ClientProxiedBy: MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::13) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.110.102) by
 MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 13:09:02 +0000
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 004a52ca-4abd-40a1-33fd-08d844410bb9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB38767DB6787EB44AEB1019C7F25D0@BY5PR12MB3876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrOM5USfzeh1JhbZ8DKfuGnBmZ0gBDjp6Je6bpR5mr4rPDihDjrc+8uJkznTIlaMapsaZIQsHs9MjW39NMlaC7Oj+9cgOmBQKIPsKWoXkEbm6bxR1/LyZZq81/QnfPRZXN/jaS23LjHrDCYYSco4PR4q1XPFC5xzCMZlum9byo2gsUk73p3Y4YcFQ1N+H3ivwzXOc3VY4/3W+tbhsbi95AE1+et7qxtcOt6lS0CJ4PdpTDyUq4sQX3t9078KbDEh66tBfh/sRe1IBpzC9LiSRvZrmbfma2/sk/k4eKqipznTkd/BZKLYtwCoBwB3gUX4Q9Y5frYKygBN3LipjwtgNW3PkFvZnKadK2s5wkZD/ar8/PoHlkMeW6GZ9PfcizxoXhLVfdfLwR0otsF0PqaBlnWoJq/eJUYjrx9ezIAOWKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(52116002)(53546011)(55236004)(66946007)(66556008)(66476007)(966005)(186003)(478600001)(16526019)(6486002)(2906002)(16576012)(5660300002)(31696002)(26005)(316002)(86362001)(4326008)(83380400001)(66574015)(15650500001)(6666004)(1006002)(956004)(2616005)(36756003)(8936002)(31686004)(45080400002)(44832011)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2hFKLzEGCWxpoO07UaxK/9vUgH+GyH1cFqR//eQLBCrz1kQan92sALiJ7YTrU2872GaBtnVkQTtiV8f2s3Un6gsrcJecslRl2VaumPKR1W9aD9rt04G9fBUNI5Yh7vHnGMaKfMBjCGAPWPxwK9ntA0Rgcu0o8a5TDomw1RPTffePPviKqoxz8QmtuQzSCtqRBL5lePIXhWUoFNrjNsqT+HNU6At79tUhzckZbB/F2CpssbW3LwZ0tQ6HoKDTmc04DK79esKwkcV0oDs6BUQHymFxhe0ciJ2u0n0FOtDD58S6kPHR7wj5XFYzs+TmTJjIl+22lGxG3p4lTiLFePL7A5rkrX9Px4Eyrd6hNhR2W+QVQJs25ydTivdEqRezTbZip9EX2513PyvcuCAfknrfwVRwuQukZoipRSA2sZQgEYoQ7gYDqoBIM1YNSwBFpfcrsCEw9e7YpasQn7yz6CeTGVMUPh3J3t9xXvI5/JEpAQwwyjQ+dgQK5rOragBdcTiU2AXK+r+eWlCg9oTMCa1elnu4QpNYLiUDLpOLwalMBW+W+Ctq4HnUPGQ0/75ASLbzGdqgQsf23425BibJ675wsoLRjRR5EiPxFOItb99dLD+vKrcJpj0e6YO9TGqAZFkuIPPCttkT4bvHc1rBeCgvgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004a52ca-4abd-40a1-33fd-08d844410bb9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 13:09:03.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9k0xnTy0BPyzkmU9vCCdx0NO0+mX9RsbXIwnLbJOg1NZnb6Hsc1YFh5iAGiQzw552uzQ/bljtJmKmoCG1eKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDE5LzA4LzIwIDY6MzQgcG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTkuMDgu
MjAgdW0gMTQ6Mzcgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+IE9uIDE5LzA4LzIwIDY6MDMg
cG0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxOS4wOC4yMCB1bSAxNDoxOSBzY2hy
aWViIFNoYXNoYW5rIFNoYXJtYToKPj4+PiBPbiAxOS8wOC8yMCA1OjM4IHBtLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+Pj4+PiBBbSAxOS4wOC4yMCB1bSAxMzo1MiBzY2hyaWViIFNoYXNoYW5r
IFNoYXJtYToKPj4+Pj4+IE9uIDEzLzA4LzIwIDE6MjggcG0sIENocmlzdGlhbiBLw7ZuaWcgd3Jv
dGU6Cj4+Pj4+Pj4gQW0gMTMuMDguMjAgdW0gMDU6MDQgc2NocmllYiBTaGFzaGFuayBTaGFybWE6
Cj4+Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyB0cmFjZSBldmVudCB0byB0cmFjayB0aGUg
UFRFIHVwZGF0ZQo+Pj4+Pj4+PiBldmVudHMuIFRoaXMgc3BlY2lmaWMgZXZlbnQgd2lsbCBwcm92
aWRlIGluZm9ybWF0aW9uIGxpa2U6Cj4+Pj4+Pj4+IC0gc3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFs
IG1lbW9yeSBtYXBwaW5nCj4+Pj4+Pj4+IC0gSFcgZW5naW5lIGZsYWdzIGZvciB0aGUgbWFwCj4+
Pj4+Pj4+IC0gcGh5c2ljYWwgYWRkcmVzcyBmb3IgbWFwcGluZwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBU
aGlzIHdpbGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHByb2ZpbGluZyB0b29s
cwo+Pj4+Pj4+PiAobGlrZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRhYmxl
IHVwZGF0ZSBldmVudHMuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IFYyOiBBZGRlZCBwaHlzaWNhbCBhZGRy
ZXNzIGxvb2t1cCBsb2dpYyBpbiB0cmFjZSBwb2ludAo+Pj4+Pj4+PiBWMzogc3dpdGNoIHRvIHVz
ZSBfX2R5bmFtaWNfYXJyYXkKPj4+Pj4+Pj4gICAgICAgICBhZGRlZCBucHRlcyBpbnQgdGhlIFRQ
cHJpbnQgYXJndW1lbnRzIGxpc3QKPj4+Pj4+Pj4gICAgICAgICBhZGRlZCBwYWdlIHNpemUgaW4g
dGhlIGFyZyBsaXN0Cj4+Pj4+Pj4+IFY0OiBBZGRyZXNzZWQgQ2hyaXN0aWFuJ3MgcmV2aWV3IGNv
bW1lbnRzCj4+Pj4+Pj4+ICAgICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+Pj4+
Pj4+PiAgICAgICAgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBiZSBhY2N1cmF0ZQo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+Pj4+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8
c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+PiAgICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIHwgMzcgKysrKysrKysrKysrKysr
KysrKysrKysKPj4+Pj4+Pj4gICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyAgICB8ICA5ICsrKystLQo+Pj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKPj4+Pj4+Pj4gaW5kZXggNjNlNzM0YTEyNWZi
Li5kZjEyY2Y4NDY2YzIgMTAwNjQ0Cj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+Pj4+IEBAIC0zMjEsNiArMzIxLDQzIEBAIERFRklO
RV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywgYW1kZ3B1X3ZtX2JvX2NzLAo+Pj4+Pj4+PiAgICAg
IAkgICAgVFBfQVJHUyhtYXBwaW5nKQo+Pj4+Pj4+PiAgICAgICk7Cj4+Pj4+Pj4+ICAgICAgCj4+
Pj4+Pj4+ICtUUkFDRV9FVkVOVChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCj4+Pj4+Pj4+ICsJICAg
IFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcCwKPj4+Pj4+Pj4gKwkJ
ICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAo+Pj4+Pj4+PiArCQkgICAgIHVuc2ln
bmVkIGludCBucHRlcywgdWludDY0X3QgZHN0LAo+Pj4+Pj4+PiArCQkgICAgIHVpbnQ2NF90IGlu
Y3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4+Pj4+Pj4gKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5w
dGVzLCBkc3QsIGluY3IsIGZsYWdzKSwKPj4+Pj4+Pj4gKwlUUF9TVFJVQ1RfX2VudHJ5KAo+Pj4+
Pj4+PiArCQkJIF9fZmllbGQodTY0LCBzdGFydCkKPj4+Pj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwg
ZW5kKQo+Pj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBmbGFncykKPj4+Pj4+Pj4gKwkJCSBfX2Zp
ZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCj4+Pj4+Pj4+ICsJCQkgX19maWVsZCh1NjQsIGluY3Ip
Cj4+Pj4+Pj4+ICsJCQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0LCBucHRlcykKPj4+Pj4+PiBB
cyBkaXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVtIG1haW50YWluZXIgd2UgbmVlZCB0
byBhZGQgdGhlIHBpZAo+Pj4+Pj4+IGFuZCBwcm9iYWJseSB0aGUgVk0gY29udGV4dCBJRCB3ZSB1
c2UgaGVyZSB0byBpZGVudGlmeSB0aGUgdXBkYXRlZCBWTS4KPj4+Pj4+Pgo+Pj4+Pj4+IENocmlz
dGlhbi4KPj4+Pj4+IEkgcHJpbnRlZCBib3RoIHZtLT50YXNrX2luZm8ucGlkIFZzIGN1cnJlbnQt
PnBpZCBmb3IgdGVzdGluZywgYW5kIEkgY2FuIHNlZSBkaWZmZXJlbnQgdmFsdWVzIGNvbWluZyBv
dXQgb2YgLgo+Pj4+Pj4KPj4+Pj4+IGdub21lLXNoZWxsLTIxMTTCoCBbMDExXcKgwqDCoCA0MS44
MTI4OTQ6IGFtZGdwdV92bV91cGRhdGVfcHRlczogc3RhcnQ6MHgwODAwMTAyZTgwIGVuZDoweDA4
MDAxMDJlODIsIGZsYWdzOjB4ODAsIGluY3I6NDA5NiwgcGlkPTIxMjggdm1pZD0wIGNwaWQ9MjEx
NAo+Pj4+Pj4KPj4+Pj4+IHBpZCBpcyB2bS0+dGFza19pbmZvLnBpZD0yMTI4IHdoZXJlYXMgY3Bp
ZD0yMTE0IGlzIGN1cnJlbnQucGlkLgo+Pj4+Pj4KPj4+Pj4+IFdoaWNoIGlzIHRoZSBvbmUgd2Ug
d2FudCB0byBzZW5kIHdpdGggdGhlIGV2ZW50ID8KPj4+Pj4gVGhhdCBpcyB2bS0+dGFza19pbmZv
LnBpZCwgc2luY2UgdGhpcyBpcyB0aGUgUElEIHdoaWNoIGlzIHVzaW5nIHRoZSBWTQo+Pj4+PiBm
b3IgY29tbWFuZCBzdWJtaXNzaW9uLgo+Pj4+IGdvdCBpdC4KPj4+Pj4+IFRyYWNlIGV2ZW50IGJ5
IGRlZmF1bHQgc2VlbXMgdG8gYmUgYWRkaW5nIHRoZSBwcm9jZXNzIG5hbWUgYW5kIGlkIGF0IHRo
ZSBoZWFkZXIgb2YgdGhlIGV2ZW50IChnbm9tZS1zaGVsbC0yMTE0KSwgd2hpY2ggaXMgc2FtZSBh
cyBjdXJyZW50LnBpZAo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBBbHNvLCBpcyBpdCBvayB0byBleHRy
YWN0IHZtaWQgZnJvbSBqb2ItPnZtaWQgPwo+Pj4+PiBPbmx5IGluIHRyYWNlX2FtZGdwdV92bV9n
cmFiX2lkKCksIGluIGFsbCBvdGhlciBjYXNlcyBpdCdzIHByb2JhYmx5IG5vdAo+Pj4+PiBhc3Np
Z25lZCB5ZXQuCj4+Pj4gT2ssIGxldCBtZSBjaGVjayBob3cgY2FuIHdlIGdldCB2bWlkIGZyb20g
dGhpcyBjb250ZXh0IHdlIGFyZSBzZW5kaW5nIHRoZSBldmVudCBmcm9tLiBPciBtYXliZSBJIHdl
IHNob3VsZMKgIGtlZXAgVjUgd2l0aCBwaWQgb25seSwgYW5kIGxhdGVyIHNlbmQgYSBzZXBhcmF0
ZSBwYXRjaCB0byBhZGQgdm1pZCA/Cj4+PiBJJ20gbm90IHN1cmUgaG93IHlvdSB3YW50IHRvIGdl
dCBhIFZNSUQgaW4gdGhlIGZpcnN0IHBsYWNlLiBXZQo+Pj4gZHluYW1pY2FsbHkgYXNzaWduIFZN
SURzIGR1cmluZyBjb21tYW5kIHN1Ym1pc3Npb24uCj4+Pgo+Pj4gU2VlIHRoZSBhbWRncHVfdm1f
Z3JhYl9pZCB0cmFjZSBwb2ludC4KPj4gQWN0dWFsbHkgSSB3YXMgYWRkaW5nIHZtaWQgdG8gYWRk
cmVzcyB0aGlzIGxhc3QgY29tbWVudCBvbiBWNDoKPj4+IGFuZCBwcm9iYWJseSB0aGUgVk0gY29u
dGV4dCBJRCB3ZSB1c2UgaGVyZSB0byBpZGVudGlmeSB0aGUgdXBkYXRlZCBWTS4KPj4gSSBhc3N1
bWVkIHlvdSBtZWFudCB0aGUgdm1pZCBieSB0aGlzLCBpcyB0aGF0IG5vdCBzbyA/Cj4gQWghIE5v
IHRoYXQncyBzb21ldGhpbmcgY29tcGxldGVseSBkaWZmZXJlbnQgOikKPgo+IFRoZSBWTUlEIGlz
IGEgNGJpdCBoYXJkd2FyZSBpZGVudGlmaWVyIHVzZWQgZm9yIFRMQiBvcHRpbWl6YXRpb24uCj4K
PiBUaGUgVk0gY29udGV4dCBJRCBpcyBhbiB1bmlxdWUgNjRiaXQgbnVtYmVyLCB3ZSB1c3VhbGx5
IHVzZSAKPiB2bS0+aW1tZWRpYXRlLmZlbmNlX2NvbnRleHQgZm9yIHRoaXMuCgpEYW1uLCB3aHkg
aXMgaXQgbmV2ZXIgd2hhdCB5b3UgaG9wZSBpdCB0byBiZSA6KS4gVGhhbmtzIGZvciB0aGlzIGlu
Zm9ybWF0aW9uLCBJIHdpbGwgY2hlY2sgdGhpcyBvdXQgZmlyc3QuCgotIFNoYXNoYW5rCgo+IFJl
Z2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMKPj4KPj4gU2hhc2hhbmsKPj4KPj4+
IENocmlzdGlhbi4KPj4+Cj4+Pj4gLSBTaGFzaGFuawo+Pj4+Cj4+Pj4+IENocmlzdGlhbi4KPj4+
Pj4KPj4+Pj4+IFJlZ2FyZHMKPj4+Pj4+Cj4+Pj4+PiBTaGFzaGFuawo+Pj4+Pj4KPj4+Pj4+Pj4g
KwkpLAo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICsJVFBfZmFzdF9hc3NpZ24oCj4+Pj4+Pj4+ICsJCQl1
bnNpZ25lZCBpbnQgaTsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArCQkJX19lbnRyeS0+c3RhcnQgPSBz
dGFydDsKPj4+Pj4+Pj4gKwkJCV9fZW50cnktPmVuZCA9IGVuZDsKPj4+Pj4+Pj4gKwkJCV9fZW50
cnktPmZsYWdzID0gZmxhZ3M7Cj4+Pj4+Pj4+ICsJCQlfX2VudHJ5LT5pbmNyID0gaW5jcjsKPj4+
Pj4+Pj4gKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7Cj4+Pj4+Pj4+ICsJCQlmb3IgKGkgPSAw
OyBpIDwgbnB0ZXM7ICsraSkgewo+Pj4+Pj4+PiArCQkJCXU2NCBhZGRyID0gcC0+cGFnZXNfYWRk
ciA/IGFtZGdwdV92bV9tYXBfZ2FydCgKPj4+Pj4+Pj4gKwkJCQkJcC0+cGFnZXNfYWRkciwgZHN0
KSA6IGRzdDsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArCQkJCSgodTY0ICopX19nZXRfZHluYW1pY19h
cnJheShkc3QpKVtpXSA9IGFkZHI7Cj4+Pj4+Pj4+ICsJCQkJZHN0ICs9IGluY3I7Cj4+Pj4+Pj4+
ICsJCQl9Cj4+Pj4+Pj4+ICsJKSwKPj4+Pj4+Pj4gKwlUUF9wcmludGsoInN0YXJ0OjB4JTAxMGxs
eCBlbmQ6MHglMDEwbGx4LCBmbGFnczoweCVsbHgsIGluY3I6JWxsdSwiCj4+Pj4+Pj4+ICsJCSAg
IiBkc3Q6XG4lcyIsIF9fZW50cnktPnN0YXJ0LCBfX2VudHJ5LT5lbmQsIF9fZW50cnktPmZsYWdz
LAo+Pj4+Pj4+PiArCQkgIF9fZW50cnktPmluY3IsIF9fcHJpbnRfYXJyYXkoCj4+Pj4+Pj4+ICsJ
CSAgX19nZXRfZHluYW1pY19hcnJheShkc3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpCj4+Pj4+Pj4+
ICspOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICAgICAgVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3NldF9w
dGVzLAo+Pj4+Pj4+PiAgICAgIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFk
ZHIsIHVuc2lnbmVkIGNvdW50LAo+Pj4+Pj4+PiAgICAgIAkJICAgICB1aW50MzJfdCBpbmNyLCB1
aW50NjRfdCBmbGFncywgYm9vbCBkaXJlY3QpLAo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+Pj4+Pj4+PiBpbmRleCA3MWUwMDVjZjI5NTIuLmI1ZGJiNWU4YmM2
MSAxMDA2NDQKPj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKPj4+Pj4+Pj4gQEAgLTE1MTMsMTcgKzE1MTMsMjIgQEAgc3RhdGljIGludCBhbWRncHVfdm1f
dXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4+Pj4+
Pj4+ICAgICAgCQlkbyB7Cj4+Pj4+Pj4+ICAgICAgCQkJdWludDY0X3QgdXBkX2VuZCA9IG1pbihl
bnRyeV9lbmQsIGZyYWdfZW5kKTsKPj4+Pj4+Pj4gICAgICAJCQl1bnNpZ25lZCBucHRlcyA9ICh1
cGRfZW5kIC0gZnJhZ19zdGFydCkgPj4gc2hpZnQ7Cj4+Pj4+Pj4+ICsJCQl1aW50NjRfdCB1cGRf
ZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVfRlJBRyhmcmFnKTsKPj4+Pj4+Pj4gICAgICAKPj4+
Pj4+Pj4gICAgICAJCQkvKiBUaGlzIGNhbiBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVyIGxldmVs
IFBEcyB0bwo+Pj4+Pj4+PiAgICAgIAkJCSAqIHNpbGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4K
Pj4+Pj4+Pj4gICAgICAJCQkgKi8KPj4+Pj4+Pj4gICAgICAJCQlucHRlcyA9IG1heChucHRlcywg
MXUpOwo+Pj4+Pj4+PiArCj4+Pj4+Pj4+ICsJCQl0cmFjZV9hbWRncHVfdm1fdXBkYXRlX3B0ZXMo
cGFyYW1zLCBmcmFnX3N0YXJ0LCB1cGRfZW5kLAo+Pj4+Pj4+PiArCQkJCQkJICAgIG5wdGVzLCBk
c3QsIGluY3IsCj4+Pj4+Pj4+ICsJCQkJCQkgICAgdXBkX2ZsYWdzKTsKPj4+Pj4+Pj4gICAgICAJ
CQlhbWRncHVfdm1fdXBkYXRlX2ZsYWdzKHBhcmFtcywgcHQsIGN1cnNvci5sZXZlbCwKPj4+Pj4+
Pj4gICAgICAJCQkJCSAgICAgICBwZV9zdGFydCwgZHN0LCBucHRlcywgaW5jciwKPj4+Pj4+Pj4g
LQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsKPj4+Pj4+Pj4gKwkJ
CQkJICAgICAgIHVwZF9mbGFncyk7Cj4+Pj4+Pj4+ICAgICAgCj4+Pj4+Pj4+ICAgICAgCQkJcGVf
c3RhcnQgKz0gbnB0ZXMgKiA4Owo+Pj4+Pj4+PiAtCQkJZHN0ICs9ICh1aW50NjRfdClucHRlcyAq
IEFNREdQVV9HUFVfUEFHRV9TSVpFIDw8IHNoaWZ0Owo+Pj4+Pj4+PiArCQkJZHN0ICs9IG5wdGVz
ICogaW5jcjsKPj4+Pj4+Pj4gICAgICAKPj4+Pj4+Pj4gICAgICAJCQlmcmFnX3N0YXJ0ID0gdXBk
X2VuZDsKPj4+Pj4+Pj4gICAgICAJCQlpZiAoZnJhZ19zdGFydCA+PSBmcmFnX2VuZCkgewo+Pj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+Pj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+
IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFt
ZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3NoYXNoYW5rLnNoYXJtYSU0MGFtZC5jb20lN0MyOTRj
MGNmMDQ2MDg0Nzk1M2U4MzA4ZDg0NDNjMTYzYyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5
NGUxODNkJTdDMCU3QzAlN0M2MzczMzQzNzIxNDcxNTY2NzQmYW1wO3NkYXRhPTNzV1pjdUxjV1ZU
Y3NweGhScTZnVDFTTSUyQnZIUUNySnFtSmlqS2dSRWtzMCUzRCZhbXA7cmVzZXJ2ZWQ9MApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
