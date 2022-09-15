Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B929ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 07:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932B710EAA7;
	Thu, 15 Sep 2022 07:42:44 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC12210EAA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 07:42:38 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F5bo5S009015;
 Thu, 15 Sep 2022 07:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=bagcAEpGDLLj4h9vuF/w0lZDopH3Z8kSyVUDAUOB3d0=;
 b=rhYDM4FizZhKfSouH+8lU3Pq0JrJeu2gSvej/SX4MXzLFRr1NNRhrxNjjIUOWdVfOdbx
 +30LhqAuCRRUCk7/EPeJYLqvmOT6SNdz9btWXGy+OQ4fvY8fwrLyyIKv3j/Dp/8Vgp1Q
 PN2hvbyhuZaYDpHnXqxUj9MMjUkC1PM7U8jR2vdSCpidTjQiDF0J82Z5Sjdpm7bpvetl
 MnqfkShPmKE1u207Yihj5CbFW/s77QX4w6w68/8y5CspPfAmEoMiWQTikZuNRvMwoRPd
 6aZ2YTDFtlDksY4BkljNhEEWvVY29KvuQgk1CS2olnb2+29MeIbSwyoELZ7XL0T76QJj 7w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypcgu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Sep 2022 07:42:37 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 28F6nTxT020759; Thu, 15 Sep 2022 07:42:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3jjy5f0g7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Sep 2022 07:42:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF4JjkncBkAJghe0NMGeNvU8uXYOUiqNVbl9hCjeKEcX9m9vwVAIzUal5q+BZhIy+U7gF+RGWcoKNSDKTiYkEuXidOpwSfitb/DwWQxIOaEpPFYtO4KtLBjIb57Sp5VM0YdGJ3aYSkKqobufUQ2wz3akylR6fM8xIuoGwg5hZRUG6LEePPb1aB5XiQdxqAHYu7rryDQ+xoI7eyog+DleUejJqTkZ7xnjc0loh2l9GMzukdKtWX+xGuYmxp/i4/N6pLfL5QQyarRFgZrBq4GT8TPEwmsuS719ZUoAkKWqL0pecdUoESpNO5Xxhq/1cSbeiePQUKzPjkq+vbZZvsATjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bagcAEpGDLLj4h9vuF/w0lZDopH3Z8kSyVUDAUOB3d0=;
 b=KnWtuhqPbEbna8Zt8kGClzSRakkKUUCvQ3AeJyXnpoJrZgkcuT95QTuO01evynLoXFfMBfBQ2+wTj7KX44rYFmU1vQdl4CSHtus36gsQbgomeKop5gr2axSrFc2zdql8qTXcqdmfhOXFa88j8TpDV6EyGawY4UOjoeV3VYUtYPs/IA4GbCUES6LoKRMwAnacb6YM9l+JMooAhvQ8qa+dVT2nro9RfEJIj4AELCHT6pDFMPhDphyaCgoZgUENw1LuBUi7rmQf5z7vdjvHtPTf0S7ErupkEM1ifv/MhJJIHF30vT9rhL1qSL5ubHJ3knpPTx+vUbWPvnQ6+DA7uAUvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bagcAEpGDLLj4h9vuF/w0lZDopH3Z8kSyVUDAUOB3d0=;
 b=MZc/zF2CI3AXw4nPs6RAeqwU6OLpwu+Ha5FLrZTKSXn6WTIdTsqWKYVRqyb7lDqgwXtiZFALke820aSNsT9tstu81n3BSenEI7fyTrR5pEP/f3BOQ+z6Df4NWVL5vMh0iCjotgjkWgHf2ieEFH4IJQDNtYNiJvTsipUufWq0TYI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 07:42:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 07:42:34 +0000
