Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C62C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6290F61375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6290F61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1971C6EC4F;
	Tue,  8 Jun 2021 21:40:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298076EC4A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/5Y8eAmBnI4S6nJ7vLHbf221c4Luvt9e2TD2ArgcNyEzthyv9vyFJOTqiZ9r4DUvBj8kXB93g49xK16YK4bwn008u1U1MpuMKI+ZZsA5yCOltCGK7vz1laCsSSVu9C6yRwxaCm6MbGfJ1QcPlSka2xEdCw5HnQNkgd+YyII/hSMvmGshaci5cPpgLNW6Tn6UiWQKprs6apLIG3NxnxsBKoinRTQvj9cg1+2ftDhsH2b3hDm2hC60soFRCLd11l5OWVH19Gmuj9pjYivk+aZaRtyd+iA/mazxuqjHGDSw7K+xTh7I+6bR/5YW5bSricN4nk2sQN9VSyWeG/EMVMJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvIo5Qkuk6tBaQR0vBt9ixiW67TSQdcolsWBQ0PSVD4=;
 b=LIbfkBwhJ+8DUFBOinvR28i3GgbUF29Kgn2cecM778ZBHSD3XyXuf6+naOjrRNhNsYt1uuHxfRAEetmO0c5L2bT5G51LcvcLQncN3m1dnpPOmG0+pIqZtsDUu9t7HnqNx3Y3Lzs7iIr3hZUEr+d5k6v8WyOBEtsSZufkNgNwuPkc6jQKOcW5Wvkv2WMBZRLaLXmMNhCztHv6A/1qj7BeiWS8Cm3099UO85dzwRbXAYjgKzIC7kdfH9614opuvjJeaIWtTuaXf0JlQf+4V4Sl8EMpmHzZmEXdsC1M8dmkhDJEqz0Z3qTs3fwrHpyiXJ67IsUg5r9LE/lDGZIdysRPFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvIo5Qkuk6tBaQR0vBt9ixiW67TSQdcolsWBQ0PSVD4=;
 b=PqFIGH/8UppkMRrOe+fhyojt3SeztM4ezs/2nfm0XUV0YFFCW/gnHsblGY64Kvf+Zl7uGPNawAGhEuCwXUOiLdMpLyen1T5eN2FrSfMcYm21mIOSDdrIxjAf70po+8pbe1dt+LLjJpRJto5fYJ28zJvtWsJnDOwjgD3H4TyLnkg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:32 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/40] drm/amdgpu: Fix wrap-around bugs in RAS
