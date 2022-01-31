Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2440EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 16:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC2510E171;
	Mon, 31 Jan 2022 16:23:30 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7EE10E171
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 16:23:29 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFwtxK028142; 
 Mon, 31 Jan 2022 16:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=+bEZ7q6E3BZs71Y5SuXu0gYUQtr4f2b4E1TYBDMF5U0=;
 b=LVFlpAtI5n7ZdIm1/YnK4eXwa9KdYLawIt2iXoa4wAsq9MvgpXrjn90UqJcoNAzjsPbP
 3Ub24yvqS/M7YklMX+wo7pnvfdu+LT2lfYLHx1PaAYiM50rL3vZqlsr0iQOhM3dXlDgc
 Ss44UQqRh/gR9wb5mlrm2QlgnDbPMfGJVaPGmslynnJOnnR2ocdQtui6QcZ6fpyQ3I90
 gFLHXtRnJVj7QyDBPApmjJKUCKGZo7By6UzcmprGHz78VPxwxLbyRgpUywKojQQwK1j4
 gbxxoCDJLTVLXVjJ90xkoIv5kg9tJvc0ou0TNMFiW7G5lQ7q2wBsbReFlQKkz/vXW/bs 2A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fr7p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jan 2022 16:23:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VGB6c1195226;
 Mon, 31 Jan 2022 16:23:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by aserp3020.oracle.com with ESMTP id 3dvwd4jt0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jan 2022 16:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCkjs1Ks09PR9vMAWoxkn1mRl29abvmM1wt9PxZljv8OvFyFIQ5tVzvO2KR2lhsNkp+a3ibgpOy+RPU+Z5BhXye0ZuMrjNx+OVGvJdwdIvGckxfDTexjYNma0EdXRuuob4R7Lx2HfjtPg3sVib1rDJMDHLajGEl0dkcj7zUGy8pVI5NzOQDzGHKPyYaI4RQ6EiCC26vCUKGdR43NtGAApjbWwNNqmOGMVH9m6vsFAuHca9ZRjbsldvs04Y8+w/bBATVkej7HLuTZVtQavKsAibkIntv7AOTKUPaV5EayZ5yXlFVy5E0iujG2UhxdSpvZnqww1rgJ0AgjZc6eWLhdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bEZ7q6E3BZs71Y5SuXu0gYUQtr4f2b4E1TYBDMF5U0=;
 b=AqsVhwY7DOqVAhJo1jM8St5szBR8u9LJGuSMsaGJrk3rZHYJVeu75NSmr9AtWEMudUiQcTyIdXVJpCBgcD8+iz3CSXHCpNvSNz0zMz6r67yi+yzpL4tyNP+jr3u7oF9FqZPVfH9yNsBUH9n8LWKOKN5B/W+TcG30OZiDyWCYMsTd7sqUbmc0x+aWuxDK8w6cINlePqaKdXdJd0y3EPwBnCI0kJGiSAywcHIi5nfXyAbqgBs5vRs7N4M4ASTsct6B3xl1Z1WkYJW7bHdvomJLDqu2ghl/ZCfN4c4cIrBJgeIEgy2YvSSnOjZ1egvV0wVorGXKFnUruSNwX67d0K6j+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bEZ7q6E3BZs71Y5SuXu0gYUQtr4f2b4E1TYBDMF5U0=;
 b=W+zfaeHg+Gn2esAToCrvhKVlALz4F5drpE97leRiCUM8jxSgCWaeLGeNHKXriSAvoT2GZtdpao3evJNYNE4rkQhGSuX2Vw+fV52un/AAJg+T8FJvmDR0r9oQtx6noeCp+PCCBXoxNVYMiggk/8nxr6r9yKUZm9cm+KHljVNk+YM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1903.namprd10.prod.outlook.com
 (2603:10b6:300:10b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 16:23:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 16:23:24 +0000
Date: Mon, 31 Jan 2022 19:23:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: wenjing.liu@amd.com
Subject: [bug report] drm/amd/display: access hpo dp link encoder only
 through link resource
Message-ID: <20220131162311.GA20493@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55219805-a917-4b29-5450-08d9e4d6013b
X-MS-TrafficTypeDiagnostic: MWHPR10MB1903:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB190396B2CCD8DFAF59FB58158E259@MWHPR10MB1903.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5j707pX9k6XExXmeGeBMHTjmwwlSSVFHL/NwqOgP9fmonGBXfjdCDGep40A1R7W1KZX2z+UP1R22hFb+Mh/bINq4gAn8d6IzwhgXdEoZbjzyrVCG6mtqJzbpRUx2PyrXO6UOEMsg6nZ6jWFhJNFy4TWgHvysiOpSly2hhpTHzYvRxwopOhsOjiwXdIqCdMNS6BrwDJw/14LLKOjcWqsI1Fq4QdEId7uUvCbbOvUgeQE9JNbO3ZP/fCVR1t4rhDag2Ol+KQ39MWPAiRsMRtzF9PR4C6ZAr5m533td0ADO7TyfhkTwy8bTXugpqL70TT+2bDAcVrA+tNV36XdbwhZB62ijKXpHem7tIWFNGHLiaIaX0MEuMU3XZjC0/uKdmz8mTL1gMqWl6ETWly5RAoFDkotQOgPE1X8qUIBAfYnkvho92Gn4o9FMKmPkVGSNFuBvLLXxa9fhy0//0RGJ+2oMKZ1k/D60vMLTis864lQOtPagrj9dJpN9LjKe0PoIoxusjOwnoWxvZP9HLH5M2pnJlLl9qNc8PHjD6YzcbDOprgKEUJcLOXdz+yBXY1kVYdhC9TgdRcVLFXdZTTzrAVyNl4lbA7lvAOIcvuJnfx4SM6MV5HfwJV77cerNm1w4ySul5llgTXM+hlupgY5OFPXozECxaXcUJF2Vj/W7fSK4nbIykhRV3sDHPl6ACPe3QbryJB8AbTJtQ6MaSMgVaD8YWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(66946007)(38350700002)(38100700002)(8676002)(4326008)(66476007)(316002)(8936002)(66556008)(508600001)(86362001)(6486002)(6666004)(6916009)(33716001)(1076003)(52116002)(9686003)(26005)(186003)(6506007)(5660300002)(44832011)(6512007)(83380400001)(33656002)(2906002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/iL2XqkngflGd9wwmMb4CG/Z1qaG4wRaU9Rj65h/DZXakYwC6nrnnoV1nhX?=
 =?us-ascii?Q?p4Lid/12O2u0dvLwU7+valybp7c46AiR1JMxD2HovpwM7g35peboctzdCjtr?=
 =?us-ascii?Q?IbkWGjgVNB4tYBL41uokO/o0HFM12BVjGgWvthDX9lGLejqN45XL2IQoEcZ4?=
 =?us-ascii?Q?/E8n4G3t/HY0B/4AORxnfyPQWTA0/SxCeUVyT0whwtZSrQKoSkUMuBLAhOOF?=
 =?us-ascii?Q?3me6LsvjBqiEhEVBL8Onk6gOU21GiSN/v0fL5aQRQ511H5S1if17B6dndRhh?=
 =?us-ascii?Q?+krEqaTLlbgVwnIMOaBbtgGHHLjskyCuYHaDulnLQMeYEzIeUz7QA7SeBWEB?=
 =?us-ascii?Q?7OdRCTIzCBqmk4NuHsbsfplOPttW3GkG29LnZ9Z2GoXD5vCmR8LkV7/ee3u5?=
 =?us-ascii?Q?K1dhG78U4TyAGv1SmwgPI6x4Ew087Ohl58fEDFNCQPjFGSwNTYoLeK3+F7U4?=
 =?us-ascii?Q?wKu3ijAMFRWGhJng0C1LzDpcUqPvNnpxhLfbAXu1my4lMmMhPxrVBi+/OVdS?=
 =?us-ascii?Q?sza5062FvbkV3nhfIQvCUSiye6WZWxNCCWUa2ZoUqtRemN8Qs0Cdq4Qt5pJ5?=
 =?us-ascii?Q?qP7GzJc00YVMrVujNJr3OAbmiKmlIoQuNRcejsk3iNhL9/5fB0xI9PBuph2Z?=
 =?us-ascii?Q?xdfgM/Ir1B7pdx+03BBXbWn9OF/c3w0GTVENC+n/XOOT0IIopLWqbKkUEaA8?=
 =?us-ascii?Q?n1GftaG/n8svyjS3pZKhY3IqmEehddixFZklItizJnYwM4mXEK6bQCguIiKA?=
 =?us-ascii?Q?JQBJNiti9WsRcdsmZGjA6ore4Gc4aS+Xror4oRQcN44uLWio2sHzNpYf77iJ?=
 =?us-ascii?Q?NicTteqwRl0Kb+zftJK2uwWNPDon7+XbZ2ZuSjrgtbAG5JXHbpVtiYfd8KNf?=
 =?us-ascii?Q?JP6gvSjCbuXisCHRwaGx4QQrjg0ZnVE+NDR6gDl0FbHgsFsiTnTdLhyw+RJ9?=
 =?us-ascii?Q?Q9ctRXiVXUAbKi/95YT6XAHcsJeMFEaXToLyVQxeT9hO3jJRBObFsvlTscKi?=
 =?us-ascii?Q?oDsfUb64lS3lplHJJQVTQmGtFQMoOM+aBKE6EIkntLAN7mAJDMrb5jbe2Wjd?=
 =?us-ascii?Q?G0hQR5252XkbCAJzXzvZqdWFZKXSwZO3Vvv5bntHVpw8gptF0Tq+/pcobbK7?=
 =?us-ascii?Q?K0MyBm9d2EZ7EEzvr4wJ7+EaGxlxVqroj5I6HeENaIXMON+CREexdLMnPxlR?=
 =?us-ascii?Q?7h3rN4/tH6n79Q+AwIIIFprvsu043O4ax+zbWA+ZZjVkv9ep6bNtuTpSpRwj?=
 =?us-ascii?Q?kLiEbFNk20PN6PJ1OtCFl4j0ZwMBa9DiHZo3yEZ3j6PJe+7TTkk84SaptHYw?=
 =?us-ascii?Q?pxANyP7cXAoNNz7MLsH9U8fAqpNQMFzx9x98LlP6kzPYlvuRbTOMmLAyi7ij?=
 =?us-ascii?Q?hGC/czMrD44t+Wbesg0IwxGf6bUWw0afmE5GvubePmlmHNdb78as6/82eNw6?=
 =?us-ascii?Q?7+vvkbLF3VcLMCxEo96EY1MGXXYL1INzXuqrd8EvXYwlLMBLM1/weW3gnsaj?=
 =?us-ascii?Q?8h34SgLtzpTmVkPJe52H+/NeQk5Zp/87ZgaILEf5mXeh5PLeVp9gRvceD3ux?=
 =?us-ascii?Q?gJ0VyccODwtO7PFtmfV8Dii+YWoOUX0LB8Y4rByAyH70I+6f4Lm2u2Z3YMHi?=
 =?us-ascii?Q?aOX9WKDWl2sxM4Trx+uk2wHq9zVa4IhHGFJm8QVDBOir9r/fhSMKQTcRIGeI?=
 =?us-ascii?Q?709Kb56qKsm2uNavH2jQFVC2AXs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55219805-a917-4b29-5450-08d9e4d6013b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 16:23:24.6154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPkF7NNv+L64JzNRFKE5URwBslEWLsy2wZVAnnxJY1rSGNuvB/Z1vo7Yxa/bvzUY/c7rifO7LMbe0aK/2IxzTTa05OX0xFMDqiVpAnR+X+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1903
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244
 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310106
X-Proofpoint-GUID: gspovaR8q-i3BsYUOMlif7dV9A9mxvIf
X-Proofpoint-ORIG-GUID: gspovaR8q-i3BsYUOMlif7dV9A9mxvIf
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

The patch 3d38a5839ea8: "drm/amd/display: access hpo dp link encoder
only through link resource" from Nov 26, 2021, leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:2961 dc_link_dp_sync_lt_end()
	error: NULL dereference inside function dp_disable_link_phy()

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c
    2954 bool dc_link_dp_sync_lt_end(struct dc_link *link, bool link_down)
    2955 {
    2956         /* If input parameter is set, shut down phy.
    2957          * Still shouldn't turn off dp_receiver (DPCD:600h)
    2958          */
    2959         if (link_down == true) {
    2960                 struct dc_link_settings link_settings = link->cur_link_settings;
--> 2961                 dp_disable_link_phy(link, NULL, link->connector_signal);
                                                   ^^^^
This NULL will lead to an Oops.

    2962                 if (dp_get_link_encoding_format(&link_settings) == DP_8b_10b_ENCODING)
    2963                         dp_set_fec_ready(link, NULL, false);
    2964         }
    2965 
    2966         link->sync_lt_in_progress = false;
    2967         return true;
    2968 }

regards,
dan carpenter
