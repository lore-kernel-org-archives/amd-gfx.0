Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2EDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73BEC10E0EC;
	Mon, 30 May 2022 07:19:28 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228DF10E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:19:26 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U2QAOj018321;
 Mon, 30 May 2022 07:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=qJiMQkGN9/HyqIM8hMMMmyv8eVA+eaj8JrpydGaf+1Y=;
 b=uU0/HIMrus/HkQUG2O++jmD/xvUBfqW0sJuhQx7cXCGdReEllT8tayg5t7J9ormtavIn
 jCpfEuS/9QgQzljWOApibst1QIlW+QI0tyYW+IFCBsoL1gmY9H9RcWHhgYl/pnaqAXtF
 oM3BeGQLPVjUFY/wQs1JdzwdeG12BFggD6I73IpSNp7+qdfun0miGz9MHOfwP8ckMITB
 D1/3kWnBs+oK5D1FpRGe0hVgTl9suxXx8369bATvP7x6H/hP6g6e/hyYEZaXa+XXW4bO
 XbTXCbkeq2yR7kIp6V7XKspR20CcO4eAGPEvvxQjEFeoyJizChVdN3YAb+NmFux+uxEQ xA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xj7k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 07:19:21 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24U7FnUK030644; Mon, 30 May 2022 07:19:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gc8hqf9a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 May 2022 07:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMZbNooRJaTSk+3XD0dgq4TTw5FJb8PvTeVv+F1a06y1xCbZ2cIWh9I6yo5+CK53sJjylwxmzEpT571vTAu+GlIRJkHpw4iCXxXT7MA2jTdGAcwPUDcWctyWHsXmTScRiERXJpo2rdIISoHsTSX2keBpmvfr4Z2AquCBzhqrZY+b9Ds4DZ2cdaJPY8xDxbUCwFQpDKxh3DpDhAg2q8vTqrk5aFPKyJ+3Eon8Vmf0TeCZMdJXPUVE6Rv4xgws7MO5Hb3bHJFFxLL2s0SSdLFfHhuPcARKifuiBP3kuCoFcVoUhpugBDbyRaYtB58Jetg1oC0yd8j9gL4Q8qwDwSNJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwFcGX19phxK2Y+p6UkZ8+go+30ukUqF4PLCZabpGus=;
 b=JrABnbidQ2CXL4XB6fb7UhTH9l4S+qwlZBJgPxmeUgUmBeG4jU6WaVF5ucvUjg1sKVDEnwSWfl4rus2zQV7zUPEhIo/ZqCfQc9y1uulX3QVsMPkatURZDKm1D3MaKNZpz1KAYo6tX8VC8NqLW9juPnr30A6pDzQJbYq8y7gz66t2tFKVlb8lCozme2A7GDqOn9Wu3sXS8a/1d6Tuev72TXNhjee7AlqFaWNxtM83EBfJQvMZVOl35PyzpDBQJB2zoSWzdRfIZnOJUjJ2hOCja87d5guqRHV+gUmRkDp8DwmiDfYudXvM4xNs/aCRR8+/yAXnMTF+HGdNuDp98Os3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwFcGX19phxK2Y+p6UkZ8+go+30ukUqF4PLCZabpGus=;
 b=g9vMkexfU0GXdsxyXqu5LyBRdKCWdji1AQoRC2pc7M8R5nU9M2uHeNrEYywV0Zd2BdSmeGc+lb8httMhZrvre5dnuoIb8iAbMMeE9E5kbK20IIoc8d/WvCMn/uYXZ2JU8Hg+GHDJlAj/2blAYXhAmrAqjqKI1uXVvrOSuL6Ed24=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:19:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:19:18 +0000
Date: Mon, 30 May 2022 10:18:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, Alex Deucher <alexander.deucher@amd.com>
Subject: [linux-next:master 13949/14198]
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1133
 amdgpu_discovery_reg_base_init() error: testing array offset
 'adev->vcn.num_vcn_inst' after use.
