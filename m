Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F5C433EA
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3290D20792
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RcZQZpmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3290D20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AD86E20E;
	Tue, 28 Jul 2020 07:50:07 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750085.outbound.protection.outlook.com [40.107.75.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45B26E21D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ5cVhSvrBHFNxBze4nAJzJL74IEZLrW7sFWPmrPPdBrVFrvMWV6Gh6lmP1VDfo1M8QxlkW0HFAxzfhLxhP7VqH8JXH/S+HKEBR6NFIvrmysciJsKkyWm+X1XSaIZ1FyiMcJopYX7AJ9iehHWaqUZIqf+2Ckuq9NZUI/p8xf5fJvyC0L1mdcYRRq+Z4cfwsGq/Hu4RyOsDI5/+irGXd/CCnOZ8VWM98vgorCBCIbSEtYoobfphOVfmDsMulXc309i5f2K+TZnkwpFKibbovBQlCPOkdo66TZZoS/rCiijCJmOnWSkpIQoEiaTwgojbIB6X89YOayDz5qNS4ie0AJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MccAQd2cAVsL+kPXUvRccRK4nCfsu40RGKUaDZYicfM=;
 b=TXLqpcCHH+9oIVC/x5HkeOaWZZ6ctTVyMWA0VQ0+1ZncLkHJ+mKxVyKx9c922mH9MIMoOWC34nWBlF2RbgVQ/kTrkLNhsj2y9ZHlSxg4Dk578W1+jMngl7AjSUybw+UxZ9GAvH3ztxBRiaOj2pGtwz8opq00MQ9QEoWOTCPZ4mZ6numf/nYStv5RZsTDZNwKKiwWldc6gldovKKbq60AQfWlqKEANB8t+LAIfgPdYuBgTYOb41HYiAR+0cCUfi1FSGT3MVYajSbywtb4SAV8S7uODyW6I75W4oFJ2rWSjpICp4vNu81t6rU2aW2hPZrm/vYKwpOpzD6Fab4Q//AO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MccAQd2cAVsL+kPXUvRccRK4nCfsu40RGKUaDZYicfM=;
 b=RcZQZpmJen5cEqOz9CTSFoMR8wVQuQ1GR1Pf+bY8h6pC2dQZkr3CUCODlBUx9SH4AJb5UCBGdgSPor1NlQY9x3s5AiQZfbyNdyc/MejyJXBZy9cXcnWjx6mJo6UXo0YW/VSyKlDPDO32P73JLIw9MGfb/4v2EYfHAXgLU+d07dA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:04 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:04 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 03/12] drm/amdgpu: add bad gpu tag definition
Date: Tue, 28 Jul 2020 15:49:25 +0800
Message-Id: <20200728074934.12490-4-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:01 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dae014e2-296e-4035-35d6-08d832cad6e0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1752E45CB6565AB75734CD1CF1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2PTP+zXNleOwZjVkn/vMA+PMkmSkyp6b460G4GcHJwCKJP+r5nGWaqCffHm3h2QVq9/Jcqz+XIIteH2aMp1AWVJ5hevWEUzTgbSS36VBP8utg2QMEH671cd3wRs1ft3gg09/3sLVUN3zhYebI+SLFEWedb+H8AiIHvJw15Sruej3m+jrvP2FdAmPQ23ukre8CsFYBqHmnrBy1OiixPhrtDOGMzYz4IrzshfDmfKMGz3LpsVzX/38g6ZzIa82k28NvkxgusrcFyaQVFsL929TROCNo3ZqUzQY9Mdh7zF+1tMXhTCJgYbox3e+zpl3LjjqVo83teL224JrBZ00PCn92tIoz5MwK5Mm/d1pwRZb6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(4744005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 83OBe/AHGRkmpDvLDzaCoeJ87MSe5ZcAhVZ7W85lqG1XkKeujohdI5ZYLpet+7958FhueJKPp9i4HR5e/0TnoG5YdnzhFTB2Ccao4LKeJTO1McFACUOw+cCUIIUi0O41l/P8LywZHwQFT7OY8nPCz76d4cwGvAToTple6bHbLirQiVFBUhhcJCgzTBysIXO7q4GSNeOLxthlsb0FjJB2hgGdzQfkufv/ZZfrcPk8dhw4jCOyN5Qrb3iOKyDN7gu+pFZlh3u617If+W1Ou0QKYEJQ3w7Cn5TgNRI54RrHSlQoLlOh0CzhTUCKBZLEusY2By87Yw/qFeuJr2gSQ14Y6HoN15JQnQT5tbGpbR7qDktoW5Szyi1zWa5SAi/oOyJyp/voPl+9UvvwTs2C5k+4yr/Sg+1JcnzaygxHOC9OaeSx8D1JOASOe+MPvVBCrjIk7iMugsrajHYRYoFjF+RVyrIZSzmFK4+MHNnNnBJEs3hQGIed2YINykLb1bkdqvuo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae014e2-296e-4035-35d6-08d832cad6e0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:04.6484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEUbXXrXulnYNcVZUaEYKBvytxfhSYR/vt0m8dqFgHdcn02PLfAY49hjo6M/GDW4KSe8WhePZTZ5cwx+1IMzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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
