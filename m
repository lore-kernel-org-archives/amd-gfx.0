Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA7C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jun 2022 07:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE62610ECDC;
	Fri, 24 Jun 2022 07:01:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E010310ECDC
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jun 2022 07:01:58 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O4UqOm019089;
 Fri, 24 Jun 2022 07:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=PvkRhpU1Q/nO6KcR0P+InybCG5SBq5mfROHLfrVv0/k=;
 b=VufE4LnKG6wNqV9Op41mYZ3PnEGEZItJYKpWccCGPpwxspLBE3hdA7ap4pnxZ9I2CxR0
 1moO3+CY1+F+ZYSgndYPdQAO+HE6HbPQj5ktl/y+6BnJfC14G9aHW88Bf3xlNXymGlXY
 LVC2U19pozqfsdSM4VLwwlGDsPiDUyRrN/FNQugteVrkJKsgZeEc1yui5g84q+RBoSxZ
 IHacXkWLAQg0CNtpKQIG8FsYhFHh2gGIJUzcxH7uxpJ9EiyfdqbP93IZrJmuNCsunzCg
 8U2xnKMG3YZsNB4xdkDHTCgTAiJ8oxxAD2WIsdNaUP57aNZt+CnjtjPlwuIjv9/2PpRa rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0n26j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jun 2022 07:01:54 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 25O6un94032402; Fri, 24 Jun 2022 07:01:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3gtg5x68sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jun 2022 07:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRdOzUwCoYUxCrfJKEIPMwLG2Fx4//q9u0gNpzDIpavYjA9AME4DsWvKFiMHcvKbuAAf8HLkqkSVTrvJCRnSAQG4J6ZQORKfgNNoBGSaz5OgKLuAdJjZUVs5fEwJmAXeWw5bnn4E8OtrYLZDrRkgcbjFTRe9ptDoa0b6ZQ82iNaD6+i6ZFrlHvCn2JXJCxL+5n0UBeSYyex7jsGM3H4jpbgx1GtQeh4PAvAet1RX2PmFkR3Muq9NXEoICexPMOZ05Cc4VOxpX1QmtuuTBH3R35ZXinD7q9e1QdrjqutnnP5k6dbHmnb7KeO4rYNoNANMyOWbAGUsPqFZSHD3DZ99Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvkRhpU1Q/nO6KcR0P+InybCG5SBq5mfROHLfrVv0/k=;
 b=XOZVfKAJEw2GKL69/o+Zzo08spl7Ly6NtLw6w1DHC/4s19mmunBA1izgztxNRvTadhtXsvw5CROEtu9kBktspzQCK2N5Lu3usYrjV/mVMr+zI5NFVwPqHGy/3RP/0+eDEd+zS6bAKQiqVrb4Rg2HHZNImCHYKDcIeI1EsvP+e3p5cYEmXjoRKfIrSGj0GiWA3/cIGlRKY1Dd8PXOjx4cL8LJgr/rrfZeT6gvGprEM0TVTkUq5iSKkEKa9ctTG6qW3Qh83nGfM5WvPbPUrYz4ADykYAqxnEAVqwjb8+UlRjTtiVqQ2KL2Y6QKpdWV4QQ9qRSf1cGs/KV1PhMbDuZ0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvkRhpU1Q/nO6KcR0P+InybCG5SBq5mfROHLfrVv0/k=;
 b=PMCgSDdkDSB227jwHkwcBO5PsuhmeKbqqtqzyMd+KL6eTh9/DUodEOxUD8VHkA8aenrR/hkdj5icFuG6OKJuBQHLvORlHJnZ+wH+RIV7aDRcLNa9F8qwuHXetkSxXgmlFBbaSinNOwsy3cb7SsMRqyE52SFA4W7N9g3wYFD+2xk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3094.namprd10.prod.outlook.com
 (2603:10b6:a03:14e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Fri, 24 Jun
 2022 07:01:51 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5373.015; Fri, 24 Jun 2022
 07:01:51 +0000
Date: Fri, 24 Jun 2022 10:01:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ramesh.Errabolu@amd.com
Subject: [bug report] drm/amdkfd: Extend KFD device topology to surface
 peer-to-peer links
Message-ID: <YrVhVae4bFr33sTt@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0006.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3ae0b8-963e-4bc6-b070-08da55af69e4
X-MS-TrafficTypeDiagnostic: BYAPR10MB3094:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okPabxWqM7Vfp7pcI+XtumB0y96rC5R42EwsBYk4gf4oZOwVxsN987d0090JVrCGdta0S2gNRFNjXO/jwGGhXTQApN2bDQxL+OMfzgSihSr8FFXdZLaGzPwNWlCDunAvzXj5NggwYkDMrtsV2Frkz3//hjV17nWZh8Q89RrPHdkuNxqM70CYcJc2o5iGBbz86H2tUb6A3n1NSkrp9UT7lMTdluiKsm8WhlQjU1lrntKpU0r/wl7+7tY4nZ/gZLl+CbwRwS9N5IsNevVk30Vuh77CjhNv5vD1MUoIFK/tWhjsLQhq4fSYokQkJ1aNjo1NVaKBFV5yRD95usPYJX2bkVxYccts2vKSbEQl7+dvpyY4cJqkVTzAdUG1Hj6O99bWcBvbXHUD83YXeUpr8jjq8WetIZsw+ku2s6ZQgukbxMn5sWsHAmWjt0gqFxS/pEKQ+4slQWCi0/bgser7SJx9MOu7k9Cjgywt2j9hVQNh/qJwiCFZbjnF8Jm2BVfaQj6CffREILTeS/s0dXPMDDn+PCwTqb2E14YCihHbdCTkvbQqkJMcAO82j7tlDCJEH4vlSooj9jjbke/ogIDJBUkTnjKT3pO8KucXpXJfVe6WfwM88CfpDqK8AvgJSUoLmmX6n9lZOR1sYIN2xJsVpWA+6JIERdIvZdPWU+oIHGVLqTGEiyfyMoqdt3Moi3H6MbnF0KOcPaopMBhObSwpqxOmqpVYzWJ08Y4D2QGT9+D56dsBBZQed2xgBfpUQSz025CRqKqzVGRQmSqr1Nv4USKi9lJRsDESPV6j1JpE2gUdmXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(6666004)(33716001)(83380400001)(6486002)(478600001)(186003)(6916009)(66476007)(86362001)(316002)(66556008)(8676002)(4326008)(8936002)(38350700002)(6512007)(41300700001)(52116002)(26005)(2906002)(44832011)(6506007)(38100700002)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfV6oUYIx6J5GVMfvVbFrNmxLtjvTYBJ+2lNTMuwJGh4mfVSK4x9pqclyyS9?=
 =?us-ascii?Q?frnBuW+LBH4+4/IQ+KsUi/okFvo1s8rhrj+daVWrHXKLxaIevwvvPGe6JViY?=
 =?us-ascii?Q?Fij9gePGEs5wSjqLFMkDLXEVt1vpBu88MztqLTpTpHJsa+MRBZCZL9g+3YkL?=
 =?us-ascii?Q?lrGMVGEWpWtfmd2WxDIoqp2s587ZX2KkVzRJQW+SggUbkokR7tIQIDcXesTK?=
 =?us-ascii?Q?bXumf/kAksKn13Ky7OJXECFTOZ2FBWGV6FLhEOXgJqPrl1My0bFie7xwSZYH?=
 =?us-ascii?Q?fIyUQavaFGAS/lOZIpGwZeURBg5RzMtwlUN9LlcseGq6E1f8LU2qjbLyJpTi?=
 =?us-ascii?Q?OegPibZkxvsXHGj7u7pO28QlhKpwIgs4EwT/QKwIxpzMIM2beWjJ9tvST+kc?=
 =?us-ascii?Q?eiO/z5dkWQX4aniA71e7C9xwA2eWwtS9Dr9zLYf7H4xlVxU+Hbw33+YKtKo5?=
 =?us-ascii?Q?gqXrtTN5v8CC3Q42BM3ZTW5Jte2IyBEEAK/IN5E34liueZYb9Faw1gvtt10Z?=
 =?us-ascii?Q?J83y3SCon/6Bivr9QKHEdpsOOM0HMdLeiB5NR/DAW/ECDAgV6OqI8IHOlP1+?=
 =?us-ascii?Q?jf32W8/QkM2TaXmW/mDsRY3um5QNCOi2+myMwAjHDOEXEDHovZKR8Yttb1SM?=
 =?us-ascii?Q?Dkt/mzE04T3PC10DtjqPijDmk/3ZNxoyZXf6HVQAhOohLmmjjXJoPMhvwCPv?=
 =?us-ascii?Q?wazJo3pBlbfVaobP5MGU2HgcRhBHclsmUKVl+iFtK33tGi7rrEBGJZVjWPKL?=
 =?us-ascii?Q?6wX82gvEFv/czCRSkmUyPE3UE/Tysi5j7NOPS1dphwudLqaTLTLL8jkY9sFF?=
 =?us-ascii?Q?eHsrhb14hauhppMMq0JXqlmAwemS2BZr5Nn14MwIV+gXEzXphZkuhVUKajb2?=
 =?us-ascii?Q?mPlTb9O9kbBABWV+EZzX87mZghHCtCHeSxwH4wYBLtDXAIB5VIR4FL/UA1EE?=
 =?us-ascii?Q?osefws/ddWGXiKtbT5DemLE0zSoy8zeqRPh8emYrFau6pvyR33MnlzqjmhAS?=
 =?us-ascii?Q?VG3U0sy8J9BhWum8k7uC/daRZWxrhpf/19WEWAQZecLRf5Cc1QhL4UIQf2MX?=
 =?us-ascii?Q?cREv2YDVTDP194i9O4lnzvnEhgRN9upvUVywmqNAJKr9AVcKZEJLHA+UC3h+?=
 =?us-ascii?Q?3X3nnW1CZdiKjbUuBpJkopGFiikPeVpNumJNAxoPq41M6R8UM8N/+a3wNrV5?=
 =?us-ascii?Q?kW4+02ThihTl0Xt6P6HSGdbgyi4VVw76Toi37CZdcYU7lKUeGsjf95odZRNH?=
 =?us-ascii?Q?dcYipQmtp5IWiHmczYPvIwHYcueRlJGQIsCQp8J9giEl/4Pq2JT0gF+myzon?=
 =?us-ascii?Q?GrhJZX+lVAjseFJILmusCtXTthWRvFEytgdMy513fCPNSlvuACOJlOVFa5as?=
 =?us-ascii?Q?wA21opZu1Hgbm7kR9tKCWjyKSKMzOGCtLH5fSke18OauWsgXKRNY9SY9mgig?=
 =?us-ascii?Q?jbClDK1muikLwIanICz4CXwr14g8pnEdd0wOCJD2xv+e+QtdfqX120BXQePI?=
 =?us-ascii?Q?/EYKKWc8f4xSe52QmdKUB5mKVLOL4lUZGloahaxnr9N2O9RJ7i3TfO57DoK/?=
 =?us-ascii?Q?VgXBIf3+OBr0Ntd1EJQE21K7jd0xIZeDGzAyB/wGbGPsdHNI9AiQSQIjN/Kq?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3ae0b8-963e-4bc6-b070-08da55af69e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 07:01:51.2297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVLSviN3fIsNA3lVXaW4/vPh54HRH7+n0ewHxLZpMzaWSEUZ+SQc8ZQmV7BI2upXKyqsYeZ6evnMke3txNntQS/xv+VsYCvuObOIjW8TBpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3094
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-06-24_04:2022-06-23,
 2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240025
X-Proofpoint-ORIG-GUID: yTGg39v6sL-cw2hoR6HBB8lpoBXPtj-r
X-Proofpoint-GUID: yTGg39v6sL-cw2hoR6HBB8lpoBXPtj-r
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

Hello Ramesh Errabolu,

The patch 0f28cca87e9a: "drm/amdkfd: Extend KFD device topology to
surface peer-to-peer links" from May 26, 2022, leads to the following
Smatch static checker warning:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' could be null (see line 1420)
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4997 add_modifier() warn: use safer allocation function (eg: kmalloc_array)
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1601 bios_parser_is_device_id_supported() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:407 get_bios_object_from_path_v3() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:613 bios_parser_get_hpd_info() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:820 bios_parser_get_device_tag() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3151 commit_planes_for_stream() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:395 dc_stream_set_cursor_position() warn: variable dereferenced before check 'stream' (see line 392)
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/amdgpu_smu.c:140 smu_set_gfx_power_up_by_imu() error: we previously assumed 'smu->ppt_funcs' could be null (see line 140)

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c
    1393 static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int gpu_node)
    1394 {
    1395         struct kfd_iolink_properties *props = NULL, *props2 = NULL;
    1396         struct kfd_iolink_properties *gpu_link, *cpu_link;
    1397         struct kfd_topology_device *cpu_dev;
    1398         int ret = 0;
    1399         int i, num_cpu;
    1400 
    1401         num_cpu = 0;
    1402         list_for_each_entry(cpu_dev, &topology_device_list, list) {
    1403                 if (cpu_dev->gpu)
    1404                         break;
    1405                 num_cpu++;
    1406         }
    1407 
    1408         gpu_link = list_first_entry(&kdev->io_link_props,
    1409                                         struct kfd_iolink_properties, list);
    1410         if (!gpu_link)
    1411                 return -ENOMEM;
    1412 
    1413         for (i = 0; i < num_cpu; i++) {
    1414                 /* CPU <--> GPU */
    1415                 if (gpu_link->node_to == i)
    1416                         continue;
    1417 
    1418                 /* find CPU <-->  CPU links */
    1419                 cpu_dev = kfd_topology_device_by_proximity_domain(i);
    1420                 if (cpu_dev) {
    1421                         list_for_each_entry(cpu_link,
    1422                                         &cpu_dev->io_link_props, list) {
    1423                                 if (cpu_link->node_to == gpu_link->node_to)
    1424                                         break;
    1425                         }

If we exit the loop without hitting the break statement then "cpu_link"
is not a valid pointer.

    1426                 }
    1427 
--> 1428                 if (cpu_link->node_to != gpu_link->node_to)

It's weird that this doesn't trigger an uninitialized variable warning.

    1429                         return -ENOMEM;
    1430 
    1431                 /* CPU <--> CPU <--> GPU, GPU node*/
    1432                 props = kfd_alloc_struct(props);
    1433                 if (!props)
    1434                         return -ENOMEM;
    1435 
    1436                 memcpy(props, gpu_link, sizeof(struct kfd_iolink_properties));
    1437                 props->weight = gpu_link->weight + cpu_link->weight;
    1438                 props->min_latency = gpu_link->min_latency + cpu_link->min_latency;
    1439                 props->max_latency = gpu_link->max_latency + cpu_link->max_latency;
    1440                 props->min_bandwidth = min(gpu_link->min_bandwidth, cpu_link->min_bandwidth);
    1441                 props->max_bandwidth = min(gpu_link->max_bandwidth, cpu_link->max_bandwidth);
    1442 
    1443                 props->node_from = gpu_node;
    1444                 props->node_to = i;
    1445                 kdev->node_props.p2p_links_count++;
    1446                 list_add_tail(&props->list, &kdev->p2p_link_props);
    1447                 ret = kfd_build_p2p_node_entry(kdev, props);
    1448                 if (ret < 0)
    1449                         return ret;
    1450 
    1451                 /* for small Bar, no CPU --> GPU in-direct links */
    1452                 if (kfd_dev_is_large_bar(kdev->gpu)) {
    1453                         /* CPU <--> CPU <--> GPU, CPU node*/
    1454                         props2 = kfd_alloc_struct(props2);
    1455                         if (!props2)
    1456                                 return -ENOMEM;
    1457 
    1458                         memcpy(props2, props, sizeof(struct kfd_iolink_properties));
    1459                         props2->node_from = i;
    1460                         props2->node_to = gpu_node;
    1461                         props2->kobj = NULL;
    1462                         cpu_dev->node_props.p2p_links_count++;

If you fix the exit condition above then probably this warning will go
away too?

    1463                         list_add_tail(&props2->list, &cpu_dev->p2p_link_props);
    1464                         ret = kfd_build_p2p_node_entry(cpu_dev, props2);
    1465                         if (ret < 0)
    1466                                 return ret;
    1467                 }
    1468         }
    1469         return ret;
    1470 }

regards,
dan carpenter
