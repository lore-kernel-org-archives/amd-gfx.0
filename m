Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3879C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4323161248
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4323161248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 033676EB39;
	Wed, 26 May 2021 16:43:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F8A6E1A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 16:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZYybXRiF17NeTPTH+zDPjzPultSbCkZTWfDpNhUzxHgOONC5kBcJkoOKQ7rQGQBQas8YNKlf6NjeP0b+JeVg94Q9fet3AdjnT7bkhPkYRGQ7RyN1/nS4oBzXnvVd+MW7ThEwRZqDZ/tLtDziqzOWdfM+mfozxbHuqZWs0KRSM/WJGJbZkT0HA7F3ZHAfvYEA2g9DG1yGzXeOH88d4yKaLSIxB+duqO3kQh7zHYTZM/j3G7p5YjyVFDjB19tQztNd3hp1QXRDJo1bDvxdyLApulsqJTjLq43/+XszljMzu6KIGjtP8qN+osiLO+mM0kmhYm2L/TFwRWfWO9dbACFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYq2Esz0vf37i10TbZnnuX1JIJipYyS9YLuRo1m3C4=;
 b=LaSgHJ0tBo0k+dacDi5iMmZFRmfjZfD6+POXdp37kQeuOGklnsmL0fM/K36zTrvR64S6jYYuv0aMMsEFEntMhyT11Y7MqU3A8Z3nH8hxe04f94YVpxrBU0W4gp4hj26o+QgP6x9W6k2ijJkP65LEFeD/Wbo/1m7Q/pBKCUtFL48A5it7nspr1jjfsQcOVcMV6jB5CKC20Bnw//QL+7M/IO8WnFsqxduKtgLQYro1cQuGHd7H1GL2ioxDRtIU5FbIpZTrJmUUskzKlxIpuW7O4zTM/z3sq1kTSLIjmvc651fKF2r1gA8TooxGhW+KCFUHEnST7/OtZX4Ww9t0PBIreg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thYq2Esz0vf37i10TbZnnuX1JIJipYyS9YLuRo1m3C4=;
 b=YJebFYyI/uLQ35gG2UcgLNdqJVwJgte/h7Bf8nd3nKsMpVVBa9sm9hFkcP4j3c5cUqdy8iqbWKz4duZi0coOXONlRHCO81turfpa8TBnol95MfVHlz6lEsDgkXqt7M/BwoNajxf+0PA/4t+geNu85RUwjUQIF/l1TuGZHMXITEs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 16:43:31 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 16:43:31 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Don't query CE and UE errors
