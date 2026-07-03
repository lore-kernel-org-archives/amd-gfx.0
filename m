Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31372C43602
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 13:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A636910E5FA;
	Fri,  3 Jul 2026 13:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iTZTyT7k";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B6310E5FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 13:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ro1jILpcsEP1B4e6ip2ZtOTFP5yzc2bXEvDvP26ZKAvPlxysC2xRCjIqPip3oIv5C/uat4NSbtIlJsY0N6jtvxiCiCa/fHjm7F0/u+qdf7md3nSmQ7soOnYPdjtjmr7i2fzgOmpduO5VWEUswuAqjCoEDQn9d0lZ2UlL63tI/UtzzJDYgGlOHKwV5pFxSXoVf/JiD5MdB/NQseF70b7JPRF9i9pbFLWPQQkwU75i2mUokBLxWSfBTTm7TX1vnYObzn1wVVgXno3bjpF9RkByUwlaenPk3Rs8ewaoThuTAEYo1M+vrqIwueahunwKHJeUDMlvtIRcNci1DwXzIG7M6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2ndKGpkmB0pcdgsDrqvPbzf0f8MO5EJ8z5+YzqA72k=;
 b=pi7Df0+zXDRj1jKafliU+qsW8ZsEF1MEppbu9NsH6UMKRZQJzcGvoYGc4qgqG2n6pMXjgnrk9YUSLgx6knWCEEjeQTUVIoHWqkTnA7Q7wXvb38ps4dMCJFWd6OcPkktA9jXHUgpWJM88jRSFIx0S3Wz6gU4OXyf2BApCFGFK3O7uR+VfxBjUd6lAKQL3FV+X1wxpDCOYr66KRnGDrNEf6xcEiyD6c3cYUCn3ZqMZCAZtdtfJxJT9pKQgqhDgXhCHNpUErsDXn+BH/Ik9OfspDe/6uKEbi+b61KX6xOvuapyjIguWOK3GNSK7jSwxXakEsA/wR0fsf0BF1RLG7OadIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2ndKGpkmB0pcdgsDrqvPbzf0f8MO5EJ8z5+YzqA72k=;
 b=iTZTyT7krfyrSgleU+DDEtUDBcL1TEXzGXwAH1E2DFdpiquULIyRDehOWaqW0vk0yZsGAgb5JfZLDt7p/5+C22njxPDYSxSPW7kIAEKy7U1fkg+hU32JakonAq1jD2qxz4FC6TmbnqVNvOHodhiEy+BIOPnn/67uBGfLDjoQG6g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 13:56:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:56:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Topic: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Index: AQHdCg44zj3JYJb6g0Cg58TryNnJcbZb0m2Q
