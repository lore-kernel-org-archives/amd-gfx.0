Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75EBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 06:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A8D112174;
	Thu, 13 Jan 2022 06:16:33 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3759D112174
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 06:16:31 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0g3w7011338; 
 Thu, 13 Jan 2022 06:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=XAp7yEJqdiZ7WKg94NcJ3zrdo2JPL5w/UCRygBXzaJM=;
 b=Weyv/pxc6EjZdoVpuYJchxU01CksxuEA6y3jpa0OyyHuVkDV7k/sjTRBNVme/yF8g/9R
 qNZJyZrHFAF2VbNzqCCccxHk8tf1msozKr9UOmslY6xWdflYuenmPnXeCR4sZUYOyEuM
 kEPHI5pNvzqf5Q00UMt1KkAhiY07kwpBp+aK31Fo9N6VoFfZ5U2c0M+c4x9mQ33/GfO4
 vneYeIwd9ntIGMOMT+45A6er7L/IdMxVJQpRxK+iVrv7Ao2Rk+OpxRjLXdfriOTYksB6
 +uEl7Kmc3HlrXv04YmTSXrs5oE87vVYkE9+SeXa/jmUrnW2GF1zTSDC80dgxBY2Vbii9 GA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74g3wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:16:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D6AYGZ022209;
 Thu, 13 Jan 2022 06:16:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by aserp3030.oracle.com with ESMTP id 3df0ngks01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jan 2022 06:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYOk/0AKSK7GSh+n+CrkHUNSm5quRQptYGnJ0LqhbN4elVVME+chW6Oqk3KirCgZf0FcASNUSUrRQ90qKw0NuVZMIGJNjyVI6TlQ25s/wspozb3sl0VT+Bv9vS44QeND0y3EOjFzs1a5NdsLcXVoyP1Dxskr8Z7DWm7OztnKdIIGcu3962HuNztoRnWwTseFS/R5e24dwV+dZkRTXRwuMGgCRZSG4GImw7AB6/h9kzhMBIjTjDPzSstYqvEEVvxQfowM3j/eLf+8473PwdEhjxOu3mBQPlXqBkXUDEAnLgQqekv1ppgW5ewPKwS2nAEYCN1v/A+2CFOBpHdU6MVEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAp7yEJqdiZ7WKg94NcJ3zrdo2JPL5w/UCRygBXzaJM=;
 b=F+7nWGqdYWwZqkQ3GmXxWAmQCuY9JJhap4RtC3mL8MqtTIoddE5HLH6FXdsLGQvO+8XstEFsOLf0ENakFoxPb4Yr0kJ5O1fRbJk371SazH/Jro+GwWGKOcnrrLeM+mluCb/zvQ3dSBoVYZhV6qSeKMJqx3DYkZFdFVA+476GltPwPrSQ3MaHipraDBMWJbdJ7mI+E9gq+CnEzIkebpocydUwOz2tzXmMmyl7HqIRSWdTbMU0mP6Eg7N/sD/RVnNoE/6l9wkD2QMHcP3xtWF0P0wPMr4/ps7IRfGcj6urI+aGIJ7z+apq0NpnXL1GHmx4vjlLiBmKo8pZh8ktbQ9S7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAp7yEJqdiZ7WKg94NcJ3zrdo2JPL5w/UCRygBXzaJM=;
 b=XRBUn2qQk2gNz+Uqgl91WoJ6MWlXoiQxa7DWvqrhoDeDw6xULUAKsIs3NH6SkVLUSVXU9fQqUcAxzjfaUKIGc55dW7R0Ufg0gJ/kWJ24rxm0XBgNgglrkEbAXE3wFNG/5Xccwaitq6NIbiMCNyjVurMcZbLFp60cJiPm1xn+NOE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5790.namprd10.prod.outlook.com
 (2603:10b6:303:145::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 06:16:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 06:16:25 +0000
Date: Thu, 13 Jan 2022 09:16:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: YiPeng.Chai@amd.com
Subject: [bug report] drm/amdgpu: Modify gfx block to fit for the unified ras
 block data and ops
Message-ID: <20220113055038.GA3978@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0038.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332d3795-4f32-4022-47da-08d9d65c3a14
X-MS-TrafficTypeDiagnostic: CO6PR10MB5790:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB57903CEABCDB6965B7A5D1CE8E539@CO6PR10MB5790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTSxJz0sKwYsIRQLojrDDKF31+c+uPfjleJFeFiF2ppBUkcK+khhuvZAdpavKitctNbmZCVQICKRdXPaHfqt8Eo11+kShccvPduPNz/G3CNr79J4Qov8mCJkgLEFOxOk2kcijVMPUISlfxK9jsbthYRT1+jF5+rXkOHgs9h+8r+scdt9UmNjPa+dM+PNsifXWhx8EPkE0IZRqAyu1fUGoGjMeSeSdu6E28xDeVkq8jGYBAAYGQZbH56IP6ZiLZUiA0jqR9jbDphmfLS7zJUelSaV0pI9IQHQhhCrmhE3Joe9FNjvFvgCIpr7Xn2YEo+tzm6cxxQ+BTAkpizpcQu++/JfHiSk4w+bEv9/E4tQNGJylERLf7NJQvDhxjXc6L7BKoxLrXaKz/znoxvkrXQfdPIBKspIgDtDbCEWFc81EFbhSCFwp+curkf/kZ9jTzRJBs08iWWpyMLBce0wvxR0jJVy8FxksmgnrT7c0EkhDvb3jur0OykEHW4ZnykpAY4FK8CCVaKPcV49eMHF/A7MZPXxZ5dk1Lzg2N8hJmmpfRJqzZhMYo9hN0IjtS9GinNiShUR+oEzoY6OLjtnhgSyamvygxJdHqp21SBu1tORE9zETct7LpcgZPCy8EQ/IxGz2Vb60MlO8ucy9nvLKVvf9Uf6T1FUHEFaITXguN/Amq0z2WP+jz/3895n/D/6dXf/lMjEylvlXPGh3il494Dytg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(366004)(9686003)(8676002)(6512007)(6916009)(6486002)(54906003)(83380400001)(6506007)(4326008)(44832011)(33716001)(66476007)(66946007)(33656002)(66556008)(5660300002)(38350700002)(8936002)(1076003)(6666004)(38100700002)(508600001)(86362001)(52116002)(2906002)(26005)(316002)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U4y3HQ66PmI9GL5RASS0M8tcjMwtQBqYruFXN5+pGHF2c6VSZBYr7TPEyTp8?=
 =?us-ascii?Q?Ej0G8TV07AQaXF12b9HZZPSzoM532M4luVDiz6GP0aefWDfHTVUCjwq9Dbxt?=
 =?us-ascii?Q?1+s/WmWeULkZqYsG7elJP07/KOjbjlbqxKAhRyvyM6TP+10ci/+9z3Biu6HW?=
 =?us-ascii?Q?OWb+PJBaNt48QxAA5LL18T9bkpfLnf2wNyU8rLToZ4E0Y8EhtyAevus6MPRp?=
 =?us-ascii?Q?t8lX1oh1Z3vof2X6xuMkrvo003At4x980wTLGRf7mSEk8bvip19rdzZMRg4s?=
 =?us-ascii?Q?e/2f+R9b5AxACEcta1ZyUf/KSk6wjtAPdmqP1ExXDuYWDAQxK2dgICgL8tjV?=
 =?us-ascii?Q?OoEKlzjJUoJZzecPaJi/i/0sBbFneZzz1apljMQQnZ6EYZAPfNhZwAQF/V6k?=
 =?us-ascii?Q?sdDzOu6XyygUF0AoxU7YucVBK60efHzgGXu7jGjf8Qbfa5xDHLNzGmFiXroR?=
 =?us-ascii?Q?FMGedEDFz4X3zrPO5a6WYOlL7fKnhpiR+zoUzXPGvLaUb2PTpmEExdQ6+2wu?=
 =?us-ascii?Q?6Y+24AFgjfmRmfwSaXUu8PPQbRGboB4pm1dWZ4uxT2zDW/dCftE9cxgBoiHM?=
 =?us-ascii?Q?WOp+Q2RoTvEHF6buOBbiFiAxG0YvbP01bHHTKS5qwGu3deGJQ0DhrxVgUdHD?=
 =?us-ascii?Q?tQ6HnsF6OrRlB0CT985CCxRTjwDkN14tc45AApkbQpMHtKmXp2G4uV5GhbPU?=
 =?us-ascii?Q?ltmpuMX4x9QxGMRTukEA7sG49/ttppN/QY23p0voqqxSq+RHoc7Yz6ls50rw?=
 =?us-ascii?Q?qv//dEg9gOm0/wG0pjezO2uIsyKs8F5XbpRgMiUt7CvnESyYvSEFSGF77j6C?=
 =?us-ascii?Q?4Ic8nn5Ce5IvgbOoreelXYVMTaCM1FZjytn4pR4ON3CYFo4YPZyVg3V3Fjjz?=
 =?us-ascii?Q?QBBNvF39BjTO5oVqVm1oJw+wlE3Wd4ONywnwSh0S1POVao7UWHLBU462BEnf?=
 =?us-ascii?Q?eis+GybkWKbuC50pqcoqtkgx0j1m8UcFAODYGAxTNIWuEtKGe2P0HyTgNehT?=
 =?us-ascii?Q?2jSOf0D2w/rNZvsNGlAmBhZuhVTlhM1Wl//vFYVPP3uwNWLI1kIL54dYFQlD?=
 =?us-ascii?Q?elIWR32wCd9z8eUcL/p0cmZAzFmkOk9rrI5M3EWc1eOGn+uaeFRADVOlIvR/?=
 =?us-ascii?Q?LJeq0LAS0GTb0Sx4D+4KeO7scqaGxWC2faFSJun/sNts8jUJhZf0UYjTRMO5?=
 =?us-ascii?Q?3/8mmrqcIp6Jfo4uvsLESeBDBfUuS/trCMzrpsHpxdfqB/ptBg+FavzWV4X2?=
 =?us-ascii?Q?93h1sMjEMQXW4SfezjA7r64T8snK+eA7ByTvWeEvWqRJZsYaH6A+TKVxVUv0?=
 =?us-ascii?Q?PsCSClQPBjvLa1zljYUrY7GfSptLra6BSXMXwzeIbs3HY39k3wx9sS3XLJPT?=
 =?us-ascii?Q?mXYXyCtINxfERtAoDzOcsGUiVu5vabtyyNPl/e/XQHZKy/f8bmAq5O7oShaZ?=
 =?us-ascii?Q?olS7S8ddGOQ4y4OLEvfXn81kyIv/SWVuxmbvoG7Jza76HzjSqn8/zg/rd7pu?=
 =?us-ascii?Q?GudytRO9iZmZUBhzUPf7yg3Ozr0/RAxjW1NANFFWNvqrxhqsjF8XWj5r7o6h?=
 =?us-ascii?Q?kkc1EXxR9MXlT9G6JhHnOQC0e7ShAaaLyYHgVWpURsviBrRST7I9PVgQSdLA?=
 =?us-ascii?Q?KutvHIM0+qUsQtxXezNoc2ZenDXTIkHuT788QxvAyzauaU5WeDmhKYBwIiaX?=
 =?us-ascii?Q?L4MgZQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332d3795-4f32-4022-47da-08d9d65c3a14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 06:16:25.1409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgvgZJtfIGc1STzq+Z1otjzsmP9n+5k3X/xO1Hewj3Fhs3zhc8FU5tTB4vLiTtZefoAEE+gNJFlCYwSbqcXUgXXZyYO9OzsGbW6cBZEUWE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=799
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130033
X-Proofpoint-ORIG-GUID: 6rG7qeCQhWStRCOgf-YUzMjaqhGjgUDy
X-Proofpoint-GUID: 6rG7qeCQhWStRCOgf-YUzMjaqhGjgUDy
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 John Clements <john.clements@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello yipechai,

The patch d51ce4db0747: "drm/amdgpu: Modify gfx block to fit for the
unified ras block data and ops" from Jan 4, 2022, leads to the
following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1058 amdgpu_ras_error_inject()
	warn: inconsistent indenting

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
    1047 int amdgpu_ras_error_inject(struct amdgpu_device *adev,
    1048                 struct ras_inject_if *info)
    1049 {
    1050         struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
    1051         struct ta_ras_trigger_error_input block_info = {
    1052                 .block_id =  amdgpu_ras_block_to_ta(info->head.block),
    1053                 .inject_error_type = amdgpu_ras_error_to_ta(info->head.type),
    1054                 .sub_block_index = info->head.sub_block_index,
    1055                 .address = info->address,
    1056                 .value = info->value,
    1057         };
--> 1058     int ret = -EINVAL;
    1059     struct amdgpu_ras_block_object* block_obj = amdgpu_ras_get_ras_block(adev, info->head.block, info->head.sub_block_index);

Really?  You can't be bothered to run checkpatch on your code?  AMD drm
code is uniquely bad in this regards.  It's the only place outside of
drivers/staging/ where you see stuff like this.

In theory, it's admirable to be this informal and free from bureaucracy
and rules.  But in another way, this kind of code is like plumber crack.
You might be a good plumber but it's not attractive.  And we might not
point it out, but we all see it.

    1060 
    1061         if (!obj)
    1062                 return -EINVAL;
    1063 
    1064         if (!block_obj || !block_obj->hw_ops)        {
    1065                 dev_info(adev->dev, "%s doesn't config ras function \n", get_ras_block_str(&info->head));
    1066                 return -EINVAL;
    1067         }

regards,
dan carpenter
