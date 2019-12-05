Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B090C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFCD20801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 16:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFCD20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19616F8A5;
	Thu,  5 Dec 2019 16:08:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8B76F8A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 16:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQYhxmq1jjH63SyB2bEwqpJKmIq/AiPutZqBu5oCBJn/T3GA6gWeJY586a4bYu6IKIFI7+IPimcRQJ1nBp0MEro88h6amB49FvJHoJbPBYlRnT8hzeomn85Pd5kHl7AAwdbhzqB82jid06QmO6Kbouzg8GTdOXm55FS6MWDOdfhAVrCM3gzUK7CNhZD5jqp25ZvjJIky5HV3s70vdSBI9gdqRseM/odUGvwyi5y70F/+ej+P8bHTpPXr514gSTH4WlMj+YPZb32ptktCmAYwxyoX/P3SvvhCkXLNryUMaC7lzrdVaKUDEpU170wqCgCEe2UfvET1c8OEdLYysdDfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig5nFvx2hqN3h9SlEoVoXFwbq3J393two781o9hsgZo=;
 b=at+nrW6PEF2G4/58Q25G4mtPLKxlFOPjGLC2RfyTD8G208P+ObRt+Do/OzwAXD/WODEMGyDeoBEgSgHitDzQYuwDgWhDYDD9KYUfq3+gh0g5xAJkJ1KcbL0Vyhczi1SLl2wuKJPGu6qy0n+A5N1gzYL3CjperTkmeVLAshoanBlU4ph1Tr1Y3LqtcqQmNgaJjQ0y9+9nMz7a40d+ExDkhJ5EdN/tExgg1xnSDRpySzo5e5R8K47LXQHiwvvMkKN4NCKSMbcHK8P2QMat8PRxsiJm0/JX4ZRX8G7CkuTHLcSAyXB2ZxmmCTaDuSkboeoC5XK3JJ/tNdX898bpAeT+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1788.namprd12.prod.outlook.com (10.175.86.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 16:08:17 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::b8ee:257d:3a23:ae8a%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:08:17 +0000
Subject: Re: [PATCH v2] drm/scheduler: rework entity creation
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com
References: <20191205144842.6768-1-nirmoy.das@amd.com>
 <f1f908a7-5fdf-557d-7d32-5fb1ee5be728@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <bbf1ab6a-6c72-2b21-9cc9-800e64406c5c@amd.com>
Date: Thu, 5 Dec 2019 17:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
In-Reply-To: <f1f908a7-5fdf-557d-7d32-5fb1ee5be728@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::22) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-Originating-IP: [2003:c5:8f4c:b00:cd77:8bff:f597:420f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f87c889f-c54c-40b7-86a7-08d7799d56c0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1788:|DM5PR12MB1788:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17885E84969BEFA62573BFF98B5C0@DM5PR12MB1788.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(6636002)(2906002)(2870700001)(36756003)(65956001)(81156014)(81166006)(6666004)(478600001)(8936002)(6486002)(8676002)(316002)(76176011)(66574012)(14454004)(52116002)(58126008)(31686004)(99286004)(110136005)(4326008)(229853002)(23676004)(186003)(6512007)(6506007)(53546011)(31696002)(66556008)(11346002)(2616005)(305945005)(25786009)(14444005)(66946007)(66476007)(50466002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1788;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxJep7j3kjXcpRjhlr/xX1KpFhQKvcD6E10p9zUlSbVxUedtNWn6d0eeT6vTUuDM+yoRUeJT/BkewKK4nGpLdnm14PcMDdyoifPhnmmBCAIpSEhInjEcHbU1tw9DlvOdHVfqbXQi6bxmSUUpcXxTzPlIU1lXCz40nrRj3X8ZlVcmVc2Wio+H7IZJMI5T3JqAB+7xsN06R1GpMfBgrpQ7BNFFSd8RsHLAb47df8zusKhOGGZns7L/MeNpxz6XqzrO/JyCezOyv4E6aENEx+GTJr6bzVSrM+aJ26ABNLo6S+EHHFdev5eomk5DWQ3+XyEViDbW2xtq0ewKqKvqc/hL9y8Ijce1QtQpcKmLnH/y5DP52kAyX1UqXuF3a/0wITNTi2drIjJj6tAF0PPww7Lt6Y1XeKdyrZV45DYlQjlSsquBtTJ6BdJyE3jw94SK1Ldd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87c889f-c54c-40b7-86a7-08d7799d56c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 16:08:17.0427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56VQk4xZJWjVfIiuMmxJO9b9K35hfFraE+b89+IrCOnQf3auQWmefxzlrFb3OmxIfa6pT3RZXrK+gxt6b9t6iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1788
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig5nFvx2hqN3h9SlEoVoXFwbq3J393two781o9hsgZo=;
 b=nfQ+NJC8/zEUQuAf0cNaYYMD2vzsrJZEmQJ7wE6Pn1l9OwpUVxieDOv/Mu1Ni8VgHH5ID/CWYkfTeqCfllmRd4ashn5av/uRlz8/XIpuShkq2YJnhq0+FSoA1c8ssuElkBDIZYMjAkaM0BqRFfdG4eO4uz4/x0Ukrwv2TqkuO5I=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEyLzUvMTkgNDo0MyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNS4xMi4x
OSB1bSAxNTo0OCBzY2hyaWViIE5pcm1veSBEYXM6Cj4+Cj4+IMKgIEVYUE9SVF9TWU1CT0woZHJt
X3NjaGVkX2VudGl0eV9zZXRfcHJpb3JpdHkpOwo+PiBAQCAtNDkwLDE4ICs0NzQsMjAgQEAgdm9p
ZCBkcm1fc2NoZWRfZW50aXR5X3NlbGVjdF9ycShzdHJ1Y3QgCj4+IGRybV9zY2hlZF9lbnRpdHkg
KmVudGl0eSkKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKPj4gwqDCoMKg
wqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX3JxICpycTsKPj4gwqAgLcKgwqDCoCBpZiAoc3BzY19xdWV1
ZV9jb3VudCgmZW50aXR5LT5qb2JfcXVldWUpIHx8IAo+PiBlbnRpdHktPm51bV9ycV9saXN0IDw9
IDEpCj4+ICvCoMKgwqAgaWYgKHNwc2NfcXVldWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSB8
fCAKPj4gZW50aXR5LT5udW1fc2NoZWRfbGlzdCA8PSAxKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOwo+PiDCoCDCoMKgwqDCoMKgIGZlbmNlID0gUkVBRF9PTkNFKGVudGl0eS0+bGFzdF9z
Y2hlZHVsZWQpOwo+PiDCoMKgwqDCoMKgIGlmIChmZW5jZSAmJiAhZG1hX2ZlbmNlX2lzX3NpZ25h
bGVkKGZlbmNlKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gwqAgK8KgwqDCoCBz
cGluX2xvY2soJmVudGl0eS0+cnFfbG9jayk7Cj4+IMKgwqDCoMKgwqAgcnEgPSBkcm1fc2NoZWRf
ZW50aXR5X2dldF9mcmVlX3NjaGVkKGVudGl0eSk7Cj4+IC3CoMKgwqAgaWYgKHJxID09IGVudGl0
eS0+cnEpCj4+ICvCoMKgwqAgaWYgKHJxID09IGVudGl0eS0+cnEpIHsKPj4gK8KgwqDCoMKgwqDC
oMKgIHNwaW5fdW5sb2NrKCZlbnRpdHktPnJxX2xvY2spOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOwo+PiArwqDCoMKgIH0KPgo+IFNob3VsZCB3ZSByZWRlc2lnbiB0aGF0IGludG86Cj4K
PiBpZiAocnEgIT0gZW50aXR5LT5ycSkgewo+PiAtwqDCoMKgIHNwaW5fbG9jaygmZW50aXR5LT5y
cV9sb2NrKTsKPj4gwqDCoMKgwqDCoCBkcm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eShlbnRpdHkt
PnJxLCBlbnRpdHkpOwo+PiDCoMKgwqDCoMKgIGVudGl0eS0+cnEgPSBycTsKPiB9Cj4KPiBXb3Vs
ZCBwcm9iYWJseSBiZSBlYXNpZXIgdG8gdW5kZXJzdGFuZC4KPgpZZXMsIGxvb2tzIG11Y2ggY2xl
YW5lciB3aXRoIHRoYXQuIFNlbnQgYSB2MyB3aXRoIHRoYXQgY2hhbmdlLgo+IEFwYXJ0IGZyb20g
dGhhdCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCj4gPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4uCj4KPiBEbyB5b3Ugd2FudCB0byB3b3JrIG9uIGEgZm9sbG93
IHVwIHBhdGNoIGZpcnN0IG9yIHNob3VsZCBJIHB1c2ggdGhpcyAKPiB0byBkcm0tbWlzYy1uZXh0
PwpQbGVhc2UgcHVzaCB0aGlzIHRvIGRybS1taXNjLW5leHQgZm9yIG5vdy4gSSBhbSB0aGlua2lu
ZyBvZiBkb2luZyByZXN0IApvZiBjbGVhbnVwIGFuZCBvbi1kZW1hZCBlbnRpdHkgY3JlYXRpb24g
Zm9yIGVhY2ggSFcgSVAgdG9nZXRoZXIuCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
