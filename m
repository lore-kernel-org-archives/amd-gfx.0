Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9316CDE000
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 19:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E9610E258;
	Thu, 25 Jun 2026 19:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w7UeyYu/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A4010E258
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 19:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sx7b/ExbDJIecmQlNkg5wKPSyHXt67bbpTOyiXx62oT8pr4n+ZLyXhaowG7OLpUyPn3Ts4Y7TvdDn8VqFURqkVdNFBKnECNtRMCShCYge5cMYfZCmByZGmG1GEUblnlH0pVGVzhDBE6453ZQDgm8rOBMgH/A2PBT6yVTcXpAYwcLU37yW3NslUFmXpzfnMX5VcUtJ897wCUVM8ZuvFN/aDbM7qKhDZC+jd5qsZ6KebbJ62voUAZlvDXVhFJIV4Db0wGdjNdOY6D4a1D/kV0iBHbWMxzu/aH39dDiyBYQM8jDH3uoUaBjL1qDIXe+JARjK1H8czHuvbQY5rBX1DyNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7M8U669EUDrz2gqaJHeiPGJdeIsMCk7pSINji2hVqI=;
 b=SpImoCivo2b5TaiRrFBAsfsJMzrDOh3CDjSpW6XbecaAxklnj/ejxd52UMoD1QstyITV3NKPJx3Ow3iXEXdr6SaKpWdowf6vfqrLYoUNsPTnBYOWG764ej+xMDU30WfuMjDIsp23q372/cnI0eAuaw8PkMnTtGzXP+M0eetpln9sIxLzdhSurKpCHprBtyU9+wXXY6Azrc2RcQZg3yhcMve3JQl8geijoMWTdLHDqLeTKAkxNNmKDhuYd0IY4RkP5UDPn3CXGIBSlhC93KlPRJS/UfWRX+hvo7ZKl+ss+jaU/Kts7FY/MCqFQyQJgSSCoZ4/z3C1N0WEQA1pipa43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7M8U669EUDrz2gqaJHeiPGJdeIsMCk7pSINji2hVqI=;
 b=w7UeyYu/sVBeT9oyhqPDvFfvqZ4gzQpvqliL7yP4DGcMfpiucSWBzrivanlR/gREI8xVoFd5ssVp3ecjGJTytLfbxsTIk9aVNhntKHEdm09K9h2/Jrb1Cy5Z5kNWh/1FXdAYyjw4WNTvaTnMX8k4CfLKm/7qd+YmVErNXXG4B3A=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 19:22:42 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 19:22:41 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: use node XCC count for v9 CRIU control stack
 restore
Thread-Topic: [PATCH] drm/amdkfd: use node XCC count for v9 CRIU control stack
 restore
