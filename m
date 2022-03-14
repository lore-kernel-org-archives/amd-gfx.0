Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A99EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 14:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C34B10E2AA;
	Mon, 14 Mar 2022 14:04:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05DD810E2AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 14:04:40 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ECSh4I010727; 
 Mon, 14 Mar 2022 14:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=WKQVNOOTO4PG7jGnuaA7t1+Whfyh8U6Vnj1jhvOMREY=;
 b=OZvy9N3D17uD8NHivWZ/fLn3Rdi4kYmARfIf0xsEikHVl6SmSn6d1C2HB1OCV2KKzkq/
 EF1JvNy3kMeXFq/Vx1C7mMB1A9JUo3kDPyUMx4ZumOiCJwp2cpRFcWUL62c6vx6LehbA
 iUKUUS8Xv6HeU8H9NN26zIxlKe6t9ijdYF94YX0kq8zW9nIyhEzWrJX/MuQmSicE3pOX
 EMeBqm46PaxiYFwBxn783afsvuTD/bZAl3V7Jszcm87lC5NN7hheU4PqEPmsYekzoA4R
 6SOaemT5Uw9iTrnh+RcyJDgu8ubFmYRnudtIyu08tK9biRBNMTSnl72tOlfha9atQra2 Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3et5fu0b1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 14:04:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EE0jnl105910;
 Mon, 14 Mar 2022 14:04:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by userp3030.oracle.com with ESMTP id 3et65nt04r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Mar 2022 14:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdtMp8XMdPoSPBmEC3ZZsMvWMgV0sFBq9O9IAozQRi52c7JS+IZsTgRJmO3annKYznPZMQD9B7LfH12L9SljnWo4dwYbyqBR4By9LwEGQ5e085adS1x8qVMKzSPTHvJewhI0vIWHMlSTYaOvYV2rCo2Tlc8019ywyk63rkgl1DPc3GJ+PDEAIye1PCQk28pMMLrWixbU0dsxh6y35HoTQxtskl77pcvQfrTwskrPaV8b16p3Po0hd/Z3VcFaTAL5Bx4d6/h72yfQWsQNJBKawNEpnldozXjZEx9PhsXTC76kxOH/kkO3tSCCIL/lWH5LQFHd+TLzFnLtjlSUb5T6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKQVNOOTO4PG7jGnuaA7t1+Whfyh8U6Vnj1jhvOMREY=;
 b=jLMuzIN3vNlEBfvytSd8fPE766Jv5895xq4srH9+ylkNRV83p079mvON6FzEaTZaF28ti4esn/DIjl19cphE+q4yYzDkCyhhxKllZtbZt4lClKCd9EyskV0tvopGbrTjKkQ1mY0A8ePaigEpw+EWSKee+gFpQlALQ+0U3odVQq9uBZqj7hJOHMWmS/MkzaWHricKc/DCiXCILGyjKUbHi2UZF5OTqo1C8dPwyjiC7GRIpI+LJGTXKoYq4r3ieOPYXrhURFLfL/bVbIBt7FY4nwL4b9+BWq9tDRgRnZNIkYvNQqFlqlvZ1AOJ+jsRwEO2x4TgJtl1ogkR7JOz4p88Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKQVNOOTO4PG7jGnuaA7t1+Whfyh8U6Vnj1jhvOMREY=;
 b=U4kvhW9WAmgEJNnolxI/6ccIC0dl/mQYGYpy452ZqmJybDdUUGtJrF2UxCYU3X/jAU9EJ0HPdHqJkTpIjqrliw84R6tqDj5MLqsUYAPDgnLZTZyeATwpIRQcVL+rwyCLeOvyIyVBIgdjIForD+sdlLqGk7cMi27ocd16TRaNgyE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4151.namprd10.prod.outlook.com
 (2603:10b6:610:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 14:04:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 14:04:25 +0000
Date: Mon, 14 Mar 2022 17:04:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Evan Quan <evan.quan@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Subject: [PATCH] drm/amd/pm: fix indenting in __smu_cmn_reg_print_error()
Message-ID: <20220314140405.GC30883@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0182.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2456002-51bc-4120-2350-08da05c38c0e
X-MS-TrafficTypeDiagnostic: CH2PR10MB4151:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB41517C339DE26320472FF6958E0F9@CH2PR10MB4151.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vutJrlVUFmUrJMmuR8ayiY4WOfWPipwd8heSpn+LmUTNC9Mg0i9QaQhWzagj7fZhntRiI/6K+7KdVzFYCGY3i141K5mI6EW1429XC/F59gOfxnIGr14pS50JDtwoR3nFsbS52JK5ixmq/K1SolwjKl0dupapf33ErsWWvBaJmGZU1EIJRXfDkF3tM2w7zXCtCc7nvbNu612HnZrAJTXJwVKVGbCZbBGUsUoJTAgtAEv/TJF2bOrsuQzOI+rHV5H1AD5m9D4tZ/v59kJyelpqH4kCJ1vpsU/X2wEWLDCE9mdOiufQK4onXVPwnBRyOvR1zVwjp23NHm0jADgfSqNe8qzvoNw/dWt8eIPkMjrzzumCfuJGfpk9ogaAZy8ZDJrhb1oVEaRwJaee62GB1+ohWkvlAjCD1jSHQC8YPkFyId8T+7jMTR4nJiQAiKVNW8y/sATBBUC+t9E42Q/HUmoaDv2BwiGEl4e95/qPOKercAeOXs9N8ubdS5dHpKQy40M32wwuIovmTTTKNGThgJa5JrnL8AmAjR9NCW0MhnsMTMRJHfeLI8obk8uIiKlrIA1jIBxP71LOCvxgJhoQRSC9m+JWT8u+lpy1BDaTju4X5T9RoqfFuYIhAnPbiSkrzhm5QIqhlcGRuRHXAoy3CGsq32/ex3ZOpRHq7i8UFtj0qncrKvSdQ1O2jEdwZjG4kcVjaOLygVOTr3D13bDYgc1dgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(7416002)(6486002)(8936002)(5660300002)(110136005)(54906003)(316002)(8676002)(66946007)(4326008)(86362001)(66476007)(66556008)(26005)(1076003)(186003)(9686003)(6666004)(33716001)(52116002)(6506007)(2906002)(33656002)(6512007)(38350700002)(83380400001)(38100700002)(44832011)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Imh9yTVG2f7h7rwL7xHAEOag3MxeXKax3yoKs3Ql3pp5miYd2vdBR76tr500?=
 =?us-ascii?Q?eYe+IrqO984WoyadZYzP8yy5v0wfKMJBhVM1sjKJcBwTKWFNfGXMYtkNzhsY?=
 =?us-ascii?Q?eBUcpJbBeHL85aQuEQrr1Dqk8dDm9j2bDsd/qDWfmqC45U1XTSyOSvDddqvN?=
 =?us-ascii?Q?hHKCfuoicb7MvQeg0x5zjimFynCxHUFQJ4wnBC/hguOyWECW+rRnF8lwwsSR?=
 =?us-ascii?Q?+g1Fl5KeM8ExiQH5CsmWBli8tPE1JgpTvhNGv/dHy76O69F9kiDNkRLK/rQs?=
 =?us-ascii?Q?7cutY5x2fV6/gOzxhFoR4eUvCrPd5Peqxu5LehH6cc81Nc7T9L4VaOhKluht?=
 =?us-ascii?Q?XJCns6VeZuB9t+q3QKu9/xYbT9RB0wvtcFX2D53SdxY/ns/oC2GJfBFxnyIP?=
 =?us-ascii?Q?H8cpqkQdcR55gVwnaRmYK6AXKq+1PfeVSwz0+WWKJMNrG+lk3bnxbQK38o/P?=
 =?us-ascii?Q?XjYLrHpJN29/Oay9/2jypBQkQ1A95VsFLs8KklsPBanlb/sb7dCTkMz8zbYv?=
 =?us-ascii?Q?D48uNsTj7QZRdoORmsKidRRELiODE9Kyf3QRVLNvJF9UnHWpTas8Zxu29GQU?=
 =?us-ascii?Q?lyTHvmJwD7pJIkErrr+pR0jYdmNaES6wDkknX4dHBlj4b6cF2IiKUfmzwl2s?=
 =?us-ascii?Q?8M7/sqN5DerBEwk90G+OS8G0pYUWFC97HQh75T7T2wU1QoiBgNF6bTUIQWgv?=
 =?us-ascii?Q?nUGF6Au/UCR9RnBuxw+g9RH0EqzLfqgU1/WKp2D+uHCZI95DC3zA1gIa5sqR?=
 =?us-ascii?Q?lpysJcMltjnXW+4VmlrgxCrkZeFNW3fcivJSQOIiUrchlX5ynMYwsaz5O45N?=
 =?us-ascii?Q?RE3fOQjYFGW1YMDCXNU1RrcHXpw5mnD8IpMegoVxwgumLfx4mUuaDaCRqh7Y?=
 =?us-ascii?Q?zCWhZeCmC3aMMWyR8AjhwGU0Hogwgmndp+/A4UhkLr4t1M03MESN6bgRFXer?=
 =?us-ascii?Q?9K/pI4Y/cSdlXzHqGj5lpDZ536japyAheSyX40MUrw0X/GW5/HqNXibU2QgR?=
 =?us-ascii?Q?Cx2J9/7ZpRRQvqu2U+14Om3+II2W53OfnRGJUOhUCksck0xgiFWu44E1LCt4?=
 =?us-ascii?Q?ZEYfqgh4OVnM2hlu32UNp1zAjsynEmWAig2YQSEoSZx5CSQ2P0xBXUUgd8E5?=
 =?us-ascii?Q?HMGq1Lv9wBrKDDgwQcF+rotb2nauXXRT9DVClpqr7WJpQCg4LeWlYWeoEjAL?=
 =?us-ascii?Q?8U9w4waoN3dyEikpJW9AUEuuVgM+lqMO5yZ6QYXSiK/Fb/aoRSJr07AJtLDx?=
 =?us-ascii?Q?N2bseX0W0ZPoLFMq2E+NxEMObZyPij4+ajsYGTP07yTWaPKYc9rtKMEGD19b?=
 =?us-ascii?Q?B31E9GhxLB3YwraSGmc24RzVQAOu1t5wXogApbBqsQ7UT1BgUv3vyOmo68My?=
 =?us-ascii?Q?4KiwpK9enNnDG1IDpOW8XYcMa+K8I7zYQnkKqDCWTedoSalVVK3KBCR9QWj4?=
 =?us-ascii?Q?SDythhXbOi6ZwUetg0zPE/z7mL34iuMz4gDTQaS7SdAvqF6be5Rbyw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2456002-51bc-4120-2350-08da05c38c0e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 14:04:25.4094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV3gssMU/QmCvcSEocV+5432mbhTo+i5KI7cD3LpJnh3AdjPGh1HaeNU7V5h5nAbLK3AT6MdYEx3ik+duI0EvjVCUKO5nNxb19/U0VlSdPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285
 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140089
X-Proofpoint-GUID: PYJBbYB7cwdDEWCM1G8G5zViITirxDuE
X-Proofpoint-ORIG-GUID: PYJBbYB7cwdDEWCM1G8G5zViITirxDuE
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Prike Liang <Prike.Liang@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Darren Powell <darren.powell@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Graham Sider <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Smatch complains that the dev_err_ratelimited() is indented one tab more
than the surrounding lines.

	drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:174
	__smu_cmn_reg_print_error() warn: inconsistent indenting

It looks like it's not a bug, just that the indenting needs to be cleaned
up.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ae64d1980f10..b8d0c70ff668 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -164,17 +164,17 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 
 	switch (reg_c2pmsg_90) {
 	case SMU_RESP_NONE: {
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
-		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
-		prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
-	} else {
-		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
-		prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	}
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
+			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
+			prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+		} else {
+			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
+			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+		}
 		dev_err_ratelimited(adev->dev,
 				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
 				    msg_idx, prm);
-	}
+		}
 		break;
 	case SMU_RESP_OK:
 		/* The SMU executed the command. It completed with a
-- 
2.20.1

