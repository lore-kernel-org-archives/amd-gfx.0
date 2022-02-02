Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Feb 2022 17:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB37810E365;
	Wed,  2 Feb 2022 17:53:12 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C6A10E365
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Feb 2022 17:53:11 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212HYH8F028484; 
 Wed, 2 Feb 2022 17:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=9EKPXCmmucC9OFjqoU5z0/e0TkUp9AvV47uZIGl3ZJ8=;
 b=V7C4f1cjkBTsB/55y4DPmQnjItCEKUuccr7iFE40DDH07uTljF5vCkxuG8P8K58PsWku
 2wKfTZ5rsG/Wt7U0agSZ0j9iBdA7InLOoHPfhtBeiZ9Xq9GR2miIpzlUn2L6Ruxfa1xS
 KuyTzh/4cBJoXzPb99JtnJ8BS9XJVbDPNfjQdmuP+UrQkYLTw5fQKJ+srX6Oh+c59klV
 5bRr1zJFZX2wN4UDZb5ZaGPob/XE0S2s+EabchqZH67zbUeyhlZxOru9gukBcAQFi2PS
 Xdpn8HxQHl/oRp/1M0G38EoHWKZYXawWAWjpTfEvn3TmHxNlJ5CNu4BUVvvfo5cd+95Z XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pd4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 17:53:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212HjSR9099379;
 Wed, 2 Feb 2022 17:53:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 by userp3030.oracle.com with ESMTP id 3dvtq36p4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Feb 2022 17:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIWkW1hb/1F/Ib6bmMhwB0Ci38/PzAwNKRQUkwdgP/vU/M3YQKwNHvlZJJxKxWPg8hbTQGgfNWkyfBEhmZgcvSXi8Qf0gGL8jJXELw0HSSxArKH1C+bUj0n0glq63YJEDJpvVx5Ca4zYwEfDYxOjjfYFu1Hdjx4mUQuivRZke9rnSaoEfgRUlcgdf+JF6Ig/CmGoo1lYzz/k33Ga3w3ZTbj/Iw5jrqmMcoFkVkRmTMdmo2qNIdJMz2wDhPWBU/ERz/HGBDpv95V6Y4mfmZyRUUCGMt1FmC/hi+SkGHT9CfOEmAXxcd3Nban+ON0Sb9xWNGqs4fKBonYZ33YAx9Y1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EKPXCmmucC9OFjqoU5z0/e0TkUp9AvV47uZIGl3ZJ8=;
 b=Baqt7rapPS+WnQ8AVgSaTnz+jg+z39x4P5VaOWkWw7Jrg/KEshuhk50fxFoQ/7otM+kuafqdTvBka+x+0weORoQ7+rbn0NFsB+xUF5RhMXKrXkkw81GmDJuLwg/27pD1DYGTEdXh2M+ZXcoCmrPe5LN6JsovtlyEfIOymsj2BEdFfIRtOYJ+O06SSvzrSz2DI+jo8Jeb3uHyNRJbFC5k73fJglZX1luOghSAW9IaaYSew7bHnWn2yXmqzYJymzETV4Ctsl9alWXzLRBCBxyFRHqtlL3pSAyreYL0HYwZlqpfF0WtJuMZk8CrFw7doK4vNB1ZMdEeS9R2rs42aZ9RKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EKPXCmmucC9OFjqoU5z0/e0TkUp9AvV47uZIGl3ZJ8=;
 b=0GKVtvMoBpekCb12jmWeUwnGbz/tXFmxBUXYKqml8YX9zuauS0G7z1nR5X2VWdVjHMMTDL1QKsQy5IMtkGxGcy9P0yDxl5ntsoFvCzwF0oRXmHk1+p1FOcGgp4OuZMZzwmdUwp/Xiz3wwzhQ+f2G3HH7VAJtC/sV9EIvfvfufQQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3343.namprd10.prod.outlook.com
 (2603:10b6:208:129::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 17:53:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 17:53:03 +0000
Date: Wed, 2 Feb 2022 20:52:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: wenjing.liu@amd.com
Subject: [bug report] drm/amd/display: refactor destructive verify link cap
 sequence
Message-ID: <20220202175253.GB5772@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c704965c-68f0-4558-6017-08d9e674dbfa
X-MS-TrafficTypeDiagnostic: MN2PR10MB3343:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3343B6CDB767A572FA8F631F8E279@MN2PR10MB3343.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkAcNsnIMjJ3EYNDQCuNOwrxhihg+7ZIgQnMe9x/su4bbGgPjixNj/bM9Q2DY2LiRhLOyda8C1W2XM1IytN11bIpJyC/4OORutQVaL+NpSH1LGaYQG1+5eEoMLiDai8QWtjrOoHHbdgzFMvZune4nfUJg1dHnvFny4uZIoUL2biaRznlnICnKMIIlgKAbi/yxylKVg9ziKSZoq6c2M5J7RspZamEZWxVvVMFnrNqHvhToeS34Re1z5GMYvAXEIelAnwhY7dzZNscjBAdtqt5O7yCX7G34Q4874Rk0YCR9jVRpzlsLxeVrETOQXFf8jggzXY9N6bpODYKE3UFDx/8VUDn2vPnRRtz2m074xI+csJQAzfAHZNjTewSN6TDd4VIRsSZy194egUB9ygoP7wZLrEtbpWFSabQJOfoGlGr9i23Mg7ppMKGotyf/Ge7vOM7m1N2l6vMHVwR+ZLdKZjohNMtbSlgBvNOI7f9vMdzwBAH+cAZdxv5D6DW0rImo50RTMOA7wrCppSJYSXpyKV/do7jOntJLcpN4fzXav0a/LINsEbUg0WDl2cWoSHtaAuIAIivJje/NHzGzgk0jeB5ZJyICdqeZrvK68B17zUYmYx0HzoI27yI0bHIHY0JXap4e1CovHt3InhFRMk9VA2OMkvfmM0HFzSPw9aqrW7QD+xoMgwf8B8QBiLrCKNH1QYMwXPa10cJToR7LvVBcbFkPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(66556008)(66476007)(8676002)(8936002)(4326008)(38100700002)(38350700002)(26005)(6512007)(6486002)(66946007)(508600001)(83380400001)(6506007)(9686003)(52116002)(186003)(1076003)(6666004)(33716001)(316002)(6916009)(15650500001)(5660300002)(86362001)(33656002)(44832011)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y67ugy2eFcqK1AtEIyqxSlAKf0zrY/W3rUn9UqBOl25HPEmEWhI9SGQOqWwn?=
 =?us-ascii?Q?M/ORoUbJesvwbuJ5J7SnBewYjJIEXG9eH02/Rla+KWWjfhMniprd6O+keEBf?=
 =?us-ascii?Q?ov7NqCqBfDVD6i0PfWWH4m3IYeDkFafhW0P18OrZVNP08vqEZDZtZOQJBfwI?=
 =?us-ascii?Q?yFAHaEjchPBqSYv0H3NUDQozU9IZUlAfVgyoRV2UuFHzaQlCDtd73dwHMFNe?=
 =?us-ascii?Q?pjOA+0E8BSa5I0IsKjqikGir8a4xcy4mQ69+GkQP3/bndeovlSxvanMWEE5q?=
 =?us-ascii?Q?FIiCIP1E2S4egQsf6qJHFoR2qHvtVSOFpTy5v/uJi9V2LZpMcCjIXB9gJVz2?=
 =?us-ascii?Q?liN1gURlBbKC1K/CtqReKwhKqQjLJlTcF0hQJND+qJ6DvRTQ1Ygjz0U4H+5i?=
 =?us-ascii?Q?grUKl/xqTmpjstomSgWDOUTLviuKdIJ10Y6CflXCyDrcSF2hmUP0buDHdVFi?=
 =?us-ascii?Q?lsEhr2Dj0kB3xcI/CcySaJjf+zIsko+x41q/5vYbhswUZ/yyAo/vD9oTHTkz?=
 =?us-ascii?Q?AxfPy5Uyhq1hbDgH2c46ihJ0L9s9QnOpGjNcNM7BtjkJF5Z+s4/iWvCCl+ux?=
 =?us-ascii?Q?UijrwSAQQWfN62q9NgR58A5EZ0+Si38XdqICxnMF7KSn/21rNO8TQLprhsTR?=
 =?us-ascii?Q?d19zbu3wM1m4wVLWmDY/89YMY59pOY3GHmxxMrQOxvgGDf2ZFoquOLzkonKv?=
 =?us-ascii?Q?fCaUyjTUpnT/PSNY27X4fEPT0ltBiunqQIZufL/whwOrhq0+ORYqRUCiF5PT?=
 =?us-ascii?Q?TFQ4lpGlStR+F1h2Xf4iII1FMHQjWs6G9uHb9GVYrDJ9KFqshT+s/ods1dhC?=
 =?us-ascii?Q?lVKCJGPSJwiwkuElgovpnEBIpdeQMe9jYRya8x62Lk5ERyKHLQp9+eRs553S?=
 =?us-ascii?Q?4kcQLR27qrFqyfQBUBnNzvsh2qzqmhNM3QEMcK/i6JXeik25q/0ReUVg1n3E?=
 =?us-ascii?Q?TglzK/aTT+YTCo+51XUpDUPhTp0BKrtlg4dZz2JIbriAeEIz7D92/crMnRrB?=
 =?us-ascii?Q?KmiRV5IxuFiQQWGgZOVQm933ENlBKLxWmO4Hujka8MXXlUk/Acc3NC3429rc?=
 =?us-ascii?Q?S93qQOZb3xZ/vJ+6oNZHDBx63Jk8n+HU2fpJrKjVRDhj7fiSve3nndVTLmf9?=
 =?us-ascii?Q?QguGy5y4HXSvuRR2jVVzUALhWGqeHyaZ1XJlqDT1zjmLJRxSMtrg7txKghVS?=
 =?us-ascii?Q?O+2Y+NgX8dAGKCtFKZUn//bZ/atzY4MstKRrc6Q0HXPN3qTYfz0n8AjRgBxI?=
 =?us-ascii?Q?A4LQsJaYfEla4G3c48AafpO9C/GhnLkCPppfTLXn/ocz/J/N1V4eB3LgAldE?=
 =?us-ascii?Q?YaxXohvPQDoOg203q0vuGdB2abpS39Y2KVfAFEHo+HlOe0mroL2K57mkf5c1?=
 =?us-ascii?Q?0i7+hF2whA+4FV4v6xsQWfG1mJTJ07B6u1VmuRrFB7f/vUcQVC+8qLOMT1S0?=
 =?us-ascii?Q?1XC6SSXJBleH+REuc1FfBh8J04cyt8QkxTQ8hyjoANukW/VX/kn/Y7fbIKCx?=
 =?us-ascii?Q?RNi6G70a3N9sAqGY2kQaZKuysVcJsOlSI9EZliWAU11IoiwLSb7AFITTXgtQ?=
 =?us-ascii?Q?3ZyUBL0zVRFJ2ZUk+SznQMcwluPe2Itrk/ZCEnyLlHcNvN1j6r73a6vhk6RH?=
 =?us-ascii?Q?rbnsh/wqJWt3XYziufZXMjsdZxZhkvDwURj+4NQxEyi4sHjrrFr3kh55ILME?=
 =?us-ascii?Q?rVek3111/mn7iUeT8UMMSaWpjkQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c704965c-68f0-4558-6017-08d9e674dbfa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 17:53:03.3505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn71CsanD2ojGpvssd3NrjHrmnZQG5mXnxcODjinehbSXzwKKwG60mq/epb8sLV3NAJzGBql3SR7qvXkFi+8Uu/HB7aEQfecg05YtgwuH2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3343
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246
 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020099
X-Proofpoint-GUID: QEz68gcBBtblCoi2GjUtgvWjU73Lc3Za
X-Proofpoint-ORIG-GUID: QEz68gcBBtblCoi2GjUtgvWjU73Lc3Za
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

Hello Wenjing Liu,

The patch 1a206273c322: "drm/amd/display: refactor destructive verify
link cap sequence" from Jan 28, 2022, leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:3248 dp_verify_link_cap()
	error: uninitialized symbol 'status'.

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c
    3192 static bool dp_verify_link_cap(
    3193         struct dc_link *link,
    3194         struct dc_link_settings *known_limit_link_setting,
    3195         int *fail_count)
    3196 {
    3197         struct dc_link_settings cur_link_settings = {0};
    3198         struct dc_link_settings initial_link_settings = *known_limit_link_setting;
    3199         bool success = false;
    3200         bool skip_video_pattern;
    3201         enum clock_source_id dp_cs_id = get_clock_source_id(link);
    3202         enum link_training_result status;
    3203         union hpd_irq_data irq_data;
    3204         struct link_resource link_res;
    3205 
    3206         memset(&irq_data, 0, sizeof(irq_data));
    3207         cur_link_settings = initial_link_settings;
    3208 
    3209         /* Grant extended timeout request */
    3210         if ((link->lttpr_mode == LTTPR_MODE_NON_TRANSPARENT) && (link->dpcd_caps.lttpr_caps.max_ext_timeout > 0)) {
    3211                 uint8_t grant = link->dpcd_caps.lttpr_caps.max_ext_timeout & 0x80;
    3212 
    3213                 core_link_write_dpcd(link, DP_PHY_REPEATER_EXTENDED_WAIT_TIMEOUT, &grant, sizeof(grant));
    3214         }
    3215 
    3216         do {
    3217                 if (!get_temp_dp_link_res(link, &link_res, &cur_link_settings))
    3218                         continue;

"status" is not set on this continure path.

    3219 
    3220                 skip_video_pattern = cur_link_settings.link_rate != LINK_RATE_LOW;
    3221                 dp_enable_link_phy(
    3222                                 link,
    3223                                 &link_res,
    3224                                 link->connector_signal,
    3225                                 dp_cs_id,
    3226                                 &cur_link_settings);
    3227 
    3228                 status = dc_link_dp_perform_link_training(
    3229                                 link,
    3230                                 &link_res,
    3231                                 &cur_link_settings,
    3232                                 skip_video_pattern);
    3233 
    3234                 if (status == LINK_TRAINING_SUCCESS) {
    3235                         success = true;
    3236                         udelay(1000);
    3237                         if (read_hpd_rx_irq_data(link, &irq_data) == DC_OK &&
    3238                                         hpd_rx_irq_check_link_loss_status(
    3239                                                         link,
    3240                                                         &irq_data))
    3241                                 (*fail_count)++;
    3242 
    3243                 } else {
    3244                         (*fail_count)++;
    3245                 }
    3246                 dp_disable_link_phy(link, &link_res, link->connector_signal);
    3247         } while (!success && decide_fallback_link_setting(link,
--> 3248                         initial_link_settings, &cur_link_settings, status));
                                                                            ^^^^^^
Uninitialized variable

    3249 
    3250         link->verified_link_cap = success ?
    3251                         cur_link_settings : fail_safe_link_settings;
    3252         return success;
    3253 }

regards,
dan carpenter
