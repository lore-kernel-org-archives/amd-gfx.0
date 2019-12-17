Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB5C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C5A206E0
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 21:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fuItz9f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C5A206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA3C6E128;
	Tue, 17 Dec 2019 21:14:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A8566E128
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 21:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMhyFrywDz4YJ5ee5/JX3mrc4eDoHL9OuW3Jyga4WMTS/4HnkSMjXT6+Y2E9vOjvO81hxEVhUzfMqfhGSmP74hRR/mZh37/nCBwzTCqIalsBdUNaAVWi1TwsYS8g+m7LuVXM2jYQ/Ia5VnF82nGb7m97YhCnZgZNHIuCvuvUMCSWB2AAJiBS9u8ZC2WZclhAo1B0ldgOst1UdI6qi5p7xswqlzAp81NnnweD2fkITvddDqdlnthH+3dyrVHyQHtNssWKpT/TOYPr27zQz2exbxSAj2e7Om7hTMfPaPWZNp2O7/GmUfXJBJhOD6kPmxbCpfi22iQgisq9VAWJ6GuY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2imMSLq/x6iO3x+c1qvv9IDLiHfGdqNbYMaJvXWUiQ=;
 b=glWIQjP2ZJIjdgk80Y+fyKA9cGO40hTQewbW0YdUgvvtKWXO1nnPGEFlejDxYmsbrJX4nL5DpEs/oX4qV6/zy0b7QprhXC/toQOQg4xVLOQzPVyCYgOARluylBkvIQVU4a9gOY9p0jBTs7KSoN70jzbZCWtNvZOvlYEFvMfRGDeaCX543I7J8wjVXsV5JYYOjjH2YnVEVSlhgj5Ce5S0AnUOsVUUpm+YbVElutg79otSxUZn4+UeVE3Q95bhYA02G8L2Mo8LP0MNGS7/Bok/hfQzbT1U9PRi/mmT+5xTxoXkFE90qibsjZrYJJqz3hupalEtOE/qCkDATJRX2FI/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2imMSLq/x6iO3x+c1qvv9IDLiHfGdqNbYMaJvXWUiQ=;
 b=fuItz9f0LVCKl9wU8eronYbg3ZpGvFNthmWpvS9QEha03HugGXf4Tl7Ec4gq/0TOybQXvk3n3FgSXICDF47IOZWRTHW0ndB1fjIdRfEuVTW7t3KBoMd4V6RIXskdFZInefOh6y7ZE9xf6ZgVlVrZS2WLQkysnVhvp3HSehb/cfk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3657.namprd12.prod.outlook.com (10.255.76.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Tue, 17 Dec 2019 21:14:20 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 21:14:20 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
To: amd-gfx@lists.freedesktop.org
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
 <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d49489d0-5536-b9e1-c067-23aa85502f04@amd.com>
Date: Tue, 17 Dec 2019 16:14:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [142.116.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98c32769-3364-467d-e93e-08d783361536
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3657D99ED68C809C89555A4292500@DM6PR12MB3657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(189003)(199004)(31696002)(45080400002)(478600001)(966005)(66556008)(6486002)(6916009)(4001150100001)(81166006)(44832011)(66476007)(316002)(2906002)(8676002)(31686004)(53546011)(36756003)(6512007)(5660300002)(81156014)(52116002)(186003)(2616005)(26005)(66946007)(8936002)(86362001)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3657;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uj320iKzyF3FARCAGS2o/K1Qj0G5FtCfHibEcXBBGSti/EgoSCrzE9PPyeF+3gMc5afm/KQiR8f8w84Jo0TZdzF00uDFmYFfiGMZ17H4ApUMGa8qFknnldoY2Fe17+oMegnj/M4re+CwbryOBYWoEKi7oR3VKpjScvRC8GTz7eDERESZ2T5OtN4SDU5UhxpcKuNWx4Pe6QnrnkPsLc/9CprC+L1koNHsXHnCYpZVrZt0g6caS8QjkGRUfHxRVxSqFxoReRmq1ULRFs1Q6TIOO1T3PJVhxbmKZIbSgfitb3xy2FLNbF3j2Q/MoHp2P5fF+mMlwjKQ4FLgnpQ9MLaFoEB01Aipaj7unUXMd9k8BYc85aHm/7ZbP9kFrUMSIx1b1OQnA8HXm4GVYb/dVfaBuRCX3/73oDc4P3fEC4nHYjnvKVjgMzZGxJiYaLcb82Y8ogurQJzac/sHu86kBap75Hpa/Mq0JTQruM3euIPLRaY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c32769-3364-467d-e93e-08d783361536
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 21:14:20.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwfjTBCcEsEhItlGZjGS2Og/U5vk+7ZCOAK6WAaexaa8V403Mi+a6fklfXD+orCNVArG06V+ghFQbyU+aFdKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3657
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSBhZ3JlZS4gUmVtb3ZpbmcgdGhlIGNhbGwgdG8gcHJlLXJlc2V0IHByb2JhYmx5IGJyZWFrcyBH
UFUgcmVzZXQgZm9yIEtGRC4KCldlIGNhbGwgdGhlIEtGRCBzdXNwZW5kIGZ1bmN0aW9uIGluIHBy
ZS1yZXNldCwgd2hpY2ggdXNlcyB0aGUgSElRIHRvIApzdG9wIGFueSB1c2VyIG1vZGUgcXVldWVz
IHN0aWxsIHJ1bm5pbmcuIElmIHRoYXQgaXMgbm90IHBvc3NpYmxlIGJlY2F1c2UgCnRoZSBISVEg
aXMgaGFuZ2luZywgaXQgc2hvdWxkIGZhaWwgd2l0aCBhIHRpbWVvdXQuIFRoZXJlIG1heSBiZSAK
c29tZXRoaW5nIHdlIGNhbiBkbyBpZiB3ZSBrbm93IHRoYXQgdGhlIEhJUSBpcyBoYW5naW5nLCBz
byB3ZSBvbmx5IAp1cGRhdGUgdGhlIEtGRC1pbnRlcm5hbCBxdWV1ZSBzdGF0ZSB3aXRob3V0IGFj
dHVhbGx5IHNlbmRpbmcgYW55dGhpbmcgdG8gCnRoZSBISVEuCgpSZWdhcmRzLAogwqAgRmVsaXgK
Ck9uIDIwMTktMTItMTcgMTA6MzcsIHNoYW95dW5sIHdyb3RlOgo+IEkgdGhpbmsgYW1ka2ZkIHNp
ZGUgZGVwZW5kcyBvbiB0aGlzIGNhbGwgdG8gc3RvcCB0aGUgdXNlciBxdWV1ZSwgCj4gd2l0aG91
dCB0aGlzIGNhbGwsIHRoZSB1c2VyIHF1ZXVlIGNhbiBzdWJtaXQgdG8gSFcgZHVyaW5nIHRoZSBy
ZXNldCAKPiB3aGljaCBjb3VsZCBjYXVzZSBoYW5nIGFnYWluIC4uLgo+IERvIHdlIGtub3cgdGhl
IHJvb3QgY2F1c2Ugd2h5IHRoaXMgZnVuY3Rpb24gd291bGQgcnVpbiBNRUMgPyBGcm9tIHRoZSAK
PiBsb2dpYywgSSB0aGluayB0aGlzIGZ1bmN0aW9uIHNob3VsZCBiZSBjYWxsZWQgYmVmb3JlIEZM
UiBzaW5jZSB3ZSBuZWVkIAo+IHRvIGRpc2FibGUgdGhlIHVzZXIgcXVldWUgc3VibWlzc2lvbiBm
aXJzdC4KPiBJIHJlbWVtYmVyZWQgdGhlIGZ1bmN0aW9uIHNob3VsZCB1c2UgaGlxIHRvIGNvbW11
bmljYXRlIHdpdGggSFcgLCAKPiBzaG91bGRuJ3QgdXNlIGtpcSB0byBhY2Nlc3MgSFcgcmVnaXN0
ZXJtLMKgIGhhcyB0aGlzIGJlZW4gY2hhbmdlZCA/Cj4KPgo+IFJlZ2FyZHMKPiBzaGFveXVuLmxp
dQo+Cj4KPiBPbiAyMDE5LTEyLTE3IDU6MTkgYS5tLiwgTW9uayBMaXUgd3JvdGU6Cj4+IGlzc3Vl
czoKPj4gTUVDIGlzIHJ1aW5lZCBieSB0aGUgYW1ka2ZkX3ByZV9yZXNldCBhZnRlciBWRiBGTFIg
ZG9uZQo+Pgo+PiBmaXg6Cj4+IGFtZGtmZF9wcmVfcmVzZXQoKSB3b3VsZCBydWluIE1FQyBhZnRl
ciBoeXBlcnZpc29yIGZpbmlzaGVkIHRoZSBWRiBGTFIsCj4+IHRoZSBjb3JyZWN0IHNlcXVlbmNl
IGlzIGRvIGFtZGtmZF9wcmVfcmVzZXQgYmVmb3JlIFZGIEZMUiBidXQgdGhlcmUgaXMKPj4gYSBs
aW1pdGF0aW9uIHRvIGJsb2NrIHRoaXMgc2VxdWVuY2U6Cj4+IGlmIHdlIGRvIHByZV9yZXNldCgp
IGJlZm9yZSBWRiBGTFIsIGl0IHdvdWxkIGdvIEtJUSB3YXkgdG8gZG8gcmVnaXN0ZXIKPj4gYWNj
ZXNzIGFuZCBzdHVjayB0aGVyZSwgYmVjYXVzZSBLSVEgcHJvYmFibHkgd29uJ3Qgd29yayBieSB0
aGF0IHRpbWUKPj4gKGUuZy4geW91IGFscmVhZHkgbWFkZSBHRlggaGFuZykKPj4KPj4gc28gdGhl
IGJlc3Qgd2F5IHJpZ2h0IG5vdyBpcyB0byBzaW1wbHkgcmVtb3ZlIGl0Lgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDIgLS0KPj4gwqAgMSBmaWxlIGNo
YW5nZWQsIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCj4+IGluZGV4IDYwNWNlZjYuLmFlOTYyYjkgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+PiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gQEAgLTM2NzIsOCAr
MzY3Miw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9yZXNldF9zcmlvdihzdHJ1Y3QgCj4+
IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gcjsKPj4gwqAgLcKgwqDCoCBhbWRncHVfYW1ka2ZkX3ByZV9yZXNldChh
ZGV2KTsKPj4gLQo+PiDCoMKgwqDCoMKgIC8qIFJlc3VtZSBJUCBwcmlvciB0byBTTUMgKi8KPj4g
wqDCoMKgwqDCoCByID0gYW1kZ3B1X2RldmljZV9pcF9yZWluaXRfZWFybHlfc3Jpb3YoYWRldik7
Cj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDZmVsaXgua3VlaGxpbmclNDBh
bWQuY29tJTdDYmQwOTc0MDRiYThiNGU3ZjlkOTMwOGQ3ODMwNzE3ZmUlN0MzZGQ4OTYxZmU0ODg0
ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTIxOTM4OTA4ODc2NzEwJmFtcDtzZGF0
YT1iTkdUWnRGTGlRNDZVd2pDYTV1OGhYRzFLVXRLJTJGczk4ZzdyQm1CdFRhUHMlM0QmYW1wO3Jl
c2VydmVkPTAgCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
