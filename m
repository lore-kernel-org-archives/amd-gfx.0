Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63131C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3626E20578
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qKwfOjR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3626E20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E168D893C0;
	Tue, 14 Apr 2020 14:52:27 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680061.outbound.protection.outlook.com [40.107.68.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC57893C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0mz8zqCcy5SSzC0c+e8puftflJzX840IlEAYx9NgVlXcXzqWmiZ7Or6bELTDmutsK5X5Nwf6tehWfMeZsIkG1HgEULZPiN7tOgd9giC0w7EwtqKZ80Ob/zLjMfwTftVKdS5Qu+f1itykP8Tb+I8OgANKwSsoGUc62ALuInhra5c1f1TpUiye6HR7ZSqymvyDGSqAUy0Qoy7N1WJJdX3x+7jUFt5Z12CMjspjHOk6uWNJ5CLLB2qw+TL5ahsyy7DfHEQ6jPYnpf/M920cUvGdgerC3fXeQco6nT6ddCwr3yCihl3/yBVkbsl0I+QboA8ej0x1dQFPSHkWjFiYLGp7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1gRQz6n3MepVGoeGn7gMXsS1ty95Joz1cESO8sOZIw=;
 b=G7gBVtfQ7RIUzbrytekDMLH1/4QZ8/JtNMMoopUz0rJgYMZHUISUiJ7KlXZ+LjJlzJhbdx/1N+qkMbyQZ2hz82rjEoBsA0gSgHQ064TH5tPgBBn8Zzk/A+fP/xdXmtPsKGN2Wl1JQCwnisbVSws2+zVU+mxzs4Kd2foSfU7RJbCxXNSNLnfpyUiTs8jL0pqowrw2unRtXha7NLcscGTdi3gPWUYJib/B6oeySQRj3wxoZVJWfWfUy183eS/lpTnjZ3q97zENEBHVUobiYGFAGH77StHqzeuJ3UtEXtBK42U32qNTAicKRnAVcR7fPiLn4GX7egcgaUtRac+Em6DawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1gRQz6n3MepVGoeGn7gMXsS1ty95Joz1cESO8sOZIw=;
 b=qKwfOjR6OwcbFwxq/bxzPL3HrKduohbkNwfb1ENnycs8uihGuuMz0wpCT7v2k9yme77boXA6W0GLFM5nPNYfrWgix1T6ZpK7mXhtGFSHtXDKUr9OrmJm4OnddiMCFQhF1WG0xfuZRGJ2ANI9brG0SnfGUu+SrbSkm8XakItcRHY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.20; Tue, 14 Apr 2020 14:52:24 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::5cda:77e2:a6d3:7135%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:52:24 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
To: Alex Deucher <alexdeucher@gmail.com>, James Zhu <James.Zhu@amd.com>,
 Rex.Zhu@amd.com
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
Date: Tue, 14 Apr 2020 10:52:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27)
 To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.233.155] (165.204.55.251) by
 YT1PR01CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 14:52:23 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acecb305-ca9c-4cec-a0bf-08d7e083712a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:|DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24854B93C17A54AE2CECE741E4DA0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(6486002)(6636002)(66946007)(45080400002)(4326008)(36756003)(478600001)(54906003)(66556008)(110136005)(52116002)(31686004)(66476007)(5660300002)(36916002)(16526019)(2906002)(2616005)(186003)(53546011)(966005)(956004)(8936002)(16576012)(81156014)(26005)(316002)(8676002)(31696002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBCwGyj4svN8MCafSOVgzuICo9nBtBATqFY10A+Om8atqicf9/PKfyDyhTQsHgLrvnriMdTp2+UqUWwLNGCM7s0pyAGro6Dd9qSPiE6CPX1ilNPI3vaTXrremeNsaJB+1wGlTXCGFoS4L861AWs5HUqzw2SFbdazJeRj4lDAG3vRlpJVzSOkGJc1zaKvaDydWnZbCM9TZdiKgCuNwHNg/AEj+KGRzRa85cOkJqSqwO28dceSmChpA5Naxc/6WwyM5Lg9UQmr0zWfSmJ0oTcvArKX7IPCw91hBdkHx7YdU+/LitmAbTA+0vSaXbwrLzyk+2Kk7L6gH5gtr4fGBEtc0NuGTdZNH1h0FTBk9UD8n9fVziU0SiatFg87U6aiYFbqj+lbNHzHC1nHOJ9pUBke9CiboBcMwqBMap9BAQOD+NVjQS16vQZX6Q36TUHa26/usYkgFcsEgL4t78ZykHZYrqvNjixz1J3JeBN23ediNiA=
X-MS-Exchange-AntiSpam-MessageData: fSsl7It8xIl73yE17oKlrC0QEZczsnoiMt/y2cE0SCDibwadWYTm25l4niwTizEuW2sV9k4tyNbmvEY8ZIevmXH/JWXWzPugGzYCIQoOM3WLmRAjrAaMNOOaVG44lQNGCIfEv1HLGrgB6FCsxm8Phg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acecb305-ca9c-4cec-a0bf-08d7e083712a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 14:52:24.2499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0ibM4MiM616iTn0D23m1myUVkjUc3kir1I6KQ7ZII6zQJcWY67SIDJ9/hYEQllw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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
Cc: changzhu <Changfeng.Zhu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

K1JleAoKVGhpcyBpcyBpbnRyb2R1Y2UgYnkgYmVsb3cgcGF0Y2guCgpjb21taXQgM2ZkZWQyMjJm
NGJmN2Y0YzU2ZWY0ODU0ODcyYTM5YTRkZTA4ZjdhOApBdXRob3I6IFJleCBaaHUgPFJleC5aaHVA
YW1kLmNvbT4KRGF0ZTrCoMKgIEZyaSBKdWwgMjcgMTc6MDA6MDIgMjAxOCArMDgwMAoKIMKgwqDC
oCBkcm0vYW1kZ3B1OiBEaXNhYmxlIGdmeCBvZmYgaWYgVkNOIGlzIGJ1c3kKCiDCoMKgwqAgdGhp
cyBwYXRjaCBpcyBhIHdvcmthcm91bmQgZm9yIHRoZSBncHUgaGFuZwogwqDCoMKgIGF0IHZpZGVv
IGJlZ2luL2VuZCB0aW1lIGlmIGdmeCBvZmYgaXMgZW5hYmxlZC4KCiDCoMKgwqAgUmV2aWV3ZWQt
Ynk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KIMKgwqDCoCBTaWduZWQt
b2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CiDCoMKgwqAgU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKCk9uIDIwMjAtMDQtMTQg
MTA6MjIgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIFR1ZSwgQXByIDE0LCAyMDIwIGF0
IDg6MDUgQU0gSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4gd3JvdGU6Cj4+IFR1cm4gb2Zm
IGdmeG9mZiBjb250cm9sIHdoZW4gdmNuIGlzIGdhdGVkLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBK
YW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCA4ICsrKysrLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYwo+PiBpbmRleCBkYWIzNGY2Li5hYTlhN2E1IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+IEBAIC0zNjksOSArMzY5LDEx
IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcpCj4+ICAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVf
d29yayk7Cj4+Cj4+ICAgICAgICAgIG11dGV4X2xvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7
Cj4+IC0gICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+IC0gICAgICAg
YW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NL
X1RZUEVfVkNOLAo+PiAtICAgICAgICAgICAgICBBTURfUEdfU1RBVEVfVU5HQVRFKTsKPj4gKyAg
ICAgICBpZiAoYWRldi0+dmNuLmN1cl9zdGF0ZSA9PSBBTURfUEdfU1RBVEVfR0FURSkgewo+PiAr
ICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+ICsgICAg
ICAgICAgICAgICBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBB
TURfSVBfQkxPQ0tfVFlQRV9WQ04sCj4+ICsgICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NU
QVRFX1VOR0FURSk7Cj4+ICsgICAgICAgfQo+Pgo+IFdoeSBhcmUgd2UgdG91Y2hpbmcgZ2Z4b2Zm
IHdpdGggVkNOPyAgV2FzIHRoaXMgYSBsZWZ0b3ZlciBmcm9tIGJyaW5nCj4gdXA/ICBDYW4gd2Ug
anVzdCBkcm9wIGFsbCBvZiB0aGlzIGdmeG9mZiBzdHVmZiBmcm9tIFZDTiBoYW5kbGluZz8gIEkK
PiBkb24ndCBzZWUgd2h5IHRoZXJlIHdvdWxkIGJlIGEgZGVwZW5kZW5jeS4KPgo+IEFsZXgKPgo+
PiAgICAgICAgICBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURfUEdfU1VQUE9SVF9WQ05fRFBHKSAg
ICB7Cj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IGRwZ19wYXVzZV9zdGF0ZSBuZXdfc3RhdGU7
Cj4+IC0tCj4+IDIuNy40Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4l
MkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0phbWVzLlpodSU0MGFtZC5j
b20lN0MzZGQ5MTM1YzcxN2E0YjMwMTFlMzA4ZDdlMDdmNTJiNiU3QzNkZDg5NjFmZTQ4ODRlNjA4
ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcyMjQ3MDk3NjMzOTE4NDUmYW1wO3NkYXRhPVkl
MkJ0c0pRTkIxVFhDUTl2ODZEVyUyRjBGQzYzZ09TSHNmenpaRnUwTUR2Q0h3JTNEJmFtcDtyZXNl
cnZlZD0wCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
