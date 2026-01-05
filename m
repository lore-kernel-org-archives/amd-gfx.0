Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F533C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 14:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A4710E3F5;
	Mon,  5 Jan 2026 14:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="BvwiKU+s";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LhC2xzc9";
	dkim-atps=neutral
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DBB10E1F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 12:19:12 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 604Nd65e157703; Mon, 5 Jan 2026 12:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=ykMwjwJC3Qu+BB1OGY
 Bjrg2KuTwafSB/y6qtWqR+yag=; b=BvwiKU+sumDM8O4GoJsgwRGTT6Gk2Fq/Fl
 jIY2gAJVlGD7ljV5o+oLN/Ih1uKXT5XcCB70acv64UoZ2njD7oysb5X/4brfG0Mr
 dEabz8MM23A5PeoioFEMMU4SR+48YLF/v8BaxN95y/oez9TJP1VsPQUZ/mvAXzZf
 H3IxTBMHVQY5albRK+sPVOzYRCsRt9mpLzQcth66x8x0f2+hsluFtwj9KniaWIov
 n89zPSJf+nsVu8cc7l9wEULeNTyVJRlcdBSBqdufeHA2biLdfyqg+aYFZlYV+nW3
 VKt2Int3oraqNwmPnwT1FILlBuhsjvNikDXnPhi3Asr6sE+xVzpg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37smxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jan 2026 12:19:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 605AAn9F034090; Mon, 5 Jan 2026 12:19:04 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4besj7aq3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jan 2026 12:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8uup2LK97VbRgEC/dEtrdFksMvLKFGnhrrAfui3Y5B+ubryurjD+5H9LpSDTiQmWoHPlTuIirIwIXMaEV23p1Ys96e4Qita/wGwhdKPdhdKInUfbr0PMlgDbrD1yybeTa2xeVcSJhTp3eNyl+GkFgFV+gTEEV2IyXQMWGhQDc8FV5WY/xAL7abZgT9ELT81OT5y79eddCPNnaBSSqgJd7oVzSwDHTwW4DXP1mok9oZEF0q5f+NL94/mvCUnOyCPLo9BUTNSX4zM9Kize7lgRhtjQbiPDolLo0+5aO2uVsjFsQrWuDmuSYC40b4SyXf5e5IK9wIjgvHgWkUHnrRQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykMwjwJC3Qu+BB1OGYBjrg2KuTwafSB/y6qtWqR+yag=;
 b=muEb/X1TAsPbO/W/+h5kZ9dWnJBBjm8tenpS7Jqod6OVML+I501QCc5cyd5pQVn6Us85ZAIJ7QLATOJAyaN99eTW/+i5+gBFH0zG/fK6zla7a5P7ujNBenju7QXyh4GNsNUBZKCjtnclGhS3qu/laCQCgzs7ReklyNF/HRnccu32VKlPiRBeWrBnTcS/Gq1Z2AMuaGjA1Albll1GdQurN9CW2C3saErEImgXJ40ho79LQEyNn7EuvUTmC0ZwDwEKqP4U6FVTxOga8hMxrhQkm8Lb0Qu4QdtBVLx+BaPabA6UNCAwsEXzG3pGGriKjnSLrnMD1gktmXGuDNS3PnTpDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykMwjwJC3Qu+BB1OGYBjrg2KuTwafSB/y6qtWqR+yag=;
 b=LhC2xzc9uG0jv0doRupajshFfENPiyOVrpnlksjQFHjJ9lC9LmXiLfR/m5civOcpO374/vfoqyVhpCGVOKRKSsf3465eDCbHokBe1Vyi/SWP7XgVXnMVcUDb2TyyqE17iIljY3if7w0GaGY6wVXvHY9ImcMJSKtgiMrcqz3Dluw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8375.namprd10.prod.outlook.com (2603:10b6:208:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 12:18:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 12:18:56 +0000
Date: Mon, 5 Jan 2026 12:18:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 1/3] tools/testing/vma/vma_internal.h: provide
 fatal_signal_pending
