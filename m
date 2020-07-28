Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1851DC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1C32064B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WsvGJ311"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1C32064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C6D89B22;
	Tue, 28 Jul 2020 11:21:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CBC889B22
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 11:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuWysObd7MEhsm3ca4sWE+UwPvXfIXV4ViPl45wV3ndJUhd8ALz8oMrJiOX7AODu2fL5SEwDfA2mFqJMj9CcPpipPowTX6GapiSkFpcshNVmv/WORtPqSCCIK7WuB17hZrAcHbSWX1s5Zg33CmKbTq2INZnr6wiMKbB9f3Ton0g7B2/4tm1HN3DYz46qWv+KJyszJSrVx4euvdNvaqJ39+gOyTxR8Z7vbGhD5RY/uSmNZGAQO4B3xXn38ixitoIpqHEr4UJaA2OcFpvBOrt4lPr3o1UJXXoHyeyOBT6gOE24JCsqQcjGp/5lwmHfkHcWP1JImZvYBRQQAtWOHr6Mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEirvnYPlJQGscCKUNPgMgInujYw0hlhTdL6OT0WLMI=;
 b=C61r6L1199NU8UzkAuq3BSmv/IHoBsJzwkqnXlTgfHF4Dq+/uSQ4Za+aneHOUfPpFrgCBAv808b0xqjpIQToVcZ7gT96ZMbV11Vot5PIelO9z550KipPPvaSSlpYg1QvEBjYQs+BviUsN5yo3GdQber2QdEiAAB5A5jsONPhMS1wHKOBqjP+ezIGx4RUI/C3uuUHeP/DP/4RP4TsE874gVSNihZ8FNRCbMouiFkJXEMu1x8IlbQZhHhgyI5qehsFb53GA9p45Ayhhd6cmJxgd/GMPWRiFDWjqVCwnWXtJwXenNI8ZzfMccA+hFqgHFvR8AlfnDPQRww3uojlgeCdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEirvnYPlJQGscCKUNPgMgInujYw0hlhTdL6OT0WLMI=;
 b=WsvGJ311z93HPMJCC6JcgLflqwVcPK0LsCPBAFhfZfqMAdEJY0aMYOtZxRP0jU4MJSDwXntFmNnyJVRuczkKCdP/oc8EECy8GxpCX09QMyx7RN3U3+f4pGRbllXPMqA2RiyBMJu2okzS8TiEgATh1OdrdoLMbPZlrMxy+IYcRrc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 11:21:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:21:02 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: assign the cpu/gpu address of fence from
 ring
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, Le.Ma@amd.com
References: <20200728102154.2505095-1-Jack.Xiao@amd.com>
 <20200728102154.2505095-4-Jack.Xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8463481a-a50e-efe0-1cc8-22fff217075c@amd.com>
