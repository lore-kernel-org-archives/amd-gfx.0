Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF0C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536A92245C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GvKGlCnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536A92245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A6E6E0D4;
	Wed, 12 Aug 2020 12:20:49 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam04on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4d::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0716E0D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 12:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DExAsYN+iPc1pnbIhnwnns1VzwDVIMx+KVSyBg8axftl90ZGPP6a/Jo3dGJCO3aJctRvPK+K7l7lzIvPUUebiIpwpgiizwo4ovPVzF+J40ErKPJZft1PvBxlDe8EmxicW/fAlkTHJtB7bFi1sGWCJWxJ7vs0ASBOmzugL+vUYlyVqP3FrHhfLr0Q+7g3mTbr6SoorzZkw1KzUBxBccv4NkA9fRoH8iRE9glZ1pzHsutGh7oZtN6OimYjNjobY2b/H0/rKMOAtaaCK9TcOI5fum1+PrzsnhvkA8S1BVtMd6gcLlIUmbBB0DWs4ZJjR11ykLkmma9+svqiiSkDvf1irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlEobTjQW64Rw6VJ3PQmpQ4hXUR/Rt9oiGpMnYl75DE=;
 b=MD3BoV1LzHytRXn9cCysQPNGK5ORZM/FzRvMPg6UlVHoHtzh6oiQQOILxC/O+kVi/iYiZIKPuxIKiUDCrL1ADOzF9aNdw0WdejacW+gAPgHwKK15ILabUforeCEdgBGeryiEunfVzqO+zlvnVHRSxQPLvKcsrNAy3exAekFWeOyu1PTuX9tye80OuJz+AlAq7fnR66FnB+qWrg4yTOiwU1JZWsFW+aNyUZHYEpRVpRvxCyjBDhtdwyoRi+MzQsnzRmG6MEYFgSDG4OB3pedWNkIP40RDQMZX226rsSCK/JnnZZ4Du8MPd3fKp6g5Hz4rseBJGiX/D89zPjxSQMnQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlEobTjQW64Rw6VJ3PQmpQ4hXUR/Rt9oiGpMnYl75DE=;
 b=GvKGlCnLcvNPvG2DLVqomD8NfROkTPskSLS7D86U63t882UYKHch4sX0T4+PQD+1lYBnmWUiyJ31S/SBQejMrvO3V+MisDoXkbu0mFGcpBUa0DXGCI0/4v07PmXJTz5xC4+f4Aodg5rpbeVp0gZSAsI4WP0JHsOhPIWijdE0eQA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB3244.namprd12.prod.outlook.com (2603:10b6:5:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 12 Aug
 2020 12:20:47 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 12:20:47 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus ppt
 driver
Date: Wed, 12 Aug 2020 08:20:30 -0400
Message-Id: <20200812122030.215907-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:404:5f::34) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:404:5f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 12:20:46 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9537c7a3-b098-4421-8c17-08d83eba2459
X-MS-TrafficTypeDiagnostic: DM6PR12MB3244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3244450C14C3AE418ACF4817F7420@DM6PR12MB3244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkkLTnnbsKjx0/RU94TyooGQQxdSYX9bAMXnk05gY0DXzFzSFJkNLDNa2Ztas4G8ly0SJtFitGjDdfmjD3PCD1hfBZmFXHTH9A+MNRDHFsQj97Vzxz9gojte4bLTQxkZbGOzcHgWH8jynwxowyZwK8YEye7qL9Ezy7vweo6d6tHO0IVQCdr6Vg0ysSRl4F3/QBQ7f+5GJRU6mFOmr6BI1CHxOCqDLUxcng8bsKdXffqImN4fTGMqUHiR26FTIiTBTYYZT8QmdR0OcuPXyxFd9ErudyA183wWr8SUNVOnVLOpM+Kd4hrQaQbBAh79oaIBuhzcJETTk+NewiGa31EdSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(8936002)(8676002)(5660300002)(66556008)(83380400001)(2906002)(66946007)(6666004)(26005)(316002)(478600001)(66476007)(6916009)(16526019)(86362001)(6486002)(956004)(1076003)(2616005)(52116002)(186003)(7696005)(4326008)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9OpbkPvJ3YRHQwjPkWw+btqq/j3gHxt0yzEXemwxsMu64VO7axuRWymeHgafvqxb6BTfZqyKOZqXbT4FpbSpIog3CwY20Y7dxVSYrCa6/16V9KUuxSEq7Tg+GAa28VO2pnJlb8sqnJ25zlZVvZvqWRZxjcAjkAcCIYTSy77L4TzSWYRPp/nNAnRRR4xXhnxsV0VjeYY3NUOqjkxQhgLfR4aZQNEDCJi+In+TVFHaomfbfuXOGcmTQ4HDGJRLneEhjI371+A53Dwyl5zAHd1lKAbB/LN/VDW3KHFZRqcdDG9LPJzB3Wr1VpQZeSF0HW6tq8tKlG/LRRn6cXUE+M2Uw17NdgJh+5z0bIbh77yoV7yCuRzWQXmMmccuo2zXPxZxmjfdWQslXlcUkQz68QRLOV/dVGLEnTJXEVsJMl7GTqNm3B3RRUwwx/FUk3eURFWBHiwIFFuKyJKwNAfM94ISEPPqJvlxvo6VDcLthGMXzdFlM3HRUr45tTIQznhc58mR0CXco+T0J9tGkvK5aMJp/sA5N4+GF7r8l6zZ1cq9XRI6zOVkaa18TSQyyj/vHfNnFwGTDpHBoXLtd+ALtRHVVodGq7wDgT+ruz9WduS0LIBwmhBQ/jt2h6+lfqBOGlw+LrF8MB/PFwrz0QXuEAdUDw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9537c7a3-b098-4421-8c17-08d83eba2459
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 12:20:47.2589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdYmHGt3sKCK3izjug3dBWzosw/Cg4TuvqFd5Jx+DjQ2CbRjH1zEhBWBD5xhWIZvkKFhjaTFMcSFyKuyCa+5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3244
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
Z2dpbmdfbGFiZWxbdGhyb3R0bGVyX2lkeF0uZmVhdHVyZV9tYXNrKSB7CgpieSBtYWtpbmcgYXJj
dHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoKSBhc3NpZ24gYSBkZWZhdWx0IHZhbHVlCihvZiB6
ZXJvKSBiZWZvcmUgYW55IHBvc3NpYmxlIHJldHVybiBwb2ludCBhcyB3ZWxsIGFzIHNpbXBseSBl
cnJvcgpvdXQgb2YgYXJjdHVydXNfbG9nX3RoZXJtYWxfdGhyb3R0bGluZ19ldmVudCgpIGlmIGl0
IGZhaWxzLgoKU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3RkZW5pc0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jIHwgMTIg
KysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1
c19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCmlu
ZGV4IDhiMTAyNWRjNTRmZC4uNzhmN2VjOTVlNGY1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwpAQCAtNTUxLDYgKzU1MSw5IEBAIHN0YXRpYyBpbnQg
YXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsCiAK
IAltdXRleF9sb2NrKCZzbXUtPm1ldHJpY3NfbG9jayk7CiAKKwkvLyBhc3NpZ24gZGVmYXVsdCB2
YWx1ZQorCSp2YWx1ZSA9IDA7CisKIAlyZXQgPSBzbXVfY21uX2dldF9tZXRyaWNzX3RhYmxlX2xv
Y2tlZChzbXUsCiAJCQkJCSAgICAgICBOVUxMLAogCQkJCQkgICAgICAgZmFsc2UpOwpAQCAtMjIw
OCwxNSArMjIxMSwyMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRocm90dGxpbmdfbG9nZ2luZ19s
YWJlbCB7CiB9Owogc3RhdGljIHZvaWQgYXJjdHVydXNfbG9nX3RoZXJtYWxfdGhyb3R0bGluZ19l
dmVudChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKIHsKLQlpbnQgdGhyb3R0bGVyX2lkeCwgdGhy
b3R0aW5nX2V2ZW50cyA9IDAsIGJ1Zl9pZHggPSAwOworCWludCB0aHJvdHRsZXJfaWR4LCB0aHJv
dHRpbmdfZXZlbnRzID0gMCwgYnVmX2lkeCA9IDAsIHJldDsKIAlzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiA9IHNtdS0+YWRldjsKIAl1aW50MzJfdCB0aHJvdHRsZXJfc3RhdHVzOwogCWNoYXIg
bG9nX2J1ZlsyNTZdOwogCi0JYXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LAorCXJl
dCA9IGFyY3R1cnVzX2dldF9zbXVfbWV0cmljc19kYXRhKHNtdSwKIAkJCQkgICAgICBNRVRSSUNT
X1RIUk9UVExFUl9TVEFUVVMsCiAJCQkJICAgICAgJnRocm90dGxlcl9zdGF0dXMpOwogCisJaWYg
KHJldCkgeworCQlkZXZfZXJyKGFkZXYtPmRldiwgIkNvdWxkIG5vdCByZWFkIGZyb20gYXJjdHVy
dXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoKVxuIik7CisJCXJldHVybjsKKwl9CisKIAltZW1zZXQo
bG9nX2J1ZiwgMCwgc2l6ZW9mKGxvZ19idWYpKTsKIAlmb3IgKHRocm90dGxlcl9pZHggPSAwOyB0
aHJvdHRsZXJfaWR4IDwgQVJSQVlfU0laRShsb2dnaW5nX2xhYmVsKTsKIAkgICAgIHRocm90dGxl
cl9pZHgrKykgewotLSAKMi4yNi4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
