Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A3CC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0BB611ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0BB611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 261E16E503;
	Fri, 21 May 2021 13:01:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082156E503
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 13:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFMi94rLMiubxF9twyAcc/6DIwGg2QrPCOd7Dfe5jMGDD41XGhECfyII9EYUECPFcvSTroGvy2BqmVee+nRH7SQq4uJyTDcijKnsAa6SA/Vm3bXlUQd3Jgmtu68tsCmXLWPi+/fHSl2EXBwfKl9ecLqi6ngdJxkLORLQnuEiPDeX8F5A4YwuWOgXqxmvGaTjUS8BdJZxJAw5NHU8vVA3Xgo+sWW36SXfB09JH/Se7w9q9aDaswQWnK++YEw9GZImbI82wiKDervUkvQilyC9+carT+rvlmH9GiDOew9ERU7f6C00vEu6GOX1zkV/vlDU7q0Q9uWsWntqqF5/bIQZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUisAd0uXEJpek5NYS7h9cPog566NT2NiI72QyvDGo4=;
 b=KoWtDp4I4TKlwe5inQzLnudX871QqTBm6v1qCfILdgJp+zM3jchCkyejQ3p64PaBGXZJpvT7zNpZDMsGsWVNgDAa3msSbD5Cz9ZOXmJfYGso543wPJOTzvdmTAwbVWFa10G8VL9rxRs9HBCJEzCGSbQOXx9zp1u2ML8qUj6jsEnw5eRGKN2PNKbhKA8w0ommeC9oIZEnxIJu8o4YpCfIVYBQ0ShwGhiONnnZmh4WaTp3OHDQ/ktjC8YBsCl6+s2jfhx1EV+3cLs0LiJJ0o/Wv78vGwyu8N9FVB9ff3Ayams0l6u2GkFTCf16977J1RFSv71+fJo+SWZC2yr80Tx6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUisAd0uXEJpek5NYS7h9cPog566NT2NiI72QyvDGo4=;
 b=bg3TfuMJ12HeLK1AjNW1M/HO3LkP3UqtGQIYgpAw4gxGKz0cEh8RC6naAAkEM5LaUizmW6Vpn15K3t8sXPqvfVQs5+wlTbnRbqjW1TZbUXRLuPlPD/a/Wtaxlm6MQImodwoBpvIyNzkGlvYoa5pnpLTMVNL5L6z4iLnxeHFQFtA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 13:01:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 13:01:45 +0000
Subject: Re: [PATCH 7/7] drm/amdgpu: do not allocate entries separately
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521124533.4380-1-nirmoy.das@amd.com>
 <20210521124533.4380-7-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <04e2e462-1e00-e5da-bc1b-e0255f09ad45@amd.com>
