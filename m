Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4CFCD1292
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Apr 2024 11:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83ACD10F0B3;
	Mon,  1 Apr 2024 11:15:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wevSbm7Q";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2129.outbound.protection.outlook.com [40.107.101.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DAA10F0B3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Apr 2024 11:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECrp8TlLQM71zbiqhsRHr4p2UZY5Bz11y414xpNkBgSyO1R8KgPV7+LYKLHPVgwyPL2fvrv5x+083dLrpaHJYWE1YAMtX55HdgZDhZUIc4xwR0wFLk7JpMLOfELYRp4RpS1E8td9uB3IMSBIazcgLB3s+OzidapJLPTE4pcTkLK/m2/Hee0gaq2OX0Mz7BJlIjh/YWWa//kYRmlytFJzmfH10VymwbGGe0z5Mq0cn0jzqwhGExeKQRMzUbdRwnzIqv2wbDMpHl3iJhrvETuOoFxrOHtSdDwXOZ8pVuonAqCI/LW/vgvqYDz2RYWaxTQ4efGfQlUQ/Bb8h994UXOOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFr8e/8cebiYagoYYE5TMABnv+jHTWCaIV4xUIq9mOU=;
 b=Ko5z45Tk1R4BODUB+3DIRUQkdeBlxkgSjU7ITa4x2Y3xhnGiSfauXiDerfqpl8S1QfdFh7bOYGEyZQo+KRKegI1syjqGQVzvUgomX2RS99HqixNSpgQMnb11PuEgLziM7AkYTLYyJFf82VTFkPNaxn2QKPIVT5paYF5duWFN+uSrxRVu8zj/Kbjmw2IILhbiknVLUA4jpoIWrG/HEyjwslXo2ckZVG+/t9Bq4bY4C22n1kQ1za+ZSE1b3rLtLBdvEjtbSYQrd9tvpFJUFWKSld1in9DIXiMKFsASEqRvZRn/XAzp4rag62d6kbT9aFUzfGmZ6uuXvkFxhC52kV/MNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFr8e/8cebiYagoYYE5TMABnv+jHTWCaIV4xUIq9mOU=;
 b=wevSbm7Qb43OsQzRtFfSfh2d9H9P9ScFQSuM1EMsvUA5jg5wf+jDtgFlRo/WiBhVXTs7noqhQ9IPUJ2COH4iEYaczxyls2CgbbPQgKu/P4YiZTQUUjM+J59cTwoEdsU9rmUYldygPUss3YHXBOTw78J4szXNR0lv6trwjW/BI/E=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 11:15:26 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::f839:3c75:f78a:ce1%6]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 11:15:26 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
Thread-Topic: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags
Thread-Index: AQHagLi4RGluN4eXW0CcC9yQNdJqF7FTSTqQ
Date: Mon, 1 Apr 2024 11:15:26 +0000
Message-ID: <DS7PR12MB6071B627E5616FA8C073302B8E3F2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240328023544.820248-1-lijo.lazar@amd.com>
 <20240328023544.820248-2-lijo.lazar@amd.com>
