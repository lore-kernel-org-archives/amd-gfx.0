Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA657C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 17:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2DB10E03C;
	Tue, 22 Mar 2022 17:33:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD2010E03C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 17:33:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhJXENIooCkJ6x6uV7aKV6MTnR6N5cHSaSfgnFzCoG/twsZOqZik3pVI8Gzs3mCa35K0EN5UrJvrhJGVMaVF16l2ZM5Ll9i0CIPEeItdBnCzPa2IUtM+tYbx6K48CksJLxwrYVFeFl8ECeuR5awHy4rJkQI5qfNJqNseq8LU2DhQpb8hUl3EK8IVZy7wjIOZu3zfe65Mo47vdAgAmUe437IN6m8BXxm9p+pHC6a1t7HQVfbOqGoIYmGQo33Z678sAH3L5EoF54XYeq/Aa4HSO+k4bYjbjeqA1pF89jhjE7oZ0R25WFer4otqxSnqqtgKYFIw1HCtv1mCKkQEfvvocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeDfm4DKFUACNTivjYHxgbhZIS/U4q3hn9N+Xz8cyfQ=;
 b=PXXuZOOBEpQTXsGcPSEllSjqdDWJzoA4t0rS1Kcsd5+ybLpiQY64EgTUmplh5MiZ85KNsnarNzd6ABrD4a8HRGO2OJV/fi86wzT2JDunEn2FM17E1ghizuUZzDtgBgtft3gGRKM7N1Ae6uFDT/8jo4+d+YGxbSv0AUN9EI8KOSwxGrZRhpY02E643HIo3v+DEQkIFxbmYmGSM3rGpxazUyNuL07vayKMbcUlGWvQy+IR9KtMXhCHn5dmNJLtRpQpmmZzxR5yK0ScNZk9w7Bbnpbam67D2R1Mkmzbxt+u6w1KheJZ6hvcKjhkkF7OvP2W1ZUqh08MURZ0dHThIuuLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeDfm4DKFUACNTivjYHxgbhZIS/U4q3hn9N+Xz8cyfQ=;
 b=Sx4H5dN98a7gkB0Gk2DxNUa3zFEs10DQ+FCAin98EUjr8/NtY3KIuUHfczCg4gjUltxTcCpveslzFs5Sml+3wv6R12gdnjyjDBvwkJYLBulOQv6LkB7P4Fid5/BcqPFtRBw+vN5XhKhjxdSInLv91V5ddpTee7bMmi8uONfZmzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 17:33:45 +0000
