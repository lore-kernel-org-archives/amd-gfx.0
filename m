Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA74C49EA4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E448E6054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E448E6054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A866E28B;
	Mon, 21 Jun 2021 17:13:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C036E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZTltSkHXKzJkadQZmV3TsOq0wDzZSanFmxvASIDe1Sgi74K0SbDsvxOYfafU/+SOD4oiSepNSWNr3o+qBjl4hQp+MaesSEW9wbgpc2jTl+GGPqZC7F+HfSGYulRcYj+cQTvaedmcWUUKX0puhhTMs44zChPy9tkK3QhzYIHpuCqq0G7fSSiCVGpzgQy2BtDdsNNIjFkVGNs4GWwmcMsp/iMcpkp6/WrBEksg/869KCftxFAnVUdxpWiDy4QcC0ODbBEx6CujiUdx4OpOulq/Vcrtpsh1yD/yNr4cBtNTqCFpuOVROjUPUR3WoeNM9E3856ZBN4kP+El7zkPdmil6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Lnc7wkcunSbJ3MYfF4ZQPr89R7R15l19NzqcWASoM=;
 b=awdQMDPY4o6o+gg854Ec8g99vuVr3LDkfyA/eGLaevQMXKd0kLrVSB7lzPAgQPTX6PxZBsz8Uxm4npYzOzvAIlP1hRU70R+axs5gGt0284TsZBfKRyj47QnGuaEMl4cke+G4k6xPbXi/thnTC1vjTr48LHWqwivLN+C8GlxfR4IzUcn/vh/Qpa9ppu8WIlrvpi0w+2ujUjkgxu0enbvnt7Ippg/JWZ8WhNbvn56yiNefvKHi3o/xnBvhnpqMYixMb7z0dwrcgvC2wjyPZiwPvLPcEAUevpXbDgHVd0A2SjVjO5sIiu7zGBG+mIpLguUk7NzBYB2SJGBsk/RP1odHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Lnc7wkcunSbJ3MYfF4ZQPr89R7R15l19NzqcWASoM=;
 b=lLdFmdHgi2KCDuG7JXwKDaEVKINx3zNKtYc2YiO5KahqDRXua6ChZsSPIxU0/0q3K2X7ShhnE7X/mA1Hts3kWT9qNgmt+j0ZysUb+FhUiUnw+rrhYzCtM2eZG7Gi3K+obW8aDxJFqdZeUHqsF4Bd5THJuq+LmffKxaP/uEHOwCA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:53 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:53 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/43] drm/amdgpu: Fix wrap-around bugs in RAS
