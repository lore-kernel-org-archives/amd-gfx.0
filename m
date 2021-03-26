Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE49C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 16:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC7261A18
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 16:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC7261A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC08B6F400;
	Fri, 26 Mar 2021 16:35:56 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9667A6F400
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 16:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1cUFY5peimk9Mvhm3I9EhdrRwc5GMJw0VtLzk91uMZxtRokdXa9rYwg0cFSbdsT7h1wBa5vT8q9CTXwtodvokEUrHmo0+kbzSKck+jpI6jStLvOOPDFBRfyF/Jt6AjsZ6L8D4eOACRTQbEE1WEmuNaExu+rwGGxlrubrmTM7sEoo1ueaLmFsx7R/OozG7PtbcR1zR8HGIyUaKZfptviT/fKFtS5gySbK6smAulwdGIlyI6OKdTmwzwKwkgMAYXRIHznIcKlZKDgGlkRc5rqWY/x8z1aoCB5WgL4t7XDpwfJz6fdVu33DvfwLYLDHtrQwvhxJf1I4iBF2gEFER9Ceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqrORpp4t5HhzRTa52wtZDwZLYzrQG5kh5D068hlgZ8=;
 b=T3e4YqFQTLUX4g56DXS/52SyvBJ3YevfP/krv6VD3ld687DNDj02RWR6bYZ3UkRMVKQXJmageA6K9etpzR+oFIOohzsmWbhs1qui6YadhAIk90gfzn0qeLyQBKv5I+HT5E0Axic2P/xikZrJXClY997mZCXeKzQTbAkw5kWWem8RGNFi1l3k10R6GMHWDANLLFsDXnIV1lhPB+pKjWdbtdBBRoBBYJ2DAe88M0TWc0UKIB9HOJrDL6093affTGaYqe4rf4XjDHXZD7R4s4AV/Vo/5RtvfcksH7fQ4hw3WOeVEtyppRLM1G9gsw5eHwT3lqRdtA3RpUpBF4f89xCIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqrORpp4t5HhzRTa52wtZDwZLYzrQG5kh5D068hlgZ8=;
 b=iGFrFzb6AYJv5qthWey1UshpsdUoCBI6RrOWVow2ZXouNzZcSLRAR6aIski+8FFO/XrS/FZcNYlwitVJGzpLSRzFw1x5JARexEwAVlMcVJwG7ps43avJBG/lTvYkRs3Szcfo1l3z0LlzXRJClrdGDeQIzPB7fArjAdbz/JH2Xy4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0199.namprd12.prod.outlook.com (2603:10b6:910:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 16:35:53 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 16:35:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: fix offset calculation in
 amdgpu_vm_bo_clear_mappings()
Date: Fri, 26 Mar 2021 17:35:40 +0100
Message-Id: <20210326163540.10221-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:405:75::48) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30 via Frontend Transport; Fri, 26 Mar 2021 16:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8a287a7-d4c3-49e8-82d2-08d8f075390f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01990B2289E981983386DD908B619@CY4PR1201MB0199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdxkYhRM1mcdES7yDJgd9TiEA1ZK1ErWHmdEENRSbqnxyZTSAMXYQdpXEdzH2xY4z6p9kkM+POE3Zr7yA3+Oe5KtuufEG9J1EhsfYcdxGOrRM4rOUCIoL7hA5snaGGuCcpFoAQPSJ/iUJJEGInfhak1x41lrxG/6V3z/A7q0xAsco2xgHw33yaTCe/dtRAy3vM0mjf3779ynE8MlralWVanTQ2iUioA9XCoWzfTaSR1A4xumdq5Moz/WjAf3G8/GOnkiifUUT3sOoUAPcsKAHz9q5hodIudp8kt+Ioqa0jHYlcGT3l2eJA3UlsqKkq2TbHk2KZVXDullUNe1Wmvc6xN714fDRCBJqZiiliwtDBM8qnWzXvRRug2T0mvkGZwAYnJOtmpArBOhVvkM92c/6l+CCudUyslkr3pBNAcfGSNeeU+yKwulI5U7rnouU/Wm3fsc81iv5LyeSWhXSJ/f0ChNJpBavLSwk32ho0olYxR3T3KVKUAMIiiK1Pf35lGlR340uwmnURRLFIROeYiQd6w3jC/u8tMyCc/8j2wuhWftQqpsS+JobUZ04Vz2u1z85AtWB8IMSdCdBcQXpywA90D93AaPEDUXj5GphXkynVArTUDIPc2pItmNkkuLO2JyijJPPvbGBCAUaDvVOw4bwKkTnorB+yrQv7yo/LnHOJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(6666004)(66556008)(8936002)(83380400001)(8676002)(26005)(66574015)(52116002)(36756003)(54906003)(316002)(38100700001)(66476007)(6486002)(7696005)(66946007)(86362001)(956004)(6916009)(1076003)(4744005)(44832011)(2906002)(2616005)(16526019)(5660300002)(478600001)(186003)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZUlwNUpIVVIvU2FySzRvV1JjYlprOS84Znc1SUpmSlpHQktjNVNYaW5lWEJl?=
 =?utf-8?B?eHNkaloxMW95andSNHFkRkl2Z0R1L2NOc0RxQzEreGZmRjR3UzFIaUIyMFBP?=
 =?utf-8?B?eW9WclBqSHlhamhkNzVTWU1JUzlIbzViTWhPY0lsS0U3dzBOUytiblJTNllK?=
 =?utf-8?B?ekJqVVhQRTFReVc5eTlTczdHU0FKZDBkUkZQZFpxQlovakFiZG1veTRTcWJr?=
 =?utf-8?B?UDNjWHkySHdIcjdyYTRJWG9wbE5XL1lhWDIvYVYydUIzLzI0WEFCdWNmbTBt?=
 =?utf-8?B?cjJHMlA3VWprSkNHQjZoTFI2OTBYUzQyYTZtYW00TjV4UmV6dXl5RDh2NjNH?=
 =?utf-8?B?WWV1YTNGS0oxK3FrdlEzMW1TQmp5WWFvUG1UZGdacmVMWUtQbXJMcTZNdDkz?=
 =?utf-8?B?TU8yV3QrSnlPNlYzUjJ4MnNiUE1YRnJFaU9Sb3Nhc2wvY3AxNDQwWFJIYUhn?=
 =?utf-8?B?cG1NTzlNT0JQZHVOa2hnbWlNOEp4WElVMmxyT1dmMU1hN2IrRG9wSjZvR2ZM?=
 =?utf-8?B?aXBraDFybHI2V0t1aFJ5VHRkcFRBc09zUmt5d1d4QTEyWWl3MjJ2TWVlMlpv?=
 =?utf-8?B?ei9UMjZ1M3hJenhyaGk2TnliWVlNOS9PeWNSYjlhY0o3aEdPRnhQdVU5Rkxq?=
 =?utf-8?B?MU16bUpMK0ZQOHFENVNueXNoZU83TnIrU2hYR0JBTG9hVnpua2gyRjRON0RY?=
 =?utf-8?B?WGpvdDNJaHRjSzhMUFM1UU5LbS9WSlRwWTAzMEYwZUFoVEhLNXl0UDVDMmZB?=
 =?utf-8?B?UlpBKytYWWxORC8zcS9FWlNEc3Y1b2RQOG1DckdIR29IK3NVaVFWbHV2T0xH?=
 =?utf-8?B?ZnNydXFwMzBCQlRBQUhBaitrWjA3ZjYxZDlTUXpLTUpEOGNFNmhKaGhwc0ky?=
 =?utf-8?B?SEc0cEUrUGN5VWs4VnNEa0xUQU5OUE0vcG9LeTBFaDM2QkVob3JaVUE5ZG1x?=
 =?utf-8?B?QnlEdEgxYlcxQmpIUFg1NW5zZjZKekFweFJIdkprbUx3REFBNWJwYnB3TWJs?=
 =?utf-8?B?aGovRVZTU3Z6cnVkZ3pmV3dsSUdYSmNaK09UWU12VmVraGZ4VUxLSzZJZ3Vu?=
 =?utf-8?B?NXJ2MkZlSEI4RmpoN1hmWVozQ2ZWdHkrcWFnMjYvZEkzdjlUMURYWGpzYnNy?=
 =?utf-8?B?Q05oOW0yZGFUek1WVEs1UVdyVUpIUmVjUStTajlTVml0RFdSeGZBQVhOejgv?=
 =?utf-8?B?Z1pVQXhaM0k0eEpoNEZnYUFqTENucEJJbklUeWsxTDBqYmxFaHFqT3Y3Uloy?=
 =?utf-8?B?VFQvcVVHTEM1Rmt5TzZNV0pPVG9kSHE0OFlTNnR4a2ROUXpDVm9uSjlxWTdh?=
 =?utf-8?B?MmpIMjZibEhyUHBaQ0VEWEEvQU5qVWtPRE1ZTHF3UE1nUGVUZFpjbTJVTXV6?=
 =?utf-8?B?ZGErZFo5Zkp6N3llT1ZSdis2MmZiR2Qxakl0M0RoalJnTEdwcmRVL0M1dWI3?=
 =?utf-8?B?WHJyU05MNjR3NkJSakQrNnlmSDZlVUFBK05YR1V5Y3p4SGVraUUwYVA5cTFp?=
 =?utf-8?B?bHU3OEpvbm5UN3VlbXJnSGZKUEdqOGNsYitybWRna2RtRnhpUkpneDNNdUNt?=
 =?utf-8?B?V3hxZHkrUnozQjk4WGRzbTg2c29Vc3R5VHF6ejY0Um5GVnRsL3JaYkgwN1Bq?=
 =?utf-8?B?MGtnVm5vZXNwM1ovQmR1K1NrL0RnSHlQbEt2RFN0NkZ4a2ZZN1lhckV4Y0li?=
 =?utf-8?B?SWFZUU95Nkg1ZmVqUGpxUERYWFV2YkloRzlBNk1NeFlPSnRJRmFCR2FHZkhm?=
 =?utf-8?Q?KDghE3L8qnSGDB+97tp9jcKmRvuBLxH0CDHSmS5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a287a7-d4c3-49e8-82d2-08d8f075390f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 16:35:53.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8tFKqrPonQ5WP0Srl1itU2AMKEAZqnFD6Y5bZbabN2QN+tOvFQNX+SNartfwbxgXnDpP2MSxzENvOkQ/i+eaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0199
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
Cc: Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T2Zmc2V0IGNhbGN1bGF0aW9uIHdhc24ndCBjb3JyZWN0IGFzIHN0YXJ0IGFkZHJlc3NlcyBhcmUg
aW4gcGZuCm5vdCBpbiBieXRlcy4KCkNDOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1v
ZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMKaW5kZXggOTI2OGRiMTE3MmJkLi5kYzRkNmFlNzE0NzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0yNDEwLDcgKzI0MTAsNyBAQCBpbnQgYW1kZ3B1X3ZtX2Jv
X2NsZWFyX21hcHBpbmdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJYWZ0ZXItPnN0
YXJ0ID0gZWFkZHIgKyAxOwogCQkJYWZ0ZXItPmxhc3QgPSB0bXAtPmxhc3Q7CiAJCQlhZnRlci0+
b2Zmc2V0ID0gdG1wLT5vZmZzZXQ7Ci0JCQlhZnRlci0+b2Zmc2V0ICs9IGFmdGVyLT5zdGFydCAt
IHRtcC0+c3RhcnQ7CisJCQlhZnRlci0+b2Zmc2V0ICs9IChhZnRlci0+c3RhcnQgLSB0bXAtPnN0
YXJ0KSA8PCBQQUdFX1NISUZUOwogCQkJYWZ0ZXItPmZsYWdzID0gdG1wLT5mbGFnczsKIAkJCWFm
dGVyLT5ib192YSA9IHRtcC0+Ym9fdmE7CiAJCQlsaXN0X2FkZCgmYWZ0ZXItPmxpc3QsICZ0bXAt
PmJvX3ZhLT5pbnZhbGlkcyk7Ci0tIAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
