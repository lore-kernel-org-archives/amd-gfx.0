Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91BFC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 11:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813FA2245C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 11:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813FA2245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA926F88D;
	Thu,  5 Dec 2019 11:54:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0660A6F88D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 11:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMKQnB4QWmFjhRYWzz/vUk7gA3QNRIJ0ktHgMdReYG+sDefp9fotvZ9IGixcJZQDpvUr/vcXvB+wX0DQwjCp6a4aKNxFfv51BWl/8a4X+pilme83M0vr2zmLVcMxLz/g6UyLLYC6peGWoAd4XOa1cgPBVVfFd8Ng6xCRXGueVNO7Lw1JmOo2KW/RfRijwoWs7vWShYdRmNTvBgFl3fZ9ZxajSbixiEzqRHhG0uOfyLXI2FmEb84qdmabMmf5f/OAqPsLjcC/7KlpEdbQawVclnaqmowl1Liy3zUc+VWIaCS2I0WFnkeQOzbe1AgPLomWdevYXX3msJNn+ULiYIJLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4uPfPHjUM1uVgS3eXZoVeHm2LjA+Id8uhV1y66XVxc=;
 b=e9btGxO9BXy6ybCJs4uueo3t/evZln3qUUjbbIii9OVwcSq2LMyBTa716uE0BF0S3aWWOm0mZQHDFdtX+7EOlaHxJ6rUeMei6YkJOXy8HVxv8pOEp3kXNz6Gm6H5YKeJqHPra4uKV3Frzlb0Bp8ecRMZ0CIWSktBCm41ZmDw6E1RYFG5Q6QD/bkKt8y94bIyAshzMJthKx7Osy+op6Sgv1izoiaLNsTZeFR5ql3P3DT6ZojKfQAfSO25AY2mUTETw0sHRHRWKkGUBV+6u29W6pYFKig4D5ECqS4/2SGqtB1LnMLsGhtaHAjCsYDUfwFVF0n5MjqBBYDt5Mtr+eA7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (52.135.55.74) by
 BY5PR12MB4180.namprd12.prod.outlook.com (10.255.126.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 11:54:34 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::cd51:d6c0:eba5:4c5e]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::cd51:d6c0:eba5:4c5e%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 11:54:34 +0000
From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/powerplay: correct the value retrieved through
 GPU_LOAD sensor interface
Date: Thu,  5 Dec 2019 19:50:31 +0800
Message-Id: <20191205115031.3822-4-Xiaomeng.Hou@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
References: <20191205115031.3822-1-Xiaomeng.Hou@amd.com>
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To BY5PR12MB4258.namprd12.prod.outlook.com
 (2603:10b6:a03:20d::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71852c38-f9bf-4dbd-c7fd-08d77979e586
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:|BY5PR12MB4180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4180462A5AF9834B26C1D83A9F5C0@BY5PR12MB4180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02426D11FE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(50466002)(14444005)(316002)(478600001)(8676002)(4326008)(48376002)(14454004)(186003)(2870700001)(86362001)(36756003)(1076003)(6666004)(2906002)(81166006)(66946007)(99286004)(6916009)(51416003)(11346002)(5660300002)(66476007)(6506007)(6486002)(76176011)(66556008)(25786009)(6512007)(26005)(305945005)(8936002)(81156014)(50226002)(52116002)(4744005)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4180;
 H:BY5PR12MB4258.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnVjHPDWDtk8NDJ+BQCJ6hoaVUYL6Fz+N4tgF41t2TgW0BaI1i2gKTTMMfOFBO5FL9IT0FDNgbm8fMasVO/o+9j/8LNN1isOuXSK3cVnTv5lJ86uqezL7zKH+Qqf4aK9hgyzASHFmskBNTlHB+9SNEJbabIEuachYJkK4L8+1TCJdX5GVTjW9eur+Dv+15Xx0dY6kyiVTWzWdq1nRq+Q3wnqbAa13i5ezXtZvShaZdQgegzFBmUnANccmokwW8YEuWgldAWC+TloXR7aVgs36jJ+H5gJ842ujKpr2qlXHwelmd6AwyguV2Ppo8rTEtdZOrC3EcczFfS2R17pT3M80tR6cmDA/GaGo4z5ez4KT0zeYFCD0C6cUvbKM90JOtOi1v0oWmQeaPWh4AlLjeyoMHJXj3/cG1aIFp0YG5ziGtDrxpbZFMgtmViLb7EMhyf5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71852c38-f9bf-4dbd-c7fd-08d77979e586
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 11:54:34.7771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4oF9SfygKUfCFYfNuvsIpiC8KKxe9MaRIe7WXVYwg4Y0+rRXELYYBPot6VFCnLyXiUwzgvQZPh+0FLzhp8f5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4uPfPHjUM1uVgS3eXZoVeHm2LjA+Id8uhV1y66XVxc=;
 b=P33Ae7E5ExY5axCnuiuLDkZF+ITQiolT5VwNm3gXcAEmGdurrmq6ME+ccVhJfIytRWvFmmU8IkdFcR7BffoDmO7EEjtwakoJWqLuJoiSlQYaf7Lkryhq8qoLCQUSV0MG4lmqCh56D5THXOXaQi0Mh5CapZh2hUZi/KjgxVNpJCs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaomeng.Hou@amd.com; 
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dGhlIHVuaXQgb2YgdmFyaWFibGUgQXZlcmFnZUdmeEFjdGl2aXR5IGRlZmluZWQgaW4gc211MTIg
bWV0cmljcwpzdHJ1Y3QgaXMgY2VudGksIHNvIHRoZSByZXRyaWV2ZWQgdmFsdWUgc2hvdWxkIGJl
IGRpdmlkZWQgYnkgMTAwIGJlZm9yZQpyZXR1cm4uCgpDaGFuZ2UtSWQ6IElhNzg3MzU5Nzk3N2Ni
NTQ3OWIwMTVkNjMyYWIyNGE3YWEyMGExY2ZiClNpZ25lZC1vZmYtYnk6IFhpYW9tZW5nIEhvdSA8
WGlhb21lbmcuSG91QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkv
cmVub2lyX3BwdC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVu
b2lyX3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvcmVub2lyX3BwdC5jCmlu
ZGV4IDFlNmI3OWNmZjIzYy4uOGZlOGZlZmNiYmJmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9yZW5vaXJfcHB0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvcmVub2lyX3BwdC5jCkBAIC01MDksNyArNTA5LDcgQEAgc3RhdGljIGludCByZW5v
aXJfZ2V0X2N1cnJlbnRfYWN0aXZpdHlfcGVyY2VudChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwK
IAogCXN3aXRjaCAoc2Vuc29yKSB7CiAJY2FzZSBBTURHUFVfUFBfU0VOU09SX0dQVV9MT0FEOgot
CQkqdmFsdWUgPSBtZXRyaWNzLkF2ZXJhZ2VHZnhBY3Rpdml0eTsKKwkJKnZhbHVlID0gbWV0cmlj
cy5BdmVyYWdlR2Z4QWN0aXZpdHkgLyAxMDA7CiAJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCXByX2Vy
cigiSW52YWxpZCBzZW5zb3IgZm9yIHJldHJpZXZpbmcgY2xvY2sgYWN0aXZpdHlcbiIpOwotLSAK
Mi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
