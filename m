Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1588CC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 08:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D064F6127C
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 08:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D064F6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D706E1CD;
	Wed, 14 Jul 2021 08:51:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D646E1CD;
 Wed, 14 Jul 2021 08:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiGRi0HzdOTugltBniCFALUM4rXVyDgr49KMTeIXB0jYRE/5zrzQ71xjm/aYLI8+ZssJJ5SCVRwh4deHanAEeZ19xevXHRqTrH2vkIwTdhihmJjnRDXb8X2gBFALnhfZb+Sy0cbuFPefUqnD2OKwdfeXYcNmpdFuEI+ItxMPtTI7OvM6D7+HTnbGOw5qjusMWBO0ODXNga5VD/ACYQB7Tn+cJc3JU9L8O9BSZSDkng40VMZA3CaEdqrm5M8qSYs7R4nPorQQDga5K6R40r0PHFPsmpkRGTlexDrnWdhbvzTBzckSwLHCITpANZSVNj+3eR/iMoNbSobIvmLZugD1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ltEWAXzHyd+pjoXT73vrgvR6fG5ECBfC2vG/naWnRY=;
 b=OoR3Yp5zjy57TAxcLxjYKiyWhP5a/Z5WXysYVX//hW/svlkJJN8jmmYMbkZx0Iev0SZ7J0MdV0RM9dpyvUYFW0RlGYpkIGWfbopqV5MK+/UWVUxtYg+rzIGkoNHsH7vzEvxiLNDEbFKXQlN2DZELTSo1kUxrN6OHqteS9HlYZkQzW2bijvOqNO9RfFSxG9bENc79yz+9INV4AHCk5FEjGqUNwlfyAXYIaTw/wxpZPt2O1smkLaaMjSeEX71BLcIAW0V8FDmJQ0saScZq2OI5LJ6823tv4umu+Yvt0jHjvO/6WO6cB4RWOLisRreqRvEcQUfESaWwES+SkvN7CkHeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ltEWAXzHyd+pjoXT73vrgvR6fG5ECBfC2vG/naWnRY=;
 b=fiDq8R0gZ5tUjwh7xOUX0tlD6wrd5xiDX1/YEb8OgFXRn0fkLkRNp1NkVa/VlQ89WS6R6FytNS5YsEq78IzuQp6UByI2O3iWE2ywKBtT/JbzslruqfBECf47cMdbiPnKHPjNaK7HcuhvhzqB5bMJswtHGnxvShkDr/e3ezvfjSs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 08:51:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:51:06 +0000
Subject: Re: [PATCH v3 1/1] drm/ttm: Fix COW check
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20210712220636.475675-1-Felix.Kuehling@amd.com>
 <d617d831-7168-51a4-042e-e36a5af7761d@gmail.com>
 <CADnq5_NCg6VnWgH7Hn61CjZBZiRuAdROW5s6imwQ8AR=9Bm4=g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1dd35814-c2bb-6e71-6259-e9d4f77d8969@amd.com>
