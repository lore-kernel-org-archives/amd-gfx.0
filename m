Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630ABD232E4
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 17:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEE010E24B;
	Sat, 10 Jan 2026 17:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="YVMMaTx9";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TCTdLjG6";
	dkim-atps=neutral
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC7410E8DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:26:55 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 609CfG3P2675804; Fri, 9 Jan 2026 14:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=ignBIy1qF59AzOvNj9
 MJ+7fPnfApHscvW1n6bGXLXI0=; b=YVMMaTx9Fnx71NpVtGZwUjLv3B/yGjUJ0X
 8scsykXx8LZQOCyI+LxIYzPmhVDJaes/l/KB/YwnXH+RiYVFEnmOyFX+y0ovM+hp
 zzX6h9UiQ/ewvxzSgCGsIlAUvTrIdGXA/pONUh/sbBOJWqERK04LJPztetmemwvm
 LbYtTkJzscRkIN+VZn12Ow9VcYFWQFmfPLQAvY4ETKqQhq+TFkI6m/4DKIzfJcbq
 WCeUnqUr2ONH3O+Tq9YYUiOPLEL3fA+lC8KLxEA4HQf1Dtz4hV+AUbbRB+SGILeZ
 7sNO2bElsDVEmwqEgpPSqbi7UKtIVB2o4/kACHtB6iqsthhUwCyw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk1w784p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jan 2026 14:26:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 609DFdcd026370; Fri, 9 Jan 2026 14:26:45 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4besjppkta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jan 2026 14:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI9SPrXhtf8FwveJlLYILepB6p7+fJ9WvuTJcntEaqVA1wI/lVGfbuCAgrgJEdZrDS+Tbpf/EUqDbM3hCyL4cYIQu67Mpwr+LXZb3HjXI113gcsTp8L8ARb23Za8rA1S2Cwh8KfRjVzeNkMvXUb762jYLkbPezF9CpVWi1mX4GLEsn5imMr0XlITCI6ta5BlsDr4CC8Ui5/dFUVxkK0J18zmQgmoC+ydntZihCkTUwKVXMplE7Yi+8tG3UBtZ8Vgr0Fw8UlZwMUNUe6aH2Y9NZRK8se2OL6Jf3GSi7KUCr+uRdhrp+rMYUEOgY2N6oidN0qFgKNo2TBGdHY5ij6wow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ignBIy1qF59AzOvNj9MJ+7fPnfApHscvW1n6bGXLXI0=;
 b=XvNXUkIdQzlIWUShbuj02FgtrjeK2V5al8rYQNlm9fgCRw4O2fOxip0l5mg8mNYV+xf42T8N0ZKcDYHJD9POTrTpNDpM6yyV5Hh5PltGJk2bRtHFZEJweqKJJ3YHikFHm1N0Z/XMHn7xz6J37GSsuIv/3o+Jk4fD0KxlOhJSeJmlZRyYricuJUfOXdHfqY2swoRWdEfy61IGm6hu1DQvSSe3zcf2mGd6diesSTQ9xBUpiaFSA4ZEvNXY5ozMnG+ac5wUYnII52bY3kQ5Zk1uR8Kqgj+nLBoLbmo1H2RY49NVQNGwxaaZWqOXMaIoi5FN8nEVdQrQp3tuIRXVY9M7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ignBIy1qF59AzOvNj9MJ+7fPnfApHscvW1n6bGXLXI0=;
 b=TCTdLjG66SdcHcpNIE90bNc/4XnVhBdKSXEGoFE/5bIkDQTPY3G5sy0v2n6laPX51eAQiFEIO0/DCCyyEvlD9QWAuqZ8aPlub4f0FYbP+C4MEBK0wqcZwI25ygHxwcDvySAsj5zqys5J+YYELOzSw/qozupD0mLwaeOgtQ4x/BA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 14:26:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:26:43 +0000
Date: Fri, 9 Jan 2026 14:26:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: Finding mm patches to review before those are pulled into the
 mainline (was "Re: [PATCH v2] fix AMDGPU failure with periodic signal")
