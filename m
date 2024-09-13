Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ED2FA3730
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 08:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A5F10ECC8;
	Fri, 13 Sep 2024 08:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4eou95s";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FC810ECC8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 08:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVTWiA7aUC+rCB/mGBDOR3i5gKvpMU+t/x9G/9i86kRClksNLrBThAGJu1PLx2mWPMoADoXepCKVIKaB1Zhcaon5Q/Nz9SFwXvoeOBHFK24nQeRxQMURfOkO0AZwbWkJzbLHHCZmKwKgoEt3ATj6dpcv1dVrZnS7edNbrbKvo6G+9W0NPfGppwTes50/o5QcfWuquBCfodnEcnxk+LCs7CZbskhKXx0mGqctgAQ1hRefwzoZKvZSfcCDQyZt6uUI01kGWqervMMLuRvj5Sb/VBP6xp3HyC/1nyxtgRyqzAiap9TLd2JyEk3RX9BjcFrw0lgTsWHHw09Sudo6k5QupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFwlH6dvo48P200mJ3xEh+kVRbPerf4EskHt+B5K5ok=;
 b=IJKO0mO0EwZsF8R4SQKoupXq4N1JDdndtu7arto/cnF9DMNaVuALhybcDw2mnpDBbX6i2l9AHLFDTWqa9ZbZTkIFoZAy73ckqFAsjIXfKffm2kxNAIsIpRg/7Ebg2cngydmZ5vge+tWgVhwmolEmSzC8X3xAfTjFpsEsXzc6TBnjB12vQaHPKP6v5aH0i2AAtKUxrAHR/Nww46L4RuGESGunewhqf2ZgVuLycQ6qV72wx5lr4sOg4Wp37BbluQAnOZUtuIB3uAcawOzbj//cdVe0cZzoWkuBoO+F3i+v/YxwVV/XaFIp+rogslGSMWDBXllObSYcHBXeA2Mks8M+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFwlH6dvo48P200mJ3xEh+kVRbPerf4EskHt+B5K5ok=;
 b=V4eou95s/xA/cxzhG3u7V6T8MslnRuXhTiu/u8RbsZVQSEIi9i7uD5K7anZ3cINcJ0ChTRng1XSjoj0y9aeKjkFtR93sc4yTmEyb7E/Jcycc+NU1vqQEFkX7c+L9ssd9IJ3uEy9EdZOv1sKEUZy6FRz0mYmrN6HU33aTl8Zub6s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 08:59:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 08:59:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Xu, Feifei" <Feifei.Xu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd:Add kfd function to config sq perfmon
Thread-Topic: [PATCH 2/2] drm/amdkfd:Add kfd function to config sq perfmon
Thread-Index: AQHbBbeIjavwGij4gkeVFHImanv/8rJVawPg
Date: Fri, 13 Sep 2024 08:59:49 +0000
Message-ID: <BN9PR12MB5257833FD7BF01C3E8E4EE77FC652@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240913083234.54001-1-Feifei.Xu@amd.com>
 <20240913083234.54001-2-Feifei.Xu@amd.com>
