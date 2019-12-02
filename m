Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082AFC432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC18320848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC18320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCBBE6E2D1;
	Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820054.outbound.protection.outlook.com [40.107.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C54C56E2CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYu99Hiu8c/WAUdavCqhPQCsiXPUtAFZWB8HI2MewMjBBatOSZ54gKSi9jDZwyiOYawgy7D3JKEseMO7v5q9w3+NVnKx1tv1nLKYEzs12FKIv/7wb1jRUDr6S7s319J1lzVkqCxKE6P3NWcVoEaK01V3nOK3byQdmdobAzSJgM4VyMstDgrGrttHbDL9Sxa/AKGHcwv/go8alsmpaAAtnKaxBoaQs7dD4Hon5R5su43cp9o5PDaowt19+zNkvGZjGSyhcI8EKHHP/lsN3rceMnjiBqcBIqjCwlzeoTY44E+FokJ0C4yTc5D2dEFEqQgZg3V/dw/e6pGSGX7SvtDqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js79K6MSz15XKxmguJWAG0qbV+YYAgH+yI+65YTOLr0=;
 b=HOWvB6QESgDWWRxEoPQ99c7GtwOrHXpFi3a/HfCLmYRi48XYbnv6wytgrVk5QL8aZ++7CExni6ZaDcSZscIeUPZUpwi44pXywSh2qEjqY7ZbiYaJ2p/ouoZg/C7eU8JJ23KEpGyIlkpAzF+pMc04szGL4mSrlN45Wz904ieTSG/ACwDxS06JpKyq9kHM5BwdsIQ8Hl9JXMCwluOA5hgXk7ZBRQd/9aWKcWKAVQQssMETY01Gtk5//s9x4j2fD8+MBCjca6nECN3iTgKqogvPXNYmd957EtcUh65Waw+7m+1N9Zqnn/3QE5Qne/0xz+hfKQiHznCjyrm8Jr4JnFxXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:11 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:11 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/51] drm/amd/display: update p-state latency for renoir when
 using lpddr4
Date: Mon,  2 Dec 2019 12:33:40 -0500
Message-Id: <20191202173405.31582-27-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3907cefe-330c-4d73-0206-08d7774dfba9
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2802578F9590E0AA48BCB5E082430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EPFAA4qJPN086nFJ6c3aFKepTjeYM27p3b37CCsZiPRKmsA08bwc/p4PULZG2tHhpw3o2Stib6SVK0JvUOIEqy14IEEdvdlF8KMnx6CT2xDtB/ggcCHmSJDQMWD1mIyU73kcLQHTflkJTfdZcCFvCr3Aioh+TJc9zviG1wlZRG933jccUbMB38TBPJjCAE5ogLM2LIL7w6VuOpT8PaRCcPEJf8e0NsRPrCnlWjHM2oRAysmCUDpNXUXdbCQFjJVUFfknBReVgaUPnp2v+s4zQOPGK8xyie9JlJFYgxrzM2rCIeX6CAck5zMxSb33UN8Jlws2y350PaEkSRw+hLZeKrh3lLSaUei8bEoQ+QAAay1QQ4N7xFNgiRMOnqwz5LxNwF06hCWFbQfu2Y7RDfTB9u0DDiXHfiy86ouVR8J7jktJkCDhXEFxdWn9v/akHOB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3907cefe-330c-4d73-0206-08d7774dfba9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:11.7297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLdquQ5wjuJEBkmDgxdae2h/L7VQiAgtGA2sqA+jVz8BT40Qzaoics9p3DqwRBlK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js79K6MSz15XKxmguJWAG0qbV+YYAgH+yI+65YTOLr0=;
 b=AzhkAVgTfzI1Y3XPU68UuT3O4f0Tn8qT0K3PQHGPbydvhBNyygiNCQQ2yHXmyGClJwfeRdUMS4xV/txJb7jJSadV6PVhr7577gLu9es/fT2nnyoaw0GXZy4yIQP5s0MHl6I70bmpqN629C/5KtnOuijxp9FSF9wsti+2W1SRv4A=
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, Joseph Gravenor <joseph.gravenor@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSm9zZXBoIEdyYXZlbm9yIDxqb3NlcGguZ3JhdmVub3JAYW1kLmNvbT4KCltXaHldCkRG
IHRlYW0gaGFzIHByb2R1Y2VkIG1vcmUgb3B0aW1pemVkIGxhdGVuY3kgbnVtYmVycywgZm9yIGxw
ZGRyNAoKW0hvd10KY2hhbmdlIHRoZSBwLXN0YXRlIGxhZW5jeSBpbiB0aGUgbHBkZHI0IHdtIHRh
YmxlIHRvIHRoZSBuZXcgbGF0ZW5jeQpudW1iZXIKClNpZ25lZC1vZmYtYnk6IEpvc2VwaCBHcmF2
ZW5vciA8am9zZXBoLmdyYXZlbm9yQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENoZW5nIDxU
b255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9jbGtf
bWdyLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
bGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3IuYwppbmRleCAzMDdjODU0MGUzNmYuLjkwMWU3MDM1
YmY4ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3Iv
ZGNuMjEvcm5fY2xrX21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
bGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3IuYwpAQCAtNTYyLDcgKzU2Miw3IEBAIHN0cnVjdCB3bV90
YWJsZSBscGRkcjRfd21fdGFibGUgPSB7CiAJCXsKIAkJCS53bV9pbnN0ID0gV01fQSwKIAkJCS53
bV90eXBlID0gV01fVFlQRV9QU1RBVEVfQ0hHLAotCQkJLnBzdGF0ZV9sYXRlbmN5X3VzID0gMjMu
ODQsCisJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAxMS42NTMzMywKIAkJCS5zcl9leGl0X3RpbWVf
dXMgPSAxMi41LAogCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1lX3VzID0gMTcuMCwKIAkJCS52
YWxpZCA9IHRydWUsCkBAIC01NzAsNyArNTcwLDcgQEAgc3RydWN0IHdtX3RhYmxlIGxwZGRyNF93
bV90YWJsZSA9IHsKIAkJewogCQkJLndtX2luc3QgPSBXTV9CLAogCQkJLndtX3R5cGUgPSBXTV9U
WVBFX1BTVEFURV9DSEcsCi0JCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAyMy44NCwKKwkJCS5wc3Rh
dGVfbGF0ZW5jeV91cyA9IDExLjY1MzMzLAogCQkJLnNyX2V4aXRfdGltZV91cyA9IDEyLjUsCiAJ
CQkuc3JfZW50ZXJfcGx1c19leGl0X3RpbWVfdXMgPSAxNy4wLAogCQkJLnZhbGlkID0gdHJ1ZSwK
QEAgLTU3OCw3ICs1NzgsNyBAQCBzdHJ1Y3Qgd21fdGFibGUgbHBkZHI0X3dtX3RhYmxlID0gewog
CQl7CiAJCQkud21faW5zdCA9IFdNX0MsCiAJCQkud21fdHlwZSA9IFdNX1RZUEVfUFNUQVRFX0NI
RywKLQkJCS5wc3RhdGVfbGF0ZW5jeV91cyA9IDIzLjg0LAorCQkJLnBzdGF0ZV9sYXRlbmN5X3Vz
ID0gMTEuNjUzMzMsCiAJCQkuc3JfZXhpdF90aW1lX3VzID0gMTIuNSwKIAkJCS5zcl9lbnRlcl9w
bHVzX2V4aXRfdGltZV91cyA9IDE3LjAsCiAJCQkudmFsaWQgPSB0cnVlLApAQCAtNTg2LDcgKzU4
Niw3IEBAIHN0cnVjdCB3bV90YWJsZSBscGRkcjRfd21fdGFibGUgPSB7CiAJCXsKIAkJCS53bV9p
bnN0ID0gV01fRCwKIAkJCS53bV90eXBlID0gV01fVFlQRV9QU1RBVEVfQ0hHLAotCQkJLnBzdGF0
ZV9sYXRlbmN5X3VzID0gMjMuODQsCisJCQkucHN0YXRlX2xhdGVuY3lfdXMgPSAxMS42NTMzMywK
IAkJCS5zcl9leGl0X3RpbWVfdXMgPSAxMi41LAogCQkJLnNyX2VudGVyX3BsdXNfZXhpdF90aW1l
X3VzID0gMTcuMCwKIAkJCS52YWxpZCA9IHRydWUsCi0tIAoyLjI0LjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
