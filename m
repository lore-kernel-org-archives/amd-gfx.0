Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E873C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Feb 2022 03:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5292510E21B;
	Sat, 12 Feb 2022 03:16:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC63C10E21B
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Feb 2022 03:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCCg8ldyPX1olXOk8N71wEvxh3LUiVYVPbZA1cWtK1uG2UE9j/QzaKNUXwvVTJRSDFCxOWEekVOQaBB2Zr8/gLTgHMksOEKsjFKlIdydg5/FJD7A6rxdthSZvEJi8jacaUKFo2qcNyM4fyNyrbfx6IbZx6NfcqAgmp1pKs04PB8xcf/KQqLsSYbFwBtDzp0S7Q2yd2VKiQXJny5ewoW03Y/UG/ylTiNR9/p9Cs88x/FSetZK6B00Ec96CycFayx1bXWGk4m7dHmasafTnIzhljeCoH+MBwLBfhA4V8EGt1WevWw97J/bCVe4kK0xrBPjnS1VdUXYJna+PZF/VP9FTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUNqtSiXF6z+W70hUyetKDXhyeRW6zTIsTR2lrkRXyg=;
 b=OteDjKVRv5f2b+w2RM66rKdA6yJ1NGCYdpqE9X4MHt/8VmJtpGD1JdXxdzyeeyqAcFptUJKvHINg1LufYk54PK+A7cwT+THOLG8PVCGqxvO1xZGxuEfIT1xQjDBXPJzmQczVd4VNxgc70dSqmevfCyswB3nq8ymMe1S2tqeDGsuEjZEEs2TDQOYeIz+fFATXr7FJ7N9Sw5A/YddFab3isYTBu4nJ5SG2Vs/hEw7xhOs9JFDNb05l4tTLQ0rwFeq22vNsFbn5CceltPGY/0RV5jWBw9/jUm4Sv8wzzJILxTeAtRZxtbEJi2xZal6ndOtyxYXYZZMzYVj7lpHiqyctaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUNqtSiXF6z+W70hUyetKDXhyeRW6zTIsTR2lrkRXyg=;
 b=UKXzvessCvWmmIHwOJmjc+S2fGCOXnym1PzqUHUTExwmAj1ufn33TnbkkLCzrlXDNHYNBkaYOnDNnhyoy1Du8eYu6QoNoK42GpOXuOrXVuIJ+oDfdT1Y1Iw6yF8hcyNp9DmStITQXDfEz8QSi2G/dkVfuEi+GewC8QkbI85RONw=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN8PR12MB4625.namprd12.prod.outlook.com (2603:10b6:408:71::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.12; Sat, 12 Feb 2022 03:16:51 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4975.011; Sat, 12 Feb 2022
 03:16:51 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration
Thread-Topic: [PATCH] drm/amdkfd: replace err by dbg print at svm vram
 migration
Thread-Index: AQHYHio56ZmEPLXJWkOrVMHJjNgFR6yOiYkAgAC3+RA=
Date: Sat, 12 Feb 2022 03:16:50 +0000
Message-ID: <DM5PR12MB24695233F69CEF826BD9494DF1319@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220210025902.32514-1-alex.sierra@amd.com>
 <20220211161758.29610-1-alex.sierra@amd.com>
In-Reply-To: <20220211161758.29610-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-12T03:16:42Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a100681-f722-45d6-9132-4cd944064cc3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-12T03:16:47Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b29d2f1a-9385-438f-bed9-d5a38d647606
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f93e0ab-669b-45eb-5d3d-08d9edd61cbd
x-ms-traffictypediagnostic: BN8PR12MB4625:EE_
x-microsoft-antispam-prvs: <BN8PR12MB4625C477E159991C9B17E53BF1319@BN8PR12MB4625.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9cVOb61+7sDgQ/rLeIeIUqndJ4TKLXfL0v7wUKLmL47PlvyCZIa8uzvIo+mmrgRneBSJdZQ7NVJeFLK3kqSPPUgd9aqO+EObUo8sOtqGKXplEIVIfTdv18vQAP+kL8QE68/Pq/iAd2fosptL2/IWg5dOwa+h13hX4DIYlnmpazcgnaWimSc/etCqdHKvmXqIS5rRC+xOEIOoveLS1dS/GEc1vFgdL5alplHhHDDmEGzILcPYFExW27E/wXeSjyBwd8mLuQHlqs6ezE2OXP+Om7jbjJFNXGhl5lvnGIbiZ+mEymjhl7np5Q5cAK0QSEB/KgP69PaTPp4BbluzFh8xO7RQIr8tYdDy5TKC9qCIdgmb9jxjevrgFGImJ+ydamfmX3Es4bRUnKnGz14xtxeLpSme7rU8Q9wa10fCFNKq6mR/r4bCQcdnkh4R1bT6n4ZzdrW32rtCnDwNqiwj+eFXy7mAIwy9/vJ3V0XUooY7Om06EyBdz7Lmb5s1ATdmQUJxcPD10hKT28MYYgtpSTrKaoAbmRzCiOxIrIFRy0MjwnWfkKIMcDLYIvkQcVXKXfoZxS2z0FLVY5HC9solJk90Ia0MJvvwxtoswOu6UOVps2HozxoI84YxH/eHyTnCH1e/BDd/MT/EeLdxJ1yUf5xFK7LknP3fQHGqFD8pecIV1JzZM9P3ZD01rPHoPbPvwBWJlB0aGZitQHZJyoVagrDMg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(76116006)(64756008)(66476007)(66446008)(26005)(52536014)(9686003)(186003)(66946007)(86362001)(8676002)(66556008)(4326008)(110136005)(38100700002)(53546011)(7696005)(6506007)(122000001)(316002)(38070700005)(5660300002)(71200400001)(508600001)(83380400001)(33656002)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lo31Yrg4Iow4bWj1Bve2ON5TSEQCgtV8jqA6JvOHrC3pDBIcYtceutVeLNy/?=
 =?us-ascii?Q?ZEMw7K3N3rRcHTRKsLWrLYAXrbtw1vdAb3n7TiPNm0IeKSZgandrTNwVxa0U?=
 =?us-ascii?Q?CvjqX62cNupQ7U0gT1egN2zHshbHE2+k60I2hABQzCkJojusUcnC+B/jok9l?=
 =?us-ascii?Q?uJM7gilHoA/Qd6BWxCSc0Dn8bUNzXcEP4X9cucbIEG0wwFNqih+fGEGRUVzR?=
 =?us-ascii?Q?ghuXUfEr3bjMSiZf27EGuxB0QArMWNnwRQXA6M4mC2tYXUTOtT8BNwOKPl2N?=
 =?us-ascii?Q?SWmSpvJG7heq9anZjjxf6ftbYiF9ZuYicbvon/6Ow5zA8Y+10F255nXbafyq?=
 =?us-ascii?Q?B+1GSrRruCnkCA4IgsBfViKgIDDzTSAT2NHwAa6S9/QIil+EaZIhbW9MXxwB?=
 =?us-ascii?Q?cYrkg/OADxDyv4vAh5v5jAYKufzx8moVd0MrjbIFD07YuohCUYElsuHlh3i/?=
 =?us-ascii?Q?0bBirnBWGNW8O175+rv+Ej+mZna51riPD9xpfzyFx2kJR5UIbrxFGo9Tb7bb?=
 =?us-ascii?Q?0B6WlmMh1SBqAmmZb/4+MegwLS7GUvtaSlZ09UKVko0vwuHcqSG5xCL1N3Ph?=
 =?us-ascii?Q?A1rroy3tjUD8IbX7C9flzo4qZtFzv9rL1kQVitfdoiEYHtT7f08y/CfbLz6j?=
 =?us-ascii?Q?jTtr2Sc1iaGxW0H0BaL4dM/hkF/A3nec9x79kYiIBvQ/ymYP5UEw5KKKvowJ?=
 =?us-ascii?Q?o/D15dQQkgiOzsCRy7HfRjpLx/3q4YRyCH8bRFNn5WiJLA3hfTW04xvJ81Cu?=
 =?us-ascii?Q?Gdy56zHHw+X6hTbU++m/1w75Db900oozaIVDT2voSvkOyYXjTIg3poLC3n4K?=
 =?us-ascii?Q?ILluUMlXqUr529kuBLSjszzqtGdVaM5g+1JpCtCGPrhCPEFGfq/BNtJClCKy?=
 =?us-ascii?Q?tzRXHfrY5AGMcXTsNNYIPuOh/HPS0xlOZyqzJ5C4tKAFScXSoA+eNxMu6Avs?=
 =?us-ascii?Q?yku6CrtzIVP6XrAGNlU3GaIVTsDf2YN5xDmo7wCNJKtZN/sMmJ8U0jzsZHKl?=
 =?us-ascii?Q?ckCpPMbvpljyYzPiSLbTj7EqRsbaaZWkRkL4sskJDrcD08c+TZYMYs8u/2eL?=
 =?us-ascii?Q?AAGprXbF+s4YMljcl0/1PripGm7sQH7pzLHiZpk3yyMrioQRleeJ98qY5Y6j?=
 =?us-ascii?Q?0/1zBFtochcTG8gpLS0VjirN+uq7TCrzibMmkIPMRQE9YBYs+O16gIfEsayG?=
 =?us-ascii?Q?ZI7rdGwoTzX375DuvH4rxDnAepNyQfsLqck0vNMsgiso7CHNQcxdoZLMboB2?=
 =?us-ascii?Q?SKGCSxYykbY7FLNPJdAuHoYAXE5GU65fFLvlNFS/ny79dGNmnmaSGYaawet+?=
 =?us-ascii?Q?bZw7OnL4VLWhv/5wj903lt5H0LxdcgMK6yPFUXUtp+3skr/lv2Um/znjXZJG?=
 =?us-ascii?Q?krs3CFg0AkQjmuN0xTz43OyFWyqtPoPsvOj0xFYtsRN5XI0vU8jL4yRkDbeB?=
 =?us-ascii?Q?0vX4yh7MQJTfhDeVz5LLHSiC1AWNQmD1ARU7W9rwduYdfLkO0p4njz+4F8w/?=
 =?us-ascii?Q?2nEijSqyzHXxbjSnKIQE/CSK45d9gu4AgY3PyBKQjUQ6xRBTn90G+qRnT5y8?=
 =?us-ascii?Q?uTse894LMct7yKYgjHSpjxh1L7p92Kd/ZS7F1Y+UzXaN5yzIM2l3Vsj1mjCF?=
 =?us-ascii?Q?934Dde/n99ARlcagyAbuXo0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f93e0ab-669b-45eb-5d3d-08d9edd61cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2022 03:16:50.9186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IhGbyMdabB3fAxvGP6isY2vSa1whxjodPQPW8fcvC+HzKzn6ODV6/DWEL+oghtzeeZPudT+wV3uJTUWYzOBrHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4625
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>=20
Sent: Saturday, February 12, 2022 12:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Chen, Guchun <Guchun.Chen@amd=
.com>
Subject: [PATCH] drm/amdkfd: replace err by dbg print at svm vram migration

Avoid spam the kernel log on application memory allocation failures.
__func__ argument was also removed from dev_fmt macro due to parameter conf=
licts with dynamic_dev_dbg.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index 88db82b3d443..befaadc0e854 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -36,7 +36,7 @@
 #ifdef dev_fmt
 #undef dev_fmt
 #endif
-#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
+#define dev_fmt(fmt) "kfd_migrate: " fmt
=20
 static uint64_t
 svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)=
 @@ -312,7 +312,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, s=
truct svm_range *prange,
=20
 	r =3D svm_range_vram_node_new(adev, prange, true);
 	if (r) {
-		dev_err(adev->dev, "fail %d to alloc vram\n", r);
+		dev_dbg(adev->dev, "fail %d dma_map_page\n", r);
 		goto out;
 	}
=20
@@ -332,7 +332,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, st=
ruct svm_range *prange,
 					      DMA_TO_DEVICE);
 			r =3D dma_mapping_error(dev, src[i]);
 			if (r) {
-				dev_err(adev->dev, "fail %d dma_map_page\n", r);
+				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
+					__func__, r);
 				goto out_free_vram_pages;
 			}
 		} else {
@@ -612,7 +613,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, str=
uct svm_range *prange,
 		dst[i] =3D dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
 		r =3D dma_mapping_error(dev, dst[i]);
 		if (r) {
-			dev_err(adev->dev, "fail %d dma_map_page\n", r);
+			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
 			goto out_oom;
 		}
=20
--
2.32.0
