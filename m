Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9648FC617E
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Jan 2026 10:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6211D10E2E6;
	Sat,  3 Jan 2026 10:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="ckregvWz";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H3gVgOzf";
	dkim-atps=neutral
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC50510E15B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jan 2026 19:08:49 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 602BuhIG2738127; Fri, 2 Jan 2026 19:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=W6au/kfNZAJZaRrRXB
 tzYpgDrJCfRLy9+czo4qJJBm8=; b=ckregvWza2ZJuLwaifbr3JftY13nrrF2cL
 6gu+Tt+n0CFCbzt91BGnfXPP6RN0MvXkB0yYDYlxIashIbjdVwUGfY30ZECJBH/N
 oiJV/CsmwEsPUopAMrvw6EJ9T/qvvonygqk0sUkqbyZaSkpCzNbHVkEupDgf5qOX
 OJOlKD1dXbeEMyw7QsR/W606JvApBPLbWyzfKwsQh4oJPpOqyK+5kUbF1N9mSFG0
 6bs+n3Xu9aM4Rk9Geq2Bqd58oM5jNTPSfe5MvZ/9nlbigCzoQTIjmRSmpgf/BwkV
 +qdPVmYfcwe8uL7M+HdZ3gEkJsM0kAvWi1hDeeK2Od0CQgxhkcfg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba61wddk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Jan 2026 19:08:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 602Gg4oP017386; Fri, 2 Jan 2026 19:08:39 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ba5we3kj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 Jan 2026 19:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq4NP6vovkxR1z8+0++Hg4RB4LOCd4G1/6hkbeM//jaNyWpuG41vtRwGOLuzyVwVDhLnfygAKC6l2jGTE6Drq27C3iFiNYVDRaaQ+gMy5w4XkdULGrDMsO5n5P8FQRTgXbCxn8VUNYmHXLi9nRr+cVbVOYj77bKGCJySrbeC/3Wzgp6Rcug9n2ipINOd5h6kEbYjoOcmexwioxvVYjqxs8LMs6++3aucIhZsJBYvnaJnaNyQJxVp4B5RkMk3QIQK1y4+2FlfC6UlPv6RxmAoIx8GwaMpry6HeeR4muM1BJd6LxwiVPxSxdou9r1A/u89CotKZInhioN1sf/DYulhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6au/kfNZAJZaRrRXBtzYpgDrJCfRLy9+czo4qJJBm8=;
 b=l6vMvNQi8V8GbR7+M0LypRcZ7iy3VNsn5Wa98Ejc6rhdlYi2jW7Md0e3/MdJiQLfM/somTdEauyUlKjHSHl9CzXN1TpY3sYx6sdU4zRzY3lDnZlI1lX0Fq1wQijjiZqlLDQbC7LTlXBkAX4wd1oDZ8ao2muBQ07qDfG2d4Ntr8EYlyDNSQYQMerz5YtcFtbgYW0rSiA5iwaHiTQUrekFv9OHWtU+GIROcEbqMLgVSuG6zZ4unQw+n9IQAuQxgmDMskmlkWHrNhREtMsvzxq0qHeqZFXSXwNYNpOWl+FrJBGvo90PvjW/H3OJDTM80Xh/sVzbNgiG/b4TQt62BbRgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6au/kfNZAJZaRrRXBtzYpgDrJCfRLy9+czo4qJJBm8=;
 b=H3gVgOzfY/Ad4tb+LSbl2lqh1sbkxO669scZL+T7IEaKdfKCBIThZfCFp3ozdYrcLPLFuOvwbbTvW49oJGkrevkQmXt+MFGL4nedycLmjlJaRvuXNSxY6vihBNcGF6zmnJhRUpvAFGS3S1L4EzIlrZE3iEdtBCtYZlaGCMw/ilA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 19:08:35 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 19:08:35 +0000
