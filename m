Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C67C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 04:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D959910E4B0;
	Thu,  6 Oct 2022 04:46:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A1210E4A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 04:46:33 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296046V0012678;
 Thu, 6 Oct 2022 04:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=RI64hc4HIYEREHODzvRtTytlmAFuYLf0d/OVUfYQfaY=;
 b=FfYZYc/VI2mk/Y82OmSV3NHgp9U4LHLEKEzmY5OoIZKJaMboRdKRVSV133IjnRYz1Pl5
 EbaKIUFNmYECXQOCz1UIEg/72lMdY/mfhMf+pAnztfsmQVX+RXmUAVI+NoBTtalDvTvM
 JQ3dw+hxKAInWwtB+XGgLoM8jTA1QACF6hphL1BlPf/deF2457vFijzgRKkDVOGvybcG
 vneRo+9XSnqvbClUXM6XyLTdnpc7zqArT5289W2c/SmqV0sxI7ZM/lvh5Jqf1mctOO95
 AwWn87GxI8Rq6oOCmkmHv7n2kwphzhIOMalwNXx4QNDr/ZlqyBvs8w0E6Wv91Dkcqo0s eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxdeab1xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Oct 2022 04:46:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 2962DhP3010242; Thu, 6 Oct 2022 04:46:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3jxc0byq1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Oct 2022 04:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9vGfYXAe8zweN/mMpi9MvIIZPQlYo3HNooecuakeDBgZi9Xc4rYT/ZlLe2uCB4DnaNOY1GD3+E29jF35K9Acrqr1Pl7zN5XpdLWEccCQ/+CP5d1dxOBXyqKXFKk2HZD7DkHHCXhZX63Qpp4KKrqoUUPb2XteWhqo6BfHT/gaiUeuGp2YZs5ta6fGzDEcha12XC6iQIZND0M8aN8yM/qELY3RFIOnt7562eX+UrkDw3GA4stA0j/wPpAHiS3SNiR4jj5IeR1VaYBYbzcbf+VAq1Y0WK8vjXeZ8ZNj0sXrpG6W5uWdvHNEnw7TXaupLjIMJiYPQgw3hQF8C+tm6jXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI64hc4HIYEREHODzvRtTytlmAFuYLf0d/OVUfYQfaY=;
 b=Y/HouX8xyHnwG6NkMT0CnuvlpEWn4hOYKD9VMhkLtrs+rfyHaEfI1aeZ1b2JFklRpAOg8TrKRNZIHNC085gV/LH/I3+m0toZkihHgZYh2mB/11mXJedOV+8Ub3zwOiOCb5wsY2+PELm90EXNjP3yQbKO01u+LMTpwfNNs9wl8JzPV9X1crEYSCfTqv99Gw353IaWUiiVvDEK3gVnh3i6zVHWsLbBwNZ66l3qNsX9RrgGgBEuldUsisyS0OVWXZHcgReNLp0Cc2qBGOCqvYuEMRz6JmOhXtcyYSfQSK7Md0RDhTG7cJpa14S7gshMo0beDyunRfVg7k+9W4mjYXqGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI64hc4HIYEREHODzvRtTytlmAFuYLf0d/OVUfYQfaY=;
 b=bcuIfiD9wEXWtdPqnVN0EAiHQee1zWMCk/DPAmQ8YphmGCp8cGphKCeloNS99PV9Xumpe96NGve4Yg1ubAqBihOBUZfNwGnteQfmz80+xzPL3EOWBLGnitzWXIMd9MlwJ/0Le8RTJ6V7/arPMEiIYKqiSEF8T8N6YMzT7Zn9e9Y=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4408.namprd10.prod.outlook.com
 (2603:10b6:510:39::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 04:46:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 04:46:25 +0000
Date: Thu, 6 Oct 2022 07:46:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alvin.Lee2@amd.com
Subject: [bug report] drm/amd/display: Update MALL SS NumWays calculation
Message-ID: <Yz5dmiz9B3QHvo8U@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR2P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa92569-6a76-4919-5d30-08daa755b962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcDJmaV04wZXy4mdSOSJLrhJ2dxAm/Iqs4KXLjtcasAyk0jhH1yEE9ZsBpO27TnzTDkT213JKqCj9QEFs7BlK3bu4S03xx5jPFS4cZ+civPivg3gsxjkAeBbEjiuB7Mj0+TFF+S4nqxxjut3o8k2Q5IeaVHwkXfKEiJZbM11FvzM2s3TThjSSSb3Og6MWBy3ZA+vyHt0ubVJ/fBNdk8qisMxuegs9VlTwBdiBsQ0T3IIsv2n0kKCoQDXSyJKAc0yiGscrteaSqVwfLGqVhfMqq+3rAtgwrZrMFPDX4PTNvRcWnMyF/j8gfDTJXOmkXLOuq2l9dWhKmHlVxoQXoA9GBTpFREyrltHc/b0QFT/5cHj2zHyIUTdMjzqfGGnbsjjB9upS4z1L2NY004jPp6pUhv12HV/6rmBJMBuzQVr5Vg7wucc7Ql8+4HoOn+whYwlhx26zUjzlzesc2VNRb4yRlvzlsBwnLivhaJoBa5aRAqImByhfbQpEYd4XNnDJYr9KDQD4XncjqhFVZehRvBpASOETG4qAs03fjPd9jsayPidY9x5hi4zuMDsPliMFSEMdoan+BVvatF7RHLwuDf2xv19hFAtorReSpn8xyDlTXULTmD09ZIveYqOXTShgK1zQMNXVlNfIVqqsvtbuN3uEt9tulAKNiOdfku4bpcG4eeyoVTdvysK19ExmkB0mhExVhHuBIzS4nYoISXdZQx9Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(33716001)(2906002)(186003)(83380400001)(38100700002)(41300700001)(8676002)(66946007)(66556008)(316002)(4326008)(6916009)(8936002)(66476007)(15650500001)(44832011)(5660300002)(9686003)(6506007)(6666004)(6486002)(6512007)(26005)(478600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRI4rKBUUkvFmKOi9W8SybdUPL6SdYasMbcDKGGfRKx1Ek+2r8l3q0Qa+gEJ?=
 =?us-ascii?Q?5dmL4ytYwbqEHzx2JPOEKV5dVQw+l5p3PnZboHl/gcvEn3iFF+W5ZTlol6fA?=
 =?us-ascii?Q?4OPFi3JIrhvy0tnf82DtvQhASwjYnrWuPrEpk9qtQ9lzrQaFexsXNlKVhTQO?=
 =?us-ascii?Q?8CHT5iFDBMvfkVXVH+3YEhVQcbIi0pL4qHm7JZJAvuKSrK5+Ks7/3zakUXeg?=
 =?us-ascii?Q?OnbPy/XcT6vUTVmRv116+gcm64opwFESnGXq17eRixqYUEaed9OxYaWcbK8U?=
 =?us-ascii?Q?BMZp9IJM4gBD3TmzD4QSx8y4xyMNugSiIqW81EgLY1BIZU7uJA6nEPnqvnyy?=
 =?us-ascii?Q?mD5ymX20cWa9dcVrkSt0zRIOMV77Vyf2BvzwsvbKqGkrokrVirNgA04r5jQ+?=
 =?us-ascii?Q?ndWwjYa9IReyRyEGP/6zXbWo8TDrrCD7zEsvEqLnFT7rSPxdpanVCX4SGvM8?=
 =?us-ascii?Q?HowQcKnkdIJX9T5rfr8pbxWvfF5jilYiK4AQM4imkwMlAdsAEheRAvbWDGXQ?=
 =?us-ascii?Q?vjt3UcAIuyH97q2DaZZJBfoBI8xT2qm/RWB54MympHvu5Hip8b0/Cxfkv7eP?=
 =?us-ascii?Q?YIbHVCzkIXqgfqEMsuDiZuSFiffNp8uMtXX+X/7Ti5iQRXdluojXGwSKmphi?=
 =?us-ascii?Q?vWjaixt3Pu0D9u/WNCwcyo5qy3n9zc2RQCUd7IwY60UZZj9PNcPyrfscnjqi?=
 =?us-ascii?Q?ncPj0V4pBJrh23lQnKZeyv7iLgaKZf2Y05WAFC0kIwl0MAmeaiSvJOa0w4K/?=
 =?us-ascii?Q?bQ6nptsQ2teym9DhaHmm1HmTj9YbyP7MdJxpobS1+Vl+PYM0Ssle9CZFE3O5?=
 =?us-ascii?Q?NYVl/MjbbI/oWbz5dld17TsoQl4zsqU+w6pqW9nWiHMMrgEhj7oSoJpP02uC?=
 =?us-ascii?Q?0kTP9kaqfX0H/1glYllPk1kyOr/JzQee+M/8ozn3tjEhffusHQgsZnBZRhL8?=
 =?us-ascii?Q?8OkzkExwwdCIbp3kMEVZS/fHd9HP3zhDu0f34jl4HXrkHKlQKmtXSOUS/dvY?=
 =?us-ascii?Q?PsLNkjA2n1UnoZQDgrfYulydRv7fjGiBp9d4NVnR9Iv83a+YidSsTjoPbTRw?=
 =?us-ascii?Q?12h3uv8THx6PzvnzDNKex2Pr9D/Sm1Lvtx7eANxiKCbTe82X9nEmaiOHAdym?=
 =?us-ascii?Q?oE4lONHzHRElxtZTn6v3kEFe1zzIq4udARdtN3+zKxC85nFs/IVs3JCCPsYP?=
 =?us-ascii?Q?xwpgXV3h7TNlegUGatNUenOrsWTUMxSdrfTzLVjPsRzs3gsyijqBCRKCWaUl?=
 =?us-ascii?Q?2mEzyF4TO8woPOME5YWEPUYPukkXItoSRYD+uGeFw131u/O2pudDf95DyUEv?=
 =?us-ascii?Q?2ZwRBLwEeRXiygyAD9woX9VcRjC02DVJKdc8BJtHUyZjX1daEGPRAFXpf3kr?=
 =?us-ascii?Q?RWUE04PjirLomPHTtigsGJiwh32JwVmvaXOrFNxqiNrOffQFubPSEH/qA2GC?=
 =?us-ascii?Q?/1hkgcfqRAteHHYSOX2P5YMllbqoxuwxVKrHWZPtCD/38k7Zf+xnp7UbxCIH?=
 =?us-ascii?Q?rtOczyJRpTgAikDuk+Ve93Y+47h0mVhZ1BRiXN4m0zQyz3utXISpZ9rLKSVK?=
 =?us-ascii?Q?Jl5Vz70ti/GjgX/+pPkOeoz1He5ksj9N5LjazL7f4hcY2EzM89WcDwMHQpmr?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GgHLeynkkBtnxNQNidoG+s48261pD1BUDmfSgdVdBEnIQ2i2o3KByHAcaYuwwNEirRSZbZ/npGJV3zods1/v7E3xP39+RGoj1pO5oJ/mK5hmy0zSuOxVgu6ekClnLMnqAV6elw6hPTG1QBcbrPRAfb7evp4JBzwg6EfCdUoPd7ZMbiKczzFfUGEt1ohxR1ZpOnQHYfuUwuV+590m4LocBxB24Vk4rMoQmicZd67oONjJy8LeLrZhwXZYBl+UffLMrxvnUdI/nQJq0FlYr3mf4z2QFpXLakzqEAiw4jWVpKRP77BC3r3+OhaN7GrPfMB0vZP0HdqUEhSWp4Vf1B0y8u2dUpFGJ8yvyR54oJhHLKx2G2YpbtfMDT75uNGC6cUcyHtAi9Ut/6xOqVz0fNx1Sl2rRn9dTwVu0gL4ZfbJOHM1d0VNzKqb2wPv+k2fvGFzSYV5B52E0a29tbKnBpbCC+ZRGAknq+bpbkSKvtOzJGljuBcXt9pTf0LXLYDopEDKvX0m+kmHS08eaPqQ3vcmgTPqztvScNmLD8kw09SU0OGikSkpn5U+WJmYy1EPGn0FOdjafpI5RQ6QquLOIikH4Nt6NEawf0LVsOCSizXhWilTjOLR3gSYA/01QgPQKtz1x4/FasagNIV5oMPE679B16Kdtr9MSalapTw1xLR1tUi2SrHSvBmgJv20d8rDWLITeFqCMRmC1vgEYeoGrd71tBvhlU4K10J8u/C0e7k4+CmhnK+3hUdUc5COzhisM6Xj60zB8HdD7slHZEiNAUZg72EE1uUxdKaxoLHjx8OvFjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa92569-6a76-4919-5d30-08daa755b962
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 04:46:25.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHgV6mKOaOs5FklDdlSD4guSwcb8jS9dXzJO6nWEGPrU/vG9kp8hrEXcRpAf1wr9v8qEJyFeTYKyDvlOVRpNWSuJ4GxB75uoYwC5RfW72A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4408
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210060029
X-Proofpoint-GUID: _mOfqqkz3iQ9gTTiakDqGrxbJppW6GY5
X-Proofpoint-ORIG-GUID: _mOfqqkz3iQ9gTTiakDqGrxbJppW6GY5
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

Hello Alvin Lee,

The patch 525a65c77db5: "drm/amd/display: Update MALL SS NumWays
calculation" from Sep 14, 2022, leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:282 dcn32_calculate_cab_allocation()
	warn: if statement not indented

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c
    276 
    277         // Include cursor size for CAB allocation
    278         for (j = 0; j < dc->res_pool->pipe_count; j++) {
    279                 struct pipe_ctx *pipe = &ctx->res_ctx.pipe_ctx[j];
    280                 struct hubp *hubp = pipe->plane_res.hubp;
    281 
--> 282                 if (pipe->stream && pipe->plane_state && hubp)
    283                         /* Find the cursor plane and use the exact size instead of
    284                         using the max for calculation */

The code for this if statement is missing so it runs into the next if
statement.

    285 
    286                 if (hubp->curs_attr.width > 0) {
    287                                 // Round cursor width to next multiple of 64
    288                                 cursor_size = (((hubp->curs_attr.width + 63) / 64) * 64) * hubp->curs_attr.height;
    289 
    290                                 switch (pipe->stream->cursor_attributes.color_format) {
    291                                 case CURSOR_MODE_MONO:
    292                                         cursor_size /= 2;
    293                                         cursor_bpp = 4;
    294                                         break;
    295                                 case CURSOR_MODE_COLOR_1BIT_AND:
    296                                 case CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA:
    297                                 case CURSOR_MODE_COLOR_UN_PRE_MULTIPLIED_ALPHA:
    298                                         cursor_size *= 4;
    299                                         cursor_bpp = 4;
    300                                         break;
    301 

regards,
dan carpenter
