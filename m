Return-Path: <SRS0=AASI=IL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC7C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 02:44:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640EC64F48
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Mar 2021 02:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640EC64F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DC86E083;
	Sat, 13 Mar 2021 02:44:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C176E083
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 02:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6PpR5UTELQx3GZFcuDj2oPgI79/p/rMz+9l/q0FnWd5F5G8FU+xmA+WZizxgX1oaAmZajn/pj0Bvlc01AgFyCwNGvUzAjBYeskViKSoCKGVE6J+ZTjB06ato95apWGNuhxP+qQQv6ZE2EXpG+Q1SGLRHQK5JPVZfH3RG+vxTWhRf+8yYUOV/6jyjmOf4jvjvYMaNoNyV5aT/bJBl4BvzMC/xyaWWssWyHgdeo1TozCnTwSbh46jeMsznw1KL8DMOWs00oVpPdkiDhsjNSRAbLSar+46qJc5qYRNF5crUvqxfCtNbeSvCrwimrzd46p0llzZPAYewxQxERVWfKM+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdjaCDJm8R7bu3hqkGt7zmkcpAvYMi8zev6R7c+f2uw=;
 b=SF2LW+zvl+FipVN6qMEkILNrwy2fycumH5mjhNdYhzTm3LNtkDs7LuSInwCbYbSiZhYZQirFMe0JLddZ84sb+nndACtVeyuG9KjkG1yydXTtMYSpZdyXTbbxWg9g+6wcNlVP4cDseXW8gLJSExhDU9I4ZgTP8YID+SrpImdFrAP9Jf+L5vUhtGnpCk/R2SWw0E5sWOXp0+eR/pN2QNF3VVWz5DA31ijan1nom4EevCOA87rD/y5xPKGJmqK0CbnV2U7Wh6wgccX9vFDF12VvMarG76NQgkTDckEsJqcE7nNeNY2mXeZGkq2qAuAuisn61yeoBXQfepU9XJeroI3Jmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdjaCDJm8R7bu3hqkGt7zmkcpAvYMi8zev6R7c+f2uw=;
 b=r2BH9y4r8g1z3G10GnAUcgrx2K6jUWIvR7Z6fg/6DpZ3StR1o0EIQmttcgHWTo5kdw4Xxovuhin8gHCCp2CpS43gmBu6GeH1pJhMQxCILyU0MHK1WmOoUWiOkJXN7Jtyd7J5S5XG3SIEYnal/AXSgoamFU8+BjJ5PKss12NBC3M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 02:44:11 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.3933.032; Sat, 13 Mar 2021
 02:44:10 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Fix resource cursor initialization