Message-ID: <674d9cc4-1e4b-4f2f-b5d5-809915728270@lucifer.local>
References: <20260108062637.82125-1-sj@kernel.org>
 <746bd1ff-b3fd-459e-b491-c62b160a956f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <746bd1ff-b3fd-459e-b491-c62b160a956f@kernel.org>
X-ClientProxiedBy: LO3P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fca101-bd4d-4012-deff-08de4f8b1ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ekf2m82+lKEJvi8QmSDYq/bzjnS6QbWE6OQHblhdA13GAdzEyf5uBi5A2Hfj?=
 =?us-ascii?Q?LdeEGL6k+UxNB1LRE23XYgm2mT1CbGmeXWBNHNyiiHTKS4jGpEPMFWl+cz5C?=
 =?us-ascii?Q?4QC1v/1496tkSMjtb8PJ+lmAqczjt2PypqVjoGDYA9BAJe4CXiOUldCyedCF?=
 =?us-ascii?Q?ydpNaFG+/dmg+eC4sIwd1yTlzlZFKEf15ODt1pW6ItlRR5zlRuaniLifDkyK?=
 =?us-ascii?Q?Y1GdP4J/jatx/L5FbvmM0BKVtPgO35gxDn26RaJpBYOzA+fBCsPEylNBINxE?=
 =?us-ascii?Q?6jiKNZJy3H1w78juNkQ94/8j2jznhwvaRzui/z2ubiXBpCPkMyBCOzIO7BV9?=
 =?us-ascii?Q?EgUo4H+PlRpWx2jdc/V+DBdC7k5adyQvsYmmtU3vXsVPGHdNldAoNyx7ghfG?=
 =?us-ascii?Q?Lg+cA+0q14cGPAxGXdmIG+G/DuPA5qRgxw86L9VyE19cx0rXnlKlZThvM07C?=
 =?us-ascii?Q?YK0KkqKHYiuxLbPN9/rffthefDgzMjl+ji0KQlupjVapF4A5qg0jLYcO2xrU?=
 =?us-ascii?Q?sglnZTj7S/5yNAUYJCi+uJ7ycP0KCwmC505+s3Z9XKhrZghd1s8xQ1+jG3UT?=
 =?us-ascii?Q?3ywRua2jQ4kOFroAX7oHPCC8JAMR6lvMzSuHH5/T8kSHp6rTqnDe1r8Rps8s?=
 =?us-ascii?Q?ewIxA2uXzVRe5ImzuwCu+05uybyhn/NGYDnQnxWb+5FatgFx/n2xI1fQ6GGQ?=
 =?us-ascii?Q?wgMipxo62zv5p59846PnS7RuylKm15Qchu7GcT0fYqDtzKL85K6424gzV067?=
 =?us-ascii?Q?lNNsnNuLqXWDY+A6PdBcMbSS2PuHgLAFyZ85gJWaduxt/JomiDRapZ0kLooO?=
 =?us-ascii?Q?AZRAeYTBKJ/CPhvP78P4wJARwueoSqLBp20zxQfJevD3lQiq8CQOxoNhSYBo?=
 =?us-ascii?Q?vDstB82+/k/9hg8dXTaYR3WeATXD9K7cUk7Oniyi8vmTeDTSYUujTAh2/RH7?=
 =?us-ascii?Q?UaNpvD8RRU9stzQhG+L39P4vbp/DOx5z1jsSxokmL04wJcMBpZih+WeZz04E?=
 =?us-ascii?Q?QL0Le2CExTPuCWgfpvbEIJ1OMmva4c4YPpomB8VZX3dw6bPUhQ0ZMLjlRnTW?=
 =?us-ascii?Q?yJMy+1Ahy4drnSckLo1p43NbtNcacDFiPLsQPPV74tKvSLQMfeGLiTpOmREG?=
 =?us-ascii?Q?c4ZoMvhh11ygmv70I0VdVWkcNT4p+rp0GLzRB7MaSsAEZtPowht+eJaPYGhs?=
 =?us-ascii?Q?b7Fdm2RGQB4zIuyWZxhNCPuWFVKoBJ1N6590pN8Eo52d4Ao94nG3fNtrORKh?=
 =?us-ascii?Q?P1I/6PoM+h4WToebzgZJs6Id1hOPE0PUosab3ks9QHexsmG9wNDkUvyNRxIG?=
 =?us-ascii?Q?mbpIB77+KNZ1A3YfDCDBnuRC/WTgbb1NzAYt1eSASlcDtIWmH2GLZHNxV/h2?=
 =?us-ascii?Q?SVk82ZeQLtulQB+XbIICPk6WcwfJGqvMztHbYmP+i8edU7V88S+/acjwR6Sl?=
 =?us-ascii?Q?tEzjGVew3TlZ6E3azcD3qrBICYFyv8a0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR10MB8218.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0HNIk9j9dORuwxI9HleiOhgV6/oAKLxJUqzjzxtPkf4LnwZeBNur/LzrBlH8?=
 =?us-ascii?Q?/FMp3GXK1+rQ5zddrdnawpBeP9ykAhVBPdcIut4fXigfI0bA2Nfp3YdvRIdL?=
 =?us-ascii?Q?5O3BMumrSz/zrf4maZFe/xdVrIt4+XmAWaDr+TxnVgg/JYOX3vCbmSgMyfOM?=
 =?us-ascii?Q?T7CvMbalJkE7S3dwwq8ZCgGlm0b9KMRmIDD8WbPNC0MwBD/FW4eCCH0C0jat?=
 =?us-ascii?Q?/Io6BRoKWsF2Jv0EBhZROXTK0rifgRo/q8+gfTFfw2VM/6OM4j1xdMqM7qAM?=
 =?us-ascii?Q?LDgmbfEiZKoxjZJR+fu1RgY7ThjsLyF7muYOLyp+gb+QNrIdrOh1tAhLZ/gT?=
 =?us-ascii?Q?uL2HH0aSSAMHIt7uB8ND7iq7FwjaA/2oaVVi+ZK7/ftVstJ3aqYDrrJasR/R?=
 =?us-ascii?Q?0I9g2AldD1aDur3bWShTqL1z1vC4BzBCEXa2u5PUGW/ohjJ/sv90AkiArypF?=
 =?us-ascii?Q?5hPvWpLJTfzhAumCZ28H0s4f2e9exp5MArXlu0IPM4j5UH8/8X6DV4egifRh?=
 =?us-ascii?Q?wQwede36ncOT9Q01LOUnOhvz8ynIZi/AhFzTIoqtz1YrVjtbzyzjrNXMkitA?=
 =?us-ascii?Q?mBx4Usm1GpyDYQmjfEhnNpAoCdaZgOWvJGFTkm0jvnGh+i1z2nl2IY1zQgSb?=
 =?us-ascii?Q?aFnlSVkQUhdYTRSXOLN33l/EAa1NMGjXmMIEPvW+wrf/qUtS4ce40h7ixuPv?=
 =?us-ascii?Q?inEumwQWVS0a56HuaSHjbJG6WgGcCPnr3RFOdyu5SHSePTGZEBtbaIg68W3c?=
 =?us-ascii?Q?7AbEGkPijD1/zZWmjZMeaDYldK5JXKnoRycl11Y+VCHTW+IWTddOs5qAX/xr?=
 =?us-ascii?Q?eZoi03iptWhSwI1WKgcSEz4e00BuTr3G+oYZGkKttlamtLQNBwngGdte67ps?=
 =?us-ascii?Q?lAURSCnoaB5AQetMfeW6zTnS2KxfQWdsdF1CYSYDW+d4e/KZksE1o5aOytt5?=
 =?us-ascii?Q?qmg/24o4xc3p892fNhfI4fJqxLOdY2MgqWBnCLWte8hrsj3lWEtdZyP2I62B?=
 =?us-ascii?Q?E9CtjR1muKmCYYXXDN8M96nO92JZQj+VK/iBMOIRXJUhBJKkIbFbQm6j2yQc?=
 =?us-ascii?Q?ltDAuQ19Pga+K5dxEhGZpxbldlvUzAp+y/veoIlfcNYszzE5+XPTyXaIyNnq?=
 =?us-ascii?Q?gF2h0L++JlRnfMkIO1QeCESq017133BQUqAt3ioq+gEDdX2TUPXIR+1c6xDy?=
 =?us-ascii?Q?3V8GuCKyIkQ9SAYzbl85L5u9jr0xOhzAPrwoq0HuYYcEFzDzN3vhEN/rEzmh?=
 =?us-ascii?Q?VeMXRjBIbiYC6hhXIzcJb1XRG1OlBlb7JPsdTY1pMMAo+JtrD54UvQaNexD7?=
 =?us-ascii?Q?qfgboF+MTtzfhhgJ7tt1hGJLI6bkiNoWIpLIwV/Emr2WtisNc4pNA5bqN/Z3?=
 =?us-ascii?Q?8sCpYw6490H0eDgLQkksVT+via3VSzPvCO8qU5ecWVPGYnDvqev/964+5A6e?=
 =?us-ascii?Q?49pEx1UQf87n0mdFLwmCZf7NATafP+4FZFihqythv+Q+bQtN+SKNt3pLCixX?=
 =?us-ascii?Q?Zl38L04AvD6UgqNCREvWEomfE15R9VrYuje/+e/9NeuiS+459w2O6XlFnbZn?=
 =?us-ascii?Q?zn2JVTPkbmb/JLx2DlLcRzXiCmh3KQCF+lzPMc5rQn/PBwbKllUrUTxY8wYo?=
 =?us-ascii?Q?0RjcNI2eymhOMs9ZYYpbw+CLdEJKyaMSJPDY/ydA9NKUrGvWjFXJVsIj4qPn?=
 =?us-ascii?Q?GOOhV/onxcnt1EudjYqecLrpEjLAUHmp1ce5Ykc17D9F/vUUroYMIU3fxZUf?=
 =?us-ascii?Q?xNV8qX1M6SZsNSpM0MMv8MMx9jaADWI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KauA4laJX74fm2QbEHXXiB7lbUuhf0QNLndPVrUZqMDI31dRQOjOeuUdqgKGLfEraCCucekhqo4dh6F8uwSChCvFmzsU8iGIv+jAePUxMT7/rUQoQRVpqk6MuVJUZsYYZRGSNF/955bLGeVyCkdS3r+LnJPu3V/WYLOwK0fjp288GxDJqahOfKhAD/wvuKC3z/Wx/i1X5wDk1kArLL6JI/NIF4vmTe6pWoZTAApa7Nx0A1yC70uxY/hCfsHQBXa427406YKMtS4Z6D3ZGXuHyI0y2unPSC/MtsfnHe/gYb0sReo04nRLNO4bulnKnoPrdP6cZr9Smq+P7p9DFivLqd5KlcYVn5idfJkXosxKJvt/KTM6n463ZkNzRXMqHperg3cFkf5B3CuGAK+n8DGGitBnEZ8WDLIBBKn0Z52ugSZHm+P8OWq+OaId4CYM0TBXasBLc2k6+0rbq42badyRgUlXgT2bVoJm1Ad99IUWgvET73nt4k+bJKklR5FgHSR9y3y5Cz9RKcSoneo2lUfdGBfzg133TsSRSBX6MRc+KXK7d3CnqC+1y0dCJQdcIbxoLtZBvT48jEQeo6jjUDy6EWxbvNbFyNiA/8L2rv8+sm0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fca101-bd4d-4012-deff-08de4f8b1ca1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:26:43.3827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wxDm9uqUa2OXD0gNt8qJ9XBaVhLUqvHgGZjhvh5H16iwA4vVjcSHgd/b4i4JzIHk2BmNNQr7FZ6MD+VkzHgbvFXqX5VoDTt7kRNYydSDHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEwNyBTYWx0ZWRfX+c4opTlem2aT
 rPSothJNWLILIfQTU5/cLugCBwyqC+6IsbsgVIRzbQkJk2Dt04vXFUyda9LFfMZoqDznaRtOuZG
 0kSPTtBErBoVTgXSjdn6rw+s8/eNNo2LQTjrHepaEtqqlpckv60xAnGc1VWn9zr/SAcxnMzvkvd
 hegxMOH2vCL7vMkmhOWbM+mQkbNHG9W5afBFV0O2bAqoybBe0snSWnESX8Z+hRTc9Z60qLB6bXE
 VCx7AwDz1K2q7DVt4K91YX4hnpV+pShXCl8ViVg+g45UduuGLPKBUn4AQnFqDi7FY0tu5UbI/Vh
 LLDwetF7U80U9gP2KVZsytJyc2sWtFQ3S6dnJLy0Gfv3GsqF6m0J+T9csTbwjcvOTD3jh9TNSsI
 AgnYSVeo6q8mpH2QDqYCL0F9FpRT+mZlR0JOcZNcFGAkXFtTD8itYZAJRIMetKPwJFXtkRyNZnI
 k7c0hNnvPrkkf5wCPdSAjYqYyGgSBfDTagH7Pl7c=
