Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F3C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 09:07:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EC710E7C2;
	Mon,  9 May 2022 09:07:54 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD6110E7C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 09:07:53 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2497BFZg023623;
 Mon, 9 May 2022 09:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=CP85Js3hse0qdSfEKv7syIIRxizpSlH9P+eGd5m1EB8=;
 b=zE75ILVuy5OKPcdqcSbjxu2utghM94OsBwH9BsZvx0URn7BKuLA2P93i5Hvj6xp6c4Is
 CC8kCCWxmec2cZq2DEV8wOo+JJtmz8YgcV/kljerVTTAg1UxiDr8/wXhMiT8tNQ4Ah32
 Kf/iOIOuBPu6ItBH6bUWf9pAhDtzOINNDsqRw3vO4iFbDQYHBZBG3z9w44boZ4KgqTPO
 H0W0uauC8Vzjbyj4BjFTR+mrLNSjD+Md6QsO+Ta28jzCEMmQp5HjOu56ez1jkUSeSV+E
 tREoqZD/l3uFv3e0A7f/mvwz2NoJb8oJfT/1NkWZCNpBztauqhnTp/h5qXsT871U89iR XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsjtxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:07:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24995htv033267; Mon, 9 May 2022 09:07:50 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3fwf71ek7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQo2Ky7Oy2TllIZghtQP99ENAbXBTxyBJyVuyWrF7PwqjIy8OrX4hWJxXe6JhThlf43dl+cUxJuwYpTpxwgcERW5qvrNznTW+nCzemaRQu9ujwkEe721jr0r4QtGhXL91f3W94tgOLz56UqOHbmrbOjlfmOD/ZL7U6TiDCwoDAnEhneDqdkIVtBGMqWlmB8mlJsVYdm3UyBNl7xUDIzmUE8xG56HzwiGUyKaAs+OCrGgQ3MLcNQGW72KK449EDPsa3TjSDF3xBHd8YyrX9Mvb/UlPUr4w6RbY4cnn1Reinw6gao+60BGs+LXZL/uh2MOSRMW18qtjTnB1K4jI1aemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP85Js3hse0qdSfEKv7syIIRxizpSlH9P+eGd5m1EB8=;
 b=LxL2dcqyKB1cdho1LESGZ47DYmTLIku4z6r5DM8AOfBLK+LONFYLAWs+foi8fBd5FXj023Wfo6UzBGcnb4UwvZZhDp8Px/C393dfPul8nTiB4fDu7e+Oqaq3qIoO+Z8OXBoctZsh1lSF+8VX46l+aREQgWSliL36yG8s7DxXUprQ3wEGBU19fBRlzeJ/g9rxj14UUsp2bJKV8crby5QzInRzXhZw5QTB6REk9NzI5LtsCXPuzMWMangT5Ii+svxdDkEchvytklqEoY6AchAS0/rhqO4+UXeyUCtJFE4yNnuv1LrDt6s8ls7XKnTiHelF7DvhmNVI5TdixBHrm1/ong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP85Js3hse0qdSfEKv7syIIRxizpSlH9P+eGd5m1EB8=;
 b=XY4mq3PjuAGM3jOLHmj76KxnOakupVKGZ4rGYVu1SuzrCYwo/+r45UihpSS53CGs2RTl24McPMvjBD/g4pn+bbiKQ/JI5hTf6rcdjgD7jfcGKvE34CkhtOiUyqRdeDVDK4OJ4mM/bNiFtfMsj0QVUESZ5/4UAaxn5ScEy6GQj5E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 09:07:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 09:07:48 +0000
