Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6713C49EA2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C8961378
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C8961378
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F616E12D;
	Mon, 14 Jun 2021 17:47:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C1BC6E122
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8YxZz6JI7pNAWmxN0qkA1wL9erepKwu8wb2915YVKhMCxZXxISz47UlEfewKPoAdq8lm0SAWRmLcHhtSVi5vJYYTqGVnk4acsGnAvU+40fJ19KYu97joW/KhxMCfbKiZHj6GlHLjzu70L5JloKwrxJYoCx1wwWECe9GNLEUUDQAMj8Q2FG1wrmuV1qHolHtXzO382pXwsrQo9uYG49DeGQQTX0v+ulhytHSZvcAaAZwWlvkpuwmpH6JXiHw+inNunr6X/gxFXCxIclTpUW9MvmD0EHTNYiz2JQkfXV4P7GeSMH4FdpJqjVCf+P/py6disi6XoBgkHvMUNKCQ/RcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Lnc7wkcunSbJ3MYfF4ZQPr89R7R15l19NzqcWASoM=;
 b=KFxs5RmGvnjmTtpgYj0SATpX4SJjk7hDfvkLm1DYs7cXUqIArqWOHXjBgAL2MZvMUgTQD57FojXdNEpMQLWlJPZJXmrGxBcfy0XyK+8UhHe1iqELjREpym1O9fxMMsPtESPuKix4fLCuyhqniYQ80tjapQ5E7m25k/pltWFB1KTBMpvheF1TGMDbRe9Z3VeOjC6B/b5jvGa/UCrP54bMr/uWtQ1AbwwT+EKHEIPje9YAcXJYN0ohY1/tfVnq4M59ythu7bVKZeRflU7xC4wZfQ4gwNSsPaadLiLHEDIdMzp+3Yy489NyCKDT8KAKNqNpH+IDbrgG1XNzPrVcQPWjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Lnc7wkcunSbJ3MYfF4ZQPr89R7R15l19NzqcWASoM=;
 b=rVC1D5mdJmqaYwYf+MhPXABq3obKXVj+AlGLwAqFQBBTitsfQv5pfSk1/oeZseEvDdx5tjkcU3kCmn+l6TDC/b3G1IEpR4hTOTlcKIbjT5JQNOuOPbpvbTa5iQe8a6eLrS0dvYCNBv75u5vIxw3xCvKUQKgTiD/qhqstnqul//0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:47:06 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:47:06 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/40] drm/amdgpu: Fix wrap-around bugs in RAS
