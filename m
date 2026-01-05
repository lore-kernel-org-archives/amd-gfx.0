Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FCCC47BC7
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 08:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DEB10E4BC;
	Tue,  6 Jan 2026 08:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="b4y4ZuiL";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RohWqLSN";
	dkim-atps=neutral
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A5C10E3FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 18:21:14 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 605I6KFp2488910; Mon, 5 Jan 2026 18:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=frkJXJZXErgAUVq/iW
 IufdMWgAtD8bQEaXi89XKDKOY=; b=b4y4ZuiLFzdB7rcyllSzV8YlefRvTlgwHd
 +U7qb6lGHjb8VBCbA1edERmY0kDzTDkGqvYj1t9FIroKlMZgBWU1zzBDYJ6kwy29
 Ew4jHPQLnncpKmY1GhJTFatzv77xLSCOx05y07FB6OVcNXowVqDvcQHEe2JLrGYc
 I4UE3IjsS1wXC+AC/3CHEcepogBOOE2/kGiU3eiBw2D808ASvyMDYHqVTkZE1irs
 MZ0X3ULd7wpEHjTNfSEnTT9lox7qQ1PAQyEd9fvwXGulH9yKvpkipolz8FNK2m5n
 gk7rkYPe/cWhDkZWvPBn44k53pRqHbjjdle5kuqUcS4Nfdz4ANkw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bgj9n00px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jan 2026 18:21:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 605GolhO026309; Mon, 5 Jan 2026 18:21:06 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4besjhx4uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Jan 2026 18:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiU7+lo71ZCnVLbVPSPzTgPnZXgTFAVGbEv3jSetHthXC5rHXbfMNaNzEKYQqbbfzrlebSRMJxdO5gE2n1MfVCdXCbQ72WEZ18vd/c/Gvp0hwpsiUo1hsOZIv7V2Sicej4PseX1CBhnqRC3k4yNmFIKLs6uVOHoi+VIylf6UXevQeLOTB/ixAKCyblMRLV2o3NLoHOJ+diT+RPeZo0ox3hTWmDTkH4pTx3U+xHTNXwDCd9uCrbHqXrmSm/B+1e83iAqrUMmOekvPE5ovi25bT7SozuoPHNQpOqHlcV/WHWgG+ZNEM8Y0qQIBMLp0Diamp78NIPNNTs583h29nf2/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frkJXJZXErgAUVq/iWIufdMWgAtD8bQEaXi89XKDKOY=;
 b=i3BL7OeUAZvTCNdyEryzC1sAV0bgBjDlElccE7KCnL7P0aKwlXr8dKc829RIyZV2yHsiVKIhLNp7+YMgcS0bGT8EgJZvS/X0EZb6HXhIHuyiXrGgwENfHUzDkmQkIjCQembTcN6Yg8xQACztwy90xDH7Mn5TbFPSXepbfgj7SEy0JAFVbttObQmuAnPOA7sIPeyHyml74i3V5fMqpY9iUBGc6V9dfYFPKBGdxiTNxQ0rwnWqmk0113zjMEdEVzP1uDPEFzJM6HfdVFaMLED9jdQ0ud1Mbd2eXtT5JJZkNPtvj0lQfVtLJfKTIR1UD8gIXLHb8PIPa1N1hi8a/6Yqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frkJXJZXErgAUVq/iWIufdMWgAtD8bQEaXi89XKDKOY=;
 b=RohWqLSNNlX618JOb7+RhBwc9rRseiWbnbSxAnCwRWjWi1eW4Qun+zVGmitGwQUUk711K83gLHP5zTPjRABLx909/7gnbE/Hh3J3iSJ8aMQqKvujrkg0qfkDjYWcb3Xt/tPtez3ypqLCLoV+0Ud6LWRid3rQUdC2EqNvug5+RlA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH0PR10MB4680.namprd10.prod.outlook.com (2603:10b6:510:3e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 18:20:52 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 18:20:52 +0000
Date: Mon, 5 Jan 2026 13:20:48 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, amd-gfx@lists.freedesktop.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v3 3/3] amdgpu: don't report an error if the process was
 killed
