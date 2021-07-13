Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE3C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 16:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7410A611AB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 16:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7410A611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3222F6E0E6;
	Tue, 13 Jul 2021 16:11:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0CD899BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 16:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYsXW2Ygf6CMCM2hqAsCiu55PWNwW+fd/9VZteU1smxJqvPQDnswbxTcuEVuRxXngk7pyZeOsc0Qpikhbah9Wy+QOAp64oCmYNCH+WvLf18MVnPGNLJrl2qP9QLyzZCwo4BOoGNQlsHycb5xbPlu+xUZhnLj6TjANnsAd0f0nDZxFaa2Yz7fXmRkCY3xJCXj4InmR6/ltTORktM2vvD/GfQi7hwe1F9A/OZVv44rnMr6nd9GfeH0ITcr0SLfu/BrbcugBd2YqMOdMYfjgHfwnT+UhApCiY01hbTmAW9aEjv2kbCpOC+jEwD62JUSsOmxcUgvlCVlC5JSU9eSgbB2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/VwVCz4NOGkwLBwH1NmcN/AgeTYc6nXMvbjORGW6iE=;
 b=QVV/IHfRJFwWVhoU3GRDyioy0QmTTf8y8h2iyIOfAA6xuZZ845WG+O4jgN3qc93rW1uLj/RCM7OwsodkQ2TBqAgXbJTf95ui7Za2/yDUjkX8mNH5B/OGhUMfkv0EHeGN4uyILNgHwcdNI9fQw28RWZ9heLDmUtxUJtt6tY6avzkTYoIfSkBVD8pZTO3ty0Cie/UfJ3r81EvdxHklkDpld11JndG4OmF0YyVOqerXbrCgpw3tvV+2DBdpSYncNl/NVRRNcuvOccM/9+WfjYZXzb4lX5gNT2DC2hOrGBeNdiHlxoacM62/U6K51sEJkKoc8694BgCy1tot5s8w86m1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/VwVCz4NOGkwLBwH1NmcN/AgeTYc6nXMvbjORGW6iE=;
 b=R7ciX1hNWEIRrj3HMGNc/VO9JmDXDIJ6BALXbcF0ORBChQteBJrg/NEhCdJI9cKyMwaI9YQs5oaIqHgWm+sh29U23jukiP+ZvdPYDmazcRzkXR4rZunq6Wypg0+gDX7DOSJgIMge/THmlmKex/+ilWOHkaPZ8qtQ9vyczTrSl3s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 16:11:25 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 16:11:25 +0000
