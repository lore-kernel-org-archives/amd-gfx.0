Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84FC11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 18:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FE024695
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 18:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k0rR99gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FE024695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3897A6ECC1;
	Thu, 27 Feb 2020 18:43:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EB16ECC1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 18:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcTMZ5twrcoVnrHYd6/ylEbKkkSZh7VXlBalzXwaT+viuxYOJmeP8D30VQJpk/RKHuJSiTmmWp/5rs/YOQx5+jRNrCpcU5MgRR0HPj763F1zGuo1F9DplDjRGtfFk8V86HC4JLknUfoQgPf7jm/YV580moFj3oAjFgycK0P4MqU255nBVnQFHrEHO6xOZ8sr7RA/cdLGqkH1fFxBkaAWy022oYzvGGYHqq/Xxf0nf8lF9yBOWhx+PR9d2KOjRTz90xChYK/WHAbZghIVKGe+wsSGMsFqzoyixesd6J+BAQwIXpVoIGuPlLUCQt8n8QKN3uLNiohAd6o8bqB4h+ai7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtZ3+q7xXKROHW1w5FXAyHmHdvsOQ/jWm1YrV7RBqSs=;
 b=XD1iPkBRlc6q9tyjhfw5WPGTyBJKLC7+M8cC2nZjIX/6psOpAMMC9hobtZ4Y37DxiSe4vZhgLAwiiUxpQ5yNd5Dv20HZQu8qbhSNbDjZxslE7Iyr1YSAvx3cS1wsgmNWCVMRt+sUj+E7IR/rAfugfMlNmEVXEemsPRzsL/dcxMvnp4cCXlQoj6cC7k4ZrjOwov0wJtDeXdaUUD1XtydqPPMiSOqp6Ks/GLnkpTVoW20/D9TuE5L8naDoTYklIOGmC+P8kJsJX4fdRcz28bIId7pohPyeSjd2cV5KHoptn+RQgFY9hHlmso5lPA7imAXhMKwpsVmLTMTr2/sp60WFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtZ3+q7xXKROHW1w5FXAyHmHdvsOQ/jWm1YrV7RBqSs=;
 b=k0rR99giWdtr54GueDaNY6AW+/N4zivjfkBj9gPAPup/DX3JSHIGQC9kV6eYYu3kLllgFrOwVGN8pqFOz7lttnCaEDM8k8cm5wmzHzhB54U4ezkTwM54TM68y/pxaTo3XjI2nfvg3uzEP8MadanPWipxsuuIyGlubcFZvKYs76c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0025.namprd12.prod.outlook.com (2603:10b6:4:53::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 18:43:19 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::6c24:8172:ed3c:5a8a%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 18:43:18 +0000
Subject: Re: [PATCH] drm/amdgpu: stop allocating PDs/PTs with the eviction
 lock held
To: christian.koenig@amd.com, alex.sierra@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20200212151426.14197-1-christian.koenig@amd.com>
 <7f0c6e3e-be75-3fa8-a5e7-d8ae6bf0dba5@amd.com>
 <eaf782de-e45d-70df-9211-69a96f8ccd80@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7c0d8432-9fe0-a734-2080-5bf4965247d2@amd.com>
Date: Thu, 27 Feb 2020 12:43:17 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <eaf782de-e45d-70df-9211-69a96f8ccd80@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0201CA0051.namprd02.prod.outlook.com
 (2603:10b6:803:20::13) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.189.239] (165.204.77.1) by
 SN4PR0201CA0051.namprd02.prod.outlook.com (2603:10b6:803:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Thu, 27 Feb 2020 18:43:18 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee700d18-c3e7-4143-52d1-08d7bbb4e9bf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:|DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0025216DAC2ECCFD132E77E492EB0@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(16526019)(8676002)(16576012)(5660300002)(186003)(44832011)(26005)(53546011)(316002)(81156014)(66476007)(66556008)(81166006)(478600001)(86362001)(2906002)(66946007)(31696002)(66574012)(36756003)(52116002)(8936002)(2616005)(956004)(6486002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0025;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EW8DNRIduGdsmjWCTLDE895nuqsqRUec65wClZsr5mgcoNWT/6yMrMpqgrnLXtPP/n9IgpKWQuaMUGjO5I+f/Y2JQnlKyf176BFXGNTozV/Eba/1D/pDLmH2fe2eJo9alJGg/NvwVzOYPykXrnqHFQiZ8KJeZ14pPmLckX+A28CAY7c9XiOUs+8ugVzcJwab2LpbO8lVBFBL1d6HVeNuX1CkAF6c2H6Z+IhmTRpKYoIyzNQ+JCp6Sry/CEtxD8V7vCCO5ba6t0XKCbP6gE3l74bijb52Twb00LvC+D/bZtXdzWn66T+CXoDXDRyT+u5byTqnkgXb3S27JQztW9LueZJpHwn1jjopiuNT4d/Emr42RZ1m41ppSFVL7u+kw38dmicYNLAH3j7EiTobGrIjwLkTB7LXcWcRO9bQ+aIDBybRL/fgX4bxbSnJt0abpdGe
X-MS-Exchange-AntiSpam-MessageData: t1PlAqdQ1pSdxWhonQTHkTXnYbhaI8LpLQyncixeFqRrIDzKX4WF93UyEL6sa312Wire6dvHLQVCbpy5VZcf/loeCXZoQ6q0/GWxLYPRzH+FtKz7w08U740+q8FAnhIRh0CMMuGbaOYNiJMMXE4ndQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee700d18-c3e7-4143-52d1-08d7bbb4e9bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 18:43:18.8810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHMgLxaBKmp7CRAB4+s+cMFHBC41HY1g8RNFgNWKZldaEBIG2uv+WSegVfrzm3jMR+121MK8OEJlM/LgNNYtBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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

T24gMjAyMC0wMi0yNyA5OjI4LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEhpIEZlbGl4LAo+
Cj4gc28gY29taW5nIGJhY2sgdG8gdGhpcyBhZnRlciB0d28gd2Vla3Mgb2YgZGlzdHJhY3Rpb24u
Cj4KPiBBbSAxNC4wMi4yMCB1bSAyMjoxMiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBOb3cg
eW91IGFsbG93IGV2aWN0aW9uIG9mIHBhZ2UgdGFibGVzIHdoaWxlIHlvdSBhbGxvY2F0ZSBwYWdl
IHRhYmxlcy4gCj4+IElzbid0IHRoZSB3aG9sZSBwb2ludCBvZiB0aGUgZXZpY3Rpb24gbG9jayB0
byBwcmV2ZW50IHBhZ2UgdGFibGUgCj4+IGV2aWN0aW9ucyB3aGlsZSBtYW5pcHVsYXRpbmcgcGFn
ZSB0YWJsZXM/Cj4+Cj4+IE9yIGRvZXMgdGhpcyBvbmx5IGFwcGx5IHRvIFBURSBpbnZhbGlkYXRp
b25zIHdoaWNoIG5ldmVyIGFsbG9jYXRlZCAKPj4gbWVtb3J5PyBJcyB0aGF0IHRoZSBvbmx5IGNh
c2UgdGhhdCBkb2Vzbid0IHJlc2VydmUgcGFnZSB0YWJsZXM/Cj4KPiBZZXMsIGV4YWN0bHkuIFdl
IGVzc2VudGlhbGx5IGhhdmUgdG8gZGlzdGluY3QgdHdvIGNhc2VzIGhlcmU6Cj4KPiAxLiBXZSBh
cmUgdmFsaWRhdGluZyBQVEVzIGFuZCBzbyBldmVudHVhbGx5IG5lZWQgdG8gYWxsb2NhdGUgcGFn
ZSB0YWJsZXMuCj4gwqDCoMKgIEZvciB0aGlzIHRoZSByb290IFBEIGlzIHJlc2VydmVkIGFuZCB3
ZSBhY3R1YWxseSBrbm93IHRoYXQgdGhlIFZNIAo+IGNhbid0IGJlIGV2aWN0ZWQuCj4gwqDCoMKg
IEJ1dCB3ZSBzdGlsbCBuZWVkIHRvIGhvbGQgdGhlIGxvY2sgd2hpbGUgcHVzaGluZyB0aGUgYWN0
dWFsIAo+IHVwZGF0ZXMgdGhlIGhhcmR3YXJlIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBtZXNzIHVw
IHRoZSBkYXRhIHN0cnVjdHVyZXMgCj4gd2l0aCBjb25jdXJyZW50IGludmFsaWRhdGlvbnMuCj4K
PiAyLiBXZSBhcmUgaW52YWxpZGF0aW5nIFBURXMuCj4gwqDCoMKgIEhlcmUgd2UgbWlnaHQgb3Ig
bWlnaHQgbm90IGhhdmUgdGhlIHJvb3QgUEQgcmVzZXJ2ZWQgYW5kIHNvIG5lZWQgCj4gdG8gbWFr
ZSBzdXJlIHRoYXQgbm9ib2R5IGlzIGV2aWN0aW5nIHBhZ2UgdGFibGVzIHdoaWxlIHdlIGFyZSAK
PiBpbnZhbGlkYXRpbmcuCj4KPiBRdWl0ZSBhIGNvbXBsaWNhdGVkIGRhbmNlLCBidXQgb2YgaGFu
ZCBJIGFsc28gZG9uJ3Qgc2VlIG11Y2ggb3RoZXIgCj4gY2hvaWNlLgoKU291bmRzIGdvb2QuIE1h
eWJlIHdlIHNob3VsZCBoYXZlIGFuIGFzc2VydCB0aGF0IHRoZSByb290IFBEIGlzIHJlc2VydmVk
IAppbiBhbWRncHVfdm1fYWxsb2NfcHRzLiBXaXRoIHRoYXQgbW9kaWZpY2F0aW9uIHRoZSBwYXRj
aCBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
PgoKCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+PiBSZWdhcmRzLAo+PiDCoCBGZWxp
eAo+Pgo+PiBPbiAyMDIwLTAyLTEyIDEwOjE0IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4+PiBXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0byBub3QgYWxsb2NhdGUgUERzL1BUcyB3aGlsZSBo
b2xkaW5nCj4+PiB0aGUgZXZpY3Rpb24gbG9jayBvciBvdGhlcndpc2Ugd2Ugd2lsbCBydW4gaW50
byBsb2NrIGludmVyc2lvbgo+Pj4gaW4gdGhlIE1NIGFzIHNvb24gYXMgd2UgZW5hYmxlIHRoZSBN
TVUgbm90aWZpZXIuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYyB8IDMxIAo+Pj4gKysrKysrKysrKysrKysrKysrKysrLS0tLS0K
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+
Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IGluZGV4
IDc3YzQwMDY3NWI3OS4uZTdhYjBjMWUyNzkzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCj4+PiBAQCAtODk3LDI3ICs4OTcsNDIgQEAgc3RhdGljIGludCBh
bWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+PiDC
oMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5ID0gY3Vyc29yLT5lbnRyeTsKPj4+
IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSBicDsKPj4+IMKgwqDCoMKgwqAgc3Ry
dWN0IGFtZGdwdV9ibyAqcHQ7Cj4+PiArwqDCoMKgIGJvb2wgbmVlZF9lbnRyaWVzOwo+Pj4gwqDC
oMKgwqDCoCBpbnQgcjsKPj4+IMKgIC3CoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwgPCBBTURHUFVf
Vk1fUFRCICYmICFlbnRyeS0+ZW50cmllcykgewo+Pj4gK8KgwqDCoCBuZWVkX2VudHJpZXMgPSBj
dXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQiAmJiAhZW50cnktPmVudHJpZXM7Cj4+PiArwqDC
oMKgIGlmICghbmVlZF9lbnRyaWVzICYmIGVudHJ5LT5iYXNlLmJvKQo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHJldHVybiAwOwo+Pj4gKwo+Pj4gK8KgwqDCoCAvKiBXZSBuZWVkIHRvIG1ha2Ugc3VyZSB0
aGF0IHdlIGRvbid0IGFsbG9jYXRlIFBEcy9QVHMgd2hpbGUgCj4+PiBob2xkaW5nIHRoZQo+Pj4g
K8KgwqDCoMKgICogZXZpY3Rpb24gbG9jayBvciB3ZSBydW4gaW50byBsb2NrIHJlY3Vyc2lvbiBp
biB0aGUgTU0uCj4+PiArwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqAgYW1kZ3B1X3ZtX2V2aWN0aW9u
X3VubG9jayh2bSk7Cj4+PiArCj4+PiArwqDCoMKgIGlmIChuZWVkX2VudHJpZXMpIHsKPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBudW1fZW50cmllczsKPj4+IMKgIMKgwqDCoMKgwqDC
oMKgwqDCoCBudW1fZW50cmllcyA9IGFtZGdwdV92bV9udW1fZW50cmllcyhhZGV2LCBjdXJzb3It
PmxldmVsKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IGt2bWFsbG9j
X2FycmF5KG51bV9lbnRyaWVzLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKCplbnRyeS0+ZW50cmllcyksCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBHRlBfS0VSTkVMIHwgX19H
RlBfWkVSTyk7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKCFlbnRyeS0+ZW50cmllcykKPj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGlmICghZW50cnktPmVudHJpZXMpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAt
RU5PTUVNOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl9sb2NrOwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIH0KPj4+IMKgwqDCoMKgwqAgfQo+Pj4gwqAgLcKgwqDCoCBpZiAoZW50
cnktPmJhc2UuYm8pCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+PiArwqDCoMKgIGlm
IChlbnRyeS0+YmFzZS5ibykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIHIgPSAwOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIGdvdG8gZXJyb3JfbG9jazsKPj4+ICvCoMKgwqAgfQo+Pj4gwqAgwqDCoMKgwqDC
oCBhbWRncHVfdm1fYm9fcGFyYW0oYWRldiwgdm0sIGN1cnNvci0+bGV2ZWwsIGRpcmVjdCwgJmJw
KTsKPj4+IMKgIMKgwqDCoMKgwqAgciA9IGFtZGdwdV9ib19jcmVhdGUoYWRldiwgJmJwLCAmcHQp
Owo+Pj4gK8KgwqDCoCBhbWRncHVfdm1fZXZpY3Rpb25fbG9jayh2bSk7Cj4+PiDCoMKgwqDCoMKg
IGlmIChyKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiByOwo+Pj4gK8KgwqDCoMKgwqDCoMKg
IGdvdG8gZXJyb3JfZnJlZV9wdDsKPj4+IMKgIMKgwqDCoMKgwqAgLyogS2VlcCBhIHJlZmVyZW5j
ZSB0byB0aGUgcm9vdCBkaXJlY3RvcnkgdG8gYXZvaWQKPj4+IMKgwqDCoMKgwqDCoCAqIGZyZWVp
bmcgdGhlbSB1cCBpbiB0aGUgd3Jvbmcgb3JkZXIuCj4+PiBAQCAtOTM2LDYgKzk1MSwxMCBAQCBz
dGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IAo+Pj4gYW1kZ3B1X2RldmljZSAq
YWRldiwKPj4+IMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZwdCk7Cj4+PiDCoMKgwqDCoMKg
IGVudHJ5LT5iYXNlLmJvID0gTlVMTDsKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+PiArCj4+
PiArZXJyb3JfbG9jazoKPj4+ICvCoMKgwqAgYW1kZ3B1X3ZtX2V2aWN0aW9uX2xvY2sodm0pOwo+
Pj4gK8KgwqDCoCByZXR1cm4gcjsKPj4+IMKgIH0KPj4+IMKgIMKgIC8qKgo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
