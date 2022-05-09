Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20692C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 09:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BB510E7C9;
	Mon,  9 May 2022 09:09:38 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF8910E7C9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 09:09:37 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2497NuSa024581;
 Mon, 9 May 2022 09:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=vXKqinJ/ddTfbn5Weav7UDRdteRR1opHMDMvhIrKSe4=;
 b=s/+200lLJysC4cGEkhP4OhxXj+PwTU1MT41s5hJurBO0yQYGYfG7HWFyrWCFfXaL78/0
 bEV8Cr2y+Hm5PJTLrxTHRC4WEqIfqMYdwqFEBLGM6FQahYtsbeLSrx2ciiImaBaTOrN9
 05UkoOlvlALNiScKKtcarGMZFMWadm21VRLQfqxqu9AsjMXJm6UztiMvSyLGGaihiplS
 AKS8G/17ufgdS+4AXXIKEU6CDU/j7m/UOPurbnStNTDjI9SJbBjaJGSZx56nUshIRE28
 KIZk3q0n6Sa44WV+UTZaMssskPbWfVMb1nweXd1CVEKkpKyS95IFxJElXvQUJhr7royf lA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwfc0jt45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:09:35 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24995lGp037158; Mon, 9 May 2022 09:09:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fwf77u1cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYsYZBsywfRhvU3ckMKfcNKnbzTXvr7c5Ruuhn+2lvbGLwWFu4WE72Vj9GZmlvQMOab/cFO0RsG85cVGFUM5o0MlqH6M0NhR1aYpgN94fXT9QAAaRuko5phOqXTVQgZJ5A/91OPpUSIAYMAaMZXpkrkDOqXCe6+C8njD7yUuxYg/zUZO8dQWkbO8QHm29YioA93AlpdW7/dst19NHu8EZcFFRK7TGBow6ImKet20bhe0fYZDjA9bc/9QXdZBHfY/mKpWAb5yJExC95WMmXE8ueWxSCXvEjG+rj9baOhmwVLNVdDncMPa1gpXZVke6m35SCyVRHb2cAWQv5kd3z+BDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXKqinJ/ddTfbn5Weav7UDRdteRR1opHMDMvhIrKSe4=;
 b=ZPVSdAxfksIX5j5XZw+Kk5EqYVk4nWIVyW9t8lzpdbpZGQ07rIcmtQF4wiPMApOb7Q520hWAxEZwAdNXW8UPEMqrm9ZHbU7tsCfZcSY8i4F4r9q7hbIQOtiK55wmuMTnX5jJYKaZ6WkvlSlB0NfACUBOlKLLSecOCvDz92niAZX3H+tTU2vspcenqrvOiwnxLn3TaNgYl/ZY30LsXFeyEKjLVf/XV353eAYQW9hV8zkgvSF5r/EgTPViZuTSnVpO9Ynmme1Tvm5QjBA7WNiYMvPCUShbRF6q5nnjSbxbvf970Rbk4v8zlumo4mZ3PQ2rzpOBf+bX3NMUNcOfZFLhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXKqinJ/ddTfbn5Weav7UDRdteRR1opHMDMvhIrKSe4=;
 b=ecRyEMW0HTOk6A9ISrxOk0ufBdnqsK7S4on1B4fFMEsRYwlo+/+zXbXfhj1Wm6UE75MADU3+pKHD4V1aTRwEhVlSfn/t7rZcMIY7Zl5lh1fVvtRChsxeNzkvGZ2lvQYzTegpJBQzkZwnOH144PwYgXoZWKZXn0Zyc6Smhnj2llY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 09:09:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 09:09:32 +0000
