Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC81AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 10:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB1E10E730;
	Mon, 13 Dec 2021 10:43:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4000310E730
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 10:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFpmyHIx/m0bxJWuVgscwjNmsLu+SY1s7y7TiVuPupEfG/7JQjv14btweM7fTxBn5AC+OM4BRdBEUpI+irFwc80zK5TdfwcsF1uBvyDNGdYSpp6EoeXvPcEJXM8Jhhn+cztDdCVjrWUZXH2rbo5+pNbjb+gQW6fi4uIgOwfUdBS+qykm0XzMDBiqmYod4jHfmu0JQ5aF9CZzwU+C6iGztLyQ8QBai1y+dzJIeCrejRDJ8ZlYibijgA2EB40o+BUN4TVAbEW56uLz3Az4T4/Ni2POQlG/QXCaCNxeB4KkoqC6Y0KpS7kkluv/QyNOMDOJExpo46oQG/rF5IEFxAIgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XVLAMVd60sKA4kNDi8WgaGVgRwM2lmiTO81kuA9tQ0=;
 b=d6H91OzaF7gQHn/V3/IGXhDgfOKvqnfxgbfnZrjFewPl8sUyF7nHiOzS3KXflVDrwIb1G2YCfncJqAxyAua5n60TQdzsKDlKoG7m0FCblh2qSIYL/dZjVg5rqt8ZheE32OwxpMbXgtvErr+srRq6rokbpGyN5qFaTj5/4zguMV0XOYplfmXGijZGyud6cja4pntJUms8+in4+QfoglHMghQ7lWfx9qsJz2iYN2GN18N5ekE5jEeivS/b+P5YfVVoZwYzcAq7QvuyRypPib5Gm6EiSTxwrkpAWCMQqPPqF3CIU5TD33e2lNIPPNz8yCQ4s5A9MmWJOZJu62mfmXMqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XVLAMVd60sKA4kNDi8WgaGVgRwM2lmiTO81kuA9tQ0=;
 b=2ku3l087w1heagmHCYEHOTBlEerTdne866t4mO9oXDydSt8oOGT7JNsen5v54WfxkF91JPXSP7JnXGRH+LWgPswFpID+uqex2gTtBawejFOQWD33p1Ww+xzcVwDZjht0Jw/PbfQPDzT75bSUWOdzFE3lrV3H67KJxBsJqIb01rs=
