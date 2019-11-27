Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72704C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C9B92070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C9B92070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1033F6E4F1;
	Wed, 27 Nov 2019 09:16:21 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760084.outbound.protection.outlook.com [40.107.76.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4E56E4EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:16:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOJtaZ3h4prioMuQE63ik7jAiMGVlDaIE01MuEkKz1xHKLc4fQ3EYhUYsU1meUM6cPVVqSXPI3iU6tww8StjPiYlcNmehKOP1+7ssnsUJS4H6lhwFxkm8dX8J5TJqGY/fUV/5JOkbBskFXfooqPt1v/GsbwpMQJS62+B7gfljKsmkjD0vL7V9FtnTwNkjdEmlfEUDoQyutohkOQaZVGXAPk/+rwu37Pyzh/ufbmpwgxhYyIzzWGsc/ack/2ABllqPXHxgK1ZFX7CnLdjCVn0nofDAGA9rklvFZdUVI8WRh4IH4PtOC0AcfnEBzE6myqKRFZmIdqrGQdjMALmWoJgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlRWjDxWS7cSNi2XKD2W9/jmumRVCOT535Pyu7+3VbU=;
 b=KP/AgUOizNKQVyiO0uQe3yupA7hASPoBNXC6Lru2ZcEgeWjxrr268SO89RvPfIAJo6uyzJ+ty5bWpOEqAo5xbEuEIvpo2ppH/od76y14Ub+JEOQb9Nu1iScgaGncJ8W9dC8Ipxl7/4jDjG8sqJxvXNVGJiP5OjOTjFBfTuRCzu8fGuV5pH5DKLNx4FPgBz1A24gaXDdq/PwhjXr5TQtPVVpucFqcY7lPPfZAeQUQWS9VfqBW7y464s/Snzwna2wjA6PNSHuEumpXc3my1m4hX3KlCT6pHmdhrQB8iBTv4orzn16VJawspMWREquL9gh1Cp3yleeDhK5Q6QSm2g8FyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0055.namprd12.prod.outlook.com (2603:10b6:3:103::17)
 by BYAPR12MB3175.namprd12.prod.outlook.com (2603:10b6:a03:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Wed, 27 Nov
 2019 09:15:58 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::208) by DM5PR12CA0055.outlook.office365.com
 (2603:10b6:3:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.17 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:57 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:57 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:56 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:54 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amdgpu: clear err_event_athub flag after reset exit
Date: Wed, 27 Nov 2019 17:15:28 +0800
Message-ID: <1574846129-4826-8-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(428003)(189003)(199004)(70206006)(76176011)(48376002)(186003)(70586007)(51416003)(11346002)(2906002)(26005)(50466002)(6916009)(305945005)(5660300002)(356004)(6666004)(47776003)(2351001)(446003)(336012)(426003)(86362001)(36756003)(54906003)(478600001)(4326008)(44832011)(2616005)(50226002)(8676002)(81156014)(81166006)(8936002)(16586007)(316002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3175; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e6bf54-30bd-4da7-f95d-08d7731a69ab
X-MS-TrafficTypeDiagnostic: BYAPR12MB3175:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3175C2A23ED48B3C0CB6D455F6440@BYAPR12MB3175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svgngnj8MozieYrLReolzvDoZtrzK8cyBgA2B9crbZdeUdfkBRjcnR4SkJqSHSZQi+o2ft/m4pHEyHbTP/Tmg/E1yrM+SAtiwFKk1k9NdBzs8fogU1ZSbeOU75+9Cm0YXwyWN2IJC6LNd5+QT2jQC5fAGRHtFtceMIg+ehsM+bHFZ6ch8ZAwpxNVXJkjansV3Kik5L+GJeR9ZkH8ImsiSuzlC8LmA3nkp/OSKqw5vxTliEa4O8iM95SL9/k4iwAvAhMoRPx5+WACAUvpAX2cQiHLLvSe/7RWUXT7WqIPCkQj/WG/MSjt+qnvlzjP5LcH00AYMz60Zf0YYs8UWTgD8yh+s1eAgVohEhQX8R991JhrpkM7w9AAIWaiROl/bnhWfEiSjBkld51maBLEaijVwgO8Z/NsGyD7bwLt8zRKwN3eI4iuaXwPgdyVKTGqYMwq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:57.4606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e6bf54-30bd-4da7-f95d-08d7731a69ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3175
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlRWjDxWS7cSNi2XKD2W9/jmumRVCOT535Pyu7+3VbU=;
 b=ml+X0aCvYinTicDLAkkdMfvih9ePAiEcTlR76QCiL93Wu1X6Z3VuruQq0/fhUjAb6cHy+vo/RR8zukmJeRDjVCZ/jedSiQNHCa2YbKPYigb/E5fe6ubgl3V/q0to5/88R2CADhxR9QFO+ELq5VibaOB2wDmGMIBCbWsxrfw5vMs=
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <le.ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127091528.TBZ0FGE-MLJCwapoXDQPWf7jVTnRc6LJt10ZQH35mVM@z>

T3RoZXJ3aXNlIG5leHQgZXJyX2V2ZW50X2F0aHViIGVycm9yIGNhbm5vdCBjYWxsIGdwdSByZXNl
dC4gQW5kIGZvbGxvd2luZwpyZXN1bWUgc2VxdWVuY2Ugd2lsbCBub3QgYmUgYWZmZWN0ZWQgYnkg
dGhpcyBmbGFnLgoKdjI6IGNyZWF0ZSBmdW5jdGlvbiB0byBjbGVhciBhbWRncHVfcmFzX2luX2lu
dHIgZm9yIG1vZHVsYXJpdHkgb2YgcmFzIGRyaXZlcgoKQ2hhbmdlLUlkOiBJNWNkMjkzZjMwZjIz
ODc2YmYyYTE4NjA2ODFiY2I1MGY0NzcxM2VjZApTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
fCAzICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oICAgIHwgNSAr
KysrKwogMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNTNlOTU5MC4uODM4N2I0NCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzg5MCw2ICszODkw
LDkgQEAgc3RhdGljIGludCBhbWRncHVfZG9fYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2hpdmVf
aW5mbyAqaGl2ZSwKIAkJfQogCX0KIAorCWlmICghciAmJiBhbWRncHVfcmFzX2ludHJfdHJpZ2dl
cmVkKCkpCisJCWFtZGdwdV9yYXNfaW50cl9jbGVhcmVkKCk7CisKIAlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQpIHsKIAkJaWYg
KG5lZWRfZnVsbF9yZXNldCkgewogCQkJLyogcG9zdCBjYXJkICovCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmgKaW5kZXggYTJjMWFjMS4uZDRhZGU0NyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaApAQCAtNjIxLDYgKzYyMSwxMSBAQCBzdGF0aWMg
aW5saW5lIGJvb2wgYW1kZ3B1X3Jhc19pbnRyX3RyaWdnZXJlZCh2b2lkKQogCXJldHVybiAhIWF0
b21pY19yZWFkKCZhbWRncHVfcmFzX2luX2ludHIpOwogfQogCitzdGF0aWMgaW5saW5lIHZvaWQg
YW1kZ3B1X3Jhc19pbnRyX2NsZWFyZWQodm9pZCkKK3sKKwlhdG9taWNfc2V0KCZhbWRncHVfcmFz
X2luX2ludHIsIDApOworfQorCiB2b2lkIGFtZGdwdV9yYXNfZ2xvYmFsX3Jhc19pc3Ioc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCiAjZW5kaWYKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
