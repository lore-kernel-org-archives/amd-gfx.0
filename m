Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF7C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EDE2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 13:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wZ5urAJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EDE2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5174F6E1F7;
	Wed, 19 Aug 2020 13:04:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751E36E1F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 13:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcRzNDYiRUTn3R+8NByE8sw62lhYGS62PyFfeV+8r9yV4XEabcstQubYIpdsfE3bkIb6qrLZ0QD/8zMlihX7Nv7DdEb3xXhumdGMu7ffjQzRkVyGNOfH6X3/GdjFXarKKpRJa3kEhrhfdIMVk6BNLpmvQ+FkiBUZ2Z41/wpwKOIvhUNr63kzb5CulQTITOeEGZZiZpqozlOUKBZ6idwBl/zu7IXowER9RAjcmiTIslXyQSM9OHVAXNNMiL+WEYL8uS0dRV1rsLkPV74IA51kwC5rSBywiEGNuySNWg2V1nCLDLKt7qGtBNePwUQIm8VvsJy0oqy0JyDtW61hsvLt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRJdvy5rnevqmVlfGhCUrw4S1MHTLmyWY3z7o5ouhjs=;
 b=elV24WR7aZZbYc7MNvS3QwteFNqHSF3unlBBg993k18aSBo2YoZUROw7LIwsWVYRMtaQwW7Eh7Fpw53Lg4AqROM4NkwZN05UnI5pKNcg0L7DrLEfTzilfTeyOWlR5Sx1W6rvh//0XKqBObLeBGbQhLNiVAQJkVU6OOIt34MHnYcQB2+K5kFw126C7dXWxyZbTU/ZRNv7yJmFa2+36rLLnjPcLPMJR8nLtzenCp+6Q4dpM4tsBCE/fiUKKHrkoLwlaiV3u7TWYSf49ZurazTyJs2cq3ytUu7gra/0oGneNcQBGZaSmjjqd5uSer7t68Z8UdGm6k9+Zqem9q3Ezsce1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRJdvy5rnevqmVlfGhCUrw4S1MHTLmyWY3z7o5ouhjs=;
 b=wZ5urAJa9v/zmQCUXfqySpbUlDat5BBU91hXGqGGgTz2Pg5ejEQf5LGjQdhorVoJJ5cxjnnbfmwNlVzz3WFtQsD1z9JVzMMGU0lsz9kNG3dkEx9UamRkxVZOVa3b6VSCcqTOjERPu9PfUOmlDXe19DlGAXQ4tFKEBfuiwG8AGMQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Wed, 19 Aug
 2020 13:04:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 13:04:40 +0000
Subject: Re: [PATCH v4] drm/amdgpu: add new trace event for page table update
 v3
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200813030414.188468-1-shashank.sharma@amd.com>
 <35be9cda-025a-8f45-1648-00b96f57720e@amd.com>
 <ea572a64-37e4-d3db-f884-59f34bbdce38@amd.com>
 <7dbb15c2-9b28-6c30-872c-e64fc51d4879@amd.com>
 <3cc6b2fe-995d-581a-5e56-913a0cf60b42@amd.com>
 <42ef3112-81fb-d58b-4335-c19655f5db07@gmail.com>
 <99ecca3a-c2bb-f11a-6786-e0dfb853ba88@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <451e4ec1-40a8-f00e-d4c7-cbb34927062c@amd.com>
