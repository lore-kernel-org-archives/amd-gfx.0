Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185A6C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 11:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3718F22C;
	Wed, 13 Jul 2022 11:34:02 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361F18EC7D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 11:34:00 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DA37NU009497;
 Wed, 13 Jul 2022 11:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mhXHVRqOttDrCtrJCYiLs8D6cyTMv6x9mY6Ya9Bhqi4=;
 b=GcwCVCw3K4qzYHKjJ7mVH1fFvVh9xWjjE+rI8An5CtCtUPtWIVCZRJWcT7j4SvOFwktM
 ZBLOiTfllvbRL0MGzMPZYxHinvfhClgGnzZBmej2w/X6T1hZcERxO0F9d/E4+D3UBb17
 X0HkOWN31k6Bz20BtDPbjEwVEc5UYRWrq6190Q8vGIWBvKEZe9GwTx3V+oLQUz1n8+6S
 4bN0gSxHsZAQkO0tibieykf6jFiOOC2ZeDiS5Hgd+zeBBXBX9GQThT0AE4vUU875vmzv
 7bCo4qLkJLOn4muodya1CgNm5p5YapQbFuXkQSBvqqZ9JT9ywV4LipMl1x7yTT3s0Tc4 mQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sca0g4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Jul 2022 11:33:58 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 26DBUo6n037533; Wed, 13 Jul 2022 11:33:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3h7044ed3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Jul 2022 11:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs+wOBxub5r9226mtjClh/YHMyCT82+hgddTy0XMQW0kmGAx2PZDsJcBLmrEi0jG644fviI+AyscnfPQuRf8UQyci5h08IT4jPAV05mKSTlxat0Q1xlloaLnZuuC6+GfV+KGB/uB2KiifMv9rY1f9JknGJlQ0LkSg/E9lpDJHIm5d6zJe7gH+VMFXM5dmKdjbVoxopnQxKj8J1nXw9pNMqxMaKxbhxvWRadUdm3JSJpNc9/v+yJ7SVUHEA1c6/VsLI4HDA/mU5PlUd0zY7Ya4tVf7Gr0EXXq6V4HU7EhAAtvLGzINE4iYQf+JEtncXryveyKCmBjLUSfy4Mtu6Niow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhXHVRqOttDrCtrJCYiLs8D6cyTMv6x9mY6Ya9Bhqi4=;
 b=KVZGwDfOX9IeTkGLS/XkpdWkAescR969KzsSd/0fIgmqcIbEAw2Nb1twaEQxdrH3kXDSrgquV+nwpsobd9NNHciVpjeUZS0cj9PpRUKG7Vjf4jZOX5bbxGoE9DU+ooWzK1xNPruFu8uEa8322yovZd8s5PAr+Q1NBYSwLWyzLkuOtMrZEvx27X05TtshAfxEUnQyCmW/C5uiXcvqWMJsPVS36/mvn5Rp/8fbfV7u64jlISFbg4Wj6RXgqeRi7w10zJU+QzvTEqABSJiId6CiTwezuuX1PXNW+mMvDYWoeAJXU3KXEdySpwLq3JEtK+UKG3+K/u6YgM+nJZjulvavvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhXHVRqOttDrCtrJCYiLs8D6cyTMv6x9mY6Ya9Bhqi4=;
 b=C0mVsRejVe82oGXaf4kCorwwyP3GBhtGxRS4PirV1N5qWh4wAGrDo4vxhmjMxxE7CqFaPFR0yQua+TEouj4td7VqwypqZ5JPsGGd6vof11vvpHLIDTwCxmF58teElefptIKN4hQP/Wi45dSn8imPmGNVKQOHsKkuBHQj+7caapQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4048.namprd10.prod.outlook.com
 (2603:10b6:208:181::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 11:33:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 11:33:53 +0000
Date: Wed, 13 Jul 2022 14:33:37 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Remove unnecessary NULL check in
 commit_planes_for_stream()
Message-ID: <Ys6tkVXQeJcgeZn0@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0121.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a066b9-65df-4483-1ee4-08da64c3906a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4048:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6mhZWxbV33R3MwGlyKTNuIY71VbVNtTEMycLcNB7WYjvJm+hyoZmasvmpAKL7JMld2eub8DIG9qJjKk7eDLYAu5Tg4kCdBA5sdueqmjLjS1qCIGn947pXYRxoaqn5IrcY1nABF5RvHdVQ3oSC+8m/H3dJL9DZnyaD8OJketlAYMXFpflKilBwojhYHSQA+QZH4JvPgttDvh/DDccmh8hUEBK+o3SKTUBcVmdWckO181ykJBHHZm4R8d8w59XasTRv6nU0AVY4kt6WZliumu5KZ0ZkMorZy3sniiPi7ukdB7uJXy07xxPJ3Tccg/YkjfapSnHJKhJT+C2YyYUpPFpM1MeXZMJoaq7/dtQEluMe8sF1aMWFXR/dx3ksIqNi8yhSaVkteiy3rlH4zsiLNMez5rFV83ezXpYzYvSLlbBkg/Jtr1oolO1sKHpIc5ytV35pI+26xYG7Y+fMojIy7NeD2JK/w9+107WLD2SoPzao3KLMn9xxaNl8xXy7iM2oQjM7LHNACd33THFGxsSoxpjg6mbJeChhe6qz/vL9JIPOS58au0M6whX5PLtgMNh+KL8LqQrl2nJOGhXFvwejJU4o0qHavRu2W9a3qVsD9Cll9Ui2z08w5+soTsHY3sK1/V4yZL7Ei6qac1+TNeGDbjArGUVKQMplpd/aJEpkFDgWdxsBHBOrHNGYGMYiRnKUHR8AtmEoUCIw6C2sDsJSJUatgj3kSDyndKxz/7M0e0cm8VQLW/fliUn8bUefTrpVcIzjeBJMAyJ5UfLcphOGwl02nHrc+spX3u7VLzvbYRv4yS6GEIcaP3dyBj94WVE68v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(396003)(366004)(39860400002)(376002)(136003)(346002)(26005)(478600001)(41300700001)(6506007)(6486002)(6512007)(6666004)(9686003)(8676002)(66946007)(66556008)(52116002)(86362001)(66476007)(316002)(6916009)(54906003)(83380400001)(4326008)(38350700002)(38100700002)(186003)(33716001)(8936002)(5660300002)(2906002)(7416002)(44832011)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4swjz4Dd+cyBqHc2ncz32CUM6Z8G5KCclDDE/ZK9DzrMMIEHsdqu3jCf3Hsd?=
 =?us-ascii?Q?+vutMsKMVhXtlZyE7qQ5+OSSWQ7R3syRjbCY2x8+wZMs/qosVpfEevly0AJG?=
 =?us-ascii?Q?MbOHfu9VQAct9DytE1i1iHForbw1cEpE3JWhKM67hgKSuu04Za08mBDzKFxb?=
 =?us-ascii?Q?p/emjbxVy8e2eRBezQK5W4iiYRW8CehcSsdsHfwQZKzqfYvnzVMF9TXwEc5V?=
 =?us-ascii?Q?w2ecTIHuntxChRyd6ODWpkVQAcOvsg/HnXC90pwbTZpYB8EjPKKpBabVvYkC?=
 =?us-ascii?Q?skiLUYy4VV7rIoVYD0Y3fssZPhCEv3ieNaGrFQjLMgMQgUwgGmjQ06MJaskp?=
 =?us-ascii?Q?risaOckGz2ExkRnJ1rqTsLg0GTJ5DPXborkjwT4NvfbOnff+n97FW5NNARTZ?=
 =?us-ascii?Q?vJkJYII5IkIfMXj2QSofuh3fP8wMaITswpQ8uKOstlV+2l72QLMCU0fNnnL1?=
 =?us-ascii?Q?9qlBYgar8cJmILujoRn+2eGNm8vApvHo+yXBSo+D0bfBLRV4VP4Du3yM+erL?=
 =?us-ascii?Q?59T9Ofy5ZB6oKTQKCqC2n8SQbQt3Tzhcg/5GYe/u9S1uzNRqM5UWnTcyWiMT?=
 =?us-ascii?Q?YK39w3lUpXiGXCldVUQMSOyEP9jOeqj11UHzSy/YqTl5Q1ZeuZB1+WDyk3uE?=
 =?us-ascii?Q?VBhIv2RlmURIVo0qJYZIeHMmMsUbxidW2yVemrq0j3idDAsdYE1c6jXrP2zH?=
 =?us-ascii?Q?7LuIfTFTazcmEDIhvU5jaSnOEN8kR2sb2TZGX6uZbBt+a0eOquFkEzvHzPl4?=
 =?us-ascii?Q?dLB6SBcjjBtL+qJxi4LEIiSr4nzRF1HjqbJiurklqRGJmWOKYCkQpeQg7gyg?=
 =?us-ascii?Q?5dlpZE4zkXXbCPaV+CVJvq4kA056RcHgrgebTiCMWe2L6vMkkarw8WhSMd+F?=
 =?us-ascii?Q?YPANlgn+FY/1Ts/ukeJkNuMtGucyzdyK6WXh8bX121Lo96zWT1ts+q2XkWcw?=
 =?us-ascii?Q?k2oSjInBe0y8BpYYHhBbO0BbJcl4KTwUiHOirtmQbRDNOvOlQiIqJxd3vsrW?=
 =?us-ascii?Q?9dTj7XOXgbNG7JrXrv7/+jgEDNjoIcYS/nOXtZiiQjPC/oDgJkuKhZC/HPAX?=
 =?us-ascii?Q?3LRHTiOgGQ1KdErWDBiieWzYGPnDAFl8WFLiarqjdYsilG/N42wFUM2Z/ZoT?=
 =?us-ascii?Q?uPTlYMUReIwBDGNaawHsFDDjkN+8tw0BKoA2MLP9j3Xvpu1+n5uM+OMyHblr?=
 =?us-ascii?Q?w44LAvz2w58GvrFSFHARM+8PeD6wSLACk5/F+wvFDjyFqAe6fkMKvfWgcIKT?=
 =?us-ascii?Q?k9ntFrixJfp+YXYER5+OpUXtNhjAIM5V3yzfSDRFEn58JT+0iIsyG0heYPC2?=
 =?us-ascii?Q?rXJnSzDv2aGMAfN4zSMaKkGPbRimtDJP2EjBbe6DqjFb/aBTWhU7GH+DPFUb?=
 =?us-ascii?Q?OL3as8dvh9A8DZsU9/OXoWDk5fIN+SjJVxQ+LQ5b39wKL1F1wGfmvWC8NHBp?=
 =?us-ascii?Q?oVqaM8ueILlnIaS2FmeHNZXjGHpDW3GvvOuRuRLbWsoalEBfu6VaaBBlXmbR?=
 =?us-ascii?Q?ZmVbd/jDHx3byDUZzILH6Ne9w2rqchdaQyb0xCQtKBFpnitCr7ENJGrUT+MH?=
 =?us-ascii?Q?yqPQCnqxpLK8qwTUCMyPmyweiSK64t01sJh0WEobS6PR15huqq2LaP3CXfIn?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a066b9-65df-4483-1ee4-08da64c3906a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 11:33:53.2807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPYNioBxUuoYGPoMpo4cynP71/IbGLs4810fuz/EvT1yLNHrJpy8YeMYVYUo0iIeOoF9Cne+AbjobNlb5bEMAguHOdxVGX33jZsuHheZL8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4048
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-07-13_02:2022-07-13,
 2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130047
X-Proofpoint-GUID: YF5Bs4Et4RVCrY6pFMP5G1S2EkuLx0GM
X-Proofpoint-ORIG-GUID: YF5Bs4Et4RVCrY6pFMP5G1S2EkuLx0GM
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, kernel-janitors@vger.kernel.org,
 Alex Hung <alex.hung@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>, Roy Chan <roy.chan@amd.com>,
 Michael Strauss <michael.strauss@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Martin Leung <martin.leung@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Smatch complains that:

    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3369 commit_planes_for_stream()
    warn: variable dereferenced before check 'stream' (see line 3114)

The 'stream' pointer cannot be NULL and the check can be removed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc2c59995a19..76f9af2c5e19 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3366,7 +3366,7 @@ static void commit_planes_for_stream(struct dc *dc,
 					top_pipe_to_program->stream_res.tg,
 					CRTC_STATE_VACTIVE);
 
-			if (stream && should_use_dmub_lock(stream->link)) {
+			if (should_use_dmub_lock(stream->link)) {
 				union dmub_hw_lock_flags hw_locks = { 0 };
 				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
 
-- 
2.35.1

