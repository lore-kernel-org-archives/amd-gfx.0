Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 14:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53EE76EA4A;
	Wed, 24 Nov 2021 14:46:32 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E66C6EA4B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 14:46:31 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOEDHP3026940; 
 Wed, 24 Nov 2021 14:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r2FlJ8OET1K7TGTcPmuznHcg5hEE1hT3I28qU1MFD3k=;
 b=q580k0pv6WgU91kf8ft+oQXZUWD8yyAEHD7qmlwYy97Sgvx7lnHnBE93Aligv46npzG1
 1Dzc9oT3r+Xnm/PJVtF1EWySSAs2jIqnPkv0Lzwd9y5xefPdxA0QOEb0hmXtUEGH+9aS
 n0kylZ0ncZNWQ3xq3eAkbRxskplOiRFTwN7XcjiZtfQIac0/QxLhnC62+1CwQOPU6u17
 MBqxgGamf+ZZSrHIC/dixPJOd552ZF0zANNH+ZoWXxZ1w5z0v94wV2jUG4t0hRAyJjBA
 ju+pOLU5Ck9ExMRxa+gW+K/lcXHLFgokBvOacCoRr8y8FO1CXg6mn+cvk99tyPoG1C6n Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3chk001hy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 14:46:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOEj7nH158809;
 Wed, 24 Nov 2021 14:46:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by userp3030.oracle.com with ESMTP id 3cep51qpem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Nov 2021 14:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqoCthi0kn3luBzbYq88poozGFgdc5YYHUc5cwABck3hVFU1FqPd4vk4EUq4zNQMh02BrqQQtpwXkQ4qaqliKnKcMlW1yGluCaXyY7CrX+68VkOywaY6r40XV2TAUR2eddBghzDc51VEBEBLdrT0EtKZm7C7zGoNtG9JcLRzBs+m6Si4oyE0lJD9NTiNi8PtPd1RDXE8sRwshkEmRshKOWAARKOiFN7W2RecwadIwiLW4a9GmxWSTr1D+v3uPb++cckX4WDj6Nec1N9GdI8WAgX454XFGfYqOuIq9rLS4MNbitWT3rlGAnuPWhLfMD/hzKETj/Wa/Ghjk1oeOhQ02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2FlJ8OET1K7TGTcPmuznHcg5hEE1hT3I28qU1MFD3k=;
 b=VQHg9ZDfufptfFbWi8hcNclXZycKkU1cg+JwcVIVWXB/IElwADVGgH6Kv1erc0qMPOk34dzilOPdagTX549/dSIouU8ZxDtzzZK+wTY/Vue6VbB/NxIHKDbzLVaxgu6Hr1V7RBkInkFH3Ui7oLwgwHzl9MAvUiZ0LqTH6QdznuPfPaoKpTiuBELb6P+w7E+Toe2aiaLL3MW5UPItXl/GZOawISzYeV/bT/K8SFxS2GU7hWh1MN9S7HDGufMKL2Kzbt4lgA6jNIh891oQLWhC3Va3WdySmfXWOiOD4U4kmVh1v8CM7QlQGyxQmaETnFRtWKenLwg+pzAUjVgYrzkVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2FlJ8OET1K7TGTcPmuznHcg5hEE1hT3I28qU1MFD3k=;
 b=CbowO0yA/eOnAkZ9aO4Rhq/7ys/7TPYcaKlil49zU16Qt4NEkfAnuofQK5qCbxtksNBSRe5zKQR6ahW0q3eLACvfWPHDYI/LWNs4Bo4D3m53O8OImJktbEndwKNkekFcpUcSaiv4c8dt6G3jXOiDu4oMa7BTP8J2jPrbcu9mtoE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4484.namprd10.prod.outlook.com
 (2603:10b6:303:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 24 Nov
 2021 14:46:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 14:46:10 +0000
Date: Wed, 24 Nov 2021 17:46:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: yang.lee@linux.alibaba.com
Subject: [bug report] drm/amd/display: check top_pipe_to_program pointer
Message-ID: <20211124144601.GA13237@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.10 via Frontend
 Transport; Wed, 24 Nov 2021 14:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f5ca6c-1dbb-4d19-bc36-08d9af592790
X-MS-TrafficTypeDiagnostic: CO1PR10MB4484:
X-Microsoft-Antispam-PRVS: <CO1PR10MB448432F380CB41E1A01E0B4F8E619@CO1PR10MB4484.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJErLt7hux+cIdKUQZmKc1Hpp8JxL4zX7kMpfz293Mx3mG9JYMynTuvsFSI9Hp3d4RNQ9+7fI9zZ84c4GzSKwRlRF20VuZfVeNgu393oohxukCI6+eHtTsPmjFTZ+qwQm3TC4O6B5RnYTIf/mVLgsdyjYJwnVD1v4pqQzysgM0i1Ad1LAdQwPc63/MIwGvDWjBOxuBW9zOVqaTJSnGeOQEGbf99nbiSlInjeVUmLdWC5sILF8owH3iuQvtUPOMtnhu2tKYoMMqAuKSMUx6X5Fjx/9os88MFzzKC4AseOaIJpH8KZj5KtwZ55b8/arqRFcl7Jan2TMWtp3f0IlWgmp55D/hSwjOy8S1yt/KPWapr9vrSMHlRsTnDUPUyJ7CYMykAVOB4IIg3jEqMHgTZs+zOWQUXkZ1xmm6gUispflZWT79Ct9MsRBmeTk1mtLh2VUqB8iGYjEh9D5gUi347Fs4Qeu1/ENNV0HM3gOLm/WjFIzLe0OuLpC2r75M5gCs7pEqrIGZp57X6eaYWhxZyeq0/b6YiSiG7mAt7RNRcgkVHg3ET5tHJybO5P9Bl/g7ijRPJgUNwQEtiX1Oyji6RTitTdWA7zoql+Dt4SDQt7mc4ajeorYCA6gB6j3lUEbIoK8lHTgmy9kAFjOOsGELFZeBYc6znCqv6qdoJr8gZQNc9Kep8hFJ4cxbs79YaY3LNZCeIicvWwMVkwr04Wben02A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38350700002)(8676002)(316002)(956004)(38100700002)(52116002)(33656002)(4326008)(55016003)(66946007)(83380400001)(66476007)(6496006)(66556008)(5660300002)(186003)(508600001)(6916009)(8936002)(9576002)(44832011)(2906002)(9686003)(6666004)(30864003)(33716001)(26005)(86362001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujxkBW98SMl+m62SE+qRsfgvWz5CSQYiCClIUQgY+cAZghu7mSYynNuC2GrA?=
 =?us-ascii?Q?vTgJt9hliYYOe364KUjwAPptIglN+SkcGhgtaKRTlQb7gl57UIEf0D64unaN?=
 =?us-ascii?Q?nU3f7d5+LANxUL1Lliuob5YrLTWEfBssEZrAsIix6rYyMdH5f6spnYGhYTPu?=
 =?us-ascii?Q?5nIRWcGjjbaRlvY6UQUqsTxnLH58QbbRU1dcJjyiXChg8riqIGcbjzx7Jupk?=
 =?us-ascii?Q?Spy6sx/MCk5WJEoQikQowrPAa8GJDull0arqqwF9TFl89I1KG4wt2/va50+u?=
 =?us-ascii?Q?1hWdNMML1yv7fHnXvCByr7grI0nSYFMDrQRsKdqKwvY9bFa8tHDJxMmUzfPX?=
 =?us-ascii?Q?Bfpaf+dI5MQMBhimbW+fT6Wf/PMQFoR1TgLS/pbU9P2eEC2HZJvcxeSAVXuN?=
 =?us-ascii?Q?Gv1n2aWOot6H6w5EJtB4DmdcOkRP/AbfZ0m1EAUY0qhTxT15RtbpL7M4QV7Z?=
 =?us-ascii?Q?qyvv6lHlkaLdsziaoQM6It+Os2yWt8qCstMMtLeaL3+6vYzENCqbdkirfKeD?=
 =?us-ascii?Q?CSSCi1CpWgHttdk0AbjK6auJJUCwzTEqKWm0KXEI0QmfrypxTy34uNdZND+N?=
 =?us-ascii?Q?BAWZOXWFwpe2bgVKUHhUaMAeYUkwc7w7WXCDXHraVcKNpwLl+8CrIb7JPM61?=
 =?us-ascii?Q?O2fFlwIT5RCuEEI83kp4bddCPp97pDsgS3Zww/r3a2Q9PDnKB08+UFwKlDth?=
 =?us-ascii?Q?aGCezVVr4X/RIINktmbs+p8DQ3ldBjDiXz1sxI4cJFp3e/RI9xmxNkVkTM1l?=
 =?us-ascii?Q?K5u2ze1bSHKgsPOcgZcmRsSr7jTEZx1gaEORGGpijeTy0BcHSFkX1IdJRpxd?=
 =?us-ascii?Q?ChyG1J/os5SVSreFoVkJH0TdwzB3SLBmfF9kPyIDoOKtOgJ+MP3+Fs46Z/aC?=
 =?us-ascii?Q?AobYaj9DEH+A+T0Ouun12mVPwg5N0bR7x2pKZiBoO2r7imqOjsLxd7LfSec+?=
 =?us-ascii?Q?5Y6+num9GQyfOXDbgyiVFEz0viti5qHBwJKFTRKvyzBh08O/10hbxvH4BXUb?=
 =?us-ascii?Q?ZfhFrx3udwGteQRBtxCK/ORakW6JZkkNL2HkBqKJcnq0kwwZfM2mN0iludY9?=
 =?us-ascii?Q?kGZGGInFvqjJT/blH84ccC1TlaZhbzGZkPIG5e+TUCGViSXTFP3GoH5YQam8?=
 =?us-ascii?Q?q8T288GL6QTWLMGqmMYbomChsxyFr1GuEwrVCZScbdJy1mMSIbr6uz5xd63Y?=
 =?us-ascii?Q?JxHeDK5ZmrmNBYe/VuICprodCCsVRXiqGXhqJW8sJFHUNJhPlMJ4QH3p2ipw?=
 =?us-ascii?Q?CWsQ9eAB2cS5pfexpTKtnaCy0Nosl2HWCWzg/DpaVuWznahLgwsr2wywcCPH?=
 =?us-ascii?Q?nJXpfyvYyeb47W1AO3sM7KnV/o8tRXBG3fsTTYpJxHHpoqkD0eaQvogi9TJh?=
 =?us-ascii?Q?c6i+dYQrAhQh2lxcKGz9rT+A+QNrpf0YhSbpjd6udQ6G9QOOedtNZlvwu8Jg?=
 =?us-ascii?Q?Vt5cKHaC/KJKjVu6fuosMdyN9Ql+GwSv/YzuQT1vjH2BbBJhtXq/igQxA2aF?=
 =?us-ascii?Q?FaZ1+OzSUl7Q/XROmbyZAoatDJUrFO2xK5dzJp1Xc52Cu2rX2k2+XRXXtZRF?=
 =?us-ascii?Q?UzcGHQpOFUka1+fnqnUx3dCHcm5x8VDiiEgWVDKgauPXAFtuvbnk1IRsZINw?=
 =?us-ascii?Q?7Dj+fjvKEyyTYvlqalCzmE8RPzubSctkogBPOp/zP+VodlUzXdYDVzwNSr8D?=
 =?us-ascii?Q?jQlMqcQi0v6fCE5S5H4gpIDBTko=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f5ca6c-1dbb-4d19-bc36-08d9af592790
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 14:46:10.3380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wfZ6csPot+ooNnCRwALqQYBBljCK43tiuLoxIvLJNgDUmVTrFpySoALkddSL3WPpFveTi2IBVPX39EYFF3AhNEdi9gVw29khiyFPrO8C94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240082
X-Proofpoint-ORIG-GUID: SIhv8LyzUWSuTCz8uindOnSp40R8C6zJ
X-Proofpoint-GUID: SIhv8LyzUWSuTCz8uindOnSp40R8C6zJ
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

Hello Yang Li,

This is a semi-automatic email about new static checker warnings.

The patch a689e8d1f800: "drm/amd/display: check top_pipe_to_program 
pointer" from Nov 15, 2021, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3064 commit_planes_for_stream()
    error: we previously assumed 'top_pipe_to_program' could be null (see line 2887)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c
  2822  static void commit_planes_for_stream(struct dc *dc,
  2823                  struct dc_surface_update *srf_updates,
  2824                  int surface_count,
  2825                  struct dc_stream_state *stream,
  2826                  struct dc_stream_update *stream_update,
  2827                  enum surface_update_type update_type,
  2828                  struct dc_state *context)
  2829  {
  2830          int i, j;
  2831          struct pipe_ctx *top_pipe_to_program = NULL;

Set to NULL here

  2832          bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
  2833  
  2834  #if defined(CONFIG_DRM_AMD_DC_DCN)
  2835          dc_z10_restore(dc);
  2836  #endif
  2837  
  2838          if (get_seamless_boot_stream_count(context) > 0 && surface_count > 0) {
  2839                  /* Optimize seamless boot flag keeps clocks and watermarks high until
  2840                   * first flip. After first flip, optimization is required to lower
  2841                   * bandwidth. Important to note that it is expected UEFI will
  2842                   * only light up a single display on POST, therefore we only expect
  2843                   * one stream with seamless boot flag set.
  2844                   */
  2845                  if (stream->apply_seamless_boot_optimization) {
  2846                          stream->apply_seamless_boot_optimization = false;
  2847  
  2848                          if (get_seamless_boot_stream_count(context) == 0)
  2849                                  dc->optimized_required = true;
  2850                  }
  2851          }
  2852  
  2853          if (update_type == UPDATE_TYPE_FULL) {
  2854  #if defined(CONFIG_DRM_AMD_DC_DCN)
  2855                  dc_allow_idle_optimizations(dc, false);
  2856  
  2857  #endif
  2858                  if (get_seamless_boot_stream_count(context) == 0)
  2859                          dc->hwss.prepare_bandwidth(dc, context);
  2860  
  2861                  context_clock_trace(dc, context);
  2862          }
  2863  
  2864          for (j = 0; j < dc->res_pool->pipe_count; j++) {
  2865                  struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
  2866  
  2867                  if (!pipe_ctx->top_pipe &&
  2868                          !pipe_ctx->prev_odm_pipe &&
  2869                          pipe_ctx->stream &&
  2870                          pipe_ctx->stream == stream) {
  2871                          top_pipe_to_program = pipe_ctx;
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Set to non-NULL here.

  2872                  }
  2873          }
  2874  
  2875  #ifdef CONFIG_DRM_AMD_DC_DCN
  2876          if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
  2877                  struct pipe_ctx *mpcc_pipe;
  2878                  struct pipe_ctx *odm_pipe;
  2879  
  2880                  for (mpcc_pipe = top_pipe_to_program; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
  2881                          for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
  2882                                  odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
  2883          }
  2884  #endif
  2885  
  2886		if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
  2887			if (top_pipe_to_program &&
                            ^^^^^^^^^^^^^^^^^^^
The patch adds a new NULL check to make clang happy.


  2888				top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
  2889				if (should_use_dmub_lock(stream->link)) {
  2890					union dmub_hw_lock_flags hw_locks = { 0 };
  2891					struct dmub_hw_lock_inst_flags inst_flags = { 0 };
  2892	
  2893					hw_locks.bits.lock_dig = 1;
  2894					inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
  2895	
  2896					dmub_hw_lock_mgr_cmd(dc->ctx->dmub_srv,
  2897								true,
  2898								&hw_locks,
  2899								&inst_flags);
  2900				} else
  2901					top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable(
  2902							top_pipe_to_program->stream_res.tg);
  2903			}
  2904	
  2905		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
  2906			dc->hwss.interdependent_update_lock(dc, context, true);
  2907		else
  2908			/* Lock the top pipe while updating plane addrs, since freesync requires
  2909			 *  plane addr update event triggers to be synchronized.
  2910			 *  top_pipe_to_program is expected to never be NULL
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This comment says that "top_pipe_to_program" is expected to never be NULL
but it's unclear if it means just for this else statement or for the
whole function or what?

  2911			 */
  2912			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
  2913	
  2914		// Stream updates
  2915		if (stream_update)
  2916			commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
  2917	
  2918		if (surface_count == 0) {
  2919			/*
  2920			 * In case of turning off screen, no need to program front end a second time.
  2921			 * just return after program blank.
  2922			 */
  2923			if (dc->hwss.apply_ctx_for_surface)
  2924				dc->hwss.apply_ctx_for_surface(dc, stream, 0, context);
  2925			if (dc->hwss.program_front_end_for_ctx)
  2926				dc->hwss.program_front_end_for_ctx(dc, context);
  2927	
  2928			if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
  2929				dc->hwss.interdependent_update_lock(dc, context, false);
  2930			else
  2931				dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
  2932			dc->hwss.post_unlock_program_front_end(dc, context);
  2933			return;
  2934		}
  2935	
  2936		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
  2937			for (i = 0; i < surface_count; i++) {
  2938				struct dc_plane_state *plane_state = srf_updates[i].surface;
  2939				/*set logical flag for lock/unlock use*/
  2940				for (j = 0; j < dc->res_pool->pipe_count; j++) {
  2941					struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
  2942					if (!pipe_ctx->plane_state)
  2943						continue;
  2944					if (should_update_pipe_for_plane(context, pipe_ctx, plane_state))
  2945						continue;
  2946					pipe_ctx->plane_state->triplebuffer_flips = false;
  2947					if (update_type == UPDATE_TYPE_FAST &&
  2948						dc->hwss.program_triplebuffer != NULL &&
  2949						!pipe_ctx->plane_state->flip_immediate && dc->debug.enable_tri_buf) {
  2950							/*triple buffer for VUpdate  only*/
  2951							pipe_ctx->plane_state->triplebuffer_flips = true;
  2952					}
  2953				}
  2954				if (update_type == UPDATE_TYPE_FULL) {
  2955					/* force vsync flip when reconfiguring pipes to prevent underflow */
  2956					plane_state->flip_immediate = false;
  2957				}
  2958			}
  2959		}
  2960	
  2961		// Update Type FULL, Surface updates
  2962		for (j = 0; j < dc->res_pool->pipe_count; j++) {
  2963			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
  2964	
  2965			if (!pipe_ctx->top_pipe &&
  2966				!pipe_ctx->prev_odm_pipe &&
  2967				should_update_pipe_for_stream(context, pipe_ctx, stream)) {
  2968				struct dc_stream_status *stream_status = NULL;
  2969	
  2970				if (!pipe_ctx->plane_state)
  2971					continue;
  2972	
  2973				/* Full fe update*/
  2974				if (update_type == UPDATE_TYPE_FAST)
  2975					continue;
  2976	
  2977				ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
  2978	
  2979				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
  2980					/*turn off triple buffer for full update*/
  2981					dc->hwss.program_triplebuffer(
  2982						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
  2983				}
  2984				stream_status =
  2985					stream_get_status(context, pipe_ctx->stream);
  2986	
  2987				if (dc->hwss.apply_ctx_for_surface)
  2988					dc->hwss.apply_ctx_for_surface(
  2989						dc, pipe_ctx->stream, stream_status->plane_count, context);
  2990			}
  2991		}
  2992		if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
  2993			dc->hwss.program_front_end_for_ctx(dc, context);
  2994	#ifdef CONFIG_DRM_AMD_DC_DCN
  2995			if (dc->debug.validate_dml_output) {
  2996				for (i = 0; i < dc->res_pool->pipe_count; i++) {
  2997					struct pipe_ctx cur_pipe = context->res_ctx.pipe_ctx[i];
  2998					if (cur_pipe.stream == NULL)
  2999						continue;
  3000	
  3001					cur_pipe.plane_res.hubp->funcs->validate_dml_output(
  3002							cur_pipe.plane_res.hubp, dc->ctx,
  3003							&context->res_ctx.pipe_ctx[i].rq_regs,
  3004							&context->res_ctx.pipe_ctx[i].dlg_regs,
  3005							&context->res_ctx.pipe_ctx[i].ttu_regs);
  3006				}
  3007			}
  3008	#endif
  3009		}
  3010	
  3011		// Update Type FAST, Surface updates
  3012		if (update_type == UPDATE_TYPE_FAST) {
  3013			if (dc->hwss.set_flip_control_gsl)
  3014				for (i = 0; i < surface_count; i++) {
  3015					struct dc_plane_state *plane_state = srf_updates[i].surface;
  3016	
  3017					for (j = 0; j < dc->res_pool->pipe_count; j++) {
  3018						struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
  3019	
  3020						if (!should_update_pipe_for_stream(context, pipe_ctx, stream))
  3021							continue;
  3022	
  3023						if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
  3024							continue;
  3025	
  3026						// GSL has to be used for flip immediate
  3027						dc->hwss.set_flip_control_gsl(pipe_ctx,
  3028								pipe_ctx->plane_state->flip_immediate);
  3029					}
  3030				}
  3031	
  3032			/* Perform requested Updates */
  3033			for (i = 0; i < surface_count; i++) {
  3034				struct dc_plane_state *plane_state = srf_updates[i].surface;
  3035	
  3036				for (j = 0; j < dc->res_pool->pipe_count; j++) {
  3037					struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
  3038	
  3039					if (!should_update_pipe_for_stream(context, pipe_ctx, stream))
  3040						continue;
  3041	
  3042					if (!should_update_pipe_for_plane(context, pipe_ctx, plane_state))
  3043						continue;
  3044	
  3045					/*program triple buffer after lock based on flip type*/
  3046					if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
  3047						/*only enable triplebuffer for  fast_update*/
  3048						dc->hwss.program_triplebuffer(
  3049							dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
  3050					}
  3051					if (pipe_ctx->plane_state->update_flags.bits.addr_update)
  3052						dc->hwss.update_plane_addr(dc, pipe_ctx);
  3053				}
  3054			}
  3055	
  3056		}
  3057	
  3058		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock)
  3059			dc->hwss.interdependent_update_lock(dc, context, false);
  3060		else
  3061			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
  3062	
  3063		if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This condition is exactly the same as the one where we added a NULL
check at the start of the function.

  3064			if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

Ideally someone would know if "top_pipe_to_program" can really be NULL
or not.  Adding NULL checks will make the static checkers happy but it
isn't necessarily the correct fix.

  3065				top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
  3066						top_pipe_to_program->stream_res.tg,

regards,
dan carpenter