Message-ID: <202205280055.X7671nNw-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45086ac1-e3d0-4d92-a78a-08da420cb58d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5030C6EBBD58E581B01D83198EDD9@BN0PR10MB5030.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+X8QCEg+WbN7Cceb71Q5+0KG4KF1AN2O5/5jclIdyqoQ1Y+uPQvyMJbH+oOGESJmCGkSkGhCgMcJNc0rpcuao/TWrsP+5uf6pa7UOmgboivLbz8qV0mWS9emkw7Ctm3YX/CamBLRjIoyhKS4MEqrwro/jIMyC8GScZt5jemUFqXKl8wuUbasXpVBTdAjJ+XySir+nSuHF9oUaovpGmkuchPw6SusfG4osOWJkn8uejH4U+ZxKAyPqoQtflZ8FvRyPDWU/J5LDEy+nw789PwZ2IR7rQynuYEraIp4LFFX/C//s0DEOkF0rAbtV3c23cTtqljaSBwHng53fX+oZ/y2p3JKRQdhd6bxFwjuG+oqjNkQzbeV5iOLCTqVZpQ0TacMDW4gOO6mf0IL+XTKRE8FgtXI+Y+40j6fugAYp5k9S4ZlXdhI9raGlIoUOGS7UjulCgMbUekFGP85m0Bublu82IQcJlDMfdeiMQg2cUqroWpiKoqjZr7iQxG9Bp8Y1GL3LLmjUnsDFhzuZC162jy1vgrwqtr89fh/wc95Grinr3pkwHELf9dykTRwEVoh/R2ubXmwWpNm+PlhhipjnHBRtdSvlMgQPyceH4Etx5M0nQ0RBB00wNyiueKnsWzfy6Ay5X679orXO1FM/snazeQ9l4Lx350v0k3toBwYJZYOyGRIzc5k7amr7WXcwgBUbPrjigy4Ab5IhzRIG/ru2t/6i9FOIfBqYqy0+RiCefbADHfLZhsYK0LzUdxdwRSWlK74aL3ePqqdPHv85ohxKQXtSWUkDWT9RCwfKEmUVj3rxHruYK3nSnvqOJBD9h2jR1U4fMjsRiKMBtefp01HmSBjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(5660300002)(83380400001)(44832011)(508600001)(8676002)(6506007)(38100700002)(66556008)(66476007)(66946007)(4326008)(36756003)(8936002)(6666004)(2906002)(4001150100001)(186003)(52116002)(316002)(86362001)(38350700002)(26005)(6916009)(66574015)(6486002)(9686003)(6512007)(1076003)(966005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?03t0WxiEOMUBPwL/74LqP7Zx6JA6tx2z+CG9NhY3Hoih8/l0zfG9u3o+lp?=
 =?iso-8859-1?Q?OE9mjVAR0xjX9029zRgWstkRqeiCHXVRAKZz3jVnHM2Fyf92Sc8ZxqKdU+?=
 =?iso-8859-1?Q?RKKY3R+PudCW3o1XMQTZC3ZicfWUX7PpST3cKe2WX0UmUMU6Y6oCbFljM8?=
 =?iso-8859-1?Q?Z6QGgZPrnGDzJa1T5UDx6tks0mVm6xpioFgqoJkAihMttq8Vgtl7Eaj0RO?=
 =?iso-8859-1?Q?fO5G2fC2PBpCloXvt7Damw0DwFR2axuYNL5UooEYe5xbkxUQr1ORF82Ttt?=
 =?iso-8859-1?Q?EHHzKCwzgN0dIJjYfEQkd6ITlCkzN3BzBBlDzuDNwPcpBQfHFeXwbymt2h?=
 =?iso-8859-1?Q?82c/w4CRiMPqKhlqV89KfKTNzHfi0SMZ5p3M4ZerAnisnokIY97uKGHLzR?=
 =?iso-8859-1?Q?t/eOdOIT4Se/JmRQwu7nbbvEbbgULRxFP/blah6sfNFqmEVBq5ezZCTfo0?=
 =?iso-8859-1?Q?fJRdXFgMbFZno1OIGF8wG66YhLgXC9y8RRSeGO2UcYRPpTQ5IWiGp6MUTe?=
 =?iso-8859-1?Q?DNIxFX59TQ7R7H/2dHenpphIqSNnpdsPIgI9YFGrnPOYaiOafsV7tfU+I5?=
 =?iso-8859-1?Q?Ymc0HFWVLEhOjL05Na5ArBsEazF6p2xjstyWCdJgNLCA4zlr5lm+F651xl?=
 =?iso-8859-1?Q?ImiPARDv24gHGhSm9gBhKS1xFA49yyQyJJtjel/O/mmz22ldlG81fvAiz9?=
 =?iso-8859-1?Q?7D4qwUJ7w3WSjVpA4M1qYZ/TcTyUxmv73pNrPUnQziTuNd+okaD7jlZxu2?=
 =?iso-8859-1?Q?2lpYSfg441mCFto6dIFFN7Z8+sIbg7ui7LIZIXzgIxIiOVQE8T0Cu5yMEA?=
 =?iso-8859-1?Q?1UXQEs7gxO0joFN/sKdzz1s8GBNxyURi8rguxBrLUDuFOqjplhkrdbAjmZ?=
 =?iso-8859-1?Q?Aq56JCgNpOwoqY1+X3F+eqJLp0AFTzFvkXsE0+lenE35C94KRw2hCdxTh8?=
 =?iso-8859-1?Q?hK+UTJBoPWeOmTPh14sJDgcQNDaK+pRBqN0VTcegAZrvCI1tWDx7zsDV2h?=
 =?iso-8859-1?Q?pIGvCLgiIJ0eqy1ay2PTPrdSJdgfdrV8wNWnN1iv1xAuBSFo7WC8fesxEE?=
 =?iso-8859-1?Q?IhsiG1CFnudhhd951N8LqwNUp8MvQlrsZLDWdLSTfU3wgMB5JGZVOJMNMD?=
 =?iso-8859-1?Q?kKeb0lfglmHWf3EqqXrOa6EghtZN9qSfBxywd5GJC7SrZe1i5avX8xjMGq?=
 =?iso-8859-1?Q?8YqAfti+nQMyS+dzatvkviHM2Y/A7IGw1qtrmf4MVjhrgzAr65NXL7Eysi?=
 =?iso-8859-1?Q?B25GxBUaTzi76uiY5ZOKtQh6x9aYNDb8fV2ftB+lc8Lr5nJsLE1/OIPyvm?=
 =?iso-8859-1?Q?iM4BV5gt+I5jOqGBd1FdvtQe2BvuCw4gdPPzeyuXi/v9OSQOqmdBqEBtcN?=
 =?iso-8859-1?Q?FzoZYFHtgmIKt3MZQ7toG8CBcta7y82hQZfVdL32kofpAGfffUhG0mEusK?=
 =?iso-8859-1?Q?T+C/2sABqwyMScP91RHbaB/oKPn0mlxyg/wBtqozZEnlxfiJfgckTHeefV?=
 =?iso-8859-1?Q?w+Yf+GHSLiVjPaj/+YpHYv/q1mEGuY/iegq4/cFjKPpCcFugZs6SmvLDyn?=
 =?iso-8859-1?Q?kaMiLNIbuBPpyvIK8Ls32vnTODFfRnL+Lo56dM5y7NYKKlnB+OSLH8OkCM?=
 =?iso-8859-1?Q?in/vQf9TymuWHocuAIMul/y4JDUD9S3olSwzCtnH1GZVDvWgnwB/wV3saX?=
 =?iso-8859-1?Q?vG/xBy3hzgtOij5X94F7SOp3D5armWaI4/OwtEtKAGiwSnZQR3nQfHw7NO?=
 =?iso-8859-1?Q?v/Ga3k/3AgQ5PiGVhtIqcAC3RTkGyWrtcw/Nq4bhGvrVq+mT6RzhBWiDGE?=
 =?iso-8859-1?Q?HurdqVTvxbZbq5TvEWm+TrLJhn/DQC0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45086ac1-e3d0-4d92-a78a-08da420cb58d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:19:18.0440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCeiil/hzrPuaBaxngf7U5+REZvWHAv7VqzCEGhWFZg5pa5TV2D1FQ42cbTq/Xuc1+WGXp/k/SjoRN1Qaf6m/eWQNOqwjv53v7p92GwlbYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-30_02:2022-05-27,
 2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300038
