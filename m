Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C25C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 08:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7A896E5BE;
	Fri, 26 Nov 2021 08:12:10 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41AB36E5BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 08:12:09 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ7qDNo001467; 
 Fri, 26 Nov 2021 08:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=CSCUWJF52PQImjZTrzYUjRwaArXw5IbBmKCfvcqrz90=;
 b=xklVzFr/LqRoN3LmltPzXjUeaoByKkvWayFxfCVEWTLf0tGt2KvXcAMHiW3KmhlC5oOM
 z62ABT/OTO7Tz2PL8ARIKk8IDRysFl+nobqZ9LVus0vk9q1NCo3ZO2S0ao/cotTZgFa0
 1vyKXcnEBTpd3zJRsRWjq6WZlHdV36zZJefWyH7XxaWqY7R/72Rda8BRXqqWeE6r5pFd
 V8+uC+xjcpWZYmVWBwaCCRZ8Z8hovveoGubTGLIhN1toh3kjUho7mrx09TVVP8YmGwvI
 Nt4lIr1rmXSznCrITEE3taOLpEnR/Hjg/u0pgby57Kd+sBdtLrTDDlHoU0mUbfN7eaqh LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3chk009ya2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Nov 2021 08:12:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ85SLP012040;
 Fri, 26 Nov 2021 08:12:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by aserp3020.oracle.com with ESMTP id 3ceru9ma8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Nov 2021 08:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw0TSs4na0DwciC7LUtGTYpjezcFQLWnhQoFccqgCXugSoUPB6asl56igFJULoKK95Tm9gKICa3Uv0sKqbYSUfbscuNBtHc5DFtXDIW/X0nj9x0wO5xt9Es+x7iBYi9WCLBoq0PC9gxZwbm0AZFxE8uYBvrCYPBngOXH3eCWH9/hUqAclfaGlNmYzNpQIrrlOnHpJzDPNQC7Uh6UUhfJd46JhSDWpV89JToNDz+g1kEQvYRxTcMofgeHs1aoiBO3npVLDUBPii8xfnPx52Zu6Pt5iqNRi4XfMLAJ9m22bzLJ+coNZUFU3Qr77OV8Tx32f7MtLZXREaenGticMYe12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSCUWJF52PQImjZTrzYUjRwaArXw5IbBmKCfvcqrz90=;
 b=OEKYFx4OvABq9c9f4grjWLi0NeQNKoHCEpLLFQF/Y4J9DrHwrM80q7+OCZV1cXpzQDjrbozp64AkEJXhRLVinsKW3HwQjFLF7EVcLei48bknUqpw9pcVV5AG4qXwp93Tw08LOu1aEIX3AJpY+AaAbQUoEkL2a+x2wECk05SI7SZlBvOCMUVnlxIAM9WDM3EwOsImFXPwv23ggefzhch/xnYP10TIQ9lgFcKwV5dzi0WWLGqONjl9he9ydGuypXDS1NCRUnIMlkbMtNEDT9We/h753JoxWVwZ1p0SPUD298YP4Pz7jJo3OVbYPtu6s7wwOP9YVy59G3q/qAaSiGOy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSCUWJF52PQImjZTrzYUjRwaArXw5IbBmKCfvcqrz90=;
 b=dwXh6edgF+WBJrWJ4ZTJm3pBoWoBr71T2Xe/YQ4Kro82jYBptSxYgQFWAn9ipOChYtGMaMro9LgZus4BWw47U9lg/rBt/iJeQ2wdAGZCKNRUP7VuJSutTzFnthAq0qrgvc7XF4u6fd3ZMB9yhopRq8LN+GOP9bEnH4/JwNdDzFI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2096.namprd10.prod.outlook.com
 (2603:10b6:301:2c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Fri, 26 Nov
 2021 08:12:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 08:12:03 +0000
Date: Fri, 26 Nov 2021 11:11:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Philip.Yang@amd.com
Subject: [bug report] drm/amdkfd: process exit and retry fault race
Message-ID: <20211126081151.GA14477@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Fri, 26 Nov 2021 08:12:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa04f520-5eb7-42b7-da98-08d9b0b46d69
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2096:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2096D447C84904020E190D688E639@MWHPR1001MB2096.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPcfi2tLUrAn55KWB9klLSAqYfgv6V9nrHKmT6BDDnVkfML1vQ8CZLntldZLVarPiwgpNW1Jbis+g8Q05Be6x/zZSmgzkhMs2wauHBV90u5DoHfPOLsZNBZ+1qg0NP12lqHIGY0VshvbE3MR+hXdcQi5Q25tTdpoftZti8gRtnNWvCRnSHejF5leHvpINF/Q5137bVZRR5iwwJ2sNo9bJoCQjKgt+TIGw7mNnRW51QNY4HTerxLiAhK7oDwwwd72JE27Rfv+b9wTfaekWJyT1tCoG7Vss4XhjDUZOBU9pzX4Uaa3BrqFdkxDTs2qtqIZZn+F32sHKm22NoWwDRQMge4MPjqs51VcbIKDfsDdi2Nhsqd7vgMtAub3dRvmbTxyLxlY9r4JtnasshbGBsdYqSnwi+vxxBi3NjBkdAWgcsGcTLYdxZ9GbqegVbZfHy+ZAcDdQ4yGYZVo1zfBwEGkGTqd1hOYm7zlee+FpmGVEdP67KtM6ReFJdwKOY4dhJCvvP6B8ohm72kAUiF3lhl+8qbln6yEU0eDiwV/OyzoyiuHf8skuvjvaxO42TUThUj2VwAN0qEL6/dKOeR23pjjbQJygWQKeMsJp2gF2Wqoao6EbkCuCYpA+KKkNBQgjiWGaS2ftf828n4lOjIkPw3LhGTxiBTaUhdP66RVYNcFtHbnzGGpCgdp2ChdKvXTiMCWBAZfs5haLSQgPTpBdszJ8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(316002)(66556008)(33716001)(83380400001)(26005)(6666004)(86362001)(4326008)(33656002)(66476007)(508600001)(6496006)(2906002)(8936002)(9686003)(66946007)(186003)(1076003)(52116002)(8676002)(5660300002)(38100700002)(55016003)(6916009)(9576002)(956004)(44832011)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f4ZBvjV5DwYOBPJWepEefziTTsup4jKEVrLBPXcYWTAS2Sg4e5wKOYe+VJAt?=
 =?us-ascii?Q?J0ODLr7dssZWRPc72huM5Xcw5I6aygYxMs5Zu6fj6jslX7T3Mf5M3NP8hLgm?=
 =?us-ascii?Q?sVbrcO/mmu3LNtZQxPR8hJcB8ag30QDCm3F+YuniASQyKQ98OdG8OAkoN7q/?=
 =?us-ascii?Q?1BcWGMW3R/jool9YSqCrSBjoqrvZb56v+MNSpDPXU0mYShnu+GvHGPKYwuEn?=
 =?us-ascii?Q?TKl1uVRmZUMZ8XBbYlVo+Cu1upXwE2N9eC/ERpwp3ePfopcg90TfLaRm7rdW?=
 =?us-ascii?Q?PhTCRIXL8A4w4oQB6NjREzeNdWEEZRJkYGQOPv6S3BMT206lH8B9w1UupNUe?=
 =?us-ascii?Q?AXtF6ONV5GzgUzUe/BOZVFBsDQHX+LO6DefFuAP/mgZ7+mAiDPH1aVo8k3jL?=
 =?us-ascii?Q?se9KhoDwjwrLwx5H7iilOVGvSg4VjAznvzzLdbBsDflHkpNiWglbU4JsF/hO?=
 =?us-ascii?Q?I6NeheazGx0xKUllWPOT+CL8a0uTAHJ2YYnKuQLgdpIGfuBgWDcd6nnmFE4V?=
 =?us-ascii?Q?PMq0oq7jpq97aZ+JJaNZVrpceSMcARkCMCzLPXe1wWPybsSCIOTsDpr2VxJA?=
 =?us-ascii?Q?DUX0v6w5tQYe364zOIS9AbSSw6h0B6yBn04fB2J6owfqWt2taIRyFMmqHTkC?=
 =?us-ascii?Q?DPpJgkiGYYL5ua3ZxDbrB3UQI4pI3P4AsiSQb21RPJdkRZUgQdFGnjc198Vc?=
 =?us-ascii?Q?Ag84bNkme9yyZ1yGSMNjQfc8H9zlnyORjkdP7iIxxGfHbWBit5JQwCuLfa9T?=
 =?us-ascii?Q?uDcbjxTUxYxqUoX1v8shr8gs34wr+nU7UCN5pVKJ1dkRrdjldLlopVNs5Aro?=
 =?us-ascii?Q?twBr8GGIgpbHWppT18SxLEh7H1HymBM8+Ts45mtYhpHmpXQO7F22lYEonB9S?=
 =?us-ascii?Q?KhycE7QHnMd8QuT3EU2Bf1z2cAifwf7aOiS2icdxpPKFJi8JUPeQhdUmgi1s?=
 =?us-ascii?Q?mTrutwkN6SKnObsHRFsNyAo+1Z9i2TKOgn1GswuJPDis17WawaD584pkZKqi?=
 =?us-ascii?Q?N99h9IIsjOYz5M22oROscNgBPT5Tqxc5L3fMsFZBmodlWuxKLb/6z94r5fDY?=
 =?us-ascii?Q?vc4DjwCn/aeFiiUR0hSyNRJ9w2CyPfsqmV6BxUqfRSU2E2UtO5Nrk/Xrj1uA?=
 =?us-ascii?Q?vTp1Sc5EfXp3F+M5JOepAZJ7lOoN0UsbyEc/m/Q0hnhQQ40LbbHzGchzVMPI?=
 =?us-ascii?Q?3W56vd3ZyXeWlsQ9V5yPQB+PNGPXoH4mafzzHOcV2iYrSP4HN4hkFM78u3rZ?=
 =?us-ascii?Q?Nxwdq5FIWKfgw3/89e1iekuwOVfYjtVadx1qu4xjL78F1Y1zK4Bxrz9ujfEG?=
 =?us-ascii?Q?2dSzAJHFQyxBZGNIPFWG9CRYtD6NIb3YrRUrmxoYrzCuH+If8DajTmu//LSR?=
 =?us-ascii?Q?9EP7KE5IkPtSRnmukfoH5dlqJ+JfmkUQY8+099Qneh/VvFSOWs4leLNOiHPd?=
 =?us-ascii?Q?4x6bInaURc5/YbpbN7i3r9HU8nntIxLuLEZWaQKTPoU7MLZQoAiITXI64Kts?=
 =?us-ascii?Q?TcmDS8SOS61L5yKTeJOuqrl6zY13Zh0E/de8DQ9FSVLw6LSYfRra8uLrFtZb?=
 =?us-ascii?Q?LqQN0x0h5BwVw7PoMQqNhqx4A06sbdSuGdarQ/aEgeiu7STf0/fsovQcg02Z?=
 =?us-ascii?Q?saLCYwHn0DicmaETFRPOS8w8mEYF2I9sRXmSov6cIkDhbJkNQ6mVw+dG784y?=
 =?us-ascii?Q?ZmHgTOsH+ejqjaymEQQ7BZVlP0A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa04f520-5eb7-42b7-da98-08d9b0b46d69
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 08:12:03.0278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yupDVsXdQ39zMFRpUvq76/VSX2b/OH8eglOA3vs5pADTH5GV8kapKK7UbiddiHNamtdNeWlId2FNDTuZ7NIM6bOqPQP2ildkiKtZf3lab68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2096
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10179
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 spamscore=0
 mlxlogscore=522 malwarescore=0 phishscore=0 adultscore=1 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111260047
X-Proofpoint-ORIG-GUID: 42UEOVzWaIjlQP5QtTOS0cWnBvPUaOoU
X-Proofpoint-GUID: 42UEOVzWaIjlQP5QtTOS0cWnBvPUaOoU
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

Hello Philip Yang,

The patch a0c55ecee100: "drm/amdkfd: process exit and retry fault
race" from Nov 16, 2021, leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2615 svm_range_restore_pages()
	warn: missing error code here? 'get_task_mm()' failed. 'r' = '0'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c
    2570 int
    2571 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
    2572                         uint64_t addr, bool write_fault)
    2573 {
    2574         struct mm_struct *mm = NULL;
    2575         struct svm_range_list *svms;
    2576         struct svm_range *prange;
    2577         struct kfd_process *p;
    2578         uint64_t timestamp;
    2579         int32_t best_loc;
    2580         int32_t gpuidx = MAX_GPU_INSTANCE;
    2581         bool write_locked = false;
    2582         struct vm_area_struct *vma;
    2583         int r = 0;
    2584 
    2585         if (!KFD_IS_SVM_API_SUPPORTED(adev->kfd.dev)) {
    2586                 pr_debug("device does not support SVM\n");
    2587                 return -EFAULT;
    2588         }
    2589 
    2590         p = kfd_lookup_process_by_pasid(pasid);
    2591         if (!p) {
    2592                 pr_debug("kfd process not founded pasid 0x%x\n", pasid);
    2593                 return 0;
    2594         }
    2595         if (!p->xnack_enabled) {
    2596                 pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
    2597                 r = -EFAULT;
    2598                 goto out;
    2599         }
    2600         svms = &p->svms;
    2601 
    2602         pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
    2603 
    2604         if (atomic_read(&svms->drain_pagefaults)) {
    2605                 pr_debug("draining retry fault, drop fault 0x%llx\n", addr);

Presumably this is a success path.

    2606                 goto out;
    2607         }
    2608 
    2609         /* p->lead_thread is available as kfd_process_wq_release flush the work
    2610          * before releasing task ref.
    2611          */
    2612         mm = get_task_mm(p->lead_thread);
    2613         if (!mm) {
    2614                 pr_debug("svms 0x%p failed to get mm\n", svms);
--> 2615                 goto out;

This used to be an error path, but the patch removes the error code and
makes it a success path.  Unfortunately, it confuses static checkers
and also human readers.  The way to silence the static checker warning
is to set the "r = 0;" explicitly within 4 lines of the goto.

		r = 0;
		pr_debug("svms 0x%p failed to get mm\n", svms);
		goto out;


    2616         }
    2617 
    2618         mmap_read_lock(mm);
    2619 retry_write_locked:
    2620         mutex_lock(&svms->lock);
    2621         prange = svm_range_from_addr(svms, addr, NULL);
    2622         if (!prange) {
    2623                 pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
    2624                          svms, addr);
    2625                 if (!write_locked) {
    2626                         /* Need the write lock to create new range with MMU notifier.
    2627                          * Also flush pending deferred work to make sure the interval
    2628                          * tree is up to date before we add a new range
    2629                          */
    2630                         mutex_unlock(&svms->lock);
    2631                         mmap_read_unlock(mm);
    2632                         mmap_write_lock(mm);
    2633                         write_locked = true;
    2634                         goto retry_write_locked;
    2635                 }
    2636                 prange = svm_range_create_unregistered_range(adev, p, mm, addr);
    2637                 if (!prange) {
    2638                         pr_debug("failed to create unregistered range svms 0x%p address [0x%llx]\n",
    2639                                  svms, addr);
    2640                         mmap_write_downgrade(mm);
    2641                         r = -EFAULT;
    2642                         goto out_unlock_svms;
    2643                 }
    2644         }
    2645         if (write_locked)
    2646                 mmap_write_downgrade(mm);
    2647 
    2648         mutex_lock(&prange->migrate_mutex);
    2649 
    2650         if (svm_range_skip_recover(prange)) {
    2651                 amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
    2652                 goto out_unlock_range;

Success path.

    2653         }
    2654 
    2655         timestamp = ktime_to_us(ktime_get()) - prange->validate_timestamp;
    2656         /* skip duplicate vm fault on different pages of same range */
    2657         if (timestamp < AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING) {
    2658                 pr_debug("svms 0x%p [0x%lx %lx] already restored\n",
    2659                          svms, prange->start, prange->last);
    2660                 goto out_unlock_range;

Same.

    2661         }
    2662 
    2663         /* __do_munmap removed VMA, return success as we are handling stale
    2664          * retry fault.
    2665          */
    2666         vma = find_vma(mm, addr << PAGE_SHIFT);
    2667         if (!vma || (addr << PAGE_SHIFT) < vma->vm_start) {
    2668                 pr_debug("address 0x%llx VMA is removed\n", addr);
    2669                 r = 0;
    2670                 goto out_unlock_range;

This success path is very clear.  Good!

    2671         }
    2672 
    2673         if (!svm_fault_allowed(vma, write_fault)) {
    2674                 pr_debug("fault addr 0x%llx no %s permission\n", addr,
    2675                         write_fault ? "write" : "read");
    2676                 r = -EPERM;
    2677                 goto out_unlock_range;
    2678         }
    2679 
    2680         best_loc = svm_range_best_restore_location(prange, adev, &gpuidx);
    2681         if (best_loc == -1) {
    2682                 pr_debug("svms %p failed get best restore loc [0x%lx 0x%lx]\n",
    2683                          svms, prange->start, prange->last);
    2684                 r = -EACCES;
    2685                 goto out_unlock_range;
    2686         }
    2687 
    2688         pr_debug("svms %p [0x%lx 0x%lx] best restore 0x%x, actual loc 0x%x\n",
    2689                  svms, prange->start, prange->last, best_loc,
    2690                  prange->actual_loc);
    2691 
    2692         if (prange->actual_loc != best_loc) {
    2693                 if (best_loc) {
    2694                         r = svm_migrate_to_vram(prange, best_loc, mm);
    2695                         if (r) {
    2696                                 pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
    2697                                          r, addr);
    2698                                 /* Fallback to system memory if migration to
    2699                                  * VRAM failed
    2700                                  */
    2701                                 if (prange->actual_loc)
    2702                                         r = svm_migrate_vram_to_ram(prange, mm);
    2703                                 else
    2704                                         r = 0;
    2705                         }
    2706                 } else {
    2707                         r = svm_migrate_vram_to_ram(prange, mm);
    2708                 }
    2709                 if (r) {
    2710                         pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
    2711                                  r, svms, prange->start, prange->last);
    2712                         goto out_unlock_range;
    2713                 }
    2714         }
    2715 
    2716         r = svm_range_validate_and_map(mm, prange, gpuidx, false, false);
    2717         if (r)
    2718                 pr_debug("failed %d to map svms 0x%p [0x%lx 0x%lx] to gpus\n",
    2719                          r, svms, prange->start, prange->last);
    2720 
    2721 out_unlock_range:
    2722         mutex_unlock(&prange->migrate_mutex);
    2723 out_unlock_svms:
    2724         mutex_unlock(&svms->lock);
    2725         mmap_read_unlock(mm);
    2726 
    2727         svm_range_count_fault(adev, p, gpuidx);
    2728 
    2729         mmput(mm);
    2730 out:
    2731         kfd_unref_process(p);
    2732 
    2733         if (r == -EAGAIN) {
    2734                 pr_debug("recover vm fault later\n");
    2735                 amdgpu_gmc_filter_faults_remove(adev, addr, pasid);
    2736                 r = 0;
    2737         }
    2738         return r;
    2739 }

regards,
dan carpenter
