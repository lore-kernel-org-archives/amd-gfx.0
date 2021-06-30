Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3701C11F69
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 00:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718FF61879
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 00:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718FF61879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C35A886DC;
	Wed, 30 Jun 2021 00:23:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F356E909;
 Wed, 30 Jun 2021 00:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrR5mmc/qmtXYawpqRjE39VM6UEVnMXHYrdSBcB/Et0vU5PceOpxyx92HgyO+vEBbM05zw6BsQ8im2VuZki/BVKBVove96yNl7Z4B+wL7zhyp5IehkYkOnQxIYsG4NfEUf9gj4nqSck8mPJfQExry9f4VyP/gzWyvqyCKnv78J0Kn8NWK6gWPCck4mei+Y2rzI6DrFYZE+pi+9P7c74XC8DMeWusDPBEa/ZCP0wX6NvbLL/7Y9WJW9w4V9r94bYZ3N8DFIp3QGeZug8SV/rnTgwvvlMkv912TEyOKs2/wFMQof5Lv8QnuDXe9q6gBJYlkIeON/6f8IyPfyQ+MGge+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/MU13EJJdQtq1C0Hzvv1TZhNFjRG3LECltiLLJS/7w=;
 b=aoW5lZkGO2nIccyYWqHi9s981hLiOG0015EqtS6y321vbxRUAwjL2s8aImpYqiVhLqnkOESO84ak3mjyXbm/OpfxNYbZDsXakAoeV2PmShW49oGNaB3UtE2ZdWkFjq0neSrnXTbILBsW9tK6osPgsOKB1qAd1Xx/5yiGxPSTR+cc4c0uE4Rijnn/uiNhR5FrL4J8LVbYkawUhvRpxUsfgvdNkwpmKVSiAfeKiPnqUsx4YdWMbGEHNo6Z61qGZ0ZmUehtm6L6LDlh7eMR5Qw1lCw4luMqCmJNG6f3gz+bDKSyEegtOndAokq85yMOQ6/e5DWrhAoxzaykPaHkP/F8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/MU13EJJdQtq1C0Hzvv1TZhNFjRG3LECltiLLJS/7w=;
 b=EYurZZMIGtgj1obxKwnF6Mg+qkNcCpPTb56JabJ1NmEYuq+BwzDKj1vRVLO4g3hsRprNqMT35oxRbu/ZDAPJRdeD3wC0dDAqRp/Ypk89uaEwy5lshPlS8BnzBL2Izr8L/SKdqZfM4/jFhfvvmy73/P3mwUCb28/xhPwpQlJVAW/ilFUKADy16t6m6YVkvL6iyWdTCbbHvVO9Fgn6HrEPF+r63pU6ss0hWLP2wyKoxPqVRfyLVdOibl8zSiuR9xRJfju38ofPzv2aYE68ssseG1ESDellRNwIRkxcfBFU8zjOB5N9GAbfw2SvaDrxHb5D9Zol22mZga1Wa6loi4vIQA==
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by SJ0PR12MB5406.namprd12.prod.outlook.com (2603:10b6:a03:3ae::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 00:23:26 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::96) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Wed, 30 Jun 2021 00:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 30 Jun 2021 00:23:25 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Jun
 2021 17:23:24 -0700
Received: from rcampbell-test.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 00:23:24 +0000
Subject: Re: [PATCH v3 2/8] mm: remove extra ZONE_DEVICE struct page refcount
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
 <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>, "Yang, Philip"
 <Philip.Yang@amd.com>
