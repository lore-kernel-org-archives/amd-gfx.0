Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6914C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 17:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C9B10FD32;
	Wed, 18 May 2022 17:38:59 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53D4910FCCC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 17:38:57 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IGgwCt001104;
 Wed, 18 May 2022 17:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SFAQY/MAC2dMaza+q0s9dnIKBbVaq4xIaNvjwiDTLd8=;
 b=k1CxIixe1HsteMTKuECqMa0f4F1bWkQrrvlgqGJBhHPSA1TnT4Pvr+7KWbkzjLOVetE7
 xACynCuJtsQrKGxlzWLJ0CUtNLBflNBEYOQ4nEk6S9LUUwKqKa8Isxzbrus7XBwBsAq5
 XR+H8wDqZWulocoX2nTA5j2Znm9QKTV2DiA2jS27F9+H3Uxmh0gf52ySMVTDoVmjGtOW
 nQvFzNOQCggLo9gdpZGXptr7dllEu5SJFc6GU5b7gyF0PEdg2emssveAy/lshHkDTX3F
 /VLqT0A7JQ5QnIZZFrMootsKPsbe/cyeFmrXGCxD8NogKu4uunI4Tn/f2oAy7y9fTk70 Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g241sa2c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 May 2022 17:38:54 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24IHZbZs014093; Wed, 18 May 2022 17:38:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3g22v4874w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 May 2022 17:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQZhYj+Qpr0v/THkHvpYv6z/PoYVvsEsKAGs9dm5+S5y9DrRIfsoh68usLm/rC2bGFyIE/tZmA3e8sWI3rS2EgGj6/Fk/GZkOqjrKiSTxw5prUrYxIHMjT9Qo28zPLtycvWO/kFPEPrHLw6rMqK203mgmIjM122q+tVqRT9kHvV8WgLiNOmEFlXdJWay0ce2gn/O+5wFc5f6EmOJ7j84nkgNe8SXfED87A4OGDmcrQ/cZiv8K6zujVLXHDsN0jactu2R4kIBjjCjcP7fQzGJhmNRLlv7p1qj2p0ncamUhLh9nqbz91KSEEJQ4WiGcxiy0cKLUuuDOE+P1TqmNE9iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFAQY/MAC2dMaza+q0s9dnIKBbVaq4xIaNvjwiDTLd8=;
 b=jQ1hjNIX2LHl0e71wJPosTh9aWOsvx2prb96zw9JX2wYVO2nQlGey5LNymVjFxEuBHSBBcfJ9zUfnSjcD6ie3dST64S4BZw3p8EKDl+QFIHR3zwKupLfJOyTwmkDzDrcWwRBKaJ6qjWrRRIfYGPl3zYekoC7jHepHNPPpJHugFzpOQDlV2GvGdfptcXTS1iR2GQ7jt/USbnknqdEF79vZ0m64E1yuafnu5D3EjdheSYaeU1ZnGiL2bLy3kPs18Tra5950u8gguq6EvZzd28rLbw9VQPTNEpsrLj44Mx4ivQyvg9F2gxZ1fqHGdDLGzReyDJkcIRbfouoUpxWYPl1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFAQY/MAC2dMaza+q0s9dnIKBbVaq4xIaNvjwiDTLd8=;
 b=QSFk02ukfRtlLYV775+rSdyIl/a3gk/sgZAY0iYHTr3QUKYRG4bJSQvc0qRjR1Hv/CVCmgEBKMhMdBMs0pVklgWlGxpDJ7Dn6na9nNOg6o97J7lFGqmzXoYkhPs51+aiqN57OhM8sFGwLbXSDhJEt48Fzv/Vvf01b6NYdiqbqsc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2919.namprd10.prod.outlook.com
 (2603:10b6:a03:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 17:38:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 17:38:50 +0000
Date: Wed, 18 May 2022 20:38:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Evan Quan <evan.quan@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH] drm/amdgpu/pm: smu_v13_0_4: delete duplicate condition
Message-ID: <YoUvHGsEaMtloBXN@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67d9797c-3969-4493-39f5-08da38f544e4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2919:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB291948A643CF485CAB39DB4D8ED19@BYAPR10MB2919.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0VpJNHeH4li9icvP1uvEgQTNZeBlQiIli60DwNCy8JPFTEf/6gKsrGHNw2L3OiqFSRbjEeliaYWY1gYUNNXuvdOARGtX8QWZKT7A8yJi+73XChvH7dRChZMgZPowkVSuRNFdOGc1Na8gIJb9obQiPMvldM3xYUAT9VBHNNWiHXO7w1Z8EwDa5LL3v7pjnqAeEEaaLLwAWYso5I+mI72H92YdZH44HyPLkK3lc6dvKljaYlzHPUzT4gUa3aTYEuUeVHbeBqvpPrMoZPUqp+q9yb0/WO8Gs2DQJ4z21Bydd65zPCMOD9uHXEThX2aIL2+OkSUyJBB7o0c/OpN+rdjhz9ygu4ylPaZ3+zCVQs4bY6yvZbTC3DQPMd5CyQbKZVbjFZjt/e1HE70SY0Cn1gtxqPd1ZeErc5TqB0alEvS7KGicu0MIAZpd5LD5Nweg3lmMJCm8Cndxza0iZC2kyQYQqKowCdJWPjupfIREdVJkLT4DPiFBjuEssg1Z3jgokRxTVaj805bcCfGK54mbXj0WY74wxxpGM5On17Oc/N8Uh+K0gdDVa3p+2obctl/aLXsD4DbkVbq7E7DcICU2Dm+Qy1Sz0hPFVXERmvLZtT0smigT2jwi4mGWWqr51gFhuaYn6cvfhK2OlJHZRIzu0xHRS059MBTyTY8bIITwulCBzs+IEUUKLp6doTRQYhx1YmW2T0NDluCagzexFYkmP/bmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(6486002)(52116002)(316002)(186003)(6512007)(33716001)(86362001)(8676002)(4326008)(66556008)(66476007)(83380400001)(8936002)(9686003)(6666004)(66946007)(26005)(44832011)(508600001)(6506007)(54906003)(110136005)(38100700002)(38350700002)(2906002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wN4IcZYRMukZhJvPcNqvOln9vcGdccn0p6Nyt33zbJwOGCAalX6Jg3ZaG//S?=
 =?us-ascii?Q?Pokl3jfvrtOUjQd2LY5ce45cPofuq8bQU/ASqMlAspZ3gsy7mzfWnlSahG/t?=
 =?us-ascii?Q?uuDIa7I38i8vokWlIcHbe0woqUvq/vbSDsT0jC13FRuAr5hMfWtEQxVPJdU7?=
 =?us-ascii?Q?dmnktB7giNsjBmlFesLYjiz35SmQxldEpluThaAOZq9InQL8mrETmDB6lQ4E?=
 =?us-ascii?Q?0Mi/EovaTLUAVeUFJIptH1pcZu4BTwkXDgPhnOgP5uY1ERLm7T6dqwmT9vxv?=
 =?us-ascii?Q?sgt47K0WH4NOb9CGLfkneG6yq//oMT1cPn2J3CWAh6MoiMbgbDaPZnB1sTtY?=
 =?us-ascii?Q?oPG3mbm9Fs9YaNVAo490FBSH/wzwRHBvrSlWrZ8f7vBhcfZI2g/ktip9aGWo?=
 =?us-ascii?Q?fUI525pPfKhcUoIvugj1QMYghd8S8LbANYBeoIp3eooKQMG+riH02uZ7PCz0?=
 =?us-ascii?Q?e85Aag9ioEIvEBVs48JyOkfe2JnBmcOxKmsxyzbz6UY6RpnppidClZ+5i4/a?=
 =?us-ascii?Q?NWOHkiQC0dLTcGi+GAg6GgcL8kc4YCm/eNzVUCNk4CQlZYks1B3TyyQrwGra?=
 =?us-ascii?Q?NWM2lILjC9hSdZnsWS4Aa0gJ9bvZZs4mboDcWrGulws3E3fICCffWjhIo62j?=
 =?us-ascii?Q?XlzdHxUyNikBFNQzqi5V2aNKhGyWySuHO7bBEJKYZyvvXJqdNU5NWU9xsaT3?=
 =?us-ascii?Q?RCIKH7OtpOi8Hq3EQ1Cr7odWlxG8AtTsf/iU7gh/D/vNsduq1CG98JkwX+ei?=
 =?us-ascii?Q?p5Iyar/15pvffG2VziPKEzmBWwmOg1mP4R1qz/kudtD8kf/tAcIxA5JbF8No?=
 =?us-ascii?Q?Wj5z7goASEjTGmYSRdhh0x7IkwaLmIkGpLeofYH+Z7fEP30YGrXzHuYrPf0X?=
 =?us-ascii?Q?JS2cFMiM+7j9VDa7NekK4vJkZVgbc/Y6HdNYleYN6DzW/kSB4/jSFCGBNNnV?=
 =?us-ascii?Q?HJwVjqZIIOazOv1N4pyr6AG46kAVKJok9tQis/P8a/hfXczml9MMCAzajAOj?=
 =?us-ascii?Q?BzKRG+qkfxwfJj/TptFCfHGC3W+Fo+oN71lndwgibCV3zIOtFyxkV/JLrhFa?=
 =?us-ascii?Q?oQtnU1pUvA/SM8O4j6tq0Ij3cbsAWJ84QE5A4rdTkIrup/SgrEQIFaYPE6gj?=
 =?us-ascii?Q?lkP/JYYASq+l8OnXn+htnNA7H0yV1xGhARWQcffN42x0Q4EZcRLyy6/u4q7m?=
 =?us-ascii?Q?etHVe1RE57V0d/96PdP7lbQAQP20UIrn8VEV70Uuw5LERKTCDQUGD1MRTg65?=
 =?us-ascii?Q?/xdijmqMDbrlOA9RAuCzDma5o9j1UNW9+4wAPwfSMzv2QER/ip88tcnAs45j?=
 =?us-ascii?Q?uhi9/3gNAN1U6Qt4BWJTDbKlEysT0wPNnQwma7D9x88SJVYcO6iqLyhCam0y?=
 =?us-ascii?Q?JKtvNEsPnk55be+lCGAoLhac7GlHDI7q+IjpmWhsujH8WrPuzg0UmlkWLzo9?=
 =?us-ascii?Q?A/ceiUL4KJI1jZAG2P71BUlFng4aEATY6Z+XsjPYxaUkpAiarExzb2aDT7kZ?=
 =?us-ascii?Q?0SDOqDiyx6AOwUslUYtjah4BEOtC0LN0Zln4iMUBlJGTaQ8AnbCUBrdZitQN?=
 =?us-ascii?Q?jq/3XJx+tYVzjR49CgBGSSEZEf/wxz5LylbvFbKEs12+wZB733IfMGMxAvx7?=
 =?us-ascii?Q?A2bVm4fQ27t0QDl1UG8+zrzQk9M1THG0iz0VG9A9itUR09tpWITytAAcCBOB?=
 =?us-ascii?Q?HgKaWJxxRw5LsK11ZDeARHZvsHdvFonBRFnP9BEr4+TcUOvCOixrLYiPYVEj?=
 =?us-ascii?Q?zk7PWck1FMbes+zeWksWi5I5+KuqZGo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d9797c-3969-4493-39f5-08da38f544e4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:38:50.2328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWeJPENkhrWDDrgJqSkyXnafC0QdYU1Pywrn7yVNnUvGwXp7qelclUmeJttU7/hEVP5Xy3IyFhxAdI0ZRtI4RL7HiGuc7mjpFA4J1eAuaxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2919
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-18_06:2022-05-17,
 2022-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180105
X-Proofpoint-GUID: WHc8i1_0adx78WD7M6UOMn5AG0e5HiTu
X-Proofpoint-ORIG-GUID: WHc8i1_0adx78WD7M6UOMn5AG0e5HiTu
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 Aaron Liu <aaron.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no need to check if "clock_ranges' is non-NULL.  It is checked
already on the line before.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 62 +++++++++----------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 7d6ff141b43f..5a17b51aa0f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -644,42 +644,40 @@ static int smu_v13_0_4_set_watermarks_table(struct smu_context *smu,
 	if (!table || !clock_ranges)
 		return -EINVAL;
 
-	if (clock_ranges) {
-		if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
-			clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
-			return -EINVAL;
-
-		for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
-			table->WatermarkRow[WM_DCFCLK][i].MinClock =
-				clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
-			table->WatermarkRow[WM_DCFCLK][i].MaxClock =
-				clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
-			table->WatermarkRow[WM_DCFCLK][i].MinMclk =
-				clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
-			table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
-				clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
-
-			table->WatermarkRow[WM_DCFCLK][i].WmSetting =
-				clock_ranges->reader_wm_sets[i].wm_inst;
-		}
+	if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
+		clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
+		return -EINVAL;
 
-		for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
-			table->WatermarkRow[WM_SOCCLK][i].MinClock =
-				clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
-			table->WatermarkRow[WM_SOCCLK][i].MaxClock =
-				clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
-			table->WatermarkRow[WM_SOCCLK][i].MinMclk =
-				clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
-			table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
-				clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
-
-			table->WatermarkRow[WM_SOCCLK][i].WmSetting =
-				clock_ranges->writer_wm_sets[i].wm_inst;
-		}
+	for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
+		table->WatermarkRow[WM_DCFCLK][i].MinClock =
+			clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
+		table->WatermarkRow[WM_DCFCLK][i].MaxClock =
+			clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
+		table->WatermarkRow[WM_DCFCLK][i].MinMclk =
+			clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
+		table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
+			clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
+
+		table->WatermarkRow[WM_DCFCLK][i].WmSetting =
+			clock_ranges->reader_wm_sets[i].wm_inst;
+	}
 
-		smu->watermarks_bitmap |= WATERMARKS_EXIST;
+	for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
+		table->WatermarkRow[WM_SOCCLK][i].MinClock =
+			clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
+		table->WatermarkRow[WM_SOCCLK][i].MaxClock =
+			clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
+		table->WatermarkRow[WM_SOCCLK][i].MinMclk =
+			clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
+		table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
+			clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
+
+		table->WatermarkRow[WM_SOCCLK][i].WmSetting =
+			clock_ranges->writer_wm_sets[i].wm_inst;
 	}
 
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
 	/* pass data to smu controller */
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	     !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-- 
2.35.1

