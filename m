Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85985C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 16:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4769A6193C
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 16:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4769A6193C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00956F420;
	Fri, 26 Mar 2021 16:09:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5F86F40D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 16:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAgxNeGaa0rlj94IBiUatJ5O0/fcMZP/NXWMnlvGM9UitJzPKW8K+KktvIUd4RmrM2HkZbYct6VAf0Vbc2YHP588bQlaKPy8Vx5+tP/g6Xae6o+QXCS/2zpmJXdB8ev8q2ZxkoTE7Zc7LBOJYoxQuSb9ijk9rlVmFeDL7/FQclXdHwwZ5pEydPO2WUEMXQDWacy0dvcz3louXC5ISJNmyL7RufP6nbrsdVk8Cvuin8aHjqXuhoqitU24+seYk/W6FgwDlNy86M72dPfXa9G00smgyUrvqvKkONjVoDpqinhl2XZ4vBle/eqBg/E3Y+TgsCiJ4qoHGqyKm6emHM4Hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic88CCxySxWtL1NRuP/YB418YRA+EQFXgsUxlzU0LP4=;
 b=OLeKHNx5Z6ZnuwjuzX5qLm3jP4Bfo66MUou7CrV/JBalLs0QV9GwGz61G+PagubNgD1HZWRiHbhqhW20ZxWy1n9kI4JdldvivUO5dmGa3PR8dMN5OV99O7P0q4dF4bCHTxBvjMPw6JEXf75aMzQBC8WNDMlepXtiNzigkcAmQ1IYOtVKl1JrueYQnFfXLawP07Xj6x1y2IYZbZOUbUvOoaVGm4DkcdbD9Wb4JYorOftNx+a5z9OBSB+m0HgAwfQ0ElMG5IHIuLxQ/sF5ErBCeAQscDBL3CzTLtw0XMVko9dqFLn2FCyU+CTJCgT/NugaWXFNqOdICc5KK5QKE8s62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ic88CCxySxWtL1NRuP/YB418YRA+EQFXgsUxlzU0LP4=;
 b=QZM05t22RxHTAnKP78nqad879TGxrP64OQK+1Okr6S1NM1fmTrz4CaBheDrknKooqrnO6YZonI7+rxeIbgeU93opVc5H4eDlgOyWFaiG/Hqb6OnFm4CVflcuIx+jaElS6fe+wBx/jlkMOflRzHRBNJDgtBGhKpFZE0aMHFfj9LU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Fri, 26 Mar
 2021 16:09:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 16:09:20 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix offset calculation
 amdgpu_vm_bo_clear_mappings()
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210326152500.7293-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cd56b78d-0d6b-13ac-53ef-d01ba14ca87a@amd.com>
Date: Fri, 26 Mar 2021 17:09:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210326152500.7293-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:77f2:59e3:2172:d342]
X-ClientProxiedBy: AM3PR07CA0144.eurprd07.prod.outlook.com
 (2603:10a6:207:8::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:77f2:59e3:2172:d342]
 (2a02:908:1252:fb60:77f2:59e3:2172:d342) by
 AM3PR07CA0144.eurprd07.prod.outlook.com (2603:10a6:207:8::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.16 via Frontend Transport; Fri, 26 Mar 2021 16:09:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88720c5b-e1d6-4ddf-8108-08d8f071838f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157AD627E5AC0F409D411AD83619@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jE0V7g8oUYkFnpNx4CJxLx09/lg5Owd+0LU55gv4cK5cJgn0niKSFMPeq4ARkS4YXUzIvG3HzUbXcukGULZwGP83TXVIJre3ongRAr2CBVdw6lLss/SyZEdITIYnOTLGRt/R+H7qj6O6KopaL13fUCqP3jaVHOxUjNDbuOP+54bFEXUK2sLuUSgbZqE1WHmDhR776LXn7ZtErUyfmJE+VrGU5+pbCgk3thVzbEoA6MTxlc+pOYXMLIdMLueVQkvi/6qPXIIYtR0aJFBmuXVpICRkheR2kMI2b4r6bUBmXKuVQw09p1Kw1m2VJYDdcnmSj13eAcA/AacfTysATzaDPVnz9B6ZPIPS7DGcPpKnutMlkcVGYCc2Rrm6qZV2v4FCYNEcwtTMxFpvIoMKRYhpoOYNRg3BOwhvDlm6Wn21AmWyHmPdR6YqCHAGfDiPpZ8NkVH+VInRx7SNJWZJlKHBJI/gSBpCo5YM4AcTymEo8mGmtZIdWNWlvpVWCunI0ZkQRtHG8ekt/37GrajSVWSj8fy98lgS+p9Shcp/IijO8MZRg6dbhU02i1tF8kRIVJb7hgWF83WmPq6d5ZR/SzlxVW0cmBaO+nWcHRUwCC+Dm6OkTHhnTZym+I1k3FeVhMhezEOlIxTLQd/Zd+iAiXjFVcHvD0IOKvI1WNhqN1OwOaDPSjj5M0KDVAssUB2h9LtZiQoNMZOIY8QMPWestXKsXmLXWfpLPPFpVmX0wMEkuww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(8676002)(8936002)(31686004)(2616005)(6486002)(83380400001)(2906002)(38100700001)(5660300002)(36756003)(66574015)(186003)(66946007)(31696002)(16526019)(6666004)(478600001)(52116002)(316002)(6636002)(6862004)(86362001)(66476007)(66556008)(4326008)(37006003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q0tmWU1hTHVJZGIzK3hUTW9vdzdtRDVhN0lOSDZtN05uUHZDbjZkaDhTcG5s?=
 =?utf-8?B?REVJZHBrRnlEMFdQdEVDNGFscWw2bUZlWlZLeG1ZMXBwMVdFTnQ3U1ZYRkpq?=
 =?utf-8?B?WjlrSUk0UkgyWjVNR0Fzd3hVTGJHQzBzUEkwOHhuS3dBWkNDWWl5U3BFWWZD?=
 =?utf-8?B?bFkvcjlZRENlU0FqRVdSQ2l2OUc2WC9wUGcvMUNUYXg3NUNKcVMvNWlYZTZU?=
 =?utf-8?B?RzJsVkhkYVRXZHF6elRlL0pzRDFGVzh4N0pSeWZncDhFdkt0d1E4aUVMVkp4?=
 =?utf-8?B?UzU3YnUrL3hOYmQyajNlaWV3NlE4ZjYxTjAzRjAyN3ByWHVHUit4L3dSQk1i?=
 =?utf-8?B?QysrOXpBM1VObXl0NFhLQ2tGbVNYL29KMk05Z2RhWlVZdHdMYlU1Sk8xY1E2?=
 =?utf-8?B?QjBnOXdNQUxMeGlTNHJIU3N1dnRwbXFQNWNwUlJFN1RXTlN5Vjg3R1RjVm82?=
 =?utf-8?B?eXBlTjNrMmhMdFJ1QnVwNVFFM294Z3JWVTV1MGgzeUZua0xiT0RLQ0IyaE4z?=
 =?utf-8?B?YmgxT1JVVzV5SlhpUWpLdVpqajhZZ2V4ZmZqUEw5THpiT0ZEd2hlSGVjL0JC?=
 =?utf-8?B?Q002WjArVlErZ2J0d1RhcmxzS05nY3ZrNXhJTEVpTjQwZ1VacEZhTGtpZ2JX?=
 =?utf-8?B?RE92ZjdiSDZkQkZ3UnhxWjBNRngydWNlekhYWHg2L25kbFRmajV3N21mKzM5?=
 =?utf-8?B?Y2NIQ0J5dUlYV3ovSkROT0pYSG9aK1Q1aTdjUVRYb0g5NzJpR0JFK3d6ZFBT?=
 =?utf-8?B?bnYrUVZuSVJ6czY2YmNBWmFIRi91citzc3ZCUGEyUnc1dGRtUmtWaVVOcCtE?=
 =?utf-8?B?K2xHcVp0bVlPbGlpamY1UVJtMzRJTXUvaFFWY1JWSURud3lxRWZCSkFES3l6?=
 =?utf-8?B?RWZId3lYdlkyVXdWM21hcm91V1VJNUhEVktjR2lwbzFaQlpJaE1LSE1keGRK?=
 =?utf-8?B?UEMyeEZacEJyd3huNkVNNUYyR0RGQ2dBcmlDcllkVFFlUWRhMFJ4VVNBVE1O?=
 =?utf-8?B?Z3d2KzIyVWZCN2ZPYkNRRkgwUTVxMlRxMTdHOWlDci90K2JLNDRKbTZSZEto?=
 =?utf-8?B?Q3VJS2w1eUFaZjk5SWxmRDcyZDNlZHMvYVl5NDdXM1Flc0I0NkVxcHlQOXFT?=
 =?utf-8?B?VjFkWDBGRlF0S2NobmF4L0U4NmpTTmxNQTNzbm1qbS9qOHJscWhNUW9IWmZ0?=
 =?utf-8?B?NnpxbWlqZno4VFd5bUhwOVl1QWdQOWlXY0xQYXVHNmJzKzZnb2pUNUIxYkwv?=
 =?utf-8?B?cUZ1eUhsd3JGRjdPVDdmekZOZk9kQmxURjFvc0llTG1wMlpYNmpOdUlCQWFL?=
 =?utf-8?B?UWc4Zk5VNzAzcUVsQ3hvUVUxZUtlUjdCUVJxdzlTMncybzVTcnQ1K3lZTVMw?=
 =?utf-8?B?enhXcUZxU1M1VE9KeC9pYUZaSHFjWU8wbDJUVTUrWWM4OGprQkh3ODRWWlFN?=
 =?utf-8?B?RnJHNFdqOXc0ZktDNUpLZWp4VEw0OGROMnlWOXY4ZnRWNWw3TU1nVU1mMUli?=
 =?utf-8?B?SjgxcDY5MW1KSmdPemoyTTgrUk1Ganlib0VUTWZCVGVjeHBXcmFOMUt6cWpl?=
 =?utf-8?B?eGdMUkdUREUyYmhUZGhkNzZack9uQk5pREVoQmpKV1MxbGNsUzZ4L2NSTUxt?=
 =?utf-8?B?RGhHY0dtTk1vdWRHeHhqRit1cnFNNUIvUzU0NDFXR0cyaG5yTWx6K1BxU0g5?=
 =?utf-8?B?MEc5d1Y3NUJvQ3kxUi8rRmZ0ZFdWQ0dGejMvZ09selVyNlFLcnRMVXMyYmxY?=
 =?utf-8?B?QnRDb2Q1aXZObWtvclNjUVdzU2k3bUZJRzM0b2VTUE16MkxOQyt2SXZKcHRG?=
 =?utf-8?B?UVJYamNtZkZOUUFsd1ExOUFoc3RYTzNZcUZmelZCSXc3eDZJNS81OE1tSlNK?=
 =?utf-8?Q?tEnGPh3ojBWAX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88720c5b-e1d6-4ddf-8108-08d8f071838f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 16:09:20.5224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRD+HN5E9hryGEfSAZZFU+w5wMTCOe1iJgnpufczwQ4iNy9pfZY+qTSzB/4+P6Vw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjYuMDMuMjEgdW0gMTY6MjUgc2NocmllYiBOaXJtb3kgRGFzOgo+IE9mZnNldCBjYWxjdWxh
dGlvbiB3YXNuJ3QgY29ycmVjdCBhcyBzdGFydCBhZGRyZXNzZXMgYXJlIGluIHBmbgo+IG5vdCBp
biBieXRlcy4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNv
bT4KCldvdyB0aGF0IGNvZGUgaGFzIGJlZW4gYXJvdW5kIGZvciBhIHdoaWxlIHdpdGhvdXQgbm90
aWNpbmcgdGhpcy4gUmVhbGx5IApnb29kIGNhdGNoLgoKUGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ0M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA5MjY4
ZGIxMTcyYmQuLmRjNGQ2YWU3MTQ3NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCj4gQEAgLTI0MTAsNyArMjQxMCw3IEBAIGludCBhbWRncHVfdm1fYm9fY2xlYXJf
bWFwcGluZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQlhZnRlci0+c3RhcnQg
PSBlYWRkciArIDE7Cj4gICAJCQlhZnRlci0+bGFzdCA9IHRtcC0+bGFzdDsKPiAgIAkJCWFmdGVy
LT5vZmZzZXQgPSB0bXAtPm9mZnNldDsKPiAtCQkJYWZ0ZXItPm9mZnNldCArPSBhZnRlci0+c3Rh
cnQgLSB0bXAtPnN0YXJ0Owo+ICsJCQlhZnRlci0+b2Zmc2V0ICs9IChhZnRlci0+c3RhcnQgLSB0
bXAtPnN0YXJ0KSA8PCBQQUdFX1NISUZUOwo+ICAgCQkJYWZ0ZXItPmZsYWdzID0gdG1wLT5mbGFn
czsKPiAgIAkJCWFmdGVyLT5ib192YSA9IHRtcC0+Ym9fdmE7Cj4gICAJCQlsaXN0X2FkZCgmYWZ0
ZXItPmxpc3QsICZ0bXAtPmJvX3ZhLT5pbnZhbGlkcyk7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