Date: Mon, 9 May 2022 12:07:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jack.Xiao@amd.com
Subject: [bug report] drm/amdgpu/mes: use ring for kernel queue submission
Message-ID: <YnjZ2yNcZGMyJ6Of@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb4b93d-bf41-4bb2-02a8-08da319b62ed
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45428B2248D42934B7A081D38EC69@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56t5Oa464pUKbb6IogHSLO5ESasJHhKrB7CizrQa/BSTB8GFjRM4WT0YCGNV3e2cVYxP7OVU6wVDorOnRoAE1CnNvTYuw8uC/KOD4yPnj1pha/ZQe31wlcm4kgkJFBLeVLoonsildAfu5Y9jF6tDcf3nwwQlnvEJa02i9dHZC6hOgSvI8ILJWUg/I+xAttPFpTKy5mA+sGFjX1Epl0nnTLUfaz4QJCIgOGeOaAgToKXdfcDez3ZiHtNSkLQ7oI8eW1Ciuqem40F0uiuE1SqLL75rgeGzPC9Kgv1wSTm+sSf7s/qIWeaxC9eZ+o45vxudGiWBCnt66KkrCFlvReLiaX1uFjPcNJb7bdhcWx7fcBjqG/Y7mWvagy+8STdy1p87zoYv+SvUJFpyLVFat6dB2RHXXYXI5FC8Hcmw3HzFRAi/Q0+T4JVMvapLA4okko5jRCOVhmZKm4IT/Tcu+7JNQYvXQOH4Fx28iZTnlh2K5da00BH8NUq3Dsf4daFqMs790dP0McEyLa7CRdbrY+BbsI1yVhoGQcglZxIhvH0qQp0Wn+BP7CJILt6uQUuyDxPvyyRwCbJBVpPehFukydkqxSXxPwGKjQKKZG2ihcm6/FyyHUrUQ3klZC5UIWz6l7GPWv+ZvzjW7C5yitTCJE3hqsY2e7MC1uosf+F/ICybCrLRTcPWZmAHQxWlLXAM10789Nlug33YVS/p6rLfXw//aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(33716001)(38350700002)(38100700002)(5660300002)(83380400001)(8936002)(6506007)(86362001)(66556008)(44832011)(9686003)(508600001)(6512007)(6666004)(26005)(66946007)(6486002)(316002)(66476007)(4326008)(8676002)(6916009)(186003)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMkeAph1YYR4BIsCrNiAqSX1cvIYJU/Fv5CI1gQTdUGlwqhXlyLkA6ETylTI?=
 =?us-ascii?Q?TzN19DJTySgm5TJLYkVRGF03v1Q3W6UNO3R2Cyn5XS5WNJIHjzYcbT/4GY+6?=
 =?us-ascii?Q?EpXPitXxA+H5qFK54QwB7yIOGaoqp6EutUufFKdY+lBAwaWgjUs5ZMwGAa99?=
 =?us-ascii?Q?aOd2vhNDntCvLqIYda84wYG+R3tREahNinTmu+ZnZLPR1M+QiUBN0txgtAeW?=
 =?us-ascii?Q?kox7En/TkFWjHJaqdRw/A33815wxGjDumZDqSvDmSMiDskAJN+BzIrtHwqXH?=
 =?us-ascii?Q?Oe8clsvIThMHdljtDPbi5rkfC5j4EPgOOZCA6WJVi8s6ol6oeU41zZgvS/Mc?=
 =?us-ascii?Q?fqsrLezr3zNfFwLfTD/OisPnUwlyNCSKxo722EBh9opL6YfkgJJwpltr/sZu?=
 =?us-ascii?Q?/9AO4njddpZckayRbjIFbbcpxKOiZ2a5Y6JgvxGZEbmNA6up54C79cGPlAIM?=
 =?us-ascii?Q?BH/iRGjXUpzFz0LQM/SSeyzRhe9sFpN2e90CLXpcn7Yu7tZtp8xR3bsZSBGd?=
 =?us-ascii?Q?JAcWp4XEuwFmg2evenv1AFxadyi5pXDb67dxU8WxyfUV0rd9UMzAbrqCT3cw?=
 =?us-ascii?Q?TAuKirEvoRY9oc/kg0JA/75Ozd7DWSwdOcqUgGEYypZ9O1r1betAodynXouB?=
 =?us-ascii?Q?3A/zwxx5s79gAx6isf5Rf4sOBwcyft9p6Xlk9ZycsUWL17KbEKRGjVIAR9cj?=
 =?us-ascii?Q?uiSfJZ7Qcnum/DhcZRsaqglQhCCwz1tTYYp/mCRq8sKHtlcHixbLhEbhXWkO?=
 =?us-ascii?Q?f0TXmyNhKI/sg5wu6TEZ+Fw0PB4Rgl1p1npMMokj7blohr63RkmnbzkaxnjU?=
 =?us-ascii?Q?OwWRrijIWGdKtXRv0RPcPQ3jzXo3V4TTS4kXiMs96s1/PH/DGzakcR/grmVD?=
 =?us-ascii?Q?iSbB6EIYo5JCAvmbswjcQhjawnrcDe6yw+60NjcnjljmyQ+mN1EJaElrM7Bk?=
 =?us-ascii?Q?vjb+aET30Fr9WMde2cmAbXZw1SwiLwIKXLeT1J3Hh273nroBElyKL7c5Dy14?=
 =?us-ascii?Q?a1H+IiddTaS/1kYVOmUFtUP60TAUKr5q4aOGm+3jGDsayPIAUjjjl7pJpuJY?=
 =?us-ascii?Q?w4vlWerhs12LEZbh5aKqFs7LHC6FredpDA+c25p3Btsr9GOcWTzGXrXHwLp1?=
 =?us-ascii?Q?POkLT2wqmkltkigx5pxssYKU2D0HMoEzs7K0zqqyPdGLhOMVT503jMZWHGUf?=
 =?us-ascii?Q?Fok7GboAAlKep3diPx1n78xgjOUNgpS0VnTu6V1cyPWkKovMsbqTfbAD6VDs?=
 =?us-ascii?Q?BhCxks2FiSBnEtivhsfxANSGts0oKq5Y2T+0XZ+PDsi9OsesdZo8nHtHwWzl?=
 =?us-ascii?Q?HOAxYmYguiV8KCsanLCez4Ir9HSqU62pZFVyLSqgj5l49M5IlIZF11NwJi5n?=
 =?us-ascii?Q?7IPlMYfyoGV6RuvmOvrrDLHnyblryHpTN5ob9/2lOvlxOJGfwUq6vua91she?=
 =?us-ascii?Q?xNtuu7hZpUs+nw71bBdehZEL+fz1VUkCppalwQozENpVXIrLBUV738WqA+LF?=
 =?us-ascii?Q?4xxUlS8MKbFXfkvYddhJJAYQaMvVDYzLy6oc2AwPbCGhbU2iiNGdmTkFkaV1?=
 =?us-ascii?Q?5HmZsNjdyMqjy5kyD8qMLnIIibZH9oUYqnHX6QN4xqEEmVfQ0Axb+UYFTMpH?=
 =?us-ascii?Q?BRxeYBEHKrnAZ4ZB4a6QAVstAawF9Rzp6BiT/iV8nUvRQ4XxN4vc/UcTUgGD?=
 =?us-ascii?Q?dkfYSuxqce442P2YkcmHq7KaojYNsB9begnuY+l376oev9x03Ab16Vjh2yrH?=
 =?us-ascii?Q?EDnXR5ANTxQWtlx/tMh6VuKmjSecKHY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb4b93d-bf41-4bb2-02a8-08da319b62ed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:07:48.0737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMQhTZESCPjLt/xhBpksCgrO32uJIMIfmKLrNz4DFERvRdcA48/eP7jwnBb4D8y0z2x7nCK1ZA0AJ1fM5z4zvz57kpZ/Wotdom6eR/JPOAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-09_02:2022-05-09,
 2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090052
