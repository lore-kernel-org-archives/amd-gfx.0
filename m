Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B330C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 09:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAFA10E4A5;
	Wed, 26 Oct 2022 09:36:14 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E10110E493
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 09:36:12 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29Q7x4Uc014047;
 Wed, 26 Oct 2022 09:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=KnIT7iJ0JKS88j1gAURTwk51ShKm0CGtKfD33U5p8L0=;
 b=XuUYDTqLF8Lljt9IraALEnorcdyBsU1Ak6kTa6O1MT21meC2/TEH2Wcaf94KzSc8aOss
 1op4dZ9rpzwuJyI+FRIVQ0I0w9+/KRHXJUgSZxDNGTvuBNfDHGeI6qXZxle7SwNkEVO5
 seoJqkW4AYByOaPhmesL6GCEHrFqOM9f1Z/un0PzlSXdqwuYEab0UH4V0iDjm93NlMi2
 PQKy5fyLxjuDnvOvpXzMBZRYRwbrYxRv4FdXeojaKMesjHa/iGvqXWpkllJYeXmvTaKD
 bFSQdkpS9s05B13FQI5/EVjub/M4kbZN8MaXQATwXGibDhuxYmdWUSZUplP+X3yvMsew Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc939epdd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Oct 2022 09:36:10 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29Q7NW33031943; Wed, 26 Oct 2022 09:36:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3kc6ybknty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Oct 2022 09:36:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4I/HvtKM8junt6XBRN7bsGJmrJl1/TJuKCEH9+hni2C10hlDRMwCEoxO66YTRE9IIiqdNTEla99BjNx3p6KRx2uv6dNDwx2kI6yazEiLF8d9pRlGx5t4QB+beHhhNpAg7UMSw/hL5a8uW8AsEM85KYuaArMBX6ue+hFWjWYQUAVLwPoykbkTe8B9QDTnw8ealtK2keRcKxBQ/6ywu1eP4ZExXtMbiC+6M0Iuu4bzWyhWNL1yjjElylcjp0QGALzwxXio4nHSCUF2mL5adubxRV7ed1GrcLGBVjqVs8gjm9CT9JLI4FFwD/auQgBfsHk0qFhku7e6AvyOYa/GZMUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnIT7iJ0JKS88j1gAURTwk51ShKm0CGtKfD33U5p8L0=;
 b=etR1ZmsBVGt+oOKJXuMvdtyQEXcyrp4zwS+b1kkkV6Dzr7jifWoMQSlaQrMy7RQFFRVQIAeeDDd9YJuJh/aUj0DAIkbLGSdfuP9YwsvFA90hUfMDtD/aUGUy0/piVq7OIkmprQZPtJ3jdenAfsnvceypGxbIw8LPDRcTxRWREarB6dG2LGhePGKEftcjNR70ZdjDIMM4oNHyAm0UOFmRd8J8BQHfkXF2TK8wUUk9wLvrsCqQ1yjiyRA+5Ig+Bsz+CwaWDCC3px1Js0pjt0qsmq/yp8hw/ahDHI4SnUhACpZR4AOl4muTbkEvEBs9Tv+4fdqFhN3D04iEBaDZpQJcOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnIT7iJ0JKS88j1gAURTwk51ShKm0CGtKfD33U5p8L0=;
 b=ateu0dffJEdOjTASxFtAfmFVDQpwREUU25U6PFkT6kCub6r9iYWoceLUeQE3f59Zi+0AZWxqbYb4bXXsbKDxEj8BlrmyqdmdjLgAB5PuhidMYYvuKotoadEtzVFulh/OtqhdV7RXgcWoyfY/DxM5BvFZzmc/AKvc7510CkAsjBI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4351.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 09:36:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 26 Oct 2022
 09:36:06 +0000
