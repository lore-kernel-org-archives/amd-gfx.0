Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6560C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9966B2073F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 16:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9966B2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FE36E33A;
	Wed, 27 Nov 2019 16:31:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8EF6E33A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 16:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9gvEjJ2BwUIe+LbMLF8yRGFRu3PZW4Vjq5lu1PwvCgw9la96HVmlq7j6PzyFtyYUpIz6UVnzCdmPtqjI8JqqGIXMLZIf/YrpP2ITnx+7kEuKT58XIlJL74zkNOvuU8kCVuc3JKPfmfzJMTVEIEpdqYLZMy3g/101D+TPJdShS/5NqWnHv+hu1guCretKkz1Iy2R1JcukF/BaQWHSCEAMikVo34g3hOn/Kv5oudjROge32AYKueWmH57zFZVPsrG7QSdNUhufHOyqFZCAlw3TFdFis8EMDpLRSbxPd5rpvS8DAXDVGN04S0coASkjDPiM6u/z/NPZYCxpBSbf6J2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac1keU5Zfd4GKDtkVSDrQOtTSHwFqsqPrkbJ1qOAA5Y=;
 b=j4uDgsU1rAdUNlAiyvTd/RwoVDm9PYbtWRE5b+wBoCCKGSTh50pBqa+z9LA6rSuXZq4Y4kpLjqdpEJpWqUBSO7fEbq/gUFRI0k2xQODkR2Kog+hWSNlit4p24BzsUrSAl4CD5qPgLk9Aio9LBm1d0fDOiT02Z9qnTSQEawHzEOAn3RNvRSi/Fpga2KsSu395buc2y6JxqRQw1h/ALPb16XigRQ/1YNuvVravyKI6LJ4dTRYwgYUwDrvLIanwcqIkVdZbNrkStwqJv77YNAIO0JXDL5vmVs7JaSict0Bs6QjIUtllWGmRYfn7fj16AgmJWh6KC+Z/m2IlY6DZD6+zDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3461.namprd12.prod.outlook.com (20.178.54.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 27 Nov 2019 16:31:49 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::81f8:ed8a:e30e:adb0%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 16:31:48 +0000
Subject: Re: [PATCH] drm/amd/display: Get NV14 specific ip params as needed
To: Zhan Liu <zhan.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 hersenxs.wu@amd.com, rodrigo.siqueira@amd.com
References: <20191126213222.17728-1-zhan.liu@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <b60fc8a3-cd3b-f48f-97af-e1e45d40c310@amd.com>
Date: Wed, 27 Nov 2019 11:31:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20191126213222.17728-1-zhan.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::41) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35847633-1588-4101-7e8b-08d773574ce5
X-MS-TrafficTypeDiagnostic: BYAPR12MB3461:|BYAPR12MB3461:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB346150F37DA5F188F3C18A60EC440@BYAPR12MB3461.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(199004)(189003)(305945005)(6486002)(2906002)(31696002)(6512007)(81156014)(14454004)(25786009)(6436002)(478600001)(186003)(58126008)(86362001)(8676002)(81166006)(316002)(26005)(31686004)(6636002)(7736002)(6246003)(52116002)(229853002)(36756003)(8936002)(99286004)(66476007)(66556008)(23676004)(66946007)(76176011)(230700001)(65956001)(47776003)(2616005)(11346002)(386003)(4001150100001)(66066001)(65806001)(6506007)(2486003)(6116002)(50466002)(53546011)(446003)(3846002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3461;
 H:BYAPR12MB3560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pf3M4B9uX1C6EngEmMnpmYZsrle03wmAJrZsz5MM5tmgrzFyvm+STFqxr45RFRcs2QIWqYspZmc95bOtiaEXlba/iSzErQ0qM2LC1uhBTm8nXTVcszSGXX501EbMTUV4X+hiZ8gHTjwGqgFL6EbBuifq60ugMHuXKuVd0afCiG3GdkdkRkW1/on7MliFh3xYZKt2FvlqwGowmQs46xvhgNXUruaRcsqHok+eRFF3cDRBVvYtS9o/ry15gQvPSumoJ6pxEE/vdTkF10vXwRlqhzVs6MI80GAQvwgzWBikuLgNOTB2vcbCpXBGruV7PlgcCiTuCPJt3YEqmoQjE50S/4PRYbVn7/MpsB6kLfFNzTHi0DkDKrNrax8zHto8+XpbOAPmQI7fxdfFRlwFu2Z3sDe18ENI57xp1GUY2FsAg1vSOUPZzpRS71zAt2ABQBVu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35847633-1588-4101-7e8b-08d773574ce5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 16:31:48.8930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0LXraO7v4cuJPKzm8FaNBzAmRwTNL0YoIVTJ+P/KMlX7H18P8m+kFZpbGC4BwXE+xT/SBjgE50J7ln4pI/8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3461
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac1keU5Zfd4GKDtkVSDrQOtTSHwFqsqPrkbJ1qOAA5Y=;
 b=RlUbPhfIrbQ0OZDfYWL80+0CCiDjC/GqyvIBftv86dsuAP6K5WaTIJaImvKmrT1SCX3/eQcixfvBGYN30oOyYC9G63XUzinFm66vQiK0QseCM3FublM1FgJV/73SoMan5EUdwZBWqB8HvzBq6Rgx/ZsWNaxrQZ5uT1ZNOW4KnnU=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
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
Message-ID: <20191127163146.MNx3YevTWP521wgglHxU5l5vuUdoKDr8EVkZRHdczZQ@z>

T24gMjAxOS0xMS0yNiA0OjMyIHAubS4sIFpoYW4gTGl1IHdyb3RlOgo+IFtXaHldCj4gTlYxNCBp
cyB1c2luZyBpdHMgb3duIGlwIHBhcmFtcyB0aGF0J3MgZGlmZmVyZW50IGZyb20gb3RoZXIKPiBE
Q04yLjAgQVNJQ3MuCj4gCj4gW0hvd10KPiBBZGQgQVNJQyByZXZpc2lvbiBjaGVjayB0byBtYWtl
IHN1cmUgTlYxNCBnZXRzIGNvcnJlY3QKPiBpcCBwYXJhbXMuCj4gCj4gU2lnbmVkLW9mZi1ieTog
WmhhbiBMaXUgPHpoYW4ubGl1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogTmljaG9sYXMgS2F6bGF1
c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMyArKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwo+IGluZGV4IGRiYzBh
NGE3YzI4NC4uM2RkMmIyNDI5YWUyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX3Jlc291cmNlLmMKPiBAQCAtMzI0NSw2ICszMjQ1
LDkgQEAgc3RhdGljIHN0cnVjdCBfdmNzX2RwaV9zb2NfYm91bmRpbmdfYm94X3N0ICpnZXRfYXNp
Y19yZXZfc29jX2JiKAo+ICAgc3RhdGljIHN0cnVjdCBfdmNzX2RwaV9pcF9wYXJhbXNfc3QgKmdl
dF9hc2ljX3Jldl9pcF9wYXJhbXMoCj4gICAJdWludDMyX3QgaHdfaW50ZXJuYWxfcmV2KQo+ICAg
ewo+ICsJaWYgKEFTSUNSRVZfSVNfTkFWSTE0X00oaHdfaW50ZXJuYWxfcmV2KSkKPiArCQlyZXR1
cm4gJmRjbjJfMF9udjE0X2lwOwo+ICsKPiAgIAkvKiBOVjEyIGFuZCBOVjEwICovCj4gICAJcmV0
dXJuICZkY24yXzBfaXA7Cj4gICB9Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
