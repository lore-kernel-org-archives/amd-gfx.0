Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828E0C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545A261279
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545A261279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BBF6E051;
	Tue, 13 Jul 2021 07:52:45 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079BF6E051
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:52:44 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16D7l5QT007527; Tue, 13 Jul 2021 07:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=o11lMyEO+dMoeJQTZJFeSOo7lNIMak/bz0e8ozLRG9Q=;
 b=jX+g6xs4+dn7JP9A0KeaImSupyfn8QvQc7J7c6DKAYemv6wloHSU4b7IFekPKlDkbS6R
 t+9ncVGDxPfVdZhV3bNnuo6DdtU7zGrwQ0rz8TRyX6LfeKU3ho+xnG8aqMtkdcbbChzt
 nxtiyntidQsBLKV09GH+qDGtHcAURabyPBJZ1/OdHBBa06onM4LR0F68mAleOr3Mn/Dt
 5yKN0nMg4qrU6os9lhaYAndzHS12cQR5gMW8Zi8BG6lzUDaxFbt+es26aQMiN1NoCyuY
 ugsunHKwhxq5bDOFHUQqb6yMiWZ4Qd5EICe7j7KDyZCSorchgCg1wLBodanX24f8pEIv /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39rqkb1n3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jul 2021 07:52:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16D7otrC055078;
 Tue, 13 Jul 2021 07:52:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
 by userp3020.oracle.com with ESMTP id 39qnax30fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Jul 2021 07:52:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZpmrUB6mk2VH7SQ6iClan46msLAZUU0F7+AHnE2i7Eran6Kgo/4h2gjlQ8Q/FNyJCHwfRMyOtqLNb2l9GWimEWch4Yu6J9xDR7lIo81RyQP8V+q9biW9ou/3MXHKu0ky0/Lj0EQbRgMq21oumiy5s4tFCxcqQ3Jnecb8D7Omv58UM1zXHC0DYo5Ht9/N1xMVQlY335pcDRqxdz4TZXbPo8ovaVllMIFYsO9dvCapv6KvcnyMuL86H1IICqvLWvX0U644TeftV9w5soit0jAY3LcxFu2CJw4tiQ3PMFHZ//9uKsoV4QdOVrsZviwucHIat/vLmZZ6d0lzAeYYaq1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o11lMyEO+dMoeJQTZJFeSOo7lNIMak/bz0e8ozLRG9Q=;
 b=iM1iXeHbzw59agtVgUys7egRf59R4kkAcAQtCG4cT6gkk9urCVzVR4w+JhBN9wAq7OmCJzthnqgeQkMePZVUWCE5yDcXPlWMfooD9edtgtsAomC3u6/S3H5ytO49dpvRmmDvuy0PK7ktdInWKxmiNu1A4LmEwWj3gznnSHtWrf53ojxzPcjLr7xP63Y/zFHuesS8S/69vmcVWciP258ActiTjnEr26Kcb84sjMJsx9bkqapYz7UgHwKpnuq1l02akwA93R/QIvSavqQsm+wbPkLmTOrBMi6HUtC3Nqkplcy69nX8CTe+L6tCWY+uPoJzjxdybu2h158nfhQUAWNLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o11lMyEO+dMoeJQTZJFeSOo7lNIMak/bz0e8ozLRG9Q=;
 b=aSN5yxg8xQWPibP0nPzRcGuQC19fbdlhjiRBRqgmbBXrH4OKrDyvaV5u+uW7FYmcWQmiUE7RywGMdRoB6a/JWw3XfI9QGkm2GMdEQN1/oviutFY8n5bR+oNHGVkdD9CDNi67RXHAz/jGgmzzW2BTJMvyWZ1H1po9knkWjvrDhXU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Tue, 13 Jul
 2021 07:52:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 07:52:38 +0000
