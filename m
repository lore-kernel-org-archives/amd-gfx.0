Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8BCC352BE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 12:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E452083E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 12:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D42KyVrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E452083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A365B6EBCD;
	Fri, 17 Apr 2020 12:09:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1F96EBC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 12:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZfep/d5JzKgBFlSwzKwhiLN08ipPYL1hWFDrvNn+k5xAMp8dZTofeIJMErxWqv6P63CsdmXgr/wfJ8vSske4UZ5E6HVgsnaZN9uVrDY+A2L1da/QocxacD8zEQd16B+LWDLdz0QDs8x6ozz7vUrJwqGDoS/EbkQebc/1CbaYHdlIEp1toB0WxrpJBD32Ya56qsqEJBQdTFG62FYTi7iKj6q2a3xbyinwYMJcvBy/cahavyfHaKqxjBUDB23oqHJ403lcfiWYCItkWBjixowYfjbroFn88hcqEBL4FqtGC9Cyyc/zR5N35nANWsYO4rjHW7Rkad/1TOuI4N51o2nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aICmvI+PHCEjnombyhHBbLYJttEojEViaDAd9ZLgtG8=;
 b=I3TH3HGmVNncmdhG7zwhzGu9lwDj2DIXSg9JkeCPxg/DmGOuE3CSH5kpz1Gupca5IxSWPKeIxFJb4190dr5Fd1H2EtocdsDJESib8ga63xKzyTfjPWEpgCVfLuTNu9S9I21wp4Pdl0khDzHDA2snICQ1P57HwnTtBzaSLo51qfPkaa0uf7BQQ3nlkQjqblT5M2FHaBxI+nB9kwkQSEmgZ4tw5KTS6WK1f0vob8MPdupUaLXUZfQ0HSaxAoc5Jh+6gmbo2U0Z6eYF//bsVwjqWkGPeo8GaA6OqwubKIh9oyi+xHK4KFgj+FGl7qlQrwjVSW1v/z+vLrJbT+EVU0c2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aICmvI+PHCEjnombyhHBbLYJttEojEViaDAd9ZLgtG8=;
 b=D42KyVrYrfCamz1RWw+fpnVWD/KxMHcsxRC3KjpLH3oOhMzMZTGMQLUu+KUXRVU+3vWVUI/AevAJqXVGWlrtr93Dhs2rSGRAEUumjjd7Vj+WJ/cU1Ii9H111b97mBuN1NEhs7YnpgAAQAFKORL41ej0fio1M9+OykUNDDNyDoHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 by MN2PR12MB3055.namprd12.prod.outlook.com (2603:10b6:208:d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 12:09:52 +0000
Received: from MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::cc36:ee17:c768:8427]) by MN2PR12MB4408.namprd12.prod.outlook.com
 ([fe80::cc36:ee17:c768:8427%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 12:09:51 +0000
Subject: Re: [PATCH 05/35] drm/amd/display: Remove byte swapping for dmcub abm
 config table
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
 <20200416234044.2082886-6-Rodrigo.Siqueira@amd.com>
 <MN2PR12MB4488B2003904110CAE92E166F7D90@MN2PR12MB4488.namprd12.prod.outlook.com>
 <c3f3fef6-6c35-7201-c75e-2a72dca42350@gmail.com>
 <9442cdf7-4aef-7831-2609-4610b09e15b8@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1bd26e82-3afe-192f-36c0-01d836329196@amd.com>
Date: Fri, 17 Apr 2020 14:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <9442cdf7-4aef-7831-2609-4610b09e15b8@daenzer.net>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To MN2PR12MB4408.namprd12.prod.outlook.com
 (2603:10b6:208:26c::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 12:09:50 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd87ccea-bb33-4f17-6bc5-08d7e2c83b8d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3055:|MN2PR12MB3055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3055B25B79728202692B437483D90@MN2PR12MB3055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4408.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(478600001)(52116002)(16526019)(186003)(6666004)(2616005)(5660300002)(4744005)(8676002)(110136005)(316002)(54906003)(4326008)(66946007)(66556008)(66476007)(6486002)(81156014)(31686004)(86362001)(36756003)(53546011)(31696002)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4VBrVFxl1RTudEPuobvOGx63exnWtFO7NJzHsSlMVkK3Zkn8U3/TZOyvAzAS3Uo5umm+z5tqTgaYaXSC/mylo0VKtmQb/xS1jVJ4cT5Hdsna18KNuKPrkg2v6qYo20dKIEE3n8o/wyn3F7bcaMuppq2iyS7CO08Xui5+mm4+L5JOirvsUcq0rK/Rb/+OLsxF44RxA3lGE0mayFRSzVuaJb59wOLLkNoppzg/S8Qxv3W+o4jRvqAcr6WoF2RGdKTJ+7T1pE6M+UkDM9+QOeNGmcVTnBFCRVvt1Ga8ZE1YeTWlUMetfmfV+doy/ogx72Z4bw5u7o5myJOdqxoy7LqSThkEABr/BySkIxJSWszogzpo7l6uQ3NoSnWEtG/Epx6HJNrUO+FnTVe0HelKMidUq0avB1l4d8A8Di9IfGWY9FuBWMyb/0O8EBlE+2GJhfZ
X-MS-Exchange-AntiSpam-MessageData: MhImpNWMXvQLseaWcJqRrEvTKTV0fiuOtDL1nmai6F6M4Fd+hReGmURM9TzfjEouzfpa/BzwWnxrpBSYi9HkU2PetMQr5ehdx9Vq4EfLmFxGKB0Go8FfhMzJ62Q6yrYZ7uY8yveJvTrqta/Iz8U45Y1Ys2YWYgSy1fqp1ut4Ob4VT8HEuAvycA2Mxd//ZNKjJVCpX1TM5PuQFEXxx8l0iw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd87ccea-bb33-4f17-6bc5-08d7e2c83b8d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 12:09:51.8815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKWrr73IJ5YbPYvfdnWBJe1zz62iUfkPwqK6R5fvo3ukBj17S9ihJZviSd9c9thj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3055
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, "Wood,
 Wyatt" <Wyatt.Wood@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDQuMjAgdW0gMTI6NDMgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDIwLTA0
LTE3IDExOjIyIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFncmVlZCwganVzdCB3
YW50ZWQgdG8gcmVwbHkgYXMgd2VsbCBzaW5jZSBJIHRoaW5rIHNvbWV0aGluZyBpcyBub3QKPj4g
Y29ycmVjdGx5IHVuZGVyc3Rvb2QgaGVyZS4KPj4KPj4gVGhlIGNwdV90b19iZTE2KCkgYW5kIGJl
MTZfdG9fY3B1KCkgZnVuY3Rpb25zIHdvcmsgZGlmZmVyZW50IGRlcGVuZGluZwo+PiBvbiB3aGlj
aCBhcmNoaXRlY3R1cmUvZW5kaWFuZXNzIHlvdXIgYXJlLgo+Pgo+PiBTbyB0aGV5IHNob3VsZCBi
ZSBhIE5PLU9QIG9uIHg4NiBpZiBldmVyeXRoaW5nIGlzIGRvbmUgcmlnaHQuCj4gVGhlICpiKmUg
bWFjcm9zIGFyZW4ndCBOT1BzIG9uIGxpdHRsZSBlbmRpYW4gYXJjaGl0ZWN0dXJlcyBsaWtlIHg4
NiwKPiB0aGV5IGFyZSBvbiBiaWcgZW5kaWFuIGFyY2hpdGVjdHVyZXMuIFZpY2UgdmVyc2EgZm9y
IHRoZSAqbCplIG1hY3Jvcy4KClllYWgsIHRoYXQncyB3aGF0IEkgbWVhbnQgd2l0aCAiaWYgZXZl
cnl0aGluZyBpcyBkb25lIHJpZ2h0IiA6KQoKSSB1c3VhbGx5IGNhbid0IHJlbWVtYmVyIHdoYXQg
ZG9lcyB3aGF0IHdpdGggdGhvc2UgZnVuY3Rpb25zLgoKQ2hyaXN0aWFuLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
