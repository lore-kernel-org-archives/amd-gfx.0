Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25634C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D661A619CB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D661A619CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762196E8F9;
	Tue, 30 Mar 2021 13:36:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9966E8F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT6rAI1XcjUWBS3JDuz/maT7EoowNvS0y+m/YBAehpn4JY4ydWdzMq25x0nmF5NNfwrZRHeAK5tnR6LgiSWRb2XTK997HnUaSKoEJbi1gvQt2HecOn0vCDPLtNUbHCRLyB+qjorifjbW8lZQ2VVeCuW2r1mRTyIhRAffycl2qX21GUNWZAC5jWruaQdgI0kdmcRM72p5/RuDU/qtYNAZKBTMPDommcqnqkZp2oyurX0759r05jsnNCzt0KVv15DIUbfTPfLEzMQBRqxtvBo5N+5804gSf0iHd3mMCzrXNhMNsQABOXflJFuPG5Y0XM08UGvR1z1fo5BrKrEcW0dujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w0ZJV04L3javxkZrvKYjgp90rIyJeYjpdoxlIFTGXI=;
 b=k6XgtL90qex8fKkvBEs4L9TzAqzu1WtVinzpihz7X9uETDPN0r+lsMHQ0ETj+IMm4kwnGObCSDxQvA3+wRgS2c/5hsIiqCF7QQN1kFLzNywZE3BrbwSw66W7wftOMXEmSo4o3BLgzjnFR6X/EzW2W5/WEmG/WVXYIM8tXc0OEWdKNXb1hAhgQKevMFbXvw2fL8XzkHc9g8G+YNbOWP43OJPCyWive2/Ct9Pt8JxhCpmaim6/j2c8Kyw6Lfs+wYwusm73Cj1A268bRSQqNT7kQqARut81iU9oNKJvynmCphqgg/ummlZlXkqKn9ja8srzFODeXlhWb5Snafby41OeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w0ZJV04L3javxkZrvKYjgp90rIyJeYjpdoxlIFTGXI=;
 b=tSyOvOkCMywZTGXJJ4mPslalsdcsP90eAQzTtCDMJTU7ug6FQZ2KUSVJp0jLkcLu3os7H9pWIpczlVSHQH3azDct2jFwFsWNgIlh77FCQiy2FbzZRikDthrvxjnJ8840i0iy4/9D2eHoQkSZp7wQgYoFvTrMsuEG8dqqB2MUYco=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.31; Tue, 30 Mar
 2021 13:36:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 13:36:17 +0000
