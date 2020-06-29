Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E80C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECA223D23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Su+0W43h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECA223D23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495248918A;
	Mon, 29 Jun 2020 12:41:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10CD8918A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 12:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+iEssT8YkCaXyZbSHLUt1IswkG/DHo8T9p+YoId1zCicxML3Tu5Lj/s8D5oIR6M0BfxSvUKdaULBR/0y1/ZCFqI2HufDVvZEi984x4eSILinocUVB3/ozKmJS+UKCuS9L0Hy77XVktQyqX9ZKvvlNP8UU4gT5wWdFlVtJe8Htu2Ck8fJYaWUvV7ehepxqf8kSC0jCSRHPIscBRO5UpQNlDCyPaSxCFeFSsBUmrxLS4e1xS6/OAbztyRD/p/3FmGRCub5q3UDsephry4Zp5JU/lHRwFSd1LpMOuz2O8Kz72eHiZvUDNviBkjM9GuwPwT8MemKt/2Xx56DRLlaUMpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MpkTYAaeRbTkXZoO5MIVyctUbAzV6YPFeIvZX7Qd7E=;
 b=RMtjXoLz1zuGfRMNKS+3mcKykCpoZAP1SteOK4efk7v+i4GWk/H9qzGP3VC0QigdbSH2CcmseZZzAtKNiY7TCQLszkj+kWHR16/eYUqSb4BF1ZbkQZvHSsv+y9V43enWyzlXDM/+OxjB6vKsSeBzyVDinOLlAH77DkiuA6RiSHQcvVcp+9PN9KXRqO30xDWlWaGc5aMvGM6La8Yx335gJ2T8XNayRjMv368OPEM1ReMJGPwcr88Cp33zj282pq2MGQKEg9/ZAtxUs7gMG0685+efXDxTVBK4byAqT7dn757sYjjkLcELPIgpKKNxHKkMS5HYQEiA9fhXZC6AGAPL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MpkTYAaeRbTkXZoO5MIVyctUbAzV6YPFeIvZX7Qd7E=;
 b=Su+0W43hyvNnDnO9argJZsANwent2sNSLNvnnCm0Zi95lwCOuhtWvpUzirZO1zu+qEThElEIzrzU90rdilNg9skUkCfgxZ5QDUJ/mS2lb4DIqZsO5FmshgSG35fBSlXmoie2xCGTOckZ29y+hqW8fU0KoFLBNA+Puwsims79tWg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 12:41:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 12:41:17 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200629121313.18064-1-kent.russell@amd.com>
 <ade43f8c-6ea1-ea69-d173-323e1d1f1867@gmail.com>
 <DM6PR12MB3721818B463CF5BE7BFD5F72856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <10dc15f9-4657-12bb-70ba-fa44ea137c88@amd.com>
 <DM6PR12MB3721970740F9380319133483856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1b7f620b-22f1-a80c-00b5-4ff980058890@amd.com>
