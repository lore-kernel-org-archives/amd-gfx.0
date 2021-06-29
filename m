Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C931C11F6A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 22:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86E361DA0
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 22:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86E361DA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4448A6E8FF;
	Tue, 29 Jun 2021 22:08:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E3C6E8FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 22:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzVekvoJ4j1eDMUpzOSxXBBHosrYXSemQLxUxMsmUWtLuF7fFd4BRREJjBkZx3MUwvLxDfenIrZEw02fqO/H5ULyp9WWtcoRTx+n7xrk63CaWQa7D+4jAhhBXhuUgf0z1n3xSeKJxc2GI8UFVQCWa3Tse6aYYflSrmqI1OOuyW/ty/3WZCgqfQc+DOqWeb6lmQidrGFyRYbZU6zVbkmbqSDk/nC87krUTX6ECn4Hu6teHB0DxhRHn1QRWC8ujbQRxBIFIMNu+Jr4RtkLoHFmrl12DTDzLAi9LgxGy1hUwnn5fRREL8WKDlT4wrHYoq4LUO0LGCjlzU44CIu49mTiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLeODFSo270TF5mOiB7sO4/5A6HG85cMRrCrIO4l5dM=;
 b=gMKcvVXzPYsLrm9TyDFr9L/2DCs2nu4nECW/GYz/CLdEE095lNS7GFUW6VIotDOC1K+R6WTTv1/wMRbiRWvUnErvoD9kKBz5jDD9kk9NYIAmzN/eGdQeM0Jzxh1xHYC/D5NVRm7n6mQd7Uk65kWI9sIjOnCWkgo9bjnOzxZcXX3op8cyhnBBiKFUZ4pbciYWtxWnFKmIfw/5usUrRspEkFLQ5To3Ne9mxRp6oZz7CkP1GoXVwHvc5eQgUvLzi54/Z2s2alrFGM8U8DgAnM9ILvtom1g30s9e7E2Ovr3I1omB8UosRshYaAofYHrYOV0Rn3oLZa2hcMBgbUr7gz/lCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLeODFSo270TF5mOiB7sO4/5A6HG85cMRrCrIO4l5dM=;
 b=IPLtuHf2UuWCpni2BmNzaPQWt1QeZbJX5egpLbVUODnQ+n2gAjbERNoyVTbs/QogXLwvSCESTGJJlKN5R244R3NJ8FrMdW8VK3KULRrmopgXQyzgG5QB+xgWBSPD8jyCvjbVpt0lm4oBH9vsY2D0nVH8e2lANTVKwSUFcVXADKQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 22:08:13 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 22:08:13 +0000
