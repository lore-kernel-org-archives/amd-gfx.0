Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7096C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 14:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8665B222D1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 14:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8665B222D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CD06E8AF;
	Tue, 19 Nov 2019 14:45:39 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680057.outbound.protection.outlook.com [40.107.68.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D216E227;
 Tue, 19 Nov 2019 14:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRouNzB9qWtGTJYJoFn3vyVBCDfYWK/87Degs8x9pPXA6JAviaTXz7+V0hlUr/gUlamk8CqoV8aKVtwg4ei2WlOubzhPEXJfukpIUo5IgF64FjYFNZCfaU2stooHUzUfvjKRnTLZV/9DJvhUSEPCD9BuX92wqCgVyQUE0/IrtUx5DkN0oJwlxeQm6mqFUFmOoGhZRUFXz66ancuTnA2ZVpyk8vWFhcG+fIR+1zlH1yOmCxonJaXrDsAjPdADmPibrZuWZJdiSIDQBodla/F6T6bE8CZfENZWUsVbzRdZB4UgS26hp1LeXkazP1AiVO71s7LLsQIK1iEmGIbXeBTMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhZmkv3LsHPL7VxP3kpV9EvDGmyUsWH8fsRLK74TUjc=;
 b=BJVXvj0O+tDCmfrLVKEEma5q807RExvcVSW79b1x97XsE6xLTGw15vaqVCecdepIqs2lZd8O+rLqaU6ISkjGDqL9n5jcNcg+Bu7TloT/5ONuYueMH4nE76hiwhoeP3Wsx/bEFBYBdACp/50bmFcSMQBdQeFCZY9yk5rSesCRROyXtl4RuZGI8UTVMqvt5+Qan1oc+XA79dDYxQ16EIXkj+7QgLJvqoiYwvEClesZ3X42Dp30O4kybpjV4DKq9DeVJC+HDZABO4E9TTBvGYNyti6FH8yZtnfw6Ikec9aCV+klzPJ/oQqprglj2Q+YluhD7YF6pjheL07uvXLP9lyKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0057.namprd12.prod.outlook.com (2603:10b6:3:103::19)
 by BN6PR12MB1491.namprd12.prod.outlook.com (2603:10b6:405:5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Tue, 19 Nov
 2019 14:45:33 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM5PR12CA0057.outlook.office365.com
 (2603:10b6:3:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Tue, 19 Nov 2019 14:45:33 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 19 Nov 2019 14:45:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 08:45:33 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 19 Nov
 2019 08:45:32 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 19 Nov 2019 08:45:32 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/dsc: Return unsigned long on compute offset
Date: Tue, 19 Nov 2019 09:45:26 -0500
Message-ID: <20191119144526.31797-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(199004)(189003)(426003)(336012)(70206006)(2351001)(70586007)(2616005)(476003)(486006)(50466002)(126002)(2876002)(450100002)(51416003)(5660300002)(4326008)(48376002)(8936002)(26005)(186003)(478600001)(50226002)(8676002)(2906002)(81156014)(81166006)(305945005)(36756003)(86362001)(7696005)(54906003)(6916009)(16586007)(53416004)(316002)(356004)(47776003)(1076003)(6666004)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1491; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7df4bdc-5a1a-4066-8f3c-08d76cff21e7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1491:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14913D900205B360D8DA6ACFE44C0@BN6PR12MB1491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-Forefront-PRVS: 022649CC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4G8TbfKSsl+5zD5i/iMJuUbzlwaWTfdUvi47K/DLdc4bqOMZDyqcIS8B6zyeqA3jhL2Zu7LeK0PTe37oddL+nbOvU8C4cl2EiF4T47MBJVPhWIYmLbO//gB3YYfQ3Yqxj2P6ylZXSSwBeIFs2KmT0JYbBdeJyThE+jIO+DBD7DT5/nsjxRp1N+f5uAC6lnEF4p0FFHjP78+pZOTYV7Qdj8DC8wgOgus+6NghN5c1vLEGAvc03AMFXee3wJAlgg3BIkVw+nfhdz9MWN3fwraHGttdApCWDSA4fou1Mq+PDBJn3omAT+CTgENG90uC1FB0K8L5Ry/go/4na7lbTU2GZqD06hu0Lrmcoj6FU2J1IowvatHTU9XAIOo6MEczocMGxHeHrrafwGZLDkpdjXQ5lzTXysiy44EmaDvM3bb3RFv82+q5hPCODaxSpAMV7p7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 14:45:33.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7df4bdc-5a1a-4066-8f3c-08d76cff21e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1491
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhZmkv3LsHPL7VxP3kpV9EvDGmyUsWH8fsRLK74TUjc=;
 b=GY0l3ihj1pPsZ/JEv2Rfo2mtHGCMOP5ITKN4YbDAUSeLHQZwN9dcT74W7oUGfbVnYeOORqHtdfBltv/iM1AUsPKS5tvZRc8VapmZOLU/aKiG+5DOOjjKnApqCufDCeDi3nq37NQ5DgQMU5p1AWOG3/3AQj37kd0/bTnwPnqgkpM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Mikita Lipski <mikita.lipski@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191119144526.yGb9tjK9uCbir9DKUh5goaVUVTTD2I37MLDoEFr5fRE@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKV2Ugc2hvdWxkbid0
IGNvbXBhcmUgaW50IHdpdGggdW5zaWduZWQgbG9uZyB0byBmaW5kIHRoZSBtYXggdmFsdWUKYW5k
IHNpbmNlIHdlIGFyZSBub3QgZXhwZWN0aW5nIG5lZ2F0aXZlIHZhbHVlIHJldHVybmVkIGZyb20K
Y29tcHV0ZV9vZmZzZXQgd2Ugc2hvdWxkIG1ha2UgdGhpcyBmdW5jdGlvbiByZXR1cm4gdW5zaWdu
ZWQgbG9uZwpzbyB3ZSBjYW4gY29tcGFyZSB0aGUgdmFsdWVzIHdoZW4gY29tcHV0aW5nIHJjIHBh
cmFtZXRlcnMuCgpDYzogTmlrb2xhIENvcm5paiA8bmlrb2xhLmNvcm5pakBhbWQuY29tPgpDYzog
SGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IE1p
a2l0YSBMaXBza2kgPG1pa2l0YS5saXBza2lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
ZHJtX2RzYy5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9kc2MuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMKaW5kZXggNzRmMzUyN2Y1NjdkLi5lYzQwNjA0YWI2YTIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZHNjLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2RybV9kc2MuYwpAQCAtMjQ1LDExICsyNDUsMTEgQEAgdm9pZCBkcm1fZHNjX3Bwc19wYXls
b2FkX3BhY2soc3RydWN0IGRybV9kc2NfcGljdHVyZV9wYXJhbWV0ZXJfc2V0ICpwcHNfcGF5bG9h
ZCwKIH0KIEVYUE9SVF9TWU1CT0woZHJtX2RzY19wcHNfcGF5bG9hZF9wYWNrKTsKIAotc3RhdGlj
IGludCBjb21wdXRlX29mZnNldChzdHJ1Y3QgZHJtX2RzY19jb25maWcgKnZkc2NfY2ZnLCBpbnQg
cGl4ZWxzX3Blcl9ncm91cCwKK3N0YXRpYyB1bnNpZ25lZCBsb25nIGNvbXB1dGVfb2Zmc2V0KHN0
cnVjdCBkcm1fZHNjX2NvbmZpZyAqdmRzY19jZmcsIGludCBwaXhlbHNfcGVyX2dyb3VwLAogCQkJ
CWludCBncm91cHNfcGVyX2xpbmUsIGludCBncnBjbnQpCiB7Ci0JaW50IG9mZnNldCA9IDA7Ci0J
aW50IGdycGNudF9pZCA9IERJVl9ST1VORF9VUCh2ZHNjX2NmZy0+aW5pdGlhbF94bWl0X2RlbGF5
LCBwaXhlbHNfcGVyX2dyb3VwKTsKKwl1bnNpZ25lZCBsb25nIG9mZnNldCA9IDA7CisJdW5zaWdu
ZWQgbG9uZyBncnBjbnRfaWQgPSBESVZfUk9VTkRfVVAodmRzY19jZmctPmluaXRpYWxfeG1pdF9k
ZWxheSwgcGl4ZWxzX3Blcl9ncm91cCk7CiAKIAlpZiAoZ3JwY250IDw9IGdycGNudF9pZCkKIAkJ
b2Zmc2V0ID0gRElWX1JPVU5EX1VQKGdycGNudCAqIHBpeGVsc19wZXJfZ3JvdXAgKiB2ZHNjX2Nm
Zy0+Yml0c19wZXJfcGl4ZWwsIDE2KTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