Date: Thu, 15 Sep 2022 10:42:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Iswara.Nagulendran@amd.com
Subject: [bug report] drm/amd/display: Reverted DSC programming sequence change
Message-ID: <YyLXX/vnb16EeKgl@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DM4PR10MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 8104043c-d70e-4f3e-cab6-08da96edda7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miQ+4vEbBnIdd73BcqnhAyLp+tp032ECs3IkR3tx7V1HYIQ4b8L2Vfh5KPVGR+NzbdvWadzVErznTZ4kiNptBwyW7Sa8u5xso8KRW4Fs/Zfx7sJnIqhiicc31fehcaQkNY7U9cK39bwT3TWCIVeAjP7Y7Kqu/IwWTWhVYd48IWhbfDV77qgzI2woKB7WQAWU00sFbBkbo14OERgG9zmWvW+xBoqFKl2uqjSNNFN7EiBjMvqavFU92DeahG0Gx0d8+6RB+E7HRW1a7pjMYvPn/RsUVbp9HhRiisc3FxW29KPKCie8dzrpuZV7BrxIy0ziCbV9lwjMJZTxka9LICKnaAb/exfUbNXeGt9puhn70wBSRvj7vtJiZ04SrEbhcJYXU1gSQaYLLeLLKh4dHZ1s7wlPFy3XNvLxKSx03IP5NkqRxdNjKpuisybUVKnGDHgs9gk54HvOCoHMVkusVcfGe57n005uKE1QaBre5mD57IGOYZIgOEgjlVuPGCm67hQkaFRl51nh7fK5vIzLHSzojowkZYIffsYy/nHD8fXnqWSDl7QgNTxCuFDi2SYYRh7ssVE1rElfcJwTHUXZbFic2zpoO8wY6rAnE9vs/FlenKkG5qFKBOioelDhSsdyUhpQdjJcZ83bjGrcFf+na6XaswbVxhY4COoXXFTipG0m4vNRc09d9gVm/cBu10IbQQ1KYsJETNvPbZ3jv3es4gEqLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(6916009)(2906002)(66556008)(5660300002)(86362001)(33716001)(8676002)(478600001)(6666004)(316002)(26005)(4326008)(6486002)(8936002)(186003)(66476007)(41300700001)(9686003)(44832011)(83380400001)(66946007)(6512007)(38100700002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9eppo3jZ1SEWc7BJWUlrvHg3tPNborNC40kd5h26/Rg4SS1OKTPQf9j6E0J?=
 =?us-ascii?Q?/RmutqzJaDsOBlW8YLLoPPy9wMQmvGQPrnBcGNdljP0siv6U9iU+j8pyNx3c?=
 =?us-ascii?Q?4FPEzHPK4h1wfOOa4NnjbXxcgmyqg58eBZUaeQxqGfDEWzsGGUnolA6dYYLb?=
 =?us-ascii?Q?OALZtTE9hy8Pz8XarBqKvsHd9wjc0r/ksG9aOrF5TiutRkC8euq1mk51JnrG?=
 =?us-ascii?Q?wUpuxm7ucjXnYN9cUzmVtIkVTRPvGxbLMWmO4l8ak7wDgR9FzulWMXfokEcb?=
 =?us-ascii?Q?+GU5fiKgkGg9gI3w+5j9lGMmM2AZ9iJ7BJpM6wTvGptLqdszLC2wbNzEPBqP?=
 =?us-ascii?Q?XWfy2xLhr/rxyJcRwYbZOGlXgq1cexZE29A4oRlSW1i2nKEWi2dnwJuJu672?=
 =?us-ascii?Q?Rnnlnjg/QD9EbZIHHfs5QwNwQHka7Co5aeEIP9euMvznVIo1NIgesgHRzEVd?=
 =?us-ascii?Q?dx3XcjilTrt1lPchd6pPshIVha8jEiOjeA5gIram7R8Ly9RZYsbZGaaLSPSO?=
 =?us-ascii?Q?MQh0PPLTL/FVE2a0/qa7ryWzY+FqSFNfBYeVN/DtR2AqdKH0Eb7ynDepKApa?=
 =?us-ascii?Q?GTBAWbBkFmx41fdlSjpFcS1hrsnBdOCgo+djd5OKi1565o249us20w8afZ54?=
 =?us-ascii?Q?ib2idAryMasfoSV2VWuWUwGPhvRpVXL+qJCkzciebX4hKJsMU/9WdAnO/g9u?=
 =?us-ascii?Q?eMRVhG4v9OpZHQ8TmWQKO00bQ79t6roF6ZhPTF2t5xeQmHxIQ32iKAv2dZTA?=
 =?us-ascii?Q?T7vH2D/KqsAzWA21/WPAJEDKWfnJ+DitU25IwTpdhOc7/4ee2crxzK50Er6g?=
 =?us-ascii?Q?oRwXVglGGmOCmI2GpIqlm76IVEpgEC9q/XWpymwa2ZcbV4ngMa/6hGaYYliF?=
 =?us-ascii?Q?7O6XY5uXpPEJfePVVoe8WlwihqgOWpYkhPj25WFD6Bl5mKhRWSw/23zfST2J?=
 =?us-ascii?Q?7icj9evVRTz1FmFYN1w2rpLOZH+IP6mGUm4AzcYNSaREhUueuNy8t1Q9Nqln?=
 =?us-ascii?Q?+Pm4Y5kJHpTfWFE4uTjq63OGIreyJHxFgOfi6WirQt9PU+LN/Hea1YKMeaen?=
 =?us-ascii?Q?A1PwCLGbbXeoQFJwHeNWRpkt/vPrWnQYnVx4C7qGxQwmNWkHltIjqz0aCtyh?=
 =?us-ascii?Q?Sc6qaEhzi3TzGJBSKo3wccKLFN0QTc+taxfu98Wslhj0xIFKU2+0Pe53jWwA?=
 =?us-ascii?Q?vQ8TSVmK2o7l0eaR7aBK7AeZVl+g1E/TgnfpF8aBJbXp3kkVC6K0+hHw34Vk?=
 =?us-ascii?Q?5ceIYWVl4hqJ8ln8h6BkTvyoLubKU2xoG8yAyZBMw9F9+RZGd599NSE3sD1i?=
 =?us-ascii?Q?uri6Xx9BTlSDnkvDO0RbEl8MNSgnM3R2+Jk4sDAamOs215JXbnmU916KMXPx?=
 =?us-ascii?Q?+uJA/XleQ41mQTxxmttzx8TybUxsAZqqgN335yqK1GI+cvvCCHJ3pLR99lJ1?=
 =?us-ascii?Q?wVJGhDQZW/xAWkfFLwCixDaw6qhm+uy0vd3tjuL7GFlztnsAfDdk139qS9fM?=
 =?us-ascii?Q?mQc+hhbnibU+S2jX9JFx/11j/7r0aEuK2DjS+t2gece+MLnLbhD2mRqXbwty?=
 =?us-ascii?Q?txJ2QZKQxnLx2K0o2+yt8P9lpUUyXgxw0Dh3cCyZ9nB8XxJiukiGfV/i1t1/?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8104043c-d70e-4f3e-cab6-08da96edda7f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 07:42:34.4976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILMbwBQqEw8wwMrIfQ3S3MRgKP8KkLzpeYaaa5EqqXbo9W8589HT+K40EQV3zIo09nj+4UqbPfhddVU/8ZvRiQ9qjYgmeZHTQBvO6rzB0ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=932 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150041
X-Proofpoint-ORIG-GUID: paOgztE6NjjT0E4VF-wszIvT2gFSR1hP
X-Proofpoint-GUID: paOgztE6NjjT0E4VF-wszIvT2gFSR1hP
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

Hello Nagulendran, Iswara,

The patch c7783a6ed4fc: "drm/amd/display: Reverted DSC programming
sequence change" from Aug 23, 2022, leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:4310 core_link_enable_stream()
	warn: if statement not indented

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c
    4299 
    4300                 if (pipe_ctx->stream->dpms_off)
    4301                         return;
    4302 
    4303                 /* Have to setup DSC before DIG FE and BE are connected (which happens before the
    4304                  * link training). This is to make sure the bandwidth sent to DIG BE won't be
    4305                  * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
    4306                  * will be automatically set at a later time when the video is enabled
    4307                  * (DP_VID_STREAM_EN = 1).
    4308                  */
    4309                 if (pipe_ctx->stream->timing.flags.DSC) {
--> 4310                         if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
    4311                                 dc_is_virtual_signal(pipe_ctx->stream->signal))
    4312                         dp_set_dsc_enable(pipe_ctx, true);
    4313 
    4314                 }

This seems likes a bug?  Like a line was deleted.  Or should it be:

	if (pipe_ctx->stream->timing.flags.DSC &&
            (dc_is_dp_signal(pipe_ctx->stream->signal) ||
             dc_is_virtual_signal(pipe_ctx->stream->signal)))
		dp_set_dsc_enable(pipe_ctx, true);

    4315 
    4316                 status = enable_link(state, pipe_ctx);
    4317 
    4318                 if (status != DC_OK) {
    4319                         DC_LOG_WARNING("enabling link %u failed: %d\n",
    4320                         pipe_ctx->stream->link->link_index,
    4321                         status);
    4322 
    4323                         /* Abort stream enable *unless* the failure was due to
    4324                          * DP link training - some DP monitors will recover and
    4325                          * show the stream anyway. But MST displays can't proceed

regards,
dan carpenter
