Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CFDC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A9E10F77F;
	Tue, 26 Jul 2022 15:25:49 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6878D10E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:25:46 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEEa39017265;
 Tue, 26 Jul 2022 15:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=rajCg4HTovz414xGXBkH9SMp7lwrbL1ZVTtbaVFZ0h4=;
 b=TCpquKVPlTY7mtfqTfszLbhCHLeQjYToQ9MXtreWko79pwZKPl1jILQaWxFHZQldzjcd
 s5I2H7Tk1TLSnOmcpTDxebSSoiJcdWx7j10YzEuWWagyln9wG4GNzymeMiuw8h5yYsWv
 McFgm2nhCTr3w6dnz8Qq38RZ/BVNwsj8wy8d/LWGejmDSkmvN5FW2SY5ZvHh6FhQ9xBt
 wWail4PSPVjNXenSYmtppFVD/1O1XIEFuU/5gbhk3j+g30Gs+U/KZvXQeqFbQ2qsj4RA
 3cADCQW5mUzrQGuZA5Ns2FMyjh2I4ilc6SBTbzPQm+fIWWYMJhGzg0ZVXVCKgdFr4zqS 8Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gerew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:25:44 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QE6dAY032993; Tue, 26 Jul 2022 15:25:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh64rycsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W70rvzLp4fozMzGJQhNRdKqjhewMVgWS+e0GgEBufliuJTtAFJfhhb2DtBP3p1rgTGyPs0QuJZvdW39Dic7Z48TOya0th71BxLBBJmJL/3nuYDdQefL7C7XpFulf/qAzKrq0FnOH9TUwvtHrpsAH3diGhza+ifHvn8sBp6/j54Y0sjKTKBHIZ+Ffd5L+//Jn7Mw4R2wjD4ZA+6U1a0/5W7MvEGcIuzXhucNfCVQxJbFT4v6IFDb/x0oepmM0PE4Q98JmybKjQmJrgpECsqOynbS7MfOSqR/JxYFSnBjbcMczwYRrWdTN//+ijPI5FfAVAc3kwm51y+fMuqIDACiL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rajCg4HTovz414xGXBkH9SMp7lwrbL1ZVTtbaVFZ0h4=;
 b=lQpulgQuZvBVtyFgLIasSiA62H4WGEVnIxXfKDfnU9k+PZ+gGDcel0WRxWb5CQn5BiZNmQr2V/n+QB5cUY4DXYG6h07uNUqPiW/B1O7/FxrROI+0qoqoloCVAyrK9pDv8N7t87Qi53qLrBAIGLO/s77xV+TWy3gjQfkyH9imyO5SmthM1SMWJEuS+z+GV0TkZwwmCFQzLy0G8JqjGE+UAC0cALi4mSfyhOZHNR2iZaBd6hPycU2RRp1/yjw6q/WmhBDLCWKnx0NqliOuzw/ky7A1H5t3MPgGHk+QvWPqn55lzI4xOYNxEdsEbhweppL91NDG9DyoPfV6ikBMJJqc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rajCg4HTovz414xGXBkH9SMp7lwrbL1ZVTtbaVFZ0h4=;
 b=fePGLldjmagetGb04yqB+oEnpM3EtKEM+j+/HDYbjU7ly8Y681uRgGantrfH5iJkIywbbdNoY9KOGvFxGASeXiKIHxhVDT5gZi0hkaac03dXogOp04eQHFMAT5BJDFqtDBMy6JJfpgMXJPnSEesHchMmtu7NzoYyZ5iTFxAc4cU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3334.namprd10.prod.outlook.com
 (2603:10b6:a03:15b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 15:25:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:25:37 +0000
Date: Tue, 26 Jul 2022 18:25:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: aurabindo.pillai@amd.com
Subject: [bug report] drm/amd/display: DML changes for DCN32/321
Message-ID: <YuAHaOtU4Kyd5ZpN@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0126.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c00ac791-440c-4b16-f9e2-08da6f1b176f
X-MS-TrafficTypeDiagnostic: BYAPR10MB3334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvf15MuNTYJ2R5l+KkP+Tz7h/yxXsbWrBlmJoNBv191xS5kNARt3h/GBkstuS8LLoPoe6ZJXW5p20YkB9NRz409C86j6S+xXRGwm2CtfgShPypIhXeiQS0oCX5+U6U+9UmDXc6ghbAhgf5hRxXyMUUmxDzjhbTHyNb5ysbtFdIGGaRfdAVBMoRvJR8Q6XkF6TrACGzWxdNlUyFy1yRF7QeMlh32mEeZrCsBJOQekBMEgdkJZyJWuOmOGjH429CRJhNKZK6PMFVHSuw7/KMMZJowBgq/VmJrwdNxvo1Daw6cDdt9CktmGJZc89lxC0/+UmF9vGQQWRNfvAQp+bTYtVphTocApxjCGQ3x3lkrYfWI5NHkHcLoqgguM5W9A4JPvfBHpg/ve/U/l6fV56EjKEjCqD72z3B7NdEK+hqQnbf613V68DLKCcq5NDCKPQ+jKnRbrwW2EFEOcQE9abfHtjmjBGYo8yFammb/P+4xjIKozpklyuua6A1OSwtg39i9xgjwRupHWpYzUuVb9Ckraf/uzkaD+ipex8Z5HVXetfgmejIKktoRH51pcQlWX1Djh4FVQPhM9F9qnCPVWH6IOD6qt0zClf+C7YNAAtK2Tjvam3Eb9wlUrq/5IRdMSynUQIcJERuy2DndFS5PkaLVyvROToWldQoAxfUTTI8qtgLjYJd9cgQ7Tw6qob4CQyiUPC9Wmy1qwScmHr3ZigLPeV+Gm/pfwI2jgZ98Yd6lJQKnyS+daTgi+v+2MqX/w4USDK/4hyLNXSFRY9/T8VU19ENOnZydE4/TQ/5OKbRfZHO9IuUK27fa4faN+4Pvrb0Ho
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(39860400002)(376002)(366004)(346002)(396003)(136003)(33716001)(26005)(6486002)(8936002)(9686003)(5660300002)(52116002)(478600001)(186003)(6506007)(83380400001)(44832011)(6666004)(6512007)(38350700002)(41300700001)(2906002)(316002)(6916009)(38100700002)(66946007)(8676002)(86362001)(4326008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8UIeQgfr+GGd69kmpgAaIcLF8LvHM/Bgh37WJ0bACSYeBfosUecQzcOvLzb5?=
 =?us-ascii?Q?ltR5Z35iK4TZ6sw8+IlY534sFRR/lHvwPgUDH/COJTFP4JSRgk9IVpiqwr8Q?=
 =?us-ascii?Q?ewxQT9zIhEIum7RR7jna3BkCmeNVEvhxc6PNMHtgdp/dNXre+KfhlF20C3CV?=
 =?us-ascii?Q?zrNUF/jgIAFZJYsKiqA27ARD2X/Ez4R4uwzwFVBDD4YqE7R8OZAOijyn5oWY?=
 =?us-ascii?Q?tqUtjSm0pQAB2Grq/M7a/AftwzKxxzTMx5XTCbtL45Brg8vR7oFyfKW6xzbN?=
 =?us-ascii?Q?vyQg8vjXNho6+qKmKks5jz4fhfgLkv+X6CvZ8LxzlOeln2EuVTy4Ojpddx+U?=
 =?us-ascii?Q?kDfciWchcjndh1QbVjiKggPXWDLWSAvTloAsjBYEa2HKo8rwP8+DEd25pb1A?=
 =?us-ascii?Q?WFevnedo0QjzFd2P1wBkAVbfd8V4XRDGt2XriyoLVbWbqMEhEMuhqV3ATMQ7?=
 =?us-ascii?Q?0F1Du7InvRP7X1H/xf6Ad/vlZtux78Mq0BAZSep5aWNZaToKV1TGxuDrs04P?=
 =?us-ascii?Q?U4XuBZ1f8zcP/oQWOgDXD9czZSChsVZjyWe2z43u5OR7gAkTaceJxHEyAcnl?=
 =?us-ascii?Q?5p6m2J2ibMsZzlpk6rR2NCh6YH6B9lpZsIzUfBf7kbWACYevUD80bb4nIRon?=
 =?us-ascii?Q?mdX55KBE+jbIBd8Ybg6Hx2dYDFrEmuATTufPFHTAOszLZzYTHhKUU2E+xDKc?=
 =?us-ascii?Q?ExdMk+FY76XdFJJvspSDv4UEKqAFRl+E9IpQsmqY1oK/hcI+p3yU/Fki0S/V?=
 =?us-ascii?Q?/XapCnmBPIDXEVzsS1+f24egSevtr7uBN6SCntYtTvwOVOc2nb9Lz/13sX3p?=
 =?us-ascii?Q?tCaGRscdY1tWMKFCNtTbII60eP7QqLQjmqQ7xOQNyHTR+X+OUf6oQXg3zs0j?=
 =?us-ascii?Q?laGMSx2nXPJgj3YLPAm7lFHWGkbC+QZHxY/l2MKIrsOjVBp9eLY8FINbcIGs?=
 =?us-ascii?Q?1r9eIVXRIKJztpZWxOLNlHlSt3m/MB/4lhWnFxhDVw+PsqIlWUCtQM9wHO9Z?=
 =?us-ascii?Q?uquZSBZyz6A0HNLZ/XtMAxB0kZdkH5zy9Aj33E35SRzeUMctqloObADYlamy?=
 =?us-ascii?Q?rXpaCW+srVIZw/yNvitYs6R5hZVZRn+3C1kgG/mRGkmQk2N80pXJ5iQ1YpCZ?=
 =?us-ascii?Q?d4xxaZD1arcKYSXRqciLKZBYLfPQ4/SVdqDtbZNbMJ3xLQiMNZNZdyHwC5Yz?=
 =?us-ascii?Q?82GzaviQD/ApTXQR0VklLSAlo9ICR60TtmhJr1r+OnOmd0f8blaE0l20U3aV?=
 =?us-ascii?Q?IPaPEiUENXWQzNTkme4qrb1rj9N3O7vKLwQcX7TyTx1dW4S2M3ocEqlGdAfH?=
 =?us-ascii?Q?DgeyEBq14C9BvzUecjHg1UWpOZuXcR+9p5+S1fqZgdjtA5iufSuPLy2e1L9M?=
 =?us-ascii?Q?NMesUOCo7dCcUf0tzAQrHZk9Pq6a/JsnKh97EkN2knHhzk4+4sSUrmG0BN08?=
 =?us-ascii?Q?PM5xVabwwZW7vOm1fpZH5DsAd05TN5HAfu7QwelFpKl/hcE0rcRrxnHQ3ONT?=
 =?us-ascii?Q?NcYb5xDGwedc4Dbx1DG4vsd0ieV5BZw2RAznD2nNWUjRP+dZk4BKRQB/Rdxi?=
 =?us-ascii?Q?6QBP7GTq+xiL5J8zNifxupVyg2N8d1YvKr+aUvWMJm/ywsGUMHrUn8GNFgWo?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00ac791-440c-4b16-f9e2-08da6f1b176f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:25:37.5610 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHQV8FvIjbQ9aNEFxO5yiOWR6MAElIPHSUMgYkW+dlts+4wgjM9oqldHLOUO+pQ0J4BWjRFn+kGpsP22+/GKZ8fTQcsrz3BYevBIS1DK7lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=735 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-GUID: NL3gv44RWEwx23ZxCD_WFNNZ3PIBEjmG
X-Proofpoint-ORIG-GUID: NL3gv44RWEwx23ZxCD_WFNNZ3PIBEjmG
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

Hello Aurabindo Pillai,

The patch dda4fb85e433: "drm/amd/display: DML changes for DCN32/321"
from Feb 21, 2022, leads to the following Smatch static checker
warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1631 dml32_TruncToValidBPP() error: uninitialized symbol 'NonDSCBPP3'.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1644 dml32_TruncToValidBPP() error: uninitialized symbol 'NonDSCBPP3'.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1651 dml32_TruncToValidBPP() warn: ignoring unreachable code.
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:713 dml32_CalculateSwathWidth() warn: inconsistent indenting

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c
    1540 double dml32_TruncToValidBPP(
    1541                 double LinkBitRate,
    1542                 unsigned int Lanes,
    1543                 unsigned int HTotal,
    1544                 unsigned int HActive,
    1545                 double PixelClock,
    1546                 double DesiredBPP,
    1547                 bool DSCEnable,
    1548                 enum output_encoder_class Output,
    1549                 enum output_format_class Format,
    1550                 unsigned int DSCInputBitPerComponent,
    1551                 unsigned int DSCSlices,
    1552                 unsigned int AudioRate,
    1553                 unsigned int AudioLayout,
    1554                 enum odm_combine_mode ODMModeNoDSC,
    1555                 enum odm_combine_mode ODMModeDSC,
    1556                 /* Output */
    1557                 unsigned int *RequiredSlots)
    1558 {
    1559         double    MaxLinkBPP;
    1560         unsigned int   MinDSCBPP;
    1561         double    MaxDSCBPP;
    1562         unsigned int   NonDSCBPP0;
    1563         unsigned int   NonDSCBPP1;
    1564         unsigned int   NonDSCBPP2;
    1565         unsigned int   NonDSCBPP3;
    1566 
    1567         if (Format == dm_420) {
    1568                 NonDSCBPP0 = 12;
    1569                 NonDSCBPP1 = 15;
    1570                 NonDSCBPP2 = 18;
    1571                 MinDSCBPP = 6;
    1572                 MaxDSCBPP = 1.5 * DSCInputBitPerComponent - 1 / 16;
    1573         } else if (Format == dm_444) {
    1574                 NonDSCBPP0 = 18;
    1575                 NonDSCBPP1 = 24;
    1576                 NonDSCBPP2 = 30;
    1577                 NonDSCBPP3 = 36;

NonDSCBPP3 is initialized here but not on other paths.

    1578                 MinDSCBPP = 8;
    1579                 MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16;
    1580         } else {
    1581                 if (Output == dm_hdmi) {
    1582                         NonDSCBPP0 = 24;
    1583                         NonDSCBPP1 = 24;
    1584                         NonDSCBPP2 = 24;
    1585                 } else {
    1586                         NonDSCBPP0 = 16;
    1587                         NonDSCBPP1 = 20;
    1588                         NonDSCBPP2 = 24;
    1589                 }
    1590                 if (Format == dm_n422) {
    1591                         MinDSCBPP = 7;
    1592                         MaxDSCBPP = 2 * DSCInputBitPerComponent - 1.0 / 16.0;
    1593                 } else {
    1594                         MinDSCBPP = 8;
    1595                         MaxDSCBPP = 3 * DSCInputBitPerComponent - 1.0 / 16.0;
    1596                 }
    1597         }
    1598         if (Output == dm_dp2p0) {
    1599                 MaxLinkBPP = LinkBitRate * Lanes / PixelClock * 128 / 132 * 383 / 384 * 65536 / 65540;
    1600         } else if (DSCEnable && Output == dm_dp) {
    1601                 MaxLinkBPP = LinkBitRate / 10 * 8 * Lanes / PixelClock * (1 - 2.4 / 100);
    1602         } else {
    1603                 MaxLinkBPP = LinkBitRate / 10 * 8 * Lanes / PixelClock;
    1604         }
    1605 
    1606         if (DSCEnable) {
    1607                 if (ODMModeDSC == dm_odm_combine_mode_4to1)
    1608                         MaxLinkBPP = dml_min(MaxLinkBPP, 16);
    1609                 else if (ODMModeDSC == dm_odm_combine_mode_2to1)
    1610                         MaxLinkBPP = dml_min(MaxLinkBPP, 32);
    1611                 else if (ODMModeDSC == dm_odm_split_mode_1to2)
    1612                         MaxLinkBPP = 2 * MaxLinkBPP;
    1613         } else {
    1614                 if (ODMModeNoDSC == dm_odm_combine_mode_4to1)
    1615                         MaxLinkBPP = dml_min(MaxLinkBPP, 16);
    1616                 else if (ODMModeNoDSC == dm_odm_combine_mode_2to1)
    1617                         MaxLinkBPP = dml_min(MaxLinkBPP, 32);
    1618                 else if (ODMModeNoDSC == dm_odm_split_mode_1to2)
    1619                         MaxLinkBPP = 2 * MaxLinkBPP;
    1620         }
    1621 
    1622         if (DesiredBPP == 0) {
    1623                 if (DSCEnable) {
    1624                         if (MaxLinkBPP < MinDSCBPP)
    1625                                 return BPP_INVALID;
    1626                         else if (MaxLinkBPP >= MaxDSCBPP)
    1627                                 return MaxDSCBPP;
    1628                         else
    1629                                 return dml_floor(16.0 * MaxLinkBPP, 1.0) / 16.0;
    1630                 } else {
--> 1631                         if (MaxLinkBPP >= NonDSCBPP3)
    1632                                 return NonDSCBPP3;
    1633                         else if (MaxLinkBPP >= NonDSCBPP2)
    1634                                 return NonDSCBPP2;
    1635                         else if (MaxLinkBPP >= NonDSCBPP1)
    1636                                 return NonDSCBPP1;
    1637                         else if (MaxLinkBPP >= NonDSCBPP0)
    1638                                 return 16.0;
    1639                         else
    1640                                 return BPP_INVALID;
    1641                 }
    1642         } else {
    1643                 if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 ||
    1644                                 DesiredBPP == NonDSCBPP0 || DesiredBPP == NonDSCBPP3)) ||
    1645                                 (DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP)))
    1646                         return BPP_INVALID;
    1647                 else
    1648                         return DesiredBPP;
    1649         }
    1650 
    1651         *RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
    1652 
    1653         return BPP_INVALID;
    1654 } // TruncToValidBPP

regards,
dan carpenter
