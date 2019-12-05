Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231FC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07B720801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07B720801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7351D6E14B;
	Thu,  5 Dec 2019 17:13:58 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAEAF6E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 17:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwFfYq1uCj6ouO9TS2ZmK1D8gOortW9Z2ysGzwJ4L9j5b69IHO8HqoBToDdGCbh6DiJ45nfGpZoWN467vPscTyKhC/1p/Upv6QFA5iwd0GWpW0PZT38Fw6/4DACb0Z1taPe29t5bgAB0+KBM3dTa7Xm5Mffsfxlh137mTfWLpIm53ZV34crO5h9KGSBn/wjLx7cBz0WbpL+foEfSMqKkPkfIggT2q7lYWiJQJAan8oCw3/IQmxJdkwjTZdkHF1PNp6AxZbl7Ccq0jN73HktH9Li1rY3z4og2N7fFchVB9WHShTL2SdGMJqYK0rnzP8GsH1JUoiOeG7Gh5DT0B9yHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqmE52Dz9N2XTMjrtqBmaC2lOH4w8flJuF7X3ao8RuA=;
 b=MJaVYAk05MjtSw8u/sidd9owxqw/E4m4SSCZztAfqUJ1sHddpZ9KW7qLzxRnBDLGjiFY5bG1f4fQuqgeS5c/6Ou57LzYdYJkUlwNBOgbR7PGE3Vm8KPZ1j60MlrFOX3E4SL5IUG4uJ1RgVOA6KOJowowWNiFgfOMBdwMP6m8zxQ+LyBQ8ELsyJ2y40xyTVR+rwMe5opa2O1FRsIobAkYHQuSR9PLKbJ7l9ClURIphQvsdp8W7L2eVWKAskIUmhfyr/WSrY1n0Jmhix4ILBRdE5Y9SC/mnh2bHuaBuK6UhXd8UH8jHEAlNiqpXyqpn4nHFcI3gajgXpuIGq48eW7gZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3947.namprd12.prod.outlook.com (10.255.175.222) by
 DM6PR12MB3273.namprd12.prod.outlook.com (20.179.106.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Thu, 5 Dec 2019 16:58:40 +0000
Received: from DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560]) by DM6PR12MB3947.namprd12.prod.outlook.com
 ([fe80::a099:6fd7:e4d6:f560%3]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:58:40 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Improve kfd_process lookup in kfd_ioctl
To: Philip Yang <philip.yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191205041311.19270-1-Felix.Kuehling@amd.com>
 <e408e64c-3259-8219-1555-9d2f89f9a459@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <120bbf1c-b519-7c7c-968a-3b6951ebcd71@amd.com>
Date: Thu, 5 Dec 2019 11:58:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
In-Reply-To: <e408e64c-3259-8219-1555-9d2f89f9a459@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To DM6PR12MB3947.namprd12.prod.outlook.com
 (2603:10b6:5:148::30)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0504dd93-136c-4d31-60c2-08d779a460c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3273:|DM6PR12MB3273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32737D39469BECDF41D79446925C0@DM6PR12MB3273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(199004)(189003)(8936002)(14454004)(4744005)(5660300002)(2616005)(81166006)(81156014)(11346002)(478600001)(316002)(58126008)(6512007)(31686004)(6486002)(229853002)(2870700001)(8676002)(2906002)(4326008)(86362001)(50466002)(6506007)(26005)(25786009)(53546011)(186003)(99286004)(65956001)(66556008)(44832011)(66946007)(76176011)(36756003)(66476007)(31696002)(52116002)(23676004)(305945005)(36916002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3273;
 H:DM6PR12MB3947.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SWuV+EIC903p2gyjK5CmIu/CoS99ewKv7Z0F8xIjUj1wY+x2OPLB6crPOsweRJXmDTDAHat0jkXBjzywQ8cukymsRKX0IEufHMK70LUwJDVbMC9kZznn9drCD9nFngG2i140xmxThQsUuLY2Tt80guqRAYdyvfs6DULfbUh72oaHDZbEY7EpwL7vOL9BUKFm4yNvovmHqGvTEOVo+N4qBqAiW6CrlsIaSI6i4p/4H6PEW61lU6ihv3+Nsr469V7AlrVh1hMDs6+61oyqMKQdP72t54BLXQx+Ft9ePX8oducrP3Rqg5rcdR8t+P6GGo5yT6nYklZqi+SjhpaK88KMmT1dqpQYQaHqF0X2ua/JOVXIwoBYh7O8ABCiTuBIVKJ55c57iIij1fBhhX59/ixz8HKomh+1D8FLgyxXuzVBjjToR60E0z/dJOW2Jp/9NQ+W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0504dd93-136c-4d31-60c2-08d779a460c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 16:58:40.1971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1bEeIi7vm6YqN3I0RpkmwWX3eHu76ZMqF7iH4A5XnG5cxY7I056/fGD8OJ9Qfm+z2gwXrLmkbTZ64mrO+KtqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3273
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqmE52Dz9N2XTMjrtqBmaC2lOH4w8flJuF7X3ao8RuA=;
 b=Hdz/Xez9Z9jSmWUVwRM0eNiRc5WtqXjfNB0kjHOU1THsQN9nC/ZL+PeoBc9He3GqluSB9JobPI0ftU5GlPAhM/hqouNXfJwKGkgiE2QKrBaKe1CP6ViBXLgE6fT0SC2aGPMt1mgVuDtjAmAlANiWSPMG57/UU4rUzQtPo7YTX5M=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Cc: sean.keely@amd.com, jonathan.kim@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAxOS0xMi0wNSAxMToxMCBhLm0uLCBQaGlsaXAgWWFuZyB3cm90ZToKPiBPbmUgY29tbWVu
dCBpbiBsaW5lLgo+Cj4gV2l0aCBpdCBpcyBmaXhlZCwgdGhpcyBpcyByZXZpZXdlZCBieSBQaGls
aXAgWWFuZyA8UGhpbGlwLllhbmdAYW1kLmNvbT4KPgo+IFBoaWxpcAo+Cj4gT24gMjAxOS0xMi0w
NCAxMToxMyBwLm0uLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4gwqAgZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgCj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+PiBpbmRleCA4Mjc2NjAxYTEyMmYuLmJiMmYy
NjUzMmZlYiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3By
b2Nlc3MuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5j
Cj4+IEBAIC0zMjQsNiArMzI0LDggQEAgc3RydWN0IGtmZF9wcm9jZXNzICprZmRfY3JlYXRlX3By
b2Nlc3Moc3RydWN0IAo+PiBmaWxlICpmaWxlcCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIChpbnQpcHJvY2Vzcy0+bGVhZF90aHJlYWQtPnBpZCk7Cj4+IMKg
wqDCoMKgwqAgfQo+PiDCoCBvdXQ6Cj4+ICvCoMKgwqAgaWYgKHByb2Nlc3MpCj4gaWYgKCFJU19F
UlJfT1JfTlVMTChwcm9jZXNzKSkKClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhhdC4gSSB0aGluayAh
SVNfRVJSIHNob3VsZCBiZSBmaW5lLiBQcm9jZXNzIHNob3VsZCAKbmV2ZXIgYmUgTlVMTCBoZXJl
LiBBbHNvIHRoZSBjYWxsZXIgb2YgdGhpcyBmdW5jdGlvbiBvbmx5IGNoZWNrcyBJU19FUlIuCgpS
ZWdhcmRzLAogwqAgRmVsaXgKCgo+Cj4+ICvCoMKgwqDCoMKgwqDCoCBrcmVmX2dldCgmcHJvY2Vz
cy0+cmVmKTsKPj4gwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmtmZF9wcm9jZXNzZXNfbXV0ZXgp
Owo+PiDCoCDCoMKgwqDCoMKgIHJldHVybiBwcm9jZXNzOwo+PgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZng=
