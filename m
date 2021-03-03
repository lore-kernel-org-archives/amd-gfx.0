Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2596FC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 11:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DF864EDF
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 11:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DF864EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D476E203;
	Wed,  3 Mar 2021 11:30:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22686E203
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 11:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6S3Hoxl5lwY56YTNCRrdOzdsVXsMiwtzw2LBulgKkRyNUFpdFScf+y+MOKuuDekv1ATNO5/mvF4dY3gBM7y26hODLnb2w9COigRrYeujzVtKnO9/2TxNX853sSIxaOHFs9zjyXenaP6ml1vcKaNHO6OmMXJV8V7YPh9JbQlV9fLxGCFmqtV/jRzrEDWHzKz2i+S6tPlVewA+Gt4ZL8BzW4g+8vAQawP+44w6JXcr4kOwiEdZYKy9YZ1+uXgEc6BPvvKrGUrpm2mqiHjhQ41QETJGVVHpkxF2FvfyKRQDf+UoeTjhLCyCjdkpGW6sE8DjizXE5QZQ1aYo2w6d0STPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbp/3kXh4zQTc8uefouSmGjazhdA+/pCRZs7tJzU1xA=;
 b=AFdyM6pY66CgLM5bZB4JUPActM9sGzVan+9DvyfAFBzxBd+mxMxm+iyHP30XHmrB69m588ANYmIEZ0k2FSn/GVuRd5wsHJ4p5B6pXdKyneGut6S8rI00xyqF93MOxH4d+eqb6GEk8sJxY+SY20o0quvux4GQwFc1N2Pejrq9GIveTSU4diUThlqZbLTa4MuVbgtFH7NFWY8DRFQESZ3g6AINFPdJqcZtZuNi0XPLXys+becD3gIu4wBpYKRtKui3y+gPLpQLoCSZ1NJkpLN1EUgk22Ss5KtRdql3Hzw+SjI09BVhiLQEnb6XvbNuoLs+IO3/md/rue4nGLCxuCGyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbp/3kXh4zQTc8uefouSmGjazhdA+/pCRZs7tJzU1xA=;
 b=TUlOOswGYp3hXE7XcsuJihsXvKe+frq3UnLvuNgAY13FbAJs1rdqGu35qldolYo88NZMq1WxKeG8X8oIzwUJRJqC+Got/iro5zJkhnAiIkMQXR0k0yQ9rrw/YHL+L091/YyLV7NyE/AUSpx/CJeq0r03MRtyoHmzS2Z00vIcO30=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 11:30:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 11:30:44 +0000
