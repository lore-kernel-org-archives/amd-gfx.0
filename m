Return-Path: <SRS0=SH5p=Z2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB62C43603
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 07:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011FA2068E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2019 07:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011FA2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5F96E087;
	Wed,  4 Dec 2019 07:21:57 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790075.outbound.protection.outlook.com [40.107.79.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983E36E087
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2019 07:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh2AVHsZQArn0324/S6v1vevT0cMugVr9VFUcdfFgkot/ap6wJ95npMlC7kN/HwP8RUnvDNDw7y78z9EoCVAwsnry+hzx3mMs74zbYpcN3bYIK1yrsv21NXtPbQ05KpVvU8gDnQT/9s6s1MBiah7T70UlWXaTy/qP06baEGcac+KkkQBwOtZEfAhnNKwGQFSpk9sTo89D5HzhPs3zSC5fKd98ajETl8uVSyZ43R9aPXaKFbyVd7ogePkghpeDhZa25nAIOgzLGK078qxjY8zC5ZmkophVl+AeujEoBOw1NHLYTERfvbwFbOuGfBqDhlq3IITwWEAWx+JjgSuoC9tZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iODz1gO+InO8fF+ypYMMdz1Dk9LtTEyFQJO3aqZN2bc=;
 b=Evu8AZvZU7PWfpIiH/0yhQ0ICGe0HeXP/l5my37JrDbNu4Z80F0t4BT88jZh9cad28UqJ9xbEV2F1dJJ3o6KSjIFdSC86grp6qHkIkP6EDPF5JqX6COnyFtUyhmqNvI8+xbYHgj1FPfJ8DNWwOzhU1H26cy0cEu9clenFLLLeR1OvmrduCeihUA4k75UuW0NpTmuYRjFynVKA1C1elnZwpRcEF43Ide4mB88UIm2bjK5Xt/KMWCViaNsZuq3C6Q1GGJgVvbyBEg9WmM1WUmL+SuDZq92amN78IxS8RH9YqxbI0UIZI252hnxaVZkPRU6Kp4J1jagQ+Tgk+LCYFWFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB3360.namprd12.prod.outlook.com (20.178.241.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 07:21:52 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::18c4:9fcb:3813:14f7%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 07:21:52 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Yong Zhao <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdkfd: fix a minor typo on user queue init
Date: Wed,  4 Dec 2019 15:21:54 +0800
Message-Id: <1575444114-24209-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac15a087-b5ac-4201-8c4d-08d7788aa241
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:|MN2PR12MB3360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB336064E41968CCE66D4D4534EC5D0@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(6512007)(110136005)(54906003)(4326008)(99286004)(51416003)(52116002)(66946007)(16586007)(6436002)(6486002)(4744005)(186003)(26005)(2616005)(316002)(25786009)(5660300002)(66556008)(36756003)(66476007)(6506007)(386003)(14454004)(478600001)(86362001)(48376002)(50466002)(2906002)(6116002)(3846002)(6636002)(8936002)(81166006)(81156014)(50226002)(14444005)(305945005)(7736002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3360;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlifc8cnlkXctb+ww2tfpWY8EYgxl5tcZf7G//jC57rVHNuk0aFdnEXWazFSMwlBMmtencQMh4skRNn92oJcgh9iBzk7OVK1iWQyhLzXgBAKZwO3T76e7J2v4GfeKxH6KSH+E1BDAxWm+Gaga1vAXARZp5G3wTDn34lHRn4nE6uwfOLbM7Fn2aytYt4UO7uCzlrrCGML1+wdjmjmiuJXHr0sZyKCXNaNUKYnQnLydUSe8QJGVhs/MXDJnXrEc7tVMlx6Ci/6PBHNyImeL61LBrEkUSWkRIaFeqcpSS0DeG2LLssH6L6RYCFa14qWD7uYRRmNntkHZABRfpXLnCKURZs1w1WPW9jec526mPHXIJ6H4L++WAHX2NgY77dNuH4gJFSw0bjWMuKZ4buhC9pSALQh3uitXd7as5RqTFoBMosj0z04dXIy84EGFjvwc1OV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac15a087-b5ac-4201-8c4d-08d7788aa241
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 07:21:52.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjoPqYIRTgci6ksDKQhyI1w++VLxfQfv05HopkVZYqZeEGYB3TsfU5t1snEalVeflD1fPbPasji3NkAJHvMxfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iODz1gO+InO8fF+ypYMMdz1Dk9LtTEyFQJO3aqZN2bc=;
 b=uYXrQcu3niiNPNPoLSZU5Q/cgvXxCHHXygfBZlq/GiEVALWLCdeGn9ojEi1o0vvM+Pp+aMC3EL1W2I7g79EHvbfCh4k9AtCImDSXhL8msekyEvVeWjZy/hje31/mzP50QlFTt8NOrYL/CteuozD/Eqso3kDr614V32JC/1xT0vg=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IFBRTSAtPiBEUU0uCgpTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21h
bmFnZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
X3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
X3F1ZXVlX21hbmFnZXIuYwppbmRleCBkM2VhY2Y3Li5iN2RiNjIyIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jCkBA
IC0xODMsNyArMTgzLDcgQEAgc3RhdGljIGludCBpbml0X3VzZXJfcXVldWUoc3RydWN0IHByb2Nl
c3NfcXVldWVfbWFuYWdlciAqcHFtLAogCSgqcSktPmRldmljZSA9IGRldjsKIAkoKnEpLT5wcm9j
ZXNzID0gcHFtLT5wcm9jZXNzOwogCi0JcHJfZGVidWcoIlBRTSBBZnRlciBpbml0IHF1ZXVlIik7
CisJcHJfZGVidWcoIkRRTSBBZnRlciBpbml0IHF1ZXVlIik7CiAKIAlyZXR1cm4gcmV0dmFsOwog
fQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
