Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4702C00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC128FA12;
	Tue, 26 Jul 2022 15:48:23 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF1E8EB05
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:48:21 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFY1rg032004;
 Tue, 26 Jul 2022 15:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=pd6Fcz0eqpqNQnWxTaBCaqvEEvyIRfjYwsdpBntlIgo=;
 b=WCRqSIkAQodiBrjsghb6qLZWLC20tdXTeShZzE2hzUEWVMctm35MdiPlashfCEbls8pW
 015hFr0zKZ58bS9L8W6+9vGXBEI6OKU0bh6ulzot2RoTMVz2DPRrJL4/Rk9B9IDGhQGy
 IzQ9d8WfJTTk/qVQB+IoxTsUOYXtJMD7RAEME3rv0o8bWII+eaV2uSvkiwr/5HD6n1We
 xOjPnh49+qc0xsxpKd4HCkT3RgGOsbRZOx4+5SQGigX7k7hu5X7lIjgJ8CBUBn6hKG3f
 eutm2Cv4X6B1rDxp1rEMmg9BumCa9pE8Y7zG/KeZZBNd6ZGRVCjwqeLpro2rBoxQ9T/h Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsq0gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:48:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QFl7th006339; Tue, 26 Jul 2022 15:48:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh65bp8rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzvH2dHr/jvyrH9KN/LuQlrQjFSWdT2+TcV0JdGiEaDN217MQ3B+PlLy9lAJy+NxiPYztYeKwBb29VNNBPmJUMMLtdIGYcSrvJwZq06IDc3JQrbjeoPNl16W2uBkjIEwELFqKYtYWUHtPYBZqTpq7aUrePlFBtK2w3fNSqx9yXteF9fBUM57k4oMELRWnZNrBizsqr3gY/baVAN+aOrHiUrwlESWgxP2IcwuJoGRGOJih9CJbiC/QcRzVsA+sTGimTMASyvgFfVwvdBa3p/VEXBvLsXur/sHaK/qQiDUdZYhhuTGxMiorZrytlYS7We8YUti7f7DCntyHJQI5XBmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd6Fcz0eqpqNQnWxTaBCaqvEEvyIRfjYwsdpBntlIgo=;
 b=Y/AJ6yhlbsD942lxjxY8vfT/HlaxJxBWL5CwxhrZxK5ulyJ43XPTJ7RKGbkHVkrguTriVLQ8pALyYoFGL2UPNIS0TQAGojq9AHbAdf6ielE4w5NhIBiQHut0QyPolYzJ8B4uoUpqDbNZN6XelsLktt0ZQtF+Uj7nI91mpgjjuj/+wHYxY6xEp/YRhJqZKIFWRuvh4L30TzJURbFpW6Ymc0K/ScreJGAX59TC7Yc68wQBt9lPzPRjlqMcOn7lDxKugFLkJAFggRXxJ3RVxvn8iTSUImUejGT/1Js/aKk9LfOCyjtf8zMVah2u5GbBmZoQFjNsxxy9fmuj6u9cP73PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd6Fcz0eqpqNQnWxTaBCaqvEEvyIRfjYwsdpBntlIgo=;
 b=owBtLwaamnGBVi9cpJ9RoGZafvCP5JEuJi8MP+A8xGTRxFxZpOnkviYp0+9eYg6r7Kc69wMZ581xRyeIISUBhGO95m6MEu0LtxUS0SDDtW8rgjWG8R1FABT/bYiRwzRmXhD1j/MiSY5XQ+GNp+xiqpPqc8KwnWMxAwweklEN2Ig=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2339.namprd10.prod.outlook.com
 (2603:10b6:405:2d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 15:48:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:48:04 +0000
Date: Tue, 26 Jul 2022 18:47:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Simon Ser <contact@emersion.fr>
Subject: Re: [bug report] drm/amd/display: use FB pitch to fill
 dc_cursor_attributes
Message-ID: <20220726154748.GQ2338@kadam>
References: <YuAGLYvbtrrgBH0U@kili>
 <1JPWbfs9ltu7lsg8hK1KCCiKY9S6tjFGGGF13vR28hS9_FtOSHoSoS9rmHM4suOoa9fs8H8zcQiz0uFiuCpx8uOfV0CoRKBVwbKp8rKeozs=@emersion.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1JPWbfs9ltu7lsg8hK1KCCiKY9S6tjFGGGF13vR28hS9_FtOSHoSoS9rmHM4suOoa9fs8H8zcQiz0uFiuCpx8uOfV0CoRKBVwbKp8rKeozs=@emersion.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f6967c-9e0e-4a43-0bc6-08da6f1e3a10
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Tf1KscIeUVBeDfpDyGoDoA0BoWnbPi00l4987W7JU345wkfzCWpWSQPz8kOQXtTOBQyjwRifJa1VQ/B//RHPX86jCDT0yhur26SUtQcsiXrR7Ckl9a8Mm8o6V9xMynY7ybcE5yF/wfDPmCnIcQTBSYJPFx27dX5mJmK7uv8MG7if7//ilT1fOBo/z0h84PWQxp1bd8ns+4ssITtwpocR2BzQ0sg5xcjhpyfuyksvPQkXh4Ss/q4rH7vuH1uz7tvJlFcNKvaShqcPKiCnKzyHkAwwE/N8o/BQCncmCFA0VOIU3dz2ydQLRvesCq/1qMtc7HyJgE/cZfnQxjLFXfYUG3qxy5YBdDXAfnIjAloY1vmDUlZIow7ExTg5x2j8zd7A+Mr5SCdGB0nPzoEphWHSdXZybCjBUVJSycI4zWyFeOTCXaIhvhGl9iI1SGnP0VrqvzFJcNKLa+ng5oIBVChojlwr9xZPnUhxONIjAi3JdGvlPYwOGgjpx2BbkVmlpWHpfeZFMdDNStbyJn61qp13E08+FxcPNCGaM+jG4f+8kNrm3F/xaEH3kMy1zo2Fa6trN94obt0AIZyyXn8iGwFPsQgifyMOghqTzVoiusTBh4f2tqfsQQ5MNcpKQB+E+f51XYpBlatvoY+KCB4xlJw74ztTPEFzGJphm1Kbvc/4E4YZsaBVts1bVmgoYjIdPZeqwaEImSdDFsNX+OBhX16AM5R+J9G09NRy8Zpna28bJ0leF/yXqqHBpWt/e+EUzh1FUFWgaVNyWPfzKQcTo59+rKEwmyYjXKFZNjmci3KAjhDBZu1x6Td2QMuOWsC9A93
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(39860400002)(376002)(396003)(136003)(346002)(366004)(8676002)(4326008)(4744005)(6916009)(66556008)(1076003)(66946007)(66476007)(478600001)(6486002)(52116002)(6512007)(9686003)(44832011)(33716001)(2906002)(26005)(316002)(6506007)(8936002)(33656002)(6666004)(5660300002)(86362001)(41300700001)(186003)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xczUXlYYzpEqpUWP+2rQwc1yl/KSWjrrIz/9UvSBBzYgWZ0M/2ko0nNDyvzc?=
 =?us-ascii?Q?TxtShPVqEGIEylDxNCyu19aGi7PnsaqekEfz5Msnpusg6SuSKbPu9DXAMdWm?=
 =?us-ascii?Q?ZRGFPZ8K0xpJ890qsKXivQ8XmLY9gyKKf9057VHChsRarBMXPoV1GIzYr3ck?=
 =?us-ascii?Q?mSZcqCVzwfSPSg6KSfXBUP3l1ptLXJ8+WCFOIcDJEKsoqQmnoZ3+8u+4nsma?=
 =?us-ascii?Q?f1+PsSjJEGwdp2+q+yLdX5JszK1opy9NfMKu2RHuvS1caR1GPHsV++j6vvx9?=
 =?us-ascii?Q?i6LN8qr/e27OaExIG3gUnX8sE3NGkWq3P4asu0glhJUVuWXA3YazagTK0+Yk?=
 =?us-ascii?Q?/FYglrfE4LOT2rUnmgJFHUfjGTudNUExcUFEvk9jZjp8CsI/dMSDV6UmBD+T?=
 =?us-ascii?Q?B8wFYPkZbw4PTq83nK9sdpwKxEL9j6+J4XS45ca1X09dKayzToLeWtAvac8g?=
 =?us-ascii?Q?Etr6M+I13yXrRCggEpPs1GrpHi4FwryGQnHA50XeyMDd3N3QyhUT8tED4R/D?=
 =?us-ascii?Q?2s+uGPWP4A9IWr/hOTuWWcSeKyqFD4cjGoeg5HQfliIuHDhM9QQqnvtf06g8?=
 =?us-ascii?Q?cQIwdfA7E2pL3Upa2xFEW+j0YC8bbIAJt32zpfmXNmoWzwdcEzDp+hzN0rTJ?=
 =?us-ascii?Q?34me9PHieFUvalAG8tq3G/ArWj4jgU6pjpfpRl4OxQtaqiz081CSA9PAvrFx?=
 =?us-ascii?Q?Mc+d7mQnMRHRLSJpZ9OUdmevXc4yjm9x2vJugRdyEoMNG36d9IrZavDubvi2?=
 =?us-ascii?Q?PNQe155euC9yTsieJEDiQ6huIxUYnUFtyLAaZaT1NVVOURKQV44Cturu6EO0?=
 =?us-ascii?Q?BS+ziykr+5qaMpxtH+C/f2d+VtR67pSIDwmIeRV+AYWBbQuUP6WwvF/tyKaB?=
 =?us-ascii?Q?coN7g5oDwzXoUl5cEh/pIycjDqutekwJFUfqofvpIYuVvLh6woES1jZogZ24?=
 =?us-ascii?Q?CqFbcvcqb/fV/eGw7+3grNNAq06LxOcpDHcTPrJZ55iUmMmmLgw/z8Ja6UT9?=
 =?us-ascii?Q?BOssVhqc1H2VnOiAmQ6p7vPIGGXhX3NyAUomM1mc8z8NGyU1bLjqRmvjPGko?=
 =?us-ascii?Q?HNS2zPu/FGGsQXbgthxzriyKiCz8UhfJKRIKUqYRZ9dJuIMuzMKihNx93H3n?=
 =?us-ascii?Q?ufogmEx0XkYdLZ82GhL30n3GLWqfQLONF7MTSwY+1Nmf95s+eaQIQRS8iZ/Q?=
 =?us-ascii?Q?mxgosfMqvft2v+mxaeIQQxdnsksdSeI49gIGAq3MOaY0VnNtc4rmWIU/Uhf+?=
 =?us-ascii?Q?4F2Gm4R1iQZhZa25bQjyMwsxrNNQqNSLTKLDjBvWe1B8owq9Qf1MHhYgbiGt?=
 =?us-ascii?Q?iI7WTWL5oW6zODOcjytgZ/Px6l6U+69t45Eh86ZYVvnrfuhL5hpKUh6AFt47?=
 =?us-ascii?Q?Wl2v/7pUi185AaQvDfpMqBhSMbGyWG0ykP+k/ytv2QLUi8RrsSC7tuK8q5qV?=
 =?us-ascii?Q?lnP1UY1A+BTNtmmPkJeRNcnXp21k4aHeo4Ehtt8SR0PmY5IvAnpBnrO7svXf?=
 =?us-ascii?Q?MbQsYpvlAWmoRxgQx7TEPmz5Z6hGJukR/WLjvU57Wc6KAZnbx/P3SrlBB6Cz?=
 =?us-ascii?Q?n7HUId1lLA2x7aC754pbq3MXMnutwy1hQ7tS2bKbnBEdNDrjlsT2LoBmcUZx?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f6967c-9e0e-4a43-0bc6-08da6f1e3a10
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:48:04.1116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McRjBhNY7Ez1I4GAhV1Kd/dqD5XelyNXrztBWO6Q+ZXC9bIavmN8x5dZnG27N+1F/uoPrGLItGx845EHY94eZIloDxtxC0hF7Ef3wPDADxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=942 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260060
X-Proofpoint-ORIG-GUID: 40q3KZwHiiAzGBgD8tGIZb8ooBhS6D06
X-Proofpoint-GUID: 40q3KZwHiiAzGBgD8tGIZb8ooBhS6D06
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

On Tue, Jul 26, 2022 at 03:27:54PM +0000, Simon Ser wrote:
> Hi,
> 
> plane->state->fb is NULL iff afb is NULL. There is an early return to
> make sure the dereferences don't cause a segfault.
> 

Are you talking about this:

	if (!plane->state->fb && !old_plane_state->fb)
		return;

Should the && be ||?

regards,
dan carpenter

