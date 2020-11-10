Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF56C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 07:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2D920781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lV+QyCb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2D920781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E718982F;
	Tue, 10 Nov 2020 07:27:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 906FF8982F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 07:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j28Oe+7MfgWTrVlXEnhXCib/7z/XfkZSTMZwQMlNAo4/psKOPBq/yHjb+F/0/khn8vs/hrTsq2DgwUPt5C8LwLGJ9jBAF0k3W6yCnR91UYpx8X7rEvuwNAnFkNXLWzKkNRku22SkmVUozFDlxC8wdWBy7p4xscHpiTSF+nCcbzdxgZ/ZdwFISoaStU5PeL4601puI6R2xDgF/ol8iD0Ly0zJ3HYrXg0XFoItOOAjpYRs9hJKaH9h7IrVZt0I92IB8lAaqNO5l3LYzfVQc3Uge7XasCDGFyRiRcoc5egpmCNfFR7X3ZEJiPZaH+KoTosgkLxHpv3OuQfihl+TmjxSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60D2gDaaXzVpmYHCTp+BW+CmGXjK2GUwyvsGAtO3zf4=;
 b=Ybutv1RPwL/csJWd6eQOae9R3G9RPuPONWSCr+DssUKFg9DNRe28MSRipK1uqdNp33QVhan6irSATjYRlRbQS/eLoQIppH4HpoIg6wzDxwYJ2ozODvnI+6l2drEs6V1/J5GA9tM0mGfz6aj8plm83YbwC8xAuFTvz/OOZ1no78/dkX/uC2iJuiu2xoonHsldjh//jExTVGylf9ivN41yrO1a5iJBGy86C3eX5JgoPhfnpv4HhBnkU3GztFMH9RgEz2P2I5ditxBdWmSyGN422AKn4MM7pazJ2dySBWQj4UecF9sjz2y+YSlyhIteviKPNoMXv/oupmf8ve3oA4745g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60D2gDaaXzVpmYHCTp+BW+CmGXjK2GUwyvsGAtO3zf4=;
 b=lV+QyCb9pS9fD4hZDA3hAVlYQL0YiUkpCMDnbGEdhn0smWpg8LMYc0JkM20tdBNXZIdXbjjwvq89poH+BMN2w2zDx6dIH1DOFnbx3cTWBayktUuCek+QXwST8gqsyAt4IN+Et8rb+o1f7tpCeUYhnGpRbxbacNBKgcuGjgeZk38=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3001.namprd12.prod.outlook.com (2603:10b6:5:116::28)
 by DM5PR12MB1531.namprd12.prod.outlook.com (2603:10b6:4:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Tue, 10 Nov 2020 07:27:15 +0000
Received: from DM6PR12MB3001.namprd12.prod.outlook.com
 ([fe80::dd64:c991:d225:9bd2]) by DM6PR12MB3001.namprd12.prod.outlook.com
 ([fe80::dd64:c991:d225:9bd2%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 07:27:15 +0000
From: Mengbing Wang <mengbing.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct table_clk_vlt memory size due to
 replacing one-element array with flexible-array in struct
 phm_clock_voltage_dependency_table
Date: Tue, 10 Nov 2020 15:26:44 +0800
Message-Id: <20201110072644.4993-1-mengbing.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:203:c9::6) To DM6PR12MB3001.namprd12.prod.outlook.com
 (2603:10b6:5:116::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from code-machine.amd.com (58.247.170.242) by
 HKAPR03CA0019.apcprd03.prod.outlook.com (2603:1096:203:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.13 via Frontend Transport; Tue, 10 Nov 2020 07:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c252214-dff5-4109-0b08-08d8854a0c50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15318563DA5616FEC9809B99EFE90@DM5PR12MB1531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYgcpqJXVZky6QGnyuc7z0JZQLgTx2RL61bqsyiZanUQJyXtC9pp7qTt5tGgxCshUnsO/+Dei6yBZimo6pa5jAub4LkwhcE/wua0yOCq3ATHcelS46d8HshxpOKmywos2s4LfwX/k6bSKk5STnZ4xpGHiSD3XWALGKenntYUv61NEM0Qspy9Fw33gSfCJ3l3XDLWepPlcqAZpAiuOJ/VziP87z/lj+giy+TjIo5IRdeFFKyePPCNepqME1PcuB/4nEENBVG43JFr3SZanT14LRFVuQ0SUOnCL7MaewZ/1trpWHseMCnzBFV/N/2mJYc5Fgem3UhaNyqgxX/hMXtNdyHaPutcF9RMolC6Rl1iph2xWLz5wHxTPhJhZDbPXuG9y1BSw9PSNJwvsUT28H40hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3001.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(86362001)(6916009)(478600001)(5660300002)(4326008)(316002)(52116002)(7696005)(66476007)(966005)(36756003)(16526019)(66556008)(1076003)(186003)(2616005)(8676002)(26005)(956004)(8936002)(83380400001)(6666004)(6486002)(66946007)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Hn6IbVOcH3SBEGiwlMvFOOHlOArj5eTr5q1St+CD1vyvH/vi5FxENK8ty8VJ8epOll7ZKrwerRgb1T8uRRPz//kE+k85Nq+/ia938cWsbnnvcKr0ZrmK/sgYoX9SLubo444Shz3I0/KhOlVb+hl92+z4mOoLtO8eCeAv1xK6v6hFbn2CeocXFhD98J1MKA50wgTMiFnAOoWExxGt9dHQb7UXsIvcxEGqnfQLjeyKHe5JAbDUD7LttE74zCOXanCWiOUz8v+FmQwbLOPsLUF1r/WA01ZjSi/vkQZjZWYQPcZp814yBL56Y5CTPITn77OFLpmyOpVWCRPsbrTNMhwU1eaqQnbvsDc267DnbcA5hbwhAM8n2/Fuam2PHhzPJDjAcedYQGYaITRwajCo/Ab9IgJW2LAAgN3ppNEwNtx0MbX/DrqA5uX02GeaZYg45k2JjcdKqnLQwfsHiuhZPtANgg2lZiW1hSJEdD+N62AhGAdXLmV1iQErvRrqJF/dXt1OawDY0k5iwWmHMvwJ7id9xiPS88V9rbtoVHLPom48+onORTUXTG74ykk5070aJesQnHAbXQvmtgfc6rBG67c85ibr/lU8i9+PUdBOk2FDfLei0PRkN+1X1AnY58QP7r/bKtzInWVNiSaqmkwRmg0xsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c252214-dff5-4109-0b08-08d8854a0c50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 07:27:15.4800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rChdFj6/CRFRUFbJ7ayGYeSXGyNbmMm98cPRCsnLkMxeHNlL4Fq+kefAfjj9NK+OVP3K6swW7D3YFM9NVOVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1531
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
Cc: mengbing wang <mengbing.wang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogbWVuZ2Jpbmcgd2FuZyA8bWVuZ2Jpbmcud2FuZ0BhbWQuY29tPgoKCkFkZCAxIHRvIHRo
ZSBzaXplIHBhc3NlZCB0byBremFsbG9jIGFmdGVyIHJlcGxhY2luZyBvbmUtZWxlbWVudCBhcnJh
eS4KClRoZXJlIGlzIGEgcmVndWxhciBuZWVkIGluIHRoZSBrZXJuZWwgdG8gcHJvdmlkZSBhIHdh
eSB0byBkZWNsYXJlIGhhdmluZwphIGR5bmFtaWNhbGx5IHNpemVkIHNldCBvZiB0cmFpbGluZyBl
bGVtZW50cyBpbiBhIHN0cnVjdHVyZS4gS2VybmVsIGNvZGUKc2hvdWxkIGFsd2F5cyB1c2Ug4oCc
ZmxleGlibGUgYXJyYXkgbWVtYmVyc+KAnVsxXSBmb3IgdGhlc2UgY2FzZXMuIFRoZSBvbGRlcgpz
dHlsZSBvZiBvbmUtZWxlbWVudCBvciB6ZXJvLWxlbmd0aCBhcnJheXMgc2hvdWxkIG5vIGxvbmdl
ciBiZSB1c2VkWzJdLgoKUmVmYWN0b3IgdGhlIGNvZGUgYWNjb3JkaW5nIHRvIHRoZSB1c2Ugb2Yg
YSBmbGV4aWJsZS1hcnJheSBtZW1iZXIgaW4Kc3RydWN0IHBobV9wcHRfdjFfbW1fY2xvY2tfdm9s
dGFnZV9kZXBlbmRlbmN5X3RhYmxlLCBpbnN0ZWFkIG9mIGEKb25lLWVsZW1lbnQgYXJyYXksIGFu
ZCB1c2UgdGhlIHN0cnVjdF9zaXplKCkgaGVscGVyIHRvIGNhbGN1bGF0ZSB0aGUKc2l6ZSBmb3Ig
dGhlIGFsbG9jYXRpb24uCgpbMV0gaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvRmxleGli
bGVfYXJyYXlfbWVtYmVyClsyXSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y1Ljkt
cmMxL3Byb2Nlc3MvZGVwcmVjYXRlZC5odG1sI3plcm8tbGVuZ3RoLWFuZC1vbmUtZWxlbWVudC1h
cnJheXMKClNpZ25lZS1vZmYtYnk6IE1lbmdiaW5nIFdhbmcgPG1lbmdiaW5nLndhbmdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21n
ci5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21n
ci9zbXUxMF9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Iv
c211MTBfaHdtZ3IuYwppbmRleCBjZjYwZjM5OTIzMDMuLjEzM2EwODQ0NDk0MyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211MTBfaHdtZ3IuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5j
CkBAIC0xMzAsOSArMTMwLDEwIEBAIHN0YXRpYyBpbnQgc211MTBfY29uc3RydWN0X21heF9wb3dl
cl9saW1pdHNfdGFibGUoc3RydWN0IHBwX2h3bWdyICpod21nciwKIHN0YXRpYyBpbnQgc211MTBf
aW5pdF9keW5hbWljX3N0YXRlX2FkanVzdG1lbnRfcnVsZV9zZXR0aW5ncygKIAkJCQkJCQlzdHJ1
Y3QgcHBfaHdtZ3IgKmh3bWdyKQogeworCWludCBjb3VudCA9IDg7CiAJc3RydWN0IHBobV9jbG9j
a192b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUgKnRhYmxlX2Nsa192bHQ7CiAKLQl0YWJsZV9jbGtf
dmx0ID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZSh0YWJsZV9jbGtfdmx0LCBlbnRyaWVzLCA3KSwKKwl0
YWJsZV9jbGtfdmx0ID0ga3phbGxvYyhzdHJ1Y3Rfc2l6ZSh0YWJsZV9jbGtfdmx0LCBlbnRyaWVz
LCBjb3VudCksCiAJCQkJR0ZQX0tFUk5FTCk7CiAKIAlpZiAoTlVMTCA9PSB0YWJsZV9jbGtfdmx0
KSB7CkBAIC0xNDAsNyArMTQxLDcgQEAgc3RhdGljIGludCBzbXUxMF9pbml0X2R5bmFtaWNfc3Rh
dGVfYWRqdXN0bWVudF9ydWxlX3NldHRpbmdzKAogCQlyZXR1cm4gLUVOT01FTTsKIAl9CiAKLQl0
YWJsZV9jbGtfdmx0LT5jb3VudCA9IDg7CisJdGFibGVfY2xrX3ZsdC0+Y291bnQgPSBjb3VudDsK
IAl0YWJsZV9jbGtfdmx0LT5lbnRyaWVzWzBdLmNsayA9IFBQX0RBTF9QT1dFUkxFVkVMXzA7CiAJ
dGFibGVfY2xrX3ZsdC0+ZW50cmllc1swXS52ID0gMDsKIAl0YWJsZV9jbGtfdmx0LT5lbnRyaWVz
WzFdLmNsayA9IFBQX0RBTF9QT1dFUkxFVkVMXzE7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