Date: Mon, 21 Jun 2021 13:12:01 -0400
Message-Id: <20210621171221.5720-24-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35a5c99-69ad-4978-8d4d-08d934d7ce3e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865C8CAC13A0D3F57D5B2A3990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWg43TUg87BUgpnXupdg6kxgPbW/+Bn9gJXGXqwHUB2Hav9y8rpou0DrlJcdk/2PGG/+GfdfCcWgMkhWvXV0pIcvK4H1N6s0nve5ZsYtUeLazs9INXEQEBrO+oh9HwPnbvMnx4vE/xxCEnqnCjM7Kg2FtAIXHmT2JWEehn24NrdG/JjxmOL1yQ1iGuGfZSnbwTBhkBbY2+vO/vVnFVDzxB3H7TF/Mpu8/wL+ZutBEjAAWwYLtsPVGbIRKYO/M5mMRuEeRufhGOE4LtJW/HsOl8PER1zYFXd8SpqRfhUGFsvJqaqiruetT8n+J6lJYNlx2z3FjZwRUD2haZ/iiBPV1ZpTmWIjOf4ytfHaaE3Csx+N4a10XY5l/kUffUEuRF8ebY7VfGMEeauWGtzfsPFJTlmhLj+bVETOzE6m0bGHl4J2tGXpGEpGEipq+VVDL2by5ZhsWDSq0UGXmTLceiPCbY3aGbEEtT/21+E0vSfdnqWEnnxHHSAXinf0q2xBeZwVgRN3zA7CShEgjqmkp2rX+M+2SGta33+tvKI1yCuy62jfD6o6OWjg2kMYD6AeNRJGk1UVdDQkYoTli4uK3MK7NyrTyDSb0xxjT4EVDsaxCBYY3HmUriXKXlAOe1Uh8T89omOeYddZOVyULIaIcrWdkkCqanvdIDdcWC3heoFYMzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2l5aWtqZlNEdFY2VUJqQ1hGcjlJR2JmNFJML0Uxa1ZZL2VhdGdxcTJTZ3Zy?=
 =?utf-8?B?VGVTT2lRT2xEZGtwTnI5b1d2ejdzbk9PUFhFbis4NS9Cemtobk5paXFVa2VT?=
 =?utf-8?B?Vkk1TkY0Zm5lbFdaYXhNdjYxWXI0cG80cmVBUUpqNmxQMmdSa0I4QUFkQ1Mr?=
 =?utf-8?B?QmNFTExjY3dNMHNmMGsrS1BxRll0RW9KNzQzbWk2b1BQbWFvQUYrRUVScnk0?=
 =?utf-8?B?SzRmRnJjczRyblJ4UHF6Z2Qrdlp4RW45NzNVa3IwV24vVDJwQmlpU2x3TWFY?=
 =?utf-8?B?c0g5eXpnbE01aG5HTE1ONTd0WEZ3SlNybEdHUGhFbmh1WENGZEs5alcwWnAw?=
 =?utf-8?B?cGZ6QmhZL2N4SS9Ubk1yNGtXWWpNemROUmFZOUdiaGVJNVdWM2ZGbFVPMmUx?=
 =?utf-8?B?MHJLaWQ0T1RqeHJMLzljTVFZdnpFL29zMkZLbmN1WFJOMU1BQTRPenJyYk8v?=
 =?utf-8?B?Z3ErcVIxUjRZaGN3TE9PVW53b1BKZEsxK3FuUG9seFpoTEhOTEU2K2luTXZu?=
 =?utf-8?B?b3FKNTZ4V1VVQ29vdVVxdTdxNGMzQk5YRUlXenhyZ1krcms5a0psNnNhRjZS?=
 =?utf-8?B?OHBsZS92Q0wrSzRCQjZUcjZNMWl0SFR6RTM1OEswa3RUdGc0ZGFBeUk2R2xa?=
 =?utf-8?B?R1JwR1RsTnlkMW5aZmlCNFY0SGRRWjdXZ0cyWE56YlptR2tCSmFqeU1FVjIy?=
 =?utf-8?B?WmxOTGhYb21YUm1TU292am50bFN1OWtxcW1VaTJPTkwvVW9JVCtkZXlUNnhD?=
 =?utf-8?B?VXFNdlRrOW5QOUN5MTd2Q2kwWm9MeG11QUs4K01tSWZjd0tlZ2JZV0ZPK1pi?=
 =?utf-8?B?QVZ3UkNoTC9wT3h0Y0p1dVdrTTl4dkRNanRrM2krZmx3dkFtZ0sydHlnbG93?=
 =?utf-8?B?NHVuQVJCNFl4VHhzMnVJa0tXR3lmQlhybjdSYUpWS1lZOUowaVhQR0J3T09t?=
 =?utf-8?B?RmdaajZicWlXektTejdyMmtRcEM2UkdnaUFWWjFrcGFUeW9mQUJxd2puK0R2?=
 =?utf-8?B?cnNYbUpTUTl5QVJFOHg3S1lnV0F1am1CTlNXd1lSSWQwdFJaWDBvQ2puQWY4?=
 =?utf-8?B?NkdISVpCRndWOGZmOXVQRGU3NlpSdE5KVjJ3YUpoaXdXZVk0UGlUN3R0SGRh?=
 =?utf-8?B?RHFFTEJxbS9KOUtrMFdGOWxpZjd4NzlEZ1Z5T2EvQU9IQWdjZmo0aTlyVEE5?=
 =?utf-8?B?UlRVc2hMMmpwejE3Q1hFY1dYekIxaERWc0lvWW5ucHRockNDQVRBaDd3K1Vq?=
 =?utf-8?B?cldMdzRYS3UrT3dxWDRpTlNZdnIzeUFKMGxmalBqc0VTdXFUTHVjVU5yOS9z?=
 =?utf-8?B?VFh3cDlpQndMQitDaHlJTzh3c0VVMjVTUjI4RFByUk9ySnNoN2tjcXNscWlu?=
 =?utf-8?B?c2RmbCtlTGJZeURybGdJVFovYnArNXE5eE8rbm43dDQvcW5HMFVKRDlpY1hF?=
 =?utf-8?B?U1lCM1hETHc5TWh6SFdkVnRnekg1S2dZQ1ZxZXhHbFhyZmU4YVBBc3lNYmJT?=
 =?utf-8?B?Vzl3dHl1WFVZVXozb3VzSGh5MENyeHJwSDVMMklYdHlSMnJUaWZkQUZrdm9K?=
 =?utf-8?B?ZFZETlVpaGh1NUV2MXp0cyt3WC8rWGFEaE4xam54M1V1ekozNklMNEF0RzlI?=
 =?utf-8?B?bU93VGtTMzhjZDJEYy9QNVdSdnkrWnNtUEFROUJSSCtFaDN6dG9JVnRBRVFY?=
 =?utf-8?B?UCtTczlsNmxwTmNmRnRHMzVvT1VYNXNpczlmUEZDWHMvelY0MWZ6SmNUeUlF?=
 =?utf-8?Q?alggAXAQJGQkAg+oQ74ympu+ZGrsZ0eKruBVlx0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35a5c99-69ad-4978-8d4d-08d934d7ce3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:53.3963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k3VpHJvoGPSLONKkcMJiXR58feQP8g+IHG/88DQwbJAqVDKB5zgvXKUrRLIj0bb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
