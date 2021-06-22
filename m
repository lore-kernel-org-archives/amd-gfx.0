Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F76C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739876113D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739876113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8989A6E5C0;
	Tue, 22 Jun 2021 16:24:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0306E5C8;
 Tue, 22 Jun 2021 16:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeRB1fCPeOaA3fCKc81b7YZGK7hD5Qxhp2VI+i/JVCu3rjNMrDxG703I/5VwJ9EmHhYx1wpazaxFzF+aIH+6gyqrsu9DA8EEG1uv82a0M+23F/1cpXmK6dJ44P+qqTOu1ZDYM89R8aLlqR3+BmE/Db5BAWTL34/CRzEl5+MYy4inJxiUNr5/XuSlozofHuu3jK0R9Ex13gsJvX+2srhga/9IdQnQFkmTZQst5FG9+fq52c/jCm2dSesM25Es1Go9Uh58LQJnPGuRPhj2oOej1ipFVxpF+ZtiahnzPZlx+RQTQAaTHPYRcZkZ5xVNdkSRmQDOvxQ2KxuZ2OqtVnE1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CaiVlPbXcMzNAIKpwZZwB1jg9zp/xGy6bWKgEEYdfw=;
 b=gXvH0Ra9+kWEixBR2PWBREbVU+67LATDQ5R1M3kOmnDy4OS6iSkLiz8Tq9ypa9PiyExYEVsROq3d0ZxBmuKrtKxvRy/xHA1T2xAwil+acKRlm/Y9TCKmtOXQfnFX8aYYL9lAGJLMd0rolK7OYnoZGF7JWrxwB8NxMdfqkkWB9YQIy7A5VFxNYw36f5fEHRtIEBVrXZVeDgZOoZlDMUJMBHa80dEyLjHjEEU78gYRtBScCZNoRLo99sn+3EtFcrYiJ+siB3EFl1Q14UlLc/FIcK+4YoNi9EhOB/jfC9Mq0m0HLyRSeOVSSDWH8SXESUvR3GnNdyNBwN64pIiKAgBfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CaiVlPbXcMzNAIKpwZZwB1jg9zp/xGy6bWKgEEYdfw=;
 b=3JnNnu1ysrgUjKgCuyiabtgadEAO5bZOgyDxI7FWHitbMAXoZTGmp0EMo5QLZS6MhwqhbH9M9VzrWzpyIckmOqT6OC0LkhQir4PLaM7EcXgRzoKerwTXttjHtSIBDqHCiDSXBE4bN99CruFeXXFn3ld4fsmgt3J0lLFbTsgv64k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 16:24:13 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 16:24:13 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu: switch gtt_mgr to counting used pages
Date: Tue, 22 Jun 2021 12:23:37 -0400
Message-Id: <20210622162339.761651-4-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622162339.761651-1-andrey.grodzovsky@amd.com>
References: <20210622162339.761651-1-andrey.grodzovsky@amd.com>
X-Originating-IP: [2607:fea8:3edf:49b0:5c6b:dde9:a4fe:685]
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home
 (2607:fea8:3edf:49b0:5c6b:dde9:a4fe:685) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 16:24:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aeb7a891-d1c4-43cd-4451-08d9359a2c21
