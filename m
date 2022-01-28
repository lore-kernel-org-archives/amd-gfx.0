Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AFFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C528C10EE68;
	Fri, 28 Jan 2022 14:46:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA0D10EE68
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXd3CrSgnyEIk8sIfIPeQhwz0W8rPWGF9XyYZxvr+5pZPn2x59KUxwPaKU49m34FtBPlzRMFm8VxgLcljzOP53vqeSi2eSLepe+A5dOhDINJZZiDwGEUPCRzVEOv4XK+1ZdiKXWryrSi72AxsiPa3fE0h+g1AN6AMoKs6ebptrwaZQLIp7tBc9+nZulhQ+t5ouLUyPT1B26vA4p/1tiWer/lZat7h9JOyx0Ev2wIN1Q2SVPeM52jWwbww7FvIGAXKF6vPaAE/go1d3inoKaWfZLPaOC0deV+lxswiEHHmXzHg4Uv387isF1kgPyEqx+LXqeDhkB/Jue9SucTDbg5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVdCPNz3xgssXSAVyRGVl6buD1y1cb/oE0O5y6SE8qU=;
 b=RDrhFOe52f61TN3bIAtwUPn/Vxfb7sPXD8Cps+OWgmaSAY9gmoHt2AyXRpEA2RoCduKodpFbj5DWtUmYN/k5hsJTX+ai6CIvaR6fMoIegVVauxvARloj1tDyl9GQfgSckxsh6XeZLPOTc1oWH5lFtWkw5oLNQWGg/cl1UbvaL3etI59BtE4s8wL956W5fzK012QsrbmAh3NscOi7G1dS682SeVslv9O1o1VNbF6lLt4Wyd9kkHlL64GvkRs7yOWZMHev4oo/Uq7Cm1aS3JWnZcRQF950PM7koa1Je5oEol75vKpyTzxfMvWZEpi9/r32zca/pyBHNsCt/yKFvbtTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVdCPNz3xgssXSAVyRGVl6buD1y1cb/oE0O5y6SE8qU=;
 b=FJBLTQxrr8ozBzjjJ93QU8rePuOkUcT/3fAhxfIgv/BCtHN0XlxxPQyo8rYB9iKjypLdqirNX7PkSOmbn1yq48rLAFWvjZaDrbMUVxC3rtpAjOhBLIBJ4OUvLJngL30CIBcyh7omM9CBavedLM97Beae9hYjPWXkxeJh13ap7T0=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 14:46:01 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::1c08:b009:69da:9d91]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::1c08:b009:69da:9d91%12]) with mapi id 15.20.4909.019; Fri, 28 Jan
 2022 14:46:00 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Fix variable set but not used warning
