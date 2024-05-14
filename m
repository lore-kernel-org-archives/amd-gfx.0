Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296E5C25B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 10:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 979C910E08A;
	Tue, 14 May 2024 10:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zR+XZeI2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BC3510E08A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 10:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glJgsabGZhjzNgwMCOF9mm2lvmiW5+F0rcTspaFKHSqqAY9A4rCowuPhDvF9Ds1Gl5X8VD1eLgptjPAmv9XHUPI2tucpdc5rTHutXpPMztFPhgozqkT3R0uKAFrNPmjSd9Zf16fTirrwS2svKm9spDX5r4S98yfiKFnVBwjE4sVG4rbabLrrBW9bmkfuoD4wX5TIDxmHGo1VZMjsKHHJmHpbECRFYmig6c0y7lHwZ/lzhSNDezXztsdL+8mJy07QdFq2po1RpOy62vpwfims78xfnzBNrm+0D1c52Wad4QvpAQIaHiMWTRmr7JEWBrTp4y6z1UhyrpyMqteOgWpnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WG9HUkKyW+5+VVSSMZuL3Y+olrMtKJnL4bs+oGpXkM=;
 b=hQqluWRkRLEqammVIUSCFyZvbricr6K9LsWa6D/YNVKKuP4ig+bacgYITdbF8wtF11AC2UL6V9U7xvxXm+eGwbVlIoBJf0MRk0Vz97TvDDNT07RaA0QKO19V/KKIIHKHZOcheP0aAy1fffP06kOPzef6cZFZYlNCRqFMF1DXQHvi/ktGrUlPdPA2a+wacsPLt+zkp2MyEzMQy5gjEUhqFh89PqaVrojpNd7vMKvOismMgQyy1COKs1m7UIvb674E+oGUfnv5RWdTf9W/tJ7X9McvR9v8Oktd2t7O4RixYrGrXS18uR80ZQgQEKnybObgzeqp6XoGVPBPl7oOwSu/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WG9HUkKyW+5+VVSSMZuL3Y+olrMtKJnL4bs+oGpXkM=;
 b=zR+XZeI2WqiE26XzVnaM1BY8uE6K33VUL2VLrnsPG7lrR+m98FNFZplAaQowJDPU2XowHnriO/wiGrMDu6XObybYZY1snqAOO3zu8DrJ7VfsQL3N5/sBO6KnIhKyOUkfIUjYO3PMkk5eh58Xk8JczsTJv5oeMu5FTV7bNYFgwlg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 10:08:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 10:08:06 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Ma, Le"
 <Le.Ma@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Use NPS ranges from discovery table
Thread-Topic: [PATCH 3/3] drm/amdgpu: Use NPS ranges from discovery table
Thread-Index: AQHapdnc88akLU4xp0CBD92ffCsr1rGWgW+A
Date: Tue, 14 May 2024 10:08:06 +0000
Message-ID: <BN9PR12MB52579B1ADE566FFC3E0D0E2FFCE32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240514083626.378626-1-lijo.lazar@amd.com>
 <20240514083626.378626-3-lijo.lazar@amd.com>
