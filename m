Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3E2C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07CB91ADA;
	Tue, 26 Jul 2022 15:53:13 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BFE91AB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:53:11 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFnPdB006246
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=KSkSF5ZF7DAac9dInr/dRUyXviec9m9h2f/n+IOK9M4=;
 b=EeTPJKcndCyGxAWrqkp2hMDbeRdMbudAA9nxVZwELjiettHFmFCDo69G3cQ7gU+4WTGf
 CjJcVUk862WYP6PvjntrgUqlOduTI3/NawME3cJNnNT5CaQhMYP50gQIawQFisE0Jh4r
 2BSBBOMOi0xTe5wU+Bf5KeZ/4YVASSBwuNdK2CT6nJthoT6M3ntzAO9smo71bVeATSc2
 pYQ/oup6kegaAobtSTVjxcOx+IaTRgnjo2py46Bn+j/4VqRnFmkQoth6i/AwvyppY09S
 gcYwrUmre9OlZ5S2fPJ3zkj0dWjxR2HGHQdqBBd24EFLbD8K+jUnKvIvZUpLchXiMh1d CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940pscf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:53:10 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QE8oUP034537
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:53:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh6330dyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMXDKohVQYv55K6MJxRHnHhROn3+3KNnBhQIVDHdTjb+qqI5xPVIrq+e/hJjkAlHYnKWRTz6m9XjIRma5QeiBZOL7lbraBHnZow/JiZbh+gHHnz+gvbByJ1lDOh2Y9Wnf+mcjb2+BzTnbvyd+rcpAIrbBcdgNfU8YkTSlrbNcZM4/ReNIEijCbTvdJmcB5wgLMh2Uh5poMd4UF0+qFe1wdj7ZClK5V5ZTSrzf2HLDvu/Er5R4XS1Xrfal5FeXE7Xf4PnvJg9qxs0YSQucSExu+vys/OjYKWgMuhBcQEp2YC92QQqUj7dLpR/9iYo8yY0+cr6EZaTD+YKSJMOKgiKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSkSF5ZF7DAac9dInr/dRUyXviec9m9h2f/n+IOK9M4=;
 b=AFd6lYDDPLMiAkp7yZtPUdxAGv8h2gzmuApx7JQGE+zmPVhqEPJA8Vw8DyQiKxiKIy58bidlK+NqErolo4oofW0ar26mPUCZMUX3RoziPgTZvTf1nMUx5pbWlXxvB7ImQkThWALpozTYn3+Urp/EYi8CzEeUFzdGA7nTyU9hwtXKeDYseQjez2OANNH2uWE3HB01Dw9B4h+huZOXpoHVOEESUEPFXjKraot9PfQuOVzAtoqnPSwz3LbvxyBTk93vVmuUGsP7/EXs4VndUc8IWSHikdROF6nYNnkt/UzPg9L+D6shePFRUQqAZhCbPty6ootd9MuVBu7x8ZpDb4MJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSkSF5ZF7DAac9dInr/dRUyXviec9m9h2f/n+IOK9M4=;
 b=p3NjmEa2eQo739y9scJusdjEDVenDntqMLgJABWhFKcY+OIj1k3yzUDRBgs1SlkzececmBAoszvIsr8e7keTbzhv/ssEpeTJvhDcx32RORDH+vteMX4zm7wLW/pvusFlF8ZXg3jD6TuThPWb2o6NS88lsYJb42zFjMJkaWwRS0g=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4481.namprd10.prod.outlook.com
 (2603:10b6:303:9e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 15:53:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:53:01 +0000
Date: Tue, 26 Jul 2022 18:52:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu: misc ugliness and inconsistency
Message-ID: <YuAN1aR9jGmnR/wk@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05f29494-db86-479d-054e-08da6f1eeb2b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4481:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRWEIe0RLK7KI4EsfKjpIjsLHBRFAN4CiaC4Ur99WbzVBdmfjNNIXHYAtLNDwaYrJRJb2yzZZBsmdKZqvMch0GIKpDSbY3do543ZlOZmYjWh8g6Ceb+ZZ5DBdroiX1SzZKTPbIclllwU2bWtiRLU44NzlYiZ/cjXxGRgLkrPQEtcvtr9iIOy5NgbipOrznEK2zxtk3nE/uBTG9iACcORNT9XPiPdLN/zjMXvxtMCc5vBPegwBIIQ8R9mLC64ud/PY1OWL9FxcKwDG8Q2d7rLncF8trsYyLEM8zoKpb3IoLzMsw0zM0WsTUEuD9RRPHqhI4k5uCxXCuG0WkNIgdNIYcrhJvsT8EGGgA8adhA40vo9szNNjY5efPbFIWf7fGRw+3SG7GtcvYtuKW2ULE26vbHDfshKjyOetJqiyYGirDFlTjdXbfZH/vJJxSRhk4PJelqYtnYfsBbSpXpZFgRU1TGqpzPdzL9urgQ+F25gUoyWkfGO/4+yf2c8W+Ne+jaJLQYPtfeXM4tuu+W722yk36/jL3kBBWCz3QohunR4SvZcwaJDly5czBDvM1oahF0CD163dq7Vj1QmlJABL0VYmJlBXqk6EEPB72PIncM/pcMG22hYEvBE/C5a/cupNy1neE8X/E/yEQQ9kaa7mAu9kA+Nu/IxM1R6xR7Pi6cNXCX499zbv4sOsWbA6XBAQ7cF8Bop4A0IJTqL1EktSnrlZU1bhaDz1NAUF6OSnQOsLD8ri8mOGxE5qCu2rWxNmF+qeJZu6vbYeUgfI5yq7Cife8wJiY6YRhX3QT1GMZjGzsiHHMQlOxY7reKy14cRlm7P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(346002)(376002)(396003)(366004)(39860400002)(136003)(86362001)(6512007)(6506007)(52116002)(478600001)(9686003)(186003)(26005)(41300700001)(6666004)(316002)(83380400001)(6916009)(66476007)(33716001)(66556008)(66946007)(8676002)(38100700002)(44832011)(6486002)(38350700002)(8936002)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2neGdDiRAmMOJuXV5mm9H39JUCiaf0uRSQSbhD6AMLkkH2GH1NMHEAMhhHy?=
 =?us-ascii?Q?R1f91Iurkw5CpBaQpVrUW/SmDoYbPCgde7SfPbbYwP4QgVhDm8a0/0UcpdBO?=
 =?us-ascii?Q?4rhoWWQxTupr1nwcb17TwoIsn53bDewaWXeCqEkHuI/9CCjxzMo/TqZywaB1?=
 =?us-ascii?Q?i38KYlptlrKTzb1n0yxIx6ZoKGuP8KeTZtXgSfa9rqNID6ONNuT+D1Oamctk?=
 =?us-ascii?Q?I5Xwj4BjeZrSJ5A1v0fZTvdm7QvTfNH7kqQ+CZDe/lFGUPsvIup7RWNR3oDP?=
 =?us-ascii?Q?a9L7Z8yOy6c1oqPFGkZUth/E4l5pc8BNvXYBv9b0TzD1YzyjmmIExqL2hacH?=
 =?us-ascii?Q?Ca8QXfm4kAD6+oFf7IVqmoZNu3Th2Tuk3j6fS7jnelnXeCM7mFEuqRQUAy0A?=
 =?us-ascii?Q?u7kwnwWWZ8DaY3htyBI4cet9SePSYqq5CoojbGzSkhdzaMaFITQfnET9sI3d?=
 =?us-ascii?Q?fsyU4zAAqBO4INd4P3OQQ0nEDBlusV9EFknlsAY6RYj8vh1dkw7zpPgS84Zf?=
 =?us-ascii?Q?D+/h5Bem9Pc05egf2uKO9F/a5oY5zYG1MNXmqCjwFrEoGlX9tBcY6NdgBcjd?=
 =?us-ascii?Q?Tf1BnkiTql/bQC5jfc9NkoL6AnboLtjzUaAK3TQzAWgL5OkDy5lHV7GXD18E?=
 =?us-ascii?Q?KJNSX8lOySGTiu0wkDZqVKmT1pk8fSZ5c7cdEqX4taMqEFpJMhwp/FctgznG?=
 =?us-ascii?Q?9Z/c8725FJkAxCkqM5bvf/zpHonGH1xVNP7j/JuCOXJxE/4qDVDSULhFutaB?=
 =?us-ascii?Q?mKtZSDr8S8JCr5CPYobWhdGGAvsvT0O6eKePxFxsdmnhvnm56yYRaGwfMDI3?=
 =?us-ascii?Q?96r+w/gy0IKzDl5xo69bucKmerRvECeAuKdyNWOuJNTQtgQ2hcY6qh0YsNEz?=
 =?us-ascii?Q?2khHaY0koZRx0gsEaNyzbuAzHcZL8w7CxwIPAqetL0RJhJlGzDENKuSkvxe9?=
 =?us-ascii?Q?BC+yR+Vn4fkTI8dHeILGOFdwukyBGq5ZV8SwHkhpLA0YIFFVRYCk7e0U9h0K?=
 =?us-ascii?Q?5GCFrX6ttF6J/djg538qXmiI12MRgy3JKoFDErzdpnEi8sO4TQ1+/Xzu+SCT?=
 =?us-ascii?Q?FYpAd6frS1jkK/3+nYgUnSRngW7tl0fzN+5StOUNNaiCVXX6JrcNKfoZwjJH?=
 =?us-ascii?Q?qsYoSQoARqrf0g787eM4LRZKBOiwlA/QwoCc9lXV/LUMjvSAsShTOQHaIU15?=
 =?us-ascii?Q?C5ax6C6281Ez52IRFujSy41hzO+ybAiRJuMOCxDsjuvb+aYaEg3EfQbd/ipy?=
 =?us-ascii?Q?rXPv8KfEawRXwIZnIsLrjOoY5Eja5RTrJROD6HOt3RM93lZay0OrbfARh9o7?=
 =?us-ascii?Q?Jhp2uogH4ojCxGUhwYHLkw7kR5Fua6/PK7uNARSMlmDuN1tpdA9+vacbCjq1?=
 =?us-ascii?Q?yrgwHLSzGgIdH8zB/r5nhfD9QKrgF0Phe5rgWBMQr88A1EiH7DpczGChXG2P?=
 =?us-ascii?Q?VkjsT+lOQhKVxpmf+DwtwKRGbMDBXfjPwky+WQ+6mds8StP9y8cQmsiaFfyD?=
 =?us-ascii?Q?kpGCHZ6qTjv3cK8GgQFQ23yQ+rpH7OMDmX2o92k1GbddKfCuWwxeXU7KYkOL?=
 =?us-ascii?Q?T8rfNlr/lFrIKaLdbnZ8kdNlXyVzXz/OT50K2pdAshhgU1LJc0jA9WsZdGn1?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f29494-db86-479d-054e-08da6f1eeb2b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:53:01.4482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG6dEL3Uj9yUqrHiTUWUlkrYYd1N9nccUk4e8enx6IEON874gW6D4DY2R0V1AY5fJX45Xddos/QwlOBZ4+6RGxu4MQT2mEI8NTQx538XVkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=453 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260061
X-Proofpoint-GUID: spP5TC_tjymXEKbImLs2PA11O9fKo8yU
X-Proofpoint-ORIG-GUID: spP5TC_tjymXEKbImLs2PA11O9fKo8yU
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi AMD devs,

I guess there was a big merge in linux-next the other day?  Anyway, it
generated a lot of Smatch warnings.  I reported some of them but there
is just a lot so I'm mass reporting these.

Inconsistent NULL checking can be harmless.  Part of the function
assumes that the pointer can be NULL and part assumes that it cannot.
It does not make sense, but it is often harmless and the correct
response is just to remove the NULL check.

The other class of reports is inconsistent indenting.  There were two
bugs but I already fixed one and reported the other so these should be
harmless.

regards,
dan carpenter

Inconsistent NULL checks:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1271 handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1230)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:1017 dcn201_acquire_idle_pipe_for_layer() error: we previously assumed 'head_pipe' could be null (see line 1011)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:222 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 213)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:765 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 749)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:767 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 749)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:284 dcn31_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 117)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:896 dcn32_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 738)
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:777 subvp_drr_schedulable() error: we previously assumed 'pipe->stream' could be null (see line 768)
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:868 subvp_vblank_schedulable() error: we previously assumed 'subvp_pipe' could be null (see line 860)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:250 dcn201_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 227)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:782 dcn20_enable_stream_timing() warn: variable dereferenced before check 'pipe_ctx->stream_res.tg' (see line 698)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_hwseq.c:157 dcn31_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 147)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:765 dcn32_init_hw() warn: variable dereferenced before check 'res_pool->dccg' (see line 742)

