Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A07C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753802173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bQMPY1IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753802173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3138689F89;
	Mon,  2 Mar 2020 12:26:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D8389F89
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:26:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX5oJnWllgANxA3QBgJKejlVa6QJP53Cfn3pNbeb2YlkJqrAvPtL7RTDc0oVNngOQjpQ8Z2S9SfkvXkERNpWW9E7KklQ9LKU76neHJErQ3YiqFsswYVZNJYJ53KlUk3nTL09E6y122f/PzdUjZG35OlNQuj7QSJnKcjtYwqbeCuTSdNvvIGeZaeYaXqg3Ov8Ftduc5JKV9EWVp4dydpQM4V7BNXLcaMY7/akElkmd4cu5WnoTMOCC0+dK3yH7jCLST1OUydCXkA63/WgLj7AyxmJNIxZf/DHp5fmDuFmeqJ/d1cbEwgCH37LKdxoKxD3EtPZDH8UZhSkxA56jLW2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3FAEPf334T3H7V1AbR33xMz/2Z7nR7uvVNGfNijyTg=;
 b=mRZSjJ3CP48TGuhjSdRH8jvy8lTX38oXSrhMnI8+Xz25+ezUSPA3oMaL/Bg8V0163dZQBa4YL6u/dEIePXm30M9h1SbUeBK34NqMBAcrUKRyyVk3NhCo1C9kkc7JgJLXkMSuRqOj9Up5pUNCiLW8BGLKVDnypC1t3Qbm4CkptOoOjnpgl3h/5fmqlD2CK06e4+mNM4kj8nYZImCayqVvoMuFcBeOvPKtVD6vxyvinyYLlBpGeyaDidHHn43DF+Y5q5TxAmrH25uLz0Oj8UaWzhyoW9l7WZQ0LazBncz0TxjWaEEv124+fDPpzlBmKpNkqkwsU+dqywJMQHY+QdEUAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3FAEPf334T3H7V1AbR33xMz/2Z7nR7uvVNGfNijyTg=;
 b=bQMPY1ITNtsXyVSruuPPiCvUlQ4TM8yxaWUAiGUf3HfEnKpesvai7siRX99rVIWsnGbwmwxmvaUB29yN+NhTcQ2SVU8eUT+VfbQt4u8WbNrfmbQaUmUYly3+uAttClW+D4VgTe9YUdh88Xt4BxbKKu14ZCAsVHKN3E9qG7kxM30=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1579.namprd12.prod.outlook.com (2603:10b6:4:c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Mon, 2 Mar 2020 12:26:03 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 12:26:02 +0000
Subject: Re: [PATCH v4 1/4] drm/amdgpu: set compute queue priority at mqd_init
To: christian.koenig@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200302095234.3638-1-nirmoy.das@amd.com>
 <155a5d96-2411-5eb2-4f29-5edcf20a13f1@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <9563f7e1-b0f6-3a8e-163d-5a9b6401c6d9@amd.com>
Date: Mon, 2 Mar 2020 13:29:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <155a5d96-2411-5eb2-4f29-5edcf20a13f1@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128]
 (2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128) by
 ZR0P278CA0035.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 12:26:00 +0000
