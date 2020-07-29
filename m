Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40713C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1466020663
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 02:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Bbq0W2Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1466020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E906E436;
	Wed, 29 Jul 2020 02:57:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BD06E436
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 02:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoa65BCrb8ID9kmwAltqvJ4yANc9gXy3jCeN2X9lbHA/cGKPTlbIH1V+oaBRPWzleNObvn5mN3Ihj2iRTTV5pvaS8LDbB4YcsiNhkv80mdRBOP1WejJD8FqRsTsHq4NZ0jtKzXXn11t4jCUVWDN6zEN/6b8XT/AZJBgfZ0wQ/pQk/zgIKgEUWVNfybhYEkBdmw4P94YW7p4gOZHcC81zl7HO+XYi4shrPL4A8kAzbKwnTHOmK+tuWZckxD4krp9RP06X7+Ygu6yCSroZfMRzNHDYbZXAiPsN5/NmTBIHknXNLBQ9tMUAfHPoY5FxE3u4efWRsWdeyIaA4rdfl4VdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MccAQd2cAVsL+kPXUvRccRK4nCfsu40RGKUaDZYicfM=;
 b=ZYgsSeYbH/8CDB3B8menTg47Dq9fiLWoI4Na8Jwh10fHdGEl8PLB0+hysH9mFirBu7ValzTRZ2pSZZLgJzLnQYGnfIuzIaxTINwJ+ctDB4p0V/+nCxNWIasjqOVaRoZX1zEYbOMUVVMJJu3paWIHcpmf8vtdiydE8LLrdzoKeRxCag3OMNCY4VNddG02qFbES0Lja2cDcDycYpOppFbgO4a2sL1QpXR9ptA5XY47VPsS59wX4YZPQ7Eig9CQUp9myaMK70iKb8RPgvUS4xjvzpQtgCIToykT5ttPdl2okZep3fchTvA85VG6uVa/fDFExyT2NZN1AfPbmFHIKQnLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MccAQd2cAVsL+kPXUvRccRK4nCfsu40RGKUaDZYicfM=;
 b=Bbq0W2Y3z5vK3n3ySccd7Enf6k+ZJzh2TdXKvTHQw8GKUABHMI96BDaZXtF+z4MzQI4j+RqhTQxn1lBurHnbKmcZsXlFGLueYd7WVtO7H8ZVFb9RrvDGMM9uiIBvaqhopSkLZirRAK1sQ6mJTIpvXcOlaS4UFTaYztvJQDdKr3A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1285.namprd12.prod.outlook.com (2603:10b6:903:3e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 02:57:02 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Wed, 29 Jul
 2020 02:57:02 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com
Subject: [PATCH 03/12] drm/amdgpu: add bad gpu tag definition
Date: Wed, 29 Jul 2020 10:56:20 +0800
Message-Id: <20200729025629.19355-4-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729025629.19355-1-guchun.chen@amd.com>
References: <20200729025629.19355-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0066.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 29 Jul 2020 02:56:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f7453f96-3065-4b3d-b57a-08d8336b1170
X-MS-TrafficTypeDiagnostic: CY4PR12MB1285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1285C20603C79570D640187DF1700@CY4PR12MB1285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3xfUd6Gk1pZLwMluGZpY+UlTC+z0LYz5V0le5dt9a1LUgEkn2TiM3HoD91VXyQShqV4x8O8QYlILcnY21/Fa0+UGcBCIpcNCR45DSmIwReX+7kUYIc1fN1oMQrCrYzmO439LLflUVmyMAbnk5/h0PBkzIcKsQv6AIrqVFxBm+gw4aqVBc0KErYwP947uLB9mCcev6oA40CBf1hsQuccMKcgKJDOgsOdBjKlNgz1+mzUZMHZlqEQ9C/jNX10u0THB9VRJAT9RTQ0IbCMhpDXXcjYDna8P4tRusR4WTspMr/vuxXcbhgIYWPjoSV/kJf2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(2906002)(66946007)(6636002)(52116002)(66556008)(8676002)(86362001)(66476007)(186003)(7696005)(16526019)(4744005)(6666004)(44832011)(36756003)(5660300002)(4326008)(1076003)(316002)(8936002)(956004)(83380400001)(6486002)(478600001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eDh4dz/s6gsbrqVh3qpOBafaE0BiJRPrv7qPxJ0VFMG6yVztPZeQHHhNIzegwYV0FrHfk85JTn6090cTmwj3yCmsKUuJcHVrZyzaYJ5LXDj7ceTfZPE9VyMSbWxQUHIzfY1XAPQdKOky5C1fyNl/rIzChhZMhiHEuUiVfW2UaMFqALj2Jwmz1pFyRJW63eQzXtdFWazws/NjwLcT/cxInC8QcaROR4ZZLiy9AfKUcTAR6XZc0bjfxqqcSxhZbBGqOElFV4CYksO6xplRyT1oUcnbvDbvZL5Wu3ImAqqG0PMK6Hp67g6smpOkjzPpIMa1vjlKckM8WxwvTFI3+kePiMt7E/BcnLLcdFau73fTrtS9kcBUiQIkv5/bCLM9F1SLw4AbnAk6SJ9KeAKUY395xnsbxEhuE2Zf5JPMOdM0WeAD2FRZZOcOKerUJWz3GVExwpjUzy5Ks3y73/FsKSc9w0EWTjR8pRIzzUUXrNsftgBB38bAA5TcvoXbx/BpZGyZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7453f96-3065-4b3d-b57a-08d8336b1170
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 02:57:02.4109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P/Qj17KOhOdrSPU6Dm6VvgplwXr4f6IsV8PZI5DUK1UxDRVuA1B97lThiF2DjHJWBKDwIh/2ljyhPTi32gzwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1285
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyB0YWcgd2lsbCBiZSBoaXJlZCBmb3IgYmFkIGdwdSBkZXRlY3Rpb24gaW4gZWVwcm9tJ3Mg
YWNjZXNzLgoKU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYyB8IDMg
KysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMKaW5kZXggYTJjOTgyYjFlYWM2Li4zNWMw
Yzg0OWQ0OWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXNfZWVwcm9tLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19l
ZXByb20uYwpAQCAtNDYsNiArNDYsOSBAQAogI2RlZmluZSBFRVBST01fVEFCTEVfSERSX1ZBTCAw
eDQxNGQ0NDUyCiAjZGVmaW5lIEVFUFJPTV9UQUJMRV9WRVIgMHgwMDAxMDAwMAogCisvKiBCYWQg
R1BVIHRhZyDigJhCQURH4oCZICovCisjZGVmaW5lIEVFUFJPTV9UQUJMRV9IRFJfQkFEIDB4NDI0
MTQ0NDcKKwogLyogQXNzdW1lIDIgTWJpdCBzaXplICovCiAjZGVmaW5lIEVFUFJPTV9TSVpFX0JZ
VEVTIDI1NjAwMAogI2RlZmluZSBFRVBST01fUEFHRV9fU0laRV9CWVRFUyAyNTYKLS0gCjIuMTcu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
