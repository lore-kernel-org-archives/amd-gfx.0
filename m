Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7C3C2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 09:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5CE2085B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 09:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3PVmGwo/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5CE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A906789E5F;
	Thu,  2 Jan 2020 09:47:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA8089E5F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 09:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpeZ0+RXZr1xvON43zCYxpz6NUEGaFk2DbbkDvCPhu6cdXNKK82IQJsIstwfAOXDkoA0pNlh+nAznG2ia0Hq49NO1WqEn+BCuqd3EcqtibHURIlP5h6F2pF7RhwQoui2bpQRVObCywM7xA9oYqFyfGTONKQy9P/d3Tzx+rJ8WU5fJV43VMWoWuJIW58ZJ0+vIlOa8yvNQ6IwV/i6WHWlkQdsNHfQUoTqtrHFlRswEYUYgcC8DAaHk6pEUQRSHoY1Sr6jRGR05xMW9p70myc0F8fdrYY2znP5qcg5tnNqZIsJWqCYPB/7RHyq3uOri+J7jD1/Madmm/Ud8mBWzmOG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUCH8m/eVWrojYjGjK6ouEryGKv2rWARgtgSoq4J8EU=;
 b=V8bYj72mRcYPg/Lab1VpdVLdDfmLraqb5pEFJ+9fMCccKrdTM2BQviWNFRAqHSDiCfa+PbkVWhV1Y3FrNERIrtTBV95wsu6T8DY2YFtftySxCmL+r7QtEB1ZpQy/xnamkwa9vXTFD7mUZ/YIMk4k1uXdxaSK7feQRWukndAKsZv8xQkqh4AmObbT/Aeb74lShPdDIte0pCLWyxPpbAiVuyrPK+NCTA/4DQrUlw+VW+BQiOl1Mg3zAhKFANUEVOLS2y+8LT/opc0mnkpP7Pl19VkyFYxfxawo7h1KRmHWQOvwz/0pDFMP2IeG+MrV2Ii0maP0k+lNwunRSEMujkXXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUCH8m/eVWrojYjGjK6ouEryGKv2rWARgtgSoq4J8EU=;
 b=3PVmGwo/dof/RvD7qyAn8edbvijMPZcM10QBUStjbnyvMxHBXeQ9TQP96UShDgHFzpw+Jf9UfRP+/2BiLhVk05GbfHKUbe77p6TuybwclgIl8g21fmNk2Yp5ovh4PH9G+WNlaFVH7OSzm9u1TrWc99gGOK1Fs1VkEKm49tdPo0k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1209.namprd12.prod.outlook.com (10.168.234.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 2 Jan 2020 09:47:04 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::d79:116:e097:801b]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::d79:116:e097:801b%7]) with mapi id 15.20.2602.010; Thu, 2 Jan 2020
 09:47:04 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: fix ctx init failure for asics without
 gfx ring
To: christian.koenig@amd.com, Le Ma <le.ma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1576755748-9800-1-git-send-email-le.ma@amd.com>
 <468e6ef3-e08c-17ad-8c83-f3efc3b04f85@amd.com>
 <cb750a50-6f57-316f-e8fd-14e39112ba53@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <d0bb3341-c4c3-00be-87c1-20c3408340d1@amd.com>
Date: Thu, 2 Jan 2020 10:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
In-Reply-To: <cb750a50-6f57-316f-e8fd-14e39112ba53@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2d:4000:a88f:f3ce:2223:1496]
 (2003:c5:8f2d:4000:a88f:f3ce:2223:1496) by
 FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10 via Frontend Transport; Thu, 2 Jan 2020 09:47:02 +0000