Date: Tue, 28 Jul 2020 13:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728102154.2505095-4-Jack.Xiao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 11:21:01 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9173c591-a428-4eed-f2d3-08d832e84f87
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36960EBF8388B31F2061ED4A83730@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YH69DlRpi5p4JcUPw8JxnL2B3gDh8hwYHmHAj5WRDy7COdpg8g+ul1h2CdtMkvv1lasD8T9hwd35FM0LvdUfm9GWBNXfKywXGThKLqXpfnKg1flRV6+4TbhLUokEhQW6aVazqaj+t+JRVcQZo5ml1siB+Gq8IHMEGIzztwiiLKoEQO29VmHHI8gLDKizdlmYWztFm57YMybHCoY8y+35e8vBxMYdSjg+CjJv+tR44eclBuhwXxFoW9MvhSVwjDiJyTR910+MUkbCQ59QofBXVW9Zf8b1sZBNdsQLMqsAe+4wU/2y+BXv0dNOQFPagZKSkQhuPBU9tNr/Se0Ess5zDS0lgKAANxswBD4lyFuEBtJArhItVvA2vAjthnlehq+Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(8676002)(66946007)(16526019)(52116002)(186003)(8936002)(6636002)(66556008)(2616005)(83380400001)(6486002)(5660300002)(66476007)(478600001)(2906002)(31696002)(86362001)(316002)(36756003)(6666004)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tJ7Ucnajmzc6QMhsOd0UhheLFaFjAvKlOq+/2q+dB3ldlhIpGqJm7dSEHcPAlxD/45iV/8mLCHEind48kxcCrC5t8N3NVkpjSj1slazzkv+m3agzCDPQJGmGJFjwaTq74yo5fC7+qK66pRYyRMySnNPWBImnYSxoHpeFYkVQ0ramSG9rPA5OwuDFZFJr2gYO8R+WFCE0X2uNFq6uj0D1Vy5qR1ZYPTElgamz9FKPiniY03F9aO2qOq2RSLgiDKn7HQ92f36hhMOYyl9xMoCjXtlPkPDPRy0QxmDdPR2euDAbrYssLRK8qFAr99nNsMgCepXur20JFx04jCxE9mLu+dhNJ4p01Ba59Y7EyPgatdnwx896+JA0aa6SWe7jDgSlyBTdm7KrVIAT4+kc1RINp+H+VxQNoh6P89+1Yqk4NIHnbaU2GBh26CcmAzeLHcNl247pgFbK76is/OLLEfa2KLS9tuEPEYJYfwXyQKdfH2qNTSBhsM/c1Au1or+m7609v6f4CN/brupLLrlD/RnXWg06kDdNzrX8ACoJhpfCa5FKhnLgigxhh8THdWA6XlRt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173c591-a428-4eed-f2d3-08d832e84f87
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 11:21:02.2935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJ3sTM5N5Nhwj7hpZi97iZszi8p9EPoMCwr3uzcw48FTAt1KmVeenOEg+LGCfG2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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

QW0gMjguMDcuMjAgdW0gMTI6MjEgc2NocmllYiBKYWNrIFhpYW86Cj4gYXNzaWduIHRoZSBjcHUv
Z3B1IGFkZHJlc3Mgb2YgZmVuY2UgZm9yIHRoZSBub3JtYWwgb3IgbWVzIHJpbmcKPiBmcm9tIHJp
bmcgc3RydWN0dXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1k
LmNvbT4KPiBSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29t
Pgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyB8IDQg
KystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2Uu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4gaW5kZXggNThk
NGMyMTkxNzhhLi4wYmUzZTIwMDczODcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYwo+IEBAIC00MDcsOCArNDA3LDggQEAgaW50IGFtZGdwdV9mZW5jZV9k
cml2ZXJfc3RhcnRfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4gICAJdWludDY0X3Qg
aW5kZXg7Cj4gICAKPiAgIAlpZiAocmluZy0+ZnVuY3MtPnR5cGUgIT0gQU1ER1BVX1JJTkdfVFlQ
RV9VVkQpIHsKPiAtCQlyaW5nLT5mZW5jZV9kcnYuY3B1X2FkZHIgPSAmYWRldi0+d2Iud2Jbcmlu
Zy0+ZmVuY2Vfb2Zmc107Cj4gLQkJcmluZy0+ZmVuY2VfZHJ2LmdwdV9hZGRyID0gYWRldi0+d2Iu
Z3B1X2FkZHIgKyAocmluZy0+ZmVuY2Vfb2ZmcyAqIDQpOwo+ICsJCXJpbmctPmZlbmNlX2Rydi5j
cHVfYWRkciA9IHJpbmctPmZlbmNlX2NwdV9hZGRyOwo+ICsJCXJpbmctPmZlbmNlX2Rydi5ncHVf
YWRkciA9IHJpbmctPmZlbmNlX2dwdV9hZGRyOwoKVGhhdCBkb2Vzbid0IGxvb2sgbGlrZSBhIGdv
b2QgaWRlYSB0byBtZS4gV2Ugc2hvdWxkIHByb2JhYmx5IHJhdGhlciAKcmVtb3ZlIHJpbmctPmZl
bmNlX29mZnMgYW5kIG1vdmUgYWxsIHRoZSBoYW5kbGluZyBoZXJlIGluc3RlYWQuCgpDaHJpc3Rp
YW4uCgo+ICAgCX0gZWxzZSB7Cj4gICAJCS8qIHB1dCBmZW5jZSBkaXJlY3RseSBiZWhpbmQgZmly
bXdhcmUgKi8KPiAgIAkJaW5kZXggPSBBTElHTihhZGV2LT51dmQuZnctPnNpemUsIDgpOwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