References: <20210617151705.15367-1-alex.sierra@amd.com>
 <20210617151705.15367-3-alex.sierra@amd.com>
 <7163dbb6-67b5-6eef-5772-500fd2107e5c@nvidia.com>
 <cecd2164-ebfd-382b-af73-992cdc4304b7@amd.com>
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <4f6dd918-d79b-1aa7-3a4c-caa67ddc29bc@nvidia.com>
Date: Tue, 29 Jun 2021 17:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cecd2164-ebfd-382b-af73-992cdc4304b7@amd.com>
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d9fe82a-6e48-4743-715d-08d93b5d46f9
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5406:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54068E2956E48723E5DE3CCBC2019@SJ0PR12MB5406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prh+q7BtytT3EGdDeO2L6f6NlgXGp8P3c/Z+Ab4mb+XT3Mwz/Wos2jk/NdGF31S4DKC5WYGnfLtNos03UzKbFGl9QFw7MCBnx4cT4geSwQ9Ff/CjG+zv6j/yDz01EatNiNNvue6zCY7xpI6SCb8aJbFRq/KYYh02M7mCxL+IoBxX9vxRKCvepEIY6a85mEw/FH0vk/2DFfDxbPa58TaohzlQDhEMb3wlDC4fwbZjsgUM/6n52zd0xslAE2ReB24NFRGOx2GBHC4vpJpGyMFItn67NONnDcukZfFY9D2494b9Z+f1GPXeRl01/usCNOyuk0KIyiSSBlfSAsc93ND5pebjFKQV3Gd4h6elk7mRdMsyH01aof5LblUnzsLHW0ic1J+9i+wyesVB8UfT+ZQB7H4GEK3Tc4vFFzkGhO28YWel0bTgqWQDg4UyBLh/VSaNzihGrif+n8/bA7hDwNvZBllAYCPHmAQPLPxbq4DbPqRg+xH7C1tMhG0SBFkeIoh98WOGT2r7dsB1HuwTNC4V5rbEwIoNhgoc2iYKAXw5E5dzIgAlHBhPwgH+D19mm0NmKKrLiKX2RwS5k/RIA3MfKx+PD0fCepAEliYEEkmU/m0G43uuNjhq6SZKFbH9TVAPeCstwhOaN5WhO562ldQqyUyhMDQY6x09niDqCNfQ5BvXyio9bK3C2adK3M1INpUdc9nhdfuMB0rYA43/lzMrVylk9oIwFOI3HfuHqYf/bD+t0yyYqjSPTbSeW9XWPbp8
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(336012)(47076005)(7696005)(5660300002)(356005)(82740400003)(53546011)(36860700001)(36756003)(426003)(8676002)(186003)(82310400003)(2906002)(31696002)(316002)(54906003)(7416002)(70586007)(26005)(86362001)(7636003)(83380400001)(110136005)(478600001)(8936002)(70206006)(31686004)(4326008)(2616005)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 00:23:25.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9fe82a-6e48-4743-715d-08d93b5d46f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5406
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
Cc: jglisse@redhat.com, jgg@nvidia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gNi8yOC8yMSA5OjQ2IEFNLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPiBBbSAyMDIxLTA2LTE3
IHVtIDM6MTYgcC5tLiBzY2hyaWViIFJhbHBoIENhbXBiZWxsOgo+PiBPbiA2LzE3LzIxIDg6MTYg
QU0sIEFsZXggU2llcnJhIHdyb3RlOgo+Pj4gRnJvbTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVs
bEBudmlkaWEuY29tPgo+Pj4KPj4+IFpPTkVfREVWSUNFIHN0cnVjdCBwYWdlcyBoYXZlIGFuIGV4
dHJhIHJlZmVyZW5jZSBjb3VudCB0aGF0Cj4+PiBjb21wbGljYXRlcyB0aGUKPj4+IGNvZGUgZm9y
IHB1dF9wYWdlKCkgYW5kIHNldmVyYWwgcGxhY2VzIGluIHRoZSBrZXJuZWwgdGhhdCBuZWVkIHRv
Cj4+PiBjaGVjayB0aGUKPj4+IHJlZmVyZW5jZSBjb3VudCB0byBzZWUgdGhhdCBhIHBhZ2UgaXMg
bm90IGJlaW5nIHVzZWQgKGd1cCwgY29tcGFjdGlvbiwKPj4+IG1pZ3JhdGlvbiwgZXRjLikuIENs
ZWFuIHVwIHRoZSBjb2RlIHNvIHRoZSByZWZlcmVuY2UgY291bnQgZG9lc24ndAo+Pj4gbmVlZCB0
bwo+Pj4gYmUgdHJlYXRlZCBzcGVjaWFsbHkgZm9yIFpPTkVfREVWSUNFLgo+Pj4KPj4+IHYyOgo+
Pj4gQVM6IG1lcmdlZCB0aGlzIHBhdGNoIGluIGxpbnV4IDUuMTEgdmVyc2lvbgo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IFJhbHBoIENhbXBiZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KPj4+IFNp
Z25lZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+Pj4gLS0tCj4+
PiAgwqAgYXJjaC9wb3dlcnBjL2t2bS9ib29rM3NfaHZfdXZtZW0uY8KgwqDCoMKgIHzCoCAyICst
Cj4+PiAgwqAgZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9kbWVtLmMgfMKgIDIgKy0K
Pj4+ICDCoCBmcy9kYXguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNCArLQo+Pj4gIMKgIGluY2x1ZGUvbGludXgvZGF4LmjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQo+Pj4gIMKgIGlu
Y2x1ZGUvbGludXgvbWVtcmVtYXAuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcg
Ky0tCj4+PiAgwqAgaW5jbHVkZS9saW51eC9tbS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDQ0IC0tLS0tLS0tLS0tLS0tLS0tCj4+PiAgwqAgbGliL3Rlc3RfaG1t
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIg
Ky0KPj4+ICDCoCBtbS9pbnRlcm5hbC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrCj4+PiAgwqAgbW0vbWVtcmVtYXAuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNjggKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0KPj4+ICDCoCBtbS9taWdyYXRlLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1IC0tCj4+PiAgwqAgbW0vcGFn
ZV9hbGxvYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMyArKwo+Pj4gIMKgIG1tL3N3YXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NSArKy0tLS0tLS0tLS0tLS0tLQo+Pj4gIMKg
IDEyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDE0NyBkZWxldGlvbnMoLSkKPj4+
Cj4+IEkgdGhpbmsgaXQgaXMgZ3JlYXQgdGhhdCB5b3UgYXJlIHBpY2tpbmcgdGhpcyB1cCBhbmQg
dHJ5aW5nIHRvIHJldml2ZSBpdC4KPj4KPj4gSG93ZXZlciwgSSBoYXZlIGEgbnVtYmVyIG9mIGNv
bmNlcm5zIGFib3V0IGhvdyBpdCBhZmZlY3RzIGV4aXN0aW5nCj4+IFpPTkVfREVWSUNFCj4+IE1F
TU9SWV9ERVZJQ0VfR0VORVJJQyBhbmQgTUVNT1JZX0RFVklDRV9GU19EQVggdXNlcnMgYW5kIEkg
ZG9uJ3Qgc2VlIHRoaXMKPj4gYWRkcmVzc2luZyB0aGVtLiBGb3IgZXhhbXBsZSwgZGV2X2RheF9w
cm9iZSgpIGFsbG9jYXRlcwo+PiBNRU1PUllfREVWSUNFX0dFTkVSSUMKPj4gc3RydWN0IHBhZ2Vz
IGFuZCB0aGVuOgo+PiAgwqAgZGV2X2RheF9mYXVsdCgpCj4+ICDCoMKgwqAgZGV2X2RheF9odWdl
X2ZhdWx0KCkKPj4gIMKgwqDCoMKgwqAgX19kZXZfZGF4X3B0ZV9mYXVsdCgpCj4+ICDCoMKgwqDC
oMKgwqDCoCB2bWZfaW5zZXJ0X21peGVkKCkKPj4gd2hpY2gganVzdCBpbnNlcnRzIHRoZSBQRk4g
aW50byB0aGUgQ1BVIHBhZ2UgdGFibGVzIHdpdGhvdXQgaW5jcmVhc2luZwo+PiB0aGUgcGFnZQo+
PiByZWZjb3VudCBzbyBpdCBpcyB6ZXJvICh3aGVyZWFzIGl0IHdhcyBvbmUgYmVmb3JlKS4gQnV0
IHVzaW5nCj4+IGdldF9wYWdlKCkgd2lsbAo+PiB0cmlnZ2VyIFZNX0JVR19PTl9QQUdFKCkgaWYg
aXQgaXMgZW5hYmxlZC4gVGhlcmUgaXNuJ3QgYW55IGN1cnJlbnQKPj4gbm90aW9uIG9mCj4+IGZy
ZWUgdmVyc2VzIGFsbG9jYXRlZCBmb3IgdGhlc2Ugc3RydWN0IHBhZ2VzLiBJIHN1cHBvc2UgaW5p
dF9wYWdlX2NvdW50KCkKPj4gY291bGQgYmUgY2FsbGVkIG9uIGFsbCB0aGUgc3RydWN0IHBhZ2Vz
IGluIGRldl9kYXhfcHJvYmUoKSB0byBmaXggdGhhdAo+PiB0aG91Z2guCj4gSGkgUmFscGgsCj4K
PiBGb3IgREVWSUNFX0dFTkVSSUMgcGFnZXMgZnJlZV96b25lX2RldmljZV9wYWdlIGRvZXNuJ3Qg
ZG8gYW55dGhpbmcuIFNvCj4gSSdtIG5vdCBzdXJlIHdoYXQgdGhlIHJlZmVyZW5jZSBjb3VudGlu
ZyBpcyBnb29kIGZvciBpbiB0aGlzIGNhc2UuCj4KPiBBbGV4IGlzIGdvaW5nIHRvIGFkZCBmcmVl
X3pvbmVfZGV2aWNlX3BhZ2Ugc3VwcG9ydCBmb3IgREVWSUNFX0dFTkVSSUMKPiBwYWdlcyAocGF0
Y2ggOCBvZiB0aGlzIHNlcmllcykuIEhvd2V2ZXIsIGV2ZW4gdGhlbiwgaXQgb25seSBkb2VzCj4g
YW55dGhpbmcgaWYgdGhlcmUgaXMgYW4gYWN0dWFsIGNhbGwgdG8gcHV0X3BhZ2UuIFdoZXJlIHdv
dWxkIHRoYXQgY2FsbAo+IGNvbWUgZnJvbSBpbiB0aGUgZGV2X2RheCBkcml2ZXIgY2FzZT8KCkNv
cnJlY3QsIHRoZSBkcml2ZXJzL2RheC9kZXZpY2UuYyBkcml2ZXIgYWxsb2NhdGVzIE1FTU9SWV9E
RVZJQ0VfR0VORVJJQwpzdHJ1Y3QgcGFnZXMgYW5kIGRvZXNuJ3Qgc2VlbSB0byBhbGxvY2F0ZS9m
cmVlIHRoZSBwYWdlIG5vciBpbmNyZW1lbnQvZGVjcmVtZW50CnRoZSByZWZlcmVuY2UgY291bnQg
YnV0IGl0IGRvZXMgY2FsbCB2bWZfaW5zZXJ0X21peGVkKCkgaWYgdGhlIC9kZXYvZmlsZQppcyBt
bWFwKCknZWQgaW50byBhIHVzZXIgcHJvY2VzcycgYWRkcmVzcyBzcGFjZS4gSWYgZGV2bV9tZW1y
ZW1hcF9wYWdlcygpCnJldHVybnMgdGhlIGFycmF5IG9mIFpPTkVfREVWSUNFIHN0cnVjdCBwYWdl
cyBpbml0aWFsaXplZCB3aXRoIGEgcmVmZXJlbmNlCmNvdW50IG9mIHplcm8sIHRoZW4gdGhlIENQ
VSBwYWdlIHRhYmxlcyB3aWxsIGhhdmUgYSBQVEUvUEZOIHRoYXQgcG9pbnRzIHRvCmEgc3RydWN0
IHBhZ2Ugd2l0aCBhIHplcm8gcmVmZXJlbmNlIGNvdW50LiBUaGlzIGdvZXMgYWdhaW5zdCB0aGUg
bm9ybWFsCmV4cGVjdGF0aW9uIGluIHRoZSByZXN0IG9mIHRoZSBtbSBjb2RlIHRoYXQgYXNzdW1l
cyBhIHBhZ2UgbWFwcGVkIGJ5IGEgQ1BVCmhhcyBhIG5vbi16ZXJvIHJlZmVyZW5jZSBjb3VudC4K
U28geWVzLCBub3RoaW5nICJiYWQiIGhhcHBlbnMgYmVjYXVzZSBwdXRfcGFnZSgpIGlzbid0IGNh
bGxlZCBidXQgdGhlCnJlZmVyZW5jZSBjb3VudCB3aWxsIGRpZmZlciBmcm9tIG90aGVyIGRyaXZl
cnMgdGhhdCBjYWxsIHZtZl9pbnNlcnRfbWl4ZWQoKQpvciB2bV9pbnNlcnRfcGFnZSgpIHdoZXJl
IHRoZSBwYWdlIHdhcyBhbGxvY2F0ZWQgd2l0aCBhbGxvY19wYWdlcygpIG9yCnNpbWlsYXIuCgo+
PiBJJ20gZXZlbiBsZXNzIGNsZWFyIGFib3V0IGhvdyB0byBmaXggTUVNT1JZX0RFVklDRV9GU19E
QVguIEZpbGUKPj4gc3lzdGVtcyBoYXZlIGNsZWFyCj4+IGFsbG9jYXRlIGFuZCBmcmVlIHN0YXRl
cyBmb3IgYmFja2luZyBzdG9yYWdlIGJ1dCB0aGVyZSBhcmUgdGhlCj4+IGNvbXBsaWNhdGlvbnMg
d2l0aAo+PiB0aGUgcGFnZSBjYWNoZSByZWZlcmVuY2VzLCBldGMuIHRvIGNvbnNpZGVyLiBUaGUg
PjEgdG8gMSByZWZlcmVuY2UKPj4gY291bnQgc2VlbXMgdG8KPj4gYmUgdXNlZCB0byB0ZWxsIHdo
ZW4gYSBwYWdlIGlzIGlkbGUgKG5vIEkvTywgcmVjbGFpbSBzY2FubmVycykgcmF0aGVyCj4+IHRo
YW4gZnJlZQo+PiAobm90IGFsbG9jYXRlZCB0byBhbnkgZmlsZSkgYnV0IEknbSBub3QgMTAwJSBz
dXJlIGFib3V0IHRoYXQgc2luY2UgSQo+PiBkb24ndCByZWFsbHkKPj4gdW5kZXJzdGFuZCBhbGwg
dGhlIGlzc3VlcyBhcm91bmQgd2h5IGEgZmlsZSBzeXN0ZW0gbmVlZHMgdG8gaGF2ZSBhIERBWAo+
PiBtb3VudCBvcHRpb24KPj4gYmVzaWRlcyBrbm93aW5nIHRoYXQgdGhlIHN0b3JhZ2UgYmxvY2sg
c2l6ZSBoYXMgdG8gYmUgYSBtdWx0aXBsZSBvZgo+PiB0aGUgcGFnZSBzaXplLgo+IFRoZSBvbmx5
IHRoaW5nIHRoYXQgaGFwcGVucyBpbiBmcmVlX3pvbmVfZGV2aWNlX3BhZ2UgZm9yIEZTX0RBWCBw
YWdlcyBpcwo+IHdha2VfdXBfdmFyKCZwYWdlLT5fcmVmY291bnQpLiBJIGd1ZXNzLCB3aG9ldmVy
IGlzIHdhaXRpbmcgZm9yIHRoaXMKPiB3YWtlLXVwIHdpbGwgbmVlZCB0byBiZSBwcmVwYXJlZCB0
byBzZWUgYSByZWZjb3VudCAwIGluc3RlYWQgb2YgMSBub3cuIEkKPiBzZWUgdGhlc2UgY2FsbGVy
cyB0aGF0IHdvdWxkIG5lZWQgdG8gYmUgdXBkYXRlZDoKPgo+IC4vZnMvZXh0NC9pbm9kZS5jOsKg
wqDCoCDCoMKgwqAgZXJyb3IgPSBfX193YWl0X3Zhcl9ldmVudCgmcGFnZS0+X3JlZmNvdW50LAo+
IC4vZnMvZXh0NC9pbm9kZS5jLcKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCBhdG9taWNfcmVh
ZCgmcGFnZS0+X3JlZmNvdW50KSA9PSAxLAo+IC4vZnMvZXh0NC9pbm9kZS5jLcKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBUQVNLX0lOVEVSUlVQVElCTEUsIDAsIDAsCj4gLi9mcy9leHQ0L2lu
b2RlLmMtwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIGV4dDRfd2FpdF9kYXhfcGFnZShlaSkp
Owo+IC0tCj4gLi9mcy9mdXNlL2RheC5jOsKgwqDCoCByZXR1cm4gX19fd2FpdF92YXJfZXZlbnQo
JnBhZ2UtPl9yZWZjb3VudCwKPiAuL2ZzL2Z1c2UvZGF4LmMtwqDCoMKgIMKgwqDCoCDCoMKgwqAg
YXRvbWljX3JlYWQoJnBhZ2UtPl9yZWZjb3VudCkgPT0gMSwKPiBUQVNLX0lOVEVSUlVQVElCTEUs
Cj4gLi9mcy9mdXNlL2RheC5jLcKgwqDCoCDCoMKgwqAgwqDCoMKgIDAsIDAsIGZ1c2Vfd2FpdF9k
YXhfcGFnZShpbm9kZSkpOwo+IC0tCj4gLi9mcy94ZnMveGZzX2ZpbGUuYzrCoMKgwqAgcmV0dXJu
IF9fX3dhaXRfdmFyX2V2ZW50KCZwYWdlLT5fcmVmY291bnQsCj4gLi9mcy94ZnMveGZzX2ZpbGUu
Yy3CoMKgwqAgwqDCoMKgIMKgwqDCoCBhdG9taWNfcmVhZCgmcGFnZS0+X3JlZmNvdW50KSA9PSAx
LAo+IFRBU0tfSU5URVJSVVBUSUJMRSwKPiAuL2ZzL3hmcy94ZnNfZmlsZS5jLcKgwqDCoCDCoMKg
wqAgwqDCoMKgIDAsIDAsIHhmc193YWl0X2RheF9wYWdlKGlub2RlKSk7Cj4KPiBSZWdhcmRpbmcg
eW91ciBwYWdlLWNhY2hlIGNvbW1lbnQsIGRvZXNuJ3QgREFYIG1lYW4gdGhhdCB0aG9zZSBmaWxl
Cj4gcGFnZXMgYXJlIG5vdCBpbiB0aGUgcGFnZSBjYWNoZT8KPgo+IFJlZ2FyZHMsCj4gIMKgIEZl
bGl4Cj4KSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB0aGUgRlNfREFYIGNvZGUuIEkgY2FuIHNl
ZSB0aGUgX193YWl0X3Zhcl9ldmVudCgpCmlzIGJlaW5nIHVzZWQgd2hlbiB0cnVuY2F0aW5nIG9y
IHB1bmNoaW5nIGhvbGVzIGluIGZpbGVzIGJ1dCBJJ20gbm90CnF1aXRlIHN1cmUgaWYgaXQgaXMg
dXNpbmcgdGhlID4xIHRvIDEgcmVmZXJlbmNlIGNvdW50IHRvIGtub3cgd2hlbiBhCnBhZ2UgaGFz
IG5vICJleHRyYSIgcmVmZXJlbmNlcyBvciBpZiBpdCBtZWFucyB0aGUgcGFnZSBpcyBhY3R1YWxs
eQoiZnJlZSIgYW5kIG5vIGxvbmdlciBhc3NpZ25lZCB0byBhIGZpbGUuCkkgcmVhbGx5IHRoaW5r
IHNvbWUgRlNfREFYIGV4cGVydCBuZWVkcyB0byB3ZWlnaCBpbiBvbiB0aGVzZSByZWZlcmVuY2Ug
Y291bnQKY2hhbmdlcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
