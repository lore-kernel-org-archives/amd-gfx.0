Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3B1C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0ED161416
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 11:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0ED161416
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EFB66E990;
	Wed, 30 Jun 2021 11:21:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A12576E990
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 11:21:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBX172cHzBQSNpwdKMJzKYocel/uT6hor2BVJdFScjVkWoQT99KbhqGMWjjjV7nsXbe8k9uKU8foO5FGtG6gfVmxQWv/n69l9Bde8/iuGnNBDKp34D1H062FzVm/TiQWtcxB1DKa/67CIj3qnejZIBmIOUAhJuF2LF7YhBW9tKkeryErycw7hZAXH4gmbkngLLbc/+XzUeWJccmHFSNImyDRsba4VOQYUhnqqtOMGBEev9goLggQ7EbkcdgyaXeIJ5AkWiPCad8jadcvJ3+54E3bIKDRaxWbJfi5e42cR0t8Ix4EKiF1PbNTiX5kNyNWFjeHtG36hodJuVX0OsNsag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYN8a8cFaVyNzCMF+3sCkHa0UH+yJLN9VZL0PGrIu78=;
 b=TTn2LfLjfleVMfVk79A7FYCnpMd3ST6dhih7OTd62Apx/ji2BKMnI5d7aZ9petftTS2lSDrVI04HDgIo98Lcq5QQrzx0DsLUCxlokvcMHS6rvGrAJhhguEz9MJ3ZGyc1GvIRkhPiVR9FKcdeHqrnh0zuLlpZWxwQlm7gS8edgEnwgK7BVWAtOI2YuCdkJ3EVt4rc9fpcN/qpMVJuF+XzMnDm1x+2XeDBPnxSkhkMI6u+uedgIpsirkBT0Ic2aAmIpdiqUv+Kg+SJyr6JQV0A5/me+RIqTsW8x8WGCpBL9Ly8gTHo2Q3Y1RzXEzmmXENorFAUvnf/Q6HguCqHA4dJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYN8a8cFaVyNzCMF+3sCkHa0UH+yJLN9VZL0PGrIu78=;
 b=iM6IWrx+HW9roWyVdFA8cNydfBqB3YG7tmIYFeD4YVbdIgzwYCSl8WOSpRC2XCO+ouv1HwFdSnBLBmOLCdXwpZnaSTTAtEjQ96eAuyvgNnYDe5eoO4SAwNy50wuLNeVyXxBANOAep+tAxF5A4SS/R23JLwCOvlmak7CP+BDYkgM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 11:21:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 11:21:53 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
To: "Liu, Monk" <Monk.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Wang, YuBiao" <YuBiao.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
 <93f00743-d94f-41de-c0a1-9b6b2391e74e@gmail.com>
 <BL1PR12MB5269971F41887FB1BC96558A84019@BL1PR12MB5269.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ae9cd4d0-6887-89e8-b025-6312c679c59f@amd.com>