In-Reply-To: <20240514083626.378626-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=517ee3c5-f4e6-430a-affd-66ac0e731bcc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T10:07:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB7786:EE_
x-ms-office365-filtering-correlation-id: 0e3d2361-e5a9-472c-c254-08dc73fdc042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?zkqim1GtuVAv2FAdvSM9qLbJff96m6LkRtzmcZMFnU+j5B56HN2Q56TuDOyO?=
 =?us-ascii?Q?Kp6TL+qaHNn5DSnsS3SQgqFhbMGAT5D/Qkol38bz7sYnfqOp+6depiEEyNos?=
 =?us-ascii?Q?OeUXRgnyA/8Hy2WPZiWf1li6aEAzKH5Rf5v922eOjfVKjjDCZ1z6n+m1Dxod?=
 =?us-ascii?Q?5HOvpHvYr9kZEFd/YRkk+KMN2xzrehOhby77sIBzr3uMJDwge7seYHyobJik?=
 =?us-ascii?Q?r03iD5HG2NB9cSAynfZYESsne2b2iq6Kx3w8OO+xiAkj23rC2iXcQwcGJaBP?=
 =?us-ascii?Q?wy86o9g8patASkHu+kUQgtJYLbEi3UOMa7hTJgKNx0LtB2G46kw7CCSBkAy8?=
 =?us-ascii?Q?kOMGyPyvVE242LnP8CoD0QncHEHg/88l0ieFGOoa7b2Ps1t087b3siFggPHs?=
 =?us-ascii?Q?dQZcze4Qp7QHt1X5IRnRoJxo2YvRf5K62rSGUNVwrdzfTGeCaOL4IS6BB6sY?=
 =?us-ascii?Q?pP/l9InMg17fWVJ5cztJvdYv1bfK/K3Kr6sK4bFT0kpqGJfpe843ZJYhM+An?=
 =?us-ascii?Q?pYOxQbZEt5KVckhRlrFzlpT+Io+mY71AzxERSRN5NXs0Sd4rZP0ZW1g70rJh?=
 =?us-ascii?Q?Gs3/1rvDV/EKal079W+FIx8b0rlBpfjliwhGuxDXR74825LjwNPZVgVZ/bAG?=
 =?us-ascii?Q?yvbfO+QLvDrn+utUmpxEZOEG8WRPQu6RHIzGZxVYMoZWgbZHZ2XIZDLkHIyi?=
 =?us-ascii?Q?2DWq29u/D6mFPSTQOB0HKnabD2s2Zzmt1lnQaDd6agMWLzZAU+Vd53wsS9Zu?=
 =?us-ascii?Q?Z1N1XfDIIxsZvvuDSl+HHfsld2XQrAZiwoQYBPnOrFSzmqbzVGZr7H/Wfutt?=
 =?us-ascii?Q?e0L8yp20QB1R0HGaz6WZ6BGRztMydBxYHsngtYV4QPILrN+UFD5d4tkcnR3k?=
 =?us-ascii?Q?GHKnlkG5fCo5lR15E54j4TN/YXFAxffnrE544+UiU4VE8xUr8lC0C9HjEtko?=
 =?us-ascii?Q?dFdTa7N9ysEkINhSa/rhAu6iYEeR1xr3COprrS7MNRDJkZYDrsaAAwx7TjcA?=
 =?us-ascii?Q?dLdN3uQCcaZC/g38D/7nWiF80IDrsceDq9pFIEIffyj6GvM48vHVCG8lTN1y?=
 =?us-ascii?Q?ou7cqwfuI2nj56g5QcWjnL/cngZF7aRRRhXy1aZkdWzSO2zIRms1M58SmrzO?=
 =?us-ascii?Q?6DgqKtUS9FYlDJ0qgnSekU9s4L7tFCNJrwcd7+SsjW5y+VjFJxtfMWWgUuc/?=
 =?us-ascii?Q?rBk4vx4W5dVEP4ecSCZzsMOLWyJu0CTJ2jsgxJ2JUSx02ZezO7tMB+W8Zle4?=
 =?us-ascii?Q?NP1dLqLrW/E4n0jSY3gZPkCOJrUxm9j/jMHGmmIlAeqzgmGT4RKKN39/HMUk?=
 =?us-ascii?Q?j9XhFJ3AURbLpZ/W7PqGuTrG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ElLDUkEBPSwkwkfdn+pse7JwBAPFfNmrsSfAwnLDr4tj8aoWXspME6n+DcIK?=
 =?us-ascii?Q?9ggvlqAKexiLvu+DBN5x40M5MHY9y7/Z4Ty/4lzRmKM8FwJBAB/5tKfHGL9V?=
 =?us-ascii?Q?qM/J+TXh2sKMUmQY/ngjHB/hBZID9m4qIl5HbFMcLjS4v4bEnuri1Bg5Ze/X?=
 =?us-ascii?Q?Cm4Q4yeOJPeDZqFavqIzkVA9OtT0Xt5tf0UmtboMGq3IK9Jnlur22S/ut4AP?=
 =?us-ascii?Q?uhIbGSKII2cQ98My8w5pgdB7JtpwKQdyZwvbXG6jDDqH4dCSO3DQQih4WvNE?=
 =?us-ascii?Q?vf73oa9NuyOhBOliDAvG7Uv6QCMVJ4N0AMamXBb/BpX1jtMM/PQZNIoJjBKK?=
 =?us-ascii?Q?KAaf16DzwfROf5duBqRRrLgcDDhk1ZUT3ccQw79YO3X4mHfr7v65KbHfi8bE?=
 =?us-ascii?Q?7htDRw/HWYh5dD7pB27SX7ePz/3Bww7qW3Ydjzarrw9+c7awwtEY2N2iEvaV?=
 =?us-ascii?Q?3RARl+/Z4sPaK7NA3cZjK1I+Olp1Jh3o2Uyr3V7awlbGzW629So3AJJSKgiX?=
 =?us-ascii?Q?ShOaq1PLi9e/06gVGFhlwH8X99dibB4oI1Ya+Ahy1oips+0cEYGxoev5ewFs?=
 =?us-ascii?Q?rS6/RrVYCk7AEuNe8wYx4eQD4MMJz0RUcSfzOQLqrJqffBjz0ArgtIN/ItTS?=
 =?us-ascii?Q?iQo46lPGzOSmWqxHnuhF3Kn1yORX1MODEr0+NGRn9DmYFBM/ep9P33OH7Q+C?=
 =?us-ascii?Q?Dwns+1St3YlEF+y/YRe93QsIVziEVbkJ8+t9Tu6ykgo/mOXsUhtE4jOzhKAW?=
 =?us-ascii?Q?KJL4QEfqyOPTyApREUME4Qbid1k1GJZotSr7jtOTT1eEjZEFJT5Hnb1A0l9J?=
 =?us-ascii?Q?z5y6q9kWESq3Hsj7pwoq0JwDApjEJoP2vcPiB3O5BJ9/Wap1qNKV64EsYbHT?=
 =?us-ascii?Q?mjzQ7VXvYRqu+bwvZWj9+tIbCK9ddjMXrwkCVa656AiyHsPyTOKOIQegvgT5?=
 =?us-ascii?Q?Uyqji3jep3GaJ4JSKKK228TcE9xKo0Pfo+Tn/Q4a/PTi895ReCWfZjqnkINB?=
 =?us-ascii?Q?aqj0bfQ6FFf8LjJd3y+inYn4hSm3SiKQwQZhmEAeCU9YdnLsIVFZOSsvP0sH?=
 =?us-ascii?Q?6ZH0WHe4TxAZv4C8utVvJQF51qgc1j+HPkcXXs/FCqYvmGXDI/ykNpDREKyA?=
 =?us-ascii?Q?uk91ELtxkPrzYWRF3gnovB+I+4UxgzxwOi63Wb5aTMVTqjk+i0q7jtXxPIP2?=
 =?us-ascii?Q?zYXnDoePki0MhVNyxn37EUDcvGDRedIaFjRYjnuKYRpqoSwxGqM/T0ISl3Fg?=
 =?us-ascii?Q?BMB/Tce3e6YwhM9ZpSiGUjUrdRl5duyY0ugXDSU+6a61KV1nopwU1lc0GlyF?=
 =?us-ascii?Q?TOjOEPXR9xcqKMtYsCyKFzKQRTMkNfn6PpOJywHlro3j2twcpH1TX2Qbfa6p?=
 =?us-ascii?Q?e1kmDK1IG5ab1t8mtbIk6Q4KZ/2qxLa2O7uDdUcPyguUGS9Tb8BvtqE3hrYH?=
 =?us-ascii?Q?GbvTNCwY1mWRnVo/5lmO8MRaFjJaoJISRPE6p0dm5GE6zPWi9MNyjDwr3hhQ?=
 =?us-ascii?Q?cEBFWDFghGO2AUDYPswTJZ8pEK41/fCehS65kgCgdh5B8zFAJBvxrxzT+vyH?=
 =?us-ascii?Q?RsDZuQFbM8Y7eCcusR53cq1o/h6gTyt7JbItVteT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3d2361-e5a9-472c-c254-08dc73fdc042
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 10:08:06.8871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rsvDpe1zB+leMx2ALPwauDGdQYRsPhT8Z8lEyHlEE56edHiHVbbjfVRKJYoNx2mLZvdu/U4lOcVsOPvqGt8D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786
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
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 14, 2024 16:36
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Ma, Le <Le.M=
a@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Use NPS ranges from discovery table

