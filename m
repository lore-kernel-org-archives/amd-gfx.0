Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32C4CDE008
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 06:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E39510E2FC;
	Fri, 26 Jun 2026 06:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ytR0TN1H";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C046010E2EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 06:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsH34GyFDryFOH7QAwkypfjivui9GcE8sqgkV7P6YCdI+I7CuS0C/y52d7diVPfeXeEeiA23hiBRp9FdzGqtmKVSW3xysDbNLo7fG3RCZNJCVHW2m0vTex3Hdwi6HZlctf8b6BSMef/b/yRgJ/uJBRWUOJ0H5mUlQfXjQKbu+mmPrvX2cxdxzQKRqd5QQreHDC2ghOZkhdlJhR1UWOF52nGYEVc8N84PAQhCyE52YDGa3vFnJMdMp72LipRRskC3cAysR96vWc+dwbtIpVPCa7Jh7J/Df446to5ePW+ZsK4xyxmW4QJtSImdBJSrzcdzJf0ClZiPAOoXaatJY1M9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFdEARTt7zw8Nfu4gef9uS8HFf1YRO/ibZCHgHWHZ2Y=;
 b=FanhbD3Acf9Tidw5hNNoIUyDiC4mSITIoU9IT0xPUNiQP5agDgUMLEOX9JyVjORuu6j9Ftgtc591HghrVa81M7E0Di6DBtXWs8I5VygUZ5xOtu3WtJ9EOjPhCRhRp9v6Nbd9x6XOpp/5pWRuMF7JB/fTcJW82uctDbEQzU13f2Gy4YH5kugq8M1vm45UAm/CEcl7d3eLYuuh2FQSpWjrOc9Wd3VKOCvjyG8p9QnmvWx2QI7noef9qq6obMv77SP5wKQ7M3mzAagzAd6e3o2NdSzdOUD/dhgP1YFdT6TrLB0WsJ1ZXMWttinYjcj7y+3qZEOP6wFSny0GBQMq+jLmnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFdEARTt7zw8Nfu4gef9uS8HFf1YRO/ibZCHgHWHZ2Y=;
 b=ytR0TN1HVX4wp9sS0lJKWibcTF3K1lqfPsINgZxtnXI3oMzfcvaouVyn0qB8P3XlvrGpL4YlHdbucGrP/dYYpDSWUUrEhI5R1GD0OD0OrU7enWWPe/urwGmKIG9L0ILA637j2Vm3VrdENIJP0Nlvq79nvHITiSdHHd6WGSaA2eM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 06:04:57 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 06:04:57 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH v3 01/44] drm/amdgpu: Retire legacy page retirement RAS
 code
Thread-Topic: [PATCH v3 01/44] drm/amdgpu: Retire legacy page retirement RAS
 code
