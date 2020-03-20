Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C069C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1DA20709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 14:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tutnvU+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1DA20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15106E15D;
	Fri, 20 Mar 2020 14:30:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A777A6E15D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 14:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUrCBx1QDDn8rSiampDUvvdEdcyiHTEsUt+UIAJ2nCTA8OoNKOPbqiPbbzeDJJRshI0oAJsnOy+p2VPk3WWiSj3HsW16poyxZpq6XHC+daImoSTDEFdWoN3muuJ+BGWUawrU+PfijvkNpnLFZtZ1ADbnCzIXzlpiZRfpYXFcbIpyB0z7ikSNXoeSlPM1SUegwa4eGRgUX98CwUC2usw/nSeia+3HvfAvLbZgq4WIVclM8Pe8JGnxRMeWRv6nniCUJSYnVud9Gg50H5pb0iFxFd6MFF1wl7sZ5GuNs2qux+m4zBOB7bzpc/DpaWqoMpjX6M4vTiD0HdGyyiNOxaCiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN3hhKXInNxHl5e+xS7SqqIk6Iv9tvX4tKRyxaWN36c=;
 b=Q6bXhkUUJRaNtDK8Pp/GVHcNr8N4sOv8bnguN10bkyWfas69vPfJfwAYD15dp+TzTo3oSK1W8sJm0iC4R05pIFWKeVJHglxfAfIRYLAzpkfTob7qdEIBl1husFcYpwmqf4GfDP45miI3SyXHGcMs925IssrOfWrZ4MWCmSUTuKUPYzghU8BxU1Ckzl2t0gz5U2SUwpwoI6gSV38+qXDPZLDOlEtvSbbV3XqUlHBg7gM9G/kvUvef3vwgCrtoK+qjTgP0l1Il7oU8wienie+/gdxd/na7evH7Q9AroWp7iI/bl+lEYC4xnJpJ6xCGGEdSNM60WzWlaRT9fyDJE3YxUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN3hhKXInNxHl5e+xS7SqqIk6Iv9tvX4tKRyxaWN36c=;
 b=tutnvU+33Z1uuq2R8XLtH6iriDsDU4zvx2NC3nTkHNUE6xq8oSFmC2nGMaT/j1N6YDIewDywfzVz7d3m0pY1mjjsmKVlLhmmuOzMzv5aovofD9YXlYhBFpcrwyCeCYp/R2OK5U3zR7wKOddYyR9lKe+zQPOzJk54NgBcGsndlqI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12)
 by DM5PR1201MB0233.namprd12.prod.outlook.com (2603:10b6:4:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Fri, 20 Mar
 2020 14:30:49 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::a46f:dd34:e56a:748d%5]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 14:30:49 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: add macro to get proper ih ring register
 offset
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200320002245.14932-1-alex.sierra@amd.com>
 <20200320002245.14932-2-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <07bf8db6-f94a-f863-e4cc-074883227a66@amd.com>