Date: Tue,  8 Jun 2021 17:39:37 -0400
Message-Id: <20210608213954.5517-24-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8959112-41e3-49b4-f03d-08d92ac60aa2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435A6E144517846023C806699379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BT7guz9BPHXdX4JaWYSr2W1SXXxAk7j8FiTkHE5WUxlfLlvDtOXKrjFvXFvMxJ51UJv8CgBc7QvgF1T4GVpa/igRAcmwDbnGOtnH+kinzGziHxd8TI44l0Mz0UYJpLjd5gsXKtYuJn7dVb4qeEn199iaUpC5n5ECjoAWKNQKo+aZ9THEI9O1oAiXB1Yuu0hm55tp72llMJw+nK6AggR2QpJ7w0fwOuM40HT9cRhUrItQZviMAhqejwLeokjLsrcNAafXcuX9ojfKSX74n/ELBYiXpBKRswFyFEM/tWZjUXCYLcSmizz2BR1r9KNDPr5EM/FxVRfIUJJvIxxuQ4im9q46TAUPRJ8P6knSbhPh4mHrOUbujXs/2o4vn0pcPqRK7yzlNLqzbvtrjP8D1WShDlPOyzo39wTcgxOv2SJrduMyxR4u9cF1szsp+eO9VzyKQfxxJGx/kbzFO7d9VczSY41TWyQuDjKBxeFTrKx7xyfPkVstF98vhHn3P2JO1HyQaLQ3qjtsLf2ColvrBnkOLGQfvaU8lHbJL6Co3rdMWTMwoJ5OCRN5skx7LLh9SrlodGXksiOXtPX+7mrBsvfsQwE3rkg2bJ1GyvvmcrkXZa4HhukZeKoE/wJU8YQczceDcqkSf160u/UQh0j3xK9mlucASve5upV1Jmxz/3wzIE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVoK0ptZHUzVHUzeDFUQm5UUE1GOVZuSnJWcDhGSU9mNDZTNEswcGxIaXh2?=
 =?utf-8?B?UHYzQ3cyb3MwUHdST1FRRWFZbjZ3U2VNTzdQek9mVEFtM05GNWZQc2lyOEJa?=
 =?utf-8?B?RXdEMnRXb1k5RlJ3TUNrTkxuWmRTZWkxQUxjOUQzUjJ6TUkyV3hJSTdjbzAx?=
 =?utf-8?B?dVFSMVNEaTBTbVlYVGQrRTlNWDhrSTRoWkVXQ0JURzE1eGNBb3lMb0RsT29I?=
 =?utf-8?B?UWd1UTlKcHFPOUpKb1Y2Y0s2UHYvVXVCVys3TG5zUDdoN3UzUEExWFZTVUYy?=
 =?utf-8?B?NXZXYlhwWmMyUitualo4QWVWVzg3eU1yQVpsTHJPMTZLWkZmb0tRZFEwMENj?=
 =?utf-8?B?YzlsQUcxN3ZMVnJvZ2UyZHJJQzB0L0hUWUZiM2daUm9iQmQ1Z0U3NThSMGg5?=
 =?utf-8?B?L3BFeE5YVkFQMElaeXdyZjV5UXpGYzlCUG4xVGtPdDRWdUdUOVRaelZNSjVN?=
 =?utf-8?B?RUJxc1Z0VmVickV6MVhHS2pvTWNkRlB6SVFSQU8yVE96QklFUjNzbmkwM0li?=
 =?utf-8?B?QjFWRjVKcC9kanNKTEZ6Um9XWC9pN2t0amN2bHI4c09YanZ0dC9GNmNQcFlC?=
 =?utf-8?B?a1dnNWxxK1ZxV3pxa1U1ZmJBby81MkVTSUJPS3RDQWRTQ1gzUnNQYk05cWNW?=
 =?utf-8?B?L0VSUzNEMHpMazFhOVFOMnNVRjNQRzRsNVlFOTN4d3IxSGl4YVg4UEVCeE1t?=
 =?utf-8?B?RSs1TFdpbFVZU0lrK0dldVVEWXhidlFtK29BSXY4U0R1VVhpdlZzZStxc0lh?=
 =?utf-8?B?U2VHdW1aNWxxd2NEZE1EaW5jMS9pTno0NURuZTQrRjdySERHaWowRFl2alR5?=
 =?utf-8?B?MmZxT3JSVzRlNEpBdGEzNWlXemxPWUdKZVkxU3RGU0taQXRTMjdKMHBFcUlG?=
 =?utf-8?B?b1NTUi80S3QxMU1Qa1J1WC9LakhUM3ZmaE5HUWFpYXdKMUlMRHBNcm8yK1Uz?=
 =?utf-8?B?eUdaUVUzeUxVZm8vMmpGR20ybDNwd2NmQkd3RVJFbTlSWG9TRVdhbjZkVnVF?=
 =?utf-8?B?Sy9WYVdndUZCNmJPOVhlOWpVV2FYY0pUZU5uODhiempCTG9zQzVHS2pRZjVQ?=
 =?utf-8?B?bUdicmg5NGd3enlWcmZpMmVkb1ZGYjZoZGNqRllsMkVQOXVqbms5V2p6OGhp?=
 =?utf-8?B?bnd0UHJKdHZzbnJ2YzFGZmd1ZHk1dll3bUduQVk1M094eUpEQnZ2Y1ovL1hO?=
 =?utf-8?B?ZW5Yemg5Zmh3L0s1Zzl4bmxXeHZxN1Q0aWRqdDVKUGd6QThOaDBqb0VUQkZK?=
 =?utf-8?B?UmRqb0FwQ1F0M3N6WHZVc0Vpb0dWWnlySmNodUFuMk8wblJBMmdqc2VEZy80?=
 =?utf-8?B?dUhrRytlSjRTNmFTRVRrT0p6MnE2TURKY3JJRnF0MFpibUpCL1hmZzFleGFh?=
 =?utf-8?B?bFd3RTRybUVxVnN6ZXJxM21hbkozUFRjYm8rQmFadXlxS1o3cmUvOEd3aDlI?=
 =?utf-8?B?Z1EyYzBhNTBDc3RTMnZXM0RzcjVqR2tkNVQrRXZjNmszcU9uYmVabDl0OGxy?=
 =?utf-8?B?ZEZOcjJMeU5GcWNXVEMvdmlKc0VzVzlodkViS01uS3RpV1dtaG1vb0VRTEdi?=
 =?utf-8?B?akRSUFRjZHRzZ0M2L0xIYnEwNlkyMlhVcnRWRit1bHUzYVpmcFEzOUFJaTFx?=
 =?utf-8?B?ODExTzh3T2RmNnZ4VnVub21PcnlBczlzOExVZkRYZW00MEs5K0pXUlFhRjQr?=
 =?utf-8?B?RlRzMWk2bWRlajN6RmpTQVlKNVpiTzVUeG8zREEzOVdBMVF2OWxRUzFETjJ4?=
 =?utf-8?Q?z2Rv2B4maqbte0ckUoCCtqi3JvfY9b1tbs7sTC9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8959112-41e3-49b4-f03d-08d92ac60aa2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:32.2636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoNTsfEZaSPh1zFY19HUiwVstsIjP7QV3tQatkoVfFgBbcbJ0FFhj4cAwAkfZHWt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHRoZSBzaXplIG9mIHRoZSBFRVBST00gZnJvbSAyNTYwMDAgYnl0ZXMKdG8gMjYyMTQ0IGJ5
