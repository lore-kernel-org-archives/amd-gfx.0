Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD3C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 15:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C2D2087D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 15:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KCirVGsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C2D2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0886EB5A;
	Thu, 27 Aug 2020 15:54:36 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680043.outbound.protection.outlook.com [40.107.68.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1366EB5A
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 15:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/6ozdTpQDWtBnBBV6hx91+jfQ6Bx5kcUYCkeHFMDBuMjcnp/sCMyoZzZyUqSVyQvCyGtY4TEQT7USdR74FzWwOPuTUxfAspIJPWBKmtfehcBo2jR6C5RFEv/FmHwBTYUWjiiQm82CDRHK+g7vrlB8+fKEa+bf5dGQTNPEYdWaU9cWvjGwkFykI/Zeic1LAUG0wtqfj0ms6oanNfxIYRqdK6lXqb7y6D5rU7Nm0SLwi4JGPMDLrVODqczsv+4qmqs6Z9veqtCo6tilnBuQ7NPL35iiJD26mQNmTKJhkjHz21GteYpXQ8Ld/SsDwCZBshZAnXWumWCkXh3dkZwh0dVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvdPStTBly4eGJ++zuYffUbz6GFvCW84PiZy+VJ7s2g=;
 b=LGz9XuknS1t+d/lOOsg+m48mPVH/rX+3533otMggyQsMDNTktmyCRvqg97CpS99/6Y/G4ZqEh83CWcQ4rfAXhFyC9whPfh7nKppp85AcIfroQbQq6XBHPHE3Nsb48trQKAMzVKi0ssogGfapHS7e/rQjR59nzlGAEMACm3Vh3GT6gQwR2Mo2W3gmS14GKOogIJfBUI1j2zhQnWjcmzfBcci2dWjeBgam7+lVsh1hG0abH7XcODCl8/BCXyNHL4aiZXotpwcE3rMNnqRAt7+spLKBdtr5U4PVk+g5O/2GS27/PBt9l89W+zCbsnnlMbncNVpXlZBuO5EnISmzhMPmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvdPStTBly4eGJ++zuYffUbz6GFvCW84PiZy+VJ7s2g=;
 b=KCirVGsu9Y4a3iNXFQnJbMVuCHTsfxBSk2p9eIX4T8xhlLX1nQTw8INprvaZx0tgrJ1VEFYQuWODeYJ6orQLxKPYetbFwOZDlcTHgTRaekQSiStSG+5KTT3ojGuq25gzs14PJO+cyKmOXD//Yy2QhasorJoB11sUU0xyeI9RwLg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3260.namprd12.prod.outlook.com (2603:10b6:5:183::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Thu, 27 Aug
 2020 15:54:30 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 15:54:30 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix compiler warnings
Date: Thu, 27 Aug 2020 17:58:24 +0200
Message-Id: <20200827155824.123589-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: BN1PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:408:e3::11) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN1PR14CA0006.namprd14.prod.outlook.com (2603:10b6:408:e3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 15:54:28 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ce2413e-82bc-4f42-78fd-08d84aa17ba0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32606F37564F73882F1B9AB08B550@DM6PR12MB3260.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:82;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwiMR1OA+jSpVrkh+xEsTUBQbmvlkrqrUtpxLSRyCYvmS6YRgp6ET31FIOUMLCaeVDt+ApAB5+6rnG0VY45QshLzIvPqjUD4ug8wO+7gnEcwFhalnqDMVV6SOi4jlNcW57jitzKVeuj5hGXt7fKyaocbPDBmDtjMeVx5IMfLn7B2OARrUB5jMjj9aGG7qgFYb30PZn4mg3p8XrS46ap+Qcfta2afaOG3FsuW+xfo/XJxhXIsGVnJ+0oBw0BWhvPRWdVeIYH8j3KvAXuqjs3se9bYHrUZShluSn1z/7lw54z9t4hkU3AfPpYg4/nAjU0H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(186003)(26005)(66946007)(36756003)(86362001)(8936002)(66476007)(52116002)(316002)(44832011)(66556008)(2906002)(6486002)(83380400001)(5660300002)(956004)(8676002)(478600001)(16576012)(6666004)(2616005)(6916009)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vuyhCouMNZ49yNp5dYKs3Vb7KbsfFoJa+Pm2zJwPlrg8fJY++zj0XIS0qHZ0PtivfebqOmDBhwIfVz0ikLV1YTOYYZ4aS+PYIfh9G8FBSvTU6Wo5m8hR+aa4eprwrFtmSH15eP5SSdDdeqzZVpeODErf+H/e+kEgAurHL7O7GCJThvFZ7Ba7CjIeblnyjbD2iFI02+vK++IklL1rHoiblXyBGNJ3f9wi6zC7qBqlZRsrK53sZ5DKVTWr7qhVU5o3Yu8SRmXMQytwz2xq/9g1YtStLGi+e7Vp37p4XKHkCQSW0yxSX3zfg9NWrag+AFOzCnOgLfZ8IWgvEGcFRkmd6PxPugpGyrEIOspYdrVa4YFN2NiaC6wGL38s/Arswh4ANTdKgpYXHVm1xDyVQ74QdArG7Xp1+TNW72K8kHB9tRkNc28F+QzQ88Ye5QFGaL7wbgVfM/yG3C2knt+I9kTwUEfdS3XgBvmMdqaeIyRPDNiXdFk9qlG4xW73XQ2B3728q0MCBgGPZPSw2TL2IvAVVtA+REVE8Wmn6hhIGUW+YrDl8bArLccjWKqmjAjRUPl82nTwMmPoS2QQ758EbDj2Rju7oDrmqgmSxSHLyjKxoIeqHoesb9MKwzurcDsttChQbZklU9ozlpjRSgupbJ549w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce2413e-82bc-4f42-78fd-08d84aa17ba0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 15:54:30.0627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXyCzE/28DsOSOKvKQ0qM08cN+AX82/kkLnRR83KIG074YbI+c/PIsXMM1dtAZ6BcsIpnZAyHEuEW2hSYTb+Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgYmVsb3cgY29tcGlsZXIgd2FybmluZ3M6CiBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uubwpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmM6MzgxOjE6IHdhcm5pbmc6IOKAmHN0YXRpY+KAmSBpcyBub3QgYXQgYmVnaW5u
aW5nIG9mIGRlY2xhcmF0aW9uIFstV29sZC1zdHlsZS1kZWNsYXJhdGlvbl0KICAzODEgfCB2b2lk
IHN0YXRpYyBpbmxpbmUgYW1kZ3B1X21tX3dyZWdfbW1pbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdWludDMyX3QgcmVnLCB1aW50MzJfdCB2LCB1aW50MzJfdCBhY2NfZmxhZ3MpCiAgICAg
IHwgXn5+fgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmM6MzgxOjE6
IHdhcm5pbmc6IOKAmGlubGluZeKAmSBpcyBub3QgYXQgYmVnaW5uaW5nIG9mIGRlY2xhcmF0aW9u
IFstV29sZC1zdHlsZS1kZWNsYXJhdGlvbl0KZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jOiBJbiBmdW5jdGlvbiDigJhhbWRncHVfZGV2aWNlX2ZpbmnigJk6CmRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYzozMzgxOjY6IHdhcm5pbmc6IHZh
cmlhYmxlIOKAmHLigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJs
ZV0KIDMzODEgfCAgaW50IHI7CiAgICAgIHwgICAgICBeCgpTaWduZWQtb2ZmLWJ5OiBOaXJtb3kg
RGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKaW5kZXggNjk2YTYxY2MzYWM2Li42NTE4ZTQ0NGJlYWQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKQEAgLTM3OCw3ICszNzgsOSBAQCB2b2lk
IGFtZGdwdV9tbV93cmVnOChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDMyX3Qgb2Zm
c2V0LCB1aW50OF90IHZhbHVlKQogCQlCVUcoKTsKIH0KIAotdm9pZCBzdGF0aWMgaW5saW5lIGFt
ZGdwdV9tbV93cmVnX21taW8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHJl
ZywgdWludDMyX3QgdiwgdWludDMyX3QgYWNjX2ZsYWdzKQorc3RhdGljIGlubGluZSB2b2lkIGFt
ZGdwdV9tbV93cmVnX21taW8oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJICAgICAg
IHVpbnQzMl90IHJlZywgdWludDMyX3QgdiwKKwkJCQkgICAgICAgdWludDMyX3QgYWNjX2ZsYWdz
KQogewogCXRyYWNlX2FtZGdwdV9tbV93cmVnKGFkZXYtPnBkZXYtPmRldmljZSwgcmVnLCB2KTsK
IApAQCAtMzM3OCw4ICszMzgwLDYgQEAgaW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKICAqLwogdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0JaW50IHI7Ci0KIAlkZXZfaW5mbyhhZGV2LT5kZXYsICJh
bWRncHU6IGZpbmlzaGluZyBkZXZpY2UuXG4iKTsKIAlmbHVzaF9kZWxheWVkX3dvcmsoJmFkZXYt
PmRlbGF5ZWRfaW5pdF93b3JrKTsKIAlhZGV2LT5zaHV0ZG93biA9IHRydWU7CkBAIC0zNDAyLDcg
KzM0MDIsNyBAQCB2b2lkIGFtZGdwdV9kZXZpY2VfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAlpZiAoYWRldi0+cG1fc3lzZnNfZW4pCiAJCWFtZGdwdV9wbV9zeXNmc19maW5pKGFk
ZXYpOwogCWFtZGdwdV9mYmRldl9maW5pKGFkZXYpOwotCXIgPSBhbWRncHVfZGV2aWNlX2lwX2Zp
bmkoYWRldik7CisJYW1kZ3B1X2RldmljZV9pcF9maW5pKGFkZXYpOwogCXJlbGVhc2VfZmlybXdh
cmUoYWRldi0+ZmlybXdhcmUuZ3B1X2luZm9fZncpOwogCWFkZXYtPmZpcm13YXJlLmdwdV9pbmZv
X2Z3ID0gTlVMTDsKIAlhZGV2LT5hY2NlbF93b3JraW5nID0gZmFsc2U7Ci0tIAoyLjI4LjAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
