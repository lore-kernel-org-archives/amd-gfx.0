Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C472C3F2CD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA5520838
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kl4RPn+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA5520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9806EA74;
	Tue,  3 Mar 2020 14:26:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 466C76EA74
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 14:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY7rHZryiHXDfp8W1lxui/JPnd3/USC1gFNnOirgoJaIDhtDB6UyVdb++I3969vRxC5GLyO5k3yuQRY8CMkPjIq0avYCFde30z/5sP8uEdxpFIDLOeyfQLLIPdd1fFCz5GXaQK7UcRYiztspZf+rLMfL/zlcgciCQUkjQqjGAK8KOv9yaWzbTRhgpRPSnRXBbWv4ezgMn9ynQRyzD8kTUbXNZLmLOWoU8CAVbS7UDX7uXz4FyYxIuOz5MMC6NVYiPqG5ml8TOhsit1CqG5HX7+8vwjOkP4yFvYl7wsaRCSOo0eQldHHmWKZgRUoKdfyZpRRtoxn+toejP10w5nciNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw2CNjdgzpIDD2BeeSY1I5vurqdYPkd+choXB5sgSTo=;
 b=m4jx/ch8zaYNPTN1UlHtsCEaVjcJ+V0YbraqY/raQPisLvyFLcUUj/xpykgUZiQbSgzI9en63MadQ5RKROOq6aTW4inn1RcpUL8vZtYFRwNPgdZyDIZIHT2Ujfhh3QMmxVOYFXKQNZwJJ65uBtCMSN1LUIdB/FT8vis+oh+N+HU0QqZWXXklglp78a6qcw1Iu39WcNDfJL9VLSfiYfGpz0UzHYqt1bm/rpfInN2rsoU3rIeq4X/UzjyiopEQ7Jg7xLztm6yepxO+uBJrRzMTR+zC+YhZhFIZ0wvstJPT8iculwtcp57bMltU/emGerK30n5A4g4BiR6bh7/IoxUEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw2CNjdgzpIDD2BeeSY1I5vurqdYPkd+choXB5sgSTo=;
 b=Kl4RPn+vyfRdIVtNpvHaBsJ3GBTVs7eWLavc7ZFpOVBkGf6GizV7oatxQqpbFPQUK71NzqKNdgaIrRxYCD17yiJmCH1ycLu3K9+6mMtB/eQwuEtGNPmbHuv1KTCnOBH135CimIqItMm72x6usza5OfFFajaI6PpBYM4GnlLX1+0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1371.namprd12.prod.outlook.com (2603:10b6:3:78::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 14:26:26 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 14:26:26 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <478f74f6-db21-0e52-9b19-e968d2fa6924@amd.com>
Date: Tue, 3 Mar 2020 15:29:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0053.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::30) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.76] (217.86.99.124) by
 AM0PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:208:aa::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Tue, 3 Mar 2020 14:26:24 +0000
X-Originating-IP: [217.86.99.124]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81bdbb9f-8250-4b7f-ba4c-08d7bf7edb1f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1371:|DM5PR12MB1371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1371E96250F8B11F9F08A7788BE40@DM5PR12MB1371.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(31686004)(316002)(110136005)(5660300002)(36756003)(478600001)(81156014)(8676002)(81166006)(16576012)(4326008)(2906002)(6486002)(8936002)(2616005)(956004)(66476007)(6666004)(66556008)(66946007)(52116002)(16526019)(31696002)(53546011)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1371;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1grvMHsHyL5d3nuRyQn+iOFbythW4rOhSaTsm5oynWvgAxiokyNBOq3uEuFolNrYNFbaUcXe1lVhUOwxit3BSxoCsRGRrKzEpoqF77wKmJj9saX57dSSROLP/24nHv4H+/5cxOKODc/5KA3PA3lmX48uXj+WnOZe0iV8Ne0bKep4KSXAt8RraFY0iYTX4u0lUedC4S40g44q3o3+gNi3zGViB5TcT2H97gGRnEqLq3zjB/7E6BWElqOM60Ck0HR8DKnV28IPfeww4MMe0U/MlkaUnWFfrELbZbd8CvtZ6LUM1t+6M90VQttUhKBRIt0VoqAPPi6FC3crE8Fx+5R2LMWA5YwB+gmft1q2XzA3OXOsC9/MkN+h39f49xjhMdo3WEet/7gi0wm4uRJHC2xoo3eofCsnC/18xny8sIlPgAixXH1kyAcPHHnOEl1aZmvb
X-MS-Exchange-AntiSpam-MessageData: 7KDhnGFWUAiE3EkWfbTKOqwhSOeVo2FJKgLkLUicI7tlaS/hFRpHh5LjRqTjatzCxrZX+6G6yX9i0u0voz+CiTmgbakFJWbrsrSnaZsrNeSbBbOU5ag1Rblhf7Df3U84HmaQEqpLRUVKZiNXW+TZ1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bdbb9f-8250-4b7f-ba4c-08d7bf7edb1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 14:26:26.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: su8zmZ9Cm9v9kS1KmaZaJrSJs6XzsuqpZU/DSQDtbev5pumSfYqGtb0TEAQ0ycsGCHAWzMiHulv++Xtwuhyf5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1371
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

