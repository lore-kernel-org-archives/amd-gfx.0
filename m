Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A78AC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D966B20678
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D966B20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8089B6E422;
	Tue, 26 Nov 2019 15:28:02 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740077.outbound.protection.outlook.com [40.107.74.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1EF6E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 15:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0ljjJirrRIa5id3PoaqOPxq0ypciJ7/1qfrhDrhrF9jqiiDb+aU5el2i5N4GyAlJLedvcaUbnNjLIaOPuzpFviaCyE8QIvO1vqwvV7+wWoW29LOV24DYZAbpt+7+ToTO2pYLy/9tys4laePu+Ae14qZVhEzoBQH51M6JbqBsRp190TfZW3tYGtAM5lHjSv0NsICmcXDRRw12mBP4PoOXgkMET4QE6ovmWbV2iap7yVbnGF4mnmoAVbtmlTVba59NhmiuArTITXlPkrIXjLp059sAiJf1yu35cZeqJNEAAVf2Qss7CVvvGfoVP+T2PyZoSZd235jELZMhChCUZVqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/Fd58kdjBfu+5wjnf9TU2rkmW/6fvIPaumnBlRc2+M=;
 b=G0wuSCVjEqwSF/6ZzPQg1Qnm4ABRabGfUII3Jhk+hw3bTsVoER418gkku4B86JBqpuIhGoyzbhOuSpLiB/nN1Y/v0jy5tGD15IOJM5ledyhIoAdEmZAPdnrBbFvbKdEtsiBEjJDz4Q0E+vDPcXhSFEKX5PEYkRzb9l8T7GrmJaKpR1pmXGPpJjrBmGCXNR0BTeR8GdYNN7/QFsGVqqYgS8hbj2hxQvJYFTy/Tkd0LPMHFH7IyJ35wj8IHUuvIMJESEe6aqQHjJs/YS2miEd+MPMiSs383SVWAmnky/0D57J4HJFFQQS9RcFxbIJ/+pF4/fbXnImXnPzhAHyncWgqlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2611.namprd12.prod.outlook.com (20.176.27.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 15:27:58 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:27:58 +0000
Subject: Re: [PATCH v7 11/17] drm/dp_mst: Add DSC enablement helpers to DRM
From: Leo <sunpeng.li@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20191116220128.16598-1-mikita.lipski@amd.com>
 <20191116220128.16598-12-mikita.lipski@amd.com>
 <fe56a601-777d-f8db-c229-f155a162f100@amd.com>
Message-ID: <04c1aa71-a62a-8cf6-0c1a-d98ec7581a7d@amd.com>
Date: Tue, 26 Nov 2019 10:27:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <fe56a601-777d-f8db-c229-f155a162f100@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1791280c-8ac3-4af6-36bd-08d772853785
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:|BN7PR12MB2611:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2611BD5EF6F79C16877F81DA82450@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(199004)(189003)(99286004)(81166006)(14454004)(305945005)(966005)(25786009)(7736002)(229853002)(478600001)(26005)(45080400002)(31686004)(186003)(8936002)(5660300002)(8676002)(47776003)(14444005)(81156014)(6116002)(36756003)(230700001)(3846002)(386003)(53546011)(6506007)(52116002)(50466002)(76176011)(66066001)(2486003)(65806001)(65956001)(23676004)(2361001)(2351001)(6246003)(2616005)(31696002)(2906002)(4326008)(6306002)(6512007)(86362001)(4001150100001)(6436002)(6916009)(66476007)(58126008)(11346002)(66946007)(54906003)(66556008)(316002)(446003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2611;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeVmVvTpRINfpFcGgRYoc96VZ9tMIxdpZipIdFsrderHPoUREt7GxgBgqvcrt7r2YRxmzTxpfRcP/TrLehE1kmJXowGWdTF612I5KUuFafTR03WSpbkUMWsafjPZpMqgjl0MhbXxn5eWxOx+DCrSvpwo5VcnQsT/pmr2KgMAi8SPF4zFfNGomQOfUIXpQKS/fKOTOtAhw5N7U+lma3iTKKIuucfvNiVZQ6zZ0XgN87yraQzrq8pNPOgB8EiyjGIoqWl+9DCOjtgD649i/RCIR8TMc2ltn57ZurL7c+4ffk2idOStgzSZjh7X8WmmG8/quqXDf/wLA8EvgDac+/ywWRjlChOJaSU2q7ZOsqibyRq16ofd/ZmaDQkLYyrcFLq/oQ4d5U4toitNwRTFMAGmU7VPpbOWNkDagFxW2wJ+t/F/HJVmXkCL8/P68RvUMH2ZopsLhuiAHYPRqvgIx2a4zhTtorjtNJ35H5zh8ohr4pM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1791280c-8ac3-4af6-36bd-08d772853785
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:27:58.5927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsUz8UdFj89jl1PAXN9fAklrH1vAfCJE3bU5XKCmRSMqaUkrB5CxOtdPgbDNdX1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/Fd58kdjBfu+5wjnf9TU2rkmW/6fvIPaumnBlRc2+M=;
 b=ZyqsNefrk0wHhCJ8oL+i2Uy2TmpFDg5oXAS/6MQC/neeEwXxMjxDOJ2X7nSwfQKWJfEvUOR2kAxN/ZwPcf2bQVtKdUm9LdvzrkQWV0qd9X/xtfx5km/geLPaINsdbbCJOEIOYNeYd7aG8jC1foDKRsin8r/HdB8AFah8klOYRE4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126152757.9XrvjB8_uC1x31Foy4p5m57lOfTdSA6O7A3Cl3rWZc0@z>

SnVzdCByZWFsaXplZCBMeXVkZSB3YXNuJ3QgQ0MnZCBvcmlnaW5hbGx5LCBhbmQgSSBmb3Jnb3Qg
dG8gQ0MgZXZlcnlvbmUgYXMgd2VsbCBpbiB0aGUgcmVwbHkgOikKCkxlbwoKT24gMjAxOS0xMS0y
NiAxMDoyNCBhLm0uLCBMZW8gd3JvdGU6Cj4gCj4gCj4gT24gMjAxOS0xMS0xNiA1OjAxIHAubS4s
IG1pa2l0YS5saXBza2lAYW1kLmNvbSB3cm90ZToKPj4gRnJvbTogTWlraXRhIExpcHNraSA8bWlr
aXRhLmxpcHNraUBhbWQuY29tPgo+Pgo+PiBBZGRpbmcgYSBoZWxwZXIgZnVuY3Rpb24gdG8gYmUg
Y2FsbGVkIGJ5Cj4+IGRyaXZlcnMgb3V0c2lkZSBvZiBEUk0gdG8gZW5hYmxlIERTQyBvbgo+PiB0
aGUgTVNUIHBvcnRzLgo+Pgo+PiBGdW5jdGlvbiBpcyBjYWxsZWQgdG8gcmVjYWxjdWxhdGUgVkNQ
SSBhbGxvY2F0aW9uCj4+IGlmIERTQyBpcyBlbmFibGVkIGFuZCByYWlzZSB0aGUgRFNDIGZsYWcg
dG8gZW5hYmxlLgo+PiBJbiBjYXNlIG9mIGRpc2FibGluZyBEU0MgdGhlIGZsYWcgaXMgc2V0IHRv
IGZhbHNlCj4+IGFuZCByZWNhbGN1bGF0aW9uIG9mIFZDUEkgc2xvdHMgaXMgZXhwZWN0ZWQgdG8g
YmUgZG9uZQo+PiBpbiBlbmNvZGVyJ3MgYXRvbWljX2NoZWNrLgo+Pgo+PiB2Mjogc3F1YXNoIHNl
cGFyYXRlIGZ1bmN0aW9ucyBpbnRvIG9uZSBhbmQgY2FsbCBpdCBwZXIKPj4gcG9ydAo+Pgo+PiBD
YzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4+IENjOiBMeXVkZSBQ
YXVsIDxseXVkZUByZWRoYXQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxt
aWtpdGEubGlwc2tpQGFtZC5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9ncHUvZHJtL2RybV9kcF9t
c3RfdG9wb2xvZ3kuYyB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgaW5jbHVk
ZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaCAgICAgICB8ICA1ICsrKwo+PiAgMiBmaWxlcyBjaGFu
Z2VkLCA2NiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
ZHJtX2RwX21zdF90b3BvbG9neS5jIGIvZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xv
Z3kuYwo+PiBpbmRleCA5NGJiMjU5YWI3M2UuLjk4Y2M5M2Q1ZGRkNyAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4+IEBAIC0zODc2LDYgKzM4NzYsNjcgQEAgZHJt
X2RwX21zdF9hdG9taWNfY2hlY2tfdG9wb2xvZ3lfc3RhdGUoc3RydWN0IGRybV9kcF9tc3RfdG9w
b2xvZ3lfbWdyICptZ3IsCj4+ICAJcmV0dXJuIDA7Cj4+ICB9Cj4+ICAKPj4gKy8qKgo+PiArICog
ZHJtX2RwX21zdF9hdG9taWNfZW5hYmxlX2RzYyAtIFNldCBEU0MgRW5hYmxlIEZsYWcgdG8gT24v
T2ZmCj4+ICsgKiBAc3RhdGU6IFBvaW50ZXIgdG8gdGhlIG5ldyBkcm1fYXRvbWljX3N0YXRlIAo+
PiArICogQHBvaW50ZXI6IFBvaW50ZXIgdG8gdGhlIGFmZmVjdGVkIE1TVCBQb3J0Cj4gCj4gcy9A
cG9pbnRlci9AcG9ydC8KPiAKPj4gKyAqIEBwYm46IE5ld2x5IHJlY2FsY3VsYXRlZCBidyByZXF1
aXJlZCBmb3IgbGluayB3aXRoIERTQyBlbmFibGVkCj4+ICsgKiBAcGJuX2RpdjogRGl2aWRlciB0
byBjYWxjdWxhdGUgY29ycmVjdCBudW1iZXIgb2YgcGJuIHBlciBzbG90Cj4+ICsgKiBAZW5hYmxl
OiBCb29sZWFuIGZsYWcgZW5hYmxpbmcgb3IgZGlzYWJsaW5nIERTQyBvbiB0aGUgcG9ydAo+PiAr
ICoKPj4gKyAqIFRoaXMgZnVuY3Rpb24gZW5hYmxlcyBEU0Mgb24gdGhlIGdpdmVuIFBvcnQKPj4g
KyAqIGJ5IHJlY2FsY3VsYXRpbmcgaXRzIHZjcGkgZnJvbSBwYm4gcHJvdmlkZWQKPj4gKyAqIGFu
ZCBzZXRzIGRzY19lbmFibGUgZmxhZyB0byBrZWVwIHRyYWNrIG9mIHdoaWNoCj4+ICsgKiBwb3J0
cyBoYXZlIERTQyBlbmFibGVkCj4gCj4gV291bGQgYmUgZ29vZCB0byBkb2N1bWVudCB0aGUgcmV0
dXJuIHZhbHVlIGFzIHdlbGwuCj4gCj4+ICsgKgo+PiArICovCj4+ICtpbnQgZHJtX2RwX21zdF9h
dG9taWNfZW5hYmxlX2RzYyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4+ICsJCQkJ
IHN0cnVjdCBkcm1fZHBfbXN0X3BvcnQgKnBvcnQsCj4+ICsJCQkJIGludCBwYm4sIGludCBwYm5f
ZGl2LAo+PiArCQkJCSBib29sIGVuYWJsZSkKPj4gK3sKPj4gKwlzdHJ1Y3QgZHJtX2RwX21zdF90
b3BvbG9neV9zdGF0ZSAqbXN0X3N0YXRlOwo+PiArCXN0cnVjdCBkcm1fZHBfdmNwaV9hbGxvY2F0
aW9uICpwb3M7Cj4+ICsJYm9vbCBmb3VuZCA9IGZhbHNlOwo+PiArCWludCB2Y3BpID0gMDsKPj4g
Kwo+PiArCW1zdF9zdGF0ZSA9IGRybV9hdG9taWNfZ2V0X21zdF90b3BvbG9neV9zdGF0ZShzdGF0
ZSwgcG9ydC0+bWdyKTsKPj4gKwo+PiArCWlmIChJU19FUlIobXN0X3N0YXRlKSkKPj4gKwkJcmV0
dXJuIFBUUl9FUlIobXN0X3N0YXRlKTsKPj4gKwo+PiArCWxpc3RfZm9yX2VhY2hfZW50cnkocG9z
LCAmbXN0X3N0YXRlLT52Y3BpcywgbmV4dCkgewo+PiArCQlpZiAocG9zLT5wb3J0ID09IHBvcnQp
IHsKPj4gKwkJCWZvdW5kID0gdHJ1ZTsKPj4gKwkJCWJyZWFrOwo+PiArCQl9Cj4+ICsJfQo+PiAr
Cj4+ICsJaWYgKCFmb3VuZCkgewo+PiArCQlEUk1fREVCVUdfQVRPTUlDKCJbTVNUIFBPUlQ6JXBd
IENvdWxkbid0IGZpbmQgVkNQSSBhbGxvY2F0aW9uIGluIG1zdCBzdGF0ZSAlcFxuIiwKPj4gKwkJ
CQkgcG9ydCwgbXN0X3N0YXRlKTsKPj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4+ICsJfQo+PiArCj4+
ICsJaWYgKHBvcy0+ZHNjX2VuYWJsZWQgPT0gZW5hYmxlKSB7Cj4+ICsJCURSTV9ERUJVR19BVE9N
SUMoIltNU1QgUE9SVDolcF0gRFNDIGZsYWcgaXMgYWxyZWFkeSBzZXQgdG8gJWQsIHJldHVybmlu
ZyAlZCBWQ1BJIHNsb3RzXG4iLAo+PiArCQkJCSBwb3J0LCBlbmFibGUsIHBvcy0+dmNwaSk7Cj4+
ICsJCXZjcGkgPSBwb3MtPnZjcGk7Cj4gCj4gRG8gd2Ugd2FudCB0byBlYXJseSByZXR1cm4gaGVy
ZT8KPiAKPiAtIExlbwo+IAo+PiArCX0KPj4gKwo+PiArCWlmIChlbmFibGUpIHsKPj4gKwkJdmNw
aSA9IGRybV9kcF9hdG9taWNfZmluZF92Y3BpX3Nsb3RzKHN0YXRlLCBwb3J0LT5tZ3IsIHBvcnQs
IHBibiwgcGJuX2Rpdik7Cj4+ICsJCURSTV9ERUJVR19BVE9NSUMoIltNU1QgUE9SVDolcF0gRW5h
YmxpbmcgRFNDIGZsYWcsIHJlYWxsb2NhdGluZyAlZCBWQ1BJIHNsb3RzIG9uIHRoZSBwb3J0XG4i
LAo+PiArCQkJCSBwb3J0LCB2Y3BpKTsKPj4gKwkJaWYgKHZjcGkgPCAwKQo+PiArCQkJcmV0dXJu
IC1FSU5WQUw7Cj4+ICsJfQo+PiArCj4+ICsJcG9zLT5kc2NfZW5hYmxlZCA9IGVuYWJsZTsKPj4g
Kwo+PiArCXJldHVybiB2Y3BpOwo+PiArfQo+PiArRVhQT1JUX1NZTUJPTChkcm1fZHBfbXN0X2F0
b21pY19lbmFibGVfZHNjKTsKPj4gIC8qKgo+PiAgICogZHJtX2RwX21zdF9hdG9taWNfY2hlY2sg
LSBDaGVjayB0aGF0IHRoZSBuZXcgc3RhdGUgb2YgYW4gTVNUIHRvcG9sb2d5IGluIGFuCj4+ICAg
KiBhdG9taWMgdXBkYXRlIGlzIHZhbGlkCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1f
ZHBfbXN0X2hlbHBlci5oIGIvaW5jbHVkZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaAo+PiBpbmRl
eCBmYzE5MDk0YjA2YzMuLmIxYjAwZGUzMDgzYiAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9kcm0v
ZHJtX2RwX21zdF9oZWxwZXIuaAo+PiArKysgYi9pbmNsdWRlL2RybS9kcm1fZHBfbXN0X2hlbHBl
ci5oCj4+IEBAIC00MzEsNiArNDMxLDcgQEAgc3RydWN0IGRybV9kcF9wYXlsb2FkIHsKPj4gIHN0
cnVjdCBkcm1fZHBfdmNwaV9hbGxvY2F0aW9uIHsKPj4gIAlzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0
ICpwb3J0Owo+PiAgCWludCB2Y3BpOwo+PiArCWJvb2wgZHNjX2VuYWJsZWQ7Cj4+ICAJc3RydWN0
IGxpc3RfaGVhZCBuZXh0Owo+PiAgfTsKPj4gIAo+PiBAQCAtNjYzLDYgKzY2NCwxMCBAQCBkcm1f
ZHBfYXRvbWljX2ZpbmRfdmNwaV9zbG90cyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUs
Cj4+ICAJCQkgICAgICBzdHJ1Y3QgZHJtX2RwX21zdF90b3BvbG9neV9tZ3IgKm1nciwKPj4gIAkJ
CSAgICAgIHN0cnVjdCBkcm1fZHBfbXN0X3BvcnQgKnBvcnQsIGludCBwYm4sCj4+ICAJCQkgICAg
ICBpbnQgcGJuX2Rpdik7Cj4+ICtpbnQgZHJtX2RwX21zdF9hdG9taWNfZW5hYmxlX2RzYyhzdHJ1
Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4+ICsJCQkJIHN0cnVjdCBkcm1fZHBfbXN0X3Bv
cnQgKnBvcnQsCj4+ICsJCQkJIGludCBwYm4sIGludCBwYm5fZGl2LAo+PiArCQkJCSBib29sIGVu
YWJsZSk7Cj4+ICBpbnQgX19tdXN0X2NoZWNrCj4+ICBkcm1fZHBfYXRvbWljX3JlbGVhc2VfdmNw
aV9zbG90cyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4+ICAJCQkJIHN0cnVjdCBk
cm1fZHBfbXN0X3RvcG9sb2d5X21nciAqbWdyLAo+Pgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUy
Rm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3N1bnBlbmcu
bGklNDBhbWQuY29tJTdDMTkyMTEwMTg2YWE5NGZkMDEzYmYwOGQ3NzI4NGMwNDQlN0MzZGQ4OTYx
ZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTAzNzg2ODI5OTM1ODM0JmFt
cDtzZGF0YT1xS3FGTnk5ZVhmJTJGdXZEY0hENFZseDlpNXUyd2gxNEtmbGV3anJycUM1NDQlM0Qm
YW1wO3Jlc2VydmVkPTAKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
