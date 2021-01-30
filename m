Return-Path: <SRS0=ZBQi=HB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ECCC433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 01:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CB164DD9
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Jan 2021 01:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CB164DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24CC6EC75;
	Sat, 30 Jan 2021 01:00:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E22D6EC75
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Jan 2021 01:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSjXfyDytWBTdGEb8lrbgbVLUwYhU0Dn5oOBmXcy0ZsScZv2YsYQ6NxyMJ+vHpthSzlIEdKfTHLr4A65YU/BnZgUAkcv/ZJJWuqxGsh6ZsKRfymoXRGJ0WmldONGSBmCLRW0oBk8gGTD7CaRrSqbgEhABcs+hENHNhDT5BgDhxUg5E2MOE4/o3xb3CgAuloCPUJT5YxB860iCcZJdrUSMjLzUm1OpaQE/4+YF/ituezlMIvCvEzeuiUK+rDTBqhW27NkEA9ir6jCYsUw5jIgZqHodmt33yzWusZjPI7Yr5CCIxvA/7ZyMTbfC7bfj5TtWIj3HWxEt406FPEPDD4fnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwq4tpLC7M+pkNAWVjnEZZlCpPiWxdCj9Mh7hrfk74E=;
 b=aOYnBpyq70yupbJLQR4UL4lVKQ+dQgNTCFgWqmj3WwA4L6CmDQnKOtdSIWHT6qY6pFosrtwxSCwby/QkdSgIFBEBD9h6XkJuC3Qx5Bof7QvKMEfgOEwkt6LIRzHCTbOgBCWRiRQx04tLyox4i9qmiqAooo64AUjZu3yxKfb4BoRkBnkxh49E5sJnUH5G5BWzVUa2zNWLywsPKDEz2n8RJ+Uxlo9F7xSnyB7yvjDjC6z3QcgR6uWDzChqg/M+oB4f9AnxETdJVjIopOlza6m1FHpKh0pRvBQJrGjXkPz7LG9vI/mFZng77UC6A3nIhs/LSoM1sHgaxBKrcAZ+sxEogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bwq4tpLC7M+pkNAWVjnEZZlCpPiWxdCj9Mh7hrfk74E=;
 b=HlYJd8inehHIXgzpQz/2Qg4Z5mCJYwNb+cIAcQFVFDRIkiPZFMDUrI1WnJVzIDh95qGWNWdalpmb0uKBW4hAPuD8nquf5DqdGGah+4xXMEqg7c9JpOA5NJ7D+DjeMrUxjjy2OUNI9vtOTIOoizhrIAfhaSqt7Vm+tMbGbFbRO+I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com (2603:10b6:4:5b::23)
 by DM6PR12MB2778.namprd12.prod.outlook.com (2603:10b6:5:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Sat, 30 Jan
 2021 01:00:22 +0000
Received: from DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::d9f0:2cfa:3be1:6453]) by DM5PR1201MB0057.namprd12.prod.outlook.com
 ([fe80::d9f0:2cfa:3be1:6453%12]) with mapi id 15.20.3784.019; Sat, 30 Jan
 2021 01:00:21 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix a false positive when pin non-VRAM memory
