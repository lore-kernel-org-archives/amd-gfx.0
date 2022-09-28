Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48FFC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 08:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F26410E32A;
	Wed, 28 Sep 2022 08:00:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C92310E308
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 08:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8QCQRE9Q1npndZ+kXqW1G9fJDoh4PKRT7811j1GjaDWfP0Cnq20sadkeDacmlcZLKb9sxVmLK2K7iHN/eE1RCwsVHFD2yc7vYeXH+5DONi+cVE1JEaAC6OJuS6lUpjI2QIJ8mF8meQXWFFH0DBFzk/CY0dh1e/eO6zRUwk2wq6DB4Lnum1q+gP7J13uPyThjOuP06ByDxEdUUDiiCYmEsLnDkOqw8+54KfaT0qiJrdGT5z+xYsTcTSC8nKc5HDexQOg5aYFBYea7zVnhDVdo14GwqAQBmuf5Tmi5OR8tpF1OMvP408tkHnNhQuOv4vejmcYgKYrFCwga3Ab8kIh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kB+RmJdbATwVJZ/1rGy4BHWPQ+dh5CPHBiYHrPfDUQ=;
 b=M37P3TKuq8JIL4LNqDgKI0GojcaE4c7YVFSwbhe3MHWesonTUpvM/CEw1M3LmbmfXobn90QGy9QQNZvUNHDiGL7KyR5m73jpbvVrL2SAt0awb1hSLDN4rOzTlxE/bPoeQh9ecj37aqThbxnubJGCrokIN0DPlEWk/aF4Ntt2gzihhfBuFI13QHckS4Dkv5mE6YMHCgob7K1V3YUk/59240oJ4PV5GdMD0PdNn+vKV+aG6WuB/gsQOItVIhLoGE2g9PbCZ3/Cyj6Pnc93GBMYiwdrmYDQbMtSHCHUseeb5jD5SZ4tYrxfAFNOPtxKxvPBY+rNMJdkroYcMEgFSk+8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kB+RmJdbATwVJZ/1rGy4BHWPQ+dh5CPHBiYHrPfDUQ=;
 b=EeF0zCt27w8lqHCygKgre6MWoCbTywEZB5q7ZCBK/KUaEj88MnGU3BRcoWklcmhCxfk1SLYtNJjEoNMLtwA4kiiTYcjGV2gD0A3N3d42thRS6Ot7YQY7Rh+cRugDf6ibxNAn95r38GyRIgLg/duZcjyabfFgPXZgq92zYNo5s+s=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 08:00:32 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::351a:44c2:f845:e6af%4]) with mapi id 15.20.5676.019; Wed, 28 Sep 2022
 08:00:32 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix sdma v4 init microcode error
