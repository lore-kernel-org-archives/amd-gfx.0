Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 09:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3757710E40B;
	Mon,  9 May 2022 09:09:11 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1597210E40B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 09:09:10 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2498JwCu022574;
 Mon, 9 May 2022 09:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HSzQA0cLRB1E1dRTUMJTIEKHaNDU5AHSosKA8JEsJ6U=;
 b=SwUiDaHEtVADdOtN3z//Qz3/VtLJtcUls+GdX+K2+79xZCYqc+7zxn56HAriDxT7UJY3
 TYG+aq8mgu4A415xxWeBnufePAp1UydSuFnFyrvFFU7dRVQBgS+BwzRlv+I9dmyaKhPz
 973eY4bx3EjGeR8EThxd+1+VuB401hJSYZrIwl9dw4kpPGt/7H8Normb4T6rnMtEzall
 +OR6XKhrwX0zkpJ4G/ltQ2gCSykDG5hqELjjMJ4NjCfrs/szleyw3JE9UZcQDYpg0JOo
 WDDj9Cf2B67ecMWSxGyzsuCS25j1TO95LDSpQ0B2E/c0OoqyQ4nO0ap50HKPEGQ1EP5x hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatapwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:09:04 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 2499772O014074; Mon, 9 May 2022 09:09:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3fwf77uv49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 May 2022 09:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njnV7XvK0FMl8/xKuP3Q4e4x1mjG2wA6YcHiKoSQjz6b0Dm+Ojc0Lzca3SCNt+Gxtco2VVR9PZAj2jMBg1k4cZ6ALKZ1lbbH1MrD5H/zQiBmnAP+4Z6n1EUVjZDe0HvbrOFPlBlGweIcatT7N9uhy4hWsAfkjX/hwRJw0oVw58u11YGp7iptW3jU28LQaYaiuov2Me4/gZMioHmQTfnxEBnWWYmauCbPTo0/1tFL1++gpG4FSZB06C7YXrwL0Dtb/M2TsL3QiXkFGV7BNxKp8EMT82rNtj1zpjDMe+1syT+Y2prXGqplZWezP2O4GTeLjoziW4++yWU8eTFal5atFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSzQA0cLRB1E1dRTUMJTIEKHaNDU5AHSosKA8JEsJ6U=;
 b=h4HXwjF1pBTlIPqqBcq2DeRd78P5Ry5JrV98rtXFp4HHTHycXXKICS1VQLh8+7Z5PKINFOnvLHLLmOB+2ph+Z19fXhcw6bg+VrJBcpXRi1iIa+WCZw68O5vRLQQX7QBKn26h+gKHnqLB5AfOrmBBJnqsX4YMwaJiYUjwfVGT3pmOpEECb9U2ayKTUJ7DicNucKM/cew8yerfseCIkLSz+nVmnA47hD3Qwgn2bXXfWnaQZPh86Nossfa6QB9qSjAPglZ8ZA+eB4iJbZHHLojGrCpj7lSlFYuJcPoiEHeNnXggRnhaTxG1VzYtROam39DVWXdbc94dzj4GqWU9v5A/TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSzQA0cLRB1E1dRTUMJTIEKHaNDU5AHSosKA8JEsJ6U=;
 b=AMzellYF4mv81o3ZIa4TNxe5DbzIZSAsQdz+fFRuwCBtVW1GRjqFNXCZdvPCboSOUCDt7DscGVagvzZWu1CzrpQxDQcqWfu5vR2RccZzy9XvK6X3k2RYgWQCBzFNBt2q/m3uAGS5tteTa1v96SvufMRzLYfzLwdNK/6ZprxlVzI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 09:09:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5227.020; Mon, 9 May 2022
 09:09:01 +0000
