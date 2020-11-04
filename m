Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA411C388F7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:05:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12815221F9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BchQssIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12815221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894846E06B;
	Wed,  4 Nov 2020 10:05:25 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B8D6E06B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 10:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPTYBXjBy5jjJ0OOvg0FxMZRSYCf23h6xzKq+3vtO4OWhV0zo7qXNw5RGCogfIXRhVq+Cbjj4Ahs6k+MaZGNrPvuccmXvBmuUCTAjb0+VsyXeTa8CgaUNE7KXEPbgyJuCcPAOhawzn5KzgdsidOpDqmO5F5lbF8V/Tpga9EwPrGk2dwzntIsvazApvPzVn1ERO974n2hyA7Xr9NbgCmqjTk5vaHUKulOK5l7MEI3xTgm8GxQOSysOYLw3k7rKt1M62loodIMmV2z4R75zEq4IARFq0IBOLredOBBkAC8PYkz6YYlcnbYg7kolcMT9UvgI0r5CF57boZRwRD2Tz9CKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGVBTlgX42flh5MrhgTE5loKYpj1R3IggWqNdUapxac=;
 b=N50zMqkAuXGh77v7RnR5DLLYJIojj7zzWPpibVilzr2y3IgOQYw4nci21vK94g3ZMA4G+IawU7mHrZyG7bz7mXNfqPhJnsrUZmDAdxG8mzvMgZf98gs1aEmb9XCHsRF82oU1by1TW9MwzUuFJxSAjVPuCgwa8a1fQ3syfai7cbpgSlZChcOamfkOLn8y+CaTUQg7t9E4JOdggj92G7HLrEmzqj7IkI+SkReA8gfDEYZO7zFX7VYMII4nBB1Uk66f3unltJCtsEi27xBpx7nOKdBubHlp9gXJEGha++bauUY1gwTc9ndhtIJyeoeaINg77oYNtr1q46whfM3cZuKBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGVBTlgX42flh5MrhgTE5loKYpj1R3IggWqNdUapxac=;
 b=BchQssIn7ySal8WReIxqYZi+r18HaaCOWkp6iN/kkzW2ysSBDOGd7zLFY9oIR7xyQX92kTlNCn6dUkaT2FgKm9MaOMQcuriXhrpRmV3eHMiBLQPoVrs6ixTgGbL/8uMcU9QLb/ysM4i0V/5eWO44Wh2aptyAUS7SNgXIfU5WjLA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Wed, 4 Nov
 2020 10:05:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 10:05:20 +0000
Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
Date: Wed, 4 Nov 2020 11:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201103171340.2978395-1-shashank.sharma@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR05CA0153.eurprd05.prod.outlook.com
 (2603:10a6:207:3::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0153.eurprd05.prod.outlook.com (2603:10a6:207:3::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 10:05:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa893009-4fff-4a07-897f-08d880a92309
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB396623DA893E9F8A3B030F8583EF0@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDtjvcUcVwMXj4+8h5YJAJjTUfFPq1b4532aA63+wbnGWBwzPknv696sxk8zsbGvcJ9XsSWwBEvDY/We3ahq7OFaDvlPggwCdRCGiGpCsqambwLrFvTMofXT9a7dNkV6Pl/nXoW7SnMqJ5DQc9FPu8mRf83IXQmSlktXPcfDQREMo61TjPnjQOkxrMs9R5rn1jtJFJyDf2d7vINBOcIpartL6F9bEDP5V1XEzlDPhcBWLHzFZtiGMcL+F0ICmwd1YWffkzogTfra0WgofD54RQoJqEDDDY0wOiLh8UaI8s1ii8k20wSjD7xpVIhjPhxpRychKt1wrcmGUUWwdnqIF3iECrkTTgvMPt9cbN8Uv4Vw2dT3CYXoIERfTNDfWb2DUjmV+JtZ61vE15mi1+1ruri98DXONYuB4YCThkASio89HEqPlQAMguHbYyG+H4w0/D288gUmB4gIE5jDnTR6tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(6666004)(8676002)(6486002)(5660300002)(66556008)(54906003)(66946007)(2906002)(66476007)(83380400001)(2616005)(186003)(498600001)(16526019)(52116002)(36756003)(966005)(66574015)(31686004)(86362001)(8936002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aq0Xj1rp3nZNqfx0HaQvqflRboflsfCi9VnQHU7BSZg3M3epu+JXFtVbuHYmE27PiGr/kE5ZVfSYH18lPJM/uDutKNmHv6m3XGg4KVvLn5X0To+evgkONuZma/pKIKlZ+1KLeloEYzOEUp083zJ+qZIZvaQ+9tGGmAbtL4312K1GgE048Ev0/KULLNkn7yDvY4U93aiEAuc2xGAXPM6ncYqIveN3iSph4NbDTYAz8QBEQ8/7HonMlIs9cs8VGxzlHkPm7v8ENmqhyzHrkJq4WtOR929rpAFxgxPmnouUR7pKEcPx/PQEnnDhA46z4qSQKuh4ppNuuW331Ep1QpUi8DhV1QwjSaPyJjTmkHObIcWFlYWJ+Mwn1LpoFrVLWFsxJ6KQ8s2qonnhpTd4Af/Ug8BVZzmMgq9OTd3b/WGmtuOIzMwXoiBaNXh7IZ+X99iwdrBvNweipvjg+eo+c4g6Ikdo2IKDAA9LlZYEX9WdsIRcto5lbQZCYGfaYZX4wSo42F7EndrX2pdp3RYBKfecsTrd2S+GrdZDOEF6toI+RBKrHtgoAxN1Vnos1MPhd9JV/dUxbR4fbNt6x15NytJMcmQM/yL6tbHlJ7SSkdwEEzOsQ/ochInG/wd8dBuvdDGrDicDCDjz2KmwCsZeBqKdEp+JhDXLXk4tgsP4huRoa0LH/NmD7TBPcLylzyOw/BMunIj8oIrW1tg5ZgwVOK7iLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa893009-4fff-4a07-897f-08d880a92309
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 10:05:20.2388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIdqRYAECvZinKjjP0+/ceoRDWhjZPCg45gEOPV447DLihE0NvbzOJ3bp8/d6OjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Eddy Qin <Eddy.Qin@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMTEuMjAgdW0gMTg6MTMgc2NocmllYiBTaGFzaGFuayBTaGFybWE6Cj4gVGhpcyBwYXRj
aCBsaW1pdHMgdGhlIHJlZl9kaXZfbWF4IHZhbHVlIHRvIDEwMCwgZHVyaW5nIHRoZQo+IGNhbGN1
bGF0aW9uIG9mIFBMTCBmZWVkYmFjayByZWZlcmVuY2UgZGl2aWRlci4gV2l0aCBjdXJyZW50Cj4g
dmFsdWUgKDEyOCksIHRoZSBwcm9kdWNlZCBmYl9yZWZfZGl2IHZhbHVlIGdlbmVyYXRlcyB1bnN0
YWJsZQo+IG91dHB1dCBhdCBwYXJ0aWN1bGFyIGZyZXF1ZW5jaWVzLiBSYWRlb24gZHJpdmVyIGxp
bWl0cyB0aGlzCj4gdmFsdWUgYXQgMTAwLgoKTWhtLCBpcyB0aGF0IDEwMCBoYXJkIGNvZGVkIGlu
IHJhZGVvbj8gSSBoYXZlIG5vIGlkZWEgd2hlcmUgdGhhdCBpcyAKY29taW5nIGZyb20uCgpCZXN0
IHdvdWxkIHByb2JhYmx5IHRvIGdyYWIgYSBoYXJkd2FyZSBlbmdpbmVlciBhbmQgdHJ5IHRvIGZp
Z3VyZSBvdXQgCndoYXQgdGhlIHJlYWwgbWF4aW11bXMgZm9yIHRoZSBQTEwgaXMgdG8gc3RpbGwg
cHJvZHVjZSBhIHN0YWJsZSBzaWduYWwuCgpDaHJpc3RpYW4uCgo+Cj4gT24gT2xhbmQsIHdoZW4g
d2UgdHJ5IHRvIHNldHVwIG1vZGUgMjA0OHgxMjgwQDYwIChhIGJpdCB3ZWlyZCwKPiBJIGtub3cp
LCBpdCBkZW1hbmRzIGEgY2xvY2sgb2YgMjIxMjcwIEtoei4gSXQncyBiZWVuIG9ic2VydmVkCj4g
dGhhdCB0aGUgUExMIGNhbGN1bGF0aW9ucyB1c2luZyB2YWx1ZXMgMTI4IGFuZCAxMDAgYXJlIHZh
c3RseQo+IGRpZmZlcmVudCwgYW5kIGxvb2sgbGlrZSB0aGlzOgo+Cj4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiB8UGFyYW1ldGVyICAgIHxBTURHUFUgICAg
ICAgIHxSYWRlb24gICAgICAgfAo+IHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICB8Cj4gKy0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsK
PiB8Q2xvY2sgZmVlZGJhY2sgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+IHxkaXZpZGVy
IG1heCAgfCAgMTI4ICAgICAgICAgfCAgIDEwMCAgICAgICB8Cj4gfGNhcCB2YWx1ZSAgICB8ICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIHwKPiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgfAo+IHwgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICB8Cj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiB8
cmVmX2Rpdl9tYXggIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+IHwgICAgICAgICAg
ICAgfCAgNDIgICAgICAgICAgfCAgMjAgICAgICAgICB8Cj4gfCAgICAgICAgICAgICB8ICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgIHwKPiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgfAo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rCj4gfHJlZl9kaXYgICAgICB8ICA0MiAgICAgICAgICB8ICAyMCAgICAgICAgIHwKPiB8ICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAgfAo+ICstLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4gfGZiX2RpdiAgICAgICB8ICAxMDMyNiAg
ICAgICB8ICA4MTk1ICAgICAgIHwKPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKwo+IHxmYl9kaXYgICAgICAgfCAgMTAyNCAgICAgICAgfCAgMTYzICAgICAgICB8
Cj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKPiB8ZmJfZGV2
X3AgICAgIHwgIDQgICAgICAgICAgIHwgIDkgICAgICAgICAgfAo+IHxmcmFjIGZiX2RlXl9wfCAg
ICAgICAgICAgICAgfCAgICAgICAgICAgICB8Cj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLS0tLSsKPgo+IFdpdGggcmVmX2Rpdl9tYXggdmFsdWUgY2xpcHBlZCBhdCAx
MDAsIEFNREdQVSBkcml2ZXIgY2FuIGFsc28KPiBkcml2ZSB2aWRlbW9kZSAyMDQ4eDEyODBANjAg
KDIyMU1oeikgYW5kIHByb2R1Y2UgcHJvcGVyIG91dHB1dAo+IHdpdGhvdXQgYW55IGJsYW5raW5n
IGFuZCBkaXN0b3J0aW9uIG9uIHRoZSBzY3JlZW4uCj4KPiBQUzogVGhpcyB2YWx1ZSB3YXMgY2hh
bmdlZCBmcm9tIDEyOCB0byAxMDAgaW4gUmFkZW9uIGRyaXZlciBhbHNvLCBoZXJlOgo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9mcmVlZGVza3RvcC9kcm0tdGlwL2NvbW1pdC80YjIxY2UxYjRiNWQyNjJl
N2Q0NjU2YjhlY2VjYzg5MWZjM2NiODA2Cj4KPiBDYzogQWxleCBEZXVjaGVyIDxBbGV4YW5kZXIu
RGV1Y2hlckBhbWQuY29tPgo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gQ2M6IEVkZHkgUWluIDxFZGR5LlFpbkBhbWQuY29tPgo+Cj4gU2lnbmVkLW9m
Zi1ieTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYyB8IDIgKy0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYwo+IGluZGV4IDFmMjMwNWI3YmQxMy4uMjNhMmUxZWJm
NzhhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYwo+IEBAIC04
NSw3ICs4NSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9wbGxfZ2V0X2ZiX3JlZl9kaXYodW5zaWdu
ZWQgbm9tLCB1bnNpZ25lZCBkZW4sIHVuc2lnbmVkIHBvc3RfCj4gICAJCQkJICAgICAgdW5zaWdu
ZWQgKmZiX2RpdiwgdW5zaWduZWQgKnJlZl9kaXYpCj4gICB7Cj4gICAJLyogbGltaXQgcmVmZXJl
bmNlICogcG9zdCBkaXZpZGVyIHRvIGEgbWF4aW11bSAqLwo+IC0JcmVmX2Rpdl9tYXggPSBtaW4o
MTI4IC8gcG9zdF9kaXYsIHJlZl9kaXZfbWF4KTsKPiArCXJlZl9kaXZfbWF4ID0gbWluKDEwMCAv
IHBvc3RfZGl2LCByZWZfZGl2X21heCk7Cj4gICAKPiAgIAkvKiBnZXQgbWF0Y2hpbmcgcmVmZXJl
bmNlIGFuZCBmZWVkYmFjayBkaXZpZGVyICovCj4gICAJKnJlZl9kaXYgPSBtaW4obWF4KERJVl9S
T1VORF9DTE9TRVNUKGRlbiwgcG9zdF9kaXYpLCAxdSksIHJlZl9kaXZfbWF4KTsKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