Date: Mon, 9 May 2022 12:09:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: mukul.joshi@amd.com
Subject: [bug report] drm/amdkfd: Add KFD support for soc21 v3
Message-ID: <YnjaQscWYypNadYw@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0187.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 951a83e9-2e1b-4059-d983-08da319ba13e
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB45429FD4E84B278284282DCC8EC69@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjrRbZM2Sj7cuiBkLDb965ThITpjny298kg3jtoM69KSZwaL02s4ll1DdNZVHBKvqJbti7HK5wAgpUuqdOnF/HHW5HSt+R5UtwBzB8CMFCaIKhU9JP2Trjy8VUpUolYtCbyor6DtvzytNX2Lw4un7ZrTCoriLsGFUuqB+Vx1ScHoOUlGHXjlNmAZ2K2fems7kPe2291yUyDocdchw+fGPFUTgpS1/b9+yoJhlL+6ny27Ah7UoE9YEWV9k2VRfaxzyR9yo3QOq7QANFABYfwJNTKn1jbFIAM6dScoBzqCxfldQjDaLkzSQg9zWRbN2yL8qHJEWlleRb9QRnO7FyNw/EGugdI7/gPaIPIvULJy4uOEzuvVhXPezn6yRMsZPvyEEGpx1rbWv0NCtK/n1tiv3pgZckSkZHmUnjTB+ToNqq/JG5HIsTFwiVVL6kSYMby5XJaRVRe8/8ezupNZOVYow1Htp9Y6XRKgZXrwE41N6agCtbb4R7Je8CUG+N8S8j4jIcnHYi07hH4izh+4oLnezpn4ptVGoLsfXD/oFoKQWMdslVC/zzaPOGwRISg+g4Ep80Nmjts5UjdJyjMk19HPU9I+PzeVylPwTj5EsCvJdwESjDWU8Y4wlPGEY4kbjzzE3uBmRdyMgTVbJJIvLGCENNX4O2iEva93m3wIRXfuOrFMk64x+dC6P0eUx/WcW2rEHNo+mXyzNWzHgHc1X9c1Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(33716001)(38350700002)(38100700002)(5660300002)(83380400001)(8936002)(6506007)(86362001)(66556008)(44832011)(9686003)(508600001)(6512007)(6666004)(26005)(66946007)(6486002)(316002)(66476007)(4326008)(8676002)(6916009)(186003)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RK7Y2Ml+6bS50O1ZerHpp3eu9NtvriR6KYripemqSO3EToLQOXYHXbMX+Cex?=
 =?us-ascii?Q?Xs5AI4kjXuFpMf+xmNAgdXYk8UWvXCP5aeAMS2fvZ97IarkHzy55iBhe31gM?=
 =?us-ascii?Q?7dyRTsjAfcu4fd0mcNQY5lnl0kNOrQy7/Ee8pBDZ8w3T9nhkWc3vXpmJMs2j?=
 =?us-ascii?Q?0DgXuHw7mBWWQUBX7gqMwk5Emw3ewWKXSW5I2u0SNUmvluCrlD1kXw5ymObP?=
 =?us-ascii?Q?In41S9l6ccfK1itDUFvuc4PhyX1PiVsEXQvhsDEm00BGu9uGt+nhgpUTOY4s?=
 =?us-ascii?Q?qNEdQoCY5SpJS4uD2H9iXHmkSJ2luzP70/gjzSnKoXvbovGzURr2XZqr9/gt?=
 =?us-ascii?Q?vZEBKO5+lHvBdGzjxBZB+GybTk0YB3gReZw32JPvJ1GasXXwhIiZiYRxPWcm?=
 =?us-ascii?Q?ge6HvEEr4uB4fS/fuztUfPHXmjrd4hRbXdD0iSA1d33UubNBAVxo+vm5ZQGe?=
 =?us-ascii?Q?ARMu24A3OE5/4m9JQgFx2pabeexho8uCbIzr8upzJq/IRUbFo7wrOK7ikBR2?=
 =?us-ascii?Q?7R6ZViLz05reus+0qXrUVvIzpuX0+Gykih4anh2RUQnL65PYChJUqz8PHNax?=
 =?us-ascii?Q?yvfUyygrmaTfT9sZ3ECd7rQwU4k5GiKP2Za/TeY+H+sXCfFrHei0FN+BJ0i3?=
 =?us-ascii?Q?OcXyA0YXQqnJhCAgY3yTnQQjH7t2Bc2OhX4zjLyUwafPnxxW7Tv4GuugR8qZ?=
 =?us-ascii?Q?xtdEdprxplDY6UjI16rDfK6DhKAGCXnN40j5jj1VkGh0nFHfmu9MQmdJUpOD?=
 =?us-ascii?Q?xX+JkZQuA57GjsVjo8MYO9EUc30wmATpnRZaBId5/j0/zVCOe4N9RfVqIiWc?=
 =?us-ascii?Q?0IeKOpL+0FdKHG55QUn6NJKurmL5Xq1ph7fJbtfC/gv+PuQ6rzrBtlOxNl03?=
 =?us-ascii?Q?g35MzQyscizAHuMutZYJwfVxpe2A2DdFz+YG/63iQI4fS1k96P18ZY3f62el?=
 =?us-ascii?Q?Z8+cLkDON2n65rcyhPO1+veCvken22ZV4EdHWHZlrLpyfCiRukBNaqPdt+n5?=
 =?us-ascii?Q?MypLfPDUxpNo+XcmDaX4/rceF9hSA+i1QOXyRef9SzGX7wRqW6SPVju6SX0u?=
 =?us-ascii?Q?7sZwAcfKzTDVUWmh3yRmYn8DtH6LnfLzHCKeQRH4YdBFcBXyH/vfqBGIvo1r?=
 =?us-ascii?Q?xssgYcAddHLsyS2bOLyhHe71AEcRTSxPR0wxC74wsn+r5CoxTaCVhUYrkiCn?=
 =?us-ascii?Q?ToZEm7EwvgylKl2zqVRmlwMyuJTMl0TpIy9TE9v5TUaSKHlc9gPf4zL+IAZ+?=
 =?us-ascii?Q?HsfmlXthfL+vOmSyFM5unncF6TyzBWM93YNBQ4af45e/XxQTovZVzf+PVpYJ?=
 =?us-ascii?Q?skTYc42l69MIkyQTseFGUSsAXqQJkU30XGW65lhgHcmU7OO0yv5S/xH9WMHN?=
 =?us-ascii?Q?4lfARYhKmuKD5notBU63SrCpdOaSGZ9hvmt4rxw+ksKs18C358nwPm0sfHtO?=
 =?us-ascii?Q?Jr82YKQF22EDLa5iGZK/SFqDqSXgU6hSsqceAUwcvPCeg85ZW1ktSulZVKYY?=
 =?us-ascii?Q?y96ihpSxN8Pa+WP0TI0MihagwtGui8F4PGuc8iJbqj4Rta2Kd3Nso3TyQ/Hz?=
 =?us-ascii?Q?UXXPLWy06G9CooORR3m+eNwhJFSJhaALjqxrDHyoncZtUm7gGedxrTHQXsfb?=
 =?us-ascii?Q?vUapQMAp5uxR2oFHmGcjk9phAaDBLB37XlKY/C3RP33uPV+Fh0RPgysXmN/M?=
 =?us-ascii?Q?c6AQnNcOvaEeKg+abfWPK35lLPUDKedQQsMWIn3uC1n/hgFoz0TZY6YxdCSi?=
 =?us-ascii?Q?11cQ+0T+1rIigg02tM3FkEPwP+HJVX8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951a83e9-2e1b-4059-d983-08da319ba13e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:09:32.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyzVgKlORH5AVIVYyz+rflURb81LU6gG+vVrhLtYoJRoLTwPe6x9PNtXeNkUdMXEQQGXQj/ewkAMKNILvT0tjc0X7tpbfK2UgCDX8g50vYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-09_03:2022-05-09,
 2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=791
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090052
X-Proofpoint-ORIG-GUID: PT-DudW_JKK7Q5Qy2FdDMD07npC5j32K
X-Proofpoint-GUID: PT-DudW_JKK7Q5Qy2FdDMD07npC5j32K
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

