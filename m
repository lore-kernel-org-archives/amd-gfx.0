Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2CC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 12:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C43611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C43611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4206F6E528;
	Fri, 28 May 2021 12:18:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCC3E6E528;
 Fri, 28 May 2021 12:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qql8pdkNaJJtVCGPX6MzHPvhq+uhONKMbdmqd99GKrasOu9ud17yyka2gIgMdMcJP26qLPrw/FHtr7NgvzqYdvUSFg9RcU/gmJcG8jnHvkSUOB+LzZDwnqrC/0JBWtW8yQ/tRh2jecwEBaV/lmd1QMbAhmt5AuZVDv9yCQfanT0TrWRhKX/dEoJttYPXUsznT+3EIYGRmOK0aVAFYAvir1MouyQkryV0cQ+SRRuGMIYuyPmjCg2ObxwrQe+iDU04wksu+jWUPK/g1G/wkwT2WuoJJkieUaucAuE/BYbCQJpaiAgn/GxnA1pDgiRugBetj8axMb0Hj8SbIA/M8GQRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU/d0yAslbJCuaO8uINvMc1IGDajUOC9Ejc96ICdXYo=;
 b=E4JBmXQjkBhaE9wuCBznYlHpXzz6FNBbvgz2X3qjjv01e0E2/imY7hLVs3pwfp+vzAnHIfFJ9IMkB2yvFmPuwEz0679uBxHw3g8WDSQo3QDDiY9o6ng0iVR4KiODBqsKqzgVLah6oPXZEPKhGKfmjbgkHq44cAkXfWJlS2cqsVFgGFVVD+NVJ+9Jhh9MVvp3g9JZkXeITCuNRxS5FIrbBcP7KmlWMPo/X5yVCq8aS6ragoVHmT+iEr/QNpraSwMm8O4zd+IB0y/q55dC8DxPo8YDOwelQUpmHUGDjDfzDSt5dcAQRN51i6YvGauVJNw8bAuyiJGtU3/1r9c68TiLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU/d0yAslbJCuaO8uINvMc1IGDajUOC9Ejc96ICdXYo=;
 b=HnCxtOiV9SBFhj1C8tsUILoTMBDRZmoWcUAQ5vcLgY6Vai57KY/Yts1hszpAp13g/DbzPg46+Vr8g4om1yuXhFW0EQX/2unwGf7+j8u/TXtxeTGEX6aLhF4C2aS5Pj63ko7KXwZtgvbuMccH6OxdSQVZMTaK2qC/atvwJJl0P6E=
Authentication-Results: lists.linaro.org; dkim=none (message not signed)
 header.d=none;lists.linaro.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4739.namprd12.prod.outlook.com (2603:10b6:208:81::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 28 May
 2021 12:18:27 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 12:18:27 +0000
Subject: Re: [PATCH v3] amdgpu: remove unreachable code
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, alexander.deucher@amd.com
References: <1622194158-70898-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <37a4f0bf-4acb-3961-699b-8335e194e315@amd.com>
Date: Fri, 28 May 2021 14:18:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1622194158-70898-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:c3f6:1c8f:ede0:3bcb]
X-ClientProxiedBy: AM8P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:c3f6:1c8f:ede0:3bcb]
 (2a02:908:1252:fb60:c3f6:1c8f:ede0:3bcb) by
 AM8P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 12:18:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d3e2f93-e7c6-40ec-73b6-08d921d2b227