Date: Fri, 3 Jul 2026 13:56:48 +0000
Message-ID: <BN9PR12MB52571AD6187A07E48068BBB0FCF42@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260702103201.299749-1-Stanley.Yang@amd.com>
In-Reply-To: <20260702103201.299749-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-03T13:53:04.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ1PR12MB6291:EE_
x-ms-office365-filtering-correlation-id: 3a78e0a6-d78f-4ac5-f042-08ded90aed49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003|38070700021;
x-microsoft-antispam-message-info: WFka1us+JLC4/lR8Is8FQ6IZ4/9BmwrHhkUhVKDBrT89CxW/XnbRrO1JjtSDOzWkY5UXtNf0P6zorfZhDeeO5ZKNVOPUGGxVeJjEqPKslB038+vCohQwmZwejjzbHVEXW0PNsczOImNzgx5dkeqwDqXAYiS1IIISxdHmDUkMBLtLJ3N5ET1vIo5461xu/d2GtS07TcReEBgieU3PSuFSdKDQlfPvgCUplxv9QvfVmRwW8rUm9cvtgTtvq1tmVLjUuW0y/TjFjZsACNUvfMfhIAE34+KzbQe7jrIH09sSfL/jk9uOVBvUrao/Jwdf71Lyixga1kxAV5PSFf4fv4gKFThTJQjVB4xNNg1odt2Tb5QPHGgTZKr0KnYMhRXyhFSAIYsc+u+oCxptpfXJClwHKy1QWprgRB/+rrHSYe0OsLYcx1BGwRJsHN9CYpQkmTA4wjnARX1OShfDOj9b3YtYXzkxiakWnXLzKh+YnlDiQ83vaX+aMJre/IV/kWKJr8MH0iiHIBfeD/lg9w80qxFk2uYWCHp8waYhWD1IuTf/ZSG616mXGU5uKRA7vslhNwV0J4JuSIMK1HooTabRtl+aJX5H//mN8lJCtn8FsTWe0f6j+uC5ZKGdh6g8SSK7Ennc8qds02ttyUiX8x8kCrMn6FqG/K9RRSgSkWMv3zu8JMj4+ztghTCzMnjljvNSfArwhEfKHogec849pt3bb6/PwsO9vRNtrLttSiBZxWIVboc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GWBVv8j9IfMdcS6qsjsjlG0eGON1xzKJvsLlFCrL+jvw0zyE/JmiX1S3Wn1e?=
 =?us-ascii?Q?D/qrhum6NTn70yb4Kw+QMsKJZTN+ULqxkNgUOFt08UGBFJrtmbcmLf4OBuyl?=
 =?us-ascii?Q?EGANDtyFh/yQ6zYR+uB38pbt4RuWNlS98ORZVcO0ljQKwcZX5qWh/ARjGs2y?=
 =?us-ascii?Q?JR+SVtWWtFWsoXpNIxMhx2cgsPWdOZPPbO9nagnxAdZs/l3JfmvJWB/oqdfq?=
 =?us-ascii?Q?Pwwp6B9IOCJB38MJJNC1JiKeaO0SPHpLUpT7q9j9HMSRlzMqhRlYOG2wYgN8?=
 =?us-ascii?Q?WVb38XSF+ejPhdvdLllk+0vcJUh4ZyALIttWuzHklCm11MuG8d1fRc5bEUJJ?=
 =?us-ascii?Q?FMfOYCfcD5iCUNb2LmeFUvuhEFa2+IAxF2yZqGtYmWFk4botdECcMpEClNXT?=
 =?us-ascii?Q?apJY0t+WCkFAxULdi6oTSEiPxGaX2RsppD98JWazNaGj6ey8hEZO0vdnDbGk?=
 =?us-ascii?Q?G2wgVGMMsVfVs1nQUeCYauzqUFCCn/x5076fjdd5+ILVKlvkxs5Z5qP9RMFp?=
 =?us-ascii?Q?Gpl7wjPVtQ27JXh921AkA51KbKvOdBwZXx44R7qDCnLR0NTg23YDBhBECuoQ?=
 =?us-ascii?Q?wHhfjYNXiLCQxvWbJet+VbQXA5T2ZjISqZagt8k+RZpVrlgxyOM3Xan/klCc?=
 =?us-ascii?Q?Mw7D7DkYPJYESYniM7GinBwWf0qfsrRfbraLt5+blAySB6bPRdIIsVbtXFQi?=
 =?us-ascii?Q?PVtGle1kuU7EszVGxhYJnEVnQLOQkHmHKocyLGL6D6dOiNcjNdlEYDAssJD3?=
 =?us-ascii?Q?mlFNO5oTpF+cSjqofoGoMboFAL75nxUk/VnwxY2zWvy+jG6i4pFMlSbiQbym?=
 =?us-ascii?Q?gBI3VWLXrzMRCfQhHjDmQCjMP+gGbH0FfBLMYLSKRUFZtFVu4faT1VnLqOcd?=
 =?us-ascii?Q?tUPMEHFDlHZ+8keMfYe74bPyxFOiWC2OSdIRsKIB8XnqlTiK4xqWMthiR3U6?=
 =?us-ascii?Q?4KxMM4aP/M9JcB6KQT4GjtSde7da5V9d2PH6/2o8m3zKpZC4gbdfsFh0plV7?=
 =?us-ascii?Q?JOK6VP2gE1GOnFRXRRiR8EYrfzn5YxaqmdrarEvGHiEBUK6YC3sjIWvKBdEl?=
 =?us-ascii?Q?MpVrZ7VFKkjpKhgkrVv8htDRw89M7UiTNab5lFVqbucIjHrZfgybmYjzU3GB?=
 =?us-ascii?Q?u9oFjrG8Qmk2yN66OwskJuAMVPPq6cjdiKWh6EwF+1/2doyloPW3jesOclyK?=
 =?us-ascii?Q?PZbQX1L8ZV/xOh+CBFSo2HRASxkvN57S4nSevmSTySNvKW0NVvo1Q2FuktHC?=
 =?us-ascii?Q?TmoMtrrWWiIG3RT8R+d8n74ZD0QePOYeQh442IdhSSmJQf3PJIj2N28tSFWF?=
 =?us-ascii?Q?QNpu/FD9ZIYcrR/g6NZU+dADzL/lLmLER2OsBnLWU0KNOmVe/H4JDuA1tMMw?=
 =?us-ascii?Q?5PAfU1s0AaOq3wBfoTtYyxYmlTe9/5MRhfiyQvPfHh/hQVAUAfPAUMjS3F8v?=
 =?us-ascii?Q?fUPQsTYpYPgRQOK5sdnVlkuSbCqdKdG9Thy4+f8qmkHoBKg/elUNMuLFnLAQ?=
 =?us-ascii?Q?eKO9flK5fc4VQguqo2h/u8st2f9g+k5CGFgJ/9LhlOyiAQ6K3I2yEojiezjO?=
 =?us-ascii?Q?Iph4HQNlC8mqPvOXTiBY7kCvvD2FaSmhmvKm8GuWbzyr5Tl1F4oidi5FUd4k?=
 =?us-ascii?Q?MnNKvAhM3DdX5KLs8+G6TtlK6nYoPBZ4zDmR9J0daLb+i8f34cEI6uv9xGC2?=
 =?us-ascii?Q?1khbvtqMJfoWZe4bLz87659tEtte+ivejL7KISWbQDPMpf9F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a78e0a6-d78f-4ac5-f042-08ded90aed49
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:56:48.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aZDjejRziwbY7U+8fy927Ys+Q/8LJWkgriPNJ9W0rIBlqZcVQZUpeujX8ssq7+7ctXBUdl0dfNKyfxvDGVXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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

