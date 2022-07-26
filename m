Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CE5C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B30A8EA0C;
	Tue, 26 Jul 2022 15:19:27 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319218E9F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:19:26 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEES8m030562;
 Tue, 26 Jul 2022 15:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=wfDwpgO+Dwp3tmwRdcb9KrskfdoDeBeKDtzvWJ5I41Y=;
 b=vezptnhE6s0pne0fXSgSw6Djai6RSj9J5EG1Z4tGUih6jBfmELhMnYFyhxkJ0XC3B1Sw
 jPqbvP4mrJjRhDZdYEyvmZSDXij8dh53TkOrzw1pwmF8ILKJqSGz1vX2JXJ4JSLrlt6k
 Qanj5O9MT+VrFB0DG7BtRvsoCFWNFpd1m+FtTlnafGGHGSiKxS3cP4lWjgLjvXhJyT8d
 2Jzft7/rNHHXvgWC+qNu0RVB+mG5JDpzZsvgooQBEoMoxCHnCJFY8ptLTwd8sFnMQDt/
 1IuhI062FJqwO03uLj6h2alHjFUBSQ+DgD7oUjgjleQJZa87FxJqXD6hld3aVNjIrlC4 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hspw42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:19:24 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QFDsLH034538; Tue, 26 Jul 2022 15:19:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh632xy0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3hz3W1sfwyI2Rgs7RbSe197iG1FhRUdnjjAnBNe+1+jKRywN/UW3AYSBQLcveI05K0dmfiaKbY3UuKZIOkGF8WXmSqSsEUgIh96qoRXSbQz2JsjPP1j3u2I0GM9zHh4+xHZ5zvdzcgDGON+DErUyuh7GdRAfM4eHCbYW9QTQg6kyc9Djr7kH84+20PDp8w+6/aGNe2Hx7y5c12mvLW8V0bck7+tgCMxMUfNpCjt4m2agYecB5S5k5suQooU2fFZ/MPtQaYFYxlOl/+8A3E/PRJ2S82XoOGBcoFNTFMUI7K80v/Tc8N6e3SUigwxUkFGn5GRXicT9jQS+oflcIDOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfDwpgO+Dwp3tmwRdcb9KrskfdoDeBeKDtzvWJ5I41Y=;
 b=g9BtYVMsUlnwZxl99chDHZIhY+pO6Il6UQwNhUg2l8YIC0G9cYzAeG5f9OzR55zs2A/8TjPbonHssR/ZuB0f5okAjVgPM9+tMTeicmKVYoyjLD3xm7vxEDkyxFvnyLfkmrLZKe/1TBqLgQ7m3u3k5+XinUWtedCS+6UL3HPVTdTJSO88nhdpq13ybubTi5XFDnSIxnEUCOg2oWyUy+IbNpyw+e7jAlkfYMPWqc5aoCLosia4LKQWJKjUl5mKfPiJRvuBNVUoxtDyFvPIN1l+bYX0skQg9hnpy39zQvNhmZt14JrbihntDszELxj/3nd0TWWN3IS4Fo0ET3UaD0X66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfDwpgO+Dwp3tmwRdcb9KrskfdoDeBeKDtzvWJ5I41Y=;
 b=Yz6PfiSKNz6E80cDfJ5qqd4gPN3xmwHKkQBSaiLntYHEJIE+4w/cz4HqJMR39nzjZ2dNKLB0wDGMnVZw1JLuHUlmyeJLJf2E8AGQqEtRurX0e2unyF/p0Dh+th0LPqot2rETA1OqH2O3EfBs5EroXfp7v3DQc8lw3vg9uQOuZKI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3505.namprd10.prod.outlook.com
 (2603:10b6:408:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 15:19:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:19:20 +0000
Date: Tue, 26 Jul 2022 18:19:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Roman.Li@amd.com
Subject: [bug report] drm/amd/display: Add dcn3.01 support to DC (v2)
Message-ID: <YuAF72UERzrbibab@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0110.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c7293f4-73b6-4dfb-858b-08da6f1a36ee
X-MS-TrafficTypeDiagnostic: BN8PR10MB3505:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJLfgtBXZeETbofVcveKshPSSbS8RvuxHCghaYG2YVZ8jmPdSukXIocJVGZcHegD9NUElMN7GHcEZnI3rtkO7UwQbo37fA/nK4QO4EaHWaGF2HaTmblemi1tSLauarCCacptQjH/x5fKxfyAPg+1DeMwSWpjLJCPDnlS1YRJpUe4ytKzjZ/fVZgKRY0isZviuuU73Fopvj20Ps3FQR3O9aVzKYYkrIvysvzzajlIquCXEaOT60sEkxFMeT3Ch5dI/c+4Er98jl7GdBVcxhGxI43FaYvvWxsuVgXE+QwbS6SlebfYHtnVmckoD/w4A/EXJ7EsqykD+jkCG6FSK9dlTxFChFtq0XoJKeiaxbYRbRIINebuTvfbo5jsojSWJRsgDzblfFmJpd5TRtMBFWus8WRP5k58o5uYbTnAdAGpf4A3yuZYuyLr87xQq6Mdzuyv2aI9BguOUs3whQuYHVDmBi4OW2nM8JhGDKV2PSc6fCQnP8EIFSwaM+HeVIGkma9casTf+T6QQYsctXl2IccnFF56GTEpA1VA9IJLvwZTPZwJ2Hq0bofWAP0XX3s8KmPl4D4mSWYuCEP0ZYMhf5vmWxgSRY5wt0WqcoukCJkVCxbSK8/ufU/pHXqQEqncJyyASgklVdbSr+k8mjOqmsrqefDVUYZJGSb9295gBn1VF9S1k7iXxi8/+JlHvzTTZKg12+m7XN6fWiY8EfYwVX6/HFXZdyZhFGPOFkzN+Ydr97Q6z1eYlixLx/5Df3SuxglxzFwJp1v9mzURp2IbT/ydiy/f8KjfhrYlQKSAmgD9rt5nNwThOINEt3NwWz5yOjtW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(6486002)(38350700002)(478600001)(38100700002)(8676002)(66946007)(5660300002)(66476007)(66556008)(8936002)(83380400001)(4326008)(52116002)(6512007)(26005)(6506007)(9686003)(186003)(4744005)(41300700001)(44832011)(6666004)(6916009)(2906002)(316002)(86362001)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DFyxzv+FiozOH8FHNFvh6n/AYUkKDtMU2wgFx850/cLnyqDDJmred9KRjuU?=
 =?us-ascii?Q?FAKQMFKTUXL14MlA/MUg/T87PakdwR8L5AkpGpBBOsdM2zC/FenTB1Emdh0k?=
 =?us-ascii?Q?hIaUDZ1ElZNJPyagDT9IUk/m1ZbzSOcmBNiBhVgbf7iND1jtjmzwl8SE//1W?=
 =?us-ascii?Q?LtEHlDLIn8KRiPLe7F4xroBIt+u5egJZDGO7FfkzGkYfoISmfLk9c8yHMkPZ?=
 =?us-ascii?Q?Bt4BoIOqTyrLvx/I6jptw9joLy1lpB/WV3gyLUbMjLRO9Aq3unei1NVRAFJd?=
 =?us-ascii?Q?4Jadd2fNr1eQ8xXsrMLVBTUU8BB5ATFE3dD48kSkBdm5IIanFYqHGBd4g+RL?=
 =?us-ascii?Q?Q8uTWeTdWCvVEk5oeC93ZXeLxgfsHCuFJ0wIR4O7SQPzGutYpDueCuJKT1Oo?=
 =?us-ascii?Q?RL1iAFLyzFhIyLQpmh1jCqZtoSiX/mxTMlfKQ7OHH4DOQDWIW/G/OfMsjS3p?=
 =?us-ascii?Q?r1LUlHdXHyqXxtw4ipBr/JJZxkjFqzyVtANtF3ofFHBcJvI36DPtrJ+060DD?=
 =?us-ascii?Q?vwr/t55Qdf5lGcYCJpnAKlzImUolY4PO8lJXcbZWGTEoluFjLnvi9VI+leFg?=
 =?us-ascii?Q?3P4sk8k11Cm6DqS0nzQpePx95K/cEc1mPncdkgaT6UlzzL4AQQqxJUEZCf/J?=
 =?us-ascii?Q?vB/sm0Gl8LxMKjylV9zrZrQPtxC5dv2KmcjHPFUBHcWvZ1tcXJ04n2U33GpN?=
 =?us-ascii?Q?sxgb8RrfJKhWEot2gO7QEuA9y/bf1BTJdPCa4EAU64ldgHXrklA75/gmTDmO?=
 =?us-ascii?Q?j4nUrCxhOiPYgYoSnvLE7zdTx9fphseemkXXYLFjwUH1jt65JvRq+37bI6nP?=
 =?us-ascii?Q?Yc7j+n2hi2YO85HVRR/pJX1seCFEtXKWkqDd16KqHUDaHYcPl45H5y65rf4p?=
 =?us-ascii?Q?vRhS3f5ASP9rrwjAxqfU6Neyu48K1PY96vkBLirnPt7NTP1Pz4VrT9Euhqft?=
 =?us-ascii?Q?TWKhST1HUDGUQo/GQWb8+l15tav6PujBENr9RZs6Z1+46yKaqEQ7DDNxjevp?=
 =?us-ascii?Q?bOBH0wWXiasMbhn6bMTeRi730tVJfeGCsTx4Xw/zdju8WvzwiNos2UE996n3?=
 =?us-ascii?Q?w/7eMHfbYGnr0WMTitHkX7q/H6itbM+YsvTFHMFpFdwkIEAXxC3n93uXpLyA?=
 =?us-ascii?Q?2l0VznFcQR+y7OOjgoerpxEM/bodmDMzqfAb6oVSDKgGTAGfaqLJDgzSF6j3?=
 =?us-ascii?Q?yiBUWU2eU1pvnnjWHfrCBVPQNO0m0s4Eis8x2DcJcY5s1uulRSZf5Y6qnush?=
 =?us-ascii?Q?S0ZQIkiGS2tSyqGpEzZPZpW+2s5ZcYL3VFolaFcHKFTsQSw2kcbDLS11W1jJ?=
 =?us-ascii?Q?+M1co6RNRoUVK9s2/333f54Rbhgy7zbg3Gjs4XRR5JTxDyoueU2NyL4Sg0pD?=
 =?us-ascii?Q?83x4BQEYPzjlI11d6alftycsazOSWHwPCmizE8vFIF/9rR/P/p2cvoL+rTlD?=
 =?us-ascii?Q?Xhdx68eXhfDPdzsnSL4wtAFy2SR5W4Iu703MCsDhx1Tyb6gN/T0b+CPgSr1g?=
 =?us-ascii?Q?vFaJFAZfR9r3RZfmKIrZgr8hF2JFrBRRoIaLMul0nG565msca1T38wW2ctXJ?=
 =?us-ascii?Q?yCKzgmbdIulUHIi/de6w3nRoujDWWyFoed4UFZ4GpXbdigmIvah7hCmyz/tS?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7293f4-73b6-4dfb-858b-08da6f1a36ee
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:19:20.9030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YojJ6FuKh4BYg1nzenEgUL4bYoDv4URVZP14C0Hx8WdEIV9rQWyZNSvBB2SB0ozQWsmjvMlVRA68WWz92r2fTskoJ+M0nfP5WmHQcltkprI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=772 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-ORIG-GUID: YA6rwpXTp0uYixoIB6t7v3LU9RI-9zTE
X-Proofpoint-GUID: YA6rwpXTp0uYixoIB6t7v3LU9RI-9zTE
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

[ It's not clear to me why Smatch is complaining about 2 year old code
  but that seems like the buggy commit? ]

Hello Roman Li,

The patch 3a83e4e64bb1: "drm/amd/display: Add dcn3.01 support to DC
(v2)" from Sep 29, 2020, leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:539 find_dcfclk_for_voltage()
	error: buffer overflow 'clock_table->DcfClocks' 7 <= 7

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c
    532 static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_table,
    533                 unsigned int voltage)
    534 {
    535         int i;
    536 
    537         for (i = 0; i < VG_NUM_SOC_VOLTAGE_LEVELS; i++) {
    538                 if (clock_table->SocVoltage[i] == voltage)
--> 539                         return clock_table->DcfClocks[i];
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^
The ->SocVoltage[] array has 8 elements but the ->DcfClocks[] array
only has 7 and the mismatch leads to an out of bounds.

    540         }
    541 
    542         ASSERT(0);
    543         return 0;
    544 }

regards,
dan carpenter