Message-ID: <vaq2ys4tsyggohbbypf6l2eobp22t47rtmgjl53zu7p2xgcezd@5wtd7q3wo5ng>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Mikulas Patocka <mpatocka@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Vlastimil Babka <vbabka@suse.cz>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <aca0147f-61be-30a3-eff5-cb981222aacc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aca0147f-61be-30a3-eff5-cb981222aacc@redhat.com>
User-Agent: NeoMutt/20250905
X-ClientProxiedBy: YT4P288CA0072.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH0PR10MB4680:EE_
X-MS-Office365-Filtering-Correlation-Id: 29105a67-f777-47d6-a597-08de4c87289a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oEZD2SxLzRrDSAQ6kEXPktOnqHQRdT+grqgUgYEdkhbmDZhfl8JYP1yOjU6u?=
 =?us-ascii?Q?OQHY8r0hyMyYLdUzw2YPb3CAvB9Jgdi9B54dXnIohTUkQLCBoVugvnP3qxOe?=
 =?us-ascii?Q?FFAYAiDNLZox6+yz6fR6I3vQ7gxx8YXCBfqMA2sBeNOoOmflqZ2ca2Xblauq?=
 =?us-ascii?Q?FmkCWSJh9l78E/3f8YC9vGVCJpTjLtkKsYxa2/8ZR9OaHnkv6g1ilaBI2sda?=
 =?us-ascii?Q?EFRrboNKp7ONvy6zIG0FbNtbVfmVRLsAEVhu3MOlmHVhvYOvYuSaSXZm8riS?=
 =?us-ascii?Q?6gnpKPYuOmXrVc56JfnkzsDWI7UXCESQVv0oSVykIVAUIEmrMo0JL1YMuXL1?=
 =?us-ascii?Q?pFQfHJnSBktGssaEmrTV74FSvVQTEt5zC/kg0P3FdB8lYePYPQwtljSZkk0Q?=
 =?us-ascii?Q?mlilweQsWAI7irMMQ975dHas6ZQd3g3PZ9UbfUQguDmYHa0z0TtNngMwQU6Y?=
 =?us-ascii?Q?op3/iQ39X7lNT5t37BFRvLZ19OguMPFS11FB13vbXA1Ak0KYfuo/PAJ/jd5N?=
 =?us-ascii?Q?+4HMekMXardYyVu1eYGeNhwO/pDVtnpz7YegzCLWS7eQ8oSgsiVdOTdzrxnv?=
 =?us-ascii?Q?dcAPuEGeqF/hS3shRyGBbWbiq7uv1JaFBEGAnHYDLc/kZTpGT9utIzdxQwST?=
 =?us-ascii?Q?xui+d8fqhwGIoMFslCXcgkbmetJpxZLtjl8vIpg9t2cdoVHgMdNRngOohSJC?=
 =?us-ascii?Q?UZmCtKZd+sjqPPQdVTPqOgN9u+TjL4Vr2vjqS5v9vyHxAHuEPDEZ1t7vhXZZ?=
 =?us-ascii?Q?zV7p36odaZmd5QsRCzjtmqoGLoQYNGDnzCWT39uFK4pQGuIgCuOVdviXiUsB?=
 =?us-ascii?Q?w80olKhr674EQeL3wR6LlF+JEX/Jf2cgo2YmfU1LjAFuMldg7/miTeNrjBpU?=
 =?us-ascii?Q?jsCsN6j6jUbgCCoarWpwogIX1Lwx7/Kcf/C5j2Be2DMmR4eeNLVT5ehPHQqk?=
 =?us-ascii?Q?F9WUbaKYCsM+ltqSP/5aPX4sfbIwOMwdaUPCP9C5yTv/N5PPvEX064pvoi+c?=
 =?us-ascii?Q?gFQvFWmM86YouY9Sx74cILXCRVG10bPj3nY6GjyAmrG6FUefBQCK+Q0/ULYJ?=
 =?us-ascii?Q?icLH82juQX4xEoHI+Ix+8HgIAxprmrPhzks8ENzXWywUUeb+lvVUGd2+MloX?=
 =?us-ascii?Q?JXG8KumTfjXPLXKYO7l09ULOum8RBGEPtoq5b9OynmZoqAPfHByDVu9WTdy8?=
 =?us-ascii?Q?WBgKdmwcRRvWREY1rJdW8qI0Hrz2FGFRXKaU0DlDMcCtJ+HyyxkddVhVg79b?=
 =?us-ascii?Q?vmLhOSgXR97q+6OWT+FIFXwjJpDoGb5oVoBzdeGPoORS9mJ93imixNblNwvs?=
 =?us-ascii?Q?Z4FJi6Ghl7ynJi+3DX1sg8EZl7JtSBaFNXHVtXY9q8ElOp9lubdHMUqrmq4t?=
 =?us-ascii?Q?u3YxQxvfRGs5mX2CRRKu09U6/A+xFdPNYuA6vBQC0K3EKgCNAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5777.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mSBYbMtkVea41waCxE05UnUfoJ3piELqDP8fUIm/XnvKT/lHKSpa77FdHMx?=
 =?us-ascii?Q?oKLvTIe7/R78goDQ9nFqdAodmApAxO3dINhVY7Tldtfw+Dq2ITehLfN0A69/?=
 =?us-ascii?Q?Z88CEMUX6uD+TyV/so5jlUOs9kUUF91k7I18OG18HZbI36FVSMmDbyWMZzGG?=
 =?us-ascii?Q?8QQt4PCial1+xVRIydjraq+NkSzIRyVItaVL+7f2N9uyMBApqdzZn7lzopTv?=
 =?us-ascii?Q?pD+J9YIGXhql39MyKulTKcPrC/XjuMZYjY5FtHi279C50tYngTBH2KrUr4S+?=
 =?us-ascii?Q?Tq3QOucjEW0ciafEPUIlwsRgALOclgnaTzNbtAA7IGadipuKxd8e0A9MeQmz?=
 =?us-ascii?Q?aaagq65SNE6lKSdtFjdIe8mpkWgyf2jIAivz+C0hcH1731o3OKGJjsKlfgfn?=
 =?us-ascii?Q?8kt+Zh1Q2eSgARAwwrVOIGgoo3k0EUWJXU68kXAdhVQb7PdBagY1BSQ+rx/3?=
 =?us-ascii?Q?Sj5hVvb0QbORvfuSXqZvjCk8E/k7xeT+Fx+YZPXgNxjdulNz3M8PgVRVKeV0?=
 =?us-ascii?Q?X7zAROP1pa1sCArjCNsHa3efPuiXm6FFS4M88+wnGFHaL1BlvaK4xowN/klp?=
 =?us-ascii?Q?gUtKm18tNuGZKeFaMHGFDqDT/zr6V180D1S1lV2QiWvtZba1GRhMeTf+pEPs?=
 =?us-ascii?Q?81tyCZ67Gblnlo+cE0yAe/6Xg0gCdlMnYX0X0BynN1xYGaNcar+nW4vOPboI?=
 =?us-ascii?Q?Sve8zdi205fAO5ETIlhII9QDN95pdtOk33fB2nfXlqdiM11Ka6SJ0goyDAwy?=
 =?us-ascii?Q?oVdmhBgoUfyjBf4BKgbQ+I8W9nTF74D9zrR7GvweMqcy4MMEE654RCfTUpFa?=
 =?us-ascii?Q?OdC5wd7ADNvEpZe696IwI3WZxqL8LfnkB9KBaMeKIqUt4kJUZigvRY08WDgS?=
 =?us-ascii?Q?nhxttYhZ6RvEJv/Reu2QNICl7rnJpg1WDFu8a6oemxfrrXBlRQtdekz9FNa6?=
 =?us-ascii?Q?X+ho5J6s9dF8WRfPgb96ZSiMC5/+vZ/Lrdc2sbMIs5AThgXFCB0S/jYZTGuC?=
 =?us-ascii?Q?dnQjvuPiq1v9UOFsdU3gLO5vQwVwxWDdj7Pz/zbYVxgbIpJrhPfuQKYbwQv4?=
 =?us-ascii?Q?vy2bwbCq7kyg52vaRTQhnj3slHT4Y1y72KhPhyWEZQe8N+vlS3RRt43dIZao?=
 =?us-ascii?Q?0LWfYZD+PESN31KeR+7lAsC152p5/xaaRmOHOqRCFFfOF3C12gD7CWQEcg8e?=
 =?us-ascii?Q?CCYRgEyeX5dv29zFaiVZDxhalQqU+pxcBT5Rt1+hn0xLIXlRGMV6hHJyJITz?=
 =?us-ascii?Q?/kXQLAJYn+hyjJktjum8dbrjCx8SmcUOQODRNVAX+953fd1sN0EMN8Tm9V5R?=
 =?us-ascii?Q?PlpQFXx96wVAiFwU+OsI9KX9AMDcyzd+8b13bIrJ7AJZpHt2PjYck8D3phNk?=
 =?us-ascii?Q?n1MC72p271iX3DlZR7jHzd7WHHzSvO2SUduWcc9U3Gn45yPduesosx9SErTh?=
 =?us-ascii?Q?xoeVYCM9J5JKlQSLcJOGKgVay/qJmzslIn+kQwCk7V47AVZhbYeod6ACiihc?=
 =?us-ascii?Q?5w+3K3O/lSDkOobCphtLPU/nGDih4sZtN9ZVLuhTcaeMSna8CSh8dYOIgBOu?=
 =?us-ascii?Q?Dp0Ej6/5OEWkyr6GCnAiQuGcnea41d2X2DMN5/GqAZHKTMpWUalJCHznupcc?=
 =?us-ascii?Q?cpBB9Yu5GgJYt+PD04Z7o58YdLMMpRcmgY5yolR5c8a/HpFGpOMT1HHmg2bw?=
 =?us-ascii?Q?kDaM7qc+ltf8pMpa/JuTXr1xqQzQvh5buWXyceCEEC8sx6cgL1EgXiS16UFb?=
 =?us-ascii?Q?l9ueOu8+Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CLgk3HSkxPB9A+MMk7QH4NCcvy8Xfipg7O85Fhwav9lsb39sliC87hApy0xbVNzvCu/x31qJyMAJqfSi8wxzsuI+7djlsNS9e4GsGiCPIwkpKfrETvLInXWKuVv46DHyD5I2VgNJIVqXrkGxqotpbXmLy15XkOT7ZSNzk5T2xIklkGX31P5p8u1cp1XAwpPp96fzoFjS15RmhqYulnvhZUsCZx4fK8DhwulQKhfKKMODfx51e2h5i1tt2dUsXy/S+jQTRPZgXhTZOzpIXbGRAR6V82VizHSkmM5CUWAUa6BRmzMJlnw6RoT5rwhmmLpqbtYXqQxAZ0IPMkyjlnJIzQs39rRS4qP4C30axWGQt2S47/TGBNFla39I5khton2QHaWzUlqL5/itAov8kuCE3gydvaTMUZTMzjIMMK9yZVADJl2tXOgvd4QHiy56A9r4v8JOq8jPk8YH7t417GXNi5s+12uk0t4TPPMn5btmwATLCevicKuPta8fAeBEYaRrepdi3fG3zWfrPibW9/JKRW82BGlYAaQISGOSpZoAHY7fv9RKjKcFmAK3hbSFk8WxmgilcqYTBije/jsrcEGCBAfiLa83YvtCkR3mfnBmnKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29105a67-f777-47d6-a597-08de4c87289a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 18:20:51.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C8rd4I91tqyKh+D+H84FIzNqVAoL+W+zcNxrC4ntxadQw/fTDKuUAAsaJ/OA7oUaiQyi7S3BFaWWSc49xtU/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050159