Add GMC API to fetch NPS range information from discovery table. Use NPS ra=
nge information in GMC 9.4.3 SOCs when available, otherwise fallback to sof=
tware method.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 92 +++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 76 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       | 11 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 40 +++++---
 5 files changed, 212 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 43528ff50e72..afe8d12667f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -367,6 +367,35 @@ static void amdgpu_discovery_harvest_config_quirk(stru=
ct amdgpu_device *adev)
        }
 }

+static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
+                                          struct binary_header *bhdr)
+{
+       struct table_info *info;
+       uint16_t checksum;
+       uint16_t offset;
+
+       info =3D &bhdr->table_list[NPS_INFO];
+       offset =3D le16_to_cpu(info->offset);
+       checksum =3D le16_to_cpu(info->checksum);
+
+       struct nps_info_header *nhdr =3D
+               (struct nps_info_header *)(adev->mman.discovery_bin + offse=
t);
+
+       if (le32_to_cpu(nhdr->table_id) !=3D NPS_INFO_TABLE_ID) {
+               dev_dbg(adev->dev, "invalid ip discovery nps info table id\=
n");
+               return -EINVAL;
+       }
+
+       if (!amdgpu_discovery_verify_checksum(adev->mman.discovery_bin + of=
fset,
+                                             le32_to_cpu(nhdr->size_bytes)=
,
+                                             checksum)) {
+               dev_dbg(adev->dev, "invalid nps info data table checksum\n"=
);
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
 static int amdgpu_discovery_init(struct amdgpu_device *adev)  {
        struct table_info *info;
@@ -1681,6 +1710,69 @@ static int amdgpu_discovery_get_vcn_info(struct amdg=
pu_device *adev)
        return 0;
 }

+union nps_info {
+       struct nps_info_v1_0 v1;
+};
+
+int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
+                                 uint32_t *nps_type,
+                                 struct amdgpu_gmc_memrange **ranges,
+                                 int *range_cnt)
+{
+       struct amdgpu_gmc_memrange *mem_ranges;
+       struct binary_header *bhdr;
+       union nps_info *nps_info;
+       u16 offset;
+       int i;
+
+       if (!nps_type || !range_cnt || !ranges)
+               return -EINVAL;
+
+       if (!adev->mman.discovery_bin) {
+               dev_err(adev->dev,
+                       "fetch mem range failed, ip discovery uninitialized=
\n");
+               return -EINVAL;
+       }
+
+       bhdr =3D (struct binary_header *)adev->mman.discovery_bin;
+       offset =3D le16_to_cpu(bhdr->table_list[NPS_INFO].offset);
+
+       if (!offset)
+               return -ENOENT;
+
+       /* If verification fails, return as if NPS table doesn't exist */
+       if (amdgpu_discovery_verify_npsinfo(adev, bhdr))
+               return -ENOENT;
+
+       nps_info =3D (union nps_info *)(adev->mman.discovery_bin + offset);
+
+       switch (le16_to_cpu(nps_info->v1.header.version_major)) {
+       case 1:
+               *nps_type =3D nps_info->v1.nps_type;
+               *range_cnt =3D nps_info->v1.count;
+               mem_ranges =3D kvzalloc(
+                       *range_cnt * sizeof(struct amdgpu_gmc_memrange),
+                       GFP_KERNEL);
+               for (i =3D 0; i < *range_cnt; i++) {
+                       mem_ranges[i].base_address =3D
+                               nps_info->v1.instance_info[i].base_address;
+                       mem_ranges[i].limit_address =3D
+                               nps_info->v1.instance_info[i].limit_address=
;
+                       mem_ranges[i].nid_mask =3D -1;
+                       mem_ranges[i].flags =3D 0;
+               }
+               *ranges =3D mem_ranges;
+               break;
+       default:
+               dev_err(adev->dev, "Unhandled NPS info table %d.%d\n",
+                       le16_to_cpu(nps_info->v1.header.version_major),
+                       le16_to_cpu(nps_info->v1.header.version_minor));
+               return -EINVAL;
+       }
+
+       return 0;
+}
+
 static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *ade=
v)  {
        /* what IP to use for this? */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.h
index 4d03cd5b3410..f5d36525ec3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -30,4 +30,9 @@
 void amdgpu_discovery_fini(struct amdgpu_device *adev);  int amdgpu_discov=
ery_set_ip_blocks(struct amdgpu_device *adev);

+int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
+                                 uint32_t *nps_type,
+                                 struct amdgpu_gmc_memrange **ranges,
+                                 int *range_cnt);
+
 #endif /* __AMDGPU_DISCOVERY__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index f8ed886ffca3..78cd31e929c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1165,3 +1165,79 @@ void amdgpu_gmc_sysfs_fini(struct amdgpu_device *ade=
v)  {
        device_remove_file(adev->dev, &dev_attr_current_memory_partition);
 }
+
+int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
+                                struct amdgpu_mem_partition_info *mem_rang=
es,
+                                int exp_ranges)
+{
+       struct amdgpu_gmc_memrange *ranges;
+       int range_cnt, ret, i, j;
+       uint32_t nps_type;
+
+       if (!mem_ranges)
+               return -EINVAL;
+
+       ret =3D amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
+                                           &range_cnt);
+
+       if (ret)
+               return ret;
+
+       /* TODO: For now, expect ranges and partition count to be the same.
+        * Adjust if there are holes expected in any NPS domain.
+        */
+       if (range_cnt !=3D exp_ranges) {
+               dev_warn(
+                       adev->dev,
+                       "NPS config mismatch - expected ranges: %d discover=
y - nps mode: %d, nps ranges: %d",
+                       exp_ranges, nps_type, range_cnt);
+               ret =3D -EINVAL;
+               goto err;
+       }
+
+       for (i =3D 0; i < exp_ranges; ++i) {
+               if (ranges[i].base_address >=3D ranges[i].limit_address) {
+                       dev_warn(
+                               adev->dev,
+                               "Invalid NPS range - nps mode: %d, range[%d=
]: base: %llx limit: %llx",
+                               nps_type, i, ranges[i].base_address,
+                               ranges[i].limit_address);
+                       ret =3D -EINVAL;
+                       goto err;
+               }
+
+               /* Check for overlaps, not expecting any now */
+               for (j =3D i - 1; j >=3D 0; j--) {
+                       if (max(ranges[j].base_address,
+                               ranges[i].base_address) <=3D
+                           min(ranges[j].limit_address,
+                               ranges[i].limit_address)) {
+                               dev_warn(
+                                       adev->dev,
+                                       "overlapping ranges detected [ %llx=
 - %llx ] | [%llx - %llx]",
+                                       ranges[j].base_address,
+                                       ranges[j].limit_address,
+                                       ranges[i].base_address,
+                                       ranges[i].limit_address);
+                               ret =3D -EINVAL;
+                               goto err;
+                       }
+               }
+
+               mem_ranges[i].range.fpfn =3D
+                       (ranges[i].base_address -
+                        adev->vm_manager.vram_base_offset) >>
+                       AMDGPU_GPU_PAGE_SHIFT;
+               mem_ranges[i].range.lpfn =3D
+                       (ranges[i].limit_address -
+                        adev->vm_manager.vram_base_offset) >>
+                       AMDGPU_GPU_PAGE_SHIFT;
+               mem_ranges[i].size =3D
+                       ranges[i].limit_address - ranges[i].base_address + =
1;
+       }
+
+err:
+       kfree(ranges);
+
+       return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index 17f40ea1104b..febca3130497 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -199,6 +199,13 @@ struct amdgpu_mem_partition_info {

 #define INVALID_PFN    -1

+struct amdgpu_gmc_memrange {
+       uint64_t base_address;
+       uint64_t limit_address;
+       uint32_t flags;
+       int nid_mask;
+};
+
 enum amdgpu_gart_placement {
        AMDGPU_GART_PLACEMENT_BEST_FIT =3D 0,
        AMDGPU_GART_PLACEMENT_HIGH,
@@ -439,4 +446,8 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev=
);  int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev);  void amdgpu_gmc=
_sysfs_fini(struct amdgpu_device *adev);

