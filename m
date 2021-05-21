Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC35C04FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED6E613EC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 21:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED6E613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984626F91F;
	Fri, 21 May 2021 21:19:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453866F91F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 21:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp7V/VqZoVwuxGxuDyhUQ+uYd4sGhhxfGi7A1BS8SeU3iT+rYpkGOK/6vQ4ztehVqBANyDCg4niugVPKB1lCGLIgBRqiMSs/Xg5LNOeJqtdCDJUi3wG0TsDssa63DaRO941ump0HZFF/X/n86O23d2DIAHc1/UWbHKdR0pOu0eT36opJtADL6ljZNilXUyDtokeirnwEj2R30Y9sLOsE/vYa82baXpBCXyaZdj0Kkbb8LBT7PBvvZiUqe5NUeJQEzgJbe6BD8vGcoTndx3lFOMFHx776oNdfglZgTwXSFaTJ6ss94kBFTplPdBYK2i3XdXwUtTZ7o/TVRG2/XHS1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/q/XL2rD/+CCuf13/Umn6SV26TtWYCgqHv3fosHbXM=;
 b=I7fk5NfZJgc4LF+lZ1lg1XOKej1Ui0P6sGt0ArrDhD5mI/7UYtOaIx9I4T/b6sM/NSgJ/5LcLtlpj737ys7aB0JlJKezzQf6BNwaIFUJe+bNXSyJ+kZlUjGmWEDg62EnGEEqR71YTTsmB30nstFTJETosuIE6OchRPBiiLnXXftA/y+KmDlqiPp8lQW7qzRB+kHGpXJUtE24tOh3DG+wYcPFUtZvVUu8r1LCNYnrvUOaxVE5dN6UVE0b/qq+m1x7GAWqwSpqbcq+uA/Rce+HErXiUt4JVlSA4cyyZkRaIp7recAINbrxWaWLwyGcwJV3mi62aLTG44LkodS3h4RX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/q/XL2rD/+CCuf13/Umn6SV26TtWYCgqHv3fosHbXM=;
 b=QeioAhpK43v+8uCRcH6pBVhTp6u63ank/exoJy+IiCbdTfjeVBPPEwr/iqcPZURAmgKtA/gfZyxJcCckNYwaEajyFuzyrnCc/JQ7hkQA/Hc3IkFQldgFPNxXBh7CxblWh2gFSImIoqVAN2+SelrBL4X3dxsHY63z9ursnKR4yAU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 21:18:58 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.026; Fri, 21 May 2021
 21:18:58 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error counters