Date: Fri, 2 Jan 2026 19:08:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v2] fix AMDGPU failure with periodic signal
Message-ID: <b6a2a040-288e-4114-b85b-51740c608bb2@lucifer.local>
References: <6f16b618-26fc-3031-abe8-65c2090262e7@redhat.com>
 <0826eb09-216c-4d00-b4eb-ed1a2ba204bf@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0826eb09-216c-4d00-b4eb-ed1a2ba204bf@lucifer.local>
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d4f84a-310e-4753-369c-08de4a3253cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yx7PHCx6jhtq3Mw9iE5mRbYzsX7cMu2oAI/0QNdvfSrvSDpeARMu5gB/n+o8?=
 =?us-ascii?Q?RtVkfpepTWuXoSmUzMGezVq1mAhwKke68tZnHVnT4sCoMzkFdoV/Ni2n1695?=
 =?us-ascii?Q?AqWZq/kyWaqIqI93lVLtgk2qJZM7yAbv4tPMkj6fu/T8D+k3mHlkuKfTRGiZ?=
 =?us-ascii?Q?CAKadgLV9uXEQ+841/Efvt6oWD92ciWVHmeLIshRGH1zap8XfDpo7g20wgbz?=
 =?us-ascii?Q?ywBwGDmvEQG6uuQf8ursvDTptzaPTnQikrNkSL06wsrnqiD93kWSPy1cPyTQ?=
 =?us-ascii?Q?MgwGmqnp/aTNO/zcFUoch1kSisVEpzUBgxYHpodejx+68Qu0nRbyFwP/Pgwb?=
 =?us-ascii?Q?bl6RTJvoWMbkX/cV/P6dlDEXMrvNJYRdjNtETbpZwjVYxJ2Iu/wNASw71bfl?=
 =?us-ascii?Q?tafpYTtPmnFbfXDsdO1PFrBn9vWxyEExYWyeV9o0HX1npqg92hi15Qr4IUXC?=
 =?us-ascii?Q?ieq2CbCW641muM8sHKFWL+688AypM/4LS1N5C47KtMRF148UAbgNMGir+1a8?=
 =?us-ascii?Q?oi3O3GGXo0aB0NpKVspFSdJilZrjd7+Wh1Q4roM9DKw6lmh3BQQSBdvtu60Y?=
 =?us-ascii?Q?MKS4pmuX5aieoG3tIGabQ1R6Yuk7PSf4q44hbKQPy2Ff71MaPhks7LwQ1avV?=
 =?us-ascii?Q?gRPwy8brPe3ygwHoSSPAc+U855TGow5N+gScnSwx+xW5LztcvvUOAJ/+pfc+?=
 =?us-ascii?Q?/Ip6FUAtWJhgLDVgErhIqxU5K5pEeDpKB0gkxStEReMM1adx2AeQ2ZxoE6G5?=
 =?us-ascii?Q?UexV9FhaRmSYyGgqYAIvFX51P7+OhrDYLOJKuAJW9baBJ5AZ/t5gzrCOqade?=
 =?us-ascii?Q?e5TR7wXjfZODf+m5lSeLLMkoTvDvPrg/ikhk+UJNuOaLpMK16qx4BJgfdYMn?=
 =?us-ascii?Q?rl39UeqHvf/s5riZqvkab1dMP7cOC29mY9wDFz1qqGYJcNz1oUVijlVWmi6S?=
 =?us-ascii?Q?PGF8w/91iRvYG8xIIRARww9UmnKdQJacleVQcIrJYVpny7Gh7OY/Dt0PHfJO?=
 =?us-ascii?Q?RQlEVnW7qW5Fk8UKN3L9JEW9PtnbntBokaSQEjB9AO7BrMILJbjmn4IQ55TO?=
 =?us-ascii?Q?BcFv2Gbex6GdydjgycfKAa1uXbWhWs8hn/uX8OMF5ldZXrufGiSp8XlyuVbH?=
 =?us-ascii?Q?foRh1o0svsR4N7DZEECG1Id8/TPjwn8t1OEEzch945Ta3PW6GDSxkuuQ22O1?=
 =?us-ascii?Q?JASWQ9KQ9eKhzun+jPyo9WuJz0cUtiE1ZwYy/KfCrUwRZCwfjTAioPArczu6?=
 =?us-ascii?Q?bGkvv/o4Ph1NxF3QnA9o9QQqiZqb6/hO+G88Fmi+cd6xjCF97JWH/by86bhY?=
 =?us-ascii?Q?qcaDMVp0WT8ZWBJxnCnwHv0l9jQb8X4q4QVkgPZX6yFoNWsbXwlY+dlYkhJi?=
 =?us-ascii?Q?+4yA1srAkjc0dHoUEc08XnU3mp6WoM+XJdPjsP3jzsb/yNvmKkEi0vPxp0hW?=
 =?us-ascii?Q?h72NPu0rn5hKnb5wnWYRWHwb8PDoJo2z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR10MB8218.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmI/dNiUXopaC8nO6Hp/QiRK7oN+AVykqCTHBaXRFHS+u/vXOOCTl0nqi+uN?=
 =?us-ascii?Q?+Z0nGYlBghXl+pf8PHMhJ2DnvmeBGNtjUKWPNS2Bz++doB7JV1l0DGm1OZmN?=
 =?us-ascii?Q?uZYYyzFfhouqkVAaA0q7DRtKrMu5stZV3/uJhE+6Tu6/Vp3X2gYbDOBWShTf?=
 =?us-ascii?Q?6qdFezo+SQiU/7qWm3HaLiXZ82HoOI3LCDrjVPL/91Zzj2suE3ZXrIFsUFs1?=
 =?us-ascii?Q?l6ZlLGifgShk0wgPG3jSRGRfQOXGmF5K9BW0TrlIB+/Iqtf/pE0J3z1E22gn?=
 =?us-ascii?Q?kkPOF5Buoy7yQ2wcRDFJnkFquT8YwegmxhpbmU0+0HDsKJ2OyNNyl+xDnVX+?=
 =?us-ascii?Q?W0FRhXmNk/q2y5a8C1HHhwTxpJOzKMC2u7KZJADXxGxb4TafMTlMLXmhYXQ/?=
 =?us-ascii?Q?UOP5JDA3ThGVI9xO1w1gmpjDYXwduIST9jYrease1s3sW1Ep4vkokW5NCDPV?=
 =?us-ascii?Q?SQ/R77R90vDsLbhOwglViNW+uaxB4qJ78bgEpcFqQ/RnRnsGU1pfPNmyB6JQ?=
 =?us-ascii?Q?t9gb0e9dBYrDQ3tSMMKYrbwORzQ3cidlF9FudB6nfsca74p1IDQ1V+B8R+o6?=
 =?us-ascii?Q?sDV0rzrtmJTP1sprlCScE0pPtmz0w0h7OkmsTHez9ZoLd12oe7l6uNhHkwZ7?=
 =?us-ascii?Q?Rr+mI7ZqJ4glvS+Vv/ZTLLL6zkGJDnew5PRQEs9n0Ow+SBh33ss4TZAIG3z9?=
 =?us-ascii?Q?ORkw+FFfmO8qLO7li6KTeHP3UPpBLRq+FxvVXGALpRFSyI7XXJJTENRvSU0o?=
 =?us-ascii?Q?zpKQ1UDL1yTuSw5PfJG6tsTG95UxY+QHxCsjyy/GFWLEk3gfkpiLi0Z8EJPZ?=
 =?us-ascii?Q?lPqAKDG5thjBm7FDoA1M4rSUvgb0zuXfBE/56bAfZpyQh81DUGSGBJ1EkYLF?=
 =?us-ascii?Q?6belEdVsVUSow1LkY1fNvMWpqC63EMlYQPR0IQ7jiZDXzgG2MAeRkYdTSpxo?=
 =?us-ascii?Q?px7wczny+ok4A7INB0ElOkg+zCrUZtskX5S0YpiakIkyksZ5XJsebFN2RYKd?=
 =?us-ascii?Q?tTYwjdgzJBYoXOuyeVKX67q0zEMO3ml3yrn28rFpHeEmIIHTgoBWN98OVp9E?=
 =?us-ascii?Q?E2Kym2F2nGsoJeWk74/T52kCyuzhedez33KzZYjaan9w2S5R6EgM2PJ+ftw5?=
 =?us-ascii?Q?CI257ulYGDcB6ySaQ4SPOD6vBLAQC9SzNRne2gsQp4tMvTxf+CuzgFCIh0h8?=
 =?us-ascii?Q?Jbt+lCmOtzQ2T1/ea5pxji5vFK6J+76oVOm5ObH3ylJgsrtUtRabD3QJ/V/K?=
 =?us-ascii?Q?kBKfu7p0vkKA6F7Rlb5+WCvvkeLb2cFAcz0eIlcGjaXN/VEjzs3y+f6WuVYv?=
 =?us-ascii?Q?bDlJVCDHWejUkiicMLXFXtOGcK0J3h6JpEpcaVaY1CO4i019jGKAyg9R59xk?=
 =?us-ascii?Q?nU0GuD4g5NktRrgz4Rtfzp3GZzEQ2W7BxImqYMny2scCEmZ+oji00yYoonMi?=
 =?us-ascii?Q?6t7r565xR5byAhzlCvUWMuF9AsuuzEHUEBh2rK6x7wkWNFacc1zQLU6R6dkx?=
 =?us-ascii?Q?E2zoc8+S8F4fWo622W0mxjpkGKYubwyoLtrKs+G+cF05RhJYefd6jOJ6BnBi?=
 =?us-ascii?Q?RVRfQ+GLYBXTERpQlV6l98a6B6ogyi+NeBYT7Wu7IHzyS77CrpAk7HNRmi8p?=
 =?us-ascii?Q?v+eqsrSbQU9Ev5rmQ+Bdhj77/1roveIT1Wsrh//V5uh4MP5VfJPwASKel3TE?=
 =?us-ascii?Q?/NTS7Qwhv7jH8e/XYK+CxEiBY97/KPFnbJfvpofNHFvjmy7K7CCl95osvgZC?=
 =?us-ascii?Q?etCBpTv1FN8oXaMq05rPS1GzG73mf2U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gKaraAGuGdr0WOi5h2VkOlt0I60FZAcqDgmwdoHBTvyxB/k5bDdfirFmPZr1PfFWGsM96Z7rsZz1xA9UdATChm1VZxayWCvw1YCO3sRs1tWnERbEVfps6rYTEPirlc+lnR78MO/ZvcOR+Dhko2Q7rYeMVo6KrK/qM2LzSBukmgacvSwGMXenRqTO+5O0pAdFILFBG92m18nSOYLmVG+ALBivqmorE1MIU8CTTd4hhyNFQGDu00QqQ89yMYN287OqsxC9fbXI2qZaODhTihuoW4fx47hFSFJ929JxsgI0fAHdxdUpc9E9925XEemQxUONTwGT1OfqAeM8rnbDXxmE7wO2Nsy6IKUh23JLUYaplDmaaBCzhSfV16qSZ6MVRSYoXUKUQ1Yr/G+kPUgUIte8r+ABgS0D7AxEAEIHRk23uFbO4v3tJuMBedB7xaEidDn4EINSinshcooYw/W1xUQW2mpUUb5SALg7/qYOZXXGAe3jklzR1YKEL5ZgBNlPvTIvCQl1ov6nLalQmHSfPrt0NlpuVnNWQ5sHiJbKtx6JvLfyZnlqA/93EWHZ1qS0sviI/3dXlbE/st5tB94Jd9UuIV/4/+z0OZK1VmxfM2K23Xk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d4f84a-310e-4753-369c-08de4a3253cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 19:08:34.9076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6zMK9tsRzTJqUiX7+K9oFgASRAbntooJxWOavk9w1HYp6aSOn+v67HHOXdAwokwEobAc1fAPZ8++3u1VOjpUXub35Ox8jCbe+IRHOzyy/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=661 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601020172
