Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB7C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 07:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FFB1122DF;
	Mon,  9 May 2022 07:41:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEEDD1122E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 07:41:40 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2497Fv8i023549;
 Mon, 9 May 2022 07:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=5qrCUPKfu4S558pgG09bDPgs2UmQOQUe9N87DbLOIU8=;
 b=VtNCBzdGobJLoKevCJX9FmL/7K980ZIK7QCOViMUhMyL9OpyFo0YcMZKI4jAvGTx94aO
 8v7UX4bxmA1GC09ctrbJ64N/y+Sn4D2t8rjBGH7RkizV/sV/OSFuepCd9lRFke1OolAK
 fkqCvvd3yBL/DwoZrrTrHdyz0ClSzsIlgHr62ZCVe8JePiCu7l/t7I9TOridqXkewvzy
 R1p57t80gt8roGAxj64xnop9hHg4qjsWbOt2EjNvV3grUnXel21eDFZRwk3DU9Qd2pcD
 MRSQcpA2zxSo+ZlLICTWQrCmMynbcrE25+41ZqiQz/1qqx5Xi0u7dLyuT2GiKI6L1pM3 nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsjkqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 07:41:37 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2497ZVFp012770; Mon, 9 May 2022 07:41:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fwf77rkhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 07:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1xTy0AH623g81I9jksSwRjrs8I7sEmRDsWavAOKzpeg8fAQhhMo7dnBl/ZE6OSl1SEIqLiIm4J10xPwfDsi53G8Ob7y4l/JcdrLWHd2onAwHrpMUgtVpO2wnkykpEK2ds09a5CrTymGVKtknkxiLOyJwu0cToIbb7mOb7Y7prMst9m8zvxYMsbjFiShVM9NcwdTn7PBoC2MOcryrnag6Y6FkbuQLK1R4PEtraAUQs5FqoXsn6042RPacYp5w+TAt4llRzmTKtA5+IHUg1RmYQTyhs1pi1bcgxEe6hpmc5IOzA4mtgXHjLOZUVUvHZKgV77J63bJglyf7s3NCY8T2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qrCUPKfu4S558pgG09bDPgs2UmQOQUe9N87DbLOIU8=;
 b=kd0jdDALEJJQDBCYRhwJuL4nTv3I2WsG9SewnIwyHRk4jYsWx6XS5KwSUbBTeIDr7Ck6WEYzDPiU89+2CZ2HKDTbAzMRYN4utkendCpKBcoFKo99+Wgtav3gh0OOMgtDlpaMQPuXMas24K0MxhNxCOtuIDM2SlHDzvZ3j6o0jbK4pTV+3xVtIsG6i4crVicUwX4QwOnHfJeHyprhY5+1PXh8rdw8i31Yl3QC7cyMCF/y1x83XVMcQHO0AmmaFwBSiUnt7aEB6NUTdyBDXMyG0U15as/nkoqbzG8UPqd4ISElgHD6FLM0p96pM4YuP1P4/FJkiyxkVRgNab/31jEUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qrCUPKfu4S558pgG09bDPgs2UmQOQUe9N87DbLOIU8=;
 b=qjZ810e0txEFnj4zr2SzHWRe5Y2b8gTuvp9FjYHRvdts84JIZxRAXc+uY/m+ZIwwo9P5URdOTbtYXNm4qF0IFvbfzrBT0SP7dDFEF34DlcqvtYHHKUYfwbPM4MOatC6DUwcMuJOQeYyPs+ozH+ve4zPYRHny7EsC7uUO2YbVtIM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3387.namprd10.prod.outlook.com
 (2603:10b6:5:1aa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 07:41:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 07:41:34 +0000
Date: Mon, 9 May 2022 10:41:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jack.Xiao@amd.com
Subject: [bug report] drm/amdgpu/mes: use ring for kernel queue submission
Message-ID: <YnjFpdmDZex0MhpI@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2502c11-395b-4605-5999-08da318f5771
X-MS-TrafficTypeDiagnostic: DM6PR10MB3387:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB338705F042CED01DE1AE51388EC69@DM6PR10MB3387.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCIZ3+ns63BxdfCTlMYJI1UDCnIPTJfsy/mcVcLv77TY1ssqaxszmaEBppu/fFbU6FTqN1SdMPgSxWGMBVcPerH+xI1zWUHPwDPB26k4DSxZ0XvkdBmzeth6eemgkrwP/kb0qLi0lc34YvwpO8n7z1KGlz4aq0LZ5lAPh1yLBztv/RoFMAeK/VxnIbLYnD2AIVyoW0a2BHzHnbqDIo8EGV/nt1AivT+hDNnSGxjTk7vhmMZg+zlj9PpACydMAdjkyZphn6gtHvUq4BP9H478ZZDApFMmW2UYmVncGK672KkRz9H0Hef8XLSLggX9kOAwAPtPM02HUGr1BqJ1aKJbyiV9yucpF40IMA0aK5JbcUQ9h2TjcaQ5a279CVNd/GEGU5KWjBE4PyMZjAKeCNK3sjdeFqq36bQ16bAFoImMEDsyW9fJ82GxmKyxXu67SKnUJuno1FHxh6xd540YSkSQCenrOILh2YFONQn8JHw3Yb+yQmcSGJCzDQ7+gEZXk26Ce40WuJCvdJwYPMOwufyDFCeT7OTHGyaKpkxJ5TC/6rzi1zFcDHgRBKJvm4pzitoNhZGaJ306wVbLSyGfr12FmUSbD9U5lcPTFJb8XfLFAhaeKbL8bZ3BeNfl/V9RwZoWTgwmAjeDtL1YyN2dtd3FAsN8EkP1qCQCMaA97/qeXwaO3SIpEA8F1DM927dzKhhfE/0ob7igy8VDvqVPeU//uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(8936002)(508600001)(33716001)(9686003)(8676002)(186003)(6512007)(66556008)(66946007)(2906002)(66476007)(52116002)(6666004)(83380400001)(6916009)(6506007)(4326008)(86362001)(316002)(44832011)(5660300002)(6486002)(38100700002)(38350700002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqwpkINKtaJJk9pxO9fh2TIfMfMwHo7CjWiaoZZoCDWvnRJECphHoDeK5Y29?=
 =?us-ascii?Q?ntQ/pYWKtLESP98JefqpQrpLLmf7uxKTBqBoAQrsuuLmHNTps0D9Kv/vqDjJ?=
 =?us-ascii?Q?4gyv+vAUM5aRTadg74LigQawj/p5wOn+K1y9kd03oJNKNmq9tiSCTnDz2IIN?=
 =?us-ascii?Q?MAOxG9l+CJlYljtyPlLQdTvPKniBwhKJbzBtEnY3qCro/I3Ql3w0Gth9y242?=
 =?us-ascii?Q?AsSV0cTK6tN5DjBQ7wnMPDudbcnby5RQaaQpghmsT2LOfgCc7/DZqhx8mLjb?=
 =?us-ascii?Q?MPzeKNIVsbDvR5QSFj4Seb6Xd1TLKKgkJ05WqtmSRQjuLuOQ4E0wGY5Y4N1D?=
 =?us-ascii?Q?i51GGkl7DuDFu/zzfi0h0pBsTjx2n1SN/TmZ48RgWR8gLxapSA6ux3hIWg4T?=
 =?us-ascii?Q?ARY+T+0fgQyrhQh91dCygmUvx+bRdQyNnEAaF5bKH0ork3nQnDE0mDI/8eT6?=
 =?us-ascii?Q?xL1jjRb/SL2nxo+1c2ZwO+mwDJRDkR4ulj7px3Bmvrd/rJg9LiHYuUKEqc02?=
 =?us-ascii?Q?aoy8BF3eXI+oNlKi4piwVJnjwDykzVc8ERKDkPng/K5C5EcU/WUsUajy38uJ?=
 =?us-ascii?Q?LEZx/KFWjuvdKQTUsqYprpCg/3tqBiMQsTnpdZ1YrzVLyACk/yCVptuTgfc/?=
 =?us-ascii?Q?6Gtgsoi8UOXwCtvvalXw2sdiXdZfD8iomCD8lyJzR5mNeNBRtqckeeSxS4kX?=
 =?us-ascii?Q?If7Yq/I4ntW+su8xf/PI7xvjmjGrI7iSOvXo+/YFCHMnAYIUETXat9dp8sPB?=
 =?us-ascii?Q?TVAYxufa3bX/3EMqCdeeZ2EBPNmJBJaHyLoEC1PfoKrM0yRKjghzBp4Q1ENF?=
 =?us-ascii?Q?M2bAQmeCaq4u+h3uuglbCZh1o9rl/HLgJzSm2/jqdPiSRUuRXITCzcEFKdT/?=
 =?us-ascii?Q?CZLmiVygOInCO2JXrStmj1fHJwh38ppOEZ31+OCMUHM1Q3fVgmszaksraO/2?=
 =?us-ascii?Q?EBqT+i/1MLwGjADR+6Tv55rs7Ku+411M678iraNqK2+QVGkrZiDK0umDbpOY?=
 =?us-ascii?Q?tRxoevPhOfhvPWFfGAMWdGnpSv9TMHXz3ScJtmSg8NhHvE9K2gQO+1THfg9t?=
 =?us-ascii?Q?cnuQlzfFdyoUC9x3zNVnr4H8ySDrNWkkngChSYIakUV84Ku8PDZ1bs/mu1Zm?=
 =?us-ascii?Q?32tfHCvauGigl/FyALmjF3w74vxpxuPwbMfJtG7hC4p4Djib4NZtq9vlzrny?=
 =?us-ascii?Q?l1vzWJwDHGCKBP//fwzW6NgwmnX4Dgh9W/S0Tgpb078AO4fz6XTBg42gRLjj?=
 =?us-ascii?Q?nCouLcqhnysrewolfgJaWkSksGLy/UigEo8EkDORrdLHakil1iVVfMG3dAl1?=
 =?us-ascii?Q?r0FJAkDWoZ9F44x0O71oWF0q9QMzSsKxlwrf8hdg6O3s0GBm5IykdYgkSMIc?=
 =?us-ascii?Q?7kRpJL0k2aDsIoZ4JY2GEpRF1b/hC1pPfxaOom7T1xmFNaoW6NUo66LMmiJM?=
 =?us-ascii?Q?ZQoxPaj8y3CUocWeUQAxSFvQon+2ERhAL/EeUTAB1l8PrI43tLtmmKgrFhtV?=
 =?us-ascii?Q?mQpUjYFEc655BZeeVRexJM594C/g0tRTMAydBwaPmyET6Wt3evkBegSIJF3w?=
 =?us-ascii?Q?JxZghlkOsj+rpY46iLmskx5kEledU9s6oQaGPCQbP8fW9Lv0EYQVUjQNBR4w?=
 =?us-ascii?Q?Uf2KN47iKBRPXf/Oqhhh4ToeIeihNTqMQ6i8bGfFgxYc8F98jixQXBeqYUol?=
 =?us-ascii?Q?Etht9MAd9GDLZ/dHMOLadTyZn29+KEsYlO5bVJqv08uws3mZrGhp6WbG6NNe?=
 =?us-ascii?Q?Qt11GpXWH9LY7DR3Lwg/lsA7S8gqDWU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2502c11-395b-4605-5999-08da318f5771
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:41:34.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N//R6/HqDKC4XTjHpTXhDlUNfQD9FyJLtK4nGRvW2C6K7YVL+vZH5iFIqWS0uPgo16N3rpaoTnkd7AsRmeBTtsOZzwkMVTdbRU2sRovE6B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3387
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-09_02:2022-05-05,
 2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090043
X-Proofpoint-GUID: M5kx2jjjfvR92EA07PfVKVwLE4LNiC3y
X-Proofpoint-ORIG-GUID: M5kx2jjjfvR92EA07PfVKVwLE4LNiC3y
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

	drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:941 amdgpu_mes_add_ring()
	error: double unlocked '&adev->mes.mutex_hidden' (orig line 914)

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

Unlocked

    915 
    916         r = amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
    917         if (r)
    918                 goto clean_up_ring;

Double unlocked by goto.  It's weird that this warning is only showing
up now but my guess is that this code was only just released to the
public?

    919 
    920         ring->hw_queue_id = queue_id;
    921         ring->doorbell_index = qprops.doorbell_off;
    922 
    923         if (queue_type == AMDGPU_RING_TYPE_GFX)
    924                 sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
    925         else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
    926                 sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
    927                         queue_id);
    928         else if (queue_type == AMDGPU_RING_TYPE_SDMA)
    929                 sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
    930                         queue_id);
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
--> 941         amdgpu_mes_unlock(&adev->mes);
    942         return r;
    943 }

regards,
dan carpenter
