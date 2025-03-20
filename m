Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667CFC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 07:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD3D10E596;
	Thu, 20 Mar 2025 07:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ryzZ6Go";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D393010E596
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 07:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDr6yHxyHRdT+9h7Wu7wJbkNhuzkDsqQhfYQeRA02qT/Zt5YCdzltQ9fxVoe5U3MJtuSB00FgvATQSvfibOdupaweDEy8kp7dRW4tNa9plDBVX2+Hq5MfNhwra20d0GrgDAEwlO+rYRwKrb8wNcQ+y/FuZ0H73IDbY6J6A62o0rppENMmm9BD6BNFotwSL5VHqomXSrlUism96WPzK57yJ/X60C8zpf1vZLqV6ZgFQzrLyd0QG9nGp3g1Sm7nVhQwzSA0K4HLF2mw1LIF3fAVugGmQtpncP9O31lwRL0hQ6Oyj0A1BfKWBvfC8TxQTdRnkwINweVBXsaOXSPTknDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aK6QBwgFEtfMli7gxOtpb1lEsWnURHSKXJVtYWF87CU=;
 b=Qf2r5erGokvUZ9PP3AzuEiHP9+OJL2cGeWGNy7czUyVF0N8RsvnSYROPYpk1EAkol+doNqiw4UWw3L446oQdMMTdMRJ8+ZUA4Va0+THD2x+72YBbbdjfLNyDLJ1DlceG2MJ3G+UBOrkw5bUS/rCl2tk5/EloIG/7yeh0TqkQlWEuLctsa4cwllboxlYccIsWOrHh0/C7CBGScQx5qRAZHEotQLBo8CSuUoPQu+nvRhBVZoa+yZoIzcTaIuOk/dTvCyw+wauwm8s8xRQH+1dB093XbQP2fxO3jJlgvUgMh7YiHWVqXwn7pXxjIqjSb+Twv+cGlet09Yzu0ksnNoN2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aK6QBwgFEtfMli7gxOtpb1lEsWnURHSKXJVtYWF87CU=;
 b=3ryzZ6GoV4ucM+tZqgYErZaQ07tko84HlJPnrZIYUggiTStxYjFlWfvu0YDAZfPeuH5XNPTAQt/tEsmHAw9tpGE5oP16TWz18Qt67rPBIttbazGxD0O3ibaRI2Zc0Y9ndBobZ4bClo31SknuTw7/nYPkxdN+mgVwtXIYNSXd86M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 07:05:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 07:05:53 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Topic: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank
 parser
