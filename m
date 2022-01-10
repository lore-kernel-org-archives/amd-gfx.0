Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23136C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 15:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C86A11A9E1;
	Mon, 10 Jan 2022 15:30:51 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F90511A9E1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 15:30:50 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AFTl3d014709; 
 Mon, 10 Jan 2022 15:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=jAQPR48B9gJrkVfC2vqNkQ2ymb0YKzrvilQGQZgGTNk=;
 b=FDBogzHjpx7g/rR2cfzpGQdtVojf+79AQkZRM/QaofINHYA+UiQhvrj/RXO5oCM+17xr
 FFzvTRf2xbY2gbrzt+gPdynqqvLqKp+T0LShsWxDcz43l/T+M1vX4pYrwB6oRvOmokUp
 1815vny8PE9gzWAy3Jl8eNcr8q8TlK9K31wvH7Ut6Woi2Zq9zoUzssLz1pzMK2hghw6X
 1Jz77yXLlGXThCJ6owiq0FD028O6PCYyAqTQyX7cwBZBWGucH0XtghFan7be9GHWcGwF
 dOsyylUZObtKuM4NeUGjMgn9SrrPMRsJ9qpQ98FQQzq9kkxHF7afpDCHH9Mg15vyjUQ1 Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dgmk98ftc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jan 2022 15:30:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AFU9hx139863;
 Mon, 10 Jan 2022 15:30:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by userp3030.oracle.com with ESMTP id 3deyqvg96u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jan 2022 15:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjy2rPeHSwkSfjfx+4T1XUn531XNQ7I9YGXFBmbH9YxXrmIGDVwq2QdEhHwGnc2VIpdQI8ntr8du3sM6aZvB3H0R2ZPt8XolLf3u5xHdRPWOCrX2ogz82uxvAgJNyffKpbmxhkzYU8AUcCnmxMVMLsIMjdVYn79oGr2JaO3OvNAX9PKhDQdiIRIhaiQd2VV7/svQMAauqzFhRfKH82Y80526N5AtAtJTuie8z+ag5soxPJWZ+0nQwGGgxVSukFt6EmpSSDGx5CbrWLLW8+GzwA8ItIwvrmKp7TRBkIz25ZePed5akCNITLRmTszzC8+O7RYeBgEEj14eRo8+16pVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAQPR48B9gJrkVfC2vqNkQ2ymb0YKzrvilQGQZgGTNk=;
 b=VZAX/PnEQHktpFmvV4VAyyCnqfJqjhF9tUgxTl3koVZkcygcteHUDmTkLPejcExs52HzcManewiY7/LiM8qBqa67duBG0OBKsVCou8472LA2qSPZhbhhjP8KGlr0rMArKxHXC+HQANDLR7bFcNIPSZr8enSG1coTMoHeFVpSAAQUrEQP5vPF9+wAw0MdEICkDC0zgCU2O0Pv7QCLAm9i1k6mYCblZiZk88fclRh5q7j+QtqXizgtoE0Z21djrU8/LfcM/8Pw3stpBLgyna1DN96+UX1SbjRSSPZCUG/ERqAEzpV94C24DEuKStnv1WJGYey2tl/xaBW6Oh8jRY89HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAQPR48B9gJrkVfC2vqNkQ2ymb0YKzrvilQGQZgGTNk=;
 b=NjBAIU/E/e3PXeqgXKHfYXMzeixtQaD6hFwj96AHSIiBdlW8AAmuSTWI1TZ7UrIWwS+SadgVkHCVDvAp/ZizsPXx29HJ3wAcpa1TCgqHO8og/akHD16BEUzeTeMp6g6hVEROsg/3Nh1zovRhUbnANhoJmyKSfw2L/ZrVLloLcF8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4628.namprd10.prod.outlook.com
 (2603:10b6:303:6c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 15:30:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 15:30:45 +0000
Date: Mon, 10 Jan 2022 18:30:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: wenjing.liu@amd.com
Subject: [bug report] drm/amd/display: define link res and make it accessible
 to all link interfaces
Message-ID: <20220110153033.GA462@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0064.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52e992df-f532-462c-fb4c-08d9d44e2b4e
X-MS-TrafficTypeDiagnostic: CO1PR10MB4628:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4628745009CE920938BBD5B28E509@CO1PR10MB4628.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R91f0q1tUT+QqrBbj1KQABPvjsaiN2BGh9XAxnIDk7HhE5SzTcxSNcAoIWwTRfPrH6uXyWNweUIzHcv/DogDTP/CMR2YgILJCGG64AjYce/AShfAVXaze/wWQKXlR+hBkX1qAaCGwrxNYVhSTWEBblZM3yPb1YmVzdEh51tCTsU1vaNqqnhyB4IygvpVuReJjC1z//9zDwKii3qdIWhaB1M2bSjP63FfNvsUtzbqD1OKn+/fbRLRwLPDXXk0h2g2h34D8z+c/4YIf1ZfFOArQbrbaVp3OPJywZd249q7YAabO2rOOx3qlY76G7Cf9YJmV2EKx1798v2pxpa17Osv5dWBlHonqoFotVohxao70pkcAfggSy4SZip4uXcIBewHxAXGeIr/CGzHswocIpfo9BYPnyIJjpiyOnAZQpvMB2Uabl6Ul3CnU4tIReOOJXZXs96xNH4oem7o/DJzNHXSXRMTNxUI05oIkpxTP1I9N+HNItvIVpdL2oJaC9BKCRtf+2WvkiQjup12ULsLel3EiHTqJkZaWHDGDaW/ER7vmxd6FrAjMPH81DtbFRYcXVodQeDda4o/5mcSt2d1MKa9uIQAnRmuJ2BbPBpt8X1GcicdWcxS7SYUIe4Y3qFdkvorKa9ntfhtF96iypV1and9unBynV2uXSTgZ8D5ETREuQZCwfhbkYzXKdmBEZsxRCvmJ4lcrv4DyS2AEctQKgfpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(366004)(8936002)(52116002)(66946007)(66476007)(4326008)(1076003)(33716001)(5660300002)(6512007)(2906002)(86362001)(9686003)(6486002)(33656002)(44832011)(8676002)(66556008)(186003)(508600001)(6666004)(6506007)(26005)(6916009)(83380400001)(316002)(38350700002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQIxl0lF48mlyPlp5NKgV+L8W8JorhZJga7YVBNMV4RQNmHaCKJxhnAdUisq?=
 =?us-ascii?Q?9B04jShALcT1XK0LIvr1BgyDZRZYtpx7RIqU4xyI7cuUEpHftbdZdseo+SFR?=
 =?us-ascii?Q?17VmWmqcT7LKArQqIiH7u6RrdmFeGd8vajYmIwYwSpNngjDW9pr9T6o0VttC?=
 =?us-ascii?Q?rZIUvNeYmRHVrPaY2kgEI3oNBXT3xUvWtgyzzWt5eFdmBLbt1jcyJQUd0HQS?=
 =?us-ascii?Q?duGcyg4IYNFgRdenL8K/SpvdGZxAdl07W5vkcs/kfQeHBh9CaDyQjBMV48zA?=
 =?us-ascii?Q?/cGRXyitJQJCXOufcz5pa8Dsczf7dtDC0eKRfnUAUvAPjDHP76XTkYabBbpb?=
 =?us-ascii?Q?kLohg2mVtEDtnUCrMWh+4edwEfjmswcMaPOcCjlr13TCVHL7vyXew7X5YpHc?=
 =?us-ascii?Q?kZbouV3QSaRU9Pf0TAr0TfMxbebzL4eTwC09e7NAk9LguRnQMeolqFlVer3c?=
 =?us-ascii?Q?+Jjzq4pj9czyhve6z24t2EQVjmK7syPo/2od0ap4lrMgZ/S51KOXe2W+EJer?=
 =?us-ascii?Q?4OV0dYTgbPCPJYSDWv3H880IBWSexuoOyMAQz/vxw0IitSwYpyRPOmIYDcLk?=
 =?us-ascii?Q?7VlrL+sx4FsT5SKhvMmbLdlt27lvDvOUlPa5+SWAkZFtENXSKpHjndSkRiJy?=
 =?us-ascii?Q?BLVUwDIuYUHR/19QmQ2ZJDl77W8sPPPj8WZ+BLprPSgEdl/Wry+hhZX6yqBW?=
 =?us-ascii?Q?S5ux7U0ZsiAb/pCsr4ZoKrd4noJqc5Kb8sQEAUz3tJ+Kwu3b48chFr72Io6t?=
 =?us-ascii?Q?lcmnSmHZyNnA/D71hn/rZ1nD0e8zU5Bo6dT8iGG3sUX73pY2rcaqekC4rqeJ?=
 =?us-ascii?Q?HLDWg8S/8Ba+s/5T2jEaMThvT/6wWPtl5R+/scZd3YQr+f7ihSaC3VCtFjwF?=
 =?us-ascii?Q?7beVFTpSqJwH10aVtAUHXSrEXm81y/CHDkUsSSUuCB+Oz2xwNqeJGlcDx8cx?=
 =?us-ascii?Q?ouBV1mMCsltwarzLcuH/oCTLylCGVOjpqgR3gjTt4i+I9+4HKNvz35V4VHkn?=
 =?us-ascii?Q?woG8d3pfIlQBEj77M69Jkn3nnf8x28sT2HiHFod9cH4aXdEjcmeVu9L+peY4?=
 =?us-ascii?Q?MvXQReh+rhLTrSqbnyXIzLUZOoTxsqhw7dt20j3vtBCqseWLWrIEiQQSPBNi?=
 =?us-ascii?Q?AEXdTO3Mpy4i3zd1UEjH95s+s+wjiBMUA6EkVtHyQFcA8T619dYqUSF534sQ?=
 =?us-ascii?Q?WwHH+/UMJcgk7/OJ0LInvlyb+W0LpKCMC9pBuWqiM3TPrA9Cbaca94xr2las?=
 =?us-ascii?Q?P1JxHCsXFPGnEI+lAUHMKAtwMZddFRaobdGeyfYND+1Ner09TwkwJo94CKgq?=
 =?us-ascii?Q?bZAkNnqTtqOVHL5eTIav6as9Qf2bfjz3OYQ8M+7+AzhZKyRz6eZI4dxF8NVN?=
 =?us-ascii?Q?iFfDXGVx08NE13yBLH6TwwKjz5GWLoxVfzKWLENMJmM1Iuub0MYqP5RM49FF?=
 =?us-ascii?Q?Xv3hX2oFATuVH6O67/HSIyM3T6Y4/jt4dvFdpnBGrN0BZ0woZiE6Gh8HevqQ?=
 =?us-ascii?Q?ahUz24931dCIgMphcPjQnzVYboOFZsIfhp52fbESpfWVGnpoUYgFo2snwjYs?=
 =?us-ascii?Q?G3u45E8lBxHh++xlPc7EaTTP7GD4lMTc80MC53YHBqWm+iUEEtJedCEIMmhE?=
 =?us-ascii?Q?UFH51s/l+3T6AqTwAAVKmMIXbyQTG66jRyfZE/yAGELB2EE0XkBH5gqaKykT?=
 =?us-ascii?Q?M1UENFoN/45hd43ylbvWBsWMzsk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e992df-f532-462c-fb4c-08d9d44e2b4e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:30:45.1738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AbwZ7AA57aBdoVYED64pc8C7h7tfNGRgnR+22GpwJHTfdhL3PpDRJbLcEtXAd/ztmX/40UKhcsuyYIXMAd/6dy1fXn4rjU4uqd1hPQv8tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100107
X-Proofpoint-GUID: 2W_MS-rjoL5s05lI7vbz9vzz62uAmP4F
X-Proofpoint-ORIG-GUID: 2W_MS-rjoL5s05lI7vbz9vzz62uAmP4F
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

The patch ef30f441f6ac: "drm/amd/display: define link res and make it
accessible to all link interfaces" from Nov 25, 2021, leads to the
following Smatch static checker warning:

    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:4586 dc_link_set_drive_settings()
    warn: address of 'dc->current_state->res_ctx.pipe_ctx[i]' is non-NULL

    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:4587 dc_link_set_drive_settings()
    error: we previously assumed 'pipe->stream' could be null (see line 4581)

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c
    4568 void dc_link_set_drive_settings(struct dc *dc,
    4569                                 struct link_training_settings *lt_settings,
    4570                                 const struct dc_link *link)
    4571 {
    4572 
    4573         int i;
    4574         struct pipe_ctx *pipe = NULL;
    4575         const struct link_resource *link_res;
    4576 
    4577         link_res = dc_link_get_cur_link_res(link);
    4578 
    4579         for (i = 0; i < MAX_PIPES; i++) {
    4580                 pipe = &dc->current_state->res_ctx.pipe_ctx[i];
    4581                 if (pipe->stream && pipe->stream->link) {
                             ^^^^^^^^^^^^
This checks for "pipe->stream"


    4582                         if (pipe->stream->link == link)
    4583                                 break;
    4584                 }
    4585         }
    4586         if (pipe && link_res)

"pipe" can't possibly be NULL

--> 4587                 dc_link_dp_set_drive_settings(pipe->stream->link, link_res, lt_settings);

This dereferences "pipe->stream" without checking

    4588         else
    4589                 ASSERT_CRITICAL(false);
    4590 }

regards,
dan carpenter
