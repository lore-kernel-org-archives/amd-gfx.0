Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E4C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D4E20678
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 15:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D4E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3246E426;
	Tue, 26 Nov 2019 15:24:35 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800050.outbound.protection.outlook.com [40.107.80.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8662D6E41F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 15:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrn9MHKQKqI0eSiSHTIIzEoDDjtSi+XYXacWQwVldK9tDZGjeHkY+AguwOzI17eGr7I86hKMd5bNnK1cg0BAVtRQBD8t2VuA6jzgzgTUU1XLS24DT53Sc6wAjMEsQqT7vHNfZxX/UOLQDDUwe4bGwWj5gkCaxXJsl2WZPiduLhvKHkQKz+4DGtaxGusqtzfW9fHsfKb42QQOf6KWR4imZNWVzpcjVQtVA4qTUMziRx6GlYEdoi8R7twOYZM0Aa8SuZwVd2nQUK8eicoHrIdSPY4E/jIO/bv/xW2Ozddz6BKnKFPui0VoZV/mWkwE0Rewt+k3gUT+Rm/grdkIIPUHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CR1lr8vJLK3PdX1mFo9Sap/HrN27mXas8X1YLoja+g=;
 b=Qf9l+eS633siuBypGAfpESPfYBtIMBbwvkg8Pp0WF64N64t9lbol/AHaQ+AYaf3p8sCLFCM/YWs8mBmJ9W9DVybM3NS4joQYLiP4+0pOd1dpAw/vnVjDxvePzRX1RvhGd4fAYzWtkLgwJCfhXAXC/A3lLEcEXxRvy6loETzMnliiIh6f/lB46HjeGs6RJ0AbGzDlJ9x5/oIQo5aCmak9lGSjWgucTZ4IK/ZvrLSZekn0mEpUZhUqbxPYvlSmHILZkvmcttxep0V4ES+MGQmHXQwQxW0D+YtGCwAwB0CtLXbVUM7bYduPhn3NXLW7gpEBbQJYwLyaoGoVlEWekkzxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2835.namprd12.prod.outlook.com (20.176.178.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Tue, 26 Nov 2019 15:24:31 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::c9fd:22d8:cfdb:f430%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 15:24:31 +0000
Subject: Re: [PATCH v7 11/17] drm/dp_mst: Add DSC enablement helpers to DRM
To: amd-gfx@lists.freedesktop.org
References: <20191116220128.16598-1-mikita.lipski@amd.com>
 <20191116220128.16598-12-mikita.lipski@amd.com>
From: Leo <sunpeng.li@amd.com>
Message-ID: <fe56a601-777d-f8db-c229-f155a162f100@amd.com>
Date: Tue, 26 Nov 2019 10:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <20191116220128.16598-12-mikita.lipski@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58833ae4-4bc3-45db-c804-08d77284bc13
X-MS-TrafficTypeDiagnostic: BN7PR12MB2835:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2835F75AD5261F7E7F469E2782450@BN7PR12MB2835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(2906002)(229853002)(26005)(6916009)(50466002)(14454004)(6246003)(99286004)(2616005)(65806001)(65956001)(31696002)(66946007)(446003)(47776003)(86362001)(76176011)(8936002)(2486003)(81166006)(52116002)(81156014)(6506007)(53546011)(186003)(23676004)(11346002)(66556008)(66476007)(8676002)(66066001)(6512007)(386003)(6436002)(36756003)(230700001)(6486002)(14444005)(305945005)(5660300002)(7736002)(3846002)(2361001)(2351001)(316002)(58126008)(31686004)(25786009)(6116002)(4001150100001)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2835;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rbmwa1xkTmYWpLLJwPJVBkoqBYDnFC4suArM4dRlmDLUD5dsGGN30K5mjYJ7BVcNTtYzh5/PaOMHx4XVvIaMspWjHcLddiP3hLLXFMt/xr3I8MQwvcovDE2Wf8NLl9SFwcMCTvaafqlJB/Ft9ILITrPVNaW3nrioI6oLKApVzWMrRVaQlQxJDiBK0AEvJwXRE0pzz2FkyR0OOdmKyOmoblqZua2emayN84P3AtziY3T5ppV2SdyB/PQHlnrK3vA1Ryc6aEOZ+yUuocnmrpHt/udoK/jk4PqKaDk58PGihMSud/yznXFmx44TJEjbtEPi5HjoopypLPsfy4AB2cs7zOdzcg8ZA+9eQcadnndfVxmX6La52EtEUCEIRWk5I6Bn0MNF5vZMaOWmddZFYltwNQe8Yk4AGqABP3+LSDQYrmmWmPKBZr8ANb50qGesYpy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58833ae4-4bc3-45db-c804-08d77284bc13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 15:24:31.4995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/JnE6VhTl5E/4LTYVBMEc3j0J/dnGZ/D96QE0YQVw6tGK27x8POVBgkhb/L8jE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2835
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CR1lr8vJLK3PdX1mFo9Sap/HrN27mXas8X1YLoja+g=;
 b=kJMh4mkz58qfP7PA6hyKkzlotwBtyGCQppR5KyKEKcNb2RXG8jxcl4xIH7UJSvsCpNCh0nW/nomsu+0J76szZwGT91FXZJG7IjNhiAJ3IpM4aJFWsu4OxZpgml8aZaPO4gUCFnEYE4PAX/168QxE+g7jIjvHjm9nBvJzygMn5bA=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126152430.2O-6XzS06anb9qR2F07elnV_f-sa2LMSuWYRg0sBV_I@z>

CgpPbiAyMDE5LTExLTE2IDU6MDEgcC5tLiwgbWlraXRhLmxpcHNraUBhbWQuY29tIHdyb3RlOgo+
IEZyb206IE1pa2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNvbT4KPiAKPiBBZGRpbmcg
YSBoZWxwZXIgZnVuY3Rpb24gdG8gYmUgY2FsbGVkIGJ5Cj4gZHJpdmVycyBvdXRzaWRlIG9mIERS
TSB0byBlbmFibGUgRFNDIG9uCj4gdGhlIE1TVCBwb3J0cy4KPiAKPiBGdW5jdGlvbiBpcyBjYWxs
ZWQgdG8gcmVjYWxjdWxhdGUgVkNQSSBhbGxvY2F0aW9uCj4gaWYgRFNDIGlzIGVuYWJsZWQgYW5k
IHJhaXNlIHRoZSBEU0MgZmxhZyB0byBlbmFibGUuCj4gSW4gY2FzZSBvZiBkaXNhYmxpbmcgRFND
IHRoZSBmbGFnIGlzIHNldCB0byBmYWxzZQo+IGFuZCByZWNhbGN1bGF0aW9uIG9mIFZDUEkgc2xv
dHMgaXMgZXhwZWN0ZWQgdG8gYmUgZG9uZQo+IGluIGVuY29kZXIncyBhdG9taWNfY2hlY2suCj4g
Cj4gdjI6IHNxdWFzaCBzZXBhcmF0ZSBmdW5jdGlvbnMgaW50byBvbmUgYW5kIGNhbGwgaXQgcGVy
Cj4gcG9ydAo+IAo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
PiBDYzogTHl1ZGUgUGF1bCA8bHl1ZGVAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNaWtp
dGEgTGlwc2tpIDxtaWtpdGEubGlwc2tpQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9kcm1fZHBfbXN0X3RvcG9sb2d5LmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysrKysrKysK
PiAgaW5jbHVkZS9kcm0vZHJtX2RwX21zdF9oZWxwZXIuaCAgICAgICB8ICA1ICsrKwo+ICAyIGZp
bGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHBfbXN0
X3RvcG9sb2d5LmMKPiBpbmRleCA5NGJiMjU5YWI3M2UuLjk4Y2M5M2Q1ZGRkNyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2RwX21zdF90b3BvbG9neS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2RybV9kcF9tc3RfdG9wb2xvZ3kuYwo+IEBAIC0zODc2LDYgKzM4NzYsNjcgQEAg
ZHJtX2RwX21zdF9hdG9taWNfY2hlY2tfdG9wb2xvZ3lfc3RhdGUoc3RydWN0IGRybV9kcF9tc3Rf
dG9wb2xvZ3lfbWdyICptZ3IsCj4gIAlyZXR1cm4gMDsKPiAgfQo+ICAKPiArLyoqCj4gKyAqIGRy
bV9kcF9tc3RfYXRvbWljX2VuYWJsZV9kc2MgLSBTZXQgRFNDIEVuYWJsZSBGbGFnIHRvIE9uL09m
Zgo+ICsgKiBAc3RhdGU6IFBvaW50ZXIgdG8gdGhlIG5ldyBkcm1fYXRvbWljX3N0YXRlIAo+ICsg
KiBAcG9pbnRlcjogUG9pbnRlciB0byB0aGUgYWZmZWN0ZWQgTVNUIFBvcnQKCnMvQHBvaW50ZXIv
QHBvcnQvCgo+ICsgKiBAcGJuOiBOZXdseSByZWNhbGN1bGF0ZWQgYncgcmVxdWlyZWQgZm9yIGxp
bmsgd2l0aCBEU0MgZW5hYmxlZAo+ICsgKiBAcGJuX2RpdjogRGl2aWRlciB0byBjYWxjdWxhdGUg
Y29ycmVjdCBudW1iZXIgb2YgcGJuIHBlciBzbG90Cj4gKyAqIEBlbmFibGU6IEJvb2xlYW4gZmxh
ZyBlbmFibGluZyBvciBkaXNhYmxpbmcgRFNDIG9uIHRoZSBwb3J0Cj4gKyAqCj4gKyAqIFRoaXMg
ZnVuY3Rpb24gZW5hYmxlcyBEU0Mgb24gdGhlIGdpdmVuIFBvcnQKPiArICogYnkgcmVjYWxjdWxh
dGluZyBpdHMgdmNwaSBmcm9tIHBibiBwcm92aWRlZAo+ICsgKiBhbmQgc2V0cyBkc2NfZW5hYmxl
IGZsYWcgdG8ga2VlcCB0cmFjayBvZiB3aGljaAo+ICsgKiBwb3J0cyBoYXZlIERTQyBlbmFibGVk
CgpXb3VsZCBiZSBnb29kIHRvIGRvY3VtZW50IHRoZSByZXR1cm4gdmFsdWUgYXMgd2VsbC4KCj4g
KyAqCj4gKyAqLwo+ICtpbnQgZHJtX2RwX21zdF9hdG9taWNfZW5hYmxlX2RzYyhzdHJ1Y3QgZHJt
X2F0b21pY19zdGF0ZSAqc3RhdGUsCj4gKwkJCQkgc3RydWN0IGRybV9kcF9tc3RfcG9ydCAqcG9y
dCwKPiArCQkJCSBpbnQgcGJuLCBpbnQgcGJuX2RpdiwKPiArCQkJCSBib29sIGVuYWJsZSkKPiAr
ewo+ICsJc3RydWN0IGRybV9kcF9tc3RfdG9wb2xvZ3lfc3RhdGUgKm1zdF9zdGF0ZTsKPiArCXN0
cnVjdCBkcm1fZHBfdmNwaV9hbGxvY2F0aW9uICpwb3M7Cj4gKwlib29sIGZvdW5kID0gZmFsc2U7
Cj4gKwlpbnQgdmNwaSA9IDA7Cj4gKwo+ICsJbXN0X3N0YXRlID0gZHJtX2F0b21pY19nZXRfbXN0
X3RvcG9sb2d5X3N0YXRlKHN0YXRlLCBwb3J0LT5tZ3IpOwo+ICsKPiArCWlmIChJU19FUlIobXN0
X3N0YXRlKSkKPiArCQlyZXR1cm4gUFRSX0VSUihtc3Rfc3RhdGUpOwo+ICsKPiArCWxpc3RfZm9y
X2VhY2hfZW50cnkocG9zLCAmbXN0X3N0YXRlLT52Y3BpcywgbmV4dCkgewo+ICsJCWlmIChwb3Mt
PnBvcnQgPT0gcG9ydCkgewo+ICsJCQlmb3VuZCA9IHRydWU7Cj4gKwkJCWJyZWFrOwo+ICsJCX0K
PiArCX0KPiArCj4gKwlpZiAoIWZvdW5kKSB7Cj4gKwkJRFJNX0RFQlVHX0FUT01JQygiW01TVCBQ
T1JUOiVwXSBDb3VsZG4ndCBmaW5kIFZDUEkgYWxsb2NhdGlvbiBpbiBtc3Qgc3RhdGUgJXBcbiIs
Cj4gKwkJCQkgcG9ydCwgbXN0X3N0YXRlKTsKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCX0KPiAr
Cj4gKwlpZiAocG9zLT5kc2NfZW5hYmxlZCA9PSBlbmFibGUpIHsKPiArCQlEUk1fREVCVUdfQVRP
TUlDKCJbTVNUIFBPUlQ6JXBdIERTQyBmbGFnIGlzIGFscmVhZHkgc2V0IHRvICVkLCByZXR1cm5p
bmcgJWQgVkNQSSBzbG90c1xuIiwKPiArCQkJCSBwb3J0LCBlbmFibGUsIHBvcy0+dmNwaSk7Cj4g
KwkJdmNwaSA9IHBvcy0+dmNwaTsKCkRvIHdlIHdhbnQgdG8gZWFybHkgcmV0dXJuIGhlcmU/Cgot
IExlbwoKPiArCX0KPiArCj4gKwlpZiAoZW5hYmxlKSB7Cj4gKwkJdmNwaSA9IGRybV9kcF9hdG9t
aWNfZmluZF92Y3BpX3Nsb3RzKHN0YXRlLCBwb3J0LT5tZ3IsIHBvcnQsIHBibiwgcGJuX2Rpdik7
Cj4gKwkJRFJNX0RFQlVHX0FUT01JQygiW01TVCBQT1JUOiVwXSBFbmFibGluZyBEU0MgZmxhZywg
cmVhbGxvY2F0aW5nICVkIFZDUEkgc2xvdHMgb24gdGhlIHBvcnRcbiIsCj4gKwkJCQkgcG9ydCwg
dmNwaSk7Cj4gKwkJaWYgKHZjcGkgPCAwKQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsKPiArCX0KPiAr
Cj4gKwlwb3MtPmRzY19lbmFibGVkID0gZW5hYmxlOwo+ICsKPiArCXJldHVybiB2Y3BpOwo+ICt9
Cj4gK0VYUE9SVF9TWU1CT0woZHJtX2RwX21zdF9hdG9taWNfZW5hYmxlX2RzYyk7Cj4gIC8qKgo+
ICAgKiBkcm1fZHBfbXN0X2F0b21pY19jaGVjayAtIENoZWNrIHRoYXQgdGhlIG5ldyBzdGF0ZSBv
ZiBhbiBNU1QgdG9wb2xvZ3kgaW4gYW4KPiAgICogYXRvbWljIHVwZGF0ZSBpcyB2YWxpZAo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1fZHBfbXN0X2hlbHBlci5oIGIvaW5jbHVkZS9kcm0v
ZHJtX2RwX21zdF9oZWxwZXIuaAo+IGluZGV4IGZjMTkwOTRiMDZjMy4uYjFiMDBkZTMwODNiIDEw
MDY0NAo+IC0tLSBhL2luY2x1ZGUvZHJtL2RybV9kcF9tc3RfaGVscGVyLmgKPiArKysgYi9pbmNs
dWRlL2RybS9kcm1fZHBfbXN0X2hlbHBlci5oCj4gQEAgLTQzMSw2ICs0MzEsNyBAQCBzdHJ1Y3Qg
ZHJtX2RwX3BheWxvYWQgewo+ICBzdHJ1Y3QgZHJtX2RwX3ZjcGlfYWxsb2NhdGlvbiB7Cj4gIAlz
dHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0Owo+ICAJaW50IHZjcGk7Cj4gKwlib29sIGRzY19l
bmFibGVkOwo+ICAJc3RydWN0IGxpc3RfaGVhZCBuZXh0Owo+ICB9Owo+ICAKPiBAQCAtNjYzLDYg
KzY2NCwxMCBAQCBkcm1fZHBfYXRvbWljX2ZpbmRfdmNwaV9zbG90cyhzdHJ1Y3QgZHJtX2F0b21p
Y19zdGF0ZSAqc3RhdGUsCj4gIAkJCSAgICAgIHN0cnVjdCBkcm1fZHBfbXN0X3RvcG9sb2d5X21n
ciAqbWdyLAo+ICAJCQkgICAgICBzdHJ1Y3QgZHJtX2RwX21zdF9wb3J0ICpwb3J0LCBpbnQgcGJu
LAo+ICAJCQkgICAgICBpbnQgcGJuX2Rpdik7Cj4gK2ludCBkcm1fZHBfbXN0X2F0b21pY19lbmFi
bGVfZHNjKHN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSwKPiArCQkJCSBzdHJ1Y3QgZHJt
X2RwX21zdF9wb3J0ICpwb3J0LAo+ICsJCQkJIGludCBwYm4sIGludCBwYm5fZGl2LAo+ICsJCQkJ
IGJvb2wgZW5hYmxlKTsKPiAgaW50IF9fbXVzdF9jaGVjawo+ICBkcm1fZHBfYXRvbWljX3JlbGVh
c2VfdmNwaV9zbG90cyhzdHJ1Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUsCj4gIAkJCQkgc3Ry
dWN0IGRybV9kcF9tc3RfdG9wb2xvZ3lfbWdyICptZ3IsCj4gCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
