Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF45FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Apr 2022 08:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498EA10EE0A;
	Tue,  5 Apr 2022 08:18:47 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695C510EE0A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 08:18:46 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2356M6qE000758; 
 Tue, 5 Apr 2022 08:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ED+Jq/5XwTFZY8B/OgVY1jrbdTAVPYjOOW6Nh9Rh/5E=;
 b=UXxz9bTttqqmLs/RZZ/zIkpU6f5Leb559orXk2LprHG7xMBsYdHAZWOGMoiDOS+3ARhw
 5VpOgTyMArISTUDcCjO+5lVsg7a6ZKTgWu9OjqZnRbkh9pvSDkuxgnq8OIDeQeI/2WMc
 yB9oCIiNwYXSKT9jgbAdaCTt6eVcBoTEdwZdm7vohgpoeN3ElRx+Ls3w9lffdu3BH5Jr
 oYX6yIJDzXCVLToCw0rPPd88dlM22KX47D5UnUFmlRMQIX0uf72zLLFFb5gK3cjNubq7
 Xn6V4cPPjlghhL7iO8YuCYa8uA2d/fVCB864QiFJZ5oEtF4oBFIK2w/8V7mK6JeQIbi2 +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sna78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Apr 2022 08:18:44 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2358BYOo005912; Tue, 5 Apr 2022 08:18:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f6cx3771a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Apr 2022 08:18:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLhhb6bYfLaHKrtPOrQ2hHzu6Qm+DL0hqBkQGN8ubUBI6+/wmz3+rM1Zg6s03PyDD0A4YHIWNMVqFPxRW84aERPwnvRgeMCcoB5L2f5XQv0xXIcYvLeFZ+qEnS1be4aLr6puSb/Trc6ZcrlI4jMiHCqJSCYnE5FjBUJ4uPlBOHkt88dVzyCSh1n/Ec1x9RlbPFRjbUJfnenX+KBjYfI7KepGfFdQk2UW+Keydr0gLq8caUFs9XJJ8/7GwpjzTLkCMcXW1ysd96SC3Z3jhfBlTivzDOJQyoZPm0ca+DBfcLwnyIdh1ZC6QgMZEYlfwGoaOws9lZB6EqgjuMtJRNXN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED+Jq/5XwTFZY8B/OgVY1jrbdTAVPYjOOW6Nh9Rh/5E=;
 b=odvcWYgdaef7Mlez9UhKKXRuSpIgtj+2jNaiGsN/QtR0867XLEfxSbaYZmXnAOa7qJ2tTWCKXZ6tYOZgNZiFIM4ultNviY/lSbnW/UlQ7LdLlepm7q1JJdmXYtV6KY/hfk/Whq0GyUaz3imrQ28nysCs8dpoI1datKK7xew4drwvmFGjHi5An8nbjvbukndbLAyjTEadbzsHn86yVq1G9L4zb+CGOll6c/SXpTyVYzKOc6BLoy2AHZ1X5ggDx7zgTY25n4+kcwjR3GOzNp16npAhZr0CyrA0KBcgRveDi4BJDS/YLgKk5qVwbaIm1m5K24dtLIuESZZUWYCEX6QGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED+Jq/5XwTFZY8B/OgVY1jrbdTAVPYjOOW6Nh9Rh/5E=;
 b=If3+b7PAS1By6BoueiZZoD6T9kZUA1sMWEKvdIYRFpcIOTpyrxm+WKKP7Ns3yhasUhu2sj4/HQqyLOoSrUpRUEP85utn8LkvUa8IfXPZNABbG/XaUet5kKtrmRaUdTfCcS8n7G4yAl7tovNNdeKSA6C2djUdGN60Ub+CAUaIu88=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2682.namprd10.prod.outlook.com
 (2603:10b6:5:b1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Tue, 5 Apr
 2022 08:18:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 08:18:40 +0000
Date: Tue, 5 Apr 2022 11:18:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Roman.Li@amd.com
Subject: [bug report] drm/amd/display: Fix allocate_mst_payload assert on
 resume
Message-ID: <20220405081807.GA7289@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d03999f-00e5-40fb-6869-08da16dce46c
X-MS-TrafficTypeDiagnostic: DM6PR10MB2682:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2682E723BE30D032D41C4C828EE49@DM6PR10MB2682.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3L+d2CWcuqV9EFQgjQlfXE33T2yBAUIVya1osQTTAeUG0YoGXg08E5RrtygnIuPqmYeLBnY55nLlhJgIopYwfPKwrbkvUOj3rQQlTPeDABvq7r71WQyfQt26jEvyRnGxXK+s5n4AnyC5JVqRh7Aiw6z4lr8loJiR5lF/CO1VKpCZ4nJcAvgtcdnqmHfaJ80nyxnKyjp2kb2xZ98WDenqcAuSrfGsbKVGIQa5X4suB1WHP/regGMv8W6Px3mtrx65I0J76qar4K3MTHg3/8q97fmejRsgfqCMCkEU+4ggw8U7ezvhElNaOhHk69hUMYLkEPOZG4jrozoUr3DccYEPvRfmWIOzdY2GceI6wOMtSfshkyIVvLqlRLNUHU+XPo53hN9pV/2QTibkqk61nbfSWnLm9//MFcHO+ROagQSaGQTcW8rENw/l2n7RCT1TiQU3WWquMbO6de2lHKCGplIp5sAnjHx3A+GpghVCBJi8tvYI3mY9Fl7pumhTj09u+rpCXx9nLkmrYlya8MT7gEtcAUfZp91DLAhtmlpP3yIP6tEWuKA77J+xvrD7dZu39/WNml5vUtZQTiSUinWe+IBHhbJ3lsXw1R2yIkPDiuFqknJ/a5dJ8x8Nrv8ptlsDng0K1uNh3v7Dz/rogK0HHWwrw3JEpa/GwPotmDUHq5Kk8OV/Q9DwsG7/savmdWKuyanCtNxO64P0xCv1in4UnHOFsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(8936002)(6486002)(316002)(38350700002)(6916009)(8676002)(33656002)(66556008)(5660300002)(4326008)(66476007)(66946007)(508600001)(86362001)(83380400001)(38100700002)(1076003)(4744005)(6666004)(33716001)(44832011)(9686003)(6512007)(2906002)(26005)(186003)(6506007)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/up5IuEBrsjvb0JfbzM7Jsbjp8P2QzMPz3eEj9nX7ETRHKtmN0UTN6zzr9li?=
 =?us-ascii?Q?G1ECStfWGegI1uDWivTMgY8Meb1Fgm+e65cM9Nb7+Fht9xLagz/2rmJV+0GZ?=
 =?us-ascii?Q?L3NFcux4gxiTFgACr8ZvSgdJAvoZKL1EdPcpeR/no7D8msTWsh/u9xwmxmIP?=
 =?us-ascii?Q?LoaPShsesCYSSb/r7ZcWgXMcKAJ6GDJvcDTteD9MSPv9fSXXkCLwmdw6gnjS?=
 =?us-ascii?Q?YA9RSB2sw8AmFiZ8JXwiZtgknZunzQsBHMOqXQrapXvFNYr2n9ouQP772LbP?=
 =?us-ascii?Q?am+48FWQI/egz2/n23txV8sAGExM7sU7n7d33bdson/9XD9E781++DWcrkqj?=
 =?us-ascii?Q?Wx6CoEU3B3cPbsi/O8XbGJbt/Issefc0RicSNsxMzkiFr8ilkuvxGzGdLY/e?=
 =?us-ascii?Q?6/2nKjJ+ikme3yRPUtwcGeZ70ThkZR4LpNp1pyRLQItVtL3yymI4/R+dN777?=
 =?us-ascii?Q?cNtw5Gkq2CvG8OILNBMQdv0lQVjfyP/it/Z8GhVBnqNok37L+V0nVNyIiEVL?=
 =?us-ascii?Q?KZKnpWKZFrAseyQs5mLWyaRLFdQ6JxZfKdWJz195oNlHg2c1ZeR+tlFsdO5B?=
 =?us-ascii?Q?vACPWkdc+P+Y3ZzrUs+R+tc+MZar2P2WLaZCAe87g7KjRijPNYEK0qHaCqkR?=
 =?us-ascii?Q?4Vc3J2FmZeg8jQQ5Y1oHMxnUytvgjShQDaNK14bGBQ6OxJFscO2DDsHJvXsk?=
 =?us-ascii?Q?8+HfuYnXHYSg4kl429S+oyKJSCUi9n7onhG6WxdaZ8dR1kwuAoiQNOU7HNWv?=
 =?us-ascii?Q?9eHmwMLZ6KNjkhPIp/F3fBOsvTGjdv/bw9AhDIGzK4dNZqkG2G5oBgQ4bdZ8?=
 =?us-ascii?Q?tv8goDd37/qESqQXBPB9DIAh+yTCpdwSnCcaVv7+PyyYo/C138ltXHM5CQ+A?=
 =?us-ascii?Q?AZ8vLb+7+NsczAEcDjXAvnb3eq9FLfDuM/l2uV9rSCZB3axVNVFRVSSjzFBX?=
 =?us-ascii?Q?+Nwvz3ClXB03zmZMWURazFBSrX0cCv3mXQjB0i+2DiBagao/GWSSdjesebdD?=
 =?us-ascii?Q?Jko5MHE4m6sE888TMmkhycx45K0YURirWGdbR6Xr25c0UN516ragTiDd8+oz?=
 =?us-ascii?Q?j/qVKgR5c8HYm/9dCFHtOtO0qMbO5O4DwtqoElREmQnO1oFa0kxm9yDvtSyR?=
 =?us-ascii?Q?r4ma62YIY5KySFq0MX/T05Ty2bVmfkGBG0DnviI/O7P+v+8KuGFHaTBzF0Hp?=
 =?us-ascii?Q?qlBww8l0HMhZ1C6O5IZZlDDvImSTxhwe8oDSFdhpHRlbE5XTifSC195PCpC5?=
 =?us-ascii?Q?+YOWlyaB6JXV/2ykrcqrlue5Gzl8/C+zqVxGRNUuIJ3K6OCdDNolXGNUKFtE?=
 =?us-ascii?Q?D++jS96J5uCPNTFVf53jTrkodGyVY5D1PieW3FpnYg3WrvBY6k07M3iqEyuP?=
 =?us-ascii?Q?VzTu/4nbS4bW7NPsb88LM3I+nD1EI1kLMRHYVg/sQzU04ZcKzuEJ3SYWtuVP?=
 =?us-ascii?Q?KzNcrFAmr3UDb2Op7bBNYQ5SAlBLQb/xXbb6Wa9rBRbLxIMmmyTK0spPgeqN?=
 =?us-ascii?Q?EsybxmNCzoY27KvWEfnjTZt3aJ/K5jFZn7AMImXOeyWN5B94ZGJ7xjc4J8nB?=
 =?us-ascii?Q?mveWeC/N8Zo3quVvAuisG6Vce3nMMwC2yUBiNd0jbQ19HG5Cch6ToaNLIIEQ?=
 =?us-ascii?Q?mKaJRPT4QnIX5H0QzFLFTmUPf0cMjoiQj93N2V7ZYEAcThGwuCL50etax7dl?=
 =?us-ascii?Q?i3v7CgAnzxo7wG+GkDrB9bkqD2ZMRkfNUq2IsHnvTH/bdiHjJ4Fi8C1xq5hO?=
 =?us-ascii?Q?yWjntoV6DrIdK/jV3S28LUqZrM60X4k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d03999f-00e5-40fb-6869-08da16dce46c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 08:18:40.8209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiBMRwglf+ChUG6jPct2n9JNnujgugLITuH0tTlflwgzCtqQjOLwzbQsyoOhXCTJzv9kaduCkl+PLiWsMBsDyXFX4NYJDOwCX4wySqUevFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2682
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-04_10:2022-03-30,
 2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=861 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050049
X-Proofpoint-ORIG-GUID: v2QXWAe0P0DthZ04_CczhJeYHHFe8fRq
X-Proofpoint-GUID: v2QXWAe0P0DthZ04_CczhJeYHHFe8fRq
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

Hello Roman Li,

This is a semi-automatic email about new static checker warnings.

The patch c4af42b4eb5b: "drm/amd/display: Fix allocate_mst_payload
assert on resume" from Mar 17, 2022, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2722 dm_resume()
    error: we previously assumed 'aconnector->dc_link' could be null (see line 2717)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
  2716			 */
  2717			if (aconnector->dc_link &&
                            ^^^^^^^^^^^^^^^^^^^
Patch adds a check for NULL

  2718			    aconnector->dc_link->type == dc_connection_mst_branch)
  2719				continue;
  2720	
  2721			mutex_lock(&aconnector->hpd_lock);
  2722			if (!dc_link_detect_sink(aconnector->dc_link, &new_connection_type))
                                                 ^^^^^^^^^^^^^^^^^^^
If aconnector->dc_link is NULL this will crash inside the function call.

  2723				DRM_ERROR("KMS: Failed to detect connector\n");
  2724	

regards,
dan carpenter