Received: from BL1SPR01MB0002.namprd12.prod.outlook.com (2603:10b6:208:308::6)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 10:43:01 +0000
Received: from BL1SPR01MB0002.namprd12.prod.outlook.com
 ([fe80::89cf:cc51:ece:74d0]) by BL1SPR01MB0002.namprd12.prod.outlook.com
 ([fe80::89cf:cc51:ece:74d0%3]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 10:43:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "thomas.chai@amd.com" <thomas.chai@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: reset queue which consumes RAS poison
Thread-Topic: [PATCH 3/3] drm/amdkfd: reset queue which consumes RAS poison
Thread-Index: AQHX7bc6aSl+JqKXTEu7artWRm+81awwQIDA
Date: Mon, 13 Dec 2021 10:43:01 +0000
Message-ID: <BL1SPR01MB0002A6FD2ED57E84EDC28989FC749@BL1SPR01MB0002.namprd12.prod.outlook.com>
References: <20211210111502.17384-1-tao.zhou1@amd.com>
 <20211210111502.17384-3-tao.zhou1@amd.com>
In-Reply-To: <20211210111502.17384-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b73408fa-9ff7-472c-9102-38c5851f77b5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T10:41:20Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0acc5e0d-a663-4ef2-8277-08d9be255602
x-ms-traffictypediagnostic: BL1PR12MB5047:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5047F5D1EFCFEB2F69E4153AFC749@BL1PR12MB5047.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zS2n8fhwEnPgy9j67gDhyrMx5iSYrIrw7hjuqnr1YAM+NAkNpu1ulBFs8k2CsvWhoVCHKoqFHucngz54wqpyrejX0OEceTxOY4Sb7k7vE1Y/czfPWOGWv7/JmCRTHDcObpdh3Ad/xI1aIrMQrEiVuoZ8u6zwTL0JxWADV5u5NbHGALHdVrCidWAc+/YgXYxYjiI7/CAEemNLqLIGp4W6RSRPeCOU8fp00kckx6M/fJyfjbcWvIrlJnlJvmvyN1wJYadjb7DvUIR6yiTnBJ5TI2C2HvVGbkKw4DQ9+R47jaXFc57OQy3zgWukQ0I1mPryYBERkyFE5RAFXV9e63y+OuZQoiF/7feRTe7NmZO2DMhXZjCaQrRdJRB4wCQ/aoCBOmrW7Or6Hrb+mqjlBSz0MBvfN4vSFTbP39GBWiqU7pb4JrrlT3YI8GZgcgi7PicHn5uXCKBa3KecWjlHRmSaTLJW6Vb1X8Jt7zP0mo/H7qiR3i+XTyEqDFuMacD2xe63weND5hxErrd2lJ9jbYeUuTsX82joMk6cn/IV+O70ScmCOGAlpOtswmfS25LArLBYh643ZO8kbrEWAqF63pE31OGRqEOP7E/CODQQA3+c/wOZclWqH4uR0exonCjtuGhj1stR55XnDt5jzWkerewsjVdt26JJxwSE+fM2LoyWQyyetdUucK3zc/l72OW2Cgat4AxTZ8VThe6ajhVF6ELE5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1SPR01MB0002.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(508600001)(5660300002)(64756008)(53546011)(7696005)(26005)(6506007)(71200400001)(33656002)(52536014)(83380400001)(6636002)(9686003)(2906002)(122000001)(38100700002)(38070700005)(186003)(8676002)(66446008)(66556008)(66946007)(76116006)(86362001)(110136005)(316002)(55016003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NAieZiSaaXQk0GojFqHjR6tqGJ5QERl7/kHWBZmpPLPcpF9hLY6JW9rvGze0?=
 =?us-ascii?Q?eOw8M3pOOd0+eOhxbZiW9bGey0zIuAiZFXiUthqqEtH/PZz31iuqAobDa1Yb?=
 =?us-ascii?Q?ZSq0fRW4/z1IhVSZCeI2pT4B6p5kZnXkPBeXBKmFHFN+kLEoVOallLA++fvZ?=
 =?us-ascii?Q?LGuBDBxs0RKZAxOvifkkj9VHoVE+fFM6cR6cRomDvetGaN2jVlKJ/BT+qwRj?=
 =?us-ascii?Q?06yInSVYIyYKgGTX5y7Mg3smH6hA5OZq7nwfNoq6CmN4NpyCMpb8abAVLwBe?=
 =?us-ascii?Q?kjFMaUSkr3WRL4m6PWp4f5QEtxODp1uF5jwuEQhWfSRhTnGtaFVQ2jQnN9AI?=
 =?us-ascii?Q?3vTAz4zNvE0yDZvg9i1K5nplDbyN1V8XSOPBZh7r2TXDFPFB7rm91JIwenUl?=
 =?us-ascii?Q?NMe+iy+EOokYpUl1oorVLwZ+W87ycBXMclRZdpfr0AQJJnUPSxptnBKajN+4?=
 =?us-ascii?Q?au2sMzOx3emSLZwe+sXv3zA4f/dUPmRm/wxwddG0LpVVpZiRJS2irIIp431l?=
 =?us-ascii?Q?wmd39VrRDDz8EzN6hZSdRmaom4ceVerCDlQLE9EOwsOSQCLGMTq3PP6tLrBJ?=
 =?us-ascii?Q?D9G9b6sRQSMfo2SULubqsDRpJtFL6rpcufPEa91of1YWlK8awG5AuZ9jjdk5?=
 =?us-ascii?Q?IYIbOw5LgG2F7ezorDU4dbQdbufd/vqb/zSU73K644BuVxSNOp0+ZJmmeC44?=
 =?us-ascii?Q?7Fqf4kuqSNIyXP3ZotSf6FJBtwqFk3/QGbSOzu1ko1eCIdOQaBPKQsYQFvp1?=
 =?us-ascii?Q?8KAfX3JPdJOyTN6Ga33vDY9csgTXNsdGk4cTxiBO1f+xhBo/yIgM0syulmN5?=
 =?us-ascii?Q?y5nDyeil8X3uRGoercse7l6mbGyNsXOHbdpgB7mzJSNJ7+TMyRtLsS66FQay?=
 =?us-ascii?Q?aBNbpJbhHOMLzAkOBZUm1YLS975GKAZNUECALbSQ2dJM3xAuFJmeOYSzO5oo?=
 =?us-ascii?Q?ymJ8/q52/7jhSqH1CRZh7uX1Hpq4fs3+Rtb3Qovm7uhdl5WmDK/uLpnk/H1p?=
 =?us-ascii?Q?FmPqY19BdsKGkeI01kLmDpRvvANFEyplLVQFNKPaoiC1eEFnPC9ecAa2qLEN?=
 =?us-ascii?Q?VYeRwZutsZBotNZ1PRAXpbDDZCfAsfHQ0ggbLrnpzfQQUAbEoskMruJut/tn?=
 =?us-ascii?Q?SO7FF/wU8UZ1mc+xNuRCFsRit1Nmn2OylQTpZWWpG1MQXpA1FJsWoGdbIsf6?=
 =?us-ascii?Q?czq7KvRo7IcPZ0suGM6VIBXgthGta+9BQJRpdiy2ll1z5WchjhKKPtI3YbXt?=
 =?us-ascii?Q?qe/59S+xwoWCHjomMixSwynv7/Q3CB7hAj7F3DJUxnBi/44/lw3SHLy+bDeQ?=
 =?us-ascii?Q?732/pjd2FXiq3xknCAyWjwNRvkvtIMnGx/hWxMH36ZXMwa/uMgPDbpzc++yA?=
 =?us-ascii?Q?oB85WQEQmkcT7IsC0YxN1v+Ny3tfWtpB4u9/d/IDESghZmu54kcxZm55l0zW?=
 =?us-ascii?Q?B4vP8Sv8PwsvtEpzsF6/iZn9wS/Y8K33W7FRTtLJstUFbdEJ6cGsyDj/r4p+?=
 =?us-ascii?Q?i4hWxoN3nlQ5QBgVLJAFKSkVlqhCOiohoQVbF4FkFUNDukSO+Xk5mBFYxsml?=
 =?us-ascii?Q?tnCD3Uq4p8iEsf81GZANhQHStBCIrR32rugnfBpuhGILYtZx6U8Jefg81GP4?=
 =?us-ascii?Q?rahOyfJnywclI/qvoy5HmIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1SPR01MB0002.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acc5e0d-a663-4ef2-8277-08d9be255602
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 10:43:01.3438 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0r48vw6HXRHw0nGVJMK0QdYA92d2m1p0aUVmNo3LA1CIDdWixk+icTuYWXtsBI4vST/B6FOXTa5Ak8rbCaQyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
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

[AMD Official Use Only]

                } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
-                       kfd_signal_poison_consumed_event(dev, pasid);
-                       amdgpu_amdkfd_ras_poison_consumption_handler(dev->a=
dev);
+                       event_interrupt_poison_consumption(dev, pasid);
                        return;
                }

