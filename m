Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD616C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9826A611C2
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9826A611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71E836EE90;
	Wed, 19 May 2021 20:38:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B5D6EE8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC6M2zWyYvFwY/uIGxxZ0jiDSucWUrBQSk1VcFLqk3IE6HvepQGB5qIGslwzDEGhtxaJKNvQipq+XgR1yOPdyASm1L3RUThptTnHCzepm+SNSirIZLWe08uI8cBs0AyuawjJtPRB9AIAC3nri2Hv2ozgmBWAlUUm/4yrwEo17yPLRuP3qrUDnQNCoKVP8Lon95AQqAVyxhEf1AYiYp44IXHunR40du2Qjy7DGNMkdKPb5B/nfe1lXfx1lUAAcV7G41cHJMaV2N1lykI088NcFLTrhUH+b7Fn5gt3LVzFez1AW+NiesM+Ojfvf49cYx3W/ZzCqn1YSgMmelgSDuqw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=634AnsUSCpi9ciIZ7+wbsx4BgBcX3xAlle5hRfF6rmc=;
 b=E4aGppzRrdmMCxta+tUm4YHvwYmaAAorCPgUA+//FfoNreNsL4r6FOML4DQCATlCC4gODmY7nERzQpJjK35YvfowskOKn6Xfv0NtkjTJSjJ1m1Rb4nj/793zQGSIXv6d53fycsQdivMqupQfgSTDxeQ6RhZj4Jb9uBSHgY6Rn3+Jf1u/kwif10H+kNoEdNvw/4Z/ziuTNUa6WzjuQI/7B66TFz81lQDifl1pzE4LssDKnFUrMVVYptMI7YcZVHA+LR0/SHeeWBMTFw2yz8D3l/wWwY0kly7yqa7tGFi8IcGjHngMTyzUBRF2qd+8s3SNhjxOKYdb2BpSu8QvPbQ9ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=634AnsUSCpi9ciIZ7+wbsx4BgBcX3xAlle5hRfF6rmc=;
 b=W+QZJerXubXfvVS/W6yVhQQKIvxx1BIn5KiEUF4EJ/r5pcl7/A3sxLlTysYOTiGetiYqC4zqQl9c/OL5qYxrpGX85JgGKr6FcDmCVModj5I0Wd2U76AuRGjXVQwxLuvPHdXsSxVoIXmb9zik5SDRPAzB0iMmgSsqrlk/+4ZO/1Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 20:38:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 20:38:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn3: remove unused variable.