Date: Mon, 9 May 2022 12:08:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: unlock on error in gfx_v11_0_kiq_resume()
Message-ID: <YnjaIZN/Wj+QvVGP@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4ad6532-c47b-4c21-e491-08da319b8eb1
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4542:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4542F90CFE1826D61A19E2308EC69@SJ0PR10MB4542.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0lcOuDOcqZAPqH5iIZpKg6qemfXCOylec6Ew5SbU2g2bVFF7kvnHn6XEQOE8UppJLjt66GEeKwF2gGBMfSU3OfKciukj4Js4lXCOq+NBX8BPHaM8SOFkwSeCc3P1X4nWRPIQUC26Fc7nLb1mfMhsuT0HWr1QqtUASgKoEIPz+49uWd1ASC805Ih5+o8vNYjZo0+JprhrpZYeAPA3kYOubjfcjdrXccDM/CxhDmOCjVvDi1gtjC9ynfqHQ5/bKwbxLtKHRRoPtbOahhBCEq10zDhfhv975e149MUThrnAHpIlvNKodW4zgB9vrGdF1wrhCoPs2emut4EC2fio53dhO7TORfeAwPBdvtIwgZgMXL+7PCMNVDf7Y1H+qpWw2Bspe6QoQ7qN2v5kGSnmo5maUoNRPNy1oZgH6O5CLNTiX2S6kvLsJoTMABXo7vhoS7GjqhDOW4o53kwPq0Po7g4cKuV6XRAI0Abh8re2C8MVJ68+IGmxnAfpHP0TSuY7Y2u7zhh1r7ofv6Q4u/MMjBS1kU66KJlCfEubfJ/MFvaHOJ5X5ikgY2m9zbahd8KBegLOKmz/7tzhT9Gpfu+N/575kWo5Va++Kjd7f7ZuT8XVvmTVQIUo5Vp6EAEki7GYQDBIxHd1R651Cbd7DqJiXuNT3A9JNhn2dDtQxPf4JP2ixj9Xt9zJXAavNxk5rTdRYKy5IORdZEq0TmreOUMtpCyeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(366004)(33716001)(38350700002)(38100700002)(110136005)(5660300002)(83380400001)(8936002)(6506007)(7416002)(86362001)(66556008)(44832011)(9686003)(508600001)(4744005)(6512007)(6666004)(26005)(66946007)(6486002)(316002)(66476007)(4326008)(54906003)(8676002)(186003)(52116002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?In/D7gw+KRrbo1EI4NxzEeuzQczsOmGeSIWW7GAFTL16W7+hi+aGpw2p5sh5?=
 =?us-ascii?Q?ylaB0Cye+CLjYl1tCATmdRi5et29omzYdEut9ezKlptr6cILb+8c+fCm1STr?=
 =?us-ascii?Q?aveq4RpOCpEpzbF7gwOFdq7TE6mCWY2vObVGwtJPhFsc1m8I9bD4+uaOWMYE?=
 =?us-ascii?Q?f6zMs7JieX1R/Q66GPXfv/RyqWwIw2KiYxgcEf0WhQgsgSop5GaADQTLeGKB?=
 =?us-ascii?Q?2Ph/MLQgSTp9L1HQncneGNPyWDfVD65NMm7Ld2pznfQRAA6mtt2vjKp7a48+?=
 =?us-ascii?Q?1pdEOWqQhQa9jZM0wJs1+akj5oZWpTpLJvctMV0FJ3g7ZSpAPYEC/SdzzUp8?=
 =?us-ascii?Q?OMcNd1btJYy4GAu4e8yfWWFMDu0IbN0feiHSczDr83td9CwZfmCzL/rPhvNi?=
 =?us-ascii?Q?2tJ9KRs2HfAmk1sjrTAd+jTJHNjWdd2ZkclhXpHAdrNb7/Gejt84yRmM1Vjg?=
 =?us-ascii?Q?AvEpcGWEP5HQYoQdkMQXa8VoCSeRnutunJ1A+uLOaFWRZ0uPJefwqpVeuCQ+?=
 =?us-ascii?Q?UIm9/a/fs9pwct55vzd2ZCwuKtmZbZwgGmIo8D0UZ5C6xy0Q/ckpH7Ct6o03?=
 =?us-ascii?Q?Ioz2343M5Z89A32DyZwzgLRctY+VdSf2S3Cz6pXCuTKslz1wn+PtuiVonkPO?=
 =?us-ascii?Q?P7YDnsq8fTRH2SxEX5ak1D4xvVhmsbHY3OCLYhnrNyhM9NGTfQ7meYeIoiJd?=
 =?us-ascii?Q?tKJGjXXPmtehm7iOnAzqdXSYCcPojl2vMQlMhOLYtJAt/V93B9kw5fPPLIgI?=
 =?us-ascii?Q?8uhN9xrnU4AMcKGhPcR4CbHfWBTaAG6o+WxM1Zkl02oXu4g+JB56OEG5XNAO?=
 =?us-ascii?Q?dsNITh/OXGVdw3bnn96x8wSeiTN+Jv5qSBI1z4pXhAhPEFicE5OkAQVCW1C8?=
 =?us-ascii?Q?ycSJ/bbYhbRKWqbLqpLEHhT6r3ncX33fwAqQBe92iKBOz9IHSr21xJlGpKoL?=
 =?us-ascii?Q?HagGY2eZI9P0/QntCdpf76yT4U/xWW7C4EaPVDwlO4gdXcRt8c6OPKBkQzea?=
 =?us-ascii?Q?EU4TjL78Dw2IU7cOx6qNxipHNrBl3AAtrqVzpu3dogZTMhu428+4MmKLYFJz?=
 =?us-ascii?Q?7Nk7mL4VSJNSEcw+x847WP/EUAx4VAl2lRdmJsLfG71wSrYyGIrV7Z4GpJbZ?=
 =?us-ascii?Q?sI2VLRP4z9KXnYtDpNKCbRx302an3TwirCjSRDB2WIl7X6o/py3vL/qX82Gk?=
 =?us-ascii?Q?gutMwu9hgcwVKRybCg/Qg9TC2dsSYYFhEuTe2c0bf1Lk8+0c433+1VT/Ek33?=
 =?us-ascii?Q?JkB9tRmNLkiQuIIVxkSHHDROcKPCXS5w/XOZdE3FWEM7y8uTM8buwNQVFLZx?=
 =?us-ascii?Q?9l2qC3bRqzMFLLtj0hxh+1c3DmP6mX8g6J0Cnw+gYAgW78RaHUqqFLo+rpd9?=
 =?us-ascii?Q?qzni2TYG1Otk6AbB2L5pgJbAf1pNeKSXEs/j6r6BGy5z5O4YY8cF539fuKEX?=
 =?us-ascii?Q?OiNiV8NEcmlYc/pAz9JbgCJ9MmtIs4dCtu9a2sqlz0cOpGDCVZd4euLkbgwk?=
 =?us-ascii?Q?8yes7nRQ41uBQZ4rbeAVSiWTbgClzJQLMwKapY3q9KFuyNKF50GLWWrSd8pw?=
 =?us-ascii?Q?1WpeJWD5YzceevoWzogMIs7IJUJ6YzeTqmCNPKp0LPMWC7w27mkanyswaN9w?=
 =?us-ascii?Q?J19f0RykLstjWpXHz8tUh8qDsYgd9FcKDboOWjvPmGsCXT8cwgwjOZldL66q?=
 =?us-ascii?Q?rzNLKJNvr4i2zRjj0SsidUnRrPL1zj2d7nqZS5w8gPpIA43v6V6qZDtup0cK?=
 =?us-ascii?Q?M6kVuTKcJxK/dIOxyjncYdMiih84Pj4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ad6532-c47b-4c21-e491-08da319b8eb1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:09:01.4904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27JyNnmAw1O1m6wU0zDYQThEpFASkcqG4wkmSdhqrCdGmYIxMZvm9xLbnvqfV9PDVEfMFCxMlAtxx42/hL2zbqn8oiAit+gZnduNbjJy90k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.858
 definitions=2022-05-09_03:2022-05-09,
 2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090052
X-Proofpoint-GUID: 4_eZPyKV-26tRqmUwP9mGya0wSX1L9_n
X-Proofpoint-ORIG-GUID: 4_eZPyKV-26tRqmUwP9mGya0wSX1L9_n
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, David Airlie <airlied@linux.ie>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 Wenhui Sheng <Wenhui.Sheng@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a missing amdgpu_bo_unreserve(ring->mqd_obj) to an error path in
gfx_v11_0_kiq_resume().

Fixes: 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 184bf554acca..92312f7c7f29 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4312,8 +4312,10 @@ static int gfx_v11_0_kiq_resume(struct amdgpu_device *adev)
 		return r;
 
 	r = amdgpu_bo_kmap(ring->mqd_obj, (void **)&ring->mqd_ptr);
-	if (unlikely(r != 0))
+	if (unlikely(r != 0)) {
+		amdgpu_bo_unreserve(ring->mqd_obj);
 		return r;
+	}
 
 	gfx_v11_0_kiq_init_queue(ring);
 	amdgpu_bo_kunmap(ring->mqd_obj);
-- 
2.35.1

