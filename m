Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFCFC2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 11:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C289021734
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 11:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WncN2eee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C289021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42B46F4CD;
	Wed, 22 Jan 2020 11:41:17 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690043.outbound.protection.outlook.com [40.107.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E0D6F4CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 11:41:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG84maKgTYLI0gpQgtGfCA1buzbzVeUHbpfuuFFwcgLQ4YrRhrsQB3ijIGivOyH9Kt0fYFOsXX5B+YfnRdUjp75WXNU95S+tf0u96koqqq6TfimpToCRxtVzmFo3F539Fwzb/AuRccSjkAim8kacTU0arq7Y4xJvW38HcmapKlHsoRIDHveevcCAPw3WX1epE5OOlPhH7hVvpdSa+ZV802s7QRR9VVYpcmlZ3/eKwdrcf3G2GueHW74kaxWiEQwi+Fwrj7IsLaRnsA+1ef6QCpRAvmhfSH4s0O0HiNAXC9S7GKXQcxXbjSpObQdbyZojmf+iVA/YFWuXlFMoPAFgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIBUOsW9XnwTVXQnVJwXKEnieJ861SqWKzBcnTNfXIs=;
 b=FCyvo+fivNWXZub4U+o7gP3wnQhbA1GZgmdbtA7/6ngcx0Tx/r5kxd3OlnRmZQq0QDH76bFOH/8STgt8Z/YnHVmM2G3+st47+rXybT/4J5ALnIV36174GgPQayuTHFDznIKvXFAzV7+fLjex8iL+T6+9/0oKYUdeHO/WujWrbpGAtqXCXY01kiBujqAU5r3voUHQuI3fFMFSPxGimO8dnQGC5xbGylud9rc5DvLELTsrUPFuQT5rbYUVc3rrS4aCJvYaDIBuT+SOKu7XEiZUgTFt/RAq6tBcVICEPbgMeVtwl/Gw3QkkmUp3fDch/0GSbGsHyc4hT25EEqYOS4UzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIBUOsW9XnwTVXQnVJwXKEnieJ861SqWKzBcnTNfXIs=;
 b=WncN2eeeQu/WZuR/PLgyhrKrn9T0qtzIShHmfLdzkXYoh7vqEca9XFskOLRXMiWfYRBa6Qi2902QC57YeX9R351qUm7ZuXCjzFpCM2H6xLGswzEjokm0e0itrZGFLLIl8gAdUNbHM9KU66FIyEzAr78N+mRrWrn27D66ISfl9pQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1243.namprd12.prod.outlook.com (10.168.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Wed, 22 Jan 2020 11:41:16 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 11:41:16 +0000
Subject: Re: [PATCH] drm/amdgpu: remove unused label
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200122094440.31166-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <94c8bb06-412f-8acc-7c74-c2a843273bf9@amd.com>
Date: Wed, 22 Jan 2020 12:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200122094440.31166-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 11:41:14 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c810470b-6bb0-44cf-fcf9-08d79f2ffd51
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:|DM5PR12MB1243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB124334C2122563471BB20FBF830C0@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(31686004)(478600001)(2616005)(16526019)(186003)(52116002)(4326008)(31696002)(66476007)(66556008)(86362001)(66946007)(6486002)(66574012)(5660300002)(4744005)(6666004)(2906002)(316002)(8936002)(8676002)(81166006)(81156014)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1243;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZIBOYxVC0GXs02Rg+CjvWQZ9lq6TjUQ/WMyU3J29OErblR7QO7TTxGYXmhwPrHNc6Cyk7sAurRMqxN9qpPdo8F/gxLRYP+UkCwO4ifsJ8S4KqHxJDrhQwIJQPvAHx8AL3KH2FrG28NPaO9AR1qibJZihbCGIMNDVxLsrAtp41J/CfOVnzktFU7JRVDuSGaKVgZ16vzBts1Icjgoq+4RlV4jlzwCLfx2EsGYtOtzJ842mwL2NkDXCGvVEiMixJqUSeL3K1WyzIjRdg1deSf/nrdyFQ/UEoe6rGVEjdS1HfEwJNhdSYZxwLe3H40JKR/3380S2UNmIa+YllbNYLTdysNix3S7I+4atG8WADsmqbz24BgXHPAOT0Rk3ySk0+6BIREijso49IRL27QChEeth5V+/tro+pVd+JIHYp7OXf/QlFpqHNpr9/TDpJLlU1bg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c810470b-6bb0-44cf-fcf9-08d79f2ffd51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 11:41:16.0301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a1kzP0v01zPhHAC0q7WiOeqMMSLY6L2Uf8gERQmpRuD9VXI6TAY+ut7fRGfXYrg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjIuMDEuMjAgdW0gMTA6NDQgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeGVzOiA0NDVhN2Q1
NCAoZHJtL2FtZGdwdS92Y24yLjU6IGZpeCBhIGJ1ZyBmb3IgdGhlIDJuZCB2Y24gaW5zdGFuY2Up
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpBY2tl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml81LmMgfCAxIC0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3YyXzUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92
Ml81LmMKPiBpbmRleCBkZTMyZTk2YTg0MDkuLjcwZmFlNzk3N2Y4ZiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjJfNS5jCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YyXzUuYwo+IEBAIC0xMzUzLDcgKzEzNTMsNiBAQCBzdGF0aWMg
aW50IHZjbl92Ml81X3N0b3Aoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCQl+VVZE
X1BPV0VSX1NUQVRVU19fVVZEX1BPV0VSX1NUQVRVU19NQVNLKTsKPiAgIAl9Cj4gICAKPiAtcG93
ZXJfb2ZmOgo+ICAgCWlmIChhZGV2LT5wbS5kcG1fZW5hYmxlZCkKPiAgIAkJYW1kZ3B1X2RwbV9l
bmFibGVfdXZkKGFkZXYsIGZhbHNlKTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
