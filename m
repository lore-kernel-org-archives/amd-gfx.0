Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C6AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 05:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37EB238D7
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 05:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37EB238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786286E504;
	Thu, 21 Jan 2021 05:08:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E83F6E504
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 05:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez2POMelNgzOPgdRrmBGTQoWJwMF9RTezTGeB4fuPDK2je/lIbbISkFyAJcgpASDsaDBY+fVAy71Ft/3TIolExDiiuHVdmcxoYq6VHTlIk2BzPq4WWocb9gUzR0CN5fYKZ09QlEEAGySGiapKPlXKxOzrJQPp3U3wYThXbFRM7UewKT/QaGVEitLgp0qORXb61QEuWDDMpERcyssIv16b4QSdrq39ddbYLITCTGpFz9zQ1kYH1DzKNSSRetq0FjGXqvsMTn+3QgqPKMmfzsyt+l5wwziRbV2wRzFYQSFKV+6QUbrJr7XQsSBKtd6J7TzMBl/Q8vcxoOWKfK/9hJEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VudIGEXX6JabBo/z+zQN5NmNFJuXeBPcpuiuSVVK2/Q=;
 b=PxnIvxNP+ZJ0k2tUPaiCpAsmpoa6GNKWypj2KZOCqm1ZWxRSG9T3NeIawnGptPe+HbgmvQQ6OqQHvSGdySTsIrkMOdvcn5OKX0aW7yc7b5f6nLd0Ia0hyYRlILJoPvxQ8lGzPcbMMuizUK0xTsZcgm3y+c6wq4AnPglNc2h00V51DEeSgckawxz3eOnVxOzb2OQ7m3mRZR+8vWp58/MqHt9YHFVvRGGXIEFXHoA0qv0Q3OLAl14Pl8BXqrXCZL22Hj+0Cw1O6nc4ZSngra1g4udhj33FSfjPD+t2Ot+Ja1GrqMPfHk+i0e8sBzh/rryT84q7EgDlZU4NZtUAnEd7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VudIGEXX6JabBo/z+zQN5NmNFJuXeBPcpuiuSVVK2/Q=;
 b=yYnGzFBWux98NvZEJhbbI5GnjZrUHH8FyudvJh3DcZ4GvPpBa3v/5VTHhHlkEo6mi8tXuKRdNuX8wiDE/fYmZSDEJgzWQPd55W+taZvfk80GhBnhDuuwOFO2fzXkPP0Jl+3DQMhJA72DddT4JfGMxFffxPxfw99PAoiVN8XJpNg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 21 Jan
 2021 05:08:41 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 05:08:41 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: Make contiguous pinning optional