X-MS-TrafficTypeDiagnostic: SA0PR12MB4399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB439986DFC8C9101881B17D3FEA099@SA0PR12MB4399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5DiIst9sfXYH8/aTgFULAaGna1+G4lnMsTJnDKtSGuBhBCoA1e21ydta3Cm92HLomq91jqi8lkoSWHXLSa1BGojB3pcr3LACsLBOkiuCBHwF2vKXmDmClXh9RtoDw0gIA+cYA9uTbMWyLEIp7yEJpEq9wzcKvmK/E0CQj9SZ6b02D4hckpfQ+WvIw+s1qOuYQHIJNlJn58Y78Ol1tstsYDij3H65uveQutzWdc6b33I9yZmVfJYfW0b4nS37xWqSH3s6LWT1lBFRHzhU83qqcOLMS7NSUwGaWw61Lqw49eNL5ASvv74bBpFsJzLGtC8P3fwt9QTJQuDkPR5/zvq3kimByirUdOm879Bf8Oovu8RuZuLFgJwMzProNsHmIcR+61NxAvfgo34Ic3nSGCXfmGbnlcmpIGPq3fFRylwGb6cf/SpomoNOH4NThTu6fi7h9yw2YShQpCblco3xk/zyle8DzIn3SQVPlJPj/djRl9iqF1+4PO9P1jxHrM71oVP9oRiGiIwvS6kTS5phG6iCU4f7yYcDNtnIaz/ESv+35iLbpi5LEq1602AGoJ3F9xEVO2EBuwpqCpRgde08Itwb99Z0Xu+H2C9Q3jh7QlcMKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(66476007)(66556008)(66946007)(2616005)(44832011)(2906002)(8936002)(8676002)(5660300002)(6666004)(86362001)(6486002)(16526019)(186003)(66574015)(6512007)(6506007)(83380400001)(1076003)(52116002)(38100700002)(4326008)(498600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNXY05lTk1jbERtbWxYWU9RSjdhRUorMlpvSkRTNlNWT3RMV0hlMWpvZVFv?=
 =?utf-8?B?OGE4a0owSEc5RHc0a2I2dUVXQzJ2VUV4MlJHK3dUMlY1U0EzSWtXRmhzeUNw?=
 =?utf-8?B?NW40cE0ycWdKaHdMMzFrY3gvVWxtT1pXZmt6ejhwTnVHUU1WWjl1akVzOXRy?=
 =?utf-8?B?TTY0VHVqcEhWUCsxQ0JBNzFDSFNSbHJMZS9LZVR0STg1OTNFOWo2dnNwcHRm?=
 =?utf-8?B?b2RYVXJ0T2NEdVh3dnUweVFSNllSWmxuVHN1TjBXbk9GOHJmQ3RzdUR4VEpn?=
 =?utf-8?B?TkVxcTEwSjkxcTFFdTV4ZkU0VWE0MGhNMmJTaHJsQ0tzV3ZIeEpWTjZOaEts?=
 =?utf-8?B?ZDBZeWcwRkE5L3RsRFQ2V0hkU1AyNjhPOXpHd0hrVFp6dWZOc0RZWGVtbjMw?=
 =?utf-8?B?L1YvdFgwd0JORndkV2ZEd2x2Q0hpeDVOeTdIcjQrNHRLYnM0cGh3dnBxN1Jk?=
 =?utf-8?B?eGhEZGsraytHbmNRSmViQ1RWK2M1WTQ4OFRjMFJndzgyV05qZzJMODVaMjEv?=
 =?utf-8?B?SGNpRnc0RjNIMU1jbVFrSHhOQXNFYWJXNFgreWpiTEMvaVE1OE1xYW55SnIw?=
 =?utf-8?B?alI5aVZGeks4Yy9VbDlRNHcySTluSVFneHgwdVFCek92WnNFUG5pTFpkdjdw?=
 =?utf-8?B?VEVNc1FtQ3hwOWdmVnkzL1oyT3FKRWg4OW5sM1kwbUFxSllCeUNvWVowbEZM?=
 =?utf-8?B?Vjh3THltcTNCVkMybnU4NG9TeW5WZWJnZ2ZKaUw5ZmNlcGlsUXBxeDRLS1dn?=
 =?utf-8?B?dEc4Vy93R0dRV3hXNGdGeDFmMnJsSGtMbUhhd0h6NDNha3llRzBiSERzYzFx?=
 =?utf-8?B?ZkRFdkZoTkhwem5wMXc3bElwbkpkZStIbUtsd2VOam1lZGxoYnZDbEpMaEQ4?=
 =?utf-8?B?RG5nMVpXSWZudUhDQXFEM0d0VGNELzBXRHgxcVBSMTBrQ2xURlJFOEsreFJ1?=
 =?utf-8?B?anlnWE1MNUh4c3lkcFZjcmxIbXRUdyt2OW9yVEJVTjBTK3Z6aUx3RTNFN3U5?=
 =?utf-8?B?dXBIK015ckRFWTE5WlMwdnNiTDhzTWowTXgrdXF6VGFaMHBrRENCaXc2RVFY?=
 =?utf-8?B?WC9KTy9ZNGFZR0RLZWl2bGhMcFdMdmwyMnRMc3ZIaG9IbWliTnhCYXNOa0RV?=
 =?utf-8?B?cWJUSDhQL2RWYitiK1k4cDY1Y0hBMnJPaFlzZTlTQWc3bE1MWC84SVZucHd3?=
 =?utf-8?B?bDNyYkpydnVCOWhoTkkyeFUxbDZTdnVNSDNZL2cvYkdFNG04Rm5TVVlkWjI4?=
 =?utf-8?B?alQvQUg5QUtPL0ZzZE1NNEhscHVuSHhPSGZWNzJ6NmQvVlE0VVZYdWZ5N1d3?=
 =?utf-8?B?QzJJTkdvOGNEdm0waGpRYzlVb2hzeGdod2kvNVhEOXgvSHdFTzJTYWE2Ukt0?=
 =?utf-8?B?U0M1YVpjbFlHWjRHckhpTDdYbzZoaHBycVRwS1dmL25udzQ3NnU3ZXQ5czlo?=
 =?utf-8?B?ZW1QbVdFblBxYmFEbE11eXFjdkV1Z0N6czNqQlZPalNsM0oyekdsdThyb21v?=
 =?utf-8?B?VnRZYlZXTFRudGx3Unk4SVRNWkFzd2NOTXVqcWpxbWVyVkhpTDREUW9mbEZq?=
 =?utf-8?B?ekRkbzJLMnBzbGtwdHFIdThQUWcyb28wQ2ZqMmUyN2hhdk55dG9oRjltLzIw?=
 =?utf-8?B?VVV5b09tU1BaeFlFOEQxWWR2aHFDN3h4VXB5SlFvVzZwOUZmeUdLS3BFNHZ1?=
 =?utf-8?B?REY5bTYzUDJMSVZIWjc2UWtiN3dZWkJxanV6L3NpV1M4U29uVWcwU09YZENT?=
 =?utf-8?B?SlRjNUNxR01zV05CWFFIdGJqOHFBQ1BqMkk3QmxJbEdxaStkbDUrL0J2SmUw?=
 =?utf-8?B?a0liWHRqUVcvN2Z1UzhvV3RGV2NvRStEYlZMNDVVbU1KS1NXbkJlM25SbG44?=
 =?utf-8?Q?dkdHi3da0szqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb7a891-d1c4-43cd-4451-08d9359a2c21
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 16:24:13.3567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kQdOc0n5sppYN9PfZqF2A7t+FwaAPtPm8Wd3n05sLz1ViAk4hY6BPQu2LdV4VHubphn2OdYuM0L1AF0a/3l+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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
Cc: ckoenig.leichtzumerken@gmail.com, Lang.Yu@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTGFuZyBZdSA8TGFuZy5ZdUBhbWQuY29tPgoKQ2hhbmdlIG1nci0+YXZhaWxhYmxlIGlu
dG8gbWdyLT51c2VkIChpbnZlcnQgdGhlIHZhbHVlKS4KCk1ha2VzIG1vcmUgc2Vuc2UgdG8gZG8g
aXQgdGhpcyB3YXkgc2luY2Ugd2UgZG9uJ3QgbmVlZCB0aGUgc3BpbmxvY2sgYW55Cm1vcmUgdG8g
ZG91YmxlIGNoZWNrIHRoZSBoYW5kbGluZy4KCnYzIChjaGspOiBzZXBhcmF0ZWQgZnJvbSB0aGUg
VEVNUE9BUkFZIEZMQUcgY2hhbmdlLgoKU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8TGFuZy5ZdUBh
bWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3Iu
YyB8IDI2ICsrKysrKysrLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5oICAgICB8ICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9ndHRfbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z3R0X21nci5jCmluZGV4IGI2OTRkYzk2YjMzNi4uNDk1ZGQzYmQ0ZjFjIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ3R0X21nci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMKQEAgLTEzMiwxNCArMTMyLDEwIEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2d0dF9tZ3JfbmV3KHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdl
ciAqbWFuLAogCXN0cnVjdCBhbWRncHVfZ3R0X25vZGUgKm5vZGU7CiAJaW50IHI7CiAKLQlpZiAo
IShwbGFjZS0+ZmxhZ3MgJiBUVE1fUExfRkxBR19URU1QT1JBUlkpKSB7Ci0JCXNwaW5fbG9jaygm
bWdyLT5sb2NrKTsKLQkJaWYgKGF0b21pYzY0X3JlYWQoJm1nci0+YXZhaWxhYmxlKSA8IG51bV9w
YWdlcykgewotCQkJc3Bpbl91bmxvY2soJm1nci0+bG9jayk7Ci0JCQlyZXR1cm4gLUVOT1NQQzsK
LQkJfQotCQlhdG9taWM2NF9zdWIobnVtX3BhZ2VzLCAmbWdyLT5hdmFpbGFibGUpOwotCQlzcGlu
X3VubG9jaygmbWdyLT5sb2NrKTsKKwlpZiAoIShwbGFjZS0+ZmxhZ3MgJiBUVE1fUExfRkxBR19U
RU1QT1JBUlkpICYmCisJICAgIGF0b21pYzY0X2FkZF9yZXR1cm4obnVtX3BhZ2VzLCAmbWdyLT51
c2VkKSA+ICBtYW4tPnNpemUpIHsKKwkJYXRvbWljNjRfc3ViKG51bV9wYWdlcywgJm1nci0+dXNl
ZCk7CisJCXJldHVybiAtRU5PU1BDOwogCX0KIAogCW5vZGUgPSBremFsbG9jKHN0cnVjdF9zaXpl
KG5vZGUsIGJhc2UubW1fbm9kZXMsIDEpLCBHRlBfS0VSTkVMKTsKQEAgLTE3Nyw3ICsxNzMsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9ndHRfbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFn
ZXIgKm1hbiwKIAogZXJyX291dDoKIAlpZiAoIShwbGFjZS0+ZmxhZ3MgJiBUVE1fUExfRkxBR19U
RU1QT1JBUlkpKQotCQlhdG9taWM2NF9hZGQobnVtX3BhZ2VzLCAmbWdyLT5hdmFpbGFibGUpOwor
CQlhdG9taWM2NF9zdWIobnVtX3BhZ2VzLCAmbWdyLT51c2VkKTsKIAogCXJldHVybiByOwogfQpA
QCAtMjAyLDcgKzE5OCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9ndHRfbWdyX2RlbChzdHJ1Y3Qg
dHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbiwKIAlzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKIAkK
IAlpZiAoIShyZXMtPnBsYWNlbWVudCAmIFRUTV9QTF9GTEFHX1RFTVBPUkFSWSkpCi0JCWF0b21p
YzY0X2FkZChyZXMtPm51bV9wYWdlcywgJm1nci0+YXZhaWxhYmxlKTsKKwkJYXRvbWljNjRfc3Vi
KHJlcy0+bnVtX3BhZ2VzLCAmbWdyLT51c2VkKTsKIAogCWtmcmVlKG5vZGUpOwogfQpAQCAtMjE3
LDkgKzIxMyw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9ndHRfbWdyX2RlbChzdHJ1Y3QgdHRtX3Jl
c291cmNlX21hbmFnZXIgKm1hbiwKIHVpbnQ2NF90IGFtZGdwdV9ndHRfbWdyX3VzYWdlKHN0cnVj
dCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFuKQogewogCXN0cnVjdCBhbWRncHVfZ3R0X21nciAq
bWdyID0gdG9fZ3R0X21ncihtYW4pOwotCXM2NCByZXN1bHQgPSBtYW4tPnNpemUgLSBhdG9taWM2
NF9yZWFkKCZtZ3ItPmF2YWlsYWJsZSk7CiAKLQlyZXR1cm4gKHJlc3VsdCA+IDAgPyByZXN1bHQg
OiAwKSAqIFBBR0VfU0laRTsKKwlyZXR1cm4gYXRvbWljNjRfcmVhZCgmbWdyLT51c2VkKSAqIFBB
R0VfU0laRTsKIH0KIAogLyoqCkBAIC0yNjksOSArMjY0LDggQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X2d0dF9tZ3JfZGVidWcoc3RydWN0IHR0bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCiAJZHJtX21t
X3ByaW50KCZtZ3ItPm1tLCBwcmludGVyKTsKIAlzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKIAot
CWRybV9wcmludGYocHJpbnRlciwgIm1hbiBzaXplOiVsbHUgcGFnZXMsIGd0dCBhdmFpbGFibGU6
JWxsZCBwYWdlcywgdXNhZ2U6JWxsdU1CXG4iLAotCQkgICBtYW4tPnNpemUsICh1NjQpYXRvbWlj
NjRfcmVhZCgmbWdyLT5hdmFpbGFibGUpLAotCQkgICBhbWRncHVfZ3R0X21ncl91c2FnZShtYW4p
ID4+IDIwKTsKKwlkcm1fcHJpbnRmKHByaW50ZXIsICJtYW4gc2l6ZTolbGx1IHBhZ2VzLCAgZ3R0
IHVzZWQ6JWxsdSBwYWdlc1xuIiwKKwkJICAgbWFuLT5zaXplLCBhdG9taWM2NF9yZWFkKCZtZ3It
PnVzZWQpKTsKIH0KIAogc3RhdGljIGNvbnN0IHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlcl9m
dW5jIGFtZGdwdV9ndHRfbWdyX2Z1bmMgPSB7CkBAIC0zMDMsNyArMjk3LDcgQEAgaW50IGFtZGdw
dV9ndHRfbWdyX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IGd0dF9z
aXplKQogCXNpemUgPSAoYWRldi0+Z21jLmdhcnRfc2l6ZSA+PiBQQUdFX1NISUZUKSAtIHN0YXJ0
OwogCWRybV9tbV9pbml0KCZtZ3ItPm1tLCBzdGFydCwgc2l6ZSk7CiAJc3Bpbl9sb2NrX2luaXQo
Jm1nci0+bG9jayk7Ci0JYXRvbWljNjRfc2V0KCZtZ3ItPmF2YWlsYWJsZSwgZ3R0X3NpemUgPj4g
UEFHRV9TSElGVCk7CisJYXRvbWljNjRfc2V0KCZtZ3ItPnVzZWQsIDApOwogCiAJdHRtX3NldF9k
cml2ZXJfbWFuYWdlcigmYWRldi0+bW1hbi5iZGV2LCBUVE1fUExfVFQsICZtZ3ItPm1hbmFnZXIp
OwogCXR0bV9yZXNvdXJjZV9tYW5hZ2VyX3NldF91c2VkKG1hbiwgdHJ1ZSk7CmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmgKaW5kZXggZTY5ZjNlOGUwNmU1Li4zMjA1ZmQ1MjAw
NjAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaAor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmgKQEAgLTUyLDcgKzUy
LDcgQEAgc3RydWN0IGFtZGdwdV9ndHRfbWdyIHsKIAlzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFn
ZXIgbWFuYWdlcjsKIAlzdHJ1Y3QgZHJtX21tIG1tOwogCXNwaW5sb2NrX3QgbG9jazsKLQlhdG9t
aWM2NF90IGF2YWlsYWJsZTsKKwlhdG9taWM2NF90IHVzZWQ7CiB9OwogCiBzdHJ1Y3QgYW1kZ3B1
X3ByZWVtcHRfbWdyIHsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