Thread-Topic: [PATCH 1/1] drm/amdkfd: Fix variable set but not used warning
Thread-Index: AQHYFFTrNwztRzkOBE+UF+PKidmGIax4gr8Q
Date: Fri, 28 Jan 2022 14:46:00 +0000
Message-ID: <DM5PR12MB1323DACA9AC846D94E40545C8C229@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220128143914.17343-1-Philip.Yang@amd.com>
In-Reply-To: <20220128143914.17343-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-28T14:45:58Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d18c5c08-43f0-4254-b7ed-110c787df984;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-28T14:45:58Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 417c76eb-f30e-4b0c-acc7-9cb3fa7ad31c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7958669e-339d-485b-a092-08d9e26ce6fd
x-ms-traffictypediagnostic: MN2PR12MB4389:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4389FE8E08EB7E7D2FC88B328C229@MN2PR12MB4389.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHJYakO1iwkGyeXRvmMesSaNRidtAaqkD5Zb77UVrOBBlHFkByesTzHjrCh4+S8pvwy9BHd7F4QQ2HqPOPbQ1jdOLPx42NnMEOHcvKIUEmTheLfWGA1/x9ZxyJsKR14B3PsB0NullLYtWZEwgHUTtpNcNz4RFT6tMC49nYMSbLMgvGFm2s7UxSGmfeJUQ5Rb6gaJYRyxHFx6ksKlQpMfDOXhTYzNZeqlmZxyT+fRtoB0S3do6bwqLl33/4KhrnthvCaR/LtXB2lo2rRw1Extx/3cc5y9kqUU3x01f9UDRi+JplL7VsL5oamm3p26Pu6uwW4dOE++7pckrUyg802NK89vidkciowB1yaG828nbBiMmHLYU9TmLe8Ug8Oqt7A3Qn2yrLDLxJ3di2yDzxLcYwa78slqvFr40tFS3LokntrVcZk3GRFFVPVkpFDrZxP7qbI+K2Dg9/MZs6sB+pXEuXhF3lDIerSTL7yYFAu2t1m0Wsdt72aRKxWiJ+mLfTOesmEFPf+byRoyTAHViRlccaotuFd3g+yXfSu8lz4yV7pPcd3s49jYxQfjlWlgkGyc6BtQHtiqcmH/VQR3IUUJfx0Voeyd8j+lUU41x/rieHnp5GkHGhrb3mW8dOdujLeZyNihTlHM0d2XfxD+ED7dvaeOkxVtnpaAWl7T2MHB4a61re37LqRQ/O0gH8wzuZPD0hqo1IuZsyvlHOy5EVylPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(33656002)(508600001)(110136005)(26005)(316002)(38100700002)(2906002)(55016003)(122000001)(86362001)(186003)(66556008)(66946007)(52536014)(83380400001)(66476007)(4326008)(71200400001)(76116006)(66446008)(8676002)(64756008)(8936002)(6506007)(7696005)(53546011)(9686003)(38070700005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ulZeTsEc+ErE2CsbuPL8QXt6qJyaJ2ctALpyIzKabsqKu1352DT+3nz8rO/Q?=
 =?us-ascii?Q?5ZroC43zjlDVK53uB44iEum68yf6yIFbXO00zo7quTuy0EMf3j1L3rSQIwEB?=
 =?us-ascii?Q?E/VXz67bmp0OSyGL/VCHbRRvGB8oj4YpdRqGr919R5DlAeRjmICyaR+xo/Ds?=
 =?us-ascii?Q?sCWOeu19obYnEzOs4seNbhyY183MmM5jghnZRlakfMgsWcHxdNpA4zc7DLIK?=
 =?us-ascii?Q?B+yrQpCE/1ZmuG7FP5H28fFFIsCf3pHw3Jr/9MgEjyvCknP01wDamQ8bBUQP?=
 =?us-ascii?Q?FIr8z1jvxOWIk5oJya/PyalZNpFIwDlDOS91SaJyE3JQjICFbxBqvPYBl5CM?=
 =?us-ascii?Q?vAFEykNB52hy6CxNtpH1Q5OmnOyu0EcVWdLk8Gm7KLpXXoiIz19L7DGXhbNV?=
 =?us-ascii?Q?Pmg7HYIArFUXwhPCirPMie3PhRSee3gqIIgmIvtmCr+n8v5+dK0FfK9I5yMx?=
 =?us-ascii?Q?UBgEr5/3sHdx8HMBZdbb9q/YoDQq98y46poa2ZMke02TCNJw9/Anv/wmzee+?=
 =?us-ascii?Q?eeasF66faRZABQAvAXZiL4d2+uoSZ1qgghv0G7Q/bJhq6xjReVwUV7lY0Yo5?=
 =?us-ascii?Q?VSSb0cwZ7slY6WTvneAfb4MHxBPYuWQmZMZECeAXLVRuljYQH93fg8PVUel4?=
 =?us-ascii?Q?KjzWlpnJCbrJXzyz51sWxi8KNXYWGcCK/p7gVS6P4CNiKhBqFU6LuUuLHe4z?=
 =?us-ascii?Q?A7xRtHsHlB5wdCrxQA8y3485PQn1DGSxw3eeAkVmGuEJBjuPD4kQeRxl4Cdt?=
 =?us-ascii?Q?OQu3/E40+KotLErnHS4mNLWRPMgiIk6qNigOug6YFGa7ZdLqBP2wmR4YT7+f?=
 =?us-ascii?Q?YqeMYnCjoUO1fUeXjmpefC0ItRBSCxgd/V/ynd6Lt0WfhatNc6BNbsgg06nk?=
 =?us-ascii?Q?qKn6N6+thVTNRIn91M69kxs8K6aFDkskbLrvELwr0Y6BpSsZATs0Tdf3HsNl?=
 =?us-ascii?Q?QJodq73naI36ebG8UwKvFd2MdCKbrcOrbG4EzPblZbBTnAZqYk9NEj3detom?=
 =?us-ascii?Q?XeX9CwxT04ADObU11qjpO3Pyr8+9/2lqHn0U5XMATeKQa0JUw3knvdqOIdIl?=
 =?us-ascii?Q?s5yg2bbYr9ZMWwERlXWQBJYpaetYYWnyGeKjHfLtsJOiKic2fW4F+NsWow8I?=
 =?us-ascii?Q?3wFEfif9gkFquea7KDZkQT4rmHatCoRDvNgNZY2W59Y7521/7h8I+rLjkUhq?=
 =?us-ascii?Q?zRg0698ZtxbzZTZwnM1B9O9uvPh7++2sj/HjLWwninSOQkWwd8az3ndP/SaW?=
 =?us-ascii?Q?usf4pxH4WNp2xSxbvbbKvCAUQ+hYQcO616MSZ4eH14ZOltfG4AVV3Zw/q9FM?=
 =?us-ascii?Q?XbTacHvHCPHMP+I0EthEu1odqksYtXb190uZsEEqHUkbRzURRZviDK3UyCgk?=
 =?us-ascii?Q?VcfDFLYWuqRKBtUYpA++cSYNbfIKnTFP2rKfNkMNiGGM4ef0+yB9qq7CveTc?=
 =?us-ascii?Q?6wpJ75YrA+pqxM8FIywmQQJjrXhzvaUDMxoTJOEcct2hmaHtijjHXcuGeKN3?=
 =?us-ascii?Q?FtuyUk6kfPu/Qa1exZ3EU6E4JHGqKAH5o2yhFRgIAasbZ5BCLUfek+8aXneY?=
 =?us-ascii?Q?nLSSaizolmrVcFF+rEtAw91S6ykE8IGdOifthcBkK7lkbW59hnqKZPhTTxGg?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7958669e-339d-485b-a092-08d9e26ce6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 14:46:00.8737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5e6UHALAhQkusIRyTla+uWUyshknhvmpwJv4k+uaoq4kJ+pXpFQcmPrrisIUnOmr7qp0QC9GnrL4BDyFVEqIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-By: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Y=
ang
Sent: Friday, January 28, 2022 9:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Philip <Philip.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdkfd: Fix variable set but not used warning

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c: In function
'svm_range_deferred_list_work':
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:2067:22: warning:
variable 'p' set but not used [-Wunused-but-set-variable]
    2067 |  struct kfd_process *p;
         |

Fixes: 8b633bdc86671("drm/amdkfd: Ensure mm remain valid in svm deferred_li=
st work")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 649c1d2b9607..9a509ec8c327 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2079,13 +2079,10 @@ static void svm_range_deferred_list_work(struct wor=
k_struct *work)
 	struct svm_range_list *svms;
 	struct svm_range *prange;
 	struct mm_struct *mm;
-	struct kfd_process *p;
=20
 	svms =3D container_of(work, struct svm_range_list, deferred_list_work);
 	pr_debug("enter svms 0x%p\n", svms);
=20
-	p =3D container_of(svms, struct kfd_process, svms);
-
 	spin_lock(&svms->deferred_list_lock);
 	while (!list_empty(&svms->deferred_range_list)) {
 		prange =3D list_first_entry(&svms->deferred_range_list,
--
2.17.1
