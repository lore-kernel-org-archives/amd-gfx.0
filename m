Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1183CC47258
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81992072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HI/m2l6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81992072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B21E6E151;
	Sat,  2 May 2020 21:34:58 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750081.outbound.protection.outlook.com [40.107.75.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7B06E130
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNWfHgU9lpkF0FGaNNoYslKyXeZZd5eXlzNaufzk31HpO8NqcrcMm+ZanU1Am94N3YRuCNsOe3TUOJlFilqRQhSnItZKOq718YaVZihjvIlTTfIyaQvH7f5KbnWuTI8j6TKo+09e/C4UspdnMobz9C1ss1PZp1J/i5/EaDV1i6Hqrzh3HzA9w/RuaBY8mSrtZoAPh/9FbojPsTMTt+C+JtZ26/+0dgIehzejGL/rBSzqGWRDF6/vJFXzbbV6LktQyBXo1iKJ1PtuG+noU6Tefq/JITqeSqAZI8Avg1PMKUQMVmIfYDFRWJnBoI7kulXZ3jAG52RU04qj+Zd5YzWU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBh/DRaSZUX1oZKevNrAuJFHPVizpuU7qDWSRqXZLh0=;
 b=PsFE4guyPicsDavuoj1OyN5N9Mjv0wJ7tLhHNHHzKBL8OFX/wuaYc24I6kTPSCFPmOIz5Z96SbJg2KP/X22Ofnm1SJZfUvVsEfXeV1DR/1EZV7YtICeoSx7Qpdr6o2CxSQ25+vruvePKQUICBsNavdo8an6pQuwPxu6QC/R89bosf7OqW8dsgJziPUDAwI/epwe8edZFLpGPwZ/Gl/ZGgsq5cLzSx5zLF9aK5oLfzZVQcW93dinXjF9xCFkV+eQi+JA0EsytM/KIOckGRUKh9VU2soovsive6SWpLeSC3a3jFi1p8eFseAYw7IcHCmuiYrSg5RaxruLOGlOwwuItvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBh/DRaSZUX1oZKevNrAuJFHPVizpuU7qDWSRqXZLh0=;
 b=HI/m2l6iTGUesqOvqsOuexcP0vn6LJ4mEgTmNlZpEN6QmIOEJdcB6GFUx8p4yoVNFxN6oTaKPzwV8f0GunI9c5WobLIzuySAh7xmdEEoAEXw60xJB3opRuJIDAO/IZ+hoCRe12rxsYino5OMq8EJq1Jla9LX+tQhueeU/Ka+rxM=
Received: from BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:34:53 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::2) by BN8PR12CA0023.outlook.office365.com
 (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Sat, 2 May 2020 21:34:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:52 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:51 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:51 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: temporary clamp the vratio used to 1.0
Date: Sat, 2 May 2020 17:34:33 -0400
Message-ID: <20200502213443.39232-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(2906002)(47076004)(82740400003)(86362001)(6916009)(4326008)(2616005)(186003)(26005)(5660300002)(1076003)(82310400002)(7696005)(36756003)(81166007)(478600001)(356005)(426003)(336012)(6666004)(8936002)(70206006)(8676002)(70586007)(54906003)(44832011)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 163da312-c68f-49d2-7757-08d7eee0a647
X-MS-TrafficTypeDiagnostic: MN2PR12MB4455:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4455B959E46B1C85BF8EA8D68BA80@MN2PR12MB4455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRYxRbV6gni47w7t7Pxj17aEK4E/5mivKe+Ne/oqeMZqFbkMDuvLStXHNfD8G1Vz9z9Qs2tJnLvR36jAH4pNPfWRJ0F9RsVuuuk/J9798omUt6Yw4rPmjWpQB6pMjUSeGH/wxCPySelzgDcOuHTZpUv7x9aTNO1cuwBzCMrsFH0ub7m7IiyUfN3bW9gSyB6XffvTQhHFD+fF2gSjhQYNwtb6KOu8LGD72GPRci+a6vgInhFzoQGd6rr2cvfxYFBE5w/C2JewQ7mS4tHJBTU/psQUF+2ENWHmmyVeEq2UaqVUY9+yViCnaRpNj06s6xAKzIgeYeZl3e1p4q1nk4vw1JvNoEGJ4Oha2h5CPQzaiOx8i3rV8QnSxPYiPe1k2YCDW0MhlmesNZ92F4lHAiJXu1IxMAUR0Ejs25OzPiQWIZsldU91Y3dKdrHfUDPMPz/UBvHjA5ozmKfIXa3olDNReGiRi9pk+XpQ7/gCb+qVq+yIB/d9pInlKzY9ph1fx6YWcvbpTmr0Y9V6cP0UAJrrFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:52.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163da312-c68f-49d2-7757-08d7eee0a647
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, Sunpeng.Li@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTGV3aXMgSHVhbmcgPExld2lzLkh1YW5nQGFtZC5jb20+CgpbV2h5XQppbiBJc19TdXBw
b3J0IGZ1bmN0aW9uLCBkcml2ZXIgcmVwb3J0IGRpZmZlcmVudCBjYXBzIGJldHdlZW4Kc2FtZSB0
aW1pbmcgYnV0IGRpZmZlcmVudCBzY2FsaW5nIGNhdXNlIE9TIGluY29uc2lzdGVudC4KCltIb3dd
Cm1pbl9yb3dfdGltZSBpcyBhIGxvY2FsIHRoYXTigJlzIG9ubHkgdXNlZCBmb3IgdmVyaWZ5aW5n
IGltbWVkaWF0ZQpmbGlwIHN1cHBvcnQuIENsYW1wIHRoZSB2cmF0aW8gdXNlZCBmb3IgaXRzIGNh
bGN1bGF0aW9uIHRvIDEuMC4KClNpZ25lZC1vZmYtYnk6IExld2lzIEh1YW5nIDxMZXdpcy5IdWFu
Z0BhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpB
Y2tlZC1ieTogQXVyYWJpbmRvIFBpbGxhaSA8YXVyYWJpbmRvLnBpbGxhaUBhbWQuY29tPgotLS0K
IC4uLi9kYy9kbWwvZGNuMjEvZGlzcGxheV9tb2RlX3ZiYV8yMS5jICAgICAgICB8IDI2ICsrKysr
KysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1s
L2RjbjIxL2Rpc3BsYXlfbW9kZV92YmFfMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kbWwvZGNuMjEvZGlzcGxheV9tb2RlX3ZiYV8yMS5jCmluZGV4IDViYzgwYjYwODRkYS4u
YTU3NmVlZDk0ZDliIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZG1sL2RjbjIxL2Rpc3BsYXlfbW9kZV92YmFfMjEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZG1sL2RjbjIxL2Rpc3BsYXlfbW9kZV92YmFfMjEuYwpAQCAtMzE5MCw2ICsz
MTkwLDcgQEAgc3RhdGljIHZvaWQgQ2FsY3VsYXRlRmxpcFNjaGVkdWxlKAogCWRvdWJsZSBUaW1l
Rm9yRmV0Y2hpbmdSb3dJblZCbGFua0ltbWVkaWF0ZUZsaXA7CiAJZG91YmxlIEltbWVkaWF0ZUZs
aXBCVzsKIAlkb3VibGUgSG9zdFZNSW5lZmZpY2llbmN5RmFjdG9yOworCWRvdWJsZSBWUmF0aW9D
bGFtcGVkOwogCiAJaWYgKEdQVVZNRW5hYmxlID09IHRydWUgJiYgSG9zdFZNRW5hYmxlID09IHRy
dWUpIHsKIAkJSG9zdFZNSW5lZmZpY2llbmN5RmFjdG9yID0KQEAgLTMyMjIsMzEgKzMyMjMsMzIg
QEAgc3RhdGljIHZvaWQgQ2FsY3VsYXRlRmxpcFNjaGVkdWxlKAogCiAJKkRlc3RpbmF0aW9uTGlu
ZXNUb1JlcXVlc3RSb3dJbkltbWVkaWF0ZUZsaXAgPSBkbWxfY2VpbCg0LjAgKiAoVGltZUZvckZl
dGNoaW5nUm93SW5WQmxhbmtJbW1lZGlhdGVGbGlwIC8gTGluZVRpbWUpLCAxKSAvIDQuMDsKIAkq
ZmluYWxfZmxpcF9idyA9IGRtbF9tYXgoUERFQW5kTWV0YVBURUJ5dGVzUGVyRnJhbWUgKiBIb3N0
Vk1JbmVmZmljaWVuY3lGYWN0b3IgLyAoKkRlc3RpbmF0aW9uTGluZXNUb1JlcXVlc3RWTUluSW1t
ZWRpYXRlRmxpcCAqIExpbmVUaW1lKSwgKE1ldGFSb3dCeXRlcyArIERQVEVCeXRlc1BlclJvdykg
KiBIb3N0Vk1JbmVmZmljaWVuY3lGYWN0b3IgLyAoKkRlc3RpbmF0aW9uTGluZXNUb1JlcXVlc3RS
b3dJbkltbWVkaWF0ZUZsaXAgKiBMaW5lVGltZSkpOworCVZSYXRpb0NsYW1wZWQgPSAoVlJhdGlv
IDwgMS4wKSA/IDEuMCA6IFZSYXRpbzsKIAlpZiAoU291cmNlUGl4ZWxGb3JtYXQgPT0gZG1fNDIw
XzggfHwgU291cmNlUGl4ZWxGb3JtYXQgPT0gZG1fNDIwXzEwKSB7CiAJCWlmIChHUFVWTUVuYWJs
ZSA9PSB0cnVlICYmIERDQ0VuYWJsZSAhPSB0cnVlKSB7CiAJCQltaW5fcm93X3RpbWUgPSBkbWxf
bWluKAotCQkJCQlkcHRlX3Jvd19oZWlnaHQgKiBMaW5lVGltZSAvIFZSYXRpbywKLQkJCQkJZHB0
ZV9yb3dfaGVpZ2h0X2Nocm9tYSAqIExpbmVUaW1lIC8gKFZSYXRpbyAvIDIpKTsKKwkJCQkJZHB0
ZV9yb3dfaGVpZ2h0ICogTGluZVRpbWUgLyBWUmF0aW9DbGFtcGVkLAorCQkJCQlkcHRlX3Jvd19o
ZWlnaHRfY2hyb21hICogTGluZVRpbWUgLyAoVlJhdGlvQ2xhbXBlZCAvIDIpKTsKIAkJfSBlbHNl
IGlmIChHUFVWTUVuYWJsZSAhPSB0cnVlICYmIERDQ0VuYWJsZSA9PSB0cnVlKSB7CiAJCQltaW5f
cm93X3RpbWUgPSBkbWxfbWluKAotCQkJCQltZXRhX3Jvd19oZWlnaHQgKiBMaW5lVGltZSAvIFZS
YXRpbywKLQkJCQkJbWV0YV9yb3dfaGVpZ2h0X2Nocm9tYSAqIExpbmVUaW1lIC8gKFZSYXRpbyAv
IDIpKTsKKwkJCQkJbWV0YV9yb3dfaGVpZ2h0ICogTGluZVRpbWUgLyBWUmF0aW9DbGFtcGVkLAor
CQkJCQltZXRhX3Jvd19oZWlnaHRfY2hyb21hICogTGluZVRpbWUgLyAoVlJhdGlvQ2xhbXBlZCAv
IDIpKTsKIAkJfSBlbHNlIHsKIAkJCW1pbl9yb3dfdGltZSA9IGRtbF9taW40KAotCQkJCQlkcHRl
X3Jvd19oZWlnaHQgKiBMaW5lVGltZSAvIFZSYXRpbywKLQkJCQkJbWV0YV9yb3dfaGVpZ2h0ICog
TGluZVRpbWUgLyBWUmF0aW8sCi0JCQkJCWRwdGVfcm93X2hlaWdodF9jaHJvbWEgKiBMaW5lVGlt
ZSAvIChWUmF0aW8gLyAyKSwKLQkJCQkJbWV0YV9yb3dfaGVpZ2h0X2Nocm9tYSAqIExpbmVUaW1l
IC8gKFZSYXRpbyAvIDIpKTsKKwkJCQkJZHB0ZV9yb3dfaGVpZ2h0ICogTGluZVRpbWUgLyBWUmF0
aW9DbGFtcGVkLAorCQkJCQltZXRhX3Jvd19oZWlnaHQgKiBMaW5lVGltZSAvIFZSYXRpb0NsYW1w
ZWQsCisJCQkJCWRwdGVfcm93X2hlaWdodF9jaHJvbWEgKiBMaW5lVGltZSAvIChWUmF0aW9DbGFt
cGVkIC8gMiksCisJCQkJCW1ldGFfcm93X2hlaWdodF9jaHJvbWEgKiBMaW5lVGltZSAvIChWUmF0
aW9DbGFtcGVkIC8gMikpOwogCQl9CiAJfSBlbHNlIHsKIAkJaWYgKEdQVVZNRW5hYmxlID09IHRy
dWUgJiYgRENDRW5hYmxlICE9IHRydWUpIHsKLQkJCW1pbl9yb3dfdGltZSA9IGRwdGVfcm93X2hl
aWdodCAqIExpbmVUaW1lIC8gVlJhdGlvOworCQkJbWluX3Jvd190aW1lID0gZHB0ZV9yb3dfaGVp
Z2h0ICogTGluZVRpbWUgLyBWUmF0aW9DbGFtcGVkOwogCQl9IGVsc2UgaWYgKEdQVVZNRW5hYmxl
ICE9IHRydWUgJiYgRENDRW5hYmxlID09IHRydWUpIHsKLQkJCW1pbl9yb3dfdGltZSA9IG1ldGFf
cm93X2hlaWdodCAqIExpbmVUaW1lIC8gVlJhdGlvOworCQkJbWluX3Jvd190aW1lID0gbWV0YV9y
b3dfaGVpZ2h0ICogTGluZVRpbWUgLyBWUmF0aW9DbGFtcGVkOwogCQl9IGVsc2UgewogCQkJbWlu
X3Jvd190aW1lID0gZG1sX21pbigKLQkJCQkJZHB0ZV9yb3dfaGVpZ2h0ICogTGluZVRpbWUgLyBW
UmF0aW8sCi0JCQkJCW1ldGFfcm93X2hlaWdodCAqIExpbmVUaW1lIC8gVlJhdGlvKTsKKwkJCQkJ
ZHB0ZV9yb3dfaGVpZ2h0ICogTGluZVRpbWUgLyBWUmF0aW9DbGFtcGVkLAorCQkJCQltZXRhX3Jv
d19oZWlnaHQgKiBMaW5lVGltZSAvIFZSYXRpb0NsYW1wZWQpOwogCQl9CiAJfQogCi0tIAoyLjI1
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
