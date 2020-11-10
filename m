Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D3DC388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 11:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6DF20678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 11:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xnhf3rJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6DF20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A13899FF;
	Tue, 10 Nov 2020 11:54:08 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700085.outbound.protection.outlook.com [40.107.70.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9898D899FF
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdW1T+5EycjXmskIQFrQBvzxCo7Qr4BGOkuSRvDaR+pLOyhJyX/4pSjTWecKSrXmCUzaDYGKpYX+ziJ+DzlO12iwvItUQaiodhoLlx0joget8e5f5wEScHObh7f+bz4GolltO3qxzZ+pii2l1nwQBOPRAN1wTL4/kzB5m6YwHf3F3B1a9jrym1xH1muzzkcliz4jxz2iJGlgx1zUZB7JyWVe0dgdzB2VOmQz2hId5R/MCNTVSN5W+iPaMOg/wDYXesgOjZUXaPMHV2kuqpTcfRR7nu5aCAk2Bvm+Pm5zh65BOjYbSTMTHjyDSGZ3Rv14gi8EzooZThGwRHJbrXEPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImCCGOn7E9UvxaustwEWibULN2QYs27dn3wO8d3zO4Y=;
 b=Uf5pUH/Bf9lenSZKohfpzaMIAtjpTuHEkIZXYCTXrbRSTiNfi/tjDcFjryMomh3JwXrLzPI+b3ENjyZkVOyF1j3OWHx6EwuZOV57t1IDOym/T2X4Q6WqM+HAOAEmbVTBFYP0nUpCiEwr7dJn7lahy/jgmSRunDftNypxwhaVynx0NSXaEf9ANuGD5KE14S+JhpXuxI1VfrxVmLQe/lW87rHdhNPSIMR8ax3t6d7LUQ+pwU/qZUouOKXk1rHRNWhLc0zvtNLXyTEmBqMGv6ADFzDGHyBEMySmfGF/EBKDwbJyFrDYr40C01X+/RvZAyxGizn8ZjmgPsQywCtgPzvvSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImCCGOn7E9UvxaustwEWibULN2QYs27dn3wO8d3zO4Y=;
 b=xnhf3rJwnh2j18iWrOn06v091vL9c/N6Q+fljV5NcNqmr515vULvi2HjayBMr1iJgS06eFAYXSm67EGV7RFTzabMdtAyqk5Lz8DQ0FAWp9Ag1gI8fZXnZQtWyT078AeCJawT9Z0tqhm9J+r/HxwkJyBqk/Rvx70oJltWaEsaiqE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 11:54:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 11:54:06 +0000
Subject: Re: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201110032033.26249-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b2d58865-9ae8-cadc-959f-3746dbea1faf@amd.com>
Date: Tue, 10 Nov 2020 12:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201110032033.26249-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR06CA0081.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR06CA0081.eurprd06.prod.outlook.com (2603:10a6:208:fa::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 11:54:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b16be72e-1d02-49e1-8c0d-08d8856f536c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047C95D2F1162FE57E0A1E783E90@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFLog/d5zyF4x/Tg9jDKRzrQecOrJZXsVO8lcslkaW3CJ/pU1k5GROSulTjZI3h4V7/z7+ApkKDaxyMaWXKw3N6iVsaiCDjNdQosuAj7kBtLSwqIgUt4S7Y9DD+Ph8UxelYhY6W6byh9To8LHXHZA9lKfvXEgd9JymYEKBdHEU6TvWneCOqhYZordq3Y6eSK3Qq/XOziFXCeFCSUNZrh3PQ6sOQqFckriU6hQXbEqR9fbCOFDp9Wtnd2n7Rn1q/NQc45HLrrW2QaijKWDWZU4p2vMifMQzBDsVeYckHA3fGJoqxbnDcLlxtQ/LXPZ4epT2JwzVsR0tX0lidtsY0Ldi8rbvVLadZYDElTbl7supwLzRgOpLUJp65UOjcA8LDl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(4326008)(316002)(66476007)(5660300002)(16526019)(31686004)(66946007)(8936002)(52116002)(66574015)(478600001)(31696002)(2906002)(86362001)(66556008)(36756003)(6486002)(83380400001)(8676002)(2616005)(186003)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q1VCTVE3eC9KKzRyTVFGRUkyYzExMGxYbnlFRkFHU01lUDBjS3E1THZQM2hm?=
 =?utf-8?B?WDRna0gveXFzeEhnemZmMXBLaTJtN1QybGEyVlFZWDUyalZVcUxORCtMRE05?=
 =?utf-8?B?V21HYlFmSmE1R0x0UUhYUzhRU2hjQ1JXTW9TZkhnTDZSM01CSmxrbnlyanBu?=
 =?utf-8?B?TGJkMzc2OFloTVNsRFBhM09kMmx6MkhNNGNTcUYwZ1ZkcW9qazd6OURxTkVP?=
 =?utf-8?B?Y2ZMQjJyNm1lMDNqUDVOeGRXYkoyMkN3TnhTeHNlQjI3blBxUU03aGQ5VTRp?=
 =?utf-8?B?MVFuWERJSnY4bkZydklCbzgwZ096Tnlaemo1K0E2UStIdU1PNjZ2b1dzSm9N?=
 =?utf-8?B?emlPd0YxY0kwV3hGc1poOEdrdGUzWnhSUlRLMlc0VjJGSlZodVZYSUk5NXMw?=
 =?utf-8?B?VDZpdHR1U3B4bmtNUUhKWTlFSnVkSVhaWW5ta2daV00xSGlSMEswQVM5Vk1D?=
 =?utf-8?B?akI1VktSVXV6R2dub1hHSGFkRFcyKzZFbit2MDVOekg5ZVJyWDZXUGtDTGJ3?=
 =?utf-8?B?SjZpT1lxcGRSbGxrWGU4Ri90UmtReksxRjFaY0pxQURRb0UySlhvWVIyWjVr?=
 =?utf-8?B?WmcwVkQ4KzZIUkRXQUdPR2syWkJ6aFFoMmJxYmRFWm5XeGluTTd4OFljdVpB?=
 =?utf-8?B?SHBLQ2xIY0FUTi9QYkpIbXYwWmYrdUtqd1Vuckl2LzJhR2RveUxZUzU5UExi?=
 =?utf-8?B?YUgvK0JmZGZXY3BSS2hBOWF1N1pMcGhjYnN0bGhPdU1JRStXS1BrdHBUd3k5?=
 =?utf-8?B?V29FbE14V0VhQS9TUmVlUmJIdVJubDVMdmQyNngvYWRFY0xOUTY2M1VzQTNv?=
 =?utf-8?B?N3NWeGpIUnk4a1NwU2ZzejBXUGlIYTVLVU5QR3dJLzc5S1F0TElEWUZRYWJ1?=
 =?utf-8?B?WWo3U1U4d0QrL0FDZkJ2STVqZnVUYkt4cGpmSzRrNnMyRC9jVlRhZHgzejIr?=
 =?utf-8?B?SjlzZnRLc1BuaHNtNFZaVlpSdVRHNk01dEc3bDh1L1ZYVmJ0SElvYVk2RDln?=
 =?utf-8?B?L05nOTBxN3lRcHJNY3ZlOU9JZ0JlRWhIaDM5cWY2d2lHdE5DWHN3djhOTE11?=
 =?utf-8?B?NG5nREYrYXJnZlczcWR2YWp5aUxjdytGR2FQN3BQOC93TmVYbUl1bm5aeVli?=
 =?utf-8?B?OHhKd05ralNRaUxCMyt5KytqMW1KY1BTazFDaUExN21kbFh5bXJRQlYzN0ZV?=
 =?utf-8?B?ZldjTWJTMm1vdVYxY0M4R1lOVzF0aFJLdUZvRlBTRG9uY3Q3MUhqTjcwUzNq?=
 =?utf-8?B?MDFIbWZlQXB2VXJQTnNCWlZUSHRFUHhzZzZGTFlwSzlRTGlvQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16be72e-1d02-49e1-8c0d-08d8856f536c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 11:54:06.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NA54aAUwF2ro+FD9DVQxU6eaoeNtehHEGXkND+UlF7jWbW8fbRfQXuJcj6qLNqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
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
Cc: Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMTEuMjAgdW0gMDQ6MjAgc2NocmllYiBBbGV4IFNpZXJyYToKPiBCeSBkZWZhdWx0IHRo
aXMgdGltZXN0YW1wIGlzIGJhc2VkIG9uIGEgMzIgYml0IGNvdW50ZXIuCj4gVGhpcyBpcyB1c2Vk
IGJ5IHRoZSBhbWRncHVfZ21jX2ZpbHRlcl9mYXVsdHMsIHRvCj4gYXZvaWQgcHJvY2VzcyB0aGUg
c2FtZSBpbnRlcnJ1cHQgaW4gcmV0cnkgY29uZmlndXJhdGlvbi4KPiBBcHBhcmVudGx5IHRoZXJl
J3MgYSBwcm9ibGVtIHdoZW4gdGhlIHRpbWVzdGFtcCBjb21pbmcgZnJvbQo+IElIIG92ZXJmbG93
cyBhbmQgY29tcGFyZXMgYWdhaW5zdCB0aW1lc3RhbXAgY29taW5nIGZyb20gdGhlCj4gdGhlIGhh
c2ggdGFibGUuCj4gVGhpcyBwYXRjaCBvbmx5IGV4dGVuZHMgdGhlIHRpbWUgb3ZlcmZsb3cgZnJv
bSAxMCBtaW51dGVzIHRvCj4gYXByeCA0NTUgZGF5cy4KCkdvb2QgY2F0Y2gsIEkgd2Fzbid0IGF3
YXJlIG9mIHRoYXQgbGltaXRhdGlvbi4gVGhlIGRvY3VtZW50YXRpb24gZnJvbSAKdGhlIElIIHN1
Z2dlc3RlZCB0aGF0IGl0IGlzIGEgNjRiaXQgdmFsdWUuCgo+IFNpZ25lZC1vZmYtYnk6IEFsZXgg
U2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgoKSW4gdGhlIGxvbmcgdGVybSB3ZSBwcm9iYWJs
eSBuZWVkIHNvbWUgd3JhcCBhcm91bmQgaGFuZGxpbmcsIGJ1dCBmb3Igbm93IApSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIHwgNiArKysrKysKPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L25hdmkxMF9paC5jCj4gaW5kZXggODM3NzY5ZmNiMzViLi5iZGE5MTZmMzM4MDUgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwo+IEBAIC05NCw2ICs5NCw4IEBAIHN0
YXRpYyB2b2lkIG5hdmkxMF9paF9lbmFibGVfaW50ZXJydXB0cyhzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIAo+ICAgCWloX3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGloX3JiX2NudGws
IElIX1JCX0NOVEwsIFJCX0VOQUJMRSwgMSk7Cj4gICAJaWhfcmJfY250bCA9IFJFR19TRVRfRklF
TEQoaWhfcmJfY250bCwgSUhfUkJfQ05UTCwgRU5BQkxFX0lOVFIsIDEpOwo+ICsJaWhfcmJfY250
bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJfQ05UTCwKPiArCQkJCSAgIFJCX0dQ
VV9UU19FTkFCTEUsIDEpOwo+ICAgCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRldi0+
YXNpY190eXBlIDwgQ0hJUF9OQVZJMTApIHsKPiAgIAkJaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRl
di0+cHNwLCBQU1BfUkVHX0lIX1JCX0NOVEwsIGloX3JiX2NudGwpKSB7Cj4gICAJCQlEUk1fRVJS
T1IoIlBTUCBwcm9ncmFtIElIX1JCX0NOVEwgZmFpbGVkIVxuIik7Cj4gQEAgLTEwOSw2ICsxMTEs
OCBAQCBzdGF0aWMgdm9pZCBuYXZpMTBfaWhfZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4gICAJCWloX3JiX2NudGwgPSBSUkVHMzJfU09DMTUoT1NTU1lTLCAw
LCBtbUlIX1JCX0NOVExfUklORzEpOwo+ICAgCQlpaF9yYl9jbnRsID0gUkVHX1NFVF9GSUVMRChp
aF9yYl9jbnRsLCBJSF9SQl9DTlRMX1JJTkcxLAo+ICAgCQkJCQkgICBSQl9FTkFCTEUsIDEpOwo+
ICsJCWloX3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGloX3JiX2NudGwsIElIX1JCX0NOVExfUklO
RzEsCj4gKwkJCQkJICAgUkJfR1BVX1RTX0VOQUJMRSwgMSk7Cj4gICAJCWlmIChhbWRncHVfc3Jp
b3ZfdmYoYWRldikgJiYgYWRldi0+YXNpY190eXBlIDwgQ0hJUF9OQVZJMTApIHsKPiAgIAkJCWlm
IChwc3BfcmVnX3Byb2dyYW0oJmFkZXYtPnBzcCwgUFNQX1JFR19JSF9SQl9DTlRMX1JJTkcxLAo+
ICAgCQkJCQkJaWhfcmJfY250bCkpIHsKPiBAQCAtMTI1LDYgKzEyOSw4IEBAIHN0YXRpYyB2b2lk
IG5hdmkxMF9paF9lbmFibGVfaW50ZXJydXB0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgIAkJaWhfcmJfY250bCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9S
SU5HMik7Cj4gICAJCWloX3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGloX3JiX2NudGwsIElIX1JC
X0NOVExfUklORzIsCj4gICAJCQkJCSAgIFJCX0VOQUJMRSwgMSk7Cj4gKwkJaWhfcmJfY250bCA9
IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJfQ05UTF9SSU5HMiwKPiArCQkJCQkgICBS
Ql9HUFVfVFNfRU5BQkxFLCAxKTsKPiAgIAkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSAmJiBh
ZGV2LT5hc2ljX3R5cGUgPCBDSElQX05BVkkxMCkgewo+ICAgCQkJaWYgKHBzcF9yZWdfcHJvZ3Jh
bSgmYWRldi0+cHNwLCBQU1BfUkVHX0lIX1JCX0NOVExfUklORzIsCj4gICAJCQkJCQlpaF9yYl9j
bnRsKSkgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