Date: Fri, 21 May 2021 17:18:36 -0400
Message-Id: <20210521211836.4839-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210521211836.4839-1-luben.tuikov@amd.com>
References: <20210521211836.4839-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 21 May 2021 21:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a6c4a3b-8c5f-4963-5341-08d91c9e0b77
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01212B410D9A60D15630866799299@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOm4WbikIlVrT9uPIelKjeaV5yeqFyw5TZXulh4w6WegqXGTVD0B/W4v/+/YNEvzV8RLVExt3sHfQRWi8MG/MpDznZgzxgc4yaZIPoOLlwV7AfR5i0La+bifW3Wo98l5VAcBblcyXPLRu+M/nMS2tU7wcBZ8LuPpZUcJFjKRsfAuikKTNkM1eys66EMLp48eOWlm/wX1HffyRKTgyIUtJUBjADrbg4IT/ci7eLn6TqDta5q2KztHUVWGf5g5hFeTFH4MX4g7k6wu7PsRKK/b6SaiRhB5ta6Mlju7wc1yrbLoDR6qNkzE/Y7qoFTIVXASMdvcqXvlJ7QiA8Jl5eHTuNPTTiOe49ZD7+A89gqoiV4vmuucKZPuU/+NP6A5KQfwp/AA11fE1ZDIqOH0nSxlDmPut12xBuHaNyHjf93Jy68X7R1PZn6hATAIVRRznmZs3ruNftUerIoUqHlrBsqTTFDyvGpVoRM90tdDkBN2CoZn8wMNSQ6707RmZGPx/NNK9uQOj07XJG5LhP/QrpuC/nhDKfSdDaI1I2TkVCenkzneMz1AK09IZ/lIl8j/5AHCbGqfyba83u9VvNlYIRHwElMds+CWRC7RUHIxWcZUEocf/8nSFQRdMaily2I418XPT0qt4Ef0RoPv1pSOGk5uMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(66574015)(4326008)(186003)(6666004)(2616005)(1076003)(6916009)(16526019)(5660300002)(956004)(36756003)(44832011)(66946007)(66476007)(2906002)(86362001)(55236004)(66556008)(316002)(38100700002)(6506007)(8936002)(26005)(6486002)(54906003)(478600001)(38350700002)(83380400001)(8676002)(6512007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1F4bU9rQmJYOWF4Lyt2bFRweVlsdkZjUHkrdE9HYXRGSXZXMCtJQlArRW1i?=
 =?utf-8?B?bWY5T21ZM3hQc2duT2Y4UDEyNXR0RDRwbit2elBBY0JOWHpCcnpSamhzd2xH?=
 =?utf-8?B?dWRndms4cXZKQUxUcHdRVHY5dVFaNjhZcFpzRTJWbDZPSWVtTWR2eUtKZm9J?=
 =?utf-8?B?dU43M0FOaStmdGZBcTk4WWtHYnpHOVhXSlhkNjQ5ZC82WWNFTnpVWWp4aURC?=
 =?utf-8?B?cGM3RXRWU2V2MEJZc3NpRGcrQm1Lak1pbFRZM1pNZjBLV2VmUkxYcEtmWG1U?=
 =?utf-8?B?UGlodE1lVG4xck9pbGVMMk53ZjlWQUVwV2UwSXFiMFZwU29zbXJ4OXg4aGVG?=
 =?utf-8?B?a2NHS25hUVV0b2hHazVNUFhTakZhQ0NsUTBJbzlORHk0clVlUWZjdHVZOTNU?=
 =?utf-8?B?SDR6Y2o4ZmJ1V0g3WEx4bWplNlcxcG0xNG95aFRaRHpWd1NmbTZkbmFpNTJB?=
 =?utf-8?B?Rlp6emZwb2w0a3c1ZUtmeFpwSFoyTWR6U3o3UVlpVUE5OVZNTjVGZ011TFBS?=
 =?utf-8?B?ZTNVdU5IUFdNZXdXQTJjUzRITEkxWktnbGhPcW8rYmo0MTBuL2ZaRFpjMkx5?=
 =?utf-8?B?Ym1hMDc3NHpTUGVrdDJHNXV5ZEpXMWZCb0tyK3VFbEZWeFV4UmdxUUVjaktP?=
 =?utf-8?B?OUZxL0ZsSS9CTC9kbHhuWW9RdDRSRVVOM3U5M0g3eW15SldJZ1Z4OVdyd09P?=
 =?utf-8?B?STJodlNodTI5ek1naVVDZUlNeHJPb1p6ZmMzdDhUVTZRVUFoeDZkRXhwZko4?=
 =?utf-8?B?UHBVWkc0ZTMrVGRvdXN2UE8wNWZzd2hEUmhSRTRzOThrd2dvYm9Ga1NzKytB?=
 =?utf-8?B?OWFRa1Z4eXVoeFQ3TXdJblB2eDZ3M082aU1VMFFONVR6VmtSZDdHc3FrSnJx?=
 =?utf-8?B?dmdnUUtWZEFHOGl0bW1MQk96SWc3TE5hWTVsUWh2d2FpQTF6SkZXTFE2ZHlq?=
 =?utf-8?B?QWxqMHI1akx2azFaNDNyZkFPcXJyTjNyR2lMcjE2THNPdWxhUHhoVG5tc0hP?=
 =?utf-8?B?NXg0a3p4TmtvYml4ejFmbVM1UkZOVndMTFdKUjBHQ3NobEJEWXMvOVlKTnlX?=
 =?utf-8?B?cG4vWVR5bUlmWGZhL092OFpiY0lrK1hITS9aRnA2L25SNDQwd2dUMzFvVHR4?=
 =?utf-8?B?WjJLSndOZnc4dUFMZnVnWG9sN050b2ZlV2IzNkNFSTVGQlJKQWZTNTZ2eDhx?=
 =?utf-8?B?NTdLYUJWWGc5UGZvRGxDa1BlZEltUGt4ZkNTeHpVdnFsK042RW1XRWdjOHMr?=
 =?utf-8?B?WUlYWEFlT01WNDduWjA4NDVOcnBWSjhaTzFjSVd0SDB3cWdqK2dDcVE0dkRZ?=
 =?utf-8?B?c0s3di9qUEhtZ01OTjFpZ0VUNXRUbXZ6TGI5VllIWFU1TE1FRERVTkdTWGVp?=
 =?utf-8?B?cEdwSE9HSm5YWXBSQVQ0TFdIalR4YXg0OFQ1bmxqWmRqalhHOE1kQUQ0b2xL?=
 =?utf-8?B?SWpjSmwrT2pRR1JaM3RDVEVnbjcyZElPeEhqUGpxaDVJSlJqS2I4TW5pSXEz?=
 =?utf-8?B?Zi9mZFRYSTc4cEtVcDg3bXpSZFRLZHpHS1FOTG5laTd6SEE2OUU3K3g0Ym1v?=
 =?utf-8?B?cXNSQUJtU1dndm9GWVl3Kyt5MXVjeGJ1bGdtS2VDWGxsYk5Xcmk2NVp2d1do?=
 =?utf-8?B?TnhuQWpFYjZWWTlDdGlkT0lRdUFmTUh2VjIxNzNyMWF3eUc3NS9oSjJPU1Y3?=
 =?utf-8?B?V1lXY2pTenJXRnVmUDZiTG1Bd3M0eG1YSExaQmkzTzRaSG94aHNYYmdMbE4y?=
 =?utf-8?Q?UlbwUHfyhZ9QML4qnhxcSaURNhhSPOECpGk/32m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6c4a3b-8c5f-4963-5341-08d91c9e0b77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 21:18:57.3655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzexoLp5kMNCzhtz7DbjVpLxRS7R73BOX253AjQO91+AnaC5ORQRaYe88ywY+gaf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gQ29udGV4dCBRdWVyeTIgSU9DVEwgcmV0dXJuIHRoZSBjb3JyZWN0YWJsZSBhbmQKdW5jb3Jy
ZWN0YWJsZSBlcnJvcnMgaW4gTygxKSBmYXNoaW9uLCBmcm9tIGNhY2hlZAp2YWx1ZXMsIGFuZCBz
Y2hlZHVsZSBhIGRlbGF5ZWQgd29yayBmdW5jdGlvbiB0bwpjYWxjdWxhdGUgYW5kIGNhY2hlIHRo
ZW0gZm9yIHRoZSBuZXh0IHN1Y2ggSU9DVEwuCgpDYzogQWxleGFuZGVyIERldWNoZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+CkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+CkNj
OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEx1
YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgMzIgKysrKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCAzOCArKysrKysrKysrKysrKysrKysr
KysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmggfCAgNSArKysr
CiAzIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4IGJiMGNmZTg3MWFiYS4uNGU5
NWQyNTU5NjBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Y3R4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCkBAIC0z
MzEsMTAgKzMzMSwxMyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfcXVlcnkoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJcmV0dXJuIDA7CiB9CiAKKyNkZWZpbmUgQU1ER1BVX1JBU19DT1VO
VEVfREVMQVlfTVMgMzAwMAorCiBzdGF0aWMgaW50IGFtZGdwdV9jdHhfcXVlcnkyKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAotCXN0cnVjdCBhbWRncHVfZnByaXYgKmZwcml2LCB1aW50MzJf
dCBpZCwKLQl1bmlvbiBkcm1fYW1kZ3B1X2N0eF9vdXQgKm91dCkKKwkJCSAgICAgc3RydWN0IGFt
ZGdwdV9mcHJpdiAqZnByaXYsIHVpbnQzMl90IGlkLAorCQkJICAgICB1bmlvbiBkcm1fYW1kZ3B1
X2N0eF9vdXQgKm91dCkKIHsKKwlzdHJ1Y3QgYW1kZ3B1X3JhcyAqY29uID0gYW1kZ3B1X3Jhc19n
ZXRfY29udGV4dChhZGV2KTsKIAlzdHJ1Y3QgYW1kZ3B1X2N0eCAqY3R4OwogCXN0cnVjdCBhbWRn
cHVfY3R4X21nciAqbWdyOwogCkBAIC0zNjEsNiArMzY0LDMxIEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2N0eF9xdWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJaWYgKGF0b21pY19yZWFk
KCZjdHgtPmd1aWx0eSkpCiAJCW91dC0+c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJf
RkxBR1NfR1VJTFRZOwogCisJaWYgKGFkZXYtPnJhc19lbmFibGVkICYmIGNvbikgeworCQkvKiBS
ZXR1cm4gdGhlIGNhY2hlZCB2YWx1ZXMgaW4gTygxKSwKKwkJICogYW5kIHNjaGVkdWxlIGRlbGF5
ZWQgd29yayB0byBjYWNoZQorCQkgKiBuZXcgdmF1ZXMuCisJCSAqLworCQlpbnQgY2VfY291bnQs
IHVlX2NvdW50OworCisJCWNlX2NvdW50ID0gYXRvbWljX3JlYWQoJmNvbi0+cmFzX2NlX2NvdW50
KTsKKwkJdWVfY291bnQgPSBhdG9taWNfcmVhZCgmY29uLT5yYXNfdWVfY291bnQpOworCisJCWlm
IChjZV9jb3VudCAhPSBjdHgtPnJhc19jb3VudGVyX2NlKSB7CisJCQljdHgtPnJhc19jb3VudGVy
X2NlID0gY2VfY291bnQ7CisJCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlky
X0ZMQUdTX1JBU19DRTsKKwkJfQorCisJCWlmICh1ZV9jb3VudCAhPSBjdHgtPnJhc19jb3VudGVy
X3VlKSB7CisJCQljdHgtPnJhc19jb3VudGVyX3VlID0gdWVfY291bnQ7CisJCQlvdXQtPnN0YXRl
LmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKKwkJfQorCisJCWlmICgh
ZGVsYXllZF93b3JrX3BlbmRpbmcoJmNvbi0+cmFzX2NvdW50ZV9kZWxheV93b3JrKSkKKwkJCXNj
aGVkdWxlX2RlbGF5ZWRfd29yaygmY29uLT5yYXNfY291bnRlX2RlbGF5X3dvcmssCisJCQkJICBt
c2Vjc190b19qaWZmaWVzKEFNREdQVV9SQVNfQ09VTlRFX0RFTEFZX01TKSk7CisJfQorCiAJbXV0
ZXhfdW5sb2NrKCZtZ3ItPmxvY2spOwogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jCmluZGV4IGVkM2M0M2U4YjBiNS4uODBmNTc2MDk4MzE4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCkBAIC0yNyw2ICsyNyw3IEBACiAj
aW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgogI2luY2x1ZGUgPGxpbnV4L3JlYm9vdC5oPgogI2lu
Y2x1ZGUgPGxpbnV4L3N5c2NhbGxzLmg+CisjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgog
CiAjaW5jbHVkZSAiYW1kZ3B1LmgiCiAjaW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgpAQCAtMjExNiw2
ICsyMTE3LDMwIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9yYXNfY2hlY2tfc3VwcG9ydGVkKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhZGV2LT5yYXNfaHdfZW5hYmxlZCAmIGFtZGdwdV9y
YXNfbWFzazsKIH0KIAorc3RhdGljIHZvaWQgYW1kZ3B1X3Jhc19jb3VudGVfZHcoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQoreworCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBjb250YWluZXJf
b2Yod29yaywgc3RydWN0IGFtZGdwdV9yYXMsCisJCQkJCSAgICAgIHJhc19jb3VudGVfZGVsYXlf
d29yay53b3JrKTsKKwlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGNvbi0+YWRldjsKKwlz
dHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0gJmFkZXYtPmRkZXY7CisJdW5zaWduZWQgbG9uZyBjZV9j
b3VudCwgdWVfY291bnQ7CisJaW50IHJlczsKKworCXJlcyA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
ZGV2LT5kZXYpOworCWlmIChyZXMgPCAwKQorCQlnb3RvIE91dDsKKworCS8qIENhY2hlIG5ldyB2
YWx1ZXMuCisJICovCisJYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCAmY2VfY291
bnQsICZ1ZV9jb3VudCk7CisJYXRvbWljX3NldCgmY29uLT5yYXNfY2VfY291bnQsIGNlX2NvdW50
KTsKKwlhdG9taWNfc2V0KCZjb24tPnJhc191ZV9jb3VudCwgdWVfY291bnQpOworCisJcG1fcnVu
dGltZV9tYXJrX2xhc3RfYnVzeShkZXYtPmRldik7CitPdXQ6CisJcG1fcnVudGltZV9wdXRfYXV0
b3N1c3BlbmQoZGV2LT5kZXYpOworfQorCiBpbnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogewogCXN0cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFz
X2dldF9jb250ZXh0KGFkZXYpOwpAQCAtMjEzMCw2ICsyMTU1LDExIEBAIGludCBhbWRncHVfcmFz
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJaWYgKCFjb24pCiAJCXJldHVybiAt
RU5PTUVNOwogCisJY29uLT5hZGV2ID0gYWRldjsKKwlJTklUX0RFTEFZRURfV09SSygmY29uLT5y
YXNfY291bnRlX2RlbGF5X3dvcmssIGFtZGdwdV9yYXNfY291bnRlX2R3KTsKKwlhdG9taWNfc2V0
KCZjb24tPnJhc19jZV9jb3VudCwgMCk7CisJYXRvbWljX3NldCgmY29uLT5yYXNfdWVfY291bnQs
IDApOworCiAJY29uLT5vYmpzID0gKHN0cnVjdCByYXNfbWFuYWdlciAqKShjb24gKyAxKTsKIAog
CWFtZGdwdV9yYXNfc2V0X2NvbnRleHQoYWRldiwgY29uKTsKQEAgLTIyMzMsNiArMjI2Myw4IEBA
IGludCBhbWRncHVfcmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJ
CSBzdHJ1Y3QgcmFzX2ZzX2lmICpmc19pbmZvLAogCQkJIHN0cnVjdCByYXNfaWhfaWYgKmloX2lu
Zm8pCiB7CisJc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQo
YWRldik7CisJdW5zaWduZWQgbG9uZyB1ZV9jb3VudCwgY2VfY291bnQ7CiAJaW50IHI7CiAKIAkv
KiBkaXNhYmxlIFJBUyBmZWF0dXJlIHBlciBJUCBibG9jayBpZiBpdCBpcyBub3Qgc3VwcG9ydGVk
ICovCkBAIC0yMjczLDYgKzIzMDUsMTIgQEAgaW50IGFtZGdwdV9yYXNfbGF0ZV9pbml0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlmIChyKQogCQlnb3RvIHN5c2ZzOwogCisJLyogVGhv
c2UgYXJlIHRoZSBjYWNoZWQgdmFsdWVzIGF0IGluaXQuCisJICovCisJYW1kZ3B1X3Jhc19xdWVy
eV9lcnJvcl9jb3VudChhZGV2LCAmY2VfY291bnQsICZ1ZV9jb3VudCk7CisJYXRvbWljX3NldCgm
Y29uLT5yYXNfY2VfY291bnQsIGNlX2NvdW50KTsKKwlhdG9taWNfc2V0KCZjb24tPnJhc191ZV9j
b3VudCwgdWVfY291bnQpOworCiAJcmV0dXJuIDA7CiBjbGVhbnVwOgogCWFtZGdwdV9yYXNfc3lz
ZnNfcmVtb3ZlKGFkZXYsIHJhc19ibG9jayk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfcmFzLmgKaW5kZXggMTBmY2EwMzkzMTA2Li4yNTZjZWE1ZDM0ZjIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKQEAgLTM0MCw2ICszNDAsMTEgQEAgc3RydWN0IGFt
ZGdwdV9yYXMgewogCiAJLyogZGlzYWJsZSByYXMgZXJyb3IgY291bnQgaGFydmVzdCBpbiByZWNv
dmVyeSAqLwogCWJvb2wgZGlzYWJsZV9yYXNfZXJyX2NudF9oYXJ2ZXN0OworCisJLyogUkFTIGNv
dW50IGVycm9ycyBkZWxheWVkIHdvcmsgKi8KKwlzdHJ1Y3QgZGVsYXllZF93b3JrIHJhc19jb3Vu
dGVfZGVsYXlfd29yazsKKwlhdG9taWNfdCByYXNfdWVfY291bnQ7CisJYXRvbWljX3QgcmFzX2Nl
X2NvdW50OwogfTsKIAogc3RydWN0IHJhc19mc19kYXRhIHsKLS0gCjIuMzEuMS41MjcuZzJkNjc3
ZTViMTUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
