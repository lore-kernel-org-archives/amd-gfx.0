Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0B1C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 10:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8272464D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 10:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8272464D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ED56E98F;
	Thu,  5 Dec 2019 10:50:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E646E98F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 10:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEwV0eLAvZSFd5bQKSA5KHGpNRChJ8zrx6cju2DrHaJA+megNFGojWFrBAvYqeYNxobdrtZUgdr5YVD21q335cr2NRBXQZqJg7KNf7fgDuzCd6+Q/lQA4d2AE/JbWrEL4ZND/PYHAhOFG29d8E2ripkSJyF3i1uPuDqbC4g6c4xbc4uH5Tbaz6i+XJrFLgou6Bn+KB1rHLHQcyilT3DCLHrV0TQRrsmkPN218zHCpO0TiYtCYRH6ckEWvnTZZnMyNkHWj7h7fiD+YYarOGb2rBzsAkcm5+m7MYlyT4WQ7LlT9j47RxhbKhv8HavxqWHerYk4UBdGVH6UbwqyMZ7Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDCd2fDywKe4NRTl4JUE1Pe4/lvoa33/w2xiZclAUdg=;
 b=RMkhhUK+t8AkWk1Y3K1W+l+FrwnoT9thpwzza6FomX7WGf6pdzwqZzplKjdRwoxdfIDkJclVeMkOwmQIpR18X18V6JSuycF5Y344lC00l8mSgUWmNTzg1BatK2j2eGSyoNJJZ/4lz1zjsIO+AmeH2yOxBRU+jx1cU9DBwYN/tu2X1PYJeI/JL6bsS3BIx77/UttoVWMMehtbB8xn7R7PCIDiAr6ortCnc9t1cdtHNdo4NulHyALgZTeu6u4wWndYd2oYt1dXj58jmIFCIR8eJWk7FvzwbPyhUQGNMVayc8YZABPrSDfazJPFr78IEVVdWGAgz4kerakt/BZ8dYHYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2406.namprd12.prod.outlook.com (52.132.142.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 10:50:43 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 10:50:43 +0000
Subject: Re: reserving VRAM for page tables
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <aeb00323-d755-da07-e658-c9a5f5877aaa@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <daa521c7-a844-4d4c-a12f-11efa6f7d2bd@amd.com>
Date: Thu, 5 Dec 2019 11:50:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <aeb00323-d755-da07-e658-c9a5f5877aaa@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::26) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcb5b8c1-4023-4392-e2dc-08d77970f99f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2406:|DM5PR12MB2406:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB240654F5BD22E52081DB7EFB835C0@DM5PR12MB2406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(199004)(189003)(8676002)(6666004)(6506007)(6512007)(36756003)(76176011)(25786009)(110136005)(86362001)(305945005)(229853002)(23676004)(6486002)(52116002)(316002)(31686004)(81166006)(186003)(65956001)(58126008)(2616005)(81156014)(99286004)(8936002)(558084003)(5660300002)(66946007)(2870700001)(66556008)(14454004)(50466002)(478600001)(31696002)(11346002)(66476007)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2406;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAeabw4aIp7Qj7m94J/cZsuT0EwAEKfTKNTlZrcEhzRtGY1lk9w4HkIdGs8BK39q2KqqFpD7LkQfxzd8x1+VIbgxJOfZG+8YP/MzKdfPC/phQITPOJ2jEaYNPj7r+XLRzxXVwCZ3JMpeOaI7mPQM6UenNJ02T1PLxuH3yVAvFUCKqxkeJH+7b0SawAhYPCkptGiUB8Go6MJqRTFJIeDG1XYpb/b070NxlA7GLaw/WxgsDz/aOZzbMzSMKcy2rsStRfC1usjVdDOMMAOCUCcZYS8nhk1M5KRvmor9ZASy0+KOusNHAquyJZGmAr+ooDmkK+eXiWSKtL6T7rADf8sOqQHV/2p3ssdZ61ODtPm7c95gm7tqPAtFmPF7/tN2Oog65l6lhhVY6JjktE0TottYk2QrfI2S2/Ck813RMFXzarZL+dZ//b4+yuUYbBjdu7xn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb5b8c1-4023-4392-e2dc-08d77970f99f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 10:50:42.9446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVWJNGJsgeZaxf38oOa8uGp7QO3j7jjNGtI67vDmSb/JySD9xXiPpLCFHROa6Sl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2406
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDCd2fDywKe4NRTl4JUE1Pe4/lvoa33/w2xiZclAUdg=;
 b=xJKue6pAt6y7I4BAsI6xpXYKn/lkJ+BcdRNhFkeQfW9WOcEQhMkQTW6M3Zeeo7+m+Rgi52HAgpj4aH5rOx+lQGuUGYTKKl6SKlhBhy1voNgdQGhi2c9JQNnZe1S9kQwmT3VKwa9lDq6leYtDbj+b/BO7L33v2DjrotxaqLwCbv4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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

U29ycnksIGp1c3QgZm9yZ290IHRvIGFkZCB0aGUgbWFpbGluZyBsaXN0LgoKQW0gMDUuMTIuMTkg
dW0gMTE6NDkgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEhpIGd1eXMsCj4KPiBJJ3ZlIHNl
ZW4gc29tZSBwYXRjaGVzIGZseWluZyBieSB0byBjaGFuZ2UgaG93IG11Y2ggVlJBTSBpcyByZXNl
cnZlZCAKPiBmb3IgcGFnZSB0YWJsZXMgaW4gdGhlIEtGRC4KPgo+IFdvdWxkIGl0IG1ha2Ugc2Vu
c2UgdG8gZnVsbHkgbW92ZSB0aGF0IGludG8gYW1kZ3B1X3ZyYW1fbWdyLmM/Cj4KPiBSZWdhcmRz
LAo+IENocmlzdGlhbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
