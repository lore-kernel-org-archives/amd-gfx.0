Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B67C4CECE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43090206EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wR6NsuN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43090206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5EBD6EC01;
	Fri, 13 Mar 2020 16:10:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90F76EC01
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 16:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3MhDf3Xr51w/mrUhYckDf46JaNtzYi/U3v1Phs1rjsA9iup9p6gijT8E5UKVwJpKnIQM8VHx2QrO9JQcJ3Y3xn/dIEhjSpTqvu0kZ0SP++gpR09s4MowDOjEDWe73k8hWwxbmlDkVcYO23THoGgnXc45Pq4lL/fepYcnBlG1qR7GBOE4zey//daogTvMklPpLL1yl2jZzzZbbsQj9Qv/2tQbdSkS0W00BkqT3o+jowAkFCPV3xL2DhuG5awqOT9guUvCKvM55CfM8rItRhal7aRdB9BHhuf/KCBJ782lCz+4r8WqZeCy+F2Z22i/bE1AwCPUHY1Sre/ZW9Yk2ibHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPyf9A5ZRW3tNiALwjGLatenCdJUcPkT5OLnWXuoDVE=;
 b=YSkHU/OcCZzeIRTz4DC/5wv4QrkHs5sOZBJxo3hqPnC/COJcP82ixZS5YE8JRUvET2cCApCqKUeYmUFwDWWKxNA0ExoXfHlN85SQb7BwbePNRKZ+tONyYWWGloml/tX3k3FNtqPRR1lZnLHShnIsWZBbfvfhHpWmeVtRWcfH5qIXUzRJqzJWgE/XF4EfWqETrCrjtAg2NJHv0mlBMg+aE5P6axBzABDFmQxvBlT1Xz6z0UHRBOSzao8Ap1seRWo67M6dc7geeLXjGFC2hVW8mX8mJ+x5XO/VJjIJAoW6tDPMhOff9gKeQ48l6WeJUp9YM0lHty1Q+LReXz01575RlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPyf9A5ZRW3tNiALwjGLatenCdJUcPkT5OLnWXuoDVE=;
 b=wR6NsuN9LMbtfW4KmBI0GUgupEEqEjIXCCIfcPAPdJe+4AZldlhohON5kEfsvd/iLURFQK4+EstVdOYpv6XXiD4/Q4ZArGCR5Z7LHFM/758SDPPzhrbKEBUmESc9yu7riJ39ZW/2O0Ai9Pj26iTTPzD2DymqryvUhpfROlattdY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2703.namprd12.prod.outlook.com (2603:10b6:805:75::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 16:10:01 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 16:10:01 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 1/2] drm_amdgpu: Add job fence to resv conditionally
Date: Sat, 14 Mar 2020 00:09:32 +0800
Message-Id: <20200313160933.10394-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313160933.10394-1-xinhui.pan@amd.com>
References: <20200313160933.10394-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16 via Frontend Transport; Fri, 13 Mar 2020 16:09:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 928a024a-e432-44a3-194c-08d7c768fbb8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2703:|SN6PR12MB2703:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2703EBF1608337421629275E87FA0@SN6PR12MB2703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(199004)(6666004)(54906003)(86362001)(36756003)(6916009)(316002)(6486002)(4326008)(16526019)(186003)(81156014)(956004)(2906002)(26005)(2616005)(1076003)(81166006)(7696005)(66574012)(5660300002)(8936002)(52116002)(66946007)(8676002)(66476007)(66556008)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2703;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyL8aT/svsNcFspuS3ENzuDEhYc/T1Ly9HAWKnrvE2UMWHL4GeYqk5CVyBRcFEyRpjkxLuaR+ZUDr/gYPjVV44bCYuEBdgJfu15R12bAgljzkiFAhuKY66mnpud1eObez5vc5AasYApfs9ab9xudIeg8sxFMuyHjUTBhqPA7FBJhqpFXUChfqWZPKEhUuLTLdkrLXwBMVrnoIwmB6RSvbeoqXlKpb1rn1uz91j3i2HNTOqJG+tuWOjXX79ESNwYUZ47P2c0X1jVDjo18Uh2qXMTxZOMS1SvS1pYiP4h4/lM80vjSYecFdvf5lGwIw14WfRXFwpJQKArwG3k7C8cENT4ZB81nL950Y8HHmUrxOO7FqGIfYVZM91OH7ZrJKReXdv8Ia3Rg4oyyWxP9ILc9+iJglVq0S1uNjqLwSFqsjA8SpMZU3XZKZ750nN3HX881
X-MS-Exchange-AntiSpam-MessageData: i7gdLtII615UhkFq26ijlLH5gLDeE4XjYv2MNSiWGkzun6mDi7TBxaE4W8+B31se5ShgW/wh94bv8mKm5d/PxJ+XB84aQdlVx6lm9WZtNnKm+zmBkmkwWr26xfCsTYSepC6mIszuEx+DjYLNFviqSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928a024a-e432-44a3-194c-08d7c768fbb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 16:10:01.3954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVDDmXaaJ4Un+VSYQLRVDSHoM6leXOjinoLTC6inO4HQ8sK3X4x3CwUnzJJnp3gm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
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

Sm9iIGZlbmNlIG9uIHBhZ2UgdGFibGUgc2hvdWxkIGJlIGEgc2hhcmVkIG9uZSwgc28gYWRkIGl0
IHRvIHRoZSByb290CnBhZ2UgdGFsYmUgYm8gcmVzdi4KCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+CkNjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4K
U3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
ClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jIHwgNCArKystCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKaW5kZXggNGNjNzg4MWY0MzhjLi5jMDk0NjU0
YjIzM2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9z
ZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwpA
QCAtMTA3LDggKzEwNywxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9zZG1hX2NvbW1pdChzdHJ1
Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCiAJdG1wID0gZG1hX2ZlbmNlX2dldChmKTsK
IAlpZiAocC0+ZGlyZWN0KQogCQlzd2FwKHAtPnZtLT5sYXN0X2RpcmVjdCwgdG1wKTsKLQllbHNl
CisJZWxzZSB7CisJCWRtYV9yZXN2X2FkZF9zaGFyZWRfZmVuY2UocC0+dm0tPnJvb3QuYmFzZS5i
by0+dGJvLmJhc2UucmVzdiwgdG1wKTsKIAkJc3dhcChwLT52bS0+bGFzdF9kZWxheWVkLCB0bXAp
OworCX0KIAlkbWFfZmVuY2VfcHV0KHRtcCk7CiAKIAlpZiAoZmVuY2UgJiYgIXAtPmRpcmVjdCkK
LS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
