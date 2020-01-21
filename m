Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85536C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5503121734
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SVluBm8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5503121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2036E271;
	Tue, 21 Jan 2020 20:58:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770049.outbound.protection.outlook.com [40.107.77.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088256E271
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 20:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAtXt+jaefoLhBJwzgC3VDHY6koeU1ymj6bllJmjuLM/DdkMoZGr2zKDvmqnpac6gcnGUcvjYE3ViGKLiCOeNm9fzFIhUnFWLiYwD9MkA9FzqpdYzyKOo4VACPCct8VAqNZz5nk28W+Arfr2xtvWvUtsJKilH3CHNChxWyNaa/xA3MXG5U8fQobgJss10OreJBiNBrTkiiju6AAKuXUP5aC0umnKkKbIy3C6OnW4V0K64Co3RLaGQ3aGhtNGvjS1A4k4Sb28H6yOHQXk0OKZC9traqfkxswwWmDIEohLyrZwFTG+TssFPSzCUqdX95V6hV2z9UOMEcHE0YfMxrXiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjCluiRoQkgQh5te8QXPCDlScwqycOGcXSx9WIcQlqk=;
 b=ehENnFfg5xzip1qKBZ0n2Pf3PBs/BD8WVWV7NX5oO0bwbH8jR2C+oht3rr4Cf3rm4DMim4pOp+0/D6EP8u0QDW4hAoiZo9ec6fE+cEOO28HA4/VGw+dIc7pci1LM6CLYksPJawmRQdu0C0nQi6kzCfX893BALTnlqxLuiFlxDfaMK0xmhfrJHw/WRNFiQVEue9xA1kx9HjAs5lJhWViG8LP0giqp0QAfvoHlT6xzbvViUnE7/wRAbV1PcujNhCgZ0K1Gs+zcXIomtT38J+pxtZDH681ZAZ+8/buKRTFZ0mv/PMnjc9DGrvj4x5ZZ6j1BR7ducrG1V5W35jQ5AUMAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjCluiRoQkgQh5te8QXPCDlScwqycOGcXSx9WIcQlqk=;
 b=SVluBm8y6z8xHeZp6NvM7XbySBxeR4PR1HRmgJhxU3zr07MJTmOXBzjOt1mjEdTFwdjkxLSvrCtxRIYMtOzzMAaySNPDVAkXQfKJPaqXowvF9Mdj4UnlNacwnKicMxoyezyLbvEbCXJreQiFlFsfzOC/h0h0Mz/L0fx7Rd2+Z1M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2981.namprd12.prod.outlook.com (20.178.55.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 20:58:11 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 20:58:11 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn: use inst_idx relacing inst
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
 <67ae3044-0701-1e76-e5ef-683222b4f458@amd.com>
 <cd7c56b2-6c0a-a594-1970-ce9849c7c17d@amd.com>
 <18b47160-2b45-b313-42be-a35dc88fa68f@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <f9803f06-7526-4fbd-5bdb-53e4cd4601d5@amd.com>
Date: Tue, 21 Jan 2020 15:58:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <18b47160-2b45-b313-42be-a35dc88fa68f@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::17) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 20:58:10 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df878756-ff28-42eb-661a-08d79eb4a015
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:|BYAPR12MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981624154C7C5C538E58CB9E40D0@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(189003)(199004)(26005)(186003)(66556008)(66476007)(16526019)(6486002)(31686004)(31696002)(5660300002)(66946007)(53546011)(2906002)(2616005)(956004)(316002)(16576012)(110136005)(81166006)(52116002)(81156014)(8676002)(36916002)(36756003)(478600001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2981;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: abH1TjLnBmYu/NgI29nt28RnsCxXXWUH2TG628r72myDH9CJeRqLuYREpzF7WLp64/gJf0VlJtykC7YFyHUekwpwSNlqKdNmarD9U7f2aTHI6LBW9K4oM/h3UB2kQb4AAZH5w6LCNYBsHTvCuXo91mpf86m+7ULyxfWtKWGVS6Bkw9hf1Vd9PauJQ4cbfgwLL/E+zCnoBwGrGZNPRq0StoF2ahKd4/CO84KBwxkgpSb2TN8gazKibArqF0knR4YWgYReDq5EP3mm/q4gx4SuCG/GeM6AtDeblJewSvBc+LLiCVnfTpUor4pspt9i/PYpKkK9LKmW3QIHjjVvJ1B1ntxA1pfjMuzs6gaO758+v/qVRIJveg2IA6OCiD3VROkEmUw+7n1Mc2H85LfE6hyJ6y3ahv3yp9srqYY+WECanL8EfpPp4ilbidrzRySpSa/b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df878756-ff28-42eb-661a-08d79eb4a015
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 20:58:11.5342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyG8dj3fFVwU9icNRfMmxe5Cf2j7uRZlzFyKxKebQlwnNUAJ6AA7lT3qKz+6tV54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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

QWN0dWFsbHkgUlJFRzMyX1NPQzE1X0RQR19NT0RFXzJfMCBoYXMgYSBidWcgaW5zaWRlIHRvIG1p
c3MgdXNpbmcgaW5zdCAKYXMgaW5zdF9pZHgsCgpTbyBJIHdhbnQgdG8gY2xlYW4gdXAgdGhlIGhl
YWRlciBmaXJzdCB0byB1c2UgaW5zdF9pZHggZm9yIGFiYnJldmlhdGlvbiAKb2YgaW5zdGFuY2Ug
aW5kZXguCgpKYW1lcwoKT24gMjAyMC0wMS0yMSAzOjMwIHAubS4sIExlbyBMaXUgd3JvdGU6Cj4K
PiBPbiAyMDIwLTAxLTIxIDEyOjUwIHAubS4sIEphbWVzIFpodSB3cm90ZToKPj4KPj4gT24gMjAy
MC0wMS0yMSAxMjo0MyBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjAtMDEtMjEg
MTE6MTkgYS5tLiwgSmFtZXMgWmh1IHdyb3RlOgo+Pj4+IFVzZSBpbnN0X2lkeCByZWxhY2luZyBp
bnN0IGluIFNPQzE1X0RQR19NT0RFIG1hY3JvCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1l
cyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaCB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0KPj4+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4+
Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zj
bi5oIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+Pj4g
aW5kZXggNjBmZTNjNC4uOThjMTg5MyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmgKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmgKPj4+PiBAQCAtNjUsMjMgKzY1LDIzIEBACj4+Pj4gwqAgLyogMSBz
ZWNvbmQgdGltZW91dCAqLwo+Pj4+IMKgICNkZWZpbmUgVkNOX0lETEVfVElNRU9VVMKgwqDCoCBt
c2Vjc190b19qaWZmaWVzKDEwMDApCj4+Pj4gwqAgLSNkZWZpbmUgUlJFRzMyX1NPQzE1X0RQR19N
T0RFKGlwLCBpbnN0LCByZWcsIG1hc2ssIAo+Pj4+IHNyYW1fc2VsKcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFwKPj4+PiAtwqDCoMKgICh7wqDCoMKgIFdSRUczMl9TT0MxNShpcCwg
aW5zdCwgbW1VVkRfRFBHX0xNQV9NQVNLLCAKPj4+PiBtYXNrKTvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXAo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3QsIG1tVVZE
X0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+PiArI2Rl
ZmluZSBSUkVHMzJfU09DMTVfRFBHX01PREUoaXAsIGluc3RfaWR4LCByZWcsIG1hc2ssIAo+Pj4+
IHNyYW1fc2VsKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4gK8KgwqDCoCAoe8KgwqDC
oCBXUkVHMzJfU09DMTUoaXAsIGluc3RfaWR4LCBtbVVWRF9EUEdfTE1BX01BU0ssIAo+Pj4+IG1h
c2spO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIFdSRUcz
Ml9TT0MxNShpcCwgaW5zdF9pZHgsIAo+Pj4+IG1tVVZEX0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+Cj4+PiBJIGhhdmUgb25seSBzZWVuIHlvdSBhcmUg
dXNpbmcgaW5zdF9pZHggdG8gcmVwbGFjZSBpbnN0LCBoYXZuJ3QgeW91PyAKPj4+IHRoaXMgaXMg
bm90IG5lY2Vzc2FyeSwgYmVjYXVzZSB3ZSBhcmUgdXNpbmcgaW5zdCBhcyB0aGUgaWR4Lgo+Pgo+
PiBTaW5jZSB3ZSB1c2UgaW5zdCBmb3IgaW5zdGFuY2UgaW4gc3RydWN0IGFtZGdwdV92Y24uIFRv
IGF2b2lkIAo+PiBjb25mdXNpbmcsIEkgY3JlYXRlIHRoaXMgcGF0Y2gsCj4KPiBJZiBvbmx5IHZh
cmlhYmxlIG5hbWUgY2hhbmdlcywgcGxlYXNlIGRyb3AgdGhlc2UgcGF0Y2gsIHdlIGFyZSB1c2lu
ZyAKPiBpbnN0IGFsbCB0aGUgcGxhY2VzLgo+Cj4gTGVvCj4KPgo+Cj4KPj4KPj4gSmFtZXMKPj4K
Pj4+Cj4+PiBMZW8KPj4+Cj4+Pgo+Pj4KPj4+PiBVVkRfRFBHX0xNQV9DVExfX01BU0tfRU5fTUFT
SyB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4+IC0gKChhZGV2LT5yZWdf
b2Zmc2V0W2lwIyNfSFdJUF1baW5zdF1bcmVnIyNfQkFTRV9JRFhdICsgcmVnKcKgwqDCoMKgIFwK
Pj4+PiArICgoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3RfaWR4XVtyZWcjI19CQVNF
X0lEWF0gKyByZWcpwqDCoMKgwqAgXAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDw8
IFVWRF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9BRERSX19TSElGVCkgCj4+Pj4gfMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNyYW1f
c2VsIDw8IAo+Pj4+IFVWRF9EUEdfTE1BX0NUTF9fU1JBTV9TRUxfX1NISUZUKSk7wqDCoMKgwqDC
oMKgwqDCoCBcCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShpcCwgaW5zdCwgbW1V
VkRfRFBHX0xNQV9EQVRBKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFf
REFUQSk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+PiDCoMKgwqDCoMKgIH0pCj4+Pj4g
wqAgLSNkZWZpbmUgV1JFRzMyX1NPQzE1X0RQR19NT0RFKGlwLCBpbnN0LCByZWcsIHZhbHVlLCBt
YXNrLCAKPj4+PiBzcmFtX3NlbCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4+ICsjZGVm
aW5lIFdSRUczMl9TT0MxNV9EUEdfTU9ERShpcCwgaW5zdF9pZHgsIHJlZywgdmFsdWUsIG1hc2ss
IAo+Pj4+IHNyYW1fc2VsKcKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4+IMKgwqDCoMKgwqAgZG8ge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+PiAtwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1
KGlwLCBpbnN0LCBtbVVWRF9EUEdfTE1BX0RBVEEsIAo+Pj4+IHZhbHVlKTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgXAo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoaXAsIGluc3Qs
IG1tVVZEX0RQR19MTUFfTUFTSywgCj4+Pj4gbWFzayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPj4+PiAtwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KGlwLCBpbnN0LCBtbVVWRF9EUEdf
TE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFfREFUQSwgCj4+
Pj4gdmFsdWUpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+Pj4gK8KgwqDCoMKgwqDCoMKg
IFdSRUczMl9TT0MxNShpcCwgaW5zdF9pZHgsIG1tVVZEX0RQR19MTUFfTUFTSywgCj4+Pj4gbWFz
ayk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMy
X1NPQzE1KGlwLCBpbnN0X2lkeCwgCj4+Pj4gbW1VVkRfRFBHX0xNQV9DVEwswqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVW
RF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9NQVNLIHwgXAo+Pj4+IC0gKChhZGV2LT5yZWdfb2Zm
c2V0W2lwIyNfSFdJUF1baW5zdF1bcmVnIyNfQkFTRV9JRFhdICsgcmVnKcKgwqDCoMKgIFwKPj4+
PiArICgoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3RfaWR4XVtyZWcjI19CQVNFX0lE
WF0gKyByZWcpwqDCoMKgwqAgXAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDw8IFVW
RF9EUEdfTE1BX0NUTF9fUkVBRF9XUklURV9BRERSX19TSElGVCkgCj4+Pj4gfMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNyYW1fc2Vs
IDw8IAo+Pj4+IFVWRF9EUEdfTE1BX0NUTF9fU1JBTV9TRUxfX1NISUZUKSk7wqDCoMKgwqDCoMKg
wqDCoCBcCj4+Pj4gwqDCoMKgwqDCoCB9IHdoaWxlICgwKQo+Pj4+IEBAIC0xMTEsNyArMTExLDcg
QEAKPj4+PiDCoCDCoCAjZGVmaW5lIFJSRUczMl9TT0MxNV9EUEdfTU9ERV8yXzAoaW5zdF9pZHgs
IG9mZnNldCwgCj4+Pj4gbWFza19lbinCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFwKPj4+PiDCoMKgwqDCoMKgICh7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XAo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoVkNOLCBpbnN0LCAKPj4+PiBtbVVW
RF9EUEdfTE1BX0NUTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwK
Pj4+PiArwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1NPQzE1KFZDTiwgaW5zdF9pZHgsIAo+Pj4+IG1t
VVZEX0RQR19MTUFfQ1RMLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
XAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgweDAgPDwgVVZEX0RQR19MTUFfQ1RM
X19SRUFEX1dSSVRFX19TSElGVCAKPj4+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXNrX2VuIDw8IFVWRF9EUEdfTE1B
X0NUTF9fTUFTS19FTl9fU0hJRlQgCj4+Pj4gfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBcCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0IDw8IAo+Pj4+IFVWRF9E
UEdfTE1BX0NUTF9fUkVBRF9XUklURV9BRERSX19TSElGVCkpO8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgXApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