Bad indenting:

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:107 dcn201_update_clocks() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c:716 dcn314_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:655 dcn315_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:683 dcn316_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c:726 dcn31_clk_mgr_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2152 dcn10_align_pixel_clocks() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:854 dcn301_hubbub_create() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:618 dcn32_set_output_transfer_func() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_hwseq.c:910 dcn32_init_hw() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:306 mpc32_get_shaper_current() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1979 dcn32_resource_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:2319 dcn32_resource_construct() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.c:205 dcn303_fpu_update_bw_bounding_box() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn303/dcn303_fpu.c:355 dcn303_fpu_init_soc_bounding_box() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:185 optc3_fpu_set_vrr_m_const() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:355 dcn30_fpu_set_mcif_arb_params() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:384 dcn30_fpu_calculate_wm_and_dlg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/dcn30_fpu.c:390 dcn30_fpu_calculate_wm_and_dlg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1110 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1113 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:1341 CalculatePrefetchSchedule() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1099 dml_rq_dlg_get_dlg_params() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn321/dcn321_fpu.c:516 dcn321_update_bw_bounding_box_fpu() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2069 dcn32_update_bw_bounding_box_fpu() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:683 DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:220 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:224 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:235 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:240 dml32_rq_dlg_get_dlg_reg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:51 dml32_rq_dlg_get_rq_reg() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_rq_dlg_calc_32.c:68 dml32_rq_dlg_get_rq_reg() warn: inconsistent indenting