aWtvdkBhbWQuY29tPgpBY2tlZC1ieTogQWxleGFuZGVyIERldWNoZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJv
bS5jICAgIHwgMjAgKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXNfZWVwcm9tLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcmFzX2VlcHJvbS5jCmluZGV4IGYzMTZmYjExYjE2ZDllLi4zZWYzOGI5MGZjM2E4
MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhc19lZXBy
b20uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzX2VlcHJvbS5j
CkBAIC01MiwxMiArNTIsMTEgQEAKIC8qIEJhZCBHUFUgdGFnIOKAmEJBREfigJkgKi8KICNkZWZp
bmUgRUVQUk9NX1RBQkxFX0hEUl9CQUQgMHg0MjQxNDQ0NwogCi0vKiBBc3N1bWUgMiBNYml0IHNp
emUgKi8KLSNkZWZpbmUgRUVQUk9NX1NJWkVfQllURVMgMjU2MDAwCi0jZGVmaW5lIEVFUFJPTV9Q
QUdFX19TSVpFX0JZVEVTIDI1NgotI2RlZmluZSBFRVBST01fSERSX1NUQVJUIDAKLSNkZWZpbmUg
RUVQUk9NX1JFQ09SRF9TVEFSVCAoRUVQUk9NX0hEUl9TVEFSVCArIEVFUFJPTV9UQUJMRV9IRUFE
RVJfU0laRSkKLSNkZWZpbmUgRUVQUk9NX01BWF9SRUNPUkRfTlVNICgoRUVQUk9NX1NJWkVfQllU
RVMgLSBFRVBST01fVEFCTEVfSEVBREVSX1NJWkUpIC8gRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpF
KQorLyogQXNzdW1lIDItTWJpdCBzaXplICovCisjZGVmaW5lIEVFUFJPTV9TSVpFX0JZVEVTICAg
ICAgICgyNTYgKiAxMDI0KQorI2RlZmluZSBFRVBST01fSERSX1NUQVJUICAgICAgICAwCisjZGVm
aW5lIEVFUFJPTV9SRUNPUkRfU1RBUlQgICAgIChFRVBST01fSERSX1NUQVJUICsgRUVQUk9NX1RB
QkxFX0hFQURFUl9TSVpFKQorI2RlZmluZSBFRVBST01fTUFYX1JFQ09SRF9OVU0gICAoKEVFUFJP
TV9TSVpFX0JZVEVTIC0gRUVQUk9NX1RBQkxFX0hFQURFUl9TSVpFKSAvIEVFUFJPTV9UQUJMRV9S
RUNPUkRfU0laRSkKIAogI2RlZmluZSB0b19hbWRncHVfZGV2aWNlKHgpIChjb250YWluZXJfb2Yo
eCwgc3RydWN0IGFtZGdwdV9yYXMsIGVlcHJvbV9jb250cm9sKSktPmFkZXYKIApAQCAtNDAyLDkg
KzQwMSw4IEBAIHN0YXRpYyB1aW50MzJfdCBfX2NvcnJlY3RfZWVwcm9tX2Rlc3RfYWRkcmVzcyh1
aW50MzJfdCBjdXJyX2FkZHJlc3MpCiAJdWludDMyX3QgbmV4dF9hZGRyZXNzID0gY3Vycl9hZGRy
ZXNzICsgRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFOwogCiAJLyogV2hlbiBhbGwgRUVQUk9NIG1l
bW9yeSB1c2VkIGp1bXAgYmFjayB0byAwIGFkZHJlc3MgKi8KLQlpZiAobmV4dF9hZGRyZXNzID4g
RUVQUk9NX1NJWkVfQllURVMpIHsKLQkJRFJNX0lORk8oIlJlYWNoZWQgZW5kIG9mIEVFUFJPTSBt
ZW1vcnksIGp1bXBpbmcgdG8gMCAiCi0JCQkgImFuZCBvdmVycmlkaW5nIG9sZCByZWNvcmQiKTsK
KwlpZiAobmV4dF9hZGRyZXNzID49IEVFUFJPTV9TSVpFX0JZVEVTKSB7CisJCURSTV9JTkZPKCJS
ZWFjaGVkIGVuZCBvZiBFRVBST00gbWVtb3J5LCB3cmFwIGFyb3VuZCB0byAwLiIpOwogCQlyZXR1
cm4gRUVQUk9NX1JFQ09SRF9TVEFSVDsKIAl9CiAKQEAgLTQ3Niw3ICs0NzQsOSBAQCBpbnQgYW1k
Z3B1X3Jhc19lZXByb21fcHJvY2Vzc19yZWNvZHMoc3RydWN0IGFtZGdwdV9yYXNfZWVwcm9tX2Nv
bnRyb2wgKmNvbnRyb2wsCiAJfQogCiAJLyogSW4gY2FzZSBvZiBvdmVyZmxvdyBqdXN0IHN0YXJ0
IGZyb20gYmVnaW5uaW5nIHRvIG5vdCBsb3NlIG5ld2VzdCByZWNvcmRzICovCi0JaWYgKHdyaXRl
ICYmIChjb250cm9sLT5uZXh0X2FkZHIgKyBFRVBST01fVEFCTEVfUkVDT1JEX1NJWkUgKiBudW0g
PiBFRVBST01fU0laRV9CWVRFUykpCisJaWYgKHdyaXRlICYmCisJICAgIChjb250cm9sLT5uZXh0
X2FkZHIgKworCSAgICAgRUVQUk9NX1RBQkxFX1JFQ09SRF9TSVpFICogbnVtID49IEVFUFJPTV9T
SVpFX0JZVEVTKSkKIAkJY29udHJvbC0+bmV4dF9hZGRyID0gRUVQUk9NX1JFQ09SRF9TVEFSVDsK
IAogCS8qCi0tIAoyLjMyLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