Thread-Index: AQHbmV9oo8UKlkZq6EqtmlgStXoDS7N7mVaQ
Date: Thu, 20 Mar 2025 07:05:53 +0000
Message-ID: <PH7PR12MB59979C5722583FE5846BB87082D82@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250320061437.572914-1-xiang.liu@amd.com>
In-Reply-To: <20250320061437.572914-1-xiang.liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ba4a500f-5bb2-4f8b-b724-98da2460872e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T07:02:27Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA5PPFE91247D15:EE_
x-ms-office365-filtering-correlation-id: 609eefb6-7270-4908-a443-08dd677da753
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QpnnBh1q1YY0rYpc2pFJPmR4C8w1xlY5cZvBctD15Vk+B9gjU5+AyrfcUtEV?=
 =?us-ascii?Q?rcaUNBCvX6oL5ygDNX7gdqVMtlVJI04JYx0lvpgioNFLMWonUZdLD9hueDMA?=
 =?us-ascii?Q?iTs533HwhP2diOmO/Zpjl04R3OjPqSvLRfyH+Tml57oYMvtn9KD86OHi5sNm?=
 =?us-ascii?Q?DwdZ7LamGQiEiJ6IhD25DkxVEiqivWlpuN5DOaNIeugptT+keXoAJEUqrHDB?=
 =?us-ascii?Q?SoiNwFDzoPtrvHn8Mam94Ze4hKXrzjwzYoi/hyvnG4bW4dSBbvrG97wGmB/1?=
 =?us-ascii?Q?9pd4ooss4kg1w7ZVcIDYCcwxJC54txhpAyDO9YWbVValSZLE9jZGlmsojvJL?=
 =?us-ascii?Q?5Mn7GqNXqOPw59jwydwJmfjRaJoLNu9CHGpChMvgZ2NZLG8j78fYKnknXloi?=
 =?us-ascii?Q?yIHphbv5jZp0yJ+lAgnAIfvUz8bIQJI9I6RWu9BmrkyjcTP2NaddLeIYAB2N?=
 =?us-ascii?Q?u3hxtUN7KOtREzUjn4vFSGocRMGXVF0JbjclKUN7zOhjiiBJBDm6XET0QrSt?=
 =?us-ascii?Q?eQ6K4X8rhwkHvFcyfoo1DvsLJEssBbQqxVINR9dGIz/y2JnD8Coa4RP1L8AA?=
 =?us-ascii?Q?PK520fDnAfr9EvGDvPTzy5HuJi+43vl+qHMNbQvY2gaboBl6xceHDNTNoSLW?=
 =?us-ascii?Q?0FZTP3E+Pg/OiQLa86HX1D8hTX5HV403742ntcLq3QYSiPaK1R9wnt3cLy3o?=
 =?us-ascii?Q?LvLht8tiF4ENzfg/xm/8VsrD//npSoXRJms6XNzt1SRwkwinpLHbEx9f4eaa?=
 =?us-ascii?Q?huGcRrCamirPN0ur4lruf8qrmpUPhPvYHeLDAKJIQxUzFZcA2E1me5V1OSOf?=
 =?us-ascii?Q?aMPXJuj9ZBHM7feCvlQPOAZ3bSmguSgqVSZHC5+uDDYYwLzqD9GF+m7dBaBH?=
 =?us-ascii?Q?sp97K3hTGpBcsQlRbJo7DLzXCvn5FjoD4Uo0+29KuzOeCRnsudwunlyenl8N?=
 =?us-ascii?Q?AVQlIjMF+MGAjTajJrdFgdiSQVPxZgOOB4WpcY1rnp9RLJccpeJppHs8QB7z?=
 =?us-ascii?Q?J9i2VIqrB7+3aVDv4vFsppyJOjxv/b2lCURwecAPEcEdryqUn/HRONaaiCaF?=
 =?us-ascii?Q?2g2BXeQqS1SPNInhm8hiBqDx0TTLoSht0+r3mUdihwjfWTAQur5ImdY/GNf5?=
 =?us-ascii?Q?0l7gbqIGtpTlaotJSON5pd056h319gQJ9CYSJ8vD8kICYeZwL82ypYPj+UNL?=
 =?us-ascii?Q?j01F0YnEUb1ePNT6NVPTc2ek4d81JiVTDu5wwe0sq+iy9MZTt/2igNe/XEL8?=
 =?us-ascii?Q?/hgpdTX7X8WI/pgx63sJhRdVkGeC98yt5IdSba09n35OVMYuvujGe87kcsCk?=
 =?us-ascii?Q?gy7AyKH5MfPe/YaXzvMS6BYRd1s0nu2WvqIvixIyaXGv8Tw+MGkjShZ5JMew?=
 =?us-ascii?Q?FE95+bCIutknSoiV1CbnQx3g0GA/jHC8zALlrw5L1/H0m5aOWjM2mmrbnzyH?=
 =?us-ascii?Q?qKKO15Rzwr26Bj7P4K0OY7u3CsS1wrRW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qexNXMPstvBeTYMH02VR9HuOJhjomdw++gyd+h9sy6SZ4whSplEGse2i2gXl?=
 =?us-ascii?Q?F4UgoBWm8eAVBimqxUQKW2+44cJRzBx4O8tlTScAwolhb28YENTpbbrMXeOY?=
 =?us-ascii?Q?OBkuet3dM6dY5cUN6SbhPDLo7pX6u9045OGomVzfx6o8TrpMODmpSpbpV4PR?=
 =?us-ascii?Q?tOXIy5wHzL/I0ZRP3mjcQ9HAdpms58Kg9yrlfFVwjmIhCglmyGvZlXJpKl1e?=
 =?us-ascii?Q?aWpsgdTh2sLhpOPuR+7z+BMU+4N0oUf/Uro49s6n/pUffOqSUySjYrImyvyj?=
 =?us-ascii?Q?HDB+HyzZH2dx6ZJZ15BzQq/nw1SrZB+2NwLCg/leqS2neWbAhgz8m+5rpzqg?=
 =?us-ascii?Q?Fg5z/KOb+bSZTcMG7rc/R9S/cWxVy9oJEQnt5dmpzfyIi4jPXEUsyIFbp6rn?=
 =?us-ascii?Q?bqmW3l5febkZyDfYeqqEWn25VgbBnG/12vEqio0JkY1GfdkU93oiplUqZq6i?=
 =?us-ascii?Q?Yj72Eq0AQMhK246ZoOavaH+LCZI2QvDq21sf+YEDLhE2N0Ky8ZJir3qPfm6q?=
 =?us-ascii?Q?0ou0w0Sz0Ph/TzqBGoJaklc7r85ePMUXniUw5VAz+abLiYjiMKt/IcthWGy4?=
 =?us-ascii?Q?6keZGZSLFgHmT+Sc4IgcYz8VUoislNdC1MvwVPNkoWJK4iH9rPYwKHl0na8m?=
 =?us-ascii?Q?XWIsdRmfm9cpZ1RrWwAIPxiuOlZCbeI+RkVJLC5hHZxJzx2/iMaZHudLxj6l?=
 =?us-ascii?Q?kkdaFJDgCmFWTBt9DFoPUhYB91qm5WAf3TYW3sY92+tk+oAsOAxVHsJug4UB?=
 =?us-ascii?Q?kzw6tPMvcApqb9tTC8R38QIRgY9TspJ8GpPWfey23RKeyIaXdjuKeTaWZA76?=
 =?us-ascii?Q?ydnzJBO06m5Gb7dCWvBSzNOaVrHGAKNqc2gT56FltLxfiT2RdRu6dNP2j3bf?=
 =?us-ascii?Q?ZYwss8LO6zJljRgcmTBLfpUS5z2eu6jPFCatA6KB0rPfbQeL+VvnWd6GA21A?=
 =?us-ascii?Q?aAPc5Q7L8srBRazyF0vY8rfhLbzvuUZIXBOTdpf40p2iiAStxmTZ3TOsRrnA?=
 =?us-ascii?Q?k6An+B3tvyPZS5WxVg/GqEiXwejrnCIwv/QOGReId+K1at6kJ7x4MpDxhMK2?=
 =?us-ascii?Q?/+fhgFp9ZZJGwrx8xxiL7aQq7jb+08kC/eQxGRzzm/Pz66LfkOPOznfo/lHj?=
 =?us-ascii?Q?9iRi+flOxDuL1l6kRZCE/U+7eJ2VNx3cDhccWAlaSlLVzyiRbkhxK6+Ib4Ou?=
 =?us-ascii?Q?f8WO1QaakI1Ob37Hu+VY3y7YpJDmZbiVnJzssSDCPTxjkvW9ZaRiyUtZUmAb?=
 =?us-ascii?Q?AF0Lgs+ktYpqWl2tR1M99n8LhEjGeJiB44m1j/a7ZajYtxugEWmApGn/YvL+?=
 =?us-ascii?Q?n+bWgtfu8TTPeJ45rroxwkEgjlt4x/9mTDyfQ8IlDqCX4aC5iAIFOO1yg/kc?=
 =?us-ascii?Q?tJZpZiEj82TnA2c+OKCJIxVDeGcYKs+lhcoN3pogRf7Gl5TrELnryQUiazSw?=
 =?us-ascii?Q?ENXwg6e7kynF30nAbgekALz8ZxDRpo12GIqY2YAiBAOMlVggw+kSlZ7ljU51?=
 =?us-ascii?Q?I/xkpwUoKI+Khvl8Pf8CwMiTTuKFF3YO0Pt/7AOZZ6fj1dkXgI7EtZd/T+CC?=
 =?us-ascii?Q?rYVk+Qr3tyOinSP4TcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609eefb6-7270-4908-a443-08dd677da753
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 07:05:53.2106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Stepn2OAi4LD41AyiPbcrGHhabwFUB1enCpt/WVDshQctxddsqGhV6Gf7Rqi1K/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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

