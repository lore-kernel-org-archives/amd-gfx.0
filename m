Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3AEC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171C82073D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bgUSUHlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171C82073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FB36E44F;
	Tue,  3 Mar 2020 15:19:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABDB6E44F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 15:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXcoDpZtut/Y7o69FXrfYLmip3UQ4D2CaeRcj7PWy/wy7KF4KL5up1N0+WeDvkI0e0vXE0sHXGHWix6rV3aEM069UAj20UzbpqzsxBesWTwlFwmNCocbphAwVtYnFgqcW5BHamQwUfe0ed3rzg+xIL81JEp7JPxJLNOu5KFGONIAeBjGiCRlRNIbwj1Dds7cnXWMpUrKfu4pXwMhtzBLAIaEN/2spWo/kI8bYPejqtPQ7G0MGgYjVYgVw6EWGXRUcI+dZMOBoZw47ul3bhuFgnErB3YbjeFTFNQuE+crTFFTdBHgbC8NBMMfYxfz50SWtxpR9ztJScIHjEFlJNruAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5JzdxP6GuFOyiBqzalcvYpOBZimPQ9FHou1Sv2mBsc=;
 b=BbpgflScZCfV90gUCcHJFOstrRCACembSMgc3ox3ST4D3ds7gkLkCestNs2+7Eka97UT/WO43HSCi26onBceeZeUVK1jvqBHN7T9zJIq1LyRQopNjti/IgCC53ZNJsjinBUgXUzTmqpBqYG7IQxlPokRH9h1WsdG2JGZiS7wIRW5th0Y0PdcdCxe2ZqQ1wzVghg5iLvAsSb7No/nI8508PIejfxysae6Jz5Cv1QQ86IIgcSu14d6Dz+N1EalWaD27aoh52reZmse/IJ/Fpx7h//w+rbi+01NrjeIoG+gZC1hXKavME3Mx7o6mr91/EsuYqxOk+1Xt1CAory9fMsl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5JzdxP6GuFOyiBqzalcvYpOBZimPQ9FHou1Sv2mBsc=;
 b=bgUSUHlbP0U7AZDe22HlAHDwlujzm5GKIWhiRU+jHMm5ustnx0v0fF3hcpiU/b2hiPTfnp9AMDrd7NLdA/Sf+bZD6ba/f7UxF7X2B//+xS8xbgFgSQ+Z+gV52hiM3Pxhq9VWMHI7493J1naJgCZe6h41ysNMIrBnFaJyoGno95Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1532.namprd12.prod.outlook.com (2603:10b6:4:6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Tue, 3 Mar 2020 15:18:59 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 15:18:59 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
 <478f74f6-db21-0e52-9b19-e968d2fa6924@amd.com>
 <b866db7d-f084-158b-c891-32221109b839@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1f70969c-a608-bd1b-d13c-c25bcf9cd389@amd.com>
Date: Tue, 3 Mar 2020 16:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <b866db7d-f084-158b-c891-32221109b839@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0067.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::44) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f27:f600:ccd8:21cd:e339:f0da]
 (2003:c5:8f27:f600:ccd8:21cd:e339:f0da) by
 AM0PR06CA0067.eurprd06.prod.outlook.com (2603:10a6:208:aa::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 15:18:58 +0000
X-Originating-IP: [2003:c5:8f27:f600:ccd8:21cd:e339:f0da]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45d8b90e-d397-4dfd-4d85-08d7bf8632a0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1532:|DM5PR12MB1532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15320C8BCA49C852F01044778BE40@DM5PR12MB1532.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(8676002)(5660300002)(4744005)(81166006)(6666004)(81156014)(2616005)(53546011)(186003)(16526019)(31696002)(66946007)(316002)(66476007)(66556008)(31686004)(52116002)(478600001)(36756003)(4326008)(6486002)(8936002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1532;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JngV/fU+aN4MzcbfJJAqBptb/4vs3OSth21/WnZmHmadja5wEz1NR7Ul/Z2zRVC5ZsqiMB9MHI5P+WHb7p1dUw9iNrFfwGand0EJqURwP51l3HXbWKyoCPT3FcHa5e6NyZw68dQ0OZGhCZoqoTW5oj9iFRXJdPwi37XZYlHZK9CIjbOdaE9A+rIejG/oJNgTEFbOMSjZr/OSjF1DsQ05ErH9W+vq6bdJRMOllqgN1rUcnFEI75XuJo/tv9sL4N91G+GQDDRjrUFOA2wP3O0K3vaCKGhrLjQJENDsPUi7ze0e/9WFE30XfzSgH4Nqil28y1qhiVOfxbAwJT03E1GHGBveBhmSTK5NtPSiuWgOYlvcgkaixb9w6WfWAe1sm6yrEiEUKU7ttVtN+/krsK8G2xvTtBULqiyC3Ny3o0CM0EaTGqykn7UtZ8hXl90+k4Za
X-MS-Exchange-AntiSpam-MessageData: 10DP4jqWiJH3Gw+NaMXnLuGsqSj0tfrTYZrkKB8M1T+4dIn2uKMNOTYjsLliZA+8GQsU2MVMPTPpkHgFn/oCULRQL7FUiIrfy0tyPdOhpOl1UchvzQjmBssbPhnKlkrwzgMavSyTP6lUB0qprzv8pOiD6WMYFLYgwoHIjs14ZMMbOHFBCWwYAMDXUfS9BJyRWM1LKsURRmHIFAIUuMtzRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d8b90e-d397-4dfd-4d85-08d7bf8632a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 15:18:59.4282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beBroZzjwmnbEoS0LJ7q4SjVl7QY6Ig3yjX9hK/Y9wSjIn7eCuDlPnfUkcIMN1c610YXhp/xF7oWwalvMNK6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1532
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKT24gMy8zLzIwIDQ6MTQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4KPj4+IEkgbWVhbiB0aGUgZHJtX2dwdV9zY2hlZHVsZXIgKiBhcnJheSBkb2Vzbid0IG5lZWRz
IHRvIGJlIGNvbnN0cnVjdGVkIAo+Pj4gYnkgdGhlIGNvbnRleHQgY29kZSBpbiB0aGUgZmlyc3Qg
cGxhY2UuCj4+IERvIHlvdSBtZWFuIGFtZGdwdV9jdHhfaW5pdF9zY2hlZCgpIHNob3VsZCBiZWxv
bmcgdG8gc29tZXdoZXJlIGVsc2UgCj4+IG1heSBiZSBpbiBhbWRncHVfcmluZy5jID8KPgo+IFRo
YXQncyBvbmUgcG9zc2liaWxpdHksIHllcy4gT24gdGhlIG90aGVyIGhhbmQgZmVlbCBmcmVlIHRv
IGdvIGFoZWFkIAo+IHdpdGggdGhlIGJvb2xlYW4gZm9yIG5vdy4gXAoKQXJlIHlvdSBmaW5lIHdp
dGggc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyIAoqKmNvbXB1dGVfcHJpb19zY2hlZFtBTURHUFVf
R0ZYX1BJUEVfUFJJT19NQVhdOyBmb3Igbm93IGFzIHdlbGwgPwoKClJlZ2FyZHMsCgpOaXJtb3kK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