X-Proofpoint-GUID: qFq3FC0d3ii4TUzDbNVsJSKbRxu0ndNG
X-Authority-Analysis: v=2.4 cv=CZgFJbrl c=1 sm=1 tr=0 ts=695c0112 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=95lX09yStPcFndA2:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=3trtME2BrhobO9Jhy8EA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE2MCBTYWx0ZWRfX9xFa2VvaKyIQ
 7yNnUdwYRxKpOW7PekeVUv/mOWDDm+PAn5J0RAVW9nbuyZRuBIYSzbE8hnAkHwaAjJfxP49uBzL
 Vw7h7UxlRy8pt2RvSMShlY+vYbLcPb2yaQGRBJm7sllXr7zgfVOlLfoyAUk9kHVHHh7aP52JDqV
 ibGT4VI7X5Swt+mB8km4lTZ2byZTv1CINVZFmX7tiLYmD3yrJqbJ9iuIM+BmRIPWoMGPLBXk5+R
 X7+BeMpmk4OR2BlyC381WQjNXsNArcM8r1STPUDxMeauVVky8DO09EIjDIKrZafRGE/+gZiDygm
 yCkmsIOAsmEEuvxkKnXHFH2D2fp976ri4kn5NUiJ/cLIXd9VgSIKgJikchFa6KSa23Eap+AyCBv
 ft8j20ygToV26KaAhxtqvp3eqQtxXLIeTAlpKyyWy6N0+/svIKu/zFjVQledxiZJDIJ2lX+5mYZ
 JJPAEjHG85YMnh8o7Wt272xN1VMOd/4XFluo74Ek=