X-Proofpoint-GUID: 3imUZ-DEX5wt7rAdaD_BS_it0ZWXcKEd
X-Proofpoint-ORIG-GUID: 3imUZ-DEX5wt7rAdaD_BS_it0ZWXcKEd
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
Cc: kbuild-all@lists.01.org, lkp@intel.com, amd-gfx@lists.freedesktop.org,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[ This is one of those weird things where the kbuild bot sends the
  warning to -mm instead of the AMD list.  It will likely try send a
  duplicate warning to the AMD list in a few days.  I would have sent
  this warning in a couple hours from my devel system as well. -dan]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   d3fde8ff50ab265749704bd7fbcf70d35235421f
commit: a0ccc717c4ab3ef572f023fdceffb4b6df496a0d [13949/14198] drm/amdgpu/discovery: validate VCN and SDMA instances
config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220528/202205280055.X7671nNw-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1133 amdgpu_discovery_reg_base_init() error: testing array offset 'adev->vcn.num_vcn_inst' after use.

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1454 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <= 3

vim +1133 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c

e24d0e91b336762 Alex Deucher    2022-03-30  1065  static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1066  {
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1067  	struct binary_header *bhdr;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1068  	struct ip_discovery_header *ihdr;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1069  	struct die_header *dhdr;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1070  	struct ip *ip;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1071  	uint16_t die_offset;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1072  	uint16_t ip_offset;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1073  	uint16_t num_dies;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1074  	uint16_t num_ips;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1075  	uint8_t num_base_address;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1076  	int hw_ip;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1077  	int i, j, k;
dffa11b4f74b157 Monk Liu        2020-03-04  1078  	int r;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1079  
dffa11b4f74b157 Monk Liu        2020-03-04  1080  	r = amdgpu_discovery_init(adev);
dffa11b4f74b157 Monk Liu        2020-03-04  1081  	if (r) {
dffa11b4f74b157 Monk Liu        2020-03-04  1082  		DRM_ERROR("amdgpu_discovery_init failed\n");
dffa11b4f74b157 Monk Liu        2020-03-04  1083  		return r;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1084  	}
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1085  
72de33f8f7ba0f4 Alex Deucher    2020-07-29  1086  	bhdr = (struct binary_header *)adev->mman.discovery_bin;
72de33f8f7ba0f4 Alex Deucher    2020-07-29  1087  	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1088  			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1089  	num_dies = le16_to_cpu(ihdr->num_dies);
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1090  
437298b833996de Xiaojie Yuan    2019-03-27  1091  	DRM_DEBUG("number of dies: %d\n", num_dies);
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1092  
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1093  	for (i = 0; i < num_dies; i++) {
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1094  		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
72de33f8f7ba0f4 Alex Deucher    2020-07-29  1095  		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1096  		num_ips = le16_to_cpu(dhdr->num_ips);
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1097  		ip_offset = die_offset + sizeof(*dhdr);
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1098  
437298b833996de Xiaojie Yuan    2019-03-27  1099  		if (le16_to_cpu(dhdr->die_id) != i) {
437298b833996de Xiaojie Yuan    2019-03-27  1100  			DRM_ERROR("invalid die id %d, expected %d\n",
437298b833996de Xiaojie Yuan    2019-03-27  1101  					le16_to_cpu(dhdr->die_id), i);
437298b833996de Xiaojie Yuan    2019-03-27  1102  			return -EINVAL;
437298b833996de Xiaojie Yuan    2019-03-27  1103  		}
437298b833996de Xiaojie Yuan    2019-03-27  1104  
437298b833996de Xiaojie Yuan    2019-03-27  1105  		DRM_DEBUG("number of hardware IPs on die%d: %d\n",
437298b833996de Xiaojie Yuan    2019-03-27  1106  				le16_to_cpu(dhdr->die_id), num_ips);
437298b833996de Xiaojie Yuan    2019-03-27  1107  
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1108  		for (j = 0; j < num_ips; j++) {
72de33f8f7ba0f4 Alex Deucher    2020-07-29  1109  			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
5039f5298880f7a Ernst Sjöstrand 2021-09-26  1110  
5039f5298880f7a Ernst Sjöstrand 2021-09-26  1111  			if (amdgpu_discovery_validate_ip(ip))
5039f5298880f7a Ernst Sjöstrand 2021-09-26  1112  				goto next_ip;
5039f5298880f7a Ernst Sjöstrand 2021-09-26  1113  
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1114  			num_base_address = ip->num_base_address;
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1115  
437298b833996de Xiaojie Yuan    2019-03-27  1116  			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
437298b833996de Xiaojie Yuan    2019-03-27  1117  				  hw_id_names[le16_to_cpu(ip->hw_id)],
437298b833996de Xiaojie Yuan    2019-03-27  1118  				  le16_to_cpu(ip->hw_id),
437298b833996de Xiaojie Yuan    2019-03-27  1119  				  ip->number_instance,
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1120  				  ip->major, ip->minor,
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1121  				  ip->revision);
f39f5bb1c9d68d5 Xiaojie Yuan    2019-06-20  1122  
baf3f8f37406257 Alex Deucher    2021-11-30  1123  			if (le16_to_cpu(ip->hw_id) == VCN_HWID) {
c40bdfb2ffa4cf1 Leslie Shi      2021-12-08  1124  				/* Bit [5:0]: original revision value
baf3f8f37406257 Alex Deucher    2021-11-30  1125  				 * Bit [7:6]: en/decode capability:
baf3f8f37406257 Alex Deucher    2021-11-30  1126  				 *     0b00 : VCN function normally
baf3f8f37406257 Alex Deucher    2021-11-30  1127  				 *     0b10 : encode is disabled
baf3f8f37406257 Alex Deucher    2021-11-30  1128  				 *     0b01 : decode is disabled
baf3f8f37406257 Alex Deucher    2021-11-30  1129  				 */
c40bdfb2ffa4cf1 Leslie Shi      2021-12-08  1130  				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
                                                                                                     ^^^^^^^^^^^^^^^^^^^^^^
If adev->vcn.num_vcn_inst == AMDGPU_MAX_VCN_INSTANCES then this will
corrupt memory.

c40bdfb2ffa4cf1 Leslie Shi      2021-12-08  1131  					ip->revision & 0xc0;
baf3f8f37406257 Alex Deucher    2021-11-30  1132  				ip->revision &= ~0xc0;
a0ccc717c4ab3ef Alex Deucher    2022-05-16 @1133  				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES)
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Checked too late.

7cbe08a930a132d Alex Deucher    2021-08-09  1134  					adev->vcn.num_vcn_inst++;
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1135  				else
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1136  					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1137  						adev->vcn.num_vcn_inst + 1,
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1138  						AMDGPU_MAX_VCN_INSTANCES);
baf3f8f37406257 Alex Deucher    2021-11-30  1139  			}
5c3720be7d46581 Alex Deucher    2021-08-09  1140  			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
5c3720be7d46581 Alex Deucher    2021-08-09  1141  			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
5c3720be7d46581 Alex Deucher    2021-08-09  1142  			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1143  			    le16_to_cpu(ip->hw_id) == SDMA3_HWID) {
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1144  				if (adev->sdma.num_instances < AMDGPU_MAX_SDMA_INSTANCES)
5c3720be7d46581 Alex Deucher    2021-08-09  1145  					adev->sdma.num_instances++;
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1146  				else
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1147  					dev_err(adev->dev, "Too many SDMA instances: %d vs %d\n",
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1148  						adev->sdma.num_instances + 1,
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1149  						AMDGPU_MAX_SDMA_INSTANCES);
a0ccc717c4ab3ef Alex Deucher    2022-05-16  1150  			}
7cbe08a930a132d Alex Deucher    2021-08-09  1151  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