Thread-Index: AQHdBHt1h20Lr2h5FkKoYOUP2eOUV7ZQWjmg
Date: Fri, 26 Jun 2026 06:04:57 +0000
Message-ID: <BN9PR12MB5257387CCEAD7F37C599240BFCEB2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-26T06:04:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6627:EE_
x-ms-office365-filtering-correlation-id: 5a828448-135e-4e15-5c7a-08ded348d99e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|6133799003|56012099006|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: nBUcOC8Mt0jwYFVWlyfYPulqn0GpvkrQXYrKRjxH6uC0l1iNdLPmdpbcXCPc32cwL2ki/JTudAzDQmWoa0j+1qOiNc6WLeMrKdE/fTJytPivv+dItcWWJf20XE+t7iwjIGUc8IZ2d9BwkhlCNDKmnCQwVw0HN1gJSmpwkwVaszdI5XU3Q7Cqdwsd2sl3RNSBTAudQIxpRUAisUg8jYNKziuyohATmgYvT4zVkTB9haMVl7V0FO4En/RcUzWP3vDEYtH2Qugyfm2Qj1YJafBlQ/iWdStjnwDEG12STdtbRBu+Z1yLNlC1Ah7+rjFh6qbUb6nYnfgztlQFAWJ0zIXV06/pUXUiWo2N2dv9zJwdHGxWa4yHqTZzNQ3byJfaVC0/N5jwAChU/1FQbbuJJ0ScTK9o6Xhtau+zekP9jSFcVcQwqi1hhAa0C1oGe9d0nOiyg9uECjJ7U6Df3VwcX53WfH1KG2+62jbZt60C2mDzwc3mNV590E0U9NdyOiYooMOWjyGn+vZshakgsRzU5ZUXdIQrlyMGU+R516s/yKFrvBLTszvgiI9Iu+fS59Vbn687EK6ta1IcoFaxQA5ESsZIFWDY1uA0FC4fJ+TU1rbg3V5fsyP0fVylrxJXG+wVgN32LLEpkFeiunk3iIzlELPOMawie6ukqJtBQsQ50yY67wjBofT2dYB4ndGgLqrYVci+KUiC4hM/fggIFeTkwxKyUM6KZbg+GTSjy/uNpeUWixY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(6133799003)(56012099006)(18002099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4L33VEW8ENvGmohSMF1hQ9TDVB6cN+pCteQc2pVGapyF1xFjvhc7VyVEGZci?=
 =?us-ascii?Q?oP2oBP6e2K/HQdzmpfSH6vmt99Ff/QCIMUIMqI0Bc3fPoY5Vdl295qNZEgdK?=
 =?us-ascii?Q?uPrWnko/tynz0s3E5U75FgX0jtVMPZWt0V2BVzvPBeakK40JUWguVzHCpJ4f?=
 =?us-ascii?Q?EHdxxP1o2Es61kCMbvPK8YVwXYU2gI7sf+cQ2o17ySXpAB1XX09HK9IuwP1c?=
 =?us-ascii?Q?s6Y9pZqzjiNFb85iejBruwc2o7XJCIICo7KukxYLOgrJKpk2Xz4eTvVEc6oC?=
 =?us-ascii?Q?dcNs2XqaO/6nI1APvQfZq6d2NPHUPlTrmWL7DY5NnZTkQPnK4LQbk536UUtS?=
 =?us-ascii?Q?A66IJF9X/S1z+QWuGjdCZ4lVpO42OgfnoKVT+uZn6qC03QnSAaVob+CrTzSr?=
 =?us-ascii?Q?+PBp4PnvLm+b7rqD50HaHuxfG0nD2v8kFjNA10deP9OiDclWkC60bsuYgwpe?=
 =?us-ascii?Q?XsbGV+Hw6cCc5rS7F6gKgb8jPue4UuvJ0FbX1fi7Miz6Qifp9OMq+YghaWiH?=
 =?us-ascii?Q?E2N3x2CSGH1gkO1o7N509EbRSLVW+mWMIuzZfmlgH9lZsql8LS3jO0r1/3gL?=
 =?us-ascii?Q?sTkRxuisCrRWx/j0/LzewgMP13DtZ47E01PxvIpI3uWvCTVMCUnHaugGyLLF?=
 =?us-ascii?Q?P4RA0oCqk6go5ZEVT/AGpFDEHwLoBijq83FAdhXSjFTU2qANELOpM/a2+UNA?=
 =?us-ascii?Q?gkslrY1c9is+iKFXE6Q5rSZsa+wBL+OQp7tpgONHnaG5uTuG6KtglrHkgBOh?=
 =?us-ascii?Q?+YJSuTnw40cR4qCw5ZdmCNkxqqCc/x1RZWr5nWoKhSOaFZ1nLtzrbUiK4U0p?=
 =?us-ascii?Q?ouh8jy+hYFBEUyye6t2Pe7ySMKv07xh2YsSpcbCthulP9yZr9Rr580ZpBJK8?=
 =?us-ascii?Q?lyZ5DXNeEo1AOnH4cmfwTNbHPnCmIfEJM15MC+a/ByRT3vYfjfdR3IytOwce?=
 =?us-ascii?Q?XrGfwYNmozg6ert9qz0LbtdY34tsC9aTo/I7EnEZyy0tOZca4np2O9JKlC1v?=
 =?us-ascii?Q?GNAQn5ilbh7S6rmGeFHgL3YwQEZHQyayNfDcDtNWh+CznUSKj11IXUwoejN8?=
 =?us-ascii?Q?qxEkVK1m2CfT8o1duR6qoE7oM330jwiuPceXffIR+2vjT1V+2x2iDNTOOYih?=
 =?us-ascii?Q?cKP8FeUQXtRpr9dHuQLmawDtDZ/jjjKKsAmS2BCISfIhP6sRuVjBbeYkjHxM?=
 =?us-ascii?Q?Uuc/IVjEPNSs7iqTwhEZeg2Rgik9rYLley0SYk7zKvwk1b7G9gVekybtxWWY?=
 =?us-ascii?Q?9F51S2tacqdAIAgvNBg7sVHHZO282Vo658O9LjnpICP+2jTTa0bel9IqL1Ar?=
 =?us-ascii?Q?jqEZ7g4628iKYcJOHTo/nsekA37u452vPHWkjlh5ud+JP5BIJSUCuOfMOWrG?=
 =?us-ascii?Q?WhKgsKgEgMsZhdeD5pwEDqRgt0t5gwB7Gj6V9RkwafTl7Sp12sPTJ8VLVQr4?=
 =?us-ascii?Q?y2EKsChB3RMZACBjLQuKEG29N4VlxgHhy9/tNd1jrE8AQFkZoB7krZ3i6ay1?=
 =?us-ascii?Q?0VX9cIRvEuS6aRDnD0+OvGK3N1TIUbKi629esNX04GrDS6p5Chwpm8pZR7gR?=
 =?us-ascii?Q?VHWtVqNEelfIR0PIYOL3KgEyvdJQvBH6fniGH7C8Jw/eQpXgSp7Jn/DhYrJ8?=
 =?us-ascii?Q?slbnymB8lvcYjrAi6DW0rjDKPUr75Y2FXjOewI33LrJa9ltFRvszMLI2kiCj?=
 =?us-ascii?Q?MJVU8l+WcLcbmEjxAMtYz0jy+/zNmIxnfuJzA+dZyvXiDlpp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a828448-135e-4e15-5c7a-08ded348d99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 06:04:57.4969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnsJP+OqUoJCu9wulXAQfXf3oW3kXjpC57ALiih8YiKo0gU3dc+Qlzr7TMwrrRS8f1mnm+C2g7u9B9OQ9YiKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

AMD General

Except for the eeprom table compatibility is pending for validation, the ot=
hers look good to me in general.

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Thursday, June 25, 2026 16:19
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; =
Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v3 01/44] drm/amdgpu: Retire legacy page retirement RAS cod=
e

