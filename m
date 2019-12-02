Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19CFC432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CA720848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CA720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524BD6E29B;
	Mon,  2 Dec 2019 17:34:57 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820081.outbound.protection.outlook.com [40.107.82.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D576E296
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fl1FZjwAHJUCkkT/Yz843EanU0ToScLbF2XCWCiwHSHk2MwBszE9zCJGYQfYzgVS7VtQjpb8NfxkJa5ssox6X7UKushFgU5s89lyv7rwbkXuYPsLXRXTa+IsM7Eit69jRNv6dHNGtv6g1hK+BnnxAPk7CHuOfv+KCdUl607Z4Sm6LQOj9SmSUDM+V9WE9gR6BGJHmojZ0wfGjFmeHQe+LXP2k9unnUBLKYSkRl7+MQndUouN9dHqjKJakMC07utkJh0At/XIQkZ1XcnOSF6b0IWG/ufcOA6CYPKkYHQfDcqI0hA5M106Q1J4Au9ongJrkEphFkfmSinW12Qz4ZINCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCTNzCsbQKnDNZNIY8ax53VaklYuM0Glb65S6PPayE8=;
 b=Q4ERB2A0qUnr/JOTfrsgQQzYNcypl6DA/m7Te60McmiG9qkNwf3XfTWDH3JmmOTGeuvYNKBa0SUtHtGceRofYGGxPD5RIUTZ6zZqKkwmcWYOi5LMbMD87t0EUhx2wB3MP4TW0y9TYAFx6+lyUN9hhZ9xj//QIUTqmKeTUJKLpm2eJ2AOA28Ab8NE1KVCDMuAOYuXrEvkpxuS2VXSn2DjrDSfficWSkANz5BmwBNeIkCiAfc0tbo0mkMB5V58xf0YsCjHk1Xpsyib5pMNLgEwuxGx1DomnQdTLgiJ5PGlG+YekaeSe5Vvvuq/HKWJT96nT6o0Q/Wf3SWpbubJSU2pdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:34:55 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:34:55 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/51] drm/amd/display: fix DalDramClockChangeLatencyNs
 override
Date: Mon,  2 Dec 2019 12:33:20 -0500
Message-Id: <20191202173405.31582-7-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a1cf8e8-b1ee-472b-34bf-08d7774df05c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB28026304DA2F2427EA28B7BF82430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002)(213903007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i49qZWztjJ+WL+/BLl2+/+NgkNfxEkE5+VLF1zT659YGXMgQ30Zd0XHj9E82+mG6mcU7yzMCTXgOR5IUjtjMPX8fcBsffseCjbkFzXWaslZhc4HP50iE0YHz9ruWNnEqVoPChFQVhH5cOgtVtgKnwhLmAa3TouRJrUOTckrsU+UFtY9+2E75tm7DwENsYoT9HPno0PY+mJcCQSiqbEPHLuCrdV5nYif0woYzWBIvvEOMJwEeg+RzlNNgUSa3DTLzUPK4xWaFz5Sbw5Cj63uCdWPkKbTKKG158iLuKQcoihbK6xdXABec6NGXnIWov7bHEibk0uo8S3CWU2aRNvDSbLcSWQ8A3ItfzAf/PvOFjm4DGIcMmAnOIkaeNhOxbdn+gZ9f18YWVza/iJ01kEF7khJ46Or8UL/iheG2I/lR2dVhhJiDoaaGUeBLot0ccjPH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1cf8e8-b1ee-472b-34bf-08d7774df05c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:34:52.8004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSoeZRvmzKuzR4a1Aa02sAmIu32B0GKPPZnZ7JZXkWMwuv6Q8K4GjnGWReFxZlmN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCTNzCsbQKnDNZNIY8ax53VaklYuM0Glb65S6PPayE8=;
 b=uXDnzExRxcsF0dXc32uIFsVH0Qa84sfXxWM0YqRWDp5aTuK7QsjLh4IWmdmQIzABa7KTsLOsr9dpxgCkpqiRJVlHrqzUvIpQaYrB6IK5bLiJCpTndRhBBOZzg4Gzegq2TLN3OYgXPxbR6zg0x7tj7SuzjBWgv9+aepIFNKXC1pk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Eric Yang <eric.yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Joseph Gravenor <joseph.gravenor@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KClt3aHldCnBz
dGF0ZV9sYXRlbmN5X3VzIG5ldmVyIGdldHMgdXBkYXRlZCBmcm9tIHRoZSBoYXJkIGNvZGVkIHZh
bHVlCmluIHJuX2Nsa19tZ3IuYwoKW2hvd10KdXBkYXRlIHRoZSB3bSB0YWJsZSdzIHZhbHVlcyBi
ZWZvcmUgd2UgZG8gY2FsY3VsYXRpb25zIHdpdGggdGhlbQoKU2lnbmVkLW9mZi1ieTogSm9zZXBo
IEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMgWWFu
ZyA8ZXJpYy55YW5nMkBhbWQuY29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291
cmNlLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIx
L2RjbjIxX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEv
ZGNuMjFfcmVzb3VyY2UuYwppbmRleCA4MThjN2E2Mjk0ODQuLmZlZjExZDU3ZDJiNyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNl
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291
cmNlLmMKQEAgLTEwMTEsOSArMTAxMSwxMiBAQCBzdGF0aWMgdm9pZCBwYXRjaF9ib3VuZGluZ19i
b3goc3RydWN0IGRjICpkYywgc3RydWN0IF92Y3NfZHBpX3NvY19ib3VuZGluZ19ib3hfcwogCX0K
IAogCWlmIChkYy0+YmJfb3ZlcnJpZGVzLmRyYW1fY2xvY2tfY2hhbmdlX2xhdGVuY3lfbnMpIHsK
LQkJYmItPmRyYW1fY2xvY2tfY2hhbmdlX2xhdGVuY3lfdXMgPQorCQlmb3IgKGkgPSAwOyBpIDwg
V01fU0VUX0NPVU5UOyBpKyspIHsKKwkJCWRjLT5jbGtfbWdyLT5id19wYXJhbXMtPndtX3RhYmxl
LmVudHJpZXNbaV0ucHN0YXRlX2xhdGVuY3lfdXMgPQogCQkJCWRjLT5iYl9vdmVycmlkZXMuZHJh
bV9jbG9ja19jaGFuZ2VfbGF0ZW5jeV9ucyAvIDEwMDAuMDsKKwkJfQogCX0KKwogCWtlcm5lbF9m
cHVfZW5kKCk7CiB9CiAKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