Date: Thu, 21 Jan 2021 00:08:30 -0500
Message-Id: <20210121050830.30888-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 05:08:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0cff0afd-7bea-4c61-2ed3-08d8bdca9e7d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB432077976D3C6077FD06B0A992A10@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpWaaMWpHzHXbQIMx7ky8JfUUmwMekG/TRvcSExOXbYhXzaZUZUtkQPIpOZ6f8aqDLn1tDNQ0Ei0BLTqe403FZ+p04JtJdLKojutWg7srXW0FnEa2071EGA9+0a6etHUUoaU+yxNAJDzRLlEJZifSwjQRZYiAbmUNsv361cyLCT3JxAcSx59lsanc0QPEi4oKf6SMTrm+4JnLSXuDRV/72fqi44w5xNeMh/TEkfj5Gk9zIoonJYET1nN/68U9SOpLOdkeekFcN0oywI037VQIjJRri74oQj8Oh2s36z3b6I+P0F0qUaRtSXv/zEbpcKdD/+1EhLlWsbl45JaW+cvLDzjjIbeBTrZ9JOTGAHqdu2BEjQsA1FW2l3evhqfV/qucLW2eHxYRS5qlcXtpWgEsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(16526019)(186003)(2616005)(83380400001)(36756003)(52116002)(8936002)(1076003)(66556008)(66946007)(6666004)(26005)(8676002)(4326008)(66574015)(6916009)(478600001)(6486002)(956004)(2906002)(66476007)(5660300002)(316002)(86362001)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WS9ROXpVWjdVbEpHZGVwUkJHZXF6VEMyVGRFZDRSQ0tLV2U4N0tIUjhMeUdQ?=
 =?utf-8?B?OFhtRXhhcWw1bFFVek0vTTBSNXlNbmttekQwNW9xZkpBSDc5SXVWSlMvc1J0?=
 =?utf-8?B?dHpGM1JURmpkZmg2VlE3Z0l6U2ZPQWdpLy9adDlwZDdWQ0tZSmJES0FNTncv?=
 =?utf-8?B?a09Sb0FPNzRVdE1uU1A4cm9TRkxnaVp3emdpekJCNE92cEhqb0dJVHFyLzE5?=
 =?utf-8?B?UmJzRVhvMmtoeVdMTS93QjVHdHovMi92dy9pYVN0dzQxc1lKd0F0ZlFSRkNx?=
 =?utf-8?B?M3R5VWtXL1ZRNEJEMjRuL2ZlVWwrY2w3bER5Q0ZDSUdaMUgxL0tXbCtnengy?=
 =?utf-8?B?YkpxTzcyTWdBQzlMaERKWjdRWGpLMHl6bTIzaVBkd3QvRU52WXlqVGpEOU1p?=
 =?utf-8?B?OFBYbkx4NTVTVDErYkx1NnhVUEE3WWdJTmphMUlMcUw0S3JsdTBHVDJkR2Zk?=
 =?utf-8?B?MzJWNmF1SmI3Nk9JSzgreXo0ZFJvSDVWWXJjY0VXa2JKMlIrTGR1b2E2Ymho?=
 =?utf-8?B?cTFWbzlsVkE1d2dyaHkzKzZidTlPOW5uTngrRVVHWVRiZFBSZjVhZzVPRlM0?=
 =?utf-8?B?bkx6YXRiY3FtZDczQkhxWllYREFjRXBkTWhRQitRbGtrTWxNZ2JGSGt3TlJX?=
 =?utf-8?B?QVd0UUFZOHdtODVwZDR4V1A1WFUwaklCVHFLcHZLL0lyYXdaK2tySUtKRStB?=
 =?utf-8?B?YU1wNmNFOWlMZlpPOEt3T1NYaTdEczVNT0RpSkxoVm1uWkpqYmpBeUNHWlNL?=
 =?utf-8?B?U3B5NmNPNTVrNGQyNXdaOWR6TGI3VnNQTXo1VDVHa1VKU29iNDY2Lzk0ditK?=
 =?utf-8?B?cTY5MFRUVmxFTmlMd2s4NGFRaTZlWWZpSmNCZVZCUUk1Z2F1WWZsYWdDUnM2?=
 =?utf-8?B?NlZlMkQ4N0kvSVg0QmpHbjdkQm1odkQ4dTVCUmYvbExrOXYzemthazJFY0Vp?=
 =?utf-8?B?dmh2dHRKOWVydjRtUHZITGIyZFpPK2c0K3dlZW8vaWR1TUc4ZkZjMU1TYmp4?=
 =?utf-8?B?NStKY2RsTU5kQzlBRExaN1NpdTF5TVFvdklnVG9VZkhSVEFhWHBid2NPQ1Ja?=
 =?utf-8?B?V1hBOUFXL1QzVThhYTN2VlE4OUIwMk5ESnYzNHhzS2FMUVJaSUNrRFpLRC9u?=
 =?utf-8?B?aVRnNE00VkwrU09NN2dnenVRSjN1dnBPVUpiNEdZVVBjWk4vOGIyeTR1TENh?=
 =?utf-8?B?Z2ZySzk2QXlKRnNodXR6OGZBOG1MeWJQaE9FODBTVm1hUWRXbmg1MnZUcGg4?=
 =?utf-8?B?VzZBMWYreHlhdUg1eHhTamdiRHVjM3l3Q3Q2ZHhXUk1DUzhOek84Skp2dEJo?=
 =?utf-8?Q?mnKnivBDTwQ4Cvb1O97E4hAz8tWAlZC2Wc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cff0afd-7bea-4c61-2ed3-08d8bdca9e7d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 05:08:41.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drvXCbqwyOonbgLOHiGaTgL9j/LbKhhvd2s4G1bVcIuGfVuWf4EYYAwrWypzBEw7t9/06JzhnJ4fs6MyY2H33w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RW5hYmxlIHBpbm5pbmcgb2YgVlJBTSB3aXRob3V0IGZvcmNpbmcgaXQgdG8gYmUgY29udGlndW91