In-Reply-To: <20240328023544.820248-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8349fdbf-8e9f-4edc-ac65-a3741b107283;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-01T11:11:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY8PR12MB8241:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2spzcgpFnB64e9ehIEcvi+1zwDE4iZPs5LOsb5F5Ysiu0fQtfc9C/pXCU6BDE5TXUXaM9b9POE2HmnUBlsAlV3cVTYcNssxmrYmzMsy5EtmAWF4ZcfHvFB9uMi2sziHkUYwWpxhfEVkURl6e7GiN907VXJTGpHqgnc34j5M4tPPoYhZlcdwkp6F2RQmUUz+SfxAoXXRnnLCIGSqitq8zO4sRi0IorxxxzVqVgpZtVn10c9czMq/kdck9SiIzo3hvxFDJQEhUYeCqj8j1OFWN0BUg5lwiplnQaRUqPBZ42gWJd7Kzhyh441fnrStF4YS7r3rR6Wmd4AjvJgALt8olnNnr+EmtjNJoKRKVmG2sxX3Xb9wNk9gx3jNW5iGdRNNiyXOq86r6YFRu9LVMCDpWq9XCHo3J6npP/lngZnd4dkaWU8kYsEGHZjJdQPef7+zlo+F290WoE/ldTRJOUPKyapov3Akj5WGBJD9mPF7d8FhYlnVamQGVRZkrA7Zl84caJ4P2owpsL6YksHXGFNos95vwcCTeYV3Ait3lmejftlpoYtDwvwsvYuZORgW7L4uUh98kkeq0cLJNcY+xqK/gWTsBMJVV3Lucrw55Dz+9UGg7l/inxFjs5p0oo3qZjDRO9qeK4ngwAZIF0yVgiF/80NEa3sI+BhWuVudTbyWXsw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8sMUu4rMKHUl9WHSqxijryobAxfTxfuqG6dJLiJOuUkiIbLII8wVVjZcEpIU?=
 =?us-ascii?Q?G4WegnrRCnCHIF2jZZ6E+71rtxvXPUfPFE2qlRE/3VDm5b+2ref0BBt3VdX9?=
 =?us-ascii?Q?CTUPW9DzBgm/GAEuu3W9i15V8gZj3SEyBhAQJ1XHx66qUgw9uMzrtnXCDsjs?=
 =?us-ascii?Q?coJAIIKdgEr3hSpzpn9F/6dGB1DM9rjgRKIBMsmm3QxaVIO1d4LCCDtmZTjj?=
 =?us-ascii?Q?yo8BFZZkGjIAzB6jzYkaVfmfYscEgCnh3r/giKxzniGwrRTrWD9Gqdvf1hNL?=
 =?us-ascii?Q?Uksd/vVzKl8SACCTw71hSZ6OF8F7sl4KELSTFEVjl9ccY9ote8ZIw+XZTNbo?=
 =?us-ascii?Q?5ZZST4aKHpXTFBlqx5tqggJjYqLkkBlB7fts9aklHSGpPpNAEJSyGgrXE34V?=
 =?us-ascii?Q?Zn/+dQsmoojtoD7sO8+aSWKI2JzdYC5DeN+j72bVjmDqRCYy0/ZuXmmc/rud?=
 =?us-ascii?Q?Cj+bLC3Ppn+0bBYTXnY10RQDlXJTEes0HtBTvCHux/2owMA1I8lVZ1uzC2SL?=
 =?us-ascii?Q?3m4FZnMyqzkpghg7/Yylqc3J292PnQQOI2IUi4d184LvtmS5mtgFWsCQfA35?=
 =?us-ascii?Q?h3VYZmvjzp4BY2gW2mPziH8OiD60qAN4lMI1LsmF4jP/qTq5DH5rx8fIVXZQ?=
 =?us-ascii?Q?PbfYxsxpUEeSIMrizBGrTXoXd3O6QQfaMQNhcgNO6CSZ96MFUB1HzoF8JxHf?=
 =?us-ascii?Q?KSQP3bpAKNNBRIJNvtJ2AerU7Z3qvg+NpSluiLqrW2lB+58vQPh7nmH+vyUL?=
 =?us-ascii?Q?++OGDyZ/L8RQWB5+UYi09uvSCVouT3RgHj/Pt9i5zERzbIY9f+1bUy1AYcNR?=
 =?us-ascii?Q?AdTNfgRlLfDHGlF9jbhIxZULJLXDy8SWXy9RDtmxwVEZLJgWFf4D537gA1Uf?=
 =?us-ascii?Q?LO/4Y9LilKzfgWR987e8ie52jL0R7X2z2G/advPCeZqvu4iiEWqzgXJpF41d?=
 =?us-ascii?Q?w0TI6roMUGybvJzIuzfiKiV237Fu1zIGcp+xIET9fcAII9cujpJL6YLvZRga?=
 =?us-ascii?Q?9S1/7xSMd5BhQaOzy4O+jJglBHq7XyXhHxDwrBMH+dnKLDBlzu+JjeHFr+zU?=
 =?us-ascii?Q?P51/FpT7QzL6AG/+UyM5h/pwzwSQzsZee976+HtRqu04OQlCuK7xWjPpAhU5?=
 =?us-ascii?Q?dntaK8BlBGAl+ctVt4csvmljCt+jnddEKi+dyo0M8P9uJGcZ13DItUXs3DC1?=
 =?us-ascii?Q?J5La2T1be9+AfQzCqauUEoz1Jy7mO05lhp64ACYwykOie4Iyatq7ShaRwcWG?=
 =?us-ascii?Q?j76wSY4pLNXz0E8N/qzkS0h/4lhx8VIaiJKa+7dXKIVqAMy6H8bfrUN8cxuR?=
 =?us-ascii?Q?d34nEBr7gxQN/NLhrXWmsivRpMA4CXIuEkaFhFvgSdU00larESBj3wwSczDy?=
 =?us-ascii?Q?ru1ehai1fH9jOAvezJuZZCIlhYDs6l4REnIqACM/xa6xGNqYaGQ8GNilws2Q?=
 =?us-ascii?Q?+JZOU1ZT/pmZO3EdD76JBEv3WP089ZbKUt4ZLOVGjbEgIbGX3uEq4xSpechu?=
 =?us-ascii?Q?2j/QyR9hDOhZUmACXLpWD6hPJBlVTKmUGQz02v8nCp9Liq4hv6K4ly6xp5Qk?=
 =?us-ascii?Q?n8lRVudLrkarQ+JXsvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684de111-1fe0-4e9f-431a-08dc523d081d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 11:15:26.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw1TugzAuzF6lTfm/5mnjsTxYVp5O79rquGav2+RaySGtEsLJgwqmlXilm7qCvLIEL4zQPtIiaetVp6oBylfxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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