Remove the deprecated legacy RAS code path for page retirement

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 304 +-----------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  23 --  drivers/gpu/drm/amd/amdgpu/=
amdgpu_umc.c |  13 +-  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  |  17 --
 4 files changed, 2 insertions(+), 355 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 8a49ae4c0132..8095f284d531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -128,12 +128,6 @@ const char *get_ras_block_str(struct ras_common_if *ra=
s_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  10
-
-#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms
-
-#define MAX_FLUSH_RETIRE_DWORK_TIMES  100
-
 #define BYPASS_ALLOCATED_ADDRESS        0x0
 #define BYPASS_INITIALIZATION_ADDRESS   0x1

@@ -2489,14 +2483,6 @@ static void amdgpu_ras_interrupt_poison_creation_han=
dler(struct ras_manager *obj
        event_id =3D amdgpu_ras_acquire_event_id(adev, type);
        RAS_EVENT_LOG(adev, event_id, "Poison is created\n");

-       if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >=3D IP_VERSION(12, 0=
, 0)) {
-               struct amdgpu_ras *con =3D amdgpu_ras_get_context(obj->adev=
);
-
-               atomic_inc(&con->page_retirement_req_cnt);
-               atomic_inc(&con->poison_creation_count);
-
-               wake_up(&con->page_retirement_wq);
-       }
 }

 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj, @@ -=
3550,38 +3536,6 @@ static void amdgpu_ras_validate_threshold(struct amdgpu_=
device *adev,
        }
 }

