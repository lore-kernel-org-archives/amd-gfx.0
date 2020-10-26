Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E80C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 07:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA17222EA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 07:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FsUu2BaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA17222EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300A36E835;
	Mon, 26 Oct 2020 07:49:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA04F6E835
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 07:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfAGhYXyCG1vt3TWdRVHdJlWOcIA2Rr/1p8Ia853L1WaORmeWyB1Y+2WMAjCf5NpJshfVo/y93rWU8CrjqIgowI6yxWwc5Q5EdXGn2Acc7ulRhVjuG+PXWaM7zFsdah+JD6fJZYLaDU8J7FkkVDTLYFvbCHA7Be1Fz/bqD22u/ixLiEjVDwsPo7uFxhX/nn4n0uXfd5nlyJ6yJfYxLHpFWeKUUJbtRjpx+6LjBvzeMcD3JjawuxZKnwIMFUEK/9aDikjZq3qwPgTisoFo3u8Ai8oI/rYYuXvmV7LgmjTJLWHgHsvzlUP4hizTGd0aRvWP7PbhYDNVphbjBsGno53LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD1uoOWZmP4E+8xprgkcmbk7axHo6A0tVc0bAHKSqFc=;
 b=NcgK8mg32gKgTfjJ1nuMsFxPihgBvX41yBKJXRqL2/2dK7n6UQitDlAFWx6MufToynxrgk7+OcqA5HU4xl+rosWKOQZKlAwolInSXGnzSCJ4N+ALEUHOLnd26NDpetvSB7SVd3I4PMCPzLDDaGYFWKclNmPyXF4q8oLHm4S8bbmB3gXv9pE8p5WkhpR0v/phau84F605ceR9/JMTlO5geY9FZjIlIeku/zKAj7Kw6DEdqnR1xM7f54b2G+D2N0cTUi7FPYBh0KlfGYI3WrIRKRvsY+QZImH+PagLC95JnMo1Pt673oWkC0Hzk3FKTLa0QNVmS6yIsOB/cD5Cg9/Thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD1uoOWZmP4E+8xprgkcmbk7axHo6A0tVc0bAHKSqFc=;
 b=FsUu2BaBFTP+rH3BY80QBQuoMzlA3S/IUioEtHWdaZPulaMICqWUENiRgvlkJWpBo7/Q0fVrcIbio1Kmx+IXf8FJtu9WXgII0OKgiFwJd2xtxxuJJKULaa4LdAAFcAmIZE24B6GIt98k4eadAqUv2yO4EKgiY/qtWUGd4Bpjhn0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 26 Oct
 2020 07:49:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 07:49:53 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix size calculation when init onchip memory
To: Luben Tuikov <luben.tuikov@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20201023054112.3307-1-xinhui.pan@amd.com>
 <a71b6131-5d5b-d00b-fb46-973d333d73fb@amd.com>
 <7ebfd8ba-9d8a-0874-2fde-271f751067c2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1de6eb8d-3432-6d25-feba-e646f92596b6@amd.com>
