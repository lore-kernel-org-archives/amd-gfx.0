Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D2FC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAE810E2AB;
	Tue, 26 Jul 2022 15:22:02 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B702610FB71
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:21:59 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEEPbn022640;
 Tue, 26 Jul 2022 15:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=YNKjIb4l+W9lyLzNOZKJusWCz5ChWFgR9c+Lg/2Vqlg=;
 b=YPtq3CCOCzaaRSMniql5t0AWXwYFS813+63yZDLgnchW8MCZsK4PepRCYf2wsKRHzCdy
 aAPsF1j4W8O4hKSz8j1Yme/jbBMqhABotdg5cLE6+RnGI3yvO94G9ziLiRwIz/OyC3t1
 TTy+mKoKE3NU2u6USpPDsdCkX4Ndg6eQVhywuderVvqRtFo+w5On+SO1+c7+XQHt9wKw
 foudR1MUSU3fyjWQkwFnLb4FTjna6Z9ZR3THmCp76cdK28ehHDJ0MkcX17zG9kCJMMyb
 lRtLdtVZJ0ApzWVJrSbWvZqFF9K14DhF3pNPhHx1emFb6AzAnfCxTtDD7xJDImQzPFkP wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9anxga9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:21:58 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QEfaN3023008; Tue, 26 Jul 2022 15:21:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh5yuwmne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WO9fRU8q2RCPljuMXC5KoX4RbW3oWGTPdyU8lBf2r1zGTHm9uTgFGSozrn/a/teQ0TAtZubd9LTXUV+gX7E3kBufJP+J6f1l8XT2R7R34dSjadK3Bof3hQlePzv2OmSGQOZA3wXdIA9M/uTWRUOHHWCDWuTAAZVjq6dtXUw3fXEb8DkVhH743wAWZAWXbkmb4pSKRPnF6bpzSgFYflNymixi4LyamQl4V3O9w7toaEnGASBp17tNSe9tEE0ntXBnsF+JBzD/s0ei80uemhitNa8ZcOSfXE6BuRpNJW9yj3Rz45WBqcjcCTZEbhB8DXxWrmrM9xNc9KrYZm9Ouc+pEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNKjIb4l+W9lyLzNOZKJusWCz5ChWFgR9c+Lg/2Vqlg=;
 b=Zoykh0t1KNuTVTaPteFf8zTJOnOfVM54Lb3IJ2s4eAeRr1CluzE6Sc5uia6TJ+1RcwJZJEXM3Xoii5I903neWthc/Ai2lCm8lDpp6AfKhkASpIqTEPpNck8HIiHG0RWWjXEpKGEcHPJmEKv8YQRIXw/G5Mm2t/DkUwQWu/rgZnUJIsEjvNbDlCQcHl05P9tKSMuAqLo9u5a11u2tszhm7U+ZXWe2YCKJ882XnzA647Y1qln0w1Cyr6zbmf+SCaJ8G93RKLZS9GLVx7Bk81QXTIaLIjZ2KgdPAspO5v4U9E0XwQNc3rnLfGGIWnVKYHhyFK4aEsEaZKvBjWzLGmDI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNKjIb4l+W9lyLzNOZKJusWCz5ChWFgR9c+Lg/2Vqlg=;
 b=NYOXapkV+dowJvGZyT93PEKq+Z1ptP/dXH4vUv5CmO7dE3uWutxtAe0laLyeEqVWKl9LusWNx5WaZ6xtlve9B5OVMhwqSGLh0gz6ZJACUla1M2Ywix5V5P/pm6qR0PtlKpSCzvGrcvPE6+AKsXTVPJZmpmH/MDl3Z0BoqpI1h14=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6219.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Tue, 26 Jul
 2022 15:21:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:21:53 +0000
Date: Tue, 26 Jul 2022 18:21:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: vladimir.stempen@amd.com
Subject: [bug report] drm/amd/display: Synchronize displays with different
 timings
