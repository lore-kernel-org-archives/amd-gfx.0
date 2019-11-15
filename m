Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F900C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0F920709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0F920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07E96F3E7;
	Fri, 15 Nov 2019 03:35:16 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4AA6F3E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK47/7VKVLfh75WZqMJWieY8Npz2bQ74GOTpa244HHABSEkAasQHGrIEB4qEO9ZdgOFpj/PrhGdx6W/uF9f1RtPKHPVf27WtaLb8+cJC1GhVA4uqCmgSilwMiVFuoNdgowteEvcxNRtyfDB/4YEFEG44+NkmknN4bDZ770Ru7PEgrE6G+5eVKUKXHat6ZvMfuirykauD3zmSxpibSY/U2mwuP0OFHOjv/AvXf3kibj/8YAG04MNdlsQOy1+jDRSr21BVf0Db/6VS2IJV6nKtxzcuVxUKgIu9yNwkvqW68S5fnOyM+MVsXoiiFga66Uk2l9G14pHbwC42FHHo8TypDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+6dJLKGM4q6E6t5Y1omhRIJ5mJk/6TJkAd3L6Kewrk=;
 b=Gi9DDO1lldiic+TA/oIZ+y1VZCE2dIifu4TE9uPu8DNqXG8Z/1l7UahkvcJ6GEtKM5I/pKzy1FLtnBxmHaQurb3upSZ7j0z7/kC4JtavQcvFKT72LEHWRuxxlNiOnkIxRsH8D32IPjoeAzFJxq990dsp1DWXuWDdWQ01c6IqHu48wR3FSEOF1SKFCxfwsxIqQ4iU1OYwBJH/d3wLO5STIfYva/A/5XNzBklnQZ/tJ+/jPzvhepOy/f4eQHXnPypM5/GQjR8O1egDkuAqSs251Mav0lmU40JsVLNgnqbLJ39TEWR/AXh+lVwrHyfzbaesdVexqHCl7jiqafnHTFVEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:14 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:14 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/12] amdgpu: add UAPI for creating encrypted buffers
Date: Fri, 15 Nov 2019 11:34:44 +0800
Message-Id: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bf2d217-6f9f-46b1-91e0-08d7697cd37a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36632986251C9AECEE289F99F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(7736002)(386003)(26005)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqOvnyorTEd6Xpl+EF4Ao/VGFIscD+Xwxak6d49rFeFPByPOAaEjPd4bjxEKYJkMW0ljCHNSGgvM45McQJu1iXQ92lq6v3dxc9REbL1qXMqAASMo9aI5XpfxLtuiCbjcfEESSedzCzZl8CB9MI00C4sKZ2Uojp1zW311MpDYY24SbNVOYUe9bAWRlOdBqh7DUQ2oHAI4KWJ20BzL0a4L3IJUkIau6mr/KBXHsAxhmJu9bA148cdF/0jAcbHF3OQG5hDYGD5EWzwxQsvnzuSRvruo4TYTNjG39YErySIT9qKiZeeZ5kypoUteItDlm6+BNkc1++s9DJ4AqKTrvXhckQa7h8eO9dKu8N9LBZ07naUhE8PVbRSUP3c3ZHbvdjH6rIOMu6abZk+JKusVNXseK3+uopzj4oMxBiEuY37i06cSVE5aML1/427M9G4Pa3OC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf2d217-6f9f-46b1-91e0-08d7697cd37a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:14.5347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WNlt+mNTEllvm0miHXjFBbcBAEccMRMEFvZ/PID4Tbxpx1DonozRu5fwyqBcj5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+6dJLKGM4q6E6t5Y1omhRIJ5mJk/6TJkAd3L6Kewrk=;
 b=sHTfuN5vX648nkjGtx7XqYQiZIJUuclZZxveWoEIgjQIDpn85j59OD6hUyD/e8C209eXuKllKapg/XwVyJobKRsjiSFHz+zJiAXcYlVOljldcThVFNwd38NssmHlnWcHRChx6/PEZCFp6BOmFz75oL8jZavrLSiKjzPkSk9C4Jk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Marek.Olsak@amd.com, Huang Rui <ray.huang@amd.com>, Luben.Tuikov@amd.com,
 Alexander.Deucher@amd.com, Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033444.O7sBpAQSXBAKMehnTDhrlAUQxb-yUzDteszzWB4HOiM@z>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRvIGFsaWduIHRoZSBrZXJuZWwg
dWFwaSBjaGFuZ2UgZnJvbSBBbGV4OgoKIkFkZCBhIGZsYWcgdG8gdGhlIEdFTV9DUkVBVEUgaW9j
dGwgdG8gY3JlYXRlIGVuY3J5cHRlZCBidWZmZXJzLiBCdWZmZXJzIHdpdGgKdGhpcyBmbGFnIHNl
dCB3aWxsIGJlIGNyZWF0ZWQgd2l0aCB0aGUgVE1aIGJpdCBzZXQgaW4gdGhlIFBURXMgb3IgZW5n
aW5lcwphY2Nlc3NpbmcgdGhlbS4gVGhpcyBpcyByZXF1aXJlZCBpbiBvcmRlciB0byBwcm9wZXJs
eSBhY2Nlc3MgdGhlIGRhdGEgZnJvbSB0aGUKZW5naW5lcy4iCgpXZSB3aWxsIHVzZSBHRU1fQ1JF
QVRFX0VOQ1JZUFRFRCBmbGFnIGZvciBzZWN1cmUgYnVmZmVyIGFsbG9jYXRpb24uCgpTaWduZWQt
b2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGluY2x1ZGUvZHJtL2FtZGdw
dV9kcm0uaCB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL2RybS9hbWRncHVfZHJt
LmgKaW5kZXggNWMyOGFhNy4uMWE5NWUzNyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9kcm0vYW1kZ3B1
X2RybS5oCisrKyBiL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaApAQCAtMTQxLDYgKzE0MSwxMSBA
QCBleHRlcm4gIkMiIHsKICAqIHJlbGVhc2luZyB0aGUgbWVtb3J5CiAgKi8KICNkZWZpbmUgQU1E
R1BVX0dFTV9DUkVBVEVfVlJBTV9XSVBFX09OX1JFTEVBU0UJKDEgPDwgOSkKKy8qIEZsYWcgdGhh
dCBCTyB3aWxsIGJlIGVuY3J5cHRlZCBhbmQgdGhhdCB0aGUgVE1aIGJpdCBzaG91bGQgYmUKKyAq
IHNldCBpbiB0aGUgUFRFcyB3aGVuIG1hcHBpbmcgdGhpcyBidWZmZXIgdmlhIEdQVVZNIG9yCisg
KiBhY2Nlc3NpbmcgaXQgd2l0aCB2YXJpb3VzIGh3IGJsb2NrcworICovCisjZGVmaW5lIEFNREdQ
VV9HRU1fQ1JFQVRFX0VOQ1JZUFRFRAkJKDEgPDwgMTApCiAKIC8qIEh5YnJpZCBzcGVjaWZpYyAq
LwogLyogRmxhZyB0aGF0IHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBzaG91bGQgYmUgZnJvbSB0b3Ag
b2YgZG9tYWluICovCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
