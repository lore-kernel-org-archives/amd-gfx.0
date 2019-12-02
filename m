Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A0DC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CFA20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CFA20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A4D6E2D3;
	Mon,  2 Dec 2019 17:35:19 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6746E2CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1EandrkQV4x3m/uBPjNPPlViDJ5grZ2kucvgabLcU/iPO0IrA1w/lsO81k3qMDipLnX7Fb2op6MUS3HoGnKsNlRBJiXm2cF3DcBQiKO7NFxIZzPRyjcr0EobZsf8jdHvPSM55FULEh7sgGalg29PKFz5OAAnHJZ68A0HH+kjimmQfdWfC3kWE9K9FXKotbrsdLhYKr9ioMbX9IJdUqV9t5DFphpShYXdNBuSm7OYhfUw/ZVfmRsyEMBNueBs6jvkA1+WGDWMpnrTkkX2AJgYaSsUevCVYLwAzuepHcF/Bz1M5ogP3rCcY0supvOVv14pEwZrTOux1un0n8snbB+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9aiHf820FLv7EOeioUFDqOXzfcswwBRFu40FOMNoXc=;
 b=nmESaD57bRFDaPeNx8ffyzkVMH0cNEK/sLRbsxR6gERKo/ARW9s4HU2hS/h0f/ilQcSsBwNNMeCC+aKQgSGOZgx5xy91Qj/exARB3xqDAnprmeaIivvs5+7K+5AqRVdh8QHsEUlUH5gyf9wdsrNa2PS8DUVfCIMa8g9qweU04qNJPIjCKtmOSg5qNdVaozwjLzS+w+svm2nggWgdPutrSoKH2z9yDgWviihhYqESU93cEQwKlrM2YIJTiBRtu9LDpYh3KcxZU8p9vtaDfmQGjUaDKF7qs0Nxrk8tlPn9hElR598HpE+Jh+oTtfBQpcDgm94eFo2Hj4v0PIEnhu/uag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:14 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:14 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/51] drm/amd/display: Return a correct error value
Date: Mon,  2 Dec 2019 12:33:43 -0500
Message-Id: <20191202173405.31582-30-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3a5f4146-1a88-4032-007e-08d7774dfd3b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610EA84EA477CC07C7874AA82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1nqzdVLXKxpp781JL+KipLIwnFA0DKrVTJRtwAjkpCiA37PSgyW1k56hce5s+i3zJzYWSM28aiU8K3lHlKOhf5wlS7ZxogcLxduIm+V8CinMU9yGXk3IQNTwPmIocsAqVFr3rzjfWlAQ/k1d4l+uGHzt1ZiTmkzDETYErGzeJXkTbs9iR5+4iDZacaStIndE9z1DiyUMIStAxCFMzJnczTN3HumnWp4p/NNb46/qp8TFBrgwMxhNvLjQT7Utduj/Awp4mn68SEisZz+kmfbX77wW5jQaOx4PwIMp+QcQPJ82iwKP59RlfVxWMoCwbYcPerjFb0X5tN0xIDg+zSa6hFWoR030cE1TtXNWSW6rfBggH6tzg/HbjltBvo7UDMvo8Z3LXnHMepYljOuKbvNyKzoN+3fPkHoNQJaqnCPz25p355GYUsMK4eIB5lK5C5e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5f4146-1a88-4032-007e-08d7774dfd3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:14.3642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoBlSrx78EtHTl9JLECQiW4xapu6GIJnm76cPpVg/9LFl7f7bViQFsu//K6+r+oM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9aiHf820FLv7EOeioUFDqOXzfcswwBRFu40FOMNoXc=;
 b=hXogmNohyRr+kQcIWZ4otEzFR8ocCTm/SHUzG8fgAW9xR/eO8q/L900KuJiYNRDkVF6dCOZ/tSx9lNuqmZq3fMi4FstShwUx0HkNQ3H9QAyIOXLCpok9VDSdp+utsbsX7W83NcSG26LsEIrDTysDEoXbo3C3ACk7yQdJxddDdDc=
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Martin Leung <Martin.Leung@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, bhawanpreet.lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW3doeV0KVGhlIGZ1
bmN0aW9uIGlzIGV4cGVjdGVkIHRvIHJldHVybiBpbnN0YW5jZSBvZiB0aGUgdGltaW5nIGdlbmVy
YXRvcgp0aGVyZWZvcmUgd2Ugc2hvdWxkbid0IGJlIHJldHVybmluZyBib29sZWFuIGluIGludGVn
ZXIgZnVuY3Rpb24sCmFuZCB3ZSBzaG91bGRuJ3QgYmUgcmV0dXJuaW5nIHplcm8gc28gY2hhbmdp
bmcgaXQgdG8gLTEuCgpTaWduZWQtb2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tp
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBNYXJ0aW4gTGV1bmcgPE1hcnRpbi5MZXVuZ0BhbWQuY29t
PgpBY2tlZC1ieTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CkFja2VkLWJ5OiBM
ZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY29yZS9kY19yZXNvdXJjZS5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKaW5kZXggYTk0MTI3MjBjODYwLi4wYzE5ZGU2
NzgzMzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
X3Jlc291cmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
cmVzb3VyY2UuYwpAQCAtMTg2Niw3ICsxODY2LDcgQEAgc3RhdGljIGludCBhY3F1aXJlX3Jlc291
cmNlX2Zyb21faHdfZW5hYmxlZF9zdGF0ZSgKIAlpbnN0ID0gbGluay0+bGlua19lbmMtPmZ1bmNz
LT5nZXRfZGlnX2Zyb250ZW5kKGxpbmstPmxpbmtfZW5jKTsKIAogCWlmIChpbnN0ID09IEVOR0lO
RV9JRF9VTktOT1dOKQotCQlyZXR1cm4gZmFsc2U7CisJCXJldHVybiAtMTsKIAogCWZvciAoaSA9
IDA7IGkgPCBwb29sLT5zdHJlYW1fZW5jX2NvdW50OyBpKyspIHsKIAkJaWYgKHBvb2wtPnN0cmVh
bV9lbmNbaV0tPmlkID09IGluc3QpIHsKQEAgLTE4NzgsMTAgKzE4NzgsMTAgQEAgc3RhdGljIGlu
dCBhY3F1aXJlX3Jlc291cmNlX2Zyb21faHdfZW5hYmxlZF9zdGF0ZSgKIAogCS8vIHRnX2luc3Qg
bm90IGZvdW5kCiAJaWYgKGkgPT0gcG9vbC0+c3RyZWFtX2VuY19jb3VudCkKLQkJcmV0dXJuIGZh
bHNlOworCQlyZXR1cm4gLTE7CiAKIAlpZiAodGdfaW5zdCA+PSBwb29sLT50aW1pbmdfZ2VuZXJh
dG9yX2NvdW50KQotCQlyZXR1cm4gZmFsc2U7CisJCXJldHVybiAtMTsKIAogCWlmICghcmVzX2N0
eC0+cGlwZV9jdHhbdGdfaW5zdF0uc3RyZWFtKSB7CiAJCXN0cnVjdCBwaXBlX2N0eCAqcGlwZV9j
dHggPSAmcmVzX2N0eC0+cGlwZV9jdHhbdGdfaW5zdF07Ci0tIAoyLjI0LjAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