Date: Wed, 26 May 2021 12:43:14 -0400
Message-Id: <20210526164316.20547-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 16:43:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c91196ea-5fe2-4c81-c045-08d920656500
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4942218B0EA59CBF6685482499249@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+QcvKjfcpCjMQisHG4RvFEobybrX1vdn1iDsIuIUwjV0aAQzKVW5vFitGpUWylofHBS1X7rEEu736FxsItSd2Lzt+POMx5y4UqmNeoY3EfoacmhgSNa4DC3/KNfA3O9k+BuKRwAjZgt8OENRSgIM1/xJQ6ysCD/LAf9ea36aEhWCuTm3GNVjg0Y60+8unfNbiBAvdvtnPgGJidDr2a10CNky42t4Zy/d11JYRkl5ItCR7E5a1+GTehYSfFEnIt/2Q+eFHv55mzXVksxt8qRdspH8JehvzRp7eWO5DEUgHUOW7+4Lkq2cRwlWqiRYI+K5PNoQCmjxRYmZp+2UYxB/iYkRaDTYQi+/nnyiK1VwLsierS4OVJzC6LHtsxfYEUp8mIwZ6YuLPE1bbaPmbhkRRd8WDP2Z1jmYa2B3duu0r2zO/fDDJ+VoRbOSrCFpvUq0qJJvPF2PqZvT7U8n9jUQHOTxTARNKI27hMWTYt2fO3hwlZOC+aVC6aC1MW0VK2DBsO8jESQ6CVjNn1EPdQD8uEjyeRoW8Hlkm12zE/u9eExEPPKWyLcHE4NGCtfQSZc1+hNPYAaRb/TqZCX/H53rui7tjJJphs/xpr0Y/GU9TNrMIChfTevgX6TwKpbYub8XOxEkXqfepCFeIZynx9Pgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(55236004)(52116002)(6506007)(38100700002)(38350700002)(83380400001)(54906003)(86362001)(316002)(66574015)(8936002)(6512007)(6666004)(8676002)(4326008)(6916009)(478600001)(6486002)(2616005)(956004)(2906002)(44832011)(16526019)(186003)(26005)(66476007)(66556008)(66946007)(5660300002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGgxSW0wTUdYQ0E4YXVoaHU2aTE5aW9wcHBOMGx1eklUSHM3VTNlckxSMmli?=
 =?utf-8?B?UVFpVmNvR1ZvTDBYdSt6bnc1a3dLTTVCMDgxOENWaUJQUjVnYlNDcFJlTVRs?=
 =?utf-8?B?ZnAxcFE2dDV1aGpKaWxPZTRDKzVidlM5ajZaaGZHUVlUZzVHS3R6cU1QVFFZ?=
 =?utf-8?B?cFFDU1krN3h5c1J0OXhFRzBiRnNmQ2lmUFBwbE50MjlicDZFOTNvTmhSN01C?=
 =?utf-8?B?bU1RRUhjSFJHc1BOWUQvb2dwZ1gwTmdzbG9ZcVNzQ0FZbnk2TmRmTUZXbFlv?=
 =?utf-8?B?QlAzdjRzQTJ1MDUydmpGM25NZXVCbnMzM1g2OXIxWWZPRm1zWUxpcFJueHhx?=
 =?utf-8?B?VWZGWUFjVFJBRUtEUzZiT2RFL1hhb1lQVFo0cDQxOFVWbVNiL0l4bWFZdHhL?=
 =?utf-8?B?QzFvV2xIZldyRXFMRndFelhXU1pFMmJ6dWJWVnU1cHY4bWFtbnlSb1FVVWJj?=
 =?utf-8?B?TDdob0VYNklxdTI0dlJscWl6cW4wd21kRHRTYTFlNGlxTzgzRVRIWldJeXpR?=
 =?utf-8?B?SGZXN1RXN3hiN2hqSnZCT0FoSWZVN1FXcGJCdkhYdzRra1RiR1R5MkVRcDdY?=
 =?utf-8?B?azBUeDNEWU5ibXV6akJXaCt2RFVLM1JJN3I2OUlMSk1HQUZhbFFjSkNkWVZp?=
 =?utf-8?B?bU5SUDV3Vkx3cmgrN0dlanZYanp4ZEdpTlVLci9haFNsaTVad3N6dEhMRzZh?=
 =?utf-8?B?Qm1DZ052Q3dHK0p0ZWhyemdTbWdmcFUwc0ZVck1jSE5KeFNhMXNkM3JqWGl3?=
 =?utf-8?B?aDlTdTRIRVhrY3E0S1grVEZuN0JBdmN1RkxuVnBMUE5VNXlRQkxmN1dwc1FU?=
 =?utf-8?B?aTBrUlBXcnlvaEVxdGJTWDlkczduMDZXNW9zUkx2SHB1UlV1bmh1aUtaSUEv?=
 =?utf-8?B?UyswaE5qTjVjY2VaSUcyL3ZlZ3NnTlNhQmhrZGZFbFlmZFQ0Ukg5R0cvd1hz?=
 =?utf-8?B?UENPWlc2cGE3eWloM1hYZWx3anZ3dWtPNjZHa2VMRHVrZmJJbTNaejkyZllk?=
 =?utf-8?B?YjhCNHd5MzdyTDlUcUF1Ti96ZjZDVDBhRXpOYy9zYVM5bkpjamhXQk1SNWt6?=
 =?utf-8?B?cmJMTm1EZFgrWktPemRZSFRoSStZaFdYeXFweDdydkg0WEwzRDN6dmtmQjM3?=
 =?utf-8?B?N25GY1hybDJHN1ZmSTJOVDVhdHczT3FrM0NkRTNaMDIzemd1c3ZzTVl1ckJs?=
 =?utf-8?B?ZTdBZTFEQUM2SGtWSmlwZnZISEFMYXpzSXlENnBtMzM0MzB1VUxwYm9yV2ZH?=
 =?utf-8?B?RXRKRmdZU0t1bHNVdG93QjJ6Q0JoZkJiYWVkTlp0OElFK09YdVRvRExmUE9V?=
 =?utf-8?B?T05sRnRwKy9sT0grbno2M24rY0ZyVW5ORnd3SEFtVGVmY05SZkNCSDBKejhq?=
 =?utf-8?B?OHhBMHhSSFU0a1ZDd3MvbHB0U054dW5aRzAxLzI4V2ZSRytKYUJYMTRXbXJR?=
 =?utf-8?B?ejY5ekhlMmIzMzJnWFdjQjdGRkRjM1JEMWRLM2FDNWFhZGh2VHZkeXdQRlEw?=
 =?utf-8?B?QjFTRTFBd293bHNpRnlmcUtOZ2U1L3hHKzJsWHZRR3NuN0k3MVJaVTBxeGV6?=
 =?utf-8?B?em84a2Q3aitWd1ZXcVlReXFremFoZjV2cDUzaEZCQyswSVkzcThIdlowc0ZP?=
 =?utf-8?B?QjJpb25yQmRYc2VCdkZXelppaldpeFEwR3NVdW9VUUxWeHJOVlJlQm80c3hS?=
 =?utf-8?B?bHZqNnpiMXdmejUyN2JVSmE1bE95dmo2Q1FhNHhrdnNybXBSaGJpNm9mMmZr?=
 =?utf-8?Q?pb4jFD8hikZANv9AEvy60nOyol+ZoidRc954SFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91196ea-5fe2-4c81-c045-08d920656500
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 16:43:30.9628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucvnzGtLgypMTR+rzgzRLtFTN0AHSc+k1AR0eadeCB6FQwNmPDq8QwephT6GG280
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gUVVFUlkyIElPQ1RMIGRvbid0IHF1ZXJ5IGNvdW50cyBvZiBjb3JyZWN0YWJsZQphbmQgdW5j
b3JyZWN0YWJsZSBlcnJvcnMsIHNpbmNlIHdoZW4gUkFTIGlzCmVuYWJsZWQgYW5kIHN1cHBvcnRl
ZCBvbiBWZWdhMjAgc2VydmVyIGJvYXJkcywKdGhpcyB0YWtlcyBpbnN1cm1vdW50YWJseSBsb25n
IHRpbWUsIGluIE8obl4zKSwKd2hpY2ggc2xvd3MgdGhlIHN5c3RlbSBkb3duIHRvIHRoZSBwb2lu
dCBvZiBpdApiZWluZyB1bnVzYWJsZSB3aGVuIHdlIGhhdmUgR1VJIHVwLgoKRml4ZXM6IGFlMzYz
YTIxMmIxNCAoImRybS9hbWRncHU6IEFkZCBhIG5ldyBmbGFnIHRvIEFNREdQVV9DVFhfT1BfUVVF
UllfU1RBVEUyIikKQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlr
b3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleGFuZGVyIERldWNoZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2N0eC5jIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jdHguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYwppbmRl
eCBmYzgzNDQ1ZmJjNDAuLmJiMGNmZTg3MWFiYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwpAQCAtMzM3LDcgKzMzNyw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9x
dWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiB7CiAJc3RydWN0IGFtZGdwdV9jdHgg
KmN0eDsKIAlzdHJ1Y3QgYW1kZ3B1X2N0eF9tZ3IgKm1ncjsKLQl1bnNpZ25lZCBsb25nIHJhc19j
b3VudGVyOwogCiAJaWYgKCFmcHJpdikKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC0zNjIsMjEgKzM2
MSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2N0eF9xdWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiAJaWYgKGF0b21pY19yZWFkKCZjdHgtPmd1aWx0eSkpCiAJCW91dC0+c3RhdGUuZmxh
Z3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfR1VJTFRZOwogCi0JLypxdWVyeSB1ZSBjb3Vu
dCovCi0JcmFzX2NvdW50ZXIgPSBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KGFkZXYsIGZh
bHNlKTsKLQkvKnJhcyBjb3VudGVyIGlzIG1vbm90b25pYyBpbmNyZWFzaW5nKi8KLQlpZiAocmFz
X2NvdW50ZXIgIT0gY3R4LT5yYXNfY291bnRlcl91ZSkgewotCQlvdXQtPnN0YXRlLmZsYWdzIHw9
IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19VRTsKLQkJY3R4LT5yYXNfY291bnRlcl91ZSA9
IHJhc19jb3VudGVyOwotCX0KLQotCS8qcXVlcnkgY2UgY291bnQqLwotCXJhc19jb3VudGVyID0g
YW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCB0cnVlKTsKLQlpZiAocmFzX2NvdW50
ZXIgIT0gY3R4LT5yYXNfY291bnRlcl9jZSkgewotCQlvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQ
VV9DVFhfUVVFUlkyX0ZMQUdTX1JBU19DRTsKLQkJY3R4LT5yYXNfY291bnRlcl9jZSA9IHJhc19j
b3VudGVyOwotCX0KLQogCW11dGV4X3VubG9jaygmbWdyLT5sb2NrKTsKIAlyZXR1cm4gMDsKIH0K
LS0gCjIuMzEuMS41MjcuZzJkNjc3ZTViMTUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