Message-ID: <YuAGidrol714y6OL@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0085.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c27a49b-8b2c-40b1-96b9-08da6f1a91cd
X-MS-TrafficTypeDiagnostic: IA1PR10MB6219:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yT3T48py+kpmW/wPa1F52d7NTYvMhpU3wyUVWuYENmG68xTeYHZklksd8AwiI9qmb6+xK44Yccsm9QqZ4KTbjDuMGlw7S0mHgJpwBFvbeNb4KyUazTBUnCt3e9VdFKPgkZzRPQLnIH1aznoPyn1B2+5YXyGZzRAbfeS+7B8qWMTlMeD1bpUZbGznvWzcpd2Ahp3YS1pc2HsB/0sIaNfzHxDHnwNl0ys0NHbzdmRU41Z+sCUMECdSFX2xyGEKpJ0SdggGf+pgOBmx7J/59+SUmkm00jB3CtG2TuoVj7DP2M4wbjI53CArXZQeAOkdGPyayAswNWozuyoNHeOB7vejYhRIdYRAS7ZcoKnzYkEk2PFkapUw1pSZsb19FHLbaOANi3whK742YjZ28HInZX6TAAcH3MC+XU7dxkqJ0RaIfxXhHruF5O2XLTxx0P09vGOZJZD7mDq7QwHN0lNuJUtIP/nT47n9FGVOrZ8eFwmvo/3o1+6hkcN+oLKG+Ac7StE+KKsTzi2j7SLiGU5UKiDEyQ9w/i1jpKQ03tmocQKqoxV8rTglrUoUnoHqNdtdRmVdkVmwpodZTkYc3dW3d991E0WNh+QCIK06ifw+f//lYPw5JTFimhgMwd+WNmMiqOV6LRVpabcl3zb2H8h6zlKDkcDNaIdYCb88muHvsH49xLHpkqIttA+W5QcCcHRigk3l2vhCIJUGllrllDhBwEKcRk0Ac649YyJ+OZaZ1pWl/VzbFtHzVhIeaHHtyDXagPuM435DvOLEgij02nxYmxsjhehrds3nEGX5M8Zd6F5P1cy81tJzLtg68fslTQgDdEsU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(33716001)(2906002)(316002)(6916009)(52116002)(6506007)(6486002)(478600001)(41300700001)(6666004)(44832011)(66476007)(66946007)(8676002)(5660300002)(66556008)(4326008)(8936002)(83380400001)(86362001)(38100700002)(38350700002)(6512007)(9686003)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TYInA/T3BrX5SU+iLbTenMXrlmL9zOCaILU1AbivRQzDSpcpBW5jOXYYGA7/?=
 =?us-ascii?Q?bvXrVF58Us0GJDM/w6QTeA5rQXQBiTvncXzSguv5Xwf7OhfeHl8v2u8cBHv6?=
 =?us-ascii?Q?tWk/gCnV0VleFEENd00Min5TDusxV/q2ty6XmmWtq8SkPWFgQtUqmVTR2Xij?=
 =?us-ascii?Q?1jDOfmKMyR4Mt4BzamN5kmRvNFWkg0cebDI9t3UvQx3g/hdaVJz2jCU3MzWJ?=
 =?us-ascii?Q?pmqok0kUxZ5QhaRyQqHybXKVo+FkZvDmSlSZNPn6PjW2mrbVlW9L+8PZ9xKY?=
 =?us-ascii?Q?KCTet9oj2MMNbL/7VIwGQLu4/MvWwF5/Da+QqhrvXUM55EiKgKOsog2I2f+g?=
 =?us-ascii?Q?LI2BfkvMDoPGaAjZ9xjYd+XgiGEcGf28G1xgTSPf49N3Rakt6TCeJNFha3i1?=
 =?us-ascii?Q?h8/Lpig7ztoeUWAPzMNXR7dKyO3Q5iNEUWYofe6fcVU/l7NVeoDxph7spUFb?=
 =?us-ascii?Q?2BSHfsuyA/wm4qXjgMIh2IZRJnz+CgX7fhU0wkvqelnz/NUDDzNz9Pe2uMoY?=
 =?us-ascii?Q?Ag74d/oVQBI4JD/4RoHi/ELyTs2lQc7FdbWPnJO2T5HtNVgEr0X/pbK6LK1u?=
 =?us-ascii?Q?e6NgsxQXXbC9p52O0TMJCetUyIVdGldTdTmlB6G3s+X9Eqwlx6aiWTE4E4yx?=
 =?us-ascii?Q?TuC/VJ8k9Sd5m4ihdDdNKJ3DCsP07Fb71NhnwhCt0XxN5X4YW9luqz2uf/LB?=
 =?us-ascii?Q?6I5cs77EeLqTxTcYhRMpyAVjahiyMdZ/gbXu1s8L6DC98lgXkMVk5XqCAKj3?=
 =?us-ascii?Q?M3zN0KzpD+4kDrRDwecLeumMAA/BSPZJd2/7BU4CSD1dsc1cRm6l2q0ghj7G?=
 =?us-ascii?Q?DqbwnnGS5U9li7TWTfIFeBWExgEaJntBuZk9XkI8FF6BjHWLknjCjQNxU6iW?=
 =?us-ascii?Q?XVW3AUs5+QKZnF0w44lveBf2YK/cn9b1IO1QfdCuRIHDic17AQr8k/SAs2u5?=
 =?us-ascii?Q?h2hZLzmRl646xNezFEtTF1C/Jo4ROEe0orke3p2Xtzq+hz/+Mph5fuwbMfhF?=
 =?us-ascii?Q?ISWb0+piaDSBj7gHV7fBPouTcOxdhJSqaEEfjjYLvHIGa3MfWOLYal7mXuR4?=
 =?us-ascii?Q?NyEZWx2mc29gdpNkZYxPREHm3fKltG6cXMzCsn3SDRfrdInKonejc9tOhmkj?=
 =?us-ascii?Q?DJIhWyrqjojc1oU3sV10ICg9pgw9w6uRgUXXjXlmjf2bOgEYL90rpw9IRj6+?=
 =?us-ascii?Q?GkWcetCvWdou2PLHX4Ew4i9K884L6h3riVIxw/5n45GYVactN3kDltqS5H1u?=
 =?us-ascii?Q?d2yxEqcMoT3qnxahjCPCATg6tBDi8KgKXv+BR1IvF7auv4ig/IPpQiK/z9x+?=
 =?us-ascii?Q?0z+rQsfx/fHSQ+vonqaWhdC5ttPdnGKjzZvd1P1yD7BEhRAYcdyWSO4yUXoo?=
 =?us-ascii?Q?wEDumFALKE8T+XjJx/R7HA7/2fw5s9Ig/OTbD0OwvpSrrvZbLcJFJfQxfAkA?=
 =?us-ascii?Q?T/irf6m+L57mb/FUUTF6u5m+Ka2fPU+L43ZF+w1bhgCWjFd/jvQV9twRedr+?=
 =?us-ascii?Q?Unezygi9N4UzuCrrymVLL9ZWVDinTqjIUuPyCt0m3PnreSOXnf52LLnmwifN?=
 =?us-ascii?Q?jcxv3luRXOgxQvofDxUiNmFJ1f5fubkCSfmpwfXaaVFgKC/Ga84jJXJA/jHV?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c27a49b-8b2c-40b1-96b9-08da6f1a91cd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:21:53.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOBjpKzvcbNor278BHjFq64p2oE59y4E04zX/At7krAgyd7j1ZxE0hU4VXyMZHWasI/xQhwk1aa2SlMmR8jAfvbiA4US672Hv5JK/uPiHUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=630
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260059
X-Proofpoint-ORIG-GUID: hVSMoGQs-RzI42Cc-NJL67l7KkQGNEwF
X-Proofpoint-GUID: hVSMoGQs-RzI42Cc-NJL67l7KkQGNEwF
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

