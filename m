Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA18C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF10A20709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF10A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892B76F3F5;
	Fri, 15 Nov 2019 03:35:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690043.outbound.protection.outlook.com [40.107.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992DC6F3F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgIpg6TTOmW4j3a14GQfX3wCeVh1zrfiH4B8bGDsJfZamMPiIWSKrrG02n7UHivWuNvJWM0BHCNfaqUfirISxPY/u7D0rqT5iiQoJhhl/N3+TKhw0spDn19otgmDLm940cQz6ZYFVQj8PysXvPcC3/0PDhfq7ZxmMsfsVLiGWFP44t6mhLlbJWu9OW2NakLjkU/MIPjUU4EW3f0T+vZC9hioKrTZJ5fftbVKvRNMo+c1Y9TBFyvYqqS3EMpBadxVTU5g3qBIluL1E3QDhMo64526zP5hrDTiflwIGDq9FQ0ckvjhj/QQKc0IBu+N3+SBnPjRGMWGAMQ5LzV1uc0bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/duq9UEfTS92VFXThJTO1lXkxLxSK8aMCmQIF4nEUso=;
 b=S6He8MZByrKCmZPnQ14dttZjm9h/9IGf3FY3VJrlHbNpaW5unPrff0oQfq2s5qKfImmJVv+ljxRQWf3RMDN6oqom9sCFSlrbVwu0QzlfcHdwUNhkyVGZZ9quS9iwGmYecy+/bcbRnaSx1N0SnnWJSVRu/BpT1p+M7i0osxPrmM9KqZUTE2wkMhWxXdkAnrIr7k+Xq9wfqftiOqz7dzal5E/nah9sQRYeRQKTa61wGWsrbDNISTTA/fAYRtGuLd5fGGx1ijo+f2ZJ2iebQXV2nNUOoe8Hy17bXsj5wUi5Inziw3hkvf5nqpUtojuB07EEQnyDsSaRFmlEzo8tbT8vSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:53 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:53 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/12] tests/amdgpu: add test to submit a sdma command with
 secure context
Date: Fri, 15 Nov 2019 11:34:55 +0800
Message-Id: <1573788895-3936-12-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbb0b32a-e1bf-4c87-16e8-08d7697ceab0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3663F5F0D54205E233B3C8B2F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STRp2ALFPnOU1VWzKg0q7gkNASsJLKGwaqjMh0mJLqVVWBXi9iXeyVgxG5E76huroiIj3WxNDcZW3dicEnEl2IHlZb1CDGEptqAk88t3JjEE5KDLWI4pZ61pXCf4Uf/Ia6GZytkX21SaDLABugHoIx6u0QZtvIcj10OjM18Akx5CK3ROSrYg5idtr0cCDG9RyYpsawiwzluOVVai35WtEfgcPLh8EP+yhO5qilBvYgcqV8Nrew7Y+xERppcGvcW1Ol/khLuFev765edtpOiosShN+0217NDc7sGW2jxGAT/jxsZuTh66vfoHWS+fHKMl+cUjGaz9uN7MN+K+ZUgWj+PEyZFtd1Psvl267u2EtDqnpbPBaEKO2QpwA1PAJ71qwK/8voL6vHDCXBAbvYMSThBcbqznETtB6PJRJ330f8c+244Kiqn4v78FLRjKzCfi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb0b32a-e1bf-4c87-16e8-08d7697ceab0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:53.4871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBy57ld5umvwttbrQb2Add0DgUOSPO3X2/SrRu0U7WMSsqEXpnVB0eeG/kLz2Av5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/duq9UEfTS92VFXThJTO1lXkxLxSK8aMCmQIF4nEUso=;
 b=mC0qO536ZSJiUVJ1I7Ywn2MsoEd1XjZ50Wi6I7rJv8DT5hgsJIltcXiP+Ktf/Aly89HyUMDDM9doSUHQe5yoWJg4SFRbEvpG6XEaEo+omsDSJ4I+3AL8v//wM2UPT3h3M5fQteV0X5zsCvyBkJRfuSrc9JQ8MxgHZAUS8oDdvto=
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
Cc: Marek.Olsak@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 Luben.Tuikov@amd.com, Alexander.Deucher@amd.com, Leo.Liu@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033455.sHD-WAvXlur_F_1kHRwKASX8hBfOxFgPiOVZQo2w46w@z>

