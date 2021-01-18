Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9495FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 21:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDBB22CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 21:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDBB22CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FBA6E5A2;
	Mon, 18 Jan 2021 21:02:30 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188E26E5A2;
 Mon, 18 Jan 2021 21:02:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdhq6+T8nA0nqrU5YHxIZI3hZ+h0eIpGEVx9KHf6FM+sg6Rxdab4CayRf2vHcllBmH0ik76yIktUJhNnKrFxsTItjpiqhDu8NJjrlGlDJJrIW0LAtQyatzzN/8ReMKhinMOaA84P7uazeXgGzIU9CYUrOHFizZpGUdB01Sz514Yf62DvVWdsh33hJJO8S51IKlBF7vctNSqyuQKdpE8PnfLun9Yt3JVyNjKxiono6Btrq8IHasIooEp/kkU+ZMief1cB74ctEN3LwkmJ1SpTbJDpMUKuAH132vHQr+XwL6tSi1z+uSB+GPiUD6c855ZEllFNXFmVG0BNMJDdonWxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vLdzE+IJs46N8vQKS6qBAcqDAEa3YfT3MnnF6Zcy0Y=;
 b=m7L2Weeu1nAC2j+op5xtimQ1E/4IU5jDqBMuRLup2XkblxfRlfIc/pfbdg06JDStJssr0YIa32AkfwZsia/L6DSHUx0jN37bLeXdAj49BCexLqe73FnHyen4oq/cajwwh4hzAWVLqx5EFTwKsl97ogLrO6mYV+utmbxV2+yEbsyCM2Qu7fIGzhIXsX0vc/WoC4jdcHPLxEMlEgWkg5ZXUqFXv9ansG6WxRNyDmTDK813N1sN3ufbdeeQvbU6mb8MxplBLK8srrTMxc81O9yLwWcydlRCtqm30vPHkyCz8ux5lHaOnD0QWFt65McaYFi9ZlJtLHTR4++jYUUvVo0BEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vLdzE+IJs46N8vQKS6qBAcqDAEa3YfT3MnnF6Zcy0Y=;
 b=BH6FX0k0AOf9Hqv8bB1+Hc85jF4daVHd3ZMgEBicAuzYgi1qNWRQMZA+CpVrNGUjMblMCvu/UXvTU7FH6VbRL6TPwsHiD2+RoSdSUcUg+78IKa1WYtjEuymdRxr1A1yrqPNmG0QLL70LdWuR6is3+WoLZ12wQnL6qYPOm2D8hek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4767.namprd12.prod.outlook.com (2603:10b6:805:e5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 21:02:27 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::5d30:b29d:5f5b:6921%5]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 21:02:27 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 ckoenig.leichtzumerken@gmail.com, daniel.vetter@ffwll.ch, robh@kernel.org,
 l.stach@pengutronix.de, yuq825@gmail.com, eric@anholt.net
Subject: [PATCH v4 04/14] drm/sched: Cancel and flush all oustatdning jobs
 before finish.
Date: Mon, 18 Jan 2021 16:01:13 -0500
Message-Id: <1611003683-3534-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1611003683-3534-1-git-send-email-andrey.grodzovsky@amd.com>
X-Originating-IP: [2607:fea8:3edf:49b0:84d3:21cc:478c:efa7]
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu-1604-test.hitronhub.home
 (2607:fea8:3edf:49b0:84d3:21cc:478c:efa7) by
 YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 21:02:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0535b1a-2401-4ac1-db6e-08d8bbf45c87
