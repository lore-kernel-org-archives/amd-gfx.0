Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EF0C3F6B0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BB38BF78;
	Tue, 26 Jul 2022 15:18:55 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5921F8D4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:18:54 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEEWgk017197;
 Tue, 26 Jul 2022 15:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=Y7tmvawjm0tyWzib+Q0dObFTjsaZfjrANSWBu07rsEk=;
 b=sjm3o+GnfE9N+AvFHsx1YvDlA0CddvamzGqXxD6eecbKncVbgQIh1mqcPxOq5kwKwnSv
 LydjLsOrwEEzQOjWNVidlGXyTP2WL+ZKaK9xVOuSHgpfcwdtGl87jHnWBCQravy+BxLC
 k61V6qMURlPDGk6chmBhrngHmfFx9NI/wEeVo8hO98bV+KU1eanX9GRbrmOxYOcwtSs6
 dgg13xDTNIYYEsBOzAXOK+iZAMkZCd1+rxJBfV4z8EQowhwMnsIOYvUqSgOqoyt/TUiI
 UrBajjFDPWiNfsnE+VsIlRTZ5IlKZIN3KLeZi70GZx4hDx3PDaXe7+Lh6WdRS4EVy/31 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94geqqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:18:51 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QF00YG031493; Tue, 26 Jul 2022 15:18:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh64ry3ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJ5TTVHMgkFDfDVBnJCWBXdxCRsA6kIH5byVNPhIh9NCHDD/dutXbT1kRt2fSkyTf+XlbS+Uhfc2J2uJBNn+EIrO/xt5ss77QJh2FKD1uL1y+9/tBcpWdM8qjOFvoTaMWjd323ErHE5Oln2HzHUD/9gNd4DYmMmq9iEEWrtv0v53HvPYntWyzDaUP7HGr4KYRl4Fi1442ZysqWr5AR/dXGg9LIEKTb7C+hF6sIWDK6g9v9E+y3i26I/kWCoi9dsHr8+ofY9lpGdynqx22tZFAx58jFrL4wHsb6af11sNSZlVzhlP6RLpI/c76tnB0W40cRPMh6+aMqjzz4yIW7SfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7tmvawjm0tyWzib+Q0dObFTjsaZfjrANSWBu07rsEk=;
 b=cVA3fNWPBsHgqcx1ukW8ZLu4KLiVKflqxr6sb6W8qyOgqEe5YLv8pXOZ4UkI4L1H8nYEbWyjmR00J1U0yLj3Cu7v34yryv6j4ALVIuJMhtzC7XulkN4CpKfz/CCNfmH+7QrMPTE08/zjn8+I5pyJOjAdnqQSsL7d7loYGkJIhn/J/nndWRaBlzEh1wbSD+xZgJ+m/wbgeWp5DwEErLHd7SSfsylQi7/t4IirKe31d9DlIPCemun+e7izGEnR3a01KqIIdVNdxLVi+e7e2lfhnKQWLL4yx4S2jnrDfr4AUn/9D4vhArZJrxf/JM9YsJkQQ6d+0Zk/QYBUZWhZTj/oUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7tmvawjm0tyWzib+Q0dObFTjsaZfjrANSWBu07rsEk=;
 b=UgO4jsf9Gke/3EG+M/a8rHrtCLnZF4RvEYwtY623vf5iZrV9MdgiqolDZe4hBmkjsqpSKdOu/Jbkql4P1c5EgbExQQf8fhQkYD0/kzwwkndWgh+e1+rRerkxnyvVZRu2yv/poa9rZ/UzoWZpE2kZdlm5u5nRwgciiUjR12F9uk0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3505.namprd10.prod.outlook.com
 (2603:10b6:408:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 15:18:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:18:48 +0000
Date: Tue, 26 Jul 2022 18:18:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: aurabindo.pillai@amd.com
Subject: [bug report] drm/amd/display: Initial DC support for Beige Goby
Message-ID: <YuAFz3COSDTJ06TM@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f191e8f5-ccda-4a08-d16f-08da6f1a2351
X-MS-TrafficTypeDiagnostic: BN8PR10MB3505:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvQXB+KqWpQJb7DAEeQ5XM2ncUWmZ9736XQnSlTuqoWqXTSZ5BhVonfsisHdwYDZBky4jTd+0mlxSUbfYnxnNQq5gO+3EwHmxsCv6JXItNEMr1A3Jqrq1h+ReZ19rMwZL92PE0r8vZ/q9dc7Ekb3tJaOxytHJHNUQKIwudUIk6kXIUWwGBtGApECw5108NSlFnKflFco2gDhuJ1NXbKuaiT6+tz2+q1XKzVlIubto+RsgZqumvp+pm0b1Jt49VMTgdPzX4ILbUQIyeMbMKdKNWr0Zq5vqotwIsnALPKl4JgOl+FphE/g3QWwe46R+Qbc9JBXfW0cpzoC+M5ZZkdvsHRPlRFKROkF/86bIr0p2cO/et4VNvSL07+97pgPDn7N4KumlSlk8pa6PkeuENxN2eSnYQPuswwD9G5O9/fbJQm57IyPnveUHa1GxukNR97Z6eM/Mec75CMD3eoJX16/TiZbCITY5f/ghVOxxi565kYIBscKBeTwIgPGBcjwbz7Y6sXSkH8NFGjS2CYK6MkbV53/dhjkhocyvrsFbvbn9dF0TRQsqAQKpxRBi8I+Bx70/KRJ+hTknK0gUaB5XbI7K+ebhWAfuvZpCdvBeACZ2svOVpw922QaB/hLkkGm9R3WdV8Re2EOD5doAh3uTb+7v5LbVJX0yjA3Lx3REnR4PgZRa8Rclmll1EJ5oSLxkeMJvHgpFFOlfLr6ZYQoTodYtoUpDfe49aK+6VDbPwD8BfBdw1ebHtn/Kx+MuQgDWz53mf0cVKqyeYM52jbX6Y+LtMDyCQPOzUDTB1vy4kz/XQTxu9VeEv9YY6KWGt55sJsX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(346002)(136003)(396003)(366004)(376002)(39860400002)(6486002)(38350700002)(478600001)(38100700002)(8676002)(66946007)(5660300002)(66476007)(66556008)(8936002)(83380400001)(4326008)(52116002)(6512007)(26005)(6506007)(9686003)(186003)(41300700001)(44832011)(6666004)(6916009)(2906002)(316002)(86362001)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8RPUkMYQAb/V5KKVHO2oqAu9xPBXMLf2y8D5JLDaeEgmtqW4CAZMOScTm8O?=
 =?us-ascii?Q?0roSOA5hd+WjUTPnh1no9z+ffptFwIiyQobhU/8ZQT6w9gCo3RMyqJX4zTZM?=
 =?us-ascii?Q?J4tZg4bV8tsIkFDog3PQ/gvZhQxy++/ANm+HrbvddcPquJlCkR8NseP8BcsM?=
 =?us-ascii?Q?QQDOxlh3/HjTZeualap43Djuhi1Sok/cqZNiuGbHsM7Htf7nOFFLM58iOZgR?=
 =?us-ascii?Q?vyZuR7xAsgCi8wJfpbHsvTY2jYDlnKM1O/H2YBNcsBHGzjP26yd1gXac720s?=
 =?us-ascii?Q?6whHF/6QUQo8KaxxepMihgEz1EIqf+plF+UwJ4RltJowmScGicPMwksJsDGz?=
 =?us-ascii?Q?PyWYF2df+0C2OrGW8DtrYnhsITfSMN4zengkAdSsg2j00Eo76Ck2856/0bti?=
 =?us-ascii?Q?njqu7UwHvoBpi/sh4HhIElTHCxp8ZAPlHmS2ep1/oQvDL0HNiFkXpFWoG1e1?=
 =?us-ascii?Q?pKsVi9SAbZMQxSaCYgfgT/yOFVSj3JEX8Cbvs8RmnqTRVrOuaNYwiaXnVV9T?=
 =?us-ascii?Q?cHY0oqCwxQZv3T1BPxJQp9ywecaI5Au+ZmU01Fww3VRjODOUTTxdVOu6B6vJ?=
 =?us-ascii?Q?N46K6HUpSjbWqSMqSSb4Bn4c/AafhMgvA61pi/vy44q/poJBVkT6rCbO10lK?=
 =?us-ascii?Q?u5Z+ddL6l5OlEtMI1X79Qp74K5BL9mMq9SsEjU32B/I0mC9u5uMxiP0HbWHM?=
 =?us-ascii?Q?NGV3+rmbdM2Hjf5ajn+5RcAB8scyfEXL1lGdFRly1bn0/QlRmSxO2is9z4NX?=
 =?us-ascii?Q?ofhTQ18gLxYm6Dv1e81sZpHoBauEg50oTT8NLxuJ/I8JJ6L+5YynYxn5VAxK?=
 =?us-ascii?Q?DRXfnHWn7ox4O3MDtN+wzKc9KRY1wvBEn9ofVAr3nW9wNxvsiv0ofk6lYOeN?=
 =?us-ascii?Q?kv8XOs/OcD6Is8obP8DzBIXuZmHx6hAGpoWB5oQxKHIixyqj+cjDGjDJv+F9?=
 =?us-ascii?Q?OcppHetdvtGhHFpu62mGPgdcuHCw9Nx5TXhRaCcVVZ0Hsm49FJLVR1HUI8BD?=
 =?us-ascii?Q?cQozRJSDFdCHLRpiygbi/PsrOX4L3pqG67aqGSW6qlFVUD4ETDdnT/jX7tb1?=
 =?us-ascii?Q?L2udFF1HF97iZ+qv2eNPaMTfChVyk+u4Ym1eKDYhMw6VW7Iau720dkHqwF5Q?=
 =?us-ascii?Q?5eXVrMaTTOuZshUJOVa0nrkiKzSjxwMUucosB+U18y6PsQbbiKeni0ZPxuI3?=
 =?us-ascii?Q?+UjuDeBe/bFb8Y1zCPn2yate4eR/Teuc091O9eay52NmmpMhe3wjTuxY5pSS?=
 =?us-ascii?Q?oj9MB2Xvn5P4SUOYa42iUfsEQZSPVyDEQ1OK89CR1usbIadCVIpanq81SpRN?=
 =?us-ascii?Q?kLNys05q9CFI+QMqKvBtLP87e3MhQDRDQSDqb7knJ2V8InrAwacVVKOnlKjF?=
 =?us-ascii?Q?6VFn/nnimq/wuW0UfvsNg3mQj/kSqAoAzAWW7TIphkDXiPTYhWv/gZ/gPgpU?=
 =?us-ascii?Q?3128Mw1h1LXL+VxdF1IFIsfwl+ZPj7fyDSNJhZoChRO3w6yASwkfb005IgtC?=
 =?us-ascii?Q?wOJEDTVJIyUYybMxe9aeDEMhpx6GqFDgDHjRzgc/fXMGs9elQe2J+k7Nl3l9?=
 =?us-ascii?Q?+3DkALiVEPKA+Ba3HS6rXnwqBJMA2VquwCrmocs/iRIeEELOgSc3XRbTcvog?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f191e8f5-ccda-4a08-d16f-08da6f1a2351
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:18:48.2493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7s2mcqQh4ex63kgJWJpZPyJgSJ+SHIVl57JlL2bZNXp6VIE3vqPV/IbKibV/t12xXEFyypjTajWfOx7TO3GEy1/fu29XL8thgEE6k+u2vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3505
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-GUID: a-wO4Xyl3s4OwoB0_WDAumWPn3YZDYwx
X-Proofpoint-ORIG-GUID: a-wO4Xyl3s4OwoB0_WDAumWPn3YZDYwx
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

The patch cd6d421e3d1a: "drm/amd/display: Initial DC support for
Beige Goby" from Mar 15, 2021, leads to the following Smatch static
checker warning:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_resource.c:392 dcn303_stream_encoder_create()
    error: buffer overflow 'stream_enc_regs' 2 <= 4

    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:1024
    dcn301_stream_encoder_create() error: buffer overflow 'stream_enc_regs' 4 <= 5

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn303/dcn303_resource.c
    366 static struct stream_encoder *dcn303_stream_encoder_create(enum engine_id eng_id, struct dc_context *ctx)
    367 {
    368         struct dcn10_stream_encoder *enc1;
    369         struct vpg *vpg;
    370         struct afmt *afmt;
    371         int vpg_inst;
    372         int afmt_inst;
    373 
    374         /* Mapping of VPG, AFMT, DME register blocks to DIO block instance */
    375         if (eng_id <= ENGINE_ID_DIGE) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^
This tells us that eng_id can be <= 4.


    376                 vpg_inst = eng_id;
    377                 afmt_inst = eng_id;
    378         } else
    379                 return NULL;
    380 
    381         enc1 = kzalloc(sizeof(struct dcn10_stream_encoder), GFP_KERNEL);
    382         vpg = dcn303_vpg_create(ctx, vpg_inst);
    383         afmt = dcn303_afmt_create(ctx, afmt_inst);
    384 
    385         if (!enc1 || !vpg || !afmt) {
    386                 kfree(enc1);
    387                 kfree(vpg);
    388                 kfree(afmt);
    389                 return NULL;
    390         }
    391 
--> 392         dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios, eng_id, vpg, afmt, &stream_enc_regs[eng_id],
                                                                                                ^^^^^^^^^^^^^^^
But anything more than 1 is out of bounds.  The dcn301 code is basically
the same.

    393                         &se_shift, &se_mask);
    394 
    395         return &enc1->base;
    396 }

regards,
dan carpenter
