Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D4EC48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5460240
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5460240
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CFAF6E5BF;
	Tue, 22 Jun 2021 16:24:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65F26E2D5;
 Tue, 22 Jun 2021 16:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzIuBSXLYkqKXyFcs+KekZ7oMkMfA2K1PnDyzj0FtMgoknGzoEvACzQQbNz1w0u7rOw+rsUCxtJywNmirDU4vPY19oM6C1QhTX0biZ1cC6vWsOhzkVyL1zydYs7NEeVt2n/5IQ3O95rtsioZuWJ0wllObPcFkd+134eUBO0zl2NQzLXY+SXx1wKIuI1LdsQ/CVISepz9duBWoe8zk+jtDARp6G+1RvbU6LHrfQdbFQTmpkDC1sZKGmbtFv0eADQ/1nBtheah2F//fTtkcrRI5h5CLLruxxKTAVcN7G/9YQS/12H+rcbV+NSp9YkmaPgRVOe5GZi2zc+fmib4UNeDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIlbrlBQPhwCCtEJn+woubiFNTaH47GxA/pBqNMl0l8=;
 b=dm1UEVOcTvsteDvnC35SQ3yte3mkkvs3nPqZCgwHjWMUrJfEtwSn8wAQXL4gPxe2S33ib/y/LJVqtTxICQZdGo9jQA1C2J3JQb9kV1vP0JwoHiUnsf8m8yba09xtzMSQl1dHxdhmre8FyB5CnyYTYcAteqmZhTRT+AF7JfWENvbkef9zmfRP4EBLkvGV6JyrTqYd0E0HTx2s7tnRIaFXAG/uqJ0mTmsxamI6YOK9fd4fcCxnspT0/o68qcmX3A1RFyD4Y/idJ5MIKmGwRkSwfeqKcBZoxy/xgX7lGKraNBDJc+MgYYLGz+uPnKWKHT/JFu/mIPkarZ5AnjuSBkBtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIlbrlBQPhwCCtEJn+woubiFNTaH47GxA/pBqNMl0l8=;
 b=5Rw7pl8O4ecEHM9R5e63aJYlhjaJ+Bx6+FMInjyN8w3BLxmSIjYkRZHDiAEcoIWABFCcmf29EXyRCM2LE6gSDEjqe5hEGXTgbvnl6YKK9ZNgb6mKlzrrdICPHdpGbtS9sPFPDtBxRzHh/PzD65ZWopbMeEBcmMkw0ytjRWao8g4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 16:24:10 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 16:24:10 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu: user temporary GTT as bounce buffer