Subject: Re: [PATCH v3 0/3] Use kvmalloc_array for radeon and amdgpu CS chunks
To: Chen Li <chenli@uniontech.com>, amd-gfx@lists.freedesktop.org
References: <87v9a8lwvl.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9314f840-57db-2e2e-c186-c4a3566fdb5b@amd.com>
Date: Wed, 3 Mar 2021 12:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87v9a8lwvl.wl-chenli@uniontech.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fea4:8409:66bb:aad2]
X-ClientProxiedBy: AM4PR0101CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::52) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fea4:8409:66bb:aad2]
 (2a02:908:1252:fb60:fea4:8409:66bb:aad2) by
 AM4PR0101CA0084.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 11:30:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f12786a0-021c-4ccb-6391-08d8de37c859
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB423926680135D45D4B9FAE9083989@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOLex7yC5gHieokQeiT/pP1KxBCm3KRdUFhWbdevTk7iHUVuiYl3w0e98M91Ekmbxj7SBzJ/qOMV4yGDxh7cJU4C74BIehocWvLm75/RtDQ26dZ5X//CbcHmiV5gEwslZ7xUmogrpIV46tsorb0UzRLPBNWI6HdZ9o5optJ39x7r5OSFT2XSJVly9Wx3IqA/63gaYE2glypReTvwGBnPLLcsZPACKOLHazjpERCNK0pZB9Lpi9nOTPO62u9gLvqf3aAABCabjQOCm+HG7BqhaUWdVI6U9WR7FAX9LbaHTYAgxQ7T6NGyVR6QSrpVsKjrgnP4AyUi/6XpkWb6kuCPcHLzDJBP2MkVpVDiRbar0U9rejG5SPAMuqg5JauJ4RL+ql0vaKDHj8sUMfAvxjFJKGOa4k7rzbj65fs0/ZeIVVXVRn7oMdxt+WBjgULCi00xiQUYzBz/HdXYQaa5nT0wG1uU/EAoUYu6idiDixnzcZSdVrrBZQwaJepaDI6SZUhQTA6Jq5TARJputpIJk5RDbu1KQYr9qdVKzusLIQTuThvy6cjzOYy2KiwNQcZMkFOTNYmhznPa0hi18KAJBlLmbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(83380400001)(31696002)(66476007)(66946007)(66556008)(31686004)(66574015)(86362001)(4744005)(4326008)(5660300002)(36756003)(16526019)(316002)(8936002)(2906002)(8676002)(52116002)(2616005)(6666004)(186003)(478600001)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZElqL2xqeXFOM0NPTTFScjArNHBrbkYvaVFZSVJXbFlQVVk5Ui9SdGhpRkVi?=
 =?utf-8?B?NDdwRkx2TWlUYUdWTlJCVHZ5eTlPT0NkZkYyTXk2MTJSZ1pOU3lWVEQrSXBW?=
 =?utf-8?B?TXZ3cFVRNUtsNm9Wc2ZmL3h4Qk5aOENpeEpxS1N3cUhvWisyQSt2Z0ZHVWFx?=
 =?utf-8?B?c09NZ0VrZXpTc29HWDA1a0JyM2I4OGVnRlhjMlZrV0ZVb2VmVWNZVm1rd0U1?=
 =?utf-8?B?UzlkRk1RUnNBczNVYjI3ckx3TGpETTRhOVV3Z3pmaUpCNVlhT0JqNkdMVk9R?=
 =?utf-8?B?MmdvUGw0aEdyZ1N5R2c2OFU0NjBNMUwwdUxDOXdVblNUcFRXMXFMYzRzVXpF?=
 =?utf-8?B?WmZmTWx0djViRWNCK1NBRCtwb2pSZCtFekZnWVkzdW1HdTRvTi8xdlhhWXJ5?=
 =?utf-8?B?ZERnMlpqRlA3cDIvMFJWbHVsT3FZNm8vQ2Q2NUVYbFZhaHNZTno0dnV5aDNO?=
 =?utf-8?B?aXJ0L3JKd3Z0QnMzZDcwdHUxR0dUUjdZQ2F2eFJqdzVYdmNjTU5HOEM0anEx?=
 =?utf-8?B?enFqZVZqNW1XNTQrU2dXYnM1dzZ3ZTQwNUhhZGlCUFFlbjJDa2lBZVRRZUY1?=
 =?utf-8?B?WnNKTUtIWlZQUmJRS0hnRE00cWVIQkFSUE5Udk5YRG52QStIYk95N3R5SFhV?=
 =?utf-8?B?Z0c0dGVNWm5WcjdkV0tVNlJHMVVXYlpuZlQ4QW5JM3JkUFRZWWxSWlF0cmtM?=
 =?utf-8?B?cVVLRG9CVml1THkwbUtYT1ZOV25FVWtyY2IwL2pLR0RLa1V5bHV6ekt4Tlp0?=
 =?utf-8?B?U3BaWDdEbjhjemhkOXdmSlV4SDFoemNwK2JZSVlxaVlnaDdPWUZrSUR6MG52?=
 =?utf-8?B?NE11K2NZdVFRczljZEN5V3VRZXpNZ1RtQkJQL2VtSHNrSlQ4WWVLbEdIaVZB?=
 =?utf-8?B?d01OcUlqYVdRd3d5K3RXV3FISTJyU2JPTVNBS0ZOSXN6eU1tbnAyMlUvdldC?=
 =?utf-8?B?Kzl5SUlVR05raVlyaFZWV1JnVTlwakQrdnZPN1RkMnRBUDJwRzBpMUt1MTA2?=
 =?utf-8?B?SEJudkorb3lvMjZLTXZDa2xyR05HN1BWbGJ4V0d6MW0wUFVJMlRzMXJNcW1K?=
 =?utf-8?B?QzQwT0ltSkJzQWlKekplQk0zdWs0ay90UXI0OEV0b25wYnhwa2pVeVM0cm1I?=
 =?utf-8?B?ZCtnZ3lTbFBLN2FhdVdDSzdCdGxuRDZBNDlhVm1pWW4rL0NEWW10WGFBbGZO?=
 =?utf-8?B?ZFpQbEJYYTEzdytiSGNTbHFSUnNUcXUyWThRY29jZE9WQ1NUY1JKekZ4d1JN?=
 =?utf-8?B?WGFyanFCSmRNNlF0c3VORW9JY0YyYjBoMmJkY0FTam9TNXVkZ1M5L1JlMHBO?=
 =?utf-8?B?OWJkS29neGRWa1JwKzRhVjBaN0RoK3BnNkY2Yk5ZOVJOTjBtMC9oYWk5b1Iy?=
 =?utf-8?B?ejNWRDA3a0llWEJuUzF3WEttd0l6bk4xbmNQS29reWV1cVNlOE9GMW1JVklB?=
 =?utf-8?B?emhkVDVFVm4xR3p3Mitnc3l5c0h2WlA1bXFRRXErM0kyYWxMNkxOZ2gzTUt0?=
 =?utf-8?B?RGlCQkpEaGFDZlpXVUlya2t0UWJ0NjNxTTlYQ21rbkIxaUc4akJLZlBCUWFp?=
 =?utf-8?B?WmpENGI3cjdJdEpWYjk5bW51Y1JTQXh4THBrQXVlS2Y4blVKYWRHemprdlor?=
 =?utf-8?B?b1U0YSs5T1JIQnBMbFd4NTZsZkFXUlJQWXg5OEVCWVdZL0E0TDlPVlpEQ2lV?=
 =?utf-8?B?U0swdGFRYjBFQktFdy8rOUtLM2hHeDJiRysvOVZqLzRqYmFQQ2YzU2hYOHZJ?=
 =?utf-8?B?bGtqVTJhVk5xRG1FTlBMQ3pLYzhRTE1xdlZwL1ppVmFTYVlpN005SUdPbk53?=
 =?utf-8?B?V0xkQll0TXRtSW9ERzdEUTlEOUtVWk1PQWd6VU5FMVA4eDhwUW0yQU5BTFBy?=
 =?utf-8?Q?KKCiiLeYgF2O1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12786a0-021c-4ccb-6391-08d8de37c859
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 11:30:44.0932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: us4Ux7iOGlAXkhEEX2x6vqgm6WCc0U/OFyCopMxHkgUhKIdnoUcEq59WpK6qeoWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4g
Zm9yIHRoZSBlbnRpcmUgCnNlcmllcy4KCkFtIDAzLjAzLjIxIHVtIDA0OjQ5IHNjaHJpZWIgQ2hl
biBMaToKPiBXaGVuIHRlc3Rpbmcga2VybmVsIHdpdGggdHJpbml0eSwgdGhlIGtlcm5lbCB0dXJu
ZWQgdG8gdGFpbnRlZCBpbiB0aGF0IHJhZGVvbiBDUyByZXF1aXJlIGxhcmdlIG1lbW9yeSBhbmQg
b3JkZXIgaXMgb3ZlciBNQVhfT1JERVIuCj4KPiBrdm1hbGxvYy9rdm1hbGxvY19hcnJheSBzaG91
bGQgYmUgdXNlZCBoZXJlIGluIHRoYXQgaXQgd2lsbCBmYWxsYmFjayB0byB2bWFsbG9jIGlmIG5l
Y2Vzc2FyeS4KPgo+IENoZW4gTGkgKDMpOgo+ICAgIGRybS9yYWRlb246IFVzZSBrdm1hbGxvYyBm
b3IgQ1MgY2h1bmtzCj4gICAgZHJtL2FtZGdwdTogVXNlIGt2bWFsbG9jIGZvciBDUyBjaHVua3MK
PiAgICBkcm0vYW1kZ3B1OiBjb3JyZWN0IERSTV9FUlJPUiBmb3Iga3ZtYWxsb2NfYXJyYXkKPgo+
IENoYW5nZWxvZzoKPiAgICB2MS0+djI6Cj4gICAgICAqIGFsc28gdXNlIGt2bWFsbG9jIGluIGFt
ZGdwdQo+ICAgICAgKiBmaXggYSBEUk1fRVJST1IgbWVzc2FnZSBmb3Iga3ZtYWxsb2NfYXJyYXku
Cj4gICAgdjItPnYzOgo+ICAgICAgKiBhZGQgbWlzc2luZyBrdmZyZWUgZm9yIGFtZGdwdSBDUwo+
Cj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDE0ICsrKysrKyst
LS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9jcy5jICAgICB8ICA4ICsr
KystLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQo+Cj4gLS0KPiAyLjMwLjAKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