Date: Fri, 20 Mar 2020 10:30:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200320002245.14932-2-alex.sierra@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::25) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.21] (142.116.63.128) by
 YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Fri, 20 Mar 2020 14:30:49 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d08d4b24-c356-495d-bc38-08d7ccdb493b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0233:|DM5PR1201MB0233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02337A2C3A206312DEF50B3B92F50@DM5PR1201MB0233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(186003)(2616005)(53546011)(66476007)(52116002)(66556008)(956004)(8936002)(44832011)(2906002)(81156014)(31686004)(66946007)(81166006)(8676002)(478600001)(5660300002)(16526019)(36756003)(316002)(26005)(6486002)(86362001)(31696002)(16576012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0233;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3gCwOOVf5Ukk+gfllmrv79qgnpru8bzbRWrd+YQHQY/z853Jy+8jFWEPHKDp6RseG6JPG6ptxa/XKZZrTlX0cDKh5H683/fDhp2O/zAuBfVtrP3Kyk8Dc4R1/hnfktgzX3NpqS/dAssrC3hdECOfs6LYke7Wg8IqyMA5KoxOi61tvPjn3XKf64ucsBEEy7c4XQMTjLwdGU9dbwep1L6KWZeC8oKlrQJguzbOaeGds/xrvOPq8cN4g3Khxhnf7/vP56RngivSCnfTne7JrglKcgpYg9FsAeJwc93wyLb2c6fLoXx5ejMMLnrB1DVF3NiRCrRDRyBazS8SmjLoQSZSOWrLuAcjzLZXNAVoteF4ySOraAUj4AvOJtLTeLYbCspcb0G9mK0L949tur4nUH9TrMv00xMbYCTqHNeZZvefn8F6ALnb8xKMTMzU8HNrCec
X-MS-Exchange-AntiSpam-MessageData: 2HaPJxGyneJT2A3GStMiz/9b+MUM39tTzGTmrwf6lPjODV2xLsuIml34mn/kHk3repRUwfVDDInqwE70nZqBgTBPq7rlLb2PLz1YXkIwdnBqT6040GdXimHXmQnbyEpz5k9LayCCFfnPYSa0Qvu2hg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08d4b24-c356-495d-bc38-08d7ccdb493b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:30:49.7509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mV6uumz+aeTbOOweAzM7UwvchJ805HOOk6eBxehtpkRyx7/JBnOLHXwxu/30LKXOQfiY/i7nWUyWRHYm22etzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0233
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

T24gMjAyMC0wMy0xOSAyMDoyMiwgQWxleCBTaWVycmEgd3JvdGU6Cj4gVGhpcyBtYWNybyBjYWxj
dWxhdGVzIHRoZSBJSCByaW5nIHJlZ2lzdGVyIG9mZnNldCBiYXNlZCBvbgo+IHRoZSB0aHJlZSBy
aW5nIG51bWJlcnMgYW5kIGFzaWMgdHlwZS4KPiBUaGUgcGFyYW1ldGVycyBuZWVkZWQgYXJlIHRo
ZSByZWdpc3RlcidzIG5hbWUgd2l0aG91dCB0aGUgcHJlZml4IG1tSUgKPiBhbmQgdGhlIHJpbmcg
bnVtYmVyIHRha2VuIGZyb20gUklORzAsIFJJTkcxIG9yIFJJTkcyIG1hY3Jvcy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgo+IC0tLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCA1ICsrKysrCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdh
MTBfaWguYwo+IGluZGV4IDQwN2M2MDkzYzJlYy4uNWJkOWJjMzdmYWRmIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKPiBAQCAtMzQsNiArMzQsMTEgQEAKPiAgICNp
bmNsdWRlICJ2ZWdhMTBfaWguaCIKPiAgIAo+ICAgI2RlZmluZSBNQVhfUkVBUk1fUkVUUlkgMTAK
PiArI2RlZmluZSBSSU5HMCAwCj4gKyNkZWZpbmUgUklORzEgKFJJTkcwICsgNCkKPiArI2RlZmlu
ZSBSSU5HMiAoUklORzEgKyA0KQo+ICsKPiArI2RlZmluZSBtbUlIX1JJTkdfUkVHKHJlZywgcmlu
ZykgKFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIXyMjcmVnKSArIChyaW5nKSAqIGFk
ZXYtPmlycS5yaW5nX3N0cmlkZSkKCkkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdGhlIFJJTkd4IGRl
ZmluaXRpb25zLiBKdXN0IHVzZSBudW1iZXJzIDAtMi4gVGhlIApyaW5nX3N0cmlkZSBzaG91bGQg
YmUgdGhlIG51bWJlciBvZiByZWdpc3RlcnMgdG8gc2tpcCBmcm9tIG9uZSByaW5nIHRvIAp0aGUg
bmV4dCwgd2hpY2ggY2FuIGJlIGRpZmZlcmVudCBmb3IgZGlmZmVyZW50IEFTSUNzLiBFLmcuIAoo
bW1JSF9SQl9DTlRMX1JJTkcxIC0gbW1JSF9SQl9DTlRMKS4gSXQncyA4IG9uIFZlZ2EsIDEyIG9u
IEFyY3R1cnVzLgoKSSdkIHNxdWFzaCBwYXRjaGVzIDEgYW5kIDIgdG8gbWFrZSB0aGlzIG1vcmUg
b2J2aW91cy4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKPiAgIAo+ICAgc3RhdGljIHZvaWQgdmVnYTEw
X2loX3NldF9pbnRlcnJ1cHRfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+ICAg
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