X-Originating-IP: [2003:c5:8f2d:4000:a88f:f3ce:2223:1496]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 913f0fe6-268a-4cd4-d0c5-08d78f68b8ea
X-MS-TrafficTypeDiagnostic: DM5PR12MB1209:|DM5PR12MB1209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12096EE1085EF0B080E817F48B200@DM5PR12MB1209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0270ED2845
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(199004)(189003)(53546011)(6666004)(31686004)(52116002)(8676002)(6486002)(36756003)(4326008)(186003)(316002)(16526019)(31696002)(45080400002)(81156014)(81166006)(66476007)(8936002)(478600001)(66574012)(66946007)(66556008)(966005)(5660300002)(2906002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1209;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: votUavKiGm9Lga2V+UMA6ZU1x0zt2dXP7CLKmKplYQoPivZ8sqU8SlsXSaCWOvQ1p8Gb5Rs+WsBvFFYn9vsZF8iN6M9pYdREXyP+51ufqm+UEftVVD6FhHcYKmSY++oehnNbZpIkvPSod7UnETqvybo3WaOaG6lYU9cU12E0f7K6eJMRqbEo5MufgO+fhWnABfPdnRdnmA0iWwPj4agDeRDZDFZcu1rX1iuCgn5JzsJxbUrmyFwbhtJTaB3KatuiJMbd/CVnT0qKpPNHz73HKiXDv2GoRee+BA81iXuq1M4novtoTx/nbaqlmhOVq5cYKt8q1vyxVA07aCeylhDMtJk2PBDqyFCUV1b2ucg7oa7zgXmOZDe/TNzfN2OtFOX3gOk+L5o7dSytKxO2vd1thResGNiE9nToo9UBuhkwFFPpcp8wLzaQ4t3UxY2v7xECoQslNZX9jY3CAFppIHOnE3JlRRNZ1lqDGcw9sqH2NaE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913f0fe6-268a-4cd4-d0c5-08d78f68b8ea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 09:47:04.0270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soghUiFhHYo/VZJEs+92qdLusTNnkgeE59rFiRaYOqRl5bPUCMtf38ThrKFjwzUaksveBRsrw0sluPL29UNpLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1209
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
Cc: Feifei.Xu@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDEvMS8yMCAxOjUyIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE5LjEyLjE5
IHVtIDEzOjAxIHNjaHJpZWIgTmlybW95Ogo+PiBSZXZpZXdlZC1ieTogTmlybW95IERhcyA8bmly
bW95LmRhc0BhbWQuY29tPgo+Pgo+PiBPbiAxMi8xOS8xOSAxMjo0MiBQTSwgTGUgTWEgd3JvdGU6
Cj4+PiBUaGlzIHdvcmthcm91bmQgZG9lcyBub3QgYWZmZWN0IG90aGVyIGFzaWNzIGJlY2F1c2Ug
YW1kZ3B1IG9ubHkgbmVlZCAKPj4+IGV4cG9zZQo+Pj4gb25lIGdmeCBzY2hlZCB0byB1c2VyIGZv
ciBub3cuCj4+Pgo+Pj4gQ2hhbmdlLUlkOiBJY2E5MmI4NTY1YTg5ODk5YWViZTBlYmE3YjJiNWEy
NTE1OWI0MTFkMwo+Pj4gU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Cj4+PiAt
LS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8IDMgKyst
Cj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHgu
YyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4+PiBpbmRl
eCA2M2Y2MzY1Li42NGUyYmFiIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2N0eC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3R4LmMKPj4+IEBAIC0xMjcsNyArMTI3LDggQEAgc3RhdGljIGludCBhbWRncHVfY3R4
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+PiAqYWRldiwKPj4+IMKgIMKgwqDCoMKgwqDC
oMKgwqDCoCBzd2l0Y2ggKGkpIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEFNREdQVV9I
V19JUF9HRlg6Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZHMgPSBhZGV2LT5nZngu
Z2Z4X3NjaGVkOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWQgPSAmYWRldi0+Z2Z4
LmdmeF9yaW5nWzBdLnNjaGVkOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0g
JnNjaGVkOwo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3NjaGVkcyA9IDE7Cj4K
PiBNaG0sIHdlIHNob3VsZCBwcm9iYWJseSByYXRoZXIgZml4IHRoaXMgaGVyZSBhbmQgZG9uJ3Qg
ZXhwb3NlIGEgR0ZYIAo+IHJpbmcgd2hlbiB0aGUgaGFyZHdhcmUgZG9lc24ndCBoYXZlIG9uZS4K
SGkgQ2hyaXN0aWFuLAoKRG8geW91IG1lYW4gYnkgbm90IGluaXRpYWxpemluZyBlbnRpdHkgZm9y
IGdmeCB3aGVuIG5vdCBhdmFpbGFibGU/CgoKPgo+IENocmlzdGlhbi4KPgo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBBTURH
UFVfSFdfSVBfQ09NUFVURToKPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUy
Rmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDbmlybW95LmRhcyU0MGFtZC5j
b20lN0NiYzVmYTQ5OGVmZTg0ZmNmYjAwYjA4ZDc4ZWI5NzA0OSU3QzNkZDg5NjFmZTQ4ODRlNjA4
ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMzQ3OTk0MjEyOTEzNDcmYW1wO3NkYXRhPUZ4
a3dhQ3JiSVYyOEhIMTh4b3Jnd216UlBDTUExSTlJa1JrZ0UxTEY4MFklM0QmYW1wO3Jlc2VydmVk
PTAgCj4+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