X-MS-TrafficTypeDiagnostic: SN6PR12MB4767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB476770F29F29E4145E328538EAA40@SN6PR12MB4767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:318;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rt0G0pYTcdm19yrYE2/xUpIzQTeKlcGNZ5pP+sb646ZF7NR1gCU9IuIKcawVNKfOsqyS9JGZAztHWWrt5T9+8JQNmwTRYFqQFQevOgFlWhqPNqj85USyMm7iQJKq8w0I8ExD4lUjv4loTjN5u+KVcZ3iiLmffo/sCOKFWdJtCgMi4pUohJhYMu0jM4zlmPYoEl9mKKrUWA9XLdqen00M2E4SNBk5qB4i7MKFhid2DA2/KCSC4Jd0ChxdGNZYBHH7IzoRMPjRqwlFjowjA9LwCIdQq+eMlft0tGnzM8FTPJTh+BX57VlpTB+G2L94C+3DQUP0UbO3p0jVUpSYco/pEqiFy2/aQAgzEkdL0tFl2haic9ME8f8nd28qoj6LDcBJdeg+vKW+Hr5uJTXWJwVb5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(86362001)(66946007)(66574015)(6666004)(83380400001)(44832011)(8936002)(66556008)(316002)(6512007)(6486002)(36756003)(2616005)(66476007)(6506007)(4326008)(478600001)(5660300002)(7416002)(2906002)(52116002)(16526019)(4744005)(8676002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0ZLTG8rSHJOWEZpVFd2c240WDhCa2JaaGFkV1ZpQjcwd1dVN3RQbHJzQ1Vw?=
 =?utf-8?B?Qnc4aUJVdWJiSFZoYlRUT3Iza1I4cWpGSEQ0ZEZadld1endyZUFtdkJFUGRE?=
 =?utf-8?B?UjRlNXBvQkQzdStxTzdVUVJscC94eWdHVDh4SXR3MXNYUjFOU0orUUdhcU44?=
 =?utf-8?B?MGFoTkpmZ3lyVTZ5bEpqUndrRGJMMEdUN0JLRUFkcnZJZmwvdytrSFd6c3Yz?=
 =?utf-8?B?QVhrWkFpcTlCeHdDc2gxUHVVQ2N1MjI4cHdWZTdNSmh2cDJrU0RNU0dQVHBK?=
 =?utf-8?B?Ump3WFVNTlR1N3VOYzhpQmE2SFpRU3lWUVhWNDBsVXk4bzY5Y1kvYkN6c1BH?=
 =?utf-8?B?Y3NpL0lrSVptZGt3V0JhVDdlOEV3N2Noc3RHVDRha2VSKzJsOUdtSmFraGQ3?=
 =?utf-8?B?dkpJK2hKMDIrUnNSVTZvRDgrYUFPcHVTeld3Sk9ocmtxc2U1QjdiTUFQaUx1?=
 =?utf-8?B?TlpQRjBQZmh0WW9GVC9wNnhEZmYwRzBMU3FSMk9nVHJnYnRZbkZEc25ZVS9i?=
 =?utf-8?B?eFN3Y2FoY0IwU2M0UUl3c0svbzJwT3NhekZ6Y0NMWnZQN0pPQ1pyMXJnQjRL?=
 =?utf-8?B?SE5ON0MxMitnMjc1YnRqZjZOMlpYdUdVcEpwTkthbkcwOXVBUnBWc0NzZUFH?=
 =?utf-8?B?cjRKb3R4bW0zL1hEdHM2cGp6THRmOUYyNDdPKzlZNFhmN3lJS1hNdzRYTXVi?=
 =?utf-8?B?dUNrOHg2TlRRakx5aytrOVFTdGRza1E5Mjd4N3ZlNjhOTHRXS0M3U0VkU09O?=
 =?utf-8?B?NnYwT1kza0lxbXk2Ni9Fd1RzTnFVL01iUTBkcDNyM3N6dGdERjNSYlpHRzRR?=
 =?utf-8?B?VEhVNk8weVFRek5tblpWZ2VTakIwWlpIYytNSkNTUG03M3I3K0tOMU5UYkR2?=
 =?utf-8?B?b3RNbkhWdTFPNTBsdlRzVVdMSGdubXB6dFRueEVJUE02WVNVQ0NsekltdCtU?=
 =?utf-8?B?Vk5WYS9PN2dmdlh3Rm9nMHZkWHlSTHROZnhEUjV1WVAvc2tkWVBXckNTV1Ji?=
 =?utf-8?B?N0o3Mmk4SnlJL1NGdVB2QVJjWHV5KzVrbjZhNnFrRmY2eVp4bHdrcjlxYk1K?=
 =?utf-8?B?Vm5IL0NjZ0ZSSWxISTFRczRBeGRKSGpnL0dsMjY3eUh6OVJXVks5U0JIYVE1?=
 =?utf-8?B?NkFrakozb3VyL2hCeDRZMEhEdk0zMWhQdTEzdVZuYm5MMnNiT0Nnd2RFNyta?=
 =?utf-8?B?dzFyVjJFdjZxTnY1LzlaS2cwZnVEZ2l0alp2Z0V1aXg4NEFsYlZVMy90Z2c0?=
 =?utf-8?B?MklxYUtna1ovbDk5bzNiN0FuM2g1S1FnSE11a2I3OXp0d29xeGdtaG1nUC9a?=
 =?utf-8?B?cUJtMVpnVEV2ajhMbkhUK0FKRDNkZHpETmkvQW14VlFURWdlMjE2RGlEMWJo?=
 =?utf-8?B?aGtFaW1PVkpyV2pzS2NVNTRMVGFhK2w0K092aTFDcGkxdlpkSTdKNE55RlF4?=
 =?utf-8?B?eGZEd3Npd1NROTdvY0R6MFU2SXNiUTIvV0ROSGx6cDYwN1kzemgzK2hreWp0?=
 =?utf-8?Q?2bEBHE3p/P13W2kD9ie3dQTaGMe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0535b1a-2401-4ac1-db6e-08d8bbf45c87
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 21:02:27.3965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLTK5EarHXw1Lct1o/bmZCpW+OTmkckEuJ9Qz/BKMjCJ0IIyfWcAiFvl1TTqdg7nnmAX/Cun/ll/g0Tf3XWQcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4767
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 Harry.Wentland@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VG8gYXZvaWQgYW55IHBvc3NpYmxlIHVzZSBhZnRlciBmcmVlLgoKU2lnbmVkLW9mZi1ieTogQW5k
cmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfbWFpbi5jIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKaW5kZXgg
OTk3YWExNS4uOTI2MzdiNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9z
Y2hlZF9tYWluLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMK
QEAgLTg5OSw2ICs4OTksOSBAQCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3Nj
aGVkdWxlciAqc2NoZWQpCiAJaWYgKHNjaGVkLT50aHJlYWQpCiAJCWt0aHJlYWRfc3RvcChzY2hl
ZC0+dGhyZWFkKTsKIAorCS8qIENvbmZpcm0gbm8gd29yayBsZWZ0IGJlaGluZCBhY2Nlc3Npbmcg
ZGV2aWNlIHN0cnVjdHVyZXMgKi8KKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnNjaGVkLT53
b3JrX3Rkcik7CisKIAlzY2hlZC0+cmVhZHkgPSBmYWxzZTsKIH0KIEVYUE9SVF9TWU1CT0woZHJt
X3NjaGVkX2ZpbmkpOwotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