Thread-Topic: [PATCH] drm/amdgpu: fix sdma v4 init microcode error
Thread-Index: AQHY0xAijztccy3swU+aZy8+2toSm630ejuQ
Date: Wed, 28 Sep 2022 08:00:32 +0000
Message-ID: <DM4PR12MB518193F098D86AE418A1C9ECEF549@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20220928075821.3410625-1-likun.gao@amd.com>
In-Reply-To: <20220928075821.3410625-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T07:59:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e7b74402-0293-4f3d-9943-cb097d14a011;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-28T08:00:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ecba500f-5ee6-4a44-8ab7-2d7364b2e10c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6226:EE_
x-ms-office365-filtering-correlation-id: 9bc34b13-f782-4d9b-9d24-08daa1278487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZeEBgO5xbtJgj3jNy+SZsy/niGqosr+v+hAbGdDP3EUbprb1VqAEKllbi/6t0HrnTucWIWtLOBzsDoALfQrY5Xi2O2/7xtZ5wGd/4jDxzZjV6+Id1LHZHYEHY/Axg8ezaqErTZ+oQHh3/L0r5UnoQb7ObblphqBcqUrJPQdwDIcV8MjzNL5Ot/70MoBQDUOOevYZ3HINOmBIJTBtpV+noI5K920MKDfpBO+Vmoun882tCvYYI5tjlJOyUvEQM6ZVdov2+ljRchgs3sLSEPrfGNjYbQ/kJztJELALcd7hyDbfX0X54AVyv+3+JNsJWNQVbjlAK0eyBt+I7+4PYlSWaqpToNLFxY9R32GQh24Mx45e/l3RDdiHMPcOoa5lbujvFk3lPG3k6PSn+ylO0ITx1gzy1sQrVg2LSZDcmIVqpBYIHszlQQ20LuwnCfg6rfRHllS2y11OcaIWRqPCBH7iMuzYMQeyjGNOtl7I1k8fOCfI1y7pDrJTTGrBcCfWeUNAuSvIR1CgV9La2ABvgHHKl5Dk1DcHvGkI2+s/VoBa3DhTY4lC3cf/qOENWL1EPq5/3vWaFl4y+YUEZ1ATsed8cd67k3CjqUZLLDnUqTXQGmcXTANysNfScl+h4C19k76VPGgnd/FUjZ5ruXC9gVh2n4Kf2S8xXJJEecnGtI2DwvFxVc7JkhR6amrFhPEfRD6IWebwqTfGdbNbpS/rcNQEULbT7ttlX9AQVWpu3HBMdnKNHU4lyaFlVMAmPsXRr1y5JJ83ROmjKcdRxF7O3ELL8A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(83380400001)(5660300002)(8936002)(186003)(71200400001)(86362001)(26005)(38070700005)(55016003)(6506007)(7696005)(52536014)(38100700002)(4326008)(8676002)(64756008)(66476007)(478600001)(66446008)(66556008)(316002)(9686003)(66946007)(76116006)(6916009)(41300700001)(122000001)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?El5DbpZmWkPWz2hCLs7Kni8HvcYruiJOCuVH9RhMCBaHIYFFqLEHbElV1+hK?=
 =?us-ascii?Q?alT46PrxHYOrID46KpwT/uJaBbp28k61YpMFNNslLMCwfRxrDfiixDs7X6yw?=
 =?us-ascii?Q?oxLUh0O4vD6CA94MAQYAzJVt4UDqVTM6IaQ5yVPHRdJC4V5qL267WuOS/P1A?=
 =?us-ascii?Q?Yx+cm7qvi0M8SyXAo8qKkvHBZTgV+akbE3oVgmHiSyFjPQt2m4dOLA+1VQjO?=
 =?us-ascii?Q?Ch5Q6f0AsDnsZp5yuqo82zsJxMnC6GTU3tKJITy/LQs2WslnuqJgiley3qJZ?=
 =?us-ascii?Q?GxCfvrSIUzg641m0djDVn31U2L927sInmjpmKZbUKBY51nt14IWuiMPVYb/o?=
 =?us-ascii?Q?J0NV5xxFu8hFsqKYWUQpI2+4lScn+WJO5H65i8XW4vVpwEYqkAzhrfRZn8qY?=
 =?us-ascii?Q?43bEoVNuQgGkHdf1E1YQatebEcKF7EAzl9QA0OJXRGhSjOEHQEa/uQh8ukfP?=
 =?us-ascii?Q?1SBssVnQspFPCyHgX6yMweBDG3uk4b1Q8eAmyCVcJ8+kToVc0jj+1amyjKFY?=
 =?us-ascii?Q?MgMeAFVh2/anOkAyXUCWv9rAWnYudchFwHlop4zInzfUxKxQqcHQsnjRY0HT?=
 =?us-ascii?Q?go5cBjhBRpYxSXBTSTlUowmKsvrnRvFmrpMekJaFveNMl0sgfVSJSHnmCPGa?=
 =?us-ascii?Q?/gQskLq7upfWakb5RehCXgMdmSgmahdNznzdvSDLnGT6R4r6xWJoEI1SXeu0?=
 =?us-ascii?Q?5B5hgNXDN6zGiPhetHZ0ZvPhEamKFGfap/ByUeZuB/M8vi+Y0+h1QESrTEN3?=
 =?us-ascii?Q?WLJAeN7MSj7EKnF26nfzQ0J7qOrumA3nNfgD44Zd9F8N6CeQuqvWsuj33soQ?=
 =?us-ascii?Q?WO9iaTTQXbu+cRC3sGRwRChZtb9yO8G3pD37BItsCbirhG97Rztb34+S1Fae?=
 =?us-ascii?Q?uABIugzazwX14OYin33WaPUow93897J0U5TnZj5cKPHStHnpELL1bhYCz57+?=
 =?us-ascii?Q?bHabQSFtAgfrVtrc2/3D74rfi2aQu0v5SIeAWmP9cscQIZMumxwX1lGSBhoM?=
 =?us-ascii?Q?pa3aJR4gRBBUPujbC1VBJmZDzV4LYRV4GGS6/ny1LUTqfLK3QM9lEYo3ljxn?=
 =?us-ascii?Q?4jeSa/bcL4XOkyp3vi+SMfER5MGnf5bUogOX8BMX8zSjCf+cgvJ0T4A2EbB7?=
 =?us-ascii?Q?lJRhSHpsCS9md+KtnVL2o1Cr74NQ9qcclabaWCZiV7Ovpm4s/wksXrRyJa8f?=
 =?us-ascii?Q?VnsvZUVNglLWzR2YuD5+csVkxgzHTKqs8xs2+N27OhgIrs8qrBnlgAf16X4Z?=
 =?us-ascii?Q?4x5/X7IoMW6vTwXzUsBIRWhvhNp+gI7FrYZSYct/P0sVg9uuZa1FBkIzx7M8?=
 =?us-ascii?Q?OA3n+4GgcFlupy/sqsG3IXbxyGerNjgqi4ruVORQ0PS0UCZnIZJh5aX6yHyD?=
 =?us-ascii?Q?m+hhfMdHXdMRCL8DdC2WihuwnTiof60gUArmUV1S5S25XPeTsWExokbHG4Ma?=
 =?us-ascii?Q?uPlNK/kGXVTN98oZLDI6rE4nTXyih4BcNnRxVkpX2EIF2hHadN2ykfMnUzkA?=
 =?us-ascii?Q?ceJWdbFUeF1MTa58F5EtXAq/KeOPlrLu/qd8jewn4h4gVV7fMa9HZO0NNA1V?=
 =?us-ascii?Q?PWq3T8ay4/3eK9KZs78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc34b13-f782-4d9b-9d24-08daa1278487
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 08:00:32.4997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeCUNlHggrXeFPraEGSRs1xNTN1T6DPQiYmOX66YDz2BWPWTVMmzXTPxtBSLPKJq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Fix init SDMA microcode error for sdma v4, which caused by mistake when rea=
rch sdma init microcode function (coding 4.2.2 to 4.2.0).

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 631a5b5828d8..7241a9fb0121 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -621,7 +621,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_devic=
e *adev)
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
 		else
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma%d.bin", chip_name, i=
);
-		if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 0) ||
+		if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 2, 2) ||
                     adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, =
4, 0)) {
 			/* Acturus & Aldebaran will leverage the same FW memory
 			   for every SDMA instance */
--
2.25.1