X-MS-TrafficTypeDiagnostic: BL0PR12MB4739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4739EFCC791330925B348FE683229@BL0PR12MB4739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9wsCu3xruOOaogQzadeInkBiVFIk8rMakkXb2TTl0garPxhkMumZAy5K4W9lVqghNDanva8Jx2pSpb4OZ4+P/XVSS9z2ZC/XFsanVg1AUP1wor8yR6VSuraQJpk3Q1SoLds8wHNdTa/ZsLIfuI7vcHW+ew62gJSCAYHchCCU43u8qcTL0LEXf1q3FbdJZQGSVybHNlKX5plqTcwjHBU6ilpjiapqCSNcL2b1Ni8TEAf/QRKGn4OyoFN3lYxWg3nqo3GuP5vGED/ynIeSLyCbxjv1RwSWvJUcRKo4Vf08Mz5urU3cw6uZQu5nma2GsoYsM0eDOd/Yg3ZdDrTBKn+AGMkMxpG4DgzMzi58+jMh0X0WDMqA4Gd6m6LRyMJCcIsToHlGYhUUeTg16XXgnjJVBfgTEPqmynXt+MVMPE9o0eytufV2VEm9fYf+mddvXmZy/jcAuyUn7+uqDZG0IHd5vgMuFTsfNp7dotPRj3omtxU6KdSdS0IFQHgDVsSw5t4UXcv3f5cCfup0Ac4Vok8cmlJoVWWf6vXW+DcZKl15rJkOlwWOCZGZcmRTE0Y3cSopr9yE9oiPurVopIGYvk+yPCJCNQnwz4cdhHFFaDHiicgHNBLzqQvtfKXl0XVuqjgTZ8rOMFxqTrGrkRs9MO9POQXu2nLUctOSpiHHK/ej4ybuiJpsJ4RA4jl79dgjDONiz7S6u7OvUxFNHAVoI3+HQ4crBehxht7XPxXjYDZvih0ql+6v2SyCMjYSKyoa+W79RVj/P5XXEf5uavGfAZlUoWKCv7FN49Bz2NDeFypUfrJ3eYAHbzxYHow7mg0+fKM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(4326008)(478600001)(31686004)(6666004)(2616005)(966005)(36756003)(66946007)(5660300002)(2906002)(6486002)(8676002)(16526019)(6636002)(8936002)(66574015)(66476007)(38100700002)(83380400001)(186003)(66556008)(31696002)(86362001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WkR3cE9ZTC94VTdvRExXcktrQVFvQ1htZi8xb3VMYzd0T0xabTExOTlwYzhN?=
 =?utf-8?B?THZZbGhuZ2NUaVpYNE9ySHY2QkRXRUxnWGVUbDlkVWxBV1NqcG5lUUFqellh?=
 =?utf-8?B?aktGcEZRNElFdVFoQ3hMODl4UCtyenNhcW5yaDZOT0pPdWhGMzZaMVhJYWRT?=
 =?utf-8?B?dmdhdzBMSWxRZm9QM0FTeVRYYldxczlnMkVVeEJOOVdBa2RmMm1LcnM1RTdz?=
 =?utf-8?B?VlZDcjMxSEpLVmhCbkhXWWQwL2VjcDNVL3lWL3F5TlZqdWQvV1Y3VGp5L2Rr?=
 =?utf-8?B?Z1huaEUvbTZhdVovakk5UkgyTWs2U0VDeFFId0lIVWpGMzRnVnBvMktlMC96?=
 =?utf-8?B?ZXhCZTIvV00rUG9YVXNEcG1ReUlxclNhUEE4Y2pzUkdxeFZiUmNVMENkZTZX?=
 =?utf-8?B?WjJQd3RJeks2UnhxRnJrN1VHY3BqakJwQTZkRzBRemtaTmZoTDFaYlBSUUEw?=
 =?utf-8?B?V2kxa1VCTUsvNHVLcGl0NkRFeWkrUEZ1bWFGTlV6WUdINEJCWXlGL0lJTUti?=
 =?utf-8?B?ZERPWGloZ3hJaCtvcTJTaXV2UTUyZzlIU3RKVkNiTXJyOUVReWJnZ2NxSGh4?=
 =?utf-8?B?aTV4R252VHl3WEM5U2VyTldwQStMODlDTWh6TzNxN1R0UHpBeXppZC9qRjNp?=
 =?utf-8?B?UkN6cnRXM2Jyc3JMYS9sdDRmZXRqTCtNWDBXbVZMTCtKY0Z0d3FUWWMxZ0F2?=
 =?utf-8?B?RVk5YkFublBiSUxzcVRiU1I2cWFkWjNOZFZob1FOOGtFWFRUYjFQUTkvL3kv?=
 =?utf-8?B?U1RpUVNFRVo1dG9NVWFXbldUcE9iQlJzMFkwcGUrT0dYU093OFpseWRJcWk1?=
 =?utf-8?B?by9PbDJNeGdZWG8reHgwRUN1Z1F4eEgzTGV0ZVJISmMzNmVMY3JIcDEzUGxl?=
 =?utf-8?B?OU1sZ1lMWXhHZjRUaFk5M29JUWl5cmNhNlYyM1ZFaWdNa3ZtQVZiQjlCSkJX?=
 =?utf-8?B?NG9PVS95RXU1K0hmdHE5NjJkWTM5T29wUFJJYlhlU2JIZWtIQkw5QkFWalRO?=
 =?utf-8?B?dWFUVkh1QlNKQ0lveE4zcGhYL05IOG1nWnVPajgwVFg1dWw3ZmI4MlVxYmZ1?=
 =?utf-8?B?djY0dCtublhIcDc5alE5c2w1NGVGM04weHRzT0NrZExkWDJoVnZ1WFVNRmRP?=
 =?utf-8?B?THpTSkFJS2tlYWRVOTJrTEpLQWVRWE5lQ2tZd1lsZkRzQnZ2cXpVM2FCMjlZ?=
 =?utf-8?B?TWFURUU5WjRCWnZhMzFpUG14TGJhVWg2amU4WjZ3RDhpYUxYeEl2bnNpckp6?=
 =?utf-8?B?T29pT3ZJc1Y4YU5mOUVRYjR0WmVXSjMrQnJXdEMrdUtlTC9FWER3QVNBNkxr?=
 =?utf-8?B?bXlRMVdBejBta3VMc1doV0x0cGlNendsTGtvckN2MGZXUVBRV2lpa2lYTldj?=
 =?utf-8?B?dVlDZFQ2andPcnpUdVFTNGlhZXJ4dmxqVDdtcmI2WFJtblF2bGVEVXlsVFV3?=
 =?utf-8?B?TWJYKzQ1OWdNa2pGWkxKTjQ4RFU1NThQZUcxbTErUzdnOHhDaFF6NFdRbkRN?=
 =?utf-8?B?ckhNdG5EaS9MSklhY3lnYWhyTVJmYlpZZ2h4cVNOMWpkTzdEVHNzNDAvQk5N?=
 =?utf-8?B?bk4zK3VJZ005TENXbVR2UjVhWXR0Ym53Qm91VXNLRHFBR1lCc0lVSHh5azFO?=
 =?utf-8?B?N29jUmhMU1VDWnphWHdDRVR6cENzcHRzR3UxdWVVSTNZM1daYUJGU1M2VkxX?=
 =?utf-8?B?OFNlM0hVTGdTUmpVUm1CZ0JWZ29VZ3kvT3lzNyt6TzBSMEdHZFhvVTR3VEZl?=
 =?utf-8?B?b08wckRaNUowSWJieTlNamxnb3ZxcndsblpaTUwxdlpOOG51WXYvKzROb0lC?=
 =?utf-8?B?UUZicmhQTXlJRnhjbGNvTkZBTTdidVdtM0pZRnFraGlwRmZLdXBDYk5jS1pq?=
 =?utf-8?Q?GJSe8RJstrpGu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3e2f93-e7c6-40ec-73b6-08d921d2b227
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 12:18:27.1571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1pVA7bMP0POSqYQFSY/btxKVkt4oKesxZSVoc42VJc1bDiG8KLNp+Yba1DawWh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4739
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch, sumit.semwal@linaro.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDUuMjEgdW0gMTE6Mjkgc2NocmllYiBKaWFwZW5nIENob25nOgo+IEluIHRoZSBmdW5j
dGlvbiBhbWRncHVfdXZkX2NzX21zZygpLCBldmVyeSBicmFuY2ggaW4gdGhlIHN3aXRjaAo+IHN0
YXRlbWVudCB3aWxsIGhhdmUgYSByZXR1cm4sIHNvIHRoZSBjb2RlIGJlbG93IHRoZSBzd2l0Y2gg
c3RhdGVtZW50Cj4gd2lsbCBub3QgYmUgZXhlY3V0ZWQuCj4KPiBFbGltaW5hdGUgdGhlIGZvbGxv
dyBzbWF0Y2ggd2FybmluZzoKPgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91
dmQuYzo4NDUgYW1kZ3B1X3V2ZF9jc19tc2coKSB3YXJuOgo+IGlnbm9yaW5nIHVucmVhY2hhYmxl
IGNvZGUuCj4KPiBSZXBvcnRlZC1ieTogQWJhY2kgUm9ib3QgPGFiYWNpQGxpbnV4LmFsaWJhYmEu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IEppYXBlbmcgQ2hvbmcgPGppYXBlbmcuY2hvbmdAbGludXgu
YWxpYmFiYS5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+ICAgIC1Gb3IgdGhlIGZvbGxv
dyBhZHZpY2U6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xNDM1OTY4
Lwo+Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMgfCAzICstLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+IGluZGV4IGM2ZGJjMDguLjM1ZjY4
NzQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCj4gQEAgLTgy
OSw5ICs4MjksOCBAQCBzdGF0aWMgaW50IGFtZGdwdV91dmRfY3NfbXNnKHN0cnVjdCBhbWRncHVf
dXZkX2NzX2N0eCAqY3R4LAo+ICAgCj4gICAJZGVmYXVsdDoKPiAgIAkJRFJNX0VSUk9SKCJJbGxl
Z2FsIFVWRCBtZXNzYWdlIHR5cGUgKCVkKSFcbiIsIG1zZ190eXBlKTsKPiAtCQlyZXR1cm4gLUVJ
TlZBTDsKPiAgIAl9Cj4gLQlCVUcoKTsKPiArCj4gICAJcmV0dXJuIC1FSU5WQUw7Cj4gICB9Cj4g
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