+       if (type =3D=3D ACA_ERROR_TYPE_UE)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

It seems that the above code is incorrect, which may lead to error statisti=
cs of different types of errors.
In the aca parser interface, I think there is enough information to identif=
y the types of errors and correctly count errors,
Please double check it, thanks.

Best Regards,
Kevin

-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, March 20, 2025 14:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.=
com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank par=
ser

In the case of injecting uncorrected error with background workload, the de=
ferred error among uncorrected errors need to be specified by checking the =
deferred and poison bits of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  3 +++  drivers/gpu/drm/amd/amdg=
pu/gfx_v9_4_3.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_aca.c
index ffd4c64e123c..3f45a600f547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *a=
dev, struct aca_handle *h
        if (ret)
                return ret;

+       if (type =3D=3D ACA_ERROR_TYPE_UE)
+               aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data=
);
+
        return aca_log_aca_error(handle, type, err_data);  }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index c0de682b7774..b21d784a7f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle=
 *handle,
                                      void *data)
 {
        struct aca_bank_info info;
-       u64 misc0;
+       u64 misc0, status;
        u32 instlo;
        int ret;

@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_hand=
le *handle,
        info.die_id =3D instlo =3D=3D mmSMNAID_XCD0_MCA_SMU ? 0 : 1;

        misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+       status =3D bank->regs[ACA_REG_IDX_STATUS];

        switch (type) {
        case ACA_SMU_TYPE_UE:
-               bank->aca_err_type =3D ACA_ERROR_TYPE_UE;
-               ret =3D aca_error_cache_log_bank_error(handle, &info,
-                                                    ACA_ERROR_TYPE_UE, 1UL=
L);
+               bank->aca_err_type =3D (ACA_REG__STATUS__POISON(status) ||
+                                     ACA_REG__STATUS__DEFERRED(status)) ?
+                                               ACA_ERROR_TYPE_DEFERRED :
+                                               ACA_ERROR_TYPE_UE;
+               ret =3D aca_error_cache_log_bank_error(handle, &info,
+bank->aca_err_type, 1ULL);
                break;
        case ACA_SMU_TYPE_CE:
                bank->aca_err_type =3D ACA_BANK_ERR_CE_DE_DECODE(bank);
--
2.34.1