Thinking about it more, would it be better to add error-checking logic in t=
he debugfs parser?

When the address parameter is set, we should also check the sub_block param=
eter to ensure the injection method is applied correctly to the intended su=
b-blocks. Otherwise, we should reject the debugfs ctrl command.

Any thoughts?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, July 2, 2026 6:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V2 1/1] drm/amdgpu/ras: only check bad page for address-bas=
ed UMC injection

UMC error injection on MI300 series is dispatched by the RAS TA via the (su=
b-block, method) pair; only the "coherent" methods are address based, the s=
ingle-shot/persistent/ac-parity ones ignore the address.

The debugfs control path validated the injection address against the bad pa=
ge list for every UMC injection. Restrict that check to address-based injec=
tions and warn when a non address-based one is given a non-zero address. Ot=
her ASICs keep injecting by address.

Changed from V1:
        move address based checking to uniras layer

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 +++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 58 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index af48dd2ebd16..f280a312b0a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -606,8 +606,14 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
                ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
                break;
        case 2:
-               /* umc ce/ue error injection for a bad page is not allowed =
*/
-               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+               /*
+                * UMC ce/ue error injection for a bad page is not allowed.=
 For
+                * uniras (SMU v13+) devices the injection address is valid=
ated by
+                * the ras_mgr inject handler, so only run the legacy bad p=
age
+                * check for the legacy RAS path.
+                */
+               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC &&
+                   !amdgpu_uniras_enabled(adev))
                        ret =3D amdgpu_ras_check_bad_page(adev, data.inject=
.address);
                if (ret =3D=3D -EINVAL) {
                        dev_warn(adev->dev, "RAS WARN: input address 0x%llx=
 is invalid.", diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.=
c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index bfbfdffbfbe6..063c7b0a7b00 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -82,6 +82,57 @@ static uint64_t local_addr_to_xgmi_global_addr(struct ra=
s_core_context *ras_core
        return (addr + xgmi->physical_node_id * xgmi->node_segment_size);  =
}

+/*
+ * UMC error injection is dispatched by the RAS TA using the
+(sub-block, method)
+ * pair carried in struct ras_cmd_inject_error_req as subblock_id (enum
+ * error_sub_block_umc) and method (enum inject_method_umc). Only the "coh=
erent"
+ * methods program an explicit injection address and are therefore
+address-based;
+ * the single-shot, persistent and ac-parity methods ignore the address.
+ *
+ * Keep the values below in sync with the RAS TA.
+ */
+enum umc_error_sub_block {
+       UMC_ERROR_CRC                   =3D 0,
+       UMC_ERROR_SRAM                  =3D 1,
+       UMC_ERROR_ODECC                 =3D 2,
+       UMC_ERROR_PARITY_DATA           =3D 3,
+       UMC_ERROR_PARITY_CMD            =3D 4,
+};
+
+enum umc_inject_method {
+       UMC_METH_COHERENT               =3D 0,
+       UMC_METH_SINGLE_SHOT            =3D 1,
+       UMC_METH_PERSISTENT             =3D 2,
+       UMC_METH_PERSISTENT_DISABLE     =3D 3,
+       UMC_METH_COHERENT_NO_DETECTION  =3D 4,
+       UMC_METH_COHERENT_WR            =3D 5,
+       UMC_METH_SINGLE_SHOT_WR         =3D 6,
+       UMC_METH_PERSISTENT_WR          =3D 7,
+       UMC_METH_SINGLE_SHOT_CLEAN      =3D 8,
+};
+
+/*
+ * Return true if a UMC error injection using @sub_block and @method is
+ * address-based, i.e. it programs an explicit injection address that
+must be
+ * validated. The non address-based methods ignore the address.
+ */
+static bool amdgpu_ras_umc_inject_is_address_based(u32 sub_block, u64
+method) {
+       switch (sub_block) {
+       case UMC_ERROR_CRC:
+               return method =3D=3D UMC_METH_COHERENT ||
+                      method =3D=3D UMC_METH_COHERENT_NO_DETECTION ||
+                      method =3D=3D UMC_METH_COHERENT_WR;
+       case UMC_ERROR_ODECC:
+               return method =3D=3D UMC_METH_COHERENT;
+       case UMC_ERROR_PARITY_DATA:
+               return method =3D=3D UMC_METH_COHERENT ||
+                      method =3D=3D UMC_METH_COHERENT_WR;
+       default:
+               return false;
+       }
+}
+
 static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
                        struct ras_cmd_ctx *cmd, void *data)  { @@ -90,7 +1=
41,8 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_cor=
e,
                (struct ras_cmd_inject_error_req *)cmd->input_buff_raw;
        int ret =3D RAS_CMD__ERROR_GENERIC;

-       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC) {
+       if (req->block_id =3D=3D RAS_BLOCK_ID__UMC &&
+               amdgpu_ras_umc_inject_is_address_based(req->subblock_id,
+req->method)) {
                if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) =
{
                        RAS_DEV_WARN(ras_core->dev,
                                "RAS WARN: inject: 0x%llx has already been =
marked as bad!\n", @@ -111,6 +163,10 @@ static int amdgpu_ras_inject_error(=
struct ras_core_context *ras_core,
                        req->block_id !=3D RAS_BLOCK_ID__GFX) {
                        req->address =3D local_addr_to_xgmi_global_addr(ras=
_core, req->address);
                }
+       } else if (req->block_id =3D=3D RAS_BLOCK_ID__UMC && req->address) =
{
+               RAS_DEV_WARN(adev,
+                       "RAS WARN: non address based injection, ignore the =
injection address 0x%llx\n",
+                       req->address);
        }

        amdgpu_ras_trigger_error_prepare(ras_core, req);
--
2.43.0