In-Reply-To: <20240913083234.54001-2-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bfc33225-a0ef-4838-92db-46b6be478b71;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-13T08:59:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB8126:EE_
x-ms-office365-filtering-correlation-id: 24d1da53-0889-418f-16a3-08dcd3d26cc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mYZeuwWbzG3YPeSNc5LkVRnM+Nv7xNhrAFOJ7JghGzVAVywlQtbi8FQlYsoQ?=
 =?us-ascii?Q?0zSPHebw4EDaVBO+rLt1w3orJRfX1FZLYmClXoovZ/KPPG0H3imgxqoQ8COt?=
 =?us-ascii?Q?eH+TR1D8dYBFpqHBphF/UMLU8a1Uy7nQ4EjkfLRdNRIWRT8KHJsUaC5lR2yh?=
 =?us-ascii?Q?269TAh34bRtuqEY5wqKiRR0WSk75S7UZu0ErYwqVj43lUg22075kb4zS93T2?=
 =?us-ascii?Q?GqDcO1S8XuGdNYhaMfieiyN9wStpwKrsoZ9gB/8Xrio8aDnrs0jreVZD+sMo?=
 =?us-ascii?Q?voXHxYas+zSvM2W3f9RpHEAtTPhyQA8jz5+vJbka2mhXx35paFJGEXZ1jMSJ?=
 =?us-ascii?Q?xzDbWUr+chAaBUuMs7kACiiAu2zWtJNnc4h4l3x1R5/TZWzuDqEG2LRpJcBZ?=
 =?us-ascii?Q?wWjE1HL+GWuLOXmwkC7MHOMEjXAuN3bM+eEZ/t9ol6z3s+VNYc/RPFm3ypxr?=
 =?us-ascii?Q?ucm1QWOOuvYtj3Ap5ly6ack7eiQkCa3Ue7XKtE77huQZGFdtqYOW7BCllPFu?=
 =?us-ascii?Q?SrJcquSQSIl6dZT42SxQRjXIrpqjrZc/EtLWyT6oVrJnP63UARFFsv1T328L?=
 =?us-ascii?Q?HQN0uHJxS1LzN1vfD9d5CDWGJ9vdCN+RExwsw0SjBM0ckaTsSh/p1j/skHkr?=
 =?us-ascii?Q?+k2DyOTZxC4qFLB8F2ROGteGPBbAinCP4X2yXsaF/xWd9ftVMR4ze62WjZx/?=
 =?us-ascii?Q?zU3/t9uxGdWXJpgx9U08FyTUQQfMDYWWtiZWKB+atuuQ0DxB/NxTNu4C5lI4?=
 =?us-ascii?Q?PoPoFT6hUWS3CtdjeISUpPuiaTBNqu+hkATsORwBCZbBeLJZgvI8GCUTBOBU?=
 =?us-ascii?Q?XPAr3HMTYjboWbfEaDg4GX88I1Jc81UkWw5O8braTC90W4VTxdnzk0arRYKC?=
 =?us-ascii?Q?mxSYOMNx/BOudmWjsadAaPZuYscSwgKwWSypbDGXsrw32w+tzxwoDfIw+MDH?=
 =?us-ascii?Q?a/ZC2Q72eCBNlGP+DnVze+XlhltoMIbw1PbVb0cKoxqHGi1MoNP4nhuRAljp?=
 =?us-ascii?Q?FXtacOAtOryDP7eZ3kH19GARYHk1LX41b8M49BYUr9vvXTvF/3bMe/fpwv+u?=
 =?us-ascii?Q?Y7Uy9BVNkYomFH1+Li8kCAhCGqAVPB1NMIIKFQHys5nGpCDDXsaeFA37y392?=
 =?us-ascii?Q?muh75uLPqwrN5n17Yx89XHBqu7hApOn65LmV2u9IQ5FUTu2dz2gGrYFmSJOn?=
 =?us-ascii?Q?VXw+FHZCVXxj4T5M+n0OP4FhUHiByg+jYopFlkNaCHUlfnwgdx6ZqcnbufOx?=
 =?us-ascii?Q?TMqI9u8SisxqaiBkWFUU4ksF6WGGyuaMGEouU8UlaXZaGnJZOKFxtye5EVDz?=
 =?us-ascii?Q?KG46dnnf/1KCjk2oOa6WGg/a6sS8DqmQ/YJpajiayE/9Fg08fCQcOwy/muJV?=
 =?us-ascii?Q?iGj4iNICxXUE8dwTjfF8Ao+9c27tz2AxFNCp0UiDwuNF0GwseA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8a97cNKy4gwJ0cRawQqSysxkrRXck2cg+B/mn2vAZ6TRK0ppesL204Cny/dt?=
 =?us-ascii?Q?9DfJFjptdlfrTVvtYqPLgqAvyj7RWnmFomTn6pTNaLD0VKYph8UXVQqP7upH?=
 =?us-ascii?Q?haPeIKbekw0Sh0XZoxylWKtfKlLf8ivBFxoFoMz+GGicj5RXU/iXEa5C0pfT?=
 =?us-ascii?Q?/M+SOZeAm4Mg+kqHbII1WV9Lv1sALbt2M2w0PFWyCWVCxjwTGS1EwWfSrNqp?=
 =?us-ascii?Q?g6M0OsL+WQUx0JTo5niFRmaAjKXo8x5YVoBKL0FpEJcmLqu2RI2uSNuoRE9L?=
 =?us-ascii?Q?udol7QWBpoy6Mae0LacWtIDqL6Q1xLTbjsW5OmypFc8tKGp3a6mjaghkNVYX?=
 =?us-ascii?Q?z1+GkHwhiizYCOsEXYlvcLDGG1GHsPBopxMkzGTFLomJotJBYdkreUtFd0r8?=
 =?us-ascii?Q?Af0Tz78vad6L9ALpdd15ExgH+aKuLBlTW9W6hZnNgHZiGaWEBN1BM8uwX6FH?=
 =?us-ascii?Q?cpqMYspCOG5G5yZd94AObRjs7moMONyTpduc4vNJalV74La4upmy3q2f/Frk?=
 =?us-ascii?Q?orItDkF3LEYSOs/dfZ+CnvlhQS4D2LzGRz0sJ+i+RuvwSnkaD+zk754Nu+K1?=
 =?us-ascii?Q?oAk3aaKqIu5J3K73J1K7fObmaBdxdMfQaDpmVYWR+If67z7sLdzQN5Grx/Wo?=
 =?us-ascii?Q?AjGOWlunT5POkmJ7xIQQK+8E+ABKJI3WlX15schwZw24mrm8I0tstG5x+hXF?=
 =?us-ascii?Q?evr989zqtiz8TUXamoqJ2SHqIWFevjg07Y9Gl+iCpes7yrWWApaDgjIog+MZ?=
 =?us-ascii?Q?LtLOLLqqD7HNPZtEzJXQ+wtpDnown55F/xPdrQ4JAQGbk1OaTCHQGPmJTYza?=
 =?us-ascii?Q?naXXU/OI0sXK0S9xBLA0Dp4ZogQ+/OLu5sceMlFxzlelRE/Z9XZDa9phQIHE?=
 =?us-ascii?Q?5ves93jipmIgzdaVXvwEm4K1sBYicALQ3dW5diuaTTS9qF5TwySlg05wCIu/?=
 =?us-ascii?Q?LpaHpbDdXJlKHvD5kvuHGWpnGkUxCzMC85EXfI0Cq/uy+PrzvM68ROpos9/h?=
 =?us-ascii?Q?5Rztzi3FRLYvUXRZrXeRRttC26beHhjlkTQOLiaO64P20JXyKYZat70pfBJb?=
 =?us-ascii?Q?26+N/sCQM16Ym1V+lKwi1JInIndDGgeBUIUiHYGnif71x87Ph+kSi0Z+eDmx?=
 =?us-ascii?Q?pZJkKIRIW2Zi4gVFwVG2Ny4xVB3sfYYnofJKxn5nomHagURici05sucoVer9?=
 =?us-ascii?Q?g6xNPZsdYESRQZn1ap0IxtqQ4yPmo/ebGx75Dnegu+x3F9hXoEJ9QY7bo+KH?=
 =?us-ascii?Q?zHFefuI1AMb32LVKiYbVvL8EOUKJ6nWrlOXKaNsMEtIGG+WaUIVNwY63G+By?=
 =?us-ascii?Q?CIwgPDK2d1wU5XLvlMwMFelTyY4GrqPTm5B6mpZe/ShBSsSw59KBv58AnMSX?=
 =?us-ascii?Q?crWCNM7V2aGMpC69jOTbNYLY5dSqF0MwbjzmEwIy/5ee9/XaEit8WvMtontk?=
 =?us-ascii?Q?n4kc1hSmLH801/0R/xVB6nCbmXarzJYOE5hrpgkhYJr95juf1gp903DMUcxk?=
 =?us-ascii?Q?bYuOhg43lHiBDHGIQBBPLP3T04PfJFssX+lCG/mxHS1Hn2MUTVLDFRDlrHmN?=
 =?us-ascii?Q?06ZXdEWnPJTrUPMsmUQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d1da53-0889-418f-16a3-08dcd3d26cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 08:59:50.0279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2lFATsI5dV1okhCMiMRFepXPoLeTg3NoXQYe1DlTdfn4tgqPs2ug0oEeKI9deBBFUL55+LbhjisGn0f3+nOaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com>