X-Authority-Analysis: v=2.4 cv=LL1rgZW9 c=1 sm=1 tr=0 ts=695817b8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=eq-GAw8BKwJPkKUly2MA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: 2LFxUJGNltDZvFAWFNgp-36HKuozjBE-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE3MSBTYWx0ZWRfX7is+9ouJs3I4
 L+Aedg3t2pp5wbPV1qBJsRCRusDjLf8ICorwuSNFutUUzVBJrAvXNevMSKejE373eT9qP61zVFs
 UF2XW1wfRGwEKASteokfA4/9VEaAt36yLtb7xi2M26D1YDggZI4rd2P1Cq9JCVWGty/0Ie4UfTD
 Qr2vloOcDqJ7Ysktk+u5LlsU2G99LdU76S6UMQKy4b3jKsFbvNTZI0cCigA+iOfPWESSqTtvTm5
 aLXyg692Slo3HGqkKPf/FKmGGlPVZlAA/oKXY/WNnECk8y/rVBM5aiobRTzlwLuxJ4Dg5Ze55k8
 ac0iGfHzs8Yh4Csu2u3iCdiVy4dT5NGO2p15PPUMR2s2HcrVqhwJbp29+tXxZChKYBV6sYGYm+y
 l5B5TUg8aMbyNEFWnwfQf527I4iOEUXmQCoiEUIEt2alye81YnPHXLFm+SpdpqGe81Fai63i5GB
 AD1pqKI/Xo1s6bWZBRTgRY+H+5SuAB5zG5TO2ni0=
X-Proofpoint-GUID: 2LFxUJGNltDZvFAWFNgp-36HKuozjBE-
X-Mailman-Approved-At: Sat, 03 Jan 2026 10:34:44 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 02, 2026 at 07:02:40PM +0000, Lorenzo Stoakes wrote:
> +cc literally everyone you should have cc'd in mm :/
>
> Hi Mikulas,
>
> You really need to check MAINTAINERS, you've sent a patch that changes mm/vma.c
> without cc'ing a single maintainer or reviewer of that file. I just happened to
> notice this by chance, even lei seemed to mess up the file query for some
> reason.

Ah yes, it's because this patch breaks the VMA userland tests.

You need to modify tools/testing/vma/vma_internal.h and rename signal_pending() to
fatal_signal_pending().

You can check it by going to the tools/testing/vma directory running make and
executing the vma executable.

This one I don't blame you for, there were meant to be CI tests for this in mm
but for some reason that's just not been done.

But this needs fixing. If this is being backported to all human history you
probably don't want to do that, but that leaves commits with broken tests in so
an alternative would be to add a patch that gets added before this one that adds
fatal_signal_pending() to vma_internal.h.

But not sure how feasible that is? Andrew?

Thanks.
