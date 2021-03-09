Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2D4C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1F46523A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 17:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1F46523A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDBF6E913;
	Tue,  9 Mar 2021 17:40:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9B26E913
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 17:40:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5TR28BlJVyE87H+N0+0EVT7/QAcou6od99puZ5/xbG99jRQj/AeznUjPvnjyXmKPQepW9ZUyAsi84OjPx8Du9BjmKy7MxCQtWw+kNtHtsEQoBB1trkMrLjGD2jW4w/nz2wJnD0DDaNiDg4wtOBNFQTaf2bx7rlnEmZG9U3rs27o7LeMgTqCQfrXRlctyIvvzRr3sT7BPtjxv8R71RQ7aP6BYz54S63JHaIAU03hBpcACrzPI9Yl8PR+YqAq9TLtoZ9GuPtQ0kssIk86THvz6CZIRYV7O70EElwgWw2z9eUKyqWbMFcd8albgkV2BCxoYtFS2VhZXkJ5MaJM1ygeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDht/iv3Lom50tQLly09X/ZDDIpi7IGbHDQz7lGnRcY=;
 b=mDX2cb77canOpQ7cd9fHDyai4xJuEWN/jccrdRpOMqDu7O2Tzz5yAAm99eNdKfSLOfRwKT3ai8PfQSSGBoCfi+USiQtr9wS7eOiXn05jrQTPSl//GRZ1EsESqQwwNHEQTuLVqzC2kcoNWxOnzxsg+CTor0Kxh32cERLyTddzlDuYTsyAtKa4I9l/CbVIfpla2JpGgz81Lh1r3cWhYYBixAIJyhNhdqLnlrC6nXyuJ2xlqfZqZzNdgpvnXqJo41CBR4pGJxLV/UtcS4MM6u0xOlOjd1G2FSS8dc5rE0kvEt+kkdSwT8OumukETX55yoZCfilWhS23RCCKEpKlH+PrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDht/iv3Lom50tQLly09X/ZDDIpi7IGbHDQz7lGnRcY=;
 b=gkbXGknCxK2zCk0CcTV5B17wM0ZoLgV/R3GyLh47jhSm5Z0IC1GkQ4c0GwaxAjCokQGjBEpVbK6MtlY2efFD6nGSMXQY02P2lkHMFkDWcZuvo5XP+thT463cJMqsPAWljqimO5UwB7sWKkYdoNuU87jm1X901sbazDiReDucfvA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4781.namprd12.prod.outlook.com (2603:10b6:208:38::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 17:40:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 17:40:28 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210309161911.45133-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <774127ac-4de9-e5f2-0aaf-470b94884679@amd.com>
Date: Tue, 9 Mar 2021 18:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210309161911.45133-1-jonathan.kim@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:6863:34a9:e041:cda6]
X-ClientProxiedBy: AM4PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:205::39)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:6863:34a9:e041:cda6]
 (2a02:908:1252:fb60:6863:34a9:e041:cda6) by
 AM4PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:205::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 17:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 105ae598-927e-4bb1-7ea0-08d8e3226d8e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4781BD1C5038403D2CCC8BAD83929@MN2PR12MB4781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXbm/A0AM8IyKH3I0gUc8rAFy7EcFxKT6J5XAgd5d1GWFtOwJsfZqoAnBjIO34eA7Ev721GFzSPDXvuIN25DIswmchHOmtLfK6VWElibq5hx7TPUSGCkNUZ4d/EDGEXk+E15OeCo1Ur71UT4Jv6WYDVYVkAQ+Qhci5ev8PKKZjSLLZgdy9eM+ezWv5HpQqqvr5bdQzG6tjVmmZvpSwEyPwhJnoKV5cJmr6rSRKQPCsgRqV7QkvpggHZoD4fPcxziSqQcYP6haJM7aXD6YGpvUetfBlCEhwnKcs9X9JTPk/3ef2p2knzg2MydkT8QPPznG9HP9WxNDiUYqSNEzRHMApZIOgn341XWXptVKaFFIOeY0mDtYaNZA4f4PO/QaKN2rSF0i+v4aD4h6zNh0uQCjRU8A4nAFD49wqBogcvl6lhm6u+YNeV/KnS49j/qt8FsLpAx+mNEmB5cJsjVdrT9Zfgq9qXRPjfEPFnouiy0Dd5JC2/xMyktYXj7eCuENwhTfdIEE2Xe7xGq7A226wzo0glBpmFBwejW/kxsuV5PIieraSjoKLIC2SKEkmhs5GnTsjmggLUGF6qMLXBD1uP3odzUxjp2NKROYJNbJQCieEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(16526019)(52116002)(316002)(5660300002)(31686004)(66574015)(66946007)(83380400001)(186003)(66476007)(478600001)(2616005)(8936002)(6486002)(8676002)(36756003)(4326008)(31696002)(86362001)(2906002)(6666004)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHZFZE5iSm41cTk2MFBremx6NHc2c0RRRUZKeTRXUTFrZmdSU3dZS1ZYTG42?=
 =?utf-8?B?Q1lrTE9vOVNqSHoraURNWnRHREVhcms3N2xmMHNNc3BKMzBxc09HRGw4bTFv?=
 =?utf-8?B?a1NYOHNWSkhGTVZGZm1VWmZYVW1sT2l0dWdQTXZrUlFHTldURXZUQWFrc3Fx?=
 =?utf-8?B?dXkvZTEvNHNKcVpQRnVqaDdBSmNJUUJ1U2hYOXhlL2RjaG5lOUZsOERFNkVs?=
 =?utf-8?B?cXJOTFFwTTE3V3BmOEQxUDVoV01GQStzcFB3K2E4bnhsb1ZWSnJIVUZSNllS?=
 =?utf-8?B?aU1aWjRlUVowU3o5eG5GdFQ4ZVpZOWtxWlJLYlY4VGdBTnJ0d1BodE9oSk1l?=
 =?utf-8?B?Nm1EMjJ5dW9wQ3p4MzJCZlN6bHp6WmRWMlRxaU1kK1h5YTNwQ2RGUHFLbXNv?=
 =?utf-8?B?aktud1YwOGlUZEkrbVdZY21ydWpmQ1YvUnJVdEJuNDh5bVBLTzkxZGFSMlcw?=
 =?utf-8?B?SmtOR1E5aEJVMmM0ZFdIYlR0ZDM5Rm1jSTN6T0IvWFJYTTdxdjRSc0dBMTZp?=
 =?utf-8?B?WXpvNnFlYUZpWWJvR245SkorYlhCNkJrTVJycktRUnZjYmh1bDI2dE9BK3V4?=
 =?utf-8?B?UTRjOTdocGdUWnVoeXlxdFgvY2d3MEs4OGI1NHhwekxTTnc5ZEJkclF2MUlB?=
 =?utf-8?B?TnozV2xDemw5c2JuVGVqYS9WREFMQzBjWklnSkVPaEZyaFlreFdiSTdGVUwy?=
 =?utf-8?B?SjF0YUgrWFdGUG1sS0VBKzYrRzIxdDZhRjlMYUloY1NyUForT0hmS3FkNnNN?=
 =?utf-8?B?YXpMaWZUdktkY0hSOFJMM1VJNXBIbFRYRUVBaVBhNmZGczIweEVZNzBTSFM4?=
 =?utf-8?B?SXgra1k1cVQrQzQ0SFNYaVdFUmR1M1I4cUk0SFpDUWwxc1BnNTU5anB0dEpr?=
 =?utf-8?B?Wk1mZ2QyR1ZaYXF0ZC9DRjloNUJhbUdpMDRvdkhrNjQ4SVJDV210cVJ4MnFq?=
 =?utf-8?B?eWZ3ZzBIc1hveDlPNWorcjVjZStBd1FZcHoyVkJUdDQ3QWJDQzk4anVwVkVa?=
 =?utf-8?B?MTlINVphemNzU3BoMG5vZ2tQZ3VmdjZud2IyR2oreUxXMG9kMnNKSkwzVXRC?=
 =?utf-8?B?Q3kxR011b2ptNGxvcHNlZkVvTkI1S09YTmJNaExUT25nSVU3Q0g4bHFTWGFu?=
 =?utf-8?B?ajhvOGVSa3RpOWs2OEl5YXRZdzUyN2FyQjMrdFkxUk5JZU04RkNwUjQyY2Fi?=
 =?utf-8?B?RmNTOU9iVERBR0MvL285eCtKZXJOS1h3VXl1aUNiRFRLLys0L1dwVFE2OEMw?=
 =?utf-8?B?UXpzYVFGTzFUQ096MXFXNWsyNkVleXlrdkp0ZUliSGg2eTF6ZVB4OWNqZUt3?=
 =?utf-8?B?eFhYMmxpc0ZsYnUyR0o3UVlaUmZIdEJuK2NranFWamk5SS9hQ3U1emQ3UVJs?=
 =?utf-8?B?SjREZnBhbW83RHpQVzlYLy85VDRyOEtMRDJtWGh2MVdOZTJvMjZWT3loaGRv?=
 =?utf-8?B?b29HSWQwQysxRGYzNGdUTUtHK1JaTGtQVldqVTkzaTMzOU1QemI3SzhuT1lO?=
 =?utf-8?B?Nlc2UDA5MFZBYmNLYVJEZTU5SjRWcFFIZEtpdGdGNnFscjd1SThIRCtJMG9w?=
 =?utf-8?B?dkNSWHBUWGlJakhJRklzRk1OVGR5OFB5aXQ1QWVTc3lyRlQweVlIR2xPdHk2?=
 =?utf-8?B?c2hCcWdCS1RIZjYzQXVZRnVLdTJCUUtxVlFJV0tOSUZwNG16RDFXeWdvZDQv?=
 =?utf-8?B?MDRHM3NSOXpNaHQyOFZxRE9qZXUwbXJJMVBQbkVjeHpMUVorY2lQR2xKdnRX?=
 =?utf-8?B?ZStRdUNYbTlERWxMVHpONEdsOThzSEMxdHY1aUhKWDNZZm4ycHpaL01FSWg3?=
 =?utf-8?B?Qm9TdW9yNDFPckE4dEdMK2pnUThwQkdudzJ2SjMxTDFYeWdhSWhRQ1lCbTBl?=
 =?utf-8?Q?3Aa5Rsb91wyLu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105ae598-927e-4bb1-7ea0-08d8e3226d8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 17:40:28.2631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrdqhK3qvLoDNmAWhl96eO95TnCzdXS/pesdU8dOqNUsM64sT/fgkGrPKEs20QWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4781
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDkuMDMuMjEgdW0gMTc6MTkgc2NocmllYiBKb25hdGhhbiBLaW06Cj4gQWRkIElIIGZ1bmN0
aW9uIHRvIGFsbG93IGNhbGxlciB0byB3YWl0IHVudGlsIHJpbmcgZW50cmllcyBhcmUgcHJvY2Vz
c2VkCj4gdW50aWwgdGhlIGNoZWNrcG9pbnQgd3JpdGUgcG9pbnRlci4KPgo+IFRoaXMgd2lsbCBi
ZSBwcmltYXJpbHkgdXNlZCBieSBITU0gdG8gZHJhaW4gcGVuZGluZyBwYWdlIGZhdWx0IGludGVy
cnVwdHMKPiBiZWZvcmUgbWVtb3J5IHVubWFwIHRvIHByZXZlbnQgSE1NIGZyb20gaGFuZGxpbmcg
c3RhbGUgaW50ZXJydXB0cy4KPgo+IHYzOiBTY3JhcCBidXN5IGxvb3AgYW5kIGNoYW5nZSB0byB3
YWl0X2V2ZW50Lgo+Cj4gdjI6IFVwZGF0ZSB0aXRsZSBhbmQgZGVzY3JpcHRpb24gdG8gY2xhcmlm
eSB1c2UuCj4gQWRkIHJwdHIvd3B0ciB3cmFwIGNvdW50ZXIgY2hlY2tzIHRvIGd1YXJhbnRlZSBy
aW5nIGVudHJpZXMgYXJlIHByb2Nlc3NlZAo+IHVudGlsIHRoZSBjaGVja3BvaW50Lgo+Cj4gU3Vn
Z2VzdGVkLWJ5OiBDaHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMgfCA0OSArKysrKysr
KysrKysrKysrKysrKysrKysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2loLmggfCAgNSArKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMKPiBpbmRleCBkYzg1MmFmNGYzYjcu
LjEwMjQwNjVmMWYwMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfaWguYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5j
Cj4gQEAgLTk5LDYgKzk5LDggQEAgaW50IGFtZGdwdV9paF9yaW5nX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgsCj4gICAJCWloLT5ycHRy
X2FkZHIgPSBhZGV2LT53Yi5ncHVfYWRkciArIHJwdHJfb2ZmcyAqIDQ7Cj4gICAJCWloLT5ycHRy
X2NwdSA9ICZhZGV2LT53Yi53YltycHRyX29mZnNdOwo+ICAgCX0KPiArCj4gKwlpbml0X3dhaXRx
dWV1ZV9oZWFkKCZpaC0+d2FpdF9wcm9jZXNzKTsKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+
IEBAIC0xNjAsNiArMTYyLDUyIEBAIHZvaWQgYW1kZ3B1X2loX3Jpbmdfd3JpdGUoc3RydWN0IGFt
ZGdwdV9paF9yaW5nICppaCwgY29uc3QgdWludDMyX3QgKml2LAo+ICAgCX0KPiAgIH0KPiAgIAo+
ICsvKiBXYWl0ZXIgaGVscGVyIHRoYXQgY2hlY2tzIGN1cnJlbnQgcnB0ciBtYXRjaGVzIG9yIHBh
c3NlcyBjaGVja3BvaW50IHdwdHIgKi8KPiArc3RhdGljIGJvb2wgYW1kZ3B1X2loX2hhc19jaGVj
a3BvaW50X3Byb2Nlc3NlZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiArCQkJCQlzdHJ1
Y3QgYW1kZ3B1X2loX3JpbmcgKmloLAo+ICsJCQkJCXVpbnQzMl90IGNoZWNrcG9pbnRfd3B0ciwK
PiArCQkJCQl1aW50MzJfdCAqcHJldl9ycHRyKQo+ICt7Cj4gKwl1aW50MzJfdCBjdXJfcnB0ciA9
IGloLT5ycHRyIHwgKCpwcmV2X3JwdHIgJiB+aWgtPnB0cl9tYXNrKTsKPiArCj4gKwkvKiBycHRy
IGhhcyB3cmFwcGVkLiAqLwo+ICsJaWYgKGN1cl9ycHRyIDwgKnByZXZfcnB0cikKPiArCQljdXJf
cnB0ciArPSBpaC0+cHRyX21hc2sgKyAxOwo+ICsJKnByZXZfcnB0ciA9IGN1cl9ycHRyOwo+ICsK
PiArCXJldHVybiBjdXJfcnB0ciA+PSBjaGVja3BvaW50X3dwdHI7Cj4gK30KPiArCj4gKy8qKgo+
ICsgKiBhbWRncHVfaWhfd2FpdF9vbl9jaGVja3BvaW50X3Byb2Nlc3MgLSB3YWl0IHRvIHByb2Nl
c3MgSVZzIHVwIHRvIGNoZWNrcG9pbnQKPiArICoKPiArICogQGFkZXY6IGFtZGdwdV9kZXZpY2Ug
cG9pbnRlcgo+ICsgKiBAaWg6IGloIHJpbmcgdG8gcHJvY2Vzcwo+ICsgKgo+ICsgKiBVc2VkIHRv
IGVuc3VyZSByaW5nIGhhcyBwcm9jZXNzZWQgSVZzIHVwIHRvIHRoZSBjaGVja3BvaW50IHdyaXRl
IHBvaW50ZXIuCj4gKyAqLwo+ICtpbnQgYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9j
ZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICsJCQkJCXN0cnVjdCBhbWRncHVfaWhf
cmluZyAqaWgpCj4gK3sKPiArCXVpbnQzMl90IGNoZWNrcG9pbnRfd3B0ciwgcnB0cjsKPiArCj4g
KwlpZiAoIWloLT5lbmFibGVkIHx8IGFkZXYtPnNodXRkb3duKQo+ICsJCXJldHVybiAtRU5PREVW
Owo+ICsKPiArCWNoZWNrcG9pbnRfd3B0ciA9IGFtZGdwdV9paF9nZXRfd3B0cihhZGV2LCBpaCk7
Cj4gKwkvKiBPcmRlciB3cHRyIHdpdGggcnB0ci4gKi8KPiArCXJtYigpOwo+ICsJcnB0ciA9IFJF
QURfT05DRShpaC0+cnB0cik7Cj4gKwo+ICsJLyogd3B0ciBoYXMgd3JhcHBlZC4gKi8KPiArCWlm
IChycHRyID4gY2hlY2twb2ludF93cHRyKQo+ICsJCWNoZWNrcG9pbnRfd3B0ciArPSBpaC0+cHRy
X21hc2sgKyAxOwo+ICsKPiArCXJldHVybiB3YWl0X2V2ZW50X2ludGVycnVwdGlibGUoaWgtPndh
aXRfcHJvY2VzcywKPiArCQkJCWFtZGdwdV9paF9oYXNfY2hlY2twb2ludF9wcm9jZXNzZWQoYWRl
diwgaWgsCj4gKwkJCQkJCWNoZWNrcG9pbnRfd3B0ciwgJnJwdHIpKTsKPiArfQo+ICsKPiAgIC8q
Kgo+ICAgICogYW1kZ3B1X2loX3Byb2Nlc3MgLSBpbnRlcnJ1cHQgaGFuZGxlcgo+ICAgICoKPiBA
QCAtMTk1LDYgKzI0Myw3IEBAIGludCBhbWRncHVfaWhfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCkKPiAgIAl9Cj4gICAKPiAgIAlh
bWRncHVfaWhfc2V0X3JwdHIoYWRldiwgaWgpOwo+ICsJd2FrZV91cF9hbGwoJmloLT53YWl0X3By
b2Nlc3MpOwo+ICAgCWF0b21pY19zZXQoJmloLT5sb2NrLCAwKTsKPiAgIAo+ICAgCS8qIG1ha2Ug
c3VyZSB3cHRyIGhhc24ndCBjaGFuZ2VkIHdoaWxlIHByb2Nlc3NpbmcgKi8KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAo+IGluZGV4IDZlZDRhODVmYzdjMy4uODdlYzZkMjBk
YmUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5o
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmgKPiBAQCAtNjYs
NiArNjYsOSBAQCBzdHJ1Y3QgYW1kZ3B1X2loX3Jpbmcgewo+ICAgCXVuc2lnbmVkCQlycHRyOwo+
ICAgCWF0b21pY190CQlsb2NrOwo+ICAgCXN0cnVjdCBhbWRncHVfaWhfcmVncwlpaF9yZWdzOwo+
ICsKPiArCS8qIEZvciB3YWl0aW5nIG9uIElIIHByb2Nlc3NpbmcgYXQgY2hlY2twb2ludC4gKi8K
PiArCXdhaXRfcXVldWVfaGVhZF90IHdhaXRfcHJvY2VzczsKPiAgIH07Cj4gICAKPiAgIC8qIHBy
b3ZpZGVkIGJ5IHRoZSBpaCBibG9jayAqLwo+IEBAIC04Nyw2ICs5MCw4IEBAIGludCBhbWRncHVf
aWhfcmluZ19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2lo
X3JpbmcgKmloLAo+ICAgdm9pZCBhbWRncHVfaWhfcmluZ19maW5pKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKTsKPiAgIHZvaWQgYW1kZ3B1X2lo
X3Jpbmdfd3JpdGUoc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCwgY29uc3QgdWludDMyX3QgKml2
LAo+ICAgCQkJICB1bnNpZ25lZCBpbnQgbnVtX2R3KTsKPiAraW50IGFtZGdwdV9paF93YWl0X29u
X2NoZWNrcG9pbnRfcHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiArCQkJCQlz
dHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKTsKPiAgIGludCBhbWRncHVfaWhfcHJvY2VzcyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9paF9yaW5nICppaCk7Cj4gICB2
b2lkIGFtZGdwdV9paF9kZWNvZGVfaXZfaGVscGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+ICAgCQkJCXN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