Message-ID: <18f7f4ff-67f8-4a39-b6c4-893bfbed4955@lucifer.local>
References: <45dd9b02-7867-6e5a-4a64-02c4d43c9b68@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45dd9b02-7867-6e5a-4a64-02c4d43c9b68@redhat.com>
X-ClientProxiedBy: LO4P123CA0492.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 3886e56f-7486-48c0-5f15-08de4c549948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fdCrVmZkTquw7DXDcGPoPyLZh5Jr9ui3EoofA4YBDxxrZ5QyA/gL2zCJFvIF?=
 =?us-ascii?Q?BwLZ0H/CBb+lYcp5+fYkEun31fIYn649iOFeTdmmTygImMwNayfSy3a37/TM?=
 =?us-ascii?Q?xmk7/kdxw6dApBAaukR9nvXlVl0UQGmouI/yzy7feyk5Y5yzi5yZMkzHstXU?=
 =?us-ascii?Q?/nUZvHX6OY8Gbj6wTe4a6rh7TN6GqgdjfiLegZAVbdmn36VHJPtzCLJNtSnL?=
 =?us-ascii?Q?TfTo3tuA6HxJFZzEznmVmOTwwV/d6OQaXZfVHZV6me5fOi+A6klMahKxWme9?=
 =?us-ascii?Q?DYgr3lN9X4KV5LhcfGzQhIL+Rzh/K4I/JmfDMvrkn5RV49w0CO0CaTULaIT5?=
 =?us-ascii?Q?LpZ0wv7lC2HZ3UyaczlZZmAqC3ZRY0he+MQczL27siGGILgElGH9jZ7Nvseb?=
 =?us-ascii?Q?GPUY7PUzP8zYuKxrSp7OhvozxJfYstz8ap22L3aiiP1HwJD31hKREfMjsA0r?=
 =?us-ascii?Q?HPAhkx/m5Bctp996k3sNLZU6bKepwQDnQdffAw8W8opv8uDVYWSG5obSxkeF?=
 =?us-ascii?Q?E+wGf1iUdcrxsugCeC/6rJqBSRtOqSRvKYgQIr8LW/o/W2vjO64xP2JcvJu7?=
 =?us-ascii?Q?Sb5q0jql+dQVe8Lxa4euBZWUIE/z98HZu5SwOFcy5iixEc4PgpH8/bFH4P4K?=
 =?us-ascii?Q?as6ugCNSCdFUpmbP+FNxV6owA4Ds0UFQ2n6asvJctxkCJgqGrWdQZtzjIYmg?=
 =?us-ascii?Q?dJ99N3GKct+AS5bgWmQhhsBz9YccEMgSNCEYFCq9FJEFuFHTEg3kc1xiCuFi?=
 =?us-ascii?Q?dRHFnSi9iibhEShsOsSxQzteWiwxbq0tRx2PUFCcX8zPWAhPUXPj9SEfxu4M?=
 =?us-ascii?Q?ag9mSE6VQDxeJDZ9dGm9f4yitCkLOsGXDJT3FJWl9J7Xjq7g/5qDPpE5z2lx?=
 =?us-ascii?Q?2H9ADBhi2M0DpinmKKRAnYPGU2qjAaBNdXugiPgodJ1/wOD1Lqe7WiwaUQYL?=
 =?us-ascii?Q?8TdoH832gm6M86+hmDluNRDd+wUZI1o6GprW8lpOtazZRFDguvAb1gysm5q7?=
 =?us-ascii?Q?IFAO1si5bqGT9QrA+f3KZ4JUzB3c10To+f+HcOM20NfqG39VhLl+l+XJusUA?=
 =?us-ascii?Q?TsiJy/yD4Q60TUrIj0LhKO6tJkyidiYorzR0EMOTtFcHcICNe68rrzYG7H4t?=
 =?us-ascii?Q?GdSkQ92bE/JTO7EadhdTSRF1cUMbMttDkk2OrYn72gzqKvzKBB34IXZx7Q+8?=
 =?us-ascii?Q?TMzu0QT8Vwy20c1OKZoNNWGTZK/i32Ofqm8hBw/imHxJmWXmtxlDXWPJ/th5?=
 =?us-ascii?Q?JnNengxG+ly5Tm4bQBhw2yCBCBxpPZfXRjhfq7CcQufoLjceKeCR5lsFgi4V?=
 =?us-ascii?Q?GgEcQ86dRIzgZFSjjPlu0HY0gX0iwcCMbmFiX63K2ckXMdHYKCkf97+v6+y3?=
 =?us-ascii?Q?KHbI7Q5UJnA63h3lA6Zem33XV58BZisFri6f0UwXoLSSnQIwCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR10MB8218.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQFOBdoRHoIc/5RuQNUZicvnZGjZgMn6kRS3VNedVic8G9Hg5iEE2saKXnVa?=
 =?us-ascii?Q?5G2SheQFzPmqEHNc81yWmiunk/6XVZ38rN1rnG5XhqgISHVzhWo8UsmpTVsD?=
 =?us-ascii?Q?JDNoHZ75qXqCIFJXqgqbWTHVGHsJEI3uHYwy79juJWm7c/i97lWZa7O71y/m?=
 =?us-ascii?Q?fDeXHlYSJSvxPe77DcYp3aFELyDLyv8uhOZ5VmbNUgczGC/C5ogTa2JNUwI2?=
 =?us-ascii?Q?8gIYpIcc6lQ1lDqp6+xncixCZ/X1zuYphvD51BMXP1b1KsJMmCckxojzFuSA?=
 =?us-ascii?Q?qzB7X68Qii5qM8n+3nECkSIHmKq2nVWxpnOVJemAByDLJmA87XwVFpHU/YAm?=
 =?us-ascii?Q?FTtjJGSpgV0k+Y4qUPiWn0AMiUtbXoRKb5xy22Z2sJzZIkwWs7J+gE63iGll?=
 =?us-ascii?Q?kaV4Xb75MjVTfyxNNOYEdHo7r7QNZmBasYjIeYNyv5pkOkd32xtCJjHNPzeH?=
 =?us-ascii?Q?xeBRlNyt6gXK/4+WUbGkU8F/44w703dyt9Z1db4u78z8aeHPWJ2nZN4lhegM?=
 =?us-ascii?Q?goyVBpV7VLmdt8LEO4cOoj6BybgAqUxLwoyOW42t6txD26YNIjZT9pTpWhgB?=
 =?us-ascii?Q?vFiI/ZpKiCR6PRUyhxJq2/4PWZbplCKbQYQwHsq/KsrWyF/sv8IcIdjJAYc2?=
 =?us-ascii?Q?fRZ7oiI+vBJKOHasw29gd/OjMhbz5cFrvKLSIh4co37nVSCpU9tDLDeomYPN?=
 =?us-ascii?Q?wArUCjI5evbYilYTXxRQFEc3vYsGjDOuYO/U250GqGqx5ZTPwFzjpqx5u4kM?=
 =?us-ascii?Q?d65yOGTUS6uk/GKOCuKbTEZ/cJdOFIfXZRDp+r2FKaYukqqSlXm7LTGUV3Tx?=
 =?us-ascii?Q?Y472lR72KS9hUVg+ktjYG0MCMf7hVcqItPK9Nb4dJTrDy3hX7Bh36J9yt7GA?=
 =?us-ascii?Q?OJ305Ubkeqqo3UxmWzjIXA6uEWg6Vbtjjt2GkqO1D3Tk7SUqD7wwuKU9/I83?=
 =?us-ascii?Q?P/OsX9OmbcEKi5kIt6x8YTPOzU3wmAyUqRgNLoO765P70lFv7l1i5URELCUV?=
 =?us-ascii?Q?P4bp5i71E0ESYhF6LlZ6Lex/E5LdAEP8FqLLSgt4afJZeTI/G0Z6z5xzphHS?=
 =?us-ascii?Q?qdvhfRaRdKzN//CC1eNmeRIwabU3DWCimmtOHK5f5EImyuh4JpeRe5nkuFc0?=
 =?us-ascii?Q?9ib5lc8wN+g2YO9pJxep+F/94jqrvkdsgEvqq0UzMbdcILuGHE2Etx2Sj7rE?=
 =?us-ascii?Q?2qUohmwav3nrSCzssodPLntQewCtd93+KfyQfmv3E2h8HOUsNW4M8KX4v/Uu?=
 =?us-ascii?Q?cKD52Eobn4eORLfIwWbg24qWLzxGjTOfrO77UXmhIu2AwBrpUp0IHHrp0Uwp?=
 =?us-ascii?Q?rHEgzUECqpTM1xy/gxnSva4G4JDphZfcrc3qXSdnomxRmOTAdZZ9JbZMuXjD?=
 =?us-ascii?Q?zq22wRHpOHiNFlR35sAO1y43c89s+JRQWhfs0YHqI6kh1hGBzPajcVtb1e+P?=
 =?us-ascii?Q?a9G/0Jhly6FeL7wPXpTzpARu3xttqzl27DLxw71I2Vgi2OQ6gnYG+Bl5aQ0I?=
 =?us-ascii?Q?Pu8/ixVQn9I2tWTy2gdKZvpAgisM2LX5LZM+bYC+nrz53nM42dHxe0YnC6KI?=
 =?us-ascii?Q?4nF2GIp9dvxSJNyfRAHmxLU5+n8DjAzq0c5sjDEaVkk2XH5k0RU/Wv/dUza4?=
 =?us-ascii?Q?o0Ut9q+0CFJ03dRKezSUxWy0OfuleWjKErtSXeaRivZeZ1BfBchoh1hzn26f?=
 =?us-ascii?Q?IEg28IKnNExLAFcFwKvJ1sBFDhN0QLHrrdVr68sZooZrm3q93SmvKfkXHNnz?=
 =?us-ascii?Q?EiFWCZQrsj6tWb5BlSUCSIwImMuTq10=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5nHU/GN/urZAoXSPQulenoJ0/biogpaAFxiRvg9OPu69PUmLbwDC1Y29oBAjQ10WotncP8RZl5wnXPiKSltM1tqibSoTp0UhNWTqQHGkZhpI7gF8aIlTwsONkUbLg+fxZBa5maUonidOrw3fAvOn2yi+XJBbn1k6SdEdNVjjX0QhfBOXbDx3zfCNMQ2zpJBF4HWEHBWy6pGuuEPDsBTEHDiZzBrjokVM15vywEzDz038PbfeosVRSR+aMafEnuUh6vdbp2fRMsrWsb+hv1E5RD1PHcsLZPEUUFrucLMm0xfmgyDqnh35RmQRcdi0P6jcw6ubOti8WpoxxDvkTAAwPbW+Nt8Y1nfPv8dF4AWnj8dTRYzsWkvnd3EDlyolhQA2fgAmjjck90OEj1+nJqO1o0q8RscglupkwV/NJzkhgrtDMEMU3d3H+1g0or8/d8OFjFZEHDjZw14IELT3y4Hvcsw5/UvQUK4FwipG2kKdr0V9hYadJwwOCsMePtW6bdmAYs9+uGBgKPA+HkEqgDtZ3QrNXzKDUtAMTR9kXHYfH2a8TeYu89W7qIR/l2sGwJSUiQ7uvUIOQg+UxiSC6v2QWqBHQaUk/wCKOlOrsWjq+wI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3886e56f-7486-48c0-5f15-08de4c549948
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 12:18:56.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TExdozqUf/Kp5MYo+8jsCRKbXehfgnZKTvVgx8amfSLDwb3eYSFvSGw5MieBeg31ewcYjt7xQqE9ZLJJAPJQPRCUji/XnmGjFVzBD5Xdp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8375
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEwOCBTYWx0ZWRfX/drP0OIZnBqh
 64ugoMVrlTnxz1P0XKaSOVsiO4+9EYS4hkE/bSVrI57mAkq7a+MFJUDsWCfmL7NcHzLQKbR1WRd
 w1OWa4WknsE1EEiPRswXV88gDikvv2YG3uFNZS7HD9dpzhc0FVe98Zrhz1Oe6+mo3kpQblyt8L+
 trzlYr75doQuYjgBh9SICX9rHvDi955U2UdGLEhsVZzDBckiMQ4p2Ota3wBeEV72e9nRIPrTtcP
 3fm/AGwbnse8oIyIAPZMjrmg/7OksFV4D/VLWiZsBLmseMgBF/gL1HbyXQfAhhgVA2AdqFYc3i+
 1HWnITYJOTscCCyzOc//9nptsNM6MzdYlUG7ctfwaoSOqGeNwL+ObdxpGs8S4P+elq26au9+FGe
 Ej8nX2//d88kZsrHsrJoFUWTvHMVwhfHFmFmZE+5Hplnv954UOO0bLFmc3x2uR/hPQV7efUkfsQ
 M47NnvGhNdhiNcFcQWw==