Date: Mon, 29 Jun 2020 14:41:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <DM6PR12MB3721970740F9380319133483856E0@DM6PR12MB3721.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Mon, 29 Jun 2020 12:41:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c64f96c-e7e0-4908-7345-08d81c29b769
X-MS-TrafficTypeDiagnostic: MN2PR12MB4392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43921EB1C46C3B2934CAFC61836E0@MN2PR12MB4392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6bvCZM3iYRDkCxMLXtDdCmGQhI9OTviFZQIO+1DNTWQ9qZpENTSWkkfGDBr9237T7MVpL+urSph94gVwXJvVbs8V4Z/nQD5xA3HFtbDmadxxjLeOtrrqSQcWZS4exaCDepYXj2dzSLpIKlikjxMRUeiKZ+zmxOuqGERb+B2lvexFWthd9i2r9uDWNWINF1TvQj3I3YbZUar3ekjuodnu23dXo3qqWgs77x66yFKHPRDlww7+n8zW7JthhCKA6OE2JO33b9zKMfJVDdeFg13qj1OTSQLgWjWhCBobK5xGL7RiJKjikok44E1Cqp/nnkL5bFSTs/pVptJUo+B5U8IWJrbSEJ3TnoNWO3wTaf1PyQ7WwwkOinugKWoxRGZFGob
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(83380400001)(86362001)(8936002)(6486002)(53546011)(31696002)(66574015)(16526019)(31686004)(186003)(2906002)(5660300002)(66476007)(66946007)(6666004)(478600001)(110136005)(36756003)(2616005)(52116002)(8676002)(66556008)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2dD/s1xmyvu9uU0UpPRFNzhucbQiV/N5wwdpT8+xxgNuf0z3qNC7XWgJUbP4t0342k7KsbLx75fjMr/0ooVurceUzhy7ufqrfpT9qRy9kXdo4vmF3EOG7mdu5JC6iMcguTyyfIEvHfMaOoGLw6L1+vzySnFU6nQmxcVm2X/VPH7tnIzk+lOQCne2/etP5/BY27KzeQn/Jtff9A+8qlmN54g2rYUpTOg2wOKIWhcEvzWZmflFaNzZ4DPUbWrZl+ojeZ5ZM++cNBYKQMNGqVYrI6oswQ9j3YQL2+VfqZb9ZLI87rFnEZ9W2jztYUSJ02n8Hw+SVHPRr5W5BGY8CCoiR9Gg+AUMYo+Mwp5vKRD4EU3OIqCUL9thypmkPgtu0r79TMV1p/1LY7foRM2BCe5iesgAVdD0N67w9TNkXBfNSBjO+JmMbG8mG5pqxa47ZiaEvpdVHiFhkcP+37Hrr4SbQw0u/3VzIdZCu0uMf6hknJwyVU/IQv66zO5sScuyXbOw72BoPdITYyHDSE4dqRXx1odZxX54cKTsvb025uqNx8pi47909FWPbcfRWzZ66xrQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c64f96c-e7e0-4908-7345-08d81c29b769
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 12:41:17.1282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4avYUP98BPnkUAPuM2MbJ9ovfbgd7wnmXJFKS4mZtvEORc57DI/9LyI/kTbsOmTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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

