Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D31EC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 00:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF25960F59
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 00:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF25960F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3246E93D;
	Tue, 27 Jul 2021 00:53:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDE86E824;
 Tue, 27 Jul 2021 00:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl1iWfECDNSPEaj4WlZhqBq8+I7aO7djrTj2DK2Mt9a1l/bE7n0yWc24MpryIVLL1WkGe/IwgcTFBGhrEssQ3E+rSlSmsujpbPEJU4rYsAzDIylq4tT9I1IvO9LZ2L8ks7ijiQWWTrNLookSzcWBl/D0quJoED9jk1qqqAXUreRik205PGvbkhicaMkEGLZtTUgQMQc1ftyy7lbI+xRK5MsWcesyyW/6Af+1dVj0gQy3ezhW9fIJsyJ4mKLDEqkD/P63zqSy+hGYKHtSwJfPJGg7nPw9bZqoOnlNbu1ciX6/h1XdwqSo9Noev8BHmFPmttQfURgYUItCQM4CLpFfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntxb2useW3uGdBbeir2Fx2sJXz7I+893rJNeBSgriS0=;
 b=LtbnyneZCKOEYQvud8zWRUDN+ou74pybKAKkKkzsqYxODLTPlVoCy2w/MDZ3aYy0Mb9qDng01+HREd3vYMR0pXOg+aN8l4wONLhUdzI21ai4wr/FLPCXMyohz0XTMgGkUA6VpcGIlI2jpT9LsRdNNSWLtOS58Iw6UcuC3dul0e5OIwFxTkU3VML79A0qH+M43bnYFOuUD1jzUYBYH2QyvMR+j0nuG6t9BwmiilAy/GjvkDrPgkj7bAPG0/kygnQHr3Bb5lhGbCjBQMXqFWYbH5NoB8bDuRIPXOR4Sw2fdECcsgQhq6SMExgf1jYsOgDp1UA6gfiTx6JqfkY4NTUgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ntxb2useW3uGdBbeir2Fx2sJXz7I+893rJNeBSgriS0=;
 b=ciRkMAZm50f837pUk30oNezV5JCliCu6fV2PHYgnsaofeMFSHTTbYoxPbifC0juUEIIexPHogi6DWS9AGzfD67j8kPBtS+5ITi6NDdQFzQi9B4ywVU8nPKwz54/BdWAOXIsxOiiIZo7OGyVsxySIxgu24U+l6Gg1ASOgr75I69U=
