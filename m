Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F4FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 07:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED77B1123FC;
	Wed, 13 Apr 2022 07:37:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644A91123FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 07:37:01 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D6hGSd028018; 
 Wed, 13 Apr 2022 07:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=qDmcE8EAaVW4xVgyHvABmv4iK0kAvjJ+qG8gUVhiYpA=;
 b=MVqwpB2vsZIxn/FAQmtq5ouucbugCWV7LH4nnSf38LdedkSSp252l9k/ew8YLaUaG+DM
 Yb6CJJ3hJqzkwEVn06f96FONWoh3XM2yjIRAwV5+HQkig0sLc3FxSQXfx3FsoA3y6ft0
 ZfH1E3+1snZQW3NVVReYi1GWE7rkN6o3ZqIeRSgV7Og5BBda5EmXBXmXTBAeWP0ycZ2X
 U3rEDJf6hREsmvpqcSsejNl4VnOXypGlTp031R2XLLEPoyfg3Ijox1wTk5WQtHnQnJSz
 qvmpCZGMxdbBFqyOcFCwBb0CKLAPrWIT7fzS0VLtiYk3d4IBLrWPChdopEyNyzGpxWZ5 iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a0r6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Apr 2022 07:36:56 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 23D7HQS4021051; Wed, 13 Apr 2022 07:36:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fb0k3qh4k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Apr 2022 07:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YypqCHyHR7JkVnkBJME74N6ijjEQidP1TNJdHS7ILfxU/mfL1nARTQnhdnnCUNt8gMEHS+ZfXW4l5WszP5iTcOtKgZkbCgxX9uCiaEENI4ipxrALnZx4Nu4L1UBiRuJ2Cij5NXiYqzbbMOFDN4xeAeIkHAp1dn3OHFmYJOwPXT7/Rb7l+ElPSacbWL57eBLWwdhqgeg4UVKtF/PgNgaB+Lmbr15pz4mLCDG0f3Bfyq1HOqFND/Llu8Q9kFrLfUrKcb+UhjcUDyea+/ACjCF8GMt1gV9xWPTVtSu6OXYGqGdnT5H26IGayCXrM4l1EtHuBhvP7EI4uNXefBVqVuBmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDmcE8EAaVW4xVgyHvABmv4iK0kAvjJ+qG8gUVhiYpA=;
 b=EVsUfUiiiSDdbyoBtnPiZeVq1md9WmJzBFIdXYR76Ch7F7almWXWBqmI8xRz8oLnh1NwrrdPHWVeZYMjpGBcGc00qgiJRLDT5sKrA5FajQzCqxTRX181Bo/hAW5gpEXAoWn6/4gJMjfN9m4pan02Yvuc29RwPQcK8h4Wnydd8XJ2bB5VVZrHij4d52938g2Vi/cST7vlmEQ+yuVBuU/gzBvrRan9f0L9eT5L417kTFOS2AfMTvcPx3smK6UNhjg3ZP/gOM99iS2kT9Jn4QpMSJg9BZy9fdq+996VR3lruA6VcdxIWTm2pojoLnlhJH2G8lFiaEE+T6A8tqwCnk6P2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDmcE8EAaVW4xVgyHvABmv4iK0kAvjJ+qG8gUVhiYpA=;
 b=r02q3LVjymBha5EnstvuFMlYuVR2AMxkXjb0Sc5PuLmnCzronsNIEe/GX1iMDzyWYeUbk8KNjcIwqa+9pxhZw2uxpGPFz90rS40Wxi30Xxcy6R96XuyAGhyNNoMURstuehOU4KwbrvBs53WXgAsLDBrzwCvsm4GXqG7uea5WlVQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 07:36:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Wed, 13 Apr 2022
 07:36:52 +0000
Date: Wed, 13 Apr 2022 10:36:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: potential NULL dereference in
 kfd_set/reset_event()
