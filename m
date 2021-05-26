Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3314AC2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FDE610A5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FDE610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D4CD6ECBD;
	Wed, 26 May 2021 12:01:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862696ECBD
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 12:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4Hxq/rr+QRVIo37tASkX3zGhmh1sM2v0HLifvO5yexcJ34Wlrin4KuDgWkLbGs4pWPC0heyAH09OWn6dlkpms+4hs83PqsLJHMa1C1u86GxuXWxiDSlz7u4XnARZHEoeHy/Dc6KuA94gEzBlnhr4Ywf197xNRQ2BU2upgSe2xFySIqRjP4zJyoKhE3HN9Ttrm8FaVjoObD1F7LPdfNf/KUakIRxIfYCtfbwHJIuPotxyBSa85sLerVwHNR1xbPG8WvKx+jaoMX5HcdY+bB3ltBSS1f87ZlgE3SSTxOPs9WFNrkCO3g2D3mcksMbtE64DSiOMM9dw8bl/aBQ6/puhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnexdLQmooWkFGMrgjZpOuOkrSYrkbV+c2XgcwTTlm0=;
 b=Kq0v+XVs6SEzKT34+WoNt0bWRakVStqw4JxEmYjkLuUrrPFmkKWomu7p1uHAd8VoU11pWyCHedQFWxncfDxB1fRnjfxzkkruMt56d2qVOh7BxTxaSex2pqjNFiKe1UADOMQ8Y4bLPULvUdVxVH/kNQa7mhqzCMIAlZxW0OevQaiU8vd00lokiINUykC2pOGs/6uqgPULZXukh0N/bx9aB9yqeVC4p5vsEwzrZQ21YZ8GoX9RqCcbh4jQ1sEtv0P9L5Jiv+eoWKWpM/2HOzX1gBrW3vzcaaa76hhloSs/TF+tcT6ERlju3kbpL3KIjawFhuz+shrWFFOID+0+tbq74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnexdLQmooWkFGMrgjZpOuOkrSYrkbV+c2XgcwTTlm0=;
 b=m73KjtoXnh50JxdupoezHXEY46EIt7OQOThsL53oXI+sjdS1P13/VhimVSp63FmvnT0wE1NA/tvtSzMLadsUbakGpAODZV4fCmGY9weWURbbWV+AxBjo/lS4+CkcnlKkygh6UCyy/uBt1o1WyCnprRsMHkVUDifuCcu+HzLwNl8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4639.namprd12.prod.outlook.com (2603:10b6:208:a4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Wed, 26 May
 2021 12:01:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 12:01:13 +0000
Subject: Re: [PATCH 1/7] drm/amdgpu: add amdgpu_bo_vm bo type
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526101027.14936-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7779bec4-e2bc-83e8-2142-de6208fe8d6f@amd.com>
Date: Wed, 26 May 2021 14:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3ecd:562c:67c6:4afe]
X-ClientProxiedBy: AM0PR01CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3ecd:562c:67c6:4afe]
 (2a02:908:1252:fb60:3ecd:562c:67c6:4afe) by
 AM0PR01CA0078.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Wed, 26 May 2021 12:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bfde776-fe57-44da-4cb0-08d9203df583