-int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
-               enum amdgpu_ras_block block, uint16_t pasid,
-               pasid_notify pasid_fn, void *data, uint32_t reset)
-{
-       int ret =3D 0;
-       struct ras_poison_msg poison_msg;
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-
-       memset(&poison_msg, 0, sizeof(poison_msg));
-       poison_msg.block =3D block;
-       poison_msg.pasid =3D pasid;
-       poison_msg.reset =3D reset;
-       poison_msg.pasid_fn =3D pasid_fn;
-       poison_msg.data =3D data;
-
-       ret =3D kfifo_put(&con->poison_fifo, poison_msg);
-       if (!ret) {
-               dev_err(adev->dev, "Poison message fifo is full!\n");
-               return -ENOSPC;
-       }
-
-       return 0;
-}
-
-static int amdgpu_ras_get_poison_req(struct amdgpu_device *adev,
-               struct ras_poison_msg *poison_msg)
-{
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-
-       return kfifo_get(&con->poison_fifo, poison_msg);
-}
-
 static void amdgpu_ras_ecc_log_init(struct ras_ecc_log_info *ecc_log)  {
        mutex_init(&ecc_log->lock);
@@ -3611,232 +3565,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_=
log_info *ecc_log)
        ecc_log->consumption_q_count =3D 0;
 }

