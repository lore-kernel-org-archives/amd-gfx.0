Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96CBC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 06:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EAA810E9F3;
	Fri, 11 Feb 2022 06:42:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0364F10E9F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 06:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSUYOG7wBJ+a3ADh6Eg+kCIpF6ytZ19WRr4zqTtC3cKM35Jh0j23G4vwrM/iiOJQsKxit/eCLBuKiduDYiAq58htz/JMz2HOGDel1LmuJ/qQPB/pZo0sbECP/HAjzDNsI64XdK6Yxnqv02sOXYchel5xZuD9eOFG1Px0fZVOgWq/k2ggfYHQXcVPETp0jTCq6kg5/iWXZ56CbAHuHYvv04OWmsvVeMIyVLIJ9aruTxUewYFnm26R5Ku/1FHXgGC6vqIof+LQh+2FkGzrtVuRRPnXFSe82ceqsR79JCOJdGS/7cfPNzpoxtvXjznPU8UuXaAkWMrVkWTFD4SAtPCVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2JaHZLsaQc6WpzdcFmv1ak+sBuKqebL23fJqM2LTxs=;
 b=UcoWZiEsJ6op+hxDrIaKDGTfs4dLZP947TKnlWLhkqofyo4LbAWnSSvMUq2U9HeiMc2m3kuKu+6X81v3DHcBVSxYTv6azMCTn+lGuqsKsoKwu7oBa4dP3+RoYAo0nbjRngD9SrkDZZGyi3NiUGG2GFMv2ika3lDp6jyt/bjYx0w/eJxwnMtawPXABvcJ/JGMDxS4yo88W1WpfWZ7Rau22Dr2gu8hpUl6iMVwTXEC1NYY6wBdlzD7z9zTa/TfUcN2Gk74xJWfy9sICCvuag8O6C0+I0fMheywvSoLllcStRUjwZAWmFqM0eeX94357Afq/GTxnbDxWwzG+4JX/C8Clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2JaHZLsaQc6WpzdcFmv1ak+sBuKqebL23fJqM2LTxs=;
 b=quXd9z1E2h1rDDJbBT2e4lgt5SKBaKFaRL5V5zkiLPi6vvAjlf2eVhtaM8qhoehutnYp58m4KkklgW+F55z+yg/KUNLS65erhcj6nMLlHRqmNx7Vndi8v/9MYcS68JKLYMJ1Mivh8BA+HIn/2F1WIpu+xuzl7wYB3mVA0J5iaAc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 06:42:24 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::bc82:1b0d:96db:25aa]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::bc82:1b0d:96db:25aa%6]) with mapi id 15.20.4975.015; Fri, 11 Feb 2022
 06:42:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Thread-Topic: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case
