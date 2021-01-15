Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B4DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 02:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEAD23A5A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 02:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEAD23A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10926E10A;
	Fri, 15 Jan 2021 02:14:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE406E10A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 02:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfKdyXbk0WYGhRfsWrHKqwdCnJyclbUCW50Jye0MvfLuSBi7BPVxXurIPcK7plX9yYZdfxU0bI6I3r2/B+i9gTdM51zcXe/KVwA5TgMtNvQoI9yRY2/CvX5u0ZRU1BbqF9cgYWag4hkfaye+uXOvugTvge2D7rPro6Rv/fnH7RBtEmnqxycMJ1Hhkg1M6J+Lna8GqXmvYaEQkTgV1op3ZIP2kKG1i+DaRZc6uXRTbpWXBJNoxczEhNol1PHnXYpTpdlBQpTcyFSdBqWWBvCbqZxqZpUxyTIn4+roKKkaXkT7CrwY5N2hCI9g5p0bj14t8bEgu4cdnwfz44HYLFOlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA8Xsg5cpwHBQ57jr8XeHrpVT+Fxi0CTSoXQOqIZMog=;
 b=D6/6jfC7avYOhdLFhXgMRXyFB8/zd0vV4itsbpGTFGjBq/+ve1a8jKsbjA6xvrJaRQ8z8Fc3Xd2Yd/aLjqEQa9kQXId6XdS66IWj6lgwIoLE3O6BQBnx1F0aLFIEcGg+KGPf39BKEK9xVT1yf+uu/MqHIvCD7xyuUQlvRSVuGlpbixD4+CVHHCUe2Qn1VXbe2HwdPZynZSRuzhbGxR+hmEleWlAZ2Y+OwBlX6xUcacpkExnZpf+995FniBNiMrcOCTtfiN7gU/o0plKKz4Z/spyh8zYEGGnI9rLM+vAgBZ7Vk1uIsJIL1OaLPMNQC8aBySLhMWvYbtEAIyFRZZIbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA8Xsg5cpwHBQ57jr8XeHrpVT+Fxi0CTSoXQOqIZMog=;
 b=B6+ulg62qXUq44bvirKuGjQqeYIajk95db83JidlSeDs/Xa8q4s/Wbd59tj7ULiBd/tZkOwUIuXovYjbfG2EcqKayuzMKqFmEbxUlBLJyIwWlfG9RuWhfCHd1N2liUcyG/etHx5Hi9WK7fUMoreBiP0+G/hInmUtEX08qC/zpoU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2827.namprd12.prod.outlook.com (2603:10b6:5:7f::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10; Fri, 15 Jan 2021 02:14:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bc84:defe:efbb:9ab1%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 02:14:09 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Horace" <Horace.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
Thread-Topic: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout
Thread-Index: AQHW6np0rrHtltbts0qSKyttHGenIqon8zhA
Date: Fri, 15 Jan 2021 02:14:09 +0000
Message-ID: <DM6PR12MB2619AAC69A4EFC699BAE08DFE4A70@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210114133729.24169-1-horace.chen@amd.com>
In-Reply-To: <20210114133729.24169-1-horace.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0eeab010-09ef-4a74-a1b4-b65337279214;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-15T02:14:01Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86d9127b-0393-40ae-acd2-08d8b8fb3e50
x-ms-traffictypediagnostic: DM6PR12MB2827:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2827FEF4C94DBBED0EE3FA3FE4A70@DM6PR12MB2827.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +P1txBxztFdsSucA5XpzAIiVjvJOemFsBwtPQVuCRyEaTql0L6p0MnKow7gvlHGDYQRz9XYfin7jnKYDmSEAXL5SnpFqCg3X6NxCo+LLMpfT46Rb6sEN5vQMDuwKsnAgy3VpmnnPK/PdtI8h5F7OpAFwSguO8axFejqL79qlQb/VJTVMr2LXJgBWSgEj0KGwzy52apkAmbgHNBXKjcP52A2pgzlpRaySiLeugV4spRVtBlDRec3M8itJVaPBEkz2oiIObtw1IGmAURP3RjBBQ+mmKlcZIlRpoKcJCNGNk2Ns2/rfwcoPVSUY7kmrLqJ6+C/9JJg76gkc78ofBEPTy5SmHRsZuAhWY/zcj8gb/Q7m5eULqbfQBLTNZKUbpY6+j8Tx/58QaXsLyACOyDBA7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(6506007)(53546011)(4326008)(8676002)(83380400001)(110136005)(186003)(86362001)(8936002)(5660300002)(26005)(7696005)(52536014)(71200400001)(54906003)(33656002)(64756008)(66556008)(9686003)(55016002)(76116006)(316002)(66946007)(66476007)(66446008)(478600001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F7k8TBicWjbGOWBuVFaYuU58i9N9F+DB74G8l/wJW4NPVNBII9t4Z+r/o48V?=
 =?us-ascii?Q?TKPQ73GTqI1OXiPwLxjM1T3KDQ8neZgW4KwLecmzgQ+zu8H5Aol/dBF3ehKo?=
 =?us-ascii?Q?oQmd1b94mKYDpES4aIopEpgVGV6C2R6egF9Kg4hT/gCMEEsqbpfKsbaXKYQx?=
 =?us-ascii?Q?PBv7G+Re7+gI9xcBwmNfDgsv0F0b6WWIYLGA0C1iXx0BjAcUC24Y2hb6Ubq7?=
 =?us-ascii?Q?NCBNyBdLtfroljEaoh35me9LFPoSxsD82H/2ixh9mmMNT/JtjCSHd2spX1/W?=
 =?us-ascii?Q?pTe4EexPiuVaikC5YbpsjEvgj7CrEe0WHtMQSqA2WiedVB234vtYon40Umwb?=
 =?us-ascii?Q?9SM4n4zl8mtobmgK/JKAvl0u3gUkGFLwGOid+PyVgWta8F41rwFf5ywoZ39c?=
 =?us-ascii?Q?N5YnV5F/NAI+47sZBiInx6i2gMsiijSd0mRTS2zVJwDSgb/OovMeXMC4Kfae?=
 =?us-ascii?Q?yt9A66R76cVAG7dCEf/SMQJfKi7jPSgpO4lDQgn+SQum2NAw4xjsOV0EAGYg?=
 =?us-ascii?Q?tHQQFtIbfuxNq4c+3gR7KCCSgfnQRFO3ESYe//DziKMMf/gU4N2SBJytvZ0E?=
 =?us-ascii?Q?pCGW6eL5Lx5Ix4x5cgZ1HKA1vqm3g1kXqQcFkjuFX7JNAr02H8Khvx5DMQmd?=
 =?us-ascii?Q?TCCl2KtUFKwrxczJ2qnEfiEXGiZimduBce8mD1ENnJlt3Ssy7mG9gwZEhdI/?=
 =?us-ascii?Q?0oOkH3J7c82sazS9gvYecUQmXd3bGuZ9r7IPIL0g6e4wdvVzgw2BMHw9JxAT?=
 =?us-ascii?Q?432i+DLBLV9b2PvV6u1C77l1bvZ8rZqu3a8k1HGr1RfIQgO3Mm7kGNjl861r?=
 =?us-ascii?Q?CHG79XQkSSAkJDPjMcpufie7Yr/zRRE1wpO8Z4nSh/I7o0J1bNePxpgSs9G6?=
 =?us-ascii?Q?YyytHKvkAQWt9n82DyYtbfc5YgWdKmmUsA351WxmUCycB92BHIKGHk7N3UFd?=
 =?us-ascii?Q?IOD52SPkjj03wzHWGxphv7Fvn3fJmKyb3m2CGHu/nBw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d9127b-0393-40ae-acd2-08d8b8fb3e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 02:14:09.3292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBL39tN3wqAxyejb7AgAUb1V6A4MpwsPsj8/9Wig9WkkX+yExLIQ7Pq+9DJxg9nT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2827
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, 
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Horace Chen <horace.chen@amd.com>
Sent: Thursday, January 14, 2021 9:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: race issue when jobs on 2 ring timeout

Fix a racing issue when jobs on 2 rings timeout simultaneously.

If 2 rings timed out at the same time, the amdgpu_device_gpu_recover will be reentered. Then the
adev->gmc.xgmi.head will be grabbed by 2 local linked list,
which may cause wild pointer issue in iterating.

lock the device earily to prevent the node be added to 2 different lists.

for xgmi there is a hive lock which can promise there won't have
2 devices on same hive reenter the interation. So xgmi doesn't need to lock the device.

Signed-off-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4d434803fb49..a28e138ac72c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4591,19 +4591,20 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 list_rotate_to_front(&adev->gmc.xgmi.head, &hive->device_list);
 device_list_handle = &hive->device_list;
 } else {
+/* if current dev is already in reset, skip adding list to prevent race issue */
+if (!amdgpu_device_lock_adev(adev, hive)) {
+dev_info(adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
+job ? job->base.id : -1);
+r = 0;
+goto skip_recovery;
+}
+
 list_add_tail(&adev->gmc.xgmi.head, &device_list);
 device_list_handle = &device_list;
 }

 /* block all schedulers and reset given job's ring */
 list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-if (!amdgpu_device_lock_adev(tmp_adev, hive)) {
-dev_info(tmp_adev->dev, "Bailing on TDR for s_job:%llx, as another already in progress",
-  job ? job->base.id : -1);
-r = 0;
-goto skip_recovery;
-}
-
 /*
  * Try to put the audio codec into suspend state
  * before gpu reset started.
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
