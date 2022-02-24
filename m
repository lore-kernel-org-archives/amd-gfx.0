Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E351CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 09:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCED10F35A;
	Thu, 24 Feb 2022 09:07:59 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E6210F35A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 09:07:56 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O7hxUw024819; 
 Thu, 24 Feb 2022 09:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=n3Ida2GYpb2Hd7ftgRXDHd4/o5Y5UkmEpo4Y2ThksS4=;
 b=qj1Sflz19txdMF8wM+sj0yZYTfzx/EPnyqjocXhuZJ+GaIf9dEVvyU8xVutdVn7quUwU
 iqk5dNSGuAQteqeTuPKb1oa0wQrE0XUTNpek5ZIVaWruYrAIzCnLr6d4H4dExXgPgIkI
 27mL27uFv2k9kwHaUDfhvVbsG9O52Y/VAoQ7+rkALyWKnL1NVdqXd6RF4hMrpqkHklLn
 DkL9VgQozNYygbPrqXVKnKCtTqoL9G4e5ybV/bpgHyzvN3ucva6mRyCTWnIfjpJSu1fj
 93BE1QiKCJ/2B/NDl+OzOYFsJ0Q6yfwFQCx83SbXvkuOCcW17uB1Lu5kfDM/MmtRdnFf 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ecxfax2q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Feb 2022 09:07:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21O95f0G017651;
 Thu, 24 Feb 2022 09:07:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by userp3030.oracle.com with ESMTP id 3eannx2tun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Feb 2022 09:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjP7O8ckc6sGfioLagnWJ/0VF/EQ5NRbT++07eDlI7OWlOQefPCgvxMwAYgRp2xtqShC4FsYUh1Ugu4fDJ7qErqZcxxaSqhZouFmyer0lFE+LDF9lNqD8m8wm8V2Lyb0bTmHFk7kCWgLeb1NCZVxLwtDfKm1llR1QLWPlm36lIciLJzL110AHOdTC/pyuMfC+S9PZoFex7E9qleiJ/t0UNOxBFEdVzaFOZTdYTLOWHN6q2SxOmZB6+O4rdSaabaIwLx+MUlA6deeOohfTZG3SLnWTfqUmKdMfiOiufsrpp3OkVmcmZ76JZzHVqBdTAiAzEAAmU8+HFPmxSNEJ+teeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3Ida2GYpb2Hd7ftgRXDHd4/o5Y5UkmEpo4Y2ThksS4=;
 b=SNP3c10v12qQessx3KzC1AaRwEES3vyn00XmZsdrQZaTX41pzU+ogEfCTWLEH2ptYR5on1Z9Ty1tB2q9GjpCK+e1j7UoXsFj6HUjWoAEzf9AQuFqVWpiTDa45n9fAW/BZVqq3grIBnO78kJzlcR9USAZ6qHTzW1kf/d7RTm9jYdwBcYLfaSIzMe88FDUVDn4OhunfI7ONPDO7pktYAirDrKZhg97NUlGFGx8iMQUpzyLgNR/r2exGNUzcLHR36NTIlBYjJk3TCrH6iVk1VuHr2GBxxQrcAQp+juQ4JdkfU2S3qXi7WH+XZVpwnnKVQpD5Z9SF55EyMD7hDFugQrMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3Ida2GYpb2Hd7ftgRXDHd4/o5Y5UkmEpo4Y2ThksS4=;
 b=aYZe5fxe2MpJelqH7Pvk4vIrZ60tCHt6Oj0dHUNH3lz71abTJI9gqMbNhJ4FaRxsY0VK7r1I2F3GahFpgZbbSCAvQ0gXUIow7b4fs6qMwH0i5qSyRVgYXcq/prZndxAgh76UtRiuAczPGIAszHa5wkox7a2nTYWbYx9QEzdyaqg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1463.namprd10.prod.outlook.com
 (2603:10b6:903:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Thu, 24 Feb
 2022 09:07:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 09:07:49 +0000
Date: Thu, 24 Feb 2022 12:07:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: yifan1.zhang@amd.com
Subject: [bug report] drm/amd/pm: add smu_v13_0_5_ppt implementation
Message-ID: <20220224090740.GA25946@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df52d5e-af95-4ee1-8164-08d9f7752166
X-MS-TrafficTypeDiagnostic: CY4PR10MB1463:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB146363A1C4058EAEE572649D8E3D9@CY4PR10MB1463.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cf+JVBp99dgDtYbWVhx+elzABzLOH2OoVnHWD+aHzN9ISWNiSmzdZUAFlpYOrNW92LEnw/Tn5aKIucxZ0gIRRVmDUYdVxv32FTFnQk9GxG3QpXaW3NG3k6yklYCVI2CCRTRF8zThfsjLcu11b2IalgW8UF0M9xkgT8TBGKoXuFYLocxx/rm6JPVjXpes3pgrwmFaFSrb7oL+mw9TBkYllscCV/6wvFSwjfFXcfE654cW88+9axdJzsllV66YmVllfrGANhprmHpaxUcZd8o+9Hqa97BfuFSvU+K6EU59ahVi/G82vTkVMqSUGFs2o3VZ8pAdbYi/n0HjWsD1P4bPneRMSTpwEsaw9Oc5Zd6axIOtqGyiVLcMJstKsmG2vcFEnqo9qI80WBGprIZnTtQ6JeDNEVkwQ33bbxNGlX8bA9oJpMCFw2SXifJ/Jr9PVX5NignE/+KMUpvKqHbQc3nDvjpD2LM/E1wotzdx26PZ8O2Qhe+9D3G5556vYBSLI6Ce+vX0trPsvfKQRZDrBNLHoCHqvqqObM8g6nrnFMVsupFdmtCmy0XidfqHQOEeRX7HVabxZHG2T1hCyvwixYXlj7cS88swmSesSbeOOR9544N7pydM324Qt+jneXBXWLnR+J+/hSB0rdb3dp4vCE7DeTtplOdWVCbvT6eveaCvdI9znXDkXuEwLPcCphmMSEqtuhVReaUpn+hHNjWVFkWVaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(5660300002)(52116002)(6666004)(508600001)(38350700002)(316002)(8936002)(8676002)(6916009)(38100700002)(6506007)(33656002)(6486002)(86362001)(2906002)(1076003)(66556008)(66946007)(4326008)(186003)(26005)(66476007)(44832011)(6512007)(33716001)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yYK7ttTxXNnly6Bx3qCg2GOBDob86gXGZndS7L2LDCUy+Tsp44H/q9RCGtD?=
 =?us-ascii?Q?rRbR9CeLXhAeK704xwJXpmN4scnO+WkZXfaPL7/XcXodeyZFP7NF6cN1m8CJ?=
 =?us-ascii?Q?AWhv96zz5n+28ce7EOkm6I1nki+FP2K0qxN6Uu4tLzUnTbD2HOPtW3TrT/oS?=
 =?us-ascii?Q?G35ECBgwepq9tPvNZ+QR21PB6WPgLlZ+oU0CPF3Ytpc3gXf/lwkkc8p0GuWL?=
 =?us-ascii?Q?xMQdszYRl2Afc/+wwhoOKXxO5JrlbeAx+Rkr4pzozuoB2kC/aXDQqGgAw74Z?=
 =?us-ascii?Q?JGCZxEfp7IKdPR5/yOawa7Ch9dq/jnoA9wI40NlEW5uaWjM4asMO3iHPeUaX?=
 =?us-ascii?Q?J3Fl7bG+w/bxVaLYAzJYWtPpjCeabgUH97THF24n8Ax9ni2hXgCIBThaFOk1?=
 =?us-ascii?Q?YgifjgJ3XPcZWI6Le5bjqwpHBEVzIH39wAg2HJ4ISXY48PU0ebZ6IMcqU8Pa?=
 =?us-ascii?Q?dOZne38itywPLJ9KGeOaWEQe1lEkgbxNvidzFuGqJ3RRo7xeUeQduxA+QeQa?=
 =?us-ascii?Q?PYilRta/3fo3Z7vxOKwi/3Ip6OdYpk8B04gOYKzGaIizDHTIXuh1BzawOD5J?=
 =?us-ascii?Q?MHjP8qBsTqzbaYEh1VTt98cwQwB96oNFfQvd8n64SDMi5aRbAgAemhfsfuvU?=
 =?us-ascii?Q?MpdyOvEWd5gwmIuFmpeSDqy29WUXTaAXJ4vFa0L5nJ5IrryMQPfhgAh5ssDl?=
 =?us-ascii?Q?gLDQdUwWUvHqZuJb/zQSoW1vghgDTzc6xPr5vsHcjOZf84kDxU8Zbt0VwxD7?=
 =?us-ascii?Q?uX/moe55xV8I6zveLWKRXsfFEoq130n2tbmIn4yL72R36Xkev2gEw6fktj27?=
 =?us-ascii?Q?Z1OWTX+xCiL7R7ytF6GGp+byToJTX96ccctMG4+iIHgy/9Sp8JKzdoe3qRu/?=
 =?us-ascii?Q?9t8BrM3NSOFcbdyq0L5Pu+62nOf9n5whLmvD0coUS4EFthW2oHznmiXzCSDM?=
 =?us-ascii?Q?jjLDW/rCgqU7v4ZM0r+E4gr7OIr5NOgcNX9qExrxb2oM1rWzbqLaRptCciDY?=
 =?us-ascii?Q?5K9E9w6PDJhyj+IS5IO24z9HKGL2o4i3bFdNt5asa4E6fZbuKYhU8/eJ0z0T?=
 =?us-ascii?Q?gRUsRNQjJPOj0D739FcFzkDmkSvQRoIyB9NVzJQ33jlDN3LI/v+kv9P9v6zp?=
 =?us-ascii?Q?6tTDk10XRjru+C6HyrhEbiCIm4JkEHvfjc0K5h/Yxk4GVjwJSAWbd3CcGXTW?=
 =?us-ascii?Q?3tYZIETCrXtCalrmvzq8WOtFAHc6DwNX6d2cPd5MXSTHteGvk2R60LesIJ4h?=
 =?us-ascii?Q?1y/ITkYWbXOOMOUoPPoMqFH9xzYOdcSeQB5NVOMfPXxSUSoCDz5SbAa5x73f?=
 =?us-ascii?Q?Dbdc3mYv021w1pq8Y0Flcge7a/SRnQYiRQ05G42EOKt9yJYMM4C7hK1dau1m?=
 =?us-ascii?Q?nFbfWGFfmr4xQg4NMtT94J7xL9/IVvp5X1QsAlnIurk/8bhgEG8pjGUByGjZ?=
 =?us-ascii?Q?4Tri2spOgQM8iFcLJSM8odTv0hpK5GKsUJKzEJprB7RJlXPFc1mXGHtMBGLE?=
 =?us-ascii?Q?BMjB5t7KgJSSI/eGvKW9suc/C82nIz9xa3zXuoGyUGz9X5cO2FRbauNLd7a1?=
 =?us-ascii?Q?R95qyyspOzaqA1dDJ9NZhdB04AohHxcGGykKMxPjmh+M3nsPoxkSxlvdfTEd?=
 =?us-ascii?Q?3Y+4Tb096VfNNtLycNTsW6ssDGA8OL5WX30/MP3xYoyZhmxo3/LuoNTWEqHA?=
 =?us-ascii?Q?Jf1XbQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df52d5e-af95-4ee1-8164-08d9f7752166
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 09:07:49.6048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYKd+u8yP8FtTBas1GiEvSTJOCaXhT80hxudT2XR7/cEzD5+HwO39TUlYKkIuTDQ9QoEuo55h26Q8v7mlYRSPKRE22AHFJ7yWFv13R87YRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1463
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267
 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=774 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240054
X-Proofpoint-GUID: ipD35UbmzO3Vk3EwgDHCE0tCb1Pp26iM
X-Proofpoint-ORIG-GUID: ipD35UbmzO3Vk3EwgDHCE0tCb1Pp26iM
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

Hello Yifan Zhang,

The patch 068ea8bdc0aa: "drm/amd/pm: add smu_v13_0_5_ppt
implementation" from Jan 21, 2022, leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_5_ppt.c:444 smu_v13_0_5_set_watermarks_table()
	warn: duplicate check 'clock_ranges' (previous on line 441)

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0_5_ppt.c
    434 static int smu_v13_0_5_set_watermarks_table(struct smu_context *smu,
    435                                 struct pp_smu_wm_range_sets *clock_ranges)
    436 {
    437         int i;
    438         int ret = 0;
    439         Watermarks_t *table = smu->smu_table.watermarks_table;
    440 
    441         if (!table || !clock_ranges)
                              ^^^^^^^^^^^^^

    442                 return -EINVAL;
    443 
--> 444         if (clock_ranges) {
                    ^^^^^^^^^^^^
This is always true.

    445                 if (clock_ranges->num_reader_wm_sets > NUM_WM_RANGES ||
    446                         clock_ranges->num_writer_wm_sets > NUM_WM_RANGES)
    447                         return -EINVAL;
    448 
    449                 for (i = 0; i < clock_ranges->num_reader_wm_sets; i++) {
    450                         table->WatermarkRow[WM_DCFCLK][i].MinClock =
    451                                 clock_ranges->reader_wm_sets[i].min_drain_clk_mhz;
    452                         table->WatermarkRow[WM_DCFCLK][i].MaxClock =
    453                                 clock_ranges->reader_wm_sets[i].max_drain_clk_mhz;
    454                         table->WatermarkRow[WM_DCFCLK][i].MinMclk =
    455                                 clock_ranges->reader_wm_sets[i].min_fill_clk_mhz;
    456                         table->WatermarkRow[WM_DCFCLK][i].MaxMclk =
    457                                 clock_ranges->reader_wm_sets[i].max_fill_clk_mhz;
    458 
    459                         table->WatermarkRow[WM_DCFCLK][i].WmSetting =
    460                                 clock_ranges->reader_wm_sets[i].wm_inst;
    461                 }
    462 
    463                 for (i = 0; i < clock_ranges->num_writer_wm_sets; i++) {
    464                         table->WatermarkRow[WM_SOCCLK][i].MinClock =
    465                                 clock_ranges->writer_wm_sets[i].min_fill_clk_mhz;
    466                         table->WatermarkRow[WM_SOCCLK][i].MaxClock =
    467                                 clock_ranges->writer_wm_sets[i].max_fill_clk_mhz;
    468                         table->WatermarkRow[WM_SOCCLK][i].MinMclk =
    469                                 clock_ranges->writer_wm_sets[i].min_drain_clk_mhz;
    470                         table->WatermarkRow[WM_SOCCLK][i].MaxMclk =
    471                                 clock_ranges->writer_wm_sets[i].max_drain_clk_mhz;
    472 
    473                         table->WatermarkRow[WM_SOCCLK][i].WmSetting =
    474                                 clock_ranges->writer_wm_sets[i].wm_inst;
    475                 }
    476 
    477                 smu->watermarks_bitmap |= WATERMARKS_EXIST;
    478         }
    479 
    480         /* pass data to smu controller */
    481         if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
    482              !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
    483                 ret = smu_cmn_write_watermarks_table(smu);
    484                 if (ret) {
    485                         dev_err(smu->adev->dev, "Failed to update WMTABLE!");
    486                         return ret;
    487                 }
    488                 smu->watermarks_bitmap |= WATERMARKS_LOADED;
    489         }
    490 
    491         return 0;
    492 }

regards,
dan carpenter
