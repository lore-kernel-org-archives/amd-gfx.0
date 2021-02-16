Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A7C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 17:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3908064DAF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 17:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3908064DAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D0A6E2D8;
	Tue, 16 Feb 2021 17:41:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0617A6E2D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 17:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk47lyrxWwYvd1+IADCwG5z4tYi8W9dlJBnTMwHjZyxq0fBgHoCQlrAvjiIOXBkUcIOUbhu2JN5d5bNDa6HbSI0lsipqbqE9L/S+SIhs7drjwYr7suR9SJJVm/eWJTWGrpz+jHJEmckcVxr+Se5qATF0Rj44R3P1r0LGsbtlss+UfI6ydW2LqbzMfaN1t1fMCkIz4JyUjaen7sC3Y0L8DLLG1JqdRkJXx8592oCz7nVIJXnbXpf3kx42DddztaHFQIkY5C1v3LM4IUAwQAglSf2BJUTVUKxhDT76li27W/IoVGa04mqsQmNubrfFEQ0icv6hV4KocseYhxhv+rRbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs4p7mheuy5rjdGiZ0NEaNlMJL2XUec4b1bGTRy66SQ=;
 b=dSrG/62LvawW4b+E/vwK9l26fj66IvSG5J1munrrgBieUjlqg5zMflIdvJ69KNEocvghNuxpNtDaI8ZuXXbJOTNxLwN8V/Ch6gKG3iSVq8U80Wm3MIzVqRW5l4PrtX8LnMJUyBfRIdhiyFrf0K1YG5KP975J9s0Wi+jJYjPg9bhH+l0whK+2UsavuIxJPO1leSXk2lt6aouhVkq7t7Y9qDbEyVrplRpbECccl4HDOhUDDRujSJquQ8LhXoDtKE1BrZo1QWX7cw8SmZfMHg6xFB+AAMtoNyemlfagdbauw5bDk2tnz2DOBp7jTpQFycc/S59kCHxM7oVZLApR3rR9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs4p7mheuy5rjdGiZ0NEaNlMJL2XUec4b1bGTRy66SQ=;
 b=re2VC9z5yqTgyZ/HCekKTepKjQ8LMKAkvsbVxNwxzrlPWl0K2yFUXwkkaoTfiWiMektKxbcju+iQwbNu+/LaVSQpC+sUulDTOml1uQ7QLvW3HPzyjl9u3bft5xnc9xZNTKC+y3G3HiRk6PMIW6PhxI/Z7aOPG+koQkQ/OW+Yd1U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1818.namprd12.prod.outlook.com (2603:10b6:3:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Tue, 16 Feb
 2021 17:41:48 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 17:41:48 +0000
From: Nirmoy <nirmodas@amd.com>
Subject: Re: [PATCH 1/1] drm/radeon: fix compilation error
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, alexander.deucher@amd.com
References: <20210216152216.50637-1-nirmoy.das@amd.com>
 <91e1ff6b-0018-43b5-f997-76611d5ba478@amd.com>
Message-ID: <6f9cf36b-44f8-2988-a4d0-946a7dd1bd35@amd.com>
Date: Tue, 16 Feb 2021 18:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <91e1ff6b-0018-43b5-f997-76611d5ba478@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.96.112]
X-ClientProxiedBy: AM0PR03CA0041.eurprd03.prod.outlook.com (2603:10a6:208::18)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.96.112) by
 AM0PR03CA0041.eurprd03.prod.outlook.com (2603:10a6:208::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.26 via Frontend Transport; Tue, 16 Feb 2021 17:41:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b96ce242-1850-4da4-e50d-08d8d2a222ac
X-MS-TrafficTypeDiagnostic: DM5PR12MB1818:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1818CDDA28ABDD6672E304098B879@DM5PR12MB1818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/mdGFH4g+rXcq+JDcHgkw6yx/Bmx6O9xIfvm/Yn3vWmhzSnj2urMaKFHFhtE19Bi6X8cTXfIHVH7ojqroweKaeKbQYgV307hhb8dbmDXHpfUUTp7Mr4JUqOchTFpZ0RVo4NQ4rtLJQigXj9+EYW5qg+6QCZIJqovlEmInQba7gJ8U5gntGMupdimiGtph5AUVXiQK/W1e5+92Tob0N1A4//vm/UT8UUtPrMrmGkWiv5qFcngyaP4F9gvyLaWT+THKziJj+hL81S5gOQVPegI3ZCav95NIcP/ysxkMZwNkXRAm0UI6lxQheWv4AzOAKtLkJ1OLbfmhTiz/pmkc5YyJZpdlAMMl4OzfuND5p5lNvHe5S43FBkgMi8V54dIzVSkX/548MgRQ84xvgNdqepzmHQen8ANzmgCqC6rCFEHubzqW167qDrTnzBSlqhpekSv3HykOPwnt3YdBCF0r2k9jWDmv7Bkntwvu4iinltoxKz8rimKzv0PdLtHvt2GkYL1Sou3posRkfpRaqEYq6gCcAeQFVnBTYu96agrVbP8VsB/MfZtkJoHE0g2ppioIratBb4mKziFsOX+qKNpLvd80+YDkhozDt0YGZDtzQCDx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(366004)(346002)(136003)(110136005)(316002)(83380400001)(31696002)(8676002)(5660300002)(8936002)(478600001)(16576012)(6636002)(16526019)(66476007)(186003)(66946007)(66556008)(4326008)(31686004)(52116002)(26005)(36756003)(53546011)(2906002)(2616005)(6666004)(956004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFNwWEpadEU2dFhGZ0NvQ0YwL0VYV2RFYnA3NUdBMFpmc1B6WEtzVWdzZmxx?=
 =?utf-8?B?K1BzVmM2U0lnNkRkZWxEVGloN1lJZ1FCcGdmSkVXakNQUGJtekJPd0p2MmJx?=
 =?utf-8?B?NGYrczlpV1h5N05Qa01hQ09GK3p1dnhKbVlZMVhvcGwyaStSbGRseVNyNmUy?=
 =?utf-8?B?TjNWdXdtTDBoYnRrRXhiTXBIcnQ3Yys5N3J2N0Z2c0M5UXF2WXdFYXJjcW9h?=
 =?utf-8?B?bTVGTFBYMHdoM3c1MEJhbWFJNE52MmUzaGRvS01Mb0RPZW1WQTY4TVNyaG5B?=
 =?utf-8?B?N3dzK2lDd2Y5LzFUd25PUGFiUlZQNURCQmJGSWg1eno1RWEycmliYkJPUUFp?=
 =?utf-8?B?QzV0VXNRczVhUE51UE9Zd3JpWTlxbUtZVXZvN0JZVlZKV0xTWm9MZmt1c2VF?=
 =?utf-8?B?NTk0aXhXV1RoQ1FCSTRBZWIrRElHRmlwcGtIV29ud2xkR3NDalVpRFB6ZnZz?=
 =?utf-8?B?Z2FjcTQ1RUt3S2ROWGRFSkFDeE5KMGJIcjhQV29vaTNDbmJpeHJUV2JsRjJX?=
 =?utf-8?B?dk1NeE9uOS9aejE1U2gvUjBDSjRuTDl2REkwRG1JL2lidDJUd3ptSWRRbC9s?=
 =?utf-8?B?d2xSbEs0dGRpYjN6RzBIVG84ZGpLZmo3T3RSRitxQmM4OUNCdjFNWVFnMEVk?=
 =?utf-8?B?bGtVZUU5UVpmNC9TYnNXNm5WS3FkQ0R5SGxuQUhmcHNSV2x4ZGhkOGwzYy8r?=
 =?utf-8?B?c0FyRzMraG5KOWdXb1cxcTV0ZDZWNnpPZ2tkSE5uZmY4RXJyQ3FOem1mZHVY?=
 =?utf-8?B?QjlWSG0yeFJjQy9rZHlKWldZaEgxL1VkRll0SWFjUThGM3FXV1pxSFZndFJJ?=
 =?utf-8?B?bDFtQm9IOFlOdXN5SlFZRVU3L3owaHVjWmxoUjJzcjdXMVkxSmE0SmRWczNM?=
 =?utf-8?B?SXVyWVdYUmVWWFBNd0YzMzVHZHJjVm5VekN3eGttbWorYURSenFKc3ROaUVq?=
 =?utf-8?B?SDZRVk1JWXVySldRUmhtVCtEZmFYdEZxeXAwTUZ2NEEyQXpIOHNyTlJ3Vys3?=
 =?utf-8?B?dkF2SXJHcFhXemMrTk9RMzEwNnZHYzFOWXVRd1ZMNTlPU2U1d1Z4eWhKWjVZ?=
 =?utf-8?B?NkRkZGNWZ1dQcUJPOHI4SUdZSWFRMCtMVWtpZWZGY2RSa0Q0eXljZWMxVmNo?=
 =?utf-8?B?VlRSeGhuTTJLNENuSml3dlJqMzM5TzFUMVpuVHFFQ3puRmcwUTY4VjJwdmdT?=
 =?utf-8?B?YkE4QldCNXNHRlhQV2d6K3NQL2lwclJrem1VbVJNajVpNktHVnhQQW5tcjFE?=
 =?utf-8?B?V2dPcTJBb01vU29McVIyN0d5VDdwMjFlRnlvSVd3NGlCemNIMEZWdHJteld4?=
 =?utf-8?B?clY2MGJlSElsUmxvUWlpbE4zZGgxcFZ4YkxGL3pua3N6U0d1WmxmbnNOajQw?=
 =?utf-8?B?V2NtM25IUWdCYTExOWxLYkZ3elA0ODRGZFpiRVQvQUxOdkFWb0dZaTFWbjFH?=
 =?utf-8?B?YTZMTGlrZ2JzQWMzUmdRQmNoRWdOWExDS05ZYk9SOW1CcTM2ZzRpcmZRWXFC?=
 =?utf-8?B?VTNxNVgrb2RYTkt3cER1a1ZsZ2dTM0JLUWpBcUpzR3BXL0h3QzdRd2ZUeGpr?=
 =?utf-8?B?MXJtSXc5YUkrSm94WExqZC9SVk9YakVYaSswN2hyNHV6ZlUvQm9uRnRrNUVB?=
 =?utf-8?B?cU9xOEVxclNQY2F5d3hBc0ExQnB3c2VEcTkrWW9YMzlwNUtOUm5laVoveGJx?=
 =?utf-8?B?TGR5UmJVQ0g2bFNYZlRyaE5IQk9ENXNVODlFUVlMcnY4Z1c5ODQ3Mld5ZUlr?=
 =?utf-8?Q?nxIHAL2qc6f8WD9QIIsYPBLah2BupSUx+k9sSnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96ce242-1850-4da4-e50d-08d8d2a222ac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 17:41:48.4334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVpV0uadQGIfphj6MMKZahQPU3TbJL37whWwozvFLV3sGX35KPUPlyCeE0eix13+LuwiktKGS9AuIvR/wiTtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
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
Cc: Mark Broadworth <Mark.Broadworth@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIvMTYvMjEgNDoyMyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPgo+Cj4gQW0gMTYu
MDIuMjEgdW0gMTY6MjIgc2NocmllYiBOaXJtb3kgRGFzOgo+PiBGaXhlcyBiZWxvdyBjb21waWxh
dGlvbiBlcnJvcjoKPj4gY29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmHIxMDBfZGVidWdmc19tY19p
bmZvX2luaXTigJkKPj4KPj4gRml4ZXM6IDZmODY3MmQ2NTIzYmZlMzhlICgiZHJtL3JhZGVvbjog
ZG8gbm90IHVzZSBkcm0gbWlkZGxlIGxheWVyIGZvcgo+PiBkZWJ1Z2ZzIikKPj4gU2lnbmVkLW9m
Zi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiBSZXBvcnRlZC1ieTogTWFy
ayBCcm9hZHdvcnRoIDxNYXJrLkJyb2Fkd29ydGhAYW1kLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPj4gLS0tCj4+IEhp
IEFsZXgsCj4+Cj4+IENhbiB5b3UgcGxlYXNlIHNxdWFzaCB0aGlzIHdpdGggdGhlICJGaXhlcyIg
Y29tbWl0Lgo+PiBJIGFtIG5vdCBzdXJlIGhvdyBJIG1pc3NlZCBpdC4KPj4gSSBldmVuIHRlc3Rl
ZCB0aGUgcGF0Y2ggd2l0aCBteSByYWRlb24gY2FyZCBiZWZvcmUgcHVzaGluZy4KPgo+IFN0cmFu
Z2UgSSdtIHByZXR0eSBzdXJlIEkndmUgc2VlbiB0aG9zZSBsaW5lcyBpbiB0aGUgb3JpZ2luYWwg
cGF0Y2guCgoKVGhhdCBodW5rIGlzIGFjdHVhbGx5IG1pc3NpbmcgZnJvbSB0aGUgb3JpZ2luYWwg
cGF0Y2ggdG9vIGJ1dCB0aGVyZQoKYXJlIG11bHRpcGxlIHNpbWlsYXIgaHVua3MuCgoKSSBrbm93
IHdoYXQgaGFwcGVuZWQ6IEkgdXNlICJyc3luYyAtdSAuLiIgdG8gZmFzdCBzeW5jIGxpbnV4IHNv
dXJjZSB3aXRoCgp0aGUgdGVzdCBtYWNoaW5lLiBJIHRoaW5rIEkgYWNjaWRlbnRhbGx5IGZpeGVk
IHNvbWUgY29tcGlsYXRpb24gZXJyb3JzIGZvcgoKcjEwMF9kZWJ1Z2ZzX21jX2luZm9faW5pdCgp
IGluIHRoZSB0ZXN0IG1hY2hpbmUgaW5zdGVhZCBvZiB0aGUgZGV2ZWwgCm1hY2hpbmUuCgoicnN5
bmMgLXUiIHdvdWxkbid0IHJlcGxhY2UgbmV3ZXIgZmlsZXMgaW4gdGhlIGRlc3QgbWFjaGluZSBs
ZWF2aW5nIGEgCmNvcnJlY3Qvd29ya2luZwoKY29weSBpbiB0aGUgdGVzdCBtYWNoaW5lIGJ1dCBp
bmNvcnJlY3Qgb25lIGluIHRoZSBkZXZlbCBtYWNoaW5lIGZyb20gCndoZXJlIEkgY3JlYXRlZCB0
aGUKCnBhdGNoLgoKClJlZ2FyZHMsCgpOaXJtb3kKCj4KPiBDaHJpc3RpYW4uCj4KPj4KPj4gwqAg
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMzAwLmPCoMKgwqDCoMKgwqDCoCB8IDYgKy0tLS0tCj4+
IMKgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2FzaWMuaCB8IDIgKy0KPj4gwqAgMiBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IzMDAuYyAKPj4gYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3IzMDAuYwo+PiBpbmRleCAwM2IwZDRhODFmN2EuLjkyNjQzZGZkZDhhOCAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMzAwLmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yMzAwLmMKPj4gQEAgLTEzMjYsMTIgKzEzMjYsOCBAQCB2b2lkIHIz
MDBfc2V0X3JlZ19zYWZlKHN0cnVjdCByYWRlb25fZGV2aWNlIAo+PiAqcmRldikKPj4gwqAgdm9p
ZCByMzAwX21jX3Byb2dyYW0oc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4+IMKgIHsKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgcjEwMF9tY19zYXZlIHNhdmU7Cj4+IC3CoMKgwqAgaW50IHI7Cj4+
Cj4+IC3CoMKgwqAgciA9IHIxMDBfZGVidWdmc19tY19pbmZvX2luaXQocmRldik7Cj4+IC3CoMKg
wqAgaWYgKHIpIHsKPj4gLcKgwqDCoMKgwqDCoMKgIGRldl9lcnIocmRldi0+ZGV2LCAiRmFpbGVk
IHRvIGNyZWF0ZSByMTAwX21jIGRlYnVnZnMgZmlsZS5cbiIpOwo+PiAtwqDCoMKgIH0KPj4gK8Kg
wqDCoCByMTAwX2RlYnVnZnNfbWNfaW5mb19pbml0KHJkZXYpOwo+Pgo+PiDCoMKgwqDCoMKgIC8q
IFN0b3BzIGFsbCBtYyBjbGllbnRzICovCj4+IMKgwqDCoMKgwqAgcjEwMF9tY19zdG9wKHJkZXYs
ICZzYXZlKTsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Fz
aWMuaCAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hc2ljLmgKPj4gaW5kZXgg
MmM3N2YxNTFlZjYyLi4xY2YyYTVlMGQ5MWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2FzaWMuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9hc2ljLmgKPj4gQEAgLTEwOCw3ICsxMDgsNyBAQCBpbnQgcjEwMF9wY2lfZ2FydF9pbml0
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KTsKPj4gwqAgdm9pZCByMTAwX3BjaV9nYXJ0X2Zp
bmkoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+PiDCoCBpbnQgcjEwMF9wY2lfZ2FydF9l
bmFibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwo+PiDCoCB2b2lkIHIxMDBfcGNpX2dh
cnRfZGlzYWJsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4+IC1pbnQgcjEwMF9kZWJ1
Z2ZzX21jX2luZm9faW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4+ICt2b2lkwqAg
cjEwMF9kZWJ1Z2ZzX21jX2luZm9faW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4+
IMKgIGludCByMTAwX2d1aV93YWl0X2Zvcl9pZGxlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2
KTsKPj4gwqAgaW50IHIxMDBfaWJfdGVzdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgc3Ry
dWN0IHJhZGVvbl9yaW5nIAo+PiAqcmluZyk7Cj4+IMKgIHZvaWQgcjEwMF9pcnFfZGlzYWJsZShz
dHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7Cj4+IC0tIAo+PiAyLjMwLjAKPj4KPgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
