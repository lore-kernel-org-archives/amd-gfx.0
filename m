Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A70BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 11:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD6E10FA9E;
	Thu, 14 Jul 2022 11:53:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7CC10FA9E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 11:53:41 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E9l3KJ008129;
 Thu, 14 Jul 2022 11:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=CD3c/mBiSz/piZA6Lyeb+4C5sF6qr1dunTKZiydvkho=;
 b=K2X2O8hGWHv5gWmZXMAIlyg4Y6ezV/JNleCeLH69gz5dbDCmjr3Mav+gYeRuR2tAdDXq
 0z1lfeMqMkOubg9HVSHjRYCUgGy/2Q+FOYMozIoFWMwuDtNKAQLHp1INAPi0cwJsAgv4
 wI+A/SunxwHlZHw/5Hs15V/i59blR2D0V41owEpENd259tsvQamGr2EDVxNxK/mGcYgC
 XMs6uQ6jAaXJPod9qBtVO3ZGg+GHKWcOaNs11VVH7Z2RuGDZvijb+qe98BY3m0C/jBMk
 HReJpCk1Ozg9ay/ZH+hCh+cwDxZzkp+2WuFyRlmQWzD4/n9+Fbb+PJrFwHmkY1AVe9tW SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scd08c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jul 2022 11:53:38 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 26EBoIMn008828; Thu, 14 Jul 2022 11:53:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3h7046519n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Jul 2022 11:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWqAD3z23yiyGWLAvrRme413n0CYVyQGvqtHbVIhsXjHXTHfawz9q6agnzJMZWyEUxuXBPtjomw3NV6cmiY5Ai9e6uRpVaYsSC6HxLqY69xJfY+Kk5wkZRG4YMZvGmVhLvXv55Y7RBo07KXqiKBAgspcLUKyBLE/G9n4oXIJyEEv/jcEOgpAKBaRA6JJjgNFHBmMi+P0rneB6aGMg5sEZynXR+jqMJxw1/PNQ4kTgyhBMNp/COS6QSw3aBMm1GSwupQ9sFdJkupL+iIIYznhUYaDldo0fqiyasAkoOx8n7aHfTIe/9USVfcZIedNzhUOQrZkWPDAvgnU82D0/4KE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD3c/mBiSz/piZA6Lyeb+4C5sF6qr1dunTKZiydvkho=;
 b=fHazPsLX0pzaTYwsT3+x/ZcXU+Z35g91zntUWDn1TXq166Xe8/RLG+zq1K8Tnn2Ceaf2PsFRMZy4C6OsbAD8FqFk7zVsnG3PJfP/rhxcl3QsxEo6KOkCjSl4b3Lu2o27Kg4nNj0aXCg8cznZ5vZxC25XI5+OcARzzsFaoA0+HwSlq7OiFPUmd4uVhqFd0BqX2Qg3NtXJAkptcvAeL075fURCnFVAyUJdgs3YUX56sB2+pwZZQjGRgpoucwSKwfMA8zYyTPOOxKLGggEJgSgxpZ9EW6XzOA9NTQiEUOFdeBDGaN7FyOlfjjj/BOvnFPNgjYfD6OEcnfC14ApyzXKBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD3c/mBiSz/piZA6Lyeb+4C5sF6qr1dunTKZiydvkho=;
 b=HBAO+WY3XYNI1X22NWmZl8X0jd247VddJJ9XZ6MCSY22lRw86Nshs9T70DCoFvZfCnbxPLXd2lQv6YUaKu8bs5D/MQdiURgxxH5YY09npgcI+xxysXMdeuFlMADRwYlTWLiXar5JogGEhUhA8KbgHHWhbAYWbADrAhhfB2LdaS0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5714.namprd10.prod.outlook.com
 (2603:10b6:303:19b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 11:53:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 11:53:35 +0000
Date: Thu, 14 Jul 2022 14:53:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: le.ma@amd.com
Subject: [bug report] drm/amdgpu/mes: ring aggregatged doorbell when mes
 queue is unmapped
Message-ID: <YtADtnn/paoPBqjv@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d115b1-09bc-47f3-c448-08da658f7b5b
X-MS-TrafficTypeDiagnostic: MW5PR10MB5714:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZ72g5yAR/WaZNBvQ4IzGjGazbiTwZp3AWv11lznLTyrGkLZ8cZLAIrgXx2JcpRfpaoWb2EJqsXPi4AmyOFnpbQenBCa0O7XR3tqysdSwnnFCfMMHrTTI8sWb9WHjLG87QxVerP+27AlTvWOICrv+GXCxFF3lDoZOBS8f1CXSZVhfEpIwddK1/csJjaH8L8WX7uqUM3u3vLL/MiDcvDW0HwH5hfM4ltPJvESPP7aGUm3P5lKwdMSb6wrgAZwnxaoDj25ujyANBQPuuQjBm9uU8VrUiNpIWCK2UxhX6rZ6tmWEeFAphFsEPfX6s3HfNrBPWHkBy5YHGZ3CcXtVKlAq5UK9Aa5DCqwnf0IemQIAARkbTdY5Hhno8xEMyq4A39KkvFCDEoddmAud/KjQm/ZN5XkCBimdCy3lGWqWtbmA+gzgZkM5ScQr5550hf4LxH187CJJWZZoyghCeFb2QF85I+zJGYhe85OySfvsLHgiGzVVK0FDNr7PvTyxilOHY1DKQ1U9kdvisAfWdmI00D3X3SIImWqw8p2VrCaYMXfNboqSUHaouMdxjewTMPaPGZC0uGLYJAf1CQ2vwnIXqzAgUJj2tUpMfiJNinEhdF5n0r9H8VC2fFsTHCor2BmR/xnyC+bEg4+bj4z/eiLXf87zz7a+c9oYi/L3bfnc4ORGdcQDOgmxX0XMDRSHXZIalaz0+w4mJzkqk2FIheQv32d4VkFdjBixtRmCMEK7Qeuq9g1MRpPqDkMimJn6+oGEU40pg0I2ndWgIBUTvTHGvwHH+QUbxEDMVDWr+TLxB3O3llZdVeybX8bCmmnXZ23+VRqzznxR4h6Q+sRWlW4koAUHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(6512007)(9686003)(186003)(26005)(8936002)(6486002)(44832011)(5660300002)(83380400001)(6916009)(2906002)(316002)(6506007)(41300700001)(66556008)(66476007)(66946007)(86362001)(8676002)(4326008)(6666004)(38100700002)(52116002)(38350700002)(478600001)(33716001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tB2xss3VIxkDeuK4Thf/6pB30umRe9rlOm4pVMfLqE4kHidQNbP6l88oToNF?=
 =?us-ascii?Q?2ZnXfPqTyYxDftp5cXSsq679NZXu/FDaejT9uKud20EVtiV39kjrY9/n53kM?=
 =?us-ascii?Q?stgEqPgzy4/V+3jruKevgoapHWqnmtCHTssRIV0+qIEcNjGYDU/3mFXRwnVC?=
 =?us-ascii?Q?qZEXyuHZn+ZpuC4JR4Y1z+MUOWPnq/odsVAC9MA+Znnh44WYC42O0l9cjAau?=
 =?us-ascii?Q?NZ4qztylknc2xWZ46hunA+TKH+FdODEWQaIdq4o2M5JyyTGT+s5SKNSfgy55?=
 =?us-ascii?Q?V96u5CNtwJNlLdA/DxC6+1qPHH3gfpwp3aeXczWhAtZpDeV7bEo1TH9CES2B?=
 =?us-ascii?Q?o+vn8gWQSBflbSxoo6ile+iTaPY6Q7IrLldv+e7wN9Pyu2k1/iAo1l40b3iY?=
 =?us-ascii?Q?aHGBj49Wzgxv2ojmK4ufXLr79GvYCbAkZ10mqAHNp5nuiIIe41sqP8ZNRp9m?=
 =?us-ascii?Q?7UUHEY29Zqee0tGqZfGI5QlRVS0xuUCbmr92Wj8YBlR8Nwk3r1GVYWmHyLGS?=
 =?us-ascii?Q?Nr6WwX4geRR0VSXNJS6ydCpA0hjzKWMKZlfwRxBmxcrkj4M5I+OB5W1cFJxq?=
 =?us-ascii?Q?sh+TvxXK8Qu45GNE9PJlYWZRlgqX7QCz7CC6GPRH5D2SJKZmpf17wPnPVD2i?=
 =?us-ascii?Q?OsRADpXFp9lkYFgYRdeYvpX1VGd3fon9CCeYSrAClGTzrUv1tZF/hmUiuuyB?=
 =?us-ascii?Q?QbZnVsA0kHIhpxL7HPIEqtwRYpoz0M9yqcL5vYevNwthHKKPQdbi7Q/ipHbZ?=
 =?us-ascii?Q?KgR2HMOmuZGQRBc92L6BcmYdPriThfZOcYuWzdLGa3ITNkuBrDfxuzUgKeHV?=
 =?us-ascii?Q?cZw1geGteyEOGyi0D9X4SoSPZ6UdfrgFbh7gHzcGvVzZSQorjRue6eypDM0Y?=
 =?us-ascii?Q?qW/uS2EEh/4hwPIKzHBwRNCinJNwpE2ogA6G7abhj3M0W8ALEaRtAbWnGbvc?=
 =?us-ascii?Q?VAHGbmqaTwVlaiiB0io/U6THX+iDw0/JkGXMIGXymmZ4fJsY35R5+7yg/JPn?=
 =?us-ascii?Q?gdz4MGSxe4c6weo4T0oDC6YGVxF940YbGycvt+K+Se5tO+yEKE/UQYCAerZn?=
 =?us-ascii?Q?/AAQ2sprf8MunRPuB0wUCHcxgNk5z+4XB2P9XBC2zNKCcMY19l8Q+TVb4r6O?=
 =?us-ascii?Q?dBOxoF2cuC6DzOQ3suet/VggCH63Vvvn9J6dW7PfTANzETmtHFrOiriCsC0P?=
 =?us-ascii?Q?Et+vXjm40Gj5sT6bEnLXqCIX1nNWeqSz8TdiY8Q3PmmLzbcchPgO1W8gbW2S?=
 =?us-ascii?Q?TkUFcpMvJVip5GteRuQcdQ3b6YfHsaOCmoXO45MQ1u1HIsBDgsxiY6thFLli?=
 =?us-ascii?Q?1K7W4V9zpEUGI5KSgXbiyZGENK4pkbzQSwqc45wz+D5QBNyhVrzpmTSy8RbJ?=
 =?us-ascii?Q?5ynX0D7krgEuy3sWrwuiBSYfrqBtHC6kcwYza8TpXOkZqDQ1R25bPVRDkjTV?=
 =?us-ascii?Q?ga2pnvv488x8bZon8BcFCrWGKFzoWoRXuG/ZbSvu8qD/wzo/SbwyM/Q/bpzl?=
 =?us-ascii?Q?3Z32f/G7wyB4IwXlhtk77GTel8GpNW0BAWDzSpYqqbxj+uauzx96o35C3Pwi?=
 =?us-ascii?Q?FacDvr0PGaY4ntmamQmh0UVyo1+54+TEagrpj1Ay9ySAnrzJWkhJzgH/bI9G?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d115b1-09bc-47f3-c448-08da658f7b5b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 11:53:35.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCtAUKDPulsYz1cibx4H4Vlvlda0EsB0jWXsPkdT36Lw11W4Z0M3E0XHochUY4GQZr+tyCynQZJV0aqp1JIbGeEC7QFApwJtWNhez9nO3ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-07-14_08:2022-07-14,
 2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140050
X-Proofpoint-GUID: BaPR114aYz8TkHX21BRW9l3TaljuWa5C
X-Proofpoint-ORIG-GUID: BaPR114aYz8TkHX21BRW9l3TaljuWa5C
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

Hello Le Ma,

The patch 5fdbff096edb: "drm/amdgpu/mes: ring aggregatged doorbell
when mes queue is unmapped" from Oct 30, 2020, leads to the following
unpublished Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:8552 gfx_v10_0_ring_set_wptr_gfx()
	warn: duplicate check '*is_queue_unmap' (previous on line 8546)

drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
    8525 static void gfx_v10_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
    8526 {
    8527         struct amdgpu_device *adev = ring->adev;
    8528         uint32_t *wptr_saved;
    8529         uint32_t *is_queue_unmap;
    8530         uint64_t aggregated_db_index;
    8531         uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
    8532         uint64_t wptr_tmp;
    8533 
    8534         if (ring->is_mes_queue) {
    8535                 wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
    8536                 is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
    8537                                               sizeof(uint32_t));
    8538                 aggregated_db_index =
    8539                         amdgpu_mes_get_aggregated_doorbell_index(adev,
    8540                         AMDGPU_MES_PRIORITY_LEVEL_NORMAL);
    8541 
    8542                 wptr_tmp = ring->wptr & ring->buf_mask;
    8543                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp);
    8544                 *wptr_saved = wptr_tmp;
    8545                 /* assume doorbell always being used by mes mapped queue */
    8546                 if (*is_queue_unmap) {
                             ^^^^^^^^^^^^^^^

Checked

    8547                         WDOORBELL64(aggregated_db_index, wptr_tmp);
    8548                         WDOORBELL64(ring->doorbell_index, wptr_tmp);
    8549                 } else {
    8550                         WDOORBELL64(ring->doorbell_index, wptr_tmp);
    8551 
--> 8552                         if (*is_queue_unmap)
                                     ^^^^^^^^^^^^^^^

It's possible this is changed inside a function, but it looks suspicious.

    8553                                 WDOORBELL64(aggregated_db_index, wptr_tmp);
    8554                 }
    8555         } else {
    8556                 if (ring->use_doorbell) {
    8557                         /* XXX check if swapping is necessary on BE */
    8558                         atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
    8559                                      ring->wptr);
    8560                         WDOORBELL64(ring->doorbell_index, ring->wptr);
    8561                 } else {
    8562                         WREG32_SOC15(GC, 0, mmCP_RB0_WPTR,
    8563                                      lower_32_bits(ring->wptr));
    8564                         WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI,
    8565                                      upper_32_bits(ring->wptr));
    8566                 }
    8567         }
    8568 }

regards,
dan carpenter