dGVzICgyNTYgS2lCKS4KCkZpeCBhIGNvdXBsZSBvciB3cmFwIGFyb3VuZCBidWdzLiBJZiBhIHZh
bGlkCnZhbHVlL2FkZHJlc3MgaXMgMCA8PSBhZGRyIDwgc2l6ZSwgdGhlIGludmVyc2Ugb2YKdGhp
cyBpbmVxdWFsaXR5IChiYXJyaW5nIG5lZ2F0aXZlIHZhbHVlcyB3aGljaAptYWtlIG5vIHNlbnNl
IGhlcmUpIGlzIGFkZHIgPj0gc2l6ZS4gRml4IHRoaXMgaW4KdGhlIFJBUyBjb2RlLgoKQ2M6IEpl
YW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5kZT4KQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPgpDYzogQW5kcmV5IEdyb2R6b3Zza3kgPEFuZHJleS5Hcm9k
em92c2t5QGFtZC5jb20+CkNjOiBMaWpvIExhemFyIDxMaWpvLkxhemFyQGFtZC5jb20+CkNjOiBT
dGFubGV5IFlhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPgpDYzogSGF3a2luZyBaaGFuZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1
aWtvdkBhbWQuY29tPgotLS0KIC4uLi9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXBy
b20uYyAgICB8IDIwICsrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhc19lZXByb20uYwppbmRleCBmMzE2ZmIxMWIxNmQ5ZS4uM2VmMzhiOTBmYzNh
ODMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVw
cm9tLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXByb20u
YwpAQCAtNTIsMTIgKzUyLDExIEBACiAvKiBCYWQgR1BVIHRhZyDigJhCQURH4oCZICovCiAjZGVm
aW5lIEVFUFJPTV9UQUJMRV9IRFJfQkFEIDB4NDI0MTQ0NDcKIAotLyogQXNzdW1lIDIgTWJpdCBz
aXplICovCi0jZGVmaW5lIEVFUFJPTV9TSVpFX0JZVEVTIDI1NjAwMAotI2RlZmluZSBFRVBST01f
UEFHRV9fU0laRV9CWVRFUyAyNTYKLSNkZWZpbmUgRUVQUk9NX0hEUl9TVEFSVCAwCi0jZGVmaW5l
IEVFUFJPTV9SRUNPUkRfU1RBUlQgKEVFUFJPTV9IRFJfU1RBUlQgKyBFRVBST01fVEFCTEVfSEVB
REVSX1NJWkUpCi0jZGVmaW5lIEVFUFJPTV9NQVhfUkVDT1JEX05VTSAoKEVFUFJPTV9TSVpFX0JZ
VEVTIC0gRUVQUk9NX1RBQkxFX0hFQURFUl9TSVpFKSAvIEVFUFJPTV9UQUJMRV9SRUNPUkRfU0la
RSkKKy8qIEFzc3VtZSAyLU1iaXQgc2l6ZSAqLworI2RlZmluZSBFRVBST01fU0laRV9CWVRFUyAg
ICAgICAoMjU2ICogMTAyNCkKKyNkZWZpbmUgRUVQUk9NX0hEUl9TVEFSVCAgICAgICAgMAorI2Rl
ZmluZSBFRVBST01fUkVDT1JEX1NUQVJUICAgICAoRUVQUk9NX0hEUl9TVEFSVCArIEVFUFJPTV9U
QUJMRV9IRUFERVJfU0laRSkKKyNkZWZpbmUgRUVQUk9NX01BWF9SRUNPUkRfTlVNICAgKChFRVBS
T01fU0laRV9CWVRFUyAtIEVFUFJPTV9UQUJMRV9IRUFERVJfU0laRSkgLyBFRVBST01fVEFCTEVf
UkVDT1JEX1NJWkUpCiAKICNkZWZpbmUgdG9fYW1kZ3B1X2RldmljZSh4KSAoY29udGFpbmVyX29m
KHgsIHN0cnVjdCBhbWRncHVfcmFzLCBlZXByb21fY29udHJvbCkpLT5hZGV2CiAKQEAgLTQwMiw5
ICs0MDEsOCBAQCBzdGF0aWMgdWludDMyX3QgX19jb3JyZWN0X2VlcHJvbV9kZXN0X2FkZHJlc3Mo
dWludDMyX3QgY3Vycl9hZGRyZXNzKQogCXVpbnQzMl90IG5leHRfYWRkcmVzcyA9IGN1cnJfYWRk
cmVzcyArIEVFUFJPTV9UQUJMRV9SRUNPUkRfU0laRTsKIAogCS8qIFdoZW4gYWxsIEVFUFJPTSBt
ZW1vcnkgdXNlZCBqdW1wIGJhY2sgdG8gMCBhZGRyZXNzICovCi0JaWYgKG5leHRfYWRkcmVzcyA+
IEVFUFJPTV9TSVpFX0JZVEVTKSB7Ci0JCURSTV9JTkZPKCJSZWFjaGVkIGVuZCBvZiBFRVBST00g
bWVtb3J5LCBqdW1waW5nIHRvIDAgIgotCQkJICJhbmQgb3ZlcnJpZGluZyBvbGQgcmVjb3JkIik7
CisJaWYgKG5leHRfYWRkcmVzcyA+PSBFRVBST01fU0laRV9CWVRFUykgeworCQlEUk1fSU5GTygi
UmVhY2hlZCBlbmQgb2YgRUVQUk9NIG1lbW9yeSwgd3JhcCBhcm91bmQgdG8gMC4iKTsKIAkJcmV0
dXJuIEVFUFJPTV9SRUNPUkRfU1RBUlQ7CiAJfQogCkBAIC00NzYsNyArNDc0LDkgQEAgaW50IGFt
ZGdwdV9yYXNfZWVwcm9tX3Byb2Nlc3NfcmVjb2RzKHN0cnVjdCBhbWRncHVfcmFzX2VlcHJvbV9j
b250cm9sICpjb250cm9sLAogCX0KIAogCS8qIEluIGNhc2Ugb2Ygb3ZlcmZsb3cganVzdCBzdGFy
dCBmcm9tIGJlZ2lubmluZyB0byBub3QgbG9zZSBuZXdlc3QgcmVjb3JkcyAqLwotCWlmICh3cml0
ZSAmJiAoY29udHJvbC0+bmV4dF9hZGRyICsgRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFICogbnVt
ID4gRUVQUk9NX1NJWkVfQllURVMpKQorCWlmICh3cml0ZSAmJgorCSAgICAoY29udHJvbC0+bmV4
dF9hZGRyICsKKwkgICAgIEVFUFJPTV9UQUJMRV9SRUNPUkRfU0laRSAqIG51bSA+PSBFRVBST01f
U0laRV9CWVRFUykpCiAJCWNvbnRyb2wtPm5leHRfYWRkciA9IEVFUFJPTV9SRUNPUkRfU1RBUlQ7
CiAKIAkvKgotLSAKMi4zMi4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