Date: Wed, 26 Oct 2022 12:35:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jack.Xiao@amd.com
Subject: [bug report] drm/amdgpu/mes: use ring for kernel queue submission
Message-ID: <Y1j/flEwcNbI7Ltk@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN2PR10MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 730450a0-5ede-4629-299c-08dab73581a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vitYbv2VSSryo/aIyCO99K1wYLUvVuu3EeoTBaM4bNYzaYJd7wYSNhBFhGhpBzTSL9ZmVBD1rBsE8yOlr26lo6pgx5aD1cqkq5qbx4YF50XM1zDiO8rpXx2ScNiQpxPU65ugcapaz1Zj5GpLqUu+3vQglgNP8WM6UzNmvpdB8eVGRUIBv2RGH90rFZWtByHmpgNABrpA67EkrECKw5EuqaVBhYSmCKAUBCjAHzLBLp849eJhh/iRm1LxpDWS1DXYyVNhDaPrSYCvsgyM1pPk8JqLDvyha+y1KZrk57wK5UZqQTXSkRkkjWoTCAuU3i3ESoGnqEOa8t/TKW7b01Un1Gic0WzjX0VrVONg8wIm9TCTxJJ1oU7+qkhVbbBBVv8jCcPHrp5s9g8zF2SDYeyj5pHzVOjMvDBG7ZSdJgemTouustcNg4OIUgD6j5y4CeaOVZFXAfZ8Ztd6OTDq15B1PGSZjJ1yEESWRYCqMM0IltrhVVpMYVpVrWfGL223em+sppGH4QRoiFErqVtbimW2Tr+o+g1fLX6knU9Fa/G7hhhLQ1rwYj894NQhaFaiLo8nKwKrAkIQvGKMLj2nFIgoW+107mS74Dn6YLMQh1XXOQ1FMCXCDFJLw7leJlDQrGDH5y5mNZaBlhvfb/NQAfZGGAo4pE38iquMVMdP9ZQR4MADV0kmcn97BCPnvH3/VB62U5Iky+AWrGgJjXlboJNVnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(8936002)(5660300002)(44832011)(83380400001)(186003)(2906002)(86362001)(41300700001)(66556008)(38100700002)(66946007)(4326008)(33716001)(66476007)(8676002)(316002)(6512007)(26005)(6506007)(9686003)(6486002)(6916009)(478600001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PbsngL0hBaLpAmCVg+4M40btF4R04SnPASt5y/wj8gQHleIXeHeoKoyN2Z1J?=
 =?us-ascii?Q?F85U8vBa19l6CfhbodC9VuAPbG6eeFE/91r/pnme/AWf+LRxPQNEeYPS0qFx?=
 =?us-ascii?Q?4l+kdg13Y1JWfefM8qb/LTV1vpLUuwXfiTz/u2+SHobbcdFCbU82hAeP1Lnc?=
 =?us-ascii?Q?bIvMVU8RgltG3IoMFx5f9af+t0Lt99s+aOxfAW1wjtLZtawwUeCvASfLZtM6?=
 =?us-ascii?Q?qZLqwBreThgxdRoLA3mQyv1cUM82OPMKXqNsKHlA8CzsjrSZji0+LWYcR1rC?=
 =?us-ascii?Q?dG52aV6+xN6iNpPX9eCBKJfRKWUj03MMclxoztCSTwipQFxVrfIShcAvRj6V?=
 =?us-ascii?Q?3q3mXEjEWLm/mtpdODF5R6tOpVgItg+YEionsWYFbmBvP5JB5qbBqTuWsaQ6?=
 =?us-ascii?Q?KGry7+Y5FGJxhRtjr0URsoGFZRg/YErG6eLm2c0YkmPhUtX4WTydqM/rGL8Z?=
 =?us-ascii?Q?O0i/Jx7mmtFSoEExXZ4cWFBmeHeh4J15MWBK3SXXNLUd5bsdb4HsXBcDcfkr?=
 =?us-ascii?Q?iCFMqXAISnctLXpQjMGKraVOQF+Qx8U9nXKxl0uvyfR+hvnWeF5CPGliHl/3?=
 =?us-ascii?Q?1yrA9I++b6saducbLonHa3MVTIv6buIJ79CJYkH9JO82TgbtU9oBrXGe62AX?=
 =?us-ascii?Q?17hwqWCVSQzt0JFfow5vY6UDAsdnUeny7QRgTjp4WZdF5Lwch0p4aKwGTv+v?=
 =?us-ascii?Q?V2bEDj69KGKiaoEdvYWXqJxOcE/tYpayw3iKEBXoPstrJgyy3ioiKDLigQE6?=
 =?us-ascii?Q?zTKDFl/Seik0X4JcJvUhldynbhFFcSLpGBMIbuj1v6YzBFQxOO03UWaWHoTj?=
 =?us-ascii?Q?lpxc6lAEKvpIzPQytMi1QR4GSvinLbwQ1x1oYRujvAlIruAsPJLfdkPflCU2?=
 =?us-ascii?Q?k/gy8FQG66lecsNBUCfTuAtr3CvTH6XCxfW6fkO97b6Td9R95AWPBil/InqO?=
 =?us-ascii?Q?aiOozkXebxNvzVWME3kdivlRXrilcoRgNp9zca/zxVStWBNBTqS9CaC9QF+A?=
 =?us-ascii?Q?wFyu2iwekVmtHvz/z6bTvy1gG+8sLTPqwgUwjzxlPYjwgSBkZWofqfoGRE9/?=
 =?us-ascii?Q?rr9j4XKvYTMiE6niQ0RyyQG7Ooki0iWA5+RM36QLM/8zW+B3FG8S7bX9RuiJ?=
 =?us-ascii?Q?qKXsVNyZE7MRkQwKM6h6xgejqBoNiUi7O2R3HUezfOlrj71ohWntKNqVP+Em?=
 =?us-ascii?Q?05OQq5Yx6CdMwuZX42NMgvVAUhiF8k1nVFl619rFtG0Pw/B81/qSy3FI3wF6?=
 =?us-ascii?Q?5jorKj85X9kydDAQRaeXaL1IpbkoD1JDeBV5oGJ4qxO+sMFMX8x9zMhOdY+0?=
 =?us-ascii?Q?PolHEZDpsm2krIAY5oa+9DWLbce2GyFooZ+y4UDzrsmAmvhUkGzLfFbxA2hY?=
 =?us-ascii?Q?08km/VrqwtemC2bSA3HiyNJsJv/MRjBMctksXLDAs8UOIRAbnblCuP7a6I3/?=
 =?us-ascii?Q?mIMKwuQYyGwxnCVpxQW/L1L/fiFNIrfuG6cXLGaNoIucFiDZeJMG9xFT3IGK?=
 =?us-ascii?Q?0XpOHN/so/fnWCu4drA2vbCbSQEmPu360Xy/AKy8DvePnM8UBsYhjHlNXVBm?=
 =?us-ascii?Q?grA2MO7L1LMRuzX4VYDI945pne8ePP+agLk32e1xXx19vMKfZjbQabsDfLJG?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730450a0-5ede-4629-299c-08dab73581a0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 09:36:06.5065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwX+gC69JNq2P3T4oYhvvhOw2OKWiEZA5ulHxJZCNZbRf8IQt6Bhk0uP2KRyo+iVFXFL4oY6I0EIdnGTOb9MqZ97/pjR+huUWzNZvB4jYvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_05,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260053
X-Proofpoint-GUID: UX5-es5AOUoe1RG1ojpSsXxAh7ZfTDAi
X-Proofpoint-ORIG-GUID: UX5-es5AOUoe1RG1ojpSsXxAh7ZfTDAi
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

	drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1056 amdgpu_mes_add_ring()
	error: format string overflow. buf_size: 16 length: 38 [user data]

drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
    980 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
    981                         int queue_type, int idx,
    982                         struct amdgpu_mes_ctx_data *ctx_data,
    983                         struct amdgpu_ring **out)
    984 {
    985         struct amdgpu_ring *ring;
    986         struct amdgpu_mes_gang *gang;
    987         struct amdgpu_mes_queue_properties qprops = {0};
    988         int r, queue_id, pasid;
    989 
    990         /*
    991          * Avoid taking any other locks under MES lock to avoid circular
    992          * lock dependencies.
    993          */
    994         amdgpu_mes_lock(&adev->mes);
    995         gang = idr_find(&adev->mes.gang_id_idr, gang_id);
    996         if (!gang) {
    997                 DRM_ERROR("gang id %d doesn't exist\n", gang_id);
    998                 amdgpu_mes_unlock(&adev->mes);
    999                 return -EINVAL;
    1000         }
    1001         pasid = gang->process->pasid;
    1002 
    1003         ring = kzalloc(sizeof(struct amdgpu_ring), GFP_KERNEL);
    1004         if (!ring) {
    1005                 amdgpu_mes_unlock(&adev->mes);
    1006                 return -ENOMEM;
    1007         }
    1008 
    1009         ring->ring_obj = NULL;
    1010         ring->use_doorbell = true;
    1011         ring->is_mes_queue = true;
    1012         ring->mes_ctx = ctx_data;
    1013         ring->idx = idx;
    1014         ring->no_scheduler = true;
    1015 
    1016         if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
    1017                 int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
    1018                                       compute[ring->idx].mec_hpd);
    1019                 ring->eop_gpu_addr =
    1020                         amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
    1021         }
    1022 
    1023         switch (queue_type) {
    1024         case AMDGPU_RING_TYPE_GFX:
    1025                 ring->funcs = adev->gfx.gfx_ring[0].funcs;
    1026                 break;
    1027         case AMDGPU_RING_TYPE_COMPUTE:
    1028                 ring->funcs = adev->gfx.compute_ring[0].funcs;
    1029                 break;
    1030         case AMDGPU_RING_TYPE_SDMA:
    1031                 ring->funcs = adev->sdma.instance[0].ring.funcs;
    1032                 break;
    1033         default:
    1034                 BUG();
    1035         }
    1036 
    1037         r = amdgpu_ring_init(adev, ring, 1024, NULL, 0,
    1038                              AMDGPU_RING_PRIO_DEFAULT, NULL);
    1039         if (r)
    1040                 goto clean_up_memory;
    1041 
    1042         amdgpu_mes_ring_to_queue_props(adev, ring, &qprops);
    1043 
    1044         dma_fence_wait(gang->process->vm->last_update, false);
    1045         dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);
    1046         amdgpu_mes_unlock(&adev->mes);
    1047 
    1048         r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
    1049         if (r)
    1050                 goto clean_up_ring;
    1051 
    1052         ring->hw_queue_id = queue_id;
    1053         ring->doorbell_index = qprops.doorbell_off;
    1054 
    1055         if (queue_type == AMDGPU_RING_TYPE_GFX)
--> 1056                 sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);

I'm not sure why this is warning now instead of in 2020.  But the bug is
definitely real.  "gang_id" is capped at INT_MAX so that can overflow
already even if the values of "pasid" and "queue_id" are zero.

Using snprintf() is safer but also probably the buffer should be larger.

    1057         else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
    1058                 sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
    1059                         queue_id);
    1060         else if (queue_type == AMDGPU_RING_TYPE_SDMA)
    1061                 sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
    1062                         queue_id);
    1063         else
    1064                 BUG();
    1065 
    1066         *out = ring;
    1067         return 0;
    1068 
    1069 clean_up_ring:
    1070         amdgpu_ring_fini(ring);
    1071 clean_up_memory:
    1072         kfree(ring);
    1073         amdgpu_mes_unlock(&adev->mes);
    1074         return r;
    1075 }

regards,
dan carpenter
