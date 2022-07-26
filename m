Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34FCC00140
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 15:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421558F6AF;
	Tue, 26 Jul 2022 15:24:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B498F69C
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 15:24:06 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEEZiv017237;
 Tue, 26 Jul 2022 15:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+i7pPniGJ20bBX28h+dbEY1+wM/frZoHEYGjv5f3CHQ=;
 b=zJvkWeFNTpnXhsuGqRtPT6Vf7yY3wwEkIivnml0NdisKdamPShL3C8CeJiRZpywdZPv+
 NNodI2/wqXJMhlqXxQWWrOOhHYn8HLa4qeknyzfYfDB1+p86UX9aQRLBLLLSBlkH5LEO
 53Bs5PSl2XSN//UyVRSvpdVXao/g3YnXjdZ8wjZ1nKtKr7gOBKkXcW5MGRFCuG3YzMGV
 FOSJWF3sR5B6B0qMG4HsWXUmzVw26TR9/jS7mYsxhZ7I1Zp4o5EF6rT+IB6BORquxLxQ
 nNLGGzNQ0itNEpSqZqTsc2NaXnDiIe/ozGx1mxC6h2rglzyWRZzFYemSpOn5E77QYpLE bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94ger9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:24:00 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 26QETm0w016588; Tue, 26 Jul 2022 15:23:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hh650ndsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Jul 2022 15:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6JcWapDFC+V7bDIhXVg2cZDo4ixW299RrItN9zl/yyD0rr+7xLPG2z0xt9Ot2FZFjiwB7rZ4JYtcDkPpPJtW9Rrw5igiH/gT6U9ZDidZTlMKwP/QVo5OGX5htw7CaREJIgorB9qa4ami+7o4jVrGnSBGLUQ2xBDIQNviW8umin3MJrkjpmcTn7kuBYx7Ih9S2awAeqioVajnycFi2MBvnW3pzDx7aFCfkz3pdksfLxga/dzhGfUXE7kh2VaTx8Rzu3N2lkTb2JTlMCt4A/6TQhIkPTeV28oESg+mAeusI+saQzO8mOmnp1ShEwtImar6rIf8AcJtUhcHl2UfcOPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i7pPniGJ20bBX28h+dbEY1+wM/frZoHEYGjv5f3CHQ=;
 b=heNWCB2EZGHqJOa9RzFY5TpOfoATSWp0zyKF3qK7gGDWfkZuwQp8rd2jtEcEQIJ514GSe6DNgT5HzLPr7JpHM9iklfuoaMHRQltK8/hxFiUjECeyu4d7beswAjC0vD6Imna/R+dqEJVKAcSSSk1O1WlMEuW/Sz+eTx4nM6wwDvtHfag8ODnDloSn6vvR99MXtdH7Nzh1H6U74J2jQwSD0bvQp/xg6w/UlpUv0zGRnXQwV9melJ8dFXhHUqp3Y892i86PHjiUaMmsPzUMswSPN/uAP3ubccQu/eb799zCbVm6cv5ec1nFdFJAvIaCM9IcunEycz/d7yNaVbmxUKS26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i7pPniGJ20bBX28h+dbEY1+wM/frZoHEYGjv5f3CHQ=;
 b=mEMGogeQg9vkY8+pcWbihbi8SosOJ5xs74bnNDsB/yVzp6MGjpPZoQmOTX+yq8ud/FnOAAk4MlDGxoFnAZVkJTabSigGBKbymdKSAHIkEIglrT8V5HYi8TBHiCD4l/VVtLzp0xfzcForsuWOz514Sz2Wvsjd4SAnunIUR47pxbc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6219.namprd10.prod.outlook.com
 (2603:10b6:208:3a4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Tue, 26 Jul
 2022 15:23:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:23:57 +0000
Date: Tue, 26 Jul 2022 18:23:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harry Wentland <harry.wentland@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH] drm/amd/display: Fix apply_synaptics_fifo_reset_wa()
Message-ID: <YuAG/ekcSSFqdeMU@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0174.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e09f936c-3a7b-4f2c-8eef-08da6f1adb80
X-MS-TrafficTypeDiagnostic: IA1PR10MB6219:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3TamLNQhRwKOLl5/jDQ6OLnvffTOFgnYPTjUwIiTvRfaXW+8ck7Vy+dQkJfi2nIyerOrLPwToCt+vH9UzrWv36BLmELkt5lEX0Gqn+N0x4yp6o4h3QMohquC/L6NBDFFeN51UXqAypZvXvLBhcUE2rMIwxETImkCnLmZCOw4b/Mb8//MXFewNok1GmcMQg/bX8SNxw1Xw/fvOlLGPt/jSV77gSwxWFqm5uiJrIevwzC0kl1LRFbVed/n8A+dmbPNDP/P7Vb7xmzf/A/AK15lz9aKQR7g34kkLpzuhXaqKYg9pyoUN6CrYuZvV7WnEjuLHPfDeZpIQ2t6N9tm6w02OWEWWZGPNaPtUi0CThxnFCNGSJAcPYuqLzc+87M6n9E7QqzsYt3V/Gc2dLDsvyBZSlOG7JkdA09+M1vABbTQaq0/ibYfeSor72vWld25pe19VH6a7kUVGhV4ssorzaAw0mNQ9Yq0GaWxNKHdPZio713TROBXfTll8DjPG6apjSS0omUAzGrXJcIdfM7kVNNaqARfVcUJ0g4h7sW3UsQoKNbzLz9ZTPUwrJRg4PRNStBXfTvYaqwAKgsrz4h+I34toXAskRRaGU3dO5VUXapnWmHphIGy2oaaEpB5+oZn1SvtbP5cW9CZD1YzpH2kHuwBCxtk3L6qj3TyEjymTYX9LrMY1H15lCDKIFONeMK4BfIFtXIM/j35nON/ly4YgfGbcxHbJ99qQH/zVqXuRaPpOBVW2DQPXMA/tShFh5G6IHalD+K0JP5JP8xcLzfsHZuE1AXle3iCw4S53i+hlR6NcY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(33716001)(2906002)(316002)(54906003)(110136005)(52116002)(6506007)(6486002)(478600001)(41300700001)(6666004)(44832011)(66476007)(66946007)(7416002)(8676002)(5660300002)(66556008)(4744005)(4326008)(8936002)(83380400001)(86362001)(38100700002)(38350700002)(6512007)(9686003)(186003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hYncGiKNLES3YERw6mobtzRYrc5MsPhq3y+O7XDS3UAoUwiyWG4n5H26Vltq?=
 =?us-ascii?Q?3pEEfHkoGbdUWMfYdlYnjM+4aUtr2h3TRUpPSfg1t8WgeAzoV/ES6e4LWjY1?=
 =?us-ascii?Q?4mmx17bUBf0OFu1Vre+AOn/bpEOWp1SAahPUIUTkkG4+IquHxBFTPL9cCQkc?=
 =?us-ascii?Q?dlHGW+IM/WB/3kdzbIuk+enbe55ZOuuhkueAbJxh1rZw1lthtVP62nnYcf7I?=
 =?us-ascii?Q?YckhjaQ7JTmCwvQmTsG75MVh6TC6pv7r65Oyd/G3/ExtwdeI8nInsHnv3zbk?=
 =?us-ascii?Q?9y3DwWqXR3dpjtLRUlY9sBktTklQj6Et41mkC5H8u/I+fmh+sfGa1Xh7maU2?=
 =?us-ascii?Q?f9GsfvXaLJaakVfPHPdj7WGskDKfE4YzVPxyQ/qEC9pUAvYR7/WFcb1z8JLm?=
 =?us-ascii?Q?3MfmGd9n3LoZWsLcZ3vDgkumKqpM2HrrOU6IRmN8pe9h2fUgKRPvtLT51Gwj?=
 =?us-ascii?Q?XFXfMJp4z8DfZRj1ZcuzwMwCxRAJ4NL9jKFjCUxQboPLvkMpCBKkjgONj1Ac?=
 =?us-ascii?Q?QpyGf+XtEplll8SWP9ooOkLQ1S7DMGEMHGbuYbtqxhm9NMRTZyg5O/VkOQTW?=
 =?us-ascii?Q?fpV51gJPTrKJrs+8zePaaGLnTzX2rQp/I2fDe1zsPaJAM1gY2cVivjQEMUpl?=
 =?us-ascii?Q?h/6Ef17TSwOksiQDmfVam2Dc7k0le84mbzw6EEcEdos6hip7FvQU+HHtZXu+?=
 =?us-ascii?Q?Z41LfJIb2vD4btxmHg+XCm/4ylO3yMRd4PSrb+6f4bOsSHIayFdtQ63fHkt8?=
 =?us-ascii?Q?RDuh4fXL0Buvup1HF/a+v4/tWSniBTDqOKLBgJYaX8C3OsKYDcUxBF0Mqyph?=
 =?us-ascii?Q?jK5X9pnQ50fBJ2UHZoYOYyh33iahor9MFpkfkEH5T9wY3qIXyiUdDNtrfM4j?=
 =?us-ascii?Q?NBe9e+iWeNdN9zKCCNgrgW8D9RJN+EmvhAlnNCwUP9TzpBdHgfYaj+8aGr55?=
 =?us-ascii?Q?dzSGlKPLr4V87cNWW3nal3KvLynHbQb2HN7/qprUggiYkvBUKshDqb3uAFcB?=
 =?us-ascii?Q?ke8uOcuDajlZVn2XOddMNgRMGCBvdbkFR74Au1xo0NXqt9gaE9wXVa9XpZVC?=
 =?us-ascii?Q?yo33TF+u0+ln8gH/2b34kvWyNdoQ6Yk4trE4r4VrWynVOj6M0eeCrnNLxoIi?=
 =?us-ascii?Q?B1WGUYeHbTIYTnUQmE/0bHn5GV9KgpdaReSL0blrnmLA/JiJqSe7sLycUL6y?=
 =?us-ascii?Q?8WqO7HJUrbTJg+yZD++4On34mkJ8LRNohkUjobwaLWsnPZUBmJfKfiaHOl1v?=
 =?us-ascii?Q?E/iZinhK4f8xd0GAOEDotTihzjUOXhQQrSBbLpvL/Hv/UcpuENeUpxTnDYbb?=
 =?us-ascii?Q?taspEJAa5Q6GktleQvTcMhZE+bRHtvZLCLrVRiwjunEVTy0ZeddTBzkQ9HrZ?=
 =?us-ascii?Q?YmsXPUhKkX0EYcZq7VQzDtmiJU3U1DOUGO3IKAfs/HSEyDgpLULJQDKV3vrs?=
 =?us-ascii?Q?NHEgRO7mmmP5wqaP6QXkVX57s73Fqf4UjJRoXU6gJoL/HLCaiNVlixORFnUA?=
 =?us-ascii?Q?/OCx1kqVZNIpnwMDLmU9o6qSB0UlWsNGC94lCpJPP2DNDdO7PqgMxVDTWsKv?=
 =?us-ascii?Q?3BXmeuNMtMEPSVJFmSbeN8LszmSSMqNtKc+BC87+8ecBwZ3ZD6bEbli/Iijl?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09f936c-3a7b-4f2c-8eef-08da6f1adb80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:23:57.1470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26IRn3dVtTVeiCAwVBbLp+Z6+I+9Gt7ad+OXNGX0gGAImT8aUDaJDHIMeEJJZ/jGdrM2NS0IVR+QNAdTAI7Dz5vS5ZK3TPLwhZlISKBwA4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207260059
X-Proofpoint-GUID: sLcbd3ifPkI0PeZ6vYKtKU7dWTSEJXyY
X-Proofpoint-ORIG-GUID: sLcbd3ifPkI0PeZ6vYKtKU7dWTSEJXyY
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
Cc: Ian Chen <ian.chen@amd.com>, Leo Li <sunpeng.li@amd.com>,
 kernel-janitors@vger.kernel.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Claudio Suarez <cssk@net-c.es>,
 Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a stray return which accidentally turns the last part of the
function into dead code.

Fixes: 2ca97adccdc9 ("drm/amd/display: Add Synaptics Fifo Reset Workaround")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
From static analysis.  Untested.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index a0154a5f7183..0d200e276e67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -671,7 +671,6 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 		return;
 
 	data[0] |= (1 << 1); // set bit 1 to 1
-		return;
 
 	if (!execute_synaptics_rc_command(aux, false, 0x31, 4, 0x221198, data))
 		return;
-- 
2.35.1