X-Proofpoint-GUID: suAxbry7Y61xfn89XwAHAgkMWj8CCeUF
X-Proofpoint-ORIG-GUID: suAxbry7Y61xfn89XwAHAgkMWj8CCeUF
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695bac39 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=slH8TumjlGNA0yKjmfwA:9 a=CjuIK1q_8ugA:10
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:09:31 +0000
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

On Sun, Jan 04, 2026 at 10:15:36PM +0100, Mikulas Patocka wrote:
> Provide a dummy function fatal_signal_pending, because it will be used in
> the following patch in the function mm_take_all_locks.
>
> This commit avoids a test failure when the following patch will be apllied.
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

No, please don't cc stable. Also don't cc stable without a Fixes tag.

This isn't backportable given you now need to backport to 5.10, 5.15, 6.1, 6.6,
6.12, 6.17.

I'm not sure how Andrew deals with a mix of Cc: stable and not-cc-stable patches
in a series, think he generally doesn't like, but I'm not sure how exactly we
are supposed to express order here otherwise. Andrew?

>
> ---
>  tools/testing/vma/vma_internal.h |    5 +++++
>  1 file changed, 5 insertions(+)
>
> Index: mm/tools/testing/vma/vma_internal.h
> ===================================================================
> --- mm.orig/tools/testing/vma/vma_internal.h	2026-01-04 21:19:10.000000000 +0100
> +++ mm/tools/testing/vma/vma_internal.h	2026-01-04 21:19:10.000000000 +0100
> @@ -1364,6 +1364,11 @@ static inline bool signal_pending(void *
>  	return false;
>  }
>
> +static inline bool fatal_signal_pending(void *p)
> +{
> +	return false;
> +}
> +
>  static inline bool is_file_hugepages(struct file *file)
>  {
>  	return false;
>
>

Thanks, Lorenzo
