Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5E7C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 21:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC8DB113870;
	Thu,  2 Jun 2022 21:33:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BE411386F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 21:33:00 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252KFouU013974;
 Thu, 2 Jun 2022 21:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=UYsdB45uKAJi4eEJ6XLILaEhApLllmt7mLMNvCVAMbw=;
 b=tQrLosghKIL0Gl7CCTcqwj1hdW4NxUDhZB010OlRrsSLOBxXDOXgFkSUDcRMxrj2VLuQ
 bOO/fVWFcr4+liyZa0r7uLsMuk5QaZKE1wFN5ycMl/UkMQY5oyF9c4NX01HhqU2vtbyZ
 MGOVEu4CAVBtnprf78S/8aDo6kSQGNZisCz2DxOZd+gWznzoc81YxhbhSOiqZlq3HI4Q
 r907zRgSJqEpbEsqt3AIKixgUQfN3T/2Is2477MDMa1jwb27j/Oae3X9dn3E1gWSjlSi
 vHEAdQyvukpDkyottR0ikLmKpsVQYqB7CPJo4qhwa7FNXuwewCqKc2CUdoFj/5EwTZTy aQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gf43cg3w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jun 2022 21:32:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 252LG684010114; Thu, 2 Jun 2022 21:32:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3gc8kjeqw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jun 2022 21:32:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILI/MFVBATot4k1eFi60r9CQFWKLuDCGn8hJj3K4nhNMdMtUuxZZE/YF/W7OuXTwZHwAaRqvXgggqsnyIl6dXgE6MfFjZSE0kgDGn7hqEYRv3jpLyoE0On/rN1ClRjAj6iERJl2YvfAqJTM6k5n11E8zVS+NzPPUFiIGLlUlaQp9Rms6FlqbKAqJ7tY7wCmwYbjbQDymtvVQdNh1zO4QET5ciTp4s/TJ9s02OT/MQnhJ88tN2zZLof4TyhvF+p0Z1/5J6R6M7zS4+pM4reDCshNZhe2cG29o+dep4eqBVKjubbRYmR/DpuqFEh8i+hT1TNQYCB3/YzJfPWIocIKzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYsdB45uKAJi4eEJ6XLILaEhApLllmt7mLMNvCVAMbw=;
 b=dcP+yXpcZs6AIChpiMh2GS9MlsrMqChzfOqJJrJ9LJx/cDMgnCB7t/Hi3CYA9bZe+IH4uNl/6gzTMZBGqeS1bbfwLU7Qm7PpsKZScfGGqhVtfpMXcpGVqrMYmn/a2ulz3qNF9uMc/MX2VWlO5e6of84rIft4qghB8ylK4a5Wkll5xDeGY0dVH61rqO0PUCeRXs+ya3HmLx1Yth8F5UjvPoTqEozEyoUdhTd9GHdKlpSODrahfqdNpj3nhUHkVZJs2T1W+Ms/MYY4mELmdnCENCzGn8D6nUhXcYjWjtN9OIGhRPbdqD+cHteZgoj1XeAMz22lGYe5+6xGkBAoTiCZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYsdB45uKAJi4eEJ6XLILaEhApLllmt7mLMNvCVAMbw=;
 b=ABkFECmfdom47sWnKei2XxVgOtx/dKQrgdGUC2SRAI65UXMRamSb4QnszcOblPPkgPmgVDRApXPwFUDwBqX71zN1/7llWaJdnWNPJy2HoG84WyDREv0BdmTE595tFClvqX6SnD/0fPgTS1/iqInm6QYpX2b7PYAnIiZfBIzOMhc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1590.namprd10.prod.outlook.com
 (2603:10b6:903:2c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 21:32:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 21:32:55 +0000
Date: Fri, 3 Jun 2022 00:32:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: add comments about VCN instance
 handling
Message-ID: <20220602213246.GJ2168@kadam>
References: <20220602164547.1171254-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602164547.1171254-1-alexander.deucher@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9606de0-1693-413c-e3f6-08da44df74be
X-MS-TrafficTypeDiagnostic: CY4PR10MB1590:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1590317EDEA0BA52F1553C3D8EDE9@CY4PR10MB1590.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Y9+SatPdrCJ4YxETexrsAeVwAA0d7pf9uoIqr3cckuSzqGXy7QpDBAPkH5UXSfjVXyyQI2rMpO4rh56vBe1VJ/7iBCvX7ZAMxJ+Phtp3vfGEIsDwlrPDBRcDTL+XxIXHHHTtiTtXg5efVSeIAeJIwXT6k2L9/N/JG3tIXvBokTTqBMqHk6tCvlC4y1cglT7fOCXS4CsyAgHdZyGnfDMBTQ1ArvTjm1DGM9A5qRD+hHEizZPqGeAF49b5RT8aZHxFpiwkMexvgMiUBTXCShGgw52N0aKfFfvYIuDQLsTNabjW/FkjH+n1oQrgHkq/pkPK+IvWuqNPQY1H5/F9GdVUiMIFaEB3os5eNb07YxIIZj03z86a2D8DWaZ5t947aWpcdks+HxseMxONcKUh51W8AfnL5BO/yuZA8TNDB3IyO518w1S/yPoe33jExv6q7QbyEa4MXvZLXgRcoq2dFVLFIhRvbPvZdgVoUYDqT7Gb7FPoRtIXbKkAnrypbY7ntAV48m+6jOChu6Rd7UYBXR/ni/SI7m7pN9GUYcmaF2UbpJHNil+j4jsXBC55p7C2xk5SnN47iGdVvWzXtRlT5iPeYxx8LuE9lvBx9kmVk6hwp9DDfi9f4wtbtRDtE4rBLwoITqSoXMJe9+XZO8HcrsQmiz9J126o5nqi3iyxukh5kaH/fSKGbQn2S4K1f9IHgEC2XVx6YDUZOne0nnYq9jOaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(4744005)(2906002)(86362001)(186003)(52116002)(83380400001)(6486002)(33656002)(508600001)(8676002)(66556008)(66476007)(316002)(6666004)(4326008)(66946007)(966005)(6506007)(5660300002)(44832011)(6916009)(38350700002)(38100700002)(33716001)(8936002)(6512007)(9686003)(26005)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NlVNs7BlLHdJeqj5EunBNRGMfGxEsXok48wyYG+8R43g7mC8iQ+/MAym0fX2?=
 =?us-ascii?Q?noO4KXheH/A3e0DoS3/jA7e9BDtP154m/Kn0dmp2bzcwEgJG+5Z1SmdKkqHO?=
 =?us-ascii?Q?kZInWc28bVvmY+0vqYzGFYG1w8xylD2BFT3eryh6AvaKN8LfvnR2Sns13f7c?=
 =?us-ascii?Q?Rrm3PB3TLchZ1C+cr97FvzXC0Bd4ZOcevwBRu9arwRQ46hX7b6iC1iAsBOQd?=
 =?us-ascii?Q?DOSDl+yMuVp8PrPxqIVEgsIC3mxDjVPDUAZu4IsrCyW8xUCH5pKrq5bYt9Mf?=
 =?us-ascii?Q?KMKBlVvVvml1DKc7fhkCpEvKD8WRcpzrOAT72R8wNM4Y3hSyw/hGDV4SnwF/?=
 =?us-ascii?Q?D+LH9jBGoElBs2QG4M9bxL0WfV0UyqMqSqNXaXLNdSBDZClDRk2V840gGyC0?=
 =?us-ascii?Q?/Sc1Iri2WOkfDPEGziB8Q3YMlzBARYrnsDOi2D7s8YaWJcM1KxcJIA8U8QJD?=
 =?us-ascii?Q?Qt/4oDrn5JpoRc6O2/V6sTA1SCi/9F1qe3ml+WUT1PUvFrqZH/FqB+s+nZdP?=
 =?us-ascii?Q?7/zJ5ld1X2X8kNL9mjWhi8Js7HmqlMNyZm18h/S2aNy0ZRcqhfFEi6btKy02?=
 =?us-ascii?Q?oHGIx8jsa/bt5vBSp7yti4nipI09L+FmP9kA2ZATKK/p1yBJeFcbIbVT9JzT?=
 =?us-ascii?Q?9P6xEPb4N5j76mIj93k0n3JshkZhIycVaSkux/3bVMCwfLOAHZGFTYliTsKD?=
 =?us-ascii?Q?N3FYpkN1fYhL6L0z/ENpCCXu1JioomF0aOFXTimmMjRMxxXI9nKFbeMknK8F?=
 =?us-ascii?Q?0db1CZ+97edR20Ch/fq64iwW4QELxCAPeanpnTlw8Cwml8UWRrSMtvN/HXx/?=
 =?us-ascii?Q?5YURBoc3EeTOsdE0V6nYwuijjl8AoDRwpmHksu7TsxBmPTbOo/5ayovYtTRr?=
 =?us-ascii?Q?W6hst81PezdfNDF+xTn/3OVLHvXzUYQleKPRIFf61hHenopO1gvMcokLqSI5?=
 =?us-ascii?Q?RH7Si4GtUGvrjyb7C083wYmkwHXgegzSFlPxWyvHVe7CClieQwdx/ozihUG8?=
 =?us-ascii?Q?2BlztzL8FCrYvYPDcg0zGwGFOp3uyBoPD9r4TrVLQOYlmTLqUZLM6k78/mVW?=
 =?us-ascii?Q?h7u+KnuaTWuT6xgg2DXlJxXISgKpGBqKP3qqj+/WT0O/zMD2TrJ+s+Vf2gAf?=
 =?us-ascii?Q?VeP4tjY+Mh2cpH32CwrnSi6PkAPXlkkGXE2+njt+UuU4lGmM1US33DW4ZisY?=
 =?us-ascii?Q?U5df7jpd1ITTk9rOCZOpuNUJlo2fp/YGMvVoLvoJv2NW4t4fQfcu7rDtTYu2?=
 =?us-ascii?Q?alYI2/lwT0edl9B39lZavZkQGxm1lNGVUYChGy0+xwlCzsPzShsKr71GToqk?=
 =?us-ascii?Q?gDTdWyfSBwCxtcJMCnd4maBznWNxsbfOvDEjrctyshL9NY/9CzeVKoXXjOAb?=
 =?us-ascii?Q?i19z0xN+bygIRhHyfZu7nasFwA9xWhQRqubFfQ1i61RsEIPboicATDtrwKTu?=
 =?us-ascii?Q?aqTu0XQoa26kntj43I41OsehTuMHRk97TNzi4cUUB8avuae2WzIB3Ojsz4IQ?=
 =?us-ascii?Q?XjQRPKPc4SpeWyMmuHCA7FiUsAAensGdTZSeQdAwTeXW3hWG5D/gZL4a647K?=
 =?us-ascii?Q?hjJ2ja9ZHLcEhyCRj30KmcLkkqihJKwxOTcdhASJUP7WBujIrakO0C42QYfK?=
 =?us-ascii?Q?fQBdo4mySYXtE+HjtTH9t01yIDPiDNQ4aIzWA/tIbDRft3XxAOidpJTKS4Lg?=
 =?us-ascii?Q?hjLTmh3/3ligPr2JE9n7GWI+2Wtue4Fpisqw+FsibWWp9+xb8N5/u5isFifm?=
 =?us-ascii?Q?ExRB8n2p0L7yLDqfQvw2iFETrYI+RwA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9606de0-1693-413c-e3f6-08da44df74be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 21:32:55.5284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYyITGPGZfPG405VhdQoTzY+GiROWvWhaujPUoHhmeetC0dKX28hGp0RIAoSHgw2/XXEPWaaSuYRH5Le8n96GnZG3I0otTHpIeIt67n2RHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1590
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.874
 definitions=2022-06-02_05:2022-06-02,
 2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206020090
X-Proofpoint-ORIG-GUID: y3o8P2XNTvBo9aOiLBuNibtAHJ5eLZar
X-Proofpoint-GUID: y3o8P2XNTvBo9aOiLBuNibtAHJ5eLZar
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 02, 2022 at 12:45:47PM -0400, Alex Deucher wrote:
> Add comments to clarify code that is safe, but triggers and
> smatch warning.
> 
> Link: https://lists.freedesktop.org/archives/amd-gfx/2022-June/079905.html 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks!

regards,
dan carpenter