Date: Wed, 14 Jul 2021 10:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_NCg6VnWgH7Hn61CjZBZiRuAdROW5s6imwQ8AR=9Bm4=g@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:205:1::39) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fe2b:fec6:eeb5:c7dc]
 (2a02:908:1252:fb60:fe2b:fec6:eeb5:c7dc) by
 AM4PR07CA0026.eurprd07.prod.outlook.com (2603:10a6:205:1::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.8 via Frontend Transport; Wed, 14 Jul 2021 08:51:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c3f1b4-2e21-490e-4acc-08d946a484a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4317E4D78F247F397E3F2CF183139@MN2PR12MB4317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:218;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytXgDweSKE6fSeAb06i1dbr05Gov/jq3+TF/djxPXaGcwAz7C75qIMCMMMucOoqRADynwDfFpylGt9smJTNbZPT0v/qREuBokmINL5f0NyTCAZaYUK9ivmvhhhG72nXk6iu4BOonqaqcrxlIDSFQuRPlPId0oFEgV2HgnS4jhO/USnJJT8tgY2qEKrJRAMqUtl1rL5gMgUZJmFtMXGKzZneePnccpmDuyyuoM/aoaysSQKgWjoluFtrTQmHIdcnEYPGKcsD6cLG0E0EEzpnWxC5mZ798oSbiMulzqMDU6KbNtnLgBAfvSxFzZtkJeON3omSIoFtBjNe0WBIGkr/gfDIEh1BI6eLtZaDG5n2xMW5CvJiVOSeSW/DhoDXCRs1jv+cIWa/hr1zopc2ZBV6iJJCNwFgSHYOFzPkFAHB5Vmpv/0YSHVuEkzJdclX7S5WxqMsDV3maXZoLPeswYYN0bWdOV/3gtxTaEUgqY9tFgM+panynNSDt2mkRfhIIZdRSWeWNqBcM/hcPhC9QS7MS1mv6eJsyVhFv93quCMKx0mEBm0eW2/AdchMq+PeaPStyTR0wPWO6kwZ0vNJq6BJDyVXVDVQ2ZUyghZOIXya8oARoMohe6Z8pPKPxFJwJV7w6UU1q6PDT4BUoPDuXZqwRex2ShyajzWwZPMpDrGx3OxfNASkQCDS5cLsE7kGQQighnXdN5erw4ezTJn4ydsrYUi8TzHPcSXoySkQDg+t0Nx6BOvug+XptYRhzGudS3pXD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(366004)(346002)(136003)(396003)(376002)(31686004)(38100700002)(6486002)(5660300002)(53546011)(186003)(4326008)(66946007)(66556008)(66476007)(83380400001)(316002)(31696002)(8676002)(86362001)(110136005)(66574015)(2616005)(54906003)(8936002)(6666004)(478600001)(36756003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTRaUVV5WDZ0Z1h2aitrRndIeDFBUFZnd1JGSlovbkVQZTVua2JrZUVPZjlE?=
 =?utf-8?B?NVZXZTY3UGJITDBOd0g4Zyt6TXE2eWU4Mm40dWhMOC9yL0JPZXc2SzdkWWpx?=
 =?utf-8?B?UU82cSt2V01QRXdDY3RjdFoyTzQ2LzJYWUNMRXVWeVIwQlZpN0FZTlh1MzhS?=
 =?utf-8?B?ZCs4bHplcXFzZm9GS0loTkR5SVIxR2FwYS8yc2hzWGlSeDI4N2FMQzNIdTBx?=
 =?utf-8?B?WCtUREJuM3FEZ3hJRXB2ZTYzRy9KU1JacmMwYUIxUGFIbnNFK0RpQjRQRjQx?=
 =?utf-8?B?ZFhZMHZPN0w3VkRxcW1Fd3pRQWNvRGMzZzgrNnFORVJWUmR4eTYzNFJ3dU5O?=
 =?utf-8?B?SzVONnMwMGlFdS9tZWNheDB6UEo0ZGFTd2hwYkNtdGV3MTU0NGJsT0ZXOTRW?=
 =?utf-8?B?M2IrUy9STEd1KzUwT0tibS82dHRTK3BBcGtOQURlaWFHNzZDZU1vMWFZcGpG?=
 =?utf-8?B?RElVOU81d3FlTlpoa0JBVDdTSXBML0Zxak15VGorUXY4MnR5WkFuaG5telh5?=
 =?utf-8?B?YktTdnhhTFF5TW5ndjFQSC9ocngvWGIybkNrcStrV2c0eGZHSEd5aXNWRWZY?=
 =?utf-8?B?cFVqLzZJNk9MeVBPVUN4RFU1SlFaUTZyWW16VkVZRk9OTWgxQXYwOVJUV0tm?=
 =?utf-8?B?L1FqZ1ZYNUtsTEkzM09IVmpkZmVobmRocEpxa3BFM0UzTG9jRVRGMEMyc0dH?=
 =?utf-8?B?TzV6TVdXNnV3SnNhcjRvbGZnOUZPS0lWa2pFZE5mZEFBWWVFSGF2RjNvSm1Q?=
 =?utf-8?B?bVgvVWtoR0E4TmViV3pZTlJvb252WjFHQUMwTVc5WFJQTklLUnJpQklPU3pZ?=
 =?utf-8?B?TzI3ZHoxejU2QlZCcnFqZHU5NVkvUE9lcUxYNzVXV0RVZlV6a0daQXM2OE9x?=
 =?utf-8?B?d3lGN1RmK2czUEx6aWtCaFZTb1BRUEdOSXplSC9RV0xwaUtQamJRME03eFBP?=
 =?utf-8?B?cWRkRkFYVVRKY2JYYkZ1RDdBdzZVbjZqa1hvWjQ3T05jWFIrLy9nRWRHZzVT?=
 =?utf-8?B?K09jeGNmY2hweXBTai9VaGt4dlE2QWpPU01IVkV5VU1LMlA1aExFa0grVHVE?=
 =?utf-8?B?bWZ3UzRScVo0ZzBMdXZPUXRSdnNLUzZVQTc5eWJFVDl5VUZsa0gwNmhNVFJJ?=
 =?utf-8?B?V0pyN2E0eG9YTSs5R1lxVTZyc3NCb3VGcGtjRGk5Z0N2aUVyai9nZ1BNOUkr?=
 =?utf-8?B?N1JDeld4ZWtpZUNQSmJvUm9NckNsaHVkYnlxUFZRRnlGUkVPT20zMWhzQTN0?=
 =?utf-8?B?dGROd3lJM0kzeFd6Tm5qS1JyVGFqN2hES0VMeDJDaERyOG9HV0l6dHBoUS9X?=
 =?utf-8?B?UkpYL2ZQOGJZMURDTzRpL0RzQ3lEakFuaWpqaVE2bHBESksrQ1lkd296eDdt?=
 =?utf-8?B?TTZCdmc2N2gycFYrdEFQdy9qVXZMdmVNL2RSV0pvTkpNcmFqc1ZqdnVHamJB?=
 =?utf-8?B?YXNFNjJzV1lLc0JNOWg0cWtGY3pyQnZXTkw4U1B0SmpVOHJCZTdxMm5CTVJG?=
 =?utf-8?B?Z0VoU1RDd3E1M09mOVM3cE9hYkExTlJ1Nm55RE9HQ1dMMWFJQmhKOXZzMzhH?=
 =?utf-8?B?c3F5U0tSWG1iM1N4Tzg5T1BKa2xBV1ljcnhjanhRdXB1cjFXeG43dDJYU1JT?=
 =?utf-8?B?dFc2d0NEWkpyQ3VzS0ZPcStjWEtkY3E4TlJZT1JXSGFOK3p6YVhLbTR2ajIr?=
 =?utf-8?B?Tm93cDVQcHd4WCtHZ3dzS2k5WExjQjQzUkJ0azRVOHZUODZkajFlbzVBZnVZ?=
 =?utf-8?B?OG1kUVloY3ptUTRoTVE0bGtUQk9CN3JGa082Wk9lYzFmaklndzBlRGRhNFpJ?=
 =?utf-8?B?OWRFR0k0d2RqNy9iZVNtVkxUa0Y0NlFER0pxU1VSYWMwRjV4ekVGUUlMUlV4?=
 =?utf-8?Q?kvmvRJKN1ig3x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c3f1b4-2e21-490e-4acc-08d946a484a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:51:06.8176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajEDCXXtGAkSypCm3bFHLXAaDvFjwX43mp4bgZeqccl6jpDLybN8pT4FHaRPTfSp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxMy4wNy4yMSB1bSAxNzoyOCBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBPbiBUdWUsIEp1
bCAxMywgMjAyMSBhdCAyOjU3IEFNIENocmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+Pgo+PiBBbSAxMy4wNy4yMSB1bSAwMDowNiBz
Y2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pj4gS0ZEIFRodW5rIG1hcHMgaW52aXNpYmxlIFZSQU0g
Qk9zIHdpdGggUFJPVF9OT05FLCBNQVBfUFJJVkFURS4KPj4+IGlzX2Nvd19tYXBwaW5nIHJldHVy
bnMgdHJ1ZSBmb3IgdGhlc2UgbWFwcGluZ3MuIEFkZCBhIGNoZWNrIGZvcgo+Pj4gdm1fZmxhZ3Mg
JiBWTV9XUklURSB0byBhdm9pZCBtbWFwIGZhaWx1cmVzIG9uIHByaXZhdGUgcmVhZC1vbmx5IG9y
Cj4+PiBQUk9UX05PTkUgbWFwcGluZ3MuCj4+Pgo+Pj4gdjI6IHByb3RlY3QgYWdhaW5zdCBtcHJv
dGVjdCBtYWtpbmcgYSBtYXBwaW5nIHdyaXRhYmxlIGFmdGVyIHRoZSBmYWN0Cj4+PiB2MzogdXBk
YXRlIGRyaXZlci1zcGVjaWZpYyB2bV9vcGVyYXRpb25zX3N0cnVjdHMKPj4+Cj4+PiBGaXhlczog
ZjkxMTQyYzYyMTYxICgiZHJtL3R0bTogbnVrZSBWTV9NSVhFRE1BUCBvbiBCTyBtYXBwaW5ncyB2
MyIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPiBBcmUgeW91IHBsYW5uaW5nIHRvIHB1c2ggdGhpcyB0byBkcm0tbWlzYz8K
ClllcywganVzdCBkaWRuJ3QgZm91bmQgdGltZSB5ZXN0ZXJkYXkuCgpDaHJpc3RpYW4uCgo+Cj4g
QWxleAo+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
ZW0uYyAgfCAgMyArKy0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2Vt
LmMgICAgfCAgMyArKy0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5j
ICAgICAgfCAgMyArKy0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgICAg
ICAgICAgfCAxNCArKysrKysrKysrKysrLQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92
bXdnZnhfdHRtX2dsdWUuYyB8ICAxICsKPj4+ICAgIGluY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBp
LmggICAgICAgICAgICAgfCAgNCArKysrCj4+PiAgICA2IGZpbGVzIGNoYW5nZWQsIDI0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYwo+Pj4gaW5kZXggYjM0MDRjNDNhOTExLi4xYWE3NTBhNmE1ZDIgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4gQEAgLTc5LDcg
Kzc5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCBhbWRncHVf
Z2VtX3ZtX29wcyA9IHsKPj4+ICAgICAgICAuZmF1bHQgPSBhbWRncHVfZ2VtX2ZhdWx0LAo+Pj4g
ICAgICAgIC5vcGVuID0gdHRtX2JvX3ZtX29wZW4sCj4+PiAgICAgICAgLmNsb3NlID0gdHRtX2Jv
X3ZtX2Nsb3NlLAo+Pj4gLSAgICAgLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MKPj4+ICsgICAg
IC5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzLAo+Pj4gKyAgICAgLm1wcm90ZWN0ID0gdHRtX2Jv
X3ZtX21wcm90ZWN0Cj4+PiAgICB9Owo+Pj4KPj4+ICAgIHN0YXRpYyB2b2lkIGFtZGdwdV9nZW1f
b2JqZWN0X2ZyZWUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnb2JqKQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
bm91dmVhdS9ub3V2ZWF1X2dlbS5jCj4+PiBpbmRleCA1YjI3ODQ1MDc1YTEuLjE2NGVhNTY0YmI3
YSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2VtLmMK
Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZ2VtLmMKPj4+IEBAIC03
MCw3ICs3MCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3Qgbm91
dmVhdV90dG1fdm1fb3BzID0gewo+Pj4gICAgICAgIC5mYXVsdCA9IG5vdXZlYXVfdHRtX2ZhdWx0
LAo+Pj4gICAgICAgIC5vcGVuID0gdHRtX2JvX3ZtX29wZW4sCj4+PiAgICAgICAgLmNsb3NlID0g
dHRtX2JvX3ZtX2Nsb3NlLAo+Pj4gLSAgICAgLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MKPj4+
ICsgICAgIC5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzLAo+Pj4gKyAgICAgLm1wcm90ZWN0ID0g
dHRtX2JvX3ZtX21wcm90ZWN0Cj4+PiAgICB9Owo+Pj4KPj4+ICAgIHZvaWQKPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nZW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2dlbS5jCj4+PiBpbmRleCA0NThmOTJhNzA4ODcuLmMxOWFkMDdlYjdi
NSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2dlbS5jCj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9nZW0uYwo+Pj4gQEAgLTc3LDcg
Kzc3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCByYWRlb25f
Z2VtX3ZtX29wcyA9IHsKPj4+ICAgICAgICAuZmF1bHQgPSByYWRlb25fZ2VtX2ZhdWx0LAo+Pj4g
ICAgICAgIC5vcGVuID0gdHRtX2JvX3ZtX29wZW4sCj4+PiAgICAgICAgLmNsb3NlID0gdHRtX2Jv
X3ZtX2Nsb3NlLAo+Pj4gLSAgICAgLmFjY2VzcyA9IHR0bV9ib192bV9hY2Nlc3MKPj4+ICsgICAg
IC5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzLAo+Pj4gKyAgICAgLm1wcm90ZWN0ID0gdHRtX2Jv
X3ZtX21wcm90ZWN0Cj4+PiAgICB9Owo+Pj4KPj4+ICAgIHN0YXRpYyB2b2lkIHJhZGVvbl9nZW1f
b2JqZWN0X2ZyZWUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpnb2JqKQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0
bV9ib192bS5jCj4+PiBpbmRleCBmNTZiZTViYzA4NjEuLmZiMzI1YmFkNWRiNiAxMDA2NDQKPj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4+IEBAIC01NDIsMTcgKzU0MiwyOSBAQCBpbnQgdHRt
X2JvX3ZtX2FjY2VzcyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBh
ZGRyLAo+Pj4gICAgfQo+Pj4gICAgRVhQT1JUX1NZTUJPTCh0dG1fYm9fdm1fYWNjZXNzKTsKPj4+
Cj4+PiAraW50IHR0bV9ib192bV9tcHJvdGVjdChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwg
dW5zaWduZWQgbG9uZyBzdGFydCwKPj4+ICsgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgZW5kLCB1bnNpZ25lZCBsb25nIG5ld2ZsYWdzKQo+Pj4gK3sKPj4+ICsgICAgIC8qIEVuZm9y
Y2Ugbm8gQ09XIHNpbmNlIHdvdWxkIGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVoYXZpb3Igd2l0aCBp
dC4gKi8KPj4+ICsgICAgIGlmIChpc19jb3dfbWFwcGluZyhuZXdmbGFncykgJiYgKG5ld2ZsYWdz
ICYgVk1fV1JJVEUpKQo+Pj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4+ICsKPj4+
ICsgICAgIHJldHVybiAwOwo+Pj4gK30KPj4+ICtFWFBPUlRfU1lNQk9MKHR0bV9ib192bV9tcHJv
dGVjdCk7Cj4+PiArCj4+PiAgICBzdGF0aWMgY29uc3Qgc3RydWN0IHZtX29wZXJhdGlvbnNfc3Ry
dWN0IHR0bV9ib192bV9vcHMgPSB7Cj4+PiAgICAgICAgLmZhdWx0ID0gdHRtX2JvX3ZtX2ZhdWx0
LAo+Pj4gICAgICAgIC5vcGVuID0gdHRtX2JvX3ZtX29wZW4sCj4+PiAgICAgICAgLmNsb3NlID0g
dHRtX2JvX3ZtX2Nsb3NlLAo+Pj4gICAgICAgIC5hY2Nlc3MgPSB0dG1fYm9fdm1fYWNjZXNzLAo+
Pj4gKyAgICAgLm1wcm90ZWN0ID0gdHRtX2JvX3ZtX21wcm90ZWN0LAo+Pj4gICAgfTsKPj4+Cj4+
PiAgICBpbnQgdHRtX2JvX21tYXBfb2JqKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBzdHJ1
Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQo+Pj4gICAgewo+Pj4gICAgICAgIC8qIEVuZm9yY2Ug
bm8gQ09XIHNpbmNlIHdvdWxkIGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVoYXZpb3Igd2l0aCBpdC4g
Ki8KPj4+IC0gICAgIGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSkKPj4+ICsgICAg
IGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdzKSAmJiAodm1hLT52bV9mbGFncyAmIFZN
X1dSSVRFKSkKPj4+ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4KPj4+ICAgICAg
ICB0dG1fYm9fZ2V0KGJvKTsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4
L3Ztd2dmeF90dG1fZ2x1ZS5jIGIvZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfdHRtX2ds
dWUuYwo+Pj4gaW5kZXggZTZiMWY5OGVjOTlmLi5lNGJmN2RjOTkzMjAgMTAwNjQ0Cj4+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF90dG1fZ2x1ZS5jCj4+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vdm13Z2Z4L3Ztd2dmeF90dG1fZ2x1ZS5jCj4+PiBAQCAtNjEsNiArNjEsNyBA
QCBpbnQgdm13X21tYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hKQo+Pj4gICAgICAgICAgICAgICAgLmZhdWx0ID0gdm13X2JvX3ZtX2ZhdWx0LAo+Pj4gICAg
ICAgICAgICAgICAgLm9wZW4gPSB0dG1fYm9fdm1fb3BlbiwKPj4+ICAgICAgICAgICAgICAgIC5j
bG9zZSA9IHR0bV9ib192bV9jbG9zZSwKPj4+ICsgICAgICAgICAgICAgLm1wcm90ZWN0ID0gdHRt
X2JvX3ZtX21wcm90ZWN0LAo+Pj4gICAgI2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFH
RQo+Pj4gICAgICAgICAgICAgICAgLmh1Z2VfZmF1bHQgPSB2bXdfYm9fdm1faHVnZV9mYXVsdCwK
Pj4+ICAgICNlbmRpZgo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBp
LmggYi9pbmNsdWRlL2RybS90dG0vdHRtX2JvX2FwaS5oCj4+PiBpbmRleCBmNjgxYmJkYmM2OTgu
LjQwZWI5NTg3NTM1NSAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBp
LmgKPj4+ICsrKyBiL2luY2x1ZGUvZHJtL3R0bS90dG1fYm9fYXBpLmgKPj4+IEBAIC02MDUsNiAr
NjA1LDEwIEBAIHZvaWQgdHRtX2JvX3ZtX2Nsb3NlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
KTsKPj4+Cj4+PiAgICBpbnQgdHRtX2JvX3ZtX2FjY2VzcyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwgdW5zaWduZWQgbG9uZyBhZGRyLAo+Pj4gICAgICAgICAgICAgICAgICAgICB2b2lkICpi
dWYsIGludCBsZW4sIGludCB3cml0ZSk7Cj4+PiArCj4+PiAraW50IHR0bV9ib192bV9tcHJvdGVj
dChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBzdGFydCwKPj4+ICsg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZW5kLCB1bnNpZ25lZCBsb25nIG5ld2Zs
YWdzKTsKPj4+ICsKPj4+ICAgIGJvb2wgdHRtX2JvX2RlbGF5ZWRfZGVsZXRlKHN0cnVjdCB0dG1f
ZGV2aWNlICpiZGV2LCBib29sIHJlbW92ZV9hbGwpOwo+Pj4KPj4+ICAgIHZtX2ZhdWx0X3QgdHRt
X2JvX3ZtX2R1bW15X3BhZ2Uoc3RydWN0IHZtX2ZhdWx0ICp2bWYsIHBncHJvdF90IHByb3QpOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