SDMA shouldn't go to the same handler and need a separated one. (i.e. re-in=
itialize the RB)

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, December 10, 2021 19:15
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; thomas.chai@amd.com; Kuehling, Felix =
<Felix.Kuehling@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: reset queue which consumes RAS poison

CP supports unmap queue with reset mode which only destroys specific queue =
without affecting others.
Replacing whole gpu reset with reset queue mode for RAS poison consumption =
saves much time, and we can also fallback to gpu reset solution if reset qu=
eue fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 14 ++++++++++  .../drm/amd=
/amdkfd/kfd_device_queue_manager.h |  1 +
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
 6 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 46cf48b3904a..0bf09a94d944 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -721,13 +721,13 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu=
_device *adev)
        return adev->have_atomics_support;
 }

-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev)
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device
+*adev, bool reset)
 {
        struct ras_err_data err_data =3D {0, 0, 0, NULL};

        /* CPU MCA will handle page retirement if connected_to_cpu is 1 */
        if (!adev->gmc.xgmi.connected_to_cpu)
-               amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
-       else
+               amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset)=
;
+       else if (reset)
                amdgpu_amdkfd_gpu_reset(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index fcbc8a9c9e06..61f899e54fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -296,7 +296,8 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_dev=
ice *adev,
                                      uint64_t *mmap_offset);
 int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
                                struct tile_config *config);