+int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
+                                struct amdgpu_mem_partition_info *mem_rang=
es,
+                                int exp_ranges);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 7c4e2adae7b3..094c08cb98e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1895,7 +1895,7 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *ade=
v,  {
        enum amdgpu_memory_partition mode;
        u32 start_addr =3D 0, size;
-       int i;
+       int i, r, l;

        mode =3D gmc_v9_0_query_memory_partition(adev);

@@ -1918,23 +1918,39 @@ gmc_v9_0_init_sw_mem_ranges(struct amdgpu_device *a=
dev,
                break;
        }

-       size =3D (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_PAGE_SHI=
FT;
-       size /=3D adev->gmc.num_mem_partitions;
+       /* Use NPS range info, if populated */
+       r =3D amdgpu_gmc_get_nps_memranges(adev, mem_ranges,
+                                        adev->gmc.num_mem_partitions);
+       if (!r) {
+               l =3D 0;
+               for (i =3D 1; i < adev->gmc.num_mem_partitions; ++i) {
+                       if (mem_ranges[i].range.lpfn >
+                           mem_ranges[i - 1].range.lpfn)
+                               l =3D i;
+               }
+
+       } else {
+               /* Fallback to sw based calculation */
+               size =3D (adev->gmc.real_vram_size + SZ_16M) >> AMDGPU_GPU_=
PAGE_SHIFT;
+               size /=3D adev->gmc.num_mem_partitions;
+
+               for (i =3D 0; i < adev->gmc.num_mem_partitions; ++i) {
+                       mem_ranges[i].range.fpfn =3D start_addr;
+                       mem_ranges[i].size =3D
+                               ((u64)size << AMDGPU_GPU_PAGE_SHIFT);
+                       mem_ranges[i].range.lpfn =3D start_addr + size - 1;
+                       start_addr +=3D size;
+               }

-       for (i =3D 0; i < adev->gmc.num_mem_partitions; ++i) {
-               mem_ranges[i].range.fpfn =3D start_addr;
-               mem_ranges[i].size =3D ((u64)size << AMDGPU_GPU_PAGE_SHIFT)=
;
-               mem_ranges[i].range.lpfn =3D start_addr + size - 1;
-               start_addr +=3D size;
+               l =3D adev->gmc.num_mem_partitions - 1;
        }

        /* Adjust the last one */
-       mem_ranges[adev->gmc.num_mem_partitions - 1].range.lpfn =3D
+       mem_ranges[l].range.lpfn =3D
                (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT) - 1;
-       mem_ranges[adev->gmc.num_mem_partitions - 1].size =3D
+       mem_ranges[l].size =3D
                adev->gmc.real_vram_size -
-               ((u64)mem_ranges[adev->gmc.num_mem_partitions - 1].range.fp=
fn
-                << AMDGPU_GPU_PAGE_SHIFT);
+               ((u64)mem_ranges[l].range.fpfn << AMDGPU_GPU_PAGE_SHIFT);
 }

 static int gmc_v9_0_init_mem_ranges(struct amdgpu_device *adev)
--
2.25.1