Tm8sIHByb2JsZW0uIEkgZG9uJ3Qga25vdyB0aGlzIGNvZGUgYnV0IHRoZSBwYXRjaCBsb29rZWQg
a2luZCBvZiBmaXNoeSA6KQoKQW5kIHllcyB0aGF0IGhhcHBlbnMgdG8gYWxsIG9mIHVzLCB0aGF0
J3Mgd2h5IHdlIGRvIHRoaXMgcmV2aWV3LgoKQ2hyaXN0aWFuLgoKQW0gMjkuMDYuMjAgdW0gMTQ6
MzUgc2NocmllYiBSdXNzZWxsLCBLZW50Ogo+IFtBTUQgUHVibGljIFVzZV0KPgo+IFRoYW5rcyBm
b3IgbWFraW5nIG1lIGxvb2sgYXQgaXQgY3JpdGljYWxseSAoc29tZXRoaW5nIEkgc2hvdWxkIGRv
IG1vcmUgYWZ0ZXIgcmV0dXJuaW5nIGZyb20gMiB3ZWVrcyB2YWNhdGlvbikuIE5pcm1veSBmaXhl
ZCB0aGUgaXNzdWUgYnkgdXNpbmcgYSBzdGF0aWMgZGVmaW5lIGluIGhpcyAiIGRybS9hbWRncHU6
IGxhYmVsIGludGVybmFsbHkgdXNlZCBzeW1ib2xzIGFzIHN0YXRpYyIgcGF0Y2ggYW5kIEkgd2Fz
IGp1c3QgaW4gYXV0b3BpbG90IHRyeWluZyB0byBmaXggdGhlIEludGVsIGtib3QgZXJyb3IgZW1h
aWwgdGhhdCBJIHJlY2VpdmVkIHdoaWxlIGF3YXksIG5vdCBhY3R1YWxseSByZWFsaXppbmcgdGhh
dCBpdCB3YXMgZml4ZWQgYW5kIEkgd2FzIGJyZWFraW5nIGFuZCB1bmJyZWFraW5nIGl0IGR1cmlu
ZyByZWJhc2luZy4gVGhpcyB0aHJlYWQgY2FuIGJlIGlnbm9yZWQuIFRpbWUgZm9yIHNvbWUgY29m
ZmVlLgo+Cj4gICBLZW50Cj4KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTog
S29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4KPj4gU2VudDogTW9u
ZGF5LCBKdW5lIDI5LCAyMDIwIDg6MjkgQU0KPj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVz
c2VsbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogRml4IGNvbXBpbGUgd2FybmluZyBpbgo+PiBhbWRncHVf
ZnJ1X3JlYWRfZWVwcm9tCj4+Cj4+IE9rLCB0aGVuIHdoeSBkb2VzIGl0IGZpeCBhIHdhcm5pbmcg
aWYgd2UgbWFrZSBpdCBub24tc3RhdGljPwo+Pgo+PiBJZiB0aGUgZnVuY3Rpb24gdXNlZCBpdCBj
b21waWxlZCB1bmRlciBzb21lICNpZmRlZiB0aGVuIHdlIHNob3VsZCBwcm9iYWJseQo+PiBqdXN0
IGNvbXBpbGUgdGhpcyB1bmRlciAjaWZkZWYgYXMgd2VsbC4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+
PiBBbSAyOS4wNi4yMCB1bSAxNDoyMCBzY2hyaWViIFJ1c3NlbGwsIEtlbnQ6Cj4+PiBbQU1EIFB1
YmxpYyBVc2VdCj4+Pgo+Pj4gSXQncyB1c2VkIHJlcGVhdGVkbHkgaW4gdGhlIGFtZGdwdV9mcnVf
Z2V0X3Byb2R1Y3RfaW5mbyBmdW5jdGlvbiwgYnV0IG9ubHkKPj4gaW4gdGhhdCBmdW5jdGlvbiB3
aGljaCBpcyBpbiB0aGUgYW1kZ3B1X2ZydV9lZXByb20uYyBmaWxlLiBXaGlsZSBpdCBjb3VsZCBi
ZQo+PiB0aGVvcmV0aWNhbGx5IGJlIHVzZWQgZWxzZXdoZXJlLCBpdCBpc24ndCBjdXJyZW50bHkg
YW5kIGFueSBvdGhlciB1c2FnZSB3b3VsZAo+PiBiZSBiZXN0IGNvbnRhaW5lZCBpbiB0aGUgYW1k
Z3B1X2ZydV9lZXByb20uYyBmaWxlLgo+Pj4gICAgS2VudAo+Pj4KPj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQo+Pj4+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0
enVtZXJrZW5AZ21haWwuY29tPgo+Pj4+IFNlbnQ6IE1vbmRheSwgSnVuZSAyOSwgMjAyMCA4OjE3
IEFNCj4+Pj4gVG86IFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBhbWQuY29tPjsKPj4+PiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRy
bS9hbWRncHU6IEZpeCBjb21waWxlIHdhcm5pbmcgaW4KPj4+PiBhbWRncHVfZnJ1X3JlYWRfZWVw
cm9tCj4+Pj4KPj4+PiBBbSAyOS4wNi4yMCB1bSAxNDoxMyBzY2hyaWViIEtlbnQgUnVzc2VsbDoK
Pj4+Pj4gVGhpcyBmaXhlcyB0aGUgbWlzc2luZy1wcm90b3R5cGVzIHdhcm5pbmcgZm9yIHRoZQo+
Pj4+PiBhbWRncHVfZnJ1X3JlYWRfZWVwcm9tIGZ1bmN0aW9uLiBTaW5jZSB3ZSBkZWNsYXJlIGl0
IGluIHRoZSBoZWFkZXIsCj4+Pj4+IHdlIGNhbiBtYWtlIGl0IHVuLXN0YXRpYwo+Pj4+IFdlbGwg
aXMgaXQgdXNlZCBpbiBkaWZmZXJlbnQgZmlsZXM/IE90aGVyd2lzZSB3ZSBtaWdodCBqdXN0IGhh
dmUKPj4+PiB1bnVzZWQgY29kZSBpbiB0aGUgbW9kdWxlIHdoaWNoIGNhbiBwb3RlbnRpYWxseSBy
YWlzZSBhIHdhcm5pbmcgYXMgd2VsbC4KPj4+Pgo+Pj4+IENocmlzdGlhbi4KPj4+Pgo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3NlbGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPgo+Pj4+PiBS
ZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4+Pj4+IENoYW5n
ZS1JZDogSTJiOTQxOTM2NWNiOGIzOGJjZmI2NTgyZGY1M2I5NmM4Mzg2MWQ2Y2YKPj4+Pj4gLS0t
Cj4+Pj4+ICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5j
IHwgMiArLQo+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9l
ZXByb20uaCB8IDIgKysKPj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYwo+Pj4+PiBpbmRleCBlODExZmVjYzU0MGYuLjY4
ZWQxNmU0ZDhiZSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZydV9lZXByb20uYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZnJ1X2VlcHJvbS5jCj4+Pj4+IEBAIC00OCw3ICs0OCw3IEBAIHN0YXRpYyBib29s
IGlzX2ZydV9lZXByb21fc3VwcG9ydGVkKHN0cnVjdAo+Pj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4+Pj4+ICAgICAJcmV0dXJuIGZhbHNlOwo+Pj4+PiAgICAgfQo+Pj4+Pgo+Pj4+PiAtc3RhdGlj
IGludCBhbWRncHVfZnJ1X3JlYWRfZWVwcm9tKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+
Pj4+PiB1aW50MzJfdCBhZGRycHRyLAo+Pj4+PiAraW50IGFtZGdwdV9mcnVfcmVhZF9lZXByb20o
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90Cj4+Pj4+ICthZGRycHRyLAo+Pj4+
PiAgICAgCQkJICAgdW5zaWduZWQgY2hhciAqYnVmZikKPj4+Pj4gICAgIHsKPj4+Pj4gICAgIAlp
bnQgcmV0LCBzaXplOwo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ZydV9lZXByb20uaAo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mcnVfZWVwcm9tLmgKPj4+Pj4gaW5kZXggZjI5YTg2MTFkNjliLi5mNDAyNGYxZDY2
YzkgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9m
cnVfZWVwcm9tLmgKPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZydV9lZXByb20uaAo+Pj4+PiBAQCAtMjQsNiArMjQsOCBAQAo+Pj4+PiAgICAgI2lmbmRlZiBf
X0FNREdQVV9GUlVfRUVQUk9NX0hfXwo+Pj4+PiAgICAgI2RlZmluZSBfX0FNREdQVV9GUlVfRUVQ
Uk9NX0hfXwo+Pj4+Pgo+Pj4+PiAraW50IGFtZGdwdV9mcnVfcmVhZF9lZXByb20oc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90Cj4+Pj4gYWRkcnB0ciwKPj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGNoYXIgKmJ1ZmYpOwo+Pj4+PiAgICAgaW50IGFt
ZGdwdV9mcnVfZ2V0X3Byb2R1Y3RfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4+
Pj4+Cj4+Pj4+ICAgICAjZW5kaWYgIC8vIF9fQU1ER1BVX1BST0RJTkZPX0hfXwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