-void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev);
+void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
+                               bool reset);
 #if IS_ENABLED(CONFIG_HSA_AMD)
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev, diff --git=
 a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_device_queue_manager.c
index 01a2cc3928ac..095b2e0822aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1476,6 +1476,20 @@ static int unmap_queues_cpsch(struct device_queue_ma=
nager *dqm,
        return retval;
 }

+int unmap_queues_cpsch_poison(struct device_queue_manager *dqm,
+uint32_t pasid) {
+       int ret;
+
+       dqm_lock(dqm);
+
+       ret =3D unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
+                       pasid, true);
+
+       dqm_unlock(dqm);
+
+       return ret;
+}
+
 /* dqm->lock mutex has to be locked before calling this function */  stati=
c int execute_queues_cpsch(struct device_queue_manager *dqm,
                                enum kfd_unmap_queues_filter filter, diff -=
-git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/=
drm/amd/amdkfd/kfd_device_queue_manager.h
index 499fc0ea387f..c52869133159 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -219,6 +219,7 @@ unsigned int get_queues_per_pipe(struct device_queue_ma=
nager *dqm);  unsigned int get_pipes_per_mec(struct device_queue_manager *d=
qm);  unsigned int get_num_sdma_queues(struct device_queue_manager *dqm);  =
unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm);
+int unmap_queues_cpsch_poison(struct device_queue_manager *dqm,
+uint32_t pasid);

 static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *=
pdd)  { diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index deb64168c9e8..2863bb9e5bca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -89,6 +89,27 @@ enum SQ_INTERRUPT_ERROR_TYPE {  #define KFD_SQ_INT_DATA_=
_ERR_TYPE_MASK 0xF00000  #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20

+static void event_interrupt_poison_consumption(struct kfd_dev *dev,
+                               uint16_t pasid)
+{
+       int ret;
+       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
+
+       /* all queues of a process will be unmapped in one time */
+       if (p && atomic_read(&p->poison))
+               return;
+
+       atomic_set(&p->poison, 1);
+       ret =3D unmap_queues_cpsch_poison(dev->dqm, pasid);
+       kfd_signal_poison_consumed_event(dev, pasid);
+       /* resetting queue passes, do page retirement without gpu reset
+          resetting queue fails, fallback to gpu reset solution */
+       if (!ret)
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, fal=
se);
+       else
+               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, tru=
e); }
+
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
                                        const uint32_t *ih_ring_entry,
                                        uint32_t *patched_ihre,
@@ -230,8 +251,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                                        sq_intr_err);
                                if (sq_intr_err !=3D SQ_INTERRUPT_ERROR_TYP=
E_ILLEGAL_INST &&
                                        sq_intr_err !=3D SQ_INTERRUPT_ERROR=
_TYPE_MEMVIOL) {
-                                       kfd_signal_poison_consumed_event(de=
v, pasid);
-                                       amdgpu_amdkfd_ras_poison_consumptio=
n_handler(dev->adev);
+                                       event_interrupt_poison_consumption(=
dev, pasid);
                                        return;
                                }
                                break;
@@ -252,8 +272,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
                if (source_id =3D=3D SOC15_INTSRC_SDMA_TRAP) {
                        kfd_signal_event_interrupt(pasid, context_id0 & 0xf=
ffffff, 28);
                } else if (source_id =3D=3D SOC15_INTSRC_SDMA_ECC) {
-                       kfd_signal_poison_consumed_event(dev, pasid);
-                       amdgpu_amdkfd_ras_poison_consumption_handler(dev->a=
dev);
+                       event_interrupt_poison_consumption(dev, pasid);
                        return;
                }
        } else if (client_id =3D=3D SOC15_IH_CLIENTID_VMC || diff --git a/d=
rivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.=
h
index 0c3f911e3bf4..ea68f3b3a4e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -856,6 +856,8 @@ struct kfd_process {
        struct svm_range_list svms;

        bool xnack_enabled;
+
+       atomic_t poison;
 };

 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
--
2.17.1