Received: from MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7]) by MW2PR12MB2505.namprd12.prod.outlook.com
 ([fe80::381e:ef8f:81f2:5ba7%6]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 17:33:45 +0000
Message-ID: <bb193f0a-28dd-2190-d787-b17fe9cbe226@amd.com>
Date: Tue, 22 Mar 2022 10:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Daniel Phillips <daniel.phillips@amd.com>
Subject: [RFC] Add KFD available memory ioctl thunk test
To: amd-gfx@lists.freedesktop.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:a03:167::36) To MW2PR12MB2505.namprd12.prod.outlook.com
 (2603:10b6:907:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ba7932-33fa-4b8f-c329-08da0c2a1db0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5994:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB599401D83C0FEF14D61187C7E3179@BL1PR12MB5994.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMqegxGSnWY8xKW93dexeSBxwSEfiEsZabaJr2fvuDlVJ5yIbEzEAj6V4uLAnvNvskiXOBsKhbigx4rSszoSzeR0jwsFC0lVp9F6NBGQy7uwFAGE1c/ai3lUxoHAC6YAqa+6ICmcacjHwt+LRZPlq3omMfyUlFmUZVQx1kDkJd3kQoAeZdT3lyhbuEzceWePhBOXgUYwtjzixx0QGpo0JXKVXLZfhgQwz4+KrzWJKvpFMDFCacamNotUyh5n1UT0aDNqlsnT/oocRB/0ZR0/P42V88HyzA6yDKAgi+dLo5GYzC/QywIYO5jlkaHb+uE/rxaQ/BVgyLv03Jm1JwpT+epKu6F6KV+8XhtMXItAWTow1CbGWlva4FZFJeviIMANMDPKK1JMA7eBKNI6SuHQI+qHYvVvzk0B+MQHXonaVsXXeCnNhIXpLICEwWAi9ouJL7rWEjFa6Uorg/M4bdjsq+PXZ4ACveWMOBuEaMT212pCAoCKvBCxfkcdymPvTggZJhLHcrXsSgGpdyc1vAtNzy0GwJcTB0YX9xDTMvlzyg2i7EF8JigIFk6Bn8pUVsU/2AE2tsy9RlKwojJIUlnVGrXSZzcTbXzyn3KsXS1GO5/qzLztSCteCBZ3xFNKemRhpaZegfXxt8IbYl2LjSQkzbEuPQB8uPcUsQS37KCSg5DjADrNJ0lpspLnTccYyuLs8pttEafCTBhx/Ifc62HujdSYB2lBB49ggDZpDPLd2Do=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2505.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(31696002)(86362001)(8936002)(4326008)(66476007)(66946007)(66556008)(38100700002)(6916009)(186003)(26005)(36756003)(83380400001)(508600001)(8676002)(6486002)(44832011)(31686004)(2616005)(19627235002)(5660300002)(2906002)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFYbzNuSFNjcFZmNVE3UHB6ODF1MW5rMUR4MkdIMUFPQmZqM3NhUU1EUTZQ?=
 =?utf-8?B?RklEUVU1V1M1MWhRYUdGWDdRRlh6NVJMaXhFa21lbTVRb1Rabnc3YzBRS1hG?=
 =?utf-8?B?WXlwRFNoSmhJQ0tnVGxpN1JwdjFaSXZ5djlKemRHVHN1MzYreDBXMWhaWkRz?=
 =?utf-8?B?cVJ2dDNaUmZDOTlrWklBdHpzTmduWUc0bzFQRkw3L2sxbjJTR3JEVWtXY2p3?=
 =?utf-8?B?NmZScHZUNXZZZHB3MmF2ZmpMekdONWdJMTRFem9VMHJiendSNHNHaSt2Uzgw?=
 =?utf-8?B?RUJYeW9teXRVOGpIbkFPbm5RbUtRN3dhZzVXQVlNNXdRdThhY3BZVkM4cE05?=
 =?utf-8?B?WkRRNWRLQS9rckw2NDZCTC84Q1ZkamNNT1k3VDBmY2FRcE51cVZmTEpJcXlx?=
 =?utf-8?B?UnZGRTZKdHRtSDBkQ1laOVFHOXE0eXBHWDlyaEc1YmxaTmZWb0xVMjI3aVY0?=
 =?utf-8?B?UzViOG1SS2duQWJpazVZRjRadzlocGxpd2hlYUZNd3JPUnQzK3ZrVC9pTGl4?=
 =?utf-8?B?QmNxQ085SlFkaVNGM3JUWXVrN3JXS3RKaHY1WGhmSUttNVJqQXF2SkFhelQv?=
 =?utf-8?B?NXVNdEpoWk1CWmdDUnRsSUllWTgrR2NrejFieHJ6SUdBSm5DT1Y2WGJWZjdm?=
 =?utf-8?B?cGNHTmE3VG1MRWl3b1hOTisvSWVFZkg1SG9XeVZFaUdKdHpJWCtpTFc5d3BH?=
 =?utf-8?B?Z1pUQ2tnV3FSMW51T2dQUEY3MnJyYkdRam1JUDI2UEt0Z0VZQUJYY3dmeTJB?=
 =?utf-8?B?d05iYk1lSEEzUlN4WHRqTTl6ZHJudjI1cm9Ra0NydEwvdFNURVdoaGRqUTRw?=
 =?utf-8?B?QXlESFdSWmFYcjdhakEyY2lWZlQyWmxlOU9CaVk5NXAyd0srSnJDM1l1dm9L?=
 =?utf-8?B?RmNZV2MyOVpML1V4YjUyZUZBa3VYd1JDM3QyS3Q1M2ZLUWZmSGxBbWxNeWEw?=
 =?utf-8?B?ZGRIUi85cnRENzR2OWVuaXRtU0toREEzeUwwSUZWK2RIZGt0SFJwcmpkL0s2?=
 =?utf-8?B?SjhFNElOMytEQWpBYXRSTlZNcEFlajhHZVdkZlhaSnBtbktVRzB0Szh6RDZ5?=
 =?utf-8?B?dFI2Zi9CTHJ4K1hUVWdCdU5zQUQ3eDBOYzEwMElJTnN4S1pFUXhLUy9IRkMx?=
 =?utf-8?B?N2ppQ0lqNi9qY28xejdTUU1VelJGekppYnN5YkRpTEg5R0tGQS82a1RLZWNK?=
 =?utf-8?B?YmdJUjRsbEpib01GeUsvTTFkWmZmaGZPOFloVmN1cVE5b2hBVTBhMi9HUTE5?=
 =?utf-8?B?Sys5TWt2YnZaazkwbHpndWFObGZDSTZ4ZEZVU09lcnN1ZWgybVRCZ2cxMUgw?=
 =?utf-8?B?dGFrbThxNWVWT3luTGMxN3h0WjFKR1UxZVJCNzVwZEZBdTdQcjZvR21ZSlMv?=
 =?utf-8?B?MFFTb0dXcHF0NHZZbFlWckcvZlZ6YnZqMGg1STY2d0kvMWhhWmVBUE0xdEN6?=
 =?utf-8?B?WWE3L1hlUGFVWVVUVHI2RnZUS1p2cHQ4cW1VUitsakpETXdOWUFTNTR3UGdw?=
 =?utf-8?B?c1JFL3dmQWZaeUZma0ZSOHNGTUVzWU1FOG05SGpRWXIxSERURDZFV0lZbnA4?=
 =?utf-8?B?S01aSU1DZThTb2tleThRWlpTR2Y3ditWZlFsamQrMW5mdHFuOVBNUE10RFhB?=
 =?utf-8?B?NG12Rk5iMXF6Ty9pT0pmbS9DRi9VV0JlcjQ3ZFNrME9VQlBNcEErY2hLWGxK?=
 =?utf-8?B?aHN0Z3JZbUcxNVRJaGlXVy85S2xsVlhMK1hiVmFraktmNUZTKzZTUCtUcHBS?=
 =?utf-8?B?NGc5UnlOY3FZQ0FrZmh6Qm5lV2RSMTY4UTVQMlJldFI0YncxSmlQc2U1L2U3?=
 =?utf-8?B?b2x3NmVYZWdKWTZEbCtLTDIzSCtsY2JCVmN1aTI0d2pxODVDQnFpcmlKbGZo?=
 =?utf-8?B?SVB5R2dTUlBMOFNnU1ZtK1gxMlUvWUt3S3ZSRUM2QjhJUzFZRERNRzVuaXc5?=
 =?utf-8?Q?BVWg23kmKRlYHeuvHGQFqB790WgNtwBu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ba7932-33fa-4b8f-c329-08da0c2a1db0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 17:33:45.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVZQu8dAc9nrIrGSlyJr6pkXzDdRse8X2FTVYGDrvkFkI7VDxhD323NiO6z1kc0+VPbdRcUeDpRF0W3X4vrAsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi all,

This patch adds at unit test to thunk for the new KFD memory availability
ioctl.

 KFDMemoryTest.cpp |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Regards,
Daniel

diff --git a/tests/kfdtest/src/KFDMemoryTest.cpp b/tests/kfdtest/src/KFDMemoryTest.cpp
index f7ac73f..b23748b 100644
--- a/tests/kfdtest/src/KFDMemoryTest.cpp
+++ b/tests/kfdtest/src/KFDMemoryTest.cpp
@@ -595,6 +595,31 @@ TEST_F(KFDMemoryTest, MemoryAlloc) {
     TEST_END
 }
 
+// Basic test for hsaKmtAllocMemory
+TEST_F(KFDMemoryTest, MemoryAllocAll) {
+    TEST_START(TESTPROFILE_RUNALL)
+
+    int defaultGPUNode = m_NodeInfo.HsaDefaultGPUNode();
+    unsigned int* pBig = NULL;
+    unsigned int* pSmall = NULL;
+    HsaMemFlags memFlags = {0};
+//  memFlags.ui32.PageSize = HSA_PAGE_SIZE_4KB; // check if default
+//  memFlags.ui32.HostAccess = 0;
+    memFlags.ui32.NonPaged = 1; // sys mem vs vram
+    m_MemoryFlags.ui32.NoNUMABind = 1;
+    HSAuint64 available;
+
+    EXPECT_SUCCESS(hsaKmtAvailableMemory(defaultGPUNode, &available));
+    fprintf(stderr, "=== available %x\n", available);
+    EXPECT_SUCCESS(hsaKmtAllocMemory(defaultGPUNode, available, memFlags, reinterpret_cast<void**>(&pBig)));
+    EXPECT_NE(HSAKMT_STATUS_SUCCESS, hsaKmtAllocMemory(defaultGPUNode, PAGE_SIZE, memFlags, reinterpret_cast<void**>(&pSmall)));
+    EXPECT_SUCCESS(hsaKmtFreeMemory(pBig, available));
+    EXPECT_SUCCESS(hsaKmtAllocMemory(defaultGPUNode, PAGE_SIZE, memFlags, reinterpret_cast<void**>(&pSmall)));
+    EXPECT_SUCCESS(hsaKmtFreeMemory(pSmall, PAGE_SIZE));
+
+    TEST_END
+}
+
 TEST_F(KFDMemoryTest, AccessPPRMem) {
     TEST_START(TESTPROFILE_RUNALL)
 