cy4gV2hlbiBtZW1vcnkgaXMKYWxyZWFkeSBwaW5uZWQsIG1ha2Ugc3VyZSBpdCdzIGNvbnRpZ3Vv
dXMgaWYgcmVxdWVzdGVkLgoKU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwpp
bmRleCBkMDI2Y2VmOGU1MjAuLjEzN2YyNzVmOTBlZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYwpAQCAtOTE0LDEwICs5MTQsMTUgQEAgaW50IGFtZGdwdV9i
b19waW5fcmVzdHJpY3RlZChzdHJ1Y3QgYW1kZ3B1X2JvICpibywgdTMyIGRvbWFpbiwKIAogCWlm
IChiby0+cGluX2NvdW50KSB7CiAJCXVpbnQzMl90IG1lbV90eXBlID0gYm8tPnRiby5tZW0ubWVt
X3R5cGU7CisJCXVpbnQzMl90IG1lbV9mbGFncyA9IGJvLT50Ym8ubWVtLnBsYWNlbWVudDsKIAog
CQlpZiAoIShkb21haW4gJiBhbWRncHVfbWVtX3R5cGVfdG9fZG9tYWluKG1lbV90eXBlKSkpCiAJ
CQlyZXR1cm4gLUVJTlZBTDsKIAorCQlpZiAoKGJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRF
X1ZSQU1fQ09OVElHVU9VUykgJiYKKwkJICAgICEobWVtX2ZsYWdzICYgVFRNX1BMX0ZMQUdfQ09O
VElHVU9VUykpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwogCQliby0+cGluX2NvdW50Kys7CiAKIAkJ
aWYgKG1heF9vZmZzZXQgIT0gMCkgewpAQCAtOTMzLDcgKzkzOCw2IEBAIGludCBhbWRncHVfYm9f
cGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAqYm8sIHUzMiBkb21haW4sCiAJaWYgKGJv
LT50Ym8uYmFzZS5pbXBvcnRfYXR0YWNoKQogCQlkbWFfYnVmX3Bpbihiby0+dGJvLmJhc2UuaW1w
b3J0X2F0dGFjaCk7CiAKLQliby0+ZmxhZ3MgfD0gQU1ER1BVX0dFTV9DUkVBVEVfVlJBTV9DT05U
SUdVT1VTOwogCS8qIGZvcmNlIHRvIHBpbiBpbnRvIHZpc2libGUgdmlkZW8gcmFtICovCiAJaWYg
KCEoYm8tPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfTk9fQ1BVX0FDQ0VTUykpCiAJCWJvLT5m
bGFncyB8PSBBTURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEOwpAQCAtOTg3LDYg
Kzk5MSw3IEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3RydWN0IGFtZGdwdV9ibyAq
Ym8sIHUzMiBkb21haW4sCiAgKi8KIGludCBhbWRncHVfYm9fcGluKHN0cnVjdCBhbWRncHVfYm8g
KmJvLCB1MzIgZG9tYWluKQogeworCWJvLT5mbGFncyB8PSBBTURHUFVfR0VNX0NSRUFURV9WUkFN
X0NPTlRJR1VPVVM7CiAJcmV0dXJuIGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChibywgZG9tYWlu
LCAwLCAwKTsKIH0KIAotLSAKMi4zMC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
