Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20290C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 16:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E2CA10E70D;
	Wed, 29 Jun 2022 16:13:18 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8549310E70D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 16:13:16 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFEJ7j018664;
 Wed, 29 Jun 2022 16:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=LVI9wKrEjCS9rYVhVCDKudRBWTB1eHmkH4a706Ui1V8=;
 b=MTCYPbH6a5i8iOPxuyo9DqgGiagRw3Vd4EDirzrIQmB94743n7fkkeRlEbufbImEjAIn
 pCoQnprb9aUpH9YUXXHbC0qitHa5q5f7bOOiAvfWnRfx8wSpSzJoJD864sjEpNaQuknf
 T2BsEhyhLN7BKL+3NX9EbWRvbFP79pYKg+9+pmDf0OM+nNhJz5ZaTO3qnawnyMdUI79i
 pbo59+7X5wDhc83NbmMQisOTUPlWBrvAKFBAd5uqZMxf6RqJG8M9kGnVHT31Hm9cdXWs
 cltDBgWu/56Rc7DDxZbZquzHkJPsK9/emsZtefPjRu7QFZVr6IlcCjQzEApBcOVqFSzc rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu9rwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jun 2022 16:13:13 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 25TG5ejq023451; Wed, 29 Jun 2022 16:13:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gwrt2y639-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jun 2022 16:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3JWF7A9RqS12YliKkMvjn6wIA0+0fyGNmjU8/ViXmysdjLBdcSJcwnQQ5/yUA2v3NxsWVCJZdA48av+C5Ast5mRRmx8wT+4yYUz6G53RuoVw9Y9atNcfgjd7p8NsB749osao6Xjo731Gd3JCFaiROSWWztua9+kyzWUUnqm8U5wCvOSpD+J7dAkYErFk73HP8BunBzZov1BFGVcwH07kJoB0ZbWS6Op3/FwgAMxYSxeM/pkDgrkcY6Kg2u7dUEXpNQm/iZ+0Y+bagL8ShR92aZVnXuL8iU2DOPW6Cxz5tUf26kbvWJmVOLPFhJeg8tLz43tFjhY7tUzuB0Q/cCJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVI9wKrEjCS9rYVhVCDKudRBWTB1eHmkH4a706Ui1V8=;
 b=gEM4PrfavCaTbiwQHxE5CqCMTp7BytjU93Xk/84h6Yh6NnElsxMAdz5QsOTWASfIZsda9HtWHHmHB3n7JDCAm3Utd/rXudhFbSsKYiGHSy/XT2NfyYdfW3qvjixno8YId0aN0bVDY1RxqgCrxfaipE7F0HhHfib2y3e9QQ9IXIraJjwQBne1FTyRtmJJ3Qat0Z0Z/5jSQON19p19RCI8SVNke/W+TYKwSCH8LObQVOi1hpAAtvwkA9nn3Iro4BmnP0jO3fwFWQm129p1RVAA7fydPz2onyrT5G1UFOcn1pPX9sxkj1NQFJY/VqxPvwUu/GIJHYM4CuARi1FD3o+8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVI9wKrEjCS9rYVhVCDKudRBWTB1eHmkH4a706Ui1V8=;
 b=LJdAFvGN7VJB3qU6hEO4i0XHQm/Ulyl9gRI2Nt3juLc7uGCBzAiKJ/Jv0Fn8mczPAP3cImizBppxoJUlhW2xybwUmoMQxF3DUsRdWVPkCcOiMMnwnaVGUkv8qxyO7x+tSYRcT25dgQpa2kE8bWIgUSe40UnZW0XHRVrZFToRhqU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1342.namprd10.prod.outlook.com
 (2603:10b6:300:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 16:13:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 16:13:09 +0000
Date: Wed, 29 Jun 2022 19:12:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Message-ID: <20220629161252.GX16517@kadam>
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0007.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8950097f-ba55-4f81-cce9-08da59ea41db
X-MS-TrafficTypeDiagnostic: MWHPR10MB1342:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAIqRrC9o9hgW64p9JsoD0IWHzjCpYXSe0hSc/FYbiTasEAQpdlnDaauWhTxSmI4LQW0Uz6Q/gh4OsCsOC/GU24DSTdaeN0qGNfwal+PyFUzl1dwfh1ONUuX7I1QO9gVekLofA2f/UXWfViPD6NSEWpIEcBBC3Iyp9Gyz9vcy2Z77G8FCU9C/l5GBj/1ryg/9Uy5OCS3MbgdinmiigW4v85tY8RxBJgd1yV5BdWEyCuni+c3xGBCipXIPMz6MD/yZPwtCEc9050oUaHGrKMl25r92Igiari9V5mxDVKvlXTGFxe2cHrM/jBlSxPAwl30MFvUYYrDlabSViPKaS9N3cd7i9BXK+sJste6iF5OsyeuKtt7IDrc6JwkRpzpE3qMRM6c2QncYbGJp+LjCwiBSNAZWoB+wiBdjRnIWsYW+6507PvegLxzq8TREbe+NIegvAGxFz6ZKlbRXpMFzUT2YvnXmjVhsIu1BmLO17qFUQ7HOGaV7AQ/zh3wTVyLyQKi/yTbwFCYYSAnXXYW6SkvsEL59U0O/GdbddPdhIygDm/WLWxy3vqpuOkDjIIW+nlkkiLc6s+hUUr5TZdIhLcZ3tnH0/Q3Vd9V2CNWXCnohN4roM9W3/RSeP/VQ9xaGfod4Mi3mWwO3YqH3xK8JM190tfbKAAGmxM+bXDjKororSABVho8OIaEjmi0SSFf09VBxZBXwxRU7zzaeRtjgxBm1eLD/cnSrUaV+5Dx941edz/Rm8dVqJtN/unilCy5uF3hifD8rk9t0e43kSVVnBC7zkxEQByZcLvlXpH/zXHmIm6HQomtxemJDoA9k3c1aGhC2j+QtlizzOKLDSxt0XZ5Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(8936002)(2906002)(44832011)(6916009)(4744005)(52116002)(1076003)(33716001)(6486002)(478600001)(38100700002)(83380400001)(38350700002)(66476007)(5660300002)(6506007)(4326008)(8676002)(41300700001)(316002)(6512007)(66946007)(6666004)(86362001)(66556008)(9686003)(186003)(26005)(33656002)(5716014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pQS11MmovwOsfCdxCpVtrMZTweuodxBUhqLppMcHekuJAMmyGknylCeZgXMM?=
 =?us-ascii?Q?HU4Re1avMQvDm16++GVRur+nNz56gwIRzP2OZtqzNQld6ueOU+M+aG7MQoRH?=
 =?us-ascii?Q?IzCWQtVbTY9CyBwVmd7o3z59ZDW8GAgFsBa14JLNiO+0KNux03QdOoeWA+Q/?=
 =?us-ascii?Q?QeijZVa4aHQcT+QKnUEq+h9zRXez7bhR5Tna1zLN+w/nX/RGXHsIlgF7xCeA?=
 =?us-ascii?Q?k7oSGYGGTgpCzAh8PzMywFPirsT1zY6w3ogC18/VCaaWU+3LkhntUFz4AeeX?=
 =?us-ascii?Q?s5SfvWV8OsUZvgwmFgrRzdCN5VspSjs1TBFHNozc52yMdIx0LygSDiIRILYX?=
 =?us-ascii?Q?uh6HZ7wa4FD8n+W65jtt1jQelxX2XuaDs4W9KW5B7BLqZupbq/Gd8PWpdep3?=
 =?us-ascii?Q?60/gSc9BifvIekd8ZHTI12xxC3l6bHdEDz0/FLNQUboTArTKNymwoHHo/gIo?=
 =?us-ascii?Q?n0gMMvygJ9pq6dkRJASwehAmxRyK+O4Fa1DKWULkfy2r5Cgwvw3thBhdJn3N?=
 =?us-ascii?Q?kxHSc/QKumq/GPSHzCbNGRH/jD2WRmrjMGWq+gA/ql+6BMaNvlniLY+iTPZp?=
 =?us-ascii?Q?sUzvmZHz8BqgBst/iaU4HjLovndMuRppS9ee+GfyefCP/PhgK7K7WdQ0Xo9H?=
 =?us-ascii?Q?5mdrFCWMgRWeguOqApsxlJsWZrRS1KFk47JCx9pDqxXgTJ+bQS+o6PBCNUGr?=
 =?us-ascii?Q?TKKEbQ3+mlpsjEv6LBt5onZiFBDXjevnarC7DRsIoHhXyl0Saco3e//kw7gq?=
 =?us-ascii?Q?nG2IkcMzs3K6dbr0FJdH9en5WYwLq747b//o9gqYkA0UoggAqUQnWt/lrv1+?=
 =?us-ascii?Q?sjer0X+PajC0uvdV1ErVc2PJB9zL3Dr7qHfTh4opRYRIxj01sa6FHR4km+xJ?=
 =?us-ascii?Q?wezdz1MyU9882ccVAA7yh20GvtQKdksWoWjCtG9SSmVyDA64vPmSdn1LNx1l?=
 =?us-ascii?Q?ZF2i3prFokQEcORPkRF8A5X9e+tbSG9w3I6k4VuyqPIbmCF0hf8OmTTGA30p?=
 =?us-ascii?Q?fiUbI2FGj51cQY804rtydoQfiCfnOYCi+U+o+UmqAAXEKQTH8I9VaeKd7DI2?=
 =?us-ascii?Q?dURZrppJy1EH6KyApq+KMo9xgoWQcI9+3JVnMv8nYGDd/OEPqQI52Z8FGtvX?=
 =?us-ascii?Q?GQ+b5kEom25bFghAt1VctlZPnhwzxoaJXamZM3ddzxC/S8y/xByg+r1fHEbz?=
 =?us-ascii?Q?sePNOO4iQp59bUznkyO5/w6lgtvHQeoRh9OzHLcp6O2GJb1IVzKuVDyJy77O?=
 =?us-ascii?Q?P+WZMGYSiGRmVLhPZutC+bSyeDBwdXY5BNG4QbI4hYuV2JHi2aQkVIJYeN4W?=
 =?us-ascii?Q?3fBvPq/zydEn8cFRLVVyWLOgV+EOmGhA4+cJOm9ss5GcMM93MtWKfbCxd1Zv?=
 =?us-ascii?Q?t4gNFXqawhss4jQx+73/Hxths7wtYFsrCm5W46bRUjxUILEYlXqJBfhHYKyv?=
 =?us-ascii?Q?GReaSyeiyexTamxDeSp1EILV+CSTHHnSBEuISLwo3HfPPOQl8WcdlgsKVPbt?=
 =?us-ascii?Q?iRiDdcc0QeI5q3tQsrTc8eDEoHpdqgWANObRsplfm2u/bujtr4SLAZNSVy8X?=
 =?us-ascii?Q?nsfVLbCcaOmyE68XROR3MM25K2yFaWPyxu/BiuZD9tvx5mVop/VI3CuVvxpW?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8950097f-ba55-4f81-cce9-08da59ea41db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:13:08.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V4tLLfvANIMeUcQlCNEONtzlaWivSrTUja9jQSkWZ2ZHiUDbfxYDQ0rpYL0lljBNsYkCVxQG0GNHsI/eh32Zonvfda/LNy/GJ4NuRspLJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1342
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-06-29_17:2022-06-28,
 2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290058
X-Proofpoint-ORIG-GUID: PwJmX8INoxLAhNS9W6sbwRiT9nAlx9rR
X-Proofpoint-GUID: PwJmX8INoxLAhNS9W6sbwRiT9nAlx9rR
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

On Tue, Jun 28, 2022 at 06:25:38PM -0500, Ramesh Errabolu wrote:
> The patch fixes couple of warnings, as reported by Smatch
> a static analyzer
> 

I had forgotten what the warnings were.  Could you put that in the
commit message or describe the bug somehow?


> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

This needs a Fixes tag as well.

regards,
dan carpenter

