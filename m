Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8F9C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 06:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFC510E6A3;
	Fri, 10 Nov 2023 06:49:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9CF10E6A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 06:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWfcUKPE6dSAm+X/i7H/H5e6iTghamipI8tuqGmDMCbRBxzeL3re+5Az76gn5lOxTneHm9+Eiam+KI6iuZP+rYJqt0NSvqdXdbDo9qJr+JF2rZ2FghBU5XYsQ+Y48NYwCuX7aCElf6cRah1pC+WE7GaHzgujg3ELZMzHZu2HsgzflWKwvPC2R5DFzoRpwXnHsX49GQS2joLVnYYi2fO+UUt8JQIQ9pHGrL0lnQZceki/m8kRnJKPma4jW8iowOEUclDyHn8uK6jD2zJKVeAdQr2MZrF5TQl2yKI9B7SxvBnsf1tHD8n12egGoXNTOrfJD5hrF30XRw6TwLuaSHgy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CYigvUgA3/VmFPKogL1cUw9ECTGfsnLFyxVG4KXumc=;
 b=YdW6Hx7uBgM1uQ+3Oz4nD1Qy96ToVSH8Hh68BqmJTztdJnJLlGVEUyF8V9oVSCH9hSEohzRw+0nQHOODUeXzhJs9WCqYBNqac7KUgzJaD7rUxVRl05B9ECgcTaywErjy3MVEkP7hkN7hKz4GYgPohkMA83SdZhFB+0XgRbOa+gG0Mjk6zk8rV2EP2joKwVlo3aRqHw30xHFJB9ezyRpzu77UqcjgmiAgGGXqVj0FynR2IWjXqJa/9RdaWr53mMcpBIuzEdGjY7b42j1RGsTtasaZHFnZTEOmk6lyJoOmaD3WRCeKQJlnTR5NySQ00UUwIarztFWoKOCbyRiezX6qGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CYigvUgA3/VmFPKogL1cUw9ECTGfsnLFyxVG4KXumc=;
 b=GcZ5xtHNqvDxpl54Fi4VPwiqXYGdhRjf5oSmt2Xvog8XMHqdcgwxyrgRjV7AIIyTcKUu6ilVCRe06YQuR0RZAbRkgSxMXwBdhoDcEX6dUbn7f2mHFpicHTDhuyGQUVp3eOdR+8qHT/aoB4BH7MSx4TLouFJlNVNsTBRNS9i73S4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 06:49:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 06:49:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct mca ipid die/socket/addr decode
