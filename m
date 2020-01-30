Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C03C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F64B20661
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HZn01cUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F64B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070DE6FA22;
	Thu, 30 Jan 2020 19:03:03 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA826FA22
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 19:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVSH/9o3SlpAukSe73tODAC7BoP8p3ByA8hiXZYtqBbii7derP8FIcb2KvV1FXDALXgQUnTivukbBffTl06dZ1fR1CYMJ+uxrduGlGRnA/xRJlGrD0iJ6sz3ilolU2SJhdMfUsgXx060YjGx28QSm8oI7yf5TWUDYz8gtGS10CmrsgQA1uDMVrOUiBQFvbqmXxrNSFxRILPPoiJIFy5acrrE1UyNYCBCN+U0Wz9uS8CfpmEmkz1v6gf+jIcVzzX+l+11nB6ZSI3sZnmQ4dja8jwz5usTkblLA+OIl9RT5w0N7FhSggoRM30gg91xps6cI6Gei8Oq2O7b/optzQTniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoEYnDGbMkcu+wVf+8R9310GRWtipY7gWvDMCAtrBIo=;
 b=KUklTQL4cgXfWUSxG6jbKiEZhe9XVhEtbTAQTcU87JgwdE4ftRdsz5UAGzqMRaO8lCHx6TYM1OhCOlRB1+AOXFb5h1WYJsxxO7+X2m1addlTou4dyxS9RVdacI5EH7Bq83aRg0ZzYw4JT52+HyWCT1QA3lQqq+CfEMbvzJGh8voU8JK0FGUOseH6Bj8DWqI6P1K+fdXHyeCSezEdoRdPM+mtnEsbktlB37aG6p6jQOcJUWni2A3S14Cftls4ZtsjleUIUxDMWxPXihjE9+14w9yDqhHEzM5t3lMcDOwsJ3tsCfxGsV2B9ZG3HmO/rqF/RYvBLWn1lABTGmZDoZxTNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoEYnDGbMkcu+wVf+8R9310GRWtipY7gWvDMCAtrBIo=;
 b=HZn01cUPJSkWaVZ9t9lVy9IEJtt/Pl5BOlVOQ5xnDgtUcJvbddEZJPfXR3f4LqyUqzKdz3GcNOtpUsjWatYtO7vY6gZSNe7QzpE9jK0mGO8bvLgURaksH4ZAGGNGiOLzN9KC4loUkbgdSosv+VR0/Ke9P8VPeAH76rnadOMYyII=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2575.namprd12.prod.outlook.com (52.132.194.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 19:03:00 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 19:03:00 +0000
Subject: Re: [Patch v1 4/5] drm/amdkfd: show warning when kfd is locked
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-5-rajneesh.bhardwaj@amd.com>
 <5209ef6a-693a-db6c-4ed2-6f234cc00a14@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
Message-ID: <6f29ebee-31db-1e1d-37fa-adcab4b5244b@amd.com>
Date: Thu, 30 Jan 2020 14:02:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <5209ef6a-693a-db6c-4ed2-6f234cc00a14@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::21) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from [172.27.232.179] (165.204.55.251) by
 YTXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend
 Transport; Thu, 30 Jan 2020 19:02:59 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83057562-b59b-43ee-0885-08d7a5b70630
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257520B24B20FF133726440FFE040@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(86362001)(31696002)(2616005)(956004)(5660300002)(4326008)(26005)(53546011)(66556008)(81166006)(66946007)(31686004)(52116002)(66476007)(81156014)(8936002)(8676002)(16526019)(6486002)(36756003)(316002)(16576012)(186003)(478600001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyhaLH7O1xygzkcmPXgm5PPJoWMwJgzGd9ARKYKYStNxtuEDfDCpE7tqUqj+DCvFhRyK83i5X7fufGP+DgSH1o/Gvtu15WfXx/kGCQXAi20WaafvuUl14LE5/teCtUUEl0qB1zaxvFeCYR3XN6Ru3Pp/Byn6uzLU6YUZpfaaHdRAIsfCm5p720M2C0F6i88WxxthZq4isUHZ06Y+UrLGdYT2Pesyjx37llrDO+mMXacox7ak48jn5flUshd0wc/P0eoEG0AxS0UmfzX8rjsClsE3LyXD/0JhtKD0US97up0GZwQadznmoP2Qj8DpMh3cElK/ChDxcg3dDATSmp4SDwv7WvhDYYXAAWvFpCmzdbq7V1mFZCoX7h9YeovktpI1b9Vz7byiwimyKjOZJdwQdNDem6+E6dWyZmbpb5DtM7wfMLgee0cfe5a8TvX5EVFZ
X-MS-Exchange-AntiSpam-MessageData: tRTHP8O7Zon8Z24r9nTNXzri3gSPcU40hH69ZSrTmt62mRy3M6YuQX3cGiwigWaL6ns5H93SkIDqffuH6e0N/OeK6/C3B55jFMMzW4lguKJlxL8KMgla2KnuEnHenA1DEyK+QNVRQzrupe9MPEMiGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83057562-b59b-43ee-0885-08d7a5b70630
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 19:02:59.9932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7AjTodNcjIBtjQn5nUBZsni+KCNVKGylFvbdOz2JmEPAQ7XjS9Z9MysIKWQ1/7sYwG0Bna884n/jSC3XJHKNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMjgvMjAyMCA1OjQyIFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBPbiAyMDIwLTAx
LTI3IDIwOjI5LCBSYWpuZWVzaCBCaGFyZHdhaiB3cm90ZToKPj4gRHVyaW5nIHN5c3RlbSBzdXNw
ZW5kIHRoZSBrZmQgZHJpdmVyIGFxdWlyZXMgYSBsb2NrIHRoYXQgcHJvaGliaXRzCj4+IGZ1cnRo
ZXIga2ZkIGFjdGlvbnMgdW5sZXNzIHRoZSBncHUgaXMgcmVzdW1lZC4gVGhpcyBhZGRzIHNvbWUg
aW5mbyB3aGljaAo+PiBjYW4gYmUgdXNlZnVsIHdoaWxlIGRlYnVnZ2luZy4KPj4KPj4gU2lnbmVk
LW9mZi1ieTogUmFqbmVlc2ggQmhhcmR3YWogPHJham5lZXNoLmJoYXJkd2FqQGFtZC5jb20+Cj4+
IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIHwgMiAr
Kwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jIAo+PiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPj4gaW5kZXggMWFlYmRhNGJiYmU3Li4w
ODFjYzVmNDBkMTggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9jaGFyZGV2LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJk
ZXYuYwo+PiBAQCAtMTI3LDYgKzEyNyw4IEBAIHN0YXRpYyBpbnQga2ZkX29wZW4oc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IAo+PiBmaWxlICpmaWxlcCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBQVFJfRVJSKHByb2Nlc3MpOwo+PiDCoCDCoMKgwqDCoMKgIGlmIChrZmRfaXNfbG9j
a2VkKCkpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGRldl93YXJuKGtmZF9kZXZpY2UsICJrZmQgaXMg
bG9ja2VkIVxuIgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJwcm9jZXNzICVk
IHVucmVmZXJlbmNlZCIsIHByb2Nlc3MtPnBhc2lkKTsKPgo+IElmIHRoaXMgaXMgZm9yIGRlYnVn
Z2luZywgbWFrZSBpdCBkZXZfZGJnLiBQcmludGluZyB3YXJuaW5ncyBsaWtlIHRoaXMgCj4gdXN1
YWxseSBjb25mdXNlcyBwZW9wbGUgcmVwb3J0aW5nIGNvbXBsZXRlbHkgdW5yZWxhdGVkIHByb2Js
ZW1zIHRoYXQgCj4gYXJlbid0IGV2ZW4ga2VybmVsIHByb2JsZW1zIGF0IGFsbC4gIkxvb2ssIEkg
Zm91bmQgYSB3YXJuaW5nIGluIHRoZSAKPiBrZXJuZWwgbG9nLiBJdCBtdXN0IGJlIGEga2VybmVs
IHByb2JsZW0uIgoKQWdyZWUuIFdpbGwgZml4IGluIHYyLgoKCj4KPiBSZWdhcmRzLAo+IMKgIEZl
bGl4Cj4KPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAga2ZkX3VucmVmX3Byb2Nlc3MocHJvY2Vzcyk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVBR0FJTjsKPj4gwqDCoMKgwqDCoCB9Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