Subject: Re: [PATCH] drm/amdkfd: inc counter on child ranges with xnack off
To: amd-gfx@lists.freedesktop.org, Alex Sierra <alex.sierra@amd.com>
References: <20210629214828.3847-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ca0878cd-8351-ba8d-c061-9730c65f63dc@amd.com>
Date: Tue, 29 Jun 2021 18:08:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629214828.3847-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.84.51]
X-ClientProxiedBy: YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::24) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YTXPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 22:08:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c8f01a-4ef6-4895-b029-08d93b4a63b7
X-MS-TrafficTypeDiagnostic: BN9PR12MB5226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB522619B0C113199636CCD15B92029@BN9PR12MB5226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfvHKQzaRfELy8AHXuadM94WiY6Nycmr9C6LvJ7R2qnXwuDrQIL1lHeTbVlnODaAgOkQW7pvrlvKmf82aj3XZeqgDvulw8+6QbTtCXGaFG8cOCbhl1CN6lGgxaDRjYiz8HSNsCgn8p07j715Mow6LXtP3rSvvHMENDyIs8ra1IAcnc3k1qyYmTrwZ1vqdHL3I0PTvGUYNQx5GrDOoiJaKH0pxDecq82AKfNY6UJ3nUq9EjIxL6UnejYWHaUbzA3Q4IJXp6e1x2RWJx2zTJB3LTxkmNFERxR7dLpHmtuGmwR5g0X84JJz9c7AY1Zq5kDICVkaVTV9FqV6Eja0JnXkQtjrpAtk6fMai1gnaE2hWUyvUwabqU5cp723LuAPrwSnHpTkEItSFpz9Yd+ZxNYV5TOFlqhRVCnJ4J6T6uyMbmA4TtF+7w0EfT9RWoFpL4VLo1SY+AODyo6rpEcs0XirJxf5JPMVFxnqjzdn6kY/V0y6iQ+l5LffNebzAwAY/EXqdNq9BmyY2j5qgpowx7DqFWMF5fm2N+Fd+8eItvve8a9PJ+GklmAno2hTEyGS1fvMqfjA844KcmuA4DS0Q23/QNl1KZpWwZp1ZrzeqtPRvoUbGAtfD3Gv8LLV9eq0Y7QNNvGckSBIM2ndQsDPx8eu+mHbLC3WWx+sJ/FsDPxdEZy0pdWS/kl5ybZ8noxaoPD8il4LSZ4p9+Grqg6cpoY5qoew9AyfgLlFJj9iOwhGTSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(316002)(6636002)(6486002)(16576012)(37006003)(38100700002)(8936002)(66476007)(478600001)(26005)(31686004)(36756003)(86362001)(31696002)(6862004)(66556008)(2906002)(66946007)(8676002)(186003)(16526019)(83380400001)(2616005)(956004)(44832011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1cvVGtHOWg4S1hLREZEYkFkNHYrOTdvMGlKbDFSYlkxaCtvT1FmVGlJWEV3?=
 =?utf-8?B?eUs0enJWWjN1VkNWdVE5RU1kbXM4NFNneG1GOXdPbm1QMVF6V0w3R29KalJi?=
 =?utf-8?B?Y2xSMkUvakRDSkNQRWZzSnp5Mmp3S1hhQ3RPMkhYTlVPdG1SZHRBOUVQR2ls?=
 =?utf-8?B?U3R4R3ZjczNHV3I4WUpSQlQxYzlaeHNhRGVFV25FbTJUVlJUMU11Z3FSNTA2?=
 =?utf-8?B?V2Qrd3kxTnNLZ2hZZ01Zc0JRSUgybW5mZXFHRC80aGVFbDdIMy9NbVZtSWg5?=
 =?utf-8?B?dnk1V05YenV3dHFxWVhYV1MzUUZoN1JydVVNc2YzWTFkNG9iVnNrdFNhajBz?=
 =?utf-8?B?RkdpR05BeEloNlR0d0NUMitNWm5ZbmJiamx3TkJDQVF6MVlFYVlTYSt0SnNL?=
 =?utf-8?B?SFRqMVprbVZydS9tMG12U0QwN2hOT0FqR1RJdmVsM2VmeGxLcXpMNTJGRHl6?=
 =?utf-8?B?UFQrTFhhY2M3YThsVDY5TFVQZDlMaUd6MVUzajcrT0tWbEFmc3RSRm5GOTlM?=
 =?utf-8?B?Y0d5WE9Cd255VDBpNUpyVkdEYlRtdEVObERMbE1sRHFpc3BaNHpWSlg4M29S?=
 =?utf-8?B?WGZGOHFoUjhBR1FGRVZUNStmRzFxVnVFZkFVMHYzMjBRLzFiWnZPdHlWRHNh?=
 =?utf-8?B?SnZRMEd6Y0tSRTRJeUFjc2g2dkQ2OExmNkNCRVZCSmFEalpJLzNRWVBsc1Np?=
 =?utf-8?B?MXdwWkU5Nk1UeTdZTm51TTNvS0oxcEowaU95WkdoL3FQUzFHZG9mSVFjYzlv?=
 =?utf-8?B?ZmVJem81czdxZytwRldzTWl4RktjSzNYR3pielh2MmpLTlZNSDB4WGdoRVoz?=
 =?utf-8?B?YzBIVi9kanVjM3NSTjc0VWF5cHJIVFFhMGUxVWJLUWlkQ05BTDFRWmFSVksv?=
 =?utf-8?B?M25SK2tKUi9BS1F0bnVHSzdSaFZuMHZsMHIzSGQyZFJOVmtXbjVXb0NZTk9O?=
 =?utf-8?B?dlZEOVVPaHN6NldSbHRqMlJ1UzJyTG8vdXlmNG92TFAwdlRrVTJ5K3NDUzRN?=
 =?utf-8?B?T3NPNWlUNlZZNTZ5VFpscTJ2dm8wQnplOTVMWG1TVldZWU4wdENpVU85MUZ6?=
 =?utf-8?B?dm9GdU5tSDh6L2RNUEdESFJSR1YyeEcxc2NtVmZGUlFSSlMvV3VveHFiMjdP?=
 =?utf-8?B?bGRxY0VDcjhsM1BjWGh4ODRRd2xTUXhMUE8ycS9DTkxwaHd3c01sR05tRWhy?=
 =?utf-8?B?emFWcEJvVi9kZkZadkhNQXNTOUVuSlkxd1ZTajVoUERiZG9FVzNPMWdXTW13?=
 =?utf-8?B?eThiNm1GSlZONzVPaTNTZjBOc3BuWHkxTEZtN1ppUDg1SUp5OW1RaTdacGU2?=
 =?utf-8?B?czdla0hVSTNMSDNUTE9mcTFETmliZXFaZS9iYmRrWFJZRmUyc0hkelVTRlJF?=
 =?utf-8?B?VHZuK3BOLzFsWFpmUU1vQWFoNDFvWlZFR21YeUIyQkhBNmtUS2E4QmlaT0U5?=
 =?utf-8?B?bzJOSUpqb1lLK0dOdGRrUFZKbnFCQWNsWnRObEdsTVpiRGpoTjM5OVcrdWJi?=
 =?utf-8?B?blpQWFF4YWVmZks0M000R0VEejVUQ3NGUzVVL2ZiYmpXTVZMNzI1anoxTU5Q?=
 =?utf-8?B?cTJSYWp6aGVNa0hLYjMvQ0pDNzZ6MGdWaVJwNXdzazVrckhZdi9KWmdUZ3Np?=
 =?utf-8?B?NTh6ejdENm5BMUJsYStmREdIVzZBbytUN2s1VVRiWlJ3bkx0b05raHBGTith?=
 =?utf-8?B?Y1VFa1p3Ky9wUFptQ2Z0ZlNSODJMNUZFRmJFTHVUQ29LcHNaZk9Yb1hOZnZP?=
 =?utf-8?Q?r0/ToFJUC1yx0v2Zb1kuY06nN8qRmxyQqW+1wue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c8f01a-4ef6-4895-b029-08d93b4a63b7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 22:08:13.8029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWdLZJq6h0VczC91VQ6Tsr4KzkqnPOcJLpW13o2EQ+5R9jM3Ijlp6MHsfRQu+6RKmiTCuEPZkaFLt5cAVfx+2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNi0yOSB1bSA1OjQ4IHAubS4gc2NocmllYiBBbGV4IFNpZXJyYToKPiBEdXJpbmcg
R1BVIHBhZ2UgdGFibGUgaW52YWxpZGF0aW9uIHdpdGggeG5hY2sgb2ZmLCBuZXcgcmFuZ2VzCj4g
c3BsaXQgbWF5IG9jY3VyIGNvbmN1cnJlbnRseSBpbiB0aGUgc2FtZSBwcmFuZ2UuIENyZWF0aW5n
IGEgbmV3Cj4gY2hpbGQgcGVyIHNwbGl0LiBFYWNoIGNoaWxkIHNob3VsZCBhbHNvIGluY3JlbWVu
dCBpdHMKPiBpbnZhbGlkIGNvdW50ZXIsIHRvIGFzc3VyZSBHUFUgcGFnZSB0YWJsZSB1cGRhdGVz
IGluIHRoZXNlCj4gcmFuZ2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXgu
c2llcnJhQGFtZC5jb20+CgpPbmUgZm9ybWF0dGluZyBuaXQtcGljayBpbmxpbmUuIFdpdGggdGhh
dCBmaXhlZCwgdGhlIHBhdGNoIGlzCgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+CgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3N2bS5jIHwgMTYgKysrKysrKysrKysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
c3ZtLmMKPiBpbmRleCAwMGI0Njg0NmE1ZTAuLmUzYjRmNjg0MzkzZSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMKPiBAQCAtMTU5MCw2ICsxNTkwLDcgQEAgc3ZtX3Jhbmdl
X2V2aWN0KHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwgc3RydWN0IG1tX3N0cnVjdCAqbW0sCj4g
IAkJdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBsYXN0KQo+ICB7Cj4gIAlzdHJ1
Y3Qgc3ZtX3JhbmdlX2xpc3QgKnN2bXMgPSBwcmFuZ2UtPnN2bXM7Cj4gKwlzdHJ1Y3Qgc3ZtX3Jh
bmdlICpwY2hpbGQ7Cj4gIAlzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKnA7Cj4gIAlpbnQgciA9IDA7Cj4g
IAo+IEBAIC0xNjAxLDcgKzE2MDIsMTkgQEAgc3ZtX3JhbmdlX2V2aWN0KHN0cnVjdCBzdm1fcmFu
Z2UgKnByYW5nZSwgc3RydWN0IG1tX3N0cnVjdCAqbW0sCj4gIAlpZiAoIXAtPnhuYWNrX2VuYWJs
ZWQpIHsKPiAgCQlpbnQgZXZpY3RlZF9yYW5nZXM7Cj4gIAo+IC0JCWF0b21pY19pbmMoJnByYW5n
ZS0+aW52YWxpZCk7Cj4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShwY2hpbGQsICZwcmFuZ2UtPmNo
aWxkX2xpc3QsIGNoaWxkX2xpc3QpIHsKPiArCQkJbXV0ZXhfbG9ja19uZXN0ZWQoJnBjaGlsZC0+
bG9jaywgMSk7Cj4gKwkJCWlmIChwY2hpbGQtPnN0YXJ0IDw9IGxhc3QgJiYgcGNoaWxkLT5sYXN0
ID49IHN0YXJ0KSB7Cj4gKwkJCQlwcl9kZWJ1ZygiaW5jcmVtZW50IHBjaGlsZCBpbnZhbGlkIFsw
eCVseCAweCVseF1cbiIsCj4gKwkJCQlwY2hpbGQtPnN0YXJ0LCBwY2hpbGQtPmxhc3QpOwoKSW5k
ZW50IHRoaXMgbGluZSBvbmUgbW9yZSBUQUIuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4gKwkJCQlh
dG9taWNfaW5jKCZwY2hpbGQtPmludmFsaWQpOwo+ICsJCQl9Cj4gKwkJCW11dGV4X3VubG9jaygm
cGNoaWxkLT5sb2NrKTsKPiArCQl9Cj4gKwo+ICsJCWlmIChwcmFuZ2UtPnN0YXJ0IDw9IGxhc3Qg
JiYgcHJhbmdlLT5sYXN0ID49IHN0YXJ0KQo+ICsJCQlhdG9taWNfaW5jKCZwcmFuZ2UtPmludmFs
aWQpOwo+ICsKPiAgCQlldmljdGVkX3JhbmdlcyA9IGF0b21pY19pbmNfcmV0dXJuKCZzdm1zLT5l
dmljdGVkX3Jhbmdlcyk7Cj4gIAkJaWYgKGV2aWN0ZWRfcmFuZ2VzICE9IDEpCj4gIAkJCXJldHVy
biByOwo+IEBAIC0xNjE4LDcgKzE2MzEsNiBAQCBzdm1fcmFuZ2VfZXZpY3Qoc3RydWN0IHN2bV9y
YW5nZSAqcHJhbmdlLCBzdHJ1Y3QgbW1fc3RydWN0ICptbSwKPiAgCQlzY2hlZHVsZV9kZWxheWVk
X3dvcmsoJnN2bXMtPnJlc3RvcmVfd29yaywKPiAgCQkJbXNlY3NfdG9famlmZmllcyhBTURHUFVf
U1ZNX1JBTkdFX1JFU1RPUkVfREVMQVlfTVMpKTsKPiAgCX0gZWxzZSB7Cj4gLQkJc3RydWN0IHN2
bV9yYW5nZSAqcGNoaWxkOwo+ICAJCXVuc2lnbmVkIGxvbmcgcywgbDsKPiAgCj4gIAkJcHJfZGVi
dWcoImludmFsaWRhdGUgdW5tYXAgc3ZtcyAweCVwIFsweCVseCAweCVseF0gZnJvbSBHUFVzXG4i
LApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