X-Proofpoint-GUID: 6anU-8bwFa6FzvJxLxbd25WaaXHIV5ER
X-Proofpoint-ORIG-GUID: 6anU-8bwFa6FzvJxLxbd25WaaXHIV5ER
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

Hello Jack Xiao,

The patch d0c423b64765: "drm/amdgpu/mes: use ring for kernel queue
submission" from Mar 27, 2020, leads to the following Smatch static
checker warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:924 amdgpu_mes_add_ring() error: format string overflow. buf_size: 16 length: 39
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:927 amdgpu_mes_add_ring() error: format string overflow. buf_size: 16 length: 43
drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:930 amdgpu_mes_add_ring() error: format string overflow. buf_size: 16 length: 40

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
    848 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
    849                         int queue_type, int idx,
    850                         struct amdgpu_mes_ctx_data *ctx_data,
    851                         struct amdgpu_ring **out)
    852 {
    853         struct amdgpu_ring *ring;
    854         struct amdgpu_mes_gang *gang;
    855         struct amdgpu_mes_queue_properties qprops = {0};
    856         int r, queue_id, pasid;
    857 
    858         /*
    859          * Avoid taking any other locks under MES lock to avoid circular
    860          * lock dependencies.
    861          */
    862         amdgpu_mes_lock(&adev->mes);
    863         gang = idr_find(&adev->mes.gang_id_idr, gang_id);
    864         if (!gang) {
    865                 DRM_ERROR("gang id %d doesn't exist\n", gang_id);
    866                 amdgpu_mes_unlock(&adev->mes);
    867                 return -EINVAL;
    868         }
    869         pasid = gang->process->pasid;
    870 
    871         ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
    872         if (!ring) {
    873                 amdgpu_mes_unlock(&adev->mes);
    874                 return -ENOMEM;
    875         }
    876 
    877         ring->ring_obj = NULL;
    878         ring->use_doorbell = true;
    879         ring->is_mes_queue = true;
    880         ring->mes_ctx = ctx_data;
    881         ring->idx = idx;
    882         ring->no_scheduler = true;
    883 
    884         if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
    885                 int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
    886                                       compute[ring->idx].mec_hpd);
    887                 ring->eop_gpu_addr =
    888                         amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
    889         }
    890 
    891         switch (queue_type) {
    892         case AMDGPU_RING_TYPE_GFX:
    893                 ring->funcs = adev->gfx.gfx_ring[0].funcs;
    894                 break;
    895         case AMDGPU_RING_TYPE_COMPUTE:
    896                 ring->funcs = adev->gfx.compute_ring[0].funcs;
    897                 break;
    898         case AMDGPU_RING_TYPE_SDMA:
    899                 ring->funcs = adev->sdma.instance[0].ring.funcs;
    900                 break;
    901         default:
    902                 BUG();
    903         }
    904 
    905         r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
    906                              AMDGPU_RING_PRIO_DEFAULT, NULL);
    907         if (r)
    908                 goto clean_up_memory;
    909 
    910         amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
    911 
    912         dma_fence_wait(gang->process->vm->last_update, false);
    913         dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
    914         amdgpu_mes_unlock(&adev->mes);
    915 
    916         r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
    917         if (r)
    918                 goto clean_up_ring;
    919 
    920         ring->hw_queue_id = queue_id;
    921         ring->doorbell_index = qprops.doorbell_off;
    922 
    923         if (queue_type == AMDGPU_RING_TYPE_GFX)
--> 924                 sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);

Using sprintf() is always ill-advised.  Better to use snprintf().

"gfx_.." 6 characters.
passid is capped at USHRT_MAX so 5 characters
gang_id is capped at INT_MAX so 10 characters
queue_id is up to 10 characters as well.
1 char for the NUL terminator

Smatch is saying that it can be 39 characters but depending on the
implementation of idr_alloc() this could reach up to 32 characters.
Still that's well past the 16 characters avaliable.

    925         else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
    926                 sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
    927                         queue_id);

Same

    928         else if (queue_type == AMDGPU_RING_TYPE_SDMA)
    929                 sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
    930                         queue_id);

Same

    931         else
    932                 BUG();
    933 
    934         *out = ring;
    935         return 0;
    936 
    937 clean_up_ring:
    938         amdgpu_ring_fini(ring);
    939 clean_up_memory:
    940         kfree(ring);
    941         amdgpu_mes_unlock(&adev->mes);
    942         return r;
    943 }

regards,
dan carpenter