-static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con,
-                               uint32_t delayed_ms)
-{
-       int ret;
-
-       mutex_lock(&con->umc_ecc_log.lock);
-       ret =3D radix_tree_tagged(&con->umc_ecc_log.de_page_tree,
-                       UMC_ECC_NEW_DETECTED_TAG);
-       mutex_unlock(&con->umc_ecc_log.lock);
-
-       if (ret)
-               schedule_delayed_work(&con->page_retirement_dwork,
-                       msecs_to_jiffies(delayed_ms));
-
-       return ret ? true : false;
-}
-
-static void amdgpu_ras_do_page_retirement(struct work_struct *work) -{
-       struct amdgpu_ras *con =3D container_of(work, struct amdgpu_ras,
-                                             page_retirement_dwork.work);
-       struct amdgpu_device *adev =3D con->adev;
-       struct ras_err_data err_data;
-
-       /* If gpu reset is ongoing, delay retiring the bad pages */
-       if (amdgpu_in_reset(adev) || amdgpu_ras_in_recovery(adev)) {
-               amdgpu_ras_schedule_retirement_dwork(con,
-                               AMDGPU_RAS_RETIRE_PAGE_INTERVAL * 3);
-               return;
-       }
-
-       amdgpu_ras_error_data_init(&err_data);
-
-       amdgpu_umc_handle_bad_pages(adev, &err_data);
-
-       amdgpu_ras_error_data_fini(&err_data);
-
-       amdgpu_ras_schedule_retirement_dwork(con,
-                       AMDGPU_RAS_RETIRE_PAGE_INTERVAL);
-}
-
-static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-                               uint32_t poison_creation_count)
-{
-       int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
-       struct ras_query_if info;
-       u32 timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
-       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       u64 de_queried_count;
-       u64 consumption_q_count;
-       enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
-
-       memset(&info, 0, sizeof(info));
-       info.head.block =3D AMDGPU_RAS_BLOCK__UMC;
-
-       ecc_log =3D &ras->umc_ecc_log;
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->consumption_q_count =3D 0;
-
-       do {
-               ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
-               if (ret)
-                       return ret;
-
-               de_queried_count =3D ecc_log->de_queried_count;
-               consumption_q_count =3D ecc_log->consumption_q_count;
-
-               if (de_queried_count && consumption_q_count)
-                       break;
-
-               msleep(100);
-       } while (--timeout);
-
-       if (de_queried_count)
-               schedule_delayed_work(&ras->page_retirement_dwork, 0);
-
-       if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
, 0, 1) =3D=3D 0)
-               amdgpu_ras_reset_gpu(adev);
-
-       return 0;
-}
-
-static void amdgpu_ras_clear_poison_fifo(struct amdgpu_device *adev) -{
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       struct ras_poison_msg msg;
-       int ret;
-
-       do {
-               ret =3D kfifo_get(&con->poison_fifo, &msg);
-       } while (ret);
-}
-
-static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *ade=
v,
-                       uint32_t msg_count, uint32_t *gpu_reset)
-{
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       uint32_t reset_flags =3D 0, reset =3D 0;
-       struct ras_poison_msg msg;
-       int ret, i;
-
-       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-
-       for (i =3D 0; i < msg_count; i++) {
-               ret =3D amdgpu_ras_get_poison_req(adev, &msg);
-               if (!ret)
-                       continue;
-
-               if (msg.pasid_fn)
-                       msg.pasid_fn(adev, msg.pasid, msg.data);
-
-               reset_flags |=3D msg.reset;
-       }
-
-       /*
-        * Try to ensure poison creation handler is completed first
-        * to set rma if bad page exceed threshold.
-        */
-       flush_delayed_work(&con->page_retirement_dwork);
-
-       /* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu res=
et */
-       if (reset_flags && !amdgpu_ras_is_rma(adev)) {
-               if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-               else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET)
-                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-               else
-                       reset =3D reset_flags;
-
-               con->gpu_reset_flags |=3D reset;
-               amdgpu_ras_reset_gpu(adev);
-
-               *gpu_reset =3D reset;
-
-               /* Wait for gpu recovery to complete */
-               flush_work(&con->recovery_work);
-       }
-
-       return 0;
-}
-
-static int amdgpu_ras_page_retirement_thread(void *param) -{
-       struct amdgpu_device *adev =3D (struct amdgpu_device *)param;
-       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       uint32_t poison_creation_count, msg_count;
-       uint32_t gpu_reset;
-       int ret;
-
-       while (!kthread_should_stop()) {
-
-               wait_event_interruptible(con->page_retirement_wq,
-                               kthread_should_stop() ||
-                               atomic_read(&con->page_retirement_req_cnt))=
;
-
-               if (kthread_should_stop())
-                       break;
-
-               mutex_lock(&con->poison_lock);
-               gpu_reset =3D 0;
-
-               do {
-                       poison_creation_count =3D atomic_read(&con->poison_=
creation_count);
-                       ret =3D amdgpu_ras_poison_creation_handler(adev, po=
ison_creation_count);
-                       if (ret =3D=3D -EIO)
-                               break;
-
-                       if (poison_creation_count) {
-                               atomic_sub(poison_creation_count, &con->poi=
son_creation_count);
-                               atomic_sub(poison_creation_count, &con->pag=
e_retirement_req_cnt);
-                       }
-               } while (atomic_read(&con->poison_creation_count) &&
-                       !atomic_read(&con->poison_consumption_count));
-
-               if (ret !=3D -EIO) {
-                       msg_count =3D kfifo_len(&con->poison_fifo);
-                       if (msg_count) {
-                               ret =3D amdgpu_ras_poison_consumption_handl=
er(adev,
-                                               msg_count, &gpu_reset);
-                               if ((ret !=3D -EIO) &&
-                                   (gpu_reset !=3D AMDGPU_RAS_GPU_RESET_MO=
DE1_RESET))
-                                       atomic_sub(msg_count, &con->page_re=
tirement_req_cnt);
-                       }
-               }
-
-               if ((ret =3D=3D -EIO) || (gpu_reset =3D=3D AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET)) {
-                       /* gpu mode-1 reset is ongoing or just completed ra=
s mode-1 reset */
-                       /* Clear poison creation request */
-                       atomic_set(&con->poison_creation_count, 0);
-                       atomic_set(&con->poison_consumption_count, 0);
-
-                       /* Clear poison fifo */
-                       amdgpu_ras_clear_poison_fifo(adev);
-
-                       /* Clear all poison requests */
-                       atomic_set(&con->page_retirement_req_cnt, 0);
-
-                       if (ret =3D=3D -EIO) {
-                               /* Wait for mode-1 reset to complete */
-                               down_read(&adev->reset_domain->sem);
-                               up_read(&adev->reset_domain->sem);
-                       }
-
-                       /* Wake up work to save bad pages to eeprom */
-                       schedule_delayed_work(&con->page_retirement_dwork, =
0);
-               } else if (gpu_reset) {
-                       /* gpu just completed mode-2 reset or other reset *=
/
-                       /* Clear poison consumption messages cached in fifo=
 */
-                       msg_count =3D kfifo_len(&con->poison_fifo);
-                       if (msg_count) {
-                               amdgpu_ras_clear_poison_fifo(adev);
-                               atomic_sub(msg_count, &con->page_retirement=
_req_cnt);
-                       }
-
-                       atomic_set(&con->poison_consumption_count, 0);
-
-                       /* Wake up work to save bad pages to eeprom */
-                       schedule_delayed_work(&con->page_retirement_dwork, =
0);
-               }
-               mutex_unlock(&con->poison_lock);
-       }
-
-       return 0;
-}
-
 int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev); @@ -3917,1=
