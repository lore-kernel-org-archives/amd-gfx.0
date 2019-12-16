Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B553EC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 14:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8025B2064B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ixTqavMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8025B2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BAB6E591;
	Mon, 16 Dec 2019 14:09:42 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76746E591
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 14:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONMfQ6FZZnpk1HUpK5POyTDqqGGCwG7LoMtL3FvtgoPwts1S+5IRHiLvHcmTDPfq84Q5pQeJjv4wOELiI3kW53gXA+DL42x2PjIytD0WpvZGjt+eYjjkElVwEOe1oUriinezCvOj47z8GxNKRltspXSwUSOycZI79XGmmLH3HveM+peC9zotpRmbm5dtONpE9iseW41nkDS/cKCnJO8Zs2EzaL9gJvwcqYt1Tgd4VprniRYEwcaBNRi7ttmasr1QVgVQE+RtgmSsgSL82xIERoJhpyOLDz0Cy9jIMUHQjGYdmj8cjnkn+RqCojjor7SsMguecVX2M1BdVdGPTjvKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbbe8GIUwODc8qRh4Utw7GJPrc0IjfbeqeQnCHM/EJA=;
 b=ZcLdZ4WqTIAN+Pj49rDaDEeK/TczhWHoKQQhKV0V1/+EiMvliV7FWbflQbqPTSr6U7u6kkP9xgQEUIiPGw21qAKNs0SRp2oVijW00ysY/mNuuI686OKa4yD0VsAWItUBQWtb+KwGHbq+kBEzgWsNYtPjvGQi14nNVjErQoXgI3niX83jc/d4Pc+KzwwO9f2PSmQrQ7sEfNJzAPDhmt1iV9YmADQ2vAqNYoHnLw1yxUT7HVmWs3es4xVog3wSIlSpkxIhx1Ga2aPC/r3V/XAwwzWXDQNkvqWygpjNneYOFxRdSbVjDA7TiUsHXHxjh12LT8qa+E5ffvFY5Su+RjfD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbbe8GIUwODc8qRh4Utw7GJPrc0IjfbeqeQnCHM/EJA=;
 b=ixTqavMmYLuLQ61TmNNYik4XWVd6/3JKMa9Xw+j+WlEjYXZP76EB6Lbc1hhQWm26YqSJ8o4lTcQlqTocXlB9QzRRhBCjGMbXAp3T8H9xIVWWJ27fqd/fhXKwrGIhQvKl33vvkN+8XAwZetzYbTmiVvModJb/6vY24+dT2ttE8AY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1434.namprd12.prod.outlook.com (10.168.238.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 14:09:40 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 14:09:40 +0000
Subject: Re: [PATCH v2 3/4] amd/amdgpu: add sched array to IPs with multiple
 run-queues
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191216140348.6023-1-nirmoy.das@amd.com>
 <20191216140348.6023-4-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <7c619572-c6a3-37fb-1a96-a95c12fd5996@amd.com>
Date: Mon, 16 Dec 2019 15:09:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191216140348.6023-4-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f24:9500:830c:e731:6915:d0f5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44a635c7-8977-490b-de4b-08d782319764
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:|DM5PR12MB1434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1434D1970580FFA2FEED51498B510@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02530BD3AA
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(189003)(199004)(6666004)(558084003)(186003)(8676002)(6512007)(53546011)(2906002)(52116002)(6486002)(478600001)(2616005)(66556008)(66476007)(66946007)(316002)(31696002)(31686004)(5660300002)(36756003)(81166006)(81156014)(6506007)(8936002)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1434;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMDjouNO4SI2DE+MlZwk98+oVIPKKZjJVByyRL4QjO7qXWHlRHTUuwoSFfLNeuSC7uUo9fnZ/j0g9qRVvJ0zVV7A5xNWpQfpXSZODJeMHaoqTPBtBKKvZaFt3nkhgbJ8PpYlwXT61V1/i+9X35WXLk1aygpKLaL016t5B4IW9gB7srm0Dd0cDdojV6dPQ+704o2m2frZ3jhdZdBWdvR1+L0do8MuekzKDZx8xYXj6RTllCoegHYQ2m0eYmbOmrnlF94JuHB28WjsL5DRsesEBIO78kxA1Cdg5Ct8udjNkeswbz4V9DmmoT/4UxscA7PGGSf+AdDGcKMBNBDa7mcRQLVcg92HgAs1XElRjpDYQ0v7qzrpVr3Y27/6hE2nzzNkADhRm3jKeF9mAJCzvi9iStnI63HhvyHhrBAut6jhVYHteU46ph80Sr48J2uzA6qe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a635c7-8977-490b-de4b-08d782319764
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2019 14:09:40.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA6wCP/hyCmYuRqFM+C7YqcEiBX6cDtdI6HXM8gPhvfT/GyZDeQNaVQrFHgvIq0Ki7VT4m7GZNmAE6cQr/kTbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMTIvMTYvMTkgMzowMyBQTSwgTmlybW95IERhcyB3cm90ZToKPiBS
ZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZzxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpJ
IGFtIGtlZXBpbmcgUmV2aWV3ZWQtYnnCoCBhZ2FpbiA6KSBJIGhhZCB0byBtaW5vciByZWJhc2Ug
cmVsYXRlZCBjaGFuZ2UuCgoKUmVnYXJkcywKCk5pcm1veQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
