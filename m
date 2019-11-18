Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D91AC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC7F20726
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC7F20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC1989BB3;
	Mon, 18 Nov 2019 05:18:58 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CF589BA1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 05:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibej5+rgv4bR2QsULs3IpfHZjGEKV5L7YvjCDW7quHTrWwfMhu4FVc+4An2TuCQaN7U3WnXa9W/is41iy0UrUpt4QoaCy+1ToEkwi0SIdoM7ya4gkdq+tkqmDQhQTi7SvlTfPaO5CULc1rX7JEZ9u4pKLVkAjC8xqWWSnZvzRzxp+MM//XoQe8R989oHncAyxohP2fvyZoDwN22So+Pb3M622+HMD/Z2UAbYcsp5Zgjt9z/yxUEn71NZhMdsoKzFbCpfzNXo9SbsgWd3w1SxQY3YE6055FSQIaOG7sAX+DCfsnbMTSq8ttyKexXNd/hrUxNaTLMNxk9jCPgovGkR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veBziWmBG94JdSZgceeYakFH/JM4d0ZsihvrUxzIny0=;
 b=k2l4oD4dmDtQgY2iY6JLyQ6E6WO1ecCdyl1iaVQrsI+aqZ+ATKEHUfYU82NvuT8I6PNxwoGvAVQcAKk2/971AbtqCvUjHN8H91+rrpc7Uif2TqCLvE3kWXnWLFhaNGf3aTZr3VQu6rkrcB0Seq4jW72LzdcjEInMFrsr1v1cDoDYPyQnYWVu2OsRuqwaEfM5nBL8zw0wPv2jNFR5qBudbhc1bU90mvdnlt6sCpsekpn53q0EfH7KCfPNRBlOCk+y6qI4RzsTo1g07vpK0/kltC9U7nfOklL0YYO3+fyLuR/aenbCMUnmk48DmF8ayTdoKhh3wyxULlhFUKQs33/3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Mon, 18 Nov 2019 05:18:55 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 05:18:55 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: enable TMZ bit in sdma copy pkt for sdma v4
Date: Mon, 18 Nov 2019 13:18:34 +0800
Message-Id: <1574054316-2802-3-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 545b70a1-eb4b-42d2-ccc9-08d76be6ce94
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB371275B7C6AAC7544B72E319F04D0@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(4744005)(86362001)(486006)(44832011)(2616005)(476003)(2351001)(66476007)(11346002)(25786009)(5660300002)(446003)(386003)(6436002)(66946007)(36756003)(26005)(6512007)(50226002)(8936002)(186003)(81156014)(8676002)(81166006)(66556008)(6486002)(66066001)(478600001)(305945005)(14444005)(6506007)(2361001)(66574012)(316002)(47776003)(23676004)(6116002)(50466002)(3846002)(52116002)(4326008)(2870700001)(2906002)(99286004)(76176011)(6916009)(7736002)(14454004)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPSNJhjD8wl4Bk239u5vS1EPOqy9HQgvqxn25K2MKQuT3BBTYHJmM+BcwlWzLwRhK9atQEwHC2mI4F+tHOf2bGVn9T7C839PWW7APYtpQOOHguuWY10aGfj6i6WOxTnEJaKYQH8enqA0AzQ8dAzAFDYuCbTcS4MwlaQAO/0Gn7IRY7uEhPOfWnQLnyNn/EyhLRyUuha4LEkrcOtNcTv7UPi8Rp8rXvS0B9QfAU/Ph28mv51R8hNHIJafVMM8nr5JAkgo4Nf2859J9PX7s899gxLdrJHSNNbA8x8ByUV1tyfrQuc6MF/Xy9Begm/KU2FUBBDVL8B7DYpAMLSb7PHTcLfNNwmH2A2a6h/8e9DOEMIgGZ75bW7FD+p4OPsxgyi5EKV45r0aGo+9ZHX8kwlVmoQuLAHlMZFaSZ/jj7HYSmqpbXMytjgTp5QEMQkO6S6p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545b70a1-eb4b-42d2-ccc9-08d76be6ce94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 05:18:55.2790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIZjbuwJexxpP7M19knnq3NQhm9g/4o155SVBAvM6BhSrQ7nJu31ef4Zjqwpwj/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veBziWmBG94JdSZgceeYakFH/JM4d0ZsihvrUxzIny0=;
 b=32PyJsx3rCc2GUsEjS4iysorzgNgy/wWnOndwGTjpRu6XzgGkEhmGMMcImDtDgGpnVFyfvGrbki0W65SNOj20l9BgwcaiwXLTm+L5spx74Pbw1emyLeKOd+G+ync5EJX91IQRo0fhdQ3pvIpyWA45rNk/AD1zc1Lq/ECUeY0gKQ=
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
Cc: Alexander.Deucher@amd.com, Luben.Tuikov@amd.com, Ray.Huang@amd.com,
 Christian.Koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118051834.u1nSIP17SL558GaIznaM6wBCSs5EI60VHLTfskTZnGQ@z>

RW5hYmxlIHNkbWEgVE1aIG1vZGUgdmlhIHNldHRpbmcgVE1aIGJpdCBpbiBzZG1hIGNvcHkgcGt0
CmZvciBzZG1hIHY0CgpTaWduZWQtb2ZmLWJ5OiBBYXJvbiBMaXUgPGFhcm9uLmxpdUBhbWQuY29t
PgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jIHwgMyArKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCmluZGV4IDExMDQ0OWEuLmQyMDljYmYgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCkBAIC0yMzQyLDcgKzIzNDIsOCBAQCBzdGF0
aWMgdm9pZCBzZG1hX3Y0XzBfZW1pdF9jb3B5X2J1ZmZlcihzdHJ1Y3QgYW1kZ3B1X2liICppYiwK
IAkJCQkgICAgICAgYm9vbCB0bXopCiB7CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gU0RN
QV9QS1RfSEVBREVSX09QKFNETUFfT1BfQ09QWSkgfAotCQlTRE1BX1BLVF9IRUFERVJfU1VCX09Q
KFNETUFfU1VCT1BfQ09QWV9MSU5FQVIpOworCQlTRE1BX1BLVF9IRUFERVJfU1VCX09QKFNETUFf
U1VCT1BfQ09QWV9MSU5FQVIpIHwKKwkJU0RNQV9QS1RfQ09QWV9MSU5FQVJfSEVBREVSX1RNWih0
bXogPyAxIDogMCk7CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gYnl0ZV9jb3VudCAtIDE7
CiAJaWItPnB0cltpYi0+bGVuZ3RoX2R3KytdID0gMDsgLyogc3JjL2RzdCBlbmRpYW4gc3dhcCAq
LwogCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IGxvd2VyXzMyX2JpdHMoc3JjX29mZnNldCk7
Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