Message-ID: <20220413073639.GA8812@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8097b286-f66d-4702-e94c-08da1d2060af
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4691346A93E68D8EEC5CE8538EEC9@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkDKvMRDz5qfpgadUr/gPuV1UKbT1JZrcu85+yCESwLtnGhdu0Jp3zZxVXLZ6zSd5ccedRKw4ivKKANiI0/C3TBajny/0ENVnpyRxEZgN6+qOc32S7HqkcNObRzAMJwI+uZHV6KXGxkgt8d+RjpI1H1wdgiHp61qKsh+Uv5EAkP95g/rwIeKXUn/Qlzrmok/XaqteLx15cLryE/CbOcGinX/9HoXLEvPbP8jpLTsv1vDwQupjiHdNlWzFg4IuCc2An9byCOk38vFFpyDGRo19Hgqx7+/i3z0fNEv2qAKUBETiGlZbJ/datsakppK0dNCjj9sy7ceUY15hv3nE3Usp/jgkFXt++l0Yhs7TkSdHfzbI3nto+wwGkHvMeu6cldJ2CqAa3CY7OQoOpTulyDpaaC+sktBXITj3d2Z3ZGNxPvNA3W3Qxx5YNBNjC8fRqWgmPng+XtQQC7yUVT49n7Js8zorI2givfuUcVxp3uJhiYh+5TiTi2Mv5+IhS2Z2kf3KG4HJx/Q1sMf3rwZVMEZSm2D0C52GP9Q5IWZ6+dssFSYA3iT4J//xgJ5R9PZtZpPtKeG7jxjfFw+QkNOpUDlmL9zkZNzuJOl7WEwZRaJWyfzTW4O99rOYItxuX6gcniGvv3R9bGn0pnx05dr4YgfDs/5rjlmPdJ1O8Q2BvXKvrEGidqwJFTZsX/+Y9cvst8CwTrgi6dXKBXmMpcQHx6G7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(9686003)(1076003)(86362001)(83380400001)(38350700002)(26005)(186003)(38100700002)(52116002)(316002)(66476007)(66556008)(8936002)(66946007)(4326008)(6916009)(54906003)(8676002)(6486002)(5660300002)(508600001)(6512007)(6506007)(33716001)(44832011)(2906002)(33656002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fDXeuN4gUGIFxk+7fYM9QuWiZvkZ7jWs7yV+G4weHJPQZyB72G2nJ9b8O4Xv?=
 =?us-ascii?Q?OcRLNGQKwzeRH3T/IAaCinUQHXeMFLIo+1RHKpwRaZ8VHuKyjgA5fyiynw6+?=
 =?us-ascii?Q?WGis4m95p8AJUcaIoWad6g+Ob9hX9xR6dUCnmBdczMh8qFxtQgjbajT6zg0e?=
 =?us-ascii?Q?3Q196p4Vq8N3XxDsdBv76qLU+XCxa3m024KX8OkZB2NSn1CWKBwRCTGD3uV6?=
 =?us-ascii?Q?yxMv9iu3Y8B6uhC64i0tsoRhXqBVyZD+a9Hv7+bjeStVi8VOzCjM3F5cYc64?=
 =?us-ascii?Q?2b3C7g01VXVFun49jcTqtGSH6hs3rqquU2nEfXiDMs8GPYFlQzg2MebcYRdR?=
 =?us-ascii?Q?emhO+sNexs8EXaICLgaIoH3YYLhZWa1OFBjLGt9L+G1WIja99XvzWYzRU0gi?=
 =?us-ascii?Q?vb1liG81AzjX4Nn3U38RGJGL2gsNjWIl4YDHMCGWnHIgs8gVVFvnKsjkptez?=
 =?us-ascii?Q?Kdc/yzhG13AG3J5KTaAf2jae73NY1Hz+FOFg8e2UfUWIQTRj8VyyClMY7v/O?=
 =?us-ascii?Q?h9C0D1vLy40IrUGgMhGPvu9J9SFrBtyH0PmDh1vVULdtIfW84w3jvX0QkHdJ?=
 =?us-ascii?Q?Ao1ph8TN5UR9YhkO9Ts76Y13h5QWzrsA+CzMN5Msb880/V367ccyWo1TkK+T?=
 =?us-ascii?Q?5n/t91KHdD3DrozvQpqU4GDEUX77N2oQIuKaQgcD+edvOCYjZsVua2qruyjM?=
 =?us-ascii?Q?AsoaGbDyxmHPC4WwYrUcchmOwOragR2a0/PAwFQO7UNioRBGT2NPrS+BGfRU?=
 =?us-ascii?Q?dkKJahwiJDRhbANY09LoTWab0Gk+yj9OyHdnfWuYUNYBOpyCAIadVx+u0tc1?=
 =?us-ascii?Q?DQXPm9I77IdqsaIq39DvSPlhDZhmyWLW4RB9zCqunpz7c26Sv8xQgRjg6WkV?=
 =?us-ascii?Q?/ruWOlrKq90WBz/1OWtqUAvc2MEh9Xyw7YjEvADqhGJ5RDlCsAqNWEcdwwyL?=
 =?us-ascii?Q?EPCw5ftPGHBvGFVi0AriUpS5jPF7PE3hmN59U7GNLSyQJfbrO63Sm8sotXvi?=
 =?us-ascii?Q?8UtdXodG/gpvZdJ5V/BjDxC2FjN2KIjT88lv4gJ60qQrHN3HWt8Xg83JEgY8?=
 =?us-ascii?Q?keR1+v02YNJLX79llZJMxJOkLYD6Z+gqAADxoB3wBWjBO18Rpn7DMqm2GG8T?=
 =?us-ascii?Q?DyTSmp2oVzLYiRaIkaqyiQGRLSx3UFTG7Uol583w6TY9/lzaiVDv6BYYbP3Z?=
 =?us-ascii?Q?jrOQe3IAEtoCBvqqUGQEym749/CggsGY7pDoVJZ9j1n0fo0t30NOkkskyBxk?=
 =?us-ascii?Q?Y+Zr9ryIEWU8tFM4cTHGfzJG9St/vseXab2vWOFs//y8yeqkktmY9lhCSm5M?=
 =?us-ascii?Q?O0Qs/yiEWICu8TjnLGpo8hpVBXFs/cAZkYxLRGNi5ttNYmut3V4e9qmdWV4n?=
 =?us-ascii?Q?+OrH10yvhMg6J7HB4B5KyNq+apHxGpNzOXNxRjkrUB1CCMSwDCtRYfufNRCV?=
 =?us-ascii?Q?uhqZag881UDf3LltZKB9I3wUJKvP09jc2VGe+uAD3++rqcH79tnwP48JAuV/?=
 =?us-ascii?Q?bWSj+8Ho47SvrzDgT0YtyKe5+xbn8aSAOcbOGpslv1zsw79kOrEliD3s3Kam?=
 =?us-ascii?Q?1ikcAPqXTnuz8c4c/VCcycyFpvIwMRVj1irKY/IIiWmtD0jFM1SMSg6OnOlj?=
 =?us-ascii?Q?8qmJJPz35HlTKHmUTAxzx73MfmXcqY8XJnFes3m1NDi25Naf8R+RK7raH/zu?=
 =?us-ascii?Q?gKu9SjmolzKett7bdJ3YbZBn22du+t2UYqtKt8fthVgHNZ86YQSNVDhEKXyo?=
 =?us-ascii?Q?iFcWxPlY/ooJI9iufh2JlkfTKNAjTG8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8097b286-f66d-4702-e94c-08da1d2060af
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 07:36:52.7459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsYMW+Py/35Yhyag/VCo2YHtuEzdDUeKIQNE9cgT5bokJPPrHfEOTUwdNHjc9VQflVDhs7YMuEHeK+rdZ2hYOc7kbD6f6yz3eJ5+qGflB3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-04-12_08:2022-04-11,
 2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130041