X-Proofpoint-ORIG-GUID: qFq3FC0d3ii4TUzDbNVsJSKbRxu0ndNG
X-Mailman-Approved-At: Tue, 06 Jan 2026 08:31:34 +0000
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

* Mikulas Patocka <mpatocka@redhat.com> [260104 16:18]:
> If the process was killed by a fatal signal, amdgpu_hmm_register could
> return -EINTR (the -EINTR comes from mm_take_all_locks).
> 
> Don't log the error in this case, because no error happened.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: mm/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> ===================================================================
> --- mm.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c	2026-01-04 21:19:14.000000000 +0100
> +++ mm/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c	2026-01-04 21:19:14.000000000 +0100
> @@ -1070,8 +1070,13 @@ static int init_user_pages(struct kgd_me
>  
>  	ret = amdgpu_hmm_register(bo, user_addr);
>  	if (ret) {
> -		pr_err("%s: Failed to register MMU notifier: %d\n",
> -		       __func__, ret);
> +		/*
> +		 * If we got EINTR because the process was killed, don't report
> +		 * it, because no error happened.
> +		 */
> +		if (!(fatal_signal_pending(current) && ret == -EINTR))
> +			pr_err("%s: Failed to register MMU notifier: %d\n",
> +			       __func__, ret);

Masking off error messages will make the message less useful and harder
to debug.

You could also change the log level, which might be more desirable for a
whole lot of the messages in here?

Thanks,
Liam
