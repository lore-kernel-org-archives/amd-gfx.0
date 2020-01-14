Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE34C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1A024655
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w4TEsEUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1A024655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662B96E428;
	Tue, 14 Jan 2020 16:23:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F0706E428
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 16:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7b8yl8fsfq863az1v5uzTZW/WkoT8xqWHhqV6IWud+ivnNNbFrat6FHCMHuK/MuyoGvROmGUyMNOayA5tpVot5E0UoVpswc7Nb/7yohemQJDtx750EdDPtAedn9WlQq/LBQIolyauNTl6g89RH1SzCQpxew93WAKsF3fbhaWMFSRwqV2+V/HSLYQ8hqVCYRjlzuioKI9Q9BDXRduHM5ZA2mgILzHKlgmDbHAiiYWiul/tCmYqrLrKbgBfRLNlk21Hl0SlRuGhWstvj9x0taf92mPwQV2KK8+dz2j7IG0gpJTySZq86wIGPU8gkbMmkDjCQ32hwYyBDM9aN0/HJmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgQs019wIGybvh1os/FBQiScsylW+FPrA+qQBiHIkYQ=;
 b=e/Y+TPC3RZlX49W5YfMMwGO3/3A/YybK3qOSkuz7/6FjegY05Zf2v8n5xCs3vQ8czMQNcnnI3wkN7HSv26YJ/4eL6ZjmVL3TipEsLUzdXyo4euCySzL1e2VHqDz44/pHgF9eJ1kXSFBScqDn99rQR+50HcedB71y4jWTv/Is/8qQ0c5QWXTnFrXEsOc5GJK/jUn9T98SCXAbS3obANt0XOSK/lkM68PIltprzbEabn42FyqPABm9AhRe3H1c1osblRl42/j+G/eLX0Q+XG4unNTba1uP9QAXsKgcWmMrwKK0xvWKEFSlTCV5AYimlYZrXn5RVAOGs8/lhYYruxT/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgQs019wIGybvh1os/FBQiScsylW+FPrA+qQBiHIkYQ=;
 b=w4TEsEUOQXkK4z9MH4i83ARWwaqDB4yZrdSrj9p5OmQn8/76sWdULwlSKZKWUg7bxKfXDXbsCZ3aFEvRnSdRGl1xl2U7sGqdeqMO6f8RIQxMwiHZ4FDkq4qwehQFdSrcdfMIXhWk0rklZ00j3Ni8H4lORESjUthDybiWy4QAUcY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1707.namprd12.prod.outlook.com (10.175.86.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 16:23:32 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 16:23:32 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
 <04f6d680-02ff-7526-adb4-4d44e83712bc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fec78b0f-809a-15de-5c54-996f480eb4eb@amd.com>
Date: Tue, 14 Jan 2020 17:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <04f6d680-02ff-7526-adb4-4d44e83712bc@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.12 via Frontend Transport; Tue, 14 Jan 2020 16:23:31 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf5d8e46-27ca-453f-2098-08d7990e1926
X-MS-TrafficTypeDiagnostic: DM5PR12MB1707:|DM5PR12MB1707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1707355DC731C8F3FC268EDA83340@DM5PR12MB1707.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(86362001)(52116002)(5660300002)(31686004)(16526019)(31696002)(53546011)(186003)(66574012)(2616005)(8676002)(110136005)(4326008)(6486002)(81156014)(66476007)(2906002)(6666004)(66946007)(316002)(36756003)(66556008)(8936002)(81166006)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1707;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z87W+9gb2eRwW1Ogv7TPz/SxUxqeGAbn0v2glkVtXRgCWE3ROHpV5b3FtVM0RSY7GCwpbku4dRlNRywUaKJWuKhl8dqTkbO61S8r6aUEV480kZBMqrUhwPsLZPBxwrZqhfEHW7AOJmtnPIj3+69vK12jyB5fe0dJG/wzXrx+YLY7hbhI3XZT3jWM2xtokSE02O6Nb7A2q2OdWpZbknQUFbD81TP7aqGfmRb5aeORpC/Pb1rxrcdIqOk/hVHixm6xRM2J8bcXO20J1wO5GktRBZlBrlMPwHv8eJCkDQkqdHQ/S8zdkvbZihlWOVCDqPP2g/DP9mTrCtPREVmkNAK2qESU1+H8bb/+5/JfCm5XKtqDsKNYehd24wuGfiV0clm/VsyzIZlkRRmaZ91RBHFMEudQRrGQ2bRGsbgQxo6xS2zZxxv5MLkUltgPEmvBLjJa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5d8e46-27ca-453f-2098-08d7990e1926
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 16:23:32.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdrsexozU8ndSNu+x2Zv3YE2iLvxq7FJ67Wk3oLtzFKZl/48wYgfkXmYq3Mq3B6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
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
 pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDEuMjAgdW0gMTc6MjAgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxLzE0LzIwIDU6MDEg
UE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE0LjAxLjIwIHVtIDE2OjQzIHNjaHJp
ZWIgTmlybW95IERhczoKPj4+IEpvYnMgc3VibWl0dGVkIGluIGFuIGVudGl0eSBzaG91bGQgZXhl
Y3V0ZSBpbiB0aGUgb3JkZXIgdGhvc2Ugam9icwo+Pj4gYXJlIHN1Ym1pdHRlZC4gV2UgbWFrZSBz
dXJlIHRoYXQgYnkgY2hlY2tpbmcgZW50aXR5LT5qb2JfcXVldWUgaW4KPj4+IGRybV9zY2hlZF9l
bnRpdHlfc2VsZWN0X3JxKCkgc28gdGhhdCB3ZSBkb24ndCBsb2FkYmFsYW5jZSBqb2JzIHdpdGhp
bgo+Pj4gYW4gZW50aXR5Lgo+Pj4KPj4+IEJ1dCBiZWNhdXNlIHdlIHVwZGF0ZSBlbnRpdHktPmpv
Yl9xdWV1ZSBsYXRlciBpbiAKPj4+IGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2IoKSwKPj4+IHRo
ZXJlIHJlbWFpbnMgYSBvcGVuIHdpbmRvdyB3aGVuIGl0IGlzIHBvc3NpYmUgdGhhdCBlbnRpdHkt
PnJxIG1pZ2h0IAo+Pj4gZ2V0Cj4+PiB1cGRhdGVkIGJ5IGRybV9zY2hlZF9lbnRpdHlfc2VsZWN0
X3JxKCkgd2hpY2ggc2hvdWxkIG5vdCBiZSBhbGxvd2VkLgo+Pgo+PiBOQUssIGNvbmN1cnJlbnQg
Y2FsbHMgdG8gCj4+IGRybV9zY2hlZF9qb2JfaW5pdCgpL2RybV9zY2hlZF9lbnRpdHlfcHVzaF9q
b2IoKSBhcmUgbm90IGFsbG93ZWQgaW4gCj4+IHRoZSBmaXJzdCBwbGFjZSBvciBvdGhlcndpc2Ug
d2UgbWVzcyB1cCB0aGUgZmVuY2Ugc2VxdWVuY2Ugb3JkZXIgYW5kIAo+PiByaXNrIG1lbW9yeSBj
b3JydXB0aW9uLgo+IGlmIEkgYW0gbm90IG1pc3Npbmcgc29tZXRoaW5nLCBJIGRvbid0IHNlZSBh
bnkgbG9jayBzZWN1cmluZyAKPiBkcm1fc2NoZWRfam9iX2luaXQoKS9kcm1fc2NoZWRfZW50aXR5
X3B1c2hfam9iKCkgY2FsbHMgaW4gCj4gYW1kZ3B1X2NzX3N1Ym1pdCgpLgoKU2VlIG9uZSBzdGVw
IHVwIGluIHRoZSBjYWxsIGNoYWluLCBmdW5jdGlvbiBhbWRncHVfY3NfaW9jdGwoKS4KClRoaXMg
aXMgbG9ja2luZyB0aGUgcGFnZSB0YWJsZXMsIHdoaWNoIGFsc28gbWFrZXMgYWNjZXNzIHRvIHRo
ZSBjb250ZXh0IAphbmQgZW50aXRpZXMgbXV0dWFsIGV4Y2x1c2l2ZToKPiDCoMKgwqDCoMKgwqDC
oCByID0gYW1kZ3B1X2NzX3BhcnNlcl9ib3MoJnBhcnNlciwgZGF0YSk7Ci4uLgo+IMKgwqDCoMKg
wqDCoMKgIHIgPSBhbWRncHVfY3Nfc3VibWl0KCZwYXJzZXIsIGNzKTsKPgo+IG91dDoKCkFuZCBo
ZXJlIHRoZSBwYWdlIHRhYmxlcyBhcmUgdW5sb2NrZWQgYWdhaW46Cj4gwqDCoMKgwqDCoMKgwqAg
YW1kZ3B1X2NzX3BhcnNlcl9maW5pKCZwYXJzZXIsIHIsIHJlc2VydmVkX2J1ZmZlcnMpOwoKUmVn
YXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4gUmVnYXJkcywKPgo+IE5pcm1veQo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
