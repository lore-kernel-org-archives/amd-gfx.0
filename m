Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CBEC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 10:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CDC61289
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 10:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CDC61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DF06E114;
	Tue,  8 Jun 2021 10:59:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3D76E114
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 10:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbTmRQwpAIlCbCbOTyihjsbtXXQE0eZopliRgkAu1ql7bRsQenzks0VUL/RNeb5euO6VrKeMisNBTn46yVmF4IkluhoehMigUF2/GX+y6SI34NoSXizOKjCjAignKRAsvIJa+3/bhjssj71CCca9I4CYiVehIgtC83OQ6UvMuDAL9G23blPWFTk4N132OY+/R9YFgXpP5q3IHwAfZL8s5whADRh1FJQH6QJMa/dBYqZKqeyjDDdGjxBqS3QaawVBJXEZfZGMcllVdjouBVIHltvxC1OdK9I5b2CyZfIwDH1ZuTTtC/mVmFnLE8BkOZfq9fXwndWT6TseRmMAQqb2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOL2de/aJpcibzd1gKShdk9Pz07ZYgB4E3JuNhtTczM=;
 b=P/Gz0UPUcLivkvKcGC/owbqia3z7KEUv0sdKdolPpPJunCqcNkUjlXWhAy/VlQXpbP4ntSbevUDHut2pmRsbRon1qJO0qEvsLqQ0JphfLIeaIQkc4YNTJMSBrHWdIxCb/GiNXHYVI2NFuNuSqTeK94cIorcV8248nlQbo16eIBjVEOIWIux6nHkwo3l5ogmwc9HVfXUn2qQW95jRG6wNoCHF3y2bLLoLnRIWyCifowQXQO0yHGfzNWoHCuXrVHo8it15M/l5c/BUrmDJZT4c3z1ZJdytDXBUdrL5Ky0BEx1G244X0clp9NNrA2j2Qoty6yl8pf0TUoa5rOaDrdHmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOL2de/aJpcibzd1gKShdk9Pz07ZYgB4E3JuNhtTczM=;
 b=YNS7dNmaYoxg0AxFsMrhjY3bCHbGD5jr8K0TYjlZS8wQhxgMAwLu8oSG1qjnW311ZHADMpdSrjWE/hOd03lnVd0uKFiPJo1V14dPhdfvq6ZFcbILTabiCkts0bKaKodwaWNsjBuwuPTBJeL8rJ0ssxNsc3iKA9P5iLGy9qQNSTM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 10:59:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 10:59:45 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix shadow bo skip condition
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608100626.7750-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6575b129-4179-daeb-8490-2e831888d0cb@amd.com>
Date: Tue, 8 Jun 2021 12:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210608100626.7750-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:197a:8536:afbe:3762]
X-ClientProxiedBy: PR0P264CA0278.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:197a:8536:afbe:3762]
 (2a02:908:1252:fb60:197a:8536:afbe:3762) by
 PR0P264CA0278.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 10:59:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8687bda4-1936-44c7-de57-08d92a6c8661
