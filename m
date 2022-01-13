Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC38C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 06:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CCA11218F;
	Thu, 13 Jan 2022 06:18:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C78911218F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 06:18:00 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CNwCBT009145; 
 Thu, 13 Jan 2022 06:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=x8caXQk7XFPBuDL9G5gEsNEKZNInStwA3qKKu0nvGjw=;
 b=SXbXPkJEI940dNvLlV6gUlFZzXorzuPemvz0vOP3+omWgcVZD6ZXO6FwJos11g8ByJK3
 930qWfWXG6O649v2br5M06Oep5YQwuoB8mBTJ6Ifhg4AZcKga8jDJ+suESDyk0tgXp/a
 8/HLi34moJC7261B/t4oTWXKicrEfsj7MZXi92FtB5Ax7F/zCDu7icO+KPGxNWNztekQ
 7Wlxd8IBNuGFqJKQsWipz3ohDmqRE1g+5V4kWF3Uw8pjxN+A/GmqHkajB1YOzBEz2oCs
 gNK2KB9q48cK5pTnP8kcUj0ntNSqJtwwqEbifGHe+MCt0GOJ0lwMPxT78ZUUJVSn9DzS Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nr8xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:17:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D6C6H2054423;
 Thu, 13 Jan 2022 06:17:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by aserp3020.oracle.com with ESMTP id 3df2e7d57j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJZgOX8V16kjUE+fQIaFizVPBWsB7H4dOwt60fNvf5VWuk+rAxc6T0WQkMUnzk8CyMzDVJbJ/hHJTVhKfQuqd9VJ+c93uVnSPtiMJ+aVStiN0SzG6V4uzdg+frd/oj6Lw/IEreV1LFz7Y1Yu+Pad0R6H0GueQtPt2eMzjlceadwUNi+LrGxiNPxrADiThlEXvxgkNxu9X2dAQy0c3Zw7UocknUJQPtMf0d203hkkGjAVMYDsDY8qRSyYvPDm4M3GKGCmykN2T2tOJGrLkWXvOGCZW3EKB8N221mivZBh1mssfkTbb9oOIXiuBin/r2dmo3StdYX/X7Apb0viwXLsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8caXQk7XFPBuDL9G5gEsNEKZNInStwA3qKKu0nvGjw=;
 b=MHL/PsHb3QHghehhIDX5DlggyF3WsuhSxF8W377aUZcPqXfniOo6datIUna1QrN73EBjjD5UN9qr9mFaJ+iqI1mGNA8hBkTpWqcnwxlO2jsJ3n8l878HnbZYK0rUJ5mcVvYy+VLIcG2fjN7ePtbsT9Vum9J3UYqTXUN9H675uGV7LsiKV+O7HNkmXXRRKQN/QyskcfSErrjg12PFdMvXo3wXqw+u6pboqkuQQgzjaiShecSk9+JLrBuQinnA43kZBOYhifBiUw7kSoi8BsL2F4NsY3DFh/wBMBpTwZGIOKxBNRwEW4wU7mD6V6WzcKXZZ/qC+kXZzpkBm3bU7rIBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8caXQk7XFPBuDL9G5gEsNEKZNInStwA3qKKu0nvGjw=;
 b=GagjBHJ0bDc7ER3/m7NwTLCN3LECwu7n5JiPKAKeUJbteydftan8rQa0tgU8u/a6prZ0A0a7gvZQdhvWTREcGADb2KwCQum7az/eb1hGSZ4ZZFv+KpWg8WEPRkIKbh6Ye7HNYjRsy1Tu0ZXq7gNj6onUYDwgEE8G/LLFlDqeOdo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5790.namprd10.prod.outlook.com
 (2603:10b6:303:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 06:17:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:17:50 +0000
Date: Thu, 13 Jan 2022 09:17:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Indent some if statements
Message-ID: <20220113061734.GA4735@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0192.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac9f039-c962-4763-18fb-08d9d65c6c8b
X-MS-TrafficTypeDiagnostic: CO6PR10MB5790:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5790CE21A400E1D66FA1F1288E539@CO6PR10MB5790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJSaNKw5JEKg7yFGV+Q0Ea4yQOmmVNYciLi8iMoFeCfs2eyC9sI14Cwpup9ihUy0m9Cp+v9LsYNr1KDXMM5XeYWuJls+aHUYryiv9SW1O0Xa69o/iA/+kVbFa3zA0Aevl4i+MKJI1+Ed01YOVHYUG36Fcaui4LMuTYQBkyvHxul2PLQ9bQmwM7rMO3L3ssSUuouo4LX0YUxXGLYmK0miLQDdbrmTsREG/vxn1SuO5RUWS8CZ4vfMu5tzhUkRlkn1dmFWBG7Qmh/MG5JZcx0cl8JCYuuAY17iobmyi2xvDX70UfQ/jSRFMfQcknhsxfpSTT0t/FriQrk96K2Uf3YJCRl5ljLk5I9TeK1GUnlvNafYc30ZepLgXaS8qLgnP33p/iu+rfkDBq7s11e5HQNrNkx/Z4AeCFtwqOtTndfqan/oxFm5fNWK92bEgmohKxznG4Tvzr72LXzPMUZ4h/Qn9qD662y1MrsvEAmgQzptsjMrkcto76cGV3jAfocKwSLMVC2sVtlxqP1rfMsFXNXJMkbSvW60f8LRhdRNVJiSbWvGlsaBMv+NmpOG7hfh2FHfXVzUUmpfPVvVxRLqvwci+lClunv6o4mOohFgsnYnFVT7Jo8O06MLgyIJmZW3DmMWIV1t+ugVOUTMvDqnV331SQLuKg0HQJDuOB1tX3+yUl8R+m0iBuuA/4pBO2J2sgG7WvrZG+Z2llxwHKJnRGQ1Fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(366004)(9686003)(8676002)(6512007)(6916009)(6486002)(54906003)(83380400001)(6506007)(4326008)(44832011)(33716001)(66476007)(66946007)(33656002)(7416002)(66556008)(5660300002)(38350700002)(8936002)(1076003)(6666004)(38100700002)(508600001)(86362001)(52116002)(2906002)(26005)(316002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9efptb0vn1oXwJFneD4NHQfsX0u+jH7lnoateA3eaO2t4ofJpuUQ+F1E+V30?=
 =?us-ascii?Q?o10eCmOtvmB0jQKWNaKXfzGz1P0i2EeGHBD1+5RW5uffbPwCUeXOepEmgGrG?=
 =?us-ascii?Q?QI5nmsweJ4gWKA3f0gylcE8ENp/wQAC37oyXKM28fEYj8EmYq61r5FhhOCts?=
 =?us-ascii?Q?oXUXbslvjmUL29QJw90df8GOn/WR4tuFIhbhnn283RTI1+6f1d3HyU+MOkRH?=
 =?us-ascii?Q?R26TdxUTXSDZnNcNz1zkgtxUrXzvsSCRUrxOtPLOTAajamqL//IkJTrKuZ2V?=
 =?us-ascii?Q?CQsTX3h8/PT4w8rrSnYn6z7+ilDfGcmPt3l2JHVoh5WAZJIgb8S1PzR+FmuA?=
 =?us-ascii?Q?fbBdJrnwbSXd82dP/hUlhBpO5IHDr+RjiqIlw0GI5xTrah1WPZgyfdHnRgSp?=
 =?us-ascii?Q?1cOOb8Dei9k/TJlpbiKPlhG2kUabY5gJbO5zwnzF/bGdBCBULJpmw+94D+WU?=
 =?us-ascii?Q?nQFRWC5fhYldzJb12mVsViWu3XiIF9pCImEGupruXVZuwE4+X0HPW8R/3jyG?=
 =?us-ascii?Q?znEGd3BluemGhZ/p0wGc34tl4P6Vh6FR2jFYNeNJnJ51M+4zEACf0geXv+xo?=
 =?us-ascii?Q?NHpYn/Czn3Ed7xoVZMNCwAuWBCd2ZkR+ArollRxZoZKMbZc0nmCx096aiazz?=
 =?us-ascii?Q?ht5AU482h0OegGe2r6f5ar+3u8pxxb7QKr7I3SCjYv21gDA65AC9mBuLKvPN?=
 =?us-ascii?Q?dGvSa9u1JMJeEK1Yr2dwlq58VmWSywtQn8s1HWNUF+1RP7HlVl60Xs7sP8Us?=
 =?us-ascii?Q?LJH4jMj3Hk8ie18rTnFiCbLRmTHPjt94Xy91mh9G4K4pd463pcln6cIjN+HT?=
 =?us-ascii?Q?1qFWXc1pSzmhNSZoQIv4jFsFhUbIXHH6+SWKpwXKCuHlmAkl72amesMl1lSz?=
 =?us-ascii?Q?Jn0DXRbCMTFGrb33hnGTupwiLsK/jtzmn5VuvJ777n4AsZGWFY7SKtC6Cbtk?=
 =?us-ascii?Q?sT/SC3A7qEu5XJRimuPst1tZQtdzulRo2QZZdKLSR8Qy2G4dVG6ZR42ZEC4G?=
 =?us-ascii?Q?2WbzJ88bMH69cG7UTiNEtEeoGAiVUySVyB3Vx1LmZaCz39gXThHj9Flqm983?=
 =?us-ascii?Q?jFwHnLVr4Z/xZztUrlRXFkMrOqEj3Qlr2nu9nYQrqv59g87UqdFZvR8+0fv+?=
 =?us-ascii?Q?3LRRobkffiTbi+qn3kfMF6T74zIFgsM8RRytilEISTesa3gjOZ2yZjUy05Dp?=
 =?us-ascii?Q?AQbqJ1PZ3bva9aI0N6zqL0tTS5BAY+j3Qt1MDK1c/Cw3boqf4crDcP5jE1nd?=
 =?us-ascii?Q?y9Q5r8LAo3TD2lXqV+0jZEAdgCGPWwHkeNl/scwR7a/ov5Zpt70CHzc8EadD?=
 =?us-ascii?Q?vbJr9re+cBZESTILFS71dwE8g+sI0oD8P+fHdJd8O4T8t9FfBfduM1w1cLTn?=
 =?us-ascii?Q?vShGqClLCg7ab9boFXwXlADaIusjHfABIAItx6vi8mASx9IsfyYMZYhFUIjD?=
 =?us-ascii?Q?9DS4D+RiC9kNrPaLUD7V7oiAGW7mqQLNovUUA9P5NwejWGD357EkyeYkUc+5?=
 =?us-ascii?Q?BCu0G1b9KiyAj3XYR3E3GmmFrNdKwuezfb/Qu1vk442wJ3Sg5KtZBjkj4VYD?=
 =?us-ascii?Q?G4o25nC3xtiAHGJUoKvO06ConBBUSvE1r/vfdIpIwGzlO24LRTKUExAS+pQX?=
 =?us-ascii?Q?+wl/mUYf31zVsYrMZPdIZWXY4jkm/wVIdQLknen6xNdROnDPSJ+KtI3tVrG7?=
 =?us-ascii?Q?OMdR9+2+/ZhcdMJ6ha6x6X5d6nU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac9f039-c962-4763-18fb-08d9d65c6c8b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:17:49.8994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJrzANuJtfYFqWuJ+FQHDKd3EAVtgMkTDBXEubLiqOV2DOjSEDWg8FICW0RwGW+HpwsQ8YNr6ExC/O8zYJ41kMgPNkpizgMvc8U6afAtR78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130033
X-Proofpoint-GUID: FMgmKoQG4RgfN25J2CjG88eD6lTjplF8
X-Proofpoint-ORIG-GUID: FMgmKoQG4RgfN25J2CjG88eD6lTjplF8
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org, yipechai <YiPeng.Chai@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, "Stanley.Yang" <Stanley.Yang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, John Clements <john.clements@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These if statements need to be indented.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index d4d9b9ea8bbd..777def770dc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1714,8 +1714,7 @@ static void amdgpu_ras_error_status_query(struct amdgpu_device *adev,
 	}
 
 	if (block_obj->hw_ops->query_ras_error_status)
-	block_obj->hw_ops->query_ras_error_status(adev);
-
+		block_obj->hw_ops->query_ras_error_status(adev);
 }
 
 static void amdgpu_ras_query_err_status(struct amdgpu_device *adev)
@@ -2722,7 +2721,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras* ras_con)
 {
 	if (!adev)
-	return -EINVAL;;
+		return -EINVAL;
 
 	adev->psp.ras_context.ras = ras_con;
 	return 0;
-- 
2.20.1