Date: Tue, 13 Jul 2021 10:52:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: alexander.deucher@amd.com
Subject: [bug report] drm/amdgpu/acpi: unify ATCS handling (v3)
Message-ID: <YO1GNnttyqTCUsP/@mwanda>
Content-Disposition: inline
X-ClientProxiedBy: JNXP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mwanda (102.222.70.252) by
 JNXP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19 via Frontend Transport; Tue, 13 Jul 2021 07:52:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b62ec68-48db-4af1-93cd-08d945d32f50
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44687F15F6CC07045CC574FB8E149@CO1PR10MB4468.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSY7G7LpxzvHzFBMxXq1cIikVqS5AuF9+/ZIhvg7bAofDxjC2S7TPxoyJIQQdKVWN0VhUPtHOsV2IkTqv+fEeADmmgdDI5eAAfR19De0vbA0DYZsCjZ7tHAOPl03L6/0T1VL+ziUSb4fL+wutlG3aC4tuXTiJzMqSyp5Toz8FDH6O7rXVMdvzctQVv2CNtSEyWuMoqQBySArWYRxxc+EomUpM8ck9XxGSMk5D5xwr2XfIar2ljVsBZUlWq5/VahMFX40lzWnp1xEtlV46F7rxpBqeqvuFCNYgsZfFFkyVDeH5HFWUFr2ajRcoY+kkTj9C8Z3CwcpF+v+BeEXQ7jcZcDTAnhoQol+qSzB+XZU4bB19Bxlo+OonWFCZG5UqsO+wrLSh75+S7wafSIYgZqPwr0T1nb5ubpTOHGqzOIrfimPtqNjcgWuiPsL4pfd7p7IIPZUPBXpFtkB6QPbbvpchhx+I2sKlLHZBizptRYFfrRcRivsREM73qrv7b61GzPmMLh1iCpoZqKiROCa6cP2OfT7WGO8wWpPlGz+6AIyXh14kUNdXJoJTAfwzrrxMmJjHH0Nl8Ea6HUIVvIHOOAkOYLtpieVbWZjxtVbCIsgoXlm6fn6hd69a2dLra/ATmzoG8c49z4WVwip2S+R8RgW4A7RXwUYDg9oELTU7xJ4Q26olDP/cg7OyRRKw7xPoXHir/KYYhqlJrBVZGS1mQ2Rvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(376002)(396003)(136003)(366004)(4326008)(66556008)(2906002)(44832011)(956004)(83380400001)(66946007)(6666004)(66476007)(86362001)(478600001)(186003)(8936002)(5660300002)(26005)(38350700002)(38100700002)(52116002)(8676002)(33716001)(6496006)(316002)(4744005)(6916009)(9576002)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHJCB8w/NEYLm33C6YWfVlNjeiGuNJz7ZVPZHapI9xduo5hXHxCNmbqSzg/7?=
 =?us-ascii?Q?6ULQ1x6Xt7dNKVWi1EHCx1GfDdqlyidO32qxGrDkvjX4/e6zzDba98tN0BUe?=
 =?us-ascii?Q?hzGN0h9zAzSBkC4MIU4Q2Cv1iVNlqBIaRCxQzSPF0jZcgE/NC8Ax/oQ7k+Kl?=
 =?us-ascii?Q?BbZ7tPYorTiCxH3IWxiJ0VSJM4N1LUHRtYliSYZAaMFrEKsZR46vbvCxefuF?=
 =?us-ascii?Q?UCqtALFdVKYlIGHnKeHBjUHXNgmPFCe8h9APimVkmNUHMxf2aYqI+sNCrZpm?=
 =?us-ascii?Q?aD/Pu57Mv/Gz4qgMDPYt9yLy6xhFhzHzqE/Y01Tum2eVvunwn6tt326CkK33?=
 =?us-ascii?Q?oBK3qDOwbbrNXu1JXj0B7lI0w3/pUG4kqMSwAZrVR7YbNtT2zgkEaurczAEC?=
 =?us-ascii?Q?BDbcebvve+0Hp1eKupPzUAaCNIFSGpoScZdvqToGBNydIuKJ90YV368MLeIR?=
 =?us-ascii?Q?GU521BdYtY6U7iecsQr7g+E/hHkTQkvy/UqCnlPqY1rVSf+aFN4H8G02F1ed?=
 =?us-ascii?Q?Te443PUGZiduI7SVg6K6ax6Z1VLT99umt+XF3KiQx+VKtdqIppaWDPOvyArF?=
 =?us-ascii?Q?K0zC1I/g5GCm53JPbHdHYTudaoSwU4njzTuoGMOI9YmfvaK41JHoA5sq0nfX?=
 =?us-ascii?Q?9PDoaB3mwwNItdSyenRWJd/9ODBnl/yxci+07PwHm01cXcZRvUj6e3pp1KHm?=
 =?us-ascii?Q?F/PiIoDASDshVLGo/Q9FPwsw3KeKvgAiNLugdmNiSTLqqFU5iosR7Mu5bW5I?=
 =?us-ascii?Q?3dfAGBS47UH6HuIXLyvA7qbEcFYQV4LaDJccjoMThNXkZz0r1xYACIf62sqC?=
 =?us-ascii?Q?iLBMHh22xKpVWrEX3Xzw+dSoD7cnun2B/qqTE2keVk5T21VohbzatQp4O0Af?=
 =?us-ascii?Q?sfXKyqZm0jVeZQlA92sauaAcn7q4y1QS4qJJogDPsVDALzSz7gaUfJaz8dsb?=
 =?us-ascii?Q?/o4Ire5dp6Ru1mbucHB/KZMFmbi3R+rHfVYzTgDiOONn8jIFDnJ2f14oVGeV?=
 =?us-ascii?Q?PBX2KB9iiO/hq9Lb1wg9N/tZE5lNdy8q+RutJvYz9p7GaYIc1qNO5gWc5NJ+?=
 =?us-ascii?Q?dkz26tkAzRm6l7aYUgpAExsVMjg9EedBVWzN5yifkyMjl5XEd47xCd8hP8qT?=
 =?us-ascii?Q?DCllhhehHVTI+7qmzUaQc/R9HK2nk9oDdZA8XMwHuoOW+1UNAwwRwZUGRUO5?=
 =?us-ascii?Q?hqPs5OR1GTiYYEtWbj8SLAyDSFgZAf1zzDuBcoIHQGC+X25FzBBI9cTudTo2?=
 =?us-ascii?Q?Edz3vpZaD9M55fclJgNcaakVDDJC/cljqrxuydfhHN5Qj1dHWPRPQQzbLSdl?=
 =?us-ascii?Q?BVzL2AIij5SjEHz3YP6jWESy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b62ec68-48db-4af1-93cd-08d945d32f50
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 07:52:38.5770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2K4MIMA0dX4zvTwvKhHideqWXn+Kzlpd/cwGQvKva9N5QR/tSjUBioiO9aYqsJkn0A7E32HEbOnr9wwcfZ17IpYomaPNhGyjAzHY9W33xM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4468
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10043
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=980 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107130049
X-Proofpoint-ORIG-GUID: fqbAvvZ08CPxJeA8qJV0cdfEshH9l74e
X-Proofpoint-GUID: fqbAvvZ08CPxJeA8qJV0cdfEshH9l74e
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Alex Deucher,

The patch 77bf762f8b30: "drm/amdgpu/acpi: unify ATCS handling (v3)"
from May 19, 2021, leads to the following static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:857 amdgpu_acpi_init()
	warn: this array is probably non-NULL. 'dm->backlight_dev'

drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
   848  int amdgpu_acpi_init(struct amdgpu_device *adev)
   849  {
   850          struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
   851  
   852  #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
   853          if (atif->notifications.brightness_change) {
   854                  if (amdgpu_device_has_dc_support(adev)) {
   855  #if defined(CONFIG_DRM_AMD_DC)
   856                          struct amdgpu_display_manager *dm = &adev->dm;
   857                          if (dm->backlight_dev)
                                    ^^^^^^^^^^^^^^^^^
The commit adds an unnecessary NULL check.

   858                                  atif->bd = dm->backlight_dev[0];
   859  #endif
   860                  } else {
   861                          struct drm_encoder *tmp;

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