VGhpcyBwYXRjaCBhZGQgdGVzdCB0byBzdWJtaXQgYSBzZG1hIGNvbW1hbmQgd2l0aCBzZWN1cmUg
Y29udGV4dC4KClNpZ25lZC1vZmYtYnk6IEFhcm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+Ci0t
LQogdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMgfCAxMCArKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2FtZGdwdS9zZWN1
cml0eV90ZXN0cy5jIGIvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKaW5kZXggMGJiNGFk
Mi4uZWIyMzlmNCAxMDA2NDQKLS0tIGEvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKKysr
IGIvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMKQEAgLTMzLDYgKzMzLDggQEAgc3RhdGlj
IHVpbnQzMl90IG1pbm9yX3ZlcnNpb247CiAKIHN0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9h
bGxvY19idWZfdGVzdCh2b2lkKTsKIHN0YXRpYyB2b2lkIGFtZGdwdV9zZWN1cml0eV9nZnhfc3Vi
bWlzc2lvbl90ZXN0KHZvaWQpOworc3RhdGljIHZvaWQgYW1kZ3B1X3NlY3VyaXR5X3NkbWFfc3Vi
bWlzc2lvbl90ZXN0KHZvaWQpOworCiAKIENVX0JPT0wgc3VpdGVfc2VjdXJpdHlfdGVzdHNfZW5h
YmxlKHZvaWQpCiB7CkBAIC03Nyw2ICs3OSw3IEBAIGludCBzdWl0ZV9zZWN1cml0eV90ZXN0c19j
bGVhbih2b2lkKQogQ1VfVGVzdEluZm8gc2VjdXJpdHlfdGVzdHNbXSA9IHsKIAl7ICJhbGxvY2F0
ZSBzZWN1cmUgYnVmZmVyIHRlc3QiLCBhbWRncHVfc2VjdXJpdHlfYWxsb2NfYnVmX3Rlc3QgfSwK
IAl7ICJncmFwaGljcyBzZWN1cmUgY29tbWFuZCBzdWJtaXNzaW9uIiwgYW1kZ3B1X3NlY3VyaXR5
X2dmeF9zdWJtaXNzaW9uX3Rlc3QgfSwKKwl7ICJzZG1hIHNlY3VyZSBjb21tYW5kIHN1Ym1pc3Np
b24iLCBhbWRncHVfc2VjdXJpdHlfc2RtYV9zdWJtaXNzaW9uX3Rlc3QgfSwKIAlDVV9URVNUX0lO
Rk9fTlVMTCwKIH07CiAKQEAgLTEyMiwzICsxMjUsMTAgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Nl
Y3VyaXR5X2dmeF9zdWJtaXNzaW9uX3Rlc3Qodm9pZCkKIAkJCQkJCQkJICBBTURHUFVfSFdfSVBf
R0ZYLAogCQkJCQkJCQkgIHRydWUpOwogfQorCitzdGF0aWMgdm9pZCBhbWRncHVfc2VjdXJpdHlf
c2RtYV9zdWJtaXNzaW9uX3Rlc3Qodm9pZCkKK3sKKwlhbWRncHVfY29tbWFuZF9zdWJtaXNzaW9u
X3dyaXRlX2xpbmVhcl9oZWxwZXJfd2l0aF9zZWN1cmUoZGV2aWNlX2hhbmRsZSwKKwkJCQkJCQkJ
ICBBTURHUFVfSFdfSVBfRE1BLAorCQkJCQkJCQkgIHRydWUpOworfQotLSAKMi43LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