Date: Tue, 22 Jun 2021 12:23:35 -0400
Message-Id: <20210622162339.761651-2-andrey.grodzovsky@amd.com>
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
 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 16:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e8f2a5-0b89-44f6-3f23-08d9359a2a32
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44622C7C805A9BC4EE859256EA099@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l95BeDMYyx22SoNxA9JHF5gWTpbJixZccbDJzLJQVQBUxiR5MyBj1Sj5QG+iwu5lH6iUaLN1bvKACxTvo+gFPJtolYgH+b7ZUG9sYHY0AO3774O60NmindHwNSMJxVdU0i6U/AwY4yUgfO5pi4QdfsKgZUBseZpElFSyA+YzgTDweq6/U3YYT0vIj4+MQsmfP43UwB8Ngpqz35CB2FFMJIJzHcHOQjAp22ZhCmWmpuultJLFCsWZTsud8GbLI8ApaA6uB6TkE+MvYVvk+Qxsf7E8dPtrtpvgJhRTklwdlNkxwAa6QcHKnvrAO0XXPM4nGQ3SZZ78bqmzvvoA2KXWirtJcfwNgVYOOR4zMeDljZi0MCHWSHNgyN/Ss/5J7DLhCoJj+xvsViH6/4ewYIdCe7j+lYxqG5oSk2rqjUzCIsVgEZ0CqbGGUiRQ8UEDfWyOeJj2Ixj2KNqGbntAbmzVEjqTx+vLx881uS6zczc8AOq398p+JwNfJz1y64fkIx2ZQrax/eFOq28P2inyTFztSwT/Dc9OcXip0qe01jTnNQZoW/zLoYEa73VZLl7fHIH+wNxBJOkOeLnRpFEO8ewK9PEKF0tyFE8u58CuKnXKmEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(6486002)(498600001)(5660300002)(1076003)(52116002)(16526019)(8676002)(83380400001)(6666004)(36756003)(44832011)(38100700002)(66574015)(6506007)(4326008)(6512007)(66946007)(8936002)(86362001)(2616005)(66556008)(186003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UktPMFVHUjYwTjFadk9sc21iMGZnVThuM3VTOWh5TXVqOGdmakZ2cGJvdWl3?=
 =?utf-8?B?SldrSmxXN2VaZjRCamJZMTlneTBhV3EweTNNZkJaYzd6bGNVNVVGc1JpV2VX?=
 =?utf-8?B?emc1WElOemRDbzViRmNQQUx3cHAxTnJ2K2VISE8zVXJKb1JGSXRmd2FHTTlp?=
 =?utf-8?B?NnE0dGZYaFRoL3IyMDV6dzNid2VKdVBpanhLTzdjRk1oSFZuVGpzTzVFa0ha?=
 =?utf-8?B?azFJSEIrcDV4MENVUk0rcjVRK1R6UTRFUW5QU0lKbElIRWZUNENHMy9sWTVm?=
 =?utf-8?B?WWF3cm53dEVqR0RJVEVPS0RpaEx2Q2hmY1B5RCt5RUovRER2NnNJbHRBTHBO?=
 =?utf-8?B?ZUxjaDNlTHUwUmpIUmJ5U3pYNTNTWHh5N29rdUdXK3YxclJzOGlIc2VXSXJk?=
 =?utf-8?B?azExZTk0Z3BqbXNMaGNydk03VkhMeXI2YnZTT2VUcHVLMzl6dXlCN1YwbmZG?=
 =?utf-8?B?U21zWDg4ZndvSnJMTndyNUdGNmZVRk1nQUNaSzFlQnBSNU83V1hzcDg5bktH?=
 =?utf-8?B?TVk4SFVmaFF0U2JwdWYzNGNYNUFnTCtsc05yaCt2SHRrYnpyR3VBME54M01L?=
 =?utf-8?B?SUczUWxIZGZ5L2NHT3VNUjJGL3B2b0FBU3QrVjVzbU1EOU5tYWxaT2s0Mjh6?=
 =?utf-8?B?eE5WcmNSdm1NR245d2thcCtlK0d1ODVQZ2hPeU9KNFc4Z1BReVFBOEFVVGpu?=
 =?utf-8?B?ZUdjcndtZzViRk5uV0FzU2pzbCs0dnVINTBXL0NkVW9XdVo4NWl6VnlvR3J5?=
 =?utf-8?B?RmpTVmRMQWR0L2UvWUxlaGgvdC9KbFEyT2ZDMkViaExwbUY2aUdDMkRXMDE5?=
 =?utf-8?B?WXduR080TkorZnpIMENFQ3I0QUFaYm5KWm9najlPai9OTGFvMmtVemlqaW04?=
 =?utf-8?B?eDJPNkVhUHFCdHdHNDdFOGlJVE8zZTA3Q0NmSUNjeW9ETjNFYXc3dFBTWS9X?=
 =?utf-8?B?SHhnb0JucFZzVEV0Snlwc2hEN0RHV2JSSi9Fa0tucFhlQWMxYzR0NkNZcWRP?=
 =?utf-8?B?ZjloZmVyaS84S3U0T1VsWW9wajRydm80Rk8zMm9qYy9YSlJPb2lEL1lCQnZx?=
 =?utf-8?B?eE5RRHdEeFNrWURVZmN3Rm5selc3MHRwTERTdk9oMktXeXR4SlRPcUpsQlN5?=
 =?utf-8?B?dkdGcDZKSlFlV2M4dlZlSXU3TjZoVVZsa2FORnZmL2tQckVDUkM2WXNjYzZk?=
 =?utf-8?B?UWR3TlhlazhYR0pQOGFDYlc2ZXVEUTN2NmtGZks0eFFhNHo5NThEcUZIMGI4?=
 =?utf-8?B?R3NYNk1waGxtZnFsY0dnQk9RYlpSdERTOWp5QzlPbXJzSVU5eGtkZEV1VndP?=
 =?utf-8?B?SU9oTmVwYmJqK1lQMHZkT3NBVDhwd05kaWxDbUVZNVFIby81ekRZYzd0UEtz?=
 =?utf-8?B?Qnc0OTY4QU5DYW1IaWp3cll5NER6OFZEZ1BVcjhFaUtwY05NVEhTRCszRGRH?=
 =?utf-8?B?QlpyMkVpcTBDNFUySGF6MzBJWVlFWUsrbC9JU2U1SUZxeEVyMnF3czNrWUJB?=
 =?utf-8?B?QmF1WUw5SUtsNS9ZdmVLaG92YlFPQUxBN2pQQnUvWjdKSE1xNE1sancxdlQx?=
 =?utf-8?B?V1hDdVlBUUYrK0p0RlAyNE5ObDBpUE1MNmJrdW9WbVFTRGRMMlBJMzdkdUdU?=
 =?utf-8?B?UVhJY2VoMDJ1OGR5UmJkYnhwL3U1SUJlZllNQ3JGWnZiamxXaTRIQTRCSll6?=
 =?utf-8?B?R0RYZHNJWGl5TDFldERpYURYTGZMdzBYVlU3R1cyQ21QWVIvR0MzcDlxamIy?=
 =?utf-8?B?SktWaWkvSzFjaG9ZZWJOb3B0dzYvL3dualFxLzBMSW00RUJoejZkQVlIRlJ6?=
 =?utf-8?B?dzFLbUJQNGJtNTcxUUwrWjcyRmh0MkJWYlE1eDVUQmZ6ektkaEt4Vmg3b3dF?=
 =?utf-8?Q?1eZR9VQIE9rnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e8f2a5-0b89-44f6-3f23-08d9359a2a32
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 16:24:10.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7iYFtoLMx5y/Uszr7KWBpzPZORTf7C8q9pX+1avJFSGbOiEkVfMEZqkL5uUiRP1NyS5Pd5W7RleqZVVF9ZLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

RnJvbTogTGFuZyBZdSA8TGFuZy5ZdUBhbWQuY29tPgoKQ3VycmVudGx5LCB3ZSBoYXZlIGEgbGlt
aXR0ZWQgR1RUIG1lbW9yeSBzaXplIGFuZCBuZWVkIGEgYm91bmNlIGJ1ZmZlcgp3aGVuIGRvaW5n
IGJ1ZmZlciBtaWdyYXRpb24gYmV0d2VlbiBWUkFNIGFuZCBTWVNURU0gZG9tYWluLgoKVGhlIHBy
b2JsZW0gaXMgdW5kZXIgR1RUIG1lbW9yeSBwcmVzc3VyZSB3ZSBjYW4ndCBkbyBidWZmZXIgbWln
cmF0aW9uCmJldHdlZW4gVlJBTSBhbmQgU1lTVEVNIGRvbWFpbi4gQnV0IGluIHNvbWUgY2FzZXMg
d2UgcmVhbGx5IG5lZWQgdGhhdC4KRWVzcGVjaWFsbHkgd2hlbiB2YWxpZGF0aW5nIGEgVlJBTSBi
YWNraW5nIHN0b3JlIEJPIHdoaWNoIHJlc2lkZXMgaW4KU1lTVEVNIGRvbWFpbi4KCnYyOiBzdGls
bCBhY2NvdW50IHRlbXBvcmFyeSBHVFQgYWxsb2NhdGlvbnMKdjMgKGNoayk6IHJldmVydCB0byB0
aGUgc2ltcGxlciBjaGFuZ2UgZm9yIG5vdwoKU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8TGFuZy5Z
dUBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9t
Z3IuYyB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMgICAgIHwgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ3R0X21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2d0dF9tZ3IuYwppbmRleCBlYzk2ZTBiMjZiMTEuLmI2OTRkYzk2YjMzNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ3R0X21nci5jCkBAIC0xMzIsMTQgKzEzMiwxNSBA
QCBzdGF0aWMgaW50IGFtZGdwdV9ndHRfbWdyX25ldyhzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFn
ZXIgKm1hbiwKIAlzdHJ1Y3QgYW1kZ3B1X2d0dF9ub2RlICpub2RlOwogCWludCByOwogCi0Jc3Bp
bl9sb2NrKCZtZ3ItPmxvY2spOwotCWlmICh0Ym8tPnJlc291cmNlICYmIHRiby0+cmVzb3VyY2Ut
Pm1lbV90eXBlICE9IFRUTV9QTF9UVCAmJgotCSAgICBhdG9taWM2NF9yZWFkKCZtZ3ItPmF2YWls
YWJsZSkgPCBudW1fcGFnZXMpIHsKKwlpZiAoIShwbGFjZS0+ZmxhZ3MgJiBUVE1fUExfRkxBR19U
RU1QT1JBUlkpKSB7CisJCXNwaW5fbG9jaygmbWdyLT5sb2NrKTsKKwkJaWYgKGF0b21pYzY0X3Jl
YWQoJm1nci0+YXZhaWxhYmxlKSA8IG51bV9wYWdlcykgeworCQkJc3Bpbl91bmxvY2soJm1nci0+
bG9jayk7CisJCQlyZXR1cm4gLUVOT1NQQzsKKwkJfQorCQlhdG9taWM2NF9zdWIobnVtX3BhZ2Vz
LCAmbWdyLT5hdmFpbGFibGUpOwogCQlzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKLQkJcmV0dXJu
IC1FTk9TUEM7CiAJfQotCWF0b21pYzY0X3N1YihudW1fcGFnZXMsICZtZ3ItPmF2YWlsYWJsZSk7
Ci0Jc3Bpbl91bmxvY2soJm1nci0+bG9jayk7CiAKIAlub2RlID0ga3phbGxvYyhzdHJ1Y3Rfc2l6
ZShub2RlLCBiYXNlLm1tX25vZGVzLCAxKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFub2RlKSB7CkBA
IC0xNzUsNyArMTc2LDggQEAgc3RhdGljIGludCBhbWRncHVfZ3R0X21ncl9uZXcoc3RydWN0IHR0
bV9yZXNvdXJjZV9tYW5hZ2VyICptYW4sCiAJa2ZyZWUobm9kZSk7CiAKIGVycl9vdXQ6Ci0JYXRv
bWljNjRfYWRkKG51bV9wYWdlcywgJm1nci0+YXZhaWxhYmxlKTsKKwlpZiAoIShwbGFjZS0+Zmxh
Z3MgJiBUVE1fUExfRkxBR19URU1QT1JBUlkpKQorCQlhdG9taWM2NF9hZGQobnVtX3BhZ2VzLCAm
bWdyLT5hdmFpbGFibGUpOwogCiAJcmV0dXJuIHI7CiB9CkBAIC0xOTgsNyArMjAwLDkgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X2d0dF9tZ3JfZGVsKHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAq
bWFuLAogCWlmIChkcm1fbW1fbm9kZV9hbGxvY2F0ZWQoJm5vZGUtPmJhc2UubW1fbm9kZXNbMF0p
KQogCQlkcm1fbW1fcmVtb3ZlX25vZGUoJm5vZGUtPmJhc2UubW1fbm9kZXNbMF0pOwogCXNwaW5f
dW5sb2NrKCZtZ3ItPmxvY2spOwotCWF0b21pYzY0X2FkZChyZXMtPm51bV9wYWdlcywgJm1nci0+
YXZhaWxhYmxlKTsKKwkKKwlpZiAoIShyZXMtPnBsYWNlbWVudCAmIFRUTV9QTF9GTEFHX1RFTVBP
UkFSWSkpCisJCWF0b21pYzY0X2FkZChyZXMtPm51bV9wYWdlcywgJm1nci0+YXZhaWxhYmxlKTsK
IAogCWtmcmVlKG5vZGUpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5j
CmluZGV4IDgwZGZmMjlmMmJjNy4uNzlmODc1NzkyYjMwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jCkBAIC01MjEsNyArNTIxLDcgQEAgc3RhdGljIGludCBhbWRncHVf
Ym9fbW92ZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBib29sIGV2aWN0LAogCQkJaG9w
LT5mcGZuID0gMDsKIAkJCWhvcC0+bHBmbiA9IDA7CiAJCQlob3AtPm1lbV90eXBlID0gVFRNX1BM
X1RUOwotCQkJaG9wLT5mbGFncyA9IDA7CisJCQlob3AtPmZsYWdzID0gVFRNX1BMX0ZMQUdfVEVN
UE9SQVJZOwogCQkJcmV0dXJuIC1FTVVMVElIT1A7CiAJCX0KIAotLSAKMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