Thread-Index: AQHdBNO8YbltkvBPE0CoICaZDv8f7LZPpj8d
Date: Thu, 25 Jun 2026 19:22:41 +0000
Message-ID: <SA1PR12MB814402FF9F14BFAF56153D0DEFEC2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260625185145.733651-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260625185145.733651-1-Yongqiang.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-25T19:22:41.019Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|SJ0PR12MB6941:EE_
x-ms-office365-filtering-correlation-id: 350fd78d-37b0-415c-fb58-08ded2ef2056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: 0Bj/ioZmQxIOpFx5N6o7N9setQBIm/HqA2Be/EGO61lD0Odrj3gTj/R8oKKikDYXmoUdlstAwLiXSIzpf7Jf0T756GYkjt8fPSS24NhKw8BsQLwgOFrJMiKrOdj/f3+JeGz96s3XLEVUzmJiSafsD2DRdQDuz/XdkSgsGR35ZnYl7/I+61TqcOmP8Kx+S1PS1ipw/bN+rPdCqhJjrfNOH8TUJOoLr4vGskL4FTzbYuIgSOzAC1ldqAmIxLWP1GugjT/HA3vsiCveP8XmoD6KH2+pCClNEqkady/JrEsHjMohdLoa571I8by9DDMxAfzJk4jaAKa2QLzejrAiXHPDaJe615guM3t7JKgWMRvvu7fFmSRZnav3lJyLLE8dL9KuKDfd8LU47BIP/YGvjlOl9KLTdY/7xiTegXYKS1mdd1Ri+hcL+z3x7+D7NxbJmSTCfDyvvwJXme+uAWKbzIHNH72HsnngwH1X0aR+9WlcnvQnHN9Ia0cHxQZuFXlP+1/QPOGiI5MTizYn9oSLeuNUv2X3GdvGzu3euEtsX7ICGu2tdLUBOSDlpevHTVzoyC+x6USzlsMM/ZOfl5GXakCP034JL4D576rxaJMX1KKjIAEhqgaE8lODkLd/ISbGfM1sPOIQyPzQDDZCvtfNvbAK0Prv20rAjahi3ilSYQrBfUWM4+5NkjG6Y2oC1ZPr8bZ4B2icNnqvyKJziBur82wmqgVvEIKQhyIZ13wQUL9o0yY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pxji/IfqYxJ10bkJA9gaI0l09w4eWAx/53swXlMsgXOge+0K6mA2FMPrPucZ?=
 =?us-ascii?Q?PA17vUz4qOqhx3k6R0hMzX6J3OVt3nJo2KSooftgQaGM8O7q5pcC+eLQQf3q?=
 =?us-ascii?Q?LBblm6u4QbjUiVMqLoaNQBnVVIzfTzNTUj+Hdv06ZfEbt27lxPtdnNTCFEjE?=
 =?us-ascii?Q?SozO7eosW2U5IyRPwhzPAiPHY36TqO7CKUKBInf2BBzh+t6LZtkDUk9Y/KdU?=
 =?us-ascii?Q?cME3tr+aWbyj3u7xhPNjH390LdHdmD5LcdG4rM/2GunEQ27qNJjRYsiI+ZgO?=
 =?us-ascii?Q?B+GpfuqUnyCgjrTxu14h8BJuo8pub5QrzrCNRL6kmsY4IbOIPotPTUyBjCy3?=
 =?us-ascii?Q?M/kCLazWJBsi11MZ+8Pv4Y643jr1/J7O5hAnCVPkCqATfqJbacRcHuEowu8Y?=
 =?us-ascii?Q?oAkzFe67wyF4bE/AcVuAYxBBAmvodgbC/LRwC7IJaItXnUYNq8b5skqjtXoK?=
 =?us-ascii?Q?ecYbN6N+1CIgccO7KYN00pshQjwtEJD4xFMjcxgj4IC5n+zMY0PKJRmBe3WQ?=
 =?us-ascii?Q?Hb1d8VwIpBGNHHz+JB5jJ1zvAZAg34yBkHU/ehfMy+R/EY5PvsT7aI8oDxCs?=
 =?us-ascii?Q?Z8cI5dOoCpop+n7+riTAC8HkfU1Ef0mXtXgJBKG7SwnnsNd468Y9Et79obsm?=
 =?us-ascii?Q?7aFCG3P89Y49riL/74PEz3M9RD4tYfV9sJ6r7oporHZk08yMsN3zFGNwraVo?=
 =?us-ascii?Q?aoju3C8v9M07xNdy5GbeaM7u+J+e7RmMOQLTFA5PlcPrPLwgYKZOOYO9XpAh?=
 =?us-ascii?Q?ki93sSDG7lHVD0LHVUSPvxcp4Y1JA3YaXmDkGGuQ+5rPaNr+1op8bVhyO3xh?=
 =?us-ascii?Q?/mN3Nsb+m3Tz7ve01NDJbPegs0rHyK/7Ox5h0M3rTjhObJ4qqUljPpjnW62R?=
 =?us-ascii?Q?YHxyBnUET1dhbcmyrxguCfNE9r2PR1fhc/qjbl2NlOscIa8+1glyTHZd0GOP?=
 =?us-ascii?Q?u9OWggaqzJB8WTezg3/X31mPIxGbMQFSqHDw7cCq625SPj/UCmIS4KH0VieJ?=
 =?us-ascii?Q?TwgD4aO0WSf8j7ogEw2VGZ96sd0AHhZLbDlzyhNrRciRRcI6RMHYwj1Opggy?=
 =?us-ascii?Q?xXLPG8pWhiGXtIxp1SYUgfGHPyd7AWyRnUREhyG0jyemNShzw/U7jEQimaNc?=
 =?us-ascii?Q?QgzHPqcoqO/9p0EnEhBBSYIOSrn7Iy4k8Opee2sSYEoPepRdI6tGM8WG2V97?=
 =?us-ascii?Q?k96eKOs1SrOywvdc+yMOpaGWLzABRlx8oaEfrWlzBmDpJGz8L8hCnq5oYuT2?=
 =?us-ascii?Q?f8vwE2oGu6MUUwyZtD9WQBFp3Wq+7GSp/9MxwvnLqnJA50oH3OlL/wNuiiXR?=
 =?us-ascii?Q?gPEG39kfjwg993sRsaxtQSe7zxVwlqMS724ZHw2NFQLhtS9MTUbX6C5QxJcj?=
 =?us-ascii?Q?HrV1O16fsEtQ80ieUg5SIZHb7JQVIGWbtFhJMDFJdM5/DOYFpUJgex9r/l93?=
 =?us-ascii?Q?pwfXAr21z6G/ferQ5KGrdvZ7J3VTMJMSNXQNLxPGfV5dwjGqHfHqDaLqvch1?=
 =?us-ascii?Q?bNWOH22VULTCXxYIgGwznTwx4O+7xWQT8WW62RseJnGOpr5GXEzLC2Ja7nXC?=
 =?us-ascii?Q?RG9C8+yTrDAtne/4AnzqhA/V/orInkd6BkoIryiaYCTHhxXOp/uuCN9n83zz?=
 =?us-ascii?Q?FfMU4U7vF0cOASnY2vwOIc4Xj/LjGnpSAml+ajJmwVvfUDx330f+nebCh4K2?=
 =?us-ascii?Q?pz18qKMPKks3d/VnB762MGZJI+hUHcZEks+YFt+8poFyv7PC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350fd78d-37b0-415c-fb58-08ded2ef2056
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 19:22:41.4516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAp+dosEY3QIPEq1VsPv10N0Dzfk941rsFbeCVeLak16b36zbLd5RQawwuWPqBdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nice catch