Thread-Index: AQHYHwnCOGKTUdm2LEK3sPI+PEIZKayN5t7w
Date: Fri, 11 Feb 2022 06:42:24 +0000
Message-ID: <BN9PR12MB5257E276C9E2512B17CAEDFFFC309@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220211053856.31729-1-guchun.chen@amd.com>
In-Reply-To: <20220211053856.31729-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T06:42:22Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b8579452-f857-4972-878a-f17ef8f6b46f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe04ec46-6ef7-4c6e-fee9-08d9ed29a9a2
x-ms-traffictypediagnostic: DM6PR12MB3115:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31154D005BF361DA17ABE9DEFC309@DM6PR12MB3115.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eiLg+vCf6a+0vMIFmcfmwayfNO3RvHq7VNl8MYMoJH759XsH4WWAuMH60CXJSfU/mIQphZMhSlLIhjqP4qV2GyAbfSbROMQlGiwW9GZqDeM093+FjUgRXpYcmRny+YSY0NOQfj9BwWXobLYT6nC6oAxiXBloZ0AyoTimTahQki60Cm6zsytGt6Int0W4ygTh0Rr1sWwNjr4MmskHN6cHqJ/iJzdUZpB8WlSB6iMScY4U1G8ZJKBAdrtFDExa6EgUz6uV7IxdPHlwbxFJKcSHNhy0yFesRFzNBCRbc+1cuons6Dn7lAYWIKywkTe5qIdtOghnhhiNBQtm85R0kRCTMEgMRlUVGSLMxO80IjHiOSCKGh8eukLQ3djgBK9wRnQEYrsPpeigArJeREOYMMmJOUc++tGAsuC0yfwg9tKOHbklfvQ4SeezZjqoy5YX7G+xvrzW1kdnZVP08EuSb67jdkFf16tgh9aZE29SaYdbgrPSDRKKUEkKWXKEtQuRmB2UZUGmq5+B+Y005RgWgR+4WluubvsXqIHDCkugKRyiOlTf3z2JlzGdxH1/88iDamNwaiug7NZMfGlC00VvHt1Wojso0M05eNSU1QUxF6+uF2t6iBSaER1taLiOPSEgRaStJh2G1E93sHAHmGxi+Kps2JpVVP5S4bJvhMv1CZFA2EPI/FdJ8nO5Mci5QVJqvH7ANoll95DDlaDGL0tncyU0Zb2Vu3OHDuVAwUMIJx2jUWI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(33656002)(71200400001)(2906002)(6636002)(66556008)(316002)(921005)(110136005)(38070700005)(8676002)(8936002)(66446008)(64756008)(122000001)(76116006)(66946007)(55016003)(86362001)(38100700002)(5660300002)(186003)(26005)(52536014)(9686003)(6506007)(7696005)(83380400001)(508600001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aAnIHH2EIn4ecGnIBLRaRMEzJlhEZfm8THm6cGS+/XC0mD7f2scLroTjhpno?=
 =?us-ascii?Q?1MDIIIosjxzojbbNKw1MzYf9mQN9UIFfHbeqDsDBh0zcvMAdzZAc3aBumTJG?=
 =?us-ascii?Q?IO941C5IxeSntYh+HM5O0aJuG65fwoKbmV0FsrdTxNtn34C3D38pKIFMRmQQ?=
 =?us-ascii?Q?y2hzm2sjJdo6dym6VZzDNxkZQl8SDZ9SVsj+3c8htU6EAjiMbgH6FmtoDpHs?=
 =?us-ascii?Q?S/emeRbnm7Eq2hoYoOBCtBuhEo1m8ffK0a+dMrUbCKU06sJclyHgz7U3zmwu?=
 =?us-ascii?Q?TRIFaUb9eL0jsHCvVybUox7sqKM/aoCoRjXdPsu2Mthnz4UpZ8B4J3UXblSa?=
 =?us-ascii?Q?AmhAH7eRFsBO/84NAYsjjLYPSYYJK5DWwGtdhfs/94696VEpsXFzHi3IzsIX?=
 =?us-ascii?Q?OEP3ZiHn4nVnGgjY9LcbG2zTN06tBavbfnKBgGMZ+exgFeSKVZfSdH6ZQsp4?=
 =?us-ascii?Q?C5RPngNIWX1roK4Rp4YvlAJMT8St6EIMnx6Gkqeq2zserkAo2NlHP1Yr06pM?=
 =?us-ascii?Q?esK1WyVaCK5ytgDbLuRRlrreJGzWmw/wXCNClGSaxPxTmn6XvF7w5f7nBvwo?=
 =?us-ascii?Q?5Zwga+QQDNFucGHSj86pGPDSm/fFk9v/qN1222Mz3ON6+gj7h7qCIct5Qnd0?=
 =?us-ascii?Q?XszlHwd2FD9S7yUm3T+bP96ufddqml6fd4sFB7aOhLeBhNpLZkTs3c3NUtZv?=
 =?us-ascii?Q?6CDCyKBvL5mEOp8xnBF8yOm0ua76zExMoFdNBU60+Y0ozUv+bjxCNSw7Ns1G?=
 =?us-ascii?Q?BqCfLrTFF4icSnOWQmn9SIWBviYDrE+XjyjMtWxcOnKHGV/ZZ4g5PaoEEBS1?=
 =?us-ascii?Q?jTYe5j8FHu82bgBskHyh7xB8i0iA+uo42jH9uAlxk3kZFXRTmuFhsWI5a+ev?=
 =?us-ascii?Q?iakyUrXGbRf4q5mzNDg0zHSEu8eo+T78zpWN97OBMHOElJdKMm8z567gHlQS?=
 =?us-ascii?Q?IVbuICEOORJB+5DUI6AP4KlhoEjpPqP/cq8+fttN4z7pChCs3D9y2eL4gJH1?=
 =?us-ascii?Q?Pqr6pDHqkFinItu8QIMx9JUsG2dEqdUsO+0uhDl0QuLhv6/fNYNGgIVxZc0w?=
 =?us-ascii?Q?zkYStNcOXGRzci5OxUpILDIbdJkhzRN9ncw4wXDINDyM2W0N6bNgW5Wry93T?=
 =?us-ascii?Q?z7H4dldRUWIyXogl9ZQ1xAsy8OYsa0NgWn6rFb/Wn6bOOyFSkYFMqcdK7W4o?=
 =?us-ascii?Q?/2BHYmIxn0qnF5J2mt6ZFQliTolf4qJ8U5h7amIsT+U/J83Uz+wvWlDW5CoF?=
 =?us-ascii?Q?6QDpA9TPgiLY9O49zdiTO1RxWYUXjrJABDuZ1eCW/k62+uwUkd3kreoa+cAx?=
 =?us-ascii?Q?m9Fxg0p+2MnPdvcX6Ad/aSpCTXaP7Yv2bXIisfLnrtWtwpDfMBFOq7aGOS6e?=
 =?us-ascii?Q?oMMt/b0wK4bD7EtqL9RdB1gOa5P5YMWDkgKvK/xRDXwxLbch1o741kcJoHCe?=
 =?us-ascii?Q?OCeGeGF93/8duwyMb5Ns1hWpdQWSYfA3x9Kgb5Fok6X6jtcFF3f7aGAUACQQ?=
 =?us-ascii?Q?iOfLTe7G3yqMVlyeRf32fGohQmavvAa5Itnhkoiuh4x/jcZy1wvbUgvxQg9u?=
 =?us-ascii?Q?UnP7Emb/jVBZJgW7mikMPCvCaf1YKPrfYfqbLqVDBYMgeBr2a04CHDYarw7D?=
 =?us-ascii?Q?SucCDANtAGkkDOHN5CKzYu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe04ec46-6ef7-4c6e-fee9-08d9ed29a9a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 06:42:24.4328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSSstLyzP9aP/hBrD5DeNHCc2rvlSRJHZ0g7gt+8kTm61hkpoanimJNnJglJNlwNnm51+deoootSgc4KBiipaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>=20
Sent: Friday, February 11, 2022 13:39
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou, Peng Ju <PengJu.Zhou@amd.com>; Koenig, Christian <Christian.Koenig@am=
d.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Skvortsov, Victor <=
Victor.Skvortsov@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: no rlcg legacy read in SRIOV case

rlcg legacy read is not available in SRIOV configration.
Otherwise, gmc_v9_0_flush_gpu_tlb will always complain timeout and finally =
breaks driver load.

v2: bypass read in amdgpu_virt_get_rlcg_reg_access_flag (from Victor)

Fixes: 0dc4a7e75581("drm/amdgpu: switch to get_rlcg_reg_access_flag for gfx=
9")
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..6668d7fa89e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -836,7 +836,7 @@ static bool amdgpu_virt_get_rlcg_reg_access_flag(struct=
 amdgpu_device *adev,
 		/* only in new version, AMDGPU_REGS_NO_KIQ and
 		 * AMDGPU_REGS_RLC are enabled simultaneously */
 		} else if ((acc_flags & AMDGPU_REGS_RLC) &&
-			   !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+				!(acc_flags & AMDGPU_REGS_NO_KIQ) && write) {
 			*rlcg_flag =3D AMDGPU_RLCG_GC_WRITE_LEGACY;
 			ret =3D true;
 		}
@@ -940,7 +940,7 @@ void amdgpu_sriov_wreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
=20
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true, &rl=
cg_flag)) {
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, true,=20
+&rlcg_flag)) {
 		amdgpu_virt_rlcg_reg_rw(adev, offset, value, rlcg_flag);
 		return;
 	}
@@ -957,7 +957,7 @@ u32 amdgpu_sriov_rreg(struct amdgpu_device *adev,
 	u32 rlcg_flag;
=20
 	if (!amdgpu_sriov_runtime(adev) &&
-	    amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false, &r=
lcg_flag))
+		amdgpu_virt_get_rlcg_reg_access_flag(adev, acc_flags, hwip, false,=20
+&rlcg_flag))
 		return amdgpu_virt_rlcg_reg_rw(adev, offset, 0, rlcg_flag);
=20
 	if (acc_flags & AMDGPU_REGS_NO_KIQ)
--
2.17.1