Received: from DM5PR07CA0160.namprd07.prod.outlook.com (2603:10b6:3:ee::26) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Tue, 27 Jul
 2021 00:53:03 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::8e) by DM5PR07CA0160.outlook.office365.com
 (2603:10b6:3:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Tue, 27 Jul 2021 00:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 00:53:03 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 26 Jul
 2021 19:53:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <sunpeng.li@amd.com>, <roman.li@amd.com>
Subject: [PATCH v4 0/4] drm/amd/display: Introduce FPU directory inside DC
Date: Mon, 26 Jul 2021 20:52:44 -0400
Message-ID: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac46c838-e7bb-4925-6f03-08d95098e3bb
X-MS-TrafficTypeDiagnostic: BY5PR12MB4291:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4291E50CF1F09486CAD915ED98E99@BY5PR12MB4291.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiDnrjEjGCtX/3q+VH0HSbm5vgNUzetuZ8nmnVAG6s8hwS0HsLY4vQ1VaDNVxmlbUfKWX26gcTpQvkIf0+aUl7DbhFqh8tkJN4BtMZaJ5yetoyD3yHqpZNsmtFORZI5f/u6Btuoj9TUkqIdE9cGKmLsHOe9Pc8I4bngiOc8v7bYGmINaYcT4FHAuBA6XbQKYQhPL/VEh1Rz3Kt78PiFQtfQ5aNpZJvT3f4DnbY7QReoX/9MNHWDjb2tGa4XSBm2+iBXOJc3dVsWFxZb5mKGTOeLsQ6ytRDhJ1HzZB4xmoyaBuB0Laur5kuAclhsA75cy+18TJGecnuFNRXW8ph1pj9jfSEDeBSqmvLoMdOZHoV2nMw069tbsa/ZyaHwYI1GlFeBi/DxxOjwc+ojXx8x7MaxjXpicYjSkXhgr6MCy4xJlLdIL6P6kzIAy9CBHLBFcjzAGEgR9HsLrF7XJ9OxE9+SwfOMJLpvbS7KLslKVLw7j1Eul5UC7bQQUTQMdY+a6SqLn998UmiljiE+vU3EWw2h6w0fz77Tt80UXipTdYoxAgO68X+JAxTfzumBlTDXzXCox4WirklnaEu59dLK9FNhNHbr+f3RIEJX+JvBRux5mC5xDdeCDs3SasWAwPP3qm22zX+XaJ2CwIg4Hdppee0luhbKdrFElFeEmrI9GhWudflZ/Gn9OS11TtmoK3v25yMpKDUYnRW4BE0u9mCtNiDVDuJp5oMWJLpbk8/ZVYao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(16526019)(186003)(47076005)(8676002)(4326008)(426003)(1076003)(36860700001)(110136005)(26005)(508600001)(6666004)(6636002)(8936002)(316002)(2616005)(356005)(2906002)(83380400001)(81166007)(36756003)(5660300002)(70206006)(66574015)(336012)(70586007)(82310400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 00:53:03.4629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac46c838-e7bb-4925-6f03-08d95098e3bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
Cc: Aric Cyr <aric.cyr@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IEhpLAoKSW4gdGhlIGRpc3BsYXkgY29yZSwgd2UgdXRpbGl6ZSBmbG9hdHMgYW5kIGRvdWJsZXMg
dW5pdHMgZm9yIGNhbGN1bGF0aW5nCm1vZGVzZXR0aW5nIHBhcmFtZXRlcnMuIE9uZSBzaWRlIGVm
ZmVjdCBvZiBvdXIgYXBwcm9hY2ggdG8gdXNlIGRvdWJsZS1wcmVjaXNpb24KaXMgdGhlIGZhY3Qg
dGhhdCB3ZSBzcHJlYWQgbXVsdGlwbGUgRlBVIGFjY2VzcyBhY3Jvc3Mgb3VyIGRyaXZlciwgd2hp
Y2ggbWVhbnMKdGhhdCB3ZSBjYW4gYWNjaWRlbnRhbGx5IGNsb2JiZXIgdXNlciBzcGFjZSBGUFUg
c3RhdGUuCgojIENoYWxsZW5nZXMKCjEuIEtlZXAgaW4gbWluZCB0aGF0IHRoaXMgRlBVIGNvZGUg
aXMgaW5ncmFpbmVkIGluIG91ciBkaXNwbGF5IGRyaXZlciBhbmQKcGVyZm9ybXMgc2V2ZXJhbCBj
cnVjaWFsIHRhc2tzLiBBZGRpdGlvbmFsbHksIHdlIGFscmVhZHkgaGF2ZSBtdWx0aXBsZQphcmNo
aXRlY3R1cmVzIGF2YWlsYWJsZSBpbiB0aGUga2VybmVsIGFuZCBhIGxhcmdlIHNldCBvZiB1c2Vy
czsgaW4gb3RoZXIgd29yZHMsCndlIHByZWZlciB0byBhdm9pZCBhIHJhZGljYWwgYXBwcm9hY2gg
dGhhdCBtaWdodCBicmVhayBvdXIgdXNlcidzIHN5c3RlbS4KCjIuIFdlIHNoYXJlIG91ciBkaXNw
bGF5IGNvZGUgd2l0aCBvdGhlciBPU3M7IHRodXMsIHdlIG5lZWQgdG8gbWFpbnRhaW4gdGhlCmlu
dGVyb3BlcmFiaWxpdHkgYmV0d2VlbiB0aGVzZSB0d28gc3lzdGVtcy4KCjMuIFdlIG5lZWQgYSBt
ZWNoYW5pc20gZm9yIGlkZW50aWZ5aW5nIHdoaWNoIGZ1bmN0aW9uIHVzZXMgRlBVIHJlZ2lzdGVy
czsKZm9ydHVuYXRlbHksIFBldGVyIFppamxzdHJhIHdyb3RlIGEgc2VyaWVzIGEgY291cGxlIG9m
IG1vbnRocyBhZ28gd2hlcmUgaGUKaW50cm9kdWNlZCBhbiBGUFUgY2hlY2sgZm9yIG9ianRvb2wu
IEkgdXNlZCB0aGUgZm9sbG93aW5nIGNvbW1hbmQgZm9yCmlkZW50aWZ5aW5nIHRoZSBwb3RlbnRp
YWwgRlBVIHVzYWdlOgoKIC4vdG9vbHMvb2JqdG9vbC9vYmp0b29sIGNoZWNrIC1GZmEgImRyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9BTllfRklMRS5vIgoKNC4gU2luY2Ugb3VyIGNvZGUg
aGVhdmlseSByZWxpZXMgb24gRlBVIGFuZCB0aGUgZmFjdCB0aGF0IHdlIHNwcmVhZAprZXJuZWxf
ZnB1X2JlZ2luL2VuZCBhY3Jvc3MgbXVsdGlwbGUgZnVuY3Rpb25zLCB3ZSBjYW4gaGF2ZSBzb21l
IGNvbXBsZXgKc2NlbmFyaW9zIHRoYXQgd2lsbCByZXF1aXJlIGNvZGUgcmVmYWN0b3JpbmcuIEhv
d2V2ZXIsIHdlIHdhbnQgdG8gYXZvaWQKY29tcGxpY2F0ZWQgY2hhbmdlcyBzaW5jZSB0aGlzIGlz
IGEgZm9ybXVsYSB0byBpbnRyb2R1Y2UgcmVncmVzc2lvbnM7IHdlIHdhbnQKc29tZXRoaW5nIHRo
YXQgYWxsb3dzIHVzIHRvIGZpeCBpdCBpbiBzbWFsbCwgc2FmZSwgYW5kIHJlbGlhYmxlIHN0ZXBz
LgoKNS4gVW5mb3J0dW5hdGVseSwgZm9yIGxlZ2FjeSByZWFzb25zLCB3ZSBoYXZlIHNvbWUgcHJv
YmxlbXMgaW4gaG93IHdlIHByb2dyYW0Kb3VyIEZQVSBhY2Nlc3MsIHdoaWNoIGluIHNvbWUgd2Vp
cmQgc2NlbmFyaW9zIGNhbiBnZW5lcmF0ZSBzaXR1YXRpb25zIHdoZXJlIHdlCnRyeSB0byBlbnRl
ciBpbiB0aGUgZnB1IG1vZGUgbXVsdGlwbGUgdGltZXMgb3IgZXhpdCB0b28gZWFybHkuCgojIE91
ciBhcHByb2FjaAoKRm9yIHRyeWluZyB0byBzb2x2ZSB0aGlzIHByb2JsZW0sIHdlIGNhbWUgdXAg
d2l0aCB0aGUgZm9sbG93aW5nIHN0cmF0ZWd5OgoKMS4gS2VlcCBpbiBtaW5kIHRoYXQgd2UgYXJl
IHVzaW5nIGtlcm5lbF9mcHVfYmVnaW4vZW5kIHNwcmVhZCBpbiB2YXJpb3VzIGFyZWFzCmFuZCBz
b21ldGltZXMgYWNyb3NzIG11bHRpcGxlIGZ1bmN0aW9ucy4gSWYgd2UgdHJ5IHRvIG1vdmUgc29t
ZSBvZiB0aGUKZnVuY3Rpb25zIHRvIGFuIGlzb2xhdGVkIHBsYWNlLCB3ZSBjYW4gZ2VuZXJhdGUg
YSBzaXR1YXRpb24gd2hlcmUgd2UgY2FuIGNhbGwKdGhlIEZQVSBwcm90ZWN0aW9uIG1vcmUgdGhh
biBvbmNlLCBjYXVzaW5nIG11bHRpcGxlIHdhcm5pbmdzLiBXZSBjYW4gZGVhbCB3aXRoCnRoaXMg
cHJvYmxlbSBieSBhZGRpbmcgYSB0aGluIG1hbmFnZW1lbnQgbGF5ZXIgYXJvdW5kIHRoZSBrZXJu
ZWxfZnB1X2JlZ2luL2VuZAp1c2VkIGluc2lkZSB0aGUgZGlzcGxheS4KCjIuIFdlIHdpbGwgbmVl
ZCBhIHRyYWNlIG1lY2hhbmlzbSBmb3IgdGhpcyBGUFUgbWFuYWdlbWVudCBpbnNpZGUgb3VyIGRp
c3BsYXkKY29kZS4KCjMuIEFmdGVyIHdlIGdldCB0aGUgdGhpbiBsYXllciB0aGF0IG1hbmFnZXMg
RlBVLCB3ZSBjYW4gc3RhcnQgdG8gbW92ZSBlYWNoCmZ1bmN0aW9uIHRoYXQgdXNlcyBGUFUgdG8g
YSBjZW50cmFsaXplZCBwbGFjZS4gT3VyIERRRSBydW5zIG11bHRpcGxlIHRlc3RzIGluCmRpZmZl
cmVudCBBU0lDcyBldmVyeSB3ZWVrOyB3ZSBjYW4gdGFrZSBhZHZhbnRhZ2Ugb2YgdGhpcyB0byBl
bnN1cmUgdGhhdCBvdXIKRlBVIHBhdGNoZXMgd29yayBkb2VzIG5vdCBpbnRyb2R1Y2UgYW55IHJl
Z3Jlc3Npb24uIFRoZSBpZGVhIGlzIHRvIHdvcmsgb24gYQpzcGVjaWZpYyBwYXJ0IG9mIHRoZSBj
b2RlIGV2ZXJ5IHdlZWsgKGUuZy4sIHdlZWsgMTogRENOMiwgd2VlayAxOiBEQ04yLjEsCmV0Yy4p
LgoKNC4gRmluYWxseSwgYWZ0ZXIgd2UgY2FuIGlzb2xhdGUgdGhlIEZQVSBvcGVyYXRpb25zIGlu
IGEgc2luZ2xlIHBsYWNlLCB3ZSBjYW4KYWx0b2dldGhlciByZW1vdmUgdGhlIEZQVSBmbGFncyBm
cm9tIG90aGVyIGZpbGVzIGFuZCBlbGltaW5hdGUgYW4gdW5uZWNlc3NhcnkKY29kZSBpbnRyb2R1
Y2VkIHRvIGRlYWwgd2l0aCB0aGlzIHByb2JsZW0uIFdlIGNhbiBhbHNvIHJlbW92ZSB0aGUgdGhp
biBsYXllcgphZGRlZCBpbiB0aGUgc3RlcCAzLgoKIyBUaGlzIHNlcmllcwoKVG8gbWFpbnRhaW4g
dGhlIGludGVyb3BlcmFiaWxpdHkgYmV0d2VlbiBtdWx0aXBsZSBPU2VzLCB3ZSBhbHJlYWR5IGhh
dmUgYQpkZWZpbmUgbmFtZWQgRENfRlBfU1RBUlQvRU5ELCB3aGljaCBpcyBhIHN0cmFpZ2h0Zm9y
d2FyZCB3cmFwcGVyIHRvCmtlcm5lbF9mcHVfYmVnaW4vZW5kIGluIHRoZSBMaW51eCBzaWRlLiBJ
biB0aGlzIHNlcmllcywgSSBkZWNpZGVkIHRvIGV4cGFuZCB0aGUKc2NvcGUgb2YgdGhpcyBEQ19G
UF8qIHdyYXBwZXIgdG8gdHJhY2UgRlBVIGVudHJhbmNlIGFuZCBleGl0IGluIHRoZSBkaXNwbGF5
CmNvZGUsIGJ1dCBJIGFsc28gYWRkIGEgbWVjaGFuaXNtIGZvciBtYW5hZ2luZyB0aGUgZW50cmFu
Y2UgYW5kIGV4aXQgb2YKa2VybmVsX2ZwdV9iZWdpbi9lbmQuIFlvdSBjYW4gc2VlIHRoZSBkZXRh
aWxzIG9uIGhvdyBJIGRpZCB0aGF0IGluIHRoZSBsYXN0IHR3bwpwYXRjaGVzLgoKSSBhbHNvIGlz
b2xhdGUgYSBzaW1wbGUgZnVuY3Rpb24gdGhhdCByZXF1aXJlcyBGUFUgYWNjZXNzIHRvIGRlbW9u
c3RyYXRlIG15CnN0cmF0ZWd5IGZvciBpc29sYXRpbmcgdGhpcyBGUFUgYWNjZXNzIGluIGEgc2lu
Z2xlIHBsYWNlLiBJZiB0aGlzIHNlcmllcyBnZXRzCmFjY2VwdGVkLCB0aGUgZm9sbG93aW5nIHN0
ZXBzIGNvbnNpc3Qgb2YgbW92aW5nIGFsbCBGUFUgZnVuY3Rpb25zIHdlZWtseSB1bnRpbAp3ZSBp
c29sYXRlIGV2ZXJ5dGhpbmcgaW4gdGhlIERNTCBmb2xkZXIuCgpDYzogSGFycnkgV2VudGxhbmQg
PGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBBbnNvbiBKYWNvYiA8QW5zb24uSmFjb2JAYW1k
LmNvbT4KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6
IEhlcnNlbiBXdSA8aGVyc2VueHMud3VAYW1kLmNvbT4KQ2M6IEFyaWMgQ3lyIDxhcmljLmN5ckBh
bWQuY29tPgpDYzogSnVuIExlaSA8anVuLmxlaUBhbWQuY29tPgpDYzogRG15dHJvIExha3R5dXNo
a2luIDxkbXl0cm8ubGFrdHl1c2hraW5AYW1kLmNvbT4KQ2M6IFFpbmdxaW5nIFpodW8gPHFpbmdx
aW5nLnpodW9AYW1kLmNvbT4KCkNoYW5nZSBTaW5jZSBWMzoKLSBVc2UgRE1MIGFzIHRoZSBGUFUg
Zm9sZGVyIGluc3RlYWQgY3JlYXRlIGEgbmV3IGZvbGRlcgotIEFkZCBhIHByb3BlciBndWFyZCB0
byB4ODYgYW5kIFBQQzY0CgpDaGFuZ2UgU2luY2UgVjI6Ci0gTWFrZSBzdXJlIHRvIGNvbXBpbGUg
RlBVIG9wZXJhdGlvbiBvbmx5IHdoZW4gRENOIGlzIGVuYWJsZWQKICAob2ZmaWNpYWxseSwgd2Ug
b25seSBlbmFibGUgaXQgZm9yIHg4NikuCi0gQ2hlY2sgY3Jvc3MtY29tcGlsZSB3aXRoIEFSTSBh
bmQgeDg2XzMyLiBFdmVyeXRoaW5nIGxvb2tzIGZpbmUuCi0gQXZvaWQgY2FsbCB0aGlzX2NwdV8q
IG9wZXJhdGlvbnMgYmV0d2VlbiBnZXQvcHV0X2NwdV9wdHIuCi0gRml4IEdDQyB3YXJuaW5ncy4K
LSBVcGRhdGUgZG9jdW1lbnRhdGlvbi4KLSBVcGRhdGUgb3VyIGFzc2VydCBtZWNoYW5pc20uCi0g
UmVtb3ZlIHVubmVjZXNzYXJ5IHdyYXBwZXJzLgoKQ2hhbmdlcyBzaW5jZSBWMToKLSBVc2UgYSBi
ZXR0ZXIgbmFtZSBmb3IgdmFyaWFibGVzLgotIFVwZGF0ZSBkb2N1bWVudGF0aW9uLgotIEF2b2lk
IHByZWVtcHRpb24uCgoqIFNlZSB1cGRhdGUgZGV0YWlscyBwZXIgY29tbWl0IG1lc3NhZ2UKClJv
ZHJpZ28gU2lxdWVpcmEgKDQpOgogIGRybS9hbWQvZGlzcGxheTogTW92ZSBzcGVjaWZpYyBEQ04y
eCBjb2RlIHRoYXQgdXNlcyBGUFUgdG8gRE1MCiAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgY29udHJv
bCBtZWNoYW5pc20gZm9yIEZQVQogIGRybS9hbWQvZGlzcGxheTogQWRkIGNvbnRyb2wgbWVjaGFu
aXNtIGZvciBGUFUgdXRpbGl6YXRpb24KICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBEQ19GUCBoZWxw
ZXIgdG8gY2hlY2sgRlBVIHN0YXRlCgogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L01ha2VmaWxlICAgIHwgICA0ICsKIC4uLi9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
X3RyYWNlLmggICB8ICAyNCArKysKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9k
Y19mcHUuYyAgICB8IDE0NCArKysrKysrKysrKysrKysrKysKIC4uLi9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9kY19mcHUuaCAgICB8ICAzNCArKysrKwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjX3RyYWNlLmggICAgIHwgICAzICsKIC4uLi9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyB8ICA0MSArLS0tLQogLi4uL2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5oIHwgICAyIC0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNuMjEvZGNuMjFfcmVzb3VyY2UuYyB8ICAgMiArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1sL01ha2VmaWxlICAgfCAgIDQgKwogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZG1sL2RjbjJ4L2RjbjJ4LmMgIHwgMTAyICsrKysrKysrKysrKysKIC4uLi9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RtbC9kY24yeC9kY24yeC5oICB8ICAzNCArKysrKwogZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL29zX3R5cGVzLmggICAgIHwgIDM1ICstLS0tCiAxMiBmaWxlcyBj
aGFuZ2VkLCAzNTggaW5zZXJ0aW9ucygrKSwgNzEgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYwogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNf
ZnB1LmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZG1sL2RjbjJ4L2RjbjJ4LmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZG1sL2RjbjJ4L2RjbjJ4LmgKCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