X-Proofpoint-GUID: 4Kzk77VisdR8UhIEoBSOwTnEu-jRqIRt
X-Authority-Analysis: v=2.4 cv=VoEuwu2n c=1 sm=1 tr=0 ts=69611027 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3wTaxfxwHTStLamafOkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: 4Kzk77VisdR8UhIEoBSOwTnEu-jRqIRt
X-Mailman-Approved-At: Sat, 10 Jan 2026 17:58:19 +0000
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

On Fri, Jan 09, 2026 at 03:16:57PM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/8/26 07:26, SeongJae Park wrote:
> > On Tue, 6 Jan 2026 21:52:25 +0000 Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > [...]
> > > I understand your point. I don't think anyone wants to see patches falling
> > > through the cracks. But we also don't want patches to get applied without
> > > any review.
> >
> > I can also clearly see both Andrew and Lorenzo are trying their best to make
> > Linux kernel better with only good faiths.  I always appreciate their such
> > efforts.  And both their opinions make sense to me in their ways.
> >
> > >
> > > Perhaps it's time to deploy something like Patchwork to help track
> > > outstanding patches?
> >
> > Nooo...  I'm too dumb and lazy to learn how to use Patchwork...
> >
> > I believe we always have rooms to improve, though.  One way to resolve concerns
> > raised here would be asking Andrew, someone, or some tools pinging relevant
> > reviewers of patches that Andrew wants to add to mm tree.  But I think that
> > might be too much request for a signle human, especially for mm, which is a
> > huge subsystem that many reviewers exist.  And because the reviewers have their
> > own tastes, the solution may not fit very well to all the reviewers.  For
> > example, someone might dislike directly getting such notification mails in
> > their inbox.
> >
> > In the past, I actually considered making and running a tool that scans patch
> > mails that not Cc-ing relevant reviewers based on get_maintainers.pl and
> > forward those to the missing reviewers.  But I didn't make it because I worried
> > polluting someone's inbox.  I should also confess I worried my electricity bill
> > :)
> >
> > As an alternative way, I was wondering what if reviewers consider mm tree as a
> > kind of compacted and curated version of the mailing list.  That is, using the
> > mm tree as the useful place that we can more easily find patches that we need
> > to review asap.  If it turns out there is no time to review immediately, the
> > reviewer can always ask Andrew to wait.
>
> I have my inbox full with stuff that needs review. As long as I am properly
> getting CCed, I am well aware.
>
> What needs review is at least not my problem. And people can feel free to be
> listed as Reviewer to get CCed :)
>
> The problem I have is that if I am not fast enough to review/ack, things
> might go upstream.
>
> It sucks. Hard.

Yup :)

I'm opting out of this game. I think the more untenable this becomes the more
sub-maintainers will do the same, which is not good for anybody.

If we are unable to even determine whether patches land upstream, what does it
actually mean? We do all the work, then still - unless we burn ourselves out
jumping on everything - we cannot prevent broken changes going upstream.

It was an irritation in the past, with the current rate of submissions it's
become completely unsustainable.

mm needs to change or it's going to simply fall apart as a subsystem.

>
> --
> Cheers
>
> David

Cheers, Lorenzo