Date: Wed, 30 Jun 2021 13:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <BL1PR12MB5269971F41887FB1BC96558A84019@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fd79:22d7:4c21:2421]
X-ClientProxiedBy: PR0P264CA0282.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fd79:22d7:4c21:2421]
 (2a02:908:1252:fb60:fd79:22d7:4c21:2421) by
 PR0P264CA0282.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 11:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e42034cf-9bca-49c4-c2f6-08d93bb9430a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB379259A931A615566325930C83019@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLT1JkYQ/a5Fo7Bfy00wXBFuURKUOIHL1C4hW+M7eri60iazawDSo7q5iFhMDKCTh94jorTasZcHMDYgXMVAPRxg/w2ehS+FtYici16BPHMQmIYukVLPjEzrQay93IxDgBltUYOaWDasuJmee7q+01wofvU5TR1ON9gJcFIWelh4AwWNWdGC0ROURV59FDN8pt7rgmjMXK5ewipTexZ+8VaWrFuHAm69spMEiWzy4Woe8H03N2BOHyVcf85uePhaLHKoTyjvUaEX6tLrCU3Gijq0Bv6A9dGOrYXL9mxW8W9UksnKafb5tUFjo//tjP5LEX3rbgWtz/LyxAfxGcmvMvqq90yt7KgIeVb2WJ8nzXNk5LKf3N7kpkjtYsWHThS8q6iLRZtx7lFS7qlawgwVVqNwSf9JnOCP0lcWv1H5b0avCsygfl/vFGny+2J3GlmmemC/NgQ4ELaYU1McHDEz+Wuo9WZEUSpI1O8Yej5dzU0WdymtXTcnYpzOSnSO4DOWRtfOgcxeeBpiN9XKpsCKurav4Nth3JY/RmIVTlbn+PUCHqFFnJncZzOzzdK4d3bb+tJSQuRYR3sYtc2GaAlejvJqCoRJkWU4JcuueTgdDqk4y+vZv7V/CEBT6omNwuRjLaZfRFN7G3GAz5YkeiOroJhtpiLvHYK7vgHSJXkaOiWbILY6nY95R1/wMfe3eWyI5DXnROk1Qn6Zz+p9VlXntNV2C4swL06sl5twGsp4H6ImCt1uVidLnUnBj2P9tHnb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66574015)(6666004)(54906003)(86362001)(66556008)(66476007)(5660300002)(110136005)(53546011)(31696002)(6486002)(8676002)(8936002)(316002)(38100700002)(66946007)(186003)(16526019)(83380400001)(478600001)(2906002)(2616005)(36756003)(31686004)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEovMjQyQXVCR0ROd1FBWCsrUWRxNk01aXhvMFJCemd6NG5STGZRckZpc2tT?=
 =?utf-8?B?MldtNGZrMXpmTnRhWkU3NS8yRk1NT2ovbjZ5SWQyaTlyVzEzcWlxT2gvZzdr?=
 =?utf-8?B?ZXNxVWpabFlRODFmUXZNY0wxZ2FENEU3K2NhVEVxOWZuUFhCbHNHMFR6TWFy?=
 =?utf-8?B?alc0emdNUEdQWTNBa3h0c25mOWptUTBoaW90SUNSTmtwZzNkMkxjdDBJTjZ1?=
 =?utf-8?B?YUZZWWppaG5jQ3IzNEhFb0p6c0RTdnA4TE1lR1NaQW5WcHd4c3lFdDJpa3N6?=
 =?utf-8?B?WUU5dERNdWRvcGVZNXk3K2t6bGlsY3NIMm0wZUtCekhOL1JmdDdWQks2TjZ0?=
 =?utf-8?B?RCtLYTk4SXE4d2pCQWN1MmpmbXNTdkMyZnc4NkI3K21wUUwyRFlvNlhPSmF6?=
 =?utf-8?B?T1ZUb1d6TDVhVjAzZkxDY2pKT01jQ01Qb2w3dlltVGNkeEp3SDk2UXduc2Va?=
 =?utf-8?B?NnpTRi8xWmxRQjkwd2FWakJrenNFdzh4TEtBVzNRZmRzcWFkbHhwYXBOeTly?=
 =?utf-8?B?Nldhd0d6TTBLdjZuQmhMVUhibkxoZGFCeFZ5akRvMUhXRDVxVnV1a1FqU2pr?=
 =?utf-8?B?czJEUytpOTAyWEtFV21jZzB1MEtZajlGdmJoNy96dXJUMVNOcG0vbDB4b0Zz?=
 =?utf-8?B?Skt3OWJRSGtxMkRQK2Z4TktCY2ZQQTE2UjN1VS80VTEvdnFKc3k3ditJbE1Q?=
 =?utf-8?B?U3RvTjlJZ25VSEtvUWorZWJQamN1Yk4wbVlJY2c0ZGxOdVVxMXRCZXR6NVl4?=
 =?utf-8?B?M1pEb3NNb3hhekI3NytoNWVvYkJCRk1VdU51dVhmQk5PUlVOUWpvaldqK3dx?=
 =?utf-8?B?cTJNV3FqOWMvcDhkVUExd1hJUkN2aElFSVVWSlJpR1lFLytncEoxd0RIWXFJ?=
 =?utf-8?B?YXVDQldKUGRmVUtDdXAzRnhuQnVTcWhwZW1hT0tva0JPUkNnOXd5ZGcwd2R3?=
 =?utf-8?B?Y29NblJTOWE2M2ZvVUYrYzg1c1Ywb3l6YjE0R0lITmU0R2xFZUpKY3ZsQ05Z?=
 =?utf-8?B?c3V6bHBISGlxdGRzQmtMQzBFd0NiSm1uai92TEs5V3lQaVhJVVJhOHNSMGto?=
 =?utf-8?B?R0RWWllMWnY2bVNoQWlveVM5VHpOd0dDUkRwcklkYkFqQ2ZpUWQ5dnNXVnMx?=
 =?utf-8?B?cnVLVGdHMWJuKzRBdzFFQWlRVjdVenk1ZjZDRUJDSy9vOFN5RnhpMHRVc2Nj?=
 =?utf-8?B?anFQK3U0NmhGaFBzWGdGcHJPTlAvMGV6TGtOMEY5eWVoNUxYY0dQWVN6UStY?=
 =?utf-8?B?eGtKbjlxcHdMVTBFOG4rUjJPU3JUZVR0b0ExTzhRQUZucmR5eEFOcW00bGhQ?=
 =?utf-8?B?bVdBSHZVc2g0dVdiU3BqL0F4bTIyRENSUEZRSVlmSmZXclR2Y2Znc1lUUTV4?=
 =?utf-8?B?blpJbUhJQ1YydHlEaTRyZWxOa3hiM0dKZzJlOVo3RGFMVHZJQkJsSnNzYVZO?=
 =?utf-8?B?MjdreFFyYnNkOFJsWGlVdHFTQnM1YWUrK0EwTnJIOXo1Ull2eE9ZcWp3cHNK?=
 =?utf-8?B?c0k3TkZSQXJ0NnlRRFJINWc2Qk4vWlRFMzZlZnIwbHIrakdzTEc2bWlGbDdN?=
 =?utf-8?B?SEoyRlRmTmV3c05BU1NhMnJrOFk1cmdZMHpHT1dQSGRrVTZLQTJMc3dkbDJo?=
 =?utf-8?B?K3V5eHBnRHhXOW9iaURqdzU1eml4K1h6MDBDTDlQNmo5ZEdIV25va2R4Qnc4?=
 =?utf-8?B?cXlqYklDazdBRlR1aCtoWjc0a1RYb3pKUDdFeXNUUjJlK1JpamZEME9XZzZJ?=
 =?utf-8?B?WW05SjNzcjFINk5qZkZVWTA3VWRTdGFhbVZuRzU1VDc0a3lZNXN1eFlkNy9j?=
 =?utf-8?B?SmJQc05TcGtMc1dNYXJjREwzTndmWEdLN3p1V2VrNjZLcGF0VFdHWmFpMkRH?=
 =?utf-8?Q?SEypqLZml5upo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42034cf-9bca-49c4-c2f6-08d93bb9430a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 11:21:53.1022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFDEbG0y7FhDMwfpPWaVrYA2VrH/0T4u6XKv5sYvcEdPd+rxeOUAF9kS3YcJQTPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMDYuMjEgdW0gMTM6MTcgc2NocmllYiBMaXUsIE1vbms6Cj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seV0KPgo+Pj4gQW5kIGEgcHJlZW1wdF9lbmFibGUoKTsgaGVyZS4gVGhpcyB3YXkgdGhl
