Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96079C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6011D24658
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 16:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oOQrIPpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6011D24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5E36E42E;
	Tue, 14 Jan 2020 16:19:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9466E42C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 16:19:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBhauPaPUJ8NCvPupSMKE9l/E9/dW+82ERolHHycikmKLcjyknwBaX354ur2M6PWI9W2U+KTX7RXFYL9noBS6sb3qEe4D4JoWVRxZc90OySxwlNVTCEB4CZZ8yulMqJgfl2W0jp3GH6w4rannSnXCgCSj9oQhqAyTOoJZrdYGjmmXR35JRZtP3GTe6n4AIf/K913ORVxPMXxaQemONhdin2bA4zTzPkB4gxdDm5VyUcykSSSiPQ3+izkDC218VtSo5vIhqAMw24ttfYlN4EXWxe0Lm+tn4ptOL8pL0FAz/wGu5v9BK7L8l33Cf88k+gHRMmLz7AUPV+UV+Eva6eR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlwVthYdxxJo6l88M/RfJqHqg0tfJemXfs7OxehcLnc=;
 b=QO42Sm8xFQ0THaiajkbqFXzYy7fVcSdgoVowf+Ja+ab61CqhGIzbdl9oEV1EYRuG4Hp0bt2skwES3U9yiIr9EFj4iZ3RLQmf8QDDbbxRVySZdEDxmOO5aGAHJgmNpyZKqp+uAT6TFqXuUw64CJxil6nrEQPstuJ5QGbQ1fxem9gC3G0mdJ6lxCmNEskKouQT7+ryIpV5xDc7nM44+p9IQnBgpY1vx+82hOEhtLqqHsKHlCo9AmuzY+cG6zfAiOAyTTX0byzBEqjjgT260ns21myarcCV0nYIC1Htng+QdXRx3rYQanZQtAvNILhWNAyE6uMNUM5IEu86B4i/Q0jVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlwVthYdxxJo6l88M/RfJqHqg0tfJemXfs7OxehcLnc=;
 b=oOQrIPpluK0+u6HVWQvVjZ/A3hju57TFy4hzXlUGV1/qoS9ifIpJLrbN7YDYtyDiy1FhFvPGE0ZvwXIA/TXKZaySf/pksQSqC3g2tNrZ4HewN8l46vh6fQL0yG1wFAZt8J3kAEtx13yv/vwhbKF/xzmevwKr3bY5eTO+YT4D7BA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1850.namprd12.prod.outlook.com (10.175.86.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 16:19:23 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2623.017; Tue, 14 Jan 2020
 16:19:23 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <04f6d680-02ff-7526-adb4-4d44e83712bc@amd.com>
Date: Tue, 14 Jan 2020 17:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f34:3700:cddf:573f:1071:ae40]
 (2003:c5:8f34:3700:cddf:573f:1071:ae40) by
 FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 16:19:22 +0000
X-Originating-IP: [2003:c5:8f34:3700:cddf:573f:1071:ae40]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e486889-24a2-4a2e-c45c-08d7990d84ad
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:|DM5PR12MB1850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18502CC1DD4E87271D8DABFE8B340@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(2616005)(81156014)(31696002)(498600001)(2906002)(81166006)(4326008)(8676002)(6486002)(6666004)(66476007)(36756003)(66946007)(53546011)(66556008)(4744005)(31686004)(5660300002)(52116002)(66574012)(186003)(16526019)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1850;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUhdM7u2Yk0eTcKr6MkZWh1k6lbTvgchL03iU2fAigCATt/v96sN2RDAT06Of4BA8ZjMp8o1bSbezwYq/cEjKTdHTdYkfRkD/53YWYjATk1+OQBZaDYV/bM3cUeT78Js8DxqSPDmyIzj0CXPs6Q0dGHeTmoGobz+VcWhxoma0mysnceUSju+5UsJPRImGyzKllY81V/nAbGD76WT81l7C5lw7wjSaFMwZmDWK21yJpMivQmTobnNEAesoEj0hKsFgX1S60CYrTHwP5l5umWDNLvEraHQUsr4luacuXOJYShBmBkiEqmzoYLGxgSbGVBpmPv0Zkcm47RtzrhtR/rkV5k9S4TBH/OxQygMX94iflFJHnJCGICm09g0tYUeBg/YJvkho6hcCM0kXXnwJvaTCJzzmoSSgKhLnvvoKTQLBgp1xGcnHJ0dhUo1lmWnv64M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e486889-24a2-4a2e-c45c-08d7990d84ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 16:19:23.7368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFq8zMNKfuWczbmR1U7V/28kK1MGA3mVIrm1+FkDozGSdOO3dOPi0A2C9hx2bouoMp48cPk1QDe4I5uscxfrAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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

Ck9uIDEvMTQvMjAgNTowMSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNC4wMS4y
MCB1bSAxNjo0MyBzY2hyaWViIE5pcm1veSBEYXM6Cj4+IEpvYnMgc3VibWl0dGVkIGluIGFuIGVu
dGl0eSBzaG91bGQgZXhlY3V0ZSBpbiB0aGUgb3JkZXIgdGhvc2Ugam9icwo+PiBhcmUgc3VibWl0
dGVkLiBXZSBtYWtlIHN1cmUgdGhhdCBieSBjaGVja2luZyBlbnRpdHktPmpvYl9xdWV1ZSBpbgo+
PiBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycSgpIHNvIHRoYXQgd2UgZG9uJ3QgbG9hZGJhbGFu
Y2Ugam9icyB3aXRoaW4KPj4gYW4gZW50aXR5Lgo+Pgo+PiBCdXQgYmVjYXVzZSB3ZSB1cGRhdGUg
ZW50aXR5LT5qb2JfcXVldWUgbGF0ZXIgaW4gCj4+IGRybV9zY2hlZF9lbnRpdHlfcHVzaF9qb2Io
KSwKPj4gdGhlcmUgcmVtYWlucyBhIG9wZW4gd2luZG93IHdoZW4gaXQgaXMgcG9zc2liZSB0aGF0
IGVudGl0eS0+cnEgbWlnaHQgZ2V0Cj4+IHVwZGF0ZWQgYnkgZHJtX3NjaGVkX2VudGl0eV9zZWxl
Y3RfcnEoKSB3aGljaCBzaG91bGQgbm90IGJlIGFsbG93ZWQuCj4KPiBOQUssIGNvbmN1cnJlbnQg
Y2FsbHMgdG8gCj4gZHJtX3NjaGVkX2pvYl9pbml0KCkvZHJtX3NjaGVkX2VudGl0eV9wdXNoX2pv
YigpIGFyZSBub3QgYWxsb3dlZCBpbiAKPiB0aGUgZmlyc3QgcGxhY2Ugb3Igb3RoZXJ3aXNlIHdl
IG1lc3MgdXAgdGhlIGZlbmNlIHNlcXVlbmNlIG9yZGVyIGFuZCAKPiByaXNrIG1lbW9yeSBjb3Jy
dXB0aW9uLgppZiBJIGFtIG5vdCBtaXNzaW5nIHNvbWV0aGluZywgSSBkb24ndCBzZWUgYW55IGxv
Y2sgc2VjdXJpbmcgCmRybV9zY2hlZF9qb2JfaW5pdCgpL2RybV9zY2hlZF9lbnRpdHlfcHVzaF9q
b2IoKSBjYWxscyBpbiAKYW1kZ3B1X2NzX3N1Ym1pdCgpLgoKClJlZ2FyZHMsCgpOaXJtb3kKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
