Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1ABC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 08:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8795711B84E;
	Fri, 15 Jul 2022 08:22:07 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61C811B85E
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 08:22:06 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F4uFNf032708;
 Fri, 15 Jul 2022 08:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mVO3E39yBAMY1t3OdQu9hivXxz5A52KU7FtiJ1uABfo=;
 b=aJL8T2GSFrdohdsdC/AMb1NFBODbz/xTpNG41HcR3zyv1jBJaARLoPPEnjLJ2YasA6Gr
 jv5aAw2GeIbNykddEh0eY/lXg2LG210l1kLoMxVGygmFs3qi/4tS3I9w1FG5vauU4q+T
 qcp2ou/inE2uMy8XQ3kum8MHa7IL0A4q4v9DrIIVfEAd5Q7lYgUpgFJw4UM6Ojq+bhIB
 6KNWaxp5Irm0SSlps9SMTxvoBS2BhlrqN8ctHMefLwRbP6ROdRAWm9jRJsHnM3X2qLkj
 aLR832JD2z6sY9zSVzMQodvAnj6y91yHKS+t3Ka71+u0wZIUqQk/XJAs+KQjEAtzotS1 Xw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1er96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Jul 2022 08:22:03 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 26F8Bh2j032712; Fri, 15 Jul 2022 08:22:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3h7046ynmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Jul 2022 08:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYPuh+CIbS78xctupi+GiruE4cegO111N5C1ozOsb/FAzvgIyQ/nQsIGu+ImgYTBg5Qioj6Z/vNp4v1C30y12quH9f/PNx4oXPZ8gakxgUX+3DXjh/py7HHksxKOlbMcPph8ntFX8SDbk46peG8TD+IKria0UKaQ3xG3WWYe8v9Oz3d4E1TRl/+foFeaOnab/4Ne3g6gyTdyGge6RG3gqs43j5u0T1TzCjZJrytVPtNng1kG+i5GJA2EAIF5//6wndWhorXm9h0ri25/1k59FS62kdUcruyg94ACB8P9C/eOdmdGADDiwTWFsFwXjqP5/ChArG8Xa8gvavdqf33qsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVO3E39yBAMY1t3OdQu9hivXxz5A52KU7FtiJ1uABfo=;
 b=GMdIsZZKUtULR14Al2ldQVHvsCJ8219XnX2Zf7Vq1r50Fu/pUENrGJ0GxdkXadcoOZStNekSfydeC45KjeXJMQmvVl2Vh0cIGTTAWFxRO0ujdx+jkujjs9pRCAssXWSvt6OPsMaBtVh7k1cuuZX7jKxsKt2DD5+uOkX0ytyPytjfzkKzQcHK/2ACdBrY9acsAzWpDQP8u0986ZiJkEjT3uZMuB9x9Md0wmPBl+2DGRSG6a4yRGJOEx+gh2IXxHUeJbY699fWPg6FEjWOL4p8yXzLw5g3+bTfzsnfh9SP3w2sYbCp/wfbdGNvfewiblwgj6D1u8kPJzewse0Zk1GbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVO3E39yBAMY1t3OdQu9hivXxz5A52KU7FtiJ1uABfo=;
 b=s56n/etALWuAArJnibADgUKVc53EeGMUaTVYefd/Lt3OFkr25LtojbvSVNtvcgB4q7LQZQajJLfKfZ6Z76vJDATbJoAJQg75sjDVBDdG1hybyHzaU/JoUheB6ClDY7V85zhhMaV5HxM9EN32BY6PItBkZZT3nQrF90Ov9dlQKqM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1593.namprd10.prod.outlook.com
 (2603:10b6:3:e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 08:22:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 08:22:00 +0000
Date: Fri, 15 Jul 2022 11:21:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo.Siqueira@amd.com
Subject: [bug report] drm/amd/display: Add basic infrastructure for enabling
 FAMS
Message-ID: <YtEjn1ZqrLegCgHQ@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef40de28-7451-4de3-50c9-08da663b1707
X-MS-TrafficTypeDiagnostic: DM5PR10MB1593:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0857c9Slt13VVQNE8vYFJfpn6wabv4vJ99k3xG1NYYOXvA0CRnCvt48PZzCdlMe4Xn2rZkc3gWJCnYxtryULko8ZvEVSU6PD1kTkthDTCmiC5SOx3pr4wHqF3JbrhzhGgC1ioy/p+VmBzAmKT8n+PCEIqlcVXr9nivkccYAjs3YFguQjkx8cISveSHmBtZb9DOb+fMvygkql4j0WTW4yNX0YnW2Vl0+kNB5OS9Bk70gt3pbW+3xWqDirBniz2MLrvMKEzBREuB9W9fEE7MMCYTknu2QHoV5BLradV9L+bT6Fph8Jl4g6VWpW+/WQ/ZzTID6AXVzgO7I3IC6Vxqi1X3VJEw8dVe6RWCvm+KQ5RcR1fsKZdmIOeSStEGYZB3f39Z89JtLxvmeHG5oz/ZHUU1/SUYIqHn3FjjcJ11qvfCKbV2lDdcVMzgDJJ3UsChUbRovb16q9IeFG3+PtmwZT7YRfiYHsk1Dizs+2lEFQyFVu4wuwkzWMMsdTbcotDUwMkHpY9d9yVmfrRZ1pG9CbpPWVeAFsgzM7c5TXoftiPfjXZY5FE56GW9iVEmQkj9Ua1OAyC00UOXIM6ak8rZSoF9+P8siV0mK9tfSYtv6qviJfzcoC5+SULJOUlOv1oMwi1rkvOMULIMl0GHU9Pfl2YwkJDqNPU+NRMfbuoZ/uDRvCeY1K7us0lV+eM1DK44woNESTB7qgFq3WsGEns2q+hXI9fnK6F06SrJ3qQJtMzLo/VbvY7g70Tqhm2PSSFIKip7qTjOVwrUMeleSK6Echw8jTH6szCFpprg7xKXzt4paJj9fx1GeEcuNPJ5NG0QAG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(44832011)(186003)(5660300002)(8936002)(66946007)(38350700002)(4326008)(66556008)(316002)(86362001)(8676002)(6512007)(9686003)(4744005)(66476007)(6916009)(6506007)(2906002)(6486002)(38100700002)(33716001)(83380400001)(478600001)(52116002)(41300700001)(6666004)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UZUQcWOt74eiOSSjAEtB4czaVRUfw1Ij6crirO0gBJHTX9a/fPi7WuuEshxt?=
 =?us-ascii?Q?M3r/yBmmkhuEoAxfM0jB1spVsj9Oz8KoXkd5eWT/3e+KMTwZe0tUAoXE0CJM?=
 =?us-ascii?Q?n2kxel9//P1T0zip4PHrqL/2i7z1cKpHeMmmvsp4e1JknqRca5nUOE2f2ftS?=
 =?us-ascii?Q?9rDPPMizJQ+ru5yD2DTIClEOhiBHrxN3oBKnbMtBrWyMGBNCVnxo3ZcxFOLA?=
 =?us-ascii?Q?Ep4kwkpnb4lhn3obz+2atLeLwYCBYDxjZudmxPblc1V8lltTJoKPwIQoLISU?=
 =?us-ascii?Q?9k4eQcVmEdfGRMLwwyzmIwfoHjzPiPfMY6QgBUKzZAPiWihj/SHoMh4phC5P?=
 =?us-ascii?Q?AvDH9SuxripJ2GI7BQeB6qKfbT3b6Ui08CiW6FAB/CsbT5LLvWcMFJqwc/mb?=
 =?us-ascii?Q?5F6uCo8AENjmeCi2n6ccFndjurGirJA2c1ZAaVnTe9mOfbgFIjOEoj78hkJJ?=
 =?us-ascii?Q?PQsRxRh/1YBUQWQ5m2ZJBQ2lY7cZiLNfWPXXZUMNrZPyRquE9zIiKoyrHL67?=
 =?us-ascii?Q?4rsqEVNGzo1cQWq3nF+sfL73qZk/6d2a4dducMb3oTKexN1BYWxlXJvzpDj/?=
 =?us-ascii?Q?xW2vQ5UM0VWWuhhvtkjJSqIapjFtfK+1ofCh08qyhbggJzymzV6RtkzTcwCr?=
 =?us-ascii?Q?SW92VyR9XHkGS5TgvOyG1t4tDcZqGJSOKJUN/hsXoglUJ1myFqmnK2/hCraU?=
 =?us-ascii?Q?QOujDsI/ToVmJ2Yd1xyaeORhUWaNyiFQXErOZbzJkB4Q7xrI1AmpOaBEsbpY?=
 =?us-ascii?Q?YaSyQRC3VaY+XuIRylvAoLC4gfG+svS9aMLSFGdEVxNTTN15hdqUJEVLIhF/?=
 =?us-ascii?Q?6E8/WqwBczOdXEgnhKXyFsOz0IzwPy7r+OGAAvY7zGbGB3M1BGfBWl+ltdeM?=
 =?us-ascii?Q?Ds2rmI/zr4uKpWS8XUJcJNbog4BMlCQ1CddpM65cVBK2sMMllCFL9llZM98P?=
 =?us-ascii?Q?xrW7w5zfAIqlo+oikGwHcAK1Zvl08txGUM1cYs7M6Ui0E8UYDbSGiUOXigOD?=
 =?us-ascii?Q?Wu1ozGQaULRUyQvbtEQBlqBYxRLQoCkjNu3HWB4yAoGAi2cR/4S0xKdXh/vc?=
 =?us-ascii?Q?y3w5jlO5u/ve4Z3B8H49lJJeMGNXA471xhjaatlf1ZP4PP7adSdYNQL8gyJO?=
 =?us-ascii?Q?nkm/hsjqw/3JTZcRDlM+nRzjJXzPSgImgaQyjfKI54v65uXNtPPjHkC5vHop?=
 =?us-ascii?Q?3F69iM61npJcGf5b6sck1Rh3Xk3AQgwVatUTqUQVVwj8fYuh/js5rYBJMcOW?=
 =?us-ascii?Q?v9/OoiigFS3oL6uu+rdqsKohvkOhAykNuC8qJSYHKfXJhCIHRSQz9v/O1Skt?=
 =?us-ascii?Q?gFOIOqfM4gzUchwR7QBznNkceOIWOCvG3253GR+bxzlrgJSOLiEcZDNdVNEJ?=
 =?us-ascii?Q?t7TWpE+vMl7fUwcir35s4sx4UHB+DmKfd3PnUfcCQRZc897yfsh3onYdSlql?=
 =?us-ascii?Q?FoT07UpwCm2fj2mHqNOYmH6vz7qQi344x7GrCNxg5W3ZLgvtCed7sA/omIaN?=
 =?us-ascii?Q?hkTmRn1goIIARIwsMWIx63KB4jHJmUUMPGOu7Tkis7OCMIwZjkxMFg6/gKMx?=
 =?us-ascii?Q?cvQUTg4FbWyY9iBExSZGKV27BKGMMp6GmhTTTrguLERAns46h6rgfC2Qeezp?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef40de28-7451-4de3-50c9-08da663b1707
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:22:00.3055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Upugje9rhR7D9CbBZEniEwnavB75vH51md6aptoxK7g6PN45onsyFElMwDRMt3RvaR5dtFawhLzreEFrJINWFK4zG5I3K85a0kZeuKrolrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1593
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-07-15_03:2022-07-14,
 2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 mlxlogscore=878 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150035
X-Proofpoint-ORIG-GUID: 1vj2vwMkDivcnZU4_4LONwmEzvv1ImHO
X-Proofpoint-GUID: 1vj2vwMkDivcnZU4_4LONwmEzvv1ImHO
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

Hello Rodrigo Siqueira,

This is a semi-automatic email about new static checker warnings.

The patch 00fa7f031dd4: "drm/amd/display: Add basic infrastructure
for enabling FAMS" from Jun 16, 2022, leads to the following Smatch
complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:311 dc_dmub_srv_p_state_delegate()
    warn: variable dereferenced before check 'dc' (see line 309)

drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c
   308		int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
   309		uint8_t visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^
Dereference

   310	
   311		if (dc == NULL)
                    ^^^^^^^^^^
NULL check is too late

   312			return false;
   313	

regards,
dan carpenter
