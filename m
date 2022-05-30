Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BC8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 11:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB3210E568;
	Mon, 30 May 2022 11:42:47 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C377410E567
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 11:42:45 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U8Qlkl029336;
 Mon, 30 May 2022 11:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=3eZpIxDtY91XglPzok2mhvuA7Pi+5+XexcD3LxlBvCU=;
 b=qt87G1YeSCXJHoV71Q67y6BVpVs22ItEnfSug9aaeaJzlyz5y+wF1gVTY9KmGu+YugG9
 xQCQW/+lWGk8I+fnSMNi3Z7X/hoNCCKdG4VVv/FufOkkOJunNBBHDJL2+jSNFfChmpt5
 +6PjYWWU9KD6YUi0KAh2vAZ2f6tsL+tiT1sDxTEYJXvmGYsHVJCqRa+IBwJJfrn2nTEg
 ecpLH70F+xCmOY5/hvxml7pa+k+d0zY/4HPt98PwTgybh4oZX+SetdSi7d0f5W4CV+4T
 xg6LcsfdK8ObNaMY/zaq2ZBmepjrSQZMZO+LonhtaBdYTtF8PYMawgqI31PmraWLSPkb zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc7kjrv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 11:42:42 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24UBeR1n019173; Mon, 30 May 2022 11:42:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3gc8kgd8j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 11:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsmSRrN5QbxyC18AGzaiVCzXrhfl3W/6Hdk3NMr3LkF8A2jLZsfOzlYWg/Eoa2zEqwDFGvirY05Q5bLOq5G6lH8Fj/1djfZ3SQfKdpw+Nkf1LXqkjZ1WjKwxMdsAr0g7NM6C5AS2z7Ge97v9WpWjUSsQt9bUUJ6io5zvvee7w8gX8ceInEG2Cym48R3D5QPtjdHsdZpscanWkQQ57JaO/akj4IMbbrRr9tKWH6ASgGfKVB8J6hzqTHYgc2NceHuIw4Bqs8rGJw6HuXis4PRAXR0vN0lPHCaOTTTOoIQMztR9GFY3wYvaiT9D0/QiEvx+duFDSq57loJO5Ws+vzRmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eZpIxDtY91XglPzok2mhvuA7Pi+5+XexcD3LxlBvCU=;
 b=Z5cJsfgssxHElMhYsJLYpfTnooQVUc2PH+o32y58c6BhQ7r0a74iNhg7cfI5boXf1U9s+D394wb4S2tUp2oNSkW4EptuSQz7hZbPLFEOWIUjzee3I/hdhrhtTFXTP19Iqug9jfZbbbYN5RMoR0Y409PwkkOi4GWwWruWLObdWo4/M5kpLF7JeETTblkIVjoRi4jBWYqQTi/5Z40lXU0E5NMHKrjMl0XCKGaiZ0BHGxD6dajw/iEh8oA/HCn8oW3lqeKs9p7FrNL2Nl2vbOh2GN/IrGYvRcj0EaT6y4Mx9GLCOE/H4tbRUaXNN45wFtarHSBF8xpJ2uJqJbWuiIEQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eZpIxDtY91XglPzok2mhvuA7Pi+5+XexcD3LxlBvCU=;
 b=nwy7liElXtszSGufyMSJqkV23rmOBDpwVD9DmVA4W4d0tg1dI3M84ElegqRvFeAOocMzMjtdl/V5GuW3dliXigqP+LZ3EnCZOO9ARCbCjpFoaMQUj6+Y4TL5DCto6oeih+eGrpAUAoIufmXopXh4NfjWpmZke0jb4eCg0dizGZc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB5871.namprd10.prod.outlook.com
 (2603:10b6:510:149::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 11:42:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 11:42:40 +0000
Date: Mon, 30 May 2022 14:42:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: delete duplicate condition in
 gfx_v11_0_soft_reset()
Message-ID: <YpStoW0tbsYOg5Jx@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8288e7f-d1e7-4523-0d9c-08da4231802a
X-MS-TrafficTypeDiagnostic: PH0PR10MB5871:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB587112865C57873B01EDC50D8EDD9@PH0PR10MB5871.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uuo5wJk2O9nZWX6g+Zn2XRCmlvWWVzxI/xaHTYA1BPGlWXxuJQ965JSz4bXCAvcraCCqtpAxGK9PmITG2kGa+5iVR2Ekoe73WQMvbfDqgXDNKZC0ovuR9FW4H9CZXXaOrqjHcVUjqweWLw6VG6Utm3kiRZp2v9eT69qL4jW++DjuOM1ZUcg0ex5E9V/7cWeKYDVtAY+J6cQEnyuBXpilOQtHWg45di9FMAteQGpZMZukXne/XH864LFnY8siz9GzRucOPdJwmKt9KN8h1kGQ1kOn27yAoaytD9Xqt+h3tCpyK/wsjQNZteTPfrnqBeXttpJJSso7CHoCXeXRDbgw+syGi1tDRauUaaz2TqbzoSeckon4Mf/3fWiVjkWd1DR4/aqKeWE4DifygIs0PYeshKEBeJYfkyhbcOafCzGzFNdt/lj3BGTkL4rHFow00jlSmXO+OucORNIFRcbpYJniCeHs5FkiR5G4A6yn9SHAzSB9VZw/BT9Idwua8jaFhEMf2dpKBqfUmIDtuE/DDwSm2cYeewe1/K205GLjOGWMdn3HGFYdqYZmN6J6Rpxadesk/CXMM7iH1jZUGS+8I2/MwMN1ZJOcZThQwmvQ0XO2tx5mYujJAwPIBjlRINiiw6QKS3uOitqlIeQMJgzU7yxqaEQWnHwWBKXijwSGUWVH79wreC+u5bEgx+my5Yi3xAdkW4PPxSy22noLJ2OAg/uASA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(38350700002)(186003)(66476007)(38100700002)(8676002)(66556008)(2906002)(6486002)(508600001)(83380400001)(5660300002)(4326008)(33716001)(44832011)(8936002)(7416002)(66946007)(86362001)(54906003)(52116002)(6666004)(6512007)(9686003)(6506007)(316002)(6916009)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3xCJnuSxk+iJS+564gyhWxFMTTCkVhOxtaMKoNwkbr6++x9eA7fZZCy6zvsj?=
 =?us-ascii?Q?H8mmOSIMzXmR2ZvE4nxyzR2VHLmJ1KY9LezCjPyT0RH15x//RHl8gfSZZtkJ?=
 =?us-ascii?Q?ThSwHefUiz2jisCt3ePga1avtGMZ3I0lj2HrtxsiCEzKeOdkLk3LoJK+ZGnH?=
 =?us-ascii?Q?vHXzsV8rOWXEJMothOMofqy0wYbd3vCVNI5cXNgGWosYsoSoqZaeoAm5DP1d?=
 =?us-ascii?Q?kFUd0QAnypjRc9C8Lrv6ekzJLlJTKBO8S75/VCgyraYptIZEg7eoBVQ+/uhS?=
 =?us-ascii?Q?YS0Venz4xkoLCYkxaR1shcLwE8415YjQw++vjV/AGpPGvJ7NbyjVgDHYCpQ8?=
 =?us-ascii?Q?rIfN0RsNWIh6rmBPiv5xv7QHDjPPBGX0yG7e5RmYxubIW6Ssf4Nxm2HZp9UV?=
 =?us-ascii?Q?cpjcpRn9w6vpQYa+QiCCifcLm+kcO1L3xg4mIJZWikeXQBfWfaxNURGud2i8?=
 =?us-ascii?Q?x14HcgOxxUPbliEn/fx8IUsXI/4r7aQ+AaHn83r7a0Gnza5h5O1JFeHDVA94?=
 =?us-ascii?Q?HufyUh4l6UpPJe+E5yutQkUy31hhKxv+yGk6C7XW/zWE5B3Q1Yvp7+nqbKH1?=
 =?us-ascii?Q?8Sy7JBUeuxY9MaKSrebw9yVmB54l2Ol+ksngDUXpK9NBAuFKSr10BTAOllHB?=
 =?us-ascii?Q?WXuGPIcKvtjXoidUot7X2DmDxq+hduva8whLofmrakGP/yBJcwi0LMVPR1NC?=
 =?us-ascii?Q?9pirwjyla4G+YPTmaaTntc4A1QB6366Ag8HTY6rX3yF71pE/sHtP5lbfsYAU?=
 =?us-ascii?Q?IvyDfQwkgt0N1xDdEydWen80CQDHdCzrS7vcF7FIEOHAqKTc92GJZyudG4M8?=
 =?us-ascii?Q?IFamcf2RhhNo0x9FrCOosDOxJHiPMXYoIVSDBVMFQvwcsbcwsVZJwJin7e8v?=
 =?us-ascii?Q?7BRRrPDLgkEly9Q7eq+EwEAsZqSVG0ERDhZLn1yrwHJGgEdBocShXPttXURS?=
 =?us-ascii?Q?WEnLaqijiPiWiAiYeVCNNUdNr5+Nsys6RswL3AljxJDMAQDZEanAv9ngp3Wz?=
 =?us-ascii?Q?xBwGJGkd/zUecpIK3MalQndh16OSy/23Mnt2xf4Rv8Tq7MNBtOJU+01JofTi?=
 =?us-ascii?Q?yiw5HIgEMq8lMaa0NRXLcUFfbKP8Sf9o3hqFtAZAIBE+aiTObszcHbYUcT0g?=
 =?us-ascii?Q?Gf0Goy570Y/426nTdpGWzDwH7fWkMFjpNcMRYjZyLeBItNVP2yZegac0+NFO?=
 =?us-ascii?Q?jF1WyBeMU2pMJS4d6uMhhpk6tZHxnFGLmg3gKArw2IuyW3AuoNSbfQrdrLMh?=
 =?us-ascii?Q?NMJ5o9+KQrgVzvK5yMdXSqKQF0L2EU4kX/KlIdQTq8UtGq6aPtyeXzHddV1i?=
 =?us-ascii?Q?2OypHv8wb4Kr7+5/YcUm3n2pCHZQ69TmilSInh/uMaGQfME1ruzKY6O+wweL?=
 =?us-ascii?Q?V8SIbSqrE6XrpuCKvuKTbT6Qolg6WAV7p1lNivOpeXclnTdqU58K5NXX8lSw?=
 =?us-ascii?Q?aP5XdyPWeRQiI1ri3aFjcRRZPsnvZBrMbdHKEwDksVcZpLWMBEhJ7dxF01Q7?=
 =?us-ascii?Q?eV6H0EdAKm3RroEfj3MvaFijMWcKrjPrBWVhWBk8dSNlxo4+DsZBIBQcmwD9?=
 =?us-ascii?Q?q2LBIHlnGMYzyvaslH1PPeZsOK8/bQP/Mz/N3S7vR0nT7/dko/JXyIWH9wXj?=
 =?us-ascii?Q?soNBn/3a8a4OEimMYJH7EpUrluNhAvapR1nHkb1PvTITlgx+ONMcftn/NWYE?=
 =?us-ascii?Q?q82ItGqT7uDJHEY3Bezbx9pbm4IMDNwXLO4O/8XRsZ8YcA1lisYme2PC8mwe?=
 =?us-ascii?Q?Bu4axLgn7EQxuHRJ9+6UM/9Wd4FHXZk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8288e7f-d1e7-4523-0d9c-08da4231802a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 11:42:40.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL2vcIwXbiZfOZAiUdr+OoBmiQjwKiHTCVaH4If5NyvOZcAiNRzMpgsr/rWj+WbwXogFneSA30MTtm2mBlnnzR+cCrniLfi7PaZN1yUKDdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5871
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-30_04:2022-05-30,
 2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300061
X-Proofpoint-GUID: CK0qon1-gOGWPPtKGKJhjk82BlLqE6cq
X-Proofpoint-ORIG-GUID: CK0qon1-gOGWPPtKGKJhjk82BlLqE6cq
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Mike Lothian <mike@fireburn.co.uk>, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We know that "grbm_soft_reset" is true because we're already inside an
if (grbm_soft_reset) condition.  No need to test again.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 8c0a3fc7aaa6..4bca63a346b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4780,19 +4780,17 @@ static int gfx_v11_0_soft_reset(void *handle)
 		/* Disable MEC parsing/prefetching */
 		gfx_v11_0_cp_compute_enable(adev, false);
 
-		if (grbm_soft_reset) {
-			tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
-			tmp |= grbm_soft_reset;
-			dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
-			WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
-
-			udelay(50);
-
-			tmp &= ~grbm_soft_reset;
-			WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
-			tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
-		}
+		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~grbm_soft_reset;
+		WREG32_SOC15(GC, 0, regGRBM_SOFT_RESET, tmp);
+		tmp = RREG32_SOC15(GC, 0, regGRBM_SOFT_RESET);
 
 		/* Wait a little for things to settle down */
 		udelay(50);
-- 
2.35.1