Hello Mukul Joshi,

The patch cc009e613de6: "drm/amdkfd: Add KFD support for soc21 v3"
from Apr 26, 2022, leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:205 add_queue_mes()
	warn: unsigned 'queue_input.queue_type' is never less than zero.

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c
    173 static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
    174                          struct qcm_process_device *qpd)
    175 {
    176         struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
    177         struct kfd_process_device *pdd = qpd_to_pdd(qpd);
    178         struct mes_add_queue_input queue_input;
    179         int r;
    180 
    181         if (dqm->is_hws_hang)
    182                 return -EIO;
    183 
    184         memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
    185         queue_input.process_id = qpd->pqm->process->pasid;
    186         queue_input.page_table_base_addr =  qpd->page_table_base;
    187         queue_input.process_va_start = 0;
    188         queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
    189         /* MES unit for quantum is 100ns */
    190         queue_input.process_quantum = KFD_MES_PROCESS_QUANTUM;  /* Equivalent to 10ms. */
    191         queue_input.process_context_addr = pdd->proc_ctx_gpu_addr;
    192         queue_input.gang_quantum = KFD_MES_GANG_QUANTUM; /* Equivalent to 1ms */
    193         queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
    194         queue_input.inprocess_gang_priority = q->properties.priority;
    195         queue_input.gang_global_priority_level =
    196                                         AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
    197         queue_input.doorbell_offset = q->properties.doorbell_off;
    198         queue_input.mqd_addr = q->gart_mqd_addr;
    199         queue_input.wptr_addr = (uint64_t)q->properties.write_ptr;
    200         queue_input.paging = false;
    201         queue_input.tba_addr = qpd->tba_addr;
    202         queue_input.tma_addr = qpd->tma_addr;
    203 
    204         queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
--> 205         if (queue_input.queue_type < 0) {

This is a u32 so it can't be negative.  Some convert_to_mes_queue_type()
functions return -1 and some return -EINVAL.

    206                 pr_err("Queue type not supported with MES, queue:%d\n",
    207                                 q->properties.type);
    208                 return -EINVAL;
    209         }
    210 
    211         if (q->gws) {
    212                 queue_input.gws_base = 0;
    213                 queue_input.gws_size = qpd->num_gws;
    214         }
    215 
    216         amdgpu_mes_lock(&adev->mes);
    217         r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
    218         amdgpu_mes_unlock(&adev->mes);
    219         if (r) {
    220                 pr_err("failed to add hardware queue to MES, doorbell=0x%x\n",
    221                         q->properties.doorbell_off);
    222                 pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
    223                 kfd_hws_hang(dqm);
    224 }

regards,
dan carpenter
