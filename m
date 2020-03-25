Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6621C1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 05:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642B020714
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 05:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oO1v7tvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642B020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E036E0FF;
	Wed, 25 Mar 2020 05:47:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 037F86E0FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 05:47:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDrTVklKH4K8aQ7YqbD1UyO8T4ZdmEBgyE6XIofW0OznpHhzR6XeBm7yFJrk5MtIqoTwtQfqEz0SHpA87mtCmLhYyR5mVJfOt/kOto1Rhgjx867ouDTitco3zhjmmBD8r5R/w+OR8JOLKhOhKE4LQ/jLNUtpPH8MTbSw1Rk8pZu3L8L2WWjVzC9R4jIjHCKf/JXn63yvvJ7Qkh1Q8LmwZA7cX+duxRf2yBSN2xnYzWJ41Q3xzqAxJQ+zFeZsiOZAKrj3yaLHRJ6qin2ddJr2waMCF1B1bpQUFELTo0pbvRTBbRkEdTg0Y3vcOynMvRPLIN2kP4VKE+mWKiIG/6vKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4EKpjNUp1GKAxrS8RYCfKLHmPSqNxLxYYUEcgJh9NY=;
 b=cV8g8aNdD9dQ7UOyu7/YHUcO+dcsA1WR2wJJSQ2ugLLBMC0LWOw+q/++k7VUy3Vm6PbfZMe35BrDxo+rwg1oPpV9jgNzz0kL+rluviZM7/TOr9xvqBKBiWlky5a6j4FfCnYUuurFiHWRUOht+mywjg6K0qDG0m2PZS3PqaL6xAQnQKvJyFvNUUVasLSPT4bUU2pX+yf69sHRFvKIGrLS/PirInLLsYgGBN0nLrCGDFbB4VKHnyaq9dj4u/nMh5YxW3nrrsWlbWSL/t1NholdT5DO0fyXt8N6HY7DjcqiaswInsNudki8P71a1NFWj+Oh6DQhFl9/mhFB1yyiQKINZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4EKpjNUp1GKAxrS8RYCfKLHmPSqNxLxYYUEcgJh9NY=;
 b=oO1v7tvI0hyYfvsZSWm2Wi5JaA9qIE187y3bO+zHee+JydTk2eGN22wSOk4g8olyB79SuuqZAFyoAH6KtYp6tzMZKp1atINPykaeY1dlwQIazB3VbJQNsEY/VcTmj85rY+tNb7XJ5S3ZH5gQdS2RNbsIuIb9ZpC2BsRPR33fOgs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 05:47:50 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 05:47:49 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Check entity rq
Date: Wed, 25 Mar 2020 13:47:23 +0800
Message-Id: <20200325054723.4560-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK0PR01CA0059.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Wed, 25 Mar 2020 05:47:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 999ed36c-42fb-49e6-49ce-08d7d0800ced
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:|SN6PR12MB2717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27175EEC129E89D4FD84356587CE0@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(8936002)(36756003)(86362001)(54906003)(66946007)(81156014)(81166006)(6486002)(7696005)(52116002)(8676002)(4326008)(186003)(6916009)(16526019)(2616005)(956004)(2906002)(4744005)(26005)(1076003)(6666004)(66574012)(66556008)(66476007)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2717;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CunDGWOBbMDB8URL6eX7IiVoYBfH+7RI5JXPsRFwegqZ4dMF34S9aWOFMi1CPEx1D2cqC7CLwBb4MQCp9mAqeqQK/JOPT0ynI0j4ABrqOukCRx209veXzYxCb/RK+3OGJwS5OyFy60VEQFPR5siVONfZNdijzaU995/MpIPjyJvTjhQW+e73qxG0hFnUIqbP99QfDosg+kM8DEhh1xZ1iFfESw17h28B8MuV1pcP9BFmyv6nKKwHLk6VG17G/UbfYA7Esg45yy6kwZsWBjtLEhdyISAvTY/ZBumeag+D/IR7C4IenziewiJZkLWIur05cyseQrZJZ+1yoWUe6M0Nv8H+uA4XT9+kAwf3lLtrNfmv3lJY6rzQVgp4vo13/dx0yL8UqXzMu/CZ9B2pG937Sto3fRFu+Ynghoyu2AzandSA815D++dEwPRnKsgaWrkm
X-MS-Exchange-AntiSpam-MessageData: l2pg0xVyDUFHnoUgMyK8eKmUXyFyZG8iIDfUJtOq8fzI+O1W+w7ljdCgGTTx5M3su84toX0zC40XrH/h45htXhJOTLYMwVFbP8xHBsosro5Sd8Apc4IR0QfmMLW5NiEmQk2zZWu95BPriqvDFHEebg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999ed36c-42fb-49e6-49ce-08d7d0800ced
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 05:47:49.1231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ODcf6FshRScB5n6rlBz9fFZj1kRfJhQuHa/pLeUlFvGS6eJ1TmDxjfVtpIKQ5yf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGl0IHBhbmljIGR1cmluZyBHUFUgcmVjb3ZlcnkgdGVzdC4gZHJtX3NjaGVkX2VudGl0eV9zZWxl
Y3RfcnEgbWlnaHQKc2V0IE5VTEwgdG8gcnEuIFNvIGFkZCBhIGNoZWNrIGxpa2UgZHJtX3NjaGVk
X2pvYl9pbml0IGRvZXMuCgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
RmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IHhp
bmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm1fc2RtYS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9z
ZG1hLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCmluZGV4
IGNmOTZjMzM1YjI1OC4uZDMwZDEwM2U0OGEyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bV9zZG1hLmMKQEAgLTk1LDYgKzk1LDggQEAgc3RhdGljIGludCBhbWRncHVf
dm1fc2RtYV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwLAogCWludCBy
OwogCiAJZW50aXR5ID0gcC0+ZGlyZWN0ID8gJnAtPnZtLT5kaXJlY3QgOiAmcC0+dm0tPmRlbGF5
ZWQ7CisJaWYgKCFlbnRpdHktPnJxKQorCQlyZXR1cm4gLUVOT0VOVDsKIAlyaW5nID0gY29udGFp
bmVyX29mKGVudGl0eS0+cnEtPnNjaGVkLCBzdHJ1Y3QgYW1kZ3B1X3JpbmcsIHNjaGVkKTsKIAog
CVdBUk5fT04oaWItPmxlbmd0aF9kdyA9PSAwKTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