IGNyaXRpY2FsIHNlY3Rpb24gaXMgYWxzbyBub3QgaW50ZXJydXB0ZWQgYnkgYSB0YXNrIHN3aXRj
aC4KPiBEbyB5b3UgbWVhbiBwdXQgYSAicHJlZW1wdF9kaXNhYmxlKCkiIGhlcmUgPwoKTm8/IFdl
IG5lZWQgdG8gZGlzYWJsZSBwcmVlbXB0aW9uIGJlZm9yZSB0aGUgY3JpdGljYWwgc2VjdGlvbiBh
bmQgZW5hYmxlIAppdCBhZ2FpbiB3aGVuIHdlIGFyZSBkb25lLgoKT3IgaXMgdGhlIGNvZGUgY2Fs
bGVkIHVuZGVyIGEgc3BpbmxvY2sgb3Igc2ltaWxhcj8gSW4gdGhhdCBjYXNlIHRoaXMgCndvdWxk
IGJlIHN1cGVyZmx1b3VzLgoKQW55d2F5IGl0IGlzIHJhdGhlciB1bmxpa2VseSB0aGF0IHRoZSB0
YXNrIGlzIG5vdCBzY2hlZHVsZWQgYWdhaW4gZm9yIAp0aGUgbmV4dCA0MiBzZWNvbmRzLgoKQ2hy
aXN0aWFuLgoKPgo+IFRoYW5rcwo+Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gTW9uayBMaXUgfCBDbG91ZC1HUFUgQ29yZSB0ZWFtCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21h
aWwuY29tPgo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAzMCwgMjAyMSA3OjE1IFBNCj4gVG86IFdh
bmcsIFl1QmlhbyA8WXVCaWFvLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gQ2M6IEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNv
bT47IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVpZmVpLlh1
QGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFtZC5jb20+OyBXYW5nLCBLZXZp
bihZYW5nKSA8S2V2aW4xLldhbmdAYW1kLmNvbT47IFR1aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtv
dkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvMV0gZHJtL2FtZGdwdTogUmVhZCBjbG9jayBjb3VudGVyIHZpYSBNTUlPIHRvIHJlZHVjZSBk
ZWxheSAodjQpCj4KPiBBbSAzMC4wNi4yMSB1bSAxMjoxMCBzY2hyaWViIFl1QmlhbyBXYW5nOgo+
PiBbV2h5XQo+PiBHUFUgdGltaW5nIGNvdW50ZXJzIGFyZSByZWFkIHZpYSBLSVEgdW5kZXIgc3Jp
b3YsIHdoaWNoIHdpbGwgaW50cm9kdWNlCj4+IGEgZGVsYXkuCj4+Cj4+IFtIb3ddCj4+IEl0IGNv
dWxkIGJlIGRpcmVjdGx5IHJlYWQgYnkgTU1JTy4KPj4KPj4gdjI6IEFkZCBhZGRpdGlvbmFsIGNo
ZWNrIHRvIHByZXZlbnQgY2FycnlvdmVyIGlzc3VlLgo+PiB2MzogT25seSBjaGVjayBmb3IgY2Fy
cnlvdmVyIGZvciBvbmNlIHRvIHByZXZlbnQgcGVyZm9ybWFuY2UgaXNzdWUuCj4+IHY0OiBBZGQg
Y29tbWVudHMgb2YgdGhlIHJvdWdoIGZyZXF1ZW5jeSB3aGVyZSBjYXJyeW92ZXIgaGFwcGVucy4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogWXVCaWFvIFdhbmcgPFl1Qmlhby5XYW5nQGFtZC5jb20+Cj4+
IEFja2VkLWJ5OiBIb3JhY2UgQ2hlbiA8aG9yYWNlLmNoZW5AYW1kLmNvbT4KPj4gLS0tCj4+ICAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMTMgKysrKysrKysrKy0t
LQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPj4gaW5kZXggZmY3
ZTlmNDkwNDBlLi45MzU1NDk0MDAyYTEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jCj4+IEBAIC03NjA5LDcgKzc2MDksNyBAQCBzdGF0aWMgaW50IGdmeF92MTBf
MF9zb2Z0X3Jlc2V0KHZvaWQgKmhhbmRsZSkKPj4gICAgCj4+ICAgIHN0YXRpYyB1aW50NjRfdCBn
ZnhfdjEwXzBfZ2V0X2dwdV9jbG9ja19jb3VudGVyKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQo+PiAgICB7Cj4+IC0JdWludDY0X3QgY2xvY2s7Cj4+ICsJdWludDY0X3QgY2xvY2ssIGNsb2Nr
X2xvLCBjbG9ja19oaSwgaGlfY2hlY2s7Cj4+ICAgIAo+PiAgICAJYW1kZ3B1X2dmeF9vZmZfY3Ry
bChhZGV2LCBmYWxzZSk7Cj4+ICAgIAltdXRleF9sb2NrKCZhZGV2LT5nZnguZ3B1X2Nsb2NrX211
dGV4KTsKPj4gQEAgLTc2MjAsOCArNzYyMCwxNSBAQCBzdGF0aWMgdWludDY0X3QgZ2Z4X3YxMF8w
X2dldF9ncHVfY2xvY2tfY291bnRlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gICAg
CQkJKCh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9V
UFBFUl9WYW5nb2doKSA8PCAzMlVMTCk7Cj4+ICAgIAkJYnJlYWs7Cj4+ICAgIAlkZWZhdWx0Ogo+
PiAtCQljbG9jayA9ICh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAsIG1tR09MREVOX1RT
Q19DT1VOVF9MT1dFUikgfAo+PiAtCQkJKCh1aW50NjRfdClSUkVHMzJfU09DMTUoU01VSU8sIDAs
IG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUikgPDwgMzJVTEwpOwo+IElmIHlvdSB3YW50IHRvIGJl
IGV4dHJhIHN1cmUgeW91IGNvdWxkIGFkZCBhIHByZWVtcHRfZGlzYWJsZSgpOyBoZXJlLgo+Cj4+
ICsJCWNsb2NrX2hpID0gUlJFRzMyX1NPQzE1X05PX0tJUShTTVVJTywgMCwgbW1HT0xERU5fVFND
X0NPVU5UX1VQUEVSKTsKPj4gKwkJY2xvY2tfbG8gPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlP
LCAwLCBtbUdPTERFTl9UU0NfQ09VTlRfTE9XRVIpOwo+PiArCQloaV9jaGVjayA9IFJSRUczMl9T
T0MxNV9OT19LSVEoU01VSU8sIDAsIG1tR09MREVOX1RTQ19DT1VOVF9VUFBFUik7Cj4+ICsJCS8q
IENhcnJ5b3ZlciBoYXBwZW5zIGV2ZXJ5IDQgR2lnYSB0aW1lIGN5Y2xlcyBjb3VudHMgd2hpY2gg
aXMgcm91Z2hseSA0MiBzZWNzICovCj4+ICsJCWlmIChoaV9jaGVjayAhPSBjbG9ja19oaSkgewo+
PiArCQkJY2xvY2tfbG8gPSBSUkVHMzJfU09DMTVfTk9fS0lRKFNNVUlPLCAwLCBtbUdPTERFTl9U
U0NfQ09VTlRfTE9XRVIpOwo+PiArCQkJY2xvY2tfaGkgPSBoaV9jaGVjazsKPj4gKwkJfQo+IEFu
ZCBhIHByZWVtcHRfZW5hYmxlKCk7IGhlcmUuIFRoaXMgd2F5IHRoZSBjcml0aWNhbCBzZWN0aW9u
IGlzIGFsc28gbm90IGludGVycnVwdGVkIGJ5IGEgdGFzayBzd2l0Y2guCj4KPiBCdXQgZWl0aGVy
IHdheSB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+ICsJCWNsb2Nr
ID0gKHVpbnQ2NF90KWNsb2NrX2xvIHwgKCh1aW50NjRfdCljbG9ja19oaSA8PCAzMlVMTCk7Cj4+
ICAgIAkJYnJlYWs7Cj4+ICAgIAl9Cj4+ICAgIAltdXRleF91bmxvY2soJmFkZXYtPmdmeC5ncHVf
Y2xvY2tfbXV0ZXgpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