Ck9uIDMvMy8yMCAzOjAzIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAzLjAzLjIw
IHVtIDEzOjUwIHNjaHJpZWIgTmlybW95IERhczoKPj4gW1NOSVBdCj4+IMKgIHN0cnVjdCBhbWRn
cHVfbWVjIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvwqDCoMKgICpocGRfZW9wX29i
ajsKPj4gwqDCoMKgwqDCoCB1NjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhwZF9lb3BfZ3B1X2Fk
ZHI7Cj4+IEBAIC0yODAsOCArMjkwLDkgQEAgc3RydWN0IGFtZGdwdV9nZnggewo+PiDCoMKgwqDC
oMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fZ2Z4X3NjaGVkOwo+PiDCoMKg
wqDCoMKgIHVuc2lnbmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fZ2Z4X3JpbmdzOwo+PiDC
oMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyBjb21wdXRlX3JpbmdbQU1ER1BVX01BWF9DT01Q
VVRFX1JJTkdTXTsKPj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgCj4+ICoqY29t
cHV0ZV9wcmlvX3NjaGVkW0FNREdQVV9HRlhfUElQRV9QUklPX01BWF07Cj4+IMKgwqDCoMKgwqAg
c3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpjb21wdXRlX3NjaGVkW0FNREdQVV9NQVhfQ09NUFVU
RV9SSU5HU107Cj4+IC3CoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9j
b21wdXRlX3NjaGVkOwo+PiArwqDCoMKgIHVpbnQzMl90IG51bV9jb21wdXRlX3NjaGVkW0FNREdQ
VV9HRlhfUElQRV9QUklPX01BWF07Cj4+IMKgwqDCoMKgwqAgdW5zaWduZWTCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG51bV9jb21wdXRlX3JpbmdzOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVf
aXJxX3NyY8KgwqDCoMKgwqDCoMKgIGVvcF9pcnE7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdw
dV9pcnFfc3JjwqDCoMKgwqDCoMKgwqAgcHJpdl9yZWdfaXJxOwo+Cj4gV2VsbCBteSBxdWVzdGlv
biBpcyB3aHkgd2Ugd2UgbmVlZCBjb21wdXRlX3ByaW9fc2NoZWQgaGVyZT8KClRoaXMgb25lIGlz
IHNvIHRoYXQgSSBjYW4gbGV2ZXJhZ2Ugc2luZ2xlIHNjaGVkIGFycmF5IApjb21wdXRlX3NjaGVk
W0FNREdQVV9NQVhfQ09NUFVURV9SSU5HU10KCnRvIHN0b3JlIGJvdGggcHJpb3JpdHnCoCBzY2hl
ZCBsaXN0wqAgaW5zdGVhZCBvZgoKc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyIAoqY29tcHV0ZV9z
Y2hlZFtBTURHUFVfR0ZYX1BJUEVfUFJJT19NQVhdW0FNREdQVV9NQVhfQ09NUFVURV9SSU5HU107
CgpJIGd1ZXNzIHRoaXMgbWFrZSBjdHggY29kZSB1bm5lY2Vzc2FyaWx5IGNvbXBsZXguCgo+Cj4g
Q2FuJ3Qgd2UganVzdCBkZXNpZ24gdGhhdCBhczoKPiBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIg
Cj4gKmNvbXB1dGVfc2NoZWRbQU1ER1BVX0dGWF9QSVBFX1BSSU9fTUFYXVtBTURHUFVfTUFYX0hJ
X0NPTVBVVEVfUklOR1NdOwo+IHVpbnQzMl90IG51bV9jb21wdXRlX3NjaGVkW0FNREdQVV9HRlhf
UElQRV9QUklPX01BWF07CldoYXQgc2hvdWxkIGJlIHRoZSB2YWx1ZSBvZiBBTURHUFVfTUFYX0hJ
X0NPTVBVVEVfUklOR1MgPwo+Cj4gSSBtZWFuIHRoZSBkcm1fZ3B1X3NjaGVkdWxlciAqIGFycmF5
IGRvZXNuJ3QgbmVlZHMgdG8gYmUgY29uc3RydWN0ZWQgCj4gYnkgdGhlIGNvbnRleHQgY29kZSBp
biB0aGUgZmlyc3QgcGxhY2UuCkRvIHlvdSBtZWFuIGFtZGdwdV9jdHhfaW5pdF9zY2hlZCgpIHNo
b3VsZCBiZWxvbmcgdG8gc29tZXdoZXJlIGVsc2UgbWF5IApiZSBpbiBhbWRncHVfcmluZy5jID8K
Pgo+IE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
