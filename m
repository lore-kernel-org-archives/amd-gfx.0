Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FEBC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D6624655
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uUY7p9sU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D6624655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93896E4A2;
	Tue, 21 Jan 2020 20:49:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760072.outbound.protection.outlook.com [40.107.76.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64C5A6EE89
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 20:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqcmKY9ZHqYfcuP2EkM/Yhm+83+ec7lTl9zlqKyX2pHRrCYVit3ZPhDL+ECPtQSK3aCM3daET49m2aWivsevCbS3TeFc9KkFezoz+tsjuokSVsd8baCtJN2WZqiumtdAKvKJFiBpUF6m32r7yXmVUvx2s3ojoHfhZ2p1rdq8tHt0rvm1vFD6FzEF2FeGyOEAR4FEC2C8ta2374OuzH5nZcdQi4PNU+2UIy1HyP6UXK3gtmPWahuaBTQNnf4leHTxoZ1FTncCmJj2eSz3GyD2Gk6sa9ZPtHV0zbNneYM4gtaC/WwQvpDip8spTrTBd0fyPwBG1S9Zs/Ka2j5dFITrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=337MW+uKdDLIEVwaIBBhiykZjXSTlVtiujb1daCs38Y=;
 b=SYsVEjH3rGl6+VQ5KAoxtFO+g/SsVi7nyNb+b6AwKJLbC4iyypvLtG1ZHzSZldJofCBJAsBTxB+1RzGrHm+4K/blM/WDXZxsxCek6NOLV++V8N9hk4e0cb9J1Ua9pBO0Prdotdi3vpEPB9QtN59tXchdP3CN/2bIZYXHb13IFGXlyGaPy3TOqkuq8XMt8MLlmorefGytz6y6d1HwxTXropCx4mT/vk/Jt471bz8kRgDLpQyCzj3DR3F50WMhXsbn3AEUIx821TiXzVov6iZsc6l6QMVjMYsSXBNHFNxxTIIjK6rPoiN/2vsmdy3Xkl2915dYkU2aZCcSzIKldeRTng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=337MW+uKdDLIEVwaIBBhiykZjXSTlVtiujb1daCs38Y=;
 b=uUY7p9sU4+iVHhw80qO1ihv69CHpCSfI7Z0+CzmviqViHnRbrGs12kIizm3bk5iezEX1vnpBXDN2ahRhtDVYriIR5CNwE6Em/zrwD92hmYoV+6gy1gEJyk9n/WZccwEATVzO4g9ST16dvL+z1qtNcs4HD3cJLeAuzCbHIVDHy6s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3605.namprd12.prod.outlook.com (20.178.197.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 20:49:47 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 20:49:47 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu/vcn2.5: fix a bug for the 2nd vcn instance
To: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
 <1579623556-30941-2-git-send-email-James.Zhu@amd.com>
 <9a367f37-2531-3966-7904-40cbe4a290d0@amd.com>
 <afe66ec7-d2c5-c0eb-8809-54581a7139c2@amd.com>
 <54758868-2ed5-2994-c357-435ea28aac2b@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <f37d405e-7b3c-2fc3-2272-dd8cedfc69c8@amd.com>
Date: Tue, 21 Jan 2020 15:49:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <54758868-2ed5-2994-c357-435ea28aac2b@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 20:49:46 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: befa0353-7fcd-4e1e-10cb-08d79eb3736a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3605:|BYAPR12MB3605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3605633BB7FCAB989C7EE00BE40D0@BYAPR12MB3605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(31686004)(2906002)(66556008)(66476007)(2616005)(8676002)(66946007)(956004)(36916002)(36756003)(52116002)(81166006)(81156014)(316002)(8936002)(5660300002)(186003)(478600001)(16576012)(53546011)(16526019)(110136005)(31696002)(26005)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3605;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJPAGDLNU5/R/UkpA68Qm96IzPGPywc7UiJFNtmJLxKt9mJdk5ublhhjL+jW0Kmhyx4glu77aK6tfhxd/+5K86GXRJ6SzIXKzlaOxfbj3wdFZ+xCWPWqaBFKshFvnsSMbAGhSw5Df2E/J683a8K20/W29MoNbcOLMWvqA87Gmv9hv9dp7uut9OmPU601Sli13zNACOHkZJ/5f385w0TTU8BknP7b/sP3qrnW2TbOlaANN25XxyZY6un7MQFp1GHPMI6q4AQeHxIVRTsOOJllLX6I0M70BHuJsX6ci7YkWWDs041vO+GiyISdC42VJWebSvJYLQFN3dnbFJKryxCCKbKO14S46Gf/GQjqLrXLMhNLpt+qGrg1/S5tgbApocV2HMcSmtXv3TlKyGLcNJKsLK2es5039rGr+mnMBdQ3O/hqGhzbjLFcHPttNeBubeDD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befa0353-7fcd-4e1e-10cb-08d79eb3736a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 20:49:47.1568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpQxlgA74t1wfhiLsrDj2++RkGetSqwOa7cXCXFAhsr5STsN79bIAvUI1P4HGXzL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
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

SXQgaXMgbm90IGZvciBEUEcgbW9kZSwgYnV0IGZvciBTUEcgbW9kZS4KCkp1c3Qgd2FudCB0byBy
ZXVzZSB0aGUgU1BHIG1vZGUgaW5zdGFuY2UgaGFydmVzdCBjaGVjayBoZXJlLgoKSmFtZXMKCk9u
IDIwMjAtMDEtMjEgMzoyMCBwLm0uLCBMZW8gTGl1IHdyb3RlOgo+Cj4gT24gMjAyMC0wMS0yMSAx
Mjo0NyBwLm0uLCBKYW1lcyBaaHUgd3JvdGU6Cj4+Cj4+IE9uIDIwMjAtMDEtMjEgMTI6MjkgcC5t
LiwgTGVvIExpdSB3cm90ZToKPj4+Cj4+PiBPbiAyMDIwLTAxLTIxIDExOjE5IGEubS4sIEphbWVz
IFpodSB3cm90ZToKPj4+PiBGaXggYSBidWcgZm9yIHRoZSAybmQgdmNuIGluc3RhbmNlIGF0IHN0
YXJ0IGFuZCBzdG9wLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5a
aHVAYW1kLmNvbT4KPj4+PiAtLS0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92
Y25fdjJfNS5jIHwgMTIgKysrKysrKystLS0tCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmNuX3YyXzUuYwo+Pj4+IGluZGV4IGMzNTFkMWEuLjc0MGEyOTEgMTAwNjQ0Cj4+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwo+Pj4+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMKPj4+PiBAQCAtODkxLDggKzg5
MSwxMCBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+
Pj4+ICphZGV2KQo+Pj4+IMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1f
dmNuX2luc3Q7ICsraSkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmhh
cnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGludWU7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT5wZ19mbGFncyAmIEFNRF9Q
R19TVVBQT1JUX1ZDTl9EUEcpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHZj
bl92Ml81X3N0YXJ0X2RwZ19tb2RlKGFkZXYsIGksIAo+Pj4+IGFkZXYtPnZjbi5pbmRpcmVjdF9z
cmFtKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NV
UFBPUlRfVkNOX0RQRykgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSB2Y25fdjJf
NV9zdGFydF9kcGdfbW9kZShhZGV2LCBpLCAKPj4+PiBhZGV2LT52Y24uaW5kaXJlY3Rfc3JhbSk7
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIH0KPj4+Cj4+PiAiciIgaXMgbm90IGJlaW5nIGNvbnNpZGVyZWQsIGFuZCBhZnRlciB0aGUg
bG9vcCwgaXQgd2lsbCBiZSBnb2luZyB0byAKPj4+IHRoZSBjb2RlIGJlbG93LCBpcyBpdCBjb3Jy
ZWN0Pwo+PiBTaW5jZSBEUEcgbW9kZSBzdGFydC9zdG9wIGFsd2F5cyByZXR1cm4gMC4gSSBoYXZl
IGFkZGVkIGNvZGUgdG8gCj4+IHJldHVybiAwIGJlbG93IHVuZGVyIERQRyBtb2RlCj4KPiBUaGVu
IHlvdSBzaG91bGQgbW92ZSB0aGUgInJldHVybiAwIiBoZXJlIGluc3RlYWQgb2YgYWRkaW5nIHR3
byBtb3JlIAo+IHVubmVjZXNzYXJ5IGxpbmVzLgo+Cj4KPj4+Cj4+Pgo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBkaXNhYmxlIHJlZ2lzdGVyIGFudGktaGFuZyBtZWNoYW5pc20gKi8KPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgV1JFRzMyX1AoU09DMTVfUkVHX09GRlNFVChVVkQsIGksIG1tVVZE
X1BPV0VSX1NUQVRVUyksIDAsCj4+Pj4gQEAgLTkwMyw2ICs5MDUsOSBAQCBzdGF0aWMgaW50IHZj
bl92Ml81X3N0YXJ0KHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+Pj4+ICphZGV2KQo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBXUkVHMzJfU09DMTUoVVZELCBpLCBtbVVWRF9TVEFUVVMsIHRtcCk7Cj4+
Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4gwqAgK8KgwqDCoCBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURf
UEdfU1VQUE9SVF9WQ05fRFBHKQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+PiAr
Cj4+Pj4gwqDCoMKgwqDCoCAvKlNXIGNsb2NrIGdhdGluZyAqLwo+Pj4+IMKgwqDCoMKgwqAgdmNu
X3YyXzVfZGlzYWJsZV9jbG9ja19nYXRpbmcoYWRldik7Cj4+Pj4gwqAgQEAgLTEyOTQsMTAgKzEy
OTksOSBAQCBzdGF0aWMgaW50IHZjbl92Ml81X3N0b3Aoc3RydWN0IAo+Pj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4+Pj4gwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgYWRldi0+dmNuLm51bV92
Y25faW5zdDsgKytpKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uaGFy
dmVzdF9jb25maWcgJiAoMSA8PCBpKSkKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b250aW51ZTsKPj4+PiAtCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT5wZ19mbGFn
cyAmIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByID0gdmNuX3YyXzVfc3RvcF9kcGdfbW9kZShhZGV2LCBpKTsKPj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIHBvd2VyX29mZjsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjb250aW51ZTsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4KPj4+IHNhbWUgcHJvYmxl
bSBhcyBhYm92ZSwgZG9uJ3QgZ28gdGhyb3VnaCB0aGUgY29kZSB0aGF0IGlzbid0IG5lY2Vzc2Fy
eS4KPj4KPj4gc2hvdWxkIGJlIGZpbmUgdW5kZXIgRFBHIG1vZGUuCj4KPiBJdCdzIGFib3V0IGNs
ZWFuIGltcGxlbWVudGF0aW9uLiBpZiBub3QgbmVjZXNzYXJ5LCB3aHkgZG8gd2UgbmVlZCB0byAK
PiBhZGQgdGhlbS4KPgo+IExlbwo+Cj4KPgo+Pgo+PiBKQW1lcwo+Pgo+Pj4KPj4+IFJlZ2FyZHMs
Cj4+Pgo+Pj4gTGVvCj4+Pgo+Pj4KPj4+PiDCoCDCoMKgwqDCoMKgwqDCoMKgwqAgLyogd2FpdCBm
b3IgdmNuIGlkbGUgKi8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