Date: Fri, 21 May 2021 15:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210521124533.4380-7-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d]
X-ClientProxiedBy: AM0PR02CA0188.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d]
 (2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d) by
 AM0PR02CA0188.eurprd02.prod.outlook.com (2603:10a6:20b:28e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Fri, 21 May 2021 13:01:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad0541bb-cb03-4576-fd69-08d91c58962a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB470801D3ED5A14887C9DEC0583299@BL0PR12MB4708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjeU8p3p5Eyr+At6TcDPUjzZS+qm+l2V04AjVxI7GkJS8LJjwKXkLK1fnF5i2qNv3DtKJdNiHkozR32y0OPN+cU6+7OaWKpQydvV30PQYmp8YXvb5xWm3OXfOWZSaAxizDT3TA3006+t2gLsteobErfJmcvD6z4BU2MS3v4HG6ecYO6wzNty6xweee28yMPqr4p2wROfxTxlNGQ0/HIy8A1XepuXya7flAoIxF2Rlmu7Arwxy7VEwvjW4FQqVKoP1TCSid2WS5nrNb/532Zj/zsUc7fbvB0ERG71sM6MwZfWsxjLD63QC1qsGDYKQGy1BrXAwdabmlW3HfCk33LBY2EfEWXTg2b/PCwFzcmb0B/KxxK3vVo6enhb3k2kQ4M0AkJE7ekgpfz14DLDMmz9eI/ftV+aAg97LZiXdwHItd9vVCj+pvVFlc9MT3+Wsdz/hrlYHhpniOXx7apRl7OccjSHbFKzWECL+r6RWoNzijDsGNQ6AsH0jsz5Ha7K4hwMQtqVcLIPGGfii+kvVsDQ/MpUqIViMRn+ok/48vyQ49PnZ11fron3F+ZDo2q8NXf/+A9jWRivVkw3I7wMBNPWkx/OjGjF3QUASj4paMMPoOffVTylA6xcIV/MWQkCO4KE5SD9nu8MvgQXWkGCZlpqRQFNPHftmmOburVd3wPJQyGRYaX7DTHTUFhYw4tAThtI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(4326008)(36756003)(5660300002)(6666004)(2616005)(186003)(16526019)(31686004)(83380400001)(66476007)(2906002)(66556008)(316002)(38100700002)(66946007)(8936002)(6486002)(31696002)(478600001)(86362001)(8676002)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WS9KUkZRWmh2bkxYblQ2UDhZWVZSckwrdVcrdi9BeDFFby92bTlNT0s3L3la?=
 =?utf-8?B?VVBqTXdGZnVvMlYyVUtaMkFsS1pKcjZVOGE2TzBMRTVDcHFteXkrTUxsdFBS?=
 =?utf-8?B?SHFibUdUdlUxbysrOFljdEdXTWFTMVJtb21RZWFZcEtDL1RyaUw0SWt3MVI3?=
 =?utf-8?B?c3pkandBQXRkY0F5d1plOHpLTWlja1JBM0VpUEZKNEtLamFWQk9qYzVBSzdr?=
 =?utf-8?B?Y0svNUpuemNQUllLNWM4dXV3aHNQQTMrQTB0aXFodUw5VGVFT2NvdlRGTGpW?=
 =?utf-8?B?QmdQWENYQnJUanhHWVArNm93SlZJR0ZPV2N4Nk1MMzdzWklnM3UvZ21TRkMw?=
 =?utf-8?B?MGlVSHdSamdIbDQ3WEpSenN0MW9TWTBKd3RubmZ6ZWFMYmpRRkE0QjhndW5H?=
 =?utf-8?B?bTBseTZUeE9rSFIxaGZEMXlsdTlYLzNwN2IxeGZnR3V0djN3Qy9KMTlheGNo?=
 =?utf-8?B?RDJPYkdOQUtCb2UvWTFmVXZtRVNrU2dnQ1RIYjh1dXhMUE00UjZYb21RTURN?=
 =?utf-8?B?T0tLQzQ0R2lFMGRQdFdEeEhZSTN5VWN4NU9rL0lqZC9RYkFaU2lwcXQrZm5k?=
 =?utf-8?B?T1drMUhKMzlLT2tERHQzWTl3Wk93SnhHSHJrRXB4YmtYNDNPSjFwUFFPQ1V5?=
 =?utf-8?B?SGs1TXk3R2VPNjdlZS8rKzV4ZUhYcUtZZ2E4cE9qVE1qSzJZYkFQNlRBS2Y3?=
 =?utf-8?B?LzNocUk1R281c1p0emVpeDZnVVU4ZmVZd3VTMkdQNzVWVW92aGRWWTBmMGs4?=
 =?utf-8?B?d1pOTUhoZ3h0eTZNckF6bzFXc0RtNkJHalhlWStoRW5tV0xiRWs2ZWcxc0cx?=
 =?utf-8?B?U0FUWEJVaGdtcEExZHZyNzF0NS9pOEhkUVkwZVREbm4vd3o1blN1ejNEdktR?=
 =?utf-8?B?WXhVRFhQZFVjamJ0a0FOSkE3aERSMnQ1U1FXazZReHlUaGRZVmdOZHNMRmtN?=
 =?utf-8?B?VVMwdnA1L3Z1U09PQnJxK3B2U3FrQm1LOHBLSlFrUHhTQnFQQzVzN24yUXdI?=
 =?utf-8?B?RGRmV2lCb2Y5MUh5QUhFcEtYZHhvZnVZRzNyMHFubFBoSTRyMVBSVEt6VzNZ?=
 =?utf-8?B?SWNYb1FLQXVNUnZzUStEOXY4Qk1lbFp3M2hwMER0YWgxMGdNQ3Y4ZHhIMDVS?=
 =?utf-8?B?cjYwUnQzTFhGMTVHVGxlY0sxNXBYbllzVDA3RS9oVHYvTzBiYjFEYTZOYnJq?=
 =?utf-8?B?cE4zTXBhS3Y2SXlKbm1NODFidlBJOW1sYnoxc0hEdzFIS0xyNnJkcHZiam5R?=
 =?utf-8?B?TkRycnhuWUFnQ1dLbEZtWUp6YmJJRm9hcjhNeEcxb3NEV3plMDlOTytvMEd4?=
 =?utf-8?B?TDZNQVl4RGRKT1lIdHdxZk55YlVNZnVoVWVUY1lRcmo1RWRQbG5MTlUzVU5H?=
 =?utf-8?B?aEl3L3piRW03bW85ck1peWxBNHVLNDJKN2JEWk1ON3FrN0JwTk5EODZkdVJP?=
 =?utf-8?B?bkRjYUFPMElvYUZvUllsUW9GeklkUFpFTmVGQk1Yb3R6azE3MU92OHpPMlpN?=
 =?utf-8?B?THN1UDNUSWE2NVJtNm9CcjBDNXdKbDcxS2Y4RGVONHIwVGZzUGkxbU84VC9H?=
 =?utf-8?B?T2oxQWtrbmk5MXk0aEppZXVIejhCakRvWkd6RFQ1anA5eEEzUDI0RWwwODNF?=
 =?utf-8?B?c0hiZ1Q1UzJ4NXM5Y3lxYTM2eWJoM3Q2SEJGbk9MOEt1ZWUrSWI4am9MTjVr?=
 =?utf-8?B?NDRieW0rQU43eEFPbTNnYmtEd0dGU1kyZ25taWZnLzkvUW5MV09jMEphTktD?=
 =?utf-8?B?WnNvMnRETDFaNElEdU9hZ3Z1ei9ZMnB0eTdzdWh3by9YWVBXRXlYamhzOUJj?=
 =?utf-8?B?WGRQS1Z4b1lOY1FoVHE0eFhMZVBnK0Y1MjU2WmVTK3JVNzdnVVI1ajM2SFl6?=
 =?utf-8?Q?trfpv42QRhU7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0541bb-cb03-4576-fd69-08d91c58962a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 13:01:45.3084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R205szRZI1A1cwzyZJJ4Tc0PrD1c6ETQIgbO71G88sahJqsAvot7xVIZSaIEshBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
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

QW0gMjEuMDUuMjEgdW0gMTQ6NDUgc2NocmllYiBOaXJtb3kgRGFzOgo+IEFsbG9jYXRlIFBEL1BU
IGVudHJpZXMgd2hpbGUgYWxsb2NhdGluZyBWTSBCT3MgYW5kIHVzZSB0aGF0Cj4gaW5zdGVhZCBv
ZiBhbGxvY2F0aW5nIHRob3NlIGVudHJpZXMgc2VwYXJhdGVseS4KPgo+IFNpZ25lZC1vZmYtYnk6
IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMzEgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggMTIwZTZiN2EwMjg2
Li40NzE3ZjA3NWEzOTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+IEBAIC04ODAsNyArODgwLDEyIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3B0X2NyZWF0ZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlicC5kb21haW4gPSBhbWRncHVfYm9fZ2V0
X3ByZWZlcnJlZF9waW5fZG9tYWluKGFkZXYsIGJwLmRvbWFpbik7Cj4gICAJYnAuZmxhZ3MgPSBB
TURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgfAo+ICAgCQlBTURHUFVfR0VNX0NSRUFU
RV9DUFVfR1RUX1VTV0M7Cj4gLQlicC5ib19wdHJfc2l6ZSA9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1
X2JvX3ZtKTsKPiArCWlmIChsZXZlbCA8IEFNREdQVV9WTV9QVEIpCj4gKwkJYnAuYm9fcHRyX3Np
emUgPSBzdHJ1Y3Rfc2l6ZSgoKnZtYm8pLCBlbnRyaWVzLAo+ICsJCQkJCSAgICAgYW1kZ3B1X3Zt
X251bV9lbnRyaWVzKGFkZXYsIGxldmVsKSk7Cj4gKwllbHNlCj4gKwkJYnAuYm9fcHRyX3NpemUg
PSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib192bSk7Cj4gKwoKUmF0aGVyIGRvIGl0IGxpa2UgdGhp
cyBoZXJlOgoKaWYgKGxldmVsIDwgQU1ER1BVX1ZNX1BUQikKIMKgwqDCoCBudW1fZW50cmllcyA9
IGFtZGdwdV92bV9udW1fZW50cmllcyguLi4pCmVsc2UKIMKgwqDCoCBudW1fZW50cmllcyA9IDA7
CgpicC5ib19wdHJfc2l6ZSA9IHN0cnVjdF9zaXplKC4uLi4pCgpJZiB3ZSBoYXZlIHRoYXQgY2Fs
Y3VsYXRpb24gbW9yZSB0aGFuIG9uY2UgdGhlbiBpdCBtaWdodCBtYWtlIHNlbnNlIHRvIAp1bmlm
eSBpdCBpbiBhIGZ1bmN0aW9uLCBidXQgSSBkb24ndCB0aGluayBzbyBvZiBoYW5kLgoKUmVnYXJk
cywKQ2hyaXN0aWFuLgoKPiAgIAlpZiAodm0tPnVzZV9jcHVfZm9yX3VwZGF0ZSkKPiAgIAkJYnAu
ZmxhZ3MgfD0gQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRDsKPiAgIAo+IEBA
IC05NTQsMTkgKzk1OSwxNCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJc3RydWN0IGFtZGdwdV9ib192bSAqcHQ7Cj4gICAJ
aW50IHI7Cj4gICAKPiAtCWlmIChjdXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQiAmJiAhZW50
cnktPmVudHJpZXMpIHsKPiAtCQl1bnNpZ25lZCBudW1fZW50cmllczsKPiAtCj4gLQkJbnVtX2Vu
dHJpZXMgPSBhbWRncHVfdm1fbnVtX2VudHJpZXMoYWRldiwgY3Vyc29yLT5sZXZlbCk7Cj4gLQkJ
ZW50cnktPmVudHJpZXMgPSBrdm1hbGxvY19hcnJheShudW1fZW50cmllcywKPiAtCQkJCQkJc2l6
ZW9mKCplbnRyeS0+ZW50cmllcyksCj4gLQkJCQkJCUdGUF9LRVJORUwgfCBfX0dGUF9aRVJPKTsK
PiAtCQlpZiAoIWVudHJ5LT5lbnRyaWVzKQo+IC0JCQlyZXR1cm4gLUVOT01FTTsKPiAtCX0KPiAt
Cj4gLQlpZiAoZW50cnktPmJhc2UuYm8pCj4gKwlpZiAoZW50cnktPmJhc2UuYm8pIHsKPiArCQlp
ZiAoY3Vyc29yLT5sZXZlbCA8IEFNREdQVV9WTV9QVEIpCj4gKwkJCWVudHJ5LT5lbnRyaWVzID0K
PiArCQkJCXRvX2FtZGdwdV9ib192bShlbnRyeS0+YmFzZS5ibyktPmVudHJpZXM7Cj4gKwkJZWxz
ZQo+ICsJCQllbnRyeS0+ZW50cmllcyA9IE5VTEw7Cj4gICAJCXJldHVybiAwOwo+ICsJfQo+ICAg
Cj4gICAJciA9IGFtZGdwdV92bV9wdF9jcmVhdGUoYWRldiwgdm0sIGN1cnNvci0+bGV2ZWwsIGlt
bWVkaWF0ZSwgJnB0KTsKPiAgIAlpZiAocikKPiBAQCAtOTc4LDYgKzk3OCwxMCBAQCBzdGF0aWMg
aW50IGFtZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
cHRfYm8gPSAmcHQtPmJvOwo+ICAgCXB0X2JvLT5wYXJlbnQgPSBhbWRncHVfYm9fcmVmKGN1cnNv
ci0+cGFyZW50LT5iYXNlLmJvKTsKPiAgIAlhbWRncHVfdm1fYm9fYmFzZV9pbml0KCZlbnRyeS0+
YmFzZSwgdm0sIHB0X2JvKTsKPiArCWlmIChjdXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQikK
PiArCQllbnRyeS0+ZW50cmllcyA9IHB0LT5lbnRyaWVzOwo+ICsJZWxzZQo+ICsJCWVudHJ5LT5l
bnRyaWVzID0gTlVMTDsKPiAgIAo+ICAgCXIgPSBhbWRncHVfdm1fY2xlYXJfYm8oYWRldiwgdm0s
IHB0X2JvLCBpbW1lZGlhdGUpOwo+ICAgCWlmIChyKQo+IEBAIC0xMDA1LDcgKzEwMDksNiBAQCBz
dGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV90YWJsZShzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRy
eSkKPiAgIAkJCWFtZGdwdV9ib191bnJlZigmdG9fYW1kZ3B1X2JvX3ZtKGVudHJ5LT5iYXNlLmJv
KS0+c2hhZG93KTsKPiAgIAkJYW1kZ3B1X2JvX3VucmVmKCZlbnRyeS0+YmFzZS5ibyk7Cj4gICAJ
fQo+IC0Ja3ZmcmVlKGVudHJ5LT5lbnRyaWVzKTsKPiAgIAllbnRyeS0+ZW50cmllcyA9IE5VTEw7
Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