Date: Fri, 12 Mar 2021 21:43:51 -0500
Message-Id: <20210313024351.10908-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210313024351.10908-1-Felix.Kuehling@amd.com>
References: <20210313024351.10908-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::31) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Sat, 13 Mar 2021 02:44:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fad1869-0180-447c-39c9-08d8e5c9e159
X-MS-TrafficTypeDiagnostic: MN2PR12MB4223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42237D73A9E5245B1AEB2C4A926E9@MN2PR12MB4223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dz+ZVv0KdvHhmFwtQrkmYbHN6/t4oAcMT8IyO2xgP2DVwlQYTpl7xNcUHDuBMHPOopIB3CUUMpktnJCOpvf7Fod0dAEmwyyZhMpbT0YxgGywv4qmF4Qt8xL1pQyFN6rDhOQ0YN3AoeNOMqMUqDM2VkW0/mo4dP3PDNVU/4vJnrfINcGwYGfNy9kIMFuqVYHTqYDF53piTyep7UysnTu9Ap5+4HK9xZkIYRy+hfc23PZhPHMyaxvv6VLCtFN9nMatt2s8SMC8yFK/4ypYEzs/T6nD4iy1tiX3VW4OveiG0sCm53EjDc4GJ8oFErUycAGG47s2Tu46fKVvsBNEpt0dRGPh6F254NR5dhD1d7frVpTjfU1dJRIS1WCVBMooV4axf3fFYzktN9+XGKqTUdQhHjbgsbr6syp9T/RrQLsSuFd2D0J+3B0fS+8Eg4Y9T/PFUgKi6cvFCygPB5I+XGRP7bOH1B3gtXgxDEJFbxQaBYrH9s9nwzHgtA0HH+1s2e7qGpo+MmmEiSuqe87Is6617Bn+RyGn8PpioDhURkimhekZwVIeN0M8mNX/yLPa7Z1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(6916009)(66556008)(66476007)(478600001)(66946007)(4744005)(6486002)(8676002)(36756003)(26005)(8936002)(316002)(2616005)(52116002)(16526019)(4326008)(6666004)(186003)(5660300002)(86362001)(1076003)(956004)(7696005)(83380400001)(2906002)(66574015);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RFFDZ0VXWjN1a2g5R1o5TEl2SUhmTG1mdDRId0l5b0w4VERhNmdJaE5RQUVj?=
 =?utf-8?B?WWJNYnh5MGtRZG1yWmJDbVdIUzJic21meHdvT0RDNmMxNmU5SXJPQ2tDdllj?=
 =?utf-8?B?NFdNanVZd3Fsd0FxL3RPQ25IaGZQc2dPRTdsUml5aDdEZXJSbjNodm5mYTNJ?=
 =?utf-8?B?SURBZU0zUHNIVGtrZkxldTJYbWVUV2h4MU4zdmFSRDZ6M2NCTWZuU2UyQnNS?=
 =?utf-8?B?cmpSUHF0QlM4eHFiaUdOVGVwOFViRHpQNEVIbmpiUTRKc1RWNFFpcTNPckQ3?=
 =?utf-8?B?V2lwcHZuWG1NLzdyckFWQXdyNytwdE80UTNmbzdaOEh3eDQxYXZQV3JjM1BX?=
 =?utf-8?B?emFJbHFmdHdlMFd0ZWFyZklyWkUrMXdWV21BNHBMQmx5L3RRUk52SzlLL3lq?=
 =?utf-8?B?VWxYcHlQeTZXK3N5YlEraWJxYlBYSkNZV2gvTkJDcWhHMXdCaCtOTC9UZ0Ew?=
 =?utf-8?B?Q1NXYlpTOCs3eE0rb0J4WDdXekxqTWk2UVlDYmZhdS81N09IenZib3RLb1BR?=
 =?utf-8?B?b1hhRTRNZEsrZUZkbmJkaXZyQnFkL3lSdGJuOEFwK042bnFlTG5LR0NpWEd4?=
 =?utf-8?B?WU9Pc1RVN2UwOHo3T1JFMDlvTXNPYWRaMXBoUlZCZTFDU3Q1WTFhbzV5NU1u?=
 =?utf-8?B?UXhrSDhXc1UycG9XSVI3UFlZMXppdjErWUE1TWNvN0owTWtVRFd3c0V6MUU4?=
 =?utf-8?B?ZkFKRDdTV2NBSnJ3QXJOek1tSTZPaHFvR2Y4V0tUaDdyZ2hnMjFKallDSE83?=
 =?utf-8?B?bmJRTWFiYlMyRGh1UmdtUjVjUlNSWnFram5PU3ZnRDN6OTRJWUtNYXRzSlNG?=
 =?utf-8?B?TmJnTjRzaHZtMWhaZW5SWHdNcFlUOXg2d3p3N0JQMHBDWWZ6b1hycXA0dzEz?=
 =?utf-8?B?MjBUMlBWd3F6TmkvV0VuaDJHQnIyY2dIQy95VkRDR0V4NTRnT2MxYVJ3UDlX?=
 =?utf-8?B?bDRRUVUxRGY5Y2kwUHNKWHUrOWJDQmp0ZVJlUCtSa2srUzBSOVp5UjZXeUZY?=
 =?utf-8?B?b3BQZlRVZENVQW1DWHM5YzB4U2IwTzlUWGltWWp0ZGVjSDkxRlkxV2hiVHI5?=
 =?utf-8?B?aEZ6VDJ3elk1dE9SZHRXckpLcFFTL3Bmck03YTVFYW5mQ1B3S3p4NnBrS2I5?=
 =?utf-8?B?MlYzMDNieDZrL3U0cXBOTGJhT045T1BMeTZnVXZTQ3UvdkovU1dOUUlZdWhn?=
 =?utf-8?B?UWY1V211cnlLQmxuMG1LNUVKMEx4ZEh0aTB2R2JtdzNURC9wcjh2elVJOWkz?=
 =?utf-8?B?V1YyblM2eHg3cHRPRy91bmVjaWxUYkcvSFNXdjU0eWhIZUVJbWYycXFEcmhz?=
 =?utf-8?B?SkhoUTRkWHhpYzcwZjd1VGlVVGNlcjNZN3hxaDBnWnpOOWhVV1A5andqNHNT?=
 =?utf-8?B?NzYvM2tEL1lCMHpVRDZmR1FtT0NUS3NKZTlOVUdxbk5UeUZvSkdQSndaVTFh?=
 =?utf-8?B?S1Qxb0VVRzRyWEwxQk0yK0dNWjc5N2xlYWZmWnRaM0tjdHpOSE85SGRxa1kw?=
 =?utf-8?B?aTRDMkpxbTJYT1RBby8rVTgrZTdJV3VpVmtkQ1VjMmJVVXFydmFvMXM5ZjJp?=
 =?utf-8?B?SkpmOEJ6YU16NlhQL09KRUNrZWszOWxkNlA2OGNxS3AwdzVKZTQ5SXJER3VC?=
 =?utf-8?B?OXptaGJnQWxaSmhGVU16V1cyMkhOakNiOFJLQk13eTFRQUg1VGkxWE5LNFUx?=
 =?utf-8?B?Si80TVlaS0UrVlVLOGR6UFRjQ2t1SzVUaXNESUZmclFmb3NUanZjWUtUVFVZ?=
 =?utf-8?Q?8X+6oXaoWPEZGo72ShgCmnyGbQKTAAYkerJGPB1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fad1869-0180-447c-39c9-08d8e5c9e159
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 02:44:10.8158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdp5WATYwxARoySvoO+qXIOkTjSZh0IYrHJCb7fCvDOg0IxORFQ/nJq7LYUmQnDy4vXep8yXbS6/MBmKXTAvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TWFrZSBzdXJlIHRoZSBjdXItPnNpemUgZG9lc24ndCBleGNlZWQgY3VyLT5yZW1haW5pbmcuIE90
aGVyd2lzZSB0aGUKZmlyc3QgY2FsbCB0byBhbWRncHVfcmVzX25leHQgd2lsbCB0cmlnZ2VyIHRo
ZSBCVUdfT04gaW4gdGhhdCBmdW5jdGlvbi4KCkZpeGVzOiAzYWYwYTAxOGE3MjggKCJkcm0vYW1k
Z3B1OiBuZXcgcmVzb3VyY2UgY3Vyc29yIikKQ0M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jl
c19jdXJzb3IuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
ZXNfY3Vyc29yLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNv
ci5oCmluZGV4IDEzMzVlMDk4NTEwZi4uYjQ5YTYxZDA3ZDYwIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmVzX2N1cnNvci5oCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yZXNfY3Vyc29yLmgKQEAgLTY4LDcgKzY4LDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGFtZGdwdV9yZXNfZmlyc3Qoc3RydWN0IHR0bV9yZXNvdXJjZSAqcmVz
LAogCQlzdGFydCAtPSBub2RlKystPnNpemUgPDwgUEFHRV9TSElGVDsKIAogCWN1ci0+c3RhcnQg
PSAobm9kZS0+c3RhcnQgPDwgUEFHRV9TSElGVCkgKyBzdGFydDsKLQljdXItPnNpemUgPSAobm9k
ZS0+c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0OworCWN1ci0+c2l6ZSA9IG1pbigobm9kZS0+
c2l6ZSA8PCBQQUdFX1NISUZUKSAtIHN0YXJ0LCBzaXplKTsKIAljdXItPnJlbWFpbmluZyA9IHNp
emU7CiAJY3VyLT5ub2RlID0gbm9kZTsKIH0KLS0gCjIuMzAuMgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