Thread-Topic: [PATCH] drm/amdgpu: correct mca ipid die/socket/addr decode
Thread-Index: AQHaE5/Mu/C9VZhPykSGKIw+7jVAnLBzHNLg
Date: Fri, 10 Nov 2023 06:49:49 +0000
Message-ID: <BN9PR12MB525738718E6958485F8D852FFCAEA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231110063239.3889891-1-kevinyang.wang@amd.com>
In-Reply-To: <20231110063239.3889891-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6cb4c464-126d-48cb-b2a9-7bef021098b2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T06:49:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN9PR12MB5227:EE_
x-ms-office365-filtering-correlation-id: f421b15c-f638-4c26-db9f-08dbe1b93c54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZR7SEB4Jueis2pcRMo+o/mKbiOegbUSdaKnt+21s0FvBsbGYSV+zYEz+DJE3Ay+dnsdULlpsT3EAcxOdKZ14ZHAi099+d6JZiSgem5ZqvA/iuK+MMAevm8rGHMZqGYqkQj5hUVzV5o2uHFdpEFL8TCuJ1XvEWbLEBPa9+eVjhhm1v++Wmp6+EMxYwbdP6rsr6TlJF2wEm+RvdMkbLCOwixuRde614l+Y3QEXbtUPQGLcM/hTQKlCakbGpjw3/zMUnbGOig8urypf7i2/BzqN5+apTMUx+/HKfeAM3gRXWhNxr5ep4NhEPfRSgd2IdyVpf4hRXgiYfhHJJPp6AM185hVDVv5lseiz5FLg1EBSJg/D7GesyyMtGalRR7ifEHOmXtsOa1qc2WzFW/b6Bkn5Z6S0kdzGzABD9SpI6vclsi0PBHaxX3y9xRZYVL+DG6ljWsClNxQpNhFjLg0j1v/Qj8V59A1732nAOvM5WUOXc3MdKsIaM60SAtr4kkVQOOOxxyT0TvFzk94ZwlAVA+J+dGT8sQabUd5X63fMkGxo+AaL1JIvcFSKw4p1UZJp3JzwmLACGQFx2PNZuyS98cwf4ybFdsjYVdtrMruoWpMpr3dPunafJGggdne7dQC2n9ww
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38070700009)(55016003)(122000001)(9686003)(66446008)(66946007)(53546011)(76116006)(64756008)(110136005)(66476007)(33656002)(86362001)(7696005)(6506007)(478600001)(71200400001)(38100700002)(26005)(83380400001)(316002)(5660300002)(41300700001)(2906002)(66556008)(8676002)(8936002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nk3wv5hPXk+by6Hw5qxS64OU06hrvE9r7sD8DdOfOiH2mHvhivfvmFyfgD7C?=
 =?us-ascii?Q?m5PxCUguK9bMtGsU+dfOskcMbRrRABswhNo8XpSg8EjFiN27mKRY3NCM1CUw?=
 =?us-ascii?Q?xjlJxoetnmH5nvTZC6kRP6k7H8wZUQabr0eo7B3M6e8SInzzv2dyGmGloe6J?=
 =?us-ascii?Q?LF4P5youyYqK+qK8XwbD1xrc7z/JJqy/jkjxUiJFOnip9IMH3TDexWgTOQrF?=
 =?us-ascii?Q?UmRBXf6WzIEW15GhxEzojLzQC+wdBYdx3zrOfgwkuppuhT/cwVRvsPS7e7ic?=
 =?us-ascii?Q?hbG80bVbRpNXQvPFyMIiFYOw7zFImWmXTQ6nemu49ix5EahZHjn1mlHC4O/v?=
 =?us-ascii?Q?Un1UQXzSn0yc0xyJ+3QOGdhPsHI1t8uL2HW91q5i8LLKTSNeBjRLBlo+XsII?=
 =?us-ascii?Q?rGPHB56pbkY2uRblpgirkAt8ap9PkGoWAVIAjDu8lpw4deGzCMGUcD2PWB8/?=
 =?us-ascii?Q?iISbEH91I/+PvoswdYPKclwwn3B+qeJWDZmw2sijjWyDUmL9Cq2+G0izFrtn?=
 =?us-ascii?Q?7vZrS6C+ASG3O51XE1MT8B1i5CupRJO3hZsq2am1ULfUhunHH9N7DUy3GlWp?=
 =?us-ascii?Q?vojRLoeKP8AmMJUrdeYd2nJnHW/JnQwhAQshcWpv7RvxKYTRApbYUv3wlwz4?=
 =?us-ascii?Q?X2EpP3hF2DaGaKMI9fm+lod9hQNgp1nBL90lmRigXvIv7Pw1cRVjtXya0azu?=
 =?us-ascii?Q?NPdztUXsyU1fvUaXazDz0X3gYSi5YGwY53gVAg3BwdZJ3XL4TWRrnDO13KpI?=
 =?us-ascii?Q?j7LZ1ZFjdNXTJY064ZCLoYLwsR4fN6wt8wubOtIDhGkE3IS+ANdYEjjW+dfl?=
 =?us-ascii?Q?qKvmKRXVrV/QiQUzAOkV5hTN9SmoKNC/VUyzwW/TXNZMdXbeo93cWxlTTaqE?=
 =?us-ascii?Q?0h+Y3Se3/WBoyoy+edtSwIGd3Q9q+M0TMNyqzWbDUCwmRg39tKJT8qlhKPnq?=
 =?us-ascii?Q?WsCamUuW2vxjv5dn4oO4/kk+xNaofx/Q8KXENjI58toyEkBbr2ZJGOTsuY/T?=
 =?us-ascii?Q?Juz1HFfBmlxBVgH88IgSrgOvvrOuBOdSuY/Zs3PHmVUXS3XvAV0A2x7zZmiN?=
 =?us-ascii?Q?0pIWdjI+S0qa4jLYhG1arbPv8dTgxiyB5Rt08d2dyHOAHtOpw4q6m0LMzVvH?=
 =?us-ascii?Q?O8PP8U3g3PVCKbTRgPe9IIx6H7g34wBp8jeQnh4EX06m70vpA5naUM4Mx6yP?=
 =?us-ascii?Q?hQHJ0yx9Ux7vB7b5AB8/HIgiiVRn8pReyjc5Nwi8t8wrv2/uy0xpv12Oc00R?=
 =?us-ascii?Q?MpjeSl14if1NUHtxG1lV2ILJwaZeRMkOVTctVmkIuUQU7zvUqeFWLvGmxyfv?=
 =?us-ascii?Q?CVKjJpetdPbix0GWpLJg5cbdBB7OfUJQ1/s3nFF1S1CRv1NYubaHMme9X5kI?=
 =?us-ascii?Q?QWqsKgvwhILeNQFPueDIaw69BfoHv22OPYZxNFO3OFD8Qhj2kn/Ur45g8QmU?=
 =?us-ascii?Q?Rr5vLWRLtTpnwYYMdhKggdP4GNDFf6YqYMELcxyQWTr3beIXfRAnGSop1TwC?=
 =?us-ascii?Q?PUtsejsvmGJlAY0farpHmGp4nf3sUbnpTPczh4cKNtKFLb28X7qV2d5QaJE2?=
 =?us-ascii?Q?d5zGTXiDA2ZeNoThsMD3cK0ncf7F9DzExKL3k0Pd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f421b15c-f638-4c26-db9f-08dbe1b93c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 06:49:50.0096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs8Uz0OfIIaeMLxuwELNaDVv/02Kqwslh8fWoq9CDURE+rqPPzLy+X5dXHLpiG8J77fSj4+SoeuaJr561Wn6nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, November 10, 2023 14:33
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: correct mca ipid die/socket/addr decode

correct mca ipid die/socket/addr decode

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 789552c66d1d..3f71490b779c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2381,8 +2381,8 @@ static const struct mca_bank_ipid smu_v13_0_6_mca_ipi=
d_table[AMDGPU_MCA_IP_COUNT

 static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, struc=
t mca_bank_info *info)  {
-       uint64_t ipid =3D entry->regs[MCA_REG_IDX_IPID];
-       uint32_t insthi;
+       u64 ipid =3D entry->regs[MCA_REG_IDX_IPID];
+       u32 instidhi, instid;

        /* NOTE: All MCA IPID register share the same format,
         * so the driver can share the MCMP1 register header file.
@@ -2391,9 +2391,14 @@ static void mca_bank_entry_info_decode(struct mca_ba=
nk_entry *entry, struct mca_
        info->hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        info->mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);

-       insthi =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
-       info->aid =3D ((insthi >> 2) & 0x03);
-       info->socket_id =3D insthi & 0x03;
+       /* Unfied DieID Format: SAASS. A:AID, S:Socket.
+        * Unfied DieID[4] =3D InstanceId[0]
+        * Unfied DieID[0:3] =3D InstanceIdHi[0:3]
+        * */
+       instidhi =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
+       instid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo);
+       info->aid =3D ((instidhi >> 2) & 0x03);
+       info->socket_id =3D ((instid & 0x1) << 4) | (instidhi & 0x03);
 }

 static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_e=
rror_type type, @@ -2567,6 +2572,7 @@ static bool mca_gfx_smu_bank_is_valid=
(const struct mca_ras_info *mca_ras, struct
        uint32_t instlo;

        instlo =3D REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT=
0, InstanceIdLo);
+       instlo &=3D GENMASK(31, 1);
        switch (instlo) {
        case 0x36430400: /* SMNAID XCD 0 */
        case 0x38430400: /* SMNAID XCD 1 */
@@ -2585,6 +2591,7 @@ static bool mca_smu_bank_is_valid(const struct mca_ra=
s_info *mca_ras, struct amd
        uint32_t errcode, instlo;

        instlo =3D REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT=
0, InstanceIdLo);
+       instlo &=3D GENMASK(31, 1);
        if (instlo !=3D 0x03b30400)
                return false;

--
2.34.1