Subject: Re: [PATCH] drm/amdgpu: fix compiler warning(v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
References: <20210330132457.32494-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <05029646-0da0-461b-048b-3862ef478f7d@amd.com>
Date: Tue, 30 Mar 2021 15:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210330132457.32494-1-guchun.chen@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
X-ClientProxiedBy: AM0PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c]
 (2a02:908:1252:fb60:8ca4:a46e:6aa7:208c) by
 AM0PR06CA0126.eurprd06.prod.outlook.com (2603:10a6:208:ab::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 13:36:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a73ac6bc-832e-48e5-2ce7-08d8f380cbac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB456531E00C077023F7BA397A837D9@MN2PR12MB4565.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTTEUAorAeouY46bllVvMvZ0rrxc42v1x2nCg/DyXHtV3an0uKf+IkT1qdPd6VoY4hMcvQhi6daDoOmyWbOSIEz7BkQfq4Mf+yRJWO5OIEOHNCRr44EXGt6LcsVqrmwBM0C+jil4W3WLJ1sdq4WxfoIwjmDljLH533ceq6O8dP1RTEbgSqu1o/eZ5bvSximJNBX/i3cQJLWph4bnwRtAzh/Ncccu3pT4HZUF9oBLHDyhpqy8H3TbJFZa8AhPNzGYUbutCHorw05cxPVw8/1QWqJ8rdDqtbCV18HI9sMTLc8ZbJOpivM+SKKKMteXfhrKV228Xufg22PsnmjpavxNCCsV0bPQ+D2T7s4IGjbNODnuqofvIA6pDVQLG9rUQMJplpxK3089yuGpiIT8Om+rBD/sUdIV8KOPpuxCC7eYXmF1FPDfMu9QsAfzUGfRw5StMioDf897oBlM2rgvYL1+0ytJzdokbQOP+tIEstY8kLbWWnaUhd3eY1xyqcZ89ttyuWqXbBdZSbOVbhDS9KQt59uyayVRvNy6Web54Y1wKNLImd4/TymnTg+V7/YQ08RPF42WnOuBzDV4FJ5zbR3ibyUvI20nMO1gDmXBSdLNBrScWw9Xk+RAiBSkBSz1XaGbPCJPBs7bpOpfOJpBrLPmlIcuvUznsbaSr9lzQEYR6y7o2nunzvZViJcAF0B33mk4UTihPItK9A8azfsR7+ip/BH60QaIQUqg9iN+YbUPwg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(38100700001)(2616005)(2906002)(66476007)(16526019)(6666004)(66556008)(8676002)(6636002)(36756003)(86362001)(66574015)(6486002)(52116002)(83380400001)(5660300002)(186003)(31696002)(478600001)(8936002)(66946007)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUgxbkhJOTEzU1V2SWRaRThZeVJSdFVCKzl4TWszMEVRQlNUVTNucGx1bHRL?=
 =?utf-8?B?eUVJUlNUQ3RVcGhaOVM4N1Q2R1FSNjZxK2lFMTZJWS81T0lLeDI4QnN2RFIr?=
 =?utf-8?B?eUNtcUtlVVlmOGxEdWJDSkk2amVYSklhZUhHY2tiNlhReTFBcnRkY3dROUJV?=
 =?utf-8?B?VjVWcTRjL25OUUNXblRWVWFPVWF3eUF0a2dzYjZNQ29FRUZkbWEvR3lpWXJR?=
 =?utf-8?B?OFFQbjVMWUxIczBjSmMySTY0UnlOQ21Nd1FnK3l3Z01kNXlsTWEzMG9FcGZq?=
 =?utf-8?B?eUhiZk5KK1o0MWVTckRCMFo2SnlrV3dNVHVRWndLV0VQWThvVEJQNVdJZnJw?=
 =?utf-8?B?TWNDKzRnc0F5dE1teEwybHZwVUNLS2NxeFJQQVVXMEpuUnJkZ0NsRS9UZlRV?=
 =?utf-8?B?aGthdHNYVVFSRWN3azE3ZkkrNTZZQ3NBTjJVelJyTHQyZnN5QmFwSmlocFJ2?=
 =?utf-8?B?TUlsdUkvZG12V1ljK0NDdnpQMWtlNXAwRmNPK0hzbzZLNjFvNDhWTXlydmln?=
 =?utf-8?B?akd6OVVKOXBGWkNJTG5ZbnN4UTNkdkhwaHhSTGhGTmtkUUhjY0pjb2VzcWFX?=
 =?utf-8?B?UGtZZ25WUTQ0NWVsakRodDJmcWhEQzlBeUdibGxlRk1hZTJ2NjFjQnFrZXRp?=
 =?utf-8?B?MGN5cDRsL2krV3lOUFV5S2R0MzRSdU84K1M1NVNUTzlqYnYyK0pINXdsK2tS?=
 =?utf-8?B?cWpKdURHRzh6Nlp1a29OdmJhTTZZd2xDSHppNUNmU3NFZ2xLdVdJTGo3QjE4?=
 =?utf-8?B?M3NFc3dHK0lLR2U4dGtQNHVOSU9KVWphT0FDT1N4bVBYTW9sVzFoRng3NXFo?=
 =?utf-8?B?emxQNDNUeEZKZVZXMWptUklmR0pwbVNOWHV3R1VFcGdWMjM4eHQzQ2FWYXhu?=
 =?utf-8?B?U0FtRUtzc0xSVUlrd3pGSE1ROTJHdjRSYUVvTW1NN2V2aEU3ZkxrcDhjY3hF?=
 =?utf-8?B?QzFqdXQvRk51Snp2MlhBUnczL3hsTzFIcWhsY3E3Z0x6Zm1kRytkMVpYZWdr?=
 =?utf-8?B?b2U4Vnl3VUtuYW5ZQVhTWUxNQnhIeVlzdXlrTVQ5ZExLUUlVY1BEcUtrZ2Ny?=
 =?utf-8?B?Y05iMHlHbE9rVzFiNWxCV0s1NWhaVTFDUTExRExrZHlpWUcwMHFqT1Y2bU5B?=
 =?utf-8?B?cVZWNXk0TG5PSVhCS0Y3ZHFGZ0VtcGJHL1N5ejlsZ2FCM3VDMDZ2NXR2di9q?=
 =?utf-8?B?Z1d5STE5bEFqZ0sxL1ViMC9mU1VoU2krSTJlS1JLQ0ZpRVFuL1k1L0M1aHFa?=
 =?utf-8?B?bUdPall2cjBldWhFaVI2ZnpGS0FVWTcxekVXb2dnVzltZCtyaitncERRNStK?=
 =?utf-8?B?cndhc1pWdlVCZHJuZjVHVlAza0VaZm9XYVA0cm0ySWh3YmRnUFNEVW1tV1Jv?=
 =?utf-8?B?WW1RZ2o2OWIwRUlpNzAxSDFLSGdpeTNQcHVoQnJXZ0wzWWxVZXV1Y1NKcnZw?=
 =?utf-8?B?ekpHaC9mTkI1VDZsSG5hZk9OQXo3cDNkS0dTcHhOb1lKOGV3ZnJnVG9raU1Y?=
 =?utf-8?B?eGZrVzQ0bWltb0NxTE1jOTZKQ25MUzhaZHBJdEtSTThHRWhwdEwrNk5WREdv?=
 =?utf-8?B?MW9HZzlJeU5aM1piVlpQYzZOLzZJalo5RTA4Q0dsVE95OEduWGZldDhzTVVY?=
 =?utf-8?B?QkRlY01venVRUVVRSXUyeVNsTGFZdUI2aGxPL3RISGJZZUVxU0JTQ3l0TU1a?=
 =?utf-8?B?NTNrTE0vRjVSTUZhbTNxZmswdDM2Tzc5UkZJZkVGdVVFVkpzS25zTHBrczdy?=
 =?utf-8?B?Ui9yUEtEdDE3WDJ5TDMzS0lkYlRwdVQvaHJHdDFYU3dyYzNLbDJXbU0yQy9F?=
 =?utf-8?B?ei9qUGsycFJmZml0S1J5eURzdm9xLzMvZytQRWtHUkxFN21JQURyTHRoSGVu?=
 =?utf-8?Q?rY4OTD1UjIOTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73ac6bc-832e-48e5-2ce7-08d8f380cbac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 13:36:17.3386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40u/u+UWN2JP4+tHXOjFWElWs/8vS+iYH1iCYSRbEZkcQ0C0W42UHGpfSDV0s+Br
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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

QW0gMzAuMDMuMjEgdW0gMTU6MjQgc2NocmllYiBHdWNodW4gQ2hlbjoKPiB3YXJuaW5nOiBJU08g
QzkwIGZvcmJpZHMgbWl4ZWQgZGVjbGFyYXRpb25zIGFuZCBjb2RlIFstV2RlY2xhcmF0aW9uLWFm
dGVyLXN0YXRlbWVudF0KPiAgICBpbnQgd3JpdGUgPSAhKGd0dC0+dXNlcmZsYWdzICYgQU1ER1BV
X0dFTV9VU0VSUFRSX1JFQURPTkxZKTsKPgo+IHYyOiBwdXQgc2hvcnQgdmFyaWFibGUgZGVjbGFy
YXRpb24gbGFzdAo+Cj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFt
ZC5jb20+CgpJIHN0aWxsIGRvbid0IGtub3cgd2h5IHlvdSBnZXQgYSBjb21waWxlciB3YXJuaW5n
LCBidXQgaXQgY2VydGFpbmx5IAppbXByb3ZlcyB0aGUgY29kaW5nIHN0eWxlLgoKUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4g
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA0ICstLS0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCA3MjJlZmQ4NjcxOGUuLmZiYWE0
YzE0OGNjYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBA
QCAtODIzLDExICs4MjMsMTAgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX3R0X3Bpbl91c2VycHRy
KHN0cnVjdCB0dG1fZGV2aWNlICpiZGV2LAo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJkZXYpOwo+ICAgCXN0cnVjdCBhbWRncHVfdHRtX3R0
ICpndHQgPSAodm9pZCAqKXR0bTsKPiAtCWludCByOwo+IC0KPiAgIAlpbnQgd3JpdGUgPSAhKGd0
dC0+dXNlcmZsYWdzICYgQU1ER1BVX0dFTV9VU0VSUFRSX1JFQURPTkxZKTsKPiAgIAllbnVtIGRt
YV9kYXRhX2RpcmVjdGlvbiBkaXJlY3Rpb24gPSB3cml0ZSA/Cj4gICAJCURNQV9CSURJUkVDVElP
TkFMIDogRE1BX1RPX0RFVklDRTsKPiArCWludCByOwo+ICAgCj4gICAJLyogQWxsb2NhdGUgYW4g
U0cgYXJyYXkgYW5kIHNxdWFzaCBwYWdlcyBpbnRvIGl0ICovCj4gICAJciA9IHNnX2FsbG9jX3Rh
YmxlX2Zyb21fcGFnZXModHRtLT5zZywgdHRtLT5wYWdlcywgdHRtLT5udW1fcGFnZXMsIDAsCj4g
QEAgLTg2MSw3ICs4NjAsNiBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdHRtX3R0X3VucGluX3VzZXJw
dHIoc3RydWN0IHR0bV9kZXZpY2UgKmJkZXYsCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYoYmRldik7Cj4gICAJc3RydWN0IGFtZGdwdV90dG1f
dHQgKmd0dCA9ICh2b2lkICopdHRtOwo+IC0KPiAgIAlpbnQgd3JpdGUgPSAhKGd0dC0+dXNlcmZs
YWdzICYgQU1ER1BVX0dFTV9VU0VSUFRSX1JFQURPTkxZKTsKPiAgIAllbnVtIGRtYV9kYXRhX2Rp
cmVjdGlvbiBkaXJlY3Rpb24gPSB3cml0ZSA/Cj4gICAJCURNQV9CSURJUkVDVElPTkFMIDogRE1B
X1RPX0RFVklDRTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