Date: Wed, 19 Aug 2020 15:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <99ecca3a-c2bb-f11a-6786-e0dfb853ba88@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::47) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0178.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Wed, 19 Aug 2020 13:04:39 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cdf3a8f5-9375-487f-088b-08d844406e9f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB420747CA318A497BBFAB732D835D0@MN2PR12MB4207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EHAGHtMlomyuf9oyk86YIFH+nHj8R1tbd6gyK8oSy/0ElDT7+Cw1pF1ZIs8o1MN7BRWSU8qEjWT/EBu+ap+l0Oskocejaz+cZeX57HqVrfsyyXG5sy5GovZKfmn+luWrw59EOLmG5Yr55e2d8yNsaaH3lEj7B9WvW6f5SRnq3xm0HS73Evw8AV4OUM1NErhkxFOpOHtvypzvd1skyQoIiZPDq25/Ey6o7huZ8HISS7qbU//XQmp4rnBbjiaF49wc2d6QPr45nnEh5OUtRZOsoG0YYogNQfywL3Ox3h4o2f9sWdrmlDbCBL0icgfY5cmPl2F0TnSgnRswKsFisSmaQsanh+VUVync/9DOx8iMpwAxSLhKTWm3JPM0OuG/LgJu4QkUbs06+KOMTpSkuJoxmGtFPtMdsF3Uwak3M4EfGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(2616005)(31686004)(52116002)(316002)(66556008)(86362001)(16526019)(186003)(45080400002)(31696002)(66946007)(66476007)(53546011)(5660300002)(15650500001)(8936002)(6666004)(8676002)(36756003)(2906002)(6486002)(478600001)(66574015)(83380400001)(966005)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6JnrgejTfWXN7KFajubgnGDmsgZ2EP8O3jZN9/oyohDI/s2zbBFoqxQPEEiNg+144Azq2gU0Stx20Xz403Ak6mTU2czrT4bqoFL94w3hy76Bv7SQ6m7LOMkmoAjSJ5Ps+/TIJDla+L+bkD8Hjpy4ezEnzQQwomzixPNcOIT/BtLV34j9zip0/w+nE+t6CAv+/pvfPt19Zos7NCc+2Or+CtLciiPuLfjEHxka8mJ7DZ/oNe9USPji52U4eczakq9HjdZEGm+il7JDn1wqlHbPxbKj4PJ3dRVPZU5Zmncl0liNYLJUoSWUULOgHt5K32fnU5y/3baTLBGTmnDVBgbet6PQgMMXp9+KEXiAsCLMeV1HhSQYTPWZhV0qSvSY84zQ9sIf09+BIjOKXRcZGo0YEePMssSHnbvpTm0TM1WtwRKzJmlzl1VvnHIA/T7XjdGPh1GAg8qTHLEwZdOki3r9zMSRNpbmxWS5Tw4Sl4Tn6S5s+icd4iZ+XwgLzIHE1OtCXItqPCPZxwaxM6SrRdHF8uJCIeZTM8rpOiQL99K9af/Yx3IqzXGJu/wvp4Un8emdeHhIpeYyLjKuY7bFOyznvhKpvZbD3HjN4nO8Wqm9hKvGJCxLYXzhyi4W8bvouEUdyL76Rw/S6Ld2O+dvoowujw2hPvaFvZf+KYnt4PZlQq3nMdqw6IQaAfU5qUqWCLC7K1Y3MwNoQQRJwBOhKqRC4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3a8f5-9375-487f-088b-08d844406e9f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 13:04:39.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTIwq24Kg51B6W1Vm6MmpoRHXV9X02P1KOjWbP7T4ziXoGzpf2w1NLGxYq8CCMXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTkuMDguMjAgdW0gMTQ6Mzcgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gT24gMTkvMDgv
MjAgNjowMyBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTkuMDguMjAgdW0gMTQ6
MTkgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4+PiBPbiAxOS8wOC8yMCA1OjM4IHBtLCBDaHJp
c3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+IEFtIDE5LjA4LjIwIHVtIDEzOjUyIHNjaHJpZWIgU2hh
c2hhbmsgU2hhcm1hOgo+Pj4+PiBPbiAxMy8wOC8yMCAxOjI4IHBtLCBDaHJpc3RpYW4gS8O2bmln
IHdyb3RlOgo+Pj4+Pj4gQW0gMTMuMDguMjAgdW0gMDU6MDQgc2NocmllYiBTaGFzaGFuayBTaGFy
bWE6Cj4+Pj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRo
ZSBQVEUgdXBkYXRlCj4+Pj4+Pj4gZXZlbnRzLiBUaGlzIHNwZWNpZmljIGV2ZW50IHdpbGwgcHJv
dmlkZSBpbmZvcm1hdGlvbiBsaWtlOgo+Pj4+Pj4+IC0gc3RhcnQgYW5kIGVuZCBvZiB2aXJ0dWFs
IG1lbW9yeSBtYXBwaW5nCj4+Pj4+Pj4gLSBIVyBlbmdpbmUgZmxhZ3MgZm9yIHRoZSBtYXAKPj4+
Pj4+PiAtIHBoeXNpY2FsIGFkZHJlc3MgZm9yIG1hcHBpbmcKPj4+Pj4+Pgo+Pj4+Pj4+IFRoaXMg
d2lsbCBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBtZW1vcnkgcHJvZmlsaW5nIHRvb2xzCj4+
Pj4+Pj4gKGxpa2UgUk1WKSB3aGljaCBhcmUgbW9uaXRvcmluZyB0aGUgcGFnZSB0YWJsZSB1cGRh
dGUgZXZlbnRzLgo+Pj4+Pj4+Cj4+Pj4+Pj4gVjI6IEFkZGVkIHBoeXNpY2FsIGFkZHJlc3MgbG9v
a3VwIGxvZ2ljIGluIHRyYWNlIHBvaW50Cj4+Pj4+Pj4gVjM6IHN3aXRjaCB0byB1c2UgX19keW5h
bWljX2FycmF5Cj4+Pj4+Pj4gICAgICAgICBhZGRlZCBucHRlcyBpbnQgdGhlIFRQcHJpbnQgYXJn
dW1lbnRzIGxpc3QKPj4+Pj4+PiAgICAgICAgIGFkZGVkIHBhZ2Ugc2l6ZSBpbiB0aGUgYXJnIGxp
c3QKPj4+Pj4+PiBWNDogQWRkcmVzc2VkIENocmlzdGlhbidzIHJldmlldyBjb21tZW50cwo+Pj4+
Pj4+ICAgICAgICAgYWRkIHN0YXJ0L2VuZCBpbnN0ZWFkIG9mIHNlZwo+Pj4+Pj4+ICAgICAgICAg
dXNlIGluY3IgaW5zdGVhZCBvZiBwYWdlX3N6IHRvIGJlIGFjY3VyYXRlCj4+Pj4+Pj4KPj4+Pj4+
PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+Pj4+
IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+Pj4+Pj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+
Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFt
ZC5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHJhY2UuaCB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4+Pj4gICAg
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8ICA5ICsrKystLQo+
Pj4+Pj4+ICAgICAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Ry
YWNlLmgKPj4+Pj4+PiBpbmRleCA2M2U3MzRhMTI1ZmIuLmRmMTJjZjg0NjZjMiAxMDA2NDQKPj4+
Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+Pj4+
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4+Pj4+
Pj4gQEAgLTMyMSw2ICszMjEsNDMgQEAgREVGSU5FX0VWRU5UKGFtZGdwdV92bV9tYXBwaW5nLCBh
bWRncHVfdm1fYm9fY3MsCj4+Pj4+Pj4gICAgICAJICAgIFRQX0FSR1MobWFwcGluZykKPj4+Pj4+
PiAgICAgICk7Cj4+Pj4+Pj4gICAgICAKPj4+Pj4+PiArVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wdGVzLAo+Pj4+Pj4+ICsJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRl
X3BhcmFtcyAqcCwKPj4+Pj4+PiArCQkgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQs
Cj4+Pj4+Pj4gKwkJICAgICB1bnNpZ25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRzdCwKPj4+Pj4+
PiArCQkgICAgIHVpbnQ2NF90IGluY3IsIHVpbnQ2NF90IGZsYWdzKSwKPj4+Pj4+PiArCVRQX0FS
R1MocCwgc3RhcnQsIGVuZCwgbnB0ZXMsIGRzdCwgaW5jciwgZmxhZ3MpLAo+Pj4+Pj4+ICsJVFBf
U1RSVUNUX19lbnRyeSgKPj4+Pj4+PiArCQkJIF9fZmllbGQodTY0LCBzdGFydCkKPj4+Pj4+PiAr
CQkJIF9fZmllbGQodTY0LCBlbmQpCj4+Pj4+Pj4gKwkJCSBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4+
Pj4+Pj4gKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCj4+Pj4+Pj4gKwkJCSBfX2Zp
ZWxkKHU2NCwgaW5jcikKPj4+Pj4+PiArCQkJIF9fZHluYW1pY19hcnJheSh1NjQsIGRzdCwgbnB0
ZXMpCj4+Pj4+PiBBcyBkaXNjdXNzZWQgd2l0aCB0aGUgdHJhY2Ugc3Vic3lzdGVtIG1haW50YWlu
ZXIgd2UgbmVlZCB0byBhZGQgdGhlIHBpZAo+Pj4+Pj4gYW5kIHByb2JhYmx5IHRoZSBWTSBjb250
ZXh0IElEIHdlIHVzZSBoZXJlIHRvIGlkZW50aWZ5IHRoZSB1cGRhdGVkIFZNLgo+Pj4+Pj4KPj4+
Pj4+IENocmlzdGlhbi4KPj4+Pj4gSSBwcmludGVkIGJvdGggdm0tPnRhc2tfaW5mby5waWQgVnMg
Y3VycmVudC0+cGlkIGZvciB0ZXN0aW5nLCBhbmQgSSBjYW4gc2VlIGRpZmZlcmVudCB2YWx1ZXMg
Y29taW5nIG91dCBvZiAuCj4+Pj4+Cj4+Pj4+IGdub21lLXNoZWxsLTIxMTTCoCBbMDExXcKgwqDC
oCA0MS44MTI4OTQ6IGFtZGdwdV92bV91cGRhdGVfcHRlczogc3RhcnQ6MHgwODAwMTAyZTgwIGVu
ZDoweDA4MDAxMDJlODIsIGZsYWdzOjB4ODAsIGluY3I6NDA5NiwgcGlkPTIxMjggdm1pZD0wIGNw
aWQ9MjExNAo+Pj4+Pgo+Pj4+PiBwaWQgaXMgdm0tPnRhc2tfaW5mby5waWQ9MjEyOCB3aGVyZWFz
IGNwaWQ9MjExNCBpcyBjdXJyZW50LnBpZC4KPj4+Pj4KPj4+Pj4gV2hpY2ggaXMgdGhlIG9uZSB3
ZSB3YW50IHRvIHNlbmQgd2l0aCB0aGUgZXZlbnQgPwo+Pj4+IFRoYXQgaXMgdm0tPnRhc2tfaW5m
by5waWQsIHNpbmNlIHRoaXMgaXMgdGhlIFBJRCB3aGljaCBpcyB1c2luZyB0aGUgVk0KPj4+PiBm
b3IgY29tbWFuZCBzdWJtaXNzaW9uLgo+Pj4gZ290IGl0Lgo+Pj4+PiBUcmFjZSBldmVudCBieSBk
ZWZhdWx0IHNlZW1zIHRvIGJlIGFkZGluZyB0aGUgcHJvY2VzcyBuYW1lIGFuZCBpZCBhdCB0aGUg
aGVhZGVyIG9mIHRoZSBldmVudCAoZ25vbWUtc2hlbGwtMjExNCksIHdoaWNoIGlzIHNhbWUgYXMg
Y3VycmVudC5waWQKPj4+Pj4KPj4+Pj4KPj4+Pj4gQWxzbywgaXMgaXQgb2sgdG8gZXh0cmFjdCB2
bWlkIGZyb20gam9iLT52bWlkID8KPj4+PiBPbmx5IGluIHRyYWNlX2FtZGdwdV92bV9ncmFiX2lk
KCksIGluIGFsbCBvdGhlciBjYXNlcyBpdCdzIHByb2JhYmx5IG5vdAo+Pj4+IGFzc2lnbmVkIHll
dC4KPj4+IE9rLCBsZXQgbWUgY2hlY2sgaG93IGNhbiB3ZSBnZXQgdm1pZCBmcm9tIHRoaXMgY29u
dGV4dCB3ZSBhcmUgc2VuZGluZyB0aGUgZXZlbnQgZnJvbS4gT3IgbWF5YmUgSSB3ZSBzaG91bGTC
oCBrZWVwIFY1IHdpdGggcGlkIG9ubHksIGFuZCBsYXRlciBzZW5kIGEgc2VwYXJhdGUgcGF0Y2gg
dG8gYWRkIHZtaWQgPwo+PiBJJ20gbm90IHN1cmUgaG93IHlvdSB3YW50IHRvIGdldCBhIFZNSUQg
aW4gdGhlIGZpcnN0IHBsYWNlLiBXZQo+PiBkeW5hbWljYWxseSBhc3NpZ24gVk1JRHMgZHVyaW5n
IGNvbW1hbmQgc3VibWlzc2lvbi4KPj4KPj4gU2VlIHRoZSBhbWRncHVfdm1fZ3JhYl9pZCB0cmFj
ZSBwb2ludC4KPiBBY3R1YWxseSBJIHdhcyBhZGRpbmcgdm1pZCB0byBhZGRyZXNzIHRoaXMgbGFz
dCBjb21tZW50IG9uIFY0Ogo+PiBhbmQgcHJvYmFibHkgdGhlIFZNIGNvbnRleHQgSUQgd2UgdXNl
IGhlcmUgdG8gaWRlbnRpZnkgdGhlIHVwZGF0ZWQgVk0uCj4gSSBhc3N1bWVkIHlvdSBtZWFudCB0
aGUgdm1pZCBieSB0aGlzLCBpcyB0aGF0IG5vdCBzbyA/CgpBaCEgTm8gdGhhdCdzIHNvbWV0aGlu
ZyBjb21wbGV0ZWx5IGRpZmZlcmVudCA6KQoKVGhlIFZNSUQgaXMgYSA0Yml0IGhhcmR3YXJlIGlk
ZW50aWZpZXIgdXNlZCBmb3IgVExCIG9wdGltaXphdGlvbi4KClRoZSBWTSBjb250ZXh0IElEIGlz
IGFuIHVuaXF1ZSA2NGJpdCBudW1iZXIsIHdlIHVzdWFsbHkgdXNlIAp2bS0+aW1tZWRpYXRlLmZl
bmNlX2NvbnRleHQgZm9yIHRoaXMuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+Cj4KPiBSZWdhcmRz
Cj4KPiBTaGFzaGFuawo+Cj4+IENocmlzdGlhbi4KPj4KPj4+IC0gU2hhc2hhbmsKPj4+Cj4+Pj4g
Q2hyaXN0aWFuLgo+Pj4+Cj4+Pj4+IFJlZ2FyZHMKPj4+Pj4KPj4+Pj4gU2hhc2hhbmsKPj4+Pj4K
Pj4+Pj4+PiArCSksCj4+Pj4+Pj4gKwo+Pj4+Pj4+ICsJVFBfZmFzdF9hc3NpZ24oCj4+Pj4+Pj4g
KwkJCXVuc2lnbmVkIGludCBpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArCQkJX19lbnRyeS0+c3RhcnQg
PSBzdGFydDsKPj4+Pj4+PiArCQkJX19lbnRyeS0+ZW5kID0gZW5kOwo+Pj4+Pj4+ICsJCQlfX2Vu
dHJ5LT5mbGFncyA9IGZsYWdzOwo+Pj4+Pj4+ICsJCQlfX2VudHJ5LT5pbmNyID0gaW5jcjsKPj4+
Pj4+PiArCQkJX19lbnRyeS0+bnB0ZXMgPSBucHRlczsKPj4+Pj4+PiArCQkJZm9yIChpID0gMDsg
aSA8IG5wdGVzOyArK2kpIHsKPj4+Pj4+PiArCQkJCXU2NCBhZGRyID0gcC0+cGFnZXNfYWRkciA/
IGFtZGdwdV92bV9tYXBfZ2FydCgKPj4+Pj4+PiArCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDog
ZHN0Owo+Pj4+Pj4+ICsKPj4+Pj4+PiArCQkJCSgodTY0ICopX19nZXRfZHluYW1pY19hcnJheShk
c3QpKVtpXSA9IGFkZHI7Cj4+Pj4+Pj4gKwkJCQlkc3QgKz0gaW5jcjsKPj4+Pj4+PiArCQkJfQo+
Pj4+Pj4+ICsJKSwKPj4+Pj4+PiArCVRQX3ByaW50aygic3RhcnQ6MHglMDEwbGx4IGVuZDoweCUw
MTBsbHgsIGZsYWdzOjB4JWxseCwgaW5jcjolbGx1LCIKPj4+Pj4+PiArCQkgICIgZHN0OlxuJXMi
LCBfX2VudHJ5LT5zdGFydCwgX19lbnRyeS0+ZW5kLCBfX2VudHJ5LT5mbGFncywKPj4+Pj4+PiAr
CQkgIF9fZW50cnktPmluY3IsIF9fcHJpbnRfYXJyYXkoCj4+Pj4+Pj4gKwkJICBfX2dldF9keW5h
bWljX2FycmF5KGRzdCksIF9fZW50cnktPm5wdGVzLCA4KSkKPj4+Pj4+PiArKTsKPj4+Pj4+PiAr
Cj4+Pj4+Pj4gICAgICBUUkFDRV9FVkVOVChhbWRncHVfdm1fc2V0X3B0ZXMsCj4+Pj4+Pj4gICAg
ICAJICAgIFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRfdCBhZGRyLCB1bnNpZ25lZCBjb3Vu
dCwKPj4+Pj4+PiAgICAgIAkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBmbGFncywgYm9v
bCBkaXJlY3QpLAo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+
Pj4+Pj4gaW5kZXggNzFlMDA1Y2YyOTUyLi5iNWRiYjVlOGJjNjEgMTAwNjQ0Cj4+Pj4+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+Pj4+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4+Pj4+IEBAIC0xNTEzLDE3
ICsxNTEzLDIyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCBhbWRn
cHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+Pj4+Pj4+ICAgICAgCQlkbyB7Cj4+Pj4+Pj4g
ICAgICAJCQl1aW50NjRfdCB1cGRfZW5kID0gbWluKGVudHJ5X2VuZCwgZnJhZ19lbmQpOwo+Pj4+
Pj4+ICAgICAgCQkJdW5zaWduZWQgbnB0ZXMgPSAodXBkX2VuZCAtIGZyYWdfc3RhcnQpID4+IHNo
aWZ0Owo+Pj4+Pj4+ICsJCQl1aW50NjRfdCB1cGRfZmxhZ3MgPSBmbGFncyB8IEFNREdQVV9QVEVf
RlJBRyhmcmFnKTsKPj4+Pj4+PiAgICAgIAo+Pj4+Pj4+ICAgICAgCQkJLyogVGhpcyBjYW4gaGFw
cGVuIHdoZW4gd2Ugc2V0IGhpZ2hlciBsZXZlbCBQRHMgdG8KPj4+Pj4+PiAgICAgIAkJCSAqIHNp
bGVudCB0byBzdG9wIGZhdWx0IGZsb29kcy4KPj4+Pj4+PiAgICAgIAkJCSAqLwo+Pj4+Pj4+ICAg
ICAgCQkJbnB0ZXMgPSBtYXgobnB0ZXMsIDF1KTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKwkJCXRyYWNl
X2FtZGdwdV92bV91cGRhdGVfcHRlcyhwYXJhbXMsIGZyYWdfc3RhcnQsIHVwZF9lbmQsCj4+Pj4+
Pj4gKwkJCQkJCSAgICBucHRlcywgZHN0LCBpbmNyLAo+Pj4+Pj4+ICsJCQkJCQkgICAgdXBkX2Zs
YWdzKTsKPj4+Pj4+PiAgICAgIAkJCWFtZGdwdV92bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBwdCwg
Y3Vyc29yLmxldmVsLAo+Pj4+Pj4+ICAgICAgCQkJCQkgICAgICAgcGVfc3RhcnQsIGRzdCwgbnB0
ZXMsIGluY3IsCj4+Pj4+Pj4gLQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZy
YWcpKTsKPj4+Pj4+PiArCQkJCQkgICAgICAgdXBkX2ZsYWdzKTsKPj4+Pj4+PiAgICAgIAo+Pj4+
Pj4+ICAgICAgCQkJcGVfc3RhcnQgKz0gbnB0ZXMgKiA4Owo+Pj4+Pj4+IC0JCQlkc3QgKz0gKHVp
bnQ2NF90KW5wdGVzICogQU1ER1BVX0dQVV9QQUdFX1NJWkUgPDwgc2hpZnQ7Cj4+Pj4+Pj4gKwkJ
CWRzdCArPSBucHRlcyAqIGluY3I7Cj4+Pj4+Pj4gICAgICAKPj4+Pj4+PiAgICAgIAkJCWZyYWdf
c3RhcnQgPSB1cGRfZW5kOwo+Pj4+Pj4+ICAgICAgCQkJaWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19l
bmQpIHsKPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5m
byUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q3NoYXNoYW5rLnNoYXJtYSU0MGFtZC5jb20l
N0MyOTRjMGNmMDQ2MDg0Nzk1M2U4MzA4ZDg0NDNjMTYzYyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczMzQzNzIxNDcxNTY2NzQmYW1wO3NkYXRhPTNzV1pj
dUxjV1ZUY3NweGhScTZnVDFTTSUyQnZIUUNySnFtSmlqS2dSRWtzMCUzRCZhbXA7cmVzZXJ2ZWQ9
MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