X-MS-TrafficTypeDiagnostic: MN2PR12MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4549DE8F5F5DC3D7EC511AD783379@MN2PR12MB4549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+LI+5L29EPSRez2ETgTkyxX9BDMm9IX4vfXFPrxu2tp1A7jTd27KIKUoPCupsLrOMsSGamLorlF3DXNl0c4RWK9+oWISNLQyW/jYCxEmEajfmLbN1U+IaGpza55g6vdtQ3WpSZE7iPDrlQffPDKf7CKkjWE2OzNfacoCSgu40pqz4dpxS0ZMTdKAFD5eqkZMkqMLG4iq8VMI3KaL+JJxyc7qeKovPSUTcS8E5BicxO9hz/hEtGKzgYkq+0CSTyf+sBoTay+NzX6gcpmMn86BNVlvHNxtuTCzfW7PVGZslvgFiF+3r6qUnDAkkXmucezOfwLtTjBEgRP3Q7BMfUff11QB8m/Q5cQ0ZZKHXoSdxW/N+3ANG7A5Jbu4dTM1HzGmHexChv+VqfsfDE097a5pnjYRVPpmHuzlpr/9PrS/ci1K6KIUsNmVYJPw3Q++5mzx9TnorAvftvROA/DAW6pq/ZM5dhFym1BcB/DSs+ZT7b6hkzOTW0yvX9bXZVJo96hSCdtH3q2eCTscgUWlSUXNf5bmND9iagWDunA3/RHm/xooXCkF/gRPmj8L6vPepU6cqvP+7F2afSLLROG8vi2rOdy6jLeQxOVescNXYiEPbzbSVE1YPMDwwFi7lqkgqaKuQvcyR/bIOu3O9zxRpcjfSPlAK8tW2v3Syy5ZKzV/64svPM5N7eYpiAcBDQjFmsd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(8936002)(66574015)(478600001)(66556008)(316002)(4744005)(31696002)(83380400001)(186003)(36756003)(31686004)(16526019)(38100700002)(2906002)(6486002)(6666004)(2616005)(66476007)(5660300002)(66946007)(8676002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFpGYTlNS0RhdXlGS2REalAwallmNVhXTHpObDA5NzcxQmlIUkdLUG5Ia2NN?=
 =?utf-8?B?VnY2VjB0aVFTZ3p3Zi9YMjVraHJyM0JZMVBtejZOUUl4QlcyYTRON0RCbm93?=
 =?utf-8?B?WUIyTE4rNUpSd0IrQjhSOWJOSVlscCtnbGV2RStZMWZUK3hGd3cyakpsaXlw?=
 =?utf-8?B?OGtySmZTcCtwTndoLytEQitrd21lVE5BL0FFMWRqMXpnQms5UCs2SzR0ci9h?=
 =?utf-8?B?dEw0Z3U3MUljb2NJNGpwK1FvTG9Pbk5pZllMaHc1YWNVcHJOOWFIQmhMaWhj?=
 =?utf-8?B?RFBFdzBQOW1na1FpVzZ5Vmh6SlZFMTNjZGQ5WU1udFFBTW9wSjhvR2hSRDZ5?=
 =?utf-8?B?N2NmQTlORjVxU05QZXkyTTY2QUk4QUFQUDVVL1BQU1dVR1NXNnZLdEFRaUhQ?=
 =?utf-8?B?b2JTcjBHVTlEM0VGMEJzbEZjNWFoQVRTMzhaR1JtNUlJU1RVZ3FYdE02ZytD?=
 =?utf-8?B?dTFpWk5pdmEwQmdLZ1JMTi9QZHd6eTNjMFRiNWltSWNVc1VIWGFiQld3MG1r?=
 =?utf-8?B?MGJFNk9sRzhxZ3N5azUrclpsUE81bURkblZxZmN6OEpmUHkyT1FJNkFJaGdO?=
 =?utf-8?B?aUl0OHFuOXBtcU9FTzRPT29pNlJ3L1FOZi9tejNJOXoyVi85NjhRTVBsbDlE?=
 =?utf-8?B?dmYyRXEwU3AzemVNT1VURkYvWDIwc25HZE1FNDNoWG5yRU9vd1lXVWNxSWI1?=
 =?utf-8?B?dmZ5RFVSeXpCZUQ2ZmpJRHB2NWlyRXJOSGdOSlZsbTVmSjRZa1hlVVNuazZZ?=
 =?utf-8?B?WFQ5d0FZUExublB5dkZTS25PNEtCdHdoREpUS3VrMUlSUXhldExyWW03K0Qv?=
 =?utf-8?B?OExkUVJIV0dsM0dtN1luR09GRHhFMGw0YVZlcDd0azNlNkJHQisySzdnNzQ0?=
 =?utf-8?B?bkNLZ2ZkQkVFWEpoNHhxNUJEa3Yza1U3NEhJcjFHbHBkWHF2R0VvUzQ2UkJo?=
 =?utf-8?B?UVdrWnExTUFDbFUxQ0xucFNIOEVnejRBbGF1MC9KOFMvRnhaclJ5KzN4TzNP?=
 =?utf-8?B?NnNyWHhWQXA4TWlxNGd2NmJQV2xBSFRBZnVPZWlaOUtaSk1BalBRbm9qT3hR?=
 =?utf-8?B?eWpsS0QvaDFTR05VTENFSEZyNVQ3UXFZS21LRzNZWWlwSElrazZOYldZcVlO?=
 =?utf-8?B?RGw2eWRCTGNpMmdqNDRaWUZXbGdQQW5NR2RlQ0xHcDhSUmtGQVhxSG9LYXVM?=
 =?utf-8?B?N0pBeFJvQ09la29xcStWbzJ4UHVIVWk2QWk5bVMydllJZmV1SnZHNFp5UzZh?=
 =?utf-8?B?Mmg0NW9obUNvQkpxNEc0OGVFVHNBc3RvRTl5elNyMXE0NDFNc0VBYzFPNlQy?=
 =?utf-8?B?QTBodDY0Yi9VanVtNjVuTVVhQVA5S3BkSDJSSWM2NXJkaExacXRiaFMwdUZG?=
 =?utf-8?B?MGtuMmthV0xDQzU0NTF6RzZ6RmhKNE84ZVd2aTlVRGUyYnNaSS9mYXA5QW9j?=
 =?utf-8?B?OExyZWZPejVlZmJPR0s1NldVdW5sb0FhdHZ2MS8yWDdwMkl3NVZtaG9vWHhr?=
 =?utf-8?B?MFNNMExqTWVDRTdKN3lyamdNQ3U2RWZOQXl3S0VuaVlVZGRsblRzS0hmZzEr?=
 =?utf-8?B?ZEhQNEVPRmZiZFJNQ3Awak5Cc2FhNWxkaFRkSUlFbzFoMk1vV0YySUdDTjc2?=
 =?utf-8?B?MmhIdDNZc3ZhVXZtREd5Nng2dUZiWlRuZE4yLzROSFBZS2RnV2VYaWtEUjN5?=
 =?utf-8?B?LzNzdGJ1R1dpNFY4dERLZUZabyttalBaMTZSeEdpVW43aUdBN0hpQlhUYjkw?=
 =?utf-8?B?UmFITlZGaWxseFc2dU5oYjRIbkw5NXFNakc0QVN3eWxTM1ZPbkQ2ZkZtTWs4?=
 =?utf-8?B?bVd1YjVXcXdTbWZUbFZZVG5xc0tZNHZhN212cGdLOGp3TFQ1V0Z0M2lZWG1u?=
 =?utf-8?Q?4JuPYtChhwAmO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687bda4-1936-44c7-de57-08d92a6c8661
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 10:59:45.2919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaoT6pvUs9/sOca4xlegPPwO0OhuFyNF6vQmFd0qMIJ6DTjOyMu0bYUYWN5cK8sg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDYuMjEgdW0gMTI6MDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IENyZWF0ZSBzaGFkb3cg
Qk9zIG9ubHkgZm9yIG5vLWNvbXB1dGUgVk0gY29udGV4dCBhbmQgb25seSBmb3IgZEdQVS4KPiBU
aGUgZXhpc3RpbmcgaWYtY29uZGl0aW9uIHdvdWxkIGNyZWF0ZSBzaGFkb3cgYm8gZm9yIGNvbXB1
dGUgY29udGV4dAo+IG9uIGRHUFUgd2hpY2ggbm90IHdoYXQgd2Ugd2FudGVkLgo+Cj4gU2lnbmVk
LW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA3NGM3ZDhiMjFjOTguLmUyMTQ2Y2FmNjg2NiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTkwOCw3ICs5MDgs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9wdF9jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCj4gICAJCXJldHVybiByOwo+ICAgCj4gICAJYm8gPSAmKCp2bWJvKS0+Ym87Cj4gLQlp
ZiAodm0tPmlzX2NvbXB1dGVfY29udGV4dCAmJiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSkg
ewo+ICsJaWYgKHZtLT5pc19jb21wdXRlX2NvbnRleHQgfHwgKGFkZXYtPmZsYWdzICYgQU1EX0lT
X0FQVSkpIHsKPiAgIAkJKCp2bWJvKS0+c2hhZG93ID0gTlVMTDsKPiAgIAkJcmV0dXJuIDA7Cj4g
ICAJfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
