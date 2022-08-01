Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD00C00144
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Aug 2022 14:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E50F38ACAF;
	Mon,  1 Aug 2022 14:54:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18D6C18AB1A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Aug 2022 14:54:43 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271E8uX6016945;
 Mon, 1 Aug 2022 14:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=3J4aaCAzCWicACUJnANjVGg//rYKWhUzJMsBueC2OXQ=;
 b=wNv1PdJhFHxQLBmg4NUqqZYKQCLB0RUPsaSlgeNa1N1a9rE8qXRETSZ0U4s3PZptwRnE
 E80rNYPzPneCilLfDEm/rasuKGenyrD0uhPFf5JVlpfWtIQd0sfO2YF7ryGE032sPWF8
 ubU604oAaiRnc2o5m+qhdf6e43F75/CIl9cPvJZolH+yuvZBHFdLak/MjmIhAgl3lN47
 k54JzDuKXP3l4EdnWSMrRFdGDU+Fzh1hhxEgr+kNEuuODmjlN9vi+FqqDGu7YyFPFdTX
 d5lhRhSDfOxq+L7sJfWNxZSWIKeCNeF9YTTQA3j/iMNIhKWmw/wGRatPEwGc00IRYJCv Wg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s3vfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Aug 2022 14:54:41 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 271CqjJQ000997; Mon, 1 Aug 2022 14:54:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hp57q8wfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Aug 2022 14:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NczLCv5uR1IVPa97gIvZ9TpcLQ3YTPNabHQItFQqGxvAJeBPUZhsfzz+VyVEpMol4GGmVJ1d4DYKpjkm9oK6zoVdSV7O9/cYkTgr70ALqvukstW3FQDjW9IawwzYNCfGyRsBSt6brDoo6ux9Ln1DwHCe1AD5dDNu8m4hIuNJ/hdv5TSUlvHV7MgfRxqAeCBosH+EV3WDTUgak4enLOJyGpF2YVXQLJ9vXbsVpqmyRloQJpt5BLNW8yOB+SHEa+nQKzw49k0LoAW+t4HQ0ZTUr8to110fDWOtKzyBsK6H0HV3XHjKVFmnLDGppfA0eoIOUj5XFHLKDmorUv43Ay2vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J4aaCAzCWicACUJnANjVGg//rYKWhUzJMsBueC2OXQ=;
 b=fhlCX5iahnQbor7HA8KmUdxnkwbYGLUrtb3nZ+UFCA+m8xnmuhmTgpRjAuSjStXoqJtDQom67CD0zc/GXXTcpzZWJy/ohJoo0SIoFWfcUnpddDbVm60GazfpxtsZtd726OydrOzTSuYQJC08l5MVamX69fLTci5QMu3rGhD7GPCtE1DkKinIvbWmfWr25bWtRunbAuVqhRir1CdrHvynrLviw7m8hevmBWJjaVE0+4fbvcvi+3qhBwZ/rMN7Ijq8ZZk1XAj1utgC4FIZeSzCMCIYo75PBsGpuY0TFK11U+1OGUalXdDIG9jJqWp5SJJwUKkr4UUA15C/MXTTsM1oVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J4aaCAzCWicACUJnANjVGg//rYKWhUzJMsBueC2OXQ=;
 b=fj0G7eHHepuiH4sIPklfBwUYwNDRgku7x+iQh112tHUZQkUf3ZHdfCO4jyi+pRaF6o7IZEWscC2LMUrmPj1glFyZcwrla7l/KGSQjX2HAGXVTo4nH4AFdG9saNq/FpGQUXcnu7QPBlHiQ/TWh9mtDQEw909Fy04ALnas9RpVrTU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3508.namprd10.prod.outlook.com
 (2603:10b6:408:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 14:54:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 14:54:38 +0000
Date: Mon, 1 Aug 2022 17:54:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alvin.Lee2@amd.com
Subject: [bug report] drm/amd/display: Add SubVP required code
Message-ID: <YufpJKgAqUWP655T@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0a40f7b-a13f-4849-57cd-08da73cdc1c3
X-MS-TrafficTypeDiagnostic: BN8PR10MB3508:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onC/WpqiZK+I2NfpjUNO1sczCnolLc6VUgd7eIy6Nm3dH+HFE3KKpjAkSSZUwrTmVAsSfj9jGa5CKPGsiH9a8B16ZcGxE18Tpb0rRhqiahAsAbjDvk2vIaxojtw86zEx1BrWvk8m76mof2e/JebVnlSEpDEKbdY8b9aKPIsuaWKDS3ds4QsJiXQ0MRE/w9oeaY2Q1kbpswOxC3ZqWzhA8kSIVUpe4jyPPuYjDdL6kG7MYV4StDZuan997J57KqdRmO6dbaPRrA1ixgGYY7wQnxAwfmjivoY3UADN1kExiETcEbCSAG+9y6edbmSa59MCPJuR/kKyjfCrloFqDN/2cqh+9/PiHEuHl2Lc1PRo35b1YzgoVqCajawBa8Zk9t70/mxdns+3CWybPD/P6j2un4fglCnEJCrZnI4RN5hEC+P/U/bR+oHnW9A+Ht+gtQYPrHL9C0pT2ukj5JhF/xT/L4Z7XGaAcFkRZheG+HidCLu/9bqtHvh593raK9vMWFy3sDkLiA2pwO7rLTdWfVS3wCt49BNfOf1Yx0chImMn7FF57vCI5ZIeAqdayA3cl8WdN0EW4MOOSiItWD4Zy6/RMSpBB+tJR4awCc/fyw6tAgrY1+VzbgfjCVHb5pfDVRLLydaNR7OSuamVPBl3BaigSS9B97rRo/tE/lpK8FmAFtgi4peMaXQgbg7TRQV0SF4ELEAvxwFXA+Oqxp62mnbaFgG0G86lZ8A/vlU/HZF806YgpGsSGaNlbB28R2NZxDDEH0QjhKX6LzXRcheD8wrjegYhXsA3rsYBfqMpS32B+dQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(376002)(346002)(396003)(366004)(39860400002)(136003)(316002)(6916009)(2906002)(66946007)(66556008)(66476007)(33716001)(38350700002)(8676002)(38100700002)(4326008)(5660300002)(186003)(8936002)(6486002)(478600001)(83380400001)(41300700001)(4744005)(6666004)(44832011)(52116002)(26005)(86362001)(6506007)(9686003)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AbcKMPi7y4pzT5bvDwTOj2m4IjnQuhH8JYzUswI4FwSnH/LRvX27TADSsFEt?=
 =?us-ascii?Q?91BPTc88pMCBGHEne0k7W1ITfguzjZJiU1rsgCdsZe8tf4ZUXc0RruE/jYvs?=
 =?us-ascii?Q?mJNzOdnmtQUASBWjfa8nnUK6Gx3AIY03zab2jDMUts07NNM7ci1etEfs9IyU?=
 =?us-ascii?Q?dzfzFVXlCQ+oO+T4pyslFZxYU51gmib39+WxTX3LDILdHMc4xelc7ttAcpje?=
 =?us-ascii?Q?Z+ZnjXK4N9rGXTbb45M4nUVRxidI2kqNuYP+ZxzMxSbP3SdOwxW/Gb0ooiR8?=
 =?us-ascii?Q?V5yjE3tEI6kE/krj2/05agy3tLSsVs8mUmF0uJ5f8kb6Zwich6FunvNfVwSH?=
 =?us-ascii?Q?D21YC8wq8lQWSzmMDy4unVDBWrejq/dzbrtPhlKyadbU3lRsfi0dlJqiAAyh?=
 =?us-ascii?Q?wVb2occOaKZ5zMTyLE7axZ+EKtWe4tdRu8/Wre4mjtJPB/tUWQ9++7IimEkT?=
 =?us-ascii?Q?u/vtnu/W8UTJ9iwhRPLy7vIL9XRRku93OBxTWU2SwzXLsX4e1OL6yFJ2qGYv?=
 =?us-ascii?Q?K/GQr0exCKJ2CBSprZSBCtPuhxqp4mMXA/UJ+GI8h6BKV122xlDhmM63cDV7?=
 =?us-ascii?Q?yuXCeoWCvjPBdQyfoWV7lVQaIB2E9iv85ZSngIrqECZB0c3DA4vDLj4IEkcT?=
 =?us-ascii?Q?DTGCsWFVsGuMei3IDty1VmKaaF/infgPkGsXGDbHQm+E0Vp9Y3+6rQtAhI+Y?=
 =?us-ascii?Q?0b8W+O4iUFs9HD38MfVCdjgCViDKRcm+tpb+Kj+wOvXZ6mqCeRvNKK/tq9wY?=
 =?us-ascii?Q?9KWLDS8hsDtTS/0xmXuBJ/h5TEm6HXyLBxDvp7bC4q8rVVKXmS6QbFOhxvRj?=
 =?us-ascii?Q?/z7SvFzvYH+KXvRG6gtUiPW9D5/ktnKLuqrsLkwZ/5HeN9sVPimpFEhRGa2u?=
 =?us-ascii?Q?HTONUxyaUpY39Egb2hkPsouyXS1oKoW68q9h/oVIpY8WERQTBlwyf6rK25IZ?=
 =?us-ascii?Q?UW+iNuKolmhEIHYMhvrnPfuJOpEE5zllyQrR1stXyQxSs3oIsJOH/rDiDHQR?=
 =?us-ascii?Q?eofWM8XV2LBQi63tA9V1TIGyOFyXLqIoL+EjpfIjuAuHf5EgRGeHwQX6Q72N?=
 =?us-ascii?Q?qFBQStyMFlZryfMek+nR9vym5F4irwM4djjBaoduuOFw1aKws5C8FPnPG+lT?=
 =?us-ascii?Q?DZiHVsuQUzYIOw7HWI298Gjbb+W0bJH6Lwk3Yofro6APmfGCy2PC3uhejjMj?=
 =?us-ascii?Q?IErfj4nbnDsfZ+xBKVXtCqtu0yK9hTocNb8lAPH2x2lEz1ptRIAe8PUNRfSi?=
 =?us-ascii?Q?0p1dtDrOy1ISVC0LQ3g8Vut4Rial9MQLJJ4eh3j8bbVIfyYH00QhxTKxc5fW?=
 =?us-ascii?Q?Km2MC7C1Xqn/kvTOps6U8UkG2A0eLhaGWItKWJB4G1zOGKzhYaWkTl88YNUq?=
 =?us-ascii?Q?nCEIORd92Yv8v9b5+VfDoqxqlSmytd2LMDyZNwQgvAsp2ObBRFQLtpIRV13y?=
 =?us-ascii?Q?Ji1gjPg1zKULR6FJZBCnJLHHY63y4V2l6LGGRwOTgw1gfgwiEcuvKQm79+XS?=
 =?us-ascii?Q?zJ82dug/BCSpClzjssk2yJUl3Ia+kenorzP3O93MWNxJmvv1kwPoriq3VpUf?=
 =?us-ascii?Q?sB69fZXOkJBjON11Yp/bRBKUzXtriZ8RWMIjISij+qJHMbFgfvCXacFZpI3y?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a40f7b-a13f-4849-57cd-08da73cdc1c3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 14:54:38.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4CFQWBujo0p4EeEestoUoaBxu/mlWWh8n63CulTYXOlHJvZ6zQEylaKx4aqyKXl75A++DkT9s9L7AYC1oZGqEm/I8W7geLsupbMtLvKr00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3508
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_07,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010075
X-Proofpoint-GUID: _3peADBcu3DcOLXZhGtqn99fMGuNZI6M
X-Proofpoint-ORIG-GUID: _3peADBcu3DcOLXZhGtqn99fMGuNZI6M
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

Hello Alvin Lee,

The patch 85f4bc0c333c: "drm/amd/display: Add SubVP required code"
from May 2, 2022, leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c:103 dcn32_smu_send_cab_for_uclk_message()
	warn: was shift intended here '(num_ways > 0)'

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
    101 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways)
    102 {
--> 103         uint32_t param = (num_ways << 1) | (num_ways > 0);

What is happening here?  It might be more readable as?

	uint32_t param = (num_ways << 1) | (num_ways != 0);

Still confusing actually...

    104 
    105         dcn32_smu_send_msg_with_param(clk_mgr, DALSMC_MSG_SetCabForUclkPstate, param, NULL);
    106         smu_print("Numways for SubVP : %d\n", num_ways);
    107 }

regards,
dan carpenter