Date: Mon, 26 Oct 2020 08:49:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7ebfd8ba-9d8a-0874-2fde-271f751067c2@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:208:3e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 07:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 588cce95-bfba-4a91-77c7-08d87983b8ec
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3935BB2877F13808568ED0AA83190@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uk3zZi874FoPBY6+aLhKjot3vyCSOdqnVUCjv7Tfx0Wmo7nINj94JVPRpNejuXgWnGne08YjUpPHM1vkBkzBeshym1Rutx9UToSkxLs5hhgKKZaJJH6dHiDaP1kO2VPf1Hl3O9weg4l+3MPsD2W19XGo5VqdHEBY7cLQc8VJA5lIyCs631qgnPCXJ1Kv6cqBVU4GACRisuj7i4mXEYK+1V0RUNg2Ybv1hfHkXkk0JFuZSo8ZgeHrlfANWUSqpbEKla6wQj5AiWSyQ0uX+Q3yK1mwsMyLrvy+5JboN2DIF6juw4g71+DDIrU3BWOkwZhG831p5xXv2HraW3ZV+DcZSIu423/qabhmFwvlQuggy/N4pbJSYAVi71jDqGXpFFsJBL8feIfVlThC5hoA8I+6eCmSDSvwB0eLW3FaXnBp3BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(16526019)(186003)(66946007)(31686004)(66476007)(53546011)(36756003)(110136005)(966005)(6486002)(66556008)(31696002)(8936002)(52116002)(83380400001)(4001150100001)(478600001)(66574015)(6666004)(4326008)(5660300002)(2906002)(2616005)(316002)(45080400002)(86362001)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y9D5yM7+l103UqBEQiI0Ijh4OxuwwqiDmCz55jm73qIG/lqzAbRAhU1DmZ3lHf2UGw0JRJkmPIM0/9kwc2965360YH63vL9ROm0X9itN2ZVwdhrdK4hfbztNcjJVyqkMNU550VJzylTST7FV148HDNIeKa1Eq+a/L1RhKerKjRuFM9Q+9yI/MpiFuRtUbQB0IBI5ZpkUgoLP491yvtFylooEht/jn6U1IKu8yWEfrFbMDJqr0K808K+ees1yPG1KXv6a0XPZ/Oip7DGNAQQEGt0nYUsvhigjeLFOj4nD6tGXZnxXnXuBqEoM1wBHaBpM+hsLrS1M1eGYUTsFyaqa2icI4BvZLJPsgXvGDoorWQGs+Tm7pGcsnGhlr0j7EmLrKj86KWjWqFSX/LljwagNskts6z3rfzAmTgMtJW13pS0vVu/S0sHjFGTSK+eCS4Iq4nmzOmJK1PwpeJZv82e1SCDHudOqrnMK9cAvjjtVnN3wKU0rxNfCpG493BFmMuAd86bA7UMS9Wt+EBf8Yt9iLUY6E4QbLqIrL6cqTAUn1L/vow8MgUIBVzkWsKWyR5OkbUsmMZuopstsToz97Mv3KrRtNc3Vy2LFrZBzuqG5Ji4OeZ3nPqc9vug75yyIDVWuwp9sPWZ4+lxG8vkZyTgMKn8VaeavIrxXqdHpTXKaq6pq638Xnf3ynB/svmS+3Lp7B4DRjhDy6el38d+7U62z4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588cce95-bfba-4a91-77c7-08d87983b8ec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 07:49:53.0752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OghhHC0JYUr34HUPwCFNcKtlZJdMSskLE3IDEvy8PqSnzuP1zHj3fzWdvSLpDzqy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
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
Cc: alexander.deucher@amd.com, Guchun.Chen@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjQuMTAuMjAgdW0gMDE6MTkgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gT24gMjAyMC0xMC0y
MyAwMzoxMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMjMuMTAuMjAgdW0gMDc6NDEg
c2NocmllYiB4aW5odWkgcGFuOgo+Pj4gU2l6ZSBpcyBwYWdlIGNvdW50IGhlcmUuCj4+Pgo+Pj4g
U2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+PiBBaCB5ZXMg
dGhhdCBvbmUgYWdhaW4uIEF0IHNvbWUgcG9pbnQgd2UgcmVhbGx5IG5lZWQgdG8gY2xlYW4gdGhh
dCB1cC4KPj4KPj4gUGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jIHwgNCArKy0tCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKPj4+IGluZGV4IDRhODVmOGNlZGQ3Ny4uMTFkZDNkOWVhYzE1IDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPj4+IEBAIC02
NSwxMSArNjUsMTEgQEAKPj4+ICAgIAo+Pj4gICAgc3RhdGljIGludCBhbWRncHVfdHRtX2luaXRf
b25fY2hpcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgIAkJCQkgICAgdW5zaWdu
ZWQgaW50IHR5cGUsCj4+PiAtCQkJCSAgICB1aW50NjRfdCBzaXplKQo+Pj4gKwkJCQkgICAgdWlu
dDY0X3Qgc2l6ZV9pbl9wYWdlKQo+Pj4gICAgewo+Pj4gICAgCXJldHVybiB0dG1fcmFuZ2VfbWFu
X2luaXQoJmFkZXYtPm1tYW4uYmRldiwgdHlwZSwKPj4+ICAgIAkJCQkgIFRUTV9QTF9GTEFHX1VO
Q0FDSEVELCBUVE1fUExfRkxBR19VTkNBQ0hFRCwKPj4+IC0JCQkJICBmYWxzZSwgc2l6ZSA+PiBQ
QUdFX1NISUZUKTsKPj4+ICsJCQkJICBmYWxzZSwgc2l6ZV9pbl9wYWdlKTsKPiBXaHkgZG9uJ3Qg
d2UgY2FsbCB0aGlzICJwYWdlX2NvdW50IiBvciAibnVtX3BhZ2VzIj8KPiAic2l6ZV9pbl9wYWdl
IiBpcyByZWFsbHkgY29uZnVzaW5nIGFuZCBub3Qgc29tZXRoaW5nIHBlb3BsZQo+IHNheSBhbmQg
dXNlIGluIEVuZ2xpc2guCgpUaGlua2luZyBtb3JlIGFib3V0IGl0IGl0IHdvdWxkIGV2ZW4gYmV0
dGVyIGlmIHdlIGp1c3Qgc3RpY2sgd2l0aCBzaXplLCAKY2F1c2UgdGhpcyBpcyBhIHNpemUgaW4g
YXJiaXRyYXJ5IHVuaXRzIChhbmQgTk9UIHBhZ2VzISkuCgpJdCdzIGp1c3QgVFRNIHdoaWNoIG1p
c2ludGVycHJldHMgdGhhdCBhcyBudW1iZXIgb2YgcGFnZXMgd2hpY2ggaXMgCnNvbWV0aGluZyBE
YXZlIGFuZCBJIGFyZSB0cnlpbmcgdG8gZml4IHJpZ2h0IG5vdy4KClJlZ2FyZHMsCkNocmlzdGlh
bi4KCj4KPiBSZWdhcmRzLAo+IEx1YmVuCj4KPj4+ICAgIH0KPj4+ICAgIAo+Pj4gICAgLyoqCj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngm
YW1wO2RhdGE9MDQlN0MwMSU3Q2x1YmVuLnR1aWtvdiU0MGFtZC5jb20lN0M4NjhjOTIzMmNiOTI0
NDQxYzAyMzA4ZDg3NzIzMDdlNCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2MzczOTAzMzk2NDY0OTA4MDElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMTAwMCZhbXA7c2RhdGE9SDVyOUMlMkJqM3pWRXNHU0ROVWx4bDElMkJnN2x5dGNzY3pP
N0twU3ltSXYlMkYwRSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+PgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
