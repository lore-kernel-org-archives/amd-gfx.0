Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77511C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 13:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B3E21739
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 13:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rQwk3yJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B3E21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090986E287;
	Mon,  2 Mar 2020 13:10:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 759B46E287
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 13:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgvYhrZOcbvL6/hx6ZKotFoyi5mQ4chDTeA9gw2PVwLma2GN4Cr/cz7ZxNfxCri/TUIEMC1RisOOjrtY0PmHOIk0VMwSEcoBicboDLf6QgpHzJAcVM36LLSYhdhBw6a51wiOlOYv0dDUEGYOe0aMcdYtBIHBrxCsFBiEoeMArHX/cmmz4UbvHmK27GWlYw3WzkV3foEOO1k7mbiOZEW7/fcBjAbIWGfN77geA3h+itAyPawuOP+q2NKF01Jyy9O7kJWWXNiwyKqyxXqMYcXFMRASm4aNT71HS0+/+yYdOBF5hKSvQ/5cUwkYHhBZ0aHktO+c1U4Bh/A0c5JjnGo2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CToSgMZsBTARVWZ8kuOK/FaR3u1B+15IXfzmRT38y5E=;
 b=SzirSI6nODizrkLSs0xhON3JrsfQ315w/+qVyc7k1RtYIsZj4kB2669gjWwtLlNo4LmxLH0wj3+rldLQjBI6BMKUwTeKexmSHkY/HRPDPEQLd3RzSLaQP7jOUG+ZcfBz5altGSRR1HfozbrBFYmatyK/r7RT9bf8KkDVY0nEA05N+Nl6h/HJbZ0ktO2ARA3trJKqlhqO2vy5FvtwiSrv2ZPQzhDVOhS0G9FwQMM20vWdSlyniOqLSAABnDspC4lMYvqMbiTsYyoZctCEVu8o/i1qFMFO3KFGORFtm0M3AWdCISHmt2KV1k7SjXeXpaaCRomYh//6Z1rbcyIkpuk5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CToSgMZsBTARVWZ8kuOK/FaR3u1B+15IXfzmRT38y5E=;
 b=rQwk3yJ+IPQ5YW3LBVF8LOiHXXUYo951MCatqmNXcNzz5kQ80UJb212w5OGyL/sEB2Gg7rVZyGoPCAD1z4e9bXPHFqEc/Qy1yKUtg5oEWoJAAzEwoJCg11OP9Rmgqb7vAn/0Esc204CV4NMvCfK5gopEjPkyGKPGY1cAf8F9Co4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Pierre-eric.Pelloux-prayer@amd.com; 
Received: from DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) by
 DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Mon, 2 Mar 2020 13:10:29 +0000
Received: from DM5PR12MB2424.namprd12.prod.outlook.com
 ([fe80::65a1:fafc:df2d:3c6c]) by DM5PR12MB2424.namprd12.prod.outlook.com
 ([fe80::65a1:fafc:df2d:3c6c%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 13:10:29 +0000
Subject: Re: Few TMZ BO move patches
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200302121759.13003-1-christian.koenig@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Message-ID: <f09a2221-4966-d110-fd07-93ea1cd8cd98@amd.com>
Date: Mon, 2 Mar 2020 14:10:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <20200302121759.13003-1-christian.koenig@amd.com>
Content-Language: fr
X-ClientProxiedBy: PR3P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::24) To DM5PR12MB2424.namprd12.prod.outlook.com
 (2603:10b6:4:b7::34)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.234] (109.190.135.109) by
 PR3P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 13:10:27 +0000
X-Originating-IP: [109.190.135.109]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8b52d6f-57df-49ea-781f-08d7beab149b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440C19779CAE85AF8B101148DE70@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(36756003)(6486002)(31696002)(6666004)(86362001)(8676002)(8936002)(966005)(81156014)(81166006)(31686004)(478600001)(956004)(2616005)(66946007)(66476007)(66556008)(316002)(16576012)(55236004)(26005)(16526019)(53546011)(4744005)(2906002)(52116002)(186003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkHCZhxrMucqymLb49sb1d4D9seozUGd9ZmH5GNlfcdqX2zi29y7IqePMszAm6oQLfnseWvEPX09BYcrFK5sOLMkpuIezgfBCbQF39MsuuYOMC1qsndOU//cseoB5SEj3cp4wulbbokdwtZDD3LUKcdyU+8WOIU0CeSNI/BfL+4fhuo6rePxKDszHksckZHT/VzTT8R0MCQWXZtDpVbV0nIaSpmWiAyawLYnw8aZIxKlVFlra1SjIo2layT/r6YKT8RQm3C8jY2UwSvo29NIdSIFPs31J2cFsxIY3ips+fh0oK2PKLqFhtYlsZmhM5IdRf0zqGiSairnyey1H1nTIwQ7DjqBVt+hKsn51eZKhLRrEuIHWJvc2AGhA7vNp2rokZpZbtmn7ypyRpafjP0xCnWYgGq8ZaL2hRwWlJy1SLdUTm5gTarblEFG4b3RYuOEZjdyAZkOGMT1yyCHQblFx2MI2CFqVgo2LedNl1C2gPQ=
X-MS-Exchange-AntiSpam-MessageData: iL3JYsG3F8LTDc+Ql9JJGoQrPR9fDcUSk28kDxaxf5Ukso6otWQDQSLtebNu6kiyViwMATmxCGF6YhneZZ+ITDDckOvs1R0vY2WHCYNNhk59FgSXrJACe/kag0opb7uSxFBPS8W9PG4EW0luMl0eOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b52d6f-57df-49ea-781f-08d7beab149b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 13:10:29.2761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb+rswaNlpPMSy1gAq1/596FUyX4wke0+Jx/2DCDKz7E8Mw8CRPLRA/koa1oUq88/J4s0TvWEGbqkac7CtjsyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQ2hyaXN0aWFuLAoKVGhlIDMgcGF0Y2hlcyBhcmU6CiAgIFRlc3RlZC1ieTogUGllcnJlLUVy
aWMgUGVsbG91eC1QcmF5ZXIgPHBpZXJyZS1lcmljLnBlbGxvdXgtcHJheWVyQGFtZC5jb20+CgpS
ZWdhcmRzLApQaWVycmUtRXJpYwoKT24gMDIvMDMvMjAyMCAxMzoxNywgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPiBCZWNhdXNlIG9mIGEgc2hpZnQgaW4gcHJpb3JpdGllcyBJIHdvbid0IHdvcmsg
b24gVE1aIHRoaXMgd2Vlay4KPiAKPiBTbyBhdHRhY2hlZCBhcmUgYSBmZXcgc21hbGxlciBwYXRj
aGVzIEkgYWxyZWFkeSBwcmVwYXJlZCwgYnV0IHRoZSBib3VuY2UgY29weSBmb3Igc3lzdGVtIGV2
aWN0aW9uIGlzIHN0aWxsIG1pc3NpbmcuCj4gCj4gUGF0Y2hlcyBhcmUgdG90YWxseSB1bnRlc3Rl
ZCwgYnV0IEkgYW55Ym9keSBmaW5kIHRoZW0gdXNlZnVsIGZlZWwgZnJlZSB0byB0ZXN0IGFuZCBy
ZXZpZXcgdGhlbS4KPiAKPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPiAKPiAKPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBs
aXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
