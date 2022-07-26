Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D95C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842E68F29A;
	Tue, 26 Jul 2022 15:20:29 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D3B8F20B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:20:28 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEE2pm021314;
 Tue, 26 Jul 2022 15:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=drh1yg7mvu2uonjAG4+w7EMslfkWo/4DPP4hrH0gLzs=;
 b=j5ci5VzpRdxtpAFM0rraeBd22a0hwW2oo5y2hHF9hG9owehCzxSBpjGgnTcP/6wFD2cb
 li34L23eHk4OLQEPOqbrZ/o9pQwaf3XIEH5XI8hJkQfivb6xi43+9aafKRu6NPZfu2zr
 pnJ094rlUUlOk+titCKU7mHueUf8ozFLa+AIoXqddV3hkxUUFHe8xk4iKFXyfKu9GjpS
 iE2Sm0TVTqnlD8JOhDWNY5jj5NMYg1Yi+BIuWh5FPX44sSPvYw0FKAiO3lv3Uc7kPHNo
 vcxy344lnkQdxDznOV12TPrQaXGOWD7sLLOAiV/MqjuaIrzjDTpo8wHO2Ps9fSDTDPcd vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940ppjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:20:24 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QEe2aq031577; Tue, 26 Jul 2022 15:20:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh64ry5g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYZyWKEa0t4abNuElAym6Tfw/o/GFMqhIhhkPWxHrAHSp07EK2V7XYF0q3sMJL5tZ9CC1QRQE8QkLUJ/MSmwF2Xgo0HOkmtYnvNMfwgA96fvOqFYaftXH5Nwe9vF5WhdGOT29ZaF49Lux3XyV9KdVQ9tZij/i0XsCKPuw4qurfN/kXXJtZeTtwzNR+P8L2N8gcJF0lxFF9/GmelCCWTXlRBclUPnCQOh35H/DgQpuvteGZJu71IsSeHitK0d7OUu9eWFEMRTRpzquO5ozjFv9tMTzdJY7iR2OmCIgbd2BD15b4Mae8r3c9O1nn6AtSexhcV4Dx0F6uLM5HUl6v35Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drh1yg7mvu2uonjAG4+w7EMslfkWo/4DPP4hrH0gLzs=;
 b=dZKGS6RfsdeR8DmXf2vj7jRscdqqdE4YtYF5BcYwc/fOKgG/FJiwHycr4ZlVTruPT9n9WEkffVpvZQNp8uI341uIir1k8RLWEYUzjHCsgsEjW3QLcumz9c8WqzJgNEbFJeliDVtNihvAsonZygwKDdyRcHn6RC9YWkxcPKJnqJHQvZ1TsXT26ID2tppJiMlhV2Q5wrcZxawxT1MUJqC7y6U3wOCXtiX5RcQc0616VdttBwoHSWhhtGWCfw2BL3e/tob6d0aCoHUs2ip/6yxmWXrTaw6ed7WPfwblP7NjGX8fwLKh2UUTGWq74ivI7BPQS5cZthSXIcfnidEJkvYM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drh1yg7mvu2uonjAG4+w7EMslfkWo/4DPP4hrH0gLzs=;
 b=t9SUwqp4LhI6LFoy9HyS9dYxNlxp0qWana1zw3B9OJEtsGiYJ7Mi/t1XmUTOXbH/jEdkNx0Ra8pRDFzcmQLd99w4H9DHKN5PmuYK2hO/11AguDZU/kCLbk/YC1qV0s84KtOg5fBujT1QxoT4dDQcIHYsTsFKk5VbnnGy+c1HJO8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3288.namprd10.prod.outlook.com
 (2603:10b6:a03:156::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 15:20:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:20:21 +0000
Date: Tue, 26 Jul 2022 18:20:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: contact@emersion.fr
Subject: [bug report] drm/amd/display: use FB pitch to fill
 dc_cursor_attributes
Message-ID: <YuAGLYvbtrrgBH0U@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb612b28-1074-4026-47b8-08da6f1a5b28
X-MS-TrafficTypeDiagnostic: BYAPR10MB3288:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: megEkOxas51pxl+vN3yQO5BS+S0QwC5MOi/aqZyrbMIp3S8vxmzRCxj8V2sKC79toG5gP6ibj8SX452xb8rHyzuWm7gr7lKHrZz++rNZWUxZH8umZxRQJuMeaI44HqM2F53tl0Tbm1pU/Pih0NnpEou9uj06hM61nY/qZINbvq59dj0CX7QWJo9TjR8hPjmD3PF+a9t2S0rposdi/f/qNLDhbmgqYfLiO1AnpaVcHYNP99Z2TVG1PWrS4bwI0aahnxbElMuGx/32mFZgRgzro6cibxBck90wc6YuQUPEph/vp2Zg8SHiczYzUzvDIn7EERGEThQCdeyQ1/x9I3mEVIthO7swAqN6zOMhM+UzkWqjvq/2Szxvvirq2RuzNv6UwPjTwcGT1fULnhIn7foY5kteUhRiTr5ephSxi5SJCw64ox8k3g4gHTkdAWzILKOnLPiBrmt1MmQJRexgso+zgaqlEfPr+GvcL+hwrrYqhPjxShdieFJG2267fuSOAgwtuYFruf4ZBb24zIGY9eGxnIu+kO/o1HvLrhrC+pgkvJtdGL2xL+yRUi6l5ChJEPISi+ZokRAUN0Hw8w2w02tbVhfN6bJKg9R7ZW871sU/a62AuBy8Z/oZjCYdLsJhfE7tk+AuXhmSSlfsIRrW+2fSatU++Lj1E+lp7HeOFSiJO3lbYQDURBDIMgH06GncdZj+FfNFWW8JrAOEFh+H/GohYBIs/6LBKJUD1CGZTYvTgSiW5XS2DdYR05JWZsDFuBmEh/lL7pH2v154naSLy1g5+UlltIydTkAqWcfByjhfLoJu9OqZ28K3eXtjHx4OeD1D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(39860400002)(376002)(136003)(396003)(346002)(366004)(5660300002)(8676002)(4326008)(8936002)(44832011)(6916009)(316002)(6506007)(33716001)(6666004)(26005)(6512007)(9686003)(6486002)(86362001)(41300700001)(66946007)(66556008)(66476007)(478600001)(52116002)(186003)(83380400001)(38350700002)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWE8iwqm0cUxfo/8kke2cpt/yI6goXJdLZ5kKiFk0gu5POlRraXTUSe864Eh?=
 =?us-ascii?Q?nQ4AlsgujBKq/ueVXPY3npao2qANesU8KrjclM4h8MmaPfeMCrKcy3gu6wdX?=
 =?us-ascii?Q?LiYbmIO4v1Krd0zyTRSKuz8at+3vwcNBJD0Dztfhliq5LyD+NWmN/6h3mtkZ?=
 =?us-ascii?Q?E8laln+TouSD+E+SyCzn8WoX6gSpFeKbk/vSTJETs513bvNai+KfAgbyNbQZ?=
 =?us-ascii?Q?CTL1oVo/g7QgddvDDYNKCVmd9s4uHwBGYnef10ySNNKkiunaycM12Ht5RI5N?=
 =?us-ascii?Q?mQA6DhzWacNtY7O4juYmnJp9JfqR2b5+vlk7opCx7BEQMNTyRU5NgBOw7sE+?=
 =?us-ascii?Q?0jwmwyik6TErTArWbg+K6UpjKp5CQW+N8+dZbAYgqykuLpZwo0+dMgYkb9m1?=
 =?us-ascii?Q?sttbZGICZZylMl6poen+vO6a/MbQxS0KwTSkhuatncU3Pqkbdlas696CxsYa?=
 =?us-ascii?Q?any4IH5aLyM9P35r/0OA/czG2aNHk/8y0EFf53anvVIXS7q3bS6dzRd3FJPK?=
 =?us-ascii?Q?HPYmQwDU89+2asVjCHSUJu07EltbZcqkB9BsbaWc2QChoOGMe2jJtH5mFWgr?=
 =?us-ascii?Q?O9W4nbedW2MZGyDwHGPEdiM7dXCOMSgXEgfovcwB+J2Iis5E+lHnGJQ/R6hP?=
 =?us-ascii?Q?EoYcjD0aJbvYLlRzekBk0cKJXW34/yzgEy5hmCo/QnOc5nLwoY/nMFctKzV+?=
 =?us-ascii?Q?HosMX0uWvybtOGlsMKrlS/uvx5AH9M0bBihAt5dn/tWuGCHZthFWBPnjSFtN?=
 =?us-ascii?Q?7kzzVpaLQ+4b2IegDUwbQvQOy+uWLgIVDVyP7Dscx3Scj7vTdbPcGgbvdow0?=
 =?us-ascii?Q?VXXK00EsaNOorOJCNdYtPYZoj94AzmJ+KZEPFoJ0YkqD8NNdSi1tXVSqpmTn?=
 =?us-ascii?Q?1bgheExaW0TdF8vaRkfpGoz3iCDYoKMKiaa29lMO6XS/4WlcmnVhokvppVb1?=
 =?us-ascii?Q?w6U2gjv8Yll2kTj9TfNhbPawYIhgP7GV83O+AZ1n+t6IWYJzO5BOaz4uZXpd?=
 =?us-ascii?Q?DJTZ4fo3nrXVmbcYd+LgPw+nSJQPT0rE94sxL8Q8Wj/mcXfyo5/QUTuAqikw?=
 =?us-ascii?Q?KkW6cAP2uq+muCYFgUQ//jikg935XLg7NxiP6hRENed3gvPoC0LxVhpVX+gC?=
 =?us-ascii?Q?5HUNvCFsq2ZpT3I7y5YKxmIMEFZ1bdYxy1+wNp9fXKyHeTcroJnKl4GXpq/c?=
 =?us-ascii?Q?SUxfoIH+tgW46QE5/KTlSFi6GbJjahtaid8Hg8tCt+jdfjSP1YRfjJvySpMN?=
 =?us-ascii?Q?qFcFIhB3rzIF9yBdMkHlseOWd37CJQDbj0hnO4Ruguzg5YPm1PQRj2C3GQgC?=
 =?us-ascii?Q?hmtFnXsxF8vQYApqASPSXVdvRrWglF7TPoe49ukOiXzPsmFQUpJYJhgzrn8o?=
 =?us-ascii?Q?kTZDNcg7PyV308eUjFqNOf7HP1NDHgb4v1/znkwv8opqVv3UM+F9pYGYiqRW?=
 =?us-ascii?Q?6DMJttYHf2YI26tZoTPYCgZw7Qgy7sBNrFxZt4TFW7Cn5DKtcPF/RmFiyW0r?=
 =?us-ascii?Q?1aVXrptvD4CKhzkpMLn5jFK5wjd9CwxE7XWFq96zJdoGRJVlERpUs5zXM9uR?=
 =?us-ascii?Q?VZoFmZatelnNbNx/yIziobbD19ua7dUb+f8ddRKYzqhum6VeGGVarQwttoKR?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb612b28-1074-4026-47b8-08da6f1a5b28
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:20:21.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/+2pZRSX5iTvtbw6Q+nfCu/PDesGlyTtxRo0aUBSjtqk8lmCn20LYfnhopCQc+u/M1DZxOL+gjFm22dkRrFj626sI1FTRpFpkU4ms65lAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=716 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-GUID: yJd010lf5xEVLuVQveqmcmBCUjKJyT4u
X-Proofpoint-ORIG-GUID: yJd010lf5xEVLuVQveqmcmBCUjKJyT4u
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

Hello Simon Ser,

The patch 03a663673063: "drm/amd/display: use FB pitch to fill
dc_cursor_attributes" from Dec 2, 2020, leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1271 handle_cursor_update()
	error: we previously assumed 'afb' could be null (see line 1230)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c
    1222 void handle_cursor_update(struct drm_plane *plane,
    1223                                  struct drm_plane_state *old_plane_state)
    1224 {
    1225         struct amdgpu_device *adev = drm_to_adev(plane->dev);
    1226         struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
    1227         struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;

afb is container_of() but it's basically a cast in this case.  I would
always prefer to check "plane->state->fb" for NULL instead of the
container_of(), but that's sort of a style debate, I guess.  Some people
really like checking the returned pointer and add build time asserts to
ensure that the container_of() is a no-op.

    1228         struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
    1229         struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
    1230         uint64_t address = afb ? afb->address : 0;
    1231         struct dc_cursor_position position = {0};
    1232         struct dc_cursor_attributes attributes;
    1233         int ret;
    1234 
    1235         if (!plane->state->fb && !old_plane_state->fb)
    1236                 return;
    1237 
    1238         DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
    1239                       __func__,
    1240                       amdgpu_crtc->crtc_id,
    1241                       plane->state->crtc_w,
    1242                       plane->state->crtc_h);
    1243 
    1244         ret = get_cursor_position(plane, crtc, &position);
    1245         if (ret)
    1246                 return;
    1247 
    1248         if (!position.enable) {
    1249                 /* turn off cursor */
    1250                 if (crtc_state && crtc_state->stream) {
    1251                         mutex_lock(&adev->dm.dc_lock);
    1252                         dc_stream_set_cursor_position(crtc_state->stream,
    1253                                                       &position);
    1254                         mutex_unlock(&adev->dm.dc_lock);
    1255                 }
    1256                 return;
    1257         }
    1258 
    1259         amdgpu_crtc->cursor_width = plane->state->crtc_w;
    1260         amdgpu_crtc->cursor_height = plane->state->crtc_h;
    1261 
    1262         memset(&attributes, 0, sizeof(attributes));
    1263         attributes.address.high_part = upper_32_bits(address);
    1264         attributes.address.low_part  = lower_32_bits(address);
    1265         attributes.width             = plane->state->crtc_w;
    1266         attributes.height            = plane->state->crtc_h;
    1267         attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
    1268         attributes.rotation_angle    = 0;
    1269         attributes.attribute_flags.value = 0;
    1270 
--> 1271         attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
                                    ^^^^^                  ^^^^^
Unchecked dereferences.

    1272 
    1273         if (crtc_state->stream) {
    1274                 mutex_lock(&adev->dm.dc_lock);
    1275                 if (!dc_stream_set_cursor_attributes(crtc_state->stream,
    1276                                                          &attributes))
    1277                         DRM_ERROR("DC failed to set cursor attributes\n");
    1278 
    1279                 if (!dc_stream_set_cursor_position(crtc_state->stream,
    1280                                                    &position))
    1281                         DRM_ERROR("DC failed to set cursor position\n");
    1282                 mutex_unlock(&adev->dm.dc_lock);
    1283         }
    1284 }

regards,
dan carpenter