[AMD Official Use Only - General]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, March 28, 2024 8:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH v2 2/4] drm/amd/pm: Add PMFW message and capability flags

Add flags to categorize messages and PMFW capabilities.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 3 ++-  drivers/gpu/drm/amd=
/pm/swsmu/inc/smu_types.h  | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/dr=
m/amd/pm/swsmu/inc/amdgpu_smu.h
index a870bdd49a4e..aa835df7ba1a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -458,7 +458,7 @@ struct smu_umd_pstate_table {  struct cmn2asic_msg_mapp=
ing {
        int     valid_mapping;
        int     map_to;
-       int     valid_in_vf;
+       uint32_t flags;
 };

[Kamal, Asad] Do we need to change the following macro , to have flags rath=
er than valid_in_vf
#define MSG_MAP(msg, index, valid_in_vf) \
        [SMU_MSG_##msg] =3D {1, (index), (valid_in_vf)}

Thanks & Regards
Asad

 struct cmn2asic_mapping {
@@ -538,6 +538,7 @@ struct smu_context {
        uint32_t smc_driver_if_version;
        uint32_t smc_fw_if_version;
        uint32_t smc_fw_version;
+       uint32_t smc_fw_caps;

        bool uploading_custom_pp_table;
        bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_types.h
index af427cc7dbb8..c48214e3dc8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -445,4 +445,11 @@ enum smu_feature_mask {
        SMU_FEATURE_COUNT,
 };

+/* Message category flags */
+#define SMU_MSG_VF_FLAG                        (1U << 0)
+#define SMU_MSG_RAS_PRI                        (1U << 1)
+
+/* Firmware capability flags */
+#define SMU_FW_CAP_RAS_PRI             (1U << 0)
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index b8dbd4e25348..3227e514e8ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -437,7 +437,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *=
smu,
                        return -EINVAL;

                if (amdgpu_sriov_vf(smu->adev) &&
-                   !msg_mapping.valid_in_vf)
+                   !(msg_mapping.flags & SMU_MSG_VF_FLAG))
                        return -EACCES;

                return msg_mapping.map_to;
--
2.25.1