X-Proofpoint-GUID: al-kyz3Fh7SmAIEdutYMHk6nlMOGRIf2
X-Proofpoint-ORIG-GUID: al-kyz3Fh7SmAIEdutYMHk6nlMOGRIf2
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Keely <Sean.Keely@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If lookup_event_by_id() returns a NULL "ev" pointer then the
spin_lock(&ev->lock) will crash.  This was detected by Smatch:

    drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_events.c:644 kfd_set_event()
    error: we previously assumed 'ev' could be null (see line 639)

Fixes: 5273e82c5f47 ("drm/amdkfd: Improve concurrency of event handling")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 0fef24b0b915..15570e72a5dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -634,14 +634,19 @@ int kfd_set_event(struct kfd_process *p, uint32_t event_id)
 	rcu_read_lock();
 
 	ev = lookup_event_by_id(p, event_id);
+	if (!ev) {
+		ret = -EINVAL;
+		goto unlock_rcu;
+	}
 	spin_lock(&ev->lock);
 
-	if (ev && event_can_be_cpu_signaled(ev))
+	if (event_can_be_cpu_signaled(ev))
 		set_event(ev);
 	else
 		ret = -EINVAL;
 
 	spin_unlock(&ev->lock);
+unlock_rcu:
 	rcu_read_unlock();
 	return ret;
 }
@@ -660,14 +665,19 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id)
 	rcu_read_lock();
 
 	ev = lookup_event_by_id(p, event_id);
+	if (!ev) {
+		ret = -EINVAL;
+		goto unlock_rcu;
+	}
 	spin_lock(&ev->lock);
 
-	if (ev && event_can_be_cpu_signaled(ev))
+	if (event_can_be_cpu_signaled(ev))
 		reset_event(ev);
 	else
 		ret = -EINVAL;
 
 	spin_unlock(&ev->lock);
+unlock_rcu:
 	rcu_read_unlock();
 	return ret;
 
-- 
2.20.1

