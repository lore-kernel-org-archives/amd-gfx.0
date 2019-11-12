Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0EC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E1121925
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E1121925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E566E52C;
	Tue, 12 Nov 2019 21:35:25 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720064.outbound.protection.outlook.com [40.107.72.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D458F6E52C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx6iCxIKuy4tAxGMiP9g033GMjmulB2bRzVoxqcwlyxVCGAms+Egb0XVu+mKIKtOoXHDMXdPNVheTfsNRoSoCNZLYB2geaArEIIQk2zqDsGv+bdYtT45+LF0yDFnvgXaGV4M1k50Gk8Ye4ZE9nJT5OI3Df4GmFyLiyCWikQN+oeL39kkPjuJ/blOYJwEKCUEV84yX6WLbXYUV/ji+6BfUbdXKkksdg4h6IB+X579+dh7ANHFmbZW7Der8xFQY3SSLpfyyFtZLuq8C9/fU7KCL8RVnNqnuQmuVEp7aCOqZZLa00++4vDSXW2o8ts03/7nb5w9CTEblXKmin+yW4Gkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maemd/x80lyzDOBr6XRzEOKJUo/XQU1bDucTSuU5Vwo=;
 b=bX4X9g+qZyXmCnjA2NQqXMzmPcYJTCi/lZ+mEuN2NVusf8H15c0B4OsuvF7x1g96JRwKyCjzpCtX8nf7iSYqvR68FbEl19V4ynyCTMUe88K855UzxBaV/6cw+T6a/yfheSwCWVdEjMVdyuF/ZIm5t0U8LNWJH2UiA3Nb8XNrS/Yv0YY5t9vK453VjNaRTYAQlMcLzJL5yURa3pjWigpucFtW9O4eH5QJmcZ5XjEsQ2A+PSfCGbZCRNEiRhkACD2aynNfPvzfzWkvL3jnhN4LiVo0yjhC74uOzHyHd0n/8DG2rHLzIA9L7VrVGClcwXMWVgP5XQJ2wGNtz4YhBvFOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB4250.namprd12.prod.outlook.com (10.141.186.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 21:35:23 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:35:23 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: Stop using GFP_NOIO explicitly for GFX10
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191112212641.4643-1-Yong.Zhao@amd.com>
 <20191112212641.4643-2-Yong.Zhao@amd.com>
 <4e5a3723-4b61-e76c-dc96-dafdec51f099@amd.com>
From: Yong Zhao <yong.zhao@amd.com>
Message-ID: <e585e540-5edf-52b1-4fcf-48f1e98a2dd2@amd.com>
Date: Tue, 12 Nov 2019 16:35:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <4e5a3723-4b61-e76c-dc96-dafdec51f099@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01b2d3d8-e7d9-4fa7-8adb-08d767b8397d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42504A4CB0E4A7F7D6B06E06F0770@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(65956001)(3846002)(66066001)(53546011)(99286004)(486006)(50466002)(386003)(31696002)(11346002)(7736002)(47776003)(44832011)(446003)(76176011)(26005)(6506007)(2906002)(2616005)(65806001)(36756003)(4001150100001)(25786009)(31686004)(6116002)(305945005)(86362001)(2870700001)(6436002)(66476007)(66556008)(476003)(14454004)(316002)(478600001)(8936002)(8676002)(6246003)(81166006)(81156014)(14444005)(186003)(5660300002)(66946007)(6486002)(6512007)(2486003)(58126008)(229853002)(23676004)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4250;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: II59MM1iTxnQAyaEF70Yx0V3elsxrszV6VdOebQ2sXoSYS6cXJygdSddYz/mX5jLDHq9B9RhhAHiCEah1xdhr6bxRFuvpVGncEAH8OKCkXpqMJ0wOTMBIpLUPIwmH18YoNw8lQWYEKP1aKP/5rHE93ejo476kOg+kim3dXTfPtcGxJWZo/Luy4E4hTz+orlf7Sfn3vxL8vasFXh7jBzZRIUcmQ2AtByi4nrlYvKdNit01eRmGv6sjpPrQGAtOasVUy+xWG03OacKYOufcHZTO5gwMgLNBJDBzCeHk6uQNSdUzgd9fvjjKCp9FNcvWhK75RIlhHIYsjjMGgY2dcC29Dt51h6MWm7MYE2Cv9E9jCza6n8PKhbC1DlzML15M6nCGY+UFg4xP9AKZUrYFob1sUVG2D5vR8w20yr9EdpLipd1g92maV8uxgvCAchG4Tqg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b2d3d8-e7d9-4fa7-8adb-08d767b8397d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:35:23.4315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCYqLZgR9zKNhYJ8ggN76AY41CCboSDaYoyUc9ruVkaPm3akbK9rpSv21nV5Kc4L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maemd/x80lyzDOBr6XRzEOKJUo/XQU1bDucTSuU5Vwo=;
 b=BAnPwQsdjBm3/qPXtMba/6O+TfBZVO1EnjmPgZIx/jvZi7TU2tzsn+aGUiVlEQUhtE7pVCGRHYaW/7+5uedBIRRu5qB3dX/L6Rs+pItFqhmqHn1VdqzVndDzuo2yf0vvYaL5uSNMPO2FlAz72znFpYJY4Wh5geXH2KgLgbNUhtY=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191112213521.fRcRUFjS8boW5qv2IQmZXm2vi8PPlfzdezZFuH7v9E0@z>

SGkgRmVsaXgsCgpTZWUgb25lIHRoaW5nIGlubGluZSBJIGFtIG5vdCB0b28gc3VyZS4KCllvbmcK
Ck9uIDIwMTktMTEtMTIgNDozMCBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBPbiAyMDE5
LTExLTEyIDQ6MjYgcC5tLiwgWW9uZyBaaGFvIHdyb3RlOgo+PiBBZGFwdCB0aGUgY2hhbmdlIGZy
b20gMWNkMTA2ZWNmYzFmMDQKPj4KPj4gVGhlIGNoYW5nZSBpczoKPj4KPj4gwqDCoMKgwqAgZHJt
L2FtZGtmZDogU3RvcCB1c2luZyBHRlBfTk9JTyBleHBsaWNpdGx5Cj4+Cj4+IMKgwqDCoMKgIFRo
aXMgaXMgbm8gbG9uZ2VyIG5lZWRlZCB3aXRoIHRoZSBtZW1hbGxvY19ub2ZzX3NhdmUvcmVzdG9y
ZSBpbgo+PiDCoMKgwqDCoCBkcW1fbG9jay91bmxvY2sKPj4KPj4gQ2hhbmdlLUlkOiBJNDI0NTBi
MmMxNDlkMmIxODQyYmU5OWE4ZjM1NWM4MjlhMDA3OWU3Ywo+PiBTaWduZWQtb2ZmLWJ5OiBZb25n
IFpoYW8gPFlvbmcuWmhhb0BhbWQuY29tPgo+Cj4gVGhlIHNlcmllcyBpcwo+Cj4gUmV2aWV3ZWQt
Ynk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Cj4KPj4gLS0tCj4+
IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDIg
Ky0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmPC
oCB8IDIgKy0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
bXFkX21hbmFnZXJfdjEwLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21x
ZF9tYW5hZ2VyX3YxMC5jCj4+IGluZGV4IDQ2ZGRiMzNiNjI0YS4uNTc5YzVmZmNmYTc5IDEwMDY0
NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEw
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Yx
MC5jCj4+IEBAIC0zOTMsNyArMzkzLDcgQEAgc3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdl
cl9pbml0X3YxMChlbnVtIAo+PiBLRkRfTVFEX1RZUEUgdHlwZSwKPj4gwqDCoMKgwqDCoCBpZiAo
V0FSTl9PTih0eXBlID49IEtGRF9NUURfVFlQRV9NQVgpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIE5VTEw7Cj4+IMKgIC3CoMKgwqAgbXFkID0ga3phbGxvYyhzaXplb2YoKm1xZCksIEdG
UF9OT0lPKTsKPj4gK8KgwqDCoCBtcWQgPSBremFsbG9jKHNpemVvZigqbXFkKSwgR0ZQX0tFUk5F
TCk7Cj4+IMKgwqDCoMKgwqAgaWYgKCFtcWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
TlVMTDsKPj4gwqAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9t
cWRfbWFuYWdlcl92OS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRf
bWFuYWdlcl92OS5jCj4+IGluZGV4IGJlMjdmZjAxY2RiOC4uMjJhODE5Yzg4OGQ4IDEwMDY0NAo+
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwo+
PiBAQCAtOTIsNyArOTIsNyBAQCBzdGF0aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9t
cWQoc3RydWN0IAo+PiBrZmRfZGV2ICprZmQsCj4+IMKgwqDCoMKgwqDCoCAqIGluc3RlYWQgb2Yg
c3ViLWFsbG9jYXRpb24gZnVuY3Rpb24uCj4+IMKgwqDCoMKgwqDCoCAqLwo+PiDCoMKgwqDCoMKg
IGlmIChrZmQtPmN3c3JfZW5hYmxlZCAmJiAocS0+dHlwZSA9PSBLRkRfUVVFVUVfVFlQRV9DT01Q
VVRFKSkgewo+PiAtwqDCoMKgwqDCoMKgwqAgbXFkX21lbV9vYmogPSBremFsbG9jKHNpemVvZihz
dHJ1Y3Qga2ZkX21lbV9vYmopLCBHRlBfTk9JTyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBtcWRfbWVt
X29iaiA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBrZmRfbWVtX29iaiksIEdGUF9LRVJORUwpOwpb
eXpdIFRoaXMgc2hvdWxkIGJlIGtlcHQgcHJvYmFibHkuIFdpdGggdGhlIGxhdGVzdCBjb2RlLCBh
bGxvY2F0ZV9tcWQoKSAKaXMgY2FsbGVkIG91dHNpZGUgb2YgdGhlIGRxbS4gU28gbm93IHRoZSBz
aXR1YXRpb24gaXMgZGlmZmVyZW50IGZyb20gdGhlIApvcmlnaW5hbCBvbmUuCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIW1xZF9tZW1fb2JqKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gTlVMTDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHZhbCA9IGFtZGdwdV9hbWRr
ZmRfYWxsb2NfZ3R0X21lbShrZmQtPmtnZCwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
