Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA08C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E120110F3D6;
	Tue, 26 Jul 2022 15:16:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6074712A95F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:15:59 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEEPYg022640;
 Tue, 26 Jul 2022 15:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=QnDV5xsz/33SEZCiaUna21aa3qybbv2pijstClJDhng=;
 b=zp6TyRN2xEZfYrxkAbkW8JMbNHNlBLBjkCEQmDtO6TTvrLHM1Qx1/MBIX7R24sNiPjy1
 hk/g2m0c7Je3TcH8V6RVwqLHcZpV6zOCU4P4MEcdSedgwMymT1EIK9bSHmny5GSzVpVA
 jmbf3md/cIAnnfYvxoGnH4XkcfJIViny2WnBeuWVkJN7XVvoBc/r02ZBzrAk5xNPaCLN
 YNpNDeMQqedrpvYCquPpLIedtDZlVzWVfr68FIMzqEmG7y/RBTs+uNnRiw7dWNZzy5mi
 mdBj8lioLAztLUYKwHxOvTAiZ8hsryO6XDVOYDAZoLq9SlR4jUu+f1xmNvS5+e8kaanf 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anxfjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:15:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QFBAvm023031; Tue, 26 Jul 2022 15:15:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh5yuwcww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6/sX4YwsYJ/UEuxCTKoK6NXo20apv2YT2SvGpyOI0LFD3KBKd0bywCjg+b0eNnhNIV/YFOZIZdnqKjDDZnBmw2JH52Z4EXT4nhgevagS1OMI7mkKhC/r66uq2GgqcKUtQQKSWR0U7G8um9XP0Cy8+3ljoFO1V96uPMKjtvrX52s0agFCw3P6fZm+hdsDQezNzO8E3HcXfqSH40LzJpIWDQdQT004J7W569PtJlVFcv80xFMuTjSyAfCxGvAhiUJAiZbD4B1BKV8bHMDR7VY+NKB47QtHFY3fXhPczLV8N7blf7QgU7vY3AjZ1sOe1engZEXmPLB5MkXuelqnfH/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnDV5xsz/33SEZCiaUna21aa3qybbv2pijstClJDhng=;
 b=QVCPUjEj3McAnoYxuHEcFWI2S4bWHuoXOfa7+cKndaSK3QGm1Yf9uTDnkWnqal8AhjyhSXcTjtvu3HInNopGaF7dQIM2/tPGPko+l0LraLVdAKnvIrQs/uwGNcsCPeIeHIrfgmAHYKPda2A3hi89pGBJjBZV3nJE/IjcG5YwY2sal4uLYyxW/8AV5Yg4IR/COskkfhgHai/VLrJo4NpRx9Wy/y4O6CmAx0EAXEnTlqAcc3Yu166IjPbcGjbzQ8+jHYXjVef9d3vJgO0m8sEShIGCa314AGyduRTgbdu14gxE6Vf6buIJyY8k5YTlK1RHtSvF9M34PcabGe5WtTpEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnDV5xsz/33SEZCiaUna21aa3qybbv2pijstClJDhng=;
 b=F2wa5Tx8Q7KfX2H9V5lGPFlUR+yuU0Yg4Len0XGVu2ofcrkLUmPXk8cIWHAOJTwvsFrS2+16CunfNZPoD4lnNaH+qDhv0N8Ertjj01EPjnr/L12JzUeN9pkpJeJGLmIDTjGvLl5yH+Mqn5CH0NSWVEV6c5OzlvWvgRPH0hqmP40=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL3PR10MB6017.namprd10.prod.outlook.com
 (2603:10b6:208:3b0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 15:15:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:15:45 +0000
Date: Tue, 26 Jul 2022 18:15:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: fix signedness bug in
 execute_synaptics_rc_command()
Message-ID: <YuAFEwKmf1uJz0e3@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0138.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb289cd4-fa20-48ee-9d07-08da6f19b698
X-MS-TrafficTypeDiagnostic: BL3PR10MB6017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wPx2KiFYsDDLtv/uJo6lnOCzuSvgYXARf9g3Yg7Z8hz5NHD1lwDG1c1Unq67OHG0t/utASqzGav0dFkCn+vIu7YqCFjEtlTmd2Gw9baf/dtP+H7DeXvmElo9kPChTHNITqmG6JvXWAvLjUpjlxDhi9OasX0jX0eiUux/2akiuNujM7gWIUiRodV3NM9pXuqbS/ZQ85n7V3bvFENapHmB4f3DwhzF5aMKbjmvAC9QSwcN/o8SdId668nPM+OMPEOB32Y3t4ZWuwuLavwx/MPuKbozFUxDtoJKx1VCZLUqDogzQXydl/sftTzNCyF2temtv3+LBB5jyQ8m1aDxtgxJD8iok0OKksCqgyNEriZgJ1hEKFyz9RGtsep0hO2Y/zuqP6jpmokSLRXzZeO+xZ7o3VKOpHvuGj0/SwRY2fURjPIg2aZPoAKaFv9HY16PM3BlmipCh3Dk9cIA6ouUOfLrzXtjM9yq9oHPYicrqCXFLADzzlF/V5UKZZXm6q/ugBATMktPPTSUu+gLRS0tOx2nnRzsBC/3vPFxyJXXSSqWQ9KA+rsQbNp/Unng2K6WiHhTxAFPEB0OWgCjsbArLg/Jkpi1FZlIatxpr4kkEgjDTZ2ubs5IU3tCB8eENV+q4zRX4MWpwE1GlwmLn0JsSvnBDiVbm+2o+zO5/9KmoW4isRxB8J6vbHuQAKtjjCDaCq6hf2UBxbfzZuOTh1Obe0Ctbpy5vWz8yWdMBrfWVjby+zAJOKjMmWDS440M9jYOgECJyFORk3eF/ltrq2C7HVa8j8sTZSiwBpvDtJAB9K8QAuH7jFEB4hdKVute7lGUfULZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(376002)(39860400002)(136003)(366004)(396003)(346002)(316002)(6916009)(41300700001)(478600001)(6486002)(54906003)(2906002)(33716001)(8676002)(6666004)(4326008)(5660300002)(66476007)(66556008)(66946007)(7416002)(44832011)(4744005)(8936002)(86362001)(38100700002)(6506007)(6512007)(26005)(9686003)(52116002)(186003)(83380400001)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XKsmWdKYvTE0pkB0WiuPEj+Nz5ATRZAYl7IoGS57idZgf+KGUak/fCwYRP0f?=
 =?us-ascii?Q?n+n7mYVeRPfvhb28IYkrD/89zWVsL4UhSvTDpHVbWlultgaZSIrtpmg+0oxX?=
 =?us-ascii?Q?RnoqCnQ4E2wC/QHi2o2wSKZqb1bDze23vkzzL2SCKcfU14l5o37ORTLJiDmk?=
 =?us-ascii?Q?zx8T4Ps+S5pWsWTSoprv0JTpke1cts0uWdjSpodfFrL3Jxlw5Mt9Mkh7voxP?=
 =?us-ascii?Q?KPI7inejSWe6TxzhUW2VjJNYMZ8HCYw4DocSKumKaTYBWbPwROPXkZ/wOMMS?=
 =?us-ascii?Q?fLY+QnYKb0ZYaj/fzWpsmV5+bK5fenDU8JrfKaUYlhaawfbiIkJjaPJ3xf2J?=
 =?us-ascii?Q?xmYwLi5aN3yEbmdAkblIC224G6Rsrd1eei13kVuaC9L2q5w3JWsgTNvApEGx?=
 =?us-ascii?Q?UkvexrH6OnWcnht9YemihFzsuAHfNyZkUJSubgwdDjUxzWsoZzAcw1MUEC8u?=
 =?us-ascii?Q?X8USmdKkKlSB0ZMoSJ8nPRGdj9w5Xh2yH3+yXYgTX3SA6dtMtn7z+P1URgjT?=
 =?us-ascii?Q?Ls6PYwixtFb911KuiHLl0R8aFdyKGW6XzZ41djaV0D89dbk4DfWOOJ3DMcpl?=
 =?us-ascii?Q?i+4UCNfv3hil1gQDBiSXxEPPwZCgWpeEhfW341ek5Z3VoHXwXAGc68pFZJgU?=
 =?us-ascii?Q?GQe8b9YOLkqxE3R5TIF4DdABmn+UPYAbi5r6HUeR47TlTs4hqcaVu/fsvFMZ?=
 =?us-ascii?Q?G2pyguuODYRjs0v+87R7d3Vo+YBf8Tea9Ic8CLdlKHXwmcIYD/P4pxU+6vob?=
 =?us-ascii?Q?RXzr+SmslvieZukMu+IA7kRt0Py8CPNJ/KwBny9bGWT7IgV9a8ny1fTxGxAI?=
 =?us-ascii?Q?9RcnEt2plg8ZdN2zrdO4vL6txIjF43bl8wajJNZBiv8uEa68/X7pA76PsPoU?=
 =?us-ascii?Q?RamZ7pgVwztdWb3um0WpVwP1bk8vg5WQ4oe4wUZlyUVH78PDHktrBC2lLVWp?=
 =?us-ascii?Q?cSibtO5rQiIQM8kdbrX/tbtExh0z+VSaq+HGZxfuP89r06rZrnemG62hhN2y?=
 =?us-ascii?Q?tj81B7PjoXme/RPi6hwRi5iejzvvzJDIwjQLfR2xv86XQCV47MhN5X4WpXbN?=
 =?us-ascii?Q?2XAjXYwqzT9PPB0Fs3vcdkAxCfIexq4jwWRorWbEPc1VxgaiZ0ozALubn417?=
 =?us-ascii?Q?eOfRGNDVxcZnyvit9Jwt3cl+UVmgD1Vz7rTv0hRLKav1mPUVkV7BawZWvJv5?=
 =?us-ascii?Q?Xw6XfIbp2wzmPriKl0aBd5yPKv8vvvN0JfYIMuf+ef9y2g0buhIp3Vu0oD8m?=
 =?us-ascii?Q?V6OkLbH601gWavWIaQ3yxIieM96YdbHKWrtowe0mmkW9FrrdycNpHQv9jalZ?=
 =?us-ascii?Q?Rh3Jr7+7eGGH2DUYgeh3s2Md7OAJxF2CCop5gwmkeTpGd7I4DXrlzE9NcrgF?=
 =?us-ascii?Q?wD4sNnctzSXXh1ZVXaSZFAaMUBU8nSGQfIzhmPQRP5GYRwVV8TF+medyFrpo?=
 =?us-ascii?Q?r4Znm9SLfTkKQdCQkFpbsOJ5iBxPYLXnT0aY/l7sj/ceGtKnAR04+6c6OpVs?=
 =?us-ascii?Q?H2QXGVQpFSqCD3/wt+T4aW0p10cyEhIOg4VmnjnkR5I9LxktU13jBQVSd03w?=
 =?us-ascii?Q?2Rio7zKwuVZbfcYDJv+gUUsGiQoTUvU2JABZTJCfFYiCUvgkgqsU/XxVy7+x?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb289cd4-fa20-48ee-9d07-08da6f19b698
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:15:45.7323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0P5rVOQ10sEtWKFHPxm3QlzZeGp/NgWwku1d74HFj0vzeFlJHqHaJulPkG2SiMC3Vg6gKW1VwdIZyIuIK+6AzKnmW2qf9FRDbikxaN+Y6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260059
X-Proofpoint-ORIG-GUID: z0DZ89vDeVLNQVCEp_mb1WGNRnXm5_hW
X-Proofpoint-GUID: z0DZ89vDeVLNQVCEp_mb1WGNRnXm5_hW
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
Cc: Ian Chen <ian.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 kernel-janitors@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Claudio Suarez <cssk@net-c.es>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The "ret" variable needs to be signed for the error handling to work.

Fixes: 2ca97adccdc9 ("drm/amd/display: Add Synaptics Fifo Reset Workaround")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d66e3cd64ebd..a0154a5f7183 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -569,7 +569,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 	unsigned char rc_cmd = 0;
 	unsigned char rc_result = 0xFF;
 	unsigned char i = 0;
-	uint8_t ret = 0;
+	int ret;
 
 	if (is_write_cmd) {
 		// write rc data
-- 
2.35.1