Date: Wed, 19 May 2021 16:37:47 -0400
Message-Id: <20210519203747.2736827-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519203747.2736827-1-alexander.deucher@amd.com>
References: <20210519203747.2736827-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR06CA0029.namprd06.prod.outlook.com (2603:10b6:208:23d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend
 Transport; Wed, 19 May 2021 20:38:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e79c0ff-c471-4900-0ffc-08d91b060940
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48659C9FF5F306E73D2321B9F72B9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZ2+WTro3roHBJmb0VaAvMCq8DSB4enlRkp0siw5nj62KGLGEwJ0GS7jcfICjM9lBy6/mqsTTuCAiR2FBazQM6mTJQXjrF8gtUKHkxZyyk9udYggAdcbqcDPbZW3/KOt4A5kuJXBhAb/PNp/GE8SAgkrrqhPITjmZPnE072df7nFWj3n2Ansdn1l7bhqdF3RUDmSMqhXyxnN5g6X9nwH9WAYX9hulVc/gg/YHo9u/mjmCwTCEWlZ8C0NHhrVV3+Zbox0TcWxCifSvOQlomgOBcduK4QismVBvsdK7HVPe5m7qe1QSS3+Yk5aP1Kjcyp8UL4o2OJhRitygaxebS4oFN/e5Tb/sxgumQNNMF+zPGgQj95wg2q52qJLcrQBSpNUKb9LbbDIEZj/+JsFutBq1H2GOkvOa2Zb0B3YKH0YPPLB5SKmAp7Kv2kawBFGqSlaxp/vAJGYeZYI+mludPs2WE53oWLkKcopL5OFHa1g/Obl/btMB3ah/wkbOphocgSgTmPAD9m52sv0kaNoTHXLgD8kcT8QQvjjcQKY3wlo6PE8Ai7i69kAV2aBClhuMKdclHKZJcw0iSOwTIsE/oOLBNzJxIulrtc3kWLKn2PSosxbdDCsj4ioppzOFyDo9GHy/WiS2M+qH0LIBabKxb+lV0A6eXvMj/gyoc1u/NDzWqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(26005)(6486002)(7696005)(66946007)(6666004)(38100700002)(4326008)(956004)(1076003)(186003)(4744005)(66574015)(38350700002)(8676002)(6916009)(2906002)(83380400001)(5660300002)(66556008)(316002)(54906003)(8936002)(86362001)(2616005)(478600001)(66476007)(52116002)(36756003)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S1I1aVhzUjQ0QVEwaFVTbHZRZ3R5NTlqUlV1Y0NMM3pjTUtnNzFIMFpNb3Uw?=
 =?utf-8?B?SHhxbGhvK1JwN1ZsRVgrUjFUcDJMNGszODJINGhtKzZUS0ZXcml0YmJwUHlr?=
 =?utf-8?B?UjVPNjNyb2lTeHkwb25XZzVqcXdQdXZsOGgvNmJUSFZTOFNheTg5d1dDQStq?=
 =?utf-8?B?K0VLbGcrOTc5SGMxYy9NZFN3UFY1NEdqcDVhclRFY0pudlJxVW5NajZiM2E2?=
 =?utf-8?B?VVlRaDlnbTBRdkwwOW1ZdThQbnM4TW9uOGswbGFnVWwvR1BPSUFNaHcrUDhR?=
 =?utf-8?B?N0FaSmYvS2x0cXVRaytURlJsMGFabUVCNmRLbW0wVHd2MVNZMHFCZlF1Qk02?=
 =?utf-8?B?aGk4YXJMUTVrM09pQWtUbWhweXZmbkd5UjZ0cXBBUTFzTzJCcXcrZXhHQ09a?=
 =?utf-8?B?WmlJTDVldXpvOHVLN3phb0xaVzc2RkNpd20veXFkQmE3RFFscW5PektOSkcv?=
 =?utf-8?B?bGlzK0tBRmxSY1F2akhqU1FhdlBybUpHdkY0NjhCYlNFYTdURzhaVSsvcHJX?=
 =?utf-8?B?WXZ0K3hIanRvak53VUlpbUlOL3RpeUpRT2hSWVE0K2dpdTJJaU5CWWlOOUdU?=
 =?utf-8?B?Qm0vekdGZG9IY2xkMHlUQ0poZWZ4NmpnZTA5Tk9TaUhPYjEzSEdtaXBtQVUz?=
 =?utf-8?B?QWtSNjVNcVh4THk4LzVNRlpldjlQTlBpdnBxcVlpeUZPa04vNURUMUpNbjVB?=
 =?utf-8?B?c1dvR2xXTWFGTWp3a09QaVhSeHdBWmNTMmxJbENZVXI3NXVGK3lnYWpGSlVQ?=
 =?utf-8?B?UjloOFlTaUZkaWxtUHZ5QlUrODg4a3p1cXBPUENNWmJpNW5IWFVwUHhHcXZu?=
 =?utf-8?B?UTZ1akQ2cWp5aFdMcGpJeWUvYk5Gb1g0aERpdVlZTFJ0S1N0bHpENnRmS0E3?=
 =?utf-8?B?d0FnZ2JFNDkveFc1QnBXY0xaL0g3OEdNSlRmU1Bmc0NGUTRNVEo2bzBJVDZp?=
 =?utf-8?B?NTlndlM5ZTljanlMK1cxR0p6QU9JTEZKeFdDSnU1Y2dUVGR3Wk5PVm9NNitJ?=
 =?utf-8?B?dnpsaWg1R0xQelN6bWowaCtyNGlnRXRtYkpZbkZ4UkpaOHpRWTJYVjNqQWRx?=
 =?utf-8?B?cWpIRFVaSjQvaWdrQlRUMTZjb1paS2lDRjc2SFRBd1gzSm1YeDdpNGFJQlF6?=
 =?utf-8?B?MWxrdUxxK3NYSXlpZ3g0NG5ld0hLTkIwT2svOUhVeHlobHhjNm5kcUtHK2NL?=
 =?utf-8?B?WUFqMysza0QvQlpaUXcrZEZkbUVPT0FYYUhiYi9BUjQ3cldIcDdodWNuQ0xM?=
 =?utf-8?B?K0oybXdkS1FwNFg2YTVmaC9uNGRGbFltN3JUUGVYOHBrOVhER3cxb3FIUkxu?=
 =?utf-8?B?WEEvUWREWElIcWdTdGU2N3lGVFhTdnRRL3ZpYXU4Z09qOXA1NGdnTFJRaVVh?=
 =?utf-8?B?RW5hbGxtZVAzNjBYNEE5Zk1jZlpXeU1jcVpudy9iVG5xQjB4RnpOempvR1N0?=
 =?utf-8?B?dk9xdjAzR0xOVFdsUXIrZitEV24rTEkyeUFmWGRiSFE0Q213VlFlYkRQMUlN?=
 =?utf-8?B?dU84bWtaYTFOY2ZLcHBBR0VTUHFKc2w2RGNtZUsyQnJNYUNnU2U0MElpZXAy?=
 =?utf-8?B?WVUraTdnMmkrcE9BRjZia25vSGFIdWxybkp2Um5qYlB2MGNUb21TbzN1VUsv?=
 =?utf-8?B?MTI5OFVFVXQwd1pZREJTNGxCejNOaHFpSHhsK081SnlBbHFlZDZIUWJKb2FD?=
 =?utf-8?B?ZW9STi91ekVQUXFrZG9YbW94STgyVXN2UUhxd3lIa1VMbE8wRENKVllVOGlB?=
 =?utf-8?Q?oH6n8FFUaHyp5fGNZZBOPh+xyhSBW5pMvtjndGw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e79c0ff-c471-4900-0ffc-08d91b060940
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:38:19.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zchS1Ts2XEpl9xf/ZiMWeAbnA7vmL+QXlARcPHZB51I61DVc7rVzYsoiWT0k8akU0g5SgAK+h3Lm01xwW+eIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tm90IHVzZWQgc28gcmVtb3ZlIGl0LgoKRml4ZXM6IGE4Y2NiNTQyNTM5ZmYxICgiZHJtL2FtZGdw
dTogc3RvcCB0b3VjaGluZyBzY2hlZC5yZWFkeSBpbiB0aGUgYmFja2VuZCIpClNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y25fdjNfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3YzXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMKaW5k
ZXggMmQ2N2NhYmE5MjkzLi45NDYzMzVkMGYxOWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
dmNuX3YzXzAuYwpAQCAtMzgxLDcgKzM4MSw3IEBAIHN0YXRpYyBpbnQgdmNuX3YzXzBfaHdfZmlu
aSh2b2lkICpoYW5kbGUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAJc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nOwotCWlu
dCBpLCBqOworCWludCBpOwogCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fdmNuX2lu
c3Q7ICsraSkgewogCQlpZiAoYWRldi0+dmNuLmhhcnZlc3RfY29uZmlnICYgKDEgPDwgaSkpCi0t
IAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