Sent: Friday, September 13, 2024 16:33
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH 2/2] drm/amdkfd:Add kfd function to config sq perfmon

Expose the interface for kfd to config sq perfmon.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 +++++++++++++++  drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 4f08b153cb66..203e669fce5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -889,3 +889,18 @@ int amdgpu_amdkfd_start_sched(struct amdgpu_device *ad=
ev, uint32_t node_id)

        return kgd2kfd_start_sched(adev->kfd.dev, node_id);  }
+
+/* Config CGTT_SQ_CLK_CTRL */
+int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t x=
cp_id,
+       bool core_override_enable, bool reg_override_enable, bool
+perfmon_override_enable) {
+       int r;
+
+       if (!adev->kfd.init_complete)
+               return 0;
+
+        r =3D psp_config_sq_perfmon(&adev->psp, xcp_id, core_override_enab=
le,
+                                       reg_override_enable, perfmon_overri=
de_enable);
+
+        return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index f9d119448442..7e0a22072536 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -266,6 +266,9 @@ int amdgpu_amdkfd_unmap_hiq(struct amdgpu_device *adev,=
 u32 doorbell_off,
                                u32 inst);
 int amdgpu_amdkfd_start_sched(struct amdgpu_device *adev, uint32_t node_id=
);  int amdgpu_amdkfd_stop_sched(struct amdgpu_device *adev, uint32_t node_=
id);
+int amdgpu_amdkfd_config_sq_perfmon(struct amdgpu_device *adev, uint32_t x=
cp_id,
+       bool core_override_enable, bool reg_override_enable, bool
+perfmon_override_enable);
+

 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
--
2.34.1

