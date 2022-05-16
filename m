Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF6C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C9010F125;
	Mon, 16 May 2022 07:06:24 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F3C10F134
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 07:06:22 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G5WT1w000545;
 Mon, 16 May 2022 07:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=1WhnMuUK5G3lCfpefDME2rIlpkOpCVEHWsxywNnTTiA=;
 b=QeRdguqGBMpwkpfO6gkkQ5lI6FqKBWlGACQfvyIRpmhTQHtaxFFtq7Zxya1ulw7wnpHr
 By/u+8kLajEAsevK8iUrhL+0zFrliKT0uhFNra7eLLyKzt27phqLC1Enr2ReSC2ZDbTY
 u9nNH3pJtKm2/R+E0dlEqHnsVGzdidgBES45FHzf9aJxd8sUnaqYpq57N9xFOln5SC8o
 TVFd751Jpb9dblWlA4eGNiQENXHt3KScEiO04vItI6pswRHjD2iSDPAQU5jaSVCwIoqG
 hCddQj2QXQFtDA3i+1IxAwIj0rOKNVYC8rfmpzqFieJTJnhYM9Vx7Zn96vLbBLlNfKrk Pg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g22uc2ex3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 May 2022 07:06:17 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24G75Rw0008998; Mon, 16 May 2022 07:06:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v1892q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 May 2022 07:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeeNhUvBwJBXWcv4QDm8TTStR2HEdmtwZ+Cg3JVcj+4czc/fg3pd8Ww04Pgns0B+1h5y+SaQ4HCfzRXNFqYiouqCVjxLH/ohgAm6kZonEtQVeG253kpfsUuUJGCnpws5UGO8wbSwQyQKijbhEXAhAjTx8dZ49UCQvKA0plNQvtRyumDt0vJq+kry2Pd61RyOa0Qa4xkKT70vZSjgpAOSacW+QJwTqux/7rQ1ayEUZwCf+mDYwM/mloURl+UR0U6fwzIW5O7GuHNMmkVRJ+Cgi6CRgGpngAQivEnfSOs6iQ6IgRUhzP5WtyiB4TGQNviwZnU4mYlH6cbvN4nTcJWrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WhnMuUK5G3lCfpefDME2rIlpkOpCVEHWsxywNnTTiA=;
 b=mlx19OyhVLR62K7aYCxtOK/13hxmv+UuMJB7mxrB9jLP4yKxvJD5ADjarUbtcGGDE8lHkWn6D7PxP/A3YFBLlvjIGQDE4SZ9v71TFmvDtkuxGjTrEtsuOdQYz3rPLx9iK9DBk11izMcqoQjkVqsFBDE1g1TuYkyksIr+jEaDUnr1Wn8oM2nJaMk6FOqhQf3o7c9xfE1VghZhFBjDsr1ntNrJNY/9sS7m7PCkY5fI9vkzNCvmc3UyfgpNyIESWCJfNpunC337zKrk3KGyPeNEW50trh0dkYKM2TI0yzls3T4YUHUKaKG46vnXECv5RKn7eRKvlsQR8yNvI/YaK3DIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WhnMuUK5G3lCfpefDME2rIlpkOpCVEHWsxywNnTTiA=;
 b=oM+MmqgeuKtHZJ3CBTac1p0J0bOQQ/AS88jw4DS6PXAVQ5y8DWYl2SoL5qSIPU9SIvJqKS9oQJUTv3m5V/C8L2aIG3j3IRMUNWgv1r0HGKKlrY2nJWDtgL1dQkg6oooBsCAv6QIzn5NlCPm4yxQYVt7g5rNYf7ebPQvNYZhGTa0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB2002.namprd10.prod.outlook.com
 (2603:10b6:404:100::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 07:06:13 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:06:13 +0000
Date: Mon, 16 May 2022 10:05:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>, Jude Shih <shenshih@amd.com>
Subject: [PATCH] drm/amdgpu: Off by one in dm_dmub_outbox1_low_irq()
Message-ID: <YoH3zD7umruSyPms@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd58e23-bc8b-494b-41d3-08da370a9038
X-MS-TrafficTypeDiagnostic: BN6PR10MB2002:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB2002F195291873262890D7888ECF9@BN6PR10MB2002.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGt2A2joamQw5xjD0w8HKDEXxpOHRQalemfmcJrX8/ui+gS6Nsjt+0t6sut5ZwnHPHFmxfLVFjyTfxzfHicT6/SEe7MWfQyV5WhEq6ORlwqOhoGi7DKrjd1bFKt995xdarj/WQPfsavb1SYrBmUzd8vfbVBr3ebQiHBa+MFSWfi0KHCcUFUV0EVR58rrnnX6UpAopeH3HPMiVnTYfoZZZ7P/Qm83FCwTcU/PsAdE/Nm6MmPn7/nLfp2om+AuTWO8q8i2PpuMBceYqrNWsUvU3nVqXjtdCR3lBn+ZlQ2mrPhPqT+mrkIspbvFd2IwczzGgaD4vUQpF2uaI+XBzk2iy73vjGZYsUb2iReERoOx984TJi4LjTJxoIlP1gqPk17ruJ9r+t1mNPlbxhLGFVLnenseATDO/WQFKhj8mtCMXpOypjZ7kPxXKkGOLCbAD0qkLL34qkCvENSdIqwNxi16bejpTPwb6rD0tE6PKuGHI0EdwardTFw1aWkOXjbs5GRfolnzA3RdSxT3NuOJMWCbwc1ozruqTcFV0W39zMuXdHlCNfnKGY50f8Crh7QTo+FJ/QzoaDE1t3HMlQWdZ+ni93vqem9V6UFXl3jYKdyG51u0rjIPiFDzaC60zoTOA1xUpIQll/mxxICGfoRBQRfmb4Rt5ClfxnU6d4jfdS5HRuJaCEhq1nzc3FV0ALyZeH2BdbUyKYBzWUKuXvX4H0EAZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(66946007)(54906003)(38100700002)(66556008)(86362001)(4326008)(4744005)(38350700002)(110136005)(33716001)(83380400001)(6506007)(5660300002)(8676002)(7416002)(6512007)(9686003)(26005)(6666004)(186003)(52116002)(508600001)(8936002)(2906002)(66476007)(316002)(6486002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHKfJLfXLVWTrbRhVl+v4iT9ios0yBaBk3jQmwyqLuRiSbOUVql3gtrcaRMp?=
 =?us-ascii?Q?Q8BxPlENRVH91IOFXIE7U5k76rpcIRxC4cEVvSTS216eP84p7tmgIgP94S0X?=
 =?us-ascii?Q?KoSFWKMTrEU8inoMGLQE66XCMJlRP87Oa4FPq5msUdBJMgP9mBgGtqDg65tT?=
 =?us-ascii?Q?KHAHxlIoKewjNFgHRbGHlXgK6hsTRbe5rnrmwVnLA6zCxlekDDzNLg9kcPdB?=
 =?us-ascii?Q?xG7SGnjcM0LI6O97lwIiLhvlITvPeLSZ6eWpl/+bXburlhnpREYPXK7XzRoE?=
 =?us-ascii?Q?/BNtMSif44PWkk5Yx9wy3QLRyuW4mfV6v/LRPRxJUVMVoQH6WtHmW3SylGds?=
 =?us-ascii?Q?t3ZEi2eOWRRP8M0G9q7HY83/T5TeAMHG1b4u5AXCJrnkXgAwlbLavP/IOwx1?=
 =?us-ascii?Q?E8/jjeQ2YhF0LSEcVz4a0IPVhLflQoslIZR+fvhqvx6WHQKyz7S/+VNGkTjf?=
 =?us-ascii?Q?rJgaB6lUqKSHoa+b85mMoChrqBBRJ3sWEszcyznqHnKweVPU3dbsjfQgJYF8?=
 =?us-ascii?Q?f8E4dnzyLNIze0ybx/q63Qk32q/sCqWzTG0hzrqRtfTycU8xv6OdU2lzrWRz?=
 =?us-ascii?Q?WEPPKqG85KnUg9dfYBsoJgHRZVm8TuLq+3AkCTn7iwkmD25wb0itJfGvAkDs?=
 =?us-ascii?Q?HJJriexWBr6ENBDXpzoFu/Rg+OP2Fq2ILBuIe3fytuLWfVypaEFMDFGYjzQN?=
 =?us-ascii?Q?ueDULC8uIBwLbw9gj9em9ZOqUyvyf6gGctIfYDjfjvLbicl/AVw/++Efv5DT?=
 =?us-ascii?Q?9QEVEEjdezsA52KlKN/RG2M0dr7LQrxDyhYn8JkYyHgC5hdlLjU7SlJYjOXV?=
 =?us-ascii?Q?AmYSiafYUG+XXEttKHl9MX9LAN4EK5iPYZJ3bTuI1X3cfzkYsP10ai2xubvC?=
 =?us-ascii?Q?N/6Mjz0hsqbVxjUsgKpJ0mxMS35iH7q/F7EaZNnp/Kv+9ZMwyvBvaZGJ3g8v?=
 =?us-ascii?Q?YLO68CBy8R//HR/HUeJg0MDNlnEaqPYP6i4GG8Hz0I8gx11S8loR7S1gXDTl?=
 =?us-ascii?Q?4sJMDDoEHBuuP8TUBV3hB7TiHcjyhnE9N4x+0IRskCcaiy8Fn8AXVji6g0K3?=
 =?us-ascii?Q?hn+/FoAxCM0VnZf9BhCUOOa2WC+jhYaeuOdE4c0K2uG29WU9+ozBCI8zZ2wa?=
 =?us-ascii?Q?fB8sMVs7zF4M8M1Ts/XE6alZtTNM4azkF0Rwrq/QfPe0+MmrkdqU2ITWCv4c?=
 =?us-ascii?Q?z0OTY3VkhBRP5PF72CTofy1Gpb1Ry4+LJGbxm/rl4uSfubMYx6TXABTD6jQ9?=
 =?us-ascii?Q?1HrXhQaY6ShgbtW8yrsc89XCpsHRRwam6HivG0gfmR1mYUwpwZwtu4QfmC0c?=
 =?us-ascii?Q?gAtw0SIaX3WKpjl1RJimFT692oFWozALAj9aUTKRgdcwcXq/0WOE5Nn5npQ0?=
 =?us-ascii?Q?Iy1WrDQMO4uqO5eWFpKX3Y4r6jkaieTvpCN/9YkMhTwXEzbYz3wPeCJ3UTnX?=
 =?us-ascii?Q?fDg+kQQWOXVyOv98fMYPCApTT9QhqfSpc35IvUZulHp4eOu2Z6Iv3EMdSBNW?=
 =?us-ascii?Q?pZxXrQTm50No94dZQtWU3xAAoH5EntKG1JBLKuRsQs2AAExJ1J9sGsR16RGd?=
 =?us-ascii?Q?RN47+0x3E0vTtaxnuM/DU2UrYwCnhJIilQrargua6b4DyFomCcODIl4lKFnz?=
 =?us-ascii?Q?NkJLiiF+bysVUoxnHo1nxsXfPbvx2AEv253h5qj3KpwZhJTCGYBm8B21xUWJ?=
 =?us-ascii?Q?vCyo/D9hY5sTSMgFIYwwf7jR/JYKILUter6ZHlQbFx7FNVubjBOZqY80r/8q?=
 =?us-ascii?Q?4xWW3s6hdfSyg0wozBFn6DRGYoir/gE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd58e23-bc8b-494b-41d3-08da370a9038
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 07:06:13.6246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKmAdW7l4xNn2TUx36rmKGbuwHxB4ScOJeP7FEsYMeDSuWYO9+xObS6yr3T/aOYVmCAGXjsXwLyMjIebaXXvURwnSRwqY+GR/2qutLx+t9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2002
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-16_03:2022-05-13,
 2022-05-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205160038
X-Proofpoint-GUID: hZFrXVADUhHvT4rmSjHHSC6sXeMI4hye
X-Proofpoint-ORIG-GUID: hZFrXVADUhHvT4rmSjHHSC6sXeMI4hye
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
Cc: kernel-janitors@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Simon Ser <contact@emersion.fr>, Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The > ARRAY_SIZE() should be >= ARRAY_SIZE() to prevent an out of bounds
access.

Fixes: e27c41d5b068 ("drm/amd/display: Support for DMUB HPD interrupt handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6edfc0963dab..c4f122c6faec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -770,7 +770,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 
 		do {
 			dc_stat_get_dmub_notification(adev->dm.dc, &notify);
-			if (notify.type > ARRAY_SIZE(dm->dmub_thread_offload)) {
+			if (notify.type >= ARRAY_SIZE(dm->dmub_thread_offload)) {
 				DRM_ERROR("DM: notify type %d invalid!", notify.type);
 				continue;
 			}
-- 
2.35.1