Patch is
Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yongqian=
g Sun <Yongqiang.Sun@amd.com>
Sent: Thursday, June 25, 2026 2:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Yongqiang
Subject: [PATCH] drm/amdkfd: use node XCC count for v9 CRIU control stack r=
estore

set_queue_properties_from_criu() divided the checkpointed control stack
size by NUM_XCC(adev->gfx.xcc_mask) (whole GPU), while the checkpoint
size was recorded, the MQD buffer allocated, and the control stack
restored using the per-node mask NUM_XCC(mm->dev->xcc_mask). On spatially
partitioned GFX9.4.3 (CPX/QPX) these differ, so the per-XCC control stack
size used for the restore memcpy could exceed the region sized for the
MQD allocation, writing past the BO into adjacent kernel memory; it also
broke legitimate restore on partitioned parts. Divide by the per-node XCC
count so allocation and copy agree, leaving kfd_queue_acquire_buffers()
to bound the size against the node's advertised control stack size.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 071f956f183c..0a7276eadf79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1040,7 +1040,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
        ctl_stack =3D mqd + q_data->mqd_size;

        memset(&qp, 0, sizeof(qp));
-       set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev-=
>gfx.xcc_mask));
+       set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc_m=
ask));

        ret =3D kfd_queue_acquire_buffers(pdd, &qp);
        if (ret) {
--
2.43.0