0 +3645,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool =
init_bp_info)
        }

        mutex_init(&con->recovery_lock);
-       mutex_init(&con->poison_lock);
        INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
        atomic_set(&con->in_recovery, 0);
-       atomic_set(&con->rma_in_recovery, 0);
        con->eeprom_control.bad_channel_bitmap =3D 0;

        max_eeprom_records_count =3D amdgpu_ras_eeprom_max_record_count(&co=
n->eeprom_control);
@@ -3933,20 +3659,8 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *a=
dev, bool init_bp_info)
        }

        mutex_init(&con->page_rsv_lock);
-       INIT_KFIFO(con->poison_fifo);
        mutex_init(&con->page_retirement_lock);
-       init_waitqueue_head(&con->page_retirement_wq);
-       atomic_set(&con->page_retirement_req_cnt, 0);
-       atomic_set(&con->poison_creation_count, 0);
-       atomic_set(&con->poison_consumption_count, 0);
-       con->page_retirement_thread =3D
-               kthread_run(amdgpu_ras_page_retirement_thread, adev, "umc_p=
age_retirement");
-       if (IS_ERR(con->page_retirement_thread)) {
-               con->page_retirement_thread =3D NULL;
-               dev_warn(adev->dev, "Failed to create umc_page_retirement t=
hread!!!\n");
-       }
-
-       INIT_DELAYED_WORK(&con->page_retirement_dwork, amdgpu_ras_do_page_r=
etirement);
+
        amdgpu_ras_ecc_log_init(&con->umc_ecc_log);
 #ifdef CONFIG_X86_MCE_AMD
        if ((adev->asic_type =3D=3D CHIP_ALDEBARAN) && @@ -3978,31 +3692,15=
 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        struct ras_err_handler_data *data =3D con->eh_data;
-       int max_flush_timeout =3D MAX_FLUSH_RETIRE_DWORK_TIMES;
-       bool ret;

        /* recovery_init failed to init it, fini is useless */
        if (!data)
                return 0;

-       /* Save all cached bad pages to eeprom */
-       do {
-               flush_delayed_work(&con->page_retirement_dwork);
-               ret =3D amdgpu_ras_schedule_retirement_dwork(con, 0);
-       } while (ret && max_flush_timeout--);
-
-       if (con->page_retirement_thread)
-               kthread_stop(con->page_retirement_thread);
-
-       atomic_set(&con->page_retirement_req_cnt, 0);
-       atomic_set(&con->poison_creation_count, 0);
-
        mutex_destroy(&con->page_rsv_lock);

        cancel_work_sync(&con->recovery_work);

-       cancel_delayed_work_sync(&con->page_retirement_dwork);
-
        amdgpu_ras_ecc_log_fini(&con->umc_ecc_log);

        mutex_lock(&con->recovery_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index a86ab65aa2f0..1629a242d58e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -466,14 +466,6 @@ struct ras_query_context {  typedef int (*pasid_notify=
)(struct amdgpu_device *adev,
                uint16_t pasid, void *data);

-struct ras_poison_msg {
-       enum amdgpu_ras_block block;
-       uint16_t pasid;
-       uint32_t reset;
-       pasid_notify pasid_fn;
-       void *data;
-};
-
 struct ras_err_pages {
        uint32_t count;
        uint64_t *pfn;
@@ -549,7 +541,6 @@ struct amdgpu_ras {
        /* gpu recovery */
        struct work_struct recovery_work;
        atomic_t in_recovery;
-       atomic_t rma_in_recovery;
        struct amdgpu_device *adev;
        /* error handler data */
        struct ras_err_handler_data *eh_data;
@@ -587,16 +578,9 @@ struct amdgpu_ras {
        /* Record special requirements of gpu reset caller */
        uint32_t  gpu_reset_flags;

-       struct task_struct *page_retirement_thread;
-       wait_queue_head_t page_retirement_wq;
        struct mutex page_retirement_lock;
-       atomic_t page_retirement_req_cnt;
-       atomic_t poison_creation_count;
-       atomic_t poison_consumption_count;
        struct mutex page_rsv_lock;
-       DECLARE_KFIFO(poison_fifo, struct ras_poison_msg, 128);
        struct ras_ecc_log_info  umc_ecc_log;
-       struct delayed_work page_retirement_dwork;

        /* ras errors detected */
        unsigned long ras_err_state;
@@ -615,9 +599,6 @@ struct amdgpu_ras {
        struct list_head critical_region_head;
        struct mutex critical_region_lock;

-       /* Protect poison injection */
-       struct mutex poison_lock;
-
        /* Disable/Enable uniras switch */
        bool uniras_enabled;
        const struct ras_smu_drv *ras_smu_drv; @@ -1029,10 +1010,6 @@ int a=
mdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn);  int amdg=
pu_ras_add_critical_region(struct amdgpu_device *adev, struct amdgpu_bo *bo=
);  bool amdgpu_ras_check_critical_address(struct amdgpu_device *adev, uint=
64_t addr);

-int amdgpu_ras_put_poison_req(struct amdgpu_device *adev,
-               enum amdgpu_ras_block block, uint16_t pasid,
-               pasid_notify pasid_fn, void *data, uint32_t reset);
-
 bool amdgpu_ras_in_recovery(struct amdgpu_device *adev);

 __printf(3, 4)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index a250109edb63..f22d07e9c29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -276,7 +276,7 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_devic=
e *adev,
                        }

                        amdgpu_ras_error_data_fini(&err_data);
-               } else if (amdgpu_uniras_enabled(adev)) {
+               } else {
                        struct ras_ih_info ih_info =3D {0};

                        ih_info.block =3D block;
@@ -285,17 +285,6 @@ int amdgpu_umc_pasid_poison_handler(struct amdgpu_devi=
ce *adev,
                        ih_info.pasid_fn =3D pasid_fn;
                        ih_info.data =3D data;
                        amdgpu_ras_mgr_handle_consumer_interrupt(adev, &ih_=
info);
-               } else {
-                       struct amdgpu_ras *con =3D amdgpu_ras_get_context(a=
dev);
-                       int ret;
-
-                       ret =3D amdgpu_ras_put_poison_req(adev,
-                               block, pasid, pasid_fn, data, reset);
-                       if (!ret) {
-                               atomic_inc(&con->page_retirement_req_cnt);
-                               atomic_inc(&con->poison_consumption_count);
-                               wake_up(&con->page_retirement_wq);
-                       }
                }
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index a6df6a778f50..749c1f845ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -656,23 +656,6 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_d=
evice *adev,
        for (i =3D 0; i < count; i++)
                amdgpu_ras_reserve_page(adev, page_pfn[i]);

-       /* The problem case is as follows:
-        * 1. GPU A triggers a gpu ras reset, and GPU A drives
-        *    GPU B to also perform a gpu ras reset.
-        * 2. After gpu B ras reset started, gpu B queried a DE
-        *    data. Since the DE data was queried in the ras reset
-        *    thread instead of the page retirement thread, bad
-        *    page retirement work would not be triggered. Then
-        *    even if all gpu resets are completed, the bad pages
-        *    will be cached in RAM until GPU B's bad page retirement
-        *    work is triggered again and then saved to eeprom.
-        * Trigger delayed work to save the bad pages to eeprom in time
-        * after gpu ras reset is completed.
-        */
-       if (amdgpu_ras_in_recovery(adev))
-               schedule_delayed_work(&con->page_retirement_dwork,
-                       msecs_to_jiffies(DELAYED_TIME_FOR_GPU_RESET));
-
        return 0;
 }

--
2.34.1

