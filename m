Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460ACC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 11:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B8D20771
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 11:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ucbuWdZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B8D20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55276E9BF;
	Thu, 13 Aug 2020 11:32:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 013046E9BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 11:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meCJMCIS5Sp5PHHMiiOCzR0RJFSSo+yUrkro0WD/3cTu1EiWugzTJzdgy4zkhOxTKmxyju/eLmyx4XRrRYc2VoI7JWVcEzmSfeL52YjUpQCF3IVGpqRHUbBpgW3UHpvIOjGadPJIFWCDbom5xvBhzKUSABSpymAg+aeg7b6aF80iNPvLHDQN1V8jNPNZCkzzfwmv6LPX9JaMFkoeP0pUXzlUypkLXU6X+hM9sYhq0GB+e5dN6sedsZQbjINzayM/dxGUi/b+NciVBeUS0zOjo/A/eQRyoqVq8Qi8XWdtYHtOu+YVj8Wwtvn68YoBqsjMmtU4IPGbB0REClAoxnX9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5hTIj+s51x29LXEHErU1lrDan2wOBAeaFJ+W/bXNsE=;
 b=eK4uEHSc5bbb9WFjEjQ7Bh1umaIi07YJceqbt0B2SfSrZr+OBLW1pGqmJxZyfEf/IZ74Xa/cqDBvRT2qUQa7UwC6D5mwQ73xiLO684FUPXFdB7W5AuJtFmS01DE0vxi8katLQGVtTFqz/10BSCu2xiB09tUp3zzvj0L1AqWKSM/WVJkAXsIdzuBHK6Bf+Z2dr4LeJZubvE/kxYxAbm4y51EDX9koOmM6uuMQPlULLODEA4k9LJERmhCW5eAhXBkjFMRl+Sf6r148tm9ZHIPsOR6N6y4JSJfvUT3I7TS3AVzYFaArAmvuozmuC71m+ThTsdW9cvwHbWQZLq0DtQVOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5hTIj+s51x29LXEHErU1lrDan2wOBAeaFJ+W/bXNsE=;
 b=ucbuWdZVlv2qSXvaHDiIQk4oORsDlbaJ1KOYvd64BVVt8Cx8btUslajITK3CsdbYEXVDol83d0T0V55mK7MF3onl0F3O44NDLJYEgiDNwLjr4xvU3JL4UGxqB1wncC31DLxWqaI4BS9rVOjnVZHkXm90Es565oxVIkKnllGi4Aw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3549.namprd12.prod.outlook.com (2603:10b6:208:107::17)
 by MN2PR12MB3487.namprd12.prod.outlook.com (2603:10b6:208:c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Thu, 13 Aug
 2020 11:32:42 +0000
Received: from MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::d82b:d4a2:7ef2:c42d]) by MN2PR12MB3549.namprd12.prod.outlook.com
 ([fe80::d82b:d4a2:7ef2:c42d%3]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 11:32:41 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus ppt
 driver (v2)
Date: Thu, 13 Aug 2020 07:32:32 -0400
Message-Id: <20200813113232.287411-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN1PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:408:e0::28) To MN2PR12MB3549.namprd12.prod.outlook.com
 (2603:10b6:208:107::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN1PR10CA0023.namprd10.prod.outlook.com (2603:10b6:408:e0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 11:32:41 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bb774d2-9962-461b-794d-08d83f7c9713
X-MS-TrafficTypeDiagnostic: MN2PR12MB3487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34873B7B541F81B0B2BC10B0F7430@MN2PR12MB3487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hSyJ9DPng66VWQrpKS3OAKmIgSFxrQuoQ5/e+TKgOSih2/D+Rpg3wcTx0/tDNBwraJrLPLBMCXWVec44gk5OehYKqf9FjYEbw3RaTXNAl6k5ehvrur7DE2NrNsaxxTLEf8TjuLpJe7v/CNfG6kCb2H3IV4J9g8wSKqhlGK6Q7q8skMOXAI5ArDLo4qgGQEJVjxxV6Ld0f2WU1c9OnSupJD1QSNEFcIFKa8IkVC1Z1IpB6UmLPCkQuV8XeOQdgaiH26YJNbBk7wtGrNiL913wIBodEZdBr3yyvVB3X+BlGGv2wjkNTFisccgxZzspUN03L9l/YbVdS1325c8MKPqCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(8936002)(8676002)(2906002)(478600001)(6486002)(36756003)(316002)(4326008)(6916009)(2616005)(956004)(83380400001)(86362001)(66556008)(66946007)(66476007)(5660300002)(52116002)(7696005)(186003)(26005)(16526019)(6666004)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: N5jwZpziR1QurowvBIm9VgU43cDkOVfN9xoTj71NFh6CGTMzVo02WIhACsH6PujQIjh2MYAR9iqBDXrpFRkD1M2C26EhfhVhJqGngSQu6JI+hryhLMTlY5FamzFkU5YqSC18X7Kc3m6YKj2U58UHQRIr8HJT5/iEPRdk9ShQqLLnDS1ukxnsqZWR3LFX+DjOL1UyCvJbPEtwfDuZUTbM9GyMttoJrzN5kow4rOtEpi9IGe0T+Xy/DS/2RUShUATeObVTVFHy4HqK7gIya3AEC7i/ksuufbr5ZhtiRt+K2F8E23VMJIGMzPYpjUyghBdCvBsXXJ7+wqWS/Z3lPsx37hXnt/gj9tC+ZelNHkJqbYBvyFKcPXn4CODN4ADb8SrlBtee/gyiREwn02WSLaWSSjGEbtfWMe1aD0cxPPe9OG22uLor1ZDoKE2wW4Pspgh/cKBBecyUMo0IF5ekhaGfTQu5OoUTrXTq6tJ3RjlviHJxnBAfZ7zrgDCS1zKnouGlsBX0jTzIk/Nc3ZAhcfb96HJu1NB0uXGgUdN+XRc+bSl+QKT/DiYkckJud7Cr51rN0pHfH+377zyh8DsW5u4KiQBpAHOw9Y4cZFkvRNNCCRTM/jMZ1LjrgI9B+NVcf78bpJ2QtP8o58Z5YQsH7GVHHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb774d2-9962-461b-794d-08d83f7c9713
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 11:32:41.8404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOsMUDu5ITcQPzS8CL+DQE79eqfhNslvpwC1Y8DGrri6aBbezmvQpvZoEYw64BiG1n7lmtQaTgywfp0uyAknTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3487
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXM6CgogIENDIFtNXSAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5vCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYzogSW4gZnVuY3Rpb24g4oCYYXJjdHVydXNfbG9n
X3RoZXJtYWxfdGhyb3R0bGluZ19ldmVudOKAmToKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jOjIyMjM6MjQ6IHdhcm5pbmc6IOKAmHRocm90dGxl
cl9zdGF0dXPigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V21heWJlLXVuaW5pdGlhbGl6ZWRdCiAyMjIzIHwgICBpZiAodGhyb3R0bGVyX3N0YXR1cyAmIGxv
Z2dpbmdfbGFiZWxbdGhyb3R0bGVyX2lkeF0uZmVhdHVyZV9tYXNrKSB7CgpCeSBhc3NpZ25pbmcg
YW4gaW5pdGlhbCB2YWx1ZSBhbmQgYWxzbyBjaGVja2luZyBmb3IgZXJyb3JzIG9uIHRoZSBjYWxs
IHRvCmFyY3R1cnVzX2dldF9zbXVfbWV0cmljc19kYXRhKCkuCgoodjIpOiBkb24ndCBzZXQgZGVm
YXVsdCBpbiBhcmN0dXJ1c19nZXRfc211X21ldHJpY3NfZGF0YSgpCgpTaWduZWQtb2ZmLWJ5OiBU
b20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCAxMSArKysrKysrKy0tLQogMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCmluZGV4IDhiMTAyNWRjNTRmZC4uZjZmZThlMGZm
OTc3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19w
cHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwpA
QCAtMjIwOCwxNSArMjIwOCwyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRocm90dGxpbmdfbG9n
Z2luZ19sYWJlbCB7CiB9Owogc3RhdGljIHZvaWQgYXJjdHVydXNfbG9nX3RoZXJtYWxfdGhyb3R0
bGluZ19ldmVudChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIHsKLQlpbnQgdGhyb3R0bGVyX2lk
eCwgdGhyb3R0aW5nX2V2ZW50cyA9IDAsIGJ1Zl9pZHggPSAwOworCWludCB0aHJvdHRsZXJfaWR4
LCB0aHJvdHRpbmdfZXZlbnRzID0gMCwgYnVmX2lkeCA9IDAsIHJldDsKIAlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IHNtdS0+YWRldjsKLQl1aW50MzJfdCB0aHJvdHRsZXJfc3RhdHVzOwor
CXVpbnQzMl90IHRocm90dGxlcl9zdGF0dXMgPSAwOwogCWNoYXIgbG9nX2J1ZlsyNTZdOwogCi0J
YXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LAorCXJldCA9IGFyY3R1cnVzX2dldF9z
bXVfbWV0cmljc19kYXRhKHNtdSwKIAkJCQkgICAgICBNRVRSSUNTX1RIUk9UVExFUl9TVEFUVVMs
CiAJCQkJICAgICAgJnRocm90dGxlcl9zdGF0dXMpOwogCisJaWYgKHJldCkgeworCQlkZXZfZXJy
KGFkZXYtPmRldiwgIkNvdWxkIG5vdCByZWFkIGZyb20gYXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNz
X2RhdGEoKVxuIik7CisJCXJldHVybjsKKwl9CisKIAltZW1zZXQobG9nX2J1ZiwgMCwgc2l6ZW9m
KGxvZ19idWYpKTsKIAlmb3IgKHRocm90dGxlcl9pZHggPSAwOyB0aHJvdHRsZXJfaWR4IDwgQVJS
QVlfU0laRShsb2dnaW5nX2xhYmVsKTsKIAkgICAgIHRocm90dGxlcl9pZHgrKykgewotLSAKMi4y
Ni4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