X-MS-TrafficTypeDiagnostic: MN2PR12MB4639:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4639838CA01BE680D98C2B4F83249@MN2PR12MB4639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vYXXdGq5TXkQvluEKjR4iUA3lIFK9s0E/Jb9GyJD4XVEaSCmlBmNWBKcu8WSaAWIjT6glVoJhiLpo5hfnQ9lyuduIqwI9yy7Q6u797WNK7U2e1k0yBOdG7DDncwyL4UXUBEZVZTMOPOY6loLwZF8pFlKlIt4znXtywoTxvfuZraid1oqBkBc+U85+tkrfpRQZ4kmKSAYF7CVV94KCTgOlzEgU7kPTCOdE/lHjEqCw/X7hdqzOZYt+ZLVD5ibLRksrcf3VVA3zQSZx2GUUhofoYvftdw48tetSNvueJD6njv+S3k9Vw4KiiWqI+mtmzg4ipJSTjfs2OvKx7iu3wnUvlN5iOhXFPnPooSdmkDEPw1ZVgozHCSQoFyyW58VgD/zQFVdvjUmyJjb9DI1J2b90abuiIoJj3P4wRECJVmDEPfmWUQF4Aml4xYEWEHV07NzB+KYT5dN5m3Dc61HpYpgY59GTjWnmhV/o5qCf88ytyETWl7E5nj+40Nib17oaBuBA1Wj+6xPTkb1EmUTLafE1BgbmJuODQZ6PHmNSfFN218ixpIQA+gzuRVHyNEKaSvDc0IblcTWjMro7CkX33wufr3pj6LGTqHCYh//QXBZs8R2YNKm/25KD9Pt8YxW956W5z/ZLeNVNXyvdeEM0wfbMkmbvoA9ik8qdsUMsYpvXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(83380400001)(316002)(478600001)(66574015)(8676002)(4326008)(31686004)(31696002)(186003)(2616005)(66946007)(8936002)(36756003)(38100700002)(52116002)(16526019)(86362001)(5660300002)(2906002)(6486002)(66476007)(66556008)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUZuS1Y3VkVvRUVJNGZmYU1GMkI3OUc5cU5UL0x2TmJQM3F4eG9HSWJqSEJE?=
 =?utf-8?B?aGVrTjhxYy90Q0tyNmk5a3R3ekVNMzN3VzgwYk5tVUtwL1huSUoreTl2dUVE?=
 =?utf-8?B?M0JPZWhsOTQyckZHU0ZRY0xRay9VWHFXMGFVTkRkVk5lTkM3NmJOcEZab1Qr?=
 =?utf-8?B?UkRWS3NtMW5BMG9Bbm0wOHBtYU9sVW5WZVk1di9sd3gwQXJhbEtreG11Nkxm?=
 =?utf-8?B?YTM2MGlDcUZPZ0RZeWZ6dzZSS05MRjhKSFo1bGdRU081dWw5UFpMNE5CYjI4?=
 =?utf-8?B?aUVPMTJMeUZvL1g4K3EzcjNIQStiNW85M2NlcWVRWHBoTkNNRHFyWGpuQkVn?=
 =?utf-8?B?VWxva1hlVlZobE5jdVRPSWg3c0krd0hGSmlqLzRsYnlpSkdSUFpzODBFRzI0?=
 =?utf-8?B?b24rN0IxN0VvR3pGU3VHNnNQUENndUloM2k2QU5QdTlUb1hZUEZBTFV4VmV4?=
 =?utf-8?B?YitJVUJQR1FSbEQ1a1BIUG5YNTJjZEt0a3JmL1lVU0hmMU03Z2tkMUhvRTZ0?=
 =?utf-8?B?Mzl2dTYxbkpVRmxKTXlhS245TGgrQmgxUjcvc2x2bHFHU2FidkwwWTFvOGhh?=
 =?utf-8?B?dE0zUk8zTkxaSkszYyszSmxtNHIwUXZNNlBoTHhwbHB3WVhqUWI4VHJmUDQy?=
 =?utf-8?B?SXZxR0Y0citWWEVlRHdMU0JHeEZhQjNsM2ZzcnljUm80aW9HOVhxTVdnQ1F2?=
 =?utf-8?B?cStZYjg0SXptdnFmNDZ1YUMxdzBVeVdtWlJUWFQ2QUJ1dXJ4TUlXVTJNNC9k?=
 =?utf-8?B?dEJLM2dKSHJtc1J1SVdWRXVUelBPNndDRmhZbDJRWDhUVzFVaFVvd0QrakIw?=
 =?utf-8?B?Q24yRWIxak56N1l6bXNLSkRqNHlXbkdlWThZUDM1M1prT3BXUTVoTnE2Qm9N?=
 =?utf-8?B?OTJBUUpybDlnaTNjcllDaVRVbExsV1hGVGZRR0t0OFhZbHJhbXFiV3BiL1o4?=
 =?utf-8?B?QmE1VitjSlRpcER5MUkybU1xRmtnWXo5UFhvcjNCQm1yZmFpZnlQc2FIVkly?=
 =?utf-8?B?d0JYcDRKS3ZUcyt6WlVpVnJJemlXZ0dsN2d2UXJEVTJYbjJZNWhFSHB4blEr?=
 =?utf-8?B?RVlEeld4VDgraHVJRmtxRzRPWTFOUHh3U3V3Z3ZoNy8xemZmTkpvcXJ0MlI5?=
 =?utf-8?B?dkZwY2ZhSjlLaUhBcytmY0x1TEh6cVN6VklQTXdLUjgwKytmVy9LZkhTVWNW?=
 =?utf-8?B?OW5kcFlXWXlkeEVqempLUlI2Y3N1Q2dkeEVobG5TcXhGbTlUVFhKeWdMeTBK?=
 =?utf-8?B?U3NmZVVRaVo2WVRVU3Nsa0FJNUlYMHlkb2FxSjNpejd0NnlOWXd1SDFieXZR?=
 =?utf-8?B?RE52Q0llcEplUzVGSmhFaFVZUnNGM3AwZkZrQktOTjFQTnZHN2JmRUlndGhm?=
 =?utf-8?B?S0hOSTRJWTg5U3BkREtYSXhSRUNIWU8zVUNTMzdpTVM3cFg5NTJNY1Bsa0N0?=
 =?utf-8?B?elhEYkliNDdGa2hONDBsNTY5K0VtZ084UjFycUdyME1DeVBTcjIwMzVVN2g3?=
 =?utf-8?B?RFlXaXZ4dVVFR0xpRXFETGdjQ0FFd2pVZGdDZkorZjhXQVpLellJczc0djhK?=
 =?utf-8?B?c1RxN0VISXIzNWlib2ttMG5Qb0VHRWZmRkl2elduQXN6N3ArOEp1S2tSNklL?=
 =?utf-8?B?RjBQMU9rWkg3Z0VWRkx3ODQ1ejkxeEZKVEQxZHBjaFVxblB6amlhN0ZDc1Jn?=
 =?utf-8?B?Y1YzRlNLaDhES0dHQy9GTkF0aUhoTGt4cG9HM3BmMEdzKzFqMUtoY3g1WEtN?=
 =?utf-8?B?aXgyMVpiakZLZUwxUGN3dXZ2TU5wR0o5SG9YZmZoUlVEbU5zTkJqSjFBampM?=
 =?utf-8?B?bUwzVzgvN1dQY0NXRktwKzlQS2lLN3kzeEsvUDJ5Y3hidThzbDkyRzd2YTQv?=
 =?utf-8?Q?Id4AYkLge500M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfde776-fe57-44da-4cb0-08d9203df583
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 12:01:13.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHtSIdQRs3csreDNWfeebywBzYafjljYeWtixPMxzPCjZwOZ8OD2BdEPQKlVp09p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4639
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjYuMDUuMjEgdW0gMTI6MTAgc2NocmllYiBOaXJtb3kgRGFzOgo+IEFkZCBuZXcgQk8gc3Vi
Y2xhc3MgdGhhdCB3aWxsIGJlIHVzZWQgYnkgYW1kZ3B1IHZtIGNvZGUuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDMyICsrKysrKysrKysrKysrKysr
KysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCB8IDEw
ICsrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+IGluZGV4IDNmODViYTgyMjJl
Zi4uNjg3MGNjMjk3YWU2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYwo+IEBAIC02OTQsNiArNjk0LDM4IEBAIGludCBhbWRncHVfYm9fY3JlYXRlX3Vz
ZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJKnVib19wdHIgPSB0b19hbWRncHVf
Ym9fdXNlcihib19wdHIpOwo+ICAgCXJldHVybiByOwo+ICAgfQo+ICsKPiArLyoqCj4gKyAqIGFt
ZGdwdV9ib19jcmVhdGVfdm0gLSBjcmVhdGUgYW4gJmFtZGdwdV9ib192bSBidWZmZXIgb2JqZWN0
Cj4gKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9iamVjdAo+ICsgKiBAYnA6IHBhcmFtZXRlcnMg
dG8gYmUgdXNlZCBmb3IgdGhlIGJ1ZmZlciBvYmplY3QKPiArICogQHZtYm9fcHRyOiBwb2ludGVy
IHRvIHRoZSBidWZmZXIgb2JqZWN0IHBvaW50ZXIKPiArICoKPiArICogQ3JlYXRlIGEgQk8gdG8g
YmUgZm9yIEdQVVZNLgo+ICsgKgo+ICsgKiBSZXR1cm5zOgo+ICsgKiAwIGZvciBzdWNjZXNzIG9y
IGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlLgo+ICsgKi8KPiArCj4gK2ludCBhbWRn
cHVfYm9fY3JlYXRlX3ZtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICsJCQlzdHJ1Y3Qg
YW1kZ3B1X2JvX3BhcmFtICpicCwKPiArCQkJc3RydWN0IGFtZGdwdV9ib192bSAqKnZtYm9fcHRy
KQo+ICt7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpib19wdHI7Cj4gKwlpbnQgcjsKPiArCj4gKwkv
KiBib19wdHJfc2l6ZSB3aWxsIGJlIGRldGVybWluZWQgYnkgdGhlIGNhbGxlciBhbmQgaXQgZGVw
ZW5kcyBvbgo+ICsJICogbnVtIG9mIGFtZGdwdV92bV9wdCBlbnRyaWVzLgo+ICsJICovCj4gKwlC
VUdfT04oYnAtPmJvX3B0cl9zaXplIDwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm9fdm0pKTsKPiAr
CXIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsIGJwLCAmYm9fcHRyKTsKPiArCWlmIChyKQo+ICsJ
CXJldHVybiByOwo+ICsKPiArCSp2bWJvX3B0ciA9IHRvX2FtZGdwdV9ib192bShib19wdHIpOwo+
ICsJcmV0dXJuIHI7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIGFtZGdwdV9ib192YWxpZGF0ZSAt
IHZhbGlkYXRlIGFuICZhbWRncHVfYm8gYnVmZmVyIG9iamVjdAo+ICAgICogQGJvOiBwb2ludGVy
IHRvIHRoZSBidWZmZXIgb2JqZWN0Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuaAo+IGluZGV4IDExNDgwYzVhMjcxNi4uYTdmYmY1ZjcwNTFlIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaAo+IEBAIC00NCw2ICs0NCw3
IEBACj4gICAjZGVmaW5lIEFNREdQVV9BTURLRkRfQ1JFQVRFX1NWTV9CTwkoMVVMTCA8PCA2MikK
PiAgIAo+ICAgI2RlZmluZSB0b19hbWRncHVfYm9fdXNlcihhYm8pIGNvbnRhaW5lcl9vZigoYWJv
KSwgc3RydWN0IGFtZGdwdV9ib191c2VyLCBibykKPiArI2RlZmluZSB0b19hbWRncHVfYm9fdm0o
YWJvKSBjb250YWluZXJfb2YoKGFibyksIHN0cnVjdCBhbWRncHVfYm9fdm0sIGJvKQo+ICAgCj4g
ICBzdHJ1Y3QgYW1kZ3B1X2JvX3BhcmFtIHsKPiAgIAl1bnNpZ25lZCBsb25nCQkJc2l6ZTsKPiBA
QCAtMTI1LDYgKzEyNiwxMiBAQCBzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgewo+ICAgCj4gICB9Owo+
ICAgCj4gK3N0cnVjdCBhbWRncHVfYm9fdm0gewo+ICsJc3RydWN0IGFtZGdwdV9ibwkJYm87Cj4g
KwlzdHJ1Y3QgYW1kZ3B1X2JvCQkqc2hhZG93Owo+ICsJc3RydWN0IGFtZGdwdV92bV9wdCAgICAg
ICAgICAgICBlbnRyaWVzW107Cj4gK307Cj4gKwo+ICAgc3RhdGljIGlubGluZSBzdHJ1Y3QgYW1k
Z3B1X2JvICp0dG1fdG9fYW1kZ3B1X2JvKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+
ICAgewo+ICAgCXJldHVybiBjb250YWluZXJfb2YodGJvLCBzdHJ1Y3QgYW1kZ3B1X2JvLCB0Ym8p
Owo+IEBAIC0yNzIsNiArMjc5LDkgQEAgaW50IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgaW50IGFtZGdwdV9ib19jcmVhdGVfdXNlcihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCSAgc3RydWN0IGFtZGdwdV9ib19wYXJh
bSAqYnAsCj4gICAJCQkgIHN0cnVjdCBhbWRncHVfYm9fdXNlciAqKnVib19wdHIpOwo+ICtpbnQg
YW1kZ3B1X2JvX2NyZWF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiArCQkJc3Ry
dWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4gKwkJCXN0cnVjdCBhbWRncHVfYm9fdm0gKip1Ym9f
cHRyKTsKPiAgIHZvaWQgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKHN0cnVjdCBhbWRncHVfYm8gKipi
bywgdTY0ICpncHVfYWRkciwKPiAgIAkJCSAgIHZvaWQgKipjcHVfYWRkcik7Cj4gICBpbnQgYW1k
Z3B1X2JvX2NyZWF0ZV9zaGFkb3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