Date: Sat, 30 Jan 2021 09:00:02 +0800
Message-Id: <20210130010002.21222-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To DM5PR1201MB0057.namprd12.prod.outlook.com
 (2603:10b6:4:5b::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR04CA0060.apcprd04.prod.outlook.com (2603:1096:202:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 01:00:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04d16b4d-d499-47b8-6002-08d8c4ba6b28
X-MS-TrafficTypeDiagnostic: DM6PR12MB2778:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27784749DA21C37C8D3BAF8687B89@DM6PR12MB2778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVG0ac1z4xVUBsTGlVUzzwHVI5CCHirW86OSw/J9mcr2lCN5jbSdUJ+DbY7mSoTjdthX25NcAdCF8BdLelZbIYyP8Es9+iaxNnFTaup0SrHVNz6WflDzjyS1myJowdopV5htzKsTarB83KyLg4kDRW6ZtCMtMPTb3LOO9r3eWRMKjV8wWPP3oqbwWcn8d5H85+BNiIYf9CzWRCFbt23RIdkV21VD1mym9KNEa5vHoTuwjlXiK/u45hkbMNSMg1LspSZT5mF1fbFyEoSJ0DvDKsb0gN68nxOkZw4Nl5cBbxr5UmA/2LG/D4QW4P0289RwIe5v3WJbYrPBA12DrWHk+YRvPk7DsVRnMa2GjWNLu9xU7z+xWNKMgIROmfzHze9kKJvSKeitKSWWCvH8RlXmV8CPKAezTvcKQql/4qrvMpvSMVM6CY4ndVuYLXvn9DvvzHWEEsR/6rqvbOTiyFU0U8aDrjAiYD7izMee5Gl5DlSDwUejsplB2xT4oirL6k8tG2jFZxld2RayAxXvg/rIyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0057.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(4326008)(316002)(86362001)(5660300002)(83380400001)(8676002)(186003)(478600001)(54906003)(66574015)(26005)(6666004)(52116002)(2906002)(956004)(6916009)(8936002)(1076003)(7696005)(66556008)(4744005)(36756003)(6486002)(2616005)(66476007)(16526019)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVViRFBDZU1wcHFhMTUrVisvdHNyTUZLd01TRU5rcVdkc2F6T0RLUXdweGNv?=
 =?utf-8?B?Y2lSTGp3SDNWNm84TkxRYXdlSnY2VGd2L2hRdmdNOFVHMUtJNXhJNFNmTi9i?=
 =?utf-8?B?YVJyYktwQk5nNkxoYXhvajc1L1NKNFYxWW5uYm9ZNit2dDlzTUN0UUNuZkZw?=
 =?utf-8?B?WFA1YnJsbUoyY3BLMGM3YUJRcHRQTEUzOStJTFB4S3I0VUpJUjlMSHNadFZm?=
 =?utf-8?B?djIrQ0ZYU0kwSmNQcFdydkNuVExHK25rVGN5WllCMXBERkQ2QllCUktiR0dP?=
 =?utf-8?B?TGlOZjJlMW9aNGlNMHExRnhMaFRJWStDeHlydG4yZ3lEMkk5M1R2NGFhUTRF?=
 =?utf-8?B?VWliTDh4R284am1Rbkk4RE5QS1hXWWE3SklZM0ZjcDFGaXpsNEpvU3NqdnVv?=
 =?utf-8?B?K2VseDBVM0R0L3RNVm9pWHBIems5bEtPRmEyN0JXZFJmelZTZENYUmp4eDVo?=
 =?utf-8?B?MEpxK3gveXVVa3BoZnFXRHo4UW9ZTU9rOHhqSVkydG1ybjhSR1hyeHJDclk5?=
 =?utf-8?B?bXdrWUJDNUdNTmh3Vi9XK3VMVHNkaFo3cXBuR1FJS3FmVm1DT2NON1BNbHRz?=
 =?utf-8?B?Q21ZY3V4MVZwZkpid0JPK21NSVVFSG9zbFEwd3FWNTRpWUVhd3VuOE5RUTlw?=
 =?utf-8?B?NzFZWHJxVWc5bkY1VHBZL20xNVYrWmdvZEdmSi9oYnZ6S1k1MThMZ0RpN2Iw?=
 =?utf-8?B?TWRBdzdOVmVIOGVUcUNzQmd1UmxyUkRMRnk0RjNOcmxIMGhWV0RUN2Vqempw?=
 =?utf-8?B?T1U1aEhDOWtzancvU1c0UjVXNnVrWnlNYlRCcXozNWFlMzF4SGU4M1hxVzg5?=
 =?utf-8?B?dWRDVExqWFRzd2kvVWJnbStlWlZ4WFFBWmZZdVBzSEJNWTBpM0NSMjZUVGJZ?=
 =?utf-8?B?Sm4rc2U2Q0R3ekNieVYvRTlvZGxrNWRVWW5DNUgrUzZiV2ErWlZwV0VZdWdz?=
 =?utf-8?B?WVF6dUttMjFidEJLRkE0Q1hBNnVkRnZTWG1yNWprVVYwQVNtRXNxbUNGTmNH?=
 =?utf-8?B?NDA3ZTB2S0FHKzN3ZWI4ZzB6S1MxcmlHNXM2MWMwWGhKZEp4L1RWOU1mL0F4?=
 =?utf-8?B?SEJpTHo1ZXhpcWpsOFVGc2FHOGJQMnp6N0ZSeDhzMHFVVW50b1ZTbUh3Zkcr?=
 =?utf-8?B?OEk5VGZiaGQwTlNiaHpWZmpXNVpYb1FCSi9LdG5KQWIrOFhNY0N6NERnbERn?=
 =?utf-8?B?SU56ejFodFIvVGRZb0d5L3lGNyt1VTBFN0NwL3hRTGRSVEltb3BpNjBwT0JN?=
 =?utf-8?B?eVdMM1NUZ2pETkZqVVZNUTJHZFVQUWI0NVc1RUROcHRpeUFKRWVCRll3NXBi?=
 =?utf-8?B?NXhQSWQyRXN4Tlo2ZkU4K1M2OTMvNm13Tzlvblk1aFJMVHorWE41Rk4zY292?=
 =?utf-8?B?cEdzNDRZSXdvaXJVQ3RPY3ZNc05GMGVrTk41VS8xTDI5dXNyZ2FGa2ZmRVdD?=
 =?utf-8?B?eXZObFJCSDFLT0FLbzZsU1duTnJFbVI3bjJGRzJ3PT0=?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d16b4d-d499-47b8-6002-08d8c4ba6b28
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0057.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 01:00:21.8402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flIw+NnxC6iGb/x8hyQX6O7KihhpRVdkiUh7FATvDbf8fHophr8u8IZKb+tRzz97
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
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
Cc: alexander.deucher@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>,
 xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RmxhZyBUVE1fUExfRkxBR19DT05USUdVT1VTIGlzIG9ubHkgdmFsaWQgZm9yIFZSQU0gZG9tYWlu
LiBTbyBmaXggdGhlCmZhbHNlIHBvc2l0aXZlIGJ5IGNoZWNraW5nIG1lbW9yeSB0eXBlIHRvby4K
ClN1Z2dlc3RlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CkFj
a2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25l
ZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9vYmplY3QuYwppbmRleCAxMzdmMjc1ZjkwZWUuLjU2ODU0YTNlZTE5YyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwpAQCAtOTE5LDcgKzkx
OSw4IEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8s
IHUzMiBkb21haW4sCiAJCWlmICghKGRvbWFpbiAmIGFtZGdwdV9tZW1fdHlwZV90b19kb21haW4o
bWVtX3R5cGUpKSkKIAkJCXJldHVybiAtRUlOVkFMOwogCi0JCWlmICgoYm8tPmZsYWdzICYgQU1E
R1BVX0dFTV9DUkVBVEVfVlJBTV9DT05USUdVT1VTKSAmJgorCQlpZiAoKG1lbV90eXBlID09IFRU
TV9QTF9WUkFNKSAmJgorCQkgICAgKGJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1f
Q09OVElHVU9VUykgJiYKIAkJICAgICEobWVtX2ZsYWdzICYgVFRNX1BMX0ZMQUdfQ09OVElHVU9V
UykpCiAJCQlyZXR1cm4gLUVJTlZBTDsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