Subject: Re: [PATCH] drm/amdgpu: further lower VRAM allocation overhead
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 jinhuieric.huang@amd.com
References: <20210713133255.16456-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1bd98b6c-ba8e-de16-9e6a-2c4ab6ab01cf@amd.com>
Date: Tue, 13 Jul 2021 12:11:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210713133255.16456-1-christian.koenig@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 16:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f185830-7d8c-48b4-4f57-08d94618dceb
X-MS-TrafficTypeDiagnostic: BN9PR12MB5180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5180BD2A437C2C7CF004D02392149@BN9PR12MB5180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxxohkZOmQK8Ub+6ULJRw/aLf9FjFR+mZxYKMS0itMZWOeha4ZFGFkOK55CHXCz6K4SOwkoBvj1avtSxyR4etsdKXVKNb7eMMM+/8opsFPajEV0PYxJ4nwInh9JJnYl6JDhsdnODJ8sQCzsQDGJsuoBUjBGOqnX637Sro4xbL6TOGJAWyiw5QA8zeBh5kCSEahjarJIGO0RL2NUHRgk6wGgg2imRLSN1nEIHEnsknf2WguMxBRvZqTFimhEOThz0O1BwlhtbdtWYewTbaIYRPE6hhLqdhUILoWqALKxdY4oPU0eYdplRMLAqdhEcoKDqRwq2zarFr2k+hnXA7Nj4gZr0nFEYjgP84FfM52Huv1DPHAk7vt/+KXXHoOkkyKF2qiBHzfbH3O0OFd6jo1/IiSsnXQZm1Iq24Zcw6z4s9arPSxLCUYFa4XKiBhxF0HojZAAeR4pCFQI0fdhS26yIC/iP4I28G1MUfr283dH0slHu6osWdVcU3Ug0e4aInjZeSH+Y5FW5C1pOVtvyjYl71fiZhDXuOOa+IUSz/7Cbk6ZjnMwa7IGHi/kAuBDK/sfT+Mk3PdJUbAVl8RXxOPPZtZBuqc5qtLH/yFoBS98QDrVMmslqDZ5TjM55JLJOkVhH6iDfvb4vURSz3SyX8fs6io3NgMNX5oREoEUQNZ9B97OcV5WeIO3T3+JifhXBE+GFceE6+ESR/X9jSiePST/4phUioMuaBjaLGtYBLBdhXfwGmwZCSMXGAhmL0hYvIy8D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(956004)(2906002)(38100700002)(8936002)(2616005)(44832011)(36756003)(16576012)(26005)(8676002)(316002)(6486002)(66946007)(4326008)(86362001)(478600001)(66476007)(31686004)(83380400001)(6636002)(66574015)(186003)(5660300002)(31696002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZFRTVDSG9yTzNlbUxrbHcrZGpEZVZSelFoU3phS2tNY05rWnpRelVweFds?=
 =?utf-8?B?REJzTWJneHE5dENxelE0RHpmTno3dzNEMlhnem1SdGhDNDIzNjJSREhZaS90?=
 =?utf-8?B?cDFsbjVXOXpZZ201d2FVajJaUEtjQ3FNVHhMUkZvUlkxZkxxeml0YTJvVUlr?=
 =?utf-8?B?UmQ0ZlhUbDNVTlY2RDdmODk4TjhybGYvRXR4YWJrcEFIVmV4SFFheWkrV2xt?=
 =?utf-8?B?TnIraHF3Nld6UmZBWXpTZVFFMk9CTEExeVpMeDVESDRZYU1lMS9KVDJQT3My?=
 =?utf-8?B?RjNENWNSeG44NjB6MWlqcitGTHg3ZWVXMjVNQ1Y5d29QRDB6UWxndzFEOHFq?=
 =?utf-8?B?amFLeGxSM216eFBRS0ZQdG1SRklGT1lzM01mZmRhMDRlbUc3RE5iSzhkRk4x?=
 =?utf-8?B?MnBFK0JJdEZMUFpjaXhVMFpYOVdWdndaRHFzeSs2OERiVWIrZjVkMHlqK01P?=
 =?utf-8?B?d1V4YkxWbkoyZEJ3dnVDbFp1RG9TcVhVQlpRVWg2ZHd3UDRab2lESXpEWnFL?=
 =?utf-8?B?cmpBS1VFVE5GUE1NYXBZMnhzSmYxbThSaXlyQTcrYnZyZEFUWXFFYkVWTFdn?=
 =?utf-8?B?OTcxZGJTck5sUFdFeWRwcFViM2doZzhWZVJ6aTg2ODIxQitlTExKUTBVWE8y?=
 =?utf-8?B?UkFsUkxCR05ZdDU2dEdOQkFoamU2TlpHdk9IeGhoOUtvOFZOSlAxZ3FLNVYw?=
 =?utf-8?B?bFRGYzJCd3ZJNnVRZlZTb0F4RzlicEtiU2JiM2QrZHkrVFE1Y3MxaTZuLzBT?=
 =?utf-8?B?TU5OZUM2V2srdDRrcmdHdjlJRXlHbDRYaTF5b2pQYmJIdFpTNUI0UUlpc3lt?=
 =?utf-8?B?QTEzb3JMT1FNamkyQkRMOFNIRTZJS09qM29SdnppRENJeElFU0ZzRjAzOThp?=
 =?utf-8?B?LytnUXFMM1FnbXArNndrV2kzd3NGY0J6TnZ4NExDa0lNaytjWTJjOHhDbFVE?=
 =?utf-8?B?WmNsMTZtZVZRY0E0TStIMDVybDNJN1U1L1MwZWw3QkVlOHNsbUVFbHN5ekli?=
 =?utf-8?B?TXMyVHdrdnlER3JHRCtlZlNDcXA2eE1UdUhTVjltRmtKMHU3bkRqK3A4dTNQ?=
 =?utf-8?B?TVhwMGJJWDNMOGlqQWF5a1E2U1hoMXowS3Jkc2hjWVZMWUVrVkhKOXlwRS9O?=
 =?utf-8?B?eTdYNnhHSWQ5bzg2Y1REQXJhNTVWbGxQZGx6Znlramo3ckZoUkdCLzcvRWhP?=
 =?utf-8?B?RU0yL1NVaStYZmxqdDMwb0tXNXUyOWRHem42d1JGeTBXNzltUzMvMXBva0ZF?=
 =?utf-8?B?R2hmdHBrcTQ0Z0wwVy9jMUt1UWgyVGRTY0FmWXlDYTNwNHRYbVVuakc3cWht?=
 =?utf-8?B?aE9rTEkyZGRJYUZNMm8rdTRqZTgvUjBoQnpCcWJ0QkNHeStqcDBoT01mZWNK?=
 =?utf-8?B?bWxvTW9hb0s0NFJ1K2hTVGllN1ZrMnI2eE1Fd0dQejNhQXBUK0FjRUwzUllh?=
 =?utf-8?B?N0hxQnNWcU5vRzhIYmcvRUlvUHRnVUVxelhUS0FxbDVhQmE2WnNPYjZuK2wx?=
 =?utf-8?B?TkNoa1Y0eFVWNFZLQThSbGZoLzNFV1FuT0RVT1Vid21udTZML0VwRG9FV3pL?=
 =?utf-8?B?Y3FEK2t5UlEraUJoYSt2OHJCS0hVeHBQcFpXRExJajVFYVlUUXFHMGROTGM4?=
 =?utf-8?B?VElvSko5UkJPeTFTb3BmTlZRNis3UjZFWGNneXgxQ2NwT1Y3VzNEaFI5eXVC?=
 =?utf-8?B?TnQrNVljUFNmRTZQelpsKzM5ZzlMdlVNMkRzR3hJQWM0OGZkc2x4enRWejF6?=
 =?utf-8?Q?Z46/375NL6f6cmXYa1eUCZclKPWDbdrx+A5NOmy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f185830-7d8c-48b4-4f57-08d94618dceb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 16:11:25.0816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvKfNNPsVJugEMd+hDebyoQD9W6UGzhwesH0+iMoB0QRZi7mfHvOgJcN7PkmfWlE2k8ytx5DX+tFR+Ky8BCiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
Cc: amd-gfx@lists.freedesktop.org, Luugi.Marsan@amd.com, Jenny-Jing.Liu@amd.com,
 Chris.Mason@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNy0xMyB1bSA5OjMyIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEZv
ciBhbGxvY2F0aW9ucyBsYXJnZXIgdGhhbiA0OE1pQiB3ZSBuZWVkIG1vcmUgdGhhbiBhIHBhZ2Ug
Zm9yIHRoZQo+IGhvdXNla2VlcGluZyBpbiB0aGUgd29yc3QgY2FzZSByZXN1bHRpbmcgaW4gdGhl
IHVzdWFsIHZtYWxsb2Mgb3ZlcmhlYWQuCj4KPiBUcnkgdG8gYXZvaWQgdGhpcyBieSBhc3N1bWlu
ZyB0aGUgZ29vZCBjYXNlIGFuZCBvbmx5IGZhbGxpbmcgYmFjayB0byB0aGUKPiB3b3JzdCBjYXNl
IGlmIHRoaXMgZGlkbid0IHdvcmtlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgfCA4MCArKysrKysrKysrKysrKystLS0tLQo+ICAx
IGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+IGluZGV4IDJmZDc3
YzM2YTFmZi4uYWI4YzVlMjhkZjdiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92cmFtX21nci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPiBAQCAtMzYxLDE5ICszNjEsMjMgQEAgc3RhdGljIHZvaWQg
YW1kZ3B1X3ZyYW1fbWdyX3ZpcnRfc3RhcnQoc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtLAo+ICAg
KiBAbWFuOiBUVE0gbWVtb3J5IHR5cGUgbWFuYWdlcgo+ICAgKiBAdGJvOiBUVE0gQk8gd2UgbmVl
ZCB0aGlzIHJhbmdlIGZvcgo+ICAgKiBAcGxhY2U6IHBsYWNlbWVudCBmbGFncyBhbmQgcmVzdHJp
Y3Rpb25zCj4gLSAqIEBtZW06IHRoZSByZXN1bHRpbmcgbWVtIG9iamVjdAo+ICsgKiBAbnVtX25v
ZGVzOiBudW1iZXIgb2YgcGFnZSBub2RlcyB0byB1c2UuCj4gKyAqIEBwYWdlc19wZXJfbm9kZTog
bnVtYmVyIG9mIHBhZ2VzIHBlciBub2RlIHRvIHVzZS4KPiArICogQHJlczogdGhlIHJlc3VsdGlu
ZyBtZW0gb2JqZWN0Cj4gICAqCj4gICAqIEFsbG9jYXRlIFZSQU0gZm9yIHRoZSBnaXZlbiBCTy4K
PiAgICovCj4gIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291
cmNlX21hbmFnZXIgKm1hbiwKPiAgCQkJICAgICAgIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAq
dGJvLAo+ICAJCQkgICAgICAgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSAqcGxhY2UsCj4gKwkJCSAg
ICAgICB1bnNpZ25lZCBsb25nIG51bV9ub2RlcywKPiArCQkJICAgICAgIHVuc2lnbmVkIGxvbmcg
cGFnZXNfcGVyX25vZGUsCj4gIAkJCSAgICAgICBzdHJ1Y3QgdHRtX3Jlc291cmNlICoqcmVzKQo+
ICB7Cj4gLQl1bnNpZ25lZCBsb25nIGxwZm4sIG51bV9ub2RlcywgcGFnZXNfcGVyX25vZGUsIHBh
Z2VzX2xlZnQsIHBhZ2VzOwo+ICAJc3RydWN0IGFtZGdwdV92cmFtX21nciAqbWdyID0gdG9fdnJh
bV9tZ3IobWFuKTsKPiAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gdG9fYW1kZ3B1X2Rl
dmljZShtZ3IpOwo+ICAJdWludDY0X3QgdmlzX3VzYWdlID0gMCwgbWVtX2J5dGVzLCBtYXhfYnl0
ZXM7Cj4gKwl1bnNpZ25lZCBsb25nIGxwZm4sIHBhZ2VzX2xlZnQsIHBhZ2VzOwo+ICAJc3RydWN0
IHR0bV9yYW5nZV9tZ3Jfbm9kZSAqbm9kZTsKPiAgCXN0cnVjdCBkcm1fbW0gKm1tID0gJm1nci0+
bW07Cj4gIAllbnVtIGRybV9tbV9pbnNlcnRfbW9kZSBtb2RlOwo+IEBAIC0zOTUsMjEgKzM5OSw2
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21h
bmFnZXIgKm1hbiwKPiAgCQlnb3RvIGVycm9yX3N1YjsKPiAgCX0KPiAgCj4gLQlpZiAocGxhY2Ut
PmZsYWdzICYgVFRNX1BMX0ZMQUdfQ09OVElHVU9VUykgewo+IC0JCXBhZ2VzX3Blcl9ub2RlID0g
fjB1bDsKPiAtCQludW1fbm9kZXMgPSAxOwo+IC0JfSBlbHNlIHsKPiAtI2lmZGVmIENPTkZJR19U
UkFOU1BBUkVOVF9IVUdFUEFHRQo+IC0JCXBhZ2VzX3Blcl9ub2RlID0gSFBBR0VfUE1EX05SOwo+
IC0jZWxzZQo+IC0JCS8qIGRlZmF1bHQgdG8gMk1CICovCj4gLQkJcGFnZXNfcGVyX25vZGUgPSAy
VUwgPDwgKDIwVUwgLSBQQUdFX1NISUZUKTsKPiAtI2VuZGlmCj4gLQkJcGFnZXNfcGVyX25vZGUg
PSBtYXhfdCh1aW50MzJfdCwgcGFnZXNfcGVyX25vZGUsCj4gLQkJCQkgICAgICAgdGJvLT5wYWdl
X2FsaWdubWVudCk7Cj4gLQkJbnVtX25vZGVzID0gRElWX1JPVU5EX1VQX1VMTChQRk5fVVAobWVt
X2J5dGVzKSwgcGFnZXNfcGVyX25vZGUpOwo+IC0JfQo+IC0KPiAgCW5vZGUgPSBrdm1hbGxvYyhz
dHJ1Y3Rfc2l6ZShub2RlLCBtbV9ub2RlcywgbnVtX25vZGVzKSwKPiAgCQkJR0ZQX0tFUk5FTCB8
IF9fR0ZQX1pFUk8pOwo+ICAJaWYgKCFub2RlKSB7Cj4gQEAgLTQzMSwxMCArNDIwLDE1IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3ZyYW1fbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIg
Km1hbiwKPiAgCWkgPSAwOwo+ICAJc3Bpbl9sb2NrKCZtZ3ItPmxvY2spOwo+ICAJd2hpbGUgKHBh
Z2VzX2xlZnQpIHsKPiAtCQl1aW50MzJfdCBhbGlnbm1lbnQgPSB0Ym8tPnBhZ2VfYWxpZ25tZW50
Owo+ICsJCXVuc2lnbmVkIGxvbmcgYWxpZ25tZW50ID0gdGJvLT5wYWdlX2FsaWdubWVudDsKPiAr
Cj4gKwkJaWYgKGkgPj0gbnVtX25vZGVzKSB7Cj4gKwkJCXIgPSAtRTJCSUc7Cj4gKwkJCWdvdG8g
ZXJyb3JfZnJlZTsKPiArCQl9Cj4gIAo+ICAJCWlmIChwYWdlcyA+PSBwYWdlc19wZXJfbm9kZSkK
PiAtCQkJYWxpZ25tZW50ID0gcGFnZXNfcGVyX25vZGU7Cj4gKwkJCWFsaWdubWVudCA9IG1heChh
bGlnbm1lbnQsIHBhZ2VzX3Blcl9ub2RlKTsKCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGlzIGNoYW5n
ZS4gSXMgdGhpcyBhbiB1bnJlbGF0ZWQgZml4PyBwYWdlc19wZXJfbm9kZQppcyBhbHJlYWR5IGJ1
bXBlZCB1cCB0byB0Ym8tPnBhZ2VfYWxpZ25tZW50IGluIGFtZGdwdV92cmFtX21ncl9hbGxvYy4g
U28KdGhpcyAibWF4IiBvcGVyYXRpb24gaGVyZSBzZWVtcyByZWR1bmRhbnQuCgpPdGhlciB0aGFu
IHRoYXQsIHRoZSBwYXRjaCBpcwoKUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPgoKQEppbkh1aUVyaWMsIGNhbiB5b3UgY29uZmlybSB0aGUgcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnQ/CgpUaGFua3MsCsKgIEZlbGl4CgoKPiAgCj4gIAkJciA9IGRybV9t
bV9pbnNlcnRfbm9kZV9pbl9yYW5nZShtbSwgJm5vZGUtPm1tX25vZGVzW2ldLCBwYWdlcywKPiAg
CQkJCQkJYWxpZ25tZW50LCAwLCBwbGFjZS0+ZnBmbiwKPiBAQCAtNDgzLDYgKzQ3Nyw1MiBAQCBz
dGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9uZXcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2Vy
ICptYW4sCj4gIAlyZXR1cm4gcjsKPiAgfQo+ICAKPiArLyoqCj4gKyAqIGFtZGdwdV92cmFtX21n
cl9hbGxvYyAtIGFsbG9jYXRlIG5ldyByYW5nZQo+ICsgKgo+ICsgKiBAbWFuOiBUVE0gbWVtb3J5
IHR5cGUgbWFuYWdlcgo+ICsgKiBAdGJvOiBUVE0gQk8gd2UgbmVlZCB0aGlzIHJhbmdlIGZvcgo+
ICsgKiBAcGxhY2U6IHBsYWNlbWVudCBmbGFncyBhbmQgcmVzdHJpY3Rpb25zCj4gKyAqIEByZXM6
IHRoZSByZXN1bHRpbmcgbWVtIG9iamVjdAo+ICsgKgo+ICsgKiBBbGxvY2F0ZSBWUkFNIGZvciB0
aGUgZ2l2ZW4gQk8uCj4gKyAqLwo+ICtzdGF0aWMgaW50IGFtZGdwdV92cmFtX21ncl9hbGxvYyhz
dHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKPiArCQkJCSBzdHJ1Y3QgdHRtX2J1ZmZl
cl9vYmplY3QgKnRibywKPiArCQkJCSBjb25zdCBzdHJ1Y3QgdHRtX3BsYWNlICpwbGFjZSwKPiAr
CQkJCSBzdHJ1Y3QgdHRtX3Jlc291cmNlICoqcmVzKQo+ICt7Cj4gKwl1bnNpZ25lZCBsb25nIG51
bV9ub2RlcywgcGFnZXNfcGVyX25vZGU7Cj4gKwlzdHJ1Y3QgdHRtX3JhbmdlX21ncl9ub2RlICpu
b2RlOwo+ICsJaW50IHI7Cj4gKwo+ICsJaWYgKHBsYWNlLT5mbGFncyAmIFRUTV9QTF9GTEFHX0NP
TlRJR1VPVVMpCj4gKwkJcmV0dXJuIGFtZGdwdV92cmFtX21ncl9uZXcobWFuLCB0Ym8sIHBsYWNl
LCAxLCB+MHVsLCByZXMpOwo+ICsKPiArI2lmZGVmIENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFH
RQo+ICsJcGFnZXNfcGVyX25vZGUgPSBIUEFHRV9QTURfTlI7Cj4gKyNlbHNlCj4gKwkvKiBkZWZh
dWx0IHRvIDJNQiAqLwo+ICsJcGFnZXNfcGVyX25vZGUgPSAyVUwgPDwgKDIwVUwgLSBQQUdFX1NI
SUZUKTsKPiArI2VuZGlmCj4gKwlwYWdlc19wZXJfbm9kZSA9IG1heF90KHVpbnQzMl90LCBwYWdl
c19wZXJfbm9kZSwgdGJvLT5wYWdlX2FsaWdubWVudCk7Cj4gKwludW1fbm9kZXMgPSBESVZfUk9V
TkRfVVBfVUxMKFBGTl9VUCh0Ym8tPmJhc2Uuc2l6ZSksIHBhZ2VzX3Blcl9ub2RlKTsKPiArCj4g
KwlpZiAoc3RydWN0X3NpemUobm9kZSwgbW1fbm9kZXMsIG51bV9ub2RlcykgPiBQQUdFX1NJWkUp
IHsKPiArCQlzaXplX3Qgc2l6ZSA9IFBBR0VfU0laRTsKPiArCj4gKwkJc2l6ZSAtPSBzaXplb2Yo
c3RydWN0IHR0bV9yYW5nZV9tZ3Jfbm9kZSk7Cj4gKwkJc2l6ZSAvPSBzaXplb2Yoc3RydWN0IGRy
bV9tbV9ub2RlKTsKPiArCQlyID0gYW1kZ3B1X3ZyYW1fbWdyX25ldyhtYW4sIHRibywgcGxhY2Us
IHNpemUsIHBhZ2VzX3Blcl9ub2RlLAo+ICsJCQkJCXJlcyk7Cj4gKwkJaWYgKHIgIT0gLUUyQklH
KQo+ICsJCQlyZXR1cm4gcjsKPiArCX0KPiArCj4gKwlyZXR1cm4gYW1kZ3B1X3ZyYW1fbWdyX25l
dyhtYW4sIHRibywgcGxhY2UsIG51bV9ub2RlcywgcGFnZXNfcGVyX25vZGUsCj4gKwkJCQkgICBy
ZXMpOwo+ICt9Cj4gKwo+ICAvKioKPiAgICogYW1kZ3B1X3ZyYW1fbWdyX2RlbCAtIGZyZWUgcmFu
Z2VzCj4gICAqCj4gQEAgLTY4MCw3ICs3MjAsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdnJhbV9t
Z3JfZGVidWcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCj4gIH0KPiAgCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXJfZnVuYyBhbWRncHVfdnJhbV9t
Z3JfZnVuYyA9IHsKPiAtCS5hbGxvYwk9IGFtZGdwdV92cmFtX21ncl9uZXcsCj4gKwkuYWxsb2MJ
PSBhbWRncHVfdnJhbV9tZ3JfYWxsb2MsCj4gIAkuZnJlZQk9IGFtZGdwdV92cmFtX21ncl9kZWws
Cj4gIAkuZGVidWcJPSBhbWRncHVfdnJhbV9tZ3JfZGVidWcKPiAgfTsKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