Date: Mon, 14 Jun 2021 13:46:15 -0400
Message-Id: <20210614174632.20818-24-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:47:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02d751a6-24ac-417c-3656-08d92f5c6d25
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB369039EC07B7362F1C8179E799319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCv+6fb5+Ty3iqi5XlexPmbkarUIom8Rl3D7NGOYaMGitj5r4liOArOj3Fs8a+jX/Ht50s9Il8rVfMCL1t7vNqOo4meqlygYXNDqdqJRhBUuuHVemeU5ZAv6G8b8WwmPWZ+cOE0T4riFf4jws3EoKgx1tdDQt8dZk/3JNGCRtB9ltSEt+kFtJvaqZi1k53x3e5RQjAjjwfefLTTK8KHRnAYYw4nhE4l+iwhQM27Z18FhRMwASfuVLR2f4te32BfLn7/0i3ljDl7la2KzzxRKekeaDTfkySGFSyfSa6gFJBKnFuyjKlwS6oyKtsDKDl67kxDQJJ9PU/RT6p+0eC9pux3jfTq6GvQOqp0O/g8v0DuMY79pdHk0I9Kq9/dBRskbHRl65z6anksBw8LBn2Xtq+EtVOK6ZmIX8GFescTZ39msuYItKOVfgTInfDEJCSxM4RM6MPzwza6jABZOmXC/+xdEUp+IXWu/AsrmgxA1HvvBz02uGIZGNsVIQWA3OajlPGa7tRI03pucCOxna/RNCDemUJVACbVyjS7aCKDaPVaA12wE6h2Fu6SNcihbn6MZdXnR5VpRakvOM2M27TFaMrhBLExbxWGytilIued9UYYhCIkAWH2H54iwiwnMpymVVcHbovfqY9o/6rB/L7rgOsxvmwqmfjlT21YQeS3PFhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(54906003)(6916009)(66556008)(6666004)(498600001)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1BTUzk3bFNTRnJNcCt6ZmV5OGxXOUM2bkErK011MFh5VnJxT3czZythZlkz?=
 =?utf-8?B?L1YxQllmU0hGbGNCSGtaY1hsM2dUMENKRFFWRFFYR0U1RXVncTBPakRiRG53?=
 =?utf-8?B?ZS9iR2p0aG5NalNSQVNnYzJJU3o1azNPeHJ2aVZhVXhhckp2c092Y0dodUh6?=
 =?utf-8?B?WGZUQkR0Zm5mVVU3c3BEdTNqSGxlRVdkUmJpbDZrRzNDL0hva0R4cUVFZEM1?=
 =?utf-8?B?eXpkTlR6ejVVNnEweE1IWnY0NTFIUmx0NXlvbEc3QlFXZVRkNm5obVpCZkxk?=
 =?utf-8?B?dVpqQiszTzNJcjErVTJ1OXFrbHRTN2Q3a1ZJUWFHR2VLQXM0cW5Qdmt3Ulhm?=
 =?utf-8?B?cE16ZWJGcjhrdW9ocnZaeVM1V1Y4ZHg5d2VQeFl6RUIzcVFpaWFSZ3lqTkxE?=
 =?utf-8?B?VlQxOG5rZFR5cDQ3YVNJMkNqZUFoUnc4NlNYdUo3eElKKytRUVZGVTY4aThO?=
 =?utf-8?B?d0NMbS9tZ0VnTkVDUGF1eExvQUFkMXVzUWJ4NDV2TmJJdlhvV1p3SEs4bk5C?=
 =?utf-8?B?MFQxTnp0dC9GekdLaytUMmlNZVN2ZkhiK1h4bG9IdEM2bHBPVFpwMXg0ZnZj?=
 =?utf-8?B?TXNSbjUrRGZwNWppOUg1dHMyQjBPV0pTSVV6SXNPeEV2V2VQYUx5NmsrZEty?=
 =?utf-8?B?cWNsZTd0djJkMEZtVG11QnRLWUZETTJYSkZZWldacFVackJIOWtIY3lrN09S?=
 =?utf-8?B?c0pXQTRhb053aDU1VC82MHhybkw3c0p6b0hGSi9IRU5QUHFpZTY4akxSdFQz?=
 =?utf-8?B?NHJ0Vk1DcnZidnBibDJOTWRzeUw0SG0zb3BEczJQZzZwNmFGVXo3YkRGS2o4?=
 =?utf-8?B?SmFObzB1dlI3UHZPSXFFTW1JY1VDQ0JxSjc3Tmp4Y0lzUkdEaHpWbDlMcHdO?=
 =?utf-8?B?akNnSUpCbDUrZnJzd0oyYjdZSnhYMUJmRGxsNnpjc1VYeVpiWHY0akYzemN2?=
 =?utf-8?B?akJxZW5YZmx0aUpPMWxVa3pqb2FTMWlkNTNKS0h3N3FhZm5XN2dtTEV0N3RC?=
 =?utf-8?B?KzBYTTR5VHd2MnA3NHczNjNKNldYVWF6U0FhaDZaN01QUXJ0VWJxQm9EZDVj?=
 =?utf-8?B?MWY1SXFXK0YzT21FTjRJNWlwaEgwVjh4M3F1Y2FYb0J4SktOMnpHWThNWXd4?=
 =?utf-8?B?MEp0ai95SythK1VtS0Fxa0ZPR3dTWnJMSDE5RUp0eTF4RFdid3dwRzY1OE5O?=
 =?utf-8?B?WmYrZHFEaHZwTDJIUUlOQmZIN1NiWENyUCtFNExrZ01qdGV3UklYY2pUZmt2?=
 =?utf-8?B?NDFzdHoyNGJZdHpGUEtWNm5naUF3ckZ1SS9Ocy9qeWp0ZzUyMU9YWlVlUGhT?=
 =?utf-8?B?TjBGUS9TQkJ3UEMrU2tuR0NOeTJ1bFY4eURPVTZpTG9ONStDVWRTOEcyRm42?=
 =?utf-8?B?KzhZWGs3VXBLVlNDdHQzVy9vR0dnU1RRakVpampyMG10VXFYOVQ1N0JFeEtW?=
 =?utf-8?B?eEdxa3UvaTNQTG9lbVkwaHpyOE9uUVZxTnNuY0JFVk1YWlpHdFJtcHdnendV?=
 =?utf-8?B?YUZnbG91eXg5K25kK3dydE5mQ2VmeDk2NE5KTnlQUDNhdXBZVm9kdjYwT3o4?=
 =?utf-8?B?aWNOa3huYUZwQm5ZVlQ0OU9iTTluSDdUYkdZTVVUMkQwdzNna1UwZzdUOTd5?=
 =?utf-8?B?TkIrYWEzUUR6VE1QY2YzVFR1UWNWbWZVaTNna0tVcHMvSHJlSDRQQ1o5U3RO?=
 =?utf-8?B?V3hOL0k3bDNIUUZJNitFUGlQU2xuOWE5RjdhVkpwMkdHV2tHNytDR0FvMXVs?=
 =?utf-8?Q?GpeD7a9fMeY1GQJ+iePPtsK5Lh8MvYDa5pfbYpb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d751a6-24ac-417c-3656-08d92f5c6d25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:47:06.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7BN3ucwd6K/XpCS8cZ7GHV/8sIl4PXsgtA+BdiEPdTDVeY1aMBKN3NhECqv6oJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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