Hello Vladimir Stempen,

The patch 77a2b7265f20: "drm/amd/display: Synchronize displays with
different timings" from Dec 29, 2020, leads to the following Smatch
static checker warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2199 dcn10_enable_vblanks_synchronization() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2207 dcn10_enable_vblanks_synchronization() warn: inconsistent indenting

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c
    2191         DC_SYNC_INFO("Aligning DP DTOs\n");
    2192 
    2193         master = dcn10_align_pixel_clocks(dc, group_size, grouped_pipes);
    2194 
    2195         DC_SYNC_INFO("Synchronizing VBlanks\n");
    2196 
    2197         if (master >= 0) {
    2198                 for (i = 0; i < group_size; i++) {
    2199                         if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
    2200                         grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
    2201                                 grouped_pipes[master]->stream_res.tg,
    2202                                 grouped_pipes[i]->stream_res.tg,
    2203                                 grouped_pipes[master]->stream->timing.pix_clk_100hz,
    2204                                 grouped_pipes[i]->stream->timing.pix_clk_100hz,
    2205                                 get_clock_divider(grouped_pipes[master], false),
    2206                                 get_clock_divider(grouped_pipes[i], false));
--> 2207                                 grouped_pipes[i]->stream->vblank_synchronized = true;

It looks like this is supposed to have curly braces (this code is buggy).

    2208                 }
    2209                 grouped_pipes[master]->stream->vblank_synchronized = true;
    2210                 DC_SYNC_INFO("Sync complete\n");
    2211         }
    2212 
    2213         for (i = 1; i < group_size; i++) {
    2214                 opp = grouped_pipes[i]->stream_res.opp;
    2215                 tg = grouped_pipes[i]->stream_res.tg;
    2216                 tg->funcs->get_otg_active_size(tg, &width, &height);
    2217                 if (opp->funcs->opp_program_dpg_dimensions)
    2218                         opp->funcs->opp_program_dpg_dimensions(opp, width, height);
    2219         }
    2220 }

regards,
dan carpenter