X-Originating-IP: [2003:c5:8f21:fc00:9e54:a4a7:c1b6:6128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55f84300-e3e6-480c-e9b9-08d7bea4df45
X-MS-TrafficTypeDiagnostic: DM5PR12MB1579:|DM5PR12MB1579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB157905F231E631D1ACD92E948BE70@DM5PR12MB1579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(189003)(199004)(52116002)(478600001)(36756003)(4326008)(53546011)(2616005)(5660300002)(6666004)(31696002)(31686004)(2906002)(316002)(66556008)(66476007)(66946007)(8676002)(186003)(81156014)(6486002)(81166006)(8936002)(16526019)(66574012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1579;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFAj40PvU/F8rFz5z5CguQ4R7NFQN5ZY3YmFimlWk54uliXk1AaaDgRUshbypfi8ZdfhSWqwdwER+b4ndAnppAeYfve+EsGXv5UEbSCo5iqKJNUprvwkRJBDXbnYRlZJT7yujzaHoh7usOTenAVDja/uK4VpJeRtXBRM5gZfByBhUqFNFKhMCTtJtSjpFCERkmFkFOa6Tgfjx9Vb82L9g0Y4F8LrWeNXECnBvUT07PwuXp9EwtdedeJPvLBbiPsf1Y5+EeALyCXfLvmX4wMJEQM0u7FwDxR0SkLNBPMJJaLVKfieuNx2vFmCJkLORIGKssXg1inm/LRTF5DGq3CWV71meZaqBk/9gynJ0UNPXTT2DGUDCeNEuCc0zv6ysmWRJ29zS7hKZmKyB1DffWCYa8kps2YWsxn8osrxOyXbQh8fbsRZLRaZfyNT/O+zoXOa
X-MS-Exchange-AntiSpam-MessageData: S5Hur9BkwkuKQNFEuVZh5ybCLk6ANes0+7lhA2hGvFsiIvefKpeDvHCco9USqA75Hz9e7tae0V4fHBf1GVVq7yLZz88d2dHKy+U+KiDP3hBHQg1FFDNVJkJUfPgWG0L/1L/3ue+NmhXSqh4Ia8XaaIcfp+euOO5aVVxFHRtzuEt7uZqc1wsDTDaQquZdimIjmpglsgoWo5Ktc4dWIaidng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f84300-e3e6-480c-e9b9-08d7bea4df45
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 12:26:02.8088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRiXCRWwMwPqyA5X9WS3Y6QNPVnysDWpRoEacvHgimh2fGuzwe3+936+DMlAQ13nzj97kt753MaOyTnxH6Zt5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
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

Ck9uIDMvMi8yMCAxOjA2IFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4+IMKgICNkZWZp
bmUgQU1ER1BVX01BWF9HRlhfUVVFVUVTIEtHRF9NQVhfUVVFVUVTCj4+IMKgICNkZWZpbmUgQU1E
R1BVX01BWF9DT01QVVRFX1FVRVVFUyBLR0RfTUFYX1FVRVVFUwo+PiArZW51bSBnZnhfcGlwZV9w
cmlvcml0eSB7Cj4+ICvCoMKgwqAgQU1ER1BVX0dGWF9QSVBFX1BSSU9fTE9XID0gMCwKPgo+IFRo
YXQgaXMgbm90IHVzZWQgYXMgZmFyIGFzIEkgY2FuIHNlZS4KT2theSBJIHdpbGwgcmVtb3ZlIGl0
Lgo+Cj4+ICvCoMKgwqAgQU1ER1BVX0dGWF9QSVBFX1BSSU9fTk9STUFMLAo+PiArwqDCoMKgIEFN
REdQVV9HRlhfUElQRV9QUklPX0hJR0gsCj4+ICvCoMKgwqAgQU1ER1BVX0dGWF9QSVBFX1BSSU9f
TUFYCj4+ICsKPj4gK307Cj4+ICsKPj4gKyNkZWZpbmUgQU1ER1BVX0dGWF9RVUVVRV9QUklPUklU
WV9NSU5JTVVNwqAgMAo+PiArI2RlZmluZSBBTURHUFVfR0ZYX1FVRVVFX1BSSU9SSVRZX01BWElN
VU3CoCAxNQo+Pgo+PiDCoCBzdHJ1Y3QgYW1kZ3B1X21lYyB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGFtZGdwdV9ib8KgwqDCoCAqaHBkX2VvcF9vYmo7Cj4+IEBAIC0yODAsOCArMjkwLDkgQEAgc3Ry
dWN0IGFtZGdwdV9nZnggewo+PiDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBudW1fZ2Z4X3NjaGVkOwo+PiDCoMKgwqDCoMKgIHVuc2lnbmVkwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBudW1fZ2Z4X3JpbmdzOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyBj
b21wdXRlX3JpbmdbQU1ER1BVX01BWF9DT01QVVRFX1JJTkdTXTsKPj4gK8KgwqDCoCBzdHJ1Y3Qg
ZHJtX2dwdV9zY2hlZHVsZXIgCj4+ICoqY29tcHV0ZV9wcmlvX3NjaGVkW0FNREdQVV9HRlhfUElQ
RV9QUklPX01BWF07Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpjb21w
dXRlX3NjaGVkW0FNREdQVV9NQVhfQ09NUFVURV9SSU5HU107Cj4+IC3CoMKgwqAgdWludDMyX3TC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9jb21wdXRlX3NjaGVkOwo+PiArwqDCoMKgIHVpbnQz
Ml90IG51bV9jb21wdXRlX3NjaGVkW0RSTV9TQ0hFRF9QUklPUklUWV9NQVhdOwo+Cj4gVHlwbyBo
ZXJlIHRoYXQgc2hvdWxkIHByb2JhYmx5IGJlIEFNREdQVV9HRlhfUElQRV9QUklPX01BWC4KVHJ1
ZS4gVGhpcyBpcyBlbWJhcnJhc3NpbmcgOi8KPiBfcmluZyB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IG11dGV4wqDCoMKgwqDCoMKgwqAgcHJpb3JpdHlfbXV0ZXg7Cj4+IMKgwqDCoMKgwqAgLyogcHJv
dGVjdGVkIGJ5IHByaW9yaXR5X211dGV4ICovCj4+IMKgwqDCoMKgwqAgaW50wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwcmlvcml0eTsKPj4gK8KgwqDCoCBib29swqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBoaWdoX3ByaW9yaXR5Owo+Cj4gUHJvYmFibHkgYmV0dGVyIHRvIHVzZSBnZnhfcGlwZV9wcmlv
cml0eSBoZXJlLgpPa2F5Cj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
